local L = LibStub("AceLocale-3.0"):NewLocale("NovaInstanceTracker", "itIT");
if (not L) then
	return;
end

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
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "d"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Starts in %s"; --"Starts in 1hour".
L["endsIn"] = "Ends in %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova Instance Tracker is out of date, please update at https://www.curseforge.com/wow/addons/nova-instance-tracker";
L["Options"] = "Options";
L["Reset Data"] = "Reset Data"; --A button to Reset data.