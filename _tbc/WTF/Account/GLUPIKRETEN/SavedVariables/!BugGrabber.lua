
BugGrabberDB = {
	["lastSanitation"] = 3,
	["session"] = 4621,
	["errors"] = {
		{
			["message"] = "...ce\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1770: attempt to perform arithmetic on a nil value",
			["time"] = "2022/02/11 10:17:31",
			["locals"] = "self = <table> {\n HookBaseTracker = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:2069\n MoveDurabilityFrame = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1128\n _alreadyHooked = true\n _alreadyHookedSecure = true\n Enable = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1166\n Unhook = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:2055\n Expand = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1212\n _IsQuestWatched = <function> defined =[C]:-1\n _GetNumQuestWatches = <function> defined =[C]:-1\n _order = <table> {\n }\n GetBaseFrame = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1098\n started = true\n private = <table> {\n }\n menu = <table> {\n }\n CheckDurabilityAlertStatus = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1142\n utils = <table> {\n }\n Untrack = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:2045\n UpdateQuestProximityTimer = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:2438\n IsExpanded = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1218\n ResetLinesForChange = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:2188\n AQW_Insert = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:2278\n UnFocus = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1938\n RemoveQuest = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:2205\n ResetDurabilityFrame = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1123\n FocusQuest = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:2027\n FocusObjective = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1987\n Collapse = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1206\n Initialize = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:63\n Update = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1222\n Toggle = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1192\n Disable = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1180\n ResetLocation = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:1102\n}\nline = Questie_QuestButton2 {\n 0 = <userdata>\n label = <unnamed> {\n }\n expandZone = Questie_ZoneHeader {\n }\n SetZone = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:931\n SetQuest = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:936\n SetVerticalPadding = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:945\n SetMode = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:914\n expandQuest = Questie_MinQuestButton {\n }\n mode = \"quest\"\n Quest = <table> {\n }\n SetObjective = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:941\n}\norder = <table> {\n 1 = 8900\n}\nquestCompletePercent = <table> {\n 8900 = 1\n}\nfirstQuestInZone = false\nzoneCheck = \"Seasonal\"\nstartUnusedFrames = 4\nstartUnusedButtons = 1\nactiveQuestsHeaderTotal = 155.992332\ntrackerVARScombined = 154.258629\ntrackerBaseFrame = 215.017059\ntrackerBottomPadding = 0\nlineNum = 2\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = Questie_BaseFrame {\n 0 = <userdata>\n SetPoint = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:27\n BottomEdge = <unnamed> {\n }\n beautyShadow = <table> {\n }\n beautyBorder = <table> {\n }\n TopLeftCorner = <unnamed> {\n }\n OnBackdropLoaded = <function> defined @Interface\\SharedXML\\Backdrop.lua:144\n Update = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:239\n Center = <unnamed> {\n }\n GetBackdropColor = <function",
			["stack"] = "[string \"@Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua\"]:1770: in function `Update'\n[string \"@Interface\\AddOns\\Questie\\Modules\\Quest\\QuestieQuest.lua\"]:514: in function `func'\n[string \"@Interface\\AddOns\\Questie\\Modules\\Libs\\QuestieCombatQueue.lua\"]:17: in function <...e\\AddOns\\Questie\\Modules\\Libs\\QuestieCombatQueue.lua:9>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 4577,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'whoaThickFrames_BCC' tried to call the protected function 'CompactRaidFrame1:ClearAllPoints()'.",
			["time"] = "2022/02/12 11:49:08",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: in function `ClearAllPoints'\n[string \"@Interface\\FrameXML\\FlowContainer.lua\"]:157: in function `FlowContainer_DoLayout'\n[string \"@Interface\\FrameXML\\FlowContainer.lua\"]:17: in function `FlowContainer_ResumeUpdates'\n[string \"@Interface\\AddOns\\Blizzard_CompactRaidFrames\\Blizzard_CompactRaidFrameContainer.lua\"]:185: in function `CompactRaidFrameContainer_LayoutFrames'\n[string \"@Interface\\AddOns\\Blizzard_CompactRaidFrames\\Blizzard_CompactRaidFrameContainer.lua\"]:130: in function `CompactRaidFrameContainer_TryUpdate'\n[string \"@Interface\\AddOns\\Blizzard_CompactRaidFrames\\Blizzard_CompactRaidFrameContainer.lua\"]:57: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 4588,
			["counter"] = 1,
		}, -- [2]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'ImprovedMacroFrame' tried to call the protected function 'EditMacro()'.",
			["time"] = "2022/02/12 14:50:26",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: in function `EditMacro'\n[string \"@Interface\\AddOns\\Blizzard_MacroUI\\Blizzard_MacroUI.lua\"]:503: in function `MacroFrame_SaveMacro'\n[string \"@Interface\\AddOns\\ImprovedMacroFrame\\ImprovedMacroFrame-1.0.2.lua\"]:44: in function <...ace\\AddOns\\ImprovedMacroFrame\\ImprovedMacroFrame.lua:42>\n[string \"=[C]\"]: in function `Hide'\n[string \"@Interface_TBC\\FrameXML\\UIParent.lua\"]:2089: in function `SetUIPanel'\n[string \"@Interface_TBC\\FrameXML\\UIParent.lua\"]:2169: in function `HideUIPanel'\n[string \"@Interface_TBC\\FrameXML\\UIParent.lua\"]:1822: in function <Interface_TBC\\FrameXML\\UIParent.lua:1814>\n[string \"=[C]\"]: in function `SetAttribute'\n[string \"@Interface_TBC\\FrameXML\\UIParent.lua\"]:2612: in function `HideUIPanel'\n[string \"@Interface\\SharedXML\\SharedUIPanelTemplates.lua\"]:313: in function `HideParentPanel'\n[string \"@Interface\\SharedXML\\SharedUIPanelTemplates.lua\"]:180: in function <Interface\\SharedXML\\SharedUIPanelTemplates.lua:174>",
			["session"] = 4590,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVermin' tried to call the protected function 'PickupAction()'.",
			["time"] = "2022/02/12 15:21:53",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: in function `PickupAction'\n[string \"*:OnDragStart\"]:2: in function <[string \"*:OnDragStart\"]:1>",
			["session"] = 4590,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:219: Action[FrameMeasurement] failed because[Can't measure restricted regions]: attempted from: NeatPlatesCarrier-1:GetPoint().",
			["time"] = "2022/02/13 17:33:53",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"=[C]\"]: in function `GetPoint'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:219: in function `HighlightFrame'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:242: in function <...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools.lua:233>",
			["session"] = 4592,
			["counter"] = 9,
		}, -- [5]
		{
			["message"] = "...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:219: Action[FrameMeasurement] failed because[Can't measure restricted regions]: attempted from: <unnamed>:GetPoint().",
			["time"] = "2022/02/13 17:34:46",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"=[C]\"]: in function `GetPoint'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:219: in function `HighlightFrame'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:242: in function <...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools.lua:233>",
			["session"] = 4592,
			["counter"] = 3,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\TellMeWhen\\TellMeWhen-9.1.2.lua:2613: [string \"for i = 1, 40 do...\"]:11: attempt to compare number with nil",
			["time"] = "2022/02/15 18:33:19",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"=[C]\"]: ?\n[string \"@Interface\\AddOns\\TellMeWhen\\TellMeWhen-9.1.2.lua\"]:2613: in function <Interface\\AddOns\\TellMeWhen\\TellMeWhen.lua:2602>",
			["session"] = 4594,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "[string \"for i = 1, 40 do...\"]:11: attempt to compare number with nil",
			["time"] = "2022/02/15 18:33:19",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"for i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend\"]:11: in function `LF_0000019987D70FA0'\n[string \"Condition_DEBUFFSTACKS_RAGE_ABS_ALIVE_HEALTH_LUA\"]:7: in function `CheckFunction'\n[string \"@Interface\\AddOns\\TellMeWhen\\Components\\Core\\Conditions\\ConditionObject.lua\"]:265: in function `Check'\n[string \"@Interface\\AddOns\\TellMeWhen\\Components\\Core\\Icon.lua\"]:756: in function <Interface\\AddOns\\TellMeWhen\\Components\\Core\\Icon.lua:727>\n[string \"=(tail call)\"]: ?\n[string \"=[C]\"]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n[string \"=(tail call)\"]: ?\n[string \"@Interface\\AddOns\\TellMeWhen\\TellMeWhen-9.1.2.lua\"]:2573: in function <Interface\\AddOns\\TellMeWhen\\TellMeWhen.lua:2535>",
			["session"] = 4594,
			["counter"] = 7,
		}, -- [8]
		{
			["message"] = "[string \"for i = 1, 40 do...\"]:8: attempt to perform arithmetic on global 'inRange' (a nil value)",
			["time"] = "2022/02/15 18:33:20",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"for i = 1, 40 do\n    if UnitExists(\"nameplate\" .. i) and IsSpellInRange(\"Cleave\", \"nameplate\" .. i) == 1 and CheckInteractDistance(\"nameplate\"..i, 3) then\n        -- 1 = Inspect, 28 yards\n        -- 2 = Trade, 11.11 yards\n        -- 3 = Duel, 9.9 yards\n        -- 4 = Follow, 28 yards\n        -- print(\"nameplate\"..i,CheckInteractDistance(\"nameplate\"..i, 3))\n        inRange = inRange + 1\n    end\nend\nif inRange > 1 then\n    return false\nelse\n    return true\nend\"]:8: in function `LF_0000019987D70FA0'\n[string \"Condition_DEBUFFSTACKS_RAGE_ABS_ALIVE_HEALTH_LUA\"]:7: in function `CheckFunction'\n[string \"@Interface\\AddOns\\TellMeWhen\\Components\\Core\\Conditions\\ConditionObject.lua\"]:265: in function `Check'\n[string \"@Interface\\AddOns\\TellMeWhen\\Components\\Core\\Icon.lua\"]:756: in function <Interface\\AddOns\\TellMeWhen\\Components\\Core\\Icon.lua:727>\n[string \"=(tail call)\"]: ?\n[string \"=[C]\"]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n[string \"=(tail call)\"]: ?\n[string \"@Interface\\AddOns\\TellMeWhen\\TellMeWhen-9.1.2.lua\"]:2573: in function <Interface\\AddOns\\TellMeWhen\\TellMeWhen.lua:2535>",
			["session"] = 4594,
			["counter"] = 125,
		}, -- [9]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVermin' tried to call the protected function 'TargetFrameToT:Show()'.",
			["time"] = "2022/02/16 20:30:17",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: in function `Show'\n[string \"@Interface_TBC\\FrameXML\\TargetFrame.lua\"]:913: in function `TargetofTarget_Update'\n[string \"@Interface_TBC\\FrameXML\\TargetFrame.lua\"]:416: in function `TargetFrame_OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?",
			["session"] = 4604,
			["counter"] = 2,
		}, -- [10]
		{
			["message"] = "...TBC\\AddOns\\Blizzard_AuctionUI\\Blizzard_AuctionUI.lua:751: attempt to index local 'color' (a nil value)",
			["time"] = "2022/02/17 22:46:39",
			["locals"] = "numBatchAuctions = 52811\ntotalAuctions = 52811\nbutton = BrowseButton2 {\n 0 = <userdata>\n itemCount = 20\n bidAmount = 34580\n buyoutPrice = 6995960\n itemIndex = 2\n PriceTooltipFrame = <unnamed> {\n }\n}\nbuttonName = \"BrowseButton2\"\nbuttonHighlight = BrowseButton2Highlight {\n 0 = <userdata>\n}\niconTexture = BrowseButton1ItemIconTexture {\n 0 = <userdata>\n}\nitemName = BrowseButton2Name {\n 0 = <userdata>\n}\ncolor = nil\nitemCount = BrowseButton1ItemCount {\n 0 = <userdata>\n}\nmoneyFrame = BrowseButton1MoneyFrame {\n 0 = <userdata>\n vadjust = 0\n trialErrorButton = BrowseButton1MoneyFrameTrialErrorButton {\n }\n moneyType = \"AUCTION\"\n info = <table> {\n }\n small = 1\n staticMoney = 2296\n maxDisplayWidth = 146\n}\nyourBidText = BrowseButton1YourBidText {\n 0 = <userdata>\n}\nbuyoutFrame = BrowseButton1BuyoutFrame {\n 0 = <userdata>\n}\nbuyoutMoney = BrowseButton1BuyoutFrameMoney {\n 0 = <userdata>\n vadjust = 0\n trialErrorButton = BrowseButton1BuyoutFrameMoneyTrialErrorButton {\n }\n moneyType = \"AUCTION\"\n info = <table> {\n }\n small = 1\n staticMoney = 2499\n maxDisplayWidth = 146\n}\noffset = 0\nindex = 2\nisLastSlotEmpty = nil\nname = \"\"\ntexture = 134955\ncount = 1\nquality = -1\ncanUse = false\nlevel = 0\nlevelColHeader = nil\nminBid = 43995\nminIncrement = 0\nbuyoutPrice = 43995\nduration = 3\nbidAmount = 0\nhighBidder = false\nbidderFullName = nil\nowner = nil\nownerFullName = nil\nsaleStatus = 0\nitemId = 15894\nhasAllInfo = true\ndisplayedPrice = 2296\nrequiredBid = 2296\n(for index) = 2\n(for limit) = 8\n(for step) = 1\ni = 2\nshouldHide = false\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = BrowseButton2Name {\n 0 = <userdata>\n}\n(*temporary) = \"\"\n(*temporary) = <userdata>\n(*temporary) = false\n(*temporary) = 0\n(*temporary) = nil\n(*temporary) = 43995\n(*temporary) = 0\n(*temporary) = 43995\n(*temporary) = 0\n(*temporary) = false\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = 0\n(*temporary) = 15894\n(*temporary) = true\n(*temporary) = \"attempt to index local 'color' (a nil value)\"\n",
			["stack"] = "[string \"@Interface_TBC\\AddOns\\Blizzard_AuctionUI\\Blizzard_AuctionUI.lua\"]:751: in function `AuctionFrameBrowse_Update'\n[string \"@Interface_TBC\\AddOns\\Blizzard_AuctionUI\\Blizzard_AuctionUI.lua\"]:277: in function <...TBC\\AddOns\\Blizzard_AuctionUI\\Blizzard_AuctionUI.lua:275>",
			["session"] = 4607,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "[string \"Questie_BaseFrame.SetPoint=funtion()end\"]:1: '<eof>' expected near 'end'",
			["time"] = "2022/02/18 13:20:38",
			["locals"] = "(*temporary) = \"Questie_BaseFrame.SetPoint=funtion()end\"\n",
			["stack"] = "[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2156: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4829: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4492: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4528: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 4611,
			["counter"] = 1,
		}, -- [12]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVermin' tried to call the protected function 'MultiBarBottomLeft:SetShown()'.",
			["time"] = "2022/02/15 18:27:27",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: in function `SetShown'\n[string \"@Interface\\FrameXML\\MultiActionBars.lua\"]:36: in function <Interface\\FrameXML\\MultiActionBars.lua:34>\n[string \"@Interface\\FrameXML\\MultiActionBars.lua\"]:52: in function `MultiActionBar_Update'\n[string \"@Interface\\FrameXML\\ActionBarController.lua\"]:138: in function `ValidateActionBarTransition'\n[string \"@Interface\\FrameXML\\ActionBarController.lua\"]:106: in function `ActionBarController_UpdateAll'\n[string \"@Interface\\FrameXML\\ActionBarController.lua\"]:45: in function <Interface\\FrameXML\\ActionBarController.lua:34>",
			["session"] = 4617,
			["counter"] = 11,
		}, -- [13]
		{
			["message"] = "...s\\Questie\\Modules\\Tracker\\QuestieTrackerPrivates.lua:32: Frame Questie_BaseFrame is not movable",
			["time"] = "2022/02/18 13:33:52",
			["locals"] = "(*temporary) = Questie_BaseFrame {\n 0 = <userdata>\n SetPoint = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:25\n BottomEdge = <unnamed> {\n }\n beautyShadow = <table> {\n }\n beautyBorder = <table> {\n }\n TopLeftCorner = <unnamed> {\n }\n OnBackdropLoaded = <function> defined @Interface\\SharedXML\\Backdrop.lua:144\n Update = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:239\n Center = <unnamed> {\n }\n GetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:382\n SetupTextureCoordinates = <function> defined @Interface\\SharedXML\\Backdrop.lua:206\n OnBackdropSizeChanged = <function> defined @Interface\\SharedXML\\Backdrop.lua:174\n HasBackdropInfo = <function> defined @Interface\\SharedXML\\Backdrop.lua:270\n SetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:414\n RightEdge = <unnamed> {\n }\n backdropInfo = <table> {\n }\n ClearAllPoints = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:24\n GetEdgeSize = <function> defined @Interface\\SharedXML\\Backdrop.lua:180\n BottomLeftCorner = <unnamed> {\n }\n BottomRightCorner = <unnamed> {\n }\n TopEdge = <unnamed> {\n }\n ApplyBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:286\n SetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:321\n ClearBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:274\n TopRightCorner = <unnamed> {\n }\n GetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:401\n GetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:339\n sizer = Questie_Sizer {\n }\n SetupPieceVisuals = <function> defined @Interface\\SharedXML\\Backdrop.lua:238\n SetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:391\n LeftEdge = <unnamed> {\n }\n SetBorderBlendMode = <function> defined @Interface\\SharedXML\\Backdrop.lua:258\n}\n",
			["stack"] = "[string \"=[C]\"]: in function `StartMoving'\n[string \"@Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTrackerPrivates.lua\"]:32: in function <...s\\Questie\\Modules\\Tracker\\QuestieTrackerPrivates.lua:19>",
			["session"] = 4621,
			["counter"] = 8,
		}, -- [14]
	},
}
