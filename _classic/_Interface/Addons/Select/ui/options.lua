-- options.lua handles the interface option panel, mostly defined in the xml

local _, s = ...
s.options = SelectOptionsPanel

s.options.name = "Select"

function s.options.refresh()
	local settingsUI = s.options.scrollFrame:GetScrollChild().settings
	s.options.version:SetText(GetAddOnMetadata("Select", "Version"))
	s.options:EnableSettings(not InCombatLockdown())
	for k, v in pairs(s.settings.defaults) do
		if settingsUI[k] then
			settingsUI[k]:SetChecked(s.settings:Get(k) and true)
		end
	end
end

-- setting default values from the Default button on the interface options panel
function s.options.default()
	if not InCombatLockdown() then
		for k, v in pairs(s.settings.defaults) do
			s.settings:Set(k, v)
		end
	else
		print("Select can't restore values to default during combat, sorry! Try again after leaving combat.")
	end
end

InterfaceOptions_AddCategory(s.options)

-- this enables/disabled the settings (makes them grey/uninteractive) depending on isEnabled; because changing settings can potentially
-- set attributes, they're not enabled in combat; called when entering/leaving combat in main if optionsPanel is visible and in refresh above
function s.options:EnableSettings(isEnabled)
	local settingsUI = s.options.scrollFrame:GetScrollChild().settings

	for k, v in pairs(s.settings.defaults) do
		if settingsUI[k] then
			if isEnabled then
				settingsUI[k]:SetEnabled(true)
				settingsUI[k].text:SetTextColor(1, 0.82, 0)
			else
				settingsUI[k]:SetEnabled(false)
				settingsUI[k].text:SetTextColor(0.4, 0.4, 0.4)
			end
		end
	end

	if isEnabled then
		settingsUI.optionDescription:Hide()
	else
		settingsUI.optionDescription:Show()
		settingsUI.optionDescription.optionTitle:SetText("")
		settingsUI.optionDescription.optionText:SetText("You are in combat. Settings cannot be changed in combat, sorry.\n\nTry again once you've left combat.")
	end
end

-- when one of the checkbuttons is clicked (can only happen outside of combat), update both the savedvar and the root attributes
function s.options:CheckButtonOnClick(...)
	local newValue = self:GetChecked() and true
	s.settings:Set(self.optionKey, newValue)
end
