local options = {}
local db = {}

local L = PerfectRaidLocals

options.type = "group"
options.name = "PerfectRaid"
options.get = function(k) return db[k.arg] end
options.set = function(k,v) db[k.arg] = v end
options.get = function() end
options.set = function() end
options.args = {}

options.args.general = {
	order = 1,
	type = "group",
	name = L["General Options"],
	desc = L["General addon-wide options"],
	args = {
		hideblizzparty = {
			name = L["Hide Blizzard party frames"],
			desc = L["Forces the Blizzard party frames to be hidden"],
			type = "toggle",
			arg = "hideblizzparty",
		},
		lockframes = {
			name = L["Lock PerfectRaid"],
			desc = L["Locks frames in place so they can't be moved accidentally"],
			type = "toggle",
			arg = "lock",
		},
		tooltips = {
			name = L["Show tooltips on mouseover"],
			desc = L["Displays the unit tooltip on mouseover"],
			type = "toggle",
			arg = "tooltip",
		},
	},
}

options.args.aggro = {
	type = "group",
	name = L["Aggro Options"],
	desc = L["Options for aggro calculation and display"],
	args = {
		showaggro = {
			order = 1,
			name = L["Perform aggro check"],
			desc = L["Enables calculating which friendly units have aggro"],
			type = "toggle",
			arg = "aggro,enable",
		},
		aggrodelay = {
			name = L["Update delay"],
			desc = L["Controls the delay between aggro calculations, in seconds"],
			type = "range",
			min = 0.0, max = 2.0, step = 0.05,
			arg = "aggro,delay"
		},
	},
}

options.args.highlight = {
	type = "group",
	name = L["Highlight Options"],
	args = {
		mouseover = {
			type = "toggle",
			name = L["Highlight on mouseover"],
		},
		disease = {
			type = "toggle",
			name = L["Highlight diseased units"],
		},
		curse = {
			type = "toggle",
			name = L["Highlight cursed units"],
		},
		magic = {
			type = "toggle",
			name = L["Highlight units with a magic debuff"],
		},
		poison = {
			type = "toggle",
			name = L["Highlight poisoned units"],
		},
		targetfocus = {
			type = "group",
			name = L["Target/Focus"],
			args = {
				target = {
					order = 1,
					type = "toggle",
					name = L["Highlight player's target"],
				},
				targetcolor = {
					order = 2,
					type = "color",
					name = L["Target highlight color"],
					hasAlpha = true,
				},
				focus = {
					order = 3,
					type = "toggle",
					name = L["Highlight player's focus"],
				},
				focuscolor = {
					order = 4,
					type = "color",
					name = L["Focus highlight color"],
					hasAlpha = true,
				},
			},
		},
	},
} -- end highlight

options.args.range = {
	type = "group",
	name = L["Range checking options"],
	args = {
		enable = {
			type = "toggle",
			name = L["Enable range checking"],
		},
		delay = {
			type = "range",
			name = L["Range checking delay"],
			desc = L["Changes the delay between range checks"],
			min = 0, max = 2, step = 0.05,
		},
		alpha = {
			type = "range",
			name = L["Out of range alpha"],
			desc = L["The opacity level to be set on frames that are out of range"],
			min = 0, max = 1.0, step = 0.05,
		},
	},
} -- end range


local function getFrameArgs()
	return {
		help = {
			order = 1,
			type = "description",
			name = L["From here you can configure the options for a display frame, including what units it displays and other options that change the look, feel and operation of the frame."],
		},

		filters = {
			type = "group",
			name = L["Filters"],
			desc = L["Filters which units are displayed in the frame"],
			args = {
				classes = {
					order = 1,
					type = "multiselect",
					name = L["Classes"],
					width = "half",
					inline = true,
					values = {
						WARRIOR = L["Warrior"],
						PRIEST = L["Priest"],
						DRUID = L["Druid"],
						SHAMAN = L["Shaman"],
						PALADIN = L["Paladin"],
						MAGE = L["Mage"],
						ROGUE = L["Rogue"],
						WARLOCK = L["Warlock"],
						HUNTER = L["Hunter"],
                        DEMONHUNTER = L["Demon Hunter"],
					}
				},
				groups = {
					order = 2,
					type = "multiselect",
					name = L["Groups"],
					width = "half",
					inline = true,
					values = {
						L["Group 1"],
						L["Group 2"],
						L["Group 3"],
						L["Group 4"],
						L["Group 5"],
						L["Group 6"],
						L["Group 7"],
						L["Group 8"],
					}
				},
				roles = {
					order = 3,
					type = "multiselect",
					name = L["Roles"],
					width = "half",
					inline = true,
					values = {
						MAINTANK = L["Main tank"],
						MAINASSIST = L["Main assist"],
					},
				},
				namelist = {
					order = 4,
					type = "input",
					width = "full",
					name = L["Name list"],
					desc = L["A list of players name to be shown.  This option will not be used if any of the group or class filters are set"],
				},
				strict = {
					order = 5,
					type = "toggle",
					name = L["Strict filtering"],
					desc = L["When strict filtering is enabled, a unit must match all given filters in order to be shown."],
				},
			},
		}, -- end filters

		visibility = {
			type = "group",
			name = L["Visibility"],
			desc = L["Options that determine when the frames are shown"],
			args = {
				showRaid = {
					width = "full",
					type = "toggle",
					name = L["Show the frame when in a raid"],
				},
				showParty = {
					width = "full",
					type = "toggle",
					name = L["Show the frame when in a party, but not in a raid"],
				},
				showPlayer = {
					width = "full",
					type = "toggle",
					name = L["Show the player when not in a raid"],
					desc = L["Enables adding the player to the party or solo frames"],
				},
				showSolo = {
					width = "full",
					type = "toggle",
					name = L["Show the frame when not grouped"],
					-- TODO: Enable showPlayer at the same time
				},
			}
		}, -- end visibility

		groupsort = {
			type = "group",
			name = L["Grouping/Sorting"],
			desc = L["Options that set the grouping and sorting for the frame"],
			args = {
				help = {
					order = 1,
					type = "description",
					name = L["Grouping is the first level of sorting, allowing you to group all of the tanks together, and all of the healers together.  After grouping is done, the sort order is applied."],
				},

				grouping = {
					inline = true,
					type = "group",
					name = L["Grouping"],
					args = {
						groupBy = {
							type = "select",
							name = L["Group frames by:"],
							desc = L["Chooses the criteria used to group the frames"],
							values = {
								nogrouping = L["No grouping"],
								group = L["Raid group number"],
								class = L["Class"],
								role = L["Role"],
							},

						},
						groupingOrder = {
							type = "input",
							name = L["Grouping order:"],
							desc = L["Specifies the sort order for grouping.  This should be a comma separated list of group numbers, uppercase english class names, or roles"],
						},
					},
				}, -- end grouping

				sorting = {
					type = "group",
					inline = true,
					name = L["Sorting"],
					args = {
						sortMethod = {
							type = "select",
							name = L["Sort method"],
							desc = L["Chooses the sort method when sorting frames.  This sort is applied after the grouping order"],
							values = {
								index = L["By party/raid index"],
								name = L["By name"],
							},
						},
						sortDirection = {
							type = "select",
							name = L["Sort direction"],
							values = {
								ASC = "Ascending order",
								DESC = "Descending order",
							},
						},
						startIndex = {
							type = "input",
							name = L["Start index"],
							desc = L["The start index of the final sorted unit list at which to begin displaying units"],
							validate = function(info, value)
								local num = tonumber(value)
								if not num or num < 1 or num > 40 then
									return L["Start index must be a value between 1 and 40"]
								end
								return true
							end,
						},
					},
				}, -- end sorting
			},
		}, -- end groupsort

		columns = {
			type = "group",
			name = L["Columns"],
			desc = L["Options that allow you to split the dislpay of frames into columns"],
			args = {
				maxColumns = {
					type = "input",
					name = L["Max columns to display"],
					validate = function(info, value)
						local num = tonumber(value)
						if not num then
							return L["Max column must be a number"]
						end
						return true
					end,
				},
				unitsPerColumn = {
					type = "input",
					name = L["Number of units per column"],
					validate = function(info, value)
						if value and not tonumber(value) then
							return L["Number of units per column must be a number, or nil"]
						end
						return true
					end
				},
				columnSpacing = {
					type = "input",
					name = L["Column spacing"],
					validate = function(info, value)
						if value and not tonumber(value) then
							return L["Column spacing must be a number, or nil"]
						end
						return true
					end,
				},
				columnAnchorPoint = {
					type = "select",
					name = L["Column anchor point"],
					desc = L["The anchor point for each new column.  Setting this to LEFT will cause the columns to grow to the right, for example."],
					values = {
						"TOPLEFT","TOP","TOPRIGHT","RIGHT","BOTTOMRIGHT","BOTTOM","BOTTOMLEFT","LEFT"
					},
				},
			},
		}, -- end columns

		display = {
			type = "group",
			name = L["General"],
			args = {
				backdrop = {
					type = "group",
					name = L["Backdrop"],
					inline = true,
					args = {
						headerbackdrop = {
							order = 1,
							width = "double",
							type = "toggle",
							name = L["Display a backdrop behind frame"],
						},
						headercolor = {
							order = 2,
							type = "color",
							name = L["Backdrop color"],
							desc = L["The color to be applied to the backdrop"],
							hasAlpha = true,
						},
					},
				},

				clickcasting = {
					order = 99,
					width = "double",
					type = "toggle",
					name = L["Enable click-casting on frames"],
					desc = L["Sets the frames to work with addons such as Clique"],
				},
				title = {
					order = 1,
					type = "input",
					width = "full",
					name = L["Title of frame"],
					desc = L["A title to be displayed above the frame"],
				},

				healthbars = {
					type = "group",
					inline = true,
					name = L["Health bar options"],
					args = {
						classcolor = {
							type = "toggle",
							name = L["Color bars by class"],
						},
						reverse = {
							type = "toggle",
							name = L["Reverse HP bars"],
						},
						deficit = {
							type = "toggle",
							name = L["Show health deficit"],
							desc = L["Shows the amount of health missing, rather than the amount of health the player has currently."],
						},
						percent = {
							type = "toggle",
							name = L["Show percentages only"],
							desc = L["Changes the health display to only show percentages"],
						},
						shortnums = {
							type = "toggle",
							name = L["Shorten large numbers"],
							desc = L["Shortens 1500 to 1.5k"],
						},
					},
				}, -- end healthbars

				manabars = {
					type = "group",
					inline = true,
					name = L["Power bar options"],
					args = {
						barheight = {
							type = "range",
							name = L["Height of power bar"],
							desc = L["The height of the power bar, in game pixels"],
							min = 0, max = 10, step = 1,
						},
						manaonly = {
							type = "toggle",
							name = L["Only show mana users"],
							desc = L["This option hides the power bars for non-mana users such as warriors and rogues."],
						},
					},
				}, -- end manabars
			},
		}, -- end display
	} -- end table definition
end

options.args.frames = {
	type = "group",
	name = L["Frame Editor"],
	args = {
		add = {
			type = "input",
			name = L["Add new frame:"],
			desc = L["Each frame must be given a unique name.  This is not the same as the title that can be displayed above the frame"],
			set = function(self, name)
				options.args.frames.args[name] = {
					type = "group",
					name = name,
					arg = name,
					childGroups = "tab",
					args = getFrameArgs(),
				}
			end
		},
	},
}

if LibStub and LibStub("AceConfig-3.0") then
	LibStub("AceConfig-3.0"):RegisterOptionsTable("PerfectRaid", options)
--	LibStub("AceConfigDialog-3.0"):Open("PerfectRaid")
end

