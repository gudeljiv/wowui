-- TODO:
-- TODO:
-- Test/fix Bar spam test bug report
-- Test /reload then add via chat, open UI and use remove button
-- Test /reload then add via unit right click, open UI and use remove
-- Do the above two for NPC and players
-- Need to set needSorted to true always in any add or remove function
-- Or change it from "needSorted" to "needIndex"

----------------------------------
-- Global Ignore List Variables --
----------------------------------

GIL_Loaded				= false
GIL_SyncOK				= false
GIL_SyncTried			= false
lastFilterError			= false

local _, L				= ...
local GILFRAME			= nil
local gotLoaded			= false
local gotEntering		= false
local safeToLoad		= false
local faction			= nil
local maxIgnoreSize		= 50
local maxSyncTries		= 1
local maxHistorySize	= 100
local firstClear		= false
local firstPrune		= false
local pruneDays			= 0
local timer				= 0
local loadedTime		= GetTime()
local lastSentIgnore	= ""
local lastFilterMsg		= ""
local lastFilterResult	= ""
local filterDefDesc		= {}
local filterDefFilter	= {}
local filterDefActive   = {}
local needPartyClose	= false
local gotGroup          = IsInGroup()
local partyNameUI		= ""
local groupWarning      = {}

--print ("DEBUG gotGroup=" .. (tostring(gotGroup) or "NIL"))

local BlizzardAddIgnore			= nil
local BlizzardDelIgnore			= nil
local BlizzardDelIgnoreByIndex	= nil
local BlizzardAddOrDelIgnore	= nil
local BlizzardInviteUnit		= nil

----------------------------------
-- Global Ignore List Functions --
----------------------------------

function ShowMsg (msg)
	print ("|cff33ff99Global Ignore: |cffffffff" .. (msg or "Critical error"))
end

local function OnOff (value)
	if value == nil or value == false then
		return "|cffffff00" .. L["OFF"] .. "|cffffffff"
	elseif value == true then
		return "|cffffff00" .. L["ON"] .. "|cffffffff"
	else
		return "|cffff0000nil"
	end
end

function dayString (value)
	if value == 1 then
		return L["DAY"]
	else
		return L["DAYS"]
	end
end

local function AddToList(newname, newfaction, newnote, newtype)

	local index = #GlobalIgnoreDB.ignoreList+1
	
	GlobalIgnoreDB.ignoreList[index] = newname
	GlobalIgnoreDB.factionList[index] = newfaction
	GlobalIgnoreDB.dateList[index] = date("%d %b %Y")
	GlobalIgnoreDB.notes[index] = (newnote or "")
	GlobalIgnoreDB.expList[index] = GlobalIgnoreDB.defexpire
	GlobalIgnoreDB.typeList[index] = (newtype or "player")
	GlobalIgnoreDB.syncInfo[index] = {}	
end

local function RemoveFromList(index)

	if index <= #GlobalIgnoreDB.ignoreList then
		table.remove(GlobalIgnoreDB.ignoreList, index)
		table.remove(GlobalIgnoreDB.factionList, index)
		table.remove(GlobalIgnoreDB.dateList, index)
		table.remove(GlobalIgnoreDB.notes, index)
		table.remove(GlobalIgnoreDB.expList, index)
		table.remove(GlobalIgnoreDB.typeList, index)
		table.remove(GlobalIgnoreDB.syncInfo, index)
	end
end

local function getSyncValue (index)
	-- value, index of syncInfo data
		
	local s = ""
	local p = ""
	local v = 0
	
	for c = 1, #GlobalIgnoreDB.syncInfo[index] do
	
		s = GlobalIgnoreDB.syncInfo[index][c]
		p = string.find(s, "@", 1, true)
			
		if p > 0 then
			v = tonumber(string.sub(s, p + 1))
			s = string.sub(s, 1, p - 1)
			
			if playerName == s then
				return v, c				
			end
		end
	end
	
	return 0, 0
end

local function setSyncValue (index)

	local val,idx = getSyncValue(index)
	
	if idx == 0 then
		idx = #GlobalIgnoreDB.syncInfo[index] + 1	
	end
	
	val = val + 1
	
	GlobalIgnoreDB.syncInfo[index][idx] = playerName .. "@" .. val
end		

local function isServerMatch (server1, server2)

	return Proper(server1) == Proper(server2)	
end

local function hasIgnored (name)

	local result = 0
	
	name = Proper(addServer(name))
		
	for count = 1, C_FriendList.GetNumIgnores() do
	
		if name == Proper(addServer(C_FriendList.GetIgnoreName(count))) then
			result = count
			
			break
		end
	end
	
	return result
end

function hasNPCIgnored (name)

	if not name then return 0 end
	
	for count = 1, #GlobalIgnoreDB.ignoreList do
		if GlobalIgnoreDB.ignoreList[count] == name and GlobalIgnoreDB.typeList[count] == "npc" then
			return count
		end
	end
	
	return 0
end

local function hasServerIgnored (name)

	if not name then return 0 end
	
	for count = 1, #GlobalIgnoreDB.ignoreList do
		if GlobalIgnoreDB.ignoreList[count] == name and GlobalIgnoreDB.typeList[count] == "server" then
			return count
		end
	end
	
	return 0
end

function hasGroupWarning (name)

	if not name then return 0 end
	
	for count = 1, #groupWarning do
		if groupWarning[count] == name then
			return count
		end
	end

	return 0
end

function hasGlobalIgnored (name)

	if not name then return 0 end

	for count = 1, #GlobalIgnoreDB.ignoreList do
		if GlobalIgnoreDB.ignoreList[count] == name and GlobalIgnoreDB.typeList[count] == "player" then
			return count
		end
	end
	
	return 0
end

function hasAnyIgnored (name)

	if not name then return 0 end

	for count = 1, #GlobalIgnoreDB.ignoreList do
	
		if GlobalIgnoreDB.ignoreList[count] == name then
			return count
		end
	end
	
	return 0
end

local function hasDeleted (name)

	if not name then return 0 end
	
	for count = 1, #GlobalIgnoreDB.delList do
		if GlobalIgnoreDB.delList[count] == name then
			return count
		end
	end
	
	return 0
end

local function addDeleted (name)

	local idx = hasDeleted(name)
	
	if idx == 0 then
		if #GlobalIgnoreDB.delList >= maxHistorySize then
			table.remove(GlobalIgnoreDB.delList, 1)
		end
		
 		GlobalIgnoreDB.delList[#GlobalIgnoreDB.delList + 1] = name
 	end
end

local function removeDeleted (name)
	local idx = hasDeleted(name)
	
	if idx > 0 then
		table.remove(GlobalIgnoreDB.delList, idx)
	end
end

local function ShowIgnoreList (param)
	local days   = tonumber(param)
	local sName  = ""
	
	if not days then
	
		days  = 0
		sName = param
		
		if not sName then
			sName = ""
		end
	end
	
	if days > 0 then
		ShowMsg("|cffffff00" .. format(L["LIST_1"], days))
	else
		if sName ~= "" then
			sName = Proper(sName)
			
			if sName == "Npc" then
				ShowMsg("|cffffff00".. L["LIST_2"])
			else			
				if sName == "Server" then
					sName = serverName		
				end
				
				ShowMsg("|cffffff00" .. format(L["LIST_3"], sName))
			end
		else
			ShowMsg("|cffffff00" .. L["LIST_4"])
		end
	end
	
	local count = 0
	
	for key,value in pairs(GlobalIgnoreDB.ignoreList) do
	
		local ok   = true
		local type = "P"
		
		if GlobalIgnoreDB.typeList[key] == "npc" then
			type = "N"
		elseif GlobalIgnoreDB.typeList[key] == "server" then
			type = "S"
		end
	
		if days > 0 then
		
			ok = daysFromToday(GlobalIgnoreDB.dateList[key]) >= days
			
		elseif sName ~= "" then
		
			ok = (type == "N" and sName == "Npc") or (type == "P" and isServerMatch(sName, getServer(value))) or (type == "S" and isServerMatch(sName, value))

		end
		
		if ok then
			local str = "  (" .. key .. ") [" .. type.. "] " .. value .. " (" .. (GlobalIgnoreDB.factionList[key] or "Unknown") .. ") " .. "[".. daysFromToday(GlobalIgnoreDB.dateList[key]) .. " "..L["DAYS"] .. "]"
			
			if GlobalIgnoreDB.notes[key] ~= "" then
				str = str .." (" .. GlobalIgnoreDB.notes[key] .. ")"
			end
			
			ShowMsg(str)

			count = count + 1			
		end
		
	end
	
	ShowMsg("|cffffff00" .. format(L["LIST_5"], count))
end

function ResetSpamFilters()
	GlobalIgnoreDB.filterList   = {}
	GlobalIgnoreDB.filterDesc   = {}
	GlobalIgnoreDB.filterCount  = {}
	GlobalIgnoreDB.filterActive = {}
	
	GlobalIgnoreDB.invertSpam = false
	GlobalIgnoreDB.spamFilter = true
	GlobalIgnoreDB.autoUpdate = true
	
	for count = 1, #filterDefDesc do
		GlobalIgnoreDB.filterDesc[count]  = filterDefDesc[count]
		GlobalIgnoreDB.filterList[count]  = filterDefFilter[count]
		GlobalIgnoreDB.filterActive[count] = filterDefActive[count]		
		GlobalIgnoreDB.filterCount[count] = 0
	end
end

local function ResetIgnoreDB()

	GlobalIgnoreDB = {
		chatmsg			= true,
		sameserver		= true,
		samefaction		= true,
		openWithFriends	= true,
		attachFriends   = true,
		trackChanges	= true,
		spamFilter		= true,
		invertSpam		= true,
		autoIgnore		= true,
		autoUpdate      = true,
		autoCount		= 3,
		autoTime		= 600,		
		defexpire		= 0,
		ignoreList		= {},
		factionList		= {},
		dateList		= {},
		notes			= {},
		expList			= {},
		typeList		= {},  
		delList			= {},
		syncInfo		= {},
		filterTotal		= 0,
		filterCount		= {},
		filterDesc		= {},
		filterList		= {},
		skipGuild		= true,
		skipParty		= false,
		skipPrivate		= true
	}
	
	GlobalIgnoreImported = false
	
	ResetSpamFilters()
end

local function isValidList()

	if C_FriendList.GetNumIgnores() > 0 then
		local str	
		local found = 0
			
		for count = 1, C_FriendList.GetNumIgnores() do
			str = removeServer(C_FriendList.GetIgnoreName(count), true)

			if str ~= nil and str ~= UNKNOWN then
				break
			end
				
			found = found + 1
		end
 			
		if str == nil or str == UNKNOWN then
			ShowMsg(format(L["LOAD_5"], found, UNKNOWN))
					
			return false
		end
	end
	
	return true
end

function SyncIgnoreList (silent)

	if silent == nil then
		silent = false
	end
	
	ShowMsg(L["LOAD_4"])

	if isValidList() == false then
		return
	end
	
	-- import ignore list if first time sync
	
	if GlobalIgnoreImported == nil or GlobalIgnoreImported ~= true then
	
		local ignores = C_FriendList.GetNumIgnores()	
		local added   = 0
		local name
			
		if (ignores > 0) and (silent == false) then
			ShowMsg(L["LOAD_2"])
		end
			
		for count = 1, ignores do
			
			name = C_FriendList.GetIgnoreName(count)
			
			if name ~= nil then
			
				if removeServer(name, true) ~= UNKNOWN then
				
					name = Proper(addServer(name))

					if hasGlobalIgnored(name) == 0 then
						added = added + 1
						
						AddToList(name, faction)
										
						if silent == false then
							ShowMsg (format(L["LOAD_3"], name))
						end
					end
				end
			end				
		end
		
		GlobalIgnoreImported = true
	end	
	
	-- first remove expired entries
	
	local count = 0
	
	while count < #GlobalIgnoreDB.dateList do
		count = count + 1
		
		if GlobalIgnoreDB.expList[count] > 0 and daysFromToday(GlobalIgnoreDB.dateList[count]) >= GlobalIgnoreDB.expList[count] then
			local name = addServer(GlobalIgnoreDB.ignoreList[count])		
			C_FriendList.DelIgnore(name)
			count = 0
		end
	end
	
	-- find account ignores that aren't on global ignore and do things
	
	for count = 1, C_FriendList.GetNumIgnores() do
	
		local name       = addServer(C_FriendList.GetIgnoreName(count))
		local skipRemove = false
		local globIdx	 = hasGlobalIgnored(name)
	
		if globIdx == 0 then
			if GlobalIgnoreDB.trackChanges == true then
			
				local idx = hasDeleted(name)
				
				if idx == 0 then
					skipRemove = true
					C_FriendList.AddIgnore(name, true)
				end
			end
			
			if skipRemove == false then

				if not silent then
					ShowMsg (format(L["SYNC_1"], name))
				end			
				
				BlizzardDelIgnoreByIndex (hasIgnored(name))
			end
		else
			GlobalIgnoreDB.syncInfo[globIdx] = {}
		end
	end
	
	if GlobalIgnoreDB.trackChanges == true then
		local listCount = 0
		
		while listCount <= #GlobalIgnoreDB.ignoreList do
		
			if GlobalIgnoreDB.typeList[listCount] == "player" then
			
				local tries = getSyncValue(listCount)

				if tries >= maxSyncTries then
					C_FriendList.DelIgnore(removeServer(GlobalIgnoreDB.ignoreList[listCount]))
					listCount = listCount - 1				
				end
			end
			
			listCount = listCount + 1
		end	
	end

--	local ignoreCount = C_FriendList.GetNumIgnores()
--	
	-- if ignore list is larger than our max we must remove players until it gets to max
	
--	if ignoreCount > maxIgnoreSize then				
--		if ignoreCount > maxIgnoreSize then
--			local name = C_FriendList.GetIgnoreName(ignoreCount)
--			print("DEBUG Reducing Max account ignore: "..name)
--			BlizzardDelIgnore(ignoreCount)
--			print("DEBUG Readding to global ignore")
--			AddIgnore(name, true)
--			ignoreCount = C_FriendList.GetNumIgnores()
--		end
--	end

	-- move qualified players to account wide ignore if there is room for it

	local ignoreCount = C_FriendList.GetNumIgnores()
	
	if ignoreCount < maxIgnoreSize then

		for key,value in pairs(GlobalIgnoreDB.ignoreList) do
		
			if GlobalIgnoreDB.typeList[key] == "player" then
		
				local name = addServer(value)
				
				--print("DEBUG processing: ".. name .. " ignored? ".. hasIgnored(name));
				
				if hasIgnored(name) == 0 then
					-- should we add an option to not always samefaction sync?
					
					local ok = (GlobalIgnoreDB.factionList[key] == faction)

					if ok then
						ok = (isServerMatch(serverName, getServer(name))) or (GlobalIgnoreDB.sameserver == false)
					end
					
					if ok then
						ignoreCount = ignoreCount + 1
						
						setSyncValue(key)
						
						name = removeServer(name)

						if not silent then
							ShowMsg (format(L["SYNC_2"], name))
						end					
								
						BlizzardAddIgnore(name)
					end
				end
			end
			
			if ignoreCount >= maxIgnoreSize then
				break
			end
		end
	end	

	GIL_SyncOK = true
end

local function PruneIgnoreList (days, doit)

	if days == nil or days <= 0 then		
		return 0
	end

	local targets = 0
	local count   = 0
	
	while count < #GlobalIgnoreDB.dateList do
		count = count + 1
	
		if daysFromToday(GlobalIgnoreDB.dateList[count]) >= days then
			targets = targets + 1
			
			local name = addServer(GlobalIgnoreDB.ignoreList[count])
					
			if doit == true then
				C_FriendList.DelIgnore(name)
				count = 0
			end
		end
	end
	
	return targets
end

local function ApplicationStartup(self)

	if GIL_Loaded == true or safeToLoad == false then
		return
	end
	
	ShowMsg(L["LOAD_1"])
	
	-- Set filter defaults
	
	filterDefDesc[#filterDefDesc + 1]     = "Filter \"Anal\" Spammers"
	filterDefFilter[#filterDefFilter + 1] = "([word=anal] or [contains=analan]) and ([link] or [words=2])"
	filterDefActive[#filterDefActive + 1] = true

	filterDefDesc[#filterDefDesc + 1]     = "Filter Thunderfury linking"
	filterDefFilter[#filterDefFilter + 1] = "[item=19019]"
	filterDefActive[#filterDefActive + 1] = true

	filterDefDesc[#filterDefDesc + 1]     = "Filter Gold Spam #1"
	filterDefFilter[#filterDefFilter + 1] = "([contains=.c0m] or [contains=.c.0.m] or [contains=,com] or ([contains=.com] and ([contains=code] or [contains=usd] or [contains=+15]))"	
	filterDefActive[#filterDefActive + 1] = true

	filterDefDesc[#filterDefDesc + 1]     = "Filter Gold Spam #2"
	filterDefFilter[#filterDefFilter + 1] = "([contains=░] or [contains=▒] or [contains=▓] or [contains=█]) and ([contains=wts] or [contains=sell] or [contains=gold] or [contains=share]))"
	filterDefActive[#filterDefActive + 1] = true

	filterDefDesc[#filterDefDesc + 1]     = "Filter Gold Spam #3"
	filterDefFilter[#filterDefFilter + 1] = "([contains=deliver] or [contains=delivery] or [contains=gold] or [contains=delievery] or [contains=sale]) and ([contains=.com] or [contains=,com] or [contains=c0m])"
	filterDefActive[#filterDefActive + 1] = true

	filterDefDesc[#filterDefDesc + 1]     = "Filter Gold Spam #4"
	filterDefFilter[#filterDefFilter + 1] = "([contains=wts] or [contains=sell]) and [contains=share] and ([contains=account] or [contains=acc]))"
	filterDefActive[#filterDefActive + 1] = true
	
	filterDefDesc[#filterDefDesc + 1]     = "Filter Guild Recruitment"
	filterDefFilter[#filterDefFilter + 1] = "(([contains=<] and [contains=>]) or ([contains=\\[] and [contains=\\]]) or ([contains=\\(] and [contains=\\)])) and ([contains=recruit] or [contains=progress] or [contains=raid] or [contains=guild] or [contains=seek] or [contains=mythic])"
	filterDefActive[#filterDefActive + 1] = false

	filterDefDesc[#filterDefDesc + 1]     = "Filter Community Recruitment"
	filterDefFilter[#filterDefFilter + 1] = "[community]"
	filterDefActive[#filterDefActive + 1] = false

	filterDefDesc[#filterDefDesc + 1]     = "Filter WTS"
	filterDefFilter[#filterDefFilter + 1] = "[contains=WTS] or [contains=WTB]"
	filterDefActive[#filterDefActive + 1] = false

	filterDefDesc[#filterDefDesc + 1]     = "Filter Chinese/Korean/Japanese"
	filterDefFilter[#filterDefFilter + 1] = "[nonlatin]"
	filterDefActive[#filterDefActive + 1] = false

	faction = UnitFactionGroup("player")
		
	if GlobalIgnoreDB == nil then	
		ResetIgnoreDB()	
	end
	
	-- set missing defaults or upgrade if needed

	if GlobalIgnoreDB.skipPrivate == nil then
		GlobalIgnoreDB.skipPrivate = true
	end

	if GlobalIgnoreDB.skipParty == nil then
		GlobalIgnoreDB.skipParty = false
	end

	if GlobalIgnoreDB.skipGuild == nil then
		GlobalIgnoreDB.skipGuild = true
	end
	
	if GlobalIgnoreDB.filterTotal == nil then
		GlobalIgnoreDB.filterTotal = 0
	end

	if GlobalIgnoreDB.spamFilter == nil then
		GlobalIgnoreDB.spamFilter = true
	end
	
	if GlobalIgnoreDB.invertSpam == nil then
		GlobalIgnoreDB.invertSpam = false
	end
	
	if GlobalIgnoreDB.autoIgnore == nil then
		GlobalIgnoreDB.autoIgnore = true
	end
	
	if GlobalIgnoreDB.autoUpdate == nil then
		GlobalIgnoreDB.autoUpdate = true
	end
	
	if GlobalIgnoreDB.autoCount == nil then
		GlobalIgnoreDB.autoCount = 3
	end
	
	if GlobalIgnoreDB.autoTime == nil then
		GlobalIgnoreDB.autoTime = 600
	end
	
	if GlobalIgnoreDB.filterList == nil or GlobalIgnoreDB.filterDesc == nil or GlobalIgnoreDB.filterCount == nil then
		ResetSpamFilters()
	end
	
	if GlobalIgnoreDB.delList == nil then
		GlobalIgnoreDB.delList = {}
	end
		
	if GlobalIgnoreDB.defexpire == nil then
		GlobalIgnoreDB.defexpire = 0
	end
	
	if not tonumber(GlobalIgnoreDB.defexpire) then
		GlobalIgnoreDB.defexpire = 0
	end
	
	if GlobalIgnoreDB.trackChanges == nil then
		GlobalIgnoreDB.trackChanges = true
	end
	
	if GlobalIgnoreDB.openWithFriends == nil then
		GlobalIgnoreDB.openWithFriends = true
	end
	
	if not GlobalIgnoreDB.attachFriends == nil then
		GlobalIgnoreDB.attachFriends = true
	end
	
	if GlobalIgnoreDB.asknote == nil then
		GlobalIgnoreDB.asknote = true
	end
		
	if GlobalIgnoreDB.expList == nil then
		GlobalIgnoreDB.expList = {}
			
		for  count = 1, #GlobalIgnoreDB.ignoreList do
			GlobalIgnoreDB.expList[count] = 0
		end
	end
	
	if GlobalIgnoreDB.syncList then
		GlobalIgnoreDB.syncList = nil
	end
	
	if GlobalIgnoreDB.syncInfo == nil then
		GlobalIgnoreDB.syncInfo = {}
		
		for count = 1, #GlobalIgnoreDB.ignoreList do
			GlobalIgnoreDB.syncInfo[count] = {}
		end
	end
	
	if GlobalIgnoreDB.typeList == nil then
		GlobalIgnoreDB.typeList = {}
		
		for count = 1, #GlobalIgnoreDB.ignoreList do
			GlobalIgnoreDB.typeList[count] = "player"
		end
	end
	
	if GlobalIgnoreDB.revision == nil then
		GlobalIgnoreDB.revision = 1
		
		for count = 1, #GlobalIgnoreDB.ignoreList do
			GlobalIgnoreDB.ignoreList[count] = Proper(GlobalIgnoreDB.ignoreList[count])
		end
	end
	
	if GlobalIgnoreDB.filterActive == nil then
		GlobalIgnoreDB.filterActive = {}
		
		for count = 1, #GlobalIgnoreDB.filterDesc do
			GlobalIgnoreDB.filterActive[count] = true
		end
	end

	loadedTime = GetTime()
		
	SyncIgnoreList(GlobalIgnoreDB.chatmsg == nil or GlobalIgnoreDB.chatmsg == false)
		
	GIL_Loaded = true
	
	self:UnregisterEvent("IGNORELIST_UPDATE")
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("ADDON_LOADED")
	
	-- Synchronize spam filters with defaults, if enabled

	if GlobalIgnoreDB.autoUpdate == true then
	
		for count = 1, #filterDefDesc do
		
			local found = false
		
			for count2 = 1, #GlobalIgnoreDB.filterDesc do
			
				if GlobalIgnoreDB.filterDesc[count2] == filterDefDesc[count] then
					found = true
					
					GlobalIgnoreDB.filterList[count2] = filterDefFilter[count]
					
					break
				end
			end
			
			if found == false then
				ShowMsg("Adding new spam filter: " .. filterDefDesc[count])
				
				GlobalIgnoreDB.filterDesc[#GlobalIgnoreDB.filterDesc + 1]     = filterDefDesc[count]
				GlobalIgnoreDB.filterList[#GlobalIgnoreDB.filterList + 1]     = filterDefFilter[count]
				GlobalIgnoreDB.filterActive[#GlobalIgnoreDB.filterActive + 1] = filterDefActive[count]
				GlobalIgnoreDB.filterCount[#GlobalIgnoreDB.filterCount + 1]   = 0
			end
		end	
	end
end

-------------------
-- EVENT HANDLER --
-------------------

local function EventHandler (self, event, sender, ...)

	--print ("DEBUG event=".. (event or "nil"))
	--print ("DEBUG event=".. (event or "nil") .. " sender=" .. (sender or "nil"))
	
	if (event == "CHANNEL_INVITE_REQUEST") then
		print ("DEBUG RECEIVED CHANNEL INVITE REQUEST")
	end

	if (event == "ADDON_LOADED") and (sender == "GlobalIgnoreList") then
		gotLoaded = true
	end
	
	if event == "IGNORELIST_UPDATE" then
		gotUpdate = true
	end

	if event == "PLAYER_ENTERING_WORLD" then
		gotEntering = true
	end

	if event == "GROUP_ROSTER_UPDATE" then
		if gotGroup == true and not IsInGroup() then
			gotGroup     = false
			groupWarning = {}
		elseif gotGroup == false and IsInGroup() then
			gotGroup = true			
		elseif gotGroup == true then
			local prefix  = IsInRaid() and "raid" or "party"
			local name    = ""
			local doWarn  = false
			
			for count = 1, GetNumGroupMembers() do	
				name = GetUnitName(prefix..count, true)
			
				if name then
					name = addServer(name)
					
					if hasGlobalIgnored(name) > 0 and hasGroupWarning(name) == 0 then					
						doWarn = true
						groupWarning[#groupWarning + 1] = name
					end
				end
			end
			
			if doWarn then
				local nameList = ""
				
				for count = 1, #groupWarning do
					nameList = nameList .. "\n" .. groupWarning[count]
				end
				
				ShowMsg(format(L["CHAT_1"], #groupWarning, nameList))

				StaticPopup_Show("GIL_PARTYWARN", #groupWarning, nameList)
			end
		end		
	end
	
	if event == "PARTY_INVITE_REQUEST" and GIL_Loaded == true then
	
		sender = addServer(sender)

		if hasGlobalIgnored(sender) > 0 then
			DeclineGroup()			
			ShowMsg("Automatically declined invite from " .. sender)
			StaticPopup_Hide("PARTY_INVITE")
		end
		
		return
	end
	
	if event == "DUEL_REQUESTED" and GIL_Loaded == true then
		sender = addServer(sender)
		
		if hasGlobalIgnored(sender) > 0 then
			CancelDuel()
			ShowMsg("Automatically declined duel from " .. sender)
		end
		
		return
	end

	if gotLoaded == true and gotEntering == true then
		if safeToLoad ~= true and gotUpdate ~= true then
		
			timer = 0
		
			self:SetScript("OnUpdate", function(Self, elapsed)
			
				timer = timer + elapsed
							
				if timer < 5 then
					return
				end
												
				self:SetScript("OnUpdate", nil)
				self:Hide()
				
				safeToLoad = true			
			end)
			
		end

		safeToLoad = true
	end	

	if safeToLoad == true then
		ApplicationStartup(self)
	end
end

------------------------
-- SPAM FILTER ENGINE --
------------------------

function filterComplex (filterStr, chatStr, chNum)
	-- true=should be filtered
	-- chatStr should be convered to all lower
	
	local chatData	= {}
	local itemID	= {}
	local spellID	= {}
	local achieveID = {}
	local petID     = {}
	local talentID  = {}
	local gmatch	= string.gmatch
	local sub		= string.sub
	local find		= string.find
	local lower		= string.lower
	local char		= string.char
	local len		= string.len
	local icons     = 0		
	local pos1
	
	--print("Start="..gsub(chatStr, "\124", "\124\124"))

	repeat
		pos1 = find(chatStr, "|htalent:", 1, true)
		
		if not pos1 then break end
		
		talentID[#talentID + 1] = sub(chatStr, pos1 + 9, find(chatStr, "[", pos1 + 9, true) - 1)
		
		chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, find(chatStr, "|h|r", pos1 + 9, true) + 4, -1)
	until false
	
	repeat
		pos1 = find(chatStr, "|c", 1, true)
		
		if not pos1 then break end
		
		chatStr = sub(chatStr, 1, pos1 - 1) .. sub(chatStr, pos1 + 10, -1)
	until false
	
	repeat
		pos1 = find(chatStr, "|hbattlepet:", 1, true)
		
		if not pos1 then break end
		
		petID[#petID + 1] = sub(chatStr, pos1 + 12, find(chatStr, ":", pos1+13, true) - 1)
		
		chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, find(chatStr, "|h|r", pos1 + 12, true) + 4, -1)
	until false

	repeat
		pos1 = find(chatStr, "|hitem:", 1, true)
		
		if not pos1 then break end
		
		itemID[#itemID + 1] = sub(chatStr, pos1 + 7, (find(chatStr, ":", pos1 + 7, true) or (find(chatStr, "[", pos1 + 8, true))) - 1)
		
		chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, (find(chatStr, "|h|r", pos1 + 8, true) or (find(chatStr, "|r|h", pos1 + 8, true))) + 4, -1)	
	until false
	
	repeat
		pos1 = find(chatStr, "|hspell:", 1, true)
		
		if not pos1 then break end
		
		spellID[#spellID + 1] = sub(chatStr, pos1 + 8, find(chatStr, ":", pos1 + 9, true) - 1, true)
		
		chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, find(chatStr, "|h|r", pos1 + 8, true) + 4, -1)
	until false

	repeat
		pos1 = find(chatStr, "|hachievement:", 1, true)
		
		if not pos1 then break end

		achieveID[#achieveID + 1] = sub(chatStr, pos1 + 14, find(chatStr, ":", pos1 + 15, true) - 1, true)
		
		chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, find(chatStr, "|h|r", pos1 + 14, true) + 4, -1)
	until false

	repeat
		pos1 = find(chatStr, "{rt%d}")
		
		if pos1 then
			icons   = icons + 1
			chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 5, -1)
		else
		
			pos1 = find(chatStr, "{x}", 1, true)
			
			if pos1 then
			
				icons   = icons + 1
				chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 3, -1)
				
			else
			
				pos1 = find(chatStr, "{star}", 1, true)
		
				if pos1 then
				
					icons   = icons + 1
					chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 6, -1)
					
				else
				
					pos1 = find(chatStr, "{coin}", 1, true)
		
					if pos1 then
				
						icons   = icons + 1
						chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 6, -1)
					
					else		

						pos1 = find(chatStr, "{moon}", 1, true)
		
						if pos1 then
				
							icons   = icons + 1
							chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 6, -1)
						
						else		

							pos1 = find(chatStr, "{cross}", 1, true)
			
							if pos1 then
				
								icons   = icons + 1
								chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 7, -1)
							else
							
								pos1 = find(chatStr, "{skull}", 1, true)
			
								if pos1 then
				
									icons   = icons + 1
									chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 7, -1)
									
								else

									pos1 = find(chatStr, "{square}", 1, true)
								
									if pos1 then
										icons   = icons + 1
										chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 8, -1)
									else

										pos1 = find(chatStr, "{circle}", 1, true)
								
										if pos1 then
											icons   = icons + 1
											chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 8, -1)
										else
							
											pos1 = find(chatStr, "{diamond}", 1, true)
								
											if pos1 then
												icons   = icons + 1
												chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 9, -1)
											else
				
												pos1 = find(chatStr, "{triangle}", 1, true)
								
												if pos1 then
													icons   = icons + 1
													chatStr = sub(chatStr, 1, pos1 - 1) .. " " .. sub(chatStr, pos1 + 10, -1)
												else
													break
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end		
		end
		
	until false	

	--print("After="..gsub(chatStr, "\124", "\124\124"))
	
	for word in gmatch(chatStr, "%S+") do
		word = string.gsub(word, "[%p]+$", "")
		
		if word ~= "" then
			chatData[#chatData + 1] = word
			
			--print("word="..gsub(word, "\124", "\124\124"))			
		end		
	end
	
	--print ("DEBUG filter word count is " .. #chatData)
	
	-----------	
	
	local filterCount = 0
	
	while (filterCount < #GlobalIgnoreDB.filterList) or (filterCount == 0 and filterStr ~= nil) do
	
		if (filterCount > 0) or ((filterCount == 0) and (filterStr == nil)) then
			filterCount = filterCount + 1
		
			if GlobalIgnoreDB.filterActive[filterCount] == true then
				filterStr = "( " .. GlobalIgnoreDB.filterList[filterCount] .. " )"
			else
				filterStr = nil
			end
		else
			filterStr = "( " .. filterStr .. " )"
		end
		
		--print ("DEBUG BEGIN ---")
		--print ("DEBUG filterStr="..filterStr)
		
		if filterStr ~= nil then

			local filterLen		= string.len(filterStr)
			local filterPos		= 0	
			local token			= ""
			local tokenData		= ""
			local result 		= ""
			local gotPR, gotPL	= false
			local contains		= false
			local gotEscaped	= false
			local wasEscaped	= false
			local c, c2
			local tempPos	
			local found
			
			lastFilterError = false
	
			while (filterPos < filterLen) and (lastFilterError == false) do
			
				--print("DEBUG loop ".. filterPos .. " of " .. filterLen)

				wasEscaped = false
				
				if gotPL == true then
					c     = " " 
					token = "("
					gotPL = false
				elseif gotPR == true then
					c     = " "
					token = ")"
					gotPR = false
				else
					filterPos = filterPos + 1
					
					c = strbyte(filterStr, filterPos)

					if gotEscaped == true then
						if c == 32 then
							c = " "
						elseif c == 40 then
							c = "("
						elseif c == 41 then
							c = ")"							
						elseif c == 91 then
							c = "["
						elseif c == 92 then
							c = "\\"
						elseif c == 93 then
							c = "]"
						end
						
						gotEscaped = false
						wasEscaped = true
					elseif c == 92 then
						c = ""					
						gotEscaped = true
						--print("DEBUG got escaped!")						
					elseif c < 32 or c > 126 then
						c = char(c)
					else
						c = lower(char(c))			
					end
				end

				if (wasEscaped == false and (c == " " or c == "(" or c == ")") or filterPos == filterLen) then
					if c == "(" then
						gotPL = true
					elseif c == ")" then
						gotPR = true
					elseif filterPos == filterLen and c ~= " " then
						token = token .. c
					end
									
					if token ~= "" then
						--print("DEBUG tokenStart="..token)
						tempPos = find(token, "=", 1, true)
					
						if tempPos then
							tokenData = sub(token, tempPos+1, strlen(token)-1)
							token	  = sub(token, 1, tempPos-1).."]"
						else
							tokenData = ""
						end
						
						token = trim(token)
						
						--print("DEBUG token=#"..token.. "#")
						--print("DEBUG tokenData=#"..tokenData .. "#")
						
						if token == "(" then
							result = result..token
						elseif token == ")" then
							result = result..token
						elseif token == "not" then
							result = result .. "!"
						elseif token == "and" then
						elseif token == "or" then
							result = result.."|"
						elseif token == "[word]" then
							found = false
		
							for count = 1, #chatData do
								if chatData[count] == tokenData then
									found = true
									break
								end
							end
						
							if found == true then
								result = result .. "T"
							else
								result = result .. "F"					
							end
						elseif token == "[contains]" then
							--print("DEBUG want to filter="..chatStr)
							--print("DEBUG testing against (tokenData)="..tokenData)
							--print("DEBUG result="..(string.find(chatStr, tokenData, 1, true) or "0"))
							
							if string.find(chatStr, tokenData, 1, true) ~= nil then
								result = result .. "T"						
							else
								result = result .. "F"									
							end
						elseif token == "[channel]" then
							if tonumber(tokenData) == chNum then
								result = result .. "T"
							else
								result = result .. "F"
							end								
						elseif token == "[words]" then
							if tonumber(tokenData) == #chatData then
								result = result .. "T"
							else
								result = result .. "F"	
							end		
						elseif token == "[item]" then
							if tokenData == "" then
								if #itemID > 0 then
									result = result .. "T"						
								else
									result = result .. "F"
								end
							else
								found = false
							
							for count = 1, #itemID do
									if tokenData == itemID[count] then
										found = true
										break
									end
								end
							
								if found == true then
									result = result .. "T"						
								else
									result = result .. "F"						
								end
							end
						elseif token == "[spell]" then
							if tokenData == "" then
								if #spellID > 0 then
									result = result .. "T"
								else
									result = result .. "F"						
								end
							else
								found = false
								
								for count = 1, #spellID do
									if tokenData == spellID[count] then
										found = true
										break
									end
								end
								
								if found == true then
									result = result .. "T"						
								else
									result = result .. "F"
								end
							end
						elseif token == "[achievement]" then
							if tokenData == "" then
								if #achieveID > 0 then
									result = result .. "T"
								else
									result = result .. "F"
								end
							else
								found = false
							
								for count = 1, #achieveID do
									if tokenData == achieveID[count] then
										found = true
										break
									end
								end
							
								if found == true then
									result = result .. "T"						
								else
									result = result .. "F"						
								end
							end
						elseif token == "[icon]" then
							if tokenData == "" then
								if icons > 0 then
									result = result .. "T"
								else
									result = result .. "F"
								end
							else
								if icons >= (tonumber(tokenData) or 0) then
									result = result .. "T"
								else
									result = result .. "F"
								end
							end
							
						elseif token == "[pet]" then
							if tokenData == "" then
								if #petID > 0 then
									result = result .. "T"
								else
									result = result .. "F"
								end
							else
								found = false
								
								for count = 1, #petID do
									if tokenData == petID[count] then
										found = true
										break
									end
								end
								
								if found == true then
									result = result .. "T"
								else
									result = result .. "F"
								end
							end
						
						elseif token == "[link]" then
							if #achieveID > 0 or #spellID > 0 or #itemID > 0 or #talentID > 0 or #petID > 0 then
								result = result .. "T"
							else
								result = result .. "F"
							end
							
						elseif token == "[community]" then							
							if find(chatStr, "|hclubticket:", 1, true) then
								result = result .. "T"
							else
								result = result .. "F"
							end
								
						elseif token == "[nonlatin]" then
							if strfind(chatStr, "[\227-\237]") then
								result = result .. "T"
							else
								result = result .. "F"
							end
						else
							--print ("DEBUG filter error="..token .. " data="..tokenData)
							lastFilterError = true
						end
					
						token = ""
					end
				else
					token = token .. c
				end
			end
					
			if lastFilterError == false then
			
				local p1	= 0
				local p2	= 0
				local ch1
				local ch2
				local count
				local chunk

				--print ("DEBUG filterResult start=" .. data)
	
				while find(result, "(", 1, true) do
					p2   = 1
					slen = len(result)
		
					while sub(result, p2, p2) ~= ")" and p2 <= slen do
						if sub(result, p2, p2) == "(" then
							p1 = p2
						end
		
						p2 = p2 + 1
					end
		
					chunk = sub(result, p1 + 1, p2 - 1)
		
					--print ("DEBUG filterResult chunk=" .. chunk)
		
					while find(chunk, "!", 1, true) do
						count = find(chunk, "!", 1, true) + 1
			
						if sub(chunk, count, count) == "T" then
							chunk = sub(chunk, 0, count - 2) .. "F" .. sub(chunk, count+1, len(chunk))
						elseif sub(chunk, count, count) == "F" then
							chunk = sub(chunk, 0, count - 2) .. "T" .. sub(chunk, count+1, len(chunk))			
						end				
					end
		
					while find(chunk, "|", 1, true) do
						count = find(chunk, "|", 1, true) - 1
						ch1   = sub(chunk, count, count)
						ch2   = sub(chunk, count+2, count+2)		
			
						if (ch1 == "T" or ch1 == "F") and (ch2 == "T" or ch2 == "F") then
							if ch1 == "T" or ch2 == "T" then
								chunk = sub(chunk, 0, count-1) .. "T" .. sub(chunk, count+3, len(chunk))
							else
								chunk = sub(chunk, 0, count-1) .. "F" .. sub(chunk, count+3, len(chunk))
							end
						else					
							--print("DEBUG not valid T/F")
							chunk = sub(chunk, 0, count) .. sub(chunk, count+2, len(chunk))
						end
					end
		
					while find(chunk, "TT", 1, true) do
						count = find(chunk, "TT", 1, true)
						chunk = sub(chunk, 0, count - 1) .. sub(chunk, count + 1, len(chunk))			
					end

					while find(chunk, "FF", 1, true) do
						count = find(chunk, "FF", 1, true)
						chunk = sub(chunk, 0, count - 1) .. sub(chunk, count + 1, len(chunk))			
					end
					
					while find(chunk, "TF", 1, true) do
						count = find(chunk, "TF", 1, true)
						chunk = sub(chunk, 0, count - 1) .. sub(chunk, count + 1, len(chunk))			
					end

					while find(chunk, "FT", 1, true) do
						count = find(chunk, "FT", 1, true)
						chunk = sub(chunk, 0, count) .. sub(chunk, count + 2, len(chunk))			
					end
		
					result = sub(result, 1, p1 - 1) .. chunk .. sub(result, p2+1, len(result))
		
					--print("DEBUG filterResult after="..result)
				end	
				
				--print("DEBUG filterResult end="..result)
				
				if result == "T" or result == "T)" then
					return true, filterCount
				end
			end
				
			if (filterCount == 0) then break end			
		end
	end
	
	return false	
end

----------------------------
-- CHAT FILTERING HANDLER --
----------------------------

--local lastMsg = ""

local function chatMessageFilter (self, event, message, from, t1, t2, t3, t4, t5, chnum, chname, ...)

	--if lastMsg ~= message then	
		--t = string.gsub(message, "|", "!")
		--print ("chatMsg evt=" .. (event or "nil") .. " msg=".. (t or "nil") .. " from=" .. (from or "nil"))
		--lastMsg = message
	--end

	if event == "CHAT_MSG_SYSTEM" then	
		if message == ERR_IGNORE_NOT_FOUND and GetTime() - loadedTime < 60 then
			return true
		end

		if message == ERR_IGNORE_ALREADY_S and GetTime() - loadedTime < 60 then
			return true
		end
			
		if message == ERR_IGNORE_FULL then
			return true
		end
	end
			
	if GIL_Loaded ~= true then
		return false
	end
	
	if event == "CHAT_MSG_MONSTER_EMOTE" or event == "CHAT_MSG_MONSTER_PARTY" or event == "CHAT_MSG_MONSTER_SAY" or
	   event == "CHAT_MSG_MONSTER_WHISPER" or event == "CHAT_MSG_MONSTER_YELL" then
	   
        	return (hasNPCIgnored(Proper(from, true)) > 0)
		
	elseif event == "CHAT_MSG_SYSTEM" then
				
		local pName = ""

		for count = 1, #GlobalIgnoreDB.ignoreList do
			
			if GlobalIgnoreDB.typeList[count] == "server" then
			
				if string.find(message, "-"..GlobalIgnoreDB.ignoreList[count], 1, true) ~= nil then
					return true
				end
			else
				if serverName == getServer(GlobalIgnoreDB.ignoreList[count]) then
					pName = removeServer(GlobalIgnoreDB.ignoreList[count])
				else
					pName = GlobalIgnoreDB.ignoreList[count]
				end
				

				local msgOffline = strDown(string.format(ERR_FRIEND_OFFLINE_S, pName))
				local msgOnline  = strDown(string.format(ERR_FRIEND_ONLINE_SS, pName, pName))

				message = strDown(message)
					
				if (message == msgOffline) or (message == msgOnline) then
					return true
				end
	  		end
	  	end
			
		return false

	elseif (from ~= nil) and (from ~= "") then
			
		local idx = string.find(from, "-", 1, true)
		
		if idx == nil then
			from = from .. "-" .. serverName
		else
			from = string.sub(from, 1, idx - 1) .. "-" .. Proper(string.sub(from, idx + 1, string.len(from)))		
		end
				
		if hasGlobalIgnored(from) > 0 or hasServerIgnored(getServer(from)) > 0 then			
			
			if event == "CHAT_MSG_WHISPER" then
				local temp = from .. math.ceil(GetTime() - 0.5)
				
				if (temp ~= lastSentIgnore) then
					SendChatMessage(L["MSG_1"], "WHISPER", nil, from)
					lastSentIgnore = temp
				end
			end

			return true
		else
		
			if GlobalIgnoreDB.spamFilter == true then
			
				if GlobalIgnoreDB.skipGuild == true and (event == "CHAT_MSG_GUILD" or event == "CHAT_MSG_OFFICER") then
					return false
				end
				
				if GlobalIgnoreDB.skipParty == true and (
					event == "CHAT_MSG_BATTLEGROUND" or
					event == "CHAT_MSG_BATTLEGROUND_LEADER" or
					event == "CHAT_MSG_INSTANCE_CHAT" or
					event == "CHAT_MSG_INSTANCE_CHAT_LEADER" or
					event == "CHAT_MSG_PARTY" or
					event == "CHAT_MSG_RAID" or 
					event == "CHAT_MSG_RAID_LEADER" or
					event == "CHAT_MSG_RAID_WARNING"					
				) then
					return false
				end
				
				if GlobalIgnoreDB.skipPrivate == true and event == "CHAT_MSG_WHISPER" then
					return false
				end
				
				if (event == "CHAT_MSG_ACHIEVEMENT") or (event == "CHAT_MSG_GUILD_ACHIEVEMENT") then			
					return false
				end
			
				if lastFilterMsg ~= message then
					lastFilterMsg = message
					
					message = string.lower(message)
					
					lastFilterResult, filterNum = filterComplex(nil, message, chnum)
				
					if lastFilterResult == true then
						
						if GlobalIgnoreDB.invertSpam == true then
							lastFilterResult = false
						else
						
							GlobalIgnoreDB.filterTotal	      = GlobalIgnoreDB.filterTotal + 1
							GlobalIgnoreDB.filterCount[filterNum] = GlobalIgnoreDB.filterCount[filterNum] + 1
						end
							
						return lastFilterResult
					end
				else
					return lastFilterResult
				end
				
				if GlobalIgnoreDB.invertSpam == true then
					GlobalIgnoreDB.filterTotal = GlobalIgnoreDB.filterTotal + 1
					
					return true
				end
				
			end
		end
	end		  	
	
	return false
end

local chatEvents = (
		{
		"CHANNEL_INVITE_REQUEST",
		"CHAT_MSG_ACHIEVEMENT",
		"CHAT_MSG_BATTLEGROUND",
		"CHAT_MSG_BATTLEGROUND_LEADER",
		"CHAT_MSG_CHANNEL",
		"CHAT_MSG_CHANNEL_JOIN",
		"CHAT_MSG_CHANNEL_LEAVE",
		"CHAT_MSG_EMOTE",
		"CHAT_MSG_GUILD",
		"CHAT_MSG_GUILD_ACHIEVEMENT",	
		"CHAT_MSG_INSTANCE_CHAT",
		"CHAT_MSG_INSTANCE_CHAT_LEADER",
		"CHAT_MSG_MONSTER_EMOTE",
		"CHAT_MSG_MONSTER_PARTY",
		"CHAT_MSG_MONSTER_SAY",
		"CHAT_MSG_MONSTER_WHISPER",
		"CHAT_MSG_MONSTER_YELL",
		"CHAT_MSG_OFFICER",
		"CHAT_MSG_PARTY",
		"CHAT_MSG_RAID",
		"CHAT_MSG_RAID_LEADER",
		"CHAT_MSG_RAID_WARNING",
		"CHAT_MSG_SAY",
		"CHAT_MSG_SYSTEM",
		"CHAT_MSG_TEXT_EMOTE",
		"CHAT_MSG_WHISPER",
		"CHAT_MSG_YELL"
		}
	)

for key, value in pairs (chatEvents) do
	ChatFrame_AddMessageEventFilter(value, chatMessageFilter)
end

-------------------
-- CHAT COMMANDS --
-------------------

function ignoreFromCmd (argStr)
	argStr = (trim(Proper(argStr)) or "")
		
	if argStr == "" then
		argStr, server =  UnitName("target")
					
		if server ~= nil then
			argStr = argStr .. "-"..server
		end
			
		if argStr == nil or not UnitPlayerControlled("target") then
			argStr = ""
		end
	end
		
	if argStr ~= "" then
		C_FriendList.AddIgnore (Proper(argStr))
	end
end

function SlashCmdList.GIGNORE (msg)

	msg = strDown(msg)
	
	local args   = {}
	local argStr = ""
	local count  = 1

	local str = GetWord(msg, count)
	
	while str ~= "" do
		
		table.insert(args, str)
		
		if count == 2 then
			argStr = str
		elseif count > 2 then
			argStr = argStr .. " ".. str
		end
		
		count = count + 1
		str   = GetWord(msg, count)
	end
	
	if args[1] == "test" then

	elseif args[1] == "clear" then
	
		if firstClear and args[2] ~= nil and args[2] == "confirm" then	
			ResetIgnoreDB()
			ShowMsg(L["CMD_2"])
			SyncIgnoreList(GlobalIgnoreDB.chatmsg == nil or GlobalIgnoreDB.chatmsg == false)
			firstClear = false
		else
			ShowMsg("|cffff0000" .. L["CMD_1"])
			firstClear = true
		end
		
	elseif args[1] == "defexpire" then
	
		if tonumber(args[2]) then
			GlobalIgnoreDB.defexpire = tonumber(args[2])
			
			ShowMsg (format(L["CMD_3"], GlobalIgnoreDB.defexpire, dayString(GlobalIgnoreDB.defexpire)))
		end
		
	elseif msg == "asknote true" or msg == "asknote on" then
	
		GlobalIgnoreDB.asknote = true
		ShowMsg (L["CMD_4"])

	elseif msg == "asknote false" or msg == "asknote off" then

		GlobalIgnoreDB.asknote = false
		ShowMsg (L["CMD_5"])
		
	elseif msg == "showmsg true" or msg == "showmsg on" then
	
		GlobalIgnoreDB.chatmsg = true
		ShowMsg (L["CMD_6"])

	elseif msg == "showmsg false" or msg == "showmsg off" then
	
		GlobalIgnoreDB.chatmsg = false	
		ShowMsg (L["CMD_7"])
	
	elseif msg == "sameserver true" or msg == "sameserver on" then
	
		GlobalIgnoreDB.sameserver = true
		ShowMsg(L["CMD_10"])

	elseif msg == "sameserver false" or msg == "sameserver off" then
	
		GlobalIgnoreDB.sameserver = false
		ShowMsg(L["CMD_11"])
		
	elseif args[1] == "list" then
	
		ShowIgnoreList(argStr)
		
	elseif (args[1] == "add" or args[1] == "ignore") then
	
		ignoreFromCmd(argStr)

	elseif (args[1] == "remove" or args[1] == "delete") and args[2] ~= nil and args[2] ~= "" then
	
		if tonumber(argStr) then
		
			local str = GlobalIgnoreDB.typeList[tonumber(argStr)]
			
			if str == "npc" then
				ShowMsg (format(L["CMD_12"], Proper(GlobalIgnoreDB.ignoreList[tonumber(argStr)], true)))
				RemoveFromList(tonumber(argStr))
				GILUpdateUI(true)
			else
				C_FriendList.DelIgnore(args[2], true)
			end
		else
			argStr = Proper(argStr, true)
			
			local npcIndex = hasNPCIgnored(argStr)
		
			if npcIndex > 0 then
				ShowMsg (format(L["CMD_12"], argStr))
				RemoveFromList(npcIndex)
				GILUpdateUI(true)
			else	
				C_FriendList.DelIgnore (args[2], true)
			end
		end
		
	elseif (args[1] == "server" or args[1] == "addserver") and args[2] ~= nil and args[2] ~= "" then

		AddOrDelServer(argStr)
		GILUpdateUI(true)

	elseif (args[1] == "npc" or args[1] == "addnpc") then
	
		AddOrDelNPC(argStr)
		GILUpdateUI(true)
		
	elseif args[1] == "expire" and args[2] ~= nil and args[2] ~= "" and tonumber(args[3]) then

		if tonumber(args[2]) then
			local index = tonumber(args[2])

			if (index > 0) and (index <= #GlobalIgnoreDB.ignoreList) then
			
				GlobalIgnoreDB.expList[index] = tonumber(args[3])
				ShowMsg(format(L["CMD_14"], GlobalIgnoreDB.ignoreList[index], tonumber(args[3])))
			end

		else
			local name        = Proper(addServer(args[2]))
			local playerIndex = hasGlobalIgnored(name)

			if playerIndex > 0 then
				GlobalIgnoreDB.expList[playerIndex] = tonumber(args[3])
				ShowMsg(format(L["CMD_14"], name, tonumber(args[3])))
			end
		end
		
	elseif args[1] == "gui" then	
	
		GUI()
		
	elseif args[1] == "sync" then
	
		SyncIgnoreList(false)
		
	elseif args[1] == "dellist" then
	
		for count = 1, #GlobalIgnoreDB.delList do
			print(GlobalIgnoreDB.delList[count])
		end
		
	elseif args[1] == "prune" then
	
		if args[2] == "confirm" and firstPrune == true then
		
			PruneIgnoreList(pruneDays, true)
			
			firstPrune = false
		elseif args[2] == nil or tonumber(args[2]) == nil then
		
			ShowMsg(L["CMD_15"])
		else
			if firstPrune == false then

				pruneDays = tonumber(args[2])
				
				ShowMsg(format(L["CMD_16"], pruneDays))
				ShowMsg(format(L["CMD_17"], PruneIgnoreList(pruneDays, false)))
				
				firstPrune = true
			end
		end

	else
		ShowMsg (L["HELP_1"])
		ShowMsg ("")
		ShowMsg ("  " .. L["HELP_2"])
		ShowMsg ("  " .. L["HELP_3"])
		ShowMsg ("  " .. L["HELP_4"])
		ShowMsg ("  " .. L["HELP_5"])
		ShowMsg ("  " .. L["HELP_6"])
		ShowMsg ("  " .. L["HELP_7"])
		ShowMsg ("  " .. L["HELP_8"])
		ShowMsg ("  " .. L["HELP_15"])
		ShowMsg ("  " .. L["HELP_16"])
		ShowMsg ("  " .. L["HELP_9"])
		ShowMsg ("")
		ShowMsg ("  " .. format(L["HELP_10"], OnOff(GlobalIgnoreDB.chatmsg)))
		ShowMsg ("  " .. format(L["HELP_11"], OnOff(GlobalIgnoreDB.sameserver)))
		ShowMsg ("  " .. format(L["HELP_12"], GlobalIgnoreDB.defexpire))
		ShowMsg ("  " .. format(L["HELP_13"], OnOff(GlobalIgnoreDB.asknote)))
		ShowMsg ("")
		ShowMsg (L["HELP_14"])
	end
end

-----------------------------
-- BLIZZARD FUNCTION HOOKS --
-----------------------------

BlizzardInviteUnit			= InviteUnit
BlizzardAddIgnore			= C_FriendList.AddIgnore
BlizzardDelIgnore			= C_FriendList.DelIgnore
BlizzardDelIgnoreByIndex	= C_FriendList.DelIgnoreByIndex
BlizzardAddOrDelIgnore		= C_FriendList.AddOrDelIgnore

StaticPopupDialogs["GIL_PARTYCONFIRM"] = {

	preferredIndex	= STATICPOPUPS_NUMDIALOGS,
	text			= L["BOX_7"],
	button1			= L["BOX_6"],
	button2			= L["BOX_5"],
	OnAccept		= 	function()
							BlizzardInviteUnit(partyNameUI)							
						end,
	whileDead		= true,
	hideOnEscape	= true,
}

StaticPopupDialogs["GIL_PARTYWARN"] = {

	preferredIndex	= STATICPOPUPS_NUMDIALOGS,
	text			= L["BOX_8"],
	button1			= L["BOX_6"],
	timeout         = 15,
	whileDead		= true,
	hideOnEscape	= true,
}

InviteUnit = function (name)

	name = Proper(name)
	
	if hasGlobalIgnored(addServer(name)) > 0 then
		partyNameUI = name
		
		StaticPopup_Show("GIL_PARTYCONFIRM", partyNameUI)
	else
		BlizzardInviteUnit(name)
	end
end

C_FriendList.AddIgnore = function(name, noNote)

	--print("DEBUG: Info sent to C_FriendList.AddIgnore name="..(name or "nil") .. " note="..(noNote or "nil"))
	
	if (not name or name == "") then

		name, server = UnitName("target")
					
		if server ~= nil then
			name = name .. "-"..server
		end
	end
	
	if (not name or name == "") then
		return
	end

	local note  = ""
	local space = string.find(name, " ")
	local days  = GlobalIgnoreDB.defexpire
	
	if space then
		note = string.sub(name, space + 1)
		name = string.sub(name, 0, space - 1)
		
		space = string.find(note, " ")
		
		if space then
			if tonumber(string.sub(note, 0, space - 1)) then
				days = tonumber(string.sub(note, 0, space - 1))
				note = string.sub(note, space + 1)
			end
		else
			if tonumber(note) then
				days = tonumber(note)
				note = ""
			end
		end
	end
	
	needSorted = true
	name	   = Proper(addServer(name))
	
	if removeServer(name, true) == UNKNOWN then return end
	
	if Proper(addServer(UnitName("player"))) ~= name then
	
		local index = hasGlobalIgnored(name)
	
		if index == 0 then
			AddToList(name, faction, note)
			
			if GlobalIgnoreDB.asknote == true and not noNote then
			
				nameUI = name				
				StaticPopup_Show("GIL_REASON", nameUI)			
			end
			
			ShowMsg(format(L["ADD_2"], name))
			
			if C_FriendList.GetNumIgnores() < maxIgnoreSize then
				BlizzardAddIgnore(removeServer(name))
			end
		else
			if hasIgnored(name) > 0 then
				ShowMsg(format(L["ADD_1"], name))
			end

			if C_FriendList.GetNumIgnores() < maxIgnoreSize then			
				BlizzardAddIgnore(removeServer(name))
			end
		end
		
		removeDeleted(name)
		
		indentUI = 0
		
		GILUpdateUI()
	else
		ShowMsg(L["ADD_3"])
	end	
end

C_FriendList.DelIgnoreByIndex = function (name)
	--print("DEBUG C_FriendList.DelIgnoreByIndex: "..(name or "nil"))
	C_FriendList.DelIgnore(name)
end

C_FriendList.DelIgnore = function(idxpos, isGIL)

	--print ("DEBUG C_FriendList.DelIgnore idx="..(idxpos or "nil"))

	local name = ""
	
	if isGIL then
		if tonumber(idxpos) ~= nil then
			name = GlobalIgnoreDB.ignoreList[tonumber(idxpos)]
			
			if name == nil then
				return
			end
		else
			name = idxpos
		end
	else
		if tonumber(idxpos) ~= nil then			
			name = C_FriendList.GetIgnoreName(idxpos)
		else
			name   = idxpos
			idxpos = hasIgnored(name)
		end
	end

	if (name == nil or name == "") then
		return
	end
	
	needSorted = true	
	name 	   = Proper(addServer(name))
	
--	if removeServer(name, true) ~= UNKNOWN then

		addDeleted(name)
	
		local index = hasGlobalIgnored(name)

		if index > 0 then
			ShowMsg(format(L["REM_1"], name))
		
			RemoveFromList(index)		
		
			name = removeServer(name)
		
			if hasIgnored(name) > 0 then
				BlizzardDelIgnore(name)
			else
				GILUpdateUI()
			end
		else
			BlizzardDelIgnore(idxpos)
		end
--	end
		
	indentUI = 0
end

C_FriendList.AddOrDelIgnore = function(name)
	
	--print ("DEBUG C_FriendList.AddOrDel called with: "..(name or "nil"))
	
	if (not name or name == "") then

		name, server = UnitName("target")
					
		if server ~= nil then
			name = name .. "-"..server
		end
	end
	
	local find = string.find
	local sub  = string.sub
	
	-- try to resolve server if there isn't one due to Blizzard bugs
	
	if not find(name, "-", nil, true) then
		local pServers = {}
		local pServer  = ""
		local tempName, count
		
		-- check group for a name
		
		if gotGroup == true then
			local prefix = IsInRaid() and "raid" or "party"

			for count = 1, GetNumGroupMembers() do	
				tempName = GetUnitName(prefix..count, true)
			
				if tempName then
					if removeServer(tempName, true) == name then
						pServer = Proper(getServer(tempName), "")
						--print ("DEBUG matched name: "..name)
						
						if pServer ~= "" then
							--print ("DEBUG adding possible server by group="..pServer)
							pServers[#pServers + 1] = pServer
						end
					end
				end
			end
		end
		
		-- check chat history for a name
		
		for count = 1, 20 do
			local frameName = "ChatFrame"..count
			
			if _G[frameName] then
				local msg, pos
			
				for c = 1, _G[frameName].historyBuffer:GetNumElements() do
					msg = _G[frameName].historyBuffer:GetEntryAtIndex(_G[frameName].historyBuffer:GetNumElements() - c + 1).message
					pos = find(msg, "|Hplayer:", 1, true)
					--t = string.gsub(msg, "|", "!")
				
					if pos then
						--print("RAW="..t);
						--tempName = sub(msg, pos + 9, find(msg, ":", pos + 10, true) - 1, true)
		                tempName = sub(msg, pos + 9, (find(msg, ":", pos + 9, true) or (find(msg, "|", pos + 10, true))) - 1)
						
						
						if removeServer(tempName, true) == name then
							--print ("DEBUG matched name: "..name)
							
							pServer = Proper(getServer(tempName), "")
						
							if pServer ~= "" then
								--print("DEBUG Adding possible server name by chat="..pServer)
								pServers[#pServers + 1] = pServer
							end
						end
					end
				end
			end
		end
		
		if pServer ~= "" then
			name = name .. "-" .. pServer
		end
		
		--print("FINAL="..pServer.. " name="..name)
		--ShowMsg (L["ADD_4"])
	end

	if (not name or name == "") then
		return
	end
	
	name = Proper(addServer(name))
	
	if removeServer(name, true) == UNKNOWN then return end

	local index = hasGlobalIgnored(name)

	if index == 0 then
		--print("DEBUG calling AddIgnore="..(name or "nil"))
		
		C_FriendList.AddIgnore(name)
	else
		C_FriendList.DelIgnore(index, true)
		--print("DEBUG calling DelIgnore="..(index or "nil"))
		
	end	
end

AddOrDelNPC = function (argStr)

	if tonumber(argStr) then
	
		local nIndex = tonumber(argStr)
		
		if (nIndex > 0) and (nIndex <= #GlobalIgnoreDB.ignoreList) and (GlobalIgnoreDB.typeList[nIndex] == "npc") then
				
			ShowMsg (format(L["CMD_12"], GlobalIgnoreDB.ignoreList[nIndex]))
			RemoveFromList(nIndex)
		end
	else
				
		argStr = (trim(Proper(argStr, true)) or "")
	
		if argStr == "" then
			argStr = Proper(UnitName("target"), true)
				
			if argStr == nil or UnitPlayerControlled("target") then
				argStr = ""
			end
		end
			
		if argStr ~= "" then

			local npcIndex = hasNPCIgnored(argStr)
		
			if npcIndex > 0 then
				local name = GlobalIgnoreDB.ignoreList[npcIndex]
			
				ShowMsg (format(L["CMD_12"], name))
				RemoveFromList(npcIndex)
			else
				ShowMsg (format(L["CMD_13"], argStr))
				AddToList(argStr, faction, "", "npc")
			end
		end
	end
end

AddOrDelServer = function (sName)

	if not sName then return end

	if tonumber(sName) then
	
		local sIndex = tonumber(sName)
		
		if (sIndex > 0) and (sIndex <= #GlobalIgnoreDB.ignoreList) and (GlobalIgnoreDB.typeList[sIndex] == "server") then
		
			ShowMsg(format(L["CMD_19"], GlobalIgnoreDB.ignoreList[sIndex]))
			RemoveFromList(sIndex)
		end
	
	else
	
		sName = Proper(sName)
		
		local sIndex = hasServerIgnored(sName)
		
		if sIndex > 0 then
		
			ShowMsg(format(L["CMD_19"], sName))
			RemoveFromList(sIndex)
	
		else
		
			ShowMsg(format(L["CMD_18"], sName))
			AddToList(sName, faction, "", "server")
		end
	end
end

-----------------------------
-- Global Ignore List Main --
-----------------------------

GILFRAME = CreateFrame("FRAME")

GILFRAME:RegisterEvent("PLAYER_ENTERING_WORLD")
GILFRAME:RegisterEvent("ADDON_LOADED")
GILFRAME:RegisterEvent("IGNORELIST_UPDATE")
GILFRAME:RegisterEvent("PARTY_INVITE_REQUEST")
GILFRAME:RegisterEvent("DUEL_REQUESTED")
GILFRAME:RegisterEvent("GROUP_ROSTER_UPDATE")

SLASH_GIGNORE1		= "/gignore"
SLASH_GIGNORE2		= "/gi"
SLASH_GIGNORE3		= "/gil"

GILFRAME:SetScript("OnEvent", EventHandler)

-------------
-- THE END --
-------------