-- Binding code that's shared between the various flavors of action buttons
local AddonName, Addon = ...
local KeyBound = LibStub("LibKeyBound-1.0")
local COMMAND_TEMPLATE = "CLICK %s:HOTKEY"

-- binding method definitions
-- returns the binding action associated with the button

-- we use a virtual button (arbitrarily named HOTKEY)
-- to enable cast on key press support
local function getButtonBindingAction(button)
	return button:GetAttribute("commandName") or COMMAND_TEMPLATE:format(button:GetName())
end

local function getButtonBindingActionName(button)
	return button:GetAttribute("displayName")
		or _G["BINDING_NAME_" .. getButtonBindingAction(button)]
		or button:GetName()
end

local function getButtonBindings(button)
	return GetBindingKey(getButtonBindingAction(button))
end

-- returns what hotkey to display for the button
local function getButtonHotkey(button)
	local key = (getButtonBindings(button))

	if key then
		return KeyBound:ToShortKey(key)
	end

	return ""
end

-- returns a space separated list of all bindings for the given button
local function getButtonBindingsList(button)
	return strjoin(" ", getButtonBindings(button))
end

-- set bindings
local function setButtonBinding(button, key)
	return SetBinding(key, getButtonBindingAction(button))
end

-- clears all bindings from the button
local function clearButtonBindings(button)
	local key = (getButtonBindings(button))

	while key do
		SetBinding(key, nil)
		key = (getButtonBindings(button))
	end
end

-- used to implement keybinding support without applying all of the LibKeyBound
-- interface methods via a mixin
local BindableButtonProxy = Addon:CreateHiddenFrame("Frame", AddonName .. "BindableButtonProxy")

-- call a thing if the thing exists
local function whenExists(obj, func, ...)
	if obj then
		return func(obj, ...)
	end
end

function BindableButtonProxy:GetHotkey()
	return whenExists(self:GetParent(), getButtonHotkey)
end

function BindableButtonProxy:SetKey(key)
	return whenExists(self:GetParent(), setButtonBinding, key)
end

function BindableButtonProxy:GetBindings()
	return whenExists(self:GetParent(), getButtonBindingsList)
end

function BindableButtonProxy:ClearBindings()
	return whenExists(self:GetParent(), clearButtonBindings)
end

function BindableButtonProxy:GetActionName()
	return whenExists(self:GetParent(), getButtonBindingActionName) or UNKNOWN
end

BindableButtonProxy:SetScript("OnLeave", function(self)
	self:ClearAllPoints()
	self:SetParent(nil)
end)

-- methods to inject onto a bar to add in common binding functionality
-- previously, this was a mixin
local BindableButton = {}

-- adds quickbinding support to buttons
function BindableButton:AddQuickBindingSupport(button)
	button:HookScript("OnEnter", BindableButton.OnEnter)

	if button.UpdateHotkeys then
		hooksecurefunc(button, "UpdateHotkeys", BindableButton.UpdateHotkeys)
	else
		button.UpdateHotkeys = BindableButton.UpdateHotkeys
	end

	button:UpdateHotkeys()
end

function BindableButton:UpdateHotkeys()
	_G[self:GetName() .. "HotKey"]:SetFont("Fonts\\FRIZQT__.ttf", 12, "OUTLINE")

	local gsub = string.gsub
	local frame = _G[self:GetName()]
	local text = (self.GetHotkey or getButtonHotkey)(self) or ""
	local hotkey = self.HotKey
	local name = self.Name

	-- hotkey:SetText(text)
	-- hotkey:SetShown(text ~= "")
	-- hotkey:ClearAllPoints()
	-- hotkey:SetPoint("TOPRIGHT", self:GetName(), "TOPRIGHT", -22, -22)
	-- hotkey:SetScale(0.9)

	-- if name then
	-- 	name:SetScale(0.85)
	-- end

	if text then
		text = gsub(text, "(s%-)", "S")
		text = gsub(text, "(a%-)", "A")
		text = gsub(text, "(c%-)", "C")
		text = gsub(text, "(st%-)", "C") -- german control 'Steuerung'

		for i = 1, 30 do
			text = gsub(text, _G["KEY_BUTTON" .. i], "M" .. i)
		end

		for i = 1, 9 do
			text = gsub(text, _G["KEY_NUMPAD" .. i], "NU" .. i)
		end

		text = gsub(text, KEY_MOUSEWHEELUP, "MU")
		text = gsub(text, KEY_MOUSEWHEELDOWN, "MD")
		text = gsub(text, KEY_NUMLOCK, "NL")
		text = gsub(text, KEY_PAGEUP, "PU")
		text = gsub(text, KEY_PAGEDOWN, "PD")
		text = gsub(text, KEY_SPACE, "_")
		text = gsub(text, KEY_INSERT, "INS")
		text = gsub(text, KEY_HOME, "HM")
		text = gsub(text, KEY_DELETE, "DEL")
		text = gsub(text, KEY_TAB, "TAB")
		text = gsub(text, "WU", "MU")
		text = gsub(text, "WD", "MD")
		text = gsub(text, "SWU", "SMU")
		text = gsub(text, "Tb", "TAB")
		text = gsub(text, "Del", "DEL")
		text = gsub(text, "Ins", "INS")

		hotkey:SetText(text)
		hotkey:SetShown(text ~= "")
	end

	name:SetScale(0.85)
	hotkey:SetScale(0.9)
	hotkey:SetWidth(40)
	hotkey:ClearAllPoints()
	hotkey:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)

	C_Timer.After(0, function()
		hotkey:ClearAllPoints()
		hotkey:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)
	end)
end

function BindableButton:OnEnter()
	if not KeyBound:IsShown() then
		return
	end

	BindableButtonProxy:ClearAllPoints()
	BindableButtonProxy:SetParent(self)
	BindableButtonProxy:SetAllPoints()

	KeyBound:Set(BindableButtonProxy)
end

-- exports
Addon.BindableButton = BindableButton
