local addonNameFull = GetAddOnMetadata('GatherMate2Marker', 'X-FullName')
local addonVersion = GetAddOnMetadata('GatherMate2Marker', 'Version')
local addonAuthor = GetAddOnMetadata('GatherMate2Marker', 'Author')

local addonSupportLink = 'https://discord.gg/wTFM4pghYn'

local GatherMate2Marker = LibStub('AceAddon-3.0'):NewAddon('GatherMate2Marker', 'AceConsole-3.0', 'AceTimer-3.0')
local GatherMate = LibStub('AceAddon-3.0'):GetAddon('GatherMate2')
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local profile = {}

GM_Display, GM_Display_addMiniMapPinStub = nil
PinDB, GM2_DB = nil

HeaderColor_h1 = '|cffffd200'
HeaderColor_h2 = '|cffffff78'
Text_normal = '|cffffffff'
Text_special1 = '|cFF8888FF'
Text_special2 = '|cFFFF4500'

local generalOptions = {
    name = addonNameFull .. ' Options',
    handler = GatherMate2Marker,
    type = 'group',
    args = {
		helpGeneral = {
			type = 'description',
			name = 'General Options',
			order = 1
		},
		enabled = {
			type = 'toggle',
			name = 'Add-On Enabled',
			desc = 'Enable or disable marking of recently visited GM2 tracking nodes via ' .. addonNameFull,
			get = 'GetEnabled',
			set = 'SetEnabled',
			width = 'full',
			order = 2
		},
		helpNode = {
			type = 'description',
			name = '\r\nNode Options',
			order = 3
		},				
		markedNodeColor = {
			type = 'color',
			name = 'Marked Node Color',
			hasAlpha = true,
			desc = 'Color and Alpha for marked nodes. To simply dim existing minimap icon and GM2 circles, just set to white and adjust alpha value.',
			get = 'GetMarkedNodeColor',
			set = 'SetMarkedNodeColor',
			width = 'full',
			order = 4
		},
		useGatherMateCircleDefault = 
		{
			type = 'toggle',
			name = 'Use default GatherMate circle color',
			desc = 'Check this to ignore our custom color when showing the circle, and instead use GatherMate 2\'s default color (green for herbs, as of this writing).\r\n\r\nThis is useful if you have your marker color set to 0 alpha, but still want to know when GatherMate has identified that you\'re within range of a potential resource node.',
			get = 'GetUseGMCircleColor',
			set = 'SetUseGMCircleColor',
			width = 'full',
			order = 5
		},
		markResetTimeInMinutes = {
			type = 'input',
			name = 'Mark Reset Minutes',
			desc = 'Time (in minutes) to reset marked node icons. Default is 5. Supports partial minutes (0.5, etc.)',
			get = 'GetResetTimeInMinutes',
			set = 'SetResetTimeInMinutes',
			width = 'normal',
			order = 6
		},
		persistOnReload = {
			type = 'toggle',
			name = 'Persist on reload',
			desc = 'Remember mini-map node states during reload/login',
			get = 'GetPersistOnReload',
			set = 'SetPersistOnReload',
			width = 'full',
			order = 7
		},
		playSFXOnMarked = {
			type = 'toggle',
			name = 'SFX on mark',
			desc = 'Play a subtle sound when nodes on mini-map are considered marked',
			get = 'GetPlaySFXOnMarked',
			set = 'SetPlaySFXOnMarked',
			width = 'normal',
			order = 8
		},
		playSFXOnMarkedVolume = {
			type = 'select',
			name = 'SFX Volume',
			desc = 'Node marked volume',
			get = 'GetPlaySFXOnMarkedVolume',
			set = 'SetPlaySFXOnMarkedVolume',
			width = 'normal',
			values = {
				subtle = "Subtle",
				normal = "Normal",
				loud = "Loud"
			},
			order = 9
		},
		helpMisc = {
			type = 'description',
			name = '\r\nWhile reloading the UI should not be required, doing so will reset the state of things (Timers, marked node colors, etc.) If you radically change your timers or experience any visual issues, simply click the button below.',
			order = 10
		},				
		reloadUIButton = {
			type = 'execute',
			name = 'Reload UI',
			desc = 'Reload the Blizz UI',
			func = function () ReloadUI() end,
			order = 11
		}
    }
}

local helpOptions = {
	type = 'group',
	name = 'Help / FAQ',
	args = {
		supportHeader = {
			order = 1,
			type = 'description',
			name = HeaderColor_h2 .. 'Addon Discord (best way for support!)\r\n',
			width = 'full',
			fontSize = 'large'
		},
		supportDetails = {
			name = 'Discord Channel (select text, and copy to clipboard)',
			order = 2,
			type = 'input',
			get = function() return addonSupportLink end,
			width = 'full',
		},
		whatIsThisThingFaqHeader = {
			order = 3,
			type = 'description',
			name = '\r\n\r\n' .. HeaderColor_h2 .. 'What does ' .. addonNameFull .. ' do?',
			width = 'full',
			fontSize = 'large'
		},
		whatIsThisThingFaqDetails = {
			order = 4,
			type = 'description',
			name = '\r\n' .. addonNameFull .. ' works with GatherMate2 to optionally dim or color nodes once you have \'seen\' them on your minimap. If you walk or fly close to a resource node, the node on your MiniMap will mark itself as \'seen\', per your ' .. addonNameFull .. ' settings.',
			width = 'full',
			fontSize = 'medium'
		},
		optimalDistanceFaqHeader = {
			order = 5,
			type = 'description',
			name = HeaderColor_h2 .. '\r\nOptimal Tracking Distance',
			width = 'full',
			fontSize = 'large'
		},
		optimalDistanceFaqDetails = {
			order = 6,
			type = 'description',
			name = '\r\n' .. 'To get the most out of ' .. addonNameFull .. ', set GatherMate2\'s \'Tracking Distance\' (located under ' 
				.. Text_special1 .. 'GatherMate 2->Minimap->Tracking Distance|r to somewhere around ' .. Text_special2 .. 
				'80 -110|r.\r\n\r\nThe general idea is that when you pass near a resource node, GatherMate displays a tracking circle (dependent on how far you are from the historical data node.)\r\n\r\nIf a resource exists at that point, it will light up (via WoW\'s built-in tracker). ' .. 
				'\r\n\r\n' .. addonNameFull .. ' will change the resource node icon\'s color on your MiniMap to let you know you\'ve already scanned the node.\r\n\r\nIcons will reset to their normal color once ' .. 
				addonNameFull .. '\'s timer has ended.',
			width = 'full',
			fontSize = 'medium'
		},
		miscFaqHeader = {
			order = 7,
			type = 'description',
			name = HeaderColor_h2 .. '\r\nWhy set a custom color?',
			width = 'full',
			fontSize = 'large'
		},
		miscDistanceFaqDetails = {
			order = 8,
			type = 'description',
			name = '\r\n' .. 'GatherMate automatically fades resource nodes that are far away. They are shown on the edges of the MiniMap. Choosing an explicit color/alpha can help to disambiguate visited/marked resource nodes from GM2\'s fade rules.',
			width = 'full',
			fontSize = 'medium'
		},
		generalFaqHeader = {
			order = 9,
			type = 'description',
			name = HeaderColor_h2 .. '\r\nFuture Improvements',
			width = 'full',
			fontSize = 'large'
		},
		generalDistanceFaqDetails = {
			order = 10,
			type = 'description',
			name = '\r\n' .. '- Integrated Routes support: Set marked node colors to the choosen Routes route color.\r\n\r\n- Optional SFX or UI notification when a node has been marked \'seen\'. This might be useless, since Blizz doesn\'t notify when actual collectable resoures are available.',
			width = 'full',
			fontSize = 'medium'
		}
	}
}

local aboutOptions = {
	type = 'group',
	name = 'About',
	args = {
		supportHeader = {
			order = 1,
			type = 'description',
			name = HeaderColor_h2 .. 'Addon Discord (best way for support!)\r\n',
			width = 'full',
			fontSize = 'large'
		},
		supportDetails = {
			name = 'Discord Channel (select text, and copy to clipboard)',
			order = 2,
			type = 'input',
			get = function() return addonSupportLink end,
			width = 'full',
		},
		versionHeader = {
			order = 3,
			type = 'description',
			name = '\r\n\r\n' .. HeaderColor_h2 .. 'Version',
			width = 'full',
			fontSize = 'large'
		},		
		versionText = {
			order = 4,
			type = 'description',
			name = '\r\nCurrent version: ' .. addonVersion,
			width = 'full',
			fontSize = 'medium'
		},
		authorHeader = {
			order = 5,
			type = 'description',
			name = HeaderColor_h2 .. '\r\nAddon Author',
			width = 'full',
			fontSize = 'large'
		},
		authorText = {
			order = 6,
			type = 'description',
			name = '\r\n' .. addonNameFull .. ' by ' .. addonAuthor,
			width = 'full',
			fontSize = 'medium'
		},
		creditsHeader = {
			order = 7,
			type = 'description',
			name = HeaderColor_h2 .. '\r\nGatherMate 2 Page',
			width = 'full',
			fontSize = 'large'
		},
		creditsText = {
			order = 8,
			type = 'description',
			name = '\r\nhttps://www.curseforge.com/wow/addons/gathermate2-classic',
			width = 'full',
			fontSize = 'medium'
		}
	}
}

local optionDefaults = {
    profile = {
        enabled = true,
		useGMCircleColor = false,
		ResetTimeInMinutes = 5,
		nodeColor = { 1.0, 1.0, 1.0, 0.45 },
		persistOnReload = true,
		playSFXOnMarked = false,
		playSFXOnMarkedVolume = 'normal',
    }
}

function GatherMate2Marker:SetDefaults()
	if profile.enabled == nil then
		profile.enabled = optionDefaults.profile.enabled
	end

	if profile.nodeColor == nil then 
		profile.nodeColor = optionDefaults.profile.nodeColor
	end

	if profile.ResetTimeInMinutes == nil then
		profile.ResetTimeInMinutes = optionDefaults.profile.ResetTimeInMinutes
	end

	if profile.persistOnReload == nil then
		profile.persistOnReload = optionDefaults.profile.persistOnReload
	end
end

function GatherMate2Marker:OnInitialize()
	self.db = LibStub('AceDB-3.0'):New('GatherMate2MarkerDB', optionDefaults)
    profile = self.db.profile

	self:SetDefaults()

    self.db.RegisterCallback(self, 'OnProfileChanged', 'RefreshConfig')
    self.db.RegisterCallback(self, 'OnProfileCopied', 'RefreshConfig')
    self.db.RegisterCallback(self, 'OnProfileReset', 'ResetConfig')

    AceConfigRegistry:RegisterOptionsTable(addonNameFull, generalOptions)
    AceConfigDialog:AddToBlizOptions(addonNameFull, addonNameFull)

    AceConfigRegistry:RegisterOptionsTable("GM2M/Help", helpOptions)
    AceConfigDialog:AddToBlizOptions("GM2M/Help", "Help / FAQ", addonNameFull)
    
    AceConfigRegistry:RegisterOptionsTable("GM2M/About", aboutOptions)
    AceConfigDialog:AddToBlizOptions("GM2M/About", "About", addonNameFull)

    AceConfigRegistry:RegisterOptionsTable("GM2M/Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db))
    AceConfigDialog:AddToBlizOptions("GM2M/Profiles", "Profiles", addonNameFull)

	-- general initialization
	if profile.pinDB == nil then
		profile.pinDB = {}
	end

	-- get ahold of GatherMate2 modules and data
	GM2_DB = GatherMate.db.profile

	GM_Display = GatherMate2:GetModule('Display')
	GM_Display_addMiniMapPinActual = GM_Display.addMiniPin

	-- if we are enabled, override addMiniPin with our local override
	if profile.enabled == true then
		GM_Display.addMiniPin = GatherMate2Marker.AddMiniPin_STUB
	end

	GatherMate2Marker:CancelAllTimers()

    self:RegisterChatCommand('gmm', 'ToggleOptions')	
    self:RegisterChatCommand('gm2m', 'ToggleOptions')	

	print(addonNameFull .. ' initialized')
end	

function GatherMate2Marker:OnEnable()
	if profile.persistOnReload == true then
		PinDB = profile.pinDB
		-- cleanup pins if they have exceeded their timers
		for key, value in pairs(profile.pinDB) do
			local activeTimer = PinDB[key].activeTimer
			if activeTimer ~= nil then
				local timeRemaining = PinDB[key].activeTimer.ends - GetTime()

				if timeRemaining <= 0 then
					PinDB[key] = nil
				else
					PinDB[key].activeTimer = GatherMate2Marker:ScheduleTimer("ResetNodeToDefault", timeRemaining, key, nil)
				end
			end
		end
	else
		profile.pinDB = {}
		PinDB = profile.pinDB
	end
end

function GatherMate2Marker:SetEnabled(info, val)	
	profile.enabled = val

	if profile.enabled == true then
		if GM_Display.addMiniPin ~= GatherMate2Marker.AddMiniPin_STUB then
	 		GM_Display.addMiniPin = GatherMate2Marker.AddMiniPin_STUB
		end
	else
	 	GM_Display.addMiniPin = GM_Display_addMiniMapPinActual
	end

	-- Have GM dispatch a map refresh
	GM_Display:UpdateMiniMap(true)
end

function GatherMate2Marker:GetEnabled(info)
    return profile.enabled
end

function GatherMate2Marker:SetPersistOnReload(info, val)
	profile.persistOnReload = val
end

function GatherMate2Marker:GetPersistOnReload(info)
    return profile.persistOnReload
end

function GatherMate2Marker:SetPlaySFXOnMarked(info, val)
	profile.playSFXOnMarked = val
end

function GatherMate2Marker:GetPlaySFXOnMarked(info)
	return profile.playSFXOnMarked
end

function GatherMate2Marker:SetPlaySFXOnMarkedVolume(info, val)
	profile.playSFXOnMarkedVolume = val
end

function GatherMate2Marker:GetPlaySFXOnMarkedVolume(info)
	return profile.playSFXOnMarkedVolume
end

function GatherMate2Marker:SetUseGMCircleColor(info, val)
	profile.useGMCircleColor = val

	GM_Display:UpdateMiniMap(true)
end

function GatherMate2Marker:GetUseGMCircleColor(info)
    return profile.useGMCircleColor
end

function GatherMate2Marker:GetMarkedNodeColor(info)
	return UnpackColorData(profile.nodeColor)
end

function GatherMate2Marker:SetMarkedNodeColor(info, r, g, b, a)
	profile.nodeColor = { r, g, b, a }
    self:RefreshConfig()    
end

function GatherMate2Marker:GetResetTimeInMinutes(info)
    return tostring(profile.ResetTimeInMinutes)
end

function GatherMate2Marker:SetResetTimeInMinutes(info, val)
	profile.ResetTimeInMinutes = val
    self:RefreshConfig()    
end

local function ScrollToCategory(panelName, offset)
    local idx = 0
    InterfaceOptionsFrameAddOnsListScrollBar:SetValue(0)
    for i,cat in ipairs(INTERFACEOPTIONS_ADDONCATEGORIES) do 
        if not cat.hidden then 
            idx = idx + 1
            if cat.name == panelName then
                break
            end
        end
    end

    local numbuttons = #(InterfaceOptionsFrameAddOns.buttons)
    if idx and numbuttons and idx > numbuttons then
        local btnHeight = InterfaceOptionsFrameAddOns.buttons[1]:GetHeight()
        InterfaceOptionsFrameAddOnsListScrollBar:SetValue((offset+idx-numbuttons)*btnHeight)
    end
end

function GatherMate2Marker:ToggleOptions()
	showOptionsPanel = not showOptionsPanel
	if showOptionsPanel then
		InterfaceOptionsFrame_Show()
		ScrollToCategory(addonNameFull)
		InterfaceOptionsFrame_OpenToCategory(addonNameFull)
		InterfaceOptionsFrame_OpenToCategory(addonNameFull)
	else
		InterfaceOptionsFrame_Show()
	end 
end

function GatherMate2Marker:RefreshConfig()
	GM_Display:UpdateMiniMap(false)
end

function GatherMate2Marker:ResetConfig()
	profile.nodeColor = optionDefaults.profile.nodeColor
	profile.ResetTimeInMinutes = optionDefaults.profile.ResetTimeInMinutes
	profile.enabled = optionDefaults.profile.enabled
	profile.persistOnReload = optionDefaults.profile.persistOnReload

	profile.pinDB = {}
	PinDB = profile.pinDB
	self:RefreshConfig()
end

function GatherMate2Marker:AddMiniPin_STUB(pin, refresh)
	-- trigger the original GM2 addMinimapPin method
	GM_Display_addMiniMapPinActual(_, pin, refresh)	

	if profile.enabled == false then
		return
	end

	-- GM2 still marks the circles, but no point in marking them as seen, since like.. we're dead!
	local isDeadOrGhost = UnitIsDeadOrGhost('player') 
	local isTraveling = UnitOnTaxi('player')

	if isDeadOrGhost == true or isTraveling then
		return
	end

	if pin.isCircle == true then		
		if PinDB[pin.coords] == nil then
			PinDB[pin.coords] = {}

			-- optionally play a sound effect if marking a node for the first time (in the timeout window)
			if profile.playSFXOnMarked == true then
				local sfxVolumeType = profile.playSFXOnMarkedVolume
				local sfxFile = ''

				if sfxVolumeType == 'normal' then
					sfxFile = 'Interface\\AddOns\\GatherMate2Marker\\Sounds\\mark_pop_normal.mp3'
				elseif sfxVolumeType == 'subtle' then
					sfxFile = 'Interface\\AddOns\\GatherMate2Marker\\Sounds\\mark_pop_subtle.mp3'
				elseif sfxVolumeType == 'loud' then
					sfxFile = 'Interface\\AddOns\\GatherMate2Marker\\Sounds\\mark_pop_loud.mp3'
				end

				if sfxFile ~= '' then
					PlaySoundFile(sfxFile, "sfx", false)
				end
			end
		end

		PinDB[pin.coords].touched = true

		if profile.useGMCircleColor ~= true then
			pin.texture:SetVertexColor(UnpackColorData(profile.nodeColor))
		end

		-- we've gotten close to a resource node. Cancel any existing timers.
		if PinDB[pin.coords].activeTimer ~= nil then
			GatherMate2Marker:CancelTimer(PinDB[pin.coords].activeTimer)
			PinDB[pin.coords].activeTimer = nil
		end

		-- mark this for future checks. When we get far enough away from the node, we'll kick off our timer.
		PinDB[pin.coords].wasCircle = true
	elseif PinDB[pin.coords] ~= nil and PinDB[pin.coords].touched == true then
		if PinDB[pin.coords].wasCircle == true then
			pinCoords = pin.coords

			-- kick off a timer, to return the node to its default visuals
			PinDB[pin.coords].activeTimer = GatherMate2Marker:ScheduleTimer("ResetNodeToDefault", profile.ResetTimeInMinutes * 60, pinCoords, nil)
								
			-- reset this for future checks
			PinDB[pin.coords].wasCircle = false
		end

		pin.texture:SetVertexColor(UnpackColorData(profile.nodeColor))
	end

	-- if we have a pin with no utility, drop it from PinDB
	if PinDB[pin.coords] ~= nil and PinDB[pin.coords].touched == false and PinDB[pin.activeTimer] == nil then
		PinDB[pin.coords] = nil
	end
end

function GatherMate2Marker:ResetNodeToDefault(coords)
	if coords == nil then
		return
	end

	GatherMate2Marker:CancelTimer(PinDB[coords].activeTimer)

	PinDB[coords].touched = false
	PinDB[coords].activeTimer = nil
end

-- internal utility methods
function UnpackColorData(val)
	return unpack(val)
end
