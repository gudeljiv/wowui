
BugGrabberDB = {
	["lastSanitation"] = 3,
	["session"] = 3701,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\xVermin\\BestFood.lua:290: attempt to index local 'b' (a nil value)",
			["time"] = "2021/12/25 16:46:03",
			["locals"] = "a = <table> {\n conj = false\n name = \"Tough Jerky\"\n lvl = 6\n id = 117\n hp = 61.200000\n}\nb = nil\n(*temporary) = false\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'b' (a nil value)\"\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:290: in function <Interface\\AddOns\\xVermin\\BestFood.lua:287>\n[string \"=[C]\"]: in function `sort'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:165: in function `Sorted'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:112: in function `UpdateMacros'\n[string \"@Interface\\AddOns\\xVermin\\BestFood.lua\"]:56: in function <Interface\\AddOns\\xVermin\\BestFood.lua:48>",
			["session"] = 3697,
			["counter"] = 14,
		}, -- [1]
		{
			["message"] = "...\\AddOns\\Details\\Libs\\DetailsFramework\\lib\\slider.lua:456: Action[SetPoint] failed because[SetPoint would result in anchor family connection]: attempted from: DetailsFrameworkSliderButtons1:SetPoint.",
			["time"] = "2021/12/25 16:54:29",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"=[C]\"]: in function `SetPoint'\n[string \"@Interface\\AddOns\\Details\\Libs\\DetailsFramework\\lib\\slider.lua\"]:456: in function `ShowMe'\n[string \"@Interface\\AddOns\\Details\\Libs\\DetailsFramework\\lib\\slider.lua\"]:388: in function <...\\AddOns\\Details\\Libs\\DetailsFramework\\lib\\slider.lua:383>",
			["session"] = 3697,
			["counter"] = 15,
		}, -- [2]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'AdiBags' tried to call the protected function 'PutItemInBag()'.",
			["time"] = "2021/12/25 17:38:24",
			["locals"] = "InCombatSkipped",
			["stack"] = "[string \"@Interface\\AddOns\\!BugGrabber\\BugGrabber.lua\"]:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[string \"=[C]\"]: ?\n[string \"@Interface\\AddOns\\AdiBags\\widgets\\BagSlots.lua\"]:335: in function <Interface\\AddOns\\AdiBags\\widgets\\BagSlots.lua:329>",
			["session"] = 3697,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "...e\\AddOns\\xVermin\\Frames/DefaultFramesCustomScale.lua:45: attempt to index field '?' (a nil value)",
			["time"] = "2021/12/25 17:43:06",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n}\nevent = \"ADDON_LOADED\"\nframelist = <table> {\n 1 = \"TalentFrame\"\n}\n(for generator) = <function> defined =[C]:-1\n(for state) = <table> {\n 1 = \"TalentFrame\"\n}\n(for control) = 1\n_ = 1\nname = \"TalentFrame\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"TalentFrame\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index field '?' (a nil value)\"\nLoDMap = <table> {\n Blizzard_InspectUI = <table> {\n }\n Blizzard_TradeSkillUI = <table> {\n }\n Blizzard_MacroUI = <table> {\n }\n Blizzard_TalentUI = <table> {\n }\n Blizzard_CraftUI = <table> {\n }\n}\n",
			["stack"] = "[string \"@Interface\\AddOns\\xVermin\\Frames/DefaultFramesCustomScale.lua\"]:45: in function <...e\\AddOns\\xVermin\\Frames/DefaultFramesCustomScale.lua:40>\n[string \"=[C]\"]: in function `LoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:365: in function `UIParentLoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:424: in function `PlayerTalentFrame_LoadUI'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:501: in function `ToggleTalentFrame'\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 3697,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "Interface\\AddOns\\xVermin\\Frames/TalentFrame.lua:22: Usage: hooksecurefunc([table,] \"function\", hookfunc)",
			["time"] = "2021/12/25 17:43:06",
			["locals"] = "(*temporary) = <table> {\n UpdateOnBarHighlightMarksBySpell = <function> defined @Interface_Vanilla\\FrameXML\\ActionButton.lua:70\n ActionButton7FlyoutBorder = ActionButton7FlyoutBorder {\n }\n GuildScrollFrameEntry11LeftText = GuildScrollFrameEntry11LeftText {\n }\n MerchantItem9ItemButtonStock = MerchantItem9ItemButtonStock {\n }\n GetTrainerServiceTypeFilter = <function> defined =[C]:-1\n UNIT_NAMES_COMBATLOG_TOOLTIP = \"Color unit names.\"\n SetTrainerServiceTypeFilter = <function> defined =[C]:-1\n LE_GAME_ERR_CHAT_RAID_RESTRICTED_TRIAL = 776\n WeakAurasDisplayButton15ToggleHighlightTexture = WeakAurasDisplayButton15ToggleHighlightTexture {\n }\n LE_GAME_ERR_PET_SPELL_TARGETS_DEAD = 399\n ERROR_CLUB_TICKET_COUNT_AT_MAX_COMMUNITY = \"Can't create any more invite links for this group.\"\n Atr_StackPriceCopperMiddle = Atr_StackPriceCopperMiddle {\n }\n InspectFrameTab1HighlightTexture = InspectFrameTab1HighlightTexture {\n }\n ERR_TRADE_EQUIPPED_BAG = \"You can't trade equipped bags.\"\n PVP_RANK_6_1 = \"Corporal\"\n MultiBarLeftButton7 = MultiBarLeftButton7 {\n }\n OPTION_TOOLTIP_SHOW_MULTIBAR4 = \"Toggles an additional optional actionbar on the right side of the screen.\"\n GuildScrollFrameEntry20 = GuildScrollFrameEntry20 {\n }\n LE_GAME_ERR_INVALID_FOLLOW_PVP_COMBAT = 353\n MerchantItem3AltCurrencyFrameItem1Text = MerchantItem3AltCurrencyFrameItem1Text {\n }\n DetailsWindowOptionsBarTextEditorEntryNumberLines = DetailsWindowOptionsBarTextEditorEntryNumberLines {\n }\n OPTION_TOOLTIP_ACTION_BUTTON_USE_KEY_DOWN = \"Action button keybinds will respond on key down, rather than on key up.\"\n BINDING_NAME_NAMEPLATES = \"Show Enemy Name Plates\"\n INSTANCE_UNAVAILABLE_OTHER_TEMPORARILY_DISABLED = \"%s cannot enter. This instance is temporarily disabled.\"\n DetailsOptionsWindow16UserTimeCapturesAddPanelFuncEntry = DetailsOptionsWindow16UserTimeCapturesAddPanelFuncEntry {\n }\n MultiBarBottomRightButton8Shine5 = MultiBarBottomRightButton8Shine5 {\n }\n RaidGroupButton9RoleTexture = RaidGroupButton9RoleTexture {\n }\n MAIL_LETTER_TOOLTIP = \"Click to make a permanent\ncopy of this letter.\"\n UnitFrameManaBar_UnregisterDefaultEvents = <function> defined @Interface_Vanilla\\FrameXML\\UnitFrame.lua:595\n MANA = \"Mana\"\n CraftExpandTabLeft = CraftExpandTabLeft {\n }\n AuctionsButton2ItemIconTexture = AuctionsButton2ItemIconTexture {\n }\n FCFDockOverflowButton_OnClick = <function> defined @Interface\\FrameXML\\FloatingChatFrame.lua:2379\n MoneyFrame_OnEvent = <function> defined @Interface\\FrameXML\\MoneyFrame.lua:214\n HubPanelProfileDefaultWidgetEliteIndicatorText = HubPanelProfileDefaultWidgetEliteIndicatorText {\n }\n AutoCompleteEditBox_OnKeyDown = <function> defined @Interface\\FrameXML\\AutoComplete.lua:368\n LE_GAME_ERR_ONLY_ONE_QUIVER = 32\n GetMonitorAspectRatio = <function> defined =[C]:-1\n Button_WorldTogglePushedTexture = Button_WorldTogglePushedTexture {\n }\n AdiBagsItemButton4IconQuestTexture = AdiBagsItemButton4IconQuestTexture {\n }\n PetStableMoneyFrameGoldButtonText = PetStableMoneyFrameGoldButtonText {\n }\n TargetFrameDebuff2Icon = TargetFrameDebuff2Icon {\n }\n questieLineFrame38 = questieLineFrame38 {\n }\n VOICEMACRO_4_Sc_1_FEMALE = \"Help me attack!\"\n JoinSkirmish = <function> defined =[C]:-1\n StanceButton4FlyoutArrow = StanceButton4FlyoutArrow {\n }\n MultiBarRightButton7Shine9 = MultiBarRightButton7Shine9 {\n }\n HubPanelProfileDefaultHideAuraDuration = HubPanelProfileDefaultHideAuraDuration {\n }\n DMG_LCD = \"DMG\"\n ACTION_SPELL_MISSED_POSSESSIVE = \"1\"\n HubPanelProfileDefaultFriendlyNameColorMode = HubPanelProfileDefaultFriendlyNameColorMode {\n }\n BattlefieldMapFrameLeft = BattlefieldMapFrameLeft {\n }\n Advanced_AdapterDropDownWarning = Advanced_AdapterDropDownWarning {\n }\n SecureCmdItemParse = <function> defined @Interface\\FrameXML\\ChatFrame.lua:1123\n TELLMEWHEN_VERSION_FULL = \"9.1.2 Classic \"\n DetailsOptionsWindow1ClassColorsButton_TextureDisabled = DetailsOptionsWindow1ClassColorsButton_TextureDisabled {\n }\n SortQuestWatches = <function> defined =[C]:-1\n ContainerFrame4Item16Cooldown = ContainerFrame4Item16Cooldown {\n }\n MINIMAP_TRACKING_TRAINER_CLASS = \"Class Trainer\"\n DetailsOptionsWindow3C",
			["stack"] = "[string \"=[C]\"]: in function `hooksecurefunc'\n[string \"@Interface\\AddOns\\xVermin\\Frames/TalentFrame.lua\"]:22: in function <Interface\\AddOns\\xVermin\\Frames/TalentFrame.lua:20>\n[string \"=[C]\"]: in function `LoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:365: in function `UIParentLoadAddOn'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:424: in function `PlayerTalentFrame_LoadUI'\n[string \"@Interface_Vanilla\\FrameXML\\UIParent.lua\"]:501: in function `ToggleTalentFrame'\n[string \"TOGGLETALENTS\"]:1: in function <[string \"TOGGLETALENTS\"]:1>",
			["session"] = 3697,
			["counter"] = 1,
		}, -- [5]
	},
}
