------------------
-- Get/Set Funcs
------------------
local function GetChannels()
	local icList = ""
	local iNext = 0
	if CCLEANER_CLASSIC_CHANNELS ~= nil then
		for i = 1, #CCLEANER_CLASSIC_CHANNELS do
			if CCLEANER_CLASSIC_CHANNELS[i] ~= nil then
				icList = icList .. CCLEANER_CLASSIC_CHANNELS[i]
			end
			iNext = i + 1
			if iNext <= #CCLEANER_CLASSIC_CHANNELS and CCLEANER_CLASSIC_CHANNELS[iNext] ~= nil then
				icList = icList .. ";"
			end
		end
	end
	return icList
end

local function SetChannels(icList)
	CCLEANER_CLASSIC_CHANNELS = {}
	for chname in string.gmatch(icList, "[^;]+") do
		if chname ~= nil and string.len(chname) then table.insert(CCLEANER_CLASSIC_CHANNELS, chname) end
	end		
end

local function GetKeywords(editbox, tbl)
	editbox:SetText("")
	if type(tbl) == "table" and #tbl > 0 then
		local text
		for i=1, #tbl do
			if not text then
				text = tbl[i]
			else
				text = text.."\n"..tbl[i]
			end
		end
		editbox:SetText(text)
	end
end

local function SaveKeywords(editbox, tbl)
	local editText = editbox:GetText()
	local editTextValid = ""

	-- clear existing table...
	for k in pairs(tbl) do tbl[k] = nil; end

	for line in editText:gmatch("[^\r\n]+") do
		line = line:gsub("%s%s+", " ")		-- double+ spaces to single
		line = line:gsub("^%s(.*)$", "%1")	-- remove pre-space
		line = line:gsub("^(.*)%s$", "%1")	-- remove post-space
		-- add if not empty string after above...
		if line ~= "" then
			table.insert(tbl, line)
			editTextValid = editTextValid .. line .. "\n"
		end
	end

	editbox:SetText(editTextValid)
end

local function TableCopy(src, dest)
	for k 		in pairs(dest) 	do dest[k] = nil end 	-- clear
	for k, v 	in pairs(src) 	do dest[k] = v   end 	-- copy
end

------------------
-- Main Frame
------------------
cccGUI = CreateFrame("Frame", nil, UIParent, "BasicFrameTemplate")
cccGUI:SetSize(675, 500)
cccGUI:SetPoint("CENTER")
cccGUI:SetClampedToScreen(true)
cccGUI:EnableMouse(true)
cccGUI:SetMovable(true)
cccGUI:RegisterForDrag("LeftButton")
cccGUI:SetScript("OnDragStart", function(self) self:StartMoving() end)
cccGUI:SetScript("OnDragStop",  function(self) self:StopMovingOrSizing() end)
cccGUI:Hide()

------------------
-- Title
------------------
cccGUI.title = cccGUI:CreateFontString(nil, nil, "GameFontNormalMed2")
cccGUI.title:SetPoint("TOPLEFT", 15, -5)
cccGUI.title:SetText("ChatCleanerClassic " .. string.format("v%s", GetAddOnMetadata("CCleanerClassic", "Version")))

------------------
-- Slash Command
------------------
SlashCmdList["ChatCleanerClassic"] = function() cccGUI:Show() end
SLASH_ChatCleanerClassic1 = "/chatcleanerclassic"
--SLASH_ChatCleanerClassic2 = "/ccc" -- commented: conflicts with other addons

------------------
-- General Options
------------------
local cccTxtGeneral = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTxtGeneral:SetPoint("TOPLEFT", cccGUI.title, "BOTTOMLEFT", 0, -20)
cccTxtGeneral:SetText("General Options:")

------------------
-- Enabled
------------------
local cccChkEnabled = CreateFrame("CheckButton", nil, cccGUI, "OptionsBaseCheckButtonTemplate")
cccChkEnabled:SetPoint("TOPLEFT", cccTxtGeneral, "TOPRIGHT", 20, 5)
cccChkEnabled:SetScript("OnClick", function(frame)
	CCLEANER_CLASSIC_ENABLED = frame:GetChecked()
end)
cccChkEnabled:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine("Enable/disable filtering.", 0.5, 0.5, 0)
	GameTooltip:Show()
end)
local cccTxtEnabled = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTxtEnabled:SetPoint("LEFT", cccChkEnabled, "RIGHT", 0, 1)
cccTxtEnabled:SetText("Enabled")

------------------
-- Filter Friendly
------------------
local cccChkFilterFriendly = CreateFrame("CheckButton", nil, cccGUI, "OptionsBaseCheckButtonTemplate")
cccChkFilterFriendly:SetPoint("TOPLEFT", cccTxtEnabled, "TOPRIGHT", 13, 5)
cccChkFilterFriendly:SetScript("OnClick", function(frame)
	CCLEANER_CLASSIC_FILTER_FRIENDLY = frame:GetChecked()
end)
cccChkFilterFriendly:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine("Filter out chat from friends, guildies, raiders, etc.", 0.5, 0.5, 0)
	GameTooltip:Show()
end)
local cccTxtFilterFriendly = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTxtFilterFriendly:SetPoint("LEFT", cccChkFilterFriendly, "RIGHT", 0, 1)
cccTxtFilterFriendly:SetText("Filter Friendly")

------------------
-- Whole Words
------------------
local cccChkWoleWords = CreateFrame("CheckButton", nil, cccGUI, "OptionsBaseCheckButtonTemplate")
cccChkWoleWords:SetPoint("TOPLEFT", cccTxtFilterFriendly, "TOPRIGHT", 10, 5)
cccChkWoleWords:SetScript("OnClick", function(frame)
	CCLEANER_CLASSIC_WHOLE_WORDS = frame:GetChecked()
end)
cccChkWoleWords:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine("Filtering keywords are matched as whole words instead of partial.", 0.5, 0.5, 0)
	GameTooltip:Show()
end)
local cccTxtWholeWords = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTxtWholeWords:SetPoint("LEFT", cccChkWoleWords, "RIGHT", 0, 1)
cccTxtWholeWords:SetText("Match Whole Words")

------------------
-- Highlight Color
------------------
local cccInputHColor = CreateFrame("EditBox", nil, cccGUI, "InputBoxTemplate")
cccInputHColor:SetAutoFocus(false)
cccInputHColor:EnableMouse(true)
cccInputHColor:SetWidth(70)
cccInputHColor:SetHeight(20)
cccInputHColor:SetMaxLetters(7)
cccInputHColor:SetScript("OnEscapePressed", function(frame) frame:ClearFocus() end)
cccInputHColor:SetScript("OnEnterPressed",  function(frame)
	CCLEANER_CLASSIC_HCOLOR = cccInputHColor:GetText()
	frame:ClearFocus() 
end)
cccInputHColor:Hide() -- not implemented yet
--[[
------------------
cccInputHColor:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine("Hex highlight color for matched (required) keywords.\nExample for green: #00FF00\nLeave empty to disable.\nNOTE: highlighting will be ignored if value is not a valid hex RGB value.", 0.5, 0.5, 0)
	GameTooltip:Show()
end)
cccInputHColor:SetScript("OnLeave", GameTooltip_Hide)
------------------
local cccTextHColor = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTextHColor:SetPoint("TOPLEFT", cccTxtWholeWords, "TOPRIGHT", 25, 0)
cccTextHColor:SetText("Match Color:")
cccInputHColor:SetPoint("TOPLEFT", cccTextHColor, "TOPRIGHT", 5, 2)
--]]

------------------
-- Channels
------------------
local cccInputChan = CreateFrame("EditBox", nil, cccGUI, "InputBoxTemplate")
cccInputChan:SetAutoFocus(false)
cccInputChan:EnableMouse(true)
cccInputChan:SetWidth(190)
cccInputChan:SetHeight(20)
cccInputChan:SetMaxLetters(99999)
cccInputChan:SetScript("OnEscapePressed", function(frame) frame:ClearFocus() end)
cccInputChan:SetScript("OnEnterPressed",  function(frame) SetChannels(frame:GetText()) frame:ClearFocus() end)
cccInputChan:Show()
------------------
cccInputChan:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine("Only affect chat on these channel names (separated by semi-colons).\nLeave empty for all named channels.\nExample: LookingForGroup;LFG", 0.5, 0.5, 0)
	GameTooltip:Show()
end)
cccInputChan:SetScript("OnLeave", GameTooltip_Hide)
------------------
local cccTextChan = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTextChan:SetPoint("TOPLEFT", cccTxtGeneral, "BOTTOMLEFT", 0, -12)
cccTextChan:SetText("Affected Channels:")
cccInputChan:SetPoint("TOPLEFT", cccTextChan, "TOPRIGHT", 15, 2)

------------------
-- Filter Say Chat
------------------
local cccChkFilterSay = CreateFrame("CheckButton", nil, cccGUI, "OptionsBaseCheckButtonTemplate")
cccChkFilterSay:SetPoint("TOPLEFT", cccInputChan, "TOPRIGHT", 5, 3)
cccChkFilterSay:SetScript("OnClick", function(frame)
	CCLEANER_CLASSIC_FILTER_SAY = frame:GetChecked()
end)
local cccTxtFilterSay = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTxtFilterSay:SetPoint("LEFT", cccChkFilterSay, "RIGHT", 0, 1)
cccTxtFilterSay:SetText("Filter Say Chat")

------------------
-- Filter Yell Chat
------------------
local cccChkFilterYell = CreateFrame("CheckButton", nil, cccGUI, "OptionsBaseCheckButtonTemplate")
cccChkFilterYell:SetPoint("TOPLEFT", cccTxtFilterSay, "TOPRIGHT", 5, 5)
cccChkFilterYell:SetScript("OnClick", function(frame)
	CCLEANER_CLASSIC_FILTER_YELL = frame:GetChecked()
end)
local cccTxtFilterYell = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTxtFilterYell:SetPoint("LEFT", cccChkFilterYell, "RIGHT", 0, 1)
cccTxtFilterYell:SetText("Filter Yell Chat")

------------------
-- Export to Account Vars
------------------
local cccBtnExport = CreateFrame("Button", nil, cccGUI, "UIPanelButtonTemplate")
cccBtnExport:SetHeight(25)
cccBtnExport:SetWidth(325)
cccBtnExport:SetPoint("TOP",  cccGUI, "BOTTOM", 0, 30)
cccBtnExport:SetPoint("LEFT", cccTxtGeneral, "LEFT", -5, 0)
cccBtnExport:SetText("Export All Settings to Account Vars")
cccBtnExport:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine("Click to export these settings to the account-wide variables.\nYou can then log on to another character and import these settings to that character.", 0.5, 0.5, 0)
	GameTooltip:Show()
end)

------------------
-- Import From Account Vars
------------------
local cccBtnImport = CreateFrame("Button", nil, cccGUI, "UIPanelButtonTemplate")
cccBtnImport:SetHeight(25)
cccBtnImport:SetWidth(325)
cccBtnImport:SetPoint("TOP",  cccGUI, "BOTTOM", 0, 30)
cccBtnImport:SetPoint("LEFT", cccBtnExport, "RIGHT", 0, 0)
cccBtnImport:SetText("Import All Settings from Account Vars")
cccBtnImport:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine("Click to import previously exported settings from the account-wide variables.\nSee export tooltip for more info.", 0.5, 0.5, 0)
	GameTooltip:Show()
end)

------------------
-- Required Keywords
------------------
local cccTxtReqBtn = CreateFrame("Button", nil, cccGUI, "UIPanelInfoButton")
cccTxtReqBtn:SetPoint("TOP",  cccTextChan, "BOTTOM", 0, -15)
cccTxtReqBtn:SetPoint("LEFT", cccTextChan, "LEFT", 3, 0)
local cccTxtReq = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTxtReq:SetPoint("TOPLEFT", cccTxtReqBtn, "TOPRIGHT", 5, 0)
cccTxtReq:SetText("Required keywords:")
------------------
local cccBtnReqRevert = CreateFrame("Button", nil, cccGUI, "UIPanelButtonTemplate")
cccBtnReqRevert:SetWidth(70)
cccBtnReqRevert:SetHeight(20)
cccBtnReqRevert:SetPoint("TOPLEFT", cccTxtReq, "TOPRIGHT", 15, 0)
cccBtnReqRevert:SetText("Revert")
------------------
local cccBtnReqSave = CreateFrame("Button", nil, cccGUI, "UIPanelButtonTemplate")
cccBtnReqSave:SetWidth(70)
cccBtnReqSave:SetHeight(20)
cccBtnReqSave:SetPoint("TOPLEFT", cccBtnReqRevert, "TOPRIGHT", 15, 0)
cccBtnReqSave:SetText("Save")
------------------
cccTxtReqBtn:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine("Required keywords: chats must have at least one of these to be shown.\nLeave empty to bypass.", 0.5, 0.5, 0)
	GameTooltip:Show()
end)
cccTxtReqBtn:SetScript("OnLeave", GameTooltip_Hide)

------------------
-- Clean Keywords
------------------
local cccTxtCleanBtn = CreateFrame("Button", nil, cccGUI, "UIPanelInfoButton")
cccTxtCleanBtn:SetPoint("TOP",  cccTextChan, "BOTTOM", 0, -15)
cccTxtCleanBtn:SetPoint("LEFT", cccBtnImport, "LEFT", 8, 0)
local cccTxtClean = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTxtClean:SetPoint("TOPLEFT", cccTxtCleanBtn, "TOPRIGHT", 5, 0)
cccTxtClean:SetText("Clean keywords:")
------------------
local cccBtnCleanRevert = CreateFrame("Button", nil, cccGUI, "UIPanelButtonTemplate")
cccBtnCleanRevert:SetWidth(70)
cccBtnCleanRevert:SetHeight(20)
cccBtnCleanRevert:SetPoint("TOPLEFT", cccTxtClean, "TOPRIGHT", 25, 0)
cccBtnCleanRevert:SetText("Revert")
------------------
local cccBtnCleanSave = CreateFrame("Button", nil, cccGUI, "UIPanelButtonTemplate")
cccBtnCleanSave:SetWidth(70)
cccBtnCleanSave:SetHeight(20)
cccBtnCleanSave:SetPoint("TOPLEFT", cccBtnCleanRevert, "TOPRIGHT", 25, 0)
cccBtnCleanSave:SetText("Save")
------------------
cccTxtCleanBtn:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine("Clean keywords: chats found with any of these will be removed (even if a required keyword is found).\n", 0.5, 0.5, 0)
	GameTooltip:Show()
end)
cccTxtCleanBtn:SetScript("OnLeave", GameTooltip_Hide)

------------------
-- Import/Export Status
------------------
local cccTxtIEStatus = cccGUI:CreateFontString(nil, nil, "GameFontHighlight")
cccTxtIEStatus:SetPoint("TOP",  cccBtnExport,  "TOP", 0, cccBtnExport:GetHeight() * 0.85)
cccTxtIEStatus:SetPoint("LEFT", cccTxtGeneral, "LEFT")
cccTxtIEStatus:SetWidth(cccGUI:GetWidth() - 30)
cccTxtIEStatus:SetJustifyH("CENTER");
cccTxtIEStatus:SetTextColor(1, 1, 0, 1)
cccTxtIEStatus:SetText("")

local function SetIEStatusText(text)
	cccTxtIEStatus:SetText(text)
	C_Timer.After(3.5, function() cccTxtIEStatus:SetText("") end)
end

------------------
-- Required Table
------------------
local cccEditReq = CreateFrame("EditBox", nil, cccGUI)
cccEditReq:SetMultiLine(true)
cccEditReq:SetMaxLetters(99999)
cccEditReq:EnableMouse(true)
cccEditReq:SetAutoFocus(false)
cccEditReq:SetFontObject(ChatFontNormal)
cccEditReq:SetWidth(350)
cccEditReq:SetHeight(cccTxtReq:GetBottom() - (cccBtnExport:GetTop() + (cccBtnExport:GetHeight() * 2)))
cccEditReq:Show()
------------------
local cccScrollReq = CreateFrame("ScrollFrame", nil, cccGUI, "UIPanelScrollFrameTemplate")
cccScrollReq:SetPoint("TOP",  cccTxtReq,    "BOTTOM", 0, -7)
cccScrollReq:SetPoint("LEFT", cccBtnExport, "LEFT",   8,  0)
cccScrollReq:SetHeight(cccEditReq:GetHeight() - 5) -- small offset because of scrollbar flickering when final value is at the bottom edge
cccScrollReq:SetScrollChild(cccEditReq)
------------------
local cccBGFReq = CreateFrame("Frame", nil, cccGUI, BackdropTemplateMixin and "BackdropTemplate");
cccBGFReq:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = {left = 3, right = 3, top = 5, bottom = 3}}
)
cccBGFReq:SetBackdropColor(0,0,0,1)
cccBGFReq:SetPoint("TOP",  cccTxtReq,    "BOTTOM", 0, -2)
cccBGFReq:SetPoint("LEFT", cccBtnExport, "LEFT")
cccBGFReq:SetWidth(cccBtnExport:GetWidth())
cccBGFReq:SetHeight(cccScrollReq:GetHeight() + 10)
cccScrollReq:SetWidth(cccBGFReq:GetWidth() - 37)

------------------
-- Clean Table
------------------
local cccEditClean = CreateFrame("EditBox", nil, cccGUI)
cccEditClean:SetMultiLine(true)
cccEditClean:SetMaxLetters(99999)
cccEditClean:EnableMouse(true)
cccEditClean:SetAutoFocus(false)
cccEditClean:SetFontObject(ChatFontNormal)
cccEditClean:SetWidth(cccEditReq:GetWidth())
cccEditClean:SetHeight(cccEditReq:GetHeight())
cccEditClean:Show()
------------------
local cccScrollClean = CreateFrame("ScrollFrame", nil, cccGUI, "UIPanelScrollFrameTemplate")
cccScrollClean:SetPoint("TOP",  cccTxtClean,  "BOTTOM", 0, -7)
cccScrollClean:SetPoint("LEFT", cccBtnImport, "LEFT",   8,  0)
cccScrollClean:SetHeight(cccScrollReq:GetHeight())
cccScrollClean:SetScrollChild(cccEditClean)
------------------
local cccBGFClean = CreateFrame("Frame", nil, cccGUI, BackdropTemplateMixin and "BackdropTemplate")
cccBGFClean:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = {left = 3, right = 3, top = 5, bottom = 3}}
)
cccBGFClean:SetBackdropColor(0,0,0,1)
cccBGFClean:SetPoint("TOP",  cccTxtClean,  "BOTTOM", 0, -2)
cccBGFClean:SetPoint("LEFT", cccBtnImport, "LEFT")
cccBGFClean:SetWidth(cccBGFReq:GetWidth())
cccBGFClean:SetHeight(cccBGFReq:GetHeight())
cccScrollClean:SetWidth(cccBGFClean:GetWidth() - 37)

------------------
-- Save OnClicks
------------------
cccBtnReqSave:SetScript("OnClick", function() 
	StaticPopupDialogs["CCC_REQ_SAVE"] = {
	  text = "WARNING: This will SAVE your REQUIRED keywords.\n\nAre you sure?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function() 
		SaveKeywords(cccEditReq, CCLEANER_CLASSIC_REQUIRED)
		SetIEStatusText("Required keywords saved!") 
	  end,
	  timeout = 0,
	  whileDead = true,
	  hideOnEscape = true,
	  preferredIndex = 3,
	}
	StaticPopup_Show("CCC_REQ_SAVE")
	cccEditReq:ClearFocus()
end)
cccBtnCleanSave:SetScript("OnClick", function() 
	StaticPopupDialogs["CCC_CLEAN_SAVE"] = {
	  text = "WARNING: This will SAVE your CLEAN keywords.\n\nAre you sure?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function() 
		SaveKeywords(cccEditClean, CCLEANER_CLASSIC_CLEAN)
		SetIEStatusText("Clean keywords saved!") 
	  end,
	  timeout = 0,
	  whileDead = true,
	  hideOnEscape = true,
	  preferredIndex = 3,
	}
	StaticPopup_Show("CCC_CLEAN_SAVE")
	cccEditClean:ClearFocus()
end)

------------------
-- Revert OnClicks
------------------
cccBtnReqRevert:SetScript("OnClick", function()
	StaticPopupDialogs["CCC_REQ_REVERT"] = {
	  text = "WARNING: This will REVERT your REQUIRED changes to the previous save.\n\nAre you sure?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function() 
	  	GetKeywords(cccEditReq, CCLEANER_CLASSIC_REQUIRED)
	  	SetIEStatusText("Required keywords reverted!")
	  end,
	  timeout = 0,
	  whileDead = true,
	  hideOnEscape = true,
	  preferredIndex = 3,
	}
	StaticPopup_Show("CCC_REQ_REVERT")
	cccEditReq:ClearFocus()
end)
cccBtnCleanRevert:SetScript("OnClick", function()
	StaticPopupDialogs["CCC_CLEAN_REVERT"] = {
	  text = "WARNING: This will REVERT your CLEAN changes to the previous save.\n\nAre you sure?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function() 
	  	GetKeywords(cccEditClean, CCLEANER_CLASSIC_CLEAN)
	  	SetIEStatusText("Clean keywords reverted!")
	  end,
	  timeout = 0,
	  whileDead = true,
	  hideOnEscape = true,
	  preferredIndex = 3,
	}
	StaticPopup_Show("CCC_CLEAN_REVERT")	
	cccEditClean:ClearFocus()
end)

------------------
-- Init Funcs
------------------
local function LoadSettings()
	cccChkEnabled:SetChecked(CCLEANER_CLASSIC_ENABLED)
	cccChkFilterFriendly:SetChecked(CCLEANER_CLASSIC_FILTER_FRIENDLY)
	cccChkWoleWords:SetChecked(CCLEANER_CLASSIC_WHOLE_WORDS)
	cccInputHColor:SetText(CCLEANER_CLASSIC_HCOLOR)
	cccInputChan:SetText(GetChannels())
	cccChkFilterSay:SetChecked(CCLEANER_CLASSIC_FILTER_SAY)
	cccChkFilterYell:SetChecked(CCLEANER_CLASSIC_FILTER_YELL)
	GetKeywords(cccEditReq,   CCLEANER_CLASSIC_REQUIRED)
	GetKeywords(cccEditClean, CCLEANER_CLASSIC_CLEAN)
end

------------------
-- Export OnClick
------------------
cccBtnExport:SetScript("OnClick", function()
	StaticPopupDialogs["CCC_CONFIRM_EXPORT"] = {
	  text = "WARNING: An EXPORT cannot be undone.\n\nAre you sure?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function()
		-- copy tables...
		TableCopy(CCLEANER_CLASSIC_CHANNELS, 	CCLEANER_CLASSIC_ACCOUNT_CHANNELS);
		TableCopy(CCLEANER_CLASSIC_REQUIRED, 	CCLEANER_CLASSIC_ACCOUNT_REQUIRED);
		TableCopy(CCLEANER_CLASSIC_CLEAN, 		CCLEANER_CLASSIC_ACCOUNT_CLEAN);
		-- other settings...
		CCLEANER_CLASSIC_ACCOUNT_ENABLED =  		CCLEANER_CLASSIC_ENABLED
		CCLEANER_CLASSIC_ACCOUNT_FILTER_FRIENDLY =  CCLEANER_CLASSIC_FILTER_FRIENDLY
		CCLEANER_CLASSIC_ACCOUNT_FILTER_SAY = 		CCLEANER_CLASSIC_FILTER_SAY
		CCLEANER_CLASSIC_ACCOUNT_FILTER_YELL = 		CCLEANER_CLASSIC_FILTER_YELL
		CCLEANER_CLASSIC_ACCOUNT_WHOLE_WORDS = 		CCLEANER_CLASSIC_WHOLE_WORDS
		CCLEANER_CLASSIC_ACCOUNT_HCOLOR = 			CCLEANER_CLASSIC_HCOLOR
		SetIEStatusText("Settings were exported to account vars!")
	  end,
	  timeout = 0,
	  whileDead = true,
	  hideOnEscape = true,
	  preferredIndex = 3,
	}

	StaticPopup_Show("CCC_CONFIRM_EXPORT")
end)

------------------
-- Import OnClick
------------------
cccBtnImport:SetScript("OnClick", function()
	StaticPopupDialogs["CCC_CONFIRM_IMPORT"] = {
		text = "WARNING: An IMPORT cannot be undone.\n\nAre you sure?",
		button1 = "Yes",
		button2 = "No",
		OnAccept = function()
			-- copy tables...
			TableCopy(CCLEANER_CLASSIC_ACCOUNT_CHANNELS, 	CCLEANER_CLASSIC_CHANNELS);
			TableCopy(CCLEANER_CLASSIC_ACCOUNT_REQUIRED, 	CCLEANER_CLASSIC_REQUIRED);
			TableCopy(CCLEANER_CLASSIC_ACCOUNT_CLEAN, 		CCLEANER_CLASSIC_CLEAN);
			-- other settings...
			CCLEANER_CLASSIC_ENABLED =  		CCLEANER_CLASSIC_ACCOUNT_ENABLED
			CCLEANER_CLASSIC_FILTER_FRIENDLY =  CCLEANER_CLASSIC_ACCOUNT_FILTER_FRIENDLY
			CCLEANER_CLASSIC_FILTER_SAY = 		CCLEANER_CLASSIC_ACCOUNT_FILTER_SAY
			CCLEANER_CLASSIC_FILTER_YELL = 		CCLEANER_CLASSIC_ACCOUNT_FILTER_YELL
			CCLEANER_CLASSIC_WHOLE_WORDS = 		CCLEANER_CLASSIC_ACCOUNT_WHOLE_WORDS
			CCLEANER_CLASSIC_HCOLOR = 			CCLEANER_CLASSIC_ACCOUNT_HCOLOR
			SetIEStatusText("Settings were imported from account vars!")
			LoadSettings()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,
	}

	StaticPopup_Show("CCC_CONFIRM_IMPORT")	
end)

------------------
-- Main Frame: Load Settings
------------------
cccGUI:SetScript("OnShow",  function() LoadSettings() end)
