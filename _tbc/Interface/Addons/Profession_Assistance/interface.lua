local L = PA_LOCALIZATION

local buttonCollection = {};
function PA_ButtonControl(ButtonName,state,storedValueName)
	if(ButtonName == "Master") then
		PA_SavedSettings["MasterChecked"] = buttonCollection['MasterButton']:GetChecked();
		
		for key, value in pairs(buttonCollection) do
			local stringIndex = key:find('Key') or key:find('Chat') or key:find('Icon')
			if stringIndex ~= nil and not key:match('ShowAllIcon') then
				local dataLink = key:sub(0, (stringIndex - 1)).."Checked"
				if(state == 'Enable') then value:SetEnabled(PA_SavedSettings[dataLink]); end
				if(state == 'Disable') then value:SetEnabled(false); end
			else
				if (not key:match('Master')) then
					if(state == 'Enable') then value:Enable() end;
					if(state == 'Disable') then value:Disable() end;
				end
			end;
		end;
		
		if(state ~= nil) then
			if(PA_SavedSettings["MinimapChecked"] and PA_Minimap~=nil and PA_Minimap:IsShown()) then PA_Minimap:SetShown(state ~= 'Enabled'); end
			PA_ButtonControl('ShowAllIcon', (PA_SavedSettings["ShowAllIconChecked"] and PA_SavedSettings["MasterChecked"]) and "Enable" or "Disable", nil)
		end
	elseif(ButtonName == "ShowAllIcon") then
		PA_SavedSettings["ShowAllIconChecked"] = buttonCollection['ShowAllIconButton']:GetChecked();

		for key, value in pairs(buttonCollection) do
			local stringIndex = key:find('Icon');
			if stringIndex ~= nil and not key:match('ShowAllIcon') then
				if (state == 'Enable') then value:Enable() end;
				if (state == 'Disable') then value:Disable() end;
			end;
		end;
	else
		if(state == "Enable") then
			PA_SavedSettings[storedValueName] = true;
			if(not ButtonName:match('Chat') and not ButtonName:match('Key') and not ButtonName:match('Icon')) then
				buttonCollection[ButtonName.."ChatButton"]:Enable()
				buttonCollection[ButtonName.."KeyButton"]:Enable()
				buttonCollection[ButtonName.."IconButton"]:Enable()
			end
		end
		if(state == "Disable") then
			PA_SavedSettings[storedValueName] = false;
			if(not ButtonName:match('Chat') and not ButtonName:match('Key') and not ButtonName:match('Icon')) then
				buttonCollection[ButtonName.."ChatButton"]:Disable()
				buttonCollection[ButtonName.."KeyButton"]:Disable()
				buttonCollection[ButtonName.."IconButton"]:Disable()
			end
		end
	end
end
--------------------------
-- Button creator stuff --
--------------------------
local function createCheckButton(parent, x_loc, y_loc, IDname, displayname, description, storedValue)
	local checkbutton = CreateFrame("CheckButton", IDname.."CheckButton", parent);
	checkbutton:SetNormalTexture("Interface/Buttons/UI-CheckBox-Up")
	checkbutton:SetPushedTexture("Interface/Buttons/UI-CheckBox-Down")
	checkbutton:SetHighlightTexture("Interface/Buttons/UI-CheckBox-Highlight","ADD")
	checkbutton:SetCheckedTexture("Interface/Buttons/UI-CheckBox-Check")
	checkbutton:SetDisabledCheckedTexture("Interface/Buttons/UI-CheckBox-Check-Disabled")
	checkbutton:SetPoint("TOPLEFT", x_loc, y_loc);
	checkbutton:SetSize(32,32);
	PA_checkbuttonText = checkbutton:CreateFontString("PA_checkbuttonText", "ARTWORK","GameFontHighlight")
	PA_checkbuttonText:SetText(displayname);
	PA_checkbuttonText:SetPoint("LEFT", "$parent", "RIGHT", 0, 1)
	checkbutton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetText(displayname, nil, nil, nil, nil, 1);
		GameTooltip:AddLine(description, 1.0, 1.0, 1.0, 1.0);
		GameTooltip:Show();
	end)
	checkbutton:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	checkbutton:SetChecked(PA_SavedSettings[storedValue]);
	checkbutton:SetScript("OnClick", function(self)
		PA_SavedSettings[storedValue] = self:GetChecked();
		PA_ButtonControl(IDname,(self:GetChecked() and "Enable" or "Disable"), storedValue);
	end);
	return checkbutton;
end

----------------------------
-- FontText creator stuff --
----------------------------
local function createFonttext(parent, x_loc, y_loc, text, fonttemplate)
	local title = parent:CreateFontString(nil, "ARTWORK", fonttemplate);
	title:SetPoint("TOPLEFT", x_loc, y_loc);
	title:SetJustifyH("LEFT");
	title:SetText(text);
end

-------------------
-- Minimap stuff --
-------------------
local function moveMinimapButton(self)
	local centerX, centerY = Minimap:GetCenter()
	local x, y = GetCursorPosition()
	x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
	centerX, centerY = math.abs(x), math.abs(y)
	centerX, centerY = (centerX / math.sqrt(centerX^2 + centerY^2)) * 80, (centerY / sqrt(centerX^2 + centerY^2)) * 80
	centerX = x < 0 and -centerX or centerX
	centerY = y < 0 and -centerY or centerY
	self:ClearAllPoints()
	self:SetPoint("CENTER", centerX, centerY)
	PA_SavedSettings["Minimap_PosX"] = centerX
	PA_SavedSettings["Minimap_PosY"] = centerY
end

local function PA_Minimap_Create()
	PA_Minimap = CreateFrame("Button", "Profession Assistance", Minimap)
	PA_Minimap:SetSize(31, 31)
	PA_Minimap:SetFrameStrata("MEDIUM")
	PA_Minimap:SetPoint("CENTER", PA_SavedSettings["Minimap_PosX"], PA_SavedSettings["Minimap_PosY"])
	PA_Minimap:SetMovable(true)
	PA_Minimap:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	
	local buttonOverlay = PA_Minimap:CreateTexture(nil, "OVERLAY")
	buttonOverlay:SetSize(53, 53)
	buttonOverlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	buttonOverlay:SetPoint("TOPLEFT")
	
	local buttonIcon = PA_Minimap:CreateTexture(nil, "ARTWORK")
	buttonIcon:SetSize(18.5, 18.5)
	buttonIcon:SetTexture("Interface\\ICONS\\INV_Hammer_20")
	buttonIcon:SetPoint("TOPLEFT", 7, -5.5)
	
	PA_Minimap:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			buttonIcon:SetPoint("TOPLEFT", 7, -5.5)
			buttonIcon:SetSize(18,18)
			PA_Panel:Show();
		else
			if IsShiftKeyDown() then
				buttonIcon:SetPoint("TOPLEFT", 7, -5.5)
				buttonIcon:SetSize(18,18)
				self:SetScript("OnUpdate", moveMinimapButton)
			end
		end
	end)
	PA_Minimap:SetScript("OnMouseUp", function(self)
		self:SetScript("OnUpdate", nil)
		buttonIcon:SetSize(18.5,18.5)
		buttonIcon:SetPoint("TOPLEFT", 7, -5.5)
	end)
	
	PA_Minimap:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self,"ANCHOR_BOTTOMLEFT")
		GameTooltip:SetText("Profession Assistance", nil, nil, nil, 1, 1)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("|cff00ff00Left-click|r to open interface panel.", 1, 1, 1)
		GameTooltip:AddLine("|cff00ff00Shift+Right-hold|r to drag this icon.", 1, 1, 1)
		GameTooltip:Show()
	end)
	PA_Minimap:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	
	if(buttonCollection['MinimapButton']:IsEnabled() and buttonCollection['MinimapButton']:GetChecked()) then PA_Minimap:Show() else PA_Minimap:Hide() end
	buttonCollection['MinimapButton']:SetScript("OnClick", function(self)
		if(PA_Minimap:IsShown()) then PA_Minimap:SetShown(false) else PA_Minimap:Show() end
		PA_SavedSettings["MinimapChecked"] = self:GetChecked();
	end);
end

-- --------------------------
-- -- Interface AddOns tab --
-- --------------------------
local PA_InterfaceFrame = CreateFrame("Frame")
PA_InterfaceFrame:RegisterEvent("PLAYER_LOGIN");
PA_InterfaceFrame:SetScript("OnEvent", function(self,event,...)
	if(type(PA_SavedSettings) ~= "table") then PA_SavedSettings = {} end
	
	-- Global tab
	if(PA_SavedSettings["MasterChecked"] == nil) then PA_SavedSettings["MasterChecked"] = true end
	if(PA_SavedSettings["ShowAllIconChecked"] == nil) then PA_SavedSettings["ShowAllIconChecked"] = true end
	
	if(PA_SavedSettings["MinimapChecked"] == nil) then PA_SavedSettings["MinimapChecked"] = true end
	if(PA_SavedSettings["Minimap_PosX"] == nil) then PA_SavedSettings["Minimap_PosX"] = -78.5 end
	if(PA_SavedSettings["Minimap_PosY"] == nil) then PA_SavedSettings["Minimap_PosY"] = -16 end
	
	-- Professions tab
	-- Herbalism
	if(PA_SavedSettings["HerbalismChecked"] == nil) then PA_SavedSettings["HerbalismChecked"] = true end
	if(PA_SavedSettings["HerbalismChatChecked"] == nil) then PA_SavedSettings["HerbalismChatChecked"] = true end
	if(PA_SavedSettings["HerbalismKeyChecked"] == nil) then PA_SavedSettings["HerbalismKeyChecked"] = true end
	if(PA_SavedSettings["HerbalismKey"] == nil) then PA_SavedSettings["HerbalismKey"] = false end
	
	-- Milling
	if(PA_SavedSettings["MillingChecked"] == nil) then PA_SavedSettings["MillingChecked"] = true end
	if(PA_SavedSettings["MillingChatChecked"] == nil) then PA_SavedSettings["MillingChatChecked"] = true end
	if(PA_SavedSettings["MillingKey"] == nil) then PA_SavedSettings["MillingKey"] = false end
	if(PA_SavedSettings["MillingIcon"] == nil) then PA_SavedSettings["MillingIcon"] = false end
	
	if(PA_SavedSettings["HerbChecked"] == nil) then PA_SavedSettings["HerbChecked"] = true end
	if(PA_SavedSettings["HerbChatChecked"] == nil) then PA_SavedSettings["HerbChatChecked"] = true end
	if(PA_SavedSettings["HerbKey"] == nil) then PA_SavedSettings["HerbKey"] = false end
	if(PA_SavedSettings["HerbIcon"] == nil) then PA_SavedSettings["HerbIcon"] = false end
	
	-- Mining
	if(PA_SavedSettings["MiningChecked"] == nil) then PA_SavedSettings["MiningChecked"] = true end
	if(PA_SavedSettings["MiningChatChecked"] == nil) then PA_SavedSettings["MiningChatChecked"] = true end
	if(PA_SavedSettings["MiningKey"] == nil) then PA_SavedSettings["MiningKey"] = false end
	
	-- Prospecting
	if(PA_SavedSettings["ProspectingChecked"] == nil) then PA_SavedSettings["ProspectingChecked"] = true end
	if(PA_SavedSettings["ProspectingChatChecked"] == nil) then PA_SavedSettings["ProspectingChatChecked"] = true end
	if(PA_SavedSettings["ProspectingKey"] == nil) then PA_SavedSettings["ProspectingKey"] = false end
	if(PA_SavedSettings["ProspectingIcon"] == nil) then PA_SavedSettings["ProspectingIcon"] = false end
	
	if(PA_SavedSettings["OreChecked"] == nil) then PA_SavedSettings["OreChecked"] = true end
	if(PA_SavedSettings["OreChatChecked"] == nil) then PA_SavedSettings["OreChatChecked"] = true end
	if(PA_SavedSettings["OreKey"] == nil) then PA_SavedSettings["OreKey"] = false end
	if(PA_SavedSettings["OreIcon"] == nil) then PA_SavedSettings["OreIcon"] = false end
	
	-- Enchanting
	if(PA_SavedSettings["EnchantingChecked"] == nil) then PA_SavedSettings["EnchantingChecked"] = true end
	if(PA_SavedSettings["EnchantingChatChecked"] == nil) then PA_SavedSettings["EnchantingChatChecked"] = true end
	if(PA_SavedSettings["EnchantingKey"] == nil) then PA_SavedSettings["EnchantingKey"] = false end
	if(PA_SavedSettings["EnchantingIcon"] == nil) then PA_SavedSettings["EnchantingIcon"] = false end
	
	if(PA_SavedSettings["MaterialChecked"] == nil) then PA_SavedSettings["MaterialChecked"] = true end
	if(PA_SavedSettings["MaterialChatChecked"] == nil) then PA_SavedSettings["MaterialChatChecked"] = true end
	if(PA_SavedSettings["MaterialKey"] == nil) then PA_SavedSettings["MaterialKey"] = false end
	if(PA_SavedSettings["MaterialIcon"] == nil) then PA_SavedSettings["MaterialIcon"] = false end
	
	------------------
	-- Layout panel --
	------------------
	PA_Panel = CreateFrame( "Frame", "PA_Panel", UIParent, BackdropTemplateMixin and "BackdropTemplate");
	PA_Panel:SetBackdrop({
		bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
		edgeFile = "Interface/DialogFrame/UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 11, right = 11, top = 12, bottom = 10 }
	});
	
	PA_Panel:SetFrameStrata("MEDIUM");
	PA_Panel:SetPoint("CENTER",0,0);
	PA_Panel:SetSize(824,568);
	PA_Panel:SetClampedToScreen(true);
	PA_Panel:EnableMouse(true);
	tinsert(UISpecialFrames, PA_Panel:GetName()); -- Makes it able to close when ESC is pressed
	
	PA_Panel:CreateTexture("$parentHeader", "ARTWORK");
	PA_PanelHeader:SetTexture("Interface/DialogFrame/UI-DialogBox-Header");
	PA_PanelHeader:SetSize(300,68);
	PA_PanelHeader:SetPoint("TOP",0,12);
	PA_Panel:CreateFontString("$parentHeaderText","ARTWORK","GameFontNormal");
	PA_PanelHeaderText:SetPoint("TOP","$parentHeader","TOP",0,-14);
	PA_PanelHeaderText:SetText("Profession Assistance");
	
	PA_Panel_Button = CreateFrame("BUTTON", "$parent_Button", PA_Panel, "UIPanelButtonTemplate");
	PA_Panel_Button:SetPoint("BOTTOMRIGHT",-22,15);
	PA_Panel_Button:SetWidth(100);
	PA_Panel_Button:SetText("Close");
	PA_Panel_Button:SetScript("OnClick", function(self) PA_Panel:Hide(); end);
	
	--Hide it because we don't need to see it straight away!
	PA_Panel:Hide();
	
	-- Show the panel with slash command
	SLASH_PA1,SLASH_PA2,SLASH_PA3 = '/'..L["PA"],'/Profesion Assistance','/Profession_Assistance';
	function SlashCmdList.PA() PA_Panel:Show(); end
	
	-----------------------
	-- Categories frames --
	-----------------------
	PA_Panel_Categories = CreateFrame( "Frame", "$parent_Categories", PA_Panel, BackdropTemplateMixin and "BackdropTemplate");
	PA_Panel_Categories:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tileSize = 16, edgeSize = 16,});
	PA_Panel_Categories:SetSize(780,489);
	PA_Panel_Categories:SetPoint("TOPLEFT",22,-40);
	
	-----------------
	-- create tabs --
	-----------------
	PA_Panel_Categories.selectedTab = 1;
	PA_Panel_Categories.subFrames = {};
	PA_Panel_Categories.name = PA_Panel_Categories:GetName();
	
	PA_Panel_Categories.showSubFrame = function(name)
		for index, value in pairs(PA_Panel_Categories.subFrames) do
			if("$parentTab"..index == "$parentTab"..PA_Panel_Categories.selectedTab) then
				_G[value]:Show();
			else _G[value]:Hide(); end
		end
	end
	
	local setPanel = function(panel,id)
		if(id) then PanelTemplates_SetTab(panel, id); end
		PanelTemplates_UpdateTabs(panel);
		panel.showSubFrame(panel.name.."Tab"..panel.selectedTab);
	end
	
	local createTab = function(parent, index, name)
		local tab = CreateFrame("Button", "$parentTab"..index, parent, "OptionsFrameTabButtonTemplate");
		tab.id = index;
		tab:SetWidth(50);
		if index == 1 then tab:SetPoint("TOPLEFT",5,24); else tab:SetPoint("LEFT", "$parentTab"..index-1, "RIGHT", -15, 0); end
		tab:HookScript("OnClick", function(self) setPanel(self:GetParent(), self.id); end);
		tab:SetText(L[string.sub(name,string.len(parent.name)+2)]);
		PanelTemplates_TabResize(tab);
	end
	
	--create subframes
	local createSubFrame = function(parent, name)
		local subframe = CreateFrame("Frame", "$parent_"..name, parent);
		subframe:SetAllPoints();
		tinsert(parent.subFrames,subframe:GetName());
	end
	
	-- createSubFrame(parent,name)
	createSubFrame(PA_Panel_Categories, "Main");
	createSubFrame(PA_Panel_Categories, "Global");
	createSubFrame(PA_Panel_Categories, "Professions");
	PA_Panel_Categories.numTabs = #PA_Panel_Categories.subFrames;
	
	for i = 1, PA_Panel_Categories.numTabs do
		--createTab(Parent,Index,Name)
		createTab(PA_Panel_Categories,i,PA_Panel_Categories.subFrames[i]);
	end
	
	setPanel(PA_Panel_Categories);
	PA_Panel_Categories:HookScript("OnShow",setPanel);
	
	-- Main panel
	
	-- title
	--createFonttext(Parent, Positionx, Positiony, text, template)
	createFonttext(PA_Panel_Categories_Main, 15, -15, "Profession Assistance", "GameFontNormalLarge");
	
	local translatorNote = [[
|cffffcc00Special thanks to the following people for translating:|r
Kad_Caiel
XingDvD
hideki66687653
laruskane
x_RazzorX_x
ScaXFuLL
Vanyshing
Donghaerang
Naodtome
아련별
arhkeis
dadec666
takasun39
BNS333
lovesingcat
]]
	
	-- content
	createFonttext(PA_Panel_Categories_Main, 20, -40, "|cffffcc00Version|r     "..C_AddOns.GetAddOnMetadata("Profession_Assistance","Version"), "GameFontHighlight");
	createFonttext(PA_Panel_Categories_Main, 20, -55, "|cffffcc00Notes|r       "..C_AddOns.GetAddOnMetadata("Profession_Assistance","Notes"), "GameFontHighlight");
	createFonttext(PA_Panel_Categories_Main, 20, -85, "|cffffcc00Author|r      "..C_AddOns.GetAddOnMetadata("Profession_Assistance","Author"), "GameFontHighlight");
	createFonttext(PA_Panel_Categories_Main, 20, -100, "|cffffcc00Credits|r     "..C_AddOns.GetAddOnMetadata("Profession_Assistance","X-Credits"), "GameFontHighlight");
	createFonttext(PA_Panel_Categories_Main, 20, -115, translatorNote, "GameFontHighlight");
	
	-- Options panel
	
	-- title
	createFonttext(PA_Panel_Categories_Global, 15, -15, L["Options"], "GameFontNormalLarge");
	
	-- Options panel
	
	-- title
	createFonttext(PA_Panel_Categories_Professions, 15, -15, L["Professions"], "GameFontNormalLarge");
	
	Frame_Profession = PA_Panel_Categories_Professions
	-- global
	createFonttext(PA_Panel_Categories_Global, 20, -60, "|cffffcc00"..L["Global"].."|r", "GameFontNormalLarge");
	-- createCheckButton(Parent, Positionx, positiony, label, description);
	buttonCollection['MasterButton'] = createCheckButton(PA_Panel_Categories_Global, 15, -80, "Master", L["Enable Master"], L["Master switch"], "MasterChecked");
	
	buttonCollection['ShowAllIconButton'] = createCheckButton(PA_Panel_Categories_Global, 15, -110, "ShowAllIcon", L["Show Icons"], L["Show icons in front of result items"], "ShowAllIconChecked");
	
	-- Minimap
	createFonttext(PA_Panel_Categories_Global, 20, -160, "|cffffcc00"..L["Minimap Button"].."|r", "GameFontNormalLarge");
	buttonCollection['MinimapButton'] = createCheckButton(PA_Panel_Categories_Global, 15, -180, "Minimap", L["Enable Minimap"], L["Toggle minimap button"], "MinimapChecked");
	
	-- Herbalism Locations
	createFonttext(PA_Panel_Categories_Professions, 20, -60, "|cffffcc00"..L["Herbalism Locations"].."|r", "GameFontNormalLarge")	;
	buttonCollection['HerbalismButton'] = createCheckButton(Frame_Profession, 15, -80, "Herbalism", L["Enable Herbalism"], L["Toggle herbalism locations on herbs"], "HerbalismChecked");
	
	buttonCollection['HerbalismChatButton'] = createCheckButton(Frame_Profession, 255, -80, "HerbalismChat", L["Enable chat"], L["Toggle chat herbalism locations on herbs"], "HerbalismChatChecked");
	
	createFonttext(Frame_Profession, 20, -115, L["Shown when"]..": ", "GameFontNormalSmall");
	buttonCollection['HerbalismKeyButton'] = createCheckButton(Frame_Profession, 15, -130, "HerbalismKey", L["On Shift"], L["Hold Shift to show Herbalism locations"], "HerbalismKey")
	
	-- Milling
	createFonttext(Frame_Profession, 420, -60, "|cffffcc00"..L["Milling"].."|r", "GameFontNormalLarge")	;
	buttonCollection['MillingButton'] = createCheckButton(Frame_Profession, 415, -80, "Milling", L["Enable Milling"], L["Toggle milling information on herbs"], "MillingChecked");
	buttonCollection['MillingChatButton'] = createCheckButton(Frame_Profession, 655, -80, "MillingChat", L["Enable chat"], L["Toggle chat information on herbs"], "MillingChatChecked");
	
	createFonttext(Frame_Profession, 420, -115, L["Shown when"]..": ", "GameFontNormalSmall");
	buttonCollection['MillingKeyButton'] = createCheckButton(Frame_Profession, 415, -130, "MillingKey", L["On Shift"], L["Hold Shift to show Milling information"], "MillingKey")
	
	buttonCollection['MillingIconButton'] = createCheckButton(Frame_Profession, 655, -130, "MillingIcon", L["Show Icons"], L["Show icons in front of result items"], "MillingIconChecked");
	
	buttonCollection['HerbButton'] = createCheckButton(Frame_Profession, 415, -170, "Herb", L["Enable Herb"], "Toggle herb information on pigments", "HerbChecked");
	buttonCollection['HerbChatButton'] = createCheckButton(Frame_Profession, 655, -170, "HerbChat", L["Enable chat"], L["Toggle chat information on pigments"], "HerbChatChecked");
	
	createFonttext(Frame_Profession, 420, -205, L["Shown when"]..": ", "GameFontNormalSmall");
	buttonCollection['HerbKeyButton'] = createCheckButton(Frame_Profession, 415, -220, "HerbKey", L["On Shift"], L["Hold Shift to show Herb information"], "HerbKey")
	
	buttonCollection['HerbIconButton'] = createCheckButton(Frame_Profession, 655, -220, "HerbIcon", L["Show Icons"], L["Show icons in front of result items"], "HerbIconChecked");
	
	-- Mining Locations
	createFonttext(Frame_Profession, 20, -170, "|cffffcc00"..L["Mining Locations"].."|r", "GameFontNormalLarge");
	buttonCollection['MiningButton'] = createCheckButton(Frame_Profession, 15, -190, "Mining", L["Enable Mining"], L["Toggle mining locations on ores"], "MiningChecked");
	buttonCollection['MiningChatButton'] = createCheckButton(Frame_Profession, 255, -190, "MiningChat", L["Enable chat"], L["Toggle chat mining locations on ores"], "MiningChatChecked");
	
	createFonttext(Frame_Profession, 20, -225, L["Shown when"]..": ", "GameFontNormalSmall");
	buttonCollection['MiningKeyButton'] = createCheckButton(Frame_Profession, 15, -240, "MiningKey", L["On Shift"], L["Hold Shift to show Mining locations"], "MiningKey")
	
	-- Prospecting
	createFonttext(Frame_Profession, 20, -280, "|cffffcc00"..L["Prospecting"].."|r", "GameFontNormalLarge");
	buttonCollection['ProspectingButton'] = createCheckButton(Frame_Profession, 15, -300, "Prospecting", L["Enable Prospecting"], L["Toggle prospecting information on ores"], "ProspectingChecked");
	buttonCollection['ProspectingChatButton'] = createCheckButton(Frame_Profession, 255, -300, "ProspectingChat", L["Enable chat"], L["Toggle chat information on ores"], "ProspectingChatChecked");
	
	createFonttext(Frame_Profession, 20, -335, L["Shown when"]..": ", "GameFontNormalSmall");
	buttonCollection['ProspectingKeyButton'] = createCheckButton(Frame_Profession, 15, -350, "ProspectingKey", L["On Shift"], L["Hold Shift to show Prospecting information"], "ProspectingKey")
	
	buttonCollection['ProspectingIconButton'] = createCheckButton(Frame_Profession, 255, -350, "ProspectingIcon", L["Show Icons"], L["Show icons in front of result items"], "ProspectingIconChecked");
	
	buttonCollection['OreButton'] = createCheckButton(Frame_Profession, 15, -390, "Ore", L["Enable Ore"], L["Toggle ore information on gems"], "OreChecked");
	buttonCollection['OreChatButton'] = createCheckButton(Frame_Profession, 255, -390, "OreChat", L["Enable chat"], L["Toggle chat information on gems"], "OreChatChecked");
	
	createFonttext(Frame_Profession, 20, -425, L["Shown when"]..": ", "GameFontNormalSmall");
	buttonCollection['OreKeyButton'] = createCheckButton(Frame_Profession, 15, -440, "OreKey", L["On Shift"], L["Hold Shift to show Ore information"], "OreKey")
	
	buttonCollection['OreIconButton'] = createCheckButton(Frame_Profession, 255, -440, "OreIcon", L["Show Icons"], L["Show icons in front of result items"], "OreIconChecked");
	
	-- Enchanting
	createFonttext(Frame_Profession, 420, -280, "|cffffcc00"..L["Enchanting"].."|r", "GameFontNormalLarge");
	
	buttonCollection['EnchantingButton'] = createCheckButton(Frame_Profession, 415, -390, "Enchanting", L["Enable Enchanting"], L["Toggle Disenchanting information on gear"], "EnchantingChecked");
	buttonCollection['EnchantingChatButton'] = createCheckButton(Frame_Profession, 655, -390, "EnchantingChat", L['Enable chat'], L["Toggle chat information on gear"], "EnchantingChatChecked");
	
	createFonttext(Frame_Profession, 420, -335, L['Shown when']..': ', "GameFontNormalSmall");
	buttonCollection['EnchantingKeyButton'] = createCheckButton(Frame_Profession, 415, -440, "EnchantingKey", L['On Shift'], L["Hold Shift to show Disenchanting information"], "EnchantingKey")
	
	buttonCollection['EnchantingIconButton'] = createCheckButton(Frame_Profession, 655, -440, "EnchantingIcon", L["Show Icons"], L["Show icons in front of result items"], "EnchantingIconChecked");
	
	buttonCollection['MaterialButton'] = createCheckButton(Frame_Profession, 415, -300, "Material", L["Enable Materials"], L["Toggle gear source information on enchanting materials"], "MaterialChecked");
	buttonCollection['MaterialChatButton'] = createCheckButton(Frame_Profession, 655, -300, "MaterialChat", L["Enable chat"], L["Toggle chat information on enchanting materials"], "MaterialChatChecked");
	
	createFonttext(Frame_Profession, 420, -335, L["Shown when"]..": ", "GameFontNormalSmall");
	buttonCollection['MaterialKeyButton'] = createCheckButton(Frame_Profession, 415, -350, "MaterialKey", L["On Shift"], L["Hold Shift to show Material information"], "MaterialKey");
	
	buttonCollection['MaterialIconButton'] = createCheckButton(Frame_Profession, 655, -350, "MaterialIcon", L["Show Icons"], L["Show icons in front of result items"], "MaterialIconChecked");
	
	-- Minimap button
	PA_Minimap_Create()
	
	---------------------------
	-- Changing settings part --
	---------------------------
	-- Master button
	--PA_ButtonControl(ButtonName,state, settingsValue)
	-- \/ is to check upon start up
	PA_ButtonControl("Master",PA_SavedSettings["MasterChecked"] and "Enable" or "Disable", nil)
	
	for key, value in pairs(buttonCollection) do
		local stringIndex = key:find('Key') or key:find('Chat');
		if stringIndex ~= nil then
			local buttonLink = key:sub(0, (stringIndex - 1)).."Button"
			value:SetEnabled((buttonCollection[buttonLink]:GetChecked() and buttonCollection[buttonLink]:IsEnabled()))
		end
		
	end;
end);