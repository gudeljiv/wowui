-------------------------------
--NovaConsumesHelper Options--
-------------------------------
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local addonName, NCH = ...;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaConsumesHelper");
local GetItemCount = C_Item.GetItemCount;

NCH.options = {
	name =  "",
	handler = NCH,
	type = 'group',
	args = {
		titleText = {
			type = "description",
			name = "        " .. NCH.prefixColor .. "NovaConsumesHelper (v" .. string.format("%.2f", NCH.version) .. ")",
			fontSize = "large",
			order = 1,
		},
		authorText = {
			type = "description",
			name = "|TInterface\\Icons\\inv_potion_62:32:32:0:20|t |cFF9CD6DEby Novaspark-Arugal|r  |cFF00C800-|r  |cFFFFFF00For help or suggestions discord.gg/RTKMfTmkdj|r",
			fontSize = "medium",
			order = 2,
		},
		lockAllFrames = {
			type = "toggle",
			name = "|cFF3CE13F" .. L["lockAllFramesTitle"],
			desc = L["lockAllFramesDesc"],
			order = 3,
			get = "getLockAllFrames",
			set = "setLockAllFrames",
		},
		general = {
			name = "Consumes",
			desc = "Main options.",
			type = "group",
			order = 3,
			args = {
				consumesListHeader = {
					type = "header",
					name = "|cFF00FF00" .. L["consumesListDesc"],
					order = 99,
				},
			},
		},
		displayOptions = {
			name = "Display Options",
			desc = "Change how the buttons are displayed.",
			type = "group",
			order = 4,
			args = {			
				generalOptionsHeader = {
					type = "header",
					name = "|cFF00FF00" .. L["generalOptionsDesc"],
					order = 180,
				},
				hideWhenBuffed = {
					type = "toggle",
					name = L["hideWhenBuffedTitle"],
					desc = L["hideWhenBuffedDesc"],
					order = 182,
					set = function(info, value)
						NCH.db.global.hideWhenBuffed = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.hideWhenBuffed;
					end,
					width = 1.2,
				},
				loadEverywhere = {
					type = "toggle",
					name = L["loadEverywhereTitle"],
					desc = L["loadEverywhereDesc"],
					order = 183,
					set = function(info, value)
						NCH.db.global.loadEverywhere = value;
						NCH:updateConsumesVisibility();
					end,
					get = function()
						return NCH.db.global.loadEverywhere;
					end,
				},
				loadInDungeons = {
					type = "toggle",
					name = L["loadInDungeonsTitle"],
					desc = L["loadInDungeonsDesc"],
					order = 184,
					set = function(info, value)
						NCH.db.global.loadInDungeons = value;
						NCH:updateConsumesVisibility();
					end,
					get = function()
						return NCH.db.global.loadInDungeons;
					end,
					width = 1.2,
				},
				loadInRaids = {
					type = "toggle",
					name = L["loadInRaidsTitle"],
					desc = L["loadInRaidsDesc"],
					order = 185,
					set = function(info, value)
						NCH.db.global.loadInRaids = value;
						NCH:updateConsumesVisibility();
					end,
					get = function()
						return NCH.db.global.loadInRaids;
					end,
				},
				loadInRaidGroup = {
					type = "toggle",
					name = L["loadInRaidGroupTitle"],
					desc = L["loadInRaidGroupDesc"],
					order = 186,
					set = function(info, value)
						NCH.db.global.loadInRaidGroup = value;
						NCH:updateConsumesVisibility();
					end,
					get = function()
						return NCH.db.global.loadInRaidGroup;
					end,
					width = 1.2,
				},
				loadInPartyGroup = {
					type = "toggle",
					name = L["loadInPartyGroupTitle"],
					desc = L["loadInPartyGroupDesc"],
					order = 187,
					set = function(info, value)
						NCH.db.global.loadInPartyGroup = value;
						NCH:updateConsumesVisibility();
					end,
					get = function()
						return NCH.db.global.loadInPartyGroup;
					end,
					width = 1.2,
				},
				loadInBattlegrounds = {
					type = "toggle",
					name = L["loadInBattlegroundsTitle"],
					desc = L["loadInBattlegroundsDesc"],
					order = 188,
					set = function(info, value)
						NCH.db.global.loadInBattlegrounds = value;
						NCH:updateConsumesVisibility();
					end,
					get = function()
						return NCH.db.global.loadInBattlegrounds;
					end,
					width = 1.2,
				},
				loadInArena = {
					type = "toggle",
					name = L["loadInArenaTitle"],
					desc = L["loadInArenaDesc"],
					order = 189,
					set = function(info, value)
						NCH.db.global.loadInArena = value;
						NCH:updateConsumesVisibility();
					end,
					get = function()
						return NCH.db.global.loadInArena;
					end,
					width = 1.2,
				},
				lowDurationThreshold = {
					type = "range",
					name = L["lowDurationThresholdTitle"],
					desc = L["lowDurationThresholdDesc"],
					order = 191,
					set = function(info, value)
						NCH.db.global.lowDurationThreshold = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.lowDurationThreshold;
					end,
					min = 10,
					max = 1800,
					softMin = 10,
					softMax = 1800,
					step = 1,
					width = 1.2,
				},
				alwaysShowDuration = {
					type = "toggle",
					name = L["alwaysShowDurationTitle"],
					desc = L["alwaysShowDurationDesc"],
					order = 192,
					set = function(info, value)
						NCH.db.global.alwaysShowDuration = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.alwaysShowDuration;
					end,
					width = 1.2,
				},
				showTooltips = {
					type = "toggle",
					name = L["showTooltipsTitle"],
					desc = L["showTooltipsDesc"],
					order = 193,
					set = function(info, value)
						NCH.db.global.showTooltips = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.showTooltips;
					end,
					width = 1.2,
				},
				disableMenuBar = {
					type = "toggle",
					name = L["disableMenuBarTitle"],
					desc = L["disableMenuBarDesc"],
					order = 194,
					set = function(info, value)
						NCH.db.global.disableMenuBar = value;
						NCH:updateConfigOptions();
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.disableMenuBar;
					end,
					width = 1.2,
				},
				disableStateAutomation = {
					type = "toggle",
					name = L["disableStateAutomationTitle"],
					desc = L["disableStateAutomationDesc"],
					order = 195,
					set = function(info, value)
						NCH.db.global.disableStateAutomation = value;
						NCH:updateConfigOptions();
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.disableStateAutomation;
					end,
					width = 1.2,
				},
				buttonSize = {
					type = "range",
					name = L["buttonSizeTitle"],
					desc = L["buttonSizeDesc"],
					order = 196,
					set = function(info, value)
						NCH.db.global.buttonSize = value;
						NCH:updateConsumesFrameSize();
					end,
					get = function()
						return NCH.db.global.buttonSize;
					end,
					min = 22,
					max = 80,
					softMin = 22,
					softMax = 80,
					step = 1,
					width = 1.2,
				},
				buttonsWide = {
					type = "range",
					name = L["buttonsWideTitle"],
					desc = L["buttonWideDesc"],
					order = 197,
					set = function(info, value)
						NCH.db.global.buttonsWide = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.buttonsWide;
					end,
					min = 1,
					max = 20,
					softMin = 1,
					softMax = 20,
					step = 1,
					width = 1.2,
				},
				padding = {
					type = "range",
					name = L["paddingTitle"],
					desc = L["paddingDesc"],
					order = 198,
					set = function(info, value)
						NCH.db.global.padding = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.padding;
					end,
					min = 1,
					max = 10,
					softMin = 1,
					softMax = 10,
					step = 1,
					width = 1.2,
				},
				showLabels = {
					type = "toggle",
					name = L["showLabelsTitle"],
					desc = L["showLabelsDesc"],
					order = 202,
					set = function(info, value)
						NCH.db.global.showLabels = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.showLabels;
					end,
				},
				showItemCount = {
					type = "toggle",
					name = L["showItemCountTitle"],
					desc = L["showItemCountDesc"],
					order = 205,
					set = function(info, value)
						NCH.db.global.showItemCount = value;
						NCH:updateConfigOptions();
						if (not value) then
							NCH:hideAllItemCounts();
						else
							NCH:updateConsumesFrame();
						end
					end,
					get = function()
						return NCH.db.global.showItemCount;
					end,
					width = 1.2,
				},
				showItemCountWhenBuffed = {
					type = "toggle",
					name = L["showItemCountWhenBuffedTitle"],
					desc = L["showItemCountWhenBuffedDesc"],
					order = 206,
					set = function(info, value)
						NCH.db.global.showItemCountWhenBuffed = value;
						NCH:updateConfigOptions();
						if (not value) then
							NCH:hideAllItemCounts();
						else
							NCH:updateConsumesFrame();
						end
					end,
					get = function()
						return NCH.db.global.showItemCountWhenBuffed;
					end,
					width = 1.2,
				},
				hideWhenNoItems = {
					type = "toggle",
					name = L["hideWhenNoItemsTitle"],
					desc = L["hideWhenNoItemsDesc"],
					order = 207,
					set = function(info, value)
						NCH.db.global.hideWhenNoItems = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.hideWhenNoItems;
					end,
					width = 1.2,
				},
				hideUniqueItems = {
					type = "toggle",
					name = L["hideUniqueTitle"],
					desc = L["hideUniqueDesc"],
					order = 208,
					set = function(info, value)
						NCH.db.global.hideUniqueItems = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.hideUniqueItems;
					end,
					width = 1.2,
				},
				hideX = {
					type = "toggle",
					name = L["hideXTitle"],
					desc = L["hideXDesc"],
					order = 209,
					set = function(info, value)
						NCH.db.global.hideX = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.hideX;
					end,
					width = 1.2,
				},
				inverseDesaturate = {
					type = "toggle",
					name = L["inverseDesaturateTitle"],
					desc = L["inverseDesaturateDesc"],
					order = 210,
					set = function(info, value)
						NCH.db.global.inverseDesaturate = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.inverseDesaturate;
					end,
					width = 1.2,
				},
				alpha = {
					type = "range",
					name = L["alphaTitle"],
					desc = L["alphaDesc"],
					order = 21109,
					set = function(info, value)
						NCH.db.global.alpha = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.alpha;
					end,
					min = 0.05,
					max = 1,
					softMin = 0.1,
					softMax = 1,
					step = 0.05,
					width = 1.2,
				},
				desaturateAlpha = {
					type = "range",
					name = L["desaturateAlphaTitle"],
					desc = L["desaturateAlphaDesc"],
					order = 212,
					set = function(info, value)
						NCH.db.global.desaturateAlpha = value;
						NCH:updateConfigOptions();
					end,
					get = function()
						return NCH.db.global.desaturateAlpha;
					end,
					min = 0.05,
					max = 1,
					softMin = 0.1,
					softMax = 1,
					step = 0.05,
					width = 1.2,
				},
				borderAnimation = {
					type = "select",
					name = L["borderAnimationTitle"],
					desc = L["borderAnimationDesc"],
					values = {
						[1] = "Simple",
						[2] = "Bright",
						[3] = "None",
					},
					sorting = {
						[1] = 1,
						[2] = 2,
						[3] = 3,
					},
					order = 216,
					set = function(info, value)
						NCH.db.global.borderAnimation = value;
						NCH:updateConfigOptions();
						NCH:updateAllGlows();
					end,
					get = function()
						return NCH.db.global.borderAnimation;
					end,
					width = 1.2,
				},
				minimapButton = {
					type = "toggle",
					name = L["minimapButtonTitle"],
					desc = L["minimapButtonDesc"],
					order = 217,
					set = function(info, value)
						NCH.db.global.minimapButton = value;
						if (value) then
							--MinimapButtonBag addon breaks these Show/Hide funcs.
							NCH.LDBIcon:Show("NovaConsumesHelper");
							NCH.db.global.minimapIcon.hide = false;
						else
							NCH.LDBIcon:Hide("NovaConsumesHelper");
							NCH.db.global.minimapIcon.hide = true;
						end
					end,
					get = function()
						return NCH.db.global.minimapButton;
					end,
					width = 1.2,
				},
				minLevel = {
					type = "range",
					name = L["minLevelTitle"],
					desc = L["minLevelDesc"],
					order = 220,
					set = function(info, value)
						NCH.db.global.minLevel = value;
						NCH:updateConfigOptions();
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.minLevel;
					end,
					min = 1,
					max = GetMaxPlayerLevel(),
					softMin = 1,
					softMax = GetMaxPlayerLevel(),
					step = 1,
					width = 1.2,
				},
				growthDirection = {
					type = "select",
					name = L["growthDirectionTitle"],
					desc = L["growthDirectionDesc"],
					values = {
						[1] = "Down",
						[2] = "Up",
					},
					sorting = {
						[1] = 1,
						[2] = 2,
					},
					order = 221,
					set = function(info, value)
						NCH.db.global.growthDirection = value;
						NCH:updateConfigOptions();
						NCH:resetAllButtonPoints();
					end,
					get = function()
						return NCH.db.global.growthDirection;
					end,
					width = 1.2,
				},
				hideInCapitalCity = {
					type = "toggle",
					name = L["hideInCapitalCityTitle"],
					desc = L["hideInCapitalCityDesc"],
					order = 222,
					set = function(info, value)
						NCH.db.global.hideInCapitalCity = value;
						NCH:updateConfigOptions();
						NCH:updateConsumesVisibility();
					end,
					get = function()
						return NCH.db.global.hideInCapitalCity;
					end,
				},
				--[[loadClassSpecPreset = {
					type = "select",
					name = L["loadClassSpecPresetTitle"],
					desc = L["loadClassSpecPresetDesc"],
					values = {
						["DRUID_BALANCE"] = "Druid - Balance |TInterface\\Icons\\Spell_Nature_StarFall:14:14|t",
					},
					sorting = {
						[1] = "DRUID_BALANCE",
					},
					order = 11,
					set = function(info, value)
						NCH.db.global.loadClassSpecPreset = value;
					end,
					get = function()
						return NCH.db.global.loadClassSpecPreset;
					end,
				},]]
				
				--[[consumesSlot1 = {
					type = "select",
					name = L["consumesSlot1Title"],
					desc = L["consumesSlot1Desc"],
					values = getConsumesList(1),
					sorting = getConsumesListOrder(1),
					order = 100,
					set = function(info, value)
						NCH.db.global.consumesSlot1 = value;
						NCH:loadConsumesData();
					end,
					get = function()
						return NCH.db.global.consumesSlot1;
					end,
				},]]
				resetFramePosition = {
					type = "execute",
					name = L["resetFramePositionTitle"];
					desc = L["resetFramePositionDesc"],
					func = function()
						NCH:resetFramePosition();
					end,
					order = 500,
					--confirm = function()
					--	return "|cFFFFFF00" .. L["resetFramePositionConfirm"];
					--end,
				},
			},
		},
		
		
		
		
		
		
		
		
		
		
		protection = {
			name = "Protection Potions",
			desc = "Main options.",
			type = "group",
			order = 6,
			args = {
				--[[protListHeader = {
					type = "header",
					name = "|cFF00FF00" .. L["protListDesc"],
					order = 98,
				},]]
				greaterListHeader = {
					type = "header",
					name = "|cFFFFFF00" .. L["greaterProtListDesc"],
					order = 99,
				},
				protShowGreaterArcane = {
					type = "toggle",
					name = "|T134863:20:20|t " .. L["protShowGreaterArcaneTitle"],
					desc = L["protShowGreaterArcaneDesc"],
					order = 120,
					set = function(info, value)
						NCH.db.global.protShowGreaterArcane = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowGreaterArcane;
					end,
					width = 1.2,
				},
				protShowGreaterFire = {
					type = "toggle",
					name = "|T134804:20:20|t " .. L["protShowGreaterFireTitle"],
					desc = L["protShowGreaterFireDesc"],
					order = 121,
					set = function(info, value)
						NCH.db.global.protShowGreaterFire = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowGreaterFire;
					end,
					width = 1.2,
				},
				protShowGreaterFrost = {
					type = "toggle",
					name = "|T134800:20:20|t " .. L["protShowGreaterFrostTitle"],
					desc = L["protShowGreaterFrostDesc"],
					order = 122,
					set = function(info, value)
						NCH.db.global.protShowGreaterFrost = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowGreaterFrost;
					end,
					width = 1.2,
				},
				protShowGreaterNature = {
					type = "toggle",
					name = "|T134802:20:20|t " .. L["protShowGreaterNatureTitle"],
					desc = L["protShowGreaterNatureDesc"],
					order = 123,
					set = function(info, value)
						NCH.db.global.protShowGreaterNature = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowGreaterNature;
					end,
					width = 1.2,
				},
				protShowGreaterShadow = {
					type = "toggle",
					name = "|T134803:20:20|t " .. L["protShowGreaterShadowTitle"],
					desc = L["protShowGreaterShadowDesc"],
					order = 124,
					set = function(info, value)
						NCH.db.global.protShowGreaterShadow = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowGreaterShadow;
					end,
					width = 1.2,
				},
				protShowGreaterHoly = {
					type = "toggle",
					name = "|T134803:20:20|t " .. L["protShowGreaterHolyTitle"],
					desc = L["protShowGreaterHolyDesc"],
					order = 125,
					set = function(info, value)
						NCH.db.global.protShowGreaterHoly = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowGreaterHoly;
					end,
					width = 1.2,
				},
				protShowFrozenRune = {
					type = "toggle",
					name = "|T134422:20:20|t " .. L["protShowFrozenRuneTitle"],
					desc = L["protShowFrozenRuneDesc"],
					order = 126,
					set = function(info, value)
						NCH.db.global.protShowFrozenRune = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowFrozenRune;
					end,
					width = 1.2,
				},
				lesserListHeader = {
					type = "header",
					name = "|cFFFFFF00" .. L["lesserProtListDesc"],
					order = 129,
				},
				protShowFire = {
					type = "toggle",
					name = "|T134787:20:20|t " .. L["protShowFireTitle"],
					desc = L["protShowFireDesc"],
					order = 130,
					set = function(info, value)
						NCH.db.global.protShowFire = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowFire;
					end,
					width = 1.2,
				},
				protShowFrost = {
					type = "toggle",
					name = "|T134754:20:20|t " .. L["protShowFrostTitle"],
					desc = L["protShowFrostDesc"],
					order = 131,
					set = function(info, value)
						NCH.db.global.protShowFrost = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowFrost;
					end,
					width = 1.2,
				},
				protShowNature = {
					type = "toggle",
					name = "|T134717:20:20|t " .. L["protShowNatureTitle"],
					desc = L["protShowNatureDesc"],
					order = 132,
					set = function(info, value)
						NCH.db.global.protShowNature = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowNature;
					end,
					width = 1.2,
				},
				protShowShadow = {
					type = "toggle",
					name = "|T134824:20:20|t " .. L["protShowShadowTitle"],
					desc = L["protShowShadowDesc"],
					order = 133,
					set = function(info, value)
						NCH.db.global.protShowShadow = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowShadow;
					end,
					width = 1.2,
				},
				protShowHoly = {
					type = "toggle",
					name = "|T134720:20:20|t " .. L["protShowHolyTitle"],
					desc = L["protShowHolyDesc"],
					order = 134,
					set = function(info, value)
						NCH.db.global.protShowHoly = value;
						NCH:loadProtData();
					end,
					get = function()
						return NCH.db.global.protShowHoly;
					end,
					width = 1.2,
				},
				protOptionsHeader = {
					type = "header",
					name = "|cFF00FF00" .. L["protOptionsDesc"],
					order = 180,
				},
				--[[hideWhenBuffedProt = {
					type = "toggle",
					name = L["hideWhenBuffedTitle"],
					desc = L["hideWhenBuffedDesc"],
					order = 182,
					set = function(info, value)
						NCH.db.global.hideWhenBuffedProt = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.hideWhenBuffedProt;
					end,
					width = 1.2,
				},]]
				loadEverywhereProt = {
					type = "toggle",
					name = L["loadEverywhereTitle"],
					desc = L["loadEverywhereDesc"],
					order = 183,
					set = function(info, value)
						NCH.db.global.loadEverywhereProt = value;
						NCH:updateProtVisibility();
					end,
					get = function()
						return NCH.db.global.loadEverywhereProt;
					end,
					width = 1.2,
				},
				loadInDungeonsProt = {
					type = "toggle",
					name = L["loadInDungeonsTitle"],
					desc = L["loadInDungeonsDesc"],
					order = 184,
					set = function(info, value)
						NCH.db.global.loadInDungeonsProt = value;
						NCH:updateProtVisibility();
					end,
					get = function()
						return NCH.db.global.loadInDungeonsProt;
					end,
					width = 1.2,
				},
				loadInRaidsProt = {
					type = "toggle",
					name = L["loadInRaidsTitle"],
					desc = L["loadInRaidsDesc"],
					order = 185,
					set = function(info, value)
						NCH.db.global.loadInRaidsProt = value;
						NCH:updateProtVisibility();
					end,
					get = function()
						return NCH.db.global.loadInRaidsProt;
					end,
					width = 1.2,
				},
				loadInRaidGroupProt = {
					type = "toggle",
					name = L["loadInRaidGroupTitle"],
					desc = L["loadInRaidGroupDesc"],
					order = 186,
					set = function(info, value)
						NCH.db.global.loadInRaidGroupProt = value;
						NCH:updateProtVisibility();
					end,
					get = function()
						return NCH.db.global.loadInRaidGroupProt;
					end,
					width = 1.2,
				},
				loadInBattlegroundsProt = {
					type = "toggle",
					name = L["loadInBattlegroundsTitle"],
					desc = L["loadInBattlegroundsDesc"],
					order = 187,
					set = function(info, value)
						NCH.db.global.loadInBattlegroundsProt = value;
						NCH:updateProtVisibility();
					end,
					get = function()
						return NCH.db.global.loadInBattlegroundsProt;
					end,
					width = 1.2,
				},
				loadInPartyGroupProt = {
					type = "toggle",
					name = L["loadInPartyGroupTitle"],
					desc = L["loadInPartyGroupDesc"],
					order = 188,
					set = function(info, value)
						NCH.db.global.loadInPartyGroupProt = value;
						NCH:updateProtVisibility();
					end,
					get = function()
						return NCH.db.global.loadInPartyGroupProt;
					end,
					width = 1.2,
				},
				showTooltipsProt = {
					type = "toggle",
					name = L["showTooltipsTitle"],
					desc = L["showTooltipsDesc"],
					order = 193,
					set = function(info, value)
						NCH.db.global.showTooltipsProt = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.showTooltipsProt;
					end,
					width = 1.2,
				},
				buttonSizeProt = {
					type = "range",
					name = L["buttonSizeTitle"],
					desc = L["buttonSizeDesc"],
					order = 194,
					set = function(info, value)
						NCH.db.global.buttonSizeProt = value;
						NCH:updateProtFrameSize();
					end,
					get = function()
						return NCH.db.global.buttonSizeProt;
					end,
					min = 22,
					max = 80,
					softMin = 22,
					softMax = 80,
					step = 1,
					width = 1.2,
				},
				buttonsWideProt = {
					type = "range",
					name = L["buttonsWideTitle"],
					desc = L["buttonWideDesc"],
					order = 195,
					set = function(info, value)
						NCH.db.global.buttonsWideProt = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.buttonsWideProt;
					end,
					min = 1,
					max = 20,
					softMin = 1,
					softMax = 20,
					step = 1,
					width = 1.2,
				},
				paddingProt = {
					type = "range",
					name = L["paddingTitle"],
					desc = L["paddingDesc"],
					order = 196,
					set = function(info, value)
						NCH.db.global.paddingProt = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.paddingProt;
					end,
					min = 1,
					max = 10,
					softMin = 1,
					softMax = 10,
					step = 1,
					width = 1.2,
				},
				showLabelsProt = {
					type = "toggle",
					name = L["showLabelsTitle"],
					desc = L["showLabelsDesc"],
					order = 202,
					set = function(info, value)
						NCH.db.global.showLabelsProt = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.showLabelsProt;
					end,
					width = 1.2,
				},
				hideInCapitalCityProt = {
					type = "toggle",
					name = L["hideInCapitalCityTitle"],
					desc = L["hideInCapitalCityDesc"],
					order = 201,
					set = function(info, value)
						NCH.db.global.hideInCapitalCityProt = value;
						NCH:updateProtConfigOptions();
						NCH:updateProtVisibility();
					end,
					get = function()
						return NCH.db.global.hideInCapitalCityProt;
					end,
					width = 1.2,
				},
				showItemCountProt = {
					type = "toggle",
					name = L["showItemCountTitle"],
					desc = L["showItemCountDesc"],
					order = 205,
					set = function(info, value)
						NCH.db.global.showItemCountProt = value;
						NCH:updateProtConfigOptions();
						if (not value) then
							NCH:hideAllProtItemCounts();
						else
							NCH:updateProtFrame();
						end
					end,
					get = function()
						return NCH.db.global.showItemCountProt;
					end,
					width = 1.2,
				},
				hideWhenNoItemsProt = {
					type = "toggle",
					name = L["hideWhenNoItemsTitle"],
					desc = L["hideWhenNoItemsDesc"],
					order = 206,
					set = function(info, value)
						NCH.db.global.hideWhenNoItemsProt = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.hideWhenNoItemsProt;
					end,
					width = 1.2,
				},
				showProgressText = {
					type = "toggle",
					name = L["showProgressTextTitle"],
					desc = L["showProgressTextDesc"],
					order = 224,
					set = function(info, value)
						NCH.db.global.showProgressText = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.showProgressText;
					end,
					width = 1.2,
				},
				progressTextPosition = {
					type = "select",
					name = L["progressTextPositionTitle"],
					desc = L["progressTextPositionDesc"],
					values = {
						[1] = "Top",
						[2] = "Bottom",
					},
					sorting = {
						[1] = 1,
						[2] = 2,
					},
					order = 225,
					set = function(info, value)
						NCH.db.global.progressTextPosition = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.progressTextPosition;
					end,
					width = 1.2,
				},
				showProgressBar = {
					type = "toggle",
					name = L["showProgressBarTitle"],
					desc = L["showProgressBarDesc"],
					order = 226,
					set = function(info, value)
						NCH.db.global.showProgressBar = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.showProgressBar;
					end,
					width = 1.2,
				},
				progressBarPosition = {
					type = "select",
					name = L["progressBarPositionTitle"],
					desc = L["progressBarPositionDesc"],
					values = {
						[1] = "Top",
						[2] = "Bottom",
						[3] = "Middle",
					},
					sorting = {
						[1] = 1,
						[2] = 2,
						[3] = 3,
					},
					order = 227,
					set = function(info, value)
						NCH.db.global.progressBarPosition = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.progressBarPosition;
					end,
					width = 1.2,
				},
				colorizeTextBySchool = {
					type = "toggle",
					name = L["colorizeTextBySchoolTitle"],
					desc = L["colorizeTextBySchoolDesc"],
					order = 228,
					set = function(info, value)
						NCH.db.global.colorizeTextBySchool = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.colorizeTextBySchool;
					end,
					width = 1.2,
				},
				inverseDesaturateProt = {
					type = "toggle",
					name = L["inverseDesaturateTitle"],
					desc = L["inverseDesaturateDesc"],
					order = 229,
					set = function(info, value)
						NCH.db.global.inverseDesaturateProt = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.inverseDesaturateProt;
					end,
					width = 1.2,
				},
				alphaProt = {
					type = "range",
					name = L["alphaTitle"],
					desc = L["alphaDesc"],
					order = 230,
					set = function(info, value)
						NCH.db.global.alphaProt = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.alphaProt;
					end,
					min = 0.05,
					max = 1,
					softMin = 0.1,
					softMax = 1,
					step = 0.05,
					width = 1.2,
				},
				desaturateAlphaProt = {
					type = "range",
					name = L["desaturateAlphaTitle"],
					desc = L["desaturateAlphaDesc"],
					order = 231,
					set = function(info, value)
						NCH.db.global.desaturateAlphaProt = value;
						NCH:updateProtConfigOptions();
					end,
					get = function()
						return NCH.db.global.desaturateAlphaProt;
					end,
					min = 0.05,
					max = 1,
					softMin = 0.1,
					softMax = 1,
					step = 0.05,
					width = 1.2,
				},
				protAbsorbText = {
					type = "description",
					name = "|cFF9CD6DE" .. L["protAbsorbTextDesc"],
					fontSize = "medium",
					order = 235,
				},
			},
		},
	},
};

--Hide protection pot options after TBC.
if (not NCH.showProtectionPots) then
	NCH.options.args.protection = nil;
end

local function getConsumesList(num)
	local values = {["None"] = "|cFF9CD6DENone"}
	local data = NCH.slots[num];
	for k, v in ipairs(data) do
		local itemCountString = "";
		if (v.itemID) then
			local itemCount = GetItemCount(v.itemID, nil, true);
			if (itemCount and itemCount > 0) then
				--itemCountString = "|cFF9CD6DE(" .. itemCount .. ")|r ";
				itemCountString = "|cFFFFFF00(" .. itemCount .. ")|r ";
			end
		end
		values[v.name] = "|T" .. v.icon .. ":14:14|t " .. itemCountString .. v.name;
	end
	return values;
end

local function getConsumesListOrder(num)
	local values = {[1] = "None"}
	local data = NCH.slots[num];
	table.sort(data, function(a, b) return a.name < b.name end);
	for k, v in ipairs(data) do
		tinsert(values, v.name);
	end
	return values;
end

local function getConsumesListTitle(num)
	local data = NCH.slots[num];
	if (data) then
		return data.name;
	else
		return "<Title Error>";
	end
end

local function getConsumesListDesc(num, name)
	--[[local data = NCH.slots[num];
	if (data) then
		string.format(L["consumesSlotUniversalDesc"], data.name);
	else
		return "<Desc Error>";
	end]]
	if (strmatch(name, "Main Hand Oils") or strmatch(name, "Off Hand Oils")) then
		return "Will show rogue poisons and shaman imbues when logged on to those classes.";
	end
end

--slot is the data [slot] for the consumes table.
--configSlot is the slot number wqhere the config data is stored by te consumes table.
--These can be different for slots added later in this addon's life when new slots are added.
function NCH:loadConsumeSlotOptions()
	local ignoredSlots = {};
	if (NCH.expansionNum > 2) then
		ignoredSlots["Scroll 1"] = true;
		ignoredSlots["Scroll 2"] = true;
		ignoredSlots["Scroll 3"] = true;
	end
	if (NCH.expansionNum > 4) then
		--After cata just don't show options for any consume types that don't have data set in the db file.
		for k, v in pairs(NCH.slots) do
			local found;
			for k, v in ipairs(v) do
				--Doing it with ipairs becaus it has data (a title) even if empty, just not sequential data.
				found = true;
			end
			if (not found) then
				ignoredSlots[v.name] = true;
			end
		end
	end
	local startOffset = 100;
	for slot, slotData in ipairs(NCH.slots) do
		if (ignoredSlots[slotData.name]) then
			C_Timer.After(5, function()
				if (NCH.db.profile["consumesSlot" .. slot] and NCH.db.profile["consumesSlot" .. slot] ~= "None") then
					--If we upgrade to a new expansion and there's slots no longer displayed in config then reset the selected consume.
					NCH.db.profile["consumesSlot" .. slot] = "None";
					NCH:loadConsumesData();
				end
			end);
		else
			local configSlot = slotData.configSlot;
			local values = getConsumesList(slot);
			local sorting = getConsumesListOrder(slot);
			NCH.options.args.general.args["consumesSlot" .. slot] = {
				type = "select",
				name = L[getConsumesListTitle(slot)],
				desc = getConsumesListDesc(slot, slotData.name),
				values = values,
				sorting = sorting,
				order = startOffset,
				width = 1.2,
				set = function(info, value)
					NCH.config["consumesSlot" .. configSlot] = value;
					NCH:loadConsumesData();
				end,
				get = function()
					return NCH.config["consumesSlot" .. configSlot];
				end,
			};
			NCH.optionDefaults.profile["consumesSlot" .. configSlot] = "None";
			startOffset = startOffset + 1;
		end
	end
	NCH:setupExtraSlotOptions();
end

function NCH:setupExtraSlotOptions()
	--I added these extra slots later but I want them to display further down in the options menu as an "extra slots" thing.
	--So the display options are still slightly visible on the first page.
	NCH.options.args.general.args.extraSlotsHeader = {
		type = "header",
		name = "|cFF00FF00" .. L["extraSlotsDesc"],
		order = 600,
	};
	NCH.options.args.general.args.extraSlotsDesc = {
		type = "description",
		name = "|cFF9CD6DE" .. L["extraSlotsDesc2"],
		order = 601,
	};
	--Setp extra slot options order in the config window.
	local startSlot = 19; --Start slot on db file.
	local endSlot = 99; --End (highest) slot in db file.
	local startOrder = 611; --Start point in config options order.
	local ignoredSlots = {
		--Slots that don't get sent down to extra slots section and are instead displayed with the main consumes.
		[46] = true,
		[47] = true,
		[48] = true,
		[49] = true,
	};
	for i = startSlot, endSlot do
		if (NCH.slots[i] and NCH.options.args.general.args["consumesSlot" .. i] and not ignoredSlots[i]) then
			NCH.options.args.general.args["consumesSlot" .. i].order = startOrder;
			startOrder = startOrder + 1;
		end
	end
	--[[NCH.options.args.general.args.consumesSlot19.order = 611;
	NCH.options.args.general.args.consumesSlot20.order = 612;
	NCH.options.args.general.args.consumesSlot21.order = 613;
	NCH.options.args.general.args.consumesSlot22.order = 614;
	NCH.options.args.general.args.consumesSlot23.order = 615;
	NCH.options.args.general.args.consumesSlot24.order = 616;
	NCH.options.args.general.args.consumesSlot25.order = 617;
	NCH.options.args.general.args.consumesSlot26.order = 618;
	NCH.options.args.general.args.consumesSlot27.order = 619;
	NCH.options.args.general.args.consumesSlot28.order = 620;
	NCH.options.args.general.args.consumesSlot29.order = 621;
	NCH.options.args.general.args.consumesSlot30.order = 622;
	NCH.options.args.general.args.consumesSlot31.order = 623;
	NCH.options.args.general.args.consumesSlot32.order = 624;
	NCH.options.args.general.args.consumesSlot33.order = 625;
	NCH.options.args.general.args.consumesSlot34.order = 626;
	NCH.options.args.general.args.consumesSlot35.order = 627;
	NCH.options.args.general.args.consumesSlot36.order = 628;
	NCH.options.args.general.args.consumesSlot37.order = 629;
	NCH.options.args.general.args.consumesSlot38.order = 630;
	NCH.options.args.general.args.consumesSlot39.order = 631;
	NCH.options.args.general.args.consumesSlot40.order = 632;
	NCH.options.args.general.args.consumesSlot41.order = 633;
	NCH.options.args.general.args.consumesSlot42.order = 634;
	NCH.options.args.general.args.consumesSlot43.order = 635;
	NCH.options.args.general.args.consumesSlot44.order = 636;
	NCH.options.args.general.args.consumesSlot45.order = 637;
	--Short pots.
	--NCH.options.args.general.args.consumesSlot46.order = 638;
	--NCH.options.args.general.args.consumesSlot47.order = 639;
	--NCH.options.args.general.args.consumesSlot48.order = 640;
	--NCH.options.args.general.args.consumesSlot49.order = 641;
	NCH.options.args.general.args.consumesSlot50.order = 642;
	NCH.options.args.general.args.consumesSlot51.order = 643;
	NCH.options.args.general.args.consumesSlot52.order = 644;
	NCH.options.args.general.args.consumesSlot53.order = 645;
	NCH.options.args.general.args.consumesSlot54.order = 646;
	NCH.options.args.general.args.consumesSlot55.order = 647;
	NCH.options.args.general.args.consumesSlot56.order = 648;
	NCH.options.args.general.args.consumesSlot57.order = 649;]]
end

function NCH:resetConsumeSlotOptions()
	for _, slotData in ipairs(NCH.slots) do
		local slotNum = slotData.configSlot;
		NCH.config["consumesSlot" .. slotNum] = NCH.optionDefaults.profile["consumesSlot" .. slotNum];
	end
end

function NCH:loadExpansionOptions()
	if (NCH.isSOD) then
		NCH.options.args.protection.args.protShowGreaterHoly = {
			type = "toggle",
			name = "|T134720:20:20|t " .. L["protShowGreaterHolyTitle"],
			desc = L["protShowGreaterHolyDesc"],
			order = 125,
			set = function(info, value)
				NCH.db.global.protShowGreaterHoly = value;
				NCH:loadProtData();
			end,
			get = function()
				return NCH.db.global.protShowGreaterHoly;
			end,
			width = 1.2,
		};
	end
end

------------------------
--Load option defaults--
------------------------
NCH.optionDefaults = {
	global = {
		minimapIcon = {["minimapPos"] = 352, ["hide"] = false},
		minimapButton = true,
		minLevel = 1,
		lowDurationThreshold = 300,
		hideWhenBuffed = false,
		showLabels = true,
		loadInDungeons = false,
		loadInRaids = true,
		loadInBattlegrounds = false,
		loadInArena = false,
		loadEverywhere = true,
		loadInPartyGroup = false,
		loadInRaidGroup = true,
		buttonSize = 32,
		borderAnimation = 1,	
		showItemCount = true,
		showItemCountWhenBuffed = true,
		showBorderHighlight = true,
		padding = 2,
		growthDirection = 1,
		buttonsWide = 5,
		alwaysShowDuration = true,
		showTooltips = true,
		hideInCapitalCity = false,
		inverseDesaturate = false,
		lockAllFrames = false,
		alpha = 1,
		desaturateAlpha = 1,
		hideWhenNoItems = false,
		hideUniqueItems = false,
		disableMenuBar = false,
		
		enableProtFrame = true,
		protShowGreaterArcane = true,
		protShowGreaterFire = true,
		protShowGreaterFrost = true,
		protShowGreaterNature = true,
		protShowGreaterShadow = true,
		protShowFrozenRune = false,
		protShowArcane = false,
		protShowFire = false,
		protShowFrost = false,
		protShowNature = false,
		protShowShadow = false,
		protShowHoly = false,
		--hideWhenBuffedProt = false,
		showLabelsProt = false,
		loadInDungeonsProt = false,
		loadInRaidsProt = true,
		loadInBattlegroundsProt = false,
		loadEverywhereProt = true,
		loadInPartyGroupProt = false,
		loadInRaidGroupProt = true,
		buttonSizeProt = 32,	
		showItemCountProt = true,
		paddingProt = 2,
		growthDirectionProt = 1,
		showTooltipsProt = true,
		hideInCapitalCityProt = false,
		buttonsWideProt = 12,
		showProgressText = true,
		progressTextPosition = 1,
		showProgressBar = true,
		progressBarPosition = 1,
		inverseDesaturateProt = false,
		alphaProt = 1,
		desaturateAlphaProt = 1,
		hideWhenNoItemsProt = false,
		hideUniqueItemsProt = false,
		colorizeTextBySchool = true,
		
		buttonFont = STANDARD_TEXT_FONT;
		timerFontSize = 12;
		countFontSize = 12;
		labelFontSize = 12;
	},
	profile = {
		--These are set in NCH:loadConsumeSlotOptions().
		--[[consumesSlot1 = "Flask of Supreme Power",
		consumesSlot2 = "Flask of Supreme Power",
		consumesSlot3 = "Flask of Supreme Power",
		consumesSlot4 = "Flask of Supreme Power",
		consumesSlot5 = "Flask of Supreme Power",
		consumesSlot6 = "Flask of Supreme Power",
		consumesSlot7 = "Flask of Supreme Power",
		consumesSlot8 = "Flask of Supreme Power",
		consumesSlot9 = "Flask of Supreme Power",
		consumesSlot10 = "Flask of Supreme Power",
		consumesSlot11 = "Flask of Supreme Power",
		consumesSlot12 = "Flask of Supreme Power",
		consumesSlot13 = "Flask of Supreme Power",
		consumesSlot14 = "Flask of Supreme Power",
		consumesSlot15 = "Flask of Supreme Power",
		consumesSlot16 = "Flask of Supreme Power",
		consumesSlot17 = "Flask of Supreme Power",
		consumesSlot18 = "Flask of Supreme Power",]]
		
		--protSlot1 = "Greater Arcane Protection Potion",
		--protSlot2 = "Greater Fire Protection Potion",
		--protSlot3 = "Greater Frost Protection Potion",
		--protSlot4 = "Greater Nature Protection Potion",
		--protSlot5 = "Greater Shadow Protection Potion",
	},
};

if (NCH.isSOD) then
	NCH.optionDefaults.global.protShowGreaterHoly = true;
end

if (NCH.expansionNum > 4) then
	NCH.optionDefaults.global.lowDurationThreshold = 600;
end

--Load some preset consumes for each spec.
function NCH:loadClassDefaults()
	--Unfinished.
end

function NCH:loadDatabase()
	--NCH.db = LibStub("AceDB-3.0"):New("NCHdatabase", NCH.optionDefaults, "Default");
	NCH.db = LibStub("AceDB-3.0"):New("NCHdatabase", NCH.optionDefaults);
    NCH.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(NCH.db);
    NCH.profiles.order = 49;
    NCH.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(NCH.db);
    NCH.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("NovaConsumesHelper", "NovaConsumesHelper");
    LibStub("AceConfig-3.0"):RegisterOptionsTable("NovaConsumesHelper", NCH.options);
    
    if (not self.db.global.versions) then
		self.db.global.versions = {};
	end
	
	--Create realm and faction tables if they don't exist.
	--[[if (not self.db.global[NCH.realm]) then
		self.db.global[NCH.realm] = {};
	end
	if (not self.db.global[NCH.realm][NCH.faction]) then
		self.db.global[NCH.realm][NCH.faction] = {};
	end]]
	--local localizedClass, englishClass = UnitClass("player");
	--self.db.global[NCH.realm][NCH.faction].myChars[UnitName("player")].localizedClass = localizedClass;
	--self.db.global[NCH.realm][NCH.faction].myChars[UnitName("player")].englishClass = englishClass;
	--self.db.global[NCH.realm][NCH.faction].myChars[UnitName("player")].faction = UnitFactionGroup("player");

	--self.data = self.db.global[NCH.realm][NCH.faction];
	self.config = self.db.profile;
	self.db.RegisterCallback(NCH, "OnProfileChanged", "refreshConfig");
	self.db.RegisterCallback(NCH, "OnProfileCopied", "refreshConfig");
	self.db.RegisterCallback(NCH, "OnProfileReset", "refreshConfig");
	self.db.RegisterCallback(NCH, "OnRefresh", "loadConsumeSlotOptions");
	--This is how the lib checks to load, I wonder if there's a future proof way to detect dual spec active though?
	if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and C_Seasons.GetActiveSeason() ~= 2 and C_Seasons.GetActiveSeason() ~= 11 and C_Seasons.GetActiveSeason() ~= 12 then return end
	local LibDualSpec = LibStub("LibDualSpec-1.0");
	if (LibDualSpec) then
		LibDualSpec:EnhanceDatabase(NCH.db, "NovaConsumesHelper");
		LibDualSpec:EnhanceOptions(NCH.options.args.profiles, NCH.db);
	end
end

function NCH:refreshConfig(event, database, newProfileKey)
	self.config = database.profile;
	NCH:loadConsumesData();
end

local function loadNewVersionFrame(version, notes, title, icon, x, y)
 	if (not _G[addonName .. "UpdateNotesFrame"]) then
 		local frame = CreateFrame("Frame", _G[addonName .. "UpdateNotesFrame"], UIParent, "BackdropTemplate");
		frame:SetToplevel(true);
		frame:SetMovable(true);
		frame:EnableMouse(true);
		frame:SetUserPlaced(false);
		frame:SetFrameStrata("HIGH");
		frame:SetSize(500, 500);
		frame:SetPoint("TOP", UIParent, "CENTER", x, y);
		frame:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8x8",
			edgeFile = [[Interface/Buttons/WHITE8X8]],
			edgeSize = 1,
			insets = {top = 4, left = 4, bottom = 4, right = 4},
		});
		frame:SetBackdropColor(0, 0, 0, 1);
		frame:SetBackdropBorderColor(1, 1, 1, 0.5);
		frame.title = frame:CreateFontString("$parentFS", "ARTWORK");
		frame.title:SetFontObject(Game15Font);
		frame.title:SetPoint("TOP", 0, -8);
		frame.title2 = frame:CreateFontString("$parentFS", "ARTWORK");
		frame.title2:SetFontObject(Game15Font);
		frame.title2:SetPoint("TOP", 0, -24);
		frame.fs = frame:CreateFontString("$parentFS", "ARTWORK");
		frame.fs:SetFontObject(Game13Font);
		frame.fs:SetPoint("TOPLEFT", 15, -52);
		frame.fs:SetPoint("TOPRIGHT", -15, -52);
		frame.fs:SetJustifyH("LEFT");
		frame.texture = frame:CreateTexture(nil, "ARTWORK");
		--frame.texture:SetPoint("TOPLEFT", 10, -10);
		frame.texture:SetPoint("TOPRIGHT", frame.title, "TOPLEFT", -10, 0);
		frame.texture:SetSize(30, 30);
		frame.closeButton = CreateFrame("Button", "$parentClose", frame, "UIPanelCloseButton");
		frame.closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1);
		frame.closeButton:SetWidth(26);
		frame.closeButton:SetHeight(26);
		frame.closeButton:SetFrameLevel(15);
		frame.closeButton:SetScript("OnClick", function(self, arg)
			frame:Hide();
		end)
		frame:SetScript("OnMouseDown", function(self, button)
			if (button == "LeftButton" and not self.isMoving) then
				self:StartMoving();
				self.isMoving = true;
			end
		end)
		frame:SetScript("OnMouseUp", function(self, button)
			if (button == "LeftButton" and self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
				frame:SetUserPlaced(false);
			end
		end)
		frame:SetScript("OnHide", function(self)
			if (self.isMoving) then
				self:StopMovingOrSizing();
				self.isMoving = false;
			end
	end)
		_G[addonName .. "UpdateNotesFrame"] = frame;
 	end
 	local frame = _G[addonName .. "UpdateNotesFrame"];
 	frame.texture:SetTexture(icon);
 	frame.title:SetText("|cFFFFFF00" .. title);
	frame.title2:SetText("|cFF00FF00New in|r |cFFFF6900v" .. string.format("%.2f", version) .. "");
 	local text = "";
	if (notes) then
		for k, v in ipairs(notes) do
			if (string.match(v, "Version 1") or v == " ") then
				text = text .. "|cFFFFFFFF" .. v .. "|r\n\n";
			else
				text = text .. "|TInterface\\QUESTFRAME\\UI-Quest-BulletPoint:12:12:0:0|t |cFFFFFFFF" .. v .. "|r\n\n";
			end
		end
	end
	if (text ~= "") then
		frame.fs:SetText(text);
		local height = frame.fs:GetStringHeight();
		frame:SetHeight(height + 75);
		frame:Show();
	end
end

function NCH:checkNewVersion()
	--NCH.db.global.versions = {}; --To test.
	local newVersionNotes = 1.29;
	if (NCH.version and NCH.version == newVersionNotes) then
		if (not NCH.db.global.versions[NCH.version]) then
			--if (NCH.isClassic) then
				local notes = {
					"Added the lower Elixir of Greater Defense to the potions section on classic.",
					"Added Whipper Root Tuber to the short potions section on classic.",
					"Added Paralytic Poison to MoP for rogues.",
					"Added an option to load in arena (mainly for weapon poisons/imbues).",
					"Fixed tooltips for spells that have no item attached (like shaman imbues etc).",
					"Fixed an error if you tried to drag the frame during combat.",
					"Changed default low time amount to 10 mins instead of 5 for MoP, fights are longer and reusing flasks at low time will just add extra time up to 1h15mins.",
				};
				loadNewVersionFrame(NCH.version, notes, "Nova Consumes Helper", "Interface\\Icons\\inv_potion_41", 30, 200);
			--end
			--Wipe old data.
			NCH.db.global.versions = {};
			--Set this version has been loaded before.
			NCH.db.global.versions[NCH.version] = GetServerTime();
		end
	end
end

local function isProfileDefault(profile)
	if (not next(profile)) then
		return true;
	end
	local found;
	local defaultProfile = NCH.optionDefaults.profile;
	for k, v in pairs(profile) do
		if (defaultProfile[k] and defaultProfile[k] ~= v) then
			found = true;
		end
	end
	if (not found) then
		return true;
	end
end

--Get profiles that aren't default (has consumes added by user).
--Only consumes are stored in profiles, settings are global.
function NCH:getActiveProfiles()
	local profiles = NCH.db.profiles;
	local data = {};
	for k, v in pairs(profiles) do
		if (not isProfileDefault(v)) then
			data[k] = v;
		end
	end
	return data;
end

function NCH:setProfile(profile)
	NCH.db:SetProfile(profile);
	NCH:updateConfigOptions();
end

--Lock all frames.
function NCH:setLockAllFrames(info, value)
	self.db.global.lockAllFrames = value;
	NCH:updateFrameLocks(value);
end

function NCH:getLockAllFrames(info)
	return self.db.global.lockAllFrames;
end

function NCH:updateFrameLocks(locked)
	NCH:consumesUpdateFrameLocks();
	if (NCH.protUpdateFrameLocks) then
		--Protection pots aren't loaded after TBC.
		NCH:protUpdateFrameLocks();
	end
end