-------------------------
--Nova Instance Tracker--
-------------------------
--https://www.curseforge.com/members/venomisto/projects

local L = LibStub("AceLocale-3.0"):GetLocale("NovaInstanceTracker");
local maxRecordsKept = 300;
local maxTradesKept = 1000;
NIT.maxRecordsShown = 300;

NIT.options = {
	name =  "",
	handler = NIT,
	type = 'group',
	args = {
		titleText = {
			type = "description",
			name = "        " .. NIT.prefixColor .. "NovaInstanceTracker (v" .. GetAddOnMetadata("NovaInstanceTracker", "Version") .. ")",
			fontSize = "large",
			order = 1,
		},
		authorText = {
			type = "description",
			name = "|TInterface\\AddOns\\NovaInstanceTracker\\Media\\nitLogo32:32:32:0:20|t |cFF9CD6DEby Novaspark-Arugal|r  |cFF00C800-|r  |cFFFFFF00For help or suggestions discord.gg/RTKMfTmkdj|r",
			fontSize = "medium",
			order = 2,
		},
		resetAllInstances = {
			type = "execute",
			name = L["resetAllInstancesTitle"];
			desc = L["resetAllInstancesDesc"],
			func = function()
				NIT:resetAllInstances();
			end,
			order = 3,
			confirm = function()
				return "|cFFFFFF00" .. L["resetAllInstancesConfirm"];
			end,
		},
		autoDialogue = {
			type = "header",
			name = L["autoDialogueDesc"],
			order = 23,
		},
		autoSlavePens = {
			type = "toggle",
			name = L["autoSlavePensTitle"],
			desc = L["autoSlavePensDesc"],
			order = 24,
			get = "getAutoSlavePens",
			set = "setAutoSlavePens",
		},
		autoCavernsFlight = {
			type = "toggle",
			name = L["autoCavernsFlightTitle"],
			desc = L["autoCavernsFlightDesc"],
			order = 25,
			get = "getAutoCavernsFlight",
			set = "setAutoCavernsFlight",
		},
		autoCavernsArthas = {
			type = "toggle",
			name = L["autoCavernsArthasTitle"],
			desc = L["autoCavernsArthasDesc"],
			order = 26,
			get = "getAutoCavernsArthas",
			set = "setAutoCavernsArthas",
		},
		autoBlackMorass = {
			type = "toggle",
			name = L["autoBlackMorassTitle"],
			desc = L["autoBlackMorassDesc"],
			order = 27,
			get = "getAutoBlackMorass",
			set = "setAutoBlackMorass",
		},
		autoSfkDoor = {
			type = "toggle",
			name = L["autoSfkDoorTitle"],
			desc = L["autoSfkDoorDesc"],
			order = 27,
			get = "getAutoSfkDoor",
			set = "setAutoSfkDoor",
		},
		colorsHeader = {
			type = "header",
			name = L["colorsHeaderDesc"],
			order = 28,
		},
		chatColor = {
			type = "color",
			name = L["chatColorTitle"],
			desc = L["chatColorDesc"],
			order = 29,
			get = "getChatColor",
			set = "setChatColor",
			hasAlpha = false,
		},
		mergeColor = {
			type = "color",
			name = L["mergeColorTitle"],
			desc = L["mergeColorDesc"],
			order = 30,
			get = "getMergeColor",
			--get = function()
			--	return 0, 255, 0;
			--end,
			set = "setMergeColor",
			hasAlpha = false,
		},
		resetColors = {
			type = "execute",
			name = L["resetColorsTitle"],
			desc = L["resetColorsDesc"],
			func = "resetColors",
			order = 31,
		},
		generalHeader = {
			type = "header",
			name = L["generalHeaderDesc"],
			order = 32,
		},
		enteredMsg = {
			type = "toggle",
			name = L["enteredMsgTitle"],
			desc = L["enteredMsgDesc"],
			order = 233,
			get = "getEnteredMsg",
			set = "setEnteredMsg",
		},
		raidEnteredMsg = {
			type = "toggle",
			name = L["raidEnteredMsgTitle"],
			desc = L["raidEnteredMsgDesc"],
			order = 34,
			get = "getRaidEnteredMsg",
			set = "setRaidEnteredMsg",
		},
		pvpEnteredMsg = {
			type = "toggle",
			name = L["pvpEnteredMsgTitle"],
			desc = L["pvpEnteredMsgDesc"],
			order = 35,
			get = "getPvpEnteredMsg",
			set = "setPvpEnteredMsg",
		},
		noRaidInstanceMergeMsg = {
			type = "toggle",
			name = L["noRaidInstanceMergeMsgTitle"],
			desc = L["noRaidInstanceMergeMsgDesc"],
			order = 36,
			get = "getNoRaidInstanceMergeMsg",
			set = "setNoRaidInstanceMergeMsg",
		},
		instanceResetMsg = {
			type = "toggle",
			name = L["instanceResetMsgTitle"],
			desc = L["instanceResetMsgDesc"],
			order = 37,
			get = "getInstanceResetMsg",
			set = "setInstanceResetMsg",
		},
		minimapButton = {
			type = "toggle",
			name = L["minimapButtonTitle"],
			desc = L["minimapButtonDesc"],
			order = 36,
			get = "getMinimapButton",
			set = "setMinimapButton",
		},
		--[[ignore40Man = { --This shouldn't be an option really, it needs to be tested if 40mans count towards lockout and hardcoded.
			type = "toggle",
			name = L["ignore40ManTitle"],
			desc = L["ignore40ManDesc"],
			order = 31,
			get = "getIgnore40Man",
			set = "setIgnore40Man",
		},]]
		showMoneyTradedChat = {
			type = "toggle",
			name = L["showMoneyTradedChatTitle"],
			desc = L["showMoneyTradedChatDesc"],
			order = 38,
			get = "getShowMoneyTradedChat",
			set = "setShowMoneyTradedChat",
		},
		timeStampFormat = {
			type = "select",
			name = L["timeStampFormatTitle"],
			desc = L["timeStampFormatDesc"],
			values = {
				[12] = L["12 hour"],
				[24] = L["24 hour"],
			},
			sorting = {
				[1] = 12,
				[2] = 24,
			},
			order = 39,
			get = "getTimeStampFormat",
			set = "setTimeStampFormat",
		},
		timeStampZone = {
			type = "select",
			name = L["timeStampZoneTitle"],
			desc = L["timeStampZoneDesc"],
			values = {
				["local"] = L["Local Time"],
				["server"] = L["Server Time"],
			},
			sorting = {
				[1] = "local",
				[2] = "server",
			},
			order = 40,
			get = "getTimeStampZone",
			set = "setTimeStampZone",
		},
		instanceWindowWidth = {
			type = "range",
			name = L["instanceWindowWidthTitle"],
			desc = L["instanceWindowWidthDesc"],
			order = 41,
			get = "getInstanceWindowWidth",
			set = "setInstanceWindowWidth",
			min = 575,
			max = 900,
			softMin = 575,
			softMax = 900,
			step = 1,
			width = 1.5,
		},
		instanceWindowHeight = {
			type = "range",
			name = L["instanceWindowHeightTitle"],
			desc = L["instanceWindowHeightDesc"],
			order = 42,
			get = "getInstanceWindowHeight",
			set = "setInstanceWindowHeight",
			min = 150,
			max = 1200,
			softMin = 150,
			softMax = 1200,
			step = 1,
			width = 1.5,
		},
		charsWindowWidth = {
			type = "range",
			name = L["charsWindowWidthTitle"],
			desc = L["charsWindowWidthDesc"],
			order = 43,
			get = "getCharsWindowWidth",
			set = "setCharsWindowWidth",
			min = 350,
			max = 900,
			softMin = 350,
			softMax = 900,
			step = 1,
			width = 1.5,
		},
		charsWindowHeight = {
			type = "range",
			name = L["charsWindowHeightTitle"],
			desc = L["charsWindowHeightDesc"],
			order = 44,
			get = "getCharsWindowHeight",
			set = "setCharsWindowHeight",
			min = 150,
			max = 950,
			softMin = 150,
			softMax = 950,
			step = 1,
			width = 1.5,
		},
		tradeWindowWidth = {
			type = "range",
			name = L["tradeWindowWidthTitle"],
			desc = L["tradeWindowWidthDesc"],
			order = 45,
			get = "getTradeWindowWidth",
			set = "setTradeWindowWidth",
			min = 350,
			max = 900,
			softMin = 350,
			softMax = 900,
			step = 1,
			width = 1.5,
		},
		tradeWindowHeight = {
			type = "range",
			name = L["tradeWindowHeightTitle"],
			desc = L["tradeWindowHeightDesc"],
			order = 46,
			get = "getTradeWindowHeight",
			set = "setTradeWindowHeight",
			min = 150,
			max = 950,
			softMin = 150,
			softMax = 950,
			step = 1,
			width = 1.5,
		},
		resetFrames = {
			type = "execute",
			name = L["resetFramesTitle"],
			desc = L["resetFramesDesc"],
			func = "resetFrames",
			order = 47,
		},
		detectSameInstance = {
			type = "toggle",
			name = L["detectSameInstanceTitle"],
			desc = L["detectSameInstanceDesc"],
			order = 48,
			get = "getDetectSameInstance",
			set = "setDetectSameInstance",
		},
		logHeader = {
			type = "header",
			name = L["logHeaderDesc"],
			order = 50,
		},
		logTextExample = {
			type = "description",
			name = function()
				return NIT:getLogExample();
			end,
			fontSize = "medium",
			order = 51,
		},
		openInstanceLogFrame = {
			type = "execute",
			name = L["openInstanceLogFrameTitle"],
			func = "openInstanceLogFrame",
			order = 55,
		},
		logSize = {
			type = "range",
			name = L["logSizeTitle"],
			desc = L["logSizeDesc"],
			order = 56,
			get = "getLogSize",
			set = "setLogSize",
			min = 1,
			max = NIT.maxRecordsShown,
			softMin = 1,
			softMax = NIT.maxRecordsShown,
			step = 1,
			width = "double",
		},
		showAltsLog = {
			type = "toggle",
			name = L["showAltsLogTitle"],
			desc = L["showAltsLogDesc"],
			order = 57,
			get = "getShowAltsLog",
			set = "setShowAltsLog",
		},
		showLockoutTime = {
			type = "toggle",
			name = L["showLockoutTimeTitle"],
			desc = L["showLockoutTimeDesc"],
			order = 58,
			get = "getShowLockoutTime",
			set = "setShowLockoutTime",
		},
		show24HourOnly = {
			type = "toggle",
			name = L["show24HourOnlyTitle"],
			desc = L["show24HourOnlyDesc"],
			order = 59,
			get = "getShow24HourOnly",
			set = "setShow24HourOnly",
		},
		timeStringType = {
			type = "select",
			name = L["timeStringTypeTitle"],
			desc = L["timeStringTypeDesc"],
			values = {
				["long"] = L["Long"],
				["medium"] = L["Medium"],
				["short"] = L["Short"],
			},
			sorting = {
				[1] = "long",
				[2] = "medium",
				[3] = "short",
			},
			order = 60,
			get = "getTimeStringType",
			set = "setTimeStringType",
		},
		instanceStatsHeader = {
			type = "header",
			name = L["instanceStatsHeaderDesc"],
			order = 70,
		},
		instanceStatsText = {
			type = "description",
			name = "|cFFFFFF00" .. L["instanceStatsTextDesc"],
			fontSize = "medium",
			order = 71,
		},
		instanceStatsOutput = {
			type = "toggle",
			name = L["instanceStatsOutputTitle"],
			desc = L["instanceStatsOutputDesc"],
			order = 72,
			get = "getInstanceStatsOutput",
			set = "setInstanceStatsOutput",
		},
		instanceStatsOutputWhere = {
			type = "select",
			name = L["instanceStatsOutputWhereTitle"],
			desc = L["instanceStatsOutputWhereDesc"],
			values = {
				["self"] = L["Chat Window"],
				["group"] = L["Group Chat (Party/Raid)"],
			},
			sorting = {
				[1] = "self",
				[2] = "group",
			},
			order = 73,
			width = "double",
			get = "getInstanceStatsOutputWhere",
			set = "setInstanceStatsOutputWhere",
		},
		instanceStatsOutputMobCount = {
			type = "toggle",
			name = L["instanceStatsOutputMobCountTitle"],
			desc = L["instanceStatsOutputMobCountDesc"],
			order = 75,
			get = "getInstanceStatsOutputMobCount",
			set = "setInstanceStatsOutputMobCount",
		},
		instanceStatsOutputXP = {
			type = "toggle",
			name = L["instanceStatsOutputXPTitle"],
			desc = L["instanceStatsOutputXPDesc"],
			order = 76,
			get = "getInstanceStatsOutputXP",
			set = "setInstanceStatsOutputXP",
		},
		instanceStatsOutputXpPerHour = {
			type = "toggle",
			name = L["instanceStatsOutputXpPerHourTitle"],
			desc = L["instanceStatsOutputXpPerHourDesc"],
			order = 77,
			get = "getInstanceStatsOutputXpPerHour",
			set = "setInstanceStatsOutputXpPerHour",
		},
		instanceStatsOutputAverageXP = {
			type = "toggle",
			name = L["instanceStatsOutputAverageXPTitle"],
			desc = L["instanceStatsOutputAverageXPDesc"],
			order = 78,
			get = "getInstanceStatsOutputAverageXP",
			set = "setInstanceStatsOutputAverageXP",
		},
		instanceStatsOutputTime = {
			type = "toggle",
			name = L["instanceStatsOutputTimeTitle"],
			desc = L["instanceStatsOutputTimeDesc"],
			order = 79,
			get = "getInstanceStatsOutputTime",
			set = "setInstanceStatsOutputTime",
		},
		instanceStatsOutputGold = {
			type = "toggle",
			name = L["instanceStatsOutputGoldTitle"],
			desc = L["instanceStatsOutputGoldDesc"],
			order = 80,
			get = "getInstanceStatsOutputGold",
			set = "setInstanceStatsOutputGold",
		},
		instanceStatsOutputAverageGroupLevel = {
			type = "toggle",
			name = L["instanceStatsOutputAverageGroupLevelTitle"],
			desc = L["instanceStatsOutputAverageGroupLevelDesc"],
			order = 81,
			get = "getInstanceStatsOutputAverageGroupLevel",
			set = "setInstanceStatsOutputAverageGroupLevel",
		},
		showStatsInRaid = {
			type = "toggle",
			name = L["showStatsInRaidTitle"],
			desc = L["showStatsInRaidDesc"],
			order = 82,
			get = "getShowStatsInRaid",
			set = "setShowStatsInRaid",
		},
		printRaidInstead = {
			type = "toggle",
			name = L["printRaidInsteadTitle"],
			desc = L["printRaidInsteadDesc"],
			order = 83,
			get = "getPrintRaidInstead",
			set = "setPrintRaidInstead",
		},
		statsOnlyWhenActivity = {
			type = "toggle",
			name = L["statsOnlyWhenActivityTitle"],
			desc = L["statsOnlyWhenActivityDesc"],
			order = 84,
			get = "getStatsOnlyWhenActivity",
			set = "setStatsOnlyWhenActivity",
		},
		instanceStatsOutputRunsPerLevel = {
			type = "toggle",
			name = L["instanceStatsOutputRunsPerLevelTitle"],
			desc = L["instanceStatsOutputRunsPerLevelDesc"],
			order = 85,
			get = "getInstanceStatsOutputRunsPerLevel",
			set = "setInstanceStatsOutputRunsPerLevel",
		},
		instanceStatsOutputRunsNextLevel = {
			type = "toggle",
			name = L["instanceStatsOutputRunsNextLevelTitle"],
			desc = L["instanceStatsOutputRunsNextLevelDesc"],
			order = 86,
			get = "getInstanceStatsOutputRunsNextLevel",
			set = "setInstanceStatsOutputRunsNextLevel",
		},
		instanceStatsOutputRep = {
			type = "toggle",
			name = L["instanceStatsOutputRepTitle"],
			desc = L["instanceStatsOutputRepDesc"],
			order = 87,
			get = "getInstanceStatsOutputRep",
			set = "setInstanceStatsOutputRep",
		},
		instanceStatsOutputHK = {
			type = "toggle",
			name = L["instanceStatsOutputHKTitle"],
			desc = L["instanceStatsOutputHKDesc"],
			order = 88,
			get = "getInstanceStatsOutputHK",
			set = "setInstanceStatsOutputHK",
		},
		instanceStatsOutputCurrency = {
			type = "toggle",
			name = L["instanceStatsOutputCurrencyTitle"],
			desc = L["instanceStatsOutputCurrencyDesc"],
			order = 89,
			get = "getInstanceStatsOutputCurrency",
			set = "setInstanceStatsOutputCurrency",
		},
		trimDataHeader = {
			type = "header",
			name = L["trimDataHeaderDesc"],
			order = 330,
		},
		trimDataText = {
			type = "description",
			name = "|cFF9CD6DE".. L["trimDataTextDesc"],
			fontSize = "medium",
			order = 331,
		},
		trimDataBelowLevel = {
			type = "range",
			name = L["trimDataBelowLevelTitle"],
			desc = L["trimDataBelowLevelDesc"],
			order = 332,
			get = "getTrimDataBelowLevel",
			set = "setTrimDataBelowLevel",
			min = 1,
			max = 60,
			softMin = 1,
			softMax = 60,
			step = 1,
			width = "double",
		},
		trimDataBelowLevelButton = {
			type = "execute",
			name = L["trimDataBelowLevelButtonTitle"],
			desc = L["trimDataBelowLevelButtonDesc"],
			func = "removeCharsBelowLevel",
			order = 333,
			--width = 1.7,
			confirm = function()
				return string.format(L["trimDataBelowLevelButtonConfirm"], "|cFFFFFF00" .. NIT.db.global.trimDataBelowLevel .. "|r");
			end,
		},
		--[[trimDataText2 = {
			type = "description",
			name = "|cFF9CD6DE".. L["trimDataText2Desc"],
			fontSize = "medium",
			order = 334,
		},
		trimDataCharInput = {
			type = "input",
			name = L["trimDataCharInputTitle"],
			desc = L["trimDataCharInputDesc"],
			get = "getTrimDataCharInput",
			set = "setTrimDataCharInput",
			order = 335,
			--width = 1.7,
			confirm = function(self, input)
				return string.format(L["trimDataCharInputConfirm"], "|cFFFFFF00" .. input .. "|r");
			end,
		},]]
		notesHeader = {
			type = "header",
			name = L["notesHeaderDesc"],
			order = 998,
		},
		notesDesc = {
			type = "description",
			name = "|cFFFFFF00" .. L["notesDesc"],
			fontSize = "medium",
			order = 999,
		},
	},
};

function NIT:loadSpecificOptions()
	if (NIT.expansionNum > 2) then
		NIT.options.args["autoGammaBuffHeader"] = {
			type = "header",
			name = L["autoGammaBuffDesc"],
			order = 4,
		};
		NIT.options.args["autoGammaBuff"] = {
			type = "toggle",
			name = L["autoGammaBuffTitle"],
			desc = L["autoGammaBuffDesc"],
			order = 5,
			get = "getAutoGammaBuff",
			set = "setAutoGammaBuff",
		};
		NIT.options.args["autoGammaBuffReminder"] = {
			type = "toggle",
			name = L["autoGammaBuffReminderTitle"],
			desc = L["autoGammaBuffReminderDesc"],
			order = 6,
			get = "getAutoGammaBuffReminder",
			set = "setAutoGammaBuffReminder",
		};
		NIT.options.args["dungeonPopTimer"] = {
			type = "toggle",
			name = L["dungeonPopTimerTitle"],
			desc = L["dungeonPopTimerDesc"],
			order = 7,
			get = "getDungeonPopTimer",
			set = "setDungeonPopTimer",
		};
		NIT.options.args["autoGammaBuffType"] = {
			type = "select",
			name = L["autoGammaBuffTypeTitle"],
			desc = L["autoGammaBuffTypeDesc"],
			values = {
				[1] = "Auto Select (Spec Based)",
				[2] = MELEE,
				[3] = RANGED,
				[4] = HEALER,
				[5] = TANK,
			},
			sorting = {
				[1] = 1,
				[2] = 2,
				[3] = 3,
				[4] = 4,
				[5] = 5,
			},
			order = 8,
			width = 1.7,
			get = "getAutoGammaBuffType",
			set = "setAutoGammaBuffType",
		};
		NIT.options.args["autoGammaText"] = {
			type = "description",
			name = "|cFFFF0000" .. L["note"] .. " |cFF9CD6DE" .. L["gammaConfigWarning"],
			fontSize = "medium",
			order = 9,
		};
		NIT.options.args["autoWrathDailies"] = {
			type = "toggle",
			name = L["autoWrathDailiesTitle"],
			desc = L["autoWrathDailiesDesc"],
			order = 10,
			get = "getAutoWrathDailies",
			set = "setAutoWrathDailies",
		};
	end
	if (NIT.isSOD) then
		NIT.options.args["lootReminder"] = {
			type = "header",
			name = L["lootReminderDesc"],
			order = 15,
		};
		NIT.options.args["lootReminderReal"] = {
			type = "toggle",
			name = L["lootReminderRealTitle"],
			desc = L["lootReminderRealDesc"],
			order = 16,
			get = "getLootReminderReal",
			set = "setLootReminderReal",
			width = 1.5,
		};
		NIT.options.args["lootReminderSize"] = {
			type = "range",
			name = L["lootReminderSizeTitle"],
			desc = L["lootReminderSizeDesc"],
			order = 17,
			get = "getLootReminderSize",
			set = "setLootReminderSize",
			min = 10,
			max = 100,
			softMin = 10,
			softMax = 100,
			step = 1,
			width = 1,
		};
		NIT.options.args["lootReminderX"] = {
			type = "range",
			name = L["lootReminderXTitle"],
			desc = L["lootReminderXDesc"],
			order = 18,
			get = "getLootReminderX",
			set = "setLootReminderX",
			min = -1000,
			max = 1000,
			softMin = -1000,
			softMax = 1000,
			step = 1,
			width = 1.5,
		};
		NIT.options.args["lootReminderY"] = {
			type = "range",
			name = L["lootReminderYTitle"],
			desc = L["lootReminderYDesc"],
			order = 19,
			get = "getLootReminderY",
			set = "setLootReminderY",
			min = -1000,
			max = 1000,
			softMin = -1000,
			softMax = 1000,
			step = 1,
			width = 1.5,
		};
	end
end
		
		
function NIT:getLogExample()
	--Simulate a log entry.
	local classLocalized, classEnglish = UnitClass("player");
	local v = {
		playerName = UnitName("player"),
		classEnglish = classEnglish,
		instanceName = L["Test Instance"],
		enteredTime = GetServerTime() - 600,
		leftTime = GetServerTime() - 300,
	}
	local line = NIT:buildInstanceLineFrameString(v, 1);
	return L["Example"] .. ": " .. line;
end

------------------------
--Load option defaults--
------------------------
NIT.optionDefaults = {
	global = {
		--The Ace3 GUI color picker seems to play better with decimals.
		--Some colors work with 255 method, some don't.
		--chatColorR = 255, chatColorG = 255, chatColorB = 0,
		--prefixColorR = 255, prefixColorG = 105, prefixColorB = 0,
		chatColorR = 1, chatColorG = 1, chatColorB = 0,
		mergeColorR = 1, mergeColorG = 1, mergeColorB = 0,
		prefixColorR = 1, prefixColorG = 0.4117647058823529, prefixColorB = 0,
		logSize = 100,
		showAltsLog = true,
		timeStringType = "medium",
		showLockoutTime = true,
		maxRecordsKept = maxRecordsKept,
		maxTradesKept = maxTradesKept,
		instanceResetMsg = true,
		enteredMsg = true,
		raidEnteredMsg = false,
		pvpEnteredMsg = true,
		timeStampFormat = 12,
		timeStampZone = "local",
		ignore40Man = false,
		showMoneyTradedChat = true,
		instanceStatsOutputMobCount = true,
		instanceStatsOutputXP = true,
		instanceStatsOutputAverageXP = false,
		instanceStatsOutputTime = true,
		instanceStatsOutputGold = true,
		instanceStatsOutputAverageGroupLevel = false,
		instanceStatsOutputRep = true,
		instanceStatsOutputHK = true,
		instanceStatsOutputXpPerHour = true,
		instanceStatsOutputCurrency = true,
		lastVersionMsg = 0,
		moneyString = "textures",
		instanceStatsOutput = true,
		instanceStatsOutputWhere = "self",
		minimapIcon = {["minimapPos"] = 180, ["hide"] = false},
		minimapButton = true,
		restedCharsOnly = false,
		detectSameInstance = true,
		showStatsInRaid = false,
		printRaidInstead = true,
		statsOnlyWhenActivity = false,
		show24HourOnly = false,
		trimDataBelowLevel = 1,
		instanceStatsOutputRunsPerLevel = true,
		instanceStatsOutputRunsNextLevel = false,
		instanceWindowWidth = 620,
		instanceWindowHeight = 501,
		charsWindowWidth = 600,
		charsWindowHeight = 350,
		tradeWindowWidth = 580,
		tradeWindowHeight = 320,
		copyTradeTime = true,
		copyTradeZone = true,
		copyTradeTimeAgo = true,
		copyTradeRecords = 100;
		charsMinLevel = 1,
		autoSfkDoor = true,
		autoSlavePens = true,
		autoBlackMorass = true,
		autoCavernsFlight = true,
		autoCavernsArthas = true,
		showPvpLog = true,
		showPveLog = true,
		noRaidInstanceMergeMsg = true,
		resetCharData = true, --Reset one time to delete data before alt UI stuff was added.
		autoGammaBuff = true,
		autoGammaBuffReminder = true,
		autoGammaBuffType = 1,
		dungeonPopTimer = true,
		autoWrathDailies = true,
		lootReminderReal = true,
		lootReminderSize = 24,
		lootReminderX = -10,
		lootReminderY = 150,
		lootReminderMinimap = true,
		wipeUpgradeData = true,
	},
};

if (NIT.isRetail) then
	NIT.optionDefaults.global.instanceWindowWidth = 650;
end

--5 per hour and 30 per day lockouts are character specific.
function NIT:buildDatabase()
	--Create realm tables if they don't exist.
	if (not self.db.global[NIT.realm]) then
		self.db.global[NIT.realm] = {};
	end
	if (not self.db.global[NIT.realm].instances) then
		self.db.global[NIT.realm].instances = {};
	end
	if (not self.db.global[NIT.realm].trades) then
		self.db.global[NIT.realm].trades = {};
	end
	if (not self.db.global[NIT.realm].myChars) then
		self.db.global[NIT.realm].myChars = {};
	end
	if (not self.db.global[NIT.realm].myChars[UnitName("player")]) then
		self.db.global[NIT.realm].myChars[UnitName("player")] = {};
	end
	if (not self.db.global[NIT.realm].myChars[UnitName("player")].bossKills) then
		self.db.global[NIT.realm].myChars[UnitName("player")].bossKills = {};
	end
	--if (not self.db.global[NIT.realm].myChars[UnitName("player")].levelLog) then
	--	self.db.global[NIT.realm].myChars[UnitName("player")].levelLog = {};
	--end
	if (not self.db.global[NIT.realm].gammaBuffSettings) then
		self.db.global[NIT.realm].gammaBuffSettings = {};
	end
	if (not self.db.global.versions) then
		self.db.global.versions = {};
	end
	self.data = self.db.global[NIT.realm];
end

local linesVersion, newVersionFrame;
local function loadNewVersionFrame()
	if (not newVersionFrame) then
		local frame = CreateFrame("Frame", "NIT_NewVersionFrame", UIParent, "BackdropTemplate");
		frame.scrollFrame = CreateFrame("ScrollFrame", "$parentScrollFrame", frame, "UIPanelScrollFrameTemplate");
		--frame.scrollFrame:SetAllPoints();
		frame.scrollChild = CreateFrame("Frame", "$parentScrollChild", frame.scrollFrame);
		frame.scrollFrame:SetScrollChild(frame.scrollChild);
		--frame.scrollChild:SetWidth(frame:GetWidth() - 30);
		frame.scrollChild:SetAllPoints();
		frame.scrollChild:SetPoint("RIGHT", -40, 0);
		frame.scrollChild:SetPoint("TOP", 0, -20);
		frame.scrollChild:SetHeight(1);
		frame.scrollChild:SetScript("OnSizeChanged", function(self,event)
			frame.scrollChild:SetWidth(self:GetWidth())
		end)
		frame.scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -8);
		frame.scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 8);
		
		frame:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8x8",
			insets = {top = 4, left = 4, bottom = 4, right = 4},
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tileEdge = true,
			edgeSize = 16,
		});
		frame:SetBackdropColor(0, 0, 0, 0.9);
		frame:SetBackdropBorderColor(1, 1, 1, 0.7);
		frame.scrollFrame.ScrollBar:ClearAllPoints();
		frame.scrollFrame.ScrollBar:SetPoint("TOPRIGHT", -5, -(frame.scrollFrame.ScrollBar.ScrollDownButton:GetHeight()) + 1);
		frame.scrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", -5, frame.scrollFrame.ScrollBar.ScrollUpButton:GetHeight());
		frame:SetToplevel(true);
		frame:SetMovable(true);
		frame:EnableMouse(true);
		frame:SetUserPlaced(false);
		frame:SetPoint("CENTER", UIParent, 0, 100);
		frame:SetSize(600, 670);
		frame:SetFrameStrata("HIGH");
		frame:SetFrameLevel(140);
		frame:SetScript("OnMouseDown", function(self, button)
			if (button == "LeftButton" and not self.isMoving) then
				self:StartMoving();
				self.isMoving = true;
				if (notSpecialFrames) then
					self:SetUserPlaced(false);
				end
			end
		end)
		frame:SetScript("OnMouseUp", function(self, button)
			if (button == "LeftButton" and self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
			end
		end)
		frame:SetScript("OnHide", function(self)
			if (self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
			end
		end)
		frame.scrollChild:EnableMouse(true);
		--frame.scrollChild:SetHyperlinksEnabled(true);
		--frame.scrollChild:SetScript("OnHyperlinkClick", ChatFrame_OnHyperlinkShow);
		--Set all fonts in the module using the frame.
		--Header string.
		frame.scrollChild.fs = frame.scrollChild:CreateFontString("NIT_NewVersionFrameFS", "ARTWORK");
		frame.scrollChild.fs:SetPoint("TOP", 0, -0);
		--The main display string.
		frame.scrollChild.fs2 = frame.scrollChild:CreateFontString("NIT_NewVersionFrameFS2", "ARTWORK");
		frame.scrollChild.fs2:SetPoint("TOPLEFT", 10, -24);
		frame.scrollChild.fs2:SetJustifyH("LEFT");
		--Bottom string.
		frame.scrollChild.fs3 = frame.scrollChild:CreateFontString("NIT_NewVersionFrameFS3", "ARTWORK");
		frame.scrollChild.fs3:SetPoint("BOTTOM", 0, -20);
		--frame.scrollChild.fs3:SetFont(NIT.regionFont, 14);
		--Top right X close button.
		frame.close = CreateFrame("Button", "NIT_NewVersionFrameClose", frame, "UIPanelCloseButton");
		frame.close:SetPoint("TOPRIGHT", -22, -4);
		frame.close:SetWidth(20);
		frame.close:SetHeight(20);
		frame.close:SetScript("OnClick", function(self, arg)
			frame:Hide();
		end)
		frame.close:GetNormalTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame.close:GetHighlightTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame.close:GetPushedTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame.close:GetDisabledTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
		frame:SetFrameStrata("HIGH");
		frame:SetClampedToScreen(true);
		frame.scrollChild.fs:SetFont(NIT.regionFont, 14);
		frame.scrollChild.fs2:SetFontObject(Game15Font);
		frame.scrollChild.fs3:SetFont(NIT.regionFont, 14);
		frame.scrollChild.fs:ClearAllPoints();
		frame.scrollChild.fs2:ClearAllPoints();
		frame.scrollChild.fs3:ClearAllPoints();
		frame.scrollChild.fs:SetPoint("TOP", 0, -5);
		frame.scrollChild.fs2:SetPoint("TOP", 0, -25);
		frame.scrollChild.fs3:SetPoint("TOPLEFT", 10, -48);
		frame.scrollChild.fs3:SetPoint("RIGHT", 0, -48);
		frame.scrollChild.fs3:SetJustifyH("LEFT");
		frame.scrollChild.fs3:CanWordWrap(true);
		frame.scrollChild.fs3:CanNonSpaceWrap(true);
		frame.scrollChild.fs3:SetNonSpaceWrap(true);
		frame.scrollChild.fs3:SetWordWrap(true);
		frame.scrollChild.fs:SetText("|TInterface\\AddOns\\NovaInstanceTracker\\Media\\portal:16:16:0:0|t  |cFF00FF00Nova Instance Tracker");
		frame.scrollChild.fs2:SetText("|cFFFFFF00New in version|r |cFFFF6900" .. string.format("%.2f", NIT.version));
		frame:Hide();
		newVersionFrame = frame;
	end
	linesVersion = 1.71;
	local lines = {
		--" ",
		"|cFFFF6900Version 1.70|r",
		"- Added reminder message in middle of the screen to loot Tarnished Undermine Real, can be disabled/moved/resized in options at the top.",
		"- Added tracking on the minimap button tooltip for which bosses you've looted a Tarnished Undermine Real from, while inside a dungeon just mouseover the NIT minimap icon for a full boss list and looted status.",
		" ",
		"|cFFFF6900Version 1.71|r",
		"- Added button on the alts window to view a list of all dungeons at once for if you've looted Tarnished Undermine Real (right click minimap button).",
		"- Fix a lua error and a couple other small bugs in version 1.70.";
	};
	--[[if (NIT.realm == "Arugal" or NIT.realm == "Remulos" or NIT.realm == "Yojamba") then
		lines = {
		};
	end]]
	local text = "";
	--Seperator lines couldn't be used because the wow client won't render 1 pixel frames if they are in certain posotions.
	--Not sure what causes some frame lines to render thicker than others and some not render at all.
	--[[local separatorText = "-";
	while (newVersionFrame.scrollFrame:GetWidth() - 55 > newVersionFrame.scrollChild.fs3:GetStringWidth()) do
		separatorText = separatorText .. "-";
		newVersionFrame.scrollChild.fs3:SetText(separatorText);
	end
	text = text .. separatorText .. "\n";]]
	text = text .. "\n";
	if (lines) then
		for k, v in ipairs(lines) do
			if (k % 2 == 0) then
				text = text .. "|cFFFFFFFF" .. v .. "|r\n";
			else
				text = text .. "|cFF9CD6DE" .. v .. "|r\n";
			end
			--text = text .. separatorText .. "\n";
			newVersionFrame.scrollChild.fs3:SetText(text);
		end
	end
	newVersionFrame:SetSize(600, 50 + newVersionFrame.scrollChild.fs:GetStringHeight() + newVersionFrame.scrollChild.fs2:GetStringHeight() + newVersionFrame.scrollChild.fs3:GetStringHeight());
	if (text ~= "" and linesVersion == NIT.version) then
		newVersionFrame.scrollChild.fs3:SetText(text);
		newVersionFrame:Show();
	end
end

function NIT:checkNewVersion()
	--loadNewVersionFrame();
	if (NIT.version and NIT.version ~= 9999) then
		if (not NIT.db.global.versions[NIT.version]) then
			if (NIT.isSOD) then
				--Only show this update for cata users.
				--if (NIT:GetCurrentRegion() == 1 and not string.match(NIT.realm, "(AU)")) then
					loadNewVersionFrame();
				--end
			end
			--Wipe old data.
			NIT.db.global.versions = {};
			--Set this version has been loaded before.
			NIT.db.global.versions[NIT.version] = GetServerTime();
		end
	end
end

function NIT:setLogSize(info, value)
	self.db.global.logSize = value;
end

function NIT:getLogSize(info)
	return self.db.global.logSize;
end

--Show all alts in the log window.
function NIT:setShowAltsLog(info, value)
	self.db.global.showAltsLog = value;
	NIT:hideAllLineFrames();
	NIT:recalcInstanceLineFrames();
	if (NIT.instanceFrameShowsAltsButton) then
		--Refresh the checkbox on instance log frame.
		NIT.instanceFrameShowsAltsButton:SetChecked(value);
	end
end

function NIT:getShowAltsLog(info)
	return self.db.global.showAltsLog;
end

--Show the past 24h in log only.
function NIT:setShow24HourOnly(info, value)
	self.db.global.show24HourOnly = value;
	NIT:hideAllLineFrames();
	NIT:recalcInstanceLineFrames();
end

function NIT:getShow24HourOnly(info)
	return self.db.global.show24HourOnly;
end

--Show lockout instead of time entered.
function NIT:setShowLockoutTime(info, value)
	self.db.global.showLockoutTime = value;
	NIT:recalcInstanceLineFrames();
end

function NIT:getShowLockoutTime(info)
	return self.db.global.showLockoutTime;
end
--Time strings in instance log.
function NIT:setTimeStringType(info, value)
	self.db.global.timeStringType = value;
	NIT:recalcInstanceLineFrames();
end

function NIT:getTimeStringType(info)
	return self.db.global.timeStringType;
end

function NIT:setInstanceResetMsg(info, value)
	self.db.global.instanceResetMsg = value;
end

function NIT:getInstanceResetMsg(info)
	return self.db.global.instanceResetMsg;
end

function NIT:setEnteredMsg(info, value)
	self.db.global.enteredMsg = value;
end

function NIT:getEnteredMsg(info)
	return self.db.global.enteredMsg;
end

function NIT:setRaidEnteredMsg(info, value)
	self.db.global.raidEnteredMsg = value;
end

function NIT:getRaidEnteredMsg(info)
	return self.db.global.raidEnteredMsg;
end

function NIT:setPvpEnteredMsg(info, value)
	self.db.global.pvpEnteredMsg = value;
end

function NIT:getPvpEnteredMsg(info)
	return self.db.global.pvpEnteredMsg;
end

function NIT:setNoRaidInstanceMergeMsg(info, value)
	self.db.global.noRaidInstanceMergeMsg = value;
end

function NIT:getNoRaidInstanceMergeMsg(info)
	return self.db.global.noRaidInstanceMergeMsg;
end

--Chat color.
function NIT:setChatColor(info, r, g, b, a)
	self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB = r, g, b;
	NIT.chatColor = "|cff" .. NIT:RGBToHex(self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB);
end

function NIT:getChatColor(info)
	return self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB;
end

--Merge color.
function NIT:setMergeColor(info, r, g, b, a)
	self.db.global.mergeColorR, self.db.global.mergeColorG, self.db.global.mergeColorB = r, g, b;
	NIT.mergeColor = "|cff" .. NIT:RGBToHex(self.db.global.mergeColorR, self.db.global.mergeColorG, self.db.global.mergeColorB);
end

function NIT:getMergeColor(info)
	return self.db.global.mergeColorR, self.db.global.mergeColorG, self.db.global.mergeColorB;
end

--Reset colors.
function NIT:resetColors(info, r, g, b, a)
	self.db.global.chatColorR = self.optionDefaults.global.chatColorR;
	self.db.global.chatColorG = self.optionDefaults.global.chatColorG;
	self.db.global.chatColorB = self.optionDefaults.global.chatColorB;
	self.db.global.mergeColorR = self.optionDefaults.global.mergeColorR;
	self.db.global.mergeColorG = self.optionDefaults.global.mergeColorG;
	self.db.global.mergeColorB = self.optionDefaults.global.mergeColorB;
	NIT.chatColor = "|cff" .. NIT:RGBToHex(self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB);
	NIT.mergeColor = "|cff" .. NIT:RGBToHex(self.db.global.mergeColorR, self.db.global.mergeColorG, self.db.global.mergeColorB);
end

--Which timestamp format to use 12h/24h.
function NIT:setTimeStampFormat(info, value)
	self.db.global.timeStampFormat = value;
end

function NIT:getTimeStampFormat(info)
	return self.db.global.timeStampFormat;
end

--Which timezone format to use local/server.
function NIT:setTimeStampZone(info, value)
	self.db.global.timeStampZone = value;
end

function NIT:getTimeStampZone(info)
	return self.db.global.timeStampZone;
end

--Ignore 40man instances.
function NIT:setIgnore40Man(info, value)
	self.db.global.ignore40Man = value;
end

function NIT:getIgnore40Man(info)
	return self.db.global.ignore40Man;
end

--Minimap button
function NIT:setMinimapButton(info, value)
	self.db.global.minimapButton = value;
	if (value) then
		NIT.LDBIcon:Show("NovaInstanceTracker");
		self.db.global.minimapIcon.hide = false;
	else
		NIT.LDBIcon:Hide("NovaInstanceTracker");
		self.db.global.minimapIcon.hide = true;
	end
end

function NIT:getMinimapButton(info)
	return self.db.global.minimapButton;
end

--Show gold trades in chat.
function NIT:setShowMoneyTradedChat(info, value)
	self.db.global.showMoneyTradedChat = value;
end

function NIT:getShowMoneyTradedChat(info)
	return self.db.global.showMoneyTradedChat;
end

--Auto detect same instance as last.
function NIT:setDetectSameInstance(info, value)
	self.db.global.detectSameInstance = value;
end

function NIT:getDetectSameInstance(info)
	return self.db.global.detectSameInstance;
end

--Show stats when exiting dungeon.
function NIT:setInstanceStatsOutput(info, value)
	self.db.global.instanceStatsOutput = value;
end

function NIT:getInstanceStatsOutput(info)
	return self.db.global.instanceStatsOutput;
end

--Where to show stats when exiting dungeon.
function NIT:setInstanceStatsOutputWhere(info, value)
	self.db.global.instanceStatsOutputWhere = value;
end

function NIT:getInstanceStatsOutputWhere(info)
	return self.db.global.instanceStatsOutputWhere;
end

--Mob count stats output when exiting dungeon.
function NIT:setInstanceStatsOutputMobCount(info, value)
	self.db.global.instanceStatsOutputMobCount = value;
end

function NIT:getInstanceStatsOutputMobCount(info)
	return self.db.global.instanceStatsOutputMobCount;
end

--XP stats output when exiting dungeon.
function NIT:setInstanceStatsOutputXP(info, value)
	self.db.global.instanceStatsOutputXP = value;
end

function NIT:getInstanceStatsOutputXP(info)
	return self.db.global.instanceStatsOutputXP;
end

--XP per hour stats output when exiting dungeon.
function NIT:setInstanceStatsOutputXpPerHour(info, value)
	self.db.global.instanceStatsOutputXpPerHour = value;
end

function NIT:getInstanceStatsOutputXpPerHour(info)
	return self.db.global.instanceStatsOutputXpPerHour;
end

--Average XP stats output when exiting dungeon.
function NIT:setInstanceStatsOutputAverageXP(info, value)
	self.db.global.instanceStatsOutputAverageXP = value;
end

function NIT:getInstanceStatsOutputAverageXP(info)
	return self.db.global.instanceStatsOutputAverageXP;
end

--Time stats output when exiting dungeon.
function NIT:setInstanceStatsOutputTime(info, value)
	self.db.global.instanceStatsOutputTime = value;
end

function NIT:getInstanceStatsOutputTime(info)
	return self.db.global.instanceStatsOutputTime;
end

--Gold stats output when exiting dungeon.
function NIT:setInstanceStatsOutputGold(info, value)
	self.db.global.instanceStatsOutputGold = value;
end

function NIT:getInstanceStatsOutputGold(info)
	return self.db.global.instanceStatsOutputGold;
end

--Average group level stats output when exiting dungeon.
function NIT:setInstanceStatsOutputAverageGroupLevel(info, value)
	self.db.global.instanceStatsOutputAverageGroupLevel = value;
end

function NIT:getInstanceStatsOutputAverageGroupLevel(info)
	return self.db.global.instanceStatsOutputAverageGroupLevel;
end

--Show stats while in raid.
function NIT:setShowStatsInRaid(info, value)
	self.db.global.showStatsInRaid = value;
end

function NIT:getShowStatsInRaid(info)
	return self.db.global.showStatsInRaid;
end

--Print to chat if in raid instead.
function NIT:setPrintRaidInstead(info, value)
	self.db.global.printRaidInstead = value;
end

function NIT:getPrintRaidInstead(info)
	return self.db.global.printRaidInstead;
end

--Show stats only when activity (xp, mob kills etc).
function NIT:setStatsOnlyWhenActivity(info, value)
	self.db.global.statsOnlyWhenActivity = value;
end

function NIT:getStatsOnlyWhenActivity(info)
	return self.db.global.statsOnlyWhenActivity;
end

--Trim data of characters below this level.
function NIT:setTrimDataBelowLevel(info, value)
	self.db.global.trimDataBelowLevel = value;
end

function NIT:getTrimDataBelowLevel(info)
	return self.db.global.trimDataBelowLevel;
end

--Trim data for single char.
function NIT:setTrimDataCharInput(info, value)
	NIT:removeSingleChar(value);
end

function NIT:getTrimDataCharInput(info)

end

--Runs per level stats output when exiting dungeon.
function NIT:setInstanceStatsOutputRunsPerLevel(info, value)
	self.db.global.instanceStatsOutputRunsPerLevel = value;
end

function NIT:getInstanceStatsOutputRunsPerLevel(info)
	return self.db.global.instanceStatsOutputRunsPerLevel;
end

--Runs until next level stats output when exiting dungeon.
function NIT:setInstanceStatsOutputRunsNextLevel(info, value)
	self.db.global.instanceStatsOutputRunsNextLevel = value;
end

function NIT:getInstanceStatsOutputRunsNextLevel(info)
	return self.db.global.instanceStatsOutputRunsNextLevel;
end

--Rep stats output when exiting dungeon.
function NIT:setInstanceStatsOutputRep(info, value)
	self.db.global.instanceStatsOutputRep = value;
end

function NIT:getInstanceStatsOutputRep(info)
	return self.db.global.instanceStatsOutputRep;
end

--Honor kills stats output when exiting bg.
function NIT:setInstanceStatsOutputHK(info, value)
	self.db.global.instanceStatsOutputHK = value;
end

function NIT:getInstanceStatsOutputHK(info)
	return self.db.global.instanceStatsOutputHK;
end

function NIT:setInstanceStatsOutputCurrency(info, value)
	self.db.global.instanceStatsOutputCurrency = value;
end

function NIT:getInstanceStatsOutputCurrency(info)
	return self.db.global.instanceStatsOutputCurrency;
end

--Instance window dimensions.
function NIT:setInstanceWindowWidth(info, value)
	self.db.global.instanceWindowWidth = value;
	_G["NITInstanceFrame"]:SetWidth(value);
	_G["NITInstanceFrame"].EditBox:SetWidth(value - 30);
end

function NIT:getInstanceWindowWidth(info)
	return self.db.global.instanceWindowWidth;
end

function NIT:setInstanceWindowHeight(info, value)
	self.db.global.instanceWindowHeight = value;
	_G["NITInstanceFrame"]:SetHeight(value);
end

function NIT:getInstanceWindowHeight(info)
	return self.db.global.instanceWindowHeight;
end

--Chars window dimensions.
function NIT:setCharsWindowWidth(info, value)
	self.db.global.charsWindowWidth = value;
	_G["NITAltsFrame"]:SetWidth(value);
	_G["NITAltsFrame"].EditBox:SetWidth(value - 30);
end

function NIT:getCharsWindowWidth(info)
	return self.db.global.charsWindowWidth;
end

function NIT:setCharsWindowHeight(info, value)
	self.db.global.charsWindowHeight = value;
	_G["NITAltsFrame"]:SetHeight(value);
end

function NIT:getCharsWindowHeight(info)
	return self.db.global.charsWindowHeight;
end

--Trade window dimensions.
function NIT:setTradeWindowWidth(info, value)
	self.db.global.tradeWindowWidth = value;
	_G["NITTradeLogFrame"]:SetWidth(value);
	_G["NITTradeLogFrame"].EditBox:SetWidth(value - 30);
end

function NIT:getTradeWindowWidth(info)
	return self.db.global.tradeWindowWidth;
end

function NIT:setTradeWindowHeight(info, value)
	self.db.global.tradeWindowHeight = value;
	_G["NITTradeLogFrame"]:SetHeight(value);
end

function NIT:getTradeWindowHeight(info)
	return self.db.global.tradeWindowHeight;
end

--Reset frames.
function NIT:resetFrames()
	self.db.global.instanceWindowWidth = self.optionDefaults.global.instanceWindowWidth;
	self.db.global.instanceWindowHeight = self.optionDefaults.global.instanceWindowHeight;
	self.db.global.charsWindowWidth = self.optionDefaults.global.charsWindowWidth;
	self.db.global.charsWindowHeight = self.optionDefaults.global.charsWindowHeight;
	self.db.global.tradeWindowWidth = self.optionDefaults.global.tradeWindowWidth;
	self.db.global.tradeWindowHeight = self.optionDefaults.global.tradeWindowHeight;
	_G["NITInstanceFrame"]:SetWidth(self.db.global.instanceWindowWidth);
	_G["NITInstanceFrame"].EditBox:SetWidth(self.db.global.instanceWindowWidth - 30);
	_G["NITInstanceFrame"]:SetHeight(self.db.global.instanceWindowHeight);
	_G["NITInstanceFrame"]:ClearAllPoints();
	_G["NITInstanceFrame"]:SetPoint("CENTER", UIParent, 0, 100);
	_G["NITAltsFrame"]:SetWidth(self.db.global.charsWindowWidth);
	_G["NITAltsFrame"].EditBox:SetWidth(self.db.global.charsWindowWidth - 30);
	_G["NITAltsFrame"]:SetHeight(self.db.global.charsWindowHeight);
	_G["NITAltsFrame"]:ClearAllPoints();
	_G["NITAltsFrame"]:SetPoint("CENTER", UIParent, 0, 100);
	_G["NITTradeLogFrame"]:SetWidth(self.db.global.tradeWindowWidth);
	_G["NITTradeLogFrame"].EditBox:SetWidth(self.db.global.tradeWindowWidth - 30);
	_G["NITTradeLogFrame"]:SetHeight(self.db.global.tradeWindowHeight);
	_G["NITTradeLogFrame"]:ClearAllPoints();
	_G["NITTradeLogFrame"]:SetPoint("CENTER", UIParent, 20, 120);
	_G["NITTradeCopyFrame"]:SetWidth(self.db.global.tradeWindowWidth);
	_G["NITTradeCopyFrame"].EditBox:SetWidth(self.db.global.tradeWindowWidth - 30);
	_G["NITTradeCopyFrame"]:SetHeight(self.db.global.tradeWindowHeight);
	_G["NITTradeCopyFrame"]:ClearAllPoints();
	_G["NITTradeCopyFrame"]:SetPoint("CENTER", UIParent, -70, 150);
	NIT:print(L["resetFramesMsg"]);
end

--Auto dialogue slave pens.
function NIT:setAutoSlavePens(info, value)
	self.db.global.autoSlavePens = value;
end

function NIT:getAutoSlavePens(info)
	return self.db.global.autoSlavePens;
end

--Auto dialogue caverns flight.
function NIT:setAutoCavernsFlight(info, value)
	self.db.global.autoCavernsFlight = value;
end

function NIT:getAutoCavernsFlight(info)
	return self.db.global.autoCavernsFlight;
end

--Auto dialogue caverns arthas.
function NIT:setAutoCavernsArthas(info, value)
	self.db.global.autoCavernsArthas = value;
end

function NIT:getAutoCavernsArthas(info)
	return self.db.global.autoCavernsArthas;
end

--Auto dialogue black morass.
function NIT:setAutoBlackMorass(info, value)
	self.db.global.autoBlackMorass = value;
end

function NIT:getAutoBlackMorass(info)
	return self.db.global.autoBlackMorass;
end

--Auto dialogue sfk door.
function NIT:setAutoSfkDoor(info, value)
	self.db.global.autoSfkDoor = value;
end

function NIT:getAutoSfkDoor(info)
	return self.db.global.autoSfkDoor;
end

--Auto gamma buff dialogue.
function NIT:setAutoGammaBuff(info, value)
	self.db.global.autoGammaBuff = value;
end

function NIT:getAutoGammaBuff(info)
	return self.db.global.autoGammaBuff;
end

--Auto gamma buff reminder.
function NIT:setAutoGammaBuffReminder(info, value)
	self.db.global.autoGammaBuffReminder = value;
end

function NIT:getAutoGammaBuffReminder(info)
	return self.db.global.autoGammaBuffReminder;
end

--Dungeon pop timer.
function NIT:setDungeonPopTimer(info, value)
	self.db.global.dungeonPopTimer = value;
end

function NIT:getDungeonPopTimer(info)
	return self.db.global.dungeonPopTimer;
end

--Auto get daily quests.
function NIT:setAutoWrathDailies(info, value)
	self.db.global.autoWrathDailies = value;
end

function NIT:getAutoWrathDailies(info)
	return self.db.global.autoWrathDailies;
end

--Which gamma dung buff to get.
function NIT:setAutoGammaBuffType(info, value)
	if (NIT.data.gammaBuffSettings) then
		NIT.data.gammaBuffSettings[UnitName("player")] = value;
	else
		self.db.global.autoGammaBuffType = value;
	end
end

function NIT:getAutoGammaBuffType(info)
	if (NIT.data.gammaBuffSettings and NIT.data.gammaBuffSettings[UnitName("player")]) then
		return NIT.data.gammaBuffSettings[UnitName("player")];
	else
		return self.db.global.autoGammaBuffType;
	end
end

--Loot reminder Tarnished Undermine Real.
function NIT:setLootReminderReal(info, value)
	self.db.global.lootReminderReal = value;
end

function NIT:getLootReminderReal(info)
	return self.db.global.lootReminderReal;
end

--Loot reminder text size.
function NIT:setLootReminderSize(info, value)
	self.db.global.lootReminderSize = value;
	NIT:updateLootReminderFrame(true);
end

function NIT:getLootReminderSize(info)
	return self.db.global.lootReminderSize;
end

--Loot reminder X position.
function NIT:setLootReminderX(info, value)
	self.db.global.lootReminderX = value;
	NIT:updateLootReminderFrame(true);
end

function NIT:getLootReminderX(info)
	return self.db.global.lootReminderX;
end

--Loot reminder Y position.
function NIT:setLootReminderY(info, value)
	self.db.global.lootReminderY = value;
	NIT:updateLootReminderFrame(true);
end

function NIT:getLootReminderY(info)
	return self.db.global.lootReminderY;
end