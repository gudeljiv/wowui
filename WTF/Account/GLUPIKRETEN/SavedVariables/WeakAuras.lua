
WeakAurasSaved = {
	["dynamicIconCache"] = {
	},
	["displays"] = {
		["KTHeader"] = {
			["outline"] = "None",
			["color"] = {
				1, -- [1]
				0.18039215686275, -- [2]
				0.35294117647059, -- [3]
				1, -- [4]
			},
			["displayText"] = "Kill Tracker",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/1l0r5Zkq0/3",
			["actions"] = {
				["start"] = {
					["custom"] = "WeakAuras.ScanEvents(\"WA_KILL_TRACKER_SHOW\")",
					["do_custom"] = true,
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["names"] = {
						},
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["custom_hide"] = "timed",
						["type"] = "custom",
						["custom"] = "function(event, a,b,c,d,e,f,g,h,i)\n    if h:find(\"Creature-\") ~= 1 then\n        return false\n    end\n    WeakAuras.ScanEvents(\"WA_KILL_TRACKER_KILL\", i)\nend\n\n\n\n",
						["custom_type"] = "event",
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED:UNIT_DIED",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 33,
			["wordWrap"] = "WordWrap",
			["font"] = "Friz Quadrata TT",
			["version"] = 3,
			["subRegions"] = {
			},
			["load"] = {
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["use_never"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 13,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["selfPoint"] = "BOTTOM",
			["conditions"] = {
			},
			["automaticWidth"] = "Auto",
			["yOffset"] = 2,
			["semver"] = "1.0.2",
			["tocversion"] = 11304,
			["id"] = "KTHeader",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["config"] = {
			},
			["uid"] = "fdocIUeXKsh",
			["xOffset"] = 0,
			["justify"] = "LEFT",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["preferToUpdate"] = false,
			["parent"] = "Kill Tracker",
		},
		["PlayerDurability"] = {
			["xOffset"] = 1553.00012207031,
			["preferToUpdate"] = false,
			["customText"] = "",
			["yOffset"] = -610.000144958496,
			["anchorPoint"] = "LEFT",
			["cooldownSwipe"] = true,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/seOfQEa4e/3",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["use_alwaystrue"] = true,
						["duration"] = "1",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["unevent"] = "auto",
						["custom_type"] = "status",
						["event"] = "Conditions",
						["customStacks"] = "function() return aura_env.Durability end",
						["subeventPrefix"] = "SPELL",
						["custom"] = "function(event, ...)\n    if (aura_env[event]) then aura_env[event](...) end\n    return true\nend",
						["spellIds"] = {
						},
						["events"] = "PLAYER_DEAD, UPDATE_INVENTORY_DURABILITY, PLAYER_ENTERING_WORLD, DURABILITY_MOUSEOVER",
						["check"] = "event",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["custom"] = "function() return true end",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["unevent"] = "timed",
						["custom_hide"] = "timed",
						["duration"] = "1",
						["event"] = "Chat Message",
						["use_unit"] = true,
						["unit"] = "player",
						["events"] = "DURABILITY_MOUSEOVER",
						["custom"] = "function(event, state) return state end",
						["custom_type"] = "status",
						["check"] = "event",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["custom"] = "function() return true end",
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 33,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 3,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%stacks%",
					["text_shadowColor"] = {
						0.2078431372549, -- [1]
						0.21960784313726, -- [2]
						0.25490196078431, -- [3]
						0.75, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_stacks_format"] = "none",
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						0.94901960784314, -- [1]
						0.96470588235294, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_anchorYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontType"] = "None",
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
				}, -- [1]
				{
					["type"] = "subborder",
					["border_size"] = 9,
					["border_color"] = {
						0.086274509803922, -- [1]
						0.090196078431373, -- [2]
						0.10196078431373, -- [3]
						1, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Details BarBorder 2",
					["border_offset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["glow"] = false,
					["useGlowColor"] = true,
					["glowScale"] = 1,
					["glowThickness"] = 2,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.17254901960784, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["type"] = "subglow",
					["glowLength"] = 10,
					["glowType"] = "Pixel",
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 30,
			["load"] = {
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "HUNTER",
					["multi"] = {
						["HUNTER"] = true,
					},
				},
				["use_never"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameFrame"] = "WeakAuras:ManaBar - Simple",
			["regionType"] = "icon",
			["displayIcon"] = "136241",
			["selfPoint"] = "CENTER",
			["cooldownTextDisabled"] = false,
			["cooldownEdge"] = false,
			["alpha"] = 1,
			["width"] = 30,
			["zoom"] = 0.25,
			["auto"] = true,
			["tocversion"] = 11304,
			["id"] = "PlayerDurability",
			["uid"] = ")DLrhdy4P3p",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["init"] = {
					["custom"] = "-- lint\nlocal _G = _G\nlocal GetInventoryItemDurability = _G.GetInventoryItemDurability\nlocal GameTooltip = _G.GameTooltip\nlocal CreateFrame = _G.CreateFrame\nlocal UIParent = _G.UIParent\nlocal GetInventoryItemLink = _G.GetInventoryItemLink\nlocal GameTooltip_SetDefaultAnchor = _G.GameTooltip_SetDefaultAnchor or GameTooltip:SetAnchorType('ANCHOR_CURSOR')\n\n-- vars\nlocal aura_env = aura_env -- luacheck: ignore\nlocal WeakAuras = WeakAuras -- luacheck: ignore\nWeakAuras.CustomPersistance = WeakAuras.CustomPersistance or { }\naura_env.Frame = nil\naura_env.Durability = 0\naura_env.OnInit = function()\n    if (not WeakAuras.CustomPersistance['e6c0ff9b65_Durability']) then\n        local f = CreateFrame('Button', nil, UIParent, 'SecureActionButtonTemplate')\n        f:SetAttribute('type', 'macro')\n        f:SetAttribute('macrotext', '/script ToggleCharacter(\"PaperDollFrame\")')\n        f:SetFrameStrata('BACKGROUND')\n        f:SetScript('OnEnter', function() WeakAuras.ScanEvents('DURABILITY_MOUSEOVER', true) end)\n        f:SetScript('OnLeave', function() WeakAuras.ScanEvents('DURABILITY_MOUSEOVER', false) end)\n        WeakAuras.CustomPersistance['e6c0ff9b65_Durability'] = f\n    end\n    aura_env.Frame = WeakAuras.CustomPersistance['e6c0ff9b65_Durability']\n    aura_env.Frame:SetAllPoints(WeakAuras.regions[aura_env.id].region)\nend\n\n-- event\naura_env.DURABILITY_MOUSEOVER = function(mouseover)\n    if (not GameTooltip:IsForbidden()) then\n        if (mouseover) then\n            GameTooltip:SetOwner(UIParent)\n            GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)\n            GameTooltip:SetText('Durability')\n            for i = 1, 18 do\n                local cur, max = GetInventoryItemDurability(i)\n                if (cur and max) then\n                    GameTooltip:AddDoubleLine(GetInventoryItemLink('player', i), math.floor(100 / max * cur).. '%', nil, nil, nil, 1, 1, 1)\n                    --GameTooltip:AddTexture(GetInventoryItemTexture('player', i))\n                end\n            end\n            GameTooltip:Show()\n        else GameTooltip:Hide() end\n    end\nend\n\naura_env.UPDATE_INVENTORY_DURABILITY = function()\n    aura_env.Durability = 100\n    for i = 1, 18 do local cur, max = GetInventoryItemDurability(i)\n        if cur and max then\n            cur = math.floor(100 / max * cur)\n            if (cur < aura_env.Durability) then aura_env.Durability = cur end\n        end\n    end\nend\n\naura_env.PLAYER_DEAD = aura_env.UPDATE_INVENTORY_DURABILITY\n\naura_env.PLAYER_ENTERING_WORLD = function()\n    aura_env.OnInit()\n    aura_env.UPDATE_INVENTORY_DURABILITY()\nend",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["config"] = {
			},
			["inverse"] = false,
			["semver"] = "1.0.2",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
						{
							["value"] = {
								0.94901960784314, -- [1]
								0.96470588235294, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.border_color",
						}, -- [2]
					},
				}, -- [1]
			},
			["color"] = {
				0.72941176470588, -- [1]
				0.77254901960784, -- [2]
				0.85098039215686, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
		},
		["nanShield"] = {
			["grow"] = "CUSTOM",
			["controlledChildren"] = {
				"nanShield:Value", -- [1]
				"nanShield:Text", -- [2]
				"nanShield:Bar", -- [3]
				"nanShield:Segment", -- [4]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 171.999633789063,
			["preferToUpdate"] = false,
			["yOffset"] = 188.007629394531,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
			["url"] = "https://wago.io/CjL90mVtb/10",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["unit"] = "player",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["event"] = "Health",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["internalVersion"] = 33,
			["selfPoint"] = "CENTER",
			["align"] = "CENTER",
			["rotation"] = 345,
			["version"] = 10,
			["subRegions"] = {
			},
			["load"] = {
				["use_class"] = false,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["arcLength"] = 30,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["limit"] = 5,
			["animate"] = false,
			["customGrow"] = "function(newPositions, activeRegions)\n    local offset = 9/64 -- target_indicator_glow texture center offset\n    local distance = 18/64\n    local angle, x, y, h, w, s, c, sb, cb, da\n    local curveAngle, segmentCount, direction, base, direction\n\n    for i, r in ipairs(activeRegions) do\n        if r.region.GetRotation then\n            direction = r.data.config.direction\n            base = (r.data.config.rotationOffset + direction * 180)\n            angle = r.region:GetRotation() - direction * 180\n            h = r.data.height\n            w = r.data.width\n            curveAngle = r.data.config.curveAngle\n            segmentCount = r.data.config.segmentCount\n            s = sin(angle)\n            c = cos(angle)\n            sb = sin(base + (direction - 1) * 180)\n            cb = cos(base + (direction - 1) * 180)\n            da = curveAngle / (segmentCount - 1)\n            radius = 0.5 * w * distance / sin(da / 2)\n            x = c * radius + s * w * offset * (direction - 1.5) * 2 + radius * cb\n            y = s * radius * h / w - c * h * offset * (direction - 1.5) * 2 + radius * h / w * sb\n        else\n            x = 0\n            y = 0\n        end\n\n        if newPositions[i] then\n            newPositions[i][1] = x\n            newPositions[i][2] = y\n        else\n            newPositions[i] = {x, y}\n        end\n    end\nend\n",
			["scale"] = 1,
			["radius"] = 300,
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
			["useLimit"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["constantFactor"] = "RADIUS",
			["gridWidth"] = 5,
			["borderOffset"] = 4,
			["semver"] = "1.3.4",
			["tocversion"] = 11302,
			["id"] = "nanShield",
			["uid"] = "QYuwGRyspxh",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["stagger"] = 0,
			["config"] = {
			},
			["borderInset"] = 1,
			["rowSpace"] = 1,
			["conditions"] = {
			},
			["authorOptions"] = {
			},
			["gridType"] = "RD",
		},
		["Kill Tracker"] = {
			["controlledChildren"] = {
				"KTHeader", -- [1]
				"KTTotal", -- [2]
				"KTList", -- [3]
				"KTReset", -- [4]
			},
			["borderBackdrop"] = "Blizzard Dialog Background",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -254,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0, -- [4]
			},
			["url"] = "https://wago.io/1l0r5Zkq0/3",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 33,
			["selfPoint"] = "BOTTOMLEFT",
			["version"] = 3,
			["subRegions"] = {
			},
			["load"] = {
				["use_class"] = false,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.76470410823822, -- [4]
			},
			["scale"] = 1,
			["border"] = true,
			["borderEdge"] = "Blizzard Tooltip",
			["regionType"] = "group",
			["borderSize"] = 1,
			["borderOffset"] = 10,
			["semver"] = "1.0.2",
			["tocversion"] = 11304,
			["id"] = "Kill Tracker",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["uid"] = "NQfLrO1EXvg",
			["xOffset"] = 564.999633789063,
			["groupIcon"] = 136183,
			["conditions"] = {
			},
			["config"] = {
			},
			["borderInset"] = 1,
		},
		["Loot Spy"] = {
			["arcLength"] = 360,
			["controlledChildren"] = {
				"Loot Alert Message", -- [1]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = -1264.00008010864,
			["preferToUpdate"] = false,
			["groupIcon"] = 136155,
			["gridType"] = "RD",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0, -- [4]
			},
			["space"] = 5,
			["url"] = "https://wago.io/ePZfV4FVs/6",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["unit"] = "player",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 0,
			["radius"] = 200,
			["selfPoint"] = "TOP",
			["align"] = "CENTER",
			["desc"] = "Display loot alerts for items of your choosing. Filter by rarity, keyword and if everyone passed an item. \nBy Oron",
			["stagger"] = 0,
			["version"] = 6,
			["subRegions"] = {
			},
			["uid"] = ")8lOB5YlNP1",
			["load"] = {
				["use_class"] = false,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["useLimit"] = true,
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.76470410823822, -- [4]
			},
			["internalVersion"] = 33,
			["animate"] = true,
			["grow"] = "DOWN",
			["scale"] = 1,
			["rotation"] = 0,
			["border"] = false,
			["borderEdge"] = "None",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 10,
			["useAnchorPerUnit"] = false,
			["yOffset"] = -460.000061035156,
			["constantFactor"] = "RADIUS",
			["rowSpace"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.5",
			["tocversion"] = 11305,
			["id"] = "Loot Spy",
			["frameStrata"] = 1,
			["gridWidth"] = 6,
			["anchorFrameType"] = "SCREEN",
			["sort"] = "none",
			["borderInset"] = 1,
			["anchorPoint"] = "TOP",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["conditions"] = {
			},
			["config"] = {
			},
			["authorOptions"] = {
			},
		},
		["Mana 5SecondRule + Ticks"] = {
			["sparkWidth"] = 10,
			["borderBackdrop"] = "Blizzard Tooltip",
			["color"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 5,
			["anchorPoint"] = "TOPRIGHT",
			["sparkHidden"] = "NEVER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/8jnpoLFyU/1",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "aura_env.lastMana = UnitPower(\"player\" , 0)",
					["do_custom"] = true,
				},
				["finish"] = {
					["custom"] = "WeakAuras.ScanEvents(\"TICKUPDATE\", true)",
					["do_custom"] = false,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "2",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["unit"] = "player",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["custom_type"] = "stateupdate",
						["event"] = "Health",
						["use_unit"] = true,
						["events"] = "UNIT_SPELLCAST_SUCCEEDED:player UNIT_POWER_FREQUENT:player",
						["custom"] = "function(a, e, t)\n    local currentMana = UnitPower(\"player\" , 0)\n    \n    if currentMana >= UnitPowerMax(\"player\", 0) then\n        return false\n    end\n    \n    if e == \"UNIT_POWER_FREQUENT\" and currentMana > aura_env.lastMana then\n        local duration = 2\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n        \n    elseif e == \"UNIT_SPELLCAST_SUCCEEDED\" and currentMana < aura_env.lastMana then\n        local duration = 6.45 -- why?\n        --local duration = 5\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n    end\n    \n    --aura_env.lastMana = currentMana\n    return true\nend",
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["check"] = "event",
						["subeventSuffix"] = "_ENERGIZE",
						["sourceUnit"] = "player",
						["customVariables"] = "{\n    duration = true\n}",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 33,
			["sparkOffsetX"] = 0,
			["selfPoint"] = "BOTTOMRIGHT",
			["backdropInFront"] = false,
			["xOffset"] = -2,
			["barColor"] = {
				0, -- [1]
				0.235294117647059, -- [2]
				1, -- [3]
				0.647058099508286, -- [4]
			},
			["desaturate"] = false,
			["icon"] = false,
			["stickyDuration"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "aurabar_bar",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 15,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Accidental Presidency",
					["text_text_format_p_time_precision"] = 1,
					["text_anchorYOffset"] = -10,
					["text_visible"] = false,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "SPARK",
					["text_text_format_p_format"] = "timed",
					["text_shadowYOffset"] = -1,
					["text_fontSize"] = 20,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_dynamic"] = false,
				}, -- [2]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 5,
					["border_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.5, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "None",
					["border_size"] = 16,
				}, -- [3]
			},
			["height"] = 7,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_class"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "ROGUE",
					["multi"] = {
						["HUNTER"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
						["MAGE"] = true,
						["DRUID"] = true,
						["PALADIN"] = true,
						["PRIEST"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["config"] = {
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["anchorFrameFrame"] = "PlayerFrameHealthBar",
			["width"] = 115,
			["customAnchor"] = "PlayerFrame",
			["smoothProgress"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["alpha"] = 1,
			["icon_side"] = "RIGHT",
			["useAdjustededMax"] = false,
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["semver"] = "1.0.0",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Mana 5SecondRule + Ticks",
			["zoom"] = 0,
			["frameStrata"] = 4,
			["anchorFrameType"] = "SELECTFRAME",
			["spark"] = true,
			["uid"] = "jKqxo1NY(5d",
			["inverse"] = false,
			["sparkOffsetY"] = 0,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "<",
						["variable"] = "duration",
						["value"] = "5",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "inverse",
						}, -- [1]
					},
				}, -- [1]
			},
			["authorOptions"] = {
			},
			["backgroundColor"] = {
				0, -- [1]
				0.141176470588235, -- [2]
				0.149019607843137, -- [3]
				0.264704823493958, -- [4]
			},
		},
		["Mana regen with 5s rule"] = {
			["sparkWidth"] = 15,
			["sparkOffsetX"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -104.371459960938,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/d1KmPR0Rj/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
					["custom"] = "WeakAuras.ScanEvents(\"TICKUPDATE\", true)",
					["do_custom"] = false,
				},
				["init"] = {
					["custom"] = "aura_env.lastMana = UnitPower(\"player\" , 0)\naura_env.lastCast = GetTime()",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "2",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["names"] = {
						},
						["subeventSuffix"] = "_ENERGIZE",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["use_unit"] = true,
						["spellIds"] = {
						},
						["events"] = "UNIT_SPELLCAST_SUCCEEDED:player UNIT_POWER_FREQUENT:player",
						["custom"] = "function(a, e, t)\n    local currentMana = UnitPower(\"player\" , 0)\n    \n    if currentMana >= UnitPowerMax(\"player\", 0) then\n        return false\n    end\n    \n    if e == \"UNIT_POWER_FREQUENT\" and currentMana > aura_env.lastMana and GetTime() >= aura_env.lastCast + 5 then\n        local duration = 2\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n        \n    elseif e == \"UNIT_SPELLCAST_SUCCEEDED\" and currentMana < aura_env.lastMana then\n        local duration = 6 -- why?\n        --local duration = 5\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n        aura_env.lastCast = GetTime()\n    end\n    return true\nend",
						["use_sourceUnit"] = true,
						["check"] = "event",
						["custom_type"] = "stateupdate",
						["sourceUnit"] = "player",
						["customVariables"] = "{\n    duration = true\n}",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 33,
			["spark"] = true,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["backdropInFront"] = false,
			["barColor"] = {
				0, -- [1]
				0.23529411764706, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["desaturate"] = false,
			["icon"] = false,
			["color"] = {
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "aurabar_bar",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 15,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Accidental Presidency",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_fontType"] = "None",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "SPARK",
					["text_text_format_p_format"] = "timed",
					["text_anchorYOffset"] = 0,
					["text_fontSize"] = 20,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_dynamic"] = false,
				}, -- [2]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 5,
					["border_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.5, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "None",
					["border_size"] = 16,
				}, -- [3]
			},
			["height"] = 1.00000739097595,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["load"] = {
				["use_class"] = false,
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "ROGUE",
					["multi"] = {
						["HUNTER"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
						["MAGE"] = true,
						["DRUID"] = true,
						["PALADIN"] = true,
						["PRIEST"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["borderBackdrop"] = "Blizzard Tooltip",
			["selfPoint"] = "CENTER",
			["uid"] = "dvZawXAyrxC",
			["config"] = {
			},
			["sparkTexture"] = "GarrMission_EncounterBar-Spark",
			["smoothProgress"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["anchorFrameType"] = "SCREEN",
			["icon_side"] = "RIGHT",
			["frameStrata"] = 5,
			["sparkHeight"] = 30,
			["texture"] = "ElvUI Blank",
			["sparkHidden"] = "NEVER",
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11302,
			["id"] = "Mana regen with 5s rule",
			["auto"] = true,
			["alpha"] = 1,
			["width"] = 109.820671081543,
			["xOffset"] = -197.88419342041,
			["sparkColor"] = {
				0.93725490196078, -- [1]
				1, -- [2]
				0.94509803921569, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["sparkOffsetY"] = 0,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "<",
						["variable"] = "duration",
						["value"] = "5",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "inverse",
						}, -- [1]
					},
				}, -- [1]
			},
			["stickyDuration"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0.22352941176471, -- [2]
				1, -- [3]
				0, -- [4]
			},
		},
		["Instance History Extended"] = {
			["sparkWidth"] = 15,
			["borderBackdrop"] = "Blizzard Tooltip",
			["sparkOffsetX"] = 0,
			["xOffset"] = 450.11108398438,
			["preferToUpdate"] = false,
			["customText"] = "function()\n    local now = time()\n    \n    local oldestKey, oldestTime;\n    local count = 0\n    \n    local durationStr = nil;\n    \n    local instances = {}\n    \n    for k,v in pairs(aura_env.db.History) do\n        if not (now > v.last + 3600 or v.last > now + 3600) then\n            count = count + 1;\n            \n            instances[#instances + 1] = v;\n            \n            if not oldestTime or v.last < oldestTime then\n                oldestKey = k;\n                oldestTime = v.last\n            end\n        end\n    end\n    \n    table.sort(instances, function (k1, k2) return k1.create < k2.create end)\n    \n    local durationStr = nil\n    for k,v in pairs(instances) do\n        local time = v.last - v.create;\n        local minutes = math.floor(time / 60);\n        local seconds = time % 60;\n        \n        if (durationStr ~= nil) then \n            durationStr = durationStr .. \" - \"\n        else\n            durationStr = \"\"\n        end\n        \n        durationStr = durationStr .. minutes .. \":\" .. string.format(\"%02d\", seconds)\n    end\n    \n    local rem = oldestTime and (oldestTime + 3600 - now);\n    \n    local instanceStr;\n    \n    \n    if count > 0 then\n        instanceStr = string.format(\"You have entered %d instances recently.\\n More instances will be available in %s.\", count, rem and SecondsToTime(rem) or \"n/a\");\n    end\n    \n    return instanceStr or \"\", durationStr or \"\"\nend",
			["yOffset"] = 400,
			["anchorPoint"] = "CENTER",
			["auto"] = true,
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["key"] = "debug",
					["default"] = false,
					["name"] = "Debug Mode",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [1]
				{
					["type"] = "toggle",
					["key"] = "ReportResets",
					["default"] = false,
					["name"] = "Report Resets to Chat",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [2]
				{
					["type"] = "toggle",
					["key"] = "ShowServer",
					["default"] = false,
					["name"] = "Show Server Name",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [3]
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 10,
					["step"] = 0.05,
					["width"] = 1,
					["min"] = 0.5,
					["key"] = "updateInterval",
					["default"] = 5,
					["name"] = "Display Update Interval",
				}, -- [4]
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 5,
					["step"] = 1,
					["width"] = 1,
					["min"] = 0,
					["name"] = "Display Threshold",
					["default"] = 2,
					["key"] = "displayMin",
					["desc"] = "Minimum number of instances before display appears",
				}, -- [5]
			},
			["sparkRotation"] = 0,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/bl0TwMpA9/1",
			["icon"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "stateupdate",
						["spellIds"] = {
						},
						["event"] = "Health",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["subeventSuffix"] = "_CAST_START",
						["custom"] = "function(as)\n    if aura_env.autoReset then\n        aura_env.doAutoReset();\n    end\n    \n    if GetTime() - aura_env.lastDisplayUpdate >= aura_env.config.updateInterval then\n        local s = {};\n        s.changed = true;\n        \n        local count = 0;\n        \n        for k,v in pairs(aura_env.db.History) do\n            count = count + 1; \n        end\n        \n        s.show = count >= aura_env.config.displayMin;\n        \n        s.name = \"Instance History\";\n        \n        s.progressType = \"static\";\n        s.value = 3600;\n        s.total = 3600;\n        \n        s.additionalProgress = {};\n        \n        local now = time();\n        local start = now-3600;\n        \n        local czk = aura_env.histZoneKey();\n        \n        local ordered = {};\n        \n        for k,v in pairs(aura_env.db.History) do\n            if k == czk then\n                v.last = now; \n            end\n            \n            table.insert(ordered, {k, v.create});\n        end\n        \n        table.sort(ordered, function(a,b) return a[2]<b[2] end);\n        \n        for idx,t in pairs(ordered) do\n            local k = t[1];\n            local v = aura_env.db.History[k];\n            \n            if v.last >= start then\n                \n                local o = {};\n                --o.max = math.min(3600, v.create - start);\n                --o.min = math.max(0, math.min(v.last - start, o.max-25));\n                \n                o.max = math.max(0, math.min(3600, v.last - start));\n                \n                local prev = #s.additionalProgress > 0 and s.additionalProgress[#s.additionalProgress].max or 0;\n                \n                o.min = math.max(0, math.min(3600, math.min(math.max(prev+25, v.create - start), o.max-25)));\n                \n                --print(o.max, o.min)\n                \n                table.insert(s.additionalProgress, o);\n            end\n        end\n        \n        --DevTools_Dump(s.additionalProgress)\n        \n        as[1] = s;\n        \n        aura_env.lastDisplayUpdate = GetTime();\n        \n        return true;\n    else\n        return false;\n    end\nend",
						["events"] = "",
						["check"] = "update",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["event"] = "Health",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["events"] = "CHAT_MSG_SYSTEM,INSTANCE_BOOT_START, INSTANCE_BOOT_STOP, GROUP_ROSTER_UPDATE, PLAYER_ENTERING_WORLD, ZONE_CHANGED_NEW_AREA, RAID_INSTANCE_WELCOME, PLAYER_LEAVING_WORLD, PLAYER_CAMPING, CHAT_MSG_ADDON, SEND_INSTANCE_RESET_REQUEST",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom"] = "function(event, ...)\n    if aura_env[event] then\n        aura_env[event](...) \n    end\nend",
						["custom_hide"] = "timed",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 33,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["backdropInFront"] = false,
			["sparkRotationMode"] = "AUTO",
			["barColor"] = {
				0.30588235294118, -- [1]
				0.30588235294118, -- [2]
				0.30588235294118, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["backgroundColor"] = {
				0.10196078431373, -- [1]
				0.10196078431373, -- [2]
				0.10196078431373, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "aurabar_bar",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%c1",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "BOTTOM",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.6059664785862, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["text_anchorYOffset"] = 3,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "TOP",
					["text_text_format_c1_format"] = "none",
					["text_shadowYOffset"] = 0,
					["text_fontSize"] = 9,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [2]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%c2",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "BOTTOMLEFT",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.6059664785862, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "TOPLEFT",
					["text_text_format_c2_format"] = "none",
					["text_anchorYOffset"] = -20,
					["text_fontSize"] = 11,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
				}, -- [3]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 0,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "ElvUI GlowBorder",
					["border_size"] = 1,
				}, -- [4]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_text_format_n_format"] = "none",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
			},
			["height"] = 4,
			["rotate"] = true,
			["load"] = {
				["use_never"] = false,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["selfPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "local function chatMsg(...)\n    DEFAULT_CHAT_FRAME:AddMessage(\"\\124cFFFF0000\"..(aura_env and aura_env.id or \"Instance History\")..\"\\124r: \"..string.format(...))\nend\n\nlocal function debug(...)\n    local db = WeakAurasSaved.instanceHistoryDb;\n    \n    if db.config.debug then\n        chatMsg(...)\n    end\nend\n\nlocal function deepcopy(orig)\n    local orig_type = type(orig)\n    local copy\n    if orig_type == 'table' then\n        copy = {}\n        for orig_key, orig_value in next, orig, nil do\n            copy[deepcopy(orig_key)] = deepcopy(orig_value)\n        end\n        setmetatable(copy, deepcopy(getmetatable(orig)))\n    else -- number, string, boolean, etc\n        copy = orig\n    end\n    return copy\nend\n\nlocal function pad(n)\n    local s = \"\";\n    \n    for i=1,n do\n        s = s..\"     \";\n    end\n    \n    return s;\nend\n\nlocal function dump(t, depth)\n    if DevTools_Dump then\n        DevTools_Dump(t)\n        return\n    end\n    \n    if type(t) == \"table\" then\n        if not depth then\n            depth = 1;\n            debug(\"Table dump: {\")\n        end\n        \n        if depth > 5 then return end\n        \n        for k,v in pairs(t) do\n            if type(v) == \"string\" or type(v) == \"number\" then\n                print(pad(depth)..k..\"=\"..v);\n            elseif type(v) == \"table\" then\n                print(pad(depth)..k..\"={\");\n                dump(v, depth+1);\n                print(pad(depth)..\"}\");\n            end\n        end\n        \n        print(\"}\");\n    else\n        print(t);\n    end\nend\n\nlocal db;\n\nif WeakAurasSaved.instanceHistoryDb then\n    db = WeakAurasSaved.instanceHistoryDb;\n    \n    --debug(\"loaded save data\")\n    \n    --dump(WeakAurasSaved.instanceHistoryDb)\nelse\n    WeakAurasSaved.instanceHistoryDb = WeakAurasSaved.instanceHistoryDb or {};\n    db = WeakAurasSaved.instanceHistoryDb;\nend\n\naura_env.db = db;\n\ndb.histGeneration = db.histGeneration or 1;\ndb.History = db.History or {};\ndb.Instances = db.Instances or {};\ndb.config = deepcopy(aura_env.config);\n\n-- session variables\ndb.sess = {}; -- session variables, reset em each time \n-- db.sess.delayedReset;\n-- db.sess.delayUpdate;\n-- db.sess.histLastZone;\n-- db.sess.histInGroup;\n-- db.sess.lasthistdbg;\n-- db.sess.histLiveCount;\n-- db.sess.histOldest;\n-- db.sess.enterLoc;\naura_env.lastDisplayUpdate = 0;\n\n-- constant stuff\nlocal histReapTime = 60*60 -- 1 hour\nlocal histLimit = 5 -- instances per hour\nlocal maxdiff = 33 -- max number of instance difficulties\nlocal LimitWarn = true;\nlocal prefix = \"instHistory\";\n\nlocal f = {};\n\nC_ChatInfo.RegisterAddonMessagePrefix(prefix);\nlocal thisToon = UnitName(\"player\") .. \" - \" .. GetRealmName()\n\nlocal transInstance = {\n    -- lockout hyperlink id = LFDID\n    [543] = 188,     -- Hellfire Citadel: Ramparts\n    [540] = 189,     -- Hellfire Citadel: Shattered Halls : deDE\n    [542] = 187,  -- Hellfire Citadel: Blood Furnace esES\n    [534] = 195,     -- The Battle for Mount Hyjal\n    [509] = 160,     -- Ruins of Ahn'Qiraj\n    [557] = 179,  -- Auchindoun: Mana-Tombs : ticket 72 zhTW\n    [556] = 180,  -- Auchindoun: Sethekk Halls : ticket 151 frFR\n    [568] = 340,  -- Zul'Aman: frFR\n    [1004] = 474, -- Scarlet Monastary: deDE\n    [600] = 215,  -- Drak'Tharon: ticket 105 deDE\n    [560] = 183,  -- Escape from Durnholde Keep: ticket 124 deDE\n    [531] = 161,  -- AQ temple: ticket 137 frFR\n    [1228] = 897, -- Highmaul: ticket 175 ruRU\n    [552] = 1011, -- Arcatraz: ticket 216 frFR\n    [1516] = 1190, -- Arcway: ticket 227/233 ptBR\n    [1651] = 1347, -- Return to Karazhan: ticket 237 (fake LFDID)\n    [545] = 185, -- The Steamvault: issue #143 esES\n    [1530] = 1353, -- The Nighthold: issue #186 frFR\n    [585] = 1154, -- Magisters' Terrace: issue #293 frFR\n}\n\nlocal function InGroup()\n    if IsInRaid() then return \"RAID\"\n    elseif GetNumGroupMembers() > 0 then return \"PARTY\"\n    else return nil end\nend\n\nlocal function histZoneKey()\n    local instname, insttype, diff, diffname, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()\n    \n    if insttype == nil or insttype == \"none\" or insttype == \"arena\" or insttype == \"pvp\" then -- pvp doesnt count\n        return nil\n    end\n    \n    --[[\n    if (IsInLFGDungeon() or IsInScenarioGroup()) and diff ~= 19 then -- LFG instances don't count, but Holiday Event counts\n        return nil\n    end\n]]\n    \n    -- check if we're locked (using FindInstance so we don't complain about unsaved unknown instances)\n    local truename = f.FindInstance(instname, insttype == \"raid\")\n    local locked = false\n    local inst = truename and db.Instances[truename]\n    inst = inst and inst[thisToon]\n    \n    for d=1,maxdiff do\n        if inst and inst[d] and inst[d].Locked then\n            locked = true\n        end\n    end\n    \n    if diff == 1 and maxPlayers == 5 then -- never locked to 5-man regs\n        locked = false\n    end\n    \n    local toonstr = thisToon\n    \n    if db.config.ShowServer then\n        toonstr = strsplit(\" - \", toonstr)\n    end\n    \n    local desc = toonstr .. \": \" .. instname\n    \n    if diffname and #diffname > 0 then\n        desc = desc .. \" - \" .. diffname\n    end\n    \n    local key = thisToon..\":\"..instname..\":\"..insttype..\":\"..diff\n    \n    if not locked then\n        key = key..\":\"..db.histGeneration\n    end\n    \n    return key, desc, locked\nend\n\naura_env.histZoneKey = histZoneKey;\n\nlocal function normalizeName(str)\n    return str:gsub(\"%p\",\"\"):gsub(\"%s\",\" \"):gsub(\"%s%s\",\" \"):gsub(\"^%s+\",\"\"):gsub(\"%s+$\",\"\"):upper()\nend\n\n-- some instances (like sethekk halls) are named differently by GetSavedInstanceInfo() and LFGGetDungeonInfoByID()\n-- we use the latter name to key our database, and this function to convert as needed\nf.FindInstance = function(name, raid)\n    if not name or #name == 0 then return nil end\n    \n    local nname = normalizeName(name)\n    -- first pass, direct match\n    local info = db.Instances[name]\n    \n    if info then\n        return name, info.LFDID\n    end\n    \n    -- hyperlink id lookup: must precede substring match for ticket 99\n    -- (so transInstance can override incorrect substring matches)\n    for i = 1, GetNumSavedInstances() do\n        local link = GetSavedInstanceChatLink(i) or \"\"\n        local lid,lname = link:match(\":(%d+):%d+:%d+\\124h%[(.+)%]\\124h\")\n        lname = lname and normalizeName(lname)\n        lid = lid and tonumber(lid)\n        local lfdid = lid and transInstance[lid]\n        if lname == nname and lfdid then\n            local truename = addon:UpdateInstance(lfdid)\n            if truename then\n                return truename, lfdid\n            end\n        end\n    end\n    -- normalized substring match\n    for truename, info in pairs(db.Instances) do\n        local tname = addon:normalizeName(truename)\n        if (tname:find(nname, 1, true) or nname:find(tname, 1, true)) and\n        info.Raid == raid then -- Tempest Keep: The Botanica\n            --debug(\"FindInstance(\"..name..\") => \"..truename)\n            return truename, info.LFDID\n        end\n    end\n    return nil\nend\n\nlocal function generationAdvance()\n    debug(\"HistoryUpdate generation advance\")\n    db.histGeneration = (db.histGeneration + 1) % 100000\n    db.sess.delayedReset = false\nend\n\nlocal function HistoryUpdate(forcereset, forcemesg)\n    local db = WeakAurasSaved.instanceHistoryDb;\n    db.histGeneration = db.histGeneration or 1;\n    \n    if forcereset and histZoneKey() then -- delay reset until we zone out\n        debug(\"HistoryUpdate reset delayed\")\n        db.sess.delayedReset = true\n    end\n    \n    if (forcereset or db.sess.delayedReset) and not histZoneKey() then\n        generationAdvance();\n    elseif db.lastLoc then\n        if not db.sess.enterLoc then\n            -- delay until enterLoc is defined\n            C_Timer.After(1, HistoryUpdate);\n            return;\n        end\n        \n        if db.sess.enterLoc.instance == db.lastLoc.instance and db.lastLoc.instance >= 0 and db.sess.enterLoc.subzone ~= db.lastLoc.subzone then\n            debug(\"Offline forced reset detected.\")\n            generationAdvance();\n        else\n            debug(\"Location data resolved, no reset detected.\")\n            \n            --[[if db.config.debug then\n                print(db.sess.enterLoc.instance, db.sess.enterLoc.subzone, db.lastLoc.instance, db.lastLoc.subzone)\n            end]]\n        end\n        \n        --[[if db.lastLoc then\n            debug(\"lastLoc cleared\")\n        end]]\n        \n        db.lastLoc = nil;\n    end\n    \n    local now = time()\n    \n    if db.sess.delayUpdate and now < db.sess.delayUpdate then\n        --debug(\"HistoryUpdate delayed\")\n        C_Timer.After(db.sess.delayUpdate - now + 0.05, HistoryUpdate)\n        return\n    end\n    \n    local zoningin = false\n    local newzone, newdesc, locked = histZoneKey()\n    \n    -- touch zone we left\n    if db.sess.histLastZone then\n        local lz = db.History[db.sess.histLastZone]\n        if lz then\n            lz.last = now\n        end\n    elseif newzone then\n        zoningin = true\n    end\n    \n    db.sess.histLastZone = newzone\n    db.sess.histInGroup = InGroup()\n    \n    -- touch/create new zone\n    if newzone then\n        local nz = db.History[newzone]\n        \n        if not nz then\n            nz = { create = now, desc = newdesc }\n            db.History[newzone] = nz\n            \n            if locked then -- creating a locked instance, delete unlocked version\n                db.History[newzone..\":\"..db.histGeneration] = nil\n            end\n        end\n        \n        nz.last = now\n    end\n    \n    -- reap old zones\n    local livecnt = 0\n    local oldestkey, oldesttime\n    \n    for zk, zi in pairs(db.History) do\n        if now > zi.last + histReapTime or\n        zi.last > (now + 3600) then -- temporary bug fix\n            debug(\"Reaping %s\",zi.desc)\n            db.History[zk] = nil\n        else\n            livecnt = livecnt + 1\n            \n            if not oldesttime or zi.last < oldesttime then\n                oldestkey = zk\n                oldesttime = zi.last\n            end\n        end\n    end\n    \n    local oldestrem = oldesttime and (oldesttime+histReapTime-now)\n    local oldestremt = (oldestrem and SecondsToTime(oldestrem,false,false,1)) or \"n/a\"\n    local oldestremtm = (oldestrem and SecondsToTime(math.floor((oldestrem+59)/60)*60,false,false,1)) or \"n/a\"\n    \n    if db.config.debug then\n        local msg = livecnt..\" live instances, oldest (\"..(oldestkey or \"none\")..\") expires in \"..oldestremt..\". Current Zone=\"..(newzone or \"nil\")\n        if msg ~= db.sess.lasthistdbg then\n            db.sess.lasthistdbg = msg\n            debug(msg)\n        end\n        \n        --dump(db.History)\n    end\n    -- display update\n    \n    if forcemesg or (LimitWarn and zoningin and livecnt >= histLimit-1) then\n        chatMsg(\"Warning: You've entered about %i instances recently and are approaching the %i instance per hour limit for your account. More instances should be available in %s.\",livecnt, histLimit, oldestremt)\n    end\n    \n    db.sess.histLiveCount = livecnt\n    db.sess.histOldest = oldestremt\n    \n    --[[\n    if db.Tooltip.HistoryText and livecnt > 0 then\n        addon.dataobject.text = \"(\"..livecnt..\"/\"..(oldestremt or \"?\")..\")\"\n        addon.histTextthrottle = math.min(oldestrem+1, addon.histTextthrottle or 15)\n        addon.resetDetect:SetScript(\"OnUpdate\", addon.histTextUpdate)\n    else\n        addon.dataobject.text = addonAbbrev\n        addon.resetDetect:SetScript(\"OnUpdate\", nil)\n    end\n]]\nend\n\n-- fixme localize or something\nfunction doExplicitReset(instancemsg, failed)\n    if InGroup() and not UnitIsGroupLeader(\"player\") then\n        return\n    end\n    \n    local db = WeakAurasSaved.instanceHistoryDb;\n    \n    if not failed then\n        HistoryUpdate(true)\n    end\n    \n    local reportchan = InGroup()\n    \n    if reportchan then\n        if not failed then\n            C_ChatInfo.SendAddonMessage(prefix, \"GENERATION_ADVANCE\", reportchan)\n        end\n        if db.config.ReportResets then\n            local msg = instancemsg or RESET_INSTANCES\n            msg = msg:gsub(\"\\1241.+;.+;\",\"\") -- ticket 76, remove |1;; escapes on koKR\n            SendChatMessage(\"All instances have been reset.\", reportchan)\n        end\n    end\nend\n\nhooksecurefunc(\"ResetInstances\", doExplicitReset)\n\naura_env.CHAT_MSG_SYSTEM = function(msg)\n    local raiddiffmsg = ERR_RAID_DIFFICULTY_CHANGED_S:gsub(\"%%s\",\".+\")\n    local dungdiffmsg = ERR_DUNGEON_DIFFICULTY_CHANGED_S:gsub(\"%%s\",\".+\")\n    \n    if msg == INSTANCE_SAVED then -- just got saved\n        C_Timer.After(4, HistoryUpdate)\n    elseif (msg:match(\"^\"..raiddiffmsg..\"$\") or msg:match(\"^\"..dungdiffmsg..\"$\")) and\n    not histZoneKey() then -- ignore difficulty messages when creating a party while inside an instance\n        HistoryUpdate(true)\n    elseif msg:match(TRANSFER_ABORT_TOO_MANY_INSTANCES) then\n        HistoryUpdate(false,true)\n    end\nend\n\naura_env.INSTANCE_BOOT_START = function()\n    HistoryUpdate(true)\nend\n\naura_env.INSTANCE_BOOT_STOP = function()\n    if InGroup() then\n        db.sess.delayedReset = false\n    end\nend\n\naura_env.GROUP_ROSTER_UPDATE = function()\n    if db.sess.histInGroup and not InGroup() and -- ignore failed invites when solo\n    not histZoneKey() then -- left group outside instance, resets now\n        HistoryUpdate(true)\n    end\nend\n\nlocal function zoneChanged(extraDelay)\n    -- delay updates while settings stabilize\n    local waittime = 3 + math.max(0,10 - GetFramerate()) + (extraDelay or 0)\n    local d = time() + waittime\n    \n    if d > (db.sess.delayUpdate or 0) then\n        db.sess.delayUpdate = d;\n    end\n    \n    C_Timer.After(waittime + 0.05, HistoryUpdate)\nend\n\nlocal function getLocation()\n    local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo();\n    \n    local loc;\n    \n    if instanceType == \"none\" then\n        loc = {};\n        loc.instance = -1;\n    else\n        loc = {};\n        --loc.instance = histZoneKey();\n        loc.instance = instanceID;\n        loc.subzone = GetSubZoneText();\n    end\n    \n    --[[\n    if db.config.debug then\n        dump(loc)\n    end\n]]\n    \n    return loc;\nend\n\naura_env.PLAYER_ENTERING_WORLD = function()\n    C_Timer.After(6, function()\n            db.sess.enterLoc = getLocation();\n    end)\n    \n    zoneChanged();\nend\n\naura_env.ZONE_CHANGED_NEW_AREA = function()\n    zoneChanged();\nend\n\naura_env.RAID_INSTANCE_WELCOME = function()\n    zoneChanged();\nend\n\naura_env.PLAYER_CAMPING = function()\n    db.lastLoc = getLocation();\n    --debug(\"Set lastLoc\")\n    \n    --dump(WeakAurasSaved.instanceHistoryDb)\nend\n\naura_env.CHAT_MSG_ADDON = function(pre, msg, channel, sender)\n    if pre == prefix then\n        if msg == \"GENERATION_ADVANCE\" and not UnitIsUnit(sender, \"player\") then\n            HistoryUpdate(true);\n        elseif msg == \"RESET_REQUEST\" then\n            if UnitIsGroupLeader(\"player\") then\n                chatMsg(string.format(\"Received reset request from %s. All instances will be reset once %s is offline.\", sender, sender))\n                aura_env.autoReset = string.match(sender, \"^[^%-]+\");\n            end\n        end\n    end\nend\n\naura_env.SEND_INSTANCE_RESET_REQUEST = function()\n    local channel = InGroup();\n    \n    if channel then\n        C_ChatInfo.SendAddonMessage(prefix, \"RESET_REQUEST\", reportchan);\n    end\nend\n\naura_env.doAutoReset = function()\n    if not aura_env.autoReset then\n        return;\n    end\n    \n    if not UnitIsGroupLeader(\"player\") then\n        debug(\"Player is not leader, auto reset disabled.\")\n        aura_env.autoReset = nil;\n        return;\n    end\n    \n    local name = aura_env.autoReset;\n    \n    if UnitExists(name) then\n        if not UnitIsConnected(name) then\n            C_Timer.After(1, function()\n                    ResetInstances();\n            end)\n            aura_env.autoReset = nil;\n            return;\n        end\n    else\n        debug(\"Sender does not exist, auto reset disabled.\")\n        aura_env.autoReset = nil;\n        return;\n    end\nend\n\n--[[\naura_env.PLAYER_LEAVING_WORLD = function()\n    db.lastLoc = getLocation();\n    debug(\"Set lastLoc\")\nend\n]]\n\n--DevTools_Dump(getLocation())\n\n\n--HistoryUpdate();\n\n--print(histZoneKey())\n\n\n",
					["do_custom"] = true,
				},
			},
			["stickyDuration"] = false,
			["discrete_rotation"] = 0,
			["sparkOffsetY"] = 0,
			["mirror"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["blendMode"] = "BLEND",
			["icon_side"] = "LEFT",
			["useAdjustededMax"] = false,
			["width"] = 230,
			["sparkHeight"] = 30,
			["texture"] = "Flat",
			["id"] = "Instance History Extended",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11303,
			["sparkHidden"] = "NEVER",
			["zoom"] = 0,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.0",
			["config"] = {
				["displayMin"] = 2,
				["debug"] = false,
				["updateInterval"] = 5,
				["ShowServer"] = false,
				["ReportResets"] = false,
			},
			["inverse"] = false,
			["frameStrata"] = 1,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["uid"] = "162dhv8uGuh",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["KTTotal"] = {
			["outline"] = "None",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayText"] = "%c1",
			["customText"] = "function()\n    return \"Total: |cfff27e7e\"..aura_env.kills..\"|r\"\nend",
			["yOffset"] = -3,
			["anchorPoint"] = "BOTTOM",
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/1l0r5Zkq0/3",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "aura_env.kills = 0",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Conditions",
						["use_unit"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["unit"] = "player",
						["unevent"] = "auto",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["duration"] = "1",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["events"] = "WA_KILL_TRACKER_KILL",
						["custom"] = "function(event)\n    if event ~= \"WA_KILL_TRACKER_KILL\" then\n        return\n    end\n    \n    aura_env.kills = aura_env.kills + 1\n    return true\nend",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["events"] = "WA_KILL_TRACKER_RESET",
						["custom_type"] = "event",
						["custom"] = "function(event)\n    if event ~= \"WA_KILL_TRACKER_RESET\" then\n        return\n    end\n    \n    aura_env.kills = 0\n    return true\nend",
						["dynamicDuration"] = false,
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["custom"] = "",
					},
				}, -- [3]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 33,
			["wordWrap"] = "WordWrap",
			["font"] = "Friz Quadrata TT",
			["version"] = 3,
			["subRegions"] = {
			},
			["load"] = {
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["use_never"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 13,
			["shadowXOffset"] = 1,
			["anchorFrameFrame"] = "WeakAuras:KTHeader",
			["regionType"] = "text",
			["fixedWidth"] = 200,
			["automaticWidth"] = "Auto",
			["xOffset"] = 0,
			["parent"] = "Kill Tracker",
			["authorOptions"] = {
			},
			["semver"] = "1.0.2",
			["justify"] = "LEFT",
			["tocversion"] = 11304,
			["id"] = "KTTotal",
			["config"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["uid"] = "qepIBP5I24B",
			["shadowYOffset"] = -1,
			["selfPoint"] = "TOP",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["preferToUpdate"] = false,
			["displayText_format_c1_format"] = "none",
		},
		["nanShield:Segment"] = {
			["authorOptions"] = {
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 360,
					["step"] = 1,
					["width"] = 1,
					["min"] = 1,
					["name"] = "Curve",
					["default"] = 15,
					["key"] = "curveAngle",
				}, -- [1]
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 180,
					["step"] = 1,
					["width"] = 1,
					["min"] = -180,
					["key"] = "rotationOffset",
					["default"] = 0,
					["name"] = "Rotation",
				}, -- [2]
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 100,
					["step"] = 1,
					["width"] = 1,
					["min"] = 3,
					["name"] = "Segments",
					["default"] = 20,
					["key"] = "segmentCount",
				}, -- [3]
				{
					["type"] = "select",
					["values"] = {
						"Counter Clockwise", -- [1]
						"Clockwise", -- [2]
					},
					["default"] = 1,
					["name"] = "Direction",
					["useDesc"] = false,
					["key"] = "direction",
					["width"] = 1,
				}, -- [4]
				{
					["text"] = "",
					["type"] = "header",
					["useName"] = false,
					["width"] = 1,
				}, -- [5]
				{
					["type"] = "toggle",
					["name"] = "Enable Debug Info",
					["default"] = false,
					["key"] = "debugEnabled",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [6]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/CjL90mVtb/10",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "function aura_env:rotate()\n    local segments = self.config.segmentCount\n    local angle = self.config.curveAngle\n    local direction = -(self.config.direction - 1.5) * 2\n    local base = (self.config.rotationOffset + self.config.direction * 180)\n    self.region:Rotate(base + direction * (angle / (segments - 1)) * (self.cloneId - (segments + 1) / 2))\nend\nfunction aura_env:on_tsu(allstates, ...)\n    -- self:log('TSU', self.config.segmentCount)\n    local now = GetTime()\n    local timestamp = self.timestamp or 0\n    local active = self.active or 0\n    local changed\n\n    for i = #allstates + 1, self.config.segmentCount do\n        allstates[i] = {\n            changed = true,\n            show = false,\n            school = \"All\"\n        }\n    end\n\n    if now - timestamp > 0.25 / self.config.segmentCount then\n        self.timestamp = now\n        if active < #allstates and allstates[active + 1].show then\n            for i = #allstates, active + 1, -1 do\n                if allstates[i].show then\n                    allstates[i].show = false\n                    allstates[i].changed = true\n                    changed = true\n                    break\n                end\n            end\n        else\n            for i = 1, active do\n                if not allstates[i].show then\n                    allstates[i].show = true\n                    allstates[i].changed = true\n                    changed = true\n                    break\n                end\n            end\n        end\n        for i = 1, active do\n            if allstates[i].show then\n                if allstates[i].school ~= self.segmentSchool[i] then\n                    self:log('TSUSchool', i, allstates[i].school, self.segmentSchool[i])\n                    allstates[i].school = self.segmentSchool[i]\n                    allstates[i].changed = true\n                    changed = true\n                end\n            end\n        end\n    end\n    return changed\nend\naura_env.segmentSchool = {}\n\nfunction aura_env:on_nan_shield(event, totalAbsorb, ...)\n    self:log(event, totalAbsorb, ...)\n    local currentAbsorb = 0\n    local value\n    local prevSegment = 0\n    local segment\n    self.active = 0\n\n    if event == 'OPTIONS' then\n        self.active = self.config.segmentCount or 10\n        self:log(event, self.active)\n    else\n        for i = 1, select(\"#\", ...) do\n            value = select(i, ...)\n            currentAbsorb = currentAbsorb + value\n            segment = ceil(currentAbsorb / totalAbsorb * self.config.segmentCount)\n            if value > 0 then\n                for s = prevSegment + 1, segment do\n                    self.segmentSchool[s] = self.schools[i]\n                end\n                prevSegment = segment\n            end\n        end\n\n        if currentAbsorb > 0 and totalAbsorb > 0 then\n            self.active = ceil(currentAbsorb / totalAbsorb * self.config.segmentCount)\n        end\n    end\nend\naura_env.logPalette = {\n    \"ff6e7dda\",\n    \"ff21dfb9\",\n    \"ffe3f57a\",\n    \"ffed705a\",\n    \"fff8a3e6\",\n}\n\nfunction aura_env:log(...)\n    if self.config and self.config.debugEnabled then\n        local palette = self.logPalette\n        local args = {\n            self.cloneId and\n            format(\"[%s:%s]\", self.id, self.cloneId) or\n            format(\"[%s]\", self.id),\n            ...\n        }\n        for i = 1, #args do\n            args[i] = format(\n                \"|c%s%s|r\",\n                palette[1 + (i - 1) % #palette],\n                tostring(args[i]))\n        end\n        print(unpack(args))\n    end\nend\nfunction aura_env:LowestAbsorb(totalAbsorb, all, physical, magic, ...)\n    self:log('LowestAbsorb', all, physical, magic, ...)\n    local minValue\n    local minIdx\n    local value\n\n    for i = 1, select('#', ...) do\n        value = select(i, ...)\n        if value > 0 and value <= (minValue or value) then\n            minIdx = i + 3\n            minValue = value\n        end\n    end\n\n    if minIdx then\n        minValue = minValue + magic\n    elseif magic > 0 then\n        minValue = magic\n        minIdx = 3\n    end\n\n    if physical > 0 and physical <= (minValue or physical) then\n        minValue = physical\n        minIdx = 2\n    end\n\n    if minIdx then\n        minValue = minValue + all\n    else\n        minValue = all\n        minIdx = 1\n    end\n\n    self:log('LowestAbsorbResult', minValue, totalAbsorb, minIdx)\n    return minValue, totalAbsorb, minIdx\nend\naura_env.schools = {\n    \"All\",\n    \"Physical\",\n    \"Magic\",\n    \"Holy\",\n    \"Fire\",\n    \"Nature\",\n    \"Frost\",\n    \"Shadow\",\n    \"Arcane\",\n}\naura_env.schoolIds = { 127, 1, 126, 2, 4, 8, 16, 32, 64 }\naura_env.schoolIdx = {}\nfor idx, id in ipairs(aura_env.schoolIds) do\n    aura_env.schoolIdx[id] = idx\nend\n",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "stateupdate",
						["customVariables"] = "{\n    school = {\n        type = \"select\",\n        display = \"Damage Type\",\n        values = {\n            [\"All\"] = \"All\",\n            [\"Physical\"] = \"Physical\",\n            [\"Magic\"] = \"Magic\",\n            [\"Holy\"] = \"Holy\",\n            [\"Fire\"] = \"Fire\",\n            [\"Nature\"] = \"Nature\",\n            [\"Frost\"] = \"Frost\",\n            [\"Shadow\"] = \"Shadow\",\n            [\"Arcane\"] = \"Arcane\"\n        }\n    }\n}",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["events"] = "PLAYER_ENTERING_WORLD WA_NAN_SHIELD",
						["spellIds"] = {
						},
						["check"] = "update",
						["custom"] = "function(...)\n    return aura_env:on_tsu(...)\nend",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["subeventPrefix"] = "SPELL",
						["type"] = "custom",
						["custom"] = "function(...)\n    return aura_env:on_nan_shield(...)\nend",
						["custom_type"] = "event",
						["events"] = "WA_NAN_SHIELD",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 33,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["rotation"] = 180,
			["version"] = 10,
			["subRegions"] = {
			},
			["height"] = 25,
			["rotate"] = true,
			["load"] = {
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\target_indicator_glow.tga",
			["alpha"] = 1,
			["parent"] = "nanShield",
			["semver"] = "1.3.4",
			["tocversion"] = 11302,
			["id"] = "nanShield:Segment",
			["color"] = {
				1, -- [1]
				0.7921568627451, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["width"] = 50,
			["config"] = {
				["direction"] = 1,
				["segmentCount"] = 20,
				["rotationOffset"] = 0,
				["curveAngle"] = 15,
				["debugEnabled"] = false,
			},
			["uid"] = "VWzp20EQnk3",
			["xOffset"] = 0,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								["custom"] = "aura_env:rotate()",
							},
							["property"] = "customcode",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "All",
					},
					["changes"] = {
						{
							["value"] = {
								0.94901960784314, -- [1]
								0.89411764705882, -- [2]
								0.56078431372549, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Magic",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0.50196078431373, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Physical",
					},
					["changes"] = {
						{
							["value"] = {
								0.9921568627451, -- [1]
								0.7921568627451, -- [2]
								0.63529411764706, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Arcane",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.61176470588235, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [5]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Fire",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.50196078431373, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [6]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Frost",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [7]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Holy",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [8]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Nature",
					},
					["changes"] = {
						{
							["value"] = {
								0.50196078431373, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [9]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Shadow",
					},
					["changes"] = {
						{
							["value"] = {
								0.72941176470588, -- [1]
								0.45882352941176, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [10]
			},
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["scalex"] = 2,
					["alphaType"] = "straight",
					["colorB"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "    function(progress, start, delta)\n      return start + (progress * delta)\n    end\n  ",
					["use_alpha"] = true,
					["scaleType"] = "straightScale",
					["scaleFunc"] = "    function(progress, startX, startY, scaleX, scaleY)\n      return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\n    end\n  ",
					["easeType"] = "none",
					["scaley"] = 1,
					["preset"] = "fade",
					["alpha"] = 0,
					["easeStrength"] = 3,
					["y"] = 0,
					["x"] = 0,
					["duration_type"] = "seconds",
					["use_scale"] = true,
					["type"] = "none",
					["rotate"] = 0,
					["duration"] = "0.2",
					["colorA"] = 1,
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["colorR"] = 1,
					["use_scale"] = true,
					["alphaType"] = "straight",
					["colorB"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "    function(progress, start, delta)\n      return start + (progress * delta)\n    end\n  ",
					["use_translate"] = true,
					["use_alpha"] = true,
					["duration"] = "0.2",
					["type"] = "custom",
					["duration_type"] = "seconds",
					["easeType"] = "none",
					["translateFunc"] = "    function(progress, startX, startY, deltaX, deltaY)\n      return startX + (progress * deltaX), startY + (progress * deltaY)\n    end\n  ",
					["scaley"] = 1.5,
					["alpha"] = 0,
					["easeStrength"] = 3,
					["y"] = 20,
					["x"] = 5,
					["scaleType"] = "straightScale",
					["scaleFunc"] = "    function(progress, startX, startY, scaleX, scaleY)\n      return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\n    end\n  ",
					["translateType"] = "straightTranslate",
					["rotate"] = 0,
					["scalex"] = 1.5,
					["colorA"] = 1,
				},
			},
			["discrete_rotation"] = 0,
		},
		["Loot Alert Message"] = {
			["outline"] = "OUTLINE",
			["xOffset"] = 0,
			["displayText"] = "%looter%message%item",
			["customText"] = "function()\nreturn aura_env.allPassed\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/ePZfV4FVs/6",
			["actions"] = {
				["start"] = {
					["message_type"] = "WHISPER",
					["message_format_allPassedWhisper_format"] = "none",
					["message_dest"] = "Player_responsible_for_loot",
					["message"] = "%allPassedWhisper",
					["custom"] = "",
					["do_sound"] = false,
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\bam.ogg",
					["do_custom"] = false,
					["do_message"] = false,
				},
				["init"] = {
					["custom"] = "",
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["customVariables"] = "{\n    wonLoot = \"bool\",\n    everyonePassed = \"bool\",\n}",
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["events"] = "CHAT_MSG_LOOT",
						["custom"] = "function(allstates, event, msg, _, _, _, sourceName)\n    if msg and event == \"CHAT_MSG_LOOT\" then\n        local itemId = string.match(msg, 'Hitem:(%d*):');\n        local item = select(2, GetItemInfo(itemId));\n        local received = string.match(msg, 'receive');\n        local allPassed = string.match(msg, 'Everyone passed');\n        local wonLoot = string.match(msg, 'won:');\n        local _, _, rarity = GetItemInfo(itemId);\n        -- Scan for keywords + \"receive\"\n        local msg, keyword = string.lower(msg)\n        for _, details in pairs(aura_env.config.keywords) do\n            keyword = msg:match(\"%f[%a]\"..string.lower(details.keyword)..\"%f[%A]\")\n            if received and keyword then \n                allstates[WeakAuras.GetUniqueCloneId()] = {\n                    show = true,\n                    changed = true,\n                    progressType = 'timed',\n                    expirationTime = GetTime() + aura_env.config.msgTimeKey,\n                    duration = aura_env.config.msgTimeKey,\n                    autoHide = true,\n                    rarity = rarity,\n                    looter = sourceName,\n                    message = \" received:\",\n                    icon = select(10, GetItemInfo(itemId)) or 134144,\n                    link = item,\n                }\n                return true\n            end\n        end\n        \n        -- Store who won loot\n        if wonLoot and rarity > aura_env.config.rarity - 1 and aura_env.config.showReceived == true then \n            allstates[itemId] = {\n                show = true,\n                changed = true,\n                progressType = 'timed',\n                expirationTime = GetTime() + aura_env.config.msgTimeWon,\n                duration = aura_env.config.msgTimeWon,\n                autoHide = true,\n                rarity = rarity,\n                looter = sourceName,\n                message = \" won:\",\n                icon = select(10, GetItemInfo(itemId)) or 134144,\n                link = item,\n                won = \" (Not received)\",\n                notReceived = true,\n            }\n            return true\n        end\n        \n        -- For item rarity + \"receive\"\n        if received and rarity > aura_env.config.rarity - 1 and aura_env.config.showReceived == true then \n            allstates[itemId] = {\n                show = true,\n                changed = true,\n                progressType = 'timed',\n                expirationTime = GetTime() + aura_env.config.msgTimeRec,\n                duration = aura_env.config.msgTimeRec,\n                autoHide = true,\n                rarity = rarity,\n                looter = sourceName,\n                message = \" received:\",\n                icon = select(10, GetItemInfo(itemId)) or 134144,\n                link = item,\n                won = \"\",\n            }\n            return true\n        end\n        -- For item rarity + \"everyone passed\"\n        if allPassed and rarity > aura_env.config.passedRarity - 1 and aura_env.config.showAllPass == true then\n            allstates[WeakAuras.GetUniqueCloneId()] = {\n                show = true,\n                changed = true,\n                progressType = 'timed',\n                expirationTime = GetTime() + aura_env.config.msgTimePass,\n                duration = aura_env.config.msgTimePass,\n                autoHide = true,\n                rarity = rarity,\n                looter = \"\",\n                message = \"Everyone passed on:\",\n                icon = select(10, GetItemInfo(itemId)) or 134144,\n                link = item,\n                allPassed = true,\n                allPassedWhisper = format(\"Everyone passed on: %s\", item), -- Optional message to whisper person responsible for loot.\n            }\n            return true\n        end\n    end\n    if WeakAuras.IsOptionsOpen() then \n        allstates[WeakAuras.GetUniqueCloneId()] = {\n            show = true,\n            changed = true,\n            progressType = 'static',\n            value = 1,\n            total = 1,\n            looter = \"Oron\",\n            message = \" received:\",\n            icon = 134888,\n            link = select(2, GetItemInfo(22726)),\n        }\n        return true\n    end\nend",
						["names"] = {
						},
						["check"] = "event",
						["spellIds"] = {
						},
						["custom_type"] = "stateupdate",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["useTooltip"] = true,
			["keepAspectRatio"] = false,
			["wordWrap"] = "WordWrap",
			["justify"] = "LEFT",
			["icon"] = true,
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["version"] = 6,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%looter%message ",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_looter_format"] = "none",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "OUTER_LEFT",
					["text_visible"] = false,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_message_format"] = "none",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_link_format"] = "none",
					["text_text"] = " %link%won",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_text_format_won_format"] = "none",
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "OUTER_RIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [2]
			},
			["height"] = 24,
			["selfPoint"] = "BOTTOM",
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["size"] = {
					["single"] = "fortyman",
					["multi"] = {
						["fortyman"] = true,
					},
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorMode"] = true,
			["fontSize"] = 16,
			["displayIcon"] = 134144,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "everyonePassed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								["sound_type"] = "Play",
								["sound"] = "Interface\\Addons\\Details\\sounds\\sound_whip1.ogg",
								["sound_channel"] = "Master",
							},
							["property"] = "sound",
						}, -- [1]
					},
				}, -- [1]
			},
			["shadowXOffset"] = 0,
			["automaticWidth"] = "Auto",
			["shadowYOffset"] = -1,
			["config"] = {
				["msgTimeKey"] = 10,
				["rarity"] = 0,
				["keywords"] = {
				},
				["msgTimeRec"] = 5,
				["msgTimePass"] = 15,
				["msgTimeWon"] = 0,
				["showAllPass"] = true,
				["showReceived"] = true,
				["passedRarity"] = 0,
			},
			["regionType"] = "icon",
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["use_scale"] = false,
					["colorB"] = 1,
					["colorG"] = 1,
					["use_translate"] = true,
					["colorA"] = 1,
					["scalex"] = 2,
					["type"] = "preset",
					["easeStrength"] = 3,
					["easeType"] = "none",
					["translateFunc"] = "    function(progress, startX, startY, deltaX, deltaY)\n      local prog = (progress * 3.5) % 1\n      local bounce = math.ceil(progress * 3.5)\n      local bounceDistance = math.sin(prog * math.pi) * (bounce / 4)\n    return startX + (bounceDistance * deltaX), startY + (bounceDistance * deltaY)\n  end\n  ",
					["scaley"] = 2,
					["alpha"] = 0,
					["translateType"] = "bounceDecay",
					["y"] = 0,
					["x"] = -20,
					["scaleFunc"] = "    function(progress, startX, startY, scaleX, scaleY)\n      return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\n    end\n  ",
					["scaleType"] = "straightScale",
					["preset"] = "slidetop",
					["rotate"] = 0,
					["duration_type"] = "seconds",
					["duration"] = "0.4",
				},
				["main"] = {
					["colorR"] = 1,
					["use_scale"] = false,
					["alphaType"] = "custom",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    if aura_env.state and (aura_env.state.allPassed or aura_env.state.notReceived) then\n        return start + (progress * delta)\n    end\nend",
					["duration"] = "0.5",
					["use_translate"] = false,
					["use_alpha"] = true,
					["scalex"] = 1.6,
					["type"] = "custom",
					["easeStrength"] = 1,
					["easeType"] = "none",
					["translateFunc"] = "    function(progress, startX, startY, deltaX, deltaY)\n      return startX + (progress * deltaX), startY + (progress * deltaY)\n    end\n  ",
					["preset"] = "alphaPulse",
					["alpha"] = 0.6,
					["colorB"] = 1,
					["y"] = 0,
					["x"] = 0,
					["scaleFunc"] = "    function(progress, startX, startY, scaleX, scaleY)\n      return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\n    end\n  ",
					["translateType"] = "straightTranslate",
					["scaleType"] = "straightScale",
					["rotate"] = 0,
					["scaley"] = 1,
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "    function(progress, start, delta)\n      return start + (progress * delta)\n    end\n  ",
					["use_translate"] = true,
					["use_alpha"] = true,
					["type"] = "preset",
					["easeType"] = "none",
					["translateFunc"] = "    function(progress, startX, startY, deltaX, deltaY)\n      return startX + (progress * deltaX), startY + (progress * deltaY)\n    end\n  ",
					["scaley"] = 1,
					["alpha"] = 0,
					["colorB"] = 1,
					["y"] = 0,
					["x"] = -125,
					["preset"] = "fade",
					["easeStrength"] = 3,
					["translateType"] = "straightTranslate",
					["rotate"] = 0,
					["duration_type"] = "seconds",
					["duration"] = "1.5",
				},
			},
			["width"] = 24,
			["frameStrata"] = 1,
			["preferToUpdate"] = false,
			["semver"] = "1.0.5",
			["zoom"] = 0,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11305,
			["id"] = "Loot Alert Message",
			["parent"] = "Loot Spy",
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["internalVersion"] = 33,
			["uid"] = "g5s86HjNRnO",
			["inverse"] = false,
			["authorOptions"] = {
				{
					["type"] = "description",
					["text"] = "\n\n         |cFFFFCD00Loot Spy |cFF505050by Oron\n",
					["fontSize"] = "large",
					["width"] = 2,
				}, -- [1]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["width"] = 0.2,
					["useHeight"] = false,
				}, -- [2]
				{
					["type"] = "description",
					["text"] = "\nDisplay loot alerts for items of your choosing. \nFilter by rarity, keyword and if everyone passed an item. \n\n\n|cFFFFCD00* To enable a whisper alert when \"Everyone passed\" an item, see Actions-tab > On show > Chat Message\n\n* By default, alerts for loot that everyone passed on will have a flashing animation. See Animations-tab to customize.\n\n\n",
					["fontSize"] = "medium",
					["width"] = 1.8,
				}, -- [3]
				{
					["type"] = "header",
					["useName"] = true,
					["text"] = "Settings",
					["noMerge"] = true,
					["width"] = 2,
				}, -- [4]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 2,
					["width"] = 2,
					["useHeight"] = true,
				}, -- [5]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 2,
					["width"] = 0.5,
					["useHeight"] = true,
				}, -- [6]
				{
					["type"] = "toggle",
					["key"] = "showAllPass",
					["desc"] = "Trigger a flashing message when everyone in your group passes an item.",
					["default"] = true,
					["useDesc"] = true,
					["name"] = "\"Everyone passed\"-message",
					["width"] = 1.5,
				}, -- [7]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["width"] = 0.5,
					["useHeight"] = true,
				}, -- [8]
				{
					["type"] = "toggle",
					["key"] = "showReceived",
					["desc"] = "Trigger a message when someone in your group receives an item based on item rarity threshold below.",
					["default"] = true,
					["useDesc"] = true,
					["name"] = "\"Player received\"-message",
					["width"] = 1.5,
				}, -- [9]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 3,
					["width"] = 2,
					["useHeight"] = true,
				}, -- [10]
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 20,
					["step"] = 1,
					["width"] = 2,
					["min"] = 0,
					["key"] = "msgTimePass",
					["desc"] = "How many seconds the message is displayed. Set to \"0\" to display message indefinetly.",
					["name"] = "\"Everyone passed\" display time",
					["default"] = 15,
				}, -- [11]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["width"] = 2,
					["useHeight"] = true,
				}, -- [12]
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 20,
					["step"] = 0.5,
					["width"] = 2,
					["min"] = 0,
					["key"] = "msgTimeRec",
					["desc"] = "How many seconds the message is displayed. Set to \"0\" to display message indefinetly.",
					["name"] = "\"Player received\" display time",
					["default"] = 5,
				}, -- [13]
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 20,
					["step"] = 0.5,
					["width"] = 2,
					["min"] = 0,
					["key"] = "msgTimeWon",
					["desc"] = "How many seconds the message is displayed. Set to \"0\" to display message indefinetly.",
					["name"] = "\"Player won\" display time (Before receiving)",
					["default"] = 0,
				}, -- [14]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["width"] = 2,
					["useHeight"] = true,
				}, -- [15]
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 20,
					["step"] = 0.5,
					["width"] = 2,
					["min"] = 0,
					["key"] = "msgTimeKey",
					["desc"] = "How many seconds the message is displayed. Set to \"0\" to display message indefinetly.",
					["name"] = "Keyword match display time",
					["default"] = 10,
				}, -- [16]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 3,
					["width"] = 2,
					["useHeight"] = true,
				}, -- [17]
				{
					["type"] = "header",
					["useName"] = true,
					["text"] = "Rarity threshold",
					["noMerge"] = true,
					["width"] = 1,
				}, -- [18]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["width"] = 2,
					["useHeight"] = true,
				}, -- [19]
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 5,
					["step"] = 1,
					["width"] = 0.7,
					["min"] = 0,
					["key"] = "rarity",
					["name"] = "Received item threshold",
					["default"] = 4,
				}, -- [20]
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 5,
					["step"] = 1,
					["width"] = 0.7,
					["min"] = 0,
					["key"] = "passedRarity",
					["name"] = "Passed item threshold",
					["default"] = 4,
				}, -- [21]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 2,
					["width"] = 0.1,
					["useHeight"] = false,
				}, -- [22]
				{
					["type"] = "description",
					["text"] = "|cFF9d9d9d0 = Poor\n|cFFffffff1 = Common\n|cFF1eff002 = Uncommon\n|cFF0070dd3 = Rare\n|cFFa335ee4 = Epic\n|cFFff80005 = Legendary",
					["fontSize"] = "small",
					["width"] = 0.5,
				}, -- [23]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 3,
					["width"] = 2,
					["useHeight"] = true,
				}, -- [24]
				{
					["type"] = "header",
					["useName"] = true,
					["text"] = "Scan for item keywords",
					["noMerge"] = true,
					["width"] = 1,
				}, -- [25]
				{
					["type"] = "description",
					["text"] = "|cFFFFCD00Enter item keywords here to trigger loot messages. If you have the keyword \"hourglass\" and someone loots \"Hourglass Sand\" it will bybass whatever item rarity threshold you have set above and still show an alert.\n\n",
					["fontSize"] = "small",
					["width"] = 2,
				}, -- [26]
				{
					["subOptions"] = {
						{
							["type"] = "input",
							["useDesc"] = false,
							["width"] = 1,
							["key"] = "keyword",
							["default"] = "",
							["multiline"] = false,
							["length"] = 10,
							["name"] = "Add/change keyword here",
							["useLength"] = false,
						}, -- [1]
					},
					["hideReorder"] = true,
					["useDesc"] = false,
					["nameSource"] = 1,
					["width"] = 1,
					["useCollapse"] = false,
					["collapse"] = false,
					["name"] = "Keywords",
					["key"] = "keywords",
					["limitType"] = "none",
					["groupType"] = "array",
					["type"] = "group",
					["size"] = 10,
				}, -- [27]
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.38645803928375, -- [4]
			},
			["fixedWidth"] = 256,
			["cooldown"] = false,
			["cooldownEdge"] = false,
		},
		["KTReset"] = {
			["outline"] = "None",
			["xOffset"] = 0,
			["displayText"] = "Reset",
			["yOffset"] = -10,
			["anchorPoint"] = "BOTTOM",
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/1l0r5Zkq0/3",
			["actions"] = {
				["start"] = {
					["custom"] = "aura_env.region:EnableMouse(true)\naura_env.region:SetScript('OnMouseUp', function()\n        WeakAuras.ScanEvents(\"WA_KILL_TRACKER_RESET\")\nend)",
					["do_custom"] = true,
				},
				["init"] = {
					["custom"] = "aura_env.active = false",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["use_unit"] = true,
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["spellIds"] = {
						},
						["custom"] = "function(event)\n    if event == \"WA_KILL_TRACKER_KILL\" then\n        aura_env.active = true\n    end\n    \n    if event ~= \"WA_KILL_TRACKER_RESET\" then\n        return aura_env.active\n    end\nend\n\n\n",
						["events"] = "WA_KILL_TRACKER_KILL WA_KILL_TRACKER_RESET WA_KILL_TRACKER_SHOW",
						["custom_type"] = "event",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
						["custom"] = "function(event)\n    if event == \"WA_KILL_TRACKER_RESET\" then\n        aura_env.active = false\n    end\n    \n    return not aura_env.active\nend\n\n\n",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 33,
			["selfPoint"] = "TOP",
			["font"] = "Friz Quadrata TT",
			["version"] = 3,
			["subRegions"] = {
			},
			["load"] = {
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["use_never"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 13,
			["shadowXOffset"] = 1,
			["anchorFrameFrame"] = "WeakAuras:KTList",
			["regionType"] = "text",
			["color"] = {
				0.51764705882353, -- [1]
				1, -- [2]
				0.34509803921569, -- [3]
				1, -- [4]
			},
			["automaticWidth"] = "Auto",
			["conditions"] = {
			},
			["shadowYOffset"] = -1,
			["authorOptions"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 11304,
			["id"] = "KTReset",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["config"] = {
			},
			["uid"] = "hc(vEOypJZk",
			["wordWrap"] = "WordWrap",
			["semver"] = "1.0.2",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["preferToUpdate"] = false,
			["parent"] = "Kill Tracker",
		},
		["nanShield:Value"] = {
			["outline"] = "None",
			["xOffset"] = 0,
			["displayText"] = "%p",
			["customText"] = "",
			["yOffset"] = -10,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/CjL90mVtb/10",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.active = 0\naura_env.spellSchool = {}\naura_env.currentAbsorb = {}\naura_env.maxAbsorb = {}\naura_env.totalAbsorb = 0\naura_env.schoolAbsorb = {0, 0, 0, 0, 0, 0, 0, 0, 0}\n\nlocal function improvedPowerWordShieldMultiplier()\n    -- FIXME: GetTalentInfo(1, 5)\n    return 1.15\nend\n\naura_env.talentMultiplier = {\n    [   17] = improvedPowerWordShieldMultiplier,\n    [  592] = improvedPowerWordShieldMultiplier,\n    [  600] = improvedPowerWordShieldMultiplier,\n    [ 3747] = improvedPowerWordShieldMultiplier,\n    [ 6065] = improvedPowerWordShieldMultiplier,\n    [ 6066] = improvedPowerWordShieldMultiplier,\n    [10898] = improvedPowerWordShieldMultiplier,\n    [10899] = improvedPowerWordShieldMultiplier,\n    [10900] = improvedPowerWordShieldMultiplier,\n    [10901] = improvedPowerWordShieldMultiplier,\n}\n\nfunction aura_env:CalculateAbsorbValue(spellName, spellId, absorbInfo)\n    -- FIXME: if caster != player\n    local value = 0\n    local keys = self.absorbDbKeys\n    local bonusHealing = GetSpellBonusHealing()\n    local level = UnitLevel(\"player\")\n    local base = absorbInfo[keys.basePoints]\n    local perLevel = absorbInfo[keys.pointsPerLevel]\n    local baseLevel = absorbInfo[keys.baseLevel]\n    local maxLevel = absorbInfo[keys.maxLevel]\n    local spellLevel = absorbInfo[keys.spellLevel]\n    local bonusMult = absorbInfo[keys.healingMultiplier]\n    local baseMultFn = self.talentMultiplier[spellId]\n    local levelPenalty = min(1, 1 - (20 - spellLevel) * .0375)\n    local levels = max(0, min(level, maxLevel) - baseLevel)\n    local baseMult = baseMultFn and baseMultFn() or 1\n\n    value = (\n        baseMult * (base + levels * perLevel) +\n        bonusHealing * bonusMult * levelPenalty\n    )\n\n    self:log('CalculateAbsorbValue', spellName,\n        value, base, perLevel, levels, baseMult,\n        bonusHealing, bonusMult, levelPenalty)\n\n    return value\nend\n\nfunction aura_env:GetBuffId(spellName)\n    local auraName, spellId\n    for i = 1, 255 do\n        auraName, _, _, _, _, _, _, _, _, spellId = UnitBuff(\"player\", i)\n        if auraName == spellName then\n            break\n        elseif not auraName then\n            spellId = nil\n            break\n        end\n    end\n    return spellId\nend\n\nfunction aura_env:ApplyAura(spellName)\n    local school = self.spellSchool[spellName]\n    self:log('ApplyAura', spellName, school)\n\n    if 0 ~= school then\n        local spellId = self:GetBuffId(spellName)\n        local absorbInfo = self.absorbDb[spellId]\n\n        self:log('ApplyAuraAbsorbOrNew', spellId)\n\n        if absorbInfo then\n            local value = self:CalculateAbsorbValue(\n                spellName, spellId, absorbInfo)\n\n            self:log('ApplyAuraSchool', school)\n            if nil == school then\n                school = absorbInfo[self.absorbDbKeys.school]\n                self.spellSchool[spellName] = school\n            end\n\n            if self.maxAbsorb[spellName] then\n                self:log('ApplyAuraUpdateCurrent', spellName, value)\n                self.currentAbsorb[spellName] = value\n            else\n                self:log('ApplyAuraSetCurrent', spellName, value)\n                self.active = self.active + 1\n\n                -- If damage event happened before aura was removed\n                local prevValue = self.currentAbsorb[spellName]\n                self.currentAbsorb[spellName] = value + (prevValue or 0)\n            end\n\n            self:log('ApplyAuraSetMax', spellName, value)\n            self.maxAbsorb[spellName] = value\n            self:UpdateValues()\n        end\n    end\nend\n\nfunction aura_env:RemoveAura(spellName)\n    self:log('RemoveAura', spellName)\n    if self.currentAbsorb[spellName] then\n        self.currentAbsorb[spellName] = nil\n        self.active = self.active - 1\n        self:log('RemoveAuraRemaining', self.active)\n        if self.active < 1 then\n            self.active = 0\n            wipe(self.maxAbsorb)\n        end\n        self:UpdateValues()\n    end\nend\n\nfunction aura_env:ApplyDamage(spellName, value)\n    self:log('ApplyDamage', spellName, value)\n    local newValue = (self.currentAbsorb[spellName] or 0) - value\n    if self.maxAbsorb[spellName] then\n        self.currentAbsorb[spellName] = max(0, newValue)\n        self:UpdateValues()\n    else\n        self.currentAbsorb[spellName] = newValue\n    end\nend\n\nfunction aura_env:ResetValues()\n    self:log('ResetValues')\n    local spellName\n    wipe(self.currentAbsorb)\n    wipe(self.maxAbsorb)\n    self.active = 0\n    for i = 1, 255 do\n        spellName = UnitBuff(\"player\", i)\n        if not spellName then\n            break\n        end\n        self:ApplyAura(spellName)\n    end\n    self:UpdateValues()\nend\n\nfunction aura_env:UpdateValues()\n    self:log('UpdateValues')\n    local values = self.schoolAbsorb\n    local keys = self.schoolIdx\n    local spellSchool = self.spellSchool\n    local current = self.currentAbsorb\n    local total = 0\n    local key, value, school\n\n    for i = 1, #values do\n        values[i] = 0\n    end\n\n    for spell, maxValue in pairs(self.maxAbsorb) do\n        school = spellSchool[spell]\n        key = keys[school]\n        total = total + maxValue\n        value = (current[spell] or 0)\n        values[key] = values[key] + value\n        self:log('UpdateValues', spell, school, key, maxValue, value)\n    end\n\n    self.totalAbsorb = total\n    WeakAuras.ScanEvents(\"WA_NAN_SHIELD\", total, unpack(values))\n    self:log('UpdateValues', total > 0)\nend\nfunction aura_env:on_cleu(triggerEvent, ...)\n    local event, spellName, spellId, auraName, value\n    local casterGUID = select(8, ...)\n\n    if triggerEvent == 'OPTIONS' then\n        self:log(triggerEvent, ...)\n    elseif self.playerGUID == casterGUID then\n        self:log(triggerEvent, ...)\n        event = select(2, ...)\n        if event == \"SPELL_AURA_APPLIED\" or event == \"SPELL_AURA_REFRESH\" then\n            spellName = select(13, ...)\n            self:ApplyAura(spellName)\n        elseif event == \"SPELL_AURA_REMOVED\" then\n            spellName = select(13, ...)\n            self:RemoveAura(spellName)\n        elseif event == \"SPELL_ABSORBED\" then\n            if select(20, ...) then\n                spellName = select(20, ...)\n                value = select(22, ...) or 0\n            else\n                spellName = select(17, ...)\n                value = select(19, ...) or 0\n            end\n            self:ApplyDamage(spellName, value)\n        end\n    elseif not casterGUID then\n        self:log(triggerEvent, ...)\n        self:ResetValues()\n    end\nend\naura_env.playerGUID = UnitGUID(\"player\")\naura_env.logPalette = {\n    \"ff6e7dda\",\n    \"ff21dfb9\",\n    \"ffe3f57a\",\n    \"ffed705a\",\n    \"fff8a3e6\",\n}\n\nfunction aura_env:log(...)\n    if self.config and self.config.debugEnabled then\n        local palette = self.logPalette\n        local args = {\n            self.cloneId and\n            format(\"[%s:%s]\", self.id, self.cloneId) or\n            format(\"[%s]\", self.id),\n            ...\n        }\n        for i = 1, #args do\n            args[i] = format(\n                \"|c%s%s|r\",\n                palette[1 + (i - 1) % #palette],\n                tostring(args[i]))\n        end\n        print(unpack(args))\n    end\nend\nfunction aura_env:LowestAbsorb(totalAbsorb, all, physical, magic, ...)\n    self:log('LowestAbsorb', all, physical, magic, ...)\n    local minValue\n    local minIdx\n    local value\n\n    for i = 1, select('#', ...) do\n        value = select(i, ...)\n        if value > 0 and value <= (minValue or value) then\n            minIdx = i + 3\n            minValue = value\n        end\n    end\n\n    if minIdx then\n        minValue = minValue + magic\n    elseif magic > 0 then\n        minValue = magic\n        minIdx = 3\n    end\n\n    if physical > 0 and physical <= (minValue or physical) then\n        minValue = physical\n        minIdx = 2\n    end\n\n    if minIdx then\n        minValue = minValue + all\n    else\n        minValue = all\n        minIdx = 1\n    end\n\n    self:log('LowestAbsorbResult', minValue, totalAbsorb, minIdx)\n    return minValue, totalAbsorb, minIdx\nend\naura_env.schools = {\n    \"All\",\n    \"Physical\",\n    \"Magic\",\n    \"Holy\",\n    \"Fire\",\n    \"Nature\",\n    \"Frost\",\n    \"Shadow\",\n    \"Arcane\",\n}\naura_env.schoolIds = { 127, 1, 126, 2, 4, 8, 16, 32, 64 }\naura_env.schoolIdx = {}\nfor idx, id in ipairs(aura_env.schoolIds) do\n    aura_env.schoolIdx[id] = idx\nend\n-- Generated by nan-wa-utils\naura_env.absorbDbKeys = {\n    [\"school\"] = 1,\n    [\"basePoints\"] = 2,\n    [\"pointsPerLevel\"] = 3,\n    [\"baseLevel\"] = 4,\n    [\"maxLevel\"] = 5,\n    [\"spellLevel\"] = 6,\n    [\"healingMultiplier\"] = 7,\n}\naura_env.absorbDb = {\n    [  7848] = {   1,    49,    0,  0,  0,  0, 0  }, -- Absorption\n    [ 25750] = {   1,   247,    0, 20,  0,  0, 0  }, -- Damage Absorb\n    [ 25747] = {   1,   309,    0, 20,  0,  0, 0  }, -- Damage Absorb\n    [ 25746] = {   1,   391,    0, 20,  0,  0, 0  }, -- Damage Absorb\n    [ 23991] = {   1,   494,    0, 20,  0,  0, 0  }, -- Damage Absorb\n    [ 11657] = {   1,    54,    0, 48,  0, 48, 0  }, -- Jang'thraze\n    [  7447] = {   1,    24,    0,  0,  0,  0, 0  }, -- Lesser Absorption\n    [  8373] = {   1,   999,    0,  0,  0,  0, 0  }, -- Mana Shield (PT)\n    [  7423] = {   1,     9,    0,  0,  0,  0, 0  }, -- Minor Absorption\n    [  3288] = {   1,    19,    0, 21,  0, 21, 0  }, -- Moss Hide\n    [ 21956] = {   1,   349,    0, 20,  0,  0, 0  }, -- Physical Protection\n    [  7245] = {   2,   299,    0, 20,  0,  0, 0  }, -- Holy Protection (Rank 1)\n    [ 16892] = {   2,   299,    0, 20,  0,  0, 0  }, -- Holy Protection (Rank 1)\n    [  7246] = {   2,   524,    0, 25,  0,  0, 0  }, -- Holy Protection (Rank 2)\n    [  7247] = {   2,   674,    0, 30,  0,  0, 0  }, -- Holy Protection (Rank 3)\n    [  7248] = {   2,   974,    0, 35,  0,  0, 0  }, -- Holy Protection (Rank 4)\n    [  7249] = {   2,  1349,    0, 40,  0,  0, 0  }, -- Holy Protection (Rank 5)\n    [ 17545] = {   2,  1949,    0, 40,  0,  0, 0  }, -- Holy Protection (Rank 6)\n    [ 27536] = {   2,   299,    0, 60,  0,  0, 0  }, -- Holy Resistance\n    [ 29432] = {   4,  1499,    0, 35,  0,  0, 0  }, -- Fire Protection\n    [ 17543] = {   4,  1949,    0, 35,  0,  0, 0  }, -- Fire Protection\n    [ 18942] = {   4,  1949,    0, 35,  0,  0, 0  }, -- Fire Protection\n    [  7230] = {   4,   299,    0, 20,  0,  0, 0  }, -- Fire Protection (Rank 1)\n    [ 12561] = {   4,   299,    0, 20,  0,  0, 0  }, -- Fire Protection (Rank 1)\n    [  7231] = {   4,   524,    0, 25,  0,  0, 0  }, -- Fire Protection (Rank 2)\n    [  7232] = {   4,   674,    0, 30,  0,  0, 0  }, -- Fire Protection (Rank 3)\n    [  7233] = {   4,   974,    0, 35,  0,  0, 0  }, -- Fire Protection (Rank 4)\n    [ 16894] = {   4,   974,    0, 35,  0,  0, 0  }, -- Fire Protection (Rank 4)\n    [  7234] = {   4,  1349,    0, 35,  0,  0, 0  }, -- Fire Protection (Rank 5)\n    [ 27533] = {   4,   299,    0, 60,  0,  0, 0  }, -- Fire Resistance\n    [  4057] = {   4,   499,    0,  0,  0, 25, 0  }, -- Fire Resistance\n    [ 17546] = {   8,  1949,    0, 40,  0,  0, 0  }, -- Nature Protection\n    [  7250] = {   8,   299,    0, 20,  0,  0, 0  }, -- Nature Protection (Rank 1)\n    [  7251] = {   8,   524,    0, 25,  0,  0, 0  }, -- Nature Protection (Rank 2)\n    [  7252] = {   8,   674,    0, 30,  0,  0, 0  }, -- Nature Protection (Rank 3)\n    [  7253] = {   8,   974,    0, 35,  0,  0, 0  }, -- Nature Protection (Rank 4)\n    [  7254] = {   8,  1349,    0, 40,  0,  0, 0  }, -- Nature Protection (Rank 5)\n    [ 16893] = {   8,  1349,    0, 40,  0,  0, 0  }, -- Nature Protection (Rank 5)\n    [ 27538] = {   8,   299,    0, 60,  0,  0, 0  }, -- Nature Resistance\n    [ 17544] = {  16,  1949,    0, 40,  0,  0, 0  }, -- Frost Protection\n    [  7240] = {  16,   299,    0, 20,  0,  0, 0  }, -- Frost Protection (Rank 1)\n    [  7236] = {  16,   524,    0, 25,  0,  0, 0  }, -- Frost Protection (Rank 2)\n    [  7238] = {  16,   674,    0, 30,  0,  0, 0  }, -- Frost Protection (Rank 3)\n    [  7237] = {  16,   974,    0, 35,  0,  0, 0  }, -- Frost Protection (Rank 4)\n    [  7239] = {  16,  1349,    0, 40,  0,  0, 0  }, -- Frost Protection (Rank 5)\n    [ 16895] = {  16,  1349,    0, 40,  0,  0, 0  }, -- Frost Protection (Rank 5)\n    [ 27534] = {  16,   299,    0, 60,  0,  0, 0  }, -- Frost Resistance\n    [  4077] = {  16,   599,    0,  0,  0, 25, 0  }, -- Frost Resistance\n    [ 17548] = {  32,  1949,    0, 40,  0,  0, 0  }, -- Shadow Protection\n    [  7235] = {  32,   299,    0, 20,  0,  0, 0  }, -- Shadow Protection (Rank 1)\n    [  7241] = {  32,   524,    0, 25,  0,  0, 0  }, -- Shadow Protection (Rank 2)\n    [  7242] = {  32,   674,    0, 30,  0,  0, 0  }, -- Shadow Protection (Rank 3)\n    [ 16891] = {  32,   674,    0, 30,  0,  0, 0  }, -- Shadow Protection (Rank 3)\n    [  7243] = {  32,   974,    0, 35,  0,  0, 0  }, -- Shadow Protection (Rank 4)\n    [  7244] = {  32,  1349,    0, 40,  0,  0, 0  }, -- Shadow Protection (Rank 5)\n    [ 27535] = {  32,   299,    0, 60,  0,  0, 0  }, -- Shadow Resistance\n    [  6229] = {  32,   289,    0, 32,  0, 32, 0  }, -- Shadow Ward (Rank 1)\n    [ 11739] = {  32,   469,    0, 42,  0, 42, 0  }, -- Shadow Ward (Rank 2)\n    [ 11740] = {  32,   674,    0, 52,  0, 52, 0  }, -- Shadow Ward (Rank 3)\n    [ 28610] = {  32,   919,    0, 60,  0, 60, 0  }, -- Shadow Ward (Rank 4)\n    [ 17549] = {  64,  1949,    0, 35,  0,  0, 0  }, -- Arcane Protection\n    [ 27540] = {  64,   299,    0, 60,  0,  0, 0  }, -- Arcane Resistance\n    [ 10618] = { 126,   599,    0, 30,  0,  0, 0  }, -- Elemental Protection\n    [ 20620] = { 127, 29999,    0, 20,  0, 20, 0  }, -- Aegis of Ragnaros\n    [ 23506] = { 127,   749,    0, 20,  0,  0, 0  }, -- Aura of Protection\n    [ 11445] = { 127,   277,    0, 35,  0, 35, 0  }, -- Bone Armor\n    [ 16431] = { 127,  1387,    0, 55,  0, 55, 0  }, -- Bone Armor\n    [ 27688] = { 127,  2499,    0,  0,  0,  0, 0  }, -- Bone Shield\n    [ 13234] = { 127,   499,    0,  0,  0,  0, 0  }, -- Harm Prevention Belt\n    [  9800] = { 127,   174,    0, 52,  0,  0, 0  }, -- Holy Shield\n    [ 17252] = { 127,   499,    0,  0,  0,  0, 0  }, -- Mark of the Dragon Lord\n    [ 11835] = { 127,   115,    0, 20,  0, 20, 0.1}, -- Power Word: Shield\n    [ 11974] = { 127,   136, 6.85, 20,  0, 20, 0.1}, -- Power Word: Shield\n    [ 22187] = { 127,   205, 10.2, 20,  0, 20, 0.1}, -- Power Word: Shield\n    [ 17139] = { 127,   273, 13.7, 20,  0, 20, 0.1}, -- Power Word: Shield\n    [ 11647] = { 127,   780,  3.9, 54, 59,  1, 0.1}, -- Power Word: Shield\n    [ 20697] = { 127,  4999,    0,  0,  0,  0, 0.1}, -- Power Word: Shield\n    [ 12040] = { 127,   199,   10, 20,  0, 20, 0  }, -- Shadow Shield\n    [ 22417] = { 127,   399,   20, 20,  0, 20, 0  }, -- Shadow Shield\n    [ 27759] = { 127,    49,    0,  0,  0,  0, 0  }, -- Shield Generator\n    [ 29506] = { 127,   899,    0, 20,  0,  0, 0  }, -- The Burrower's Shell\n    [ 10368] = { 127,   199,  2.3, 30, 35, 30, 0  }, -- Uther's Light Effect (Rank 1)\n    [ 28810] = { 127,   499,    0,  0,  0,  1, 0  }, -- [Priest] Armor of Faith\n    [ 27779] = { 127,   349,  2.3,  0,  0,  0, 0  }, -- [Priest] Divine Protection\n    [    17] = { 127,    43,  0.8,  6, 11,  6, 0.1}, -- [Priest] Power Word: Shield (Rank 1)\n    [ 10901] = { 127,   941,  4.3, 60, 65, 60, 0.1}, -- [Priest] Power Word: Shield (Rank 10)\n    [ 27607] = { 127,   941,  4.3, 60, 65, 60, 0.1}, -- [Priest] Power Word: Shield (Rank 10)\n    [   592] = { 127,    87,  1.2, 12, 17, 12, 0.1}, -- [Priest] Power Word: Shield (Rank 2)\n    [   600] = { 127,   157,  1.6, 18, 23, 18, 0.1}, -- [Priest] Power Word: Shield (Rank 3)\n    [  3747] = { 127,   233,    2, 24, 29, 24, 0.1}, -- [Priest] Power Word: Shield (Rank 4)\n    [  6065] = { 127,   300,  2.3, 30, 35, 30, 0.1}, -- [Priest] Power Word: Shield (Rank 5)\n    [  6066] = { 127,   380,  2.6, 36, 41, 36, 0.1}, -- [Priest] Power Word: Shield (Rank 6)\n    [ 10898] = { 127,   483,    3, 42, 47, 42, 0.1}, -- [Priest] Power Word: Shield (Rank 7)\n    [ 10899] = { 127,   604,  3.4, 48, 53, 48, 0.1}, -- [Priest] Power Word: Shield (Rank 8)\n    [ 10900] = { 127,   762,  3.9, 54, 59, 54, 0.1}, -- [Priest] Power Word: Shield (Rank 9)\n    [ 20706] = { 127,   499,    3, 42, 47, 42, 0  }, -- [Priest] Power Word: Shield 500 (Rank 7)\n    [ 17740] = {   1,   119,    6, 20,  0, 20, 0  }, -- [Mage] Mana Shield\n    [ 17741] = {   1,   119,    6, 20,  0, 20, 0  }, -- [Mage] Mana Shield\n    [  1463] = {   1,   119,    0, 20,  0, 20, 0  }, -- [Mage] Mana Shield (Rank 1)\n    [  8494] = {   1,   209,    0, 28,  0, 28, 0  }, -- [Mage] Mana Shield (Rank 2)\n    [  8495] = {   1,   299,    0, 36,  0, 36, 0  }, -- [Mage] Mana Shield (Rank 3)\n    [ 10191] = {   1,   389,    0, 44,  0, 44, 0  }, -- [Mage] Mana Shield (Rank 4)\n    [ 10192] = {   1,   479,    0, 52,  0, 52, 0  }, -- [Mage] Mana Shield (Rank 5)\n    [ 10193] = {   1,   569,    0, 60,  0, 60, 0  }, -- [Mage] Mana Shield (Rank 6)\n    [ 15041] = {   4,   119,    0, 20,  0, 20, 0  }, -- [Mage] Fire Ward\n    [   543] = {   4,   164,    0, 20,  0, 20, 0  }, -- [Mage] Fire Ward (Rank 1)\n    [  8457] = {   4,   289,    0, 30,  0, 30, 0  }, -- [Mage] Fire Ward (Rank 2)\n    [  8458] = {   4,   469,    0, 40,  0, 40, 0  }, -- [Mage] Fire Ward (Rank 3)\n    [ 10223] = {   4,   674,    0, 50,  0, 50, 0  }, -- [Mage] Fire Ward (Rank 4)\n    [ 10225] = {   4,   919,    0, 60,  0, 60, 0  }, -- [Mage] Fire Ward (Rank 5)\n    [ 15044] = {  16,   119,    0, 20,  0, 20, 0  }, -- [Mage] Frost Ward\n    [  6143] = {  16,   164,    0, 22,  0, 22, 0  }, -- [Mage] Frost Ward (Rank 1)\n    [  8461] = {  16,   289,    0, 32,  0, 32, 0  }, -- [Mage] Frost Ward (Rank 2)\n    [  8462] = {  16,   469,    0, 42,  0, 42, 0  }, -- [Mage] Frost Ward (Rank 3)\n    [ 10177] = {  16,   674,    0, 52,  0, 52, 0  }, -- [Mage] Frost Ward (Rank 4)\n    [ 28609] = {  16,   919,    0, 60,  0, 60, 0  }, -- [Mage] Frost Ward (Rank 5)\n    [ 11426] = { 127,   437,  2.8, 40, 46, 40, 0.1}, -- [Mage] Ice Barrier (Rank 1)\n    [ 13031] = { 127,   548,  3.2, 46, 52, 46, 0.1}, -- [Mage] Ice Barrier (Rank 2)\n    [ 13032] = { 127,   677,  3.6, 52, 58, 52, 0.1}, -- [Mage] Ice Barrier (Rank 3)\n    [ 13033] = { 127,   817,    4, 58, 64, 58, 0.1}, -- [Mage] Ice Barrier (Rank 4)\n    [ 26470] = { 127,     0,    0,  0,  0,  1, 0  }, -- [Mage] Persistent Shield\n    [ 17729] = { 126,   649,    0, 48,  0, 48, 0  }, -- [Warlock] Greater Spellstone\n    [ 17730] = { 126,   899,    0, 60,  0, 60, 0  }, -- [Warlock] Major Spellstone\n    [   128] = { 126,   399,    0, 36,  0, 36, 0  }, -- [Warlock] Spellstone\n    [  7812] = { 127,   304,  2.3, 16, 22, 16, 0  }, -- [Warlock] Sacrifice (Rank 1)\n    [ 19438] = { 127,   509,  3.1, 24, 30, 24, 0  }, -- [Warlock] Sacrifice (Rank 2)\n    [ 19440] = { 127,   769,  3.9, 32, 38, 32, 0  }, -- [Warlock] Sacrifice (Rank 3)\n    [ 19441] = { 127,  1094,  4.7, 40, 46, 40, 0  }, -- [Warlock] Sacrifice (Rank 4)\n    [ 19442] = { 127,  1469,  5.5, 48, 54, 48, 0  }, -- [Warlock] Sacrifice (Rank 5)\n    [ 19443] = { 127,  1904,  6.4, 56, 62, 56, 0  }, -- [Warlock] Sacrifice (Rank 6)\n}\n",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["names"] = {
						},
						["custom_hide"] = "custom",
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["use_unit"] = true,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["event"] = "Conditions",
						["customStacks"] = "",
						["customDuration"] = "",
						["customName"] = "",
						["custom"] = "function(...)\n    aura_env:on_cleu(...)\nend\n\n\n",
						["subeventPrefix"] = "SPELL",
						["check"] = "event",
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED DELAYED_PLAYER_ENTERING_WORLD",
						["custom_type"] = "status",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 33,
			["wordWrap"] = "WordWrap",
			["font"] = "Arial Narrow",
			["version"] = 10,
			["subRegions"] = {
			},
			["load"] = {
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 20,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["fixedWidth"] = 200,
			["preferToUpdate"] = false,
			["parent"] = "nanShield",
			["displayText_format_p_time_precision"] = 0,
			["automaticWidth"] = "Auto",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "BOTTOM",
			["justify"] = "CENTER",
			["tocversion"] = 11302,
			["id"] = "nanShield:Value",
			["uid"] = "gURA36O1i4T",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["displayText_format_p_time_dynamic"] = false,
			["config"] = {
				["debugEnabled"] = false,
			},
			["semver"] = "1.3.4",
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["name"] = "Enable Debug Info",
					["default"] = false,
					["key"] = "debugEnabled",
					["useDesc"] = false,
					["width"] = 2,
				}, -- [1]
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["shadowYOffset"] = -1,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
		},
		["Freeze"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["xOffset"] = 35,
			["preferToUpdate"] = false,
			["yOffset"] = -45,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/jpUN6WoYU/1",
			["icon"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "8",
						["use_spell"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["use_sourceName"] = false,
						["subeventPrefix"] = "SPELL",
						["unevent"] = "timed",
						["use_unit"] = true,
						["subeventSuffix"] = "_DAMAGE",
						["event"] = "Combat Log",
						["type"] = "event",
						["spell"] = "frost nova",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["sourceName"] = "Frost Nova",
						["spellName"] = "Frost Nova",
						["sourceUnit"] = "player",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 33,
			["useAdjustedMin"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0, -- [1]
				0.11764705882353, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["anchorFrameType"] = "SCREEN",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "aurabar_bar",
				}, -- [1]
			},
			["height"] = 20,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_class"] = true,
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkOffsetY"] = 0,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["do_custom"] = true,
					["custom"] = "\n\n",
				},
				["finish"] = {
				},
			},
			["parent"] = "Farming Tracker Spell",
			["sparkDesaturate"] = false,
			["useAdjustedMax"] = false,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["semver"] = "1.0.0",
			["uid"] = "iJ3GjV9fAPc",
			["icon_side"] = "RIGHT",
			["id"] = "Freeze",
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["alpha"] = 1,
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11304,
			["sparkHidden"] = "NEVER",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["frameStrata"] = 1,
			["width"] = 275,
			["spark"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["authorOptions"] = {
			},
		},
		["Renew"] = {
			["parent"] = "Farming Tracker Spell",
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/jpUN6WoYU/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Renew", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnCooldown",
						["names"] = {
						},
						["namePattern_operator"] = "==",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["spellName"] = 0,
						["event"] = "Cooldown Progress (Spell)",
						["use_genericShowOn"] = true,
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["namePattern_name"] = "Renew",
						["useNamePattern"] = false,
						["use_track"] = true,
						["useRem"] = false,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 33,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [1]
			},
			["height"] = 64,
			["load"] = {
				["use_class"] = true,
				["use_never"] = true,
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["xOffset"] = 140,
			["regionType"] = "icon",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["do_custom"] = true,
					["custom"] = "\n\n",
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["authorOptions"] = {
			},
			["auto"] = true,
			["uid"] = "QFEONHsX4uB",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Renew",
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["width"] = 64,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["zoom"] = 0,
			["conditions"] = {
			},
			["cooldown"] = true,
			["cooldownEdge"] = false,
		},
		["Total AoE Icon"] = {
			["outline"] = "OUTLINE",
			["color"] = {
				0.95294117647059, -- [1]
				1, -- [2]
				0.95294117647059, -- [3]
				1, -- [4]
			},
			["displayText"] = "%spellName > %dmgAmount > %count\n",
			["customText"] = "",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/5KTmxZPmA/3",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "aura_env.spells = {\n    [GetSpellInfo(10202)] = aura_env.config.AE, -- Arcane Explosion\n    [GetSpellInfo(10230)] = aura_env.config.FN, -- Frost Nova\n    [GetSpellInfo(10161)] = aura_env.config.CoC, -- Cone of Cold\n    [GetSpellInfo(13026)] = aura_env.config.BW, -- Blast Wave\n    [GetSpellInfo(10216)] = aura_env.config.Fs, -- Flamestrike\n    [GetSpellInfo(27801)] = aura_env.config.HN, -- Holy Nova\n    [GetSpellInfo(1680)] = aura_env.config.Ww, -- Whirlwind\n    [GetSpellInfo(421)] = aura_env.config.CL, -- Chain Lightning\n    [GetSpellInfo(13241)] = aura_env.config.GSC, -- Goblin Sapper Charge\n    [GetSpellInfo(23063)] = aura_env.config.DD, -- Dense Dynamite\n    [GetSpellInfo(23063)] = aura_env.config.TG, -- Thorium Grenade\n    [GetSpellInfo(17291)] = aura_env.config.SHW, -- Stratholme Holy Water\n    [GetSpellInfo(20569)] = aura_env.config.Cl, -- Cleave\n    [GetSpellInfo(17668)] = aura_env.config.RLB, -- Ramstein's Lightning Bolts\n    \n}\n\naura_env.spellsPeriodic = {\n    [GetSpellInfo(10187)] = aura_env.config.Bz, -- Blizzard\n    [GetSpellInfo(10216)] = aura_env.config.FsDoT, -- Flamestrike\n    [GetSpellInfo(11350)] = aura_env.config.OoI, -- Oil of Immolation\n    [GetSpellInfo(11678)] = aura_env.config.RoF, -- Rain of Fire\n    [GetSpellInfo(11682)] = aura_env.config.Hf, -- Hellfire (Effect)\n    [GetSpellInfo(14295)] = aura_env.config.Vl, -- Volley\n    [GetSpellInfo(17402)] = aura_env.config.Hc, -- Hurricane\n    \n}\n\naura_env.icons = {\n    [GetSpellInfo(10202)] = 136116, -- Arcane Explosion\n    [GetSpellInfo(10230)] = 135848, -- Frost Nova\n    [GetSpellInfo(10161)] = 135852, -- Cone of Cold\n    [GetSpellInfo(13026)] = 135903, -- Blast Wave\n    [GetSpellInfo(10216)] = 135826, -- Flamestrike\n    [GetSpellInfo(27801)] = 135922, -- Holy Nova\n    [GetSpellInfo(11682)] = 135818, -- Hellfire\n    [GetSpellInfo(1680)] = 132369, -- Whirlwind\n    [GetSpellInfo(421)] = 136015, -- Chain Lightning\n    [GetSpellInfo(10587)] = 135826, -- Magma Totem\n    [GetSpellInfo(11315)] = 135824, -- Fire Nova Totem\n    [GetSpellInfo(13241)] = 135826, -- Goblin Sapper Charge\n    [GetSpellInfo(23063)] = 133714, -- Dense Dynamite\n    [GetSpellInfo(19769)] = 133716, -- Thorium Grenade\n    [GetSpellInfo(17291)] = 134855, -- Stratholme Holy Water\n    [GetSpellInfo(11350)] = 135817, -- Oil of Immolation\n    [GetSpellInfo(10187)] = 135857, -- Blizzard\n    [GetSpellInfo(10216)] = 135826, -- Flamestrike\n    [GetSpellInfo(11678)] = 136186, -- Rain of Fire\n    [GetSpellInfo(14295)] = 132222, -- Volley\n    [GetSpellInfo(17402)] = 136018, -- Hurricane\n    [GetSpellInfo(20569)] = 132338, -- Cleave\n    [GetSpellInfo(17668)] = 135990, -- Ramstein's Lightning Bolts\n}",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["customVariables"] = "{\n    count = \"number\",\n    dmgAmount = \"number\",\n    spellSchool = \"number\",\n}",
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["events"] = "CLEU",
						["custom"] = "function(allstates, event, _, subEvent, _, sourceGUID, _, _, _, _, _, _, _, _, spellName, _, dmgAmount, overkill, spellSchool)\n    if subEvent == \"SPELL_DAMAGE\" and sourceGUID == UnitGUID(\"player\") and aura_env.spells[spellName] \n    or subEvent == \"SPELL_PERIODIC_DAMAGE\" and sourceGUID == UnitGUID(\"player\") and aura_env.spellsPeriodic[spellName] then\n        if not aura_env.firstHit or GetTime() - aura_env.firstHit > aura_env.config.dmgWindow then\n            aura_env.firstHit = GetTime()\n            allstates[aura_env.firstHit] = {\n                show = true,\n                changed = true,\n                progressType = 'timed',\n                expirationTime = GetTime() + aura_env.config.msgTime,\n                duration = aura_env.config.msgTime,\n                autoHide = true,\n                icon = aura_env.icons[spellName] or 132862,\n                spellName = spellName,\n                dmgAmount = dmgAmount,\n                count = 1,\n                spellSchool = spellSchool,\n            }\n            return true\n        else\n            allstates[aura_env.firstHit].count = allstates[aura_env.firstHit].count + 1\n            allstates[aura_env.firstHit].dmgAmount = allstates[aura_env.firstHit].dmgAmount + dmgAmount\n            allstates[aura_env.firstHit].changed = true\n            return true\n        end \n    end\nend",
						["names"] = {
						},
						["check"] = "event",
						["spellIds"] = {
						},
						["custom_type"] = "stateupdate",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 33,
			["keepAspectRatio"] = false,
			["wordWrap"] = "WordWrap",
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["version"] = 3,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%count",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "CENTER",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						0.96862745098039, -- [1]
						1, -- [2]
						0.93725490196078, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_text_format_count_format"] = "none",
					["text_anchorPoint"] = "CENTER",
					["text_fontType"] = "OUTLINE",
					["text_visible"] = true,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = -1,
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%dmgAmount",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "LEFT",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 8,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "OUTER_RIGHT",
					["text_text_format_dmgAmount_format"] = "none",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
				}, -- [2]
				{
					["type"] = "subborder",
					["border_offset"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "Blizzard Tooltip",
					["border_size"] = 6,
				}, -- [3]
			},
			["height"] = 28,
			["load"] = {
				["use_class"] = false,
				["use_never"] = true,
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
						["none"] = true,
						["party"] = true,
						["twenty"] = true,
						["pvp"] = true,
					},
				},
			},
			["auto"] = true,
			["fontSize"] = 16,
			["frameStrata"] = 1,
			["xOffset"] = 0,
			["authorOptions"] = {
				{
					["type"] = "description",
					["text"] = "\n\n         |cFFFFCD00Total AoE |cFF505050by Oron\n",
					["fontSize"] = "large",
					["width"] = 2,
				}, -- [1]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["width"] = 0.2,
					["useHeight"] = false,
				}, -- [2]
				{
					["type"] = "description",
					["text"] = "\nCalculate the total damage done by AoE spells/items.\n\n|cFFFFCD00* The number inside the icon represents amount of mobs\n hit by the spell.\n\n\n",
					["fontSize"] = "medium",
					["width"] = 1.8,
				}, -- [3]
				{
					["type"] = "header",
					["useName"] = true,
					["text"] = "Settings",
					["noMerge"] = false,
					["width"] = 2,
				}, -- [4]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 2,
					["width"] = 2,
					["useHeight"] = true,
				}, -- [5]
				{
					["type"] = "toggle",
					["key"] = "AE",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFF69CCF0Arcane Explosion",
					["width"] = 1,
				}, -- [6]
				{
					["type"] = "toggle",
					["key"] = "FN",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFF69CCF0Frost Nova",
					["width"] = 1,
				}, -- [7]
				{
					["type"] = "toggle",
					["key"] = "CoC",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFF69CCF0Cone of Cold",
					["width"] = 1,
				}, -- [8]
				{
					["type"] = "toggle",
					["key"] = "BW",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFF69CCF0Blast Wave",
					["width"] = 1,
				}, -- [9]
				{
					["type"] = "toggle",
					["key"] = "Fs",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFF69CCF0Flamestrike",
					["width"] = 1,
				}, -- [10]
				{
					["type"] = "toggle",
					["key"] = "FsDoT",
					["default"] = false,
					["useDesc"] = false,
					["name"] = "|cFF69CCF0Flamestrike (DoT)",
					["width"] = 1,
				}, -- [11]
				{
					["type"] = "toggle",
					["key"] = "Bz",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFF69CCF0Blizzard",
					["width"] = 1,
				}, -- [12]
				{
					["type"] = "toggle",
					["key"] = "HN",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFFFFFFFHoly Nova",
					["width"] = 1,
				}, -- [13]
				{
					["type"] = "toggle",
					["key"] = "Ww",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFC79C6EWhirlwind",
					["width"] = 1,
				}, -- [14]
				{
					["type"] = "toggle",
					["key"] = "Cl",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFC79C6ECleave",
					["width"] = 1,
				}, -- [15]
				{
					["type"] = "toggle",
					["key"] = "RoF",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFF9482C9Rain of Fire",
					["width"] = 1,
				}, -- [16]
				{
					["type"] = "toggle",
					["key"] = "Hf",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFF9482C9Hellfire",
					["width"] = 1,
				}, -- [17]
				{
					["type"] = "toggle",
					["key"] = "Hc",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFFF7D0AHurricane",
					["width"] = 1,
				}, -- [18]
				{
					["type"] = "toggle",
					["key"] = "CL",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFF0070DEChain Lightning",
					["width"] = 1,
				}, -- [19]
				{
					["type"] = "toggle",
					["key"] = "Vl",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFABD473Volley",
					["width"] = 1,
				}, -- [20]
				{
					["type"] = "toggle",
					["key"] = "DD",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFD3D3D3Dense Dynamite",
					["width"] = 1,
				}, -- [21]
				{
					["type"] = "toggle",
					["key"] = "TG",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFD3D3D3Thorium Grenade",
					["width"] = 1,
				}, -- [22]
				{
					["type"] = "toggle",
					["key"] = "SHW",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFD3D3D3Stratholme Holy Water",
					["width"] = 1,
				}, -- [23]
				{
					["type"] = "toggle",
					["key"] = "GSC",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFD3D3D3Goblin Sapper Charge",
					["width"] = 1,
				}, -- [24]
				{
					["type"] = "toggle",
					["key"] = "OoI",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFD3D3D3Oil of Immolation",
					["width"] = 1,
				}, -- [25]
				{
					["type"] = "toggle",
					["key"] = "RLB",
					["default"] = true,
					["useDesc"] = false,
					["name"] = "|cFFD3D3D3Ramstein's Lightning Bolts",
					["width"] = 1,
				}, -- [26]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 2,
					["width"] = 2,
					["useHeight"] = true,
				}, -- [27]
				{
					["softMin"] = 0,
					["type"] = "range",
					["bigStep"] = 0.5,
					["max"] = 10,
					["step"] = 0.01,
					["width"] = 2,
					["min"] = 0,
					["key"] = "msgTime",
					["desc"] = "Time (in seconds) the display will be shown before fading.",
					["softMax"] = 10,
					["useDesc"] = true,
					["name"] = "Display time",
					["default"] = 3,
				}, -- [28]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["width"] = 2,
					["useHeight"] = false,
				}, -- [29]
				{
					["softMin"] = 0.2,
					["type"] = "range",
					["bigStep"] = 0.1,
					["max"] = 10,
					["step"] = 0.01,
					["width"] = 2,
					["min"] = 0.1,
					["key"] = "dmgWindow",
					["desc"] = "Time (in seconds) for the damage recordning and calculation per spell.",
					["softMax"] = 1.5,
					["useDesc"] = true,
					["name"] = "Recording window time",
					["default"] = 0.2,
				}, -- [30]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["width"] = 2,
					["useHeight"] = false,
				}, -- [31]
			},
			["preferToUpdate"] = false,
			["fixedWidth"] = 200,
			["selfPoint"] = "BOTTOM",
			["regionType"] = "icon",
			["icon"] = true,
			["uid"] = "Fyj2Qe2APdw",
			["automaticWidth"] = "Auto",
			["width"] = 28,
			["zoom"] = 0.33,
			["semver"] = "1.0.2",
			["cooldownTextDisabled"] = false,
			["justify"] = "CENTER",
			["tocversion"] = 11305,
			["id"] = "Total AoE Icon",
			["displayIcon"] = 132996,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["parent"] = "Total AoE",
			["config"] = {
				["Cl"] = true,
				["SHW"] = true,
				["DD"] = true,
				["RoF"] = true,
				["AE"] = true,
				["GSC"] = true,
				["HN"] = true,
				["CL"] = true,
				["RLB"] = true,
				["dmgWindow"] = 0.2,
				["Vl"] = true,
				["TG"] = true,
				["Ww"] = true,
				["BW"] = true,
				["Hf"] = true,
				["OoI"] = true,
				["Bz"] = true,
				["Fs"] = true,
				["FsDoT"] = false,
				["msgTime"] = 3,
				["CoC"] = true,
				["FN"] = true,
				["Hc"] = true,
			},
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["duration"] = "0.2",
					["colorA"] = 1,
					["colorG"] = 1,
					["use_translate"] = true,
					["colorB"] = 1,
					["type"] = "custom",
					["scalex"] = 1.5,
					["easeType"] = "none",
					["translateFunc"] = "    function(progress, startX, startY, deltaX, deltaY)\n      local prog\n      if(progress < 0.25) then\n        prog = progress * 4\n      elseif(progress < .75) then\n        prog = 2 - (progress * 4)\n      else\n        prog = (progress - 1) * 4\n      end\n      return startX + (prog * deltaX), startY + (prog * deltaY)\n    end\n  ",
					["scaley"] = 1.5,
					["alpha"] = 0,
					["easeStrength"] = 3,
					["y"] = 0,
					["x"] = 15,
					["use_scale"] = true,
					["scaleType"] = "straightScale",
					["scaleFunc"] = "    function(progress, startX, startY, scaleX, scaleY)\n      return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\n    end\n  ",
					["rotate"] = 0,
					["duration_type"] = "seconds",
					["translateType"] = "shake",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "    function(progress, start, delta)\n      return start + (progress * delta)\n    end\n  ",
					["use_translate"] = true,
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "easeIn",
					["translateFunc"] = "    function(progress, startX, startY, deltaX, deltaY)\n      return startX + (progress * deltaX), startY + (progress * deltaY)\n    end\n  ",
					["scaley"] = 1,
					["alpha"] = 0,
					["colorB"] = 1,
					["y"] = 0,
					["x"] = 100,
					["preset"] = "slidebottom",
					["easeStrength"] = 3,
					["translateType"] = "straightTranslate",
					["rotate"] = 0,
					["duration_type"] = "seconds",
					["duration"] = "0.2",
				},
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = ">=",
						["variable"] = "count",
						["value"] = "3",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.7921568627451, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.1.text_color",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = ">=",
						["variable"] = "count",
						["value"] = "5",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.42745098039216, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.1.text_color",
						}, -- [1]
						{
							["value"] = 20,
							["property"] = "sub.2.text_fontSize",
						}, -- [2]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = ">=",
						["variable"] = "count",
						["value"] = "10",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.050980392156863, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.1.text_color",
						}, -- [1]
						{
							["value"] = 24,
							["property"] = "sub.2.text_fontSize",
						}, -- [2]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "spellSchool",
						["value"] = "64",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.51764705882353, -- [2]
								0.71372549019608, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "spellSchool",
						["value"] = "16",
					},
					["changes"] = {
						{
							["value"] = {
								0.36862745098039, -- [1]
								0.8078431372549, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [5]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "spellSchool",
						["value"] = "4",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.44313725490196, -- [2]
								0.14509803921569, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [6]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "spellSchool",
						["value"] = "8",
					},
					["changes"] = {
						{
							["value"] = {
								0.4078431372549, -- [1]
								0.78823529411765, -- [2]
								0.36862745098039, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [7]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "spellSchool",
						["value"] = "32",
					},
					["changes"] = {
						{
							["value"] = {
								0.69803921568628, -- [1]
								0.40392156862745, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [8]
			},
			["cooldown"] = false,
			["cooldownEdge"] = false,
		},
		["Blink"] = {
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["unevent"] = "auto",
						["names"] = {
						},
						["event"] = "Cooldown Progress (Spell)",
						["use_genericShowOn"] = true,
						["realSpellName"] = "Blink",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["spellName"] = 1953,
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 33,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [1]
			},
			["height"] = 64,
			["load"] = {
				["use_class"] = true,
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["zoom"] = 0,
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["do_custom"] = false,
					["custom"] = "print(name)\n\n\n",
				},
				["finish"] = {
				},
			},
			["parent"] = "Farming Tracker Spell",
			["semver"] = "1.0.0",
			["config"] = {
			},
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11304,
			["id"] = "Blink",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 64,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "F6xaWtTgJSy",
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["cooldown"] = true,
			["url"] = "https://wago.io/jpUN6WoYU/1",
		},
		["COC"] = {
			["xOffset"] = 70,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["unevent"] = "auto",
						["spellName"] = 120,
						["event"] = "Cooldown Progress (Spell)",
						["use_genericShowOn"] = true,
						["realSpellName"] = "Cone of Cold",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 33,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [1]
			},
			["height"] = 64,
			["load"] = {
				["use_class"] = true,
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["cooldownTextDisabled"] = false,
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["do_custom"] = true,
					["custom"] = "\n\n",
				},
				["finish"] = {
				},
			},
			["authorOptions"] = {
			},
			["parent"] = "Farming Tracker Spell",
			["auto"] = true,
			["config"] = {
			},
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "COC",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 64,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "DpMMi2Vw6ZA",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["cooldown"] = true,
			["url"] = "https://wago.io/jpUN6WoYU/1",
		},
		["Farming Tracker Spell"] = {
			["controlledChildren"] = {
				"Freeze", -- [1]
				"Frost Nova", -- [2]
				"COC", -- [3]
				"Blink", -- [4]
				"Renew", -- [5]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -36.6670728847309,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/jpUN6WoYU/1",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 33,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["use_class"] = "true",
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["scale"] = 0.6,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Farming Tracker Spell",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "LsC2(NCqen4",
			["borderInset"] = 1,
			["selfPoint"] = "BOTTOMLEFT",
			["conditions"] = {
			},
			["xOffset"] = -406.667065992944,
			["config"] = {
			},
		},
		["Total AoE"] = {
			["arcLength"] = 360,
			["controlledChildren"] = {
				"Total AoE Icon", -- [1]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["groupIcon"] = "132862",
			["gridType"] = "RU",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["rowSpace"] = 2,
			["url"] = "https://wago.io/5KTmxZPmA/3",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["unit"] = "player",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 0,
			["radius"] = 200,
			["useLimit"] = false,
			["align"] = "LEFT",
			["desc"] = "Calculate the total damage done by AoE spells/items.\n\nBy Oron",
			["stagger"] = -18,
			["version"] = 3,
			["subRegions"] = {
			},
			["load"] = {
				["use_class"] = false,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["config"] = {
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["selfPoint"] = "LEFT",
			["animate"] = true,
			["sort"] = "descending",
			["scale"] = 1,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["space"] = 10,
			["rotation"] = 0,
			["constantFactor"] = "RADIUS",
			["uid"] = "rmvzOw7o2IH",
			["borderOffset"] = 4,
			["semver"] = "1.0.2",
			["tocversion"] = 11305,
			["id"] = "Total AoE",
			["internalVersion"] = 33,
			["gridWidth"] = 2,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["borderInset"] = 1,
			["xOffset"] = 350,
			["anchorPoint"] = "CENTER",
			["conditions"] = {
			},
			["yOffset"] = 0,
			["grow"] = "VERTICAL",
		},
		["Frost Nova"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["unevent"] = "auto",
						["names"] = {
						},
						["event"] = "Cooldown Progress (Spell)",
						["use_genericShowOn"] = true,
						["realSpellName"] = "Frost Nova",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["spellName"] = 122,
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 33,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [1]
			},
			["height"] = 64,
			["load"] = {
				["use_class"] = true,
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["zoom"] = 0,
			["regionType"] = "icon",
			["url"] = "https://wago.io/jpUN6WoYU/1",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["init"] = {
					["do_custom"] = true,
					["custom"] = "-- aura_env.region:CreateBeautyBorder(6)",
				},
				["finish"] = {
				},
			},
			["xOffset"] = -70,
			["parent"] = "Farming Tracker Spell",
			["auto"] = true,
			["uid"] = "OnHejeaJcIq",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Frost Nova",
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["width"] = 64,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["cooldown"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
		},
		["KTList"] = {
			["outline"] = "None",
			["xOffset"] = 0,
			["displayText"] = "%c1",
			["customText"] = "function ()\n    return aura_env.text\nend",
			["yOffset"] = -10,
			["anchorPoint"] = "BOTTOM",
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/1l0r5Zkq0/3",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "aura_env.update = function()\n    local sorted = {}\n    for k, v in pairs(aura_env.list) do\n        table.insert(sorted,{k,v})\n    end\n    table.sort(sorted, function(a,b) return a[2] > b[2] end)\n    \n    aura_env.text = \"\"\n    for _, v in ipairs(sorted) do\n        aura_env.text = aura_env.text..v[1]..\": |cfff27e7e\"..v[2]..\"|r\\n\"\n    end\nend\n\naura_env.reset = function()\n    aura_env.list = {}\n    aura_env.text = \"\"\nend\n\naura_env.reset()\naura_env.update()",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["use_alwaystrue"] = true,
						["custom_type"] = "event",
						["debuffType"] = "HELPFUL",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["unevent"] = "auto",
						["names"] = {
						},
						["events"] = "",
						["spellIds"] = {
						},
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["duration"] = "1",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["events"] = "WA_KILL_TRACKER_KILL",
						["custom"] = "function(event, name)\n    if event ~= \"WA_KILL_TRACKER_KILL\" then\n        return\n    end\n    \n    if aura_env.list[name] then\n        aura_env.list[name] = aura_env.list[name] + 1\n    else\n        aura_env.list[name] = 1\n    end\n    \n    aura_env.update()\n    return true\nend",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["duration"] = "1",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["events"] = "WA_KILL_TRACKER_RESET",
						["custom"] = "function(event)\n    if event ~= \"WA_KILL_TRACKER_RESET\" then\n        return\n    end\n    \n    aura_env.reset()\n    aura_env.update()\n    return true\nend",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 33,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["font"] = "Friz Quadrata TT",
			["version"] = 3,
			["subRegions"] = {
			},
			["load"] = {
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["use_never"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 12,
			["shadowXOffset"] = 1,
			["anchorFrameFrame"] = "WeakAuras:KTTotal",
			["regionType"] = "text",
			["conditions"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "TOP",
			["wordWrap"] = "WordWrap",
			["authorOptions"] = {
			},
			["justify"] = "LEFT",
			["semver"] = "1.0.2",
			["tocversion"] = 11304,
			["id"] = "KTList",
			["uid"] = ")rZjI53vyNI",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["automaticWidth"] = "Auto",
			["config"] = {
			},
			["shadowYOffset"] = -1,
			["parent"] = "Kill Tracker",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["preferToUpdate"] = false,
			["displayText_format_c1_format"] = "none",
		},
		["nanShield:Bar"] = {
			["overlays"] = {
				{
					0.94901960784314, -- [1]
					0.89411764705882, -- [2]
					0.56078431372549, -- [3]
					1, -- [4]
				}, -- [1]
				{
					0.9921568627451, -- [1]
					0.7921568627451, -- [2]
					0.63529411764706, -- [3]
					1, -- [4]
				}, -- [2]
				{
					0, -- [1]
					0.50196078431373, -- [2]
					1, -- [3]
					1, -- [4]
				}, -- [3]
				{
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				}, -- [4]
				{
					1, -- [1]
					0.50196078431373, -- [2]
					0, -- [3]
					1, -- [4]
				}, -- [5]
				{
					0.50196078431373, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				}, -- [6]
				{
					0, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				}, -- [7]
			},
			["sparkOffsetX"] = 0,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/CjL90mVtb/10",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["unevent"] = "timed",
						["custom_hide"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Chat Message",
						["subeventPrefix"] = "SPELL",
						["customOverlay1"] = "",
						["spellIds"] = {
						},
						["custom"] = "function(...)\n  return aura_env:on_tsu(...)\nend",
						["events"] = "WA_NAN_SHIELD",
						["check"] = "event",
						["names"] = {
						},
						["custom_type"] = "stateupdate",
						["customVariables"] = "{\n    additionalProgress = 9,\n    school = {\n        type = \"select\",\n        display = \"Damage Type\",\n        values = {\n            [\"All\"] = \"All\",\n            [\"Physical\"] = \"Physical\",\n            [\"Magic\"] = \"Magic\",\n            [\"Holy\"] = \"Holy\",\n            [\"Fire\"] = \"Fire\",\n            [\"Nature\"] = \"Nature\",\n            [\"Frost\"] = \"Frost\",\n            [\"Shadow\"] = \"Shadow\",\n            [\"Arcane\"] = \"Arcane\"\n        }\n    }\n}",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 33,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["frameStrata"] = 1,
			["version"] = 10,
			["subRegions"] = {
				{
					["type"] = "aurabar_bar",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "FORCED SQUARE",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_CENTER",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_fontType"] = "THICKOUTLINE",
				}, -- [2]
			},
			["height"] = 20,
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["parent"] = "nanShield",
			["icon"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["sparkOffsetY"] = 0,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkHeight"] = 30,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["uid"] = "nNYjECvELIW",
			["auto"] = true,
			["icon_side"] = "RIGHT",
			["anchorFrameType"] = "SCREEN",
			["overlayclip"] = false,
			["texture"] = "Details Flat",
			["id"] = "nanShield:Bar",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["semver"] = "1.3.4",
			["tocversion"] = 11302,
			["sparkHidden"] = "NEVER",
			["spark"] = false,
			["alpha"] = 1,
			["width"] = 200,
			["zoom"] = 0,
			["config"] = {
				["debugEnabled"] = false,
				["isHealthPct"] = false,
			},
			["inverse"] = false,
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["key"] = "isHealthPct",
					["width"] = 1,
					["name"] = "Show as %HP",
					["useDesc"] = true,
					["default"] = false,
					["desc"] = "When enabled, the bar's total will be set to player's max health",
				}, -- [1]
				{
					["text"] = "",
					["useName"] = false,
					["type"] = "header",
					["width"] = 1,
				}, -- [2]
				{
					["type"] = "toggle",
					["name"] = "Enable Debug Info",
					["default"] = false,
					["key"] = "debugEnabled",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [3]
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "All",
					},
					["changes"] = {
						{
							["value"] = {
								0.94901960784314, -- [1]
								0.89411764705882, -- [2]
								0.56078431372549, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Magic",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0.50196078431373, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Physical",
					},
					["changes"] = {
						{
							["value"] = {
								0.9921568627451, -- [1]
								0.7921568627451, -- [2]
								0.63529411764706, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Arcane",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.61176470588235, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Fire",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.50196078431373, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [5]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Frost",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [6]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Holy",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [7]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Nature",
					},
					["changes"] = {
						{
							["value"] = {
								0.50196078431373, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [8]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Shadow",
					},
					["changes"] = {
						{
							["value"] = {
								0.72941176470588, -- [1]
								0.45882352941177, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.text_color",
						}, -- [1]
					},
				}, -- [9]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "function aura_env:on_tsu(allstates, event, ...)\n    self:log(event, ...)\n    local changed = false\n    local state = allstates[1] or {\n        show = true,\n        changed = true,\n        progressType = 'static',\n        value = 0,\n        total = 0,\n        stacks = 0,\n        additionalProgress = {\n            {}, {}, {},\n            {}, {}, {},\n            {}, {}, {},\n        }\n    }\n    allstates[1] = state\n\n    if event == 'WA_NAN_SHIELD' and select(1, ...) then\n        local value, school\n        local minValue, totalAbsorb, minIdx = self:LowestAbsorb(...)\n        minValue = ceil(minValue)\n        totalAbsorb = ceil(totalAbsorb)\n\n        if self.config.isHealthPct then\n            totalAbsorb = UnitHealthMax(\"player\")\n        end\n\n        changed = changed or state.total ~= totalAbsorb\n        changed = changed or state.stacks ~= minValue\n        changed = changed or state.show ~= (minValue > 0)\n        state.show = minValue > 0\n        state.total = totalAbsorb\n        state.stacks = minValue\n        state.school = self.schools[minIdx]\n\n        local progressOffset = 0\n        for i, ap in ipairs(state.additionalProgress) do\n            value = select(i + 1, ...)\n            school = self.schools[i]\n            self:log('Set', school, value)\n            changed = changed or ap.width ~= value\n            ap.min = progressOffset\n            ap.max = progressOffset + value\n            ap.school = school\n            progressOffset = progressOffset + value\n        end\n\n        allstates[1].changed = changed\n    end\n    return changed\nend\naura_env.logPalette = {\n    \"ff6e7dda\",\n    \"ff21dfb9\",\n    \"ffe3f57a\",\n    \"ffed705a\",\n    \"fff8a3e6\",\n}\n\nfunction aura_env:log(...)\n    if self.config and self.config.debugEnabled then\n        local palette = self.logPalette\n        local args = {\n            self.cloneId and\n            format(\"[%s:%s]\", self.id, self.cloneId) or\n            format(\"[%s]\", self.id),\n            ...\n        }\n        for i = 1, #args do\n            args[i] = format(\n                \"|c%s%s|r\",\n                palette[1 + (i - 1) % #palette],\n                tostring(args[i]))\n        end\n        print(unpack(args))\n    end\nend\nfunction aura_env:LowestAbsorb(totalAbsorb, all, physical, magic, ...)\n    self:log('LowestAbsorb', all, physical, magic, ...)\n    local minValue\n    local minIdx\n    local value\n\n    for i = 1, select('#', ...) do\n        value = select(i, ...)\n        if value > 0 and value <= (minValue or value) then\n            minIdx = i + 3\n            minValue = value\n        end\n    end\n\n    if minIdx then\n        minValue = minValue + magic\n    elseif magic > 0 then\n        minValue = magic\n        minIdx = 3\n    end\n\n    if physical > 0 and physical <= (minValue or physical) then\n        minValue = physical\n        minIdx = 2\n    end\n\n    if minIdx then\n        minValue = minValue + all\n    else\n        minValue = all\n        minIdx = 1\n    end\n\n    self:log('LowestAbsorbResult', minValue, totalAbsorb, minIdx)\n    return minValue, totalAbsorb, minIdx\nend\naura_env.schools = {\n    \"All\",\n    \"Physical\",\n    \"Magic\",\n    \"Holy\",\n    \"Fire\",\n    \"Nature\",\n    \"Frost\",\n    \"Shadow\",\n    \"Arcane\",\n}\naura_env.schoolIds = { 127, 1, 126, 2, 4, 8, 16, 32, 64 }\naura_env.schoolIdx = {}\nfor idx, id in ipairs(aura_env.schoolIds) do\n    aura_env.schoolIdx[id] = idx\nend\n",
					["do_custom"] = true,
				},
			},
			["sparkWidth"] = 10,
		},
		["nanShield:Text"] = {
			["outline"] = "None",
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["name"] = "Enable Debug Info",
					["default"] = false,
					["key"] = "debugEnabled",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [1]
			},
			["displayText"] = "%p",
			["yOffset"] = -80,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/CjL90mVtb/10",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "function aura_env:on_tsu(allstates, ...)\n    -- self:log('TSU', self.config.segmentCount)\n    local now = GetTime()\n    local timestamp = self.timestamp or 0\n    local currentAbsorb = self.currentAbsorb\n    local state = allstates[1]\n\n    if not state then\n        state = {\n            changed = true,\n            show = false,\n            progressType = \"static\",\n            school = \"All\",\n            value = 0,\n            total = 0,\n        }\n        allstates[1] = state\n    end\n\n    if state.show ~= (currentAbsorb > 0) then\n        state.show = currentAbsorb > 0\n        state.changed = true\n        state.value = currentAbsorb\n        state.total = self.totalAbsorb\n        state.school = self.currentSchool\n        self.timestamp = now\n    elseif state.value ~= currentAbsorb then\n        state.changed = true\n        state.value = currentAbsorb\n        state.total = self.totalAbsorb\n        state.school = self.currentSchool\n        self.timestamp = now\n    end\n\n    return state.changed\nend\nfunction aura_env:on_nan_shield(event, ...)\n    self:log(event, ...)\n    local minValue, totalAbsorb, minIdx = self:LowestAbsorb(...)\n    self.currentAbsorb = ceil(minValue)\n    self.currentSchool = self.schools[minIdx]\n    self.totalAbsorb = ceil(totalAbsorb)\n    self:log('SetValues', self.currentSchool, self.currentAbsorb, self.totalAbsorb)\nend\naura_env.logPalette = {\n    \"ff6e7dda\",\n    \"ff21dfb9\",\n    \"ffe3f57a\",\n    \"ffed705a\",\n    \"fff8a3e6\",\n}\n\nfunction aura_env:log(...)\n    if self.config and self.config.debugEnabled then\n        local palette = self.logPalette\n        local args = {\n            self.cloneId and\n            format(\"[%s:%s]\", self.id, self.cloneId) or\n            format(\"[%s]\", self.id),\n            ...\n        }\n        for i = 1, #args do\n            args[i] = format(\n                \"|c%s%s|r\",\n                palette[1 + (i - 1) % #palette],\n                tostring(args[i]))\n        end\n        print(unpack(args))\n    end\nend\nfunction aura_env:LowestAbsorb(totalAbsorb, all, physical, magic, ...)\n    self:log('LowestAbsorb', all, physical, magic, ...)\n    local minValue\n    local minIdx\n    local value\n\n    for i = 1, select('#', ...) do\n        value = select(i, ...)\n        if value > 0 and value <= (minValue or value) then\n            minIdx = i + 3\n            minValue = value\n        end\n    end\n\n    if minIdx then\n        minValue = minValue + magic\n    elseif magic > 0 then\n        minValue = magic\n        minIdx = 3\n    end\n\n    if physical > 0 and physical <= (minValue or physical) then\n        minValue = physical\n        minIdx = 2\n    end\n\n    if minIdx then\n        minValue = minValue + all\n    else\n        minValue = all\n        minIdx = 1\n    end\n\n    self:log('LowestAbsorbResult', minValue, totalAbsorb, minIdx)\n    return minValue, totalAbsorb, minIdx\nend\naura_env.schools = {\n    \"All\",\n    \"Physical\",\n    \"Magic\",\n    \"Holy\",\n    \"Fire\",\n    \"Nature\",\n    \"Frost\",\n    \"Shadow\",\n    \"Arcane\",\n}\naura_env.schoolIds = { 127, 1, 126, 2, 4, 8, 16, 32, 64 }\naura_env.schoolIdx = {}\nfor idx, id in ipairs(aura_env.schoolIds) do\n    aura_env.schoolIdx[id] = idx\nend\n",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "stateupdate",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["spellIds"] = {
						},
						["custom"] = "function(...)\n    return aura_env:on_tsu(...)\nend",
						["subeventSuffix"] = "_CAST_START",
						["check"] = "update",
						["unit"] = "player",
						["names"] = {
						},
						["customVariables"] = "{\n    school = {\n        type = \"select\",\n        display = \"Damage Type\",\n        values = {\n            [\"All\"] = \"All\",\n            [\"Physical\"] = \"Physical\",\n            [\"Magic\"] = \"Magic\",\n            [\"Holy\"] = \"Holy\",\n            [\"Fire\"] = \"Fire\",\n            [\"Nature\"] = \"Nature\",\n            [\"Frost\"] = \"Frost\",\n            [\"Shadow\"] = \"Shadow\",\n            [\"Arcane\"] = \"Arcane\"\n        }\n    }\n}",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["subeventPrefix"] = "SPELL",
						["type"] = "custom",
						["custom"] = "function(...)\n    return aura_env:on_nan_shield(...)\nend",
						["subeventSuffix"] = "_CAST_START",
						["events"] = "WA_NAN_SHIELD",
						["custom_type"] = "event",
						["event"] = "Health",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 33,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["font"] = "Arial Narrow",
			["version"] = 10,
			["subRegions"] = {
			},
			["load"] = {
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 20,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["fixedWidth"] = 200,
			["preferToUpdate"] = false,
			["parent"] = "nanShield",
			["displayText_format_p_time_precision"] = 0,
			["wordWrap"] = "WordWrap",
			["shadowYOffset"] = -1,
			["displayText_format_p_time_dynamic"] = false,
			["semver"] = "1.3.4",
			["tocversion"] = 11302,
			["id"] = "nanShield:Text",
			["uid"] = "pGdpCt6LJm)",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = -10,
			["config"] = {
				["debugEnabled"] = false,
			},
			["justify"] = "CENTER",
			["selfPoint"] = "BOTTOM",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "All",
					},
					["changes"] = {
						{
							["value"] = {
								0.94901960784314, -- [1]
								0.89411764705882, -- [2]
								0.56078431372549, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Magic",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0.50196078431373, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Physical",
					},
					["changes"] = {
						{
							["value"] = {
								0.9921568627451, -- [1]
								0.7921568627451, -- [2]
								0.63529411764706, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Arcane",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.61176470588235, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Fire",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.50196078431373, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [5]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Frost",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [6]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Holy",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [7]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Nature",
					},
					["changes"] = {
						{
							["value"] = {
								0.50196078431373, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [8]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Shadow",
					},
					["changes"] = {
						{
							["value"] = {
								0.72941176470588, -- [1]
								0.45882352941176, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [9]
			},
			["automaticWidth"] = "Auto",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
	},
	["dbVersion"] = 33,
	["lastArchiveClear"] = 1601569666,
	["minimap"] = {
		["minimapPos"] = 34.3920514550927,
		["hide"] = true,
	},
	["lastUpgrade"] = 1601569669,
	["personalRessourceDisplayFrame"] = {
		["xOffset"] = -1205.50048262996,
		["yOffset"] = -530.626020175352,
	},
	["registered"] = {
	},
	["editor_bracket_matching"] = false,
	["login_squelch_time"] = 10,
	["frame"] = {
		["xOffset"] = -1322.37756347656,
		["yOffset"] = -69.3248291015625,
		["height"] = 961.4423828125,
		["width"] = 913.649963378906,
	},
	["instanceHistoryDb"] = {
		["sess"] = {
		},
		["History"] = {
			["Augustin - Golemagg:Zul'Farrak:party:1:4"] = {
				["last"] = 1602529325,
				["create"] = 1602516995,
				["desc"] = "Augustin - Golemagg: Zul'Farrak - Normal",
			},
		},
		["HistoryDay"] = {
			["Augustin - Golemagg:Zul'Farrak:party:1:4"] = {
				["last"] = 1602529325,
				["create"] = 1602516995,
				["desc"] = "Augustin - Golemagg: Zul'Farrak - Normal",
			},
		},
		["histGeneration"] = 4,
		["config"] = {
			["displayMin"] = 2,
			["debug"] = false,
			["updateInterval"] = 5,
			["ShowServer"] = false,
			["ReportResets"] = false,
		},
		["Instances"] = {
		},
	},
	["editor_theme"] = "Monokai",
}
