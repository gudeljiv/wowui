local _, xVermin = ...

local function Set(autointeract)
	SetCVar("AutoInteract", autointeract and "1" or "0")
	if (autointeract) then
		SetBinding("MOUSEWHEELUP", "INTERACTMOUSEOVER", 1)
		SetBinding("MOUSEWHEELDOWN", "INTERACTMOUSEOVER", 1)
		PlayerFrame:SetAlpha(0)
		PlayerHealthFrame:SetAlpha(0)
		TargetFrame:SetAlpha(0)
		TargetHealthFrame:SetAlpha(0)
		LootFrame:SetAlpha(0)
	else
		SetBinding("MOUSEWHEELDOWN", "MULTIACTIONBAR2BUTTON1", 1)
		SetBinding("MOUSEWHEELUP", "MULTIACTIONBAR2BUTTON2", 1)
		PlayerFrame:SetAlpha(1)
		PlayerHealthFrame:SetAlpha(1)
		TargetFrame:SetAlpha(1)
		TargetHealthFrame:SetAlpha(1)
		LootFrame:SetAlpha(1)
	end
end

local function Get()
	return GetCVar("AutoInteract") == "1"
end

local f = CreateFrame("FRAME")
f:SetScript(
	"OnEvent",
	function(self, event)
		if event == "PLAYER_REGEN_ENABLED" then
			Set(not Get())
			f:UnregisterEvent("PLAYER_REGEN_ENABLED")
		end
	end
)

local btn = CreateFrame("BUTTON", "MyBindingLootHelper")
SetBindingClick("ALT-Q", btn:GetName())
btn:SetScript(
	"OnClick",
	function(self, event)
		if not InCombatLockdown() then
			Set(not Get())
		else
			f:RegisterEvent("PLAYER_REGEN_ENABLED")
		end
	end
)
