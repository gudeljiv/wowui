local L = LibStub("AceLocale-3.0"):NewLocale("NovaInstanceTracker", "zhCN");
if (not L) then
	return;
end

L["noTimer"] = "没有计时"; --No timer
L["noCurrentTimer"] = "没有当前计时"; --No current timer
L["noActiveTimers"] = "没有激活计时"; --No active timers
L["second"] = "秒"; --Second (singular).
L["seconds"] = "秒"; --Seconds (plural).
L["minute"] = "分"; --Minute (singular).
L["minutes"] = "分"; --Minutes (plural).
L["hour"] = "小时"; --Hour (singular).
L["hours"] = "小时"; --Hours (plural).
L["day"] = "天"; --Day (singular).
L["days"] = "天"; --Days (plural).
L["secondShort"] = "秒"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "分"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "小时"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "天"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "将于 %s 后开始"; --"Starts in 1hour".
L["endsIn"] = "将于 %s 后结束"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova Instance Tracker 插件已过期,请前往 https://www.curseforge.com/wow/addons/nova-instance-tracker 或在 twitch 上更新.";
L["Options"] = "设置";