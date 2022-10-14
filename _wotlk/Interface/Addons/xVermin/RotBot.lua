local F1 = CreateFrame('BUTTON', 'RotBotF1')
local F2 = CreateFrame('BUTTON', 'RotBotF2')
local F3 = CreateFrame('BUTTON', 'RotBotF3')
SetBindingClick('HOME', F1:GetName())
SetBindingClick('END', F2:GetName())
-- SetBindingClick('CTRL-SHIFT-+', F3:GetName())

F1:SetScript(
	'OnClick',
	function(self, event)
		RotationFrame3:SetBackdropColor(0, 1, 0, 0.9)
	end
)

F2:SetScript(
	'OnClick',
	function(self, event)
		RotationFrame3:SetBackdropColor(1, 0, 0, 0.9)
	end
)

-- RF4color = false
-- F3:SetScript(
-- 	'OnClick',
-- 	function(self, event)
-- 		RF4color = not RF4color
-- 		if RF4color then
-- 			RotationFrame4:SetBackdropColor(0, 0, 1, 1)
-- 		else
-- 			RotationFrame4:SetBackdropColor(1, 1, 1, 1)
-- 		end
-- 	end
-- )
