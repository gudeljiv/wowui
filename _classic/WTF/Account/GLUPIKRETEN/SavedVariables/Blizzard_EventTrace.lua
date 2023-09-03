
EventTraceSavedVars = {
	["ShowTimestamp"] = true,
	["LogEventsWhenHidden"] = false,
	["ShowArguments"] = true,
	["LogCREvents"] = true,
	["Filters"] = {
		["User"] = {
			{
				["enabled"] = true,
				["event"] = "ACTIONBAR_SLOT_CHANGED",
				["displayEvent"] = "ACTIONBAR_SLOT_CHANGED",
			}, -- [1]
			{
				["enabled"] = true,
				["event"] = "ACTIONBAR_UPDATE_COOLDOWN",
				["displayEvent"] = "ACTIONBAR_UPDATE_COOLDOWN",
			}, -- [2]
			{
				["enabled"] = true,
				["event"] = "ACTIONBAR_UPDATE_STATE",
				["displayEvent"] = "ACTIONBAR_UPDATE_STATE",
			}, -- [3]
			{
				["enabled"] = true,
				["event"] = "ADDON_LOADED",
				["displayEvent"] = "ADDON_LOADED",
			}, -- [4]
			{
				["enabled"] = true,
				["event"] = "BAG_UPDATE_COOLDOWN",
				["displayEvent"] = "BAG_UPDATE_COOLDOWN",
			}, -- [5]
			{
				["enabled"] = true,
				["event"] = "CHAT_MSG_ADDON",
				["displayEvent"] = "CHAT_MSG_ADDON",
			}, -- [6]
			{
				["enabled"] = true,
				["event"] = "CHAT_MSG_CHANNEL",
				["displayEvent"] = "CHAT_MSG_CHANNEL",
			}, -- [7]
			{
				["enabled"] = true,
				["event"] = "CHAT_MSG_MONSTER_SAY",
				["displayEvent"] = "CHAT_MSG_MONSTER_SAY",
			}, -- [8]
			{
				["enabled"] = true,
				["event"] = "CHAT_MSG_SYSTEM",
				["displayEvent"] = "CHAT_MSG_SYSTEM",
			}, -- [9]
			{
				["enabled"] = true,
				["event"] = "CHAT_MSG_TRADESKILLS",
				["displayEvent"] = "CHAT_MSG_TRADESKILLS",
			}, -- [10]
			{
				["enabled"] = true,
				["event"] = "CHAT_MSG_YELL",
				["displayEvent"] = "CHAT_MSG_YELL",
			}, -- [11]
			{
				["enabled"] = true,
				["event"] = "COMBAT_LOG_EVENT_UNFILTERED",
				["displayEvent"] = "COMBAT_LOG_EVENT_UNFILTERED",
			}, -- [12]
			{
				["enabled"] = true,
				["event"] = "COMPANION_UPDATE",
				["displayEvent"] = "COMPANION_UPDATE",
			}, -- [13]
			{
				["enabled"] = true,
				["event"] = "CONSOLE_MESSAGE",
				["displayEvent"] = "CONSOLE_MESSAGE",
			}, -- [14]
			{
				["enabled"] = true,
				["event"] = "CRITERIA_UPDATE",
				["displayEvent"] = "CRITERIA_UPDATE",
			}, -- [15]
			{
				["enabled"] = true,
				["event"] = "CURRENT_SPELL_CAST_CHANGED",
				["displayEvent"] = "CURRENT_SPELL_CAST_CHANGED",
			}, -- [16]
			{
				["enabled"] = true,
				["event"] = "CURSOR_CHANGED",
				["displayEvent"] = "CURSOR_CHANGED",
			}, -- [17]
			{
				["enabled"] = true,
				["event"] = "GET_ITEM_INFO_RECEIVED",
				["displayEvent"] = "GET_ITEM_INFO_RECEIVED",
			}, -- [18]
			{
				["enabled"] = true,
				["event"] = "GLOBAL_MOUSE_DOWN",
				["displayEvent"] = "GLOBAL_MOUSE_DOWN",
			}, -- [19]
			{
				["enabled"] = true,
				["event"] = "GLOBAL_MOUSE_UP",
				["displayEvent"] = "GLOBAL_MOUSE_UP",
			}, -- [20]
			{
				["enabled"] = true,
				["event"] = "GUILD_RANKS_UPDATE",
				["displayEvent"] = "GUILD_RANKS_UPDATE",
			}, -- [21]
			{
				["enabled"] = true,
				["event"] = "GUILD_ROSTER_UPDATE",
				["displayEvent"] = "GUILD_ROSTER_UPDATE",
			}, -- [22]
			{
				["enabled"] = true,
				["event"] = "ITEM_DATA_LOAD_RESULT",
				["displayEvent"] = "ITEM_DATA_LOAD_RESULT",
			}, -- [23]
			{
				["enabled"] = true,
				["event"] = "LFG_LIST_SEARCH_RESULT_UPDATED",
				["displayEvent"] = "LFG_LIST_SEARCH_RESULT_UPDATED",
			}, -- [24]
			{
				["enabled"] = true,
				["event"] = "PLAYER_STARTED_MOVING",
				["displayEvent"] = "PLAYER_STARTED_MOVING",
			}, -- [25]
			{
				["enabled"] = true,
				["event"] = "PLAYER_STARTED_TURNING",
				["displayEvent"] = "PLAYER_STARTED_TURNING",
			}, -- [26]
			{
				["enabled"] = true,
				["event"] = "PLAYER_STOPPED_MOVING",
				["displayEvent"] = "PLAYER_STOPPED_MOVING",
			}, -- [27]
			{
				["enabled"] = true,
				["event"] = "PLAYER_STOPPED_TURNING",
				["displayEvent"] = "PLAYER_STOPPED_TURNING",
			}, -- [28]
			{
				["enabled"] = true,
				["event"] = "SPELL_DATA_LOAD_RESULT",
				["displayEvent"] = "SPELL_DATA_LOAD_RESULT",
			}, -- [29]
			{
				["enabled"] = true,
				["event"] = "SPELL_UPDATE_COOLDOWN",
				["displayEvent"] = "SPELL_UPDATE_COOLDOWN",
			}, -- [30]
			{
				["enabled"] = true,
				["event"] = "SPELL_UPDATE_USABLE",
				["displayEvent"] = "SPELL_UPDATE_USABLE",
			}, -- [31]
			{
				["enabled"] = true,
				["event"] = "UNIT_AURA",
				["displayEvent"] = "UNIT_AURA",
			}, -- [32]
			{
				["enabled"] = true,
				["event"] = "UNIT_HAPPINESS",
				["displayEvent"] = "UNIT_HAPPINESS",
			}, -- [33]
			{
				["enabled"] = true,
				["event"] = "UNIT_HEALTH",
				["displayEvent"] = "UNIT_HEALTH",
			}, -- [34]
			{
				["enabled"] = true,
				["event"] = "UNIT_HEALTH_FREQUENT",
				["displayEvent"] = "UNIT_HEALTH_FREQUENT",
			}, -- [35]
			{
				["enabled"] = true,
				["event"] = "UNIT_POWER_FREQUENT",
				["displayEvent"] = "UNIT_POWER_FREQUENT",
			}, -- [36]
			{
				["enabled"] = true,
				["event"] = "UNIT_POWER_UPDATE",
				["displayEvent"] = "UNIT_POWER_UPDATE",
			}, -- [37]
			{
				["enabled"] = true,
				["event"] = "UPDATE_EXHAUSTION",
				["displayEvent"] = "UPDATE_EXHAUSTION",
			}, -- [38]
			{
				["enabled"] = true,
				["event"] = "UPDATE_INVENTORY_DURABILITY",
				["displayEvent"] = "UPDATE_INVENTORY_DURABILITY",
			}, -- [39]
			{
				["enabled"] = true,
				["event"] = "UPDATE_MOUSEOVER_UNIT",
				["displayEvent"] = "UPDATE_MOUSEOVER_UNIT",
			}, -- [40]
			{
				["enabled"] = true,
				["event"] = "UPDATE_SHAPESHIFT_FORM",
				["displayEvent"] = "UPDATE_SHAPESHIFT_FORM",
			}, -- [41]
		},
	},
	["Size"] = {
		["Height"] = 824.82177734375,
		["Width"] = 734.8216552734375,
	},
}
