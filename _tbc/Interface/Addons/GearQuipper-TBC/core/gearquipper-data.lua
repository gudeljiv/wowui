-- scope stuff
gearquipper = gearquipper or {};
local c = gearquipper;

----- [ general ] -----

-- character fields
local FIELD_CURRENTSET = "FIELD_CURRENTSET";
local FIELD_LASTSET = "FIELD_LASTSET";
local FIELD_SETS = "FIELD_SETS";
local FIELD_EVENTS = "FIELD_EVENTS";
local FIELD_INVENTORY = "FIELD_INVENTORY";
local FIELD_BANK = "FIELD_BANK";
local FIELD_IGNOREDSLOTS = "FIELD_IGNOREDSLOTS";

-- set fields
local FIELD_SHOWCLOAK = "FIELD_SHOWCLOAK";
local FIELD_SHOWHELMET = "FIELD_SHOWHELMET";
local FIELD_EVENTS_ENABLED = "FIELD_EVENTS_ENABLED";
local FIELD_SLOTS = "FIELD_SLOTS";
local FIELD_SLOTSTATES = "FIELD_SLOTSTATES";
local FIELD_ACTIONSLOTS = "FIELD_ACTIONSLOTS";

-- additional set fields
local FIELD_AFFECTS_HELMET = "FIELD_AFFECTS_HELMET";
local FIELD_AFFECTS_CLOAK = "FIELD_AFFECTS_CLOAK";

local FIELD_OPT_ACTIONSLOTS = "FIELD_OPT_ACTIONSLOTS";
local FIELD_OPT_PARTIAL = "FIELD_OPT_PARTIAL";

-- scripts
local FIELD_SCRIPTS = "FIELD_SCRIPTS";
local FIELD_SCRIPTS_ID = "FIELD_SCRIPTS_ID";

-- misc fields
c.FIELD_ID = "FIELD_ID";
c.FIELD_TYPE = "FIELD_TYPE";
c.FIELD_SUBTYPE = "FIELD_SUBTYPE";
c.FIELD_SUBSUBTYPE = "FIELD_SUBSUBTYPE"; -- transient
c.FIELD_NAME = "FIELD_NAME";
c.FIELD_PVE = "FIELD_PVE";
c.FIELD_PVP = "FIELD_PVP";
c.FIELD_TEXT = "FIELD_TEXT";
c.FIELD_OK = "FIELD_OK";
c.FIELD_ENABLED = "FIELD_ENABLED";

function c:InitDatabase()
	GQ_DATA[c:GetRealmName()] = GQ_DATA[c:GetRealmName()] or {};
	GQ_DATA[c:GetRealmName()][c:GetCharName()] = GQ_DATA[c:GetRealmName()][c:GetCharName()] or {};
	GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS] or {};
	GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS] or {};
	GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_INVENTORY] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_INVENTORY] or {};
	GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_BANK] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_BANK] or {};
	GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_IGNOREDSLOTS] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_IGNOREDSLOTS] or {};

	GQ_AUX[FIELD_SCRIPTS] = GQ_AUX[FIELD_SCRIPTS] or {};
	GQ_AUX[FIELD_SCRIPTS_ID] = GQ_AUX[FIELD_SCRIPTS_ID] or 1;
end

----- [ sets ] -----

function c:LoadSetNames(includePrevious)
	local setNames = {};
	for setName in pairs(GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS]) do
		if setName ~= c.KEYWORD_PREVIOUSEQUIPMENT or includePrevious then
			table.insert(setNames, setName);
		end
	end

	table.sort(setNames);
	return setNames;
end

function c:LoadCurrentSetName()
	return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_CURRENTSET];
end

function c:LoadPreviousSetName()
	return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_LASTSET];
end

function c:SaveCurrentSetName(setName)
	c:DebugPrint("SaveCurrentSetName", setName);
	if GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_CURRENTSET] ~= setName then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_LASTSET] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_CURRENTSET];
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_CURRENTSET] = setName;
	end
end

function c:SaveSet(setName, notify)
	c:DebugPrint("SaveSet", setName);
	if setName then
		if notify == nil then
			notify = true;
		end

		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] or {};
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTS] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTS] or {};
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTSTATES] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTSTATES] or {};

		for slotId, slotName in pairs(c:GetSlotInfo()) do
			local slotState = c:LoadSlotState(slotId, setName);
			if not c:LoadPartialOption(setName) or slotState == nil or slotState then
				c:SaveSlot(slotId, setName, notify);
			end
		end

		if setName ~= c.KEYWORD_PREVIOUSEQUIPMENT then
			if GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_OPT_ACTIONSLOTS] == nil then
				GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_OPT_ACTIONSLOTS] = true;
			end
			if GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_OPT_PARTIAL] == nil then
				GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_OPT_PARTIAL] = false;
			end

			c:SaveCloakAndHelmet(setName, notify);
			c:SaveCurrentSetName(setName);

			if c:LoadActionSlotsOption(setName) then
				c:SaveActionConfiguration(setName, notify);
			end

			c:RefreshSetList(setName);
			c:SetPaperDollLabelText();

			if notify then
				c:Println(c:GetText("Set \"%s\" has been saved.", setName));
			end
		else
			GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_OPT_ACTIONSLOTS] = true;
			GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_OPT_PARTIAL] = false;
			c:SaveActionConfiguration(setName, false);
		end
	end
end

function c:LoadSet(setName)
	setName = setName or c:LoadCurrentSetName();
	if setName then
		local result = {};
		for slotId, slotName in pairs(c:GetSlotInfo()) do
			result[slotId] = c:LoadSlot(slotId, setName);
		end
		return result;
	end
end

function c:CreateDefaultSet()
	if table.getn(c:LoadSetNames()) == 0 then
		c:SaveSet(c:GetText("default"), false);
	end
end

function c:CreatePreviousEquipmentSet()
	c:DebugPrint("CreatePreviousEquipmentSet");
	if not GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][c.KEYWORD_PREVIOUSEQUIPMENT] then
		c:SaveSet(c.KEYWORD_PREVIOUSEQUIPMENT, false);
	end
end

function c:DeleteSet(setName)
	c:DebugPrint("DeleteSet", setName);
	GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] = nil;

	if c:LoadCurrentSetName() == setName then
		c:SaveCurrentSetName(nil);
	end
	for eventName, bindingName in pairs(c:LoadEventBindings()) do
		if setName == bindingName then
			c:SaveEventBinding(eventName, nil);
		end
	end

	CloseDropDownMenus();
	c:RefreshSetList();
	c:RefreshEventEntries();
	c:SetPaperDollLabelText();
	c:HideSlotStateBoxes();
end

----- [ slots ] -----

function c:SaveSlot(slotId, setName, notify, itemString)
	c:DebugPrint("SaveSlot", slotId, setName, notify, itemString);
	setName = setName or c:LoadCurrentSetName();
	if notify == nil then
		notify = true;
	end

	if setName then
		itemString = itemString or c:GetItemString(slotId);
		if GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTS][slotId] ~= itemString then
			GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTS][slotId] = itemString;
			if notify then
				c:NotifyInChat(c:GetText("<%s> Saved slot %s (%s): %s", setName, slotId, c:GetDisplaySlotName(slotId), c:GetItemLink(itemString)));
			end
			return true;
		end
	end
end

function c:LoadSlot(slotId, setName)
	setName = setName or c:LoadCurrentSetName();
	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTS][slotId];
	end
end

function c:LoadSlotState(slotId, setName)
	setName = setName or c:LoadCurrentSetName();
	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTSTATES][slotId];
	end
end

function c:SaveSlotState(slotId, active, notify, setName)
	c:DebugPrint("SaveSlotState", slotId, active, notify, setName);
	setName = setName or c:LoadCurrentSetName();
	if setName then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTSTATES] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTSTATES] or {};
		if GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTSTATES][slotId] ~= active then
			GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SLOTSTATES][slotId] = active;
			if notify then
				c:NotifyInChat(c:GetText("<%s> Saved slot state for %s (%s): %s", setName, slotId, c:GetDisplaySlotName(slotId), c:BoolToText(active, c:GetText("active"), c:GetText("not active"))));
			end
		end
	end
end

function c:LevelUp(newLevel)
	c:DebugPrint("LevelUp", newLevel);
	-- itemStrings contain the level at which they were created, which makes an update neccessary if there has been a lvlup
	if newLevel then
		-- sets
		for setName in pairs(GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS]) do
			for slotId, slotName in pairs(c:GetSlotInfo()) do
				local itemString = c:LoadSlot(slotId, setName);
				if not c:IsEmpty(itemString) then
					local stringValues = { strsplit(":", itemString) };
					stringValues[10] = newLevel;
					c:SaveSlot(slotId, setName, false, table.concat(stringValues, ":"));
				end
			end
		end

		-- last inventory locations
		local copy = c:Deepcopy(GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_INVENTORY]);
		for itemString, values in pairs(copy) do
			-- remove old value
			GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_INVENTORY][itemString] = nil;

			-- build new value
			local stringValues = { strsplit(":", itemString) };
			stringValues[10] = newLevel;
			local newItemString = table.concat(stringValues, ":");
			if newItemString then
				-- set new value
				GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_INVENTORY][table.concat(stringValues, ":")] = values;
			end
		end
	end
end

function c:ReplaceItemStringInAllSets(oldString, newString, notify)
	c:DebugPrint("ReplaceItemStringInAllSets", oldString, newString, notify);
	for _, setName in ipairs(c:LoadSetNames()) do
		for slotId, itemString in pairs(c:LoadSet(setName)) do
			if itemString == oldString and (not c:LoadPartialOption(setName) or c:LoadSlotState(slotId, setName)) then
				c:SaveSlot(slotId, setName, notify, newString);
			end
		end
	end
end

----- [ actions ] -----

function c:SaveActionConfiguration(setName, notify)
	c:DebugPrint("SaveActionConfiguration", setName, notify);
	setName = setName or c:LoadCurrentSetName();
	if setName then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] or {};
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS] or {};

		for slotId = 1, 120 do
			c:SaveActionSlot(slotId, setName, notify);
		end
	end
end

function c:SaveActionSlot(slotId, setName, notify, realmName, charName)
	c:DebugPrint("SaveActionSlot", slotId, setName, notify, realmName, charName);
	slotId = tonumber(slotId);
	if slotId then
		realmName = realmName or c:GetRealmName();
		charName = charName or c:GetCharName();
		setName = setName or c:LoadCurrentSetName();
		if setName then
			if notify == nil then
				notify = true;
			end

			GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] or {};
			GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS] = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS] or {};
			local entry = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS][slotId];

			if not c:IsSameAction(slotId, entry) then
				if HasAction(slotId) then
					local actionType, id, subType = GetActionInfo(slotId);

					local newEntry = {};
					newEntry[c.FIELD_TYPE] = actionType;
					if actionType == "macro" then
						newEntry[c.FIELD_ID] = GetMacroInfo(id);
					else
						newEntry[c.FIELD_ID] = id;
					end
					newEntry[c.FIELD_SUBTYPE] = subType;

					GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS][slotId] = newEntry;
				else
					GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS][slotId] = c.VALUE_NONE;
				end

				if notify then
					local actionItemName = c:GetText("Empty");

					if GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS][slotId] ~= c.VALUE_NONE then
						local aType, id = GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS][slotId][c.FIELD_TYPE], GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS][slotId][c.FIELD_ID];

						if aType == "spell" then
							local name, rank = c:GetSpellName(id), c:GetSpellSubText(id);
							if rank and rank ~= "" then
								actionItemName = string.format("%s (%s)", name, rank);
							else
								actionItemName = name;
							end
						elseif aType == "item" then
							actionItemName = c:GetRarityColor(c:GetItemRarity(id))["hex"] .. c:GetItemName(id);
						elseif aType == "macro" then
							actionItemName = c:GetText("Macro \"%s\"", id);
						end
					end
					c:NotifyInChat(c:GetText("<%s> Saved action slot %s: %s", setName, slotId, actionItemName));
				end
			end
		end
	end
end

function c:LoadActionSlots(setName)
	setName = setName or c:LoadCurrentSetName();
	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_ACTIONSLOTS];
	end
end

local macros;
function c:GetMacros(refresh)
	c:DebugPrint("GetMacros");
	if not macros or refresh then
		macros = {
			["all"] = {},
			["global"] = {},
			["char"] = {}
		}

		local numGlobal, numLocal = GetNumMacros(); -- 1-120: global; 121-138: local
		for id = 1, numGlobal do
			local name, iconTexture, body, isLocal = GetMacroInfo(id);
			table.insert(macros["all"], name);
			table.insert(macros["global"], name);
		end

		for id = 1, numLocal do
			id = id + 120;
			local name, iconTexture, body, isLocal = GetMacroInfo(id);
			table.insert(macros["all"], name);
			table.insert(macros["char"], name);
		end
	end
	return macros;
end

function c:ProcessMacroUpdate()
	c:DebugPrint("ProcessMacroUpdate");
	if c.macroAction == c.MACROACTION_EDIT or c.macroAction == c.MACROACTION_DELETE then
		local oldMacrosAll, newMacrosAll, oldMacros, newMacros, realmName, charName = c:GetMacros(), c:GetMacros(true);
		if c.macroAction[c.FIELD_TYPE] == 1 then
			oldMacros = oldMacrosAll["global"];
			newMacros = newMacrosAll["global"];
		elseif c.macroAction[c.FIELD_TYPE] == 2 then
			oldMacros = oldMacrosAll["char"];
			newMacros = newMacrosAll["char"];
			realmName = c:GetRealmName();
			charName = c:GetCharName();
		end

		local oldName, newName;
		if oldMacros and newMacros then
			if c.macroAction[c.FIELD_NAME] == c.MACROACTION_EDIT then
				oldName, newName = c:FindRenamedMacro(oldMacros, newMacros);
			elseif c.macroAction[c.FIELD_NAME] == c.MACROACTION_DELETE then
				oldName = GetMacroInfo(c.macroAction[c.FIELD_ID]);
			end
			c:UpdateMacro(oldName, newName, realmName, charName);
		end

		c.macroAction = nil;
	end
end

function c:FindRenamedMacro(oldMacros, newMacros)
	c:DebugPrint("FindRenamedMacro");
	for id, name in ipairs(oldMacros) do
		if not c:TableContains(newMacros, name) then
			for newId, newName in ipairs(newMacros) do
				if not c:TableContains(oldMacros, newName) then
					return name, newName;
				end
			end
		end
	end
end

function c:UpdateMacro(oldName, newName, realmName, charName)
	c:DebugPrint("UpdateMacro", oldName, newName, realmName, charName);
	if not realmName or not charName then
		-- global macros
		for realmName in pairs(GQ_DATA) do
			for charName in pairs(GQ_DATA[realmName]) do
				c:UpdateMacro(oldName, newName, realmName, charName);
			end
		end
	else
		-- local macro (character macro)
		for setName in pairs(GQ_DATA[realmName][charName][FIELD_SETS]) do
			for slotId, entry in ipairs(GQ_DATA[realmName][charName][FIELD_SETS][setName][FIELD_ACTIONSLOTS]) do
				if entry and entry[c.FIELD_TYPE] == "macro" and entry[c.FIELD_ID] == oldName then
					if newName then
						GQ_DATA[realmName][charName][FIELD_SETS][setName][FIELD_ACTIONSLOTS][slotId][c.FIELD_ID] = newName;
					else
						GQ_DATA[realmName][charName][FIELD_SETS][setName][FIELD_ACTIONSLOTS][slotId] = c.VALUE_NONE;
					end
				end
			end
		end
	end
end

function c:UprankSpellOnActionSlots(targetSpellId)
	if GQ_OPTIONS[c.OPT_AUTOUPRANKSPELLS] and targetSpellId then
		--local targetSpellId = c:GetSpellId(spellName, targetSpellRank);
		local upgradableSpellIds;
		c:DebugPrint("SpellId:", targetSpellId);
		if GQ_OPTIONS[c.OPT_AUTOUPRANKSPELLS_ALLRANKS] then
			-- all lower ranks
			upgradableSpellIds = c:GetUprankableSpellIds(targetSpellId);
		else
			-- only -1 rank
			upgradableSpellIds = { c:GetLowerRankSpellId(targetSpellId) };
		end

		c:DebugPrint("Upgradable ids:");
		if c.debugMode then
			c:DumpTable(upgradableSpellIds);
		end

		local currentSetName = c:LoadCurrentSetName();
		for _, setName in ipairs(c:LoadSetNames()) do
			if c:LoadActionSlotsOption(setName) then
				for slotId, slotInfo in pairs(c:LoadActionSlots(setName)) do
					if slotInfo and slotInfo ~= c.VALUE_NONE and c:TableContains(upgradableSpellIds, slotInfo[c.FIELD_ID]) then
						c:SaveActionSlot(slotId, setName, true);

						if setName == currentSetName then
							ClearCursor();
							PickupSpell(targetSpellId);
							PlaceAction(slotId);
							ClearCursor();
							c:HighlightActionSlot(slotId);
						end
					end
				end
			end
		end
	end
end

----- [ event ] -----

function c:SaveEventBinding(binding, index)
	c:DebugPrint("SaveEventBinding", binding, index);
	if index then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS][index] = binding;
	else
		if binding[c.FIELD_SUBSUBTYPE] then
			binding[c.FIELD_SUBTYPE] = binding[c.FIELD_SUBSUBTYPE];
			binding[c.FIELD_SUBSUBTYPE] = nil;
		end
		table.insert(GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS], binding);
	end

	-- notification
	local event = c:GetEvents()[binding[c.FIELD_TYPE]];
	if event and binding[c.FIELD_SUBTYPE] then
		if binding[c.FIELD_SUBTYPE]["mapID"] then
			--zone
			event = event .. " (" .. c:GetZoneDisplayName(binding[c.FIELD_SUBTYPE]["mapID"]) .. ")";
		elseif binding[c.FIELD_SUBTYPE][c.FIELD_NAME] then
			-- script
			event = event .. " (" ..binding[c.FIELD_SUBTYPE][c.FIELD_NAME] .. ")";
		end
	end
	local setName = binding[c.FIELD_NAME];
	if setName == c.KEYWORD_PREVIOUS then
		setName = c:GetText("[Previous set]");
	end
	c:NotifyInChat(string.format("%s %s -> %s", c:GetText("Saved event:"), event, setName));
end

function c:LoadEventBindings(filter)
	if filter then
		local result = {};
		for index, binding in ipairs(c:LoadEventBindings()) do
			local applies = true;
			for filterName, filterValue in pairs(filter) do
				if not c:Equals(filterValue, binding[filterName]) then
					applies = false;
					break;
				end
			end
			if applies then
				result[index] = binding;
			end
		end
		return result;
	else
		return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS];
	end
end

function c:DeleteEventBinding(index)
	c:DebugPrint("DeleteEventBinding", index);
	if index and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS][index]then
		local binding = c:Deepcopy(GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS][index]);
		table.remove(GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS], index);

		-- notification
		local event = c:GetEvents()[binding[c.FIELD_TYPE]];
		if event and binding[c.FIELD_SUBTYPE] then
			if binding[c.FIELD_SUBTYPE]["mapID"] then
				--zone
				event = event .. " (" .. c:GetZoneDisplayName(binding[c.FIELD_SUBTYPE]["mapID"]) .. ")";
			elseif binding[c.FIELD_SUBTYPE][c.FIELD_NAME] then
				-- script
				event = event .. " (" ..binding[c.FIELD_SUBTYPE][c.FIELD_NAME] .. ")";
			end
		end
		local setName = binding[c.FIELD_NAME];
		if setName == c.KEYWORD_PREVIOUS then
			setName = c:GetText("[Previous set]");
		end
		c:NotifyInChat(string.format("%s %s -> %s", c:GetText("Removed event:"), event or c:GetText("Deprecated event"), setName));
	end
end

function c:BindingExists(binding)
	if binding[c.FIELD_TYPE] then
		local bindingClone = c:Deepcopy(binding);
		if bindingClone[c.FIELD_SUBSUBTYPE] then
			bindingClone[c.FIELD_SUBTYPE] = bindingClone[c.FIELD_SUBSUBTYPE];
			bindingClone[c.FIELD_SUBSUBTYPE] = nil;
		end
		bindingClone[c.FIELD_PVE] = nil;
		bindingClone[c.FIELD_PVP] = nil;

		for index, matchedBinding in pairs(c:LoadEventBindings(bindingClone)) do
			if (binding[c.FIELD_PVE] and matchedBinding[c.FIELD_PVE]) or (binding[c.FIELD_PVP] and matchedBinding[c.FIELD_PVP]) then
				return true;
			end
		end
	end
end

local function SetBindingEnabled(setName, value)
	c:DebugPrint("SetBindingEnabled", setName, value);
	local setBindings = c:LoadEventBindings();
	if setBindings then
		for index, binding in pairs(setBindings) do
			if binding[c.FIELD_NAME] == setName then
				GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS][index][c.FIELD_ENABLED] = value;
			end
		end
	end
end

function c:EnableBindings(setName)
	c:DebugPrint("EnableBindings");
	SetBindingEnabled(setName, true);
end

function c:DisableBindings(setName)
	c:DebugPrint("DisableBindings");
	SetBindingEnabled(setName, false);
end

----- [ other ] -----

function c:SaveCloakAndHelmet(setName, notify)
	c:DebugPrint("SaveCloakAndHelmet", setName, notify);
	setName = setName or c:LoadCurrentSetName();
	if notify == nil then
		notify = true;
	end

	if setName then
		if ShowingHelm() ~= GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SHOWHELMET] then
			GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SHOWHELMET] = ShowingHelm();
			if notify then
				c:NotifyInChat(string.format("<%s> %s %s", setName, c:GetText("Saved helmet visibility:"), c:BoolToText(ShowingHelm(), c:GetText("visible"), c:GetText("not visible"))));
			end
		end

		if ShowingCloak() ~= GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SHOWCLOAK] then
			GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SHOWCLOAK] = ShowingCloak();
			if notify then
				c:NotifyInChat(string.format("<%s> %s %s", setName, c:GetText("Saved cloak visibility:"), c:BoolToText(ShowingCloak(), c:GetText("visible"), c:GetText("not visible"))));
			end
		end
	end
end

function c:LoadCloakAndHelmet(setName)
	setName = setName or c:LoadCurrentSetName();
	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		if c:GetAffectsHelmet(setName) and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SHOWHELMET] ~= nil then
			ShowHelm(GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SHOWHELMET]);
		end
		if c:GetAffectsCloak(setName) and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SHOWCLOAK] ~= nil then
			ShowCloak(GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_SHOWCLOAK]);
		end
	end
end

function c:SetAffectsHelmet(value, setName, notify)
	c:DebugPrint("SaveAffectsHelmet", value, setName, notify);
	setName = setName or c:LoadCurrentSetName();
	if notify == nil then
		notify = true;
	end

	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_AFFECTS_HELMET] = value;
		if notify then
			c:NotifyInChat(string.format("<%s> %s %s", setName, c:GetText("Affects helmet visibility:"), c:BoolToText(value, c:GetText("Yes"), c:GetText("No"))));
		end
	end
end

function c:GetAffectsHelmet(setName)
	setName = setName or c:LoadCurrentSetName();
	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		-- weird syntax for backwards compatibility
		if GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_AFFECTS_HELMET] == false then
			return false;
		end
		return true;
	end
end

function c:SetAffectsCloak(value, setName, notify)
	c:DebugPrint("SaveAffectsCloak", value, setName, notify);
	setName = setName or c:LoadCurrentSetName();
	if notify == nil then
		notify = true;
	end

	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_AFFECTS_CLOAK] = value;
		if notify then
			c:NotifyInChat(string.format("<%s> %s %s", setName, c:GetText("Affects cloak visibility:"), c:BoolToText(value, c:GetText("Yes"), c:GetText("No"))));
		end
	end
end

function c:GetAffectsCloak(setName)
	setName = setName or c:LoadCurrentSetName();
	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		-- weird syntax for backwards compatibility
		if GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_AFFECTS_CLOAK] == false then
			return false;
		end
		return true;
	end
end

function c:IsEventsEnabled()
	if GQ_DATA[c:GetRealmName()][c:GetCharName()] then
		return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS_ENABLED];
	end
end

function c:SetEventsEnabled(value)
	if GQ_DATA[c:GetRealmName()][c:GetCharName()] then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_EVENTS_ENABLED] = value;
	end
end

function c:LoadPartialOption(setName)
	setName = setName or c:LoadCurrentSetName();
	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_OPT_PARTIAL];
	end
end

function c:SavePartialOption(setName, value)
	c:DebugPrint("SavePartialOption", setName, value);
	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_OPT_PARTIAL] = value;
	end
end

function c:LoadActionSlotsOption(setName)
	setName = setName or c:LoadCurrentSetName();
	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_OPT_ACTIONSLOTS];
	end
end

function c:SaveActionSlotsOption(setName, value)
	c:DebugPrint("SaveActionSlotsOption", setName, value);
	if setName and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName] then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_SETS][setName][FIELD_OPT_ACTIONSLOTS] = value;
	end
end

function c:SaveLastBagLocation(itemString, bagId, slotId)
	c:DebugPrint("SaveLastBagLocation", itemString, bagId, slotId);
	if itemString and bagId and slotId then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_INVENTORY][itemString] = { [c.ITEM_BAG_ID] = bagId, [c.ITEM_SLOT_ID] = slotId };
	end
end

function c:LoadLastBagLocation(itemString)
	if itemString and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_INVENTORY][itemString] then
		return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_INVENTORY][itemString][c.ITEM_BAG_ID], GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_INVENTORY][itemString][c.ITEM_SLOT_ID];
	end
end

function c:SaveLastBankLocation(itemString, bagId, slotId)
	c:DebugPrint("SaveLastBankLocation", itemString, bagId, slotId);
	if itemString and bagId and slotId then
		GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_BANK][itemString] = { [c.ITEM_BAG_ID] = bagId, [c.ITEM_SLOT_ID] = slotId };
	end
end

function c:LoadLastBankLocation(itemString)
	if itemString and GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_BANK][itemString] then
		return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_BANK][itemString][c.ITEM_BAG_ID], GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_BANK][itemString][c.ITEM_SLOT_ID];
	end
end

function c:AddIgnoredSlot(slotId)
	c:DebugPrint("AddIgnoredSlot", slotId);
	GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_IGNOREDSLOTS][slotId] = not c:IsSetItem(slotId);
end

function c:GetIgnoredItems()
	return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_IGNOREDSLOTS];
end

function c:IsIgnoredItem(slotId)
	return GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_IGNOREDSLOTS][slotId];
end

function c:ResetIgnoredSlots()
	c:DebugPrint("ResetIgnoredSlots");
	GQ_DATA[c:GetRealmName()][c:GetCharName()][FIELD_IGNOREDSLOTS] = {};
end

----- [ scripts ] -----

function c:LoadScriptNames(distinct)
	local scriptNames = {};
	for scriptId, script in pairs(GQ_AUX[FIELD_SCRIPTS]) do
		if not distinct or not tContains(scriptNames, script[c.FIELD_NAME]) then
			table.insert(scriptNames, script[c.FIELD_NAME]);
		end
	end

	table.sort(scriptNames);
	return scriptNames;
end

function c:LoadScripts()
	return GQ_AUX[FIELD_SCRIPTS];
end

function c:LoadScript(scriptId)
	if scriptId then
		return GQ_AUX[FIELD_SCRIPTS][scriptId];
	end
end

function c:SaveScriptStatus(script, newStatus)
	c:DebugPrint("SaveScriptStatus", script, newStatus);
	script[c.FIELD_OK] = newStatus;
	GQ_AUX[FIELD_SCRIPTS][script[c.FIELD_ID]] = script;
end

function c:SaveScript(script, newText)
	c:DebugPrint("SaveScript", script, "[TEXT HIDDEN]");
	if script[c.FIELD_TEXT] ~= newText then
		script[c.FIELD_OK] = false;
	end
	script[c.FIELD_TEXT] = newText;

	GQ_AUX[FIELD_SCRIPTS][script[c.FIELD_ID]] = script;
	c:Println(c:GetText("Script saved: %s", script[c.FIELD_NAME]));
end

function c:NewScript()
	local scriptNames = c:LoadScriptNames();
	local number = 1;
	local newScriptName = c:GetText("New Script %s", number);
	c:DebugPrint("NewScript", newScriptName);

	-- new name
	while (tContains(scriptNames, newScriptName)) do
		number = number + 1;
		newScriptName = c:GetText("New Script %s", number);
	end

	-- new id
	GQ_AUX[FIELD_SCRIPTS_ID] = GQ_AUX[FIELD_SCRIPTS_ID] or 1;
	GQ_AUX[FIELD_SCRIPTS_ID] = GQ_AUX[FIELD_SCRIPTS_ID] + 1;
	local nextId = GQ_AUX[FIELD_SCRIPTS_ID];

	local newScript = {};
	newScript[c.FIELD_ID] = nextId;
	newScript[c.FIELD_NAME] = newScriptName;
	newScript[c.FIELD_TEXT] = "print(\"Hello World\")";

	GQ_AUX[FIELD_SCRIPTS][nextId] = newScript;
	return newScript;
end

function c:DeleteScript(script)
	c:DebugPrint("DeleteScript", script);
	-- delete bindings
	local filter = { [c.FIELD_TYPE] = c.EVENT_CUSTOMSCRIPT };
	local setBindings = c:LoadEventBindings(filter);
	if setBindings then
		for index, binding in pairs(setBindings) do
			if binding[c.FIELD_SUBTYPE] and binding[c.FIELD_SUBTYPE][c.FIELD_ID] and binding[c.FIELD_SUBTYPE][c.FIELD_ID] == script[c.FIELD_ID] then
				c:DeleteEventBinding(index);
			end
		end
	end

	-- delete script
	GQ_AUX[FIELD_SCRIPTS][script[c.FIELD_ID]] = nil;
end