local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("DungeonACLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "CLA"
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Wailing Caverns (15-25)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Wailing Caverns",
description="This guide will walk you through the Wailing Caverns dungeon.",
lfgid=718,
},[[
step
Enter the cave |goto The Barrens 45.96,36.33 < 7 |walk
Follow the path |goto Kalimdor 51.92,55.37 < 7 |only if walking
Continue following the path |goto 51.98,55.21 < 7 |only if walking
Continue following the path |goto 51.94,54.98 < 7 |only if walking
Continue following the path |goto 52.27,54.63 < 7 |only if walking
Enter the Wailing Caverns dungeon with your group |goto 52.40,55.21 < 7 |c
step
kill Kresh##3653
|tip Kresh has no abilities, it is a simple tank and spank fight.
Click Here to Continue |confirm
step
kill Lady Anacondra##3671
|tip Interrupt her "Sleep" ability.
Click Here to Continue |confirm
step
kill Lord Cobrahn##3669
|tip After pulling, immediately kill the three Deviate Pythons before switching to Lord Cobrahn.
|tip Interrupt his "Sleep" ability.
Click Here to Continue |confirm
step
kill Lord Pythas##3670
|tip Interrupt his "Sleep" ability.
|tip After pulling, CC the Druid of the Fang and kill the other add before switching to Pythas.
Click Here to Continue |confirm
step
kill Skum##3674
|tip "Chained Bolt" does damage to players near each other so melee DPS should spread out around the boss to avoid damage.
Click Here to Continue |confirm
step
kill Lord Serpentis##3673
|tip Interrupt his "Sleep" ability.
Click Here to Continue |confirm
step
kill Verdan the Everliving##5775
|tip "Grasping Vines" roots all players within 10 yards, knocks them down and does damage so the healer should try to keep the group's health topped off as much as possible.
Click Here to Continue |confirm
step
kill Mutanus the Devourer##3654
|tip Mutanus is spawned during an optional dungeon event that can occur if the four Lords of the Fang bosses have been defeated.
|tip These four bosses include Lady Anacondra, Lord Cobrahn, Lord Pythas and Lord Serpentis.
|tip The event is started by escorting the Disciple of Naralex through the dungeon.
|tip The Disciple of Naralex is found at the start of the dungeon.
|tip Once the Disciple reaches the ritual stone where Naralex sleeps, you will be attacked by waves of enemies.
|tip Mutanus' "Thunderclap" ability does high damage to the tank and any nearby melee DPS so ranged DPS is better for this fight.
|tip He also has two abilities, "Terrify" and "Naralex's Nightmare" that both stun/sleep players so the healer should try to keep the group's health topped off as much as possible.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Deadmines (17-26)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Deadmines",
description="This guide will walk you through the Deadmines dungeon.",
lfgid=1581,
},[[
step
Enter the building |goto Westfall 42.56,71.74 < 5 |walk
Run up the stairs |goto 43.38,71.92 < 5 |walk
Follow the path |goto 42.90,72.68 < 5 |walk
Run down the ramp |goto 43.42,72.79 < 7 |c
step
Jump down here |goto 43.28,74.14 < 5 |walk
Follow the path |goto 42.18,75.97 < 10 |walk
Follow the path up |goto 41.27,76.15 < 10 |walk
Continue following the path |goto Eastern Kingdoms 41.04,79.66 < 10 |walk
Follow the path |goto 40.99,79.79 < 10 |walk
Jump down here |goto 40.85,79.62 < 10 |walk
Enter the Deadmines dungeon with your group |goto 40.69,79.58 < 7 |c
step
kill Rhahk'Zor##644
|tip Before the encounter, you can pull the 2 Defias Watchman without drawing aggro from the boss.
|tip If you cannot do this, use CC on one archer.
|tip If you can't CC, kill the adds before the boss.
|tip Be careful of patrolling elites.
Click Here to Continue |confirm
step
kill Miner Johnson##3586
|tip This is a rare spawn boss.
|tip He will be surrounded by Defias Miners that aren't elite.
|tip Try picking them off before engaging Miner Johnson.
|tip Click the line below if the rare spawn isn't available.
Click Here to Continue |confirm
step
kill Sneed's Shredder##642
|tip Clear the entire room before engaging Sneed's Shredder.
|tip It uses an ability called "Terrify" that will cause you to run in fear.
|tip Once the Shredder is killed, Sneed will hop out and the tank will need to pick it up quickly.
|tip It will disarm the tank so give them time to get aggro.
Click Here to Continue |confirm
step
kill Gilnid##1763
|tip A Goblin Engineer will pull when you engage him.
|tip CC the engineer, or it will summing a Remote Controlled Golem, which is immune to most abilities.
|tip If the Golem is summoned focus on the engineer.
Click Here to Continue |confirm
step
kill Mr. Smite##646
|tip When you approach the plank, he will automatically engage your group.
|tip There will be two Defias Blackguard that are stealthed.
|tip They need to die before you begin damaging Mr. Smite.
|tip At 66% and 33% he will stun the group for nearly 10 seconds.
|tip At 33% he will gain the ability to stun your tank.
|tip It will be important to keep your tank healed up.
Click Here to Continue |confirm
step
kill Captain Greenskin##647
|tip CC adds next to Captain Greenskin before pulling.
|tip Start the encounter by killing the adds, CCing as many as possible.
Click Here to Continue |confirm
step
kill Edwin VanCleef##639
|tip When you begin the encounter, there will be two Defias Blackguard that break stealth.
|tip CC and kill them before attacking Edwin VanCleef.
|tip At 50% he will summon two more adds.
|tip Repeat the process from before, killing the adds.
|tip Finish the encounter after.
Click Here to Continue |confirm
step
kill Cookie##645
|tip This is a bonus boss, on a little island below.
|tip If you want to be safe, you can clear the adds below before jumping down.
|tip Interrupt "Cookie's Cooking" spell or it heals him.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Shadowfang Keep (22-30)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Shadowfang Keep",
description="This guide will walk you through the Shadowfang Keep dungeon.",
lfgid=209,
},[[
step
Follow the path up |goto Silverpine Forest 47.12,69.56 < 15 |only if walking
Continue up the path |goto 47.44,67.07 < 15 |only if walking
Cross the bridge |goto 45.63,68.32 < 15 |only if walking
Enter the Shadowfang Keep dungeon with your group |goto 44.80,67.84 < 10 |c
step
kill Rethilgore##3914
|tip This is a straight forward encounter, with his only ability being "Soul Drain"
|tip It will immobilize the target and gain health while casting it.
Click Here to Continue |confirm
step
kill Shadow Charger##3865
|tip Pulling one of the 3 horses in the stable will pull all 3.
|tip Use CC on at least one of the horses if possible as they deal high damage.
|tip Focus them down one at a time.
|tip Make sure your healer is prepared for the enounter before starting.
Click Here to Continue |confirm
step
kill Razorclaw the Butcher##3886
|tip Clear the room before starting the encounter.
|tip The fight itself is a simple enough.
Click Here to Continue |confirm
step
kill Baron Silverlaine##3887
|tip Healers will need to watch for the "Veil of Shadow" ability when it is cast.
|tip If you have a hybrid class in your group, support the healer when this ability goes off.
|tip Veil of Shadows will reduce incoming healing by 75%.
Click Here to Continue |confirm
step
kill Commander Springvale##4278
|tip This encounter starts with two adds.
|tip Start by focus DPSing the Haunted Servitor.
|tip You can either kill the Wailing Guardsman next, or have a Warlock or Hunter pet Off-tank it.
Click Here to Continue |confirm
step
kill Odo the Blindwatcher##4279
|tip This encounter starts with two adds.
|tip They have the "Disarm" and "Cleave" abilities, so be sure to keep them away from the group as a tank.
|tip You can use CC or focus DPS them down quickly.
Click Here to Continue |confirm
step
kill Deathsworn Captin##3872
|tip This is a rare spawn in the dungeon.
|tip The tank should keep this boss 10 yards away from the group to avoid the AoE Silence it uses.
Click Here to Continue |confirm
step
kill Fenrus the Devourer##4274
|tip This boss has a dot ability and is otherwise simple.
Click Here to Continue |confirm
step
kill Wolf Master Nados##3927
|tip In the he room where this encounter takes place, there are 4 adds that should be killed beforehand.
|tip During the fight, he will summon additional Worg that should be killed.
Click Here to Continue |confirm
step
kill Archmage Arugal##4275
|tip For this encounter, you will want to have ranged DPS and Healers stand at the platform you entered the room in.
|tip As the encounter progresses, Arugal will teleport around the room.
|tip His standard attack, "Shadow Bolt" hits very hard.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\The Stockades (22-30)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\The Stockade",
description="This guide will walk you through The Stockades dungeon.",
lfgid=717,
},[[
step
Enter the building |goto Stormwind City 42.21,58.80 < 10 |walk
Enter The Stockades dungeon with your group |goto 39.79,54.22 < 10 |c
step
kill Targorr the Dread##1696
|tip There will be Defias enemies surrounding him in the room.
|tip Use CC on the Defias before the encounter.
|tip DPS should focus on the adds before engaging Targorr the Dread.
|tip Finish off the CC'd adds after killing the boss.
Click Here to Continue |confirm
step
kill Kam Deepfury##1666
|tip There will be Defias enemies surrounding him in the room.
|tip Use CC on the Defias before the encounter.
|tip DPS should focus on the adds before engaging Kam Deepfury.
|tip Finish off the CC'd adds after killing the boss.
Click Here to Continue |confirm
step
kill Hamhock##1717
|tip There will be two Defias enemies along side Hamhock.
|tip Use CC on them if possible before starting the enounter.
|tip All DPS should focus on killing a single add at a time before switching to Hamhock.
|tip Hamhock will cast "Chain Lightning" which will deal heavy damage to bunched up allies, so spread out as best as possible.
Click Here to Continue |confirm
step
kill Bazil Thredd##1716
|tip It will be important to keep the tank topped off during this encounter.
|tip His "Smoke Bomb" ability will stun the group for 4 seconds upon use.
|tip Bazil Thredd deals high amounts of single target damage.
Click Here to Continue |confirm
step
kill Dextren Ward##1663
|tip His "Intimidating Shout" ability will cause your group to run in fear.
|tip It is important to clear any area around him before engaging.
|tip If you pull extra adds during the fear, be sure to use CC abilities on them as best you can.
|tip DPS should focus down Dextren Ward as soon as possible.
Click Here to Continue |confirm
step
kill Bruegal Ironknuckle##1720
|tip This is a Rare Spawn boss that isn't always available.
|tip Clear adds before engaging him and kill the boss.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackfathom Deeps (24-32)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Blackfathom Deeps",
description="This guide will walk you through the Blackfathom Deeps dungeon.",
lfgid=719,
},[[
step
Follow the path |goto Ashenvale 14.11,14.87 < 15 |only if walking
Jump down into the water |goto Kalimdor 43.97,35.37 < 20 |walk
Enter the underwater cave |goto 43.94,35.27 < 7 |walk
Follow the path |goto 43.82,35.14 < 7 |walk
Continue following the path |goto 43.94,34.87 < 7 |walk
Continue following the path |goto 43.90,34.59 < 7 |walk
Follow the path |goto 44.00,34.56 < 7 |c
step
Follow the path up |goto 44.09,34.77 < 7 |walk
Continue following the path |goto 44.35,34.96 < 7 |walk
Enter the Blackfathom Deeps dungeon with your group |goto 44.35,34.86 < 5 |c
step
kill Ghamoo-ra##4887
|tip Ghamoo-ra has high armor so melee damage will be significantly reduced.
|tip Spread out as best as possible to avoid taking damage from "Trample".
Click Here to Continue |confirm
step
kill Lady Sarevess##4831
|tip Lady Sarevess will be patrolling a cave with 2 other Naga.
|tip It's recommended that you kill them before engaging her.
|tip Use CC abilities on her two bodyguards that accompany her.
|tip Kill the adds before starting DPS on her.
Click Here to Continue |confirm
step
kill Gelihast##6243
|tip Before starting the encounter, clear the room of the Murlocs.
|tip Be careful not to pull them with the boss while clearing them out.
|tip Once the room is clear of adds, kill Gelihast.
Click Here to Continue |confirm
step
kill Twilight Lord Kelris##4832
|tip Kelris will cast the "Sleep" ability on a random party member.
|tip The healer should keep the tank topped off in case they get slept.
|tip If there is a hybrid class in the group and the healer is slept, you may need to assist.
Click Here to Continue |confirm
step
kill Old Serra'kis##4830
|tip This is an optional encounter.
|tip It takes place underwater.
|tip Keep your eye out for air vents underwater.
Click Here to Continue |confirm
step
kill Aku'mai##4829
|tip Aku'mai deals high damage to a single target during "Frenzied Rage".
|tip This ability lasts for 15 seconds.
|tip High healing will be required for these phases.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Gnomeregan (29-38)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Gnomeregan",
description="This guide will walk you through the Gnomeregan dungeon.",
lfgid=721,
},[[
step
Enter the building |goto Dun Morogh 24.35,39.78 < 7 |walk
Run down the ramp |goto Eastern Kingdoms 43.45,53.80 < 7 |walk
Go down the elevator |goto 43.61,53.82 < 7 |c
step
Run up the ramp |goto 43.40,53.73 < 7 |only if walking
Follow the path |goto 43.20,53.37 < 15 |only if walking
Enter the Gnomeregan dungeon with your group |goto 42.81,53.82 < 5 |c
step
kill Grubbis##7361
|tip This boss spawns from an event started by "Blastmaster Emi Shortfuse".
|tip She will trigger an explosive tha twill cause mobs to spawn from a cave.
|tip Grubbis will eventually spawn.
Click Here to Continue |confirm
step
kill Viscous Fallout##7079
|tip Before engaging in this encounter, it is recommended that you clear the trash in the room.
|tip After that, the fight itself is simple.
Click Here to Continue |confirm
step
kill Electrocutioner 6000##6235
|tip This encounter is standard.
|tip DPS the boss down and move on.
Click Here to Continue |confirm
step
kill Crowd Pummeler 9-60##6229
|tip For this encounter, place the groups back against the wall to avoid being knocked off the ledge.
Click Here to Continue |confirm
step
kill Dark Iron Ambassador##6228
|tip This is a Rare Spawn boss that isn't always available.
|tip This is a standard boss fight.
|tip Click the line below to continue.
Click Here to Continue |confirm
step
kill Mekgineer Thermaplugg##7800
|tip For this encounter, the DPS in the group should focus down "Walking Bombs" as they close in on the group.
|tip Other than that, kill Thermaplugg in between them.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Razorfen Kraul (30-40)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Razorfen Kraul",
description="This guide will walk you through the Razorfen Kraul dungeon.",
lfgid=491,
},[[
step
Follow the path |goto The Barrens 43.87,90.11 < 15 |only if walking
Enter the Razorfen Kraul dungeon with your group |goto 50.90,70.36 < 10 |c
step
kill Aggem Thorncurse##4424
|tip During the encounter, he will summon a boar.
|tip DPS should focus target the boar down then switch back to the boss.
Click Here to Continue |confirm
step
kill Death Speaker Jargba##4428
|tip For this encounter, he will be assisted by two caster allies.
|tip It is important to use CC abilities on them before starting the encounter.
|tip DPS should focus down the adds before switching to the boss.
|tip Death Speaker Jargba will use the "Dominate Mind" ability which will Mind Control a party member.
|tip Save all cooldowns for the boss.
Click Here to Continue |confirm
step
kill Overlord Ramtusk##4420
|tip Overlord Ramtusk deals high single target damage.
|tip He has two allies that should be CC'd.
|tip CC should be focused on the Spearhides if possible.
|tip Kill Ramtusk then the adds after.
Click Here to Continue |confirm
step
kill Agathelos the Raging##4422
|tip Agathelos the Raging deals massive single target damage.
|tip You might need back up heals if the healer can't keep up.
Click Here to Continue |confirm
step
kill Blind Hunter##4425
|tip This is a Rare Spawn boss that isn't always available.
|tip Have the casters stop casting when Blind Hunter is using it's "Sonic Boom" ability.
|tip Click the line below if the boss isn't there.
Click Here to Continue |confirm
step
kill Earthcaller Halmgar##4842
|tip Clear the platform before engaging then pull the boss.
|tip Kill the totem he summons as soon as they appear.
|tip If you have a Warlock, you can banish the elemental.
Click Here to Continue |confirm
step
kill Charlga Razorflank##4421
|tip Charlga Razorflank deals high damage.
|tip Pull them down fromt he hut and tank them at the platform below.
|tip The group should spread out if possible.
|tip Interrupt the "Chain Bolt" ability whenever it's being cast.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery (Graveyard) (29-35)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through the Scarlet Monastery (Graveyard) dungeon.",
lfgid=798,
},[[
step
Follow the path up |goto Tirisfal Glades 81.39,41.13 < 15 |only if walking
Follow the path |goto 81.39,39.57 < 15 |only if walking
Continue following the path |goto 82.28,37.86 < 15 |only if walking
Enter the building |goto Scarlet Monastery 47.43,19.74 < 10 |c
step
Run up the stairs |goto Scarlet Monastery 47.45,19.69 < 10 |walk
Follow the path |goto 74.88,23.51 < 10 |walk
Enter the Scarlet Monastery - Graveyard dungeon with your group |goto 74.95,23.41 < 5 |c
step
kill Interrogator Vishas##3983
|tip Clear the area before engaging Interrogator Vishas.
|tip He will use "Immolate" throughout the fight, so be ready for extra healing.
Click Here to Continue |confirm
step
kill Bloodmage Thalnos##4543
|tip For this encounter, ranged DPS should spread out to avoid taking damage from AoE attacks.
Click Here to Continue |confirm
step
kill Azshir the Sleepless##6490
|tip This is a Rare Spawn boss that isn't always available.
|tip If you see an "Unfettered Spirit", you will be able to spawn this boss.
|tip There are 6 different spawn points across the Graveyard that appear in intervals of 10 to 15 minutes.
|tip Every 10 to 15 minutes, instead of an Unfettered Spirit, Azshir the Sleepless has a chance to spawn.
|tip It will use the "Terrify" ability which will fear the group.
|tip It will also use an ability called "Call of the Grave" which will damage an ally even after the boss is dead.
Click Here to Continue |confirm
step
kill Fallen Champion##6488
|tip This is a Rare Spawn boss that isn't always available.
|tip If you see an "Unfettered Spirit", you will be able to spawn this boss.
|tip There are 6 different spawn points across the Graveyard that appear in intervals of 10 to 15 minutes.
|tip Every 10 to 15 minutes, instead of an Unfettered Spirit, Azshir the Sleepless has a chance to spawn.
|tip The Fallen Champion only uses melee abilities, including "Cleave" so spread out when possible.
Click Here to Continue |confirm
step
kill Ironspine##6489
|tip This is a Rare Spawn boss that isn't always available.
|tip If you see an "Unfettered Spirit", you will be able to spawn this boss.
|tip There are 6 different spawn points across the Graveyard that appear in intervals of 10 to 15 minutes.
|tip Every 10 to 15 minutes, instead of an Unfettered Spirit, Azshir the Sleepless has a chance to spawn.
|tip Ironspine will use the ability "Poison Cloud" so spread out to avoid it.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery (Library) (31-37)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through the Scarlet Monastery (Library) dungeon.",
lfgid=799,
},[[
step
Follow the path up |goto Tirisfal Glades 81.39,41.13 < 15 |only if walking
Follow the path |goto 81.39,39.57 < 15 |only if walking
Continue following the path |goto 82.28,37.86 < 15 |only if walking
Enter the building |goto Scarlet Monastery 47.43,19.74 < 10 |c
step
Run up the stairs |goto Scarlet Monastery 47.45,19.69 < 10 |walk
Follow the path |goto 74.89,23.58 < 10 |walk
Enter the Scarlet Monastery - Library dungeon with your group |goto 75.00,23.58 < 5 |c
step
kill Houndmaster Loksey##3974
|tip For this encounter, Loksey will be accompanied by 3 elite Scarlet Tracking Hounds.
|tip They will need to either be CC'd or killed immidiately.
|tip Once the hounds are dealt with, kill Houndmaster Loksey.
Click Here to Continue |confirm
step
kill Arcanist Doan##6487
|tip For this encounter, he will cast "Detonation" which will damage the entire group.
|tip When he does this, use the pillars to line of sight the ability.
|tip This fight is very healing intensive, so if you have a hybrid class, additional healing may be required.
|tip He will also cast "Silence" on casters.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery (Armory) (35-40)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through the Scarlet Monastery (Armory) dungeon.",
lfgid=796,
},[[
step
Follow the path up |goto Tirisfal Glades 81.39,41.13 < 15 |only if walking
Follow the path |goto 81.39,39.57 < 15 |only if walking
Continue following the path |goto 82.28,37.86 < 15 |only if walking
Enter the building |goto Scarlet Monastery 47.43,19.74 < 10 |c
step
Run up the stairs |goto Scarlet Monastery 47.45,19.69 < 10 |walk
Follow the path |goto 74.89,23.58 < 10 |walk
click Armory Door
|tip You will need to collect "The Scarlet Key" from the Scarlet Monastery - Library dungeon to open this.
|tip Additionally, a rogue with leveled "Lockpicking" skill can open the door.
Enter the doorway |goto 75.01,23.51 < 5 |walk
Enter the Scarlet Monastery - Armory dungeon with your group |goto 75.03,23.52 < 5 |c
step
kill Herod##3975
|tip The tank should keep Herod at the center of the room.
|tip He will use the "Whirlwind" ability, he will become immune to magic damage.
|tip Anyone at the center of the room should move from it to avoid getting hit by it, including the tank.
|tip Casters should stay on the ledge above at all times.
|tip When Herod dies, a group of non-elites will rush the room.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery (Cathedral) (36-42)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through the Scarlet Monastery (Cathedral) dungeon.",
lfgid=797,
},[[
step
ding 40
step
Follow the path up |goto Tirisfal Glades 81.39,41.13 < 15 |only if walking
Follow the path |goto 81.39,39.57 < 15 |only if walking
Continue following the path |goto 82.28,37.86 < 15 |only if walking
Enter the building |goto Scarlet Monastery 47.43,19.74 < 10 |c
step
Run up the stairs |goto Scarlet Monastery 47.45,19.69 < 10 |walk
Follow the path |goto 74.88,23.51 < 10 |walk
click Cathedral Door
|tip You will need to collect "The Scarlet Key" from the Scarlet Monastery - Library dungeon to open this.
|tip Additionally, a rogue with leveled "Lockpicking" skill can open the door.
Enter the doorway |goto 74.99,23.44 < 5 |walk
Enter the Scarlet Monastery - Cathedral dungeon with your group |goto 75.00,23.41 < 5 |c
step
kill Scarlet Commander Mograine##3976
|tip Clear the Cathedral before starting this encounter.
|tip He will use the ability "Hammer of Justice" which will stun the target for 3 seconds.
|tip He will use the "Divine Shield" ability, which will make him invulnerable to all damage.
Click Here to Continue |confirm
step
kill High Inquisitor Whitemane##3977
|tip She will primarily cast "Holy Smite", dealing magic damage to the tank.
|tip When she is near death, she will sleep the entire party and revive Mograine.
|tip Both of their health bars will return to full adn the tank will need to pick up Mograine immidiately.
|tip DPS should focus on Whitemane, then Mograine.
Click Here to Continue |confirm
step
kill High Inquisitor Fairbanks##4542
|tip He will cast "Curse of Blood" on a party member, which can be dispelled by a mage or a druid.
|tip He will also use "Fear" and "Sleep" on random party members.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Razorfen Downs (37-43)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Razorfen Downs",
description="This guide will walk you through the Razorfen Downs dungeon.",
lfgid=722,
},[[
step
Follow the path |goto The Barrens 44.92,88.93 < 15 |only if walking
Continue following the path |goto 46.56,91.38 < 15 |only if walking
Continue following the path |goto The Barrens 47.41,92.89 < 15 |only if walking
Enter the tunnel |goto The Barrens 48.97,93.83 < 10 |only if walking
Follow the path |goto Razorfen Downs 52.89,71.03 < 10 |only if walking
Enter the Razorfen Downs dungeon with your group |goto Razorfen Downs 53.25,71.17 |only if walking
step
kill Tuten'kash##7355
|tip Clear the room and ring the gong to begin the encounter.
|tip After each wave, you will need to ring the gong again until the boss appears.
|tip The tank should face the boss away from the group when it spawns.
|tip It's "Web Spray" ability will immobilize any ally in front of it.
Click Here to Continue |confirm
step
kill Mordresh Fire Eye##7357
|tip Before engaging, clear the enemies around Mordresh.
|tip The last pack of skeletons will draw the aggro of the boss.
|tip This boss is vulnerable to melee damage.
|tip Be sure to interrupt the "Fireball" ability.
Click Here to Continue |confirm
step
kill Glutton##8567
|tip Have the tank move out of it's "Disease Cloud" ability.
|tip Heavy heals will be needed when Glutton enrages.
Click Here to Continue |confirm
step
kill Ragglesnout##7354
|tip This is a Rare Spawn boss that isn't always available.
|tip He will use "Dominate Mind" on a random group member, including the tank or healer.
|tip It'll be important to have a back up healer or tank in case this happens.
|tip Interrupt his "Heal" ability when possible.
Click Here to Continue |confirm
step
kill Amnennar the Coldbringer##7358
|tip The tank should tank him facing the tent where he's at.
|tip The group should then stack on top of the tank to reduce damage from "Frost Nova".
|tip He will summon "Frost Spectres".
|tip As soon as one appears, the damage should switch and kill it quickly.
Click Here to Continue |confirm
step
kill Plaguemaw the Rotting##7356
|tip This is an optional fight.
|tip Speak with Belnistrasz to start the event.
|tip Waves of enemies will spawn and may require additional off tanks.
|tip When Belnistrasz is finished channeling, Plaguemaw the Rotting will spawn.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Uldaman (42-52)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Uldaman",
description="This guide will walk you through the Uldaman dungeon.",
lfgid=1337,
},[[
step
Enter the Uldaman Dungeon with your group
Click Here to Continue |confirm
step
kill Revelosh##6910
|tip Use Crowd Control abilities on the 2 Stonevault Rockcheres if possible.
|tip If you have no Crowd Control, burn them down before the boss.
|tip Interrupt his "Chain Lightning" ability when possible.
Click Here to Continue |confirm
step
kill Ironaya##7228
|tip She is immune to Damage Over Time effects.
|tip The tank should face her away from the rest of the group to avoid them being hit with "Arcing Smash".
|tip Range spread out.
Click Here to Continue |confirm
step
kill Obsidian Sentinel##7023
|tip This boss is immunity to Damage Over Time abilities.
|tip At 66% and 33% Health, it will spawn two Obsidian Shards.
|tip DPS should switch to killing these before going back to the boss.
Click Here to Continue |confirm
step
kill Ancient Stone Keeper##7206
|tip This boss has immunity to Damage Over Time abilities.
|tip It also casts the ability "Sand Storms", which will cast Slow and Silence on those caught in it.
|tip Range spread out.
Click Here to Continue |confirm
step
kill Galgann Firehammer##7291
|tip He will be accompanied by Shadowforge Geologists.
|tip Heavy AoE damage will be inflicted upon your group.
|tip The Tank should pick up Galgann Firehammer and move him away from the Shadowforge Geologist.
|tip Keep him faced away from the group.
|tip Use Crowd Control abilities on one Shadowforge Geologist, then kill the other.
|tip After, then kill the last Shadowforge Geologist.
|tip Then, switch to Galgann and kill him.
Click Here to Continue |confirm
step
kill Grimlok##4854
|tip He is accompanied by a Stonevault Geomancer, Stonevault Brawler and a Jadespine Basilisk.
|tip Use a Crowd Control ability on one of the adds.
|tip Then, use all cooldowns and burn down Grimlok as fast as possible.
|tip After, deal with the adds.
Click Here to Continue |confirm
step
kill Archaedas##2748
|tip He will summon adds through the encounter.
|tip When they appear, all DPS should kill them as soon as possible.
|tip The fight is long, so healers should conserve mana when possible.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Zul'Farrak (44-49)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Zul'Farrak",
description="This guide will walk you through the Zul'Farrak dungeon.",
lfgid=1176,
},[[
step
Follow the path |goto Tanaris 39.02,20.95 < 10 |only if walking
Enter the Zul'Farrak dungeon with your group |goto Tanaris 38.73,19.97 < 5 |c
step
kill Antu'sul##8127
|tip During the encounter, he will summon "Sul'lithuz Broodlings" and "Servants of Antu'sul".
|tip When they appear, all DPS should switch to the adds and kill them.
|tip He will summon various totems that should be destroyed as soon as they appear.
Click Here to Continue |confirm
step
kill Theka the Martyr##7272
|tip This is a mini boss found in the dungeon.
|tip He will cast "Fevered Plague" on group members, dealing damage over time.
|tip When he reaches 30% health, he will become immune to physical and shadow damage.
Click Here to Continue |confirm
step
kill Witch Doctor Zum'rah##7271
|tip Zum'rah will cast "Shadow Bolt Volley" which will need to be interrupted.
|tip He will also summon zombies from nearby graves that will attack you.
|tip All DPS should switch to the zombies before moving back to the boss.
|tip Whenever he summons a totem, you should also focus on those.
Click Here to Continue |confirm
step
kill Zerillis##10082
|tip Line of sight him into melee range as soon as possible.
|tip Afterwards, the fight is straight forward.
Click Here to Continue |confirm
step
kill Nekrum Gutchewer##7796
kill Shadowpriest Sezz'ziz##7275
|tip He will be accompanied by Shadowpriest Sezz'ziz.
|tip Have DPS burn down Nekrum Gutchewer before burning down Sezz'ziz.
|tip Be sure to interrupt Sezz'ziz' "Heal" ability throughout the encounter.
|tip After Nekrum has been defeated, quickly burn down Sezz'ziz.
Click Here to Continue |confirm
step
kill Sergeant Bly##7604
|tip He will be accompanied by a group of other elites.
|tip DPS should prioritize killing Murta Grimgut and Oro Eyegouge before all else.
Click Here to Continue |confirm
step
kill Chief Ukorz Sandscalp##7267
|tip Make sure the tank faces the bosses away from the group.
|tip Melee allies should damage him from behind to avoid its "Cleave" ability.
|tip Kill Ruuzlu, then Ukorz.
Click Here to Continue |confirm
step
kill Hydromancer Velratha##7795
|tip She patrols around a room filled with elite enemies.
|tip Clear as many as you can without pulling her.
|tip Once you've cleared a safe spot, pull Velratha into the hallway from where you fought Sergeant Bly.
Click Here to Continue |confirm
step
kill Gahz'rilla##7273
|tip To summon Gahz'rilla, you will need the "Sacred Mallet" that drops from Qiaga the Keeper in the Hinterlands.
|tip You will then need to use the mallet at the altar in Jintha'Alor, also found in the Hinterlands.
|tip Clear the entire room before ringing the gong with the "Mallet of Zul'Farrak".
|tip When engaging, the tank should face him away from the group.
|tip If you don't, the group will be tossed up in the air.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Maraudon (Wicked Grotto - Purple) (45-53)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Maraudon",
description="This guide will walk you through the Maraudon (Wicked Grotto - Purple) dungeon.",
lfgid=2100,
},[[
step
click Stone Door
Enter the building |goto Desolace 38.43,57.98 < 5 |walk
Jump down here |goto Desolace 38.33,58.00 < 10 |walk
Jump down here |goto 38.30,58.18 < 10 |c
step
Jump down here |goto 38.27,58.00 < 10 |walk
Follow the path down |goto 38.43,57.86 < 10 |walk
Cross the bridge |goto 38.53,57.80 < 10 |walk
Follow the path |goto 38.64,57.68 < 10 |walk
Continue following the path |goto 38.42,57.42 < 10 |walk
Enter the Maraudon - Purple dungeon with your group |goto Kalimdor 38.57,57.00 < 10 |c
step
kill Lord Vyletongue##12236
|tip Have the entire group stack on top of each other to avoid the bosses ranged abilities.
|tip He will occasionally use his "Blink" ability, causing him to move away from the group.
|tip Be sure to stack in melee range of the boss as soon as possible whenever this happens.
|tip If you have a Warlock, you can banish the one of the two adds that appear.
|tip Defeat the boss, then finish the adds.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Maraudon (Foulspore Cavern - Orange) (45-53)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Maraudon",
description="This guide will walk you through the Maraudon (Foulspore Cavern - Orange) dungeon.",
lfgid=2101,
},[[
step
Follow the path up |goto Desolace 38.49,61.12 < 15 |only if walking
Run up the stairs |goto 29.84,62.50 < 10 |only if walking
click Stone Door
Enter the building |goto Kalimdor 38.43,57.97 < 7 |c
step
Follow the path |goto 38.34,58.12 < 10 |only if walking
Run down the stairs |goto 38.25,57.99 < 10 |only if walking
Continue following the path |goto 38.45,58.14 < 10 |only if walking
Run up the stairs |goto 38.69,58.16 < 10 |only if walking
Follow the path |goto 38.84,58.34 < 10 |only if walking
Continue following the path |goto 39.10,57.99 < 7 |only if walking
Enter the Maraudon (Foulspore Cavern - Orange) dungeon with your group |goto 39.27,58.19 < 5 |c
step
kill Noxxion##13282
|tip Noxxion will use "Toxic Volley" which will deal damage to the entire group.
|tip During the fight, he will split into tiny versions of himself which need to be killed before you can resume damaging him again.
Click Here to Continue |confirm
step
kill Razorlash##
|tip Razorlash uses the "Cleave" ability, so ranged sould stand at max range to avoid additional damage to the group.
|tip It will also use the "Puncture" ability which will deal heavy damage to its target.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Maraudon (Earth Song Falls - Inner) (48-57)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Maraudon",
description="This guide will walk you through the Maraudon (Earth Song Falls - Inner) dungeon.",
lfgid=2102,
},[[
step
Follow the path up |goto Desolace 38.49,61.12 < 15 |only if walking
Run up the stairs |goto 29.84,62.50 < 10 |only if walking
click Stone Door
Enter the building |goto Kalimdor 38.43,57.97 < 7 |c
step
Follow the path |goto 38.34,58.12 < 10 |only if walking
Run down the stairs |goto 38.25,57.99 < 10 |only if walking
Continue following the path |goto 38.47,57.96 < 7 |only if walking
Continue following the path |goto 38.49,57.73 < 7 |only if walking
use Scepter of Celebras##17191
|tip This is a reward from a short quest chain given by Cavindra outside the Foulspore Cavern - Orange dungeon.
click Portal to Inner Maraudon |goto 38.45,57.81
Enter the Maraudon (Earth Song Falls - Inner) dungeon with your group |goto Maraudon 0.00,0.00 < 1000 |noway |c
step
kill Landslide##12203
|tip The tank should keep him where he spawns.
|tip The tank should also keep their back to the wall when possible.
|tip Ranged stay at a distance.
|tip Ranged will also need to avoid the "Theradrim Shardling" that spawns, which will disappear once the boss dies.
Click Here to Continue |confirm
step
kill Tinkerer Gizlock##13601
|tip The tank should face him away from the group to avoid taking damage from "Gobling Dragon Gun".
|tip After, the group should stack in close melee rang to prevent Gizlock from using his "Bomb" and "Shoot" abilities.
Click Here to Continue |confirm
step
kill Rotgrip##13596
|tip Rotgrip deals high damage, so the fight will be very heal intensive.
|tip You may need support heals.
|tip Its ability "Puncture" will deal damage over time increasing this damage.
Click Here to Continue |confirm
step
kill Princess Theradras##12201
|tip She has the ability "Repulsive Gaze" which will fear the entire group.
|tip Use "Fear Ward" on the tank if possible.
|tip Warriors ability "Berserker Rage" can negate the fear.
|tip Also, use "Tremor Totem" if possible.
|tip Ranged group members should stay at max range to avoid being knocked back by "Dust Field".
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\The Temple of Atal'Hakkar (50-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\The Temple of Atal'Hakkar",
description="This guide will walk you through The Temple of Atal'Hakkar dungeon.",
lfgid=1477,
},[[
step
Run up the stairs |goto Swamp of Sorrows 56.28,76.52 < 10 |only if walking
Enter the building |goto 56.33,76.26 < 10 |c
step
Follow the path down |goto 56.30,76.17 < 10 |walk
Swim through the water |goto 56.35,76.16 < 10 |walk
Run up the stairs |goto 56.45,75.80 < 10 |walk
Follow the path |goto 56.42,75.72 < 5 |walk
Continue following the path |goto 56.46,75.55 < 5 |walk
Run down the stairs |goto 56.51,75.57 < 5 |c
step
Follow the path |goto 56.72,75.73 < 5 |walk
Continue following the path |goto 56.90,75.89 < 10 |walk
Follow the path |goto 56.87,76.00 < 5 |walk
Continue following the path |goto 57.00,76.04 < 5 |walk
Continue following the path |goto 57.08,75.58 < 5 |c
step
Run down the stairs |goto 56.90,75.51 < 5 |walk
Follow the path |goto 56.93,75.37 < 5 |walk
Continue following the path |goto 56.81,75.32 < 5 |walk
Enter The Temple of Atal'Hakkar dungeon with your group |goto 56.81,75.17 < 5 |c
step
kill Atal'alarion##8580
|tip Clear the trash in the area as you travel around the platform.
|tip Once cleared, the group will need to spread out and click each shrine found in the room:
|tip Start with the Bottom Shrine, to the south.
|tip Then, hit the North Shrine, to the north.
|tip Next, hit the Bottom Left Shrine, to the southwest.
|tip Then, hit the Bottome Right Shrine, to the southeast.
|tip Next, hit the Top Left Shrine, to the northwest.
|tip Finally, hit the Top Right Shrine, to the northeast.
|tip The shrine will be green if done correctly and Atal'alrion will appear at the center of the room.
|tip He has a threat clearing abilitiy, so it will be important for the tank to keep taunt available.
|tip He will also knock players into the air who will take fall damage after.
|tip Healers should focus on the member who got knocked into the air as soon as they land.
|tip Tanks should keep the boss near a wall and be prepared to kite if the group healer gets knocked into the air.
Click Here to Continue |confirm
step
Kill the Atal'ai Defenders
|tip There will be 6 sub bosses you need to kill.
|tip To start, clear the Pit of Refuse of all mobs.
|tip You'll run up the stairs and reach an area similar to the shrine area for the previous boss.
|tip Instead of activating the shrines, there will be the bosses Loro, Gasher, Mijan, Zolo, Zul'lor and Hukku.
Click Here to Continue |confirm
step
kill Jammal'an the Prophet##5710
kill Ogom the Wretched##5711
|tip After defeating the Atal'ai Defenders, the way to Jammal'an will open up.
|tip Clear the trash in the Lair of the Chosen, watching out for Atal'ai Deathwalkers "Fear" abilitiy.
|tip Ghosts will spawn when some of the enemies die here, all of which you can do is kite run away from them.
|tip Engage once all enemies are clear.
|tip Separate Jammal'an and Ogum when the fight starts, killing Ogom as soon as possible.
|tip Then, spread out as best you can.
|tip Jammal'an will use the "Hex of Jammal'an" ability, transforming a party member into a hostil Berserker.
|tip Switch damage to the "Hex of Jammal'an" then burn down the boss as quick as possible.
Click Here to Continue |confirm
step
kill Dreamscythe##5721
kill Weaver##5720
|tip The tank should keep their back to the wall and keep all drakes facing away from the party.
|tip All of their abilities hit in front of it, so this will save you needless healing.
Click Here to Continue |confirm
step
kill Hazzas##5722
kill Morphaz##5719
|tip Similar to the last encounter, the tank should keep their back to the wall and keep all drakes facing away from the party.
|tip All of their abilities hit in front of it, so this will save you needless healing.
Click Here to Continue |confirm
step
kill Shade of Eranikus##5709
|tip Clear all dragon enemies before pulling this boss or they will swarm you.
|tip All ranged should stay at max distance to avoid being stunned by its "War Stomp" ability.
|tip The abilities "Fade" for Priest, "Blessing of Salvation" for Paladin and "Feint" for Rogues should be used to mitigate threat when possible.
|tip The target with the highest threat will be the target of Eranikus' "Deep Slumber" ability, which will make you unable to act for 15 seconds.
|tip Melee never stand in front of this boss.
|tip This is a long fight so side heals might be necessary.
Click Here to Continue |confirm
step
kill Avatar of Hakkar##8443
|tip Clear trash in the Sanctum of the Fallen God.
|tip This boss can only be summoned by using the "Egg of Hakkar" which is for the quest "The God Hakkar".
|tip Players whom have completed the quest can use "Yeh'kinya's Scroll" to summon as well.
|tip Once used, kill adds that spawn.
|tip Eventually, a Hakkari Bloodkeeper spawns.
|tip Collect the "Hakkari Blood" from their corpse and extinguish the Braziers in the room.
|tip Repeat the process until all are extinguished.
|tip The Avatar of Hakkar will use "Cause Insanity" on random players.
|tip CC or Stun the player if possible until it wears off.
|tip He will also use "Shadow Word: Pain" which should be dispelled when possible.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackrock Depths (52-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Blackrock Depths",
description="This guide will walk you through the Blackrock Depths dungeon.",
lfgid=1584,
},[[
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run down the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Run down the stairs |goto 48.65,64.16 < 5 |walk
Continue down the stairs |goto 48.62,64.26 < 5 |c
step
Run down the stairs |goto 48.62,64.11 < 7 |walk
Follow the path down |goto 48.68,64.07 < 7 |walk
Run down the chain |goto 48.58,64.09 < 5 |walk
Enter the building |goto 48.44,63.83 < 5 |walk
Follow the path |goto 48.15,63.34 < 15 |walk
Enter the Blackrock Depths dungeon with your group |goto 48.08,62.41 < 7 |c
step
kill High Interrogator Gerstahn##9018
|tip Her most dangerous ability is "Psychic Scream" which will fear the entire group, possibly leading to adds being pulled.
|tip "Fear Ward" and "Tremor Totem" will come in very handy during this encounter.
|tip Fight her in a corner of the room to try and control where your party runs during fear.
|tip Dispel her "Shadow Word: Pain" when applicable.
|tip Interrupt her "Mana Burn" when possible also.
|tip The "Prison Cell Key" is important to loot from her before moving on.
Click Here to Continue |confirm
step
kill Lord Roccor##9025
|tip This boss can use "Earth Shock" which will interrupt any casters spells and prevent casting for 2 seconds.
|tip It also casts "Flame Shock" which will leave a dot on a party member.
Click Here to Continue |confirm
step
kill Houndmaster Grebmar##9319
|tip Before engaging him, pull and kill the two packs of hounds patrolling the room with him.
|tip Range should keep their distance to avoid being interrupted with "Pummel".
|tip Other than that, this is a pretty straight forward encounter.
Click Here to Continue |confirm
step
Defeat the Ring of the Law
|tip There are multiple bosses that can appear in this event.
|tip Gorosh the Dervish: Spread out to avoid "Whirlwind" damage and try to heal outside of "Mortal Strike".
|tip Grizzle: Range should stay at max distance to avoid "Earth Shock".
|tip Eviscerator: If applicable, have a priest use "Shadow Protection".
|tip Ok'Thor the Breaker: He will use "Polymorph" on a random player in the group, which will need to be dispelled asap.
|tip Anub'Shiah: Dispel it's "Curse of Tongues" and "Enveloping Web" abilities immidiately.
|tip Hedrum the Creeper: Dispel the it's "Paralyzing Poison" and "Baneful Poison" when possible.
Click Here to Continue |confirm
step
kill Fineous Darkvire##9056
|tip Clear all enemies along the path he patrols before engaging.
|tip This boss hits very hard, so extra healing may be required.
|tip Be sure to interrupt his "Holy Light" as to not prolong the encounter.
|tip Ranged should keep their distance as he will interrupt you otherwise.
Click Here to Continue |confirm
step
kill Pyromancer Loregrain##9024
|tip This is an optional boss and may be skipped.
|tip Destroy his totems when they are summoned.
Click Here to Continue |confirm
step
kill Bael'Gar##9016
|tip This is an optional boss and may be skipped.
|tip He will spawn adds which need to be killed quickly.
|tip The tank will need to face him away from the group to prevent damage from "Magma Splash".
Click Here to Continue |confirm
step
kill Lord Incendius##9017
|tip The most important thing for this encounter is to not get knocked off the platform.
|tip Avoid its "Mighty Blow" ability to ensure that.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scholomance (58-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scholomance",
description="This guide will walk you through the Scholomance dungeon.",
lfgid=2057,
},[[
step
Follow the path |goto Western Plaguelands 68.60,80.11 < 15 |only if walking
Follow the path up |goto 70.39,78.17 < 15 |only if walking
Continue up the path |goto 70.72,75.45 < 15 |only if walking
Run up the stairs |goto Scholomance 52.81,26.51 < 10 |only if walking
Enter the building |goto 52.78,26.43 < 10 |walk
click Scholomance Door
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
Enter the room |goto 52.75,26.41 < 10 |walk
Enter the Scholomance dungeon with your group |goto 52.70,26.38 < 7 |c
step
kill Blood Steward of Kirtonos##14861
|tip She has 3 abilities to look out for:
|tip "Curse of Impotence" reduces magic damage output on the target and can be removed by a Mage or Druid.
|tip "Curse of Weakness" reduces the melee damage output on the target and can be removed by a Mage or Druid.
|tip "Paralyzing Poison" should be removed by a Druid, Shaman or Paladin if possible.
Click Here to Continue |confirm
step
kill Kirtonos the Herald##10506
|tip This boss is summoned by "Blood of Innocents", obtained from Blood Steward of Kirtonos, Doctor Theolen Krastinov and Jandice Barov.
|tip Use it on the porch to summon Kirtonos.
|tip The tank should keep their back to the wall to prevent knockback.
|tip While in human form, he will use various curses that can be dispelled by Mages and Druids.
|tip Once he transforms into a Gargoyle, the fight becomes very straight forward.
Click Here to Continue |confirm
step
kill Jandice Barov##10503
|tip She will use the ability "Curse of Blood" which should be dispelled by Mages and Druids.
|tip She will also summon Illusions of herself, which will need to be killed.
|tip They cannot be AoE'd so you will need to single target damage all of them.
Click Here to Continue |confirm
step
kill Rattlegore##11622
|tip Carefully clear the area around Rattlegore before engaging.
|tip He hits hard, so this fight will be healing intensive.
|tip The tank should face him away from the group.
|tip The Viewing Room Key comes from this encounter, which lets you progress further into the dungeon.
Click Here to Continue |confirm
step
kill Marduk Blackpool##10433
|tip The tank should keep Marduk stationary when possible.
|tip Range should stand far enough back to avoid being hit by Defiling Aura.
|tip When he casts "Shadow Shield", melee will take extra damage each time they hit.
Click Here to Continue |confirm
step
kill Vectus##10432
|tip Avoid standing in his "Flamestrikes" radius when cast.
Click Here to Continue |confirm
step
kill Ras Frostwhisper##10508
|tip Clear the area around him before engaging.
|tip The tank should face him away from the group.
|tip If possible, interrupt his "Fear" ability, as well as his "Frostbolt Volley".
Click Here to Continue |confirm
step
kill Instructor Malicia##10505
|tip For this encounter, it is important to interrupt her "Heal" ability.
|tip Druids and Mages should keep an eye out for "Call of the Grave" which sould be dispelled as soon as possible.
Click Here to Continue |confirm
step
kill Doctor Theolen Krastinov##11261
|tip The tank should pull Theolen and keep their back to the wall.
|tip The tank should also save defensive abilities for when the boss reaches 50% health.
|tip He will gain 50% increased attack speed at that point, making the fight healing intensive.
Click Here to Continue |confirm
step
kill Lorekeeper Polkelt##10901
|tip He should be tanked at the lower level of the room, while all ranged stay at the top level and DPS/Heal from the balcony.
|tip Anyone afflicted by "Volatile Infection" needs to move away from the rest of the party.
Click Here to Continue |confirm
step
kill The Ravenian##10507
|tip The tank should stand with their back to a wall, facing Ravenian away from the group.
|tip Melee watch out for its "Cleave" and "Sundering Cleave" ability.
Click Here to Continue |confirm
step
kill Lord Alexei Barov##10504
|tip He is accompanied by two skeleton body guards which can be CC'd with either a Priests "Shackle Undead" or a Paladins "Turn Undead".
|tip In the room, there is green liquid on the ground which the group must stay out of.
|tip The tank must bull Alexei to max range from range so they don't take damage from "Unholy Aura".
|tip Mages and Druids must dispel "Veil of Shadow" when a party member is afflicted with it.
Click Here to Continue |confirm
step
kill Lady Illucia Barov##10502
|tip She used the "Dominate Mind" ability on random party members.
|tip Use CC abilities on them when it happens.
|tip Clear the entire room to avoid pulling adds from her "Fear" ability.
|tip She also uses the "Silence" ability, which will disable nearby casters from using spells.
Click Here to Continue |confirm
step
kill Darkmaster Gandling##1853
|tip The tank should keep him where he spawns if possible, while ranged stay stay at the top of the stairs.
|tip During the encounter, he will teleport a random player to one of the rooms where previous bosses were.
|tip That player will be locked in until the kill all enemies inside.
|tip This includes the tank!
|tip If the tank is teleported, you will need to kit the boss around the room until they are out.
|tip Interrupt "Arcane Missile" on rotation.
|tip Mages and Druids should dispel "Improved Shadow Bolt" as soon as possible.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Stratholme - Live (58-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Stratholme",
description="This guide will walk you through the Stratholme - Live dungeon.",
lfgid=2017,
},[[
step
Cross the bridge |goto Eastern Plaguelands 30.85,20.48 < 15 |only if walking
Enter the Stratholme - Live dungeon with your group |goto Eastern Kingdoms 55.12,17.36 < 5 |c
step
click Mailbox
|tip Take the contents from the mailbox to summon.
kill Fras Siabi##11058
|tip Spread out as best you can to avoid being hit by "Flame Breath".
|tip He will use "Smoke Bomb" which will stun anybody caught by it.
Click Here to Continue |confirm
step
kill Skul##10393
|tip This is a Rare Spawn boss that isn't always available.
|tip There are two spots he can spawn; Just before Fras Siabi and on the east portion of the map.
|tip Interrup its spells when possible.
Click Here to Continue |confirm
step
kill Hearthsinger Forresten##10558
|tip This is a Rare Spawn boss that isn't always available.
|tip He can spawn after the rat gate.
|tip Spread out a little to avoid being hit with "Multi-Shot".
|tip He will randomly cast "Enchanting Lullaby" on a random player.
Click Here to Continue |confirm
step
kill The Unforgiven##10516
|tip This boss spawns as you walk through the gate at the opposite end to where Timmy the Cruel is.
|tip Be sure your health and mana are healed up before passing through the gate.
|tip He will have non elite adds along with him.
Click Here to Continue |confirm
step
kill Postmaster Malown##11143
|tip To summon this boss, kill "Stratholme Couriers" found throughout the instance.
|tip Collect 3 the "Market Row Postbox Key".
|tip Next, find and open 3 of the locked Mailboxes.
|tip on the 3rd, Malown will spawn close to where Fras Siabi was.
|tip If you haven't already, clear the area to avoid pulling adds during "Fear".
|tip Mages and Druids should dispel "Curse of Tongues" when possible.
Click Here to Continue |confirm
step
kill Timmy the Cruel##10808
|tip He will heal while using "Ravenous Claw", but other than that the fight is straight forward.
Click Here to Continue |confirm
step
kill Malor the Zealous##11032
|tip During the fight, he will use the "Lay on Hands" ability which will heal him significantly.
|tip The chest behind him contains the "Medallion of Faith" for the quest The Medallion of Faith.
Click Here to Continue |confirm
step
click Blacksmithing Plans
|tip They are on the floor near boxes in the room.
kill Cannon Master Willey##10997
|tip He has no special abilities to account for.
Click Here to Continue |confirm
step
kill Crimson Hammersmith##11120
|tip
Click Here to Continue |confirm
step
kill Archivist Galford##10811
|tip His ability "Burning Winds" is a high damage DoT that will make this fight healing intensive.
|tip If the tank is hit with the ability, the Galford may swap targets.
Click Here to Continue |confirm
step
kill Balnazzar##10813
|tip He uses the "Domination" ability on random players in the group.
|tip Use CC on them to mitigate any damage they might do to the part.
|tip Casters should stand at max range to avoid being feared.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Stratholme - Undead (58-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Stratholme",
description="This guide will walk you through the Stratholme dungeon.",
lfgid=2018,
},[[
step
Follow the path |goto Eastern Plaguelands 47.90,31.58 < 15 |only if walking
click Elders' Square Service Gate
|tip This requires the Key to the City, which drops from Magistrate barthilas in Stratholme - Live.
Enter the gate |goto 47.86,23.87 < 7
Enter the Stratholme - Undead dungeon with your group |goto 48.23,21.88 < 5 |c
step
kill Magistrate Barthilas##10435
|tip The tank should keep their back to the wall.
|tip He uses the "Mighty Blow" ability which will knockback the tank.
Click Here to Continue |confirm
step
kill Stonespine##10809
|tip This is a Rare Spawn boss that isn't always available.
|tip It uses the "Vicious Rend" ability which will inflict heavy damage to the target.
Click Here to Continue |confirm
step
kill Nerub'enkan##10437
|tip During the fight, it will summon "Crypt Scarabs" which will need to be AoE'd down.
|tip It also uses "Pierce Armor" on the tank.
|tip When this happens, the tank should use damage mitigating abilities.
Click Here to Continue |confirm
step
kill Baroness Anastari##10436
|tip She will use the "Possess" ability which will mind control a random party member.
|tip To break the Possess, you will need to damage the target to 50% health.
|tip "Banshee Curse" should be dispelled by Mages and Druids.
|tip She will also use the "Silence" ability randomly throughout the encounter.
Click Here to Continue |confirm
step
kill Maleki the Pallid##10438
|tip He uses the ability "Ice Tomb" which most of the time will target the tank.
|tip DPS should slow when this happen so they don't pull aggro.
Click Here to Continue |confirm
step
kill Ramstein the Gorger##10439
|tip Clear the room before engaging the boss.
|tip Tank him with your back when possible.
Click Here to Continue |confirm
step
kill Baron Rivendare##10440
|tip The tank should pull him to the right side of the room.
|tip Ranged should stand atop the bone piles located throughout the room.
|tip Melee stack up behind the boss to avoid the "Cleave" ability.
|tip When the adds spawn, dps should focus them down before going back to the boss.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul East (58-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Dire Maul",
description="This guide will walk you through the Dire Maul - East dungeon.",
lfgid=2557,
},[[
step
Run up the ramp |goto Feralas 59.14,45.02 < 10 |only if walking
Follow the path |goto 59.51,39.40 < 15 |only if walking
Continue following the path |goto 61.99,37.10 < 10 |only if walking
Enter the tunnel |goto 65.50,35.24 < 5 |walk
Enter the Dire Maul - East dungeon with your group |goto Kalimdor 44.27,68.40 < 5 |c
step
kill Pusillin##14354
|tip He drops the "Crescent Key" which is needed for progression in the dungeon.
|tip To start, engaging him will cause 4 Wildspawn Imps to spawn.
|tip AoE them down as quickly as possible.
|tip Interrupt his "Fireball" ability when possible.
|tip When he has the "Spirit of Runn Tum" buff, he has a 50% chance to reflect spells back to casters.
Click Here to Continue |confirm
step
kill Lethtendris##14327
|tip Interrupt her "Void Bolt" when possible.
|tip Mages and Druids should dispel "Curse of Tongues" and "Curse of Thorns" when group members are afflicted.
|tip Kill her imp, Pimgib, then her after.
Click Here to Continue |confirm
step
kill Hydrospawn##13280
|tip Kill the Hydrolings that spawn before focusing on the boss.
Click Here to Continue |confirm
step
kill Zevrim Thornhoof##11490
|tip During the encounter, he will teleport random group members to his ritual and cast "Sacrifice" on them.
|tip The target will need big heals to survive.
|tip He will also use an AoE ability "Shadow Word: Pain" which should be dispelled as quickly as possible.
Click Here to Continue |confirm
step
kill Alzzin the Wildshaper##11492
|tip Clear all mobs as you go down the ramp, or they will aggro as adds when you begin the encounter.
|tip During the encounter, Alzzin will shapeshift, dropping all established aggro.
|tip Give the tank time to establish aggro before resuming DPS.
|tip Cleanse the "Wither" spell he casts when possible.
|tip When he casts "Wither" it can also be interrupted.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul North (58-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Dire Maul",
description="This guide will walk you through the Dire Maul - North dungeon.",
lfgid=2558,
},[[
step
Run up the ramp |goto Feralas 59.14,45.02 < 10 |only if walking
Follow the path |goto 59.51,39.40 < 15 |only if walking
Enter the tunnel |goto 62.81,34.89 < 7 |only if walking
Run up the ramp |goto Kalimdor 43.32,66.69 < 20 |only if walking
click Door
|tip You need a Crescent Key to unlock this door.
|tip This drops from Pusillin in the "Dire Maul - East" dungeon.
Enter the tunnel |goto 43.39,66.52 < 5 |only if walking
Enter the Dire Maul - North dungeon with your group |goto 43.45,66.52 < 5 |c
step
kill Guard Mol'dar##14326
|tip Ranged should keep at a distance to avoid his "Knock Away" and "Shield Charge" abilities.
Click Here to Continue |confirm
step
kill Stomper Kreeg##14322
|tip His main ability is "Booze Spit" which will reduce the groups accuracy by 75%.
Click Here to Continue |confirm
step
kill Guard Fengus##14321
|tip Like Mol'dar, ranged should keep a distance to avoid being hit by "Knock Away" and "Shield Charge".
Click Here to Continue |confirm
step
kill Guard Slip'kik##14323
|tip Like Mol'dar, ranged should keep a distance to avoid being hit by "Knock Away" and "Shield Charge".
Click Here to Continue |confirm
step
kill Captain Kromcrush##14325
|tip He hits hard so the fight will be healing intensive.
|tip He uses the ability "Intimidating Shout" which will fear your group, so clear the room.
|tip At 50% Health he summons 2 Gordok Reavers, which should be CC'd.
|tip Casters stay at max range of the boss.
Click Here to Continue |confirm
step
kill Cho'Rush the Observer##14324
kill King Gordok##11501
|tip DPS should focus on killing Cho'Rush first.
|tip Keep an eye out for King Gordok's "Heal" ability and interrupt it when possible.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul West (58-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Dire Maul",
description="This guide will walk you through the Dire Maul - West dungeon.",
lfgid=2559,
},[[
step
Run up the ramp |goto Feralas 42.75,70.26 < 10 |only if walking
Follow the path |goto 42.77,69.24 < 15 |only if walking
Continue following the path |goto 43.29,69.17 < 10 |only if walking
Continue following the path |goto 43.30,68.63 < 10 |only if walking
Follow the path |goto 43.48,68.52 < 10 |c
step
Run down the ramp |goto 43.31,68.32 < 10 |only if walking
Follow the path |goto 43.14,68.10 < 10 |only if walking
Run up the ramp |goto 43.11,67.66 < 10 |only if walking
click Door
|tip This drops from Pusillin in the "Dire Maul - East" dungeon.
Enter the door |goto 42.98,67.51 < 10 |walk
Enter the Dire Maul - West dungeon with your group |goto 42.98,67.45 < 7 |c
step
kill Tendris Warpwood##11489
|tip Clear all ancients in the area before engaging Tendris.
|tip Melee should move away when it uses the "Trample" ability.
|tip Range stand at max distance to avoid being hit with "Entangle".
Click Here to Continue |confirm
step
kill Magister Kalendris##11487
|tip Dispel "Shadow Word: Pain" when an ally is afflicted by it.
|tip Interrupt his "Mind Blast" and "Mind Flay" spells when possible.
|tip Use CC abilities on group members who are afflicted by "Dominate Mind".
Click Here to Continue |confirm
step
kill Tsu'zee##11467
|tip This will be a healing intensive encounter.
|tip Dispel her "Blind" ability on allies when afflicted.
Click Here to Continue |confirm
step
kill Illyanna Ravenoak##11488
|tip The group should stand in melee range to avoid her abilities.
|tip Kill Illyanna, then Ferra after.
Click Here to Continue |confirm
step
kill Immol'thar##11496
|tip He will use the "Eye of Immol'thar" ability during the encounter, spawning eye enemies around the room.
|tip Designate a ranged attack to deal with them.
|tip At 50% health, he will enrage, increasing his attack speed by 60%.
|tip At this point, it will become a healing intensive encounter.
Click Here to Continue |confirm
step
kill Prince Tortheldrin##11486
|tip This is a healing intensive fight.
|tip The tank should face their back to the wall to avoid being knocked back by his "Arcane Blast" ability.
|tip When Arcane Blast is used, his aggro will reset, so it's best to stop DPS until the tank can establish aggro once more.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul North Tribute (58-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Dire Maul",
description="This guide will walk you through the Dire Maul North dungeon.",
lfgid=2558,
},[[
step
collect Frost Oil##3829
|tip An Alchemist can make this with 4 Khadgar's Whisker, 2 Wintersbite and 1 Leaded Vial.
|tip You can also purchase this from the Auction House.
step
collect Thorium Widget##15994
|tip An Engineer can make this with 3 Thorium Bars and 1 Runecloth.
|tip You can also purchase this from the Auction House.
step
Enter Dire maul - North
|tip In the Tribute run, you won't be killing any boss save for King Gordok.
Click Here to Continue |confirm
step
Avoid Guard Mol'dar
|tip To accomplish this, avoid entering the Courtyard in the first area.
|tip Run along the ledges of the room.
Click Here to Continue |confirm
step
Avoid Stomper Kreeg
|tip He has a short aggro range.
|tip By moving along the left side of the room as soon as you enter the instance you will completely avoid him.
Click Here to Continue |confirm
step
Avoid Guard Fengus
|tip Hug the right side of the room, the use the ramp up North  to sneak to Fengus' Chest.
|tip He patrols around the area so keep an eye out.
click Fengus's Chest
collect Gordok Courtyard Key##18266
Click Here to Continue |confirm
step
Avoid Guard Slip'kik
|tip Clear the room of trash while watching for his patrol.
click Broken Trap
turnin A Broken Trap##1193
|tip Activate the trap, then dragon Guard Slip'kik to it.
Click Here to Continue |confirm
step
For Captain Kromcrush:
use the Gordok Ogre Suit##18258
|tip Clear nearby trash without pulling him before doing this.
talk Captain Kromcrush##14325
Tell him _"Um, I'm taking some prisoners we found outside before the king for punishment."_
|tip If someone else in the group has the suit and you don't, they will need to do this.
|tip A member of the group will need the Gordok Inner Door Key from Guard Mol'dar from a previous run.
Click Here to Continue |confirm
step
kill King Gordok##11501
|tip Use CC on Cho'Rush the Observer when possible.
|tip Be sure not to kill Cho'Rush the Observer.
step
click Gordok Tribute
|tip It's at Gordok's seat just before the boss encounter.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Lower Blackrock Spire (55-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Lower Blackrock Spire",
description="This guide will walk you through the Lower Blackrock Spire dungeon.",
lfgid=1583,
},[[
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run up the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Jump down here |goto 48.77,63.67 < 5 |walk
Follow the path up |goto 48.83,63.66 < 5 |walk
Enter the building |goto 48.91,63.92 < 5 |walk
Enter the Blackrock Spire dungeon with your group |goto 48.95,63.88 < 7 |c
step
kill Highlord Omokk##9196
|tip CC one of the two adds that accompany him.
|tip The tank should stand away from the group after picking up Highlord Omokk.
|tip Ranged should stand with their backs to a wall.
|tip If you can't CC more than one, kill the add, then Omokk.
|tip Omokk hits hard so the fight will be healing intensive.
Click Here to Continue |confirm
step
kill Shadow Hunter Vosh'gajin##9236
|tip She will be accompanied by 2 "Smolderthorn Shadow Priests".
|tip CC one of them.
|tip The tank should take Shadow Hunter Vosh'gajin away from the group.
|tip DPS down the Priests one at a time, then focus on Shadow Hunter Vosh'gajin.
|tip Mages and Druids should remove the "Curse of Blood" ability.
|tip Spread out as best as possible to avoid multiple group members being afflicted by "Hex".
Click Here to Continue |confirm
step
kill War Master Voone##9237
|tip Clear the rooms leading up to him before engaging.
|tip War master Voone hits hard, so this will be a healing intensive fight.
|tip Wait for the tank to establish aggro before DPS jumps in.
|tip The tank should have their back to a wall during the encounter.
|tip If Voone changes targets, all DPS should stop until the tank re establishes aggro.
Click Here to Continue |confirm
step
kill Mother Smolderweb##10596
|tip On the way to her, Druids can use the "Hibernate" ability to CC them if one is available.
|tip When you reach her, the tank should face her away from the group to avoid her "Crystallize" ability.
|tip Her "Mother's Milk" ability will temporarily stun party members.
Click Here to Continue |confirm
step
kill Urok Doomhowl##10584
|tip Collect the Pike on the ledge just after Mother Smolderweb.
|tip Whoever picked up Omokk's Head should do this.
|tip Clear the room of ogres then combine the two to summon Urok Doomhowl.
|tip After, waves of elite ogres will spawn.
|tip Clicking the pike will insta kill one of the ogres every 30 seconds.
|tip Use CC on additional ogres to mitigate damage to the group.
|tip Eventually, Urok will spawn.
|tip Let your tank establish aggro before engaging.
Click Here to Continue |confirm
step
kill Quartermaster Zigris##9736
|tip Clear the entire room that he patrols before engaging him.
|tip Avoid him when possible, until the room is clear by waiting for him to patrol past the group.
Click Here to Continue |confirm
step
kill Halycon##10220
|tip Halycon will be accompanied by "Worg Pups" which will need to be AoE'd down.
|tip The tank should pick up Halycon while this is happening, establishing aggro.
|tip Once the adds are taken care of, DPS should move to Halycon.
|tip Replenish health and mana as soon as it dies as the next boss will be entering the room.
Click Here to Continue |confirm
step
kill Gizrul the Slavener##10268
|tip This boss hits hard, so it will be a healing intensive fight.
|tip It heals with each use of "Fatal Bite", dealing out massive damage to the tank.
|tip It will also use the "Infected Bite" ability on your tank.
|tip Let the tank establish aggro before starting DPS.
Click Here to Continue |confirm
step
kill Overlord Wyrmthalak##9568
|tip The tank needs to face Wyrmthalak away from the group.
|tip Melee be sure to stand behind him to avoid its "Cleave" ability.
|tip CC adds as the spawn and DPS Overlord Wyrmthalak as fast as possible, moving to the adds after he is dealth with.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Upper Blackrock Spire (55-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Upper Blackrock Spire",
description="This guide will walk you through the Upper Blackrock Spire dungeon.",
lfgid=1584,
},[[
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run up the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Jump down here |goto 48.77,63.67 < 5 |walk
Follow the path up |goto 48.83,63.66 < 5 |walk
Enter the building |goto 48.91,63.92 < 5 |walk
Enter the Blackrock Spire dungeon with your group |goto 48.95,63.88 < 7 |c
step
click Blackrock Altar
|tip This will start the fight.
kill Pyroguard Emberseer##9816
|tip The Tank should keep him away from the group.
|tip Melee will need extra heals during the encounter from its AoE attacks.
Click Here to Continue |confirm
step
kill Solakar Flamewreath##10264
|tip Clear all dragon spawn before starting the event.
|tip Click on father flame and take the item to start the event.
|tip DPS need to focus down "Rookery Hatchers" as quickly as possible.
|tip AoE down whelps that spawn meanwhile.
|tip Tanks pick up "Rookery Guardians" as soon as they appear.
|tip Tanks should have their backs to the wall for these.
|tip After a bit, Solakar will spawn, who will also need to be tanked with against the wall.
|tip Finish off the whelps before switching DPS to Solakar.
|tip Hug the wall after to avoid spawning additional whelps.
Click Here to Continue |confirm
step
kill Jed Runewatcher##10509
|tip This is a Rare Spawn boss that isn't always available.
|tip The tank should have their back to the wall.
|tip All ranged should be at max distance as well.
Click Here to Continue |confirm
step
Goraluk Anvilcrack##10899
|tip The tank should have their back to the wall.
|tip All ranged should be at max distance as well.
Click Here to Continue |confirm
step
kill Warchief Rend Blackhand##10429
kill Gyth##10339
|tip They will spawn after clearing the gauntlet of orcs and dragon spawn.
|tip Focus on Flame Tongues, Dragonguard, Dragon Spawn, Chromatic Dragonspawn, Chromatic Whelps then Blackhand Orcs in that order.
|tip When Gyth appears, the tank should face it away from the group.
|tip At 20%, Rend will join the fight.
|tip The Offtank should immediately grab Rend.
|tip Finish off Gyth before switching to Warchief Rend Blackhand.
|tip Melee move out of range when he casts the "Whirlwind" ability.
Click Here to Continue |confirm
step
kill The Beast##10430
|tip It's "Berserker Charge" ability targets the player with the most aggro.
|tip The tanks must ensure that they have the highest aggro at all times.
|tip All ranged should stand at max range to avoid its "Fear" ability.
|tip The final ability will be "Flamebreak".
|tip It will knockback anyone near it, so the tanks should fight The Beast with their back to the wall.
Click Here to Continue |confirm
step
kill General Drakkisath##10363
|tip To start, if you have a hunter, you can have them kite General Drakkisath into The Beasts room and feign death while the group burns down the "Chromatic Elite Guards".
|tip You can also tank all 3 where they stand, AoEing down the Elite Guards as quickly as possible.
|tip Melee should stand behind Drakkisath at all times.
|tip The Tank should have their back to the wall.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Wailing Caverns Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Wailing Caverns",
description="This guide will walk you through completing the Wailing Caverns Quests.",
},[[
step
ding 15
step
talk Mebok Mizzyrix##3446
accept Raptor Horns##865 |goto The Barrens 62.37,37.62
step
kill Sunscale Scytheclaw##3256+
|tip They look like purple raptors.
collect 5 Intact Raptor Horn##5055 |q 865/1 |goto 43.36,15.57
You can find more around [45.27,14.94]
step
talk Mebok Mizzyrix##3446
turnin Raptor Horns##865 |goto 62.37,37.62
accept Smart Drinks##1491 |goto 62.37,37.62
step
talk Crane Operator Bigglefuzz##3665
accept Trouble at the Docks##959 |goto 63.05,37.60
step
Follow the path up |goto 50.32,35.44 < 10 |only if walking
Continue up the path |goto 49.17,34.09 < 10 |only if walking
Follow the path |goto 48.09,32.95 < 10 |only if walking
Follow the path down |goto 47.28,33.56 < 10 |only if walking
Jump down here |goto 45.86,35.86 < 10 |only if walking
Jump down carefully here |goto Kalimdor 51.87,55.54 < 5 |c
|tip Aim for the stone.
|only if not completedq(1486) and (1487)
step
Enter the cave |goto The Barrens 45.85,35.95 < 5 |walk
talk Nalpak##5767
|tip Inside the cave.
accept Deviate Hides##1486 |goto The Barrens 45.98,35.66
step
talk Ebru##5768
|tip Inside the cave.
accept Deviate Eradication##1487 |goto 46.01,35.74
step
Enter the cave |goto 45.97,36.33 < 10 |walk
Follow the path |goto The Barrens 45.91,35.62 < 10 |walk
Continue follow the path |goto 46.26,34.98 < 10 |walk
Follow the path |goto 45.94,34.24 < 10 |walk
kill Mad Magglish##3655
collect 99-Year-Old Port##5334 |q 959/1 |goto 45.69,33.62
step
Follow the path |goto 46.10,34.07 < 10 |walk
Continue following the path |goto 45.92,32.78 < 10 |walk
Cross the water |goto 46.50,32.37 < 10 |walk
Follow the path |goto 47.37,32.80 < 10 |walk
Cross the bridge |goto 47.50,33.77 < 10 |walk
Enter the Wailing Caverns Dungeon with your Group |goto 47.75,34.86 |c
step
stickystart "Collect_20_Deviate_Hide"
stickystart "Slay_7_Deviate_Ravager"
stickystart "Slay_7_Deviate_Viper"
stickystart "Slay_7_Deviate_Shambler"
stickystart "Slay_7_Deviate_Dreadfang"
Kill Ectoplasm enemies around this area
|tip They are found throughout the dungeon.
collect 6 Wailing Essence##6464 |q 1491/1
step
label "Collect_20_Deviate_Hide"
Kill enemies around this area
collect 20 Deviate Hide##6443 |q 1486/1
step
label "Slay_7_Deviate_Ravager"
kill 7 Deviate Ravager##3636 |q 1487/1
step
label "Slay_7_Deviate_Viper"
kill 7 Deviate Viper##5755 |q 1487/2
step
label "Slay_7_Deviate_Shambler"
kill 7 Deviate Shambler##5761 |q 1487/3
step
label "Slay_7_Deviate_Dreadfang"
kill 7 Deviate Dreadfang##5056 |q 1487/4
step
talk Disciple of Naralex##3678
Tell him _"Let the event begin!"_
|tip This will only be an available option once the Leaders of the fang have been killed.
Escort the Disciple of Naralex
|tip kill any enemies that attack, don't let him die.
kill Mutanus the Devourer##3654
|tip He will spawn at Dreamer's Rock, after several waves of enemies.
collect Glowing Shard##10441 |n
use the Glowing Shard##10441
accept The Glowing Shard##3366
step
Follow the path up |goto 50.32,35.44 < 10 |only if walking
Continue up the path |goto 49.17,34.09 < 10 |only if walking
Follow the path |goto 48.09,32.95 < 10 |only if walking
Follow the path down |goto 47.28,33.56 < 10 |only if walking
Jump down here |goto 45.86,35.86 < 10 |only if walking
Jump down carefully here |goto Kalimdor 51.87,55.54 < 5 |c
|tip Aim for the stone.
|only if not completedq(1486) and (1487)
step
Enter the cave |goto The Barrens 45.85,35.95 < 5 |walk
talk Nalpak##5767
|tip Inside the cave.
turnin Deviate Hides##1486 |goto The Barrens 45.98,35.66
step
talk Ebru##5768
|tip Inside the cave.
turnin Deviate Eradication##1487 |goto 46.01,35.74
step
talk Mebok Mizzyrix##3446
turnin Smart Drinks##1491 |goto 62.37,37.62
step
talk Crane Operator Bigglefuzz##3665
turnin Trouble at the Docks##959 |goto 63.05,37.60
step
talk Sputtervalve##3442
Ask him _"Can you tell me about this shard?"_
Speak with Someone in Ratchet About the Glowing Shard |q 3366/1
step
Follow the path up |goto 50.32,35.44 < 10 |only if walking
Continue up the path |goto 49.17,34.09 < 10 |only if walking
talk Falla Sagewind##8418
turnin The Glowing Shard##3366 |goto 48.18,32.78
accept In Nightmares##3370 |goto 48.18,32.78 |or
accept In Nightmares##3369 |goto 48.18,32.78 |or
step
Enter the building |goto Darnassus 35.52,10.69 < 5 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin In Nightmares##3369 |goto 35.40,8.40
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\The Deadmines Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Deadmines",
description="This guide will walk you through completing The Deadmines Quests.",
},[[
step
ding 16
step
Enter the building |goto Stormwind City 63.62,22.82
talk Wilder Thistlenettle##656
|tip Inside the building
accept Oh Brother...##167 |goto 65.45,21.21
accept Collecting Memories##168 |goto 65.45,21.21
step
talk Shoni the Shilent##6579
accept Underground Assault##2040 |goto 55.52,12.54
step
talk Gryan Stoutmantle##234
accept The Defias Brotherhood##65 |goto Westfall 56.33,47.52
step
Enter the building |goto Redridge Mountains 26.61,46.41 < 7 |walk
talk Wiley the Black##266
|tip Upstairs inside the building.
turnin The Defias Brotherhood##65 |goto Redridge Mountains 26.48,45.35
accept The Defias Brotherhood##132 |goto Redridge Mountains 26.48,45.35
step
Leave the building |goto 26.61,46.41 < 7 |walk
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##132 |goto Westfall 56.33,47.52
accept The Defias Brotherhood##135 |goto Westfall 56.33,47.52
step
Follow the path |goto Stormwind City 74.69,53.64 < 7 |walk
Enter the building |goto Stormwind City/0 77.14,58.04 < 7 |walk
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin The Defias Brotherhood##135 |goto Stormwind City 75.78,59.84
accept The Defias Brotherhood##141 |goto Stormwind City 75.78,59.84
step
Leave the building |goto 77.14,58.04 < 7 |walk
Follow the path |goto 74.69,53.64 < 7 |walk
Run up the ramp |goto 62.44,62.33 < 7 |only if walking
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##141 |goto Westfall 56.33,47.52
accept The Defias Brotherhood##142 |goto Westfall 56.33,47.52
step
map Westfall
path loop off
path	55.6,47.6	56.6,54.0	57.4,62.0	55.0,66.4	50.2,64.0
path	45.6,65.6	44.0,69.6
Check For the Defias Messenger Along This Path
kill Defias Messenger##550
|tip He walks along the road between Jangolode Mine and Moonbrook.
|tip He walks into Gold Coast Quarry before traveling to either Jangolode Mine or Moonbrook.
|tip Run on the road while looking for him.
|tip He spawns around this location, so it may be easier to kill enemies around this area, waiting for him to either spawn or walk here.
collect A Mysterious Message##1381 |q 142/1
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##142 |goto Westfall 56.33,47.52
step
talk The Defias Traitor##467
|tip This is an escort quest.
|tip If he's not here, someone may be escorting him.
|tip Wait until he respawns.
accept The Defias Brotherhood##155 |goto 55.68,47.50 |noautoaccept
step
Watch the dialogue
|tip Follow the Defias Traitor and protect him as he walks.
|tip He eventually walks to this location.
Escort The Defias Traitor to Discover Where VanCleef is Hiding |q 155/1 |goto 42.54,71.69
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##155 |goto 56.33,47.52
accept The Defias Brotherhood##166 |goto 56.33,47.52
step
Enter the building |goto Westfall 56.51,47.41 < 5 |only if walking
talk Scout Riell##820
|tip At the top of the tower.
accept Red Silk Bandanas##214 |goto 56.67,47.35
step
Enter the building |goto Westfall 42.56,71.74 < 5 |walk
Run up the stairs |goto The Deadmines 41.20,79.03 < 5 |walk
Follow the path |goto 41.15,79.10 < 5 |walk
Follow the ramp down |goto 41.20,79.11 < 7 |c
Kill Undead enemies around this area
collect 4 Miners' Union Card##1894 |q 168/1
step
kill Foreman Thistlenettle##626
collect Thistlenettle's Badge##1875 |q 167/1
stickystart "Collect_10_Red_Silk_Bandanas"
step
kill Sneed's Shredder##642
collect Gnoam Sprecklesprocket##7365 |q 2040/1
step
label "Collect_10_Red_Silk_Bandanas"
Kill Defias enemies around this area
|tip They are all around this area.
collect 10 Red Silk Bandanas##915 |q 214/1
step
kill Edwin Vancleef##639
|tip Aboard the ship.
collect An Unsent Letter##2874 |n
collect Head of VanCleef##3637 |q 166/1
use An Unsent Letter##2874
accept The Unsent Letter##373
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##166 |goto Westfall 56.33,47.52
step
Enter the building |goto Westfall 56.51,47.41 < 5 |only if walking
talk Scout Riell##820
|tip At the top of the tower.
turnin Red Silk Bandanas##214 |goto 56.67,47.35
step
Enter the building |goto Stormwind City 47.89,31.17 < 5 |walk
talk Baros Alexston##1646
turnin The Unsent Letter##373 |goto 49.20,30.28
step
Leave the building |goto Stormwind City 47.89,31.17 < 5 |walk
talk Shoni the Shilent##6579
turnin Underground Assault##2040 |goto 55.52,12.54
step
Enter the building |goto 63.64,22.78 < 5 |walk
talk Wilder Thistlenettle##656
|tip Inside the building
accept Oh Brother...##167 |goto 65.45,21.21
accept Collecting Memories##168 |goto 65.45,21.21
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackfathom Deeps Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Blackfathom Deeps",
description="This guide will walk you through completing the Blackfathom Deeps Quests.",
},[[
step
ding 20
step
talk Argos Nightwhisper##4984
accept The Corruption Abroad##3765 |goto Stormwind City 21.41,55.77
step
Run up the stairs |goto Ironforge 51.24,9.84 < 5 |only if walking
talk Gerrig Bonegrip##2786
|tip Inside the building.
accept Knowledge in the Deeps##971 |goto 50.82,5.60
step
talk Gershala Nightwhisper##8997
turnin The Corruption Abroad##3765 |goto Darkshore 38.33,43.04
accept Researching the Corruption##1275 |goto Darkshore 38.33,43.04
step
Run up the ramp |goto Darnassus 56.46,20.41 < 5 |only if walking
talk Argent Guard Manados##4784
|tip Inside the building.
accept Twilight Falls##1199 |goto 55.23,24.00
step
talk Dawnwatcher Shaedlass##4786
|tip Inside the building.
accept In Search of Thaelrid##1198 |goto 55.37,25.00
stickystart "Collect_10_Twilight_Pendants"
stickystart "Collect_8_Corrupted_Brain_Stems"
step
click Pitted Iron Chest
|tip It is underwater to the north of Gamoo-ra.
|tip It will be surrounded by elite naga.
collect Lorgalis Manuscript##5359 |q 971/1
step
talk Argent Guard Thaelrid##4787
|tip Swim into the South-West cave in the room where the boss Gamoo-ra is to reach him.
turnin In Search of Thaelrid##1198
accept Blackfathom Villainy##1200
step
kill Twilight Lord Kelris##4832
collect Head of Kelris##5881 |q 1200/1
step
label "Collect_10_Twilight_Pendants"
Kill Twilight enemies around this area
|tip They are found through out the instance.
collect 10 Twilight Pendant##5879 |q 1199/1
step
label "Collect_8_Corrupted_Brain_Stems"
Kill enemies around this area
collect 8 Corrupted Brain Stem##5952 |q 1275/1
step
talk Gershala Nightwhisper##8997
turnin Researching the Corruption##1275 |goto Darkshore 38.33,43.04
step
Run up the ramp |goto Darnassus 56.46,20.41 < 5 |only if walking
talk Argent Guard Manados##4784
|tip Inside the building.
turnin Twilight Falls##1199 |goto 55.23,24.00
step
talk Dawnwatcher Selgorm##4783
|tip Inside the building.
turnin Blackfathom Villainy##1200 |goto 56.17,24.38
step
Run up the stairs |goto Ironforge 51.24,9.84 < 5 |only if walking
talk Gerrig Bonegrip##2786
|tip Inside the building.
turnin Knowledge in the Deeps##971 |goto 50.82,5.60
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\The Stockade Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\The Stockade",
description="This guide will walk you through completing The Stockade Quests.",
},[[
step
ding 22
step
talk Motley Garmason##1074
accept The Fury Runs Deep##378 |goto Wetlands 49.67,18.24
step
talk Guard Berton##859
accept What Comes Around...##386 |goto Redridge Mountains 26.26,46.57
step
Enter the building |goto Duskwood 72.88,46.83 < 5 |walk
talk Councilman Millstipe##270
|tip Inside the building.
accept Crime and Punishment##377 |goto 71.92,47.79
step
talk Nikova Raskol##1721
|tip She patrols around the area.
accept The Color of Blood##388 |goto Stormwind City 73.39,50.69
step
kill Edwin Vancleef##639
|tip This is the final boss of the Deadmines.
collect An Unsent Letter##2874 |n
use An Unsent Letter##2874
accept The Unsent Letter##373
step
Enter the building |goto Stormwind City 47.89,31.17 < 5 |walk
talk Baros Alexston##1646
turnin The Unsent Letter##373 |goto 49.20,30.28
accept Bazil Thredd##389 |goto 49.20,30.28
step
Enter the building |goto Stormwind City 42.25,58.86 < 5 |walk
talk Warden Thelwater##1719
|tip Inside the building.
turnin accept 389 |goto 41.16,58.02
accept The Stockade Riots##391 |goto 41.16,58.02
accept Quell The Uprising##387 |goto 41.16,58.02
stickystart "Kill_10_Defias_Prisoners"
stickystart "Kill_8_Defias_Convicts"
stickystart "Kill_8_Defias_Insurgents"
stickystart "Collect_10_Red_Wool_Bandanas"
step
kill Targorr the Dread##1696
collect Head of Targorr##3630 |q 386/1
step
kill Dextren Ward##1663
collect Hand of Dextren Ward##3628 |q 377/1
step
kill Kam Deepfury##1666
collect Head of Deepfury##3640 |q 378/1
step
kill Bazil Thredd##1716
collect Head of Bazil Thredd##2926 |q 391/1
step
label "Kill_10_Defias_Prisoners"
kill 10 Defias Prisoner##1706 |q 387/1
step
label "Kill_8_Defias_Convicts"
kill 8 Defias Convict##1711 |q 387/2
step
label "Kill_8_Defias_Insurgents"
kill 8 Defias Insurgent##1715 |q 387/3
step
label "Collect_10_Red_Wool_Bandanas"
Kill enemies around this area
collect 10 Red Wool Bandana##2909 |q 388/1
step
talk Warden Thelwater##1719
|tip Inside the building.
turnin The Stockade Riots##391 |goto Stormwind City 41.16,58.02
turnin Quell The Uprising##387 |goto 41.16,58.02
step
Leave the building |goto 42.25,58.86 < 5 |walk
talk Nikova Raskol##1721
|tip She patrols around the area.
turnin The Color of Blood##388 |goto 73.39,50.69
step
Enter the building |goto Duskwood 72.88,46.83 < 5 |walk
talk Councilman Millstipe##270
|tip Inside the building.
turnin Crime and Punishment##377 |goto 71.92,47.79
step
talk Guard Berton##859
turnin What Comes Around...##386 |goto Redridge Mountains 26.26,46.57
step
talk Motley Garmason##1074
turnin The Fury Runs Deep##378 |goto Wetlands 49.67,18.24
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Gnomeregan Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Gnomeregan",
description="This guide will walk you through completing the Gnomeregan Quests.",
},[[
step
ding 25
step
Enter the building |goto Stormwind City 42.93,34.24 < 5 |walk
talk Brother Sarno##7917
accept Tinkmaster Overspark##2923 |goto 40.56,30.92
step
talk Shoni the Shilent##6579
accept Gyrodrillmatic Excavationators##2928 |goto 55.51,12.50
step
talk Mathiel##6142
accept Klockmort's Essentials##2925 |goto Darnassus 59.48,45.38
step
talk Klockmort Spannerspan##6169
turnin Klockmort's Essentials##2925 |goto Ironforge 67.98,46.13
accept Essential Artificials##2924  |goto Ironforge 67.98,46.13
step
talk Tinkmaster Overspark##7944
turnin Tinkmaster Overspark##2923 |goto Ironforge 69.56,50.32
accept Save Techbot's Brain!##2922 |goto Ironforge 69.56,50.32
step
talk Gnoarn##6569
accept The Day After##2927 |goto Ironforge 69.21,50.56
step
talk Master Mechanic Castpipe##7950
accept Data Rescue##2930 |goto Ironforge 69.82,48.08
step
Enter the building |goto Dun Morogh 45.97,48.83 < 5
talk Ozzie Togglevolt##1268
turnin The Day After##2927 |goto 45.88,49.38
accept Gnogaine##2926 |goto 45.88,49.38
step
talk High Tinker Mekkatorque##7937
accept The Grand Betrayal##2929 |goto Ironforge 68.76,48.96
step
Enter the building |goto Dun Morogh 24.35,39.78 < 7 |walk
Run down the ramp |goto Eastern Kingdoms 43.45,53.80 < 7 |walk
Go down the elevator |goto 43.61,53.82 < 7 |c
step
Kill enemies around this area
|tip Addled Lepers and Addled Troggs just outside of Gnomeregan drop this.
collect White Punch Card##9279 |q 2930 |future
step
click Matrix Punchograph 3005-A
|tip It's up on the elevated platform in the Train Depot just outside of the Gnomeregan instance.
Choose _"Acquire Higher Level Access Card"_
collect Yellow Punch Card##9280 |q 2930 |future
step
kill Techbot##6231
|tip On the Western end of the platform inside the Train Depot, just outside of the Gnomeregan instance.
collect Techbot's Memory Core##9277 |q 2922/1
step
Run up the ramp |goto 43.40,53.73 < 7 |only if walking
Follow the path |goto 43.20,53.37 < 15 |only if walking
Enter the Gnomeregan dungeon with your group |goto 42.81,53.82 < 5 |c
step
use the Empty Leaden Collection Phial##9283
|tip Use this on Irradiated Invaders or Irradiated Pillagers.
|tip They are found in The Dormitory area.
collect Full Leaden Collection Phial##9284 |q 2926/1
step
click Miatrix Punchograph 3005-B
|tip It's in The Dormitory area of Gnomeregan.
Choose _"Acquire Higher Level Access Card"_
collect Blue Punch Card##9282 |q 2930 |future
step
kill Electrocutioner 6000##6235
collect Workshop Key##6893 |q 2930 |future
step
click Matrix Punchograph 3005-C
|tip It's up in the Launch Bay platform, with Electrocutioner 6000.
Choose _"Acquire Higher Level Access Card"_
collect Red Punch Card##9281 |q 2930 |future
step
Ride the Elevator down
|tip It is found in the Engineering Labs, along with Crowd Pummeler 9-60.
click Miatrix Punchograph 3005-D
|tip On the bottom level of the Engineer Labs.
Choose _"Acquire Higher Level Access Card"_
collect Prismatic Punch Card##9316 |q 2930/1
step
label "Collect_24_Robo-Mechanical_Guts"
Kill enemies around this area
collect 24 Robo-mechanical Guts##9309 |q 2928/1
step
label "Collect_12_Essential_Artificial"
Kill enemies around this area
collect 12 Essential Artificial##9278 |q 2924/1
step
kill Mekgineer Thermaplugg##7800 |q 2929/1
step
Leave the Gnomeregan Dungeon
Click Here to Continue |confirm
step
Enter the building |goto Dun Morogh 45.97,48.83 < 5
talk Ozzie Togglevolt##1268
turnin Gnogaine##2926 |goto 45.88,49.38
accept The Only Cure is More Green Glow##2962 |goto 45.88,49.38
step
talk Klockmort Spannerspan##6169
turnin Essential Artificials##2924 |goto Ironforge 67.98,46.13
step
talk Tinkmaster Overspark##7944
turnin Save Techbot's Brain!##2922 |goto Ironforge 69.56,50.32
step
talk Master Mechanic Castpipe##7950
accept Data Rescue##2930 |goto Ironforge 69.82,48.08
step
talk High Tinker Mekkatorque##7937
turnin The Grand Betrayal##2929 |goto Ironforge 68.76,48.96
step
Enter the building |goto Dun Morogh 24.35,39.78 < 7 |walk
Run down the ramp |goto Eastern Kingdoms 43.45,53.80 < 7 |walk
Go down the elevator |goto 43.61,53.82 < 7 |c
step
Run up the ramp |goto 43.40,53.73 < 7 |only if walking
Follow the path |goto 43.20,53.37 < 15 |only if walking
Enter the Gnomeregan dungeon with your group |goto 42.81,53.82 < 5 |c
step
kill Viscous Fallout##7079
use the Heavy Leaden Collection Phial##9364
|tip Use it on Viscious Fallout's corpse.
collect High Potency Radioactive Fallout##9365 |q 2962/1
step
Leave the Gnomeregan Dungeon
Click Here to Continue |confirm
step
Enter the building |goto Dun Morogh 45.97,48.83 < 5
talk Ozzie Togglevolt##1268
turnin The Only Cure is More Green Glow##2962 |goto 45.88,49.38
step
talk Shoni the Shilent##6579
turnin Gyrodrillmatic Excavationators##2928 |goto Stormwind City 55.51,12.50
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Razorfen Kraul Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Razorfen Kraul",
description="This guide will walk you through completing the Razorfen Kraul Quests.",
},[[
step
ding 29
step
talk Mebok Mizzyrix##3446
accept Blueleaf Tubers##1221 |goto The Barrens 62.37,37.62
step
click Snufflenose Command Stick##68865
collect Snufflenose Command Stick##6684 |q 1221/4|goto The Barrens 62.34,37.61
step
click Snufflenose Owner's Manual##21530
collect Snufflenose Owner's Manual##5897 |q 1221/3 |goto 62.34,37.63
step
click Crate with Holes##21277
collect Crate With Holes##5880 |q 1221/2 |goto The Barrens 62.33,37.63
step
click Henrig Longbrow's Journal##19861
|tip It will be in the hand of a corpse on the ground.
collect Henrig Lonebrow's Journal##5791 |n
use Henrig Lonebrow's Journal##5791
accept Longbrow's Jounral##1100 |goto Thousand Needles 30.73,24.35
step
talk Falfindel Waywarder##4048
turnin Longbrow's Jounral##1100 |goto Feralas 89.63,46.57
accept The Crone of the Kraul##1101 |goto Feralas 89.63,46.57
stickystart "Collect_6_Blueleaf_Tuber"
step
use the Crate With Holes##5880
|tip This will summon a gopher.
use the Snufflenose Command Stick##6684
|tip This will allow you to command the gopher.
|tip Once past Overlord Ramtusk, go to the biggest hill from the area with many bridges.
collect 6 Blueleaf Tuber##5876 |q 1221/1
step
kill Charlga Razorflank##4421
collect Razorflank's Medallion##5792
step
talk Heralath Fallowbrook##4510
|tip Inside the tent.
|tip Jump down from the platform where Charlga Razorflank was, and head to the tent to the left.
accept Mortality Wanes##1142
step
talk Willix the Importer##4508
|tip Inside the building.
|tip This is an escort quest.
accept Willix the Importer##1144
stickystart "Treshala's Pendant"
step
Escort Willix the Importer out of Razorfen Kraul |q 1144/1
step
talk Willix the Importer##4508
|tip He will be at the entrance after the completion of the escort quest.
turnin Willix the Importer##1144
step
label "Treshala's Pendant"
Kill Razorfen enemies around this area
collect Treshala's Pendant##5825 |q 1142/1
step
label "Collect_6_Blueleaf_Tuber"
collect 6 Blueleaf Tuber##5876
|tip They are found on the ground throughout the instance.
step
talk Falfindel Waywarder##4048
turnin The Crone of the Kraul##1101 |goto Feralas 89.63,46.57
step
Run up the ramp |goto Darnassus 67.68,61.26 < 10 |only if walking
Continue up the ramp |goto 63.69,57.75 < 10 |only if walking
Cross the bridge |goto 65.71,61.63 < 10 |only if walking
talk Treshala Fallowbrook##4521
turnin Mortality Wanes##1142 |goto 69.55,67.79
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery Cathedral Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through completing the Scarlet Monastery Cathedral Quests.",
},[[
step
ding 40
step
Enter the building |goto Stormwind City 42.89,34.14 < 6 |walk
Run down the ramp |goto 41.33,25.11 < 6 |walk
talk Brother Crowley##12336
accept Brother Anton##6141 |goto 42.53,24.46
step
Run up the ramp |goto 40.69,25.88 < 6 |walk
Leave the building |goto 42.89,34.14 < 6 |walk
talk Brother Anton##1182
|tip Inside the building.
turnin Brother Anton##6141 |goto Desolace 66.52,7.90
accept Down the Scarlet Path##261 |goto 66.52,7.90
step
kill 30 Undead Ravager##11561 |q 261/1 |goto 64.09,91.64
step
talk Brother Anton##1182
|tip Inside the building.
turnin Down the Scarlet Path##261 |goto 66.52,7.90
accept Down the Scarlet Path##1052 |goto 66.52,7.90
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin Down the Scarlet Path##1052 |goto 51.46,58.36
accept In the Name of the Light##1053
step
Enter the building |goto Scarlet Monastery 47.43,19.74 < 10
Enter the Scarlet Monastery - Cathedral dungeon with your group |goto 75.00,23.41 < 5 |c
step
Inside the Scarlet Monastery Cathedral Dungeon:
kill High Inquisitor Whitemane |q 1053/1
step
Inside the Scarlet Monastery Cathedral Dungeon:
kill Scarlet Commander Mograine |q 1053/2
step
Leave the Scarlet Monastery Catherdal Dungeon
Click Here to Continue |confirm
step
Enter the Scarlet Monastery - Library dungeon with your group |goto 75.00,23.58 < 5 |c
step
Inside the Scarlet Monastery Library Dungeon:
kill Houndmaster Loksey |q 1053/4
step
Leave the Scarlet Monastery Library Dungeon
Click Here to Continue |confirm
step
Enter the Scarlet Monastery - Armory dungeon with your group |goto 75.03,23.52 < 5 |c
step
Inside the Scarlet Monastery Armory Dungeon:
kill Herod##3975 |q 1048/3
step
Leave the Scarlet Monastery Armor Dungeon
Click Here to Continue |confirm
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin In the Name of the Light##1053 |goto 51.46,58.36
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Library Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through completing the Razorfen Kraul Quests.",
},[[
step
ding 28
step
Enter the building |goto Stormwind City 42.89,34.14 < 6 |walk
Run down the ramp |goto 41.33,25.11 < 6 |walk
talk Brother Crowley##12336
accept Brother Anton##6141 |goto 42.53,24.46
step
Run up the ramp |goto 40.69,25.88 < 6 |walk
Leave the building |goto 42.89,34.14 < 6 |walk
talk Brother Anton##1182
|tip Inside the building.
turnin Brother Anton##6141 |goto Desolace 66.52,7.90
accept Down the Scarlet Path##261 |goto 66.52,7.90
step
kill 30 Undead Ravager##11561 |q 261/1 |goto 64.09,91.64
step
talk Brother Anton##1182
|tip Inside the building.
turnin Down the Scarlet Path##261 |goto 66.52,7.90
accept Down the Scarlet Path##1052 |goto 66.52,7.90
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin Down the Scarlet Path##1052 |goto 51.46,58.36
accept In the Name of the Light##1053
step
talk Librarian Mae Paledust##3979
accept Mythology of the Titans##1050 |goto Ironforge 74.97,12.46
step
Follow the path up |goto Tirisfal Glades 81.39,41.13 < 15 |only if walking
Follow the path |goto 81.39,39.57 < 15 |only if walking
Continue following the path |goto 82.28,37.86 < 15 |only if walking
Enter the building |goto Scarlet Monastery 47.43,19.74 < 10 |c
step
Run up the stairs |goto Scarlet Monastery 47.45,19.69 < 10 |walk
Follow the path |goto 74.89,23.58 < 10 |walk
Enter the Scarlet Monastery - Library dungeon with your group |goto 75.00,23.58 < 5 |c
step
Inside the Scarlet Monastery Library Dungeon:
kill Houndmaster Loksey |q 1053/4
step
click Mythology of the Titans##19284
|tip It's on the ground just to the left of the room just the Gallery of Treasures.
collect Mythology of the Titans##5536
step
Leave the Scarlet Monastery Library Dungeon
Click Here to Continue |confirm
step
ding 38
step
Enter the Scarlet Monastery - Armory dungeon with your group |goto 75.03,23.52 < 5 |c
step
Inside the Scarlet Monastery Armory Dungeon:
kill Herod##3975 |q 1048/3
step
Leave the Scarlet Monastery Armor Dungeon
Click Here to Continue |confirm
step
ding 40
step
Enter the Scarlet Monastery - Cathedral dungeon with your group |goto 75.00,23.41 < 5 |c
step
Inside the Scarlet Monastery Cathedral Dungeon:
kill High Inquisitor Whitemane |q 1053/1
step
Inside the Scarlet Monastery Cathedral Dungeon:
kill Scarlet Commander Mograine |q 1053/2
step
Leave the Scarlet Monastery Catherdal Dungeon
Click Here to Continue |confirm
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin In the Name of the Light##1053 |goto 51.46,58.36
step
talk Librarian Mae Paledust##3979
turnin Mythology of the Titans##1050 |goto Ironforge 74.97,12.46
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Armory Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through completing the Razorfen Kraul Quests.",
},[[
step
ding 38
step
Enter the building |goto Stormwind City 42.89,34.14 < 6 |walk
Run down the ramp |goto 41.33,25.11 < 6 |walk
talk Brother Crowley##12336
accept Brother Anton##6141 |goto 42.53,24.46
step
Run up the ramp |goto 40.69,25.88 < 6 |walk
Leave the building |goto 42.89,34.14 < 6 |walk
talk Brother Anton##1182
|tip Inside the building.
turnin Brother Anton##6141 |goto Desolace 66.52,7.90
accept Down the Scarlet Path##261 |goto 66.52,7.90
step
kill 30 Undead Ravager##11561 |q 261/1 |goto 64.09,91.64
step
talk Brother Anton##1182
|tip Inside the building.
turnin Down the Scarlet Path##261 |goto 66.52,7.90
accept Down the Scarlet Path##1052 |goto 66.52,7.90
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin Down the Scarlet Path##1052 |goto 51.46,58.36
accept In the Name of the Light##1053 |goto 51.46,58.36
step
Follow the path up |goto Tirisfal Glades 81.39,41.13 < 15 |only if walking
Follow the path |goto 81.39,39.57 < 15 |only if walking
Continue following the path |goto 82.28,37.86 < 15 |only if walking
Enter the building |goto Scarlet Monastery 47.43,19.74 < 10 |c
step
Run up the stairs |goto Scarlet Monastery 47.45,19.69 < 10 |walk
Follow the path |goto 74.89,23.58 < 10 |walk
Enter the Scarlet Monastery - Library dungeon with your group |goto 75.00,23.58 < 5 |c
step
Inside the Scarlet Monastery Library Dungeon:
kill Herod##3975 |q 1048/3
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin In the Name of the Light##1053 |goto 51.46,58.36
|tip Ignore this if you haven't completed the other objectives of the quest yet.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Razorfen Downs Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Razorfen Downs",
description="This guide will walk you through completing the Razorfen Downs Quests.",
},[[
step
ding 37
step
Enter the building |goto Stormwind City 42.88,34.14 < 7 |walk
talk Archbishop Benedictus##1284
|tip Inside the building.
accept Bring the Light##3636 |goto 39.58,27.26
step
Follow the path up |goto The Barrens 49.10,94.49
talk Myriam Moonsinger##12866
accept A Host of Evil##6626 |goto 49.01,94.94
stickystart "Kill_8_Razorfen_Thronweaver"
stickystart "Kill_8_Death's_Head_ Cultist"
step
kill 8 Razorfen Battleguard## |q 6626/1 |goto The Barrens 48.59,95.47
step
label "Kill_8_Razorfen_Thronweaver"
kill 8 Razorfen Thronweaver## |q 6626/2 |goto 48.14,92.26
step
label "Kill_8_Death's_Head_ Cultist"
kill 8 Death's Head Cultist## |q 6626/3 |goto 46.68,87.95
step
Follow the path up |goto The Barrens 49.10,94.49
talk Myriam Moonsinger##12866
accept A Host of Evil##6626 |goto 49.01,94.94
step
Follow the path |goto The Barrens 49.13,93.47 < 10 |only if walking
Enter the Razorfen Downs Instance |goto 53.25,71.17 < 10 |c
step
Inside the Razorfen Downs Dungeon:
click Holding Pen
talk Belnistrasz##8516
|tip Inside the Holding Pen.
accept Scourge of the Downs##3523
step
Inside the Razorfen Downs Dungeon:
talk Belnistrasz##8516
|tip Inside the Holding Pen.
turnin Scourge of the Downs##3523
accept Extinguishing the Idol##3525
|tip This is an escort quest.
step
Inside the Razorfen Downs Dungeon:
Escort Belnistrasz to the Quilboar's Idol |q 3525/1
|tip Follow him and kill enemies that attack.
step
Inside the Razorfen Downs Dungeon:
click Belnistrasz's Brazier
|tip It will be in the room where he was channeling.
turnin Extinguishing the Idol##3525
step
Inside the Razorfen Downs Dungeon:
kill Amnennar the Coldbringer##7358 |q 3636/1
step
Leave the Razorfen Downs Dungeon
Click Here to Continue |confirm
step
Enter the building |goto Stormwind City 42.88,34.14 < 7 |walk
talk Archbishop Benedictus##1284
|tip Inside the building.
turnin Bring the Light##3636 |goto 39.58,27.26
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Uldaman Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Uldaman",
description="This guide will walk you through completing the Uldaman Quests.",
},[[
step
ding 38
step
Enter the cave |goto Eastern Kingdoms 54.48,57.78
Kill Shadowforge enemies around this area
|tip You may need help with this.
collect Shattered Necklace##7666 |n
use the Shattered Necklace##7666
accept The Shattered Necklace##2198 |goto 53.86,57.90
step
talk Talvash del Kissel##6826
turnin The Shattered Necklace##2198 |goto Ironforge 36.36,3.62
accept Lore for a Price##2199 |goto Ironforge 36.36,3.62
step
collect 5 Silver Bar##2842 |q 2199/1
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
step
talk Talvash del Kissel##6826
turnin Lore for a Price##2199 |goto Ironforge 36.36,3.62
accept Back to Uldaman##2200 |goto Ironforge 36.36,3.62
step
talk Prospector Stormpike##1356
accept The Lost Dwarves##2398 |goto 74.62,11.79
step
Follow the path |goto Badlands 51.84,15.51 < 30 |only if walking
Follow the path |goto Badlands 51.77,33.17 < 15 |only if walking
click Crumpled Map
accept A Sign of Hope##720 |goto Badlands 53.03,33.93
step
Follow the path up |goto 50.48,37.05 < 30 |only if walking
talk Prospector Ryedol##2910
turnin A Sign of Hope##720 |goto 53.42,43.40
accept A Sign of Hope##721 |goto 53.42,43.40
step
Enter the cave |goto Eastern Kingdoms 54.48,57.78
talk Hammertoe Grez##2909
Find Hammertoe Grez in Uldaman |q 721/1 |goto 54.04,57.67
step
talk Hammertoe Grez##2909
turnin A Sign of Hope##721 |goto 54.04,57.67
accept Amulet of Secrets##722 |goto 54.04,57.67
step
kill Magregan Deepshadow##2932
|tip He patrols through the tunnels before the entrance.
|tip He has a slow respawn rate.
collect Hammertoe's Amulet##4635 |q 722/1 |goto 53.85,57.95
step
talk Hammertoe Grez##2909
turnin Amulet of Secrets##722 |goto 54.04,57.67
accept Prospect of Faith##723 |goto 54.04,57.67
step
Leave the cave |goto Eastern Kingdoms 54.48,57.78
talk Prospector Ryedol##2910
turnin Prospect of Faith##723 |goto Badlands 53.42,43.40
accept Prospect of Faith##724 |goto Badlands 53.42,43.40
step
talk Prospector Stormpike##1356
accept Ironband Wants You!##707 |goto Ironforge 74.70,11.72
step
talk Historian Karnik##2916
turnin Prospect of Faith##724 |goto Ironforge 77.57,11.83
accept Passing Word of a Threat##725 |goto Ironforge 77.57,11.83
step
talk Advisor Belgrum##2918
turnin Passing Word of a Threat##725 |goto 77.32,9.75
accept Passing Word of a Threat##726 |goto 77.32,9.75
step
talk Historian Karnik##2916
turnin Passing Word of a Threat##726 |goto Ironforge 77.57,11.83
accept An Ambassador of Evil##762 |goto Ironforge 77.57,11.83
step
Enter the building |goto Loch Modan 36.64,48.53 < 7 |walk
talk Ghak Healtouch##1470
|tip Inside the building.
accept Badlands Reagent Run##2500 |goto 37.07,49.38
step
talk Prospector Ironband##1344
turnin Ironband Wants You!##707 |goto Loch Modan 65.94,65.62
accept Find Agmond##738 |goto Loch Modan 65.94,65.62
step
click Battered Dwarven Skeleton
turnin Find Agmond##738 |goto Badlands 50.89,62.40
accept Murdaloc##739 |goto Badlands 50.89,62.40
step
kill Murdaloc##2945 |q 739/1 |goto 49.63,66.27
step
kill 12 Stonevault Bonesnapper##2893 |q 739/2 |goto 51.18,68.27
step
Enter the building |goto Badlands 42.93,29.93 < 10 |walk
Follow the path |goto 43.10,28.83 < 7 |walk
Run down the stairs |goto 42.20,26.74 < 7 |walk
Continue down the stairs |goto 41.24,27.44 < 7 |walk
kill Ambassador Infernus##2745
|tip Downstairs inside the building.
|tip You may need help with this.
collect Ambassador Infernus' Bracer##4621 |q 762/1 |goto 42.10,28.90
step
kill Lesser Rock Elemental##2735+
collect 5 Rock Elemental Shard##7848 |q 2500/3 |goto 19.46,43.02
step
label "Collect_Buzzard_Gizzards"
Kill Buzzard enemies around this area
collect 5 Buzzard Gizzard##7847 |q 2500/1 |goto 16.82,59.84
You can find more around: |notinsticky
[12.45,69.20]
[17.43,48.90]
[25.63,62.04]
[33.36,59.65]
[28.67,72.03]
[24.51,74.45]
[18.90,77.65]
step
label "Collect_Crag_Coyote_Fangs"
Kill Coyote enemies around this area
collect 10 Crag Coyote Fang##7846 |q 2500/2 |goto 23.75,55.12
You can find more around: |notinsticky
[14.18,65.72]
[31.58,65.16]
step
talk Prospector Ironband##1344
turnin Find Agmond##738 |goto Loch Modan 65.94,65.62
accept Agmond's Fate##704 |goto Loch Modan 65.94,65.62
step
Enter the building |goto Loch Modan 36.63,48.53 < 7 |walk
talk Ghak Healtouch##1470
|tip Inside the building.
turnin Badlands Reagent Run##2500 |goto Loch Modan 37.07,49.38
accept Uldaman Reagent Run##2202 |goto Loch Modan 37.07,49.38
step
talk Advisor Belgrum##2918
turnin An Ambassador of Evil##762 |goto Ironforge 77.32,9.75
accept The Lost Tablets of Will##1139 |goto Ironforge 77.32,9.75
step
Enter the cave |goto Eastern Kingdoms 54.48,57.78
Enter the Uldaman Dungeon with Your Group |goto 53.85,57.66 < 10 |q 2279 |future |c
stickystart "Collect_4_Carved_Stone_Urn"
stickystart "Collect_12_Magenta_Cap_Cluster"
step
Inside the Uldaman Dungeon:
talk Remains of a Paladin##6912
|tip He's laying on the ground surrounded by enemies.
turnin Back to Uldaman##2200
accept Find the Gems##2201
step
Inside the Uldaman Dungeon:
talk Baelog##6906
|tip In Dig Two.
turnin The Lost Dwarves##2398
accept The Hidden Chamber##2240
step
Inside the Uldaman Dungeon:
click Baelog's Chest
|tip On the table behind Baelog.
collect Gni'kiv Medallion##7740 |q 2240 |future
step
Inside the Uldaman Dungeon:
click Conspicuous Urn
|tip In Dig Two, the room with Olaf, Eric "The Swift" and Baelog.
collect Shattered Necklace Topaz##7671 |q 2201/3
step
Inside the Uldaman Dungeon:
kill Revelosh##6910
collect The Shaft of Tsol##7741 |q 2240 |future
step
Inside the Uldaman Dungeon:
use The Shaft of Tsol##7741
collect Staff of Prehistoria##7733 |q 2240 |future
step
Inside the Uldaman Dungeon:
click Keystone
|tip In the Map Chamber, just after Revelosh.
|tip This will only be usable by someone with the Staff of Prehistoria.
|tip This will open the locked door, guarded by the boss Ironaya.
|tip After defeating Ironaya, enter the room she was in.
Explore the Hidden Chamber |q 2240/1
step
Inside the Uldaman Dungeon:
click Shadowforge Cache
|tip In Dig Three, with Galgann Firehammer.
collect Shattered Necklace Ruby##7669 |q 2201/1
step
Inside the Uldaman Dungeon:
click Tablet of Will
|tip It is against the wall in Dig Three, the same room with Galgann Firehammer.
collect Tablet of Will##5824 |q 1139/1
step
Inside the Uldaman Dungeon:
kill Grimlok##4854
collect Shattered Necklace Sapphire##7670 |q 2201/2
step
Inside the Uldaman Dungeon:
use Talvash's Phial of Scrying##7667
click Talvash's Scrying Bowl##112877
turnin Find the Gems##2201
accept Restoring the Necklace##2204
step
Inside the Uldaman Dungeon:
kill Archaedas##2748
|tip This will open the door behind him, granting access to the Platinum Discs.
collect Shattered Necklace Power Source##7672 |q 2204/1
step
Inside the Uldaman Dungeon:
click The Discs of Norgannon
accept The Platinum Discs##2278
|only if level >=40
step
Inside the Uldaman Dungeon:
talk Lore Keeper of Norgannon##7172
Tell him _"Who are the Earthen?"_
Learn What Lore That the Stone Watcher Has to Offer |q 2278/1
|only if level >=40
step
Inside the Uldaman Dungeon:
click The Discs of Norgannon
turnin The Platinum Discs##2278
accept The Platinum Discs##2279
|only if level >=40
step
label "Collect_4_Carved_Stone_Urn"
Inside the Uldaman Dungeon:
click Carved Stone Urn
|tip They are scattered throughout the instance.
collect 4 Carved Stone Urn##4610 |q 704/1
step
label "Collect_12_Magenta_Cap_Cluster"
Inside the Uldaman Dungeon:
click Magenta Cap Cluster
|tip They look like a pair of mushrooms along the walls of the cave.
collect 12 Magenta Cap Cluster##8047 |q 2202/1
step
Leave the Uldaman Dungeon
Click Here to Continue |confirm
step
talk Prospector Ironband##1344
turnin Agmond's Fate##704 |goto Loch Modan 65.93,65.62
step
Enter the building |goto Loch Modan 36.63,48.52 < 5 |walk
talk Ghak Healtouch##1470
|tip Inside the building.
turnin Uldaman Reagent Run##17 |goto 37.07,49.37
step
Run up the stairs |goto Ironforge 31.94,8.36 < 5 |only if walking
Enter the building |goto 31.98,5.42 < 5 |walk
talk Tymor##8507
|tip Inside the building.
turnin Passing the Burden##3448 |goto 30.98,4.81
step
talk High Explorer Magellas##5387
turnin The Platinum Discs##2279 |goto Ironforge 69.1,18.6
accept The Platinum Discs##2439 |goto Ironforge 69.1,18.6
|only if level >=40
step
talk Dinita Stonemantle##7292
turnin The Platinum Discs##2439 |goto 33.8,60.2
step
talk Talvash del Kissel##6826
turnin Restoring the Necklace##2204|goto Ironforge 36.36,3.62
step
talk Prospector Stormpike##1356
turnin The Hidden Chamber##2240 |goto Ironforge 74.66,11.73
step
talk Advisor Belgrum##2918
turnin The Lost Tablets of Will##1139 |goto Ironforge 77.32,9.75
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Zul'Farrak Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Zul'Farrak",
description="This guide will walk you through completing the Zul'Farrak Quests.",
},[[
step
ding 40
step
Enter the building |goto The Hinterlands 11.00,45.68 < 7 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
accept Witherbark Cages##2988 |goto 9.76,44.48
step
click First Witherbark Cage
Check the First Cage |q 2988/1 |goto 23.28,58.75
step
click Second Witherbark Cage
Check the Second Cage |q 2988/2 |goto 23.13,58.76
step
Follow the path |goto 30.53,53.53 < 30 |only if walking
Follow the path |goto 32.40,57.21 < 15 |only if walking
click Third Witherbark Cage
Check the Third Cage |q 2988/3 |goto 31.99,57.38
step
Follow the path up |goto 12.91,48.27 < 15 |only if walking
Enter the building at the top of the path |goto 11.00,45.67 < 7 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
turnin Witherbark Cages##2988 |goto 9.76,44.47
accept The Altar of Zul##2989 |goto 9.76,44.47
step
Run up the stairs |goto 47.75,66.74 < 15 |only if walking
Search the Altar of Zul |q 2989/1 |goto 48.85,68.45
|tip There are elite enemies at the top of the temple.
|tip Complete the quest goal and immediately run away to safety.
step
Follow the path up |goto 12.85,48.25 < 15 |only if walking
Enter the building at the top of the path |goto 11.00,45.67 < 7 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
turnin The Altar of Zul##2989 |goto 9.76,44.48
accept Thadius Grimshade##2990 |goto 9.76,44.48
step
talk Thadius Grimshade##8022
|tip Upstairs inside the building, at the top.
turnin Thadius Grimshade##2990 |goto Blasted Lands 66.90,19.47
accept Nekrum's Medallion##2991 |goto Blasted Lands 66.90,19.47
step
Run up the stairs |goto The Hinterlands 47.74,66.60 < 10 |only if walking
kill Qiaga the Keeper##7996
|tip at the top of the Altar of Zul.
collect Sacred Mallet##9241 |goto 48.66,68.25 |q 2770 |future
step
Run up the stairs |goto 66.67,66.75 < 10 |only if walking
Continue up the stairs |goto 67.91,69.04 < 10 |only if walking
Follow the path |goto 67.78,70.69 < 10 |only if walking
Run up the stairs |goto 65.07,68.93 < 10 |only if walking
Follow the path |goto 63.77,70.68 < 10 |only if walking
Continue following the path |goto 65.39,72.99 < 10 |c |q 2770 |future
step
Run up the stairs |goto 67.16,73.31 < 10 |only if walking
Follow the path |goto 64.54,74.99 < 10 |only if walking
Run up the stairs |goto 62.17,71.38 < 10 |only if walking
Continue up the stairs |goto 59.92,70.16 < 10 |only if walking
Follow the path |goto 59.16,74.13 < 10 |c |q 2770 |future
step
use the Sacred Mallet##9241
collect Mallet of Zul'Farrak##9240 |goto 59.64,77.90 |q 2770 |future
step
Enter the building |goto Dustwallow Marsh 45.88,57.22
talk Tabetha##6546
|tip Inside the building.
accept Tiara of the Deep##2846 |goto Dustwallow Marsh 46.06,57.09
step
talk Wizzle Brassbolts##4453
accept Gahz'rilla##2770 |goto Thousand Needles 78.14,77.11
step
talk Yeh'kinya##8579
accept Screecher Spirits##3520 |goto Tanaris 66.98,22.36
step
kill Vale Screecher##5307
|tip These have a low spawn rate.
use Yeh'Kinya's Bramble##10699
|tip Use it on their corpse.
talk Screecher Spirit##8612
collect 3 Screecher Spirits |q 3520/1 |goto Feralas 58.31,57.70
step
talk Yeh'kinya##8579
turnin Screecher Spirits##3520 |goto Tanaris 66.98,22.36
accept The Prophecy of Mosh'aru##3527 |goto Tanaris 66.98,22.36
step
talk Chief Engineer Bilgewhizzle##7407
accept Divino-matic Rod##2768 |goto Tanaris 52.46,28.51
step
talk Tran'rek##7876
accept Scarab Shells##2865 |goto 51.57,26.76
step
talk Trenton Lighthammer##7804
accept Troll Temper##3042 |goto 51.42,28.75
step
Follow the path |goto Tanaris 39.02,20.95 < 10 |only if walking
Enter the Zul'Farrak dungeon with your group |goto Tanaris 38.73,19.97 < 5 |c
stickystart "Collect_5_Uncracked_Scarab_Shell"
stickystart "Collect_20_Troll_Temper"
step
Inside the Zul'Farrak Dungeon:
kill Theka the Martyr##7272
collect First Mosh'aru Tablet##10660 |q 3527/1
step
Inside the Zul'Farrak Dungeon:
kill Hydromancer Velratha##7795
|tip She patrols around the gong where you summon Gahz'rilla.
collect Tiara of the Deep##9234 |q 2846/1
collect Second Mosh'aru Tablet##10661 |q 3527/2
step
Inside the Zul'Farrak Dungeon:
use the Mallet of Zul'Farrak##9240
|tip Clear the room.
|tip Use it near the gong atop the pool of water.
kill Gahz'rilla##7273
collect Gahz'rilla's Electrified Scale##8707 |q 2770/1
step
Inside the Zul'Farrak Dungeon:
kill Nekrum Gutchewer##7796
|tip He will appear once you assist Sergeant Bly and company to escape from their prison.
collect Nekrum's Medallion##2991
step
Inside the Zul'Farrak Dungeon:
kill Sergeant Bly##7604
|tip He will be killable after you release them from captivity and clear the temple event.
collect Divino-matic Rod##8548 |q 2768/1
step
label "Collect_5_Uncracked_Scarab_Shell"
Inside the Zul'Farrak Dungeon:
kill Scarab##7269
|tip They are found all around the instance.
collect 5 Uncracked Scarab Shell##9238 |q 2865/1
step
label "Collect_20_Troll_Temper"
Inside the Zul'Farrak Dungeon:
Kill enemies around this area
|tip These drop from troll enemies inside of Zul'Farrak.
|tip It will likely take multiple runs to complete.
collect 20 Troll Temper##9523 |q 3042/1
step
Leave the Zul'Farak Dungeon
Click Here to Continue |confirm
step
talk Yeh'kinya##8579
turnin The Prophecy of Mosh'aru##3527 |goto Tanaris 66.98,22.36
step
talk Chief Engineer Bilgewhizzle##7407
turnin Divino-matic Rod##2768 |goto Tanaris 52.46,28.51
step
talk Tran'rek##7876
turnin Scarab Shells##2865 |goto 51.57,26.76
step
talk Trenton Lighthammer##7804
turnin Troll Temper##3042 |goto 51.42,28.75
step
talk Wizzle Brassbolts##4453
turnin Gahz'rilla##2770 |goto Thousand Needles 78.14,77.11
step
Enter the building |goto Dustwallow Marsh 45.88,57.22
talk Tabetha##6546
|tip Inside the building.
turnin Tiara of the Deep##2846 |goto Dustwallow Marsh 46.06,57.09
step
talk Thadius Grimshade##8022
|tip Upstairs inside the building, at the top.
turnin Nekrum's Medallion##2991 |goto Blasted Lands 66.90,19.47
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Maraudon Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Maraudon",
description="This guide will walk you through completing the Maraudon Quests.",
},[[
step
ding 45
step
Enter the building |goto Dustwallow Marsh 65.73,48.61 < 7 |walk
talk Archmage Tervosh##4967
|tip At the top of the tower.
accept Shadowshard Fragments##7070 |goto 66.42,49.26
step
talk Talendria##11715
|tip Upstairs inside the building.
accept Vyletongue Corruption##7041 |goto Desolace 68.50,8.87
step
Run up the ramp |goto Desolace 64.66,9.23 < 10 |only if walking
talk Keeper Marandis##13698
accept Corruption of Earth and Seed##7065 |goto 63.82,10.66
step
talk Willow##13656
|tip Inside the building.
accept Twisted Evils##7028 |goto Desolace 62.19,39.63
step
talk Centuar Pariah##13717
|tip He patrols around this area.
accept The Pariah's Instructions##7067 |goto Desolace 48.4,87.0
step
kill The Nameless Prophet##13718
|tip He spawns in multiple locations outside of the Maraudon dungeon.
|tip You may need help with this.
collect Amulet of Spirits##17757 |q 7067 |future
step
talk Cavindra##Cavindra
accept Legend of Maraudon##7044
step
use Coated Cerulean Vial##17693
collect Filled Cerulean Vial##17696 |q 7041/2
step
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Magra.
kill Magra##13740
collect Gem of the Third Khan##17763 |q 7067 |future
step
Kill Shadowshard enemies around this area
collect 10 Shadowshard Fragment##17756 |q 7070/1
step
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Gelk.
kill Gelk##13741
collect Gem of the Second Khan##17762 |q 7067 |future
step
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Kolk.
kill Kolk##13742
collect Gem of the First Khan##17761 |q 7067 |future
step
Follow the path up |goto Desolace 38.49,61.12 < 15 |only if walking
Run up the stairs |goto 29.84,62.50 < 10 |only if walking
click Stone Door
Enter the building |goto Kalimdor 38.43,57.97 < 7 |c
step
Follow the path |goto 38.34,58.12 < 10 |only if walking
Run down the stairs |goto 38.25,57.99 < 10 |only if walking
Continue following the path |goto 38.45,58.14 < 10 |only if walking
Run up the stairs |goto 38.69,58.16 < 10 |only if walking
Follow the path |goto 38.84,58.34 < 10 |only if walking
Continue following the path |goto 39.10,57.99 < 7 |only if walking
Enter the Maraudon (Foulspore Cavern - Orange) dungeon with your group |goto 39.27,58.19 < 5 |c
stickystart "Collect_15_Theradric_Crystal_Carving"
step
Inside the Maraudon Dungeon:
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Veng.
|tip He is on the Orange side of Maraudon.
kill Veng##13738
collect Gem of the Fifth Khan##17765 |q 7067 |future
step
Inside the Maraudon Dungeon:
use the Filled Cerulean Vial##17696
|tip While in the Foulspore Cavern, or Orange side of Maraudon, there will be tree stumps with a red top.
|tip You won't be able to target them.
|tip They have five leaves growing out of them.
|tip Use the Filled Cerulean Vial near them and Noxxious Scion will spawn.
kill Noxxious Scion##13696
Heal 8 Vylestem Vines |q 7041/1
step
Inside the Maraudon Dungeon:
kill Lord Vyletongue##12236
|tip He is a boss on the Orange side of Maraudon.
collect Celebrian Diamond##17703 |q 7044/1
step
Inside the Maraudon Dungeon:
kill Noxxion##13282
|tip It is a boss on the Orange side of Maraudon.
collect Celebrian Rod##17702 |q 7044/2
step
Inside the Maraudon Dungeon:
kill Celebras the Cursed##12225
talk Celebras the Redeemed##13716
|tip He will appear after you kill Celebras the Cursed.
turnin Legend of Maraudon##7044
accept The Scepter of Celebras##7046
step
Inside the Maraudon Dungeon:
Follow Celebras the Redeemed
|tip Click the stone he leads you to.
click Incantations of Celebras
Watch the Dialogue
Create the Scepter of Celebras |q 7046/1
step
Inside the Maraudon Dungeon:
talk Celebras the Redeemed##13716
turnin The Scepter of Celebras##7046
step
Leave the Maraudon - Orange Dungeon
Click Here to Continue |confirm
step
Enter the Maraudon - Purple dungeon with your group |goto Kalimdor 38.57,57.00 < 10 |c
step
Inside the Maraudon Dungeon:
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Maraudos.
|tip He patrols around the instance.
|tip He is on the Purple side of Maraudon.
kill Maraudos##13739
collect Gem of the Fourth Khan##17764 |q 7067 |future
step
Inside the Maraudon Dungeon:
use the Gem of the Fifth Khan##17765
collect Amulet of Union##17758 |q 7067/1
step
Inside the Maraudon Dungeon:
kill Princess Theradras##12201 |q 7065/1
step
Inside the Maraudon Dungeon:
talk Zaetar's Spirit##12238
|tip He will appear at the center of the room once Princess Theradras is killed.
accept Seed of Life##7066
step
label "Collect_15_Theradric_Crystal_Carving"
Inside the Maraudon Dungeon:
Kill enemies around this area
|tip These drop from enemies inside of Maraudon.
collect 15 Theradric Crystal Carving##17684 |q 7028/1
step
Leave the Maraudon Dungeon
Click Here to Continue |confirm
step
talk Centuar Pariah##13717
|tip He patrols around this area.
turnin The Pariah's Instructions##7067 |goto Desolace 48.4,87.0
step
talk Willow##13656
|tip Inside the building.
turnin Twisted Evils##7028 |goto Desolace 62.19,39.63
step
talk Talendria##11715
|tip Upstairs inside the building.
accept Vyletongue Corruption##7041 |goto Desolace 68.50,8.87
step
Run up the ramp |goto Desolace 64.66,9.23 < 10 |only if walking
talk Keeper Marandis##13698
accept Corruption of Earth and Seed##7065 |goto 63.82,10.66
step
Enter the building |goto Dustwallow Marsh 65.73,48.61 < 7 |walk
talk Archmage Tervosh##4967
|tip At the top of the tower.
accept Shadowshard Fragments##7070 |goto 66.42,49.26
step
talk Keeper Remulos##11832
turnin Seed of Life##7066 |goto Moonglade 36.18,41.82
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Temple of Atal'Hakkar Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\The Temple of Atal'Hakkar",
description="This guide will walk you through completing the Temple of Atal'Hakkar Quests.",
},[[
step
ding 47
step
Enter the building |goto Stormwind City 63.60,22.86 < 8 |walk
talk Brohann Caskbelly##5384
accept In Search of The Temple##1448 |goto 64.31,20.67
step
Search for the Temple of Atal'Hakkar |q 1448/1 |goto Swamp of Sorrows 66.82,59.39
step
Enter the building |goto Stormwind City 63.60,22.86 < 8 |walk
talk Brohann Caskbelly##5384
turnin In Search of The Temple##1448 |goto 64.31,20.67
accept To The Hinterlands##1449 |goto 64.31,20.67
step
talk Falstad Wildhammer##5635
turnin To The Hinterlands##1449 |goto The Hinterlands 11.81,46.76
accept Gryphon Master Talonaxe##1450 |goto The Hinterlands 11.81,46.76
step
Run up the ramp |goto The Hinterlands 11.75,46.90 < 10 |only if walking
Enter the building |goto 11.00,45.68 < 10 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
turnin Gryphon Master Talonaxe##1450 |goto 9.75,44.48
accept Rhapsody Shindigger##1451 |goto 9.75,44.48
step
Leave the building |goto 11.00,45.68 < 10 |walk
Run down the ramp |goto 11.28,46.05 < 10 |only if walking
Continue down the ramp |goto 12.10,46.34 < 10 |only if walking
Follow the path |goto 12.35,47.46 < 10 |only if walking
Continue following the path |goto 11.59,49.60 < 10 |only if walking
Follow the path up |goto 52.20,30.80 < 10 |only if walking
talk Rhapsody Shindigger##5634
turnin Rhapsody Shindigger##1451 |goto 52.88,30.88
accept Rhapsody's Kalimdor Kocktail##1452 |goto 52.88,30.88
step
Kill Roc enemies around this area
collect 3 Roc Gizzard##6257 |q 1452/1 |goto Tanaris 43.48,40.36
step
Kill Ironfur enemies around this area
|tip They share a spawn with Groddoc enemies around this area.
collect 3 Ironfur Liver##6258 |q 1452/2 |goto Feralas 49.93,30.39
You Can Find More Around Here [46.20,25.09]
step
Kill Groddoc enemies around this area
|tip They share a spawn with Ironfur enemies around this area.
collect 3 Groddoc Liver##6259 |q 1452/3 |goto Feralas 49.93,30.39
You Can Find More Around Here [46.20,25.09]
step
Follow the path up |goto The Hinterlands 21.02,47.81 < 15 |only if walking
talk Rhapsody Shindigger##5634
turnin Rhapsody's Kalimdor Kocktail##1452 |goto 26.94,48.59
Watch the Dialogue
accept Rhapsody's Tale##1469 |goto 26.94,48.59
step
Enter the building |goto Stormwind City 63.65,22.80 < 8 |walk
talk Brohann Caskbelly##5384
turnin Rhapsody's Tale##1469 |goto 64.33,20.65
accept Into The Temple of Atal'Hakkar##1475 |goto 64.33,20.65
step
Enter the building |goto Feralas 31.84,45.02 < 5 |walk
talk Angelas Moonbreeze##7900
accept The Sunken Temple##3445 |goto 31.83,45.61
step
talk Marvon Rivetseeker##7771
turnin The Sunken Temple##3445 |goto Tanaris 52.71,45.92
accept The Stone Circle##3444 |goto Tanaris 52.71,45.92
step
click Marvon's Chest
collect Stone Circle##10556 |q 3444/1 |goto The Barrens 62.50,38.54
step
talk Marvon Rivetseeker##7771
turnin The Stone Circle##3444 |goto Tanaris 52.71,45.92
accept Into the Depths##3446 |goto Tanaris 52.71,45.92
step
talk Yeh'kinya##8579
accept Screecher Spirits##3520 |goto Tanaris 66.98,22.36
step
kill Vale Screecher##5307
|tip These have a low spawn rate.
use Yeh'Kinya's Bramble##10699
|tip Use it on their corpse.
talk Screecher Spirit##8612
collect 3 Screecher Spirits |q 3520/1 |goto Feralas 58.31,57.70
step
talk Yeh'kinya##8579
turnin Screecher Spirits##3520 |goto Tanaris 66.98,22.36
accept The Prophecy of Mosh'aru##3527 |goto Tanaris 66.98,22.36
step
Enter the Zul'Farrak Dungeon with your Group |goto Tanaris 38.73,19.99 < 8 |q 3527 |future
step
Inside the Zul'Farrak Dungeon:
kill Theka the Martyr##7272
collect First Mosh'aru Tablet##10660 |q 3527/1
step
Inside the Zul'Farrak Dungeon:
kill Hydromancer Velratha##7795
|tip She patrols around the gong where you summon Gahz'rilla.
collect Tiara of the Deep##9234 |q 2846/1
collect Second Mosh'aru Tablet##10661 |q 3527/2
step
Leave the Zul'Farrak Dungeon
Click Here to Continue |confirm |q 3527 |future
step
talk Yeh'kinya##8579
turnin The Prophecy of Mosh'aru##3527 |goto Tanaris 66.98,22.36
accept The Ancient Egg##4787 |goto Tanaris 66.98,22.36
step
Enter the building |goto Swamp of Sorrows 47.23,54.36 < 7 |walk
talk Fel'zerul##1443
accept Pool of Tears##1424 |goto 47.94,54.79
step
use an Elixir of Water Breathing##5996
click Atal'ai Tablet+
|tip They look like various small objects on the ground underwater around this area.
|tip You can find them all around this large lake.
collect 10 Atal'ai Tablet##6175 |q 1424/1 |goto 67.14,58.70
step
Enter the building |goto Swamp of Sorrows 47.23,54.36 < 7 |walk
talk Fel'zerul##1443
turnin Pool of Tears##1424 |goto 47.94,54.79
accept The Atal'ai Exile##1429 |goto 47.94,54.79
step
Follow the path |goto The Hinterlands 35.78,64.12 < 15 |only if walking
Run up the stairs |goto 33.09,73.80 < 15 |only if walking
Jump down here |goto 33.11,75.53 < 7 |only if walking
talk Atal'ai Exile##5598
turnin The Atal'ai Exile##1429 |goto 33.75,75.22
accept Return to Fel'Zerul##1444 |goto 33.75,75.22
accept Jammal'an the Prophet##1446 |goto 33.75,75.22
step
Follow the path |goto The Hinterlands 35.79,64.07 < 15 |only if walking
Run up the stairs |goto 66.70,66.71 < 8 |only if walking
Follow the path |goto 66.63,68.83 < 10 |only if walking
Run up the stairs |goto 67.93,69.12 < 10 |only if walking
Follow the path |goto 67.78,70.73 < 10  |c |q 4787 |future
step
Run up the stairs |goto 65.08,68.94 < 8 |only if walking
Follow the path |goto 63.69,70.44 < 10 |only if walking
Continue following the path |goto 65.38,72.92 < 10 |only if walking
Run up the stairs |goto 67.14,73.37 < 8 |only if walking
Follow the path |goto 67.15,75.46 < 10 |c |q 4787 |future
step
Follow the path |goto 64.52,74.83 < 10 |only if walking
Run up the stairs |goto 62.16,71.38 < 10 |only if walking
Continue up the stairs |goto 59.96,70.17 < 10 |only if walking
Follow the path |goto 58.68,70.28 < 10 |only if walking
Continue following the path |goto 59.15,74.30 < 10 |c |q 4787 |future
step
Enter the cave |goto 58.61,79.19 < 10 |walk
Follow the path down |goto 58.26,82.31 < 10 |walk
Follow the path up |goto 54.81,83.42 < 10 |walk
click Ancient Egg
collect Ancient Egg##12402 |q 4787/1 |goto 57.52,86.78
step
talk Yeh'kinya##8579
turnin The Ancient Egg##4787 |goto Tanaris 66.98,22.36
accept The God Hakkar##3528 |goto Tanaris 66.98,22.36
step
Enter the building |goto Swamp of Sorrows 47.23,54.36 < 7 |walk
talk Fel'zerul##1443
turnin Return to Fel'Zerul##1444 |goto 47.94,54.79
accept The Temple of Atal'Hakkar##1445 |goto 47.94,54.79
step
Follow the path up |goto Un'Goro Crater 45.72,13.08 < 10 |only if walking
talk Muigin##9119
accept Muigin and Larion##4141 |goto 42.94,9.65
step
label "Collect_Bloodpetals"
Kill Bloodpetal enemies around this area
|tip They look like walking plants.
collect 15 Bloodpetal##11316 |q 4141/1 |goto 71.46,38.72
|tip These have a low drop rate.
You can find more around: |notinsticky
[69.26,24.59]
[66.08,35.13]
[55.87,34.69]
[41.91,27.10]
step
Follow the path up |goto Un'Goro Crater 45.72,13.08 < 10 |only if walking
talk Muigin##9119
turnin Muigin and Larion##4141 |goto 42.94,9.65
accept A Visit to Gregan##4142 |goto 42.94,9.65
step
Follow the path up |goto Feralas 47.28,44.56 < 15 |only if walking
Follow the path |goto 48.66,44.98 < 15 |only if walking
Continue following the path |goto 47.87,36.21 < 15 |only if walking
Follow the path down |goto 48.22,32.73 < 15 |only if walking
Follow the path up |goto 45.70,25.74 < 15 |only if walking
talk Gregan Brewspewer##7775
turnin A Visit to Gregan##4142 |goto 45.12,25.56
accept Haze of Evil##4143 |goto 45.12,25.56
step
Run up the stairs |goto Swamp of Sorrows 56.28,76.52 < 10 |only if walking
Enter the building |goto 56.33,76.26 < 10 |c
step
Follow the path down |goto 56.30,76.17 < 10 |walk
Swim through the water |goto 56.35,76.16 < 10 |walk
Run up the stairs |goto 56.45,75.80 < 10 |walk
Follow the path |goto 56.42,75.72 < 5 |walk
Continue following the path |goto 56.46,75.55 < 5 |walk
Run down the stairs |goto 56.51,75.57 < 5 |c
step
Follow the path |goto 56.72,75.73 < 5 |walk
Continue following the path |goto 56.90,75.89 < 10 |walk
Follow the path |goto 56.87,76.00 < 5 |walk
Continue following the path |goto 57.00,76.04 < 5 |walk
Continue following the path |goto 57.08,75.58 < 5 |c
step
click Atal'ai Tablet##11185
|tip They are along the walls around this area.
collect 10 Atal'ai Tablet##6288  |q 1475/1 |goto 57.08,75.58
step
Run down the stairs |goto 56.90,75.51 < 5 |walk
Follow the path |goto 56.93,75.37 < 5 |walk
Continue following the path |goto 56.81,75.32 < 5 |walk
Enter The Temple of Atal'Hakkar dungeon with your group |goto 56.81,75.17 < 5 |c
stickystart "Collect_20_Fetish_of_Hakkar"
stickystart "Collect_5_Atal'ai_Haze"
step
Inside the Temple of Atal'Hakkar Dungeon:
Find the Altor of Hakkar in the Sunken Temple |q 3446/1
|tip Once in the Pit of Refuse, in this order:
|tip Click the South, North, Southwest, Northwest then finally the Northeast altar.
|tip Jump down and kill Atal'alarion.
|tip Run up the stairs.
click Altar of Hakkar
turnin Into the Depths##3446
accept Secret of the Circle##3447
step
Inside the Temple of Atal'Hakkar Dungeon:
click Idol of Hakkar
|tip At the center of the room down in The Pit of Refuse.
turnin Secret of the Circle##3447
step
Inside the Temple of Atal'Hakkar Dungeon:
kill Jammal'an the Prophet##5710
collect Head of Jammal'an##6212 |q 1446/1
step
Inside the Temple of Atal'Hakkar Dungeon:
kill Shade of Eranikus##5709
accept The Essence of Eranikus##3373
step
Inside the Temple of Atal'Hakkar Dungeon:
click Essence Font
|tip It is in the left corner of the room where the Shade of Eranikus is.
turnin The Essence of Eranikus##3373
step
Inside the Temple of Atal'Hakkar Dungeon:
use the Egg of Hakkar##10465
|tip Use it in the Sanctum of the Fallen God.
|tip There will be a skeleton on the ground surrounded by candals.
|tip Kill adds that spawn and collect Hakkari Blood.
|tip Use the Hakkari Blood to put out the braziers in the room.
kill Shade of Hakkar##8440
collect Essence of Hakkar##10663 |n
use the Essence of Hakkar##10663
Fill the Egg of Hakkar |q 3528/1
step
label "Collect_20_Fetish_of_Hakkar"
Inside the Temple of Atal'Hakkar Dungeon:
Kill Atal'ai enemies around this area
collect 20 Fetish of Hakkar##6181 |q 1445/1
|tip These can also drop outside of the instance.
step
label "Collect_5_Atal'ai_Haze"
Inside the Temple of Atal'Hakkar Dungeon:
Kill enemies around this area
|tip Murk Worms, Deep Lurkers and Saturated Oozes specifically drop the quest item.
collect 5 Atal'ai Haze##11318 |q 4143/1
step
Leave the Temple of Atal'Hakkar
Click Here to Continue |confirm
step
Enter the building |goto Swamp of Sorrows 47.23,54.36 < 7 |walk
talk Fel'zerul##1443
turnin The Temple of Atal'Hakkar##1445 |goto 47.94,54.79
step
Enter the building |goto Stormwind City 63.65,22.80 < 8 |walk
talk Brohann Caskbelly##5384
turnin Into The Temple of Atal'Hakkar##1475 |goto 64.33,20.65
step
Follow the path |goto The Hinterlands 35.78,64.12 < 15 |only if walking
Run up the stairs |goto 33.09,73.80 < 15 |only if walking
Jump down here |goto 33.11,75.53 < 7 |only if walking
talk Atal'ai Exile##5598
turnin Jammal'an the Prophet##1446 |goto 33.75,75.22
step
Follow the path up |goto Un'Goro Crater 45.72,13.08 < 10 |only if walking
talk Muigin##9119
turnin Haze of Evil##4143 |goto 42.94,9.65
step
talk Yeh'kinya##8579
turnin The God Hakkar##3528 |goto Tanaris 66.98,22.36
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Raid Attunements\\Blackwing Lair Attunement",{
author="support@zygorguides.com",
description="This guide will walk you through becoming attuned for the Blackwing Lair raid.",
},[[
step
Reach level 55 |ding 55
|tip Use the Leveling guides to accomplish this.
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run up the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Jump down here |goto 48.77,63.67 < 5 |walk
Follow the path up |goto 48.83,63.66 < 5 |walk
Enter the building |goto 48.91,63.92 < 5 |walk
Follow the path |goto 48.95,63.93 < 5 |walk
Follow the path down |goto 49.01,64.12 < 5 |walk
kill Scarshield Quartermaster##9046
|tip He walks around this area.
collect Blackhand's Command##18987 |goto 49.12,64.10 |condition itemcount(18987) == 1 or havequest(7761) or completedq(7761)
step
use Blackhand's Command##18987
accept Blackhand's Command##7761
step
Enter the Blackrock Spire dungeon with your group |goto 48.95,63.88 < 7 |q 7761
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
kill General Drakkisath##10363
|tip Use the Dungeon guides to accomplish this.
click Drakkisath's Brand##179880
|tip It looks like a large glowing blue totem behind General Drakkisath.
turnin Blackhand's Command##7761
|tip Turning this in will allow you to teleport directly to Blackwing Lair by clicking the Orb of Command.
|tip It is located down the southern hallway outside of the dungeon entrance.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Raid Attunements\\Molten Core Attunement",{
author="support@zygorguides.com",
description="This guide will walk you through becoming attuned for the Molten Core raid.",
},[[
step
Reach level 55 |ding 55
|tip Use the Leveling guides to accomplish this.
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run down the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Run down the stairs |goto 48.65,64.16 < 5 |walk
Continue down the stairs |goto 48.62,64.26 < 5 |q 7848 |future
step
Run down the stairs |goto 48.62,64.11 < 7 |walk
Follow the path down |goto 48.68,64.07 < 7 |walk
Run down the chain |goto 48.58,64.09 < 5 |walk
talk Lothos Riftwaker##14387
accept Attunement to the Core##7848 |goto 48.41,63.82
step
Enter the building |goto 48.44,63.83 < 5 |walk
Follow the path |goto 48.15,63.34 < 15 |walk
Enter the Blackrock Depths dungeon with your group |goto 48.08,62.41 < 7 |q 7848
|tip This quest requires you to progress through the Blackrock Depths dungeon.
|tip You will likely need a full group to complete the quest.
step
Inside the Blackrock Depths Dungeon:
Reach the room with Lord Incendius
|tip The fastest way to reach him is to pick the locked door to the left after entering the dungeon.
|tip Continue straight through the Detention Block and into the Dark Iron Hallway.
|tip Follow the path north east through the Dark Iron Hallway and through the Shadowforge City.
|tip If you are doing a normal dungeon run you can use the Dungeon guides to accomplish this.
Jump down from Lord Incendius' platform and into the lava below
Hug the left side of the room and you'll be able to swim from the lava up onto a small section of land
Follow this left wall as far as you can, after a short while you'll have to swim through lava
You'll pass a small island with Fireguard Destroyers on it and then past them will be a bridge
Follow the path up and across the bridge, killing the addional Fireguard Destroyers
On the left side of the bridge, before the green portal is the Core Fragment
click Core Fragment##179553
collect Core Fragment##18412 |q 7848/1
step
talk Lothos Riftwaker##14387
turnin Attunement to the Core##7848 |goto 48.41,63.82
|tip Turning this in will allow you to teleport directly to Molten Core by talking to Lothos Riftwaker.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Raid Attunements\\Onyxia's Lair Attunement",{
author="support@zygorguides.com",
description="This guide will walk you through becoming attuned for the Onyxia's Lair raid.",
},[[
step
Reach level 48 |ding 48
|tip Use the Leveling guides to accomplish this.
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Helendis Riverhorn##9562
accept Dragonkin Menace##4182 |goto 85.82,68.95
stickystart "Slay_Black_Dragonspawns"
stickystart "Slay_Black_Drake"
stickystart "Slay_Black_Wrymkins"
step
kill 15 Black Broodling##7047 |q 4182/1 |goto 89.18,53.85
You can find more around [91.51,35.35]
step
label "Slay_Black_Dragonspawns"
kill 10 Black Dragonspawn##7040 |q 4182/2 |goto 92.05,53.82
|tip These enemies are Elite, you may need a group to complete this.
You can find more around: |notinsticky
[88.72,37.56]
[84.45,27.50]
step
label "Slay_Black_Drake"
kill 1 Black Drake##7044 |q 4182/3 |goto 89.18,53.85
|tip These enemies are Elite, you may need a group to complete this.
You can find more around [91.51,35.35]
step
label "Slay_Black_Wrymkins"
kill 4 Black Wyrmkin##7041 |q 4182/4 |goto 92.05,53.82
|tip These enemies are Elite, you may need a group to complete this.
You can find more around: |notinsticky
[88.72,37.56]
[84.45,27.50]
step
Follow the path up |goto 82.89,63.37 < 7 |only if walking
talk Helendis Riverhorn##9562
turnin Dragonkin Menace##4182 |goto 85.82,68.95
accept The True Masters##4183 |goto 85.82,68.95
step
Enter the building |goto Redridge Mountains 29.51,46.07 < 5 |walk
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4183 |goto 29.98,44.45
accept The True Masters##4184 |goto 29.98,44.45
step
Enter the building |goto Stormwind City 69.19,28.59 < 7 |walk
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4184 |goto 78.22,17.99
accept The True Masters##4185 |goto 78.22,17.99
step
talk Lady Katrana Prestor##1749
|tip Inside the building.
Tell her _"Pardon the intrusion, Lady Prestor, but Highlord Bolvar suggested that I seek your advice."_
|tip Click through the dialogue.
Receive Advice From Lady Prestor |q 4185/1 |goto 78.10,17.75
step
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4185 |goto 78.22,17.99
accept The True Masters##4186 |goto 78.22,17.99
step
Enter the building |goto Redridge Mountains 29.51,46.07 < 5 |walk
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4186 |goto 29.98,44.45
accept The True Masters##4223 |goto 29.98,44.45
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin The True Masters##4223 |goto 84.75,69.02
accept The True Masters##4224 |goto 84.75,69.02
step
Follow the path up |goto 63.86,30.11 < 10 |only if walking
talk Ragged John##9563
Tell him _"Official business, John. I need some information about Marshal Windsor. Tell me about the last time you saw him."_
|tip Click through the dialogue.
Hear Ragged John's Story |q 4224/1 |goto 65.02,23.76
step
Follow the path up |goto 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin The True Masters##4224 |goto 84.75,69.02
accept Marshal Windsor##4241 |goto 84.75,69.02
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run down the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Run down the stairs |goto 48.65,64.16 < 5 |walk
Continue down the stairs |goto 48.62,64.26 < 5 |c |q 4241
|tip This quest requires you to progress through the Blackrock Depths dungeon.
|tip You will likely need a full group to complete the quest.
step
Run down the stairs |goto 48.62,64.11 < 7 |walk
Follow the path down |goto 48.68,64.07 < 7 |walk
Run down the chain |goto 48.58,64.09 < 5 |walk
Enter the building |goto 48.44,63.83 < 5 |walk
Follow the path |goto 48.15,63.34 < 15 |walk
Enter the Blackrock Depths dungeon with your group |goto 48.08,62.41 < 7 |c |q 4241
|tip This quest requires you to progress through the Blackrock Depths dungeon.
|tip You will likely need a full group to complete the quest.
step
Inside the Blackrock Depths Dungeon:
kill High Interrogator Gerstahn##9018
|tip She is the fourth boss in the dungeon.
|tip Use the Dungeon guides to accomplish this.
collect Prison Cell Key##11140 |q 4241
|tip You need this key to unlock Marshal Windsor's cell door.
|tip If someone else in the group already has the key you can skip this step.
|tip A Rogue can also pick the lock.
step
Inside the Blackrock Depths Dungeon:
talk Marshal Windsor##9023
|tip He is in a prison cell inside the Detention Block.
|tip After entering the dungeon enter the first room and then take the third tunnel on the right.
|tip If you enter the Halls of the Law you went too far.
turnin Marshal Windsor##4241
accept Abandoned Hope##4242
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin Abandoned Hope##4242 |goto 84.75,69.02
step
Reach level 50 |ding 50
|tip Use the Leveling guides to accomplish this.
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run down the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Run down the stairs |goto 48.65,64.16 < 5 |walk
Continue down the stairs |goto 48.62,64.26 < 5 |q 4264 |future
|tip This quest requires you to progress through the Blackrock Depths dungeon.
|tip You will likely need a full group to complete the quest.
step
Run down the stairs |goto 48.62,64.11 < 7 |walk
Follow the path down |goto 48.68,64.07 < 7 |walk
Run down the chain |goto 48.58,64.09 < 5 |walk
Enter the building |goto 48.44,63.83 < 5 |walk
Follow the path |goto 48.15,63.34 < 15 |walk
Enter the Blackrock Depths dungeon with your group |goto 48.08,62.41 < 7 |q 4264 |future
|tip This quest requires you to progress through the Blackrock Depths dungeon.
|tip You will likely need a full group to complete the quest.
step
Inside the Blackrock Depths Dungeon:
Kill Anvilrage dwarves at the beginning of the dungeon
|tip Just clear the first few rooms of the dungeon, killing all the Anvilrage dwarves and resetting the instance if needed, until you get the item drop.
collect A Crumpled Up Note##11446 |condition itemcount(11446) == 1 or havequest(4264) or completedq(4264)
step
use A Crumpled Up Note##11446
accept A Crumpled Up Note##4264
step
Inside the Blackrock Depths Dungeon:
kill High Interrogator Gerstahn##9018
|tip She is the fourth boss in the dungeon.
|tip Use the Dungeon guides to accomplish this.
collect Prison Cell Key##11140 |q 4264
|tip You need this key to unlock Marshal Windsor's cell door.
|tip If someone else in the group already has the key you can skip this step.
|tip A Rogue can also pick the lock.
step
Inside the Blackrock Depths Dungeon:
talk Marshal Windsor##9023
|tip He is in a prison cell inside the Detention Block.
|tip After entering the dungeon enter the first room and then take the third tunnel on the right.
|tip If you enter the Halls of the Law you went too far.
turnin A Crumpled Up Note##4264
accept A Shred of Hope##4282
step
Inside the Blackrock Depths Dungeon:
kill General Angerforge##9033
|tip Use the Dungeon guides to accomplish this.
collect Marshal Windsor's Lost Information##11464 |q 4282/1
step
Inside the Blackrock Depths Dungeon:
kill Golem Lord Argelmach##8983
|tip Use the Dungeon guides to accomplish this.
collect Marshal Windsor's Lost Information##11465 |q 4282/2
step
Inside the Blackrock Depths Dungeon:
talk Marshal Windsor##9023
|tip He is in a prison cell inside the Detention Block.
|tip After entering the dungeon enter the first room and then take the third tunnel on the right.
|tip If you enter the Halls of the Law you went too far.
turnin A Shred of Hope##4282
|tip Make sure everyone turns this quest in before anyone accepts the next one.
|tip Accepting Jail Break! will start the escort quest and other party members will not be able to interact with Marshal Windsor.
accept Jail Break!##4322
step
Inside the Blackrock Depths Dungeon:
Follow and protect Marshal Windsor
|tip He will walk around the Detention Block and Halls of the Law, so clearing these beforehand can be helpful.
|tip There will be a few cells he will have you open. Sometimes you'll have to fight the prisoners or talk to a friendly NPC to free them.
|tip Eventually he will walk back to the dungeon entrance and escape.
Jail Break! |q 4322/1
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin Jail Break!##4322 |goto 84.75,69.02
accept Stormwind Rendezvous##6402 |goto 84.75,69.02
step
talk Squire Rowe##17804 |goto Stormwind City 70.52,85.07
Tell him _"Let Marshal Windsor know that I am ready."_
|confirm |q 6402
step
talk Reginald Windsor##12580
turnin Stormwind Rendezvous##6402 |goto 69.71,86.07
accept The Great Masquerade##6403 |goto 69.71,86.07
step
Watch the dialogue
Follow Reginald Windsor through Stormwind |goto 68.01,30.07 < 10 |q 6403
step
talk Reginald Windsor##12580 |goto 68.01,30.07
Tell him _"I am ready, as are my forces. Let us end this masquerade!"_
|confirm |q 6403
step
Enter the building |goto 69.17,28.63 < 7 |walk
Watch the dialogue
kill Onyxia's Elite Guard##12739+
|tip Inside the building.
Complete Reginald Windsor's March |q 6403/1 |goto 78.10,17.95
step
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The Great Masquerade##6403 |goto 78.22,17.99
accept The Dragon's Eye##6501 |goto 78.22,17.99
step
Follow the path up |goto Winterspring 59.30,43.21 < 10 |only if walking
Enter the cave |goto 57.15,49.93 < 7 |walk
Follow the path down |goto 54.65,49.94 < 10 |only if walking
Step onto the Blue Rune |goto 52.65,55.78
|tip Inside the cave.
Teleport to Haleh |goto 54.56,51.27 < 5 |noway |q 6501
step
talk Haleh##10929
turnin The Dragon's Eye##6501 |goto 54.55,51.20
accept Drakefire Amulet##6502 |goto 54.55,51.20
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run up the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Jump down here |goto 48.77,63.67 < 5 |walk
Follow the path up |goto 48.83,63.66 < 5 |walk
Enter the building |goto 48.91,63.92 < 5 |walk
Enter the Blackrock Spire dungeon with your group |goto 48.95,63.88 < 7 |q 6502
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
kill General Drakkisath##10363
|tip Use the Dungeon guides to accomplish this.
collect Blood of the Black Dragon Champion##16663 |q 6502/1
step
Follow the path up |goto Winterspring 59.30,43.21 < 10 |only if walking
Enter the cave |goto 57.15,49.93 < 7 |walk
Follow the path down |goto 54.65,49.94 < 10 |only if walking
Step onto the Blue Rune |goto 52.65,55.78
|tip Inside the cave.
Teleport to Haleh |goto 54.56,51.27 < 5 |noway |q 6502
step
talk Haleh##10929
turnin Drakefire Amulet##6502 |goto 54.55,51.20
|tip Completing this quest will award you with a Darkfire Amulet, which will allow you to enter the Onyxia's Lair raid.
|tip You must keep it in your inventory in order to enter the raid instance.
]])
