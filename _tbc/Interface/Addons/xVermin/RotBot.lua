local F1 = CreateFrame('BUTTON', 'RotBotF1')
local F2 = CreateFrame('BUTTON', 'RotBotF2')
SetBindingClick('SHIFT-F1', F1:GetName())
SetBindingClick('SHIFT-F2', F2:GetName())

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
