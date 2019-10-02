
BugGrabberDB = {
	["lastSanitation"] = 3,
	["session"] = 203,
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
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn 'xVerminz' tried to call the protected function 'TargetFrameToT:Show()'.",
			["time"] = "2019/09/30 21:16:47",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `Show'\nInterface\\FrameXML\\TargetFrame.lua:910: in function <Interface\\FrameXML\\TargetFrame.lua:905>\n[C]: ?\n[C]: ?\n[C]: in function `TargetofTarget_Update'\nInterface\\FrameXML\\TargetFrame.lua:420: in function `TargetFrame_OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>\n[C]: ?",
			["session"] = 200,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] AddOn '!Colorz' tried to call the protected function 'CompactRaidFrame2:ClearAllPoints()'.",
			["time"] = "2019/10/02 12:16:33",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:69: in function `CompactRaidFrameContainer_OnSizeChanged'\n[string \"*:OnSizeChanged\"]:1: in function <[string \"*:OnSizeChanged\"]:1>\n[C]: in function `?'\nInterface\\FrameXML\\FlowContainer.lua:133: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:57: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 203,
			["counter"] = 1,
		}, -- [4]
	},
}
