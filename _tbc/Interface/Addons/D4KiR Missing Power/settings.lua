-- By D4KiR

MIPOBUILD = "CLASSIC"
if select(4, GetBuildInfo()) > 90000 then
	MIPOBUILD = "RETAIL"
elseif select(4, GetBuildInfo()) > 19999 then
	MIPOBUILD = "TBC"
end

function MIPO_InitSetting()
	MIPO_Settings = {}
	local settingname = MIPO.colorauthor .. MIPO.author .. " " .. MIPO.colorname .. MIPO.name
	MIPO_Settings.panel = CreateFrame("Frame", settingname, UIParent)
	MIPO_Settings.panel.name = settingname

	local Y = -14
	local H = 16
	local BR = 30

	local settings_header = {}
	settings_header.frame = MIPO_Settings.panel
	settings_header.parent = MIPO_Settings.panel
	settings_header.x = 10
	settings_header.y = Y
	settings_header.text = settingname
	settings_header.textsize = 24
	MIPO_CreateText(settings_header)
	Y = Y - BR

	local settings_showoverlap = {}
	settings_showoverlap.name = "hideoverlap"
	settings_showoverlap.parent = MIPO_Settings.panel
	settings_showoverlap.checked = MIPOGetConfig("hideoverlap", true)
	settings_showoverlap.text = "hideoverlap"
	settings_showoverlap.x = 10
	settings_showoverlap.y = Y
	settings_showoverlap.dbvalue = "hideoverlap"
	MIPO_CreateCheckBox(settings_showoverlap)
	Y = Y - H

	if MIPOBUILD ~= "RETAIL" then
		local settings_shownextready = {}
		settings_shownextready.name = "shownextready"
		settings_shownextready.parent = MIPO_Settings.panel
		settings_shownextready.checked = MIPOGetConfig("shownextready", true)
		settings_shownextready.text = "shownextready"
		settings_shownextready.x = 10
		settings_shownextready.y = Y
		settings_shownextready.dbvalue = "shownextready"
		MIPO_CreateCheckBox(settings_shownextready)
		Y = Y - H

		local settings_experiment = {}
		settings_experiment.name = "experiment"
		settings_experiment.parent = MIPO_Settings.panel
		settings_experiment.checked = MIPOGetConfig("experiment", false)
		settings_experiment.text = "experiment"
		settings_experiment.x = 10
		settings_experiment.y = Y
		settings_experiment.dbvalue = "experiment"
		MIPO_CreateCheckBox(settings_experiment)
		Y = Y - H
	end

	local settings_showamountcounter = {}
	settings_showamountcounter.name = "showamountcounter"
	settings_showamountcounter.parent = MIPO_Settings.panel
	settings_showamountcounter.checked = MIPOGetConfig("showamountcounter", true)
	settings_showamountcounter.text = "showamountcounter"
	settings_showamountcounter.x = 10
	settings_showamountcounter.y = Y
	settings_showamountcounter.dbvalue = "showamountcounter"
	MIPO_CreateCheckBox(settings_showamountcounter)
	Y = Y - BR

	local settings_poweralpha = {}
	settings_poweralpha.name = "poweralpha"
	settings_poweralpha.parent = MIPO_Settings.panel
	settings_poweralpha.value = MIPOGetConfig("poweralpha", 0.7)
	settings_poweralpha.text = "poweralpha"
	settings_poweralpha.x = 10
	settings_poweralpha.y = Y
	settings_poweralpha.min = 0.1
	settings_poweralpha.max = 1.0
	settings_poweralpha.decimals = 2
	settings_poweralpha.steps = 0.02
	settings_poweralpha.dbvalue = "poweralpha"
	MIPO_CreateSlider(settings_poweralpha)
	Y = Y - BR

	local settings_decimals = {}
	settings_decimals.name = "decimals"
	settings_decimals.parent = MIPO_Settings.panel
	settings_decimals.value = MIPOGetConfig("decimals", 1)
	settings_decimals.text = "decimals"
	settings_decimals.x = 10
	settings_decimals.y = Y
	settings_decimals.min = 0
	settings_decimals.max = 2
	settings_decimals.decimals = 0
	settings_decimals.steps = 1
	settings_decimals.dbvalue = "decimals"
	MIPO_CreateSlider(settings_decimals)
	Y = Y - BR

	local settings_fontsize = {}
	settings_fontsize.name = "fontsize"
	settings_fontsize.parent = MIPO_Settings.panel
	settings_fontsize.value = MIPOGetConfig("fontsize", 10)
	settings_fontsize.text = "fontsize"
	settings_fontsize.x = 10
	settings_fontsize.y = Y
	settings_fontsize.min = 6
	settings_fontsize.max = 16
	settings_fontsize.decimals = 0
	settings_fontsize.steps = 1
	settings_fontsize.dbvalue = "fontsize"
	MIPO_CreateSlider(settings_fontsize)
	Y = Y - BR

	local settings_fontx = {}
	settings_fontx.name = "fontx"
	settings_fontx.parent = MIPO_Settings.panel
	settings_fontx.value = MIPOGetConfig("fontx", 0)
	settings_fontx.text = "fontx"
	settings_fontx.x = 10
	settings_fontx.y = Y
	settings_fontx.min = -2
	settings_fontx.max = 2
	settings_fontx.decimals = 1
	settings_fontx.steps = 0.1
	settings_fontx.dbvalue = "fontx"
	MIPO_CreateSlider(settings_fontx)
	Y = Y - BR

	local settings_fonty = {}
	settings_fonty.name = "fonty"
	settings_fonty.parent = MIPO_Settings.panel
	settings_fonty.value = MIPOGetConfig("fonty", 0)
	settings_fonty.text = "fonty"
	settings_fonty.x = 10
	settings_fonty.y = Y
	settings_fonty.min = -2
	settings_fonty.max = 2
	settings_fonty.decimals = 1
	settings_fonty.steps = 0.1
	settings_fonty.dbvalue = "fonty"
	MIPO_CreateSlider(settings_fonty)
	Y = Y - BR

	local settings_showtickbar = {}
	settings_showtickbar.name = "showtickbar"
	settings_showtickbar.parent = MIPO_Settings.panel
	settings_showtickbar.checked = MIPOGetConfig("showtickbar", true)
	settings_showtickbar.text = "showtickbar"
	settings_showtickbar.x = 10
	settings_showtickbar.y = Y
	settings_showtickbar.dbvalue = "showtickbar"
	MIPO_CreateCheckBox(settings_showtickbar)
	Y = Y - BR

	local settings_customcolor = {}
	settings_customcolor.name = "customcolor"
	settings_customcolor.parent = MIPO_Settings.panel
	settings_customcolor.checked = MIPOGetConfig("customcolor", false)
	settings_customcolor.text = "customcolor"
	settings_customcolor.x = 10
	settings_customcolor.y = Y
	settings_customcolor.dbvalue = "customcolor"
	MIPO_CreateCheckBox(settings_customcolor)
	Y = Y - BR
	
	local settings_ccolr = {}
	settings_ccolr.name = "ccolr"
	settings_ccolr.parent = MIPO_Settings.panel
	settings_ccolr.value = MIPOGetConfig("ccolr", 0)
	settings_ccolr.text = "ccolr"
	settings_ccolr.x = 10
	settings_ccolr.y = Y
	settings_ccolr.min = 0
	settings_ccolr.max = 1
	settings_ccolr.decimals = 2
	settings_ccolr.steps = 0.01
	settings_ccolr.dbvalue = "ccolr"
	MIPO_CreateSlider(settings_ccolr)
	Y = Y - BR

	local settings_ccolg = {}
	settings_ccolg.name = "ccolg"
	settings_ccolg.parent = MIPO_Settings.panel
	settings_ccolg.value = MIPOGetConfig("ccolg", 0)
	settings_ccolg.text = "ccolg"
	settings_ccolg.x = 10
	settings_ccolg.y = Y
	settings_ccolg.min = 0
	settings_ccolg.max = 1
	settings_ccolg.decimals = 2
	settings_ccolg.steps = 0.01
	settings_ccolg.dbvalue = "ccolg"
	MIPO_CreateSlider(settings_ccolg)
	Y = Y - BR

	local settings_ccolb = {}
	settings_ccolb.name = "ccolb"
	settings_ccolb.parent = MIPO_Settings.panel
	settings_ccolb.value = MIPOGetConfig("ccolb", 0)
	settings_ccolb.text = "ccolb"
	settings_ccolb.x = 10
	settings_ccolb.y = Y
	settings_ccolb.min = 0
	settings_ccolb.max = 1
	settings_ccolb.decimals = 2
	settings_ccolb.steps = 0.01
	settings_ccolb.dbvalue = "ccolb"
	MIPO_CreateSlider(settings_ccolb)
	Y = Y - BR

	

	Y = Y - BR
	local settings_displayiflowerthanx = {}
	settings_displayiflowerthanx.name = "displayiflowerthanx"
	settings_displayiflowerthanx.parent = MIPO_Settings.panel
	settings_displayiflowerthanx.value = MIPOGetConfig("displayiflowerthanx", 10)
	settings_displayiflowerthanx.text = "displayiflowerthanx"
	settings_displayiflowerthanx.x = 10
	settings_displayiflowerthanx.y = Y
	settings_displayiflowerthanx.min = 0
	settings_displayiflowerthanx.max = 99
	settings_displayiflowerthanx.decimals = 0
	settings_displayiflowerthanx.steps = 1
	settings_displayiflowerthanx.dbvalue = "displayiflowerthanx"
	MIPO_CreateSlider(settings_displayiflowerthanx, "   [0 = unlimited]")
	Y = Y - BR

	InterfaceOptions_AddCategory(MIPO_Settings.panel)
end
