
BugGrabberDB = {
	["lastSanitation"] = 3,
	["session"] = 327,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:62: '<eof>' expected near 'end'",
			["time"] = "2019/09/30 20:25:42",
			["locals"] = "",
			["stack"] = "",
			["session"] = 193,
			["counter"] = 4,
		}, -- [1]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:50: 'then' expected near 'SetRaidTarget'",
			["time"] = "2019/09/30 20:29:43",
			["locals"] = "",
			["stack"] = "",
			["session"] = 197,
			["counter"] = 4,
		}, -- [2]
		{
			["message"] = "[string \"print(UnitGroupRolesAssigned(\"player\"))\"]:1: attempt to call global 'UnitGroupRolesAssigned' (a nil value)",
			["time"] = "2019/10/02 18:32:32",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \"player\"\n(*temporary) = \"attempt to call global 'UnitGroupRolesAssigned' (a nil value)\"\n",
			["stack"] = "[string \"print(UnitGroupRolesAssigned(\"player\"))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 208,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "[string \"print(UnitGroupRolesAssigned(\"target\"))\"]:1: attempt to call global 'UnitGroupRolesAssigned' (a nil value)",
			["time"] = "2019/10/02 18:32:40",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \"target\"\n(*temporary) = \"attempt to call global 'UnitGroupRolesAssigned' (a nil value)\"\n",
			["stack"] = "[string \"print(UnitGroupRolesAssigned(\"target\"))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 208,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "[string \"print(UnitGroupRolesAssigned(target))\"]:1: attempt to call global 'UnitGroupRolesAssigned' (a nil value)",
			["time"] = "2019/10/02 18:32:48",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'UnitGroupRolesAssigned' (a nil value)\"\n",
			["stack"] = "[string \"print(UnitGroupRolesAssigned(target))\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 208,
			["counter"] = 1,
		}, -- [5]
		{
			["message"] = "Interface\\AddOns\\nTooltip\\core.lua:206: attempt to call global 'UnitGroupRolesAssigned' (a nil value)",
			["time"] = "2019/10/02 18:27:39",
			["locals"] = "unit = \"player\"\n(*temporary) = nil\n(*temporary) = \"player\"\n(*temporary) = \"attempt to call global 'UnitGroupRolesAssigned' (a nil value)\"\ntankIcon = \"|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:13:13:0:0:64:64:0:19:22:41|t\"\nhealIcon = \"|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:13:13:0:0:64:64:20:39:1:20|t\"\ndamagerIcon = \"|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:13:13:0:0:64:64:20:39:22:41|t\"\n",
			["stack"] = "Interface\\AddOns\\nTooltip\\core.lua:206: in function <Interface\\AddOns\\nTooltip\\core.lua:205>\nInterface\\AddOns\\nTooltip\\core.lua:337: in function <Interface\\AddOns\\nTooltip\\core.lua:295>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `SetUnit'\nInterface\\FrameXML\\UnitFrame.lua:291: in function `UnitFrame_UpdateTooltip'\nInterface\\FrameXML\\UnitFrame.lua:277: in function <Interface\\FrameXML\\UnitFrame.lua:264>",
			["session"] = 208,
			["counter"] = 14,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\TomTom\\TomTom_CrazyArrow.lua:289: <unnamed>:SetScale(): Scale must be > 0",
			["time"] = "2019/10/02 19:41:43",
			["stack"] = "[C]: in function `SetScale'\nInterface\\AddOns\\TomTom\\TomTom_CrazyArrow.lua:289: in function `ShowHideCrazyArrow'\nInterface\\AddOns\\TomTom\\TomTom_Config.lua:38: in function <Interface\\AddOns\\TomTom\\TomTom_Config.lua:20>\n[C]: ?\n...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0-78.lua:51: in function <...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:49>\n...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0-78.lua:843: in function <...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:664>\n...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0-78.lua:895: in function <...nfig-3.0\\AceConfigDialog-3.0\\AceConfigDialog-3.0.lua:883>\n[C]: ?\n...assicCastbars_Options\\Libs\\AceGUI-3.0\\AceGUI-3.0-40.lua:72: in function <...assicCastbars_Options\\Libs\\AceGUI-3.0\\AceGUI-3.0.lua:70>\n...assicCastbars_Options\\Libs\\AceGUI-3.0\\AceGUI-3.0-40.lua:290: in function `Fire'\n...eBar\\libs\\AceGUI-3.0-40\\widgets\\AceGUIWidget-Slider.lua:69: in function <...eBar\\libs\\AceGUI-3.0\\widgets\\AceGUIWidget-Slider.lua:60>",
			["session"] = 216,
			["counter"] = 3,
		}, -- [7]
		{
			["message"] = "Interface\\AddOns\\nMainbar\\modules\\hotkey.lua:8: bad argument #2 to 'gsub' (string expected, got nil)",
			["time"] = "2019/10/03 16:57:10",
			["locals"] = "(*temporary) = \"1\"\n(*temporary) = nil\n(*temporary) = \"+\"\n(*temporary) = \"string expected, got nil\"\n",
			["stack"] = "[C]: ?\nInterface\\AddOns\\nMainbar\\modules\\hotkey.lua:8: in function <Interface\\AddOns\\nMainbar\\modules\\hotkey.lua:4>\n[C]: in function `ActionButton_UpdateHotkeys'\nInterface\\FrameXML\\ActionButton.lua:711: in function `ActionButton_OnEvent'\nInterface\\FrameXML\\ActionButton.lua:207: in function <Interface\\FrameXML\\ActionButton.lua:204>\n[C]: in function `SetBinding'\nInterface\\AddOns\\xVerminz\\Bindings.lua:5: in function `FixBindings'\nInterface\\AddOns\\xVerminz\\Bindings.lua:124: in main chunk",
			["session"] = 225,
			["counter"] = 12,
		}, -- [8]
		{
			["message"] = "...Details\\Libs\\DF\\Details-Framework-Classic\\slider.lua:816: Details! Framework: OnSwitch() -NONAME- error: ...nterface\\AddOns\\Details\\classes\\classe_instancia.lua:935: DetailsBaseFrame1:SetPoint(): DetailsBaseFrame2 is dependent on this",
			["time"] = "2019/10/03 17:07:08",
			["locals"] = "(*temporary) = \"Details! Framework: OnSwitch() -NONAME- error: ...nterface\\AddOns\\Details\\classes\\classe_instancia.lua:935: DetailsBaseFrame1:SetPoint(): DetailsBaseFrame2 is dependent on this\"\n",
			["stack"] = "[C]: in function `error'\n...Details\\Libs\\DF\\Details-Framework-Classic\\slider.lua:816: in function <...Details\\Libs\\DF\\Details-Framework-Classic\\slider.lua:763>",
			["session"] = 226,
			["counter"] = 2,
		}, -- [9]
		{
			["message"] = "...nterface\\AddOns\\Details\\classes\\classe_instancia.lua:935: DetailsBaseFrame1:SetPoint(): DetailsBaseFrame2 is dependent on this",
			["time"] = "2019/10/03 17:07:22",
			["locals"] = "(*temporary) = DetailsBaseFrame1 {\n 0 = <userdata>\n _place = <table> {\n }\n faded = false\n statusbar = DetailsStatusBar1 {\n }\n resize_esquerda = Details_Resize_Esquerda1 {\n }\n fading_out = false\n instance = <table> {\n }\n hidden = false\n button_down = DetailsScrollDown1 {\n }\n button_up = DetailsScrollUp1 {\n }\n rodape = <table> {\n }\n button_stretch = DetailsButtonStretch1 {\n }\n id_texture2 = <unnamed> {\n }\n scroll_middle = <unnamed> {\n }\n barra_esquerda = <unnamed> {\n }\n id_texture1 = <unnamed> {\n }\n anti_menu_overlap = Details_WindowFrameAntiMenuOverlap1 {\n }\n barra_fundo = <unnamed> {\n }\n HaveGradientEffect = false\n isStretching = false\n cabecalho = <table> {\n }\n isResizing = false\n _instance = <table> {\n }\n isMoving = false\n lock_button = Details_Lock_Button1 {\n }\n fading_in = false\n UPFrame = DetailsUpFrameInstance1 {\n }\n BoxBarrasAltura = 136.640854\n UPFrameLeftPart = DetailsUpFrameLeftPart1 {\n }\n scroll_down = <unnamed> {\n }\n scroll_up = <unnamed> {\n }\n isLocked = true\n wallpaper = <unnamed> {\n }\n DOWNFrame = DetailsDownFrame1 {\n }\n barra_direita = <unnamed> {\n }\n UPFrameConnect = DetailsAntiGap1 {\n }\n alert = DetailsAlertFrame1 {\n }\n resize_direita = Details_Resize_Direita1 {\n }\n}\n(*temporary) = \"TOPRIGHT\"\n(*temporary) = DetailsBaseFrame2 {\n 0 = <userdata>\n _place = <table> {\n }\n faded = false\n statusbar = DetailsStatusBar2 {\n }\n resize_esquerda = Details_Resize_Esquerda2 {\n }\n fading_out = false\n instance = <table> {\n }\n hidden = false\n button_down = DetailsScrollDown2 {\n }\n button_up = DetailsScrollUp2 {\n }\n rodape = <table> {\n }\n button_stretch = DetailsButtonStretch2 {\n }\n id_texture2 = <unnamed> {\n }\n id_texture1 = <unnamed> {\n }\n scroll_middle = <unnamed> {\n }\n barra_esquerda = <unnamed> {\n }\n anti_menu_overlap = Details_WindowFrameAntiMenuOverlap2 {\n }\n barra_fundo = <unnamed> {\n }\n HaveGradientEffect = false\n isStretching = false\n cabecalho = <table> {\n }\n isResizing = false\n _instance = <table> {\n }\n isMoving = false\n lock_button = Details_Lock_Button2 {\n }\n fading_in = false\n UPFrame = DetailsUpFrameInstance2 {\n }\n BoxBarrasAltura = 136.640854\n UPFrameLeftPart = DetailsUpFrameLeftPart2 {\n }\n scroll_down = <unnamed> {\n }\n scroll_up = <unnamed> {\n }\n isLocked = true\n wallpaper = <unnamed> {\n }\n DOWNFrame = DetailsDownFrame2 {\n }\n barra_direita = <unnamed> {\n }\n UPFrameConnect = DetailsAntiGap2 {\n }\n alert = DetailsAlertFrame2 {\n }\n resize_direita = Details_Resize_Direita2 {\n }\n}\n(*temporary) = \"TOPLEFT\"\n",
			["stack"] = "[C]: in function `SetPoint'\n...nterface\\AddOns\\Details\\classes\\classe_instancia.lua:935: in function `BaseFrameSnap'\nInterface\\AddOns\\Details\\gumps\\janela_principal.lua:787: in function <Interface\\AddOns\\Details\\gumps\\janela_principal.lua:772>\nInterface\\AddOns\\Details\\gumps\\janela_principal.lua:1060: in function <Interface\\AddOns\\Details\\gumps\\janela_principal.lua:1047>",
			["session"] = 226,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = "...\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Player.lua:315: attempt to call method 'CreateBeautyBorder' (a nil value)",
			["time"] = "2019/10/03 21:08:15",
			["locals"] = "frame = WeaponSwingTimerPlayerFrame {\n 0 = <userdata>\n off_spark = <unnamed> {\n }\n main_left_text = <unnamed> {\n }\n main_right_text = <unnamed> {\n }\n off_left_text = <unnamed> {\n }\n backplane = WeaponSwingTimerPlayerBackdropFrame {\n }\n main_spark = <unnamed> {\n }\n off_right_text = <unnamed> {\n }\n main_bar = <unnamed> {\n }\n off_bar = <unnamed> {\n }\n}\nsettings = <table> {\n off_a = 1\n ooc_alpha = 0.250000\n classic_bars = true\n show_left_text = false\n off_g = 0.100000\n main_text_a = 1\n off_r = 0.100000\n in_combat_alpha = 1\n enabled = true\n y_offset = -200\n x_offset = 0\n height = 10\n show_right_text = true\n point = \"CENTER\"\n show_border = false\n off_text_b = 1\n main_text_b = 1\n main_b = 0.900000\n fill_empty = true\n off_text_a = 1\n main_g = 0.100000\n off_text_g = 1\n off_b = 0.900000\n show_offhand = true\n width = 200\n main_text_g = 1\n main_a = 1\n backplane_alpha = 0.500000\n main_text_r = 1\n off_text_r = 1\n is_locked = false\n rel_point = \"CENTER\"\n main_r = 0.100000\n}\n(*temporary) = nil\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = 8\n(*temporary) = \"attempt to call method 'CreateBeautyBorder' (a nil value)\"\naddon_data = <table> {\n core = <table> {\n }\n player = <table> {\n }\n config = <table> {\n }\n target = <table> {\n }\n hunter = <table> {\n }\n localization_table = <table> {\n }\n utils = <table> {\n }\n}\n",
			["stack"] = "...\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Player.lua:315: in function `UpdateVisualsOnSettingsChange'\n...\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Player.lua:444: in function `InitializeVisuals'\n...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:542: in function <...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:541>\n...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:662: in function <...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:644>\n...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:673: in function <...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:669>",
			["session"] = 228,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "...\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Target.lua:313: attempt to index local 'frame' (a nil value)",
			["time"] = "2019/10/03 21:08:19",
			["locals"] = "settings = <table> {\n off_a = 1\n ooc_alpha = 0.250000\n classic_bars = true\n show_left_text = true\n off_g = 0.100000\n main_text_a = 1\n off_r = 0.800000\n in_combat_alpha = 1\n enabled = false\n y_offset = -230\n x_offset = 0\n height = 10\n show_right_text = true\n point = \"CENTER\"\n show_border = true\n off_text_b = 1\n main_text_b = 1\n main_b = 0.100000\n fill_empty = true\n off_text_a = 1\n main_g = 0.100000\n off_text_g = 1\n off_b = 0.100000\n show_offhand = true\n width = 200\n main_text_g = 1\n main_a = 1\n backplane_alpha = 0.500000\n main_text_r = 1\n off_text_r = 1\n is_locked = false\n rel_point = \"CENTER\"\n main_r = 0.800000\n}\nframe = nil\n(*temporary) = false\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'frame' (a nil value)\"\naddon_data = <table> {\n core = <table> {\n }\n player = <table> {\n }\n config = <table> {\n }\n target = <table> {\n }\n hunter = <table> {\n }\n localization_table = <table> {\n }\n utils = <table> {\n }\n}\n",
			["stack"] = "...\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Target.lua:313: in function `UpdateVisualsOnUpdate'\n...\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Target.lua:125: in function `OnUpdate'\n...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:576: in function <...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:574>",
			["session"] = 228,
			["counter"] = 279,
		}, -- [12]
		{
			["message"] = "...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:529: attempt to index field 'player' (a nil value)",
			["time"] = "2019/10/03 21:18:20",
			["locals"] = "(*temporary) = nil\n(*temporary) = <function> defined =[C]:-1\n(*temporary) = \"attempt to index field 'player' (a nil value)\"\naddon_data = <table> {\n core = <table> {\n }\n utils = <table> {\n }\n target = <table> {\n }\n hunter = <table> {\n }\n localization_table = <table> {\n }\n config = <table> {\n }\n}\n",
			["stack"] = "...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:529: in function <...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:527>\n...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:661: in function <...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:644>\n...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:673: in function <...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:669>",
			["session"] = 232,
			["counter"] = 1,
		}, -- [13]
		{
			["message"] = "Interface\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Player.lua:834: 'end' expected (to close 'function' at line 291) near '<eof>'",
			["time"] = "2019/10/03 21:18:20",
			["locals"] = "",
			["stack"] = "",
			["session"] = 232,
			["counter"] = 4,
		}, -- [14]
		{
			["message"] = "...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:683: attempt to index field 'player' (a nil value)",
			["time"] = "2019/10/03 21:18:24",
			["locals"] = "self = WeaponSwingTimerCoreFrame {\n 0 = <userdata>\n}\nevent = \"COMBAT_LOG_EVENT_UNFILTERED\"\nargs = <table> {\n}\ncombat_info = <table> {\n 1 = 1570130305.058000\n 2 = \"SPELL_AURA_APPLIED\"\n 3 = false\n 4 = \"Player-4465-011C68ED\"\n 5 = \"Bexkiller\"\n 6 = 1304\n 7 = 0\n 8 = \"Player-4465-011C68ED\"\n 9 = \"Bexkiller\"\n 10 = 1304\n 11 = 0\n 12 = 0\n 13 = \"Blink\"\n 14 = 64\n 15 = \"BUFF\"\n}\n(*temporary) = nil\n(*temporary) = \"SPELL_AURA_APPLIED\"\n(*temporary) = \"attempt to index field 'player' (a nil value)\"\nOnAddonLoaded = <function> defined @Interface\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:644\naddon_data = <table> {\n core = <table> {\n }\n utils = <table> {\n }\n target = <table> {\n }\n hunter = <table> {\n }\n localization_table = <table> {\n }\n config = <table> {\n }\n}\n",
			["stack"] = "...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:683: in function <...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:669>",
			["session"] = 232,
			["counter"] = 3,
		}, -- [15]
		{
			["message"] = "...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:575: attempt to index field 'player' (a nil value)",
			["time"] = "2019/10/03 21:18:24",
			["locals"] = "self = WeaponSwingTimerCoreFrame {\n 0 = <userdata>\n}\nelapsed = 0.017000\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index field 'player' (a nil value)\"\naddon_data = <table> {\n core = <table> {\n }\n utils = <table> {\n }\n target = <table> {\n }\n hunter = <table> {\n }\n localization_table = <table> {\n }\n config = <table> {\n }\n}\n",
			["stack"] = "...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:575: in function <...ce\\AddOns\\WeaponSwingTimer\\WeaponSwingTimer_Core.lua:574>",
			["session"] = 232,
			["counter"] = 258,
		}, -- [16]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\SkinBuffs.lua:164: hooksecurefunc(): PetFrame_UpdateAuras is not a function",
			["time"] = "2019/10/04 17:04:44",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVerminz\\SkinBuffs.lua:164: in main chunk",
			["session"] = 236,
			["counter"] = 1,
		}, -- [17]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\SkinBuffs.lua:164: hooksecurefunc(): PlayerFrame_UpdateAuras is not a function",
			["time"] = "2019/10/04 17:05:41",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVerminz\\SkinBuffs.lua:164: in main chunk",
			["session"] = 237,
			["counter"] = 1,
		}, -- [18]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\BestFood.lua:76: '}' expected (to close '{' at line 72) near '['",
			["time"] = "2019/10/04 17:12:56",
			["locals"] = "",
			["stack"] = "",
			["session"] = 239,
			["counter"] = 4,
		}, -- [19]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Unit.lua:10: attempt to index global 'cgt' (a nil value)",
			["time"] = "2019/10/04 17:27:06",
			["locals"] = "font = \"Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf\"\ncus = CustomContainer_CombatUnitState {\n 0 = <userdata>\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = 10\n(*temporary) = <userdata>\n(*temporary) = \"CENTER\"\n(*temporary) = 0\n(*temporary) = 2\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index global 'cgt' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\Unit.lua:10: in main chunk",
			["session"] = 242,
			["counter"] = 1,
		}, -- [20]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Unit.lua:15: attempt to call global 'UnitIsDNS' (a nil value)",
			["time"] = "2019/10/04 17:27:49",
			["locals"] = "font = \"Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf\"\ncus = CustomContainer_CombatUnitState {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nafk = false\n(*temporary) = nil\n(*temporary) = \"player\"\n(*temporary) = \"attempt to call global 'UnitIsDNS' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\Unit.lua:15: in main chunk",
			["session"] = 243,
			["counter"] = 1,
		}, -- [21]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Unit.lua:17: attempt to index global 'cgt' (a nil value)",
			["time"] = "2019/10/04 17:28:08",
			["locals"] = "font = \"Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf\"\ncus = CustomContainer_CombatUnitState {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nafk = false\ndnd = false\n(*temporary) = nil\n(*temporary) = false\n(*temporary) = \"LEFT\"\n(*temporary) = 3\n(*temporary) = 2\n(*temporary) = <userdata>\n(*temporary) = \"attempt to index global 'cgt' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\Unit.lua:17: in main chunk",
			["session"] = 244,
			["counter"] = 1,
		}, -- [22]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Unit.lua:17: attempt to call method 'Setext' (a nil value)",
			["time"] = "2019/10/04 17:28:33",
			["locals"] = "font = \"Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf\"\ncus = CustomContainer_CombatUnitState {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nafk = false\ndnd = false\n(*temporary) = nil\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n(*temporary) = \"\"\n(*temporary) = \"attempt to call method 'Setext' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\Unit.lua:17: in main chunk",
			["session"] = 245,
			["counter"] = 1,
		}, -- [23]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Unit.lua:17: hooksecurefunc(): Update is not a function",
			["time"] = "2019/10/04 17:42:43",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVerminz\\Unit.lua:17: in main chunk",
			["session"] = 247,
			["counter"] = 1,
		}, -- [24]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Unit.lua:17: hooksecurefunc(): OnUpdate is not a function",
			["time"] = "2019/10/04 17:43:01",
			["locals"] = "",
			["stack"] = "[C]: in function `hooksecurefunc'\nInterface\\AddOns\\xVerminz\\Unit.lua:17: in main chunk",
			["session"] = 248,
			["counter"] = 1,
		}, -- [25]
		{
			["message"] = "[string \"if not THO then local f,t,c=CreateFrame(\"Fr...\"]:1: attempt to call global 'SetTracking' (a nil value)",
			["time"] = "2019/10/04 18:10:24",
			["locals"] = "_ = THO {\n 0 = <userdata>\n}\ne = 0.016000\n(*temporary) = nil\n(*temporary) = 1\n(*temporary) = \"attempt to call global 'SetTracking' (a nil value)\"\nc = 0\nt = 1\n",
			["stack"] = "[string \"if not THO then local f,t,c=CreateFrame(\"Fr...\"]:1: in function <[string \"if not THO then local f,t,c=CreateFrame(\"Fr...\"]:1>",
			["session"] = 252,
			["counter"] = 1,
		}, -- [26]
		{
			["message"] = "[string \"SetTracking(1)\"]:1: attempt to call global 'SetTracking' (a nil value)",
			["time"] = "2019/10/04 18:11:06",
			["locals"] = "(*temporary) = nil\n(*temporary) = 1\n(*temporary) = \"attempt to call global 'SetTracking' (a nil value)\"\n",
			["stack"] = "[string \"SetTracking(1)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 252,
			["counter"] = 1,
		}, -- [27]
		{
			["message"] = "...ace\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:52: attempt to index local 'temp' (a nil value)",
			["time"] = "2019/10/04 21:36:16",
			["locals"] = "TargetHealthFrame = TargetHealthFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nPlayerHealthFrame = PlayerHealthFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nPHealthShow = <function> defined @Interface\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:19\nTHealthHide = <function> defined @Interface\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:26\nTHealthShow = <function> defined @Interface\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:29\ntemp = nil\nUpdate = <function> defined @Interface\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:48\n(*temporary) = true\n(*temporary) = nil\n(*temporary) = <function> defined @Interface\\FrameXML\\PlayerFrame.lua:360\n(*temporary) = nil\n(*temporary) = \"attempt to index local 'temp' (a nil value)\"\n",
			["stack"] = "...ace\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:52: in main chunk",
			["session"] = 254,
			["counter"] = 1,
		}, -- [28]
		{
			["message"] = "...ace\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:51: attempt to index global 'this' (a nil value)",
			["time"] = "2019/10/04 21:41:06",
			["locals"] = "TargetHealthFrame = TargetHealthFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nPlayerHealthFrame = PlayerHealthFrame {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nPHealthShow = <function> defined @Interface\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:19\nTHealthHide = <function> defined @Interface\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:26\nTHealthShow = <function> defined @Interface\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:29\nUpdate = <function> defined @Interface\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:47\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = <function> defined @Interface\\FrameXML\\PlayerFrame.lua:360\n(*temporary) = \"attempt to index global 'this' (a nil value)\"\n",
			["stack"] = "...ace\\AddOns\\xVerminz\\PlayerTargetHealthPercentage.lua:51: in main chunk",
			["session"] = 257,
			["counter"] = 1,
		}, -- [29]
		{
			["message"] = "[string \"(SetTarget(\"player\", 0))\"]:1: syntax error near '<eof>'",
			["time"] = "2019/10/04 21:59:07",
			["locals"] = "(*temporary) = \"(SetTarget(\"player\", 0))\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 268,
			["counter"] = 1,
		}, -- [30]
		{
			["message"] = "Couldn't open Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.xml",
			["time"] = "2019/10/04 21:57:35",
			["session"] = 269,
			["counter"] = 9,
		}, -- [31]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:14: Usage: SetRaidTarget(unit, index)",
			["time"] = "2019/10/05 20:47:02",
			["locals"] = "(*temporary) = \"player\"\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n",
			["stack"] = "[C]: in function `SetRaidTarget'\nInterface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:14: in function <Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:12>\n[C]: in function `CameraOrSelectOrMoveStop'\n[string \"CAMERAORSELECTORMOVE\"]:4: in function <[string \"CAMERAORSELECTORMOVE\"]:1>",
			["session"] = 270,
			["counter"] = 2,
		}, -- [32]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:6: attempt to compare number with nil",
			["time"] = "2019/10/05 20:48:15",
			["locals"] = "arg = \"1\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to compare number with nil\"\nrt = 6\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:6: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 271,
			["counter"] = 1,
		}, -- [33]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:17: Usage: SetRaidTarget(unit, index)",
			["time"] = "2019/10/05 20:47:53",
			["locals"] = "(*temporary) = \"player\"\n(*temporary) = <unnamed> {\n 0 = <userdata>\n}\n",
			["stack"] = "[C]: in function `SetRaidTarget'\nInterface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:17: in function <Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:12>\n[C]: in function `CameraOrSelectOrMoveStop'\n[string \"CAMERAORSELECTORMOVE\"]:4: in function <[string \"CAMERAORSELECTORMOVE\"]:1>",
			["session"] = 271,
			["counter"] = 2,
		}, -- [34]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:6: attempt to compare number with string",
			["time"] = "2019/10/05 20:48:57",
			["locals"] = "arg = \"1\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to compare number with string\"\nrt = 6\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:6: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 272,
			["counter"] = 1,
		}, -- [35]
		{
			["message"] = "[string \"TrackingIconFrame:SetPoint(\"BOTTOM\", Custom...\"]:1: attempt to index global 'TrackingIconFrame' (a nil value)",
			["time"] = "2019/10/05 21:04:19",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'TrackingIconFrame' (a nil value)\"\n",
			["stack"] = "[string \"TrackingIconFrame:SetPoint(\"BOTTOM\", Custom...\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 279,
			["counter"] = 1,
		}, -- [36]
		{
			["message"] = "[string \"CustomContainer_TrackingIconFrame:SetStrata...\"]:1: attempt to call method 'SetStrata' (a nil value)",
			["time"] = "2019/10/05 21:06:36",
			["locals"] = "(*temporary) = nil\n(*temporary) = CustomContainer_TrackingIconFrame {\n 0 = <userdata>\n beautyBorder = <table> {\n }\n beautyShadow = <table> {\n }\n}\n(*temporary) = \"high\"\n(*temporary) = \"attempt to call method 'SetStrata' (a nil value)\"\n",
			["stack"] = "[string \"CustomContainer_TrackingIconFrame:SetStrata...\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 279,
			["counter"] = 2,
		}, -- [37]
		{
			["message"] = "[string \"CustomContainer_TrackingIconFrame:SetTextur...\"]:1: attempt to call method 'SetTexture' (a nil value)",
			["time"] = "2019/10/05 21:15:08",
			["locals"] = "(*temporary) = nil\n(*temporary) = CustomContainer_TrackingIconFrame {\n 0 = <userdata>\n beautyBorder = <table> {\n }\n beautyShadow = <table> {\n }\n}\n(*temporary) = \"Interface\\Icons\\spell_nature_earthquake\"\n(*temporary) = \"attempt to call method 'SetTexture' (a nil value)\"\n",
			["stack"] = "[string \"CustomContainer_TrackingIconFrame:SetTextur...\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2699: in function <Interface\\FrameXML\\ChatFrame.lua:2692>\n[C]: ?\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:338: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:616: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:4: in function <[string \"*:OnClick\"]:1>",
			["session"] = 279,
			["counter"] = 1,
		}, -- [38]
		{
			["message"] = "[string \"print(GetProfessions())\"]:1: attempt to call global 'GetProfessions' (a nil value)",
			["time"] = "2019/10/05 21:19:53",
			["locals"] = "(*temporary) = <function> defined @Interface\\FrameXML\\RestrictedInfrastructure.lua:116\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'GetProfessions' (a nil value)\"\n",
			["stack"] = "[string \"print(GetProfessions())\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 283,
			["counter"] = 1,
		}, -- [39]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Unit.lua:47: attempt to call global 'GetProfessions' (a nil value)",
			["time"] = "2019/10/05 21:22:12",
			["locals"] = "font = \"Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf\"\ncus = CustomContainer_CombatUnitState {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nTrackingIconFrame = CustomContainer_TrackingIconFrame {\n 0 = <userdata>\n Icon = <unnamed> {\n }\n beautyBorder = <table> {\n }\n beautyShadow = <table> {\n }\n}\nTrackingIcon = <function> defined @Interface\\AddOns\\xVerminz\\Unit.lua:33\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'GetProfessions' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\Unit.lua:47: in main chunk",
			["session"] = 284,
			["counter"] = 1,
		}, -- [40]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\Unit.lua:49: attempt to call global 'GetSpellName' (a nil value)",
			["time"] = "2019/10/05 21:25:10",
			["locals"] = "font = \"Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf\"\ncus = CustomContainer_CombatUnitState {\n 0 = <userdata>\n text = <unnamed> {\n }\n}\nTrackingIconFrame = CustomContainer_TrackingIconFrame {\n 0 = <userdata>\n Icon = <unnamed> {\n }\n beautyBorder = <table> {\n }\n beautyShadow = <table> {\n }\n}\nTrackingIcon = <function> defined @Interface\\AddOns\\xVerminz\\Unit.lua:33\ni = 1\n(*temporary) = nil\n(*temporary) = 1\n(*temporary) = \"spell\"\n(*temporary) = \"attempt to call global 'GetSpellName' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\Unit.lua:49: in main chunk",
			["session"] = 285,
			["counter"] = 1,
		}, -- [41]
		{
			["message"] = "[string \"GetSpellName(1)\"]:1: attempt to call global 'GetSpellName' (a nil value)",
			["time"] = "2019/10/05 21:26:20",
			["locals"] = "(*temporary) = nil\n(*temporary) = 1\n(*temporary) = \"attempt to call global 'GetSpellName' (a nil value)\"\n",
			["stack"] = "[string \"GetSpellName(1)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 285,
			["counter"] = 1,
		}, -- [42]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\TrackingIcon.lua:37: attempt to index global 'cus' (a nil value)",
			["time"] = "2019/10/05 21:39:00",
			["locals"] = "tabName = \"General\"\ntabTexture = 132219\ntabOffset = 0\nnumEntries = 17\n(for index) = 11\n(for limit) = 17\n(for step) = 1\ni = 11\nspellName = \"Find Minerals\"\nspellSubName = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = 2580\n(*temporary) = \"attempt to index global 'cus' (a nil value)\"\nTrackingIconMinerals = <function> defined @Interface\\AddOns\\xVerminz\\TrackingIcon.lua:11\nTrackingIconHerbs = <function> defined @Interface\\AddOns\\xVerminz\\TrackingIcon.lua:22\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\TrackingIcon.lua:37: in function <Interface\\AddOns\\xVerminz\\TrackingIcon.lua:32>",
			["session"] = 293,
			["counter"] = 2,
		}, -- [43]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVerminz' tried to call the protected function 'TargetFrameToT:Show()'.",
			["time"] = "2019/09/30 21:16:47",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `Show'\nInterface\\FrameXML\\TargetFrame.lua:910: in function <Interface\\FrameXML\\TargetFrame.lua:905>\n[C]: ?\n[C]: ?\n[C]: in function `TargetofTarget_Update'\nInterface\\FrameXML\\TargetFrame.lua:420: in function `TargetFrame_OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>\n[C]: ?",
			["session"] = 305,
			["counter"] = 4,
		}, -- [44]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn '!Colorz' tried to call the protected function 'CompactRaidFrame1:ClearAllPoints()'.",
			["time"] = "2019/10/06 12:40:06",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:69: in function `CompactRaidFrameContainer_OnSizeChanged'\n[string \"*:OnSizeChanged\"]:1: in function <[string \"*:OnSizeChanged\"]:1>\n[C]: in function `?'\nInterface\\FrameXML\\FlowContainer.lua:133: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:57: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 308,
			["counter"] = 2,
		}, -- [45]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:20: attempt to call global 'wsrt_wait' (a nil value)",
			["time"] = "2019/10/07 23:10:52",
			["locals"] = "type = 8\nsrt = <function> defined @Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:4\n(*temporary) = nil\n(*temporary) = 5\n(*temporary) = nil\n(*temporary) = \"attempt to call global 'wsrt_wait' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:20: in main chunk",
			["session"] = 316,
			["counter"] = 1,
		}, -- [46]
		{
			["message"] = "(null)",
			["session"] = 316,
			["time"] = "2019/10/04 17:04:44",
			["counter"] = 39,
		}, -- [47]
		{
			["message"] = "Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:4: attempt to call global 'clear_mark' (a nil value)",
			["time"] = "2019/10/07 23:18:51",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"attempt to call global 'clear_mark' (a nil value)\"\ntype = 8\n",
			["stack"] = "Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:4: in function <Interface\\AddOns\\xVerminz\\PlayerTargetSetMark.lua:3>\n[C]: in function `CameraOrSelectOrMoveStop'\n[string \"CAMERAORSELECTORMOVE\"]:4: in function <[string \"CAMERAORSELECTORMOVE\"]:1>",
			["session"] = 320,
			["counter"] = 2,
		}, -- [48]
		{
			["message"] = "[string \"TargetFramehealthBarText:Hide()\"]:1: attempt to index global 'TargetFramehealthBarText' (a nil value)",
			["time"] = "2019/10/08 17:02:16",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index global 'TargetFramehealthBarText' (a nil value)\"\n",
			["stack"] = "[string \"TargetFramehealthBarText:Hide()\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2033: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4609: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4270: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4306: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 322,
			["counter"] = 1,
		}, -- [49]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn '!Colorz' tried to call the protected function 'CompactRaidFrame2:ClearAllPoints()'.",
			["time"] = "2019/10/02 12:16:33",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:69: in function `CompactRaidFrameContainer_OnSizeChanged'\n[string \"*:OnSizeChanged\"]:1: in function <[string \"*:OnSizeChanged\"]:1>\n[C]: in function `?'\nInterface\\FrameXML\\FlowContainer.lua:133: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:57: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 323,
			["counter"] = 3,
		}, -- [50]
	},
}
