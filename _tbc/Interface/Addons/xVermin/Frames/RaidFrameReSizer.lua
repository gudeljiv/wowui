--This is how you make the raid frames even more resizable :) you can also put all this in one line and just use a macro in game.
-- local n, w, h = "CompactUnitFrameProfilesGeneralOptionsFrame"
-- h, w = _G[n .. "HeightSlider"], _G[n .. "WidthSlider"]
-- h:SetMinMaxValues(1, 150)
-- w:SetMinMaxValues(1, 150)

-- local Button = CreateFrame("Button", "AddOnName_ButtonName", nil, "SecureActionButtonTemplate")
-- Button:SetAttribute("type", "macro")
-- Button:SetAttribute("macrotext", "/cast [@mouseover] Lesser Heal")
-- SetOverrideBindingClick(Button, "F12", "AddOnName_ButtonName")
