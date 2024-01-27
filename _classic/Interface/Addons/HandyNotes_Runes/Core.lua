--[[
                                ----o----(||)----oo----(||)----o----

                                                Runes

                                      v1.29 - 27th January 2024
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved

                                ----o----(||)----oo----(||)----o----
]]

local myName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}
ns.texturesNum = ""
ns.texturesNumCode = {}
ns.scalingNum = 0
-- Pink theme
ns.colour = {}
ns.colour.prefix	= "\124cFFFF007F" -- Bright Pink
ns.colour.highlight = "\124cFFFF69B4" -- Hot Pink
ns.colour.plaintext = "\124cFFFFB2D0" -- Powder Pink

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = false,
								hideIfRuneLearnt = true, iconChoice = 15,
								icon1 = 5, icon2 = 5, icon3 = 5, icon4 = 5, icon5 = 5,
								icon6 = 5, icon7 = 5, icon8 = 5, icon9 = 5, icon10 = 5, 
								icon11 = 5, icon12 = 5 } }
local continents = {}
local pluginHandler = {}

-- Upvalues
local GameTooltip = _G.GameTooltip
local GetRunesForCategory = C_Engraving.GetRunesForCategory
local IsKnownRuneSpell = C_Engraving.IsKnownRuneSpell
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local UnitLevel = UnitLevel
local formatt, ipairs, next, type = format, ipairs, next, type
local HandyNotes = _G.HandyNotes

ns.name = UnitName( "player" ) or "Character"
ns.faction = UnitFactionGroup( "player" )

ns.classLocal, ns.class = UnitClass( "player" )
ns.raceList = { "Human", "Orc", "Dwarf", "Night Elf", "Undead", "Tauren", "Gnome", "Troll" }
ns.slotList = { "Head", "Neck", "Shoulders", "Shirt", "Chest", "Waist", "Legs", "Feet",
				"Wrist", "Hands", "Ring 1", "Ring 2", "Trinket 1", "Trinket 2", "Back",
				"Main Hand", "Off Hand", "Ranged", "Tabard" }
ns.slotColour = { "\124cFFFFFF00", "\124cFFFFD700", "\124cFFFFA500", "\124cFFFFFFFF", "\124cFF0000FF", 
						"\124cFF3CB371", "\124cFF4169E1", "\124cFF008000", "\124cFF00FF00", "\124cFF87CEFA",
						"\124cFF00FFFF", "\124cFFFFFFFF", "\124cFF7FFFD4", "\124cFFFFFFFF", "\124cFFFFFFFF", 
						"\124cFF008B8B", "\124cFFFFFFFF", "\124cFFFFFFFF", "\124cFFFFFFFF" }

ns.race = ns.raceList[ select( 3, UnitRace( "player" ) ) ]
ns.colour.class = "\124c" ..select( 4, GetClassColor( ns.class ) )

continents[ 1414 ] = true -- Kalimdor
continents[ 1415 ] = true -- Eastern Kingdoms

local function ShowPinForThisClassQuest( quests, level, forceCheck )

	if level then if level > ( UnitLevel( "player" ) + 1 ) then return false end end
	if forceCheck == false and ns.db.hideIfRuneLearnt == false then return true end

	if not HandyNotes_RunesDB then return true end -- too soon for the server
	if HandyNotes_RunesDB.questsDone == nil then HandyNotes_RunesDB.questsDone = {} end
	if HandyNotes_RunesDB.questsDone[ ns.class ] == nil then HandyNotes_RunesDB.questsDone[ ns.class ] = {} end
	if HandyNotes_RunesDB.questsDone[ ns.class ].quests == nil then HandyNotes_RunesDB.questsDone[ ns.class ].quests = {} end

	local completed = false
	
	if type( quests ) == "table" then
		for j,w in ipairs( quests ) do
			if w > 0 then
				if HandyNotes_RunesDB.questsDone[ ns.class ].quests[ w ] then
					completed = true
				else
					completed = IsQuestFlaggedCompleted( w )
					if completed == true then
						HandyNotes_RunesDB.questsDone[ ns.class ].quests[ w ] = true
					else
						return true
					end
				end
			end
		end
		return false
	elseif ( type( quests ) == "number" ) and ( quests > 0 ) then
		if HandyNotes_RunesDB.questsDone[ ns.class ].quests[ quests ] then
			return false
		end
		completed = IsQuestFlaggedCompleted( quests )
		if completed == true then
			HandyNotes_RunesDB.questsDone[ ns.class ].quests[ quests ] = true
			return false
		end
		return true
	else
		return false
	end
end

local function ShowPinForThisClassSpell( spell, forceCheck ) -- English language spell from the Data file

	if forceCheck == false and ns.db.hideIfRuneLearnt == false then return true end

	if not HandyNotes_RunesDB then return true end -- too soon for the server
	if HandyNotes_RunesDB.runesKnown == nil then HandyNotes_RunesDB.runesKnown = {} end
	if HandyNotes_RunesDB.runesKnown[ ns.class ] == nil then HandyNotes_RunesDB.runesKnown[ ns.class ] = {} end
	if HandyNotes_RunesDB.runesKnown[ ns.class ].spells == nil then HandyNotes_RunesDB.runesKnown[ ns.class ].spells = {} end

	if HandyNotes_RunesDB.runesKnown[ ns.class ].spells[ ns.L[ spell ] ] then
		return false
	end
	if not ns.runeCategories then
		C_Engraving.RefreshRunesList()
		ns.runeCategories = C_Engraving.GetRuneCategories( false, false ) -- returns 5, 7, 10 as of 1.15.0 (Chest/Legs/Hands)
		if ns.runeCategories == nil then return true end -- too soon for the server
		if #ns.runeCategories == 0 then return true end -- too soon for the server
	end
	for _,cat in ipairs( ns.runeCategories ) do
		local engravingData = GetRunesForCategory( cat, true )
		for _,ed in ipairs( engravingData ) do
			if ed.name == ns.L[ spell ] then -- It appears that ed.name is localised
				HandyNotes_RunesDB.runesKnown[ ns.class ].spells[ ns.L[ spell ] ] = true
				return false
			end
		end
	end
	return true
end

function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local completed, quests, questNames;
	local pin = ns.points[mapFile] and ns.points[mapFile][coord]
	local previousEntry, spaceBeforeQuests = false, false
	
	if pin == "Quick Start" then	
		for k,v in pairs( ns.runes ) do
			if k == ns.class then
				local completed;
				GameTooltip:SetText( ns.colour.class ..ns.classLocal .." QUICK START for " ..ns.name )
				for r,s in ipairs( v.spells ) do	
					completed = not ShowPinForThisClassSpell( s, true )
					GameTooltip:AddDoubleLine( ns.colour.prefix ..r .. ".  " ..ns.L[ s ] .."   (" ..v[s].level .."+)",
							( ( completed == true ) and ( "\124cFF00FF00" ..ns.L["Completed"] ) 
													or ( "\124cFFFF0000" ..ns.L["Not Completed"] ) )
							.."     " ..ns.slotColour[ v[s].slot ] ..ns.slotList[ v[s].slot ] )
					GameTooltip:AddLine( ns.colour.highlight ..v[s].rune )
					GameTooltip:AddLine( ns.colour.plaintext ..v[s].start )
				end
			end
		end

	else
		
		for i,v in ipairs( pin.class ) do

			if ( ns.class == v ) or ( v == "ALL" ) then
			
				-- Data will be typical rune spells or the new levelled quests type
			
				if not pin.level then			
					if previousEntry == true then GameTooltip:AddLine( "\n" ) end
					previousEntry = true
					GameTooltip:AddDoubleLine( ns.colour.prefix ..ns.L[ pin.spell[ i ] ] ..ns.colour.highlight .."\n(" 
												..ns.runes[ v ][ pin.spell[ i ] ].rune ..")",
												ns.colour.class ..ns.classLocal )
					GameTooltip:AddLine( ns.colour.highlight ..pin.name .."\n" )
				end
				
				-- Quests are listed as: (a) part of collecting the rune or (b) as a non-rune levelling guide
				-- If (a) then there must be a 1:1 spell and quest (single or table) for each class v
				-- If (b) then there must be a 1:1 quest (single or table) for each class v

				if pin.quest then
					-- Single quest for all classes is permitted. Always a table. Table within a table or number
					-- To avoid a class with no quest being given pin.quest[ 1 ], use {} - can't use nil 
					quests = ( pin.quest[ i ] ~= nil ) and pin.quest[ i ] or pin.quest[ 1 ]
					questsNames = ( pin.questName[ i ] ~= nil ) and pin.questName[ i ] or pin.questName[ 1 ]

					if type( quests ) == "table" then				
						-- Note that a class with a {} for quests will safely drop through here, thus not pulling in any quests
						for j,w in ipairs( quests ) do
							if pin.level then
								if previousEntry == false then
									previousEntry = true
									GameTooltip:AddDoubleLine( ns.colour.prefix ..pin.name, 
											ns.colour.highlight .."Level = " ..pin.level )
								end
							end
							if spaceBeforeQuests == false then GameTooltip:AddLine( "\n" ) end
							spaceBeforeQuests = true
							completed = IsQuestFlaggedCompleted( w )
							GameTooltip:AddDoubleLine( ns.colour.highlight ..questsNames[ j ],
									( completed == true ) and ( "\124cFF00FF00" ..ns.L["Completed"] .." (" ..ns.name ..")" )
									or ( "\124cFFFF0000" ..ns.L["Not Completed"] .." (" ..ns.name ..")" ) )
						end
					else
						if pin.level then
							if previousEntry == false then
								previousEntry = true
								GameTooltip:AddDoubleLine( ns.colour.prefix ..pin.name, 
										ns.colour.highlight .."Level = " ..pin.level )
							end
						end
						GameTooltip:AddLine( "\n" )
						completed = IsQuestFlaggedCompleted( quests )
						GameTooltip:AddDoubleLine( ns.colour.highlight ..questsNames,
								( completed == true ) and ( "\124cFF00FF00" ..ns.L["Completed"] .." (" ..ns.name ..")" ) 
									or ( "\124cFFFF0000" ..ns.L["Not Completed"] .." (" ..ns.name ..")" ) )
					end
				end
				
				if pin.level and ( ( previousEntry == true ) or ( pin.quest == nil ) ) or not pin.level then
					if previousEntry == false then
						GameTooltip:AddDoubleLine( ns.colour.prefix ..pin.name, 
								ns.colour.highlight .."Level = " ..pin.level )
					end
					if pin.tip then
						-- Table or string
						if type( pin.tip ) == "table" then
							if pin.tip[ i ] ~= nil then
								GameTooltip:AddLine( "\n" ..ns.colour.plaintext ..pin.tip[ i ] )
							end
						else
							-- Single tip for all classes is permitted
							GameTooltip:AddLine( "\n" ..ns.colour.plaintext ..pin.tip )
						end
					end
					
					if pin.guide then
						-- Single guide for all classes is permitted. Always a table
						GameTooltip:AddLine( "\n" ..ns.colour.highlight .."Guide\n\n" ..ns.colour.plaintext
									..( ( pin.guide[ i ] ~= nil ) and pin.guide[ i ] or pin.guide[ 1 ] ) )
					end
				end
			end
		end

		if ( ns.db.showCoords == true ) then
			local mX, mY = HandyNotes:getXY(coord)
			mX, mY = mX*100, mY*100
			GameTooltip:AddLine( ns.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
		end
	end
	
	GameTooltip:Show()
end

function pluginHandler:OnLeave()
	GameTooltip:Hide()
end

do	
	local function iterator(t, prev)
		if not t then return end
		local coord, pin = next(t, prev)

		while coord do		
			if pin == "Quick Start" then
				for k,v in pairs( ns.runes ) do
					if k == ns.class then
						return coord, nil, ns.textures[ ns.db.iconChoice ],
							ns.db.iconScale * ns.scaling[ ns.db.iconChoice ] * 2, ns.db.iconAlpha
					end
				end
			else
				-- class and spell are aways 1:1 with indexing/existence
				-- BUT... I added quest help with no spells
				for i,v in ipairs( pin.class ) do
					if ( ns.class == v ) or ( v == "ALL" ) then
						if ( pin.faction == nil ) or ( pin.faction == ns.faction ) then
							if pin.spell then
								-- Note that if here then by design I don't check for player level
								-- This so that players can see all "upcoming" spells/runes
								-- pin.spell is English language
								if ShowPinForThisClassSpell( pin.spell[ i ], false ) then
									if pin.alsoTestQuest then
										-- Added to support Mage book partial completion. Maybe other stuff in the future
										-- Terrible field name. Can't think of better tbh
										if ShowPinForThisClassQuest( pin.quest[ i ], pin.level, false ) then
											return coord, nil, ns.texturesNum ..tostring( ns.runes[ v ][ pin.spell[ i ] ].icon ) .."-" 
												..ns.texturesNumCode[ ns.db[ "icon" ..tostring( ns.runes[ v ][ pin.spell[ i ] ].icon ) ] ],
												ns.db.iconScale * ns.scalingNum, ns.db.iconAlpha
										end
									else
										return coord, nil, ns.texturesNum ..tostring( ns.runes[ v ][ pin.spell[ i ] ].icon ) .."-" 
											..ns.texturesNumCode[ ns.db[ "icon" ..tostring( ns.runes[ v ][ pin.spell[ i ] ].icon ) ] ],
											ns.db.iconScale * ns.scalingNum, ns.db.iconAlpha
									end
								end
							elseif pin.quest then
								-- Quests that are separate from runes. Priest L17 quest comes to mind
								if ShowPinForThisClassQuest( pin.quest[ i ], pin.level, false ) then
									return coord, nil, ns.textures[ ns.db.iconChoice ],
										ns.db.iconScale * ns.scaling[ ns.db.iconChoice ], ns.db.iconAlpha
								end
							elseif pin.level then
								-- Void Touched gear guide, for example
								if pin.level <= ( UnitLevel( "player" ) + 1 ) then
									return coord, nil, ns.textures[ ns.db.iconChoice ],
										ns.db.iconScale * ns.scaling[ ns.db.iconChoice ], ns.db.iconAlpha
								end
							end
						end
					end
				end
			end
			coord, pin = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		return iterator, ns.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> Runes options
ns.options = {
	type = "group",
	name = "Runes",
	desc = ns.L["AddOn Description"],
	get = function(info) return ns.db[info[#info]] end,
	set = function(info, v)
		ns.db[info[#info]] = v
		pluginHandler:Refresh()
	end,
	args = {
		options = {
			type = "group",
			name = " " ..ns.L["Options"],
			inline = true,
			args = {
				iconScale = {
					type = "range",
					name = ns.L["Map Pin Size"],
					desc = ns.L["The Map Pin Size"],
					min = 1, max = 4, step = 0.1,
					arg = "iconScale",
					order = 1,
				},
				iconAlpha = {
					type = "range",
					name = ns.L["Map Pin Alpha"],
					desc = ns.L["The alpha transparency of the map pins"],
					min = 0, max = 1, step = 0.01,
					arg = "iconAlpha",
					order = 2,
				},
				showCoords = {
					type = "toggle",
					name = ns.L["Show Coordinates"],
					desc = ns.L["Show Coordinates Description"] 
							..ns.colour.highlight .."(xx.xx,yy.yy)",
					width = "full",
					arg = "showCoords",
					order = 3,
				},
				hideIfRuneLearnt = {
					name = "Hide if the rune spell was learnt",
					desc = "Will also hide copmpleted Icy Veins books (Mages)",
					type = "toggle",
					width = "full",
					arg = "hideIfRuneLearnt",
					order = 4,
				},
			},
		},
		icon = {
			type = "group",
			name = ns.L["Map Pin Selections"],
			inline = true,
			args = {
				icon1 = {
					type = "range",
					name = "Icon 1",
					desc = "1 = Cyan on Black 1\n2 = Green on Black 1\n3 = Magenta on Black 1"
							.."\n4 = Red on Black 1\n5 = Yellow on Black 1",
					min = 1, max = 5, step = 1,
					arg = "icon1",
					order = 5,
				},
				icon2 = {
					type = "range",
					name = "Icon 2",
					desc = "1 = Cyan on Black 2\n2 = Green on Black 2\n3 = Magenta on Black 2"
							.."\n4 = Red on Black 2\n5 = Yellow on Black 2",
					min = 1, max = 5, step = 1,
					arg = "icon2",
					order = 6,
				},
				icon3 = {
					type = "range",
					name = "Icon 3",
					desc = "1 = Cyan on Black 3\n2 = Green on Black 3\n3 = Magenta on Black 3"
							.."\n4 = Red on Black 3\n5 = Yellow on Black 3",
					min = 1, max = 5, step = 1,
					arg = "icon3",
					order = 7,
				},
				icon4 = {
					type = "range",
					name = "Icon 4",
					desc = "1 = Cyan on Black 4\n2 = Green on Black 4\n3 = Magenta on Black 4"
							.."\n4 = Red on Black 4\n5 = Yellow on Black 4",
					min = 1, max = 5, step = 1,
					arg = "icon4",
					order = 8,
				},
				icon5 = {
					type = "range",
					name = "Icon 5",
					desc = "1 = Cyan on Black 5\n2 = Green on Black 5\n3 = Magenta on Black 5"
							.."\n4 = Red on Black 5\n5 = Yellow on Black 5",
					min = 1, max = 5, step = 1,
					arg = "icon5",
					order = 9,
				},
				icon6 = {
					type = "range",
					name = "Icon 6",
					desc = "1 = Cyan on Black 6\n2 = Green on Black 6\n3 = Magenta on Black 6"
							.."\n4 = Red on Black 6\n5 = Yellow on Black 6",
					min = 1, max = 5, step = 1,
					arg = "icon6",
					order = 10,
				},
				icon7 = {
					type = "range",
					name = "Icon 7",
					desc = "1 = Cyan on Black 7\n2 = Green on Black 7\n3 = Magenta on Black 7"
							.."\n4 = Red on Black 7\n5 = Yellow on Black 7",
					min = 1, max = 5, step = 1,
					arg = "icon7",
					order = 11,
				},
				icon8 = {
					type = "range",
					name = "Icon 8",
					desc = "1 = Cyan on Black 8\n2 = Green on Black 8\n3 = Magenta on Black 8"
							.."\n4 = Red on Black 8\n5 = Yellow on Black 8",
					min = 1, max = 5, step = 1,
					arg = "icon8",
					order = 12,
				},
				icon9 = {
					type = "range",
					name = "Icon 9",
					desc = "1 = Cyan on Black 9\n2 = Green on Black 9\n3 = Magenta on Black 9"
							.."\n4 = Red on Black 9\n5 = Yellow on Black 9",
					min = 1, max = 5, step = 1,
					arg = "icon9",
					order = 13,
				},
				icon10 = {
					type = "range",
					name = "Icon 10",
					desc = "1 = Cyan on Black 10\n2 = Green on Black 10\n3 = Magenta on Black 10"
							.."\n4 = Red on Black 10\n5 = Yellow on Black 10",
					min = 1, max = 5, step = 1,
					arg = "icon10",
					order = 14,
				},
				icon11 = {
					type = "range",
					name = "Icon 11",
					desc = "1 = Cyan on Black 11\n2 = Green on Black 11\n3 = Magenta on Black 11"
							.."\n4 = Red on Black 11\n5 = Yellow on Black 11",
					min = 1, max = 5, step = 1,
					arg = "icon11",
					order = 15,
				},
				icon12 = {
					type = "range",
					name = "Icon 12",
					desc = "1 = Cyan on Black 12\n2 = Green on Black 12\n3 = Magenta on Black 12"
							.."\n4 = Red on Black 12\n5 = Yellow on Black 12",
					min = 1, max = 5, step = 1,
					arg = "icon12",
					order = 16,
				},
				iconChoice = {
					type = "range",
					name = "Quick Start / Summary",					
					desc = "1 = " ..ns.L["White"] .."\n2 = " ..ns.L["Purple"] .."\n3 = " ..ns.L["Red"] .."\n4 = " 
							..ns.L["Yellow"] .."\n5 = " ..ns.L["Green"] .."\n6 = " ..ns.L["Grey"] .."\n7 = " ..ns.L["Mana Orb"]
							.."\n8 = " ..ns.L["Phasing"] .."\n9 = " ..ns.L["Raptor egg"] .."\n10 = " ..ns.L["Stars"]
							.."\n11 = " ..ns.L["Cogwheel"] .."\n12 = " ..ns.L["Frost"] .."\n13 = " ..ns.L["Diamond"]
							.."\n14 = " ..ns.L["Screw"] .."\n15 = " ..ns.L["Mjolnir"] .."\n16 = " ..ns.L["Arcane"] 
							.."\n17= " ..ns.L["Demonic"] .."\n18 = " ..ns.L["Duty"],
					min = 1, max = 18, step = 1,
					arg = "iconChoice",
					order = 17,
				},
			},
		},
	},
}

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	
	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
			if coords then
				for coord, pin in next, coords do
					local function AddToContinent()
						local mx, my = HandyNotes:getXY(coord)
						local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
						if cx and cy then
							ns.points[continentMapID] = ns.points[continentMapID] or {}
							ns.points[continentMapID][HandyNotes:getCoord(cx, cy)] = pin
						end
					end
					-- Very basic delimiting which doesn't require saved player options and also will never change
					for i,v in ipairs( pin.class ) do
						if ( ns.class == v ) or ( v == "ALL" ) then
							if ( pin.faction == nil ) or ( pin.faction == ns.faction ) then
								AddToContinent()
							end
						end
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB("Runes", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_RunesDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "Runes")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_RunesDB", "AceEvent-3.0")