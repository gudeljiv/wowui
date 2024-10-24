local pairs = pairs;
local _;

VUHDO_GLOBAL_CONFIG = {
	["PROFILES_VERSION"] = 1;
};


--
local tHotCfg, tHotSlots;
function VUHDO_fixHotSettings()
	tHotSlots = VUHDO_PANEL_SETUP["HOTS"]["SLOTS"];
	tHotCfg = VUHDO_PANEL_SETUP["HOTS"]["SLOTCFG"];

	for tCnt2 = 1, 10 do
		if not tHotCfg["" .. tCnt2]["mine"] and not tHotCfg["" .. tCnt2]["others"] then
			if tHotSlots[tCnt2] then
				tHotCfg["" .. tCnt2]["mine"] = true;
				tHotCfg["" .. tCnt2]["others"] = VUHDO_EXCLUSIVE_HOTS[tHotSlots[tCnt2]];
			end
		end
	end
end



--
local function VUHDO_getVarDescription(aVar)
	local tMessage = "";
	if aVar == nil then
		tMessage = "<nil>";
	elseif "boolean" == type(aVar) then
		if aVar then
			tMessage = "<true>";
		else
			tMessage = "<false>";
		end
	elseif "number" == type(aVar) or "string" == type(aVar) then
		tMessage = aVar .. " (" .. type(aVar) .. ")";
	else
		tMessage = "(" .. type(aVar) .. ")";
	end

	return tMessage;
end



--
local tCreated, tRepaired;
local function _VUHDO_ensureSanity(aName, aValue, aSaneValue)
	if aSaneValue ~= nil then
		if type(aSaneValue) == "table" then
			if aValue ~= nil and type(aValue) == "table" then
				for tIndex, _ in pairs(aSaneValue) do
					aValue[tIndex] = _VUHDO_ensureSanity(aName, aValue[tIndex], aSaneValue[tIndex]);
				end
			else

				if aValue ~= nil then
					tRepaired = tRepaired + 1;
				else
					tCreated = tCreated + 1;
				end

				return VUHDO_deepCopyTable(aSaneValue);
			end
		else
			if aValue == nil or type(aValue) ~= type(aSaneValue) then
				if (type(aSaneValue) ~= "boolean" or (aValue ~= 1 and aValue ~= 0 and aValue ~= nil))
				and (type(aSaneValue) ~= "number" or (aSaneValue ~= 1 and aSaneValue ~= 0)) then

					if (aValue ~= nil) then
						tRepaired = tRepaired + 1;
					else
						tCreated = tCreated + 1;
					end

					return aSaneValue;
				end
			end

			if aValue ~= nil and "string" == type(aValue) then
				aValue = strtrim(aValue);
			end

		end
	end

	return aValue
end



--
local tRepairedArray;
function VUHDO_ensureSanity(aName, aValue, aSaneValue)
	tCreated, tRepaired = 0, 0;

	local tSaneValue = VUHDO_decompressIfCompressed(aSaneValue);
	tRepairedArray = _VUHDO_ensureSanity(aName, aValue, tSaneValue);

	if tCreated + tRepaired > 0 then
		VUHDO_Msg("auto model sanity: " .. aName .. ": created " .. tCreated .. ", repaired " .. tRepaired .. " values.");
	end

	return tRepairedArray;
end



local VUHDO_DEFAULT_MODELS = {
	{ VUHDO_ID_GROUP_1, VUHDO_ID_GROUP_2, VUHDO_ID_GROUP_3, VUHDO_ID_GROUP_4, VUHDO_ID_GROUP_5, VUHDO_ID_GROUP_6, VUHDO_ID_GROUP_7, VUHDO_ID_GROUP_8, VUHDO_ID_PETS },
	{ VUHDO_ID_PRIVATE_TANKS, VUHDO_ID_BOSSES }, 
};



local VUHDO_DEFAULT_RANGE_SPELLS = {
	["PALADIN"] = VUHDO_SPELL_ID.FLASH_OF_LIGHT,
	["SHAMAN"] = VUHDO_SPELL_ID.HEALING_WAVE,
	["DRUID"] = VUHDO_SPELL_ID.REJUVENATION,
	["PRIEST"] = VUHDO_SPELL_ID.HEAL,
	["MONK"] = VUHDO_SPELL_ID.DETOX,
}



--local VUHDO_DEFAULT_SPELL_ASSIGNMENT = { };
--local VUHDO_DEFAULT_HOSTILE_SPELL_ASSIGNMENT = {};
local VUHDO_DEFAULT_SPELLS_KEYBOARD = {};



local VUHDO_CLASS_DEFAULT_SPELL_ASSIGNMENT = {
	["PALADIN"] = {
		["1"] = {"", "1", VUHDO_SPELL_ID.FLASH_OF_LIGHT},
		["2"] = {"", "2", VUHDO_SPELL_ID.PALA_CLEANSE},
		["3"] = {"", "3", "menu"},
		["4"] = {"", "4", VUHDO_SPELL_ID.LIGHT_OF_DAWN},

		["alt1"] = {"alt-", "1", "target"},

		["ctrl1"] = {"ctrl-", "1", VUHDO_SPELL_ID.HOLY_LIGHT},
		["ctrl2"] = {"ctrl-", "2", VUHDO_SPELL_ID.HOLY_SHOCK},

		["shift1"] = {"shift-", "1", VUHDO_SPELL_ID.HOLY_RADIANCE},
		["shift2"] = {"shift-", "2", VUHDO_SPELL_ID.LAY_ON_HANDS},
	},

	["SHAMAN"] = {
		["1"] = {"", "1", VUHDO_SPELL_ID.HEALING_WAVE},
		["2"] = {"", "2", VUHDO_SPELL_ID.CHAIN_HEAL},
		["3"] = {"", "3", "menu"},

		["alt1"] = {"alt-", "1", VUHDO_SPELL_ID.BUFF_EARTH_SHIELD},
		["alt2"] = {"alt-", "2", VUHDO_SPELL_ID.GIFT_OF_THE_NAARU},
		["alt3"] = {"alt-", "3", "menu"},

		["ctrl1"] = {"ctrl-", "1", "target"},
		["ctrl2"] = {"ctrl-", "2", "target"},
		["ctrl3"] = {"ctrl-", "3", "menu"},

		["shift1"] = {"shift-", "1", VUHDO_SPELL_ID.HEALING_WAVE},
		["shift2"] = {"shift-", "2", VUHDO_SPELL_ID.CHAIN_HEAL},
		["shift3"] = {"shift-", "3", "menu" },

		["altctrl1"] = {"alt-ctrl-", "1", VUHDO_SPELL_ID.PURIFY_SPIRIT},
		["altctrl2"] = {"alt-ctrl-", "2", VUHDO_SPELL_ID.PURIFY_SPIRIT},
	},

	["PRIEST"] = {
		["1"] = {"", "1", VUHDO_SPELL_ID.FLASH_HEAL},
		["2"] = {"", "2", VUHDO_SPELL_ID.HEAL},
		["3"] = {"", "3", VUHDO_SPELL_ID.DESPERATE_PRAYER},
		["4"] = {"", "4", VUHDO_SPELL_ID.RENEW},
		["5"] = {"", "5", VUHDO_SPELL_ID.BINDING_HEAL},

		["alt1"] = {"alt-", "1", "target"},
		["alt2"] = {"alt-", "2", "focus"},
		["alt3"] = {"alt-", "3", VUHDO_SPELL_ID.POWERWORD_SHIELD},
		["alt4"] = {"alt-", "4", VUHDO_SPELL_ID.POWERWORD_SHIELD},
		["alt5"] = {"alt-", "5", VUHDO_SPELL_ID.POWERWORD_SHIELD},

		["ctrl1"] = {"ctrl-", "1", VUHDO_SPELL_ID.PRAYER_OF_HEALING},
		["ctrl2"] = {"ctrl-", "2", VUHDO_SPELL_ID.CIRCLE_OF_HEALING},
		["ctrl3"] = {"ctrl-", "3", "menu"},
		["ctrl4"] = {"ctrl-", "4", VUHDO_SPELL_ID.PRAYER_OF_MENDING},
		["ctrl5"] = {"ctrl-", "5", VUHDO_SPELL_ID.PRAYER_OF_MENDING},

		["shift2"] = {"shift-", "2", VUHDO_SPELL_ID.PURIFY},
		["shift3"] = {"shift-", "3", "menu"},
	},

	["DRUID"] = {
		["1"] = {"", "1", VUHDO_SPELL_ID.HEALING_TOUCH},
		["2"] = {"", "2", VUHDO_SPELL_ID.REJUVENATION},
		["3"] = {"", "3", "menu"},
		["4"] = {"", "4", VUHDO_SPELL_ID.INNERVATE},
		["5"] = {"", "5", VUHDO_SPELL_ID.INNERVATE},

		["alt1"] = {"alt-", "1", "target"},
		["alt2"] = {"alt-", "2", "focus"},
		["alt3"] = {"alt-", "3", "menu"},

		["ctrl1"] = {"ctrl-", "1", VUHDO_SPELL_ID.REGROWTH},
		["ctrl2"] = {"ctrl-", "2", VUHDO_SPELL_ID.LIFEBLOOM},
		["ctrl4"] = {"ctrl-", "4", VUHDO_SPELL_ID.TRANQUILITY},
		["ctrl5"] = {"ctrl-", "5", VUHDO_SPELL_ID.TRANQUILITY},

		["shift2"] = {"shift-", "2", VUHDO_SPELL_ID.NATURES_CURE},
	},

	["MONK"] = {
		["1"] = { "", "1", VUHDO_SPELL_ID.SURGING_MIST },
		["2"] = { "", "2", VUHDO_SPELL_ID.ENVELOPING_MIST },
		["3"] = { "", "3", "menu"},
		["4"] = { "", "4", VUHDO_SPELL_ID.RENEWING_MIST },
		["5"] = { "", "5", VUHDO_SPELL_ID.SOOTHING_MIST },

		["alt1"] = { "alt-", "1", "target" },
		["alt2"] = { "alt-", "2", VUHDO_SPELL_ID.CHI_WAVE },

		["ctrl1"] = { "ctrl-", "1", VUHDO_SPELL_ID.DETOX },
		["ctrl2"] = { "ctrl-", "2", VUHDO_SPELL_ID.LIFE_COCOON },

		["shift1"] = { "shift-", "1", VUHDO_SPELL_ID.UPLIFT },
		["shift2"] = { "shift-", "2", VUHDO_SPELL_ID.REVIVAL },
	},

};



--
local VUHDO_GLOBAL_DEFAULT_SPELL_ASSIGNMENT = {
	["1"] = {"", "1", "target"},
	["2"] = {"", "2", "assist"},
	["3"] = {"", "3", "focus"},
	["4"] = {"", "4", "menu"},
	["5"] = {"", "5", "menu"},
};



--
VUHDO_DEFAULT_SPELL_CONFIG = {
	["IS_AUTO_FIRE"] = true,
	["IS_FIRE_HOT"] = false,
	["IS_FIRE_OUT_FIGHT"] = false,
	["IS_AUTO_TARGET"] = false,
	["IS_CANCEL_CURRENT"] = false,
	["IS_FIRE_TRINKET_1"] = false,
	["IS_FIRE_TRINKET_2"] = false,
	["IS_FIRE_GLOVES"] = false,
	["IS_FIRE_CUSTOM_1"] = false,
	["FIRE_CUSTOM_1_SPELL"] = "",
	["IS_FIRE_CUSTOM_2"] = false,
	["FIRE_CUSTOM_2_SPELL"] = "",
	["IS_TOOLTIP_INFO"] = false,
	["IS_LOAD_HOTS"] = false,
	["smartCastModi"] = "all",
	["autoBattleRez"] = true,
	["custom1Unit"] = "@player",
	["custom2Unit"] = "@player",
}


local tDefaultWheelAssignments = {
	["1"] = {"", "-w1", ""},
	["2"] = {"", "-w2", ""},

	["alt1"] = {"ALT-", "-w3", ""},
	["alt2"] = {"ALT-", "-w4", ""},

	["ctrl1"] = {"CTRL-", "-w5", ""},
	["ctrl2"] = {"CTRL-", "-w6", ""},

	["shift1"] = {"SHIFT-", "-w7", ""},
	["shift2"] = {"SHIFT-", "-w8", ""},

	["altctrl1"] = {"ALT-CTRL-", "-w9", ""},
	["altctrl2"] = {"ALT-CTRL-", "-w10", ""},

	["altshift1"] = {"ALT-SHIFT-", "-w11", ""},
	["altshift2"] = {"ALT-SHIFT-", "-w12", ""},

	["ctrlshift1"] = {"CTRL-SHIFT-", "-w13", ""},
	["ctrlshift2"] = {"CTRL-SHIFT-", "-w14", ""},

	["altctrlshift1"] = {"ALT-CTRL-SHIFT-", "-w15", ""},
	["altctrlshift2"] = {"ALT-CTRL-SHIFT-", "-w16", ""},
};



--
local function VUHDO_initDefaultKeySpellAssignments()
	VUHDO_DEFAULT_SPELLS_KEYBOARD = { };

	for tCnt = 1, VUHDO_NUM_KEYBOARD_KEYS do
		VUHDO_DEFAULT_SPELLS_KEYBOARD["SPELL" .. tCnt] = "";
	end

	VUHDO_DEFAULT_SPELLS_KEYBOARD["INTERNAL"] = {	};
	VUHDO_DEFAULT_SPELLS_KEYBOARD["WHEEL"] = VUHDO_deepCopyTable(tDefaultWheelAssignments);
	VUHDO_DEFAULT_SPELLS_KEYBOARD["HOSTILE_WHEEL"] = VUHDO_deepCopyTable(tDefaultWheelAssignments);
end



--
function VUHDO_trimSpellAssignments(anArray)
	local tRemove = { };

	for tKey, tValue in pairs(anArray) do
		if (VUHDO_strempty(tValue[3])) then
			tinsert(tRemove, tKey);
		end
	end

	for _, tKey in pairs(tRemove) do
		anArray[tKey] = nil;
	end
end



--
local function VUHDO_assignDefaultSpells()
	local _, tClass = UnitClass("player");

	VUHDO_SPELL_ASSIGNMENTS = VUHDO_deepCopyTable(VUHDO_CLASS_DEFAULT_SPELL_ASSIGNMENT[tClass] ~= nil
		and VUHDO_CLASS_DEFAULT_SPELL_ASSIGNMENT[tClass] or VUHDO_GLOBAL_DEFAULT_SPELL_ASSIGNMENT);

	VUHDO_CLASS_DEFAULT_SPELL_ASSIGNMENT = nil;
	VUHDO_GLOBAL_DEFAULT_SPELL_ASSIGNMENT = nil;
end



--
function VUHDO_loadSpellArray()
	-- Maus freundlich
	if (VUHDO_SPELL_ASSIGNMENTS == nil) then
		VUHDO_assignDefaultSpells();
	end
	VUHDO_SPELL_ASSIGNMENTS = VUHDO_ensureSanity("VUHDO_SPELL_ASSIGNMENTS", VUHDO_SPELL_ASSIGNMENTS, {});
	VUHDO_trimSpellAssignments(VUHDO_SPELL_ASSIGNMENTS);

	-- Maus gegnerisch
	if (VUHDO_HOSTILE_SPELL_ASSIGNMENTS == nil) then
		VUHDO_HOSTILE_SPELL_ASSIGNMENTS = { };
	end
	VUHDO_HOSTILE_SPELL_ASSIGNMENTS = VUHDO_ensureSanity("VUHDO_HOSTILE_SPELL_ASSIGNMENTS", VUHDO_HOSTILE_SPELL_ASSIGNMENTS, {});
	VUHDO_trimSpellAssignments(VUHDO_HOSTILE_SPELL_ASSIGNMENTS);

	-- Tastatur
	VUHDO_initDefaultKeySpellAssignments();
	if (VUHDO_SPELLS_KEYBOARD == nil) then
		VUHDO_SPELLS_KEYBOARD = VUHDO_deepCopyTable(VUHDO_DEFAULT_SPELLS_KEYBOARD);
	end
	VUHDO_SPELLS_KEYBOARD = VUHDO_ensureSanity("VUHDO_SPELLS_KEYBOARD", VUHDO_SPELLS_KEYBOARD, VUHDO_DEFAULT_SPELLS_KEYBOARD);
	VUHDO_DEFAULT_SPELLS_KEYBOARD = nil;

	-- Konfiguration
	if (VUHDO_SPELL_CONFIG == nil) then
		VUHDO_SPELL_CONFIG = VUHDO_deepCopyTable(VUHDO_DEFAULT_SPELL_CONFIG);
	end
	VUHDO_SPELL_CONFIG = VUHDO_ensureSanity("VUHDO_SPELL_CONFIG", VUHDO_SPELL_CONFIG, VUHDO_DEFAULT_SPELL_CONFIG);

	if (VUHDO_SPELL_LAYOUTS == nil) then
		VUHDO_SPELL_LAYOUTS = { };
	end

	if (VUHDO_SPEC_LAYOUTS == nil) then
		VUHDO_SPEC_LAYOUTS = {
			["selected"] = "",
			["1"] = "",
			["2"] = "",
			["3"] = "",
			["4"] = ""
		}
	end

	VUHDO_DEFAULT_SPELL_CONFIG = nil;
end



--
local function VUHDO_makeFullColorWoOpacity(...)
	local tColor = VUHDO_makeFullColor(...);
	
	tColor["useOpacity"] = false;
	
	return tColor;
end



--
local function VUHDO_makeHotColor(...)
	local tColor = VUHDO_makeFullColor(...);
	
	tColor["isFullDuration"] = false;
	tColor["isClock"] = false;
	tColor["countdownMode"] = 1;
	tColor["useOpacity"] = false;
	tColor["isFadeOut"] = false;
	tColor["isFlashWhenLow"] = false;
	
	return tColor;
end




--
local function VUHDO_customDebuffsAddDefaultSettings(aBuffName)
	if (VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"] == nil) then
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"] = { };
	end

	if (VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName] == nil) then
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]	= {
			["isIcon"] = VUHDO_CONFIG["CUSTOM_DEBUFF"]["isIcon"],
			["isColor"] = false,
			["animate"] = VUHDO_CONFIG["CUSTOM_DEBUFF"]["animate"],
			["timer"] = VUHDO_CONFIG["CUSTOM_DEBUFF"]["timer"],
			["isStacks"] = VUHDO_CONFIG["CUSTOM_DEBUFF"]["isStacks"],
			["isMine"] = true,
			["isOthers"] = true,
			["isBarGlow"] = false,
			["isIconGlow"] = false,
		}
	end

	if (not VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["isColor"]) then
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["color"] = nil;
	elseif (VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["color"] == nil) then
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["color"]
			= VUHDO_makeFullColor(0.6, 0.3, 0, 1,   0.8, 0.5, 0, 1);
	end
	
	if (not VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["isBarGlow"]) then
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["barGlowColor"] = nil;
	elseif (VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["barGlowColor"] == nil) then
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["barGlowColor"]
			= VUHDO_makeFullColor(0.95, 0.95, 0.32, 1,   1, 1, 0, 1);
	end

	if (not VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["isIconGlow"]) then
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["iconGlowColor"] = nil;
	elseif (VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["iconGlowColor"] == nil) then
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][aBuffName]["iconGlowColor"]
			= VUHDO_makeFullColor(0.95, 0.95, 0.32, 1,   1, 1, 0, 1);
	end
end



--
local function VUHDO_addCustomSpellIds(aVersion, ...)
	if ((VUHDO_CONFIG["CUSTOM_DEBUFF"].version or 0) < aVersion) then
		VUHDO_CONFIG["CUSTOM_DEBUFF"].version = aVersion;

		local tArg;
		for tCnt = 1, select("#", ...) do
			tArg = select(tCnt, ...);

			if (type(tArg) == "number") then
				-- make sure the spell ID is still added as a string
				-- otherwise getKeyFromValue look-ups w/ spell ID string fail later
				tArg = tostring(tArg);
			end

			VUHDO_tableUniqueAdd(VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED"], tArg);
		end
	end
end



--
local function VUHDO_spellTraceAddDefaultSettings(aSpellName)

	if (VUHDO_CONFIG["SPELL_TRACE"]["STORED_SETTINGS"] == nil) then
		VUHDO_CONFIG["SPELL_TRACE"]["STORED_SETTINGS"] = { };
	end

	if (VUHDO_CONFIG["SPELL_TRACE"]["STORED_SETTINGS"][aSpellName] == nil) then
		VUHDO_CONFIG["SPELL_TRACE"]["STORED_SETTINGS"][aSpellName] = {
			["isMine"] = VUHDO_CONFIG["SPELL_TRACE"]["isMine"],
			["isOthers"] = VUHDO_CONFIG["SPELL_TRACE"]["isOthers"],
			["duration"] = VUHDO_CONFIG["SPELL_TRACE"]["duration"],
		}
	end

end



--
local function VUHDO_addSpellTraceSpellIds(aVersion, ...)

	if ((VUHDO_CONFIG["SPELL_TRACE"].version or 0) < aVersion) then
		VUHDO_CONFIG["SPELL_TRACE"].version = aVersion;

		local tArg;

		for tCnt = 1, select("#", ...) do
			tArg = select(tCnt, ...);

			if (type(tArg) == "number") then
				-- make sure the spell ID is still added as a string
				-- otherwise getKeyFromValue look-ups w/ spell ID string fail later
				tArg = tostring(tArg);
			end

			VUHDO_tableUniqueAdd(VUHDO_CONFIG["SPELL_TRACE"]["STORED"], tArg);
		end
	end

end



--
local VUHDO_DEFAULT_CONFIG = {
	["VERSION"] = 4,

	["SHOW_PANELS"] = true,
	["HIDE_PANELS_SOLO"] = false,
	["HIDE_PANELS_PARTY"] = false,
	["HIDE_PANELS_PET_BATTLE"] = true,
	["LOCK_PANELS"] = false,
	["LOCK_CLICKS_THROUGH"] = false,
	["LOCK_IN_FIGHT"] = true,
	["PARSE_COMBAT_LOG"] = true,
	["HIDE_EMPTY_BUTTONS"] = false,

	["MODE"] = VUHDO_MODE_NEUTRAL,
	["EMERGENCY_TRIGGER"] = 100,
	["MAX_EMERGENCIES"] = 5,

	["SHOW_INCOMING"] = true,
	["SHOW_OVERHEAL"] = true,
	["SHOW_OWN_INCOMING"] = true,
	["SHOW_TEXT_OVERHEAL"] = true,
	["SHOW_LIBHEALCOMM_INCOMING"] = false,
	["SHOW_SHIELD_BAR"] = true,
	["SHOW_OVERSHIELD_BAR"] = false,
	["SHOW_HEAL_ABSORB_BAR"] = true,

	["RANGE_CHECK_DELAY"] = 260,

	["SOUND_DEBUFF"] = nil,
	["DETECT_DEBUFFS_REMOVABLE_ONLY"] = true,
	["DETECT_DEBUFFS_REMOVABLE_ONLY_ICONS"] = true,
	["DETECT_DEBUFFS_IGNORE_BY_CLASS"] = true,
	["DETECT_DEBUFFS_IGNORE_NO_HARM"] = true,
	["DETECT_DEBUFFS_IGNORE_MOVEMENT"] = true,
	["DETECT_DEBUFFS_IGNORE_DURATION"] = true,

	["SMARTCAST_RESURRECT"] = true,
	["SMARTCAST_CLEANSE"] = true,
	["SMARTCAST_BUFF"] = false,

	["SHOW_PLAYER_TAGS"] = true,
	["OMIT_MAIN_TANKS"] = false,
	["OMIT_MAIN_ASSIST"] = false,
	["OMIT_PLAYER_TARGETS"] = false,
	["OMIT_OWN_GROUP"] = false,
	["OMIT_FOCUS"] = false,
	["OMIT_TARGET"] = false,
	["OMIT_SELF"] = false,
	["OMIT_DFT_MTS"] = false,
	["BLIZZ_UI_HIDE_PLAYER"] = 2,
	["BLIZZ_UI_HIDE_PARTY"] = 2,
	["BLIZZ_UI_HIDE_TARGET"] = 2,
	["BLIZZ_UI_HIDE_PET"] = 2,
	["BLIZZ_UI_HIDE_FOCUS"] = 2,
	["BLIZZ_UI_HIDE_RAID"] = 2,
	["BLIZZ_UI_HIDE_RAID_MGR"] = 2,

	["CURRENT_PROFILE"] = "",
	["IS_ALWAYS_OVERWRITE_PROFILE"] = false,
	["HIDE_EMPTY_PANELS"] = false,
	["ON_MOUSE_UP"] = false,

	["STANDARD_TOOLTIP"] = false,
	["DEBUFF_TOOLTIP"] = true,

	["AUTO_PROFILES"] = {	},

	["RES_ANNOUNCE_TEXT"] = VUHDO_I18N_DEFAULT_RES_ANNOUNCE,
	["RES_ANNOUNCE_MASS_TEXT"] = VUHDO_I18N_DEFAULT_RES_ANNOUNCE_MASS,
	["RES_IS_SHOW_TEXT"] = false,

	["CUSTOM_DEBUFF"] = {
		["scale"] = 0.8,
		["animate"] = true,
		["timer"] = true,
		["max_num"] = 3,
		["isNoRangeFade"] = false,
		["isIcon"] = true,
		["isColor"] = false,
		["isStacks"] = false,
		["isName"] = false, 
		["isShowOnlyForFriendly"] = false, 
		["blacklistModi"] = "ALT-CTRL-SHIFT",
		["SELECTED"] = "",
		["point"] = "TOPRIGHT",
		["xAdjust"] = -2,
		["yAdjust"] = -34,
		["STORED"] = { },

		["TIMER_TEXT"] = {
			["ANCHOR"] = "BOTTOMRIGHT",
			["X_ADJUST"] = 20,
			["Y_ADJUST"] = 26,
			["SCALE"] = 85,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["COLOR"] = VUHDO_makeFullColor(0, 0, 0, 1,   1, 1, 1, 1),
			["USE_SHADOW"] = true,
			["USE_OUTLINE"] = false,
			["USE_MONO"] = false,
		},

		["COUNTER_TEXT"] = {
			["ANCHOR"] = "TOPLEFT",
			["X_ADJUST"] = -10,
			["Y_ADJUST"] = -15,
			["SCALE"] = 70,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["COLOR"] = VUHDO_makeFullColor(0, 0, 0, 1,   0, 1, 0, 1),
			["USE_SHADOW"] = true,
			["USE_OUTLINE"] = false,
			["USE_MONO"] = false,
		},
	},

	["SPELL_TRACE"] = {
		["isMine"] = true,
		["isOthers"] = false,
		["duration"] = 2,
		["showTrailOfLight"] = false,
		["SELECTED"] = "",
		["STORED"] = { },
	},

	["THREAT"] = {
		["AGGRO_REFRESH_MS"] = 300,
		["AGGRO_TEXT_LEFT"] = ">>",
		["AGGRO_TEXT_RIGHT"] = "<<",
		["AGGRO_USE_TEXT"] = false,
		["IS_TANK_MODE"] = false,
	},

	["CLUSTER"] = {
		["REFRESH"] = 180,
		["RANGE"] = 30,
		["RANGE_JUMP"] = 11,
		["BELOW_HEALTH_PERC"] = 85,
		["THRESH_FAIR"] = 3,
		["THRESH_GOOD"] = 5,
		["DISPLAY_SOURCE"] = 2, -- 1=Mine, 2=all
		["DISPLAY_DESTINATION"] = 2, -- 1=Party, 2=Raid
		["MODE"] = 1, -- 1=radial, 2=chained
		["IS_NUMBER"] = true,
		["CHAIN_MAX_JUMP"] = 3,
		["COOLDOWN_SPELL"] = "",
		["CONE_DEGREES"] = 360,
        ["ARE_TARGETS_RANDOM"] = true,

		["TEXT"] = {
			["ANCHOR"] = "BOTTOMRIGHT",
			["X_ADJUST"] = 40,
			["Y_ADJUST"] = 22,
			["SCALE"] = 85,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["COLOR"] = VUHDO_makeFullColor(0, 0, 0, 1,   1, 1, 1, 1),
			["USE_SHADOW"] = false,
			["USE_OUTLINE"] = true,
			["USE_MONO"] = false,
		},
	},

	["UPDATE_HOTS_MS"] = 250,
	["SCAN_RANGE"] = "2", -- 0=all, 2=100 yards, 3=40 yards

	["RANGE_SPELL"] = "",
	["RANGE_PESSIMISTIC"] = true,

	["IS_SHOW_GCD"] = false,
	["IS_SCAN_TALENTS"] = true,
	["IS_CLIQUE_COMPAT_MODE"] = false,
	["IS_CLIQUE_PASSTHROUGH"] = false,
	["DIRECTION"] = {
		["enable"] = true,
		["isDistanceText"] = false,
		["isDeadOnly"] = false,
		["isAlways"] = false,
		["scale"] = 75,
	},

	["AOE_ADVISOR"] = {
		["knownOnly"] = true,
		["subInc"] = true,
		["subIncOnlyCastTime"] = true,
		["isCooldown"] = true,
		["animate"] = true,
		["isGroupWise"] = false,
		["refresh"] = 800,

		["config"] = {
			["coh"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["poh"] = {
				["enable"] = true,
				["thresh"] = 20000,
			},
			["ch"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["wg"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["tq"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["lod"] = {
				["enable"] = true,
				["thresh"] = 8000,
			},
			["hr"] = {
				["enable"] = false,
				["thresh"] = 10000,
			},
			["cb"] = {
				["enable"] = false,
				["thresh"] = 10000,
			},
		},

	},

	["IS_DC_SHIELD_DISABLED"] = false,
	["IS_USE_BUTTON_FACADE"] = false,
	["IS_SHARE"] = true,
	["IS_READY_CHECK_DISABLED"] = false,

	["SHOW_SPELL_TRACE"] = false,
};



local VUHDO_DEFAULT_CU_DE_STORED_SETTINGS = {
	["isIcon"] = true,
	["isColor"] = false,
--	["SOUND"] = "",
	["animate"] = true,
	["timer"] = true,
	["isStacks"] = true,
	["isAliveTime"] = false,
	["isFullDuration"] = false,
	["isMine"] = true,
	["isOthers"] = true,
	["isBarGlow"] = false,
	["isIconGlow"] = false,

--	["color"] = {
--		["R"] = 0.6,
--		["G"] = 0.3,
--		["B"] = 0,
--		["O"] = 1,
--		["TR"] = 0.8,
--		["TG"] = 0.5,
--		["TB"] = 0,
--		["TO"] = 1,
--		["useText"] = true,
--		["useBackground"] = true,
--		["useOpacity"] = true,
--	},
};



local VUHDO_DEFAULT_SPELL_TRACE_STORED_SETTINGS = {
	["isMine"] = true,
	["isOthers"] = false,
	["duration"] = 2,
};



VUHDO_DEFAULT_POWER_TYPE_COLORS = {
	[VUHDO_UNIT_POWER_MANA]         = VUHDO_makeFullColor(0,     0,     1,    1,  0,     0,     1,    1),
	[VUHDO_UNIT_POWER_RAGE]         = VUHDO_makeFullColor(1,     0,     0,    1,  1,     0,     0,    1),
	[VUHDO_UNIT_POWER_FOCUS]        = VUHDO_makeFullColor(1,     0.5,   0.25, 1,  1,     0.5,   0.25, 1),
	[VUHDO_UNIT_POWER_ENERGY]       = VUHDO_makeFullColor(1,     1,     0,    1,  1,     1,     0,    1),
	[VUHDO_UNIT_POWER_COMBO_POINTS] = VUHDO_makeFullColor(0,     1,     1,    1,  0,     1,     1,    1),
	[VUHDO_UNIT_POWER_RUNIC_POWER]  = VUHDO_makeFullColor(0.5,   0.5,   0.5,  1,  0.5,   0.5,   0.5,  1),
	[VUHDO_UNIT_POWER_LUNAR_POWER]  = VUHDO_makeFullColor(0.87,  0.95,  1,    1,  0.87,  0.95,  1,    1),
	[VUHDO_UNIT_POWER_MAELSTROM]    = VUHDO_makeFullColor(0.09,  0.56,  1,    1,  0.09,  0.56,  1,    1),
	[VUHDO_UNIT_POWER_INSANITY]     = VUHDO_makeFullColor(0.15,  0.97,  1,    1,  0.15,  0.97,  1,    1),
	[VUHDO_UNIT_POWER_FURY]         = VUHDO_makeFullColor(0.54,  0.09,  0.69, 1,  0.54,  0.09,  0.69, 1),
	[VUHDO_UNIT_POWER_PAIN]         = VUHDO_makeFullColor(0.54,  0.09,  0.69, 1,  0.54,  0.09,  0.69, 1),
};



--
local function VUHDO_convertToTristate(aBoolean, aTrueVal, aFalseVal)
	if (aBoolean == nil or aBoolean == false) then
		return aFalseVal;
	elseif (aBoolean == true) then
		return aTrueVal;
	else
		return aBoolean;
	end
end



--
function VUHDO_loadDefaultConfig()
	local tClass;
	 _, tClass = UnitClass("player");

	if (VUHDO_CONFIG == nil) then
		VUHDO_CONFIG = VUHDO_decompressOrCopy(VUHDO_DEFAULT_CONFIG);

		if (VUHDO_DEFAULT_RANGE_SPELLS[tClass] ~= nil) then
			VUHDO_CONFIG["RANGE_SPELL"] = VUHDO_DEFAULT_RANGE_SPELLS[tClass];
			VUHDO_CONFIG["RANGE_PESSIMISTIC"] = false;
		end
	end

	VUHDO_CONFIG["BLIZZ_UI_HIDE_PLAYER"] = VUHDO_convertToTristate(VUHDO_CONFIG["BLIZZ_UI_HIDE_PLAYER"], 3, 2);
	VUHDO_CONFIG["BLIZZ_UI_HIDE_PARTY"] = VUHDO_convertToTristate(VUHDO_CONFIG["BLIZZ_UI_HIDE_PARTY"], 3, 2);
	VUHDO_CONFIG["BLIZZ_UI_HIDE_TARGET"] = VUHDO_convertToTristate(VUHDO_CONFIG["BLIZZ_UI_HIDE_TARGET"], 3, 2);
	VUHDO_CONFIG["BLIZZ_UI_HIDE_PET"] = VUHDO_convertToTristate(VUHDO_CONFIG["BLIZZ_UI_HIDE_PET"], 3, 2);
	VUHDO_CONFIG["BLIZZ_UI_HIDE_FOCUS"] = VUHDO_convertToTristate(VUHDO_CONFIG["BLIZZ_UI_HIDE_FOCUS"], 3, 2);
	VUHDO_CONFIG["BLIZZ_UI_HIDE_RAID"] = VUHDO_convertToTristate(VUHDO_CONFIG["BLIZZ_UI_HIDE_RAID"], 3, 2);
	VUHDO_CONFIG["BLIZZ_UI_HIDE_RAID_MGR"] = VUHDO_convertToTristate(VUHDO_CONFIG["BLIZZ_UI_HIDE_RAID_MGR"], 3, 2);

	VUHDO_CONFIG = VUHDO_ensureSanity("VUHDO_CONFIG", VUHDO_CONFIG, VUHDO_DEFAULT_CONFIG);
	VUHDO_DEFAULT_CONFIG = VUHDO_compressAndPackTable(VUHDO_DEFAULT_CONFIG);

	if ((VUHDO_CONFIG["VERSION"] or 1) < 4) then
		VUHDO_CONFIG["IS_SHARE"] = true;
		VUHDO_CONFIG["VERSION"] = 4;
	end

	-- add relevant custom debuffs for raid bosses
	-- 1.13.2 - Classic
	VUHDO_addCustomSpellIds(45, 
		-- [[ MolTon Core ]]
		-- Baron Geddon
		20475   -- Living Bomb
	);
	
	-- TBCC phase 1
	VUHDO_addCustomSpellIds(49, 
		39171, -- Mortal Strike
		29572, -- Mortal Strike
		8379,  -- Disarm
		30901, -- Sunder Armor
		29321, -- Fear
		30530, -- Fear
		6016,  -- Pierce Armor
		29574, -- Rend
		29928, -- Immolate
		12024, -- Net
		-- [[ Gruul's Lair ]]
		-- High King Maulgar
		16508, -- Intimidating Roar
		33130, -- Death Coil
		33129, -- Dark Decay
		33173, -- Greater Polymorph
		-- Gruul
		36240, -- Cave In
		36297, -- Reverberation
		-- 33813  -- Hurtful Strike (Tank)
		-- [[Magtheridon's Lair]]
		-- Magtheridon
		30757,  -- Conflagration
		44032,  -- Mind Exhaustion
		-- [[Karazhan]]
		29323, -- Absorb Vitality
		29540, -- Curse of Past Burdens
		29618, -- Burning Brand
		29684, -- Shield Slam
		29546, -- Oath of Fealty
		29690, -- Drunken Skull Crack
		29497, -- Jealousy
		29491, -- Impending Betrayal
		29490, -- Seduction
		29505, -- Banshee Shriek
		29670, -- Ice Tomb
		29679, -- Bad Poetry
		29768, -- Overload
		29882, -- Loose Mana
		29900, -- Unstable Magic
		29942, -- Infected Blood
		18812, -- Knockdown
		-- Attumen the Huntsman
		29711, -- Knockdown
		-- 29833, -- Intangible Presence
		-- Moroes
		37066, -- Garrote
		29425, -- Gouge
		34694, -- Blind
		13005, -- Hammer of Justice
		-- Maiden of Virtue
		29512, -- Holy Ground
		29511, -- Repentance
		29522, -- Holy Fire
		-- Opera Hall
		30822, -- Poisoned Thrust
		30889, -- Powerful Attraction
		30890, -- Blinding Passion
		30761, -- Wide Swipe
		30752, -- Terrifying Howl
		31042, -- Shred Armor
		31046, -- Brain Bash
		31013, -- Frightened Scream
		31069, -- Brain Wipe
		-- Prince Malchezaar
		39095, -- Amplify Damage
		30843, -- Enfeeble
		30898, -- Shadow Word: Pain
		30854, -- Shadow Word: Pain
		-- Shade of Aran 
		29951, -- Blizzard
		29946, -- Flame Wreath
		30035, -- Mass Slow
		29991, -- Chains of Ice
		29964, -- Dragon's Breath
		29990, -- Slow
		-- Terestian Illhoof
		30115, -- Sacrifice
		30053, -- Amplify Flames
		-- Netherspite
		38637, -- Nether Exhaustion
		38638, -- Nether Exhaustion
		38639, -- Nether Exhaustion
		30421, -- Nether Portal - Perseverence
		30422, -- Nether Portal - Serenity
		30423, -- Nether Portal - Dominance
		-- Nightbane
		38927, -- Fel Ache
		30210, -- Smoldering Breath
		30129, -- Charred Earth
		25653, -- Tail Sweep
		30130, -- Distracting Ash
		36922, -- Bellowing Roar
		22686, -- Bellowing Roar
		-- [[World boss]]
		-- Doom Lord Kazzak
		21063, -- Twisted Reflection
		32960, -- Mark of Kazzak
		-- Doomwalker
		33661, -- Crush Armor
		32686  -- Earthquake
	);

	--  TBCC phase 2
	VUHDO_addCustomSpellIds(50, 
		-- [[ Serpentshrine Cavern ]]
		-- Trash
		38924,   -- Spore Burst
		39044,   -- Serpentshrine Parasite
		38971,   -- Acid Geyser
		38491,   -- Silence
		38591,   -- Shatter Armor
		38585,   -- Holy Fire
		38572,   -- Mortal Cleave
		-- 38603,   -- Corrupt Devotion Aura
		38635,   -- Rain of Fire
		38634,   -- Arcane Lightning
		39029,   -- Virulent Poison
		38655,   -- Poison Bolt Volley
		39032,   -- Initial Infection
		39015,   -- Atrophic Blow
		38626,   -- Domination
		39042,   -- Rampant Infection
		38652,   -- Spore Cloud
		38653,   -- Spore Cloud
		37641,   -- Whirlwind
		-- Hydross the Unstable
		38246,   -- Vile Sludge
		-- 38215,   -- Mark of Hydross - 10%
		-- 38216,   -- Mark of Hydross - 25%
		-- 38217,   -- Mark of Hydross - 50%
		-- 38218,   -- Mark of Hydross - 100%
		-- 38231,   -- Mark of Hydross - 250%
		-- 40584,   -- Mark of Hydross - 500%
		38235,   -- Water Tomb
		-- 38219,   -- Mark of Corruption - 10%
		-- 38220,   -- Mark of Corruption - 25%
		-- 38221,   -- Mark of Corruption - 50%
		-- 38222,   -- Mark of Corruption - 100%
		-- 38230,   -- Mark of Corruption - 250%
		-- 40583,   -- Mark of Corruption - 500%
		-- The Lurker Below 
		37284,   -- Scalding Water
		-- Leotheras the Blind
		37675,   -- Chaos Blast
		37676,   -- Insidious Whisper
		37749,   -- Consuming Madness
		37527,   -- Banish
		-- Fathom-Lord Karathress
		-- 39261,   -- Gusting Winds
		38441,   -- Cataclysmic Bolt
		29436,   -- Leeching Throw
		-- Morogrim Tidewalker
		38187,   -- Pierce Armor
		41932,   -- Carnivorous Bite
		-- 37730,   -- Tidal Wave
		38023,   -- Watery Grave
		38024,   -- Watery Grave
		38025,   -- Watery Grave
		37850,   -- Watery Grave
		-- Lady Vashj 
		38258,   -- Panic
		38132,   -- Paralyze
		38253,   -- Poison Bolt
		38280,   -- Static Charge
		38316,   -- Entangle
		38575,   -- Toxic Spores
		38511,   -- Persuasion
		38509,   -- Shock Blast
		-- [[ Tempest Keep  ]]
		-- Trash
		37124,  -- Starfall
		37122,  -- Domination
		39077,  -- Hammer of Justice
		37160,  -- Silence
		37155,  -- Immolation
		37118,  -- Shell Shock
		37120,  -- Fragmentation Bomb
		37123,  -- Saw Blade
		37132,  -- Arcane Shock
		37279,  -- Rain of Fire
		-- 37133,  -- Arcane Buffet
		37275,  -- Shadow Word: Pain
		37276,  -- Mind Flay
		37263,  -- Blizzard
		-- Al'ar
		35383,  -- Flame Patch
		35410,  -- Melt Armor
		34121,  -- Flame Buffet
		35412,  -- Charge
		-- Void Reaver
		34190,  -- Arcane Orb
		-- High Astromancer Solarian
		33044,  -- Wrath of the Astromancer
		33045,  -- Wrath of the Astromancer
		33040,  -- Wrath of the Astromancer
		33048,  -- Wrath of the Astromancer
		33049,  -- Wrath of the Astromancer
		-- 33023,  -- Mark of Solarian
		-- 33390,  -- Arcane Torrent
		-- Kael'thas Sunstrider
		37027,  -- Remote Toy
		30225,  -- Silence
		37018,  -- Conflagration
		36991,  -- Rend
		36965,  -- Rend
		--36970,  -- Arcane Burst
		44863,  -- Bellowing Roar
		36797,  -- Mind Control
		36834,  -- Arcane Disruption
		36482,  -- Armor Disruption
		36731,  -- Flame Strike
		36478,  -- Magic Disruption
		35859   -- Nether Vapor
	);

	--  TBCC phase 3
	VUHDO_addCustomSpellIds(51, 
		-- [[ Black Temple ]]
		-- Trash
		41170,  -- Curse of the Bleakheart
		41334,  -- Polymorph
		39580,  -- Lightning Cloud
		39647,  -- Curse of Mending
		-- 40099,  -- Vile Slime
		40103,  -- Sludge Nova
		-- 41382,  -- Blizzard
		41346,  -- Poisonous Throw
		41406,  -- Dementia
		13444,  -- Sunder Armor
		39672,  -- Curse of Agony
		41351,  -- Curse of Vitality
		39665,  -- Wound Poison
		41345,  -- Infatuation
		41409,  -- Dementia
		24698,  -- Gouge
		41193,  -- Cloud of Disease
		40078,  -- Poison Spit
		40090,  -- Hurricane
		25646,  -- Mortal Wound
		41190,  -- Mind-numbing Poison
		41355,  -- Shadow Word: Pain
		32588,  -- Concussion Blow
		41186,  -- Wyvern Sting
		24336,  -- Wyvern Sting
		13005,  -- Hammer of Justice
		41171,  -- Skeleton Shot
		6945,   -- Chest Pains
		41392,  -- Riposte
		41338,  -- Love Tap
		40892,  -- Fixate
		-- 40946,  -- Rain of Chaos
		-- 39671,  -- Rain of Chaos
		40864,  -- Throbbing Stun
		39674,  -- Banish
		3609,   -- Paralyzing Poison
		41213,  -- Throw Shield
		34654,  -- Blind
		40936,  -- War Stomp
		41238,  -- Blood Drain
		41978,  -- Debilitating Poison
		41150,  -- Fear
		41274,  -- Fel Stomp
		41396,  -- Sleep
		41468,  -- Hammer of Justice
		-- High Warlod Naj'entus
		39837,  -- Impaling Spine
		-- Supremus
		40953,  -- Immolation
		40253,  -- Molten Flame
		-- 40875,  -- Freeze
		-- Shade of Akama
		-- 41092,  -- Carnivorous Bite
		-- 42023,  -- Rain of Fire
		41047,  -- Shadow Resonance
		-- Teron Gorefiend
		40251,  -- Shadow of Death
		40243,  -- Crushing Shadows
		40239,  -- Incinerate
		-- Reliquary of Souls
		41294,  -- Fixate
		41426,  -- Spirit Shock
		41303,  -- Soul Drain
		41376,  -- Spite
		41377,  -- Spite
		41410,  -- Deaden
		-- Gurtogg Bloodboil
		40481,  -- Acidic Wound
		42005,  -- Bloodboil
		40604,  -- Fel Rage
		40508,  -- Fel-Acid Breath
		40491,  -- Bewildering Strike
		40597,  -- Eject
		40599,  -- Arcing Smash
		-- Mother Shahraz
		41001,  -- Fatal Attraction
		40860,  -- Vile Beam
		-- The Illidari Council
		-- 41541,  -- Consecration
		-- 41482,  -- Blizzard
		-- 41481,  -- Flamestrike
		41461,  -- Judgement of Blood
		41485,  -- Deadly Poison
		41472,  -- Divine Wrath
		-- Illidan Stormrage
		41917,  -- Parasitic Shadowfiend
		41914,  -- Parasitic Shadowfiend
		40932,  -- Agonizing Flames
		40585,  -- Dark Barrage
		-- [[ Hyjal Summit ]]
		-- Trash
		31651,  -- Banshee Curse
		31724,  -- Flame Buffet
		31610,  -- Knockdown
		42205,  -- Residue of Eternity
		42201,  -- Eternal Silence
		-- Rage Winterchill
		31258,  -- Death & Decay
		31249,  -- Icebolt
		31250,  -- Frost Nova
		-- Anetheron
		31306,  -- Carrion Swarm
		31298,  -- Sleep
		-- Kaz'rogal
		31477,  -- Cripple
		31480,  -- War Stomp
		-- 31447,  -- Mark of Kaz'rogal
		-- Azgalor
		31341,  -- Unquenchable Flames
		31406,  -- Cripple
		-- 31340,  -- Rain of Fire
		31408,  -- War Stomp
		31347,  -- Doom
		-- Archimonde
		31944,  -- Doomfire
		31972,  -- Grip of the Legion
		32014,  -- Air Burst
		31970   -- Fear
	);

	--  TBCC phase 4
	VUHDO_addCustomSpellIds(52, 
		-- [[ Zul'Aman ]]
		-- Trash
		43362,  -- Electrified Net
		43359,  -- Call of the Beast
		43530,  -- Piercing Howl
		42497,  -- Furious Roar
		43361,  -- Domesticate
		20989,  -- Sleep
		43529,  -- Mortal Strike
		43364,  -- Tranquilizing Poison
		35011,  -- Knockdown
		43358,  -- Gut Rip
		43356,  -- Pounce
		-- Akil'zon
		44008,  -- Static Disruption
		43621,  -- Gust of Wind
		--43648,  -- Electrical Storm
		-- Nalorakk
		44955,  -- Mangle
		42395,  -- Lacerating Slash
		42397,  -- Rend Flesh
		-- 42398,  -- Deafening Roar
		-- Jan'alai
		43140,  -- Flame Breath
		-- Halazzi
		43303,  -- Flame Shock
		43243,  -- Shred Armor
		-- Hex Lord Malacrass
		43501,  -- Siphon Soul
		43522,  -- Unstable Affliction
		43439,  -- Curse of Doom
		43446,  -- Explosive Trap Effect
		43590,  -- Psychic Wail
		43448,  -- Freezing Trap
		-- Zul'jin
		43150,  -- Claw Rage
		43095,  -- Creeping Paralysis
		43437,  -- Paralyzed
		43093   -- Grievous Throw
	);

	--  TBCC phase 5
	VUHDO_addCustomSpellIds(53, 
		-- [[ Sunwell Plateau ]]
		-- Trash
		46557, -- Slaying Shot
		--39171, -- Mortal Strike
		46543,  -- Ignite Mana
		46560,  -- Shadow Word: Pain
		46562,  -- Mind Flay
		46561,  -- Fear
		46469,  -- Melt Armor
		46279,  -- Flame Buffet
		46297,  -- Piercing Shadow
		46298,  -- Shrink
		46294,  -- Fevered Fatigue
		46299,  -- Wavering Will
		46293,  -- Corrosive Poison
		46295,  -- Hex
		46296,  -- Necrotic Poison
		--45770,  -- Shadow Bolt Volley
		46466,  -- Drain Life
		45029,  -- Corrupting Strike
		46283,  -- Death Coil
		46427,  -- Domination
		46483,  -- Volatile Disease
		-- Kalecgos
		45034,  -- Curse of Boundless Agony
		45032,  -- Curse of Boundless Agony
		45004,  -- Wild Magic
		44978,  -- Wild Magic
		45001,  -- Wild Magic
		--45002,  -- Wild Magic
		45006,  -- Wild Magic
		45010,  -- Wild Magic
		45029,  -- Corrupting Strike
		-- Brutallus
		45150,  -- Meteor Slash
		46394,  -- Burn
		45185,  -- Stomp
		-- Felmyst
		45717,  -- Fog of Corruption
		45866,  -- Corrosion
		45855,  -- Gas Nova
		45662,  -- Encapsulate
		45402,  -- Demonic Vapor
		-- Eredar Twins
		46771,  -- Flame Sear
		45348,  -- Flame Touched
		45347,  -- Dark Touched
		--45271,  -- Dark Strike
		45256,  -- Confounding Blow
		45342,  -- Conflagration
		45270,  -- Shadowfury
		-- M'uru
		45996,  -- Darkness
		-- Kil'jaeden
		45641,  -- Fire Bloom
		45442,  -- Soul Flay
		45885,  -- Shadow Spike
		46190  -- Curse of Agony
	);

	local debuffRemovalList = {};

	for tIndex, tName in pairs(VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED"]) do
		-- I introduced a bug which added some default custom debuffs by spell ID
		-- where spell ID was a number and not a string, this causes all sorts of odd 
		-- bugs in the custom debuff code particularly any getKeyFromValue table lookups
		if (type(tName) == "number") then
			-- if we encounter a custom debuff stored by an actual number flag this key for removal
			debuffRemovalList[tIndex] = tIndex;
		else
			VUHDO_customDebuffsAddDefaultSettings(tName);
			VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tName] = VUHDO_ensureSanity(
				"CUSTOM_DEBUFF.STORED_SETTINGS",
				VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED_SETTINGS"][tName],
				VUHDO_DEFAULT_CU_DE_STORED_SETTINGS
			);
		end
	end

	-- in Lua removal can't be done in place while perserving order properly
	-- so do the removal in a second pass
	for tIndex, _ in pairs(debuffRemovalList) do
		VUHDO_CONFIG["CUSTOM_DEBUFF"]["STORED"][tIndex] = nil;
	end

	-- add default spells to track with spell trace
	VUHDO_addSpellTraceSpellIds(1, 
		-- Shaman
		1064,   -- Chain Heal
		-- Priest
		34861,  -- Holy Word: Sanctify
		596,    -- Prayer of Healing
		194509  -- Power Word: Radiance
	);

	for tIndex, tName in pairs(VUHDO_CONFIG["SPELL_TRACE"]["STORED"]) do
		VUHDO_spellTraceAddDefaultSettings(tName);

		VUHDO_CONFIG["SPELL_TRACE"]["STORED_SETTINGS"][tName] = VUHDO_ensureSanity(
			"SPELL_TRACE.STORED_SETTINGS",
			VUHDO_CONFIG["SPELL_TRACE"]["STORED_SETTINGS"][tName],
			VUHDO_DEFAULT_SPELL_TRACE_STORED_SETTINGS
		);
	end

	if (VUHDO_POWER_TYPE_COLORS == nil) then
		VUHDO_POWER_TYPE_COLORS = VUHDO_decompressOrCopy(VUHDO_DEFAULT_POWER_TYPE_COLORS);
	end
	VUHDO_POWER_TYPE_COLORS = VUHDO_ensureSanity("VUHDO_POWER_TYPE_COLORS", VUHDO_POWER_TYPE_COLORS, VUHDO_DEFAULT_POWER_TYPE_COLORS);
	VUHDO_DEFAULT_POWER_TYPE_COLORS = VUHDO_compressAndPackTable(VUHDO_DEFAULT_POWER_TYPE_COLORS);
end



local VUHDO_DEFAULT_PANEL_SETUP = {
	["RAID_ICON_FILTER"] = {
		[1] = true,
		[2] = true,
		[3] = true,
		[4] = true,
		[5] = true,
		[6] = true,
		[7] = true,
		[8] = true
	},

	["HOTS"] = {
		["radioValue"] = 13,
		["iconRadioValue"] = 1,
		["stacksRadioValue"] = 2,

		["TIMER_TEXT"] = {
			["ANCHOR"] = "BOTTOMRIGHT",
			["X_ADJUST"] = 25,
			["Y_ADJUST"] = 0,
			["SCALE"] = 60,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_SHADOW"] = false,
			["USE_OUTLINE"] = true,
			["USE_MONO"] = false,
		},

		["COUNTER_TEXT"] = {
			["ANCHOR"] = "TOP",
			["X_ADJUST"] = -25,
			["Y_ADJUST"] = 0,
			["SCALE"] = 66,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_SHADOW"] = false,
			["USE_OUTLINE"] = true,
			["USE_MONO"] = false,
		},

		["SLOTS"] = {
			["firstFlood"] = true,
		},

		["SLOTCFG"] = {
			["firstFlood"] = true,
			["1"] = { ["mine"] = true, ["others"] = false, ["scale"] = 1 },
			["2"] = { ["mine"] = true, ["others"] = false, ["scale"] = 1 },
			["3"] = { ["mine"] = true, ["others"] = false, ["scale"] = 1 },
			["4"] = { ["mine"] = true, ["others"] = false, ["scale"] = 1 },
			["5"] = { ["mine"] = true, ["others"] = false, ["scale"] = 1 },
			["6"] = { ["mine"] = true, ["others"] = false, ["scale"] = 1 },
			["7"] = { ["mine"] = true, ["others"] = false, ["scale"] = 1 },
			["8"] = { ["mine"] = true, ["others"] = false, ["scale"] = 1 },
			["9"] = { ["mine"] = true, ["others"] = false, ["scale"] = 1 },
			["10"] = { ["mine"] = true, ["others"] = false, ["scale"] = 1.5 },
		},

		["BARS"] = {
			["radioValue"] = 1,
			["width"] = 25,
		},
	},

	["PANEL_COLOR"] = {
		["TEXT"] = {
			["TR"] = 1, ["TG"] = 0.82, ["TB"] = 0, ["TO"] = 1,
			["useText"] = true,
		},
		["HEALTH_TEXT"] = {
			["useText"] = false,
			["TR"] = 1, ["TG"] = 0, ["TB"] = 0, ["TO"] = 1,
		},
		["BARS"] = {
			["R"] = 0.7, ["G"] = 0.7, ["B"] = 0.7, ["O"] = 1,
			["useBackground"] = true, ["useOpacity"] = true,
		},
		["classColorsName"] = false,
	},

	["BAR_COLORS"] = {

		["TARGET"] = {
			["TR"] = 1,	["TG"] = 1,	["TB"] = 1,	["TO"] = 1,
			["R"] = 0,	["G"] = 1,	["B"] = 0,	["O"] = 1,
			["useText"] = true, ["useBackground"] = true, ["useOpacity"] = true,
			["modeText"] = 2, -- 1=enemy, 2=solid, 3=class color, 4=gradient
			["modeBack"] = 1
		},

		["IRRELEVANT"] =  {
			["R"] = 0, ["G"] = 0, ["B"] = 0.4, ["O"] = 0.2,
			["TR"] = 1, ["TG"] = 0.82, ["TB"] = 0, ["TO"] = 1,
			["useText"] = false, ["useBackground"] = false, ["useOpacity"] = true,
			["useClassColor"] = false,
		},
		["INCOMING"] = {
			["R"] = 0, ["G"] = 0, ["B"] = 0, ["O"] = 0.33,
			["TR"] = 1, ["TG"] = 0.82, ["TB"] = 0, ["TO"] = 1,
			["useText"] = false, ["useBackground"] = false,	["useOpacity"] = true,
			["useClassColor"] = false,
		},
		["SHIELD"] = {
			["R"] = 0.35, ["G"] = 0.52, ["B"] = 1, ["O"] = 1,
			["TR"] = 0.35, ["TG"] = 0.52, ["TB"] = 1, ["TO"] = 1,
			["useText"] = false, ["useBackground"] = true,	["useOpacity"] = true,
			["useClassColor"] = false,
		},
		["OVERSHIELD"] = {
			["R"] = 0.35, ["G"] = 0.52, ["B"] = 1, ["O"] = 1,
			["TR"] = 0.35, ["TG"] = 0.52, ["TB"] = 1, ["TO"] = 1,
			["useText"] = false, ["useBackground"] = true,	["useOpacity"] = true,
			["useClassColor"] = false,
		},
		["HEAL_ABSORB"] = {
			["R"] = 1, ["G"] = 0.4, ["B"] = 0.4, ["O"] = 1,
			["TR"] = 0.35, ["TG"] = 0.52, ["TB"] = 1, ["TO"] = 1,
			["useText"] = false, ["useBackground"] = true,	["useOpacity"] = true,
			["useClassColor"] = false,
		},
		["DIRECTION"] = {
			["R"] = 1, ["G"] = 0.4, ["B"] = 0.4, ["O"] = 1,
			["useBackground"] = true,
		},
		["EMERGENCY"] = VUHDO_makeFullColor(1, 0, 0, 1,   1, 0.82, 0, 1),
		["NO_EMERGENCY"] = VUHDO_makeFullColor(0, 0, 0.4, 1,   1, 0.82, 0, 1),
		["OFFLINE"] = VUHDO_makeFullColor(0.298, 0.298, 0.298, 0.21,   0.576, 0.576, 0.576, 0.58),
		["DEAD"] = VUHDO_makeFullColor(0.3, 0.3, 0.3, 0.5,   0.5, 0.5, 0.5, 1),
		["OUTRANGED"] = {
			["R"] = 0, ["G"] = 0, ["B"] = 0, ["O"] = 0.25,
			["TR"] = 0, ["TG"] = 0, ["TB"] = 0, ["TO"] = 0.5,
			["useText"] = false, ["useBackground"] = false, ["useOpacity"] = true,
		},
		["TAPPED"] = VUHDO_makeFullColor(0.4, 0.4, 0.4, 1,   0.4, 0.4, 0.4, 1),
		["TARGET_FRIEND"] = VUHDO_makeFullColor(0, 1, 0, 1,   0, 1, 0, 1),
		["TARGET_NEUTRAL"] = VUHDO_makeFullColor(1, 1, 0, 1,   1, 1, 0, 1),
		["TARGET_ENEMY"] = VUHDO_makeFullColor(1, 0, 0, 1,   1, 0, 0, 1),

		["DEBUFF" .. VUHDO_DEBUFF_TYPE_NONE] =  {
			["useText"] = false, ["useBackground"] = false, ["useOpacity"] = false,
		},
		["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON] = VUHDO_makeFullColor(0, 0.592, 0.8, 1,   0, 1, 0.686, 1),
		["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE] = VUHDO_makeFullColor(0.8, 0.4, 0.4, 1,   1, 0, 0, 1),
		["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE] = VUHDO_makeFullColor(0.7, 0, 0.7, 1,   1, 0, 1, 1),
		["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC] = VUHDO_makeFullColor(0.4, 0.4, 0.8, 1,   0.329, 0.957, 1, 1),
		["DEBUFF" .. VUHDO_DEBUFF_TYPE_CUSTOM] = VUHDO_makeFullColor(0.6, 0.3, 0, 1,   0.8, 0.5, 0, 1),
		["DEBUFF_BAR_GLOW"] = VUHDO_makeFullColor(0.95, 0.95, 0.32, 1,   1, 1, 0, 1),
		["DEBUFF_ICON_GLOW"] = VUHDO_makeFullColor(0.95, 0.95, 0.32, 1,   1, 1, 0, 1),
		["CHARMED"] = VUHDO_makeFullColor(0.51, 0.082, 0.263, 1,   1, 0.31, 0.31, 1),

		["BAR_FRAMES"] = {
			["R"] = 0, ["G"] = 0, ["B"] = 0, ["O"] = 0.7,
			["useBackground"] = true, ["useOpacity"] = true,
		},

		["OVERHEAL_TEXT"] = {
			["TR"] = 0.8, ["TG"] = 1, ["TB"] = 0.8, ["TO"] = 1,
			["useText"] = true, ["useOpacity"] = true,
		},

		["HOTS"] = {
			["useColorText"] = true,
			["useColorBack"] = true,
			["isFadeOut"] = false,
			["isFlashWhenLow"] = false,
			["showShieldAbsorb"] = true,
			["isPumpDivineAegis"] = false,
			["WARNING"] = {
				["R"] = 0.5, ["G"] = 0.2,	["B"] = 0.2, ["O"] = 1,
				["TR"] = 1,	["TG"] = 0.6,	["TB"] = 0.6,	["TO"] = 1,
				["useText"] = true,	["useBackground"] = true,
				["lowSecs"] = 3, ["enabled"] = false,
			},
		},

		["HOT1"] = VUHDO_makeHotColor(1, 0.3, 0.3, 1,   1, 0.6, 0.6, 1),
		["HOT2"] = VUHDO_makeHotColor(1, 1, 0.3, 1,   1, 1, 0.6, 1),
		["HOT3"] = VUHDO_makeHotColor(1, 1, 1, 1,   1, 1, 1, 1),
		["HOT4"] = VUHDO_makeHotColor(0.3, 0.3, 1, 1,   0.6, 0.6, 1, 1),
		["HOT5"] = VUHDO_makeHotColor(1, 0.3, 1, 1,   1, 0.6, 1, 1),

		["HOT6"] = {
			["R"] = 1, ["G"] = 1, ["B"] = 1, ["O"] = 0.75,
			["useBackground"] = true,
		},

		["HOT7"] = {
			["R"] = 1, ["G"] = 1, ["B"] = 1, ["O"] = 0.75,
			["useBackground"] = true,
		},

		["HOT8"] = {
			["R"] = 1, ["G"] = 1, ["B"] = 1, ["O"] = 0.75,
			["useBackground"] = true,
		},

		["HOT9"] = VUHDO_makeHotColor(0.3, 1, 1, 1,   0.6, 1, 1, 1),
		["HOT10"] = VUHDO_makeHotColor(0.3, 1, 0.3, 1,   0.6, 1, 0.3, 1),

		["HOT_CHARGE_2"] = VUHDO_makeFullColorWoOpacity(1, 1, 0.3, 1,   1, 1, 0.6, 1),
		["HOT_CHARGE_3"] = VUHDO_makeFullColorWoOpacity(0.3, 1, 0.3, 1,   0.6, 1, 0.6, 1),
		["HOT_CHARGE_4"] = VUHDO_makeFullColorWoOpacity(0.8, 0.8, 0.8, 1,   1, 1, 1, 1),

		["useDebuffIcon"] = false,
		["useDebuffIconBossOnly"] = true,

		["RAID_ICONS"] = {
			["enable"] = false,
			["filterOnly"] = false,

			["1"] = VUHDO_makeFullColorWoOpacity(1, 0.976, 0.305, 1,   0.980,	1, 0.607, 1),
			["2"] = VUHDO_makeFullColorWoOpacity(1, 0.513, 0.039, 1,   1, 0.827, 0.419, 1),
			["3"] = VUHDO_makeFullColorWoOpacity(0.788, 0.290, 0.8, 1,   1, 0.674, 0.921, 1),
			["4"] = VUHDO_makeFullColorWoOpacity(0, 0.8, 0.015, 1,   0.698, 1, 0.698, 1),
			["5"] = VUHDO_makeFullColorWoOpacity(0.466, 0.717, 0.8, 1,   0.725, 0.870, 1, 1),
			["6"] = VUHDO_makeFullColorWoOpacity(0.121, 0.690, 0.972, 1,   0.662, 0.831, 1, 1),
			["7"] = VUHDO_makeFullColorWoOpacity(0.8, 0.184, 0.129, 1,   1, 0.627, 0.619, 1),
			["8"] = VUHDO_makeFullColorWoOpacity(0.847, 0.866, 0.890, 1,   0.231, 0.231, 0.231, 1),
		},

		["CLUSTER_FAIR"] = VUHDO_makeFullColorWoOpacity(0.8, 0.8, 0, 1,   1, 1, 0, 1),
		["CLUSTER_GOOD"] = VUHDO_makeFullColorWoOpacity(0, 0.8, 0, 1,   0, 1, 0, 1),

		["GCD_BAR"] = {
			["R"] = 0.4, ["G"] = 0.4, ["B"] = 0.4, ["O"] = 0.5,
			["useBackground"] = true,
		},

		["LIFE_LEFT"] = {
			["LOW"] = {
				["R"] = 1, ["G"] = 0, ["B"] = 0, ["O"] = 1,
				["useBackground"] = true,
			},
			["FAIR"] = {
				["R"] = 1, ["G"] = 1, ["B"] = 0, ["O"] = 1,
				["useBackground"] = true,
			},
			["GOOD"] = {
				["R"] = 0, ["G"] = 1, ["B"] = 0, ["O"] = 1,
				["useBackground"] = true,
			},
		},

		["THREAT"] = {
			["HIGH"] = {
				["R"] = 1, ["G"] = 0, ["B"] = 1, ["O"] = 1,
				["useBackground"] = true,
			},
			["LOW"] = {
				["R"] = 0, ["G"] = 1, ["B"] = 1, ["O"] = 1,
				["useBackground"] = true,
			},
		},
	}, -- BAR_COLORS
};



--
local VUHDO_DEFAULT_PER_PANEL_SETUP = {
	["HOTS"] = {
		["size"] = 40,
	},
	["MODEL"] = {
		["ordering"] = VUHDO_ORDERING_STRICT,
		["sort"] = VUHDO_SORT_RAID_UNITID,
		["isReverse"] = false,
	},
--[[
	["POSITION"] = {
		["x"] = 100,
		["y"] = 668,
		["relativePoint"] = "BOTTOMLEFT",
		["orientation"] = "TOPLEFT",
		["growth"] = "TOPLEFT",
		["width"] = 200,
		["height"] = 200,
		["scale"] = 1,
	};
]]--

	["SCALING"] = {
		["columnSpacing"] = 5,
		["rowSpacing"] = 2,

		["borderGapX"] = 5,
		["borderGapY"] = 5,

		["barWidth"] = 80,
		["barHeight"] = 40,

		["showHeaders"] = true,
		["headerHeight"] = 12,
		["headerWidth"] = 100,
		["headerSpacing"] = 5,

		["manaBarHeight"] = 6,
		["sideLeftWidth"] = 6,
		["sideRightWidth"] = 6,

		["maxColumnsWhenStructured"] = 10,
		["maxRowsWhenLoose"] = 5,
		["ommitEmptyWhenStructured"] = true,
		["isPlayerOnTop"] = true,

		["showTarget"] = false,
		["targetSpacing"] = 3,
		["targetWidth"] = 30,

		["showTot"] = false,
		["totSpacing"] = 3,
		["totWidth"] = 30,
		["targetOrientation"] = 1;

		["isTarClassColText"] = true,
		["isTarClassColBack"] = false,

		["arrangeHorizontal"] = false,
		["alignBottom"] = false,

		["scale"] = 1,

		["isDamFlash"] = true,
		["damFlashFactor"] = 0.75,
	},

	["LIFE_TEXT"] = {
		["show"] = true,
		["mode"] = VUHDO_LT_MODE_PERCENT,
		["position"] = VUHDO_LT_POS_ABOVE,
		["verbose"] = false,
		["hideIrrelevant"] = false,
		["showTotalHp"] = false;
	},

	["ID_TEXT"] = {
		["showName"] = true, 
		["showNickname"] = false,
		["showClass"] = false,
		["showTags"] = true,
		["showPetOwners"] = true,
		["position"] = "CENTER+CENTER",
		["xAdjust"] = 0.000001,
		["yAdjust"] = 0.000001,
	},

	["PANEL_COLOR"] = {
		["barTexture"] = "VuhDo - Polished Wood",

		["BACK"] = {
			["R"] = 0, ["G"] = 0, ["B"] = 0, ["O"] = 0.35,
			["useBackground"] = true, ["useOpacity"] = true,
		},

		["BORDER"] = {
			["R"] = 0, ["G"] = 0, ["B"] = 0, ["O"] = 0.46,
			["useBackground"] = true, ["useOpacity"] = true,
			["file"] = "Interface\\Tooltips\\UI-Tooltip-Border",
			["edgeSize"] = 8,
			["insets"] = 1,
		},

		["TEXT"] = {
			["useText"] = true, ["useOpacity"] = true,
			["textSize"] = 10,
			["textSizeLife"] = 8,
			["maxChars"] = 0,
			["outline"] = false,
			["USE_SHADOW"] = true,
			["USE_MONO"] = false,
		},

		["HEADER"] = {
			["R"] = 1, ["G"] = 1, ["B"] = 1, ["O"] = 0.4,
			["TR"] = 1, ["TG"] = 0.859, ["TB"] = 0.38, ["TO"] = 1,
			["useText"] = true, ["useBackground"] = true,
			["barTexture"] = "LiteStepLite",
			["textSize"] = 10,
		},
	},

	["TOOLTIP"] = {
		["show"] = true,
		["position"] = 2, -- Standard-Pos
		["inFight"] = false,
		["showBuffs"] = false,
		["x"] = 100,
		["y"] = -100,
		["point"] = "TOPLEFT",
		["relativePoint"] = "TOPLEFT",
		["SCALE"] = 1,

		["BACKGROUND"] = {
			["R"] = 0, ["G"] = 0, ["B"] = 0, ["O"] = 1,
			["useBackground"] = true, ["useOpacity"] = true,
		},

		["BORDER"] = {
			["R"] = 0, ["G"] = 0, ["B"] = 0, ["O"] = 1,
			["useBackground"] = true, ["useOpacity"] = true,
		},
	},

	["RAID_ICON"] = {
		["show"] = true,
		["scale"] = 1,
		["point"] = "TOP",
		["xAdjust"] = 0,
		["yAdjust"] = -20,
	},

	["OVERHEAL_TEXT"] = {
		["show"] = true,
		["scale"] = 1,
		["point"] = "LEFT",
		["xAdjust"] = 0,
		["yAdjust"] = 0,
	},

	["frameStrata"] = "MEDIUM",
};



--
function VUHDO_loadDefaultPanelSetup()
	local tAktPanel;

	if not VUHDO_PANEL_SETUP then
		VUHDO_PANEL_SETUP = VUHDO_decompressOrCopy(VUHDO_DEFAULT_PANEL_SETUP);
	end

	for tPanelNum = 1, 10 do -- VUHDO_MAX_PANELS
		if not VUHDO_PANEL_SETUP[tPanelNum] then
			VUHDO_PANEL_SETUP[tPanelNum] = VUHDO_decompressOrCopy(VUHDO_DEFAULT_PER_PANEL_SETUP);

			tAktPanel = VUHDO_PANEL_SETUP[tPanelNum];
			tAktPanel["MODEL"]["groups"] = VUHDO_DEFAULT_MODELS[tPanelNum];

			if VUHDO_DEFAULT_MODELS[tPanelNum] and VUHDO_ID_PRIVATE_TANKS == VUHDO_DEFAULT_MODELS[tPanelNum][1] then
				tAktPanel["SCALING"]["ommitEmptyWhenStructured"] = false;
			end

			if GetLocale() == "zhCN" or GetLocale() == "zhTW" or GetLocale() == "koKR" then
				tAktPanel["PANEL_COLOR"]["TEXT"]["font"] = "";
				tAktPanel["PANEL_COLOR"]["HEADER"]["font"] = "";
			else
				tAktPanel["PANEL_COLOR"]["TEXT"]["font"] = VUHDO_LibSharedMedia:Fetch('font', "Emblem");
				tAktPanel["PANEL_COLOR"]["HEADER"]["font"] = VUHDO_LibSharedMedia:Fetch('font', "Emblem");
			end

			if VUHDO_DEFAULT_MODELS[tPanelNum] and VUHDO_ID_MAINTANKS == VUHDO_DEFAULT_MODELS[tPanelNum][1] then
				tAktPanel["PANEL_COLOR"]["TEXT"]["textSize"] = 12;
			end
		end
	end

	for tPanelNum = 1, 10 do -- VUHDO_MAX_PANELS
		if not VUHDO_PANEL_SETUP[tPanelNum]["POSITION"] and tPanelNum == 1 then
			VUHDO_PANEL_SETUP[tPanelNum]["POSITION"] = {
				["x"] = 130,
				["y"] = 650,
				["relativePoint"] = "BOTTOMLEFT",
				["orientation"] = "TOPLEFT",
				["growth"] = "TOPLEFT",
				["width"] = 200,
				["height"] = 200,
				["scale"] = 1,
			};
		elseif not VUHDO_PANEL_SETUP[tPanelNum]["POSITION"] and tPanelNum == 2 then
			VUHDO_PANEL_SETUP[tPanelNum]["POSITION"] = {
				["x"] = 130,
				["y"] = 885,
				["relativePoint"] = "BOTTOMLEFT",
				["orientation"] = "TOPLEFT",
				["growth"] = "TOPLEFT",
				["width"] = 200,
				["height"] = 200,
				["scale"] = 1,
			};
		elseif not VUHDO_PANEL_SETUP[tPanelNum]["POSITION"] then
			VUHDO_PANEL_SETUP[tPanelNum]["POSITION"] = {
				["x"] = 130 + 75 * tPanelNum,
				["y"] = 650 - 75 * tPanelNum,
				["relativePoint"] = "BOTTOMLEFT",
				["orientation"] = "TOPLEFT",
				["growth"] = "TOPLEFT",
				["width"] = 200,
				["height"] = 200,
				["scale"] = 1,
			};
		end

		VUHDO_PANEL_SETUP[tPanelNum] = VUHDO_ensureSanity("VUHDO_PANEL_SETUP[" .. tPanelNum .. "]", VUHDO_PANEL_SETUP[tPanelNum], VUHDO_DEFAULT_PER_PANEL_SETUP);
	end
	
	VUHDO_PANEL_SETUP = VUHDO_ensureSanity("VUHDO_PANEL_SETUP", VUHDO_PANEL_SETUP, VUHDO_DEFAULT_PANEL_SETUP);
	VUHDO_DEFAULT_PANEL_SETUP = VUHDO_compressAndPackTable(VUHDO_DEFAULT_PANEL_SETUP);
	VUHDO_DEFAULT_PER_PANEL_SETUP = VUHDO_compressAndPackTable(VUHDO_DEFAULT_PER_PANEL_SETUP);

	VUHDO_fixHotSettings();
end



local VUHDO_DEFAULT_BUFF_CONFIG = {
  ["VERSION"] = 4,
	["SHOW"] = true,
	["COMPACT"] = true,
	["SHOW_LABEL"] = false,
	["BAR_COLORS_TEXT"] = true,
	["BAR_COLORS_BACKGROUND"] = true,
	["BAR_COLORS_IN_FIGHT"] = false,
	["HIDE_CHARGES"] = false,
	["REFRESH_SECS"] = 1,
	["POSITION"] = {
		["x"] = 130,
		["y"] = -130,
		["point"] = "TOPLEFT",
		["relativePoint"] = "TOPLEFT",
	},
	["SCALE"] = 1,
	["PANEL_MAX_BUFFS"] = 5,
	["PANEL_BG_COLOR"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0, ["O"] = 0.5,
		["useBackground"] = true,
	},
	["PANEL_BORDER_COLOR"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0, ["O"] = 0.5,
		["useBackground"] = true,
	},
	["SWATCH_BG_COLOR"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0, ["O"] = 1,
		["useBackground"] = true,
	},
	["SWATCH_BORDER_COLOR"] = {
		["R"] = 0.8, ["G"] = 0.8,	["B"] = 0.8, ["O"] = 0,
		["useBackground"] = true,
	},
	["REBUFF_AT_PERCENT"] = 25,
	["REBUFF_MIN_MINUTES"] = 3,
	["HIGHLIGHT_COOLDOWN"] = true,
	["WHEEL_SMART_BUFF"] = false,

	["SWATCH_COLOR_BUFF_OKAY"]     = VUHDO_makeFullColor(0,   0,   0,   1,   0,   0.8, 0,   1),
	["SWATCH_COLOR_BUFF_LOW"]      = VUHDO_makeFullColor(0,   0,   0,   1,   1,   0.7, 0,   1),
	["SWATCH_COLOR_BUFF_OUT"]      = VUHDO_makeFullColor(0,   0,   0,   1,   0.8, 0,   0,   1),
	["SWATCH_COLOR_BUFF_COOLDOWN"] = VUHDO_makeFullColor(0.3, 0.3, 0.3, 1,   0.6, 0.6, 0.6, 1),
}



VUHDO_DEFAULT_USER_CLASS_COLORS = {
	[VUHDO_ID_DRUIDS]        = VUHDO_makeFullColor(1,    0.49, 0.04, 1,   1,    0.6,  0.04, 1),
	[VUHDO_ID_HUNTERS]       = VUHDO_makeFullColor(0.67, 0.83, 0.45, 1,   0.77, 0.93, 0.55, 1),
	[VUHDO_ID_MAGES]         = VUHDO_makeFullColor(0.41, 0.8,  0.94, 1,   0.51, 0.9,  1,    1),
	[VUHDO_ID_PALADINS]      = VUHDO_makeFullColor(0.96, 0.55, 0.73, 1,   1,    0.65, 0.83, 1),
	[VUHDO_ID_PRIESTS]       = VUHDO_makeFullColor(0.9,  0.9,  0.9,  1,   1,    1,    1,    1),
	[VUHDO_ID_ROGUES]        = VUHDO_makeFullColor(1,    0.96, 0.41, 1,   1,    1,    0.51, 1),
	[VUHDO_ID_SHAMANS]       = VUHDO_makeFullColor(0.14, 0.35, 1,    1,   0.24, 0.45, 1,    1),
	[VUHDO_ID_WARLOCKS]      = VUHDO_makeFullColor(0.58, 0.51, 0.79, 1,   0.68, 0.61, 0.89, 1),
	[VUHDO_ID_WARRIORS]      = VUHDO_makeFullColor(0.78, 0.61, 0.43, 1,   0.88, 0.71, 0.53, 1),
	[VUHDO_ID_DEATH_KNIGHT]  = VUHDO_makeFullColor(0.77, 0.12, 0.23, 1,   0.87, 0.22, 0.33, 1),
	[VUHDO_ID_MONKS]         = VUHDO_makeFullColor(0,    1,    0.59, 1,   0,    1,    0.69, 1),
	[VUHDO_ID_DEMON_HUNTERS] = VUHDO_makeFullColor(0.54, 0.09, 0.69, 1,   0.64, 0.19, 0.79, 1),
	[VUHDO_ID_PETS]          = VUHDO_makeFullColor(0.4,  0.6,  0.4,  1,   0.5,  0.9,  0.5,  1),
	["petClassColor"] = false,
}



--
function VUHDO_initClassColors()
	if not VUHDO_USER_CLASS_COLORS then
		VUHDO_USER_CLASS_COLORS = VUHDO_decompressOrCopy(VUHDO_DEFAULT_USER_CLASS_COLORS);
	end
	VUHDO_USER_CLASS_COLORS = VUHDO_ensureSanity("VUHDO_USER_CLASS_COLORS", VUHDO_USER_CLASS_COLORS, VUHDO_DEFAULT_USER_CLASS_COLORS);
	VUHDO_DEFAULT_USER_CLASS_COLORS = VUHDO_compressAndPackTable(VUHDO_DEFAULT_USER_CLASS_COLORS);
end



--
local function VUHDO_getFirstFreeBuffOrder()
	for tCnt = 1, 10000 do
		if not VUHDO_tableGetKeyFromValue(VUHDO_BUFF_ORDER, tCnt) then
			return tCnt;
		end
	end

	return nil;
end



--
local function VUHDO_fixBuffOrder()
	local _, tPlayerClass = UnitClass("player");
	local tAllBuffs = VUHDO_CLASS_BUFFS[tPlayerClass];
	local tSortArray = {};

	-- Order ohne buff?
	for tCategName, _ in pairs(VUHDO_BUFF_ORDER) do
		if not tAllBuffs[tCategName] then
			VUHDO_BUFF_ORDER[tCategName] = nil;
		end
	end

	-- Buffs ohne order?
	for tCategName, _ in pairs(tAllBuffs) do
		if not VUHDO_BUFF_ORDER[tCategName] then
			VUHDO_BUFF_ORDER[tCategName] = VUHDO_getFirstFreeBuffOrder();
		end

		tinsert(tSortArray, tCategName);
	end

	table.sort(tSortArray, function(aCateg, anotherCateg) return VUHDO_BUFF_ORDER[aCateg] < VUHDO_BUFF_ORDER[anotherCateg] end);
	table.wipe(VUHDO_BUFF_ORDER);
	for tIndex, tCateg in ipairs(tSortArray) do
		VUHDO_BUFF_ORDER[tCateg] = tIndex;
	end

end



--
function VUHDO_initBuffSettings()
	if not VUHDO_BUFF_SETTINGS["CONFIG"] then
		VUHDO_BUFF_SETTINGS["CONFIG"] = VUHDO_decompressOrCopy(VUHDO_DEFAULT_BUFF_CONFIG);
	end

	VUHDO_BUFF_SETTINGS["CONFIG"] = VUHDO_ensureSanity("VUHDO_BUFF_SETTINGS.CONFIG", VUHDO_BUFF_SETTINGS["CONFIG"], VUHDO_DEFAULT_BUFF_CONFIG);
	VUHDO_DEFAULT_BUFF_CONFIG = VUHDO_compressAndPackTable(VUHDO_DEFAULT_BUFF_CONFIG);

	local _, tPlayerClass = UnitClass("player");
	for tCategSpec, _ in pairs(VUHDO_CLASS_BUFFS[tPlayerClass]) do

		if not VUHDO_BUFF_SETTINGS[tCategSpec] then
			VUHDO_BUFF_SETTINGS[tCategSpec] = {
				["enabled"] = false,
				["missingColor"] = {
					["show"] = false,
					["R"] = 1, ["G"] = 1, ["B"] = 1, ["O"] = 1,
					["TR"] = 1, ["TG"] = 1, ["TB"] = 1, ["TO"] = 1,
					["useText"] = true, ["useBackground"] = true, ["useOpacity"] = true,
				}
			};
		end

		if not VUHDO_BUFF_SETTINGS[tCategSpec]["filter"] then
			VUHDO_BUFF_SETTINGS[tCategSpec]["filter"] = { [VUHDO_ID_ALL] = true };
		end
	end

	VUHDO_fixBuffOrder();
end
