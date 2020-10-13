local L = LibStub("AceLocale-3.0"):NewLocale("NovaInstanceTracker", "enUS", true, true);

L["noTimer"] = "No timer"; --No timer
L["noCurrentTimer"] = "No current timer"; --No current timer
L["noActiveTimers"] = "No active timers";	--No active timers
L["second"] = "second"; --Second (singular).
L["seconds"] = "seconds"; --Seconds (plural).
L["minute"] = "minute"; --Minute (singular).
L["minutes"] = "minutes"; --Minutes (plural).
L["hour"] = "hour"; --Hour (singular).
L["hours"] = "hours"; --Hours (plural).
L["day"] = "day"; --Day (singular).
L["days"] = "days"; --Days (plural).
L["secondMedium"] = "sec"; --Second (singular).
L["secondsMedium"] = "secs"; --Seconds (plural).
L["minuteMedium"] = "min"; --Minute (singular).
L["minutesMedium"] = "mins"; --Minutes (plural).
L["hourMedium"] = "hour"; --Hour (singular).
L["hoursMedium"] = "hours"; --Hours (plural).
L["dayMedium"] = "day"; --Day (singular).
L["daysMedium"] = "days"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "d"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Starts in %s"; --"Starts in 1hour".
L["endsIn"] = "Ends in %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova Instance Tracker is out of date, please update at https://www.curseforge.com/wow/addons/nova-instance-tracker";
L["Options"] = "Options";
L["Reset Data"] = "Reset Data"; --A button to Reset data.

---New---

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


---New Options

L["notesHeaderDesc"] = "Some Notes:";
L["notesDesc"] = "This addon does it's best to work out when you can enter more instances but Blizzard's lockout system is sometimes buggy and you can get locked before reaching the correct limit.";

L["logHeaderDesc"] = "Log Window";

L["openInstanceLogFrameTitle"] = "Open Instance Log";

L["logSizeTitle"] = "How many instances shown in log";
L["logSizeDesc"] = "How many instance do you want to be shown in the log? Max of 300 are stored, 100 is default shown (you can open log with /NIT).";

L["enteredMsgTitle"] = "Instance Entered Msg";
L["enteredMsgDesc"] = "This will print a msg to your main chat window when you enter an instance with an X icon to delete the new instance from database if you want.";

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