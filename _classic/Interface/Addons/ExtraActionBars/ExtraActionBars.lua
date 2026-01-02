local addonName, addon = ...

-- Main frame for initialization
local frame = CreateFrame("Frame")
local L = addon.L

-- Constants
local BUTTON_SIZE = 36
local BUTTON_SPACING = 6
local NUM_BUTTONS = 12

-- Variables to store visibility state and position
addon.bars = {
	bar6Visible = true,
	bar7Visible = true,
	bar7Position = "top", -- "top" for above bar 6, "bottom" for above bar 2
}

-- Function to save settings
local function SaveSettings()
	if not CustomActionBarsDB then
		CustomActionBarsDB = {}
	end
	CustomActionBarsDB.bar6Visible = addon.bars.bar6Visible
	CustomActionBarsDB.bar7Visible = addon.bars.bar7Visible
	CustomActionBarsDB.bar7Position = addon.bars.bar7Position
end

-- Function to load settings
local function LoadSettings()
	if not CustomActionBarsDB then
		CustomActionBarsDB = {
			bar6Visible = true,
			bar7Visible = true,
			bar7Position = "top",
		}
	end
	addon.bars.bar6Visible = CustomActionBarsDB.bar6Visible
	addon.bars.bar7Visible = CustomActionBarsDB.bar7Visible
	addon.bars.bar7Position = CustomActionBarsDB.bar7Position or "top"
end

-- Function to create an action bar
local function CreateCustomActionBar(name, startActionID)
	-- Create main container using SecureHandlerStateTemplate
	local bar = CreateFrame("Frame", name, UIParent, "SecureHandlerStateTemplate")
	bar:SetSize((BUTTON_SIZE + BUTTON_SPACING) * NUM_BUTTONS - BUTTON_SPACING, BUTTON_SIZE)
	bar:SetFrameStrata("MEDIUM")
	bar:Show()

	-- Create buttons
	local buttons = {}
	for i = 1, NUM_BUTTONS do
		local buttonName = name .. "Button" .. i
		local button =
			CreateFrame("CheckButton", buttonName, bar, "SecureActionButtonTemplate, ActionBarButtonTemplate")

		-- Remove overlays/highlights
		button.NormalTexture:SetAlpha(0)
		if button.FloatingBG then
			button.FloatingBG:Hide()
		end

		-- Disable border when mouse is over
		button:GetHighlightTexture():SetAlpha(0)

		-- Positioning
		if i == 1 then
			button:SetPoint("LEFT", bar, "LEFT", 0, 0)
		else
			button:SetPoint("LEFT", buttons[i - 1], "RIGHT", BUTTON_SPACING, 0)
		end

		-- Configure button
		local actionID = (startActionID + i - 1)
		button:SetID(actionID)
		button:SetAttribute("type", "action")
		button:SetAttribute("action", actionID)
		button:SetAttribute("actionpage", 1)
		button:SetAttribute("showgrid", 0)
		button:SetAttribute("useparent-unit", true)

		-- Configure secure attributes
		button:SetAttribute("useparent-unit", true)
		button:SetAttribute("useparent-actionpage", true)

		-- Register clicks and drag
		button:RegisterForClicks("AnyUp")
		button:RegisterForDrag("LeftButton", "RightButton")
		button:Show()

		-- Drag scripts
		button:SetScript("OnDragStart", function(self)
			if InCombatLockdown() then
				print("|cffff0000" .. L["COMBAT_LOCKDOWN"] .. "|r")
				return
			end
			PickupAction(actionID)
		end)

		button:SetScript("OnReceiveDrag", function(self)
			if InCombatLockdown() then
				print("|cffff0000" .. L["COMBAT_LOCKDOWN"] .. "|r")
				return
			end
			PlaceAction(actionID)
		end)

		-- Improve event handling
		button:SetScript("OnEvent", function(self, event, ...)
			if event == "UPDATE_BINDINGS" then
				local key = GetBindingKey("CLICK " .. buttonName .. ":LeftButton")
				if key then
					self.HotKey:SetText(GetBindingText(key, "KEY_"))
				else
					self.HotKey:SetText("")
				end
			elseif event == "ACTIONBAR_UPDATE_STATE" then
				if HasAction(actionID) then
					self:SetChecked(IsCurrentAction(actionID))
				end
			elseif event == "ACTIONBAR_UPDATE_COOLDOWN" then
				if HasAction(actionID) then
					local start, duration, enable = GetActionCooldown(actionID)
					CooldownFrame_Set(self.cooldown, start, duration, enable)
				end
			end
		end)

		-- Register for pre-click and post-click
		button:SetAttribute(
			"_onclick",
			[[ 
            if self:GetAttribute("type") == "action" then
                local action = self:GetAttribute("action")
                if action then
                    self:CallMethod("UpdateState")
                end
            end
        ]]
		)

		buttons[i] = button
	end

	return bar, buttons
end

-- Function to update bar 7 position
local function UpdateBar7Position()
	if InCombatLockdown() then
		print("|cffff0000" .. L["COMBAT_LOCKDOWN"] .. "|r")
		return
	end

	if addon.bar7 then
		if addon.bars.bar7Position == "top" then
			addon.bar7:ClearAllPoints()
			addon.bar7:SetPoint("BOTTOM", addon.bar6, "TOP", 0, 5)
		else
			if MultiBarBottomLeft then
				addon.bar7:ClearAllPoints()
				addon.bar7:SetPoint("BOTTOM", MultiBarBottomLeft, "TOP", 0, 5)
			else
				-- Fallback position if bar 2 is not found
				addon.bar7:ClearAllPoints()
				addon.bar7:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 48)
			end
		end
	end
end

-- Functions to show/hide bars
local function ToggleBar6()
	if addon.bar6 then
		addon.bars.bar6Visible = not addon.bars.bar6Visible
		if addon.bars.bar6Visible then
			addon.bar6:Show()
			print("|cff00ff00ExtraActionBars:|r " .. L["BAR6_VISIBLE"])
		else
			addon.bar6:Hide()
			print("|cff00ff00ExtraActionBars:|r " .. L["BAR6_HIDDEN"])
		end
		SaveSettings()
	end
end

local function ToggleBar7()
	if addon.bar7 then
		addon.bars.bar7Visible = not addon.bars.bar7Visible
		if addon.bars.bar7Visible then
			addon.bar7:Show()
			print("|cff00ff00ExtraActionBars:|r " .. L["BAR7_VISIBLE"])
		else
			addon.bar7:Hide()
			print("|cff00ff00ExtraActionBars:|r " .. L["BAR7_HIDDEN"])
		end
		SaveSettings()
	end
end

-- Function to toggle bar 7 position
local function ToggleBar7Position()
	if addon.bar7 then
		addon.bars.bar7Position = addon.bars.bar7Position == "top" and "bottom" or "top"
		UpdateBar7Position()
		print(
			"|cff00ff00ExtraActionBars:|r "
				.. L[addon.bars.bar7Position == "top" and "BAR7_MOVED_TOP" or "BAR7_MOVED_BOTTOM"]
		)
		SaveSettings()
	end
end

-- Function to process slash commands
local function HandleSlashCommands(msg)
	msg = string.lower(msg or "")
	local command = msg:match("^(%S*)%s*(.-)$")

	if command == "6" then
		ToggleBar6()
	elseif command == "7" then
		ToggleBar7()
	elseif command == "position" or command == "pos" then
		ToggleBar7Position()
	else
		-- Show help
		print("|cff00ff00ExtraActionBars - " .. L["AVAILABLE_COMMANDS"] .. "|r")
		print("  |cffffffff/cab 6|r - " .. L["TOGGLE_BAR6"])
		print("  |cffffffff/cab 7|r - " .. L["TOGGLE_BAR7"])
		print("  |cffffffff/cab position|r - " .. L["TOGGLE_POSITION"])
		print("  |cffffffff/cab pos|r - " .. L["TOGGLE_POSITION"])
	end
end

-- Register slash commands
SLASH_CUSTOMACTIONBARS1 = "/cab"
SlashCmdList["CUSTOMACTIONBARS"] = HandleSlashCommands

-- Initialization and events
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		-- Load saved settings
		LoadSettings()

		C_Timer.After(0.1, function()
			-- Create bar 6 using slots 73-84
			local bar6, buttons6 = CreateCustomActionBar("CustomBar6", 73)
			if MultiBarBottomRight then
				bar6:SetPoint("BOTTOM", MultiBarBottomRight, "TOP", 0, 5)
			else
				bar6:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 98)
			end

			-- Create bar 7 using slots 85-96
			local bar7, buttons7 = CreateCustomActionBar("CustomBar7", 85)

			-- Save reference to bars
			addon.bar6 = bar6
			addon.bar7 = bar7
			addon.buttons6 = buttons6
			addon.buttons7 = buttons7

			-- Apply initial bar 7 position
			UpdateBar7Position()

			-- Apply saved visibility state
			if not addon.bars.bar6Visible then
				bar6:Hide()
			end
			if not addon.bars.bar7Visible then
				bar7:Hide()
			end

			-- Register events for buttons
			local function RegisterButtonEvents(button)
				button:RegisterEvent("ACTIONBAR_UPDATE_STATE")
				button:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
				button:RegisterEvent("UPDATE_BINDINGS")
			end

			for _, button in pairs(buttons6) do
				RegisterButtonEvents(button)
			end

			for _, button in pairs(buttons7) do
				RegisterButtonEvents(button)
			end
		end)
	elseif event == "PLAYER_LOGOUT" then
		SaveSettings()
	end
end)
