local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("DungeonHCLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "CLA"
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Ragefire Chasm (13-18)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Ragefire Chasm",
description="This guide will walk you through the Ragefire Chasm dungeon.",
lfgid=2437,
},[[
step
Follow the path |goto Orgrimmar 52.00,57.84 < 15 |only if walking
Follow the path down |goto 56.07,41.08 < 10 |only if walking
Enter the Ragefire Chasm dungeon with your group |goto 52.75,48.86 < 7 |c
step
kill Oggleflint##11517
|tip Oggleflint has two guards so CC one before pulling, if able.
|tip The tank should keep him facing away from the rest of the group to avoid his "Cleave" ability.
|tip Kill the adds and then focus on killing Oggleflint.
Click Here to Continue |confirm
step
kill Taragaman the Hungerer##11520
|tip The tank should keep him away from the edges of the platform to avoid being knocked into the lava from his "Uppercut" ability.
|tip The healer and DPS should stay as far away as possible to avoid damage from his "Fire Nova" ability, if possible.
Click Here to Continue |confirm
step
kill Jergosh the Invoker##11518
|tip Jergosh has two guards with him so CC one before pulling, if able.
|tip Kill the adds and then focus on killing Jergosh.
Click Here to Continue |confirm
step
kill Bazzalan##11519
|tip The Searing Blade Cultist to the right of the boss can be pulled by itself and should be killed before pulling the boss.
|tip CC the second Searing Blade Cultist and then focus on kill Bazzalan.
]])
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
Run up the stairs |goto The Deadmines 41.20,79.03 < 5 |walk
Follow the path |goto 41.15,79.10 < 5 |walk
Follow the ramp down |goto 41.20,79.11 < 7 |c
step
Jump down here |goto 41.19,79.25 < 5 |walk
Enter the Deadmines dungeon with your group |goto 52.75,48.86 < 7 |c
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
kill Baelog##6906
|tip He is accompanied by Eric "The Swift" and Olaf.
|tip Use Crowd Control on Baelog.
|tip After, the tank should pick up Olaf.
|tip Then, all DPS should focus down Eric "The Swift".
|tip Refresh Crowd Control on Baelog then kill Olaf.
|tip Finish off Baelog to conclude the fight.
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
Enter the building |goto Kalimdor 38.43,57.98 < 5 |walk
Jump down here |goto 38.33,58.00 < 10 |walk
Jump down here |goto 38.30,58.18 < 10 |c
step
Jump down here |goto 38.27,58.00 < 10 |walk
Follow the path down |goto 38.43,57.86 < 10 |walk
Cross the bridge |goto 38.53,57.80 < 10 |walk
Follow the path |goto 38.64,57.68 < 10 |walk
Continue following the path |goto 38.42,57.42 < 10 |walk
Enter the Maraudon - Purple dungeon with your group |goto 38.57,57.00 < 10 |c
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
Follow the path |goto Desolace 29.76,67.46 < 15 |only if walking
Continue following the path |goto 31.61,65.09 < 10 |only if walking
Continue following the path |goto 33.34,63.39 < 7 |only if walking
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
Follow the path |goto Desolace 29.76,67.46 < 15 |only if walking
Continue following the path |goto 31.61,65.09 < 10 |only if walking
Continue following the path |goto 33.34,63.39 < 7 |only if walking
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
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul West (58-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Dire Maul",
description="This guide will walk you through the Dire Maul - West dungeon.",
lfgid=2559,
},[[
step
Run up the ramp |goto Kalimdor 42.75,70.26 < 10 |only if walking
Follow the path |goto 42.77,69.24 < 15 |only if walking
Continue following the path |goto 43.29,69.17 < 10 |only if walking
Continue following the path |goto 43.30,68.63 < 10 |only if walking
Follow the path |goto 43.48,68.52 < 10 |c
step
Run down the ramp |goto 43.31,68.32 < 10 |only if walking
Follow the path |goto 43.14,68.10 < 10 |only if walking
Run up the ramp |goto 43.11,67.66 < 10 |only if walking
click Door
|tip The key drops from Pusillin in the "Dire Maul - East" dungeon.
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
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Ragefire Chasm Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Ragefire Chasm",
description="This guide will walk you through completing the Ragefire Chasm Quests.",
},[[
step
ding 9
step
talk Rahauro##11833
|tip He walks around this area.
accept Searching for the Lost Satchel##5722 |goto Thunder Bluff 70.32,29.55
accept Testing an Enemy's Strength##5723 |goto Thunder Bluff 70.32,29.55
step
Enter the tunnel |goto Undercity 51.93,64.78 < 10 |only if walking
Follow the path |goto 45.95,73.73 < 10 |only if walking
talk Varimathras##2425
accept The Power to Destroy...##5725 |goto 56.26,92.19
step
Enter the building |goto Orgrimmar 40.07,37.01 < 10 |walk
talk Thrall##4949
|tip Inside the building.
accept Hidden Enemies##5726 |goto 31.79,37.84
step
Follow the path |goto Durotar 46.20,14.07 < 15 |only if walking
Continue following the path |goto 49.62,13.38 < 15 |only if walking
Follow the path down |goto 53.51,11.65 < 15 |only if walking
Enter the cave |goto 54.96,9.64 < 15 |walk
Kill Burning Blade enemies around this area
collect Lieutenant's Insignia##14544 |q 5726/1 |goto 53.83,9.04
step
Leave the cave |goto 54.96,9.64 < 15 |walk
Follow the path |goto 53.51,11.65 < 15 |only if walking
Continue following the path |goto 49.62,13.38 < 15 |only if walking
Follow the path |goto Durotar 46.20,14.07 < 15 |only if walking
Enter Orgrimmar |goto Orgrimmar 49.08,94.82 < 15 |c
step
Enter the building |goto Orgrimmar 40.07,37.01 < 10 |walk
talk Thrall##4949
|tip Inside the building.
turnin Hidden Enemies##5726 |goto 31.79,37.84
accept Hidden Enemies##5727 |goto 31.79,37.84
step
Leave the building |goto Orgrimmar 40.07,37.01 < 10 |walk
Follow the path |goto 54.40,35.58 < 15 |only if walking
Follow the path down |goto 55.22,40.76 < 15 |only if walking
talk Neeru Fireblade##3216
|tip Inside the building.
Tell him _"You may speak frankly, Neeru..."_
Gauge Neeru Fireblade's Reaction to Being a Member of the Burning Blade |q 5727/1 |goto 49.47,50.63
step
Follow the path up |goto 48.35,49.33 < 10 |only if walking
Follow the path |goto 56.91,40.80 < 10 |only if walking
Enter the building |goto Orgrimmar 40.07,37.01 < 10 |walk
talk Thrall##4949
|tip Inside the building.
turnin Hidden Enemies##5727 |goto 31.79,37.84
accept Hidden Enemies##5728 |goto 31.79,37.84
step
talk Neeru Fireblade##3216
|tip Inside the building.
accept Slaying the Beast##5761 |goto Orgrimmar 49.49,50.60
step
Enter the Ragefire Chasm dungeon with your group |goto Orgrimmar 52.75,48.86 < 10 |c
step
stickystart "Slay_8_Ragefire_Trogg"
stickystart "Slay_8_Ragefire_Shaman"
stickystart "Collect_Incantations_from_the_Nether"
Inside the Ragefire Chasm Spire Dungeon:
talk Maur Grimtotem##11834
|tip Follow long path down and take the first right.
|tip Run up the ramp in the room, killing the troggs.
|tip Maur Grimtotem will be on the floor up in the room.
turnin Searching for the Lost Satchel##5722
accept Returning the Lost Satchel##5724
step
Inside the Ragefire Chasm Spire Dungeon:
kill Taragaman the Hungerer##11520
collect Taragaman the Hungerer's Heart##14540 |q 5761/1
step
label "Slay_8_Ragefire_Trogg"
Inside the Ragefire Chasm Spire Dungeon:
kill Ragefire Trogg##11318
|tip These are found throughout the instance.
Slay #8# Ragefire Troggs |q 5723/1
step
label "Slay_8_Ragefire_Shaman"
Inside the Ragefire Chasm Spire Dungeon:
kill 8 Ragefire Shaman##11319
|tip These are found throughout the instance.
Slay #8# Ragefire Shaman |q 5723/2
step
label "Collect_Incantations_from_the_Nether"
Inside the Ragefire Chasm Spire Dungeon:
Kill Searing Blade enemies around this area
collect Incantations from the Nether##14396 |q 5725/1
step
Inside the Ragefire Chasm Spire Dungeon:
kill Bazzalan##11519 |q 5728/1
step
Inside the Ragefire Chasm Spire Dungeon:
kill Jergosh the Invoker##11518 |q 5728/2
step
Leave the Ragefire Chasm Instance
Click Here to Continue |confirm
step
talk Neeru Fireblade##3216
|tip Inside the building.
turnin Slaying the Beast##5761 |goto Orgrimmar 49.49,50.60
step
Enter the building |goto Orgrimmar 40.07,37.01 < 10 |walk
talk Thrall##4949
|tip Inside the building.
turnin Hidden Enemies##5728 |goto 31.79,37.84
step
Enter the tunnel |goto Undercity 51.93,64.78 < 10 |only if walking
Follow the path |goto 45.95,73.73 < 10 |only if walking
talk Varimathras##2425
turnin The Power to Destroy...##5725 |goto 56.26,92.19
step
talk Rahauro##11833
|tip He walks around this area.
accept Returning the Lost Satchel##5724 |goto Thunder Bluff 70.32,29.55
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Wailing Caverns Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Wailing Caverns",
description="This guide will walk you through completing the Wailing Caverns Quests.",
},[[
step
ding 15
step
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
accept The Barrens Oases##886 |goto Thunder Bluff 78.59,28.56
step
Enter the cave |goto Thunder Bluff 35.85,22.92 < 5 |walk
talk Apothecary Zamah##3419
|tip Inside the cave.
accept Serpentbloom##962 |goto 34.45,21.10
step
talk Tonga Runetotem##3448
turnin The Barrens Oases##886 |goto The Barrens 52.26,31.93
accept The Forgotten Pools##870 |goto 52.26,31.93
step
Explore the Waters of the Forgotten Pools |q 870/1 |goto 45.07,22.53
|tip Underwater.
step
talk Tonga Runetotem##3448
turnin The Forgotten Pools##870 |goto 52.26,31.93
accept The Stagnant Oasis##877 |goto 52.26,31.93
step
Follow the path |goto 59.88,38.96 < 30 |only if walking
click Bubbling Fissure
|tip Underwater.
Test the Dried Seeds |q 877/1 |goto 55.61,42.74
step
talk Tonga Runetotem##3448
turnin The Stagnant Oasis##877 |goto 52.26,31.93
|tip You can destroy the "Dried Seeds" quest item after turning in this quest.
accept Altered Beings##880 |goto 52.26,31.93
step
kill Oasis Snapjaw##3461+
|tip Underwater and along the edges of the water around this area.
collect 8 Altered Snapjaw Shell##5098 |q 880/1 |goto 55.53,42.70
step
talk Tonga Runetotem##3448
turnin Altered Beings##880 |goto 52.26,31.93
accept Hamuul Runetotem##1489 |goto 52.26,31.93
step
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
turnin Hamuul Runetotem##1489 |goto Thunder Bluff 78.59,28.56
accept Nara Wildmane##1490 |goto 78.59,28.56
step
talk Nara Wildmane##5770
|tip Inside the building.
turnin Nara Wildmane##1490 |goto 75.65,31.60
accept Leaders of the Fang##914 |goto 75.65,31.60
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
Enter the Wailing Caverns dungeon with your group |goto 52.40,55.21 < 10 |c
stickystart "Collect_6_Wailing_Essence"
stickystart "Collect_10_Serpentbloom"
stickystart "Collect_20_Deviate_Hide"
stickystart "Slay_7_Deviate_Ravager"
stickystart "Slay_7_Deviate_Viper"
stickystart "Slay_7_Deviate_Shambler"
stickystart "Slay_7_Deviate_Dreadfang"
step
Inside the Wailing Caverns Dungeon:
kill Lady Anacondra##3671
|tip She can spawn at several locations in the Screaming Gully.
collect Gem of Anacondra##9739 |q 914/2
step
Inside the Wailing Caverns Dungeon:
kill Lord Cobrahn##3669
collect Gem of Cobrahn##9738 |q 914/1
step
Inside the Wailing Caverns Dungeon:
kill Lord Pythas##3670
collect Gem of Pythas##9740 |q 914/3
step
Inside the Wailing Caverns Dungeon:
kill Lord Serpentis##3673
collect Gem of Serpentis##9741 |q 914/4
step
label "Collect_6_Wailing_Essence"
Inside the Wailing Caverns Dungeon:
Kill Ectoplasm enemies around this area
|tip They are found throughout the dungeon.
collect 6 Wailing Essence##6464 |q 1491/1
step
label "Collect_10_Serpentbloom"
Inside the Wailing Caverns Dungeon:
click Serpentbloom
|tip They are found along the walls inside of the dungeon.
collect 10 Serpentbloom##5339 |q 962/1
step
label "Collect_20_Deviate_Hide"
Inside the Wailing Caverns Dungeon:
Kill enemies around this area
collect 20 Deviate Hide##6443 |q 1486/1
step
label "Slay_7_Deviate_Ravager"
Inside the Wailing Caverns Dungeon:
kill 7 Deviate Ravager##3636 |q 1487/1
step
label "Slay_7_Deviate_Viper"
Inside the Wailing Caverns Dungeon:
kill 7 Deviate Viper##5755 |q 1487/2
step
label "Slay_7_Deviate_Shambler"
Inside the Wailing Caverns Dungeon:
kill 7 Deviate Shambler##5761 |q 1487/3
step
label "Slay_7_Deviate_Dreadfang"
Inside the Wailing Caverns Dungeon:
kill 7 Deviate Dreadfang##5056 |q 1487/4
step
Inside the Wailing Caverns Dungeon:
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
Leave the Wailing Caverns Dungeon
Click Here to Continue |confirm
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
Enter the cave |goto Thunder Bluff 35.85,22.92 < 5 |walk
talk Apothecary Zamah##3419
|tip Inside the cave.
accept Serpentbloom##962 |goto 34.45,21.10
step
talk Nara Wildmane##5770
|tip Inside the building.
turnin Leaders of the Fang##914 |goto 75.65,31.60
step
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
turnin In Nightmares##3370 |goto 78.59,28.56
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Shadowfang Keep Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Shadowfang Keep",
description="This guide will walk you through completing the Shadowfang Keep Quests.",
},[[
step
ding 18
step
talk Keeper Bel'dugur##2934
accept The Book of Ur##1013 |goto Undercity 53.72,54.45
step
talk Dalar Dawnweaver##1938
accept Arugal Must Die##1014 |goto Silverpine Forest 44.20,39.79
step
Enter the building |goto Silverpine Forest 43.09,41.38 < 5 |walk
talk High Executor Hadrec##1952
|tip Inside the building.
accept Deathstalkers in Shadowfang##1098 |goto 43.42,40.87
step
Enter the Shadowfang Keep dungeon with your group |goto 44.80,67.84 < 10 |c
step
Inside the Shadowfang Keep Dungeon:
kill Rethilgore##3914
|tip Open the cell door and speak with Deathstalker Adamant.
|tip Follow him and once he opens the door, jump down to the right of the stairs.
talk Deathstalker Vincent##4444
turnin Deathstalkers in Shadowfang##1098
step
Inside the Shadowfang Keep Dungeon:
click The Book of Ur##36738
|tip It is on a bookshelf to the left of the room where Fenrus the Devourer is.
collect The Book of Ur##6283 |q 1013/1
step
Inside the Shadowfang Keep Dungeon:
kill Archmage Arugal##4275
collect Head of Arugal##5442 |q 1014/1
step
Leave the Shadowfang Keep Dungeon
Click Here to Continue |confirm
step
talk Dalar Dawnweaver##1938
turnin Arugal Must Die##1014 |goto Silverpine Forest 44.20,39.79
step
talk Keeper Bel'dugur##2934
turnin The Book of Ur##1013 |goto Undercity 53.72,54.45
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackfathom Deeps Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Blackfathom Deeps",
description="This guide will walk you through completing the Blackfathom Deeps Quests.",
},[[
step
ding 21
step
Follow the path |goto Ashenvale 14.11,14.87 < 15 |only if walking
Jump down into the water |goto Kalimdor 43.97,35.37 < 20 |walk
Enter the underwater cave |goto 43.94,35.27 < 7 |walk
kill Blackfathom Tide Priestess##4802
|tip You may need help with this.
collect Damp Note##16790 |n
|tip This is has an extremely low drop rate.
use the Damp Note##16790
accept Allegience to the Old Gods##6564 |goto 43.82,35.14
step
talk Je'neu Sancrea##12736
|tip Inside the building.
turnin Allegience to the Old Gods##6564 |goto Ashenvale 11.57,34.28
accept Allegiance to the Old Gods##6565 |goto Ashenvale 11.57,34.28
accept The Essence of Aku'Mai##6563 |goto Ashenvale 11.57,34.28
accept Amongst the Ruins##6921 |goto Ashenvale 11.57,34.28
step
Follow the path |goto Ashenvale 14.11,14.87 < 15 |only if walking
Jump down into the water |goto Kalimdor 43.97,35.37 < 20 |walk
Enter the underwater cave |goto 43.94,35.27 < 7 |walk
click Sapphire of Aku'Mai
|tip They are along the cavern walls all through out the area
collect 20 Sapphire of Aku'Mai##16784 |q 6563/1 |goto 44.00,34.56
step
Follow the path up |goto 44.09,34.77 < 7 |walk
Continue following the path |goto 44.35,34.96 < 7 |walk
Enter the Blackfathom Deeps dungeon with your group |goto 44.35,34.86 < 5 |c
step
Inside the Blackfathom Deeps Dungeon:
talk Argent Guard Thaelrid##4787
|tip Swim into the South-West cave in the room where the boss Gamoo-ra is to reach him.
accept Blackfathom Villainy##6561
step
Inside the Blackfathom Deeps Dungeon:
kill Lorgus Jett##12902 |q 6565/1
step
Inside the Blackfathom Deeps Dungeon:
click Fathom Stone
|tip It is under water, beneath the walkway just before Twilight Lord Kelris.
|tip Click it will also cause Baron Aquanis to spawn.
collect Fathom Core##16762
step
Inside the Blackfathom Deeps Dungeon:
kill Baron Aquanis##12876
collect Strange Water Globe##16782 |n
use the Strange Water Globe##16782
accept Baron Aquanis##6922
step
Inside the Blackfathom Deeps Dungeon:
kill Twilight Lord Kelris##4832
collect Head of Kelris##5881 |q 6561/1
step
Leave the Blackfathom Deeps Dungeon
Click Here to Continue |confirm
step
talk Je'neu Sancrea##12736
|tip Inside the building.
turnin Allegiance to the Old Gods##6565 |goto Ashenvale 11.57,34.28
turnin The Essence of Aku'Mai##6563 |goto Ashenvale 11.57,34.28
turnin Amongst the Ruins##6921 |goto Ashenvale 11.57,34.28
turnin Baron Aquanis##6922 |goto Ashenvale 11.57,34.28
step
talk Bashana Runetotem##9087
|tip Inside the building.
turnin Blackfathom Villainy##6561 |goto Thunder Bluff 71.07,34.16
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Gnomeregan Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Gnomeregan",
description="This guide will walk you through completing the Gnomeregan Quests.",
},[[
step
ding 25
step
Enter the building |goto Orgrimmar 75.22,24.61 < 5 |walk
talk Nogg##3412
|tip Inside the building.
accept Rig Wars##2841 |goto 76.00,25.42
step
talk Sovik##3413
|tip Inside the building.
accept Chief Engineer Scooty |goto 75.49,25.35
step
talk Scooty##7853
turnin Chief Engineer Scooty##2842 |goto Stranglethorn Vale 27.60,77.48
accept Gnomer-gooooone!##2843 |goto Stranglethorn Vale 27.60,77.48
step
Wait for Scooty to Calibrate the Goblin Transponder |q 2843/1
step
talk Scooty##7853
turnin Gnomer-gooooone!##2843 |goto Stranglethorn Vale 27.60,77.48
step
Enter the Gnomeregan Dungeon |goto Stranglethorn Vale 27.63,77.55 < 5 |c
|tip Use the teleporter to accomplish this.
step
Inside the Gnomeregan Dungeon:
kill Mekgineer Thermaplugg##7800
collect Thermaplugg's Safe Combination##9299 |q 2841/2
step
Inside the Gnomeregan Dungeon:
click Thermaplugg's Safe##142477
|tip It's near the back wall of the third pillar from the right in the room with Mekgineer Thermaplugg.
collect Rig Blueprints##9153 |q 2841/1
step
Leave the Gnomeregan Dungeon
Click Here to Continue |confirm
step
Enter the building |goto Orgrimmar 75.22,24.61 < 5 |walk
talk Nogg##3412
|tip Inside the building.
turnin Rig Wars##2841 |goto 76.00,25.42
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Razorfen Kraul Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Razorfen Kraul",
description="This guide will walk you through completing the Razorfen Kraul Quests.",
},[[
step
ding 30
step
Follow the path	|goto Undercity 46.94,59.57 < 10 |only if walking
Run down the ramp |goto 44.56,66.51 < 10 |only if walking
talk Master Apothecary Faranell##2055
accept Going, Going, Guano!##1109 |goto 48.81,69.30
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
talk Auld Stonespire##4451
|tip Inside the tent.
accept A Vengeful Fate##1102 |goto Thunder Bluff 45.99,57.34
step
Follow the path |goto The Barrens 43.87,90.11 < 15 |only if walking
Enter the Razorfen Kraul dungeon with your group |goto 50.90,70.36 < 10 |c
step
Inside the Razorfen Kraul Dungeon:
collect Kraul Guano##5801 |q 1109/1
|tip These drop from Kraul Bats and Greater Kraul Bats.
stickystart "Collect_6_Blueleaf_Tuber"
step
Inside the Razorfen Kraul Dungeon:
use the Crate With Holes##5880
|tip This will summon a gopher.
use the Snufflenose Command Stick##6684
|tip This will allow you to command the gopher.
|tip Once past Overlord Ramtusk, go to the biggest hill from the area with many bridges.
collect 6 Blueleaf Tuber##5876 |q 1221/1
step
Inside the Razorfen Kraul Dungeon:
kill Charlga Razorflank##4421
|tip This is the last boss of the dungeon.
collect Razorflank's Heart##5793 |q 1102/1
collect Small Scroll##17008 |n
use the Small Scroll##17008
accept An Unholy Alliance##6522
step
Inside the Razorfen Kraul Dungeon:
talk Willix the Importer##4508
|tip Inside the building.
|tip Jump down from the platform where Charlga Razorflank was, and head to the tent to the left.
|tip This is an escort quest.
accept Willix the Importer##1144
step
Inside the Razorfen Kraul Dungeon:
Escort Willix the Importer out of Razorfen Kraul |q 1144/1
step
Inside the Razorfen Kraul Dungeon:
talk Willix the Importer##4508
|tip He will be at the entrance after the completion of the escort quest.
turnin Willix the Importer##1144
step
Leave the Razorfen Kraul Dungeon
Click Here to Continue |confirm
step
talk Mebok Mizzyrix##3446
turnin Blueleaf Tubers##1221 |goto The Barrens 62.37,37.62
step
talk Auld Stonespire##4451
|tip Inside the tent.
turnin A Vengeful Fate##1102 |goto Thunder Bluff 45.99,57.34
step
Follow the path	|goto Undercity 46.94,59.57 < 10 |only if walking
Run down the ramp |goto 44.56,66.51 < 10 |only if walking
talk Master Apothecary Faranell##2055
turnin Going, Going, Guano!##1109 |goto 48.81,69.30
step
Follow the path |goto Undercity 51.86,64.67
talk Varimathras##2425
turnin An Unholy Alliance##6522 |goto 56.23,92.18
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery Cathedral Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through completing the Scarlet Monastery Cathedral Quests.",
},[[
step
ding 40
step
Follow the path |goto Undercity 52.15,64.37 < 10 |only if walking
talk Varimathras##2425
accept Into The Scarlet Monastery##1048 |goto Undercity 56.26,92.20
step
Enter the building |goto Scarlet Monastery 47.43,19.74 < 10
Enter the Scarlet Monastery - Cathedral dungeon with your group |goto 75.00,23.41 < 5 |c
step
Inside the Scarlet Monastery Cathedral Dungeon:
kill High Inquisitor Whitemane##3977 |q 1048/1
step
Inside the Scarlet Monastery Cathedral Dungeon:
kill Scarlet Commander Mograine##3976 |q 1048/2
step
Leave the Scarlet Monastery Cathedral Dungeon
Click Here to Continue |confirm
step
Enter the Scarlet Monastery - Armory dungeon with your group |goto 75.03,23.52 < 5 |c
step
Inside the Scarlet Monastery Armory Dungeon:
kill Herod##3975 |q 1048/3
step
Leave the Scarlet Monastery Armory Dungeon
Click Here to Continue |confirm
step
Enter the Scarlet Monastery - Library dungeon with your group |goto 75.00,23.58 < 5 |c
step
Inside the Scarlet Monastery Library Dungeon:
kill Houndmaster Loksey##3974 |q 1048/4
step
Leave the Scarlet Monastery Library Dungeon
Click Here to Continue |confirm
step
Follow the path |goto Undercity 52.15,64.37 < 10 |only if walking
talk Varimathras##2425
turnin Into The Scarlet Monastery##1048 |goto Undercity 56.26,92.20
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery Library Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through completing the Scarlet Monastery Library Quests.",
},[[
step
ding 28
step
talk Sage Truthseeker##3978
|tip Inside the building.
accept Compendium of the Fallen##1049 |goto Thunder Bluff 34.41,46.90
|only Orc, Tauren, Troll
step
Follow the path up |goto Thousand Needles 54.68,44.78 < 15 |only if walking
Enter the cave |goto 53.67,42.51 < 10 |walk
talk Dorn Plainstalker##2986
|tip Inside the cave.
accept Test of Faith##1149 |goto 53.94,41.48
step
Watch the dialogue
Teleport to the Plateau |goto 26.43,31.29 < 20 |noway |c |q 1149
step
Jump down here |goto 26.43,32.41
|tip You won't die.
Return to Dorn Plainstalker |goto 53.89,41.62 < 20 |noway |c |q 1149
step
talk Dorn Plainstalker##2986
|tip Inside the cave.
turnin Test of Faith##1149 |goto 53.94,41.48
accept Test of Endurance##1150 |goto 53.94,41.48
step
Run up the hill |goto 27.59,49.85 < 7 |only if walking
Continue up the path |goto 28.73,51.37 < 7 |only if walking
Enter the cave |goto 27.27,51.29 < 8 |walk
click Harpy Foodstuffs##20447
kill Grenka Bloodscreech##4490
|tip She patrols around this area.
collect Grenka's Claw##5843 |q 1150/1 |goto 25.96,55.40
step
Leave the cave |goto 27.27,51.29 < 8 |walk
Follow the path up |goto Thousand Needles 54.68,44.78 < 15 |only if walking
Enter the cave |goto 53.67,42.51 < 10 |walk
talk Dorn Plainstalker##2986
|tip Inside the cave.
turnin Test of Endurance##1150 |goto 53.94,41.48
accept Test of Strength##1151 |goto 53.94,41.48
step
map Thousand Needles
path loop off
path	26.24,47.48	23.91,44.29	20.59,40.07	17.96,37.68	15.25,33.88
path	14.11,29.42	12.88,26.44
kill Rok'Alim the Pounder##4499
|tip It patrols along this path.
collect Fragments of Rok'Alim##5844 |q 1151/1
step
Follow the path up |goto Thousand Needles 54.68,44.78 < 15 |only if walking
Enter the cave |goto 53.67,42.51 < 10 |walk
talk Dorn Plainstalker##2986
|tip Inside the cave.
turnin Test of Strength##1151 |goto 53.94,41.48
accept Test of Lore##1152 |goto 53.94,41.48
step
talk Braug Dimspirit##4489
|tip Inside the tent.
turnin Test of Lore##1152 |goto Stonetalon Mountains 78.78,45.67
accept Test of Lore##1154 |goto 78.78,45.67
step
Enter the building |goto Ashenvale 75.96,75.38 < 8 |walk
Follow the path down |goto 76.27,75.64 < 8 |c |q 1154 |future
step
Follow the path |goto 77.23,76.28 < 10 |walk
Run down the ramp |goto 77.31,75.18 < 10 |walk
Continue following the path |goto 76.76,74.86 < 10 |walk
Continue down the path |goto 75.66,76.11 < 10 |walk
click Legacy of Aspects
collect Legacy of the Aspects##5860 |q 1154/1
step
talk Braug Dimspirit##4489
|tip Inside the tent.
turnin Test of Lore##1154 |goto Stonetalon Mountains 78.78,45.67
accept Test of Lore##6627 |goto Stonetalon Mountains 78.78,45.67
step
talk Braug Dimspirit##4489
Tell him "Neltharion is my answer."
Answer Braug Dimspirit's Question Correctly |q 6627/1 |goto Stonetalon Mountains 78.78,45.67
step
talk Braug Dimspirit##4489
|tip Inside the tent.
turnin Test of Lore##6627 |goto Stonetalon Mountains 78.78,45.67
accept Test of Lore##1159 |goto Stonetalon Mountains 78.78,45.67
step
talk Parqual Fintallas##4488
|tip Standing on the bridge.
turnin Test of Lore##1159 |goto Undercity 57.80,65.44
accept Test of Lore##1160 |goto 57.80,65.44
step
Follow the path |goto Undercity 52.15,64.37 < 10 |only if walking
talk Varimathras##2425
accept Into The Scarlet Monastery##1048 |goto Undercity 56.26,92.20
step
Enter the building |goto Scarlet Monastery 47.43,19.74 < 10
Enter the Scarlet Monastery - Library dungeon with your group |goto 75.00,23.58 < 5 |c
step
Inside the Scarlet Monastery Library Dungeon:
kill Houndmaster Loksey##3974 |q 1048/4
step
Inside the Scarlet Monastery Library Dungeon:
click Beginnings of the Undead Threat##20726
|tip It will be in the first room on the left once you enter the Gallery of Treasures.
collect Beginnings of the Undead Threat##5861 |q 1160/1
step
Inside the Scarlet Monastery Library Dungeon:
click Compendium of the Fallen##19283
|tip As soon as you enter the Athenaeum, follow the wall left and it will be on a nearby bookcase.
collect Compendium of the Fallen##5535 |q 1049/1
|only Orc, Tauren, Troll
step
Leave the Scarlet Monastery Library Dungeon
Click Here to Continue |confirm
step
ding 30
step
Enter the Scarlet Monastery - Armory dungeon with your group |goto 75.03,23.52 < 5 |c
step
Inside the Scarlet Monastery Armory Dungeon:
kill Herod##3975 |q 1048/3
step
Leave the Scarlet Monastery Armory Dungeon
Click Here to Continue |confirm
step
ding 40
step
Enter the Scarlet Monastery - Cathedral dungeon with your group |goto 75.00,23.41 < 5 |c
step
Inside the Scarlet Monastery Cathedral Dungeon:
kill High Inquisitor Whitemane##3977 |q 1048/1
step
Inside the Scarlet Monastery Cathedral Dungeon:
kill Scarlet Commander Mograine##3976 |q 1048/2
step
Leave the Scarlet Monastery Cathedral Dungeon
Click Here to Continue |confirm
step
talk Parqual Fintallas##4488
|tip Standing on the bridge.
turnin Test of Lore##1160 |goto Undercity 57.80,65.44
step
Follow the path |goto Undercity 52.15,64.37 < 10 |only if walking
talk Varimathras##2425
turnin Into The Scarlet Monastery##1048 |goto Undercity 56.26,92.20
Click Here to Continue |confirm
|tip If you haven't completed the other objectives, skip this for now.
step
talk Sage Truthseeker##3978
|tip Inside the building.
turnin Compendium of the Fallen##1049 |goto Thunder Bluff 34.41,46.90
|only Orc, Tauren, Troll
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery Graveyard Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through completing the Scarlet Monastery Graveyard Quests.",
},[[
step
ding 30
step
Follow the path	|goto Undercity 46.94,59.57 < 10 |only if walking
Run down the ramp |goto 44.56,66.51 < 10 |only if walking
talk Master Apothecary Faranell##2055
accept Going, Going, Guano!##1109 |goto 48.81,69.30
step
collect Kraul Guano##5801 |q 1109/1
|tip These drop from Kraul Bats and Greater Kraul Bats.
step
Follow the path	|goto Undercity 46.94,59.57 < 10 |only if walking
Run down the ramp |goto 44.56,66.51 < 10 |only if walking
talk Master Apothecary Faranell##2055
turnin Going, Going, Guano!##1109 |goto 48.81,69.30
accept Hearts of Zeal##1113 |goto 48.81,69.30
step
Enter the building |goto Scarlet Monastery 47.43,19.74 < 10
Enter the Scarlet Monastery - Graveyard dungeon with your group |goto 74.95,23.41 < 5 |c
step
Inside the Scarlet Monastery Graveyard Dungeon:
talk Vorrel Sengutz##3981
|tip He's on the table where Interrogator Vishas was standing.
|tip Inside the instance.
accept Vorrel's Revenge##1051
step
Inside the Scarlet Monastery Graveyard Dungeon:
kill Nancy Vishas##3984
|tip Inside the building.
collect Vorrel's Wedding Ring##5538 |q 1051/1 |goto Alterac Mountains 32.34,32.78
step
label "Collect_30_Heart_of_Zeal"
Inside the Scarlet Monastery Graveyard Dungeon:
Kill enemies around this area
collect 30 Heart of Zeal##5805 |q 1113/1
step
Leave the Scarlet Monastery Graveyard Dungeon
Click Here to Continue |confirm
step
talk Monika Sengutz##3982
|tip Inside the building.
turnin Vorrel's Revenge##1051 |goto Hillsbrad Foothills 62.67,18.88
step
Follow the path	|goto Undercity 46.94,59.57 < 10 |only if walking
Run down the ramp |goto 44.56,66.51 < 10 |only if walking
talk Master Apothecary Faranell##2055
turnin Hearts of Zeal##1113 |goto 48.81,69.30
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery Armory Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Scarlet Monastery",
description="This guide will walk you through completing the Scarlet Monastery Armory Quests.",
},[[
step
ding 38
step
Follow the path |goto Undercity 52.15,64.37 < 10 |only if walking
talk Varimathras##2425
accept Into The Scarlet Monastery##1048 |goto Undercity 56.26,92.20
step
Inside the Scarlet Monastery Armory Dungeon:
kill Herod##3975 |q 1048/3
step
Follow the path |goto Undercity 52.15,64.37 < 10 |only if walking
talk Varimathras##2425
turnin Into The Scarlet Monastery##1048 |goto Undercity 56.26,92.20
|tip If you haven't completed the other objectives, skip this for now.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Razorfen Downs Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Razorfen Downs",
description="This guide will walk you through completing the Razorfen Downs Quests.",
},[[
step
ding 37
step
kill Charlga Razorflank##4421
|tip This is the last boss of the Razorfen Kraul dungeon.
collect Small Scroll##17008 |n
use the Small Scroll##17008
accept An Unholy Alliance##6522
step
Follow the path |goto Undercity 51.86,64.67
talk Varimathras##2425
turnin An Unholy Alliance##6522 |goto 56.23,92.18
accept An Unholy Alliance##6521 |goto 56.23,92.18
step
talk Andrew Brownell##2308
accept Bring the End##3341 |goto Undercity 74.06,33.29
step
kill Ambassador Malcin##12865
collect Ambassador Malcin's Head##17009 |goto The Barrens 48.52,95.62
Check in the Locations Below If He's Not Here:
[48.2,92.6]
[47.8,90.6]
[46.2,90.2]
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
kill Amnennar the Coldbringer##7358
collect Skull of the Coldbringer##10420 |q 3341/1
step
Leave the Razorfen Downs Dungeon
Click Here to Continue |confirm
step
talk Andrew Brownell##2308
turnin Bring the End##3341 |goto Undercity 74.06,33.29
step
Follow the path |goto Undercity 51.86,64.67
talk Varimathras##2425
turnin An Unholy Alliance##6521 |goto 56.23,92.18
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Uldaman Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Uldaman",
description="This guide will walk you through completing the Uldaman Quests.",
},[[
step
ding 37
step
talk Patrick Garrett##5651
accept Reclaimed Treasure##2342 |goto Undercity 62.32,48.62
step
talk Rigglefuzz##2817
accept Power Stones##2418 |goto Badlands 42.38,52.95
step
talk Theldurin the Lost##2785
accept Solution to Doom##709 |goto 51.39,76.86
step
Enter the building |goto Badlands 3.83,46.98 < 5 |walk
talk Jarkal Mossmeld##6868
|tip Upstairs inside the building.
accept Badlands Reagent Run##2258 |goto 2.43,46.08
step
Leave the building |goto 3.83,46.97 < 7 |walk
Follow the path |goto 9.18,43.23 < 15 |only if walking
kill Lesser Rock Elemental##2735+
collect 5 Rock Elemental Shard##7848 |q 2258/3 |goto 19.46,43.02
You can find more around [13.98,39.71]
step
label "Collect_Buzzard_Gizzards"
Kill Buzzard enemies around this area
collect 5 Buzzard Gizzard##7847 |q 2258/1 |goto 16.82,59.84
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
collect 10 Crag Coyote Fang##7846 |q 2258/2 |goto 23.75,55.12
You can find more around: |notinsticky
[14.18,65.72]
[31.58,65.16]
step
Enter the building |goto Badlands 3.83,46.98 < 5 |walk
talk Jarkal Mossmeld##6868
|tip Upstairs inside the building.
turnin Badlands Reagent Run##2258 |goto 2.43,46.08
accept Uldaman Reagent Run##2202 |goto 2.43,46.08
step
Enter the cave |goto Eastern Kingdoms 54.48,57.78
Kill Shadowforge enemies around this area
|tip You may need help with this.
collect Shattered Necklace##7666  |q 2283 |future |goto 53.86,57.90
step
click Garret Family Chest
collect Garrett Family Treasure##8026 |q 2342/1
step
talk Dran Droffers##6986
accept Necklace Recovery##2283 |goto Orgrimmar 59.48,36.59
turnin Necklace Recovery##2283 |goto Orgrimmar 59.48,36.59
accept Necklace Recovery, Take 2##2284 |goto Orgrimmar 59.48,36.59
step
talk Remains of a Paladin##6912
|tip He's laying on the ground surrounded by enemies.
turnin Necklace Recovery, Take 2##2284
accept Translating the Journal##2318
step
Enter the building |goto Badlands 3.83,46.98 < 5 |walk
talk Jarkal Mossmeld##6868
|tip Upstairs inside the building.
turnin Translating the Journal##2318 |goto Badlands 2.43,46.07
accept Translating the Journal##2338 |goto Badlands 2.43,46.07
step
talk Jarkal Mossmeld##6868
|tip Upstairs inside the building.
turnin Translating the Journal##2338
Watch the Dialogue
accept Find the Gems and Power Source##2339 |goto Badlands 2.43,46.07
step
Enter the cave |goto Eastern Kingdoms 54.48,57.78
Enter the Uldaman Dungeon with Your Group |goto 53.85,57.66 < 10 |q 2280 |future |c
step
stickystart "Collect_12_Magenta_Cap_Cluster"
stickystart "Collect_8_Dentrium_Power_Stone"
stickystart "Collect_8_An'Alleum_Power_Stone"
step
Inside the Uldaman Dungeon:
click Conspicuous Urn
|tip In Dig Two, the room with Olaf, Eric "The Swift" and Baelog.
collect Shattered Necklace Topaz##7671 |q 2339/3
step
Inside the Uldaman Dungeon:
click Shadowforge Cache
|tip In Dig Three, with Galgann Firehammer.
collect Shattered Necklace Ruby##7669 |q 2339/1
step
Inside the Uldaman Dungeon:
kill Grimlok##4854
collect Shattered Necklace Sapphire##7670 |q 2339/2
step
Inside the Uldaman Dungeon:
kill Archaedas##2748
collect Shattered Necklace Power Source##7672 |q 2339/4
step
Inside the Uldaman Dungeon:
click The Discs of Norgannon
|tip In the room behind Archaedas.
|tip You will only be able to access this room after Archadas is defeated.
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
accept The Platinum Discs##2280
|only if level >=40
step
label "Collect_12_Magenta_Cap_Cluster"
Inside the Uldaman Dungeon:
click Magenta Cap Cluster
|tip They look like a pair of mushrooms along the walls of the cave.
collect 12 Magenta Cap Cluster##8047 |q 2202/1
step
label "Collect_8_Dentrium_Power_Stone"
Inside the Uldaman Dungeon:
Kill Shadowforge enemies around this area
collect 8 Dentrium Power Stone##8009 |q 2418/1
step
label "Collect_8_An'Alleum_Power_Stone"
Inside the Uldaman Dungeon:
Kill Shadowforge enemies around this area
collect 8 An'Alleum Power Stone##8052 |q 2418/2
step
Leave the Uldaman Dungeon
Click Here to Continue |confirm
step
Enter the building |goto Badlands 3.83,46.98 < 5 |walk
talk Jarkal Mossmeld##6868
|tip Upstairs inside the building.
turnin Uldaman Reagent Run##2202 |goto 2.43,46.08
turnin Find the Gems and Power Source##2339 |goto Badlands 2.43,46.07
Watch the Dialogue
accept Deliver the Gems##2340 |goto Badlands 2.43,46.07
step
talk Patrick Garrett##5651
turnin Reclaimed Treasure##2342 |goto Undercity 62.32,48.62
step
Enter the building |goto Orgrimmar 59.01,37.57 < 5
talk Dran Droffers##6986
|tip Inside the building.
turnin Deliver the Gems##2340 |goto 59.50,36.60
accept Necklace Recovery, Take 3##2341 |goto 59.50,36.60
step
Enter the building |goto Thunder Bluff 36.34,50.53 < 10 |walk
talk Sage Truthseeker##3978
|tip Inside the building.
turnin The Platinum Discs##2280 |goto 34.40,46.91
|only if level >=40
step
Enter the building |goto Badlands 3.83,46.98 < 5 |walk
talk Jarkal Mossmeld##6868
|tip Upstairs inside the building.
turnin Necklace Recovery, Take 3##2341 |goto Badlands 2.43,46.07
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Zul'Farrak Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Zul'Farrak",
description="This guide will walk you through completing the Zul'Farrak Quests.",
},[[
step
click Venom Bottle
|tip It looks like a green battle laying against a crate.
accept Venom Bottles##2933 |goto The Hinterlands 23.51,58.78
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
Enter the building |goto Hillsbrad Foothills 61.50,19.43 < 5 |walk
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Venom Bottles##2933 |goto 61.44,19.06
accept Undamaged Venom Sac##2934 |goto 61.44,19.06
step
Follow the path up |goto Hillsbrad Foothills 72.92,23.67 < 10 |only if walking
Continue following the path |goto 74.43,23.22 < 10 |only if walking
Continue following the path |goto 84.10,32.70 < 15 |only if walking
Enter the Hinterlands |goto 90.05,24.99 < 20 |c |q 2934 |future
step
Follow the path |goto The Hinterlands 35.74,64.01 < 10 |only if walking
kill Witherbark Broodguard##2686
collect 1 Undamaged Venom Sac##9322 |q 2934/1
step
Enter the building |goto Hillsbrad Foothills 61.50,19.43 < 5 |walk
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Undamaged Venom Sac##2934 |goto 61.44,19.06
accept Consult Master Gadrin##2935 |goto 61.44,19.06
step
talk Master Gadrin##3188
turnin Consult Master Gadrin##2935 |goto Durotar 55.95,74.72
accept The Spider God##2936 |goto Durotar 55.95,74.72
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
click Tablet of Theka
|tip it's in the room full of Scarabs and Theka the Martyr.
Find the Spider God's Name |q 2936/1
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
talk Master Gadrin##3188
turnin The Spider God##2936 |goto Durotar 55.95,74.72
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Maraudon Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Maraudon",
description="This guide will walk you through completing the Maraudon Quests.",
},[[
step
ding 45
step
Run up the stairs |goto Orgrimmar 38.30,81.47 < 7 |only if walking
Enter the building |goto 38.75,83.33 < 7 |walk
talk Uthel'nay##7311
accept Shadowshard Fragments##7068 |goto 39.16,86.26
step
Run up the stairs |goto Desolace 23.61,70.08 < 7 |only if walking
talk Vark Battlescar##11823
|tip Upstairs inside the building.
accept Vyletongue Corruption##7029 |goto 23.22,70.32
step
talk Selendra##13699
accept Corruption of Earth and Seed##7064 |goto 26.86,77.67
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
collect Filled Cerulean Vial##17696 |q 7029/2
step
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Magra.
kill Magra##13740
collect Gem of the Third Khan##17763 |q 7067 |future
step
Kill Shadowshard enemies around this area
collect 10 Shadowshard Fragment##17756 |q 7068/1
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
Heal 8 Vylestem Vines |q 7029/1
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
kill Princess Theradras##12201 |q 7064/1
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
Run up the stairs |goto Orgrimmar 38.30,81.47 < 7 |only if walking
Enter the building |goto 38.75,83.33 < 7 |walk
talk Uthel'nay##7311
turnin Shadowshard Fragments##7068 |goto 39.16,86.26
step
Run up the stairs |goto Desolace 23.61,70.08 < 7 |only if walking
talk Vark Battlescar##11823
|tip Upstairs inside the building.
turnin Vyletongue Corruption##7029 |goto 23.22,70.32
step
talk Selendra##13699
turnin Corruption of Earth and Seed##7064 |goto 26.86,77.67
step
talk Centuar Pariah##13717
|tip He patrols around this area.
turnin The Pariah's Instructions##7067 |goto Desolace 48.4,87.0
step
talk Willow##13656
|tip Inside the building.
turnin Twisted Evils##7028 |goto Desolace 62.19,39.63
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
talk Witch Doctor Uzer'i##8115
accept The Sunken Temple##3380 |goto Feralas 74.42,43.36
step
talk Marvon Rivetseeker##7771
turnin The Sunken Temple##3380 |goto Tanaris 52.71,45.92
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
Enter Zul'Farrak |goto Tanaris 38.73,19.99 < 8 |q 3527 |future
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
Click Here to Continue |confirm
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
click Atal'ai Artifact+
|tip They look like various small objects on the ground underwater around this area.
|tip You can find them all around this large lake.
collect 10 Atal'ai Artifact##6175 |q 1424/1 |goto 67.14,58.70
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
talk Larion##9118
accept Larion and Muigin##4145 |goto 45.53,8.71
stickystart "Kill_Bloodpetal_Thresher"
stickystart "Kill_Bloodpetal_Lashers"
stickystart "Kill_Bloodpetal_Trappers"
step
kill 5 Bloodpetal Flayer##6510 |q 4145/3 |goto 57.09,16.45
You can find more around [56.74,24.61]
step
label "Kill_Bloodpetal_Thresher"
kill 5 Bloodpetal Thresher##6511 |q 4145/4 |goto 56.59,34.46
You can find more around: |notinsticky
[61.68,36.93]
[69.81,29.80]
step
label "Kill_Bloodpetal_Lashers"
kill 5 Bloodpetal Lasher##6509 |q 4145/1 |goto 69.81,29.80
You can find more around: |notinsticky
[61.68,36.93]
[56.59,34.46]
step
label "Kill_Bloodpetal_Trappers"
kill 5 Bloodpetal Trapper##6512 |q 4145/2 |goto 39.85,53.54
You can find more around [34.49,37.63]
step
Follow the path up |goto Un'Goro Crater 45.72,13.08 < 10 |only if walking
talk Larion##9118
turnin Larion and Muigin##4145 |goto 45.53,8.71
accept Marvon's Workshop##4147 |goto 45.53,8.71
step
Enter the building |goto The Barrens 62.52,38.57 < 7 |walk
talk Liv Rizzlefix##8496
|tip Inside the building.
turnin Marvon's Workshop##4147 |goto The Barrens 62.45,38.73
accept Zapper Fuel##4146 |goto The Barrens 62.45,38.73
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
collect 5 Atal'ai Haze##11318 |q 4146/1
step
Leave the Temple of Atal'Hakkar
Click Here to Continue |confirm
step
Enter the building |goto Swamp of Sorrows 47.23,54.36 < 7 |walk
talk Fel'zerul##1443
turnin The Temple of Atal'Hakkar##1445 |goto 47.94,54.79
step
Follow the path |goto The Hinterlands 35.78,64.12 < 15 |only if walking
Run up the stairs |goto 33.09,73.80 < 15 |only if walking
Jump down here |goto 33.11,75.53 < 7 |only if walking
talk Atal'ai Exile##5598
turnin Jammal'an the Prophet##1446 |goto 33.75,75.22
step
Enter the building |goto The Barrens 62.52,38.57 < 7 |walk
talk Liv Rizzlefix##8496
|tip Inside the building.
turnin Zapper Fuel##4146 |goto The Barrens 62.45,38.73
step
talk Yeh'kinya##8579
turnin The God Hakkar##3528 |goto Tanaris 66.98,22.36
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackrock Depths Quests",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Blackrock Depths",
description="This guide will walk you through completing the Blackrock Depths Quests.",
},[[
step
ding 52
step
Enter the building |goto Tanaris 66.99,23.87 < 5 |walk
talk Yorba Screwspigot##9706
|tip Inside the building.
accept Yuka Screwspigot##4324 |goto Tanaris 67.04,24.01
step
Follow the path |goto Undercity 52.81,77.39 < 10 |walk
Follow the path down |goto 51.16,80.26 < 8 |walk
talk Apothecary Zinge##5204
accept Vivian Lagrave##4133 |goto Undercity 50.14,67.99
step
talk Shadowmage Vivian Lagrave##9078
turnin Vivian Lagrave##4133 |goto Badlands 2.89,47.76
accept Lost Thunderbrew Recipe##4134 |goto 2.89,47.76
step
talk Thunderheart##9084
|tip He will sometimes go out on patrol.
|tip Do not click him until he stops near this spot or you might attack him.
|tip Wait for him to reapper in Kargath.
accept Disharmony of Flame##3906 |goto Badlands 3.32,48.27
step
click WANTED##164867
accept KILL ON SIGHT: Dark Iron Dwarves##4081 |goto Badlands 3.77,47.47
step
talk Hierophant Theodora Mulvadania##9079
accept The Rise of the Machines##4061 |goto Badlands 3.03,47.81
step
talk Kalaran Windblade##8479
accept Divine Retribution##3441 |goto Searing Gorge 39.05,38.99
step
talk Kalaran Windblade##8479
Ask him _"Tell me what drives this vengeance?"_
Listen to Kalaran's Story |q 3441/1 |goto 39.05,38.99
step
talk Kalaran Windblade##8479
turnin Divine Retribution##3441 |goto 39.05,38.99
accept The Flawless Flame##3442 |goto 39.05,38.99
stickystart "Collect_Hearts_Of_Flame"
step
Kill enemies around this area
|tip Only Tempered War Golems, Heavy War Golems, and Magma Elementals will drop the quest item.
collect 4 Golem Oil##10511 |q 3442/2 |goto 48.59,38.32
You can find more around: |notinsticky
[43.27,39.20]
[36.56,40.58]
[32.26,46.19]
[25.43,53.98]
[31.52,72.23]
step
label "Collect_Hearts_Of_Flame"
Kill Elemental enemies around this area
|tip Heavy War Golems will not drop this quest item.
collect 4 Heart of Flame##10509 |q 3442/1 |goto 42.58,38.58
You can find more around: |notinsticky
[39.22,41.58]
[31.18,43.67]
[25.43,53.98]
[31.52,72.23]
step
talk Kalaran Windblade##8479
turnin The Flawless Flame##3442 |goto 39.05,38.99
accept Forging the Shaft##3443 |goto 39.05,38.99
step
Kill Dark Iron enemies around this area
|tip Inside the cave, all throughout.
|tip You can also find some outside, near Thorium Point.
collect 8 Thorium Plated Dagger##10551 |q 3443/1 |goto 43.38,34.94
step
Jump down here |goto 49.32,43.74 < 15 |only if walking
Enter the cave |goto 49.58,45.49 < 10 |walk
Cross the bridge |goto 47.78,42.60 < 15 |walk
Follow the path |goto 42.02,35.57 < 15 |walk
Kill Dark Iron enemies around this area
|tip Inside the cave, all throughout.
|tip You can also find some outside, near Thorium Point.
collect 8 Thorium Plated Dagger##10551 |q 3443/1 |goto 43.38,34.94
step
Follow the path |goto 50.59,38.45 < 15 |walk
Continue following the path |goto 47.21,42.94 < 15 |walk
Leave the cave |goto 47.53,46.72 < 15 |walk
Jump down carefully here |goto 48.98,46.87 < 10 |only if walking
Follow the path up |goto 58.08,41.10 < 15 |only if walking
Follow the path |goto 65.38,34.61 < 30 |only if walking
talk Kalaran Windblade##8479
turnin Forging the Shaft##3443 |goto 39.06,38.99
accept The Flame's Casing##3452 |goto 39.06,38.99
step
Follow the path down |goto 34.86,25.83 < 20 |only if walking
Follow the path |goto 31.32,33.57 < 30 |only if walking
Kill Twilight enemies around this area
|tip They are elite enemies, you will likely need help with this.
|tip Try to find someone to help you.
|tip Doing this quest unlocks more quests that give easy experience, so it's important to get it done.
collect Symbol of Ragnaros##10552 |q 3452/1 |goto 24.62,35.13
|tip This has a low drop rate.
You can find more inside the cave at [21.89,36.36]
You can find more up the path that starts at [24.23,33.12]
step
Follow the path |goto 26.48,34.56 < 30 |only if walking
talk Kalaran Windblade##8479
turnin The Flame's Casing##3452 |goto 39.05,38.99
accept The Torch of Retribution##3453 |goto 39.05,38.99
step
Watch the dialogue
Witness the Creation of the Torch |q 3453/1 |goto 39.05,38.99
step
talk Kalaran Windblade##8479
turnin The Torch of Retribution##3453 |goto 39.05,38.99
accept The Torch of Retribution##3454 |goto 39.05,38.99
step
click Torch of Retribution
turnin The Torch of Retribution##3454 |goto 39.06,39.06
step
talk Kalaran Windblade##8479
accept Squire Maltrake##3462 |goto 39.05,39.00
step
talk Squire Maltrake##8509
turnin Squire Maltrake##3462 |goto 39.16,38.99
accept Set Them Ablaze!##3463 |goto 39.16,38.99
step
Follow the path |goto 33.70,49.71 < 30 |only if walking
Run up the ramp |goto 33.50,53.64 < 15 |only if walking
click Sentry Brazier
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Northern Tower Ablaze |q 3463/4 |goto 33.31,54.49
step
Run up the ramp |goto 35.92,59.85 < 15 |only if walking
click Sentry Brazier
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Western Tower Ablaze |q 3463/1 |goto 35.67,60.68
step
Follow the path |goto 35.00,72.13 < 30 |only if walking
Continue following the path |goto 43.33,72.09 < 30 |only if walking
Run up the ramp |goto 44.10,61.85 < 15 |only if walking
click Sentry Brazier
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Southern Tower Ablaze |q 3463/2 |goto 44.03,60.91
step
Cross the hanging bridge |goto 52.48,57.95 < 15 |only if walking
Run up the ramp |goto 50.19,55.61 < 15 |only if walking
click Sentry Brazier
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Eastern Tower Ablaze |q 3463/3 |goto 50.06,54.74
step
Follow the path |goto 67.99,50.25 < 30 |only if walking
Continue following the path |goto 66.79,34.56 < 30 |only if walking
talk Squire Maltrake##8509
turnin Set Them Ablaze!##3463 |goto 39.17,39.00
step
Watch the dialogue
click Hoard of the Black Dragonflight
accept Trinkets...##3481 |goto 38.86,38.99
step
click Hoard of the Black Dragonflight
turnin Trinkets...##3481 |goto 38.86,38.99
|tip Save the Hoard of the Black Dragonflight for later.
step
Kill enemies around this area
collect 10 Fractured Elemental Shard##11266 |q 4061/1 |goto Burning Steppes 62.44,40.48
You can find more around here [69.20,37.33]
step
talk Maxwort Uberglint##9536
accept The Heart of the Mountain##4123 |goto Burning Steppes 65.15,23.91
step
Enter the cave |goto Burning Steppes 65.65,22.68 < 8 |walk
talk Yuka Screwspigot##9544
|tip Inside the cave.
turnin Yuka Screwspigot##4324 |goto 66.06,21.95
accept Ribbly Screwspigot##4136 |goto 66.06,21.95
step
Enter the cave |goto Burning Steppes 94.43,31.86 < 8 |walk
talk Cyrus Therepentous##9459
accept A Taste of Flame##4022 |goto 95.07,31.56
step
use the Hoard of the Black Dragonflight##10569
collect Black Dragonflight Molt##10575 |q 4022/1
step
talk Cyrus Therepentous##9459
turnin A Taste of Flame##4022 |goto 95.07,31.56
accept A Taste of Flame##4024 |goto 95.07,31.56
step
talk Hierophant Theodora Mulvadania##9079
turnin The Rise of the Machines##4061 |goto Badlands 3.03,47.81
accept The Rise of the Machines##4062 |goto 3.03,47.81
step
talk Lotwil Veriatus##2921
turnin The Rise of the Machines##4062 |goto 25.95,44.87
accept The Rise of the Machines##4063 |goto 25.95,44.87
step
Jump into the lava |havebuff 132331 |goto Eastern Kingdoms 48.63,64.04
|tip You will need to be dead to talk to the next quest giver.
step
Cross the chain |goto Blackrock Mountain 48.73,63.79
Enter the building |goto 48.63,64.14
Run down the path |goto 48.62,64.26
talk Franclorn Forgewright##8888
accept Dark Iron Legacy##3801 |goto 48.62,64.18
step
talk Franclorn Forgewright##8888
turnin Dark Iron Legacy##3801 |goto 48.62,64.18
accept Dark Iron Legacy##3802 |goto 48.62,64.18
step
kill Overmaster Pyron##9026 |q 4262/1
|tip He patrols the area just outside of the Blackrock Depths entrance.
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
stickystart "Collect_Dark_Keeper_Key"
stickystart "Kill_15_Anvilrage_Guardsman"
stickystart "Kill_10_Anvilrage_Warden"
stickystart "Kill_5_Anvilrage_Footman"
stickystart "Collect_10_Intact_Elemental_Core"
step
Inside the Blackrock Depths Dungeon:
kill Fineous Darkvire##9056
collect Ironfel##10999 |q 3802/1
step
Inside the Blackrock Depths Dungeon:
kill Bael'Gar##9016
use the Altered Black Dragonflight Molt##11231
|tip Use it on Bael'Gars corpse.
collect Encased Fiery Essence##11230 |q 4024/1
step
Inside the Blackrock Depths Dungeon:
talk Ribbly Screwspigot##9543
|tip He's at the bottom level of the Grim Guzzler.
Tell him _"Your family says hello, Ribbly. And they want your head!"_
kill Ribbly Screwspigot##9543
collect Ribbly's Head##11313 |q 4136/1
step
Inside the Blackrock Depths Dungeon:
kill Golem Lord Argelmach##8983
collect Head of Argelmach##11268 |q 4063/1
step
Inside the Blackrock Depths Dungeon:
talk Mistress Nagmara##9500
|tip She walks around the Grim Guzzler.
accept The Love Potion##4201
step
Inside the Blackrock Depths Dungeon:
kill Hurley Blackbreath##9537
collect Lost Thunderbrew Recipe##11312 |q 4134/1
step
label "Collect_10_Intact_Elemental_Core"
Inside the Blackrock Depths Dungeon:
Kill enemies around this area
|tip Specifically, Golem and Construct enemies throughout the dungeon.
collect 10 Intact Elemental Core##11269 |q 4063/2
step
label "Collect_Dark_Keeper_Key"
Inside the Blackrock Depths Dungeon:
Kill enemies around this area
collect 12 Relic Coffer Key##11078 |q 4123 |future
step
label "Kill_15_Anvilrage_Guardsman"
Inside the Blackrock Depths Dungeon:
kill 15 Anvilrage Guardsman##8891 |q 4081/1
step
label "Kill_10_Anvilrage_Warden"
Inside the Blackrock Depths Dungeon:
kill 10 Anvilrage Warden##8890 |q 4081/2
step
label "Kill_5_Anvilrage_Footman"
Inside the Blackrock Depths Dungeon:
kill 5 Anvilrage Footman##8892 |q 4081/3
step
Inside the Blackrock Depths Dungeon:
click Relic Coffer Door
|tip Open all 12 of them inside of the Black Vault after clearing the room.
kill Watchman Doomgrip##9476
|tip He will spawn once all 12 Relic Coffer Doors have been opened.
click Heart of the Mountain
|tip It will appear after killing the Warbringer Constructs and Watchman Doomgrip.
collect The Heart of the Mountain##11309 |q 4123/1
step
Leave the Blackrock Depths Dungeon
Click Here to Continue |confirm
step
Jump into the lava |havebuff 132331 |goto Eastern Kingdoms 48.63,64.04
|tip You will need to be dead to talk to the next quest giver.
step
Cross the chain |goto Blackrock Mountain 48.73,63.79
Enter the building |goto 48.63,64.14
Run down the path |goto 48.62,64.26
talk Franclorn Forgewright##8888
turnin Dark Iron Legacy##3802 |goto 48.62,64.18
step
talk Maxwort Uberglint##9536
accept The Heart of the Mountain##4123 |goto Burning Steppes 65.15,23.91
step
Enter the cave |goto Burning Steppes 94.43,31.86 < 8 |walk
talk Cyrus Therepentous##9459
turnin A Taste of Flame##4024 |goto 95.07,31.56
step
collect 4 Gromsblood##8846 |q 4201/1
|tip These are gathered with the Herbalism Profession.
|tip Load the "Gromsblood Farming Guide" to accomplish this.
|tip You can also buy these from the Auction House.
step
Kill Cliff enemies around this area
|tip These are elite.
|tip You may need help.
collect 10 Giant Silver Vein##  |q 4201/2 |goto Azshara 44.81,85.43
You Can Find More At These Locations:
[48.72,87.54]
[52.63,85.45]
[58.25,89.50]
[60.45,89.81]
[59.12,83.27]
[52.13,78.62]
step
Follow the path up |goto Un'Goro Crater 31.19,51.48 < 10 |only if walking
use Nagmara's Vial##11412
|tip You must be in the water.
collect Nagmara's Filled Vial##11413 |q 4201/3 |goto 31.99,50.01
step
talk Thunderheart##9084
|tip He will sometimes go out on patrol.
|tip Do not click him until he stops near this spot or you might attack him.
|tip Wait for him to reapper in Kargath.
turnin Disharmony of Flame##3906 |goto Badlands 3.32,48.27
accept Disharmony of Fire##3907 |goto 3.32,48.27
step
talk Lotwil Veriatus##2921
turnin The Rise of the Machines##4062 |goto Badlands 25.95,44.87
step
talk Warlord Goretooth##9077
|tip At the top of the tower.
turnin KILL ON SIGHT: Dark Iron Dwarves##4081 |goto Badlands 5.83,47.52
step
click WANTED##164867
accept KILL ON SIGHT: High Ranking Dark Iron Officials##4082 |goto Badlands 3.77,47.47
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
stickystart "Kill_10_Anvilrage_Medic"
stickystart "Kill_10_Anvilrage_Soldier"
stickystart "Kill_10_Anvilrage_Officer"
step
Inside the Blackrock Depths Dungeon:
talk Mistress Nagmara##9500
|tip She walks around the Grim Guzzler.
turnin The Love Potion##4201
step
Inside the Blackrock Depths Dungeon:
kill Lord Incendius##9017 |q 3907/1
collect Tablet of Kurniya##11126 |q 3907/2
step
label "Kill_10_Anvilrage_Medic"
Inside the Blackrock Depths Dungeon:
kill 10 Anvilrage Medic##8894 |q 4082/1
step
label "Kill_10_Anvilrage_Soldier"
Inside the Blackrock Depths Dungeon:
kill 10 Anvilrage Soldier##8893 |q 4082/2
step
label "Kill_10_Anvilrage_Officer"
Inside the Blackrock Depths Dungeon:
kill 10 Anvilrage Officer##8895 |q 4082/3
step
Leave the Blackrock Depths Dungeon
Click Here to Continue |confirm
step
talk Thunderheart##9084
turnin Disharmony of Fire##3907 |goto Badlands 3.33,48.28
step
talk Galamav the Marksman##9081
|tip Upstairs inside the tower.
accept Commander Gor'shak##3981 |goto Badlands 5.95,47.75
step
talk Warlord Goretooth##9077
|tip At the top of the tower.
turnin KILL ON SIGHT: High Ranking Dark Iron Officials##4082 |goto Badlands 5.83,47.52
step
talk Maxwort Uberglint##4123
turnin The Heart of the Mountain##4123 |goto Burning Steppes 65.2,23.8
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
Inside the Blackrock Depths Dungeon:
kill High Interrogator Gerstahn##9018
collect Prison Cell Key##11140 |q 3981 |future
step
Inside the Blackrock Depths Dungeon:
click Cell Door
|tip Leave the tunnel with High Interrogator Gerstahn back into the main room.
|tip Enter the tunnel to the right.
|tip While in the tunnel, open the first interactable door on the right.
talk Commander Gor'shak##9020
turnin Commander Gor'shak##3981
accept What Is Going On?##3982
|tip Clear the enemies around the cell before accepting this quest.
step
Inside the Blackrock Depths Dungeon:
Survive the Onslaught |q 3982/1
|tip There will be two waves of enemies.
|tip Make sure Commander Gor'shak doesn't die.
step
Inside the Blackrock Depths Dungeon:
talk Commander Gor'shak##9020
turnin What Is Going On?##3982
accept What Is Going On?##4001
step
Inside the Blackrock Depths Dungeon:
click Cell Door
|tip Exit the cell and cross the hallway.
|tip Open the first cell door on the left.
talk Kharan Mighthammer##9021
Tell him _"I need to know where the princess are, Kharan!"_
Gather Information from Kharan |q 4001/1
step
Leave the Blackrock Depths Dungeon
Click Here to Continue |confirm
step
Enter the building |goto Orgrimmar 40.09,36.93 < 8 |walk
talk Thrall##4949
|tip Inside the building.
turnin What Is Going On?##4001 |goto 31.77,37.82
accept The Eastern Kingdom##4002 |goto 31.77,37.82
step
talk Thrall##4949
|tip Inside the building.
turnin The Eastern Kingdom##4002 |goto 31.77,37.82
accept The Royal Rescue##4003 |goto 31.77,37.82
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
Inside the Blackrock Depths Dungeon:
kill Emperor Dagran Thaurissan##9019
|tip Don't kill Princess Moira Bronzebeard during the encounter.
|tip Interrupt her heals otherwise the encounter will be complicated.
|tip You will not be able to turn in the quest if you kill her.
Slay Emperor Dagran Thaurissan |q 4003/1
step
Inside the Blackrock Depths Dungeon:
talk Princess Moira Bronzebeard##8929
|tip She is in the room where Emperor Dagran Thaurissan was.
turnin The Royal Rescue##4003
accept The Princess Saved?##4004
step
Leave the Blackrock Depths Dungeon
Click Here to Continue |confirm
step
Enter the building |goto Orgrimmar 40.09,36.93 < 8 |walk
talk Thrall##4949
|tip Inside the building.
turnin The Princess Saved?##4004 |goto 31.77,37.82
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
turnin Attunement to the Core##7848 |goto 48.41,63.82
|tip Turning this in will allow you to teleport directly to Molten Core by talking to Lothos Riftwaker.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Raid Attunements\\Onyxia's Lair Attunement",{
author="support@zygorguides.com",
description="This guide will walk you through becoming attuned for the Onyxia's Lair raid.",
},[[
step
Reach level 55 |ding 55
|tip Use the Leveling guides to accomplish this.
step
Run up the ramp |goto Badlands 6.20,47.59 < 5 |only if walking
talk Warlord Goretooth##9077
|tip At the top of the tower.
Ask him _"What roles?"_
|tip Click through the dialogue.
collect Warlord Goretooth's Command##12563 |goto 5.80,47.53 |condition itemcount(12563) == 1 or havequest(4903) or completedq(4903)
step
use Warlord Goretooth's Command##12563
accept Warlord's Command##4903
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run up the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Jump down here |goto 48.77,63.67 < 5 |walk
Follow the path up |goto 48.83,63.66 < 5 |walk
Enter the building |goto 48.91,63.92 < 5 |walk
Enter the Blackrock Spire dungeon with your group |goto 48.95,63.88 < 7 |q 4903
|tip This quest requires you to progress through the Lower Blackrock Spire dungeon.
|tip You will likely need a full group to complete the quest.
stickystart "Collect_Important_Blackrock_Documents"
step
Inside the Lower Blackrock Spire Dungeon:
kill Highlord Omokk##9196 |q 4903/2
|tip Use the Dungeon guides to accomplish this.
step
Inside the Lower Blackrock Spire Dungeon:
kill War Master Voone##9237 |q 4903/3
|tip Use the Dungeon guides to accomplish this.
step
Inside the Lower Blackrock Spire Dungeon:
kill Overlord Wyrmthalak##9568 |q 4903/1
|tip Use the Dungeon guides to accomplish this.
step
label "Collect_Important_Blackrock_Documents"
Inside the Lower Blackrock Spire Dungeon:
click Inconspicuous Documents##175785
|tip It looks like a small open scroll laying on the ground behind one of these three bosses.
|tip Check behind each boss after killing them to see if it's there.
collect Important Blackrock Documents##12562 |q 4903/4
step
Run up the ramp |goto Badlands 6.20,47.59 < 5 |only if walking
talk Warlord Goretooth##9077
|tip At the top of the tower.
turnin Warlord's Command##4903 |goto 5.80,47.53
accept Eitrigg's Wisdom##4941 |goto 5.80,47.53
step
Follow the path |goto Orgrimmar 51.98,57.66 < 10 |only if walking
Enter the building |goto 40.25,36.95 < 7 |walk
talk Eitrigg##3144
|tip Inside the building.
Tell him _"Hello, Eitrigg. I bring news back from Blackrock Spire."_
|tip Click through the dialogue.
Council with Eitrigg |q 4941/1 |goto 34.28,39.35
step
talk Thrall##4949
|tip Inside the building.
turnin Eitrigg's Wisdom##4941 |goto 31.74,37.83
accept For The Horde!##4974 |goto 31.74,37.83
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run up the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Jump down here |goto 48.77,63.67 < 5 |walk
Follow the path up |goto 48.83,63.66 < 5 |walk
Enter the building |goto 48.91,63.92 < 5 |walk
Enter the Blackrock Spire dungeon with your group |goto 48.95,63.88 < 7 |q 4974
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
kill Warchief Rend Blackhand##10429
|tip Use the Dungeon guides to accomplish this.
collect Head of Rend Blackhand##12630 |q 4974/1
step
Follow the path |goto Orgrimmar 51.98,57.66 < 10 |only if walking
Enter the building |goto 40.25,36.95 < 7 |walk
talk Thrall##4949
|tip Inside the building.
turnin For The Horde!##4974 |goto 31.74,37.83
accept What the Wind Carries##6566 |goto 31.74,37.83
step
talk Thrall##4949
|tip Inside the building.
Tell him _"Please share your wisdom with me, Warchief."_
|tip Click through the dialogue.
Listen to Thrall's Tale |q 6566/1 |goto 31.74,37.83
step
talk Thrall##4949
|tip Inside the building.
turnin What the Wind Carries##6566 |goto 31.74,37.83
accept The Champion of the Horde##6567 |goto 31.74,37.83
step
label "Rexxar_Champion_of_the_Horde_Path_One"
map Stonetalon Mountains
path follow smart; loop off; ants curved; dist 20
path	30.39,73.93	30.07,77.17	29.77,77.90
map Desolace
path	53.34,5.86	54.72,11.16	56.39,13.39	59.43,15.18	60.89,16.96
path	62.54,20.27	63.33,27.21	61.77,32.81	60.42,37.22	57.01,38.15
path	53.39,37.31	50.37,42.62	48.99,53.91	55.06,64.40	55.74,67.74
path	51.77,71.68	50.04,75.60	47.63,75.37	40.00,78.28	39.80,82.01
path	41.88,85.48	40.77,89.83	42.26,96.67
map Feralas
path	45.88,4.39	44.90,7.23	45.05,9.16	45.87,11.01	46.46,15.48
path	46.35,21.15	48.21,23.21	48.79,25.33
Follow the path looking for Rexxar
talk Rexxar##10182
|tip He walks along the road through Stonetalon Mountains, Desolace and Feralas.
|tip He's an Orc that walks with a pet bear.
turnin The Champion of the Horde##6567 |or |next "Accept_Testament_of_Power"
'|goto 48.79,25.33 < 20 |noway |or |c
step
map Feralas
path follow smart; loop off; ants curved; dist 20
path	48.79,25.33	48.21,23.21	46.35,21.15	46.46,15.48	45.87,11.01
path	45.05,9.16	44.90,7.23	45.88,4.39
map Desolace
path	42.26,96.67	40.77,89.83	41.88,85.48	39.80,82.01	40.00,78.28
path	47.63,75.37	50.04,75.60	51.77,71.68	55.74,67.74	55.06,64.40
path	48.99,53.91	50.37,42.62	53.39,37.31	57.01,38.15	60.42,37.22
path	61.77,32.81	63.33,27.21	62.54,20.27	60.89,16.96	59.43,15.18
path	56.39,13.39	54.72,11.16	53.34,5.86
map Stonetalon Mountains
path	29.77,77.90	30.07,77.17	30.39,73.93
Follow the path looking for Rexxar
talk Rexxar##10182
|tip He walks along the road through Stonetalon Mountains, Desolace and Feralas.
|tip He's an Orc that walks with a pet bear.
turnin The Champion of the Horde##6567 |or
'|goto 30.39,73.93 < 20 |noway |or |c |next "Rexxar_Champion_of_the_Horde_Path_One"
step
label "Accept_Testament_of_Power"
talk Rexxar##10182
accept The Testament of Rexxar##6568
step
talk Myranda the Hag##11872
turnin The Testament of Rexxar##6568 |goto Western Plaguelands 50.79,77.85
accept Oculus Illusions##6569 |goto 50.79,77.85
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run up the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Jump down here |goto 48.77,63.67 < 5 |walk
Follow the path up |goto 48.83,63.66 < 5 |walk
Enter the building |goto 48.91,63.92 < 5 |walk
Enter the Blackrock Spire dungeon with your group |goto 48.95,63.88 < 7 |q 6569
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
Kill Rage Talon enemies throughout the dungeon
|tip There's a few at the very beginning of the dungeon and a lot more in The Rookery.
collect 20 Black Dragonspawn Eye##16786 |q 6569/1
step
talk Myranda the Hag##11872
turnin Oculus Illusions##6569 |goto Western Plaguelands 50.79,77.85
accept Emberstrife##6570 |goto 50.79,77.85
step
Enter the cave |goto Dustwallow Marsh 54.54,84.73 < 5 |walk
Equip the Amulet of Draconic Subversion
|tip It should be in your bags.
Equip the Amulet of Draconic Subversion |equipped Amulet of Draconic Subversion##16787 |goto 55.09,85.62 |q 6570
step
use Amulet of Draconic Subversion##16787
Become Disguised |havebuff spell:19937 |goto 55.09,85.62 |q 6570
step
Follow the path |goto 55.43,86.98 < 7 |walk
Continue following the path |goto 57.76,86.86 < 7 |walk
talk Emberstrife##10321
|tip Inside the cave.
turnin Emberstrife##6570 |goto 56.65,87.71
accept The Test of Skulls, Scryer##6582 |goto 56.65,87.71
accept The Test of Skulls, Somnus##6583 |goto 56.65,87.71
accept The Test of Skulls, Chronalis##6584 |goto 56.65,87.71
step
Follow the path |goto Tanaris 61.28,50.59 < 10 |only if walking
kill Chronalis##8197
|tip It flies around this area.
|tip Killing it will require a full group.
collect The Skull of Chronalis##16871 |q 6584/1 |goto 64.07,48.75
step
Follow the path up |goto Winterspring 59.30,43.21 < 10 |only if walking
Enter the cave |goto 57.15,49.93 < 7 |walk
Follow the path down |goto 54.65,49.94 < 10 |only if walking
kill Scryer##10664
|tiP Inside the cave.
|tip It flies around this area.
|tip Killing it will require a full group.
collect The Skull of Scryer##16869 |q 6582/1 |goto 52.87,56.08
step
kill Somnus##12900
|tip It flies around this area, between these two spots.
|tip Killing it will require a full group.
collect The Skull of Somnus##16870 |q 6583/1 |goto Swamp of Sorrows 80.44,68.40
It may also be found around [77.87,37.19]
step
Enter the cave |goto Dustwallow Marsh 54.54,84.73 < 5 |walk
Equip the Amulet of Draconic Subversion
|tip It should be in your bags.
Equip the Amulet of Draconic Subversion |equipped Amulet of Draconic Subversion##16787 |goto 55.09,85.62 |q 6584
step
use Amulet of Draconic Subversion##16787
Become Disguised |havebuff spell:19937 |goto 55.09,85.62 |q 6584
step
Follow the path |goto 55.43,86.98 < 7 |walk
Continue following the path |goto 57.76,86.86 < 7 |walk
talk Emberstrife##10321
|tip Inside the cave.
turnin The Test of Skulls, Scryer##6582 |goto 56.65,87.71
turnin The Test of Skulls, Somnus##6583 |goto 56.65,87.71
turnin The Test of Skulls, Chronalis##6584 |goto 56.65,87.71
accept The Test of Skulls, Axtroz##6585 |goto 56.65,87.71
step
Follow the path up |goto Wetlands 74.18,47.32 < 20 |only if walking
kill Axtroz##12899
|tip It flies back and forth between these two gates.
|tip Killing it will require a full group.
collect The Skull of Axtroz##16872 |q 6585/1 |goto 82.81,48.88
step
Enter the cave |goto Dustwallow Marsh 54.54,84.73 < 5 |walk
Equip the Amulet of Draconic Subversion
|tip It should be in your bags.
Equip the Amulet of Draconic Subversion |equipped Amulet of Draconic Subversion##16787 |goto 55.09,85.62 |q 6585
step
use Amulet of Draconic Subversion##16787
Become Disguised |havebuff spell:19937 |goto 55.09,85.62 |q 6585
step
Follow the path |goto 55.43,86.98 < 7 |walk
Continue following the path |goto 57.76,86.86 < 7 |walk
talk Emberstrife##10321
|tip Inside the cave.
turnin The Test of Skulls, Axtroz##6585 |goto 56.65,87.71
accept Ascension...##6601 |goto 56.65,87.71
step
label "Rexxar_Ascension_Path_One"
map Stonetalon Mountains
path follow smart; loop off; ants curved; dist 20
path	30.39,73.93	30.07,77.17	29.77,77.90
map Desolace
path	53.34,5.86	54.72,11.16	56.39,13.39	59.43,15.18	60.89,16.96
path	62.54,20.27	63.33,27.21	61.77,32.81	60.42,37.22	57.01,38.15
path	53.39,37.31	50.37,42.62	48.99,53.91	55.06,64.40	55.74,67.74
path	51.77,71.68	50.04,75.60	47.63,75.37	40.00,78.28	39.80,82.01
path	41.88,85.48	40.77,89.83	42.26,96.67
map Feralas
path	45.88,4.39	44.90,7.23	45.05,9.16	45.87,11.01	46.46,15.48
path	46.35,21.15	48.21,23.21	48.79,25.33
Follow the path looking for Rexxar
talk Rexxar##10182
|tip He walks along the road through Stonetalon Mountains, Desolace and Feralas.
|tip He's an Orc that walks with a pet bear.
turnin Ascension...##6601 |or |next "Accept_Blood_of_the_Black_Dragon_Champion"
'|goto 48.79,25.33 < 20 |noway |or |c
step
map Feralas
path follow smart; loop off; ants curved; dist 20
path	48.79,25.33	48.21,23.21	46.35,21.15	46.46,15.48	45.87,11.01
path	45.05,9.16	44.90,7.23	45.88,4.39
map Desolace
path	42.26,96.67	40.77,89.83	41.88,85.48	39.80,82.01	40.00,78.28
path	47.63,75.37	50.04,75.60	51.77,71.68	55.74,67.74	55.06,64.40
path	48.99,53.91	50.37,42.62	53.39,37.31	57.01,38.15	60.42,37.22
path	61.77,32.81	63.33,27.21	62.54,20.27	60.89,16.96	59.43,15.18
path	56.39,13.39	54.72,11.16	53.34,5.86
map Stonetalon Mountains
path	29.77,77.90	30.07,77.17	30.39,73.93
Follow the path looking for Rexxar
talk Rexxar##10182
|tip He walks along the road through Stonetalon Mountains, Desolace and Feralas.
|tip He's an Orc that walks with a pet bear.
turnin Ascension...##6601 |or
'|goto 30.39,73.93 < 20 |noway |or |c |next "Rexxar_Ascension_Path_One"
step
label "Accept_Blood_of_the_Black_Dragon_Champion"
talk Rexxar##10182
accept Blood of the Black Dragon Champion##6602
step
Follow the path up |goto Searing Gorge 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Searing Gorge 34.76,83.98 < 7 |walk
Run up the chain |goto Eastern Kingdoms 48.73,63.79 < 5 |walk
Jump down here |goto 48.77,63.67 < 5 |walk
Follow the path up |goto 48.83,63.66 < 5 |walk
Enter the building |goto 48.91,63.92 < 5 |walk
Enter the Blackrock Spire dungeon with your group |goto 48.95,63.88 < 7 |q 6602
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
kill General Drakkisath##10363
|tip Use the Dungeon guides to accomplish this.
collect Blood of the Black Dragon Champion##16663 |q 6602/1
step
label "Rexxar_Blood_of_the_Black_Dragon_Champion_Path_One"
map Stonetalon Mountains
path follow smart; loop off; ants curved; dist 20
path	30.39,73.93	30.07,77.17	29.77,77.90
map Desolace
path	53.34,5.86	54.72,11.16	56.39,13.39	59.43,15.18	60.89,16.96
path	62.54,20.27	63.33,27.21	61.77,32.81	60.42,37.22	57.01,38.15
path	53.39,37.31	50.37,42.62	48.99,53.91	55.06,64.40	55.74,67.74
path	51.77,71.68	50.04,75.60	47.63,75.37	40.00,78.28	39.80,82.01
path	41.88,85.48	40.77,89.83	42.26,96.67
map Feralas
path	45.88,4.39	44.90,7.23	45.05,9.16	45.87,11.01	46.46,15.48
path	46.35,21.15	48.21,23.21	48.79,25.33
Follow the path looking for Rexxar
talk Rexxar##10182
|tip He walks along the road through Stonetalon Mountains, Desolace and Feralas.
|tip He's an Orc that walks with a pet bear.
turnin Blood of the Black Dragon Champion##6602 |or
|tip Completing this quest will award you with a Darkfire Amulet, which will allow you to enter the Onyxia's Lair raid.
|tip You must keep it in your inventory in order to enter the raid instance.
'|goto 48.79,25.33 < 20 |noway |or |c
step
map Feralas
path follow smart; loop off; ants curved; dist 20
path	48.79,25.33	48.21,23.21	46.35,21.15	46.46,15.48	45.87,11.01
path	45.05,9.16	44.90,7.23	45.88,4.39
map Desolace
path	42.26,96.67	40.77,89.83	41.88,85.48	39.80,82.01	40.00,78.28
path	47.63,75.37	50.04,75.60	51.77,71.68	55.74,67.74	55.06,64.40
path	48.99,53.91	50.37,42.62	53.39,37.31	57.01,38.15	60.42,37.22
path	61.77,32.81	63.33,27.21	62.54,20.27	60.89,16.96	59.43,15.18
path	56.39,13.39	54.72,11.16	53.34,5.86
map Stonetalon Mountains
path	29.77,77.90	30.07,77.17	30.39,73.93
Follow the path looking for Rexxar
talk Rexxar##10182
|tip He walks along the road through Stonetalon Mountains, Desolace and Feralas.
|tip He's an Orc that walks with a pet bear.
turnin Blood of the Black Dragon Champion##6602 |or
|tip Completing this quest will award you with a Darkfire Amulet, which will allow you to enter the Onyxia's Lair raid.
|tip You must keep it in your inventory in order to enter the raid instance.
'|goto 30.39,73.93 < 20 |noway |or |c |next "Rexxar_Blood_of_the_Black_Dragon_Champion_Path_One"
]])
