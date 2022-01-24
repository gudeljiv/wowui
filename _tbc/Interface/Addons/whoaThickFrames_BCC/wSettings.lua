whoa = {}
cfg = {}
whoaAddon = "whoaThickFrames_BCC";
local addonName = GetAddOnMetadata(""..whoaAddon.."", "title")
local addonVer = GetAddOnMetadata(""..whoaAddon.."", "version")

-- whoa default settings.
local function loadDefaults()
	if cfg.cfg == nil then cfg.cfg = true; end
	if cfg.smallAuraSize == nil then cfg.smallAuraSize = 20; end
	if cfg.largeAuraSize == nil then cfg.largeAuraSize = 27; end
	if cfg.classColor == nil then cfg.classColor = true; end
	if cfg.reactColor == nil then cfg.reactColor = true; end
	if cfg.blizzColors == nil then cfg.blizzColors = false; end
	if cfg.usePartyFrames == nil then cfg.usePartyFrames = true; end
	if cfg.showPartyPets == nil then cfg.showPartyPets = false; end
	if cfg.bigAuras == nil then cfg.bigAuras = true; end
	if cfg.useBossFrames == nil then cfg.useBossFrames = true; end
	if cfg.whoaTexture == nil then cfg.whoaTexture = true; end
	if cfg.whoaTextureIndex == nil then cfg.whoaTextureIndex = 1; end
	if cfg.noClickFrame == nil then cfg.noClickFrame = false;	end
	if cfg.SBTextureName == nil then cfg.SBTextureName = "whoa";	end
	if cfg.selectedTexture == nil then cfg.selectedTexture = 5;	end
	if cfg.frameMode == nil then cfg.frameMode = "light";	end
	if cfg.darkFrames == nil then cfg.darkFrames = false;	end
	if cfg.minimapZoom == nil then cfg.minimapZoom = true;	end
	if cfg.playerNameHide == nil then cfg.playerNameHide = false; end
	if cfg.fontFamily == nil then cfg.fontFamily = "SystemFont_Outline_Small"; end
	if cfg.fontIndex == nil then cfg.fontIndex = 1; end
	if cfg.playerFrameIndex == nil then cfg.playerFrameIndex = 1 end
	-- cfg.playerFrameSelect = "UI-TargetingFrame";
end
loadDefaults()
local function loadSettings()
	if cfg.classColor==true then whoaCheckButton2:SetChecked(true) end
	if cfg.playerNameHide == true then whoaCheckButton3:SetChecked(true) end
	if cfg.reactColor == true then whoaCheckButton4:SetChecked(true) end
	if cfg.blizzColors == true then whoaCheckButton5:SetChecked(true) end
	if cfg.bigAuras == true then whoaCheckButton6:SetChecked(true) end
	-- if cfg.styleFont == true then whoaCheckButton7:SetChecked(true) end
	-- if cfg.usePartyFrames == true then whoaCheckButton7:SetChecked(true) end
	if cfg.darkFrames == true then whoaCheckButton7:SetChecked(true) end
	if cfg.usePartyFrames == true then whoaCheckButton8:SetChecked(true) end
	-- if cfg.comboPointFrame == true then whoaCheckButton9:SetChecked(true) end
	-- if cfg.threatShowNumeric == true then whoaCheckButton10:SetChecked(true) end
	if cfg.showPartyPets == true then whoaCheckButton9:SetChecked(true) end
	if cfg.minimapZoom == true then whoaCheckButton10:SetChecked(true) end
	if cfg.noClickFrame == true then whoaCheckButton11:SetChecked(true) end
end

function SBTexturesDo()
	for i, v in pairs ({ PlayerFrameHealthBar, PlayerFrameManaBar, PlayerFrameHealthBar.AnimatedLossBar, PlayerFrameAlternateManaBar,
		PetFrameHealthBar, PetFrameManaBar, TargetFrameHealthBar, TargetFrameManaBar, FocusFrameHealthBar,
		FocusFrameManaBar, TargetFrameToTHealthBar, FocusFrameToTHealthBar }) do
		v:SetStatusBarTexture("Interface\\Addons\\"..whoaAddon.."\\media\\statusbar\\"..cfg.SBTextureName); end
	for i, v in pairs ({ PlayerFrameMyHealPredictionBar, }) do
		v:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\statusbar\\"..cfg.SBTextureName); end
	for i = 1, 4 do
		if _G["PartyMemberFrame"..i] then
			_G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarTexture("Interface\\Addons\\"..whoaAddon.."\\media\\statusbar\\"..cfg.SBTextureName);
			_G["PartyMemberFrame"..i.."ManaBar"]:SetStatusBarTexture("Interface\\Addons\\"..whoaAddon.."\\media\\statusbar\\"..cfg.SBTextureName)
		end
	end
end

function playerFrameDo()
	local path = cfg.frameMode;
	local frameType;
	
	if cfg.playerFrameIndex == 2 then
		frameType = "UI-TargetingFrame-Elite"
	elseif cfg.playerFrameIndex == 3 then
		frameType = "UI-TargetingFrame-Rare"
	elseif cfg.playerFrameIndex == 4 then
		frameType = "UI-TargetingFrame-Rare-Elite"
	else
		frameType = "UI-TargetingFrame";
	-- 
	end
	
	PlayerFrameTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\"..frameType);
end

function dynamicFramesDo(self, unit)
	local path = cfg.frameMode;
	
	if self then
		local classification = UnitClassification(self.unit);
		if ( classification == "worldboss" or classification == "elite" ) then
			self.borderTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetingFrame-Elite");
		elseif ( classification == "rareelite" ) then
			self.borderTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetingFrame-Rare-Elite");
		elseif ( classification == "rare" ) then
			self.borderTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetingFrame-Rare");
		else
			self.borderTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetingFrame");
		end
		if ( self.showPVP ) then
			local factionGroup = UnitFactionGroup(self.unit);
			if ( UnitIsPVPFreeForAll(self.unit) ) then
					self.pvpIcon:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-PVP-FFA");
			elseif ( factionGroup and factionGroup ~= "Neutral" and UnitIsPVP(self.unit) ) then
					self.pvpIcon:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-PVP-"..factionGroup);
			end
		end
	end
end

function darkFramesDo(self)
	local path = cfg.frameMode;
	PetFrameTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-SmallTargetingFrame");
	TargetFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetofTargetFrame");
	FocusFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetofTargetFrame");
end

local function fontStyleDo()
	local font = cfg.fontFamily;
	if font == nil then
		font = "SystemFont_Outline_Small";
	end
	for i, v in pairs({	PlayerFrameHealthBarText, PlayerFrameHealthBarTextLeft,	PlayerFrameHealthBarTextRight,
		PlayerFrameManaBarTextLeft,	PlayerFrameManaBarTextRight, PlayerFrameManaBarText, TargetFrameTextureFrame.HealthBarText,
		TargetFrameTextureFrame.HealthBarTextLeft, TargetFrameTextureFrame.HealthBarTextRight, TargetFrameTextureFrame.ManaBarText, 
		TargetFrameTextureFrame.ManaBarTextLeft, TargetFrameTextureFrame.ManaBarTextRight, FocusFrameTextureFrame.HealthBarText, 
		FocusFrameTextureFrame.HealthBarTextLeft,	FocusFrameTextureFrame.HealthBarTextRight, FocusFrameTextureFrame.ManaBarText,
		FocusFrameTextureFrame.ManaBarTextLeft,	FocusFrameTextureFrame.ManaBarTextRight, PetFrameHealthBarText, PetFrameHealthBarTextLeft, 
		PetFrameHealthBarTextRight, PetFrameManaBarText, PetFrameManaBarTextLeft, PetFrameManaBarTextRight, }) do 
		if v then v:SetFontObject(font); end
	end
end

-- Font strings factory
function whoa:CreateFont(frame, name, text, x, y, font, size )
	if size == nil then size = 15 end
	if font == nil then font = STANDARD_TEXT_FONT end
	local fontString = frame:CreateFontString(name) fontString:SetPoint("TOPLEFT", x, y) fontString:SetFont(font, size, "") fontString:SetText(text)
	return (fontString)
end

-- Checkbuttons factory.
local uniquealyzer = 1;
local function createCheckbutton(parent, x_loc, y_loc, displayname)
	uniquealyzer = uniquealyzer + 1;
	local checkbutton = CreateFrame("CheckButton", "whoaCheckButton" .. uniquealyzer, parent, "ChatConfigCheckButtonTemplate");
	checkbutton:SetPoint("TOPLEFT", x_loc, y_loc);
	getglobal(checkbutton:GetName() .. 'Text'):SetText(displayname);
	return checkbutton;
end

-- Buttons factory.
function whoa:CreateButton(frame, name, text, width, height, x, y, template)
	if (template == nil) then template = "OptionsButtonTemplate" end
	local button = CreateFrame("Button", name, frame, template) button:SetPoint("TOPLEFT", x, y) button:SetWidth(width)
	button:SetHeight(height) button:SetText(text)
	return (button)
end

-- Disable/enable unit frames click interaction.
function disableFramesClick()
	if (cfg.noClickFrame == true) then
		for i, v in pairs({	PlayerFrame, PetFrame, TargetFrame, FocusFrame }) do v:SetMouseClickEnabled(false); end
	elseif (cfg.noClickFrame == false) then
		for i, v in pairs({	PlayerFrame, PetFrame, TargetFrame, FocusFrame }) do v:SetMouseClickEnabled(true); end
	end
end

-- Mouse wheel minimap zoom.
function minimapZoomHack()
	if (cfg.minimapZoom == true) then
		Minimap:EnableMouseWheel(true)
		Minimap:SetScript("OnMouseWheel", function(mp, input)
		local zoom = Minimap:GetZoom()
			if input > 0 and zoom < 5 then
				mp:SetZoom(zoom +1)
			elseif input < 0 and zoom > 0 then
				mp:SetZoom(zoom -1)
			end
			C_Timer.After(10, function()
				mp:SetZoom(0)
			end)
		end)
	elseif (cfg.minimapZoom == false) then
		Minimap:SetScript("OnMouseWheel", nil)
		Minimap:SetZoom(0)
	end
end

optionUI = {}
optionUI.panel = CreateFrame( "Frame", "optionUI", UIParent );
optionUI.panel.name = GetAddOnMetadata(""..whoaAddon.."", "X-Menu");
InterfaceOptions_AddCategory(optionUI.panel);

--	Option panel frame.
local whoaMenu = CreateFrame("Frame", "myframe", UIParent);
whoaMenu:RegisterEvent("PLAYER_LOGIN")
whoaMenu:SetScript("OnEvent", function(self)

	local title = whoa:CreateFont(optionUI.panel, "title", ""..addonName..addonVer.."", 15, -18, font, 15)
	title:SetFontObject(GameFontNormal)
	title:SetPoint("LEFT",optionUI.panel,"TOPLEFT",0,0)
	-- local disclaimer = whoa:CreateFont(optionUI.panel, "disclaimer", "Most options require a reload (/rl) for correct aplication of changes.", 15, -40, font, 12)
	-- disclaimer:SetPoint("LEFT",optionUI.panel,"TOPLEFT",0,0)

	local xOffset = -80;
	--	Class colors.
	myCheckButton = createCheckbutton(optionUI.panel, 40, xOffset, " Players class colores.");
	myCheckButton.tooltip = " Non players health bars colored by class.";
	myCheckButton:SetScript("OnClick",
	function(self)
		if whoaCheckButton2:GetChecked() then
			cfg.classColor = true;
		else
			cfg.classColor = false;
		end
	end );
		--	Player name hide
	myCheckButton = createCheckbutton(optionUI.panel, 300, xOffset, "  Hide player name.");
	myCheckButton.tooltip = "Hides player name over player frame.";
	myCheckButton:SetScript("OnClick",
	function(self)
		if whoaCheckButton3:GetChecked() then
			cfg.playerNameHide = true;
			playerNameHide()
		else
			cfg.playerNameHide = false;
			playerNameHide()
		end
	end );
	--	Reaction colors
	myCheckButton = createCheckbutton(optionUI.panel, 40, xOffset-30, " Unit reaction colors");
	myCheckButton.tooltip = "Non players health bars colored by reaction or RPG.";
	myCheckButton:SetScript("OnClick",
	function(self)
		if whoaCheckButton4:GetChecked() then
			cfg.reactColor = true;
		else
			cfg.reactColor = false;
			cfg.blizzColors = false;
			whoaCheckButton5:SetChecked(false);
		end
	end );
	--	Bright reaction colors.
	myCheckButton = createCheckbutton(optionUI.panel, 300, xOffset-30, " Use Blizzards reaction colors.");
	myCheckButton.tooltip = "Set reaction colot palette WoW default making it brighter.";
	myCheckButton:SetScript("OnClick",
	function(self)
		if whoaCheckButton5:GetChecked() then
			cfg.reactColor = true;
			cfg.blizzColors = true;
			whoaCheckButton4:SetChecked(true);
		else
			cfg.blizzColors = false;
			whoaCheckButton5:SetChecked(false);
		end
	end );
	--	Aura size.
	myCheckButton = createCheckbutton(optionUI.panel, 40, xOffset-60, " Enlarge buff and debuff icons.");
	myCheckButton.tooltip = "Enlarges buff and debuff icons on target and focus frames.";
	myCheckButton:SetScript("OnClick",
	function(self)
		if whoaCheckButton6:GetChecked() then
			cfg.largeAuraSize = 28;
			cfg.smallAuraSize = 24;
			cfg.bigAuras = true;
		else
			cfg.largeAuraSize = 21;
			cfg.smallAuraSize = 17;
			cfg.bigAuras = false;
		end
	end );
	
	-- --	Blizzard status text.
	-- myCheckButton = createCheckbutton(optionUI.panel, 300, xOffset-60, "Use retail font style.");
	-- -- myCheckButton:SetEnabled(false);
	-- myCheckButton.tooltip = "Displays Blizzard´s default font style for player and target frames status text.";
	-- myCheckButton:SetScript("OnClick",
	-- function(self)
		-- if whoaCheckButton7:GetChecked() then
			-- cfg.styleFont = true;
			-- fontStyleDo(TargetFrame)
		-- else
			-- cfg.styleFont = false;
			-- fontStyleDo(TargetFrame)
		-- end
	-- end );
		
	--	dark frames
	myCheckButton = createCheckbutton(optionUI.panel, 40, xOffset-90, " Dark unit frames.");
	myCheckButton.tooltip = "Enables dark texture frames for dark themed Ui.";
	myCheckButton:SetScript("OnClick",
	function(self)
		if whoaCheckButton7:GetChecked() then
			cfg.frameMode = "dark";
			cfg.darkFrames = true;
			playerFrameDo()
			whoaUpdatePvPStatus()
			darkFramesDo()
			dynamicFramesDo(TargetFrame)
			dynamicFramesDo(FocusFrame)
			whoaPartyFrames()
		else
			cfg.frameMode = "light";
			cfg.darkFrames = false;
			playerFrameDo()
			whoaUpdatePvPStatus()
			darkFramesDo()
			dynamicFramesDo(TargetFrame)
			dynamicFramesDo(FocusFrame)
			whoaPartyFrames()
		end
	end );
	
	local fancyOptions = whoa:CreateFont(optionUI.panel, "fancyOptions", "Other fancy options.", 25, xOffset-160, font, 12)
	fancyOptions:SetPoint("LEFT",optionUI.panel,"TOPLEFT",0,0)
	
	--	Party frames.
	myCheckButton = createCheckbutton(optionUI.panel, 40, xOffset-220, " Party frames.");
	myCheckButton.tooltip = "Applies whoa themed party frames when not using raid frames";
	myCheckButton:SetScript("OnClick",
	function(self)
		if whoaCheckButton8:GetChecked() then
			cfg.usePartyFrames = true;
		else
			cfg.usePartyFrames = false;
		end
	end );
	
	--	Pets on party frames.
	myCheckButton = createCheckbutton(optionUI.panel, 40, xOffset-250, " Show pets in patry.");
	myCheckButton.tooltip = "Displays pet frames on party frames when non in raid mode.";
	myCheckButton:SetScript("OnClick",
	function(self)
		if whoaCheckButton9:GetChecked() then
			SetCVar("showPartyPets",1)
			cfg.showPartyPets = true;
		else
			SetCVar("showPartyPets",0)
			cfg.showPartyPets = false;
		end
	end );
	
	-- -- combo points
	-- myCheckButton = createCheckbutton(optionUI.panel, 40, xOffset-190, " Combo points location.");
	-- myCheckButton.tooltip = "Set legacy combo points on target frame.";
	-- -- myCheckButton:SetEnabled(false);
	-- myCheckButton:SetScript("OnClick",
	-- function(self)
		-- if whoaCheckButton10:GetChecked() then
			-- SetCVar("comboPointLocation",1)
			-- cfg.comboPointFrame = true;
		-- else
			-- SetCVar("comboPointLocation",2)
			-- cfg.comboPointFrame = false;
		-- end
	-- end );
	-- --	Old threat numeric indicator.
	-- myCheckButton = createCheckbutton(optionUI.panel, 40, xOffset-220, "Threat numeric indicator.");
	-- myCheckButton.tooltip = "Enables threat numeric indicator over player frame.";
	-- myCheckButton:SetScript("OnClick",
	-- function(self)
		-- if whoaCheckButton10:GetChecked() then
			-- SetCVar("threatShowNumeric",1)
			-- cfg.threatShowNumeric = true;
		-- else
			-- SetCVar("threatShowNumeric",0)
			-- cfg.threatShowNumeric = false;
		-- end
	-- end );
		
	--	minimap mouswheel zoom.
	myCheckButton = createCheckbutton(optionUI.panel, 40, xOffset-280, " Minimap mousewheel zoom.");
	myCheckButton.tooltip = "Use whoa´s legacy texture on status bars.";
	myCheckButton:SetScript("OnClick",
	function(self)
		if whoaCheckButton10:GetChecked() then
			cfg.minimapZoom = true;
			minimapZoomHack()
		else
			cfg.minimapZoom = false;
			minimapZoomHack()
		end
	end );
	
	--	Click interaction switch.
	myCheckButton = createCheckbutton(optionUI.panel, 40, xOffset-370, "Click through frames.");
	myCheckButton.tooltip = "Disable click interaction for player/target/focus frames.";
	-- myCheckButton:SetEnabled(false);
	myCheckButton:SetScript("OnClick",
	function(self)
		if whoaCheckButton11:GetChecked() then
			cfg.noClickFrame = true;
			disableFramesClick()
		else
			cfg.noClickFrame = false;
			disableFramesClick()
		end
	end );
	
	-- Frames centering / restore.
	local positionOptions = whoa:CreateFont(optionUI.panel, "mainOptions", "Positioning options.", 25, xOffset-350, font, 13)
	mainOptions:SetPoint("LEFT",optionUI.panel,"TOPLEFT",0,0)
	local centerBttnInfo = whoa:CreateFont(optionUI.panel, "centerBttnInfo", "Center player and target frames middle screen.", 50, -500, font, 12)
	mainOptions:SetPoint("LEFT",optionUI.panel,"TOPLEFT",0,0)
	local centerBttn = CreateFrame("Button", "centerButton", optionUI.panel, "UIPanelButtonTemplate")
	centerBttn:SetSize(110 ,25)
	centerBttn:SetText("Center frames")
	centerBttn:SetPoint("BOTTOMLEFT",70,20)
	centerBttn:SetScript("OnClick", function()
		local x,y = -20,-150 for i,f in pairs({PlayerFrame,TargetFrame}) do f:ClearAllPoints() f:SetPoint(i==1 and "RIGHT" or "LEFT",UIParent,"CENTER",i==1 and x or -x,y) f:SetUserPlaced(true) end
	end)
	-- Reset.
	local resetBttn = CreateFrame("Button", "resetButton", optionUI.panel, "UIPanelButtonTemplate")
	resetBttn:SetSize(100 ,25)
	resetBttn:SetText("Reset frames")
	resetBttn:SetPoint("BOTTOMLEFT",210,20)
	resetBttn:SetScript("OnClick", function()
		PlayerFrame_ResetUserPlacedPosition()
		TargetFrame_ResetUserPlacedPosition()
	end)
	-- -- Reload
	-- local reloadBttn = CreateFrame("Button", "reloadButton", optionUI.panel, "UIPanelButtonTemplate")
		-- reloadBttn:SetSize(80 ,22)
		-- reloadBttn:SetText("Reload UI")
		-- reloadBttn:SetPoint("BOTTOMRIGHT",-20,20)
		-- reloadBttn:SetScript("OnClick", function()
		-- ReloadUI()
	-- end)

	-- texture selector.
	local textSelector = whoa:CreateFont(optionUI.panel, "textureSelector", "Statusbar texture selector:", 300, xOffset-115, font, 12)


	CreateFrame("Button", "dropSelector", optionUI.panel, "UIDropDownMenuTemplate")
	dropSelector:ClearAllPoints()
	dropSelector:SetPoint("CENTER", 65, 50)

	local items = {
		"Whoa",
		"Blizzard",
		"65%",
		"Ace",
		"Aluminium",
		"Banto",
		"Cracked",
		"Glaze",
		"Lite Step",
		"Metal",
		"Neon",
		"Otravi",
		"Perl",
		"Shiny",
		"Smooth",
		"Striped",
		"Swag",
	}

	local function OnClick(self)
		UIDropDownMenu_SetSelectedID(dropSelector, self:GetID())
		if (UIDropDownMenu_GetSelectedID(dropSelector)==1) then
			cfg.SBTextureName = "whoa";
			cfg.whoaTextureIndex = 1;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==2) then
			cfg.SBTextureName = "blizzard";
			cfg.whoaTextureIndex = 2;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==3) then
			cfg.SBTextureName = "65";
			cfg.whoaTextureIndex = 3;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==4) then
			cfg.SBTextureName = "ace";
			cfg.whoaTextureIndex = 4;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==5) then
			cfg.SBTextureName = "aluminium";
			cfg.whoaTextureIndex = 5;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==6) then
			cfg.SBTextureName = "banto";
			cfg.whoaTextureIndex = 6;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==7) then
			cfg.SBTextureName = "cracked";
			cfg.whoaTextureIndex = 7;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==8) then
			cfg.SBTextureName = "glaze";
			cfg.whoaTextureIndex = 8;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==9) then
			cfg.SBTextureName = "liteStep";
			cfg.whoaTextureIndex = 9;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==10) then
			cfg.SBTextureName = "metal";
			cfg.whoaTextureIndex = 10;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==11) then
			cfg.SBTextureName = "neon";
			cfg.whoaTextureIndex = 11;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==12) then
			cfg.SBTextureName = "otravi";
			cfg.whoaTextureIndex = 12;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==13) then
			cfg.SBTextureName = "perl";
			cfg.whoaTextureIndex = 13;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==14) then
			cfg.SBTextureName = "shiny";
			cfg.whoaTextureIndex = 14;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==15) then
			cfg.SBTextureName = "smooth";
			cfg.whoaTextureIndex = 15;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==16) then
			cfg.SBTextureName = "striped";
			cfg.whoaTextureIndex = 16;
		elseif (UIDropDownMenu_GetSelectedID(dropSelector)==17) then
			cfg.SBTextureName = "swag";
			cfg.whoaTextureIndex = 17;
		end
		SBTexturesDo()
	end
	local function initialize(self, level)
		local info = UIDropDownMenu_CreateInfo()
		for k,v in pairs(items) do
			info = UIDropDownMenu_CreateInfo()
			info.text = v
			info.value = k
			info.func = OnClick
			UIDropDownMenu_AddButton(info, level)
		end
	end

	UIDropDownMenu_Initialize(dropSelector, initialize)
	UIDropDownMenu_SetWidth(dropSelector, 100);
	UIDropDownMenu_SetButtonWidth(dropSelector, 124)
	UIDropDownMenu_JustifyText(dropSelector, "LEFT")
	if  (UIDropDownMenu_GetSelectedID(dropSelector) == nil) then
		UIDropDownMenu_SetSelectedID(dropSelector, 1)
	end
		UIDropDownMenu_SetSelectedID(dropSelector, cfg.whoaTextureIndex)
	
	
			-- font selector.
	local playerSelect = whoa:CreateFont(optionUI.panel, "playerSelector", "Font select:", 300, xOffset-180, font, 12)
	playerSelect:SetPoint("LEFT",optionUI.panel,"TOPLEFT",0,0)

	CreateFrame("Button", "fontSelector", optionUI.panel, "UIDropDownMenuTemplate")
	fontSelector:ClearAllPoints()
	fontSelector:SetPoint("CENTER", 65, -15)

	local fontList = {
		"Retail",
		"Retail Big",
		"Retail Huge",
		"Classic Small",
		"Classic",
		"Classic Big",
		"Mono",
	}

	local function OnClick(self)
		UIDropDownMenu_SetSelectedID(fontSelector, self:GetID())
		if (UIDropDownMenu_GetSelectedID(fontSelector)==1) then
			cfg.fontFamily = "SystemFont_Outline_Small";
			cfg.fontIndex = 1;
		elseif (UIDropDownMenu_GetSelectedID(fontSelector)==2) then
			cfg.fontFamily = "SystemFont_Outline";
			cfg.fontIndex = 2;
		elseif (UIDropDownMenu_GetSelectedID(fontSelector)==3) then
			cfg.fontFamily = "Game15Font_o1";
			cfg.fontIndex = 3;
		elseif (UIDropDownMenu_GetSelectedID(fontSelector)==4) then
			cfg.fontFamily = "Number12Font_o1";
			cfg.fontIndex = 4;
		elseif (UIDropDownMenu_GetSelectedID(fontSelector)==5) then
			cfg.fontFamily = "NumberFontNormal";
			cfg.fontIndex = 5;
		elseif (UIDropDownMenu_GetSelectedID(fontSelector)==6) then
			cfg.fontFamily = "NumberFont_Outline_Large";
			cfg.fontIndex = 6;
		elseif (UIDropDownMenu_GetSelectedID(fontSelector)==7) then
			cfg.fontFamily = "NumberFontNormalSmall";
			cfg.fontIndex = 7;
		end
		fontStyleDo()
	end
	local function initialize(self, level)
		local info = UIDropDownMenu_CreateInfo()
		for k,v in pairs(fontList) do
			info = UIDropDownMenu_CreateInfo()
			info.text = v
			info.value = k
			info.func = OnClick
			UIDropDownMenu_AddButton(info, level)
		end
	end
	UIDropDownMenu_Initialize(fontSelector, initialize)
	UIDropDownMenu_SetWidth(fontSelector, 100);
	UIDropDownMenu_JustifyText(fontSelector, "LEFT")
	UIDropDownMenu_SetButtonWidth(fontSelector, 124)
	if  (UIDropDownMenu_GetSelectedID(fontSelector) == nil) then
		UIDropDownMenu_SetSelectedID(fontSelector, 1)
	end
		UIDropDownMenu_SetSelectedID(fontSelector, cfg.fontIndex)
	
	
	-- player frame  selector.
	local playerSelect = whoa:CreateFont(optionUI.panel, "playerSelector", "Player frame select:", 300, xOffset-240, font, 12);
	playerSelect:SetPoint("LEFT",optionUI.panel,"TOPLEFT",0,0);

	CreateFrame("Button", "playerFrameSelect", optionUI.panel, "UIDropDownMenuTemplate")
	playerFrameSelect:ClearAllPoints()
	playerFrameSelect:SetPoint("CENTER", 65, -75)

	local playerFrameList = {
		"Normal",
		"Elite",
		"Rare",
		"Rare Elite",
	}

	local function OnClick(self)
		UIDropDownMenu_SetSelectedID(playerFrameSelect, self:GetID())
		if (UIDropDownMenu_GetSelectedID(playerFrameSelect)==1) then
			cfg.playerFrameSelect = "UI-TargetingFrame";
			cfg.playerFrameIndex = 1;
		elseif (UIDropDownMenu_GetSelectedID(playerFrameSelect)==2) then
			cfg.playerFrameSelect = "UI-TargetingFrame-Elite";
			cfg.playerFrameIndex = 2;
		elseif (UIDropDownMenu_GetSelectedID(playerFrameSelect)==3) then
			cfg.playerFrameSelect = "UI-TargetingFrame-Rar";
			cfg.playerFrameIndex = 3;
		elseif (UIDropDownMenu_GetSelectedID(playerFrameSelect)==4) then
			cfg.playerFrameSelect = "UI-TargetingFrame-Rare-Elite";
			cfg.playerFrameIndex = 4;
		end
		playerFrameDo(self)
	end
	local function initialize(self, level)
		local info = UIDropDownMenu_CreateInfo()
		for k,v in pairs(playerFrameList) do
			info = UIDropDownMenu_CreateInfo()
			info.text = v
			info.value = k
			info.func = OnClick
			UIDropDownMenu_AddButton(info, level)
		end
	end
	UIDropDownMenu_Initialize(playerFrameSelect, initialize)
	UIDropDownMenu_SetWidth(playerFrameSelect, 100);
	UIDropDownMenu_SetButtonWidth(playerFrameSelect, 124)
	UIDropDownMenu_JustifyText(playerFrameSelect, "LEFT")
	if  (UIDropDownMenu_GetSelectedID(playerFrameSelect) == nil) then
		cfg.playerFrameSelect = "UI-TargetingFrame";
		UIDropDownMenu_SetSelectedID(playerFrameSelect, 1)
	end
		UIDropDownMenu_SetSelectedID(playerFrameSelect, cfg.playerFrameIndex)
	
end)

-- slash commands.
SlashCmdList.optionUI = function()
	InterfaceOptionsFrame_OpenToCategory(optionUI.panel)
	InterfaceOptionsFrame_OpenToCategory(optionUI.panel)
end

SLASH_optionUI1 = "/optionUI"
SLASH_optionUI1 = "/wtf"
SLASH_optionUI1 = "/whoaf"

SlashCmdList['RELOAD'] = function() ReloadUI() end
SLASH_RELOAD1 = '/rl'

local whoaInit = CreateFrame("Frame", "whoaInit")
whoaInit:RegisterEvent("PLAYER_LOGIN");
whoaInit:RegisterEvent("ADDON_LOADED");
whoaInit:RegisterEvent("PLAYER_ENTERING_WORLD");
whoaInit:RegisterEvent("PLAYER_TARGET_CHANGED");
whoaInit:RegisterEvent("PLAYER_FOCUS_CHANGED");
whoaInit:SetScript('OnEvent', function(self, event, ...)
	if (event == "PLAYER_LOGIN") then
		if IsAddOnLoaded(""..whoaAddon.."") then
			print("|cffe6cc80 ["..addonName..""..addonVer.."] |cffffffffis now loaded. Use |cffffff00'/whoaf' |cffffffffto view options.");
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		loadDefaults()
		loadSettings()
	
		playerNameHide()
		fontStyleDo()
		SBTexturesDo()
		minimapZoomHack()
		disableFramesClick()
		playerFrameDo()
		darkFramesDo(self)
		
	elseif (event == "PLAYER_TARGET_CHANGED") then
		dynamicFramesDo(TargetFrame)
	elseif (event == "PLAYER_FOCUS_CHANGED") then
		dynamicFramesDo(FocusFrame)
	end
end)