
BugGrabberDB = {
	["session"] = 1222,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\xVermin\\Frames/CharacterFrame.lua:49: attempt to index global 'frame' (a nil value)",
			["time"] = "2020/07/24 16:00:03",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\xVermin\\Frames/CharacterFrame.lua:49: in main chunk",
			["session"] = 1205,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "(null)",
			["session"] = 1205,
			["time"] = "2020/07/24 16:00:06",
			["counter"] = 3,
		}, -- [2]
		{
			["message"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:29: attempt to index upvalue 'frame' (a nil value)",
			["time"] = "2020/07/24 17:08:43",
			["locals"] = "(for index) = 1\n(for limit) = 32\n(for step) = 1\ni = 1\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"1\"\n(*temporary) = \"Count\"\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index upvalue 'frame' (a nil value)\"\nB_spellId = nil\nB_unitCaster = nil\nD_spellId = nil\nD_unitCaster = nil\nframe = nil\nframeBorder = nil\nframeCount = nil\ncolor = nil\n",
			["stack"] = "Interface\\AddOns\\xVermin\\SkinBuffs.lua:29: in function <Interface\\AddOns\\xVermin\\SkinBuffs.lua:15>\n[C]: ?\n[C]: in function `TargetFrame_UpdateAuras'\nInterface\\FrameXML\\TargetFrame.lua:131: in function `TargetFrame_Update'\nInterface\\FrameXML\\TargetFrame.lua:150: in function <Interface\\FrameXML\\TargetFrame.lua:142>\n[C]: in function `CameraOrSelectOrMoveStop'\n[string \"CAMERAORSELECTORMOVE\"]:4: in function <[string \"CAMERAORSELECTORMOVE\"]:1>",
			["session"] = 1216,
			["counter"] = 3,
		}, -- [3]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'ItemRack' tried to call the protected function 'AttemptToSaveBindings()'.",
			["time"] = "2020/07/24 16:00:07",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `AttemptToSaveBindings'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:2062: in function `SetSetBindings'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:544: in function `InitCore'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:281: in function `func'\nInterface\\AddOns\\ItemRack\\ItemRack-3.45.nil.lua:982: in function `OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>",
			["session"] = 1219,
			["counter"] = 2,
		}, -- [4]
	},
}
