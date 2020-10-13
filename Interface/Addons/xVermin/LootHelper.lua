local _, xVermin = ...

local ai = false

local function Set(autointeract)
	-- SetCVar("AutoInteract", autointeract and "1" or "0")
	if autointeract then
		SetBinding("MOUSEWHEELUP", "INTERACTMOUSEOVER", 1)
		SetBinding("MOUSEWHEELDOWN", "INTERACTMOUSEOVER", 1)
		PlayerFrame:SetAlpha(0)
		PlayerFrame:EnableMouse(false)
		TargetFrame:SetAlpha(0)
		TargetFrame:EnableMouse(false)
		LootFrame:SetAlpha(0)
		GameTooltip:SetScript("OnShow", GameTooltip.Hide)
	else
		SetBinding("MOUSEWHEELDOWN", "MULTIACTIONBAR2BUTTON1", 1)
		SetBinding("MOUSEWHEELUP", "MULTIACTIONBAR2BUTTON2", 1)
		PlayerFrame:SetAlpha(1)
		PlayerFrame:EnableMouse(true)
		TargetFrame:SetAlpha(1)
		TargetFrame:EnableMouse(true)
		LootFrame:SetAlpha(1)
		GameTooltip:SetScript("OnShow", GameTooltip.Show)
	end

	ai = autointeract
end

local function Get()
	return GetCVar("AutoInteract") == "1"
end

local f = CreateFrame("FRAME")
f:SetScript(
	"OnEvent",
	function(self, event)
		if event == "PLAYER_REGEN_ENABLED" then
			Set(not ai)
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
			-- Set(not Get())
			Set(not ai)
		else
			f:RegisterEvent("PLAYER_REGEN_ENABLED")
		end
	end
)
