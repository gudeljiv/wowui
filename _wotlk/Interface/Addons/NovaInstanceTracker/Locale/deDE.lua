local L = LibStub("AceLocale-3.0"):NewLocale("NovaInstanceTracker", "deDE");
if (not L) then
	return;
end

L["noTimer"] = "--"; --No timer (used only in map timer frames)
L["noCurrentTimer"] = "Kein aktueller Timer"; --No current timer
L["noActiveTimers"] = "Kein aktiver Timer";	--No active timers
L["second"] = "Sekunde"; --Second (singular).
L["seconds"] = "Sekunden"; --Seconds (plural).
L["minute"] = "Minute"; --Minute (singular).
L["minutes"] = "Minuten"; --Minutes (plural).
L["hour"] = "Stunde"; --Hour (singular).
L["hours"] = "Stunden"; --Hours (plural).
L["day"] = "Tag"; --Day (singular).
L["days"] = "Tage"; --Days (plural).
L["year"] = "year"; --Year (singular).
L["years"] = "years"; --Years (plural).
L["secondMedium"] = "sec"; --Second (singular).
L["secondsMedium"] = "secs"; --Seconds (plural).
L["minuteMedium"] = "min"; --Minute (singular).
L["minutesMedium"] = "mins"; --Minutes (plural).
L["hourMedium"] = "hour"; --Hour (singular).
L["hoursMedium"] = "hours"; --Hours (plural).
L["dayMedium"] = "day"; --Day (singular).
L["daysMedium"] = "days"; --Days (plural).
L["yearMedium"] = "year"; --Day (singular).
L["yearsMedium"] = "years"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "d"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["yearShort"] = "y"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Startet in %s"; --"Starts in 1hour".
L["endsIn"] = "Endet in %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Dein Nova Instance Tracker Addon ist nicht mehr aktuell. Bitte führe ein Update über https://www.curseforge.com/wow/addons/nova-instance-tracker oder den Twitch Client durch.";
L["Options"] = "Einstellungen";
L["Reset Data"] = "Reset Data"; --A button to Reset data.

L["Error"] = "Error";
L["delete"] = "Delete";
L["confirmInstanceDeletion"] = "Confirm Instance Deletion";
L["confirmCharacterDeletion"] = "Confirm Character Deletion";

-------------
---Config---
-------------
--There are 2 types of strings here, the names end in Title or Desc L["exampleTitle"] and L["exampleDesc"].
--Title must not be any longer than 21 characters (maybe less for chinese characters because they are larger).
--Desc can be any length.

---General Options---
L["generalHeaderDesc"] = "General Options";

L["chatColorTitle"] = "Chat Msg Color";
L["chatColorDesc"] = "What color should the msgs in chat be?";

L["resetColorsTitle"] = "Reset Colors";
L["resetColorsDesc"] = "Reset colors back to default.";

L["timeStampFormatTitle"] = "Time Stamp Format";
L["timeStampFormatDesc"] = "Set which timestamp format to use, 12 hour (1:23pm) or 24 hour (13:23).";

L["timeStampZoneTitle"] = "Local Time / Server Time";
L["timeStampZoneDesc"] = "Use local time or server time for timestamps?";

L["minimapButtonTitle"] = "Show Minimap Button";
L["minimapButtonDesc"] = "Show the NIT button the minimap?";

---Sounds---
L["soundsHeaderDesc"] = "Sounds";

L["soundsTextDesc"] = "Set sound to \"None\" to disable.";

L["disableAllSoundsTitle"] = "Disable All Sounds";
L["disableAllSoundsDesc"] = "Disable all sounds from this addon.";

L["extraSoundOptionsTitle"] = "Extra Sound Options";
L["extraSoundOptionsDesc"] = "Enable this to display all the sounds from all your addons at once in the dropdown lists here.";

L["notesHeaderDesc"] = "Some Notes:";
L["notesDesc"] = "This addon does it's best to work out when you can enter more instances but Blizzard's lockout system is sometimes buggy and you can get locked before reaching the correct limit. Sometimes you can only enter 4 per hour, but also sometimes you enter 6 per hour.";

L["logHeaderDesc"] = "Log Window";

L["openInstanceLogFrameTitle"] = "Open Instance Log";

L["logSizeTitle"] = "How many instances shown in log";
L["logSizeDesc"] = "How many instance do you want to be shown in the log? Max of 300 are stored, 100 is default shown (you can open log with /NIT).";

L["enteredMsgTitle"] = "Instance Entered Msg";
L["enteredMsgDesc"] = "This will print a msg to your main chat window when you enter an instance with an X icon to delete the new instance from database if you want.";

L["raidEnteredMsgTitle"] = "Raid Entered Msg";
L["raidEnteredMsgDesc"] = "This will print a msg to your main chat window when you enter a raid with an X icon to delete the new instance from database if you want.";

L["pvpEnteredMsgTitle"] = "PvP Entered Msg";
L["pvpEnteredMsgDesc"] = "This will print a msg to your main chat window when you enter a pvp instance with an X icon to delete the new instance from database if you want.";

L["noRaidInstanceMergeMsgTitle"] = "Hide Raid Merged";
L["noRaidInstanceMergeMsgDesc"] = "Hide the instance merged msg when you enter a raid and detect the same ID.";

L["instanceResetMsgTitle"] = "Group Instance Reset";
L["instanceResetMsgDesc"] = "This will show a msg to your party or raid which instances were successfully reset if you are the group leader. Example: \"Wailing Caverns was reset.\"";

L["showMoneyTradedChatTitle"] = "Gold Traded In Chat";
L["showMoneyTradedChatDesc"] = "Show in trade when you give or receive gold from someone in the chat window? (Helps keep tack of who you have paid or received gold from in boost groups).";

L["instanceStatsHeaderDesc"] = "End of Dungeon Stats Output";

L["instanceStatsTextDesc"] = "Select here which stats to display to group chat or to your chat window when leaving a dungeon.";

L["instanceStatsOutputTitle"] = "Show Stats";
L["instanceStatsOutputDesc"] = "Show stats about the dungeon when you leave?";
			
L["instanceStatsOutputWhereTitle"] = "Show Stats Where";
L["instanceStatsOutputWhereDesc"] = "Where do you want to show the stats, the chat window to yourself or show the group chat?";

L["instanceStatsOutputMobCountTitle"] = "Show Mob Count";
L["instanceStatsOutputMobCountDesc"] = "Show how many mobs were killed while inside dungeon?";

L["instanceStatsOutputXPTitle"] = "Show XP";
L["instanceStatsOutputXPDesc"] = "Show how much experience was earned while inside dungeon?";

L["instanceStatsOutputAverageXPTitle"] = "Show Average XP";
L["instanceStatsOutputAverageXPDesc"] = "Show average XP per kill while inside dungeon?";

L["instanceStatsOutputTimeTitle"] = "Show Time";
L["instanceStatsOutputTimeDesc"] = "Show how long you spent inside dungeon?";

L["instanceStatsOutputGoldTitle"] = "Show Raw Gold";
L["instanceStatsOutputGoldDesc"] = "Show how much raw gold was looted from mobs while inside dungeon?";

L["instanceStatsOutputAverageGroupLevelDesc"] = "Show Average Level";
L["instanceStatsOutputAverageGroupLevelTitle"] = "Show the average group level inside dungeon?";

L["showAltsLogTitle"] = "Show Alts";
L["showAltsLogDesc"] = "Show alts in the instance log?";

L["timeStringTypeTitle"] = "Time String Format";
L["timeStringTypeDesc"] = "What time string format to use in the instance log?\n|cFFFFFF00Long:|r 1 minute 30 seconds\n|cFFFFFF00Medium|r: 1 min 30 secs\n|cFFFFFF00Short|r 1m30s";

L["showLockoutTimeTitle"] = "Show Lockout Time";
L["showLockoutTimeDesc"] = "This will show lockout time left in the instance log for instances within the past 24 hours, with this unticked it will show the time entered instead like in older versions.";

L["colorsHeaderDesc"] = "Colors"

L["mergeColorTitle"] = "Instance Merge Color";
L["mergeColorDesc"] = "What color should the msg in chat be when the same instance as last is detected and the data is merged?";

L["detectSameInstanceTitle"] = "Detect Same Instance";
L["detectSameInstanceDesc"] = "Auto detect if you re-enter the same instance so the addon doesn't count it as 2 seperate instances?";

L["showStatsInRaidTitle"] = "Show Stats In Raid";
L["showStatsInRaidDesc"] = "Show stats when in a raid? Disable this to only show stats to group when you are in a 5 man party (This option only works when you have group chat as your stats output).";

L["printRaidInsteadTitle"] = "Print While In Raid";
L["printRaidInsteadDesc"] = "If you have the option to disable sending stats to raid chat then this will print them to your chat window instead so you can still see them.";

L["statsOnlyWhenActivityTitle"] = "Only When Activity";
L["statsOnlyWhenActivityDesc"] = "Only show stats when some activity occured while inside the dungeon? This means only if you killed some mobs, got xp, looted some gold etc. This will make it not show empty stats.";

L["show24HourOnlyTitle"] = "Show Last 24h Only";
L["show24HourOnlyDesc"] = "Only show instance from the last 24 hours in the instance log?";

L["trimDataHeaderDesc"] = "Data Cleanup";

L["trimDataBelowLevelTitle"] = "Maximum Level To Remove";
L["trimDataBelowLevelDesc"] = "Select maximum level of characters to remove from database, all characters this level and below will be deleted.";

L["trimDataBelowLevelButtonTitle"] = "Remove Characters";
L["trimDataBelowLevelButtonDesc"] = "Click this button to remove all characters with the selected level and lower from this addon database.";

L["trimDataTextDesc"] = "Remove multiple characters from the database:";
L["trimDataText2Desc"] = "Remove one character from the database:";

L["trimDataCharInputTitle"] = "Remove One Character Input";
L["trimDataCharInputDesc"] = "Type a character here to remove, format as Name-Realm (Case sensitive). Note: This removes buff count data permanently.";

L["trimDataBelowLevelButtonConfirm"] = "Are you sure you want to remove all characters below level %s from the database?";
L["trimDataCharInputConfirm"] = "Are you sure you want to remove this character %s from the database?";

L["trimDataMsg2"] = "Removing all chars below level %s.";
L["trimDataMsg3"] = "Removed: %s.";
L["trimDataMsg4"] = "Done, no characters found.";
L["trimDataMsg5"] = "Done, removed %s characters.";
L["trimDataMsg6"] = "Please enter a valid Character-Name to delete from database.";
L["trimDataMsg7"] = "This character name %s doesn't include a realm, please input Name-Realm.";
L["trimDataMsg8"] = "Error removing %s from the database, character not found (name is case sensitive).";
L["trimDataMsg9"] = "Removed %s from the database.";

L["instanceFrameSelectAltMsg"] = "Select which alt to show if \"Show All Alts\" is unticked.\nOr which alt to colorize if \"Show All Alts\" is ticked.";

L["enteredDungeon"] = "New instance %s %s, click";
L["enteredDungeon2"] = "if this is not a new instance.";
L["enteredRaid"] = "New instance %s, this raid doesn't count towards lockout.";
L["loggedInDungeon"] = "You have logged in inside %s %s, if this is not a new instance click";
L["loggedInDungeon2"] = "to delete this instance from the database.";
L["reloadDungeon"] = "UI Reload detected %s, loading last instance data instead of creating new.";
L["thisHour"] = "this hour";
L["statsError"] = "Error finding stats for instance id %s.";
L["statsMobs"] = "Mobs:";
L["statsXP"] = "XP:";
L["statsAverageXP"] = "Average XP/Mob:";
L["statsRunsPerLevel"] = "Runs per level:";
L["statsRunsNextLevel"] = "Runs until next level:";
L["statsTime"] = "Time:";
L["statsAverageGroupLevel"] = "Average Group Level:";
L["statsGold"] = "Gold";
L["sameInstance"] = "Same instance ID as last detected %s, merging database entries.";
L["deleteInstance"] = "Deleted instance [%s] %s (%s ago) from the database.";
L["deleteInstanceError"] = "Error deleting %s.";
L["countString"] = "You have entered %s instances in the past hour and %s in the past 24h";
L["countStringColorized"] = "You have entered %s %s %s instances in the past hour and %s %s %s in the past 24h";
L["now"] = "now";
L["in"] = "in";
L["active24"] = "24h lockout active";
L["nextInstanceAvailable"] = "Next instance available";
L["gave"] = "Gave";
L["received"] = "Received";
L["to"] = "to";
L["from"] = "from";
L["playersStillInside"] = "has been reset (Players still inside old instance can zone out and enter new).";
L["Gold"] = "Gold";
L["gold"] = "gold";
L["silver"] = "silver";
L["copper"] = "copper";
L["newInstanceNow"] = "A new instance can be entered now";
L["thisHour"] = "this hour";
L["thisHour24"] = "this 24hours";
L["openInstanceFrame"] = "Open Instance Frame";
L["openYourChars"] = "Open Your Characters";
L["openTradeLog"] = "Open Trade Log";
L["config"] = "Config";
L["thisChar"] = "This character";
L["yourChars"] = "Your Characters";
L["instancesPastHour"] = "instances in the past hour.";
L["instancesPastHour24"] = "instances in the past 24h.";
L["leftOnLockout"] = "left on lockout";
L["tradeLog"] = "Trade Log";
L["pastHour"] = "Past hour";
L["pastHour24"] = "Past 24 hours";
L["older"] = "Older";
L["raid"] = "Raid";
L["alts"] = "Alts";
L["deleteEntry"] = "Delete entry";
L["lastHour"] = "Last hour";
L["lastHour24"] = "Last 24h";
L["entered"] = "Entered";
L["ago"] = "ago";
L["stillInDungeon"] = "Still inside dungeon";
L["leftOnLockout"] = "left on lockout";
L["leftOnDailyLockout"] = "left on daily lockout";
L["noLockout"] = "No lockout for this raid";
L["unknown"] = "Unknown";
L["instance"] = "Instance";
L["timeEntered"] = "Time Entered";
L["timeLeft"] = "Time Left";
L["timeInside"] = "Time Inside";
L["mobCount"] = "Mob Count";
L["experience"] = "Experience";
L["experienceShort"] = "XP";
L["rawGoldMobs"] = "Raw Gold From Mobs";
L["enteredLevel"] = "Entered Level";
L["leftLevel"] = "Left Level";
L["averageGroupLevel"] = "Average Group Level";
L["currentLockouts"] = "current lockouts";
L["repGains"] = "Reputation Gains";
L["groupMembers"] = "Group Members";
L["tradesWhileInside"] = "Trades while inside";
L["noDataInstance"] = "No data available for this instance.";
L["restedOnlyText"] = "Show Rested Only";
L["restedOnlyTextTooltip"] = "Only show chars that have rested XP? Untick this to show all alts, even max level and alts with no rested.";
L["deleteEntry"] = "Delete entry"; --Example: "Delete entry 5";
L["online"] = "Online";
L["maximum"] = "Max";
L["level"] = "Level";
L["rested"] = "Rested";
L["realmGold"] = "Realm gold for";
L["total"] = "Total";
L["guild"] = "Guild";
L["resting"] = "Resting";
L["notResting"] = "Not Resting";
L["rested"] = "Rested";
L["restedBubbles"] = "Rested Bubbles";
L["restedState"] = "Rested State";
L["bagSlots"] = "Bag slots";
L["durability"] = "Durability";
L["items"] = "Items";
L["ammunition"] = "Ammo";
L["petStatus"] = "Pet Status";
L["name"] = "Name";
L["family"] = "Family";
L["happiness"] = "Happiness";
L["loyaltyRate"] = "Loyalty rate";
L["petExperience"] = "Pet XP";
L["unspentTrainingPoints"] = "Unspent Training points";
L["professions"] = "Professions";
L["lastSeenPetDetails"] = "Last seen pet details";
L["currentPet"] = "Current Pet";
L["noPetSummoned"] = "No Pet Summoned";
L["lastSeenPetDetails"] = "Last seen pet details";
L["noProfessions"] = "No professions found.";
L["cooldowns"] = "Cooldowns";
L["left"] = "left"; -- This is left as in "time left";
L["ready"] = "Ready.";
L["pvp"] = "PvP"; --Must be 3 letters max to fit.
L["rank"] = "Rank";
L["lastWeek"] = "Last week";
L["attunements"] = "Attunements";
L["currentRaidLockouts"] = "Current Raid Lockouts";
L["none"] = "None.";

L["instanceStatsOutputRunsPerLevelTitle"] = "Runs Per Level";
L["instanceStatsOutputRunsPerLevelDesc"] = "Show how many runs it will take per level?";

L["instanceStatsOutputRunsNextLevelTitle"] = "Runs Until Next Level";
L["instanceStatsOutputRunsNextLevelDesc"] = "Show how many more runs you need until your next level?";

L["instanceWindowWidthTitle"] = "Instance Window Width";
L["instanceWindowWidthDesc"] = "How wide should the instance window be.";

L["instanceWindowHeightTitle"] = "Instance Window Height";
L["instanceWindowHeightDesc"] = "How high should the instance window be.";

L["charsWindowWidthTitle"] = "Characters Window Width";
L["charsWindowWidthDesc"] = "How wide should the characters info window be.";

L["charsWindowHeightTitle"] = "Characters Window Height";
L["charsWindowHeightDesc"] = "How high should the characters info window be.";

L["tradeWindowWidthTitle"] = "Trade Window Width";
L["tradeWindowWidthDesc"] = "How wide should the trade window be.";

L["tradeWindowHeightTitle"] = "Trade Window Height";
L["tradeWindowHeightDesc"] = "How high should the trade window be.";

L["resetFramesTitle"] = "Reset Windows";
L["resetFramesDesc"] = "Reset all windows back to the middle of screen and sizes back to default.";

L["resetFramesMsg"] = "Resetting all window positions and size.";

L["statsRep"] = "Rep:";

L["instanceStatsOutputRepTitle"] = "Reputation Gained";
L["instanceStatsOutputRepDesc"] = "Show how much repuation gained while inside the dungeon?";

L["instanceStatsOutputHKTitle"] = "Honor";
L["instanceStatsOutputHKDesc"] = "Show how much honor gained while inside a battleground?";

L["experiencePerHour"] = "XP/Hour";

L["instanceStatsOutputXpPerHourTitle"] = "Show XP/Hour";
L["instanceStatsOutputXpPerHourDesc"] = "Show how much experience per hour was earned while inside dungeon?";

L["autoDialogueDesc"] = "Auto NPC Dialogue";

L["autoSlavePensTitle"] = "Auto Slave Pens";
L["autoSlavePensDesc"] = "Auto dialogue with the NPC at the end of slave pens in the cage?";

L["autoCavernsFlightTitle"] = "Auto CoT Flight";
L["autoCavernsFlightDesc"] = "Auto dialogue with the dragon near the summoning stone at caverns of time to fly down? (Only if \"To The Master's Lair\" quest is complete)";

L["autoBlackMorassTitle"] = "Auto Black Morass";
L["autoBlackMorassDesc"] = "Auto dialogue with the NPC at the start of black morass to get your beacon? (Only if \"Hero of the Brood\" quest is complete)";

L["autoSfkDoorTitle"] = "Auto Sfk Door";
L["autoSfkDoorDesc"] = "Auto dialogue with the NPC in shadowfang keep that opens the door?";

L["honorGains"] = "Honor Gains";
L["Honor"] = "Honor";
L["Won"] = "Won";
L["Lost"] = "Lost";
L["Arena"] = "Arena";
L["Arena Points"] = "Arena Points";

L["stillInArena"] = "Still inside";
L["stillInBattleground"] = "Still inside";

L["resetAllInstancesConfirm"] = "Are you sure you want to delete all instance data from the log?";
L["All Instance log data has been deleted."] = "All Instance log data has been deleted.";

L["resetAllInstancesTitle"] = "Reset Instance Data";
L["resetAllInstancesDesc"] = "This will reset all instance data and remove everything from the log. This does not reset trades.";

L["autoCavernsArthasTitle"] = "Auto CoS Arthas";
L["autoCavernsArthasDesc"] = "Auto dialogue owith arthas in the Culling of Strathholme in Wrath.";

L["Mythic Plus"] = "Mythic Plus";
L["mythicPlusShort"] = "Mythic+";

L["noCurrentRaidLockouts"] = "No current raid lockouts.";

L["weeklyQuests"] = "Weekly Quests";
L["dailyQuests"] = "Daily Quests";

L["openLockouts"] = "Open Lockouts";

L["autoGammaBuffDesc"] = "Gamma Dungeons";

L["autoGammaBuffTitle"] = "Auto Gamma Buff";
L["autoGammaBuffDesc"] = "Auto get the right gamma buff for your class when you talk to the buff NPC in a Gamma Dungeon.";

L["autoGammaBuffReminderTitle"] = "Gamma Buff Reminder";
L["autoGammaBuffReminderDesc"] = "Print a msg to chat at the start of the dung remimding you to get the buff if you don't have it.";

L["autoGammaBuffTypeTitle"] = "Gamma Buff Type";
L["autoGammaBuffTypeDesc"] = "What buff type fo you want, Auto Select will auto choose between melee/ranged/healer/tank based off your spec. Or you can override it with a different selection. Buff selection is a character specific config option.";

L["dungeonPopTimerTitle"] = "Dungeon Pop Timer";
L["dungeonPopTimerDesc"] = "Show a timer on the dungeon queue pop window that shows how long left to click enter?";

L["autoWrathDailiesTitle"] = "Auto Get Daily Quests";
L["autoWrathDailiesDesc"] = "Auto get and hand in wrath daily quests from Archmage Lan'dalock in Dalaran";
			
L["gammaConfigWarning"] = "Gamma buff choice is character specific, if you change it on this character it won't effect your other characters.";
L["autoGammaBuffReminder"] = "Get Gamma Dungeon buff from %s.";
L["Sunreaver Warden"] = "Sunreaver Warden";
L["Silver Covenant Warden"] = "Silver Covenant Warden";
L["note"] = "Note:";
L["Click an entry to post stats."] = "Click an entry to post stats.";
L["Show Alts"] = "Show Alts";
L["showAltsTooltip"] = "Show all alts in the instance log? (Lockouts are per character)";
L["PvE"] = "PvE"; --Must be 3 letters max to fit. (PvP already exists further up)
L["Hold to drag"] = "Hold to drag";
L["Raid Lockouts (Including Alts)"] = "Raid Lockouts (Including Alts)";
L["No trade logs found."] = "No trade logs found.";
L["Today"] = "Today";
L["Yesterday"] = "Yesterday";

L["Level Log"] = "Level Log";
L["Mouseover log entry for more info"] = "Mouseover log entry for more info";
L["Current Level"] = "Current Level";
L["Leveling history for"] = "Leveling history for";
L["Unknown Time"] = "Unknown Time";
L["Unknown Zone"] = "Unknown Zone";
L["Zone"] = "Zone";
L["SubZone"] = "SubZone";
L["Ding"] = "Ding"; --Level up.
L["Map coords"] = "Map coords";
L["Gold owned at start of level"] = "Gold owned at start of level";
L["Gold change during this level"] = "Gold change during this level";
L["Quests completed during this level"] = "Quests completed during this level";
L["Mobs that gave exp during this level"] = "Mobs that gave exp during this level";
L["Played time this level"] = "Played time this level";
L["Total Played"] = "Total Played";
L["firstTimeSeeingCharPlayed"] = "First time seeing this character was at this level, played time for this level is likely wrong.";

L["Left-Click"] = "Left-Click";
L["Right-Click"] = "Right-Click";
L["Shift Left-Click"] = "Shift Left-Click";
L["Shift Right-Click"] = "Shift Right-Click";
L["Middle-Click"] = "Middle-Click";
L["Control Left-Click"] = "Ctrl Left-Click";

L["Lockouts"] = "Lockouts";
L["Instance"] = "Instance";
L["ZoneID"] = "ZoneID";
L["Show dungeons and raids?"] = "Show dungeons and raids?";
L["Show battleground and arena instances?"] = "Show battleground and arena instances?";
L["Party"] = "Party";
L["Guild"] = "Guild";
L["Copy Paste"] = "Copy Paste";
L["Print"] = "Print";
L["Post Stats for log"] = "Post Stats for log";
L["Alts (Mouseover names for info)"] = "Alts (Mouseover names for info)";
L["Min Level"] = "Min Level";
L["No guild"] = "No guild";
L["No guild rank"] = "No guild rank";
L["Show leveling history for"] = "Show leveling history for";
L["Test Instance"] = "Test Instance";
L["Long"] = "Long";
L["Medium"] = "Medium";
L["Short"] = "Short";
L["Chat Window"] = "Chat Window";
L["Group Chat (Party/Raid)"] = "Group Chat (Party/Raid)";
L["12 hour"] = "12 hour";
L["24 hour"] = "24 hour";

L["Molten Core"] = "Molten Core";
L["Onyxia's Lair"] = "Onyxia's Lair";
L["Blackwing Lair"] = "Blackwing Lair";
L["Naxxramas"] = "Naxxramas";
L["Karazhan"] = "Karazhan";
L["The Shattered Halls"] = "The Shattered Halls";
L["Serpentshrine Cavern"] = "Serpentshrine Cavern";
L["The Arcatraz"] = "The Arcatraz";
L["Black Morass"] = "Black Morass";
L["Battle of Mount Hyjal"] = "Battle of Mount Hyjal";
L["Black Temple"] = "Black Temple";
L["Hellfire Citadel"] = "Hellfire Citadel";
L["Coilfang Reservoir"] = "Coilfang Reservoir";
L["Shadow Labyrinth"] = "Shadow Labyrinth";
L["Auchindoun"] = "Auchindoun";
L["Tempest Keep"] = "Tempest Keep";
L["Caverns of Time"] = "Caverns of Time";
L["deletedCharOnRealm"] = "Deleted character %s on realm [%s].";
L["deletedCharOnRealmNewInfo"] = "Deleted character %s on realm [%s], recording new info.";

L["Time"] = "Time";
L["Show time?"] = "Show time?";
L["Show Zone where trade happened?"] = "Show Zone where trade happened?";
L["Time Ago"] = "Time Ago";
L["Show how long ago?"] = "Show how long ago?";
L["Records"] = "Records";
L["How many trade records to show?"] = "How many trade records to show?";
L["Current Hour Lockouts"] = "Current Hour Lockouts";
L["Current Dungeon Stats"] = "Current Dungeon Stats";
L["Log Entry"] = "Log Entry";
L["Local Time"] = "Local Time";
L["Server Time"] = "Server Time";
L["Example"] = "Example";

--Abbreviated days/months.
L["Mon"] = "Mon";
L["Tue"] = "Tue";
L["Wed"] = "Wed";
L["Thu"] = "Thu";
L["Fri"] = "Fri";
L["Sat"] = "Sat";
L["Sun"] = "Sun";

L["Jan"] = "Jan";
L["Feb"] = "Feb";
L["Mar"] = "Mar";
L["Apr"] = "Apr";
L["May"] = "May";
L["Jun"] = "Jun";
L["Jul"] = "Jul";
L["Aug"] = "Aug";
L["Sep"] = "Sep";
L["Oct"] = "Oct";
L["Nov"] = "Nov";
L["Dec"] = "Dec";

L["Blacksmithing"] = "Schmiedekunst";
L["Leatherworking"] = "Lederverarbeitung";
L["Alchemy"] = "Alchimie";
L["Herbalism"] = "Kräuterkunde";
L["Cooking"] = "Kochkunst";
L["Mining"] = "Bergbau";
L["Tailoring"] = "Schneiderei";
L["Engineering"] = "Ingenieurskunst";
L["Enchanting"] = "Verzauberkunst";
L["Fishing"] = "Angeln";
L["Skinning"] = "Kürschnerei";
L["Jewelcrafting"] = "Juwelenschleifen";
L["Inscription"] = "Inschriftenkunde";
L["First Aid"] = "Erste Hilfe";

L["Wrath Cooking Daily"] = "Wrath Cooking Daily";
L["Wrath Fishing Daily"] = "Wrath Fishing Daily";
L["Wrath Jewelcrafting Daily"] = "Wrath Jewelcrafting Daily";
L["Cata Cooking Daily"] = "Cata Cooking Daily";
L["Cata Fishing Daily"] = "Cata Fishing Daily";
L["Cata Jewelcrafting Daily"] = "Cata Jewelcrafting Daily";

L["Tarnished Undermine Real"] = "Angelaufener Real aus Undermine";

L["Dungeon weeklies remaining"] = "Dungeon weeklies remaining";

L["Currency"] = "Currency";
L["Currencies"] = "Currencies";

L["instanceStatsOutputCurrencyTitle"] = "Currency";
L["instanceStatsOutputCurrencyDesc"] = "Show what currencies were gained while inside a dungeon?";

L["lootReminderDesc"] = "Loot Reminders";

L["lootReminderRealTitle"] = "Tarnished Undermine Real";
L["lootReminderRealDesc"] = "Show a reminder to loot Tarnished Undermine Real in SoD when a boss dies that can drop it.";

L["lootReminderSizeTitle"] = "Text Size";
L["lootReminderSizeDesc"] = "What size text to show on the reminder.";

L["lootReminderXTitle"] = "X Position";
L["lootReminderXDesc"] = "Adjust this for the left/right position of the reminder text.";

L["lootReminderYTitle"] = "Y Position";
L["lootReminderYDesc"] = "Adjust this for the up/down position of the reminder text.";

L["Looted"] = "Looted";
L["Not Looted"] = "Not Looted";
L["Killed But Not Looted"] = "Killed But Not Looted";
L["Loot the Tarnished Undermine Real"] = "Loot the Tarnished Undermine Real";

L["Reminder"] = "Reminder";
L["missingArgentDawnTrinket"] = "%s trinket reminder %s isn't equipped." --Argent Dawn trinket reminder [Rune of the Dawn] isn't equipped.

L["argentDawnTrinketReminderTitle"] = "Argent Dawn Trinket Reminder";
L["argentDawnTrinketReminderDesc"] = "Argent Dawn trinket reminder in chat if you enter Scholomance/Stratholme with the trinket in bags and not exalted.";