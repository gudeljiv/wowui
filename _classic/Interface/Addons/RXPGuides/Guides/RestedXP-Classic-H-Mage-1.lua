
RXPGuides.RegisterGuide("RestedXP Horde Mage AoE",[[
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
    .turnin 441 >>Turn in Raleigh and the Undercity
    .accept 530 >>Accept A Husband's Revenge
step << !Undead Mage
    .goto Undercity,63.27,48.60
    .fp >> Get the Undercity Flight Path
step
    .goto Undercity,82.79,15.82
    .vendor >> Go to Hannah. Buy a Rune of Teleportation
    .collect 17031,1 --Rune of Teleportation (1)
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
    .accept 493 >>Accept Journey to Hillsbrad Foothills
step
    .goto Silverpine Forest,42.91,42.00
    .turnin 3301 >>Turn in Mura Runetotem
step
    .goto Silverpine Forest,44.18,42.67
    .turnin 264 >>Turn in Until Death Do Us Part
step << Undead Mage
    #sticky
    #label Valdred
    .goto Silverpine Forest,44.63,84.69
    .complete 530,1 --Valdred's Hands (1)
    >>Kill Valdred Moray (He is AoE-able). Loot him for his hands
step
    #completewith next
    .goto Silverpine Forest,46.50,86.49,0
    +It is HIGHLY Recommended you watch the Silverpine Section of the AoE guide, as it can be a bit tricky
    .link https://youtu.be/SxMc2GoP33c?t=555 >>CLICK HERE
    >>You can also vendor/repair/buy potions at Wallace the Blind next to the gates if needed
--N time to make a horde aoe guide lmaooooooooo
step << Undead Mage
	#requires Valdred
step
    .goto Silverpine Forest,46.10,85.75
    .xp 22 >> Run south to The Greymane Wall. AoE here until 22 
step
    >>Run East into Hillsbrad
    .goto Silverpine Forest,72.58,81.35
    .accept 494 >>Accept Time To Strike
step
    >>Run to Tarren Mill
    .goto Hillsbrad Foothills,62.37,20.58
    .turnin 494 >>Turn in Time To Strike
    .accept 527 >>Accept Battle of Hillsbrad
step << skip
    #som
    .goto Hillsbrad Foothills,62.62,20.73
    .accept 549 >>Accept WANTED: Syndicate Personnel
--N too many casters around the area, long travel
step << skip
    #som
    .goto Hillsbrad Foothills,63.24,20.65
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
    .turnin 493 >>Turn in Journey to Hillsbrad Foothills
    .turnin 1065 >>Turn in Journey to Tarren Mill
--    .accept 496 >>Accept Elixir of Suffering
    .accept 501 >>Accept Elixir of Pain
step
    .goto Hillsbrad Foothills,60.14,18.62
    .fp Hillsbrad >> Get the Tarren Mill Flight Path
step << skip
    #sticky
    #completewith Hillsbrad1
    >>AoE Bears. Loot them for their Tongues
    .complete 496,1 --Gray Bear Tongue (10)
step << skip
    #sticky
    #completewith Hillsbrad1
    >>Kill Spiders. Loot them for their Ichor
    .complete 496,2 --Creeper Ichor (1)
step
    #sticky
    #completewith Hillsbrad1
    >>AoE Lions. Loot them for their Blood
    .complete 501,1 --Mountain Lion Blood (10)
step
    #label Hillsbrad1
    .goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
step
    #sticky
    #completewith next
    +It is HIGHLY Recommended you watch the Hillsbrad Section of the AoE guide, as it can be a bit tricky
    .link https://youtu.be/SxMc2GoP33c?t=555 >>CLICK HERE
step
    #sticky
    #completewith l24
    >>Kill Citizen Wilkes. He patrols around the fields
    .complete 567,2 --Citizen Wilkes (1)
step
    #sticky
    #completewith next
    .goto Hillsbrad Foothills,35.16,39.06
    >>AoE the Hillsbrad Mobs in the area. Keep an eye out for Farmer Rey and Getz
    .complete 527,1 --Hillsbrad Farmer (6)
    .complete 527,2 --Hillsbrad Farmhand (6)
    .complete 527,3 --Farmer Ray (1)
    .complete 527,4 --Farmer Getz (1)
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
    .complete 527,4 --Farmer Getz (1)
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
    .complete 527,3 --Farmer Ray (1)
step
    >>AoE the Hillsbrad Mobs in the area. Keep an eye out for Farmer Rey and Getz
    .complete 527,1 --Hillsbrad Farmer (6)
    .complete 527,2 --Hillsbrad Farmhand (6)
step
    >>Kill Citizen Wilkes. He patrols around the fields
    .complete 567,2 --Citizen Wilkes (1)
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
    .collect 17031,1 --Rune of Teleportation (1)
step
    .goto Undercity,57.30,32.76
    .trainer >> Train 1h Swords, Daggers
step << Undead Mage
    .goto Undercity,62.01,42.72
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
    .turnin 527 >>Turn in Battle of Hillsbrad
    .accept 528 >>Accept Battle of Hillsbrad
step
    .goto Hillsbrad Foothills,62.13,19.57
    .accept 546 >>Accept Souvenirs of Death
step
    .isQuestComplete 501
    .goto Hillsbrad Foothills,61.44,19.06
    .turnin 501 >>Turn in Elixir of Pain
    .accept 502 >>Accept Elixir of Pain
step
    .goto Hillsbrad Foothills,39.10,38.68
    >>AoE Lions en route to the fields. Loot them for their Blood
    .complete 501,1 --Mountain Lion Blood (10)
step
    .goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
step
    .isOnQuest 502
    >>Turn in the Elixir at Stanley. Kill him afterwards
    .goto Hillsbrad Foothills,32.66,35.32
    .turnin 502 >>Turn in Elixir of Pain
step
    #sticky
    #label Kalaba
    >>Kill Farmer Kalaba. She patrols around the southern field
    .complete 567,4 --Farmer Kalaba (1)
step
    #sticky
    #completewith next
    .goto Hillsbrad Foothills,35.29,46.83,0
    >>AoE the Peasants in the southern field
    .complete 528,1 --Hillsbrad Peasant (15)
step
    .xp 25 >> AoE all of the fields to 25
step
    >>Keep grinding until you've looted 30 skulls
    .complete 546,1 --Hillsbrad Human Skull (30)
    >>AoE the Peasants in the southern field
    .complete 528,1 --Hillsbrad Peasant (15)
step
    #requires Kalaba
	.hs >> If your hearth is up, hearth to Tarren Mill
    >> If your hearth is down, keep AoE farming until it's back up
    .vendor >> Buy level 25 drink from the Innkeeper once you hearthed
step
    .goto Hillsbrad Foothills,62.35,20.51
    .turnin 528 >>Turn in Battle of Hillsbrad
    .accept 529 >>Accept Battle of Hillsbrad
step
    .goto Hillsbrad Foothills,62.13,19.57
    .turnin 546 >>Turn in Souvenirs of Death
step
    .isOnQuest 501
    .goto Hillsbrad Foothills,61.44,19.06
    .turnin 501 >>Turn in Elixir of Pain
    .accept 502 >>Accept Elixir of Pain
    .accept 509 >>Accept Elixir of Agony
step
    .goto Hillsbrad Foothills,61.44,19.06
    .accept 509 >>Accept Elixir of Agony
step
    .goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
step
    #sticky
    #label Iron
    >>Loot the Shipment of Iron found within the Smith
    .goto Hillsbrad Foothills,32.00,45.44
    .complete 529,3 --Shipment of Iron (1)
step
    #sticky
    #completewith next
    >>Kill Blacksmith Verringtan and his Apprentices around the Smith
    .complete 529,1 --Blacksmith Verringtan (1)
    .complete 529,2 --Hillsbrad Apprentice Blacksmith (4)
step
    .xp 26 >> AoE all of the fields to 26
	>>Start saving the Wool Cloth you get. You need 12 stacks for later
step
    >>Kill Blacksmith Verringtan and his Apprentices around the Smith
    .complete 529,1 --Blacksmith Verringtan (1)
    .complete 529,2 --Hillsbrad Apprentice Blacksmith (4)
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
    .collect 17031,3 --Rune of Teleportation (3)
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
    .turnin 529 >>Turn in Battle of Hillsbrad
    .accept 532 >>Accept Battle of Hillsbrad
step
    #sticky
    >>Kill the Clerk. He's inside the Hall
    .complete 567,1 --Clerk Horrace Whitesteed (1)
step
    >>Kill the Councilmans. Be careful as they Frost Nova and Frostbolt
    .goto Hillsbrad Foothills,29.63,42.33
    .complete 532,2 --Hillsbrad Councilman (5)
step
    >>Single-target kill Burnside inside the Hall. Loot the book and Burn the scroll after
    .goto Hillsbrad Foothills,29.67,41.64
    .complete 532,1 --Magistrate Burnside (1)
    .goto Hillsbrad Foothills,29.52,41.53
    .complete 532,4 --Hillsbrad Town Registry (1)
    .goto Hillsbrad Foothills,29.73,41.75
    .complete 532,3 --Hillsbrad Proclamation destroyed (1)
step
    .xp 27 >> AoE all of the fields to 27
step
    .hs >> If your hearth is up, hearth to Tarren Mill. Otherwise, keep AoE farming
    .vendor >> Buy level 25 drink from the Innkeeper once you hearthed
step
    .turnin 532 >>Turn in Battle of Hillsbrad
    .accept 539 >>Accept Battle of Hillsbrad
step
    >>Loot the big blue mushrooms in the area.
    >>You can AoE the gnolls, but be careful of Shamans as they cast Lightning Bolt+Healing Wave (remember to use Counterspell)
    .goto Hillsbrad Foothills,63.70,61.59
    .complete 509,1 --Mudsnout Blossoms (6)
step
    .goto Hillsbrad Foothills,27.21,57.20,150 >> Run to Azurelode Mine
step
    #sticky
    #completewith next
    +It is HIGHLY Recommended you watch the Hillsbrad Mines section of the AoE guide, as it can be a bit tricky
    .link https://youtu.be/SxMc2GoP33c?t=555 >>CLICK HERE
step
    #sticky
    #label Hackett
    >>Kill Miner Hackett. He can be found all throughout the mine
    .complete 567,3 --Miner Hackett (1)
step
    #sticky
    #completewith next
    >>Kill Foreman Bonds. Be careful as he has a stun
    .goto Hillsbrad Foothills,31.20,56.02
    .complete 539,1 --Foreman Bonds (1)
step
    .xp 30 >> AoE mobs in the mine to Level 30
	>>Start saving the Wool Cloth you get. You need 12 stacks for later
    >>You can hearth back to Tarren Mill to buy more water+vendor trash if ever needed, then run back to the mine
step
    >>Kill 10 Miners inside the mine
    .complete 539,2 --Hillsbrad Miner (10)
step
    >>Kill Foreman Bonds. Be careful as he has a stun
    .goto Hillsbrad Foothills,31.20,56.02
    .complete 539,1 --Foreman Bonds (1)
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
    .collect 17031,4 --Rune of Teleportation (4)
step
    .goto Undercity,63.82,49.37
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
    .accept 676 >>Accept The Hammer May Fall
step
    .goto Hillsbrad Foothills,61.57,20.84
    .accept 544 >>Accept Prison Break In
    .accept 556 >>Accept Stone Tokens
step
    .goto Hillsbrad Foothills,62.38,20.56
    .turnin 539 >>Turn in Battle of Hillsbrad
    .turnin 567 >>Turn in Dangerous!
step
    .goto Hillsbrad Foothills,63.24,20.65
    .accept 533 >>Accept Infiltration
step
    .goto Hillsbrad Foothills,63.88,19.67
    .accept 552 >>Accept Helcular's Revenge
step
    .goto Hillsbrad Foothills,88.20,48.09,40,0
    .zone Arathi Highlands >>Run to Arathi Highlands
    
]],"Horde Mage")

RXPGuides.RegisterGuide("RestedXP Horde Mage AoE",[[
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
    .accept 655 >>Accept Hammerfall
step
    .goto Arathi Highlands,74.71,36.29
    .turnin 655 >>Turn in Hammerfall
    .accept 672 >>Accept Raising Spirits
    .accept 671 >>Accept Foul Magics
step
    #completewith next
    >>AoE raptors en route to Dabyrie Farmstead. Loot them for their eyes
    .complete 672,1 --Highland Raptor Eye (10)
step
    .goto Arathi Highlands,55.25,39.86,150 >> Run to Dabyrie's Farmstead
step
    #completewith next
    +Try and avoid pulling the named mobs just yet if possible. Marcel has Shield Wall (75% reduced damage), Fardel has ranged poison+Thrash, Kenata does nothing
    >>It is HIGHLY Recommended you watch the Arathi Section of the AoE guide, as it can be a bit tricky
    .link https://youtu.be/SxMc2GoP33c?t=555 >>CLICK HERE
step
    .xp 32 >> AoE the Dabyrie Farmstead to 32
	>>Start saving the Wool Cloth and Silk Cloth you get. You need 12 stacks for later
step
    >>AoE the named NPCs. Loot them for their heads
    .goto Arathi Highlands,56.56,38.69
    .complete 1164,3 --Fardel's Head (1)
    .goto Arathi Highlands,54.20,38.05
    .complete 1164,2 --Marcel's Head (1)
    .goto Arathi Highlands,56.41,36.09
    .complete 1164,1 --Kenata's Head (1)
--N telling people to do this maybe a bit early. Wrist reward is quite nice
step
    .zone Undercity >> Teleport to Undercity
step
    .goto Undercity,85.14,10.03
    .trainer >> Train your class spells
step
    .goto Undercity,82.79,15.82
    .vendor >> Go to Hannah. Buy some Runes of Teleportation
    .collect 17031,3 --Rune of Teleportation (3)
step
     #completewith next
    .goto Undercity,65.97,44.73
	+Bank your Wool Cloth and Silk Cloth here from earlier. You need 12 stacks of each (240) for later
step
    .goto Undercity,63.82,49.37
    .turnin 1164 >>Turn in To Steal From Thieves
step
    .goto Undercity,53.00,77.48,40,0
    .goto Undercity,48.82,69.28
    .turnin 513 >>Turn in Elixir of Agony
step
    .hs >> Hearth to Hammerfall
    .vendor >> vendor trash
step
   .goto Arathi Highlands,42.14,39.38
    >>AoE raptors en route to Dabyrie Farmstead. Loot them for their eyes
    .complete 672,1 --Highland Raptor Eye (10)
step
    .goto Arathi Highlands,55.25,39.86,150 >> Run to Dabyrie's Farmstead
step
    .xp 34 >> AoE the Dabyrie Farmstead to 34
	>>Start saving the Wool Cloth and Silk Cloth you get. You need 12 stacks for later
step
    >>Go in and around the cave. Start AoEing ogres
    .goto Arathi Highlands,32.93,44.02
    .complete 676,1 --Boulderfist Ogre (8)
    .complete 676,2 --Boulderfist Enforcer (10)
step
    >>Start AoEing Syndicates in the area. Try and avoid the Pathstalkers. Be careful of misspulling stealthed mobs
    .goto Arathi Highlands,32.32,28.58
    .complete 671,1 --Bloodstone Amulet (10)
step
    .zone Undercity >> Teleport to Undercity
step
    .goto Undercity,85.14,10.03
    .trainer >> Train your class spells
step
    .goto Undercity,82.79,15.82
    .vendor >> Go to Hannah. Buy some Runes of Teleportation
    .collect 17031,3 --Rune of Teleportation (3)
step
     #completewith next
    .goto Undercity,65.97,44.73
	+Bank your Wool Cloth and Silk Cloth here from earlier. You need 12 stacks of each (240) for later
step
    .hs >> Hearth to Hammerfall
    .vendor >> Buy level 35 drink from the Innkeeper once you hearthed
step
    .goto Arathi Highlands,74.26,33.93
    .turnin 676 >>Turn in The Hammer May Fall
step
    .goto Arathi Highlands,74.72,36.29
    .turnin 671 >>Turn in Foul Magics
    .turnin 672 >>Turn in Raising Spirits
    .accept 674 >>Accept Raising Spirits
step
    .goto Arathi Highlands,72.61,34.16
    .turnin 674 >>Turn in Raising Spirits
    .accept 675 >>Accept Raising Spirits
step
    .goto Arathi Highlands,74.72,36.29
    .turnin 675 >>Turn in Raising Spirits
--    .accept 701 >>Accept Guile of the Raptor
step
    .goto Arathi Highlands,73.02,32.70
    .fly Hillsbrad >> Fly to Tarren Mill
step
    .home >> Set your Hearth to Tarren Mill
    .goto Hillsbrad Foothills,62.78,19.03
step
    #sticky
    #completewith next
    +It is HIGHLY Recommended you watch the Alterac Section of the AoE guide
    .link https://youtu.be/SxMc2GoP33c?t=555 >>CLICK HERE
step
    >>AoE Syndicates. Loot them for the Missive
    .goto Alterac Mountains,58.35,67.49,120,0
    .goto Alterac Mountains,47.65,82.22,120,0
    .complete 533,1 --Syndicate Missive (1)
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
    .complete 552,1 --Helcular's Rod (1)
step
    #sticky
	#completewith Stonetoken
	>>AoE the Dalaran mobs. Loot them for Worn Stone Tokens
    .complete 556,1 --Collect Worn Stone Token (x10)
step
   >>Kill Alina. Loot her for the Shard. Kill Dermot, loot him for the Wedge 
	.goto Alterac Mountains,20.2,86.3
    .complete 544,3 --Collect Bloodstone Shard (x1)
    .complete 544,1 --Collect Bloodstone Wedge (x1)
step
   >>Go outside and kill Ricter. Loot him for the Marble
   .goto Alterac Mountains,19.7,84.6
    .complete 544,2 --Collect Bloodstone Marble (x1)
step
	#label Stonetoken
    >>Go into the second floor of the other building. Kill Kegan. Loot him for the Oval
    .goto Alterac Mountains,18.6,84.4,15,0
    .goto Alterac Mountains,17.8,83.2
    .complete 544,4 --Collect Bloodstone Oval (x1)
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
    .complete 556,1 --Collect Worn Stone Token (x10)
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
    .collect 17031,5 --Rune of Teleportation (5)
step
     #completewith next
    .goto Undercity,65.97,44.73
	+Bank your Silk Cloth here from earlier. You need 12 stacks of each (240) for later
step
    .hs >> Hearth to Tarren Mill
    .vendor >> Buy level 35 drink if needed
step
    .goto Hillsbrad Foothills,61.50,20.94
    .turnin 556 >>Turn in Stone Tokens
    .turnin 544 >>Turn in Prison Break In
    .accept 557 >>Accept Bracers of Binding
    .accept 545 >>Accept Dalaran Patrols
step
    .goto Hillsbrad Foothills,63.24,20.65
    .turnin 533 >>Turn in Infiltration
    .accept 503 >>Accept Gol'dir
step
    .goto Hillsbrad Foothills,63.88,19.66
    .turnin 552 >>Turn in Helcular's Revenge
step
    >>Find and kill Jailor Borhuin. Loot him for the Rusted Iron Key
    .goto Alterac Mountains,63.19,43.68,40,0
    .goto Alterac Mountains,62.11,40.43,40,0
    .goto Alterac Mountains,59.96,43.68,40,0
    .complete 503,2 --Rusted Iron Key (1)
    .unitscan Jailor Borhuin
step
    >>Go upstairs into the second floor of the inn
    .goto Alterac Mountains,60.64,43.89
    .complete 503,1 --Find where Gol'dir is being held (1)
    .turnin 503 >>Turn in Gol'dir
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
    .complete 545,1 --Dalaran Summoner (6)
    .complete 545,2 --Elemental Slave (12)
    .complete 557,1 --Bracers of Earth Binding (4)
step
    .hs >> Hearth to Tarren Mill
    .vendor >> Buy level 35 drink if needed
step
    .goto Hillsbrad Foothills,62.29,19.04
    .vendor >> Buy 3 Soothing Spices from Christoph on the first floor of the Inn
    .collect 3713,3 --Soothing Spices (3)
step
    .goto Hillsbrad Foothills,63.24,20.66
    .turnin 506 >>Turn in Blackmoore's Legacy
step
    .goto Hillsbrad Foothills,61.50,20.94
    .turnin 557 >>Turn in Bracers of Binding
    .turnin 545 >>Turn in Dalaran Patrols
step
    .zone Orgrimmar >> Teleport to Orgrimmar
step
    .goto Orgrimmar,45.11,63.91
    .fly Camp T >> Fly to Camp Taurajo
]],"Horde Mage")

RXPGuides.RegisterGuide("RestedXP Horde Mage AoE",[[
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
    .accept 1177 >>Accept Hungry!
step
    .goto Dustwallow Marsh,35.56,31.88
    .fp >> Get the Brackenwall Flight Path
step
    .goto Dustwallow Marsh,36.42,31.89
    .turnin 1251 >>Turn in The Black Shield
    .accept 1321 >>Accept The Black Shield
    .turnin 1268 >>Turn in Suspicious Hoofprints
    .turnin 1269 >>Turn in Lieutenant Paval Reethe
step
    .goto Dustwallow Marsh,36.53,30.79
    .turnin 1321 >>Turn in The Black Shield
step
    .goto Dustwallow Marsh,34.35,22.03
    .accept 1322 >>Accept The Black Shield
step
    >>Search for stealthed Theramore Infiltrators north-east of Brackenwall. AoE them if possible
    .goto Dustwallow Marsh,39.11,22.81,120,0
    .goto Dustwallow Marsh,38.99,27.55,120,0
    .goto Dustwallow Marsh,41.65,25.78,120,0
    .complete 1201,1 --Theramore Infiltrator (9)
step
    .goto Dustwallow Marsh,55.43,26.26
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
    .complete 1177,1 --Mirefin Head (12)
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
    .turnin 1177 >>Turn in Hungry!
step
    .goto Dustwallow Marsh,35.21,30.66
    .turnin 1201 >>Turn in Theramore Spies
    .turnin 1238 >>Turn in The Lost Report
step
    >>AoE Spiders in the area
    .goto Dustwallow Marsh,34.39,21.97
    .complete 1322,1 --Acidic Venom Sac (6)
    .complete 1206,1 --Unpopped Darkmist Eye (40)
step
    .goto Dustwallow Marsh,36.53,30.80
    .turnin 1322 >>Turn in The Black Shield
    .accept 1323 >>Accept The Black Shield
step
    .goto Dustwallow Marsh,36.42,31.89
    .turnin 1323 >>Turn in The Black Shield
step
    .goto Dustwallow Marsh,55.43,26.26
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
    .goto Tirisfal Glades,61.85,66.59,60 >> Exit Undercity
step << Undead
    .zone Tirisfal Glades >>Skip this step if you won't have 90g or more after vendoring trash
    .trainer >>Run into Tirisfal Glades and get your mount and mount training. 
    .goto Tirisfal Glades,59.93,52.57
step << Troll
    .zone Orgrimmar >> Teleport to Orgrimmar
    .trainer >> Train your class spells
step << Troll
    .zone Durotar >>Skip this step if you won't have 90g or more after vendoring trash
    .goto Durotar,55.21,75.53
    .trainer >>Run to out of Orgrimmar all the way down to Sen'jin and get your mount and mount training. 
step
    .hs >> Hearth to Camp Taurajo
>> Buy food/water if needed
step
    #hardcore
    .fly Brackenwall >> Fly to Brackenwall Village
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
    #completewith next
    .goto Thousand Needles,45.14,49.11,0
    .fp >> Get the Freewind Post Flight Path
    >>This is completely optional, as it is not used at all in the route, but is a convenient time to get it
step
    >>Travel to Tanaris. Ride through Barrens -> Thousand Needles -> Gadgetzan
    .goto Tanaris,52.51,27.91
    .home >> Set your hearth to Gadgetzan
step
    #softcore
    .goto Tanaris,51.42,28.75
    .accept 3042 >>Accept Troll Temper
    .vendor >> Vendor and Repair at Krinkle
step
    #softcore
    .goto Tanaris,50.21,27.48
    .accept 992 >>Accept Gadgetzan Water Survey
step
    #softcore
    .goto Tanaris,38.73,20.02,60 >> Travel to Zul'Farrak
step
    #softcore
    #completewith next
    +You're now going to be doing Zul'Farrak. This can be extremely difficult, but is absolutely worth the xp/hr once you learn to do it
    >>Click either of the links depending on whether or not you have a mount yet
    >>If you have no mount, as soon as you get 90g worth of loot, teleport back to Ironforge, go to Dun Morogh, and buy your mount. Hearth back to Gadgetzan << Gnome
    >>If you have no mount, as soon as you get 90g worth of loot, teleport back to Stormwind, Fly to Redridge, run to Eastvale, then go and buy your mount. Hearth back to Gadgetzan << Human
    .link https://youtu.be/TgwHw7qT4ws >> If you have a mount, CLICK HERE
    .link https://youtu.be/4-yJ47T728Y?t=6 >> If you DONT have a mount, CLICK HERE
step
    #softcore
    #sticky
    #label Temper
    >>Loot Troll Temper from the mobs you kill inside of Zul'Farrak
    .complete 3042,1 --Troll Temper (20)
step
    #softcore
    .xp 44 >> AoE Zul'Farrak to level 44
	>>Start saving the Silk Cloth and Mageweave Cloth you get. You need 12 stacks of each for later
step
    #hardcore
    .goto Tanaris,52.48,28.45
    .accept 1707 >>Accept Water Pouch Bounty
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
    +AoE some Bandits/Thieves in Noonshade Ruins en route to Steamwheedle Port
    .complete 1690,1 --Wastewander Bandit (10)
    .complete 1690,2 --Wastewander Thief (10)
step
    #hardcore
    .goto Tanaris,66.56,22.27
    .accept 8365 >>Accept Pirate Hats Ahoy!
step
    #hardcore
    .goto Tanaris,67.06,23.89
    .accept 8366 >>Accept Southsea Shakedown
step
    #hardcore
    .goto Tanaris,63.67,31.29
    >>AoE Bandits and Thieves. Loot them for Water Pouches
    >>Be careful as some of the mobs under the tents are bugged, and will evade all mobs aggroed onto you if you aggro one of them
    .complete 1690,1 --Wastewander Bandit (10)
    .complete 1690,2 --Wastewander Thief (10)
    .complete 1707,1 --Wastewander Water Pouch (5)
step
    #hardcore
    .goto Tanaris,52.48,28.45
    .turnin 1707 >>Turn in Water Pouch Bounty
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
    .complete 8365,1 --Southsea Pirate Hat (20)
step
    #hardcore  
    #sticky
	#label Andre
    >>Kill Andre Firebeard
    .complete 2875,1 --Firebeard's Head (1)
step
    #hardcore
    #sticky
    #completewith end
    >>Loot the Ship Schedule from the footlockers that drop from pirates in the area
    .collect 9250,1,2876 --Ship Schedule (1)
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
    .complete 8366,1 --Southsea Pirate (10)
    .complete 8366,2 --Southsea Freebooter (10)
    .complete 8366,3 --Southsea Dock Worker (10)
    .complete 8366,4 --Southsea Swashbuckler (10)
step
    #softcore
    #requires Temper
    .zone Undercity >> Teleport to Undercity
step
    #hardcore
    .zone Undercity >> Teleport to Undercity
step
    .goto Undercity,85.16,10.01
    .trainer >> Train your class spells
step
    .goto Undercity,82.79,15.82
    .vendor >> Talk to Hannah. Buy 6 Runes of Teleportation
    >>You can also go to the AH and buy bigger bags if you need
    .collect 17031,6 --Rune of Teleportation (6)
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
    .turnin 8365 >>Turn in Pirate Hats Ahoy!
step
    #hardcore
    .isOnQuest 2876
    .goto Tanaris,67.06,23.89
    .turnin 2875 >>Turn in WANTED: Andre Firebeard
    .turnin 2876 >>Turn in Ship Schedules
    .turnin 8366 >>Turn in Southsea Shakedown
step
    #hardcore
    .goto Tanaris,67.06,23.89
    .turnin 2875 >>Turn in WANTED: Andre Firebeard
    .turnin 8366 >>Turn in Southsea Shakedown
step
    #hardcore
    #label Caliph
        .goto Tanaris,62.22,37.75
    >>Look for Caliph Scorpidsting in the area. Kill and loot him for his head
    >>Be careful as he has two stealthed adds right next to him
   .complete 2781,1 --Caliph Scorpidsting's Head (1)
    .unitscan Caliph Scorpidsting
step
    #hardcore
    .goto Tanaris,73.72,46.86
    .xp 48 >> AoE grind to 48
    >>Use any Captain's Keys you get on the 2nd floor of the 2nd ship to the east
step
    #softcore
    .goto Tanaris,51.42,28.75
    .turnin 3042 >>Turn in Troll Temper
    .vendor >> Vendor and Repair at Krinkle
step
    #softcore
    .goto Tanaris,51.57,26.75
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
    .complete 992,1 --Tapped Dowsing Widget (1)
step
    #softcore
    #completewith next
    +You're now going to learn to do a harder version which takes longer, but gives more xp: Pulling scarabs.
    .link https://youtu.be/rFO4prcG2p0 >> CLICK HERE
step
    #softcore
    #sticky
	#label ScarabS
    >>Loot Scarab Shells inside of ZF after you've AoE'd them
    .complete 2865,1 --Uncracked Scarab Shell (5)
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
    .turnin 2781 >>Turn in WANTED: Caliph Scorpidsting
step
    #softcore
    .isQuestComplete 992
    .goto Tanaris,50.21,27.48
    .turnin 992 >>Turn in Gadgetzan Water Survey
step
    #softcore
    .goto Tanaris,51.57,26.75
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
    .turnin 992 >>Turn in Gadgetzan Water Survey
step
    #softcore
    .goto Tanaris,51.57,26.75
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
    .turnin 5405 >> Turn in Argent Dawn Commission
--P Add cauldron quests etc, probably also some quests in undercity to add
step
    .goto Tirisfal Glades,83.1,68.9
    .accept 5096 >>Accept Scarlet Diversions
step
	.goto Western Plaguelands,26.55,56.18
        >>Loot the crate next to the fire
        .collect 12814,1 --Flame in a Bottle (1)
step
	>> Be careful as the mobs are relatively difficult, and can chain-pull each other here
    >>Burn the command tent down, then use the banner in your inventory on top of it
    .goto Western Plaguelands,40.5,51.8
    .complete 5096,1 --Destroy the command tent and plant the Scourge banner in the camp (1)
step
    .goto Tirisfal Glades,83.1,68.9
    .turnin 5096 >>Turn in Scarlet Diversions
    .accept 5098 >>Accept All Along the Watchtowers
    .accept 5228 >>Accept The Scourge Cauldrons
step
    .goto Tirisfal Glades,83.03,71.91
    .turnin 5228 >>Turn in The Scourge Cauldrons
    .accept 5229 >>Accept Target: Felstone Field
step
    >>Kill Cauldron Lord Bilemaw. Loot him for the key
    .goto Western Plaguelands,37.12,57.18
    .complete 5229,1 --Felstone Field Cauldron Key (1)
    .unitscan Cauldron Lord Bilemaw
step
	>>Go to the top floor of the house. Talk to Janice
    .goto Western Plaguelands,38.40,54.05
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
    .turnin 5230 >>Turn in Return to the Bulwark
    .accept 5231 >>Accept Target: Dalson's Tears
step
    >>Kill Cauldron Lord Malvinous. Loot him for the key
    .goto Western Plaguelands,46.04,52.33
    .complete 5231,1 --Dalson's Tears Cauldron Key (1)
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
    .collect 12738,1 --Dalson Outhouse Key (1)
step
	#completewith UD58
    #label LockedAway
    #requires SkeletonKey
    .goto Western Plaguelands,48.16,49.64
    >>Click the outhouse. This will spawn a mob. Kill it
    .turnin 5059 >> Turn in Locked Away
    .collect 12739,1 --Dalson Cabinet Key (1)
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
    .collect 22526,30 --Collect Bone Fragments (30)
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
    .complete 5098,3 --Tower Three marked (1)
step
    .goto Western Plaguelands,26.65,55.18
    .vendor >> You should be Friendly with the Argent Dawn now, so buy as many Manna Biscuits as possible to last you to level 60
    >>If you're not, turn in scourgestones you looted until you are
step
    .goto Western Plaguelands,26.40,59.14
    .turnin 5232 >>Turn in Return to the Bulwark
    .accept 5233 >>Accept Target: Writhing Haunt
step
    .goto Western Plaguelands,26.68,59.59
    .accept 5901 >>Accept A Plague Upon Thee
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,42.28,66.05
    .complete 5098,2 --Tower Two marked (1)
step
    #label UD58
	.goto Western Plaguelands,46.49,52.15
    .xp 58 >> AoE Undead in the area to 58
step
    >>Kill Cauldron Lord Razarch. Loot him for the key
    .goto Western Plaguelands,53.07,65.97
    .complete 5233,1 --Writhing Haunt Cauldron Key (1)
step
    .goto Western Plaguelands,53.05,65.71
    .turnin 5233 >>Turn in Target: Writhing Haunt
    .accept 5234 >>Accept Return to the Bulwark
step
    .goto Western Plaguelands,53.73,64.66
    .accept 4984 >>Accept The Wildlife Suffers Too
step
    .zone Undercity >> Teleport to Undercity
step
    .goto Undercity,85.16,10.01
    .trainer >> Train your class spells
step
    .goto Undercity,67.62,44.16
    .turnin 5023 >>Turn in Better Late Than Never
    .accept 5049 >>Accept The Jeremiah Blues
step
	>>Under the staircase
    .goto Undercity,67.62,44.16
    .turnin 5049 >>Turn in The Jeremiah Blues
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
    .turnin 5234 >>Turn in Return to the Bulwark
    .accept 5235 >>Accept Target: Gahrron's Withering
step
    #phase 5
    #softcore
    #completewith next
    +You can now go and do ZG from 58-60. This is EXTREMELY hard, but is faster than open world aoe leveling if you're confident/already know how to do it
    .link https://youtu.be/lfgvyhmf3q4?t=7 >>CLICK HERE
step
	>>Go to the top floor of the house. Talk to Janice
    .goto Western Plaguelands,38.4,54.1
    .turnin 5050 >>Turn in Good Luck Charm
    .accept 5051 >>Accept Two Halves Become One
step
    .goto Western Plaguelands,38.0,54.7
	>>Find a Jabbering Ghoul. Kill him and loot the Good Luck Charm
    .complete 5051,1 --Good Luck Charm (1)
step
    .goto Western Plaguelands,38.4,54.1
    .turnin 5051 >>Turn in Two Halves Become One
step
    >>AoE Wolves in the area. You may need to kill spiders to force respawns on wolves
    .goto Western Plaguelands,47.14,44.80
    .complete 4984,1 --Diseased Wolf (8)
step
    .goto Western Plaguelands,53.72,64.66
    .turnin 4984 >>Turn in The Wildlife Suffers Too
    .accept 4985 >>Accept The Wildlife Suffers Too
step
    .abandon 4984 >> Abandon The Wildlife Suffers Too
step
    #sticky
    #label Grizzly
    >>AoE Grizzlys en route to other quests
    .complete 4985,1 --Diseased Grizzly (8)
step
    >>Kill Cauldron Lord Soulwraith. Loot him for the key
    .goto Western Plaguelands,62.80,58.76
    .complete 5235,1 --Gahrron's Withering Cauldron Key (1)
step
    .goto Western Plaguelands,62.59,58.55
    .turnin 5235 >>Turn in Target: Gahrron's Withering
    .accept 5236 >>Accept Return to the Bulwark
step
    #requires Grizzly
    .goto Western Plaguelands,67.33,24.23
    .accept 5542 >>Accept Demon Dogs
    .accept 5543 >>Accept Blood Tinged Skies
    .accept 5544 >>Accept Carrion Grubbage
step
	#label grubs
	#sticky
	>>AoE Carrion Worms
    .complete 5544,1 --Collect Slab of Carrion Worm Meat (x15)
step
	#label fordring1
	#sticky
    .goto Eastern Plaguelands,40.8,68.1,0
    >>AoE Plaguebots and Plaguehounds
    >>Be careful as Plaguebats can terrify
    .complete 5543,1 --Kill Plaguebat (x30)
    .complete 5542,1 --Kill Plaguehound Runt (x20)
step << skip
    .goto Eastern Plaguelands,26.54,74.74
    .accept 6022 >>Accept To Kill With Purpose
step
    .goto Eastern Plaguelands,36.5,90.8
    .accept 5149 >> Accept Pamela's Doll
step
    .goto Eastern Plaguelands,39.2,91.6
    >>Loot the 3 doll parts found on the floor throughout Darrowshire and then combine them together
    .complete 5149,1 --Collect Pamela's Doll (1)
step
    .goto Eastern Plaguelands,36.4,90.9
    .turnin 5149 >> Turn in Pamela's Doll
    .accept 5152 >> Accept Auntie Marlene
    .accept 5241 >> Accept Uncle Carlin
step
	#requires fordring1
    .goto Eastern Plaguelands,81.6,59.3
    .complete 5542,2 --Kill Plaguehound (5)
step
    #phase 5
    .goto Eastern Plaguelands,81.63,58.07
    .home >> Set your Hearth to Light's Hope Chapel
step
    #phase 5
    .goto Eastern Plaguelands,81.42,58.51
    .accept 9126 >> Accept Bonescythe Digs
step
    #phase 5
    .isQuestComplete 9126
    .turnin 9126 >> Turn in Bonescythe Digs
step
    .goto Eastern Plaguelands,81.6,59.3
    .fp Light's Hope Chapel >> Get the Light's Hope Chapel flight path
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
    .complete 5542,3 --Kill Frenzied Plaguehound (5)
step
    .goto Eastern Plaguelands,34.0,28.1
	>>Look for termite mounds around Plaguewood
    .complete 5901,1 --Collect Plagueland Termites (100)
step
	#sticky
	#completewith next
	+Drop any spare Plagueland Termites you have, if you have them (NOT the 100 stack)
step
    .goto Eastern Plaguelands,14.5,33.6
    .turnin 5281 >> Turn in The Restless Souls
step
	#requires grubs
	#label EPL1
    .goto Eastern Plaguelands,7.6,43.7--825-417
    .turnin 5542 >> Turn in Demon Dogs
    .turnin 5543 >> Turn in Blood Tinged Skies
    .turnin 5544 >> Turn in Carrion Grubbage
    .accept 5742 >> Accept Redemption
step
    #requires FPlague
	.goto Eastern Plaguelands,7.6,43.7
    >>Talk to Tirion
    .complete 5742,1 --Tirion's Tale
    .turnin 5742 >> Turn in Redemption
    .accept 5781 >> Accept Of Forgotten Memories
step
    .goto Eastern Plaguelands,27.4,84.9
    >>Enter the troll crypt
    .complete 6021,1 --Collect Zaeldarr's Head (x1)
step
    .goto Eastern Plaguelands,27.3,85.2
    .accept 6024 >> Accept Hameya's Plea
step
    .goto Eastern Plaguelands,28.4,86.6
    >>Summon Mercutio and his goons by clicking on the dirt pile, you have to kill him while handling 3 other adds
    >>Simply AoE them down as normal
    .complete 5781,1 --Collect Taelan's Hammer (x1)
step
    .goto Eastern Plaguelands,7.6,43.7
    .turnin 5781 >> Turn in Of Forgotten Memories
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
    .turnin 5236 >>Turn in Return to the Bulwark
step
    .goto Tirisfal Glades,83.30,72.33
    .turnin 5901 >>Turn in A Plague Upon Thee
    .accept 5902 >>Accept A Plague Upon Thee
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,40.15,71.50
    .complete 5098,1 --Tower One marked (1)
step
    .goto Western Plaguelands,49.2,78.6
    .turnin 5152 >> Turn in Auntie Marlene
    .accept 5153 >> Accept A Strange Historian
step
    .goto Western Plaguelands,49.6,76.8
	>>Loot the gravestone right outside the house
    .complete 5153,1 --Collect Joseph's Wedding Ring (x1)
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,46.73,71.14
    .complete 5098,4 --Tower Four marked (1)
step
    >>Go into the Inn. Try to avoid mobs en route
    .goto Western Plaguelands,39.5,66.9
    .turnin 5153 >> Turn in A Strange Historian
    .accept 5154 >> Accept The Annals of Darrowshire
--   .accept 4971 >> Accept A Matter of Time
step << skip
	#sticky
	#label parasites
    .goto Western Plaguelands,46.7,62.3
	>>Use the temporal displacer on the grain silos
    .complete 4971,1 --Kill Temporal Parasite (x10)
step
    .goto Western Plaguelands,43.4,69.6
	>>Loot books inside the Andorhal town hall until you get the correct one
    .complete 5154,1 --Collect Annals of Darrowshire (x1)
	*The correct book's pages has a lighter shade of grey on BOTH pages and sometimes the correct book won't spawn
	*If you're unlucky, you have to keep looting bad tomes until a good one spawns
step
	#requires parasites
    .goto Western Plaguelands,39.5,66.8
--    .turnin 4971 >> Turn in A Matter of Time
--    .accept 4972 >> Accept Counting Out Time
    .turnin 5154 >> Turn in The Annals of Darrowshire
    .accept 5210 >> Accept Brother Carlin
step << skip
    .goto Western Plaguelands,41.3,67.1
    >>Look for small lockboxes inside the burnt houses
    .complete 4972,1 --Collect Andorhal Watch (x5)
step << skip
    .goto Western Plaguelands,39.4,66.9
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
    .turnin 9126 >> Turn in Bonescythe Digs
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
step
    .goto Eastern Plaguelands,70.8,16.2
    >>Run past all the mobs up the hill, then go and kill Infiltrator Hameya, he walks around the shallow graves
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
    .complete 5181,2 --Collect Shattered Sword of Marduk (x1)
step
    .goto Eastern Plaguelands,28.1,86.1
    .turnin 6024 >> Turn in Hameya's Plea
step
    .goto Eastern Plaguelands,7.6,43.6
    .turnin 5845 >> Turn in Of Lost Honor
    .accept 5846 >> Accept Of Love and Family
step
    .goto Western Plaguelands,63.8,57.2
    >>Loot the shield on the ground, just outside the barn
    .complete 5168,2 --Collect Redpath's Shield (x1)
step
    .goto Western Plaguelands,65.7,75.4
    .turnin 5846 >> Turn in Of Love and Family
step
    .isQuestComplete 4985
    .goto Western Plaguelands,53.7,64.7
    .turnin 4985 >> Turn in The Wildlife Suffers Too
    .accept 4987 >> Accept Glyphed Oaken Branch
step
    .goto Western Plaguelands,48.4,31.9
    .turnin 5902 >> Turn in A Plague Upon Thee
    .accept 6390 >> Accept A Plague Upon Thee
step
    .goto Western Plaguelands,51.9,28.2
    .accept 6004 >> Accept Unfinished Business
step
    .goto Western Plaguelands,51.80,44.25,100,0
    .goto Western Plaguelands,40.53,51.79,100,0
    .complete 6004,1 --Scarlet Medic (2)
    .complete 6004,2 --Scarlet Hunter (2)
    .complete 6004,3 --Scarlet Mage (2)
    .complete 6004,4 --Scarlet Knight (2)
step
    .goto Western Plaguelands,51.9,28.1
    .turnin 6004 >> Turn in Unfinished Business
    .accept 6023 >> Accept Unfinished Business
step
    .goto Western Plaguelands,57.8,36.2
    .complete 6023,1 --Kill Huntsman Radley (x1)
step
    .goto Western Plaguelands,55.1,23.5
    >>Look for the named mob that patrols up and down the tower
    .complete 6023,2 --Kill Cavalier Durgen (x1)
    *There is a level 63 elite mob that can spawn at the tower, if that's the case just be patient and wait for Durgen to come down
step
    .goto Western Plaguelands,51.9,28.0
    .turnin 6023 >> Turn in Unfinished Business
    .accept 6025 >> Accept Unfinished Business
step
    .goto Western Plaguelands,45.7,18.8
    .complete 6025,1 --Climb the Tower
step
    #softcore
    .goto Western Plaguelands,42.5,18.9
    >>Loot the libram inside the town hall. Either slowly kill all the mobs one-by-one, or pull all of the mobs inside, kite them outside, freeze them in place, then loot the Libram and run
    >>do NOT die here or you have a very long run
    .complete 5168,1 --Collect Davil's Libram (x1)
    .link >> CLICK HERE for a guide
step
    #hardcore
    .goto Western Plaguelands,42.5,18.9
    >>Loot the libram inside the town hall. Either slowly kill all the mobs one-by-one, or pull all of the mobs inside, kite them outside, freeze them in place, then loot the Libram and run
    >>this quest is VERY difficult and risky. I wouldn't recommend doing this on hardcore
    .complete 5168,1 --Collect Davil's Libram (x1)
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
    .turnin 6025 >> Turn in Unfinished Business
step
    .goto Western Plaguelands,26.51,56.02
    .turnin 5098 >>Turn in All Along the Watchtowers
    .turnin 5238 >>Turn in Mission Accomplished!
    .accept 838 >>Accept Scholomance
step
    .goto Western Plaguelands,26.67,56.33
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
    .turnin 9126 >> Turn in Bonescythe Digs
step
    .goto Eastern Plaguelands,81.5,59.8
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
    .collect 2592,240 --Wool Cloth (240)
    .collect 4306,240 --Silk Cloth (240)
    .collect 4338,240 --Mageweave Cloth (240)
    .collect 14047,240 --Runecloth (240)
step
    >>Make sure you have no addons on that will automatically turn in extra runecloth (for rep) or you will be told to buy it again later
    .goto Undercity,71.65,29.25
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
    .collect 2592,180 --Wool Cloth (180)
    .collect 4306,180 --Silk Cloth (180)
    .collect 4338,180 --Mageweave Cloth (180)
    .collect 14047,180 --Runecloth (180)
step
    >>Make sure you have no addons on that will automatically turn in extra runecloth (for rep) or you will be told to buy it again later
    .goto Orgrimmar,63.62,51.24
    .turnin 7826 >> Turn in A Donation of Wool
    .turnin 7827 >> Turn in A Donation of Silk
    .turnin 7831 >> Turn in A Donation of Mageweave
    .turnin 7824 >> Turn in A Donation of Runecloth
step
    >>Make sure you have no addons on that will automatically turn in extra runecloth (for rep) or you will be told to buy it again later
    .goto Orgrimmar,37.69,87.92
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
    .collect 2592,600 --Wool Cloth (60)
    .collect 4306,60 --Silk Cloth (60)
    .collect 4338,60 --Mageweave Cloth (60)
    .collect 14047,60 --Runecloth (60)
step
    .goto Thunder Bluff,75.63,31.66
    .turnin 4987 >>Turn in Glyphed Oaken Branch
step
    >>Make sure you have no addons on that will automatically turn in extra runecloth (for rep) or you will be told to buy it again later
    .goto Thunder Bluff,43.05,42.73
    .turnin 7820 >> Turn in A Donation of Wool
    .turnin 7821 >> Turn in A Donation of Silk
    .turnin 7822 >> Turn in A Donation of Mageweave
    .turnin 7823 >> Turn in A Donation of Runecloth
step
    +Congratulations on level 60!
]],"Horde Mage")