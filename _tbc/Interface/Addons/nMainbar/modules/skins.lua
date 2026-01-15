local _, nMainbar = ...
local cfg = nMainbar.Config

if not cfg.MainMenuBar.skinButton then
	return
end

local _G, pairs, unpack = _G, pairs, unpack
local path = "Interface\\AddOns\\nMainbar\\media\\"

local function IsSpecificButton(self, name)
	local sbut = self:GetName():match(name)
	if sbut then
		return true
	else
		return false
	end
end

local function UpdateVehicleButton()
	for i = 1, NUM_OVERRIDE_BUTTONS do
		local button = _G["OverrideActionBarButton" .. i]
		if button then
			local hotkey = _G["OverrideActionBarButton" .. i .. "HotKey"]
			if hotkey then
				if cfg.button.showVehicleKeybinds then
					hotkey:SetFont(cfg.button.hotkeyFont, cfg.button.hotkeyFontsize + 3, "OUTLINE")
					hotkey:SetVertexColor(unpack(cfg.color.HotKeyText))
				else
					hotkey:Hide()
				end
			end
		end
	end
end

-- Updated pet/stance/possess button styling
local function UpdatePetActionButtons()
	for _, name in pairs({
		"PetActionButton",
		"PossessButton",
		"StanceButton",
	}) do
		for i = 1, 12 do
			local button = _G[name .. i]
			if button then
				button:SetNormalTexture(path .. "textureNormal")

				if not InCombatLockdown() then
					local cooldown = _G[name .. i .. "Cooldown"]
					if cooldown then
						cooldown:ClearAllPoints()
						cooldown:SetPoint("TOPRIGHT", button, -2, -2)
						cooldown:SetPoint("BOTTOMLEFT", button, 1, 1)
					end
				end

				if not button.Shadow then
					local normal = _G[name .. i .. "NormalTexture2"] or _G[name .. i .. "NormalTexture"]
					if normal then
						normal:ClearAllPoints()
						normal:SetPoint("TOPRIGHT", button, 1.5, 1.5)
						normal:SetPoint("BOTTOMLEFT", button, -1.5, -1.5)
						normal:SetVertexColor(cfg.color.Normal[1], cfg.color.Normal[2], cfg.color.Normal[3], 1)
					end

					local icon = _G[name .. i .. "Icon"]
					if icon then
						icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
						icon:SetPoint("TOPRIGHT", button, 1, 1)
						icon:SetPoint("BOTTOMLEFT", button, -1, -1)
					end

					local flash = _G[name .. i .. "Flash"]
					if flash then
						flash:SetTexture(nil)
					end

					button:SetCheckedTexture(path .. "textureChecked")
					local checkedTexture = button:GetCheckedTexture()
					if checkedTexture and normal then
						checkedTexture:SetAllPoints(normal)
					end

					button:SetPushedTexture(path .. "texturePushed")
					local pushedTexture = button:GetPushedTexture()
					if pushedTexture and normal then
						pushedTexture:SetAllPoints(normal)
					end

					button:SetHighlightTexture(path .. "textureHighlight")
					local highlightTexture = button:GetHighlightTexture()
					if highlightTexture and normal then
						highlightTexture:SetAllPoints(normal)
					end

					local buttonBg = _G[name .. i .. "FloatingBG"]
					if buttonBg then
						buttonBg:ClearAllPoints()
						buttonBg:SetPoint("TOPRIGHT", button, 5, 5)
						buttonBg:SetPoint("BOTTOMLEFT", button, -5, -5)
						buttonBg:SetTexture(path .. "textureShadow")
						buttonBg:SetVertexColor(0, 0, 0, 1)
						button.Shadow = true
					else
						button.Shadow = button:CreateTexture(nil, "BACKGROUND")
						button.Shadow:SetParent(button)
						if normal then
							button.Shadow:SetPoint("TOPRIGHT", normal, 4, 4)
							button.Shadow:SetPoint("BOTTOMLEFT", normal, -4, -4)
						else
							button.Shadow:SetPoint("TOPRIGHT", button, 4, 4)
							button.Shadow:SetPoint("BOTTOMLEFT", button, -4, -4)
						end
						button.Shadow:SetTexture(path .. "textureShadow")
						button.Shadow:SetVertexColor(0, 0, 0, 1)
					end

					local hotkey = _G[name .. i .. "HotKey"]
					if hotkey and cfg.button.showKeybinds then
						hotkey:ClearAllPoints()
						hotkey:SetPoint("TOPRIGHT", button, 0, -3)
						hotkey:SetFont(cfg.button.hotkeyFont, cfg.button.petHotKeyFontsize, "OUTLINE")
						hotkey:SetVertexColor(unpack(cfg.color.HotKeyText))
					elseif hotkey then
						hotkey:Hide()
					end
				end
			end
		end
	end
end

-- Initialize pet action buttons on relevant events
local petActionFrame = CreateFrame("Frame")
petActionFrame:RegisterEvent("PLAYER_LOGIN")
petActionFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
petActionFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
petActionFrame:RegisterEvent("UNIT_PET")
petActionFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "UNIT_PET" then
		local unit = ...
		if unit == "player" then
			UpdatePetActionButtons()
		end
	else
		UpdatePetActionButtons()
	end
end)

-- Custom function to handle button grid display
local function UpdateButtonGrid(self)
	if not self or not self:GetName() then
		return
	end

	local normal = _G[self:GetName() .. "NormalTexture"]
	if normal then
		normal:SetVertexColor(unpack(cfg.color.Normal))
	end
end

-- Custom function to style action buttons
local function StyleActionButton(self)
	if not self or not self:GetName() then
		return
	end

	-- Force an initial update for hotkeys
	if ActionButton_UpdateHotkeys then
		ActionButton_UpdateHotkeys(self, self.buttonType)
	end

	if IsSpecificButton(self, "MultiCast") then
		for _, icon in pairs({
			self:GetName(),
			"MultiCastRecallSpellButton",
			"MultiCastSummonSpellButton",
		}) do
			local button = _G[icon]
			if button then
				if not button.Shadow then
					local icon = _G[self:GetName() .. "Icon"]
					if icon then
						icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
					end

					button.Shadow = button:CreateTexture(nil, "BACKGROUND")
					button.Shadow:SetParent(button)
					button.Shadow:SetPoint("TOPRIGHT", button, 4.5, 4.5)
					button.Shadow:SetPoint("BOTTOMLEFT", button, -4.5, -4.5)
					button.Shadow:SetTexture(path .. "textureShadow")
					button.Shadow:SetVertexColor(0, 0, 0, 0.85)
				end
			end
		end
	elseif not IsSpecificButton(self, "ExtraActionButton") then
		local button = _G[self:GetName()]
		if not button then
			return
		end

		if not button.Background then
			local normal = _G[self:GetName() .. "NormalTexture"]
			if normal then
				normal:ClearAllPoints()
				normal:SetPoint("TOPRIGHT", button, 1, 1)
				normal:SetPoint("BOTTOMLEFT", button, -1, -1)
				normal:SetVertexColor(unpack(cfg.color.Normal))
			end

			button:SetNormalTexture(path .. "textureNormal")

			button:SetCheckedTexture(path .. "textureChecked")
			local checkedTexture = button:GetCheckedTexture()
			if checkedTexture and normal then
				checkedTexture:SetAllPoints(normal)
			end

			button:SetPushedTexture(path .. "texturePushed")
			local pushedTexture = button:GetPushedTexture()
			if pushedTexture and normal then
				pushedTexture:SetAllPoints(normal)
			end

			button:SetHighlightTexture(path .. "textureHighlight")
			local highlightTexture = button:GetHighlightTexture()
			if highlightTexture and normal then
				highlightTexture:SetAllPoints(normal)
			end

			local icon = _G[self:GetName() .. "Icon"]
			if icon then
				icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
			end

			local count = _G[self:GetName() .. "Count"]
			if count then
				count:SetPoint("BOTTOMRIGHT", button, 0, 1)
				count:SetFont(cfg.button.countFont, cfg.button.countFontsize, "OUTLINE")
				count:SetVertexColor(unpack(cfg.color.CountText))
			end

			local macroname = _G[self:GetName() .. "Name"]
			if macroname then
				if not cfg.button.showMacronames then
					macroname:SetAlpha(0)
				else
					macroname:SetWidth(button:GetWidth() + 15)
					macroname:SetFont(cfg.button.macronameFont, cfg.button.macronameFontsize, "OUTLINE")
					macroname:SetVertexColor(unpack(cfg.color.MacroText))
				end
			end

			local buttonBg = _G[self:GetName() .. "FloatingBG"]
			if buttonBg then
				buttonBg:ClearAllPoints()
				buttonBg:SetPoint("TOPRIGHT", button, 5, 5)
				buttonBg:SetPoint("BOTTOMLEFT", button, -5, -5)
				buttonBg:SetTexture(path .. "textureShadow")
				buttonBg:SetVertexColor(0, 0, 0, 1)
			end

			button.Background = button:CreateTexture(nil, "BACKGROUND", nil, -8)
			button.Background:SetTexture(path .. "textureBackground")
			button.Background:SetPoint("TOPRIGHT", button, 14, 12)
			button.Background:SetPoint("BOTTOMLEFT", button, -14, -16)

			-- Hook the button to update grid on show/hide
			if not button.GridHooked then
				button:HookScript("OnShow", function(self)
					UpdateButtonGrid(self)
				end)
				button.GridHooked = true
			end
		end

		if not InCombatLockdown() then
			local cooldown = _G[self:GetName() .. "Cooldown"]
			if cooldown then
				cooldown:ClearAllPoints()
				cooldown:SetPoint("TOPRIGHT", button, -2, -2.5)
				cooldown:SetPoint("BOTTOMLEFT", button, 2, 2)
			end
		end

		local border = _G[self:GetName() .. "Border"]
		if border and self.action then
			if IsEquippedAction(self.action) then
				border:SetAlpha(1)
				border:SetVertexColor(unpack(cfg.color.IsEquipped))
			else
				border:SetAlpha(0)
			end
		end
	end
end

-- Apply styling to action buttons using multiple approaches
local function InitializeActionButtons()
	-- Style main action bar buttons
	for i = 1, 12 do
		for _, barName in pairs({
			"ActionButton",
			"MultiBarBottomLeftButton",
			"MultiBarBottomRightButton",
			"MultiBarRightButton",
			"MultiBarLeftButton",
			"MultiBar5Button",
			"MultiBar6Button",
			"MultiBar7Button",
		}) do
			local button = _G[barName .. i]
			if button then
				StyleActionButton(button)
				-- Hook the button's update script if it exists
				if button:GetScript("OnUpdate") then
					button:HookScript("OnUpdate", function(self)
						StyleActionButton(self)
					end)
				end
			end
		end
	end

	-- Style override/vehicle buttons
	for i = 1, NUM_OVERRIDE_BUTTONS or 6 do
		local button = _G["OverrideActionBarButton" .. i]
		if button then
			StyleActionButton(button)
		end
	end
end

-- Create frame to handle initialization
local actionButtonFrame = CreateFrame("Frame")
actionButtonFrame:RegisterEvent("PLAYER_LOGIN")
actionButtonFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
actionButtonFrame:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
actionButtonFrame:RegisterEvent("UPDATE_INVENTORY_ALERTS")
actionButtonFrame:RegisterEvent("ACTIONBAR_SHOWGRID")
actionButtonFrame:RegisterEvent("ACTIONBAR_HIDEGRID")
actionButtonFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then
		C_Timer.After(0.5, InitializeActionButtons)
	elseif event == "ACTIONBAR_SLOT_CHANGED" then
		local slot = ...
		if slot then
			-- Update specific button
			for _, barName in pairs({
				"ActionButton",
				"MultiBarBottomLeftButton",
				"MultiBarBottomRightButton",
				"MultiBarRightButton",
				"MultiBarLeftButton",
				"MultiBar5Button",
				"MultiBar6Button",
				"MultiBar7Button",
			}) do
				local button = _G[barName .. slot]
				if button then
					StyleActionButton(button)
				end
			end
		end
	elseif event == "ACTIONBAR_SHOWGRID" or event == "ACTIONBAR_HIDEGRID" then
		-- Update all buttons when grid is shown/hidden
		for i = 1, 12 do
			for _, barName in pairs({
				"ActionButton",
				"MultiBarBottomLeftButton",
				"MultiBarBottomRightButton",
				"MultiBarRightButton",
				"MultiBarLeftButton",
				"MultiBar5Button",
				"MultiBar6Button",
				"MultiBar7Button",
			}) do
				local button = _G[barName .. i]
				if button then
					UpdateButtonGrid(button)
				end
			end
		end
	end
end)

-- Hook ActionButton_ShowGrid if it exists
if ActionButton_ShowGrid then
	hooksecurefunc("ActionButton_ShowGrid", function(self)
		UpdateButtonGrid(self)
	end)
end

-- Hook ActionButton_UpdateUsable if it exists
if ActionButton_UpdateUsable then
	hooksecurefunc("ActionButton_UpdateUsable", function(self)
		if not self or not self:GetName() or not self.action then
			return
		end

		if
			IsAddOnLoaded("RedRange")
			or IsAddOnLoaded("GreenRange")
			or IsAddOnLoaded("tullaRange")
			or IsAddOnLoaded("RangeColors")
		then
			return
		end

		local normal = _G[self:GetName() .. "NormalTexture"]
		if normal then
			normal:SetVertexColor(unpack(cfg.color.Normal))
		end

		local icon = _G[self:GetName() .. "Icon"]
		if not icon then
			return
		end

		local isUsable, notEnoughMana = IsUsableAction(self.action)
		if isUsable then
			icon:SetVertexColor(1, 1, 1)
		elseif notEnoughMana then
			icon:SetVertexColor(unpack(cfg.color.OutOfMana))
		else
			icon:SetVertexColor(unpack(cfg.color.NotUsable))
		end
	end)
end

-- Hook ActionButton_UpdateHotkeys if it exists
if ActionButton_UpdateHotkeys then
	hooksecurefunc("ActionButton_UpdateHotkeys", function(self, actionButtonType)
		if not self or not self:GetName() then
			return
		end

		local hotkey = _G[self:GetName() .. "HotKey"]
		if not hotkey then
			return
		end

		if not IsSpecificButton(self, "OverrideActionBarButton") then
			if cfg.button.showKeybinds then
				hotkey:ClearAllPoints()
				hotkey:SetPoint("TOPRIGHT", self, 0, -3)
				hotkey:SetFont(cfg.button.hotkeyFont, cfg.button.hotkeyFontsize, "OUTLINE")
				hotkey:SetVertexColor(unpack(cfg.color.HotKeyText))
			else
				hotkey:Hide()
			end
		else
			UpdateVehicleButton()
		end
	end)
end

-- Hook ActionButton_OnUpdate if it exists
if ActionButton_OnUpdate then
	hooksecurefunc("ActionButton_OnUpdate", function(self, elapsed)
		if not self or not self:GetName() or not self.action then
			return
		end

		if IsAddOnLoaded("tullaRange") or IsAddOnLoaded("RangeColors") then
			return
		end

		if self.rangeTimer == TOOLTIP_UPDATE_TIME then
			local hotkey = _G[self:GetName() .. "HotKey"]
			if not hotkey then
				return
			end

			local icon = _G[self:GetName() .. "Icon"]
			if not icon then
				return
			end

			local valid = IsActionInRange(self.action)
			if hotkey:GetText() == RANGE_INDICATOR then
				if valid == false then
					hotkey:Show()
					if cfg.button.buttonOutOfRange then
						icon:SetVertexColor(unpack(cfg.color.OutOfRange))
						hotkey:SetVertexColor(unpack(cfg.color.OutOfRange))
					else
						hotkey:SetVertexColor(unpack(cfg.color.OutOfRange))
					end
				elseif valid then
					hotkey:Show()
					hotkey:SetVertexColor(unpack(cfg.color.HotKeyText))
					if ActionButton_UpdateUsable then
						ActionButton_UpdateUsable(self)
					end
				else
					hotkey:Hide()
				end
			else
				if valid == false then
					if cfg.button.buttonOutOfRange then
						icon:SetVertexColor(unpack(cfg.color.OutOfRange))
						hotkey:SetVertexColor(unpack(cfg.color.OutOfRange))
					else
						hotkey:SetVertexColor(unpack(cfg.color.HotKeyText))
					end
				else
					hotkey:SetVertexColor(unpack(cfg.color.HotKeyText))
					if ActionButton_UpdateUsable then
						ActionButton_UpdateUsable(self)
					end
				end
			end
		end
	end)
end
