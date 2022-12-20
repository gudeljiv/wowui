local start = CreateFrame('BUTTON', 'RotBotF1')
local stop = CreateFrame('BUTTON', 'RotBotF2')

SetBindingClick('HOME', start:GetName())
SetBindingClick('END', stop:GetName())

start:SetScript(
	'OnClick',
	function(self, event)
		RotationFrame1:SetBackdropColor(0, 1, 0, 0.9)
	end
)

stop:SetScript(
	'OnClick',
	function(self, event)
		RotationFrame1:SetBackdropColor(1, 0, 0, 0.9)
	end
)
