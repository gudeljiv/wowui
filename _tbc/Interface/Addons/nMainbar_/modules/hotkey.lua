local gsub = string.gsub

-- RANGE_INDICATOR = "•"
local UpdateHotkeys = function(self, t)
	local frame = _G[self:GetName()]
	local hotkey = _G[self:GetName() .. "HotKey"]
	local name = _G[frame:GetName() .. "Name"]
	local text = hotkey:GetText()

	-- print(hotkey:GetName())
	-- print("-->",text,"<--")

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

		if text == RANGE_INDICATOR then
			hotkey:SetText("•")
			hotkey:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 1, 1)
		else
			hotkey:SetText(text)
		end

		if t == 2 then
			hotkey:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -2)
		end
	end

	name:SetScale(0.7)
	name:SetPoint("BOTTOM", frame, "BOTTOM", 2, 5)
	hotkey:SetScale(0.9)
	hotkey:SetWidth(40)
end

if ActionButtonMixin and ActionButtonMixin.UpdateHotkeys then
	hooksecurefunc(ActionButtonMixin, "UpdateHotkeys", function(self)
		UpdateHotkeys(self, 1)
	end)
end

if PetActionButtonMixin and PetActionButtonMixin.UpdateHotkeys then
	hooksecurefunc(PetActionButtonMixin, "UpdateHotkeys", function(self)
		UpdateHotkeys(self, 2)
	end)
end

-- hooksecurefunc(
-- 	'ActionButton_UpdateHotkeys',
-- 	function(self)
-- 		UpdateHotkeys(self, 1)
-- 	end
-- )
-- hooksecurefunc("PetActionButton_SetHotkeys", function(self)
-- 	UpdateHotkeys(self, 2)
-- end)
