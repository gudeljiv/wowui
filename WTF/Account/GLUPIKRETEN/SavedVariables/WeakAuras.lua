
WeakAurasSaved = {
	["dynamicIconCache"] = {
	},
	["displays"] = {
		["XpSession_XpPerHour"] = {
			["outline"] = "None",
			["authorOptions"] = {
			},
			["displayText"] = "%c",
			["customText"] = "function()\n    WA_XPPERHOUR_MAXXP = WA_XPPERHOUR_MAXXP or UnitXPMax(\"player\")\n    WA_XPPERHOUR_XP = WA_XPPERHOUR_XP or UnitXP(\"player\")\n    WA_XPPERHOUR_TIME = WA_XPPERHOUR_TIME or time() - 1\n    local Time = time() - WA_XPPERHOUR_TIME \n    \n    if WA_XPPERHOUR_MAXXP < UnitXPMax(\"player\") then\n        WA_XPPERHOUR_XP = WA_XPPERHOUR_XP - WA_XPPERHOUR_MAXXP\n        WA_XPPERHOUR_MAXXP = UnitXPMax(\"player\")\n    end\n    \n    local XP = UnitXP(\"player\") - WA_XPPERHOUR_XP\n    \n    local XpPerHour = math.floor(3600 * XP / Time)\n    \n    local TimeElapsed = math.floor(Time / 60)\n    local UntilDing = (WA_XPPERHOUR_MAXXP-UnitXP(\"player\"))/(60*XP/Time)\n    \n    if(UntilDing) then UntilDing = 0 end\n    \n    return string.format(\n        \"|cffb76b45XP/hr|r: %sk |cffffff00Ding:|r %smin |cffffff00Time:|r %smin\"\n        ,floor(XpPerHour/100)/10, math.floor(UntilDing), TimeElapsed\n    )\nend    \n\n",
			["yOffset"] = 0,
			["anchorPoint"] = "BOTTOMLEFT",
			["customTextUpdate"] = "update",
			["automaticWidth"] = "Auto",
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
						["type"] = "status",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["event"] = "Conditions",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["duration"] = "1",
						["use_unit"] = true,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 37,
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
			["font"] = "Friz Quadrata TT",
			["version"] = 1,
			["load"] = {
				["use_level"] = true,
				["use_never"] = true,
				["level_operator"] = "<",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["level"] = "60",
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 12,
			["shadowXOffset"] = 1,
			["anchorFrameFrame"] = "ChatFrame3",
			["regionType"] = "text",
			["preferToUpdate"] = false,
			["shadowYOffset"] = -1,
			["ignoreOptionsEventErrors"] = true,
			["conditions"] = {
			},
			["semver"] = "1.0.0",
			["justify"] = "RIGHT",
			["tocversion"] = 11302,
			["id"] = "XpSession_XpPerHour",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["config"] = {
			},
			["uid"] = "7bgNy747Jmx",
			["selfPoint"] = "BOTTOMRIGHT",
			["url"] = "https://wago.io/RK7ZxVkep/1",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["xOffset"] = -30,
			["wordWrap"] = "WordWrap",
		},
		["Instance Lock (24h)"] = {
			["sparkWidth"] = 15,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 5,
			["anchorPoint"] = "TOP",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/ynSYGaSVC/6",
			["icon"] = false,
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "BOTTOM",
			["barColor"] = {
				0.4, -- [1]
				0.4, -- [2]
				0.4, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["sparkOffsetY"] = 0,
			["load"] = {
				["use_zone"] = false,
				["use_never"] = false,
				["use_itemequiped"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["single"] = "none",
					["multi"] = {
					},
				},
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["blendMode"] = "BLEND",
			["texture"] = "Glamour2",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11305,
			["alpha"] = 1,
			["config"] = {
				["displayMin"] = 0,
				["debug"] = false,
				["updateInterval"] = 5,
				["ShowServer"] = false,
				["ReportResets"] = false,
				["showTimeSpent"] = false,
			},
			["sparkOffsetX"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["customText"] = "function()\n    local now = time()\n    \n    local oldestKey, oldestTime;\n    local oldestKeyDay, oldestTimeDay;\n    local count = 0;\n    local thisToon = UnitName(\"player\") .. \"%s%p%s\" .. GetRealmName();\n    \n    local instances = {}\n    \n    for k,v in pairs(aura_env.db.History) do\n        if not (now > v.last + 3600 or v.last > now + 3600) then\n            instances[count] = v;\n            count = count + 1;\n            \n            if not oldestTime or v.last < oldestTime then\n                oldestKey = k;\n                oldestTime = v.last;\n            end\n        end\n    end\n    \n    local dayCount = 0;\n    for k,v in pairs(aura_env.db.HistoryDay) do\n        if string.match(k, thisToon) then\n            if not (now > v.last + 86400 or v.last > now + 86400) then\n                dayCount = dayCount + 1;\n                \n                if not oldestTimeDay or v.last < oldestTimeDay then\n                    oldestKeyDay = k;\n                    oldestTimeDay = v.last;\n                end\n            end\n        end\n    end\n    \n    \n    local remDay = oldestTimeDay and (oldestTimeDay + 86400 - now);\n    \n    local instanceStr = \"\"\n    local needLineBreak = false;\n    local timeSpentStr = \"\"\n    \n    if count >= aura_env.config.displayMin then\n        local rem = oldestTime and (oldestTime + 3600 - now);\n        instanceStr = string.format(\"Hourly: %d/5; More in %s.\", count, rem and SecondsToTime(rem) or \"n/a\");\n        needLineBreak = true;\n        \n        -- Time spent in instance\n        if aura_env.config.showTimeSpent then\n            table.sort(instances, function (i1, i2) return i1.create < i2.create end)\n            for k,v in pairs(instances) do\n                if timeSpentStr ~= \"\" then\n                    timeSpentStr = timeSpentStr .. \" / \";\n                end\n                \n                local timeSpent = v.last - v.create;\n                local minutes = math.floor(timeSpent / 60);\n                local seconds = timeSpent - minutes * 60;\n                timeSpentStr = timeSpentStr .. string.format(\"%02d:%02d\", minutes, seconds);\n            end\n        end\n    end\n    if dayCount >= aura_env.config.displayMin then\n        if needLineBreak then\n            instanceStr = instanceStr .. \"\\n\";\n        end\n        \n         -- instanceStr = instanceStr .. string.format(\"Daily (%s): %d/30; More in %s\", UnitName(\"player\"), dayCount, remDay and SecondsToTime(remDay) or \"n/a\");\n         instanceStr = instanceStr .. string.format(\"Daily: %d/30; More in %s\", dayCount, remDay and SecondsToTime(remDay) or \"n/a\");\n    end    \n    \n    return instanceStr, timeSpentStr;\nend",
			["customTextUpdate"] = "update",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "stateupdate",
						["custom_hide"] = "timed",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["custom"] = "function(as)\n    local now = time()\n    \n    if aura_env.autoReset then\n        aura_env.doAutoReset();\n    end\n    \n    if GetTime() - aura_env.lastDisplayUpdate >= aura_env.config.updateInterval then\n        local thisToon = UnitName(\"player\") .. \"%s%p%s\" .. GetRealmName();\n        local s = {};\n        s.changed = true;\n        \n        local count = 0;\n        \n        for k,v in pairs(aura_env.db.History) do\n            if not (now > v.last + 3600 or v.last > now + 3600) then\n                count = count + 1; \n            end\n        end\n        \n        s.name = \"Instance History\";\n        \n        s.progressType = \"static\";\n        \n        s.additionalProgress = {};\n        local now = time();\n        \n        local czk = aura_env.histZoneKey();\n        \n        local ordered = {};\n        \n        local dayCount = 0;\n        for k,v in pairs(aura_env.db.HistoryDay) do\n            if string.match(k, thisToon) then\n                if not (now > v.last + 86400 or v.last > now + 86400) then\n                    dayCount = dayCount + 1;\n                end\n            end\n        end\n        \n        s.show = count >= aura_env.config.displayMin or dayCount >= aura_env.config.displayMin;\n        \n        if count > 0 then\n            s.value = 3600;\n            s.total = 3600;\n            local start = now-3600;\n            \n            for k,v in pairs(aura_env.db.History) do\n                if k == czk then\n                    v.last = now; \n                end\n                table.insert(ordered, {k, v.create});\n            end\n            \n            table.sort(ordered, function(a,b) return a[2]<b[2] end);\n            \n            for idx,t in pairs(ordered) do\n                local k = t[1];\n                local v = aura_env.db.History[k];\n                \n                if v.last >= start then\n                    \n                    local o = {};\n                    --o.max = math.min(3600, v.create - start);\n                    --o.min = math.max(0, math.min(v.last - start, o.max-25));\n                    \n                    o.max = math.max(0, math.min(3600, v.last - start));\n                    \n                    local prev = #s.additionalProgress > 0 and s.additionalProgress[#s.additionalProgress].max or 0;\n                    \n                    o.min = math.max(0, math.min(3600, math.min(math.max(prev+25, v.create - start), o.max-25)));\n                    \n                    --print(o.max, o.min)\n                    table.insert(s.additionalProgress, o);\n                end\n            end\n        elseif dayCount > 0 then\n            s.value = 86400;\n            s.total = 86400;\n            local start = now-86400;\n            \n            for k,v in pairs(aura_env.db.HistoryDay) do\n                if string.match(k, thisToon) then\n                    if k == czk then\n                        v.last = now; \n                    end\n                    table.insert(ordered, {k, v.create});\n                end\n            end\n            \n            table.sort(ordered, function(a,b) return a[2]<b[2] end);\n            \n            for idx,t in pairs(ordered) do\n                local k = t[1];\n                local v = aura_env.db.HistoryDay[k];\n                \n                if v.last >= start then\n                    \n                    local o = {};\n                    --o.max = math.min(86400, v.create - start);\n                    --o.min = math.max(0, math.min(v.last - start, o.max-25));\n                    \n                    o.max = math.max(0, math.min(86400, v.last - start));\n                    \n                    local prev = #s.additionalProgress > 0 and s.additionalProgress[#s.additionalProgress].max or 0;\n                    \n                    o.min = math.max(0, math.min(86400, math.min(math.max(prev+25, v.create - start), o.max-25)));\n                    \n                    --print(o.max, o.min)\n                    table.insert(s.additionalProgress, o);\n                end\n            end\n        end\n        \n        \n        --DevTools_Dump(s.additionalProgress)\n        \n        as[1] = s;\n        \n        aura_env.lastDisplayUpdate = GetTime();\n        return true;\n    else\n        return false;\n    end\nend",
						["subeventPrefix"] = "SPELL",
						["check"] = "update",
						["events"] = "",
						["names"] = {
						},
						["customVariables"] = "\n\n",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["custom_hide"] = "timed",
						["custom"] = "function(event, ...)\n    if aura_env[event] then\n        aura_env[event](...) \n    end\nend",
						["events"] = "CHAT_MSG_SYSTEM,INSTANCE_BOOT_START, INSTANCE_BOOT_STOP, GROUP_ROSTER_UPDATE, PLAYER_ENTERING_WORLD, ZONE_CHANGED_NEW_AREA, RAID_INSTANCE_WELCOME, PLAYER_LEAVING_WORLD, PLAYER_CAMPING, CHAT_MSG_ADDON, SEND_INSTANCE_RESET_REQUEST",
						["unit"] = "player",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 37,
			["useAdjustedMin"] = false,
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
			["backdropInFront"] = false,
			["stickyDuration"] = false,
			["discrete_rotation"] = 0,
			["version"] = 6,
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
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "TOP",
					["text_visible"] = true,
					["text_anchorYOffset"] = 3,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_c1_format"] = "none",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c2",
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
					["text_shadowYOffset"] = -1,
					["text_text_format_c2_format"] = "none",
					["text_visible"] = true,
					["text_anchorPoint"] = "BOTTOM",
					["text_fontType"] = "None",
					["text_wordWrap"] = "WordWrap",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = -15,
				}, -- [3]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_size"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "ElvUI GlowBorder",
					["border_offset"] = 0,
				}, -- [4]
			},
			["height"] = 8,
			["rotate"] = true,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["useAdjustedMax"] = false,
			["mirror"] = false,
			["anchorFrameFrame"] = "KillCountFrame",
			["borderInFront"] = true,
			["auto"] = true,
			["icon_side"] = "LEFT",
			["zoom"] = 0,
			["borderBackdrop"] = "Blizzard Tooltip",
			["sparkHeight"] = 30,
			["ignoreOptionsEventErrors"] = true,
			["backgroundColor"] = {
				0.101960784313725, -- [1]
				0.101960784313725, -- [2]
				0.101960784313725, -- [3]
				0.691175431013107, -- [4]
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["semver"] = "1.0.5",
			["id"] = "Instance Lock (24h)",
			["sparkHidden"] = "NEVER",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "-- Do not remove this comment, it is part of this trigger: Instance History\nlocal function chatMsg(...)\n    DEFAULT_CHAT_FRAME:AddMessage(\"\\124cFFFF0000\"..(aura_env and aura_env.id or \"Instance History\")..\"\\124r: \"..string.format(...))\nend\n\nlocal function debug(...)\n    local db = WeakAurasSaved.instanceHistoryDb;\n    \n    if db.config.debug then\n        chatMsg(...)\n    end\nend\n\nlocal function deepcopy(orig)\n    local orig_type = type(orig)\n    local copy\n    if orig_type == 'table' then\n        copy = {}\n        for orig_key, orig_value in next, orig, nil do\n            copy[deepcopy(orig_key)] = deepcopy(orig_value)\n        end\n        setmetatable(copy, deepcopy(getmetatable(orig)))\n    else -- number, string, boolean, etc\n        copy = orig\n    end\n    return copy\nend\n\nlocal function pad(n)\n    local s = \"\";\n    \n    for i=1,n do\n        s = s..\"     \";\n    end\n    \n    return s;\nend\n\nlocal function dump(t, depth)\n    if DevTools_Dump then\n        DevTools_Dump(t)\n        return\n    end\n    \n    if type(t) == \"table\" then\n        if not depth then\n            depth = 1;\n            debug(\"Table dump: {\")\n        end\n        \n        if depth > 5 then return end\n        \n        for k,v in pairs(t) do\n            if type(v) == \"string\" or type(v) == \"number\" then\n                print(pad(depth)..k..\"=\"..v);\n            elseif type(v) == \"table\" then\n                print(pad(depth)..k..\"={\");\n                dump(v, depth+1);\n                print(pad(depth)..\"}\");\n            end\n        end\n        \n        print(\"}\");\n    else\n        print(t);\n    end\nend\n\nlocal db;\n\nif WeakAurasSaved.instanceHistoryDb then\n    db = WeakAurasSaved.instanceHistoryDb;\n    \n    --debug(\"loaded save data\")\n    \n    --dump(WeakAurasSaved.instanceHistoryDb)\nelse\n    WeakAurasSaved.instanceHistoryDb = WeakAurasSaved.instanceHistoryDb or {};\n    db = WeakAurasSaved.instanceHistoryDb;\nend\n\naura_env.db = db;\n\ndb.histGeneration = db.histGeneration or 1;\ndb.History = db.History or {};\ndb.HistoryDay = db.HistoryDay or {};\ndb.Instances = db.Instances or {};\ndb.config = deepcopy(aura_env.config);\n\n-- session variables\ndb.sess = {}; -- session variables, reset em each time \n-- db.sess.delayedReset;\n-- db.sess.delayUpdate;\n-- db.sess.histLastZone;\n-- db.sess.histInGroup;\n-- db.sess.lasthistdbg;\n-- db.sess.histLiveCount;\n-- db.sess.histOldest;\n-- db.sess.enterLoc;\naura_env.lastDisplayUpdate = 0;\n\n-- constant stuff\nlocal histReapTime = 60*60 -- 1 hour\nlocal histReapTimeDay = 60*60*24 -- 1 day\nlocal histLimit = 5 -- instances per hour\nlocal maxdiff = 33 -- max number of instance difficulties\nlocal LimitWarn = true;\nlocal prefix = \"instHistory\";\n\nlocal f = {};\n\nC_ChatInfo.RegisterAddonMessagePrefix(prefix);\nlocal thisToon = UnitName(\"player\") .. \" - \" .. GetRealmName()\n\nlocal transInstance = {\n    -- lockout hyperlink id = LFDID\n    [543] = 188,     -- Hellfire Citadel: Ramparts\n    [540] = 189,     -- Hellfire Citadel: Shattered Halls : deDE\n    [542] = 187,  -- Hellfire Citadel: Blood Furnace esES\n    [534] = 195,     -- The Battle for Mount Hyjal\n    [509] = 160,     -- Ruins of Ahn'Qiraj\n    [557] = 179,  -- Auchindoun: Mana-Tombs : ticket 72 zhTW\n    [556] = 180,  -- Auchindoun: Sethekk Halls : ticket 151 frFR\n    [568] = 340,  -- Zul'Aman: frFR\n    [1004] = 474, -- Scarlet Monastary: deDE\n    [600] = 215,  -- Drak'Tharon: ticket 105 deDE\n    [560] = 183,  -- Escape from Durnholde Keep: ticket 124 deDE\n    [531] = 161,  -- AQ temple: ticket 137 frFR\n    [1228] = 897, -- Highmaul: ticket 175 ruRU\n    [552] = 1011, -- Arcatraz: ticket 216 frFR\n    [1516] = 1190, -- Arcway: ticket 227/233 ptBR\n    [1651] = 1347, -- Return to Karazhan: ticket 237 (fake LFDID)\n    [545] = 185, -- The Steamvault: issue #143 esES\n    [1530] = 1353, -- The Nighthold: issue #186 frFR\n    [585] = 1154, -- Magisters' Terrace: issue #293 frFR\n}\n\nlocal function InGroup()\n    if IsInRaid() then return \"RAID\"\n    elseif GetNumGroupMembers() > 0 then return \"PARTY\"\n    else return nil end\nend\n\nlocal function histZoneKey()\n    local instname, insttype, diff, diffname, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()\n    \n    if insttype == nil or insttype == \"none\" or insttype == \"arena\" or insttype == \"pvp\" then -- pvp doesnt count\n        return nil\n    end\n    \n    --[[\n    if (IsInLFGDungeon() or IsInScenarioGroup()) and diff ~= 19 then -- LFG instances don't count, but Holiday Event counts\n        return nil\n    end\n]]\n    \n    -- check if we're locked (using FindInstance so we don't complain about unsaved unknown instances)\n    local truename = f.FindInstance(instname, insttype == \"raid\")\n    local locked = false\n    local inst = truename and db.Instances[truename]\n    inst = inst and inst[thisToon]\n    \n    for d=1,maxdiff do\n        if inst and inst[d] and inst[d].Locked then\n            locked = true\n        end\n    end\n    \n    if diff == 1 and maxPlayers == 5 then -- never locked to 5-man regs\n        locked = false\n    end\n    \n    local toonstr = thisToon\n    \n    if db.config.ShowServer then\n        toonstr = strsplit(\" - \", toonstr)\n    end\n    \n    local desc = toonstr .. \": \" .. instname\n    \n    if diffname and #diffname > 0 then\n        desc = desc .. \" - \" .. diffname\n    end\n    \n    local key = thisToon..\":\"..instname..\":\"..insttype..\":\"..diff\n    \n    if not locked then\n        key = key..\":\"..db.histGeneration\n    end\n    \n    return key, desc, locked\nend\n\naura_env.histZoneKey = histZoneKey;\n\nlocal function normalizeName(str)\n    return str:gsub(\"%p\",\"\"):gsub(\"%s\",\" \"):gsub(\"%s%s\",\" \"):gsub(\"^%s+\",\"\"):gsub(\"%s+$\",\"\"):upper()\nend\n\n-- some instances (like sethekk halls) are named differently by GetSavedInstanceInfo() and LFGGetDungeonInfoByID()\n-- we use the latter name to key our database, and this function to convert as needed\nf.FindInstance = function(name, raid)\n    if not name or #name == 0 then return nil end\n    \n    local nname = normalizeName(name)\n    -- first pass, direct match\n    local info = db.Instances[name]\n    \n    if info then\n        return name, info.LFDID\n    end\n    \n    -- hyperlink id lookup: must precede substring match for ticket 99\n    -- (so transInstance can override incorrect substring matches)\n    for i = 1, GetNumSavedInstances() do\n        local link = GetSavedInstanceChatLink(i) or \"\"\n        local lid,lname = link:match(\":(%d+):%d+:%d+\\124h%[(.+)%]\\124h\")\n        lname = lname and normalizeName(lname)\n        lid = lid and tonumber(lid)\n        local lfdid = lid and transInstance[lid]\n        if lname == nname and lfdid then\n            local truename = addon:UpdateInstance(lfdid)\n            if truename then\n                return truename, lfdid\n            end\n        end\n    end\n    -- normalized substring match\n    for truename, info in pairs(db.Instances) do\n        local tname = addon:normalizeName(truename)\n        if (tname:find(nname, 1, true) or nname:find(tname, 1, true)) and\n        info.Raid == raid then -- Tempest Keep: The Botanica\n            --debug(\"FindInstance(\"..name..\") => \"..truename)\n            return truename, info.LFDID\n        end\n    end\n    return nil\nend\n\nlocal function generationAdvance()\n    debug(\"HistoryUpdate generation advance\")\n    db.histGeneration = (db.histGeneration + 1) % 100000\n    db.sess.delayedReset = false\nend\n\nlocal function HistoryUpdate(forcereset, forcemesg)\n    local db = WeakAurasSaved.instanceHistoryDb;\n    db.histGeneration = db.histGeneration or 1;\n    \n    if forcereset and histZoneKey() then -- delay reset until we zone out\n        debug(\"HistoryUpdate reset delayed\")\n        db.sess.delayedReset = true\n    end\n    \n    if (forcereset or db.sess.delayedReset) and not histZoneKey() then\n        generationAdvance();\n    elseif db.lastLoc then\n        if not db.sess.enterLoc then\n            -- delay until enterLoc is defined\n            C_Timer.After(1, HistoryUpdate);\n            return;\n        end\n        \n        if db.sess.enterLoc.instance == db.lastLoc.instance and db.lastLoc.instance >= 0 and db.sess.enterLoc.subzone ~= db.lastLoc.subzone then\n            debug(\"Offline forced reset detected.\")\n            generationAdvance();\n        else\n            debug(\"Location data resolved, no reset detected.\")\n            \n            --[[if db.config.debug then\n                print(db.sess.enterLoc.instance, db.sess.enterLoc.subzone, db.lastLoc.instance, db.lastLoc.subzone)\n            end]]\n        end\n        \n        --[[if db.lastLoc then\n            debug(\"lastLoc cleared\")\n        end]]\n        \n        db.lastLoc = nil;\n    end\n    \n    local now = time()\n    \n    if db.sess.delayUpdate and now < db.sess.delayUpdate then\n        --debug(\"HistoryUpdate delayed\")\n        C_Timer.After(db.sess.delayUpdate - now + 0.05, HistoryUpdate)\n        return\n    end\n    \n    local zoningin = false\n    local newzone, newdesc, locked = histZoneKey()\n    \n    -- touch zone we left\n    if db.sess.histLastZone then\n        local lz = db.History[db.sess.histLastZone]\n        local lzDay = db.HistoryDay[db.sess.histLastZone]\n        if lz then\n            lz.last = now\n            lzDay.last = now\n        end\n    elseif newzone then\n        zoningin = true\n    end\n    \n    db.sess.histLastZone = newzone\n    db.sess.histInGroup = InGroup()\n    \n    -- touch/create new zone\n    if newzone and not string.match(newzone, \"Blackwing%sLair\") and not string.match(newzone, \"Molten%sCore\") and not string.match(newzone, \"Ahn.Qiraj\") and not string.match(newzone, \"Naxxramas\") then\n        local nz = db.History[newzone]\n        local nzDay = db.HistoryDay[newzone]\n        \n        if not nz then\n            nz = { create = now, desc = newdesc }\n            nzDay = nz\n            db.History[newzone] = nz\n            db.HistoryDay[newzone] = nzDay\n            \n            if locked then -- creating a locked instance, delete unlocked version\n                db.History[newzone..\":\"..db.histGeneration] = nil\n                db.HistoryDay[newzone..\":\"..db.histGeneration] = nil\n            end\n        elseif not nzDay then\n            nzDay = nz\n            db.HistoryDay[newzone] = nzDay\n            \n            if locked then -- creating a locked instance, delete unlocked version\n                db.HistoryDay[newzone..\":\"..db.histGeneration] = nil\n            end\n        end\n        \n        \n        nz.last = now\n        nzDay.last = now\n    end\n    \n    -- reap old zones\n    local livecnt = 0\n    local oldestkey, oldesttime\n    \n    for zk, zi in pairs(db.History) do\n        if now > zi.last + histReapTime or\n        zi.last > (now + 3600) then -- temporary bug fix\n            debug(\"Reaping %s\",zi.desc)\n            db.History[zk] = nil\n        else\n            livecnt = livecnt + 1\n            \n            if not oldesttime or zi.last < oldesttime then\n                oldestkey = zk\n                oldesttime = zi.last\n            end\n        end\n    end\n    \n    -- reap old zones per day\n    for zk, zi in pairs(db.HistoryDay) do\n        if now > zi.last + histReapTimeDay or\n        zi.last > (now + 86400) then -- temporary bug fix\n            debug(\"Reaping %s from day\",zi.desc)\n            db.HistoryDay[zk] = nil\n        end\n    end\n    \n    local oldestrem = oldesttime and (oldesttime+histReapTime-now)\n    local oldestremt = (oldestrem and SecondsToTime(oldestrem,false,false,1)) or \"n/a\"\n    local oldestremtm = (oldestrem and SecondsToTime(math.floor((oldestrem+59)/60)*60,false,false,1)) or \"n/a\"\n    \n    if db.config.debug then\n        local msg = livecnt..\" live instances, oldest (\"..(oldestkey or \"none\")..\") expires in \"..oldestremt..\". Current Zone=\"..(newzone or \"nil\")\n        if msg ~= db.sess.lasthistdbg then\n            db.sess.lasthistdbg = msg\n            debug(msg)\n        end\n        \n        --dump(db.History)\n    end\n    -- display update\n    \n    if forcemesg or (LimitWarn and zoningin and livecnt >= histLimit-1) then\n        chatMsg(\"Warning: You've entered about %i instances recently and are approaching the %i instance per hour limit for your account. More instances should be available in %s.\",livecnt, histLimit, oldestremt)\n    end\n    \n    db.sess.histLiveCount = livecnt\n    db.sess.histOldest = oldestremt\n    \n    --[[\n    if db.Tooltip.HistoryText and livecnt > 0 then\n        addon.dataobject.text = \"(\"..livecnt..\"/\"..(oldestremt or \"?\")..\")\"\n        addon.histTextthrottle = math.min(oldestrem+1, addon.histTextthrottle or 15)\n        addon.resetDetect:SetScript(\"OnUpdate\", addon.histTextUpdate)\n    else\n        addon.dataobject.text = addonAbbrev\n        addon.resetDetect:SetScript(\"OnUpdate\", nil)\n    end\n]]\nend\n\n-- fixme localize or something\nfunction doExplicitReset(instancemsg, failed)\n    if InGroup() and not UnitIsGroupLeader(\"player\") then\n        return\n    end\n    \n    local db = WeakAurasSaved.instanceHistoryDb;\n    \n    if not failed then\n        HistoryUpdate(true)\n    end\n    \n    local reportchan = InGroup()\n    \n    if reportchan then\n        if not failed then\n            C_ChatInfo.SendAddonMessage(prefix, \"GENERATION_ADVANCE\", reportchan)\n        end\n        if db.config.ReportResets then\n            local msg = instancemsg or RESET_INSTANCES\n            msg = msg:gsub(\"\\1241.+;.+;\",\"\") -- ticket 76, remove |1;; escapes on koKR\n            -- SendChatMessage(\"All instances have been reset.\", reportchan)\n        end\n    end\nend\n\nhooksecurefunc(\"ResetInstances\", doExplicitReset)\n\naura_env.CHAT_MSG_SYSTEM = function(msg)\n    local raiddiffmsg = ERR_RAID_DIFFICULTY_CHANGED_S:gsub(\"%%s\",\".+\")\n    local dungdiffmsg = ERR_DUNGEON_DIFFICULTY_CHANGED_S:gsub(\"%%s\",\".+\")\n    \n    if msg == INSTANCE_SAVED then -- just got saved\n        C_Timer.After(4, HistoryUpdate)\n    elseif (msg:match(\"^\"..raiddiffmsg..\"$\") or msg:match(\"^\"..dungdiffmsg..\"$\")) and\n    not histZoneKey() then -- ignore difficulty messages when creating a party while inside an instance\n        HistoryUpdate(true)\n    elseif msg:match(TRANSFER_ABORT_TOO_MANY_INSTANCES) then\n        HistoryUpdate(false,true)\n    end\nend\n\naura_env.INSTANCE_BOOT_START = function()\n    HistoryUpdate(true)\nend\n\naura_env.INSTANCE_BOOT_STOP = function()\n    if InGroup() then\n        db.sess.delayedReset = false\n    end\nend\n\naura_env.GROUP_ROSTER_UPDATE = function()\n    if db.sess.histInGroup and not InGroup() and -- ignore failed invites when solo\n    not histZoneKey() then -- left group outside instance, resets now\n        HistoryUpdate(true)\n    end\nend\n\nlocal function zoneChanged(extraDelay)\n    -- delay updates while settings stabilize\n    local waittime = 3 + math.max(0,10 - GetFramerate()) + (extraDelay or 0)\n    local d = time() + waittime\n    \n    if d > (db.sess.delayUpdate or 0) then\n        db.sess.delayUpdate = d;\n    end\n    \n    C_Timer.After(waittime + 0.05, HistoryUpdate)\nend\n\nlocal function getLocation()\n    local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo();\n    \n    local loc;\n    \n    if instanceType == \"none\" then\n        loc = {};\n        loc.instance = -1;\n    else\n        loc = {};\n        --loc.instance = histZoneKey();\n        loc.instance = instanceID;\n        loc.subzone = GetSubZoneText();\n    end\n    \n    --[[\n    if db.config.debug then\n        dump(loc)\n    end\n]]\n    \n    return loc;\nend\n\naura_env.PLAYER_ENTERING_WORLD = function()\n    C_Timer.After(6, function()\n            db.sess.enterLoc = getLocation();\n    end)\n    \n    zoneChanged();\nend\n\naura_env.ZONE_CHANGED_NEW_AREA = function()\n    zoneChanged();\nend\n\naura_env.RAID_INSTANCE_WELCOME = function()\n    zoneChanged();\nend\n\naura_env.PLAYER_CAMPING = function()\n    db.lastLoc = getLocation();\n    --debug(\"Set lastLoc\")\n    \n    --dump(WeakAurasSaved.instanceHistoryDb)\nend\n\naura_env.CHAT_MSG_ADDON = function(pre, msg, channel, sender)\n    if pre == prefix then\n        if msg == \"GENERATION_ADVANCE\" and not UnitIsUnit(sender, \"player\") then\n            HistoryUpdate(true);\n        elseif msg == \"RESET_REQUEST\" then\n            if UnitIsGroupLeader(\"player\") then\n                chatMsg(string.format(\"Received reset request from %s. All instances will be reset once %s is offline.\", sender, sender))\n                aura_env.autoReset = string.match(sender, \"^[^%-]+\");\n            end\n        end\n    end\nend\n\naura_env.SEND_INSTANCE_RESET_REQUEST = function()\n    local channel = InGroup();\n    \n    if channel then\n        C_ChatInfo.SendAddonMessage(prefix, \"RESET_REQUEST\", reportchan);\n    end\nend\n\naura_env.doAutoReset = function()\n    if not aura_env.autoReset then\n        return;\n    end\n    \n    if not UnitIsGroupLeader(\"player\") then\n        debug(\"Player is not leader, auto reset disabled.\")\n        aura_env.autoReset = nil;\n        return;\n    end\n    \n    local name = aura_env.autoReset;\n    \n    if UnitExists(name) then\n        if not UnitIsConnected(name) then\n            C_Timer.After(1, function()\n                    ResetInstances();\n            end)\n            aura_env.autoReset = nil;\n            return;\n        end\n    else\n        debug(\"Sender does not exist, auto reset disabled.\")\n        aura_env.autoReset = nil;\n        return;\n    end\nend\n\n--[[\naura_env.PLAYER_LEAVING_WORLD = function()\n    db.lastLoc = getLocation();\n    debug(\"Set lastLoc\")\nend\n]]\n\n--DevTools_Dump(getLocation())\n\n\n--HistoryUpdate();\n\n--print(histZoneKey())",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["width"] = 270,
			["inverse"] = false,
			["sparkRotationMode"] = "AUTO",
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["uid"] = "JnXsI)Znc0b",
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["name"] = "Debug Mode",
					["default"] = false,
					["useDesc"] = false,
					["key"] = "debug",
					["width"] = 1,
				}, -- [1]
				{
					["type"] = "toggle",
					["name"] = "Report Resets to Chat",
					["default"] = false,
					["useDesc"] = false,
					["key"] = "ReportResets",
					["width"] = 1,
				}, -- [2]
				{
					["type"] = "toggle",
					["name"] = "Show Server Name",
					["default"] = false,
					["useDesc"] = false,
					["key"] = "ShowServer",
					["width"] = 1,
				}, -- [3]
				{
					["type"] = "toggle",
					["key"] = "showTimeSpent",
					["default"] = false,
					["useDesc"] = false,
					["name"] = "Show time spent in instances",
					["width"] = 1,
				}, -- [4]
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 10,
					["step"] = 0.05,
					["width"] = 1,
					["min"] = 0.5,
					["key"] = "updateInterval",
					["name"] = "Display Update Interval",
					["default"] = 5,
				}, -- [5]
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 5,
					["step"] = 1,
					["width"] = 1,
					["min"] = 0,
					["name"] = "Display Threshold",
					["desc"] = "Minimum number of instances before display appears",
					["key"] = "displayMin",
					["default"] = 2,
				}, -- [6]
			},
		},
		["Mana regen with 5s rule"] = {
			["sparkWidth"] = 15,
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 5,
			["anchorPoint"] = "TOP",
			["zoom"] = 0,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/d1KmPR0Rj/1",
			["backgroundColor"] = {
				0, -- [1]
				0.0784313725490196, -- [2]
				0.352941176470588, -- [3]
				0.382352113723755, -- [4]
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
			["internalVersion"] = 37,
			["sparkOffsetX"] = 0,
			["selfPoint"] = "BOTTOM",
			["backdropInFront"] = false,
			["authorOptions"] = {
			},
			["barColor"] = {
				0, -- [1]
				0.235294117647059, -- [2]
				1, -- [3]
				0.676470726728439, -- [4]
			},
			["desaturate"] = false,
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
			["icon"] = false,
			["sparkOffsetY"] = 0,
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
			["height"] = 7,
			["color"] = {
			},
			["load"] = {
				["use_class"] = false,
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
			["useAdjustededMax"] = false,
			["uid"] = "dvZawXAyrxC",
			["sparkColor"] = {
				0.93725490196078, -- [1]
				1, -- [2]
				0.94509803921569, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["width"] = 115,
			["alpha"] = 1,
			["smoothProgress"] = false,
			["anchorFrameFrame"] = "PlayerFrameHealthBar",
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["useAdjustededMin"] = false,
			["icon_side"] = "RIGHT",
			["sparkHidden"] = "NEVER",
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["spark"] = true,
			["sparkTexture"] = "GarrMission_EncounterBar-Spark",
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Mana regen with 5s rule",
			["semver"] = "1.0.0",
			["frameStrata"] = 5,
			["anchorFrameType"] = "SELECTFRAME",
			["ignoreOptionsEventErrors"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
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
		},
	},
	["lastArchiveClear"] = 1602609267,
	["minimap"] = {
		["hide"] = true,
	},
	["lastUpgrade"] = 1602700027,
	["dbVersion"] = 37,
	["registered"] = {
	},
	["login_squelch_time"] = 10,
	["frame"] = {
		["xOffset"] = -901.001098632812,
		["width"] = 927.000305175781,
		["height"] = 995.999877929688,
		["yOffset"] = -113.50146484375,
	},
	["instanceHistoryDb"] = {
		["sess"] = {
			["histOldest"] = "n/a",
			["enterLoc"] = {
				["instance"] = -1,
			},
			["delayUpdate"] = 1602963979,
			["histLiveCount"] = 0,
		},
		["History"] = {
		},
		["HistoryDay"] = {
			["Augustin - Golemagg:Zul'Farrak:party:1:23"] = {
				["last"] = 1602955575,
				["create"] = 1602954080,
				["desc"] = "Augustin - Golemagg: Zul'Farrak - Normal",
			},
			["Augustin - Golemagg:Zul'Farrak:party:1:26"] = {
				["last"] = 1602958144,
				["create"] = 1602956489,
				["desc"] = "Augustin - Golemagg: Zul'Farrak - Normal",
			},
			["Augustin - Golemagg:Zul'Farrak:party:1:20"] = {
				["last"] = 1602950751,
				["create"] = 1602949548,
				["desc"] = "Augustin - Golemagg: Zul'Farrak - Normal",
			},
			["Augustin - Golemagg:Zul'Farrak:party:1:21"] = {
				["last"] = 1602952414,
				["create"] = 1602950801,
				["desc"] = "Augustin - Golemagg: Zul'Farrak - Normal",
			},
			["Augustin - Golemagg:Zul'Farrak:party:1:22"] = {
				["last"] = 1602954042,
				["create"] = 1602952656,
				["desc"] = "Augustin - Golemagg: Zul'Farrak - Normal",
			},
		},
		["histGeneration"] = 26,
		["config"] = {
			["displayMin"] = 0,
			["debug"] = false,
			["updateInterval"] = 5,
			["ShowServer"] = false,
			["ReportResets"] = false,
			["showTimeSpent"] = false,
		},
		["Instances"] = {
		},
	},
	["editor_theme"] = "Monokai",
}
