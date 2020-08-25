local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("ProfessionsACLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "CLA"
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Alchemy\\Alchemy (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Alchemy') > 0 end,
description="This guide will walk you through leveling your Alchemy skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 45.77,78.03 < 7 |walk
talk Tel'Athir##5500
|tip Inside the building.
Learn Apprentice Alchemy |skillmax Alchemy,75 |goto Stormwind City 46.25,79.10
step
collect 65 Peacebloom##2447
collect 65 Silverleaf##765
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 60
step
Enter the building |goto 45.77,78.03 < 7 |walk
talk Eldraeith##5503
|tip Inside the building.
buy 65 Empty Vial##3371 |goto 46.66,78.64
|only if skill("Alchemy") < 60
step
Open Your Alchemy Crafting Panel:
_<Create 65 Minor Healing Potions>_
|tip Save these, they will be used in a later recipe.
Reach Level 60 Alchemy |skill Alchemy,60
collect 65 Minor Healing Potion##118 |only if skill("Alchemy") < 110
step
Reach Level 10 |ding 10
|tip You must be at least this level before you can learn the next rank of this profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto 45.77,78.03 < 7 |walk
talk Lilyssia Nightbreeze##5499
|tip Inside the building.
Learn Journeyman Alchemy |skillmax Alchemy,150 |goto 46.50,79.67
step
collect 65 Briarthorn##2450
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 110
step
Enter the building |goto 45.77,78.03 < 7 |walk
talk Lilyssia Nightbreeze##5499
|tip Inside the building.
learn Lesser Healing Potion##2337 |goto 46.50,79.67
step
Open Your Alchemy Crafting Panel:
_<Create 65 Lesser Healing Potions>_
Reach Level 110 Alchemy |skill Alchemy,110
step
collect 35 Briarthorn##2450
collect 35 Bruiseweed##2453
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 140
step
Enter the building |goto 45.77,78.03 < 7 |walk
talk Lilyssia Nightbreeze##5499
|tip Inside the building.
learn Healing Potion##3447 |goto 46.50,79.67
step
talk Eldraeith##5503
|tip Inside the building.
buy 35 Leaded Vial##3372 |goto 46.66,78.64
|only if skill("Alchemy") < 140
step
Open Your Alchemy Crafting Panel:
_<Create 35 Healing Potions>_
Reach Level 140 Alchemy |skill Alchemy,140
|only if skill("Alchemy") < 140
step
Reach Level 20 |ding 20
|tip You must be at least this level before you can learn the next rank of this profession.
|tip Use the Leveling guides to accomplish this.
step
talk Ainethil##4160
|tip Inside the building.
Learn Expert Alchemy |skillmax Alchemy,225 |goto Darnassus 54.88,24.02
step
collect 20 Mageroyal##785
collect 20 Stranglekelp##3820
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 155
step
talk Ainethil##4160
|tip Inside the building.
learn Lesser Mana Potion##3173 |goto 54.88,24.02
step
talk Ulthir##4226
|tip Inside the building.
buy 20 Empty Vial##3371 |goto 46.66,78.64
|only if skill("Alchemy") < 155
step
Open Your Alchemy Crafting Panel:
_<Create 20 Lesser Mana Potions>_
Reach Level 155 Alchemy |skill Alchemy,155
step
collect 35 Liferoot##3357
collect 35 Kingsblood##3356
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 185
step
talk Ainethil##4160
|tip Inside the building.
learn Greater Healing Potion##7181 |goto 54.88,24.02
step
talk Ulthir##4226
|tip Inside the building.
buy 35 Leaded Vial##3372 |goto 46.66,78.64
|only if skill("Alchemy") < 185
step
Open Your Alchemy Crafting Panel:
_<Create 35 Greater Healing Potions>_
Reach Level 185 Alchemy |skill Alchemy,185
step
collect 30 Goldthorn##3821
collect 30 Stranglekelp##3820
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 210
step
talk Ainethil##4160
|tip Inside the building.
learn Elixir of Agility##11449 |goto 54.88,24.02
step
talk Ulthir##4226
|tip Inside the building.
buy 30 Leaded Vial##3372 |goto 46.66,78.64
|only if skill("Alchemy") < 210
step
Open Your Alchemy Crafting Panel:
_<Create 30 Elixirs of Agility>_
Reach Level 210 Alchemy |skill Alchemy,210
step
collect 5 Wild Steelbloom##3355
collect 5 Goldthorn##3821
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 215
step
talk Ainethil##4160
|tip Inside the building.
learn Elixir of Greater Defense##11450 |goto 54.88,24.02
step
talk Ulthir##4226
|tip Inside the building.
buy 5 Leaded Vial##3372 |goto 46.66,78.64
|only if skill("Alchemy") < 215
step
Open Your Alchemy Crafting Panel:
_<Create 5 Elixirs of Greater Defense>_
Reach Level 215 Alchemy |skill Alchemy,215
step
Reach Level 35 |ding 35
|tip You must be at least this level before you can learn the next rank of this profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Feralas 32.34,43.69 < 7 |walk
talk Kylanna Windwhisper##7948
|tip Inside the building.
Learn Artisan Alchemy |skillmax Alchemy,300 |goto Feralas 32.62,43.78
step
talk Kylanna Windwhisper##7948
|tip Inside the building.
learn Superior Healing Potion##11457 |goto 32.62,43.78
step
collect 15 Sungrass##8838
collect 15 Khadgar's Whisker##3358
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 230
step
Enter the building |goto 32.34,43.69 < 7 |walk
talk Logannas##8157
|tip Inside the building.
buy 15 Crystal Vial##8925 |goto 32.67,44.03
|only if skill("Alchemy") < 230
step
Open Your Alchemy Crafting Panel:
_<Create 15 Superior Healing Potions>_
Reach Level 230 Alchemy |skill Alchemy,230
step
collect 25 Arthas' Tears##8836
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 250
step
Enter the building |goto 32.34,43.69 < 7 |walk
talk Kylanna Windwhisper##7948
|tip Inside the building.
learn Elixir of Detect Undead##11460 |goto 32.62,43.78
step
talk Logannas##8157
|tip Inside the building.
buy 25 Crystal Vial##8925 |goto 32.67,44.03
|only if skill("Alchemy") < 250
step
Open Your Alchemy Crafting Panel:
_<Create 25 Elixirs of Detect Undead>_
Reach Level 250 Alchemy |skill Alchemy,250
step
collect 20 Sungrass##8838
collect 20 Goldthorn##3821
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 265
step
Enter the building |goto 32.34,43.69 < 7 |walk
talk Kylanna Windwhisper##7948
|tip Inside the building.
learn Elixir of Greater Agility##11467 |goto 32.62,43.78
step
talk Logannas##8157
|tip Inside the building.
buy 20 Crystal Vial##8925 |goto 32.67,44.03
|only if skill("Alchemy") < 265
step
Open Your Alchemy Crafting Panel:
_<Create 25 Elixirs of Greater Agility>_
Reach Level 265 Alchemy |skill Alchemy,265
step
Reach Level 41 |ding 41
|tip You must be at least this level before you can learn the next recipe.
|tip Use the Leveling guides to accomplish this.
step
talk Ulthir##4226
|tip Inside the building.
buy Recipe: Superior Mana Potion##13477 |n
|tip This is a limited supply item.
|tip If he doesn't have it for sale, check the Auction House.
use the Recipe: Superior Mana Potion##13477
learn Superior Mana Potion##17553 |goto Darnassus 46.66,78.64
step
collect 50 Sungrass##8838
collect 50 Blindweed##8839
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 285
step
talk Ulthir##4226
|tip Inside the building.
buy 25 Crystal Vial##8925 |goto 46.66,78.64
|only if skill("Alchemy") < 285
step
Open Your Alchemy Crafting Panel:
_<Create 25 Superior Mana Potions>_
Reach Level 285 Alchemy |skill Alchemy,285
step
Reach Level 45 |ding 45
|tip You must be at least this level before you can learn the next recipe.
|tip Use the Leveling guides to accomplish this.
step
Follow the path |goto Winterspring 60.56,38.20 < 7 |only if walking
Enter the building |goto Winterspring 60.83,37.85 < 7 |walk
talk Evie Whirlbrew##11188
|tip Inside the building.
buy 25 Crystal Vial##8925 |goto Winterspring 60.75,37.78
step
talk Evie Whirlbrew##11188
|tip Inside the building.
buy Recipe: Major Healing Potion##13480 |n
|tip This is a limited supply item.
|tip If she doesn't have it for sale, check the Auction House.
use the Recipe: Major Healing Potion##13480
learn Major Healing Potion##17556 |goto 60.75,37.78
step
collect 50 Golden Sansam##13464
collect 25 Mountain Silversage##13465
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 300
step
Open Your Alchemy Crafting Panel:
_<Create 25 Major Healing Potions>_
Reach Level 300 Alchemy |skill Alchemy,300
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Blacksmithing\\Blacksmithing (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Blacksmithing') > 0 end,
description="This guide will walk you through leveling your Blacksmithing skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
talk Groum Stonebeard##10277
Learn Apprentice Blacksmithing |skillmax Blacksmithing,75 |goto Ironforge 52.26,41.94
step
talk Thurgrum Deepforge##4259
buy Blacksmith Hammer##5956 |goto 51.74,42.78
|tip You must have a Blacksmith Hammer in your bags to be able to create some Blacksmithing recipes.
step
collect 40 Rough Stone##2835
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 30
step
Open Your Blacksmithing Crafting Panel:
_<Create 40 Rough Sharpening Stones>_
Reach Level 30 Blacksmithing |skill Blacksmithing,30
step
collect 90 Rough Stone##2835
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 65
step
talk Groum Stonebeard##10277
learn Rough Grinding Stone##3320 |goto 52.26,41.94
step
Open Your Blacksmithing Crafting Panel:
_<Create 45 Rough Grinding Stones>_
|tip Save 10 of these, they will be used in a later recipe.
Reach Level 65 Blacksmithing |skill Blacksmithing,65
step
collect 25 Coarse Stone##2836
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 75
step
talk Groum Stonebeard##10277
learn Course Sharpening Stone##2665 |goto 52.26,41.94
step
Open Your Blacksmithing Crafting Panel:
_<Create 25 Course Sharpening Stone>_
Reach Level 75 Blacksmithing |skill Blacksmithing,75
step
Reach Level 10 |ding 10
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
talk Rotgath Stonebeard##10276
Learn Journeyman Blacksmithing |skillmax Blacksmithing,150 |goto 52.36,42.55
step
collect 60 Coarse Stone##2836
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 90
step
talk Rotgath Stonebeard##10276
learn Course Grinding Stone##3326 |goto 52.36,42.55
step
Open Your Blacksmithing Crafting Panel:
_<Create 30 Course Grinding Stones>_
|tip Save these, they will be used in a later recipe.
Reach Level 90 Blacksmithing |skill Blacksmithing,90
step
collect 100 Copper Bar##2840
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 100
step
talk Rotgath Stonebeard##10276
learn Runed Copper Belt##2666 |goto 52.36,42.55
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 10 Runed Copper Belts>_
Reach Level 100 Blacksmithing |skill Blacksmithing,100 |goto 52.36,42.55
step
collect 5 Silver Bar##2842
collect 10 Rough Grinding Stone##3470
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 105
step
talk Rotgath Stonebeard##10276
learn Silver Rod##7818 |goto 52.36,42.55
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 5 Silver Rods>_
Reach Level 105 Blacksmithing |skill Blacksmithing,105 |goto 52.36,42.55
step
collect 50 Copper Bar##2840
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 110
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 5 Runed Copper Belts>_
Reach Level 110 Blacksmithing |skill Blacksmithing,110 |goto 52.36,42.55
step
collect 90 Bronze Bar##2841
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 125
step
talk Rotgath Stonebeard##10276
learn Rough Bronze Leggings##2668 |goto 52.36,42.55
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 15 Rough Bronze Leggings>_
Reach Level 125 Blacksmithing |skill Blacksmithing,125 |goto 52.36,42.55
step
collect 120 Heavy Stone##2838
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 140
step
talk Rotgath Stonebeard##10276
learn Heavy Grinding Stone##3337 |goto 52.36,42.55
step
Open Your Blacksmithing Crafting Panel:
_<Create 40 Heavy Grinding Stones>_
|tip Save 30 of these, they will be used in a later recipe.
Reach Level 140 Blacksmithing |skill Blacksmithing,140
step
collect 50 Bronze Bar##2841
collect 20 Coarse Grinding Stone##3478
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 150
step
talk Rotgath Stonebeard##10276
learn Patterned Bronze Bracers##2672 |goto 52.36,42.55
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 10 Patterned Bronze Bracers>_
Reach Level 150 Blacksmithing |skill Blacksmithing,150 |goto 52.36,42.55
step
Reach Level 20 |ding 20
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
talk Bengus Deepforge##4258
Learn Expert Blacksmithing |skillmax Blacksmithing,225 |goto Ironforge 52.55,41.46
step
collect 5 Gold Bar##3577
collect 10 Coarse Grinding Stone##3478
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 155
step
talk Bengus Deepforge##4258
learn Golden Rod##14379 |goto 52.55,41.46
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 5 Golden Rods>_
Reach Level 155 Blacksmithing |skill Blacksmithing,155 |goto 52.55,41.46
step
collect 80 Iron Bar##3575
collect 10 Heavy Grinding Stone##3486
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 165
step
Enter the building |goto 43.85,29.81 < 7 |walk
talk Poranna Snowbraid##5154
|tip Inside the building.
buy 10 Green Dye##2605 |goto 42.96,28.32
|only if skill("Blacksmithing") < 165
step
talk Bengus Deepforge##4258
learn Green Iron Leggings##3506 |goto 52.55,41.46
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 10 Green Iron Leggings>_
Reach Level 165 Blacksmithing |skill Blacksmithing,165 |goto 52.55,41.46
step
collect 150 Iron Bar##3575
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 190
step
Enter the building |goto 43.85,29.81 < 7 |walk
talk Poranna Snowbraid##5154
|tip Inside the building.
buy 25 Green Dye##2605 |goto 42.96,28.32
|only if skill("Blacksmithing") < 190
step
talk Bengus Deepforge##4258
learn Green Iron Bracers##3501 |goto 52.55,41.46
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 25 Green Iron Bracers>_
Reach Level 190 Blacksmithing |skill Blacksmithing,190 |goto 52.55,41.46
step
collect 50 Steel Bar##3859
collect 20 Heavy Grinding Stone##3486
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 200
step
talk Bengus Deepforge##4258
learn Golden Scale Bracers##7223 |goto 52.55,41.46
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 10 Golden Scale Bracers>_
|tip If you plan to get the Armorsmith specialization, keep 6 of these to use later.
Reach Level 200 Blacksmithing |skill Blacksmithing,200 |goto 52.55,41.46
step
collect 120 Solid Stone##7912
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 210
step
talk Bengus Deepforge##4258
learn Solid Grinding Stone##9920 |goto 52.55,41.46
step
Open Your Blacksmithing Crafting Panel:
_<Create 30 Solid Grinding Stones>_
|tip Save these, they will be used in a later recipe.
Reach Level 210 Blacksmithing |skill Blacksmithing,210
step
collect 90 Mithril Bar##3860
|tip If you have the Mining profession, you can gather these.
collect 60 Mageweave Cloth##4338
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 225
step
talk Bengus Deepforge##4258
learn Heavy Mithril Gauntlet##9928 |goto 52.55,41.46
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 15 Heavy Mithril Gauntlets>_
Reach Level 225 Blacksmithing |skill Blacksmithing,225 |goto 52.55,41.46
step
Reach Level 35 |ding 35
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
collect 140 Steel Bar##3859
collect 10 Solid Grinding Stone##7966
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 235
step
Enter the building |goto Stranglethorn Vale 28.95,75.33 < 5 |walk
talk Brikk Keencraft##2836
|tip Inside the building.
Learn Artisan Blacksmithing |skillmax Blacksmithing,300 |goto Stranglethorn Vale 28.99,75.55
step
talk Brikk Keencraft##2836
|tip Inside the building.
learn Steel Plate Helm##9935 |goto 28.99,75.55
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 10 Steel Plate Helms>_
|tip If you plan to get the Armorsmith specialization, keep 4 of these to use later.
Reach Level 235 Blacksmithing |skill Blacksmithing,235 |goto 28.95,75.53
step
collect Plans: Mithril Spurs##7989 |n
|tip Buy it from the auction house.
use the Plans: Mithril Spurs##7989
learn Mithril Spurs##9964
step
collect 80 Mithril Bar##3860
collect 60 Solid Grinding Stone##7966
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 255
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 20 Mithril Spurs>_
Reach Level 255 Blacksmithing |skill Blacksmithing,255 |goto Ironforge 52.55,41.46
step
collect 15 Dense Stone##12365
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 260
step
Enter the building |goto Stranglethorn Vale 28.95,75.33 < 5 |walk
talk Brikk Keencraft##2836
|tip Inside the building.
learn Dense Sharpening Stone##16641 |goto Stranglethorn Vale 28.99,75.55
step
Open Your Blacksmithing Crafting Panel:
_<Create 15 Dense Sharpening Stones>_
Reach Level 260 Blacksmithing |skill Blacksmithing,260
step
collect 100 Mithril Bar##3860
collect 75 Solid Grinding Stone##7966
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 270
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 25 Mithril Spurs>_
Reach Level 270 Blacksmithing |skill Blacksmithing,270 |goto Ironforge 52.55,41.46
step
Reach Level 50 |ding 50
|tip You must be at least this level before you can accept the next quests.
|tip Use the Leveling guides to accomplish this.
step
collect 620 Thorium Bar##12359
collect 30 Star Ruby##7910
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 295
step
talk Derotain Mudsipper##14567
accept A Blue Light Bargain##7652 |goto Tanaris 51.38,28.67
step
talk Derotain Mudsipper##14567
accept Imperial Plate Bracer##7655 |goto 51.38,28.67
|only if skill("Blacksmithing") < 295
step
use the Plans: Imperial Plate Bracers##12690
learn Imperial Plate Bracers##16649
|only if skill("Blacksmithing") < 295
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 30 Imperial Plate Bracers>_
Reach Level 295 Blacksmithing |skill Blacksmithing,295 |goto 51.39,28.71
step
collect 210 Thorium Bar##12359
collect 5 Star Ruby##7910
collect 5 Aquamarine##7909
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 300
step
talk Derotain Mudsipper##14567
accept Imperial Plate Boots##7654 |goto 51.38,28.67
|only if skill("Blacksmithing") < 300
step
use the Plans: Imperial Plate Boots##12700
learn Imperial Plate Boots##16657
|only if skill("Blacksmithing") < 300
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 5 Imperial Plate Boots>_
Reach Level 300 Blacksmithing |skill Blacksmithing,300 |goto 51.39,28.71
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Enchanting\\Enchanting (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Enchanting') > 0 end,
description="This guide will walk you through leveling your Enchanting skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 43.68,63.87 < 5 |walk
talk Betty Quin##11068
|tip Inside the building.
Learn Apprentice Enchanting |skillmax Enchanting,75 |goto Stormwind City 43.11,63.71
step
talk Jessara Cordell##1318
|tip Inside the building.
|tip The vendor has a limited supply of some of these items.
|tip If none are available, you can buy them from the Auction House.
buy Copper Rod##6217 |goto 42.81,64.39
buy Strange Dust##10940 |goto 42.81,64.39
buy Lesser Magic Essence##10938 |goto 42.81,64.39
|only if skill("Enchanting") < 2 or itemcount(6218) < 1
step
Open Your Enchanting Crafting Panel:
_<Create 1 Runed Copper Rod>_
|tip Keep the Runed Copper Rod that you create.
|tip You will need it in your inventory to enchant things.
Reach Level 2 Enchanting |skill Enchanting,2
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 75 Strange Dust##10940
|tip Use your Disenchant ability on level 5-25 green weapons and armor.
|only if skill("Enchanting") < 75
step
Open Your Enchanting Crafting Panel:
_<Create 75 Enchant Bracer - Minor Health>_
|tip Use the recipe on a pair of Bracers, either equipped or in your inventory.
|tip You may be able to use it on other players' Bracers to make some profit while increasing your skill level.
Reach Level 75 Enchanting |skill Enchanting,75
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 43.68,63.87 < 5 |walk
talk Lucan Cordell##1317
|tip Inside the building.
Learn Journeyman Enchanting |skillmax Enchanting,150 |goto Stormwind City 42.94,64.64
step
talk Lucan Cordell##1317
|tip Inside the building.
learn Enchant Bracer - Minor Deflect##7428 |goto 42.94,64.64
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 12 Strange Dust##10940
|tip Use your Disenchant ability on level 5-25 green weapons and armor.
collect 12 Lesser Magic Essence##10938
|tip Use your Disenchant ability on level 5-15 green weapons and armor.
|only if skill("Enchanting") < 85
step
Open Your Enchanting Crafting Panel:
_<Create 12 Enchant Bracer - Minor Deflect>_
|tip Use the recipe on a pair of Bracers, either equipped or in your inventory.
|tip You may be able to use it on other players' Bracers to make some profit while increasing your skill level.
Reach Level 85 Enchanting |skill Enchanting,85
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 45 Strange Dust##10940
|tip Use your Disenchant ability on level 5-25 green weapons and armor.
|only if skill("Enchanting") < 100
step
Enter the building |goto Stormwind City 43.68,63.87 < 5 |walk
talk Lucan Cordell##1317
|tip Inside the building.
learn Enchant Bracer - Minor Stamina##7457 |goto Stormwind City 42.94,64.64
step
Open Your Enchanting Crafting Panel:
_<Create 15 Enchant Bracer - Minor Stamina>_
|tip Use the recipe on a pair of Bracers, either equipped or in your inventory.
|tip You may be able to use it on other players' Bracers to make some profit while increasing your skill level.
Reach Level 100 Enchanting |skill Enchanting,100
step
Enter the building |goto Stormwind City 43.68,63.87 < 5 |walk
talk Lucan Cordell##1317
|tip Inside the building.
learn Runed Silver Rod##7795 |goto Stormwind City 42.94,64.64
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 6 Strange Dust##10940
|tip Use your Disenchant ability on level 5-25 green weapons and armor.
collect 3 Greater Magic Essence##10939
|tip Use your Disenchant ability on level 9-15 green armor, and 9-25 green weapons.
|tip You can combine 3 Lesser Magic Essences to create 1 Greater Magic Essence.
collect 1 Silver Rod##6338
|tip This is created by Blacksmiths.
|tip It requires 1 Silver bar and 2 Rough Grinding Stones to craft.
|tip Try to find a Blacksmith to craft it for you.
collect 1 Shadowgem##1210
|tip These are gathered with the Mining Profession.
|only if skill("Enchanting") < 101 or itemcount(6339) < 1
step
Open Your Enchanting Crafting Panel:
_<Create 1 Runed Silver Rod>_
|tip Keep the Runed Silver Rod that you create.
|tip You will need it in your inventory to enchant things.
Reach Level 101 Enchanting |skill Enchanting,101
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 9 Greater Magic Essence##10939
|tip Use your Disenchant ability on level 9-15 green armor, and 9-25 green weapons.
|tip You can combine 3 Lesser Magic Essences to create 1 Greater Magic Essence.
|only if skill("Enchanting") < 110
step
Enter the building |goto Stormwind City 43.68,63.87 < 5 |walk
talk Jessara Cordell##1318
|tip Inside the building.
buy 9 Simple Wood##4470 |goto Stormwind City 42.81,64.39
|only if skill("Enchanting") < 110
step
talk Lucan Cordell##1317
|tip Inside the building.
learn Greater Magic Wand##14807 |goto 42.94,64.64
step
Open Your Enchanting Crafting Panel:
_<Create 9 Greater Magic Wands>_
Reach Level 110 Enchanting |skill Enchanting,110
step
Enter the building |goto Ashenvale 35.64,50.99 < 10 |walk
talk Dalria##3954
|tip Inside the building.
|tip These are limited supply items.
|tip If she doesn't have them for sale, check the Auction House.
buy Formula: Enchant Cloak - Minor Agility##11039 |goto Ashenvale 35.12,52.12
buy Formula: Enchant Bracer - Lesser Strength##11101 |goto Ashenvale 35.12,52.12
step
use the Formula: Enchant Cloak - Minor Agility##11039
learn Enchant Cloak - Minor Agility##13419
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 25 Lesser Astral Essence##10998
|tip Use your Disenchant ability on level 21-25 green weapons and armor.
|only if skill("Enchanting") < 135
step
Open Your Enchanting Crafting Panel:
_<Create 25 Enchant Cloak - Minor Agility>_
|tip Use the recipe on a Cloak, either equipped or in your inventory.
|tip You may be able to use it on other players' Cloak to make some profit while increasing your skill level.
Reach Level 135 Enchanting |skill Enchanting,135
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 40 Soul Dust##11083
|tip Use your Disenchant ability on level 26-35 green weapons and armor.
|only if skill("Enchanting") < 155
step
Enter the building |goto Elwynn Forest 64.42,69.12 < 7 |walk
talk Kitta Firewind##11072
|tip Upstairs inside the building, at the top.
Learn Expert Enchanting |skillmax Enchanting,225 |goto Elwynn Forest 64.93,70.71
step
talk Kitta Firewind##11072
|tip Upstairs inside the building, at the top.
learn Enchant Bracer - Lesser Stamina##13501 |goto 64.93,70.71
step
Open Your Enchanting Crafting Panel:
_<Create 20 Enchant Bracer - Lesser Stamina>_
|tip Use the recipe on a pair of Bracers, either equipped or in your inventory.
|tip You may be able to use it on other players' Bracers to make some profit while increasing your skill level.
Reach Level 155 Enchanting |skill Enchanting,155
step
use the Formula: Enchant Bracer - Lesser Strength##11101
|tip You should have this from earlier in the guide.
learn Enchant Bracer - Lesser Strength##13536
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 2 Greater Astral Essence##11082
|tip Use your Disenchant ability on level 26-30 green weapons and armor.
collect 2 Soul Dust##11083
|tip Use your Disenchant ability on level 26-35 green weapons and armor.
collect Golden Rod##11128
|tip This is created by Blacksmiths.
|tip It requires 1 Gold Bar and 2 Coarse Grinding Stones to craft.
|tip Try to get a Blacksmith to create one for you.
collect 1 Iridescent Pearl##5500
|tip Use the Iridescent Pearl farming guide.
|only if skill("Enchanting") < 151 or itemcount(11130) < 1
step
Enter the building |goto Elwynn Forest 64.42,69.12 < 7 |walk
talk Kitta Firewind##11072
|tip Upstairs inside the building, at the top.
learn Runed Golden Rod##13628 |goto Elwynn Forest 64.92,70.71
step
Open Your Enchanting Crafting Panel:
_<Create 1 Runed Golden Rod>_
|tip Keep the Runed Golden Rod that you create.
|tip You will need it in your inventory to enchant things.
Reach Level 151 Enchanting |skill Enchanting,151
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 18 Soul Dust##11083
|tip Use your Disenchant ability on level 26-35 green weapons and armor.
|only if skill("Enchanting") < 165
step
Open Your Enchanting Crafting Panel:
_<Create 9 Enchant Bracer - Lesser Strength>_
|tip Use the recipe on a pair of Bracers, either equipped or in your inventory.
|tip You may be able to use it on other players' Bracers to make some profit while increasing your skill level.
Reach Level 165 Enchanting |skill Enchanting,165
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 20 Lesser Mystic Essence##11134
|tip Use your Disenchant ability on level 31-35 green weapons and armor.
|only if skill("Enchanting") < 185
step
Enter the building |goto Elwynn Forest 64.42,69.12 < 7 |walk
talk Kitta Firewind##11072
|tip Upstairs inside the building, at the top.
learn Enchant Bracer - Spirit##13642 |goto Elwynn Forest 64.92,70.71
step
Open Your Enchanting Crafting Panel:
_<Create 20 Enchant Bracer - Spirit>_
|tip Use the recipe on a pair of Bracers, either equipped or in your inventory.
|tip You may be able to use it on other players' Bracers to make some profit while increasing your skill level.
Reach Level 185 Enchanting |skill Enchanting,185
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 15 Vision Dust##11137
|tip Use your Disenchant ability on level 36-45 green weapons and armor.
|only if skill("Enchanting") < 200
step
Enter the building |goto Elwynn Forest 64.42,69.12 < 7 |walk
talk Kitta Firewind##11072
|tip Upstairs inside the building, at the top.
learn Enchant Bracer - Strength##13661 |goto Elwynn Forest 64.92,70.71
step
Open Your Enchanting Crafting Panel:
_<Create 15 Enchant Bracer - Strength>_
|tip Use the recipe on a pair of Bracers, either equipped or in your inventory.
|tip You may be able to use it on other players' Bracers to make some profit while increasing your skill level.
Reach Level 200 Enchanting |skill Enchanting,200
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 2 Vision Dust##11137
|tip Use your Disenchant ability on level 36-45 green weapons and armor.
collect 2 Greater Mystic Essence##11135
|tip Use your Disenchant ability on level 36-40 green weapons and armor.
collect Truesilver Rod##11144
|tip This is created by Blacksmiths.
|tip It requires 1 Truesilver Bar and 1 Heavy Grinding Stones to craft.
|tip Try to get a Blacksmith to create one for you.
collect Black Pearl##7971
|tip Use the Black Pearl farming guide.
|only if skill("Enchanting") < 201 or itemcount(11145) < 1
step
Enter the building |goto Elwynn Forest 64.42,69.12 < 7 |walk
talk Kitta Firewind##11072
|tip Upstairs inside the building, at the top.
learn Runed Truesilver Rod##13702 |goto Elwynn Forest 64.92,70.71
step
Open Your Enchanting Crafting Panel:
_<Create 1 Runed Truesilver Rod>_
|tip Keep the Runed Truesilver Rod that you create.
|tip You will need it in your inventory to enchant things.
Reach Level 201 Enchanting |skill Enchanting,201
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 35 Vision Dust##11137
|tip Use your Disenchant ability on level 36-45 green weapons and armor.
|only if skill("Enchanting") < 220
step
Open Your Enchanting Crafting Panel:
_<Create 35 Enchant Bracer - Strength>_
|tip Use the recipe on a pair of Bracers, either equipped or in your inventory.
|tip You may be able to use it on other players' Bracers to make some profit while increasing your skill level.
Reach Level 220 Enchanting |skill Enchanting,220
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 15 Vision Dust##11137
|tip Use your Disenchant ability on level 36-45 green weapons and armor.
|only if skill("Enchanting") < 225
step
Enter the building |goto Elwynn Forest 64.42,69.12 < 7 |walk
talk Kitta Firewind##11072
|tip Upstairs inside the building, at the top.
learn Enchant Cloak - Greater Defense##13746 |goto Elwynn Forest 64.92,70.71
step
Open Your Enchanting Crafting Panel:
_<Create 5 Enchant Cloak - Greater Defense>_
|tip Use the recipe on a Cloak, either equipped or in your inventory.
|tip You may be able to use it on other players' Cloak to make some profit while increasing your skill level.
Reach Level 225 Enchanting |skill Enchanting,225
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 211 Vision Dust##11137
|tip Use your Disenchant ability on level 36-45 green weapons and armor.
|tip You are about to go into the Uldaman dungeon, where the Artisan Enchanting trainer is located.
|tip You need to have enough materials to reach at least Enchanting level 250, so you can learn everything she teaches.
|tip It can be difficult to find a group to help you, so you don't want to have to go more than once.
collect 12g 75s
|tip You will need this amount of gold to be able to learn Artisan Enchanting, and all of the Artisan level recipes the Artisan Enchanting trainer can teach you.
|only if skill("Enchanting") < 300
step
_Enter the Uldaman Dungeon:_
|tip Use the back door entrance at this location.
|tip Enter the cave and follow the path to the swirling portal.
|tip Unless you are already level 60, you will need a group to help you through the dungeon.
|tip Try to put together a group of friends who are okay waiting on you for a few minutes inside the dungeon.
|tip They will be helping you to the Artisan Enchanting trainer, and waiting for you to level up your Enchanting skill.
Click Here After Entering the Uldaman Dungeon |confirm |goto Badlands 65.05,43.45
|only if skill("Enchanting") < 300
step
talk Annora##11073
|tip Inside the Uldaman dungeon.
|tip Follow the arrow in the image below to locate her.
|tip She will only appear once you've killed all of the scorpion enemies near her location.
How to Find Her |image text,Professions_Enchanting_Master_Enchanter_Annora_Uldaman,1024,1024,808,660
|tip Click the line above to display an image.
Learn Artisan Enchanting |skillmax Enchanting,300
step
Open Your Enchanting Crafting Panel:
_<Create 12 Enchant Cloak - Greater Defense>_
|tip Use the recipe on a Cloak, either equipped or in your inventory.
Reach Level 230 Enchanting |skill Enchanting,230
step
talk Annora##11073
|tip Inside the Uldaman dungeon.
learn Enchant Boots - Stamina##13836
step
Open Your Enchanting Crafting Panel:
_<Create 5 Enchant Boots - Stamina>_
|tip Use the recipe on a pair of Boots, either equipped or in your inventory.
Reach Level 235 Enchanting |skill Enchanting,235
step
talk Annora##11073
|tip Inside the Uldaman dungeon.
learn Enchant Chest - Superior Health##13858
step
Open Your Enchanting Crafting Panel:
_<Create 25 Enchant Chest - Superior Health>_
|tip Use the recipe on a Chest armor, either equipped or in your inventory.
Reach Level 250 Enchanting |skill Enchanting,250
step
talk Annora##11073
|tip Inside the Uldaman dungeon.
learn Enchant Chest - Superior Mana##13917
learn Enchant Shield - Greater Spirit##13905
learn Enchant Boots - Agility##13935
learn Enchant 2H Weapon - Greater Impact##13937
learn Enchant Bracer - Greater Strength##13939
learn Enchant Chest - Stats##13942
learn Enchant Weapon - Greater Striking##13943
learn Enchant Gloves - Minor Haste##13948
learn Enchanted Leather##17181
learn Enchanted Thorium##17180
step
_Leave the Uldaman Dungeon:_
|tip You are now done with Enchanting inside the Uldaman dungeon.
|tip You can leave at any time.
Click Here After Leaving the Uldaman Dungeon |confirm
|only if skill("Enchanting") < 300
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 300 Vision Dust##11137
|tip Use your Disenchant ability on level 36-45 green weapons and armor.
|only if skill("Enchanting") < 265
step
Open Your Enchanting Crafting Panel:
_<Create 50 Enchant Chest - Superior Health>_
|tip Use the recipe on a Chest armor, either equipped or in your inventory.
|tip You may be able to use it on other players' Chest armor to make some profit while increasing your skill level.
Reach Level 265 Enchanting |skill Enchanting,265
step
talk Mythrin'dir##4229
|tip Inside the building.
buy Formula: Enchant Shield - Greater Stamina##16217 |goto Darnassus 60.96,17.67
|tip This item is a limited supply item.
|tip It is also bind on pickup, so you can't purchase it from the Auction House.
|tip If he doesn't have it for sale, you will have to wait.
|tip Camp out next to him and keep checking to see if he has it for sale.
step
use the Formula: Enchant Shield - Greater Stamina##16217
learn Enchant Shield - Greater Stamina##20017
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 380 Dream Dust##11176
|tip Use your Disenchant ability on level 46-55 green weapons and armor.
|only if skill("Enchanting") < 294
step
Open Your Enchanting Crafting Panel:
_<Create 38 Enchant Shield - Greater Stamina>_
|tip Use the recipe on a Shield, either equipped or in your inventory.
|tip You may be able to use it on other players' Shield to make some profit while increasing your skill level.
Reach Level 294 Enchanting |skill Enchanting,294
step
Follow the road |goto Moonglade 40.25,37.05 < 30 |only if walking
talk Lorelae Wintersong##12022
|tip Inside the building.
buy Formula: Enchant Cloak - Superior Defense##16224 |goto Moonglade 48.24,40.14
buy Formula: Runed Arcanite Rod##16243 |goto Moonglade 48.24,40.14
|tip These items are limited supply items.
|tip If she doesn't have them for sale, check the Auction House.
step
use the Formula: Enchant Cloak - Superior Defense##16224
learn Enchant Cloak - Superior Defense##20015
step
use the Formula: Runed Arcanite Rod##16243
learn Runed Arcanite Rod##20051
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 10 Illusion Dust##16204
|tip Use your Disenchant ability on level 56-60 green weapons and armor.
collect 4 Greater Eternal Essence##16203
|tip Use your Disenchant ability on level 51-56 green weapons and armor.
collect 4 Small Brilliant Shard##14343
|tip Use your Disenchant ability on level 46-51 blue weapons and armor.
collect 2 Large Brilliant Shard##14344
|tip Use your Disenchant ability on level 51-60 blue weapons and armor.
collect Arcanite Rod##16206
|tip These are made by Blacksmiths.
|tip It takes 3 Arcanite Bars and 1 Dense Grinding Stone to craft.
|tip Try to find a Blacksmith to create one for you.
collect Golden Pearl##13926
|tip Use the Golden Pearl farming guide.
|only if skill("Enchanting") < 295 or itemcount(16207) < 1
step
Open Your Enchanting Crafting Panel:
_<Create 1 Runed Arcanite Rod>_
|tip Keep the Runed Arcanite Rod that you create.
|tip You will need it in your inventory to enchant things.
Reach Level 295 Enchanting |skill Enchanting,295
step
_Disenchant Green Items:_
|tip You can also purchase them from the Auction House.
collect 40 Illusion Dust##16204
|tip Use your Disenchant ability on level 56-60 green weapons and armor.
|only if skill("Enchanting") < 300
step
Open Your Enchanting Crafting Panel:
_<Create 5 Enchant Cloak - Superior Defense>_
|tip Use the recipe on a Cloak, either equipped or in your inventory.
|tip You may be able to use it on other players' Cloak to make some profit while increasing your skill level.
Reach Level 300 Enchanting |skill Enchanting,300
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Engineering\\Engineering (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Engineering') > 0 end,
description="This guide will walk you through leveling your Engineering skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
talk Jemma Quikswitch##11028
|tip Inside the building.
Learn Apprentice Engineering |skillmax Engineering,75 |goto Ironforge 67.66,44.21
step
talk Gearcutter Cogspinner##5175
|tip Inside the building.
buy Blacksmith Hammer##5956 |goto 67.85,42.51
|tip You must have a Blacksmith Hammer in your bags to be able to create some Engineering schematics.
step
collect 60 Rough Stone##2835
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 30
step
Open Your Engineering Crafting Panel:
_<Create 60 Rough Blasting Powder>_
|tip Save these, they will be used in a later schematic.
Reach Level 30 Engineering |skill Engineering,30
collect 60 Rough Blasting Powder##4357 |only if skill("Engineering") < 75
step
talk Jemma Quikswitch##11028
|tip Inside the building
learn Handful of Copper Bolts##3922 |goto Ironforge 67.66,44.21
step
collect 30 Copper Bar##2840
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 50
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 30 Handful of Copper Bolts>_
|tip Save these, they will be used in a later schematic.
Reach Level 50 Engineering |skill Engineering,50 |goto Ironforge 49.83,44.12
collect 30 Handful of Copper Bolts##4359 |only if skill("Engineering") < 75
step
talk Jemma Quikswitch##11028
|tip Inside the building.
learn Arclight Spanner##7430 |goto 67.66,44.21
step
collect 6 Copper Bar##2840
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 51  or itemcount(6219) < 1
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 1 Arclight Spanner>_
|tip Keep the Arclight Spanner that you create.
|tip You will need it in your inventory to create things.
Reach Level 51 Engineering |skill Engineering,51 |goto Ironforge 49.83,44.12
step
talk Jemma Quikswitch##11028
|tip Inside the building.
learn Rough Copper Bomb##3923 |goto 67.66,44.21
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 60 Rough Blasting Powder##4357
|tip You should already these from creating them earlier in the guide.
collect 30 Handful of Copper Bolts##4359
|tip You should already these from creating them earlier in the guide.
collect 30 Copper Bar##2840
|tip If you have the Mining profession, you can gather these.
collect 30 Linen Cloth##2589
|only if skill("Engineering") < 75
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 30 Rough Copper Bombs>_
Reach Level 75 Engineering |skill Engineering,75 |goto 49.83,44.12
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
talk Trixie Quikswitch##11029
|tip Inside the building.
Learn Journeyman Engineering |skillmax Engineering,150 |goto Ironforge 67.48,42.91
step
talk Trixie Quikswitch##11029
|tip Inside the building.
learn Coarse Blasting Powder##3929 |goto 67.48,42.91
step
collect 60 Coarse Stone##2836
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 95
step
Open Your Engineering Crafting Panel:
_<Create 60 Coarse Blasting Powder>_
|tip Save these, they will be used in a later schematic.
Reach Level 95 Engineering |skill Engineering,95
collect 60 Coarse Blasting Powder##4364 |only if skill("Engineering") < 100
step
talk Trixie Quikswitch##11029
|tip Inside the building.
learn Coarse Dynamite##3931 |goto 67.48,42.91
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 60 Coarse Blasting Powder##4364
|tip You should already these from creating them earlier in the guide.
collect 20 Linen Cloth##2589
|only if skill("Engineering") < 100
step
Open Your Engineering Crafting Panel:
_<Create 20 Coarse Dynamite>_
Reach Level 100 Engineering |skill Engineering,100
step
talk Trixie Quikswitch##11029
|tip Inside the building.
learn Silver Contact##3973 |goto 67.48,42.91
step
collect 5 Silver Bar##2842
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 105
step
Open Your Engineering Crafting Panel:
_<Create 5 Silver Contacts>_
Reach Level 105 Engineering |skill Engineering,105
step
talk Trixie Quikswitch##11029
|tip Inside the building.
learn Bronze Tube##3938 |goto 67.48,42.91
step
collect 60 Bronze Bar##2841
|tip If you have the Mining profession, you can create these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 125
step
talk Gearcutter Cogspinner##5175
|tip Inside the building.
buy 30 Weak Flux##2880 |goto Ironforge 67.85,42.51
|only if skill("Engineering") < 125
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 30 Bronze Tubes>_
|tip Save 10 of these, they will be used in a later schematic.
Reach Level 125 Engineering |skill Engineering,125 |goto 49.83,44.12
collect 10 Bronze Tube##4371 |goto 49.83,44.12 |only if skill("Engineering") < 135
step
talk Trixie Quikswitch##11029
|tip Inside the building.
learn Standard Scope##3978 |goto 67.48,42.91
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 10 Bronze Tube##4371
|tip You should already these from creating them earlier in the guide.
collect 10 Moss Agate##1206
|tip If you have the Mining profession, you can gather these.
|only if skill("Engineering") < 135
step
Open Your Engineering Crafting Panel:
_<Create 10 Standard Scopes>_
Reach Level 135 Engineering |skill Engineering,135
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
Learn Expert Engineering |skillmax Engineering,225 |goto Ironforge 68.46,43.56
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
learn Heavy Blasting Powder##3945 |goto 68.46,43.56
step
collect 30 Heavy Stone##2838
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 175
step
Open Your Engineering Crafting Panel:
_<Create 30 Heavy Blasting Powder>_
|tip Save these, they will be used in a later schematic.
Reach Level 140 Engineering |skill Engineering,140
collect 30 Heavy Blasting Powder##4377 |only if skill("Engineering") < 175
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
learn Whirring Bronze Gizmo##3942 |goto 68.46,43.56
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 30 Bronze Bar##2841
|tip If you have the Mining profession, you can create these.
collect 15 Wool Cloth##2592
|only if skill("Engineering") < 175
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 15 Whirring Bronze Gizmos>_
|tip Save these, they will be used in a later schematic.
Reach Level 150 Engineering |skill Engineering,150 |goto 49.83,44.12
collect 15 Whirring Bronze Gizmo##4375 |goto 49.83,44.12 |only if skill("Engineering") < 175
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
learn Bronze Framework##3953 |goto Ironforge 68.46,43.56
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 30 Bronze Bar##2841
|tip If you have the Mining profession, you can create these.
collect 15 Medium Leather##2319
collect 15 Wool Cloth##2592
|only if skill("Engineering") < 175
step
Open Your Engineering Crafting Panel:
_<Create 15 Bronze Frameworks>_
|tip Save these, they will be used in a later schematic.
Reach Level 160 Engineering |skill Engineering,160
collect 15 Bronze Framework##4382 |only if skill("Engineering") < 175
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
learn Explosive Sheep##3955 |goto Ironforge 68.46,43.56
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 30 Heavy Blasting Powder##4377
|tip You should already these from creating them earlier in the guide.
collect 15 Whirring Bronze Gizmo##4375
|tip You should already these from creating them earlier in the guide.
collect 15 Bronze Framework##4382
|tip You should already these from creating them earlier in the guide.
collect 30 Wool Cloth##2592
|only if skill("Engineering") < 175
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 15 Explosive Sheep>_
|tip Keep 5 of these.
|tip They will be needed, if you choose to learn Goblin Engineering later.
Reach Level 175 Engineering |skill Engineering,175 |goto 49.83,44.12
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
learn Gyromatic Micro-Adjustor##12590 |goto 68.46,43.56
step
collect 4 Steel Bar##3859
|tip If you have the Mining profession, you can create these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 176 or itemcount(10498) < 1
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 1 Gyromatic Micro-Adjustor>_
|tip Keep the Gyromatic Micro-Adjustor that you create.
|tip You will need it in your inventory to create things.
Reach Level 176 Engineering |skill Engineering,176 |goto 49.83,44.12
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
learn Solid Blasting Powder##12585 |goto 68.46,43.56
step
collect 120 Solid Stone##7912
|tip If you have the Mining profession, you can create these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 195
step
Open Your Engineering Crafting Panel:
_<Create 60 Solid Blasting Powder>_
|tip Save these, they will be used in a later schematic.
Reach Level 195 Engineering |skill Engineering,195
collect 60 Solid Blasting Powder##10505 |only if skill("Engineering") < 250
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
learn Mithril Tube##12589 |goto 68.46,43.56
step
collect 24 Mithril Bar##3860
|tip If you have the Mining profession, you can create these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 200
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 8 Mithril Tubes>_
|tip Save 6 of these.
|tip They will be needed, if you choose to learn Gnomish Engineering later.
Reach Level 200 Engineering |skill Engineering,200 |goto 49.83,44.12
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
learn Unstable Trigger##12591 |goto Ironforge 68.46,43.56
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 20 Solid Blasting Powder##10505
|tip You should already these from creating them earlier in the guide.
collect 20 Mithril Bar##3860
|tip If you have the Mining profession, you can create these.
collect 20 Mageweave Cloth##4338
|only if skill("Engineering") < 216
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 20 Unstable Triggers>_
|tip Save these, they will be used in a later schematic.
Reach Level 215 Engineering |skill Engineering,215 |goto 49.83,44.12
collect 20 Unstable Trigger##10560 |goto 49.83,44.12 |only if skill("Engineering") < 250
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
talk Buzzek Bracketswing##8736
Learn Artisan Engineering |skillmax Engineering,300 |goto Tanaris 52.34,27.72
step
talk Buzzek Bracketswing##8736
learn Mithril Casing##12599 |goto 52.34,27.72
step
collect 120 Mithril Bar##3860
|tip If you have the Mining profession, you can create these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 238
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 40 Mithril Casings>_
|tip Save these, they will be used in a later schematic.
Reach Level 238 Engineering |skill Engineering,238 |goto Tanaris 51.40,28.72
collect 40 Mithril Casing##10561 |goto Tanaris 51.40,28.72 |only if skill("Engineering") < 250
step
talk Buzzek Bracketswing##8736
learn Hi-Explosive Bomb##12619 |goto 52.34,27.72
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 40 Solid Blasting Powder##10505
|tip You should already these from creating them earlier in the guide.
collect 20 Unstable Trigger##10560
|tip You should already these from creating them earlier in the guide.
collect 40 Mithril Casing##10561
|tip You should already these from creating them earlier in the guide.
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 20 Hi-Explosive Bombs>_
Reach Level 250 Engineering |skill Engineering,250 |goto Tanaris 51.40,28.72
step
talk Buzzek Bracketswing##8736
learn Dense Blasting Powder##19788 |goto 52.34,27.72
step
collect 80 Dense Stone##12365
|tip If you have the Mining profession, you can create these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 260
step
Open Your Engineering Crafting Panel:
_<Create 40 Dense Blasting Powder>_
Reach Level 260 Engineering |skill Engineering,260
step
talk Gearcutter Cogspinner##5175
|tip Inside the building.
buy Schematic: Thorium Widget##16042 |n
|tip This is a limited supply item.
|tip If he doesn't have it for sale, check the Auction House.
use the Schematic: Thorium Widget##16042
learn Thorium Widget##19791 |goto Ironforge 67.84,42.50
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 90 Thorium Bar##12359
|tip If you have the Mining profession, you can create these.
collect 30 Runecloth##14047
|only if skill("Engineering") < 285
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 30 Thorium Widget>_
|tip You may have to make more.
Reach Level 285 Engineering |skill Engineering,285 |goto Ironforge 49.83,44.12
step
Follow the path |goto Winterspring 60.56,38.20 < 7 |only if walking
Enter the building |goto Winterspring 60.86,38.51 < 5 |walk
talk Xizzer Fizzbolt##11185
|tip Inside the building.
buy Schematic: Thorium Tube##16047 |n
|tip This is a limited supply item.
|tip If he doesn't have it for sale, check the Auction House.
use the Schematic: Thorium Tube##16047
learn Thorium Tube##19795 |goto Winterspring 60.81,38.60
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 120 Thorium Bar##12359
|tip If you have the Mining profession, you can create these.
|only if skill("Engineering") < 300
step
Open Your Engineering Crafting Panel:
_<Create 20 Thorium Tubes>_
Reach Level 300 Engineering |skill Engineering,300 |goto Ironforge 49.83,44.12
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Leatherworking\\Leatherworking (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Leatherworking') > 0 end,
description="This guide will walk you through leveling your Leatherworking skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Ironforge 41.98,33.37 < 7 |only if walking
Enter the building |goto Ironforge 40.36,35.48 < 5 |walk
talk Gretta Finespindle##1466
|tip Downstairs inside the building.
Learn Apprentice Leatherworking |skillmax Leatherworking,75 |goto Ironforge 38.82,32.86
step
collect 57 Ruined Leather Scraps##2934
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 20
step
Open Your Leatherworking Crafting Panel:
_<Create 19 Light Leather>_
|tip Save these, they will be used in a later pattern.
Reach Level 20 Leatherworking |skill Leatherworking,20
collect 19 Light Leather##2318 |only if skill("Leatherworking") < 55
step
collect 30 Light Leather##2318
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 45
step
Open Your Leatherworking Crafting Panel:
_<Create 30 Light Leather Kits>_
Reach Level 45 Leatherworking |skill Leatherworking,45
step
collect 40 Light Leather##2318
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 55
step
Run up the stairs |goto Ironforge 41.98,33.37 < 7 |only if walking
Enter the building |goto Ironforge 40.36,35.48 < 5 |walk
talk Bombus Finespindle##5128
|tip Downstairs inside the building.
buy 20 Coarse Thread##2320 |goto Ironforge 39.62,34.47
|only if skill("Leatherworking") < 55
step
Open Your Leatherworking Crafting Panel:
_<Create 20 Handstitched Leather Cloaks>_
Reach Level 55 Leatherworking |skill Leatherworking,55
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Ironforge 41.98,33.37 < 7 |only if walking
Enter the building |goto Ironforge 40.36,35.48 < 5 |walk
talk Fimble Finespindle##5127
|tip Downstairs inside the building.
Learn Journeyman Leatherworking |skillmax Leatherworking,150 |goto Ironforge 40.23,33.66
step
talk Gretta Finespindle##1466
|tip Downstairs inside the building.
learn Embossed Leather Gloves##3756 |goto 38.84,32.85
step
collect 180 Light Leather##2318
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 100
step
Run up the stairs |goto Ironforge 41.98,33.37 < 7 |only if walking
Enter the building |goto Ironforge 40.36,35.48 < 5 |walk
talk Bombus Finespindle##5128
|tip Downstairs inside the building.
buy 120 Coarse Thread##2320 |goto Ironforge 39.62,34.47
|only if skill("Leatherworking") < 100
step
Open Your Leatherworking Crafting Panel:
_<Create 50 Embossed Leather Gloves>_
Reach Level 100 Leatherworking |skill Leatherworking,100
step
collect 210 Light Leather##2318
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 125
step
Run up the stairs |goto Ironforge 41.98,33.37 < 7 |only if walking
Enter the building |goto Ironforge 40.36,35.48 < 5 |walk
talk Bombus Finespindle##5128
|tip Downstairs inside the building.
buy 70 Coarse Thread##2320 |goto Ironforge 39.62,34.47
|only if skill("Leatherworking") < 125
step
talk Fimble Finespindle##5127
|tip Downstairs inside the building.
learn Fine Leather Belt##3763 |goto 40.23,33.66
step
Open Your Leatherworking Crafting Panel:
_<Create 35 Fine Leather Belts>_
Reach Level 125 Leatherworking |skill Leatherworking,125
step
talk Fimble Finespindle##5127
|tip Downstairs inside the building.
learn Dark Leather Boots##2167 |goto 40.23,33.66
step
collect 80 Medium Leather##2319
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 137
step
Run up the stairs |goto Ironforge 41.98,33.37 < 7 |only if walking
Enter the building |goto Ironforge 40.36,35.48 < 5 |walk
talk Bombus Finespindle##5128
|tip Downstairs inside the building.
buy 40 Fine Thread##2321 |goto Ironforge 39.62,34.47
buy 20 Gray Dye##4340 |goto Ironforge 39.62,34.47
|only if skill("Leatherworking") < 137
step
Open Your Leatherworking Crafting Panel:
_<Create 20 Dark Leather Boots>_
Reach Level 137 Leatherworking |skill Leatherworking,137
step
talk Fimble Finespindle##5127
|tip Downstairs inside the building.
learn Dark Leather Pants##7135 |goto 40.23,33.66
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
talk Telonis##4212
|tip Upstairs inside the building.
Learn Expert Leatherworking |skillmax Leatherworking,225 |goto Darnassus 64.43,21.54
step
collect 240 Medium Leather##2319
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 150
step
talk Saenorion##4225
|tip Upstairs inside the building.
buy 20 Fine Thread##2321 |goto Darnassus 63.70,22.28
buy 20 Gray Dye##4340 |goto Darnassus 63.70,22.28
|only if skill("Leatherworking") < 150
step
Open Your Leatherworking Crafting Panel:
_<Create 20 Dark Leather Pants>_
Reach Level 150 Leatherworking |skill Leatherworking,150
step
talk Telonis##4212
|tip Upstairs inside the building.
learn Heavy Leather##20649 |goto 64.43,21.54
step
collect 40 Medium Leather##2319
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 155
step
Open Your Leatherworking Crafting Panel:
_<Create 8 Heavy Leather>_
Reach Level 155 Leatherworking |skill Leatherworking,155
step
collect 20 Heavy Hide##4235
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 200
step
talk Saenorion##4225
|tip Upstairs inside the building.
buy 60 Salt##4289 |goto Darnassus 63.70,22.28
|only if skill("Leatherworking") < 200
step
talk Telonis##4212
|tip Upstairs inside the building.
learn Cured Heavy Hide##3818 |goto 64.43,21.54
step
Open Your Leatherworking Crafting Panel:
_<Create 20 Cured Heavy Hides>_
|tip Save these, they will be used in a later recipe.
Reach Level 165 Leatherworking |skill Leatherworking,165
collect 20 Cured Heavy Hide##4236 |only if skill("Leatherworking") < 200
step
talk Telonis##4212
|tip Upstairs inside the building.
learn Heavy Armor Kit##3780 |goto 64.43,21.54
step
collect 125 Heavy Leather##4234
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 180
step
talk Saenorion##4225
|tip Upstairs inside the building.
buy 25 Fine Thread##2321 |goto 63.70,22.28
|only if skill("Leatherworking") < 180
step
Open Your Leatherworking Crafting Panel:
_<Create 25 Heavy Armor Kit>_
Reach Level 180 Leatherworking |skill Leatherworking,180
step
talk Telonis##4212
|tip Upstairs inside the building.
learn Barbaric Shoulders##7151 |goto 64.43,21.54
step
_Collect These Items:_
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 80 Heavy Leather##4234
collect 10 Cured Heavy Hide##4236
|tip You should already have these from earlier in the guide.
|only if skill("Leatherworking") < 190
step
talk Saenorion##4225
|tip Upstairs inside the building.
buy 20 Fine Thread##2321 |goto 63.70,22.28
|only if skill("Leatherworking") < 190
step
Open Your Leatherworking Crafting Panel:
_<Create 10 Barbaric Shoulders>_
Reach Level 190 Leatherworking |skill Leatherworking,190
step
talk Telonis##4212
|tip Upstairs inside the building.
learn Guardian Gloves##7156 |goto 64.43,21.54
step
_Collect These Items:_
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 40 Heavy Leather##4234
collect 10 Cured Heavy Hide##4236
|tip You should already have these from earlier in the guide.
|only if skill("Leatherworking") < 200
step
talk Saenorion##4225
|tip Upstairs inside the building.
buy 10 Silken Thread##4291 |goto 63.70,22.28
|only if skill("Leatherworking") < 200
step
Open Your Leatherworking Crafting Panel:
_<Create 10 Guardian Gloves>_
Reach Level 200 Leatherworking |skill Leatherworking,200
step
talk Telonis##4212
|tip Upstairs inside the building.
learn Thick Armor Kit##10487 |goto 64.43,21.54
step
talk Saenorion##4225
|tip Upstairs inside the building.
buy 5 Silken Thread##4291 |goto 63.70,22.28
|only if skill("Leatherworking") < 205
step
collect 25 Thick Leather##4304
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 205
step
Open Your Leatherworking Crafting Panel:
_<Create 5 Thick Armor Kits>_
|tip You may need to make more.
Reach Level 205 Leatherworking |skill Leatherworking,205
step
Reach Level 35 |ding 35
|tip You must be at least this level before you can learn the next rank of this profession.
|tip Use the Leveling guides to accomplish this.
step
collect 200 Thick Leather##4304
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 235
step
Enter the building |goto The Hinterlands 14.17,45.22 < 20 |walk
Run down the stairs |goto The Hinterlands 13.18,43.43 < 5 |walk
talk Drakk Stonehand##11097
|tip Downstairs inside the building.
Learn Artisan Leatherworking |skillmax Leatherworking,300 |goto The Hinterlands 13.39,43.48
step
talk Drakk Stonehand##11097
|tip Downstairs inside the building.
learn Nightscape Headband##10507 |goto 13.39,43.48
step
talk Nioma##8160
|tip Downstairs inside the building.
buy 80 Silken Thread##4291 |goto 13.30,43.37
|only if skill("Leatherworking") < 235
step
Open Your Leatherworking Crafting Panel:
_<Create 40 Nightscape Headbands>_
Reach Level 235 Leatherworking |skill Leatherworking,235
step
talk Drakk Stonehand##11097
|tip Downstairs inside the building.
learn Nightscape Pants##10548 |goto 13.39,43.48
step
collect 210 Thick Leather##4304
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 250
step
Enter the building |goto The Hinterlands 14.17,45.22 < 20 |walk
Run down the stairs |goto The Hinterlands 13.18,43.43 < 5 |walk
talk Nioma##8160
|tip Downstairs inside the building.
buy 60 Silken Thread##4291 |goto The Hinterlands 13.30,43.37
|only if skill("Leatherworking") < 250
step
Open Your Leatherworking Crafting Panel:
_<Create 15 Nightscape Pants>_
Reach Level 250 Leatherworking |skill Leatherworking,250
step
talk Drakk Stonehand##11097
|tip Downstairs inside the building.
learn Rugged Armor Kit##19058 |goto 13.39,43.48
step
collect 175 Rugged Leather##8170
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 265
step
Open Your Leatherworking Crafting Panel:
_<Create 35 Rugged Armor Kits>_
Reach Level 265 Leatherworking |skill Leatherworking,265
step
Follow the path |goto Azshara 33.91,45.33 < 30 |only if walking
Continue following the path |goto Azshara 43.23,36.72 < 30 |only if walking
kill Legashi Rogue##6201+
|tip They look like blue satyrs around this area.
collect Pattern: Wicked Leather Bracers##15728 |n
|tip You can also purchase this from the Auction House, if you don't want to grind for it.
use the Pattern: Wicked Leather Bracers##15728
learn Wicked Leather Bracers##19052 |goto Azshara 51.87,18.36
You can find more Legashi Rogues around:
[Azshara 61.09,24.69]
[Azshara 66.08,16.85]
step
collect 240 Rugged Leather##8170
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 290
step
Enter the building |goto The Hinterlands 14.17,45.22 < 20 |walk
Run down the stairs |goto The Hinterlands 13.18,43.43 < 5 |walk
talk Nioma##8160
|tip Downstairs inside the building.
buy 30 Black Dye##2325 |goto The Hinterlands 13.30,43.37
buy 30 Rune Thread##14341 |goto The Hinterlands 13.30,43.37
|only if skill("Leatherworking") < 290
step
Open Your Leatherworking Crafting Panel:
_<Create 30 Wicked Leather Bracers>_
Reach Level 290 Leatherworking |skill Leatherworking,290
step
Follow the path up |goto Felwood 43.08,21.31 < 20 |only if walking
kill Jadefire Trickster##7107+
collect Pattern: Wicked Leather Headband##15744 |n
|tip You can also purchase this from the Auction House, if you don't want to grind for it.
use the Pattern: Wicked Leather Headband##15744
learn Wicked Leather Headband##19071 |goto Felwood 42.00,18.87
You can find more Jadefire Tricksters around:
[Felwood 42.87,15.20]
[Felwood 39.53,20.61]
step
collect 120 Rugged Leather##8170
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 300
step
Enter the building |goto The Hinterlands 14.17,45.22 < 20 |walk
Run down the stairs |goto The Hinterlands 13.18,43.43 < 5 |walk
talk Nioma##8160
|tip Downstairs inside the building.
buy 10 Black Dye##2325 |goto The Hinterlands 13.30,43.37
buy 10 Rune Thread##14341 |goto The Hinterlands 13.30,43.37
|only if skill("Leatherworking") < 300
step
Open Your Leatherworking Crafting Panel:
_<Create 10 Wicked Leather Headbands>_
Reach Level 300 Leatherworking |skill Leatherworking,300
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Tailoring\\Tailoring (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Tailoring') > 0 end,
description="This guide will walk you through leveling your Tailoring skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least level 5 before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 44.54,73.90 < 5 |walk
talk Lawrence Schneider##1300
|tip Inside the building.
Learn Apprentice Tailoring |skillmax Tailoring,75 |goto Stormwind City 43.69,73.71
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 204 Linen Cloth##2589
|only if skill("Tailoring") < 50
step
Open Your Tailoring Crafting Panel:
_<Create 102 Bolts of Linen Cloth>_
|tip Save these, they will be used in a later pattern.
Reach Level 45 Tailoring |skill Tailoring,45
collect 102 Bolt of Linen Cloth##2996 |only if skill("Tailoring") < 110
step
Enter the building |goto Stormwind City 44.54,73.90 < 5 |walk
talk Lawrence Schneider##1300
|tip Inside the building.
learn Linen Belt##8776 |goto Stormwind City 43.69,73.71
step
talk Alexandra Bolero##1347
|tip Inside the building.
buy 40 Coarse Thread##2320 |goto 43.26,74.08
|only if skill("Tailoring") < 70
step
Open Your Tailoring Crafting Panel:
_<Create 40 Linen Belts>_
Reach Level 70 Tailoring |skill Tailoring,70
step
talk Lawrence Schneider##1300
|tip Inside the building.
learn Reinforced Linen Cape##2397 |goto 43.69,73.71
step
talk Alexandra Bolero##1347
|tip Inside the building.
buy 15 Coarse Thread##2320 |goto 43.26,74.08
|only if skill("Tailoring") < 75
step
Open Your Tailoring Crafting Panel:
_<Create 5 Reinforced Linen Capes>_
Reach Level 75 Tailoring |skill Tailoring,75
step
Reach Level 10 |ding 10
|tip You must be at least level 10 to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 41.64,77.54 < 5 |walk
talk Sellandus##5567
|tip Inside the building.
Learn Journeyman Tailoring |skillmax Tailoring,150 |goto Stormwind City 42.06,75.77
step
talk Sellandus##5567
|tip Inside the building.
learn Bolt of Woolen Cloth##2964 |goto 42.06,75.77
step
collect 135 Wool Cloth##2592
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Tailoring") < 100
step
Open Your Tailoring Crafting Panel:
_<Create 45 Bolts of Woolen Cloth>_
|tip Save these, they will be used in a later pattern.
Reach Level 100 Tailoring |skill Tailoring,100
collect 45 Bolt of Woolen Cloth##2997 |only if skill("Tailoring") < 125
step
Enter the building |goto 41.64,77.54 < 5 |walk
talk Sellandus##5567
|tip Inside the building.
learn Simple Kilt##12046 |goto 42.06,75.77
step
Enter the building |goto 44.54,73.90 < 5 |walk
talk Alexandra Bolero##1347
|tip Inside the building.
buy 13 Fine Thread##2321 |goto 43.26,74.08
|only if skill("Tailoring") < 110
step
Open Your Tailoring Crafting Panel:
_<Create 13 Simple Kilts>_
Reach Level 110 Tailoring |skill Tailoring,110
step
Leave the building |goto 44.54,73.90 < 5 |walk
Enter the building |goto 41.64,77.54 < 5 |walk
talk Sellandus##5567
|tip Inside the building.
learn Double-stitched Woolen Shoulders##3848 |goto 42.06,75.77
step
Leave the building |goto 41.64,77.54 < 5 |walk
Enter the building |goto 44.54,73.90 < 5 |walk
talk Alexandra Bolero##1347
|tip Inside the building.
buy 30 Fine Thread##2321 |goto 43.26,74.08
|only if skill("Tailoring") < 125
step
Open Your Tailoring Crafting Panel:
_<Create 15 Double-stitched Woolen Shoulders>_
Reach Level 125 Tailoring |skill Tailoring,125
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto 44.54,73.90 < 5 |walk
talk Georgio Bolero##1346
|tip Inside the building.
Learn Expert Tailoring |skillmax Tailoring,225 |goto 43.17,73.55
step
talk Georgio Bolero##1346
|tip Inside the building.
learn Bolt of Silk Cloth##3839 |goto 43.17,73.55
step
collect 804 Silk Cloth##4306
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Tailoring") < 145
step
Open Your Tailoring Crafting Panel:
_<Create 201 Bolts of Silk Cloth>_
|tip Save these, they will be used in a later pattern.
Reach Level 145 Tailoring |skill Tailoring,145
collect 201 Bolt of Silk Cloth##4305 |only if skill("Tailoring") < 215
step
Enter the building |goto 44.54,73.90 < 5 |walk
talk Georgio Bolero##1346
|tip Inside the building.
learn Azure Silk Hood##8760 |goto 43.17,73.55
step
talk Alexandra Bolero##1347
|tip Inside the building.
buy 18 Fine Thread##2321 |goto 43.26,74.08
buy 36 Blue Dye##6260 |goto 43.26,74.08
|only if skill("Tailoring") < 160
step
Open Your Tailoring Crafting Panel:
_<Create 18 Azure Silk Hoods>_
Reach Level 160 Tailoring |skill Tailoring,160
step
talk Georgio Bolero##1346
|tip Inside the building.
learn Silk Headband##8762 |goto 43.17,73.55
step
talk Alexandra Bolero##1347
|tip Inside the building.
buy 20 Fine Thread##2321 |goto 43.26,74.08
|only if skill("Tailoring") < 170
step
Open Your Tailoring Crafting Panel:
_<Create 10 Silk Headbands>_
Reach Level 170 Tailoring |skill Tailoring,170
step
talk Georgio Bolero##1346
|tip Inside the building.
learn Formal White Shirt##3871 |goto 43.17,73.55
step
talk Alexandra Bolero##1347
|tip Inside the building.
buy 10 Bleach##2324 |goto 43.26,74.08
buy 5 Fine Thread##2321 |goto 43.26,74.08
|only if skill("Tailoring") < 175
step
Open Your Tailoring Crafting Panel:
_<Create 5 Formal White Shirts>_
Reach Level 175 Tailoring |skill Tailoring,175
step
talk Georgio Bolero##1346
|tip Inside the building.
learn Bolt of Mageweave##3865 |goto 43.17,73.55
step
collect 500 Mageweave Cloth##4338
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Tailoring") < 185
step
Open Your Tailoring Crafting Panel:
_<Create 100 Bolts of Mageweave>_
|tip Save these, they will be used in a later recipe.
Reach Level 185 Tailoring |skill Tailoring,185
collect 100 Bolt of Mageweave##4339 |only if skill("Tailoring") < 250
step
Enter the building |goto 44.54,73.90 < 5 |walk
talk Georgio Bolero##1346
|tip Inside the building.
learn Crimson Silk Vest##8791 |goto 43.17,73.55
step
talk Alexandra Bolero##1347
|tip Inside the building.
buy 30 Fine Thread##2321 |goto 43.26,74.08
buy 30 Red Dye##2604 |goto 43.26,74.08
|only if skill("Tailoring") < 200
step
Open Your Tailoring Crafting Panel:
_<Create 15 Crimson Silk Vests>_
Reach Level 200 Tailoring |skill Tailoring,200
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Dustwallow Marsh 66.12,51.55 < 5 |walk
talk Timothy Worthington##11052
|tip Upstairs inside the building.
Learn Artisan Tailoring |skillmax Tailoring,300 |goto Dustwallow Marsh 66.18,51.81
step
talk Timothy Worthington##11052
|tip Upstairs inside the building.
learn Crimson Silk Pantaloons##8799 |goto 66.18,51.81
step
talk Helenia Olden##4897
|tip Inside the building.
buy 30 Red Dye##2604 |goto 66.44,51.46
buy 30 Silken Thread##4291 |goto 66.44,51.46
|only if skill("Tailoring") < 215
step
Open Your Tailoring Crafting Panel:
_<Create 15 Crimson Silk Pantaloons>_
Reach Level 215 Tailoring |skill Tailoring,215
step
talk Timothy Worthington##11052
|tip Upstairs inside the building.
learn Orange Mageweave Shirt##12061 |goto 66.18,51.81
step
talk Helenia Olden##4897
|tip Inside the building.
buy 5 Orange Dye##6261 |goto 66.44,51.46
buy 5 Heavy Silken Thread##8343 |goto 66.44,51.46
|only if skill("Tailoring") < 220
step
Open Your Tailoring Crafting Panel:
_<Create 5 Orange Mageweave Shirts>_
Reach Level 220 Tailoring |skill Tailoring,220
step
talk Timothy Worthington##11052
|tip Upstairs inside the building.
learn Black Mageweave Gloves##12053 |goto 66.18,51.81
step
talk Helenia Olden##4897
|tip Inside the building.
buy 20 Heavy Silken Thread##8343 |goto 66.44,51.46
|only if skill("Tailoring") < 230
step
Open Your Tailoring Crafting Panel:
_<Create 10 Black Mageweave Gloves>_
Reach Level 230 Tailoring |skill Tailoring,230
step
talk Timothy Worthington##11052
|tip Upstairs inside the building.
learn Black Mageweave Headband##12072 |goto 66.18,51.81
step
talk Helenia Olden##4897
|tip Inside the building.
buy 50 Heavy Silken Thread##8343 |goto 66.44,51.46
|only if skill("Tailoring") < 250
step
Open Your Tailoring Crafting Panel:
_<Create 25 Black Mageweave Headbands>_
Reach Level 250 Tailoring |skill Tailoring,250
step
talk Timothy Worthington##11052
|tip Upstairs inside the building.
learn Bolt of Runecloth##18401 |goto 66.18,51.81
step
collect 1235 Runecloth##14047
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Tailoring") < 260
step
Open Your Tailoring Crafting Panel:
_<Create 247 Bolts of Runecloth>_
|tip Save these, they will be used in a later recipe.
Reach Level 260 Tailoring |skill Tailoring,260
collect 247 Bolt of Runecloth##14048 |only if skill("Tailoring") < 300
step
Enter the building |goto 66.12,51.55 < 5 |walk
talk Timothy Worthington##11052
|tip Upstairs inside the building.
learn Runecloth Belt##18402 |goto 66.18,51.81
step
talk Helenia Olden##4897
|tip Inside the building.
buy 25 Rune Thread##14341 |goto 66.44,51.46
|only if skill("Tailoring") < 280
step
Open Your Tailoring Crafting Panel:
_<Create 25 Runecloth Belts>_
Reach Level 280 Tailoring |skill Tailoring,280
step
Enter the building |goto Winterspring 61.33,37.35 < 5 |walk
talk Qia##11189
|tip Inside the building.
buy 38 Rune Thread##14341 |goto Winterspring 61.20,37.21
|only if skill("Tailoring") < 300
step
talk Qia##11189
|tip Inside the building.
buy Pattern: Runecloth Bag##14468 |n
|tip This is a limited supply item.
|tip If she doesn't have it for sale, check the Auction House.
use the Pattern: Runecloth Bag##14468
learn Runecloth Bag##18405 |goto 61.20,37.21
step
collect 118 Rugged Leather##8170
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Tailoring") < 300
step
Open Your Tailoring Crafting Panel:
_<Create 18 Runecloth Bags>_
Reach Level 290 Tailoring |skill Tailoring,290
step
Enter the building |goto 61.33,37.35 < 5 |walk
talk Qia##11189
|tip Inside the building.
buy Pattern: Runecloth Gloves##14481
|tip This is a limited supply item.
|tip If she doesn't have it for sale, check the Auction House.
use Pattern: Runecloth Gloves##14481
learn Runecloth Gloves##18417 |goto 61.20,37.21
step
Open Your Tailoring Crafting Panel:
_<Create 20 Runecloth Gloves>_
Reach Level 300 Tailoring |skill Tailoring,300
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Herbalism\\Herbalism (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Herbalism') > 0 end,
description="This guide will walk you through leveling your Herbalism skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
talk Tannysa##5566
Learn Apprentice Herbalism |skillmax Herbalism,75 |goto Stormwind City 44.74,77.11
step
map Elwynn Forest
path	follow smart;	loop on;	ants curved;	dist 30
path	35.16,58.15	35.80,61.90	34.96,66.91	35.08,70.72	34.97,74.55
path	31.26,76.29	29.39,72.28	26.34,77.16	26.78,84.53	26.01,88.87
path	28.95,85.90	31.32,84.53	34.00,86.31	35.63,87.61	40.33,90.30
path	42.44,85.05	42.33,79.53	44.78,75.63	57.19,75.30	61.71,78.02
path	64.64,80.21	66.96,82.28	71.53,82.34	74.86,79.96	85.15,82.86
path	88.50,76.38	87.13,70.90	86.64,64.81	83.70,60.88	78.23,58.27
path	74.68,59.68	70.59,61.28	67.25,64.47	63.72,65.35	60.60,62.03
path	56.21,61.31	51.67,60.44	49.08,59.49	44.65,55.81	42.02,54.40
path	39.16,55.56
Reach Level 50 Herbalism |skill Herbalism,50
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
step
map Elwynn Forest
path	follow smart;	loop on;	ants curved;	dist 30
path	37.69,50.56	37.74,52.72	40.46,52.58	44.68,49.88	47.75,50.98
path	50.11,53.78	51.22,59.12	53.58,60.05	55.86,57.19	58.11,58.67
path	61.20,55.26	63.90,54.16	65.95,58.60	68.39,54.25	67.30,49.51
path	66.94,46.11	64.93,39.76	68.35,38.37	73.03,36.59	78.22,39.11
path	80.09,41.77	81.52,47.88	81.14,54.53	84.76,60.10	88.26,63.13
path	89.58,67.45	86.13,79.13	83.85,81.99	79.68,75.80	74.93,72.40
path	71.73,71.92	66.40,71.08	64.94,72.55	60.59,74.44	58.98,78.43
path	55.19,81.63	51.23,81.44	50.22,73.66	44.38,68.40	42.59,67.01
path	39.55,56.74
Reach Level 75 Herbalism |skill Herbalism,75
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
talk Tannysa##5566
Learn Journeyman Herbalism |skillmax Herbalism,150 |goto Stormwind City 44.74,77.11
step
map Loch Modan
path	follow smart;	loop on;	ants curved;	dist 30
path	40.49,37.53	40.59,34.21	40.62,31.51	42.55,17.23	47.47,22.19
path	50.74,28.53	55.34,27.94	56.36,15.76	62.98,23.92	65.54,30.38
path	68.61,50.11	63.36,56.97	56.49,65.33	49.71,69.45	42.94,61.42
path	40.69,53.45	38.36,47.24	35.90,38.71
Reach Level 115 Herbalism |skill Herbalism,115
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
step
map Stranglethorn Vale
path	follow smart;	loop on;	ants curved;	dist 30
path	40.4,6.9	46.1,5.7	49.2,10.3	46.1,12.8	46.1,15.9
path	48.7,21.3	49.9,26.5	48.4,43.2	46.4,45.0	42.3,45.0
path	38.2,49.0	38.1,35.5	35.2,24.8	34.1,16.7	32.3,17.3
path	28.0,17.7	25.6,17.1	23.1,14.0	27.0,13.5	26.8,8.1
path	28.8,6.9	31.1,9.2	33.7,5.9	35.8,6.1
Reach Level 140 Herbalism |skill Herbalism,140
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
talk Tannysa##5566
Learn Expert Herbalism |skillmax Herbalism,225 |goto Stormwind City 44.74,77.11
step
map Stranglethorn Vale
path	follow smart;	loop on;	ants curved;	dist 30
path	40.4,6.9	46.1,5.7	49.2,10.3	46.1,12.8	46.1,15.9
path	48.7,21.3	49.9,26.5	48.4,43.2	46.4,45.0	42.3,45.0
path	38.2,49.0	38.1,35.5	35.2,24.8	34.1,16.7	32.3,17.3
path	28.0,17.7	25.6,17.1	23.1,14.0	27.0,13.5	26.8,8.1
path	28.8,6.9	31.1,9.2	33.7,5.9	35.8,6.1
Reach Level 160 Herbalism |skill Herbalism,160
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
step
map Swamp of Sorrows
path	follow smart;	loop on;	ants curved;	dist 30
path	20.50,54.53	16.62,58.22	15.71,65.71	12.68,68.05	10.73,63.62
path	12.41,55.83	15.50,47.83	18.39,45.92	22.07,39.95	28.92,38.70
path	33.28,38.90	38.62,34.97	47.12,33.93	51.82,34.91	51.62,41.06
path	44.78,45.30	37.49,50.34	33.07,52.19	27.05,54.68	22.47,57.13
Reach Level 205 Herbalism |skill Herbalism,205
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
|tip Watch out for horde guards along the main road.
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
talk Tannysa##5566
Learn Artisan Herbalism |skillmax Herbalism,300 |goto Stormwind City 44.74,77.11
step
map Blasted Lands
path	follow smart;	loop on;	ants curved;	dist 30
path	59.95,26.91	63.87,32.24	62.52,37.16	61.93,40.77	63.59,47.87
path	60.16,47.06	56.61,47.07	52.58,50.11	48.61,51.34	45.83,49.50
path	46.56,43.37	45.38,37.03	44.55,26.43	45.95,23.01	49.76,23.71
path	51.28,26.22	52.49,31.62	51.40,36.19	53.41,38.07	55.97,36.24
path	57.46,32.43	58.67,28.99
Reach Level 275 Herbalism |skill Herbalism,275
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
|tip You won't be able to gather Sungrass until level 230 Herbalism.
|tip You Won't be able to gather Gromsblood until level 250 Herbalism.
step
map Azshara
path	follow smart;	loop on;	ants curved;	dist 30
path	44.24,35.76	44.97,34.08	45.34,30.56	45.01,27.72	44.00,22.97
path	44.61,20.55	45.91,19.60	48.17,18.74	50.79,18.10	52.77,19.45
path	53.43,20.10	54.10,20.23	56.85,20.66	59.23,18.80	61.89,16.89
path	64.79,17.01	66.41,15.27	69.57,16.37	71.70,16.63	73.96,18.69
path	75.86,21.19	76.87,24.70	79.46,24.05	79.40,26.62	77.14,28.54
path	74.71,29.28	71.72,29.19	69.51,28.09	67.74,26.09	64.29,23.93
path	61.47,23.67	59.32,24.37	56.53,25.81	54.31,28.58	52.61,32.17
path	49.37,31.47	46.94,31.71
Reach Level 285 Herbalism |skill Herbalism,285
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
step
map Eastern Plaguelands
path	follow smart;	loop on;	ants curved;	dist 30
path	63.32,54.67	67.59,55.28	72.06,54.50	75.06,53.69	77.43,53.29
path	78.36,55.80	79.17,59.16	80.07,63.69	80.31,67.80	78.88,71.68
path	76.88,73.45	75.52,74.46	74.76,76.67	72.94,78.41	68.81,75.52
path	66.81,76.30	65.03,73.91	64.71,69.43	63.81,66.25	63.25,64.01
path	63.98,59.07
Reach Level 300 Herbalism |skill Herbalism,300
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Mining\\Mining (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Mining') > 0 end,
description="This guide will walk you through leveling your Mining skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 52.41,16.18 < 5 |walk
talk Gelman Stonehand##5513
|tip Upstairs inside the building.
Learn Apprentice Mining |skillmax Mining,75 |goto Stormwind City 51.19,17.31
step
talk Brooke Stonebraid##5514
|tip Inside the building.
buy Mining Pick##2901 |goto 51.02,16.86
|tip You must have a Mining Pick in your bags to be able to gather ore.
step
map Elwynn Forest
path	follow smart;	loop on;	ants curved;	dist 10
path	30.84,52.85	31.66,56.55	30.70,59.27	33.97,61.71	32.67,69.74
path	34.82,71.77	38.65,70.47	41.90,72.73	38.79,78.16	36.73,83.14
path	38.86,85.10	40.47,81.19	42.54,75.73	43.46,72.43	45.88,71.66
path	48.66,72.57	50.67,73.61	52.16,76.22	51.59,81.68	50.51,84.27
path	52.44,85.57	54.07,81.63	55.50,80.65	57.18,77.77	59.76,76.99
path	64.90,71.42	66.82,69.10	70.81,68.32	75.97,68.43	74.95,64.93
path	73.11,60.29	76.43,54.83	77.84,50.88	75.35,46.25	73.10,46.01
path	71.20,49.01	71.93,55.39	68.33,54.29	67.11,57.66	65.88,58.62
path	65.45,55.47	63.86,53.92	61.15,54.32	59.49,56.50	57.71,57.94
path	55.65,58.04	53.51,57.94	52.34,58.34	51.04,58.74	49.28,57.01
path	50.05,53.17	48.15,51.19	47.15,49.29	43.66,49.22	41.39,51.02
path	39.84,53.01	36.99,52.64	34.92,51.69	35.76,48.57	34.85,46.74
Reach Level 65 Mining |skill Mining,65
|tip Click ore as you follow the path around this area.
|tip Track them on your minimap with "Find Minerals".
|tip You can smelt Copper Ore from skill level 1-47 for additional points.
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 52.41,16.18 < 5 |walk
talk Gelman Stonehand##5513
|tip Upstairs inside the building.
Learn Journeyman Mining |skillmax Mining,150 |goto Stormwind City 51.19,17.31
step
map Wetlands
path	follow smart;	loop on;	ants curved;	dist 10
path	34.74,16.82	36.33,18.75	39.75,20.23	43.44,23.27	46.05,22.77
path	48.20,23.86	49.91,23.03	53.21,23.66	55.80,22.78	57.30,23.64
path	58.74,23.33	60.36,21.58	61.25,24.78	63.07,26.13	64.55,28.11
path	63.58,30.34	64.11,33.78	65.20,39.01	67.23,42.83	71.03,45.91
path	70.92,50.14	67.86,53.66	67.02,56.69	66.31,60.65	66.18,65.59
path	67.37,73.31	59.48,72.47	57.49,74.14	56.16,78.29	54.13,78.16
path	54.29,74.22	54.19,68.98	56.08,60.41	56.30,58.46	55.28,53.86
path	53.93,48.40	52.05,43.80	48.11,40.65	44.62,39.47	42.08,40.16
path	38.66,37.95	34.42,38.78
Reach Level 125 Mining |skill Mining,125
|tip Click ore as you follow the path around this area.
|tip Track them on your minimap with "Find Minerals".
|tip You can smelt Bronze Bars with leftover Tin and Copper Bars from skill level 65-90 for additional points.
|tip You can smelt Silver Ore from skill level 75-112 for additional points.
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Ironforge 51.88,29.67 < 7 |walk
Enter the building |goto Ironforge 49.57,28.51 < 5 |walk
talk Geofram Bouldertoe##4254
|tip Downstairs inside the building.
Learn Expert Mining |skillmax Mining,225 |goto Ironforge 50.00,26.29
step
map Arathi Highlands
path	follow smart;	loop on;	ants curved;	dist 30
path	76.64,42.59	75.00,44.93	72.65,48.07	70.58,55.05	69.99,58.40
path	72.92,59.03	72.28,63.63	72.78,66.86	71.75,66.15	69.15,72.54
path	67.17,70.90	63.52,73.55	59.48,74.71	59.32,70.74	56.16,71.89
path	50.82,78.41	47.96,82.44	42.53,80.75	43.02,77.16	40.39,71.86
path	37.95,67.63	38.52,68.50	33.94,66.02	34.59,61.64	33.70,56.77
path	33.45,53.94	33.65,50.19	35.00,47.28	32.96,46.68	31.68,45.41
path	32.34,42.64	31.42,41.24	25.23,43.10	20.94,39.12	20.02,35.80
path	19.12,33.36	22.43,31.28	23.48,24.90	26.93,20.65	28.65,14.18
path	28.96,16.96	31.62,18.63	30.96,20.36	33.19,21.23	36.35,24.61
path	39.97,25.62	40.21,28.79	43.97,30.51	45.70,33.02	48.08,33.60
path	49.78,36.76	52.14,36.11	52.75,31.99	54.80,33.13	58.19,32.50
path	58.02,34.22	59.94,35.97	62.25,32.06	64.69,35.58	64.49,26.56
path	66.77,27.64	70.39,27.07	70.47,30.74	71.07,38.63
Reach Level 175 Mining |skill Mining,175
|tip Click ore as you follow the path around this area.
|tip Track them on your minimap with "Find Minerals".
|tip You can smelt Iron Ore from skill level 125-135 for additional points.
|tip You can smelt Gold Ore from skill level 155-184 for additional points.
step
map Badlands
path	follow smart;	loop on;	ants curved;	dist 30
path	26.84,74.76	25.28,78.53	19.71,81.32	14.75,83.82	12.50,85.54
path	7.98,80.56	6.30,74.40	8.68,67.97	17.19,68.54	15.13,72.43
path	17.19,77.39	21.25,75.06	25.11,72.08
Reach Level 200 Mining |skill Mining,200
|tip Click ore as you follow the path around this area.
|tip Track them on your minimap with "Find Minerals".
|tip You can smelt Gold Ore from skill level 155-184 for additional points.
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Ironforge 51.88,29.67 < 7 |walk
Enter the building |goto Ironforge 49.57,28.51 < 5 |walk
talk Geofram Bouldertoe##4254
|tip Downstairs inside the building.
Learn Artisan Mining |skillmax Mining,300 |goto Ironforge 50.00,26.29
step
map Badlands
path	follow smart;	loop on;	ants curved;	dist 30
path	26.84,74.76	25.28,78.53	19.71,81.32	14.75,83.82	12.50,85.54
path	7.98,80.56	6.30,74.40	8.68,67.97	17.19,68.54	15.13,72.43
path	17.19,77.39	21.25,75.06	25.11,72.08
Reach Level 230 Mining |skill Mining,230
|tip Click ore as you follow the path around this area.
|tip Track them on your minimap with "Find Minerals".
step
map Un'Goro Crater
path	follow smart;	loop on;	ants curved;	dist 30
path	66.46,78.95	64.56,79.71	61.79,84.21	59.34,84.18	57.63,86.04
path	54.50,86.69	51.13,86.82	48.27,87.30	45.98,86.58	42.89,85.00
path	40.79,83.52	37.91,83.14	36.77,80.17	33.58,79.05	30.40,79.61
path	28.89,76.98	28.97,71.52	26.00,67.67	25.93,63.53	24.59,58.51
path	23.95,53.04	24.40,48.21	23.89,44.76	24.71,41.12	26.26,36.59
path	26.62,31.21	28.29,29.47	29.59,25.66	29.89,20.92	33.32,20.67
path	36.29,20.47	38.67,16.00	41.73,15.77	43.32,14.12	46.94,13.03
path	49.79,13.83	52.84,12.88	56.31,14.04	59.61,16.58	62.25,16.02
path	64.19,19.90	65.99,21.01	68.51,20.26	71.19,20.89	71.21,23.75
path	71.75,28.19	74.76,32.46	75.06,37.15	76.32,43.15	76.67,48.32
path	77.05,53.09	76.56,57.02	75.35,61.97	74.66,68.05	72.92,70.46
path	71.39,73.80	71.00,79.21	68.32,79.90
Reach Level 300 Mining |skill Mining,300
|tip Click ore as you follow the path around this area.
|tip Track them on your minimap with "Find Minerals".
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Skinning\\Skinning (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Skinning') > 0 end,
description="This guide will walk you through leveling your Skinning skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least level 5 before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Ironforge 41.98,33.37 < 7 |only if walking
Enter the building |goto Ironforge 40.36,35.48 < 5 |walk
talk Balthus Stoneflayer##6291
|tip Downstairs inside the building.
Learn Apprentice Skinning |skillmax Skinning,75 |goto Ironforge 39.86,32.51
step
talk Bombus Finespindle##5128
|tip Downstairs inside the building.
buy Skinning Knife##7005 |goto 39.61,34.47
|tip You must have a Skinning Knife in your bags to be able to skin enemies.
step
map Dun Morogh
path follow loose;	loop;	ants curved;	dist 30
path	43.96,46.88		40.38,47.16		36.62,45.87		32.97,48.03
path	28.87,48.65		29.08,43.33		32.55,37.52		39.71,31.71
path	43.35,31.77		44.37,36.99
Kill enemies around this area
|tip Skin their corpses.
Reach Level 75 Skinning |skill Skinning,75
step
Reach Level 10 |ding 10
|tip You must be at least level 10 to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Ironforge 41.98,33.37 < 7 |only if walking
Enter the building |goto Ironforge 40.36,35.48 < 5 |walk
talk Balthus Stoneflayer##6291
|tip Downstairs inside the building.
Learn Journeyman Skinning |skillmax Skinning,150 |goto Ironforge 39.86,32.51
step
Kill enemies around this area
|tip Skin their corpses.
Reach Level 125 Skinning |skill Skinning,125 |goto Loch Modan 54.84,37.76
You can find more around: |notinsticky
[Loch Modan 63.58,38.31]
[Loch Modan 74.11,40.81]
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Ironforge 41.98,33.37 < 7 |only if walking
Enter the building |goto Ironforge 40.36,35.48 < 5 |walk
talk Balthus Stoneflayer##6291
|tip Downstairs inside the building.
Learn Expert Skinning |skillmax Skinning,225 |goto Ironforge 39.86,32.51
step
Follow the path |goto Wetlands 10.80,54.98 < 15 |only if walking
Kill enemies around this area
|tip Skin their corpses.
Reach Level 165 Skinning |skill Skinning,165 |goto Wetlands 22.16,53.53
You can find more around: |notinsticky
[Wetlands 25.11,46.89]
[Wetlands 28.92,43.39]
step
Kill enemies around this area
|tip Skin their corpses.
|tip The spiders won't be skinnable.
Reach Level 180 Skinning |skill Skinning,180 |goto Arathi Highlands 40.94,47.87
step
Kill enemies around this area
|tip Skin their corpses.
|tip The spiders won't be skinnable.
Reach Level 225 Skinning |skill Skinning,225 |goto 52.20,67.24
You can find more around [47.81,77.26]
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Ironforge 41.98,33.37 < 7 |only if walking
Enter the building |goto Ironforge 40.36,35.48 < 5 |walk
talk Balthus Stoneflayer##6291
|tip Downstairs inside the building.
Learn Artisan Skinning |skillmax Skinning,300 |goto Ironforge 39.86,32.51
step
Run up the ramp |goto Feralas 30.92,43.22 < 7 |only if walking
Ride the boat or swim across |goto Feralas 31.03,39.87 < 20 |only if walking
Follow the path up |goto Feralas 47.09,44.45 < 20 |only if walking
Follow the road |goto Feralas 48.76,45.17 < 30 |only if walking
Follow the path |goto Feralas 54.31,51.36 < 30 |only if walking
Kill Feral Scar enemies around this area
|tip They look like yetis.
|tip You can find more through the tunnel.
|tip Skin their corpses.
Reach Level 260 Skinning |skill Skinning,260 |goto Feralas 55.21,56.38
step
Follow the road |goto 54.86,51.34 < 30 |only if walking
Continue following the road |goto 50.21,49.70 < 30 |only if walking
Follow the path |goto 48.29,38.07 < 30 |only if walking
Kill enemies around this area
|tip Skin their corpses.
Reach Level 300 Skinning |skill Skinning,300 |goto 49.99,33.16
You can find more around: |notinsticky
[51.94,31.89]
[49.59,28.55]
[46.15,23.56]
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Cooking\\Cooking (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Cooking') > 0 end,
description="This guide will walk you through leveling your Cooking skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least level 5 before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 71.64,39.92 < 5 |walk
Run down the stairs |goto Stormwind City 74.90,37.61 < 5 |walk
talk Stephen Ryback##5482
|tip Downstairs inside the building.
Learn Apprentice Cooking |skillmax Cooking,75 |goto Stormwind City 75.60,37.04
step
collect 55 Chunk of Boar Meat##769
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Cooking") < 50
step
Enter the building |goto 71.64,39.92 < 5 |walk
Run down the stairs |goto 74.90,37.61 < 5 |walk
Open Your Cooking Crafting Panel:
|tip Stand next to the Warm Fire.
|tip Downstairs inside the building.
_<Create 55 Roasted Boar Meat>_
Reach Level 50 Cooking |skill Cooking,50 |goto 75.97,36.50
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 71.64,39.92 < 5 |walk
Run down the stairs |goto Stormwind City 74.90,37.61 < 5 |walk
talk Stephen Ryback##5482
|tip Downstairs inside the building.
Learn Journeyman Cooking |skillmax Cooking,150 |goto Stormwind City 75.60,37.04
step
Enter the building |goto Loch Modan 35.23,47.74 < 5 |walk
talk Drac Roughcut##1465
|tip Inside the building.
buy Recipe: Smoked Bear Meat##6892 |n
use the Recipe: Smoked Bear Meat##6892
learn Smoked Bear Meat##8607 |goto Loch Modan 35.57,49.15
step
collect 30 Bear Meat##3173
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Cooking") < 80
step
Enter the building |goto Stormwind City 71.64,39.92 < 5 |walk
Run down the stairs |goto Stormwind City 74.90,37.61 < 5 |walk
Open Your Cooking Crafting Panel:
|tip Stand next to the Warm Fire.
|tip Downstairs inside the building.
_<Create 30 Smoked Bear Meat>_
Reach Level 80 Cooking |skill Cooking,80 |goto Stormwind City 75.97,36.50
step
talk Stephen Ryback##5482
|tip Downstairs inside the building.
learn Boiled Clams##6499 |goto 75.60,37.04
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 40 Clam Meat##5503
|only if skill("Cooking") < 110
step
Enter the building |goto Stormwind City 71.64,39.92 < 5 |walk
Run down the stairs |goto Stormwind City 74.90,37.61 < 5 |walk
talk Erika Tate##5483
|tip Downstairs inside the building.
buy 40 Refreshing Spring Water##159 |goto 76.06,36.76
|only if skill("Cooking") < 110
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Warm Fire.
|tip Downstairs inside the building.
_<Create 40 Boiled Clams>_
Reach Level 110 Cooking |skill Cooking,110 |goto 75.97,36.50
step
talk Stephen Ryback##5482
|tip Downstairs inside the building.
learn Crab Cake##2544 |goto 75.60,37.04
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 30 Crawler Meat##2674
|only if skill("Cooking") < 130
step
Enter the building |goto Stormwind City 71.64,39.92 < 5 |walk
Run down the stairs |goto Stormwind City 74.90,37.61 < 5 |walk
talk Erika Tate##5483
|tip Downstairs inside the building.
buy 30 Mild Spice##2678 |goto 76.06,36.76
|only if skill("Cooking") < 130
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Warm Fire.
|tip Downstairs inside the building.
_<Create 30 Crab Cakes>_
Reach Level 130 Cooking |skill Cooking,130 |goto 75.97,36.50
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
Follow the path down |goto Ashenvale 51.22,58.21 < 20 |only if walking
Enter the building |goto 50.12,66.48 < 10 |walk
talk Shandrina##3955
|tip Inside the building.
buy Expert Cookbook##16072 |n
use the Expert Cookbook##16072
Learn Expert Cooking |skillmax Cooking,225 |goto Ashenvale 49.48,67.09
step
Enter the building |goto Stormwind City 71.71,39.83 < 5 |walk
talk Kendor Kabonka##340
|tip Upstairs inside the building.
buy Recipe: Curiously Tasty Omelet##3682 |n
use the Recipe: Curiously Tasty Omelet##3682
learn Curiously Tasty Omelet##3376 |goto Stormwind City 74.69,36.51
step
collect 50 Raptor Egg##3685
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Cooking") < 175
step
Enter the building |goto 71.71,39.83 < 5 |walk
Run down the stairs |goto 74.90,37.61 < 5 |walk
talk Erika Tate##5483
|tip Downstairs inside the building.
buy 50 Hot Spices##2692 |goto 76.06,36.76
|only if skill("Cooking") < 175
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Warm Fire.
|tip Downstairs inside the building.
_<Create 50 Curiously Tasty Omelets>_
Reach Level 175 Cooking |skill Cooking,175 |goto 75.97,36.50
step
talk Hammon Karwn##2810
buy Recipe: Roast Raptor##12228 |n
use the Recipe: Roast Raptor##12228
learn Roast Raptor##15855 |goto Arathi Highlands 46.49,47.41
step
collect 60 Raptor Flesh##12184
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Cooking") < 225
step
Run up the stairs |goto Ironforge 57.55,37.38 < 5 |only if walking
Enter the building |goto Ironforge 59.42,37.75 < 5 |walk
talk Emrul Riknussun##5160
|tip Downstairs inside the building.
buy 60 Hot Spices##2692 |goto Ironforge 59.88,37.37
|only if skill("Cooking") < 225
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Potbelly Stove.
|tip Inside the building.
_<Create 60 Roast Raptors>_
Reach Level 225 Cooking |skill Cooking,225 |goto 75.95,36.52
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Tanaris 52.38,27.91 < 5 |walk
talk Dirge Quikcleave##8125
|tip Inside the building.
accept Clamlette Surprise##6610 |goto Tanaris 52.63,28.11
step
kill Steeljaw Snapper##14123+
|tip They look like turtles.
collect Big-mouth Clam##7973+ |n
use the Big-mouth Clam##7973+
collect 10 Zesty Clam Meat##7974 |q 6610/2 |goto 67.75,22.96
|tip You can also purchase them from the Auction House.
You can find more around:
[67.09,18.71]
[67.51,26.30]
[67.68,29.49]
step
map The Hinterlands
path	follow smart;	loop on;	ants curved;	dist 30
path	44.80,59.32	47.13,56.54	50.76,57.53	55.91,52.30	59.36,53.56
path	62.11,54.23	61.51,46.51	57.53,46.76	51.91,41.76	47.07,45.83
path	41.96,47.60	44.40,54.54
Kill Owlbeast enemies
|tip Follow the path and kill them as you find them.
collect 12 Giant Egg##12207 |q 6610/1
|tip You can also purchase them from the Auction House.
step
Enter the building |goto Stormwind City 59.96,64.18 < 5 |walk
talk Ben Trias##4981
|tip Inside the building.
buy 20 Alterac Swiss##8932 |q 6610/3 |goto Stormwind City 60.33,63.42
|tip It may be cheaper on the Auction House.
step
Enter the building |goto Tanaris 52.38,27.91 < 5 |walk
talk Dirge Quikcleave##8125
|tip Inside the building.
turnin Clamlette Surprise##6610 |goto Tanaris 52.63,28.11
Learn Artisan Cook |skillmax Cooking,300 |goto Tanaris 52.63,28.11
|tip You will learn this automatically.
step
Enter the building |goto Winterspring 61.32,38.72 < 5 |walk
talk Himmik##11187
|tip Inside the building.
buy Recipe: Monster Omelet##16110 |n
use the Recipe: Monster Omelet##16110
learn Monster Omelet##15933 |goto Winterspring 61.33,39.16
step
Leave the building |goto 61.32,38.72 < 5 |walk
Enter the building |goto 61.33,37.36 < 5 |walk
talk Qia##11189
|tip Inside the building.
buy 120 Soothing Spices##3713 |goto 61.20,37.21
|only if skill("Cooking") < 275
step
map The Hinterlands
path	follow smart;	loop on;	ants curved;	dist 30
path	44.80,59.32	47.13,56.54	50.76,57.53	55.91,52.30	59.36,53.56
path	62.11,54.23	61.51,46.51	57.53,46.76	51.91,41.76	47.07,45.83
path	41.96,47.60	44.40,54.54
Kill Owlbeast enemies along this path
collect 60 Giant Egg##12207
|tip You can also purchase them from the Auction House.
|only if skill("Cooking") < 275
step
Enter the building |goto Stormwind City 71.71,39.83 < 5 |walk
Run down the stairs |goto Stormwind City 74.90,37.61 < 5 |walk
Open Your Cooking Crafting Panel:
|tip Stand next to the Warm Fire.
|tip Downstairs inside the building.
_<Create 60 Monster Omelets>_
Reach Level 275 Cooking |skill Cooking,275 |goto Stormwind City 75.97,36.50
step
Follow the path |goto Tanaris 61.03,26.14 < 50 |only if walking
Enter the building |goto Tanaris 66.66,22.20 < 5 |walk
talk Gikkix##8137
|tip Inside the building.
buy Recipe: Poached Sunscale Salmon##13946 |n
use the Recipe: Poached Sunscale Salmon##13946
learn Poached Sunscale Salmon##18244 |goto Tanaris 66.64,22.08
step
collect 35 Raw Sunscale Salmon##13760
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Cooking") < 300
step
Enter the building |goto Stormwind City 71.71,39.83 < 5 |walk
Run down the stairs |goto Stormwind City 74.90,37.61 < 5 |walk
Open Your Cooking Crafting Panel:
|tip Stand next to the Warm Fire.
|tip Downstairs inside the building.
_<Create 35 Poached Sunscale Salmon>_
Reach Level 300 Cooking |skill Cooking,300 |goto Stormwind City 75.97,36.50
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Cooking\\Cooking + Fishing (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return (skill('Cooking') > 0) or (skill('Fishing') > 0) end,
description="This guide will walk you through leveling both your Cooking and Fishing skills from 1-300, together.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least level 5 before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
talk Tharynn Bouden##66
buy Fishing Pole##6256 |goto Elwynn Forest 41.82,67.16
|tip You need to be able to equip a fishing pole in order to fish.
|only if skill("Fishing") < 300
step
talk Tharynn Bouden##66
buy 10 Shiny Bauble##6529 |goto 41.82,67.16
|only if skill("Fishing") < 75
step
talk Lee Brown##1651
Learn Apprentice Fishing |skillmax Fishing,75 |goto 47.61,62.32
step
Fish in the Water
|tip Use the "Fishing" skill in your spell book.
|tip Equip the Fishing Pole in your bags.
|tip Save the fish you catch, to cook later.
use the Shiny Bauble##6529+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 75 Fishing |skill Fishing,75 |goto 47.68,62.52
step
talk Lee Brown##1651
Learn Journeyman Fishing |skillmax Fishing,150 |goto 47.61,62.32
step
Enter the building |goto 42.94,65.65 < 7 |walk
talk Tomas##1430
|tip Inside the building.
Learn Apprentice Cooking |skillmax Cooking,75 |goto Elwynn Forest 44.37,65.99
step
Leave the building |goto 42.99,65.65 < 7 |walk
talk Tharynn Bouden##66
buy Recipe: Brilliant Smallfish##6325 |n
use the Recipe: Brilliant Smallfish##6325
learn Brilliant Smallfish##7751 |goto 41.82,67.16
step
talk Tharynn Bouden##66
buy Recipe: Longjaw Mud Snapper##6328 |goto 41.82,67.16
|tip Save this for later.
step
talk Catherine Leland##5494
buy Recipe: Bristle Whisker Catfish##6330 |goto Stormwind City 45.77,58.58
|tip Save this for later.
|only if skill("Cooking") < 175
step
Fish in the Water
use the Shiny Bauble##6529+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 130 Fishing |skill Fishing,130 |goto 45.97,58.54
collect 55 Raw Brilliant Smallfish##6291 |goto 45.97,58.54 |only if skill("Cooking") < 50
collect 60 Raw Longjaw Mud Snapper##6289 |goto 45.97,58.54 |only if skill("Cooking") < 100
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto 71.65,39.88 < 5 |walk
Run down the stairs |goto 74.87,37.66 < 5 |walk
Open Your Cooking Crafting Panel:
|tip Stand next to the Warm Fire.
|tip Downstairs inside the building.
_<Create 55 Brilliant Smallfish>_
Reach Level 50 Cooking |skill Cooking,50 |goto 75.96,36.54
step
use the Recipe: Longjaw Mud Snapper##6328
|tip You should have this from earlier in the guide.
learn Longjaw Mud Snapper##7753
step
talk Stephen Ryback##5482
|tip Downstairs inside the building.
Learn Journeyman Cooking |skillmax Cooking,150 |goto 75.60,37.04
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Warm Fire.
|tip Downstairs inside the building.
_<Create 60 Longjaw Mud Snappers>_
Reach Level 100 Cooking |skill Cooking,100 |goto 75.96,36.54
step
use the Recipe: Bristle Whisker Catfish##6330
learn Bristle Whisker Catfish##7755
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run down the ramp |goto Stranglethorn Vale 28.04,76.53 < 7 |only if walking
Enter the building |goto Stranglethorn Vale 27.47,77.09 < 5 |walk
talk Old Man Heming##2626
|tip Inside the building.
buy Expert Fishing - The Bass and You##16083 |n
use Expert Fishing - The Bass and You##16083
Learn Expert Fishing |skillmax Fishing,225 |goto Stranglethorn Vale 27.42,77.16
step
talk Old Man Heming##2626
|tip Inside the building.
buy 20 Bright Baubles##6532 |goto 27.42,77.16
|only if skill("Fishing") < 225
step
Enter the building |goto 28.11,74.99 < 10 |walk
talk Kelsey Yance##2664
|tip Inside the building.
buy Recipe: Mithril Head Trout##17062 |goto 28.23,74.34
buy Recipe: Filet of Redgill##13941 |goto 28.23,74.34
|tip Save these for later.
step
Enter the building |goto Ashenvale 35.64,51.01 < 10 |only if walking
talk Haljan Oakheart##3962
|tip Inside the building.
buy Flint and Tinder##4471 |goto Ashenvale 34.85,50.87 |only if itemcount(4471) < 1
|tip You need to have Flint and Tinder in your bags to be able to create Basic Campfires to cook with.
buy 10 Simple Wood##4470 |goto Ashenvale 34.85,50.87 |only if itemcount(4470) < 15 and skill("Cooking") < 300
|tip You will use one of these each time you create a Basic Campfire to cook with.
step
Follow the path down |goto 51.22,58.21 < 20 |only if walking
Enter the building |goto 50.12,66.48 < 10 |walk
talk Shandrina##3955
|tip Inside the building.
buy Expert Cookbook##16072 |goto 49.48,67.09
|only if skillmax("Cooking") < 225
|tip Save this for later.
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 205 Fishing |skill Fishing,205 |goto 48.90,68.23
collect 150 Raw Bristle Whisker Catfish##6308 |goto 48.90,68.23 |only if skill("Cooking") < 175
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 25 Bristle Whisker Catfish>_
Reach Level 125 Cooking |skill Cooking,125 |goto 48.80,67.66
step
use the Expert Cookbook##16072
Learn Expert Cooking |skillmax Cooking,225
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 125 Bristle Whisker Catfish>_
Reach Level 175 Cooking |skill Cooking,175 |goto 48.80,67.66
step
use the Recipe: Mithril Head Trout##17062
learn Mithril Head Trout##20916
step
Enter the building |goto Dustwallow Marsh 65.99,45.20 < 7 |walk
talk Craig Nollward##4894
|tip Inside the building.
buy 20 Alterac Swiss##8932 |goto Dustwallow Marsh 66.90,45.26 |q 6610 |future
|tip It may be cheaper on the Auction House.
|tip Save these for later.
step
Leave the building |goto 65.99,45.20 < 7 |walk
Cross the bridge and follow the road |goto 64.30,45.63 < 20 |only if walking
Fish in the Water
|tip Save any Raw Mithril Head Trout you catch.
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 225 Fishing |skill Fishing,225 |goto 59.12,36.84
step
Reach Level 35 |ding 35
|tip You must be at least this level before you can accept the quest in the next step.
|tip Use the Leveling guides to accomplish this.
step
Cross the water |goto Dustwallow Marsh 66.54,55.09 < 30 |only if walking
talk Nat Pagle##12919
|tip On a small island in the water.
accept Nat Pagle, Angler Extreme##6607 |goto 58.55,60.21
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
collect Feralas Ahi##16967 |q 6607/1 |goto Feralas 62.38,52.50
|tip You will eventually catch one.
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
collect Sar'theris Striker##16968 |q 6607/3 |goto Desolace 38.96,22.70
|tip You will eventually catch one.
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
collect Misty Reed Mahi Mahi##16970 |q 6607/2 |goto Swamp of Sorrows 90.45,73.47
|tip You will eventually catch one.
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
collect Savage Coast Blue Sailfin##16969 |q 6607/4 |goto Stranglethorn Vale 24.58,65.80
|tip You will eventually catch one.
step
Cross the water |goto Dustwallow Marsh 66.54,55.09 < 30 |only if walking
talk Nat Pagle##12919
|tip On a small island in the water.
turnin Nat Pagle, Angler Extreme##6607 |goto Dustwallow Marsh 58.55,60.21
Learn Artisan Fishing |skillmax Fishing,300 |goto Dustwallow Marsh 58.55,60.21
|tip You will learn this automatically.
step
Cross the water |goto 66.54,55.09 < 15 |only if walking
Cross the bridge and follow the road |goto 64.30,45.63 < 20 |only if walking
Fish in the Water
|tip Save any Raw Mithril Head Trout you catch.
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 255 Fishing |skill Fishing,255 |goto 59.12,36.84
collect 60 Raw Mithril Head Trout##8365 |goto 59.12,36.84 |only if skill("Cooking") < 225
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 60 Mithril Head Trout>_
Reach Level 225 Cooking |skill Cooking,225 |goto 59.08,37.04
step
use the Recipe: Filet of Redgill##13941
learn Filet of Redgill##18241
step
Enter the building |goto Tanaris 52.38,27.91 < 5 |walk
talk Dirge Quikcleave##8125
|tip Inside the building.
accept Clamlette Surprise##6610 |goto Tanaris 52.63,28.11
step
kill Steeljaw Snapper##14123+
|tip They look like turtles.
collect Big-mouth Clam##7973+ |n
use the Big-mouth Clam##7973+
collect 10 Zesty Clam Meat##7974 |q 6610/2 |goto 67.75,22.96
|tip You can also purchase them from the Auction House.
You can find more around:
[67.09,18.71]
[67.51,26.30]
[67.68,29.49]
step
map The Hinterlands
path	follow smart;	loop on;	ants curved;	dist 30
path	44.80,59.32	47.13,56.54	50.76,57.53	55.91,52.30	59.36,53.56
path	62.11,54.23	61.51,46.51	57.53,46.76	51.91,41.76	47.07,45.83
path	41.96,47.60	44.40,54.54
Kill Owlbeast enemies
|tip Follow the path and kill them as you find them.
collect 12 Giant Egg##12207 |q 6610/1
|tip You can also purchase them from the Auction House.
step
Enter the building |goto Stormwind City 59.96,64.18 < 5 |walk
talk Ben Trias##4981
|tip Inside the building.
buy 20 Alterac Swiss##8932 |q 6610/3 |goto Stormwind City 60.33,63.42
|tip It may be cheaper on the Auction House.
step
Enter the building |goto Tanaris 52.38,27.91 < 5 |walk
talk Dirge Quikcleave##8125
|tip Inside the building.
turnin Clamlette Surprise##6610 |goto Tanaris 52.63,28.11
Learn Artisan Cook |skillmax Cooking,300 |goto Tanaris 52.63,28.11
|tip You will learn this automatically.
step
Follow the path |goto 61.03,26.14 < 50 |only if walking
Enter the building |goto 66.66,22.20 < 5 |walk
talk Gikkix##8137
|tip Inside the building.
buy Recipe: Spotted Yellowtail##13939 |n
use the Recipe: Spotted Yellowtail##13939
learn Spotted Yellowtail##18238 |goto 66.64,22.08
step
talk Gikkix##8137
|tip Inside the building.
buy Recipe: Poached Sunscale Salmon##13946 |goto 66.64,22.08
|tip Save this for later.
step
talk Vivianna##7947
|tip Inside the building.
buy 20 Bright Baubles##6532 |goto Feralas 31.30,43.46 |only if skill("Cooking") < 300
step
Fish in the Water
|tip Save any Raw Redgill you catch.
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 300 Fishing |skill Fishing,300 |goto 62.39,52.49
collect 20 Raw Mithril Head Trout##8365 |goto 62.39,52.49 |only if skill("Cooking") < 250
collect 50 Raw Redgill##13758 |goto 62.39,52.49 |only if skill("Cooking") < 280
collect 35 Raw Sunscale Salmon##13760 |goto 62.39,52.49 |only if skill("Cooking") < 300
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 20 Mithril Headed Trout>_
Reach Level 235 Cooking |skill Cooking,235 |goto 62.34,52.70
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 50 Filets of Redgill>_
Reach Level 275 Cooking |skill Cooking,275 |goto 62.34,52.70
step
use the Recipe: Poached Sunscale Salmon##13946
learn Poached Sunscale Salmon##18244
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 35 Poached Sunscale Salmon>_
Reach Level 300 Cooking |skill Cooking,300 |goto 62.34,52.70
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Fishing\\Fishing (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Fishing') > 0 end,
description="This guide will walk you through leveling your Fishing skill from 1-300.",
},[[
step
Reach Level 5 |ding 5
|tip You must be at least this level before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
talk Arnold Leland##5493
Learn Apprentice Fishing |skillmax Fishing,75 |goto Stormwind City 45.64,58.43
step
talk Catherine Leland##5494
buy Fishing Pole##6256 |goto 45.77,58.58
|tip You need to be able to equip a fishing pole in order to fish.
|only if skill("Fishing") < 300
step
talk Catherine Leland##5494
buy 10 Shiny Bauble##6529 |goto 45.77,58.58
|tip These will allow you to catch fish easier.
|only if skill("Fishing") < 55
step
Fish in the Water
|tip Use the "Fishing" skill in your spell book.
|tip Equip the Fishing Pole in your bags.
use the Shiny Bauble##6529+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 55 Fishing |skill Fishing,55 |goto Elwynn Forest 33.70,62.97
step
talk Catherine Leland##5494
buy Strong Fishing Pole##6365 |goto Stormwind City 45.77,58.58
|tip This is a limited supply item.
|tip If she doesn't have it for sale, check the Auction House.
|tip If you can't get one, you can skip this step.
step
Fish in the Water
|tip Equip the "Strong Fishing Pole", if you were able to get one.
use the Shiny Bauble##6529+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 75 Fishing |skill Fishing,75 |goto 45.96,58.53
step
talk Arnold Leland##5493
Learn Journeyman Fishing |skillmax Fishing,150 |goto 45.64,58.43
step
talk Catherine Leland##5494
buy 10 Nightcrawlers##6530 |goto 45.77,58.58
|tip These will allow you to catch fish easier.
|only if skill("Fishing") < 150
step
Fish in the Water
use the Nightcrawlers##6530+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 150 Fishing |skill Fishing,150 |goto Redridge Mountains 29.69,56.28
step
Run down the ramp |goto Stranglethorn Vale 28.04,76.53 < 7 |only if walking
Enter the building |goto Stranglethorn Vale 27.47,77.09 < 5 |walk
talk Old Man Heming##2626
|tip Inside the building.
buy Expert Fishing - The Bass and You##16083 |n
use Expert Fishing - The Bass and You##16083
Learn Expert Fishing |skillmax Fishing,225 |goto Stranglethorn Vale 27.42,77.16
step
talk Old Man Heming##2626
|tip Inside the building.
buy 20 Bright Baubles##6532 |goto 27.42,77.16
|only if skill("Fishing") < 225
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 225 Fishing |skill Fishing,225 |goto 27.64,76.67
step
Reach Level 35 |ding 35
|tip You must be at least this level before you can accept the quest in the next step.
|tip Use the Leveling guides to accomplish this.
step
Cross the water |goto Dustwallow Marsh 66.54,55.09 < 30 |only if walking
talk Nat Pagle##12919
|tip On a small island in the water.
accept Nat Pagle, Angler Extreme##6607 |goto Dustwallow Marsh 58.55,60.21
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
collect Feralas Ahi##16967 |q 6607/1 |goto Feralas 62.38,52.50
|tip You will eventually catch one.
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
collect Sar'theris Striker##16968 |q 6607/3 |goto Desolace 38.96,22.70
|tip You will eventually catch one.
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
collect Misty Reed Mahi Mahi##16970 |q 6607/2 |goto Swamp of Sorrows 90.45,73.47
|tip You will eventually catch one.
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
collect Savage Coast Blue Sailfin##16969 |q 6607/4 |goto Stranglethorn Vale 24.58,65.80
|tip You will eventually catch one.
step
Cross the water |goto Dustwallow Marsh 66.54,55.09 < 30 |only if walking
talk Nat Pagle##12919
|tip On a small island in the water.
turnin Nat Pagle, Angler Extreme##6607 |goto Dustwallow Marsh 58.55,60.21
Learn Artisan Fishing |skillmax Fishing,300 |goto Dustwallow Marsh 58.55,60.21
|tip You will learn this automatically.
step
talk Catherine Leland##5494
buy 20 Bright Baubles##6532 |goto Stormwind City 45.77,58.58
|only if skill("Fishing") < 300
step
Follow the path |goto The Hinterlands 18.57,53.61 < 50 |only if walking
Continue following the path |goto The Hinterlands 28.61,53.02 < 30 |only if walking
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 300 Fishing |skill Fishing,300 |goto The Hinterlands 29.50,47.82
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\First Aid\\First Aid (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('First Aid') > 0 end,
description="This guide will walk you through leveling your First Aid skill from 1-300.",
},[[
step
Enter the building |goto Ironforge 55.18,57.31 < 5 |walk
talk Nissa Firestone##5150
|tip Upstairs inside the building.
Learn Apprentice First Aid |skillmax First Aid,75 |goto Ironforge 55.09,58.26
step
collect 50 Linen Cloth##2589
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("First Aid") < 40
step
Open Your First Aid Crafting Panel:
_<Create 50 Linen Bandages>_
Reach Level 40 First Aid |skill First Aid,40
step
Enter the building |goto Ironforge 55.18,57.31 < 5 |walk
talk Nissa Firestone##5150
|tip Upstairs inside the building.
learn Heavy Linen Bandage##3276 |goto Ironforge 55.09,58.26
step
collect 80 Linen Cloth##2589
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("First Aid") < 70
step
Open Your First Aid Crafting Panel:
_<Create 40 Heavy Linen Bandages>_
Reach Level 70 First Aid |skill First Aid,70
step
Enter the building |goto Ironforge 55.18,57.31 < 5 |walk
talk Nissa Firestone##5150
|tip Upstairs inside the building.
Learn Journeyman First Aid |skillmax First Aid,150 |goto Ironforge 55.09,58.26
step
collect 50 Linen Cloth##2589
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("First Aid") < 80
step
Open Your First Aid Crafting Panel:
_<Create 25 Heavy Linen Bandages>_
Reach Level 80 First Aid |skill First Aid,80
step
Enter the building |goto Ironforge 55.18,57.31 < 5 |walk
talk Nissa Firestone##5150
|tip Upstairs inside the building.
learn Wool Bandage##3277 |goto Ironforge 55.09,58.26
step
collect 60 Wool Cloth##2592
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("First Aid") < 115
step
Open Your First Aid Crafting Panel:
_<Create 60 Wool Bandages>_
Reach Level 115 First Aid |skill First Aid,115
step
Enter the building |goto Ironforge 55.18,57.31 < 5 |walk
talk Nissa Firestone##5150
|tip Upstairs inside the building.
learn Heavy Wool Bandage##3278 |goto Ironforge 55.09,58.26
step
collect 110 Wool Cloth##2592
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("First Aid") < 150
step
Open Your First Aid Crafting Panel:
_<Create 55 Heavy Wool Bandages>_
Reach Level 150 First Aid |skill First Aid,150
step
Enter the building |goto Ironforge 55.18,57.31 < 5 |walk
talk Nissa Firestone##5150
|tip Upstairs inside the building.
learn Silk Bandage##7928 |goto Ironforge 55.09,58.26
step
Follow the path |goto Arathi Highlands 26.07,55.71 < 15 |only if walking
Continue following the path |goto Arathi Highlands 25.54,60.06 < 15 |only if walking
Continue following the path |goto Arathi Highlands 23.02,59.86 < 20 |c
|only if skillmax("First Aid") < 225
step
Cross the bridge |goto 25.62,58.14 < 10 |only if walking
talk Deneb Walker##2805
buy Expert First Aid - Under Wraps##16084 |n
use the Expert First Aid - Under Wraps##16084
Learn Expert First Aid |skillmax First Aid,225 |goto 26.97,58.83
step
talk Deneb Walker##2805
buy Manual: Heavy Silk Bandage##16112 |goto 26.97,58.83
buy Manual: Mageweave Bandage##16113 |goto 26.97,58.83
|tip Save these for later.
step
collect 50 Silk Cloth##4306
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("First Aid") < 180
step
Open Your First Aid Crafting Panel:
_<Create 50 Silk Bandages>_
Reach Level 180 First Aid |skill First Aid,180
step
use Manual: Heavy Silk Bandage##16112
learn Heavy Silk Bandage##7929
step
collect 90 Silk Cloth##4306
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("First Aid") < 210
step
Open Your First Aid Crafting Panel:
_<Create 45 Heavy Silk Bandages>_
Reach Level 210 First Aid |skill First Aid,210
step
use Manual: Mageweave Bandage##16113
learn Mageweave Bandage##10840
step
collect 30 Mageweave Cloth##4338
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("First Aid") < 225
step
Open Your First Aid Crafting Panel:
_<Create 30 Mageweave Bandages>_
Reach Level 225 First Aid |skill First Aid,225
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 96 Mageweave Cloth##4338 |only if skill("First Aid") < 260
collect 85 Runecloth##14047 |only if skill("First Aid") < 300
|only if skill("First Aid") < 300
step
Enter the building |goto Dustwallow Marsh 67.80,47.66 < 7 |walk
talk Doctor Gustaf VanHowzen##12939
|tip Inside the building.
accept Triage##6624 |goto Dustwallow Marsh 67.76,48.97
step
use the Triage Bandage##16991
|tip Use it on the injured NPC's on the beds nearby inside the building.
|tip You must use the Triage Bandage to heal them before they die.
|tip If too many die you will fail the quest.
|tip Press "Ctrl+V" to show their health bars to make it easier.
|tip Try to heal them by priority, in this order:
|tip Critically Injured
|tip Badly Injured
|tip Injured Patients
Save #15# Patients |q 6624/1 |goto 67.76,48.97
|tip If you fail, just abandon the quest and try again.
step
talk Doctor Gustaf VanHowzen##12939
|tip Inside the building.
turnin Triage##6624 |goto 67.76,48.97
Learn Artisan First Aid |skillmax First Aid,300 |goto 67.76,48.97
|tip You will learn this automatically.
step
Open Your First Aid Crafting Panel:
_<Create 30 Mageweave Bandages>_
Reach Level 240 First Aid |skill First Aid,240
step
talk Doctor Gustaf VanHowzen##12939
|tip Inside the building.
Tell him _"Teach me how to create and apply a Heavy Mageweave Bandage, Doctor."_
learn Heavy Mageweave Bandage##10841 |goto 67.76,48.97
step
Open Your First Aid Crafting Panel:
_<Create 33 Heavy Mageweave Bandages>_
Reach Level 260 First Aid |skill First Aid,260
step
talk Doctor Gustaf VanHowzen##12939
|tip Inside the building.
Tell him _"Teach me how to create and apply a Runecloth Bandage, Doctor."_
learn Runecloth Bandage##18629 |goto 67.76,48.97
step
Open Your First Aid Crafting Panel:
_<Create 45 Runecloth Bandages>_
Reach Level 290 First Aid |skill First Aid,290
step
talk Doctor Gustaf VanHowzen##12939
|tip Inside the building.
Tell him _"Teach me how to create and apply a Heavy Runecloth Bandage, Doctor."_
learn Heavy Runecloth Bandage##18630 |goto 67.76,48.97
step
Open Your First Aid Crafting Panel:
_<Create 20 Heavy Runecloth Bandages>_
Reach Level 300 First Aid |skill First Aid,300
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Lockpicking\\Lockpicking (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Lockpicking') > 0 end,
description="This guide will walk you through leveling your Lockpicking skill from 1-300.",
},[[
step
Reach Level 20 |ding 20
|tip You must be at least level 16 before you can learn Lockpicking.
|tip You are able to gain 5 levels of Lockpicking for each level your character gains.
|tip You need to be at least level 20 to reach level 100 Lockpicking in a few steps.
|tip Use the Leveling guides to accomplish this.
step
talk Osborne the Night Man##918
learn Pick Lock##1804 |goto Stormwind City 74.64,52.82
step
Enter the building |goto 74.75,53.72 < 7 |only if walking
Enter the building |goto 77.12,58.02 < 7 |walk
talk Renzik "The Shiv"##6946
|tip Upstairs inside the building.
accept Redridge Rendezvous##2281 |goto 75.76,60.36
step
talk Lucius##6966
turnin Redridge Rendezvous##2281 |goto Redridge Mountains 28.06,52.04
|tip Save the Thieves' Tools you get as a reward.
|tip You must keep Thieves' Tools in your bags to be able to pick locks.
accept Alther's Mill##2282 |goto Redridge Mountains 28.06,52.04
step
Follow the road |goto 33.21,47.22 < 30 |only if walking
Follow the path |goto 43.36,37.56 < 30 |only if walking
click Practice Lockbox##178244+
|tip Inside the building.
Reach Level 100 Lockpicking |skill Lockpicking,100 |goto 51.99,45.19
step
click Lucius's Lockbox##121264
|tip Inside the building.
collect Token of Thievery##7871 |q 2282/1 |goto 52.04,44.69
step
Follow the road |goto 42.87,37.52 < 30 |only if walking
talk Lucius##6966
turnin Alther's Mill##2282 |goto 28.06,52.04
step
Reach Level 30 |ding 30
|tip You are able to gain 5 levels of Lockpicking for each level your character gains.
|tip You need to be at least level 30 to reach level 150 Lockpicking in a few steps.
|tip Use the Leveling guides to accomplish this.
step
map Ashenvale
path	follow smart;	loop on;	ants curved;	dist 30
path	11.90,30.15	12.87,31.05	13.79,30.52	15.42,28.31	15.15,25.13
path	15.82,19.58	15.51,16.55	13.56,14.91	11.15,13.42	12.00,15.83
path	13.22,16.26	14.17,16.22	15.09,17.10	14.04,19.81	14.75,21.67
path	14.41,23.32	13.04,24.29	12.29,25.73	11.68,25.84	11.48,26.97
path	11.75,28.81
click Waterlogged Footlocker##179487+
|tip They look like small yellow and brown wooden chests on the ground around this area.
Reach Level 150 Lockpicking |skill Lockpicking,150
step
Reach Level 40 |ding 40
|tip You are able to gain 5 levels of Lockpicking for each level your character gains.
|tip You need to be at least level 40 to reach level 200 Lockpicking in a few steps.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Badlands 43.03,30.08 < 20 |walk
Run up the stairs |goto Badlands 39.62,27.22 < 5 |c
|only if skill("Lockpicking") < 200
step
click Battered Footlocker##179490+
|tip They look like small wooden chests upstairs inside the building.
Reach Level 175 Lockpicking |skill Lockpicking,175 |goto 40.49,28.01
You can find more at: |notinsticky
[41.29,29.31]
[41.44,29.95]
[41.37,26.17]
step
Jump down and follow the path |goto 42.29,27.96 < 5 |walk
Run down the stairs |goto 42.17,26.73 < 5 |c |walk
|only if skill("Lockpicking") < 200
step
click Dented Footlocker##179492+
|tip They look like small wooden chests downstairs inside the building.
Reach Level 200 Lockpicking |skill Lockpicking,200 |goto 41.08,27.42
You can find more at: |notinsticky
[40.73,28.07]
[40.81,28.68]
[42.30,28.40]
step
Reach Level 50 |ding 50
|tip You are able to gain 5 levels of Lockpicking for each level your character gains.
|tip You need to be at least level 50 to reach level 250 Lockpicking in a few steps.
|tip Use the Leveling guides to accomplish this.
step
Follow the path down |goto Searing Gorge 63.41,38.52 < 10 |only if walking
Run up the ramp |goto Searing Gorge 46.75,53.52 < 15 |only if walking
Enter the cave |goto Searing Gorge 41.38,53.89 < 7 |c
|only if skill("Lockpicking") < 250
step
click Dented Footlocker##179492+
|tip They look like small wooden chests on the ground around this area inside the cave, in the lower section.
|tip You can also try to pickpocket enemies around this area to get Sturdy Junkboxes to unlock.
Reach Level 225 Lockpicking |skill Lockpicking,225 |goto Searing Gorge 38.44,50.83
You can find more at: |notinsticky
[Searing Gorge 38.00,45.87]
Through the Quarry Gate at [Searing Gorge 37.82,44.31]
[Searing Gorge 40.40,38.18]
[Searing Gorge 40.73,31.16]
[Searing Gorge 42.28,29.47]
[Searing Gorge 39.07,24.44]
step
Run up the ramp |goto 44.22,24.36 < 7 |walk
Follow the path |goto 42.47,30.78 < 7 |c
|only if skill("Lockpicking") < 250
step
click Dented Footlocker##179492+
|tip They look like small wooden chests on the ground around this area inside the cave, in the upper section.
|tip You can also try to pickpocket enemies around this area to get Sturdy Junkboxes to unlock.
Reach Level 250 Lockpicking |skill Lockpicking,250 |goto 42.90,31.18
You can find more around: |notinsticky
[43.93,30.88]
[45.77,28.35]
[46.88,25.68]
step
Reach Level 60 |ding 60
|tip You are able to gain 5 levels of Lockpicking for each level your character gains.
|tip You need to be at least level 60 to reach level 300 Lockpicking in a few steps.
|tip Use the Leveling guides to accomplish this.
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98
|tip The waypoint arrow will stop working after you enter the doors.
|tip Once you enter through the huge doors, take the first left you come to.
|tip Walk up onto the large chain and follow it to the island in the middle of the lava.
|tip Run down the stairs and follow the path to another large chain.
|tip Walk across the large chain and follow the path into the Grinding Quarry.
|tip Once in the Grinding Quarry, follow the path northwest through the tunnel to find the dungeon portal entrance.
Click Here After Entering the Blackrock Depths Dungeon |confirm
|only if skill("Lockpicking") < 300
step
_Inside the Blackrock Depths Dungeon:_
|tip Pick the following locks inside the dungon.
|tip You can also pickpocket enemies inside the dungeon to get Strong Junkboxes and Heavy Junkboxes to unlock.
|tip
|tip Lock #1: Once inside the dungeon, immediately turn left, pick the locked door and walk through it.
|tip Lock #2: Up ahead, on the right, pick the locked door and walk through it.
|tip Lock #3: Up ahead, on the left, pick the locked door and walk through it.
|tip Lock #4: Straight ahead, under the huge gear, pick the Shadowforge Lock.
|tip
|tip After you pick these 4 locks, leave the dungeon the way you came.
|tip Outside the dungeon portal, right-click your player portrait.
|tip Select "Reset all instances" and re-enter the dungeon to repeat this process.
Reach Level 300 Lockpicking |skill Lockpicking,300
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Blacksmithing\\Specialization\\Armorsmith\\Armorsmith Questline",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Blacksmithing') >= 200 end,
description="This guide will walk you through completing the Armorsmith questline for the Blacksmithing profession.",
},[[
step
_NOTE ABOUT BLACKSMITHING SPECIALIZATION:_
|tip You can only have one Blacksmithing specialization.
|tip Additionally, you cannot change your specialization without unlearning the Blacksmithing profession, and leveling it up again.
|tip We recommend looking into the different options for Armorsmith and Weaponsmith Blacksmithing before you choose which to pursue, depending on your personal play style and the specific items you want to create.
|tip Most of the items you can create with the specializations are BoE, so you could also buy them from the AH or other players, but some of them are BoP and you would need to craft them to use them.
|tip If you change specializations, you will still be able to use the items you create.
Click Here to Continue |confirm
step
Reach Level 40 |ding 40
|tip You must be at least this level before you can begin this questline.
|tip Use the Leveling guides to accomplish this.
step
Reach Level 245 Blacksmithing |skill Blacksmithing,245
|tip You must be at least this level with your Blacksmithing profession before you can create some of the item needed in this questline.
|tip Use the "Blacksmithing (1-300)" guide to accomplish this.
step
talk Grumnus Steelshaper##5164
accept The Art of the Armorsmith##5283 |goto Ironforge 49.97,42.81
step
talk Bengus Deepforge##4258
learn Heavy Grinding Stone##3337 |goto 52.53,41.47
learn Golden Scale Bracers##7223 |goto 52.53,41.47
learn Solid Grinding Stone##9920 |goto 52.53,41.47
step
_Collect These Items:_
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 30 Steel Bar##3859 |q 2758 |future
collect 36 Heavy Stone##2838 |q 2758 |future
step
Open Your Blacksmithing Crafting Panel:
_<Create 12 Heavy Grinding Stones>_
collect 12 Heavy Grinding Stone##3486 |q 2758 |future
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 6 Golden Scale Bracers>_
collect 6 Golden Scale Bracers##6040 |goto Ironforge 49.83,44.12 |q 2758 |future
step
talk Hank the Hammer##7798
accept The Origins of Smithing##2758 |goto Stormwind City 56.00,15.41
step
talk Hank the Hammer##7798
turnin The Origins of Smithing##2758 |goto 56.00,15.41
accept In Search of Galvan##2759 |goto 56.00,15.41
step
use the Plans: Golden Scale Gauntlets##9367
learn Golden Scale Gauntlets##11643
step
Run up the ramp |goto Stranglethorn Vale 27.85,76.75 < 7 |only if walking
Follow the path |goto Stranglethorn Vale 28.40,75.77 < 7 |only if walking
talk McGavan##7794
turnin In Search of Galvan##2759 |goto Stranglethorn Vale 28.87,75.42
accept The Mithril Order##2760 |goto Stranglethorn Vale 28.87,75.42
step
Enter the building |goto 28.95,75.34 < 5 |walk
talk Brikk Keencraft##2836
|tip Inside the building.
learn Heavy Mithril Breastplate##9959 |goto 28.99,75.55
learn Mithril Coif##9961 |goto 28.99,75.55
learn Heavy Mithril Boots##9968 |goto 28.99,75.55
step
_Collect These Items:_
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 40 Iron Bar##3575 |q 2761 |future
collect 120 Mithril Bar##3860 |q 2763 |future
collect 5 Truesilver Bar##6037 |q 2762 |future
collect 4 Citrine##3864 |q 2763 |future
step
Enter the tunnel |goto 27.95,73.61 < 10 |only if walking
Leave the tunnel |goto 29.59,72.46 < 10 |only if walking
Follow the road |goto 30.96,71.70 < 30 |only if walking
Continue following the road |goto 33.46,55.53 < 30 |only if walking
Continue following the road |goto 36.15,48.91 < 30 |only if walking
Follow the path |goto 44.00,26.14 < 30 |only if walking
Follow the path up |goto 47.03,22.84 < 15 |only if walking
talk Galvan the Ancient##7802
turnin The Mithril Order##2760 |goto 50.62,20.48
accept Smelt On, Smelt Off##2761 |goto 50.62,20.48
accept The Great Silver Deceiver##2762 |goto 50.62,20.48
accept The Art of the Imbue##2763 |goto 50.62,20.48
step
talk Galvan the Ancient##7802
turnin Smelt On, Smelt Off##2761 |goto 50.62,20.48
turnin The Great Silver Deceiver##2762 |goto 50.62,20.48
turnin The Art of the Imbue##2763 |goto 50.62,20.48
accept Expert Blacksmith!##2765 |goto 50.62,20.48
step
Watch the dialogue
Watch Galvan Work |q 2765/1 |goto 50.57,20.37
step
talk Galvan the Ancient##7802
turnin Expert Blacksmith!##2765 |goto 50.57,20.37
accept Galvan's Finest Pupil##2764 |goto 50.57,20.37
step
use the Plans: Ornate Mithril Pants##7983
learn Ornate Mithril Pants##9945
step
use the Plans: Ornate Mithril Gloves##7984
learn Ornate Mithril Gloves##9950
step
use the Plans: Ornate Mithril Shoulder##7985
learn Ornate Mithril Shoulders##9952
step
_Collect These Items:_
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 114 Mithril Bar##3860 |q 2773 |future
collect 3 Truesilver Bar##6037 |q 2773 |future
collect Aquamarine##7909 |q 2772 |future
collect 8 Solid Stone##7912 |q 2773 |future
collect 14 Thick Leather##4304 |q 2772 |future
|tip If you have the Skinning profession, you can gather this.
collect 18 Mageweave Cloth##4338 |q 2773 |future
step
talk Trenton Lighthammer##7804
turnin Galvan's Finest Pupil##2764 |goto Tanaris 51.42,28.75
accept A Good Head On Your Shoulders##2771 |goto Tanaris 51.42,28.75
accept The World At Your Feet##2772 |goto Tanaris 51.42,28.75
accept The Mithril Kid##2773 |goto Tanaris 51.42,28.75
step
Open Your Blacksmithing Crafting Panel:
_<Create 2 Solid Grinding Stones>_
collect 2 Solid Grinding Stone##7966 |q 2773
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Mithril Coifs>_
collect 2 Mithril Coif##7931 |q 2771/1 |goto 51.42,28.75
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 1 Ornate Mithril Shoulders>_
collect Mithril Coif##7931 |q 2771/2 |goto 51.42,28.75
step
talk Trenton Lighthammer##7804
turnin A Good Head On Your Shoulders##2771 |goto 51.42,28.75
learn Ornate Mithril Helm##9980 |goto 51.42,28.75
|tip You will learn this automatically.
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Heavy Mithril Boots>_
collect 2 Heavy Mithril Boots##7933 |q 2772/1 |goto 51.42,28.75
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 1 Ornate Mithril Pants>_
collect Ornate Mithril Pants##7926 |q 2771/2 |goto 51.42,28.75
step
talk Trenton Lighthammer##7804
turnin The World At Your Feet##2772 |goto 51.42,28.75
learn Ornate Mithril Boots##9979 |goto 51.42,28.75
|tip You will learn this automatically.
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Heavy Mithril Breastplate>_
collect 2 Heavy Mithril Breastplate##7930 |q 2773/1 |goto 51.42,28.75
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 1 Ornate Mithril Gloves>_
collect Ornate Mithril Gloves##7927 |q 2773/2 |goto 51.42,28.75
step
talk Trenton Lighthammer##7804
turnin The Mithril Kid##2773 |goto 51.42,28.75
learn Ornate Mithril Breastplate##9972 |goto 51.42,28.75
|tip You will learn this automatically.
step
talk Trenton Lighthammer##7804
accept Did You Lose This?##3321 |goto 51.42,28.75
step
Watch the dialogue
Watch Trenton Work |q 3321/1 |goto 51.42,28.76
step
talk Trenton Lighthammer##7804
turnin Did You Lose This?##3321 |goto 51.42,28.76
step
_Collect These Items:_
|tip If you have the Mining profession, you can gather most these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 108 Mithril Bar##3860 |q 5283
collect 18 Truesilver Bar##6037 |q 5283
collect 2 Aquamarine##7909 |q 5283
collect 28 Solid Stone##7912 |q 5283
collect 4 Black Pearl##7971 |q 5283
collect Heart of Fire##7077 |q 5283
collect 8 Thick Leather##4304 |q 5283
|tip If you have the Skinning profession, you can gather this.
step
Open Your Blacksmithing Crafting Panel:
_<Create 7 Solid Grinding Stones>_
collect 7 Solid Grinding Stone##7966 |q 5283
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 4 Ornate Mithril Helms>_
collect 4 Ornate Mithril Helm##7937 |q 5283/1 |goto Ironforge 49.83,44.12
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Ornate Mithril Boots>_
collect 2 Ornate Mithril Boots##7936 |q 5283/2 |goto 49.83,44.12
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 1 Ornate Mithril Breastplate>_
collect Ornate Mithril Breastplate##7935 |q 5283/3 |goto 49.83,44.12
step
talk Grumnus Steelshaper##5164
turnin The Art of the Armorsmith##5283 |goto 49.98,42.82
learn Armorsmith##9788 |goto 49.98,42.82
|tip You will learn this automatically.
step
_Congratulations!_
|tip You have become a Blacksmithing Armorsmith.
Learn Plans From Grumnus Steelshaper at [Ironforge 49.98,42.82]
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Blacksmithing\\Specialization\\Weaponsmith\\Weaponsmith Questline",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Blacksmithing') >= 200 end,
description="This guide will walk you through completing the Weaponsmith questline for the Blacksmithing profession.",
},[[
step
_NOTE ABOUT BLACKSMITHING SPECIALIZATION:_
|tip You can only have one Blacksmithing specialization.
|tip Additionally, you cannot change your specialization without unlearning the Blacksmithing profession, and leveling it up again.
|tip We recommend looking into the different options for Armorsmith and Weaponsmith Blacksmithing before you choose which to pursue, depending on your personal play style and the specific items you want to create.
|tip Most of the items you can create with the specializations are BoE, so you could also buy them from the AH or other players, but some of them are BoP and you would need to craft them to use them.
|tip If you change specializations, you will still be able to use the items you create.
Click Here to Continue |confirm
step
Reach Level 40 |ding 40
|tip You must be at least this level before you can begin this questline.
|tip Use the Leveling guides to accomplish this.
step
Reach Level 230 Blacksmithing |skill Blacksmithing,230
|tip You must be at least this level with your Blacksmithing profession before you can create some of the item needed in this questline.
|tip Use the "Blacksmithing (1-300)" guide to accomplish this.
step
talk Ironus Coldsteel##11146
accept The Way of the Weaponsmith##5284 |goto Ironforge 50.33,43.55
step
Run up the ramp |goto Stranglethorn Vale 27.85,76.75 < 7 |only if walking
Follow the path |goto Stranglethorn Vale 28.40,75.77 < 7 |only if walking
Enter the building |goto Stranglethorn Vale 28.95,75.34 < 5 |walk
talk Brikk Keencraft##2836
|tip Inside the building.
learn Heavy Grinding Stone##3337 |goto Stranglethorn Vale 28.99,75.55
learn Solid Grinding Stone##9920 |goto Stranglethorn Vale 28.99,75.55
learn Heavy Mithril Axe##9993 |goto Stranglethorn Vale 28.99,75.55
learn Big Black Mace##10001 |goto Stranglethorn Vale 28.99,75.55
step
Leave the building |goto 44.39,93.07 < 5 |walk
Jump down and enter the building |goto 44.31,93.11 < 5 |walk
talk Zarena Cromwind##2482
|tip Inside the building.
buy Plans: Moonsteel Broadsword##12163 |n
|tip This is a limited supply item.
|tip If she doesn't have it for sale, check the Auction House.
use the Plans: Moonsteel Broadsword##12163
learn Moonsteel Broadsword##3496 |goto 44.28,93.09
step
Run up the ramp |goto 44.02,92.76 < 7 |only if walking
Enter the tunnel |goto 27.95,73.61 < 10 |only if walking
Leave the tunnel |goto 29.59,72.46 < 10 |only if walking
Follow the road |goto 30.96,71.70 < 30 |only if walking
Continue following the road |goto 33.46,55.53 < 30 |only if walking
Continue following the road |goto 36.15,48.91 < 30 |only if walking
Continue following the road |goto 43.93,28.59 < 30 |only if walking
Follow the path down |goto 35.20,14.73 < 30 |only if walking
talk Jaquilina Dramet##2483
buy Plans: Massive Iron Axe##12164 |n
|tip This is a limited supply item.
|tip If she doesn't have it for sale, check the Auction House.
use the Plans: Massive Iron Axe##12164
learn Massive Iron Axe##3498 |goto 35.75,10.66
step
_Collect These Items:_
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 32 Steel Bar##3859 |q 5284
collect 56 Mithril Bar##3860 |q 5284
collect 56 Iron Bar##3575 |q 5284
collect 16 Gold Bar##3577 |q 5284
collect 48 Heavy Stone##2838 |q 5284
collect 16 Solid Stone##7912 |q 5284
collect 4 Citrine##3864 |q 5284
collect 2 Black Pearl##7971 |q 5284
collect 8 Shadowgem##1210 |q 5284
collect 12 Lesser Moonstone##1705 |q 5284
collect 28 Heavy Leather##4234 |q 5284
|tip If you have the Skinning profession, you can gather this.
collect 4 Thick Leather##4304 |q 5284
|tip If you have the Skinning profession, you can gather this.
step
talk Thurgrum Deepforge##4259
buy 16 Strong Flux##3466 |goto Ironforge 51.72,42.80 |q 5284
step
Open Your Blacksmithing Crafting Panel:
_<Create 4 Solid Grinding Stones>_
collect 4 Solid Grinding Stone##7966 |q 5284
step
Open Your Blacksmithing Crafting Panel:
_<Create 16 Heavy Grinding Stones>_
collect 16 Heavy Grinding Stone##3486 |q 5284
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 4 Moonsteel Broadswords>_
collect 4 Moonsteel Broadsword##3853 |q 5284/1 |goto 51.42,28.75
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 4 Massive Iron Axes>_
collect 4 Massive Iron Axe##3855 |q 5284/2 |goto 51.42,28.75
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Heavy Mithril Axes>_
collect 2 Heavy Mithril Axe##7941 |q 5284/3 |goto 51.42,28.75
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Big Black Maces>_
collect 2 Big Black Mace##7945 |q 5284/4 |goto 51.42,28.75
step
talk Ironus Coldsteel##11146
turnin The Way of the Weaponsmith##5284 |goto 50.33,43.55
learn Weaponsmith##9787 |goto 50.33,43.55
|tip You will learn this automatically.
step
_Congratulations!_
|tip You have become a Blacksmithing Weaponsmith.
Learn Plans From Ironus Coldsteel at [Ironforge 50.33,43.55]
|tip You can continue your specialization by choosing from 3 paths:
|tip Master Axesmith
|tip Master Hammersmith
|tip Master Swordsmith
|tip Search the guide menu for the title above to find the questline guide associated with it.
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Blacksmithing\\Specialization\\Weaponsmith\\Master Axesmith Questline",{
author="support@zygorguides.com",
description="This guide will walk you through completing the Master Axesmith questline to continue Weaponsmith specialization for the Blacksmithing profession.",
},[[
step
_NOTE ABOUT BLACKSMITHING SPECIALIZATION:_
|tip You can only have one Blacksmithing specialization.
|tip Additionally, you cannot change your specialization without unlearning the Blacksmithing profession, and leveling it up again.
|tip We recommend looking into the different options for Armorsmith and Weaponsmith Blacksmithing before you choose which to pursue, depending on your personal play style and the specific items you want to create.
|tip Most of the items you can create with the specializations are BoE, so you could also buy them from the AH or other players, but some of them are BoP and you would need to craft them to use them.
|tip If you change specializations, you will still be able to use the items you create.
Click Here to Continue |confirm
step
learn Weaponsmith##9787
|tip You must become a Weaponsmith before you can begin this questline.
|tip Use the "Weaponsmith Questline" guide to accomplish this.
step
Reach Level 50 |ding 50
|tip You must be at least this level before you can begin this questline.
|tip Use the Leveling guides to accomplish this.
step
Reach Level 250 Blacksmithing |skill Blacksmithing,250
|tip You must be at least this level with your Blacksmithing profession before you can begin this questline.
|tip Use the "Blacksmithing (1-300)" guide to accomplish this.
step
Follow the path |goto Winterspring 60.56,38.20 < 7 |only if walking
Enter the building |goto Winterspring 61.33,37.36 < 7 |walk
talk Kilram##11192
|tip Inside the building.
accept Snakestone of the Shadow Huntress##5306 |goto Winterspring 61.30,37.07
step
kill Shadow Hunter Vosh'gajin##9236
|tip She is a boss inside the Lower Blackrock Spire dungeon.
|tip Use the "Lower Blackrock Spire" dungeon guide to accomplish this.
collect Vosh'gajin's Snakestone##13352 |q 5306/1
step
Follow the path |goto Winterspring 60.56,38.20 < 7 |only if walking
Enter the building |goto Winterspring 61.33,37.36 < 7 |walk
talk Kilram##11192
|tip Inside the building.
turnin Snakestone of the Shadow Huntress##5306 |goto Winterspring 61.30,37.07
step
talk Kilram##11192
|tip Inside the building.
Tell him _"Please teach me how to become an axesmith, Kilram."_
learn Master Axesmith##17041 |goto 61.30,37.07
step
Reach Level 275 Blacksmithing |skill Blacksmithing,275
|tip You must be at least this level with your Blacksmithing profession before you can learn the plans in the next step.
|tip Use the "Blacksmithing (1-300)" guide to accomplish this.
step
use the Plans: Dawn's Edge##12821
learn Dawn's Edge##16970
step
_Congratulations!_
|tip You have become a Master Axesmith.
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Blacksmithing\\Specialization\\Weaponsmith\\Master Hammersmith Questline",{
author="support@zygorguides.com",
description="This guide will walk you through completing the Master Hammersmith questline to continue Weaponsmith specialization for the Blacksmithing profession.",
},[[
step
_NOTE ABOUT BLACKSMITHING SPECIALIZATION:_
|tip You can only have one Blacksmithing specialization.
|tip Additionally, you cannot change your specialization without unlearning the Blacksmithing profession, and leveling it up again.
|tip We recommend looking into the different options for Armorsmith and Weaponsmith Blacksmithing before you choose which to pursue, depending on your personal play style and the specific items you want to create.
|tip Most of the items you can create with the specializations are BoE, so you could also buy them from the AH or other players, but some of them are BoP and you would need to craft them to use them.
|tip If you change specializations, you will still be able to use the items you create.
Click Here to Continue |confirm
step
learn Weaponsmith##9787
|tip You must become a Weaponsmith before you can begin this questline.
|tip Use the "Weaponsmith Questline" guide to accomplish this.
step
Reach Level 50 |ding 50
|tip You must be at least this level before you can begin this questline.
|tip Use the Leveling guides to accomplish this.
step
Reach Level 250 Blacksmithing |skill Blacksmithing,250
|tip You must be at least this level with your Blacksmithing profession before you can begin this questline.
|tip Use the "Blacksmithing (1-300)" guide to accomplish this.
step
Follow the path |goto Winterspring 60.56,38.20 < 7 |only if walking
Enter the building |goto Winterspring 61.33,37.36 < 7 |walk
talk Lilith the Lithe##11191
|tip Inside the building.
accept Sweet Serenity##5305 |goto Winterspring 61.33,37.13
step
kill Crimson Hammersmith##11120
|tip He is a boss inside the Main Gate section of the Stratholme dungeon.
|tip Use the "Stratholme" dungeon guide to accomplish this.
collect Crimson Hammersmith's Apron##13351 |q 5305/1
step
Follow the path |goto Winterspring 60.56,38.20 < 7 |only if walking
Enter the building |goto Winterspring 61.33,37.36 < 7 |walk
talk Lilith the Lithe##11191
|tip Inside the building.
turnin Sweet Serenity##5305 |goto Winterspring 61.33,37.13
step
talk Lilith the Lithe##11191
|tip Inside the building.
Tell him _"Please teach me how to become a hammersmith, Lilith."_
learn Master Hammersmith##17040 |goto 61.33,37.13
step
Reach Level 280 Blacksmithing |skill Blacksmithing,280
|tip You must be at least this level with your Blacksmithing profession before you can learn the plans in the next step.
|tip Use the "Blacksmithing (1-300)" guide to accomplish this.
step
use the Plans: Enchanted Battlehammer##12824
learn Enchanted Battlehammer##16973
step
_Congratulations!_
|tip You have become a Master Hammersmith.
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Blacksmithing\\Specialization\\Weaponsmith\\Master Swordsmith Questline",{
author="support@zygorguides.com",
description="This guide will walk you through completing the Master Swordsmith questline to continue Weaponsmith specialization for the Blacksmithing profession.",
},[[
step
_NOTE ABOUT BLACKSMITHING SPECIALIZATION:_
|tip You can only have one Blacksmithing specialization.
|tip Additionally, you cannot change your specialization without unlearning the Blacksmithing profession, and leveling it up again.
|tip We recommend looking into the different options for Armorsmith and Weaponsmith Blacksmithing before you choose which to pursue, depending on your personal play style and the specific items you want to create.
|tip Most of the items you can create with the specializations are BoE, so you could also buy them from the AH or other players, but some of them are BoP and you would need to craft them to use them.
|tip If you change specializations, you will still be able to use the items you create.
Click Here to Continue |confirm
step
learn Weaponsmith##9787
|tip You must become a Weaponsmith before you can begin this questline.
|tip Use the "Weaponsmith Questline" guide to accomplish this.
step
Reach Level 50 |ding 50
|tip You must be at least this level before you can begin this questline.
|tip Use the Leveling guides to accomplish this.
step
Reach Level 250 Blacksmithing |skill Blacksmithing,250
|tip You must be at least this level with your Blacksmithing profession before you can begin this questline.
|tip Use the "Blacksmithing (1-300)" guide to accomplish this.
step
Follow the path |goto Winterspring 60.56,38.20 < 7 |only if walking
Enter the building |goto Winterspring 61.33,37.36 < 7 |walk
talk Seril Scourgebane##11193
|tip Inside the building.
accept Corruption##5307 |goto Winterspring 61.33,37.19
step
kill Black Guard Swordsmith##11121
|tip He is a boss inside the Service Gate section of the Stratholme dungeon.
|tip Use the "Stratholme" dungeon guide to accomplish this.
collect Insignia of the Black Guard##13350 |q 5307/1
step
Follow the path |goto Winterspring 60.56,38.20 < 7 |only if walking
Enter the building |goto Winterspring 61.33,37.36 < 7 |walk
talk Seril Scourgebane##11193
|tip Inside the building.
turnin Corruption##5307 |goto Winterspring 61.33,37.19
step
talk Seril Scourgebane##11193
|tip Inside the building.
Tell him _"Please teach me how to become a swordsmith, Seril."_
learn Master Swordsmith##17039 |goto 61.33,37.19
step
Reach Level 280 Blacksmithing |skill Blacksmithing,280
|tip You must be at least this level with your Blacksmithing profession before you can learn the plans in the next step.
|tip Use the "Blacksmithing (1-300)" guide to accomplish this.
step
use the Plans: Blazing Rapier##12825
learn Blazing Rapier##16978
step
_Congratulations!_
|tip You have become a Master Swordsmith.
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Blacksmithing\\Specialization\\How to Change Blacksmithing Specialization",{
author="support@zygorguides.com",
description="This guide will walk you through changing your Blacksmithing profession specialization.",
},[[
step
_NOTE:_
|tip You MUST fully complete the questline for either Armorsmith or Weaponsmith before you can switch specializations.
Click Here to Continue |confirm
step
Unlearn Blacksmithing |condition skill("Blacksmithing") == 0
|tip Press "K" to open your Skills tab.
|tip You must completely unlearn the Blacksmithing profession to be able to switch your specialization.
step
Reach Level 40 |ding 40
|tip Use the Leveling guides to accomplish this.
|tip You must be at least level 30 to be able to start the questlines to choose an Blacksmithing specialization.
step
Reach Level 200 Blacksmithing |condition skill("Blacksmithing") >= 200
|tip Use the "Blacksmithing (1-300)" guide to accomplish this.
|tip You must be at least level 200 Blacksmithing to be able to start the questlines to choose an Blacksmithing specialization.
step
Follow the path |goto Tanaris 64.90,22.54 < 30 |only if walking
Enter the building |goto Tanaris 65.41,18.56 < 7 |walk
click Book "Soothsaying for Dummies"
|tip Inside the building.
|tip Choose the dialogue option that matches what you want to do.
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Engineering\\Specialization\\Gnomish Engineering\\Gnomish Engineering Questline",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Engineering') >= 200 end,
description="This guide will walk you through completing the Gnomish Engineering questline for the Engineering profession.",
},[[
step
_NOTE ABOUT GNOMISH ENGINEERING:_
|tip You cannot specialize in both Gnomish and Goblin Engineering.
|tip Additionally, you cannot change your specialization without unlearning the Engineering profession, and leveling it up again.
|tip We recommend looking into the differences between Gnomish and Goblin Engineering before you choose which to pursue, depending on your personal play style and the specific items you want to create.
|tip You can create some of the most desirable Bind On Pickup trinkets for a specialization, unlearn Engineering to level it up again to learn the other specialization.
|tip If you change specializations, you will still be able to use the items you create, unless they specifically require Gnomish Engineering to use it.
Click Here to Continue |confirm
step
Reach Level 30 |ding 30
|tip You must be at least this level before you can begin this questline.
|tip Use the Leveling guides to accomplish this.
step
Reach Level 200 Engineering |skill Engineering,200
|tip You must be at least level 200 with your Engineering profession before you can begin this questline.
|tip Use the "Engineering (1-300)" guide to accomplish this.
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
accept Gnome Engineering##3632 |goto Ironforge 68.46,43.56
step
talk Tinkmaster Overspark##7944
turnin Gnome Engineering##3632 |goto 69.56,50.31
accept The Pledge of Secrecy##3640 |goto 69.56,50.31
step
use Overspark's Pledge of Secrecy##10793
collect Overspark's Signed Pledge##11283 |q 3640/1
step
talk Tinkmaster Overspark##7944
turnin The Pledge of Secrecy##3640 |goto 69.56,50.31
accept Show Your Work##3641 |goto 69.56,50.31
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
learn Bronze Framework##3953 |goto 68.47,43.56
learn Gold Power Core##12584 |goto 68.47,43.56
learn Iron Strut##3958 |goto 68.47,43.56
learn Gyrochronatom##3961 |goto 68.47,43.56
learn Advanced Target Dummy##3965 |goto 68.47,43.56
step
talk Gearcutter Cogspinner##5175
|tip Inside the building.
buy Weak Flux##2880 |goto 67.85,42.51
step
Enter the building |goto Stranglethorn Vale 28.11,74.99 < 7 |walk
talk Mazk Snipeshot##2685
|tip Inside the building.
buy Schematic: Accurate Scope##13310
|tip This is a limited supply item.
|tip If he doesn't have it for sale, check the Auction House.
use the Schematic: Accurate Scope##13310
learn Accurate Scope##3979 |goto Stranglethorn Vale 28.50,75.12
step
_Collect These Items:_
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 18 Mithril Bar##3860 |q 3641
collect 6 Bronze Bar##2841 |q 3641
collect Jade##1529 |q 3641
collect Citrine##3864 |q 3641
collect 6 Iron Bar##3575 |q 3641
collect Gold Bar##3577 |q 3641
collect 2 Medium Leather##2319 |q 3641
|tip If you have the Skinning profession, you can gather this.
collect 8 Heavy Leather##4234 |q 3641
|tip If you have the Skinning profession, you can gather this.
collect 2 Wool Cloth##2592 |q 3641
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 6 Mithril Tubes>_
collect 6 Mithril Tube##10559 |q 3641/1 |goto Ironforge 49.83,44.12
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 1 Bronze Tube>_
collect Bronze Tube##4371 |goto 49.83,44.12 |q 3641
step
Open Your Engineering Crafting Panel:
_<Create 1 Accurate Scope>_
collect Accurate Scope##4407 |q 3641/2
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Iron Struts>_
collect 2 Iron Strut##4387 |goto 49.83,44.12 |q 3641
step
Open Your Engineering Crafting Panel:
_<Create 2 Bronze Frameworks>_
collect 2 Bronze Framework##4382 |q 3641
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 1 Gold Power Core>_
|tip This schematic will give you 3 of these.
collect 2 Gold Power Core##10558 |goto 49.83,44.12 |q 3641
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Gyrochronatoms>_
collect 2 Gyrochronatom##4389 |goto 49.83,44.12 |q 3641
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Advanced Target Dummies>_
collect 2 Advanced Target Dummy##4392 |q 3641/3 |goto 49.83,44.12
step
talk Tinkmaster Overspark##7944
turnin Show Your Work##3641 |goto 69.56,50.31
step
_Congratulations!_
|tip You have earned your Gnome Engineer Membership Card.
|tip This card allows you to learn Gnomish Engineering schematics from Tinkmaster Overspark.
|tip This item will last for 14 days of in-game play time.
|tip The time will not count down when you are logged out, so it will last a long time.
|tip You can only learn Gnomish Engineering schematics while you have this item in your bags.
|tip When the time runs out, you can renew the card, if you need to.
|tip Use the "Gnomish Engineering Card Renewal" guide to renew the card.
Learn Schematics From Tinkmaster Overspark at [Ironforge 69.56,50.31]
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Engineering\\Specialization\\Gnomish Engineering\\Gnome Engineer Membership Card Renewal",{
author="support@zygorguides.com",
description="This guide will walk you through renewing your Gnome Engineer Membership Card, as well as using the Gnome Engineer's Renewal Gifts to collect rare schematics.",
},[[
step
talk Tinkmaster Overspark##7944
accept Membership Card Renewal##3647 |goto Ironforge 69.56,50.33
|tip You must have the Gnomish Engineering specialization to be able to complete this quest.
|tip This quest requires 2 gold to complete.
|tip This will keep your Gnome Engineer Membership Card active for another 14 days of played time.
step
collect Gnome Engineer's Renewal Gift##11423 |n
|tip You will receive one of these in your mailbo 24 hours after renewing your membership card.
|tip You can destroy and renew your membership card repeatedly, if you want more of them to open.
|tip You don't need to wait for the card to expire on its own.
use the Gnome Engineer's Renewal Gift##11423
|tip These will contain some Engineer crafting supplies.
|tip The rare schematic for the "Lil' Smoky" pet also has a chance to be inside.
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Engineering\\Specialization\\Goblin Engineering\\Goblin Engineering Questline",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Engineering') >= 200 end,
description="This guide will walk you through completing the Goblin Engineering questline for the Engineering profession.",
},[[
step
_NOTE ABOUT GOBLIN ENGINEERING:_
|tip You cannot specialize in both Gnomish and Goblin Engineering.
|tip Additionally, you cannot change your specialization without unlearning the Engineering profession, and leveling it up again.
|tip We recommend looking into the differences between Gnomish and Goblin Engineering before you choose which to pursue, depending on your personal play style and the specific items you want to create.
|tip You can create some of the most desirable Bind On Pickup trinkets for a specialization, unlearn Engineering to level it up again to learn the other specialization.
|tip If you change specializations, you will still be able to use the items you create, unless they specifically require Goblin Engineering to use it.
Click Here to Continue |confirm
step
Reach Level 30 |ding 30
|tip You must be at least this level before you can begin this questline.
|tip Use the Leveling guides to accomplish this.
step
Reach Level 200 Engineering |skill Engineering,200
|tip You must be at least level 200 with your Engineering profession before you can begin this questline.
|tip Use the "Engineering (1-300)" guide to accomplish this.
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
accept Goblin Engineering##4181 |goto Ironforge 68.46,43.56
step
Enter the building |goto Tanaris 52.39,27.30 < 5 |walk
talk Nixx Sprocketspring##8126
|tip Inside the building.
turnin Goblin Engineering##4181 |goto Tanaris 52.48,27.33
accept The Pledge of Secrecy##3638 |goto Tanaris 52.48,27.33
step
use Nixx's Pledge of Secrecy##10792
collect Nixx's Signed Pledge##11270 |q 3638/1
step
talk Nixx Sprocketspring##8126
|tip Inside the building.
turnin The Pledge of Secrecy##3638 |goto 52.48,27.33
accept Show Your Work##3639 |goto 52.48,27.33
step
_Collect These Items:_
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 30 Iron Bar##3575 |q 3639
collect 40 Heavy Stone##2838 |q 3639
collect 2 Silver Bar##2842 |q 3639
collect 20 Solid Stone##7912 |q 3639
collect 10 Silk Cloth##4306 |q 3639
collect 20 Bronze Bar##2841 |q 3639
collect 5 Medium Leather##2319 |q 3639
|tip If you have the Skinning profession, you can gather this.
collect 20 Wool Cloth##2592 |q 3639
step
talk Springspindle Fizzlegear##5174
|tip Inside the building.
learn Big Iron Bomb##3967 |goto Ironforge 68.47,43.56
learn Solid Dynamite##12586 |goto Ironforge 68.47,43.56
learn Explosive Sheep##3955 |goto Ironforge 68.47,43.56
learn Solid Blasting Powder##12585 |goto Ironforge 68.47,43.56
learn Bronze Framework##3953 |goto Ironforge 68.47,43.56
learn Heavy Blasting Powder##3945 |goto Ironforge 68.47,43.56
learn Whirring Bronze Gizmo##3942 |goto Ironforge 68.47,43.56
learn Silver Contact##3973 |goto Ironforge 68.47,43.56
step
Open Your Engineering Crafting Panel:
_<Create 40 Heavy Blasting Powder>_
collect 40 Heavy Blasting Powder##4377 |q 3639
step
Open Your Engineering Crafting Panel:
_<Create 2 Silver Contacts>_
|tip This schematic will give you 5 of these.
collect 10 Silver Contact##4404 |q 3639
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 10 Big Iron Bombs>_
|tip This schematic will give you 2 of these.
collect 20 Big Iron Bomb##4394 |q 3639/1 |goto 49.83,44.12
step
Open Your Engineering Crafting Panel:
_<Create 10 Solid Blasting Powder>_
collect 10 Solid Blasting Powder##10505 |q 3639
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 10 Solid Dynamite>_
|tip This schematic will give you 2 of these.
collect 20 Solid Dynamite##10507 |q 3639/2 |goto 49.83,44.12
step
Open Your Engineering Crafting Panel:
_<Create 5 Bronze Frameworks>_
collect 5 Bronze Framework##4382 |q 3639
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 5 Whirring Bronze Gizmos>_
collect 5 Whirring Bronze Gizmo##4375 |goto 49.83,44.12 |q 3639
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 5 Explosive Sheep>_
collect 5 Explosive Sheep##4384 |q 3639/3 |goto 49.83,44.12
step
Enter the building |goto Tanaris 52.39,27.30 < 5 |walk
talk Nixx Sprocketspring##8126
|tip Inside the building.
turnin Show Your Work##3639 |goto Tanaris 52.48,27.33
step
_Congratulations!_
|tip You have earned your Goblin Engineer Membership Card.
|tip This card allows you to learn Goblin Engineering schematics from Nixx Sprocketspring.
|tip This item will last for 14 days of in-game play time.
|tip The time will not count down when you are logged out, so it will last a long time.
|tip You can only learn Goblin Engineering schematics while you have this item in your bags.
|tip When the time runs out, you can renew the card, if you need to.
|tip Use the "Goblin Engineering Card Renewal" guide to renew the card.
Learn Schematics From Nixx Sprocketspring at [Tanaris 52.48,27.33]
|tip Inside the building.
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Engineering\\Specialization\\Goblin Engineering\\Goblin Engineer Membership Card Renewal",{
author="support@zygorguides.com",
description="This guide will walk you through renewing your Goblin Engineer Membership Card, as well as using the Goblin Engineer's Renewal Gifts to collect rare schematics.",
},[[
step
Enter the building |goto Tanaris 52.39,27.30 < 5 |walk
talk Nixx Sprocketspring##8126
|tip Inside the building.
accept Membership Card Renewal##3644 |goto Tanaris 52.48,27.33
|tip You must have the Goblin Engineering specialization to be able to complete this quest.
|tip This quest requires 2 gold to complete.
|tip This will keep your Goblin Engineer Membership Card active for another 14 days of played time.
step
collect Goblin Engineer's Renewal Gift##11422 |n
|tip You will receive one of these in your mailbo 24 hours after renewing your membership card.
|tip You can destroy and renew your membership card repeatedly, if you want more of them to open.
|tip You don't need to wait for the card to expire on its own.
use the Goblin Engineer's Renewal Gift##11422
|tip These will contain some Engineer crafting supplies.
|tip The rare schematic for the "Pet Bombling" pet also has a chance to be inside.
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Engineering\\Specialization\\How to Change Engineering Specialization",{
author="support@zygorguides.com",
description="This guide will walk you through changing your Engineering profession specialization.",
},[[
step
_NOTE:_
|tip You MUST fully complete the questline for either Gnomish Engineering or Goblin engineering before you can switch specializations.
|tip You must have obtained either the Gnome Engineer Membership Card or Goblin Engineer Membership Card, or it won't let you switch.
Click Here to Continue |confirm
step
Unlearn Engineering |condition skill("Engineering") == 0
|tip Press "K" to open your Skills tab.
|tip You must completely unlearn the Engineering profession to be able to switch your specialization.
step
Reach Level 30 |ding 30
|tip Use the Leveling guides to accomplish this.
|tip You must be at least level 30 to be able to start the questlines to choose an Engineering specialization.
step
Reach Level 200 Engineering |condition skill("Engineering") >= 200
|tip Use the "Engineering (1-300)" guide to accomplish this.
|tip You must be at least level 200 Engineering to be able to start the questlines to choose an Engineering specialization.
step
Follow the path |goto Tanaris 64.90,22.54 < 30 |only if walking
Enter the building |goto Tanaris 65.41,18.56 < 7 |walk
click Book "Soothsaying for Dummies"
|tip Inside the building.
|tip Choose the dialogue option that matches what you want to do.
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Leatherworking\\Specialization\\Dragonscale Leatherworking\\Dragonscale Leatherworking Questline",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Leatherworking') >= 225 end,
description="This guide will walk you through completing the Dragonscale Leatherworking questline for the Leatherworking profession.",
},[[
step
_NOTE ABOUT LEATHERWORKING SPECIALIZATION:_
|tip You can only have one Leatherworking specialization.
|tip Additionally, you cannot change your specialization without unlearning the Leatherworking profession, and leveling it up again.
|tip We recommend looking into the different options for Dragonscale, Elemental, and Tribal Leatherworking before you choose which to pursue, depending on your personal play style and the specific items you want to create.
Click Here to Continue |confirm
step
Reach Level 40 |ding 40
|tip You must be at least this level before you can begin this questline.
|tip Use the Leveling guides to accomplish this.
step
Reach Level 225 Leatherworking |skill Leatherworking,225
|tip You must be at least this level with your Leatherworking profession before you can begin this questline.
|tip Use the "Leatherworking (1-300)" guide to accomplish this.
stickystart "Learn_Tough_Scorpid_Gloves"
step
kill Wastewander Bandit##5618+
collect Pattern: Tough Scorpid Breastplate##8395 |n
|tip You can also purchase this from the Auction House, if you don't want to grind for it.
use the Pattern: Tough Scorpid Breastplate##8395
learn Tough Scorpid Breastplate##10525 |goto Tanaris 60.30,24.02
You can find more Wastewander Bandits around:
[Tanaris 63.62,31.49]
step
label "Learn_Tough_Scorpid_Gloves"
kill Wastewander Thief##5616+
collect Pattern: Tough Scorpid Gloves##8398 |n
|tip You can also purchase this from the Auction House, if you don't want to grind for it.
use the Pattern: Tough Scorpid Gloves##8398
learn Tough Scorpid Gloves##10542 |goto Tanaris 60.30,24.02
You can find more Wastewander Thieves around:
[Tanaris 63.62,31.49]
step
_Collect These Items:_
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 36 Thick Leather##4304 |q 5141 |future
collect 40 Scorpid Scale##8154 |q 5141 |future
collect 10 Worn Dragonscale##8165 |q 5141 |future
|tip These are skinned from Dragonkin enemies and bosses inside the Temple of Atal'Hakkar (Sunken Temple) dungeon.
step
Enter the building |goto Darkshore 37.77,41.35 < 10 |walk
talk Valdaron##4189
|tip Inside the building.
buy 12 Silken Thread##4291 |goto Darkshore 38.15,40.60 |q 5141 |future
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Tough Scorpid Gloves>_
collect 2 Tough Scorpid Gloves##8204 |q 5141 |future
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Tough Scorpid Breastplates>_
collect 2 Tough Scorpid Breastplate##8203 |q 5141 |future
step
Follow the road |goto Azshara 15.68,75.85 < 30 |only if walking
Follow the path |goto Azshara 27.65,59.62 < 30 |only if walking
Continue following the path |goto Azshara 33.85,62.14 < 30 |only if walking
Continue following the path |goto Azshara 35.14,65.45 < 30 |only if walking
talk Peter Galen##7866
accept Dragonscale Leatherworking##5141 |goto Azshara 37.59,65.42
step
talk Peter Galen##7866
turnin Dragonscale Leatherworking##5141 |goto 37.59,65.42
learn Dragonscale Leatherworking##10656 |goto 37.59,65.42
|tip You will learn this automatically.
step
_Congratulations!_
|tip You have become a Dragonscale Leatherworker.
Learn Patterns From Peter Galen at [Azshara 37.59,65.42]
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Leatherworking\\Specialization\\Elemental Leatherworking\\Elemental Leatherworking Questline",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Leatherworking') >= 225 end,
description="This guide will walk you through completing the Elemental Leatherworking questline for the Leatherworking profession.",
},[[
step
_NOTE ABOUT LEATHERWORKING SPECIALIZATION:_
|tip You can only have one Leatherworking specialization.
|tip Additionally, you cannot change your specialization without unlearning the Leatherworking profession, and leveling it up again.
|tip We recommend looking into the different options for Dragonscale, Elemental, and Tribal Leatherworking before you choose which to pursue, depending on your personal play style and the specific items you want to create.
Click Here to Continue |confirm
step
Reach Level 40 |ding 40
|tip You must be at least this level before you can begin this questline.
|tip Use the Leveling guides to accomplish this.
step
Reach Level 225 Leatherworking |skill Leatherworking,225
|tip You must be at least this level with your Leatherworking profession before you can begin this questline.
|tip Use the "Leatherworking (1-300)" guide to accomplish this.
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 2 Heart of Fire##7077 |q 5144 |future
collect 2 Globe of Water##7079 |q 5144 |future
collect 2 Core of Earth##7075 |q 5144 |future
collect 2 Breath of Wind##7081 |q 5144 |future
step
talk Sarah Tanner##7868
accept Elemental Leatherworking##5144 |goto Searing Gorge 63.56,75.97
step
talk Sarah Tanner##7868
turnin Elemental Leatherworking##5144 |goto 63.56,75.97
step
_Congratulations!_
|tip You have become an Elemental Leatherworker.
Learn Patterns From Sarah Tanner at [Searing Gorge 63.56,75.97]
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Leatherworking\\Specialization\\Tribal Leatherworking\\Tribal Leatherworking Questline",{
author="support@zygorguides.com",
condition_suggested=function() return skill('Leatherworking') >= 225 end,
description="This guide will walk you through completing the Tribal Leatherworking questline for the Leatherworking profession.",
},[[
step
_NOTE ABOUT LEATHERWORKING SPECIALIZATION:_
|tip You can only have one Leatherworking specialization.
|tip Additionally, you cannot change your specialization without unlearning the Leatherworking profession, and leveling it up again.
|tip We recommend looking into the different options for Dragonscale, Elemental, and Tribal Leatherworking before you choose which to pursue, depending on your personal play style and the specific items you want to create.
Click Here to Continue |confirm
step
Reach Level 40 |ding 40
|tip You must be at least this level before you can begin this questline.
|tip Use the Leveling guides to accomplish this.
step
Reach Level 235 Leatherworking |skill Leatherworking,235
|tip You must be at least this level with your Leatherworking profession before you can creature some of the patterns needed for this questline.
|tip Use the "Leatherworking (1-300)" guide to accomplish this.
step
Enter the building |goto The Hinterlands 14.17,45.22 < 20 |walk
Run down the stairs |goto The Hinterlands 13.18,43.43 < 5 |walk
talk Drakk Stonehand##11097
|tip Downstairs inside the building.
learn Cured Thick Hide##10482 |goto The Hinterlands 13.39,43.48
learn Thick Armor Kit##10487 |goto The Hinterlands 13.39,43.48
learn Nightscape Headband##10507 |goto The Hinterlands 13.39,43.48
learn Nightscape Tunic##10499 |goto The Hinterlands 13.39,43.48
learn Turtle Scale Bracers##10518 |goto The Hinterlands 13.39,43.48
learn Turtle Scale Breastplate##10511 |goto The Hinterlands 13.39,43.48
learn Turtle Scale Helm##10552 |goto The Hinterlands 13.39,43.48
learn Nightscape Boots##10558 |goto The Hinterlands 13.39,43.48
learn Nightscape Pants##10548 |goto The Hinterlands 13.39,43.48
step
_Collect These Items:_
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 214 Thick Leather##4304 |q 2851 |future
collect 112 Turtle Scale##8167 |q 2852 |future
collect 11 Wildvine##8153 |q 5143 |future
|tip If you have the Herbalism profession, you can gather these.
collect 2 Cured Thick Hide##8172 |q 5143 |future
step
talk Pratt McGrubben##7852
buy Pattern: Turtle Scale Gloves##8385 |n
|tip This is a limited supply item.
|tip If he doesn't have it for sale, check the Auction House.
use the Pattern: Turtle Scale Gloves##8385
learn Turtle Scale Gloves##10509 |goto Feralas 30.63,42.71
step
talk Pratt McGrubben##7852
accept Wild Leather Armor##2847 |goto 30.63,42.71
step
talk Pratt McGrubben##7852
turnin Wild Leather Armor##2847 |goto 30.63,42.71
accept Wild Leather Shoulders##2848 |goto 30.63,42.71
accept Wild Leather Vest##2849 |goto 30.63,42.71
accept Wild Leather Helmet##2850 |goto 30.63,42.71
accept Wild Leather Boots##2851 |goto 30.63,42.71
accept Wild Leather Leggings##2852 |goto 30.63,42.71
step
talk Pratt McGrubben##7852
buy 22 Silken Thread##4291 |goto 30.63,42.71 |q 2852
buy 12 Heavy Silken Thread##8343 |goto 30.63,42.71 |q 2852
step
Open Your Leatherworking Crafting Panel:
_<Create 6 Thick Armor Kits>_
collect 6 Thick Armor Kit##8173 |q 2848/1
step
talk Pratt McGrubben##7852
turnin Wild Leather Shoulders##2848 |goto 30.63,42.71
step
use the Pattern: Wild Leather Shoulders##8403
learn Wild Leather Shoulders##10529
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Turtle Scale Breastplates>_
collect 2 Turtle Scale Breastplate##8189 |q 2849/1
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Turtle Scale Gloves>_
collect 2 Turtle Scale Gloves##8187 |q 2849/2
step
talk Pratt McGrubben##7852
turnin Wild Leather Vest##2849 |goto 30.63,42.71
step
use the Pattern: Wild Leather Vest##8404
learn Wild Leather Vest##10544
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Nightscape Tunics>_
collect 2 Nightscape Tunic##8175 |q 2850/1
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Nightscape Headbands>_
collect 2 Nightscape Headband##8176 |q 2850/2
step
talk Pratt McGrubben##7852
turnin Wild Leather Helmet##2850 |goto 30.63,42.71
step
use the Pattern: Wild Leather Helmet##8405
learn Wild Leather Helmet##10546
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Nightscape Pants>_
collect 2 Nightscape Pants##8193 |q 2851/1
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Nightscape Boots>_
collect 2 Nightscape Boots##8197 |q 2851/2
step
talk Pratt McGrubben##7852
turnin Wild Leather Boots##2851 |goto 30.63,42.71
step
use the Pattern: Wild Leather Boots##8406
learn Wild Leather Boots##10566
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Turtle Scale Helms>_
collect 2 Turtle Scale Helm##8191 |q 2852/1
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Turtle Scale Bracers>_
collect 2 Turtle Scale Bracers##8198 |q 2852/2
step
talk Pratt McGrubben##7852
turnin Wild Leather Leggings##2852 |goto 30.63,42.71
step
use the Pattern: Wild Leather Leggings##8407
learn Wild Leather Leggings##10572
step
talk Pratt McGrubben##7852
accept Master of the Wild Leather##2853 |goto 30.63,42.71
step
talk Telonis##4212
|tip Upstairs inside the building.
turnin Master of the Wild Leather##2853 |goto Darnassus 64.43,21.54
step
use the Pattern: Wild Leather Cloak##8408
learn Wild Leather Cloak##10574
step
Open Your Leatherworking Crafting Panel:
_<Create 1 Wild Leather Vest>_
collect Wild Leather Vest##8211 |q 5143 |future
step
Open Your Leatherworking Crafting Panel:
_<Create 1 Wild Leather Helmet>_
collect Wild Leather Helmet##8214 |q 5143 |future
step
talk Caryssia Moonhunter##7870
accept Tribal Leatherworking##5143 |goto Feralas 89.42,46.55
step
talk Caryssia Moonhunter##7870
turnin Tribal Leatherworking##5143 |goto 89.42,46.55
step
_Congratulations!_
|tip You have become a Tribal Leatherworker.
Learn Patterns From Caryssia Moonhunter at [Feralas 89.42,46.55]
]])
