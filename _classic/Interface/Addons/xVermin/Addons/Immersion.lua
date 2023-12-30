local _, xVermin = ...

-- xVermin.CheckIfLoadedWithTimer(
-- 	'ImmersionFrame',
-- 	function()
-- 		ImmersionFrame.TalkBox:ClearAllPoints()
-- 		ImmersionFrame.TalkBox:SetPoint("CENTER", UIParent, "CENTER", 0, 500)
-- 	end
-- )

ImmersionFrame:HookScript(
	'OnShow',
	function(self)
		ImmersionFrame.TalkBox:ClearAllPoints()
		ImmersionFrame.TalkBox:SetPoint("CENTER", UIParent, "CENTER", 0, 500)
	end
)



