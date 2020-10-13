local L = LibStub("AceLocale-3.0"):NewLocale("NovaInstanceTracker", "frFR");
if (not L) then
	return;
end

L["noTimer"] = "--"; --No timer (used only in map timer frames)
L["noCurrentTimer"] = "Actuellement pas de timer"; --No current timer
L["noActiveTimers"] = "Pas de timer actif";	--No active timers
L["second"] = "seconde"; --Second (singular).
L["seconds"] = "secondes"; --Seconds (plural).
L["minute"] = "minute"; --Minute (singular).
L["minutes"] = "minutes"; --Minutes (plural).
L["hour"] = "heure"; --Hour (singular).
L["hours"] = "heures"; --Hours (plural).
L["day"] = "jour"; --Day (singular).
L["days"] = "jours"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "j"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Commence dans %s"; --"Starts in 1hour".
L["endsIn"] = "Fini dans %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Votre addon Nova Instance Tracker n'est plus à jour, mettez le à jour sur https://www.curseforge.com/wow/addons/nova-instance-tracker ou via l'app twitch";
L["Options"] = "Options";
L["Reset Data"] = "Reset Data"; --A button to Reset data.