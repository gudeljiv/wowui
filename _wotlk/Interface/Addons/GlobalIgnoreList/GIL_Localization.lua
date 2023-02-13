local _, L   = ...
local locale = GetLocale()

local function badString (L, key)
	return "BAD TEXT \"".. (key or "NIL") .. "\""
end

setmetatable (L, {__index=badString})

-- ENGLISH DEFAULTS

L["ON"]		= "ON"
L["OFF"]	= "OFF"
L["DAY"]	= "day"
L["DAYS"]	= "days"
L["EXP_NVR"]	= "Never"
L["EXP_TDY"]	= "Today"
L["LIST_1"]	= "Characters on ignore for %d or more days:"
L["LIST_2"]	= "All ignored NPC characters:"
L["LIST_3"]	= "All ignored players on server %s:"
L["LIST_4"]	= "All characters on global ignore:"
L["LIST_5"]	= "Listed %d character(s)"
L["SYNC_1"]	= "Removing %s from character's ignore list"
L["SYNC_2"]	= "Adding %s to character's ignore list"
L["LOAD_1"]	= "Type /gignore or /gi for help and options"
L["LOAD_2"]	= "New character found: Importing ignored players"
L["LOAD_3"]	= "Adding %s to global ignore list"
L["LOAD_4"] = "Synchronizing Ignore list..."
L["LOAD_5"] = "WARNING: Synchronization could not be preformed at this time because there were |cffffff00%s|cffffffff player(s) on Blizzard's ignore list reported as \"%s\". If synchronization continues to fail, the unknown player may need to be manually removed from Blizzard ignore list.  The list will try to synchronize the next time the GUI is opened, or by typing /gi sync in chat."
L["RCM_1"]	= "Edit note"
L["RCM_2"]	= "Set Expiration"
L["RCM_3"]	= "Reset Expiration"
L["RCM_4"]	= "Remove from Ignore"
L["RCM_5"]	= "Cancel"
L["RCM_6"]  = "Add to Ignore"
L["OVER_1"]	= "Realm:"
L["OVER_2"]	= "Faction:"
L["OVER_3"]	= "Ignored:"
L["OVER_4"]	= "Expires:"
L["OVER_5"]	= "After %d day(s) (%d day(s) from today)"
L["ADD_1"]	= "%s is already ignored"
L["ADD_2"]	= "%s added to global ignore"
L["ADD_3"]	= "You cannot ignore yourself, silly!"
L["ADD_4"]	= "Cannot ignore player due to Blizzard bug. Try ignoring again"
L["REM_1"]	= "%s removed from global ignore"
L["BOX_1"]	= "Remove after how many days on the list?\n(Use 0 to disable expiration)"
L["BOX_2"]	= "Are you sure you wish to reset to the latest default spam filters?  You will lose all custom filters!"
L["BOX_3"]	= "Save"
L["BOX_4"]	= "Reset"
L["BOX_5"]	= "Cancel"
L["BOX_6"]  = "Accept"
L["BOX_7"]  = "|cffffff00INVITE WARNING: %s\n\n|cffffffffThis player is on your Global Ignore List.  Do you still want to invite them?\n"
L["BOX_8"]  = "|cffffff00PARTY WARNING\n\n|cffffffffThere are |cffffff00%d |cffffffffplayer(s) on your ignore list in group:\n|cff69CCF0%s\n"
L["BOX_9"]	= "Are you sure wish to remove the selected filter?"
L["BOX_10"] = "Remove"
L["CMD_1"]	= "WARNING: You will remove all ignores on all characters on all servers. Type \"/gi clear confirm\" to clear the list"
L["CMD_2"]	= "Database cleared"
L["CMD_3"]	= "Newly ignored players will now be automatically removed after |cffffff00%d|cffffffff %s.  Existing ignored players will be unaffected.  If you want to disable auto expire, set this value to zero (0)."
L["CMD_4"]	= "Asking for ignore note when a player is ignored is now |cffffff00on"
L["CMD_5"]	= "Asking for ignore note when a player is ignored is now |cffffff00off"
L["CMD_6"]	= "Synchronization messages are now |cffffff00on"
L["CMD_7"]	= "Synchronization messages are now |cffffff00off"
L["CMD_8"]	= "UNUSED"
L["CMD_9"]	= "UNUSED"
L["CMD_10"]	= "Only sync same server characters is now |cffffff00on"
L["CMD_11"]	= "Only sync same server characters is now |cffffff00off"
L["CMD_12"]	= "|cffffff00%s|cffffffff has been removed from NPC ignore list"
L["CMD_13"]	= "|cffffff00%s|cffffffff has been added to NPC ignore list"
L["CMD_14"]	= "%s will be automatically removed after %d days."
L["CMD_15"]	= "Invalid command please double check what you've typed"
L["CMD_16"]	= "Remove players that have been ignored for |cffffff00%d|cffffffff or more days"
L["CMD_17"]	= "Type |cffffff00/gi prune confirm|cffffffff to prune |cffffff00%d|cffffffff players"
L["CMD_18"]	= "|cffffff00%s|cffffffff added to server ignore list"
L["CMD_19"]	= "|cffffff00%s|cffffffff removed from server ignore list"
L["HELP_1"]	= "|cffff99ffTYPE: |cffffffff/gi [command], where [command] is one of:"
L["HELP_2"]	= "|cffffff00list|cffffffff: List all players on global ignore list"
L["HELP_3"]	= "|cffffff00clear|cffffffff: Clear all names from global ignore list"
L["HELP_4"]	= "|cffffff00add player|cffffffff: Add [player] to ignore list"
L["HELP_5"]	= "|cffffff00remove player|cffffffff: Remove [player] from ignore list"
L["HELP_6"]	= "|cffffff00expire player days|cffffffff: Remove [player] from list after [days]"
L["HELP_7"]	= "|cffffff00prune days|cffffffff: Remove those on list for [days] or more days"
L["HELP_8"]	= "|cffffff00npc npcname|cffffffff: Add or remove an NPC character ignore"
L["HELP_9"]	= "|cffffff00sync|cffffffff: Synchronize ignore list"
L["HELP_10"]	= "|cffffff00showmsg on|off|cffffffff: Show actions during synchronization (%s)"
L["HELP_11"]	= "|cffffff00sameserver on|off|cffffffff: Only add same-server characters to account wide ignore (%s)"
L["HELP_12"]	= "|cffffff00defexpire days|cffffffff: Newly ignored players auto expire after (|cffffff00%d|cffffffff) days"
L["HELP_13"]	= "|cffffff00asknote on|off|cffffffff: Ask for ignore note on ignore (%s)"
L["HELP_14"]	= "|cffff99ffNOTE: |cffffffffUse /ignore, and UI as usual to add/remove players!"
L["HELP_15"]	= "|cffffff00server servername|cffffffff: Add or remove an entire server ignore"
L["HELP_16"]	= "|cffffff00gui|cffffffff: Open GIL user interface"
L["CHAT_1"]	= "WARNING: There are %d ignored player(s) in this group: |cffffff00%s"
L["MSG_1"]	= "[Global Ignore List] You are being ignored."
L["COL_1"]	= "Player Name"
L["COL_2"]	= "Server Name"
L["COL_3"]	= "Type"
L["COL_4"]	= "Listed"
L["COL_5"]	= "Expires"
L["COL_6"]	= "Note"
L["COL_7"]	= "Alts"
L["COL_8"]	= "Active"
L["COL_9"]	= "Description"
L["COL_10"]	= "Filter"
L["BUT_1"]	= "Remove Ignore"
L["BUT_2"]	= "Ignore Player"
L["BUT_3"]	= "Ignore NPC"
L["BUT_4"]	= "Ignore Server"
L["BUT_5"]	= "Create Filter"
L["BUT_6"]	= "Remove Filter"
L["BUT_7"]	= "Reset Defaults"
L["TAB_1"]	= "Ignore List"
L["TAB_2"]	= "Spam Filters"
L["TAB_3"]	= "Options"
L["INFO_1"]	= "%d entries in list"
L["INFO_2"]	= "Your spam filters have blocked a total of |cffffff00%d|cffffffff spammers"
L["INFO_3"]	= "This filter has blocked |cffffff00%d|cffffffff spammers"
L["OPT_1"]	= "Ask for note after adding a new ignore"
L["OPT_2"]	= "Open Global Ignore UI with Blizzard Friends/Ignore UI"
L["OPT_3"]	= "UNUSED"
L["OPT_4"]	= "Only add same server players to account-wide ignore (highly recommended on)"
L["OPT_5"]	= "Default expiration days for newly added ignores (Use 0 for never)"
L["OPT_6"]	= "Attempt to track character name changes and deleted characters (account wide ignore only)"
L["OPT_7"]	= "Enable chat spam filtering"
L["OPT_8"]	= "Ignore List Options:"
L["OPT_9"]	= "Spam Filtering Options:"
L["OPT_10"]	= "Perform reverse spam filtering (not recommended)"
L["OPT_11"] = "Automatically update default Spam Filters"
L["OPT_12"] = "Never filter Guild chat"
L["OPT_13"] = "Never filter Party/Group chat"
L["OPT_14"] = "Never filter private chat"
L["TIP_1"]  = "|cffffffffFilter Editing Help\n\n|cffffff00Enter chat filter in the box below.  Chat text is converted to lower cased letters before\napplying filters, so all filters must be defined using lower cased letters only.\n\nAny links entered into the edit box will be automatically converted to the appropriate\nfilter tag.\n\nPlease view the website for more detailed information on creating chat filters."
L["TIP_2"]  = "|cffffffffFilter Testing Help\n\n|cffffff00Enter chat text into the Filter Testing box and GIL will apply the current filter\nto the contents in the box whenever the Test button is clicked.\n\nThe result of the applied filter is shown as BLOCKED if the text would be\nfiltered, or PASSED if the text would not be filtered."

-- GERMAN
if locale == "deDE" then
end

-- PORTUGUESE
if locale == "ptBR" then
end

-- FRENCH
if locale == "frFR" then
end

-- RUSSIAN
if locale == "ruRU" then
end

-- SPANISH (SPAIN AND MEXICO)
if (locale == "esES") or (locale == "esMX") then
end

-- CHINESE (CHINA)
if locale == "zhCN" then
end

-- CHINESE (TAIWAN)
if locale == "zhTW" then
end

-- KOREAN
if locale == "koKR" then
end

-- ITALIAN
if locale == "itIT" then
end
