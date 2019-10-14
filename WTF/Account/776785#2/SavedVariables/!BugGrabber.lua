
BugGrabberDB = {
	["session"] = 460,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\nHealth\\core.lua:92: attempt to concatenate global 'max' (a function value)",
			["time"] = "2019/10/13 15:33:23",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = \" : \"\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = \"attempt to concatenate global 'max' (a function value)\"\nf = <unnamed> {\n 0 = <userdata>\n Health = <unnamed> {\n }\n fadeInfo = <table> {\n }\n}\nFormatValue = <function> defined @Interface\\AddOns\\nHealth\\core.lua:64\n",
			["stack"] = "Interface\\AddOns\\nHealth\\core.lua:92: in function <Interface\\AddOns\\nHealth\\core.lua:84>\nInterface\\AddOns\\nHealth\\core.lua:111: in function <Interface\\AddOns\\nHealth\\core.lua:109>\nInterface\\AddOns\\nHealth\\core.lua:138: in function <Interface\\AddOns\\nHealth\\core.lua:134>",
			["session"] = 381,
			["counter"] = 398,
		}, -- [1]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\xVerminz-54000.lua:370: 'then' expected near 'print'",
			["time"] = "2019/10/13 15:45:09",
			["locals"] = "",
			["stack"] = "",
			["session"] = 387,
			["counter"] = 4,
		}, -- [2]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\xVerminz-54000.lua:373: attempt to index global 'frmautorepair' (a nil value)",
			["time"] = "2019/10/13 16:00:21",
			["locals"] = "frame = CVarSet {\n 0 = <userdata>\n}\nfont = \"Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf\"\nf = <unnamed> {\n 0 = <userdata>\n}\ntDelay = 0\nFastLoot = <function> defined @Interface\\AddOns\\xVerminz\\xVerminz.lua:342\nfaster = <unnamed> {\n 0 = <userdata>\n}\nmaxammo = 2000\nammoCount = 611\nneedtobuy = 1389\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = true\n(*temporary) = \"attempt to index global 'frmautorepair' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\xVerminz-54000.lua:373: in main chunk",
			["session"] = 391,
			["counter"] = 2,
		}, -- [3]
		{
			["message"] = "Error loading Interface\\AddOns\\xVerminz\\AutoRepair.lua",
			["time"] = "2019/10/13 16:00:25",
			["session"] = 391,
			["counter"] = 6,
		}, -- [4]
		{
			["message"] = "(null)",
			["time"] = "2019/10/13 16:00:25",
			["session"] = 391,
			["counter"] = 6,
		}, -- [5]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: attempt to concatenate local 'isUsable' (a boolean value)",
			["time"] = "2019/10/13 16:07:48",
			["locals"] = "numItems = 6\n(for index) = 3\n(for limit) = 6\n(for step) = 1\nitem = 3\nname = \"Rough Arrow\"\ntexture = 132382\nprice = 10\nquantity = 200\nnumAvailable = -1\nisUsable = true\nextendedCost = true\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \"imam arrow --> \"\n(*temporary) = 3\n(*temporary) = \" - \"\n(*temporary) = true\n(*temporary) = \"attempt to concatenate local 'isUsable' (a boolean value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 396,
			["counter"] = 1,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:8: 'then' expected near 'usable'",
			["time"] = "2019/10/13 16:09:03",
			["locals"] = "",
			["stack"] = "",
			["session"] = 397,
			["counter"] = 4,
		}, -- [7]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:9: attempt to concatenate local 'isUsable' (a boolean value)",
			["time"] = "2019/10/13 16:09:37",
			["locals"] = "numItems = 6\n(for index) = 3\n(for limit) = 6\n(for step) = 1\nitem = 3\nname = \"Rough Arrow\"\ntexture = 132382\nprice = 10\nquantity = 200\nnumAvailable = -1\nisUsable = true\nextendedCost = true\nusable = \"da\"\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \"imam arrow --> \"\n(*temporary) = 3\n(*temporary) = \" - \"\n(*temporary) = true\n(*temporary) = \"attempt to concatenate local 'isUsable' (a boolean value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:9: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 398,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "[string \"1%2\"]:1: unexpected symbol near '1'",
			["time"] = "2019/10/13 16:14:15",
			["locals"] = "(*temporary) = \"1%2\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2699: in function <Interface\\FrameXML\\ChatFrame.lua:2692>\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 403,
			["counter"] = 1,
		}, -- [9]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: attempt to index local 'name' (a nil value)",
			["time"] = "2019/10/13 16:04:46",
			["locals"] = "numItems = 6\n(for index) = 0\n(for limit) = 6\n(for step) = 1\nitem = 0\nname = nil\ntexture = nil\nprice = nil\nquantity = nil\nnumAvailable = nil\nisUsable = nil\nextendedCost = nil\n(*temporary) = nil\n(*temporary) = ChatFrame1 {\n SetJustifyV = <function> defined =[C]:-1\n RefreshIfNecessary = <function> defined =[C]:-1\n OnPostShow = <function> defined =[C]:-1\n CalculateLineAlphaValueFromTimestamp = <function> defined =[C]:-1\n isLayoutDirty = false\n tellTimer = 401030.258000\n isDisplayDirty = true\n GetFading = <function> defined =[C]:-1\n IsTextCopyable = <function> defined =[C]:-1\n shouldFadeAfterInactivity = true\n SetIndentedWordWrap = <function> defined =[C]:-1\n init = 0\n GetJustifyV = <function> defined =[C]:-1\n SetFont = <function> defined =[C]:-1\n GetMaxLines = <function> defined =[C]:-1\n GetIndentedWordWrap = <function> defined =[C]:-1\n buttonSide = \"left\"\n GetFont = <function> defined =[C]:-1\n checkedGMOTD = true\n SetMaxLines = <function> defined =[C]:-1\n CalculateSelectingCharacterIndicesForVisibleLine = <function> defined =[C]:-1\n PageUp = <function> defined =[C]:-1\n RefreshDisplay = <function> defined =[C]:-1\n SetFontObject = <function> defined =[C]:-1\n textIsCopyable = false\n SetOnScrollChangedCallback = <function> defined =[C]:-1\n CalculateNumVisibleLines = <function> defined =[C]:-1\n overrideFadeTimestamp = 401034.311000\n MarkDisplayDirty = <function> defined =[C]:-1\n GetMessageInfo = <function> defined =[C]:-1\n GetOnScrollChangedCallback = <function> defined =[C]:-1\n AtTop = <function> defined =[C]:-1\n GetFontObject = <function> defined =[C]:-1\n fontStringPool = <table> {\n }\n CanEffectivelyFade = <function> defined =[C]:-1\n OnPreSizeChanged = <function> defined =[C]:-1\n OnPostMouseUp = <function> defined =[C]:-1\n GetSpacing = <function> defined =[C]:-1\n OnPreLoad = <function> defined =[C]:-1\n SetSpacing = <function> defined =[C]:-1\n name = \"General\"\n CalculateLineSpacing = <function> defined =[C]:-1\n AddMessage = <function> defined @Interface\\AddOns\\xVerminz\\Chat.lua:49\n InitializeFontableFrame = <function> defined =[C]:-1\n GetShadowColor = <function> defined =[C]:-1\n isUninteractable = false\n SetOnTextCopiedCallback = <function> defined =[C]:-1\n mouseOutTime = 2.691000\n AcquireFontString = <function> defined =[C]:-1\n TransformMessages = <function> defined =[C]:-1\n SetShadowColor = <function> defined =[C]:-1\n buttonFrame = ChatFrame1ButtonFrame {\n }\n HasFontObject = <function> defined =[C]:-1\n isDocked = 1\n GetOnTextCopiedCallback = <function> defined =[C]:-1\n SetFading = <function> defined =[C]:-1\n OnPostHide = <function> defined =[C]:-1\n alternativeDefaultLanguage = \"Orcish\"\n isInitialized = 1\n ScrollByAmount = <function> defined =[C]:-1\n GetInsertMode = <function> defined =[C]:-1\n SetTimeVisible = <function> defined =[C]:-1\n hasOwnFontObject = true\n Clear = <function> defined =[C]:-1\n oldAlpha = 0\n channelList = <table> {\n }\n GetTimeVisible = <function> defined =[C]:-1\n MarkLayoutDirty = <function> defined =[C]:-1\n SetTextCopyable = <function> defined =[C]:-1\n BackFillMessage = <function> defined =[C]:-1\n UnpackageEntry = <function> defined =[C]:-1\n FontStringContainer = <unnamed> {\n }\n SetShadowOffset = <function> defined =[C]:-1\n messageTypeList = <table> {\n }\n flashTimer = 0\n timeVisibleSecs = 120\n PackageEntry = <function> defined =[C]:-1\n chatframe = ChatFrame1 {\n }\n MakeFontObjectCustom = <function> defined =[C]:-1\n SetPoint = <function> defined @Interface\\AddOns\\xVerminz\\Chat.lua:188\n fontObject = table: 00000171380C84B0 {\n }\n SetInsertMode = <function> defined =[C]:-1\n mouseInTime = 0\n ScrollDown = <function> defined =[C]:-1\n zoneChannelList = <table> {\n }\n SetScrollOffset = <function> defined =[C]:-1\n onDisplayRefreshedCallback = <function> defined =[C]:-1\n insertMode = 2\n ResetSelectingText = <function> defined =[C]:-1\n defaultLanguage = \"Orcish\"\n GetTextColor = <function> defined =[C]:-1\n ResetAllFadeTimes = <function> defined =[C]:-1\n GatherSelectedText = <function> defined =[C]:-1\n GetNumVisibleLines = <function> defined =[C]:-1\n ScrollUp = <function> defined =[C]:-1\n 0 = <userdata>\n IsSelectingText ",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 413,
			["counter"] = 2,
		}, -- [10]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: attempt to concatenate local 'name' (a nil value)",
			["time"] = "2019/10/13 16:44:38",
			["locals"] = "numItems = 9\niindex = nil\n(for index) = 1\n(for limit) = 9\n(for step) = 1\nitem = 1\nname = nil\ntexture = 133581\nprice = 1000\nquantity = 1\nnumAvailable = -1\nisUsable = true\nextendedCost = true\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \" - 1\"\n(*temporary) = \"1\"\n(*temporary) = \"attempt to concatenate local 'name' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 414,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:10: attempt to index local 'name' (a nil value)",
			["time"] = "2019/10/13 16:47:19",
			["locals"] = "numItems = 33\nindex = nil\n(for index) = 3\n(for limit) = 33\n(for step) = 1\nitem = 3\nname = nil\ntexture = 133057\nprice = 18\nquantity = 1\nnumAvailable = -1\nisUsable = true\nextendedCost = true\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = 3\n(*temporary) = \" \"\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'name' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:10: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 415,
			["counter"] = 2,
		}, -- [12]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:16: attempt to index local 'name' (a nil value)",
			["time"] = "2019/10/13 16:53:12",
			["locals"] = "numItems = 17\nindex = nil\n(for index) = 7\n(for limit) = 17\n(for step) = 1\nitem = 7\nname = nil\ntexture = 136120\nprice = 5000\nquantity = 1\nnumAvailable = -1\nisUsable = true\nextendedCost = true\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = 0.100000\n(*temporary) = <function> defined @Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1\n(*temporary) = <function> defined @Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1\n(*temporary) = \"attempt to index local 'name' (a nil value)\"\nBuyAmmo = <function> defined @Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:16: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 418,
			["counter"] = 4,
		}, -- [13]
		{
			["message"] = "Error loading Interface\\AddOns\\xVerminz\\PetHapiness.lua",
			["session"] = 430,
			["time"] = "2019/10/13 17:14:03",
			["counter"] = 6,
		}, -- [14]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:15: Usage: GetItemInfo(itemID|\"name\"|\"itemlink\")",
			["time"] = "2019/10/13 22:36:25",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetItemInfo'\nInterface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:15: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 448,
			["counter"] = 1,
		}, -- [15]
		{
			["message"] = "[string \"print(GetMerchantItemCostItem(1))\"]:1: Usage: GetMerchantItemCostItem(index, itemIndex)",
			["time"] = "2019/10/13 22:42:32",
			["locals"] = "(*temporary) = 1\n",
			["stack"] = "[C]: in function `GetMerchantItemCostItem'\n[string \"print(GetMerchantItemCostItem(1))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 451,
			["counter"] = 1,
		}, -- [16]
		{
			["message"] = "[string \"print(GetItemInfo([Rought Arrow]))\"]:1: unexpected symbol near '['",
			["time"] = "2019/10/13 22:47:31",
			["locals"] = "(*temporary) = \"print(GetItemInfo([Rought Arrow]))\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 451,
			["counter"] = 1,
		}, -- [17]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn '!Colorz' tried to call the protected function 'CompactRaidFrame1:ClearAllPoints()'.",
			["time"] = "2019/10/13 16:30:57",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:62: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 453,
			["counter"] = 2,
		}, -- [18]
	},
}
