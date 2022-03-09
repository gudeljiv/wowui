-- LIB Design

function SetPoint(frame, point, relativeFrame, relativePoint, ofsx, ofsy)
	if not InCombatLockdown() then
		frame:ClearAllPoints()
		frame:SetPoint(point, relativeFrame, relativePoint, ofsx, ofsy)
	end
end

function MIPO_CreateText(tab)
	tab.textsize = tab.textsize or 12
	local text = tab.frame:CreateFontString(nil, "ARTWORK")
	tab.frame:SetFrameStrata("HIGH")
	text:SetFont(STANDARD_TEXT_FONT, tab.textsize, "OUTLINE")
	text:SetPoint("TOPLEFT", tab.parent, "TOPLEFT", tab.x, tab.y)
	text:SetText(MIPOGT(tab.text))

	hooksecurefunc("MIPOUpdateLanguage", function()
		text:SetText(MIPOGT(tab.text))
	end)

	return text
end

function MIPO_CreateCheckBox(tab)
	tab = tab or {}
	tab.parent = tab.parent or UIParent
	tab.tooltip = tab.tooltip or ""
	tab.x = tab.x or 0
	tab.y = tab.y or 0
	local CB = CreateFrame("CheckButton", nil, tab.parent, "ChatConfigCheckButtonTemplate")
	CB:SetPoint("TOPLEFT", tab.x, tab.y)
	CB.tooltip = tab.tooltip
	CB:SetChecked(tab.checked)
	CB:SetScript("OnClick", function(self)
		local status = CB:GetChecked()
		self:SetChecked(status)
		MIPOPC[tab.dbvalue] = status

		if tab.func ~= nil then
			tab:func()
		end
	end)

	tab.frame = CB
	tab.x = tab.x + 26
	tab.y = tab.y - 6
	CB.text = MIPO_CreateText(tab)

	return CB
end

function MIPO_CreateSlider(tab, extratext)
	tab = tab or {}
	tab.parent = tab.parent or UIParent
	tab.x = tab.x or 0
	tab.y = tab.y or 0
	tab.value = tab.value or 0
	local SL = CreateFrame("Slider", tab.name, tab.parent, "OptionsSliderTemplate")
	SL:SetPoint("TOPLEFT", tab.x, tab.y)
	SL.Low:SetText(tab.min)
	SL.High:SetText(tab.max)
	local trans = {}
	trans["VALUE"] = tab.value
	if extratext then
		SL.Text:SetText(MIPOGT(tab.text, trans) .. " " .. extratext)
	else
		SL.Text:SetText(MIPOGT(tab.text, trans))
	end
	SL:SetMinMaxValues(tab.min, tab.max)
	SL:SetValue(tab.value)
	SL:SetWidth(tab.w or 600)
	SL:SetObeyStepOnDrag(tab.steps)
	tab.steps = tab.steps or 1
	SL:SetValueStep(tab.steps)
	SL.decimals = tab.decimals or 1
	SL:SetScript("OnValueChanged", function(self, val)
		val = mathR(val, self.decimals)
		if tab.steps > 0 then
			val = val - val % tab.steps
		end
		val = mathR(val, self.decimals)
		MIPOPC[tab.dbvalue] = val
		trans = {}
		trans["VALUE"] = val
		if extratext then
			SL.Text:SetText(MIPOGT(tab.text, trans) .. " " .. extratext)
		else
			SL.Text:SetText(MIPOGT(tab.text, trans))
		end
		if tab.func ~= nil then
			tab:func()
		else
			MIPOShowOOM()
		end
	end)

	hooksecurefunc("MIPOUpdateLanguage", function()
		trans = {}
		trans["VALUE"] = SL:GetValue()
		if extratext then
			SL.Text:SetText(MIPOGT(tab.text, trans) .. " " .. extratext)
		else
			SL.Text:SetText(MIPOGT(tab.text, trans))
		end
	end)

	return EB
end

function MIPO_CTexture(frame, tab)
	tab.layer = tab.layer or "BACKGROUND"
	local texture = frame:CreateTexture(nil, tab.layer)
	tab.texture = tab.texture or ""
	tab.color = tab.color or {}
	if tab.texture ~= "" then
		tab.color.r = tab.color.r or 1
		tab.color.g = tab.color.g or 1
		tab.color.b = tab.color.b or 1
		tab.color.a = tab.color.a or 1
	 	texture:SetTexture(tab.texture)
		texture:SetVertexColor(tab.color.r, tab.color.g, tab.color.b, tab.color.a)
	elseif tab.color ~= nil then
		tab.color.r = tab.color.r or 1
		tab.color.g = tab.color.g or 1
		tab.color.b = tab.color.b or 1
		tab.color.a = tab.color.a or 1
		texture:SetColorTexture(tab.color.r, tab.color.g, tab.color.b, tab.color.a)
	else
		texture:SetTexture(tab.texture)
	end

	if tab.autoresize then
		texture:SetAllPoints(frame)
	else
		tab.w = tab.w or frame:GetWidth()
		tab.h = tab.h or frame:GetHeight()
		texture:SetSize(tab.w, tab.h)

		tab.x = tab.x or 0
		tab.y = tab.y or 0
		texture:SetPoint(tab.align or "TOPLEFT", frame, tab.x, tab.y)
	end

	return texture
end

function MIPO_createF(tab)
	tab.w = tab.w or 2
	tab.h = tab.h or 2
	tab.x = tab.x or 0
	tab.y = tab.y or 0
	tab.align = tab.align or "CENTER"
	tab.text = tab.text or "Unnamed"
	tab.textalign = tab.textalign or "CENTER"
	tab.textsize = tab.textsize or tonumber(string.format("%.0f", tab.h * 0.69))
	tab.parent = tab.parent or UIParent
	local frame = CreateFrame("FRAME", tab.name, tab.parent)
	frame:SetWidth(tab.w)
	frame:SetHeight(tab.h)
	frame:ClearAllPoints()
	frame:SetPoint(tab.align, tab.parent, tab.align, tab.x, tab.y)

	tab.layer = tab.layer or "BACKGROUND"
	frame.texture = MIPO_CTexture(frame, tab)

	tab.textlayer = tab.textlayer or "ARTWORK"
	frame.text = frame:CreateFontString(nil, tab.textlayer)
	if tab.framestrata ~= nil then
		frame:SetFrameStrata(tab.framestrata)
	else
		frame:SetFrameStrata("HIGH")
	end
	frame.text:SetFont(STANDARD_TEXT_FONT, tab.textsize, "OUTLINE")
	frame.text:SetPoint(tab.textalign, 0, 0)
	frame.text:SetText(tab.text)

	function frame:SetText(text)
		frame.text:SetText(text)
	end

	frame.oldSetSize = frame.SetSize
	function frame:SetSize(w, h)
		frame:oldSetSize(w, h)
		self.texture:SetSize(w, h)
	end

	return frame
end

function MIPO_CreateBar(tab)
	tab.w = 800
	tab.h = 16
	tab.alpha = 0.7
	tab.text = ""
	tab.bgcolor = tab.bgcolor or {}
	tab.bgcolor.r = tab.bgcolor.r or 0.2
	tab.bgcolor.g = tab.bgcolor.g or 0.2
	tab.bgcolor.b = tab.bgcolor.b or 0.2
	tab.bgcolor.a = tab.bgcolor.a or tab.alpha
	tab.color = tab.bgcolor
	tab.texture = "Interface/TargetingFrame/UI-StatusBar"
	local bar = {}
	tab.autoresize = true
	tab.framestrata = "BACKGROUND"
	tab.oldname = tab.name or ""
	tab.name = tab.oldname .. "Background"
	bar.background = MIPO_createF(tab)

	tab.parent = bar.background
	tab.barcolor = tab.barcolor or {}
	tab.barcolor.r = tab.barcolor.r or 0.3
	tab.barcolor.g = tab.barcolor.g or 0.1
	tab.barcolor.b = tab.barcolor.b or 1
	tab.barcolor.a = tab.barcolor.a or tab.alpha
	tab.color = tab.barcolor
	tab.text = ""
	tab.align = "LEFT"
	tab.texture = "Interface/TargetingFrame/UI-StatusBar"
	tab.autoresize = true
	tab.name = tab.oldname .. "Bar"
	bar.bar = MIPO_createF(tab)
	tab.autoresize = false

	tab.align = "CENTER"
	tab.texture = ""
	tab.color.a = 0
	tab.text = ""
	tab.name = tab.oldname .. "Overlay"
	bar.overlay = MIPO_createF(tab)
	local bars = {}
	bars.layer = "BORDER"
	bars.color = {}
	bars.color.r = 0.2
	bars.color.g = 0.2
	bars.color.b = 0.2
	bars.color.a = tab.alpha
	bars.thickness = 1.1
	bars.w = tab.w
	bars.h = bars.thickness
	bars.align = "TOP"
	bar.overlay.t = MIPO_CTexture(bar.overlay, bars)
	bars.y = 0
	bars.align = "BOTTOM"
	bar.overlay.b = MIPO_CTexture(bar.overlay, bars)
	bars.w = bars.thickness
	bars.h = tab.h
	bars.y = 0
	bars.align = "LEFT"
	bar.overlay.l = MIPO_CTexture(bar.overlay, bars)
	bars.x = 0
	bars.align = "RIGHT"
	bar.overlay.r = MIPO_CTexture(bar.overlay, bars)
	local perc = 10
	local amount = 100 / perc
	for i = 1, amount - 1 do
		bars.x = tonumber(string.format("%.0f", (bar.overlay:GetWidth() / amount) * i) - (bars.thickness / 2))
		bars.align = nil
		bar.overlay[i] = MIPO_CTexture(bar.overlay, bars)
	end

	function bar:Hide()
		bar.background:Hide()
	end
	function bar:Show()
		bar.background:Show()
	end

	function bar:GetHeight()
		return self.background:GetHeight()
	end

	function bar:SetHeight(h)
		bar.background:SetHeight(h)
		bar.bar:SetHeight(h)

		bar.overlay:SetHeight(h)
		bar.overlay.l:SetHeight(h)
		bar.overlay.r:SetHeight(h)
		for i = 1, amount - 1 do
			bar.overlay[i]:SetHeight(h)
		end
		bar.overlay.text:SetFont(STANDARD_TEXT_FONT, tonumber(string.format("%.0f", h * 0.69)), "OUTLINE")
		--bar.overlay.text:SetTextHeight(tonumber(string.format("%.0f", h * 0.69)))
	end

	function bar:GetWidth()
		return self.background:GetWidth()
	end

	function bar:SetWidth(w)
		w = mathR(w, 0)
		bar.background:SetWidth(w)

		bar.overlay:SetWidth(w)
		bar.overlay.t:SetWidth(w)
		bar.overlay.b:SetWidth(w)
		for i = 1, amount - 1 do
			local x = tonumber(string.format("%.0f", (bar.overlay:GetWidth() / amount) * i) - (bars.thickness / 2))
			bar.overlay[i]:SetPoint("TOPLEFT", bar.overlay, x, 0)
		end
	end

	bar.overlay:EnableMouse()
	bar.overlay:SetScript("OnEnter", function() bar.overlay.text:Hide() end)
	bar.overlay:SetScript("OnLeave", function() bar.overlay.text:Show() end)

	return bar
end
