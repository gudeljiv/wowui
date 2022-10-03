
PitBull4DB = {
	["namespaces"] = {
		["CombatIcon"] = {
		},
		["LeaderIcon"] = {
		},
		["ExperienceBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["enabled"] = false,
						},
					},
				},
			},
		},
		["ResurrectionIcon"] = {
		},
		["RangeFader"] = {
		},
		["Border"] = {
		},
		["Highlight"] = {
		},
		["Sounds"] = {
		},
		["LuaTexts"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["first"] = false,
							["elements"] = {
								["Lua:Reputation"] = {
									["events"] = {
										["UNIT_FACTION"] = true,
										["UPDATE_FACTION"] = true,
									},
									["exists"] = true,
									["code"] = "local name, _, min , max, value, id = GetWatchedFactionInfo()\nif IsMouseOver() then\n  return name or ConfigMode()\nelse\n  local bar_cur,bar_max = value-min,max-min\n  return \"%d/%d (%s%%)\",bar_cur,bar_max,Percent(bar_cur,bar_max)\nend",
									["location"] = "center",
									["attach_to"] = "ReputationBar",
								},
								["Lua:Name"] = {
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
										["UNIT_NAME_UPDATE"] = true,
									},
									["exists"] = true,
									["code"] = "return '%s %s%s%s',Name(unit),Angle(AFK(unit) or DND(unit))",
									["location"] = "left",
									["attach_to"] = "HealthBar",
								},
								["Lua:Threat"] = {
									["events"] = {
										["UNIT_THREAT_LIST_UPDATE"] = true,
										["UNIT_THREAT_SITUATION_UPDATE"] = true,
									},
									["exists"] = true,
									["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
									["location"] = "center",
									["attach_to"] = "ThreatBar",
								},
								["Lua:Experience"] = {
									["events"] = {
										["UNIT_PET_EXPERIENCE"] = true,
										["PLAYER_XP_UPDATE"] = true,
									},
									["exists"] = true,
									["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
									["location"] = "center",
									["attach_to"] = "ExperienceBar",
								},
								["Lua:Druid mana"] = {
									["events"] = {
										["UNIT_DISPLAYPOWER"] = true,
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER_FREQUENT"] = true,
									},
									["exists"] = true,
									["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
									["location"] = "center",
									["attach_to"] = "AltManaBar",
								},
								["Lua:Cast time"] = {
									["events"] = {
										["UNIT_SPELLCAST_SUCCEEDED"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
									["exists"] = true,
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "CastBar",
								},
								["Lua:Health"] = {
									["exists"] = true,
									["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s%%\",Percent(HP(unit),MaxHP(unit))",
									["location"] = "right",
									["events"] = {
										["UNIT_MAXHEALTH"] = true,
										["UNIT_HEALTH"] = true,
										["UNIT_AURA"] = true,
									},
									["attach_to"] = "HealthBar",
									["size"] = 0.9,
								},
								["Lua:PVPTimer"] = {
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
									},
									["exists"] = true,
									["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
									["location"] = "out_right_top",
								},
								["Lua:Class"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_LEVEL"] = true,
										["UNIT_CLASSIFICATION_CHANGED"] = true,
										["UNIT_AURA"] = true,
									},
									["exists"] = true,
									["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
									["location"] = "left",
									["attach_to"] = "PowerBar",
								},
								["Lua:Cast"] = {
									["events"] = {
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
									["exists"] = true,
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
									["location"] = "left",
									["attach_to"] = "CastBar",
								},
								["Lua:Power"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER_FREQUENT"] = true,
									},
									["exists"] = true,
									["code"] = "local max = MaxPower(unit)\nif max > 0 then\n  return \"%s/%s\",Power(unit),max\nend",
									["location"] = "right",
									["attach_to"] = "PowerBar",
								},
							},
						},
					},
				},
			},
		},
		["PowerBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["size"] = 1,
							["animated"] = true,
							["use_atlas"] = true,
						},
					},
				},
			},
		},
		["Aura"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["layout"] = {
								["debuff"] = {
									["my_size"] = 28,
									["anchor"] = "TOPLEFT",
									["size"] = 18,
									["side"] = "TOP",
									["growth"] = "right_up",
								},
								["buff"] = {
									["my_size"] = 28,
									["anchor"] = "TOPLEFT",
									["size"] = 18,
									["side"] = "TOP",
								},
							},
						},
					},
				},
			},
		},
		["BlankSpace"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["first"] = false,
							["elements"] = {
								["Default"] = {
									["exists"] = true,
								},
							},
						},
					},
				},
			},
		},
		["Background"] = {
		},
		["ComboPoints"] = {
		},
		["HideBlizzard"] = {
		},
		["RestIcon"] = {
		},
		["RaidTargetIcon"] = {
		},
		["HealthBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["size"] = 10,
						},
					},
				},
			},
		},
		["PvPIcon"] = {
		},
		["ManaSpark"] = {
		},
		["Aggro"] = {
		},
		["VisualHeal"] = {
		},
		["HostilityFader"] = {
		},
		["CombatFader"] = {
		},
		["Portrait"] = {
		},
		["ReputationBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["enabled"] = false,
						},
					},
				},
			},
		},
		["CombatText"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["position"] = 1.00001,
						},
					},
				},
			},
		},
		["ThreatBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["size"] = 2,
							["show_solo"] = true,
						},
					},
				},
			},
		},
		["CastBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["enabled"] = false,
						},
					},
				},
			},
		},
		["ReadyCheckIcon"] = {
		},
		["CastBarLatency"] = {
		},
	},
	["global"] = {
		["config_version"] = 6,
	},
	["profileKeys"] = {
		["Mxyzptlk - Golemagg"] = "Default",
		["Vermin - Golemagg"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["class_order"] = {
				"WARRIOR", -- [1]
				"PALADIN", -- [2]
				"PRIEST", -- [3]
				"SHAMAN", -- [4]
				"DRUID", -- [5]
				"ROGUE", -- [6]
				"MAGE", -- [7]
				"WARLOCK", -- [8]
				"HUNTER", -- [9]
			},
			["layouts"] = {
				["Normal"] = {
					["size_y"] = 50,
					["exists"] = true,
					["bar_texture"] = "Glamour2",
				},
			},
			["made_groups"] = true,
			["units"] = {
				["Player's pet's target"] = {
					["unit"] = "pettarget",
				},
				["Player's pet"] = {
					["enabled"] = true,
					["position_x"] = 1.42852783203125,
					["unit"] = "pet",
					["relative_point"] = "BOTTOM",
					["position_y"] = -21.42501831054688,
					["anchor"] = "TOP",
					["relative_to"] = "SPlayer",
				},
				["Target's target's target"] = {
					["unit"] = "targettargettarget",
				},
				["Target's target"] = {
					["enabled"] = true,
					["relative_to"] = "STarget",
					["unit"] = "targettarget",
					["relative_point"] = "RIGHT",
					["anchor"] = "LEFT",
				},
				["Focus's target's target"] = {
					["unit"] = "focustargettarget",
				},
				["Player"] = {
					["enabled"] = true,
					["position_x"] = 843.1658935546875,
					["unit"] = "player",
					["relative_point"] = "TOPLEFT",
					["position_y"] = -737.2050170898438,
					["anchor"] = "TOPLEFT",
				},
				["Focus"] = {
					["enabled"] = true,
					["position_x"] = 250,
					["unit"] = "focus",
					["relative_point"] = "TOPLEFT",
					["position_y"] = -260,
					["anchor"] = "TOPLEFT",
				},
				["Target"] = {
					["enabled"] = true,
					["position_x"] = 1311.864624023438,
					["unit"] = "target",
					["relative_point"] = "TOPLEFT",
					["position_y"] = -736.575927734375,
					["anchor"] = "TOPLEFT",
				},
				["Focus's target"] = {
					["unit"] = "focustarget",
				},
			},
			["made_units"] = true,
			["groups"] = {
				["Party pets"] = {
					["unit_group"] = "partypet",
					["exists"] = true,
				},
				["Party"] = {
					["position_x"] = 10,
					["relative_point"] = "TOPLEFT",
					["enabled"] = true,
					["exists"] = true,
					["position_y"] = -260,
				},
			},
			["minimap_icon"] = {
				["hide"] = true,
			},
		},
	},
}
