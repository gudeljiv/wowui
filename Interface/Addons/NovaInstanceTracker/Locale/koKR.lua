local L = LibStub("AceLocale-3.0"):NewLocale("NovaInstanceTracker", "koKR");
if (not L) then
    return;
end
 
L["noTimer"] = "기록 없음"; --No timer
L["noCurrentTimer"] = "현재 기록 없음"; --No current timer
L["noActiveTimers"] = "활성화된 기록 없음"; --No active timers
L["second"] = "초"; --Second (singular).
L["seconds"] = "초"; --Seconds (plural).
L["minute"] = "분"; --Minute (singular).
L["minutes"] = "분"; --Minutes (plural).
L["hour"] = "시간"; --Hour (singular).
L["hours"] = "시간"; --Hours (plural).
L["day"] = "일"; --Day (singular).
L["days"] = "일"; --Days (plural).
L["secondShort"] = "초"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "분"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "시간"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "일"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "%s 이후 개최"; --"Starts in 1hour".
L["endsIn"] = "%s 이후 종료"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova Instance Tracker 애드온을 트위치나 URL을 통해 업데이트 해주세요. https://www.curseforge.com/wow/addons/nova-instance-tracker";
L["Options"] = "Options";
L["Reset Data"] = "Reset Data"; --A button to Reset data.