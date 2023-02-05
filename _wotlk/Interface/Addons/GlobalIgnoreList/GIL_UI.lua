---------------------------------------
-- GLOBAL IGNORE LIST USER INTERFACE --
---------------------------------------

-- first : X... - is move left
-- second: Y... - is move down

local _, L					= ...

needSorted					= true
nameUI						= ""

local MainFrame				= nil
local Tab1Frame				= nil
local Tab2Frame				= nil
local Tab2FrameEdit			= nil
local Tab2EditState			= false
local Tab2EditDesc			= ""
local Tab2EditFilter		= ""
local Tab2EditActive		= false
local Tab3Frame				= nil
local columnCount			= 0
local IgnoreScrollFrame		= nil
local IgnoreScrollButtons	= {}
local IgnoreScrollIndex		= {}
local IgnoreScrollType		= 0
local IgnoreScrollSelect	= 0
local FilterScrollFrame		= nil
local FilterScrollButtons	= {}
local FilterScrollSelect	= 0
local WINDOW_WIDTH			= 734
local WINDOW_HEIGHT			= 400
local WINDOW_OFFSET			= 113
local BUTTON_HEIGHT			= 20
local BUTTON_TOTAL			= math.floor((WINDOW_HEIGHT - WINDOW_OFFSET) / BUTTON_HEIGHT)
local BUTTON_WIDTH			= WINDOW_WIDTH - 44
local COL_NAME				= 130
local COL_SERVER			= 150
local COL_TYPE				= 60
local COL_LISTED			= 53
local COL_EXPIRE			= 56
local COL_NOTES				= 241
local COL_DESC				= 210
local COL_STATE				= 30
local COL_FILTER			= 430
local COL_INFOTEXT			= 400

-------------------------
-- DIALOGS AND BUTTONS --
-------------------------

StaticPopupDialogs["GIL_REASON"] = {

	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text           = "Edit ignore note for |cffffff00%s:",
	maxLetters     = 128,
	hasEditBox	   = 1,
	whileDead      = 1,
	button1        = L["BOX_3"],
	button2        = L["BOX_5"],
  
	OnShow = function(self)
		self.editBox:SetText(GlobalIgnoreDB.notes[hasAnyIgnored(nameUI)])
		self.editBox:SetFocus()
	end,
	OnAccept = function(self)
		GlobalIgnoreDB.notes[hasAnyIgnored(nameUI)] = self.editBox:GetText()
		IgnoreList_Update()
	end,
	EditBoxOnEnterPressed = function(self)
		GlobalIgnoreDB.notes[hasAnyIgnored(nameUI)] = self:GetParent().editBox:GetText()
		IgnoreList_Update()
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end
}

local function setExpire (text)

	if tonumber(text) then
		GlobalIgnoreDB.expList[hasAnyIgnored(nameUI)] = tonumber(text)	
		IgnoreList_Update()
	end	
end

StaticPopupDialogs["GIL_EXPIRE"] = {

	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text           = "|cffffff00%s|cffffffff\n\n"..L["BOX_1"],
	maxLetters     = 4,
	hasEditBox	   = 1,
	whileDead      = 1,
	button1        = L["BOX_3"],
	button2        = L["BOX_5"],
  
	OnShow         = function(self)
		self.editBox:SetText(GlobalIgnoreDB.expList[hasAnyIgnored(nameUI)])
		self.editBox:SetFocus()
	end,
	OnAccept       = function(self)
		setExpire(self.editBox:GetText())
	end,
	EditBoxOnEnterPressed = function(self)
		setExpire(self:GetParent().editBox:GetText())
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end
}

StaticPopupDialogs["GIL_RESETFILTER"] = {

	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text           = "|cffffff00%s|cffffffff\n\n"..L["BOX_2"],
	whileDead      = 1,
	button1        = L["BOX_4"],
	button2        = L["BOX_5"],
	OnAccept       = function(self)
		ResetSpamFilters()
		FilterListDrawUpdate(FilterScrollFrame)
	end,	
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end
}

StaticPopupDialogs["GIL_REMOVEFILTER"] = {

	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text           = "|cffffff00%s|cffffffff\n\n"..L["BOX_9"],
	whileDead      = 1,
	button1        = L["BOX_10"],
	button2        = L["BOX_5"],
	OnAccept       = function(self)
		if FilterScrollSelect <= 0 then
			return
		end
			
		table.remove(GlobalIgnoreDB.filterList,   FilterScrollSelect)
		table.remove(GlobalIgnoreDB.filterDesc,   FilterScrollSelect)
		table.remove(GlobalIgnoreDB.filterCount,  FilterScrollSelect)
		table.remove(GlobalIgnoreDB.filterActive, FilterScrollSelect)
			
		FilterListDrawUpdate(FilterScrollFrame)		
	end,	
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end
}

local function ButtonIgnoreRemove()
	
	if IgnoreScrollSelect <= 0 then
		return
	end
	
	local idx     = IgnoreScrollIndex[IgnoreScrollSelect]
	local typeStr = GlobalIgnoreDB.typeList[idx]

	needSorted = true

	--print("DEBUG ButtonIgnoreRemove")
	
	if typeStr == "player" then
		C_FriendList.DelIgnore(idx, true)
	elseif typeStr == "npc" then
		AddOrDelNPC(idx)
		GILUpdateUI()
	elseif typeStr == "server" then
		AddOrDelServer(idx)
		GILUpdateUI()
	end
end

--------------------------
-- SPAM FILTER SCROLLER --
--------------------------

function FilterListDrawUpdate (self)

	FauxScrollFrame_Update(self, #GlobalIgnoreDB.filterList, BUTTON_TOTAL, BUTTON_HEIGHT)
	
	if FilterScrollSelect > #GlobalIgnoreDB.filterList then
		FilterScrollSelect = #GlobalIgnoreDB.filterList
	end
	
	Tab2Frame.infotext:SetText(format(L["INFO_2"], GlobalIgnoreDB.filterTotal))
	
	local offset = FauxScrollFrame_GetOffset(self)
	local index  = 0
	
	for count = 1, BUTTON_TOTAL do
		index = count + offset
		
		if index <= #GlobalIgnoreDB.filterList then		
			pName = GlobalIgnoreDB.filterDesc[index]
			
			FilterScrollButtons[count].name:SetText(GlobalIgnoreDB.filterDesc[index])
			FilterScrollButtons[count].filter:SetText(GlobalIgnoreDB.filterList[index])
			
			if GlobalIgnoreDB.filterActive[index] == true then
				FilterScrollButtons[count].state:SetText("|cff33ff99" .. L["ON"]);			
			else
				FilterScrollButtons[count].state:SetText("|cffe60000" .. L["OFF"]);
			end
			
			FilterScrollButtons[count]:SetID(index)
			
			if FilterScrollSelect == index then
				FilterScrollButtons[count]:LockHighlight()
			else
				FilterScrollButtons[count]:UnlockHighlight()
			end
		
			FilterScrollButtons[count]:Show()
		else
			FilterScrollButtons[count]:Hide()
		end
	end
end

local function CreateFilterButtons()

	FilterScrollButtons = {}
	
	for count = 1, BUTTON_TOTAL do
	
		FilterScrollButtons[count] = CreateFrame("Button", nil, FilterScrollFrame:GetParent(), "FriendsFrameIgnoreButtonTemplate")
	
		if count == 1 then
			FilterScrollButtons[count]:SetPoint("TOPLEFT", FilterScrollFrame, -1, 0)
		else
			FilterScrollButtons[count]:SetPoint("TOP", FilterScrollButtons[count - 1], "BOTTOM")
		end

		FilterScrollButtons[count]:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
		FilterScrollButtons[count]:RegisterForClicks("LeftButtonUp")
		FilterScrollButtons[count]:SetScript("OnClick", FilterScrollClick)

		-- set name style
		FilterScrollButtons[count].name:SetWidth(COL_DESC)		

		-- set active style
		FilterScrollButtons[count].state = FilterScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		FilterScrollButtons[count].state:SetPoint("LEFT", FilterScrollButtons[count].name, "RIGHT", 10, 0)
		FilterScrollButtons[count].state:SetWidth(COL_STATE)
		FilterScrollButtons[count].state:SetJustifyH("LEFT")

		-- create filter style
		FilterScrollButtons[count].filter = FilterScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		FilterScrollButtons[count].filter:SetPoint("LEFT", FilterScrollButtons[count].state, "RIGHT", 6, 0)
		FilterScrollButtons[count].filter:SetWidth(COL_FILTER)
		FilterScrollButtons[count].filter:SetJustifyH("LEFT")
		FilterScrollButtons[count].filter:SetWordWrap(false)		
	end
	
	FilterListDrawUpdate(FilterScrollFrame)
end

function FilterScrollDoubleClick()

	if GlobalIgnoreDB.filterDesc[FilterScrollSelect] ~= nil then
	
		Tab2EditDesc   = GlobalIgnoreDB.filterDesc[FilterScrollSelect]
		Tab2EditFilter = GlobalIgnoreDB.filterList[FilterScrollSelect]
		Tab2EditActive = GlobalIgnoreDB.filterActive[FilterScrollSelect]
		Tab2EditState  = true

		Tab2Frame:Hide()
		Tab2FrameEdit:Show()	
	end
end

function FilterScrollClick(self, button, down)

	if down == true then return end
	
	if FilterScrollSelect == self:GetID() and button == "LeftButton" then
		FilterScrollDoubleClick()
		return
	elseif FilterScrollSelect ~= self:GetID() then
		FilterScrollSelect = self:GetID()
		FilterListDrawUpdate(IgnoreScrollFrame)
	end
end


--------------------------
-- IGNORE LIST SCROLLER --
--------------------------

local function IgnoreListDrawUpdate (self)

	FauxScrollFrame_Update(self, #GlobalIgnoreDB.ignoreList, BUTTON_TOTAL, BUTTON_HEIGHT)
	
	if IgnoreScrollSelect > #GlobalIgnoreDB.ignoreList then
		IgnoreScrollSelect = #GlobalIgnoreDB.ignoreList
	end
	
	Tab1Frame.infotext:SetText(format(L["INFO_1"], #GlobalIgnoreDB.ignoreList))
	
	local offset  = FauxScrollFrame_GetOffset(self)
	local index   = 0
	local id      = 0
	local pName   = ""
	local pServer = ""
	local pType   = ""
	local pExpire = ""
	local temp    = 0
	
	for count = 1, BUTTON_TOTAL do
		id = count + offset
		
		if id <= #GlobalIgnoreDB.ignoreList then		
			index = IgnoreScrollIndex[id] or id
			pName = GlobalIgnoreDB.ignoreList[index]
			temp  = string.find(pName, "-", 1, true)
			
			if temp then
				pServer = prettyServer(string.sub(pName, temp + 1, string.len(pName)))
				pName   = string.sub(pName, 1, temp - 1)
			else
				pServer = "All"
			end
			
			if GlobalIgnoreDB.typeList[index] == "player" then
				if GlobalIgnoreDB.factionList[index] == "Alliance" then
					pType = "|cff335effAlliance"
				elseif GlobalIgnoreDB.factionList[index] == "Horde" then
					pType = "|cffe60000Horde"
				else
					pType = "Unknown"
				end				  
			elseif GlobalIgnoreDB.typeList[index] == "npc" then
				pType = "|cffffff99NPC"
			else
				pType = "|cffff66ccServer"
				pServer = prettyServer(pName)
				pName = "All"				
			end	
			
			local playerExp = (GlobalIgnoreDB.expList[index] or 0)
			local daysExp   = playerExp - daysFromToday(GlobalIgnoreDB.dateList[index])

			if playerExp == 0 then
				pExpire = "|cff808080"..L["EXP_NVR"]
			elseif daysExp <= 0 then
				pExpire = "|cffff6666"..L["EXP_TDY"]
			else
				pExpire = daysExp.."d"
			end

			IgnoreScrollButtons[count].name:SetText(pName)
			IgnoreScrollButtons[count].server:SetText(pServer)
			IgnoreScrollButtons[count].type:SetText(pType)
			IgnoreScrollButtons[count].listed:SetText(daysFromToday(GlobalIgnoreDB.dateList[index]) .. "d")
			IgnoreScrollButtons[count].expire:SetText(pExpire)
			IgnoreScrollButtons[count].note:SetText("|cff69CCF0"..GlobalIgnoreDB.notes[index])
			
			IgnoreScrollButtons[count]:SetID(id)
			
			if IgnoreScrollSelect == id then
				IgnoreScrollButtons[count]:LockHighlight()
			else
				IgnoreScrollButtons[count]:UnlockHighlight()
			end
		
			IgnoreScrollButtons[count]:Show()
		else
			IgnoreScrollButtons[count]:Hide()
		end
	end
end

local function CreateIgnoreButtons()

	IgnoreScrollButtons = {}
	
	for count = 1, BUTTON_TOTAL do
	
		IgnoreScrollButtons[count] = CreateFrame("Button", nil, IgnoreScrollFrame:GetParent(), "FriendsFrameIgnoreButtonTemplate")
	
		if count == 1 then
			IgnoreScrollButtons[count]:SetPoint("TOPLEFT", IgnoreScrollFrame, -1, 0)
		else
			IgnoreScrollButtons[count]:SetPoint("TOP", IgnoreScrollButtons[count - 1], "BOTTOM")
		end

		IgnoreScrollButtons[count]:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
		IgnoreScrollButtons[count]:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		IgnoreScrollButtons[count]:SetScript("OnClick", IgnoreScrollClick)		

		-- set name style
		IgnoreScrollButtons[count].name:SetWidth(COL_NAME)

		-- create server style		
		IgnoreScrollButtons[count].server = IgnoreScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		IgnoreScrollButtons[count].server:SetPoint("LEFT", IgnoreScrollButtons[count].name, "RIGHT", 0, 0)
		IgnoreScrollButtons[count].server:SetWidth(COL_SERVER)
		IgnoreScrollButtons[count].server:SetJustifyH("LEFT")
		
		-- create type style
		IgnoreScrollButtons[count].type = IgnoreScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		IgnoreScrollButtons[count].type:SetPoint("LEFT", IgnoreScrollButtons[count].server, "RIGHT", 0, 0)
		IgnoreScrollButtons[count].type:SetWidth(COL_TYPE)
		IgnoreScrollButtons[count].type:SetJustifyH("LEFT")
		
		-- create listed style
		IgnoreScrollButtons[count].listed = IgnoreScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		IgnoreScrollButtons[count].listed:SetPoint("LEFT", IgnoreScrollButtons[count].type, "RIGHT", -17, 0)
		IgnoreScrollButtons[count].listed:SetWidth(COL_LISTED)
		IgnoreScrollButtons[count].listed:SetJustifyH("RIGHT")
		
		-- create expire style
		IgnoreScrollButtons[count].expire = IgnoreScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		IgnoreScrollButtons[count].expire:SetPoint("LEFT", IgnoreScrollButtons[count].listed, "RIGHT", 3, 0)
		IgnoreScrollButtons[count].expire:SetWidth(COL_EXPIRE)
		IgnoreScrollButtons[count].expire:SetJustifyH("RIGHT")
		
		-- create note style
		IgnoreScrollButtons[count].note = IgnoreScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		IgnoreScrollButtons[count].note:SetPoint("LEFT", IgnoreScrollButtons[count].expire, "RIGHT", 13, 0)
		IgnoreScrollButtons[count].note:SetWidth(COL_NOTES)
		IgnoreScrollButtons[count].note:SetJustifyH("LEFT")
		IgnoreScrollButtons[count].note:SetWordWrap(false)
	end
	
	IgnoreListDrawUpdate(IgnoreScrollFrame)
end

function IgnoreScrollDoubleClick()
	nameUI = GlobalIgnoreDB.ignoreList[IgnoreScrollIndex[IgnoreScrollSelect]]
	
	StaticPopup_Show("GIL_REASON", nameUI)
end

function IgnoreScrollClick(self, button, down)

	if down == true then return end
	
	if IgnoreScrollSelect == self:GetID() and button == "LeftButton" then
		IgnoreScrollDoubleClick()
		return
	elseif IgnoreScrollSelect ~= self:GetID() then
		IgnoreScrollSelect = self:GetID()
		IgnoreListDrawUpdate(IgnoreScrollFrame)
	end
	
	if button == "RightButton" then	
		nameUI = GlobalIgnoreDB.ignoreList[IgnoreScrollIndex[IgnoreScrollSelect]]

		local IgnoreRightClickMenu = {

			{ text = nameUI, isTitle = true, notCheckable = true },
			{ text = L["RCM_1"], notCheckable = true, func = function() IgnoreScrollDoubleClick() end },
			{ text = "", disabled = true, notCheckable = true },
			{ text = L["RCM_2"], notCheckable = true, func = function() StaticPopup_Show("GIL_EXPIRE", nameUI) end },
			{ text = L["RCM_3"], notCheckable = true, func = function() GlobalIgnoreDB.expList[IgnoreScrollIndex[IgnoreScrollSelect]] = 0 IgnoreList_Update() end },
			{ text = "", disabled = true, notCheckable = true },
			{ text = L["RCM_4"], notCheckable = true, func = function() ButtonIgnoreRemove() end },
			{ text = "", notCheckable = true, disabled = true },
			{ text = L["RCM_5"], notCheckable = true }
		}	
	
		local menuFrame = CreateFrame("Frame", "GILIgnoreRightClick", UIParent, "UIDropDownMenuTemplate")

		EasyMenu(IgnoreRightClickMenu, menuFrame, "cursor", 0 , 0, "MENU")
	end
end

------------------------------
-- COLUMN SORTING FUNCTIONS --
------------------------------

local function elementName (num)

	local type = GlobalIgnoreDB.typeList[num]
	
	if type == "player" or type == "npc" then
		return removeServer(GlobalIgnoreDB.ignoreList[num], true)
	elseif type == "server" then
		return "All"
	else
		return ""
	end
end

local function elementServer (num)

	local type = GlobalIgnoreDB.typeList[num]

	if type == "player" then
		return getServer(GlobalIgnoreDB.ignoreList[num])
	elseif type == "server" then
		return GlobalIgnoreDB.ignoreList[num]
	elseif type == "npc" then
		return "All"
	else
		return ""
	end
end

local function elementType(num)

	local type = GlobalIgnoreDB.typeList[num]
	
	if type == "player" then
		return GlobalIgnoreDB.factionList[num]
	else
		return type
	end
end

local function createSortedIndex (sortType)

	needSorted			= false
	IgnoreScrollIndex	= {}
	IgnoreScrollType	= sortType
	
	for count = 1, #GlobalIgnoreDB.ignoreList do
		IgnoreScrollIndex[count] = count
	end
	
	-- should I make one of these for each sortType for performance reasons?
	table.sort(IgnoreScrollIndex,
		function (a,b)		
			if sortType == 1 then 
				-- sort by name column only
				return GlobalIgnoreDB.ignoreList[a] < GlobalIgnoreDB.ignoreList[b]
			elseif sortType == 2 then
				return GlobalIgnoreDB.ignoreList[a] > GlobalIgnoreDB.ignoreList[b]
			elseif sortType == 3 then
				local SA = elementServer(a)
				local SB = elementServer(b)
							
				if SA < SB then
					return true
				elseif SA > SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 4 then
				local SA = elementServer(a)
				local SB = elementServer(b)
							
				if SA > SB then
					return true
				elseif SA < SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 5 then
				local SA = elementType(a)
				local SB = elementType(b)

				if SA < SB then
					return true
				elseif SA > SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end				
			elseif sortType == 6 then
				local SA = elementType(a)
				local SB = elementType(b)

				if SA > SB then
					return true
				elseif SA < SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 7 then
				local SA = daysFromToday(GlobalIgnoreDB.dateList[a])
				local SB = daysFromToday(GlobalIgnoreDB.dateList[b])
				
				if SA < SB then
					return true
				elseif SA > SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 8 then
				local SA = daysFromToday(GlobalIgnoreDB.dateList[a])
				local SB = daysFromToday(GlobalIgnoreDB.dateList[b])

				if SA > SB then
					return true
				elseif SA < SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
				
			elseif sortType == 9 then
				local SA = GlobalIgnoreDB.expList[a]
				local SB = GlobalIgnoreDB.expList[b]

				if not SA or SA == 0 then
					SA = 100000
				else
					SA = SA - daysFromToday(GlobalIgnoreDB.dateList[a])
					if SA < 1 then SA = -1 end
				end
					
				if not SB or SB == 0 then
					SB = 100000
				else
					SB = SB - daysFromToday(GlobalIgnoreDB.dateList[b])
					if SB < 1 then SB = -1 end
				end
				
				if SA < SB then
					return true
				elseif SA > SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 10 then
				local SA = GlobalIgnoreDB.expList[a]
				local SB = GlobalIgnoreDB.expList[b]
				
				if not SA or SA == 0 then
					SA = -100000
				else
					SA = SA - daysFromToday(GlobalIgnoreDB.dateList[a])
					if SA < 1 then SA = -1 end
				end
					
				if not SB or SB == 0 then
					SB = -100000
				else
					SB = SB - daysFromToday(GlobalIgnoreDB.dateList[b])
					if SB < 1 then SB = -1 end
				end
				
				if SA  > SB then
					return true
				elseif SA < SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 11 then
				local SA = GlobalIgnoreDB.notes[a]
				local SB = GlobalIgnoreDB.notes[b]
				
				if SA == "" then SA = string.char(255) end
				if SB == "" then SB = string.char(255) end
				
				if SA < SB then
					return true
				elseif SA > SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			
			elseif sortType == 12 then
				local SA = GlobalIgnoreDB.notes[a]
				local SB = GlobalIgnoreDB.notes[b]
				
				if SA == "" then SA = string.char(255) end
				if SB == "" then SB = string.char(255) end
				
				if SA > SB then
					return true
				elseif SA < SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end			
			end
		end)
	
	if (IgnoreScrollFrame ~= nil) then	
		IgnoreListDrawUpdate(IgnoreScrollFrame)
	end
end

local function columnClick(self)

	local id = self:GetID()

	if id == 1 then
		if IgnoreScrollType == 1 then
			createSortedIndex(2)
		else
			createSortedIndex(1)
		end
	elseif id == 2 then
		if IgnoreScrollType == 3 then
			createSortedIndex(4)
		else
			createSortedIndex(3)
		end
	elseif id == 3 then
		if IgnoreScrollType == 5 then
			createSortedIndex(6)
		else
			createSortedIndex(5)
		end
	elseif id == 4 then
		if IgnoreScrollType == 7 then
			createSortedIndex(8)
		else
			createSortedIndex(7)
		end		
	elseif id == 5 then
		if IgnoreScrollType == 9 then
			createSortedIndex(10)
		else
			createSortedIndex(9)
		end	
	elseif id == 6 then
		if IgnoreScrollType == 11 then
			createSortedIndex(12)
		else
			createSortedIndex(11)
		end	
	end
end

local function createColumn (text, width, parent)

	local p = _G[parent:GetName() .. "Header1"]
	
	if p == nil then
		columnCount = 0
	end
	
	columnCount = columnCount + 1
	
	local Header = CreateFrame("Button", parent:GetName() .. "Header" .. columnCount, parent, "WhoFrameColumnHeaderTemplate")
	Header:SetWidth(width)
	_G[parent:GetName().."Header"..columnCount.."Middle"]:SetWidth(width - 9)
	Header:SetText(text)
	Header:SetNormalFontObject("GameFontHighlight")
	Header:SetID(columnCount)
	
	if columnCount == 1 then	
		Header:SetPoint("TOPLEFT", parent, "TOPLEFT", 1, 22)
	else
		Header:SetPoint("LEFT", parent:GetName() .."Header"..columnCount - 1, "RIGHT", 0, 0)	
	end
	
	Header:SetScript("OnClick", columnClick)
end

--------------------
-- LINK CONVERTER --
--------------------

local function convertLink (text)

	if text == nil or text == "" then
		return "UNKNOWN"
	end

	local temp = string.match(text, "|Hitem:(%d+)")
	
	if temp then
		return "[item=".. temp .. "]"
	end

	temp = string.match(text, "|Hspell:(%d+)")

	if temp then
		return "[spell=".. temp.."]"
	end
	
	temp = string.match(text, "|Htalent:(%d+)")
	
	if temp then
		return "[talent=" .. temp .. "]"
	end

	temp = string.match(text, "|Hachievement:(%d+)")
	
	if temp then
		return "[achievement=".. temp .. "]"
	end
	
	temp = string.match(text, "|Hbattlepet:(%d+)")
	
	if temp then
		return "[pet=" .. temp .. "]"
	end

	return "UNKNOWN"
end

---------------------
-- BUILD UI FRAMES --
---------------------

local function CreateUIFrames()

	if MainFrame ~= nil then
		createSortedIndex(IgnoreScrollType)
		MainFrame:Show()
		return
	end

	----------------
	-- MAIN FRAME --
	----------------
	
	MainFrame = CreateFrame("Frame", "GIL", UIParent, "PortraitFrameTemplate")

	MainFrame:Hide()
	
	MainFrame:SetFrameStrata("DIALOG")	
	MainFrame:SetWidth(WINDOW_WIDTH)
	MainFrame:SetHeight(WINDOW_HEIGHT)
	MainFrame:SetPoint("CENTER", UIParent)
	MainFrame:SetMovable(true)
	MainFrame:EnableMouse(true)
	MainFrame:RegisterForDrag("LeftButton", "RightButton")
	MainFrame:SetClampedToScreen(true)
	
	MainFrame.title = _G["GILTitleText"]
	MainFrame.title:SetText("Global Ignore List")
	
	MainFrame:SetScript("OnMouseDown",
		function(self)
			self:StartMoving()
    			self.isMoving = true
		end)

	MainFrame:SetScript("OnMouseUp",
		function (self)
			if self.isMoving then
				self:StopMovingOrSizing()
				self.isMoving = false
			end
		end)
		
	MainFrame:SetScript("OnShow",
		function (self)
			if GIL_SyncOK == false then
				SyncIgnoreList()
			end
		end)

	local icon = MainFrame:CreateTexture("$parentIcon", "OVERLAY", nil, -8)
		
	icon:SetSize(60, 60)
	icon:SetPoint("TOPLEFT", -5, 7)
	icon:SetTexture("Interface\\FriendsFrame\\Battlenet-Portrait")
	
	local Tab1Button = CreateFrame("Button", "GILTab1", MainFrame, "CharacterFrameTabButtonTemplate")
	
	Tab1Button:SetPoint("TOPLEFT", MainFrame, "BOTTOMLEFT", 20, 1)
	Tab1Button:SetText(L["TAB_1"])
	Tab1Button:SetID("1")
	
	Tab1Button:SetScript("OnClick",
		function(self)
			Tab3Frame:Hide()
			Tab2Frame:Hide()
			Tab2FrameEdit:Hide()
			Tab1Frame:Show()
			PanelTemplates_SetTab(MainFrame, 1)
		end)

	local Tab2Button = CreateFrame("Button", "GILTab2", MainFrame, "CharacterFrameTabButtonTemplate")
	
	Tab2Button:SetPoint("LEFT", "GILTab1", "RIGHT", -16, 0)
	Tab2Button:SetText(L["TAB_2"])
	Tab2Button:SetID("2")

	Tab2Button:SetScript("OnClick",
		function(self)
			Tab1Frame:Hide()
			Tab3Frame:Hide()
			
			if Tab2EditState == true then
				Tab2FrameEdit:Show()
				Tab2Frame:Hide()
			else
				Tab2FrameEdit:Hide()
				Tab2Frame:Show()
			end
					
			PanelTemplates_SetTab(MainFrame, 2)
		end)
		
	local Tab3Button = CreateFrame("Button", "GILTab3", MainFrame, "CharacterFrameTabButtonTemplate")
	
	Tab3Button:SetPoint("LEFT", "GILTab2", "RIGHT", -16, 0)
	Tab3Button:SetText(L["TAB_3"])
	Tab3Button:SetID("3")

	Tab3Button:SetScript("OnClick",
		function(self)
			Tab1Frame:Hide()
			Tab2Frame:Hide()
			Tab2FrameEdit:Hide()
			Tab3Frame:Show()
			PanelTemplates_SetTab(MainFrame, 3)
		end)
		
	------------------
	-- TAB 1 FRAMES --
	------------------
	
	Tab1Frame = CreateFrame("Frame", "GILFrame1", MainFrame, "InsetFrameTemplate")

	Tab1Frame:SetWidth(WINDOW_WIDTH - 19)
	Tab1Frame:SetHeight(WINDOW_HEIGHT - WINDOW_OFFSET)
	Tab1Frame:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -84)

	Tab1Frame:SetScript("OnShow",
		function(self)
			IgnoreListDrawUpdate(IgnoreScrollFrame)
		end)
	
	createColumn(L["COL_1"], COL_NAME, Tab1Frame)
	createColumn(L["COL_2"], COL_SERVER, Tab1Frame)
	createColumn(L["COL_3"], COL_TYPE, Tab1Frame)
	createColumn(L["COL_4"], COL_LISTED, Tab1Frame)
	createColumn(L["COL_5"], COL_EXPIRE, Tab1Frame)
	createColumn(L["COL_6"], COL_NOTES, Tab1Frame)
	--createColumn("Alts", 40, Tab1Frame)

	IgnoreScrollFrame = CreateFrame("ScrollFrame", "GILIgnoreScrollFrame", Tab1Frame, "FauxScrollFrameTemplate")
	
	IgnoreScrollFrame:SetWidth  (WINDOW_WIDTH - 46)
	IgnoreScrollFrame:SetHeight (BUTTON_TOTAL * BUTTON_HEIGHT)
	IgnoreScrollFrame:SetPoint  ("TOPLEFT", 0, -4)
	
	IgnoreScrollFrame:SetScript("OnVerticalScroll",
		function(self, offset)
			FauxScrollFrame_OnVerticalScroll(self, offset, BUTTON_HEIGHT, IgnoreListDrawUpdate)
		end)
	
	Tab1Frame.infotext = Tab1Frame:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
	
	Tab1Frame.infotext:SetWidth(COL_INFOTEXT)
	Tab1Frame.infotext:SetJustifyH("CENTER")
	Tab1Frame.infotext:SetPoint("TOP", 0, 46)
	
	CreateIgnoreButtons()
	
	local Button = CreateFrame("Button", "GILFrame1IgnoreButton", Tab1Frame, "UIPanelButtonTemplate")
	
	Button:SetSize(110, 22)
	Button:SetText(L["BUT_1"])
	Button:SetPoint("BOTTOMRIGHT", -1, -24)
	Button:SetScript("OnClick", function(self) ButtonIgnoreRemove() end)

	createSortedIndex(1)

	------------------
	-- TAB 2 FRAMES --
	------------------	
	
	Tab2Frame = CreateFrame("Frame", "GILFrame2", MainFrame, "InsetFrameTemplate")
	
	Tab2Frame:SetScript("OnShow",
		function(self)
			FilterListDrawUpdate(FilterScrollFrame) -- update filter count display
		end)
	
	Tab2Frame:Hide()

	Tab2Frame:SetWidth(WINDOW_WIDTH - 19)
	Tab2Frame:SetHeight(WINDOW_HEIGHT - WINDOW_OFFSET)
	Tab2Frame:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -84)
	
	Tab2Frame.infotext = Tab2Frame:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
	
	Tab2Frame.infotext:SetWidth(COL_INFOTEXT)
	Tab2Frame.infotext:SetJustifyH("CENTER")
	Tab2Frame.infotext:SetPoint("TOP", 0, 46)
	
	createColumn(L["COL_9"],  COL_DESC + 10,   Tab2Frame)
	createColumn("",          COL_STATE + 6,  Tab2Frame)
	createColumn(L["COL_10"], COL_FILTER, Tab2Frame)
	
	FilterScrollFrame = CreateFrame("ScrollFrame", "GILFilterScrollFrame", Tab2Frame, "FauxScrollFrameTemplate")
	
	FilterScrollFrame:SetWidth  (WINDOW_WIDTH - 46)
	FilterScrollFrame:SetHeight (BUTTON_TOTAL * BUTTON_HEIGHT)
	FilterScrollFrame:SetPoint  ("TOPLEFT", 0, -4)
	
	FilterScrollFrame:SetScript("OnVerticalScroll",
		function(self, offset)
			FauxScrollFrame_OnVerticalScroll(self, offset, BUTTON_HEIGHT, FilterListDrawUpdate)
		end)
	
	CreateFilterButtons()

	-- create
	Button = CreateFrame("Button", "GILFrame2CreateButton", Tab2Frame, "UIPanelButtonTemplate")
	Button:SetSize(110, 22)
	Button:SetText(L["BUT_5"])
	--Button:SetPoint("RIGHT", "GILFrame2RemoveButton", "LEFT", 0, 0)
	Button:SetPoint("BOTTOMRIGHT", -1, -24)
	Button:SetScript("OnClick",
		function(self)
			idx = #GlobalIgnoreDB.filterList + 1
			
			GlobalIgnoreDB.filterList[idx]   = "[word=NewSpamFilter]"
			GlobalIgnoreDB.filterDesc[idx]   = "New Spam Filter"
			GlobalIgnoreDB.filterCount[idx]  = 0
			GlobalIgnoreDB.filterActive[idx] = true
			
			FilterListDrawUpdate(FilterScrollFrame)
		end)

	local Button = CreateFrame("Button", "GILFrame2RemoveButton", Tab2Frame, "UIPanelButtonTemplate")	
	Button:SetSize(110, 22)
	Button:SetText(L["BUT_6"])
	Button:SetPoint("RIGHT", "GILFrame2CreateButton", "LEFT", 0, 0)	
	Button:SetScript("OnClick", function(self) if FilterScrollSelect <= 0 then return end StaticPopup_Show("GIL_REMOVEFILTER", L["BOX_10"]) end)
	
	-- reset
	Button = CreateFrame("Button", "GILFrame2ResetButton", Tab2Frame, "UIPanelButtonTemplate")
	Button:SetSize(110, 22)
	Button:SetText(L["BUT_7"])
	Button:SetPoint("RIGHT", "GILFrame2RemoveButton", "LEFT", 0, 0)
	Button:SetScript("OnClick", function(self) StaticPopup_Show("GIL_RESETFILTER", L["BOX_4"]) end)
	--]]

	-----------------------
	-- TAB 2 EDIT FRAMES --
	-----------------------	

	Tab2FrameEdit = CreateFrame("Frame", "GILFrame2Edit", MainFrame, "InsetFrameTemplate")
	
	Tab2FrameEdit:Hide()

	Tab2FrameEdit:SetWidth(WINDOW_WIDTH - 19)
	Tab2FrameEdit:SetHeight(WINDOW_HEIGHT - WINDOW_OFFSET + 20)
	Tab2FrameEdit:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -64)

	Tab2FrameEdit:SetScript("OnShow", function(self) self.InfoText:SetText(format(L["INFO_3"], (GlobalIgnoreDB.filterCount[FilterScrollSelect] or 0))) end)
	
	-- BOTTOM BUTTONS
	
	local Button = CreateFrame("Button", "GILFrame2EditCancelButton", Tab2FrameEdit, "UIPanelButtonTemplate")
		
	Button:SetSize(110, 22)
	Button:SetText("Cancel")
	Button:SetPoint("BOTTOMRIGHT", -1, -24)
	Button:SetScript("OnClick", function(self) Tab2EditState = false Tab2FrameEdit:Hide() Tab2Frame:Show() end)
	
	Button = CreateFrame("Button", "GILFrame2EditSaveButton", Tab2FrameEdit, "UIPanelButtonTemplate")
	Button:SetSize(110, 22)
	Button:SetText("Save Filter")
	Button:SetPoint("RIGHT", "GILFrame2EditCancelButton", "LEFT", 0, 0)
	Button:SetScript("OnClick",
		function(self)
			Tab2EditDesc   = GILFrame2EditDescField:GetText()
			Tab2EditFilter = GILFrame2EditFilterField.EditBox:GetText()
			
			GlobalIgnoreDB.filterDesc[FilterScrollSelect] = Tab2EditDesc
			GlobalIgnoreDB.filterList[FilterScrollSelect] = Tab2EditFilter
			GlobalIgnoreDB.filterActive[FilterScrollSelect] = Tab2EditActive
			
			Tab2EditState = false
			
			Tab2FrameEdit:Hide()
			Tab2Frame:Show()
		end)
	
	
	-- WIDGETS
	
	Text = Tab2FrameEdit:CreateFontString("FontString", "OVERLAY", "GameFontNormalLarge")
	Text:SetPoint("TOPLEFT", Tab2FrameEdit, "TOPLEFT", -8, -18)
	Text:SetWidth(200)
	Text:SetText("Spam Filter Editor:")

	Tab2FrameEdit.InfoText = Tab2FrameEdit:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
	
	Tab2FrameEdit.InfoText:SetWidth(250)
	Tab2FrameEdit.InfoText:SetJustifyH("RIGHT")
	Tab2FrameEdit.InfoText:SetPoint("TOPRIGHT", -48 , -24)
	
	---

	Button = Tab2FrameEdit:CreateFontString("GILFrame2ActiveText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 50, -14)
	Button:SetText("Active:")
	
	Button = CreateFrame("CheckButton", "GILFrame2Active", Tab2FrameEdit, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame2ActiveText, "BOTTOMLEFT", -4, 2)
	Button:SetScript("OnShow",  function(self) self:SetChecked(Tab2EditActive == true) end)
	Button:SetScript("OnClick" ,function(self) Tab2EditActive = (self:GetChecked() or false) end) 

	Button = Tab2FrameEdit:CreateFontString("GILFrame2EditDescText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 110, -14)
	Button:SetText("Description:")
	
	Button = CreateFrame("EditBox", "GILFrame2EditDescField", Tab2FrameEdit, "InputBoxTemplate")
	Button:SetPoint("TOPLEFT", GILFrame2EditDescText, "BOTTOMLEFT", 6, -4)
	Button:SetWidth(564)
	Button:SetHeight(20)
	Button:SetAutoFocus(false)
	Button:SetScript("OnShow",	    function(self) self:SetText(Tab2EditDesc) end)
	Button:SetScript("OnEnterPressed",  function(self) Tab2EditDesc = self:GetText() self:ClearFocus() end)
	Button:SetScript("OnEscapePressed", function(self) self:SetText(Tab2EditDesc) self:ClearFocus() end)
	
	---

	Button = Tab2FrameEdit:CreateFontString("GILFrame2EditFilterText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPLEFT", GILFrame2EditDescText, "BOTTOMLEFT", -60, -40)
	Button:SetText("Filter:")
		
	Button = CreateFrame("ScrollFrame", "GILFrame2EditFilterField", Tab2FrameEdit, "InputScrollFrameTemplate")
	Button:SetPoint("TOPLEFT", GILFrame2EditFilterText, "BOTTOMLEFT", 6, -8)
	Button:SetSize(618, 60)
	Button.EditBox:SetAutoFocus(false)
	Button.EditBox:SetMaxLetters(500)
	Button.EditBox:SetWidth(570)
	Button.EditBox:SetFontObject("ChatFontNormal")
	Button.EditBox:SetScript("OnShow",		    function(self) self:SetText(Tab2EditFilter) end)	
	Button.EditBox:SetScript("OnEnterPressed",  function(self) Tab2EditFilter = self:GetText() self:ClearFocus() end)
	Button.EditBox:SetScript("OnEscapePressed", function(self) self:SetText(Tab2EditFilter) self:ClearFocus() end)
	
	Button = CreateFrame("Button", "GILFrame2EditFilterHelp", Tab2FrameEdit, "UIPanelButtonTemplate")
	Button:SetSize(38, 18)
	Button:SetNormalFontObject("GameFontNormalSmall")
	Button:SetText("Help")
	Button:SetPoint("RIGHT", "GILFrame2EditFilterText", "RIGHT", 598, 0)
	Button:SetScript("OnEnter",
		function(self)
		
			GameTooltip:SetOwner(self)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(L["TIP_1"]);
			GameTooltip:Show()
		end)
		
	Button:SetScript("OnLeave",
		function(self)
			GameTooltip:Hide()
		end)

	---
	
	Button = Tab2FrameEdit:CreateFontString("GILFrame2EditTestText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("BOTTOMLEFT", Tab2FrameEdit, "BOTTOMLEFT", 42, 94)
	Button:SetText("Filter Testing:")

	Button = Tab2FrameEdit:CreateFontString("GILFrame2EditTestResult", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPRIGHT", GILFrame2EditTestText, "TOPRIGHT", 104, -1)
	Button:SetWidth(100)
	Button:SetJustifyH("LEFT")	
	Button:SetText("")
	
	Button = CreateFrame("ScrollFrame", "GILFrame2EditTestField", Tab2FrameEdit, "InputScrollFrameTemplate")
	Button:SetPoint("TOPLEFT", GILFrame2EditTestText, "BOTTOMLEFT", 6, -8)
	Button:SetSize(400, 60)
	Button.EditBox:SetAutoFocus(false)
	Button.EditBox:SetMaxLetters(500)
	Button.EditBox:SetWidth(355)
	Button.EditBox:SetFontObject("ChatFontNormal")
	Button.EditBox:SetScript("OnTextChanged", function(self) GILFrame2EditTestResult:SetText("") end)
	
	Button = CreateFrame("Button", "GILFrame2EditTestHelp", Tab2FrameEdit, "UIPanelButtonTemplate")
	Button:SetSize(38, 18)
	Button:SetNormalFontObject("GameFontNormalSmall")
	Button:SetText("Help")
	Button:SetPoint("RIGHT", "GILFrame2EditTestText", "RIGHT", 294, 0)
	Button:SetScript("OnEnter",
		function(self)
		
			GameTooltip:SetOwner(self)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(L["TIP_2"]);
			GameTooltip:Show()
		end)
		
	Button:SetScript("OnLeave",
		function(self)
			GameTooltip:Hide()
		end)
	

	Button = CreateFrame("Button", "GILFrame2EditTestTest", Tab2FrameEdit, "UIPanelButtonTemplate")
	Button:SetSize(38, 18)
	Button:SetNormalFontObject("GameFontNormalSmall")
	Button:SetText("Test")
	Button:SetPoint("RIGHT", "GILFrame2EditTestHelp", "RIGHT", 40, 0)

	Button:SetScript("OnClick",
		function(self)

			local chatStr   = string.lower(GILFrame2EditTestField.EditBox:GetText())
			local filterStr = GILFrame2EditFilterField.EditBox:GetText()
						
			local res = filterComplex (filterStr, chatStr)
			
			if lastFilterError == true then
				GILFrame2EditTestResult:SetText("|cffffff00FILTER ERROR")
			elseif res == true then
				GILFrame2EditTestResult:SetText("|cffff5c5cBLOCKED")			
			else
				GILFrame2EditTestResult:SetText("|cff00ff96PASSED")			
			end
		end)

	---

	Button = Tab2FrameEdit:CreateFontString("GILFrame2EditLinkText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("BOTTOMRIGHT", Tab2FrameEdit, "BOTTOMRIGHT", -130, 94)
	Button:SetText("Chat Link Converter:")
	
	Button = CreateFrame("Button", "GILFrame2EditLinkHelp", Tab2FrameEdit, "UIPanelButtonTemplate")
	Button:SetSize(38, 18)
	Button:SetNormalFontObject("GameFontNormalSmall")
	Button:SetText("Help")
	Button:SetPoint("RIGHT", "GILFrame2EditLinkText", "RIGHT", 86, 0)
	Button:SetScript("OnEnter",
		function(self)
		
			GameTooltip:SetOwner(self)
			GameTooltip:ClearLines()
			GameTooltip:AddLine("|cffffffffChat Link Converter Help\n\n|cffffff00Enter a chat link into the input box, then press the Enter key.  If the link is valid\nit will be converted into a [tag] used by the chat filter system.\n\nConverted text will automatically be selected so it can be copied and pasted\nusing the copy and paste hotkeys.\n\nLinking items directly into the filter editor box will also automatically convert\nthe link to a GIL format [tag] without using this conversion tool.")
			GameTooltip:Show()
		end)
		
	Button:SetScript("OnLeave",
		function(self)
			GameTooltip:Hide()
		end)

	Button = CreateFrame("EditBox", "GILFrame2EditLinkField", Tab2FrameEdit, "InputBoxTemplate")
	Button:SetPoint("TOPLEFT", GILFrame2EditLinkText, "BOTTOMLEFT", 5, -4)
	Button:SetWidth(200)
	Button:SetHeight(20)
	Button:SetAutoFocus(false)
	Button:SetScript("OnEnterPressed",
		function(self)
			self:SetText(convertLink(self:GetText()))
			self:HighlightText()
		end)

	------------------
	-- TAB 3 FRAMES --
	------------------	
	
	Tab3Frame = CreateFrame("Frame", "GILFrame3", MainFrame, "InsetFrameTemplate")
	
	Tab3Frame:Hide()

	Tab3Frame:SetWidth(WINDOW_WIDTH - 19)
	Tab3Frame:SetHeight(WINDOW_HEIGHT - WINDOW_OFFSET + 20)
	Tab3Frame:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -64)
	
	-- IGNORE LIST OPTIONS

	Text = Tab3Frame:CreateFontString("FontString", "OVERLAY", "GameFontNormalLarge")
	Text:SetPoint("TOPLEFT", Tab3Frame, "TOPLEFT", -8, -18)
	Text:SetWidth(200)
	Text:SetText(L["OPT_8"])
	
	Button = CreateFrame("CheckButton", "GILFrame3AskNote", Tab3Frame, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 30, -10)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_1"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.asknote == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.asknote = (self:GetChecked() or false) end) 

	Button = CreateFrame("CheckButton", "GILFrame3OpenUI", Tab3Frame, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3AskNote, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_2"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.openWithFriends == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.openWithFriends = (self:GetChecked() or false) end) 
	
	Button = CreateFrame("CheckButton", "GILFrame3SameServer", Tab3Frame, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3OpenUI, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_4"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.sameserver == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.sameserver = (self:GetChecked() or false) end) 

	Button = CreateFrame("CheckButton", "GILFrame3TrackChanges", Tab3Frame, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3SameServer, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_6"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.trackChanges == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.trackChanges = (self:GetChecked() or false) end) 

	Button = Tab3Frame:CreateFontString("GILFrame3ExpText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPLEFT", GILFrame3TrackChanges, "BOTTOMLEFT", 6, -4)
	Button:SetText(L["OPT_5"])

	Button = CreateFrame("EditBox", "GILFrame3Exp", Tab3Frame, "InputBoxTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3ExpText, "TOPRIGHT", 6, 4)
	Button:SetWidth(50)
	Button:SetHeight(20)
	Button:SetAutoFocus(false)
	Button:SetScript("OnShow",	    function(self) self:SetText(GlobalIgnoreDB.defexpire) end)
	Button:SetScript("OnEnterPressed",  function(self) if tonumber(self:GetText()) then GlobalIgnoreDB.defexpire = tonumber(self:GetText()) end self:ClearFocus() end)
	Button:SetScript("OnEscapePressed", function(self) self:SetText(GlobalIgnoreDB.defexpire) end)
	
	-- CHAT FILTER OPTIONS

	Text = Tab3Frame:CreateFontString("FontString", "OVERLAY", "GameFontNormalLarge")
	Text:SetPoint("TOPLEFT", GILFrame3ExpText, "BOTTOMLEFT", -22, -20)
	Text:SetWidth(200)
	Text:SetText(L["OPT_9"])

	Button = CreateFrame("CheckButton", "GILFrame3EnableFilter", Tab3Frame, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 16, -6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_7"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.spamFilter == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.spamFilter = (self:GetChecked() or false) end)

	Button = CreateFrame("CheckButton", "GILFrame3InvertFilter", Tab3Frame, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3EnableFilter, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_10"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.invertSpam == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.invertSpam = (self:GetChecked() or false) end)

	Button = CreateFrame("CheckButton", "GILFrame3UpdateFilter", Tab3Frame, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3InvertFilter, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_11"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.autoUpdate == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.autoUpdate = (self:GetChecked() or false) end)

	Button = CreateFrame("CheckButton", "GILFrame3SkipGuild", Tab3Frame, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 450, -6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_12"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.skipGuild == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.skipGuild = (self:GetChecked() or false) end)

	Button = CreateFrame("CheckButton", "GILFrame3SkipParty", Tab3Frame, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3SkipGuild, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_13"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.skipParty == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.skipParty = (self:GetChecked() or false) end)

	Button = CreateFrame("CheckButton", "GILFrame3SkipPrivate", Tab3Frame, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3SkipParty, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_14"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.skipPrivate == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.skipPrivate = (self:GetChecked() or false) end)

	-- SHOW
	
	PanelTemplates_SetNumTabs(MainFrame, 3)
	PanelTemplates_SetTab(MainFrame, 1)
	
	MainFrame:Show()
end

------------------------------
-- HOOK INTO FRIENDS WINDOW --
------------------------------

local function friendsShow()
	
	if not GlobalIgnoreDB.openWithFriends then
		return
	end
	
	if MainFrame == nil then
		CreateUIFrames()
	end
	
	if MainFrame ~= nil then
		MainFrame:ClearAllPoints()
		MainFrame:SetPoint("TOPLEFT", FriendsFrame, "TOPRIGHT", 12, -10)		
		MainFrame:Show()
	end
end

local function friendsHide()
	if not GlobalIgnoreDB.openWithFriends then
		return
	end

	if MainFrame ~= nil then
		MainFrame:Hide()
	end
end

FriendsFrame:HookScript("OnShow", friendsShow)
FriendsFrame:HookScript("OnHide", friendsHide)

--------------------------
-- HOOK INTO CHAT LINKS --
--------------------------

Blizzard_ChatEdit_InsertLink = ChatEdit_InsertLink

function ChatEdit_InsertLink (text)

	if text and GILFrame2EditLinkField and GILFrame2EditLinkField:HasFocus() then
		GILFrame2EditLinkField:SetText(text)
		GILFrame2EditLinkField:Show()
		
		return true	
	elseif text and GILFrame2EditFilterField and GILFrame2EditFilterField.EditBox:HasFocus() then
		GILFrame2EditFilterField.EditBox:Insert(convertLink(text))
		GILFrame2EditFilterField.EditBox:Show()
		
		return true
	elseif text and GILFrame2EditTestField and GILFrame2EditTestField.EditBox:HasFocus() then
		GILFrame2EditTestField.EditBox:Insert(text)
		GILFrame2EditTestField.EditBox:Show()
		
		return true
	else	
		return Blizzard_ChatEdit_InsertLink(text)
	end
end

---------------------
-- CORE UI GLOBALS --
---------------------

function GILUpdateUI (forced)
	
	if MainFrame ~= nil and Tab1Frame:IsVisible() then	
		if needSorted or (forced and forced == true) then
			createSortedIndex(IgnoreScrollType)
		else
			IgnoreListDrawUpdate(IgnoreScrollFrame)
		end
	else
		if needSorted or (forced and forced == true) then
			createSortedIndex(IgnoreScrollType)
		end
	end
end

function GUI()

	CreateUIFrames()
end
