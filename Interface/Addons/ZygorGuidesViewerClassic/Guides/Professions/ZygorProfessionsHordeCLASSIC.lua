local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("ProfessionsHCLASSIC") then return end
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
Enter the building |goto Orgrimmar 56.48,35.25 < 7 |walk
talk Whuut##11046
|tip Inside the building.
Learn Apprentice Alchemy |skillmax Alchemy,75 |goto Orgrimmar 55.79,32.90
step
collect 65 Peacebloom##2447
collect 65 Silverleaf##765
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 60
step
Enter the building |goto 56.48,35.25 < 7 |walk
talk Kor'geld##3348
|tip Inside the building.
buy 65 Empty Vial##3371 |goto 56.06,34.15
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
Enter the building |goto 56.48,35.25 < 7 |walk
talk Yelmak##3347
|tip Inside the building.
Learn Journeyman Alchemy |skillmax Alchemy,150 |goto 56.84,33.05
step
collect 65 Briarthorn##2450
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 110
step
Enter the building |goto 56.48,35.25 < 7 |walk
talk Yelmak##3347
|tip Inside the building.
learn Lesser Healing Potion##2337 |goto 56.84,33.05
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
Enter the building |goto 56.48,35.25 < 7 |walk
talk Yelmak##3347
|tip Inside the building.
learn Healing Potion##3447 |goto 56.84,33.05
step
talk Kor'geld##3348
|tip Inside the building.
buy 35 Leaded Vial##3372 |goto 56.06,34.15
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
Follow the path down |goto Undercity 52.87,77.53 < 7 |walk
talk Doctor Herbert Halsey##4611
Learn Expert Alchemy |skillmax Alchemy,225 |goto Undercity 47.78,73.32
step
collect 20 Mageroyal##785
collect 20 Stranglekelp##3820
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 155
step
talk Algernon##4610
buy 20 Empty Vial##3371 |goto 51.71,74.67
|only if skill("Alchemy") < 155
step
Follow the path down |goto 52.87,77.53 < 7 |walk
talk Doctor Herbert Halsey##4611
learn Lesser Mana Potion##3173 |goto 47.78,73.32
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
talk Algernon##4610
buy 35 Leaded Vial##3372 |goto 51.71,74.67
|only if skill("Alchemy") < 185
step
Follow the path down |goto 52.87,77.53 < 7 |walk
talk Doctor Herbert Halsey##4611
learn Greater Healing Potion##7181 |goto 47.78,73.32
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
talk Algernon##4610
buy 30 Leaded Vial##3372 |goto 51.71,74.67
|only if skill("Alchemy") < 210
step
Follow the path down |goto 52.87,77.53 < 7 |walk
talk Doctor Herbert Halsey##4611
learn Elixir of Agility##11449 |goto 47.78,73.32
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
talk Algernon##4610
buy 5 Leaded Vial##3372 |goto 51.71,74.67
|only if skill("Alchemy") < 215
step
Follow the path down |goto 52.87,77.53 < 7 |walk
talk Doctor Herbert Halsey##4611
learn Elixir of Greater Defense##11450 |goto 47.78,73.32
step
Open Your Alchemy Crafting Panel:
_<Create 5 Elixirs of Greater Defense>_
Reach Level 215 Alchemy |skill Alchemy,215
step
Reach Level 35 |ding 35
|tip You must be at least this level before you can learn the next rank of this profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Swamp of Sorrows 47.16,54.27 < 7 |walk
talk Rogvar##1386
|tip Upstairs inside the building.
Learn Artisan Alchemy |skillmax Alchemy,300 |goto Swamp of Sorrows 48.52,55.83
step
talk Rogvar##1386
|tip Upstairs inside the building.
learn Superior Healing Potion##11457 |goto 48.52,55.83
step
collect 15 Sungrass##8838
collect 15 Khadgar's Whisker##3358
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 230
step
talk Thultazor##983
|tip Inside the building.
buy 15 Crystal Vial##8925 |goto 45.78,52.83
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
talk Thultazor##983
|tip Inside the building.
buy 25 Crystal Vial##8925 |goto 45.78,52.83
|only if skill("Alchemy") < 250
step
Enter the building |goto 47.16,54.27 < 7 |walk
talk Rogvar##1386
|tip Upstairs inside the building.
learn Elixir of Detect Undead##11460 |goto 48.52,55.83
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
talk Thultazor##983
|tip Inside the building.
buy 20 Crystal Vial##8925 |goto 45.78,52.83
|only if skill("Alchemy") < 265
step
Enter the building |goto 47.16,54.27 < 7 |walk
talk Rogvar##1386
|tip Upstairs inside the building.
learn Elixir of Greater Agility##11467 |goto 48.52,55.83
step
Open Your Alchemy Crafting Panel:
_<Create 25 Elixirs of Greater Agility>_
Reach Level 265 Alchemy |skill Alchemy,265
step
Reach Level 41 |ding 41
|tip You must be at least this level before you can learn the next recipe.
|tip Use the Leveling guides to accomplish this.
step
talk Algernon##4610
buy Recipe: Superior Mana Potion##13477 |n
|tip This is a limited supply item.
|tip If he doesn't have it for sale, check the Auction House.
use the Recipe: Superior Mana Potion##13477
learn Superior Mana Potion##17553 |goto Undercity 51.71,74.67
step
collect 50 Sungrass##8838
collect 50 Blindweed##8839
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Alchemy") < 285
step
talk Algernon##4610
buy 25 Crystal Vial##8925 |goto 51.71,74.67
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
Enter the building |goto Orgrimmar 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
Learn Apprentice Blacksmithing |skillmax Blacksmithing,75 |goto Orgrimmar 82.34,22.97
step
talk Sumi##3356
|tip Inside the building.
buy Blacksmith Hammer##5956 |goto 82.59,23.95
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
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Rough Grinding Stone##3320 |goto 82.34,22.97
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
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Course Sharpening Stone##2665 |goto 82.34,22.97
step
Open Your Blacksmithing Crafting Panel:
_<Create 25 Rough Grinding Stones>_
Reach Level 75 Blacksmithing |skill Blacksmithing,75
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
Learn Journeyman Blacksmithing |skillmax Blacksmithing,150 |goto 82.34,22.97
step
collect 60 Coarse Stone##2836
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 90
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Course Grinding Stone##3326 |goto 82.34,22.97
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
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Runed Copper Belt##2666 |goto 82.34,22.97
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 10 Runed Copper Belts>_
Reach Level 100 Blacksmithing |skill Blacksmithing,100 |goto 82.34,22.97
step
collect 5 Silver Bar##2842
collect 10 Rough Grinding Stone##3470
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 105
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Silver Rod##7818 |goto 82.34,22.97
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 5 Silver Rods>_
Reach Level 105 Blacksmithing |skill Blacksmithing,105 |goto 82.34,22.97
step
collect 50 Copper Bar##2840
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 110
step
Enter the building |goto 81.62,22.79 < 7 |walk
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 5 Runed Copper Belts>_
Reach Level 110 Blacksmithing |skill Blacksmithing,110 |goto 82.34,22.97
step
collect 90 Bronze Bar##2841
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 125
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Rough Bronze Leggings##2668 |goto 82.34,22.97
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 15 Rough Bronze Leggings>_
Reach Level 125 Blacksmithing |skill Blacksmithing,125 |goto 82.34,22.97
step
collect 120 Heavy Stone##2838
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 140
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Heavy Grinding Stone##3337 |goto 82.34,22.97
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
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Patterned Bronze Bracers##2672 |goto 82.34,22.97
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 10 Patterned Bronze Bracers>_
Reach Level 150 Blacksmithing |skill Blacksmithing,150 |goto 82.34,22.97
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
Learn Expert Blacksmithing |skillmax Blacksmithing,225 |goto 82.34,22.97
step
collect 5 Gold Bar##3577
collect 10 Coarse Grinding Stone##3478
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 155
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Golden Rod##14379 |goto 82.34,22.97
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 5 Golden Rods>_
Reach Level 155 Blacksmithing |skill Blacksmithing,155 |goto 82.34,22.97
step
collect 80 Iron Bar##3575
collect 10 Heavy Grinding Stone##3486
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 165
step
Enter the building |goto 62.21,45.64 < 7 |walk
talk Tamar##3366
|tip Inside the building.
buy 10 Green Dye##2605 |goto 63.04,45.51
|only if skill("Blacksmithing") < 165
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Green Iron Leggings##3506 |goto 82.34,22.97
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 10 Green Iron Leggings>_
Reach Level 165 Blacksmithing |skill Blacksmithing,165 |goto 82.34,22.97
step
collect 150 Iron Bar##3575
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 190
step
Enter the building |goto 62.21,45.64 < 7 |walk
talk Tamar##3366
|tip Inside the building.
buy 25 Green Dye##2605 |goto 63.04,45.51
|only if skill("Blacksmithing") < 190
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Green Iron Bracers##3501 |goto 82.34,22.97
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 25 Green Iron Bracers>_
Reach Level 190 Blacksmithing |skill Blacksmithing,190 |goto 82.34,22.97
step
collect 50 Steel Bar##3859
collect 20 Heavy Grinding Stone##3486
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 200
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Golden Scale Bracers##7223 |goto 82.34,22.97
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 10 Golden Scale Bracers>_
|tip If you plan to get the Armorsmith specialization, keep 6 of these to use later.
Reach Level 200 Blacksmithing |skill Blacksmithing,200 |goto 82.34,22.97
step
collect 120 Solid Stone##7912
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Blacksmithing") < 210
step
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Solid Grinding Stone##9920 |goto 82.34,22.97
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
Enter the building |goto 81.62,22.79 < 7 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Heavy Mithril Gauntlet##9928 |goto 82.34,22.97
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 15 Heavy Mithril Gauntlets>_
Reach Level 225 Blacksmithing |skill Blacksmithing,225 |goto 82.34,22.97
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
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
Enter the building |goto Orgrimmar 53.42,36.92 < 7 |walk
talk Jhag##11066
|tip Inside the building.
Learn Apprentice Enchanting |skillmax Enchanting,75 |goto Orgrimmar 53.47,38.56
step
talk Kithas##3346
|tip Inside the building.
|tip The vendor has a limited supply of some of these items.
|tip If none are available, you can buy them from the Auction House.
buy Copper Rod##6217 |goto 53.87,38.02
buy Strange Dust##10940 |goto 53.87,38.02
buy Lesser Magic Essence##10938 |goto 53.87,38.02
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
Enter the building |goto Orgrimmar 53.42,36.92 < 7 |walk
talk Godan##3345
|tip Inside the building.
Learn Journeyman Enchanting |skillmax Enchanting,150 |goto Orgrimmar 53.90,38.66
step
talk Godan##3345
|tip Inside the building.
learn Enchant Bracer - Minor Deflect##7428 |goto 53.90,38.66
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
Enter the building |goto Orgrimmar 53.42,36.92 < 7 |walk
talk Godan##3345
|tip Inside the building.
learn Enchant Bracer - Minor Stamina##7457 |goto Orgrimmar 53.90,38.66
step
Open Your Enchanting Crafting Panel:
_<Create 15 Enchant Bracer - Minor Stamina>_
|tip Use the recipe on a pair of Bracers, either equipped or in your inventory.
|tip You may be able to use it on other players' Bracers to make some profit while increasing your skill level.
Reach Level 100 Enchanting |skill Enchanting,100
step
Enter the building |goto Orgrimmar 53.42,36.92 < 7 |walk
talk Godan##3345
|tip Inside the building.
learn Runed Silver Rod##7795 |goto Orgrimmar 53.90,38.66
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
Enter the building |goto Orgrimmar 53.42,36.92 < 7 |walk
talk Kithas##3346
|tip Inside the building.
buy 9 Simple Wood##4470 |goto Orgrimmar 53.87,38.02
|only if skill("Enchanting") < 110
step
talk Godan##3345
|tip Inside the building.
learn Greater Magic Wand##14807 |goto Orgrimmar 53.90,38.66
step
Open Your Enchanting Crafting Panel:
_<Create 9 Greater Magic Wands>_
Reach Level 101 Enchanting |skill Enchanting,110
step
talk Kulwia##12043
|tip These are limited supply items.
|tip If she doesn't have them for sale, check the Auction House.
buy Formula: Enchant Cloak - Minor Agility##11039 |goto Stonetalon Mountains 45.39,59.33
buy Formula: Enchant Bracer - Lesser Strength##11101 |goto Stonetalon Mountains 45.39,59.33
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
Follow the path |goto Stonetalon Mountains 49.13,61.03 < 20 |only if walking
Continue following the path |goto Stonetalon Mountains 51.84,58.09 < 15 |only if walking
Follow the road |goto Stonetalon Mountains 52.22,52.90 < 20 |only if walking
Follow the path up |goto Stonetalon Mountains 51.00,52.38 < 15 |only if walking
talk Hgarth##11074
Learn Expert Enchanting |skillmax Enchanting,225 |goto Stonetalon Mountains 49.18,57.18
step
talk Hgarth##11074
learn Enchant Bracer - Lesser Stamina##13501 |goto 49.18,57.18
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
Follow the path |goto Stonetalon Mountains 49.13,61.03 < 20 |only if walking
Continue following the path |goto Stonetalon Mountains 51.84,58.09 < 15 |only if walking
Follow the road |goto Stonetalon Mountains 52.22,52.90 < 20 |only if walking
Follow the path up |goto Stonetalon Mountains 51.00,52.38 < 15 |only if walking
talk Hgarth##11074
learn Runed Golden Rod##13628 |goto Stonetalon Mountains 49.18,57.18
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
Follow the path |goto Stonetalon Mountains 49.13,61.03 < 20 |only if walking
Continue following the path |goto Stonetalon Mountains 51.84,58.09 < 15 |only if walking
Follow the road |goto Stonetalon Mountains 52.22,52.90 < 20 |only if walking
Follow the path up |goto Stonetalon Mountains 51.00,52.38 < 15 |only if walking
talk Hgarth##11074
learn Enchant Bracer - Spirit##13642 |goto Stonetalon Mountains 49.18,57.18
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
Follow the path |goto Stonetalon Mountains 49.13,61.03 < 20 |only if walking
Continue following the path |goto Stonetalon Mountains 51.84,58.09 < 15 |only if walking
Follow the road |goto Stonetalon Mountains 52.22,52.90 < 20 |only if walking
Follow the path up |goto Stonetalon Mountains 51.00,52.38 < 15 |only if walking
talk Hgarth##11074
learn Enchant Bracer - Strength##13661 |goto Stonetalon Mountains 49.18,57.18
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
Follow the path |goto Stonetalon Mountains 49.13,61.03 < 20 |only if walking
Continue following the path |goto Stonetalon Mountains 51.84,58.09 < 15 |only if walking
Follow the road |goto Stonetalon Mountains 52.22,52.90 < 20 |only if walking
Follow the path up |goto Stonetalon Mountains 51.00,52.38 < 15 |only if walking
talk Hgarth##11074
learn Runed Truesilver Rod##13702 |goto Stonetalon Mountains 49.18,57.18
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
Follow the path |goto Stonetalon Mountains 49.13,61.03 < 20 |only if walking
Continue following the path |goto Stonetalon Mountains 51.84,58.09 < 15 |only if walking
Follow the road |goto Stonetalon Mountains 52.22,52.90 < 20 |only if walking
Follow the path up |goto Stonetalon Mountains 51.00,52.38 < 15 |only if walking
talk Hgarth##11074
learn Enchant Cloak - Greater Defense##13746 |goto Stonetalon Mountains 49.18,57.18
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
talk Daniel Bartlett##4561
buy Formula: Enchant Shield - Greater Stamina##16217 |goto Undercity 64.05,37.37
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
|tip You must be at least level 5 before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Thund##2857
|tip Inside the building.
Learn Apprentice Engineering |skillmax Engineering,75 |goto Orgrimmar 75.96,24.15
step
talk Sovik##3413
|tip Inside the building.
buy Blacksmith Hammer##5956 |goto 75.49,25.36
|tip You must have a Blacksmith Hammer in your bags to be able to create some Engineering recipes.
step
collect 60 Rough Stone##2835
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 30
step
Open Your Engineering Crafting Panel:
_<Create 60 Rough Blasting Powder>_
|tip Save these, they will be used in a later recipe.
Reach Level 30 Engineering |skill Engineering,30
collect 60 Rough Blasting Powder##4357 |only if skill("Engineering") < 75
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Thund##2857
|tip Inside the building.
learn Handful of Copper Bolts##3922 |goto Orgrimmar 75.96,24.15
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
|tip Save these, they will be used in a later recipe.
Reach Level 50 Engineering |skill Engineering,50 |goto Orgrimmar 79.61,22.95
collect 30 Handful of Copper Bolts##4359 |only if skill("Engineering") < 75
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Thund##2857
|tip Inside the building.
learn Arclight Spanner##7430 |goto Orgrimmar 75.96,24.15
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
Reach Level 51 Engineering |skill Engineering,51 |goto Orgrimmar 79.61,22.95
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Thund##2857
|tip Inside the building.
learn Rough Copper Bomb##3923 |goto Orgrimmar 75.96,24.15
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
Reach Level 75 Engineering |skill Engineering,75 |goto Orgrimmar 79.61,22.95
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Nogg##3412
|tip Inside the building.
Learn Journeyman Engineering |skillmax Engineering,150 |goto Orgrimmar 75.99,25.41
step
talk Nogg##3412
|tip Inside the building.
learn Coarse Blasting Powder##3929 |goto 75.99,25.41
step
collect 60 Coarse Stone##2836
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 95
step
Open Your Engineering Crafting Panel:
_<Create 60 Coarse Blasting Powder>_
|tip Save these, they will be used in a later recipe.
Reach Level 95 Engineering |skill Engineering,95
collect 60 Coarse Blasting Powder##4364 |only if skill("Engineering") < 100
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Nogg##3412
|tip Inside the building.
learn Coarse Dynamite##3931 |goto Orgrimmar 75.99,25.41
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
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Nogg##3412
|tip Inside the building.
learn Silver Contact##3973 |goto Orgrimmar 75.99,25.41
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
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Nogg##3412
|tip Inside the building.
learn Bronze Tube##3938 |goto Orgrimmar 75.99,25.41
step
collect 60 Bronze Bar##2841
|tip If you have the Mining profession, you can create these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 125
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Sovik##3413
|tip Inside the building.
buy 30 Weak Flux##2880 |goto Orgrimmar 75.49,25.36
|only if skill("Engineering") < 125
step
Leave the building |goto Orgrimmar 75.19,24.59 < 5 |walk
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
_<Create 30 Bronze Tubes>_
|tip Save 10 of these, they will be used in a later recipe.
Reach Level 125 Engineering |skill Engineering,125 |goto Orgrimmar 79.61,22.95
collect 10 Bronze Tube##4371 |goto Orgrimmar 79.61,22.95 |only if skill("Engineering") < 135
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Nogg##3412
|tip Inside the building.
learn Standard Scope##3978 |goto Orgrimmar 75.99,25.41
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
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Roxxik##11017
|tip Inside the building.
Learn Expert Engineering |skillmax Engineering,225 |goto Orgrimmar 76.17,25.17
step
talk Roxxik##11017
|tip Inside the building.
learn Heavy Blasting Powder##3945 |goto Orgrimmar 76.17,25.17
step
collect 30 Heavy Stone##2838
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 175
step
Open Your Engineering Crafting Panel:
_<Create 30 Heavy Blasting Powder>_
|tip Save these, they will be used in a later recipe.
Reach Level 140 Engineering |skill Engineering,140
collect 30 Heavy Blasting Powder##4377 |only if skill("Engineering") < 175
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Roxxik##11017
|tip Inside the building.
learn Whirring Bronze Gizmo##3942 |goto Orgrimmar 76.17,25.17
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
|tip Save these, they will be used in a later recipe.
Reach Level 150 Engineering |skill Engineering,150 |goto Orgrimmar 79.61,22.95
collect 15 Whirring Bronze Gizmo##4375 |goto Orgrimmar 79.61,22.95 |only if skill("Engineering") < 175
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Roxxik##11017
|tip Inside the building.
learn Bronze Framework##3953 |goto Orgrimmar 76.17,25.17
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
|tip Save these, they will be used in a later recipe.
Reach Level 160 Engineering |skill Engineering,160
collect 15 Bronze Framework##4382 |only if skill("Engineering") < 175
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Roxxik##11017
|tip Inside the building.
learn Explosive Sheep##3955 |goto Orgrimmar 76.17,25.17
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
Reach Level 175 Engineering |skill Engineering,175 |goto Orgrimmar 79.61,22.95
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Roxxik##11017
|tip Inside the building.
learn Gyromatic Micro-Adjustor##12590 |goto Orgrimmar 76.17,25.17
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
Reach Level 176 Engineering |skill Engineering,176 |goto Orgrimmar 79.61,22.95
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Roxxik##11017
|tip Inside the building.
learn Solid Blasting Powder##12585 |goto Orgrimmar 76.17,25.17
step
collect 120 Solid Stone##7912
|tip If you have the Mining profession, you can create these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Engineering") < 195
step
Open Your Engineering Crafting Panel:
_<Create 60 Solid Blasting Powder>_
|tip Save these, they will be used in a later recipe.
Reach Level 195 Engineering |skill Engineering,195
collect 60 Solid Blasting Powder##10505 |only if skill("Engineering") < 250
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Roxxik##11017
|tip Inside the building.
learn Mithril Tube##12589 |goto Orgrimmar 76.17,25.17
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
Reach Level 200 Engineering |skill Engineering,200 |goto Orgrimmar 79.61,22.95
step
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Roxxik##11017
|tip Inside the building.
learn Unstable Trigger##12591 |goto Orgrimmar 76.17,25.17
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
|tip Save these, they will be used in a later recipe.
Reach Level 215 Engineering |skill Engineering,215 |goto Orgrimmar 79.61,22.95
collect 20 Unstable Trigger##10560 |goto Orgrimmar 79.61,22.95 |only if skill("Engineering") < 250
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
|tip Save these, they will be used in a later recipe.
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
Enter the building |goto Orgrimmar 75.19,24.59 < 5 |walk
talk Sovik##3413
|tip Inside the building.
buy Schematic: Thorium Widget##16042 |n
|tip This is a limited supply item.
|tip If he doesn't have it for sale, check the Auction House.
use the Schematic: Thorium Widget##16042
learn Thorium Widget##19791 |goto Orgrimmar 75.49,25.36
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
Reach Level 285 Engineering |skill Engineering,285 |goto Orgrimmar 79.61,22.95
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
Reach Level 300 Engineering |skill Engineering,300 |goto Orgrimmar 79.61,22.95
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
Enter the building |goto Orgrimmar 62.22,45.65 < 5 |walk
talk Kamari##5811
|tip Inside the building.
Learn Apprentice Leatherworking |skillmax Leatherworking,75 |goto Orgrimmar 63.28,44.75
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
Enter the building |goto Orgrimmar 62.22,45.65 < 5 |walk
talk Tamar##3366
|tip Inside the building.
buy 20 Coarse Thread##2320 |goto Orgrimmar 63.05,45.53
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
Enter the building |goto Orgrimmar 62.22,45.65 < 5 |walk
talk Karolek##3365
|tip Inside the building.
Learn Journeyman Leatherworking |skillmax Leatherworking,150 |goto Orgrimmar 62.81,44.15
step
talk Kamari##5811
|tip Inside the building.
learn Embossed Leather Gloves##3756 |goto 63.28,44.75
step
collect 180 Light Leather##2318
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 100
step
Enter the building |goto Orgrimmar 62.22,45.65 < 5 |walk
talk Tamar##3366
|tip Inside the building.
buy 120 Coarse Thread##2320 |goto Orgrimmar 63.05,45.53
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
Enter the building |goto Orgrimmar 62.22,45.65 < 5 |walk
talk Tamar##3366
|tip Inside the building.
buy 70 Coarse Thread##2320 |goto Orgrimmar 63.05,45.53
|only if skill("Leatherworking") < 125
step
talk Karolek##3365
|tip Inside the building.
learn Fine Leather Belt##3763 |goto 62.81,44.15
step
Open Your Leatherworking Crafting Panel:
_<Create 35 Fine Leather Belts>_
Reach Level 125 Leatherworking |skill Leatherworking,125
step
talk Karolek##3365
|tip Inside the building.
learn Dark Leather Boots##2167 |goto 62.81,44.15
step
collect 80 Medium Leather##2319
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 137
step
Enter the building |goto Orgrimmar 62.22,45.65 < 5 |walk
talk Tamar##3366
|tip Inside the building.
buy 40 Fine Thread##2321 |goto Orgrimmar 63.05,45.53
buy 20 Gray Dye##4340 |goto Orgrimmar 63.05,45.53
|only if skill("Leatherworking") < 137
step
Open Your Leatherworking Crafting Panel:
_<Create 20 Dark Leather Boots>_
Reach Level 137 Leatherworking |skill Leatherworking,137
step
talk Karolek##3365
|tip Inside the building.
learn Dark Leather Pants##7135 |goto 62.81,44.15
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Thunder Bluff 43.76,42.44 < 5 |walk
talk Una##3007
|tip Inside the building.
Learn Expert Leatherworking |skillmax Leatherworking,225 |goto Thunder Bluff 41.51,42.57
step
collect 240 Medium Leather##2319
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 150
step
Enter the building |goto Thunder Bluff 43.76,42.44 < 5 |walk
talk Mahu##3005
|tip Inside the building.
buy 20 Fine Thread##2321 |goto Thunder Bluff 43.81,45.10
buy 20 Gray Dye##4340 |goto Thunder Bluff 43.81,45.10
|only if skill("Leatherworking") < 150
step
Open Your Leatherworking Crafting Panel:
_<Create 20 Dark Leather Pants>_
Reach Level 150 Leatherworking |skill Leatherworking,150
step
talk Una##3007
|tip Inside the building.
learn Heavy Leather##20649 |goto 41.51,42.57
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
Enter the building |goto Thunder Bluff 43.76,42.44 < 5 |walk
talk Mahu##3005
|tip Inside the building.
buy 60 Salt##4289 |goto Thunder Bluff 43.81,45.10
|only if skill("Leatherworking") < 200
step
talk Una##3007
|tip Inside the building.
learn Cured Heavy Hide##3818 |goto 41.51,42.57
step
Open Your Leatherworking Crafting Panel:
_<Create 20 Cured Heavy Hides>_
|tip Save these, they will be used in a later recipe.
Reach Level 165 Leatherworking |skill Leatherworking,165
collect 20 Cured Heavy Hide##4236 |only if skill("Leatherworking") < 200
step
talk Una##3007
|tip Inside the building.
learn Heavy Armor Kit##3780 |goto 41.51,42.57
step
collect 125 Heavy Leather##4234
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 180
step
Enter the building |goto Thunder Bluff 43.76,42.44 < 5 |walk
talk Mahu##3005
|tip Inside the building.
buy 25 Fine Thread##2321 |goto Thunder Bluff 43.81,45.10
|only if skill("Leatherworking") < 180
step
Open Your Leatherworking Crafting Panel:
_<Create 25 Heavy Armor Kit>_
Reach Level 180 Leatherworking |skill Leatherworking,180
step
talk Una##3007
|tip Inside the building.
learn Barbaric Shoulders##7151 |goto 41.51,42.57
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
Enter the building |goto Thunder Bluff 43.76,42.44 < 5 |walk
talk Mahu##3005
|tip Inside the building.
buy 20 Fine Thread##2321 |goto Thunder Bluff 43.81,45.10
|only if skill("Leatherworking") < 190
step
Open Your Leatherworking Crafting Panel:
_<Create 10 Barbaric Shoulders>_
Reach Level 190 Leatherworking |skill Leatherworking,190
step
talk Una##3007
|tip Inside the building.
learn Guardian Gloves##7156 |goto 41.51,42.57
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
Enter the building |goto Thunder Bluff 43.76,42.44 < 5 |walk
talk Mahu##3005
|tip Inside the building.
buy 10 Silken Thread##4291 |goto Thunder Bluff 43.81,45.10
|only if skill("Leatherworking") < 200
step
Open Your Leatherworking Crafting Panel:
_<Create 10 Guardian Gloves>_
Reach Level 200 Leatherworking |skill Leatherworking,200
step
talk Una##3007
|tip Inside the building.
learn Thick Armor Kit##10487 |goto 41.51,42.57
step
talk Mahu##3005
|tip Inside the building.
buy 5 Silken Thread##4291 |goto 43.81,45.10
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
Enter the building |goto Feralas 74.68,42.99 < 5 |walk
talk Hahrana Ironhide##11098
|tip Inside the building.
Learn Artisan Leatherworking |skillmax Leatherworking,300 |goto Feralas 74.36,43.12
step
talk Hahrana Ironhide##11098
|tip Inside the building.
learn Nightscape Headband##10507 |goto 74.36,43.12
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
buy 80 Silken Thread##4291 |goto 74.43,42.91
|only if skill("Leatherworking") < 235
step
Open Your Leatherworking Crafting Panel:
_<Create 40 Nightscape Headbands>_
Reach Level 235 Leatherworking |skill Leatherworking,235
step
talk Hahrana Ironhide##11098
|tip Inside the building.
learn Nightscape Pants##10548 |goto 74.36,43.12
step
collect 210 Thick Leather##4304
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Leatherworking") < 250
step
Enter the building |goto Feralas 74.68,42.99 < 5 |walk
talk Jangdor Swiftstrider##7854
|tip Inside the building.
buy 60 Silken Thread##4291 |goto Feralas 74.43,42.91
|only if skill("Leatherworking") < 250
step
Open Your Leatherworking Crafting Panel:
_<Create 15 Nightscape Pants>_
Reach Level 250 Leatherworking |skill Leatherworking,250
step
talk Hahrana Ironhide##11098
|tip Inside the building.
learn Rugged Armor Kit##19058 |goto 74.36,43.12
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
Enter the building |goto Feralas 74.68,42.99 < 5 |walk
talk Jangdor Swiftstrider##7854
|tip Inside the building.
buy 30 Black Dye##2325 |goto Feralas 74.43,42.91
buy 30 Rune Thread##14341 |goto Feralas 74.43,42.91
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
Enter the building |goto Feralas 74.68,42.99 < 5 |walk
talk Jangdor Swiftstrider##7854
|tip Inside the building.
buy 10 Black Dye##2325 |goto Feralas 74.43,42.91
buy 10 Rune Thread##14341 |goto Feralas 74.43,42.91
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
Enter the building |goto Orgrimmar 61.38,50.37 < 7 |walk
talk Snang##2855
|tip Inside the building.
Learn Apprentice Tailor |skillmax Tailoring,75 |goto Orgrimmar 62.93,49.24
step
collect 204 Linen Cloth##2589
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Tailoring") < 50
step
Open Your Tailoring Crafting Panel:
_<Create 102 Bolts of Linen Cloth>_
|tip Save these, they will be used in a later pattern.
Reach Level 45 Tailoring |skill Tailoring,45
collect 102 Bolt of Linen Cloth##2996 |only if skill("Tailoring") < 110
step
Enter the building |goto Orgrimmar 61.38,50.37 < 7 |walk
talk Snang##2855
|tip Inside the building.
learn Linen Belt##8776 |goto Orgrimmar 62.93,49.24
step
talk Borya##3364
|tip Inside the building.
buy 40 Coarse Thread##2320 |goto 63.08,51.44
|only if skill("Tailoring") < 70
step
Open Your Tailoring Crafting Panel:
_<Create 40 Linen Belts>_
Reach Level 70 Tailoring |skill Tailoring,70
step
talk Snang##2855
|tip Inside the building.
learn Reinforced Linen Cape##2397 |goto 62.93,49.24
step
talk Borya##3364
|tip Inside the building.
buy 15 Coarse Thread##2320 |goto 63.08,51.44
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
Enter the building |goto Orgrimmar 61.38,50.37 < 7 |walk
talk Magar##3363
|tip Inside the building.
Learn Journeyman Tailoring |skillmax Tailoring,150 |goto Orgrimmar 63.65,49.93
step
talk Magar##3363
|tip Inside the building.
learn Bolt of Woolen Cloth##2964 |goto 63.65,49.93
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
Enter the building |goto Orgrimmar 61.38,50.37 < 7 |walk
talk Magar##3363
|tip Inside the building.
learn Simple Kilt##12046 |goto Orgrimmar 63.65,49.93
step
talk Borya##3364
|tip Inside the building.
buy 13 Fine Thread##2321 |goto 63.08,51.44
|only if skill("Tailoring") < 110
step
Open Your Tailoring Crafting Panel:
_<Create 13 Simple Kilts>_
Reach Level 110 Tailoring |skill Tailoring,110
step
talk Magar##3363
|tip Inside the building.
learn Double-stitched Woolen Shoulders##3848 |goto 63.65,49.93
step
talk Borya##3364
|tip Inside the building.
buy 30 Fine Thread##2321 |goto 63.08,51.44
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
talk Josef Gregorian##4576
Learn Expert Tailoring |skillmax Tailoring,225 |goto Undercity 70.76,30.69
step
talk Josef Gregorian##4576
learn Bolt of Silk Cloth##3839 |goto 70.76,30.69
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
talk Josef Gregorian##4576
learn Azure Silk Hood##8760 |goto Undercity 70.76,30.69
step
talk Millie Gregorian##4577
|tip Inside the building.
buy 18 Fine Thread##2321 |goto 70.59,30.15
buy 36 Blue Dye##6260 |goto 70.59,30.15
|only if skill("Tailoring") < 160
step
Open Your Tailoring Crafting Panel:
_<Create 18 Azure Silk Hoods>_
Reach Level 160 Tailoring |skill Tailoring,160
step
talk Josef Gregorian##4576
learn Silk Headband##8762 |goto 70.76,30.69
step
talk Millie Gregorian##4577
buy 20 Fine Thread##2321 |goto 70.59,30.15
|only if skill("Tailoring") < 170
step
Open Your Tailoring Crafting Panel:
_<Create 10 Silk Headbands>_
Reach Level 170 Tailoring |skill Tailoring,170
step
talk Josef Gregorian##4576
learn Formal White Shirt##3871 |goto 70.76,30.69
step
talk Millie Gregorian##4577
buy 10 Bleach##2324 |goto 70.59,30.15
buy 5 Fine Thread##2321 |goto 70.59,30.15
|only if skill("Tailoring") < 175
step
Open Your Tailoring Crafting Panel:
_<Create 5 Formal White Shirts>_
Reach Level 175 Tailoring |skill Tailoring,175
step
talk Josef Gregorian##4576
learn Bolt of Mageweave##3865 |goto 70.76,30.69
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
talk Josef Gregorian##4576
learn Crimson Silk Vest##8791 |goto Undercity 70.76,30.69
step
talk Millie Gregorian##4577
buy 30 Fine Thread##2321 |goto 70.59,30.15
buy 30 Red Dye##2604 |goto 70.59,30.15
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
Enter the building |goto Hillsbrad Foothills 62.90,20.55 < 5 |walk
talk Daryl Stack##2399
|tip Inside the building.
Learn Artisan Tailoring |skillmax Tailoring,300 |goto Hillsbrad Foothills 63.75,20.78
step
talk Daryl Stack##2399
|tip Inside the building.
learn Crimson Silk Pantaloons##8799 |goto 63.75,20.78
step
Leave the building |goto 62.90,20.55 < 5 |walk
talk Mallen Swain##2394
|tip He walks around this area.
buy 30 Red Dye##2604 |goto 61.90,20.98
buy 30 Silken Thread##4291 |goto 61.90,20.98
|only if skill("Tailoring") < 215
step
Open Your Tailoring Crafting Panel:
_<Create 15 Crimson Silk Pantaloons>_
Reach Level 215 Tailoring |skill Tailoring,215
step
Enter the building |goto 62.90,20.55 < 5 |walk
talk Daryl Stack##2399
|tip Inside the building.
learn Orange Mageweave Shirt##12061 |goto 63.75,20.78
step
Leave the building |goto 62.90,20.55 < 5 |walk
talk Mallen Swain##2394
|tip He walks around this area.
buy 5 Orange Dye##6261 |goto 61.90,20.98
buy 5 Heavy Silken Thread##8343 |goto 61.90,20.98
|only if skill("Tailoring") < 220
step
Open Your Tailoring Crafting Panel:
_<Create 5 Orange Mageweave Shirts>_
Reach Level 220 Tailoring |skill Tailoring,220
step
Enter the building |goto 62.90,20.55 < 5 |walk
talk Daryl Stack##2399
|tip Inside the building.
learn Black Mageweave Gloves##12053 |goto 63.75,20.78
step
Leave the building |goto 62.90,20.55 < 5 |walk
talk Mallen Swain##2394
|tip He walks around this area.
buy 20 Heavy Silken Thread##8343 |goto 61.90,20.98
|only if skill("Tailoring") < 230
step
Open Your Tailoring Crafting Panel:
_<Create 10 Black Mageweave Gloves>_
Reach Level 230 Tailoring |skill Tailoring,230
step
Enter the building |goto 62.90,20.55 < 5 |walk
talk Daryl Stack##2399
|tip Inside the building.
learn Black Mageweave Headband##12072 |goto 63.75,20.78
step
Leave the building |goto 62.90,20.55 < 5 |walk
talk Mallen Swain##2394
|tip He walks around this area.
buy 50 Heavy Silken Thread##8343 |goto 61.90,20.98
|only if skill("Tailoring") < 250
step
Open Your Tailoring Crafting Panel:
_<Create 25 Black Mageweave Headbands>_
Reach Level 250 Tailoring |skill Tailoring,250
step
Enter the building |goto 62.90,20.55 < 5 |walk
talk Daryl Stack##2399
|tip Inside the building.
learn Bolt of Runecloth##18401 |goto 63.75,20.78
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
Enter the building |goto 62.90,20.55 < 5 |walk
talk Daryl Stack##2399
|tip Inside the building.
learn Runecloth Belt##18402 |goto 63.75,20.78
step
Leave the building |goto 62.90,20.55 < 5 |walk
talk Mallen Swain##2394
|tip He walks around this area.
buy 25 Rune Thread##14341 |goto 61.90,20.98
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
|tip You must be at least level 5 before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Orgrimmar 56.43,56.78 < 7 |only if walking
Enter the building |goto Orgrimmar 54.75,40.57 < 7 |walk
talk Jandi##3404
|tip Inside the building.
Learn Apprentice Herbalist |skillmax Herbalism,75 |goto Orgrimmar 55.62,39.46
step
map Durotar
path	follow smart;	loop on;	ants curved;	dist 30
path	53.29,45.77	55.68,46.14	56.16,50.10	55.24,54.58	55.03,60.41
path	54.89,63.15	54.79,65.91	54.21,71.92	54.98,76.20	52.08,77.83
path	50.18,74.99	49.93,69.47	51.36,67.29	51.81,64.25	51.58,58.68
path	51.88,55.18	50.35,51.24	50.49,48.42
Reach Level 75 Herbalism |skill Herbalism,75
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Orgrimmar 56.43,56.78 < 7 |only if walking
Enter the building |goto Orgrimmar 54.75,40.57 < 7 |walk
talk Jandi##3404
|tip Inside the building.
Learn Journeyman Herbalist |skillmax Herbalism,150 |goto Orgrimmar 55.62,39.46
step
map The Barrens
path	follow smart;	loop on;	ants curved;	dist 30
path	59.10,40.30	60.19,40.99	61.84,40.54	62.14,43.04	62.65,46.75
path	61.30,50.02	60.46,50.11	58.76,50.43	56.82,51.16	55.42,52.22
path	53.50,52.61	53.16,56.18	51.94,57.54	50.38,58.57	43.15,60.77
path	43.09,56.64	43.61,52.80	41.37,48.89	42.58,47.61	41.37,44.96
path	43.42,44.79	43.15,42.53	43.28,39.61	42.28,38.89	41.58,37.21
path	42.55,35.50	42.04,33.21	40.69,29.92	40.86,26.76	40.85,25.65
path	41.14,22.86	40.75,20.98	43.41,19.48	45.37,20.92	46.02,22.67
path	47.72,24.15	50.85,22.99	53.51,23.60	58.76,25.08	60.04,27.81
path	60.07,30.45	59.29,36.79	58.73,39.32
Reach Level 100 Herbalism |skill Herbalism,100
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
step
map The Barrens
path	follow smart;	loop on;	ants curved;	dist 30
path	49.34,61.86	47.74,65.34	49.23,69.53	48.13,71.47	48.25,74.69
path	49.98,75.97	49.97,78.84	48.59,80.24	48.26,82.33	46.66,83.76
path	46.10,86.08	44.27,84.64	42.70,82.63	41.20,79.51	44.09,78.36
path	43.80,75.03	43.88,73.08	42.35,72.24	41.90,68.97	43.39,69.35
path	45.54,68.99	45.03,65.70	43.83,62.98
Reach Level 125 Herbalism |skill Herbalism,125
|tip Click herbs as you follow the path around this area.
|tip Track them on your minimap with "Find Herbs".
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Orgrimmar 56.43,56.78 < 7 |only if walking
Enter the building |goto Orgrimmar 54.75,40.57 < 7 |walk
talk Jandi##3404
|tip Inside the building.
Learn Expert Herbalist |skillmax Herbalism,225 |goto Orgrimmar 55.62,39.46
step
map Wetlands
path	follow smart;	loop on;	ants curved;	dist 30
path	13.6,37.2	15.1,33.5	18.5,32.8	19.2,26.5	21.8,27.2
path	24.6,28.8	28.2,30.5	32.9,27.9	35.5,24.6	38.6,23.2
path	41.1,24.4	46.5,25.4	51.5,29.0	56.5,30.5	59.3,32.9
path	62.7,34.1	61.8,39.2	58.3,44.0	56.4,48.5	44.7,34.5
path	41.0,34.0	35.2,31.8	31.5,36.3	26.9,34.9	18.3,36.6
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
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Orgrimmar 56.43,56.78 < 7 |only if walking
Enter the building |goto Orgrimmar 54.75,40.57 < 7 |walk
talk Jandi##3404
|tip Inside the building.
Learn Artisan Herbalist |skillmax Herbalism,300 |goto Orgrimmar 55.62,39.46
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
|tip You must be at least level 5 before you can learn professions.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Orgrimmar 72.94,27.48 < 7 |walk
talk Makaru##3357
|tip Inside the building.
Learn Apprentice Miner |skillmax Mining,75 |goto Orgrimmar 73.12,26.08
step
talk Gorina##3358
|tip Inside the building.
buy Mining Pick##2901 |goto 73.31,26.60
|tip You must have a Mining Pick in your bags to be able to gather ore.
step
map Durotar
path	follow smart;	loop on;	ants curved;	dist 30
path	50.96,17.00	52.99,18.09	54.60,19.05	55.40,21.06	55.71,23.38
path	56.28,25.33	55.89,27.78	54.64,27.62	55.10,30.09	58.12,29.94
path	55.62,32.75	55.97,36.63	55.71,40.53	57.32,42.00	59.26,41.50
path	57.59,43.98	55.27,48.14	50.81,48.20	48.51,43.33	47.83,39.78
path	46.87,34.69	45.55,32.24	45.61,27.19	46.52,23.35	48.07,21.59
path	49.70,21.37	49.54,18.59
Reach Level 65 Mining |skill Mining,65
|tip Click ore as you follow the path around this area.
|tip Track them on your minimap with "Find Minerals".
|tip You can smelt Copper Ore from skill level 1-47 for additional points.
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Orgrimmar 72.94,27.48 < 7 |walk
talk Makaru##3357
|tip Inside the building.
Learn Journeyman Miner |skillmax Mining,150 |goto Orgrimmar 73.12,26.08
step
map The Barrens
path	follow smart;	loop on;	ants curved;	dist 30
path	59.10,40.30	60.19,40.99	61.84,40.54	62.14,43.04	62.65,46.75
path	61.30,50.02	60.46,50.11	58.76,50.43	56.82,51.16	55.42,52.22
path	53.50,52.61	53.16,56.18	51.94,57.54	50.38,58.57	49.34,61.86
path	47.74,65.34	49.23,69.53	48.13,71.47	48.25,74.69	49.98,75.97
path	49.97,78.84	48.59,80.24	48.26,82.33	46.66,83.76	46.10,86.08
path	44.27,84.64	42.70,82.63	41.20,79.51	44.09,78.36	43.80,75.03
path	43.88,73.08	42.35,72.24	41.90,68.97	43.39,69.35	45.54,68.99
path	45.03,65.70	43.83,62.98	43.15,60.77	43.09,56.64	43.61,52.80
path	41.37,48.89	42.58,47.61	41.37,44.96	43.42,44.79	43.15,42.53
path	43.28,39.61	42.28,38.89	41.58,37.21	42.55,35.50	42.04,33.21
path	45.13,32.85	46.58,30.52	46.71,28.37	48.20,28.72	49.48,31.40
path	50.44,34.37	52.43,34.60	56.90,37.50	58.56,39.33
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
Enter the building |goto Orgrimmar 72.94,27.48 < 7 |walk
talk Makaru##3357
|tip Inside the building.
Learn Expert Miner |skillmax Mining,225 |goto Orgrimmar 73.12,26.08
step
map Arathi Highlands
path	follow smart;	loop on;	ants curved;	dist 30
path	78.66,36.13	77.36,41.29	75.00,44.93	72.65,48.07	70.58,55.05
path	69.99,58.40	72.92,59.03	72.28,63.63	72.78,66.86	71.75,66.15
path	69.15,72.54	67.17,70.90	63.52,73.55	59.48,74.71	59.32,70.74
path	56.16,71.89	50.82,78.41	47.96,82.44	42.53,80.75	43.02,77.16
path	40.39,71.86	37.95,67.63	38.52,68.50	33.94,66.02	34.59,61.64
path	33.70,56.77	33.45,53.94	33.65,50.19	35.00,47.28	32.96,46.68
path	31.68,45.41	32.34,42.64	31.42,41.24	25.23,43.10	20.94,39.12
path	20.02,35.80	19.12,33.36	22.43,31.28	23.48,24.90	26.93,20.65
path	28.65,14.18	28.96,16.96	31.62,18.63	30.96,20.36	33.19,21.23
path	36.35,24.61	39.97,25.62	40.21,28.79	43.97,30.51	45.70,33.02
path	48.08,33.60	49.78,36.76	52.14,36.11	52.75,31.99	54.80,33.13
path	58.19,32.50	58.02,34.22	59.94,35.97	62.25,32.06	64.69,35.58
path	64.49,26.56	66.77,27.64	70.39,27.07	70.47,30.74	72.89,30.09
path	76.73,29.48	76.70,33.68	79.56,35.45
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
Enter the building |goto Orgrimmar 72.94,27.48 < 7 |walk
talk Makaru##3357
|tip Inside the building.
Learn Artisan Miner |skillmax Mining,300 |goto Orgrimmar 73.12,26.08
step
map Badlands
path	follow smart;	loop on;	ants curved;	dist 30
path	26.84,74.76	25.28,78.53	19.71,81.32	14.75,83.82	12.50,85.54
path	7.98,80.56	6.30,74.40	8.68,67.97	17.19,68.54	15.13,72.43
path	17.19,77.39	21.25,75.06	25.11,72.08
Reach Level 250 Mining |skill Mining,250
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
Enter the building |goto Orgrimmar 62.23,45.64 < 7 |walk
talk Thuwd##7088
|tip Inside the building.
Learn Apprentice Skinning |skillmax Skinning,75 |goto Orgrimmar 63.36,45.41
step
talk Tamar##3366
|tip Inside the building.
buy Skinning Knife##7005 |goto 63.04,45.53
|tip You must have a Skinning Knife in your bags to be able to skin enemies.
step
Kill enemies around this area
|tip Only beast enemies, or certain humanoid enemies such as yetis or worgen, will be skinnable.
|tip Skin their corpses.
Reach Level 75 Skinning |skill Skinning,75 |goto Durotar 44.13,18.79
You can find more around: |notinsticky
[Durotar 39.38,18.92]
[Durotar 36.57,24.98]
[Durotar 38.33,35.20]
[Durotar 53.64,14.77]
step
Reach Level 10 |ding 10
|tip You must be at least level 10 to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Orgrimmar 62.23,45.64 < 7 |walk
talk Thuwd##7088
|tip Inside the building.
Learn Journeyman Skinning |skillmax Skinning,150 |goto Orgrimmar 63.36,45.41
step
Kill enemies around this area
|tip Only beast enemies will be skinnable.
|tip Skin their corpses.
Reach Level 90 Skinning |skill Skinning,90 |goto The Barrens 53.93,30.27
You can find more around: |notinsticky
[The Barrens 53.44,33.96]
[The Barrens 50.98,33.32]
[The Barrens 49.67,29.89]
step
Kill enemies around this area
|tip Skin their corpses.
Reach Level 130 Skinning |skill Skinning,130 |goto 45.77,56.23
You can find more around: |notinsticky
[46.67,50.16]
[49.90,53.28]
[48.92,58.67]
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
talk Dranh##6387
Learn Expert Skinning |skillmax Skinning,225 |goto 45.07,59.09
step
Kill enemies around this area
|tip Skin their corpses.
Reach Level 165 Skinning |skill Skinning,165 |goto 44.89,75.35
You can find more around: |notinsticky
[48.02,75.51]
[49.18,79.05]
[47.17,78.38]
[47.02,81.85]
step
Kill enemies around this area
|tip All around in the Shimmering Flats.
|tip Skin their corpses.
Reach Level 220 Skinning |skill Skinning,220 |goto Thousand Needles 78.97,69.34
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Feralas 74.69,42.99 < 7 |walk
talk Kulleg Stonehorn##8144
|tip Inside the building.
Learn Artisan Skinning |skillmax Skinning,300 |goto Feralas 74.47,43.04
step
Kill Feral Scar enemies around this area
|tip They look like yetis.
|tip Skin their corpses.
|tip You can find more through the tunnel.
Reach Level 270 Skinning |skill Skinning,270 |goto 55.24,56.36
step
Kill enemies around this area
|tip Skin their corpses.
Reach Level 300 Skinning |skill Skinning,300 |goto 48.69,37.24
You can find more around: |notinsticky
[49.97,33.40]
[49.69,28.62]
[46.69,24.68]
[44.94,22.35]
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
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
talk Zamja##3399
|tip Inside the building.
Learn Apprentice Cooking |skillmax Cooking,75 |goto Orgrimmar 57.40,53.96
step
collect 55 Chunk of Boar Meat##769
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Cooking") < 50
step
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
Open Your Cooking Crafting Panel:
|tip Stand next to the Mighty Blaze.
|tip Inside the building.
_<Create 55 Roasted Boar Meat>_
Reach Level 50 Cooking |skill Cooking,50 |goto Orgrimmar 57.20,53.32
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
talk Zamja##3399
|tip Inside the building.
Learn Journeyman Cooking |skillmax Cooking,150 |goto Orgrimmar 57.40,53.96
step
Run down the stairs |goto Silverpine Forest 43.09,41.39 < 5 |walk
talk Andrew Hilbert##3556
|tip Downstairs inside the crypt.
buy Recipe: Smoked Bear Meat##6892 |n
use the Recipe: Smoked Bear Meat##6892
learn Smoked Bear Meat##8607 |goto Silverpine Forest 43.22,40.66
step
collect 30 Bear Meat##3173
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Cooking") < 80
step
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
Open Your Cooking Crafting Panel:
|tip Stand next to the Mighty Blaze.
|tip Inside the building.
_<Create 30 Smoked Bear Meat>_
Reach Level 80 Cooking |skill Cooking,80 |goto Orgrimmar 57.20,53.32
step
talk Zamja##3399
|tip Inside the building.
learn Boiled Clams##6499 |goto 57.40,53.96
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 40 Clam Meat##5503
|only if skill("Cooking") < 110
step
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
talk Xen'to##3400
|tip Inside the building.
buy 40 Refreshing Spring Water##159 |goto Orgrimmar 57.57,52.90
|only if skill("Cooking") < 110
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Mighty Blaze.
|tip Inside the building.
_<Create 40 Boiled Clams>_
Reach Level 110 Cooking |skill Cooking,110 |goto Orgrimmar 57.20,53.32
step
talk Zamja##3399
|tip Inside the building.
learn Crab Cake##2544 |goto 57.40,53.96
step
_Collect These Items:_
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 30 Crawler Meat##2674
|only if skill("Cooking") < 130
step
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
talk Xen'to##3400
|tip Inside the building.
buy 30 Mild Spice##2678 |goto Orgrimmar 57.57,52.90
|only if skill("Cooking") < 130
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Mighty Blaze.
|tip Inside the building.
_<Create 30 Crab Cakes>_
Reach Level 130 Cooking |skill Cooking,130 |goto 57.20,53.32
step
Reach Level 20 |ding 20
|tip You must be at least this level to become an Expert in a profession.
|tip Use the Leveling guides to accomplish this.
step
talk Wulan##12033
|tip Upstairs inside the building.
buy Expert Cookbook##16072 |n
use the Expert Cookbook##16072
Learn Expert Cook |skillmax Cooking,225 |goto Desolace 26.17,69.65
step
talk Nerrist##1148
buy Recipe: Curiously Tasty Omelet##3682 |n
use the Recipe: Curiously Tasty Omelet##3682
learn Curiously Tasty Omelet##3376 |goto Stranglethorn Vale 32.70,29.23
step
collect 50 Raptor Egg##3685
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Cooking") < 175
step
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
talk Xen'to##3400
|tip Inside the building.
buy 50 Hot Spices##2692 |goto Orgrimmar 57.57,52.90
|only if skill("Cooking") < 175
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Mighty Blaze.
|tip Inside the building.
_<Create 50 Curiously Tasty Omelets>_
Reach Level 175 Cooking |skill Cooking,175 |goto 57.20,53.32
step
talk Nerrist##1148
buy Recipe: Roast Raptor##12228 |n
use the Recipe: Roast Raptor##12228
learn Roast Raptor##15855 |goto Stranglethorn Vale 32.70,29.23
step
collect 60 Raptor Flesh##12184
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
|only if skill("Cooking") < 225
step
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
talk Xen'to##3400
|tip Inside the building.
buy 60 Hot Spices##2692 |goto Orgrimmar 57.57,52.90
|only if skill("Cooking") < 225
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Mighty Blaze.
|tip Inside the building.
_<Create 60 Roast Raptors>_
Reach Level 225 Cooking |skill Cooking,225 |goto 57.20,53.32
step
Reach Level 35 |ding 35
|tip You must be at least this level to become an Artisan in a profession.
|tip Use the Leveling guides to accomplish this.
step
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
talk Zamja##3399
|tip Inside the building.
accept To Gadgetzan You Go!##6611 |goto Orgrimmar 57.40,53.96
step
Enter the building |goto Tanaris 52.38,27.91 < 5 |walk
talk Dirge Quikcleave##8125
|tip Inside the building.
turnin To Gadgetzan You Go!##6611 |goto Tanaris 52.63,28.11
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
Enter the building |goto Thousand Needles 45.94,51.07 < 7 |walk
talk Innkeeper Abeqwa##11116
|tip Inside the building.
buy 20 Alterac Swiss##8932 |q 6610/3 |goto Thousand Needles 46.07,51.52
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
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
Open Your Cooking Crafting Panel:
|tip Stand next to the Mighty Blaze.
|tip Inside the building.
_<Create 60 Monster Omelets>_
Reach Level 275 Cooking |skill Cooking,275 |goto Orgrimmar 57.20,53.32
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
Run up the stairs |goto Orgrimmar 56.34,56.91 < 7 |only if walking
Enter the building |goto Orgrimmar 58.14,53.56 < 7 |walk
Open Your Cooking Crafting Panel:
|tip Stand next to the Mighty Blaze.
|tip Inside the building.
_<Create 35 Poached Sunscale Salmon>_
Reach Level 300 Cooking |skill Cooking,300 |goto Orgrimmar 57.20,53.32
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
talk Harn Longcast##5940
buy Fishing Pole##6256 |goto Mulgore 47.51,55.06
|tip You need to be able to equip a fishing pole in order to fish.
|only if skill("Fishing") < 300
step
talk Harn Longcast##5940
buy 10 Shiny Bauble##6529 |goto 47.51,55.06
|only if skill("Fishing") < 75
step
talk Uthan Stillwater##5938
Learn Apprentice Fishing |skillmax Fishing,75 |goto 44.51,60.66
step
Fish in the Water
|tip Use the "Fishing" skill in your spell book.
|tip Equip the Fishing Pole in your bags.
|tip Save the fish you catch, to cook later.
use the Shiny Bauble##6529+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 75 Fishing |skill Fishing,75 |goto 44.49,61.24
step
talk Uthan Stillwater##5938
Learn Journeyman Fishing |skillmax Fishing,150 |goto 44.51,60.66
step
Enter the building |goto Mulgore 46.32,58.69 < 7 |walk
talk Pyall Silentstride##3067
|tip Inside the building.
Learn Apprentice Cooking |skillmax Cooking,75 |goto Mulgore 45.41,58.11
step
Leave the building |goto 46.32,58.69 < 7 |walk
talk Harn Longcast##5940
buy Recipe: Brilliant Smallfish##6325 |n
use the Recipe: Brilliant Smallfish##6325
learn Brilliant Smallfish##7751 |goto 47.51,55.06
step
talk Harn Longcast##5940
buy Recipe: Longjaw Mud Snapper##6328 |goto 47.51,55.06
|tip Save this for later.
step
Fish in the Water
use the Shiny Bauble##6529+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 130 Fishing |skill Fishing,130 |goto Thunder Bluff 41.47,57.15
collect 55 Raw Brilliant Smallfish##6291 |goto Thunder Bluff 41.47,57.15 |only if skill("Cooking") < 50
collect 60 Raw Longjaw Mud Snapper##6289 |goto Thunder Bluff 41.47,57.15 |only if skill("Cooking") < 100
step
talk Naal Mistrunner##3027
buy Recipe: Bristle Whisker Catfish##6330 |goto 50.99,52.45
|tip Save this for later.
|only if skill("Cooking") < 175
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Boiling Cauldron.
_<Create 55 Brilliant Smallfish>_
Reach Level 50 Cooking |skill Cooking,50 |goto 51.39,53.25
step
use the Recipe: Longjaw Mud Snapper##6328
|tip You should have this from earlier in the guide.
learn Longjaw Mud Snapper##7753
step
Reach Level 10 |ding 10
|tip You must be at least this level to become a Journeyman in a profession.
|tip Use the Leveling guides to accomplish this.
step
talk Aska Mistrunner##3026
Learn Journeyman Cooking |skillmax Cooking,150 |goto 50.72,53.11
step
Open Your Cooking Crafting Panel:
|tip Stand next to the Boiling Cauldron.
_<Create 60 Longjaw Mud Snappers>_
Reach Level 100 Cooking |skill Cooking,100 |goto 51.39,53.25
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
Enter the building |goto Stonetalon Mountains 46.47,59.31 < 7 |only if walking
talk Grawnal##4082
|tip Inside the building.
buy Flint and Tinder##4471 |goto Stonetalon Mountains 45.88,58.66 |only if itemcount(4471) < 1
|tip You need to have Flint and Tinder in your bags to be able to create Basic Campfires to cook with.
buy 10 Simple Wood##4470 |goto Stonetalon Mountains 45.88,58.66 |only if itemcount(4470) < 15 and skill("Cooking") < 300
|tip You will use one of these each time you create a Basic Campfire to cook with.
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 205 Fishing |skill Fishing,205 |goto 46.34,61.25
collect 150 Raw Bristle Whisker Catfish##6308 |goto 46.34,61.25 |only if skill("Cooking") < 175
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 25 Bristle Whisker Catfish>_
Reach Level 125 Cooking |skill Cooking,125 |goto 46.32,60.85
step
talk Wulan##12033
|tip Upstairs inside the building.
buy Expert Cookbook##16072 |n
use the Expert Cookbook##16072
Learn Expert Cooking |skillmax Cooking,225 |goto Desolace 26.17,69.65
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 125 Bristle Whisker Catfish>_
Reach Level 175 Cooking |skill Cooking,175 |goto 25.52,70.11
step
use the Recipe: Mithril Head Trout##17062
learn Mithril Head Trout##20916
step
Enter the building |goto 24.54,68.64 < 7 |walk
talk Innkeeper Sikewa##11106
|tip Inside the building.
buy 20 Alterac Swiss##8932 |goto 24.09,68.21 |q 6610 |future
|tip It may be cheaper on the Auction House.
|tip Save these for later.
step
Fish in the Water
|tip Save any Raw Mithril Head Trout you catch.
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 225 Fishing |skill Fishing,225 |goto Dustwallow Marsh 38.08,31.99
step
Reach Level 35 |ding 35
|tip You must be at least this level before you can accept the quest in the next step.
|tip Use the Leveling guides to accomplish this.
step
Follow the path down |goto 52.55,62.35 < 15 |only if walking
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
collect Sar'theris Striker##16968 |q 6607/3 |goto Desolace 26.19,75.50
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
collect Savage Coast Blue Sailfin##16969 |q 6607/4 |goto Stranglethorn Vale 29.69,28.37
|tip You will eventually catch one.
step
Follow the path down |goto Dustwallow Marsh 52.55,62.35 < 15 |only if walking
talk Nat Pagle##12919
|tip On a small island in the water.
turnin Nat Pagle, Angler Extreme##6607 |goto Dustwallow Marsh 58.55,60.21
Learn Artisan Fishing |skillmax Fishing,300 |goto Dustwallow Marsh 58.55,60.21
|tip You will learn this automatically.
step
Follow the path up |goto 53.42,63.96 < 15 |only if walking
Fish in the Water
|tip Save any Raw Mithril Head Trout you catch.
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 255 Fishing |skill Fishing,255 |goto 38.08,31.99
collect 60 Raw Mithril Head Trout##8365 |goto 38.08,31.99 |only if skill("Cooking") < 225
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 60 Mithril Head Trout>_
Reach Level 225 Cooking |skill Cooking,225 |goto 37.93,31.78
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
Enter the building |goto Feralas 74.69,43.00 < 5 |walk
talk Sheendra Tallgrass##8145
|tip Inside the building.
buy 20 Bright Baubles##6532 |goto Feralas 74.49,42.73 |only if skill("Cooking") < 300
step
Fish in the Water
|tip Save any Raw Redgill you catch.
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 300 Fishing |skill Fishing,300 |goto 75.65,43.89
collect 20 Raw Mithril Head Trout##8365 |goto 75.65,43.89 |only if skill("Cooking") < 250
collect 50 Raw Redgill##13758 |goto 75.65,43.89 |only if skill("Cooking") < 280
collect 35 Raw Sunscale Salmon##13760 |goto 75.65,43.89 |only if skill("Cooking") < 300
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 20 Mithril Headed Trout>_
Reach Level 235 Cooking |skill Cooking,235 |goto 75.32,43.72
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 50 Filets of Redgill>_
Reach Level 275 Cooking |skill Cooking,275 |goto 75.32,43.72
step
use the Recipe: Poached Sunscale Salmon##13946
learn Poached Sunscale Salmon##18244
step
_Create a Basic Campfire_
|tip Use the "Basic Campfire" skill in your spell book.
Open Your Cooking Crafting Panel:
|tip Stand next to the Basic Campfire.
_<Create 35 Poached Sunscale Salmon>_
Reach Level 300 Cooking |skill Cooking,300 |goto 75.32,43.72
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
talk Lumak##3332
Learn Apprentice Fishing |skillmax Fishing,75 |goto Orgrimmar 69.80,29.21
step
talk Shankys##3333
buy Fishing Pole##6256 |goto 69.99,29.77
|tip You need to be able to equip a fishing pole in order to fish.
|only if skill("Fishing") < 300
step
talk Shankys##3333
buy 10 Shiny Bauble##6529 |goto 69.99,29.77
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
Reach Level 55 Fishing |skill Fishing,55 |goto Durotar 41.65,15.66
step
talk Shankys##3333
buy Strong Fishing Pole##6365 |goto Orgrimmar 69.99,29.77
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
Reach Level 75 Fishing |skill Fishing,75 |goto 69.76,30.11
step
talk Lumak##3332
Learn Journeyman Fishing |skillmax Fishing,150 |goto 69.80,29.21
step
talk Shankys##3333
buy 10 Nightcrawlers##6530 |goto 69.99,29.77
|tip These will allow you to catch fish easier.
|only if skill("Fishing") < 150
step
Fish in the Water
use the Nightcrawlers##6530+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 150 Fishing |skill Fishing,150 |goto Stonetalon Mountains 46.33,61.29
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
Follow the path down |goto Dustwallow Marsh 52.55,62.35 < 15 |only if walking
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
collect Sar'theris Striker##16968 |q 6607/3 |goto Desolace 26.19,75.50
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
collect Savage Coast Blue Sailfin##16969 |q 6607/4 |goto Stranglethorn Vale 29.69,28.37
|tip You will eventually catch one.
step
Follow the path down |goto Dustwallow Marsh 52.55,62.35 < 15 |only if walking
talk Nat Pagle##12919
|tip On a small island in the water.
turnin Nat Pagle, Angler Extreme##6607 |goto Dustwallow Marsh 58.55,60.21
Learn Artisan Fishing |skillmax Fishing,300 |goto Dustwallow Marsh 58.55,60.21
|tip You will learn this automatically.
step
talk Shankys##3333
buy 20 Bright Baubles##6532 |goto 69.99,29.77
|tip These will allow you to catch fish easier.
|only if skill("Fishing") < 300
step
Fish in the Water
use the Bright Baubles##6532+
|tip Use it on your Fishing Pole.
|tip These will allow you to catch fish easier.
|tip Try to keep one of these active whenever you are fishing.
Reach Level 300 Fishing |skill Fishing,300 |goto The Hinterlands 81.66,82.38
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\First Aid\\First Aid (1-300)",{
author="support@zygorguides.com",
condition_suggested=function() return skill('First Aid') > 0 end,
description="This guide will walk you through leveling your First Aid skill from 1-300.",
},[[
step
talk Arnok##3373
|tip Inside the building.
Learn Apprentice First Aid |skillmax First Aid,75 |goto Orgrimmar 34.18,84.58
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
talk Arnok##3373
|tip Inside the building.
learn Heavy Linen Bandage##3276 |goto Orgrimmar 34.18,84.58
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
talk Arnok##3373
|tip Inside the building.
Learn Journeyman First Aid |skillmax First Aid,150 |goto Orgrimmar 34.18,84.58
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
talk Arnok##3373
|tip Inside the building.
learn Wool Bandage##3277 |goto Orgrimmar 34.18,84.58
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
talk Arnok##3373
|tip Inside the building.
learn Heavy Wool Bandage##3278 |goto Orgrimmar 34.18,84.58
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
talk Arnok##3373
|tip Inside the building.
learn Silk Bandage##7928 |goto Orgrimmar 34.18,84.58
step
talk Balai Lok'Wein##13476
buy Expert First Aid - Under Wraps##16084 |n
use the Expert First Aid - Under Wraps##16084
Learn Expert First Aid |skillmax First Aid,225 |goto Dustwallow Marsh 36.49,30.36
step
talk Balai Lok'Wein##13476
buy Manual: Heavy Silk Bandage##16112 |goto 36.49,30.36
buy Manual: Mageweave Bandage##16113 |goto 36.49,30.36
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
Enter the building |goto Arathi Highlands 73.42,36.65 < 5 |walk
talk Doctor Gregory Victor##12920
|tip Inside the building.
accept Triage##6622 |goto Arathi Highlands 73.41,36.89
step
use the Triage Bandage##16991
|tip Use it on the injured NPC's on the rugs nearby inside the building.
|tip You must use the Triage Bandage to heal them before they die.
|tip If too many die you will fail the quest.
|tip Press "Ctrl+V" to show their health bars to make it easier.
|tip Try to heal them by priority, in this order:
|tip Critically Injured
|tip Badly Injured
|tip Injured Patients
Save #15# Patients |q 6624/1 |goto 73.03,36.84
|tip If you fail, just abandon the quest and try again.
step
talk Doctor Gregory Victor##12920
|tip Inside the building.
turnin Triage##6624 |goto 73.41,36.89
Learn Artisan First Aid |skillmax First Aid,300 |goto 73.41,36.89
|tip You will learn this automatically.
step
Open Your First Aid Crafting Panel:
_<Create 30 Mageweave Bandages>_
Reach Level 240 First Aid |skill First Aid,240
step
talk Doctor Gregory Victor##12920
|tip Inside the building.
Tell him _"Teach me how to create and apply a Heavy Mageweave Bandage, Doctor."_
learn Heavy Mageweave Bandage##10841 |goto 73.41,36.89
step
Open Your First Aid Crafting Panel:
_<Create 33 Heavy Mageweave Bandages>_
Reach Level 260 First Aid |skill First Aid,260
step
talk Doctor Gregory Victor##12920
|tip Inside the building.
Tell him _"Teach me how to create and apply a Runecloth Bandage, Doctor."_
learn Runecloth Bandage##18629 |goto 73.41,36.89
step
Open Your First Aid Crafting Panel:
_<Create 45 Runecloth Bandages>_
Reach Level 290 First Aid |skill First Aid,290
step
talk Doctor Gregory Victor##12920
|tip Inside the building.
Tell him _"Teach me how to create and apply a Heavy Runecloth Bandage, Doctor."_
learn Heavy Runecloth Bandage##18630 |goto 73.41,36.89
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
talk Ormok##3328
|tip Inside the Cleft of Shadow.
learn Pick Lock##1804 |goto Orgrimmar 43.90,54.63
step
talk Shenthul##3401
|tip Inside the hut, inside the Cleft of Shadow.
accept Zando'zan##2379 |goto 43.05,53.74
step
talk Zando'zan##3402
|tip Inside the hut, inside the Cleft of Shadow.
turnin Zando'zan##2379 |goto 42.73,52.95
accept Wrenix of Ratchet##2382 |goto 42.73,52.95
step
talk Wrenix the Wretched##7161
turnin Wrenix of Ratchet##2382 |goto The Barrens 63.07,36.32
accept Plundering the Plunderers##2381 |goto The Barrens 63.07,36.32
step
talk Wrenix's Gizmotronic Apparatus##7166
Tell it _"Give me what I need stupid machine!"_
collect Thieves' Tools##5060 |goto 63.12,36.32 |q 2381
|tip Save the Thieves' Tools you get.
|tip You must keep Thieves' Tools in your bags to be able to pick locks.
collect E.C.A.C.##7970 |goto 63.12,36.32 |q 2381
step
Follow the path |goto 62.08,38.81 < 10 |only if walking
Continue following the path |goto 62.75,39.86 < 15 |only if walking
Jump onto the front of the ship |goto 64.18,45.49 < 7 |only if walking
click Buccaneer's Strongbox##123330+
|tip They look like small grey metal chests on the ground around this area.
|tip Downstairs inside the ship, on the middle level.
Reach Level 100 Lockpicking |skill Lockpicking,100 |goto 65.06,45.43
step
click The Jewel of the Southsea##123462
|tip Downstairs inside the ship, on the bottom level.
|tip Polly, a high level parrot will appear and attack you.
use E.C.A.C.##7970
|tip Use it on Polly.
|tip It will become weaker.
kill Polly##7167
collect Southsea Treasure##7968 |q 2381/1 |goto 64.95,45.44
step
Follow the path |goto 63.21,42.64 < 20 |only if walking
talk Wrenix the Wretched##7161
turnin Plundering the Plunderers##2381 |goto 63.07,36.32
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
talk Okothos Ironrager##11177
accept The Art of the Armorsmith##5301 |goto Orgrimmar 79.81,24.05
step
Enter the building |goto 81.61,22.77 < 5 |walk
talk Saru Steelfury##3355
|tip Inside the building.
learn Heavy Grinding Stone##3337 |goto 82.34,22.97
learn Solid Grinding Stone##9920 |goto 82.34,22.97
learn Steel Breastplate##9916 |goto 82.34,22.97
learn Steel Plate Helm##9935 |goto 82.34,22.97
step
_Collect These Items:_
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 120 Steel Bar##3859 |q 2756 |future
collect 36 Heavy Stone##2838 |q 2756 |future
collect 16 Solid Stone##7912 |q 2756 |future
step
Open Your Blacksmithing Crafting Panel:
_<Create 12 Heavy Grinding Stones>_
collect 12 Heavy Grinding Stone##3486 |q 2756 |future
step
Open Your Blacksmithing Crafting Panel:
_<Create 4 Solid Grinding Stones>_
collect 4 Solid Grinding Stone##7966 |q 2756 |future
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 4 Steel Breastplates>_
collect 4 Steel Breastplate##7963 |goto Orgrimmar 79.76,22.99 |q 2756 |future
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 4 Steel Plate Helms>_
collect 4 Steel Plate Helm##7922 |goto 79.76,22.99 |q 2756 |future
step
talk Aturk the Anvil##7792
accept The Old Ways##2756 |goto 80.94,23.32
step
talk Aturk the Anvil##7792
turnin The Old Ways##2756 |goto 80.94,23.32
learn Orcish War Leggings##9957 |goto 80.94,23.32
|tip You will learn this automatically.
step
talk Ox##7793
accept Booty Bay or Bust!##2757 |goto 80.45,23.50
step
Run up the ramp |goto Stranglethorn Vale 27.85,76.75 < 7 |only if walking
Follow the path |goto Stranglethorn Vale 28.40,75.77 < 7 |only if walking
talk McGavan##7794
turnin Booty Bay or Bust!##2757 |goto Stranglethorn Vale 28.87,75.42
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
collect 108 Mithril Bar##3860 |q 5301
collect 18 Truesilver Bar##6037 |q 5301
collect 2 Aquamarine##7909 |q 5301
collect 28 Solid Stone##7912 |q 5301
collect 4 Black Pearl##7971 |q 5301
collect Heart of Fire##7077 |q 5301
collect 8 Thick Leather##4304 |q 5301
|tip If you have the Skinning profession, you can gather this.
step
Open Your Blacksmithing Crafting Panel:
_<Create 7 Solid Grinding Stones>_
collect 7 Solid Grinding Stone##7966 |q 5301
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 4 Ornate Mithril Helms>_
collect 4 Ornate Mithril Helm##7937 |q 5301/1 |goto Orgrimmar 79.76,22.99
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Ornate Mithril Boots>_
collect 2 Ornate Mithril Boots##7936 |q 5301/2 |goto 79.76,22.99
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 1 Ornate Mithril Breastplate>_
collect Ornate Mithril Breastplate##7935 |q 5301/3 |goto 79.76,22.99
step
talk Okothos Ironrager##11177
turnin The Art of the Armorsmith##5283 |goto 79.81,24.05
learn Armorsmith##9788 |goto 79.81,24.05
|tip You will learn this automatically.
step
_Congratulations!_
|tip You have become an Blacksmithing Armorsmith.
Learn Plans From Okothos Ironrager at [Orgrimmar 79.81,24.05]
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
talk Borgosh Corebender##11178
accept The Way of the Weaponsmith##5302 |goto Orgrimmar 79.42,23.73
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
talk Vharr##1146
buy Plans: Massive Iron Axe##12164 |n
|tip This is a limited supply item.
|tip If she doesn't have it for sale, check the Auction House.
use the Plans: Massive Iron Axe##12164
learn Massive Iron Axe##3498 |goto 32.36,27.95
Also check Jaquilina Dramet located at [Stranglethorn Vale 35.75,10.66]
step
_Collect These Items:_
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 32 Steel Bar##3859 |q 5302
collect 56 Mithril Bar##3860 |q 5302
collect 56 Iron Bar##3575 |q 5302
collect 16 Gold Bar##3577 |q 5302
collect 48 Heavy Stone##2838 |q 5302
collect 16 Solid Stone##7912 |q 5302
collect 4 Citrine##3864 |q 5302
collect 2 Black Pearl##7971 |q 5302
collect 8 Shadowgem##1210 |q 5302
collect 12 Lesser Moonstone##1705 |q 5302
collect 28 Heavy Leather##4234 |q 5302
|tip If you have the Skinning profession, you can gather this.
collect 4 Thick Leather##4304 |q 5302
|tip If you have the Skinning profession, you can gather this.
step
Enter the building |goto Orgrimmar 81.60,22.77 < 5 |walk
talk Sumi##3356
|tip Inside the building.
buy 16 Strong Flux##3466 |goto Orgrimmar 82.60,23.96 |q 5302
step
Open Your Blacksmithing Crafting Panel:
_<Create 4 Solid Grinding Stones>_
collect 4 Solid Grinding Stone##7966 |q 5302
step
Open Your Blacksmithing Crafting Panel:
_<Create 16 Heavy Grinding Stones>_
collect 16 Heavy Grinding Stone##3486 |q 5302
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 4 Moonsteel Broadswords>_
collect 4 Moonsteel Broadsword##3853 |q 5302/1 |goto 79.76,22.99
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 4 Massive Iron Axes>_
collect 4 Massive Iron Axe##3855 |q 5302/2 |goto 79.76,22.99
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Heavy Mithril Axes>_
collect 2 Heavy Mithril Axe##7941 |q 5302/3 |goto 79.76,22.99
step
Open Your Blacksmithing Crafting Panel:
|tip Stand next to the anvil.
_<Create 2 Big Black Maces>_
collect 2 Big Black Mace##7945 |q 5302/4 |goto 79.76,22.99
step
talk Borgosh Corebender##11178
turnin The Way of the Weaponsmith##5302 |goto 79.42,23.73
learn Weaponsmith##9787 |goto 79.42,23.73
|tip You will learn this automatically.
step
_Congratulations!_
|tip You have become an Blacksmithing Weaponsmith.
Learn Plans From Borgosh Corebender at [Orgrimmar 79.42,23.73]
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
Enter the building |goto The Barrens 62.89,36.52 < 7 |walk
talk Tinkerwiz##3494
|tip Inside the building.
accept Gnome Engineering##3637 |goto The Barrens 62.67,36.31
step
Leave the building |goto 62.89,36.52 < 7 |walk
Run up the ramp |goto Stranglethorn Vale 26.92,73.62 < 7 |only if walking
Follow the path |goto Stranglethorn Vale 28.10,73.96 < 7 |only if walking
Enter the building |goto Stranglethorn Vale 28.29,76.16 < 5 |walk
talk Oglethorpe Obnoticus##7406
|tip Inside the building.
turnin Gnome Engineering##3637 |goto Stranglethorn Vale 28.36,76.35
accept The Pledge of Secrecy##3642 |goto Stranglethorn Vale 28.36,76.35
step
use Oglethorpe's Pledge of Secrecy##10794
collect Oglethorpe's Signed Pledge##11282 |q 3642/1
step
talk Oglethorpe Obnoticus##7406
|tip Inside the building.
turnin The Pledge of Secrecy##3642 |goto 28.36,76.35
accept Show Your Work##3643 |goto 28.36,76.35
step
Enter the building |goto 28.11,74.99 < 7 |walk
talk Mazk Snipeshot##2685
|tip Inside the building.
buy Schematic: Accurate Scope##13310
|tip This is a limited supply item.
|tip If he doesn't have it for sale, check the Auction House.
use the Schematic: Accurate Scope##13310
learn Accurate Scope##3979 |goto 28.50,75.12
step
Enter the building |goto Orgrimmar 75.23,24.61 < 5 |walk
talk Roxxik##11017
|tip Inside the building.
learn Bronze Framework##3953 |goto Orgrimmar 76.17,25.17
learn Gold Power Core##12584 |goto Orgrimmar 76.17,25.17
learn Iron Strut##3958 |goto Orgrimmar 76.17,25.17
learn Gyrochronatom##3961 |goto Orgrimmar 76.17,25.17
learn Advanced Target Dummy##3965 |goto Orgrimmar 76.17,25.17
step
talk Sovik##3413
|tip Inside the building.
buy Weak Flux##2880 |goto 75.48,25.36
step
_Collect These Items:_
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 18 Mithril Bar##3860 |q 3643
collect 6 Bronze Bar##2841 |q 3643
collect Jade##1529 |q 3643
collect Citrine##3864 |q 3643
collect 6 Iron Bar##3575 |q 3643
collect Gold Bar##3577 |q 3643
collect 2 Medium Leather##2319 |q 3643
|tip If you have the Skinning profession, you can gather this.
collect 8 Heavy Leather##4234 |q 3643
|tip If you have the Skinning profession, you can gather this.
collect 2 Wool Cloth##2592 |q 3643
step
Run up the ramp |goto Stranglethorn Vale 26.92,73.62 < 7 |only if walking
Follow the path |goto Stranglethorn Vale 28.10,73.96 < 7 |only if walking
Enter the building |goto Stranglethorn Vale 28.95,75.33 < 5 |walk
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 6 Mithril Tubes>_
collect 6 Mithril Tube##10559 |q 3643/1 |goto Stranglethorn Vale 28.95,75.48
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 1 Bronze Tube>_
collect Bronze Tube##4371 |goto 28.95,75.48 |q 3643
step
Open Your Engineering Crafting Panel:
_<Create 1 Accurate Scope>_
collect Accurate Scope##4407 |q 3643/2
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 2 Iron Struts>_
collect 2 Iron Strut##4387 |goto 28.95,75.48 |q 3643
step
Open Your Engineering Crafting Panel:
_<Create 2 Bronze Frameworks>_
collect 2 Bronze Framework##4382 |q 3643
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 1 Gold Power Core>_
|tip This schematic will give you 3 of these.
collect 2 Gold Power Core##10558 |goto 28.95,75.48 |q 3643
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 2 Gyrochronatoms>_
collect 2 Gyrochronatom##4389 |goto 28.95,75.48 |q 3643
step
Open Your Engineering Crafting Panel:
|tip Stand next to the anvil.
|tip Inside the building.
_<Create 2 Advanced Target Dummies>_
collect 2 Advanced Target Dummy##4392 |q 3643/3 |goto 28.95,75.48
step
Leave the building |goto 28.95,75.33 < 5 |walk
Enter the building |goto 28.29,76.16 < 5 |walk
talk Oglethorpe Obnoticus##7406
|tip Inside the building.
turnin Show Your Work##3643 |goto 28.36,76.35
step
_Congratulations!_
|tip You have earned your Gnome Engineer Membership Card.
|tip This card allows you to learn Gnomish Engineering schematics from Oglethorpe Obnoticus.
|tip This item will last for 14 days of in-game play time.
|tip The time will not count down when you are logged out, so it will last a long time.
|tip You can only learn Gnomish Engineering schematics while you have this item in your bags.
|tip When the time runs out, you can renew the card, if you need to.
|tip Use the "Gnomish Engineering Card Renewal" guide to renew the card.
Learn Schematics From Oglethorpe Obnoticus at [Stranglethorn Vale 28.36,76.35]
|tip On the upper dock, inside the building.
]])
ZygorGuidesViewer:RegisterGuide("Profession Guides\\Engineering\\Specialization\\Gnomish Engineering\\Gnome Engineer Membership Card Renewal",{
author="support@zygorguides.com",
description="This guide will walk you through renewing your Gnome Engineer Membership Card, as well as using the Gnome Engineer's Renewal Gifts to collect rare schematics.",
},[[
step
Enter the building |goto Stranglethorn Vale 28.29,76.16 < 5 |walk
talk Oglethorpe Obnoticus##7406
|tip Inside the building.
accept Membership Card Renewal##3645 |goto Stranglethorn Vale 28.36,76.35
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
Enter the building |goto The Barrens 62.89,36.52 < 7 |walk
talk Tinkerwiz##3494
|tip Inside the building.
accept Goblin Engineering##3633 |goto The Barrens 62.67,36.31
step
Leave the building |goto 62.89,36.52 < 7 |walk
Enter the building |goto Tanaris 52.39,27.30 < 5 |walk
talk Nixx Sprocketspring##8126
|tip Inside the building.
turnin Goblin Engineering##3633 |goto Tanaris 52.48,27.33
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
collect 36 Thick Leather##4304 |q 5145 |future
collect 40 Scorpid Scale##8154 |q 5145 |future
collect 10 Worn Dragonscale##8165 |q 5145 |future
|tip These are skinned from Dragonkin enemies and bosses inside the Temple of Atal'Hakkar (Sunken Temple) dungeon.
step
talk Nerrist##1148
buy 12 Silken Thread##4291 |goto Stranglethorn Vale 32.70,29.23 |q 5145 |future
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Tough Scorpid Gloves>_
collect 2 Tough Scorpid Gloves##8204 |q 5145 |future
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Tough Scorpid Breastplates>_
collect 2 Tough Scorpid Breastplate##8203 |q 5145 |future
step
talk Thorkaf Dragoneye##7867
accept Dragonscale Leatherworking##5145 |goto Badlands 62.70,57.40
step
talk Thorkaf Dragoneye##7867
turnin Dragonscale Leatherworking##5145 |goto 62.70,57.40
learn Dragonscale Leatherworking##10656 |goto 62.70,57.40
|tip You will learn this automatically.
step
_Congratulations!_
|tip You have become a Dragonscale Leatherworker.
Learn Patterns From Thorkaf Dragoneye at [Badlands 62.70,57.40]
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
collect 2 Heart of Fire##7077 |q 5146 |future
collect 2 Globe of Water##7079 |q 5146 |future
collect 2 Core of Earth##7075 |q 5146 |future
collect 2 Breath of Wind##7081 |q 5146 |future
step
talk Brumn Winterhoof##7869
accept Elemental Leatherworking##5146 |goto Arathi Highlands 28.27,45.09
step
talk Brumn Winterhoof##7869
turnin Elemental Leatherworking##5146 |goto 28.27,45.09
step
_Congratulations!_
|tip You have become an Elemental Leatherworker.
Learn Patterns From Brumn Winterhoof at [Arathi Highlands 28.27,45.09]
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
_Collect These Items:_
|tip If you have the Skinning profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
collect 214 Thick Leather##4304 |q 2858 |future
collect 112 Turtle Scale##8167 |q 2859 |future
collect 11 Wildvine##8153 |q 5148 |future
|tip If you have the Herbalism profession, you can gather these.
collect 2 Cured Thick Hide##8172 |q 5148 |future
step
Enter the building |goto Feralas 74.68,42.99 < 5 |walk
talk Hahrana Ironhide##11098
|tip Inside the building.
learn Cured Thick Hide##10482 |goto Feralas 74.36,43.12
learn Thick Armor Kit##10487 |goto Feralas 74.36,43.12
learn Nightscape Headband##10507 |goto Feralas 74.36,43.12
learn Nightscape Tunic##10499 |goto Feralas 74.36,43.12
learn Turtle Scale Bracers##10518 |goto Feralas 74.36,43.12
learn Turtle Scale Breastplate##10511 |goto Feralas 74.36,43.12
learn Turtle Scale Helm##10552 |goto Feralas 74.36,43.12
learn Nightscape Boots##10558 |goto Feralas 74.36,43.12
learn Nightscape Pants##10548 |goto Feralas 74.36,43.12
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
buy Pattern: Turtle Scale Gloves##8385 |n
|tip This is a limited supply item.
|tip If he doesn't have it for sale, check the Auction House.
use the Pattern: Turtle Scale Gloves##8385
learn Turtle Scale Gloves##10509 |goto 74.43,42.91
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
accept Wild Leather Armor##2854 |goto 74.43,42.91
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
turnin Wild Leather Armor##2854 |goto 74.43,42.91
accept Wild Leather Shoulders##2855 |goto 74.43,42.91
accept Wild Leather Vest##2856 |goto 74.43,42.91
accept Wild Leather Helmet##2857 |goto 74.43,42.91
accept Wild Leather Boots##2858 |goto 74.43,42.91
accept Wild Leather Leggings##2859 |goto 74.43,42.91
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
buy 22 Silken Thread##4291 |goto 74.43,42.91 |q 2859
buy 12 Heavy Silken Thread##8343 |goto 74.43,42.91 |q 2859
step
Open Your Leatherworking Crafting Panel:
_<Create 6 Thick Armor Kits>_
collect 6 Thick Armor Kit##8173 |q 2855/1
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
turnin Wild Leather Shoulders##2855 |goto 74.43,42.91
step
use the Pattern: Wild Leather Shoulders##8403
learn Wild Leather Shoulders##10529
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Turtle Scale Breastplates>_
collect 2 Turtle Scale Breastplate##8189 |q 2856/1
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Turtle Scale Gloves>_
collect 2 Turtle Scale Gloves##8187 |q 2856/2
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
turnin Wild Leather Vest##2856 |goto 74.43,42.91
step
use the Pattern: Wild Leather Vest##8404
learn Wild Leather Vest##10544
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Nightscape Tunics>_
collect 2 Nightscape Tunic##8175 |q 2857/1
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Nightscape Headbands>_
collect 2 Nightscape Headband##8176 |q 2857/2
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
turnin Wild Leather Helmet##2857 |goto 74.43,42.91
step
use the Pattern: Wild Leather Helmet##8405
learn Wild Leather Helmet##10546
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Nightscape Pants>_
collect 2 Nightscape Pants##8193 |q 2858/1
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Nightscape Boots>_
collect 2 Nightscape Boots##8197 |q 2858/2
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
turnin Wild Leather Boots##2858 |goto 74.43,42.91
step
use the Pattern: Wild Leather Boots##8406
learn Wild Leather Boots##10566
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Turtle Scale Helms>_
collect 2 Turtle Scale Helm##8191 |q 2859/1
step
Open Your Leatherworking Crafting Panel:
_<Create 2 Turtle Scale Bracers>_
collect 2 Turtle Scale Bracers##8198 |q 2859/2
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
turnin Wild Leather Leggings##2859 |goto 74.43,42.91
step
use the Pattern: Wild Leather Leggings##8407
learn Wild Leather Leggings##10572
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
accept Master of the Wild Leather##2860 |goto 74.43,42.91
step
Enter the building |goto Thunder Bluff 43.76,42.44 < 5 |walk
talk Una##3007
|tip Inside the building.
turnin Master of the Wild Leather##2853 |goto Thunder Bluff 41.51,42.57
step
use the Pattern: Wild Leather Cloak##8408
learn Wild Leather Cloak##10574
step
Open Your Leatherworking Crafting Panel:
_<Create 1 Wild Leather Vest>_
collect Wild Leather Vest##8211 |q 5148 |future
step
Open Your Leatherworking Crafting Panel:
_<Create 1 Wild Leather Helmet>_
collect Wild Leather Helmet##8214 |q 5148 |future
step
Follow the path |goto Stranglethorn Vale 32.79,28.75 < 10 |only if walking
Continue following the path |goto Stranglethorn Vale 35.28,35.56 < 20 |only if walking
talk Se'Jib##7871
|tip Inside the hut.
accept Tribal Leatherworking##5143 |goto Stranglethorn Vale 36.55,34.09
step
talk Se'Jib##7871
|tip Inside the hut.
turnin Tribal Leatherworking##5143 |goto 36.55,34.09
step
_Congratulations!_
|tip You have become a Tribal Leatherworker.
Learn Patterns From Se'Jib at [Stranglethorn Vale 36.55,34.09]
]])
