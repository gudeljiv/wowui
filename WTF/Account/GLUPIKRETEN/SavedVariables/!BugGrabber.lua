
BugGrabberDB = {
	["session"] = 3928,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "...\\AddOns\\Details\\Libs\\DetailsFramework\\lib\\slider.lua:456: Action[SetPoint] failed because[SetPoint would result in anchor family connection]: attempted from: DetailsFrameworkSliderButtons1:SetPoint.",
			["time"] = "2021/12/25 16:54:29",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"=[C]\"]: in function `SetPoint'\n[string \"@Interface\\AddOns\\Details\\Libs\\DetailsFramework\\lib\\slider.lua\"]:456: in function `ShowMe'\n[string \"@Interface\\AddOns\\Details\\Libs\\DetailsFramework\\lib\\slider.lua\"]:388: in function <...\\AddOns\\Details\\Libs\\DetailsFramework\\lib\\slider.lua:383>",
			["session"] = 3697,
			["counter"] = 15,
		}, -- [1]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'AdiBags' tried to call the protected function 'PutItemInBag()'.",
			["time"] = "2021/12/25 17:38:24",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: ?\n[string \"@Interface\\AddOns\\AdiBags\\widgets\\BagSlots.lua\"]:335: in function <Interface\\AddOns\\AdiBags\\widgets\\BagSlots.lua:329>",
			["session"] = 3697,
			["counter"] = 1,
		}, -- [2]
		{
			["message"] = "Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:466: attempt to index local 'button' (a nil value)",
			["time"] = "2021/12/26 10:56:53",
			["locals"] = "self = AdiBagsContainer1 {\n 0 = <userdata>\n HeaderLeftRegion = AdiBagsSimpleLayeredRegion1 {\n }\n isBank = false\n OnBackdropLoaded = <function> defined @Interface\\SharedXML\\Backdrop.lua:144\n GetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:382\n SetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:414\n BagSlotButton = <unnamed> {\n }\n BottomLeftRegion = AdiBagsSimpleLayeredRegion3 {\n }\n minWidth = 142.643744\n forceLayout = false\n paused = false\n ApplyBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:286\n beautyBorder = <table> {\n }\n ClearBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:274\n Center = <unnamed> {\n }\n GetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:401\n name = \"Backpack\"\n RightEdge = <unnamed> {\n }\n LeftEdge = <unnamed> {\n }\n BottomEdge = <unnamed> {\n }\n content = <table> {\n }\n HasBackdropInfo = <function> defined @Interface\\SharedXML\\Backdrop.lua:270\n SetBorderBlendMode = <function> defined @Interface\\SharedXML\\Backdrop.lua:258\n BottomRightCorner = <unnamed> {\n }\n BottomLeftCorner = <unnamed> {\n }\n sections = <table> {\n }\n TopRightCorner = <unnamed> {\n }\n HeaderRightRegion = AdiBagsSimpleLayeredRegion2 {\n }\n added = <table> {\n }\n ToSortSection = AdiBagsSection1 {\n }\n TopLeftCorner = <unnamed> {\n }\n stacks = <table> {\n }\n SetupTextureCoordinates = <function> defined @Interface\\SharedXML\\Backdrop.lua:206\n OnBackdropSizeChanged = <function> defined @Interface\\SharedXML\\Backdrop.lua:174\n Anchor = AdiBagsBagAnchor1 {\n }\n backdropInfo = <table> {\n }\n BagSlotPanel = AdiBagsContainer1Bags {\n }\n SetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:321\n GetEdgeSize = <function> defined @Interface\\SharedXML\\Backdrop.lua:180\n changed = <table> {\n }\n buttons = <table> {\n }\n TopEdge = <unnamed> {\n }\n GetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:339\n removed = <table> {\n }\n widgets = <table> {\n }\n beautyShadow = <table> {\n }\n CloseButton = <unnamed> {\n }\n Title = AdiBagsContainer1Title {\n }\n bagObject = <table> {\n }\n SetupPieceVisuals = <function> defined @Interface\\SharedXML\\Backdrop.lua:238\n SetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:391\n Content = <unnamed> {\n }\n BottomRightRegion = AdiBagsSimpleLayeredRegion4 {\n }\n}\nkind = \"item\"\ndata1 = 2512\ndata2 = \"|cffffffff|Hitem:2512::::::::11:::::::::|h[Rough Arrow]|h|r\"\nitemLink = \"|cffffffff|Hitem:2512::::::::11:::::::::|h[Rough Arrow]|h|r\"\nslotId = 101\nbutton = AdiBagsStackButton1 {\n 0 = <userdata>\n acquired = true\n slots = <table> {\n }\n key = \"*Free*#1\"\n count = 0\n section = AdiBagsSection2 {\n }\n GetCountHook = <function> defined @Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:450\n dirtyCount = true\n container = AdiBagsContainer1 {\n }\n}\nbutton = nil\n(*temporary) = <function> defined @Interface\\AddOns\\AdiBags\\core\\Core.lua:60\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'button' (a nil value)\"\nGetCursorInfo = <function> defined =[C]:-1\nGetMerchantItemLink = <function> defined =[C]:-1\naddon = <table> {\n AcquireItemButton = <function> defined @Interface\\AddOns\\AdiBags\\widgets\\ItemButton.lua:153\n modules = <table> {\n }\n UpdateFilters = <function> defined @Interface\\AddOns\\AdiBags\\core\\Filters.lua:86\n SecureHook = <function> defined @Interface\\AddOns\\BlizzMove\\Libs\\AceHook-3.0\\AceHook-3.0.lua:336\n GetInteractingWindow = <function> defined @Interface\\AddOns\\AdiBags\\core\\Core.lua:469\n ConfigChanged = <function> defined @Interface\\AddOns\\AdiBags\\core\\Core.lua:389\n GetSlotId = <function> defined @Interface\\AddOns\\AdiBags\\core\\Utility.lua:56\n Filter = <function> defined @Interface\\AddOns\\AdiBags\\core\\Filters.lua:147\n IsEnabled = <function> defined @Interface\\AddOns\\BlizzMove\\Libs\\AceAddon-3.0\\AceAddon-3.0.lua:451\n Reconfigure = <function> defined @Interface\\AddOns\\AdiBags\\core\\Core.lua:205\n SetupTooltip = <function> defined @Interface\\AddOns\\AdiBags\\core\\Utility.lua:113\n RegisterMessage = <function> defined @Interface\\AddOns\\AdiBags\\libs\\Callback",
			["stack"] = "[string \"@Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua\"]:466: in function <Interface\\AddOns\\AdiBags\\widgets\\ContainerFrame.lua:446>\n[string \"=(tail call)\"]: ?",
			["session"] = 3702,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "[string \"GameTooltip:OnEnter\"]:3: Usage: GameTooltip:SetText(\"text\" [, color, wrap])",
			["time"] = "2021/12/26 12:15:53",
			["locals"] = "(*temporary) = GameTooltip {\n 0 = <userdata>\n beautyShadow = <table> {\n }\n GetBackdropColor = <function> defined @Interface\\SharedXML\\SharedTooltipTemplates.lua:182\n SetHyperlink = <function> defined =[C]:-1\n SetGuildBankItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetVoidItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetBackdropBorderColor = <function> defined @Interface\\AddOns\\Lorti UI Classic\\core\\frames.lua:213\n SetVoidDepositItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetVoidWithdrawalItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n questOrder = <table> {\n }\n comparing = false\n beautyBorder = <table> {\n }\n TopOverlay = <unnamed> {\n }\n GetBackdropBorderColor = <function> defined @Interface\\SharedXML\\SharedTooltipTemplates.lua:190\n npcOrder = <table> {\n }\n _owner = QuestieFrame15 {\n }\n TMW_SetEquiv = <function> defined @Interface\\AddOns\\TellMeWhen\\Options\\TellMeWhen_Options.lua:165\n SetLootItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetQuestItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n manualOrder = <table> {\n }\n SetBorderBlendMode = <function> defined @Interface\\SharedXML\\SharedTooltipTemplates.lua:194\n blockInspectRequests = false\n miniMapIcon = false\n SetLootRollItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n TMW_SetDogTag = <function> defined @Interface\\AddOns\\TellMeWhen\\Components\\Core\\Common\\DogTags\\config.lua:403\n SetInboxItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetBuybackItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n shoppingTooltips = <table> {\n }\n SetRecipeReagentItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetMerchantItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetQuestLogItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n layoutType = \"TooltipDefaultLayout\"\n SetTradeTargetItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n Background = NeavBackground {\n }\n SetTradePlayerItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n TMW_SetSpellByIDWithClassIcon = <function> defined @Interface\\AddOns\\TellMeWhen\\Components\\Core\\Spells\\ClassSpellCache.lua:189\n SetSendMailItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetMerchantCostItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n updateTooltip = 0.150000\n SetInventoryItem = <function> defined =[C]:-1\n BottomOverlay = <unnamed> {\n }\n NineSlice = <unnamed> {\n }\n TooltipBackdropOnLoad = <function> defined @Interface\\SharedXML\\SharedTooltipTemplates.lua:163\n inspectCache = <table> {\n }\n SetRecipeResultItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetAuctionSellItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetBagItem = <function> defined =[C]:-1\n needsReset = true\n SetAction = <function> defined =[C]:-1\n SetBackdropColor = <function> defined @Interface\\SharedXML\\SharedTooltipTemplates.lua:178\n TMW_SetFrameHighlight = <function> defined @Interface\\AddOns\\TellMeWhen\\Components\\GroupModules\\GroupModule_GroupPosition\\Config.lua:193\n SetAuctionItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipC",
			["stack"] = "[string \"=[C]\"]: in function `SetText'\n[string \"*:OnEnter\"]:3: in function <[string \"*:OnEnter\"]:1>",
			["session"] = 3702,
			["counter"] = 2,
		}, -- [4]
		{
			["message"] = "Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:172: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2021/12/26 21:07:47",
			["locals"] = "self = ClassicCastbars {\n NAME_PLATE_UNIT_REMOVED = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:477\n StoreCast = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:183\n CreateOrUpdateSecureFocusButton = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:519\n PLAYER_ENTERING_WORLD = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:351\n SkinPlayerCastbar = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:415\n ToggleUnitEvents = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:319\n DeleteCast = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:241\n NAME_PLATE_UNIT_ADDED = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:466\n DisplayCastbar = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:289\n SetBorderShieldStyle = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:103\n AnchorManager = <table> {\n }\n SetFocusDisplay = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:567\n StartCast = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:139\n SetCastbarFonts = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:239\n CheckCastModifiers = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:71\n SetCastbarIconAndText = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:80\n activeFrames = <table> {\n }\n CastPushback = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:258\n StopCast = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:153\n GROUP_ROSTER_UPDATE = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:488\n GetCastbarFrame = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:31\n HideCastbar = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:325\n SetTargetCastbarPosition = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:44\n db = <table> {\n }\n UNIT_AURA = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:444\n ClearFocus = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:550\n PLAYER_GUID = \"Player-5239-013D6C3C\"\n SetCastbarStatusColorsOnDisplay = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:276\n CreateFadeAnimationGroup = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:262\n ZONE_CHANGED_NEW_AREA = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:366\n 0 = <userdata>\n GROUP_JOINED = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:488\n SetLSMBorders = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:214\n SetCastbarStyle = <function> defined @Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:151\n defaultConfig = <table> {\n }\n activeTimers = <table> {\n }\n StartAllCasts = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:164\n COMBAT_LOG_EVENT_UNFILTERED = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:522\n npcCastUninterruptibleCache = <table> {\n }\n StopAllCasts = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:174\n GetUnitType = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:60\n PLAYER_TARGET_CHANGED = <function> defined @Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:459\n}\ncastbar = <unnamed> {\n 0 = <userdata>\n animationGroup = <unnamed> {\n }\n Border = <unnamed> {\n }\n Flash = <unnamed> {\n }\n showCastbar = true\n _data = <table> {\n }\n Background = <unnamed> {\n }\n Icon = <unnamed> {\n }\n startChannelColor = <table> {\n }\n finishedCastColor = <table> {\n }\n nonInterruptibleColor = <table> {\n }\n Text = <unnamed> {\n }\n fade = <unnamed> {\n }\n currWidth = 400\n Timer = <unnamed> {\n }\n BorderShield = <unnamed> {\n }\n Spark = <unnamed> {\n }\n startCastColor = <table> {\n }\n flashColorSameAsStart = true\n finishedColorSameAsStart = true\n failedCastColor = <",
			["stack"] = "[string \"@Interface\\AddOns\\ClassicCastbars\\core/Frames.lua\"]:172: in function `SetCastbarStyle'\n[string \"@Interface\\AddOns\\ClassicCastbars\\core/Frames.lua\"]:303: in function `DisplayCastbar'\n[string \"@Interface\\AddOns\\ClassicCastbars\\ClassicCastbars-v1.4.3.lua\"]:150: in function `StartCast'\n[string \"@Interface\\AddOns\\ClassicCastbars\\ClassicCastbars-v1.4.3.lua\"]:169: in function `StartAllCasts'\n[string \"@Interface\\AddOns\\ClassicCastbars\\ClassicCastbars-v1.4.3.lua\"]:237: in function <Interface\\AddOns\\ClassicCastbars\\ClassicCastbars.lua:183>\n[string \"=(tail call)\"]: ?\n[string \"=(tail call)\"]: ?",
			["session"] = 3709,
			["counter"] = 1,
		}, -- [5]
		{
			["message"] = "[string \"TargetFrame.1ac84ecb4a0.Icon:CreateBeautyBorder(6)\"]:1: malformed number near '.1ac84ecb4a0'",
			["time"] = "2021/12/26 21:24:36",
			["locals"] = "(*temporary) = \"TargetFrame.1ac84ecb4a0.Icon:CreateBeautyBorder(6)\"\n",
			["stack"] = "[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4532: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 3713,
			["counter"] = 1,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\ClassicCastbars\\core/Frames.lua:93: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2021/12/26 21:05:15",
			["stack"] = "[string \"@Interface\\AddOns\\ClassicCastbars\\core/Frames.lua\"]:93: in function `SetCastbarIconAndText'\n[string \"@Interface\\AddOns\\ClassicCastbars\\core/Frames.lua\"]:304: in function `DisplayCastbar'\n[string \"@Interface\\AddOns\\ClassicCastbars_Options\\TestMode.lua\"]:173: in function `SetCastbarMovable'\n[string \"@Interface\\AddOns\\ClassicCastbars_Options\\TestMode.lua\"]:96: in function `ToggleCastbarMovable'\n[string \"@Interface\\AddOns\\ClassicCastbars_Options\\ClassicCastbars_Options-v1.4.3.lua\"]:548: in function <...\\ClassicCastbars_Options\\ClassicCastbars_Options.lua:548>\n[string \"=[C]\"]: ?\n[string \"@Interface\\AddOns\\BlizzMove\\Libs\\AceConfig-3.0-3\\AceConfigDialog-3.0\\AceConfigDialog-3.0-82.lua\"]:51: in function <...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:49>\n[string \"@Interface\\AddOns\\BlizzMove\\Libs\\AceConfig-3.0-3\\AceConfigDialog-3.0\\AceConfigDialog-3.0-82.lua\"]:847: in function <...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:668>\n[string \"=[C]\"]: ?\n[string \"@Interface\\AddOns\\BlizzMove\\Libs\\AceGUI-3.0\\AceGUI-3.0-41.lua\"]:72: in function <...face\\AddOns\\BlizzMove\\Libs\\AceGUI-3.0\\AceGUI-3.0.lua:70>\n[string \"@Interface\\AddOns\\BlizzMove\\Libs\\AceGUI-3.0\\AceGUI-3.0-41.lua\"]:306: in function `Fire'\n[string \"@Interface\\AddOns\\BlizzMove\\Libs\\AceGUI-3.0-41\\widgets\\AceGUIWidget-Button.lua\"]:22: in function <...Move\\Libs\\AceGUI-3.0\\widgets\\AceGUIWidget-Button.lua:19>",
			["session"] = 3714,
			["counter"] = 8,
		}, -- [7]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:288: attempt to index local 'a' (a nil value)",
			["time"] = "2021/12/27 20:24:23",
			["locals"] = "a = nil\nb = <table> {\n conj = false\n name = \"Freshly Baked Bread\"\n lvl = 5\n id = 4541\n hp = 243.600000\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'a' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:288: in function <Interface\\AddOns\\xVermin\\BestFood.lua:287>\n[string \"=[C]\"]: in function `sort'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:165: in function `Sorted'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:112: in function `UpdateMacros'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:53: in function <Interface\\AddOns\\xVermin\\BestFood.lua:48>",
			["session"] = 3720,
			["counter"] = 9,
		}, -- [8]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:290: attempt to index local 'b' (a nil value)",
			["time"] = "2021/12/25 16:46:03",
			["locals"] = "a = <table> {\n conj = false\n name = \"Tough Jerky\"\n lvl = 6\n id = 117\n hp = 61.200000\n}\nb = nil\n(*temporary) = false\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'b' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:290: in function <Interface\\AddOns\\xVermin\\BestFood.lua:287>\n[string \"=[C]\"]: in function `sort'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:165: in function `Sorted'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:112: in function `UpdateMacros'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:56: in function <Interface\\AddOns\\xVermin\\BestFood.lua:48>",
			["session"] = 3720,
			["counter"] = 128,
		}, -- [9]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:308: attempt to index local 'b' (a nil value)",
			["time"] = "2021/12/27 20:54:16",
			["locals"] = "a = <table> {\n id = 4537\n type = \"Fruit\"\n}\nb = nil\n(*temporary) = 1\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = 1\n(*temporary) = \"attempt to index local 'b' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:308: in function <Interface\\AddOns\\xVermin\\BestFood.lua:307>\n[string \"=[C]\"]: in function `sort'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:165: in function `Sorted'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:113: in function `UpdateMacros'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:53: in function <Interface\\AddOns\\xVermin\\BestFood.lua:48>",
			["session"] = 3722,
			["counter"] = 12,
		}, -- [10]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Frames/TalentFrame.lua:22: Usage: hooksecurefunc([table,] \"function\", hookfunc)",
			["time"] = "2021/12/25 17:43:06",
			["locals"] = "(*temporary) = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface_Vanilla\\FrameXML\\ActionButton.lua:70\n ActionButton7FlyoutBorder = ActionButton7FlyoutBorder {\n }\n GuildScrollFrameEntry11LeftText = GuildScrollFrameEntry11LeftText {\n }\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 776\n WeakAurasDisplayButton15ToggleHighlightTexture = WeakAurasDisplayButton15ToggleHighlightTexture {\n }\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n Atr_StackPriceCopperMiddle = Atr_StackPriceCopperMiddle {\n }\n InspectFrameTab1HighlightTexture = InspectFrameTab1HighlightTexture {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n OPTION_TOOLTIP_SHOW_MULTIBAR4 = \"Toggles an additional optional actionbar on the right side of the screen.\"\n GuildScrollFrameEntry20 = GuildScrollFrameEntry20 {\n }\n LE_GAME_ERR_INVALID_FOLLOW_PVP_COMBAT = 353\n MerchantItem3AltCurrencyFrameItem1Text = MerchantItem3AltCurrencyFrameItem1Text {\n }\n DetailsWindowOptionsBarTextEditorEntryNumberLines = DetailsWindowOptionsBarTextEditorEntryNumberLines {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n INSTANCE_UNAVAILABLE_OTHER_TEMPORARILY_DISABLED = \"%s cannot enter. This instance is temporarily disabled.\"\n DetailsOptionsWindow16UserTimeCapturesAddPanelFuncEntry = DetailsOptionsWindow16UserTimeCapturesAddPanelFuncEntry {\n }\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n RaidGroupButton9RoleTexture = RaidGroupButton9RoleTexture {\n }\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface_Vanilla\\FrameXML\\UnitFrame.lua:595\n MANA = \"Mana\"\n CraftExpandTabLeft = CraftExpandTabLeft {\n }\n AuctionsButton2ItemIconTexture = AuctionsButton2ItemIconTexture {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2379\n MoneyFrame_OnEvent = <function> defined @Interface\\FrameXML\\MoneyFrame.lua:214\n HubPanelProfileDefaultWidgetEliteIndicatorText = HubPanelProfileDefaultWidgetEliteIndicatorText {\n }\n AutoCompleteEditBox_OnKeyDown = <function> defined @Interface\\FrameXML\\AutoComplete.lua:368\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n GetMonitorAspectRatio = <function> defined =[C]:-1\n Button_WorldTogglePushedTexture = Button_WorldTogglePushedTexture {\n }\n AdiBagsItemButton4IconQuestTexture = AdiBagsItemButton4IconQuestTexture {\n }\n PetStableMoneyFrameGoldButtonText = PetStableMoneyFrameGoldButtonText {\n }\n TargetFrameDebuff2Icon = TargetFrameDebuff2Icon {\n }\n questieLineFrame38 = questieLineFrame38 {\n }\n VOICEMACRO_4_Sc_1_FEMALE = \"Help me attack!\"\n JoinSkirmish = <function> defined =[C]:-1\n StanceButton4FlyoutArrow = StanceButton4FlyoutArrow {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n HubPanelProfileDefaultHideAuraDuration = HubPanelProfileDefaultHideAuraDuration {\n }\n DMG_LCD = \"DMG\"\n ACTION_SPELL_MISSED_POSSESSIVE = \"1\"\n HubPanelProfileDefaultFriendlyNameColorMode = HubPanelProfileDefaultFriendlyNameColorMode {\n }\n BattlefieldMapFrameLeft = BattlefieldMapFrameLeft {\n }\n Advanced_AdapterDropDownWarning = Advanced_AdapterDropDownWarning {\n }\n SecureCmdItemParse = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1123\n TELLMEWHEN_VERSION_FULL = \"9.1.2 Classic \"\n DetailsOptionsWindow1ClassColorsButton_TextureDisabled = DetailsOptionsWindow1ClassColorsButton_TextureDisabled {\n }\n SortQuestWatches = <function> defined =[C]:-1\n ContainerFrame4Item16Cooldown = ContainerFrame4Item16Cooldown {\n }\n MINIMAP_TRACKING_TRAINER_CLASS = \"Class Trainer\"\n DetailsOptionsWindow3C",
			["stack"] = "[string \"=[C]\"]: in function `hooksecurefunc'\n[string \"@Interface\\AddOns\\xVermin\\Frames/TalentFrame.lua\"]:22: in function <Interface\\AddOns\\xVermin\\Frames/TalentFrame.lua:20>\n[string \"=[C]\"]: in function `LoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:365: in function `UIParentLoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:424: in function `PlayerTalentFrame_LoadUI'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:501: in function `ToggleTalentFrame'\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 3724,
			["counter"] = 9,
		}, -- [11]
		{
			["message"] = "...e\\AddOns\\xVermin\\Frames/DefaultFramesCustomScale.lua:45: attempt to index field '?' (a nil value)",
			["time"] = "2021/12/25 17:43:06",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n}\nevent = \"ADDON_LOADED\"\nframelist = <table> {\n 1 = \"TalentFrame\"\n}\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = \"TalentFrame\"\n}\n(for control) = 1\n_ = 1\nname = \"TalentFrame\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"TalentFrame\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index field '?' (a nil value)\"\nLoDMap = <table> {\n Blizzard_InspectUI = <table> {\n }\n Blizzard_TradeSkillUI = <table> {\n }\n Blizzard_MacroUI = <table> {\n }\n Blizzard_TalentUI = <table> {\n }\n Blizzard_CraftUI = <table> {\n }\n}\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Frames/DefaultFramesCustomScale.lua\"]:45: in function <...e\\AddOns\\xVermin\\Frames/DefaultFramesCustomScale.lua:40>\n[string \"=[C]\"]: in function `LoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:365: in function `UIParentLoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:424: in function `PlayerTalentFrame_LoadUI'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:501: in function `ToggleTalentFrame'\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 3725,
			["counter"] = 10,
		}, -- [12]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Frames/TalentFrame.lua:21: Usage: hooksecurefunc([table,] \"function\", hookfunc)",
			["time"] = "2021/12/28 08:34:30",
			["locals"] = "(*temporary) = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface_Vanilla\\FrameXML\\ActionButton.lua:70\n ERR_OUT_OF_CHI = \"Not enough chi\"\n DH_HAVOC_CORE_ABILITY_2 = \"Strong melee attack that consumes Fury. If it critical strikes, some Fury is refunded.\"\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 776\n SPELL_FAILED_CUSTOM_ERROR_71 = \"This partygoer wants to dance with you.\"\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n GuildScrollFrameEntry660 = GuildScrollFrameEntry660 {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n InterfaceOptionsNamesPanelUnitNameplatesShowAll = InterfaceOptionsNamesPanelUnitNameplatesShowAll {\n }\n GuildScrollFrameEntry20 = GuildScrollFrameEntry20 {\n }\n VideoOptionsFrameDefaults = VideoOptionsFrameDefaults {\n }\n MerchantItem2AltCurrencyFrameItem1Text = MerchantItem2AltCurrencyFrameItem1Text {\n }\n DetailsWindowOptionsBarTextEditorEntryNumberLines = DetailsWindowOptionsBarTextEditorEntryNumberLines {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n CHAT_HEADER_SUFFIX = \": \"\n Atr_StackList9 = Atr_StackList9 {\n }\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n IsReferAFriendLinked = <function> defined =[C]:-1\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface_Vanilla\\FrameXML\\UnitFrame.lua:595\n DUNGEON_FLOOR_UPPERBLACKROCKSPIRE3 = \"Hall of Blackhand\"\n CraftExpandTabLeft = CraftExpandTabLeft {\n }\n CHAT_CONFIG_OTHER_COMBAT = <table> {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2379\n BOOST2_WARRIOR_COLOSSUSSMASH = \"Use |cFFFFFFFFColossus Smash|r.\n\n|cFFFFFFFFColossus Smash|r increases your damage.\"\n BN_UNABLE_TO_RESOLVE_NAME = \"Unable to whisper '%s'. Blizzard services may be unavailable.\"\n AutoCompleteEditBox_OnKeyDown = <function> defined @Interface\\FrameXML\\AutoComplete.lua:368\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n SpellButton6Cooldown = SpellButton6Cooldown {\n }\n SLASH_LibQTip1 = \"/qtip\"\n AdiBagsItemButton4IconQuestTexture = AdiBagsItemButton4IconQuestTexture {\n }\n LOSS_OF_CONTROL_DISPLAY_FEAR = \"Feared\"\n Graphics_QualityText = Graphics_QualityText {\n }\n questieLineFrame38 = questieLineFrame38 {\n }\n ROGUE_COMBAT_CORE_ABILITY_4 = \"Melee ability with an increased range that consumes Combo Points.\"\n JoinSkirmish = <function> defined =[C]:-1\n Advanced_GraphicsAPIDropDownButtonHighlightTexture = Advanced_GraphicsAPIDropDownButtonHighlightTexture {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n BankFrameItem17SearchOverlay = BankFrameItem17SearchOverlay {\n }\n DMG_LCD = \"DMG\"\n RaidGraphics_EnvironmentalDetailSlider = RaidGraphics_EnvironmentalDetailSlider {\n }\n HubPanelProfileDefaultFriendlyNameColorMode = HubPanelProfileDefaultFriendlyNameColorMode {\n }\n BattlefieldMapFrameLeft = BattlefieldMapFrameLeft {\n }\n Is64BitClient = <function> defined =[C]:-1\n SecureCmdItemParse = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1123\n SLASH_STOPATTACK1 = \"/stopattack\"\n SortQuestWatches = <function> defined =[C]:-1\n ContainerFrame4Item16Cooldown = ContainerFrame4Item16Cooldown {\n }\n MINIMAP_TRACKING_TRAINER_CLASS = \"Class Trainer\"\n SLASH_DISMOUNT2 = \"/dismount\"\n DUNGEON_FLOOR_DRAGONBLIGHTCHROMIESCENARIO2 = \"Andorhal\"\n PlayerFrame_UpdateReadyCheck = <function> defined @Interface\\FrameXML\\PlayerFrame.lua:345\n EMOTE69_CMD1 = \"/nosepick\"\n WowTokenRedemptionFrameBg = WowTokenRedemptionFrameBg {\n }\n SHIELD_BLOCK_TEMPLATE = \"%d Block\"\n LAG_TOLERANCE = \"Lag Tolerance\"\n GuildCo",
			["stack"] = "[string \"=[C]\"]: in function `hooksecurefunc'\n[string \"@Interface\\AddOns\\xVermin\\Frames/TalentFrame.lua\"]:21: in function <Interface\\AddOns\\xVermin\\Frames/TalentFrame.lua:19>\n[string \"=[C]\"]: in function `LoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:365: in function `UIParentLoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:424: in function `PlayerTalentFrame_LoadUI'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:501: in function `ToggleTalentFrame'\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 3725,
			["counter"] = 1,
		}, -- [13]
		{
			["message"] = "...e\\AddOns\\xVermin\\Frames/DefaultFramesCustomScale.lua:47: attempt to index field '?' (a nil value)",
			["time"] = "2021/12/28 08:34:52",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n}\nevent = \"ADDON_LOADED\"\nframelist = <table> {\n 1 = \"TalentFrame\"\n}\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = \"TalentFrame\"\n}\n(for control) = 1\n_ = 1\nname = \"TalentFrame\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"TalentFrame\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index field '?' (a nil value)\"\nLoDMap = <table> {\n Blizzard_InspectUI = <table> {\n }\n Blizzard_TradeSkillUI = <table> {\n }\n Blizzard_MacroUI = <table> {\n }\n Blizzard_TalentUI = <table> {\n }\n Blizzard_CraftUI = <table> {\n }\n}\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Frames/DefaultFramesCustomScale.lua\"]:47: in function <...e\\AddOns\\xVermin\\Frames/DefaultFramesCustomScale.lua:42>\n[string \"=[C]\"]: in function `LoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:365: in function `UIParentLoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:424: in function `PlayerTalentFrame_LoadUI'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:501: in function `ToggleTalentFrame'\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 3726,
			["counter"] = 1,
		}, -- [14]
		{
			["message"] = "[string \"/rl\"]:1: unexpected symbol near '/'",
			["time"] = "2021/12/28 11:06:39",
			["locals"] = "(*temporary) = \"/rl\"\n",
			["stack"] = "[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4532: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 3729,
			["counter"] = 1,
		}, -- [15]
		{
			["message"] = "[string \"MerchantItems2:CreateBeautyBorder(8)\"]:1: attempt to index global 'MerchantItems2' (a nil value)",
			["time"] = "2021/12/28 11:08:12",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'MerchantItems2' (a nil value)\"\n",
			["stack"] = "[string \"MerchantItems2:CreateBeautyBorder(8)\"]:1: in main chunk\n[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4532: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 3731,
			["counter"] = 1,
		}, -- [16]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:207: attempt to call method 'SetBackdrop' (a nil value)",
			["time"] = "2021/12/28 18:59:46",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n}\nevent = \"PLAYER_ENTERING_WORLD\"\nisInitialLogin = false\nisReloadingUi = true\n(*temporary) = nil\n(*temporary) = Puggle_ContainerFrame {\n 0 = <userdata>\n numTabs = 5\n beautyShadow = <table> {\n }\n elapsed = 0\n selectedTab = 1\n beautyBorder = <table> {\n }\n}\n(*temporary) = <table> {\n bgFile = \"Interface\\Buttons\\WHITE8x8\"\n tileSize = 0\n edgeFile = \"\"\n tile = false\n edgeSize = 0\n insets = <table> {\n }\n}\n(*temporary) = \"attempt to call method 'SetBackdrop' (a nil value)\"\nxVermin = <table> {\n LogBreak = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:56\n FormatNumber = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:90\n Debug = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:14\n Color = <table> {\n }\n Class = \"HUNTER\"\n FormatValue = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:82\n ClassColor = <table> {\n }\n Config = <table> {\n }\n AOE = <function> defined @Interface\\AddOns\\xVermin\\Rotation/_Core.lua:3\n Log = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:41\n Round = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:107\n TimeFormat = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:134\n ColorGradient = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:119\n}\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:207: in function <Interface\\AddOns\\xVermin\\xVermin.lua:7>",
			["session"] = 3741,
			["counter"] = 1,
		}, -- [17]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:219: unexpected symbol near ')'",
			["time"] = "2021/12/28 19:00:40",
			["locals"] = "",
			["stack"] = "",
			["session"] = 3742,
			["counter"] = 4,
		}, -- [18]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:222: unexpected symbol near ')'",
			["time"] = "2021/12/28 19:01:33",
			["locals"] = "",
			["stack"] = "",
			["session"] = 3743,
			["counter"] = 4,
		}, -- [19]
		{
			["message"] = "[string \"PuggleLib_DropDownList1MenuBackdrop:OnLoad\"]:1: attempt to call method 'SetBackdropBorderColor' (a nil value)",
			["time"] = "2021/12/28 18:57:39",
			["locals"] = "self = PuggleLib_DropDownList1MenuBackdrop {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = PuggleLib_DropDownList1MenuBackdrop {\n 0 = <userdata>\n}\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = \"attempt to call method 'SetBackdropBorderColor' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 3744,
			["counter"] = 5,
		}, -- [20]
		{
			["message"] = "[string \"PuggleLib_DropDownList2MenuBackdrop:OnLoad\"]:1: attempt to call method 'SetBackdropBorderColor' (a nil value)",
			["time"] = "2021/12/28 18:57:39",
			["locals"] = "self = PuggleLib_DropDownList2MenuBackdrop {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = PuggleLib_DropDownList2MenuBackdrop {\n 0 = <userdata>\n}\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = 1\n(*temporary) = \"attempt to call method 'SetBackdropBorderColor' (a nil value)\"\n",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 3744,
			["counter"] = 5,
		}, -- [21]
		{
			["message"] = "Interface\\AddOns\\ItemRack\\ItemRack-3.69.nil.lua:1963: Usage: SaveBindings(1||2)",
			["time"] = "2021/12/29 10:50:52",
			["locals"] = "(*temporary) = 0\n",
			["stack"] = "[string \"=[C]\"]: in function `SaveBindings'\n[string \"@Interface\\AddOns\\ItemRack\\ItemRack-3.69.nil.lua\"]:1963: in function `SetSetBindings'\n[string \"@Interface\\AddOns\\ItemRack\\ItemRack-3.69.nil.lua\"]:233: in function `?'\n[string \"@Interface\\AddOns\\ItemRack\\ItemRack-3.69.nil.lua\"]:198: in function `OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 3748,
			["counter"] = 1,
		}, -- [22]
		{
			["message"] = "...Puggle\\Libs\\NoTaintUIDropDownMenu\\UIDropDownMenu.lua:1101: attempt to index local 'frame' (a nil value)",
			["time"] = "2021/12/29 10:54:02",
			["locals"] = "frame = nil\ntext = \"Pitchwise - Wednesday December 29, 2021 at 10:54 - The Barrens\"\n(*temporary) = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface_Vanilla\\FrameXML\\ActionButton.lua:70\n puggletags_STL_pick = puggletags_STL_pick {\n }\n ERR_OUT_OF_CHI = \"Not enough chi\"\n DH_HAVOC_CORE_ABILITY_2 = \"Strong melee attack that consumes Fury. If it critical strikes, some Fury is refunded.\"\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 776\n SPELL_FAILED_CUSTOM_ERROR_71 = \"This partygoer wants to dance with you.\"\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n GuildScrollFrameEntry660 = GuildScrollFrameEntry660 {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n InterfaceOptionsNamesPanelUnitNameplatesShowAll = InterfaceOptionsNamesPanelUnitNameplatesShowAll {\n }\n GuildScrollFrameEntry20 = GuildScrollFrameEntry20 {\n }\n VideoOptionsFrameDefaults = VideoOptionsFrameDefaults {\n }\n MerchantItem2AltCurrencyFrameItem1Text = MerchantItem2AltCurrencyFrameItem1Text {\n }\n DetailsWindowOptionsBarTextEditorEntryNumberLines = DetailsWindowOptionsBarTextEditorEntryNumberLines {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n CHAT_HEADER_SUFFIX = \": \"\n Atr_StackList9 = Atr_StackList9 {\n }\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n IsReferAFriendLinked = <function> defined =[C]:-1\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface_Vanilla\\FrameXML\\UnitFrame.lua:595\n DUNGEON_FLOOR_UPPERBLACKROCKSPIRE3 = \"Hall of Blackhand\"\n CraftExpandTabLeft = CraftExpandTabLeft {\n }\n CHAT_CONFIG_OTHER_COMBAT = <table> {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2379\n BOOST2_WARRIOR_COLOSSUSSMASH = \"Use |cFFFFFFFFColossus Smash|r.\n\n|cFFFFFFFFColossus Smash|r increases your damage.\"\n BN_UNABLE_TO_RESOLVE_NAME = \"Unable to whisper '%s'. Blizzard services may be unavailable.\"\n LE_GAME_ERR_RECRUIT_A_FRIEND_FAILED = 986\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n SpellButton6Cooldown = SpellButton6Cooldown {\n }\n SLASH_LibQTip1 = \"/qtip\"\n AdiBagsItemButton4IconQuestTexture = AdiBagsItemButton4IconQuestTexture {\n }\n LOSS_OF_CONTROL_DISPLAY_FEAR = \"Feared\"\n Graphics_QualityText = Graphics_QualityText {\n }\n questieLineFrame38 = questieLineFrame38 {\n }\n ROGUE_COMBAT_CORE_ABILITY_4 = \"Melee ability with an increased range that consumes Combo Points.\"\n JoinSkirmish = <function> defined =[C]:-1\n Advanced_GraphicsAPIDropDownButtonHighlightTexture = Advanced_GraphicsAPIDropDownButtonHighlightTexture {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n BankFrameItem17SearchOverlay = BankFrameItem17SearchOverlay {\n }\n DMG_LCD = \"DMG\"\n RaidGraphics_EnvironmentalDetailSlider = RaidGraphics_EnvironmentalDetailSlider {\n }\n HubPanelProfileDefaultFriendlyNameColorMode = HubPanelProfileDefaultFriendlyNameColorMode {\n }\n BattlefieldMapFrameLeft = BattlefieldMapFrameLeft {\n }\n Is64BitClient = <function> defined =[C]:-1\n SecureCmdItemParse = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1123\n SLASH_STOPATTACK1 = \"/stopattack\"\n Puggle_ContainerFrameTab3HighlightTexture = Puggle_ContainerFrameTab3HighlightTexture {\n }\n SortQuestWatches = <function> defined =[C]:-1\n ContainerFrame4Item16Cooldown = ContainerFrame4Item16Cooldown {\n }\n MINIMAP_TRACKING_TRAINER_CLASS = \"Class Trainer\"\n SLASH_DISMOUNT2 = \"/dismount\"\n DUNGEON_FLOOR_DRAGONBLIGHTCHROMIESCENARIO2 = \"Andorhal\"\n PlayerFrame_UpdateReadyCheck = <function> defined @Interface\\FrameXML\\PlayerFrame",
			["stack"] = "[string \"@Interface\\AddOns\\Puggle\\Libs\\NoTaintUIDropDownMenu\\UIDropDownMenu.lua\"]:1101: in function `Lib_UIDropDownMenu_SetText'\n[string \"@Interface\\AddOns\\Puggle\\Puggle-2.7.lua\"]:496: in function `Puggle_UpdateCurrentGroup'\n[string \"@Interface\\AddOns\\Puggle\\Puggle-2.7.lua\"]:417: in function `Puggle_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 3749,
			["counter"] = 1,
		}, -- [23]
		{
			["message"] = "Usage: CastSpellByName(name[, target])",
			["time"] = "2021/12/26 11:46:05",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `CastSpellByName'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:995: in function <Interface\\FrameXML\\ChatFrame.lua:923>\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:1238: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4813: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2918: in function <Interface\\FrameXML\\ChatFrame.lua:2911>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:341: in function `handler'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:623: in function `SecureActionButton_OnClick'\n[string \"@Interface_Vanilla\\FrameXML\\MultiActionBars.lua\"]:14: in function `MultiActionButtonDown'\n[string \"MULTIACTIONBAR4BUTTON11\"]:2: in function <[string \"MULTIACTIONBAR4BUTTON11\"]:1>",
			["session"] = 3749,
			["counter"] = 2,
		}, -- [24]
		{
			["message"] = "[string \"--[==[ Error in 'HC Autoshot CD':'initializ...\"]:28: attempt to index a nil value",
			["time"] = "2021/12/29 11:25:14",
			["stack"] = "[string \"=[C]\"]: in function `xpcall'\n[string \"@Interface\\AddOns\\WeakAuras\\AuraEnvironment.lua\"]:289: in function `ActivateAuraEnvironment'\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:759: in function `CreateFakeStates'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3777: in function `UpdateFakeStatesFor'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3753: in function `FakeStatesFor'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:2775: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:2666>\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:2795: in function `Add'\n[string \"@Interface\\AddOns\\WeakAuras\\Transmission.lua\"]:332: in function <Interface\\AddOns\\WeakAuras\\Transmission.lua:323>\n[string \"@Interface\\AddOns\\WeakAuras\\Transmission.lua\"]:475: in function <Interface\\AddOns\\WeakAuras\\Transmission.lua:392>",
			["session"] = 3755,
			["counter"] = 1,
		}, -- [25]
		{
			["message"] = "[string \"--[==[ Error in 'HC Autoshot CD' ]==] retur...\"]:14: attempt to index a nil value",
			["time"] = "2021/12/29 11:25:14",
			["stack"] = "[string \"=[C]\"]: in function `xpcall'\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:601: in function <Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:537>\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:761: in function `CreateFakeStates'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3777: in function `UpdateFakeStatesFor'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3753: in function `FakeStatesFor'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:2775: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:2666>\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:2795: in function `Add'\n[string \"@Interface\\AddOns\\WeakAuras\\Transmission.lua\"]:332: in function <Interface\\AddOns\\WeakAuras\\Transmission.lua:323>\n[string \"@Interface\\AddOns\\WeakAuras\\Transmission.lua\"]:475: in function <Interface\\AddOns\\WeakAuras\\Transmission.lua:392>",
			["session"] = 3755,
			["counter"] = 1,
		}, -- [26]
		{
			["message"] = "[string \"--[==[ Error in 'HC Autoshot CD' ]==] retur...\"]:4: attempt to index a nil value",
			["time"] = "2021/12/29 11:25:14",
			["stack"] = "[string \"=[C]\"]: in function `xpcall'\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:601: in function <Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:537>\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:761: in function `CreateFakeStates'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3777: in function `UpdateFakeStatesFor'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3753: in function `FakeStatesFor'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:2775: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:2666>\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:2795: in function `Add'\n[string \"@Interface\\AddOns\\WeakAuras\\Transmission.lua\"]:332: in function <Interface\\AddOns\\WeakAuras\\Transmission.lua:323>\n[string \"@Interface\\AddOns\\WeakAuras\\Transmission.lua\"]:475: in function <Interface\\AddOns\\WeakAuras\\Transmission.lua:392>",
			["session"] = 3755,
			["counter"] = 1,
		}, -- [27]
		{
			["message"] = "[string \"--[==[ Error in 'HC Autoshot Cast':'initial...\"]:11: attempt to index a nil value",
			["time"] = "2021/12/29 11:25:14",
			["stack"] = "[string \"=[C]\"]: in function `xpcall'\n[string \"@Interface\\AddOns\\WeakAuras\\AuraEnvironment.lua\"]:289: in function `ActivateAuraEnvironment'\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:759: in function `CreateFakeStates'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3777: in function `UpdateFakeStatesFor'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3753: in function `FakeStatesFor'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:2775: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:2666>\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:2795: in function `Add'\n[string \"@Interface\\AddOns\\WeakAuras\\Transmission.lua\"]:332: in function <Interface\\AddOns\\WeakAuras\\Transmission.lua:323>\n[string \"@Interface\\AddOns\\WeakAuras\\Transmission.lua\"]:475: in function <Interface\\AddOns\\WeakAuras\\Transmission.lua:392>",
			["session"] = 3755,
			["counter"] = 1,
		}, -- [28]
		{
			["message"] = "[string \"--[==[ Error in 'HC Autoshot Cast' ]==] ret...\"]:4: attempt to index a nil value",
			["time"] = "2021/12/29 11:25:14",
			["stack"] = "[string \"=[C]\"]: in function `xpcall'\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:601: in function <Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:537>\n[string \"@Interface\\AddOns\\WeakAuras\\GenericTrigger.lua\"]:761: in function `CreateFakeStates'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3777: in function `UpdateFakeStatesFor'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3753: in function `FakeStatesFor'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:2775: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:2666>\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:2795: in function `Add'\n[string \"@Interface\\AddOns\\WeakAuras\\Transmission.lua\"]:332: in function <Interface\\AddOns\\WeakAuras\\Transmission.lua:323>\n[string \"@Interface\\AddOns\\WeakAuras\\Transmission.lua\"]:475: in function <Interface\\AddOns\\WeakAuras\\Transmission.lua:392>",
			["session"] = 3755,
			["counter"] = 1,
		}, -- [29]
		{
			["message"] = "Interface\\SharedXML\\Backdrop.lua:200: TexCoord out of range",
			["time"] = "2021/12/29 11:25:14",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = 0.257813\n(*temporary) = Infinite\n(*temporary) = 0.367188\n(*temporary) = Infinite\n(*temporary) = 0.257813\n(*temporary) = 0.062500\n(*temporary) = 0.367188\n(*temporary) = 0.062500\n",
			["stack"] = "[string \"=[C]\"]: in function `SetTexCoord'\n[string \"@Interface\\SharedXML\\Backdrop.lua\"]:200: in function <Interface\\SharedXML\\Backdrop.lua:199>\n[string \"@Interface\\SharedXML\\Backdrop.lua\"]:232: in function `SetupTextureCoordinates'\n[string \"@Interface\\SharedXML\\Backdrop.lua\"]:176: in function <Interface\\SharedXML\\Backdrop.lua:174>\n[string \"=[C]\"]: in function `resume'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.0.5.lua\"]:3658: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3641>",
			["session"] = 3755,
			["counter"] = 2,
		}, -- [30]
		{
			["message"] = "...lMaster\\Core\\UI\\Elements\\SelectionScrollingTable.lua:124: assertion failed!",
			["time"] = "2021/12/30 14:26:20",
			["locals"] = "(*temporary) = false\n",
			["stack"] = "[string \"=[C]\"]: in function `assert'\n[string \"@Interface\\AddOns\\TradeSkillMaster\\Core\\UI\\Elements\\SelectionScrollingTable.lua\"]:124: in function <...lMaster\\Core\\UI\\Elements\\SelectionScrollingTable.lua:122>\n[string \"@Interface\\AddOns\\TradeSkillMaster\\External\\LibTSMClass\\LibTSMClass-1.lua\"]:208: in function `SetSelection'\n[string \"@Interface\\AddOns\\TradeSkillMaster\\Core\\UI\\Util\\TableRow.lua\"]:1197: in function `?'\n[string \"@Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Util\\ScriptWrapper.lua\"]:86: in function `ScriptHandlerCommon'\n[string \"@Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Util\\ScriptWrapper.lua\"]:37: in function <...ddOns\\TradeSkillMaster\\LibTSM\\Util\\ScriptWrapper.lua:36>\n[string \"@Interface\\AddOns\\TradeSkillMaster\\Core\\UI\\Util\\TableRow.lua\"]:1381: in function `?'\n[string \"@Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Util\\ScriptWrapper.lua\"]:86: in function `ScriptHandlerCommon'\n[string \"@Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Util\\ScriptWrapper.lua\"]:37: in function <...ddOns\\TradeSkillMaster\\LibTSM\\Util\\ScriptWrapper.lua:36>",
			["session"] = 3762,
			["counter"] = 1,
		}, -- [31]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:226: attempt to concatenate global 'Rollid' (a nil value)",
			["time"] = "2021/12/31 09:09:33",
			["locals"] = "_ = <unnamed> {\n 0 = <userdata>\n}\n_ = \"START_LOOT_ROLL\"\nid = 14\n_ = 133766\n_ = \"Ritual Cape of the Eagle\"\n_ = 1\nquality = 2\nbop = false\n_ = true\n_ = true\ncanDE = false\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Chat.lua:31\n(*temporary) = ChatFrame1 {\n GatherSelectedText = <function> defined =[C]:-1\n RefreshIfNecessary = <function> defined =[C]:-1\n OnPostShow = <function> defined =[C]:-1\n CalculateLineAlphaValueFromTimestamp = <function> defined =[C]:-1\n ScrollUp = <function> defined =[C]:-1\n tellTimer = 3944228.317000\n fadeDurationSecs = 3\n GetFading = <function> defined =[C]:-1\n IsTextCopyable = <function> defined =[C]:-1\n shouldFadeAfterInactivity = true\n SetIndentedWordWrap = <function> defined =[C]:-1\n init = 0\n GetJustifyV = <function> defined =[C]:-1\n ScrollToBottom = <function> defined =[C]:-1\n GetMaxLines = <function> defined =[C]:-1\n GetIndentedWordWrap = <function> defined =[C]:-1\n buttonSide = \"left\"\n GetFont = <function> defined =[C]:-1\n checkedGMOTD = true\n SetMaxLines = <function> defined =[C]:-1\n CalculateSelectingCharacterIndicesForVisibleLine = <function> defined =[C]:-1\n OnPostUpdate = <function> defined =[C]:-1\n RefreshDisplay = <function> defined =[C]:-1\n SetFontObject = <function> defined =[C]:-1\n textIsCopyable = false\n SetOnScrollChangedCallback = <function> defined =[C]:-1\n CalculateNumVisibleLines = <function> defined =[C]:-1\n overrideFadeTimestamp = 3944236.423000\n MarkDisplayDirty = <function> defined =[C]:-1\n GetMessageInfo = <function> defined =[C]:-1\n GetOnScrollChangedCallback = <function> defined =[C]:-1\n AtTop = <function> defined =[C]:-1\n GetFontObject = <function> defined =[C]:-1\n fontStringPool = <table> {\n }\n CanEffectivelyFade = <function> defined =[C]:-1\n OnPreSizeChanged = <function> defined =[C]:-1\n GetScrollOffset = <function> defined =[C]:-1\n GetSpacing = <function> defined =[C]:-1\n OnPreLoad = <function> defined =[C]:-1\n SetSpacing = <function> defined =[C]:-1\n name = \"General\"\n CalculateLineSpacing = <function> defined =[C]:-1\n AddMessage = <function> defined @Interface\\AddOns\\xVermin\\Chat.lua:31\n InitializeFontableFrame = <function> defined =[C]:-1\n GetShadowColor = <function> defined =[C]:-1\n isUninteractable = false\n SetOnTextCopiedCallback = <function> defined =[C]:-1\n mouseOutTime = 8.106000\n RemoveMessagesByPredicate = <function> defined =[C]:-1\n TransformMessages = <function> defined =[C]:-1\n SetShadowColor = <function> defined =[C]:-1\n buttonFrame = ChatFrame1ButtonFrame {\n }\n HasFontObject = <function> defined =[C]:-1\n isDocked = 1\n GetOnTextCopiedCallback = <function> defined =[C]:-1\n SetFading = <function> defined =[C]:-1\n OnPostHide = <function> defined =[C]:-1\n alternativeDefaultLanguage = \"Orcish\"\n isInitialized = 1\n GetNumVisibleLines = <function> defined =[C]:-1\n GetInsertMode = <function> defined =[C]:-1\n SetTimeVisible = <function> defined =[C]:-1\n hasOwnFontObject = true\n Clear = <function> defined =[C]:-1\n oldAlpha = 0\n channelList = <table> {\n }\n GetTimeVisible = <function> defined =[C]:-1\n MarkLayoutDirty = <function> defined =[C]:-1\n SetTextCopyable = <function> defined =[C]:-1\n BackFillMessage = <function> defined =[C]:-1\n UnpackageEntry = <function> defined =[C]:-1\n FontStringContainer = <unnamed> {\n }\n SetShadowOffset = <function> defined =[C]:-1\n messageTypeList = <table> {\n }\n flashTimer = 0\n timeVisibleSecs = 120\n PackageEntry = <function> defined =[C]:-1\n chatframe = ChatFrame1 {\n }\n MakeFontObjectCustom = <function> defined =[C]:-1\n SetPoint = <function> defined @Interface\\AddOns\\xVermin\\Chat.lua:178\n fontObject = table: 0x7f8268b90e00 {\n }\n SetInsertMode = <function> defined =[C]:-1\n mouseInTime = 0\n UpdateSelectingText = <function> defined =[C]:-1\n zoneChannelList = <table> {\n }\n SetScrollOffset = <function> defined =[C]:-1\n onDisplayRefreshedCallback = <function> defined =[C]:-1\n insertMode = 2\n ResetSelectingText = <function> defined =[C]:-1\n GetTextColor = <function> defined =[C]:-1\n CallOnDisplayRefreshed = <function> defined =[C]:-1\n 0 = <userdata>\n IsSelectingText = <function> defined =[C]:-1\n OnFontObjectUpdated = <func",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:226: in function <Interface\\AddOns\\xVermin\\xVermin.lua:220>",
			["session"] = 3768,
			["counter"] = 3,
		}, -- [32]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:225: attempt to concatenate global 'Rollid' (a nil value)",
			["time"] = "2021/12/31 09:14:18",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:225: in function <Interface\\AddOns\\xVermin\\xVermin.lua:220>",
			["session"] = 3769,
			["counter"] = 1,
		}, -- [33]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:229: cannot use '...' outside a vararg function near '...'",
			["time"] = "2021/12/31 09:29:16",
			["locals"] = "",
			["stack"] = "",
			["session"] = 3772,
			["counter"] = 8,
		}, -- [34]
		{
			["message"] = "[string \"ConfirmLootRoll()\"]:1: Usage: ConfirmLootRoll(id, rollType)",
			["time"] = "2021/12/31 09:40:53",
			["locals"] = "",
			["stack"] = "[string \"=[C]\"]: in function `ConfirmLootRoll'\n[string \"ConfirmLootRoll()\"]:1: in main chunk\n[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4532: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 3773,
			["counter"] = 1,
		}, -- [35]
		{
			["message"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:1117: attempt to call global 'TEXT' (a nil value)",
			["time"] = "2021/12/31 11:59:51",
			["locals"] = "info = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"All Slots\"\n(*temporary) = \"attempt to call global 'TEXT' (a nil value)\"\natsw_currentinvslotfilter = <table> {\n}\n",
			["stack"] = "[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua\"]:1117: in function `ATSWFilterFrame_LoadInvSlots'\n[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua\"]:1112: in function `initFunction'\n[string \"@Interface\\FrameXML\\UIDropDownMenu.lua\"]:79: in function `UIDropDownMenu_Initialize'\n[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua\"]:1099: in function `ATSWInvSlotDropDown_OnLoad'\n[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 3775,
			["counter"] = 1,
		}, -- [36]
		{
			["message"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua:1072: attempt to call global 'TEXT' (a nil value)",
			["time"] = "2021/12/31 11:59:51",
			["locals"] = "info = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"All Subclasses\"\n(*temporary) = \"attempt to call global 'TEXT' (a nil value)\"\natsw_currentsubclassfilter = <table> {\n}\n",
			["stack"] = "[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua\"]:1072: in function `ATSWFilterFrame_LoadSubClasses'\n[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua\"]:1067: in function `initFunction'\n[string \"@Interface\\FrameXML\\UIDropDownMenu.lua\"]:79: in function `UIDropDownMenu_Initialize'\n[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.8.0 - by Slarti on EU-Blackhand.lua\"]:1054: in function `ATSWSubClassDropDown_OnLoad'\n[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 3775,
			["counter"] = 1,
		}, -- [37]
		{
			["message"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua:1111: attempt to call global 'TEXT' (a nil value)",
			["time"] = "2021/12/31 12:06:39",
			["locals"] = "info = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"All Slots\"\n(*temporary) = \"attempt to call global 'TEXT' (a nil value)\"\natsw_currentinvslotfilter = <table> {\n}\n",
			["stack"] = "[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua\"]:1111: in function `ATSWFilterFrame_LoadInvSlots'\n[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua\"]:1106: in function `initFunction'\n[string \"@Interface\\FrameXML\\UIDropDownMenu.lua\"]:79: in function `UIDropDownMenu_Initialize'\n[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua\"]:1093: in function `ATSWInvSlotDropDown_OnLoad'\n[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 3776,
			["counter"] = 1,
		}, -- [38]
		{
			["message"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua:1066: attempt to call global 'TEXT' (a nil value)",
			["time"] = "2021/12/31 12:06:39",
			["locals"] = "info = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"All Subclasses\"\n(*temporary) = \"attempt to call global 'TEXT' (a nil value)\"\natsw_currentsubclassfilter = <table> {\n}\n",
			["stack"] = "[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua\"]:1066: in function `ATSWFilterFrame_LoadSubClasses'\n[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua\"]:1061: in function `initFunction'\n[string \"@Interface\\FrameXML\\UIDropDownMenu.lua\"]:79: in function `UIDropDownMenu_Initialize'\n[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua\"]:1048: in function `ATSWSubClassDropDown_OnLoad'\n[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 3776,
			["counter"] = 1,
		}, -- [39]
		{
			["message"] = "Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua:337: attempt to call global 'IsTradeSkillLinked' (a nil value)",
			["time"] = "2021/12/31 12:08:33",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"attempt to call global 'IsTradeSkillLinked' (a nil value)\"\natsw_iscurrentlyenabled = false\nplayer_name = \"Poklopac\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua\"]:337: in function `ATSW_IsEnabled'\n[string \"@Interface\\AddOns\\AdvancedTradeSkillWindow\\atsw-ATSW v0.10.4.lua\"]:395: in function `ATSWFrame_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:341: in function `handler'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:623: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>\n[string \"=[C]\"]: ?\n[string \"@Interface\\FrameXML\\SecureHandlers.lua\"]:266: in function <Interface\\FrameXML\\SecureHandlers.lua:263>\n[string \"=[C]\"]: ?\n[string \"@Interface\\FrameXML\\SecureHandlers.lua\"]:296: in function <Interface\\FrameXML\\SecureHandlers.lua:279>\n[string \"=(tail call)\"]: ?",
			["session"] = 3777,
			["counter"] = 2,
		}, -- [40]
		{
			["message"] = "MkQL_RewardItem1_BtnCount: Couldn't find relative frame: $parentIconTexture",
			["session"] = 3793,
			["time"] = "2022/01/01 17:21:22",
			["counter"] = 1,
		}, -- [41]
		{
			["message"] = "MkQL_RewardItem2_BtnCount: Couldn't find relative frame: $parentIconTexture",
			["session"] = 3793,
			["time"] = "2022/01/01 17:21:22",
			["counter"] = 1,
		}, -- [42]
		{
			["message"] = "MkQL_RewardItem3_BtnCount: Couldn't find relative frame: $parentIconTexture",
			["session"] = 3793,
			["time"] = "2022/01/01 17:21:22",
			["counter"] = 1,
		}, -- [43]
		{
			["message"] = "MkQL_RewardItem4_BtnCount: Couldn't find relative frame: $parentIconTexture",
			["session"] = 3793,
			["time"] = "2022/01/01 17:21:22",
			["counter"] = 1,
		}, -- [44]
		{
			["message"] = "MkQL_RewardItem5_BtnCount: Couldn't find relative frame: $parentIconTexture",
			["session"] = 3793,
			["time"] = "2022/01/01 17:21:22",
			["counter"] = 1,
		}, -- [45]
		{
			["message"] = "MkQL_RewardItem6_BtnCount: Couldn't find relative frame: $parentIconTexture",
			["session"] = 3793,
			["time"] = "2022/01/01 17:21:22",
			["counter"] = 1,
		}, -- [46]
		{
			["message"] = "MkQL_RewardItem7_BtnCount: Couldn't find relative frame: $parentIconTexture",
			["session"] = 3793,
			["time"] = "2022/01/01 17:21:22",
			["counter"] = 1,
		}, -- [47]
		{
			["message"] = "MkQL_RewardItem8_BtnCount: Couldn't find relative frame: $parentIconTexture",
			["session"] = 3793,
			["time"] = "2022/01/01 17:21:22",
			["counter"] = 1,
		}, -- [48]
		{
			["message"] = "MkQL_RewardItem9_BtnCount: Couldn't find relative frame: $parentIconTexture",
			["session"] = 3793,
			["time"] = "2022/01/01 17:21:22",
			["counter"] = 1,
		}, -- [49]
		{
			["message"] = "MkQL_RewardItem10_BtnCount: Couldn't find relative frame: $parentIconTexture",
			["session"] = 3793,
			["time"] = "2022/01/01 17:21:22",
			["counter"] = 1,
		}, -- [50]
		{
			["message"] = "Interface\\FrameXML\\ItemButtonTemplate.lua:51: attempt to index local 'icon' (a nil value)",
			["time"] = "2022/01/01 17:21:24",
			["locals"] = "button = MkQL_RewardItem1_Btn {\n 0 = <userdata>\n type = \"choice\"\n count = 1\n hasItem = 1\n rewardType = \"item\"\n}\ntexture = 135324\nicon = nil\n(*temporary) = \"MkQL_RewardItem1_BtnIconTexture\"\n(*temporary) = nil\n(*temporary) = \"MkQL_RewardItem1_Btn\"\n(*temporary) = \"attempt to index local 'icon' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\FrameXML\\ItemButtonTemplate.lua\"]:51: in function `SetItemButtonTexture'\n[string \"@Interface\\AddOns\\MonkeyQuestLog\\MonkeyQuestLogFrame.lua\"]:263: in function `MkQL_SetQuest'\n[string \"@Interface\\AddOns\\MonkeyQuest\\MonkeyQuest-2.11.0.lua\"]:1486: in function `MonkeyQuestButton_OnClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 3793,
			["counter"] = 3,
		}, -- [51]
		{
			["message"] = "[string \"MkQL_RewardItem1_Btn:SetTexCoord(0.08, 0.92...\"]:1: attempt to call method 'SetTexCoord' (a nil value)",
			["time"] = "2022/01/01 17:25:59",
			["locals"] = "(*temporary) = nil\n(*temporary) = MkQL_RewardItem1_Btn {\n 0 = <userdata>\n type = \"choice\"\n count = 1\n beautyShadow = <table> {\n }\n hasItem = 1\n beautyBorder = <table> {\n }\n rewardType = \"item\"\n}\n(*temporary) = 0.080000\n(*temporary) = 0.920000\n(*temporary) = 0.080000\n(*temporary) = 0.920000\n(*temporary) = \"attempt to call method 'SetTexCoord' (a nil value)\"\n",
			["stack"] = "[string \"MkQL_RewardItem1_Btn:SetTexCoord(0.08, 0.92, 0.08, 0.92)\"]:1: in main chunk\n[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2918: in function <Interface\\FrameXML\\ChatFrame.lua:2911>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:341: in function `handler'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:623: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 3794,
			["counter"] = 5,
		}, -- [52]
		{
			["message"] = "[string \"print(MkQL_RewardItem1_Btn::GetItem()\"]:1: '<name>' expected near ':'",
			["time"] = "2022/01/01 17:35:21",
			["locals"] = "(*temporary) = \"print(MkQL_RewardItem1_Btn::GetItem()\"\n",
			["stack"] = "[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2918: in function <Interface\\FrameXML\\ChatFrame.lua:2911>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:341: in function `handler'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:623: in function `SecureActionButton_OnClick'\n[string \"@Interface_Vanilla\\FrameXML\\ActionButton.lua\"]:100: in function <Interface_Vanilla\\FrameXML\\ActionButton.lua:94>\n[string \"@Interface_Vanilla\\FrameXML\\ActionButton.lua\"]:136: in function `ActionButtonDown'\n[string \"ACTIONBUTTON4\"]:2: in function <[string \"ACTIONBUTTON4\"]:1>",
			["session"] = 3795,
			["counter"] = 1,
		}, -- [53]
		{
			["message"] = "[string \"print(MkQL_RewardItem1_Btn:GetItem()\"]:1: ')' expected near '<eof>'",
			["time"] = "2022/01/01 17:35:33",
			["locals"] = "(*temporary) = \"print(MkQL_RewardItem1_Btn:GetItem()\"\n",
			["stack"] = "[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2918: in function <Interface\\FrameXML\\ChatFrame.lua:2911>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:341: in function `handler'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:623: in function `SecureActionButton_OnClick'\n[string \"@Interface_Vanilla\\FrameXML\\ActionButton.lua\"]:100: in function <Interface_Vanilla\\FrameXML\\ActionButton.lua:94>\n[string \"@Interface_Vanilla\\FrameXML\\ActionButton.lua\"]:136: in function `ActionButtonDown'\n[string \"ACTIONBUTTON4\"]:2: in function <[string \"ACTIONBUTTON4\"]:1>",
			["session"] = 3795,
			["counter"] = 1,
		}, -- [54]
		{
			["message"] = "[string \"print(MkQL_RewardItem1_BtnIconTexture:GetItem()\"]:1: ')' expected near '<eof>'",
			["time"] = "2022/01/01 17:37:09",
			["locals"] = "(*temporary) = \"print(MkQL_RewardItem1_BtnIconTexture:GetItem()\"\n",
			["stack"] = "[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2918: in function <Interface\\FrameXML\\ChatFrame.lua:2911>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:341: in function `handler'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:623: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 3795,
			["counter"] = 1,
		}, -- [55]
		{
			["message"] = "[string \"print(MkQL_RewardItem1_BtnIconTexture:GetIt...\"]:1: attempt to call method 'GetItem' (a nil value)",
			["time"] = "2022/01/01 17:42:35",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = MkQL_RewardItem1_BtnIconTexture {\n 0 = <userdata>\n}\n(*temporary) = \"attempt to call method 'GetItem' (a nil value)\"\n",
			["stack"] = "[string \"print(MkQL_RewardItem1_BtnIconTexture:GetItem())\"]:1: in main chunk\n[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2918: in function <Interface\\FrameXML\\ChatFrame.lua:2911>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:341: in function `handler'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:623: in function `SecureActionButton_OnClick'\n[string \"@Interface_Vanilla\\FrameXML\\ActionButton.lua\"]:100: in function <Interface_Vanilla\\FrameXML\\ActionButton.lua:94>\n[string \"@Interface_Vanilla\\FrameXML\\ActionButton.lua\"]:136: in function `ActionButtonDown'\n[string \"ACTIONBUTTON4\"]:2: in function <[string \"ACTIONBUTTON4\"]:1>",
			["session"] = 3795,
			["counter"] = 1,
		}, -- [56]
		{
			["message"] = "[string \"print(MkQL_RewardItem1_Btn:GetItem())\"]:1: attempt to call method 'GetItem' (a nil value)",
			["time"] = "2022/01/01 17:42:48",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = MkQL_RewardItem1_Btn {\n SetBorderBlendMode = <function> defined @Interface\\SharedXML\\Backdrop.lua:258\n beautyShadow = <table> {\n }\n OnBackdropLoaded = <function> defined @Interface\\SharedXML\\Backdrop.lua:144\n GetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:382\n SetupTextureCoordinates = <function> defined @Interface\\SharedXML\\Backdrop.lua:206\n OnBackdropSizeChanged = <function> defined @Interface\\SharedXML\\Backdrop.lua:174\n HasBackdropInfo = <function> defined @Interface\\SharedXML\\Backdrop.lua:270\n SetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:414\n GetEdgeSize = <function> defined @Interface\\SharedXML\\Backdrop.lua:180\n count = 1\n rewardType = \"item\"\n ApplyBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:286\n SetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:321\n ClearBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:274\n type = \"reward\"\n GetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:401\n GetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:339\n beautyBorder = <table> {\n }\n SetupPieceVisuals = <function> defined @Interface\\SharedXML\\Backdrop.lua:238\n SetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:391\n 0 = <userdata>\n hasItem = 1\n}\n(*temporary) = \"attempt to call method 'GetItem' (a nil value)\"\n",
			["stack"] = "[string \"print(MkQL_RewardItem1_Btn:GetItem())\"]:1: in main chunk\n[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2918: in function <Interface\\FrameXML\\ChatFrame.lua:2911>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:341: in function `handler'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:623: in function `SecureActionButton_OnClick'\n[string \"@Interface_Vanilla\\FrameXML\\ActionButton.lua\"]:100: in function <Interface_Vanilla\\FrameXML\\ActionButton.lua:94>\n[string \"@Interface_Vanilla\\FrameXML\\ActionButton.lua\"]:136: in function `ActionButtonDown'\n[string \"ACTIONBUTTON4\"]:2: in function <[string \"ACTIONBUTTON4\"]:1>",
			["session"] = 3795,
			["counter"] = 1,
		}, -- [57]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/MonkeyQuest.lua:50: Usage: GetQuestLogItemLink(\"type\", index)",
			["time"] = "2022/01/01 18:27:33",
			["locals"] = "(*temporary) = nil\n(*temporary) = 1\n",
			["stack"] = "[string \"=[C]\"]: in function `GetQuestLogItemLink'\n[string \"@Interface\\AddOns\\xVermin\\Addons/MonkeyQuest.lua\"]:50: in function <Interface\\AddOns\\xVermin\\Addons/MonkeyQuest.lua:6>",
			["session"] = 3797,
			["counter"] = 1,
		}, -- [58]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/MonkeyQuest.lua:57: Usage: GetQuestLogItemLink(\"type\", index)",
			["time"] = "2022/01/01 18:28:08",
			["locals"] = "(*temporary) = nil\n(*temporary) = 1\n",
			["stack"] = "[string \"=[C]\"]: in function `GetQuestLogItemLink'\n[string \"@Interface\\AddOns\\xVermin\\Addons/MonkeyQuest.lua\"]:57: in function <Interface\\AddOns\\xVermin\\Addons/MonkeyQuest.lua:6>",
			["session"] = 3798,
			["counter"] = 1,
		}, -- [59]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/MonkeyQuest.lua:57: attempt to concatenate field 'type' (a nil value)",
			["time"] = "2022/01/01 18:30:57",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n}\nevent = \"PLAYER_ENTERING_WORLD\"\nisInitialLogin = false\nisReloadingUi = true\n(for index) = 1\n(for limit) = 50\n(for step) = 1\ni = 1\nframe = MkQL_RewardItem1_Btn {\n SetBorderBlendMode = <function> defined @Interface\\SharedXML\\Backdrop.lua:258\n OnBackdropLoaded = <function> defined @Interface\\SharedXML\\Backdrop.lua:144\n GetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:382\n SetupTextureCoordinates = <function> defined @Interface\\SharedXML\\Backdrop.lua:206\n OnBackdropSizeChanged = <function> defined @Interface\\SharedXML\\Backdrop.lua:174\n HasBackdropInfo = <function> defined @Interface\\SharedXML\\Backdrop.lua:270\n SetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:414\n GetEdgeSize = <function> defined @Interface\\SharedXML\\Backdrop.lua:180\n ApplyBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:286\n SetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:321\n ClearBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:274\n GetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:401\n GetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:339\n SetupPieceVisuals = <function> defined @Interface\\SharedXML\\Backdrop.lua:238\n SetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:391\n 0 = <userdata>\n hasItem = 1\n}\ntexture = MkQL_RewardItem1_BtnIconTexture {\n 0 = <userdata>\n}\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = \"\"\"\n(*temporary) = nil\n(*temporary) = \"\"\"\n(*temporary) = 1\n(*temporary) = \"attempt to concatenate field 'type' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/MonkeyQuest.lua\"]:57: in function <Interface\\AddOns\\xVermin\\Addons/MonkeyQuest.lua:6>",
			["session"] = 3799,
			["counter"] = 1,
		}, -- [60]
		{
			["message"] = "...erface\\AddOns\\MonkeyQuestLog\\MonkeyQuestLogFrame.lua:343: attempt to index global 'xVermin' (a nil value)",
			["time"] = "2022/01/01 18:36:24",
			["locals"] = "iQuestNum = 2\ntmpQuestLogSelection = 6\nstrQuestLogTitleText = \"Blueleaf Tubers\"\nsuggestedGroup = \"Dungeon\"\nstrQuestTag = nil\nisHeader = false\nisCollapsed = false\nisComplete = nil\nfrequency = 1\nquestID = 1221\nquestInfo = nil\nstrQuestDescription = \"Blueleaf tubers are a delicacy around the world!  But they're rare, very rare.  The only place to find them is here in the Barrens, deep in the earth, in Razorfen Kraul.\n\nAnd even then, they're impossible to find unless you know just where to look!  That's why I've trained these snufflenose gophers to find them for me.  They have great noses and can smell a tuber from fifty paces away.\n\nIt won't be easy, but if you get me some tubers I'll pay you handsomely.\"\nstrQuestObjectives = \"Grab a Crate with Holes.\nGrab a Snufflenose Command Stick.\nGrab and read the Snufflenose Owner's Manual.\n\nIn Razorfen Kraul, use the Crate with Holes to summon a Snufflenose Gopher, and use the Command Stick on the gopher to make it search for Tubers.\n\nBring 6 Blueleaf Tubers, the Snufflenose Command Stick and the Crate with Holes to Mebok Mizzyrix in Ratchet.\"\nstrOverview = \"Grab a |cff9999ffCrate|cffffffff with |cff9999ffHoles|cffffffff.\nGrab a |cff9999ffSnufflenose|cffffffff |cff9999ffCommand|cffffffff |cff9999ffStick|cffffffff.\nGrab and read the |cff9999ffSnufflenose|cffffffff |cff9999ffOwner's|cffffffff |cff9999ffManual|cffffffff.\n\nIn |cff9999ffRazorfen|cffffffff |cff9999ffKraul|cffffffff, use the |cff9999ffCrate|cffffffff with |cff9999ffHoles|cffffffff to summon a |cff9999ffSnufflenose|cffffffff |cff9999ffGopher|cffffffff, and use the |cff9999ffCommand|cffffffff |cff9999ffStick|cffffffff on the gopher to make it search for |cff9999ffTubers|cffffffff.\n\nBring |cffff 0 06|cffffffff |cff9999ffBlueleaf|cffffffff |cff9999ffTubers|cffffffff, the |cff9999ffSnufflenose|cffffffff |cff9999ffCommand|cffffffff |cff9999ffStick|cffffffff and the |cff9999ffCrate|cffffffff with |cff9999ffHoles|cffffffff to |cff9999ffMebok|cffffffff |cff9999ffMizzyrix|cffffffff in |cff9999ffRatchet|cffffffff.\n\n  |cffd82619Blueleaf Tuber: 0/6\n  |cffd82619Crate With Holes: 0/1\n  |cffd82619SnufflnumQuestRewards = 1\nnumQuestChoices = 0\nrewardMoney = 0\nname = \"A Small Container of Gems\"\ntexture = 134344\nnumItems = 1\nquality = 1\nisUsable = true\nnumTotalRewards = 1\nrewardXP = 0\nrewardItem = MkQL_RewardItem1_Btn {\n SetBorderBlendMode = <function> defined @Interface\\SharedXML\\Backdrop.lua:258\n beautyShadow = <table> {\n }\n OnBackdropLoaded = <function> defined @Interface\\SharedXML\\Backdrop.lua:144\n GetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:382\n SetupTextureCoordinates = <function> defined @Interface\\SharedXML\\Backdrop.lua:206\n OnBackdropSizeChanged = <function> defined @Interface\\SharedXML\\Backdrop.lua:174\n HasBackdropInfo = <function> defined @Interface\\SharedXML\\Backdrop.lua:270\n SetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:414\n GetEdgeSize = <function> defined @Interface\\SharedXML\\Backdrop.lua:180\n beautyBorder = <table> {\n }\n count = 1\n ApplyBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:286\n SetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:321\n ClearBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:274\n rewardType = \"item\"\n GetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:401\n GetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:339\n type = \"reward\"\n SetupPieceVisuals = <function> defined @Interface\\SharedXML\\Backdrop.lua:238\n SetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:391\n 0 = <userdata>\n hasItem = 1\n}\n(for index) = 1\n(for limit) = 1\n(for step) = 1\ni = 1\n(*temporary) = <function> defined @Interface\\AddOns\\!Beautycase\\!Beautycase.lua:130\n(*temporary) = MkQL_RewardItem1_Btn {\n SetBorderBlendMode = <function> defined @Interface\\SharedXML\\Backdrop.lua:258\n beautyShadow = <table> {\n }\n OnBackdropLoaded = <function> defined @Interface\\SharedXML\\Backdrop.lua:144\n GetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:382\n SetupTextureCoordinat",
			["stack"] = "[string \"@Interface\\AddOns\\MonkeyQuestLog\\MonkeyQuestLogFrame.lua\"]:343: in function `MkQL_SetQuest'\n[string \"@Interface\\AddOns\\MonkeyQuest\\MonkeyQuest-2.11.0.lua\"]:1486: in function `MonkeyQuestButton_OnClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 3803,
			["counter"] = 1,
		}, -- [61]
		{
			["message"] = "Interface\\AddOns\\xVermin\\LootHelper.lua:163: attempt to index global 'mcf' (a nil value)",
			["time"] = "2022/01/01 20:48:00",
			["locals"] = "self = BlizzardCountFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nevent = \"ADDON_LOADED\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <userdata>\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'mcf' (a nil value)\"\nxVermin = <table> {\n LogBreak = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:56\n FormatNumber = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:90\n Debug = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:14\n Color = <table> {\n }\n Class = \"WARRIOR\"\n FormatValue = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:82\n ClassColor = <table> {\n }\n Config = <table> {\n }\n AOE = <function> defined @Interface\\AddOns\\xVermin\\Rotation/_Core.lua:3\n Log = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:41\n Round = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:107\n TimeFormat = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:134\n ColorGradient = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:119\n}\nticktime = 1641066480\nmanaticktotal = 0\nbase = nil\ncasting = nil\nlastmana = nil\nmanatick = 0\nbcount = nil\nbcf = BlizzardCountFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\LootHelper.lua\"]:163: in function <Interface\\AddOns\\xVermin\\LootHelper.lua:113>",
			["session"] = 3809,
			["counter"] = 1,
		}, -- [62]
		{
			["message"] = "[string \"print(GetProfessions())\"]:1: attempt to call global 'GetProfessions' (a nil value)",
			["time"] = "2022/01/02 09:25:06",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'GetProfessions' (a nil value)\"\n",
			["stack"] = "[string \"print(GetProfessions())\"]:1: in main chunk\n[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4532: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 3819,
			["counter"] = 1,
		}, -- [63]
		{
			["message"] = "Interface\\SharedXML\\TableUtil.lua:90: bad argument #1 to 'pairs' (table expected, got nil)",
			["time"] = "2022/01/02 09:34:16",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"table expected, got nil\"\n = <function> defined =[C]:-1\n",
			["stack"] = "[string \"=[C]\"]: in function `pairs'\n[string \"@Interface\\SharedXML\\TableUtil.lua\"]:90: in function `tInvert'\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:240: in main chunk",
			["session"] = 3821,
			["counter"] = 1,
		}, -- [64]
		{
			["message"] = "attempt to call a table value",
			["time"] = "2022/01/02 09:43:41",
			["stack"] = "[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.3.lua\"]:4841: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:4762>\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.3.lua\"]:4868: in function `AnchorFrame'\n[string \"@Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua\"]:570: in function `modify'\n[string \"@Interface\\AddOns\\WeakAuras\\RegionTypes\\DynamicGroup.lua\"]:792: in function `modify'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.3.lua\"]:2738: in function `SetRegion'\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.3.lua\"]:2559: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:2526>\n[string \"@Interface\\AddOns\\WeakAuras\\WeakAuras-3.7.3.lua\"]:2660: in function `Add'\n[string \"@Interface\\AddOns\\WeakAurasOptions\\CommonOptions.lua\"]:1317: in function <Interface\\AddOns\\WeakAurasOptions\\CommonOptions.lua:1308>\n[string \"=[C]\"]: ?\n[string \"@Interface\\AddOns\\BlizzMove\\Libs\\AceConfig-3.0-3\\AceConfigDialog-3.0\\AceConfigDialog-3.0-82.lua\"]:51: in function <...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:49>\n[string \"@Interface\\AddOns\\BlizzMove\\Libs\\AceConfig-3.0-3\\AceConfigDialog-3.0\\AceConfigDialog-3.0-82.lua\"]:847: in function <...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:668>\n[string \"=[C]\"]: ?\n[string \"@Interface\\AddOns\\BlizzMove\\Libs\\AceGUI-3.0\\AceGUI-3.0-41.lua\"]:72: in function <...face\\AddOns\\BlizzMove\\Libs\\AceGUI-3.0\\AceGUI-3.0.lua:70>\n[string \"@Interface\\AddOns\\BlizzMove\\Libs\\AceGUI-3.0\\AceGUI-3.0-41.lua\"]:306: in function `Fire'\n[string \"@Interface\\AddOns\\WeakAurasOptions\\AceGUI-Widgets\\AceGUIWidget-WeakAurasMultiLineEditBox.lua\"]:59: in function <...I-Widgets\\AceGUIWidget-WeakAurasMultiLineEditBox.lua:56>",
			["session"] = 3822,
			["counter"] = 3,
		}, -- [65]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVermin' tried to call the protected function 'MultiBarBottomLeft:SetShown()'.",
			["time"] = "2022/01/02 17:31:48",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: in function `SetShown'\n[string \"@Interface_Vanilla\\FrameXML\\MultiActionBars.lua\"]:36: in function <Interface_Vanilla\\FrameXML\\MultiActionBars.lua:34>\n[string \"@Interface_Vanilla\\FrameXML\\MultiActionBars.lua\"]:52: in function `MultiActionBar_Update'\n[string \"@Interface_Vanilla\\FrameXML\\ActionBarController.lua\"]:138: in function `ValidateActionBarTransition'\n[string \"@Interface_Vanilla\\FrameXML\\ActionBarController.lua\"]:106: in function `ActionBarController_UpdateAll'\n[string \"@Interface_Vanilla\\FrameXML\\ActionBarController.lua\"]:45: in function <Interface_Vanilla\\FrameXML\\ActionBarController.lua:34>",
			["session"] = 3829,
			["counter"] = 1,
		}, -- [66]
		{
			["message"] = "Interface\\AddOns\\nHealth\\core.lua:44: attempt to call method 'SetBackdrop' (a nil value)",
			["time"] = "2022/01/03 14:52:29",
			["locals"] = "ComboColor = <table> {\n 2 = <table> {\n }\n 3 = <table> {\n }\n 1 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n}\nf = nHealth {\n 0 = <userdata>\n Health = nHealthStatusBar {\n }\n}\n(*temporary) = nil\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = <table> {\n insets = <table> {\n }\n BgFile = \"Interface\\ChatFrame\\ChatFrameBackground\"\n edgeSize = 4\n edgeFile = \"Interface\\Addons\\nHealth\\media\\textureGlow\"\n}\n(*temporary) = \"attempt to call method 'SetBackdrop' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\nHealth\\core.lua\"]:44: in main chunk",
			["session"] = 3833,
			["counter"] = 3,
		}, -- [67]
		{
			["message"] = "Interface\\AddOns\\nPower\\core.lua:89: attempt to call method 'SetBackdrop' (a nil value)",
			["time"] = "2022/01/03 14:52:29",
			["locals"] = "ComboColor = <table> {\n 2 = <table> {\n }\n 3 = <table> {\n }\n 1 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n}\nplayerClass = \"PRIEST\"\nf = nPower {\n 0 = <userdata>\n ComboPoints = <table> {\n }\n Power = nPowerStatusBar {\n }\n}\n(*temporary) = nil\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = <table> {\n insets = <table> {\n }\n BgFile = \"Interface\\ChatFrame\\ChatFrameBackground\"\n edgeSize = 4\n edgeFile = \"Interface\\Addons\\nPower\\media\\textureGlow\"\n}\n(*temporary) = \"attempt to call method 'SetBackdrop' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\nPower\\core.lua\"]:89: in main chunk",
			["session"] = 3833,
			["counter"] = 3,
		}, -- [68]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:170: attempt to index local 'food' (a nil value)",
			["time"] = "2022/01/03 15:07:14",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n PetFood = <table> {\n }\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:261\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:224\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:169\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:288\n ManaGem = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:356\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:342\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:377\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:243\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:214\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:253\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:363\n FindPairInPetFoodArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:192\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:62\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:349\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:233\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:180\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:308\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:279\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:370\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:160\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:201\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:389\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:322\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:315\n}\nfood = nil\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'food' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:170: in function `IsUsableFood'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:80: in function `UpdateMacros'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:53: in function <Interface\\AddOns\\xVermin\\BestFood.lua:48>",
			["session"] = 3835,
			["counter"] = 3,
		}, -- [69]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:176: attempt to index local 'food' (a nil value)",
			["time"] = "2022/01/03 15:09:10",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n PetFood = <table> {\n }\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:267\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:230\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:175\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:294\n ManaGem = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:362\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:348\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:383\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:249\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:220\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:259\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:369\n FindPairInPetFoodArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:198\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:68\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:355\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:239\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:186\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:314\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:285\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:376\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:166\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:207\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:395\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:328\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:321\n}\nfood = nil\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'food' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:176: in function `IsUsableFood'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:86: in function `UpdateMacros'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:57: in function <Interface\\AddOns\\xVermin\\BestFood.lua:48>",
			["session"] = 3836,
			["counter"] = 1,
		}, -- [70]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:172: attempt to index local 'food' (a nil value)",
			["time"] = "2022/01/03 15:10:20",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n PetFood = <table> {\n }\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:263\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:226\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:171\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:290\n ManaGem = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:358\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:344\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:379\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:245\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:216\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:255\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:365\n FindPairInPetFoodArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:194\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:62\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:351\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:235\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:182\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:310\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:281\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:372\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:162\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:203\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:391\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:324\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:317\n}\nfood = nil\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'food' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:172: in function `IsUsableFood'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:82: in function `UpdateMacros'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:53: in function <Interface\\AddOns\\xVermin\\BestFood.lua:48>",
			["session"] = 3837,
			["counter"] = 1,
		}, -- [71]
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:174: attempt to compare nil with number",
			["time"] = "2022/01/03 15:59:05",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n PetFood = <table> {\n }\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:261\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:224\n IsUsableFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:169\n Bandage = <table> {\n }\n BetterFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:288\n ManaGem = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:356\n Potion = <table> {\n }\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:342\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:377\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:243\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:214\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:253\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:363\n FindPairInPetFoodArray = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:192\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:62\n BetterHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:349\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:233\n IsUsablePetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:180\n BetterPetFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:308\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:279\n BetterManaGem = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:370\n Sorted = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:160\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:201\n BuildSequence = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:389\n BetterDrink = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:322\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVermin\\BestFood.lua:315\n}\nfood = <table> {\n conj = false\n name = \"Tough Hunk of Bread\"\n lvl = 6\n id = 4540\n hp = 61.200000\n}\n(*temporary) = nil\n(*temporary) = 2\n(*temporary) = \"player\"\n(*temporary) = 2\n(*temporary) = \"attempt to compare nil with number\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:174: in function `IsUsableFood'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:80: in function `UpdateMacros'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:53: in function <Interface\\AddOns\\xVermin\\BestFood.lua:48>",
			["session"] = 3842,
			["counter"] = 1,
		}, -- [72]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'ItemRack' tried to call the protected function 'AutoEquipCursorItem()'.",
			["time"] = "2022/01/03 20:35:31",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: in function `AutoEquipCursorItem'\n[string \"*:OnMouseUp\"]:4: in function `oldCharacterModelFrame_OnMouseUp'\n[string \"@Interface\\AddOns\\ItemRack\\ItemRackButtons.lua\"]:105: in function <Interface\\AddOns\\ItemRack\\ItemRackButtons.lua:101>",
			["session"] = 3846,
			["counter"] = 1,
		}, -- [73]
		{
			["message"] = "...lla\\AddOns\\Blizzard_AuctionUI\\Blizzard_AuctionUI.lua:751: attempt to index local 'color' (a nil value)",
			["time"] = "2021/12/26 12:15:07",
			["locals"] = "numBatchAuctions = 36449\ntotalAuctions = 36449\nbutton = BrowseButton1 {\n 0 = <userdata>\n PriceTooltipFrame = <unnamed> {\n }\n}\nbuttonName = \"BrowseButton1\"\nbuttonHighlight = BrowseButton1Highlight {\n 0 = <userdata>\n}\niconTexture = nil\nitemName = BrowseButton1Name {\n 0 = <userdata>\n}\ncolor = nil\nitemCount = nil\nmoneyFrame = nil\nyourBidText = nil\nbuyoutFrame = nil\nbuyoutMoney = nil\noffset = 0\nindex = 1\nisLastSlotEmpty = nil\nname = \"\"\ntexture = 135327\ncount = 1\nquality = -1\ncanUse = false\nlevel = -666652416\nlevelColHeader = nil\nminBid = 1861999\nminIncrement = 0\nbuyoutPrice = 1959998\nduration = 1\nbidAmount = 0\nhighBidder = false\nbidderFullName = nil\nowner = nil\nownerFullName = nil\nsaleStatus = 0\nitemId = 935\nhasAllInfo = true\ndisplayedPrice = nil\nrequiredBid = nil\n(for index) = 1\n(for limit) = 8\n(for step) = 1\ni = 1\nshouldHide = false\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = BrowseButton1Name {\n 0 = <userdata>\n}\n(*temporary) = \"\"\n(*temporary) = <userdata>\n(*temporary) = false\n(*temporary) = -666652416\n(*temporary) = nil\n(*temporary) = 1861999\n(*temporary) = 0\n(*temporary) = 1959998\n(*temporary) = 0\n(*temporary) = false\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = 0\n(*temporary) = 935\n(*temporary) = true\n(*temporary) = \"attempt to index local 'color' (a nil value)\"\n",
			["stack"] = "[string \"@Interface_Vanilla\\AddOns\\Blizzard_AuctionUI\\Blizzard_AuctionUI.lua\"]:751: in function `AuctionFrameBrowse_Update'\n[string \"@Interface_Vanilla\\AddOns\\Blizzard_AuctionUI\\Blizzard_AuctionUI.lua\"]:277: in function <...lla\\AddOns\\Blizzard_AuctionUI\\Blizzard_AuctionUI.lua:275>",
			["session"] = 3870,
			["counter"] = 17,
		}, -- [74]
		{
			["message"] = "...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:123: Action[FrameMeasurement] failed because[Can't measure restricted regions]: attempted from: <unnamed>:IsMouseOver().",
			["time"] = "2022/01/05 11:21:53",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n",
			["stack"] = "[string \"=[C]\"]: in function `IsMouseOver'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:123: in function <...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools.lua:118>\n[string \"=(tail call)\"]: ?\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:151: in function <...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools.lua:147>\n[string \"=[C]\"]: in function `SetFrameStack'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:239: in function <...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools.lua:233>",
			["session"] = 3872,
			["counter"] = 2,
		}, -- [75]
		{
			["message"] = "...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:219: Action[FrameMeasurement] failed because[Can't measure restricted regions]: attempted from: <unnamed>:GetPoint().",
			["time"] = "2022/01/05 11:21:53",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = 1\n",
			["stack"] = "[string \"=[C]\"]: in function `GetPoint'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:219: in function `HighlightFrame'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:242: in function <...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools.lua:233>",
			["session"] = 3872,
			["counter"] = 2,
		}, -- [76]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:10: attempt to index global 'Questie_BaseFrame' (a nil value)",
			["time"] = "2022/01/05 11:32:57",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n}\nevent = \"PLAYER_ENTERING_WORLD\"\nisInitialLogin = false\nisReloadingUi = true\n(*temporary) = nil\n(*temporary) = \"Questie\"\n(*temporary) = true\n(*temporary) = true\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'Questie_BaseFrame' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:10: in function <Interface\\AddOns\\xVermin\\Addons/Questie.lua:6>",
			["session"] = 3874,
			["counter"] = 1,
		}, -- [77]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:39: attempt to index global 'Questie_BaseFrame' (a nil value)",
			["time"] = "2022/01/05 11:35:30",
			["locals"] = "_ = \"xVermin\"\nxVermin = <table> {\n LogBreak = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:56\n FormatNumber = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:90\n Debug = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:14\n Color = <table> {\n }\n Class = \"WARRIOR\"\n FormatValue = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:82\n ClassColor = <table> {\n }\n Config = <table> {\n }\n Log = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:41\n Round = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:107\n TimeFormat = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:134\n ColorGradient = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:119\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'Questie_BaseFrame' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:39: in main chunk",
			["session"] = 3875,
			["counter"] = 1,
		}, -- [78]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:46: attempt to index global 'Questie_BaseFrame' (a nil value)",
			["time"] = "2022/01/05 11:38:46",
			["locals"] = "_ = \"xVermin\"\nxVermin = <table> {\n LogBreak = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:56\n FormatNumber = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:90\n Debug = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:14\n Color = <table> {\n }\n Class = \"WARRIOR\"\n FormatValue = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:82\n ClassColor = <table> {\n }\n Config = <table> {\n }\n Log = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:41\n Round = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:107\n TimeFormat = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:134\n ColorGradient = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:119\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"OnUpdate\"\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:41\n(*temporary) = \"attempt to index global 'Questie_BaseFrame' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:46: in main chunk",
			["session"] = 3876,
			["counter"] = 1,
		}, -- [79]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:51: no loop to break near 'end'",
			["time"] = "2022/01/05 11:43:46",
			["locals"] = "",
			["stack"] = "",
			["session"] = 3879,
			["counter"] = 4,
		}, -- [80]
		{
			["message"] = "Interface\\AddOns\\Grid2\\modules\\IndicatorTooltip.lua:55: attempt to call method 'GetTooltip' (a nil value)",
			["time"] = "2022/01/05 14:20:12",
			["locals"] = "self = <table> {\n LoadDB = <function> defined @Interface\\AddOns\\Grid2\\modules\\IndicatorTooltip.lua:82\n Update = <function> defined @Interface\\AddOns\\Grid2\\GridIndicator.lua:44\n statuses = <table> {\n }\n prototype = <table> {\n }\n Layout = <function> defined @Interface\\AddOns\\Grid2\\GridUtils.lua:14\n Create = <function> defined @Interface\\AddOns\\Grid2\\GridUtils.lua:14\n dbx = <table> {\n }\n OnSuspend = <function> defined @Interface\\AddOns\\Grid2\\modules\\IndicatorTooltip.lua:77\n sortStatuses = <function> defined @Interface\\AddOns\\Grid2\\GridIndicator.lua:25\n name = \"tooltip\"\n priorities = <table> {\n }\n Display = <function> defined @Interface\\AddOns\\Grid2\\modules\\IndicatorTooltip.lua:48\n GetTooltip = <function> defined @Interface\\AddOns\\Grid2\\modules\\IndicatorTooltip.lua:44\n OnUpdate = <function> defined @Interface\\AddOns\\Grid2\\modules\\IndicatorTooltip.lua:67\n Hide = <function> defined @Interface\\AddOns\\Grid2\\modules\\IndicatorTooltip.lua:60\n}\nunit = \"player\"\nstatus = <table> {\n GetPercent = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:224\n indicators = <table> {\n }\n GetIcons = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:226\n IsActive = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:221\n GetText = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:222\n priorities = <table> {\n }\n GetColor = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:223\n enabled = true\n name = \"test\"\n GetIcon = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:225\n}\nanchor = nil\n(*temporary) = nil\n(*temporary) = <table> {\n GetPercent = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:224\n indicators = <table> {\n }\n GetIcons = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:226\n IsActive = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:221\n GetText = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:222\n priorities = <table> {\n }\n GetColor = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:223\n enabled = true\n name = \"test\"\n GetIcon = <function> defined @Interface\\AddOns\\Grid2Options\\GridIndicators.lua:225\n}\n(*temporary) = \"player\"\n(*temporary) = GameTooltip {\n 0 = <userdata>\n beautyShadow = <table> {\n }\n GetBackdropColor = <function> defined @Interface\\SharedXML\\SharedTooltipTemplates.lua:182\n SetHyperlink = <function> defined =[C]:-1\n SetGuildBankItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetVoidItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetBackdropBorderColor = <function> defined @Interface\\AddOns\\Lorti UI Classic\\core\\frames.lua:213\n SetVoidDepositItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetVoidWithdrawalItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n questOrder = <table> {\n }\n comparing = false\n beautyBorder = <table> {\n }\n default = 1\n TopOverlay = <unnamed> {\n }\n GetBackdropBorderColor = <function> defined @Interface\\SharedXML\\SharedTooltipTemplates.lua:190\n npcOrder = <table> {\n }\n _owner = QuestieFrame709 {\n }\n TMW_SetEquiv = <function> defined @Interface\\AddOns\\TellMeWhen\\Options\\TellMeWhen_Options.lua:165\n SetLootItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n SetQuestItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n manualOrder = <table> {\n }\n SetBorderBlendMode = <function> defined @Interface\\SharedXML\\SharedTooltipTemplates.lua:194\n blockInspectRequests = false\n miniMapIcon = false\n SetLootRollItem = <function> defined @Interface\\AddOns\\TradeSkillMaster\\LibTSM\\Service\\ItemTooltipClasses\\Wrapper.lua:105\n TMW_SetDogTag = <function> defined @Interface\\AddOns\\TellMeWhen\\Components\\Core\\Common\\DogTags\\config.lua:403\n SetRecipeReagentI",
			["stack"] = "[string \"@Interface\\AddOns\\Grid2\\modules\\IndicatorTooltip.lua\"]:55: in function `Display'\n[string \"@Interface\\AddOns\\Grid2\\modules\\IndicatorTooltip.lua\"]:31: in function `func'\n[string \"@Interface\\AddOns\\Grid2\\GridFrame.lua\"]:92: in function <Interface\\AddOns\\Grid2\\GridFrame.lua:90>",
			["session"] = 3886,
			["counter"] = 4,
		}, -- [81]
		{
			["message"] = "...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua:55: Usage: CopyToClipboard(\"string\" [, removeMarkup])",
			["time"] = "2022/01/05 14:27:12",
			["locals"] = "(*temporary) = QuestLogItem4IconTexture {\n 0 = <userdata>\n}\n",
			["stack"] = "[string \"=[C]\"]: in function `CopyToClipboard'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:55: in function `FrameStackTooltip_HandleFrameCommand'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:25: in function `command'\n[string \"@Interface\\SharedXML\\KeyCommand.lua\"]:47: in function `Update'\n[string \"@Interface\\SharedXML\\KeyCommand.lua\"]:111: in function `KeyCommand_Update'\n[string \"@Interface\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools-1.0.lua\"]:234: in function <...e\\AddOns\\Blizzard_DebugTools\\Blizzard_DebugTools.lua:233>",
			["session"] = 3887,
			["counter"] = 1,
		}, -- [82]
		{
			["message"] = "[string \"QuestLogItem4IconTexture:CreateBeautyBorder...\"]:1: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2022/01/05 14:27:13",
			["locals"] = "(*temporary) = nil\n(*temporary) = QuestLogItem4IconTexture {\n 0 = <userdata>\n}\n(*temporary) = 8\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "[string \"QuestLogItem4IconTexture:CreateBeautyBorder(8)\"]:1: in main chunk\n[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4532: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 3887,
			["counter"] = 1,
		}, -- [83]
		{
			["message"] = "[string \"QuestLogItem3IconTexture:CreateBeautyBorder...\"]:1: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2022/01/05 14:27:24",
			["locals"] = "(*temporary) = nil\n(*temporary) = QuestLogItem3IconTexture {\n 0 = <userdata>\n}\n(*temporary) = 8\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\n",
			["stack"] = "[string \"QuestLogItem3IconTexture:CreateBeautyBorder(8)\"]:1: in main chunk\n[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4532: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 3887,
			["counter"] = 3,
		}, -- [84]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:68: attempt to index global 'T' (a nil value)",
			["time"] = "2022/01/05 15:17:00",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"OnUpdate\"\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:65\n(*temporary) = \"attempt to index global 'T' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:68: in function <Interface\\AddOns\\xVermin\\Addons/Questie.lua:63>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3888,
			["counter"] = 1,
		}, -- [85]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:69: attempt to index global 'T' (a nil value)",
			["time"] = "2022/01/05 15:17:38",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"OnUpdate\"\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:66\n(*temporary) = \"attempt to index global 'T' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:69: in function <Interface\\AddOns\\xVermin\\Addons/Questie.lua:63>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3889,
			["counter"] = 1,
		}, -- [86]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:91: attempt to index global 'T' (a nil value)",
			["time"] = "2022/01/05 15:18:26",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"OnUpdate\"\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:65\n(*temporary) = \"attempt to index global 'T' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:91: in function <Interface\\AddOns\\xVermin\\Addons/Questie.lua:63>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3890,
			["counter"] = 1,
		}, -- [87]
		{
			["message"] = "Interface\\SharedXML\\NineSlice.lua:164: C stack overflow",
			["time"] = "2022/01/05 15:24:57",
			["locals"] = "container = Questie_BaseFrame {\n 0 = <userdata>\n SetPoint = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:86\n BottomEdge = <unnamed> {\n }\n beautyShadow = <table> {\n }\n beautyBorder = <table> {\n }\n TopLeftCorner = <unnamed> {\n }\n OnBackdropLoaded = <function> defined @Interface\\SharedXML\\Backdrop.lua:144\n Update = <function> defined @Interface\\AddOns\\Questie\\Modules\\Tracker\\QuestieTracker.lua:239\n Center = <unnamed> {\n }\n GetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:382\n SetupTextureCoordinates = <function> defined @Interface\\SharedXML\\Backdrop.lua:206\n OnBackdropSizeChanged = <function> defined @Interface\\SharedXML\\Backdrop.lua:174\n HasBackdropInfo = <function> defined @Interface\\SharedXML\\Backdrop.lua:270\n SetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:414\n RightEdge = <unnamed> {\n }\n backdropInfo = <table> {\n }\n ClearAllPoints = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:85\n GetEdgeSize = <function> defined @Interface\\SharedXML\\Backdrop.lua:180\n BottomLeftCorner = <unnamed> {\n }\n BottomRightCorner = <unnamed> {\n }\n TopEdge = <unnamed> {\n }\n ApplyBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:286\n SetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:321\n ClearBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:274\n TopRightCorner = <unnamed> {\n }\n GetBackdropBorderColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:401\n GetBackdrop = <function> defined @Interface\\SharedXML\\Backdrop.lua:339\n sizer = Questie_Sizer {\n }\n SetupPieceVisuals = <function> defined @Interface\\SharedXML\\Backdrop.lua:238\n SetBackdropColor = <function> defined @Interface\\SharedXML\\Backdrop.lua:391\n LeftEdge = <unnamed> {\n }\n SetBorderBlendMode = <function> defined @Interface\\SharedXML\\Backdrop.lua:258\n}\nuserLayout = <table> {\n BottomLeftCorner = <table> {\n }\n TopEdge = <table> {\n }\n BottomEdge = <table> {\n }\n setupPieceVisualsFunction = <function> defined @Interface\\SharedXML\\Backdrop.lua:238\n Center = <table> {\n }\n RightEdge = <table> {\n }\n TopRightCorner = <table> {\n }\n TopLeftCorner = <table> {\n }\n LeftEdge = <table> {\n }\n BottomRightCorner = <table> {\n }\n}\ntextureKit = nil\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n 6 = <table> {\n }\n 7 = <table> {\n }\n 8 = <table> {\n }\n 9 = <table> {\n }\n}\n(for control) = 0\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n 6 = <table> {\n }\n 7 = <table> {\n }\n 8 = <table> {\n }\n 9 = <table> {\n }\n}\n(*temporary) = 0\n(*temporary) = \"C stack overflow\"\nnineSliceSetup = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n 6 = <table> {\n }\n 7 = <table> {\n }\n 8 = <table> {\n }\n 9 = <table> {\n }\n}\nGetNineSlicePiece = <function> defined @Interface\\SharedXML\\NineSlice.lua:63\nSetupPieceVisuals = <function> defined @Interface\\SharedXML\\NineSlice.lua:104\n",
			["stack"] = "[string \"@Interface\\SharedXML\\NineSlice.lua\"]:164: in function `ApplyLayout'\n[string \"@Interface\\SharedXML\\Backdrop.lua\"]:314: in function `ApplyBackdrop'\n[string \"@Interface\\SharedXML\\Backdrop.lua\"]:333: in function `SetBackdrop'\n[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:74: in function <Interface\\AddOns\\xVermin\\Addons/Questie.lua:65>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n...\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?",
			["session"] = 3894,
			["counter"] = 57,
		}, -- [88]
		{
			["message"] = "C stack overflow",
			["time"] = "2022/01/05 11:43:25",
			["stack"] = "[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"@Interface\\FrameXML\\RestrictedInfrastructure.lua\"]:117: in function `print'\n[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:47: in function <Interface\\AddOns\\xVermin\\Addons/Questie.lua:46>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n...\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?",
			["session"] = 3894,
			["counter"] = 2504,
		}, -- [89]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:34: attempt to index global 'T' (a nil value)",
			["time"] = "2022/01/05 15:36:05",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:6\n(*temporary) = \"attempt to index global 'T' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:34: in function <Interface\\AddOns\\xVermin\\Addons/Questie.lua:3>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3895,
			["counter"] = 1,
		}, -- [90]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:35: attempt to index global 'T' (a nil value)",
			["time"] = "2022/01/05 15:37:20",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'T' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:35: in function <Interface\\AddOns\\xVermin\\Addons/Questie.lua:3>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3896,
			["counter"] = 1,
		}, -- [91]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:45: attempt to index global 'T' (a nil value)",
			["time"] = "2022/01/05 15:40:26",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'T' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:45: in function <Interface\\AddOns\\xVermin\\Addons/Questie.lua:41>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3898,
			["counter"] = 1,
		}, -- [92]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:37: ')' expected (to close '(' at line 3) near 'end'",
			["time"] = "2022/01/05 15:43:23",
			["locals"] = "",
			["stack"] = "",
			["session"] = 3900,
			["counter"] = 4,
		}, -- [93]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Addons/Questie.lua:35: attempt to index global 'self' (a nil value)",
			["time"] = "2022/01/05 15:44:44",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <function> defined @Interface\\AddOns\\xVermin\\Addons/Questie.lua:6\n(*temporary) = \"attempt to index global 'self' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Addons/Questie.lua\"]:35: in function <Interface\\AddOns\\xVermin\\Addons/Questie.lua:3>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3902,
			["counter"] = 2,
		}, -- [94]
		{
			["message"] = "[string \"local T = C_Timer.NewTicker(1, function()\"]:1: 'end' expected near '<eof>'",
			["time"] = "2022/01/05 17:07:07",
			["locals"] = "(*temporary) = \"local T = C_Timer.NewTicker(1, function()\"\n",
			["stack"] = "[string \"=[C]\"]: in function `RunScript'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2160: in function `?'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4833: in function `ChatEdit_ParseText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:4496: in function `ChatEdit_SendText'\n[string \"@Interface\\FrameXML\\ChatFrame.lua\"]:2918: in function <Interface\\FrameXML\\ChatFrame.lua:2911>\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: ?\n[string \"=[C]\"]: in function `UseAction'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:341: in function `handler'\n[string \"@Interface\\FrameXML\\SecureTemplates.lua\"]:623: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 3903,
			["counter"] = 1,
		}, -- [95]
		{
			["message"] = "[string \"local T = C_Timer.NewTicker(1, function() p...\"]:1: attempt to index global 'T' (a nil value)",
			["time"] = "2022/01/05 17:07:33",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'T' (a nil value)\"\n",
			["stack"] = "[string \"local T = C_Timer.NewTicker(1, function() print(1) T:Cancel() end)\"]:1: in function <[string \"local T = C_Timer.NewTicker(1, function() p...\"]:1>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3903,
			["counter"] = 1,
		}, -- [96]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVermin' tried to call the protected function 'PickupAction()'.",
			["time"] = "2022/01/03 15:20:23",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: in function `PickupAction'\n[string \"*:OnDragStart\"]:2: in function <[string \"*:OnDragStart\"]:1>",
			["session"] = 3905,
			["counter"] = 2,
		}, -- [97]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:235: attempt to call method 'GetNumChildren' (a nil value)",
			["time"] = "2022/01/05 22:39:17",
			["locals"] = "_ = \"xVermin\"\nxVermin = <table> {\n LogBreak = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:56\n FormatNumber = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:90\n Debug = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:14\n Color = <table> {\n }\n Class = \"PRIEST\"\n FormatValue = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:82\n ClassColor = <table> {\n }\n Config = <table> {\n }\n AOE = <function> defined @Interface\\AddOns\\xVermin\\Rotation/_Core.lua:3\n Log = <function> defined @Interface\\AddOns\\xVermin\\Debug.lua:41\n Round = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:107\n TimeFormat = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:134\n ColorGradient = <function> defined @Interface\\AddOns\\xVermin\\Core.lua:119\n}\nf = <unnamed> {\n 0 = <userdata>\n}\nTargetFrameTextAdjustment = <function> defined @Interface\\AddOns\\xVermin\\xVermin.lua:210\ntestF = \"WeakAurasFrame\"\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \"amount children: \"\n(*temporary) = nil\n(*temporary) = \"WeakAurasFrame\"\n(*temporary) = \"attempt to call method 'GetNumChildren' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:235: in main chunk",
			["session"] = 3906,
			["counter"] = 1,
		}, -- [98]
		{
			["message"] = "(null)",
			["session"] = 3906,
			["time"] = "2022/01/02 09:34:18",
			["counter"] = 30,
		}, -- [99]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:227: attempt to index local 'frame' (a nil value)",
			["time"] = "2022/01/05 22:45:03",
			["locals"] = "frame = nil\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \"amount children: \"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'frame' (a nil value)\"\nprint_children = <function> defined @Interface\\AddOns\\xVermin\\xVermin.lua:225\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:227: in function <Interface\\AddOns\\xVermin\\xVermin.lua:225>\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:254: in function <Interface\\AddOns\\xVermin\\xVermin.lua:250>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3910,
			["counter"] = 1,
		}, -- [100]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:234: bad argument #1 to 'gsub' (string expected, got table)",
			["time"] = "2022/01/05 22:58:20",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \".iconFrame\"\n(*temporary) = \"\"\n(*temporary) = \"string expected, got table\"\n",
			["stack"] = "[string \"=[C]\"]: in function `gsub'\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:234: in function <Interface\\AddOns\\xVermin\\xVermin.lua:225>\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:241: in function <Interface\\AddOns\\xVermin\\xVermin.lua:225>\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:241: in function <Interface\\AddOns\\xVermin\\xVermin.lua:225>\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:256: in function <Interface\\AddOns\\xVermin\\xVermin.lua:252>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3919,
			["counter"] = 1,
		}, -- [101]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:234: attempt to call method 'GetName' (a nil value)",
			["time"] = "2022/01/05 22:59:47",
			["locals"] = "frame = <unnamed> {\n 0 = <userdata>\n iconSource = -1\n AnchorSubRegion = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:738\n xOffset = 0\n desaturateIcon = false\n Expand = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:857\n yOffset = -126.999878\n anchorPoint = \"CENTER\"\n SetOrientation = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:879\n icon = <unnamed> {\n }\n SetOffset = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:330\n icon_color = <table> {\n }\n SendChat = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:278\n SetInverse = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:863\n toShow = false\n Resume = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:905\n SetRegionHeight = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:824\n Pause = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:900\n Collapse = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:834\n ClickToPick = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:746\n OptionsClosed = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:741\n bar = <unnamed> {\n }\n startFormatters = <table> {\n }\n UpdateIcon = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:937\n scaley = 1\n regionHasTimer = false\n SetSparkHeight = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:814\n cloneId = \"\"\n Update = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1257\n inverseDirection = false\n regionType = \"aurabar\"\n stacks = <unnamed> {\n }\n GetRegionAlpha = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:399\n relativePoint = \"CENTER\"\n timer = <unnamed> {\n }\n iconVisible = false\n SoundPlay = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:260\n subRegions = <table> {\n }\n GetMinMax = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1253\n zoom = 0\n SetIconColor = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:800\n color_b = 0\n UpdateRegionHasTimerTick = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:421\n alpha = 1\n color_r = 1\n SetXOffset = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:339\n SetRegionWidth = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:820\n Scale = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1315\n RealClearAllPoints = <function> defined =[C]:-1\n UpdateMinMax = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1212\n RunCode = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:285\n customTextFunc = <function> defined Error in: Warrior - Rage Bar':'custom text:1\n GetYOffset = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:351\n SetAnimAlpha = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:403\n color_a = 1\n SetOverlayColor = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:953\n overlaysTexture = <table> {\n }\n SetYOffsetRelative = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:368\n effectiveOrientation = \"HORIZONTAL\"\n ReOrient = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:962\n GetColor = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1158\n ColorAnim = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1150\n GetXOffset = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:347\n SetYOffset = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:343\n Color = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1142\n color_g = 0\n overlays = <table> {\n }\n icon_side = \"RIGHT\"\n GetYOffs",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:234: in function <Interface\\AddOns\\xVermin\\xVermin.lua:225>\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:241: in function <Interface\\AddOns\\xVermin\\xVermin.lua:225>\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:241: in function <Interface\\AddOns\\xVermin\\xVermin.lua:225>\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:256: in function <Interface\\AddOns\\xVermin\\xVermin.lua:252>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3921,
			["counter"] = 1,
		}, -- [102]
		{
			["message"] = "Interface\\AddOns\\xVermin\\xVermin-54000.lua:236: attempt to index field '?' (a nil value)",
			["time"] = "2022/01/05 22:58:56",
			["locals"] = "frame = <unnamed> {\n 0 = <userdata>\n iconSource = -1\n AnchorSubRegion = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:738\n xOffset = 0\n desaturateIcon = false\n Expand = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:857\n yOffset = -107.999817\n anchorPoint = \"CENTER\"\n SetOrientation = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:879\n icon = <unnamed> {\n }\n SetOffset = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:330\n icon_color = <table> {\n }\n SendChat = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:278\n SetInverse = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:863\n toShow = false\n Resume = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:905\n SetRegionHeight = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:824\n Pause = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:900\n Collapse = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:834\n ClickToPick = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:746\n OptionsClosed = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:741\n bar = <unnamed> {\n }\n startFormatters = <table> {\n }\n UpdateIcon = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:937\n scaley = 1\n regionHasTimer = false\n SetSparkHeight = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:814\n cloneId = \"\"\n Update = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1257\n inverseDirection = false\n regionType = \"aurabar\"\n stacks = <unnamed> {\n }\n GetRegionAlpha = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:399\n relativePoint = \"CENTER\"\n timer = <unnamed> {\n }\n iconVisible = false\n SoundPlay = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:260\n subRegions = <table> {\n }\n GetMinMax = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1253\n zoom = 0\n SetIconColor = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:800\n color_b = 0.431373\n UpdateRegionHasTimerTick = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:421\n alpha = 1\n color_r = 0.780392\n SetXOffset = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:339\n SetRegionWidth = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:820\n Scale = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1315\n RealClearAllPoints = <function> defined =[C]:-1\n UpdateMinMax = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1212\n RunCode = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:285\n GetYOffset = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:351\n SetAnimAlpha = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:403\n color_a = 1\n SetOverlayColor = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:953\n overlaysTexture = <table> {\n }\n SetYOffsetRelative = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:368\n effectiveOrientation = \"HORIZONTAL\"\n ReOrient = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:962\n GetColor = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1158\n ColorAnim = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1150\n GetXOffset = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:347\n SetYOffset = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:343\n Color = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\AuraBar.lua:1142\n color_g = 0.611765\n overlays = <table> {\n }\n icon_side = \"RIGHT\"\n GetYOffsetRelative = <function> defined @Interface\\AddOns\\WeakAuras\\R",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:236: in function <Interface\\AddOns\\xVermin\\xVermin.lua:225>\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:241: in function <Interface\\AddOns\\xVermin\\xVermin.lua:225>\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:241: in function <Interface\\AddOns\\xVermin\\xVermin.lua:225>\n[string \"@Interface\\AddOns\\xVermin\\xVermin-54000.lua\"]:256: in function <Interface\\AddOns\\xVermin\\xVermin.lua:252>\n[string \"@Interface\\SharedXML\\C_TimerAugment.lua\"]:16: in function <Interface\\SharedXML\\C_TimerAugment.lua:14>",
			["session"] = 3922,
			["counter"] = 2,
		}, -- [103]
	},
}
