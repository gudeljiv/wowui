--[[
	* Copyright (c) 2019 by Antoine Desmarets.
	* Cixi of Remulos Oceanic / WoW Classic
	*
	* Puggle is distributed in the hope that it will be useful and entertaining,
	* but WITHOUT ANY WARRANTY
]]--


local puglocal_version = "2.7"  --change here, and in TOC
local puglocal_reqPrefix = "Puggle;"
local puglocal_dispFrequency = 5  -- display refresh every x seconds
local puglocal_whoFrequency = 10  -- seconds before allowing another /who
local puglocal_idleTimeout = 300	 --remove entries after x seconds

--local wholib		--library to process /who requests

local _G = getfenv(0)

local puglocal_users = {}
local puglocal_zones = {}
local puglocal_nbUsers = 0

local puglocal_frames = {} --frames created (to reuse them later)
local puglocal_groupframes = {} --frames created (to reuse them later)
local puglocal_playerframes = {} --frames created (to reuse them later)

local puglocal_dungeonNames = {}
-- Name defaults
puglocal_dungeonNames["VC"] = 	"The Deadmines"
puglocal_dungeonNames["WC"] = 	"Wailing Caverns"
puglocal_dungeonNames["RFC"] = 	"Ragefire Chasm"
puglocal_dungeonNames["SFK"] = 	"Shadowfang Keep"
puglocal_dungeonNames["STK"] = 	"The Stockade"
puglocal_dungeonNames["BFD"] = 	"Blackfathom Deeps"
puglocal_dungeonNames["GNO"] = 	"Gnomeregan"
puglocal_dungeonNames["RFK"] = 	"Razorfen Kraul"
puglocal_dungeonNames["SMG"] = 	"Scarlet Monastery: Graveyard"
puglocal_dungeonNames["SML"] = 	"Scarlet Monastery: Library"
puglocal_dungeonNames["SMA"] = 	"Scarlet Monastery: Armory"
puglocal_dungeonNames["SMC"] = 	"Scarlet Monastery: Cathedral"
puglocal_dungeonNames["RFD"] = 	"Razorfen Downs"
puglocal_dungeonNames["ULD"] = 	"Uldaman"
puglocal_dungeonNames["ZF"] = 	"Zul'Farrak"
puglocal_dungeonNames["MAR"] = 	"Maraudon"
puglocal_dungeonNames["ST"] = 	"The Sunken Temple"
puglocal_dungeonNames["BRD"] = 	"Blackrock Depths"
puglocal_dungeonNames["DME"] = 	"Dire Maul: East"
puglocal_dungeonNames["DMN"] = 	"Dire Maul: North"
puglocal_dungeonNames["DMW"] = 	"Dire Maul: West"
puglocal_dungeonNames["STL"] = 	"Stratholme: Live"
puglocal_dungeonNames["STU"] = 	"Stratholme: Undead"
puglocal_dungeonNames["SCH"] = 	"Scholomance"
puglocal_dungeonNames["LBRS"] = 	"Lower Blackrock Spire"
puglocal_dungeonNames["UBRS"] = 	"Upper Blackrock Spire"
puglocal_dungeonNames["ONY"] = 	"Onyxia's Lair"
puglocal_dungeonNames["MC"] = 	"Molten Core"
puglocal_dungeonNames["ZG"] = 	"Zul'Gurub"
puglocal_dungeonNames["AQ20"] = 	"Ruins of Ahn'Qiraj"
puglocal_dungeonNames["BWL"] = 	"Blackwing Lair"
puglocal_dungeonNames["AQ40"] = 	"Temple of Ahn'Qiraj"
puglocal_dungeonNames["NAX"] = 	"Naxxramas"
puglocal_dungeonNames["WSG"] = 	"Warsong Gulch"
puglocal_dungeonNames["AB"] = 	"Arathi Basin"
puglocal_dungeonNames["AV"] = 	"Alterac Valley"
puglocal_dungeonNames["MISC"] = 	"Miscellaneous"
puglocal_dungeonNames["UD1"] = 	"User Defined 1"
puglocal_dungeonNames["UD2"] = 	"User Defined 2"
puglocal_dungeonNames["UD3"] = 	"User Defined 3"


local puglocal_dungeonTags = {}
-- Search tags defaults
puglocal_dungeonTags["RFC"] = 	{ "rfc", "ragefire","chasm"} 
puglocal_dungeonTags["WC"] = 	{ "wc", "wailing", "caverns"} 
puglocal_dungeonTags["VC"] = 	{ "deadmines", "vc", "vancleef"} 
puglocal_dungeonTags["SFK"] = 	{ "sfk", "shadowfang"} 
puglocal_dungeonTags["STK"] = 	{ "stk", "stock", "stockade", "stockades"} 
puglocal_dungeonTags["BFD"] = 	{ "bfd", "blackfathom"} 
puglocal_dungeonTags["GNO"] =  	{"gnomer", "gno", "gnomeregan", "gnomeragan"} 
puglocal_dungeonTags["RFK"] = 	{"rfk", "kraul"} 
puglocal_dungeonTags["SMG"] = 	{"smgy", "smg", "gy", "graveyard"} 
puglocal_dungeonTags["SML"] = 	{"smlib", "sml", "lib", "library"} 
puglocal_dungeonTags["SMA"] = 	{"smarm", "sma", "arm", "armory", "herod", "armoury", "arms"} 
puglocal_dungeonTags["SMC"] =  	{"smcath", "smc", "cath", "cathedral" }
puglocal_dungeonTags["RFD"] = 	{"rfd", "downs"} 
puglocal_dungeonTags["ULD"] = 	{"uld", "ulda", "uldaman"} 
puglocal_dungeonTags["ZF"] = 	{"zf", "zul", "farrak", "zul'farrak", "zulfarrak", "zulfarak"} 
puglocal_dungeonTags["MAR"] = 	{"mar", "mara", "maraudon", "mauradon" } 
puglocal_dungeonTags["ST"] = 	{"st", "sunken", "Atal" } 
puglocal_dungeonTags["BRD"] = 	{"brd", "lava run", "emperor"}
puglocal_dungeonTags["DME"] =  	{"dme", "east", "puzilin", "dm:e"}
puglocal_dungeonTags["DMN"] = 	{"dmn", "north", "tribute", "dm:n"}
puglocal_dungeonTags["DMW"] = 	{"dmw", "west", "dm:w"}
puglocal_dungeonTags["STL"] = 	{"stratlive", "live", "strat"}
puglocal_dungeonTags["STU"] = 	{"stratUD", "undead", "ud"}
puglocal_dungeonTags["SCH"] = 	{"scholomance", "scholo"}
puglocal_dungeonTags["LBRS"] = 	{"lower", "lbrs", "lrbs"}
puglocal_dungeonTags["UBRS"] =  	{"upper", "ubrs", "urbs"}
puglocal_dungeonTags["ONY"] = 	{"onyxia", "ony"}
puglocal_dungeonTags["MC"] = 	{"molten", "core", "mc"}
puglocal_dungeonTags["ZG"] = 	{"zg", "gurub", "zul'gurub", "zulgurub"}
puglocal_dungeonTags["AQ20"] = 	{"ruins", "aq20"}
puglocal_dungeonTags["BWL"] = 	{"blackwing", "lair", "bwl"}
puglocal_dungeonTags["AQ40"] =  	{"temple", "aq40"}
puglocal_dungeonTags["NAX"] = 	{"naxxramas", "nax", "naxx"}
puglocal_dungeonTags["WSG"] = 	{"wsg", "warsong"}
puglocal_dungeonTags["AB"] = 	{"ab", "arathi", "basin"}
puglocal_dungeonTags["AV"] = 	{"av", "alterac", "valley"}
puglocal_dungeonTags["MISC"] = 	{} 
puglocal_dungeonTags["UD1"] = 	{} 
puglocal_dungeonTags["UD2"] = 	{} 
puglocal_dungeonTags["UD3"] = 	{} 

local puglocal_dungeons = {}
-- SortOrder, LvlRange Low, LvlRange High, LvlMin
puglocal_dungeons["RFC"] = 	{ 1, 	13, 	18, 	8	 }
puglocal_dungeons["WC"] = 	{ 2, 	17, 	24, 	10 }
puglocal_dungeons["VC"] = 	{ 3, 	17, 	26, 	10 }
puglocal_dungeons["SFK"] = 	{ 4,  	22, 	30, 	14 }
puglocal_dungeons["STK"] = 	{ 5,	24, 	32, 	15 }
puglocal_dungeons["BFD"] = 	{ 6, 	24, 	32, 	15 }
puglocal_dungeons["GNO"] = 	{ 7, 	29, 	38, 	19 }
puglocal_dungeons["RFK"] = 	{ 8, 	29, 	38, 	19 }
puglocal_dungeons["SMG"] = 	{ 9, 	34, 	45, 	21 }
puglocal_dungeons["SML"] = 	{ 10, 	36, 	45, 	21 }
puglocal_dungeons["SMA"] = 	{ 11, 	38, 	45, 	21 }
puglocal_dungeons["SMC"] = 	{ 12, 	40, 	45, 	21 }
puglocal_dungeons["RFD"] = 	{ 14,	37, 	46, 	25 }
puglocal_dungeons["ULD"] = 	{ 15, 	41, 	51, 	30 }
puglocal_dungeons["ZF"] = 	{ 16, 	42, 	46, 	35 }
puglocal_dungeons["MAR"] = 	{ 17, 	46, 	55, 	35 }
puglocal_dungeons["ST"] = 	{ 18, 	50, 	55, 	35 }
puglocal_dungeons["BRD"] = 	{ 19, 	52, 	60, 	40 }
puglocal_dungeons["DME"] = 	{ 20, 	55, 	60, 	45 }
puglocal_dungeons["DMN"] = 	{ 21, 	55, 	60, 	45 }
puglocal_dungeons["DMW"] = 	{ 22, 	55, 	60, 	45 }
puglocal_dungeons["STL"] = 	{ 23, 	58, 	60, 	45 }
puglocal_dungeons["STU"] = 	{ 24, 	58, 	60, 	45 }
puglocal_dungeons["SCH"] = 	{ 25, 	58, 	60, 	45 }
puglocal_dungeons["LBRS"] = 	{ 26, 	55, 	60, 	45 }
puglocal_dungeons["UBRS"] = 	{ 27, 	58, 	60, 	45 }
puglocal_dungeons["ONY"] = 	{ 28, 	60, 	60, 	50 }
puglocal_dungeons["MC"] = 	{ 29, 	60, 	60, 	58 }	
puglocal_dungeons["ZG"] = 	{ 30, 	60, 	60, 	60 }
puglocal_dungeons["AQ20"] = 	{ 31, 	60, 	60, 	60 }
puglocal_dungeons["BWL"] = 	{ 32, 	60, 	60, 	60 }
puglocal_dungeons["AQ40"] = 	{ 33, 	60, 	60, 	60 }
puglocal_dungeons["NAX"] = 	{ 34, 	60, 	60, 	60 }
puglocal_dungeons["WSG"] = 	{ 35, 	10, 	60, 	10 }
puglocal_dungeons["AB"] = 	{ 36, 	20, 	60, 	20 }
puglocal_dungeons["AV"] = 	{ 37, 	51, 	60, 	51 }
puglocal_dungeons["MISC"] = 	{ 38, 	1, 	60, 	1	 }
puglocal_dungeons["UD1"] = 	{ 39, 	1, 	60, 	1	 }
puglocal_dungeons["UD2"] = 	{ 40, 	1, 	60, 	1	 }
puglocal_dungeons["UD3"] = 	{ 41, 	1, 	60, 	1	 }

local puglocal_searchTags = { "lfg", "lfm", "lf1m", "lf2m", "lf3m", "lftank", "lfheals", "lfhealer", "lfdps" }
local puglocal_blacklistTags = { "" }

local puglocal_playerLevel = 1;

local puglocal_loadTime = 0	-- time addon loaded
local puglocal_dispTime = 0	-- time of last UI List display
local puglocal_whoTime = 0
local elapsed = 0
local puglocal_whoOk = true 	-- ok to run a /who

local puglocal_curGroupId = -1	--timestamp/id of the current group
local puglocal_lastGroupId = -1	--latest group id (default to show)
local puglocal_playerToon = -1	-- current toon being played
local puglocal_ratingPage = "groupMember"	-- prefix of the star object
local puglocal_sortPlayersBy = "race"
local puglocal_sortPlayersAsc = true
local puglocal_nbRelevant = 0
local puglocal_tabShown = 1	--tab currently being shown
local puglocal_ticker --ticker for onupdate

local puglocal_ldb = LibStub("LibDataBroker-1.1")
local Puggle_broker = nil

local Puggle_ratedList = {}

local hideNotifications = false  --used to 'disable' addon while in instances
-------------------------------------------------------------------------

function Puggle_OnLoad()

	Puggle_ContainerFrame:RegisterEvent("ADDON_LOADED");				--Initialisation
	Puggle_ContainerFrame:RegisterEvent("CHAT_MSG_CHANNEL");			--Get Puggle requests
	Puggle_ContainerFrame:RegisterEvent("CHAT_MSG_SYSTEM");				--To retrieve /who results		
	Puggle_ContainerFrame:RegisterEvent("CHAT_MSG_GUILD");				--To retrieve requests coming from the guild chat		
	Puggle_ContainerFrame:RegisterEvent("CHAT_MSG_PARTY");				--To retrieve guild/level through out the grouping		
	Puggle_ContainerFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER");		--To retrieve guild/level through out the grouping		
	Puggle_ContainerFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");		--Whenever someone joins/leaves group

	Puggle_ContainerFrame:RegisterEvent("GROUP_ROSTER_UPDATE")	
	Puggle_ContainerFrame:RegisterEvent("PLAYER_ENTERING_WORLD");			--To detect entrance into an instance
	Puggle_AdjustScrollSizes() -- in case default size were changed	

	Puggle_broker = puglocal_ldb:NewDataObject("Puggle_Broker", {
		type = "data source",
		label = "Puggle",
		text = ""..puglocal_nbRelevant, 
		icon = "Interface\\Icons\\spell_holy_prayerofspirit", 
		OnClick = function(self, button)
			if button=="LeftButton" then
				Puggle_MinimapButton_OnClick()
			elseif button=="RightButton" then
				Puggle_ToggleAllDungeons(true)
			end
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine("|cFFffffffPuggle v"..puglocal_version.."|r")
			tooltip:AddLine(" ")
			if puglocal_nbRelevant < 2 then tooltip:AddLine("|cFFffffff"..puglocal_nbRelevant.." relevant request|r") 
			else 	tooltip:AddLine("|cFFffffff"..puglocal_nbRelevant.." relevant requests|r") end
			tooltip:AddLine(" ")
			tooltip:AddLine("|cFFffff00Left Click|r    Open Puggle\n|cFFffff00Right Click|r  Toggle all requests", 0.2, 1, 0.2)
		end,
	})

end

-------------------------------------------------------------------------

function Puggle_OnEvent(event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg, arg9 = ...
	
	if event == "ADDON_LOADED" and arg1 == "Puggle" then
		DEFAULT_CHAT_FRAME:AddMessage("Puggle v."..puglocal_version.." by Cixi@Remulos. Type /puggle or /pug to get started,")
		DEFAULT_CHAT_FRAME:AddMessage("or use the minimap button to toggle the app.")
		puglocal_loadTime = time()
	
		if (Puggle_minimapPos == nil) then Puggle_minimapPos = 30; end
		if (Puggle_encoded== nil) then Puggle_encoded = false; end
--		if Puggle_windowHeight < 500 then Puggle_windowHeight = 500 end
		if (Puggle_showMinimapButton == nil) then Puggle_showMinimapButton = true; end
		if (Puggle_showMessageOnNewRequest == nil) then Puggle_showMessageOnNewRequest = false; end
		if (Puggle_playSoundOnNewRequest== nil) then Puggle_playSoundOnNewRequest = true; end
		if (Puggle_showLevelColorCoding== nil) then Puggle_showLevelColorCoding = true; end
		if (Puggle_showOnlyRelevant== nil) then Puggle_showOnlyRelevant = false; end
		if (Puggle_idleTimeout == nil) then Puggle_idleTimeout = puglocal_idleTimeout; end
		if (Puggle_sortLatestFirst== nil) then Puggle_sortLatestFirst = false; end
		if (Puggle_allowSendWho== nil) then Puggle_allowSendWho = true; end
		if (Puggle_trackGroups== nil) then Puggle_trackGroups = true; end
		if (Puggle_disableInInstance== nil) then Puggle_disableInInstance = true; end
				
		--check new install (all variables empty)
		if (Puggle_dungeonTags == nil) then Puggle_dungeonTags = puglocal_dungeonTags;	end
		if (Puggle_dungeonNames == nil) then Puggle_dungeonNames = puglocal_dungeonNames;	end
		if (Puggle_searchTags == nil) then Puggle_searchTags = puglocal_searchTags;	end
		if (Puggle_blacklistTags == nil) then Puggle_blacklistTags = puglocal_blacklistTags;	end
		if (Puggle_dungeonShow == nil) then 
			Puggle_dungeonShow = {} 
			for is, s in pairs(Puggle_dungeonNames) do Puggle_dungeonShow[is] = true;	end 
		end
		
		if (Puggle_pastGroups == nil) then Puggle_pastGroups = {};	end
		if (Puggle_pastPlayers == nil) then Puggle_pastPlayers = {};	end
		
		--check updates -- get all customised ones, and add new ones with defaults
		for is, s in pairs(puglocal_dungeonNames) do if Puggle_dungeonNames[is] == nil then Puggle_dungeonNames[is] = puglocal_dungeonNames[is]	end end
		for is, s in pairs(puglocal_dungeonTags) do 
			if Puggle_dungeonTags[is] == nil then Puggle_dungeonTags[is] = puglocal_dungeonTags[is]	end
			if Puggle_dungeonShow[is] == nil then Puggle_dungeonShow[is] = true	end 
		end


		maintitle:SetText("Puggle  v"..puglocal_version)
		myTabPage4_version:SetText("Version "..puglocal_version)
		_G["myTabPage4_showMinimapButtonText"]:SetText(myTabPage4_showMinimapButton:GetText())
		_G["myTabPage4_showMessageOnNewRequestText"]:SetText(myTabPage4_showMessageOnNewRequest:GetText())
		_G["myTabPage4_playSoundOnNewRequestText"]:SetText(myTabPage4_playSoundOnNewRequest:GetText())
		_G["myTabPage4_showLevelColorCodingText"]:SetText(myTabPage4_showLevelColorCoding:GetText())
		_G["myTabPage4_sortLatestFirstText"]:SetText(myTabPage4_sortLatestFirst:GetText())
		_G["myTabPage4_showOnlyRelevantText"]:SetText(myTabPage4_showOnlyRelevant:GetText())
		_G["myTabPage4_allowSendWhoText"]:SetText(myTabPage4_allowSendWho:GetText())
		_G["myTabPage4_trackGroupsText"]:SetText(myTabPage4_trackGroups:GetText())
		_G["myTabPage4_disableInInstanceText"]:SetText(myTabPage4_disableInInstance:GetText())

		myTabPage4_showMinimapButton:SetChecked(Puggle_showMinimapButton)
		myTabPage4_showMessageOnNewRequest:SetChecked(Puggle_showMessageOnNewRequest)
		myTabPage4_playSoundOnNewRequest:SetChecked(Puggle_playSoundOnNewRequest)
		myTabPage4_showLevelColorCoding:SetChecked(Puggle_showLevelColorCoding)
		myTabPage4_showOnlyRelevant:SetChecked(Puggle_showOnlyRelevant)
		myTabPage4_sortLatestFirst:SetChecked(Puggle_sortLatestFirst)
		myTabPage4_idleTimeout:SetText(Puggle_idleTimeout)
		myTabPage4_allowSendWho:SetChecked(Puggle_allowSendWho)
		myTabPage4_trackGroups:SetChecked(Puggle_trackGroups)
		myTabPage4_disableInInstance:SetChecked(Puggle_disableInInstance)

		myTabPage4_note:SetText("I hope this will help you get a group, while still keep the social element that was\nunfortunately lost with the LFG feature introduced in the later expansions.\n\nQuestions, suggestions, praise or rant can be sent to \124cffffd100\124hCixi@WarcraftRatings.com\124h\124r\nJust remember I did this addon as a fun little project, and am forcing nobody to use it :-)\n\nNo animal was harmed during the development of this addon.\nWell, apart from that kitten I punched while trying to get the scrollframe to work.\n\nSpecial thanks to \124cffffd100\124hKagerX\124h\124r, \124cffffd100\124hRiot\124r, \124cffffd100\124hItzachu\124h\124r, \124cffffd100\124hMauridius\124h\124r and \124cffffd100\124hThawe\124h\124r for their help and ideas.")
	
		puglocal_playerLevel = UnitLevel("player")


		--add potentially missing fields added in newer versions
		for ip, p in pairs(Puggle_pastPlayers) do
			if p.faction == nil then p.faction = UnitFactionGroup("player") end
			if p.realm == nil then p.realm = GetRealmName() end
		end
		for ig, g in pairs(Puggle_pastGroups) do
			if g.realm == nil then g.realm = GetRealmName() end
		end
		

		--convert to encoded if needed
		--not id / time / dur / player
		if not Puggle_encoded then
			for ip, p in pairs(Puggle_pastPlayers) do
				p.name = Puggle_enc(p.name)
				p.class = Puggle_enc(p.class)
				p.race = Puggle_enc(p.race)
				p.gender = Puggle_enc(""..p.gender)
				p.faction = Puggle_enc(p.faction)
				p.realm = Puggle_enc(p.realm)
			end

			for ig, g in pairs(Puggle_pastGroups) do
				g.cmt = Puggle_enc(g.cmt)
				g.realm = Puggle_enc(g.realm)
				g.loc = Puggle_enc(g.loc)
				for ip, p in pairs(g.party) do
					p.level = Puggle_enc(""..p.level)
					p.guild = Puggle_enc(p.guild)
					p.star = Puggle_enc(""..p.star)
					p.cmt = Puggle_enc(p.cmt)
				end	
			end
			Puggle_encoded = true
		end

		-- add the current toon being played to the list of past players
		for ip, p in pairs(Puggle_pastPlayers) do
			if p.name == Puggle_enc(UnitName("player")) then puglocal_playerToon = ip end
		end
		--add player to invariable meta if not found
		if puglocal_playerToon == -1 then
			puglocal_playerToon = Puggle_count(Puggle_pastPlayers)+1 --increment Id
			print("Puggle: Adding "..UnitName("player") .. " to Puggle data")
			_, classFile = UnitClass("player")
			_, raceFile = UnitRace("player")
			Puggle_pastPlayers[puglocal_playerToon] = {}
			Puggle_pastPlayers[puglocal_playerToon].name = Puggle_enc(UnitName("player"))
			Puggle_pastPlayers[puglocal_playerToon].class = Puggle_enc(classFile)
			Puggle_pastPlayers[puglocal_playerToon].race = Puggle_enc(raceFile)   --Scourge, Troll, etc
			Puggle_pastPlayers[puglocal_playerToon].gender = Puggle_enc("" .. UnitSex("player"))
			Puggle_pastPlayers[puglocal_playerToon].faction = Puggle_enc(UnitFactionGroup("player"))
			Puggle_pastPlayers[puglocal_playerToon].player = true
			Puggle_pastPlayers[puglocal_playerToon].realm = Puggle_enc(GetRealmName())
		end

		--pingTime = puglocal_loadTime
		Puggle_MinimapButton_Reposition()
		
		if Puggle_showMinimapButton then Puggle_MinimapButton:Show() else Puggle_MinimapButton:Hide() end
		Puggle_ShowEditTags()
		
		Puggle_loadGroups()
		Puggle_UpdateCurrentGroup() -- in case we are already in a group when we start
		Puggle_displayPlayers() -- to preload the list of past ratings

		--kick off the ticker
		Puggle_OnUpdate()
		puglocal_ticker = C_Timer.NewTicker(puglocal_dispFrequency, Puggle_OnUpdate )

	end

	
	if event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_GUILD" then
		Puggle_ProcessRandom(arg1, arg2)
	end


	if event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" then
		-- checking guild and level of party members when there's chat going on
		for i=1, 4 do 
			if UnitName("party"..i) ~= nil and UnitName("party"..i) ~= "Unknown" then 
				--check if we already got this player's invariable meta
				local pId = -1
				for ip, p in pairs(Puggle_pastPlayers) do
					if p.name == Puggle_enc(UnitName("party"..i)) then pId = ip end
				end

				if pId ~= -1 and puglocal_curGroupId ~= -1 then
		
					-- check where player is listed in group
					local pInd = -1  --check if doesn't already exist
					for ipp, pp in pairs(Puggle_pastGroups[puglocal_curGroupId].party) do
						if pp.id == pId then 
							pInd = ipp 
						end
					end

					if pInd ~= -1 then 
						--update level and guild as distance and leveling might prevent the right value
						Puggle_pastGroups[puglocal_curGroupId].party[pInd].level = Puggle_enc(""..UnitLevel("party"..i)) --this might change while in group
						local guildName = GetGuildInfo("party"..i)
						if guildName == nil then guildName = "" end
						if guildName ~= "" then Puggle_pastGroups[puglocal_curGroupId].party[pInd].guild = Puggle_enc(guildName)  end
					end
				end
			end
		end

	end
	
	if event == "CHAT_MSG_SYSTEM" then
		--only look at results from /who
		if string.find(arg1, " Level ") then
			Puggle_ExtractWho(arg1)
		end
	end
	
	if event == "GROUP_ROSTER_UPDATE" then
		Puggle_UpdateCurrentGroup()
	end
	
	
	if event == "ZONE_CHANGED_NEW_AREA" then
		--check if in instance
		inInstance, instanceType = IsInInstance()
		if instanceType ~= "none" then 
			if Puggle_disableInInstance then 
				hideNotifications = true
			end
		else 
			hideNotifications = false
		end

		Puggle_UpdateCurrentGroup()
	end
	

	if event == "PLAYER_ENTERING_WORLD" then
		--check if in instance
		inInstance, instanceType = IsInInstance()
		if instanceType ~= "none" then 
			if Puggle_disableInInstance then 
				hideNotifications = true
			end
		else 
			hideNotifications = false
		end

	end
	
end

-------------------------------------------------------------------------

function Puggle_ExtractWho(arg1) 
	arg1 = gsub(arg1, "Night Elf", "NightElf") --transform minus space
	t = Puggle_split(arg1, " ");
	local toon  = string.gsub(t[1], "|", "!")	-- unescape player link
	toon  = string.sub(toon, string.find(toon, "%[") +1, string.len(toon)) -- remove front
	toon  = string.sub(toon, 1, string.find(toon, "%]")-1 ) -- remove back
	
	--find the toons request and update his level/class
	for iu, u in pairs(puglocal_users) do
		--print(string.gsub(u, toon..":0:0:", toon..":"..t[3]..":"..string.upper(t[5])..":"))
		puglocal_users[iu] = string.gsub(u, toon..":0:0:", toon..":"..t[3]..":"..string.upper(t[5])..":"); 	
	end
	Puggle_UpdateList()
end

-------------------------------------------------------------------------

function Puggle_UpdateCurrentGroup()
	if Puggle_trackGroups then
		if GetNumGroupMembers() > 0 then
			--Check if really in a group.
			-- The event triggers even if nobody has acceptd an invite yet
			local inGroup = false
			--for i=1,GetNumGroupMembers() do
			for i=1, 4 do 
				if UnitName("party"..i) ~= nil and UnitName("party"..i) ~= "Unknown" then 
					inGroup = true 
				end
			end

			if inGroup then 
				--if we just joined that group, prepare the group meta
				if puglocal_curGroupId == -1 then 
					puglocal_curGroupId = time()

					Puggle_pastGroups[puglocal_curGroupId] = {}
					Puggle_pastGroups[puglocal_curGroupId].cmt = Puggle_enc("")
					Puggle_pastGroups[puglocal_curGroupId].loc = Puggle_enc(GetZoneText())
					Puggle_pastGroups[puglocal_curGroupId].realm = Puggle_enc(GetRealmName())
					Puggle_pastGroups[puglocal_curGroupId].party = {}
					Puggle_pastGroups[puglocal_curGroupId].exported = false

					puglocal_lastGroupId = puglocal_curGroupId --if entering a group, make it the new default shown
					Lib_UIDropDownMenu_SetText(_G["Puggle_DropDownGroups"], Puggle_dec(Puggle_pastPlayers[puglocal_playerToon].name) .. " - " .. date("%A %B %d, %Y at %H:%M", puglocal_lastGroupId) .. " - " .. Puggle_dec(Puggle_pastGroups[puglocal_lastGroupId].loc) )
				end
				
				-- add me to the group
				Puggle_pastGroups[puglocal_curGroupId].party[1] = {}
				Puggle_pastGroups[puglocal_curGroupId].party[1].id = puglocal_playerToon 
				Puggle_pastGroups[puglocal_curGroupId].party[1].level = Puggle_enc("" .. UnitLevel("player")) --this might change while in group
				Puggle_pastGroups[puglocal_curGroupId].party[1].guild = Puggle_enc("") -- and so might this
				local guildName = GetGuildInfo("player")
				if guildName ~= nil and guildName ~= "" then 
					Puggle_pastGroups[puglocal_curGroupId].party[1].guild = Puggle_enc(guildName) 
				end
				Puggle_pastGroups[puglocal_curGroupId].party[1].star = Puggle_enc("0")
				Puggle_pastGroups[puglocal_curGroupId].party[1].cmt = Puggle_enc("")
				Puggle_pastGroups[puglocal_curGroupId].party[1].time = puglocal_curGroupId
				Puggle_pastGroups[puglocal_curGroupId].party[1].dur = 0

				-- parse all players in group
				--for i=1,GetNumGroupMembers() do
				for i=1, 4 do 
					if UnitName("party"..i) ~= nil and UnitName("party"..i) ~= "Unknown" then 
						--check if we already got this player's invariable meta
						local pId = -1
						for ip, p in pairs(Puggle_pastPlayers) do
							if p.name == Puggle_enc(UnitName("party"..i)) then pId = ip end
						end
						--add player to invariable meta if not found
						if pId == -1 then
							pId = Puggle_count(Puggle_pastPlayers)+1 --increment Id
							print("Puggle: Adding "..UnitName("party"..i) .. " to Puggle data")
							_, classFile = UnitClass("party"..i)
							_, raceFile = UnitRace("party"..i)
							Puggle_pastPlayers[pId] = {}
							Puggle_pastPlayers[pId].name = Puggle_enc(UnitName("party"..i))
							Puggle_pastPlayers[pId].class = Puggle_enc(classFile)
							Puggle_pastPlayers[pId].race = Puggle_enc(raceFile)   --Scourge, Troll, etc
							Puggle_pastPlayers[pId].gender = Puggle_enc(""..UnitSex("party"..i))
							Puggle_pastPlayers[pId].faction = Puggle_enc(UnitFactionGroup("party"..i))
							Puggle_pastPlayers[pId].player = false
							Puggle_pastPlayers[pId].realm = Puggle_enc(GetRealmName())
						end
						
						-- check if player is already listed in group
						local pInd = -1  --check if doesn't already exist
						for ipp, pp in pairs(Puggle_pastGroups[puglocal_curGroupId].party) do
							if pp.id == pId then 
								pInd = ipp 
							end
						end

						if pInd == -1 then 
							--new player, add him to the party
							pInd = Puggle_count(Puggle_pastGroups[puglocal_curGroupId].party)+1 --increment Id, but check if doesn't already exist
							Puggle_pastGroups[puglocal_curGroupId].party[pInd] = {}
							Puggle_pastGroups[puglocal_curGroupId].party[pInd].star = Puggle_enc("0")
							Puggle_pastGroups[puglocal_curGroupId].party[pInd].cmt = Puggle_enc("")
							Puggle_pastGroups[puglocal_curGroupId].party[pInd].id = pId 
						end 

						Puggle_pastGroups[puglocal_curGroupId].party[pInd].level = Puggle_enc(""..UnitLevel("party"..i)) --this might change while in group
						if Puggle_pastGroups[puglocal_curGroupId].party[pInd].guild == nil then Puggle_pastGroups[puglocal_curGroupId].party[pInd].guild = Puggle_enc("") end
						local guildName = GetGuildInfo("party"..i)
						if guildName == nil then guildName = "" end
						if guildName ~= "" then Puggle_pastGroups[puglocal_curGroupId].party[pInd].guild = Puggle_enc(guildName) end
						if Puggle_pastGroups[puglocal_curGroupId].party[pInd].time == nil then Puggle_pastGroups[puglocal_curGroupId].party[pInd].time = puglocal_curGroupId end
						Puggle_pastGroups[puglocal_curGroupId].party[pInd].dur = time() - Puggle_pastGroups[puglocal_curGroupId].party[pInd].time
						
					end
				end

				

				--update location name if step into an instance
				--overwrite with Instance, rather than normal zone
				inInstance, instanceType = IsInInstance()
				if instanceType ~= "none" then 
					Puggle_pastGroups[puglocal_curGroupId].loc = Puggle_enc(GetZoneText())
					if puglocal_lastGroupId == puglocal_curGroupId then
						Lib_UIDropDownMenu_SetText(_G["Puggle_DropDownGroups"], Puggle_dec(Puggle_pastPlayers[puglocal_playerToon].name) .. " - " .. date("%A %B %d, %Y at %H:%M", puglocal_lastGroupId) .. " - " .. Puggle_dec(Puggle_pastGroups[puglocal_curGroupId].loc) )
					end
				end
		
				Puggle_pastGroups[puglocal_curGroupId].dur = time() - puglocal_curGroupId
				Puggle_displayGroup(puglocal_lastGroupId)
			end
		else 
			--not in a group 

			-- did we just leave one?
			if puglocal_curGroupId ~= -1 then 

				--close off group timer
				Puggle_pastGroups[puglocal_curGroupId].dur = time() - puglocal_curGroupId
				--close off group party timers
				for ip, p in pairs(Puggle_pastGroups[puglocal_curGroupId].party) do
					p.dur = time() - p.time
				end
				puglocal_lastGroupId = puglocal_curGroupId
				puglocal_curGroupId = -1  --group indicator reset
				Puggle_displayGroup(puglocal_lastGroupId)
				myTabPage2_delete:Enable()
			end
		end
	end
end

-------------------------------------------------------------------------

function Puggle_loadGroups() 


	if Puggle_pastGroups ~= nil and Puggle_count(Puggle_pastGroups) ~= 0 then 
		
		local realm = Puggle_enc(GetRealmName())

		--check if any of the same realm
		local found = false
		for ig, g in Puggle_spairs(Puggle_pastGroups, function(t,a,b) 	return a > b end) do
			if g.realm == realm then found = true end
		end

		if found then 
			Puggle_showMyGroupsInterface()

			local Puggle_dropDown = nil
			-- Create the dropdown, and configure its appearance
			--local Puggle_dropDown = _G["Puggle_DropDownGroups"]
			if _G["Puggle_DropDownGroups"] == nil then 
				Puggle_dropDown = CreateFrame("Frame", "Puggle_DropDownGroups", myTabPage2, "PuggleLib_UIDropDownMenuTemplate") 
				Puggle_dropDown:SetPoint("TOPLEFT", "$parent", "TOPLEFT",20, -59)
				Lib_UIDropDownMenu_SetWidth(Puggle_dropDown, 400)
			else 
				Puggle_dropDown = _G["Puggle_DropDownGroups"]
			end
			
			Puggle_dropDown:SetPoint("CENTER")
			Lib_UIDropDownMenu_SetWidth(Puggle_dropDown, 400)
			Lib_UIDropDownMenu_SetText(Puggle_dropDown, "Select a group event:")


			Lib_UIDropDownMenu_Initialize(Puggle_dropDown, function(self, level, menuList)
				local info = Lib_UIDropDownMenu_CreateInfo() 
				if (level or 1) == 1 then
					local prevDate = ""
					-- Display the day groups
					for ig, g in Puggle_spairs(Puggle_pastGroups, function(t,a,b) 	return a > b end) do
						if g.realm == realm then  
							local curDate = date("%A %B %d, %Y", ig)
							if curDate ~= prevDate then
								info.text = curDate
								if curDate == date("%A %B %d, %Y", puglocal_lastGroupId) then info.checked = true else info.checked = false end
								info.menuList = date("%A %B %d, %Y", ig)
								info.hasArrow = true
								Lib_UIDropDownMenu_AddButton(info, level)
								if puglocal_lastGroupId == -1 then
									puglocal_lastGroupId = ig 
									Lib_UIDropDownMenu_SetText(Puggle_dropDown, Puggle_dec(Puggle_pastPlayers[puglocal_playerToon].name) .. " - " .. date("%A %B %d, %Y at %H:%M", puglocal_lastGroupId) .. " - " .. Puggle_dec(Puggle_pastGroups[puglocal_lastGroupId].loc) )
								end
								Puggle_displayGroup(puglocal_lastGroupId)
								prevDate = curDate
							end
						end
					end

				else
					--nested group
					for ig, g in Puggle_spairs(Puggle_pastGroups, function(t,a,b) 	return a > b end) do
						if g.realm == realm then 
							local curDate = date("%A %B %d, %Y", ig)
							if curDate == menuList then 
								local me = ""
								for ip, p in pairs(g.party) do 
									if Puggle_pastPlayers[p.id].player then me = Puggle_dec(Puggle_pastPlayers[p.id].name) end 
								end
								info.text = me .. " - " .. date("%A %B %d, %Y at %H:%M", ig) .. " - " .. Puggle_dec(g.loc) 
								if ig == puglocal_lastGroupId then 
									info.checked = true 
									Lib_UIDropDownMenu_SetText(Puggle_dropDown, Puggle_dec(Puggle_pastPlayers[puglocal_playerToon].name) .. " - " .. date("%A %B %d, %Y at %H:%M", puglocal_lastGroupId) .. " - " .. Puggle_dec(Puggle_pastGroups[puglocal_lastGroupId].loc) )
								else 
									info.checked = false 
								end
								info.menuList = ig
								info.hasArrow = false
								info.arg1 = ig
								info.func = self.SetValue
								info.owner = frame
								Lib_UIDropDownMenu_AddButton(info, level)
							end
						end
					end

				end
	
			end)


			-- Implement the function to change the favoriteNumber
			function Puggle_dropDown:SetValue(newValue)
				puglocal_lastGroupId = newValue
				Lib_UIDropDownMenu_SetText(Puggle_dropDown, Puggle_dec(Puggle_pastPlayers[puglocal_playerToon].name) .. " - " .. date("%A %B %d, %Y at %H:%M", puglocal_lastGroupId) .. " - " .. Puggle_dec(Puggle_pastGroups[puglocal_lastGroupId].loc) )
				Puggle_displayGroup(puglocal_lastGroupId)
				Lib_CloseDropDownMenus()
			end
			
		else
		
			Puggle_hideMyGroupsInterface()
		end
	else
		
		Puggle_hideMyGroupsInterface()
	end
end

-------------------------------------------------------------------------

function Puggle_showMyGroupsInterface()
	myTabPage2_nobody:Hide()
	
	if myTabPage2_delete ~= nil then
		myTabPage2_delete:Show()
		myTabPage2_duration:Show()
		myTabPage2_groupComment:Show()
		myTabPage2_commentText:Show()
		myTabPage2_text1:Show()
		if Puggle_DropDownGroups ~= nil then Puggle_DropDownGroups:Show() end
		Puggle_ScrollFrameGroups:Show()
	end

end

-------------------------------------------------------------------------

function Puggle_hideMyGroupsInterface()

	if myTabPage2_delete ~= nil then
		myTabPage2_delete:Hide()
		myTabPage2_duration:Hide()
		myTabPage2_groupComment:Hide()
		myTabPage2_commentText:Hide()
		if Puggle_DropDownGroups ~= nil then Puggle_DropDownGroups:Hide() end
		Puggle_ScrollFrameGroups:Hide()
		myTabPage2_text1:Hide()

		myTabPage2_nobody:Show()
	end

end

-------------------------------------------------------------------------

function Puggle_displayGroup(groupId)
	
	if Puggle_pastGroups ~= nil and Puggle_count(Puggle_pastGroups) ~= 0 then 
		Puggle_showMyGroupsInterface()

		--Hiding all frames
		for i, f in pairs(puglocal_groupframes) do
			_G[f]:Hide()
		end

		local Puggle_yy = -10
		myTabPage2_duration:SetText("Duration: " .. Puggle_formatTime(Puggle_pastGroups[groupId].dur)) --duration
		myTabPage2_commentText:SetText(Puggle_dec(Puggle_pastGroups[groupId].cmt))
		for ip, p in pairs(Puggle_pastGroups[groupId].party) do
			-- let's find out if we need to create this groupframe or if we can reuse it
			local exist = false
			for _, f in ipairs(puglocal_groupframes) do if f == "pugglegroupMember-"..ip then exist = true end end
			
			if exist == false then 
				CreateFrame("Frame", "pugglegroupMember-"..ip, Puggle_ScrollChildFrameGroups, "Puggle_GroupMemberTemplate")
				table.insert(puglocal_groupframes, "pugglegroupMember-"..ip)
			
			end
			local member = Puggle_pastPlayers[p.id]
			_G["pugglegroupMember-"..ip.."_last"]:Hide()
			_G["pugglegroupMember-"..ip.."_level"]:SetText(Puggle_dec("" .. p.level))
			_G["pugglegroupMember-"..ip.."_name"]:SetText(Puggle_split(Puggle_dec(member.name), "-")[1])
			if p.guild ~= "" then _G["pugglegroupMember-"..ip.."_guild"]:SetText("< " .. Puggle_dec(p.guild) .. " >") else  _G["pugglegroupMember-"..ip.."_guild"]:SetText("") end
			_G["pugglegroupMember-"..ip.."_raceIcon"]:SetNormalTexture(Puggle_Icons(Puggle_dec(member.race), tonumber(Puggle_dec("" .. member.gender))));
			_G["pugglegroupMember-"..ip.."_classIcon"]:SetNormalTexture(Puggle_Icons(Puggle_dec(member.class), ''));
			if member.player then
				_G["pugglegroupMember-"..ip.."_star1"]:Hide()
				_G["pugglegroupMember-"..ip.."_star2"]:Hide()
				_G["pugglegroupMember-"..ip.."_star3"]:Hide()
				_G["pugglegroupMember-"..ip.."_star4"]:Hide()
				_G["pugglegroupMember-"..ip.."_star5"]:Hide()
				_G["pugglegroupMember-"..ip.."_comment"]:Hide()
			else 
				if p.star == nil then p.star = Puggle_enc("0") end
				Puggle_ShowStars(ip, tonumber(Puggle_dec(p.star)))
			end
			
			_G["pugglegroupMember-"..ip]:SetParent(Puggle_ScrollChildFrameGroups)
			_G["pugglegroupMember-"..ip]:SetPoint("TOPLEFT", Puggle_ScrollChildFrameGroups, "TOPLEFT", 40, Puggle_yy);			
			_G["pugglegroupMember-"..ip]:Show()
			Puggle_yy = Puggle_yy - 35

		end
		Puggle_ScrollChildFrameGroups:SetHeight(-Puggle_yy)
		Puggle_ScrollChildFrameGroups:SetWidth(676)	
		Puggle_ScrollFrameGroups:SetScrollChild(Puggle_ScrollChildFrameGroups)

	else
		Puggle_hideMyGroupsInterface()
	end 

end 

-------------------------------------------------------------------------

function Puggle_displayPlayers()

	Puggle_ratedList = {}
	local Puggle_realm = Puggle_enc(GetRealmName())
	for ip, p in pairs(Puggle_pastPlayers) do
		if p.player == false and p.realm == Puggle_realm then -- don't list myself, or toons from other realms

			--retrieve latest rating/level/guild
			--for ig, g in Puggle_spairs(Puggle_pastGroups, function(t,a,b) return b > a end) do
			local Puggle_maxLevel = 0
			local Puggle_maxTime = 0
			local Puggle_maxGuild = ""
			local Puggle_maxStar = 0
			local Puggle_maxFrom = 0
			--local max
			for ig, g in pairs(Puggle_pastGroups) do
				--dont get overwritten
				local from = 0
				for igp, gp in pairs(g.party) do
					if Puggle_pastPlayers[gp.id].player then from = gp.id end
					if gp.id == ip then
						if tonumber(Puggle_dec(gp.level)) > Puggle_maxLevel then Puggle_maxLevel = tonumber(Puggle_dec(gp.level)) end
						if ig > Puggle_maxTime then 
							Puggle_maxTime = ig 
							Puggle_maxGuild = Puggle_dec(gp.guild)
							Puggle_maxStar = tonumber(Puggle_dec(gp.star))
							if (from ~= 0) then Puggle_maxFrom = Puggle_dec(Puggle_pastPlayers[from].name) end
						end
					end
				end
			--	end
			end 
			if Puggle_maxGuild ~= "" then Puggle_maxGuild = "< " .. Puggle_maxGuild .. " >" end

			if Puggle_maxStar > 0 then 
				Puggle_ratedList[ip] = {}
				Puggle_ratedList[ip].name = Puggle_dec(p.name)
				Puggle_ratedList[ip].race = Puggle_dec(p.race)
				Puggle_ratedList[ip].class = Puggle_dec(p.class)
				Puggle_ratedList[ip].gender = tonumber(Puggle_dec(p.gender))
				Puggle_ratedList[ip].realm = Puggle_dec(p.realm)
				Puggle_ratedList[ip].faction = Puggle_dec(p.faction)
				Puggle_ratedList[ip].guild = Puggle_maxGuild
				Puggle_ratedList[ip].level = Puggle_maxLevel
				Puggle_ratedList[ip].last = Puggle_maxTime
				Puggle_ratedList[ip].star = Puggle_maxStar
				Puggle_ratedList[ip].from = Puggle_maxFrom
			end
		end
	end


	--Hiding all frame
	for i, f in pairs(puglocal_playerframes) do
		_G[f]:Hide()
	end

	local Puggle_yy = -10

	local puglocal_count = 0

	for ip, p in Puggle_spairs(Puggle_ratedList, function(t,a,b) 
			if (puglocal_sortPlayersAsc) then return t[b][puglocal_sortPlayersBy] > t[a][puglocal_sortPlayersBy]
			else 	return t[b][puglocal_sortPlayersBy] < t[a][puglocal_sortPlayersBy]
			end
		end) do

		-- don't list players with a level = 0, that means the groups they were in have been deleted
		if (p.level ~= 0) then 

			-- let's find out if we need to create this playerframe or if we can reuse it
			local exist = false
			for _, f in ipairs(puglocal_playerframes) do if f == "puggleplayer-"..ip then exist = true end end
				
			if exist == false then 
				CreateFrame("Frame", "puggleplayer-"..ip, Puggle_ScrollChildFramePlayers, "Puggle_GroupMemberTemplate")
				table.insert(puglocal_playerframes, "puggleplayer-"..ip)
			end
			
			_G["puggleplayer-"..ip.."_name"]:SetText(Puggle_split(p.name, "-")[1])
			_G["puggleplayer-"..ip.."_raceIcon"]:SetNormalTexture(Puggle_Icons(p.race, p.gender));
			_G["puggleplayer-"..ip.."_classIcon"]:SetNormalTexture(Puggle_Icons(p.class, ''));
			_G["puggleplayer-"..ip.."_comment"]:Hide()

			_G["puggleplayer-"..ip.."_level"]:SetText(p.level)
			_G["puggleplayer-"..ip.."_guild"]:SetText(p.guild) 
			_G["puggleplayer-"..ip.."_last"]:SetText(""..date("%d %b %y", p.last))
			_G["puggleplayer-"..ip.."_last"]:Show()
			
			Puggle_ShowStars(ip, p.star)

			_G["puggleplayer-"..ip]:SetParent(Puggle_ScrollChildFramePlayers)
			_G["puggleplayer-"..ip]:SetPoint("TOPLEFT", Puggle_ScrollChildFramePlayers, "TOPLEFT", 40, Puggle_yy);			
			_G["puggleplayer-"..ip]:Show()
			Puggle_yy = Puggle_yy - 35
			puglocal_count = puglocal_count + 1
		end
	end


	Puggle_ScrollChildFramePlayers:SetHeight(-Puggle_yy)
	Puggle_ScrollChildFramePlayers:SetWidth(676)	
	Puggle_ScrollFramePlayers:SetScrollChild(Puggle_ScrollChildFramePlayers)

	if puglocal_count > 0 then
		myTabPage3_nobody:Hide()
	end 
end 

-------------------------------------------------------------------------

function Puggle_ShowStars(pid, nb)
	for i = 1,5 do
		if _G["puggle" .. puglocal_ratingPage.."-"..pid.."_star"..i] ~= nil then 
			if i <= nb then 
				_G["puggle" .. puglocal_ratingPage.."-"..pid.."_star"..i]:SetNormalTexture("Interface\\AddOns\\Puggle\\Images\\star-on")
			else 
				_G["puggle" .. puglocal_ratingPage.."-"..pid.."_star"..i]:SetNormalTexture("Interface\\AddOns\\Puggle\\Images\\star-off")
			end
			_G["puggle" .. puglocal_ratingPage.."-"..pid.."_star"..i]:Show()
		end
	end
end

-------------------------------------------------------------------------

function Puggle_sortPlayersBy(sortField)
	if sortField == puglocal_sortPlayersBy then 
		puglocal_sortPlayersAsc = not puglocal_sortPlayersAsc 
	else 
		puglocal_sortPlayersBy = sortField
	end
	Puggle_displayPlayers()
end

-------------------------------------------------------------------------

function Puggle_rateHover(self, nb)
	if puglocal_ratingPage ~= "player" then
		local s = Puggle_split(self:GetName(), "_")  --remove "_star" from last bit
		local c = Puggle_split(s[1], "-")	--retrieve party id 
		local pid = tonumber(c[2])
		if nb == -1 then 
			nb = tonumber(Puggle_dec(Puggle_pastGroups[puglocal_lastGroupId].party[pid].star))
		end --restore saved value
		Puggle_ShowStars(pid, nb)
	end
end

-------------------------------------------------------------------------

function Puggle_ratePlayer(self, nb)
	if puglocal_ratingPage ~= "player" then
		local s = Puggle_split(self:GetName(), "_")  --remove "_star" from last bit
		local c = Puggle_split(s[1], "-")	--retrieve party id 
		local pid = tonumber(c[2])
		Puggle_rateHover(self, nb)

		print("Puggle: Giving " .. nb .. " stars to " .. Puggle_dec(Puggle_pastPlayers[Puggle_pastGroups[puglocal_lastGroupId].party[pid].id].name))
		Puggle_pastGroups[puglocal_lastGroupId].party[pid].star = Puggle_enc(""..nb)
	end
end

-------------------------------------------------------------------------

function Puggle_updateGroupComment(self)

	if (self:GetText() == nil) then 
		Puggle_pastGroups[puglocal_lastGroupId].cmt = Puggle_enc("")
	else 
		Puggle_pastGroups[puglocal_lastGroupId].cmt = Puggle_enc("" .. self:GetText())
	end
end

-------------------------------------------------------------------------

function Puggle_deleteGroup() 

	StaticPopupDialogs["CONFIRM_DELETE"] = {
		text = "Are you sure you want to delete this group?",
		button1 = "Yes",
		button2 = "No",
		OnAccept = function()
			Puggle_pastGroups[puglocal_lastGroupId] = nil
			puglocal_lastGroupId = -1
			Puggle_loadGroups() 
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show ("CONFIRM_DELETE")
end

-------------------------------------------------------------------------

function Puggle_addComment(self) 

	local s = Puggle_split(self:GetName(), "_")  --remove "_star" from last bit
	local c = Puggle_split(s[1], "-")	--retrieve party id 
	local pid = tonumber(c[2])
	local pInd = 0
	for ip, p in pairs(Puggle_pastGroups[puglocal_lastGroupId].party) do
		if ip == pid then pInd = p.id 	end
	end

	StaticPopupDialogs["ADD_COMMENT"] = {
		text = "Add a comment for " .. Puggle_dec(Puggle_pastPlayers[pInd].name),
		button1 = "Save",
		button2 = "Cancel",
		OnShow = function (self, data)
    		self.editBox:SetText("" .. Puggle_dec(Puggle_pastGroups[puglocal_lastGroupId].party[pid].cmt))
		end,
		OnAccept = function (self, data, data2)
    		local text = self.editBox:GetText()
    		Puggle_pastGroups[puglocal_lastGroupId].party[pid].cmt = Puggle_enc(""..text)
		end,
		timeout = 0,
		hasEditBox = true,
		editBoxWidth = 350,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show ("ADD_COMMENT")
end


-------------------------------------------------------------------------

function Puggle_addGroupComment(self) 

	StaticPopupDialogs["ADD_GROUP_COMMENT"] = {
		text = "Add a comment for this group",
		button1 = "Save",
		button2 = "Cancel",
		OnShow = function (self, data)
    		self.editBox:SetText("" .. Puggle_dec(Puggle_pastGroups[puglocal_lastGroupId].cmt))
		end,
		OnAccept = function (self, data, data2)
    		local text = self.editBox:GetText()
			Puggle_pastGroups[puglocal_lastGroupId].cmt = Puggle_enc(text)
			myTabPage2_commentText:SetText(text)
		end,
		maxLetters = 400,
		timeout = 0,
		hasEditBox = true,
		editBoxWidth = 350,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show ("ADD_GROUP_COMMENT")
end

-------------------------------------------------------------------------

function Puggle_exportGroupData(self)

	--refresh list
	Puggle_displayPlayers()
	
	local temp_myList = {}
	local realm = Puggle_enc(GetRealmName())
	for ip, p in pairs(Puggle_pastPlayers) do
		if p.player == true and p.realm == realm then -- only list my own toons from this realm
			temp_myList[ip] = {}
			temp_myList[ip].name = Puggle_dec(p.name)
			temp_myList[ip].race = Puggle_dec(p.race)
			temp_myList[ip].class = Puggle_dec(p.class)
			temp_myList[ip].gender = tonumber(Puggle_dec(p.gender))
			temp_myList[ip].realm = Puggle_dec(p.realm)
			temp_myList[ip].faction = Puggle_dec(p.faction)
		end 
	end
	local serme = Puggle_serialize(temp_myList)
	

	local ser = Puggle_serialize(Puggle_ratedList)
	ser = puglocal_version .. "##" .. serme .. "##" .. ser

	--reduce string 
	ser = ser:gsub('%[%"name%"%]', '["n"]');
	ser = ser:gsub('%[%"race%"%]', '["r"]');
	ser = ser:gsub('%[%"class%"%]', '["c"]');
	ser = ser:gsub('%[%"gender%"%]', '["g"]');
	ser = ser:gsub('%[%"guild%"%]', '["G"]');
	ser = ser:gsub('%[%"level%"%]', '["l"]');
	ser = ser:gsub('%[%"last%"%]', '["L"]');
	ser = ser:gsub('%[%"star%"%]', '["s"]');
	ser = ser:gsub('%[%"realm%"%]', '["R"]');
	ser = ser:gsub('%[%"faction%"%]', '["F"]');
	ser = ser:gsub('%[%"from%"%]', '["f"]');
	
--[[	ser = ser:gsub('%[%"party%"%]', '["p"]');
	ser = ser:gsub('%[%"cmt%"%]', '["m"]');
	ser = ser:gsub('%[%"time%"%]', '["t"]');
	ser = ser:gsub('%[%"dur%"%]', '["d"]');
	ser = ser:gsub('%[%"loc%"%]', '["L"]');
	ser = ser:gsub('%[%"party%"%]', '["p"]');
]]	
	local encoded = Puggle_enc(ser)
	
	StaticPopupDialogs["EXPORT_GROUP"] = {
		text = "Copy the text below, then upload it to\n\nhttp://warcraftratings.com/puggle/upload",
		button1 = "Done",
		OnShow = function (self, data)
			self.editBox:SetText(""..encoded)
			self.editBox:HighlightText()
		end,
		timeout = 0,
		hasEditBox = true,
		editBoxWidth = 350,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show ("EXPORT_GROUP")

end

-------------------------------------------------------------------------

function Puggle_serialize (o)
	local res = ""
	if type(o) == "number" then
	  res = res .. o
	elseif type(o) == "string" then
		res = res .. string.format("%q", o)
	elseif type(o) == "table" then
		res = res .. "{\n"
	  for k,v in pairs(o) do
		if type(k) == "number" then
			res = res .. "  [" .. k .. "] = "
		elseif type(k) == "string" then
			 res = res .. "  [\"" .. k .. "\"] = "
		end
		res = res .. Puggle_serialize(v)
		res = res .. ",\n"
	  end
	  res = res ..  "}"
	elseif type(o) == "boolean" then
		if o then res = res .. "true"
		else res = res .. "false" end
	else
	  error("cannot serialize a " .. type(o))
	end
	return res
  end

-------------------------------------------------------------------------

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- You will need this for encoding/decoding
-- encoding
function Puggle_enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

-------------------------------------------------------------------------
-- decoding
function Puggle_dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

-------------------------------------------------------------------------

function Puggle_SetStarSource(source)
	puglocal_ratingPage = source
	if puglocal_ratingPage == "groupMember" then 
		Puggle_UpdateCurrentGroup()
	else 
		Puggle_displayPlayers()
	end
end

-------------------------------------------------------------------------

function Puggle_UpdateList()
	
	Puggle_cleanRequests()
	puglocal_nbRelevant = 0

	--Hiding all frames
	for i, f in pairs(puglocal_frames) do
		_G[f]:Hide()
		--_G[f]:SetParent(nil)
		--	table.remove(puglocal_frames, i)
	end
	
	puglocal_zones = {}
	for iu, u in pairs(puglocal_users) do

		local chat = Puggle_split(u, ";")
		--local tag = chat[1]
	
		local player = Puggle_split(chat[2], ":")
		--local pRoles  = Puggle_split(chat[3], ":")
		local pSelected = Puggle_split(chat[4], ":")
		local pTime = chat[6]
		local pElapsed = time() - pTime	--request elapsed time
		
		--Add players to the right puglocal_zones
		for iz, z in pairs(pSelected) do
			local show = true
			if (puglocal_playerLevel < puglocal_dungeons[z][2] or puglocal_playerLevel > puglocal_dungeons[z][3]) and Puggle_showOnlyRelevant then show = false end
	
			if show then 
				-- only show if the user has selected that zone
				if Puggle_dungeonShow[z] then 
					if puglocal_zones[z] == nil then puglocal_zones[z] = {} end
					puglocal_zones[z][Puggle_count(puglocal_zones[z])+1] = u..";"..pElapsed
				end 
			end 
		end
	end
	
	
	local atLeastOneMisc = false
	
	table.sort(puglocal_zones)
	local str = ""
	local Puggle_yy = 0
	
	-- this uses an custom sorting function ordering by zone ascending
	puglocal_szones = Puggle_spairs(puglocal_zones, function(t,a,b) 
		return puglocal_dungeons[b][1] > puglocal_dungeons[a][1]
	end)
	
	
	for iz, z in puglocal_szones do
				
		local ft = nil
		
		-- let's find out if we need to create this tite frame or if we can reuse it
		local exist = false
		for _, f in ipairs(puglocal_frames) do if f == "puggletitle-"..iz then exist = true end end
		
		if exist == false then 
			CreateFrame("Frame", "puggletitle-"..iz, Puggle_ScrollChildFrame, "Puggle_TitleTemplate")
			table.insert(puglocal_frames, "puggletitle-"..iz)
		end
		
		local prefix = ""
		local suffix = ""

		-- color off those instances the player is not in the level bracket of
		if Puggle_showLevelColorCoding then   --check setting first
			if puglocal_playerLevel < puglocal_dungeons[iz][2] then 
				prefix = "|cffff4040"
				suffix = "|r"
			end
			if puglocal_playerLevel > puglocal_dungeons[iz][3] then 
				prefix = "|cff00ff00"
				suffix = "|r"
			end
		end
		
		if (iz ~= "MISC") then 
			_G["puggletitle-"..iz.."_title"]:SetText(prefix..Puggle_dungeonNames[iz].."  (levels "..puglocal_dungeons[iz][2].."-"..puglocal_dungeons[iz][3]..")"..suffix)
		else 
			_G["puggletitle-"..iz.."_title"]:SetText(prefix..Puggle_dungeonNames[iz]..suffix) -- Misc category doesn't need level range
		end
		_G["puggletitle-"..iz.."_title"]:SetPoint("TOPLEFT", Puggle_ScrollChildFrame, "TOPLEFT", 40, Puggle_yy);
		_G["puggletitle-"..iz]:Show()
		_G["puggletitle-"..iz]:SetParent(Puggle_ScrollChildFrame)
		Puggle_yy = Puggle_yy - 20
		
		-- custom sort to show players who have been waiting the most first.
		for is, s in Puggle_spairs(puglocal_zones[iz], function(t,a,b) 
				local chata = Puggle_split(t[a], ";")
				reqTimea = chata[6]
				local chatb = Puggle_split(t[b], ";")
				reqTimeb = chatb[6]
				--DEFAULT_CHAT_FRAME:AddMessage("Comparing " .. reqTimeb .. " with " .. reqTimea)	
				if Puggle_sortLatestFirst then return reqTimea > reqTimeb end
				return reqTimeb > reqTimea end) do

			local chat = Puggle_split(s, ";")
			local player = Puggle_split(chat[2], ":")
			local playername = Puggle_split(player[1], "-")[1]  --remove realm name
			local pRoles  = Puggle_split(chat[3], ":")
			local pTime = chat[6]
			local pElapsed = time() - pTime	--request elapsed time
			
			
			--depending on setting, might not show MISC request if not within 5levels of player
			--if not misc or no setting, then go through
			if (iz ~= "MISC") or (player[2] == "0") or (not Puggle_showOnlyRelevant) or (Puggle_showOnlyRelevant and (puglocal_playerLevel >= player[2] - 5 and puglocal_playerLevel <= player[2] +5)) then
				
				if iz=="MISC" then atLeastOneMisc = true end  --this is to know whether or not to show the MISC title, or to hide it later on
				puglocal_nbRelevant = puglocal_nbRelevant + 1
				local exist = false
				for _, f in ipairs(puglocal_frames) do if f == "puggletoon:"..iz..":"..is then exist = true end end
				if exist == false then 
					CreateFrame("Frame", "puggletoon:"..iz..":"..is, Puggle_ScrollChildFrame, "Puggle_CharTemplate") 
					table.insert(puglocal_frames, "puggletoon:"..iz..":"..is)
				end 
				_G["puggletoon:"..iz..":"..is]:SetParent(Puggle_ScrollChildFrame)
				if (player[4] == "0" or player[4] == nil) then 
					_G["puggletoon:"..iz..":"..is.."_name"]:SetText(""..playername)
				else 
					_G["puggletoon:"..iz..":"..is.."_name"]:SetText(""..playername .. "  (+" .. player[4] .. ")")
				end
				_G["puggletoon:"..iz..":"..is.."_msg"]:SetText(""..string.sub(chat[3], 1, 55))
				_G["puggletoon:"..iz..":"..is.."_level"]:SetText(""..player[2])
				_G["puggletoon:"..iz..":"..is.."_classIcon"]:SetNormalTexture(Puggle_Icons(player[3], ''));
					
				_G["puggletoon:"..iz..":"..is.."_time"]:SetText(""..Puggle_formatTime(pElapsed))
				if (UnitName("player") == player[1]) then 
					_G["puggletoon:"..iz..":"..is.."_whisper"]:Disable()
				else 
					_G["puggletoon:"..iz..":"..is.."_whisper"]:Enable()

				end 
				
				if player[2] ~= "0" then 	
					_G["puggletoon:"..iz..":"..is.."_requestWho"]:Hide() 
					_G["puggletoon:"..iz..":"..is.."_classIcon"]:Show() 
				else 
					_G["puggletoon:"..iz..":"..is.."_requestWho"]:Show() 
					if puglocal_whoOk then _G["puggletoon:"..iz..":"..is.."_requestWho"]:Enable() 
					else _G["puggletoon:"..iz..":"..is.."_requestWho"]:Disable() end
					_G["puggletoon:"..iz..":"..is.."_classIcon"]:Hide() 
				end
						
				_G["puggletoon:"..iz..":"..is]:SetPoint("TOPLEFT", Puggle_ScrollChildFrame, "TOPLEFT", 60, Puggle_yy);			
				_G["puggletoon:"..iz..":"..is]:Show()
			
				Puggle_yy = Puggle_yy - 25
			end
		end
		Puggle_yy = Puggle_yy - 15
	end
	
	
	-- check if we removed all MISC requests (because of level filter). If none left, remove title
	if not atLeastOneMisc then 
		if _G["puggletitle-MISC"] ~= nil then 
			_G["puggletitle-MISC"]:Hide()  -- call in protected mode as there might not be a MISC yet
			Puggle_yy = Puggle_yy + 20
		end
	end
	
	Puggle_ScrollChildFrame:SetHeight(-Puggle_yy)
	Puggle_ScrollChildFrame:SetWidth(676)	
	Puggle_ScrollFrame:SetScrollChild(Puggle_ScrollChildFrame)

	
		
	if (puglocal_nbRelevant == 0) then 
		myTabPage1_nobody:Show()
		myTabPage1_synopsis:SetText("Players have expressed interest in dungeons (some might be hidden by your settings):")
		
	else 
		myTabPage1_nobody:Hide()
			
		if puglocal_nbRelevant == 1 then myTabPage1_synopsis:SetText("1 player has expressed interest in a dungeon (might be hidden by your settings):")
		else myTabPage1_synopsis:SetText(puglocal_nbRelevant .. " players have expressed interest in dungeons (some might be hidden by your settings):")
		end
	end

	--update broker
	Puggle_broker.text = "" .. puglocal_nbRelevant
end 

-------------------------------------------------------------------------

function Puggle_SendWhisper(self)
	local s = Puggle_split(self:GetName(), ":")
	local c = Puggle_split(s[3], "_")	--remove "_invite" from last bit
	local ind = tonumber(c[1])
	local chat = Puggle_split(puglocal_zones[s[2]][ind], ";")
	local player = Puggle_split(chat[2], ":")

	ChatFrame_OpenChat("/w "..player[1].." ") --open whisper chat
end

-------------------------------------------------------------------------

function Puggle_ShowEditTags()

	CreateFrame("Frame", "puggletags_LFG", myTabPage5, "Puggle_EditTagsTemplate")
	_G["puggletags_LFG_instCode"]:SetText("LFG")
	_G["puggletags_LFG_instName"]:Hide()
	_G["puggletags_LFG_instName2"]:SetText("Looking for group")
	_G["puggletags_LFG_instName2"]:Show()
	_G["puggletags_LFG_pick"]:Hide()
	
	local allTags = "";
	for idt, dt in pairs(Puggle_searchTags) do
		allTags = allTags .. dt .. " "
	end
	_G["puggletags_LFG_instTags"]:SetText(allTags)
	
	_G["puggletags_LFG"]:SetPoint("TOPLEFT", myTabPage5, "TOPLEFT", 30, -150);			
	_G["puggletags_LFG"]:Show()


	CreateFrame("Frame", "puggletags_BL", myTabPage5, "Puggle_EditTagsTemplate")
	_G["puggletags_BL_instCode"]:SetText("BL")
	_G["puggletags_BL_instName"]:Hide()
	_G["puggletags_BL_instName2"]:SetText("Black list")
	_G["puggletags_BL_instName2"]:Show()
	_G["puggletags_BL_pick"]:Hide()
	
	local blTags = "";
	for idt, dt in pairs(Puggle_blacklistTags) do
		blTags = blTags .. dt .. " "
	end
	_G["puggletags_BL_instTags"]:SetText(blTags)
	
	_G["puggletags_BL"]:SetPoint("TOPLEFT", myTabPage5, "TOPLEFT", 30, -190);			
	_G["puggletags_BL"]:Show()




	local Puggle_yy = -10	
	--DEFAULT_CHAT_FRAME:AddMessage("Count of Players: "..Puggle_count(puglocal_users))	
	for id, d in Puggle_spairs(puglocal_dungeons, function(t,a,b) 
			return puglocal_dungeons[b][1] > puglocal_dungeons[a][1]
		end)
		do

		if id ~= "MISC"  then 
			CreateFrame("Frame", "puggletags_"..id, Puggle_ScrollChildFrameEditTags, "Puggle_EditTagsTemplate")

			_G["puggletags_"..id.."_instCode"]:SetText(id)
			if Puggle_dungeonNames[id] == nil then 
				_G["puggletags_"..id.."_instName"]:SetText(puglocal_dungeonNames[id])
				_G["puggletags_"..id.."_pick"]:SetChecked(true)
			else 
				_G["puggletags_"..id.."_instName"]:SetText(Puggle_dungeonNames[id])
				_G["puggletags_"..id.."_pick"]:SetChecked(Puggle_dungeonShow[id])
			end
			_G["puggletags_"..id.."_pickText"]:SetText("Show")
			
	
			
			if Puggle_dungeonTags[id] ~= nil then --safeguarding for newer (empty) dungeons
				allTags = "";
				for idt, dt in pairs(Puggle_dungeonTags[id]) do
					allTags = allTags .. dt .. " "
				end	
				_G["puggletags_"..id.."_instTags"]:SetText(allTags)
				
				_G["puggletags_"..id]:SetPoint("TOPLEFT", Puggle_ScrollChildFrameEditTags, "TOPLEFT", 40, Puggle_yy);			
				_G["puggletags_"..id]:Show()
			end		
			Puggle_yy = Puggle_yy - 40
		end 
	end

	CreateFrame("Frame", "puggletags_MISC", Puggle_ScrollChildFrameEditTags, "Puggle_EditTagsTemplate")

	_G["puggletags_MISC_instCode"]:SetText("MISC")
	_G["puggletags_MISC_instName2"]:Hide()
	_G["puggletags_MISC_instTags"]:Hide()
	if Puggle_dungeonNames["MISC"] == nil then 
		_G["puggletags_MISC_instName"]:SetText(puglocal_dungeonNames["MISC"])
	else
		_G["puggletags_MISC_instName"]:SetText(Puggle_dungeonNames["MISC"])
	end
	_G["puggletags_MISC_instName"]:SetText("Miscellaneous")
	_G["puggletags_MISC_pick"]:SetChecked(Puggle_dungeonShow["MISC"])
	_G["puggletags_MISC"]:SetPoint("TOPLEFT", Puggle_ScrollChildFrameEditTags, "TOPLEFT", 40, Puggle_yy);			
	_G["puggletags_MISC"]:Show()
	
	Puggle_yy = Puggle_yy - 40
	
	Puggle_ScrollChildFrameEditTags:SetHeight(-Puggle_yy)
	Puggle_ScrollChildFrameEditTags:SetWidth(676)	
	Puggle_ScrollFrameEditTags:SetScrollChild(Puggle_ScrollChildFrameEditTags)

end 

-------------------------------------------------------------------------

function Puggle_ValidateInstName(self) 

	local code = Puggle_split(self:GetName() , "_")[2]
	
	if (self:GetText() == nil) then 
		Puggle_dungeonNames[code] = puglocal_dungeonNames[code]
	else 
		if (self:GetText() == "") then 
			Puggle_dungeonNames[code] = puglocal_dungeonNames[code]
			_G["puggletags_"..code.."_instName"]:SetText(Puggle_dungeonNames[code])
			print("Puggle: Resetting dungeon name for "..code.. " to its default")
		else
			Puggle_dungeonNames[code] = self:GetText()
		end
	end
end 

-------------------------------------------------------------------------

function Puggle_TogglePickInstance(self) 

	local code = Puggle_split(self:GetName() , "_")[2]
	Puggle_dungeonShow[code] = self:GetChecked();
end 

-------------------------------------------------------------------------

function Puggle_ToggleAllDungeons(notify)
	local tog = not Puggle_dungeonShow['RFC']
	
	for id, d in pairs(Puggle_dungeonShow) do
		--if id ~= "MISC" then 
			Puggle_dungeonShow[id] = tog
			_G["puggletags_"..id.."_pick"]:SetChecked(tog)
		--end
	end

	if notify then 
		if tog then print("Puggle: Listening to ALL dungeon requests")
		else print("Puggle: Listening to NO dungeon requests")
		end
	end
	Puggle_UpdateList()
end

-------------------------------------------------------------------------

function Puggle_ValidateInstTags(self) 

	local code = Puggle_split(self:GetName() , "_")[2]
	local search = false;
	local blacklist = false;
	if code == "LFG" then search = true end
	if code == "BL" then blacklist = true end
	
	if (self:GetText() == nil) then 
		if search then Puggle_searchTags = puglocal_searchTags
		else if blacklist then Puggle_blacklistTags = puglocal_blacklistTags			
		else Puggle_dungeonTags[code] = puglocal_dungeonTags[code] end end
	else 
		if (self:GetText() == "") then 
			if search then 
				Puggle_searchTags = puglocal_searchTags
				local allTags = "";
				for idt, dt in pairs(Puggle_searchTags) do allTags = allTags .. dt .. " "	end

				_G["puggletags_LFG_instTags"]:SetText(allTags)
				print("Puggle: Resetting search tags to their defaults")	
			else 
				if blacklist then 
					Puggle_blacklistTags = puglocal_blacklistTags
					local allTags = "";
					for idt, dt in pairs(Puggle_blacklistTags) do allTags = allTags .. dt .. " "	end
	
					_G["puggletags_BL_instTags"]:SetText(allTags)
					print("Puggle: Resetting blacklist tags to their defaults")	
				else
					Puggle_dungeonTags[code] = puglocal_dungeonTags[code] 
					local allTags = "";
					for idt, dt in pairs(Puggle_dungeonTags[code]) do allTags = allTags .. dt .. " "	end

					_G["puggletags_"..code.."_instTags"]:SetText(allTags)
					print("Puggle: Resetting tags for "..code.. " to their defaults")
				end 
			end
		else
			if search then Puggle_searchTags = Puggle_split(self:GetText(), " ")
			else if blacklist then Puggle_blacklistTags = Puggle_split(self:GetText(), " ")
			else Puggle_dungeonTags[code] = Puggle_split(self:GetText(), " ") end end
		end
	end

end 

-------------------------------------------------------------------------

function Puggle_formatTime(sec) 
	local str = ""

	if sec ~= nil then 
		local minutes, hours
		if (sec<60) then 
			str = ""..sec.."sec"
		else
			minutes = math.floor(sec/60)
			sec = sec - (minutes*60)
			if (minutes<60) then 
				str =  ""..minutes.."min"
			else 
				hours = math.floor(minutes/60)
				minutes = minutes - (hours*60)
				str = ""..hours.."h"
				if (minutes > 0) then str = str .. " "..minutes.."min" end
			end
			if (sec > 0) then str = str .. " "..sec.."sec" end
		end
	else 
		str = ""
	end
	return str
end

-------------------------------------------------------------------------

function Puggle_ProcessRandom(req, sender) 
	--DEFAULT_CHAT_FRAME:AddMessage("" .. sender .. " : " .. req)
	
	local playername = Puggle_split(sender, "-")[1]
	
	local newUser = true
	local newInst = true
	local userDetails = ""
	local existingReq = -1
	local existingStart = 0
	
	req = string.gsub(req, ";", "%.");		--remove semicolons as they break the string
	local sel = Puggle_ExtractDungeon(string.lower(req))

	--if request is valid, proceed
	if next(sel) ~= nil then
	
		for is, s in pairs(sel) do

			--check if user is already listed
			if (Puggle_count(puglocal_users)==0) then
				--no one there, add it
				newUser = true
				newInst = true
			else
				for iu, u in pairs(puglocal_users) do
					local chat = Puggle_split(u, ";")
					local user = Puggle_split(chat[2], ":")
					local inst = chat[4];
					
					if (playername == user[1]) then
						-- already there, exists
						newUser = false
						userDetails = chat[2]
						if inst == s then
							newInst = false
							existingReq = iu
							existingStart = chat[5]
							break
						end 
					else
						-- new user, add
						newUser = true
						newInst = true
					end
				end
			end
			
			if  (newUser) then 
				puglocal_users[puglocal_nbUsers] = puglocal_reqPrefix..playername..":0:0:0;"..req..";" .. s .. ";"..time()..";"..time() --adding a timestamp of last ping
				puglocal_nbUsers = puglocal_nbUsers + 1		

				if Puggle_dungeonShow[s] then 
					if (puglocal_playerLevel >= puglocal_dungeons[s][2] and puglocal_playerLevel <= puglocal_dungeons[s][3]) or Puggle_showOnlyRelevant == false then 
						if Puggle_showMessageOnNewRequest and not hideNotifications then DEFAULT_CHAT_FRAME:AddMessage("New Puggle request by " .. playername .. " for " .. Puggle_dungeonNames[s]) end 
						if Puggle_playSoundOnNewRequest and not hideNotifications then   PlaySoundFile("sound/interface/pickup/putdownring.ogg") end
					end
				end
			
			else 
				--player reapplyin LFG. can be same instance or an new one
				if newInst then
					-- add new request, but no need to get the /who details. retrieve from earlier request
					puglocal_users[puglocal_nbUsers] = puglocal_reqPrefix..userDetails..";"..req..";" .. s .. ";"..time()..";"..time() -- new request
					puglocal_nbUsers = puglocal_nbUsers + 1		

					if Puggle_dungeonShow[s] then 
						if (puglocal_playerLevel >= puglocal_dungeons[s][2] and puglocal_playerLevel <= puglocal_dungeons[s][3]) or Puggle_showOnlyRelevant == false then 
							if Puggle_showMessageOnNewRequest and not hideNotifications then DEFAULT_CHAT_FRAME:AddMessage("New Puggle request by " .. playername .. " for " .. Puggle_dungeonNames[s]) end 
							if Puggle_playSoundOnNewRequest and not hideNotifications then   PlaySoundFile("sound/interface/pickup/putdownring.ogg") end				
						end
					end
				else 
					-- refresh timeer and message on current request
					puglocal_users[existingReq] = puglocal_reqPrefix..userDetails..";"..req..";" .. s .. ";"..existingStart..";"..time() --refreshing timestamp of last ping
				end
			
			end
		end
		
		Puggle_UpdateList()  --refresh displayed list
	end	
end

-------------------------------------------------------------------------

function Puggle_requestWho(whofor) 
	if puglocal_whoOk then 
		puglocal_whoOk = false
		puglocal_whoTime = time()
		Puggle_UpdateList()

		if Puggle_allowSendWho then 
			DEFAULT_CHAT_FRAME.editBox:SetText("/who " .. "x-".. whofor) 
			ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0) 
		else
			ChatFrame_OpenChat("/who " .. "x-".. whofor) --open whisper chat
		end
	end
end 

-------------------------------------------------------------------------

function Puggle_requestWhoClicked(self) 

	local s = Puggle_split(self:GetName(), ":")
	local c = Puggle_split(s[3], "_")	
	local ind = tonumber(c[1])
	local chat = Puggle_split(puglocal_zones[s[2]][ind], ";")
	local player = Puggle_split(chat[2], ":")
	Puggle_requestWho(player[1]) 
	
end

-------------------------------------------------------------------------

function Puggle_ExtractDungeon(req) 
	
	local sel = {}
	
	req = string.gsub(req, " ", "_");
	req = string.gsub(req, "%.", "_");
	req = string.gsub(req, ",", "_");
	req = string.gsub(req, "%/", "_");
	req = string.gsub(req, "'", "_");
	req = string.gsub(req, "?", "_");
	req = string.gsub(req, "!", "_");

	--remove double spaces(_) as ti was preventing some requests in 2.6
	--for example "lfg    rfc" was failing
    while string.find(req, "__") do
		req = string.gsub(req, "__", "_");
    end

	local parts = Puggle_split(req, "_")
	
	local valid = false;
	local blacklisted = false;
	-- Three pass request parsing. check blacklist tags, then lfg tags,  then dungeon tags
		
	-- First check if it contains any black listed tags
	for il, l in pairs(Puggle_blacklistTags) do --check all BL tags
		for ip, p in pairs(parts) do
			if (p == l) then 
				blacklisted = true -- contains blacklist tag
				break
			end
		end
	end
	

	if not blacklisted then 
		-- Then check that this is an actual request for group
		for il, l in pairs(Puggle_searchTags) do --check all LFG tags
			for ip, p in pairs(parts) do
				if (p == l) then 
					valid = true
					break
				end
			end
		end
		
		if valid then 
			-- Then identify what instance it is for, or throw in a Misc/Other bucket	 if can't understand it (99)
			for id, d in pairs(puglocal_dungeons) do --check all dungeons
			--	for is, s in pairs(d[7]) do --check all acronyms
				for is, s in pairs(Puggle_dungeonTags[id]) do --check all acronyms
					for ip, p in pairs(parts) do
						if (p == s) then 
							local found = false
							--check the dungeon isn't already in the selection (prevent dupes like "lfg wailing caverns") 
							for iss, ss in pairs(sel) do --check selection
								if ss == id then found = true end
							end
							if not found then table.insert(sel, id) end
						end
					end
				end	
			end
			if next(sel) == nil then table.insert(sel, "MISC") end 
			
		end
	end

	return sel
end 

-------------------------------------------------------------------------

function Puggle_Icons(what, gender) 
	local icon = "Interface/Icons/inv_misc_questionmark"
	if (what == "DRUID") 	then icon = "Interface\\Icons\\inv_misc_monsterclaw_04" end
	if (what == "HUNTER") 	then icon = "Interface\\Icons\\inv_weapon_bow_07" end
	if (what == "MAGE") 	then icon = "Interface\\Icons\\inv_staff_13" end
	if (what == "PALADIN") then icon = "Interface\\AddOns\\Puggle\\Images\\class_paladin" end
	if (what == "PRIEST") 	then icon = "Interface\\AddOns\\Puggle\\Images\\class_priest" 	end
	if (what == "ROGUE") 	then icon = "Interface\\AddOns\\Puggle\\Images\\class_rogue" end
	if (what == "SHAMAN") 	then icon = "Interface\\Icons\\spell_nature_bloodlust" end
	if (what == "WARLOCK") then icon = "Interface\\Icons\\spell_nature_drowsy" end
	if (what == "WARRIOR") then icon = "Interface\\Icons\\inv_sword_27" end

	local g = 'male'
	if gender == 3 then g = 'female' end
	if (what == "Dwarf") then icon = "Interface\\AddOns\\Puggle\\Images\\achievement_character_dwarf_"..g end
	if (what == "Gnome") then icon = "Interface\\AddOns\\Puggle\\Images\\achievement_character_gnome_"..g end
	if (what == "Human") then icon = "Interface\\AddOns\\Puggle\\Images\\achievement_character_human_"..g end
	if (what == "NightElf") then icon = "Interface\\AddOns\\Puggle\\Images\\achievement_character_nightelf_"..g end
	if (what == "Orc") then icon = "Interface\\AddOns\\Puggle\\Images\\achievement_character_orc_"..g end
	if (what == "Tauren") then icon = "Interface\\AddOns\\Puggle\\Images\\achievement_character_tauren_"..g end
	if (what == "Troll") then icon = "Interface\\AddOns\\Puggle\\Images\\achievement_character_troll_"..g end
	if (what == "Scourge") then icon = "Interface\\AddOns\\Puggle\\Images\\achievement_character_undead_"..g end
	return icon
end 

-------------------------------------------------------------------------

--function Puggle_OnUpdate(self, elapsed)
function Puggle_OnUpdate()
	--DEFAULT_CHAT_FRAME:AddMessage("Puggle_OnUpdate");
	local dispElapsed = time() - puglocal_dispTime
	local whoElapsed = time() - puglocal_whoTime

	if (whoElapsed >= puglocal_whoFrequency) and not puglocal_whoOk then 
		puglocal_whoOk = true
		Puggle_UpdateList()
	end 


	if (dispElapsed >= puglocal_dispFrequency) then 
		puglocal_playerLevel = UnitLevel("player")  -- refresh player level in case they ding'd
		puglocal_dispTime = time()
		Puggle_UpdateList()
		if puglocal_ratingPage == "groupMember" and puglocal_curGroupId ~= -1 then 
		--	Puggle_UpdateCurrentGroup()  --comment that as it prevent typing of
			if puglocal_curGroupId == puglocal_lastGroupId then -- only refresh the time instead
				Puggle_pastGroups[puglocal_curGroupId].dur = time() - puglocal_curGroupId
				myTabPage2_duration:SetText("Ongoing: " .. Puggle_formatTime(Puggle_pastGroups[puglocal_curGroupId].dur)) --duration
			end
		end

	end 
end

-------------------------------------------------------------------------

function Puggle_cleanRequests() 
		
		local toKeep = {}
		local nbToKeep = 0
	
		--Keeping only users that are still pinging, discard others
		for iu, u in pairs(puglocal_users) do
			local remove = false
			local chat = Puggle_split(u, ";")
			local player = Puggle_split(chat[2], ":")
			local reqTime = chat[6]
	
			local reqElapsed = time() - reqTime
		
			--random req, remove after 5min
			if (reqElapsed > tonumber(Puggle_idleTimeout)) then remove = true end
		
			if (not remove) then 
				--DEFAULT_CHAT_FRAME:AddMessage("Keeping ".. player[1] .. "/" .. u)
				toKeep[nbToKeep] = u
				nbToKeep = nbToKeep + 1
			end
		end

		puglocal_users = toKeep
end

-------------------------------------------------------------------------

function Puggle_split(str, sep)
	local t = {}
	local ind = string.find(str, sep)
	while (ind ~= nil) do 	
		table.insert(t, string.sub(str, 1, ind-1))
		str = string.sub(str, ind+1)
		ind = string.find(str, sep, 1, true)
	end
	if (str ~="") then table.insert(t, str) end
	return t
end

-------------------------------------------------------------------------

function Puggle_count(tab)
	puglocal_count = 0
	for Index, Value in pairs(tab) do
		--DEFAULT_CHAT_FRAME:AddMessage("parsing: " .. Index)
		puglocal_count = puglocal_count + 1
	end
	--DEFAULT_CHAT_FRAME:AddMessage("Return: " .. puglocal_count)
	return puglocal_count
	
end

-------------------------------------------------------------------------

function Puggle_spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[Puggle_count(keys)+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-------------------------------------------------------------------------

function Puggle_stringify(tbl, sep)
	local res
	for k, v in pairs(tbl) do
		res = res .. v .. sep
	end
	res = string.sub(res, 1, string.len(sub)-1)
	return res
end

-------------------------------------------------------------------------

function Puggle_ShowResizeMessage(show)

	if show then 
		Puggle_ShowTab(-1)
		Puggle_Resizing:Show()
	else 
		Puggle_Resizing:Hide()
		Puggle_ShowTab(puglocal_tabShown)
	end
end

-------------------------------------------------------------------------

function Puggle_ShowTab(tab)

	for t = 1, 5 do
		_G["myTabPage" .. t]:Hide()
	end
	if tab ~= -1 then
		 puglocal_tabShown = tab
		_G["myTabPage" .. puglocal_tabShown]:Show()
	end 
end 

-------------------------------------------------------------------------

function Puggle_AdjustScrollSizes() 
	local newHeight = Puggle_ContainerFrame:GetHeight()
	Puggle_ScrollFrameEditTags:SetHeight(newHeight -245)
	Puggle_ScrollFrame:SetHeight(newHeight - 80)
	Puggle_ScrollFrameGroups:SetHeight(newHeight - 285)
	Puggle_ScrollFramePlayers:SetHeight(newHeight - 100)
	Puggle_ScrollFrameEditTags:Show()
end

-------------------------------------------------------------------------

-- Call this in a mod's initialization to move the minimap button to its saved position (also used in its movement)
-- ** do not call from the mod's OnLoad, VARIABLES_LOADED or later is fine. **
function Puggle_MinimapButton_Reposition()
	Puggle_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(Puggle_minimapPos)),(80*sin(Puggle_minimapPos))-52)
end

-- Only while the button is dragged this is called every frame
function Puggle_MinimapButton_DraggingFrame_OnUpdate()

	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70 -- get coordinates as differences from the center of the minimap
	ypos = ypos/UIParent:GetScale()-ymin-70

	Puggle_minimapPos = math.deg(math.atan2(ypos,xpos)) -- save the degrees we are relative to the minimap center
	Puggle_MinimapButton_Reposition() -- move the button
end

-------------------------------------------------------------------------

-- Put your code that you want on a minimap button click here.  arg1="LeftButton", "RightButton", etc
function Puggle_MinimapButton_OnClick()
	if (Puggle_ContainerFrame:IsShown()) then 
		Puggle_ContainerFrame:Hide()
	else
		Puggle_ContainerFrame:Show()
		Puggle_ShowTab(1)
	end
end

-------------------------------------------------------------------------

-- normal tooltip for options
function Puggle_ShowTooltip(self)
	local s = Puggle_split(self:GetName(), ":")
	local c = Puggle_split(s[3], "_")	--remove "_invite" from last bit
	local ind = tonumber(c[1])
	local chat = Puggle_split(puglocal_zones[s[2]][ind], ";")
	local player = Puggle_split(chat[2], ":")
	local req = chat[3]
	pname = Puggle_split(player[1], "-")[1]

	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 26, -72	)
	GameTooltip:AddLine(pname)
	GameTooltip:AddLine(req,.8,.8,.8,1)
	GameTooltip:AddLine(" ",.8,.8,.8,1)
	GameTooltip:AddLine("Player in the queue for ".. Puggle_formatTime(time()-chat[5]),1,1,1,1)
	GameTooltip:AddLine("Last request "..Puggle_formatTime(time()-chat[6]).." ago",.6,.6,.6,1)

	if Puggle_ratedList ~= nil then
		for ip, p in pairs(Puggle_ratedList) do
			if (p.name == pname and p.realm == GetRealmName()) then
				GameTooltip:AddLine(" ",.8,.8,.8,1)
				GameTooltip:AddLine("Rated " .. p.star .. " stars on " .. date("%b %d", p.last),1,1,1,1)
				GameTooltip:AddTexture("Interface\\AddOns\\Puggle\\Images\\star-on_" .. p.star)
			end
		end
	end
	GameTooltip:Show()

end 

-------------------------------------------------------------------------

function Puggle_ToggleSound()
	Puggle_playSoundOnNewRequest = not Puggle_playSoundOnNewRequest
	myTabPage4_playSoundOnNewRequest:SetChecked(Puggle_playSoundOnNewRequest)
	if Puggle_playSoundOnNewRequest then print("Puggle: Notification sound ON") else print("Puggle: Notification sound OFF") end
end

-------------------------------------------------------------------------

function Puggle_SlashCommandHandler( msg )
	local args = Puggle_split(msg, " ")
		
	if args[1] == "sound" then 
		Puggle_ToggleSound()
	else 
		Puggle_MinimapButton_OnClick()
	end
	
end

-------------------------------------------------------------------------

SlashCmdList["Puggle"] = Puggle_SlashCommandHandler
SLASH_Puggle1 = "/puggle"
SLASH_Puggle2 = "/pug"
