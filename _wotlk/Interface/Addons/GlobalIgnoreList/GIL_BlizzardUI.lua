-----------------------
-- BLIZZARD UI HOOKS --
-----------------------

indentUI	= 0

local _, L      = ...
local daysUI	= {}
local expUI		= {}
local reasonUI	= {}
local headerUI	= {}

local BlizzardIgnoreListUpdate	= nil

-----------------------------
-- UNIT AND CHAT MENU HOOK --
-----------------------------

local function getButtonElement (list, name)
	for index, value in ipairs(list) do
		if (type(value) == "string") and (value == "IGNORE") then
			return index
		end
	end
	
	return -1
end

table.remove(UnitPopupMenus["FRIEND"], getButtonElement(UnitPopupMenus["FRIEND"], "IGNORE"))

local function GilUnitMenu (dropdownMenu, which, unit, name, userData, ...)

	if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
		return
	end
	
	if (which and (which == "FRIEND")) then

		local info = UIDropDownMenu_CreateInfo()
				
		info.dist = 0
		info.notCheckable = 1	
		info.func = function() C_FriendList.AddOrDelIgnore(addServer(name)) GILUpdateUI(true) end
			
		if (hasGlobalIgnored(addServer(name)) > 0) then
			info.text = L["RCM_4"]					
		else
			info.text = L["RCM_6"]
		end	
				
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		
	elseif (which and (which == "PLAYER" or which == "RAID_PLAYER" or which == "PARTY" or which == "TARGET")) then
		
		local target, server = UnitName(unit or "target")
			
		if server then
			if server == "" then
				addServer(target)
			else
				target = target .. "-"..server
			end
		end
		
		target = Proper(target, true)
		
		DropDownList1.numButtons = max(0, DropDownList1.numButtons - 1)

		local info = UIDropDownMenu_CreateInfo()
		info.text = ""
		info.notCheckable = true
		info.disabled = true
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)	

		local info = UIDropDownMenu_CreateInfo()
				
		info.dist = 0
		info.notCheckable = 1
		
		if name and name == RAID_TARGET_ICON then
			info.func = function() AddOrDelNPC("") GILUpdateUI(true) end
				
			if (hasNPCIgnored(target) > 0) then
				info.text = L["RCM_4"]
			else
				info.text = L["RCM_6"]
			end

		else
			info.func = function() C_FriendList.AddOrDelIgnore(addServer(target)) GILUpdateUI(true) end
			
			if (hasGlobalIgnored(addServer(target)) > 0) then
				info.text = L["RCM_4"]				
				
			else
				info.text = L["RCM_6"]
			end	
		end
		
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		
		local info = UIDropDownMenu_CreateInfo()
		info.text = L["RCM_5"]
		info.dist = 0
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	end
end

hooksecurefunc("UnitPopup_ShowMenu", GilUnitMenu)

-----------------------
-- IGNORE LIST HACKS --
-----------------------

BlizzardIgnoreListUpdate	= IgnoreList_Update

local function IgnoreButtonEnter(self, ...)

	GameTooltip:Hide()
	GameTooltip:ClearLines()
	
	local playerIndex = hasGlobalIgnored(addServer(self.name:GetText()))
	
	if playerIndex == 0 then
		return
	end
	
	local playerNotes = GlobalIgnoreDB.notes[playerIndex]
	local daysInList  = daysFromToday(GlobalIgnoreDB.dateList[playerIndex])
	local daysExpire  = GlobalIgnoreDB.expList[playerIndex]
		
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:AddLine("|cff69CCF0" .. self.name:GetText())
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("  "..L["OVER_1"].." |cffc0c0c0" .. getServer(self.name:GetText()))
	GameTooltip:AddLine("  "..L["OVER_2"].." |cffc0c0c0" .. (GlobalIgnoreDB.factionList[playerIndex] or "Unknown"))
	GameTooltip:AddLine("  "..L["OVER_3"].." |cffc0c0c0" .. daysInList .. " " .. dayString(daysInList))
	
	if GlobalIgnoreDB.expList[playerIndex] == 0 then
		GameTooltip:AddLine("  "..L["OVER_4"].." |cffc0c0c0"..L["EXP_NVR"])
	else
		GameTooltip:AddLine("  "..L["OVER_4"].." |cffc0c0c0"..format(L["OVER_5"], daysExpire , daysExpire - daysInList))
	end
	
	GameTooltip:AddLine(" ")
	
	if playerNotes ~= nil and playerNotes ~= "" then
		GameTooltip:AddLine("|cff69CCF0"..playerNotes)
	end
	
	GameTooltip:Show()
end

local function IgnoreButtonLeave(self, ...)
	GameTooltip:Hide()
end

local function IgnoreButtonDoubleClick(self, ...)
	nameUI = addServer(C_FriendList.GetIgnoreName(GetSelectedIgnore()))
	
	if (nameUI ~= nil) then
		StaticPopup_Show("GIL_REASON", nameUI)
	end
end

local function IgnoreButtonClick(self, button, down)

	if button ~= "RightButton" or down == true then
		return
	end
	
	nameUI = addServer(C_FriendList.GetIgnoreName(GetSelectedIgnore()))
		
	local IgnoreRightClickMenu = {

		{ text = C_FriendList.GetIgnoreName(GetSelectedIgnore()), isTitle = true, notCheckable = true },
		{ text = L["RCM_1"], notCheckable = true, func = function() IgnoreButtonDoubleClick() end },
		{ text = "", disabled = true, notCheckable = true },
		{ text = L["RCM_2"], notCheckable = true, func = function() if (nameUI ~= nil) then StaticPopup_Show("GIL_EXPIRE", nameUI) end end },
		{ text = L["RCM_3"], notCheckable = true, func = function() GlobalIgnoreDB.expList[hasGlobalIgnored(nameUI)] = 0 IgnoreList_Update() end },
		{ text = "", disabled = true, notCheckable = true },
--		{ text = L["RCM_4"], notCheckable = true, func = function() C_FriendList.DelIgnore(C_FriendList.GetIgnoreName(GetSelectedIgnore())) end },
		{ text = L["RCM_4"], notCheckable = true, func = function() C_FriendList.DelIgnoreByIndex(GetSelectedIgnore(), true) end },
		{ text = "", notCheckable = true, disabled = true },
		{ text = L["RCM_5"], notCheckable = true }
	}	
	
	local menuFrame = CreateFrame("Frame", "gil_IgnoreRightClick", UIParent, "UIDropDownMenuTemplate")

	EasyMenu(IgnoreRightClickMenu, menuFrame, "cursor", 0 , 0, "MENU")
end

IgnoreList_Update = function(...)

	BlizzardIgnoreListUpdate(...)

	if GIL_Loaded ~= true then
		return
	end
	
	GILUpdateUI()
	
	local buttonWidth = 0
	
	if indentUI == 0 then
		indentUI = 130
		
		for count = 1, IGNORES_TO_DISPLAY, 1 do
			local button = _G["FriendsFrameIgnoreButton"..count]
		
			if button then
				indentUI = max(indentUI, (button.name:GetStringWidth() + 16))
			end
		end
	end

	for count = 1, IGNORES_TO_DISPLAY, 1 do
		button = _G["FriendsFrameIgnoreButton"..count]
		
		if button then

			if buttonWidth == 0 then
				buttonWidth = button:GetWidth()
			end
			
			if daysUI[count] == nil then		
				daysUI[count] = button:CreateFontString("FontString", "OVERLAY", "GameFontWhiteSmall")
		
				daysUI[count]:SetPoint("TOP", button)
				daysUI[count]:SetPoint("BOTTOMLEFT", button)
				daysUI[count]:SetJustifyH("RIGHT")
					
				button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
				
				button:HookScript("OnEnter", IgnoreButtonEnter)
				button:HookScript("OnLeave", IgnoreButtonLeave)
				button:HookScript("OnClick", IgnoreButtonClick)
				button:HookScript("OnDoubleClick", IgnoreButtonDoubleClick)
			end
			
			if expUI[count] == nil then		
				expUI[count] = button:CreateFontString("FontString", "OVERLAY", "GameFontWhiteSmall")
					
				expUI[count]:SetPoint("TOP", button)
				expUI[count]:SetPoint("BOTTOMLEFT", button)
				expUI[count]:SetJustifyH("RIGHT")
			end
			
			if reasonUI[count] == nil then
				reasonUI[count] = button:CreateFontString("FontString", "OVERLAY", "GameFontWhiteSmall")
		
				reasonUI[count]:SetPoint("TOP", button)
				reasonUI[count]:SetPoint("BOTTOMRIGHT", button)
				reasonUI[count]:SetJustifyH("LEFT")
			end				

			daysUI[count]:SetWidth(indentUI + 50)
			expUI[count]:SetWidth(indentUI + 90)
			reasonUI[count]:SetWidth(buttonWidth - indentUI - 100)
			
			if count == 1 and FauxScrollFrame_GetOffset(FriendsFrameIgnoreScrollFrame) == 0 then
			
				if headerUI[1] == nil then
					headerUI[1] = button:CreateFontString("FontString", "OVERLAY", "GameFontWhiteSmall")
					
					headerUI[1]:SetPoint("TOP", button)
					headerUI[1]:SetPoint("TOPLEFT", 64, -3)
					headerUI[1]:SetJustifyH("RIGHT")	
				end
				
				local ignoreNum = C_FriendList.GetNumIgnores()
				
				headerUI[1]:SetText("By Account ("..ignoreNum..")")
								
				daysUI[1]:SetText("Days")
				expUI[1]:SetText("Expire")
				reasonUI[1]:SetText("Note")
			
			else
			
				if count == 1 then
					headerUI[1]:SetText("")
				end
								
				playerIndex = hasGlobalIgnored(addServer(button.name:GetText()))
				
				if playerIndex > 0 then			
					daysUI[count]:SetText(daysFromToday(GlobalIgnoreDB.dateList[playerIndex]) .. "d")
				
					local playerExp = (GlobalIgnoreDB.expList[playerIndex] or 0)
					local daysExp   = playerExp - daysFromToday(GlobalIgnoreDB.dateList[playerIndex])
				
					if playerExp == 0 then
						expUI[count]:SetText("|cff808080"..L["EXP_NVR"])
					elseif daysExp <= 0 then
						expUI[count]:SetText("|cffff6666"..L["EXP_TDY"])
					else
						expUI[count]:SetText(daysExp.."d")
					end
					
					reasonUI[count]:SetText("|cff69CCF0"..GlobalIgnoreDB.notes[playerIndex])
				end
			end				
		end
	end
end
