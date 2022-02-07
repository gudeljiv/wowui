

RXPGuides.RegisterGuide("RestedXP Alliance Mage",[[
#classic
<< Alliance Mage
#name 21-22 Duskwood Mage AoE
#next 22-26 Wetlands Mage AoE
step
    .goto Duskwood,81.82,19.77
    .vendor >> Talk to Kzixx. Buy one of the green BoE belts (lower level = better). Buy potions too if any of these are available
step
     >>Follow the road down into Darkshire.
	.goto Duskwood,77.48,44.29
    .fp >> Get the Darkshire flight path
step
    #completewith next
    .goto Duskwood,78.00,48.34,0
    >> Buy a bronze tube from Herble if you didn't get one earlier
    .collect 4371,1 --Bronze Tube (1)
step
    >>If you didn't get a bronze tube, then you can do this later
    .goto Duskwood,79.80,48.03
    .accept 174 >>Accept Look To The Stars
    .turnin 174 >>Turn in Look To The Stars
    .accept 175 >>Accept Look To The Stars
step
    >>Inside the building
    .goto Duskwood,75.34,48.74
    .accept 163 >>Accept Raven Hill
    .accept 164 >>Accept Deliveries to Sven
    .accept 165 >>Accept The Hermit
step
	#sticky
	#label Eva
	>>Go into the building
    .goto Duskwood,75.80,45.35
    .accept 101 >>Accept The Totem of Infliction
step
	>>Go behind Eva
    .goto Duskwood,76.29,45.28
    .vendor >> Buy 2 Runes of Teleportation from Alyssa
    .collect 17031,2 --Rune of Teleportation (2)
step << skip
    .goto Duskwood,73.87,44.40
    .home >> Set your hearth in Darkshire
step
    #requires Eva
	>>Go into the Inn. Remember you need 50 skill in cooking to accept the quest
    .goto Duskwood,73.83,44.05
    .accept 90 >>Accept Seasoned Wolf Kabobs
step
    .goto Duskwood,73.57,46.85
    .accept 56 >>Accept The Night Watch
step
    >>If Stitches has just killed this npc, skip the quest.
    .goto Duskwood,45.12,67.03
    .accept 245 >>Accept Eight-Legged Menaces
step
    .goto Duskwood,18.22,56.22
    .turnin 163 >>Turn in Raven Hill
    .accept 5 >>Accept Jitters' Growling Gut
step
    #completewith next
    +start AoEing needed quest mobs in groups of 3+ that you see.
    >>Keep this tutorial open in another tab for the Duskwood AoE Section if needed:
    .link https://youtu.be/SxMc2GoP33c?t=376 >> CLICK HERE
step
    #completewith next
    >>Go to the shore. Start AoEing spiders en route to Sven's Camp
    .complete 245,1 --Pygmy Venom Web Spider (15)
    .complete 93,1 --Gooey Spider Leg (6)
step
    .goto Duskwood,7.80,34.05
    .turnin 164 >>Turn in Deliveries to Sven
    .accept 95 >>Accept Sven's Revenge
    .accept 226 >>Accept Wolves at Our Heels
step
    #completewith WolvesT
    >>Go to the shore. Start AoEing spiders en route to Sven's Camp. Loot them for Gooey Spider Legs
    .complete 245,1 --Pygmy Venom Web Spider (15)
    .complete 93,1 --Gooey Spider Leg (6)
step
   #sticky
   #label Wolves
   .goto Duskwood,54.66,14.53
    >>AoE Wolves all along the coast
    .complete 90,1 --Lean Wolf Flank (10)
    .complete 226,1 --Starving Dire Wolf (12)
    .complete 226,2 --Rabid Dire Wolf (8)
step
    .goto Duskwood,28.10,31.47
    .turnin 165 >>Turn in The Hermit
    .accept 148 >>Accept Supplies from Darkshire
step
    #requires Wolves
	#label WolvesT
    .goto Duskwood,7.72,33.21
    .turnin 226 >>Turn in Wolves at Our Heels
step
    .goto Duskwood,10.68,59.08
    >>Finish off Spiders and their Legs
    .complete 245,1 --Pygmy Venom Web Spider (15)
    .complete 93,1 --Gooey Spider Leg (6)
step
    >>Run to Westfall
    .goto Westfall,56.33,47.52
    .turnin 132 >>Turn in The Defias Brotherhood
    .accept 135 >>Accept The Defias Brotherhood
    .turnin 143 >>Turn in Messenger to Westfall
    .accept 144 >>Accept Messenger to Westfall
step
    .goto Westfall,56.55,52.64
    .fly Stormwind >> Fly to Stormwind City
step
    .goto Stormwind City,39.04,81.88,40,0
    .goto Stormwind City,36.93,81.97,40,0
    .goto Stormwind City,37.80,78.22,40,0
    .goto Stormwind City,37.80,81.93,10 >> Run up the mage tower, then run through the green portal
step
    .goto Stormwind City,36.87,81.15
    .trainer >> Train your class spells. Make sure you have at least 20 silver for later
step
    .goto Stormwind City,39.83,79.46
    .trainer >> Train the SW Portal
step
    #completewith next
    +Remember to bind Blink to your bars
step
    >>Run back through the green portal
    .goto Stormwind City,45.70,38.42
    .accept 343 >>Accept Speaking of Fortitude
step
	.goto Stormwind City,58.09,16.53
    .turnin 1338 >>Turn in Stormpike's Order
step
    .goto Stormwind City,69.55,28.10,30,0
    >>Run to the Stormwind Keep, then into the Library
    .goto Stormwind City,74.18,7.47
    .turnin 343 >>Turn in Speaking of Fortitude
    .accept 344 >>Accept Brother Paxton
step
    >>Go upstairs in SI:7
    .goto Stormwind City,75.52,55.18,20,0
    .goto Stormwind City,75.78,59.85
    .turnin 135 >>Turn in The Defias Brotherhood
step
    .goto Stormwind City,58.65,52.98,40,0
    .goto Stormwind City,64.19,60.60
    >> Buy Stormwind Seasoning Herbs from Felicia for the Lean Wolf Meat (Darkshire) quest
    .collect 2665,1 --Stormwind Seasoning Herbs (1)
step
    .goto Elwynn Forest,32.19,49.27,90 >> Exit Stormwind
step
    >>Run into Northshire Abbey
    .goto Elwynn Forest,45.50,48.25,40,0
    .goto Elwynn Forest,48.82,41.65,40,0
    .goto Elwynn Forest,49.60,40.41
    .turnin 344 >>Turn in Brother Paxton
    .accept 345 >>Accept Ink Supplies
step
    .hs >> Hearth to Lakeshire. Remember to buy drink if you need
>> Buy food/water if needed
step
    >>Go into the Town Hall
    .goto Redridge Mountains,29.50,46.05,30,0
    .goto Redridge Mountains,29.99,44.45
    .turnin 144 >>Turn in Messenger to Westfall
    .accept 145 >>Accept Messenger to Darkshire
step
    .goto Redridge Mountains,32.14,48.64
    .turnin 345 >>Turn in Ink Supplies
    .accept 347 >>Accept Rethban Ore
step
    >>Go into the cave. AoE Dredgers for Rethban Ore. They share respawns with Bashers
    >>Be careful as Dredgers attack fast, and Bashers bash and stun
    .goto Redridge Mountains,19.55,32.01,30,0
    .goto Redridge Mountains,19.04,23.48
    .complete 347,1 --Rethban Ore (5)
step
    >>Kill Yowler. Split pull him using Blizzard or Flamestrike, then kite him back through the path of mobs you killed
    .goto Redridge Mountains,19.55,32.01,30,0
    .goto Redridge Mountains,23.77,30.48,40,0
    .goto Redridge Mountains,27.58,21.78
    .complete 126,1 --Yowler's Paw (1)
--N Video
step
    .goto Redridge Mountains,30.98,47.28
    .turnin 126 >>Turn in Howling in the Hills
step
    .goto Redridge Mountains,30.59,59.41
    .fly Darkshire >> Fly to Darkshire
step
    #completewith next
    .goto Duskwood,78.00,48.34
    >> Buy a bronze tube from Herble if you didn't get one earlier
    .collect 4371,1 --Bronze Tube (1)
step
    >>If you didn't get a bronze tube, then you can do this later
    .goto Duskwood,79.80,48.03
    .accept 174 >>Accept Look To The Stars
    .turnin 174 >>Turn in Look To The Stars
    .accept 175 >>Accept Look To The Stars
step
    >>Inside the building
    .goto Duskwood,75.80,45.31
    .turnin 148 >>Turn in Supplies from Darkshire
    .accept 149 >>Accept Ghost Hair Thread
step
    >>Talk to Chef Grual
    .goto Duskwood,73.84,43.21
    .turnin 5 >>Turn in Jitters' Growling Gut
    .accept 93 >>Accept Dusky Crab Cakes
    .turnin 90 >>Turn in Seasoned Wolf Kabobs
    .turnin 93 >>Turn in Dusky Crab Cakes
    .accept 240 >>Accept Return to Jitters
step
    .goto Duskwood,72.81,46.83,20,0
    .goto Duskwood,71.93,46.42
    .turnin 145 >>Turn in Messenger to Darkshire
step
    >>Talk to Mary in the building. Try to avoid fighting mobs
    >>Check for the chest in the area near the house/outhouse
    .isQuestComplete 174
    .goto Duskwood,81.77,59.38
    .turnin 149 >>Turn in Ghost Hair Thread
    .accept 154 >>Accept Return the Comb
    .turnin 175 >>Turn in Look To The Stars
    .accept 177 >>Accept Look To The Stars
step
    .goto Duskwood,81.77,59.37
    .turnin 149 >>Turn in Ghost Hair Thread
    .accept 154 >>Accept Return the Comb
step
    >>Kill the Insane Ghoul. Outrange/Decurse its Curse of Blood, keep it slowed
    .complete 177,1 --Mary's Looking Glass (1)
    .goto Duskwood,80.87,71.58
step
    >>Kill mobs in the area
    .goto Duskwood,79.22,70.97
    .complete 56,1 --Skeletal Warrior (8)
    .complete 56,2 --Skeletal Mage (6)
step
    .goto Duskwood,79.80,48.01
    .turnin 177 >>Turn in Look To The Stars
    .accept 181 >>Accept Look To The Stars
step
    .goto Duskwood,75.80,45.32
    .turnin 154 >>Turn in Return the Comb
    .accept 157 >>Accept Deliver the Thread
step
    .goto Duskwood,73.58,46.91
    .turnin 56 >>Turn in The Night Watch
    .accept 57 >>Accept The Night Watch
step
    .xp 22 >> Grind to 22
step
    .zone Stormwind City >> Teleport to Stormwind
step
    >>Respec to AoE Frost (if you didn't talent into it originally)
    .goto Stormwind City,36.87,81.13
    .trainer >> Train your class spells
    >>MAKE SURE you save at least 30s for later (10s for another rune, 20s for IF tele)
step
    #completewith next
    .goto Stormwind City,55.30,68.18,40,0
    .goto Stormwind City,56.47,73.42,20 >> Bank your cloth here (to do cloth turnins for extra xp later)
    >>You'll eventually need 12 stacks of Wool, Silk, Mageweave and Runecloth
    >>BANK YOUR LIGHT FEATHERS HERE. THIS IS SUPER IMPORTANT
step
    #completewith next
    .goto Stormwind City,56.12,65.26
    .vendor >>Go into the building. Buy another Rune of Teleportation from Kyra
    .collect 17031,1 --Rune of Teleportation (1)
step
    .goto Elwynn Forest,32.19,49.27,90 >> Exit Stormwind
step
    >>Run into Northshire Abbey
    .goto Elwynn Forest,45.50,48.25,40,0
    .goto Elwynn Forest,48.82,41.65,40,0
    .goto Elwynn Forest,49.60,40.41
    .turnin 347 >>Turn in Rethban Ore
    .accept 346 >>Accept Return to Kristoff
step
    .zone Stormwind City >> Teleport to Stormwind
step
    >>Run to the outside of the Cathedral
    .goto Stormwind City,45.69,38.41
    .turnin 346 >>Turn in Return to Kristoff
step
    #completewith next
    .goto Stormwind City,63.68,8.49,30 >> Take the Deeprun Tram to Ironforge
step
    .zone Ironforge >> Travel to Ironforge
step
    .isOnQuest 968
    >>Go inside the building
    .goto Ironforge,51.08,8.04,20,0
    .goto Ironforge,50.84,5.64
    .turnin 968 >>Turn in The Powers Below
step
    .goto Ironforge,25.51,7.08
    .trainer >> Talk to Milstaff. Train the Ironforge Portal
step
    .goto Ironforge,55.51,47.75
    .fly Menethil >> Fly to Menethil
]],"Alliance Mage")

RXPGuides.RegisterGuide("RestedXP Alliance Mage",[[
#classic
<< Alliance Mage
#name 22-26 Wetlands Mage AoE
#next 26-31 Duskwood Mage AoE

step
    .goto Wetlands,8.32,58.57
    .accept 279 >>Accept Claws from the Deep
step
    #completewith next
    .vendor >> Buy an extra Rune of Teleportation from Falkan or Healing Potions from Dewin inside the house behind Falkan if needed
step
    .goto Wetlands,8.55,55.73
    .accept 484 >> Accept Young Crocolisk Skins
step
    .goto Wetlands,10.91,59.64
    .accept 463 >>Accept The Greenwarden
step
    >>Go Upstairs
    #completewith next
    .goto Wetlands,10.49,60.20
    .vendor >> Buy Healing Potions from Samor if needed
step
    .isQuestTurnedIn 741
    .goto Wetlands,10.84,60.44
    .turnin 942 >>Turn in The Absent Minded Prospector
    .accept 943 >>Accept The Absent Minded Prospector
step
    .goto Wetlands,10.70,60.95
    .home >> Set your hearth to Menethil Harbor
step
    .goto Wetlands,11.80,57.99
    .accept 470 >>Accept Digging Through the Ooze
step
    .goto Wetlands,11.50,52.13
    .accept 305 >>Accept In Search of The Excavation Team
step
    #sticky
    #label Skins
    >>AoE Young Crocolisks. Loot them for their skins
    .complete 484,1 --Young Crocolisk Skin (4)
step
    >>Run to the Raptor Excavation site
    .goto Wetlands,34.51,41.70,60,0
    .goto Wetlands,37.02,43.82,40,0
    .goto Wetlands,37.17,48.09,40,0
    .goto Wetlands,38.19,50.90
    .accept 294 >>Accept Ormer's Revenge
step
    >>Go into the cave. do NOT loot the fossil yet
    .goto Wetlands,38.81,52.39
    .turnin 305 >>Turn in In Search of The Excavation Team
    .accept 306 >>Accept In Search of The Excavation Team
step
    >>Go back onto the main road and follow it east
    .goto Wetlands,34.51,41.70,100,0
    .goto Wetlands,49.92,39.37
    .accept 469 >>Accept Daily Delivery
step
    #completewith next
    .goto Wetlands,50.20,37.73,0
    .vendor >> Buy Healing Potions from Kixxle if you have money
step
    .goto Wetlands,56.32,40.41
    .turnin 463 >>Turn in The Greenwarden
    .accept 276 >>Accept Tramping Paws
step
    #completewith next
    +It is HIGHLY Recommended you watch the Wetlands Section of the AoE guide, as the gnoll section can be a bit tricky (especially for new AoE mage players)
    .link https://youtu.be/SxMc2GoP33c?t=555 >>CLICK HERE
step
    .goto Wetlands,63.97,63.30,120,0
    .goto Wetlands,62.69,69.21,120,0
    .goto Wetlands,55.86,74.99,120,0
    .goto Wetlands,61.64,72.37,120,0
    .goto Wetlands,63.97,63.30,120,0
    .goto Wetlands,62.69,69.21,120,0
    .goto Wetlands,55.86,74.99,120,0
    .goto Wetlands,61.64,72.37,120,0
    >>Run back and forth between the four main gnoll camps, AoEing them all down
    .complete 276,1 --Mosshide Gnoll (15)
    .complete 276,2 --Mosshide Mongrel (10)
step
    .xp 24 >> AoE the gnolls all the way until level 24
step
    .goto Wetlands,56.32,40.41
    .turnin 276 >>Turn in Tramping Paws
    .accept 277 >>Accept Fire Taboo
step
    #requires Skins
    .trainer >> Teleport back to Stormwind or Ironforge, and train your level 24 class spells
step
    #completewith next
	.goto Ironforge,35.92,60.15,0
    +If you have a couple of stacks of wool/silk cloth, go to the bank and bank it
step
    .hs >> Hearth to Menethil
    >> Buy food/water if needed
step
    >>Buy a Flagon of Mead from the Innkeeper
    >>Also buy some level 25 drink down to 20 silver
    .goto Wetlands,10.69,60.95
    .complete 288,1 --Flagon of Mead (1)
step
    .goto Wetlands,10.90,59.63
    .accept 288 >>Accept The Third Fleet
    .turnin 288 >>Turn in The Third Fleet
    .accept 289 >>Accept The Cursed Crew
step
    >>Have at least 2 runes of teleportation. If you don't, buy some from Falkan
    >>Remember to buy healing potions from Dewin in the building behind him too if needed
    .goto Wetlands,8.33,56.45
    .collect 17031,2 --Rune of Teleportation (2)
step
    >>Go into the Barracks. Talk to Stoutfist
    .goto Wetlands,9.86,57.49
    .accept 464 >>Accept War Banners
step
    .goto Wetlands,11.50,52.13
    .turnin 306 >>Turn in In Search of The Excavation Team
step
    .goto Wetlands,15.84,40.19,70,0
    .goto Wetlands,19.65,40.08,70,0
    .goto Wetlands,15.84,40.19,70,0
    .goto Wetlands,19.65,40.08,70,0
    >>AoE the murlocs in the area. Be careful as they have frost resistance, so save your cold snap for a big blizzard pull
    >>If Cold Snap is down, kill the rest of the murlocs with relative safety using Arcane Explosion spam if frost nova gets resisted on pull (refer to video)
    .complete 279,1 --Bluegill Murloc (12)
    .complete 279,2 --Gobbler's Head (1)
    .unitscan Gobbler
step
    .goto Wetlands,45.98,34.17
    >>AoE some of the gnolls en route back to the gnolls you grinded from 22-24. Loot them for some of the flint needed
    >>Trappers Net, Fenrunners run fast and at higher hp (25%), and brutes hit very hard
    .collect 2611,5 --Crude Flint (5)
step
    #sticky
    #completewith next
    .goto Wetlands,64.69,55.48,0
    >>Also start AoEing the small Fenrunner pull at the trees just north of the northern-most AoE-able gnoll camp until you have all of your Flint
    .complete 277,1 --Crude Flint (9)
step
    .goto Wetlands,63.97,63.30,120,0
    .goto Wetlands,62.69,69.21,120,0
    .goto Wetlands,55.86,74.99,120,0
    .goto Wetlands,61.64,72.37,120,0
    >>Run back and forth between the four main gnoll camps, AoEing them all down
    .xp 25 >> AoE the gnolls all the way until level 25
step
    .goto Wetlands,45.98,34.17
    >>Finish off getting the flint from the Gnolls
    >>Trappers Net, Fenrunners run fast and at higher hp (25%), and brutes hit very hard
    .collect 2611,9 --Crude Flint (9)
step
     >>Keep AoEing the gnolls until you have less than 2 minutes on your Hearthstone cd
    .goto Wetlands,56.36,40.48
    .turnin 277 >>Turn in Fire Taboo
    .accept 275 >>Accept Blisters on the Land
step
    .hs >> Hearth to Menethil Harbor
    >> Buy food/water if needed
step
    .goto Wetlands,10.69,60.95
    .vendor >>Buy some level 25 drink from the Innkeeper
    >>Remember to Conjure level 15 food instead of buying it (and DONT buy level 25 food)
step
    .goto Wetlands,8.33,58.58
    .turnin 279 >>Turn in Claws from the Deep
    .accept 281 >>Accept Reclaiming Goods
step
    .goto Wetlands,8.55,55.73
    .turnin 484 >>Turn in Young Crocolisk Skins
    .accept 471 >>Accept Apprentice's Duties
step
    >>Click on the Crate
    .goto Wetlands,13.51,41.39
    .turnin 281 >>Turn in Reclaiming Goods
    .accept 284 >>Accept The Search Continues
step
    >>Click on the barrel (5s casttime on opening it)
    .goto Wetlands,13.62,38.20
    .turnin 284 >>Turn in The Search Continues
    .accept 285 >>Accept Search More Hovels
step
    >>Click on the barrel
    .goto Wetlands,13.94,34.80
    .turnin 285 >>Turn in Search More Hovels
    .accept 286 >>Accept Return the Statuette
step
    #completewith next
    +I suggest looking at the pulls for the undead here, as they can be extremely tricky
    >>Mobs can be 3 levels above, and you have water disadvantage. There is a cheese aoe spot on the first boat you can abuse however
    .link https://youtu.be/SxMc2GoP33c?t=899 >> CLICK HERE
step
    #sticky
    #label Snuffbox
    >>Kill Snellig at the bottom of the first ship. Loot him for his Snuffbox
    .goto Wetlands,13.82,30.18
    .complete 289,3 --Snellig's Snuffbox (1)
step
    .goto Wetlands,13.93,29.75,60,0
    .goto Wetlands,14.75,23.95,60,0
    .goto Wetlands,13.93,29.75,60,0
    .goto Wetlands,14.75,23.95,60,0
    .complete 289,1 --Cursed Sailor (13)
    .complete 289,2 --Cursed Marine (5)
step
    #sticky
    #completewith Ormer
    >>Kill the stealthed Fen Creepers found in the shallow parts of the inland water
    .complete 275,1 --Fen Creeper (12)
step
    #requires Snuffbox
    >>Kill Giant Crocolisks all along the coast. Loot them for their skins
    >>Be careful as they Tendon Rip (really long movespeed slow ability)
    .goto Wetlands,16.55,27.67,70,0
    .goto Wetlands,25.72,20.22,70,0
    .complete 471,1 --Giant Crocolisk Skin (6)
step
    .isOnQuest 943
    #sticky
    #label Relu
    >>AoE Raptors for the Stone of Relu
    .complete 943,1 --Stone of Relu (1)
step
    >>AoE the raptors in the area
    .goto Wetlands,29.35,45.02,70,0
    .goto Wetlands,22.96,55.77,70,0
    .complete 294,1 --Mottled Raptor (10)
    .complete 294,2 --Mottled Screecher (10)
step
    #label Ormer
    .goto Wetlands,38.17,50.89
    .turnin 294 >>Turn in Ormer's Revenge
    .accept 295 >>Accept Ormer's Revenge
step
    .isOnQuest 943
    >>Go into the cave. Loot the fossil on the ground
    .goto Wetlands,38.81,52.39
    .accept 299 >>Accept Uncovering the Past
    .complete 943,2 --Flagongut's Fossil (1)
step
    >>Go into the cave
    .goto Wetlands,38.81,52.39
    .accept 299 >>Accept Uncovering the Past
step
    #sticky
    #label Relics
    >>Loot the relics found within the Excavation Site. They can be found all over (even up to where Sarltooth is)
    .complete 299,1 --Ados Fragment (1)
    .complete 299,2 --Modr Fragment (1)
    .complete 299,3 --Golm Fragment (1)
    .complete 299,4 --Neru Fragment (1)
step
    .goto Wetlands,34.81,44.02,80,0
    .goto Wetlands,32.62,50.73,80,0
    .complete 295,1 --Mottled Scytheclaw (10)
    .complete 295,2 --Mottled Razormaw (10)
step
    #requires Relics
    >>Kite Sarltooth all the way back to Ormer without killing him until you pick up the next quest if you can, otherwise just turn in
    .goto Wetlands,38.18,50.89
    .turnin 295 >>Turn in Ormer's Revenge
    .accept 296 >>Accept Ormer's Revenge
step
    >>Kill Sarltooth. Loot him for his Talon. He's found on the south-eastern part of the site, up the mountain
    .goto Wetlands,33.11,51.40
    .complete 296,1 --Sarltooth's Talon (1)
step
    .goto Wetlands,38.18,50.89
    .turnin 296 >>Turn in Ormer's Revenge
step
    >>Go into the cave
    .goto Wetlands,38.81,52.39
    .turnin 299 >>Turn in Uncovering the Past
step
    #sticky
    #label Creeperawman
    >>Kill the stealthed Fen Creepers found in the shallow parts of the inland water
    .complete 275,1 --Fen Creeper (12)
step
    .isOnQuest 943
    #requires Relu
    >>Run out of the Site to Ironbeard's Tomb. AoE Oozes. Loot them for Sida's Bag
    .goto Wetlands,44.07,26.67
    .complete 470,1 --Sida's Bag (1)
step
    >>Run out of the Site to Ironbeard's Tomb. AoE Oozes. Loot them for Sida's Bag
    .goto Wetlands,44.07,26.67
    .complete 470,1 --Sida's Bag (1)
step
    #requires Creeperawman
    >>Run to the orc area. AoE them for their War Banners
    >>Be careful as they attack fast, net, and have higher fire resistance
    .goto Wetlands,43.71,43.98
    .complete 464,1 --Dragonmaw War Banner (8)
step
    .goto Wetlands,56.36,40.48
    .turnin 275 >>Turn in Blisters on the Land
step
    .hs >> Hearth to Menethil Harbor
    >> Buy food/water if needed
step
    #completewith Crew
    .vendor >> Remember to buy level 25 drink/Healing Potions if needed. But save some money for level 26 training later
step
   .isOnQuest 943
   .goto Wetlands,10.84,60.43
   >>Go upstairs
    .turnin 943 >>Turn in The Absent Minded Prospector
step
    #label Crew
	.goto Wetlands,10.91,59.63
    .turnin 289 >>Turn in The Cursed Crew
    .accept 290 >>Accept Lifting the Curse
step
    .goto Wetlands,11.80,57.99
    .turnin 470 >>Turn in Digging Through the Ooze
step
    >>Go inside the barracks
    .goto Wetlands,9.86,57.49
    .turnin 464 >> Turn in War Banners
    .accept 465 >>Accept Nek'rosh's Gambit
step
    .goto Wetlands,8.57,55.73
    .turnin 471 >>Turn in Apprentice's Duties
step
    #completewith next
    .vendor >> Make sure you have at least 2 runes of teleportation from Falkan
    .collect 17031,2 --Rune of Teleportation (2)
step
    .goto Wetlands,8.32,58.58
    .turnin 286 >>Turn in Return the Statuette
step
    .xp 26
step
    .zone Stormwind City >> Teleport to Stormwind
step
    >>Talk to Jennea
    .goto Stormwind City,38.62,79.30
    .accept 1939 >>Accept High Sorcerer Andromath
    .trainer >> Train your level 26 spells
step
    >>Go through the green portal, then turnin immediately on your left
    .goto Stormwind City,37.53,81.65
    .turnin 1939 >>Turn in High Sorcerer Andromath
    .accept 1938 >>Accept Ur's Treatise on Shadow Magic
step
    #completewith next
    +Bank cloth and/or buy more runes of teleportation if needed
    >>You'll eventually need 12 stacks of Wool, Silk, Mageweave and Runecloth
step
    .goto Stormwind City,66.28,62.14
    .fly Redridge >> Fly to Redridge
]],"Alliance Mage")

RXPGuides.RegisterGuide("RestedXP Alliance Mage",[[
#classic
<< Alliance Mage
#name 26-31 Duskwood Part 2 Mage AoE
#next 31-33 Hillsbrad Mage AoE

step
    .goto Redridge Mountains,26.76,46.40
    .accept 180 >>Accept Wanted: Lieutenant Fangore
step
    .goto Redridge Mountains,29.72,44.27
    .accept 91 >>Accept Solomon's Law
step
    #sticky
    #label Pendants
    >>AoE gnolls. Loot them for Shadowhide Pendants
    .complete 91,1 --Shadowhide Pendant (10)
step
    >>Kill Lieutenant Fangore. Be careful as he pulls as a pack of 3. You can split pull them all with Blizzard if needed
    >>Loot his paw
    .goto Redridge Mountains,80.17,37.08
    .complete 180,1 --Fangore's Paw (1)
step
    #requires Pendants
	>>Go to the top floor of the tower. Loot the Blue book sticking out of the bookcase
    >>Do not pull Morganth. Be careful as the Servants have high Arcane resistance and Mana burn
    >>Be careful of the slayers, as they execute you when you're below 20% hp
    .goto Redridge Mountains,78.88,47.66
    .complete 1938,1 --Ur's Treatise on Shadow Magic (1)
step
    .zone Stormwind City >> Teleport to Stormwind
step
    >>Go through the green portal, on your left
    .goto Stormwind City,37.53,81.66
    .turnin 1938 >>Turn in Ur's Treatise on Shadow Magic
    .accept 1940 >>Accept Pristine Spider Silk
step
    .goto Stormwind City,66.28,62.14
    .fly Darkshire >> Fly to Duskwood
step
    >>Inside the house
    .goto Duskwood,75.79,45.30
    .accept 66 >>Accept The Legend of Stalvan
--N TEST TIMINGS OF REDRIDGE VS JUST PURE DUSKWOOD GRIND
step
    .goto Duskwood,75.30,48.04
    .accept 173 >>Accept Worgen in the Woods
step
    .home >> Set your hearth to Darkshire
    .goto Duskwood,73.87,44.41
step
    .goto Duskwood,72.53,46.85
    .turnin 66 >>Turn in The Legend of Stalvan
    .accept 67 >>Accept The Legend of Stalvan
step
    >>Run to the Defias Farm. Click the dirt mound
    >>Be careful as there are stealthed mobs around that slow, and mobs can run easily through the wall into the barn and awkwardly pull mobs
    .goto Duskwood,49.86,77.72
    .turnin 95 >>Turn in Sven's Revenge
    .accept 230 >>Accept Sven's Camp
step
    .isOnQuest 245
    >>If Stitches has killed the questgiver, skip this and turn in some other time
    .goto Duskwood,45.12,67.03
    .turnin 245 >>Turn in Eight-Legged Menaces
step
    >>AoE spiders for Pristine Spider Silk and Vials of Spider Venom en route to Abercrombie
    .goto Duskwood,31.70,41.98
    .complete 101,2 --Vial of Spider Venom (5)
    .complete 1940,1 --Pristine Spider Silk (8)
step
    .goto Duskwood,28.11,31.46
    .turnin 157 >>Turn in Deliver the Thread
    .accept 158 >>Accept Zombie Juice
step
    >>AoE all the nearby ghouls en route
    .goto Duskwood,7.81,34.06
    .turnin 230 >>Turn in Sven's Camp
    .accept 262 >>Accept The Shadowy Figure
step
    #completewith next
    >>Keep an eye out for the Old History Book that drops from humanoids in the zone
    .collect 2794,1,337
    .accept 337 >> Accept An Old History Book
step
    #completewith next
    >>AoE kill some Fiends and Horrors until you have 4 minutes left on your hearthstone. Kill other mobs if you're waiting on respawns
    .complete 57,1 --Skeletal Fiend (15)
    .complete 57,2 --Skeletal Horror (15)
    .complete 101,3 --Skeleton Finger (10)
step
    .goto Duskwood,18.14,56.47
    .turnin 240 >>Turn in Return to Jitters
step
    >>Run all the way west into Westfall. Go into the Moonbrook Schoolhouse and open the footlocker on the ground
    .goto Westfall,41.51,66.72
    .turnin 67 >>Turn in The Legend of Stalvan
    .accept 68 >>Accept The Legend of Stalvan
step
    .hs >> Hearth to Darkshire
    >> Buy food/water if needed
step
    .goto Duskwood,75.81,45.32
    .turnin 262 >>Turn in The Shadowy Figure
    .accept 265 >>Accept The Shadowy Search Continues
step
    .isQuestComplete 57
    .goto Duskwood,73.56,46.88
    .turnin 57 >>Turn in The Night Watch
    .accept 58 >>Accept The Night Watch
step
    .goto Duskwood,72.52,46.85
    .turnin 68 >>Turn in The Legend of Stalvan
    .accept 69 >>Accept The Legend of Stalvan
    .turnin 265 >>Turn in The Shadowy Search Continues
    .accept 266 >>Accept Inquire at the Inn
step
    .goto Duskwood,73.78,44.49
    .turnin 266 >>Turn in Inquire at the Inn
    .accept 453 >>Accept Finding the Shadowy Figure
    .turnin 158 >>Turn in Zombie Juice
    .accept 156 >>Accept Gather Rot Blossoms
step
    #sticky
    #completewith Grave
    >>Keep an eye out for the Old History Book that drops from humanoids in the zone
    .collect 2794,1,337
    .accept 337 >> Accept An Old History Book
step
    >>Single target burst some Shadow Weavers
    .goto Duskwood,61.40,72.19
    .complete 173,1 --Nightbane Shadow Weaver (6)
step
    .isOnQuest 245
    .goto Duskwood,45.12,67.03
    .turnin 245 >>Turn in Eight-Legged Menaces
step
    .goto Duskwood,18.14,56.47
    .turnin 453 >>Turn in Finding the Shadowy Figure
    .accept 268 >>Accept Return to Sven
step
    .goto Duskwood,7.79,34.06
    .turnin 268 >>Turn in Return to Sven
    .accept 323 >>Accept Proving Your Worth
step
    #completewith next
    >>Kill any Skeletal Raiders you see en route. You can finish this later
    .complete 323,1 --Skeletal Raider (15)
step
    >>AoE kill Fiends and Horrors. Kill Ghouls as well whilst waiting for respawns for extra xp
    .goto Duskwood,22.61,46.53,90,0
    .goto Duskwood,24.97,33.58,90,0
    .goto Duskwood,14.43,43.54,90,0
    .goto Duskwood,15.35,48.15,90,0
    .goto Duskwood,22.61,46.53,90,0
    .goto Duskwood,24.97,33.58,90,0
    .goto Duskwood,14.43,43.54,90,0
    .goto Duskwood,15.35,48.15,90,0
    .complete 57,1 --Skeletal Fiend (15)
    .complete 57,2 --Skeletal Horror (15)
    .complete 101,3 --Skeleton Finger (10)
    .complete 156,1 --Rot Blossom (8)
step
    >>Kill Raiders primarily outside the crypt and near Morbent's house. Kill healers outside the crypt. Kill Warders inside the crypt
    >>Be careful of warders. They can ward themselves for fire/frost immunity (and it's not interruptable by Counterspell)
    .goto Duskwood,15.67,38.68,30,0
    .complete 323,1 --Skeletal Raider (15)
    .complete 323,2 --Skeletal Healer (3)
    .complete 323,3 --Skeletal Warder (3)
step
    .xp 28 >> Grind to 28 by aoeing skeletons/ghouls
step
    #sticky
    #label Grave
    .goto Duskwood,17.73,29.06
    >>Click on the grave
    .accept 225 >>Accept The Weathered Grave
step
    .goto Duskwood,7.78,34.06
    .turnin 323 >>Turn in Proving Your Worth
    .accept 269 >>Accept Seeking Wisdom
step
    #requires Grave
    >>Go inside the Goldshire Inn
    .goto Elwynn Forest,43.77,65.80
    .turnin 69 >>Turn in The Legend of Stalvan
    .accept 70 >>Accept The Legend of Stalvan
step
    >>Go upstairs. Loot the brown chest
    .goto Elwynn Forest,44.30,65.83
    .complete 70,1 --An Undelivered Letter (1)
step
    .zone Stormwind City >> Teleport to Stormwind
step
    .goto Stormwind City,36.86,81.13
    .trainer >> Train your class spells
step
    >>Go through the green portal. Run into the clothes shop. Turn in 
    >>Wait out the RP event then turn in again. Choose the Blouse
    .goto Stormwind City,41.56,76.32
    .turnin 1940 >>Turn in Pristine Spider Silk
    .turnin 1942 >>Turn in Astral Knot Garment
step
    .goto Stormwind City,29.53,61.93
    .turnin 70 >>Turn in The Legend of Stalvan
    .accept 72 >>Accept The Legend of Stalvan
    .goto Stormwind City,29.46,61.55
    .turnin 72 >>Turn in The Legend of Stalvan
    .accept 74 >>Accept The Legend of Stalvan
step
    #sticky
    #label Diplomat
    >>Talk to Thomas. He's a kid who patrols around the Cathedral
    .accept 1274 >>Accept The Missing Diplomat
step
    >>Go into Stormwind Cathedral
    .goto Stormwind City,42.62,33.59,30,0
    .goto Stormwind City,39.11,27.87
    .turnin 269 >>Turn in Seeking Wisdom
    .accept 270 >>Accept The Doomed Fleet
step
    #requires Diplomat
    >>Go into Stormwind Keep
    .goto Stormwind City,69.49,28.14,30,0
    .goto Stormwind City,78.28,25.39
    .turnin 1274 >>Turn in The Missing Diplomat
    .accept 1241 >>Accept The Missing Diplomat
step
    >>Go to the Library
    .isOnQuest 337
    .goto Stormwind City,74.19,7.44
    .turnin 337 >>Turn in An Old History Book
    .accept 538 >>Accept Southshore
step
    >>Leave Stormwind Keep. Go toward the front of Stormwind
    .goto Stormwind City,69.49,28.14,30,0
    .goto Stormwind City,73.17,78.42
    .turnin 1241 >>Turn in The Missing Diplomat
    .accept 1242 >>Accept The Missing Diplomat
step
    .goto Stormwind City,56.12,65.27
    >>Buy at least 3 runes of teleportation from Kyra
    .collect 17031,3 --Rune of Teleportation (3)
step
    >>Go into the cheese shop and talk to Elling Trias
    .goto Stormwind City,59.91,64.18
    .turnin 1242 >>Turn in The Missing Diplomat
    .accept 1243 >>Accept The Missing Diplomat
step
    .hs >> Hearth to Darkshire
    >> Buy food/water if needed
step
    .goto Duskwood,73.78,44.48
    .turnin 156 >>Turn in Gather Rot Blossoms
    .accept 159 >>Accept Juice Delivery
step
    #completewith next
    .goto Duskwood,74.08,44.83
    .vendor >> Buy 3 8 slot bags from Mabel Solaj if needed
step
    >>Talk to Watcher Backus. He patrols along the road north of Darkshire
    .goto Duskwood,74.58,41.38,60,0
    .goto Duskwood,72.18,37.09,60,0
    .goto Duskwood,73.47,31.84,60,0
    .goto Duskwood,74.58,41.38,60,0
    .goto Duskwood,72.18,37.09,60,0
    .goto Duskwood,73.47,31.84,60,0
    .turnin 1243 >>Turn in The Missing Diplomat
    .accept 1244 >>Accept The Missing Diplomat
    .unitscan Watcher Backus
step
    >>Run (blink on cooldown) all the way to Eastvale
    .goto Elwynn Forest,84.60,69.37
    .turnin 74 >>Turn in The Legend of Stalvan
    .accept 75 >>Accept The Legend of Stalvan
step
    >>Go inside the house, then upstairs. Loot the brown chest
    >>When you loot it, run from the mob back to Haggard
    .goto Elwynn Forest,85.70,69.54
    .complete 75,1 --A Faded Journal Page (1)
step
    .goto Elwynn Forest,84.60,69.38
    .turnin 75 >>Turn in The Legend of Stalvan
    .accept 78 >>Accept The Legend of Stalvan
step
    >>Blink all the way to Redridge
    .goto Redridge Mountains,29.72,44.27
    .turnin 91 >>Turn in Solomon's Law
    .turnin 180 >>Turn in Wanted: Lieutenant Fangore
step
    .goto Redridge Mountains,30.59,59.41
    .fly Darkshire >> Fly to Darkshire
step
    .goto Duskwood,75.75,47.57
    .turnin 173 >>Turn in Worgen in the Woods
    .accept 221 >>Accept Worgen in the Woods
step
    >>Go inside the Inn
    .goto Duskwood,73.78,44.49
    .turnin 78 >>Turn in The Legend of Stalvan
    .accept 79 >>Accept The Legend of Stalvan
step
    .goto Duskwood,73.56,46.88
    .turnin 79 >>Turn in The Legend of Stalvan
    .accept 80 >>Accept The Legend of Stalvan
    .turnin 57 >>Turn in The Night Watch
    .accept 58 >>Accept The Night Watch
step
    .goto Duskwood,72.53,46.86
    .turnin 80 >>Turn in The Legend of Stalvan
    .accept 97 >>Accept The Legend of Stalvan
step
    >>To the room on the left of Clerk Daltry
    .goto Duskwood,72.64,47.59
    .turnin 225 >>Turn in The Weathered Grave
    .accept 227 >>Accept Morgan Ladimore
step
    .goto Duskwood,73.56,46.91
    .turnin 97 >>Turn in The Legend of Stalvan
    .accept 98 >>Accept The Legend of Stalvan
    .turnin 227 >>Turn in Morgan Ladimore
    .accept 228 >>Accept Mor'Ladim
step
    >>AoE Nightbane Dark Runners. Be careful as they run faster than normal mobs (and hit hard)
    .goto Duskwood,63.96,51.35,70,0
    .goto Duskwood,60.83,40.72,70,0
    .complete 221,1 --Nightbane Dark Runner (12)
step
    >>Blink all the way over to Abercrombie
    .goto Duskwood,28.11,31.46
    .turnin 159 >>Turn in Juice Delivery
    .accept 133 >>Accept Ghoulish Effigy
step
    >>AoE any type of ghoul. Loot them for ribs
    >>Be careful of Brain Eaters as they have a disease that reduces mp5
    .goto Duskwood,23.59,35.15,50,0
    .goto Duskwood,25.62,34.46,50,0
    .goto Duskwood,24.76,29.16
    .complete 58,1 --Plague Spreader (20)
    .complete 101,1 --Ghoul Fang (10)
    .complete 133,1 --Ghoul Rib (7)
step
    .goto Duskwood,28.11,31.47
    .turnin 133 >>Turn in Ghoulish Effigy
    .accept 134 >>Accept Ogre Thieves
step
    >>Loot the strongbox inside of the house
    .goto Duskwood,23.92,72.08
    .complete 1244,1 --Defias Docket (1)
step
    >>Loot the wooden box just outside of the cave
    .goto Duskwood,33.42,76.37
    .complete 134,1 --Abercrombie's Crate (1)
step
    >>Go inside of the Ogre cave. Kill Zzarc'Vul
    .goto Duskwood,36.82,83.78
    .complete 181,1 --Ogre's Monocle (1)
    .unitscan Zzarc'Vul
step
    .goto Duskwood,28.11,31.47
    .turnin 134 >>Turn in Ogre Thieves
    .accept 160 >>Accept Note to the Mayor
step
    .hs >> Hearth to Darkshire
    >>If your hearthstone is still on cooldown, AoE grind ghouls until it comes back up
step
    >>Talk to Watcher Backus. He patrols along the road north of Darkshire
    .goto Duskwood,74.58,41.38,60,0
    .goto Duskwood,72.18,37.09,60,0
    .goto Duskwood,73.47,31.84,60,0
    .goto Duskwood,74.58,41.38,60,0
    .goto Duskwood,72.18,37.09,60,0
    .goto Duskwood,73.47,31.84,60,0
    .turnin 1244 >>Turn in The Missing Diplomat
    .accept 1245 >>Accept The Missing Diplomat
step
   >>Kill Stalvan Mistmantle. Loot him for his ring
   >>Be careful as he attacks quickly and deals a LOT of melee damage
   .goto Duskwood,77.35,36.19
    .complete 98,1 --Mistmantle Family Ring (1)
step
    .goto Duskwood,79.81,48.02
    .turnin 181 >>Turn in Look To The Stars
step
    .goto Duskwood,75.78,45.31
    .turnin 98 >>Turn in The Legend of Stalvan
    .turnin 101 >>Turn in The Totem of Infliction
step
    .goto Duskwood,75.68,47.66
    .turnin 221 >>Turn in Worgen in the Woods
    .accept 222 >>Accept Worgen in the Woods
step
    .goto Duskwood,73.58,46.89
    .turnin 58 >>Turn in The Night Watch
step
    >>Go inside the Keep
    .goto Duskwood,71.93,46.42
    .turnin 160 >>Turn in Note to the Mayor
    .accept 251 >>Accept Translate Abercrombie's Note
step
    .goto Duskwood,72.64,47.61
    .turnin 251 >>Turn in Translate Abercrombie's Note
    .accept 401 >>Accept Wait for Sirra to Finish
    .turnin 401 >>Turn in Wait for Sirra to Finish
    .accept 252 >>Accept Translation to Ello
step
    .goto Duskwood,71.93,46.43
    .turnin 252 >>Turn in Translation to Ello
    .accept 253 >>Accept Bride of the Embalmer
step
    #completewith NightbaneW
    +It is HIGHLY Recommended you watch the Worgen Duskwood Section of the AoE guide, as it's important to know the pathing you should take for doing the 4 main worgen camps
    .link https://youtu.be/SxMc2GoP33c?t=2450 >>CLICK HERE
step
    #sticky
    #label Book
    >>Keep an eye out for the Old History Book. If you don't have it yet, keep grinding for it
    .collect 2794,1,337
    .accept 337 >> Accept An Old History Book
step
    #label NightbaneW
	.goto Duskwood,72.74,71.83,120,0
    .goto Duskwood,61.98,81.51,120,0
    .goto Duskwood,61.25,75.17,120,0
    .goto Duskwood,63.63,51.01,120,0
    .goto Duskwood,72.74,71.83,120,0
    .goto Duskwood,61.98,81.51,120,0
    .goto Duskwood,61.25,75.17,120,0
    .goto Duskwood,63.63,51.01,120,0
    .complete 222,1 --Nightbane Vile Fang (8)
    .complete 222,2 --Nightbane Tainted One (8)
step
    .xp 31+40000 >> AoE grind the worgens to 31 & 40000/50800
step
    #requires Book
    .goto Duskwood,75.30,48.04
    .turnin 222 >>Turn in Worgen in the Woods
    .accept 223 >>Accept Worgen in the Woods
step
    >>Go inside
    .goto Duskwood,75.32,49.02
    .turnin 223 >>Turn in Worgen in the Woods
step
    .zone Stormwind City >> Teleport to Stormwind
step
    .goto Stormwind City,36.86,81.13
    .trainer >> Train your class spells
step
    >>Bottom of the mage tower
    .goto Stormwind City,39.83,81.46
    .accept 690 >>Accept Malin's Request
step
    .goto Stormwind City,56.47,73.41
    >>Bank your cloth. Take at least 1 Light Feather out of your bank. If there's none in the bank, buy some off the AH
    >>You'll eventually need 12 stacks of Wool, Silk, Mageweave and Runecloth
    .collect 17056,1 --Light Feather (1)
step
    >>Go to the upstairs of the cheese shop
    .goto Stormwind City,59.91,64.18
    .turnin 1245 >>Turn in The Missing Diplomat
    .accept 1246 >>Accept The Missing Diplomat
step
    >>When you handin the quest, this will start a 1v3 against you. Just frost nova and nuke Dashel
    .goto Stormwind City,70.11,47.72,20,0
    .goto Stormwind City,70.55,44.89
    .turnin 1246 >>Turn in The Missing Diplomat
    .accept 1447 >>Accept The Missing Diplomat
step
    .goto Stormwind City,70.55,44.89
    .complete 1447,1 --Defeat Dashel Stonefist (1)
    .turnin 1447 >>Turn in The Missing Diplomat
    .accept 1247 >>Accept The Missing Diplomat
step
    .goto Stormwind City,59.91,64.18
    .turnin 1247 >>Turn in The Missing Diplomat
    .accept 1248 >>Accept The Missing Diplomat
step
    >>Go to the Library
    .isOnQuest 337
    .goto Stormwind City,74.19,7.44
    .turnin 337 >>Turn in An Old History Book
    .accept 538 >>Accept Southshore
step
    .zone Ironforge >> Teleport to Ironforge
	.trainer >> Train your level 32 spells
step
    .goto Ironforge,55.50,47.74
    .fly Menethil >> Fly to Menethil
]],"Alliance Mage")

RXPGuides.RegisterGuide("RestedXP Alliance Mage",[[
#classic
<< Alliance Mage
#name 31-33 Hillsbrad Mage AoE
#next 33-60 Mage AoE

step
    >>Go inside the Wetlands Inn
    .goto Wetlands,10.58,60.59
    .turnin 270 >>Turn in The Doomed Fleet
    .accept 321 >>Accept Lightforge Iron
step
    >>Turning this in will make the NPC behind you start to run out of the Inn. Catch up to him
    .goto Wetlands,10.60,60.77
    .turnin 1248 >>Turn in The Missing Diplomat
    .accept 1249 >>Accept The Missing Diplomat
step
    >>Quickly run outside the Inn. Nova/Polymorph his friend, and nuke Tapoke
    .goto Wetlands,10.50,59.30
    .complete 1249,1 --Defeat Tapoke Jahn (1)
step
    >>Mikhail might be stuck in an rp animation, you may have to wait a few seconds
    .goto Wetlands,10.60,60.77
    .turnin 1249 >>Turn in The Missing Diplomat
step
    >>Talk to Tapoke behind you
    .goto Wetlands,10.55,60.26
    .accept 1248 >>Accept The Missing Diplomat
step
    .goto Wetlands,10.60,60.77
    .turnin 1248 >>Turn in The Missing Diplomat
    .accept 1264 >>Accept The Missing Diplomat
step
    >>Run out the inn, and swim over to the murlocs
    .goto Wetlands,12.11,64.20
    .turnin 321 >>Turn in Lightforge Iron
    .accept 324 >>Accept The Lost Ingots
step
    >>Single-target nuke the murlocs. Be careful as they net
    >>The droprate can be really bad on this quest
    .goto Wetlands,12.99,64.06,100,0
    .goto Wetlands,10.26,67.93,100,0
    .goto Wetlands,9.90,72.02,100,0
    .complete 324,1 --Lightforge Ingot (5)
step
    .goto Wetlands,10.85,55.90
    .accept 472 >>Accept Fall of Dun Modr
step
    >>Run up the back of the ship. Kill Captain Halyndor. Don't cast on him when he has the green shield around him, as it reflects spells
    .goto Wetlands,15.92,23.15,20,0
    .goto Wetlands,15.49,23.50
    .complete 290,1 --Intrepid Strongbox Key (1)
step
    >>Swim under the ship on the north side. Open the grey strongbox
    .goto Wetlands,14.36,24.04
    .turnin 290 >>Turn in Lifting the Curse
    .accept 292 >>Accept The Eye of Paleth
step
    >>Right click on the catapult
    .goto Wetlands,47.49,46.92
    .turnin 465 >>Turn in Nek'rosh's Gambit
--    .accept 474 >>Accept Defeat Nek'rosh
step << skip
    .goto Wetlands,53.48,54.78
    .complete 474,1 --Nek'rosh's Head (1)
step
    .goto Wetlands,49.80,18.26
    .turnin 472 >>Turn in Fall of Dun Modr
step
    .goto Wetlands,49.90,18.23
    .accept 631 >>Accept The Thandol Span
step
    >>Go into the doorway at the bridge. Avoid fighting mobs
    >>Loot the corpse on the bottom floor
    .goto Wetlands,51.30,8.11,20,0
    .goto Wetlands,51.28,7.96
    .turnin 631 >>Turn in The Thandol Span
    .accept 632 >>Accept The Thandol Span
step
    .goto Wetlands,49.90,18.23
    .turnin 632 >>Turn in The Thandol Span
    .accept 633 >>Accept The Thandol Span
step
    >>Cross the bridge into Arathi. Get on the edge of the broken bridge, then cast Slow Fall on yourself with the feather you took out the bank earlier. Jump across
    >>If you failed the jump, skip this quest
    >>Accepting this quest will start a 15 minute timer. Be quick and focused
    .goto Arathi Highlands,43.99,88.24,40,0
    .goto Arathi Highlands,42.91,91.46,20,0
    .goto Arathi Highlands,43.24,92.64
    .accept 647 >>Accept MacKreel's Moonshine
--N link the jump here
step
    >>Loot the letter near the dwarf corpse underwater
    .goto Arathi Highlands,44.29,92.89
    .collect 4433,1,637 --Waterlogged Envelope
    .accept 637 >>Accept Sully Balloo's Letter
step
    #completewith next
    .goto Arathi Highlands,52.5,90.4,45 >> Swim east toward the ramp here
step
    >>Click on the Wagon
    .goto Arathi Highlands,48.87,88.14
    .complete 633,1 --Cache of Explosives Destroyed (1)
step
    >>Run back to Wetlands
    .goto Arathi Highlands,46.25,88.14,40,0
    .goto Wetlands,49.92,18.20
    .turnin 633 >>Turn in The Thandol Span
    .accept 634 >>Accept Plea To The Alliance
step
    >>Run to Arathi
    .goto Arathi Highlands,45.83,47.56
    .turnin 634 >>Turn in Plea To The Alliance
step
    .goto Arathi Highlands,46.65,47.01
    .turnin 690 >>Turn in Malin's Request
step
    #completewith next
    .goto Arathi Highlands,46.34,47.03
    .vendor >>Buy potions from Drovnar if you want
step
    .goto Arathi Highlands,45.73,46.10
    .fp >> Get the Refuge Pointe Flight Path
step
    >>Run to Southshore, into the inn, then into the basement. If you fail the timed quest, abandon it and skip this step
    .goto Arathi Highlands,19.72,29.04,40,0
    .goto Hillsbrad Foothills,50.71,58.76,15,0
    .goto Hillsbrad Foothills,52.09,58.70
    .turnin 647 >>Turn in MacKreel's Moonshine
step
    >>go back upstairs
    .goto Hillsbrad Foothills,51.89,58.68
    .accept 555 >>Accept Soothing Turtle Bisque
step
    >>Go back out the Inn
    .goto Hillsbrad Foothills,50.34,59.05
    .accept 659 >>Accept Hints of a New Plague?
step
    .goto Hillsbrad Foothills,49.47,58.73
    .accept 500 >>Accept Crushridge Bounty
step
    .goto Hillsbrad Foothills,48.14,59.10
    .accept 505 >>Accept Syndicate Assassins
step
    .goto Hillsbrad Foothills,50.56,57.10
    .turnin 538 >>Turn in Southshore
step
    >>Go inside the building. Buy 4 soothing spices from Micha for quests later
    .goto Hillsbrad Foothills,48.93,55.02
    .collect 3713,4 --Soothing Spices (4)
step
    .goto Hillsbrad Foothills,49.34,52.27
    .fp >> Get the Southshore Flight Path
    .fly Menethil >> Fly to Menethil
step
    >>Run Into the inn
    .goto Wetlands,10.59,60.59
    .turnin 324 >> Turn in The Lost Ingots
    .accept 322 >>Accept Blessed Arm
    .turnin 292 >>Turn in The Eye of Paleth
    .accept 293 >>Accept Cleansing the Eye
step
    .zone Stormwind City >> Teleport to Stormwind City
step << skip
    .goto Stormwind City,36.86,81.13
    .trainer >> Train your class spells
step
    >>Go into Stormwind Cathedral
    .goto Stormwind City,42.62,33.59,30,0
    .goto Stormwind City,39.59,27.20
    .turnin 293 >>Turn in Cleansing the Eye
step
    >>Run to the Dwarven District
    .goto Stormwind City,51.76,12.08
    .turnin 322 >>Turn in Blessed Arm
    .accept 325 >>Accept Armed and Ready
step
    .goto Stormwind City,66.27,62.12
    .fly Westfall >> Fly to Westfall
step
    >>Go east to Duskwood
    .goto Duskwood,7.78,34.06
    .turnin 325 >>Turn in Armed and Ready
    .accept 55 >>Accept Morbent Fel
step
    >>Clear the mobs out inside the house. Equip Morbent's Bane in your inventory.
    >>Split pull the pack in Morbent's upstairs room with a blizzard, then kite him out the building. Use Morbent's bane on him
    >>Nuke him with Single Target
    .goto Duskwood,17.60,33.42,20,0
    .goto Duskwood,16.91,33.40
    .complete 55,1 --Morbent Fel (1)
--N Link
step
    >>Go to the big tree and pull Mor'Ladim when he patrols gets close. Kite him using Frostbolt and slowly kill him
    .goto Duskwood,21.66,40.73
    .complete 228,1 --Mor'Ladim's Skull (1)
--N Link
step
    >>Go to Eliza's Grave and summon her. Jump onto Abercrombie's shack behind you, and nuke Eliza down
    >>Use Frost Ward if you trained it. Loot Eliza for her heart
    .goto Duskwood,28.85,30.72
    .turnin 254 >> Turn in Digging Through the Dirt
    .complete 253,1 --The Embalmer's Heart (1)
step
    .goto Duskwood,7.79,34.07
    .turnin 55 >>Turn in Morbent Fel
step
    .hs >> Hearth to Darkshire
    >> Buy food/water if needed
step
    .goto Duskwood,73.57,46.88
    .turnin 228 >>Turn in Mor'Ladim
    .accept 229 >>Accept The Daughter Who Lived
step
    >>Go into the Town Keep
    .goto Duskwood,71.93,46.42
    .turnin 253 >>Turn in Bride of the Embalmer
step
    #sticky
    .destroy 3248 >>Throw away the Translated Letter from The Embalmer
step
    >>Turn in at Watcher Ladimore. She patrols the inner circle of Darkshire
    .goto Duskwood,75.02,45.51
    .turnin 229 >>Turn in The Daughter Who Lived
step
    .zone Ironforge >> Teleport to Ironforge
step
    >>You may need to wait out her short RP event
    .goto Ironforge,63.79,67.78
    .turnin 637 >>Turn in Sully Balloo's Letter
    .accept 683 >>Accept Sara Balloo's Plea
step
    .goto Ironforge,39.10,56.19
    .turnin 683 >>Turn in Sara Balloo's Plea
    .accept 686 >>Accept A King's Tribute
step
    #completewith next
    +Bank your cloth and light feathers if needed
step
    .goto Ironforge,38.75,87.04
    .turnin 686 >>Turn in A King's Tribute
    .accept 689 >>Accept A King's Tribute
step
    .goto Ironforge,55.50,47.74
    .fly Southshore >> Fly to Southshore
step
    >>Go into the Inn
    .goto Hillsbrad Foothills,51.17,58.92
    .home >> Set your hearth to Southshore
step
    .goto Hillsbrad Foothills,52.42,55.96
    .accept 564 >>Accept Costly Menace
step
    #completewith next
    .goto Hillsbrad Foothills,55.57,55.82,100 >> Run to the river leading up to Alterac
step
    #completewith next
    .goto Alterac Mountains,83.14,52.75,120,0
    >>AoE turtles along the river up north toward Western Plaguelands. You can get all 10 later if needed
    >>Note that Turtles have frost resistance, so use Arcane Explosion and backwards strafe to kill him. Watch the video for reference
    .link https://youtu.be/SxMc2GoP33c?t=3375 >> CLICK HERE
    .complete 555,1 --Turtle Meat (10)
step
    .goto Alterac Mountains,80.50,32.01,100,0
    .zone Western Plaguelands >> Travel to Western Plaguelands
step
    .goto Alterac Mountains,79.01,30.63
    .fp >> Get the Chillwind Camp Flight Path
step
    >>AoE ogres. Loot them for knucklebones
    >>Try and avoid the level 36 brutes, as they will resist too much
    .goto Alterac Mountains,45.32,61.65,120,0
    .goto Alterac Mountains,54.66,52.80,120,0
    .goto Alterac Mountains,45.32,61.65,120,0
    .goto Alterac Mountains,54.66,52.80,120,0
   .complete 500,1 --Dirty Knucklebones (9)
step
    #sticky
    #completewith Syndicate
    >>Kill Lions that you see. Focus on the Hulking ones if possible
    .complete 564,1 --Mountain Lion (8)
    .complete 564,2 --Hulking Mountain Lion (10)
step
    #sticky
    #label Plans
    >>Loot the plans from the table in the camp
    .goto Alterac Mountains,67.28,47.30,90,0
    .goto Alterac Mountains,58.32,67.92
    .accept 510 >>Accept Foreboding Plans
    .accept 511 >>Accept Encrypted Letter
step
    #label Syndicate
    >>AoE Syndicates in the area. Go up north and kill Ogres for knucklebones if you're waiting on respawns after clearing both camps
    .goto Alterac Mountains,58.32,67.92,100,0
    .goto Alterac Mountains,47.72,82.08,100,0
    .complete 505,1 --Syndicate Footpad (12)
    .complete 505,2 --Syndicate Thief (8)
step
    #requires Plans
    .goto Hillsbrad Foothills,43.1,28.0,24,0
    .goto Hillsbrad Foothills,43.9,31.4,24,0
    .goto Hillsbrad Foothills,44.1,29.0,24,0
    .goto Hillsbrad Foothills,43.6,30.2,24,0
    .goto Hillsbrad Foothills,43.0,32.9,24,0
    .goto Hillsbrad Foothills,41.6,31.9,24,0
    .goto Hillsbrad Foothills,45.1,28.3,24,0
    .goto Hillsbrad Foothills,45.2,25.2,24,0
    .goto Hillsbrad Foothills,46.3,31.9,24,0
    >>Loot the lighter, highlighted shards of granite against the wall. There can only be 2-3 up at a time (so you'll likely backtrack for spawns)
    >>AoE the Yetis in the area
	.complete 689,1 --Alterac Granite (5)
step
    .goto Alterac Mountains,39.08,92.32,150,0
    .goto Hillsbrad Foothills,35.25,23.37
    >>AoE Lions that you see. Focus on the Hulking ones if possible
    .complete 564,1 --Mountain Lion (8)
    .complete 564,2 --Hulking Mountain Lion (10)
step
    >>Run along the shore, AoEing turtles for their meat
    .goto Alterac Mountains,18.36,51.30,100,0
    .goto Alterac Mountains,36.90,20.14,100,0
    .complete 555,1 --Turtle Meat (10)
--N link if it does work
step
    .hs >> Hearth to Southshore
    .vendor >> Buy up to 120 level 35 drink from the Innkeeper
step
    >>At the back of the Inn
    .goto Hillsbrad Foothills,51.89,58.68
    .turnin 555 >>Turn in Soothing Turtle Bisque
step
    .goto Hillsbrad Foothills,49.47,58.73
    .turnin 500 >>Turn in Crushridge Bounty
step
    >>Inside the keep
    .goto Hillsbrad Foothills,48.14,59.11
    .turnin 505 >>Turn in Syndicate Assassins
    .turnin 510 >>Turn in Foreboding Plans
step
    .goto Hillsbrad Foothills,50.57,57.10
    .turnin 511 >>Turn in Encrypted Letter
    .accept 514 >>Accept Letter to Stormpike
step
    .goto Hillsbrad Foothills,52.42,55.97
    .turnin 564 >>Turn in Costly Menace
step
    .zone Ironforge >> Teleport to Ironforge
step
    #completewith next
    +Make sure to bank your cloth and repair. You're not going back to town for hours soon
step
    >>If you get unlucky on the quest accept and have to wait out the RP event, start conjuring level 25 water en masse
    .goto Ironforge,39.02,88.08
    .turnin 689 >>Turn in A King's Tribute
    .accept 700 >>Accept A King's Tribute
step
    .goto Ironforge,39.07,56.23
    .turnin 700 >>Turn in A King's Tribute
step
    .goto Ironforge,74.64,11.74
    .turnin 514 >>Turn in Letter to Stormpike
    .accept 525 >>Accept Further Mysteries
step
    .goto Ironforge,55.50,47.74
    .fly Arathi >> Fly to Arathi
]],"Alliance Mage")

RXPGuides.RegisterGuide("RestedXP Alliance Mage",[[
#classic
<< Alliance Mage
#name 33-60 Mage AoE
step
    #completewith next
    +Congratulations! You're now onto the AoE grind part. If there is competition in the area you're AoEing in, then you can always log and play an alt, do dungeons, or try to kick them out the spot by being more persistent than them.
    >>Good luck, and have fun!
step
    .goto Arathi Highlands,60.18,53.85
    .turnin 659 >>Turn in Hints of a New Plague?
    .accept 658 >>Accept Hints of a New Plague?
step
    #completewith next
    +It's highly recommended you watch the video on how to do all 4-5 pulls effectively in the area for the orcs
    .link https://youtu.be/SxMc2GoP33c?t=3477 >> CLICK HERE
step
    .goto Arathi Highlands,66.34,64.29,120,0
    .goto Arathi Highlands,63.49,67.77,120,0
    .goto Arathi Highlands,61.25,72.37,120,0
    .goto Arathi Highlands,64.77,73.22,120,0
    .goto Arathi Highlands,70.50,69.58,120,0
    .goto Arathi Highlands,73.20,64.88,120 >> Check the troll camps that are outside for Nimar the Slayer, as he drops a really good cloth helm
    .unitscan Nimar the Slayer
    >>If he's not up or you can't find him, skip this step
step
    #sticky
    #label Folder
    >>Kill the Forsaken Courier when it spawns. Loot it for the folder
    .complete 658,1 --Sealed Folder (1)
    .unitscan Forsaken Courier
step
    .goto Arathi Highlands,61.89,58.12
    .xp 36 >> AoE grind orcs to 36. Check the video guide linked earlier if you're struggling
    >>Don't be afraid to Hearth early and restock/repair if needed
    >>Remember to start saving Silk Cloth to bank later (for cloth turnins)
step
    .isQuestComplete 658
    .goto Arathi Highlands,60.19,53.85
    .turnin 658 >>Turn in Hints of a New Plague?
step
    .isQuestTurnedIn 658
    .accept 657 >>Accept Hints of a New Plague?
    .turnin 657 >>Turn in Hints of a New Plague?
    .accept 660 >>Accept Hints of a New Plague?
step
    .isQuestTurnedIn 658
    >>Escort Kinelory
    .complete 660,1 --Protect Kinelory (1)
step
    .isQuestTurnedIn 658
    .goto Arathi Highlands,60.19,53.85    
    .turnin 660 >>Turn in Hints of a New Plague?
    .accept 661 >>Accept Hints of a New Plague?
step
    .zone Ironforge >> Teleport to Ironforge
    .trainer >> Train your class spells
    >>Bank your cloth too if needed
step
    .hs >> Hearth to Southshore
    .vendor >> Buy up to 140 level 35 water
step
    .isOnQuest 661
    .goto Hillsbrad Foothills,50.34,59.04
    .turnin 661 >>Turn in Hints of a New Plague?
step
    .goto Hillsbrad Foothills,48.14,59.11
    .turnin 525 >>Turn in Further Mysteries
step
    .goto Hillsbrad Foothills,49.34,52.27
    .fly Arathi >> Fly to Arathi
step
    #completewith next
    .goto Arathi Highlands,45.98,47.72
    .vendor >> Talk to Jannos and vendor/repair if needed
step
    .goto Arathi Highlands,61.89,58.12,250 >> Run back to the orc farm
step
    #sticky
    #completewith next
    >>Kill the Forsaken Courier when it spawns. Loot it for the folder
    .complete 658,1 --Sealed Folder (1)
    .unitscan Forsaken Courier
step
    .goto Arathi Highlands,61.89,58.12
    .xp 37 >> AoE grind orcs to 37. Check the video guide linked earlier if you're struggling
 step
    .isQuestComplete 658
    .goto Arathi Highlands,60.19,53.85
    .turnin 658 >>Turn in Hints of a New Plague?
step
    .isQuestTurnedIn 658
    .accept 657 >>Accept Hints of a New Plague?
    .turnin 657 >>Turn in Hints of a New Plague?
    .accept 660 >>Accept Hints of a New Plague?
step
    .isQuestTurnedIn 658
    >>Escort Kinelory
    .complete 660,1 --Protect Kinelory (1)
step
    .isQuestTurnedIn 658
    .goto Arathi Highlands,60.19,53.85    
    .turnin 660 >>Turn in Hints of a New Plague?
    .accept 661 >>Accept Hints of a New Plague?
step
    .hs >> Hearth to Southshore
    .vendor >> Buy level 35 drink if needed
step
    .isOnQuest 661
    .goto Hillsbrad Foothills,50.34,59.04
    .turnin 661 >>Turn in Hints of a New Plague?
step
    .goto Hillsbrad Foothills,49.34,52.27
    .fly Wetlands >> Fly to Wetlands
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
    >>Go into the house and buy Soothing Spices from Helenia if you didn't get them in Southshore
    .goto Dustwallow Marsh,66.44,51.46
    .collect 3713,3 --Soothing Spices (3)
step
    .goto Dustwallow Marsh,66.15,46.07
    .accept 1282 >>Accept They Call Him Smiling Jim
step
    >>Go into the Inn
    .goto Dustwallow Marsh,66.33,45.47
    .accept 1204 >>Accept Mudrock Soup and Bugs
step
    .goto Dustwallow Marsh,66.59,45.22
    .home >> Set your hearth to Theramore
    .vendor >> Buy up to 180 level 35 drink
step
    >>Go upstairs in the keep
    .goto Dustwallow Marsh,67.79,47.62,30,0
    .goto Dustwallow Marsh,68.02,48.71
    .turnin 1264 >>Turn in The Missing Diplomat
    .accept 1265 >>Accept The Missing Diplomat
step
    .goto Dustwallow Marsh,68.21,48.62
    .turnin 1282 >>Turn in They Call Him Smiling Jim
step
    >>Wait for Tervosh to appear in the tower. Turn in, then wait for him to cast his buff on you
    .goto Dustwallow Marsh,59.72,41.17
    .complete 1265,1 --Sentry Point explored (1)
    .turnin 1265 >> Turn in The Missing Diplomat
    .accept 1266 >> Accept The Missing Diplomat
step
    >>Talk to Private Hendel. This will start a 1v3 event
    >>Nova the other mobs, try to focus Hendel
    .goto Dustwallow Marsh,45.20,24.58
    .turnin 1266 >>Turn in The Missing Diplomat
    .accept 1324 >>Accept The Missing Diplomat
    .complete 1324,1 --Subdue Private Hendel (1)
step
    >>Turn in behind you
    .goto Dustwallow Marsh,45.19,24.27
    .turnin 1324 >>Turn in The Missing Diplomat
    .turnin 1267 >>Turn in The Missing Diplomat
step
    >>Turn in the Soothing Spices that you got earlier from Southshore
    .goto Dustwallow Marsh,55.44,26.27
    .accept 1218 >>Accept Soothing Spices
    .turnin 1218 >>Turn in Soothing Spices
step
    >>Click the dirt grave
    .goto Dustwallow Marsh,55.44,25.92
    .accept 1219 >>Accept The Orc Report
step
    #completewith next
    +I HIGHLY recommend watching the mage guide for these mobs, as they are arguably the hardest part of the AoE Mage leveling experience
    >>I wouldn't recommend doing the turtle pack until level 38+
    .link https://youtu.be/SxMc2GoP33c?t=3824 >> CLICK HERE
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
    .trainer >> Teleport to Stormwind or Ironforge. Train your level 38 spells
    >>Start being very careful with your money too, as it's very nice to have your mount at level 40
step
    .hs >> Hearth to Theramore
>> Buy food/water if needed
step
    .goto Dustwallow Marsh,65.07,47.12
    .turnin 1219 >>Turn in The Orc Report
    .accept 1220 >>Accept Captain Vimes
step
    >>Go upstairs in the keep
    .goto Dustwallow Marsh,67.79,47.62,30,0
    .goto Dustwallow Marsh,68.21,48.62
    .turnin 1220 >>Turn in Captain Vimes
step
    #sticky
    #completewith next
    .goto Dustwallow Marsh,54.33,12.41,0
    >>Start doing the Turtle pack just north of the north-western murloc camp
    .complete 1204,1 --Forked Mudrock Tongue (8)
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
step
    .goto Dustwallow Marsh,64.80,40.43
    >>Finish AoEing the turtles for their tongues
    .complete 1204,1 --Forked Mudrock Tongue (8)
step << Gnome
    .zone Ironforge >> Teleport to Ironforge
    .trainer >> Train your class spells
step << Gnome
    .zone Dun Morogh >>Skip this step if you won't have 90g or more after vendoring trash
    .trainer >>Run into Dun Morogh and get your mount and mount training. 
    .goto Dun Morogh,49.15,48.05
step << Human
    .zone Stormwind City >> Teleport to Stormwind
    .trainer >> Train your class spells
step << Human
    .goto Stormwind City,66.27,62.13
    .fly Redridge >> Fly to Redridge. Skip this step if you won't have 90g or more after vendoring trash
    .goto Elwynn Forest,84.32,64.87
    .trainer >>Run to Eastvale and get your mount and mount training. 
step
    .hs >> Hearth to Theramore
>> Buy food/water if needed
step
    .goto Dustwallow Marsh,66.33,45.47
    .turnin 1204 >>Turn in Mudrock Soup and Bugs
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
    .zone Ironforge >> Teleport to Ironforge
    .trainer >> Train your class spells
step
    #hardcore
    .hs >> Hearth to Theramore
>> Buy food/water if needed
step
    >>Travel to Tanaris. You can either ride through Dustwallow -> Barrens -> Thousand Needles -> Gadgetzan
    >>Or you can go straight south and swim near the fatigue water to eastern tanaris -> Gadgetzan
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
    .zone Ironforge >> Teleport to Ironforge
step
    #hardcore
    .zone Ironforge >> Teleport to Ironforge
step
    .goto Ironforge,27.17,8.58
    .trainer >> Train your class spells
step
    .goto Ironforge,31.32,27.80
    .vendor >> Talk to Ginny. Buy 6 Runes of Teleportation
    >>You can also go to the AH and buy bigger bags if you need
    .collect 17031,6 --Rune of Teleportation (6)
step
    .hs >> Hearth to Gadgetzan
    .vendor >> Buy 140 level 45 drink
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
    .trainer >> Teleport to Stormwind or Ironforge. Train your level 46-48 spells
step
    #hardcore
    .trainer >> Teleport to Stormwind or Ironforge. Train your level 46-48 spells
step
    .hs >> Hearth to Gadgetzan. Buy level 45 drink if needed
>> Buy food/water if needed
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
    #hardcore
    .zone Ironforge >> Teleport to Ironforge
    .trainer >> Train your level 50-52 spells
step
    #softcore
    .trainer >> Teleport to Stormwind or Ironforge. Train your level 50-52 spells
step
    #softcore
    .hs >> Hearth to Gadgetzan. Buy level 45 drink if needed
>> Buy food/water if needed
step
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
    #softcore
    .trainer >> Teleport to Ironforge. Train your level 54 spells
step
    .goto Ironforge,55.50,47.75
    .fly Chillwind >> Fly to Western Plaguelands
step
    .goto Western Plaguelands,42.70,84.03
    .accept 5092 >> Accept Clear the Way
step
    .goto Western Plaguelands,42.97,83.55
    .turnin 5401 >> Turn in Argent Dawn Commission
step
    >>Equip your Argent Dawn Commission
    >>AoE the skeletons and ghouls. Be careful when going back into melee range after pulling as they thrash (multiple attacks at once)
    .goto Western Plaguelands,51.00,76.16
    .complete 5092,1 --Skeletal Flayer (10)
    .complete 5092,2 --Slavering Ghoul (10)
step
    .goto Western Plaguelands,42.70,84.03
    .turnin 5092 >> Turn in Clear the Way
    .accept 5097 >> Accept All Along the Watchtowers
    .accept 5215 >> Accept The Scourge Cauldrons
step
    .goto Western Plaguelands,42.97,84.50
    .turnin 5215 >>Turn in The Scourge Cauldrons
    .accept 5216 >>Accept Target: Felstone Field
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,40.02,71.74
    .complete 5097,1 --Tower One marked (1)
step
    >>Kill Cauldron Lord Bilemaw. Loot him for the key
    .goto Western Plaguelands,37.12,57.18
    .complete 5216,1 --Felstone Field Cauldron Key (1)
    .unitscan Cauldron Lord Bilemaw
step
    >>Click on the Cauldron in front of you
    .goto Western Plaguelands,37.21,56.88
    .turnin 5216 >>Turn in Target: Felstone Field
    .accept 5217 >>Accept Return to Chillwind Camp
step
    >>2nd floor of the house
    .goto Western Plaguelands,38.40,54.06
    .accept 5021 >>Accept Better Late Than Never
step
    >>Small package inside the barn. Try not to aggro the scarlet mobs if they're alive outside
    .goto Western Plaguelands,38.73,55.24
    .turnin 5021 >>Turn in Better Late Than Never
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,42.30,66.04
    .complete 5097,2 --Tower Two marked (1)
step
    .goto Western Plaguelands,42.97,84.50
    .turnin 5217 >>Turn in Return to Chillwind Camp
    .accept 5219 >>Accept Target: Dalson's Tears
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,44.18,63.36
    .complete 5097,3 --Tower Three marked (1)
step
    >>Kill Cauldron Lord Malvinous. Loot him for the key
    .goto Western Plaguelands,46.04,52.34
    .complete 5219,1 --Dalson's Tears Cauldron Key (1)
    .unitscan Cauldron Lord Malvinous
step
    >>Click the Cauldron
    .goto Western Plaguelands,46.19,52.01
    .turnin 5219 >>Turn in Target: Dalson's Tears
    .accept 5220 >>Accept Return to Chillwind Camp
step
    >>Inside the barn on the ground
    .goto Western Plaguelands,47.79,50.67
    .turnin 5058 >> Turn in Mrs. Dalson's Diary
step
    #completewith next
    +Start AoEing the undead in the area. Be careful as the Skeletal Terrors fear. Watch the video for more info
    .link https://youtu.be/SxMc2GoP33c?t=4759 >> CLICK HERE
step
    #completewith 54Grind
    #label SkeletonKey
    >>Keep an eye out for the Wandering Skeleton whilst you're AoEing. Kill him then loot him for the Outhouse Key
    .collect 12738,1 --Dalson Outhouse Key (1)
step
    #completewith 54Grind
    #label LockedAway
    #requires SkeletonKey
    .goto Western Plaguelands,48.16,49.64
    >>Click the outhouse. This will spawn a mob. Kill it
    .turnin 5059 >> Turn in Locked Away
    .collect 12739,1 --Dalson Cabinet Key (1)
step
    #completewith 54Grind
    #requires LockedAway
    >>Click the cabinet at the top floor of the house
    .goto Western Plaguelands,47.37,49.66
    .turnin 5060 >> Turn in Locked Away
step
    #label 54Grind
    .xp 54+156900 >>AoE Undead in the area to 54 & 156900+/173900xp
    >>Remember to try and save 12 stacks of Runecloth. You'll need it for cloth turnins later
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,46.52,71.21
    .complete 5097,4 --Tower Four marked (1)
step
    .goto Western Plaguelands,42.70,84.04
    .turnin 5097 >>Turn in All Along the Watchtowers
step
    .goto Western Plaguelands,42.97,84.51
    .turnin 5220 >>Turn in Return to Chillwind Camp
    .accept 5222 >>Accept Target: Writhing Haunt
step
    >>Kill Cauldron Lord Razarch. Loot him for the key
    .goto Western Plaguelands,53.11,65.98
    .complete 5222,1 --Writhing Haunt Cauldron Key (1)
step
    >>Click the Cauldron
    .goto Western Plaguelands,53.04,65.71
    .turnin 5222 >>Turn in Target: Writhing Haunt
    .accept 5223 >>Accept Return to Chillwind Camp
step
    #softcore
    .deathskip >> Die and Respawn back in Chillwind
step
    #completewith next
    .goto Western Plaguelands,42.84,83.72
    .vendor >> If you would have friendly rep after turning in and using your scourgestones to Pureheart, buy as many Manna Biscuits as possible to last you to level 60
    >>If you don't, skip this step
step
    .goto Western Plaguelands,42.97,84.50
    .turnin 5223 >>Turn in Return to Chillwind Camp
step
    .zone Stormwind City >> Teleport to Stormwind City
step
    #softcore
    #completewith SWBank
    .goto Stormwind City,53.61,59.77
    +If you don't have 12 stacks of each cloth, or the Feathers, buy them from the Auction House
step
    #label SWBank
    .goto Stormwind City,56.48,73.41,50,0
    >>Withdraw all your cloth from the bank. You need 12 stacks of Wool, Silk, Mageweave, and Runecloth
    >>If you don't have inventory space, then leave half of the cloth in the bank and skip this step
    >>Also get as many Light Feathers as you can. You'll need them for later
    .collect 2592,240 --Wool Cloth (240)
    .collect 4306,240 --Silk Cloth (240)
    .collect 4338,240 --Mageweave Cloth (240)
    .collect 14047,240 --Runecloth (240)
    .collect 17056,10 --Light Feather (10)
step
    >>Inside the 2nd floor of the house
    >>Make sure you have no addons on that will automatically turn in extra runecloth (for rep) or you will be told to buy it again later
    .goto Stormwind City,44.27,73.99
    .turnin 7791 >> Turn in A Donation of Wool
    .turnin 7793 >> Turn in A Donation of Silk
    .turnin 7794 >> Turn in A Donation of Mageweave
    .turnin 7795 >> Turn in A Donation of Runecloth
step
    .zone Ironforge >> Teleport to Ironforge
step
    #softcore
    #completewith IFBank
    .goto Ironforge,25.75,75.42
    +If you don't have 9 stacks of each cloth, buy it from the Auction House
step
    #label IFBank
    .goto Ironforge,35.92,60.14,40,0
    >>Withdraw all your cloth from the bank. You need 9 stacks of Wool, Silk, Mageweave, and Runecloth
    >>If you don't have inventory space, then leave half of the cloth in the bank and skip this step
    .collect 2592,180 --Wool Cloth (180)
    .collect 4306,180 --Silk Cloth (180)
    .collect 4338,180 --Mageweave Cloth (180)
    .collect 14047,180 --Runecloth (180)
step
    .goto Ironforge,43.22,31.59
    .turnin 7802 >> Turn in A Donation of Wool
    .turnin 7803 >> Turn in A Donation of Silk
    .turnin 7804 >> Turn in A Donation of Mageweave
    .turnin 7805 >> Turn in A Donation of Runecloth
step
    .goto Ironforge,74.09,48.23
    .turnin 7807 >> Turn in A Donation of Wool
    .turnin 7808 >> Turn in A Donation of Silk
    .turnin 7809 >> Turn in A Donation of Mageweave
    .turnin 7811 >> Turn in A Donation of Runecloth
step
    .goto Ironforge,55.50,47.75
    .fly Wetlands >> Fly to Wetlands
step
    #sticky
    #completewith Darkshore1
    +Wait here for the boat
    .goto Wetlands,4.7,57.3
step
    #label Darkshore1
    .zone Darkshore >>Get onto the boat when it comes. Take it to Darkshore
step
    .goto Darkshore,37.04,44.13
    .home >> Set your hearth to Auberdine
step
    .isQuestTurnedIn 741
    .goto Darkshore,36.34,45.57
    .fly Teldrassil >> Fly to Teldrassil
step
    #sticky
    #completewith next
    +Wait here for the boat
    .goto Darkshore,33.17,40.18
step
    .zone Teldrassil >>Get onto the boat when it comes. Take it to Darnassus
step
    .goto Teldrassil,55.95,89.88,40 >> Take the purple portal into Darnassus
step
    #softcore
    #completewith NEBank
    .goto Darnassus,56.37,51.80
    +If you don't have 3 stacks of each cloth, buy it from the Auction House
step
    #label NEBank
    .goto Darnassus,39.90,42.08,40,0
    >>Withdraw all your cloth from the bank. You need 3 stacks of Wool, Silk, Mageweave, and Runecloth
    >>If you don't have inventory space, then leave half of the cloth in the bank and skip this step
    .collect 2592,60 --Wool Cloth (60)
    .collect 4306,60 --Silk Cloth (60)
    .collect 4338,60 --Mageweave Cloth (60)
    .collect 14047,60 --Runecloth (60)
step
    #completewith next
    .goto Darnassus,40.60,82.13
    .trainer >> Train the Darnassus portal for convenience if you want (its not needed for any part of the route later)
step
    .goto Darnassus,64.02,23.00
    .turnin 7792 >> Turn in A Donation of Wool
    .turnin 7798 >> Turn in A Donation of Silk
    .turnin 7799 >> Turn in A Donation of Mageweave
    .turnin 7800 >> Turn in A Donation of Runecloth
step
    .hs >> Hearth to Auberdine
>> Buy food/water if needed
step
    .goto Darkshore,37.12,43.62
    .vendor >> Buy A LOT level 45 water from Allyndia if you didn't get the Manna Biscuits earlier. Fill your bags with it
    >>Alternatively, if you don't want to go broke, just conjure level 45 water instead
step
    .goto Darkshore,38.14,41.11
    .vendor >> Repair. You're going to be AoE grinding solidly for the next 5 levels, so make sure you're at full durability
step
    #completewith next
    +You're now going to do the Dancing Troll Village. You can get there through Darkshore (pretty hard, needs Light Feathers, but 10 mins faster) or through Winterspring
    .link https://youtu.be/1nBptJKSJto >> CLICK HERE for Darkshore
    .link https://youtu.be/2aAD8pgMaF4?t=40 >> CLICK HERE for Winterspring
--N update with our links
step
    .goto Darkshore,69.07,20.58,150 >> Arrive in the Dancing Troll Village
step
    .goto Darkshore,68.34,22.98,60,0
    .goto Darkshore,68.42,18.97,60,0
    .goto Darkshore,69.63,21.01,60,0
    .goto Darkshore,68.34,22.98,60,0
    .goto Darkshore,68.42,18.97,60,0
    .goto Darkshore,69.63,21.01,60,0
    .xp 60 >> Grind the trolls to 60
    >>DO NOT DIE. Look at the video guide if needed. If you die, you'll need to do the Darkshore jumps or travel to Winterspring again
step
    +Congratulations on level 60!
]],"Human Mage/Gnome Mage")
