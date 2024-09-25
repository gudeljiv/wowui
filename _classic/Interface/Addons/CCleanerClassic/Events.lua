------------------
-- Init Vars
------------------
local function InitVars()
	-- char variables...
	if CCLEANER_CLASSIC_ENABLED == nil then						CCLEANER_CLASSIC_ENABLED = true end
	if CCLEANER_CLASSIC_WHOLE_WORDS == nil then 				CCLEANER_CLASSIC_WHOLE_WORDS = true end
	if CCLEANER_CLASSIC_FILTER_FRIENDLY == nil then 			CCLEANER_CLASSIC_FILTER_FRIENDLY = false end
	if CCLEANER_CLASSIC_FILTER_SAY == nil then 					CCLEANER_CLASSIC_FILTER_SAY = false end
	if CCLEANER_CLASSIC_FILTER_YELL == nil then 				CCLEANER_CLASSIC_FILTER_YELL = false end
	if CCLEANER_CLASSIC_HCOLOR == nil then 						CCLEANER_CLASSIC_HCOLOR = "" end
	if type(CCLEANER_CLASSIC_REQUIRED) ~= "table" then 			CCLEANER_CLASSIC_REQUIRED = {} end
	if type(CCLEANER_CLASSIC_CHANNELS) ~= "table" then 			CCLEANER_CLASSIC_CHANNELS = {} end
	if type(CCLEANER_CLASSIC_CLEAN) ~= "table" then				CCLEANER_CLASSIC_CLEAN = {"anal", "rape"} end
	-- account variables...
	if CCLEANER_CLASSIC_ACCOUNT_ENABLED == nil then 			CCLEANER_CLASSIC_ACCOUNT_ENABLED = true end
	if CCLEANER_CLASSIC_ACCOUNT_WHOLE_WORDS == nil then 		CCLEANER_CLASSIC_ACCOUNT_WHOLE_WORDS = true end
	if CCLEANER_CLASSIC_ACCOUNT_FILTER_FRIENDLY == nil then 	CCLEANER_CLASSIC_ACCOUNT_FILTER_FRIENDLY = false end
	if CCLEANER_CLASSIC_ACCOUNT_FILTER_SAY == nil then 			CCLEANER_CLASSIC_ACCOUNT_FILTER_SAY = false end
	if CCLEANER_CLASSIC_ACCOUNT_FILTER_YELL == nil then 		CCLEANER_CLASSIC_ACCOUNT_FILTER_YELL = false end
	if CCLEANER_CLASSIC_ACCOUNT_HCOLOR == nil then 				CCLEANER_CLASSIC_ACCOUNT_HCOLOR = "" end
	if type(CCLEANER_CLASSIC_ACCOUNT_REQUIRED) ~= "table" then 	CCLEANER_CLASSIC_ACCOUNT_REQUIRED = {} end
	if type(CCLEANER_CLASSIC_ACCOUNT_CHANNELS) ~= "table" then 	CCLEANER_CLASSIC_ACCOUNT_CHANNELS = {} end
	if type(CCLEANER_CLASSIC_ACCOUNT_CLEAN) ~= "table" then 	CCLEANER_CLASSIC_ACCOUNT_CLEAN = {"anal", "rape"} end
end

------------------
-- Addons Frame Entry
------------------
local function CreateInterfaceOptionsEntry()
	local frame = CreateFrame("Frame", nil)
	frame.name = "ChatCleanerClassic";
	-- title text...
	local txt = frame:CreateFontString(nil, nil, "GameFontNormalLarge")
	txt:SetText(string.format("%s v%s", GetAddOnMetadata("CCleanerClassic", "Title"), GetAddOnMetadata("CCleanerClassic", "Version")));
	txt:SetJustifyH("LEFT");
	txt:SetJustifyV("TOP");
	txt:SetPoint("TOPLEFT", 16, -16);
	frame.titleTextField = txt;
	-- open button...
	local btn = CreateFrame("Button", nil, frame, "UIButtonTemplate");
	btn:SetText("Open Options");
	btn:SetWidth(125);
	btn:SetHeight(25);
	btn:SetPoint("TOPLEFT", frame.titleTextField, "BOTTOMLEFT", 0, -10);
	btn:SetScript("OnClick", function()
		InterfaceOptionsFrame_Show();
		HideUIPanel(GameMenuFrame);
		cccGUI:Show();
	end)
	-- slash command text...
	local txt = frame:CreateFontString(nil, nil, "GameFontHighlight");
	txt:SetText(string.format("/%s", GetAddOnMetadata("CCleanerClassic", "Title")));
	txt:SetNonSpaceWrap(true);
	txt:SetPoint("LEFT", btn, "RIGHT", 10, 0);	
	-- blizzard calls to add...
	if InterfaceOptions_AddCategory then
		InterfaceOptions_AddCategory(frame)
	else
		local category, layout = _G.Settings.RegisterCanvasLayoutCategory(frame, frame.name)
		_G.Settings.RegisterAddOnCategory(category)
	end
end

------------------
-- Friendly Check
------------------
local function IsFriendly(name, flag, _, guid)
	if not guid then return true end -- LocalDefense automated prints
	if not guid:find("^Player") then
		local msg = "CCC: Unexpected GUID requested by an addon: ".. guid
		print(msg)
		geterrorhandler()(msg)
		return true
	end
	local _, characterName = BNGetGameAccountInfoByGUID(guid)
	if characterName or IsGuildMember(guid) or C_FriendList.IsFriend(guid) or UnitInRaid(name) or UnitInParty(name) or flag == "GM" or flag == "DEV" then
		return true
	end
end

------------------
-- String Search Function
------------------
local function StringSearch(msgLower, kwLower, msgRaw)
	local found = false

	-- print ("CCC: msgLower=" .. msgLower .. " >>>> kwLower=" .. kwLower)
	-- special: check for ecncapsulating symbols that exist around the word (like <GUILD NAMES>)...
	local encapsulated_word = 
		(kwLower:sub(1, 1) == "<" or kwLower:sub(1, 1) == "{" or kwLower:sub(1, 1) == "[" or kwLower:sub(1, 1) == "(") and
		(kwLower:sub(-1)   == ">" or kwLower:sub(-1)   == "}" or kwLower:sub(-1)   == "]" or kwLower:sub(-1)   == ")")

	-- check for match...
	local left, right = 0, 0
	if CCLEANER_CLASSIC_WHOLE_WORDS == true then
		left, right = string.find(msgLower, "%f[%w_]" .. kwLower .. "%f[^%w_]")
	elseif CCLEANER_CLASSIC_WHOLE_WORDS == false or encapsulated_word then
		left, right = msgLower:find(kwLower, nil, true)
	end
	found = (left ~= nil and right ~= nil)

	-- rebuild string if found and highglighting...
	--[[
	if found and CCLEANER_CLASSIC_HCOLOR:find("^#%x%x%x%x%x%x$") ~= nil then
		local msgRawLeft =  msgRaw:sub(1, left - 1)
		local msgRawRight = msgRaw:sub(right + 1, msgRaw:len())
		local kwRaw =       msgRaw:sub(left, right)
		kwRaw = "|cff00ff00" .. kwRaw
		msgRaw = msgRawLeft .. kwRaw .. msgRawRight
		--print("StringSearch(): " .. msgRaw)
	end
	--]]

	return found, msgRaw
end

------------------
-- Startup + Set Filter
------------------
local cccEvents = CreateFrame("Frame")
cccEvents:RegisterEvent("ADDON_LOADED")
cccEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
local function EventHandler(self, event, sender, arg1, ...)
	-- addon loaded - start filtering now...
	if (event == "ADDON_LOADED") and (sender == "CCleanerClassic") then
		cccEvents:UnregisterEvent("ADDON_LOADED")
		
		InitVars()

		--main filtering function
		local prevLineId, remove = 0, nil
		local filter = function(_, event, msg, player, _, _, _, flag, chid, chnum, chname, _, lineId, guid)
			if lineId == prevLineId then
				return remove
			else
				-- print ("CCC: chname=" .. (chname or "nil") .. " >>>> chatMsg chnum=" .. (chnum or "nil"))
				-- print ("CCC: #CCLEANER_CLASSIC_CHANNELS=" .. #CCLEANER_CLASSIC_CHANNELS)
				-- print ("CCC: msg1=" .. msg)
				-- print ("CCC: event=" .. event .. " >>>> chid=" .. chid .. " >>>> chname=" .. chname)

				prevLineId, remove = lineId, nil
				local trimmedPlayer = Ambiguate(player, "none")
				local msgLower = msg:lower()
				local chanNameLower = chname:lower()

				-- return if disabled...
				if CCLEANER_CLASSIC_ENABLED == false then return end
				-- always show messages from actual player...
				if trimmedPlayer == UnitName("player") then return end
				-- validate channel and event...
				if event == "CHAT_MSG_CHANNEL" and type(chid) ~= "number" then return end
				if event == "CHAT_MSG_SAY"     and CCLEANER_CLASSIC_FILTER_SAY  == false then return end
				if event == "CHAT_MSG_YELL"    and CCLEANER_CLASSIC_FILTER_YELL == false then return end
				-- check if we're filtering friendlies
				if IsFriendly(trimmedPlayer, flag, lineId, guid) and CCLEANER_CLASSIC_FILTER_FRIENDLY == false then return end

				-- check for a say or yell...
				local channel_match = false
				if ((event == "CHAT_MSG_SAY"  	and CCLEANER_CLASSIC_FILTER_SAY  == true) or
					(event == "CHAT_MSG_YELL"   and CCLEANER_CLASSIC_FILTER_YELL == true) or 
					#CCLEANER_CLASSIC_CHANNELS == 0) then
					channel_match = true
				-- else proceed as a standard named channel...
				else
					for i=1, #CCLEANER_CLASSIC_CHANNELS do
						-- print ("CCC: CCLEANER_CLASSIC_CHANNELS[i]=" .. CCLEANER_CLASSIC_CHANNELS[i] .. " >>>> chanNameLower=" .. (chanNameLower or "nil"))
						if  chanNameLower and chanNameLower ~= '' and 
							chanNameLower == string.lower(CCLEANER_CLASSIC_CHANNELS[i]) then
							channel_match = true
							break
						end
					end
				end

				if channel_match == true then
					-- scan for required matches (filter if not found)...
					local req_match = false
					for i=1, #CCLEANER_CLASSIC_REQUIRED do 
						-- print ("CCC: lowMsg_req=" .. msgLower .. " >>>> CCLEANER_CLASSIC_REQUIRED[i]=" .. CCLEANER_CLASSIC_REQUIRED[i])
						req_match, msg = StringSearch(msgLower, string.lower(CCLEANER_CLASSIC_REQUIRED[i]), msg)
						if req_match then break end
					end

					-- scan for clean matches (filter if found)...
					if req_match == true or #CCLEANER_CLASSIC_REQUIRED == 0 then
						for i=1, #CCLEANER_CLASSIC_CLEAN do 
							-- print ("CCC: lowMsg2_clean=" .. msgLower .. " >>>> CCLEANER_CLASSIC_CLEAN[i]=" .. CCLEANER_CLASSIC_CLEAN[i])
							remove, msg = StringSearch(msgLower, string.lower(CCLEANER_CLASSIC_CLEAN[i]), msg)
							if remove then break end
						end
					else
						-- print ("CCC: msgLower reqs not met!")
						remove = true
					end

					-- logging...
					if remove == true then
						-- print ("CCC: FILTERED: " .. msg)
					end

					return remove
				end
			end
		end

		-- sub to chat events...
		ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)
	end

	-- show startup message when entering the world (need a delay)...
	if (event == "PLAYER_ENTERING_WORLD") then
		cccEvents:UnregisterEvent("PLAYER_ENTERING_WORLD")
		CreateInterfaceOptionsEntry();

		-- delay for the startup message...
		local message_delay = 0
		self:SetScript("OnUpdate", function(self, elapsed)
			message_delay = message_delay + elapsed
			if message_delay < 5 then return end
			self:SetScript("OnUpdate", nil)
			self:Hide()
		end)
		print(string.format(
			"|cff9999ff%s v%s: |cffffffffuse /%s to open the options panel.", 
				GetAddOnMetadata("CCleanerClassic", "Title"), 
				GetAddOnMetadata("CCleanerClassic", "Version"), 
				GetAddOnMetadata("CCleanerClassic", "Title")))
	end
end
cccEvents:SetScript("OnEvent", EventHandler)
