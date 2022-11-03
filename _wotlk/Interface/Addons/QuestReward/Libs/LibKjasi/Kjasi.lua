--[[
	LibKjasi
	Version 1.0
	
	LibKjasi contains common functions used by Kjasi in his addons.
	LibKjasi is placed in the public domain, and is free to use in Addon Projects.
	Original Author: Kjasi
	Website: https://bitbucket.org/Kjasi/libkjasi
	
	Revision 8:
		* Updated getIDNumber for 6.0.x
	Revision 7:
		* getIDNumber now returns the link's type as it's second variable, and if a number is passed to it, returns that with an type of "itemid".
	Revision 6:
		* Timer's 4th variable can now be either a string or a function.
		* SetLen's new 4th variable, inBack, dictates if the character should be placed in the front or in the back of the string.
	Revision 5:
		* Setup's Version now requires either a string or a number.
		* Added getNamefromLink function.
		* PairsByKeys's Sort function is now optional
	Revision 4:
		* PairsByKeys's sort Type error now displays the proper type, and not the table's type
	Revision 3:
		* Requires LibStub error now shows in Red.
		* Updated getIDNumber to support Currencies.
		* Added SetLen function.
		* Error messages are now more in-line with Blizzard error messages.
		* Fixed a Rounding, Ceiling and Floor bug.
		* Code Reduction.
	Revision 2:
		* Removed superfluous line of code.
]]

local MAJOR = "LibKjasi-1.0"
local MINOR = 8
if not LibStub then error(RED_FONT_COLOR_CODE..MAJOR.." requires LibStub."..FONT_COLOR_CODE_CLOSE) end
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

if not lib.private then
	lib.private = {}
end
local private = lib.private

-- List of Enumerations
lib.Enums = {
	["ROUND_NORMAL"] 	= "ROUND_NORMAL",
	["ROUND_UP"] 		= "ROUND_UP",
	["ROUND_DOWN"]		= "ROUND_DOWN",
}

--[[
	Set Up an addon for use with this Library
	
	Format:
		SetupVars = {
			["Name"] = "Addon Name",
			["Version"] = "Addon Version",
			["MsgStrings"] = {
				["Channel Name"] = "Output String with Variables",
				["Default"] = "%s's Default Message String: %s",
				-- ["Default"] is a required Channel!
				-- Output String's Passed Vars: Addon's Name, Message
				-- Coloring can be achieved by altering the Output String.
			},
			["ChannelLevel"] = Current channel level, indicating the "Show all Messages" mode.
		}
]]
function lib:setupAddon(SetupVars)
	assert(SetupVars, "LibKjasi:setupAddon: bad argument #1: Expected a table, got nil.")
	assert(type(SetupVars) == "table", "LibKjasi:setupAddon: bad argument #1: Expected a table, got "..type(SetupVars)..".")
	assert(SetupVars["Name"] and SetupVars["Version"] and SetupVars["MsgStrings"] and SetupVars["ChannelLevel"], "LibKjasi:setupAddon: Incorrect or missing SetupVars.")
	assert(type(SetupVars["Name"]) == "string", "LibKjasi:setupAddon: Invalid Addon Name type. Expected a String.")
	assert(((type(SetupVars["Version"]) == "string" )or(type(SetupVars["Version"]) == "number" )), "LibKjasi:setupAddon: Invalid Addon Version type. Expected a String or Number.")
	assert(type(SetupVars["MsgStrings"]) == "table", "LibKjasi:setupAddon: Invalid MsgStrings type. Expected a Table.")
	assert(SetupVars["MsgStrings"]["Default"], "LibKjasi:setupAddon: No Default MsgStrings. Please add one.")
	assert(type(SetupVars["MsgStrings"]["Default"]) == "string", "LibKjasi:setupAddon: Invalid Default MsgString type. Expected a String.")
	assert(type(SetupVars["ChannelLevel"]) == "number", "LibKjasi:setupAddon: Invalid ChannelLevel type. Expected a Number.")
	
	if not lib.private[SetupVars["Name"]] then lib.private[SetupVars["Name"]] = {} end
	
	private[SetupVars["Name"]]["Setup"] = SetupVars
end

--[[
	Messaging Function
	
	If set, channel should match a MsgStrings variable.
	If chanlevel is less than, or equal to the ChannelLevel in the setup, the message will be shown.
]]
function lib:Msg(addonName, message, channel, chanlevel, chatframe)
	assert(addonName, "LibKjasi:Msg: bad argument #1: Expected a string, got nil.")
	assert(type(addonName) =="string", "LibKjasi:Msg: bad argument #1: Expected a string, got "..type(addonName)..".")
	assert(private[addonName]["Setup"], "Please set up your addon with LibKjasi's setupAddon function first.")
	assert(message, "LibKjasi:Msg: bad argument #2: Expected a message, got nil.")

	-- Left in here, just in case...
	if (message == nil) then return end
	if (chanlevel == nil) then chanlevel = private[addonName]["Setup"]["ChannelLevel"] end
	if (channel ~= nil) then
		assert(private[addonName]["Setup"]["MsgStrings"][channel], format("LibKjasi:Msg: bad argument #3: Could not find the channel \"%s\" in MsgStrings.",channel))
	end
	if (chatframe ~= nil) then
		assert(type(chatframe)=="string","LibKjasi:Msg: bad argument #5: Expected a string, got "..type(chatframe)..".")
		assert(_G[chatframe], "LibKjasi:Msg: bad argument #5: Unable to find the specified chatframe.")
		assert(_G[chatframe]:GetName(), "LibKjasi:Msg: bad argument #5: Specified chatframe is not a chatframe.")
		chatframe = _G[chatframe]
	else
		chatframe = DEFAULT_CHAT_FRAME
	end

	local chan = "Default"
	if (channel ~= nil) then
		chan = tostring(channel)
	end
	if (chanlevel <= private[addonName]["Setup"]["ChannelLevel"]) then
		local f = private[addonName]["Setup"]["MsgStrings"][chan]
		local n = private[addonName]["Setup"]["Name"]
		chatframe:AddMessage(format(f,n,message))
	end
end

-- Sub-function used by the UpdateDatabase function
local function dbparse(db, olddb)
	local k,v
	for k,v in pairs(db) do
		if ((olddb) and (olddb[k] ~= nil) and (type(olddb[k]) == "table") and (type(db[k]) =="table")) then
			db[k] = dbparse(v, olddb[k])
		elseif (olddb and olddb[k] ~= nil and v ~= nil) then
			db[k] = v
		end
	end
	return db
end

--[[
	Update a database's format to match defaults.
	
	This function also copies data with the same name from the database to the new defaults database.
	Be sure to update any information you want updated after running, such as ["version"] options.
	
	Supports an infinite-level database!
]]
function lib:UpdateDatabase(db, defaults)
	assert(db, "LibKjasi:UpdateDatabase: bad argument #1: Expected a table, got nil.")
	assert(defaults, "LibKjasi:UpdateDatabase: bad argument #2: Expected a table, got nil.")
	assert(type(db) == "table","LibKjasi:UpdateDatabase: bad argument #1: Expected a table, got "..type(db)..".")
	assert(type(defaults) == "table","LibKjasi:UpdateDatabase: bad argument #2: Expected a table, got "..type(defaults)..".")

	local temp = dbparse(defaults, db)
	
	return temp
end

--[[
	Timer function
	
	TimerName is the unique name for this timer. This will be added to the addonName, to ensure the name is totally unique.
	Time is how long until the specified function should run.
	funct is the function, or the name of the function the timer should run when it reaches Time.
	Any additional variables will be passed to the function.
]]
function lib:Timer(addonName,TimerName,Time,funct,...)
	assert(addonName, "LibKjasi:Timer: bad argument #1: Expected a string, got nil.")
	assert(TimerName, "LibKjasi:Timer: bad argument #2: Expected a string, got nil.")
	assert(Time, "LibKjasi:Timer: bad argument #3: Expected a number, got nil.")
	assert(funct, "LibKjasi:Timer: bad argument #4: Expected a string, got nil.")
	assert(type(addonName) == "string", "LibKjasi:Timer: bad argument #1: Expected a string, got "..type(addonName)..".")
	assert(type(TimerName) == "string", "LibKjasi:Timer: bad argument #2: Expected a string, got "..type(TimerName)..".")
	assert(type(Time) == "number", "LibKjasi:Timer: bad argument #3: Expected a number, got "..type(Time)..".")
	assert((type(funct) == "string") or (type(funct) == "function"), "LibKjasi:Timer: bad argument #4: Expected a function or a string, got "..type(funct)..".")
	if (type(funct) == "function") then
		assert(funct, format("LibKjasi:Timer: bad argument #4: Unable to find function \"%s\".",tostring(funct)))
	elseif (type(funct) == "string") then
		assert(_G[funct], format("LibKjasi:Timer: bad argument #4: Unable to find global \"%s\".",funct))
		assert(type(_G[funct]) == "function", "LibKjasi:Timer: bad argument #4: Expected Global to be a function, got "..type(_G[funct])..".")
		funct = _G[funct]
	end

	local framename = addonName.."TimeFrame"..TimerName
	if _G[framename] and (_G[framename]:GetScript("OnUpdate") ~= nil) then return end

	local frame = CreateFrame("Frame", framename)
	local totalElapsed = 0.0
	local tickcount = 0
	local vars = {...}
	
	local function LibKjasiTimer_onUpdate(self, elapsed)
		totalElapsed = totalElapsed + elapsed
		if (totalElapsed < 1) then return end
		totalElapsed = totalElapsed - floor(totalElapsed)
		tickcount = tickcount + 1

		if (tickcount == Time) then
			local result = funct(vars)
			frame:SetScript("OnUpdate", nil)
			return result
		end
		-- Enable for timing debugging
		-- DEFAULT_CHAT_FRAME:AddMessage("tick... "..tickcount)
	end
	frame:SetScript("OnUpdate", LibKjasiTimer_onUpdate)
	frame:Show()
end

--[[
	Rounding functions
	
	Number is the number to round.
	Decimal (Optional) is the number of decimals to round to. Defaults to 2 decimal points.
	Mode (Optional) indicates how it should round. Defaults to Standard Rounding. Enums["ROUND_NORMAL"] = Standard Rounding. Enums["ROUND_UP"] = Always Round Up. Enums["ROUND_DOWN"] = Always Round Down.
]]

function lib:Round(Number, Decimal, Mode)
	assert(Number,"LibKjasi:Round: bad argument #1: Expected a number, got nil.")
	assert(type(Number)=="number", "LibKjasi:Round: bad argument #1: Expected a number, got "..type(Number)..".")
	if (not Decimal) or (Decimal==nil) then Decimal = 2 end
	assert(tonumber(Decimal), "LibKjasi:Round: bad argument #2: Unable to convert Decimal to a Number.")
	assert(Decimal>=0, "LibKjasi:Round: bad argument #2: Decimal count must be 0 or greater.")
	Decimal = tonumber(Decimal)
	
	if (not Mode) then Mode=lib.Enums["ROUND_NORMAL"] end
	assert(type(Mode)=="string", "LibKjasi:Round: bad argument #3: Expected a string, got "..type(Number)..".")
	assert((Mode==lib.Enums["ROUND_NORMAL"]) or (Mode==lib.Enums["ROUND_UP"]) or (Mode==lib.Enums["ROUND_DOWN"]), format("LibKjasi:Round: bad argument #3: Invalid Rounding Mode specified. Expected \"%s\", \"%s\" or \"%s\"", lib.Enums["ROUND_NORMAL"], lib.Enums["ROUND_UP"], lib.Enums["ROUND_DOWN"]))
	
	local mult = 10^(Decimal or 0)
	if (Mode==lib.Enums["ROUND_UP"]) then return math.ceil(Number * mult) / mult
	elseif (Mode == lib.Enums["ROUND_DOWN"]) then return math.floor(Number * mult + 0.5) / mult
	else return math.floor(Number * mult) / mult
	end
end

function lib:Ceiling(Number, Decimal)
	assert(Number,"LibKjasi:Ceiling: bad argument #1: Expected a number, got nil.")
	assert(type(Number)=="number", "LibKjasi:Ceiling: bad argument #1: Expected a number, got "..type(Number)..".")
	if (not Decimal) or (Decimal==nil) then Decimal = 2 end
	assert(tonumber(Decimal), "LibKjasi:Ceiling: bad argument #2: Unable to convert Decimal to a Number.")
	assert(Decimal>=0, "LibKjasi:Ceiling: bad argument #2: Decimal count must be 0 or greater.")
	Decimal = tonumber(Decimal)
	return lib:Round(Number, Decimal, lib.Enums["ROUND_UP"])
end

function lib:Floor(Number, Decimal)
	assert(Number,"LibKjasi:Floor: bad argument #1: Expected a number, got nil.")
	assert(type(Number)=="number", "LibKjasi:Floor: bad argument #1: Expected a number, got "..type(Number)..".")
	if (not Decimal) or (Decimal==nil) then Decimal = 2 end
	assert(tonumber(Decimal), "LibKjasi:Floor: bad argument #2: Unable to convert Decimal to a Number.")
	assert(Decimal>=0, "LibKjasi:Floor: bad argument #2: Decimal count must be 0 or greater.")
	Decimal = tonumber(Decimal)
	return lib:Round(Number,Decimal, lib.Enums["ROUND_DOWN"])
end

-- Sort tables by Keys
function lib:PairsByKeys (t, sort)
	assert(t, "LibKjasi:PairsByKeys: bad argument #1: Expected a table, got nil.")
	assert(type(t)=="table", "LibKjasi:PairsByKeys: bad argument #1: Expected a table, got "..type(t)..".")
	if (sort) then
		assert(type(sort)=="function", "LibKjasi:PairsByKeys: bad argument #2: Expected a function, got "..type(sort)..".")
	end
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, sort)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then return nil else return a[i], t[a[i]] end
	end
	return iter
end

-- Returns the Name of the link, without the surrounding brackets. Returns nil if it's a link with no text.
function lib:getNamefromLink(link)
	lib:checkLink(link)
	if (not string.find(link,'|h')) then
		return
	end
	
	local start = string.find(link,'|h')+3
	local send = string.find(link,'|h',start)-2
	return string.sub(link,start,send)
end

--[[
	Get the ID Number and Type from a link.
	
	The returned Type variable lets you identify the type of link. If an ItemID is passed, then the type is "id".

	If link is an item, and isFull is set, then the full ID string is returned.
	if link is a currency, and getSlot is set, returns the index in the player's currency list, with a type of "currencyIndex"
	If link is a quest, returns the Quest ID number, and the Quest's Level. Raid, Group and Dungeon quests are also specified by the Quest's level.
	Otherwise, it returns just the ID number.
]]
function lib:getIDNumber(link, isFull, getSlot)
	assert(link, "LibKjasi:getIDNumber: bad argument #1: Expected a string, got nil.")
	assert((type(link)=="string")or(type(link)=="number"),"LibKjasi:getIDNumber: bad argument #1: Expected a string or number, got "..type(link)..".")
	if (type(link)=="string") then
		assert(strfind(link,":") ~= nil, "LibKjasi:getIDNumber: bad argument #1: Supplied string is not a valid link.")
	else
		return tonumber(link), "id"
	end
	local justID = string.gsub(link,".-\124H([^\124]*)\124h.-\124h", "%1")
	local itype, itemid, enchant, gem1, gem2, gem3, gem4, suffixID, uniqueID, level, upgradeId, instanceDifficultyID, numBonusIDs, bonusID1, bonusID2 = strsplit(":",justID)
	
	if (itype == "item") and (isFull) then
		return string.gsub(justID, "\124", "\124\124"), tostring(itype)
	elseif (itype == "currency") and (getSlot) then
		for i=1,GetCurrencyListSize() do
			local name, ih = GetCurrencyListInfo(i)
			if (ih == false) then
				if (name == lib:getNamefromLink(link)) then
					return tonumber(i), "currencyIndex"
				end
			end
		end
	elseif (itype == "quest") then
		local questlevel = enchant
		return tonumber(itemid), tostring(itype), tonumber(string.match(questlevel,"%d+")), tostring(questlevel)	-- questlevel is returned as both a string and a number, because raid, group and dungeon quests add a character to the end of the quest's level
	else
		return tonumber(itemid), tostring(itype)
	end
end

-- Count the total number of variables in a Table, number or not.
function lib:tcount(table)
	assert(table, "LibKjasi:tcount: bad argument #1: Expected a table, got nil.")
	assert(type(table)=="table", "LibKjasi:tcount: bad argument #1: Expected a table, got "..type(table)..".")
	local count = 0
	
	for _ in pairs(table) do
		count = count + 1
	end

	return tonumber(count)
end

-- Printr function that will recursively print all the data of a passed table.
function lib:printr(table,indent)
	assert(table,"LibKjasi:printr: bad argument #1: expected table, got nil")
	assert(type(table)=="table", "LibKjasi:printr: bad argument #1: Expected a table, got "..type(table)..".")
	if (not indent) then
		indent = 0
	end
	assert(type(indent)=="number", "LibKjasi:printr: bad argument #2: Expected a number, got "..type(indent)..".")
	
	local str = ""
	local num = 0
	while (num < indent) do
		str = "    "..str
		num = (num+1)
	end
		
	if (lib:tcount(table) == 0) then
		print(str.."Empty Table.")
		return
	end
	
	for k,v in pairs(table) do
		local f = "[%s] = "
		if (type(k) == "string") then f = "[\"%s\"] = " end
		if (type(v) == "table") then
			local fv = "{"
			print(str..format(f..fv,tostring(k)))
			lib:printr(table[k],(indent+1))
			print(str.."},")
		else
			local fv = "%s"
			if (type(v) == "string") then fv = '"%s"' end
			print(str..format(f..fv,tostring(k),tostring(v)))
		end
	end
end

-- SetLen will add Char or 0 to the front of a string until the length specified is reached.
-- inBack, if set to true, will add the Char/0 to the end of the string, instead of the beginning.
function lib:SetLen(Val,Len,Char,inBack)
	assert(Val,"LibKjasi:SetLen: bad argument #1: Expected a Value, got nil.")
	assert(Len,"LibKjasi:SetLen: bad argument #2: Expected a Length to extend the Value to, got nil.")
	assert(type(Len)=="number","LibKjasi:SetLen: bad argument #2: Expected a number, got "..type(Len)..".")
	if (not Char) then Char = 0 end
	if (inBack) then
		assert((inBack==true) or (inBack==false),"LibKjasi:SetLen: bad argument #4: Expected boolian true or false, got "..type(inBack).." "..tostring(inBack)..".")
	else
		inBack = false
	end
	local l = strlen(Val)
	while l < Len do
		if (inBack == true) then
			Val = Val..Char
		else
			Val = Char..Val
		end
		l = strlen(Val)
	end

	return Val
end