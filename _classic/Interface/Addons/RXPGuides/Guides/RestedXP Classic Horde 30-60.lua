RXPGuides.RegisterGuide([[
#version 8
#defaultfor Horde Mage
#group RestedXP Horde Mage AoE
#version 8
#classic
<< Horde Mage
#name 21-30 Silverpine/Hillsbrad AoE
#next 30-36 Arathi/Alterac AoE
step
.goto Orgrimmar,38.69,85.38
.trainer >> Go Upstairs. Train Portal: Orgrimmar
step
#level 22
.goto Orgrimmar,38.34,85.56
.trainer >> Train your class spells
>>Respec to Frost Mage AoE spec if you haven't already
>>Make sure you have at least 30 silver left over
step
#completewith next
>>Run out of Orgrimmar
.goto Orgrimmar,49.10,94.82,100,0
.goto Durotar,50.82,13.86
+Wait for the Zeppelin to Arrive, get on it when it comes
step
.zone Tirisfal Glades >> Travel to Tirisfal
step
.goto Tirisfal Glades,61.87,65.02,40,0
.goto Tirisfal Glades,61.81,74.42,40 >> Run to Undercity, then run to the Elevator room. Take one of the lifts down to the main part of Undercity
step
#completewith next
+Bank items if you need to
step << Undead Mage
.goto Undercity,62.01,42.73
>>Talk to |cRXP_FRIENDLY_Raleigh Andrean|r
.turnin 441 >>Turn in Raleigh and the Undercity
.target Raleigh Andrean
.accept 530 >>Accept A Husband's Revenge
step << !Undead Mage
.goto Undercity,63.27,48.60
.fp Undercity >> Get the Undercity flight path
step
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy a Rune of Teleportation
.collect 17031,1 
step
.goto Undercity,84.20,15.55
.trainer >> Train the Undercity Portal
>>If you don't have enough money, vendor some things to the reagent vendor below
step << Undead Mage
.goto Undercity,63.27,48.60
.fly Silverpine >> Fly to Silverpine Forest
step << !Undead Mage
#sticky
#completewith next
.goto Undercity,82.36,15.31
+Go to the Reagent Vendor on your right and perform a Logout Skip by positioning your character on the highest part of the lowest staircase until it looks like they're floating, then logging out and back in.
.link https://www.youtube.com/watch?v=-Bi95bCN8dM >> CLICK HERE for an example
>>If you can't do this, just run out of Undercity normally
step << !Undead Mage
.goto Tirisfal Glades,61.85,66.59,60 >> Exit Undercity
step << !Undead Mage
.goto Silverpine Forest,67.42,5.91
.zone Silverpine Forest >> Follow the road west to Silverpine Forest
step << Mage
#completewith next
.money <0.1400
.goto Silverpine Forest,44.80,39.24
.vendor >> Talk to Andrea and check for a Wise Man's Belt. Buy it if its up (and if you need it)
step
>>Travel to The Sepulcher << !Undead Mage
.goto Silverpine Forest,42.80,40.87
.target Apothecary Renferrel
>>Talk to |cRXP_FRIENDLY_Apothecary Renferrel|r
.accept 493 >>Accept Journey to Hillsbrad Foothills
step
.goto Silverpine Forest,42.91,42.00
.target Mura Runetotem
>>Talk to |cRXP_FRIENDLY_Mura Runetotem|r
.turnin 3301 >>Turn in Mura Runetotem
step
.goto Silverpine Forest,44.18,42.67
.turnin 264 >>Turn in Until Death Do Us Part
step << Undead Mage
#sticky
#label Valdred
.goto Silverpine Forest,44.63,84.69
.complete 530,1 
>>Kill Valdred Moray (He is AoE-able). Loot him for his hands
step
#completewith next
.goto Silverpine Forest,46.50,86.49,0
+It is HIGHLY recommended you watch the link, as it can be a bit tricky here
.link https://www.twitch.tv/videos/970326213?t=03h49m43s >>CLICK HERE
>>You can also vendor/repair/buy potions at Wallace the Blind next to the gates if needed
step << Undead Mage
#requires Valdred
step
.goto Silverpine Forest,46.10,85.75
.xp 22 >> Run south to The Greymane Wall. AoE here until 22
step
>>Run East into Hillsbrad
.goto Silverpine Forest,72.58,81.35
.target Deathstalker Lesh
>>Talk to |cRXP_FRIENDLY_Deathstalker Lesh|r
.accept 494 >>Accept Time To Strike
step
>>Run to Tarren Mill
.goto Hillsbrad Foothills,62.37,20.58
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 494 >>Turn in Time To Strike
.target High Executor Darthalia
.accept 527 >>Accept Battle of Hillsbrad
step << skip
#som
.goto Hillsbrad Foothills,62.62,20.73
.accept 549 >>Accept WANTED: Syndicate Personnel

step << skip
#som
.goto Hillsbrad Foothills,63.24,20.65
.target Krusk
>>Talk to |cRXP_FRIENDLY_Krusk|r
.accept 498 >>Accept The Rescue
step
>>Click the Wanted Poster outside the Inn
.goto Hillsbrad Foothills,62.55,19.69
.accept 567 >>Accept Dangerous!
step
.goto Hillsbrad Foothills,62.77,19.02
.home >> Set your Hearth to Tarren Mill
step
.goto Hillsbrad Foothills,61.44,19.05
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 493 >>Turn in Journey to Hillsbrad Foothills
.turnin 1065 >>Turn in Journey to Tarren Mill

.target Apothecary Lydon
.accept 501 >>Accept Elixir of Pain
step
.goto Hillsbrad Foothills,60.14,18.62
.fp Hillsbrad >> Get the Tarren Mill Flight Path
step << skip
#sticky
#completewith Hillsbrad1
>>AoE Bears. Loot them for their Tongues
.complete 496,1 
step << skip
#sticky
#completewith Hillsbrad1
>>Kill Spiders. Loot them for their Ichor
.complete 496,2 
step
#sticky
#completewith Hillsbrad1
>>AoE Lions. Loot them for their Blood
.complete 501,1 
step
#label Hillsbrad1
.goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
step
#sticky
#completewith next
+It is HIGHLY recommended you watch the link, as it can be a bit tricky here
.link https://www.twitch.tv/videos/970326213?t=04h32m58s >>CLICK HERE
step
#sticky
#completewith l24
>>Kill Citizen Wilkes. He patrols around the fields
.complete 567,2 
step
#sticky
#completewith next
.goto Hillsbrad Foothills,35.16,39.06
>>AoE the Hillsbrad Mobs in the area. Keep an eye out for Farmer Rey and Getz
.complete 527,1 
.complete 527,2 
.complete 527,3 
.complete 527,4 
step
#label l24
.xp 24 >> AoE the middle and northern fields (with Farmers and Farmhands) to 24
>>Start saving the Wool Cloth you get. You need 12 stacks for later
step
#sticky
#label Getz
>>Kill Farmer Getz, he can be in the House, Barn, or Field
.goto Hillsbrad Foothills,36.7,39.4,60,0
.goto Hillsbrad Foothills,35.2,37.6,45,0
.goto Hillsbrad Foothills,35.1,41.0,60,0
.complete 527,4 
step
>>Kill Farmer Ray. He can be in the 1st or 2nd floor of the house. He can also be outside under the grapevine (hut)
.goto Hillsbrad Foothills,33.7,35.5,20,0
.goto Hillsbrad Foothills,33.2,34.8,20,0
.goto Hillsbrad Foothills,33.7,35.5,20,0
.goto Hillsbrad Foothills,33.2,34.8,20,0
.goto Hillsbrad Foothills,33.7,35.5,20,0
.goto Hillsbrad Foothills,33.2,34.8,20,0
.goto Hillsbrad Foothills,33.7,35.5,20,0
.goto Hillsbrad Foothills,33.2,34.8,20,0
.goto Hillsbrad Foothills,33.7,35.5,20,0
.goto Hillsbrad Foothills,33.2,34.8,20,0
.goto Hillsbrad Foothills,33.2,34.8
.complete 527,3 
step
>>AoE the Hillsbrad Mobs in the area. Keep an eye out for Farmer Rey and Getz
.complete 527,1 
.complete 527,2 
step
>>Kill Citizen Wilkes. He patrols around the fields
.complete 567,2 
step
#requires Getz
.zone Undercity >> Teleport to Undercity
step
.goto Undercity,85.14,10.03
.trainer >> Train your class spells
>>Make sure you have at least 10s leftover
step
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy a Rune of Teleportation
.collect 17031,1 
step
.goto Undercity,57.30,32.76
.trainer >> Train 1h Swords, Daggers
step << Undead Mage
.goto Undercity,62.01,42.72
.target Raleigh Andrean
>>Talk to |cRXP_FRIENDLY_Raleigh Andrean|r
.turnin 530 >>Turn in A Husband's Revenge
step
#completewith next
.goto Undercity,65.97,44.73
+Bank your Wool Cloth here from earlier. You need 12 stacks (240) for later
step
.hs >> Hearth to Tarren Mill
.vendor >> Buy level 25 drink from the Innkeeper once you hearthed
step
#hardcore
#completewith next
.goto Hillsbrad Foothills,62.56,19.91
.vendor >> Buy 8-10 slot bags from Kayren if needed
step
.goto Hillsbrad Foothills,62.34,20.44
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 527 >>Turn in Battle of Hillsbrad
.target High Executor Darthalia
.accept 528 >>Accept Battle of Hillsbrad
step
.goto Hillsbrad Foothills,62.13,19.57
.target Deathguard Samsa
>>Talk to |cRXP_FRIENDLY_Deathguard Samsa|r
.accept 546 >>Accept Souvenirs of Death
step
.isQuestComplete 501
.goto Hillsbrad Foothills,61.44,19.06
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 501 >>Turn in Elixir of Pain
.target Apothecary Lydon
.accept 502 >>Accept Elixir of Pain
step
.goto Hillsbrad Foothills,39.10,38.68
>>AoE Lions en route to the fields. Loot them for their Blood
.complete 501,1 
step
.goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
+It is HIGHLY recommended you watch the link for the new field pulls you have to do, as it can be a bit tricky here
.link https://www.twitch.tv/videos/970328906?t=00h50m19s >> CLICK HERE
step
.isOnQuest 502
>>Turn in the Elixir at Stanley. Kill him afterwards
.goto Hillsbrad Foothills,32.66,35.32
.target Stanley
>>Talk to |cRXP_FRIENDLY_Stanley|r
.turnin 502 >>Turn in Elixir of Pain
step
#sticky
#label Kalaba
>>Kill Farmer Kalaba. She patrols around the southern field
.complete 567,4 
step
#sticky
#completewith next
.goto Hillsbrad Foothills,35.29,46.83,0
>>AoE the Peasants in the southern field
.complete 528,1 
step
.xp 25 >> AoE all of the fields to 25
step
>>Keep grinding until you've looted 30 skulls
.complete 546,1 
>>AoE the Peasants in the southern field
.complete 528,1 
step
#requires Kalaba
.hs >> If your hearth is up, hearth to Tarren Mill
>> If your hearth is down, keep AoE farming until it's back up
.vendor >> Buy level 25 drink from the Innkeeper once you hearthed
step
.goto Hillsbrad Foothills,62.35,20.51
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 528 >>Turn in Battle of Hillsbrad
.target High Executor Darthalia
.accept 529 >>Accept Battle of Hillsbrad
step
.goto Hillsbrad Foothills,62.13,19.57
.target Deathguard Samsa
>>Talk to |cRXP_FRIENDLY_Deathguard Samsa|r
.turnin 546 >>Turn in Souvenirs of Death
step
.isOnQuest 501
.goto Hillsbrad Foothills,61.44,19.06
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 501 >>Turn in Elixir of Pain
.target Apothecary Lydon
.accept 502 >>Accept Elixir of Pain
.accept 509 >>Accept Elixir of Agony
step
.goto Hillsbrad Foothills,61.44,19.06
.target Apothecary Lydon
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.accept 509 >>Accept Elixir of Agony
step
.goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
step
#sticky
#label Iron
>>Loot the Shipment of Iron found within the Smith
.goto Hillsbrad Foothills,32.00,45.44
.complete 529,3 
step
#sticky
#completewith next
>>Kill Blacksmith Verringtan and his Apprentices around the Smith
.complete 529,1 
.complete 529,2 
step
.xp 26 >> AoE all of the fields to 26
>>Start saving the Wool Cloth you get. You need 12 stacks for later
step
>>Kill Blacksmith Verringtan and his Apprentices around the Smith
.complete 529,1 
.complete 529,2 
step
#requires Iron
>> If your hearth is down, keep AoE farming until it's back up
.zone Undercity >> Teleport (don't hearth) to Undercity
step
.goto Undercity,85.14,10.03
.trainer >> Train your class spells
>>Make sure you have at least 30s leftover
step
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy some Runes of Teleportation
.collect 17031,3 
step
#completewith next
.goto Undercity,65.97,44.73
+Bank your Wool Cloth here from earlier. You need 12 stacks (240) for later
step
#softcore
#completewith next
.goto Undercity,71.50,41.92,0
+Buy some bags from the auction house if you have spare money, you're in for a long grind ahead
step
.hs >> If your hearth is up, hearth to Tarren Mill
.vendor >> Buy level 25 drink from the Innkeeper once you hearthed
step
#hardcore
#completewith next
.goto Hillsbrad Foothills,62.56,19.91
.vendor >> Buy 8-10 slot bags from Kayren if needed
step
.goto Hillsbrad Foothills,62.27,20.40
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 529 >>Turn in Battle of Hillsbrad
.target High Executor Darthalia
.accept 532 >>Accept Battle of Hillsbrad
step
#sticky
>>Kill the Clerk. He's inside the Hall
.complete 567,1 
step
>>Kill the Councilmans. Be careful as they Frost Nova and Frostbolt
.goto Hillsbrad Foothills,29.63,42.33
.complete 532,2 
step
>>Single-target kill Burnside inside the Hall. Loot the book and Burn the scroll after
.goto Hillsbrad Foothills,29.67,41.64
.complete 532,1 
.goto Hillsbrad Foothills,29.52,41.53
.complete 532,4 
.goto Hillsbrad Foothills,29.73,41.75
.complete 532,3 
step
.xp 27 >> AoE all of the fields to 27
step
.hs >> If your hearth is up, hearth to Tarren Mill. Otherwise, keep AoE farming
.vendor >> Buy level 25 drink from the Innkeeper once you hearthed
step
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 532 >>Turn in Battle of Hillsbrad
.target High Executor Darthalia
.accept 539 >>Accept Battle of Hillsbrad
step
>>Loot the big blue mushrooms in the area.
>>You can AoE the gnolls, but be careful of Shamans as they cast Lightning Bolt+Healing Wave (remember to use Counterspell)
.goto Hillsbrad Foothills,63.70,61.59
.complete 509,1 
step
.goto Hillsbrad Foothills,27.21,57.20,150 >> Run to Azurelode Mine
step
#sticky
#completewith next
+It is HIGHLY recommended you watch the link, as it can be a bit tricky here
.link https://www.twitch.tv/videos/970328906?t=06h14m29s >>CLICK HERE
step
#sticky
#label Hackett
>>Kill Miner Hackett. He can be found all throughout the mine
.complete 567,3 
step
#sticky
#completewith next
>>Kill Foreman Bonds. Be careful as he has a stun
.goto Hillsbrad Foothills,31.20,56.02
.complete 539,1 
step
.xp 30 >> AoE mobs in the mine to Level 30
>>Start saving the Wool Cloth you get. You need 12 stacks for later
>>You can hearth back to Tarren Mill to buy more water+vendor trash if ever needed, then run back to the mine
step
>>Kill 10 Miners inside the mine
.complete 539,2 
step
>>Kill Foreman Bonds. Be careful as he has a stun
.goto Hillsbrad Foothills,31.20,56.02
.complete 539,1 
step
#requires Hackett
.zone Undercity >> Teleport to Undercity
step
.goto Undercity,85.14,10.03
.trainer >> Train your class spells
>>Make sure you have at least 40s leftover
step
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy some Runes of Teleportation
.collect 17031,4 
step
.goto Undercity,63.82,49.37
.target Genavie Callow
>>Talk to |cRXP_FRIENDLY_Genavie Callow|r
.accept 1164 >>Accept To Steal From Thieves
step
#completewith next
.goto Undercity,65.97,44.73
+Bank your Wool Cloth here from earlier. You need 12 stacks (240) for later
step
.hs >> If your hearth is up, hearth to Tarren Mill
.vendor >> Buy level 25 drink from the Innkeeper once you hearthed
step
#hardcore
#completewith next
.goto Hillsbrad Foothills,62.56,19.91
.vendor >> Buy 8-10 slot bags from Kayren if needed
step
.goto Hillsbrad Foothills,61.86,19.57
.target Tallow
>>Talk to |cRXP_FRIENDLY_Tallow|r
.accept 676 >>Accept The Hammer May Fall
step
.goto Hillsbrad Foothills,61.57,20.84
.target Magus Wordeen Voidglare
>>Talk to |cRXP_FRIENDLY_Magus Wordeen Voidglare|r
.accept 544 >>Accept Prison Break In
.target Keeper Bel'varil
>>Talk to |cRXP_FRIENDLY_Keeper Bel'varil|r
.accept 556 >>Accept Stone Tokens
step
.goto Hillsbrad Foothills,62.38,20.56
.target High Executor Darthalia
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 539 >>Turn in Battle of Hillsbrad
.turnin 567 >>Turn in Dangerous!
step
.goto Hillsbrad Foothills,63.24,20.65
.target Krusk
>>Talk to |cRXP_FRIENDLY_Krusk|r
.accept 533 >>Accept Infiltration
step
.goto Hillsbrad Foothills,63.88,19.67
.target Novice Thaivand
>>Talk to |cRXP_FRIENDLY_Novice Thaivand|r
.accept 552 >>Accept Helcular's Revenge
step
.goto Hillsbrad Foothills,88.20,48.09,40,0
.zone Arathi Highlands >>Run to Arathi Highlands

]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 22-30
#classic
<< Horde
#name 22-24 Hillsbrad
#somname 22-24 Hillsbrad (Optional)
#next 24-26 Southern Barrens/Stonetalon << !Rogue !Warlock !Shaman
step
#som
#sticky
+This is a filler section, skip this part of the guide if you are level 24 or above.
.xpcheck 24-25 Class quests << Warlock/Rogue/Shaman
.xpcheck 24-26 Southern Barrens/Stonetalon << !Rogue !Warlock !Shaman
.zoneskip Hillsbrad Foothills
.zoneskip Silverpine Forest
step << Shaman
.goto Orgrimmar,38.6,36.0
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,66.046,18.526
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
>>Make sure you have Rupture and Ambush trained. You need a Dagger too
step << Warlock
.goto Orgrimmar,48.0,46.0
.trainer >> Go and train your class spells
step << Warlock
.goto Orgrimmar,47.5,46.7
.vendor >> Buy your pet spell upgrades if you got the money.
step << Mage
#som
.goto Orgrimmar,38.8,85.6
.trainer >> Go and train your class spells
>> Make sure to save at least 35 silver after training
step << Mage
#era
.goto Orgrimmar,38.8,85.6
.trainer >> Go and train your class spells
>> Make sure to save at least 55 silver after training
step << Mage
#era
.goto Orgrimmar,38.69,85.39
.trainer >> Go upstairs. Train Portal: Orgrimmar
step << Priest
.goto Orgrimmar,35.6,87.8
.trainer >> Go and train your class spells
step << Priest/Warlock/Mage
.goto Orgrimmar,44.4,48.6
.collect 5211,1 >> Buy Dusk Wand if you got the money for it.
step << Warlock
.goto Orgrimmar,48.246,45.281
>>Talk to |cRXP_FRIENDLY_Gan'rul Bloodeye|r
.turnin 1512 >>Turn in Love's Gift
.target Gan'rul Bloodeye
.accept 1513 >>Accept The Binding
step << Warlock
>>Summon the Succubus at the circle in the building. Kill her
.goto Orgrimmar,49.4,50.0
.complete 1513,1 
step << Warlock
.goto Orgrimmar,48.246,45.281
.target Gan'rul Bloodeye
>>Talk to |cRXP_FRIENDLY_Gan'rul Bloodeye|r
.turnin 1513 >>Turn in The Binding
step << Rogue
.goto Durotar,43.89,1.01
.target Shenthul
>>Talk to |cRXP_FRIENDLY_Shenthul|r
.accept 2460 >>Accept The Shattered Salute
step << Rogue
>>After Shenthul does his salute, type /Salute while targeting him.
.complete 2460,1 
step << Rogue
>>Talk to |cRXP_FRIENDLY_Shenthul|r
.turnin 2460 >>Turn in The Shattered Salute
.target Shenthul
.accept 2458 >>Accept Deep Cover
step << Rogue
#completewith next
.goto Orgrimmar,11.5,67.0,50 >>Run to the west entrance of Orgrimmar. Make sure you have a Dagger so you can Ambush later
step << Rogue
>>Use your Flare Gun TWICE, target Taskmaster Fizzule and type /Salute to turn in your quest.
.goto Durotar,20.26,17.25
.target Taskmaster Fizzule
>>Talk to |cRXP_FRIENDLY_Taskmaster Fizzule|r
.turnin 2458 >>Turn in Deep Cover
step << Rogue
.goto Durotar,19.52,16.25
.target Taskmaster Fizzule
>>Talk to |cRXP_FRIENDLY_Taskmaster Fizzule|r
.accept 2478 >>Accept Mission: Possible But Not Probable
step << Rogue
#sticky
#completewith roguetowerq
+Each mob here will take increased damage to certain abilities.
>>Ambush the Drones
>>Rupture the Patrollers (1 combo point)
>>Eviscerate the Lookouts one time (1 combo point)
step << Rogue
.goto Durotar,18.31,16.95
>>Pickpocket Foreman Silixiz to loot his Tower Key
.complete 2478,5 
step << Rogue
#label roguetowerq
.goto Durotar,18.34,16.55
>>Run into the Rogue Tower
.complete 2478,1 
.complete 2478,3 
.complete 2478,2 
step << Rogue
.goto The Barrens,54.77,5.57
>>At the top of the tower you'll find Gallywix. Ambush him to reduce his HP to half. Use Gouge to restore energy and Evasion as needed.
>>Remember to use Potions if you have them
.complete 2478,4 
step << Rogue
.goto The Barrens,54.77,5.57
>>Use your lock picking to open Gallywix's Lockbox & loot the mixture.
.complete 2478,6 
step << Rogue
.goto Orgrimmar,43.15,53.61
>>Return back to Orgrimmar to turn in your quest.
>>Talk to |cRXP_FRIENDLY_Shenthul|r
.turnin 2478 >>Turn in Mission: Possible But Not Probable
.target Shenthul
.accept 2479 >>Accept Hinott's Assistance
step << Rogue
.goto Orgrimmar,42.20,49.60
>>Purchase 10 or more of each Dust of Decay and an Empty Vial from Rekkul. These are for your poisons soon.
.vendor 3334
step << Warlock
.isQuestComplete 6284
#sticky
#completewith next
.bankdeposit 16192 >> Deposit the following items in your bank:
>> Besseleth's Fang
step
#sticky
#completewith next
+Go to the Zeppelin tower. Take the zeppelin to Tirisfal
.goto Durotar,50.8,13.8
step
.zone Tirisfal Glades >>Arrive in Tirisfal Glades
step
.goto Tirisfal Glades,61.87,65.02,40 >> Run to Undercity
step
.goto Tirisfal Glades,61.81,74.42,30 >> Run to the Elevator room
step << !Undead !Rogue
>>Take one of the elevators down
.goto Undercity,63.25,48.56
.fp Undercity >> Get the Undercity Flight Path
step << Mage
.goto Undercity,84.19,15.55
.trainer >> Go to the Portal Trainer on top of the Ziggurat. Train Portal: Undercity
step << Mage
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy a Rune of Teleportation (or more if you want)
.collect 17031,1 
step << Undead/Rogue
>>Take one of the elevators down
.goto Undercity,62.02,42.76
.target Raleigh Andrean
>>Talk to |cRXP_FRIENDLY_Raleigh Andrean|r
.turnin 441 >>Turn in Raleigh and the Undercity

step << Priest
.goto Undercity,49.2,18.2
.target Aelthalyste
>>Talk to |cRXP_FRIENDLY_Aelthalyste|r
.turnin 5644 >> Turn In Devouring Plague
step << Undead
.goto Undercity,63.25,48.56
.target Michael Garrett
>>Talk to |cRXP_FRIENDLY_Michael Garrett|r
.accept 6324 >> Accept Return to Podrig
step << Undead/Rogue
.goto Undercity,63.25,48.56
.fly The Sepulcher >> Fly to The Sepulcher
step << !Undead !Rogue
.goto Undercity,46.16,43.97,50,0
.goto Undercity,41.04,33.26,50,0
.goto Undercity,23.86,35.90,50,0
.goto Undercity,15.06,32.86,50 >> Exit Undercity via the Sewers
step << !Undead !Rogue
.goto Silverpine Forest,67.57,5.00
.zone Silverpine Forest >> Head south-west to Silverpine
step << !Undead !Rogue
.goto Silverpine Forest,45.60,42.60
.fp Sepulcher >>Run to The Sepulcher. Get The Sepulcher Flight Path
step
>>Click the Tombstone
.goto Silverpine Forest,44.10,42.60
.turnin 264 >> Turn in Until Death Do Us Part
step
.goto Silverpine Forest,43.06,41.92
.target Mura Runetotem
>>Talk to |cRXP_FRIENDLY_Mura Runetotem|r
.turnin 3301 >> Turn in Mura Runetotem
step << Undead
.goto Silverpine Forest,43.4,41.60
.target Deathguard Podrig
>>Talk to |cRXP_FRIENDLY_Deathguard Podrig|r
.turnin 6324 >> Turn in Return to Podrig
step
.goto Silverpine Forest,42.90,40.80
.target Apothecary Renferrel
>>Talk to |cRXP_FRIENDLY_Apothecary Renferrel|r
.accept 493 >> Accept Journey to Hillsbrad Foothills
step << skip
.goto Silverpine Forest,46.07,85.75
>>Kill Valdred Moray. Loot him for his hands
.complete 530,1 
.unitscan Valdred Moray

step
.goto Hillsbrad Foothills,20.80,47.40
.target Deathstalker Lesh
>>Talk to |cRXP_FRIENDLY_Deathstalker Lesh|r
.accept 494 >> Accept Time To Strike
step
.goto Hillsbrad Foothills,60.10,18.60
.fp Tarren Mill>> Get the Tarren Mill Flight Path
step << Rogue
.goto Hillsbrad Foothills,61.55,19.19
>>Talk to |cRXP_FRIENDLY_Serge Hinott|r
.turnin 2479 >>Turn in Hinott's Assistance
.target Serge Hinott
.accept 2480 >>Accept Hinott's Assistance
step << Rogue
>>Wait for Serge to complete the cure
.complete 2480,1 
step << Rogue
.goto Hillsbrad Foothills,61.50,19.20
.target Serge Hinott
>>Talk to |cRXP_FRIENDLY_Serge Hinott|r
.turnin 2480 >>Turn in Hinott's Assistance
step << Shaman
.goto Hillsbrad Foothills,62.2,20.8
>>Fill the Waterskin at the well
.complete 1536,1 
step
.goto Hillsbrad Foothills,61.50,19.20
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 493 >> Turn in Journey to Hillsbrad Foothills
.turnin 1065 >> Turn in Journey to Tarren Mill
.target Apothecary Lydon
.accept 1066 >> Accept Blood of Innocents
step
.goto Hillsbrad Foothills,61.50,19.20
.target Apothecary Lydon
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.accept 496 >> Accept Elixir of Suffering
.accept 501 >> Accept Elixir of Pain
step
.goto Hillsbrad Foothills,62.50,19.70
>> Click the Wanted poster just outside of the Inn
.accept 567 >> Accept Dangerous!
step
.goto Hillsbrad Foothills,62.20,20.50
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 494 >> Turn in Time To Strike
.target High Executor Darthalia
.accept 527 >> Accept Battle of Hillsbrad
step
.goto Hillsbrad Foothills,62.60,20.70
>>Click the Wanted poster next to Melisara
.accept 549 >> Accept WANTED: Syndicate Personnel
step
.goto Hillsbrad Foothills,63.20,20.70
.target Krusk
>>Talk to |cRXP_FRIENDLY_Krusk|r
.accept 498 >> Accept The Rescue
step << Hunter
#completewith next
.goto Hillsbrad Foothills,62.56,19.91
.vendor >> Buy arrows until your quiver is full
step
.goto Hillsbrad Foothills,62.79,19.05
.vendor 2388 >> Go inside the Inn. Vendor trash, and buy Food/Water from Shay
step << Shaman/Warrior
.goto Hillsbrad Foothills,60.4,26.2
.vendor >> Go buy a Merciless Axe from the vendor if you have enough money. It's not always in the shop.
.collect 12249,1
step << Rogue
.goto Hillsbrad Foothills,60.4,26.2
.vendor >> Go buy a Broad Bladed Knife from the vendor if you have enough money. It's not always in the shop.
.collect 12247,1
step
#era
#completewith next
>>Kill Bears and Spiders en route to the syndicates
.complete 496,1 
.complete 496,2 
step
#era
.goto Hillsbrad Foothills,78.46,43.06,200 >> Run to Dornholde Keep
step
#sticky
#label syndicateq
>>Kill Syndicates in the area
.goto Hillsbrad Foothills,77.8,44.1,0
.complete 549,1 
.complete 549,2 
step
#sticky
#label shadowmage
.goto Hillsbrad Foothills,80.61,45.40,0
>>Kill Shadow Mages. Loot them for Vials of Innocent Blood
.complete 1066,1 
step << !Rogue !Hunter !Shaman
#completewith next
.goto Hillsbrad Foothills,80.1,38.9
.vendor >> vendor trash, repair if needed
step << Rogue/Hunter/Shaman
#completewith Drull
.goto Hillsbrad Foothills,80.1,38.9
.vendor >> Vendor & repair if needed. If Stalking Pants and/or Wolf Bracers are in the shop, buy them
step
#completewith next
.goto Hillsbrad Foothills,79.8,39.3
>>Kill Jailor Marlgen. Loot him for his Burnished Gold Key
.collect 3499,1
step
>>Click the ball and chain
.goto Hillsbrad Foothills,79.8,39.6
.complete 498,2 
step
#completewith next
>>Kill Jailor Eston. Loot him for his Dull Iron Key, he can either spawn up top or inside one of the lodges at the bottom floor
.goto Hillsbrad Foothills,79.4,41.6
.collect 3467,1
.unitscan Jailor Eston
step
#label Drull
>>Click the ball and chain
.goto Hillsbrad Foothills,75.3,41.5
.complete 498,1 
step
#som
#requires shadowmage
step
#requires shadowmage
#completewith next
>>Kill Bears. Loot them for their Tongues
.complete 496,1 
step
#requires syndicateq
>>Kill Spiders. Loot them until Creeper Ichor drops
.goto Hillsbrad Foothills,63.5,33.0,100,0
.goto Hillsbrad Foothills,57.9,34.5,100,0
.goto Hillsbrad Foothills,57.2,22.1,100,0
.goto Hillsbrad Foothills,63.5,33.0,100,0
.goto Hillsbrad Foothills,57.9,34.5,100,0
.goto Hillsbrad Foothills,57.2,22.1,100,0
.goto Hillsbrad Foothills,63.5,33.0
.complete 496,2 
step
#requires syndicateq
.goto Hillsbrad Foothills,61.526,19.161
.target Apothecary Lydon
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 1066 >> Turn in Blood of Innocents
step
.goto Hillsbrad Foothills,62.38,20.52
.target High Executor Darthalia
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 549 >> Turn in WANTED: Syndicate Personnel
step
.goto Hillsbrad Foothills,63.240,20.657
.target Krusk
>>Talk to |cRXP_FRIENDLY_Krusk|r
.turnin 498 >> Turn in The Rescue
step << Hunter
#completewith next
.goto Hillsbrad Foothills,62.56,19.91
.vendor >> Buy arrows until your quiver is full
step
.goto Hillsbrad Foothills,62.79,19.05
.vendor 2388 >> Go inside the Inn. Vendor trash, and buy Food/Water from Shay
step
#completewith next
>>Kill Bears and Mountain Lions en route to the Fields. Loot them for Tongues and Blood
.complete 496,1 
.complete 501,1 
step
.goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
step
#sticky
#label Farmers
>>Kill Farmers in and around the fields
.complete 527,1 
.complete 527,2 
step
#sticky
#label Getz
>>Kill Farmer Getz. He can be in the house, barn, or field
.goto Hillsbrad Foothills,36.7,39.4,60,0
.goto Hillsbrad Foothills,35.2,37.6,45,0
.goto Hillsbrad Foothills,35.1,41.0,60,0
.goto Hillsbrad Foothills,36.7,39.4,60,0
.goto Hillsbrad Foothills,35.2,37.6,45,0
.goto Hillsbrad Foothills,35.1,41.0,60,0
.goto Hillsbrad Foothills,36.7,39.4
.complete 527,4 
step
>>Kill Farmer Ray. He can be in the 1st or 2nd floor of the house. He can also be outside under the grapevine (hut)
.goto Hillsbrad Foothills,33.7,35.5,20,0
.goto Hillsbrad Foothills,33.2,34.8,20,0
.goto Hillsbrad Foothills,33.7,35.5,20,0
.goto Hillsbrad Foothills,33.2,34.8,20,0
.goto Hillsbrad Foothills,33.7,35.5,20,0
.goto Hillsbrad Foothills,33.2,34.8,20,0
.goto Hillsbrad Foothills,33.7,35.5,20,0
.goto Hillsbrad Foothills,33.2,34.8,20,0
.goto Hillsbrad Foothills,33.7,35.5,20,0
.goto Hillsbrad Foothills,33.2,34.8,20,0
.goto Hillsbrad Foothills,33.2,34.8
.complete 527,3 
step
#hidewindow
#requires Getz
step
#requires Farmers
#completewith next
>>Kill Bears and Mountain Lions. Loot them for Tongues and Blood
.complete 496,1 
.complete 501,1 

step
#requires Farmers
>>Return to Tarren Mill
.goto Hillsbrad Foothills,62.3,20.2
.target High Executor Darthalia
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 527 >> Turn in Battle of Hillsbrad
step
.goto Hillsbrad Foothills,62.5,20.3
.target High Executor Darthalia
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.accept 528 >> Accept Battle of Hillsbrad
.target Deathguard Samsa
>>Talk to |cRXP_FRIENDLY_Deathguard Samsa|r
.accept 546 >> Accept Souvenirs of Death
step
#completewith next
>>Kill Bears and Mountain Lions. Loot them for Tongues and Blood
.goto Hillsbrad Foothills,54.9,29.8,90,0
.goto Hillsbrad Foothills,50.5,37.7,90,0
.goto Hillsbrad Foothills,43.7,39.9,90,0
.goto Hillsbrad Foothills,38.4,34.9,90,0
.goto Hillsbrad Foothills,39.1,45.4,90,0
.goto Hillsbrad Foothills,54.9,29.8
.complete 496,1 
.complete 501,1 
step
.goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
step
#sticky
#label Wilkes
>>Kill Citizen Wilkes. He patrols every road in the town
.complete 567,2 
step
#sticky
#label Kalaba
>>Kill Farmer Kalaba. She patrols the field of Peasants
.goto Hillsbrad Foothills,35.2,46.5
.complete 567,4 
step
#label Peasants
>>Kill Peasants in and around the field
.goto Hillsbrad Foothills,35.2,46.5
.complete 528,1 
step
#hidewindow
#requires Wilkes
step
#requires Kalaba
>>Finish killing Bears and Mountain Lions. Loot them for Tongues and Blood
.goto Hillsbrad Foothills,39.1,45.4,90,0
.goto Hillsbrad Foothills,38.4,34.9,90,0
.goto Hillsbrad Foothills,43.7,39.9,90,0
.goto Hillsbrad Foothills,50.5,37.7,90,0
.goto Hillsbrad Foothills,54.9,29.8,90,0
.goto Hillsbrad Foothills,39.1,45.4
.complete 496,1 
.complete 501,1 
step
>>Run back to Tarren Mill
.goto Hillsbrad Foothills,62.4,20.3
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 528 >> Turn in Battle of Hillsbrad
.target High Executor Darthalia
.accept 529 >> Accept Battle of Hillsbrad
step
.goto Hillsbrad Foothills,61.526,19.161
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 496 >> Turn in Elixir of Suffering
.target Apothecary Lydon
.accept 499 >> Accept Elixir of Suffering
.turnin 501 >> Turn in Elixir of Pain
.accept 502 >> Accept Elixir of Pain
.target Umpi
>>Talk to |cRXP_FRIENDLY_Umpi|r
.turnin 499 >> Turn in Elixir of Suffering
.accept 1067 >> Accept Return to Thunder Bluff
step << Shaman/Warrior
.goto Hillsbrad Foothills,60.4,26.2
.vendor >> If you didn't get the Merciless Axe the first time, go buy it in the shop now.
.collect 12249,1
step << Rogue
.goto Hillsbrad Foothills,60.4,26.2
.vendor >> If you didn't get the Broad Bladed Knife the first time, go buy it in the shop now.
.collect 12247,1
step
#sticky
#completewith next
+While turning in Elixir of Pain, you can kill Stanley after for a bunch of extra XP
step
.goto Hillsbrad Foothills,32.6,35.6
.target Stanley
>>Talk to |cRXP_FRIENDLY_Stanley|r
.turnin 502 >> Turn in Elixir of Pain
step
#sticky
#label Crate
>>Run back to the Hillsbrad Fields
>>Collect the crate inside the Blacksmith
.goto Hillsbrad Foothills,32.0,45.4
.complete 529,3 
step
>>Kill Blacksmith Verringtan and his Apprentices
.goto Hillsbrad Foothills,32.1,45.3
.complete 529,1 
.complete 529,2 
step
#requires Crate
.hs >> Hearth to Thunder Bluff
>> Buy food/water if needed
]])
RXPGuides.RegisterGuide([[
#group RestedXP Horde 22-30
#version 8
#classic
#som
<< Horde Shaman/Horde Warlock/Horde Rogue
#name 24-25 Class quests
#next 24-26 Southern Barrens/Stonetalon

step << Shaman
.goto Orgrimmar,38.6,36.0
.trainer >> Go and train your class spells
step << Rogue
#completewith next
.goto Orgrimmar,45.7,56.0
.vendor >> Purchase a Jambiya from Kareth if you don't have a dagger to temporarily use
step << Rogue
.goto Orgrimmar,44.0,54.6
.trainer >> Go and train your class spells
>>Make sure you have Rupture and Ambush trained. You need a Dagger too
step << Warlock
.goto Orgrimmar,48.0,46.0
.trainer >> Go and train your class spells
step << Warlock
.goto Orgrimmar,47.5,46.7
.vendor >> Buy your pet spell upgrades if you have the money for them.
step << Warlock
.goto Orgrimmar,44.4,48.6
.collect 5211,1 >> Buy Dusk Wand if you have the money for it.
step << Warlock
.goto Orgrimmar,48.246,45.281
>>Talk to |cRXP_FRIENDLY_Gan'rul Bloodeye|r
.turnin 1512 >>Turn in Love's Gift
.target Gan'rul Bloodeye
.accept 1513 >>Accept The Binding
step << Warlock
>>Summon the Succubus at the circle in the building. Kill her
.goto Orgrimmar,49.4,50.0
.complete 1513,1 
step << Warlock
.goto Orgrimmar,48.246,45.281
.target Gan'rul Bloodeye
>>Talk to |cRXP_FRIENDLY_Gan'rul Bloodeye|r
.turnin 1513 >>Turn in The Binding
step << Rogue
.goto Durotar,43.89,1.01
.target Shenthul
>>Talk to |cRXP_FRIENDLY_Shenthul|r
.accept 2460 >>Accept The Shattered Salute
step << Rogue
>>After Shenthul does his salute, type /Salute while targeting him.
.complete 2460,1 
step << Rogue
>>Talk to |cRXP_FRIENDLY_Shenthul|r
.turnin 2460 >>Turn in The Shattered Salute
.target Shenthul
.accept 2458 >>Accept Deep Cover
step << Rogue
#completewith next
.goto Orgrimmar,11.5,67.0,50 >>Run to the west entrance of Orgrimmar. Make sure you have a Dagger so you can Ambush later
step << Rogue
>>Use your Flare Gun TWICE, target Taskmaster Fizzule and type /Salute to turn in your quest.
.goto Durotar,20.26,17.25
.target Taskmaster Fizzule
>>Talk to |cRXP_FRIENDLY_Taskmaster Fizzule|r
.turnin 2458 >>Turn in Deep Cover
step << Rogue
.goto Durotar,19.52,16.25
.target Taskmaster Fizzule
>>Talk to |cRXP_FRIENDLY_Taskmaster Fizzule|r
.accept 2478 >>Accept Mission: Possible But Not Probable
step << Rogue
#sticky
#completewith roguetowerq
+Each mob here will take increased damage to certain abilities.
>>Ambush the Drones
>>Rupture the Patrollers (1 combo point)
>>Eviscerate the Lookouts one time (1 combo point)
step << Rogue
.goto Durotar,18.31,16.95
>>Pickpocket Foreman Silixiz to loot his Tower Key
.complete 2478,5 
step << Rogue
#label roguetowerq
.goto Durotar,18.34,16.55
>>Run into the Rogue Tower
.complete 2478,1 
.complete 2478,3 
.complete 2478,2 
step << Rogue
.goto The Barrens,54.77,5.57
>>At the top of the tower you'll find Gallywix. Ambush him to reduce his HP to half. Use Gouge to restore energy and Evasion as needed.
>>Remember to use Potions if you have them
.complete 2478,4 
step << Rogue
.goto The Barrens,54.77,5.57
>>Use your lock picking to open Gallywix's Lockbox & loot the mixture.
.complete 2478,6 
step << Rogue
.goto Orgrimmar,43.15,53.61
>>Return back to Orgrimmar to turn in your quest.
>>Talk to |cRXP_FRIENDLY_Shenthul|r
.turnin 2478 >>Turn in Mission: Possible But Not Probable
.target Shenthul
.accept 2479 >>Accept Hinott's Assistance
step << Rogue
.goto Orgrimmar,42.20,49.60
>>Purchase 10 or more of each Dust of Decay and an Empty Vial from Rekkul. These are for your poisons soon.
.vendor 3334
step << Warlock
.isQuestComplete 6284
#sticky
#completewith next
.bankdeposit 16192 >> Deposit the following items into your bank:
>> Besseleth's Fang
step << !Shaman !Rogue
.goto Orgrimmar,45.11,63.89
.fly Camp T >> Fly to Camp Taurajo
step << Shaman/Rogue
#sticky
#completewith next
+Go to the Zeppelin tower. Take the zeppelin to Tirisfal
.goto Durotar,50.8,13.8
step << Shaman/Rogue
.zone Tirisfal Glades >>Arrive in Tirisfal Glades
step << !Undead Rogue/Shaman
#completewith next
.goto Tirisfal Glades,61.87,65.02,40 >> Run to Undercity
step << !Undead Rogue/Shaman
.goto Tirisfal Glades,61.81,74.42,30 >> Run to the Elevator room
step << !Undead Rogue/Shaman
>>Take one of the elevators down
.goto Undercity,63.25,48.56
.fp Undercity >> Get the Undercity Flight Path
step << !Undead Rogue/Shaman
.goto Undercity,46.16,43.97,50,0
.goto Undercity,41.04,33.26,50,0
.goto Undercity,23.86,35.90,50,0
.goto Undercity,15.06,32.86,50 >> Exit Undercity via the Sewers
step << Shaman/Rogue
.goto Silverpine Forest,67.57,5.00
.zone Silverpine Forest >> Head south-west to Silverpine
step << Shaman/Rogue
.goto Silverpine Forest,45.60,42.60
.fp Sepulcher >>Run to The Sepulcher. Get The Sepulcher Flight Path
step << Shaman/Rogue
>>Click the Tombstone
.goto Silverpine Forest,44.10,42.60
.turnin 264 >> Turn in Until Death Do Us Part
step << Shaman/Rogue
.goto Silverpine Forest,43.06,41.92
.target Mura Runetotem
>>Talk to |cRXP_FRIENDLY_Mura Runetotem|r
.turnin 3301 >> Turn in Mura Runetotem
step << Shaman/Rogue
.goto Silverpine Forest,43.4,41.60
.target Deathguard Podrig
>>Talk to |cRXP_FRIENDLY_Deathguard Podrig|r
.turnin 6324 >> Turn in Return to Podrig
step << Shaman/Rogue
.goto Silverpine Forest,42.90,40.80
.target Apothecary Renferrel
>>Talk to |cRXP_FRIENDLY_Apothecary Renferrel|r
.accept 493 >> Accept Journey to Hillsbrad Foothills
step << Shaman/Rogue
.goto Hillsbrad Foothills,20.80,47.40
.target Deathstalker Lesh
>>Talk to |cRXP_FRIENDLY_Deathstalker Lesh|r
.accept 494 >> Accept Time To Strike
step << Shaman/Rogue
.goto Hillsbrad Foothills,60.10,18.60
.fp Tarren Mill>> Get the Tarren Mill Flight Path
step << Rogue
.goto Hillsbrad Foothills,61.55,19.19
>>Talk to |cRXP_FRIENDLY_Serge Hinott|r
.turnin 2479 >>Turn in Hinott's Assistance
.target Serge Hinott
.accept 2480 >>Accept Hinott's Assistance
step << Rogue
>>Wait for Serge to complete the cure
.complete 2480,1 
.goto Hillsbrad Foothills,61.50,19.20
.target Serge Hinott
>>Talk to |cRXP_FRIENDLY_Serge Hinott|r
.turnin 2480 >>Turn in Hinott's Assistance
step << Shaman
.goto Hillsbrad Foothills,62.2,20.8
.use 7768 >>Fill the Waterskin at the well
.complete 1536,1 
step << Shaman/Rogue
.goto Hillsbrad Foothills,61.50,19.20
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 493 >> Turn in Journey to Hillsbrad Foothills
.turnin 1065 >> Turn in Journey to Tarren Mill
.target Apothecary Lydon
.accept 1066 >> Accept Blood of Innocents
step << Shaman/Rogue
.goto Hillsbrad Foothills,62.20,20.50
.target High Executor Darthalia
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 494 >> Turn in Time To Strike
step << Shaman/Rogue
.goto Hillsbrad Foothills,62.60,20.70
>>Click the Wanted poster next to Melisara
.accept 549 >> Accept WANTED: Syndicate Personnel
step << Shaman/Rogue
.goto Hillsbrad Foothills,63.20,20.70
.target Krusk
>>Talk to |cRXP_FRIENDLY_Krusk|r
.accept 498 >> Accept The Rescue
step << Shaman/Rogue
.goto Hillsbrad Foothills,62.79,19.05
.vendor 2388 >> Go inside the Inn. Vendor trash, and buy Food/Water from Shay
step << Shaman
.goto Hillsbrad Foothills,60.4,26.2
.vendor >> Go buy a Merciless Axe from the vendor if you have enough money. It's not always in the shop.
.collect 12249,1
step << Rogue
.goto Hillsbrad Foothills,60.4,26.2
.vendor >> Go buy a Broad Bladed Knife from the vendor if you have enough money. It's not always in the shop.
.collect 12247,1
step << Shaman/Rogue
.goto Hillsbrad Foothills,78.46,43.06,200 >> Run to Dornholde Keep
step << Shaman/Rogue
#sticky
#label syndicateq
>>Kill Syndicates in the area
.goto Hillsbrad Foothills,77.8,44.1,0
.complete 549,1 
.complete 549,2 
step << Shaman/Rogue
#sticky
#label shadowmage
.goto Hillsbrad Foothills,80.61,45.40,0
>>Kill Shadow Mages. Loot them for Vials of Innocent Blood
.complete 1066,1 
step << Shaman/Rogue
#completewith Drull
.goto Hillsbrad Foothills,80.1,38.9
.vendor >> Vendor & repair if needed. If Stalking Pants and/or Wolf Bracers are in the shop, buy them
step << Shaman/Rogue
#completewith next
.goto Hillsbrad Foothills,79.8,39.3
>>Kill Jailor Marlgen. Loot him for his Burnished Gold Key
.collect 3499,1
step << Shaman/Rogue
>>Click the ball and chain
.goto Hillsbrad Foothills,79.8,39.6
.complete 498,2 
step << Shaman/Rogue
#completewith next
>>Kill Jailor Eston. Loot him for his Dull Iron Key, he can either spawn up top or inside one of the lodges at the bottom floor
.goto Hillsbrad Foothills,79.4,41.6
.collect 3467,1
.unitscan Jailor Eston
step << Shaman/Rogue
#label Drull
>>Click the ball and chain
.goto Hillsbrad Foothills,75.3,41.5
.complete 498,1 
step << Shaman/Rogue
#som
#requires shadowmage
step << Shaman/Rogue
#requires syndicateq
.goto Hillsbrad Foothills,61.526,19.161
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 1066 >> Turn in Blood of Innocents
.target Apothecary Lydon
.accept 1067 >> Accept Return to Thunder Bluff
step << Shaman/Rogue
.goto Hillsbrad Foothills,62.38,20.52
.target High Executor Darthalia
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 549 >> Turn in WANTED: Syndicate Personnel
step << Shaman/Rogue
.goto Hillsbrad Foothills,63.240,20.657
.target Krusk
>>Talk to |cRXP_FRIENDLY_Krusk|r
.turnin 498 >> Turn in The Rescue
step << Shaman/Rogue
.hs >> Hearth to Thunder Bluff
step << Shaman/Rogue
.goto Thunder Bluff,22.90,21.00
>>Talk to |cRXP_FRIENDLY_Apothecary Zamah|r
.turnin 1067 >> Turn in Return to Thunder Bluff
.target Apothecary Zamah
.accept 1086 >> Accept The Flying Machine Airport
step << Shaman/Rogue
.goto Thunder Bluff,46.8,50.0
.fly Camp Taurajo >> Fly to Camp Taurajo
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 22-30
#classic
<< Horde
#name 24-26 Southern Barrens/Stonetalon
#next 26-28 Ashenvale
step << Shaman/Warrior
#era/som
.goto Thunder Bluff,54.0,57.3
.vendor >> Go buy Merciless Axe if u didn't get it in Hillsbrad
.collect 12249,1
step
#sticky
.abandon 264 >> Abandon Until Death Do Us Part
.abandon 3301 >> Abandon Mura Runetotem
step << Hunter
#era/som
.goto Thunder Bluff,59.1,86.9
.trainer >> Go and train your class spells
step << Hunter
#era/som
.goto Thunder Bluff,54.1,83.9
.trainer >> Go and train your pet spells
step << Warrior
#era/som
.goto Thunder Bluff,57.6,85.5
.trainer >> Go and train your class spells
step << Druid
#era/som
.goto Thunder Bluff,77.0,29.9
.trainer >> Go and train your class spells
step << Shaman
#era/som
.goto Thunder Bluff,22.813,20.893
.trainer >> Go and train your class spells
step << Priest
#era/som
.goto Thunder Bluff,24.6,22.6
.trainer >> Go and train your class spells
step << Mage
#era/som
.goto Thunder Bluff,25.2,20.9
.trainer >> Go and train your class spells
step << Hunter
#era/som
#completewith next
.vendor >> Buy a LOT of level 25 arrows (1200+). Remember to equip them at level 25
step << Hunter
#era/som
.goto Thunder Bluff,46.9,45.7
>> Go and buy the Sturdy Recurve if it's in the shop. If it's not, skip this step
.collect 11306,1
step << Warlock
#era/som
.isOnQuest 6284
>> Withdraw the following items from your bank:
>> Besseleth's Fang
.bankwithdraw 16192
step << Rogue
#era/som
>> If you are able to use the AH or able to get these items somehow prepare them now.
.collect 5996,1
.collect 6050,1
.collect 1710,1
step
#era/som
.goto Thunder Bluff,22.90,21.00
>>Talk to |cRXP_FRIENDLY_Apothecary Zamah|r
.turnin 1067 >> Turn in Return to Thunder Bluff
.target Apothecary Zamah
.accept 1086 >> Accept The Flying Machine Airport
step
#era/som
.goto Thunder Bluff,54.70,51.30
.target Zangen Stonehoof
>>Talk to |cRXP_FRIENDLY_Zangen Stonehoof|r
.accept 1195 >> Accept The Sacred Flame
step
#completwith next
.goto Thunder Bluff,46.8,50.0
.fly Camp Taurajo >> Fly to Camp Taurajo
step
#completewith next
.goto The Barrens,45.60,59.00
.target Mangletooth
>>Talk to |cRXP_FRIENDLY_Mangletooth|r
.turnin 5046 >> Turn in Razorhide for the Thorns buff if you have 4 Bloodshards
step << Warrior
#era
>>In the building
.goto The Barrens,44.7,59.4
>>Talk to |cRXP_FRIENDLY_Ruga Ragetotem|r
.turnin 1823 >>Turn in Speak with Ruga
.target Ruga Ragetotem
.accept 1824 >>Accept Trial at the Field of Giants
step
.goto The Barrens,44.6,59.2
.target Mangletooth
>>Talk to |cRXP_FRIENDLY_Mangletooth|r
.accept 879 >> Accept Betrayal from Within
step
.goto The Barrens,45.6,59.0
.home >>Set your Hearthstone to Camp Taurajo
step
#sticky
#label Owatanka2
#completewith next
.goto The Barrens,44.2,62.1,0
.goto The Barrens,49.2,62.6,0
.goto The Barrens,49.6,60.0,0
>>Search for Owatanka (Blue Thunder Lizard) around this area. If you find him, loot his Tailspike and start the quest. If you can't find him, skip this quest
.collect 5102,1,884 
.accept 884 >>Accept Owatanka
step << Warrior
#era
>>Kill Silithid mobs in the area. Loot them for Twitching Antennae. Be quick as they have a 15m duration
.goto The Barrens,48.1,70.3
.complete 1824,1 
step << Warrior
#era
>>In the building
.goto The Barrens,44.7,59.4
.target Ruga Ragetotem
>>Talk to |cRXP_FRIENDLY_Ruga Ragetotem|r
.turnin 1824 >>Turn in Trial at the Field of Giants
>>Skip the follow-up
step
#completewith next
>>Keep an eye out for the Silithid Harvester. If you see it, kill it and loot it for its head
.collect 5138,1,897 
.accept 897 >> Accept The Harvester
.unitscan Silithid Harvester
step
>>Loot the big mounds found near the silithids
.goto The Barrens,44.97,69.74,90,0
.goto The Barrens,42.81,69.88,90,0
.goto The Barrens,43.07,71.67,90,0
.goto The Barrens,44.93,72.57,90,0
.goto The Barrens,48.79,70.04
.complete 868,1 
step
#sticky
#label Washte
.goto The Barrens,44.7,74.7,0
.goto The Barrens,44.7,77.8,0
.goto The Barrens,47.6,79.8,0
>>Search for Washte Pawne (Red Wind Serpent) around the area.
.collect 5103,1 
.accept 885 >>Accept Washte Pawne
step
.goto The Barrens,46.0,76.2,90,0
.goto The Barrens,46.0,81.2,90,0
.goto The Barrens,46.0,76.2
.target Gann Stonespire
>>Talk to |cRXP_FRIENDLY_Gann Stonespire|r
.accept 843 >> Accept Gann's Reclamation
.unitscan Gann Stonespire
step << Shaman
.goto The Barrens,43.4,77.4
>>Talk to |cRXP_FRIENDLY_Brine|r
.turnin 1536 >>Turn in Call of Water
.target Brine
.accept 1534 >>Accept Call of Water
step
#sticky
#label Weapons
>>Kill mobs in the area for Weapons of Choice. Wand from Seers, Backstabber from Stalkers or Pathfinders, and Shield from Warfrenzies
.collect 5092,1 
.collect 5093,1 
.collect 5094,1 
step
.goto The Barrens,43.4,78.8
>> Kuz can be found patrolling all around the ridge
.unitscan Kuz
.complete 879,1 
step
.goto The Barrens,40.6,80.7
>> In the building up from the Ramp
.unitscan Lok
.complete 879,3 
step
.goto The Barrens,43.8,83.5
>> Around the southern part of the Ridge
.complete 879,2 
.unitscan Nak
step
#requires Weapons
#sticky
#label Baeldun
>>Kill Dwarves in the area for Gann's Reclamation
.complete 843,1 
.complete 843,2 
step
#requires Weapons
>>Kill Prospector Khazgorm. Loot him for his Journal
.goto The Barrens,48.3,86.2
.complete 843,3 
step
#requires Baeldun
.goto The Barrens,46.0,81.2,90,0
.goto The Barrens,46.0,76.2
>>Talk to |cRXP_FRIENDLY_Gann Stonespire|r
.turnin 843 >> Turn in Gann's Reclamation
.target Gann Stonespire
.accept 846 >> Accept Revenge of Gann
.unitscan Gann Stonespire
step
>>Kill mobs and loot them for Revenge of Gann
.goto The Barrens,49.4,84.3
.complete 846,1 
.complete 846,2 
.complete 846,3 
step
.goto The Barrens,46.0,81.2,90,0
.goto The Barrens,46.0,76.2
>>Talk to |cRXP_FRIENDLY_Gann Stonespire|r
.turnin 846 >> Turn in Revenge of Gann
.target Gann Stonespire
.accept 849 >> Accept Revenge of Gann
.unitscan Gann Stonespire
step
>>Right click the Flying Machine at the top of the launch pad
.goto The Barrens,47.0,85.6
.complete 849,1 
step
.goto The Barrens,46.0,81.2,90,0
.goto The Barrens,46.0,76.2,90,0
.goto The Barrens,46.0,81.2,90,0
.goto The Barrens,46.0,76.2,90,0
.target Gann Stonespire
>>Talk to |cRXP_FRIENDLY_Gann Stonespire|r
.turnin 849 >> Turn in Revenge of Gann
step
#requires Washte
.goto Dustwallow Marsh,29.35,42.92
.zone Dustwallow Marsh >> Head to Dustwallow
step << Warrior/Shaman
.goto Dustwallow Marsh,36.20,31.60
>>Run to Brackenwall Village. Try to stick to the roads
>>Be VERY careful when running through here due to the high level mobs in the area. Don't try to attack them if you pull them, just keep running
>>Be VERY careful when running through here due to the high level mobs in the area. Don't try to attack them if you pull them, just stay in Ghost Wolf and keep running
.vendor 4884 >> Buy the Big Stick from Zulrg if it's in the shop.
step << Rogue
.goto Dustwallow Marsh,36.4,30.4
.vendor >> Buy healthpots & combat scrolls, to help u solo BFD dungeon later.
step
.goto Dustwallow Marsh,35.60,31.80
>>Run to Brackenwall Village. Try to stick to the roads << !Shaman !Warrior
.fp Brackenwall >> Get the Brackenwall Village Flight Path
.fly Ratchet >> Fly to Ratchet
step
#completewith next
.goto The Barrens,62.29,39.03
.target Captain Thalo'thas Brightsun
>>Talk to |cRXP_FRIENDLY_Captain Thalo'thas Brightsun|r
.accept 891 >>Accept The Guns of Northwatch
>>IF YOUR HEARTHSTONE IS UP, SKIP THIS QUEST
step
.goto The Barrens,65.80,43.90
>>Talk to |cRXP_FRIENDLY_Mahren Skyseer|r
.turnin 874 >> Turn in Mahren Skyseer
.target Mahren Skyseer
.accept 873 >> Accept Isha Awak
step
.goto The Barrens,65.6,47.1,100,0
.goto The Barrens,63.3,54.2,100,0
.goto The Barrens,65.6,47.1,100,0
.goto The Barrens,63.3,54.2
>>Search up and down the coast in the water for Isha Awak (Red Threshadon). Kill & loot it for its heart
.complete 873,1 
.unitscan Isha Awak
step
.isOnQuest 891
#sticky
>> If your hearth isn't up after killing Isha Awak, do the Northwatch quests. Otherwise, abandon The Guns of Northwatch
.complete 891,4 
step
.isOnQuest 891
>>Go upstairs in the tower. Kill Cannoneer Smythe
.goto The Barrens,63.17,56.58
.complete 891,3 
step
.isOnQuest 891
>>Go upstairs in the tower. Kill Cannoneer Whessan
.goto The Barrens,60.43,54.78
.complete 891,2 
step
.isOnQuest 891
>>Go upstairs in the tower. Kill Captain Fairmount
>>Do NOT accept the quest downstairs
.goto The Barrens,61.85,54.65
.complete 891,1 
step
.isOnQuest 891
.goto The Barrens,61.97,54.96
.target Gilthares Firebough
>>Talk to |cRXP_FRIENDLY_Gilthares Firebough|r
.accept 898 >>Accept Free From the Hold
step
.isOnQuest 891
>>Escort Gilthares
.goto The Barrens,62.40,39.40
.complete 898,1 
step
.goto The Barrens,62.29,39.03
.target Captain Thalo'thas Brightsun
>>Talk to |cRXP_FRIENDLY_Captain Thalo'thas Brightsun|r
.turnin 898 >> Turn in Free From the Hold
.isQuestComplete 898
step
.goto The Barrens,62.29,39.03
.target Captain Thalo'thas Brightsun
>>Talk to |cRXP_FRIENDLY_Captain Thalo'thas Brightsun|r
.turnin 891 >>Turn in The Guns of Northwatch
.isOnQuest 891
step
.goto The Barrens,65.83,43.85
.target Mahren Skyseer
>>Talk to |cRXP_FRIENDLY_Mahren Skyseer|r
.turnin 873 >> Turn in Isha Awak
step
.hs >> Hearth back to Camp Taurajo
>> Buy food/water if needed
step
.isOnQuest 897
.target Jorn Skyseer
>>Talk to |cRXP_FRIENDLY_Jorn Skyseer|r
.turnin 897 >> Turn in The Harvester
step
.goto The Barrens,45.10,57.70
.target Tatternack Steelforge
>>Talk to |cRXP_FRIENDLY_Tatternack Steelforge|r
.accept 893 >> Accept Weapons of Choice
.turnin 893 >> Turn in Weapons of Choice
.accept 1153 >> Accept A New Ore Sample
step
.goto The Barrens,44.8,59.0
.target Jorn Skyseer
>>Talk to |cRXP_FRIENDLY_Jorn Skyseer|r
.turnin 885 >> Turn in Washte Pawne
.turnin 884 >> Turn in Owatanka
step
.goto The Barrens,44.60,59.20
>>Talk to |cRXP_FRIENDLY_Mangletooth|r
.turnin 879 >> Turn in Betrayal from Within
.target Mangletooth
.accept 906 >> Accept Betrayal from Within
step
.goto The Barrens,44.60,59.20
>>Talk to |cRXP_FRIENDLY_Mangletooth|r
.turnin 879 >> Turn in Betrayal from Within
.target Mangletooth
.accept 906 >> Accept Betrayal from Within
step
.goto The Barrens,44.45,59.15
.fly Crossroads >> Fly to The Crossroads
step
.goto The Barrens,51.50,30.90
.target Thork
>>Talk to |cRXP_FRIENDLY_Thork|r
.turnin 906 >> Turn in Betrayal from Within
step
#completewith next
+If you have over 12 Silithid Eggs, split the stack and delete the extras that you have
step
.goto The Barrens,51.10,29.60
.target Korran
>>Talk to |cRXP_FRIENDLY_Korran|r
.turnin 868 >> Turn in Egg Hunt
step << Hunter
.goto The Barrens,51.50,30.34
.fly Orgrimmar >> Fly to Orgrimmar
step << Hunter
.goto Orgrimmar,48.13,80.53
.vendor >> Fill your quiver with level 25 arrows. Also upgrade your bags to 4 bags of 8 slots (if they're bigger).
step
.maxlevel 25,stonetalon25
.goto The Barrens,51.5,30.3 << !Hunter
.goto Orgrimmar,45.11,63.89 << Hunter
.fly Sun Rock >> Fly to Stonetalon Mountains
step
#era
.goto Stonetalon Mountains,45.90,60.40
.target Braelyn Firehand
>>Talk to |cRXP_FRIENDLY_Braelyn Firehand|r
.accept 1087 >> Accept Cenarius' Legacy
step
.goto Stonetalon Mountains,47.30,64.30
.target Tsunaman
>>Talk to |cRXP_FRIENDLY_Tsunaman|r
.accept 6393 >> Accept Elemental War
step
.goto Stonetalon Mountains,47.40,58.40
.target Tammra Windfield
>>Talk to |cRXP_FRIENDLY_Tammra Windfield|r
.accept 6301 >> Accept Cycle of Rebirth
step
.goto Stonetalon Mountains,47.30,61.10
.target Maggran Earthbinder
>>Talk to |cRXP_FRIENDLY_Maggran Earthbinder|r
.accept 5881 >> Accept Calling in the Reserves
.accept 6282 >> Accept Harpies Threaten
step << Warlock
.isQuestComplete 6284
.goto Stonetalon Mountains,47.19,61.15
.target Maggran Earthbinder
>>Talk to |cRXP_FRIENDLY_Maggran Earthbinder|r
.turnin 6284 >> Turn in Arachnophobia
step << !Warlock
.goto Stonetalon Mountains,59.10,75.73
.accept 6284 >>Accept Arachnophobia
step << !Warlock
#hardcoore
>>Be careful as Besseleth is a level 21 elite with a net and poison.
*This quest is optional and difficult. If you can't do it, skip this quest.
.goto Stonetalon Mountains,52.03,73.89
.complete 6284,1 
.unitscan Besseleth
step << !Warlock
#softcore
>>Be careful as Besseleth is a level 21 elite and has a net and poison. Group up if needed
.goto Stonetalon Mountains,52.03,73.89
.complete 6284,1 
.unitscan Besseleth
step
.goto Stonetalon Mountains,59.00,62.60
.target Ziz Fizziks
>>Talk to |cRXP_FRIENDLY_Ziz Fizziks|r
.accept 1096 >> Accept Gerenzo Wrenchwhistle
step
.unitscan XT:9
>>Kill XT:9. It patrols the southern side of the river
.goto Stonetalon Mountains,60.23,53.04,90,0
.goto Stonetalon Mountains,71.04,57.76
.complete 1068,2 
step
.unitscan XT:4
>>Kill XT:4. It patrols the northern side of the river
.goto Stonetalon Mountains,71.30,44.12,90,0
.goto Stonetalon Mountains,63.96,47.37
.complete 1068,1 
step
.isOnQuest 1086
.goto Stonetalon Mountains,66.40,45.40
>> Place the Toxic Fogger
.complete 1086,1
step
.goto Stonetalon Mountains,64.48,40.25
>>Climb up the mountain to find Gerenzo. Clear the mobs around him and kill him.
.complete 1096,1
.unitscan Gerenzo Wrenchwhistle
step
.goto Stonetalon Mountains,62.6,40.2
.vendor >> Go and buy gear upgrades from the vendor at the end of platform. He has the chance of having gear upgrades for every class.
step
.goto Stonetalon Mountains,58.98,62.59
.target Ziz Fizziks
>>Talk to |cRXP_FRIENDLY_Ziz Fizziks|r
.turnin 1096 >> Turn in Gerenzo Wrenchwhistle
step
#era
#completewith Gaea
.goto Stonetalon Mountains,50.64,36.60,0
>> Loot Gaea Seeds as you pass through the lake and around the lake.
.complete 6301,1
step
#era
.goto Stonetalon Mountains,38.4,18.4
>>Kill all the Coursers you see en route to Stonetalon Peak. Loot them for their eyes
.complete 1058,3
step
#era
.goto Stonetalon Mountains,35.84,13.09
>>Kill the Dryads and Night Elves in the area
.complete 1087,1
.complete 1087,2
.complete 1087,3
step
#era
#label Gaea
.goto Stonetalon Mountains,38.4,18.4
>>Kill Sap Beasts for Stonetalon Sap, Runners for Whiskers, and Fey Dragons for the Scale
.complete 1058,1
.complete 1058,2
.complete 1058,4
step
.goto Stonetalon Mountains,50.64,36.60
>> Loot Gaea Seeds as you pass through the lake and around the lake.
.complete 6301,1
step
#completewith next
.goto Stonetalon Mountains,32.60,67.40,0
>> Kill Fire Elementals. Loot them for Increndrite
.complete 6393,1
step
.goto Stonetalon Mountains,31.10,61.27
>>Kill Harpies. Be careful as the Slayers execute you when you're below 20% health, Ambushers shock for a LOT of instant damage on low cooldown, and Roguefeathers thrash (multiple attacks at once every 10 seconds or so)
.complete 6282,1
.complete 6282,2
.complete 6282,3
.complete 6282,4
step
#completewith next
.goto Stonetalon Mountains,38.7,68.6,50 >> Enter Sun Rock Retreat from the West side
step
#era
.goto Stonetalon Mountains,46.00,60.50
>> Head to Sun Rock Retreat
>>Talk to |cRXP_FRIENDLY_Braelyn Firehand|r
.turnin 1087 >> Turn in Cenarius' Legacy
.target Braelyn Firehand
.accept 1088 >> Accept Ordanus
step << !Warlock
.goto Stonetalon Mountains,47.24,61.14
.target Maggran Earthbinder
>>Talk to |cRXP_FRIENDLY_Maggran Earthbinder|r
.turnin 6284 >>Turn in Arachnophobia
step
.goto Stonetalon Mountains,47.10,61.10
>>Talk to |cRXP_FRIENDLY_Maggran Earthbinder|r
.turnin 6282 >> Turn in Harpies Threaten
.target Maggran Earthbinder
.accept 6283 >> Accept Bloodfury Bloodline
step
.goto Stonetalon Mountains,47.40,58.50
>>Talk to |cRXP_FRIENDLY_Tammra Windfield|r
.turnin 6301 >> Turn in Cycle of Rebirth
.target Tammra Windfield
.accept 6381 >> Accept New Life
step
#completewith next
.goto Stonetalon Mountains,32.60,67.40,0
>> Kill Fire Elementals. Loot them for Increndrite
.complete 6393,1
step
#sticky
#completewith Ripper
.goto Stonetalon Mountains,31.10,61.27,0
>> Plant the trees in the dirt mounds of The Charred Vale
.complete 6381,1
step
.goto Stonetalon Mountains,32.60,67.40
>> Kill Fire Elementals. Loot them for Increndrite
.complete 6393,1
step
#hardcore
#label Ripper
.goto Stonetalon Mountains,30.75,61.91
>>Clear out the Harpies next to Bloodfury Ripper. She has a large social pull radius so be careful
.complete 6283,1
.unitscan Bloodfury Ripper
step
#softcore
#label Ripper
.goto Stonetalon Mountains,30.75,61.91
>>Clear out the Harpies next to Bloodfury Ripper. She has a large social pull radius so be careful. Group if you can't solo this quest.
.complete 6283,1
.unitscan Bloodfury Ripper
step
.goto Stonetalon Mountains,31.10,61.27
>> Plant the trees in the dirt mounds of The Charred Vale
.complete 6381,1
step
.goto Stonetalon Mountains,38.7,68.6,50,0
.goto Stonetalon Mountains,47.20,64.40
>> Head back to Sun Rock Retreat
.target Tsunaman
>>Talk to |cRXP_FRIENDLY_Tsunaman|r
.turnin 6393 >> Turn in Elemental War
step
.isQuestComplete 6283
.goto Stonetalon Mountains,47.19,61.15
.target Maggran Earthbinder
>>Talk to |cRXP_FRIENDLY_Maggran Earthbinder|r
.turnin 6283 >> Turn in Bloodfury Bloodline
step
.goto Stonetalon Mountains,47.46,58.37
.target Tammra Windfield
>>Talk to |cRXP_FRIENDLY_Tammra Windfield|r
.turnin 6381 >> Turn in New Life
step
#era
.goto Stonetalon Mountains,74.50,97.90
.target Witch Doctor Jin'Zil
>>Talk to |cRXP_FRIENDLY_Witch Doctor Jin'Zil|r
.turnin 1060 >> Turn in Letter to Jin'Zil
.turnin 1058 >> Turn in Jin'Zil's Forest Magic
step
#som
#phase 1-2
.goto Stonetalon Mountains,74.50,97.90
.target Witch Doctor Jin'Zil
>>Talk to |cRXP_FRIENDLY_Witch Doctor Jin'Zil|r
.turnin 1060 >> Turn in Letter to Jin'Zil
step
.goto The Barrens,35.30,27.90
.target Seereth Stonebreak
>>Talk to |cRXP_FRIENDLY_Seereth Stonebreak|r
.turnin 1068 >> Turn in Shredding Machines
step << Hunter
.hs >> Hearth to Camp Taurajo
>> Buy food/water if needed
step << Hunter
.goto The Barrens,44.45,59.15
.fly Splintertree >> Fly to Splintertree Post
step << !Hunter
#label stonetalon25
.goto Ashenvale,68.66,85.86
.zone Ashenvale >> Walk to Ashenvale from Stonetalon via The Barrens
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 22-30
#classic
<< Horde
#name 26-28 Ashenvale
#next 28-30 Thousand Needles
step << !Hunter
.goto Ashenvale,68.30,75.30
>> Start the escort quest
.target Torek
>>Talk to |cRXP_FRIENDLY_Torek|r

.accept 6544 >> Accept Torek's Assault
step << !Hunter
>> Escort Torek. When you kill the mobs 4 inside, run to the end platform (as more mobs will spawn), and let the orcs take aggro
>> Kill the mobs that have aggro on Torek, then kill the rest.
.complete 6544,1 
step << !Hunter
.goto Ashenvale,71.20,68.10
.target Kuray'bin
>>Talk to |cRXP_FRIENDLY_Kuray'bin|r
.accept 6503 >> Accept Ashenvale Outrunners
step << !Hunter
.goto Ashenvale,73.00,62.50
.target Ertog Ragetusk
>>Talk to |cRXP_FRIENDLY_Ertog Ragetusk|r
.turnin 6544 >> Turn in Torek's Assault
step << !Hunter
.goto Ashenvale,73.78,61.46
.target Senani Thunderheart
>>Talk to |cRXP_FRIENDLY_Senani Thunderheart|r
.turnin 6382 >> Turn in The Ashenvale Hunt
.turnin 6383 >> Turn in The Ashenvale Hunt
step
.goto Ashenvale,73.10,61.50
.target Pixel
>>Talk to |cRXP_FRIENDLY_Pixel|r
.accept 6441 >> Accept Satyr Horns
step << Hunter
.goto Ashenvale,73.38,61.01
.stable >> Talk to Qeeju. Stable your pet
step
.goto Ashenvale,73.60,60.10
.target Mastok Wrilehiss
>>Talk to |cRXP_FRIENDLY_Mastok Wrilehiss|r
.accept 25 >> Accept Stonetalon Standstill
step << Rogue
.goto Ashenvale,74.0,60.6
.home >>Set your Hearthstone to Splintertree Post
step << Hunter
#completewith Outrunners
.goto Ashenvale,68.84,60.54
+Leave Splintertree and cross the river. Tame an Elder Ashenvale Bear
>>Attack mobs with the Bear using Rank 4 Claw until you see that you've learnt it in your chat window
.unitscan Elder Ashenvale Bear
step << Hunter
.goto Ashenvale,73.38,61.01
.stable >>Abandon the Bear. Go back to the stable and equip your pet
step << Hunter
#sticky
#label Sharptalon
>>Kill Sharptalon by kiting him back to the guards. M
step << Hunter
#label Outrunners
.goto Ashenvale,71.20,68.10
.target Kuray'bin
>>Talk to |cRXP_FRIENDLY_Kuray'bin|r
.accept 6503 >> Accept Ashenvale Outrunners
step
>>Kill Ashenvale Outrunners that are stealthed around the area.
.goto Ashenvale,72.5,72.5,90,0
.goto Ashenvale,76.3,71.1,90,0
.goto Ashenvale,76.3,67.3,90,0
.goto Ashenvale,72.5,72.5
.complete 6503,1 
step
#sticky
#completewith next
.goto Ashenvale,71.75,63.83,90,0
.goto Ashenvale,72.3,49.8,90 >>Run along the side of the river to here
step
>>Kill Satyrs in the area. Loot them for their Horns
.goto Ashenvale,68.2,54.0
.complete 6441,1 
step
#sticky
#completewith next
>>Kill Laughing Sisters until they drop Etched Phial
.collect 5867 
step
#sticky
#completewith next
+This next quest can be quite hard, be extra careful
#hardcore
step
#era
.goto Ashenvale,62.07,51.32
>> Ordanus can be quite hard, your should try to burst him, loot him and then jump down from the building.
.complete 1088,1 
step
>>Look for Shadumbra (a panther) and loot her for Shadumbra's Head, then accept it.
.goto Ashenvale,62.2,49.6,90,0
.goto Ashenvale,58.0,56.2,90,0
.goto Ashenvale,51.9,54.3,90,0
.goto Ashenvale,61.2,51.5
.collect 16304,1,24 
.accept 24 >> Accept Shadumbra's Head
.unitscan Shadumbra
step
>>Kill Laughing Sisters until they drop Etched Phial
.goto Ashenvale,61.3,51.9
.collect 5867 
step
#requires Phial
.goto Ashenvale,44.62,55.47,150,0
.goto Ashenvale,38.5,36.1,90 >>Run to Thistlefur Village
step
#sticky
#completewith next
>>Kill some of the Furbolgs en route to the cave
.complete 216,2 
.complete 216,1 
step
#completewith next
.goto Ashenvale,38.4,30.6,60 >>Run into Thistlefur Hold
step
.goto Ashenvale,41.08,32.74
>>Loot the tiny chests inside the tunnel
.complete 6462,1 
step
>>Go to the back of the cave. Talk to the Bear. This starts an escort
.goto Ashenvale,41.5,34.5
.target Ruul Snowhoof
>>Talk to |cRXP_FRIENDLY_Ruul Snowhoof|r
.accept 6482 >> Accept Freedom to Ruul
step
.goto Ashenvale,38.5,36.4
.complete 6482,1 
step
>>Finish killing the Furbolgs
.goto Ashenvale,35.9,36.7
.complete 216,2 
.complete 216,1 
step << Shaman
>>Fill the Waterskin
.goto Ashenvale,33.5,67.5
.complete 1534,1 
step
.goto Ashenvale,41.5,67.4,90,0
.goto Ashenvale,44.3,68.6,90,0
.goto Ashenvale,43.8,63.6,90,0
.goto Ashenvale,41.4,65.9,90,0
.goto Ashenvale,41.5,67.4
>>Look for Ursangous (Bear). He patrols clockwise. Kill and loot him for Ursangous's Paw, then accept it
.collect 16303,1,23 
.accept 23 >> Accept Ursangous's Paw
.unitscan Ursangous
step
#sticky
#label Tideress
.unitscan Tideress
>>Kill Tideress who is located around the middle of the lake. Loot her for a Befouled Water Globe, then click it to accept the quest
.collect 16408,1,1918 
.accept 1918 >>Accept The Befouled Element
step
#sticky
#completewith next
>>Kill Water Elementals throughout the lake
.complete 25,1 
step
>>Run under the Gazebo in the middle of the lake
.goto Ashenvale,48.9,69.6
.complete 25,2 
step
>>Kill Water Elementals throughout the lake
.goto Ashenvale,48.9,69.6
.complete 25,1 
step
#requires Tideress
>>Use the Etched Phial from earlier at the moonwell
.goto Ashenvale,60.2,72.9
.complete 1195,1 
step
.goto Ashenvale,71.2,68.1
.target Kuray'bin
>>Talk to |cRXP_FRIENDLY_Kuray'bin|r
.turnin 6503 >> Turn in Ashenvale Outrunners
step
#sticky
#completewith next
+This next quest can be quite hard, be extra careful
#hardcore
step
.goto Ashenvale,72.4,72.1,90,0
.goto Ashenvale,75.7,70.0,90,0
.goto Ashenvale,78.2,65.5,90,0
.goto Ashenvale,72.4,72.1,90,0
.goto Ashenvale,75.7,70.0,90,0
.goto Ashenvale,78.2,65.5,90,0
.goto Ashenvale,75.3,72.0,0
>>Look for Sharptalon (Big Bird). He Patrols clockwise. Kill and loot him for Sharptalon's Claw, then accept it. Solo him down to about 60%, then kite him to the undead camp to kill him.
.collect 16305,1,2 
.accept 2 >> Accept Sharptalon's Claw
.unitscan Sharptalon
step
>>Go back to town
.goto Ashenvale,73.1,62.5
.target Ertog Ragetusk
>>Talk to |cRXP_FRIENDLY_Ertog Ragetusk|r
.turnin 6544 >> Turn in Torek's Assault
step
.goto Ashenvale,73.8,61.5
.target Senani Thunderheart
>>Talk to |cRXP_FRIENDLY_Senani Thunderheart|r
.turnin 2 >> Turn in Sharptalon's Claw
.turnin 24 >> Turn in Shadumbra's Head
.turnin 23 >> Turn in Ursangous's Paw
.turnin 247 >> Turn in The Hunt Completed
step
.goto Ashenvale,73.1,61.5
.target Pixel
>>Talk to |cRXP_FRIENDLY_Pixel|r
.turnin 6441 >> Turn in Satyr Horns
step
.goto Ashenvale,73.7,60.0
>>Talk to |cRXP_FRIENDLY_Mastok Wrilehiss|r
.turnin 25 >> Turn in Stonetalon Standstill
.turnin 1918 >> Turn in The Befouled Element
.target Mastok Wrilehiss
.accept 824 >> Accept Je'neu of the Earthen Ring
step
.goto Ashenvale,74.114,60.917
.target Yama Snowhoof
>>Talk to |cRXP_FRIENDLY_Yama Snowhoof|r
.turnin 6482 >> Turn in Freedom to Ruul
step
.goto Ashenvale,73.2,61.5
.fly Zoram'gar >> Fly to Zoram'gar Outpost
step
.goto Ashenvale,11.897,34.535
.target Karang Amakkar
>>Talk to |cRXP_FRIENDLY_Karang Amakkar|r
.turnin 216 >> Turn in Between a Rock and a Thistlefur
step
.goto Ashenvale,11.7,34.8
.target Mitsuwa
>>Talk to |cRXP_FRIENDLY_Mitsuwa|r
.turnin 6462 >> Turn in Troll Charm
step
.goto Ashenvale,11.6,34.3
.target Je'neu Sancrea
>>Talk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.turnin 824 >> Turn in Je'neu of the Earthen Ring
step << Rogue
.goto Ashenvale,11.59,34.27
.target Je'neu Sancrea
>>Talk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.accept 6921 >>Accept Amongst the Ruins
.accept 6563 >>Accept The Essence of Aku'Mai
step << Rogue
.goto Ashenvale,14.0,15.0,100 >> Go to the entrance of Blackfathom Deeps
step << Rogue
.goto Ashenvale,13.15,12.96
>> Kill Blackfathom Tide Priestesses until Damp Note drops. Start the quest
.collect 16790,1,6564
.accept 6564 >> Accept Allegiance to the Old Gods
step << Rogue
.goto Ashenvale,17.04,12.29
>> Stealth towards the dungeon while looting the 20 Sapphires on the walls
.complete 6563,1 
step << Rogue
#completewith next
+To solo this quest you need to play correctly in 2 ways. First of all you need to not die to breath, that means before you aggro the boss you should have full breath. The second thing to be aware of is that you need to kick EVERY frostbolt you can and use evasion after a kick. Most of his damage will be from frostbolts. Remember you can vanish and try again 5 mins later, aslong as you don't die to breath.
.link https://youtu.be/ehXV0stmDrM?t=202 >> CLICK HERE for a guide on this section
step << Rogue
>> Stealth all the way to the Moonshine Ruins, then swim under the Bridge and prepare for the boss (Use all buffs you have)
>> Loot the Fathom Core, this spawns the boss.
>> Loot the Globe from Baron Aquanis. Accept the quest
.collect 16762,1,6922
.accept 6922 >> Accept Baron Aquanis
step << !Rogue !Warlock
.hs >> Hearth to Camp Taurajo
>> Buy food/water if needed
step << Rogue
.hs >> Hearth to Splintertree Post
>> Buy food/water if needed
step << Rogue
.goto Ashenvale,73.2,61.5
.fly Zoram'gar >> Fly to Zoram'gar Outpost
step << Rogue
.goto Ashenvale,11.57,34.28
.target Je'neu Sancrea
>>Talk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.turnin 6563 >>Turn in The Essence of Aku'Mai
.turnin 6921 >>Turn in Amongst the Ruins
.turnin 6922 >>Turn in Baron Aquanis
.turnin 6564 >>Turn in Allegiance to the Old Gods
step << Warlock/Rogue
.goto Ashenvale,12.24,33.80
.fly Orgrimmar >> Fly to Orgrimmar
step << Rogue
.goto Orgrimmar,48.0,80.2
.vendor >> Buy throwns if you need it
step << Rogue
.goto Orgrimmar,44.0,54.6
.trainer >> Go and train your class spells
step << Warlock
.goto Orgrimmar,48.0,46.0
.trainer >> Go and train your class spells
step << Warlock
.goto Orgrimmar,47.5,46.7
.vendor >> Buy your pet upgrades if you got the money for it.
step << Warlock
.hs >> Hearth to Camp Taurajo
>> Buy food/water if needed
step
.goto Orgrimmar,45.11,63.89 << Rogue
.goto The Barrens,44.45,59.16 << !Warlock !Rogue
.fly Thunder Bluff >> Fly to Thunder Bluff
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 22-30
#classic
<< Horde
#name 28-30 Thousand Needles
#next RestedXP Horde 30-40\30-33 Hillsbrad/Arathi
step << Shaman/Warrior
.goto Thunder Bluff,54.0,57.3
>> Go and buy the Merciless Axe if it's in the shop. If it's not, skip this step
.collect 12249,1
step
.goto Thunder Bluff,54.90,51.60
>>Talk to |cRXP_FRIENDLY_Zangen Stonehoof|r
.turnin 1195 >> Turn in The Sacred Flame
.target Zangen Stonehoof
.accept 1196 >> Accept The Sacred Flame
step << Druid
.goto Thunder Bluff,77.0,29.9
.trainer >> Go and train your class spells
step
.goto Thunder Bluff,61.538,80.919
>>Talk to |cRXP_FRIENDLY_Melor Stonehoof|r
.turnin 1130 >>Turn in Melor Sends Word
.target Melor Stonehoof
.accept 1131 >>Accept Steelsnap
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
.goto Thunder Bluff,45.80,64.60
.home >> Set your Hearthstone to Thunder Bluff
step << Shaman
.goto Thunder Bluff,22.813,20.893
.trainer >> Go and train your class spells
step << Priest
.goto Thunder Bluff,24.6,22.6
.trainer >> Go and train your class spells
step << Mage
.goto Thunder Bluff,25.2,20.9
.trainer >> Go and train your class spells
step
.isOnQuest 1086
.goto Thunder Bluff,22.80,20.80
.target Apothecary Zamah
>>Talk to |cRXP_FRIENDLY_Apothecary Zamah|r
.turnin 1086 >> Turn in The Flying Machine Airport
step
>>Run up the tower to the Flight Master
.goto Thunder Bluff,47.00,49.83
.fly Camp Taurajo >> Fly to Camp Taurajo
step
.goto The Barrens,45.10,57.70
.target Tatternack Steelforge
>>Talk to |cRXP_FRIENDLY_Tatternack Steelforge|r
.accept 1153 >> Accept A New Ore Sample
step << Shaman
.goto The Barrens,43.4,77.4
>>Talk to |cRXP_FRIENDLY_Brine|r
.turnin 1534 >>Turn in Call of Water
.target Brine
.accept 220 >>Accept Call of Water
step << Warlock/Hunter
#era
.goto The Barrens,48.90,86.30
.target Feegly the Exiled
>>Talk to |cRXP_FRIENDLY_Feegly the Exiled|r
.accept 857 >> Accept The Tear of the Moons
#softcore
step << Warlock/Hunter
#era
.goto The Barrens,49.12,84.25
>> Enter the keep, go downstairs, and loot the chest.
.complete 857,1
#softcore
step << Warlock/Hunter
#era
.goto The Barrens,48.99,86.29
.target Feegly the Exiled
>>Talk to |cRXP_FRIENDLY_Feegly the Exiled|r
.turnin 857 >> Turn in The Tear of the Moons
#softcore
step
.isOnQuest 5881
.goto The Barrens,44.00,92.00
.target Grish Longrunner
>>Talk to |cRXP_FRIENDLY_Grish Longrunner|r
.turnin 5881 >> Turn in Calling in the Reserves
step
.goto The Barrens,44.20,92.20
.target Brave Moonhorn
>>Talk to |cRXP_FRIENDLY_Brave Moonhorn|r
.accept 4542 >> Accept Message to Freewind Post
step
#sticky
#completewith GalakM
>> Keep an eye out & kill the Galak Messenger that patrols the area as you quest. Loot him for the Assassination Note
.collect 12564,1,4881
.accept 4881 >> Accept Assassination Plot
.unitscan Galak Messenger
step
#sticky
#completewith Faith
>> Kill all Kobolds you encounter. Loot them for the Ore Sample
.goto Thousand Needles,65.74,49.89,0
.goto Thousand Needles,67.87,58.33,0
.goto Thousand Needles,66.03,62.14,0
.goto Thousand Needles,58.95,57.84,0
.complete 1153,1
.unitscan Gravelsnout Digger;Gravelsnout Surveyor;Gibblesnik
step
>>Take the lift up to Freewind Post
.goto Thousand Needles,46.74,47.98,30,0
.goto Thousand Needles,45.10,49.10
.fp Freewind >> Get the Freewind Post Flight Path
step
.goto Thousand Needles,44.90,48.90
.target Elu
>>Talk to |cRXP_FRIENDLY_Elu|r
.accept 4767 >> Accept Wind Rider
step
.goto Thousand Needles,44.70,50.30
.target Hagar Lightninghoof
>>Talk to |cRXP_FRIENDLY_Hagar Lightninghoof|r
.accept 4821 >> Accept Alien Egg
step
.goto Thousand Needles,45.70,50.80
>>Talk to |cRXP_FRIENDLY_Cliffwatcher Longhorn|r
.turnin 4542 >> Turn in Message to Freewind Post
.target Cliffwatcher Longhorn
.accept 4841 >> Accept Pacify the Centaur
step
.goto Thousand Needles,46.10,51.60
>>Talk to |cRXP_FRIENDLY_Rau Cliffrunner|r
.turnin 1196 >> Turn in The Sacred Flame
.target Rau Cliffrunner
.accept 1197 >> Accept The Sacred Flame
step
.goto Thousand Needles,46.00,50.80
>> Click on the wanted poster
.accept 5147 >> Accept Wanted - Arnak Grimtotem
step
#completewith next
>> Kill Centaurs in the area
.complete 4841,1
.complete 4841,2
.complete 4841,3
step
#sticky
#completewith next
+This next quest can be quite hard, be extra careful
#hardcore
step
.goto Thousand Needles,44.11,37.16,50,0
.goto Thousand Needles,42.00,31.60
>> Go to the Centaur Cave. Click on the brazier at the back of it. Loot the item from it
.complete 1197,1
step
.goto Thousand Needles,40.89,38.45
>> Finish killing the remaining Centaurs
.complete 4841,1
.complete 4841,2
.complete 4841,3
step
.goto Thousand Needles,53.90,41.60
.target Dorn Plainstalker
>>Talk to |cRXP_FRIENDLY_Dorn Plainstalker|r
.accept 1149 >> Accept Test of Faith
step
>> Jump off the small wooden platform. You will be teleported back to the cave mid-air
.complete 1149,1
step
#label Faith
.goto Thousand Needles,53.94,41.48
>>Talk to |cRXP_FRIENDLY_Dorn Plainstalker|r
.turnin 1149 >> Turn in Test of Faith
.target Dorn Plainstalker
.accept 1150 >> Accept Test of Endurance
step
#sticky
#label Kobolds
.goto Thousand Needles,65.74,49.89,90,0
.goto Thousand Needles,67.87,58.33,90,0
.goto Thousand Needles,66.03,62.14,90,0
.goto Thousand Needles,58.95,57.84,90,0
.goto Thousand Needles,65.74,49.89
>> Kill all Kobolds you encounter. Loot them for the Ore Sample
.complete 1153,1
.unitscan Gravelsnout Digger;Gravelsnout Surveyor;Gibblesnik
step
.goto Thousand Needles,56.30,50.40,20,0
.goto Thousand Needles,52.33,55.25,20,0
.goto Thousand Needles,37.64,56.01,20,0
.goto Thousand Needles,56.30,50.40,20,0
.goto Thousand Needles,52.33,55.25,20,0
.goto Thousand Needles,37.64,56.01,20,0
.goto Thousand Needles,56.30,50.40,0
.goto Thousand Needles,52.33,55.25,0
.goto Thousand Needles,37.64,56.01,0
>>Look for the white Alien Egg at the Wind Serpent nests. It can be in multiple spawnpoints
.complete 4821,1
step
#requires Kobolds
.goto Thousand Needles,46.10,51.60
.target Rau Cliffrunner
>>Talk to |cRXP_FRIENDLY_Rau Cliffrunner|r
.turnin 1197 >> Turn in The Sacred Flame
step
.goto Thousand Needles,45.70,50.80
>>Talk to |cRXP_FRIENDLY_Cliffwatcher Longhorn|r
.turnin 4841 >> Turn in Pacify the Centaur
.target Cliffwatcher Longhorn
.accept 5064 >> Accept Grimtotem Spying
step
.goto Thousand Needles,44.70,50.30
>>Talk to |cRXP_FRIENDLY_Hagar Lightninghoof|r
.turnin 4821 >> Turn in Alien Egg
.target Hagar Lightninghoof
.accept 4865 >> Accept Serpent Wild
step
.goto Thousand Needles,25.90,54.80
>> Head to the harpy cave. Destroy all the boxes at the end of it to summon Grenka Bloodscreech.
>> Be careful as this quest is VERY HARD. Find a group if you're unable to solo this or skip it.
.link https://www.youtube.com/watch?v=EVy-6OjB5bs&t=27300s >> CLICK HERE for a visual reference if you think it's doable
.complete 1150,1
step
#completewith SteelsnapG
>> Kill Steelsnap. He patrols the zone. Try to split pull him if you know how
.complete 1131,1
.unitscan Steelsnap
step
#completewith Paoka
>>Loot the eggs on the ground. Try to have 7-8 before starting the Escort, and finish it during the escort
.complete 4767,1
step
.goto Thousand Needles,14.05,32.01,60,0
.goto Thousand Needles,12.65,34.49,60,0
.goto Thousand Needles,13.45,40.29,40,0
.goto Thousand Needles,17.90,40.60
>> Start the escort quest
.target Pao'ka Swiftmountain
>>Talk to |cRXP_FRIENDLY_Pao'ka Swiftmountain|r
.accept 4770 >> Accept Homeward Bound
step
#label Paoka
>> Escort Pao'ka to safety. Be careful of Heartrazor (level 32 rare elite)
.complete 4770,1
.unitscan Heartrazor
step
.goto Thousand Needles,11.60,35.21
>> Finish gathering the Highperch Eggs
.complete 4767,1
step
#completewith SteelsnapG
.goto Thousand Needles,21.06,31.87
.vendor >> vendor trash, buy food/water if needed
step
.isOnQuest 4881
.goto Thousand Needles,21.34,31.95
.target Kanati Greycloud
>>Talk to |cRXP_FRIENDLY_Kanati Greycloud|r
.turnin 4881 >>Turn in Assassination Plot
step
.isQuestTurnedIn 4881
.goto Thousand Needles,21.34,31.95
>>Accepting this quest will start an escort. 3 Mobs will attack at once
.target Kanati Greycloud
>>Talk to |cRXP_FRIENDLY_Kanati Greycloud|r
.accept 4966 >>Accept Protect Kanati Greycloud
step
.isQuestTurnedIn 4881
.goto Thousand Needles,21.34,31.95
>>Kill the 3 mobs that spawn
.complete 4966,1 
.target Kanati Greycloud
>>Talk to |cRXP_FRIENDLY_Kanati Greycloud|r
.turnin 4966 >>Turn in Protect Kanati Greycloud
step
.goto Thousand Needles,21.50,32.50
.target Wizlo Bearingshiner
>>Talk to |cRXP_FRIENDLY_Wizlo Bearingshiner|r
.accept 5151 >> Accept Hypercapacitor Gizmo
>>Talk to |cRXP_FRIENDLY_Motega Firemane|r
.turnin 4865 >> Turn in Serpent Wild
.target Motega Firemane
.accept 5062 >> Accept Sacred Fire
.turnin 4770 >> Turn in Homeward Bound
step
#softcore
.goto Thousand Needles,22.90,24.40
>> Click on the panther cage and kill the elite inside. Group up if he's too hard to solo.
>>Be careful as this quest is HARD
.complete 5151,1

step
#hardcore
.goto Thousand Needles,22.90,24.40
>> Click on the panther cage and kill the elite inside
>>Be careful as this quest is HARD
.complete 5151,1

step
#era
.goto Thousand Needles,18.7,22.2
.xp 28+29000 >> Grind to 29000+/41400xp
step
#som
.goto Thousand Needles,18.7,22.2
.xp 28+20000 >> Grind to 20000+/41400xp
step
#label SteelsnapG
.goto The Barrens,35.22,92.47
>> Finish off A New Ore Sample
.complete 1153,1
step
#label GalakM
>>Search for Steelsnap (Hyena). He patrols counter-clockwise
>>Scout him out with Eagle Eye << Hunter
>>Scout him out with Far Sight if you have it trained << Shaman
.goto Thousand Needles,10.9,23.2,90,0
.goto Thousand Needles,17.1,18.4,90,0
.goto Thousand Needles,18.3,26.8,90,0
.goto Thousand Needles,15.2,30.5,90,0
.goto Thousand Needles,18.3,26.8,90,0
.goto Thousand Needles,17.1,18.4,90,0
.goto Thousand Needles,10.9,23.2,90,0
.goto Thousand Needles,17.1,18.4,90,0
.goto Thousand Needles,18.3,26.8,90,0
.goto Thousand Needles,15.2,30.5,90,0
.complete 1131,1 
.unitscan Steelsnap
step
.goto Thousand Needles,21.43,32.55
.isQuestComplete 5151
.target Wizlo Bearingshiner
>>Talk to |cRXP_FRIENDLY_Wizlo Bearingshiner|r
.turnin 5151 >> Turn in Hypercapacitor Gizmo
step
>>Search for the Galak Messenger. He starts at a camp, goes on the road, then goes to the other camp
>>Scout him out with Eagle Eye << Hunter
>>Scout him out with Far Sight if you have it trained << Shaman
.goto Thousand Needles,18.4,22.2,90,0
.goto Thousand Needles,25.2,33.8,90,0
.goto Thousand Needles,36.0,29.0,90,0
.goto Thousand Needles,39.6,33.6,90,0
.goto Thousand Needles,36.0,29.0,90,0
.goto Thousand Needles,25.2,33.8,90,0
.goto Thousand Needles,18.4,22.2,90,0
.goto Thousand Needles,25.2,33.8,90,0
.goto Thousand Needles,36.0,29.0,90,0
.goto Thousand Needles,39.6,33.6,90,0
.collect 12564,1,4881 
.accept 4881 >> Accept Assassination Plot
.unitscan Galak Messenger
step
>>Loot the plants in and around the whole body of water
.goto Thousand Needles,36.80,38.11
.complete 5062,1
step
#completewith next
.hs >> Hearth to Thunder Bluff
>> Buy food/water if needed
step
.goto Thunder Bluff,61.53,80.91
>>Talk to |cRXP_FRIENDLY_Melor Stonehoof|r
.turnin 1131 >> Turn in Steelsnap
.target Melor Stonehoof
.accept 1136 >> Accept Frostmaw << Hunter
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
.goto Thunder Bluff,70.20,30.90
>>Talk to |cRXP_FRIENDLY_Magatha Grimtotem|r
.turnin 5062 >> Turn in Sacred Fire
.target Magatha Grimtotem
.accept 5088 >> Accept Arikara
step << Druid
.goto Thunder Bluff,77.0,29.9
.trainer >> Go and train your class spells
step << Shaman
.goto Thunder Bluff,22.813,20.893
.trainer >> Go and train your class spells
step << Priest
.goto Thunder Bluff,24.6,22.6
.trainer >> Go and train your class spells
step << Mage
.goto Thunder Bluff,25.2,20.9
.trainer >> Go and train your class spells
step
.goto Thunder Bluff,46.8,50.0
.fly Camp Taurajo >> Fly to Camp Taurajo
step
.goto The Barrens,45.10,57.70
.target Tatternack Steelforge
>>Talk to |cRXP_FRIENDLY_Tatternack Steelforge|r
.turnin 1153 >> Turn in A New Ore Sample
step
.goto The Barrens,44.45,59.15
.fly Freewind >> Fly to Thousand Needles
step
.goto Thousand Needles,45.00,49.00
.target Elu
>>Talk to |cRXP_FRIENDLY_Elu|r
.turnin 4767 >> Turn in Wind Rider
step
.goto Thousand Needles,46.00,52.0
.home >> Set your Hearthstone to Freewind Post
step
.isQuestComplete 1150
.goto Thousand Needles,53.90,41.60
.target Dorn Plainstalker
>>Talk to |cRXP_FRIENDLY_Dorn Plainstalker|r
.turnin 1150 >> Turn in Test of Endurance
step
.isQuestTurnedIn 1150
.goto Thousand Needles,53.90,41.60
.target Dorn Plainstalker
>>Talk to |cRXP_FRIENDLY_Dorn Plainstalker|r
.accept 1151 >> Accept Test of Strength
step
.goto Thousand Needles,53.90,41.60
.target Dorn Plainstalker
>>Talk to |cRXP_FRIENDLY_Dorn Plainstalker|r
.accept 1151 >> Accept Test of Strength
.isQuestTurnedIn 1150
step
#completewith next
.goto Thousand Needles,25.60,45.60,0
.goto Thousand Needles,8.60,20.00,0
>> Look for Rok'Alim the Pounder. He patrols a large portion of the north-western part of the zone
>> Be careful as this quest is HARD. Skip it if you need to
.complete 1151,1
.unitscan Rok'Alim the Pounder
.isOnQuest 1151
step
.goto Thousand Needles,31.50,36.70,30 >> Head to Darkcloud Pinnacle
step
.goto Thousand Needles,31.80,32.70
>> Loot the chest on top of the plataeu. Collect Secret Note #1
.complete 5064,1
step
.goto Thousand Needles,33.80,39.90
>> Loot the chest in the building. Collect Secret Note #2
.complete 5064,2
step
.goto Thousand Needles,39.20,41.60
>> Loot the chest in the building. Collect Secret Note #3
.complete 5064,3
step
>>Clear the mobs around the Bonfire. Light it, then kill Arikara. Loot her
>>Be careful as she is a level 28 elite, use scrolls/potions/cooldowns etc if you have them
.goto Thousand Needles,38.00,35.30
.complete 5088,2
.complete 5088,1
step
.goto Thousand Needles,38.00,26.80
>> Kill Arnak Grimtotem. Loot him for his Hoof
.complete 5147,1
step
.goto Thousand Needles,38.00,26.60
>> Start the escort quest
.target Lakota Windsong
>>Talk to |cRXP_FRIENDLY_Lakota Windsong|r
.accept 4904 >> Accept Free at Last
step
>>Escort Lakota. Whenever she reaches a new platform, 2 mobs will spawn - try and stay ahead of her to clear the platforms if you have respawns behind
>>Be careful as this quest is HARD. Don't be afraid to escape by running behind you and failing the escort
>>If you can't do it, abandon the quest
.goto Thousand Needles,30.98,37.08
.complete 4904,1 
step
.isQuestComplete 1151
.goto Thousand Needles,53.90,41.50
.target Dorn Plainstalker
>>Talk to |cRXP_FRIENDLY_Dorn Plainstalker|r
.turnin 1151 >> Turn in Test of Strength
step
.goto Thousand Needles,77.78,77.26
>> Talk to Kravel Koalbeard
.target Kravel Koalbeard
>>Talk to |cRXP_FRIENDLY_Kravel Koalbeard|r
.accept 1110 >> Accept Rocket Car Parts
.accept 1111 >> Accept Wharfmaster Dizzywig
step
.goto Thousand Needles,78.06,77.12
>> Talk with the Gnomes
.target Fizzle Brassbolts
>>Talk to |cRXP_FRIENDLY_Fizzle Brassbolts|r
.accept 1104 >> Accept Salt Flat Venom
.target Wizzle Brassbolts
>>Talk to |cRXP_FRIENDLY_Wizzle Brassbolts|r
.accept 1105 >> Accept Hardened Shells
step
.goto Thousand Needles,80.17,75.88
.target Pozzik
>>Talk to |cRXP_FRIENDLY_Pozzik|r
.accept 1176 >> Accept Load Lightening
step
.goto Thousand Needles,81.63,77.95
.target Trackmaster Zherin
>>Talk to |cRXP_FRIENDLY_Trackmaster Zherin|r
.accept 1175 >> Accept A Bump in the Road
step
.goto Tanaris,51.60,25.40
.fp Gadgetzan >> Get the Gadgetzan Flight Path
.fly Freewind >> Fly to Freewind Post
step
.goto Thousand Needles,45.70,50.80
.target Cliffwatcher Longhorn
>>Talk to |cRXP_FRIENDLY_Cliffwatcher Longhorn|r
.turnin 5064 >> Turn in Grimtotem Spying
.turnin 5147 >> Turn in Wanted - Arnak Grimtotem
step
.isQuestComplete 4904
.goto Thousand Needles,46.00,51.50
.target Thalia Amberhide
>>Talk to |cRXP_FRIENDLY_Thalia Amberhide|r
.turnin 4904 >> Turn in Free at Last
step
.goto Thousand Needles,46.65,48.36,30 >> Take the lift down from Freewind Post
step
.goto Thousand Needles,21.50,32.20
.target Motega Firemane
>>Talk to |cRXP_FRIENDLY_Motega Firemane|r
.turnin 5088 >> Turn in Arikara
step
.goto Thousand Needles,21.34,31.95
>>Talk to |cRXP_FRIENDLY_Kanati Greycloud|r
.turnin 4881 >>Turn in Assassination Plot
>>Accepting this quest will start an escort. 3 Mobs will attack at once
.target Kanati Greycloud
.accept 4966 >>Accept Protect Kanati Greycloud
step
.goto Thousand Needles,21.34,31.95
>>Kill the 3 mobs that spawn
.complete 4966,1 
.target Kanati Greycloud
>>Talk to |cRXP_FRIENDLY_Kanati Greycloud|r
.turnin 4966 >>Turn in Protect Kanati Greycloud
step
.goto Thousand Needles,25.60,45.60,0
.goto Thousand Needles,8.60,20.00,0
>> Look for Rok'Alim the Pounder. He patrols a large portion of the north-western part of the zone
>> Be careful as this quest is HARD. Skip it if you need to
.complete 1151,1
.unitscan Rok'Alim the Pounder
.isOnQuest 1151
step
#softcore
.goto Feralas,88.97,41.13
.zone Feralas >> Run North-West into Feralas
step
#softcore
.goto Feralas,75.40,44.40
.deathskip >> Once your zone changes to Feralas, pull a high level mob. Die and Respawn in Camp Mojache
step
#hardcore
.goto Feralas,75.40,44.40
>> Follow the road to Camp Mojache. Be careful of the high level mobs
.fp Camp Mojache >> Get the Camp Mojache Flight Path
.fly Crossroads >> Fly to Crossroads
step
#softcore
.goto Feralas,75.40,44.40
.fp Camp Mojache >> Get the Camp Mojache Flight Path
.fly Crossroads >> Fly to Crossroads
step
.goto The Barrens,51.10,29.60
.target Korran
>>Talk to |cRXP_FRIENDLY_Korran|r
.accept 1145 >> Accept The Swarm Grows
step
.goto The Barrens,51.5,30.3
.fly Ratchet >> Fly to Ratchet
step
.goto The Barrens,63.30,38.40
>>Talk to |cRXP_FRIENDLY_Wharfmaster Dizzywig|r
.turnin 1111 >> Turn in Wharfmaster Dizzywig
.target Wharfmaster Dizzywig
.accept 1112 >> Accept Parts for Kravel
step << Shaman
.goto The Barrens,65.8,43.8
>>Talk to |cRXP_FRIENDLY_Islen Waterseer|r
.turnin 220 >>Turn in Call of Water
.target Islen Waterseer
.accept 63 >>Accept Call of Water
step << Shaman
>>Speak to Islen again and make sure you have a Water Sapta with you
.collect 6637,1
step << !Mage
.goto The Barrens,63.1,37.1
.fly Orgrimmar >> Fly to Orgrimmar
step << Mage
.zone Orgrimmar >> Teleport to Orgrimmar
step << Mage
.goto Orgrimmar,38.8,85.6
.trainer >> Go and train your class spells
step << Shaman
.goto Orgrimmar,38.6,36.0
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,66.046,18.526
.trainer >> Go and train your class spells
>>Save at least 1 Gold 88 Silver for later
step << Hunter
.goto Orgrimmar,66.3,14.8
.trainer >> Go and train your pet spells
>>Save at least 1 Gold 88 Silver for later
step << Hunter
.goto Orgrimmar,81.62,19.59
.train 197 >> Train 2h Axes from Hanashi
step
.target Nogg
>>Talk to |cRXP_FRIENDLY_Nogg|r
.accept 2841 >>Accept Rig Wars
.goto Orgrimmar,76.1,25.2
.target Sovik
>>Talk to |cRXP_FRIENDLY_Sovik|r
.accept 2842 >>Accept Chief Engineer Scooty
.goto Orgrimmar,75.3,25.2
>>Speak with Sovik and go through his dialogue to accept this quest
>>In order to accept the 2nd quest you are required to have Rig Wars in your quest log
step
#sticky
.abandon 2841 >> Abandon Rig Wars
.target Sovik
>>Talk to |cRXP_FRIENDLY_Sovik|r
.accept 2842 >>Make sure you have Chief Engineer Scooty in your quest log before abandoning Rig Wars
step
.goto Orgrimmar,75.00,34.10
>>Talk to |cRXP_FRIENDLY_Belgrom Rockmaul|r
.turnin 1145 >> Turn in The Swarm Grows
.target Belgrom Rockmaul
.accept 1146 >> Accept The Swarm Grows
step << Warrior
.goto Orgrimmar,79.7,31.4
.trainer >> Go and train your class spells
.target Wu Shen
.target Kelv Sternhammer
.target Baltus Fowler
.target Sorek
.target Torm Ragetotem
>>Talk to |cRXP_FRIENDLY_Torm Ragetotem|r




.accept 1718 >> Accept The Islander
step << Rogue
.goto Orgrimmar,44.0,54.6
.trainer >> Go and train your class spells
step << Warlock
.goto Orgrimmar,48.0,46.0
.trainer >> Go and train your class spells
step << Warlock
.goto Orgrimmar,47.5,46.7
.vendor >> Buy your pet spellbooks if you have the money for it.
step << Mage
.goto Orgrimmar,45.44,56.54
.vendor >> Go to Horthus. Buy two Runes of Teleportation (or more if you want)
.collect 17031,2 
step
.goto Orgrimmar,44.70,52.00
.target Craven Drok
>>Talk to |cRXP_FRIENDLY_Craven Drok|r
.accept 1431 >> Accept Alliance Relations
step << Priest
.goto Orgrimmar,44.8,48.8
>> Go into the Cleft of Shadow and talk to Katis. Buy the Pestilent Wand. Equip it
.collect 5347,1
step << Priest
.goto Orgrimmar,35.6,87.8
.trainer >> Go and train your class spells
step
>>Run to the western exit of Orgrimmar
.goto Orgrimmar,22.50,52.60
>>Talk to |cRXP_FRIENDLY_Keldran|r
.turnin 1431 >> Turn in Alliance Relations
.target Keldran
.accept 1432 >> Accept Alliance Relations
step << Warrior
.goto Orgrimmar,45.14,63.89
.fly Ratchet >> Fly to Ratchet
step << Warrior
>>Run (not swim) to Fray Island
.goto The Barrens,65.09,47.81,90,0
.goto The Barrens,68.61,49.16
>>Talk to |cRXP_FRIENDLY_Klannoc Macleod|r
.turnin 1718 >>Turn in The Islander
.target Klannoc Macleod
.accept 1719 >>Accept The Affray
step << Warrior
>>Step onto the grate behind you. Quickly kill the challengers that come, then kill Big Will
.goto The Barrens,68.59,48.76
.complete 1719,1 
.complete 1719,2 
step << Warrior
>>This will teach you Berserker Stance
.goto The Barrens,68.62,49.16
>>Talk to |cRXP_FRIENDLY_Klannoc Macleod|r
.turnin 1719 >>Turn in The Affray
.target Klannoc Macleod
.accept 1791 >>Accept The Windwatcher
step << Warrior
>>Run back to Ratchet
.goto The Barrens,65.09,47.81,90,0
.goto The Barrens,63.08,37.16
.fly Orgrimmar >> Fly to Orgrimmar
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 30-40
#classic
<< Horde
#name 30-33 Hillsbrad/Arathi
#next 33-34 Shimmering Flats
#somname 30-32 Hillsbrad/Arathi
step << Mage
.zone Undercity >> Teleport to Undercity
step << Mage
.goto Undercity,82.79,15.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hannah Akeley|r
.vendor >> |cRXP_BUY_Buy at least two|r |T134419:0|t[Rune of Teleportation]
.collect 17031,2 
.target Hannah Akeley
step << !Mage
#completewith next
.goto Durotar,50.8,13.8
+Go to the Zeppelin tower, then take the Zeppelin to Undercity
step << !Mage
.zone Tirisfal Glades >>Arrive in Tirisfal Glades
step << Hunter
.goto Undercity,57.31,32.77
>>Talk to |cRXP_FRIENDLY_Archibald|r
.train 5011 >> Train Crossbows
.train 202 >> Train Two-Handed Swords
.target Archibald
step << Hunter
#som
.goto Undercity,58.82,32.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Benijah Fenner|r
.vendor >>|cRXP_BUY_Buy a|r |T134402:0|t[Heavy Quiver] |cRXP_BUY_and a|r |T135532:0|t[Heavy Crossbow] |cRXP_BUY_,then fill your new quiver with arrows|r
.collect 7371,1 
.collect 15809,1 
.target Benijah Fenner


step << Hunter
#era
.goto Undercity,58.82,32.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Benijah Fenner|r
.vendor >>|cRXP_BUY_Buy a|r |T134402:0|t[Heavy Quiver] |cRXP_BUY_and a|r |T135532:0|t[Heavy Crossbow] |cRXP_BUY_,then fill your new quiver with arrows|r
.collect 7371,1 
.collect 15809,1 
.target Benijah Fenner
step << Rogue
#sticky
#completewith next
.goto Undercity,58.65,33.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geoffrey Hartwell|r
.vendor >> |cRXP_BUY_Buy a|r |T135275:0|t[Broadsword] |cRXP_BUY_if it is better than your current weapon.|r
.collect 2520,1 
step
.goto Undercity,64.20,49.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Genavie Callow|r
.accept 1164 >> Accept To Steal From Thieves
.target Genavie Callow
step
.goto Undercity,62.14,44.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Eunice Burch|r
.train 2550 >> Train Cooking for a quest later
.target Eunice Burch
step
#era/som
.goto Undercity,62.30,43.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ronald Burch|r
.vendor >> |cRXP_BUY_Buy|r |T134059:0|t[Soothing Spices]
.collect 3713,1 
.target Ronald Burch
step << !Undead !Rogue
.goto Undercity,63.25,48.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael Garrett|r
.fp Undercity >> Get the Undercity Flight Path
.target Michael Garrett
step
#completewith next
.goto Undercity,63.25,48.58
.fly Tarren Mill >> Fly to Tarren Mill, or walk if you don't have the flight path << !Shaman
.fly Sepulcher >> Fly to The Sepulcher << Shaman
.target Michael Garrett
.zoneskip Hillsbrad Foothills
step << Shaman
#completewith next
.goto Silverpine Forest,42.03,40.66,10 >> Jump up the side of the tree here
step << Shaman
.goto Silverpine Forest,41.6,41.8,15,0
.goto Silverpine Forest,41.6,41.8,15,0
.goto Silverpine Forest,40.3,42.1,15,0
.goto Silverpine Forest,38.9,43.3,20 >>Run down the mountain
step << Shaman
>>Drink the water sapta, then kill the |cRXP_LOOT_Corrupt Minor Manifestion of Water|r and loot the |T132608:0|t[Corrupt Manifestation's Bracers]
.goto Silverpine Forest,38.78,44.25
.complete 63,1 
.unitscan Corrupt Minor Manifestation of Water
step << Shaman
.goto Silverpine Forest,38.26,44.56
>>Click the |cRXP_PICK_Brazier of Everfount|r
.turnin 63 >>Turn in Call of Water
.accept 100 >>Accept Call of Water
step << Shaman
.goto Silverpine Forest,38.78,44.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Minor Manifestation of Water|r
*It will appear after a few seconds of roleplay
.turnin 100 >>Turn in Call of Water
.accept 96 >>Accept Call of Water
.target Minor Manifestation of Water
step << Shaman
.goto Silverpine Forest,45.62,42.59
.fly Tarren Mill >> Fly to Tarren Mill
.target Karos Razok
step
.goto Hillsbrad Foothills,61.86,19.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tallow|r
.accept 676 >> Accept The Hammer May Fall
.target Tallow
step
.goto Hillsbrad Foothills,62.4,20.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 529 >> Turn in Battle of Hillsbrad
.accept 532 >> Accept Battle of Hillsbrad
.target High Executor Darthalia
.isQuestTurnedIn 528

step
.goto Hillsbrad Foothills,63.24,20.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krusk|r
.accept 533 >> Accept Infiltration
.target Krusk
step
.goto Hillsbrad Foothills,63.88,19.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Novice Thaivand|r
.accept 552 >> Accept Helcular's Revenge
.target Novice Thaivand
step << !Warrior
#era
>>Travel north up the river, killing |cRXP_LOOT_Snapjaws|r and looting their |T134026:0|t[Turtle Meat]
.goto Hillsbrad Foothills,61.97,42.80,100,0
.goto Hillsbrad Foothills,66.95,37.54,100,0
.goto Hillsbrad Foothills,70.15,11.79
.collect 3712,10 
.mob Snapjaw
step << Warrior
#era
#completewith next
>>Travel north up the river, killing |cRXP_LOOT_Snapjaws|r and looting their |T134026:0|t[Turtle Meat]
.collect 3712,10 
.mob Snapjaw
step << Warrior
.goto Alterac Mountains,80.497,66.919
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bath'rah the Windwatcher|r
.turnin 1791 >>Turn in The Windwatcher
.accept 1712 >>Accept Cyclonian
.target Bath'rah the Windwatcher
step << Warrior
#era
>>Travel south down the river, killing |cRXP_LOOT_Snapjaws|r and looting their |T134026:0|t[Turtle Meat]
.goto Hillsbrad Foothills,70.15,11.79,100,0
.goto Hillsbrad Foothills,66.95,37.54,100,0
.goto Hillsbrad Foothills,61.97,42.80
.collect 3712,10 
step
#era
.goto Hillsbrad Foothills,62.28,19.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Christoph Jeffcoat|r inside the inn
.accept 7321 >> Accept Soothing Turtle Bisque
.turnin 7321 >> Turn in Soothing Turtle Bisque
.target Christoph Jeffcoat
step
#completewith next
.goto Hillsbrad Foothills,62.76,19.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock food and water if necessary|r
.target Innkeeper Shay
step
.goto Hillsbrad Foothills,61.56,20.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keeper Bel'varil|r
.accept 556 >> Accept Stone Tokens
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Magus Wordeen Voidglare|r
.accept 544 >> Accept Prison Break In
.target Keeper Bel'varil
.target Magus Wordeen Voidglare
step
.goto Hillsbrad Foothills,47.9,31.5,60,0
.goto Hillsbrad Foothills,46.1,33.2,60,0
.goto Hillsbrad Foothills,43.5,27.3,60,0
.goto Hillsbrad Foothills,43.9,30.2,60,0
.goto Hillsbrad Foothills,41.8,30.6,60,0
.goto Hillsbrad Foothills,43.6,24.9,60,0
.goto Hillsbrad Foothills,47.9,31.5
>>Kill |cRXP_LOOT_Cave Yetis|r in and around the cave at Darrow Hill, then loot |T135471:0|t[Helcular's Rod].
*|cRXP_WARN_This quest item has a fairly low drop rate|r
.complete 552,1 
step
#completewith next
#label Council
.goto Hillsbrad Foothills,29.63,42.33
>>Kill |cRXP_ENEMY_Hillsbrad Councilmen|r
*Be careful of their Frost Nova and Frostbolt
.complete 532,2 
.mob Hillsbrad Councilman
.isQuestTurnedIn 528
step
>>Kill |cRXP_ENEMY_Magistrate Burnside|r inside Hillsbrad Town Hall, then loot the |T133740:0|t[Hillsbrad Town Registry] and burn the |cRXP_PICK_Hillsbrad Proclamation|r
.goto Hillsbrad Foothills,29.67,41.64
.complete 532,1 
.goto Hillsbrad Foothills,29.52,41.53
.complete 532,4 
.goto Hillsbrad Foothills,29.73,41.75
.complete 532,3 
.isQuestTurnedIn 528
step
.goto Hillsbrad Foothills,29.63,42.33
>>Finish killing |cRXP_ENEMY_Hillsbrad Councilmen|r
*Be careful of their Frost Nova and Frostbolt
.complete 532,2 
.mob Hillsbrad Councilman
.isQuestTurnedIn 528
step
#completewith next
.goto Hillsbrad Foothills,61.63,21.75,125
>>Return to Tarren Mill
step
#requires Council
.goto Hillsbrad Foothills,62.3,20.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r
.turnin 532 >> Turn in Battle of Hillsbrad
.accept 539 >> Accept Battle of Hillsbrad
.target High Executor Darthalia
.isQuestTurnedIn 528
step
#softcore
.goto Hillsbrad Foothills,63.88,19.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thaivand|r
.turnin 552 >> Turn in Helcular's Revenge
.accept 553 >> Accept Helcular's Revenge
.target Novice Thaivand
step
#hardcore
.goto Hillsbrad Foothills,63.88,19.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Novice Thaivand|r
.turnin 552 >> Turn in Helcular's Revenge
.target Novice Thaivand
step << Hunter
#completewith next
.goto Hillsbrad Foothills,62.55,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kayren Soothallow|r
.vendor >> |cRXP_BUY_Fill your quiver with arrows|r
.target Kayren Soothallow
step
.goto Hillsbrad Foothills,62.76,19.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock food and water if necessary|r
.target Innkeeper Shay
step
#completewith Bonds
>>Kill |cRXP_LOOT_all Hillsbrad villagers|r, then loot their |T133730:0|t[Hillsbrad Human Skull]
.complete 546,1 
.mob Hillsbrad Miner
.mob Hillsbrad Farmer
.mob Hillsbrad Peasant
.mob Hillsbrad Apprentice Blacksmith
.mob Hillsbrad Farmhand
.mob Hillsbrad Farmer
.mob Hillsbrad Tailor
.mob Hillsbrad Footman
.mob Hillsbrad Citizen
.mob Hillsbrad Sentry
.mob Hillsbrad Councilman
.mob Hillsbrad Foreman
.mob Farmer Kalaba
.mob Miner Hackett
.mob Foreman Bonds
.mob Citizen Wilkes
.mob Clerk Horrace Whitesteed
.mob Magistrate Burnside
.isOnQuest 546
step
.goto Hillsbrad Foothills,26.95,59.55,100 >> Run to Azurelode Mine
.isOnQuest 546
step
#sticky
#label Hackett
.goto Hillsbrad Foothills,31.8,52.5,60,0
.goto Hillsbrad Foothills,29.7,55.7,60,0
.goto Hillsbrad Foothills,31.1,58.6,60,0
.goto Hillsbrad Foothills,31.8,52.5,60,0
.goto Hillsbrad Foothills,29.7,55.7,60,0
.goto Hillsbrad Foothills,31.1,58.6,60,0
.goto Hillsbrad Foothills,31.8,52.5,60,0
.goto Hillsbrad Foothills,29.7,55.7,60,0
.goto Hillsbrad Foothills,31.1,58.6,60,0
.goto Hillsbrad Foothills,31.8,52.5
>>Kill |cRXP_ENEMY_Miner Hackett|r
.complete 567,3 
.unitscan Miner Hackett
.isQuestTurnedIn 528
step
#label Bonds
>>Kill |cRXP_ENEMY_Foreman Bonds|r in the center of the mine's lowest floor
.goto Hillsbrad Foothills,31.2,56.0
.complete 539,1 
.complete 539,2 
.isQuestTurnedIn 528
step
#requires Hackett
.goto Hillsbrad Foothills,29.9,55.6
>>Finish killing |cRXP_LOOT_Hillsbrad villagers|r, and looting their |T133730:0|t[Hillsbrad Human Skull]
*|cRXP_WARN_Are we the baddies..?|r
.complete 546,1 
.mob Hillsbrad Miner
.mob Hillsbrad Farmer
.mob Hillsbrad Peasant
.mob Hillsbrad Apprentice Blacksmith
.mob Hillsbrad Farmhand
.mob Hillsbrad Farmer
.mob Hillsbrad Tailor
.mob Hillsbrad Footman
.mob Hillsbrad Citizen
.mob Hillsbrad Sentry
.mob Hillsbrad Councilman
.mob Hillsbrad Foreman
.mob Farmer Kalaba
.mob Miner Hackett
.mob Foreman Bonds
.mob Citizen Wilkes
.mob Clerk Horrace Whitesteed
.mob Magistrate Burnside
.isQuestTurnedIn 528
step
#era
.goto Hillsbrad Foothills,29.8,55.0
.xp 32 >> Grind to 32 in Azurelode Mine. Return to Tarren Mill if you need to restock
step
#som
#phase 1-2
.goto Hillsbrad Foothills,29.8,55.0
.xp 31 >> Grind to 31 in the Mine. Return to Tarren Mill if you need to restock
step
#hardcore
#completewith next
+This next quest can be quite hard, be extra careful
step
#completewith Stonetoken
>>Kill |cRXP_LOOT_all Dalaran mobs|r, then loot their |T134414:0|t[Worn Stone Tokens]
.mob Dalaran Shield Guard
.mob Dalaran Theurgist
.mob Dalaran Worker
.mob Warden Belamoore
.mob Dalaran Summoner
.complete 556,1 
step
.goto Alterac Mountains,20.2,86.3
>>Kill |cRXP_LOOT_Alina|r, then loot her |T134084:0|t[Bloodstone Shard]
.complete 544,3 
>>Kill |cRXP_LOOT_Dermot|r, then loot his |T134128:0|t[Bloodstone Wedge]
.complete 544,1 
step
.goto Alterac Mountains,19.7,84.6
>>Go outside and kill |cRXP_LOOT_Ricter|r, then loot his |T134085:0|t[Bloodstone Marble]
.complete 544,2 
step
#label Stonetoken
.goto Alterac Mountains,18.6,84.4,15,0
.goto Alterac Mountains,17.8,83.2
>>Go into the second floor of the west building, then kill |cRXP_LOOT_Kegan Darkmar|r and loot the |T134086:0|t[Bloodstone Oval]
.complete 544,4 
step
.goto Alterac Mountains,20.1,86.2,90,0
.goto Alterac Mountains,17.9,83.0,90,0
.goto Alterac Mountains,10.7,76.6,90,0
.goto Alterac Mountains,19.4,75.6,90,0
.goto Alterac Mountains,20.1,86.2,90,0
.goto Alterac Mountains,17.9,83.0,90,0
.goto Alterac Mountains,10.7,76.6,90,0
.goto Alterac Mountains,19.4,75.6
>>Finish killing |cRXP_LOOT_all Dalaran mobs|r and looting their |T134414:0|t[Worn Stone Tokens]
.mob Dalaran Shield Guard
.mob Dalaran Theurgist
.mob Dalaran Worker
.mob Warden Belamoore
.mob Dalaran Summoner
.complete 556,1 
step << Hunter
#completewith Frostmaw
.goto Alterac Mountains,29.12,77.98,30,0
.goto Alterac Mountains,30.69,82.31,30,0
.goto Alterac Mountains,30.48,87.06,30,0
.goto Alterac Mountains,35.35,82.68,30,0
.goto Alterac Mountains,42.83,82.98,30,0
.goto Alterac Mountains,41.83,76.57
>>Head northeast. Kill a Mountain Lion, then loot its |T134368:0|t[Fresh Carcass]
.collect 5810,1 
step
#softcore
.goto Alterac Mountains,37.54,66.24
>>Enter the Growless Cave, then click the Flame of Uzel
.complete 553,3 
step << Hunter
#label Frostmaw
.goto Alterac Mountains,37.54,66.24
>>Summon |cRXP_LOOT_Frostmaw|r by placing the |T134368:0|t[Fresh Carcass] on top of the flame, then kill him and loot |T134356:0|t[Frostmaw's Mane]
*|cRXP_WARN_Frostmaw is level 37. Clear a kiting path before summoning him. If you don't need the helm upgrade, wait until level 39 to do this quest.|r
.complete 1136,1 
step
#softcore
.goto Hillsbrad Foothills,46.22,31.86,30,0
.goto Hillsbrad Foothills,43.89,28.06
>>Return to the Darrow Hill cave, then click the Flame of Azel
.complete 553,1 
step
#softcore
.goto Hillsbrad Foothills,44.7,28.6,20,0
.goto Hillsbrad Foothills,44.2,26.7
>>Drop down to the lower floor, and go through the north side of the cave. Charge the flame
.complete 553,2 
step
>>Kill |cRXP_LOOT_Syndicate members|r, then loot the |T133472:0|t[Syndicate Missive].
.goto Alterac Mountains,47.7,81.7,90,0
.goto Alterac Mountains,58.4,67.7,90,0
.goto Alterac Mountains,47.7,81.7,90,0
.goto Alterac Mountains,58.4,67.7,90,0
.goto Alterac Mountains,47.7,81.7
.complete 533,1 
step
.goto Hillsbrad Foothills,61.498,20.933
>>Return to |cRXP_FRIENDLY_Magus Wordeen|r
.turnin 544 >> Turn in Prison Break In
>>Return to |cRXP_FRIENDLY_Bel'varil|r
.turnin 556 >> Turn in Stone Tokens
.target Magus Wordeen Voidglare
.target Keeper Bel'varil
step
.goto Hillsbrad Foothills,62.11,19.67
>>Return to |cRXP_FRIENDLY_Samsa|r
.turnin 546 >> Turn in Souvenirs of Death
.target Deathguard Samsa
.isQuestComplete 546
step
.goto Hillsbrad Foothills,62.3,20.3
>>Return to |cRXP_FRIENDLY_Darthalia|r
.turnin 539 >> Turn in Battle of Hillsbrad
.target High Executor Darthalia
.isQuestComplete 539
step
.goto Hillsbrad Foothills,62.3,20.3
>>Return to |cRXP_FRIENDLY_Darthalia|r
.turnin 567 >> Turn in Dangerous!
.target High Executor Darthalia
.isQuestComplete 567
step
.goto Hillsbrad Foothills,63.3,20.7
>>Return to |cRXP_FRIENDLY_Krusk|r
.turnin 533 >> Turn in Infiltration
.target Krusk
step << Hunter
.goto Hillsbrad Foothills,62.55,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kayren|r
.vendor >> |cRXP_BUY_Fill your quiver with arrows|r
.target Kayren Soothallow
step
.goto Hillsbrad Foothills,62.79,19.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock food and water if necessary|r
.target Innkeeper Shay
step
.goto Hillsbrad Foothills,61.44,19.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Apothecary Lydon|r
.accept 509 >> Accept Elixir of Agony
.target Apothecary Lydon
step
#softcore
.goto Hillsbrad Foothills,52.9,53.4
.goto Hillsbrad Foothills,63.88,19.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Novice Thaivand|r
.turnin 553 >> Turn in Helcular's Revenge
.target Novice Thaivand
step
.goto Hillsbrad Foothills,64.7,61.4
>>Click the |cRXP_PICK_white mushrooms|r around Nethander Stead, then loot their |T134531:0|t[Mudsnout Blossom]
.complete 509,1 
step
.goto Arathi Highlands,20.19,29.54
.zone Arathi Highlands >> Head to Arathi Highlands
step
.goto Hillsbrad Foothills,83.09,58.18,90,0
.goto Arathi Highlands,33.90,44.60
>>Kill |cRXP_ENEMY_Boulderfist Ogres|r and |cRXP_ENEMY_Boulderfist Enforcers|r in and around Boulder'gor
.mob Boulderfist Ogre
.mob Boulderfist Enforcer
.complete 676,1 
.complete 676,2 
step
.goto Arathi Highlands,54.20,38.20
>>Kill |cRXP_LOOT_Marcel|r, then loot |T134166:0|t[Marcel's Head]
*|cRXP_WARN_Marcel uses Shield Wall after a few seconds|r
.complete 1164,2 
step << Rogue/Warrior/Shaman
#hardcore
#completewith next
+|cRXP_WARN_This next step can be quite hard. Be very careful|r
step
.goto Arathi Highlands,56.40,36.10
>>Kill |cRXP_LOOT_Kenata|r, then loot |T134167:0|t[Kenata's Head]
.complete 1164,1 
step
.goto Arathi Highlands,56.50,38.70
>>Kill |cRXP_LOOT_Fardel|r, then loot |T134166:0|t[Fardel's Head]
*|cRXP_WARN_Be careful as he thrashes and has high-damage poison|r
.complete 1164,3 
step
.goto Arathi Highlands,62.50,33.80
>>Talk to the |cRXP_PICK_Shards of Myzrael|r
.accept 642 >> Accept The Princess Trapped
step
.goto Arathi Highlands,73.10,32.70
>>Travel to Hammerfall, then talk to |cRXP_FRIENDLY_Urda|r
.fp Hammerfall >> Get the Hammerfall flight path
.target Urda
step
.goto Arathi Highlands,74.20,33.90
>>Talk to |cRXP_FRIENDLY_Drum Fel|r
.turnin 676 >> Turn in The Hammer May Fall
.accept 677 >> Accept Call to Arms
.target Drum Fel
step
.goto Arathi Highlands,72.90,34.20
>>Talk to |cRXP_FRIENDLY_Gor'mul|r
.accept 655 >> Accept Hammerfall
.target Gor'mul
step
.goto Arathi Highlands,74.60,36.30
>>Talk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 655 >> Turn in Hammerfall
.accept 672 >> Accept Raising Spirits
.accept 671 >> Accept Foul Magics
.target Tor'gan
step
.goto Arathi Highlands,73.84,32.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Adegwa|r
.vendor >>|cRXP_BUY_Sell your junk, then restock food and water if necessary|r
.target Innkeeper Adegwa
step
#completewith next
+Keep an eye out for Nimar the Slayer (rare). He can drop really good BoEs
.unitscan Nimar the Slayer
step
#hardcore
#completewith next
+|cRXP_WARN_This next quest can be quite hard, be extra careful|r
step
.loop 40,Arathi Highlands,71.7,60.3,73.4,65.2,70.6,69.3,68.3,74.5,66.2,69.2,64.8,73.1,61.3,72.4,63.3,67.7,66.5,63.7,71.7,60.3
>>Travel southeast to Witherbark Village, then kill |cRXP_ENEMY_Witherbark Witch Doctors|r, |cRXP_ENEMY_Headhunters|r, and |cRXP_ENEMY_Axe Throwers|r
.complete 677,3 
.complete 677,2 
.complete 677,1 
.mob Witherbark Axe Thrower
.mob Witherbark Headhunter
.mob Witherbark Witch Doctor
step
#completewith xpgate
#label Raptorscomplete
>>Kill any |cRXP_LOOT_Highland Raptors|r that you encounter, then loot their |T133884:0|t[Highland Raptor Eye].
*|cRXP_WARN_Be careful of the Thrashers, as they actually thrash|r
.complete 672,1 
step
.loop 30,Arathi Highlands,34.07,28.35,33.36,26.41,31.79,26.47,30.83,27.49,31.01,29.58,32.32,30.87,33.36,30.72,34.07,28.35
>>Kill |cRXP_LOOT_Syndicate members|r, then loot their |T133292:0|t[Bloodstone Amulet] and |T132905:0|t[Silk Cloth]
.complete 671,1 
.collect 4306,15 
step
#era
#label xpgate
.goto Arathi Highlands,33.8,31.8
.xp 33>> Grind to level 33
step
#som
#phase 1-2
#label xpgate
.goto Arathi Highlands,33.8,31.8
.xp 32+10000 >> Grind to level 32 and 10000+/54500xp
step
#requires Raptorscomplete
.goto Arathi Highlands,74.24,33.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Drum|r
.turnin 677 >> Turn in Call to Arms
.target Drum Fel
step
.goto Arathi Highlands,74.72,36.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Tor'gan|r
.turnin 672 >> Turn in Raising Spirits
.accept 674 >> Accept Raising Spirits
.turnin 671 >> Turn in Foul Magics
.target Tor'gan
step
.goto Arathi Highlands,72.63,33.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Gor'mul|r
.turnin 674 >> Turn in Raising Spirits
.target Gor'mul
step
.goto Arathi Highlands,72.63,33.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gor'mul|r again
.accept 675 >> Accept Raising Spirits
.target Gor'mul
step
.goto Arathi Highlands,74.72,36.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Tor'gan|r
.turnin 675 >> Turn in Raising Spirits
.target Tor'gan
step
.goto Arathi Highlands,73.10,32.70
.fly Tarren Mill >> Fly to Tarren Mill
step
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Lydon|r
.turnin 509 >> Turn in Elixir of Agony
.accept 513 >> Accept Elixir of Agony
.target Apothecary Lydon
step
.goto Hillsbrad Foothills,60.14,18.63
.fly Undercity >> Fly to Undercity
step
.goto Undercity,63.83,49.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Genavie Callow|r
.turnin 1164 >> Turn In To Steal From Thieves
.target Genavie Callow
step
.goto Undercity,48.80,69.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Master Apothecary Faranell|r
.turnin 513 >> Turn in Elixir of Agony
.target Master Apothecary Faranell
step << Priest
.goto Undercity,49.26,17.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aelthalyste|r
.trainer >>Train your class spells
.target Aelthalyste
step << Warrior
.goto Undercity,46.95,15.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Christoph Walker|r
.trainer >>Train your class spells
.target Christoph Walker
step << Mage
.goto Undercity,85.01,14.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kaelystia Hatebringer|r
.trainer >>Train your class spells
.target Kaelystia Hatebringer
step << Warlock
.goto Undercity,86.22,15.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kaal Soulreaper|r
.trainer >>Train your class spells
.target Kaal Soulreaper
step << Rogue
.goto Undercity,85.21,71.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Miles Dexter|r
.trainer >>Train your class spells
.target Miles Dexter
step << Druid
.goto Moonglade,52.4,40.6
.cast 18960 >>Teleport to Moonglade
.trainer >> Train your class spells
step
.hs >> Hearth back to Freewind Post
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Abeqwa|r
.vendor >>|cRXP_BUY_Sell your junk, then restock food and water if necessary|r
.target Innkeeper Abeqwa
]])
RXPGuides.RegisterGuide([[
#version 8
#defaultfor Horde Mage
#group RestedXP Horde Mage AoE
#classic
<< Horde Mage
#name 30-36 Arathi/Alterac AoE
#next 36-60 Mage AoE
step
.goto Arathi Highlands,73.84,32.47
.home >> Set your Hearth to Hammerfall
step
.goto Arathi Highlands,73.02,32.70
.fp Hammerfall >> Get the Hammerfall Flight Path
step
.goto Arathi Highlands,72.77,33.67
.target Gor'mul
>>Talk to |cRXP_FRIENDLY_Gor'mul|r
.accept 655 >>Accept Hammerfall
step
.goto Arathi Highlands,74.71,36.29
>>Talk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 655 >>Turn in Hammerfall
.target Tor'gan
.accept 672 >>Accept Raising Spirits
.accept 671 >>Accept Foul Magics
step
#completewith next
>>AoE raptors en route to Dabyrie Farmstead. Loot them for their eyes
.complete 672,1 
step
.goto Arathi Highlands,55.25,39.86,150 >> Run to Dabyrie's Farmstead
step
#completewith next
+Try and avoid pulling the named mobs just yet if possible. Marcel has Shield Wall (75% reduced damage), Fardel has ranged poison+Thrash, Kenata does nothing
step
.xp 32 >> AoE the Dabyrie Farmstead to 32
>>Start saving the Wool Cloth and Silk Cloth you get. You need 12 stacks for later
step
>>AoE the named NPCs. Loot them for their heads
.goto Arathi Highlands,56.56,38.69
.complete 1164,3 
.goto Arathi Highlands,54.20,38.05
.complete 1164,2 
.goto Arathi Highlands,56.41,36.09
.complete 1164,1 

step
.zone Undercity >> Teleport to Undercity
step
.goto Undercity,85.14,10.03
.trainer >> Train your class spells
step
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy some Runes of Teleportation
.collect 17031,3 
step
#completewith next
.goto Undercity,65.97,44.73
+Bank your Wool Cloth and Silk Cloth here from earlier. You need 12 stacks of each (240) for later
step
.goto Undercity,63.82,49.37
.target Genavie Callow
>>Talk to |cRXP_FRIENDLY_Genavie Callow|r
.turnin 1164 >>Turn in To Steal From Thieves
step
.goto Undercity,53.00,77.48,40,0
.goto Undercity,48.82,69.28
.target Master Apothecary Faranell
>>Talk to |cRXP_FRIENDLY_Master Apothecary Faranell|r
.turnin 513 >>Turn in Elixir of Agony
step
.hs >> Hearth to Hammerfall
.vendor >> vendor trash
step
.goto Arathi Highlands,42.14,39.38
>>AoE raptors en route to Dabyrie Farmstead. Loot them for their eyes
.complete 672,1 
step
.goto Arathi Highlands,55.25,39.86,150 >> Run to Dabyrie's Farmstead
step
.xp 34 >> AoE the Dabyrie Farmstead to 34
>>Start saving the Wool Cloth and Silk Cloth you get. You need 12 stacks for later
step
>>Go in and around the cave. Start AoEing ogres
.goto Arathi Highlands,32.93,44.02
.complete 676,1 
.complete 676,2 
step
>>Start AoEing Syndicates in the area. Try and avoid the Pathstalkers. Be careful of misspulling stealthed mobs
.goto Arathi Highlands,32.32,28.58
.complete 671,1 
step
.zone Undercity >> Teleport to Undercity
step
.goto Undercity,85.14,10.03
.trainer >> Train your class spells
step
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy some Runes of Teleportation
.collect 17031,3 
step
#completewith next
.goto Undercity,65.97,44.73
+Bank your Wool Cloth and Silk Cloth here from earlier. You need 12 stacks of each (240) for later
step
.hs >> Hearth to Hammerfall
.vendor >> Buy level 35 drink from the Innkeeper once you hearthed
step
.goto Arathi Highlands,74.26,33.93
.target Drum Fel
>>Talk to |cRXP_FRIENDLY_Drum Fel|r
.turnin 676 >>Turn in The Hammer May Fall
step
.goto Arathi Highlands,74.72,36.29
>>Talk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 671 >>Turn in Foul Magics
.turnin 672 >>Turn in Raising Spirits
.target Tor'gan
.accept 674 >>Accept Raising Spirits
step
.goto Arathi Highlands,72.61,34.16
>>Talk to |cRXP_FRIENDLY_Gor'mul|r
.turnin 674 >>Turn in Raising Spirits
.target Gor'mul
.accept 675 >>Accept Raising Spirits
step
.goto Arathi Highlands,74.72,36.29
.target Tor'gan
>>Talk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 675 >>Turn in Raising Spirits

step
.goto Arathi Highlands,73.02,32.70
.fly Hillsbrad >> Fly to Tarren Mill
step
.home >> Set your Hearth to Tarren Mill
.goto Hillsbrad Foothills,62.78,19.03
step
#sticky
#completewith next
+It is HIGHLY recommended you watch the link, as it can be a bit tricky here
.link https://www.twitch.tv/videos/970330908?t=03h27m43s >>CLICK HERE
step
>>AoE Syndicates. Loot them for the Missive
.goto Alterac Mountains,58.35,67.49,120,0
.goto Alterac Mountains,47.65,82.22,120,0
.complete 533,1 
step
.goto Alterac Mountains,53.36,53.47,120,0
.goto Alterac Mountains,49.49,56.10,120,0
.goto Alterac Mountains,47.12,60.91,120,0
.goto Alterac Mountains,58.39,67.91,120,0
.goto Alterac Mountains,53.36,53.47,120,0
.goto Alterac Mountains,49.49,56.10,120,0
.goto Alterac Mountains,47.12,60.91,120,0
.goto Alterac Mountains,58.39,67.91,120,0
.xp 34+56000 >> AoE Ogres and Syndicate to 34 & 56000+/62800xp
>>Keep grinding until your hearth cooldown is <8 minutes
step
#completewith next
.goto Alterac Mountains,42.67,95.30,40 >> Go into the Yeti Cave
step
>>AoE Yetis. Loot them for the Rod
.goto Alterac Mountains,40.83,93.24
.complete 552,1 
step
#sticky
#completewith Stonetoken
>>AoE the Dalaran mobs. Loot them for Worn Stone Tokens
.complete 556,1 
step
>>Kill Alina. Loot her for the Shard. Kill Dermot, loot him for the Wedge
.goto Alterac Mountains,20.2,86.3
.complete 544,3 
.complete 544,1 
step
>>Go outside and kill Ricter. Loot him for the Marble
.goto Alterac Mountains,19.7,84.6
.complete 544,2 
step
#label Stonetoken
>>Go into the second floor of the other building. Kill Kegan Darkmar. Loot him for the Oval
.goto Alterac Mountains,18.6,84.4,15,0
.goto Alterac Mountains,17.8,83.2
.complete 544,4 
step
.goto Alterac Mountains,20.1,86.2,40,0
.goto Alterac Mountains,17.9,83.0,40,0
.goto Alterac Mountains,10.7,76.6,40,0
.goto Alterac Mountains,19.4,75.6,40,0
.goto Alterac Mountains,20.1,86.2,40,0
.goto Alterac Mountains,17.9,83.0,40,0
.goto Alterac Mountains,10.7,76.6,40,0
.goto Alterac Mountains,19.4,75.6,40,0
>>Kill the Dalaran mobs. Loot them for Worn Stone Tokens
.complete 556,1 
step
.goto Alterac Mountains,53.36,53.47,120,0
.goto Alterac Mountains,49.49,56.10,120,0
.goto Alterac Mountains,47.12,60.91,120,0
.goto Alterac Mountains,58.39,67.91,120,0
.goto Alterac Mountains,53.36,53.47,120,0
.goto Alterac Mountains,49.49,56.10,120,0
.goto Alterac Mountains,47.12,60.91,120,0
.goto Alterac Mountains,58.39,67.91,120,0
.xp 36 >> AoE Cats/Syndicates/Ogre mobs to level 36
>>Start saving the Silk Cloth you get. You need 12 stacks for later
step
.zone Undercity >> Teleport to Undercity
step
.goto Undercity,85.14,10.03
.trainer >> Train your class spells
>>Make sure you have at least 50s leftover
step
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy some Runes of Teleportation
.collect 17031,5 
step
#completewith next
.goto Undercity,65.97,44.73
+Bank your Silk Cloth here from earlier. You need 12 stacks of each (240) for later
step
.hs >> Hearth to Tarren Mill
.vendor >> Buy level 35 drink if needed
step
.goto Hillsbrad Foothills,61.50,20.94
>>Talk to |cRXP_FRIENDLY_Keeper Bel'varil|r
.turnin 556 >>Turn in Stone Tokens
>>Talk to |cRXP_FRIENDLY_Magus Wordeen Voidglare|r
.turnin 544 >>Turn in Prison Break In
.target Keeper Bel'varil
.accept 557 >>Accept Bracers of Binding
.target Magus Wordeen Voidglare
.accept 545 >>Accept Dalaran Patrols
step
.goto Hillsbrad Foothills,63.24,20.65
>>Talk to |cRXP_FRIENDLY_Krusk|r
.turnin 533 >>Turn in Infiltration
.target Krusk
.accept 503 >>Accept Gol'dir
step
.goto Hillsbrad Foothills,63.88,19.66
.target Novice Thaivand
>>Talk to |cRXP_FRIENDLY_Novice Thaivand|r
.turnin 552 >>Turn in Helcular's Revenge
step
>>Find and kill Jailor Borhuin. Loot him for the Rusted Iron Key
.goto Alterac Mountains,63.19,43.68,40,0
.goto Alterac Mountains,62.11,40.43,40,0
.goto Alterac Mountains,59.96,43.68,40,0
.complete 503,2 
.unitscan Jailor Borhuin
step
>>Go upstairs into the second floor of the inn
.goto Alterac Mountains,60.64,43.89
.complete 503,1 
>>Talk to |cRXP_FRIENDLY_Gol'dir|r
.turnin 503 >>Turn in Gol'dir
.target Gol'dir
.accept 506 >>Accept Blackmoore's Legacy
step
.goto Alterac Mountains,53.36,53.47,120,0
.goto Alterac Mountains,49.49,56.10,120,0
.goto Alterac Mountains,47.12,60.91,120,0
.goto Alterac Mountains,58.39,67.91,120,0
.goto Alterac Mountains,53.36,53.47,120,0
.goto Alterac Mountains,49.49,56.10,120,0
.goto Alterac Mountains,47.12,60.91,120,0
.goto Alterac Mountains,58.39,67.91,120,0
.xp 36+60000 >> Grind the Ogres and Syndicate to 36 & 60000+/71600xp
>>Keep grinding until your hearth cooldown is <8 minutes
step
>>AoE Cats/Syndicates/Ogres en route
>>Kill/AoE the dalaran mobs in the area
.goto Alterac Mountains,11.73,77.20,120,0
.goto Alterac Mountains,21.51,56.63,120,0
.goto Alterac Mountains,11.73,77.20
.complete 545,1 
.complete 545,2 
.complete 557,1 
step
.hs >> Hearth to Tarren Mill
.vendor >> Buy level 35 drink if needed
step
.goto Hillsbrad Foothills,62.29,19.04
.vendor >> Buy 3 Soothing Spices from Christoph on the first floor of the Inn
.collect 3713,3 
step
.goto Hillsbrad Foothills,63.24,20.66
.target Krusk
>>Talk to |cRXP_FRIENDLY_Krusk|r
.turnin 506 >>Turn in Blackmoore's Legacy
step
.goto Hillsbrad Foothills,61.50,20.94
.target Keeper Bel'varil
>>Talk to |cRXP_FRIENDLY_Keeper Bel'varil|r
.turnin 557 >>Turn in Bracers of Binding
.target Magus Wordeen Voidglare
>>Talk to |cRXP_FRIENDLY_Magus Wordeen Voidglare|r
.turnin 545 >>Turn in Dalaran Patrols
step
.zone Orgrimmar >> Teleport to Orgrimmar
step
.goto Orgrimmar,45.11,63.91
.fly Camp T >> Fly to Camp Taurajo
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 30-40
#classic
<< Horde
#name 33-34 Shimmering Flats
#next 34-35 Desolace
#somname 32-33 Shimmering Flats
step
.goto Thousand Needles,45.70,50.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cliffwatcher Longhorn|r
.accept 5361 >> Accept Family Tree
.target Cliffwatcher Longhorn
step << Hunter
.goto Thousand Needles,44.89,50.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Starn|r
.vendor >>|cRXP_BUY_Buy arrows until your quiver is full|r
.target Starn
step << Shaman
#sticky
#completewith next
.goto Thousand Needles,54.68,44.75,30
>> Run up the ramp here
step << Shaman
.goto Thousand Needles,53.54,42.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Prate Cloudseer|r
>>|cRXP_WARN_This turn-in grants a 40% movespeed, 30% attack speed buff for 1 hour|r
.turnin 1531 >>Turn in Call of Air
.target Prate Cloudseer
step
.goto Thousand Needles,53.94,41.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dorn Plainstalker|r
.turnin 1151 >> Turn in Test of Strength
.target Dorn Plainstalker
.isQuestComplete 1151
step
.goto Thousand Needles,67.58,63.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Moktar Krin|r
.turnin 1146 >> Turn in The Swarm Grows
.accept 1147 >> Accept The Swarm Grows
.target Moktar Krin
step
#sticky
#label CarParts
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel Koalbeard|r
.accept 1110 >> Accept Rocket Car Parts
.target Kravel Koalbeard
step
.goto Thousand Needles,77.79,77.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel Koalbeard|r again
.turnin 1112 >> Turn in Parts for Kravel
.target Kravel Koalbeard
step
#requires CarParts
.goto Thousand Needles,78.14,77.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wizzle Brassbolts|r
.accept 1105 >> Accept Hardened Shells
.target Wizzle Brassbolts
step
#sticky
#label SaltVenom
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzle Brassbolts|r
.accept 1104 >> Accept Salt Flat Venom
.target Fizzle Brassbolts
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Kravel Koalbeard|r
.accept 1114 >> Accept Delivery to the Gnomes
.goto Thousand Needles,77.79,77.26,10,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Fizzle Brassbolts|r
.turnin 1114 >> Turn in Delivery to the Gnomes
.accept 1115 >> Accept The Rumormonger
.goto Thousand Needles,78.06,77.13
.target Kravel Koalbeard
.target Fizzle Brassbolts
step
#requires SaltVenom
.goto Thousand Needles,80.18,75.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pozzik|r
.accept 1176 >> Accept Load Lightening
.target Pozzik
step
.goto Thousand Needles,81.64,77.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trackmaster Zherin|r
.accept 1175 >> Accept A Bump in the Road
.target Trackmaster Zherin
step
#completewith next
>>Collect the |T132997:0|t[Rocket Car Parts] around the Mirage Raceway
.complete 1110,1 
step
#completewith next
>>As you're roaming, kill any |cRXP_ENEMY_Saltstone Crystalhides|r
*|cRXP_WARN_Don't focus on this; you can finish it later|r
.complete 1175,2 
step
.goto Thousand Needles,78.4,89.1
>>Travel south to Tahonda Ruins' lake, and kill |cRXP_ENEMY_Saltstone Gazers|r
.complete 1175,3 
step
#sticky
#label Swarm
.loop 40,Thousand Needles,67.27,85.30,68.14,85.96,68.03,86.93,68.08,88.54,69.48,89.64,70.31,87.64,71.09,86.23,71.34,84.11,70.51,82.80,68.52,80.87,67.45,82.28,67.27,85.30
.complete 1147,3 
.complete 1147,1 
.complete 1147,2 
step
>>Grind the Silithid creatures until you get a |T135034:0|t[Cracked Silithid Carapace], then click it and accept its quest
.collect 5877,1,1148 
.accept 1148 >> Accept Parts of the Swarm
step
.goto Thousand Needles,67.8,85.7
>>Kill |cRXP_LOOT_Silithids|r, then loot their |T134339:0|t[Silithid Heart], |T134295:0|t[Silithid Talon], and |T135035:0|t[Intact Silithid Carapace]
.complete 1148,1 
.complete 1148,2 
.complete 1148,3 
.mob Silithid Searcher
.mob Silithid Hive Drone
.mob Silithid Invader
step
#label ShimmeringF
#requires Swarm
.loop 40,Thousand Needles,72.98,80.33,70.89,78.41,73.17,76.19,71.42,73.28,71.84,68.82,70.02,66.75,70.68,63.52,74.08,60.82,72.70,56.27,76.29,57.90,79.23,53.37,82.00,55.71,81.23,59.76,84.23,59.46,86.78,61.60,87.62,65.43,83.27,65.36,83.52,70.13,87.14,70.94,87.91,77.23,83.92,77.35,83.71,81.85,82.62,86.92,78.19,88.69,77.02,84.71,72.25,89.26,72.98,80.33
>>Circle the Mirage Raceway, looting |T132997:0|t[Rocket Car Parts] while killing and looting |cRXP_ENEMY_Scorpids|r, |cRXP_ENEMY_Saltstone Basilisks|r, |cRXP_ENEMY_Salt Flats Vultures|r, and |cRXP_ENEMY_Sparkleshell Tortoises|r
.complete 1175,2 
.complete 1175,1 
.complete 1176,1 
.complete 1105,1 
.complete 1104,1 
.complete 1110,1 
.mob Scorpid Terror
.mob Sparkleshell Snapper
.mob Saltstone Crystalhide
.mob Salt Flats Vulture
.mob Salt Flats Scavenger
.mob Scorpid Reaver
.mob Sparkleshell Tortoise
.mob Saltstone Basilisk
.mob Saltstone Gazer
.mob Sparkleshell Borer
step
.goto Thousand Needles,67.58,63.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Moktar|r
.turnin 1147 >> Turn in The Swarm Grows
.target Moktar Krin
step
.goto Thousand Needles,77.79,77.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Kravel|r
.turnin 1110 >> Turn in Rocket Car Parts
.accept 5762 >> Accept Hemet Nesingwary
.target Kravel Koalbeard
step
.goto Thousand Needles,78.10,77.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Fizzle Brassbolts|r
.turnin 1104 >> Turn in Salt Flat Venom
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Wizzle Brassbolts|r
.turnin 1105 >> Turn in Hardened Shells
.accept 1106 >> Accept Martek the Exiled
.target Fizzle Brassbolts
.target Wizzle Brassbolts
step
.goto Thousand Needles,80.18,75.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Pozzik|r
.turnin 1176 >> Turn in Load Lightening
.accept 1178 >> Accept Goblin Sponsorship
.target Pozzik
step
.goto Thousand Needles,81.63,77.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Zherin|r
.turnin 1175 >> Turn in A Bump in the Road
.target Trackmaster Zherin
step
.goto Tanaris,51.61,25.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek Ragefist|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.target Bulkrek Ragefist
step
.goto The Barrens,45.60,59.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Byula|r
.home >>Set your Hearthstone to Camp Taurajo
.target Innkeeper Byula
step
.goto The Barrens,44.45,59.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa Thunderhorn|r
.fly Crossroads >> Fly to The Crossroads
.target Omusa Thunderhorn
step
.goto The Barrens,51.10,29.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korran|r
.turnin 1148 >> Turn in Parts of the Swarm
.accept 1184 >> Accept Parts of the Swarm
.target Korran
step
.goto The Barrens,51.50,30.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Ratchet >> Fly to Ratchet
.target Devrak
step
.goto The Barrens,62.68,37.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zikkel|r
.bankdeposit 4306 >> Deposit 15 |T132905:0|t[Silk Cloth] into your bank:
+Silk Cloth (15)
.target Zikkel
step
.goto The Barrens,62.68,36.23
>>Talk to |cRXP_FRIENDLY_Gazlowe|r
.turnin 1178 >> Turn in Goblin Sponsorship
.accept 1180 >> Accept Goblin Sponsorship
.target Gazlowe
step << Shaman
.goto The Barrens,65.83,43.78
>>Talk to |cRXP_FRIENDLY_Islen Waterseer|r
.turnin 96 >>Turn in Call of Water
.target Islen Waterseer
step
.goto The Barrens,63.30,38.50
>>Talk to |cRXP_FRIENDLY_Wharfmaster Dizzywig|r
.turnin 1111 >> Turn in Wharfmaster Dizzywig

.target Wharfmaster Dizzywig
step
#completewith next
.goto The Barrens,63.74,38.66
.zone Stranglethorn Vale >> Take the boat to Stranglethorn Vale
step
.goto Stranglethorn Vale,27.60,77.48
>>Talk to |cRXP_FRIENDLY_Scooty|r
.turnin 2842 >>Turn in Chief Engineer Scooty
.target Scooty
step << skip
#softcore
.goto Stranglethorn Vale,27.60,77.48
>>Talk to |cRXP_FRIENDLY_Scooty|r
*|cRXP_WARN_Wait for roleplay|r
.accept 2843 >>Accept Gnomer-gooooone!
.target Scooty
step << skip
#softcore
.goto Stranglethorn Vale,27.60,77.48
>>Talk to |cRXP_FRIENDLY_Scooty|r
.turnin 2843 >>Turn in Gnomer-gooooone!

.target Scooty
step
#sticky
.abandon 2841 >> Abandon Rig Wars
step
.goto Stranglethorn Vale,26.30,73.50
>>Talk to |cRXP_FRIENDLY_Wharfmaster Lozgil|r
.turnin 1180 >> Turn in Goblin Sponsorship
.accept 1181 >> Accept Goblin Sponsorship
.target Wharfmaster Lozgil
step << Warrior/Shaman
#label Protection
#completewith BigStick
.goto Stranglethorn Vale,28.34,75.46
>>Talk to |cRXP_FRIENDLY_Zarena Cromwind|r
.vendor >> |cRXP_BUY_Buy|r |T135144:0|t[Staff of Protection] |cRXP_BUY_or|r |T135158:0|t[Big Stick] |cRXP_BUY_if either are in the shop,|r |cRXP_WARN_then manually skip this step|r
.collect 12252,1 
.collect 12251,1 
.target Zarena Cromwind
step << Warrior/Shaman
#label BigStick
#completewith Protection
.goto Stranglethorn Vale,28.34,75.46
>>Talk to |cRXP_FRIENDLY_Zarena Cromwind|r
.vendor >> |cRXP_BUY_Buy|r |T135144:0|t[Staff of Protection] |cRXP_BUY_or|r |T135158:0|t[Big Stick] |cRXP_BUY_if either are in the shop,|r |cRXP_WARN_then manually skip this step|r
.collect 12251,1 
.target Zarena Cromwind
step
#completewith next
.goto Stranglethorn Vale,27.04,77.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nixxrax Fillamug|r
.vendor >>|cRXP_BUY_Sell your junk, then restock food and water if necessary|r
.target Nixxrax Fillamug
step
#era
.goto Stranglethorn Vale,27.10,77.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tEnter the inn, then talk to |cRXP_FRIENDLY_Crank Fizzlebub|r
.accept 605 >> Accept Singing Blue Shards
.target Crank Fizzlebub
step << Rogue
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tClimb the inn's stairs to its second floor, cross the bridge over the bar, then turn left and talk to |cRXP_FRIENDLY_Ian Strom|r in the room at the end of the hall
.goto Stranglethorn Vale,26.8,77.2
.trainer >>Train your class spells
.target Ian Strom
step
.goto Stranglethorn Vale,26.99,77.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tClimb to the third floor of the inn, then talk to |cRXP_FRIENDLY_Krazek|r
.accept 201 >> Accept Investigate the Camp
.turnin 1115 >> Turn in The Rumormonger

>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kebok|r
.accept 189 >> Accept Bloodscalp Ears
.accept 213 >> Accept Hostile Takeover
.target Krazek
.target Kebok
step
.goto Stranglethorn Vale,27.20,76.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tExit to the third floor balcony, then talk to |cRXP_FRIENDLY_Baron Revilgaz|r
.turnin 1181 >> Turn in Goblin Sponsorship
.accept 1182 >> Accept Goblin Sponsorship
.target Baron Revilgaz
step
.goto Stranglethorn Vale,26.90,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFollow the small pathway around the balcony |cRXP_FRIENDLY_Fleet Master Seahorn|r is facing, then talk to |cRXP_FRIENDLY_Gringer|r
.fp Booty Bay >> Get the Booty Bay flight path
.target Gringer
step
.goto Stranglethorn Vale,28.30,77.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drizzlik|r
.accept 575 >> Accept Supply and Demand
.target Drizzlik
step
.hs >> Hearth back to Camp Taurajo
step
.goto The Barrens,44.45,59.15
.fly Thunder Bluff >> Fly to Thunder Bluff
step
.goto Thunder Bluff,45.81,64.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Pala|r
.home >>Set your Hearthstone to Thunder Bluff
.target Innkeeper Pala
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak Runetotem|r
.trainer >>Train your class spells
step << Hunter
.goto Thunder Bluff,61.54,80.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melor Stonehoof|r
.turnin 1136 >>Turn in Frostmaw
.target Melor Stonehoof
.isQuestComplete 1136
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek Thunderhorn|r
.trainer >>Train your class spells
.target Urek Thunderhorn
step << Hunter
.goto Thunder Bluff,54.08,84.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hesuwa Thunderhorn|r
.trainer >>Train your pet spells
.target Hesuwa Thunderhorn
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker Ragetotem|r
.trainer >>Train your class spells
step << Shaman
.goto Thunder Bluff,22.84,21.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor Skychaser|r
.trainer >>Train your class spells
.target Tigor Skychaser
step << Priest
.goto Thunder Bluff,24.56,22.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malakai Cross|r
.trainer >>Train your class spells
.target Malakai Cross
step << Mage
.goto Thunder Bluff,25.18,20.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thurston Xane|r
.trainer >>Train your class spells
.target Thurston Xane
step << Mage
.goto Thunder Bluff,22.50,16.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Birgitte Cranston|r
.trainer >>Train Portal: Thunder Bluff
.target Birgitte Cranston
step
.goto Thunder Bluff,47.00,49.83
.fly Sun Rock >> Fly to Stonetalon Mountains
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 30-40
#classic
<< Horde
#name 34-35 Desolace
#next 35-37 Northern Stranglethorn
#somname 33-35 Desolace
step
#era
.goto Stonetalon Mountains,46.00,60.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Braelyn Firehand|r
.turnin 1088 >> Turn in Ordanus
.target Braelyn Firehand
step
.goto Stonetalon Mountains,44.63,61.55,60,0
.goto Stonetalon Mountains,38.77,68.65,60,0
.goto Stonetalon Mountains,30.22,75.61,60,0
.goto Stonetalon Mountains,29.29,79.69
.zone Desolace >>Head southwest to the mountain path. Follow it into the Charred Vale. From there, turn south into Desolace.
step
.goto Desolace,55.80,30.10
>>Kill and loot members of the |cRXP_LOOT_Burning Blade|r until you get a |T134253:0|t[Flayed Demon Skin]
.accept 1480 >> Accept The Corrupter
.collect 20310,1,1480
.mob Burning Blade Augur
.mob Burning Blade Adept
.mob Burning Blade Reaver
.mob Burning Blade Felsworn
.mob Burning Blade Shadowmage
step
.goto Desolace,38.90,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Azore Aldamort|r
.accept 5741 >> Accept Sceptre of Light
.target Azore Aldamort
step
#era
.goto Desolace,56.20,59.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Felgur Twocuts|r
.accept 1365 >> Accept Khan Dez'hepah
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gurda Wildmane|r
.accept 1368 >> Accept Gelkis Alliance
.target Felgur Twocuts
.target Gurda Wildmane
step
#som
.goto Desolace,56.20,59.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Felgur Twocuts|r
.accept 1365 >> Accept Khan Dez'hepah
.target Felgur Twocuts
step
.goto Desolace,55.40,55.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nataka Longhorn|r
.turnin 5361 >> Turn in Family Tree
.target Nataka Longhorn
step
.goto Desolace,52.60,54.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Takata Steelblade|r
.turnin 1432 >> Turn in Alliance Relations
.accept 1433 >> Accept Alliance Relations
.accept 1434 >> Accept Befouled by Satyr
.target Takata Steelblade
step
.goto Desolace,52.20,53.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maurin Bonesplitter|r
.turnin 1433 >> Turn in Alliance Relations
.accept 1435 >> Accept The Burning of Spirits
.turnin 1480 >> Turn in The Corrupter
.accept 1481 >> Accept The Corrupter
.target Maurin Bonesplitter
step
.goto Desolace,73.20,41.80,60,0
.goto Desolace,73.00,46.80,60,0
.goto Desolace,74.80,48.80,60,0
.goto Desolace,73.20,41.80,0
.goto Desolace,73.00,46.80,0
.goto Desolace,74.80,48.80
>>Kill |cRXP_LOOT_Khan Dez'hepah|r, then loot |T134151:0|t[Khan Dez'hepah's Head]|r
*|cRXP_WARN_He has 3 different spawn locations|r
.complete 1365,1 
.unitscan Khan Dez'hepah
step
#sticky
#label shadowstalkers
.goto Desolace,76.70,19.40,0
>>Kill |cRXP_LOOT_Hatefury Shadowstalkers|r, then loot their |T134361:0|t[Shadowstalker Scalp]
.complete 1481,1 
step
.goto Desolace,76.70,19.40
>>Prioritize killing |cRXP_ENEMY_Hatefury Rogues|r while killing all |cRXP_ENEMY_Hatefury satyr|r
.complete 1434,1 
.complete 1434,2 
.complete 1434,3 
.complete 1434,4 
.unitscan Hatefury Rogue
step
#requires shadowstalkers
.goto Desolace,62.30,39.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bibbly F'utzbuckle|r
.accept 5501 >> Accept Bone Collector
.target Bibbly F'utzbuckle
step
.goto Desolace,52.60,54.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTravel to Ghost Walker Post, then talk to |cRXP_FRIENDLY_Takata Steelblade|r
.turnin 1434 >> Turn in Befouled by Satyr
.target Takata Steelblade
step
.goto Desolace,52.20,53.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maurin Bonesplitter|r
.turnin 1481 >> Turn in The Corrupter
.accept 1482 >> Accept The Corrupter
.target Maurin Bonesplitter
step
.goto Desolace,51.20,53.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harnor|r
.vendor >>|cRXP_BUY_Sell your junk, the restock food and water if necessary|r
.target Harnor
step
#era
.goto Desolace,56.20,59.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Felgur Twocuts|r
.turnin 1365 >> Turn in Khan Dez'hepah
.accept 1366 >> Accept Centaur Bounty
.target Felgur Twocuts
step
#som
.goto Desolace,56.20,59.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Felgur Twocuts|r
.turnin 1365 >> Turn in Khan Dez'hepah
.target Felgur Twocuts
step
.goto Desolace,60.80,61.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Smeed Scrabblescrew|r
.accept 5561 >> Accept Kodo Roundup
.target Smeed Scrabblescrew
step
#era
.goto Desolace,69.90,75.10
>>Kill |cRXP_LOOT_Magram Centaur|r, then loot their |T133855:0|t[Centaur Ear]
.complete 1366,1 
.mob Magram Outrunner
.mob Magram Scout
.mob Magram Stormer
.mob Magram Mauler
.mob Magram Marauder
.mob Magram Wrangler
.mob Magram Pack Runner
step
#era
.goto Desolace,69.90,75.10
>>Grind |cRXP_ENEMY_Magram Centaur|r until your reputation with the Gelkis Centaur is Friendly
.reputation 92,Friendly
step
#era
.goto Desolace,56.20,59.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Felgur Twocuts|r
.turnin 1366 >> Turn in Centaur Bounty
.target Felgur Twocuts
step
#completewith next
.goto Desolace,49.7,57.2,0
>>Click |cRXP_PICK_Kodo Bones|r around the Kodo Graveyard to loot |T133726:0|t[Kodo Bones].
*|cRXP_WARN_Be careful as mobs can spawn as soon as the cast resolves|r
*|cRXP_WARN_Be careful as mobs can spawn after the cast resolves. Immediately stealthing will often keep mobs from attacking you|r << Rogue/Druid
.complete 5501,1 
step
.goto Desolace,60.86,61.86,0
>>Use the |T132488:0|t[Kodo Kombobulator] on kodos, then escort them to |cRXP_FRIENDLY_Smeed|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Smeed|r after each trip to progress the quest
.complete 5561,1 
.target Smeed Scrabblescrew
step
.goto Desolace,49.7,57.2,0
>>Click |cRXP_PICK_Kodo Bones|r around the Kodo Graveyard to loot |T133726:0|t[Kodo Bones].
*|cRXP_WARN_Be careful as mobs can spawn as soon as the cast resolves|r
*|cRXP_WARN_Be careful as mobs can spawn after the cast resolves. Immediately stealthing will often keep mobs from attacking you|r << Rogue/Druid
.complete 5501,1 
step
.goto Desolace,60.80,61.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Smeed|r
.turnin 5561 >> Turn in Kodo Roundup
.target Smeed Scrabblescrew
step
#era
.goto Desolace,36.30,79.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uthek the Wise|r
.turnin 1368 >> Turn in Gelkis Alliance
.accept 1370 >> Accept Stealing Supplies
.target Uthek the Wise
step
.goto Desolace,25.80,68.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTravel to Shadowprey Village, then talk to |cRXP_FRIENDLY_Taiga Wisemane|r
.accept 5381 >> Accept Hand of Iruxos
.target Taiga Wisemane
step
.goto Desolace,22.70,72.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mai'Lahii|r
.accept 6142 >> Accept Clam Bait
.target Mai'Lahii
step
.goto Desolace,23.30,72.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drulzegar Skraghook|r
.accept 6143 >> Accept Other Fish to Fry
.target Drulzegar Skraghook
step
.goto Desolace,21.60,74.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thalon|r at the end of the dock
.fp Shadowprey Village >> Get the Shadowprey Village flight path
.target Thalon
step << Hunter
.goto Desolace,24.93,71.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tukk|r
.vendor >>|cRXP_BUY_Buy arrows until your quiver is full.|r
step
#som
.goto Desolace,73.33,47.94
.xp 34+17500 >> Grind to 34 and 17500+/62800
step
.goto Desolace,62.30,39.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bibbly F'utzbuckle|r
.turnin 5501 >> Turn in Bone Collector
.target Bibbly F'utzbuckle
step
#sticky
#label infused
>>Use the |T134095:0|t[Burning Gem] to kill |cRXP_ENEMY_members of the Burning Blade|r
.complete 1435,1 
.mob Burning Blade Augur
.mob Burning Blade Adept
.mob Burning Blade Reaver
.mob Burning Blade Felsworn
.mob Burning Blade Shadowmage
step
.goto Desolace,55.20,30.10
>>Kill the |cRXP_LOOT_Burning Blade Seer|r at the top of the tower, then loot the |T135161:0|t[Sceptre of Light]
.complete 5741,1 
step
.goto Desolace,54.95,26.65
>>Go into the larger building, then use the |T136248:0|t[Demon Pick] on the large red crystal
>> A level 37 demon will spawn. Kill it
.complete 5381,1 
step
#requires infused
.goto Desolace,38.90,27.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Azore|r
.turnin 5741 >> Turn in Sceptre of Light
.accept 6027 >> Accept Book of the Ancients
.target Azore Aldamort
step
.goto Desolace,36.07,30.40
>>Click |cRXP_PICK_Rackmore's Log|r, resting on a barrel
.accept 6161 >> Accept Claim Rackmore's Treasure!
step
#completewith Nagas
#label oracledeso
.goto Desolace,36.88,23.16,0
>>Kill |cRXP_LOOT_Slitherblade Oracles|r, then loot their |T134564:0|t[Oracle Crystal]
*|cRXP_WARN_Slitherblade Oracles share spawns with other naga; you may have to kill them|r
.complete 1482,1 
step
#sticky
#label desogoldenkey
.goto Desolace,36.88,23.16,0
>>Kill |cRXP_LOOT_Slitherblade Naga|r, then loot |T134238:0|t[Rackmore's Golden Key]
.complete 6161,2 
.mob Slitherblade Naga
.mob Slitherblade Warrior
.mob Slitherblade Sorceress
.mob Slitherblade Myrmidon
.mob Slitherblade Oracle
.mob Accursed Slitherblade
.mob Slitherblade Razortail
.mob Slitherblade Tidehunter
.mob Slitherblade Sea Witch
step
#sticky
#label clambait
.goto Desolace,33.09,29.79,0
>>Click |cRXP_PICK_Giant Softshell Clams|r, then loot their |T134007:0|t[Soft-shelled Clam Meat]
.complete 6142,1 
step
.goto Desolace,32.40,29.20
>>Kill |cRXP_LOOT_Drysnap Pincers|r and |cRXP_LOOT_Cralwers|r, then loot |T134237:0|t[Rackmore's Silver Key]
.complete 6161,1 
.mob Slitherblade Naga
.mob Slitherblade Warrior
.mob Slitherblade Sorceress
.mob Slitherblade Myrmidon
.mob Slitherblade Oracle
.mob Accursed Slitherblade
.mob Slitherblade Razortail
.mob Slitherblade Tidehunter
.mob Slitherblade Sea Witch
step
#completewith Rackmore
.loop 40,Desolace,32.41,23.00,34.99,21.73,36.86,20.16,39.13,18.74,40.44,20.40,37.70,20.85,36.64,23.40,34.67,24.12,32.41,23.00
>>Kill |cRXP_ENEMY_Slitherblade Naga|r, |cRXP_ENEMY_Myrmidons|r, and |cRXP_ENEMY_Sorceresses|r
.complete 6143,1 
.complete 6143,2 
.complete 6143,3 
.mob Slitherblade Myrmidon
.mob Slitherblade Naga
.mob Slitherblade Sorceress
step
.goto Desolace,30.00,8.80
>>Click |cRXP_PICK_Rackmore's Chest|r
.turnin 6161 >> Turn in Claim Rackmore's Treasure!
.isQuestComplete 6161
step
.goto Desolace,28.20,6.60
>>Click the |cRXP_PICK_Serpent Statue|r to summon |cRXP_LOOT_Lord Kragaru|r, then kill him and loot the |T133738:0|t[Book of the Ancients]
*|cRXP_WARN_Kill everything around the Serpent Statue|r
.complete 6027,1 
step
#label Rackmore
#requires desogoldenkey
.goto Desolace,30.00,8.80
>>Click |cRXP_PICK_Rackmore's Chest|r
.turnin 6161 >> Turn in Claim Rackmore's Treasure!
step
#label Nagas
.loop 40,Desolace,32.41,23.00,34.99,21.73,36.86,20.16,39.13,18.74,40.44,20.40,37.70,20.85,36.64,23.40,34.67,24.12,32.41,23.00
>>Kill |cRXP_ENEMY_Slitherblade Naga|r, |cRXP_ENEMY_Myrmidons|r, and |cRXP_ENEMY_Sorceresses|r
.complete 6143,1 
.complete 6143,2 
.complete 6143,3 
.mob Slitherblade Myrmidon
.mob Slitherblade Naga
.mob Slitherblade Sorceress
step
.goto Desolace,28.69,8.05
>>Kill |cRXP_LOOT_Slitherblade Oracles|r, then loot their |T134564:0|t[Oracle Crystal]
*|cRXP_WARN_Slitherblade Oracles share spawns with other naga; you may have to kill them|r
.complete 1482,1 
step
#requires clambait
.goto Desolace,38.88,27.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Azore|r
.turnin 6027 >> Turn in Book of the Ancients
.target Azore Aldamort
step
.goto Desolace,52.24,53.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Maurin|r
.turnin 1435 >> Turn in The Burning of Spirits
.turnin 1482 >> Turn in The Corrupter
.accept 1484 >> Accept The Corrupter
.target Maurin Bonesplitter
step
.goto Desolace,52.56,54.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Takata|r
.turnin 1484 >> Turn in The Corrupter
.accept 1436 >> Accept Alliance Relations
.target Takata Steelblade
step
#era
.goto Desolace,69.90,75.10
>>Click |cRXP_PICK_Sacks of Meat|r around Magram Village, then loot their |T133972:0|t[Crudely Dried Meat]
.complete 1370,1 
step
#era
.goto Desolace,36.21,79.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uthek the Wise|r
.turnin 1370 >> Turn in Stealing Supplies
.accept 1373 >> Accept Ongeku
.target Uthek the Wise
step << Hunter
.goto Desolace,24.90,68.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aboda|r
>>Stable your pet, tame a Scorpashi Lasher outside of town, then learn Claw 5
.target Aboda
step
.goto Desolace,25.10,72.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Roon Wildmane|r
.accept 5763 >> Accept Hunting in Stranglethorn
.target Roon Wildmane
step
.goto Desolace,25.80,68.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Taiga|r
.turnin 5381 >> Turn in Hand of Iruxos
.target Taiga Wisemane
step
.goto Desolace,23.40,72.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Drulzegar|r
.turnin 6143 >> Turn in Other Fish to Fry
.target Drulzegar Skraghook
step
.goto Desolace,22.70,72.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Mai'Lahii|r
.turnin 6142 >> Turn in Clam Bait
.target Mai'Lahii
step
.goto Desolace,42.78,70.12
.xp 35 >> Grind to 35
step << Druid
#completewith next
>> Use the spell Teleport to Moonglade
.goto Moonglade,52.526,40.565
.trainer >> Go and train your class spells
step
.hs >> Hearth back to Thunder Bluff
>> Buy food/water if needed
step << Warrior
#softcore
>>Go to the Auction House. Buy 8 Liferoot
.goto Thunder Bluff,40.42,51.74
.collect 3357,8
step
.goto Thunder Bluff,61.538,80.919
.target Melor Stonehoof
>>Talk to |cRXP_FRIENDLY_Melor Stonehoof|r
.accept 1136 >> Accept Frostmaw
step << Hunter
.goto Thunder Bluff,59.1,86.9
.trainer >> Go and train your class spells
step << Hunter
.goto Thunder Bluff,54.1,83.9
.trainer >> Go and train your pet spells
step << Warrior
.goto Thunder Bluff,57.6,85.5
.trainer >> Go and train your class spells
>> Buy food/water if needed
step << !Mage
.goto Thunder Bluff,47.003,49.832
.fly Orgrimmar >> Fly to Orgrimmar
step << Mage
.zone Orgrimmar >> Teleport to Orgrimmar
step << Shaman
.goto Orgrimmar,38.6,36.0
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
.goto Orgrimmar,22.40,52.80
.target Keldran
>>Talk to |cRXP_FRIENDLY_Keldran|r
.turnin 1436 >> Turn in Alliance Relations
step
.goto Orgrimmar,75.20,34.30
.target Belgrom Rockmaul
>>Talk to |cRXP_FRIENDLY_Belgrom Rockmaul|r
.turnin 1184 >> Turn in Parts of the Swarm
step
.goto Orgrimmar,54.097,68.407
.home >> Set your Hearthstone to Orgrimmar
step
#completewith next
.goto Durotar,45.53,11.79,60 >> Run out of Orgrimmar
step
>>Run up the Zeppelin Tower outside of Orgrimmar
.goto Durotar,50.53,12.52
.zone Stranglethorn Vale >> Take the Zeppelin to Stranglethorn Vale
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 30-40
#classic
<< Horde
#name 35-37 Northern Stranglethorn
#next 37-38 Dustwallow Marsh
step
.goto Stranglethorn Vale,32.10,29.20
.target Far Seer Mok'thardin
>>Talk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.accept 570 >> Accept Mok'thardin's Enchantment
step
.goto Stranglethorn Vale,32.20,28.90
.target Commander Aggro'gosh
>>Talk to |cRXP_FRIENDLY_Commander Aggro'gosh|r
.accept 568 >> Accept The Defense of Grom'gol
step
#era
.goto Stranglethorn Vale,32.20,27.80
.target Kin'weelay
>>Talk to |cRXP_FRIENDLY_Kin'weelay|r
.accept 596 >> Accept Bloody Bone Necklaces
.accept 629 >> Accept The Vile Reef
step
#som
.goto Stranglethorn Vale,32.20,27.80
.target Kin'weelay
>>Talk to |cRXP_FRIENDLY_Kin'weelay|r
.accept 629 >> Accept The Vile Reef
step
.goto Stranglethorn Vale,32.20,27.80
.target Nimboya
>>Talk to |cRXP_FRIENDLY_Nimboya|r
.accept 581 >> Accept Hunt for Yenniku
step
.goto Stranglethorn Vale,35.66,10.52
>>Talk to |cRXP_FRIENDLY_Hemet Nesingwary|r
.turnin 5762 >> Turn in Hemet Nesingwary
.turnin 5763 >> Turn in Hunting in Stranglethorn
.target Barnil Stonepot
>>Talk to |cRXP_FRIENDLY_Barnil Stonepot|r
.accept 583 >> Accept Welcome to the Jungle
.turnin 583 >> Turn in Welcome to the Jungle
.target Hemet Nesingwary
.accept 194 >> Accept Raptor Mastery
.target Ajeck Rouack
>>Talk to |cRXP_FRIENDLY_Ajeck Rouack|r
.accept 185 >> Accept Tiger Mastery
.target Sir S. J. Erlgadin
>>Talk to |cRXP_FRIENDLY_Sir S. J. Erlgadin|r
.accept 190 >> Accept Panther Mastery
step
#sticky
#completewith YoungTigers
>>Kill Crocolisks along the river. Loot them for their Skin
.goto Stranglethorn Vale,37.0,9.9,90,0
.goto Stranglethorn Vale,39.9,11.8,90,0
.goto Stranglethorn Vale,40.9,14.5
.complete 575,1 
step
.goto Stranglethorn Vale,43.0,13.4,90,0
.goto Stranglethorn Vale,42.2,9.4,90,0
.goto Stranglethorn Vale,40.2,10.4,90,0
.goto Stranglethorn Vale,41.3,8.1,90,0
.goto Stranglethorn Vale,43.0,13.4
>>Kill all the Panthers you see
.complete 190,1 
step << Warrior
#softcore
.goto Stranglethorn Vale,44.52,9.99
>>If you haven't collected enough Liferoot yet, Go to the Kurzen Compound. Grind Medicine Men for Liferoot
>>Note that Jungle Fighters and Medicine Men share spawns, so you'll have to kill both
.collect 3357,8
step << Warrior
#hardcore
.goto Stranglethorn Vale,44.52,9.99
>>Go to the Kurzen Compound. Grind Medicine Men for Liferoot
>>Note that Jungle Fighters and Medicine Men share spawns, so you'll have to kill both
.collect 3357,8
step
#label YoungTigers
.goto Stranglethorn Vale,35.7,12.3,90,0
.goto Stranglethorn Vale,34.0,11.7,90,0
.goto Stranglethorn Vale,30.7,7.5,90,0
.goto Stranglethorn Vale,35.7,12.3,90,0
.goto Stranglethorn Vale,34.0,11.7,90,0
.goto Stranglethorn Vale,30.7,7.5,90,0
.goto Stranglethorn Vale,35.7,12.3
.complete 185,1 
step
#sticky
#completewith next
.goto Stranglethorn Vale,32.5,8.6,40,0
.goto Stranglethorn Vale,35.7,10.7
>>Kill Crocolisks along the river. Loot them for their skin
.complete 575,1 
step
.goto Stranglethorn Vale,35.616,10.619
>>Talk to |cRXP_FRIENDLY_Ajeck Rouack|r
.turnin 185 >> Turn in Tiger Mastery
.target Ajeck Rouack
.accept 186 >> Accept Tiger Mastery
>>Talk to |cRXP_FRIENDLY_Sir S. J. Erlgadin|r
.turnin 190 >> Turn in Panther Mastery
.target Sir S. J. Erlgadin
.accept 191 >> Accept Panther Mastery
step
.goto Stranglethorn Vale,31.0,11.2,90,0
.goto Stranglethorn Vale,29.7,8.9,90,0
.goto Stranglethorn Vale,28.4,12.3,90,0
.goto Stranglethorn Vale,28.8,13.6,90,0
.goto Stranglethorn Vale,28.5,16.9,90,0
.goto Stranglethorn Vale,30.6,13.9,90,0
.goto Stranglethorn Vale,31.0,11.2
>>Kill Panthers and Tigers in the area
.complete 191,1 
.complete 186,1 
step
.goto Stranglethorn Vale,27.7,14.7,90,0
.goto Stranglethorn Vale,26.9,17.3,90,0
.goto Stranglethorn Vale,23.8,15.5,90,0
.goto Stranglethorn Vale,27.7,14.7,90,0
.goto Stranglethorn Vale,26.9,17.3,90,0
.goto Stranglethorn Vale,23.8,15.5
>>Kill Raptors in the area
.complete 194,1 
step
.goto Stranglethorn Vale,35.6,10.5
>>Talk to |cRXP_FRIENDLY_Sir S. J. Erlgadin|r
.turnin 191 >> Turn in Panther Mastery
.target Sir S. J. Erlgadin
.accept 192 >> Accept Panther Mastery
>>Talk to |cRXP_FRIENDLY_Ajeck Rouack|r
.turnin 186 >> Turn in Tiger Mastery
.target Ajeck Rouack
.accept 187 >> Accept Tiger Mastery
>>Talk to |cRXP_FRIENDLY_Hemet Nesingwary|r
.turnin 194 >> Turn in Raptor Mastery
.target Hemet Nesingwary
.accept 195 >> Accept Raptor Mastery
step
#sticky
#completewith BloodscalpTr
>>Kill Stranglethorn Tigers en route to other objectives
.complete 187,1 
step
#label BloodscalpTr
>>Kill Trolls. Loot them for their tusks
.goto Stranglethorn Vale,33.9,15.6,90,0
.goto Stranglethorn Vale,33.2,13.7,90,0
.goto Stranglethorn Vale,28.8,19.6,90,0
.goto Stranglethorn Vale,29.8,19.4,90,0
.goto Stranglethorn Vale,30.6,18.9,90,0
.goto Stranglethorn Vale,33.9,15.6
>> Kill Bloodscalp Trolls. Loot them for their Tusks
.complete 581,1 
step
.goto Stranglethorn Vale,32.1,15.8,90,0
.goto Stranglethorn Vale,31.4,18.4,90,0
.goto Stranglethorn Vale,31.8,20.0,90,0
.goto Stranglethorn Vale,34.2,17.6,90,0
.goto Stranglethorn Vale,32.1,15.8
>>Finish killing Stranglethorn Tigers
.complete 187,1 
step
.goto Stranglethorn Vale,31.9,20.9,90,0
.goto Stranglethorn Vale,30.4,24.7,90,0
.goto Stranglethorn Vale,32.5,23.4,90,0
.goto Stranglethorn Vale,34.1,25.5,90,0
.goto Stranglethorn Vale,36.0,26.8,90,0
.goto Stranglethorn Vale,38.9,25.1,90,0
.goto Stranglethorn Vale,38.1,28.1,90,0
.goto Stranglethorn Vale,31.9,20.9
>>Kill Lashtail Raptors. Be careful as they stun and disarm
.complete 568,1 
step
.goto Stranglethorn Vale,32.2,27.8
>>Talk to |cRXP_FRIENDLY_Nimboya|r
.turnin 581 >> Turn in Hunt for Yenniku
.target Nimboya
.accept 582 >> Accept Headhunting
step
.goto Stranglethorn Vale,32.2,28.9
>>Talk to |cRXP_FRIENDLY_Commander Aggro'gosh|r
.turnin 568 >> Turn in The Defense of Grom'gol
.target Commander Aggro'gosh
.accept 569 >> Accept The Defense of Grom'gol
step << Hunter
.goto Stranglethorn Vale,31.55,27.95
.vendor >> Go to Uthok. |cRXP_BUY_Buy arrows until your quiver is full.|r
step << Hunter
#level 36
.goto Stranglethorn Vale,31.23,28.68
.trainer >> Train your class spells
step
#sticky
#completewith next
+This next quest can be quite hard, be extra careful from breath and not pulling elites.
#hardcore
step
.goto Stranglethorn Vale,24.8,22.9
>>Loot the tablet against the wall in the water
.complete 629,1 
step
#era
>>Kill Basilisks for Singing Crystal Shards.
.goto Stranglethorn Vale,23.2,17.7,90,0
.goto Stranglethorn Vale,24.6,17.9,90,0
.goto Stranglethorn Vale,23.7,16.8,90,0
.goto Stranglethorn Vale,27.4,18.6,90,0
.goto Stranglethorn Vale,23.2,17.7,90,0
.goto Stranglethorn Vale,24.6,17.9,90,0
.goto Stranglethorn Vale,23.7,16.8,90,0
.goto Stranglethorn Vale,27.4,18.6
>>Kill Basilisks. Loot them for their Shards. You have to go back and forth here forcing dynamic respawns
.complete 605,1 
step
#som
.goto Stranglethorn Vale,20.7,14.1,90,0
.goto Stranglethorn Vale,20.2,12.1,90,0
.goto Stranglethorn Vale,21.4,10.2,90,0
.goto Stranglethorn Vale,20.7,14.1,90,0
.goto Stranglethorn Vale,20.2,12.1,90,0
.goto Stranglethorn Vale,21.4,10.2
>>Grind trolls in the area. Loot them for objectives. Heads only drop from Headhunters, Ears and Necklaces from all trolls
.complete 189,1 
.complete 582,1 
step
#era
.goto Stranglethorn Vale,20.7,14.1,90,0
.goto Stranglethorn Vale,20.2,12.1,90,0
.goto Stranglethorn Vale,21.4,10.2,90,0
.goto Stranglethorn Vale,20.7,14.1,90,0
.goto Stranglethorn Vale,20.2,12.1,90,0
.goto Stranglethorn Vale,21.4,10.2
>>Grind trolls in the area. Loot them for objectives. Heads only drop from Headhunters, Ears and Necklaces from all trolls
.complete 189,1 
.complete 582,1 
.complete 596,1 
step << Warrior
.goto Stranglethorn Vale,20.7,14.1,90,0
.goto Stranglethorn Vale,20.2,12.1,90,0
.goto Stranglethorn Vale,21.4,10.2,90,0
.goto Stranglethorn Vale,20.7,14.1
>>Grind Trolls in the area. Loot them for Tusks.
.complete 1712,2 
step
#som
.goto Stranglethorn Vale,32.2,27.8
.target Nimboya
>>Talk to |cRXP_FRIENDLY_Nimboya|r
.turnin 582 >> Turn in Headhunting
.target Kin'weelay
>>Talk to |cRXP_FRIENDLY_Kin'weelay|r
.turnin 629 >> Turn in The Vile Reef
step
#era
.goto Stranglethorn Vale,32.2,27.8
.target Nimboya
>>Talk to |cRXP_FRIENDLY_Nimboya|r
.turnin 582 >> Turn in Headhunting
.target Kin'weelay
>>Talk to |cRXP_FRIENDLY_Kin'weelay|r
.turnin 596 >> Turn in Bloody Bone Necklaces
.turnin 629 >> Turn in The Vile Reef
step
#completewith next
.goto Stranglethorn Vale,37.3,30.9,100,0
>>There aren't enough of each to complete this quest now. Kill all the mobs in the camp, then go across the river and kill Tigers & Panthers until the Ogres respawn.
.complete 569,1 
.complete 569,2 
step
#sticky
#completewith CozzleBl
>>Kill Geologists. Loot them for Tumbled Crystals en route to other objectives
.complete 213,1 
step
.goto Stranglethorn Vale,42.6,18.6
>>Run up the watchtower. Kill Foreman Cozzle and loot him for his key.
.collect 5851,1
step
#label CozzleBl
.goto Stranglethorn Vale,43.3,20.3
>>Open Cozzle's Footlocker in his house
.complete 1182,1 
step
.goto Stranglethorn Vale,37.3,30.9
>>Go back to Mizjah Ruins, finish killing the Mosh'Ogg ogres, waiting for respawns if needed
.complete 569,1 
.complete 569,2 
step
.goto Stranglethorn Vale,43.8,17.3,90,0
.goto Stranglethorn Vale,42.6,22.3,90,0
.goto Stranglethorn Vale,46.4,23.4
>>Kill Geologists. Loot them for Tumbled Crystals
.complete 213,1 
step
#era
.goto Stranglethorn Vale,45.2,20.5
.xp 36+50000 >> Grind to 50000+/71600 xp
step
#som
#phase 1-2
.goto Stranglethorn Vale,45.2,20.5
.xp 36+30000 >> Grind to 30000+/71600 xp
step
#som
#phase 3-6
.goto Stranglethorn Vale,45.2,20.5
.xp 36+10000 >> Grind to 10000+/71600 xp
step
#sticky
#completewith next
>>Kill Stranglethorn Tigresses. Loot them for a Fang
.complete 570,2 
step
.goto Stranglethorn Vale,47.7,22.6,90,0
.goto Stranglethorn Vale,49.6,25.4,90,0
.goto Stranglethorn Vale,49.5,20.4,90,0
.goto Stranglethorn Vale,47.7,22.6
>>Kill Shadowmaw Panthers (they're stealthed). Loot them for Shadowmaw Claws. Look in spots where other mobs aren't near, specifically around trees
.complete 570,1 
.complete 192,1 
step
.goto Stranglethorn Vale,47.7,22.6,90,0
.goto Stranglethorn Vale,49.6,25.4,90,0
.goto Stranglethorn Vale,49.5,20.4
>>Kill Stranglethorn Tigresses. Loot them for a Fang
.complete 570,2 
step
.goto Stranglethorn Vale,39.9,14.3,90,0
.goto Stranglethorn Vale,39.9,11.6,90,0
.goto Stranglethorn Vale,41.0,14.3,90,0
.goto Stranglethorn Vale,31.9,8.4,90,0
.goto Stranglethorn Vale,39.9,14.3
>>Backtrack and finish killing and looting Crocolisks for their skin if you haven't gotten 2
.complete 575,1 
step
.goto Stranglethorn Vale,35.6,10.8
>>Talk to |cRXP_FRIENDLY_Hemet Nesingwary|r
.turnin 195 >> Turn in Raptor Mastery
.target Hemet Nesingwary
.accept 196 >> Accept Raptor Mastery
>>Talk to |cRXP_FRIENDLY_Ajeck Rouack|r
.turnin 187 >> Turn in Tiger Mastery
.target Ajeck Rouack
.accept 188 >> Accept Tiger Mastery
>>Talk to |cRXP_FRIENDLY_Sir S. J. Erlgadin|r
.turnin 192 >> Turn in Panther Mastery
.target Sir S. J. Erlgadin
.accept 193 >> Accept Panther Mastery
step
>>Kill Sin'Dall. Loot him for his Paw
>>He can either be on top of the Plateau, or patrolling around it
.goto Stranglethorn Vale,32.2,17.4
.complete 188,1 
.unitscan Sin'Dall
step
.goto Stranglethorn Vale,35.6,10.7
.target Ajeck Rouack
>>Talk to |cRXP_FRIENDLY_Ajeck Rouack|r
.turnin 188 >> Turn in Tiger Mastery
step
.goto Stranglethorn Vale,32.2,27.8
.target Nimboya
>>Talk to |cRXP_FRIENDLY_Nimboya|r
.accept 638 >> Accept Trollbane
step
.goto Stranglethorn Vale,32.2,28.8
.target Commander Aggro'gosh
>>Talk to |cRXP_FRIENDLY_Commander Aggro'gosh|r
.turnin 569 >> Turn in The Defense of Grom'gol
step
.goto Stranglethorn Vale,32.1,29.2
>>Talk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.turnin 570 >> Turn in Mok'thardin's Enchantment
.target Far Seer Mok'thardin
step
.goto Stranglethorn Vale,32.5,29.3
.fly Booty Bay >> Fly to Booty Bay
step
.goto Stranglethorn Vale,27.2,76.9
>>Talk to |cRXP_FRIENDLY_Baron Revilgaz|r
.turnin 1182 >> Turn in Goblin Sponsorship
.target Baron Revilgaz
.accept 1183 >> Accept Goblin Sponsorship
step
#era
.goto Stranglethorn Vale,27.0,77.2
>>Talk to |cRXP_FRIENDLY_Kebok|r
.turnin 189 >> Turn in Bloodscalp Ears
.turnin 213 >> Turn in Hostile Takeover
>>Talk to |cRXP_FRIENDLY_Krazek|r
.turnin 201 >> Turn in Investigate the Camp
.target Krazek
.accept 1116 >> Accept Dream Dust in the Swamp
.target Kebok
.accept 209 >> Accept Skullsplitter Tusks

step
#som
.goto Stranglethorn Vale,27.0,77.2
>>Talk to |cRXP_FRIENDLY_Kebok|r
.turnin 189 >> Turn in Bloodscalp Ears
.turnin 213 >> Turn in Hostile Takeover
.target Krazek
>>Talk to |cRXP_FRIENDLY_Krazek|r
.turnin 201 >> Turn in Investigate the Camp
.target Kebok
.accept 209 >> Accept Skullsplitter Tusks
step
#era
.goto Stranglethorn Vale,27.0,77.2
>>At the bottom floor of the inn
>>Talk to |cRXP_FRIENDLY_Crank Fizzlebub|r
.turnin 605 >> Turn in Singing Blue Shards
.target Crank Fizzlebub
.accept 600 >> Accept Venture Company Mining

step
.goto Stranglethorn Vale,28.293,77.591
.target Drizzlik
>>Talk to |cRXP_FRIENDLY_Drizzlik|r
.turnin 575 >> Turn in Supply and Demand
step << Druid
>> Use the spell Teleport to Moonglade
.goto Moonglade,52.526,40.565
.trainer >> Go and train your class spells
step
.hs >>Hearth to Orgrimmar
>> Buy food/water if needed
step
.goto Orgrimmar,48.0,80.2
>>Buy 3 Soothing Spices before starting the Dustwallow section
.collect 3713,3
step << Shaman
.goto Orgrimmar,38.6,36.0
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,66.046,18.526
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
.vendor >> Buy Lash of pain 3
step << Mage
.goto Orgrimmar,38.8,85.6
.trainer >> Go and train your class spells
step << Priest
.goto Orgrimmar,35.6,87.8
.trainer >> Go and train your class spells
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde Mage AoE
#classic
<< Horde Mage
#name 36-60 Mage AoE
step
.goto The Barrens,45.58,59.04
.home >> Set your Hearth to Camp Taurajo
step
>>Run South into Dustwallow Marsh
>>Click the Hoofprints on the ground
.goto Dustwallow Marsh,29.71,47.65
.accept 1268 >>Accept Suspicious Hoofprints
step
.goto Dustwallow Marsh,29.83,48.24
>>Click the Badge on the wood
.accept 1269 >>Accept Lieutenant Paval Reethe
step
>>Click the Shield above the fireplace
.goto Dustwallow Marsh,29.64,48.58
.accept 1251 >>Accept The Black Shield
step
.goto Dustwallow Marsh,35.15,38.26
.target Mudcrush Durtfeet
>>Talk to |cRXP_FRIENDLY_Mudcrush Durtfeet|r
.accept 1177 >>Accept Hungry!
step
.goto Dustwallow Marsh,35.56,31.88
.fp Brackenwall >> Get the Brackenwall flight path
step
.goto Dustwallow Marsh,36.42,31.89
>>Talk to |cRXP_FRIENDLY_Krog|r
.turnin 1251 >>Turn in The Black Shield
.target Krog
.accept 1321 >>Accept The Black Shield
.turnin 1268 >>Turn in Suspicious Hoofprints
.turnin 1269 >>Turn in Lieutenant Paval Reethe
step
.goto Dustwallow Marsh,36.53,30.79
.target Do'gol
>>Talk to |cRXP_FRIENDLY_Do'gol|r
.turnin 1321 >>Turn in The Black Shield
step
.goto Dustwallow Marsh,34.35,22.03
.target Do'gol
>>Talk to |cRXP_FRIENDLY_Do'gol|r
.accept 1322 >>Accept The Black Shield
step
>>Search for stealthed Theramore Infiltrators north-east of Brackenwall. AoE them if possible
.goto Dustwallow Marsh,39.11,22.81,120,0
.goto Dustwallow Marsh,38.99,27.55,120,0
.goto Dustwallow Marsh,41.65,25.78,120,0
.complete 1201,1 
step
.goto Dustwallow Marsh,55.43,26.26
.target "Swamp Eye" Jarl
>>Talk to |cRXP_FRIENDLY_"Swamp Eye" Jarl|r
.accept 1218 >>Accept Soothing Spices
.turnin 1218 >>Turn in Soothing Spices
.accept 1206 >>Accept Jarl Needs Eyes
step
.goto Dustwallow Marsh,55.45,25.92
.accept 1238 >>Accept The Lost Report
step
#completewith next
+I HIGHLY recommend watching the mage guide for these mobs, as they are arguably the hardest part of the AoE Mage leveling experience
>>I wouldn't recommend doing the turtle pack until level 38+
.link https://youtu.be/SxMc2GoP33c?t=3824 >> CLICK HERE
step
#sticky
#label Head
>>Kill Murlocs. Loot them for their heads
.complete 1177,1 
step
.goto Dustwallow Marsh,57.16,21.04,100,0
.goto Dustwallow Marsh,57.79,15.71,100,0
.goto Dustwallow Marsh,54.14,15.11,100,0
.goto Dustwallow Marsh,53.98,19.35,100,0
.goto Dustwallow Marsh,57.16,21.04,100,0
.goto Dustwallow Marsh,57.79,15.71,100,0
.goto Dustwallow Marsh,54.14,15.11,100,0
.goto Dustwallow Marsh,53.98,19.35,100,0
.xp 38 >> AoE Murlocs to level 38
step
#requires Head
.trainer >> Teleport to Undercity. Train your level 38 spells
>>Start being very careful with your money too, as it's very nice to have your mount at level 40
step
.hs >> Hearth to Camp Taurajo
.vendor >> Buy level 35 drink if needed
step
.goto The Barrens,44.44,59.15
.fly Brackenwall >> Fly to Brackenwall Village
step
.goto Dustwallow Marsh,35.15,38.25
.target Mudcrush Durtfeet
>>Talk to |cRXP_FRIENDLY_Mudcrush Durtfeet|r
.turnin 1177 >>Turn in Hungry!
step
.goto Dustwallow Marsh,35.21,30.66
.target Nazeer Bloodpike
>>Talk to |cRXP_FRIENDLY_Nazeer Bloodpike|r
.turnin 1201 >>Turn in Theramore Spies
.turnin 1238 >>Turn in The Lost Report
step
>>AoE Spiders in the area
.goto Dustwallow Marsh,34.39,21.97
.complete 1322,1 
.complete 1206,1 
step
.goto Dustwallow Marsh,36.53,30.80
>>Talk to |cRXP_FRIENDLY_Do'gol|r
.turnin 1322 >>Turn in The Black Shield
.target Do'gol
.accept 1323 >>Accept The Black Shield
step
.goto Dustwallow Marsh,36.42,31.89
.target Krog
>>Talk to |cRXP_FRIENDLY_Krog|r
.turnin 1323 >>Turn in The Black Shield
step
.goto Dustwallow Marsh,55.43,26.26
.target "Swamp Eye" Jarl
>>Talk to |cRXP_FRIENDLY_"Swamp Eye" Jarl|r
.turnin 1206 >>Turn in Jarl Needs Eyes
step
.goto Dustwallow Marsh,57.16,21.04,100,0
.goto Dustwallow Marsh,57.79,15.71,100,0
.goto Dustwallow Marsh,54.14,15.11,100,0
.goto Dustwallow Marsh,53.98,19.35,100,0
.goto Dustwallow Marsh,57.16,21.04,100,0
.goto Dustwallow Marsh,57.79,15.71,100,0
.goto Dustwallow Marsh,54.14,15.11,100,0
.goto Dustwallow Marsh,53.98,19.35,100,0
.xp 40 >> AoE Murlocs to level 40
step << Undead
.zone Undercity >> Teleport to Undercity
.trainer >> Train your class spells
step << Undead
#sticky
#completewith next
.goto Undercity,82.36,15.31
+Go to the Reagent Vendor on your right and perform a Logout Skip by positioning your character on the highest part of the lowest staircase until it looks like they're floating, then logging out and back in.
.link https://www.youtube.com/watch?v=-Bi95bCN8dM >> CLICK HERE for an example
>>If you can't do this, just run out of Undercity normally
step << Undead
#era
>>Skip this step if you won't have 90g or more after vendoring trash
.goto Tirisfal Glades,61.85,66.59,60 >> Exit Undercity
step << Undead
#som
>>Skip this step if you won't have 50g or more after vendoring trash
.goto Tirisfal Glades,61.85,66.59,60 >> Exit Undercity
step << Undead
#era
.zone Tirisfal Glades >>Skip this step if you won't have 90g or more after vendoring trash
.trainer >>Run into Tirisfal Glades and get your mount and mount training.
.goto Tirisfal Glades,59.93,52.57
step << Undead
#som
.zone Tirisfal Glades >>Skip this step if you won't have 50g or more after vendoring trash
.trainer >>Run into Tirisfal Glades and get your mount and mount training.
.goto Tirisfal Glades,59.93,52.57
step << Troll
.zone Orgrimmar >> Teleport to Orgrimmar
.trainer >> Train your class spells
step << Troll
#era
.zone Durotar >>Skip this step if you won't have 90g or more after vendoring trash
.goto Durotar,55.21,75.53
.trainer >>Run to out of Orgrimmar all the way down to Sen'jin and get your mount and mount training.
step << Troll
#som
.zone Durotar >>Skip this step if you won't have 50g or more after vendoring trash
.goto Durotar,55.21,75.53
.trainer >>Run to out of Orgrimmar all the way down to Sen'jin and get your mount and mount training.
step
.hs >> Hearth to Camp Taurajo
>> Buy food/water if needed
step
#softcore
#som
.fly Brackenwall >> Fly to Brackenwall Village
step
#hardcore
.fly Brackenwall >> Fly to Brackenwall Village
step
#softcore
#som
.goto Dustwallow Marsh,57.16,21.04,100,0
.goto Dustwallow Marsh,57.79,15.71,100,0
.goto Dustwallow Marsh,54.14,15.11,100,0
.goto Dustwallow Marsh,53.98,19.35,100,0
.goto Dustwallow Marsh,57.16,21.04,100,0
.goto Dustwallow Marsh,57.79,15.71,100,0
.goto Dustwallow Marsh,54.14,15.11,100,0
.goto Dustwallow Marsh,53.98,19.35,100,0
.xp 42+80000 >> AoE Murlocs to level 42 & 80000+/101000xp
step
#hardcore
.goto Dustwallow Marsh,57.16,21.04,100,0
.goto Dustwallow Marsh,57.79,15.71,100,0
.goto Dustwallow Marsh,54.14,15.11,100,0
.goto Dustwallow Marsh,53.98,19.35,100,0
.goto Dustwallow Marsh,57.16,21.04,100,0
.goto Dustwallow Marsh,57.79,15.71,100,0
.goto Dustwallow Marsh,54.14,15.11,100,0
.goto Dustwallow Marsh,53.98,19.35,100,0
.xp 42+80000 >> AoE Murlocs to level 42 & 80000+/101000xp
step
#hardcore
.zone Undercity >> Teleport to Undercity
.trainer >> Train your class spells
step
#hardcore
.hs >> Hearth to Camp Taurajo
>> Buy food/water if needed
step
#softcore
#som
.zone Undercity >> Teleport to Undercity
.trainer >> Train your class spells
step
#softcore
#som
.hs >> Hearth to Camp Taurajo
>> Buy food/water if needed
step
#completewith next
.goto Thousand Needles,45.14,49.11,0
.fp Freewind Post >> Get the Freewind Post flight path
>>This is completely optional, as it is not used at all in the route, but is a convenient time to get it
step
>>Travel to Tanaris. Ride through Barrens -> Thousand Needles -> Gadgetzan
.goto Tanaris,52.51,27.91
.home >> Set your hearth to Gadgetzan
step
#softcore
#era
.goto Tanaris,51.42,28.75
.target Trenton Lighthammer
>>Talk to |cRXP_FRIENDLY_Trenton Lighthammer|r
.accept 3042 >>Accept Troll Temper
.vendor >> Vendor and Repair at Krinkle
step
#softcore
#era
.goto Tanaris,50.21,27.48
.target Senior Surveyor Fizzledowser
>>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r
.accept 992 >>Accept Gadgetzan Water Survey
step
#softcore
#era
.goto Tanaris,38.73,20.02,60 >> Travel to Zul'Farrak
step
#softcore
#era
#completewith next
+You're now going to be doing Zul'Farrak. This can be extremely difficult, but is absolutely worth the xp/hr once you learn to do it
>>Click either of the links depending on whether or not you have a mount yet
>>If you have no mount, as soon as you get 90g worth of loot, teleport back to Undercity, logout skip to Tirisfal, run to Brill, and then buy your mount. Hearth back to Gadgetzan << Undead
>>If you have no mount, as soon as you get 90g worth of loot, teleport back to Orgrimmar, run to Durotar, then run to Sen'jin and buy your mount. Hearth back to Gadgetzan << Troll
.link https://youtu.be/TgwHw7qT4ws >> If you have a mount, CLICK HERE
.link https://youtu.be/4-yJ47T728Y?t=6 >> If you DONT have a mount, CLICK HERE
step
#softcore
#sticky
#label Temper
#era
>>Loot Troll Temper from the mobs you kill inside of Zul'Farrak
.complete 3042,1 
step
#softcore
#era
.xp 44 >> AoE Zul'Farrak to level 44
>>Start saving the Silk Cloth and Mageweave Cloth you get. You need 12 stacks of each for later
step
#softcore
#som
.goto Tanaris,52.48,28.45
.target Spigot Operator Luglunket
>>Talk to |cRXP_FRIENDLY_Spigot Operator Luglunket|r
.accept 1707 >>Accept Water Pouch Bounty
.target Chief Engineer Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.accept 1690 >>Accept Wastewander Justice
step
#softcore
#som
.goto Tanaris,51.84,27.02
.accept 2781 >>Accept WANTED: Caliph Scorpidsting
.accept 2875 >>Accept WANTED: Andre Firebeard
step
#softcore
#som
#completewith next
.goto Tanaris,60.18,23.29,0
>>AoE some Bandits/Thieves in Noonshade Ruins en route to Steamwheedle Port
.complete 1690,1 
.complete 1690,2 
.complete 1707,1 
step
#softcore
#som
.goto Tanaris,66.56,22.27
.target Haughty Modiste
>>Talk to |cRXP_FRIENDLY_Haughty Modiste|r
.accept 8365 >>Accept Pirate Hats Ahoy!
step
#softcore
#som
.goto Tanaris,67.06,23.89
.target Security Chief Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r
.accept 8366 >>Accept Southsea Shakedown
step
#softcore
#som
.goto Tanaris,63.67,31.29
>>AoE Bandits and Thieves. Loot them for Water Pouches
>>Be careful as some of the mobs under the tents are bugged, and will evade all mobs aggroed onto you if you aggro one of them
.complete 1690,1 
.complete 1690,2 
.complete 1707,1 
step
#softcore
#som
.goto Tanaris,62.22,37.75
>>Look for Caliph Scorpidsting in the area. Kill and loot him for his head
>>Be careful as he has two stealthed adds right next to him
.complete 2781,1 
.unitscan Caliph Scorpidsting
step
#softcore
#som
.goto Tanaris,52.48,28.45
.target Spigot Operator Luglunket
>>Talk to |cRXP_FRIENDLY_Spigot Operator Luglunket|r
.turnin 1707 >>Turn in Water Pouch Bounty
.target Chief Engineer Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.turnin 1690 >>Turn in Wastewander Justice
.turnin 2781 >>Turn in WANTED: Caliph Scorpidsting
step
#softcore
#som
.goto Tanaris,68.73,41.49,50 >> Travel to Lost Rigger Cove. Open the AoE guide en route and watch it
.link https://youtu.be/SxMc2GoP33c?t=4113 >> CLICK HERE for reference
step
#softcore
#som
#sticky
#label Hats
>>Loot pirates you AoE in the area for their hats
.complete 8365,1 
step
#softcore
#som
#sticky
#label Andre
>>Kill Andre Firebeard
.complete 2875,1 
step
#softcore
#som
#sticky
#completewith end
>>Loot the Ship Schedule from the footlockers that drop from pirates in the area
.collect 9250,1,2876 
.accept 2876 >>Accept Ship Schedules
step
#softcore
#som
.goto Tanaris,73.72,46.86
.xp 43+91000 >> AoE Grind to 43 & 91000+/106300xp
>>Use any Captain's Keys you get on the 2nd floor of the 2nd ship to the east
step
#softcore
#som
#requires Hats
step
#softcore
#som
#requires Andre
>>Finish off killing the Southsea Mobs
.complete 8366,1 
.complete 8366,2 
.complete 8366,3 
.complete 8366,4 
step
#softcore
#som
.goto Tanaris,66.56,22.27
.target Haughty Modiste
>>Talk to |cRXP_FRIENDLY_Haughty Modiste|r
.turnin 8365 >>Turn in Pirate Hats Ahoy!
step
#softcore
#som
.isOnQuest 2876
.goto Tanaris,67.06,23.89
.target Security Chief Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r
.turnin 2875 >>Turn in WANTED: Andre Firebeard
.turnin 2876 >>Turn in Ship Schedules
.turnin 8366 >>Turn in Southsea Shakedown
step
#softcore
#som
.goto Tanaris,67.06,23.89
.target Security Chief Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r
.turnin 2875 >>Turn in WANTED: Andre Firebeard
.turnin 8366 >>Turn in Southsea Shakedown
step
#hardcore
.goto Tanaris,52.48,28.45
.target Spigot Operator Luglunket
>>Talk to |cRXP_FRIENDLY_Spigot Operator Luglunket|r
.accept 1707 >>Accept Water Pouch Bounty
.target Chief Engineer Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.accept 1690 >>Accept Wastewander Justice
step
#hardcore
.goto Tanaris,51.84,27.02
.accept 2781 >>Accept WANTED: Caliph Scorpidsting
.accept 2875 >>Accept WANTED: Andre Firebeard
step
#hardcore
#completewith next
.goto Tanaris,60.18,23.29,0
>>AoE some Bandits/Thieves in Noonshade Ruins en route to Steamwheedle Port
.complete 1690,1 
.complete 1690,2 
.complete 1707,1 
step
#hardcore
.goto Tanaris,66.56,22.27
.target Haughty Modiste
>>Talk to |cRXP_FRIENDLY_Haughty Modiste|r
.accept 8365 >>Accept Pirate Hats Ahoy!
step
#hardcore
.goto Tanaris,67.06,23.89
.target Security Chief Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r
.accept 8366 >>Accept Southsea Shakedown
step
#hardcore
.goto Tanaris,63.67,31.29
>>AoE Bandits and Thieves. Loot them for Water Pouches
>>Be careful as some of the mobs under the tents are bugged, and will evade all mobs aggroed onto you if you aggro one of them
.complete 1690,1 
.complete 1690,2 
.complete 1707,1 
step
#hardcore
.goto Tanaris,52.48,28.45
.target Spigot Operator Luglunket
>>Talk to |cRXP_FRIENDLY_Spigot Operator Luglunket|r
.turnin 1707 >>Turn in Water Pouch Bounty
.target Chief Engineer Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.turnin 1690 >>Turn in Wastewander Justice
step
#hardcore
.goto Tanaris,68.73,41.49,50 >> Travel to Lost Rigger Cove. Open the AoE guide en route and watch it
.link https://youtu.be/SxMc2GoP33c?t=4113 >> CLICK HERE for reference
step
#hardcore
#sticky
#label Hats
>>Loot pirates you AoE in the area for their hats
.complete 8365,1 
step
#hardcore
#sticky
#label Andre
>>Kill Andre Firebeard
.complete 2875,1 
step
#hardcore
#sticky
#completewith end
>>Loot the Ship Schedule from the footlockers that drop from pirates in the area
.collect 9250,1,2876 
.accept 2876 >>Accept Ship Schedules
step
#hardcore
.goto Tanaris,73.72,46.86
.xp 44 >> AoE Grind to 44
>>Use any Captain's Keys you get on the 2nd floor of the 2nd ship to the east
>>Start saving the Silk Cloth and Mageweave Cloth you get. You need 12 stacks of each for later
step
#hardcore
#requires Hats
step
#hardcore
#requires Andre
>>Finish off killing the Southsea Mobs
.complete 8366,1 
.complete 8366,2 
.complete 8366,3 
.complete 8366,4 
step
#softcore
#era
#requires Temper
.zone Undercity >> Teleport to Undercity
step
#softcore
#som
.zone Undercity >> Teleport to Undercity
step
#hardcore
.zone Undercity >> Teleport to Undercity
step
.goto Undercity,85.16,10.01
.trainer >> Train your class spells
step
.goto Undercity,82.79,15.82
>> Talk to Hannah. Buy 6 Runes of Teleportation
>>You can also go to the AH and buy bigger bags if you need
.collect 17031,6 
step
.hs >> Hearth to Gadgetzan
.vendor >> Buy 140 level 45 drink
step
#completewith next
.goto Tanaris,52.30,28.92
+Bank your Silk Cloth and Mageweave Cloth here from earlier. You need 12 stacks (240) of each for later
step
#hardcore
.goto Tanaris,66.56,22.27
.target Haughty Modiste
>>Talk to |cRXP_FRIENDLY_Haughty Modiste|r
.turnin 8365 >>Turn in Pirate Hats Ahoy!
step
#hardcore
.isOnQuest 2876
.goto Tanaris,67.06,23.89
.target Security Chief Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r
.turnin 2875 >>Turn in WANTED: Andre Firebeard
.turnin 2876 >>Turn in Ship Schedules
.turnin 8366 >>Turn in Southsea Shakedown
step
#hardcore
.goto Tanaris,67.06,23.89
.target Security Chief Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r
.turnin 2875 >>Turn in WANTED: Andre Firebeard
.turnin 8366 >>Turn in Southsea Shakedown
step
#hardcore
#label Caliph
.goto Tanaris,62.22,37.75
>>Look for Caliph Scorpidsting in the area. Kill and loot him for his head
>>Be careful as he has two stealthed adds right next to him
.complete 2781,1 
.unitscan Caliph Scorpidsting
step
#hardcore
.goto Tanaris,73.72,46.86
.xp 48 >> AoE grind to 48
>>Use any Captain's Keys you get on the 2nd floor of the 2nd ship to the east
step
#softcore
#som
.goto Tanaris,51.42,28.75
.target Trenton Lighthammer
>>Talk to |cRXP_FRIENDLY_Trenton Lighthammer|r
.accept 3042 >>Accept Troll Temper
.vendor >> Vendor and Repair at Krinkle
step
#softcore
#era
.goto Tanaris,51.42,28.75
.target Trenton Lighthammer
>>Talk to |cRXP_FRIENDLY_Trenton Lighthammer|r
.turnin 3042 >>Turn in Troll Temper
.vendor >> Vendor and Repair at Krinkle
step
#softcore
.goto Tanaris,51.57,26.75
.target Tran'rek
>>Talk to |cRXP_FRIENDLY_Tran'rek|r
.accept 2865 >> Accept Scarab Shells
step
#softcore
.goto Tanaris,38.73,20.02,60 >> Travel to Zul'Farrak
step
#softcore
#sticky
#completewith ZF54
.goto Tanaris,39.14,29.15,0
>>If you ever hit lockout (max 5 instances per hour) and it won't let you back in ZF, do the Dowsing Widget
.complete 992,1 
step
#softcore
#era
#completewith next
+You're now going to learn to do a harder version which takes longer, but gives more xp: Pulling scarabs.
.link https://youtu.be/rFO4prcG2p0 >> CLICK HERE
step
#softcore
#som
#completewith next
+You're now going to be doing Zul'Farrak. This can be extremely difficult, but is absolutely worth the xp/hr once you learn to do it
>>Click either of the links depending on whether or not you have a mount yet
>>If you have no mount, as soon as you get 50g worth of loot, teleport back to Undercity, logout skip to Tirisfal, run to Brill, and then buy your mount. Hearth back to Gadgetzan << Undead
>>If you have no mount, as soon as you get 50g worth of loot, teleport back to Orgrimmar, run to Durotar, then run to Sen'jin and buy your mount. Hearth back to Gadgetzan << Troll
.link https://youtu.be/TgwHw7qT4ws >> If you have a mount, CLICK HERE
.link https://youtu.be/4-yJ47T728Y?t=6 >> If you DONT have a mount, CLICK HERE
.link https://youtu.be/rFO4prcG2p0 >> CLICK HERE when you're comfortable enough to do the additional Scarab pull
step
#softcore
#sticky
#label ScarabS
>>Loot Scarab Shells inside of ZF after you've AoE'd them
.complete 2865,1 
step
#softcore
#som
>>Loot Troll Temper from the zombies you AoE inside of Zul'Farrak
.complete 3042,1 
step
#softcore
.xp 48 >> AoE Zul'Farrak to level 48
step
#softcore
#requires ScarabS
.trainer >> Teleport to Orgrimmar or Undercity. Train your level 46-48 spells
step
#hardcore
.trainer >> Teleport to Orgrimmar or Undercity. Train your level 46-48 spells
step
.hs >> Hearth to Gadgetzan. Buy level 45 drink if needed
>> Buy food/water if needed
step
#completewith next
.goto Tanaris,52.30,28.92
+Bank your Silk Cloth and Mageweave Cloth here from earlier. You need 12 stacks (240) of each for later
step
#hardcore
.goto Tanaris,52.46,28.52
.target Chief Engineer Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.turnin 2781 >>Turn in WANTED: Caliph Scorpidsting
step
#softcore
#som
.goto Tanaris,51.42,28.75
.target Trenton Lighthammer
>>Talk to |cRXP_FRIENDLY_Trenton Lighthammer|r
.turnin 3042 >>Turn in Troll Temper
.vendor >> Vendor and Repair at Krinkle
step
#softcore
.isQuestComplete 992
.goto Tanaris,50.21,27.48
.target Senior Surveyor Fizzledowser
>>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r
.turnin 992 >>Turn in Gadgetzan Water Survey
step
#softcore
.goto Tanaris,51.57,26.75
.target Tran'rek
>>Talk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 2865 >> Turn in Scarab Shells
step
#softcore
.goto Tanaris,38.73,20.02,60 >> Travel to Zul'Farrak
step
#softcore
.xp 52 >> AoE Zul'Farrak to level 52
step
#hardcore
.isOnQuest 2876
.goto Tanaris,67.06,23.89
.target Security Chief Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r
.turnin 2876 >>Turn in Ship Schedules
step
#hardcore
.goto Tanaris,73.72,46.86
.xp 52 >> AoE grind to 52
>>Use any Captain's Keys you get on the 2nd floor of the 2nd ship to the east
>>Remember to save 12 stacks of Mageweave. You'll need it for cloth turnins later
step
#softcore
.trainer >> Teleport to Orgrimmar or Undercity. Train your level 50-52 spells
step
#softcore
.hs >> Hearth to Gadgetzan. Buy level 45 drink if needed
>> Buy food/water if needed
step
#softcore
.isQuestComplete 992
.goto Tanaris,50.21,27.48
.target Senior Surveyor Fizzledowser
>>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r
.turnin 992 >>Turn in Gadgetzan Water Survey
step
#softcore
.goto Tanaris,51.57,26.75
.target Tran'rek
>>Talk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 2865 >> Turn in Scarab Shells
step
#softcore
.goto Tanaris,38.73,20.02,60 >> Travel to Zul'Farrak
step
#softcore
#label ZF54
.xp 54 >> AoE Zul'Farrak to level 54
>>Remember to save 12 stacks of Mageweave. You'll need it for cloth turnins later
step
.zone Undercity >> Teleport to Undercity
step
.goto Undercity,85.16,10.01
.trainer >> Train your class spells
step
#sticky
#completewith next
.goto Undercity,82.36,15.31
+Go to the Reagent Vendor on your right and perform a Logout Skip by positioning your character on the highest part of the lowest staircase until it looks like they're floating, then logging out and back in.
.link https://www.youtube.com/watch?v=-Bi95bCN8dM >> CLICK HERE for an example
>>If you can't do this, just run out of Undercity normally
step
.goto Tirisfal Glades,61.85,66.59,60 >> Exit Undercity
step
>>Run East to The Bulwark
.goto Tirisfal Glades,83.19,68.45
.target Argent Officer Garush
>>Talk to |cRXP_FRIENDLY_Argent Officer Garush|r
.turnin 5405 >> Turn in Argent Dawn Commission

step
.goto Tirisfal Glades,83.1,68.9
.target High Executor Derrington
>>Talk to |cRXP_FRIENDLY_High Executor Derrington|r
.accept 5096 >>Accept Scarlet Diversions
step
.goto Western Plaguelands,26.55,56.18
>>Loot the crate next to the fire
.collect 12814,1 
step
>> Be careful as the mobs are relatively difficult, and can chain-pull each other here
>>Burn the command tent down, then use the banner in your inventory on top of it
.goto Western Plaguelands,40.5,51.8
.complete 5096,1 
step
.goto Tirisfal Glades,83.1,68.9
>>Talk to |cRXP_FRIENDLY_High Executor Derrington|r
.turnin 5096 >>Turn in Scarlet Diversions
.target High Executor Derrington
.accept 5098 >>Accept All Along the Watchtowers
.accept 5228 >>Accept The Scourge Cauldrons
step
.goto Tirisfal Glades,83.03,71.91
>>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r
.turnin 5228 >>Turn in The Scourge Cauldrons
.target Shadow Priestess Vandis
.accept 5229 >>Accept Target: Felstone Field
step
>>Kill Cauldron Lord Bilemaw. Loot him for the key
.goto Western Plaguelands,37.12,57.18
.complete 5229,1 
.unitscan Cauldron Lord Bilemaw
step
>>Go to the top floor of the house. Talk to Janice
.goto Western Plaguelands,38.40,54.05
.target Janice Felstone
>>Talk to |cRXP_FRIENDLY_Janice Felstone|r
.accept 5021 >>Accept Better Late Than Never
step
>>Click the package on the floor of the barn
.goto Western Plaguelands,38.8,55.3
.turnin 5021 >>Turn in Better Late Than Never
.accept 5023 >>Accept Better Late Than Never
step
.goto Western Plaguelands,37.22,56.88
.turnin 5229 >>Turn in Target: Felstone Field
.accept 5230 >>Accept Return to the Bulwark
step
.goto Western Plaguelands,26.41,59.14
>>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r
.turnin 5230 >>Turn in Return to the Bulwark
.target Shadow Priestess Vandis
.accept 5231 >>Accept Target: Dalson's Tears
step
>>Kill Cauldron Lord Malvinous. Loot him for the key
.goto Western Plaguelands,46.04,52.33
.complete 5231,1 
step
.goto Western Plaguelands,46.19,52.01
.turnin 5231 >>Turn in Target: Dalson's Tears
.accept 5232 >>Accept Return to the Bulwark
step
>>Inside the barn on the ground
.goto Western Plaguelands,47.79,50.67
.turnin 5058 >> Turn in Mrs. Dalson's Diary
step
#completewith next
+Start AoEing the undead in the area. Be careful as the Skeletal Terrors fear. Watch the video for more info << !Undead
+Start AoEing the undead in the area. Be careful as the Skeletal Terrors fear (remember to use your racial Will of the Forsaken). Watch the video for more info << Undead
.link https://youtu.be/SxMc2GoP33c?t=4759 >> CLICK HERE
step
#label SkeletonKey
#completewith UD58
>>Keep an eye out for the Wandering Skeleton whilst you're AoEing. Kill him then loot him for the Outhouse Key
.collect 12738,1 
step
#completewith UD58
#label LockedAway
#requires SkeletonKey
.goto Western Plaguelands,48.16,49.64
>>Click the outhouse. This will spawn a mob. Kill it
.turnin 5059 >> Turn in Locked Away
.collect 12739,1 
step
#completewith UD58
#requires LockedAway
>>Click the cabinet at the top floor of the house
.goto Western Plaguelands,47.37,49.66
.turnin 5060 >> Turn in Locked Away
step
#phase 5
#sticky
>>Save Bone Fragments looted from skeletons for a quest later
.collect 22526,30 
step
#hardcore
.goto Western Plaguelands,46.49,52.15
.xp 53+100000 >>AoE Undead in the area to 53 & 100000+/167100xp
>>Remember to try and save 12 stacks of Runecloth. You'll need it for cloth turnins later
step
#softcore
.goto Western Plaguelands,46.49,52.15
.xp 55+100000 >>AoE Undead in the area to 55 & 100000+/180800xp
>>Remember to try and save 12 stacks of Runecloth. You'll need it for cloth turnins later
step
>>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
.goto Western Plaguelands,44.24,63.06
.complete 5098,3 
step
.goto Western Plaguelands,26.65,55.18
.vendor >> You should be Friendly with the Argent Dawn now, so buy as many Manna Biscuits as possible to last you to level 60
>>If you're not, turn in scourgestones you looted until you are
step
.goto Western Plaguelands,26.40,59.14
>>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r
.turnin 5232 >>Turn in Return to the Bulwark
.target Shadow Priestess Vandis
.accept 5233 >>Accept Target: Writhing Haunt
step
.goto Western Plaguelands,26.68,59.59
.target Mickey Levine
>>Talk to |cRXP_FRIENDLY_Mickey Levine|r
.accept 5901 >>Accept A Plague Upon Thee
step
>>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
.goto Western Plaguelands,42.28,66.05
.complete 5098,2 
step
#label UD58
.goto Western Plaguelands,46.49,52.15
.xp 58 >> AoE Undead in the area to 58
step
>>Kill Cauldron Lord Razarch. Loot him for the key
.goto Western Plaguelands,53.07,65.97
.complete 5233,1 
step
.goto Western Plaguelands,53.05,65.71
.turnin 5233 >>Turn in Target: Writhing Haunt
.accept 5234 >>Accept Return to the Bulwark
step
.goto Western Plaguelands,53.73,64.66
.target Mulgris Deepriver
>>Talk to |cRXP_FRIENDLY_Mulgris Deepriver|r
.accept 4984 >>Accept The Wildlife Suffers Too
step
.zone Undercity >> Teleport to Undercity
step
.goto Undercity,85.16,10.01
.trainer >> Train your class spells
step
.goto Undercity,67.62,44.16
>>Talk to |cRXP_FRIENDLY_Royal Overseer Bauhaus|r
.turnin 5023 >>Turn in Better Late Than Never
.target Royal Overseer Bauhaus
.accept 5049 >>Accept The Jeremiah Blues
step
>>Under the staircase
.goto Undercity,67.62,44.16
>>Talk to |cRXP_FRIENDLY_Jeremiah Payson|r
.turnin 5049 >>Turn in The Jeremiah Blues
.target Jeremiah Payson
.target Ol' Emma
>>Talk to |cRXP_FRIENDLY_Ol' Emma|r

.accept 5050 >>Accept Good Luck Charm
step
#sticky
#completewith next
.goto Undercity,67.62,44.16
+Perform a Logout Skip by positioning your character until it looks like they're floating with some distance between you and the ground, then logging out and back in.
.link https://www.youtube.com/watch?v=-Bi95bCN8dM >> CLICK HERE for an example
>>If you can't do this, just run out of Undercity normally
step
.goto Tirisfal Glades,61.85,66.59,60 >> Exit Undercity
step
.goto Western Plaguelands,26.40,59.15
>>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r
.turnin 5234 >>Turn in Return to the Bulwark
.target Shadow Priestess Vandis
.accept 5235 >>Accept Target: Gahrron's Withering
step
#phase 5
#softcore
#completewith next
+You can now go and do ZG from 58-60. This is EXTREMELY hard, but is faster than open world aoe leveling if you're confident/already know how to do it
.link https://youtu.be/lfgvyhmf3q4?t=7 >>CLICK HERE
step
>>Go to the top floor of the house. Talk to Janice
.goto Western Plaguelands,38.401,54.053
>>Talk to |cRXP_FRIENDLY_Janice Felstone|r
.turnin 5050 >>Turn in Good Luck Charm
.target Janice Felstone
.accept 5051 >>Accept Two Halves Become One
step
.goto Western Plaguelands,38.0,54.7
>>Find a Jabbering Ghoul. Kill him and loot the Good Luck Charm
.complete 5051,1 
step
.goto Western Plaguelands,38.401,54.053
.target Janice Felstone
>>Talk to |cRXP_FRIENDLY_Janice Felstone|r
.turnin 5051 >>Turn in Two Halves Become One
step
>>AoE Wolves in the area. You may need to kill spiders to force respawns on wolves
.goto Western Plaguelands,47.14,44.80
.complete 4984,1 
step
.goto Western Plaguelands,53.72,64.66
>>Talk to |cRXP_FRIENDLY_Mulgris Deepriver|r
.turnin 4984 >>Turn in The Wildlife Suffers Too
.target Mulgris Deepriver
.accept 4985 >>Accept The Wildlife Suffers Too
step
.abandon 4984 >> Abandon The Wildlife Suffers Too
step
#sticky
#label Grizzly
>>AoE Grizzlys en route to other quests
.complete 4985,1 
step
>>Kill Cauldron Lord Soulwraith. Loot him for the key
.goto Western Plaguelands,62.80,58.76
.complete 5235,1 
step
.goto Western Plaguelands,62.59,58.55
.turnin 5235 >>Turn in Target: Gahrron's Withering
.accept 5236 >>Accept Return to the Bulwark
step
#requires Grizzly
.goto Western Plaguelands,67.33,24.23
.target Tirion Fordring
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.accept 5542 >>Accept Demon Dogs
.accept 5543 >>Accept Blood Tinged Skies
.accept 5544 >>Accept Carrion Grubbage
step
#label grubs
#sticky
>>AoE Carrion Worms
.complete 5544,1 
step
#label fordring1
#sticky
.goto Eastern Plaguelands,40.8,68.1,0
>>AoE Plaguebots and Plaguehounds
>>Be careful as Plaguebats can terrify
.complete 5543,1 
.complete 5542,1 
step << skip
.goto Eastern Plaguelands,26.54,74.74
.target Nathanos Blightcaller
>>Talk to |cRXP_FRIENDLY_Nathanos Blightcaller|r
.accept 6022 >>Accept To Kill With Purpose
step
.goto Eastern Plaguelands,36.5,90.8
.target Pamela Redpath
>>Talk to |cRXP_FRIENDLY_Pamela Redpath|r
.accept 5149 >> Accept Pamela's Doll
step
.goto Eastern Plaguelands,39.2,91.6
>>Loot the 3 doll parts found on the floor throughout Darrowshire and then combine them together
.complete 5149,1 
step
.goto Eastern Plaguelands,36.4,90.9
>>Talk to |cRXP_FRIENDLY_Pamela Redpath|r
.turnin 5149 >> Turn in Pamela's Doll
.target Pamela Redpath
.accept 5152 >> Accept Auntie Marlene
.accept 5241 >> Accept Uncle Carlin
step
#requires fordring1
.goto Eastern Plaguelands,81.6,59.3
.complete 5542,2 
step
#phase 5
.goto Eastern Plaguelands,81.63,58.07
.home >> Set your Hearth to Light's Hope Chapel
step
#phase 5
.goto Eastern Plaguelands,81.42,58.51
.target Rohan the Assassin
>>Talk to |cRXP_FRIENDLY_Rohan the Assassin|r
.accept 9126 >> Accept Bonescythe Digs
step
#phase 5
.isQuestComplete 9126
.target Rohan the Assassin
>>Talk to |cRXP_FRIENDLY_Rohan the Assassin|r
.turnin 9126 >> Turn in Bonescythe Digs
step
.goto Eastern Plaguelands,81.6,59.3
.fp Light's Hope Chapel >> Get the Light's Hope Chapel flight path
step
.goto Eastern Plaguelands,81.4,59.9
>>Talk to |cRXP_FRIENDLY_Carlin Redpath|r
.turnin 5241 >> Turn in Uncle Carlin
.target Carlin Redpath
.accept 5211 >> Accept Defenders of Darrowshire
step
.goto Eastern Plaguelands,79.7,63.6
.target Caretaker Alen
>>Talk to |cRXP_FRIENDLY_Caretaker Alen|r
.accept 5281 >> Accept The Restless Souls
.accept 6021 >> Accept Zaeldarr the Outcast
step
#sticky
#completewith EPL1
.goto Eastern Plaguelands,76.48,49.66,0
.goto Eastern Plaguelands,83.90,40.88,0
.goto Eastern Plaguelands,65.50,38.66,0
.goto Eastern Plaguelands,26.75,27.56,0
.goto Eastern Plaguelands,17.71,32.13,0
.goto Eastern Plaguelands,59.54,68.65,0
>>Kill ghouls and then talk to the Darrowshire spirits that spawn from their corpses
.complete 5211,1
step
#sticky
#label FPlague
.goto Eastern Plaguelands,23.5,37.4
.complete 5542,3 
step
.goto Eastern Plaguelands,34.0,28.1
>>Look for termite mounds around Plaguewood
.complete 5901,1 
step
#sticky
#completewith next
+Drop any spare Plagueland Termites you have, if you have them (NOT the 100 stack)
step
.goto Eastern Plaguelands,14.5,33.6
.target Egan
>>Talk to |cRXP_FRIENDLY_Egan|r
.turnin 5281 >> Turn in The Restless Souls
step
#requires grubs
#label EPL1
.goto Eastern Plaguelands,7.6,43.7
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.turnin 5542 >> Turn in Demon Dogs
.turnin 5543 >> Turn in Blood Tinged Skies
.turnin 5544 >> Turn in Carrion Grubbage
.target Tirion Fordring
.accept 5742 >> Accept Redemption
step
#requires FPlague
.goto Eastern Plaguelands,7.6,43.7
>>Talk to Tirion
.complete 5742,1 
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.turnin 5742 >> Turn in Redemption
.target Tirion Fordring
.accept 5781 >> Accept Of Forgotten Memories
step
.goto Eastern Plaguelands,27.4,84.9
>>Enter the troll crypt
.complete 6021,1 
step
.goto Eastern Plaguelands,27.3,85.2
.accept 6024 >> Accept Hameya's Plea
step
.goto Eastern Plaguelands,28.4,86.6
>>Summon Mercutio and his goons by clicking on the dirt pile, you have to kill him while handling 3 other adds
>>Simply AoE them down as normal
.complete 5781,1 
step
.goto Eastern Plaguelands,7.6,43.7
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.turnin 5781 >> Turn in Of Forgotten Memories
.target Tirion Fordring
.accept 5845 >> Accept Of Lost Honor
step
.zone Undercity >> Teleport to Undercity
step
#sticky
#completewith next
.goto Undercity,82.36,15.31
+Go to the Reagent Vendor on your right and perform a Logout Skip by positioning your character on the highest part of the lowest staircase until it looks like they're floating, then logging out and back in.
.link https://www.youtube.com/watch?v=-Bi95bCN8dM >> CLICK HERE for an example
>>If you can't do this, just run out of Undercity normally
step
.goto Tirisfal Glades,61.85,66.59,60 >> Exit Undercity
step
.goto Tirisfal Glades,83.04,71.91
.target Shadow Priestess Vandis
>>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r
.turnin 5236 >>Turn in Return to the Bulwark
step
.goto Tirisfal Glades,83.30,72.33
>>Talk to |cRXP_FRIENDLY_Mickey Levine|r
.turnin 5901 >>Turn in A Plague Upon Thee
.target Mickey Levine
.accept 5902 >>Accept A Plague Upon Thee
step
>>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
.goto Western Plaguelands,40.15,71.50
.complete 5098,1 
step
.goto Western Plaguelands,49.2,78.6
>>Talk to |cRXP_FRIENDLY_Marlene Redpath|r
.turnin 5152 >> Turn in Auntie Marlene
.target Marlene Redpath
.accept 5153 >> Accept A Strange Historian
step
.goto Western Plaguelands,49.6,76.8
>>Loot the gravestone right outside the house
.complete 5153,1 
step
>>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
.goto Western Plaguelands,46.73,71.14
.complete 5098,4 
step
>>Go into the Inn. Try to avoid mobs en route
.goto Western Plaguelands,39.5,66.9
>>Talk to |cRXP_FRIENDLY_Chromie|r
.turnin 5153 >> Turn in A Strange Historian
.target Chromie
.accept 5154 >> Accept The Annals of Darrowshire

step << skip
#sticky
#label parasites
.goto Western Plaguelands,46.7,62.3
>>Use the temporal displacer on the grain silos
.complete 4971,1 
step
.goto Western Plaguelands,43.4,69.6
>>Loot books inside the Andorhal town hall until you get the correct one
.complete 5154,1 
*The correct book's pages has a lighter shade of grey on BOTH pages and sometimes the correct book won't spawn
*If you're unlucky, you have to keep looting bad tomes until a good one spawns
step
#requires parasites
.goto Western Plaguelands,39.5,66.8


>>Talk to |cRXP_FRIENDLY_Chromie|r
.turnin 5154 >> Turn in The Annals of Darrowshire
.target Chromie
.accept 5210 >> Accept Brother Carlin
step << skip
.goto Western Plaguelands,41.3,67.1
>>Look for small lockboxes inside the burnt houses
.complete 4972,1 
step << skip
.goto Western Plaguelands,39.4,66.9
.target Chromie
>>Talk to |cRXP_FRIENDLY_Chromie|r
.turnin 4972 >> Turn in Counting Out Time
step
#phase 1-4
.zone Undercity >> Teleport to Undercity
step
#phase 1-4
.goto Undercity,63.28,48.58
.fly Eastern Plaguelands >> Fly to Light's Hope Chapel
step
#phase 5
.hs >> Hearth to Light's Hope Chapel
>> Buy food/water if needed
step
#phase 5
.isQuestComplete 9126
.target Rohan the Assassin
>>Talk to |cRXP_FRIENDLY_Rohan the Assassin|r
.turnin 9126 >> Turn in Bonescythe Digs
step
.goto Eastern Plaguelands,81.5,59.8
>>Talk to |cRXP_FRIENDLY_Carlin Redpath|r
.turnin 5210 >> Turn in Brother Carlin
.target Carlin Redpath
.accept 5181 >> Accept Villains of Darrowshire
.accept 5168 >> Accept Heroes of Darrowshire
step
.goto Eastern Plaguelands,79.7,63.7
.target Caretaker Alen
>>Talk to |cRXP_FRIENDLY_Caretaker Alen|r
.turnin 6021 >> Turn in Zaeldarr the Outcast
step
.goto Eastern Plaguelands,71.3,34.0
>>Loot the banner underwater
.complete 5845,1 
step
.goto Eastern Plaguelands,70.8,16.2
>>Run past all the mobs up the hill, then go and kill Infiltrator Hameya, he walks around the shallow graves
.complete 6024,1 
step
.goto Eastern Plaguelands,51.2,49.9
>>Loot the skull underwater
.complete 5181,1 
step
.goto Eastern Plaguelands,60.6,68.4
>>Kill ghouls and then talk to the Darrowshire spirits that spawn from their corpses
.complete 5211,1
step
.goto Eastern Plaguelands,53.9,65.8
.complete 5181,2 
step
.goto Eastern Plaguelands,28.1,86.1
.turnin 6024 >> Turn in Hameya's Plea
step
.goto Eastern Plaguelands,7.6,43.6
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.turnin 5845 >> Turn in Of Lost Honor
.target Tirion Fordring
.accept 5846 >> Accept Of Love and Family
step
.goto Western Plaguelands,63.8,57.2
>>Loot the shield on the ground, just outside the barn
.complete 5168,2 
step
.goto Western Plaguelands,65.7,75.4
.target Artist Renfray
>>Talk to |cRXP_FRIENDLY_Artist Renfray|r
.turnin 5846 >> Turn in Of Love and Family
step
.isQuestComplete 4985
.goto Western Plaguelands,53.7,64.7
>>Talk to |cRXP_FRIENDLY_Mulgris Deepriver|r
.turnin 4985 >> Turn in The Wildlife Suffers Too
.target Mulgris Deepriver
.accept 4987 >> Accept Glyphed Oaken Branch
step
.goto Western Plaguelands,48.4,31.9
.turnin 5902 >> Turn in A Plague Upon Thee
.accept 6390 >> Accept A Plague Upon Thee
step
.goto Western Plaguelands,51.9,28.2
.target Kirsta Deepshadow
>>Talk to |cRXP_FRIENDLY_Kirsta Deepshadow|r
.accept 6004 >> Accept Unfinished Business
step
.goto Western Plaguelands,51.80,44.25,100,0
.goto Western Plaguelands,40.53,51.79,100,0
.complete 6004,1 
.complete 6004,2 
.complete 6004,3 
.complete 6004,4 
step
.goto Western Plaguelands,51.920,28.058
>>Talk to |cRXP_FRIENDLY_Kirsta Deepshadow|r
.turnin 6004 >> Turn in Unfinished Business
.target Kirsta Deepshadow
.accept 6023 >> Accept Unfinished Business
step
.goto Western Plaguelands,57.8,36.2
.complete 6023,1 
step
.goto Western Plaguelands,55.1,23.5
>>Look for the named mob that patrols up and down the tower
.complete 6023,2 
*There is a level 63 elite mob that can spawn at the tower, if that's the case just be patient and wait for Durgen to come down
step
.goto Western Plaguelands,51.9,28.0
>>Talk to |cRXP_FRIENDLY_Kirsta Deepshadow|r
.turnin 6023 >> Turn in Unfinished Business
.target Kirsta Deepshadow
.accept 6025 >> Accept Unfinished Business
step
.goto Western Plaguelands,45.7,18.8
.complete 6025,1 
step
#softcore
.goto Western Plaguelands,42.5,18.9
>>Loot the libram inside the town hall. Either slowly kill all the mobs one-by-one, or pull all of the mobs inside, kite them outside, freeze them in place, then loot the Libram and run
>>do NOT die here or you have a very long run
.complete 5168,1 
.link >> CLICK HERE for a guide
step
#hardcore
.goto Western Plaguelands,42.5,18.9
>>Loot the libram inside the town hall. Either slowly kill all the mobs one-by-one, or pull all of the mobs inside, kite them outside, freeze them in place, then loot the Libram and run
>>this quest is VERY difficult and risky. I wouldn't recommend doing this on hardcore
.complete 5168,1 
.link >> CLICK HERE for a guide
step
#sticky
#completewith next
+I HIGHLY recommend watching the mage guide for these mobs
.link https://youtu.be/SxMc2GoP33c?t=3824 >> CLICK HERE
step
.goto Western Plaguelands,46.30,16.86,120,0
.goto Western Plaguelands,44.84,12.43,120,0
.goto Western Plaguelands,45.53,9.51,120,0
.goto Western Plaguelands,43.97,17.21,120,0
.xp 59+130000 >> Grind to 59 & 130000+/209800
step
.goto Western Plaguelands,51.9,28.0
.target Kirsta Deepshadow
>>Talk to |cRXP_FRIENDLY_Kirsta Deepshadow|r
.turnin 6025 >> Turn in Unfinished Business
step
.goto Western Plaguelands,26.51,56.02
>>Talk to |cRXP_FRIENDLY_High Executor Derrington|r
.turnin 5098 >>Turn in All Along the Watchtowers
.turnin 5238 >>Turn in Mission Accomplished!
.target High Executor Derrington
.accept 838 >>Accept Scholomance
step
.goto Western Plaguelands,26.67,56.33
.target Apothecary Dithers
>>Talk to |cRXP_FRIENDLY_Apothecary Dithers|r
.turnin 838 >>Turn in Scholomance
step
#phase 1-4
.zone Undercity >> Teleport to Undercity
step
#phase 1-4
.goto Undercity,63.28,48.58
.fly Eastern Plaguelands >> Fly to Light's Hope Chapel
step
#phase 5
.hs >> Hearth to Light's Hope Chapel
>> Buy food/water if needed
step
#phase 5
.isQuestComplete 9126
.target Rohan the Assassin
>>Talk to |cRXP_FRIENDLY_Rohan the Assassin|r
.turnin 9126 >> Turn in Bonescythe Digs
step
.goto Eastern Plaguelands,81.5,59.8
.target Carlin Redpath
>>Talk to |cRXP_FRIENDLY_Carlin Redpath|r
.turnin 5168 >> Turn in Heroes of Darrowshire
.turnin 5181 >> Turn in Villains of Darrowshire
.turnin 5211 >> Turn in Defenders of Darrowshire
step
.zone Undercity >> Teleport to Undercity
step
#softcore
#completewith UCBank
.goto Undercity,60.48,41.77
+If you don't have 12 stacks of each cloth, buy them from the Auction House
step
#label UCBank
.goto Undercity,65.65,44.10,50,0
>>Withdraw all your cloth from the bank. You need 12 stacks of Wool, Silk, Mageweave, and Runecloth
>>If you don't have inventory space, then leave half of the cloth in the bank and skip this step
.collect 2592,240 
.collect 4306,240 
.collect 4338,240 
.collect 14047,240 
step
>>Make sure you have no addons on that will automatically turn in extra runecloth (for rep) or you will be told to buy it again later
.goto Undercity,71.65,29.25
.target Ralston Farnsley
>>Talk to |cRXP_FRIENDLY_Ralston Farnsley|r
.turnin 7813 >> Turn in A Donation of Wool
.turnin 7814 >> Turn in A Donation of Silk
.turnin 7817 >> Turn in A Donation of Mageweave
.turnin 7818 >> Turn in A Donation of Runecloth
step
.zone Orgrimmar >> Teleport to Orgrimmar
step
#softcore
#completewith OGBank
.goto Orgrimmar,55.55,64.71
+If you don't have 9 stacks of each cloth, buy it from the Auction House
step
#label OGBank
.goto Orgrimmar,49.57,69.10,40,0
>>Withdraw all your cloth from the bank. You need 9 stacks of Wool, Silk, Mageweave, and Runecloth
>>If you don't have inventory space, then leave half of the cloth in the bank and skip this step
.collect 2592,180 
.collect 4306,180 
.collect 4338,180 
.collect 14047,180 
step
>>Make sure you have no addons on that will automatically turn in extra runecloth (for rep) or you will be told to buy it again later
.goto Orgrimmar,63.62,51.24
.target Rashona Straglash
>>Talk to |cRXP_FRIENDLY_Rashona Straglash|r
.turnin 7826 >> Turn in A Donation of Wool
.turnin 7827 >> Turn in A Donation of Silk
.turnin 7831 >> Turn in A Donation of Mageweave
.turnin 7824 >> Turn in A Donation of Runecloth
step
>>Make sure you have no addons on that will automatically turn in extra runecloth (for rep) or you will be told to buy it again later
.goto Orgrimmar,37.69,87.92
.target Vehena
>>Talk to |cRXP_FRIENDLY_Vehena|r
.turnin 7833 >> Turn in A Donation of Wool
.turnin 7834 >> Turn in A Donation of Silk
.turnin 7835 >> Turn in A Donation of Mageweave
.turnin 7836 >> Turn in A Donation of Runecloth
step
.goto Orgrimmar,45.11,63.89
.fly Thunder Bluff >> Fly to Thunder Bluff
step
#softcore
#completewith TBBank
.goto Thunder Bluff,40.42,51.76
+If you don't have 3 stacks of each cloth, buy it from the Auction House
step
#label TBBank
.goto Thunder Bluff,47.28,58.62,40,0
>>Withdraw all your cloth from the bank. You need 3 stacks of Wool, Silk, Mageweave, and Runecloth
>>If you don't have inventory space, then leave half of the cloth in the bank and skip this step
.collect 2592,600 
.collect 4306,60 
.collect 4338,60 
.collect 14047,60 
step
.goto Thunder Bluff,75.63,31.66
.target Nara Wildmane
>>Talk to |cRXP_FRIENDLY_Nara Wildmane|r
.turnin 4987 >>Turn in Glyphed Oaken Branch
step
>>Make sure you have no addons on that will automatically turn in extra runecloth (for rep) or you will be told to buy it again later
.goto Thunder Bluff,43.05,42.73
.target Rumstag Proudstrider
>>Talk to |cRXP_FRIENDLY_Rumstag Proudstrider|r
.turnin 7820 >> Turn in A Donation of Wool
.turnin 7821 >> Turn in A Donation of Silk
.turnin 7822 >> Turn in A Donation of Mageweave
.turnin 7823 >> Turn in A Donation of Runecloth
step
+Congratulations on level 60!
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 30-40
#classic
<< Horde
#name 37-38 Dustwallow Marsh
#next 38-39 Alterac/Arathi
step
.maxlevel 37,dustwallowskip1
.goto Orgrimmar,45.120,63.889
.fly Camp Taurajo >>Fly to Camp Taurajo
step
#completewith next
.goto The Barrens,50.2,78.5,100 >>Run to Dustwallow Marsh
step
#completewith next
#sticky
#label Hoofprints
>>Click the Hoofprints on the ground
.goto Dustwallow Marsh,29.7,47.6
.accept 1268 >> Accept Suspicious Hoofprints
step
#completewith next
#sticky
#label Badge
>>Click the Dadge on the plank of wood
.goto Dustwallow Marsh,29.8,48.2
.accept 1269 >> Accept Lieutenant Paval Reethe
step
>>Click the Shield above the fireplace
.goto Dustwallow Marsh,29.6,48.6
.accept 1251 >> Accept The Black Shield
step
#hidewindow
#requires Hoofprints
step
#requires Badge
.goto Dustwallow Marsh,35.1,38.2
.target Mudcrush Durtfeet
>>Talk to |cRXP_FRIENDLY_Mudcrush Durtfeet|r
.accept 1177 >> Accept Hungry!
step << skip
.goto Dustwallow Marsh,35.5,32.0
.fp Brackenwall >> Get the Brackenwall Village flight path

step
.goto Dustwallow Marsh,35.2,30.6
.target Nazeer Bloodpike
>>Talk to |cRXP_FRIENDLY_Nazeer Bloodpike|r
.accept 1201 >> Accept Theramore Spies
step
.goto Dustwallow Marsh,36.41,31.88
.target Krog
>>Talk to |cRXP_FRIENDLY_Krog|r
.turnin 1268 >> Turn in Suspicious Hoofprints
.turnin 1269 >> Turn in Lieutenant Paval Reethe
step
.goto Dustwallow Marsh,36.41,31.88
>>Talk to |cRXP_FRIENDLY_Krog|r
.turnin 1251 >> Turn in The Black Shield
.target Krog
.accept 1321 >> Accept The Black Shield
step
.goto Dustwallow Marsh,36.50,30.80
>>Talk to |cRXP_FRIENDLY_Do'gol|r
.turnin 1321 >> Turn in The Black Shield
.target Do'gol
.accept 1322 >> Accept The Black Shield
step
#sticky
#completewith Infiltrator
.goto Dustwallow Marsh,39.0,21.6,0
.goto Dustwallow Marsh,39.7,23.9,0
.goto Dustwallow Marsh,37.6,26.9,0
.goto Dustwallow Marsh,41.0,25.5,0
.goto Dustwallow Marsh,44.2,27.4,0
.goto Dustwallow Marsh,37.9,37.4,0
.goto Dustwallow Marsh,39.0,21.6,0
>>Kill the Darkfang (Red) spiders in the area. Loot them for Sacs
>> Bloodfen Raptors share spawns with the spiders. Kill them too if needed
.complete 1322,1 
step
.goto Dustwallow Marsh,41.00,36.70
>> Start the escort quest
.target Ogron
>>Talk to |cRXP_FRIENDLY_Ogron|r
.accept 1273 >> Accept Questioning Reethe
step
.goto Dustwallow Marsh,42.50,38.00
>> Escort Ogron
>> When you reach the camp, 4 mobs will spawn, and go through a short rp sequence. When they start attacking, let Ogron aggro one whilst you kill the other 3 using cooldowns.
.complete 1273,1
step
.goto Dustwallow Marsh,46.90,17.50
>> Start the escort quest
.target "Stinky" Ignatz
>>Talk to |cRXP_FRIENDLY_"Stinky" Ignatz|r
.accept 1270 >> Accept Stinky's Escape
step
>> Escort Stinky
.complete 1270,1
step
#completewith next
#sticky
#label Mound
.goto Dustwallow Marsh,55.44,25.92
>> Click on the Dirt Mound
.accept 1238 >> Accept The Lost Report
step
.goto Dustwallow Marsh,55.43,26.26
.target "Swamp Eye" Jarl
>>Talk to |cRXP_FRIENDLY_"Swamp Eye" Jarl|r
.accept 1218 >> Accept Soothing Spices
.turnin 1218 >> Turn in Soothing Spices
.accept 1206 >> Accept Jarl Needs Eyes
step
#requires Mound
.goto Dustwallow Marsh,57.25,20.99
>> Kill Murlocs in the area. Loot them for their heads
.complete 1177,1
step
#sticky
#completewith next
>>Kill some Infiltrators if you come across them en route to spiders. They are stealthed.
.complete 1201,1 
step
.goto Dustwallow Marsh,35.9,20.7,90,0
.goto Dustwallow Marsh,32.8,21.4,90,0
.goto Dustwallow Marsh,34.4,25.2,90,0
.goto Dustwallow Marsh,35.9,20.7,90,0
.goto Dustwallow Marsh,32.8,21.4,90,0
.goto Dustwallow Marsh,34.4,25.2
>>Kill all the Spiders you see. Loot them for Eyes
.complete 1206,1 
step
#label Infiltrator
.goto Dustwallow Marsh,39.0,21.6,70,0
.goto Dustwallow Marsh,39.7,23.9,70,0
.goto Dustwallow Marsh,37.6,26.9,70,0
.goto Dustwallow Marsh,41.0,25.5,70,0
.goto Dustwallow Marsh,44.2,27.4,70,0
.goto Dustwallow Marsh,37.9,37.4,70,0
.goto Dustwallow Marsh,39.0,21.6,70,0
.goto Dustwallow Marsh,39.7,23.9
>>These are stealthed around the area. Find them and kill them
.complete 1201,1 
.unitscan Theramore Infiltrator
step
.goto Dustwallow Marsh,39.0,21.6,70,0
.goto Dustwallow Marsh,39.7,23.9,70,0
.goto Dustwallow Marsh,37.6,26.9,70,0
.goto Dustwallow Marsh,41.0,25.5,70,0
.goto Dustwallow Marsh,44.2,27.4,70,0
.goto Dustwallow Marsh,37.9,37.4,70,0
.goto Dustwallow Marsh,39.0,21.6,70,0
.goto Dustwallow Marsh,39.96,14.10
>>Kill the Darkfang (Red) spiders in the area. Loot them for Sacs
.complete 1322,1 
step
.goto Dustwallow Marsh,35.30,30.70
.target Nazeer Bloodpike
>>Talk to |cRXP_FRIENDLY_Nazeer Bloodpike|r
.turnin 1201 >> Turn in Theramore Spies
.turnin 1238 >> Turn in The Lost Report
step
.goto Dustwallow Marsh,35.30,30.70
.target Nazeer Bloodpike
>>Talk to |cRXP_FRIENDLY_Nazeer Bloodpike|r
.accept 1202 >> Accept The Theramore Docks
#softcore
step
.goto Dustwallow Marsh,36.50,30.80
>>Talk to |cRXP_FRIENDLY_Do'gol|r
.turnin 1322 >> Turn in The Black Shield
.target Do'gol
.accept 1323 >> Accept The Black Shield
step
.goto Dustwallow Marsh,36.50,31.80
>>Talk to |cRXP_FRIENDLY_Krog|r
.turnin 1323 >> Turn in The Black Shield
.turnin 1273 >> Turn in Questioning Reethe
.target Krog
.accept 1276 >> Accept The Black Shield
step
.goto Dustwallow Marsh,35.20,38.30
.target Mudcrush Durtfeet
>>Talk to |cRXP_FRIENDLY_Mudcrush Durtfeet|r
.turnin 1177 >> Turn in Hungry!
step
.goto Dustwallow Marsh,55.40,25.90
>>Click on the dirt mound outside the house
.accept 1239 >> Accept The Severed Head
step
.goto Dustwallow Marsh,55.43,26.26
.target "Swamp Eye" Jarl
>>Talk to |cRXP_FRIENDLY_"Swamp Eye" Jarl|r
.turnin 1206 >> Turn in Jarl Needs Eyes
step
#era
.goto Dustwallow Marsh,46.878,17.517
.xp 37+67550 >> Grind to 67550+/76100xp
#softcore
step
#era
.goto Dustwallow Marsh,46.878,17.517
.xp 37+70300 >> Grind to 70300+/76100xp
#hardcore
step
#som
.goto Dustwallow Marsh,46.878,17.517
.xp 37+64130 >> Grind to 64130+/76100xp
#softcore
step
#som
.goto Dustwallow Marsh,46.878,17.517
.xp 37+67980 >> Grind to 67980+/76100xp
#hardcore
step
.goto Dustwallow Marsh,71.50,51.30
>> Swim along the eastern side of Theramore. Be VERY careful of guards. Look in the water for a chest. Open it and loot the Documents
.complete 1202,1
#softcore
step
#completewith next
.goto Dustwallow Marsh,69.60,49.96
.deathskip >> Die and respawn back at the Spirit Healer
#softcore
step
.isQuestTurnedIn 1238
.goto Dustwallow Marsh,35.30,30.70
>>Talk to |cRXP_FRIENDLY_Nazeer Bloodpike|r
.turnin 1239 >> Turn in The Severed Head
.target Nazeer Bloodpike
.accept 1240 >> Accept The Troll Witchdoctor
step
.goto Dustwallow Marsh,35.30,30.70
.target Nazeer Bloodpike
>>Talk to |cRXP_FRIENDLY_Nazeer Bloodpike|r
.turnin 1202 >> Turn in The Theramore Docks
#softcore
step
.goto Dustwallow Marsh,35.6,31.9
.fly Gadgetzan >> Fly to Gadgetzan
step
.goto Thousand Needles,80.2,75.8
>>Talk to |cRXP_FRIENDLY_Pozzik|r
.turnin 1183 >> Turn in Goblin Sponsorship
.target Pozzik
.accept 1186 >> Accept The Eighteenth Pilot
step
.goto Thousand Needles,80.328,76.094
>>Talk to |cRXP_FRIENDLY_Razzeric|r
.turnin 1186 >> Turn in The Eighteenth Pilot
.target Razzeric
.accept 1187 >> Accept Razzeric's Tweaking
step << Druid
#label dustwallowskip1
>> Use the spell Teleport to Moonglade
.goto Moonglade,52.526,40.565
.trainer >> Go and train your class spells
step
#label dustwallowskip1
.hs >> Hearth to Orgrimmar, if hearth is not up fly instead.
>> Buy food/water if needed
step
#sticky
.abandon 1186 >> Abandon Goblin Sponsorship
step << Shaman
.goto Orgrimmar,38.6,36.0
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,66.046,18.526
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
step << Priest
.goto Orgrimmar,35.6,87.8
.trainer >> Go and train your class spells
step << !Mage
.zone Tirisfal Glades >> Run back up the Zeppelin Tower. Take the Zeppelin to Undercity
step << Mage
.zone Undercity >> Teleport to Undercity
step << Mage
.goto Undercity,85.13,10.03
.trainer >> Train your class spells
>>Make sure you save at least 30 silver for later
step << Mage
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy three Runes of Teleportation (or more if you want)
.collect 17031,3 
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 30-40
#classic
<< Horde
#name 38-39 Alterac/Arathi
#next 39-40 Badlands
step
.goto Undercity,50.2,68.8
.target Apothecary Zinge
>>Talk to |cRXP_FRIENDLY_Apothecary Zinge|r
.accept 232 >> Accept Errand for Apothecary Zinge
step
.goto Undercity,58.5,55.4
>>Talk to |cRXP_FRIENDLY_Alessandro Luca|r
.turnin 232 >> Turn in Errand for Apothecary Zinge
.target Alessandro Luca
.accept 238 >> Accept Errand for Apothecary Zinge
step
.goto Undercity,49.9,67.9
>>Talk to |cRXP_FRIENDLY_Apothecary Zinge|r
.turnin 238 >> Turn in Errand for Apothecary Zinge
.target Apothecary Zinge
.accept 243 >> Accept Into the Field
step << Hunter
.goto Undercity,58.6,33.0
>> Buy a Great Axe if you're melee weaving. Otherwise, skip this step
.collect 2531,1
step << Hunter
.goto Undercity,54.7,38.6
>> Talk to Abigail. Buy a Massive Longbow. if it's not in the shop, skip this step and buy it in a capital city later.
.collect 11307,1
step << Rogue
.goto Undercity,58.66,33.07
>> Talk to Geoffrey. Buy a Rondel and a Falchion
.collect 2534,1
.collect 2528,1
step << Priest
.goto Undercity,69.54,26.93
.collect 5239,1 >> Talk to Zane. Buy a Blackbone Wand
step << Warrior
.goto Undercity,77.48,49.60
.vendor 4592 >> Go to Nathaniel. Buy 2 stacks of level 35 thrown from him. Equip them for later
step << Warrior
#softcore
#completewith next
>>You can also buy these items now to save a LOT of time (if you have the money)
.collect 4480,8
.collect 4479,8
.collect 4481,8
.collect 3357,8
step << !Warrior
#softcore
.goto Undercity,64.3,35.8
>> Go to the Auction house and buy an Elixir of Water Breathing. This will make your life a LOT easier in the future
.collect 5996,1
step << Warrior
#softcore
.goto Undercity,64.3,35.8
>> Go to the Auction house and buy an Elixir of Water Breathing and Nature Protection Potions
.collect 5996,1
.collect 6052,2
step << Warrior
#completewith next
.goto Undercity,63.27,48.59
.fly Hammerfall >> Fly to Hammerfall
step << Warrior
.goto Arathi Highlands,66.72,29.72
#label Cresting
>>Kill Cresting Exiles. Loot them for their Charms
.collect 4481,8
step << Warrior
>>Kill Thundering Exiles. Loot them for their Charms
>>Be careful as these mobs can be difficult
.goto Arathi Highlands,52.06,50.60
.collect 4480,8
step << Warrior
>>Kill Burning Exiles. Loot them for their Charms
.goto Arathi Highlands,25.47,30.09
.collect 4479,8
step << !Warrior
.goto Undercity,63.27,48.59
.fly Tarren Mill >> Fly to Tarren Mill
step
.goto Hillsbrad Foothills,61.498,20.933
.target Keeper Bel'varil
>>Talk to |cRXP_FRIENDLY_Keeper Bel'varil|r
.accept 557 >> Accept Bracers of Binding
step
.goto Hillsbrad Foothills,61.6,20.6
.target Magus Wordeen Voidglare
>>Talk to |cRXP_FRIENDLY_Magus Wordeen Voidglare|r
.accept 545 >> Accept Dalaran Patrols
step
.goto Hillsbrad Foothills,62.60,20.70
.accept 566 >> Accept WANTED: Baron Vardus
step
.goto Hillsbrad Foothills,63.20,20.70
.target Krusk
>>Talk to |cRXP_FRIENDLY_Krusk|r
.accept 503 >> Accept Gol'dir
step << Warrior
#softcore
#completewith Whirlwind
+If you didn't get the Nature Protection Potions from the Auction House, it is VERY important that you watch this video on how to cheese Cyclonian for the Whirlwind Axe
.link https://www.youtube.com/watch?v=BiuWeMSHEhA >> CLICK HERE
step << Warrior
#hardcore
#completewith Whirlwind
+it is VERY important that you watch this video on how to cheese Cyclonian for the Whirlwind Axe
.link https://www.youtube.com/watch?v=BiuWeMSHEhA >> CLICK HERE
step << Warrior
#softcore
>>Use one of your nature protection potions en route to here if you bought them
.goto Alterac Mountains,80.497,66.919
.turnin 1714 >> Turn in Essence of the Exile
step << Warrior
#hardcore
.goto Alterac Mountains,80.497,66.919
.turnin 1714 >> Turn in Essence of the Exile
step << Warrior
.goto Alterac Mountains,80.497,66.919
>>Talk to |cRXP_FRIENDLY_Bath'rah the Windwatcher|r
.turnin 1712 >>Turn in Cyclonian
.target Bath'rah the Windwatcher
.accept 1713 >>Accept The Summoning
step << Warrior
#softcore
#label Whirlwind
>>Follow the NPC that's about to spawn Cyclonian. Make sure you equipped your throwns from earlier if you didn't get the Nature Protection Potions
>>If you have another Nature Protection Potion, use it when your current one wears off
>>Kill and loot Cyclonian for the Whirlwind Heart
.goto Alterac Mountains,80.6,62.2
.complete 1713,1 
step << Warrior
#hardcore
#label Whirlwind
>>Follow the NPC that's about to spawn Cyclonian. Make sure you equipped your throwns from earlier
>>Kill and loot Cyclonian for the Whirlwind Heart
.goto Alterac Mountains,80.6,62.2
.complete 1713,1 
step << Warrior
>> Pick the Axe
.goto Alterac Mountains,80.497,66.919
.target Bath'rah the Windwatcher
>>Talk to |cRXP_FRIENDLY_Bath'rah the Windwatcher|r
.turnin 1713 >>Turn in The Summoning
.turnin 1792 >>Turn in Whirlwind Weapon
step
.goto Alterac Mountains,63.20,43.90
>> Kill Jailor Borhuin. Loot him for his key
.complete 503,1
.unitscan Jailor Borhuin
step
.goto Alterac Mountains,60.00,43.80
>>Talk to |cRXP_FRIENDLY_Gol'dir|r
.turnin 503 >> Turn in Gol'dir
.target Gol'dir
.accept 506 >> Accept Blackmoore's Legacy
step
.goto Alterac Mountains,62.10,82.50
>>Talk to |cRXP_FRIENDLY_Krusk|r
.turnin 506 >> Turn in Blackmoore's Legacy
.target Krusk
.accept 507 >> Accept Lord Aliden Perenolde
step
#sticky
#completewith next
.goto Alterac Mountains,42.2,77.8,90,0
.goto Alterac Mountains,46.2,78.2,90,0
>>Kill Mountain Lions around the area for a Carcass if you didn't get one before, or it expired
.collect 5810,1
step
>>Use your Fresh Carcass on the Flame of Uzel inside the cave to summon Frostmaw. Kill and loot him for his Mane.
>>Be careful, as this quest can be quite hard.
.goto Alterac Mountains,37.5,66.2
.complete 1136,1 
step
.goto Alterac Mountains,10.3,78.5,90,0
.goto Alterac Mountains,20.5,75.2,90,0
.goto Alterac Mountains,21.3,53.5,90,0
.goto Alterac Mountains,17.8,56.2,90,0
.goto Alterac Mountains,21.3,53.5,90,0
.goto Alterac Mountains,20.5,75.2,90,0
.goto Alterac Mountains,10.3,78.5
>>Kill the Rock Elementals in the area. Loot them for their Bracers. Kill Summoners too
.complete 545,2 
.complete 557,1 
.complete 545,1 
step
#sticky
#completewith next
+This next quest can be quite hard, be extra careful
#hardcore
step
>> On the 2nd floor of the House. He priest bubbles, renews, and sleeps if you have pet/another player with you
.goto Alterac Mountains,39.3,14.6
.complete 507,1 
step
>>Turn in at Elysa behind him
.goto Alterac Mountains,39.298,14.306
>>Talk to |cRXP_FRIENDLY_Elysa|r
.turnin 507 >> Turn in Lord Aliden Perenolde
.target Elysa
.accept 508 >> Accept Taretha's Gift
step
#sticky
#completewith next
+This next quest can be quite hard, be extra careful
#hardcore
step
.goto Alterac Mountains,47.8,17.1,70,0
.goto Alterac Mountains,53.6,20.6,70,0
.goto Alterac Mountains,56.2,26.8,70,0
.goto Alterac Mountains,58.1,29.9,70,0
.goto Alterac Mountains,59.7,43.9
>>Search each camp, as well as the basement inn of Strahnbrad, for Baron Vardus. Kill him and loot his head.
.complete 566,1 
.unitscan Baron Vardus
step
.goto Alterac Mountains,61.10,82.40
.target High Executor Darthalia
>>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 566 >> Turn in WANTED: Baron Vardus
step
.goto Alterac Mountains,62.10,82.50
.target Krusk
>>Talk to |cRXP_FRIENDLY_Krusk|r
.turnin 508 >> Turn in Taretha's Gift
step
.goto Hillsbrad Foothills,61.603,20.847
.target Magus Wordeen Voidglare
>>Talk to |cRXP_FRIENDLY_Magus Wordeen Voidglare|r
.turnin 545 >> Turn in Dalaran Patrols
.target Keeper Bel'varil
>>Talk to |cRXP_FRIENDLY_Keeper Bel'varil|r
.turnin 557 >> Turn in Bracers of Binding
step
.goto Hillsbrad Foothills,60.15,18.63
.fly Hammerfall >> Fly to Hammerfall
step
.goto Arathi Highlands,73.80,33.90
.target Zengu
>>Talk to |cRXP_FRIENDLY_Zengu|r
.turnin 638 >> Turn in Trollbane
step
.goto Arathi Highlands,74.30,33.80
.target Drum Fel
>>Talk to |cRXP_FRIENDLY_Drum Fel|r
.accept 678 >> Accept Call to Arms
step << Rogue
.goto Arathi Highlands,74.718,36.291
.target Tor'gan
>>Talk to |cRXP_FRIENDLY_Tor'gan|r
.accept 673 >> Accept Foul Magics
step
.goto Arathi Highlands,72.70,34.20
.target Gor'mul
>>Talk to |cRXP_FRIENDLY_Gor'mul|r
.accept 675 >> Accept Raising Spirits
step
.goto Arathi Highlands,74.70,36.40
>>Talk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 675 >>Turn in Raising Spirits
.target Tor'gan
.accept 701 >> Accept Guile of the Raptor
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
.goto Arathi Highlands,66.70,29.80
>> Loot the rock in the middle of the elementals
.complete 651,2
step
.goto Arathi Highlands,52.00,50.80
>> Loot the rock in the middle of the elementals
.complete 651,3
step
.goto Arathi Highlands,25.50,30.10
>> Loot the rock in the middle of the elementals
.complete 651,1
step << Rogue
#sticky
#completewith next
+This next quest can be quite hard, be extra careful
#hardcore
step << Rogue
.goto Arathi Highlands,29.4,61.6,90,0
.goto Arathi Highlands,29.6,63.0,90,0
.goto Arathi Highlands,29.4,64.4,90,0
.goto Arathi Highlands,29.4,61.6
>>Kill Marez Cowl. Loot her for the Befouled Bloodstone Orb (she's not inside the buildings), you can stealth to her, usually she is on the left side.
.complete 673,1 
step
.goto Arathi Highlands,36.20,57.30
.turnin 651 >> Turn in Stones of Binding
.accept 652 >> Accept Breaking the Keystone
step << Hunter
#sticky
>> Use Eagle Eye to find Fozruk
>>Make sure to kill Sleeby and the rest of the kobolds first, you can kill one add at a time and reset the fight
>>Kill Fozruk by kiting him around Refuge Point
>>This is a difficult quest solo, consider skipping this step if you can't group up
.complete 652,1
.link https://www.twitch.tv/videos/778346703 >> Click here for video reference
.unitscan Fozruk
step << !Hunter
#sticky
>> Find and kill Fozruk but don't go out of your way to finish this step, he patrols the whole zone
>>This is a VERY HARD elite to solo, consider skipping this step if you're not able to group up << !Warlock
>>Fozruk can be feared, and Sleeby can heal, this is a VERY HARD quest to solo, consider skipping this step if you're not able to group up << Warlock
.complete 652,1
.link https://www.twitch.tv/videos/669107037?t=05h51m54s >> Click here for video reference
.unitscan Fozruk
step
#sticky
#label Graptor
>>Kill Raptors. Loot them for their Hearts
.goto Arathi Highlands,46.81,78.45
.complete 701,1
step
>>Kill Ogres in the area
.goto Arathi Highlands,53.26,74.19
.complete 678,1
.complete 678,2
step
#requires Graptor
.goto Arathi Highlands,36.07,58.09
>> Skip this step if you haven't found Fozruk
>>After turning in this quest, an elite mob will spawn, be ready to run away
.turnin 652 >> Turn in Breaking the Keystone
step
.goto Arathi Highlands,36.07,58.09
.accept 688 >> Accept Myzrael's Allies
.isQuestTurnedIn 652
step
.goto Arathi Highlands,74.70,36.40
>>Talk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 673 >> Turn in Foul Magics << Rogue
.turnin 701 >> Turn in Guile of the Raptor
.target Tor'gan
.accept 702 >> Accept Guile of the Raptor
step
.goto Arathi Highlands,74.40,35.60
>>Talk to |cRXP_FRIENDLY_Zaruk|r
.turnin 688 >> Turn in Myzrael's Allies
.target Zaruk
.target Gerrig Bonegrip
>>Talk to |cRXP_FRIENDLY_Gerrig Bonegrip|r

.accept 687 >> Accept Theldurin the Lost
.isQuestTurnedIn 652
step
.goto Arathi Highlands,72.70,34.20
.target Gor'mul
>>Talk to |cRXP_FRIENDLY_Gor'mul|r
.turnin 702 >> Turn in Guile of the Raptor
step
.goto Arathi Highlands,74.20,33.90
.target Drum Fel
>>Talk to |cRXP_FRIENDLY_Drum Fel|r
.turnin 678 >> Turn in Call to Arms
step
.goto Arathi Highlands,72.80,34.10
.target Gor'mul
>>Talk to |cRXP_FRIENDLY_Gor'mul|r
.accept 847 >> Accept Guile of the Raptor
step
.goto Arathi Highlands,74.70,36.40
.target Tor'gan
>>Talk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 847 >> Turn in Guile of the Raptor
step
.goto Arathi Highlands,21.6,75.6,30,0
.goto Arathi Highlands,22.1,79.9,25 >> Run through the cave to Faldir's Cove
step
.goto Arathi Highlands,31.9,82.6
.target Lolo the Lookout
>>Talk to |cRXP_FRIENDLY_Lolo the Lookout|r
.accept 663 >> Accept Land Ho!
step
.goto Arathi Highlands,32.3,81.5
.target Shakes O'Breen
>>Talk to |cRXP_FRIENDLY_Shakes O'Breen|r
.turnin 663 >> Turn in Land Ho!
step
.goto Arathi Highlands,33.0,81.4
.target First Mate Nilzlix
>>Talk to |cRXP_FRIENDLY_First Mate Nilzlix|r
.accept 662 >> Accept Deep Sea Salvage
step
.goto Arathi Highlands,33.9,80.7
.target Captain Steelgut
>>Talk to |cRXP_FRIENDLY_Captain Steelgut|r
.accept 664 >> Accept Drowned Sorrows
.target Professor Phizzlethorpe
>>Talk to |cRXP_FRIENDLY_Professor Phizzlethorpe|r
.accept 665 >> Accept Sunken Treasure
step
>>Two water elementals will spawn when Phizzle kneels at the stone. Attack them before they aggro onto Phizzle. Kill them
.goto Arathi Highlands,35.7,79.7
.complete 665,1 
step
.goto Arathi Highlands,33.8,80.5
>>Talk to |cRXP_FRIENDLY_Doctor Draxlegauge|r
.turnin 665 >> Turn in Sunken Treasure
.target Doctor Draxlegauge
.accept 666 >> Accept Sunken Treasure
step
#sticky
#completewith next
+These water quests can be quite hard, make sure to always get air after each mob and the warriors can net you.
#hardcore
step
#completewith next
+Use the Water Breathing Potion you bought from the Auction House.
#softcore
step << !Druid !Warlock !Shaman
#softcore
#completewith SLog
>>Elven Gems are big stones located on the sea floor. Equip your Goggles of Gem hunting to see them on the minimap.
.complete 666,1 
step << !Druid !Warlock !Shaman
#hardcore
#completewith SLog
>>Be VERY careful of your breath. Elven Gems are big stones located on the sea floor. Equip your Goggles of Gem hunting to see them on the minimap.
.complete 666,1 
step << Warlock/Shaman
#completewith SLog
>>Use your Water Breathing spell. Elven Gems are big stones located on the sea floor. Equip your Goggles of Gem Hunting to see them on the minimap.
.complete 666,1 
step << Druid
#completewith SLog
>>Use your Aquatic Form when your breath gets low. Elven Gems are big stones located on the sea floor. Equip your Goggles of Gem Hunting to see them on the minimap.
.complete 666,1 
step
#sticky
#completewith SLog
>>Kill the Nagas in the area
.complete 664,1 
.complete 664,2 
step
>>2nd floor of the ship, in the cauldron
.goto Arathi Highlands,23.4,85.1
.complete 662,2 
step
>>2nd floor of the ship on the pillar
.goto Arathi Highlands,23.0,84.5
.complete 662,1 
step
>>2nd floor of other ship, top of the crate next to the cannon
.goto Arathi Highlands,20.5,85.6
.complete 662,3 
step
#label SLog
>>Bottom of the ship on the ground of the sea floor
.goto Arathi Highlands,20.6,85.1
.complete 662,4 
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
.complete 666,1 
step
.goto Arathi Highlands,19.3,84.1,90,0
.goto Arathi Highlands,17.7,89.5,90,0
.goto Arathi Highlands,25.5,90.8,90,0
.goto Arathi Highlands,24.1,85.7,90,0
.goto Arathi Highlands,23.2,89.7,90,0
.goto Arathi Highlands,19.3,84.1
>>Finish killing the Nagas in the area
.complete 664,1 
.complete 664,2 
step
#requires ElvenGems
.goto Arathi Highlands,32.8,81.3
.target First Mate Nilzlix
>>Talk to |cRXP_FRIENDLY_First Mate Nilzlix|r
.turnin 662 >> Turn in Deep Sea Salvage
>>Re-equip your helm
step
.goto Arathi Highlands,33.9,80.6
>>Talk to |cRXP_FRIENDLY_Doctor Draxlegauge|r
.turnin 666 >> Turn in Sunken Treasure
.target Doctor Draxlegauge
.accept 668 >> Accept Sunken Treasure
step
.goto Arathi Highlands,34.003,80.796
.target Captain Steelgut
>>Talk to |cRXP_FRIENDLY_Captain Steelgut|r
.turnin 664 >> Turn in Drowned Sorrows
step
.goto Arathi Highlands,32.2,81.5
>>Talk to |cRXP_FRIENDLY_Shakes O'Breen|r
.turnin 668 >> Turn in Sunken Treasure
.target Shakes O'Breen
.accept 669 >> Accept Sunken Treasure
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 30-40
#classic
<< Horde
#name 39-40 Badlands
#next RestedXP Horde 40-50\40-41 Stranglethorn Vale
step
.maxlevel 40,badlandsskip
.goto Wetlands,32.78,13.12
.zone Wetlands >> Swim to Wetlands
step
.goto Wetlands,53.86,46.42,150,0
.goto Wetlands,63.9,78.6
.zone Loch Modan >> Logout on top of the mushrooms at the back of the cave. When you log back in, this will teleport you to just outside of Thelsamar
.link https://www.youtube.com/watch?v=21CuGto26Mk >> CLICK HERE for a reference
>>be VERY careful not to move forward when you log in as there are level 30-40 guards around and you may get PVP flagged. Instead run to the other side of the road and try to avoid the guards
step
#completewith next
.goto Loch Modan,25.34,67.27,0
.goto Loch Modan,24.76,70.59,30,0
.goto Loch Modan,25.10,72.98,30,0
.goto Loch Modan,26.11,75.42,30,0
.goto Loch Modan,23.27,81.30,30,0
.goto Loch Modan,22.82,84.81,30,0
.goto Loch Modan,19.59,87.23,30,0
.goto Loch Modan,20.37,91.08,30,0
.goto Loch Modan,22.33,91.55,30,0
.goto Loch Modan,22.87,94.92,30,0
.goto Badlands,5.73,29.78,0
>>Use the shortcut to get to Badlands faster
.zone Badlands >> Run to the Badlands
.link https://www.youtube.com/watch?v=oNFXup-DCM0 >> CLICK HERE
step
.goto Badlands,4.1,44.7
.fp Kargath >> Get the Kargath Flight Path
step
#level 40
.goto Badlands,2.915,45.604
.target Gorn
>>Talk to |cRXP_FRIENDLY_Gorn|r
.accept 782 >> Accept Broken Alliances
>>Skip this step if you're not level 40
step
.goto Badlands,2.6,46.1
.target Jarkal Mossmeld
>>Talk to |cRXP_FRIENDLY_Jarkal Mossmeld|r
.accept 2258 >> Accept Badlands Reagent Run
step
.goto Badlands,6.4,47.5
.target Neeka Bloodscar
>>Talk to |cRXP_FRIENDLY_Neeka Bloodscar|r
.accept 1419 >> Accept Coyote Thieves
step
#era
.goto Badlands,6.4,47.0
.target Neeka Bloodscar
>>Talk to |cRXP_FRIENDLY_Neeka Bloodscar|r
.accept 1420 >> Accept Report to Helgrum
step
.goto Badlands,25.8,45.0
.target Lotwil Veriatus
>>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r
.accept 710 >> Accept Study of the Elements: Rock
step
#completewith badlandsall
>>Complete these as you quest through Badlands.
.complete 2258,1 
.complete 1419,1 
.complete 2258,2 
.complete 703,1 
step
.goto Badlands,23.2,47.0,90,0
.goto Badlands,19.5,46.4,90,0
.goto Badlands,22.1,43.1,90,0
.goto Badlands,12.7,39.5,90,0
.goto Badlands,15.1,32.6,90,0
.goto Badlands,23.2,47.0
>>Kill all of the Elementals you see. Loot the Small Stone Shards from the lesser Elementals, and the Rock Elemental Shards from both
.complete 2258,3 
.complete 710,1 
step
#label badlandsall
.goto Badlands,25.948,44.869
>>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r
.turnin 710 >> Turn in Study of the Elements: Rock
.target Lotwil Veriatus
.accept 711 >> Accept Study of the Elements: Rock
step
#completewith next
>> You do not need to finish the Gizzards yet, these can be done later or throughout the zone.
.complete 2258,1 
step
.goto Badlands,18.0,56.6
.complete 703,1 
step
#completewith badlands3
.complete 2258,1 
.complete 1419,1 
.complete 2258,2 
step
#era
.goto Badlands,23.2,47.0
.xp 40 >> Grind to 40
step
.goto Badlands,2.915,45.604
.target Gorn
>>Talk to |cRXP_FRIENDLY_Gorn|r
.accept 782 >> Accept Broken Alliances
step
.goto Badlands,42.4,52.8
.target Rigglefuzz
>>Talk to |cRXP_FRIENDLY_Rigglefuzz|r
.accept 703 >> Accept Barbecued Buzzard Wings
.turnin 703 >> Turn in Barbecued Buzzard Wing
>>Talk to |cRXP_FRIENDLY_Martek the Exiled|r
.turnin 1106 >> Turn in Martek the Exiled
.target Martek the Exiled
.accept 1108 >> Accept Indurium
step
.isOnQuest 782
#sticky
#label signofearthBL
>>Find & kill Tho'grun. He's an ogre who patrols around the zone with a pack of guards.
>>Kite him away from his guards. Loot him for the Sign of the Earth << !Warlock !Mage
>>Split Pull him away from his guards using Rain of Fire. Loot him for the Sign of the Earth << Warlock
>>Split Pull him away from his guards using Blizzard. Loot him for the Sign of the Earth << Mage
.complete 782,1 
.unitscan Boss Tho'grun
step
.goto Badlands,36.2,75.1,90,0
.goto Badlands,46.0,78.4,90,0
.goto Badlands,42.8,87.2,90,0
.goto Badlands,36.2,75.1,90,0
.goto Badlands,46.0,78.4,90,0
.goto Badlands,42.8,87.2
>>Kill Rock Elementals. Loot them for Large Stone Slabs
.complete 711,1 
step
.goto Badlands,51.387,76.875
.target Theldurin the Lost
>>Talk to |cRXP_FRIENDLY_Theldurin the Lost|r
.turnin 687 >> Turn in Theldurin the Lost
.isOnQuest 687
step
>>Kill Troggs. Loot them for Indurium Flakes
.goto Badlands,50.1,67.2
.complete 1108,1 
step
#label badlands3
.goto Badlands,42.4,52.7
>>Talk to |cRXP_FRIENDLY_Martek the Exiled|r
.turnin 1108 >> Turn in Indurium
.target Martek the Exiled
.accept 1137 >> Accept News for Fizzle
step
#completewith next
>> Kill all the buzzards that you see while you do the Coyote.
.complete 2258,1 
step
.goto Badlands,34.6,66.8
>>Complete these as you quest through Badlands.
.complete 1419,1 
.complete 2258,2 
step
.goto Badlands,18.0,56.6
.complete 2258,1 
step
.goto Badlands,6.4,47.3
.target Neeka Bloodscar
>>Talk to |cRXP_FRIENDLY_Neeka Bloodscar|r
.turnin 1419 >> Turn in Coyote Thieves
step
.goto Badlands,2.4,45.9
.target Jarkal Mossmeld
>>Talk to |cRXP_FRIENDLY_Jarkal Mossmeld|r
.turnin 2258 >> Turn in Badlands Reagent Run
step
#requires signofearthBL
.goto Badlands,2.8,45.6
.target Gorn
>>Talk to |cRXP_FRIENDLY_Gorn|r
.turnin 782 >> Turn in Broken Alliances
.isQuestComplete 782
step
.goto Badlands,25.948,44.869
.target Lotwil Veriatus
>>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r
.turnin 711 >> Turn in Study of the Elements: Rock
step << Druid
>> Use the spell Teleport to Moonglade
.goto Moonglade,52.526,40.565
.trainer >> Go and train your class spells
step
#label badlandsskip
.hs >> Hearth to Orgrimmar
>> Buy food/water if needed
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 40-50
#classic
<< Horde
#name 40-41 Stranglethorn Vale
#next 41-41 Desolace II
step << Shaman
.goto Orgrimmar,38.6,36.0
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,66.046,18.526
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
step << Mage
.goto Orgrimmar,38.8,85.6
.trainer >> Go and train your class spells
step << Priest
.goto Orgrimmar,35.6,87.8
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,78.1,38.4
>> Go and buy a Massive Longbow from Jin'sora. If it's not at the vendor, skip this step
.collect 11307,1
step
.goto Orgrimmar,75.18,34.20
.target Belgrom Rockmaul
>>Talk to |cRXP_FRIENDLY_Belgrom Rockmaul|r
.accept 2981 >> Accept A Threat in Feralas
step
#sticky
.abandon 1106 >> Abandon Martek the Exiled if u didn't do Badlands.
step
#completewith next
.goto Durotar,45.53,11.79,60 >> Run out of Orgrimmar
step
>>Run up the Zeppelin Tower outside of Orgrimmar
.goto Durotar,50.53,12.52
.zone Stranglethorn Vale >> Take the Zeppelin to Stranglethorn Vale
step
.goto Stranglethorn Vale,31.4,29.60
.home >>Set your Hearthstone to Grom'Gol Base Camp
step
.isQuestTurnedIn 1238
.goto Stranglethorn Vale,32.20,27.80
.target Kin'weelay
>>Talk to |cRXP_FRIENDLY_Kin'weelay|r
.turnin 1240 >> Turn in The Troll Witchdoctor
step
.goto Stranglethorn Vale,32.10,27.80
.target Nimboya
>>Talk to |cRXP_FRIENDLY_Nimboya|r
.accept 584 >> Accept Bloodscalp Clan Heads
step
#era
.goto Stranglethorn Vale,32.20,27.70
.target Kin'weelay
>>Talk to |cRXP_FRIENDLY_Kin'weelay|r
.accept 598 >> Accept Split Bone Necklace
step
.goto Stranglethorn Vale,23.40,8.00
>> Kill Gan'Zulah. Loot him for his Head
.complete 584,1
.unitscan Gan'zulah
step
.goto Stranglethorn Vale,23.50,9.50
>> Kill Nezzliok. Loot him for his Head
.complete 584,2
.unitscan Nezzliok the Dire
step
.goto Stranglethorn Vale,32.20,27.60
>> Click on the Bubbling Cauldron
.turnin 584 >> Turn in Bloodscalp Clan Heads
.accept 585 >> Accept Speaking with Nezzliok
step
.goto Stranglethorn Vale,32.10,29.20
.target Far Seer Mok'thardin
>>Talk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.accept 572 >> Accept Mok'thardin's Enchantment
step
.goto Stranglethorn Vale,31.00,42.50
>> Kill Jungle Stalkers. Loot them for Jungle Stalker Feathers
.complete 196,1
.complete 572,1
step
#era
.goto Stranglethorn Vale,41.60,43.60
>> Kill Goblins. Loot them for the Blue Crystals
.complete 600,1
step
#era
#sticky
#completewith SkullP
>>Kill Trolls in the area. Loot them for Tusks and Necklaces
.complete 209,1
step
#som
#sticky
#completewith SkullP
>>Kill Trolls in the area. Loot them for Tusks and Necklaces
.complete 209,1
step
.goto Stranglethorn Vale,42.20,36.10
>> Loot the Skull Pile on the ground
.complete 585,2
step
.goto Stranglethorn Vale,47.60,39.60
>> Loot the Skull Pile on the ground
.complete 585,3
step
#label SkullP
.goto Stranglethorn Vale,46.10,32.30
>> Loot the Skull Pile on the ground
.complete 585,1
step
#som
.goto Stranglethorn Vale,42.25,36.06
>>Kill Trolls in the area. Loot them for Tusks and Necklaces
.complete 209,1
step
#era
.goto Stranglethorn Vale,42.25,36.06
>>Kill Trolls in the area. Loot them for Tusks and Necklaces
.complete 209,1
.complete 598,1
step
#sticky
#completewith next
+This next quest can be quite hard, be extra careful
#hardcore
step
.goto Stranglethorn Vale,47.26,28.58,70,0
.goto Stranglethorn Vale,49.61,23.98,70,0
.goto Stranglethorn Vale,48.95,19.87,70,0
.goto Stranglethorn Vale,47.26,28.58
.goto Stranglethorn Vale,49.61,23.98,0
.goto Stranglethorn Vale,48.95,19.87,0
>> Look for Bhag'thera. Kill and loot him for his Fang
.complete 193,1
.unitscan BHAG'THERA
step
#era
.hs >> Hearth to Grom'Gol
>> Buy food/water if needed
step << Hunter
#era
.goto Stranglethorn Vale,31.55,27.95
.vendor >> Go to Uthok. |cRXP_BUY_Buy arrows until your quiver is full|r
step
#era
.goto Stranglethorn Vale,32.20,27.80
.target Kin'weelay
>>Talk to |cRXP_FRIENDLY_Kin'weelay|r
.turnin 598 >> Turn in Split Bone Necklace
.turnin 585 >> Turn in Speaking with Nezzliok
.accept 1261 >> Accept Marg Speaks
step
#era
.goto Stranglethorn Vale,32.10,29.20
.target Far Seer Mok'thardin
>>Talk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.turnin 572 >> Turn in Mok'thardin's Enchantment
step
.goto Stranglethorn Vale,35.60,10.60
>>Talk to |cRXP_FRIENDLY_Hemet Nesingwary|r
.turnin 196 >> Turn in Raptor Mastery
.target Hemet Nesingwary
.accept 197 >> Accept Raptor Mastery
.target Sir S. J. Erlgadin
>>Talk to |cRXP_FRIENDLY_Sir S. J. Erlgadin|r
.turnin 193 >> Turn in Panther Mastery
step
#som
.hs >> Hearth to Grom'Gol
>> Buy food/water if needed
step << Hunter
#era
.goto Stranglethorn Vale,31.55,27.95
.vendor >> Go to Uthok. Buy |cRXP_BUY_arrows|r until your quiver is full
step
.isQuestComplete 598
.goto Stranglethorn Vale,32.20,27.80
.target Kin'weelay
>>Talk to |cRXP_FRIENDLY_Kin'weelay|r
.turnin 598 >> Turn in Split Bone Necklace
step
.goto Stranglethorn Vale,32.20,27.80
.isQuestTurnedIn 1240
.accept 1261 >> Accept Marg Speaks
step
.goto Stranglethorn Vale,32.20,27.80
.turnin 585 >> Turn in Speaking with Nezzliok
step
#som
.goto Stranglethorn Vale,32.10,29.20
.target Far Seer Mok'thardin
>>Talk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.turnin 572 >> Turn in Mok'thardin's Enchantment
step
#era
#completewith next
.goto Stranglethorn Vale,39.30,6.49,60,0
.goto Stranglethorn Vale,40.60,3.15,50 >> Travel to Duskwood
step
#era
.goto Deadwind Pass,28.10,29.60
.target Deathstalker Zraedus
>>Talk to |cRXP_FRIENDLY_Deathstalker Zraedus|r
.accept 1372 >> Accept Nothing But The Truth
.target Apothecary Faustin
>>Talk to |cRXP_FRIENDLY_Apothecary Faustin|r
.turnin 1372 >> Turn in Nothing But The Truth
step
#era
#completewith next
.goto Duskwood,88.47,41.00,50 >> Travel to Deadwind Pass
step
#era
.goto Deadwind Pass,48.02,34.60,60,0
.goto Deadwind Pass,58.43,41.51,50 >> Travel to Swamp of Sorrows
step
#era
#completewith next
.goto Swamp of Sorrows,14.32,59.97,100 >> Head to where the Whelps are
step
#era
#completewith next
.goto Swamp of Sorrows,13.27,67.96,0
.goto Swamp of Sorrows,16.68,54.52,0
>>Kill the Whelps in the area. Loot them for Dream Dust
>>You won't find enough Whelps to finish this quest in the first loop
>>Head to Stonard after the first loop
.complete 1116,1
step
#era
.goto Swamp of Sorrows,44.70,57.10
.target Dar
>>Talk to |cRXP_FRIENDLY_Dar|r
.accept 698 >> Accept Lack of Surplus
step
#era
.goto Swamp of Sorrows,46.10,54.70
.fp Stonard >> Get the Stonard Flight Path
step
#era
.goto Swamp of Sorrows,47.80,55.20
.target Helgrum the Swift
>>Talk to |cRXP_FRIENDLY_Helgrum the Swift|r
.turnin 1420 >> Turn in Report to Helgrum
.target Fel'zerul
>>Talk to |cRXP_FRIENDLY_Fel'zerul|r
.accept 1424 >> Accept Pool of Tears
step
#era
#sticky
.goto Swamp of Sorrows,57.68,38.36,0
>> Kill Sawtooth Crocolisks and Sawtooth Snappers. Loot them for Sawtooth Flanks
.complete 698,1
step
#era
.goto Swamp of Sorrows,47.10,38.83
>> Kill Noboru, loot him for the Cudgel, then click it. He patrols around the top-center of the zone
.collect 6196,1,1392
.accept 1392 >> Accept Noboru the Cudgel
.unitscan NOBORU THE CUDGEL
step
#era
.goto Swamp of Sorrows,26.00,31.40
.target Magtoor
>>Talk to |cRXP_FRIENDLY_Magtoor|r
.accept 1389 >> Accept Draenethyst Crystals
.turnin 1392 >> Turn in Noboru the Cudgel
step
#era
#completewith Draene
>> Kill Ongeku. Loot him for his Shard. He can be found all over the Fallow Sanctuary
.complete 1373,1
.isOnQuest 1373
.unitscan Ongeku
step
#era
#sticky
#completewith GalenE
.goto Swamp of Sorrows,63.26,22.35,0
>> Loot 6 Blue Crystals around the wooden huts
.complete 1389,1
step
#era
#sticky
#completewith next
+This next quest can be quite hard, be extra careful
#hardcore
step
#era
#label Galen
.goto Swamp of Sorrows,65.46,18.16
>> Accepting this quest will start an escort. Try clearing out the mobs around the camp 40 yards south from Galen before starting this quest
.target Galen Goodward
>>Talk to |cRXP_FRIENDLY_Galen Goodward|r
.accept 1393 >> Accept Galen's Escape
step
#era
#label GalenE
>> Escort Galen
.complete 1393,1
step
#era
#label Draene
.goto Swamp of Sorrows,63.26,22.35
>> Finish off Draenethyst Crystals
.complete 1389,1
step
#era
.goto Swamp of Sorrows,64.74,22.46
>> Kill Ongeku. Loot him for his Shard. He can be found all over the Fallow Sanctuary
.complete 1373,1
.isOnQuest 1373
.unitscan Ongeku
step
#era
.goto Swamp of Sorrows,47.80,39.75
>> Click on Galen's Strongbox
.turnin 1393 >> Turn in Galen's Escape
step
#era
.goto Swamp of Sorrows,57.68,38.36
>> Kill Sawtooth Crocolisks and Sawtooth Snappers. Loot them for Sawtooth Flanks
.complete 698,1
step
#era
.goto Swamp of Sorrows,81.40,81.00
>>Talk to |cRXP_FRIENDLY_Tok'Kar|r
.turnin 698 >> Turn in Lack of Surplus
.target Tok'Kar
.accept 699 >> Accept Lack of Surplus
step
#era
>>Loot the various artifacts found underwater in the lake
.goto Swamp of Sorrows,71.40,61.25
.complete 1424,1
step
#era
>>Run back to Stonard
.goto Swamp of Sorrows,48.00,54.90
.target Fel'zerul
>>Talk to |cRXP_FRIENDLY_Fel'zerul|r
.turnin 1424 >> Turn in Pool of Tears
step
#era
.goto Swamp of Sorrows,25.90,31.50
.target Magtoor
>>Talk to |cRXP_FRIENDLY_Magtoor|r
.turnin 1392 >> Turn in Noboru the Cudgel
.turnin 1389 >> Turn in Draenethyst Crystals
step
#era
.goto Swamp of Sorrows,13.96,61.67
>> Kill Whelps. Loot them for Dream Dust
.complete 1116,1
step
#era
.hs >> Hearth back to Grom'Gol
>> Buy food/water if needed
step
.goto Stranglethorn Vale,32.54,29.36
.fly Booty Bay >> Fly to Booty Bay
step
#era
>>Top floor of the Inn
.goto Stranglethorn Vale,27.00,77.20
.target Krazek
>>Talk to |cRXP_FRIENDLY_Krazek|r
.turnin 1116 >> Turn in Dream Dust in the Swamp
.target Kebok
>>Talk to |cRXP_FRIENDLY_Kebok|r
.turnin 209 >> Turn in Skullsplitter Tusks
step
#som
>>Top floor of the Inn
.goto Stranglethorn Vale,27.00,77.10
.target Kebok
>>Talk to |cRXP_FRIENDLY_Kebok|r
.turnin 209 >> Turn in Skullsplitter Tusks
step
>>Balcony of the Inn
.goto Stranglethorn Vale,27.10,77.00
.target Fleet Master Seahorn
>>Talk to |cRXP_FRIENDLY_Fleet Master Seahorn|r
.turnin 669 >> Turn in Sunken Treasure
.target Baron Revilgaz
>>Talk to |cRXP_FRIENDLY_Baron Revilgaz|r
.accept 1183 >> Accept Goblin Sponsorship
step
#era
.goto Stranglethorn Vale,27.00,77.20
.target Krazek
>>Talk to |cRXP_FRIENDLY_Krazek|r
.accept 1117 >> Accept Rumors for Kravel
.accept 2864 >> Accept Tran'rek
step
#som
.goto Stranglethorn Vale,27.00,77.20
.target Krazek
>>Talk to |cRXP_FRIENDLY_Krazek|r
.accept 2864 >> Accept Tran'rek
step
#era
.goto Stranglethorn Vale,27.10,77.30
.target Crank Fizzlebub
>>Talk to |cRXP_FRIENDLY_Crank Fizzlebub|r
.turnin 600 >> Turn in Venture Company Mining
step
.goto Stranglethorn Vale,27.70,77.10
.target "Sea Wolf" MacKinley
>>Talk to |cRXP_FRIENDLY_"Sea Wolf" MacKinley|r
.accept 2872 >> Accept Stoley's Debt
step
#completewith next
.goto Stranglethorn Vale,25.90,73.14,40 >> Run to the Booty Bay Dock
step
.goto Stranglethorn Vale,25.76,73.04
.zone The Barrens >> Take the Boat to Ratchet
step
.isQuestComplete 1270
.goto The Barrens,62.40,37.60
.target Mebok Mizzyrix
>>Talk to |cRXP_FRIENDLY_Mebok Mizzyrix|r
.turnin 1270 >> Turn in Stinky's Escape
step
#era
.goto The Barrens,63.08,37.16
.fly Camp Taurajo >> Fly to Camp Taurajo
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 40-50
#classic
<< Horde
#name 41-41 Desolace II
#next 41-43 Tanaris/Dustwallow
#somname 41-41 Thunder Bluff

step
#era
.goto The Barrens,45.6,59.0
.home >> Set your Hearthstone to Camp Taurajo
step << !Mage
.goto The Barrens,44.45,59.15
.fly Thunder Bluff >> Fly to Thunder Bluff
step << Mage
.zone Thunder Bluff >> Teleport to Thunder Bluff
step
.goto Thunder Bluff,54.00,80.90
.target Mosarn
>>Talk to |cRXP_FRIENDLY_Mosarn|r
.turnin 1276 >> Turn in The Black Shield
step
.goto Thunder Bluff,61.40,80.70
.target Melor Stonehoof
>>Talk to |cRXP_FRIENDLY_Melor Stonehoof|r
.accept 1205 >> Accept Deadmire
step
.goto Thunder Bluff,61.40,80.70
.target Melor Stonehoof
>>Talk to |cRXP_FRIENDLY_Melor Stonehoof|r
.turnin 1136 >> Turn in Frostmaw
step
#era
.goto Thunder Bluff,47.00,49.83
.fly Desolace >> Fly to Desolace
step
#era
.goto Desolace,25.80,68.20
.target Taiga Wisemane
>>Talk to |cRXP_FRIENDLY_Taiga Wisemane|r
.accept 5581 >> Accept Portals of the Legion
step
#era
.goto Desolace,36.30,79.20
>>Talk to |cRXP_FRIENDLY_Uthek the Wise|r
.turnin 1373 >> Turn in Ongeku
.target Uthek the Wise
.accept 1374 >> Accept Khan Jehn
step
#era
.goto Desolace,47.80,61.80
.target Hornizz Brimbuzzle
>>Talk to |cRXP_FRIENDLY_Hornizz Brimbuzzle|r
.accept 6134 >> Accept Ghost-o-plasm Round Up
step
#era
.goto Desolace,52.20,53.50
.target Maurin Bonesplitter
>>Talk to |cRXP_FRIENDLY_Maurin Bonesplitter|r
.accept 1484 >> Accept The Corrupter
step
#era
.goto Desolace,52.60,54.30
>>Talk to |cRXP_FRIENDLY_Takata Steelblade|r
.turnin 1484 >> Turn in The Corrupter
.target Takata Steelblade
.accept 1488 >> Accept The Corrupter
step
#era
#completewith KhanJ
.goto Desolace,53.36,79.47,0
>>Use the Hand of Iruxos to close the purple portals in the area
>>You don't need to finish this now, you can do it later
.complete 5581,1
step
#era
#sticky
#completewith next
+This next quest can be quite hard, be extra careful
#hardcore
step
#era
#completewith next
.goto Desolace,55.90,77.80,0
>> Kill Lord Azrethoc, this can be quite hard, but should be doable on all classes with cooldowns.
>> He patrols all around the edges of Mannoroc Cavern
.complete 1488,1
.unitscan Lord Azrethoc
step
#era
#label Jugkar
.goto Desolace,55.90,77.80
>> Kill Jugkar Grim'rod
.complete 1488,2
step
#era
#label Azrethoc
.goto Desolace,55.90,77.80
>> Kill Lord Azrethoc, this can be quite hard, but should be doable on all classes with cooldowns.
>> He patrols all around the edges of Mannoroc Cavern
.complete 1488,1
.unitscan Lord Azrethoc
step
#era
#label KhanJ
.goto Desolace,66.30,80.10
>> Kill Khan Jehn. Loot him for his Head
.complete 1374,1
step
#era
.goto Desolace,64.00,91.70
>> At the Valley of Bones, use the Crate of Ghost Magnets in your inventory. Kill the Ghosts that spawn. Loot them for the Ghost-O-Plasm
.complete 6134,1
step
#era
.goto Desolace,53.36,79.47
>>Use the Hand of Iruxos to close the purple portals in the area
.complete 5581,1
step
#era
.goto Desolace,36.30,79.30
.target Uthek the Wise
>>Talk to |cRXP_FRIENDLY_Uthek the Wise|r
.turnin 1374 >> Turn in Khan Jehn
step
#era
.goto Desolace,25.81,68.21
.target Taiga Wisemane
>>Talk to |cRXP_FRIENDLY_Taiga Wisemane|r
.turnin 5581 >> Turn in Portals of the Legion
step
#era
#softcore
.goto Desolace,33.90,53.60
>> Start the escort quest
>> Be careful, as this quest is HARD
.target Melizza Brimbuzzle
>>Talk to |cRXP_FRIENDLY_Melizza Brimbuzzle|r
.accept 6132 >> Accept Get Me Out of Here!

step
#era
#softcore
>> The first wave you can ignore completely, the mobs wont run into the escort. The 2nd wave is 5 mobs, so use all cooldowns for it. If you die, skip the quest.
>> Finish the escort quest
.complete 6132,1
step
#era
#softcore
.goto Desolace,47.80,61.80
.target Hornizz Brimbuzzle
>>Talk to |cRXP_FRIENDLY_Hornizz Brimbuzzle|r
.turnin 6132 >> Turn in Get Me Out of Here!
step
#era
.goto Desolace,47.83,61.82
.target Hornizz Brimbuzzle
>>Talk to |cRXP_FRIENDLY_Hornizz Brimbuzzle|r
.turnin 6134 >> Turn in Ghost-o-plasm Round Up
step
#era
.goto Desolace,52.60,54.40
.target Takata Steelblade
>>Talk to |cRXP_FRIENDLY_Takata Steelblade|r
.turnin 1488 >> Turn in The Corrupter
step
#era
.hs >> Hearth back to Camp Taurajo
>> Buy food/water if needed
step
#era
.goto The Barrens,44.45,59.15
.fly Tanaris >> Fly to Tanaris
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 40-50
#classic
<< Horde
#name 41-43 Tanaris/Dustwallow
#next 43-44 Feralas
#somname 41-42 Tanaris/Dustwallow
step
#som
.goto Thunder Bluff,47.00,49.83
.fly Tanaris >> Fly to Tanaris
step
.goto Tanaris,51.60,26.80
.target Tran'rek
>>Talk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 2864 >> Turn in Tran'rek
step
.goto Tanaris,51.80,26.90
.accept 2781 >> Accept WANTED: Caliph Scorpidsting
step
.goto Tanaris,52.50,27.90
.home >> Set your Hearthstone to Gadgetzan
step
.goto Tanaris,52.40,28.50
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.turnin 243 >> Turn in Into the Field
.target Chief Engineer Bilgewhizzle
.accept 379 >> Accept Slake That Thirst
step
.goto Tanaris,52.46,28.51
.target Chief Engineer Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.accept 1690 >> Accept Wastewander Justice
.target Spigot Operator Luglunket
>>Talk to |cRXP_FRIENDLY_Spigot Operator Luglunket|r
.accept 1707 >> Accept Water Pouch Bounty
step
.goto Tanaris,50.20,27.50
.target Senior Surveyor Fizzledowser
>>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r
.accept 992 >> Accept Gadgetzan Water Survey
step
.goto Tanaris,39.10,29.30
>> Use the Untapped Widget at the pool. Run from the mobs that spawn
.complete 992,1
step
#completewith next
.goto Tanaris,60.18,23.29,0
>> Kill Bandits and Thieves in Noonshade Ruins en route to Steamwheedle Port. Loot them for Water Pouches
.complete 1690,1
.complete 1690,2
.collect 8483,10
step
.goto Tanaris,67.00,22.40
.target Yeh'kinya
>>Talk to |cRXP_FRIENDLY_Yeh'kinya|r
.accept 3520 >> Accept Screecher Spirits
step
.goto Tanaris,67.10,24.00
.target Stoley
>>Talk to |cRXP_FRIENDLY_Stoley|r
.turnin 2872 >> Turn in Stoley's Debt
step
.goto Tanaris,63.70,31.15
>> Kill Bandits and Thieves. Loot them for Water Pouches
.complete 1690,1
.complete 1690,2
.collect 8483,10
step << Shaman
.hs >> Hearth to Gadgetzan
>> Buy food/water if needed
step
.goto Tanaris,52.50,28.50
.target Spigot Operator Luglunket
>>Talk to |cRXP_FRIENDLY_Spigot Operator Luglunket|r
.turnin 1707 >> Turn in Water Pouch Bounty
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.turnin 379 >> Turn in Slake That Thirst
.turnin 1690 >> Turn in Wastewander Justice
.target Chief Engineer Bilgewhizzle
.accept 1691 >> Accept More Wastewander Justice
step
#som
#sticky
.destroy 8524 >> Destroy the Model 4711-FTZ Power Source in your bags
step
.goto Tanaris,50.21,27.48
.target Senior Surveyor Fizzledowser
>>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r
.turnin 992 >> Turn in Gadgetzan Water Survey
step
#era
.goto Tanaris,52.70,7.80
>> Head north to the Shimmering Flats
.target Kravel Koalbeard
>>Talk to |cRXP_FRIENDLY_Kravel Koalbeard|r
.turnin 1117 >> Turn in Rumors for Kravel
step
.isQuestTurnedIn 1108
.goto Tanaris,52.90,7.70
.target Fizzle Brassbolts
>>Talk to |cRXP_FRIENDLY_Fizzle Brassbolts|r
.turnin 1137 >> Turn in News for Fizzle
step
.goto Tanaris,54.20,6.90
>>Talk to |cRXP_FRIENDLY_Pozzik|r
.turnin 1183 >> Turn in Goblin Sponsorship
.target Pozzik
.accept 1186 >> Accept The Eighteenth Pilot
step
.isQuestTurnedIn 1108
.goto Tanaris,54.20,6.90
.target Pozzik
>>Talk to |cRXP_FRIENDLY_Pozzik|r
.accept 1190 >> Accept Keeping Pace
step
.goto Tanaris,54.30,7.00
>>Talk to |cRXP_FRIENDLY_Razzeric|r
.turnin 1186 >> Turn in The Eighteenth Pilot
.target Razzeric
.accept 1187 >> Accept Razzeric's Tweaking
step
.isQuestTurnedIn 1108
#completewith next
.goto Thousand Needles,79.81,77.02
>>Talk with Zamek to create a diversion
.target Zamek
>>Talk to |cRXP_FRIENDLY_Zamek|r
.turnin 1191 >> Turn in Zamek's Distraction
.timer 30,Keeping Pace RP
step
.isQuestTurnedIn 1108
.goto Thousand Needles,77.21,77.41
>>Click on the unguarded plans inside the metal hut
.turnin 1190 >> Turn in Keeping Pace
.accept 1194 >> Accept Rizzle's Schematics
step
#era
.goto Tanaris,52.70,7.80
.target Kravel Koalbeard
>>Talk to |cRXP_FRIENDLY_Kravel Koalbeard|r
.accept 1118 >> Accept Back to Booty Bay
step
.isQuestTurnedIn 1108
.goto Tanaris,54.20,6.90
.target Pozzik
>>Talk to |cRXP_FRIENDLY_Pozzik|r
.turnin 1194 >> Turn in Rizzle's Schematics
step
#sticky
#completewith next
>> If your Hearthstone is up, hearth to Gadgetzan, otherwise walk back and fly.
.hs >> Hearth to Gadgetzan
>> Buy food/water if needed
step
.maxlevel 43,dustwallowskip
.goto Tanaris,51.60,25.50
.fly Brackenwall >> Fly to Dustwallow Marsh
step
.goto Dustwallow Marsh,36.30,31.40
.target Overlord Mok'Morokk
>>Talk to |cRXP_FRIENDLY_Overlord Mok'Morokk|r
.accept 1166 >> Accept Overlord Mok'Morokk's Concern
step
.goto Dustwallow Marsh,37.10,33.00
.target Draz'Zilb
>>Talk to |cRXP_FRIENDLY_Draz'Zilb|r
.accept 1169 >> Accept Identifying the Brood
step
.goto Dustwallow Marsh,37.30,31.40
.target Tharg
>>Talk to |cRXP_FRIENDLY_Tharg|r
.accept 1168 >> Accept Army of the Black Dragon
step
#completewith Dragondeez
.unitscan Deadmire
.goto Dustwallow Marsh,50.5,53.1,0
.goto Dustwallow Marsh,49.3,57.4,0
.goto Dustwallow Marsh,45.8,61.6,0
.goto Dustwallow Marsh,46.4,60.3,0
.goto Dustwallow Marsh,46.2,54.1,0
>>Find & kill Deadmire. He's a White Crocolisk who patrols in the water mires around the area. Loot him for his tooth
.complete 1205,1 
.unitscan Deadmire
step
.goto Dustwallow Marsh,54.10,56.50
>> Loot the box on the ground near the crashed Zeppelin
.complete 1187,1
step
.isOnQuest 1261
.goto Dustwallow Marsh,55.40,63.10
>> Kill the Makrura mobs on the beach. Loot them for the Pendant
.complete 1261,1
step
.goto Dustwallow Marsh,44.50,66.00
>> Loot the Barrel on the ground
.complete 1166,1
step
.goto Dustwallow Marsh,38.70,65.60
>> Loot the Vase on the ground. Go inside the cave afterward
.complete 1166,2
step
.goto Dustwallow Marsh,36.60,69.50
>> Loot the Chest in the back of the cave. Kill the Scalebanes whilst you're inside
.complete 1166,3
.complete 1168,3
step
#completewith next
.goto Dustwallow Marsh,44.64,65.97,0
>>Kill Whelps you see on the borders of the area. Loot them for Tongues and Hearts
.complete 1169,1
.complete 1169,2
step
.goto Dustwallow Marsh,44.64,65.97
>> Kill the Dragonkin in the area
.complete 1168,1
.complete 1168,2
step
#label Dragondeez
.goto Dustwallow Marsh,42.12,80.82
>>Kill the Whelps in the area. Loot them for Tongues and Hearts
.complete 1169,1
.complete 1169,2
step
.goto Dustwallow Marsh,50.5,53.1,90,0
.goto Dustwallow Marsh,50.1,56.1,90,0
.goto Dustwallow Marsh,49.3,57.4,90,0
.goto Dustwallow Marsh,47.9,55.5,90,0
.goto Dustwallow Marsh,45.8,61.6,90,0
.goto Dustwallow Marsh,44.1,62.2,90,0
.goto Dustwallow Marsh,46.4,60.3,90,0
.goto Dustwallow Marsh,47.8,55.5,90,0
.goto Dustwallow Marsh,46.2,54.1,90,0
.goto Dustwallow Marsh,44.2,50.0,90,0
.goto Dustwallow Marsh,50.5,53.1
>>Find and kill Deadmire. He's a White Crocolisk who patrols in the water mires around the area. Loot him for his Tooth
.complete 1205,1 
step
>>Run back to Brackenwall Village
.goto Dustwallow Marsh,37.10,33.00
.target Draz'Zilb
>>Talk to |cRXP_FRIENDLY_Draz'Zilb|r
.turnin 1169 >> Turn in Identifying the Brood
step
.goto Dustwallow Marsh,36.30,31.50
.target Overlord Mok'Morokk
>>Talk to |cRXP_FRIENDLY_Overlord Mok'Morokk|r
.turnin 1166 >> Turn in Overlord Mok'Morokk's Concern
step
.goto Dustwallow Marsh,37.30,31.40
.target Tharg
>>Talk to |cRXP_FRIENDLY_Tharg|r
.turnin 1168 >> Turn in Army of the Black Dragon
step
.isQuestComplete 1261
.goto Dustwallow Marsh,35.30,30.60
.target Nazeer Bloodpike
>>Talk to |cRXP_FRIENDLY_Nazeer Bloodpike|r
.turnin 1261 >> Turn in Marg Speaks
step
.isQuestTurnedIn 1261
.goto Dustwallow Marsh,35.30,30.60
.target Nazeer Bloodpike
>>Talk to |cRXP_FRIENDLY_Nazeer Bloodpike|r
.accept 1262 >> Accept Report to Zor
step
.hs >> Hearth to Gadgetzan
>> Buy food/water if needed
step
#label dustwallowskip
.goto Tanaris,51.80,26.90
>>Click on the wanted poster
.accept 2781 >> Accept WANTED: Caliph Scorpidsting
step
#era
#level 43
>> Click on the Power Source (Orange tablet) in your bags.
.accept 654 >> Accept Tanaris Field Sampling
step
#era
.isOnQuest 654
>> Go around the zone and kill Scorpions, Basilisk and Hyenas for Samples. Click the looted Samples to test them to see if they're acceptable
>> do NOT delete any untested samples you have that you don't need
.complete 654,1
.complete 654,2
.complete 654,3
step
#era
.goto Tanaris,52.40,28.50
.isOnQuest 654
.target Chief Engineer Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.turnin 654 >> Turn in Tanaris Field Sampling
step
#era
.isQuestTurnedIn 654
.goto Tanaris,52.40,28.50
.target Chief Engineer Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.accept 864 >> Accept Return to Apothecary Zinge
step
#completewith next
.goto Tanaris,62.22,37.75,0
>>Look for Caliph Scorpidsting in the area. Kill and loot him for his head
>>Be careful as he has two stealthed adds right next to him
.complete 2781,1 
.unitscan Caliph Scorpidsting
step
.goto Tanaris,59.09,37.87
>> Do More Wastewander Justice
.complete 1691,1
.complete 1691,2
.complete 1691,3
step
.goto Tanaris,62.22,37.75
>>Look for Caliph Scorpidsting in the area. Kill and loot him for his head
>>Be careful as he has two stealthed adds right next to him
.complete 2781,1 
.unitscan Caliph Scorpidsting
step << Hunter
#level 43
.goto Tanaris,52.70,45.92
.target Marvon Rivetseeker
>>Talk to |cRXP_FRIENDLY_Marvon Rivetseeker|r
.accept 3161 >> Accept Gahz'ridian
step << Hunter
.goto Tanaris,47.31,65.14
.goto Tanaris,40.48,72.82
>> Equip the Helmet provided. Loot the patches of sand on the ground (and on the minimap). Loot them for the Ornaments
.complete 3161,1
.isOnQuest 3161
step << Hunter
.goto Tanaris,52.70,45.92
>>Re-equip your normal Helmet
.target Marvon Rivetseeker
>>Talk to |cRXP_FRIENDLY_Marvon Rivetseeker|r
.turnin 3161 >> Turn in Gahz'ridian
.isOnQuest 3161
step
.goto Tanaris,52.40,28.50
.target Chief Engineer Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.turnin 1691 >> Turn in More Wastewander Justice
.turnin 2781 >> Turn in WANTED: Caliph Scorpidsting
step
.goto Tanaris,51.60,25.50
.fly Feralas >> Fly to Feralas
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 40-50
#classic
<< Horde
#name 43-44 Feralas
#next 44-45 Southern Stranglethorn
#somname 42-43 Feralas
step
.goto Feralas,75.70,44.30
.target Orwin Gizzmick
>>Talk to |cRXP_FRIENDLY_Orwin Gizzmick|r
.accept 2987 >> Accept Gordunni Cobalt
step
#sticky
#label RokOrhan
.goto Feralas,75.70,43.62,0
>> Speak to Rok Orhan. She patrols the road inside of Camp Mojache
>>Talk to |cRXP_FRIENDLY_Rok Orhan|r
.turnin 2981 >> Turn in A Threat in Feralas
.target Rok Orhan
.accept 2975 >> Accept The Ogres of Feralas
step
.goto Feralas,76.00,42.70
.target Krueg Skullsplitter
>>Talk to |cRXP_FRIENDLY_Krueg Skullsplitter|r
.accept 2973 >> Accept A New Cloak's Sheen
step
.goto Feralas,74.90,42.50
.target Hadoken Swiftstrider
>>Talk to |cRXP_FRIENDLY_Hadoken Swiftstrider|r
.accept 2862 >> Accept War on the Woodpaw
step
>>Inside the building
.goto Feralas,74.50,42.90
.target Jangdor Swiftstrider
>>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r
.accept 2822 >> Accept The Mark of Quality
step
.goto Feralas,74.80,45.20
.home >> Set your Hearthstone to Camp Mojache
step
#sticky
#completewith YetiHide
>>Look out for the Distress Beacon drop as you quest throughout Feralas
.collect 8705,1,2766
.accept 2766 >> Accept Find OOX-22/FE!
step
#requires RokOrhan
.goto Feralas,73.76,45.76,90,0
.goto Feralas,72.03,36.89
>> Kill the Woodpaw Gnolls North-west of Camp Mojache. Loot them for their Manes
.complete 2862,1
step
#completewith Scroll
.goto Feralas,75.30,28.26,0
>> Use Orwin's Shovel in your bags on the blue patches on the ground. Loot them for the Cobalt. Loot the brown dirt that lights blue afterwards. Those have the quest items.
.complete 2987,1
step
#completewith Shovel
.goto Feralas,76.10,33.20,0
>>Kill Ogres at the Gordunni Outpost
.complete 2975,1
.complete 2975,2
.complete 2975,3
step
#label Scroll
.goto Feralas,75.25,34.44,60,0
.goto Feralas,79.4,34.8,15,0
.goto Feralas,80.5,34.3,15,0
.goto Feralas,80.8,35.0,15,0
.goto Feralas,75.1,29.8,15,0
.goto Feralas,75.2,28.7,15,0
.goto Feralas,74.6,27.9,15,0
.goto Feralas,79.4,34.8,15,0
.goto Feralas,80.5,34.3,15,0
.goto Feralas,80.8,35.0,15,0
.goto Feralas,75.1,29.8,15,0
.goto Feralas,75.2,28.7,15,0
.goto Feralas,74.6,27.9,15,0
.goto Feralas,79.4,34.8,
>> Run to the Gordunni Outpost and look for the small parchment. It can spawn in the main camp or in the east camp in the mountains. Follow the arrow for spawn points.
.accept 2978 >> Accept The Gordunni Scroll
step
#label Shovel
.goto Feralas,75.30,28.26,60,0
.goto Feralas,74.59,30.23
>> Use Orwin's Shovel in your bags on the blue patches on the ground. Loot them for the Cobalt
.complete 2987,1
step
.goto Feralas,76.10,33.20
>>Kill Ogres at the Gordunni Outpost
.complete 2975,1
.complete 2975,2
.complete 2975,3
step << Shaman
#completewith next
.hs >> Hearth to Camp Mojache
>> Buy food/water if needed
step
.goto Feralas,74.90,42.46
>>Talk to |cRXP_FRIENDLY_Hadoken Swiftstrider|r
.turnin 2862 >> Turn in War on the Woodpaw
.target Hadoken Swiftstrider
.accept 2863 >> Accept Alpha Strike
step
.goto Feralas,75.80,43.58
>>Talk to |cRXP_FRIENDLY_Rok Orhan|r
.turnin 2975 >> Turn in The Ogres of Feralas
.target Rok Orhan
.accept 2980 >> Accept The Ogres of Feralas
.turnin 2978 >> Turn in The Gordunni Scroll
.accept 2979 >> Accept Dark Ceremony
step
.goto Feralas,75.70,44.30
.target Orwin Gizzmick
>>Talk to |cRXP_FRIENDLY_Orwin Gizzmick|r
.turnin 2987 >> Turn in Gordunni Cobalt
step
.goto Feralas,68.80,48.00
>> Kill Sprite Darters. Loot them for their Wings
.complete 2973,1
step
.goto Feralas,67.50,55.60
.goto Feralas,69.05,55.78,0
.goto Feralas,68.60,54.25,0
.goto Feralas,71.51,55.98,0
.goto Feralas,72.42,56.63,0
.goto Feralas,73.21,56.25,0
>> Kill Woodpaw Alphas. There's usually one in each camp
.complete 2863,1
.unitscan Woodpaw Alpha
step
#completewith next
.hs >> Hearth to Camp Mojache
step
.goto Feralas,76.00,42.80
>>Talk to |cRXP_FRIENDLY_Krueg Skullsplitter|r
.turnin 2973 >> Turn in A New Cloak's Sheen
.target Krueg Skullsplitter
.accept 2974 >> Accept A Grim Discovery
step
.goto Feralas,74.90,42.50
>>Talk to |cRXP_FRIENDLY_Hadoken Swiftstrider|r
.turnin 2863 >> Turn in Alpha Strike
.target Hadoken Swiftstrider
.accept 2902 >> Accept Woodpaw Investigation
step
.goto Feralas,67.10,46.40
>> Kill Grimtotems in the area. Loot them for their horns
.complete 2974,1
step
.goto Feralas,71.60,55.90
>> Click on the map sitting on top of the box
.turnin 2902 >> Turn in Woodpaw Investigation
.accept 2903 >> Accept The Battle Plans
step
.goto Feralas,76.00,42.80
>>Talk to |cRXP_FRIENDLY_Krueg Skullsplitter|r
.turnin 2974 >> Turn in A Grim Discovery
.target Krueg Skullsplitter
.accept 2976 >> Accept A Grim Discovery
step
.goto Feralas,74.90,42.40
>>Talk to |cRXP_FRIENDLY_Hadoken Swiftstrider|r
.turnin 2903 >> Turn in The Battle Plans
.target Hadoken Swiftstrider
.accept 7730 >> Accept Zukk'ash Infestation
.accept 7731 >> Accept Stinglasher
step
#completewith next
.goto Feralas,73.38,62.94,0
>> Kill Silithid mobs in the area. Loot them for their Carapaces
.complete 7730,1
step
.goto Feralas,76.90,61.60
>> Kill Stinglasher. Loot it for its Glands
>> It patrols all around the outside of the Silithid Hives
.complete 7731,1
.unitscan Stinglasher
step
.goto Feralas,73.38,62.94
>> Kill Silithid mobs in the area. Loot them for their Carapaces
.complete 7730,1
step
.goto Feralas,56.15,46.88,0
#completewith egghypo
>> Kill Rogue Vale Screechers. Use the Bramble on their corpses after killing them
.complete 3520,1
.unitscan Rogue Vale Screecher
step
#completewith next
.goto Feralas,58.59,69.85,0
>> Kill Gordunni Mage-Lords. Loot them for the Gordunni Orb
.complete 2979,1
step
.goto Feralas,59.58,65.02
>> Kill Gordunni Ogres in the area
.complete 2980,1
.complete 2980,2
.complete 2980,3
step
.goto Feralas,58.59,69.85
>> Kill Gordunni Mage-Lords. Loot them for the Gordunni Orb
.complete 2979,1
.unitscan Gordunni Mage-Lord
step
#label egghypo
.goto Feralas,56.66,75.89
>> Head south and look for Hippogryph nests by the mountains. Loot one of the Hippogryph Eggs
.collect 8564,1 
step
#label longelegant
#sticky
.goto Feralas,56.46,63.08,0
>> Grind Frayfeather Hippogryphs. Loot them for Long Elegant Feathers
.collect 4589,10
step
.goto Feralas,56.15,46.88
>> Kill Rogue Vale Screechers. Use the Bramble on their corpses after killing them
.complete 3520,1
.unitscan Rogue Vale Screecher
step
#label YetiHide
.goto Feralas,55.14,56.35,70,0
.goto Feralas,53.12,56.27,70,0
.goto Feralas,52.05,58.40
>> Kill Yetis. Loot them for their Hides
.complete 2822,1
step
#requires longelegant
>> Skip this step if you didn't find the Distress Beacon.
.accept 2766 >> Accept Find OOX-22/FE!
step
.goto Feralas,53.35,55.69
.isOnQuest 2766
.target Homing Robot OOX-22/FE
>>Talk to |cRXP_FRIENDLY_Homing Robot OOX-22/FE|r
.turnin 2766 >> Turn in Find OOX-22/FE!
step
.isQuestTurnedIn 2766
.goto Feralas,53.35,55.69
>> Start the chicken escort. Be careful as this escort is HARD
>> 3 Waves will spawn: 3 Yetis (each level 46), 3 Bears, then 4 Gnolls. Save all your very long cooldowns for the Gnolls, and use some on the Yetis
.target Homing Robot OOX-22/FE
>>Talk to |cRXP_FRIENDLY_Homing Robot OOX-22/FE|r
.accept 2767 >> Accept Rescue OOX-22/FE!
step
#completewith next
.hs >> Hearth back to Camp Mojache
>> Buy food/water if needed
step
.goto Feralas,75.80,43.58
>>Talk to |cRXP_FRIENDLY_Rok Orhan|r
.turnin 2980 >> Turn in The Ogres of Feralas
.turnin 2979 >> Turn in Dark Ceremony
.target Rok Orhan
.accept 3002 >> Accept The Gordunni Orb
step
.goto Feralas,74.40,43.40
.target Witch Doctor Uzer'i
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.accept 3121 >> Accept A Strange Request
step
.goto Feralas,74.40,42.90
.target Jangdor Swiftstrider
>>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r
.turnin 2822 >> Turn in The Mark of Quality
step
.goto Feralas,74.90,42.50
>>Talk to |cRXP_FRIENDLY_Hadoken Swiftstrider|r
.turnin 7730 >> Turn in Zukk'ash Infestation
.turnin 7731 >> Turn in Stinglasher
.target Hadoken Swiftstrider
.accept 7732 >> Accept Zukk'ash Report
step << Druid
.goto Feralas,76.0,42.3
.trainer >> Go and train your class spells
step << !Mage
.goto Feralas,75.45,44.36
.fly Orgrimmar >> Fly to Orgrimmar
step << Mage
.zone Orgrimmar >> Teleport to Orgrimmar
step
.goto Orgrimmar,39.20,86.30
.target Uthel'nay
>>Talk to |cRXP_FRIENDLY_Uthel'nay|r
.turnin 3002 >> Turn in The Gordunni Orb
step << Mage
.goto Orgrimmar,38.8,85.6
.trainer >> Go and train your class spells
step << Priest
.goto Orgrimmar,35.6,87.8
.trainer >> Go and train your class spells
step
.isOnQuest 1262
.goto Orgrimmar,39.00,38.10
.target Zor Lonetree
>>Talk to |cRXP_FRIENDLY_Zor Lonetree|r
.turnin 1262 >> Turn in Report to Zor
step
.isQuestTurnedIn 1262
.goto Orgrimmar,39.00,38.10
.target Zor Lonetree
>>Talk to |cRXP_FRIENDLY_Zor Lonetree|r
.accept 7541 >> Accept Service to the Horde
.turnin 7541 >> Turn in Service to the Horde
step << Shaman
.goto Orgrimmar,38.6,36.0
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,66.046,18.526
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,66.3,14.8
.trainer >> Go and train your pet spells
step << Warrior
.goto Orgrimmar,79.7,31.4
.trainer >> Go and train your class spells
step
.goto Orgrimmar,56.50,46.60
.target Zilzibin Drumlore
>>Talk to |cRXP_FRIENDLY_Zilzibin Drumlore|r
.turnin 7732 >> Turn in Zukk'ash Report
step
.goto Orgrimmar,75.20,34.20
.target Belgrom Rockmaul
>>Talk to |cRXP_FRIENDLY_Belgrom Rockmaul|r
.turnin 2976 >> Turn in A Grim Discovery
step
.goto Orgrimmar,49.60,50.40
>>Talk to |cRXP_FRIENDLY_Neeru Fireblade|r
.turnin 3121 >> Turn in A Strange Request
.target Neeru Fireblade
.accept 3122 >> Accept Return to Witch Doctor Uzer'i
step << Rogue
.goto Orgrimmar,44.0,54.6
.trainer >> Go and train your class spells
step << Warlock
.goto Orgrimmar,48.0,46.0
.trainer >> Go and train your class spells
step << Warlock
.goto Orgrimmar,47.5,46.7
.vendor >> Buy your pet upgrades if you got the money for it.
step
#completewith next
.goto Durotar,45.53,11.79,60 >> Run out of Orgrimmar
step
>>Run up the Zeppelin Tower outside of Orgrimmar
.goto Durotar,50.53,12.52
.zone Stranglethorn Vale >> Take the Zeppelin to Stranglethorn Vale
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 40-50
#classic
<< Horde
#name 44-45 Southern Stranglethorn
#next 45-46 Swamp of Sorrows
#somname 43-45 Southern Stranglethorn
step
.goto Stranglethorn Vale,32.20,27.60
.accept 586 >> Accept Speaking with Gan'zulah
step
.goto Stranglethorn Vale,32.10,29.20
.target Far Seer Mok'thardin
>>Talk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.accept 571 >> Accept Mok'thardin's Enchantment
step
.goto Stranglethorn Vale,28.80,44.80
>> Kill Tethis. Loot him for his Talon
>> He patrols all around the raptor area
.complete 197,1
.unitscan Tethis
step
#sticky
#completewith Anathek
>>Kill Trolls in the area. Loot them for Tusks and Necklaces
.complete 586,1 
.complete 586,3 
.complete 586,2 
step
#sticky
#completewith next
+This next quest can be quite hard, be extra careful
#hardcore
step
#label Anathek
.goto Stranglethorn Vale,44.3,44.9,30,0
.goto Stranglethorn Vale,45.8,41.2,30,0
.goto Stranglethorn Vale,47.1,40.7,30,0
.goto Stranglethorn Vale,44.3,44.9,30,0
.goto Stranglethorn Vale,45.8,41.2,30,0
.goto Stranglethorn Vale,47.1,40.7,30,0
.goto Stranglethorn Vale,44.3,44.9,30,0
.goto Stranglethorn Vale,45.8,41.2,30,0
.goto Stranglethorn Vale,47.1,40.7,30,0
>>Find & kill Ana'thek the Cruel. Loot his broken armor.
.complete 586,4 
step
.goto Stranglethorn Vale,47.9,42.9,40,0
.goto Stranglethorn Vale,47.6,44.1,40,0
.goto Stranglethorn Vale,46.0,42.8,40,0
.goto Stranglethorn Vale,44.4,41.9,40,0
.goto Stranglethorn Vale,47.4,39.8,40,0
.goto Stranglethorn Vale,47.9,42.9,40,0
.goto Stranglethorn Vale,47.6,44.1,40,0
.goto Stranglethorn Vale,46.0,42.8,40,0
.goto Stranglethorn Vale,44.4,41.9,40,0
.goto Stranglethorn Vale,47.4,39.8,40,0
.goto Stranglethorn Vale,47.9,42.9,40,0
.goto Stranglethorn Vale,47.6,44.1,40,0
.goto Stranglethorn Vale,46.0,42.8,40,0
.goto Stranglethorn Vale,44.4,41.9,40,0
.goto Stranglethorn Vale,47.4,39.8,40,0
.goto Stranglethorn Vale,47.9,42.9,40,0
.goto Stranglethorn Vale,47.6,44.1,40,0
.goto Stranglethorn Vale,46.0,42.8,40,0
.goto Stranglethorn Vale,44.4,41.9,40,0
.goto Stranglethorn Vale,47.4,39.8,40,0
>>Kill Trolls in the area. Loot them for Tusks and Necklaces
.complete 586,1 
.complete 586,3 
.complete 586,2 
step
.goto Stranglethorn Vale,35.70,10.80
>>Talk to |cRXP_FRIENDLY_Hemet Nesingwary|r
.turnin 197 >> Turn in Raptor Mastery
.target Hemet Nesingwary
.accept 208 >> Accept Big Game Hunter
step
.goto Stranglethorn Vale,32.20,27.70
>> Click on the cauldron
.turnin 586 >> Turn in Speaking with Gan'zulah
.accept 588 >> Accept The Fate of Yenniku
step
.goto Stranglethorn Vale,32.20,27.70
>>Talk to |cRXP_FRIENDLY_Kin'weelay|r
.turnin 588 >> Turn in The Fate of Yenniku
.target Kin'weelay
.accept 589 >> Accept The Singing Crystals
step
.goto Stranglethorn Vale,32.54,29.36
.fly Booty Bay >> Fly to Booty Bay
step
.goto Stranglethorn Vale,26.70,76.40
.target Privateer Bloads
>>Talk to |cRXP_FRIENDLY_Privateer Bloads|r
.accept 617 >> Accept Akiris by the Bundle
step
.goto Stranglethorn Vale,27.10,77.30
.target Crank Fizzlebub
>>Talk to |cRXP_FRIENDLY_Crank Fizzlebub|r
.accept 621 >> Accept Zanzil's Secret
step
#era
.goto Stranglethorn Vale,27.11,77.21
.target Crank Fizzlebub
>>Talk to |cRXP_FRIENDLY_Crank Fizzlebub|r
.turnin 1118 >> Turn in Back to Booty Bay
step
.goto Stranglethorn Vale,27.70,77.10
.target "Sea Wolf" MacKinley
>>Talk to |cRXP_FRIENDLY_"Sea Wolf" MacKinley|r
.accept 606 >> Accept Scaring Shaky
step
.goto Stranglethorn Vale,27.70,76.80
.target Fin Fizracket
>>Talk to |cRXP_FRIENDLY_Fin Fizracket|r
.accept 348 >> Accept Stranglethorn Fever
step
.goto Stranglethorn Vale,28.10,76.20
.target First Mate Crazz
>>Talk to |cRXP_FRIENDLY_First Mate Crazz|r
.accept 595 >> Accept The Bloodsail Buccaneers
step
.goto Stranglethorn Vale,26.70,73.60
.target Captain Hecklebury Smotts
>>Talk to |cRXP_FRIENDLY_Captain Hecklebury Smotts|r
.accept 8551 >> Accept The Captain's Chest
step
.goto Stranglethorn Vale,27.27,69.51
.turnin 595 >> Turn in The Bloodsail Buccaneers
.accept 597 >> Accept The Bloodsail Buccaneers
step
.goto Stranglethorn Vale,28.09,76.21
>>Talk to |cRXP_FRIENDLY_First Mate Crazz|r
.turnin 597 >> Turn in The Bloodsail Buccaneers
.target First Mate Crazz
.accept 599 >> Accept The Bloodsail Buccaneers
step
.goto Stranglethorn Vale,26.92,77.34
.target Deeg
>>Talk to |cRXP_FRIENDLY_Deeg|r
.accept 587 >> Accept Up to Snuff
step
.goto Stranglethorn Vale,27.17,77.00
>>Talk to |cRXP_FRIENDLY_Fleet Master Seahorn|r
.turnin 599 >> Turn in The Bloodsail Buccaneers
.target Fleet Master Seahorn
.accept 604 >> Accept The Bloodsail Buccaneers
step
.isQuestComplete 2767
.goto Stranglethorn Vale,28.35,76.35
.target Oglethorpe Obnoticus
>>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r
.turnin 2767 >> Turn in Rescue OOX-22/FE!
step
.goto Stranglethorn Vale,28.59,75.89
.target Dizzy One-Eye
>>Talk to |cRXP_FRIENDLY_Dizzy One-Eye|r
.accept 576 >> Accept Keep An Eye Out
step
#era
#completewith Orders
>>Kill Bloodsail mobs. Loot them for Dizzy's Eye. You can finish this later
.complete 576,1
step
#som
#completewith Orders
>>Kill Bloodsail mobs. Loot them for Snuff. You can finish this later
.complete 587,1
step
#sticky
#completewith next
.goto Stranglethorn Vale,29.61,80.89,0
.goto Stranglethorn Vale,27.75,83.13,0
.goto Stranglethorn Vale,27.18,82.66,0
.goto Stranglethorn Vale,26.94,82.49,0
>> Loot the Bloodsail Orders and Bloodsail Charts. They look like scrolls on the ground
.complete 604,2
.complete 604,3
step
.goto Stranglethorn Vale,28.00,82.40
>> Kill Bloodsail Swashbucklers
.complete 604,1
step
#label Orders
.goto Stranglethorn Vale,29.61,80.89,20,0
.goto Stranglethorn Vale,27.75,83.13,20,0
.goto Stranglethorn Vale,27.18,82.66,20,0
.goto Stranglethorn Vale,26.94,82.49
>> Loot the Bloodsail Orders and Bloodsail Charts. They look like scrolls on the ground
.complete 604,2
.complete 604,3
step
#som
>>Kill Bloodsail mobs. Loot them for Dizzy's Eye & Snuff
.complete 576,1
.complete 587,1
step
#softcore
#completewith next
.goto Stranglethorn Vale,32.80,65.80,0
>>Kill Gorillas. Loot them for Gorilla Fangs
.collect 2799,10
step
#hardcore
#completewith next
.goto Stranglethorn Vale,32.80,65.80,0
>>Kill Gorillas. Loot them for Gorilla Fangs
>>You can skip this if you want, the quest proceeding this is VERY difficult
.collect 2799,10
step
.goto Stranglethorn Vale,32.80,65.80
>> Kill Gorillas. Loot them for their Giblets and Sinew
.complete 606,1
.complete 571,1
step
.goto Stranglethorn Vale,32.80,65.80
>> Keep grinding gorillas until you get 10 Gorilla fangs
.collect 2799,10
step
#completewith next
+This quest will be very hard, consider skipping it.
#hardcore
step
.goto Stranglethorn Vale,35.27,60.40
>> This quest is very hard. Use no cooldowns on wave 1. Use all cooldowns on wave 2. On wave 3 avoid them by going a bit up the mountain, then when they aggro the NPC kill the named mob only and loot it.
.target Witch Doctor Unbagwa
>>Talk to |cRXP_FRIENDLY_Witch Doctor Unbagwa|r
.turnin 349 >> Turn in Stranglethorn Fever
step
>> This quest is very hard. Use no cooldowns on wave 1. Use all cooldowns on wave 2. On wave 3 avoid them by going a bit up the mountain, then when they aggro the NPC kill the named mob only and loot it.
.goto Stranglethorn Vale,35.27,60.40
>> Collect Heart of Mokk
.complete 348,1
step
.isQuestComplete 576
.goto Stranglethorn Vale,28.60,75.80
.target Dizzy One-Eye
>>Talk to |cRXP_FRIENDLY_Dizzy One-Eye|r
.turnin 576 >> Keep An Eye Out
step
>>Run back to Booty Bay
.goto Stranglethorn Vale,26.90,73.70
>>Talk to |cRXP_FRIENDLY_"Shaky" Phillipe|r
.turnin 606 >> Turn in Scaring Shaky
.target "Shaky" Phillipe
.accept 607 >> Accept Return to MacKinley
step
.goto Stranglethorn Vale,27.60,76.70
.target Fin Fizracket
>>Talk to |cRXP_FRIENDLY_Fin Fizracket|r
.turnin 348 >> Turn in Stranglethorn Fever
step
.goto Stranglethorn Vale,27.70,77.10
>>Talk to |cRXP_FRIENDLY_"Sea Wolf" MacKinley|r
.turnin 607 >> Turn in Return to MacKinley
.target "Sea Wolf" MacKinley
.accept 609 >> Accept Voodoo Dues
step
#era
.goto Stranglethorn Vale,27.20,77.00
>>Talk to |cRXP_FRIENDLY_Fleet Master Seahorn|r
.turnin 604 >> Turn in The Bloodsail Buccaneers
.target Fleet Master Seahorn
.accept 608 >> Accept The Bloodsail Buccaneers
step
#som
.goto Stranglethorn Vale,27.20,77.00
.target Fleet Master Seahorn
>>Talk to |cRXP_FRIENDLY_Fleet Master Seahorn|r
.turnin 604 >> Turn in The Bloodsail Buccaneers
step
.goto Stranglethorn Vale,26.87,77.10
.fly Grom'gol >> Fly to Grom'gol
step
.goto Stranglethorn Vale,32.10,29.20
>>Talk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.turnin 571 >> Turn in Mok'thardin's Enchantment
.target Far Seer Mok'thardin
.accept 573 >> Accept Mok'thardin's Enchantment
step
.goto Stranglethorn Vale,38.18,35.60
>> Kill King Bangalash. Loot him for his head
>> Be careful as this quest is HARD. He comes with 2 mobs when he spawns, and spawns 2 more at about 50%.
.complete 208,1

step
.goto Stranglethorn Vale,39.48,47.42,60,0
.goto Stranglethorn Vale,41.67,50.19,60,0
.goto Stranglethorn Vale,43.84,47.77
>> Go into the cave. Kill Ironjaw Basilisks. Loot them for their Blue Shards
.complete 589,1
step
#completewith Chucky
.goto Stranglethorn Vale,35.26,51.28,0
>> Kill Zanzil mobs. Loot them for the Mixture
.complete 621,1
step
.goto Stranglethorn Vale,37.46,49.46,70,0
.goto Stranglethorn Vale,35.26,51.28,0
>> Kill Maury. Loot his Clubbed Foot
.complete 609,1
step
.goto Stranglethorn Vale,34.92,51.84
>> Kill Jon-Jon. Loot his Golden Spyglass
.complete 609,2
step
#label Chucky
.goto Stranglethorn Vale,34.07,54.11,70,0
.goto Stranglethorn Vale,40.00,58.24
>> Kill Chucky. Loot his Huge Ring
.complete 609,3
step
.goto Stranglethorn Vale,39.44,58.47
>> Kill Zanzil mobs. Loot them for the Mixture
>> Do NOT pull or attack Zanzil the Outcast
.complete 621,1
step
>> Kill Gorlash. Loot him for Smotts' Chest
>> You can kite him back to the Booty Bay guards, and get credit as long as you did the majority damage
>> This quest is HARD depending on how well you can kite and do damage on the move. You can skip this quest if needed
.goto Stranglethorn Vale,37.00,69.50
.complete 8551,1
.link https://youtu.be/lNy2ohTWeLw?t=1037 >> CLICK HERE for a reference
step
#era
#sticky
#completewith next
+These next ships quests can be very aard. Be careful
#hardcore
step
#era
#label Cortello
#sticky
.goto Stranglethorn Vale,32.90,88.20,0
.goto Stranglethorn Vale,30.60,90.60,0
.goto Stranglethorn Vale,29.30,88.30,0
>> Look for Cortello's Riddle. It's a small scroll that can spawn in any of the 3 ships on the bottom and middle levels.
.accept 624 >> Accept Cortello's Riddle
step
#era
.goto Stranglethorn Vale,32.90,88.20
>> Kill Captain Stillwater in the 2nd floor at the back of the ship
.complete 608,1
step
#era
.goto Stranglethorn Vale,30.60,90.60
>> Kill Fleet Master Firallon in the 2nd floor at the back of the ship
.complete 608,3
step
#era
.goto Stranglethorn Vale,29.30,88.30
>> Kill Captain Keelhaul in the 2nd floor at the back of the ship. Be careful of Garr Salthoof who's just outside the room guarding him, as he is difficult
>>Garr can charge for a LOT of damage, stun for 2 seconds, and Thrash
.complete 608,2
step
#era
>>Kill Bloodsail mobs. Loot them for Dizzy's Eye and Snuff.
.complete 576,1
.complete 587,1
step
#era
#requires Cortello
#completewith next
>> Kill Nagas. Loot them for Akiris Reed
.complete 573,1
.complete 617,1
step
#som
#completewith next
>> Kill Nagas. Loot them for Akiris Reed
.complete 573,1
.complete 617,1
step
#requires Dizzy
.goto Stranglethorn Vale,27.04,67.80,60,0
.goto Stranglethorn Vale,24.75,63.60,60,0
.goto Stranglethorn Vale,28.97,61.92
>> Go up the mountain, across the bridge, and loot the Holy Spring Water from the spring
.complete 573,2
step
.goto Stranglethorn Vale,25.86,62.04
>> Kill Nagas. Loot them for Akiris Reed
.complete 573,1
.complete 617,1
step
.isQuestComplete 8551
>>Run back to Booty Bay
.goto Stranglethorn Vale,26.70,73.60
.target Captain Hecklebury Smotts
>>Talk to |cRXP_FRIENDLY_Captain Hecklebury Smotts|r
.turnin 8551 >> Turn in The Captain's Chest
step
.abandon 8551 >> Abandon The Captain's Chest
step
.goto Stranglethorn Vale,28.60,75.90
.target Dizzy One-Eye
>>Talk to |cRXP_FRIENDLY_Dizzy One-Eye|r
.turnin 576 >> Turn in Keep An Eye Out
step
.goto Stranglethorn Vale,27.80,77.10
.target "Sea Wolf" MacKinley
>>Talk to |cRXP_FRIENDLY_"Sea Wolf" MacKinley|r
.turnin 609 >> Turn in Voodoo Dues
step
.goto Stranglethorn Vale,26.70,76.40
.target Privateer Bloads
>>Talk to |cRXP_FRIENDLY_Privateer Bloads|r
.turnin 617 >> Turn in Akiris by the Bundle
step
.goto Stranglethorn Vale,27.11,77.21
.target Crank Fizzlebub
>>Talk to |cRXP_FRIENDLY_Crank Fizzlebub|r
.turnin 621 >> Turn in Zanzil's Secret
step
.goto Stranglethorn Vale,27.13,77.44
.target Whiskey Slim
>>Talk to |cRXP_FRIENDLY_Whiskey Slim|r
.accept 580 >> Accept Whiskey Slim's Lost Grog
step
#era
.goto Stranglethorn Vale,27.11,77.21
.target Crank Fizzlebub
>>Talk to |cRXP_FRIENDLY_Crank Fizzlebub|r
.accept 1119 >> Accept Zanzil's Mixture and a Fool's Stout
step
.goto Stranglethorn Vale,27.00,77.30
.target Deeg
>>Talk to |cRXP_FRIENDLY_Deeg|r
.turnin 587 >> Turn in Up to Snuff
step
#era
.goto Stranglethorn Vale,27.10,77.00
.target Fleet Master Seahorn
>>Talk to |cRXP_FRIENDLY_Fleet Master Seahorn|r
.turnin 608 >> Turn in The Bloodsail Buccaneers
step
.goto Stranglethorn Vale,26.87,77.10
.fly Grom'gol >> Fly to Grom'gol
step
.goto Stranglethorn Vale,32.10,29.20
.target Far Seer Mok'thardin
>>Talk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.turnin 573 >> Turn in Mok'thardin's Enchantment
step
.goto Stranglethorn Vale,32.20,27.80
.target Kin'weelay
>>Talk to |cRXP_FRIENDLY_Kin'weelay|r
.turnin 589 >> Turn in The Singing Crystals
step
#completewith next
.goto Stranglethorn Vale,35.70,10.80,0
+Turn in all journal pages that you have.
step
.goto Stranglethorn Vale,35.70,10.80
.target Hemet Nesingwary
>>Talk to |cRXP_FRIENDLY_Hemet Nesingwary|r
.turnin 208 >> Turn in Big Game Hunter
step
#som
.hs >> Hearth to Camp Mojache
>> Buy food/water if needed
step
#era
.goto Stranglethorn Vale,32.6,29.2
.fly Stonard>> Fly to Stonard
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 40-50
#version 8
#classic
<< Horde
#name 45-46 Swamp of Sorrows
#next 46-48 Tanaris
#era
step
#era
>>Run toward the Blasted Lands border
.goto Swamp of Sorrows,34.30,66.00
.target Fallen Hero of the Horde
>>Talk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r
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
>>Talk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.turnin 2784 >> Turn in Fall From Grace
.target Fallen Hero of the Horde
.accept 2621 >> Accept The Disgraced One
step
#era
.goto Swamp of Sorrows,47.90,55.00
.target Fel'zerul
>>Talk to |cRXP_FRIENDLY_Fel'zerul|r
.accept 1429 >> Accept The Atal'ai Exile
>>Talk to |cRXP_FRIENDLY_Dispatch Commander Ruag|r
.turnin 2621 >> Turn in The Disgraced One
.target Dispatch Commander Ruag
.accept 2622 >> Accept The Missing Orders
step
#era
.goto Swamp of Sorrows,81.31,80.97
.target Tok'Kar
>>Talk to |cRXP_FRIENDLY_Tok'Kar|r
.accept 699 >> Accept Lack of Surplus
step
.goto Swamp of Sorrows,44.96,57.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bengor|r
.turnin 2622 >>Turn in The Missing Orders
.accept 2623 >>Accept The Swamp Talker
.target Bengor
step
#era
.goto Swamp of Sorrows,74.10,17.34,0
>> Kill Sawtooth Snappers. Loot them for their Claws
.complete 699,1
step
#era
.goto Swamp of Sorrows,81.40,80.80
>>Talk to |cRXP_FRIENDLY_Tok'Kar|r
.turnin 699 >> Turn in Lack of Surplus
.target Tok'Kar
.accept 1422 >> Accept Threat From the Sea
step
#era
.goto Swamp of Sorrows,83.70,80.50
>>Talk to |cRXP_FRIENDLY_Katar|r
.turnin 1422 >> Turn in Threat From the Sea
.target Katar
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
>>Talk to |cRXP_FRIENDLY_Katar|r
.turnin 1426 >> Turn in Threat From the Sea
.target Katar
.accept 1427 >> Accept Threat From the Sea
step
#era
.goto Swamp of Sorrows,81.40,80.80
.target Tok'Kar
>>Talk to |cRXP_FRIENDLY_Tok'Kar|r
.turnin 1427 >> Turn in Threat From the Sea
step
#era
.goto Swamp of Sorrows,83.75,80.41
.target Katar
>>Talk to |cRXP_FRIENDLY_Katar|r
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
.target Katar
>>Talk to |cRXP_FRIENDLY_Katar|r
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
>>Talk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.turnin 2623 >> Turn in The Swamp Talker
.target Fallen Hero of the Horde
.accept 2801 >> Accept A Tale of Sorrow
step
#era
>> Go through the whole dialogue
.complete 2801,1
.skipgossip
step
#era
.goto Blasted Lands,52.76,2.93
.target Fallen Hero of the Horde
>>Talk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r
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
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3122 >> Turn in Return to Witch Doctor Uzer'i
.target Witch Doctor Uzer'i
.accept 3123 >> Accept Testing the Vessel
.accept 3380 >> Accept The Sunken Temple
.accept 3128 >> Accept Natural Materials
step
#era
.goto Feralas,75.45,44.36
.fly Tanaris>> Fly to Tanaris
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 40-50
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
#level 46
.goto Feralas,74.50,43.40
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3122 >> Turn in Return to Witch Doctor Uzer'i
.target Witch Doctor Uzer'i
.accept 3123 >> Accept Testing the Vessel
.accept 3380 >> Accept The Sunken Temple
step
#som
.goto Feralas,74.50,43.40
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3122 >> Turn in Return to Witch Doctor Uzer'i
.target Witch Doctor Uzer'i
.accept 3123 >> Accept Testing the Vessel
.accept 3128 >> Accept Natural Materials
step
#som
.goto Feralas,75.45,44.36
.fly Tanaris>> Fly to Tanaris
step
#era
.goto Tanaris,52.70,7.80
.target Kravel Koalbeard
>>Talk to |cRXP_FRIENDLY_Kravel Koalbeard|r
.turnin 1119 >> Turn in Zanzil's Mixture and a Fool's Stout
.timer 13,Kravel Koalbeard RP
step
.isQuestComplete 1187
.goto Tanaris,54.30,7.10
.target Razzeric
>>Talk to |cRXP_FRIENDLY_Razzeric|r
.turnin 1187 >> Turn in Razzeric's Tweaking
step
.goto Tanaris,54.30,7.10
.isQuestTurnedIn 1187
.target Razzeric
>>Talk to |cRXP_FRIENDLY_Razzeric|r
.accept 1188 >> Accept Safety First
step
#era
.goto Tanaris,52.70,7.80
.target Kravel Koalbeard
>>Talk to |cRXP_FRIENDLY_Kravel Koalbeard|r
.accept 1120 >> Accept Get the Gnomes Drunk
step
#era
.goto Tanaris,52.60,7.60
.target Gnome Pit Boss
>>Talk to |cRXP_FRIENDLY_Gnome Pit Boss|r
.turnin 1120 >> Turn in Get the Gnomes Drunk
step
#era
.goto Tanaris,52.70,7.80
.target Kravel Koalbeard
>>Talk to |cRXP_FRIENDLY_Kravel Koalbeard|r
.accept 1122 >> Accept Report Back to Fizzlebub
step
.goto Tanaris,50.21,27.48
.target Senior Surveyor Fizzledowser
>>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r
.accept 82 >> Accept Noxious Lair Investigation
step
.goto Tanaris,51.90,27.00
.accept 2875 >> Accept WANTED: Andre Firebeard
step
.goto Tanaris,51.56,26.75
.target Tran'rek
>>Talk to |cRXP_FRIENDLY_Tran'rek|r
.accept 3362 >> Accept Thistleshrub Valley
step
.isQuestComplete 1188
.goto Tanaris,51.00,27.30
.target Shreev
>>Talk to |cRXP_FRIENDLY_Shreev|r
.turnin 1188 >> Turn in Safety First
step
.goto Tanaris,51.80,28.60
.target Marin Noggenfogger
>>Talk to |cRXP_FRIENDLY_Marin Noggenfogger|r
.accept 2605 >> Accept The Thirsty Goblin
step
.goto Tanaris,52.50,27.90
.home >> Set your Hearthstone to Gadgetzan
step
.goto Tanaris,52.80,27.40
.target Andi Lynn
>>Talk to |cRXP_FRIENDLY_Andi Lynn|r
.accept 5863 >> Accept The Dunemaul Compound
step
.goto Tanaris,52.30,27.00
>> Click on the Egg-O-Matic and turn in your Hippogryph Egg (The Super Egg-O-Matic) It's a small metal console sitting next to the teleporter
.accept 2741 >> Accept The Super Egg-O-Matic
.turnin 2741 >> Turn in The Super Egg-O-Matic
step
.goto Tanaris,66.60,22.30
.target Haughty Modiste
>>Talk to |cRXP_FRIENDLY_Haughty Modiste|r
.accept 8365 >> Accept Pirate Hats Ahoy!
step
.goto Tanaris,67.00,22.40
.target Yeh'kinya
>>Talk to |cRXP_FRIENDLY_Yeh'kinya|r
.turnin 3520 >> Turn in Screecher Spirits
step
.goto Tanaris,67.10,23.90
.target Security Chief Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r
.accept 8366 >> Accept Southsea Shakedown
.target Stoley
>>Talk to |cRXP_FRIENDLY_Stoley|r
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
.isOnQuest 3380
.goto Tanaris,52.70,45.92
>>Leave Lost Rigger Cove
.target Marvon Rivetseeker
>>Talk to |cRXP_FRIENDLY_Marvon Rivetseeker|r
.turnin 3380 >> Turn in The Sunken Temple
step
.goto Tanaris,52.70,45.92

.target Marvon Rivetseeker
>>Talk to |cRXP_FRIENDLY_Marvon Rivetseeker|r
.accept 3161 >> Accept Gahz'ridian << !Hunter
step << !Hunter
.goto Tanaris,52.70,45.92
>>Leave Lost Rigger Cove

.target Marvon Rivetseeker
>>Talk to |cRXP_FRIENDLY_Marvon Rivetseeker|r
.accept 3161 >> Accept Gahz'ridian
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
.target Tooga
>>Talk to |cRXP_FRIENDLY_Tooga|r
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
.complete 1560,1 
.target Torta
>>Talk to |cRXP_FRIENDLY_Torta|r
.turnin 1560 >> Turn in Tooga's Quest
step
.goto Tanaris,67.00,23.90
.target Security Chief Bilgewhizzle
>>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r
.turnin 2875 >> Turn in WANTED: Andre Firebeard
.turnin 8366 >> Turn in Southsea Shakedown
>>Talk to |cRXP_FRIENDLY_Stoley|r
.turnin 2873 >> Turn in Stoley's Shipment
.target Stoley
.accept 2874 >> Accept Deliver to MacKinley
step
.goto Tanaris,66.60,22.30
.target Haughty Modiste
>>Talk to |cRXP_FRIENDLY_Haughty Modiste|r
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
>>Talk to |cRXP_FRIENDLY_Marin Noggenfogger|r
.turnin 2605 >> Turn in The Thirsty Goblin
.target Marin Noggenfogger
.accept 2606 >> Accept In Good Taste
step
.goto Tanaris,50.90,27.00
.target Alchemist Pestlezugg
>>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r
.turnin 82 >> Turn in Noxious Lair Investigation
step
.goto Tanaris,51.10,26.90
>>Talk to |cRXP_FRIENDLY_Sprinkle|r
.turnin 2606 >> Turn in In Good Taste
.target Sprinkle
.accept 2641 >> Accept Sprinkle's Secret Ingredient
step
.goto Tanaris,50.20,27.50
.target Senior Surveyor Fizzledowser
>>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r
.accept 10 >> Accept The Scrimshank Redemption
step
.goto Tanaris,51.50,26.80
.target Tran'rek
>>Talk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 3362 >> Turn in Thistleshrub Valley
step
.goto Tanaris,52.80,27.40
.target Andi Lynn
>>Talk to |cRXP_FRIENDLY_Andi Lynn|r
.turnin 5863 >> Turn in The Dunemaul Compound
step
.goto Tanaris,52.70,45.90
.target Marvon Rivetseeker
>>Talk to |cRXP_FRIENDLY_Marvon Rivetseeker|r
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
>>If you managed to find a distress beacon, right click it and accept the quest, otherwise skip this step
.accept 351 >> Accept Find OOX-17/TN!
step
.isOnQuest 351
.goto Tanaris,60.20,64.70
.target Homing Robot OOX-17/TN
>>Talk to |cRXP_FRIENDLY_Homing Robot OOX-17/TN|r
.turnin 351 >> Turn in Find OOX-17/TN!
step
.isQuestTurnedIn 351
.goto Tanaris,60.23,64.71
>> Start the escort quest
.target Homing Robot OOX-17/TN
>>Talk to |cRXP_FRIENDLY_Homing Robot OOX-17/TN|r
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
>>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r
.turnin 10 >> Turn in The Scrimshank Redemption
.target Senior Surveyor Fizzledowser
.accept 110 >> Accept Insect Part Analysis
step
.goto Tanaris,50.90,27.00
>>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r
.turnin 110 >> Turn in Insect Part Analysis
.target Alchemist Pestlezugg
.accept 113 >> Accept Insect Part Analysis
step
.goto Tanaris,50.20,27.50
>>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r
.turnin 113 >> Turn in Insect Part Analysis
.target Senior Surveyor Fizzledowser
.accept 32 >> Accept Rise of the Silithid
step
#era
.goto Tanaris,51.60,25.50
.fly Brackenwall >> Fly to Brackenwall
step
#era
.goto Dustwallow Marsh,37.10,33.00
.target Draz'Zilb
>>Talk to |cRXP_FRIENDLY_Draz'Zilb|r
.accept 1170 >> Accept The Brood of Onyxia
step
#era
.goto Dustwallow Marsh,36.30,31.40
>>Talk to |cRXP_FRIENDLY_Overlord Mok'Morokk|r
.turnin 1170 >> Turn in The Brood of Onyxia
.target Overlord Mok'Morokk
.accept 1171 >> Accept The Brood of Onyxia
step
#era
.goto Dustwallow Marsh,37.10,33.00
>>Talk to |cRXP_FRIENDLY_Draz'Zilb|r
.turnin 1171 >> Turn in The Brood of Onyxia
.target Draz'Zilb
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
.target Draz'Zilb
>>Talk to |cRXP_FRIENDLY_Draz'Zilb|r
.turnin 1172 >> Turn in The Brood of Onyxia
step
#era
.goto Dustwallow Marsh,36.30,31.50
>> Accepting this quest turns Overlord Mok'Morokk hostile. Be prepared
>> Be careful, as this quest can be HARD
.target Overlord Mok'Morokk
>>Talk to |cRXP_FRIENDLY_Overlord Mok'Morokk|r
.accept 1173 >> Accept Challenge Overlord Mok'Morokk
step
#era
>> Defeat Overlord Mok'Morokk by reducing his health to about 30%
.complete 1173,1
step
#era
.goto Dustwallow Marsh,37.10,33.00
.target Draz'Zilb
>>Talk to |cRXP_FRIENDLY_Draz'Zilb|r
.turnin 1173 >> Turn in Challenge Overlord Mok'Morokk
step << !Mage
.isQuestComplete 1205
#era
.goto Dustwallow Marsh,35.57,31.89
.fly Thunder Bluff>> Fly to Thunder Bluff
step << !Mage
.isQuestComplete 1205
#som
.goto Tanaris,51.60,25.50
.fly Thunder Bluff>> Fly to Thunder Bluff
step << Mage
.isQuestComplete 1205
.zone Thunder Bluff >> Teleport to Thunder Bluff
step
.isQuestComplete 1205
.goto Thunder Bluff,61.50,80.90
.target Melor Stonehoof
>>Talk to |cRXP_FRIENDLY_Melor Stonehoof|r
.turnin 1205 >> Turn in Deadmire
step << Druid
.isQuestTurnedIn 1205
.goto Thunder Bluff,77.0,29.9
.trainer >> Go and train your class spells
step << Hunter
.isQuestTurnedIn 1205
.goto Thunder Bluff,59.1,86.9
.trainer >> Go and train your class spells
step << Hunter
.isQuestTurnedIn 1205
.goto Thunder Bluff,54.1,83.9
.trainer >> Go and train your pet spells
step << Warrior
.isQuestTurnedIn 1205
.goto Thunder Bluff,57.6,85.5
.trainer >> Go and train your class spells
step
.isQuestTurnedIn 1205
#softcore
>>Go to the Auction House. Buy 15 Silk Cloth
.goto Thunder Bluff,40.42,51.74
.collect 4306,15
step << !Mage
.goto Thunder Bluff,47.003,49.832
.fly Orgrimmar>> Fly to Orgrimmar
step << Mage
.zone Orgrimmar >> Teleport to Orgrimmar
step << Shaman
.goto Orgrimmar,38.6,36.0
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,66.046,18.526
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
.target Zilzibin Drumlore
>>Talk to |cRXP_FRIENDLY_Zilzibin Drumlore|r
.turnin 32 >> Turn in Rise of the Silithid
step
.goto Orgrimmar,59.40,36.70
.target Dran Droffers
>>Talk to |cRXP_FRIENDLY_Dran Droffers|r
.accept 649 >> Accept Ripple Recovery
step
.goto Orgrimmar,59.50,36.80
>>Talk to |cRXP_FRIENDLY_Malton Droffers|r
.turnin 649 >> Turn in Ripple Recovery
.target Malton Droffers
.accept 650 >> Accept Ripple Recovery
step
#era
.goto Orgrimmar,55.52,34.07
.target Jes'rimon
>>Talk to |cRXP_FRIENDLY_Jes'rimon|r
.accept 4300 >> Accept Bone-Bladed Weapons
step
#som
#level 48
.goto Orgrimmar,55.52,34.07
.target Jes'rimon
>>Talk to |cRXP_FRIENDLY_Jes'rimon|r
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
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 40-50
#classic
<< Horde
#name 48-49 The Hinterlands
#next 49-50 Feralas
#somname 47-49 The Hinterlands
step << Mage
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy four Runes of Teleportation (or more if you want)
.collect 17031,4 
step
.goto Undercity,73.20,32.80
.target Oran Snakewrithe
>>Talk to |cRXP_FRIENDLY_Oran Snakewrithe|r
.accept 2995 >> Accept Lines of Communication
step
.goto Undercity,48.50,71.90
.target Chemist Cuely
>>Talk to |cRXP_FRIENDLY_Chemist Cuely|r
.accept 3568 >> Accept Seeping Corruption
step
.isOnQuest 864
.goto Undercity,50.00,68.20
.target Apothecary Zinge
>>Talk to |cRXP_FRIENDLY_Apothecary Zinge|r
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
>>Talk to |cRXP_FRIENDLY_Gilveradin Sunchaser|r
.turnin 650 >> Turn in Ripple Recovery
.target Gilveradin Sunchaser
.accept 77 >> Accept A Sticky Situation
step
#label ViHo
.goto The Hinterlands,72.50,66.20,50,0
.goto The Hinterlands,77.10,80.00
>> Head to Revantusk Village
.target Smith Slagtree
>>Talk to |cRXP_FRIENDLY_Smith Slagtree|r
.accept 7839 >> Accept Vilebranch Hooligans
step
.goto The Hinterlands,78.20,81.30
.target Lard
>>Talk to |cRXP_FRIENDLY_Lard|r
.accept 7840 >> Accept Lard Lost His Lunch
step
.goto The Hinterlands,80.40,81.50
.target Katoom the Angler
>>Talk to |cRXP_FRIENDLY_Katoom the Angler|r
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
#hidewindow
#requires Turtles
step
#hidewindow
#requires Gammerita
step
#requires Bottles
.goto The Hinterlands,80.30,81.40
.target Katoom the Angler
>>Talk to |cRXP_FRIENDLY_Katoom the Angler|r
.turnin 7815 >> Turn in Snapjaws, Mon!
.turnin 7816 >> Turn in Gammerita, Mon!
step
.goto The Hinterlands,78.20,81.30
.target Lard
>>Talk to |cRXP_FRIENDLY_Lard|r
.turnin 7840 >> Turn in Lard Lost His Lunch
step
.goto The Hinterlands,78.80,78.40
.target Mystic Yayo'jin
>>Talk to |cRXP_FRIENDLY_Mystic Yayo'jin|r
.accept 7844 >> Accept Cannibalistic Cousins
step
.goto The Hinterlands,79.40,79.10
.target Otho Moji'ko
>>Talk to |cRXP_FRIENDLY_Otho Moji'ko|r
.accept 7841 >> Accept Message to the Wildhammer
step
.goto The Hinterlands,79.10,79.50
.target Huntsman Markhor
>>Talk to |cRXP_FRIENDLY_Huntsman Markhor|r
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
.target Rin'ji
>>Talk to |cRXP_FRIENDLY_Rin'ji|r
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
>> Kill Savage Owlbeasts and use the Wildkin Muisek Vessel on their corpses
.complete 7829,1
.complete 3123,1
step
>>Swim to the island to the far east
.goto The Hinterlands,86.30,59.00
.turnin 2742 >> Turn in Rin'ji is Trapped!
.accept 2782 >> Accept Rin'ji's Secret
step
>>Run back to Revantusk Village
.goto The Hinterlands,77.20,80.20
.target Smith Slagtree
>>Talk to |cRXP_FRIENDLY_Smith Slagtree|r
.turnin 7839 >> Turn in Vilebranch Hooligans
step
.goto The Hinterlands,78.80,78.40
.target Mystic Yayo'jin
>>Talk to |cRXP_FRIENDLY_Mystic Yayo'jin|r
.turnin 7844 >> Turn in Cannibalistic Cousins
step
.goto The Hinterlands,79.10,79.50
.target Huntsman Markhor
>>Talk to |cRXP_FRIENDLY_Huntsman Markhor|r
.turnin 7828 >> Turn in Stalking the Stalkers
.turnin 7829 >> Turn in Hunt the Savages
.turnin 7830 >> Turn in Avenging the Fallen
step
#hardcore
>>You can accept the follow-up to these quests, but be aware that it DOES flag you for PVP in a densely-populated Alliance area
.goto The Hinterlands,79.30,79.10
>>Talk to |cRXP_FRIENDLY_Otho Moji'ko|r
.turnin 7841 >> Turn in Message to the Wildhammer
.target Otho Moji'ko
.accept 7842 >> Accept Another Message to the Wildhammer
.turnin 7842 >> Turn in Another Message to the Wildhammer
step
#softcore
.goto The Hinterlands,79.38,79.08
>>Talk to |cRXP_FRIENDLY_Otho Moji'ko|r
.turnin 7841 >> Turn in Message to the Wildhammer
.target Otho Moji'ko
.accept 7842 >> Accept Another Message to the Wildhammer
.turnin 7842 >> Turn in Another Message to the Wildhammer
.accept 7843 >> Accept The Final Message to the Wildhammer
step
.goto The Hinterlands,81.70,81.75
.fp Hinterlands >> Get the Hinterlands Flight Path
.fly Tarren Mill>> Fly to Tarren Mill
step
.goto Hillsbrad Foothills,61.50,19.20
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 2933 >> Turn in Venom Bottles
.target Apothecary Lydon
.accept 2934 >> Accept Undamaged Venom Sac
step
.isOnQuest 7843
.goto The Hinterlands,14.0,48.3
>>Run back to The Hinterlands
>> Go place the flag in Aerie Peak, wait for the guard to patrol away first.
.complete 7843,1
step
.goto The Hinterlands,26.70,48.60
>>Talk to |cRXP_FRIENDLY_Gilveradin Sunchaser|r
.turnin 77 >> Turn in A Sticky Situation
.target Gilveradin Sunchaser
.accept 81 >> Accept Ripple Delivery
step
>>Run to Shadra'Alor. Kill a Witherbark Broodguard. Loot it for its Undamaged Venom Sac
>>Be careful as it expires after 30 minutes
.goto The Hinterlands,35.76,64.24,60,0
.goto The Hinterlands,25.2,70.8
.complete 2934,1
step
#era
.goto The Hinterlands,33.70,75.10
.target Atal'ai Exile
>>Talk to |cRXP_FRIENDLY_Atal'ai Exile|r
.turnin 1429 >> Turn in The Atal'ai Exile
step
#era
.goto The Hinterlands,33.70,75.10
.target Atal'ai Exile
>>Talk to |cRXP_FRIENDLY_Atal'ai Exile|r
.accept 1444 >> Accept Return to Fel'Zerul
step
.goto The Hinterlands,49.30,37.70
>> Manually skip this step if you haven't found the Distress Beacon
.accept 485 >> Accept Find OOX-09/HL!
.target Homing Robot OOX-09/HL
>>Talk to |cRXP_FRIENDLY_Homing Robot OOX-09/HL|r
.turnin 485 >> Turn in Find OOX-09/HL!

step
.isQuestTurnedIn 485
.goto The Hinterlands,49.35,37.65
>> Start the chicken escort
.target Homing Robot OOX-09/HL
>>Talk to |cRXP_FRIENDLY_Homing Robot OOX-09/HL|r
.accept 836 >> Accept Rescue OOX-09/HL!

step
.isQuestTurnedIn 485
>> Escort the robot chicken. 2 Waves will spawn: 3 level 46 Owlbeasts that Enrage and 3 level 47 Vilebranch Ambushers that can execute (Can instantly kill you when you're below 20% health)
>> Be careful, as this quest is HARD
.goto The Hinterlands,79.47,61.21
.complete 836,1 
step
.isOnQuest 7843
>>Run back to Revantusk Village
.goto The Hinterlands,79.40,79.10
.target Otho Moji'ko
>>Talk to |cRXP_FRIENDLY_Otho Moji'ko|r
.turnin 7843 >> Turn in The Final Message to the Wildhammer
step
.goto The Hinterlands,81.70,81.75
.fly Tarren Mill>> Fly to Tarren Mill
step
.goto Hillsbrad Foothills,61.50,19.20
>>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 2934 >> Turn in Undamaged Venom Sac
.target Apothecary Lydon
.accept 2935 >> Accept Consult Master Gadrin << Troll
step << !Mage
.goto Hillsbrad Foothills,60.10,18.60
.fly Undercity >> Fly to Undercity
step << Mage
.zone Undercity >> Teleport to Undercity
step << Mage
.goto Undercity,82.79,15.82
.vendor >> Go to Hannah. Buy four Runes of Teleportation (or more if you want)
.collect 17031,4 
step << Troll
#sticky
#completewith next
.abandon 2935 >> Abandon Consult Master Gadrin IF you already have a mount. If u don't have a mount, keep it until you get one.
step
.goto Undercity,73.50,32.70
>>Talk to |cRXP_FRIENDLY_Oran Snakewrithe|r
.turnin 2995 >> Turn in Lines of Communication
.turnin 2782 >> Turn in Rin'ji's Secret
.target Oran Snakewrithe
.accept 8273 >> Accept Oran's Gratitude
.turnin 8273 >> Turn in Oran's Gratitude
step
.hs >> Hearth to Tanaris
>> Buy food/water if needed
step
.goto Tanaris,51.10,26.90
>>Talk to |cRXP_FRIENDLY_Sprinkle|r
.turnin 2641 >> Turn in Sprinkle's Secret Ingredient
.target Sprinkle
.accept 2661 >> Accept Delivery for Marin
step
.goto Tanaris,51.80,28.60
>>Talk to |cRXP_FRIENDLY_Marin Noggenfogger|r
.turnin 2661 >> Turn in Delivery for Marin
.target Marin Noggenfogger
.accept 2662 >> Accept Noggenfogger Elixir
.turnin 2662 >> Turn in Noggenfogger Elixir
>> Make sure you carry 1 stack of noggenfogger with you at all times, buy 2 extra stacks and bank it
.collect 8529,60
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 40-50
#classic
<< Horde
#name 49-50 Feralas
#next RestedXP Horde 50-60\50-51 Stranglethorn/Blasted Lands
step
.maxlevel 50,Feralasskip
.goto Tanaris,51.60,25.50
.fly Feralas>> Fly to Feralas
step
#era/som
.goto Feralas,76.20,43.80
.target Talo Thornhoof
>>Talk to |cRXP_FRIENDLY_Talo Thornhoof|r
.accept 3062 >> Accept Dark Heart
.accept 3063 >> Accept Vengeance on the Northspring
.accept 4120 >> Accept The Strength of Corruption
step
#som
#phase 3-6
.goto Feralas,76.20,43.80
.target Talo Thornhoof
>>Talk to |cRXP_FRIENDLY_Talo Thornhoof|r
.accept 3062 >> Accept Dark Heart
.accept 3063 >> Accept Vengeance on the Northspring
step
.goto Feralas,74.50,42.90
.target Jangdor Swiftstrider
>>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r
.accept 7734 >> Accept Improved Quality
step
#som
.goto Feralas,74.50,43.40
.target Witch Doctor Uzer'i
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.accept 3380 >> Accept The Sunken Temple
step
.goto Feralas,74.50,43.40
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3123 >> Turn in Testing the Vessel
.target Witch Doctor Uzer'i
.accept 3124 >> Accept Hippogryph Muisek
.accept 3128 >> Accept Natural Materials
step
#som
.goto Feralas,54.4,68.1
>>Kill Frayfeather Hippogryphs. Loot them for Metallic Fragments, then use the Hippogryph Muisek Vessel on their corpses
.complete 3124,1 
.complete 3128,4 
step
#era
.goto Feralas,54.4,68.1
>>Kill Frayfeather Hippogryphs. Loot them for Metallic Fragments, then use the Hippogryph Muisek Vessel on their corpses
.complete 3124,1 
.complete 3128,4 
step
.goto Feralas,74.4,43.4
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3124 >> Turn in Hippogryph Muisek
.target Witch Doctor Uzer'i
.accept 3125 >> Accept Faerie Dragon Muisek
step
.goto Feralas,68.68,48.60
>>Kill Faerie Dragons. Loot them for Encrusted Minerals, then use the Faerie Muisek Vessel on their corpses
.complete 3125,1 
.complete 3128,2 
step
.goto Feralas,74.4,43.3
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3125 >> Turn in Faerie Dragon Muisek
.target Witch Doctor Uzer'i
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
.collect 9590,1 
.collect 9593,1 
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
.collect 9590,2 
.collect 9593,2 
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
.collect 9593,3 
.unitscan Wandering Forest Walker
step
.goto Feralas,74.5,43.4
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3126 >> Turn in Treant Muisek
.target Witch Doctor Uzer'i
.accept 3127 >> Accept Mountain Giant Muisek
step
>>Run west to the shore
.goto Feralas,44.9,43.4
.target Zorbin Fandazzle
>>Talk to |cRXP_FRIENDLY_Zorbin Fandazzle|r
.accept 7003 >> Accept Zapped Giants
step
#sticky
#completewith next
>> Perfect Yeti Hide drops from the mobs which starts a quest. Skip it if you don't get it before all of the Rage Scar Yeti Hides. Don't accept the quest yet
.collect 18972
step
>>Kill Scar Yetis. Loot them for their Hides
.goto Feralas,55.0,33.0
.complete 7734,1 
step
>> Use Zorbin's Ultra-Shrinker to weaken the giants. Kill them. Loot them for their Residue, then use the Mountain Giant Musiek Vessel on their corpses
.goto Feralas,38.8,21.6
.complete 3127,1 
.collect 18956,8 
step
#completewith next
>>Kill the Harpies in the area
.goto Feralas,38.1,14.4,0
.complete 3063,1 
.complete 3063,2 
.complete 3063,3 
.complete 3063,4 
step
>>Go to the big rock. Use the Horn of Hatetalon in your inventory
>>Kill Edana Hatetalon. Loot her for her Heart
.goto Feralas,40.5,8.6
.complete 3062,1 
step
>>Kill the Harpies in the area
.goto Feralas,38.1,14.4
.complete 3063,1 
.complete 3063,2 
.complete 3063,3 
.complete 3063,4 
step
>> Finish Zapped Giants.
.goto Feralas,38.8,21.6
.complete 7003,1 
step
.goto Feralas,44.9,43.4
.target Zorbin Fandazzle
>>Talk to |cRXP_FRIENDLY_Zorbin Fandazzle|r
.turnin 7003 >> Turn in Zapped Giants
step
.hs >>Hearth to Gadgetzan
>> Buy food/water if needed
step
#label Feralasskip
#som
.goto Tanaris,52.70,45.92
.target Marvon Rivetseeker
>>Talk to |cRXP_FRIENDLY_Marvon Rivetseeker|r
.turnin 3380 >> Turn in The Sunken Temple
step
#completewith next
.goto Tanaris,27.00,55.66,150,0
.goto Tanaris,27.00,50.21
.zone Un'Goro Crater >> Run to Un'Goro Crater
step
.goto Un'Goro Crater,71.63,75.95
.target Torwa Pathfinder
>>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r
.accept 4289 >> Accept The Apes of Un'Goro
.accept 4290 >> Accept The Fare of Lar'korwi
step
.isOnQuest 4300
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
.target Torwa Pathfinder
>>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r
.accept 4289 >> Accept The Apes of Un'Goro
.accept 4290 >> Accept The Fare of Lar'korwi
step
.goto Un'Goro Crater,63.10,68.60
.accept 3844 >> Accept It's a Secret to Everybody
step
>>Turn around, go under the water
.goto Un'Goro Crater,63.10,69.00
.turnin 3844 >> Turn in It's a Secret to Everybody
.accept 3845 >> Accept It's a Secret to Everybody
step
.goto Un'Goro Crater,68.80,56.80
>> Click the giant Threshadon. Loot it for its carcass
.complete 4290,1
step
.goto Un'Goro Crater,71.60,76.00
>>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r
.turnin 4290 >> Turn in The Fare of Lar'korwi
.target Torwa Pathfinder
.accept 4291 >> Accept The Scent of Lar'korwi
step
.goto Un'Goro Crater,67.30,73.10,20,0
.goto Un'Goro Crater,66.60,66.70
>> Step on the small egg nests to summon Lar'Kowi Mates. Kill and loot them for the Glands
.complete 4291,1
step
#label Scent
.goto Un'Goro Crater,71.63,75.95
>>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r
.turnin 4291 >> Turn in The Scent of Lar'korwi
.target Torwa Pathfinder
.accept 4292 >> Accept The Bait for Lar'korwi
step
.isOnQuest 4300
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
>>Talk to |cRXP_FRIENDLY_Linken|r
.turnin 3845 >> Turn in It's a Secret to Everybody
.target Linken
.accept 3908 >> Accept It's a Secret to Everybody
step
#completewith next
.destroy 3108 >> Delete the Heavy Throwing Daggers from your inventory
.destroy 11108 >> Delete the Faded Photograph from your inventory
step
>>Go into the cave
.goto Un'Goro Crater,43.16,6.24,30,0
.goto Un'Goro Crater,41.90,2.70
.target J.D. Collie
>>Talk to |cRXP_FRIENDLY_J.D. Collie|r
.accept 4284 >> Accept Crystals of Power
.turnin 4284 >> Turn in Crystals of Power
step
.goto Un'Goro Crater,43.16,6.24,30,0
.goto Un'Goro Crater,45.23,5.82
>>Exit the Cave
.fp Marshal >> Get the Un'Goro Crater Flight Path
.fly Camp Mojache >> Fly to Camp Mojache
step
.isQuestComplete 3128
.goto Feralas,74.5,43.3
.target Witch Doctor Uzer'i
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3128 >> Turn in Natural Materials
step
.goto Feralas,74.5,43.3
.target Witch Doctor Uzer'i
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3127 >> Turn in Mountain Giant Muisek
.isQuestComplete 3127
step
.goto Feralas,74.5,43.3
.target Witch Doctor Uzer'i
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.accept 3129 >> Accept Weapons of Spirit
.isQuestTurnedIn 3127
step
.isQuestComplete 7734
.goto Feralas,74.5,42.9
.target Jangdor Swiftstrider
>>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r
.turnin 7734 >> Turn in Improved Quality
step
.isOnQuest 7738
.target Jangdor Swiftstrider
>>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r
.turnin 7738 >>Turn in Perfect Yeti Hide
step
.isQuestComplete 3062
.goto Feralas,76.1,43.8
.target Talo Thornhoof
>>Talk to |cRXP_FRIENDLY_Talo Thornhoof|r
.turnin 3062 >> Turn in Dark Heart
step
.isQuestComplete 3063
.goto Feralas,76.1,43.8
.target Talo Thornhoof
>>Talk to |cRXP_FRIENDLY_Talo Thornhoof|r
.turnin 3063 >> Turn in Vengeance on the Northspring
step
.isQuestComplete 3129
.goto Feralas,74.4,43.4
.target Witch Doctor Uzer'i
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3129 >> Turn in Weapons of Spirit
step
#som
#phase 3-6
.goto Feralas,74.4,43.4
.target Witch Doctor Uzer'i
>>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r
.turnin 3123 >> Turn in Testing The Vessel
step << Druid
.goto Feralas,76.0,42.3
.trainer >> Go and train your class spells
step
.goto Feralas,75.4,44.3,0
.fly Ratchet >> Fly to Ratchet
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 50-60
#classic
<< Horde
#name 50-51 Stranglethorn/Blasted Lands
#next 51-52 Searing Gorge/Burning Steppes
step
.goto The Barrens,62.50,38.70
.target Liv Rizzlefix
>>Talk to |cRXP_FRIENDLY_Liv Rizzlefix|r
.accept 4502 >> Accept Volcanic Activity
step << skip
.goto The Barrens,62.50,38.60
>> Loot the small wooden chest just outside the building for The Stone Circle
.complete 3444,1
step
.goto The Barrens,62.05,39.41
.home >> Set your Hearthstone to Ratchet
step
.goto The Barrens,63.74,38.66
.zone Stranglethorn Vale >> Take the boat to Stranglethorn Vale
step << !Warrior !Rogue !Shaman
#sticky
>> Look for Mok'rash, an elite giant at the giant goblin statue
>>Set up a slow trap near the goblin statue and kite him with cheetah << Hunter
>>Kill him by kiting in circles around the goblin statue
>>Fear him as much as you can, he's not immune to fear or slows << Priest/Warlock
>>Once he gets to around 60% hp, use Levitate to kite him back to Booty Bay << Priest
>>Only use ranged spells (root/starfire/moonfire) he hits HARD << Druid
>>Loot and right click The Monogrammed Sash
.collect 3985,1,8552
.accept 8552 >> Accept The Monogrammed Sash
>>This can be a very hard elite to solo, skip this step if you have to
.link https://www.youtube.com/watch?v=xw2mGnQaCQM >> Click here for video reference << Priest
.link https://www.twitch.tv/videos/850022146?t=04h16m26s >> Click here for video reference << !Priest
step
.isQuestComplete 648
.goto Stranglethorn Vale,28.40,76.30
.target Oglethorpe Obnoticus
>>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r
.turnin 648 >> Turn in Rescue OOX-17/TN!
step
.isQuestComplete 836
.goto Stranglethorn Vale,28.40,76.30
.target Oglethorpe Obnoticus
>>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r
.turnin 836 >> Turn in Rescue OOX-09/HL!
step
.isQuestComplete 2767
.goto Stranglethorn Vale,28.40,76.30
.target Oglethorpe Obnoticus
>>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r
.turnin 2767 >> Turn in Rescue OOX-22/FE!
step
.goto Stranglethorn Vale,28.40,76.30
.target Oglethorpe Obnoticus
>>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r
.accept 3721 >> Accept An OOX of Your Own
.turnin 3721 >> Turn in An OOX of Your Own
.isQuestTurnedIn 2767
.isQuestTurnedIn 836
.isQuestTurnedIn 648
step
.isQuestComplete 648
.goto Stranglethorn Vale,28.40,76.30
.target Oglethorpe Obnoticus
>>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r
.turnin 648 >> Turn in Rescue OOX-17/TN!
step
.isQuestComplete 836
.goto Stranglethorn Vale,28.40,76.30
.target Oglethorpe Obnoticus
>>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r
.turnin 836 >> Turn in Rescue OOX-09/HL!
step
.isQuestComplete 2767
.goto Stranglethorn Vale,28.40,76.30
.target Oglethorpe Obnoticus
>>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r
.turnin 2767 >> Turn in Rescue OOX-22/FE!
step << !Warrior !Rogue !Shaman
.isOnQuest 8552
.goto Stranglethorn Vale,26.70,73.60
.target Captain Hecklebury Smotts
>>Talk to |cRXP_FRIENDLY_Captain Hecklebury Smotts|r
.turnin 8552 >> Turn in The Monogrammed Sash
step
.isQuestTurnedIn 8552
.goto Stranglethorn Vale,26.70,73.60
.target Captain Hecklebury Smotts
>>Talk to |cRXP_FRIENDLY_Captain Hecklebury Smotts|r
.accept 615 >> Accept The Captain's Cutlass
.target Sprogger
>>Talk to |cRXP_FRIENDLY_Sprogger|r
.turnin 615 >> Turn in The Captain's Cutlass
step
#completewith next
.goto Stranglethorn Vale,26.54,76.57
.collect 4306,15 >> Take out 15 Silk cloth from the bank if you have them.
step
.goto Stranglethorn Vale,27.70,77.10
.target "Sea Wolf" MacKinley
>>Talk to |cRXP_FRIENDLY_"Sea Wolf" MacKinley|r
.turnin 2874 >> Turn in Deliver to MacKinley
step
.goto Stranglethorn Vale,27.10,77.50
.target Whiskey Slim
>>Talk to |cRXP_FRIENDLY_Whiskey Slim|r
.turnin 580 >> Turn in Whiskey Slim's Lost Grog
step
#era
.goto Stranglethorn Vale,27.10,77.30
.target Crank Fizzlebub
>>Talk to |cRXP_FRIENDLY_Crank Fizzlebub|r
.turnin 1122 >> Turn in Report Back to Fizzlebub
step
#era
.goto Stranglethorn Vale,26.87,77.10
.fly Stonard>> Fly to Stonard
step
#era
.goto Swamp of Sorrows,47.90,55.00
.target Fel'zerul
>>Talk to |cRXP_FRIENDLY_Fel'zerul|r
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
.target Kum'isha the Collector
>>Talk to |cRXP_FRIENDLY_Kum'isha the Collector|r
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
.target Bloodmage Drazial
>>Talk to |cRXP_FRIENDLY_Bloodmage Drazial|r
.accept 2585 >> Accept The Decisive Striker
.turnin 2585 >> Turn in The Decisive Striker
step << Druid/Paladin/Warrior/Shaman
#era
.goto Blasted Lands,50.55,14.20
>>Go back to the quest giver once you get the following:
>>3 Snickerfang Jowl
>>2 Blasted Boar Lung
>>1 Scorpok Pincer
.target Bloodmage Drazial
>>Talk to |cRXP_FRIENDLY_Bloodmage Drazial|r
.accept 2581 >> Accept Snickerfang Jowls
.turnin 2581 >> Turn in Snickerfang Jowls
step
#era
#requires blquests
.goto Blasted Lands,50.55,14.20
.target Bloodmage Drazial
>>Talk to |cRXP_FRIENDLY_Bloodmage Drazial|r
.accept 2585 >> Accept The Decisive Striker << !Rogue !Hunter
.turnin 2585 >> Turn in The Decisive Striker << !Rogue !Hunter
.accept 2583 >> Accept A Boar's Vitality
.turnin 2583 >> Turn in A Boar's Vitality
.accept 2581 >> Accept Snickerfang Jowls << !Druid !Warrior !Shaman
.turnin 2581 >> Turn in Snickerfang Jowls << !Druid !Warrior !Shaman
.target Bloodmage Lynnore
>>Talk to |cRXP_FRIENDLY_Bloodmage Lynnore|r
.accept 2601 >> Accept The Basilisk's Bite
.turnin 2601 >> Turn in The Basilisk's Bite
.accept 2603 >> Accept Vulture's Vigor
.turnin 2603 >> Turn in Vulture's Vigor
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 50-60
#classic
<< Horde
#name 51-52 Searing Gorge/Burning Steppes
#next 52-53 Azshara
step
#era
.fly Badlands>> Fly to Badlands
step
#sticky
#label Badlandsarrive
#som
>> Fly to Badlands, if you don't have the flightpath take the teleporter to Gnomeregan and follow the video guide.
.goto Badlands,4.0,44.80,100
step
#som
.goto Stranglethorn Vale,27.7,77.4
#completewith Badlandsarrive
>> Walk into the teleporter next to the questgiver after accepting and delivering the quest.
.target Scooty
>>Talk to |cRXP_FRIENDLY_Scooty|r
.accept 2843 >> Accept Gnomer-gooooone!
.turnin 2843 >> Turn in Gnomer-gooooone!
.maxlevel 51,Searingskip
step
#som
.goto Dun Morogh,78.0,62.7
.zone Badlands >> Walk to the building in the eastern Dun Morogh and logout.
.link https://www.youtube.com/watch?v=MdXtOxSxaYo >> Click here
step
.goto Badlands,3.40,48.10
>> You may have to wait for Thal'trak to finish his RP event. Just follow him around for a bit
.target Thal'trak Proudtusk
>>Talk to |cRXP_FRIENDLY_Thal'trak Proudtusk|r
.accept 3821 >> Accept Dreadmaul Rock
.unitscan Thal'trak Proudtusk
step
.goto Badlands,3.62,61.88,50,0
.goto Searing Gorge,72.34,55.47
.zone Searing Gorge >> Ride to Searing Gorge
step
#sticky
#completewith HoardO
>>Collect 15 Silk Cloth in the zone
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
.target Kalaran Windblade
>>Talk to |cRXP_FRIENDLY_Kalaran Windblade|r
.accept 3441 >> Accept Divine Retribution
>> Talk to Kalaran Windblade Go through his whole dialogue
.complete 3441,1
.skipgossip
step
.goto Searing Gorge,39.05,38.98
>>Talk to |cRXP_FRIENDLY_Kalaran Windblade|r
.turnin 3441 >> Turn in Divine Retribution
.target Kalaran Windblade
.accept 3442 >> Accept The Flawless Flame
step
.goto Searing Gorge,32.50,32.48,30,0
>>Run to Thorium Point
.goto Searing Gorge,34.84,30.89
.fp Thorium >> Get the Searing Gorge Flight Path
step
.goto Searing Gorge,38.58,27.80
.target Hansel Heavyhands
>>Talk to |cRXP_FRIENDLY_Hansel Heavyhands|r
.accept 7723 >> Accept Curse These Fat Fingers
.accept 7724 >> Accept Fiery Menace!
.accept 7727 >> Accept Incendosaurs? Whateverosaur is More Like It
step
.goto Searing Gorge,37.64,26.47
>> Click on the wanted board
.accept 7728 >> Accept STOLEN: Smithing Tuyere and Lookout's Spyglass
.accept 7729 >> Accept JOB OPPORTUNITY: Culling the Competition
step << !Shaman !Druid
.goto Searing Gorge,38.58,27.80
.target Master Smith Burninate
>>Talk to |cRXP_FRIENDLY_Master Smith Burninate|r
.accept 7722 >> Accept What the Flux?
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
>>Talk to |cRXP_FRIENDLY_Kalaran Windblade|r
.turnin 3442 >> Turn in The Flawless Flame
.target Kalaran Windblade
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
>> Pull all 3 mobs with your pet and go loot the plans. << Hunter
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
>>Talk to |cRXP_FRIENDLY_Kalaran Windblade|r
.turnin 3443 >> Turn in Forging the Shaft
.target Kalaran Windblade
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
.target Kalaran Windblade
>>Talk to |cRXP_FRIENDLY_Kalaran Windblade|r
.turnin 3452 >> Turn in The Flame's Casing
step
.isQuestTurnedIn 3452
.goto Searing Gorge,39.05,38.98
>> Stay next to the NPC while the RP event is going
.target Kalaran Windblade
>>Talk to |cRXP_FRIENDLY_Kalaran Windblade|r
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
.target Kalaran Windblade
>>Talk to |cRXP_FRIENDLY_Kalaran Windblade|r
.accept 3462 >> Accept Squire Maltrake
>>Talk to |cRXP_FRIENDLY_Squire Maltrake|r
.turnin 3462 >> Turn in Squire Maltrake
.target Squire Maltrake
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
>> Kill Taskmasters and Slavers
.complete 7729,1
.complete 7729,2
step
#completewith next
.isQuestTurnedIn 3452
.goto Searing Gorge,39.05,38.98
.target Squire Maltrake
>>Talk to |cRXP_FRIENDLY_Squire Maltrake|r
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
.target Hansel Heavyhands
>>Talk to |cRXP_FRIENDLY_Hansel Heavyhands|r
.turnin 7723 >> Turn in Curse These Fat Fingers
.turnin 7724 >> Turn in Fiery Menace!
.turnin 7727 >> Turn in Incendosaurs? Whateverosaur is More Like It
.target Taskmaster Scrange
>>Talk to |cRXP_FRIENDLY_Taskmaster Scrange|r
.turnin 7728 >> Turn in STOLEN: Smithing Tuyere and Lookout's Spyglass
step << !Shaman
.isQuestComplete 7722
.goto Searing Gorge,38.80,28.50
.target Master Smith Burninate
>>Talk to |cRXP_FRIENDLY_Master Smith Burninate|r
.turnin 7722 >> Turn in What the Flux?
step
.goto Searing Gorge,38.80,28.50
.isQuestComplete 7729
.target Taskmaster Scrange
>>Talk to |cRXP_FRIENDLY_Taskmaster Scrange|r
.turnin 7729 >> Turn in JOB OPPORTUNITY: Culling the Competition
step
#completewith next
.goto Searing Gorge,69.2,71.6,50,0
.goto Searing Gorge,73.2,76.0,50,0
.goto Searing Gorge,73.6,83.0,50,0
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
.target Tinkee Steamboil
>>Talk to |cRXP_FRIENDLY_Tinkee Steamboil|r
.accept 4726 >> Accept Broodling Essence
.target Maxwort Uberglint
>>Talk to |cRXP_FRIENDLY_Maxwort Uberglint|r
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
.target Sha'ni Proudtusk
>>Talk to |cRXP_FRIENDLY_Sha'ni Proudtusk|r
.turnin 3821 >> Turn in Dreadmaul Rock
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
>>Talk to |cRXP_FRIENDLY_Tinkee Steamboil|r
.turnin 4726 >> Turn in Broodling Essence
.target Tinkee Steamboil
.accept 4808 >> Accept Felnok Steelspring
.target Maxwort Uberglint
>>Talk to |cRXP_FRIENDLY_Maxwort Uberglint|r
.turnin 4296 >> Turn in Tablet of the Seven
step
.goto Burning Steppes,77.68,38.23
.xp 52 >> Grind mobs in the area to level 52
step
.isQuestTurnedIn 3452
#label HoardO
.goto Burning Steppes,95.09,31.56
>> Go to the cave and turn in A Taste of Flame. Remember to open the Hoard of the Black Dragonflight from earlier
.target Cyrus Therepentous
>>Talk to |cRXP_FRIENDLY_Cyrus Therepentous|r
.accept 4022 >> Accept A Taste of Flame
.turnin 4022 >> Turn in A Taste of Flame
step << Druid
>> Use the spell Teleport to Moonglade
.goto Moonglade,52.526,40.565
.trainer >> Go and train your class spells
step << !Mage
#som
#completewith next
#label Searingskip
.hs >> Hearth to Ratchet or take the boat
>> Buy food/water if needed
step << !Mage
#som
.goto Stranglethorn Vale,26.90,77.10
.fly Orgrimmar >> Fly To Orgrimmar
step << Mage
#som
#label Searingskip
.zone Orgrimmar >> Teleport to Orgrimmar
step << !Mage
#era
#completewith next
.hs >> Hearth to Ratchet or take the boat
>> Buy food/water if needed
step << !Mage
#era
.goto Stranglethorn Vale,26.90,77.10
.fly Orgrimmar >> Fly To Orgrimmar
step << Mage
#era
.zone Orgrimmar >> Teleport to Orgrimmar
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 50-60
#classic
<< Horde
#name 52-53 Azshara
#next 53-53 Felwood
step
.goto Orgrimmar,54.097,68.407
.home >> Set your Hearthstone to Orgrimmar
step << Shaman
.goto Orgrimmar,38.6,36.0
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,66.046,18.526
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
.target Zilzibin Drumlore
>>Talk to |cRXP_FRIENDLY_Zilzibin Drumlore|r
.accept 4494 >> Accept March of the Silithid
step
.goto Orgrimmar,59.40,36.90
.target Dran Droffers
>>Talk to |cRXP_FRIENDLY_Dran Droffers|r
.turnin 81 >> Turn in Ripple Delivery
step
.isQuestComplete 4300
.goto Orgrimmar,55.60,34.20
.target Jes'rimon
>>Talk to |cRXP_FRIENDLY_Jes'rimon|r
.turnin 4300 >> Turn in Bone-Bladed Weapons
step
.goto Orgrimmar,75.00,34.30
.target Belgrom Rockmaul
>>Talk to |cRXP_FRIENDLY_Belgrom Rockmaul|r
.accept 3504 >> Accept Betrayed
step
.maxlevel 53,azharaskip
.goto Orgrimmar,45.120,63.889
.fly Splintertree Post>> Fly to Splintertree Post
step
.goto Azshara,10.40,74.90,40,0
.goto Azshara,11.40,78.10
>> Head to Azshara
.target Loh'atu
>>Talk to |cRXP_FRIENDLY_Loh'atu|r
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
.target Loh'atu
>>Talk to |cRXP_FRIENDLY_Loh'atu|r
.turnin 5535 >> Turn in Spiritual Unrest
.turnin 5536 >> Turn in A Land Filled with Hatred
step
.goto Azshara,22.00,49.70
.fp Azshara >> Get the Azshara Flight Path
step
.isOnQuest 3504
.goto Azshara,22.20,51.50
.target Ag'tor Bloodfist
>>Talk to |cRXP_FRIENDLY_Ag'tor Bloodfist|r
.turnin 3504 >> Turn in Betrayed
step
.isQuestTurnedIn 3504
.goto Azshara,22.20,51.50
.target Ag'tor Bloodfist
>>Talk to |cRXP_FRIENDLY_Ag'tor Bloodfist|r
.accept 3505 >> Accept Betrayed
step
.goto Azshara,22.50,51.40
.target Jediga
>>Talk to |cRXP_FRIENDLY_Jediga|r
.accept 3517 >> Accept Stealing Knowledge
step
.goto Azshara,53.45,21.82
.target Kim'jael
>>Talk to |cRXP_FRIENDLY_Kim'jael|r
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
.turnin 3505 >> Turn in Betrayed
step
.isQuestTurnedIn 3505
.goto Azshara,59.50,31.20
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
>>Talk to |cRXP_FRIENDLY_Kim'jael|r
.turnin 3601 >> Turn in Kim'jael Indeed!
.target Kim'jael
.accept 5534 >> Accept Kim'jael's "Missing" Equipment
step
#label nagasrune
#sticky
>> Kill Nagas. Loot them for "Some Rune"
.complete 5534,1
step
.goto Azshara,47.80,60.80
>> Go south to the cliff and jump down into the water. Then go and use the first Vial.
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
>>These tablets are scattered everywhere in these ruins. Find one of each.
.goto Azshara,37.53,53.48,40,0
.goto Azshara,39.5,48.2,40,0
.goto Azshara,39.0,61.0
.complete 3517,1
.complete 3517,2
.complete 3517,3
.complete 3517,4
step
#requires nagasrune
.goto Azshara,45.55,37.79,50,0
.goto Azshara,53.45,21.82
>> Run up the ramp north out of the shore part of Azshara. Run back to Kim'jael
.target Kim'jael
>>Talk to |cRXP_FRIENDLY_Kim'jael|r
.turnin 5534 >> Turn in Kim'jael's "Missing" Equipment
step
.goto Azshara,22.60,51.40
>> Skip the other quest for now
>>Talk to |cRXP_FRIENDLY_Jediga|r
.turnin 3517 >> Turn in Stealing Knowledge
.target Jediga
.accept 3561 >> Accept Delivery to Archmage Xylem
.accept 3518 >> Accept Delivery to Magatha
.accept 3541 >> Accept Delivery to Jes'rimon
step
.isQuestTurnedIn 3505
.goto Azshara,22.3,51.5
>>Talk to |cRXP_FRIENDLY_Ag'tor Bloodfist|r
.turnin 3506 >>Turn in Betrayed
.target Ag'tor Bloodfist
.accept 3507 >>Accept Betrayed
step
.goto Azshara,28.1,50.0
.target Sanath Lim-yo
>>Talk to |cRXP_FRIENDLY_Sanath Lim-yo|r
.turnin 3503 >>Turn in Meeting with the Master
step
.goto Azshara,29.7,40.4
>>Talk to |cRXP_FRIENDLY_Archmage Xylem|r
.turnin 3561 >>Turn in Delivery to Archmage Xylem
.target Archmage Xylem
.accept 3565 >>Accept Xylem's Payment to Jediga
step
.goto Azshara,26.5,46.3
.target Nyrill
>>Talk to |cRXP_FRIENDLY_Nyrill|r
.turnin 3421 >>Turn in Return Trip
step
.goto Azshara,22.5,51.5
.target Jediga
>>Talk to |cRXP_FRIENDLY_Jediga|r
.turnin 3565 >>Turn in Xylem's Payment to Jediga
step
.goto Azshara,22.0,49.6
.fly Splintertree Post >>Fly to Splintertree Post
step
#label azharaskip
.goto Ashenvale,55.78,28.12
.zone Felwood >> Travel to Felwood
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 50-60
#classic
<< Horde
#name 53-53 Felwood
#next 53-54 Un'Goro Crater
step
#completewith next
#sticky
.abandon 3504
step
.goto Felwood,51.00,85.00
.target Grazle
>>Talk to |cRXP_FRIENDLY_Grazle|r
.accept 8460 >> Accept Timbermaw Ally
step
.goto Felwood,50.90,81.70
.target Taronn Redfeather
>>Talk to |cRXP_FRIENDLY_Taronn Redfeather|r
.accept 5156 >> Accept Verifying the Corruption
step
.goto Felwood,51.20,82.10
.target Greta Mosshoof
>>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r
.accept 5155 >> Accept Forces of Jaedenar
step
.goto Felwood,46.70,83.30
.target Maybess Riverbreeze
>>Talk to |cRXP_FRIENDLY_Maybess Riverbreeze|r
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
.target Dreka'Sur
>>Talk to |cRXP_FRIENDLY_Dreka'Sur|r
.accept 6162 >> Accept A Husband's Last Battle
step
.goto Felwood,34.20,52.30
.target Winna Hazzard
>>Talk to |cRXP_FRIENDLY_Winna Hazzard|r
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
>>Talk to |cRXP_FRIENDLY_Grazle|r
.turnin 8460 >> Turn in Timbermaw Ally
.target Grazle
.accept 8462 >> Accept Speak to Nafien
step
.goto Felwood,51.20,82.20
>>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r
.turnin 5155 >> Turn in Forces of Jaedenar
.target Greta Mosshoof
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
.complete 5156,1 
step
.goto Felwood,40.87,42.03,90,0
.goto Felwood,46.03,38.06
>> Kill Entropic Beasts and Horrors in the area.
>> If you can't find Horrors and can only find Beasts, kill some Beasts to force respawns on the Horrors
.complete 5156,2
.complete 5156,3
.unitscan Entropic Horror
step
#era/som
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
#era/som
.goto Felwood,53.75,28.06,90,0
.goto Felwood,58.03,17.83,90,0
.goto Felwood,63.27,19.15
>> Finish killing Angerclaw Grizzlys and Felpaw Ravagers
.complete 4120,1
.complete 4120,2
step
.goto Felwood,64.70,8.20
.target Nafien
>>Talk to |cRXP_FRIENDLY_Nafien|r
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
.target Donova Snowden
>>Talk to |cRXP_FRIENDLY_Donova Snowden|r
.accept 5082 >> Accept Threat of the Winterfall
step
.goto Winterspring,31.30,45.10
.target Donova Snowden
>>Talk to |cRXP_FRIENDLY_Donova Snowden|r
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
>>Talk to |cRXP_FRIENDLY_Donova Snowden|r
.turnin 5082 >> Turn in Threat of the Winterfall
.turnin 5083 >> Turn in Winterfall Firewater
.target Donova Snowden
.accept 5084 >> Accept Falling to Corruption
.accept 3909 >> Accept The Videre Elixir
step
#softcore
#completewith next
.deathskip >> Die and respawn at the Spirit Healer
step
.goto Winterspring,61.60,38.60
.target Felnok Steelspring
>>Talk to |cRXP_FRIENDLY_Felnok Steelspring|r
.turnin 4808 >> Turn in Felnok Steelspring
step
.goto Winterspring,60.47,36.30
.fp Everlook >> Get the Everlook Flight Path
.fly Felwood >> Fly to Felwood
step
.goto Felwood,34.20,52.30
.target Winna Hazzard
>>Talk to |cRXP_FRIENDLY_Winna Hazzard|r
.turnin 4505 >> Turn in Well of Corruption
step
.goto Felwood,34.80,52.70
.target Dreka'Sur
>>Talk to |cRXP_FRIENDLY_Dreka'Sur|r
.turnin 6162 >> Turn in A Husband's Last Battle
step
#softcore
#completewith next
.goto Felwood,41.30,67.10
>> Head towards the slime pond south of Jaedenar. Die and respawn at the Spirit Healer in Southern Felwood
step
.goto Felwood,46.60,83.00
.target Maybess Riverbreeze
>>Talk to |cRXP_FRIENDLY_Maybess Riverbreeze|r
.turnin 4102 >> Turn in Cleansing Felwood
>> Ask Arathandris for a Cenarion Beacon
.collect 11511,1
step
.goto Felwood,51.20,82.10
>>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r
.turnin 5157 >> Turn in Collection of the Corrupt Water
.target Greta Mosshoof
.accept 5158 >> Accept Seeking Spiritual Aid
step
.goto Felwood,50.90,81.70
.target Taronn Redfeather
>>Talk to |cRXP_FRIENDLY_Taronn Redfeather|r
.turnin 5156 >> Turn in Verifying the Corruption
step
.hs >> Hearth to Orgrimmar
>> Buy food/water if needed
step
#softcore
.goto Orgrimmar,55.55,64.74
>>Go to the Auction House. Buy a Mithril Casing for later if there's one available
.collect 10561,1 
step
.isOnQuest 3541
.goto Orgrimmar,55.52,34.07
>>Talk to |cRXP_FRIENDLY_Jes'rimon|r
.turnin 3541 >> Turn in Delivery to Jes'rimon
.target Jes'rimon
.accept 3563 >> Accept Jes'rimon's Payment to Jediga
step
.isOnQuest 3507
.goto Orgrimmar,75.20,34.00
.target Belgrom Rockmaul
>>Talk to |cRXP_FRIENDLY_Belgrom Rockmaul|r
.turnin 3507 >> Turn in Betrayed
step
.goto Orgrimmar,45.11,63.89
.fly Camp Taurajo >> Fly to Camp Taurajo
step
.goto The Barrens,45.6,59.0
.home >> Set your Hearthstone to Camp Taurajo
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 50-60
#classic
<< Horde
#name 53-54 Un'Goro Crater
#next 54-56 Felwood/Winterspring
step
.goto The Barrens,44.45,59.15
.fly Tanaris >> Fly to Tanaris
step
.goto Tanaris,50.90,27.00
>>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r
.turnin 4494 >> Turn in March of the Silithid
.target Alchemist Pestlezugg
.accept 4496 >> Accept Bungle in the Jungle
step
.goto Tanaris,51.60,25.50
.fly Un'Goro Crater>> Fly to Un'Goro Crater
step
.goto Tanaris,12.70,5.90
.target Williden Marshal
>>Talk to |cRXP_FRIENDLY_Williden Marshal|r
.accept 3881 >> Accept Expedition Salvation
.target Hol'anyee Marshal
>>Talk to |cRXP_FRIENDLY_Hol'anyee Marshal|r
.accept 3883 >> Accept Alien Ecology
step
.goto Tanaris,12.50,6.00
.target Spark Nilminer
>>Talk to |cRXP_FRIENDLY_Spark Nilminer|r
.accept 3882 >> Accept Roll the Bones
step
>>Go into the cave
.goto Un'Goro Crater,43.16,6.24,30,0
.goto Un'Goro Crater,41.90,2.70
.target J.D. Collie
>>Talk to |cRXP_FRIENDLY_J.D. Collie|r
.accept 4288 >> Accept The Western Pylon
.accept 4285 >> Accept The Northern Pylon
.accept 4287 >> Accept The Eastern Pylon
step
.goto Tanaris,12.50,6.50
.target Spraggle Frock
>>Talk to |cRXP_FRIENDLY_Spraggle Frock|r
.accept 4492 >> Accept Lost!
.accept 4501 >> Accept Beware of Pterrordax
step
.goto Un'Goro Crater,45.53,8.72
.target Larion
>>Talk to |cRXP_FRIENDLY_Larion|r
.accept 4145 >> Accept Larion and Muigin
step
.goto Tanaris,12.80,8.10
.target Shizzle
>>Talk to |cRXP_FRIENDLY_Shizzle|r
.accept 4503 >> Accept Shizzle's Flyer
step
#completewith Mighty
>>Collect Un'Goro Soil from mobs as you quest through the zone
.collect 11018,25 
step
#completewith next
>>Loot the Pterrordax you kill for their scales. You'll finish this later
.complete 4503,2 
step
#completewith Gorillaz
>> Kill some of the Pterrordax found north of the Northern Pylon
.complete 4501,1 
step
.isOnQuest 4285
>>Interact with the Pylon
.goto Un'Goro Crater,56.6,12.6
.complete 4285,1 
step
#label Gorillaz
.goto Un'Goro Crater,62.97,17.39,150 >> Travel to Fungal Rock
step
.goto Un'Goro Crater,63.3,16.8
>>Kill the Gorrilas inside and outside the cave. Loot them for their pelts
>>Be careful as the normal Gorillas call for help in a 90 yard range, and the Thunderers have a high-damage, instant shock spell
.complete 4289,2 
.complete 4289,3 
.complete 4289,1 
step
#completewith Ucha
.goto Un'Goro Crater,65.02,35.93,0
>>Kill the Young Diemetradons that you see. Loot them for Bones and Scales
.complete 3882,1 
.complete 4503,1 
step
.goto Un'Goro Crater,57.6,20.7
>>Kill Bloodpetal Flayers. Be careful of their Poison as it deals a lot of damage << Warrior/Rogue
>>Kill Bloodpetal Flayers. Be careful of their Poison as it deals a lot of damage, and drains a lot of mana << !Warrior !Rogue
.complete 4145,3 
step
>>Loot the Crate on the ground
.goto Un'Goro Crater,68.4,36.5
.complete 3881,1 
step
.goto Un'Goro Crater,69.2,36.9
>>Kill Bloodpetal Threshers and Lashers. Be careful of their Poison as it deals a lot of damage, and Lashers can disarm you << Warrior/Rogue/Shaman
>>Kill Bloodpetal Threshers and Lashers. Be careful of their Poison as it deals a lot of damage, and drains a lot of mana << !Warrior !Rogue !Shaman
.complete 4145,4 
.complete 4145,1 
step
.isOnQuest 4287
>>Interact with the Pylon
.goto Un'Goro Crater,77.3,50.0
.complete 4287,1 
step
>> Open Torwa's Pouch. Place the Threshadon Meat on the flat rock, then apply the Pheromone Mixture on it
>> KIll Lar'korwi once he's summoned. Loot his head
.goto Un'Goro Crater,79.94,49.88
.complete 4292,1 
step
#label Ucha
.goto Un'Goro Crater,71.6,75.9
>>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r
.turnin 4292 >> Turn in The Bait for Lar'korwi
.turnin 4289 >> Turn in The Apes of Un'Goro
.target Torwa Pathfinder
.accept 4301 >> Accept The Mighty U'cha
step
.isOnQuest 4300
.goto Un'Goro Crater,68.6,46.4
>> Kill Raptors. Loot them for Ravasaur Claws
.complete 4300,1
step
#completewith next
.goto Un'Goro Crater,50.59,77.06,0
>>Kill Silithid mobs in the area. Loot them for the Scent Gland
.complete 4496,1 
step
>> Go down into the Silithid cave. Hug the left wall toward the first room
>> Use the Scraping Vial when you're in the middle of the room
.goto Un'Goro Crater,49.97,81.36,40,0
.goto Un'Goro Crater,48.7,85.2
.complete 3883,1 
step
.goto Un'Goro Crater,50.59,77.06
>>Kill Silithid mobs in the area. Loot them for the Scent Gland
.complete 4496,1 
step
#completewith next
.goto Un'Goro Crater,44.11,91.63,0
>>Loot the Pterrordax you kill for their scales. You'll finish this later
.complete 4503,2 
step
>> Kill the rest of the Pterrordax needed in the southern mountains
.goto Un'Goro Crater,50.49,90.54,60,0
.goto Un'Goro Crater,44.11,91.63
.complete 4501,1 
.unitscan Pterrordax
step
#completewith Springs
.goto Un'Goro Crater,36.76,35.47,0
>>Kill Bloodpetal Trappers that you see
.complete 4145,2 
step
#completewith Springs
.goto Un'Goro Crater,50.5,65.2,0
>>Kill Diemetradons that you see. Loot them for Bones and Scales
.complete 3882,1 
.complete 4503,1 
step
.goto Un'Goro Crater,38.6,66.1
>>Loot the boxes on the ground
.complete 3881,2 
step
>>Interact with the Pylon
.goto Un'Goro Crater,23.87,59.21
.complete 4288,1 
step
#completewith Springs
.goto Un'Goro Crater,20.95,59.45,80,0
.goto Un'Goro Crater,36.76,35.47,0
>>Kill Frenzied Pterrordax. Loot them for their scales
.complete 4501,2 
.complete 4503,2 
step
.goto Un'Goro Crater,30.9,50.2
.target Krakle
>>Talk to |cRXP_FRIENDLY_Krakle|r
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
.complete 974,1 
step
#label Springs
>>Travel back to Krackle
.goto Un'Goro Crater,30.9,50.5
>>Talk to |cRXP_FRIENDLY_Krakle|r
.turnin 974 >> Turn in Finding the Source
.target Krakle
.accept 980 >> Accept The New Springs
step
#completewith PterrordaxAndys
.goto Un'Goro Crater,35.49,43.91,0
>>Kill Diemetradons that you see. Loot them for Bones and Scales
.complete 3882,1 
.complete 4503,1 
step
#completewith next
.goto Un'Goro Crater,20.95,59.45,80,0
.goto Un'Goro Crater,36.76,35.47,0
>>Kill Frenzied Pterrordax. Loot them for their scales
.complete 4501,2 
.complete 4503,2 
step
.goto Un'Goro Crater,35.49,43.91
>>Kill Bloodpetal Trappers that you see
.complete 4145,2 
step
#label PterrordaxAndys
.goto Un'Goro Crater,28.23,30.76
>>Kill Frenzied Pterrordax. Loot them for their scales
.complete 4501,2 
.complete 4503,2 
step
.goto Un'Goro Crater,40.94,41.57
>>Kill Diemetradons that you see. Loot them for Bones and Scales
.complete 3882,1 
.complete 4503,1 
step
>>Return to the Volcano. Kill and loot Elementals for Un'Goro Ash
.goto Un'Goro Crater,53.4,50.9
.complete 4502,1 
step
>>Ride toward the east side of the volcano. Go into the cave
.goto Un'Goro Crater,51.904,49.845
>>Talk to |cRXP_FRIENDLY_Ringo|r
.turnin 4492 >> Turn in Lost!
.target Ringo
.accept 4491 >> Accept A Little Help From My Friends
step
.goto Un'Goro Crater,43.617,8.497
>> For this escort quest, remember to use the Canteen in your bags to wake him up when he stops moving. Be careful not to ride away too fast from Ringo
.complete 4491,1 
step
.goto Un'Goro Crater,43.617,8.497
.target Spraggle Frock
>>Talk to |cRXP_FRIENDLY_Spraggle Frock|r
.turnin 4501 >> Turn in Beware of Pterrordax
step
.goto Un'Goro Crater,44.2,11.4
.target Shizzle
>>Talk to |cRXP_FRIENDLY_Shizzle|r
.turnin 4503 >> Turn in Shizzle's Flyer
step
.goto Un'Goro Crater,43.889,7.239
.target Hol'anyee Marshal
>>Talk to |cRXP_FRIENDLY_Hol'anyee Marshal|r
.turnin 3883 >> Turn in Alien Ecology
.target Williden Marshal
>>Talk to |cRXP_FRIENDLY_Williden Marshal|r
.turnin 3881 >> Turn in Expedition Salvation
step
>>Go into the cave
.goto Un'Goro Crater,43.16,6.24,30,0
.goto Un'Goro Crater,41.9,2.6
>>Talk to |cRXP_FRIENDLY_J.D. Collie|r
.turnin 4288 >> Turn in The Western Pylon
.turnin 4285 >> Turn in The Northern Pylon
.turnin 4287 >> Turn in The Eastern Pylon
.target J.D. Collie
.accept 4321 >> Accept Making Sense of It
.turnin 4321 >> Turn in Making Sense of It
step
.goto Un'Goro Crater,43.5,7.5
.target Spark Nilminer
>>Talk to |cRXP_FRIENDLY_Spark Nilminer|r
.turnin 3882 >> Turn in Roll the Bones
step
.goto Un'Goro Crater,43.6,8.4
.target Spraggle Frock
>>Talk to |cRXP_FRIENDLY_Spraggle Frock|r
.turnin 4491 >> Turn in A Little Help From My Friends
step
.goto Un'Goro Crater,45.5,8.7
>>Talk to |cRXP_FRIENDLY_Larion|r
.turnin 4145 >> Turn in Larion and Muigin
.target Larion
.accept 4147 >> Accept Marvon's Workshop
step
.goto Un'Goro Crater,46.1,13.5
.target Karna Remtravel
>>Talk to |cRXP_FRIENDLY_Karna Remtravel|r
.accept 4243 >> Accept Chasing A-Me 01
step
.isOnQuest 4285
>>Interact with the Pylon
.goto Un'Goro Crater,56.6,12.6
.complete 4285,1 
step
>>Travel back to the Gorilla cave. Hug the right wall when you enter the cave
.goto Un'Goro Crater,64.17,16.43,40,0
.goto Un'Goro Crater,67.6,16.8
.target A-Me 01
>>Talk to |cRXP_FRIENDLY_A-Me 01|r
.turnin 4243 >> Turn in Chasing A-Me 01
step
>>Run to the back of the cave. Kill U'cha. Loot him for his pelt
.goto Un'Goro Crater,68.0,13.2
.complete 4301,1 
step
#softcore
>>If you got a Mithril Casing from the Auction House earlier, turn in the quests at A-Me 01
>>If you didn't get a Mithril Casing, skip this step
.goto Un'Goro Crater,67.67,16.75
.target A-Me 01
>>Talk to |cRXP_FRIENDLY_A-Me 01|r
.accept 4244 >> Accept Chasing A-Me 01
.turnin 4244 >> Turn in Chasing A-Me 01
.accept 4245 >> Accept Chasing A-Me 01
step
#softcore
.isOnQuest 4245
>>Escort A-Me back to the outside of Marshal's Refuge
.goto Un'Goro Crater,46.37,13.43
.complete 4245,1 
step
#softcore
.isOnQuest 4245
.goto Un'Goro Crater,46.37,13.43
.target Karna Remtravel
>>Talk to |cRXP_FRIENDLY_Karna Remtravel|r
.turnin 4245 >>Turn in Chasing A-Me 01
step
.isOnQuest 4287
>>Interact with the Pylon
.goto Un'Goro Crater,77.3,50.0
.complete 4287,1 
step
#label Mighty
.goto Un'Goro Crater,71.6,76.0
.target Torwa Pathfinder
>>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r
.turnin 4301 >> Turn in The Mighty U'cha
step
>>Collect Un'Goro Soil from mobs or soil patches
.collect 11018,25 
step
#hardcore
>>Run back to Marshal's Refuge
.goto Un'Goro Crater,43.16,6.24,30,0
.goto Un'Goro Crater,41.9,2.6
>>Talk to |cRXP_FRIENDLY_J.D. Collie|r
.turnin 4285 >> Turn in The Northern Pylon
.turnin 4287 >> Turn in The Eastern Pylon
.target J.D. Collie
.accept 4321 >> Accept Making Sense of It
.turnin 4321 >> Turn in Making Sense of It
step
#hardcore
.fly Tanaris >> Fly to Tanaris
step
#completewith next
#softcore
.goto Tanaris,27.06,56.58
.zone Tanaris >> Travel back up to Tanaris
step
#completewith next
#softcore
.goto Tanaris,27.89,59.02
.deathskip >> Die and respawn at the Spirit Healer in Gadgetzan
step
.goto Tanaris,50.90,27.00
.target Alchemist Pestlezugg
>>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r
.turnin 4496 >> Turn in Bungle in the Jungle
step
.goto Tanaris,51.60,25.50
.fly Feralas>> Fly to Feralas
step
#era/som
.goto Feralas,76.18,43.83
.target Talo Thornhoof
>>Talk to |cRXP_FRIENDLY_Talo Thornhoof|r
.turnin 4120 >> Turn in The Strength of Corruption
step
>>Travel to Dire Maul
.goto Feralas,60.07,47.44,50,0
.goto Feralas,59.59,43.45,10 >> Hug the wall outside of Dire Maul. Make sure your general chat changes to "Dire Maul". This is to unlock a quest later
step
.goto Feralas,50.76,49.83,60,0
.goto Feralas,45.12,25.56
>> Buy some bait from Gregan
.collect 11141,1,3909,1
step
.goto Feralas,44.60,10.19
>> Give some bait to Miblion who's guarding the Evoroot. Loot the Evoroot in the Ruins
.collect 11242,1,3909,1
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
.target Bluff Runner Windstrider
>>Talk to |cRXP_FRIENDLY_Bluff Runner Windstrider|r
.accept 1000 >> Accept The New Frontier
.accept 5095 >> Accept A Call to Arms: The Plaguelands!
.unitscan Bluff Runner Windstrider
step
.goto Thunder Bluff,45.80,64.70
.target Innkeeper Pala
>>Talk to |cRXP_FRIENDLY_Innkeeper Pala|r
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
.goto Thunder Bluff,22.813,20.893
.trainer >> Go and train your class spells
step << Priest
.goto Thunder Bluff,24.6,22.6
.trainer >> Go and train your class spells
step
.goto Thunder Bluff,78.50,28.60
>>Talk to |cRXP_FRIENDLY_Arch Druid Hamuul Runetotem|r
.turnin 1000 >> Turn in The New Frontier
.target Arch Druid Hamuul Runetotem
.accept 1123 >> Accept Rabine Saturna
.turnin 3762 >> Turn in Assisting Arch Druid Runetotem
.accept 3761 >> Accept Un'Goro Soil
step
.goto Thunder Bluff,77.30,22.20
.target Ghede
>>Talk to |cRXP_FRIENDLY_Ghede|r
.turnin 3761 >> Turn in Un'Goro Soil
step
.goto Thunder Bluff,78.40,28.80
.target Arch Druid Hamuul Runetotem
>>Talk to |cRXP_FRIENDLY_Arch Druid Hamuul Runetotem|r
.accept 3782 >> Accept Morrowgrain Research
step
.isOnQuest 3518
.goto Thunder Bluff,70.20,30.70
.target Magatha Grimtotem
>>Talk to |cRXP_FRIENDLY_Magatha Grimtotem|r
.turnin 3518 >> Turn in Delivery to Magatha
step
.isQuestTurnedIn 3518
.goto Thunder Bluff,70.20,30.70
.target Magatha Grimtotem
>>Talk to |cRXP_FRIENDLY_Magatha Grimtotem|r
.accept 3562 >> Accept Magatha's Payment to Jediga
step
.goto Thunder Bluff,71.00,33.80
.target Bashana Runetotem
>>Talk to |cRXP_FRIENDLY_Bashana Runetotem|r
.turnin 3782 >> Turn in Morrowgrain Research
step
#requires BluffRunner
.goto Thunder Bluff,46.8,50.0
.fly Ratchet>> Fly to Ratchet
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 50-60
#classic
<< Horde
#name 54-56 Felwood/Winterspring
#next 56-58 Western PL/Eastern PL
step
.goto The Barrens,62.50,38.70
.target Liv Rizzlefix
>>Talk to |cRXP_FRIENDLY_Liv Rizzlefix|r
.turnin 4502 >> Turn in Volcanic Activity
step
.goto The Barrens,62.50,38.70
.target Liv Rizzlefix
>>Talk to |cRXP_FRIENDLY_Liv Rizzlefix|r
.turnin 4147 >> Turn in Marvon's Workshop
step
.goto The Barrens,65.80,43.80
>>Talk to |cRXP_FRIENDLY_Islen Waterseer|r
.turnin 5158 >> Turn in Seeking Spiritual Aid
.target Islen Waterseer
.accept 5159 >> Accept Cleansed Water Returns to Felwood
step
.isOnQuest 3562
.goto The Barrens,63.1,37.1
.fly Azshara>> Fly to Azshara
step
.isOnQuest 3562
.goto Azshara,22.50,51.40
.target Jediga
>>Talk to |cRXP_FRIENDLY_Jediga|r
.turnin 3562 >> Turn in Magatha's Payment to Jediga
step
.goto Azshara,22.50,51.40
.isOnQuest 3563
.target Jediga
>>Talk to |cRXP_FRIENDLY_Jediga|r
.turnin 3563 >> Turn in Jes'rimon's Payment to Jediga
step
.goto Azshara,22.50,51.40
.target Jediga
>>Talk to |cRXP_FRIENDLY_Jediga|r
.accept 3542 >> Accept Delivery to Andron Gant
.isQuestTurnedIn 3562
step

.fly Felwood>> Fly to Felwood
step
.goto Felwood,34.30,52.30
.target Winna Hazzard
>>Talk to |cRXP_FRIENDLY_Winna Hazzard|r
.accept 4506 >> Accept Corrupted Sabers
step
#era/som
.goto Felwood,34.80,52.80
.target Trull Failbane
>>Talk to |cRXP_FRIENDLY_Trull Failbane|r
.accept 4521 >> Accept Wild Guardians
step
#sticky
#label SoulShards
>> Collect 6 Corrupted Soul Shards from mobs you kill and loot with the Beacon in your inventory
.collect 11515,6
step
.goto Felwood,51.20,82.10
>>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r
.turnin 5159 >> Turn in Cleansed Water Returns to Felwood
.target Greta Mosshoof
.accept 5165 >> Accept Dousing the Flames of Protection
step
.goto Felwood,36.02,66.99,70,0
.goto Felwood,32.40,66.60
.cast 15647 >> Use Winna's Kitten Carrier at the corrupted moonwell


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
>>Talk to |cRXP_FRIENDLY_Captured Arko'narin|r
.turnin 5202 >>Turn in A Strange Red Key
.target Captured Arko'narin
.accept 5203 >>Accept Rescue From Jaedenar
step
#sticky
#label Arko
#requires StrangeRed2
>>Protect Arko'narin as you extinguish the Braziers within Shadow Hold. U need to do this WHILE u do the escort. Don't forget or u have to walk back in.
>>Be careful as this quest can be HARD. 3 Felguards will spawn after Arko'narin equips her armor (use short <3 minute cooldowns). Let Arko'narin tank one, she has 6k hp.
>>An elite will spawn at the end once Arko'narin leaves the cave. Be careful as he has a 500 damage instant shock spell
.complete 5203,1 
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
.target Winna Hazzard
>>Talk to |cRXP_FRIENDLY_Winna Hazzard|r
.turnin 4506 >> Turn in Corrupted Sabers
step
>>Travel up to northern Felwood
.goto Felwood,64.70,8.10
.target Nafien
>>Talk to |cRXP_FRIENDLY_Nafien|r
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
>>Talk to |cRXP_FRIENDLY_Nafien|r
.turnin 8461 >> Turn in Deadwood of the North
.target Nafien
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
.target Salfa
>>Talk to |cRXP_FRIENDLY_Salfa|r
.turnin 8465 >> Turn in Speak to Salfa

step
#softcore
.goto Winterspring,31.30,45.10
>>Talk to |cRXP_FRIENDLY_Donova Snowden|r
.turnin 980 >> Turn in The New Springs
.target Donova Snowden
.accept 4842 >> Accept Strange Sources
.turnin 3909 >> Turn in The Videre Elixir
.accept 3912 >> Accept Meet at the Grave
.turnin 5085 >> Turn in Mystery Goo
.accept 5086 >> Accept Toxic Horrors
step
#hardcore
.goto Winterspring,31.30,45.10
>>Talk to |cRXP_FRIENDLY_Donova Snowden|r
.turnin 980 >> Turn in The New Springs
.target Donova Snowden
.accept 4842 >> Accept Strange Sources
.turnin 3909 >> Turn in The Videre Elixir
.turnin 5085 >> Turn in Mystery Goo
.accept 5086 >> Accept Toxic Horrors
step
#era/som
#completewith Ursius
.goto Winterspring,44.98,37.83,0
>> Kill Ragged Owlbeasts en route to Everlook
.complete 4521,2
step
>>Run to Everlook
.goto Winterspring,61.2,38.8
.home >> Set your Hearthstone to Everlook
step
#era/som
.goto Winterspring,60.88,37.61
.target Umi Rumplesnicker
>>Talk to |cRXP_FRIENDLY_Umi Rumplesnicker|r
.accept 3783 >> Accept Are We There, Yeti?
step
#label Ursius
.goto Winterspring,61.93,38.37
.target Storm Shadowhoof
>>Talk to |cRXP_FRIENDLY_Storm Shadowhoof|r
.accept 5054 >> Accept Ursius of the Shardtooth
step
#era/som
.goto Winterspring,44.98,37.83
>> Kill Ragged Owlbeasts west of Everlook
.complete 4521,2
step
#era/som
#completewith ROwlbeasts
.goto Winterspring,58.22,33.79,0
>>Kill Yetis. Loot them for their Fur
.complete 3783,1
step
#era/som
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
#era/som
#label ROwlbeasts
.goto Winterspring,60.67,29.81,60,0
.goto Winterspring,58.64,34.51
>>Kill Raging Owlbeasts
.complete 4521,1
step
#era/som
.goto Winterspring,65.97,41.47
>>Kill Yetis. Loot them for their Fur
.complete 3783,1
step << Shaman
.hs >> Hearth to Everlook
>> Buy food/water if needed
step
.goto Winterspring,61.90,38.40
>>Talk to |cRXP_FRIENDLY_Storm Shadowhoof|r
.turnin 5054 >> Turn in Ursius of the Shardtooth
.target Storm Shadowhoof
.accept 5055 >> Accept Brumeran of the Chillwind
.target Witch Doctor Mau'ari
>>Talk to |cRXP_FRIENDLY_Witch Doctor Mau'ari|r

.accept 969 >> Accept Luck Be With You << Hunter
step
#era/som
.goto Winterspring,60.88,37.61
.target Umi Rumplesnicker
>>Talk to |cRXP_FRIENDLY_Umi Rumplesnicker|r
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
.complete 4842,1 
step << Hunter
.goto Winterspring,60.43,65.31
>> Loot the blue crystals around the outer perimeter of the canyon, use your pet to bait the giants away from the crystals. Run away after looting one
>>This is a hard quest to solo, skip this quest if you have to
.complete 969,1
.link https://www.twitch.tv/videos/850027450?t=00h26m14s >> Click here for video reference
step
#era/som
#softcore
#completewith next
.deathskip >> Once you finish all quests, die on purpose and respawn at Everlook
step
#som
#phase 3-6
#softcore
#requires brumeran2
.hs >> Hearth to Everlook
>> Buy food/water if needed
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
.target Witch Doctor Mau'ari
>>Talk to |cRXP_FRIENDLY_Witch Doctor Mau'ari|r

.turnin 969 >> Turn in Luck Be With You
.isQuestComplete 969
step
.goto Winterspring,61.90,38.40
.target Storm Shadowhoof
>>Talk to |cRXP_FRIENDLY_Storm Shadowhoof|r
.turnin 5055 >> Turn in Brumeran of the Chillwind
.isQuestComplete 5055
step
#era/som
#softcore
.goto Winterspring,60.47,36.30
.fly Tanaris>> Fly to Tanaris
step
#era/som
#softcore
.goto Tanaris,53.90,23.40
>> Use the Videre Elixir at the Tanaris Graveyard
>>Talk to |cRXP_FRIENDLY_Gaeriyan|r
.turnin 3912 >> Turn in Meet at the Grave
.target Gaeriyan
.accept 3913 >> Accept A Grave Situation
step
#era/som
#softcore
.goto Tanaris,53.80,29.10
.turnin 3913 >> Turn in A Grave Situation
.accept 3914 >> Accept Linken's Sword
step
#era/som
#softcore
.goto Tanaris,51.60,25.50
.fly Un'Goro Crater>> Fly to Un'Goro Crater
step
#era/som
#softcore
.goto Tanaris,13.10,6.40
>>Talk to |cRXP_FRIENDLY_Linken|r
.turnin 3914 >> Turn in Linken's Sword
.target Linken
.accept 3941 >> Accept A Gnome's Assistance
step
#era/som
#softcore
.goto Tanaris,11.60,3.40
>>Talk to |cRXP_FRIENDLY_J.D. Collie|r
.turnin 3941 >> Turn in A Gnome's Assistance
.target J.D. Collie
.accept 3942 >> Accept Linken's Memory
step
#era/som
#softcore
#completewith next
.hs >> Hearth to Winterspring
>> Buy food/water if needed
step
.goto Winterspring,61.34,38.97
.target Gregor Greystone
>>Talk to |cRXP_FRIENDLY_Gregor Greystone|r
.accept 6029 >> Accept The Everlook Report
.accept 6030 >> Accept Duke Nicholas Zverenhoff
step
.goto Winterspring,60.47,36.30
.fly Felwood>> Fly to Felwood
step
#era/som
.goto Felwood,34.70,52.70
>>Talk to |cRXP_FRIENDLY_Trull Failbane|r
.turnin 4521 >> Turn in Wild Guardians
.target Trull Failbane
.accept 4741 >> Accept Wild Guardians
step
.goto Felwood,51.20,82.10
>>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r
.turnin 5165 >> Turn in Dousing the Flames of Protection
.target Greta Mosshoof
.accept 5242 >> Accept A Final Blow
step
.goto Felwood,51.30,82.00
>>Talk to |cRXP_FRIENDLY_Jessir Moonbow|r
.turnin 5203 >> Turn in Rescue From Jaedenar
.target Jessir Moonbow
.accept 5204 >> Accept Retribution of the Light
step
#era/som
#softcore
.goto Felwood,51.30,81.50
>>Talk to |cRXP_FRIENDLY_Eridan Bluewind|r
.turnin 3942 >> Turn in Linken's Memory
.target Eridan Bluewind
.accept 4084 >> Accept Silver Heart
step
#era/som
#label wolvesbears
#completewith next
>> Kill Wolves/Bears. Loot them for their claws
.complete 4084,1
step
#completewith next
.goto Felwood,38.47,59.51,50 >> Run to Jaedenar (Shadow Hold)
step
.goto Felwood,35.39,58.74,30,0
.goto Felwood,38.30,50.50
>> Go deep into Shadow Hold. Kill Rakaiah
.complete 5204,1
step
.goto Felwood,38.50,50.40
>> Be careful when clearing mobs around the corpse, as they can bug by keeping you in combat, but not attacking you
>>Talk to |cRXP_FRIENDLY_Remains of Trey Lightforge|r
.turnin 5204 >> Turn in Retribution of the Light
.target Remains of Trey Lightforge
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
step
#era/som
.goto Felwood,51.90,21.80
>> Kill Treants. Loot them for the Irontree Heart
.complete 4084,2
step
.goto Winterspring,12.41,50.58
>> Kill Toxic Horrors. Loot them for their Droplets
.complete 5086,1
step
#era/som
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
>>Talk to |cRXP_FRIENDLY_Donova Snowden|r
.turnin 4842 >> Turn in Strange Sources
.turnin 5086 >> Turn in Toxic Horrors
.target Donova Snowden
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
>>Talk to |cRXP_FRIENDLY_Donova Snowden|r
.turnin 5087 >> Turn in Winterfall Runners
.target Donova Snowden
.accept 5121 >> Accept High Chief Winterfall
step << !Mage
#softcore
.deathskip >> Die and respawn at the Spirit Healer in Everlook
step << !Mage
#softcore
.goto Winterspring,60.47,36.30
.fly Felwood >> Fly to Felwood
step << !Mage
#hardcore
.goto Moonglade,32.2,66.6
>>Go back to the Furbolg tunnel and take the north exit into Moonglade
.fly Felwood >> Fly to Felwood
step << Mage
#completewith next
>>Teleport to Orgrimmar
.fly Splintertree >> Fly to Splintertree Post in Ashenvale then run up to Felwood
step
>>Run to southern Felwood
.goto Winterspring,13.90,96.10
.target Greta Mosshoof
>>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r
.turnin 5242 >> Turn in A Final Blow
.isQuestComplete 5242
step
.goto Winterspring,14.00,96.00
.target Jessir Moonbow
>>Talk to |cRXP_FRIENDLY_Jessir Moonbow|r
.turnin 5385 >> Turn in The Remains of Trey Lightforge
.isOnQuest 5385
step
#era/som
#softcore
.goto Winterspring,14.00,95.60
.target Eridan Bluewind
>>Talk to |cRXP_FRIENDLY_Eridan Bluewind|r
.turnin 4084 >> Turn in Silver Heart
step << !Mage
#hardcore
.goto Ashenvale,73.2,61.6
>>Head to Splintertree Post
.fly Orgrimmar>> Fly to Orgrimmar
step << !Mage
#softcore
.goto Ashenvale,73.2,61.6
>>Head to Splintertree Post
.fly Orgrimmar>> Fly to Orgrimmar
>>Alternatively, you can use the website unstuck service to teleport to Orgrimmar
.zoneskip Durotar
step << Shaman
.goto Orgrimmar,38.6,36.0
.trainer >> Go and train your class spells
step << Hunter
.goto Orgrimmar,66.046,18.526
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
step << Mage
.zone Undercity >> Teleport to Undercity
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 50-60
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
>>Talk to |cRXP_FRIENDLY_High Executor Derrington|r
.turnin 5095 >>Turn in A Call to Arms: The Plaguelands!
.target High Executor Derrington
.accept 5096 >>Accept Scarlet Diversions
step
.goto Western Plaguelands,26.55,56.18
>>Loot the crate next to the fire
.collect 12814,1 
step
.goto Tirisfal Glades,83.2,68.6
.target Argent Officer Garush
>>Talk to |cRXP_FRIENDLY_Argent Officer Garush|r
.turnin 6029 >>Turn in The Everlook Report
.turnin 5405 >>Turn in Argent Dawn Commission
step
.goto Tirisfal Glades,83.3,72.1
.target Mickey Levine
>>Talk to |cRXP_FRIENDLY_Mickey Levine|r
.accept 5901 >>Accept A Plague Upon Thee
step
>> Be careful as the mobs are relatively difficult, and can chain-pull each other here
>>Burn the command tent down, then use the banner in your inventory on top of it
.goto Western Plaguelands,40.5,51.8
.complete 5096,1 
step
.goto Tirisfal Glades,83.0,69.0
>>Talk to |cRXP_FRIENDLY_High Executor Derrington|r
.turnin 5096 >>Turn in Scarlet Diversions
.target High Executor Derrington
.accept 5098 >>Accept All Along the Watchtowers
.accept 5228 >>Accept The Scourge Cauldrons
step
.goto Tirisfal Glades,83.0,71.9
>>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r
.turnin 5228 >>Turn in The Scourge Cauldrons
.target Shadow Priestess Vandis
.accept 5229 >>Accept Target: Felstone Field
step
>>Kill Cauldron Lord Bilemaw. Loot him for the key
.goto Western Plaguelands,37.12,57.18
.complete 5229,1 
.unitscan Cauldron Lord Bilemaw
step
.goto Western Plaguelands,37.2,56.8
.turnin 5229 >>Turn in Target: Felstone Field
.accept 5230 >>Accept Return to the Bulwark
step
>>Second floor of the house
.goto Western Plaguelands,38.3,54.1
.target Janice Felstone
>>Talk to |cRXP_FRIENDLY_Janice Felstone|r
.accept 5021 >>Accept Better Late Than Never
step
>>Loot the parcel in the barn
.goto Western Plaguelands,38.8,55.3
.turnin 5021 >>Turn in Better Late Than Never
.accept 5023 >>Accept Better Late Than Never
step
>>Run back to The Bulwark
.goto Tirisfal Glades,83.0,72.0
>>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r
.turnin 5230 >>Turn in Return to the Bulwark
.target Shadow Priestess Vandis
.accept 5231 >>Accept Target: Dalson's Tears
step
>>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
.goto Western Plaguelands,42.28,66.05
.complete 5098,2 
step
>>Kill Cauldron Lord Malvinous. Loot him for the key
.goto Western Plaguelands,46.04,52.33
.complete 5231,1 
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
.collect 12739,1,5060 
step
.goto Western Plaguelands,47.4,49.7
>>Click on the cabinet at the top floor of the farmhouse
.turnin 5060 >> Turn in Locked Away
step
>>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
.goto Western Plaguelands,40.15,71.50
.complete 5098,1 
step
>>Go to the top floor of the Inn. Talk to Chromie
.goto Western Plaguelands,39.4,66.9
.target Chromie
>>Talk to |cRXP_FRIENDLY_Chromie|r
.accept 4971 >>Accept A Matter of Time
step
>>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
.goto Western Plaguelands,44.24,63.06
.complete 5098,3 
step
.goto Western Plaguelands,45.8,63.3
>>Use the Temporal Displacer near the blue-glowing silos of Andorhal to spawn the parasites.
>>Be careful as the Parasites can spawn up to 3 at once, and have a 50% chance of respawning when killed. They also cast Slow
>>They are evadeable in the water near Andorhal
.complete 4971,1 
step
>>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
.goto Western Plaguelands,46.73,71.14
.complete 5098,4 
step
.goto Tirisfal Glades,83.0,71.9
>>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r
.turnin 5232 >>Turn in Return to the Bulwark
.target Shadow Priestess Vandis
.accept 5233 >>Accept Target: Writhing Haunt
step
.goto Tirisfal Glades,83.0,68.9
>>Talk to |cRXP_FRIENDLY_High Executor Derrington|r
.turnin 5098 >>Turn in All Along the Watchtowers
.target High Executor Derrington
.accept 838 >>Accept Scholomance
step
#era/som
.goto Tirisfal Glades,83.2,69.3
>>Talk to |cRXP_FRIENDLY_Apothecary Dithers|r
.turnin 838 >>Turn in Scholomance
.target Apothecary Dithers
.accept 964 >>Accept Skeletal Fragments
step
#som
#phase 3-6
.goto Tirisfal Glades,83.2,69.3
.target Apothecary Dithers
>>Talk to |cRXP_FRIENDLY_Apothecary Dithers|r
.turnin 838 >>Turn in Scholomance
step
>>Go to the top floor of the Inn. Talk to Chromie
.goto Western Plaguelands,39.5,66.8
>>Talk to |cRXP_FRIENDLY_Chromie|r
.turnin 4971 >>Turn in A Matter of Time
.target Chromie
.accept 4972 >>Accept Counting Out Time
step
#completewith next
>>Loot the tiny gray Lockboxes found throughout the buildings of the ruins. There's usually 1 per building
.goto Western Plaguelands,42.8,68.3,0
.complete 4972,1 
step
>>Go to the top floor of the Inn. Talk to Chromie
.goto Western Plaguelands,39.5,66.8
.target Chromie
>>Talk to |cRXP_FRIENDLY_Chromie|r
.turnin 4972 >>Turn in Counting Out Time
step
#era/som
.goto Western Plaguelands,47.79,70.90
>>Kill Skeletons in Andorhal. Loot them for Skeletal Fragments
.complete 964,1 
step
>>Loot the tiny gray Lockboxes found throughout the buildings of the ruins. There's usually 1 per building
.goto Western Plaguelands,42.8,68.3
.complete 4972,1 
step
>>Kill Cauldron Lord Razarch. Loot him for the key
>>Be careful of the Freezing Ghouls nearby, as they have a 5-second long, instant cast AoE stun
.goto Western Plaguelands,53.07,65.97
.complete 5233,1 
step
.goto Western Plaguelands,53.0,65.7
>>Be careful of the Freezing Ghouls nearby, as they have a 5-second long, instant cast AoE stun
.turnin 5233 >>Turn in Target: Writhing Haunt
.accept 5234 >>Accept Return to the Bulwark
step
.goto Western Plaguelands,53.7,64.8
>>Go into the house. Accept the quest from Mulgris
>>Be careful of the Freezing Ghouls nearby, as they have a 5-second long, instant cast AoE stun
.target Mulgris Deepriver
>>Talk to |cRXP_FRIENDLY_Mulgris Deepriver|r
.accept 4984 >>Accept The Wildlife Suffers Too
step
#completewith Businessman
.goto Western Plaguelands,46.41,42.36,0
>>Kill Diseased Wolves that you see
.complete 4984,1 
.unitscan Diseased Wolf
step
.goto Western Plaguelands,51.9,28.2
.target Kirsta Deepshadow
>>Talk to |cRXP_FRIENDLY_Kirsta Deepshadow|r
.accept 6004 >>Accept Unfinished Business
step
#completewith next
>>Kill the Scarlet Mages and Knights along the road. Come back later if you can't find 2 of each
>>The Mages and Knights share respawns, so you may have to kill some to respawn the ones you need (about 75% Knight, 25% Mage)
.goto Western Plaguelands,50.43,41.12,70,0
.goto Western Plaguelands,53.50,36.85,70,0
.goto Western Plaguelands,50.43,41.12
.complete 6004,3 
.complete 6004,4 
step
>>Kill Scarlet Medics and Hunters found in the camps
>>The Medics and Hunters share respawns with other mobs, so you may have to kill some other types to respawn the ones you need
.goto Western Plaguelands,51.77,44.13,70,0
.goto Western Plaguelands,40.83,52.30,70,0
.goto Western Plaguelands,47.35,51.54,0
.goto Western Plaguelands,51.77,44.13
.complete 6004,1 
.complete 6004,2 
step
>>Kill the Scarlet Mages and Knights along the road. Come back later if you can't find 2 of each
>>The Mages and Knights share respawns, so you may have to kill some to respawn the ones you need (about 75% Knight, 25% Mage)
.goto Western Plaguelands,50.43,41.12,70,0
.goto Western Plaguelands,53.50,36.85,70,0
.goto Western Plaguelands,50.43,41.12
.complete 6004,3 
.complete 6004,4 
step
.goto Western Plaguelands,52.0,28.1
>>Talk to |cRXP_FRIENDLY_Kirsta Deepshadow|r
.turnin 6004 >>Turn in Unfinished Business
.target Kirsta Deepshadow
.accept 6023 >>Accept Unfinished Business
step
>>Kill Huntsman Radley. Be careful not to chain pull the mobs around her
>>Be careful of the Spellbinders in the area, as they cast Frost Nova
.goto Western Plaguelands,57.83,36.10
.complete 6023,1 
step
>>Kill Cavalier Durgen. Be careful as he has a 5 second, instant cast stun
>>Try to kill him when he patrols outside to the front of the tower
.goto Western Plaguelands,54.1,25.1
.complete 6023,2 
.unitscan Cavalier Durgen
step
#label Businessman
.goto Western Plaguelands,51.9,28.2
>>Talk to |cRXP_FRIENDLY_Kirsta Deepshadow|r
.turnin 6023 >>Turn in Unfinished Business
.target Kirsta Deepshadow
.accept 6025 >>Accept Unfinished Business
step
.goto Western Plaguelands,47.92,39.63,90,0
.goto Western Plaguelands,46.70,47.77,90,0
.goto Western Plaguelands,51.35,48.78,90,0
.goto Western Plaguelands,52.13,61.17,90,0
.goto Western Plaguelands,47.92,39.63
>>Kill Diseased Wolves. They share spawns with Carrion Lurkers. Kill them too if you're unable to find wolves.
.complete 4984,1 
.unitscan Diseased Wolf
step
.goto Western Plaguelands,53.7,64.7
>>Talk to |cRXP_FRIENDLY_Mulgris Deepriver|r
.turnin 4984 >>Turn in The Wildlife Suffers Too
.target Mulgris Deepriver
.accept 4985 >>Accept The Wildlife Suffers Too
step
.goto Western Plaguelands,56.08,63.26,90,0
.goto Western Plaguelands,60.15,59.93,90,0
.goto Western Plaguelands,59.43,52.40,90,0
.goto Western Plaguelands,68.18,46.23,90,0
.goto Western Plaguelands,56.08,63.26
>>Kill Diseased Grizzlys
.complete 4985,1 
.unitscan Diseased Grizzly
step
#era/som
>>Travel to Tirion Fordring
.goto Eastern Plaguelands,7.5,43.6
.target Tirion Fordring
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.accept 5542 >>Accept Demon Dogs
.accept 5543 >>Accept Blood Tinged Skies
.accept 5544 >>Accept Carrion Grubbage
step
#era/som
#completewith WormMeat
.goto Eastern Plaguelands,16.80,64.61,0
.goto Eastern Plaguelands,25.28,70.11,0
.goto Eastern Plaguelands,30.37,69.59,0
.goto Eastern Plaguelands,42.26,69.09,0
.goto Eastern Plaguelands,44.43,82.82,0
.goto Eastern Plaguelands,57.29,79.85,0
>>Kill Carrion Worms. Loot them for their Meat
.complete 5544,1 
step
#era/som
#completewith Pamela
.goto Eastern Plaguelands,16.80,64.61,0
.goto Eastern Plaguelands,25.28,70.11,0
.goto Eastern Plaguelands,30.37,69.59,0
.goto Eastern Plaguelands,42.26,69.09,0
.goto Eastern Plaguelands,44.43,82.82,0
.goto Eastern Plaguelands,57.29,79.85,0
>>Kill Plaguebats and Plaguehounds in the area
.complete 5543,1 
.complete 5542,1 
step
#era/som
>>Travel to Nathanos
.goto Eastern Plaguelands,26.6,74.8
.target Nathanos Blightcaller
>>Talk to |cRXP_FRIENDLY_Nathanos Blightcaller|r
.accept 6022 >>Accept To Kill With Purpose
.accept 6042 >>Accept Un-Life's Little Annoyances

step
#som
#phase 3-6
>>Travel to Nathanos
.goto Eastern Plaguelands,26.6,74.8
.target Nathanos Blightcaller
>>Talk to |cRXP_FRIENDLY_Nathanos Blightcaller|r
.accept 6022 >>Accept To Kill With Purpose
step
#som
#phase 3-6
.goto Eastern Plaguelands,27.3,85.4
>>Loot the scroll on the ground inside of the crypt
.accept 6024 >>Accept Hameya's Plea
step
.goto Eastern Plaguelands,36.4,90.8
>>Talk to |cRXP_FRIENDLY_Pamela Redpath|r
.turnin 5601 >>Turn in Sister Pamela
.target Pamela Redpath
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
.complete 5149,1 
step
#label Pamela
.goto Eastern Plaguelands,36.4,90.8
>>Talk to |cRXP_FRIENDLY_Pamela Redpath|r
.turnin 5149 >>Turn in Pamela's Doll
.target Pamela Redpath
.accept 5152 >>Accept Auntie Marlene
.accept 5241 >>Accept Uncle Carlin
step
#era/som
.goto Eastern Plaguelands,16.80,64.61,80,0
.goto Eastern Plaguelands,25.28,70.11,80,0
.goto Eastern Plaguelands,30.37,69.59,80,0
.goto Eastern Plaguelands,42.26,69.09,80,0
.goto Eastern Plaguelands,44.43,82.82,80,0
.goto Eastern Plaguelands,57.29,79.85,80,0
.goto Eastern Plaguelands,16.80,64.61
>>Kill Plaguebats and Plaguehounds in the area
.complete 5543,1 
.complete 5542,1 
step
#era/som
.goto Eastern Plaguelands,72.94,54.96
>>Kill Plaguehounds in the area
.complete 5542,2 
step
#completewith next
>> Get 7 Living Rot from the undead mobs in town and turn it into a Coagulated Rot before they expire
.collect 15447,7 
step
>> Use the Mortar and Pestle to combine the Living Rot into Coagulated Rot
.goto Eastern Plaguelands,62.5,66.5
.complete 6022,1 
step
#era/som
.goto Eastern Plaguelands,51.67,60.09,90,0
.goto Eastern Plaguelands,72.94,54.96
>>Kill Plaguehounds and Noxious Plaguebats in the area
.complete 5542,2 
.complete 6042,1 
step
.goto Eastern Plaguelands,80.2,57.0
.fp Light's Hope Chapel >> Get the Light's Hope Chapel flight path
step
.goto Eastern Plaguelands,81.4,59.9
.target Duke Nicholas Zverenhoff
>>Talk to |cRXP_FRIENDLY_Duke Nicholas Zverenhoff|r
.turnin 6030 >>Turn in Duke Nicholas Zverenhoff
>>Talk to |cRXP_FRIENDLY_Carlin Redpath|r
.turnin 5241 >>Turn in Uncle Carlin
.target Carlin Redpath
.accept 5211 >>Accept Defenders of Darrowshire
step
.goto Eastern Plaguelands,79.6,63.9
.target Caretaker Alen
>>Talk to |cRXP_FRIENDLY_Caretaker Alen|r
.accept 6021 >>Accept Zaeldarr the Outcast
.accept 5281 >>Accept The Restless Souls
step
#lavel ghoulsepl
>>These can be hard to find. Kill Ghouls and the Darrowshire Spirits will emerge from the corpses. Talk to them to free their spirit.
.goto Eastern Plaguelands,77.11,48.00,90,0
.goto Eastern Plaguelands,67.85,41.13,90,0
.goto Eastern Plaguelands,63.70,38.55,90,0
.goto Eastern Plaguelands,77.11,48.00,0
.goto Eastern Plaguelands,67.85,41.13,0
.goto Eastern Plaguelands,63.70,38.55,0
.goto Eastern Plaguelands,61.04,66.91,0
.goto Eastern Plaguelands,39.02,52.71,0
.complete 5211,1 
.unitscan Diseased Flayer;Gibbering Ghoul
step
.goto Eastern Plaguelands,65.28,24.77,90,0
.goto Eastern Plaguelands,64.58,21.56,90,0
.goto Eastern Plaguelands,69.19,22.04,40,0
.goto Eastern Plaguelands,69.7,18.6
>>You should be able to avoid all the mobs en route up the mountain. Run past them all then run up the mountains to the east
>>Kill Infiltrator Hameya. Loot him for his key
.complete 6024,1 
step
#era/som
#label WormMeat
.goto Eastern Plaguelands,46.5,38.7
>>Kill Monstrous Plaguebats and Frenzied Plaguehounds
>>Be careful as Plaguebats can silence for 10 seconds in melee range << !Rogue !Warrior
.complete 6042,2 
.complete 5542,3 
step
#era/som
.goto Eastern Plaguelands,53.81,37.82,90,0
.goto Eastern Plaguelands,48.90,27.18
>>Kill Carrion Worms. Loot them for their Meat
.complete 5544,1 
.unitscan Carrion Devourer
step
>>Loot the Termite Mounds found around Plaguewood. They look like half-cut tree logs
.goto Eastern Plaguelands,25.68,32.38
.complete 5901,1 
step
>>Inside the house
.goto Eastern Plaguelands,14.5,33.7
.target Egan
>>Talk to |cRXP_FRIENDLY_Egan|r
.turnin 5281 >>Turn in The Restless Souls
.target Augustus the Touched
>>Talk to |cRXP_FRIENDLY_Augustus the Touched|r

.accept 6164 >>Accept Augustus' Receipt Book
step
>>Second floor of the Inn on the floor
.goto Eastern Plaguelands,17.5,31.2
.complete 6164,1 
step
>>Run back to the house
.goto Eastern Plaguelands,14.5,33.6
.target Augustus the Touched
>>Talk to |cRXP_FRIENDLY_Augustus the Touched|r

.turnin 6164 >>Turn in Augustus' Receipt Book

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
#era/som
.goto Eastern Plaguelands,7.6,43.7
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.turnin 5542 >>Turn in Demon Dogs
.turnin 5543 >>Turn in Blood Tinged Skies
.turnin 5544 >>Turn in Carrion Grubbage
.target Tirion Fordring
.accept 5742 >>Accept Redemption
step
#era/som
.goto Eastern Plaguelands,7.6,43.7
>>Type /sit when listening to Tirion's Tale. You can be mounted when doing this
.complete 5742,1 
.skipgossip
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.turnin 5742 >>Turn in Redemption
.target Tirion Fordring
.accept 5781 >>Accept Of Forgotten Memories
step
#era/som
>>Run back to Nathanos
.goto Eastern Plaguelands,26.6,74.8
>>Talk to |cRXP_FRIENDLY_Nathanos Blightcaller|r
.turnin 6022 >>Turn in To Kill With Purpose
.turnin 6042 >>Turn in Un-Life's Little Annoyances
.target Nathanos Blightcaller
.accept 6133 >>Accept The Ranger Lord's Behest
step
#som
#phase 3-6
>>Run back to Nathanos
.goto Eastern Plaguelands,26.6,74.8
.target Nathanos Blightcaller
>>Talk to |cRXP_FRIENDLY_Nathanos Blightcaller|r
.turnin 6022 >>Turn in To Kill With Purpose
step
#era/som
>>Click on the dirt grave to summon Mercutio and 3 adds. Kill Mercutio, and loot him for Taelan's hammer
>>Be careful, as the adds take a LONG time to reset and break leash for some reason.
>>This quest is one of the hardest in the game. Skip it if you need to << !Mage !Warlock !Hunter !Rogue !Druid
>> Split pull the pack that spawns with Blizzard. Kite Mercutio away until the other mobs break leash << Mage
>> Split pull the pack that spawns with Rain of Fire. Kite Mercutio away until the other mobs break leash << Warlock
>> Split pull the pack that spawns with Volley. Kite Mercutio away until the other mobs break leash << Hunter
>> Stealth into the middle of the pack that spawns, then de-stealth, immediately aggroing all mobs at once. Keep refreshing leash on Mercutio whilst sprinting away from the other mobs << Rogue
>> Stealth into the middle of the pack that spawns, then de-stealth, immediately aggroing all mobs at once. Keep refreshing leash on Mercutio whilst dashing away from the other mobs << Druid
.goto Eastern Plaguelands,28.4,85.3
.complete 5781,1 
.link https://www.twitch.tv/videos/850028806?t=02h34m49s >> CLICK HERE for reference << Mage/Warlock/Hunter/Druid/Rogue
step
#era/som
#sticky
#label HameyaP
.goto Eastern Plaguelands,27.3,85.4
>>Loot the scroll on the ground inside of the crypt
.accept 6024 >>Accept Hameya's Plea
step
>>Go into the crypt. Kill Zaeldarr
.goto Eastern Plaguelands,27.4,85.1
.complete 6021,1 
step
>>Click on the mound of dirt outside behind the crypt
.goto Eastern Plaguelands,28.1,86.1
.turnin 6024 >>Turn in Hameya's Plea
step
#era/som
#requires HameyaP
#label Memories
.isQuestComplete 5781
.goto Eastern Plaguelands,7.4,43.7
.target Tirion Fordring
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.turnin 5781 >>Turn in Of Forgotten Memories
step
#era/som
.isQuestTurnedIn 5781
.goto Eastern Plaguelands,7.4,43.7
.target Tirion Fordring
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.accept 5845 >>Accept Of Lost Honor
step
#era/som
.goto Eastern Plaguelands,65.28,24.77,90,0
.goto Eastern Plaguelands,64.58,21.56,90,0
.goto Eastern Plaguelands,69.19,22.04,40,0
.goto Eastern Plaguelands,69.7,18.6
>>You should be able to avoid all the mobs en route up the mountain. Run past them all then run up the mountains to the east
>>Kill Infiltrator Hameya. Loot him for his key
.complete 6024,1 
step
#era/som
#sticky
#label registry
.goto Eastern Plaguelands,52.2,18.4
>>Look for a small book on top of a bench
.complete 6133,4
step
#era/som
.goto Eastern Plaguelands,51.2,19.1
.complete 6133,1
.complete 6133,2
.complete 6133,3
step
#era/som
.isQuestTurnedIn 5781
>>Loot the banner underwater
.goto Eastern Plaguelands,71.3,33.9
.complete 5845,1 
step
#requires ghoulsepl
.goto Eastern Plaguelands,79.6,63.9
.target Caretaker Alen
>>Talk to |cRXP_FRIENDLY_Caretaker Alen|r
.turnin 6021 >>Turn in Zaeldarr the Outcast
step
.goto Eastern Plaguelands,81.5,59.9
.target Carlin Redpath
>>Talk to |cRXP_FRIENDLY_Carlin Redpath|r
.turnin 5211 >>Turn in Defenders of Darrowshire
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
.target Ralston Farnsley
>>Talk to |cRXP_FRIENDLY_Ralston Farnsley|r
.turnin 7813 >> Turn in A Donation of Wool
.turnin 7814 >> Turn in A Donation of Silk
.turnin 7817 >> Turn in A Donation of Mageweave
.turnin 7818 >> Turn in A Donation of Runecloth
#softcore
step
.goto Undercity,69.7,43.7
>>Talk to |cRXP_FRIENDLY_Royal Overseer Bauhaus|r
.turnin 5023 >>Turn in Better Late Than Never
.target Royal Overseer Bauhaus
.accept 5049 >>Accept The Jeremiah Blues
step
>>Under the stairs
.goto Undercity,67.4,44.4
>>Talk to |cRXP_FRIENDLY_Jeremiah Payson|r
.turnin 5049 >>Turn in The Jeremiah Blues
.target Jeremiah Payson
.target Ol' Emma
>>Talk to |cRXP_FRIENDLY_Ol' Emma|r

.accept 5050 >>Accept Good Luck Charm
step
.isQuestComplete 3568
.goto Undercity,48.709,71.389
.target Chemist Cuely
>>Talk to |cRXP_FRIENDLY_Chemist Cuely|r
.turnin 3568 >>Turn in Seeping Corruption
step
.isQuestTurnedIn 3568
.goto Undercity,48.709,71.389
.target Chemist Cuely
>>Talk to |cRXP_FRIENDLY_Chemist Cuely|r
.accept 3569 >>Accept Seeping Corruption
>>Turn in at the Tauren nearby
.target Thersa Windsong
>>Talk to |cRXP_FRIENDLY_Thersa Windsong|r
.turnin 3569 >>Turn in Seeping Corruption
.turnin 3570 >>Turn in Seeping Corruption
step
.isOnQuest 3542
.goto Undercity,55.0,76.6
.target Andron Gant
>>Talk to |cRXP_FRIENDLY_Andron Gant|r
.turnin 3542 >>Turn in Delivery to Andron Gant
step
.isQuestComplete 3542
.goto Undercity,54.9,75.8
.target Andron Gant
>>Talk to |cRXP_FRIENDLY_Andron Gant|r
.accept 3564 >>Accept Andron's Payment to Jediga
step
#era/som
>>Travel to the Royal Quarter
.goto Undercity,51.88,64.49,30,0
.goto Undercity,57.3,91.3
.target Lady Sylvanas Windrunner
>>Talk to |cRXP_FRIENDLY_Lady Sylvanas Windrunner|r
.accept 5961 >>Accept The Champion of the Banshee Queen
step
.goto Undercity,55.22,90.88
+Go to the edge of the main platform and perform a Logout Skip by positioning your character until it looks like they're floating, then logging out and back in.
.link https://www.youtube.com/watch?v=jj85AXyF1XE >> Open this tab when running to the turn in. CLICK HERE for an example
>>If you can't do this, just run out of Undercity normally
step
.goto Tirisfal Glades,61.85,66.59,60 >> Exit Undercity
step
#era/som
.goto Tirisfal Glades,83.282,69.234
.target Apothecary Dithers
>>Talk to |cRXP_FRIENDLY_Apothecary Dithers|r
.turnin 964 >>Turn in Skeletal Fragments
step
.goto Tirisfal Glades,83.0,72.0
>>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r
.turnin 5234 >>Turn in Return to the Bulwark
.target Shadow Priestess Vandis
.accept 5235 >>Accept Target: Gahrron's Withering
step
.goto Tirisfal Glades,83.294,72.336
>>Talk to |cRXP_FRIENDLY_Mickey Levine|r
.turnin 5901 >>Turn in A Plague Upon Thee
.target Mickey Levine
.accept 5902 >>Accept A Plague Upon Thee
step
>>Top floor of the building
.goto Western Plaguelands,38.401,54.053
>>Talk to |cRXP_FRIENDLY_Janice Felstone|r
.turnin 5050 >>Turn in Good Luck Charm
.target Janice Felstone
.accept 5051 >>Accept Two Halves Become One
step
.goto Western Plaguelands,38.0,54.7
>>Find a Jabbering Ghoul. Kill him and loot the Good Luck Charm
.complete 5051,1 
.unitscan Jabbering Ghoul
step
>>Top floor of the building
.goto Western Plaguelands,38.401,54.053
.target Janice Felstone
>>Talk to |cRXP_FRIENDLY_Janice Felstone|r
.turnin 5051 >>Turn in Two Halves Become One
step
>>Talk to Marlene inside the house
.goto Western Plaguelands,48.9,78.4
>>Talk to |cRXP_FRIENDLY_Marlene Redpath|r
.turnin 5152 >>Turn in Auntie Marlene
.target Marlene Redpath
.accept 5153 >>Accept A Strange Historian
step
>>Click the gravestone. Loot it for the ring
.goto Western Plaguelands,49.69,76.75
.complete 5153,1 
step
>>Go to the top floor of the Inn. Talk to Chromie
.goto Western Plaguelands,39.4,66.8
>>Talk to |cRXP_FRIENDLY_Chromie|r
.turnin 5153 >>Turn in A Strange Historian
.target Chromie
.accept 5154 >>Accept The Annals of Darrowshire
step
>> Enter the town hall. Be very careful to not aggro the mobs outside when entering inside
>> Look for a real book on the ground. Loot it.
>> The correct book will be WHITE only on the pages when you hover over it. Not half gray/half white.
>> You may need to loot some fake books to spawn real ones if you can't find any (as they share spawns)
.goto Western Plaguelands,43.4,69.6
.complete 5154,1 
.link https://i.imgur.com/B2HDb6K.png >> CLICK HERE for visual example
step
>>Go to the top floor of the Inn. Talk to Chromie
.goto Western Plaguelands,39.5,66.8
>>Talk to |cRXP_FRIENDLY_Chromie|r
.turnin 5154 >>Turn in The Annals of Darrowshire
.target Chromie
.accept 5210 >>Accept Brother Carlin
step
>>Run back to the farm with the dead Tauren
.goto Western Plaguelands,53.6,64.7
>>Talk to |cRXP_FRIENDLY_Mulgris Deepriver|r
.turnin 4985 >>Turn in The Wildlife Suffers Too
.target Mulgris Deepriver
.accept 4987 >>Accept Glyphed Oaken Branch
step
>>Kill Cauldron Lord Soulwraith. Loot him for the key
.goto Western Plaguelands,62.80,58.76
.complete 5235,1 
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
>>Run up to the top of the tower. Be careful as the Paladins outside can heal. You can try running past them/Crowd controlling them and going to the top, but be mindful that mobs have no Z axis range (they can hit you from the bottom of the tower)
.complete 6025,1 
step
>>Travel out of Hearthglen back to Kirsta
.goto Western Plaguelands,51.920,28.058
.target Kirsta Deepshadow
>>Talk to |cRXP_FRIENDLY_Kirsta Deepshadow|r
.turnin 6025 >>Turn in Unfinished Business
step
>>Travel back to The Bulwark
.goto Tirisfal Glades,83.0,71.9
.target Shadow Priestess Vandis
>>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r
.turnin 5236 >>Turn in Return to the Bulwark
step
.goto Tirisfal Glades,83.2,72.3
.target Mickey Levine
>>Talk to |cRXP_FRIENDLY_Mickey Levine|r
.turnin 6390 >>Turn in A Plague Upon Thee
step
.goto Tirisfal Glades,83.1,68.9
.target High Executor Derrington
>>Talk to |cRXP_FRIENDLY_High Executor Derrington|r
.turnin 5238 >>Turn in Mission Accomplished!
step
#era/som
>>Ride back to Tirion
.goto Eastern Plaguelands,7.5,43.6
>>Talk to |cRXP_FRIENDLY_Tirion Fordring|r
.turnin 5845 >>Turn in Of Lost Honor
.target Tirion Fordring
.accept 5846 >>Accept Of Love and Family
step
#era/som
>>Swim to Caer Darrow << !Shaman
>>Waterwalk to Caer Darrow if you have the Reagents. Otherwise, swim << Shaman
.goto Western Plaguelands,65.7,75.3
.target Artist Renfray
>>Talk to |cRXP_FRIENDLY_Artist Renfray|r
.turnin 5846 >>Turn in Of Love and Family
step
#era/som
>>Click on the mound of dirt outside behind the crypt
.goto Eastern Plaguelands,28.1,86.1
.turnin 6024 >>Turn in Hameya's Plea
step
#era/som
>>Run back to Nathanos
.goto Eastern Plaguelands,26.6,74.8
.target Nathanos Blightcaller
>>Talk to |cRXP_FRIENDLY_Nathanos Blightcaller|r
.turnin 5961 >>Turn in The Champion of the Banshee Queen
.turnin 6133 >> The Ranger Lord's Behest
step
#era/som
>>Run back to Light's Hope Chapel
.goto Eastern Plaguelands,81.5,59.7
.target Carlin Redpath
>>Talk to |cRXP_FRIENDLY_Carlin Redpath|r
.turnin 5210 >>Turn in Brother Carlin
step
.hs >> Hearth to Everlook
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 50-60
#classic
<< Horde
#name 59-59 Winterspring/Silithus I
#next 59-60 Winterspring/Silithus II
step
#era/som
.goto Winterspring,61.60,38.60
.target Felnok Steelspring
>>Talk to |cRXP_FRIENDLY_Felnok Steelspring|r
.accept 4809 >> Accept Chillwind Horns
step
#era/som
.goto Winterspring,60.90,37.70
.target Umi Rumplesnicker
>>Talk to |cRXP_FRIENDLY_Umi Rumplesnicker|r
.accept 977 >> Accept Are We There, Yeti?
step << skip
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
step << skip
.goto Winterspring,67.19,35.81
>> Kill Furbolgs at the village. Skip this step if the village is too crowded
.complete 8464,1
.complete 8464,2
.complete 8464,3
step
#era/som
.goto Winterspring,67.66,41.70,50,0
.goto Winterspring,70.00,41.88
>> Go into the cave. Kill Yeti Patriarchs and Matriachs. Loot them for the Pristine Yeti Horn
.complete 977,1
step << Shaman
.hs >> Hearth to Everlook
>> Buy food/water if needed
step
#era/som
.goto Winterspring,60.90,37.70
>>Talk to |cRXP_FRIENDLY_Umi Rumplesnicker|r
.turnin 977 >> Turn in Are We There, Yeti?
.target Umi Rumplesnicker
.accept 5163 >> Accept Are We There, Yeti?
step
#era/som
.goto Winterspring,61.50,38.60
>> Use the Mechanical Yeti on Legacki
.complete 5163,1
step
#era/som
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
>>Talk to |cRXP_FRIENDLY_Donova Snowden|r
.turnin 5121 >> Turn in High Chief Winterfall
.turnin 5123 >> Turn in The Final Piece
.target Donova Snowden
.accept 5128 >> Accept Words of the High Chief
step << skip
.goto Felwood,68.30,6.07
.target Salfa
>>Talk to |cRXP_FRIENDLY_Salfa|r
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
>>Talk to |cRXP_FRIENDLY_Rabine Saturna|r
.turnin 1123 >> Turn in Rabine Saturna
.target Rabine Saturna
.accept 1124 >> Accept Wasteland
step
.goto Moonglade,51.68,45.09
>> Finish the dialogue with Rabine. Skip this step if the Dire Maul dialogue is not available
.target Rabine Saturna
>>Talk to |cRXP_FRIENDLY_Rabine Saturna|r
.accept 5527 >> Accept A Reliquary of Purity
.skipgossip
step
.goto Moonglade,32.10,66.60
.fp Moonglade >> Get the Moonglade Flight Path << !Druid
.fly Felwood>> Fly to Felwood
step
#era/som
.goto Felwood,34.70,52.80
>>Talk to |cRXP_FRIENDLY_Trull Failbane|r
.turnin 4741 >> Turn in Wild Guardians
.target Trull Failbane
.accept 4721 >> Accept Wild Guardians
step << !Rogue !Warrior
#era/som
.goto Winterspring,13.90,96.10
.target Greta Mosshoof
>>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r
.turnin 5242 >> Turn in A Final Blow
step << !Rogue !Warrior
#era/som
.goto Winterspring,14.00,96.00
.target Jessir Moonbow
>>Talk to |cRXP_FRIENDLY_Jessir Moonbow|r
.turnin 5385 >> Turn in The Remains of Trey Lightforge
step
#era/som
.goto Winterspring,13.90,95.80
.target Kelek Skykeeper
>>Talk to |cRXP_FRIENDLY_Kelek Skykeeper|r
.turnin 5128 >> Turn in Words of the High Chief
step
#era/som
#softcore
.goto Winterspring,14.00,95.60
>>Talk to |cRXP_FRIENDLY_Eridan Bluewind|r
.turnin 4084 >> Turn in Silver Heart
.target Eridan Bluewind
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
#completewith next
.fly Azshara>> Fly to Azshara
step
.isOnQuest 3564
.goto Azshara,22.50,51.40
.target Jediga
>>Talk to |cRXP_FRIENDLY_Jediga|r
.turnin 3564 >> Turn in Andron's Payment to Jediga
step << !Mage
.goto Azshara,22.00,49.70
.fly Thunder Bluff>> Fly to Thunder Bluff
step << Mage
.zone Thunder Bluff >> Teleport to Thunder Bluff
step
.goto Thunder Bluff,43.3,42.8
>>Buy 3 stacks of each cloth on the AH if you weren't able to earlier.
.target Rumstag Proudstrider
>>Talk to |cRXP_FRIENDLY_Rumstag Proudstrider|r
.turnin 7820 >> Turn in A Donation of Wool
.turnin 7821 >> Turn in A Donation of Silk
.turnin 7822 >> Turn in A Donation of Mageweave
.turnin 7823 >> Turn in A Donation of Runecloth
#softcore
step
.goto Thunder Bluff,75.80,31.20
.target Nara Wildmane
>>Talk to |cRXP_FRIENDLY_Nara Wildmane|r
.turnin 4987 >> Turn in Glyphed Oaken Branch
step
.goto Thunder Bluff,46.8,50.0
.fly Tanaris>> Fly to Tanaris
step
#som
#phase 3-6
#softcore
.goto Tanaris,53.90,23.40
>> Use the Videre Elixir at the Tanaris Graveyard
>>Talk to |cRXP_FRIENDLY_Gaeriyan|r
.turnin 3912 >> Turn in Meet at the Grave
.target Gaeriyan
.accept 3913 >> Accept A Grave Situation
step
#som
#phase 3-6
#softcore
.goto Tanaris,53.80,29.10
.turnin 3913 >> Turn in A Grave Situation
.accept 3914 >> Accept Linken's Sword
step
#era/som
.goto Tanaris,51.56,26.75
.target Tran'rek
>>Talk to |cRXP_FRIENDLY_Tran'rek|r
.accept 4504 >> Accept Super Sticky
step
#era/som
.goto Tanaris,51.10,26.90
>> Use the Mechanical Yeti on Sprinkle
.complete 5163,2
step
.goto Tanaris,50.90,27.00
.target Alchemist Pestlezugg
>>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r
.accept 4507 >> Accept Pawn Captures Queen
step
#era/som
#softcore
.goto Tanaris,70.40,49.90
>>Head to the pirate area and use the supplies provided at the stone circle to summon Aquementas
.complete 4005,1
step
.goto Tanaris,51.6,25.5
.fly Un'Goro Crater>> Fly to Un'Goro Crater
step
#era/som
#softcore
.goto Tanaris,11.60,3.40
>>Talk to |cRXP_FRIENDLY_J.D. Collie|r
.turnin 4005 >> Turn in Aquementas
.target J.D. Collie
.accept 3961 >> Accept Linken's Adventure
step
#era/som
#softcore
.goto Tanaris,13.10,6.40
>>Talk to |cRXP_FRIENDLY_Linken|r
.turnin 3961 >> Turn in Linken's Adventure
.target Linken
.accept 3962 >> Accept It's Dangerous to Go Alone
step
#som
#phase 3-6
#softcore
.goto Tanaris,13.10,6.40
>>Talk to |cRXP_FRIENDLY_Linken|r
.turnin 3914 >> Turn in Linken's Sword
.target Linken
.accept 3941 >> Accept A Gnome's Assistance
step
#som
#phase 3-6
#softcore
.goto Tanaris,11.60,3.40
>>Talk to |cRXP_FRIENDLY_J.D. Collie|r
.turnin 3941 >> Turn in A Gnome's Assistance
.target J.D. Collie
.accept 3942 >> Accept Linken's Memory
step
#era/som
.goto Un'Goro Crater,43.70,9.40
>> Use the Mechanical Yeti on Quixxil
.complete 5163,3
step
#era/som
.goto Un'Goro Crater,46.86,15.11,100,0
.goto Un'Goro Crater,42.03,21.77,100,0
.goto Un'Goro Crater,49.54,20.49,100,0
.goto Un'Goro Crater,52.00,27.21,100,0
.goto Un'Goro Crater,64.11,24.14,100,0
.goto Un'Goro Crater,59.65,31.29
>>Kill the Tar Beasts in the area. Loot them for their Tar
>>Be careful as the Tar Lords cast Entangling Roots << !Warrior !Rogue !Shaman
>>Be careful as the Tar Lords cast Entangling Roots, and all Tar Beasts have a thorns-like effect where you can be Disarmed for 4 seconds << Warrior/Rogue/Shaman
.complete 4504,1 
step
#era/som
#softcore
#completewith next
.goto Un'Goro Crater,50.28,49.98
>> Click on the chest at the back of the cave
.complete 3962,2
step
#era/som
#softcore
.goto Un'Goro Crater,50.28,49.98,0
>> Equip the Silver Totem of Aquementas on your off-hand
>>Use it to weaken Blazerunner at the top of the volcano
.complete 3962,1
step
#era/som
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
>>Talk to |cRXP_FRIENDLY_Layo Starstrike|r
.turnin 1124 >> Turn in Wasteland
.target Layo Starstrike
.accept 1125 >> Accept The Spirits of Southwind
step
#completewith end
.xpto60 >> Skip to the part 2 of the guide once you have enough xp to ding 60
step
#phase 4
.goto Silithus,51.80,38.60
>> Talk to the goblin on the 2nd floor of the inn
.target Beetix Ficklespragg
>>Talk to |cRXP_FRIENDLY_Beetix Ficklespragg|r
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
>>Talk to |cRXP_FRIENDLY_Windcaller Proudhorn|r
.turnin 8275 >> Turn in Taking Back Silithus
.target Windcaller Proudhorn
.accept 8280 >> Accept Securing the Supply Lines
step
#phase 4
.goto Silithus,49.60,37.30
.target Geologist Larksbane
>>Talk to |cRXP_FRIENDLY_Geologist Larksbane|r
.accept 8284 >> Accept The Twilight Mystery
step
#phase 4
.goto Silithus,49.20,34.20
.target Commander Mar'alith
>>Talk to |cRXP_FRIENDLY_Commander Mar'alith|r
.accept 8304 >> Accept Dearest Natalia
step
#phase 4
.goto Silithus,48.60,37.80
.target Bor Wildmane
>>Talk to |cRXP_FRIENDLY_Bor Wildmane|r
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
.collect 20461,1,8308 
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
>>Talk to |cRXP_FRIENDLY_Layo Starstrike|r
.turnin 1125 >> Turn in The Spirits of Southwind
.target Layo Starstrike
.accept 1126 >> Accept Hive in the Tower
step
.goto Silithus,60.22,52.55
>> Clear the 3 bugs that spawn at the base of the tower
>>Click on the object at the top of the tower
>>Kill the 2 ambushers that spawn after clicking it
.complete 1126,1
step
.goto Silithus,81.87,18.93
>>Talk to |cRXP_FRIENDLY_Layo Starstrike|r
.turnin 1126 >> Turn in Hive in the Tower
.target Layo Starstrike
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
>>Talk to |cRXP_FRIENDLY_Geologist Larksbane|r
.turnin 8284 >> Turn in The Twilight Mystery
.target Geologist Larksbane
.accept 8285 >> Accept The Deserter
step
#phase 4
.goto Silithus,51.10,38.20
>>Talk to |cRXP_FRIENDLY_Windcaller Proudhorn|r
.turnin 8280 >> Turn in Securing the Supply Lines
.target Windcaller Proudhorn
.accept 8281 >> Accept Stepping Up Security
step
#phase 4
.goto Silithus,51.70,38.50
>>Talk to |cRXP_FRIENDLY_Beetix Ficklespragg|r
.turnin 8277 >> Turn in Deadly Desert Venom
.target Beetix Ficklespragg
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
>>Talk to |cRXP_FRIENDLY_Hermit Ortell|r
.turnin 8285 >> Turn in The Deserter
.target Hermit Ortell
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
.target Windcaller Proudhorn
>>Talk to |cRXP_FRIENDLY_Windcaller Proudhorn|r
.turnin 8281 >> Turn in Stepping Up Security
step
#phase 4
.goto Silithus,51.70,38.50
.target Beetix Ficklespragg
>>Talk to |cRXP_FRIENDLY_Beetix Ficklespragg|r
.turnin 8278 >> Turn in Noggle's Last Hope
.target Noggle Ficklespragg
>>Talk to |cRXP_FRIENDLY_Noggle Ficklespragg|r
.accept 8282 >> Accept Noggle's Lost Satchel
step
#phase 4
.goto Silithus,49.20,34.30
.target Commander Mar'alith
>>Talk to |cRXP_FRIENDLY_Commander Mar'alith|r
.turnin 8304 >> Turn in Dearest Natalia
step << Mage/Warlock/Hunter
#phase 4
.goto Silithus,50.80,33.60
.target Vish Kozus
>>Talk to |cRXP_FRIENDLY_Vish Kozus|r
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
>>Talk to |cRXP_FRIENDLY_Hermit Ortell|r
.turnin 8279 >> Turn in The Twilight Lexicon
.target Hermit Ortell
.accept 8287 >> Accept A Terrible Purpose
.accept 8323 >> Accept True Believers
.turnin 8323 >> Turn in True Believers
step
#phase 4
.goto Silithus,51.70,38.50
>> Head to Cenarion Hold
.target Noggle Ficklespragg
>>Talk to |cRXP_FRIENDLY_Noggle Ficklespragg|r
.turnin 8282 >> Turn in Noggle's Lost Satchel
step
#phase 4
.goto Silithus,49.20,34.20
.target Commander Mar'alith
>>Talk to |cRXP_FRIENDLY_Commander Mar'alith|r
.turnin 8287 >> Turn in A Terrible Purpose
step
#phase 4
.goto Silithus,48.70,37.50
>> Kill cultists. Loot them for Encrypted Twilight Texts
.complete 8318,1
step
#phase 4
.goto Silithus,48.60,37.70
.target Bor Wildmane
>>Talk to |cRXP_FRIENDLY_Bor Wildmane|r
.turnin 8318 >> Turn in Secret Communication
step
#era/som
#softcore
#completewith next
.goto Silithus,50.59,34.45
.fly Un'Goro >> Fly to Un'Goro Crater
step
#era/som
#softcore
.goto Un'Goro Crater,44.65,8.09
.target Linken
>>Talk to |cRXP_FRIENDLY_Linken|r
.turnin 3962 >> Turn in It's Dangerous to Go Alone
step
#completewith end
.goto Un'Goro Crater,45.23,5.82
.fly Tanaris>> Fly to Tanaris
step
#era/som
.goto Tanaris,51.56,26.75
.target Tran'rek
>>Talk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 4504 >> Turn in Super Sticky
step
#label end
.goto Tanaris,50.88,26.96
>>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r
.turnin 4507 >> Turn in Pawn Captures Queen
.target Alchemist Pestlezugg
.accept 4509 >> Accept Calm Before the Storm
]])
RXPGuides.RegisterGuide([[
#version 8
#group RestedXP Horde 50-60
#classic
<< Horde
#name 59-60 Winterspring/Silithus II
step
#completewith next
.fly Un'Goro>> Fly to Un'Goro Crater
step
#era/som
.goto Un'Goro Crater,44.65,8.09
.target Linken
>>Talk to |cRXP_FRIENDLY_Linken|r
.turnin 3962 >> Turn in It's Dangerous to Go Alone
step
#completewith tanaris
.fly Tanaris>> Fly to Tanaris
step
.goto Tanaris,50.88,26.96
>>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r
.turnin 4507 >> Turn in Pawn Captures Queen
.target Alchemist Pestlezugg
.accept 4509 >> Accept Calm Before the Storm
step
#label tanaris
.goto Tanaris,51.56,26.75
.target Tran'rek
>>Talk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 4504 >> Turn in Super Sticky
step
.hs >> Hearth to Everlook
>> Buy food/water if needed
step
#era/som
.goto Winterspring,60.88,37.61
.target Umi Rumplesnicker
>>Talk to |cRXP_FRIENDLY_Umi Rumplesnicker|r
.turnin 5163 >> Turn in Are We There, Yeti?
step
#completewith moonglade
#label ding60
.xpto60 >> Stop questing in Winterspring once you have enough XP
step
#era/som
#label owlbeasts
#completewith ding60
.goto Winterspring,65.20,20.30
.complete 4721,1
.unitscan Berserk Owlbeast
step
#era/som
#requires owlbeasts
#completewith ding60
#label horns
>>Kill chimeras just north of Everlook
.complete 4809,1
.goto Winterspring,60.4,23.2
.target Felnok Steelspring
>>Talk to |cRXP_FRIENDLY_Felnok Steelspring|r
.turnin 4809 >> Turn in Chillwind Horns
.goto Winterspring,61.6,38.6
step
#label moonglade
#requires horns
.goto Winterspring,60.47,36.30
.fly Moonglade>> Fly to Moonglade
step
.goto Moonglade,44.88,35.60
>>Talk to |cRXP_FRIENDLY_Umber|r
.turnin 6844 >> Turn in Umber, Archivist
.target Umber
.accept 6845 >> Accept Uncovering Past Secrets

step
.goto Moonglade,51.68,45.09
.target Rabine Saturna
>>Talk to |cRXP_FRIENDLY_Rabine Saturna|r
.turnin 6845 >> Turn in Uncovering Past Secrets

step
.goto Moonglade,51.68,45.09
.target Rabine Saturna
>>Talk to |cRXP_FRIENDLY_Rabine Saturna|r
.turnin 5527 >> Turn in A Reliquary of Purity
.isQuestComplete 5527
step
.goto Moonglade,44.87,35.62
.target Umber
>>Talk to |cRXP_FRIENDLY_Umber|r
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
#som
#phase 3-6
.goto Felwood,51.30,81.50
.target Eridan Bluewind
>>Talk to |cRXP_FRIENDLY_Eridan Bluewind|r
.turnin 3942 >> Turn in Linken's Memory
step << !Rogue !Warrior
#som
#phase 3-6
.goto Winterspring,13.90,96.10
.target Greta Mosshoof
>>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r
.turnin 5242 >> Turn in A Final Blow
step << !Rogue !Warrior
#som
#phase 3-6
.goto Winterspring,14.00,96.00
.target Jessir Moonbow
>>Talk to |cRXP_FRIENDLY_Jessir Moonbow|r
.turnin 5385 >> Turn in The Remains of Trey Lightforge
step
#som
#phase 3-6
.goto Winterspring,13.90,95.80
.target Kelek Skykeeper
>>Talk to |cRXP_FRIENDLY_Kelek Skykeeper|r
.turnin 5128 >> Turn in Words of the High Chief
step
#era/som
.goto Winterspring,0.50,72.30
.target Trull Failbane
>>Talk to |cRXP_FRIENDLY_Trull Failbane|r
.turnin 4721 >> Turn in Wild Guardians
.isQuestComplete 4721
step << !Mage
#era/som
.goto Felwood,34.44,53.97
.fly Orgrimmar>> Fly to Orgrimmar
step << !Mage
#era/som
.goto Ashenvale,73.2,61.6
.fly Orgrimmar>> Fly to Orgrimmar
step << Mage
.zone Orgrimmar>> Teleport to Orgrimmar
step
.goto Orgrimmar,56.50,46.40
>>Talk to |cRXP_FRIENDLY_Zilzibin Drumlore|r
.turnin 4509 >> Turn in Calm Before the Storm
.target Zilzibin Drumlore
.accept 4511 >> Accept Calm Before the Storm
step
.goto Orgrimmar,49.70,69.30
.target Karus
>>Talk to |cRXP_FRIENDLY_Karus|r
.turnin 4511 >> Turn in Calm Before the Storm
]])
