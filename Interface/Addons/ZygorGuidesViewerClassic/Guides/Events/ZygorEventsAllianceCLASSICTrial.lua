local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("EventsA") then return end
ZygorGuidesViewer.GuideMenuTier = "TRI"
ZygorGuidesViewer:RegisterGuide("Events Guides\\Darkmoon Faire\\Elwynn Forest\\Sayge's Fortunes (Elwynn Forest)",{
author="support@zygorguides.com",
description="\nReceive a stat buff and have your fortune told by Sayge at the Darkmoon Faire.",
model={491},
},[[
step
label "Choose_Fortune"
Choose the buff you would like to receive:
|tip The buff lasts for two hours.
|tip You can have your fortune told every four hours.
|tip NOTE: You will not be able to receive the written fortune and potential quest without an open inventory slot.
+10% Agility |confirm |next "Agility_Buff"
+10% Intelligence |confirm |next "Intelligence_Buff"
+10% Spirit |confirm |next "Spirit_Buff"
+10% Stamina |confirm |next "Stamina_Buff"
+10% Strength |confirm |next "Strength_Buff"
+10% Armor |confirm |next "Armor_Buff"
+25 All Resistances |confirm |next "Resistance_Buff"
+10% Damage |confirm |next "Damage_Buff"
step
label "Agility_Buff"
talk Sayge##14822
Choose _"I am ready to discover where my fortune lies!"_
Tell him _"I confiscate the corn he has stolen, warn him that stealing is a path towards doom and destruction, but I let him go to return to his family."_
Then tell him _"I would create some surreptitious means to keep my brother out of the order."_
Gain the "Sayge's Dark Fortune of Agility" Buff |havebuff spell:23736 |goto Elwynn Forest 42.12,69.00 |next "Use_Darkmoon_Faire_Fortune"
step
label "Intelligence_Buff"
talk Sayge##14822
Choose _"I am ready to discover where my fortune lies!"_
Tell him _"I turn over the man to my liege for punishment, as he has broken the law of the land and it is my sworn duty to enforce it."_
Then tell him _"I quietly ignore the insult."_
Gain the "Sayge's Dark Fortune of Intelligence" Buff |havebuff spell:23766 |goto Elwynn Forest 42.12,69.00 |next "Use_Darkmoon_Faire_Fortune"
step
label "Spirit_Buff"
talk Sayge##14822
Choose _"I am ready to discover where my fortune lies!"_
Tell him _"I turn over the man to my liege for punishment, as he has broken the law of the land and it is my sworn duty to enforce it."_
Then tell him _"I confront the ruler on his malicious behavior, upholding my liege's honor at the risk of any future diplomacy."_
Gain the "Sayge's Dark Fortune of Spirit" Buff |havebuff spell:23738 |goto Elwynn Forest 42.12,69.00 |next "Use_Darkmoon_Faire_Fortune"
step
label "Stamina_Buff"
talk Sayge##14822
Choose _"I am ready to discover where my fortune lies!"_
Tell him _"I confiscate the corn he has stolen, warn him that stealing is a path towards doom and destruction, but I let him go to return to his family."_
Then tell him _"I would speak against my brother joining the order, rushing a permanent breech in our relationship."_
Gain the "Sayge's Dark Fortune of Stamina" Buff |havebuff spell:23737 |goto Elwynn Forest 42.12,69.00 |next "Use_Darkmoon_Faire_Fortune"
step
label "Strength_Buff"
talk Sayge##14822
Choose _"I am ready to discover where my fortune lies!"_
Tell him _"I confiscate the corn he has stolen, warn him that stealing is a path towards doom and destruction, but I let him go to return to his family."_
Then tell him _"I would speak for my brother joining the order, potentially risking the safety of the order."_
Gain the "Sayge's Dark Fortune of Strength" Buff |havebuff spell:23735 |goto Elwynn Forest 42.12,69.00 |next "Use_Darkmoon_Faire_Fortune"
step
label "Armor_Buff"
talk Sayge##14822
Choose _"I am ready to discover where my fortune lies!"_
Tell him _"I slay the man on the spot as my liege would expect me to do, as he is nothing more than a thief and a liar."_
Then tell him _"I risk my own life and free him so that he may prove his innocence."_
Gain the "Sayge's Dark Fortune of Armor" Buff |havebuff spell:23767 |goto Elwynn Forest 42.12,69.00 |next "Use_Darkmoon_Faire_Fortune"
step
label "Resistance_Buff"
talk Sayge##14822
Choose _"I am ready to discover where my fortune lies!"_
Tell him _"I slay the man on the spot as my liege would expect me to do, as he is nothing more than a thief and a liar."_
Then tell him _"I execute him as per my liege's instructions, but doing so in as painless of a way as possible."_
Gain the "Sayge's Dark Fortune of Resistance" Buff |havebuff spell:23769 |goto Elwynn Forest 42.12,69.00 |next "Use_Darkmoon_Faire_Fortune"
step
label "Damage_Buff"
talk Sayge##14822
Choose _"I am ready to discover where my fortune lies!"_
Tell him _"I slay the man on the spot as my liege would expect me to do, as he is nothing more than a thief and a liar."_
Then tell him _"I execute him as per my liege's instructions, and do it in such a manner that he suffers painfully before he dies as retribution for his crimes against my people."_
Gain the "Sayge's Dark Fortune of Damage" Buff |havebuff spell:23768 |goto Elwynn Forest 42.12,69.00 |next "Use_Darkmoon_Faire_Fortune"
step
label "Use_Darkmoon_Faire_Fortune"
talk Sayge##14822
Tell him _"I'd love to get one of those written fortunes you mentioned!"_
collect 1 Darkmoon Faire Fortune##19422 |goto Elwynn Forest 42.12,69.00
step
use the Darkmoon Faire Fortune##19422
Obtain Your Fortune |condition itemcount(19422) == 0
step
label "Fortune_Told"
You have received your fortune
|tip You can have your fortune told every four hours.
Click Here to Choose Another Fortune |confirm |next "Choose_Fortune" |or
'|condition itemcount(19423) == 1 and not completedq(7937) and level >= 10 |next "Fortune_Awaits_Eastvale" |or
'|condition itemcount(19424) == 1 and not completedq(7938) and level >= 10 |next "Fortune_Awaits_Deadmines" |or
'|condition itemcount(19443) == 1 and not completedq(7944) and level >= 10 |next "Fortune_Awaits_Wailing_Caverns" |or
'|condition itemcount(19452) == 1 and not completedq(7945) and level >= 10 |next "Fortune_Awaits_Palemane_Rock" |or
step
label "Fortune_Awaits_Eastvale"
use Sayge's Fortune #23##19423
accept Your Fortune Awaits You...##7937
step
click Mysterious Eastvale Haystack
turnin Your Fortune Awaits You...##7937 |goto Elwynn Forest 84.79,64.37 |next "Fortune_Told"
step
label "Fortune_Awaits_Deadmines"
use Sayge's Fortune #24##19424
accept Your Fortune Awaits You...##7938
step
click Mysterious Deadmines Chest
|tip Just inside The Deadmines instance before you reach the first Miner.
|tip It may take a minute or two to appear.
turnin Your Fortune Awaits You...##7938 |next "Fortune_Told"
step
label "Fortune_Awaits_Wailing_Caverns"
use Sayge's Fortune #25##19443
accept Your Fortune Awaits You...##7944
step
click Mysterious Wailing Caverns Chest
|tip Just inside the Wailing Caverns instance after the Disciple of Naralex.
|tip It may take a minute or two to appear.
turnin Your Fortune Awaits You...##7944 |next "Fortune_Told"
step
label "Fortune_Awaits_Palemane_Rock"
use Sayge's Fortune #27##19452
accept Your Fortune Awaits You...##7945
step
click Mysterious Tree Stump
turnin Your Fortune Awaits You...##7945 |goto Mulgore 34.99,61.56 |next "Fortune_Told"
]])
ZygorGuidesViewer:RegisterGuide("Events Guides\\Darkmoon Faire\\Elwynn Forest\\Chronos Turn-Ins (Elwynn Forest)",{
author="support@zygorguides.com",
description="\nExchange various Leatherworking crafted items with Chronos for prize tickets at the Darkmoon Faire.",
model={14875},
},[[
step
collect 3 Embossed Leather Boots##2309 |n
|tip Create them with Leatherworking or purchase them from the Auction House.
talk Chronos##14833
accept Carnival Boots##7881 |goto Elwynn Forest 43.57,70.86 |or
|tip Each turnin requires 3 Embossed Leather Boots and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 1 Darkmoon Faire Prize Ticket.
|tip You can turn this quest in until you reach 500 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 500 |or
step
Reach Level 10 |ding 10
|tip Use the leveling guides to accomplish this.
step
collect 3 Toughened Leather Armor##2314 |n
|tip Create them with Leatherworking or purchase them from the Auction House.
talk Chronos##14833
accept Carnival Jerkins##7882 |goto 43.57,70.86 |or
|tip Each turnin requires 3 Toughened Leather Armors and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 4 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 1,100 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 1100 |or
step
Reach Level 20 |ding 20
|tip Use the leveling guides to accomplish this.
step
collect 3 Barbaric Harness##5739 |n
|tip Create them with Leatherworking or purchase them from the Auction House.
talk Chronos##14833
accept The World's Largest Gnome!##7883 |goto 43.57,70.86 |or
|tip Each turnin requires 3 Barbaric Harnesses and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 8 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 1,700 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 1700 |or
step
Reach Level 30 |ding 30
|tip Use the leveling guides to accomplish this.
step
collect 1 Turtle Scale Leggings##8185 |n
|tip Create them with Leatherworking or purchase them from the Auction House.
talk Chronos##14833
accept Crocolisk Boy and the Bearded Murloc##7884 |goto 43.57,70.86 |or
|tip Each turnin requires 1 Turtle Scale Leggings and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 12 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 2,500 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 2500 |or
step
Reach Level 40 |ding 40
|tip Use the leveling guides to accomplish this.
step
collect 8 Rugged Armor Kit##15564 |q 7885 |future
|tip Create them with Leatherworking or purchase them from the Auction House.
step
talk Chronos##14833
accept Armor Kits##7885 |goto 43.57,70.86
step
collect 8 Rugged Armor Kit##15564 |n
|tip Create them with Leatherworking or purchase them from the Auction House.
talk Chronos##14833
accept More Armor Kits##7941 |goto 43.57,70.86 |or
|tip From this point on, you can continue turning in Rugged Armor Kits.
|tip Each of these turnins will award 20 Darkmoon Faire Prize Tickets.
|tip Each turnin requires 8 Rugged Armor Kits and grants 100 reputation with the Darkmoon Faire.
]])
ZygorGuidesViewer:RegisterGuide("Events Guides\\Darkmoon Faire\\Elwynn Forest\\Kerri Hicks Turn-Ins (Elwynn Forest)",{
author="support@zygorguides.com",
description="\nExchange various Blacksmithing crafted items with Kerri Hicks for prize tickets at the Darkmoon Faire.",
model={14876},
},[[
step
collect 10 Coarse Weightstone##3240 |n
|tip Create them with Blacksmithing or purchase them from the Auction House.
talk Kerri Hicks##14832
accept Coarse Weightstone##7889 |goto Elwynn Forest 40.48,69.93 |or
|tip Each turnin requires 10 Coarse Weightstones and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 1 Darkmoon Faire Prize Ticket.
|tip You can turn this quest in until you reach 500 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 500 |or
step
Reach Level 10 |ding 10
|tip Use the leveling guides to accomplish this.
step
collect 7 Heavy Grinding Stone##3486 |n
|tip Create them with Blacksmithing or purchase them from the Auction House.
talk Kerri Hicks##14832
accept Heavy Grinding Stone##7890 |goto 40.48,69.93 |or
|tip Each turnin requires 7 Heavy Grinding Stones and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 4 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 1,100 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 1100 |or
step
Reach Level 20 |ding 20
|tip Use the leveling guides to accomplish this.
step
collect 3 Green Iron Bracers##3835 |n
|tip Create them with Blacksmithing or purchase them from the Auction House.
talk Kerri Hicks##14832
accept Green Iron Bracers##7891 |goto 40.48,69.93 |or
|tip Each turnin requires 3 Green Iron Bracers and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 8 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 1,700 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 1700 |or
step
Reach Level 30 |ding 30
|tip Use the leveling guides to accomplish this.
step
collect 1 Big Black Mace##7945 |n
|tip Create them with Blacksmithing or purchase them from the Auction House.
talk Kerri Hicks##14832
accept Big Black Mace##7892 |goto 40.48,69.93 |or
|tip Each turnin requires 1 Big Black Mace and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 12 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 2,500 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 2500 |or
step
Reach Level 40 |ding 40
|tip Use the leveling guides to accomplish this.
step
collect 8 Dense Grinding Stone##12644 |q 7893 |future
|tip Create them with Blacksmithing or purchase them from the Auction House.
step
talk Kerri Hicks##14832
accept Rituals of Strength##7893 |goto 40.48,69.93
step
collect 8 Dense Grinding Stone##12644 |n
|tip Create them with Blacksmithing or purchase them from the Auction House.
talk Kerri Hicks##14832
accept More Dense Grinding Stones##7939 |goto 40.48,69.93 |or
|tip From this point on, you can continue turning in Dense Grinding Stones.
|tip Each of these turnins will award 20 Darkmoon Faire Prize Tickets.
|tip Each turnin requires 8 Dense Grinding Stones and grants 100 reputation with the Darkmoon Faire.
]])
ZygorGuidesViewer:RegisterGuide("Events Guides\\Darkmoon Faire\\Elwynn Forest\\Rinling Turn-Ins (Elwynn Forest)",{
author="support@zygorguides.com",
description="\nExchange various Engineering crafted items with Rinling for prize tickets at the Darkmoon Faire.",
model={14877},
},[[
step
collect 5 Copper Modulator##4363 |n
|tip Create them with Engineering or purchase them from the Auction House.
|tip They also have a small chance to drop from mobs in the Gnomeregan dungeon.
talk Rinling##14841
accept Copper Modulator##7894 |goto Elwynn Forest 41.71,70.72 |or
|tip Each turnin requires 5 Copper Modulators and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 1 Darkmoon Faire Prize Ticket.
|tip You can turn this quest in until you reach 500 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 500 |or
step
Reach Level 10 |ding 10
|tip Use the leveling guides to accomplish this.
step
collect 7 Whirring Bronze Gizmo##4375 |n
|tip Create them with Engineering or purchase them from the Auction House.
talk Rinling##14841
accept Whirring Bronze Gizmo##7895 |goto 41.71,70.72 |or
|tip Each turnin requires 7 Whirring Bronze Gizmos and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 4 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 1,100 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 1100 |or
step
Reach Level 20 |ding 20
|tip Use the leveling guides to accomplish this.
step
collect 36 Green Firework##9313 |n
|tip Create them with Engineering or purchase them from the Auction House.
|tip They can also be purchased from any Holiday Fireworks Vendor on July 4th.
talk Rinling##14841
accept Green Fireworks##7896 |goto 41.71,70.72 |or
|tip Each turnin requires 36 Green Fireworks and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 8 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 1,700 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 1700 |or
step
Reach Level 30 |ding 30
|tip Use the leveling guides to accomplish this.
step
collect 6 Mechanical Repair Kit##11590 |n
|tip Create them with Engineering or purchase them from the Auction House.
talk Rinling##14841
accept Mechanical Repair Kits##7897 |goto 41.71,70.72 |or
|tip Each turnin requires 6 Mechanical Repair Kits and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 12 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 2,500 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 2500 |or
step
Reach Level 40 |ding 40
|tip Use the leveling guides to accomplish this.
step
collect 6 Thorium Widget##15994 |q 7898 |future
|tip Create them with Engineering or purchase them from the Auction House.
step
talk Rinling##14841
accept Thorium Widget##7898 |goto 41.71,70.72
step
collect 6 Thorium Widget##15994 |n
|tip Create them with Engineering or purchase them from the Auction House.
talk Rinling##14841
accept More Thorium Widgets##7942 |goto 41.71,70.72 |or
|tip From this point on, you can continue turning in Thorium Widgets.
|tip Each of these turnins will award 20 Darkmoon Faire Prize Tickets.
|tip Each turnin requires 6 Thorium Widgets and grants 100 reputation with the Darkmoon Faire.
]])
ZygorGuidesViewer:RegisterGuide("Events Guides\\Darkmoon Faire\\Elwynn Forest\\Yebb Neblegear Turn-Ins (Elwynn Forest)",{
author="support@zygorguides.com",
description="\nExchange various Farmed items with Yebb Neblegear for prize tickets at the Darkmoon Faire.",
model={14856},
},[[
step
Kill Savannah enemies around this area
|tip You can find them all over around Crossroads and to its northern area.
collect 5 Small Furry Paw##5134 |goto The Barrens 50.21,21.82 |n
talk Yebb Neblegear##14829
accept Small Furry Paws##7899 |goto Elwynn Forest 40.17,69.53 |or
|tip Each turnin requires 5 Small Furry Paws and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 1 Darkmoon Faire Prize Ticket.
|tip You can turn this quest in until you reach 500 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 500 |or
step
Reach Level 10 |ding 10
|tip Use the leveling guides to accomplish this.
step
Kill Ashenvale Bear enemies around this area
|tip You can find them all over between Raynewood Retreat and Splintertree post.
|tip You can also find them east of Satyrn.
collect 5 Torn Bear Pelt##11407 |goto Ashenvale 66.01,60.42 |n
You can find more around [83.81,47.40]
talk Yebb Neblegear##14829
accept Torn Bear Pelts##7900 |goto Elwynn Forest 40.17,69.53 |or
|tip Each turnin requires 5 Torn Bear Pelts and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 4 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 1,100 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 1100 |or
step
Reach Level 20 |ding 20
|tip Use the leveling guides to accomplish this.
step
Kill Crag Coyote enemies around this area
|tip You can find the all over central and western Badlands.
collect 5 Soft Bushy Tail##4582 |goto Badlands 34.41,65.63 |n
You can find more around [57.00,58.62]
talk Yebb Neblegear##14829
accept Soft Bushy Tails##7901 |goto Elwynn Forest 40.17,69.53 |or
|tip Each turnin requires 5 Soft Bushy Tails and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 8 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 1,700 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 1700 |or
step
Reach Level 30 |ding 30
|tip Use the leveling guides to accomplish this.
step
Kill Northspring enemies around this area
collect 5 Vibrant Plume##5117 |goto Feralas 40.00,12.61 |n
talk Yebb Neblegear##14829
accept Vibrant Plumes##7902 |goto Elwynn Forest 40.17,69.53 |or
|tip Each turnin requires 5 Vibrant Plumes and grants 100 reputation with the Darkmoon Faire.
|tip Each of these turnins will award 12 Darkmoon Faire Prize Tickets.
|tip You can turn this quest in until you reach 2,500 Neutral reputation.
'|condition repval('Darkmoon Faire','Neutral') >= 2500 |or
step
Reach Level 40 |ding 40
|tip Use the leveling guides to accomplish this.
step
Kill Stonelash enemies around this area
|tip You can find them all over central and southern Silithus.
collect 10 Glowing Scorpid Blood##19933 |goto Silithus 44.81,54.50 |q 8222 |future
step
talk Yebb Neblegear##14829
accept Glowing Scorpid Blood##8222 |goto Elwynn Forest 40.17,69.53
step
Kill Stonelash enemies around this area
|tip You can find them all over central and southern Silithus.
collect 10 Glowing Scorpid Blood##19933 |goto Silithus 44.81,54.50 |n
talk Yebb Neblegear##14829
accept More Glowing Scorpid Blood##8223 |goto Elwynn Forest 40.17,69.53
|tip From this point on, you can continue turning in Glowing Scorpid Blood.
|tip Each of these turnins will award 20 Darkmoon Faire Prize Tickets.
|tip Each turnin requires 10 Glowing Scorpid Blood and grants 100 reputation with the Darkmoon Faire.
]])
ZygorGuidesViewer:RegisterGuide("Events Guides\\Darkmoon Faire\\Elwynn Forest\\Spawn of Jubjub (Elwynn Forest)",{
author="support@zygorguides.com",
description="\nCollect a couple of Dark Iron Ale Mugs from the Grim Guzzler tavern in Blackrock Depths "..
"and offer them to Morja at the Darkmoon Faire to receive your very own Jubjub companion pet.",
condition_end=function() return completedq(7946) end,
model={14938},
},[[
step
click Dark Iron Ale Mug##165738
|tip They look like small mugs of ale on tables around the Grim Guzzler tavern in Blackrock Depths.
|tip Clicking two of them is safe but clicking more will anger the bar patrons.
collect 2 Dark Iron Ale Mug##11325 |q 7946 |future
|tip They can also be purchased from Plugger Spazzring in the Grim Guzzler.
|tip They can be purchased from the Auction House if you are lucky enough to find them.
step
use the Dark Iron Ale Mug##11325
|tip Place it at Morja's feet.
|tip Be sure you only use one; you will need the other one to turn in the quest.
Wait for Jubjub the frog to hop over to the mug
|tip This may take a couple of minutes.
talk Morja##14871
accept Spawn of Jubjub##7946 |goto Elwynn Forest 43.33,70.29
|tip This quest will be available after Jubjub appears.
step
use the Unhatched Jubling Egg##19462
|tip It will take seven days for the egg to mature enough to hatch.
collect 1 A Jubling's Tiny Home##19450
]])
ZygorGuidesViewer:RegisterGuide("Events Guides\\Darkmoon Faire\\Elwynn Forest\\Wood Frog (Elwynn Forest)",{
author="support@zygorguides.com",
description="\nCatch Flik as he runs all over the Darkmoon Faire grounds and purchase his limited supply "..
"Wood Frog Box for 1 gold.",
model={901},
},[[
step
talk Flik##14860
|tip He's a little Orc boy running fast all over the Darkmoon Faire grounds.
|tip You will have to be quick to catch him.
|tip Talking to him will stop him for a short period of time.
buy 1 Wood Frog Box##11027 |goto Elwynn Forest 42.59,70.30
|tip This item costs 1 gold and has a limited quantity of 1.
|tip It respawns in approximately 20 minutes.
]])
ZygorGuidesViewer:RegisterGuide("Events Guides\\Darkmoon Faire\\Elwynn Forest\\Tree Frog (Elwynn Forest)",{
author="support@zygorguides.com",
description="\nCatch Flik as he runs all over the Darkmoon Faire grounds and purchase his "..
"Tree Frog Box for 1 gold.",
model={6295},
},[[
step
talk Flik##14860
|tip He's a little Orc boy running fast all over the Darkmoon Faire grounds.
|tip You will have to be quick to catch him.
|tip Talking to him will stop him for a short period of time.
buy 1 Tree Frog Box##11026 |goto Elwynn Forest 42.59,70.30
|tip This item costs 1 gold.
]])
ZygorGuidesViewer:RegisterGuide("Events Guides\\Love is in the Air\\Love is in the Air Quests",{
author="support@zygorguides.com",
description="\nThis guide will assist you in completing the quests for the \"Love is in the Air\" event.",
condition_end=function() return completedq(9029) end,
},[[
step
talk Aristan Mottar##16105
accept Dangerous Love##8903 |goto Stormwind City 54.60,65.29
step
talk Innkeeper Allison##6740
|tip Inside the building.
buy 1 Love Token##21815 |goto 52.62,65.70 |q 8903
buy 1 Cologne Bottle##21833 |goto 52.62,65.70 |q 8903
buy 1 Perfume Bottle##21829 |goto 52.62,65.70 |q 8903
step
use the Cologne Bottle##21833
use the Perfume Bottle##21829
Apply Perfume or Cologne |condition hasbuff("spell:26681") or hasbuff("spell:26682") |q 8903
|tip Perfume allows you to give Love Tokens to male NPCs.
|tip Cologne allows you to give Love Tokens to female NPCs.
step
Talk to NPCs
|tip Talk to those with a heart above their head.
Tell them _"Here, I'd like to give you this token of my love."_
use the Pledge of Adoration: Stormwind##21975
use the Pledge of Friendship: Stormwind##22178
collect 1 Stormwind Guard's Card##22143 |q 8903
step
talk Aristan Mottar##16105
turnin Dangerous Love##8903 |goto 54.60,65.29
accept Artisan's Hunch##9024 |goto 54.60,65.29
step
talk Morgan Pestle##279
|tip Inside the building.
turnin Artisan's Hunch##9024 |goto 56.20,64.58
accept Morgan's Discovery##9025 |goto 56.20,64.58
step
talk Aristan Mottar##16105
turnin Morgan's Discovery##9025 |goto 54.60,65.29
accept Tracing the Source##9026 |goto 54.60,65.29
step
talk Innkeeper Allison##6740
|tip Inside the building.
turnin Tracing the Source##9026 |goto 52.62,65.70
accept Tracing the Source##9027 |goto 52.62,65.70
step
talk Evert Sorisam##16106
|tip Inside the building.
turnin Tracing the Source##9027 |goto 39.83,46.97
accept The Source Revealed##9028 |goto 39.83,46.97
step
Follow the path up |goto Hillsbrad Foothills 75.5,24.0
Enter the cave |goto 77.7,19.4
Run up the hill |goto Alterac Mountains 84.3,84.3
Follow the path up |goto 86.1,25.3
talk Apothecary Staffron Lerent##16107
turnin The Source Revealed##9028 |goto 89.5,75.5
step
click Fragrant Cauldron
accept A Bubbling Cauldron##9029 |goto 89.6,75.7
]])
ZygorGuidesViewer:RegisterGuide("Events Guides\\Love is in the Air\\Gift Giving",{
author="support@zygorguides.com",
description="\nThis guide will assist you in completing the \"Gift Giving\" quest for the \"Love is in the Air\" event.",
},[[
step
label "Begin_Guide"
talk Innkeeper Allison##6740
|tip Inside the building.
buy 10 Love Token##21815 |goto Stormwind City 52.62,65.70
buy 1 Cologne Bottle##21833 |goto 52.62,65.70
buy 1 Perfume Bottle##21829 |goto 52.62,65.70
step
label "Apply_Perfume_or_Cologne_Stormwind"
use the Cologne Bottle##21833
use the Perfume Bottle##21829
Apply Perfume or Cologne |condition hasbuff("spell:26681") or hasbuff("spell:26682")
|tip Perfume allows you to give Love Tokens to male NPCs.
|tip Cologne allows you to give Love Tokens to female NPCs.
step
Talk to Stormwind City NPCs
|tip Talk to guards around Stormwind who have hearts over their heads.
|tip If you run out of Love Tokens, talk to the nearest Innkeeper to purchase more.
Tell them _"Here, I'd like to give you this token of my love."_
use the Pledge of Adoration: Stormwind##21975
use the Pledge of Friendship: Stormwind##22178
collect 5 Pledge of Loyalty: Stormwind##22117 |goto Stormwind City 55.91,61.93 |or
'|condition not hasbuff("spell:26681") and not hasbuff("spell:26682") and itemcount (22117) < 5 |next "Apply_Perfume_or_Cologne_Stormwind" |or
step
Talk to Stormwind City NPCs
|tip Talk to guards around Stormwind who have hearts over their heads.
|tip If you run out of Love Tokens, talk to the nearest Innkeeper to purchase more.
Tell them _"Here, I'd like to give you this token of my love."_
use the Pledge of Adoration: Stormwind##21975
use the Pledge of Friendship: Stormwind##22178
collect 5 Stormwind Guard's Card##22143 |goto Stormwind City 55.91,61.93 |or
'|condition not hasbuff("spell:26681") and not hasbuff("spell:26682") and itemcount (22143) < 5 |next "Apply_Perfume_or_Cologne_Stormwind" |or
step
Talk to non-guard NPCs
|tip Talk to NPCs who aren't guards around Stormwind who have hearts over their heads.
|tip If you run out of Love Tokens, talk to the nearest Innkeeper to purchase more.
Tell them _"Here, I'd like to give you this token of my love."_
use the Gift of Adoration: Stormwind##21981 |only if not hasbuff("spell:26680")
use the Gift of Friendship: Stormwind##22170 |only not hasbuff("spell:26680")
collect 5 Homemade Bread##22176 |goto Stormwind City 55.91,61.93 |or
'|condition not hasbuff("spell:26681") and not hasbuff("spell:26682") and itemcount (22176) < 5 |next "Apply_Perfume_or_Cologne_Stormwind" |or
step
use the Pledge of Loyalty: Stormwind##22117
collect 1 Stormwind Pledge Collection##22285
step
use the Stormwind Guard's Card##22143
collect 1 Bundle of Cards##22284
step
use the Homemade Bread##22176
collect 1 Sack of Homemade Bread##22283
step
use the Stormwind Pledge Collection##22285
collect 1 Stormwind Gift Collection##22131
step
label "Apply_Perfume_or_Cologne_Ironforge"
use the Cologne Bottle##21833
use the Perfume Bottle##21829
Apply Perfume or Cologne |condition hasbuff("spell:26681") or hasbuff("spell:26682")
|tip Perfume allows you to give Love Tokens to male NPCs.
|tip Cologne allows you to give Love Tokens to female NPCs.
step
Talk to Ironforge guard NPCs
|tip Talk to guards around Ironforge who have hearts over their heads.
|tip If you run out of Love Tokens, talk to the nearest Innkeeper to purchase more.
|tip Nearly all Ironforge guards are male, so Perfume works best for this.
Tell them _"Here, I'd like to give you this token of my love."_
use the Pledge of Adoration: Ironforge##22154
use the Pledge of Friendship: Ironforge##22160
collect 5 Pledge of Loyalty: Ironforge##22119 |goto Ironforge 30.63,66.72 |or
'|condition not hasbuff("spell:26681") and not hasbuff("spell:26682") and itemcount (22119) < 5 |next "Apply_Perfume_or_Cologne_Ironforge" |or
step
Talk to Ironforge guard NPCs
|tip Talk to guards around Ironforge who have hearts over their heads.
|tip If you run out of Love Tokens, talk to the nearest Innkeeper to purchase more.
|tip Nearly all Ironforge guards are male, so Perfume works best for this.
Tell them _"Here, I'd like to give you this token of my love."_
use the Pledge of Adoration: Ironforge##22154
use the Pledge of Friendship: Ironforge##22160
collect 5 Ironforge Guard's Card##22141 |goto Ironforge 30.63,66.72 |or
'|condition not hasbuff("spell:26681") and not hasbuff("spell:26682") and itemcount (22141) < 5 |next "Apply_Perfume_or_Cologne_Ironforge" |or
step
Talk to non-guard NPCs
|tip Talk to NPCs who aren't guards around Ironforge who have hearts over their heads.
|tip If you run out of Love Tokens, talk to the nearest Innkeeper to purchase more.
Tell them _"Here, I'd like to give you this token of my love."_
use the Gift of Adoration: Ironforge##21980
use the Gift of Friendship: Ironforge##22168
collect 5 Dwarven Homebrew##22173 |goto Ironforge 30.63,66.72 |or
'|condition not hasbuff("spell:26681") and not hasbuff("spell:26682") and itemcount (22173) < 5 |next "Apply_Perfume_or_Cologne_Ironforge" |or
step
use the Pledge of Loyalty: Ironforge##22119
collect 1 Ironforge Pledge Collection##22286
step
use the Ironforge Guard's Card##22141
collect 1 Parcel of Cards##22287
step
use the Dwarven Homebrew##22173
collect 1 Case of Homebrew##22288
step
use the Ironforge Pledge Collection##22286
collect 1 Ironforge Gift Collection##22132
step
label "Apply_Perfume_or_Cologne_Darnassus"
use the Cologne Bottle##21833
use the Perfume Bottle##21829
Apply Perfume or Cologne |condition hasbuff("spell:26681") or hasbuff("spell:26682")
|tip Perfume allows you to give Love Tokens to male NPCs.
|tip Cologne allows you to give Love Tokens to female NPCs.
step
Talk to Darnassus guard NPCs
|tip Talk to guards around Darnassus who have hearts over their heads.
|tip If you run out of Love Tokens, talk to the nearest Innkeeper to purchase more.
|tip Nearly all Darnassus guards are female, so Cologne works best for this.
Tell them _"Here, I'd like to give you this token of my love."_
use the Pledge of Adoration: Darnassus##22155
use the Pledge of Friendship: Darnassus##22159
collect 5 Pledge of Loyalty: Darnassus##22120 |goto Darnassus 43.11,41.20 |or
'|condition not hasbuff("spell:26681") and not hasbuff("spell:26682") and itemcount (22120) < 5 |next "Apply_Perfume_or_Cologne_Darnassus" |or
step
Talk to Darnassus guard NPCs
|tip Talk to guards around Darnassus who have hearts over their heads.
|tip If you run out of Love Tokens, talk to the nearest Innkeeper to purchase more.
|tip Nearly all Darnassus guards are female, so Cologne works best for this.
Tell them _"Here, I'd like to give you this token of my love."_
use the Pledge of Adoration: Darnassus##22155
use the Pledge of Friendship: Darnassus##22159
collect 5 Sentinel's Card##22140 |goto Darnassus 43.11,41.20 |or
'|condition not hasbuff("spell:26681") and not hasbuff("spell:26682") and itemcount (22140) < 5 |next "Apply_Perfume_or_Cologne_Darnassus" |or
step
Talk to non-guard NPCs
|tip Talk to NPCs who aren't guards around Darnassus who have hearts over their heads.
|tip If you run out of Love Tokens, talk to the nearest Innkeeper to purchase more.
Tell them _"Here, I'd like to give you this token of my love."_
use the Gift of Adoration: Darnassus##21980
use the Gift of Friendship: Darnassus##22168
collect 5 Handmade Woodcraft##21960 |goto Darnassus 43.11,41.20 |or
'|condition not hasbuff("spell:26681") and not hasbuff("spell:26682") and itemcount (21960) < 5 |next "Apply_Perfume_or_Cologne_Darnassus" |or
step
use the Pledge of Loyalty: Darnassus##22120
collect 1 Darnassus Pledge Collection##22290
step
use the Sentinel's Card##22140
collect 1 Stack of Cards##22289
step
use the Handmade Woodcraft##21960
collect 1 Box of Woodcrafts##22291
step
use the Darnassus Pledge Collection##22290
collect 1 Darnassus Gift Collection##22133
step
use the Stormwind Gift Collection##22131
collect 1 Alliance Gift Collection##22262
step
Choose the faction leader you would like to vote for:
|tip Turning in this quest in a capital city votes for that leader.
Bolvar Fordragon |confirm |next "Bolvar_Fordragon"
Magni Bronzebeard |confirm |next "Vote_Magni_Bronzebeard"
Tyrande Whisperwind |confirm |next "Tyrande_Whisperwind"
step
label "Bolvar_Fordragon"
talk Kwee Q. Peddlefeet##16075
accept Gift Giving##8993 |goto Stormwind City 78.67,17.45 |next "Final_Step"
step
label "Vote_Magni_Bronzebeard"
talk Kwee Q. Peddlefeet##16075
accept Gift Giving##8993 |goto Ironforge 40.30,56.59 |next "Final_Step"
step
label "Tyrande_Whisperwind"
Enter the building |goto Darnassus 39.03,77.23 < 15 |walk
Run up the ramp |goto 40.49,91.59 < 15 |walk
talk Kwee Q. Peddlefeet##16075
|tip Upstairs inside the building.
accept Gift Giving##8993 |goto 38.11,80.50 |next "Final_Step"
step
label "Final_Step"
You completed the Gift Giving quest
Click Here to Complete it Again |confirm |next "Begin_Guide"
]])
