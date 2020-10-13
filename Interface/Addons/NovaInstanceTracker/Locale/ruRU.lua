local L = LibStub("AceLocale-3.0"):NewLocale("NovaInstanceTracker", "ruRU");
if (not L) then
	return;
end

L["noTimer"] = "—"; --No timer (used only in map timer frames)
L["noCurrentTimer"] = "Таймер отсутствует"; --No current timer
L["noActiveTimers"] = "Таймер отсутствует";	--No active timers
L["second"] = "сек"; --Second (singular).
L["seconds"] = "сек"; --Seconds (plural).
L["minute"] = "мин"; --Minute (singular).
L["minutes"] = "мин"; --Minutes (plural).
L["hour"] = "ч"; --Hour (singular).
L["hours"] = "ч"; --Hours (plural).
L["day"] = "д"; --Day (singular).
L["days"] = "д"; --Days (plural).
L["secondShort"] = "с"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "м"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "ч"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "д"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Начнется через %s"; --"Starts in 1hour".
L["endsIn"] = "Закончится через %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Ваша версия аддона Nova Instance Tracker устарела. Пожалуйста, обновите ее по ссылке https://www.curseforge.com/wow/addons/nova-instance-tracker или через Twitch-клиент";
L["Options"] = "Настройки";