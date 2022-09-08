-- By D4KiR

local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

DUFBUILD = "CLASSIC"
if select(4, GetBuildInfo()) > 90000 then
	DUFBUILD = "RETAIL"
elseif select(4, GetBuildInfo()) > 29999 then
	DUFBUILD = "WRATH"
elseif select(4, GetBuildInfo()) > 19999 then
	DUFBUILD = "TBC"
end

local vars = false
local addo = false

local DUFLoaded = false

DUFTAB = DUFTAB or {}
DUFTABPC = DUFTABPC or {}

function DUFGetConfig(key, value, pc)
	if DUFLoaded then
		if DUFTAB ~= nil and DUFTABPC ~= nil then
			if pc then
				if DUFTABPC[key] ~= nil then
					value = DUFTABPC[key]
				else
					DUFTABPC[key] = value
				end
			else
				if DUFTAB[key] ~= nil then
					value = DUFTAB[key]
				else
					DUFTAB[key] = value
				end
			end
		end
	end
	return value
end



function DUFCreateSlider(parent, key, vval, x, y, vmin, vmax, steps, lstr, func)
	local SL = CreateFrame("Slider", nil, parent, "OptionsSliderTemplate")

	SL:SetWidth(600)
	SL:SetPoint("TOPLEFT", x, y)

	SL.Low:SetText(vmin)
	SL.High:SetText(vmax)
	
	SL.Text:SetText(DUFGT(lstr) .. ": " .. DUFGetConfig(key, vval))

	SL:SetMinMaxValues(vmin, vmax)

	SL:SetValue(DUFGetConfig(key, vval))

	SL:SetObeyStepOnDrag(steps)
	SL:SetValueStep(steps)

	SL:SetScript("OnValueChanged", function(self, val)
		val = string.format("%.0f", val)
		DUFTAB[key] = tonumber(val)
		SL.Text:SetText(DUFGT(lstr) .. ": " .. val)
		if func ~= nil then
			func()
		end
	end)

	return SL
end

function DUFCreateCheckBox(parent, key, vval, x, y, lstr, pc)
	local CB = CreateFrame("CheckButton", nil, parent, "ChatConfigCheckButtonTemplate")
	CB:SetSize(24, 24)

	CB:SetPoint("TOPLEFT", x, y)

	CB.Text:SetPoint("LEFT", CB, "RIGHT", 0, 0)
	CB.Text:SetText(DUFGT(lstr))

	CB:SetChecked(DUFGetConfig(key, vval))

	CB:SetScript("OnClick", function(self, val)
		val = CB:GetChecked()
		if pc then
			DUFTABPC[key] = val
		else
			DUFTAB[key] = val
		end
		CB.Text:SetText(DUFGT(lstr))
	end)

	return CB
end

function DUFCreateComboBox(parent, key, vval, x, y, lstr, tab, func)
	local CB = LibDD:Create_UIDropDownMenu("Frame", parent)
	CB:SetPoint("TOPLEFT", x, y)

	
	CB.text = CB:CreateFontString(nil, "ARTWORK") 
	CB.text:SetFont(STANDARD_TEXT_FONT, 12, "")
	CB.text:SetText(DUFGT(lstr))
	CB.text:SetPoint("LEFT", CB, "RIGHT", 0, 3)
	CB.Text:SetText(DUFGT(lstr) .. ": " .. tostring(DUFGetConfig(key, vval)))

	LibDD:UIDropDownMenu_SetWidth(CB, 120)
	LibDD:UIDropDownMenu_SetText(CB, DUFGetConfig(key, vval))

	-- Create and bind the initialization function to the dropdown menu
	LibDD:UIDropDownMenu_Initialize(CB, function(self, level, menuList)
		for i, v in pairs(tab) do
			local info = LibDD:UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			info.text = v
			info.arg1 = v
			LibDD:UIDropDownMenu_AddButton(info)
		end
	end)

	function CB:SetValue(newValue)
		DUFTAB[key] = newValue

		LibDD:UIDropDownMenu_SetText(CB, newValue)
		LibDD:CloseDropDownMenus()

		if func ~= nil then
			func()
		end
	end

	return CB
end



function DUFUpdateTextureColors()
	PlayerFrameTexture:SetVertexColor(1, 1, 1)
	TargetFrameTextureFrameTexture:SetVertexColor(1, 1, 1)
	if FocusFrameTextureFrameTexture then
		FocusFrameTextureFrameTexture:SetVertexColor(1, 1, 1)
	end
	for id = 1, 4 do
		if _G["PartyMemberFrame" .. id .. "Texture"] then
			_G["PartyMemberFrame" .. id .. "Texture"]:SetVertexColor(1, 1, 1)
		end
	end
end



local Y = 0
local H = 16
local BR = 30

local SORTTAB = {}
SORTTAB = {"Group", "Role"}

local dufsetting = false
function DUFInitSettings()
	if not dufsetting then
		dufsetting = true

		local DUFSettings = {}

		local DUFname = "DUnitFrames |T134167/:16:16:0:0|t by |cFFAAAAFFD4KiR |T132115/:16:16:0:0|t"

		local settingname = DUFname
		DUFSettings.panel = CreateFrame("FRAME")
		DUFSettings.panel.name = settingname

		Y = 0
		H = 16
		BR = 30

		Y = Y - 10
		local text = DUFSettings.panel:CreateFontString(nil, "ARTWORK")
		text:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
		text:SetPoint("TOPLEFT", DUFSettings.panel, "TOPLEFT", 10, Y)
		text:SetText("Settings")

		DUFCreateComboBox(DUFSettings.panel, "portraitmode", "Dark", 0, -30, "portraitmode", {"Dark", "Bright", "Dark-Grey", "DarkV2", "DarkV2Small", "Light", "MediumGrey", "Muted", "Old", "Default"}, function()
			UnitFramePortrait_Update(PlayerFrame)
			for id = 1, 4 do
				UnitFramePortrait_Update(_G["PartyMemberFrame" .. id])
			end
		end)

		DUFCreateComboBox(DUFSettings.panel, "bordermode", "Class+Status", 0, -60, "bordermode", {"Class+Status", "Class", "Status", "Dark", "Black", "Default"}, function()
			DUFUpdateTextureColors()
		end)

		DUFCreateComboBox(DUFSettings.panel, "barmode", "Class+Status", 0, -90, "barmode", {"Class+Status", "Class", "Status", "Default"}, function()
			DUFUpdateTextureColors()
		end)

		DUFCreateComboBox(DUFSettings.panel, "numbermode", "X.X Dynamic", 0, -120, "numbermode", {"Default", "X Dynamic", "X.X Dynamic", "X.XX Dynamic", "X.XXX", "XK", "X.XK", "X.XXK"}, function()
			if PlayerFrameHealthBarTextRight then
				PlayerFrameHealthBarTextRight:SetText(PlayerFrameHealthBarTextRight:GetText())
			end
			if TargetFrameHealthBarTextRight then
				TargetFrameHealthBarTextRight:SetText(TargetFrameHealthBarTextRight:GetText())
			end
			if FocusFrameTextureFrameHealthBarTextRight then
				FocusFrameTextureFrameHealthBarTextRight:SetText(FocusFrameTextureFrameHealthBarTextRight:GetText())
			end
		end)

		DUFCreateComboBox(DUFSettings.panel, "percentmode", "X.X%", 0, -150, "percentmode", {"Default", "X.X%", "X.XX%"}, function()
			if PlayerFrameHealthBarTextLeft then
				PlayerFrameHealthBarTextLeft:SetText(PlayerFrameHealthBarTextLeft:GetText())
			end
			if TargetFrameHealthBarTextLeft then
				TargetFrameHealthBarTextLeft:SetText(TargetFrameHealthBarTextLeft:GetText())
			end
			if FocusFrameTextureFrameHealthBarTextLeft then
				FocusFrameTextureFrameHealthBarTextLeft:SetText(FocusFrameTextureFrameHealthBarTextLeft:GetText())
			end
		end)

		DUFCreateComboBox(DUFSettings.panel, "namemode", "Over Portrait", 0, -180, "namemode", {"Over Portrait", "Over Health", "Hide"}, function()
			TargetFrameTextureFrameName:SetText(TargetFrameTextureFrameName:GetText())
		end)

		DUFCreateSlider(DUFSettings.panel, "hpheight", 27, 10, -240, 12, 28, 1, "hpheight", function()
			DUFUpdatePlayerFrame()
			DUFUpdateTargetFrame()
			DUFUpdateTargetTexture()
			if DUFUpdateFocusFrame then
				DUFUpdateFocusFrame()
			end
			if DUFUpdateFocusTexture then
				DUFUpdateFocusTexture()
			end
			if DUFUpdatePartyMemberFrames then
				DUFUpdatePartyMemberFrames()
			end
			for id = 1, 4 do
				local func = _G["DUFUpdateParty" .. id .. "Texture"]
				if func then
					func()
				end
			end
		end)

		DUFCreateSlider(DUFSettings.panel, "namesize", 10, 10, -280, 6, 20, 1, "namesize", function()
			if TargetFrameTextureFrameName then
				TargetFrameTextureFrameName:SetText(TargetFrameTextureFrameName:GetText())
			end
			if FocusFrameTextureFrameName then
				FocusFrameTextureFrameName:SetText(FocusFrameTextureFrameName:GetText())
			end
		end)

		DUFCreateCheckBox(DUFSettings.panel, "hidewhenfull", false, 10, -320, "hidewhenfull")

		if ComboPointPlayerFrame then
			DUFCreateCheckBox(DUFSettings.panel, "hidecombopoints", false, 10, -340, "hidecombopoints")
		end

		if CanInspect and GetInspectSpecialization then
			DUFCreateCheckBox(DUFSettings.panel, "showspecs", true, 10, -360, "showspecs")
		end

		if DUFBUILD ~= "RETAIL" then
			DUFCreateCheckBox(DUFSettings.panel, "showthreat", true, 10, -400, "showthreat")
		end

		DUFCreateSlider(DUFSettings.panel, "bartexture", 0, 10, -440, 0, 18, 1, "bartexture", function()
			if PlayerFrameHealthBar then
				PlayerFrameHealthBar:SetStatusBarTexture("")
			end
			if PlayerFrameManaBar then
				PlayerFrameManaBar:SetStatusBarTexture("")
			end

			if TargetFrameHealthBar then
				TargetFrameHealthBar:SetStatusBarTexture("")
			end
			if TargetFrameManaBar then
				TargetFrameManaBar:SetStatusBarTexture("")
			end

			if FocusFrameHealthBar then
				FocusFrameHealthBar:SetStatusBarTexture("")
			end
			if FocusFrameManaBar then
				FocusFrameManaBar:SetStatusBarTexture("")
			end
		end)

		local b = CreateFrame("Button", "MyButton", DUFSettings.panel, "UIPanelButtonTemplate")
		b:SetSize(200, 24) -- width, height
		b:SetText("DISCORD")
		b:SetPoint("BOTTOMLEFT", 10, 10)
		b:SetScript("OnClick", function()
			local iconbtn = 32
			local s = CreateFrame("Frame", nil, UIParent) -- or you actual parent instead
			s:SetSize(300, 2 * iconbtn + 2 * 10)
			s:SetPoint("CENTER")

			s.texture = s:CreateTexture(nil, "BACKGROUND")
			s.texture:SetColorTexture(0, 0, 0, 0.5)
			s.texture:SetAllPoints(s)

			s.text = s:CreateFontString(nil,"ARTWORK") 
			s.text:SetFont(STANDARD_TEXT_FONT, 11, "")
			s.text:SetText("Feedback")
			s.text:SetPoint("CENTER", s, "TOP", 0, -10)

			local eb = CreateFrame("EditBox", "logEditBox", s, "InputBoxTemplate")
			eb:SetFrameStrata("DIALOG")
			eb:SetSize(280, iconbtn)
			eb:SetAutoFocus(false)
			eb:SetText("https://discord.gg/UeBsafs")
			eb:SetPoint("TOPLEFT", 10, -10 - iconbtn)

			s.close = CreateFrame("Button", "closediscord", s, "UIPanelButtonTemplate")
			s.close:SetFrameStrata("DIALOG")
			s.close:SetPoint("TOPLEFT", 300 - 10 - iconbtn, -10)
			s.close:SetSize(iconbtn, iconbtn)
			s.close:SetText("X")
			s.close:SetScript("OnClick", function(self, btn, down)
				s:Hide()
			end)
		end)

		InterfaceOptions_AddCategory(DUFSettings.panel)
	end
end


SetCVar("ScriptErrors", 1)
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")

local once = true
function f:OnEvent(event, ...)
	if event == "PLAYER_ENTERING_WORLD" and once then
		once = false

		if DUFTAB["bartexture"] == nil then
			DUFTAB["bartexture"] = 0
		end

		DUFLoaded = true 

		UnitFramePortrait_Update(PlayerPortrait)
		PlayerFrameTexture:SetVertexColor(1, 1, 1)

		DUFPlayerFrameSetup()
		DUFTargetFrameSetup()
		if DUFFocusFrameSetup then
			DUFFocusFrameSetup()
		end
		if DUFPartyMemberFramesSetup then
			DUFPartyMemberFramesSetup()
		end

		UnitFramePortrait_Update(PlayerFrame)
		for id = 1, 4 do
			UnitFramePortrait_Update(_G["PartyMemberFrame" .. id])
		end

		-- PlayerFrame
		hooksecurefunc("PlayerFrame_ToPlayerArt", DUFUpdatePlayerFrame);

		-- TargetFrame
		hooksecurefunc("TargetFrame_CheckClassification", function()
			DUFUpdateTargetTexture()
			if DUFUpdateFocusTexture then
				DUFUpdateFocusTexture()
			end
		end)
		
		DUFInitSettings()
	end
end
f:SetScript("OnEvent", f.OnEvent)
