
BugGrabberDB = {
	["lastSanitation"] = 3,
	["session"] = 583,
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
			["session"] = 391,
			["time"] = "2019/10/13 16:00:25",
			["counter"] = 6,
		}, -- [4]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: attempt to concatenate local 'isUsable' (a boolean value)",
			["time"] = "2019/10/13 16:07:48",
			["locals"] = "numItems = 6\n(for index) = 3\n(for limit) = 6\n(for step) = 1\nitem = 3\nname = \"Rough Arrow\"\ntexture = 132382\nprice = 10\nquantity = 200\nnumAvailable = -1\nisUsable = true\nextendedCost = true\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \"imam arrow --> \"\n(*temporary) = 3\n(*temporary) = \" - \"\n(*temporary) = true\n(*temporary) = \"attempt to concatenate local 'isUsable' (a boolean value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 396,
			["counter"] = 1,
		}, -- [5]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:8: 'then' expected near 'usable'",
			["time"] = "2019/10/13 16:09:03",
			["locals"] = "",
			["stack"] = "",
			["session"] = 397,
			["counter"] = 4,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:9: attempt to concatenate local 'isUsable' (a boolean value)",
			["time"] = "2019/10/13 16:09:37",
			["locals"] = "numItems = 6\n(for index) = 3\n(for limit) = 6\n(for step) = 1\nitem = 3\nname = \"Rough Arrow\"\ntexture = 132382\nprice = 10\nquantity = 200\nnumAvailable = -1\nisUsable = true\nextendedCost = true\nusable = \"da\"\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = \"imam arrow --> \"\n(*temporary) = 3\n(*temporary) = \" - \"\n(*temporary) = true\n(*temporary) = \"attempt to concatenate local 'isUsable' (a boolean value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:9: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 398,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "[string \"1%2\"]:1: unexpected symbol near '1'",
			["time"] = "2019/10/13 16:14:15",
			["locals"] = "(*temporary) = \"1%2\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2699: in function <Interface\\FrameXML\\ChatFrame.lua:2692>\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 403,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: attempt to index local 'name' (a nil value)",
			["time"] = "2019/10/13 16:04:46",
			["locals"] = "numItems = 6\n(for index) = 0\n(for limit) = 6\n(for step) = 1\nitem = 0\nname = nil\ntexture = nil\nprice = nil\nquantity = nil\nnumAvailable = nil\nisUsable = nil\nextendedCost = nil\n(*temporary) = nil\n(*temporary) = ChatFrame1 {\n SetJustifyV = <function> defined =[C]:-1\n RefreshIfNecessary = <function> defined =[C]:-1\n OnPostShow = <function> defined =[C]:-1\n CalculateLineAlphaValueFromTimestamp = <function> defined =[C]:-1\n isLayoutDirty = false\n tellTimer = 401030.258000\n isDisplayDirty = true\n GetFading = <function> defined =[C]:-1\n IsTextCopyable = <function> defined =[C]:-1\n shouldFadeAfterInactivity = true\n SetIndentedWordWrap = <function> defined =[C]:-1\n init = 0\n GetJustifyV = <function> defined =[C]:-1\n SetFont = <function> defined =[C]:-1\n GetMaxLines = <function> defined =[C]:-1\n GetIndentedWordWrap = <function> defined =[C]:-1\n buttonSide = \"left\"\n GetFont = <function> defined =[C]:-1\n checkedGMOTD = true\n SetMaxLines = <function> defined =[C]:-1\n CalculateSelectingCharacterIndicesForVisibleLine = <function> defined =[C]:-1\n PageUp = <function> defined =[C]:-1\n RefreshDisplay = <function> defined =[C]:-1\n SetFontObject = <function> defined =[C]:-1\n textIsCopyable = false\n SetOnScrollChangedCallback = <function> defined =[C]:-1\n CalculateNumVisibleLines = <function> defined =[C]:-1\n overrideFadeTimestamp = 401034.311000\n MarkDisplayDirty = <function> defined =[C]:-1\n GetMessageInfo = <function> defined =[C]:-1\n GetOnScrollChangedCallback = <function> defined =[C]:-1\n AtTop = <function> defined =[C]:-1\n GetFontObject = <function> defined =[C]:-1\n fontStringPool = <table> {\n }\n CanEffectivelyFade = <function> defined =[C]:-1\n OnPreSizeChanged = <function> defined =[C]:-1\n OnPostMouseUp = <function> defined =[C]:-1\n GetSpacing = <function> defined =[C]:-1\n OnPreLoad = <function> defined =[C]:-1\n SetSpacing = <function> defined =[C]:-1\n name = \"General\"\n CalculateLineSpacing = <function> defined =[C]:-1\n AddMessage = <function> defined @Interface\\AddOns\\xVerminz\\Chat.lua:49\n InitializeFontableFrame = <function> defined =[C]:-1\n GetShadowColor = <function> defined =[C]:-1\n isUninteractable = false\n SetOnTextCopiedCallback = <function> defined =[C]:-1\n mouseOutTime = 2.691000\n AcquireFontString = <function> defined =[C]:-1\n TransformMessages = <function> defined =[C]:-1\n SetShadowColor = <function> defined =[C]:-1\n buttonFrame = ChatFrame1ButtonFrame {\n }\n HasFontObject = <function> defined =[C]:-1\n isDocked = 1\n GetOnTextCopiedCallback = <function> defined =[C]:-1\n SetFading = <function> defined =[C]:-1\n OnPostHide = <function> defined =[C]:-1\n alternativeDefaultLanguage = \"Orcish\"\n isInitialized = 1\n ScrollByAmount = <function> defined =[C]:-1\n GetInsertMode = <function> defined =[C]:-1\n SetTimeVisible = <function> defined =[C]:-1\n hasOwnFontObject = true\n Clear = <function> defined =[C]:-1\n oldAlpha = 0\n channelList = <table> {\n }\n GetTimeVisible = <function> defined =[C]:-1\n MarkLayoutDirty = <function> defined =[C]:-1\n SetTextCopyable = <function> defined =[C]:-1\n BackFillMessage = <function> defined =[C]:-1\n UnpackageEntry = <function> defined =[C]:-1\n FontStringContainer = <unnamed> {\n }\n SetShadowOffset = <function> defined =[C]:-1\n messageTypeList = <table> {\n }\n flashTimer = 0\n timeVisibleSecs = 120\n PackageEntry = <function> defined =[C]:-1\n chatframe = ChatFrame1 {\n }\n MakeFontObjectCustom = <function> defined =[C]:-1\n SetPoint = <function> defined @Interface\\AddOns\\xVerminz\\Chat.lua:188\n fontObject = table: 00000171380C84B0 {\n }\n SetInsertMode = <function> defined =[C]:-1\n mouseInTime = 0\n ScrollDown = <function> defined =[C]:-1\n zoneChannelList = <table> {\n }\n SetScrollOffset = <function> defined =[C]:-1\n onDisplayRefreshedCallback = <function> defined =[C]:-1\n insertMode = 2\n ResetSelectingText = <function> defined =[C]:-1\n defaultLanguage = \"Orcish\"\n GetTextColor = <function> defined =[C]:-1\n ResetAllFadeTimes = <function> defined =[C]:-1\n GatherSelectedText = <function> defined =[C]:-1\n GetNumVisibleLines = <function> defined =[C]:-1\n ScrollUp = <function> defined =[C]:-1\n 0 = <userdata>\n IsSelectingText ",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 413,
			["counter"] = 2,
		}, -- [9]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: attempt to concatenate local 'name' (a nil value)",
			["time"] = "2019/10/13 16:44:38",
			["locals"] = "numItems = 9\niindex = nil\n(for index) = 1\n(for limit) = 9\n(for step) = 1\nitem = 1\nname = nil\ntexture = 133581\nprice = 1000\nquantity = 1\nnumAvailable = -1\nisUsable = true\nextendedCost = true\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \" - 1\"\n(*temporary) = \"1\"\n(*temporary) = \"attempt to concatenate local 'name' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:7: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 414,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:10: attempt to index local 'name' (a nil value)",
			["time"] = "2019/10/13 16:47:19",
			["locals"] = "numItems = 33\nindex = nil\n(for index) = 3\n(for limit) = 33\n(for step) = 1\nitem = 3\nname = nil\ntexture = 133057\nprice = 18\nquantity = 1\nnumAvailable = -1\nisUsable = true\nextendedCost = true\n(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = 3\n(*temporary) = \" \"\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'name' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:10: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 415,
			["counter"] = 2,
		}, -- [11]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:16: attempt to index local 'name' (a nil value)",
			["time"] = "2019/10/13 16:53:12",
			["locals"] = "numItems = 17\nindex = nil\n(for index) = 7\n(for limit) = 17\n(for step) = 1\nitem = 7\nname = nil\ntexture = 136120\nprice = 5000\nquantity = 1\nnumAvailable = -1\nisUsable = true\nextendedCost = true\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = 0.100000\n(*temporary) = <function> defined @Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1\n(*temporary) = <function> defined @Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1\n(*temporary) = \"attempt to index local 'name' (a nil value)\"\nBuyAmmo = <function> defined @Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:16: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 418,
			["counter"] = 4,
		}, -- [12]
		{
			["message"] = "Error loading Interface\\AddOns\\xVerminz\\PetHapiness.lua",
			["time"] = "2019/10/13 17:14:03",
			["session"] = 430,
			["counter"] = 6,
		}, -- [13]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:15: Usage: GetItemInfo(itemID|\"name\"|\"itemlink\")",
			["time"] = "2019/10/13 22:36:25",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetItemInfo'\nInterface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:15: in function <Interface\\AddOns\\xVerminz\\AutoBuyAmmo.lua:1>",
			["session"] = 448,
			["counter"] = 1,
		}, -- [14]
		{
			["message"] = "[string \"print(GetMerchantItemCostItem(1))\"]:1: Usage: GetMerchantItemCostItem(index, itemIndex)",
			["time"] = "2019/10/13 22:42:32",
			["locals"] = "(*temporary) = 1\n",
			["stack"] = "[C]: in function `GetMerchantItemCostItem'\n[string \"print(GetMerchantItemCostItem(1))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 451,
			["counter"] = 1,
		}, -- [15]
		{
			["message"] = "[string \"print(GetItemInfo([Rought Arrow]))\"]:1: unexpected symbol near '['",
			["time"] = "2019/10/13 22:47:31",
			["locals"] = "(*temporary) = \"print(GetItemInfo([Rought Arrow]))\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 451,
			["counter"] = 1,
		}, -- [16]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:207: attempt to index global 'NeedsFoodBadly' (a nil value)",
			["time"] = "2019/10/14 17:46:38",
			["locals"] = "(*temporary) = nil\n(*temporary) = <table> {\n 8957 = <table> {\n }\n 17344 = <table> {\n }\n 13810 = <table> {\n }\n 18635 = <table> {\n }\n 3726 = <table> {\n }\n 3727 = <table> {\n }\n 2070 = <table> {\n }\n 20452 = <table> {\n }\n 3729 = <table> {\n }\n 17404 = <table> {\n }\n 3220 = <table> {\n }\n 1487 = <table> {\n }\n 19225 = <table> {\n }\n 422 = <table> {\n }\n 17197 = <table> {\n }\n 20516 = <table> {\n }\n 21030 = <table> {\n }\n 8766 = <table> {\n }\n 21552 = <table> {\n }\n 4656 = <table> {\n }\n 16167 = <table> {\n }\n 16169 = <table> {\n }\n 16171 = <table> {\n }\n 19301 = <table> {\n }\n 19305 = <table> {\n }\n 20074 = <table> {\n }\n 8543 = <table> {\n }\n 22895 = <table> {\n }\n 1113 = <table> {\n }\n 11109 = <table> {\n }\n 1114 = <table> {\n }\n 1179 = <table> {\n }\n 13928 = <table> {\n }\n 13930 = <table> {\n }\n 13932 = <table> {\n }\n 13934 = <table> {\n }\n 18632 = <table> {\n }\n 1119 = <table> {\n }\n 19696 = <table> {\n }\n 5472 = <table> {\n }\n 8364 = <table> {\n }\n 5474 = <table> {\n }\n 5476 = <table> {\n }\n 4457 = <table> {\n }\n 5478 = <table> {\n }\n 21023 = <table> {\n }\n 5480 = <table> {\n }\n 21031 = <table> {\n }\n 787 = <table> {\n }\n 3770 = <table> {\n }\n 17222 = <table> {\n }\n 16971 = <table> {\n }\n 18254 = <table> {\n }\n 724 = <table> {\n }\n 5473 = <table> {\n }\n 8075 = <table> {\n }\n 12209 = <table> {\n }\n 9681 = <table> {\n }\n 21217 = <table> {\n }\n 19306 = <table> {\n }\n 21215 = <table> {\n }\n 8078 = <table> {\n }\n 11444 = <table> {\n }\n 21240 = <table> {\n }\n 7806 = <table> {\n }\n 8932 = <table> {\n }\n 12211 = <table> {\n }\n 19995 = <table> {\n }\n 2888 = <table> {\n }\n 21033 = <table> {\n }\n 19223 = <table> {\n }\n 17408 = <table> {\n }\n 23160 = <table> {\n }\n 8948 = <table> {\n }\n 8950 = <table> {\n }\n 8952 = <table> {\n }\n 7808 = <table> {\n }\n 13546 = <table> {\n }\n 17199 = <table> {\n }\n 19994 = <table> {\n }\n 7807 = <table> {\n }\n 159 = <table> {\n }\n 18633 = <table> {\n }\n 13813 = <table> {\n }\n 1707 = <table> {\n }\n 3663 = <table> {\n }\n 17119 = <table> {\n }\n 21235 = <table> {\n }\n 1708 = <table> {\n }\n 5526 = <table> {\n }\n 5527 = <table> {\n }\n 1645 = <table> {\n }\n 8079 = <table> {\n }\n 12763 = <table> {\n }\n 3666 = <table> {\n }\n 6807 = <table> {\n }\n 21236 = <table> {\n }\n 6299 = <table> {\n }\n 5057 = <table> {\n }\n 21254 = <table> {\n }\n 22324 = <table> {\n }\n 1017 = <table> {\n }\n 13851 = <table> {\n }\n 414 = <table> {\n }\n 19996 = <table> {\n }\n 17406 = <table> {\n }\n 3927 = <table> {\n }\n 16170 = <table> {\n }\n 19224 = <table> {\n }\n 19299 = <table> {\n }\n 2288 = <table> {\n }\n 12215 = <table> {\n }\n 16166 = <table> {\n }\n 16168 = <table> {\n }\n 6316 = <table> {\n }\n 18255 = <table> {\n }\n 1205 = <table> {\n }\n 2682 = <table> {\n }\n 21072 = <table> {\n }\n 4536 = <table> {\n }\n 4537 = <table> {\n }\n 4538 = <table> {\n }\n 4539 = <table> {\n }\n 4540 = <table> {\n }\n 733 = <table> {\n }\n 4542 = <table> {\n }\n 11584 = <table> {\n }\n 4544 = <table> {\n }\n 7228 = <table> {\n }\n 3662 = <table> {\n }\n 7097 = <table> {\n }\n 19300 = <table> {\n }\n 17198 = <table> {\n }\n 23172 = <table> {\n }\n 1082 = <table> {\n }\n 1401 = <table> {\n }\n 4541 = <table> {\n }\n 5525 = <table> {\n }\n 8076 = <table> {\n }\n 5066 = <table> {\n }\n 13927 = <table> {\n }\n 13929 = <table> {\n }\n 13931 = <table> {\n }\n 13933 = <table> {\n }\n 13935 = <table> {\n }\n 1326 = <table> {\n }\n 5350 = <table> {\n }\n 6888 = <table> {\n }\n 6038 = <table> {\n }\n 4606 = <table> {\n }\n 20031 = <table> {\n }\n 3448 = <table> {\n }\n 18300 = <table> {\n }\n 5479 = <table> {\n }\n 4607 = <table> {\n }\n 4605 = <table> {\n }\n 2136 = <table> {\n }\n 6887 = <table> {\n }\n 17407 = <table> {\n }\n 11415 = <table> {\n }\n 2679 = <table> {\n }\n 5477 = <table> {\n }\n 2680 = <table> {\n }\n 961 = <table> {\n }\n 2681 = <table> {\n }\n 3664 = <table> {\n }\n 13724 = <table> {\n }\n 5349 = <table> {\n }\n 5095 = <table> {\n }\n 3772 = <table> {\n }\n 2684 = <table> {\n }\n 2287 = <table> {\n }\n 2685 = <table> {\n }\n 2683 = <table> {\n }\n 12210 = <table> {\n }\n 4592 = <table> {\n }\n 4593 = <table> {\n }\n 12216 = <table> {\n }\n 12218 = <table> {\n }\n 8077 = <table> {\n }\n 2687 = <table> {\n }\n 12224 = <table> {\n }\n 4599 = <table> {\n }\n 6890 = <table> {\n }\n 4601 = <table> {\n }\n 4602 = <table> {\n }\n 19304 = <table> {\n }\n 4604 = <table> {\n }\n 12238 = <table> {\n }\n 16766",
			["stack"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:207: in main chunk",
			["session"] = 474,
			["counter"] = 1,
		}, -- [17]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:122: attempt to index field 'petfood' (a nil value)",
			["time"] = "2019/10/14 18:00:33",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:185\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:160\n IsUsableFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:140\n BetterFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:206\n PetFood = <table> {\n }\n Bandage = <table> {\n }\n ManaGem = <table> {\n }\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:153\n Potion = <table> {\n }\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:173\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:247\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:180\n dirty = false\n BetterBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:255\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:50\n BetterHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:239\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:166\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:200\n BetterMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:243\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:235\n BetterManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:251\n Sorted = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:131\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:147\n BuildSequence = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:264\n BetterDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:223\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:219\n}\nbest = <table> {\n drink = <table> {\n }\n food = <table> {\n }\n manaGem = <table> {\n }\n mPotion = <table> {\n }\n bandage = <table> {\n }\n healthstone = <table> {\n }\n buffFood = <table> {\n }\n hPotion = <table> {\n }\n buffDrink = <table> {\n }\n}\n_ = \"Hunter\"\nclass = \"HUNTER\"\n_ = 3\npetType = \"Boar\"\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = \"#showtooltip <petfood>\n/cast feed pet\n/use <petfood>\n\"\n(*temporary) = \"<%a+>\"\n(*temporary) = <table> {\n}\n(*temporary) = \"item:\"\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = nil\n(*temporary) = 2\n(*temporary) = \"attempt to index field 'petfood' (a nil value)\"\ndefaultFoodMacro = \"#showtooltip\n/use [mod:shift]<bandage>;[nocombat,mod]<buffFood>;[nocombat]<food>\n/castsequence [combat]<hPotions>\n\"\ndefaultDrinkMacro = \"#showtooltip\n/use [nocombat,mod]<manaBuff>;[nocombat]<drink>\n/castsequence [combat]<mPotions>\n\"\nCreateOrUpdateMacro = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:22\ndefaultPetFoodMacro = \"#showtooltip <petfood>\n/cast feed pet\n/use <petfood>\n\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:122: in function `UpdateMacros'\nInterface\\AddOns\\xVerminz\\BestFood.lua:42: in function <Interface\\AddOns\\xVerminz\\BestFood.lua:37>",
			["session"] = 480,
			["counter"] = 1,
		}, -- [18]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:86: attempt to index field 'petefood' (a nil value)",
			["time"] = "2019/10/14 18:02:59",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:189\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:164\n IsUsableFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:144\n BetterFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:210\n PetFood = <table> {\n }\n Bandage = <table> {\n }\n ManaGem = <table> {\n }\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:264\n Potion = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:260\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:177\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:151\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:184\n BetterBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:272\n dirty = false\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:50\n BetterHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:256\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:170\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:204\n BetterPetFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:223\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:252\n BetterManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:268\n Sorted = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:135\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:157\n BuildSequence = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:281\n BetterDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:240\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:236\n}\nbest = <table> {\n drink = <table> {\n }\n food = <table> {\n }\n manaGem = <table> {\n }\n mPotion = <table> {\n }\n bandage = <table> {\n }\n healthstone = <table> {\n }\n buffFood = <table> {\n }\n hPotion = <table> {\n }\n buffDrink = <table> {\n }\n}\n(for index) = 0\n(for limit) = 4\n(for step) = 1\nbag = 0\n(for index) = 1\n(for limit) = 16\n(for step) = 1\nslot = 1\nid = 2287\n(*temporary) = nil\n(*temporary) = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:189\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:164\n IsUsableFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:144\n BetterFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:210\n PetFood = <table> {\n }\n Bandage = <table> {\n }\n ManaGem = <table> {\n }\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:264\n Potion = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:260\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:177\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:151\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:184\n BetterBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:272\n dirty = false\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:50\n BetterHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:256\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:170\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:204\n BetterPetFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:223\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:252\n BetterManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:268\n Sorted = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:135\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:157\n BuildSequen",
			["stack"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:86: in function `UpdateMacros'\nInterface\\AddOns\\xVerminz\\BestFood.lua:42: in function <Interface\\AddOns\\xVerminz\\BestFood.lua:37>",
			["session"] = 481,
			["counter"] = 1,
		}, -- [19]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:86: attempt to index field 'petfood' (a nil value)",
			["time"] = "2019/10/14 18:03:26",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:189\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:164\n IsUsableFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:144\n BetterFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:210\n PetFood = <table> {\n }\n Bandage = <table> {\n }\n ManaGem = <table> {\n }\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:264\n Potion = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:260\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:177\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:151\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:184\n BetterBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:272\n dirty = false\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:50\n BetterHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:256\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:170\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:204\n BetterPetFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:223\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:252\n BetterManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:268\n Sorted = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:135\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:157\n BuildSequence = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:281\n BetterDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:240\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:236\n}\nbest = <table> {\n drink = <table> {\n }\n food = <table> {\n }\n manaGem = <table> {\n }\n mPotion = <table> {\n }\n bandage = <table> {\n }\n healthstone = <table> {\n }\n buffFood = <table> {\n }\n hPotion = <table> {\n }\n buffDrink = <table> {\n }\n}\n(for index) = 0\n(for limit) = 4\n(for step) = 1\nbag = 0\n(for index) = 1\n(for limit) = 16\n(for step) = 1\nslot = 1\nid = 2287\n(*temporary) = nil\n(*temporary) = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:189\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:164\n IsUsableFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:144\n BetterFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:210\n PetFood = <table> {\n }\n Bandage = <table> {\n }\n ManaGem = <table> {\n }\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:264\n Potion = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:260\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:177\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:151\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:184\n BetterBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:272\n dirty = false\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:50\n BetterHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:256\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:170\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:204\n BetterPetFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:223\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:252\n BetterManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:268\n Sorted = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:135\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:157\n BuildSequen",
			["stack"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:86: in function `UpdateMacros'\nInterface\\AddOns\\xVerminz\\BestFood.lua:42: in function <Interface\\AddOns\\xVerminz\\BestFood.lua:37>",
			["session"] = 482,
			["counter"] = 1,
		}, -- [20]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:87: table index is nil",
			["time"] = "2019/10/14 18:03:56",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:189\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:164\n IsUsableFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:144\n BetterFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:210\n PetFood = <table> {\n }\n Bandage = <table> {\n }\n ManaGem = <table> {\n }\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:264\n Potion = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:260\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:177\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:151\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:184\n BetterBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:272\n dirty = false\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:50\n BetterHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:256\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:170\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:204\n BetterPetFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:223\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:252\n BetterManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:268\n Sorted = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:135\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:157\n BuildSequence = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:281\n BetterDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:240\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:236\n}\nbest = <table> {\n drink = <table> {\n }\n food = <table> {\n }\n manaGem = <table> {\n }\n mPotion = <table> {\n }\n hPotion = <table> {\n }\n bandage = <table> {\n }\n healthstone = <table> {\n }\n buffFood = <table> {\n }\n petfood = <table> {\n }\n buffDrink = <table> {\n }\n}\n(for index) = 1\n(for limit) = 4\n(for step) = 1\nbag = 1\n(for index) = 1\n(for limit) = 10\n(for step) = 1\nslot = 1\nid = nil\n(*temporary) = <table> {\n 2287 = <table> {\n }\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"table index is nil\"\ndefaultFoodMacro = \"#showtooltip\n/use [mod:shift]<bandage>;[nocombat,mod]<buffFood>;[nocombat]<food>\n/castsequence [combat]<hPotions>\n\"\ndefaultDrinkMacro = \"#showtooltip\n/use [nocombat,mod]<manaBuff>;[nocombat]<drink>\n/castsequence [combat]<mPotions>\n\"\nCreateOrUpdateMacro = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:22\ndefaultPetFoodMacro = \"#showtooltip <petfood>\n/cast feed pet\n/use <petfood>\n\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:87: in function `UpdateMacros'\nInterface\\AddOns\\xVerminz\\BestFood.lua:42: in function <Interface\\AddOns\\xVerminz\\BestFood.lua:37>",
			["session"] = 484,
			["counter"] = 2,
		}, -- [21]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:61: table index is nil",
			["time"] = "2019/10/14 18:59:50",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:172\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:147\n IsUsableFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:127\n BetterFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:193\n PetFood = <table> {\n }\n Bandage = <table> {\n }\n ManaGem = <table> {\n }\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:247\n Potion = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:243\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:160\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:134\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:167\n BetterBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:255\n dirty = false\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:48\n BetterHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:239\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:153\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:187\n BetterPetFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:206\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:235\n BetterManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:251\n Sorted = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:118\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:140\n BuildSequence = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:264\n BetterDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:223\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:219\n}\nbest = <table> {\n drink = <table> {\n }\n food = <table> {\n }\n manaGem = <table> {\n }\n mPotion = <table> {\n }\n bandage = <table> {\n }\n healthstone = <table> {\n }\n hPotion = <table> {\n }\n buffFood = <table> {\n }\n petfood = <table> {\n }\n buffDrink = <table> {\n }\n}\n(for index) = 2\n(for limit) = 4\n(for step) = 1\nbag = 2\n(for index) = 1\n(for limit) = 8\n(for step) = 1\nslot = 1\nid = nil\n(*temporary) = <table> {\n 2287 = <table> {\n }\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"table index is nil\"\ndefaultFoodMacro = \"#showtooltip\n/use [mod:shift]<bandage>;[nocombat,mod]<buffFood>;[nocombat]<food>;[combat]<hPotions>\n\"\ndefaultPetFoodMacro = \"#showtooltip <petfood>\n/cast feed pet\n/use <petfood>\n\"\ndefaultDrinkMacro = \"#showtooltip\n/use [nocombat,mod]<manaBuff>;[nocombat]<drink>;[combat]<mPotions>\n\"\nCreateOrUpdateMacro = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:20\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:61: in function `UpdateMacros'\nInterface\\AddOns\\xVerminz\\BestFood.lua:40: in function <Interface\\AddOns\\xVerminz\\BestFood.lua:35>",
			["session"] = 492,
			["counter"] = 2,
		}, -- [22]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:62: table index is nil",
			["time"] = "2019/10/14 19:02:12",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n IsUsableManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:173\n IsUsableBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:148\n IsUsableFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:128\n BetterFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:194\n PetFood = <table> {\n }\n Bandage = <table> {\n }\n ManaGem = <table> {\n }\n BetterHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:248\n Potion = <table> {\n }\n BetterMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:244\n IsUsableMPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:161\n IsUsableBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:135\n IsUsableHealthstone = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:168\n BetterBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:256\n dirty = false\n Healthstone = <table> {\n }\n Food = <table> {\n }\n UpdateMacros = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:48\n BetterHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:240\n IsUsableHPotion = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:154\n IsUsableBandage = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:188\n BetterPetFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:207\n BetterBuffDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:236\n BetterManaGem = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:252\n Sorted = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:119\n IsUsableDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:141\n BuildSequence = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:265\n BetterDrink = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:224\n BetterBuffFood = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:220\n}\nbest = <table> {\n drink = <table> {\n }\n food = <table> {\n }\n manaGem = <table> {\n }\n mPotion = <table> {\n }\n bandage = <table> {\n }\n healthstone = <table> {\n }\n hPotion = <table> {\n }\n buffFood = <table> {\n }\n petfood = <table> {\n }\n buffDrink = <table> {\n }\n}\n(for index) = 2\n(for limit) = 4\n(for step) = 1\nbag = 2\n(for index) = 1\n(for limit) = 8\n(for step) = 1\nslot = 1\nid = nil\n(*temporary) = <table> {\n 2287 = <table> {\n }\n}\n(*temporary) = nil\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = \"table index is nil\"\ndefaultFoodMacro = \"#showtooltip\n/use [mod:shift]<bandage>;[nocombat,mod]<buffFood>;[nocombat]<food>;[combat]<hPotions>\n\"\ndefaultPetFoodMacro = \"#showtooltip <petfood>\n/cast feed pet\n/use <petfood>\n\"\ndefaultDrinkMacro = \"#showtooltip\n/use [nocombat,mod]<manaBuff>;[nocombat]<drink>;[combat]<mPotions>\n\"\nCreateOrUpdateMacro = <function> defined @Interface\\AddOns\\xVerminz\\BestFood.lua:20\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:62: in function `UpdateMacros'\nInterface\\AddOns\\xVerminz\\BestFood.lua:40: in function <Interface\\AddOns\\xVerminz\\BestFood.lua:35>",
			["session"] = 494,
			["counter"] = 1,
		}, -- [23]
		{
			["message"] = "...xternal\\Wildpants\\libs\\AceEvent-3.0\\AceEvent-3.0-4.lua:33: Attempt to register unknown event \"VOID_STORAGE_OPEN\"",
			["time"] = "2019/10/14 22:16:25",
			["locals"] = "(*temporary) = AceEvent30Frame {\n 0 = <userdata>\n}\n(*temporary) = \"VOID_STORAGE_OPEN\"\n",
			["stack"] = "[C]: in function `RegisterEvent'\n...xternal\\Wildpants\\libs\\AceEvent-3.0\\AceEvent-3.0-4.lua:33: in function `OnUsed'\n...sic\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:142: in function `RegisterEvent'\n...Wildpants\\libs\\LibItemCache-2.0\\LibItemCache-2.0-14.lua:42: in main chunk",
			["session"] = 513,
			["counter"] = 2,
		}, -- [24]
		{
			["message"] = "...ldpants\\libs\\LibItemSearch-1.2\\LibItemSearch-1.2-15.lua:230: attempt to index global 'C_CurrencyInfo' (a nil value)",
			["time"] = "2019/10/14 22:16:25",
			["locals"] = "Search = <table> {\n OR = \"or\"\n NOT_MATCH = \"not\"\n NOT = \"Not\"\n Find = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\CustomSearch-1.0\\CustomSearch-1.0.lua:133\n Match = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\CustomSearch-1.0\\CustomSearch-1.0.lua:56\n MatchAny = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\CustomSearch-1.0\\CustomSearch-1.0.lua:48\n ACCENTS = <table> {\n }\n MatchAll = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\CustomSearch-1.0\\CustomSearch-1.0.lua:38\n UseFilter = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\CustomSearch-1.0\\CustomSearch-1.0.lua:123\n Compare = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\CustomSearch-1.0\\CustomSearch-1.0.lua:153\n Matches = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\CustomSearch-1.0\\CustomSearch-1.0.lua:29\n Filter = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\CustomSearch-1.0\\CustomSearch-1.0.lua:101\n Clean = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\CustomSearch-1.0\\CustomSearch-1.0.lua:142\n}\nUnfit = <table> {\n IsItemUnusable = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\Unfit-1.0\\Unfit-1.0.lua:113\n unusable = <table> {\n }\n IsClassUnusable = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\Unfit-1.0\\Unfit-1.0.lua:120\n}\nLib = <table> {\n Scanner = LibItemSearchTooltipScanner {\n }\n Matches = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\LibItemSearch-1.2\\LibItemSearch-1.2.lua:19\n TooltipLine = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\LibItemSearch-1.2\\LibItemSearch-1.2.lua:41\n TooltipPhrase = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\LibItemSearch-1.2\\LibItemSearch-1.2.lua:27\n InSet = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\LibItemSearch-1.2\\LibItemSearch-1.2.lua:31\n Tooltip = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\LibItemSearch-1.2\\LibItemSearch-1.2.lua:23\n BelongsToSet = <function> defined @Interface\\AddOns\\Bagnon\\external\\Wildpants\\libs\\LibItemSearch-1.2\\LibItemSearch-1.2.lua:78\n Filters = <table> {\n }\n}\n(*temporary) = <table> {\n artifact = <table> {\n }\n type = <table> {\n }\n sets = <table> {\n }\n items = <table> {\n }\n name = <table> {\n }\n requiredlevel = <table> {\n }\n level = <table> {\n }\n usable = <table> {\n }\n quality = <table> {\n }\n}\n(*temporary) = <table> {\n}\n(*temporary) = nil\n(*temporary) = \"Relic\"\n(*temporary) = \"relic\"\n(*temporary) = \"wow token\"\n(*temporary) = \"WoW Token\"\n(*temporary) = \"wow token\"\n(*temporary) = \"_DESC\"\n(*temporary) = \"attempt to index global 'C_CurrencyInfo' (a nil value)\"\n",
			["stack"] = "...ldpants\\libs\\LibItemSearch-1.2\\LibItemSearch-1.2-15.lua:230: in main chunk",
			["session"] = 513,
			["counter"] = 2,
		}, -- [25]
		{
			["message"] = "...ce\\AddOns\\Bagnon\\external\\Wildpants\\core\\classes.lua:40: CreateFrame: Unknown frame type 'ItemButton'",
			["time"] = "2019/10/14 22:16:25",
			["locals"] = "(*temporary) = \"ItemButton\"\n",
			["stack"] = "[C]: in function `CreateFrame'\n...ce\\AddOns\\Bagnon\\external\\Wildpants\\core\\classes.lua:40: in function `NewClass'\n...AddOns\\Bagnon\\external\\Wildpants\\components\\item.lua:8: in main chunk",
			["session"] = 513,
			["counter"] = 2,
		}, -- [26]
		{
			["message"] = "...e\\AddOns\\Bagnon\\external\\Wildpants\\core\\settings-Settings.lua:158: attempt to call method 'GetOwnerID' (a nil value)",
			["time"] = "2019/10/14 22:16:32",
			["stack"] = "...e\\AddOns\\Bagnon\\external\\Wildpants\\core\\settings-Settings.lua:158: in function `GetProfile'\n...e\\AddOns\\Bagnon\\external\\Wildpants\\core\\settings-Settings.lua:130: in function `StartupSettings'\nInterface\\AddOns\\Bagnon\\main.lua:10: in function <Interface\\AddOns\\Bagnon\\main.lua:9>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:558: in function `EnableAddon'\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:651: in function <...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:636>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:353: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:424: in function `TimeManager_LoadUI'\nInterface\\FrameXML\\UIParent.lua:693: in function <Interface\\FrameXML\\UIParent.lua:658>",
			["session"] = 513,
			["counter"] = 2,
		}, -- [27]
		{
			["message"] = "...xternal\\Wildpants\\libs\\AceEvent-3.0\\AceEvent-3.0-4.lua:33: Attempt to register unknown event \"PLAYERREAGENTBANKSLOTS_CHANGED\"",
			["time"] = "2019/10/14 22:16:32",
			["stack"] = "[C]: in function `RegisterEvent'\n...xternal\\Wildpants\\libs\\AceEvent-3.0\\AceEvent-3.0-4.lua:33: in function `OnUsed'\n...sic\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:142: in function `RegisterEvent'\n...ace\\AddOns\\Bagnon\\external\\Wildpants\\core\\events.lua:26: in function <...ace\\AddOns\\Bagnon\\external\\Wildpants\\core\\events.lua:20>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:558: in function `EnableAddon'\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:571: in function `EnableAddon'\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:651: in function <...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:636>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:353: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:424: in function `TimeManager_LoadUI'\nInterface\\FrameXML\\UIParent.lua:693: in function <Interface\\FrameXML\\UIParent.lua:658>",
			["session"] = 513,
			["counter"] = 2,
		}, -- [28]
		{
			["message"] = "...xternal\\Wildpants\\libs\\AceEvent-3.0\\AceEvent-3.0-4.lua:33: Attempt to register unknown event \"GUILDBANKFRAME_OPENED\"",
			["time"] = "2019/10/14 22:16:32",
			["stack"] = "[C]: in function `RegisterEvent'\n...xternal\\Wildpants\\libs\\AceEvent-3.0\\AceEvent-3.0-4.lua:33: in function `OnUsed'\n...sic\\Libs\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:142: in function `RegisterEvent'\n...s\\Bagnon\\external\\Wildpants\\features\\autoDisplay.lua:60: in function `RegisterDisplayEvents'\n...s\\Bagnon\\external\\Wildpants\\features\\autoDisplay.lua:29: in function `RegisterGameEvents'\n...s\\Bagnon\\external\\Wildpants\\features\\autoDisplay.lua:13: in function <...s\\Bagnon\\external\\Wildpants\\features\\autoDisplay.lua:12>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:558: in function `EnableAddon'\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:571: in function `EnableAddon'\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:651: in function <...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:636>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:353: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:424: in function `TimeManager_LoadUI'\nInterface\\FrameXML\\UIParent.lua:693: in function <Interface\\FrameXML\\UIParent.lua:658>",
			["session"] = 513,
			["counter"] = 2,
		}, -- [29]
		{
			["message"] = "...Bagnon\\external\\Wildpants\\features\\tooltipCounts.lua:166: hooksecurefunc(): SetRecipeReagentItem is not a function",
			["time"] = "2019/10/14 22:16:32",
			["stack"] = "[C]: in function `hooksecurefunc'\n...Bagnon\\external\\Wildpants\\features\\tooltipCounts.lua:166: in function <...Bagnon\\external\\Wildpants\\features\\tooltipCounts.lua:162>\n...Bagnon\\external\\Wildpants\\features\\tooltipCounts.lua:178: in function <...Bagnon\\external\\Wildpants\\features\\tooltipCounts.lua:175>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:558: in function `EnableAddon'\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:571: in function `EnableAddon'\n...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0-12.lua:651: in function <...xternal\\Wildpants\\libs\\AceAddon-3.0\\AceAddon-3.0.lua:636>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:353: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:424: in function `TimeManager_LoadUI'\nInterface\\FrameXML\\UIParent.lua:693: in function <Interface\\FrameXML\\UIParent.lua:658>",
			["session"] = 513,
			["counter"] = 2,
		}, -- [30]
		{
			["message"] = "Interface\\AddOns\\BagBrother\\Startup.lua:57: Attempt to register unknown event \"VOID_STORAGE_OPEN\"",
			["time"] = "2019/10/14 22:16:32",
			["locals"] = "(*temporary) = BagBrother {\n BANKFRAME_OPENED = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:55\n ParseItem = <function> defined @Interface\\AddOns\\BagBrother\\API.lua:45\n BAG_UPDATE = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:32\n VOID_STORAGE_CLOSE = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:81\n SaveBag = <function> defined @Interface\\AddOns\\BagBrother\\API.lua:19\n SaveEquip = <function> defined @Interface\\AddOns\\BagBrother\\API.lua:38\n GUILDBANKFRAME_OPENED = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:96\n Realm = <table> {\n }\n StartupCache = <function> defined @Interface\\AddOns\\BagBrother\\Startup.lua:33\n PLAYER_MONEY = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:48\n BANKFRAME_CLOSED = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:59\n GUILDBANKFRAME_CLOSED = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:100\n VOID_STORAGE_OPEN = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:77\n GUILDBANKBAGSLOTS_CHANGED = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:108\n Player = <table> {\n }\n RemoveEvent = <function> defined @Interface\\AddOns\\BagBrother\\Startup.lua:79\n 0 = <userdata>\n UpdateData = <function> defined @Interface\\AddOns\\BagBrother\\Startup.lua:66\n GUILD_ROSTER_UPDATE = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:104\n SetupEvents = <function> defined @Interface\\AddOns\\BagBrother\\Startup.lua:49\n UNIT_INVENTORY_CHANGED = <function> defined @Interface\\AddOns\\BagBrother\\Events.lua:40\n}\n(*temporary) = \"VOID_STORAGE_OPEN\"\n",
			["stack"] = "[C]: in function `RegisterEvent'\nInterface\\AddOns\\BagBrother\\Startup.lua:57: in function `SetupEvents'\nInterface\\AddOns\\BagBrother\\Startup.lua:29: in function `?'\nInterface\\AddOns\\BagBrother\\Startup.lua:20: in function <Interface\\AddOns\\BagBrother\\Startup.lua:20>",
			["session"] = 513,
			["counter"] = 2,
		}, -- [31]
		{
			["message"] = "Couldn't open Interface\\AddOns\\Bagnon\\modules\\main.xml",
			["session"] = 514,
			["time"] = "2019/10/14 22:19:40",
			["counter"] = 3,
		}, -- [32]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:293: bad argument #1 to 'pairs' (table expected, got nil)",
			["time"] = "2019/10/14 23:01:21",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"table expected, got nil\"\n = <function> defined =[C]:-1\n",
			["stack"] = "[C]: in function `pairs'\nInterface\\AddOns\\xVerminz\\BestFood.lua:293: in function `BuildSequence'\nInterface\\AddOns\\xVerminz\\BestFood.lua:114: in function `UpdateMacros'\nInterface\\AddOns\\xVerminz\\BestFood.lua:46: in function <Interface\\AddOns\\xVerminz\\BestFood.lua:41>",
			["session"] = 527,
			["counter"] = 1,
		}, -- [33]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn '!Colorz' tried to call the protected function 'CompactRaidFrame2:SetAttribute()'.",
			["time"] = "2019/10/14 19:30:45",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `SetAttribute'\nInterface\\FrameXML\\CompactUnitFrame.lua:161: in function `CompactUnitFrame_SetUnit'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:318: in function `CompactRaidFrameContainer_AddUnitFrame'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:272: in function `CompactRaidFrameContainer_AddPets'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:182: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:62: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 538,
			["counter"] = 2,
		}, -- [34]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVerminz' tried to call the protected function 'TargetFrameToT:Show()'.",
			["time"] = "2019/10/15 22:21:39",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `Show'\nInterface\\FrameXML\\TargetFrame.lua:910: in function <Interface\\FrameXML\\TargetFrame.lua:905>\n[C]: in function `TargetofTarget_Update'\nInterface\\FrameXML\\TargetFrame.lua:420: in function `TargetFrame_OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>",
			["session"] = 541,
			["counter"] = 1,
		}, -- [35]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn '!Colorz' tried to call the protected function 'CompactRaidFrame1:ClearAllPoints()'.",
			["time"] = "2019/10/13 16:30:57",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:62: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 541,
			["counter"] = 5,
		}, -- [36]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\PetHappiness.lua:50: Attempt to find 'this' in non-table object (used '.' instead of ':' ?)",
			["time"] = "2019/10/15 22:29:35",
			["locals"] = "(*temporary) = \"OnEvent\"\n(*temporary) = <function> defined @Interface\\AddOns\\xVerminz\\PetHappiness.lua:11\n",
			["stack"] = "[C]: in function `SetScript'\nInterface\\AddOns\\xVerminz\\PetHappiness.lua:50: in main chunk",
			["session"] = 543,
			["counter"] = 1,
		}, -- [37]
		{
			["message"] = "(null)",
			["session"] = 543,
			["time"] = "2019/10/13 16:00:25",
			["counter"] = 29,
		}, -- [38]
		{
			["message"] = "[string \"print(UnitXPMax(pet))\"]:1: Usage: UnitXPMax(\"unit\")",
			["time"] = "2019/10/16 22:00:32",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `UnitXPMax'\n[string \"print(UnitXPMax(pet))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 552,
			["counter"] = 1,
		}, -- [39]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Experience.lua:30: attempt to call method 'SetText' (a nil value)",
			["time"] = "2019/10/16 22:17:19",
			["locals"] = "currentXP = 4138\nmaxXP = 19400\npercent = 21\n(*temporary) = nil\n(*temporary) = playerExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\n(*temporary) = \"4138 / 19400 (21%)\"\n(*temporary) = \"attempt to call method 'SetText' (a nil value)\"\nplayerExpFrame = playerExpFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nclass = \"HUNTER\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\Experience.lua:30: in function <Interface\\AddOns\\xVerminz\\Experience.lua:26>\n[C]: ?",
			["session"] = 559,
			["counter"] = 257,
		}, -- [40]
		{
			["message"] = "[string \"pplayerExpFrame:ClearAllPoints()\"]:1: attempt to index global 'pplayerExpFrame' (a nil value)",
			["time"] = "2019/10/16 22:21:08",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'pplayerExpFrame' (a nil value)\"\n",
			["stack"] = "[string \"pplayerExpFrame:ClearAllPoints()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2699: in function <Interface\\FrameXML\\ChatFrame.lua:2692>\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 562,
			["counter"] = 1,
		}, -- [41]
		{
			["message"] = "[string \"MainMenuBarExp:Hide()\"]:1: attempt to index global 'MainMenuBarExp' (a nil value)",
			["time"] = "2019/10/16 22:24:35",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'MainMenuBarExp' (a nil value)\"\n",
			["stack"] = "[string \"MainMenuBarExp:Hide()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 566,
			["counter"] = 1,
		}, -- [42]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Experience.lua:32: <unnamed>:SetText(): Font not set",
			["time"] = "2019/10/16 22:35:21",
			["locals"] = "(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"player (18): 4393 / 19400 (22%)\"\n",
			["stack"] = "[C]: in function `SetText'\nInterface\\AddOns\\xVerminz\\Experience.lua:32: in function <Interface\\AddOns\\xVerminz\\Experience.lua:28>\n[C]: ?",
			["session"] = 575,
			["counter"] = 353,
		}, -- [43]
	},
}
