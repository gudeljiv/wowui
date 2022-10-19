local gsub = string.gsub

hooksecurefunc(
	'ActionButton_UpdateHotkeys',
	function(self)
		local hotkey = _G[self:GetName() .. 'HotKey']
		local text = hotkey:GetText()

		if (text) then
			text = gsub(text, '(s%-)', 'S-')
			text = gsub(text, '(a%-)', 'A-')
			text = gsub(text, '(c%-)', 'C-')
			text = gsub(text, '(st%-)', 'C-') -- german control 'Steuerung'

			for i = 1, 30 do
				text = gsub(text, _G['KEY_BUTTON' .. i], 'M' .. i)
			end

			for i = 1, 9 do
				text = gsub(text, _G['KEY_NUMPAD' .. i], 'NU' .. i)
			end

			text = gsub(text, KEY_MOUSEWHEELUP, 'MU')
			text = gsub(text, KEY_MOUSEWHEELDOWN, 'MD')
			text = gsub(text, KEY_NUMLOCK, 'NL')
			text = gsub(text, KEY_PAGEUP, 'PU')
			text = gsub(text, KEY_PAGEDOWN, 'PD')
			text = gsub(text, KEY_SPACE, '_')
			text = gsub(text, KEY_INSERT, 'INS')
			text = gsub(text, KEY_HOME, 'HM')
			text = gsub(text, KEY_DELETE, 'DEL')

			hotkey:SetText(text)
		else
			-- hotkey:SetText(RANGE_INDICATOR)
			-- hotkey:SetPoint('TOPLEFT', button, 'TOPLEFT', 1, -2)
			hotkey:Hide()
		end
	end
)
