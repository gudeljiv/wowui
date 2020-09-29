local _, xVermin = ...

local function Set(autointeract)
	SetCVar("AutoInteract", autointeract and "1" or "0")
	if (autointeract) then
		SetBinding("MOUSEWHEELUP", "INTERACTMOUSEOVER", 1)
		SetBinding("MOUSEWHEELDOWN", "INTERACTMOUSEOVER", 1)
	else
		SetBinding("MOUSEWHEELDOWN", "MULTIACTIONBAR2BUTTON1", 1)
		SetBinding("MOUSEWHEELUP", "MULTIACTIONBAR2BUTTON2", 1)
	end
end

local function Get()
	return GetCVar("AutoInteract") == "1"
end

local btn = CreateFrame("BUTTON", "MyBindingLootHelper")
SetBindingClick("K", btn:GetName())
btn:SetScript(
	"OnClick",
	function(self, button, down)
		Set(not Get())
	end
)
