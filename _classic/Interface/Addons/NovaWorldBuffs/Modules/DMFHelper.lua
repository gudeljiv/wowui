-------------------
---NovaWorldBuffs--
-------------------

local addonName, addon = ...;
local NWB = addon.a;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");

function NWB:openDmfHelperFrame()
	if (_G["NWBDmfFrame"]) then
		_G["NWBDmfFrame"]:Show();
	else
		NWB:print("DMF helper not available in this game version.");
	end
end

SLASH_NWBDMFHCMD1, SLASH_NWBDMFHCMD2 = '/dmfhelper', '/dmfhelpers';
function SlashCmdList.NWBDMFCMD(msg, editBox)
	NWB:openDmfHelperFrame();
end

if (NWB.isClassic) then
	--DMF Helper Frame.
	--This helps using the stuck method for DMF buff people are already using on pvp realms for when factions are griefing each other.
	--If Blizzard is against using stuck in this way I'll be happy to remove this.
	local dmfTimerBar;
	local NWBDmfFrame = CreateFrame("Frame", "NWBDmfFrame", UIParent, NWB:addBackdrop());
	NWBDmfFrame:Hide();
	NWBDmfFrame:SetToplevel(true);
	NWBDmfFrame:SetMovable(true);
	NWBDmfFrame:EnableMouse(true);
	--tinsert(UISpecialFrames, "NWBDmfFrame");
	NWBDmfFrame:SetPoint("CENTER", UIParent, -325, 125);
	NWBDmfFrame:SetWidth(250);
	NWBDmfFrame:SetHeight(270);
	NWBDmfFrame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
	NWBDmfFrame:SetBackdropColor(0,0,0,.6);
	NWBDmfFrame:SetFrameLevel(128);
	NWBDmfFrame:SetFrameStrata("MEDIUM");
	NWBDmfFrame.fs = NWBDmfFrame:CreateFontString("NWBDmfFrameFS", "ARTWORK");
	NWBDmfFrame.fs:SetPoint("TOP", 0, -3);
	NWBDmfFrame.fs:SetFont(NWB.regionFont, 14);
	NWBDmfFrame.fs:SetText(NWB.prefixColor .. "NWB Stuck Helper");
	NWBDmfFrame.fs2 = NWBDmfFrame:CreateFontString("NWBDmfFrameFS2", "ARTWORK");
	NWBDmfFrame.fs2:SetPoint("TOP", 0, -65);
	NWBDmfFrame.fs2:SetFont(NWB.regionFont, 14);
	local iwtKeybind = "";
	NWBDmfFrame.fs2:SetText("Current Interact With Target keybind: |cffffa500" .. iwtKeybind);
	NWBDmfFrame.fs3 = NWBDmfFrame:CreateFontString("NWBDmfFrameFS", "ARTWORK");
	NWBDmfFrame.fs3:SetPoint("TOP", 0, -19);
	NWBDmfFrame.fs3:SetFont(NWB.regionFont, 14);
	NWBDmfFrame.fs3:SetText("|cffffff00Target Sayge and be in interact range\nbefore starting.");

	function NWB:updateInteractBindText()
		iwtKeybind = GetBindingKey("INTERACTTARGET");
		if (not iwtKeybind) then
			iwtKeybind = "None";
		end
		NWBDmfFrame.fs2:SetText("Current Interact With Target keybind:\n|cffffa500" .. iwtKeybind);
	end

	local NWBDmfDragFrame = CreateFrame("Frame", "NWBbuffListDragFrame", NWBDmfFrame);
	--NWBDmfDragFrame:SetToplevel(true);
	NWBDmfDragFrame:EnableMouse(true);
	NWBDmfDragFrame:SetWidth(205);
	NWBDmfDragFrame:SetHeight(38);
	NWBDmfDragFrame:SetPoint("TOP", 0, 4);
	NWBDmfDragFrame:SetFrameLevel(131);
	NWBDmfDragFrame.tooltip = CreateFrame("Frame", "NWBDmfDragTooltip", NWBDmfDragFrame, "TooltipBorderedFrameTemplate");
	NWBDmfDragFrame.tooltip:SetPoint("CENTER", NWBDmfDragFrame, "TOP", 0, 12);
	NWBDmfDragFrame.tooltip:SetFrameStrata("TOOLTIP");
	NWBDmfDragFrame.tooltip:SetFrameLevel(9);
	NWBDmfDragFrame.tooltip:SetAlpha(.8);
	NWBDmfDragFrame.tooltip.fs = NWBDmfDragFrame.tooltip:CreateFontString("NWBDmfDragTooltipFS", "ARTWORK");
	NWBDmfDragFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
	NWBDmfDragFrame.tooltip.fs:SetFont(NWB.regionFont, 12);
	NWBDmfDragFrame.tooltip.fs:SetText(L["Hold to drag"]);
	NWBDmfDragFrame.tooltip:SetWidth(NWBDmfDragFrame.tooltip.fs:GetStringWidth() + 16);
	NWBDmfDragFrame.tooltip:SetHeight(NWBDmfDragFrame.tooltip.fs:GetStringHeight() + 10);
	NWBDmfDragFrame:SetScript("OnEnter", function(self)
		NWBDmfDragFrame.tooltip:Show();
	end)
	NWBDmfDragFrame:SetScript("OnLeave", function(self)
		NWBDmfDragFrame.tooltip:Hide();
	end)
	NWBDmfDragFrame.tooltip:Hide();
	NWBDmfDragFrame:SetScript("OnMouseDown", function(self, button)
		if (button == "LeftButton" and not self:GetParent().isMoving) then
			self:GetParent():StartMoving();
			self:GetParent().isMoving = true;
			--self:GetParent():SetUserPlaced(false);
		end
	end)
	NWBDmfDragFrame:SetScript("OnMouseUp", function(self, button)
		if (button == "LeftButton" and self:GetParent().isMoving) then
			self:GetParent():StopMovingOrSizing();
			self:GetParent().isMoving = false;
		end
	end)
	NWBDmfDragFrame:SetScript("OnHide", function(self)
		if (self:GetParent().isMoving) then
			self:GetParent():StopMovingOrSizing();
			self:GetParent().isMoving = false;
		end
	end)

	--Top right X close button.
	local NWBDmfFrameClose = CreateFrame("Button", "NWBDmfFrameFrameClose", NWBDmfFrame, "UIPanelCloseButton");
	NWBDmfFrameClose:SetPoint("TOPRIGHT", 0, 0);
	NWBDmfFrameClose:SetWidth(20);
	NWBDmfFrameClose:SetHeight(20);
	--NWBDmfFrameClose:SetFrameLevel(3);
	local clickedDmfFrameClose;
	NWBDmfFrameClose:SetScript("OnClick", function(self, arg)
		clickedDmfFrameClose = true;
		NWBDmfFrame:Hide();
		NWB:print("Closed DMF helper, to reopen it walk away from Sayge and back in again (This window can disabled in /nwb config).");
	end)
	--Adjust the X texture so it fits the entire frame and remove the empty clickable space around the close button.
	--Big thanks to Meorawr for this.
	NWBDmfFrameClose:GetNormalTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
	NWBDmfFrameClose:GetHighlightTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
	NWBDmfFrameClose:GetPushedTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
	NWBDmfFrameClose:GetDisabledTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);

	--Start stuck button.
	local NWBDmfFrameStartStuckButton = CreateFrame("Button", "NWBDmfFrameStartStuckButton", NWBDmfFrame, "UIPanelButtonTemplate, SecureActionButtonTemplate");
	NWBDmfFrameStartStuckButton:SetAttribute("type", "macro");
	NWBDmfFrameStartStuckButton:SetAttribute("macrotext", "/click HelpFrameCharacterStuckStuck");
	--NWBDmfFrameStartStuckButton:SetPoint("Bottom", 0, 10);
	NWBDmfFrameStartStuckButton:SetPoint("BottomLeft", 3, 3);
	NWBDmfFrameStartStuckButton:SetWidth(120);
	NWBDmfFrameStartStuckButton:SetHeight(30);
	NWBDmfFrameStartStuckButton:SetText("Start Stuck");
	NWBDmfFrameStartStuckButton:SetNormalFontObject("GameFontNormal");
	local lastDmfStuckStartClick = 0;
	NWBDmfFrameStartStuckButton:SetScript("OnMouseDown", function(self, arg)
		lastDmfStuckStartClick = GetTime();
	end)
	NWBDmfFrameStartStuckButton.tooltip = CreateFrame("Frame", "NWBDmfFrameStartStuckButtonTooltip", NWBDmfFrameStartStuckButton, "TooltipBorderedFrameTemplate");
	NWBDmfFrameStartStuckButton.tooltip:SetPoint("CENTER", NWBDmfFrameStartStuckButton, "CENTER", 0, -50);
	NWBDmfFrameStartStuckButton.tooltip:SetFrameStrata("TOOLTIP");
	NWBDmfFrameStartStuckButton.tooltip:SetFrameLevel(140);
	NWBDmfFrameStartStuckButton.tooltip.fs = NWBDmfFrameStartStuckButton.tooltip:CreateFontString("NWBDmfFrameStartStuckButtonTooltipFS", "ARTWORK");
	NWBDmfFrameStartStuckButton.tooltip.fs:SetPoint("CENTER", 0, 0);
	NWBDmfFrameStartStuckButton.tooltip.fs:SetFont(NWB.regionFont, 12);
	NWBDmfFrameStartStuckButton.tooltip.fs:SetText("|CffDEDE42Start a |CFFFFA50010|CffDEDE42 second stuck timer\nwith auto resurrection.\nTarget Sayge and spam interact keybind.\n(This is the ingame Blizzard\nstuck helper with no logout)");
	NWBDmfFrameStartStuckButton.tooltip:SetWidth(NWBDmfFrameStartStuckButton.tooltip.fs:GetStringWidth() + 18);
	NWBDmfFrameStartStuckButton.tooltip:SetHeight(NWBDmfFrameStartStuckButton.tooltip.fs:GetStringHeight() + 12);
	NWBDmfFrameStartStuckButton:SetScript("OnEnter", function(self)
		NWBDmfFrameStartStuckButton.tooltip:Show();
	end)
	NWBDmfFrameStartStuckButton:SetScript("OnLeave", function(self)
		NWBDmfFrameStartStuckButton.tooltip:Hide();
	end)
	NWBDmfFrameStartStuckButton.tooltip:Hide();

	--Stop stuck button.
	local NWBDmfFrameStopStuckButton = CreateFrame("Button", "NWBDmfFrameStopStuckButton", NWBDmfFrame, "UIPanelButtonTemplate, SecureActionButtonTemplate");
	NWBDmfFrameStopStuckButton:SetAttribute("type", "macro");
	NWBDmfFrameStopStuckButton:SetAttribute("macrotext", "/stopcasting");
	NWBDmfFrameStopStuckButton:SetPoint("BottomLeft", 3, 3);
	NWBDmfFrameStopStuckButton:SetWidth(120);
	NWBDmfFrameStopStuckButton:SetHeight(30);
	NWBDmfFrameStopStuckButton:SetText("Cancel");
	NWBDmfFrameStopStuckButton:SetNormalFontObject("GameFontNormal");
	local lastDmfStuckStopClick = 0;
	NWBDmfFrameStopStuckButton:SetScript("OnMouseDown", function(self, arg)
		lastDmfStuckStopClick = GetTime();
	end)
	NWBDmfFrameStopStuckButton:Hide();

	--Start logout button.
	local NWBDmfFrameStartLogoutButton = CreateFrame("Button", "NWBDmfFrameStartLogoutButton", NWBDmfFrame, "UIPanelButtonTemplate, SecureActionButtonTemplate");
	NWBDmfFrameStartLogoutButton:SetAttribute("type", "macro");
	NWBDmfFrameStartLogoutButton:SetAttribute("macrotext", "/camp");
	NWBDmfFrameStartLogoutButton:SetPoint("BottomRight", -3, 3);
	NWBDmfFrameStartLogoutButton:SetWidth(120);
	NWBDmfFrameStartLogoutButton:SetHeight(30);
	--NWBDmfFrameStartLogoutButton:SetFrameLevel(130);
	NWBDmfFrameStartLogoutButton:SetText("Start Logout");
	NWBDmfFrameStartLogoutButton:SetNormalFontObject("GameFontNormal");
	local lastDmfLogoutStartClick = 0;
	NWBDmfFrameStartLogoutButton:SetScript("OnMouseDown", function(self, arg)
		lastDmfLogoutStartClick = GetTime();
	end)
	NWBDmfFrameStartLogoutButton.tooltip = CreateFrame("Frame", "NWBDmfFrameStartLogoutButtonTooltip", NWBDmfFrameStartLogoutButton, "TooltipBorderedFrameTemplate");
	NWBDmfFrameStartLogoutButton.tooltip:SetPoint("CENTER", NWBDmfFrameStartLogoutButton, "CENTER", 0, -50);
	NWBDmfFrameStartLogoutButton.tooltip:SetFrameStrata("TOOLTIP");
	NWBDmfFrameStartLogoutButton.tooltip:SetFrameLevel(140);
	NWBDmfFrameStartLogoutButton.tooltip.fs = NWBDmfFrameStartLogoutButton.tooltip:CreateFontString("NWBDmfFrameStartLogoutButtonTooltipFS", "ARTWORK");
	NWBDmfFrameStartLogoutButton.tooltip.fs:SetPoint("CENTER", 0, 0);
	NWBDmfFrameStartLogoutButton.tooltip.fs:SetFont(NWB.regionFont, 12);
	NWBDmfFrameStartLogoutButton.tooltip.fs:SetText("|CffDEDE42Start a |CFFFFA50020|CffDEDE42 second logout timer\nwith auto resurrection.\nTarget Sayge and spam interact keybind.\n(This requires using the website\nstuck helper while offline)");
	NWBDmfFrameStartLogoutButton.tooltip:SetWidth(NWBDmfFrameStartLogoutButton.tooltip.fs:GetStringWidth() + 18);
	NWBDmfFrameStartLogoutButton.tooltip:SetHeight(NWBDmfFrameStartLogoutButton.tooltip.fs:GetStringHeight() + 12);
	NWBDmfFrameStartLogoutButton:SetScript("OnEnter", function(self)
		NWBDmfFrameStartLogoutButton.tooltip:Show();
	end)
	NWBDmfFrameStartLogoutButton:SetScript("OnLeave", function(self)
		NWBDmfFrameStartLogoutButton.tooltip:Hide();
	end)
	NWBDmfFrameStartLogoutButton.tooltip:Hide();

	--Stop logout button.
	local NWBDmfFrameStopLogoutButton = CreateFrame("Button", "NWBDmfFrameStopLogoutButton", NWBDmfFrame, "UIPanelButtonTemplate, SecureActionButtonTemplate");
	local dmfStopLogoutMacro = [=[
	/run for i=1,STATICPOPUP_NUMDIALOGS do if _G["StaticPopup"..i].which=="CAMP" then _G["StaticPopup"..i.."Button1"]:Click() end end
	]=]
	NWBDmfFrameStopLogoutButton:SetAttribute("type", "macro");
	NWBDmfFrameStopLogoutButton:SetAttribute("macrotext", dmfStopLogoutMacro);
	NWBDmfFrameStopLogoutButton:SetPoint("BottomRight", -3, 3);
	NWBDmfFrameStopLogoutButton:SetWidth(120);
	NWBDmfFrameStopLogoutButton:SetHeight(30);
	--NWBDmfFrameStopLogoutButton:SetFrameLevel(141);
	NWBDmfFrameStopLogoutButton:SetText("Cancel");
	NWBDmfFrameStopLogoutButton:SetNormalFontObject("GameFontNormal");
	local lastDmfLogoutStopClick = 0;
	NWBDmfFrameStopLogoutButton:SetScript("OnMouseDown", function(self, arg)
		lastDmfLogoutStopClick = GetTime();
	end)
	NWBDmfFrameStopLogoutButton:Hide();

	--Interact keybind button.
	local NWBChangeInteractKeybindButton = CreateFrame("Button", "NWBChangeInteractKeybindButton", NWBDmfFrame, "UIPanelButtonTemplate");
	--NWBChangeInteractKeybindButton:SetPoint("TopLeft", 28, -85);
	NWBChangeInteractKeybindButton:SetPoint("TOP", 0, -95);
	NWBChangeInteractKeybindButton:SetWidth(120);
	NWBChangeInteractKeybindButton:SetHeight(20);
	NWBChangeInteractKeybindButton:SetText("Change Keybind");
	NWBChangeInteractKeybindButton:SetNormalFontObject("GameFontNormalSmall");
	--[[NWBChangeInteractKeybindButton:SetScript("OnClick", function(self, arg)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION);
		KeyBindingFrame_LoadUI();
		KeyBindingFrame.mode = 1;
		ShowUIPanel(KeyBindingFrame);
		--Go to the targeting category.
		KeyBindingFrameCategoryListButton5:Click();
		KeyBindingFrameScrollFrame.ScrollBar:SetValue(999);
		for i = 1, 20 do
			local binding = _G["KeyBindingFrameKeyBinding" .. i];
			if (binding and binding.description
					and binding.description:GetText() == BINDING_NAME_INTERACTTARGET) then
				binding.description:SetText(BINDING_NAME_INTERACTTARGET .. "  |CFFFFFFFF<- HERE");
			end
		end
	end)]]
	NWBChangeInteractKeybindButton:SetScript("OnClick", function(self, arg)
		Settings.OpenToCategory(Settings.KEYBINDINGS_CATEGORY_ID);
		local children = {SettingsPanel.Container.SettingsList.ScrollBox.ScrollTarget:GetChildren()};
		for k, v in pairs(children) do
			if (v.Button and v.Button.Text and v.Button.Text:GetText() == BINDING_HEADER_TARGETING) then
				v.Button:Click();
				SettingsPanel.Container.SettingsList.ScrollBar:SetScrollPercentage(50);
			end
		end
	end)
	NWBChangeInteractKeybindButton.tooltip = CreateFrame("Frame", "NWBChangeInteractKeybindButtonTooltip", NWBChangeInteractKeybindButton, "TooltipBorderedFrameTemplate");
	NWBChangeInteractKeybindButton.tooltip:SetPoint("CENTER", NWBChangeInteractKeybindButton, "CENTER", 0, -40);
	NWBChangeInteractKeybindButton.tooltip:SetFrameStrata("TOOLTIP");
	NWBChangeInteractKeybindButton.tooltip:SetFrameLevel(140);
	NWBChangeInteractKeybindButton.tooltip.fs = NWBChangeInteractKeybindButton.tooltip:CreateFontString("NWBChangeInteractKeybindButtonTooltipFS", "ARTWORK");
	NWBChangeInteractKeybindButton.tooltip.fs:SetPoint("CENTER", 0, 0);
	NWBChangeInteractKeybindButton.tooltip.fs:SetFont(NWB.regionFont, 12);
	NWBChangeInteractKeybindButton.tooltip.fs:SetText("|CffDEDE42Opens the keybinds menu.\nKeybinds -> Targeting -> Interact With Target");
	NWBChangeInteractKeybindButton.tooltip:SetWidth(NWBChangeInteractKeybindButton.tooltip.fs:GetStringWidth() + 18);
	NWBChangeInteractKeybindButton.tooltip:SetHeight(NWBChangeInteractKeybindButton.tooltip.fs:GetStringHeight() + 12);
	NWBChangeInteractKeybindButton:SetScript("OnEnter", function(self)
		NWBChangeInteractKeybindButton.tooltip:Show();
	end)
	NWBChangeInteractKeybindButton:SetScript("OnLeave", function(self)
		NWBChangeInteractKeybindButton.tooltip:Hide();
	end)
	NWBChangeInteractKeybindButton.tooltip:Hide();

	function NWB:createDmfHelperButtons()
		if (not NWB.dmfChatCountdown) then
			NWB.dmfChatCountdown = CreateFrame("CheckButton", "NWBDMFChatCountdown", NWBDmfFrame, "ChatConfigCheckButtonTemplate");
			NWB.dmfChatCountdown:SetPoint("BOTTOMLEFT", 30, 120);
			NWBDMFChatCountdownText:SetText("Group Chat Countdown");
			NWB.dmfChatCountdown.tooltip = "Countdown the seconds left until resurrection in party/raid chat? This is for friends helping you by ressing first to take some hits.";
			--NWB.dmfChatCountdown:SetFrameStrata("HIGH");
			NWB.dmfChatCountdown:SetFrameLevel(132);
			NWB.dmfChatCountdown:SetWidth(24);
			NWB.dmfChatCountdown:SetHeight(24);
			NWB.dmfChatCountdown:SetChecked(NWB.db.global.dmfChatCountdown);
			NWB.dmfChatCountdown:SetScript("OnClick", function()
				local value = NWB.dmfChatCountdown:GetChecked();
				NWB.db.global.dmfChatCountdown = value;
			end)
			NWB.dmfChatCountdown:SetHitRectInsets(0, 0, -10, 7);
		end
		if (not NWB.dmfAutoResButton) then
			NWB.dmfAutoResButton = CreateFrame("CheckButton", "NWBDMFAutoResButton", NWBDmfFrame, "ChatConfigCheckButtonTemplate");
			NWB.dmfAutoResButton:SetPoint("BOTTOMLEFT", 30, 88);
			NWBDMFAutoResButtonText:SetText("Auto Resurrect");
			NWB.dmfAutoResButton.tooltip = "Auto accept resurrect right before you logout/stuck?\nSet how many seconds before the timer ends to res below.";
			--NWB.dmfAutoResButton:SetFrameStrata("HIGH");
			--NWB.dmfAutoResButton:SetFrameLevel(3);
			NWB.dmfAutoResButton:SetWidth(24);
			NWB.dmfAutoResButton:SetHeight(24);
			NWB.dmfAutoResButton:SetChecked(NWB.db.global.dmfAutoRes);
			NWB.dmfAutoResButton:SetScript("OnClick", function()
				local value = NWB.dmfAutoResButton:GetChecked();
				NWB.db.global.dmfAutoRes = value;
			end)
			NWB.dmfAutoResButton:SetHitRectInsets(0, 0, -10, 7);
		end
		if (not NWB.dmfAutoResSlider) then
			NWB.dmfAutoResSlider = CreateFrame("Slider", "NWBDMFAutoResSlider", NWBDmfFrame, "UISliderTemplate");
			--Slider template currently bugged, need to create some elements ourself.
			NWB.dmfAutoResSlider.High = NWB.dmfAutoResSlider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
			NWB.dmfAutoResSlider.High:SetPoint("TOPRIGHT", NWB.dmfAutoResSlider, "BOTTOMRIGHT");
			NWB.dmfAutoResSlider.Low = NWB.dmfAutoResSlider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
			NWB.dmfAutoResSlider.Low:SetPoint("TOPLEFT", NWB.dmfAutoResSlider, "BOTTOMLEFT");
			NWB.dmfAutoResSlider.Text = NWB.dmfAutoResSlider:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
			NWB.dmfAutoResSlider.Text:SetPoint("BOTTOM", NWB.dmfAutoResSlider, "TOP");
			NWB.dmfAutoResSlider:SetPoint("BOTTOM", 0, 50);
			NWBDMFAutoResSlider.Text:SetText("Auto Resurrect Seconds Left");
			NWB.dmfAutoResSlider.tooltipText = "How many seconds left on logout/stuck will we auto resurrect at?";
			--NWB.dmfAutoResSlider:SetFrameStrata("HIGH");
			--NWB.dmfAutoResSlider:SetFrameLevel(5);
			NWB.dmfAutoResSlider:SetWidth(180);
			NWB.dmfAutoResSlider:SetHeight(16);
			NWB.dmfAutoResSlider:SetMinMaxValues(1, 5);
			NWB.dmfAutoResSlider:SetObeyStepOnDrag(true);
			NWB.dmfAutoResSlider:SetValueStep(0.5);
			NWB.dmfAutoResSlider:SetStepsPerPage(0.5);
			NWB.dmfAutoResSlider:SetValue(NWB.db.global.dmfAutoResTime);
			NWBDMFAutoResSlider.Low:SetText("1");
			NWBDMFAutoResSlider.High:SetText("5");
			NWBDMFAutoResSlider:HookScript("OnValueChanged", function(self, value)
				NWB.db.global.dmfAutoResTime = value;
				NWB.dmfAutoResSlider.editBox:SetText(value);
			end)
			--Some of this was taken from AceGUI.
			local function EditBox_OnEscapePressed(frame)
				frame:ClearFocus();
			end
			local function EditBox_OnEnterPressed(frame)
				local value = frame:GetText();
				value = tonumber(value);
				if value then
					PlaySound(856);
					NWB.db.global.dmfAutoResTime = value;
					NWB.dmfAutoResSlider:SetValue(value);
					frame:ClearFocus();
				else
					--If not a valid number reset the box.
					NWB.dmfAutoResSlider.editBox:SetText(NWB.db.global.dmfAutoResTime);
					frame:ClearFocus();
				end
			end
			local function EditBox_OnEnter(frame)
				frame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
			end
			local function EditBox_OnLeave(frame)
				frame:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8);
			end
			local ManualBackdrop = {
				bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
				edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
				tile = true, edgeSize = 1, tileSize = 5,
			};
			NWB.dmfAutoResSlider.editBox = CreateFrame("EditBox", nil, NWB.dmfAutoResSlider, NWB:addBackdrop());
			NWB.dmfAutoResSlider.editBox:SetAutoFocus(false);
			NWB.dmfAutoResSlider.editBox:SetFontObject(GameFontHighlightSmall);
			NWB.dmfAutoResSlider.editBox:SetPoint("TOP", NWB.dmfAutoResSlider, "BOTTOM");
			NWB.dmfAutoResSlider.editBox:SetHeight(14);
			NWB.dmfAutoResSlider.editBox:SetWidth(40);
			NWB.dmfAutoResSlider.editBox:SetJustifyH("CENTER");
			NWB.dmfAutoResSlider.editBox:EnableMouse(true);
			NWB.dmfAutoResSlider.editBox:SetBackdrop(ManualBackdrop);
			NWB.dmfAutoResSlider.editBox:SetBackdropColor(0, 0, 0, 0.5);
			NWB.dmfAutoResSlider.editBox:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80);
			NWB.dmfAutoResSlider.editBox:SetScript("OnEnter", EditBox_OnEnter);
			NWB.dmfAutoResSlider.editBox:SetScript("OnLeave", EditBox_OnLeave);
			NWB.dmfAutoResSlider.editBox:SetScript("OnEnterPressed", EditBox_OnEnterPressed);
			NWB.dmfAutoResSlider.editBox:SetScript("OnEscapePressed", EditBox_OnEscapePressed);
			NWB.dmfAutoResSlider.editBox:SetText(NWB.db.global.dmfAutoResTime);
		end
	end

	NWBDmfFrame:SetScript("OnShow", function(self)
		NWB:updateInteractBindText();
		NWB:createDmfHelperButtons();
		NWBDmfFrameStartLogoutButton:Show();
		NWBDmfFrameStopLogoutButton:Hide();
		NWBDmfFrameStartStuckButton:Show();
		NWBDmfFrameStopStuckButton:Hide();
	end)

	local doDmfScan = false;
	local f = CreateFrame("Frame");
	local lastDmfPoisChange = 0;
	local lastDmfPoisZone;
	local scanCheckEnabled;
	local dmfStuckResTimer, dmfLogoutResTimer, dmfChatTimer;
	local dmfChatTickerCount = 0;
	f:RegisterEvent("PLAYER_ENTERING_WORLD");
	f:RegisterEvent("AREA_POIS_UPDATED");
	f:RegisterEvent("UNIT_SPELLCAST_START");
	f:RegisterEvent("UNIT_SPELLCAST_STOP");
	f:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	f:RegisterEvent("PLAYER_CAMPING");
	f:RegisterEvent("UPDATE_BINDINGS");
	f:RegisterEvent("PLAYER_UNGHOST");
	f:SetScript("OnEvent", function(self, event, ...)
		if (event == "PLAYER_ENTERING_WORLD" or event == "AREA_POIS_UPDATED") then
			--Must use GetServerTime() and not GetTime() for logon or its unreliable.
			lastDmfPoisChange = GetServerTime();
			local subZone = GetSubZoneText();
			local _, _, zone = NWB:GetPlayerZonePosition();
			if (NWB.isDmfUp and NWB:verifyDmfZone() and not doDmfScan) then
				NWB:debug("Starting DMF scan.");
				doDmfScan = true;
				NWB:dmfPosTicker();
			elseif (doDmfScan and (not NWB.isDmfUp or not zone)) then
				doDmfScan = false;
			end
			lastDmfPoisZone = subZone;
		elseif (event == "UNIT_SPELLCAST_START") then
			local unit, _, spellID = ...;
			if (unit == "player" and spellID == 7355 and (GetTime() - lastDmfStuckStartClick) < 10) then
				if (UnitIsGhost("player")) then
					local stuckTime = 10;
					local duration = stuckTime - NWB.db.global.dmfAutoResTime;
					if (NWB.db.global.dmfAutoRes) then
						NWB:print("Target Sayge and spam press your Interact With Target keybind now, resurrection in " .. duration ..  " seconds.");
						dmfStuckResTimer = C_Timer.NewTimer(duration, function()
							RetrieveCorpse();
						end)
						dmfChatTickerCount = math.floor(duration);
						dmfChatTimer = C_Timer.NewTicker(1, function()
							NWB:dmfChatTicker();
						end, math.floor(duration))
						if (NWB.db.global.dmfChatCountdown) then
							NWB:dmfSendGroup("Starting resurrection countdown.");
						end
						dmfTimerBar = NWB:createTimerBar(NWBDmfFrame:GetWidth(), 30, duration, "Resurrection");
						dmfTimerBar:SetPoint("TOP", NWBDmfFrame, "BOTTOM", 0, 0);
						dmfTimerBar:SetFill(true);
						dmfTimerBar:SetColor(255, 165, 0);
						dmfTimerBar:Start();
						NWBDmfFrameStartStuckButton:Hide();
						NWBDmfFrameStopStuckButton:Show();
					else
						NWB:print("Stuck started (Auto resurrection disabled).");
					end
				else
					NWB:print("You must be a ghost to use this.");
				end
			end
		elseif (event == "UNIT_SPELLCAST_STOP") then
			local unit, _, spellID = ...;
			if (unit == "player" and spellID == 7355 and dmfStuckResTimer) then
				NWB:debug("cancelled res timer")
				if (dmfStuckResTimer._remainingIterations and dmfStuckResTimer._remainingIterations > 0) then
					if (NWB.db.global.dmfChatCountdown) then
						NWB:dmfSendGroup("Cancelled resurrection countdown.");
					else
						NWB:print("Cancelled resurrection countdown.");
					end
				end
				dmfStuckResTimer:Cancel();
				dmfChatTimer:Cancel();
				dmfLogoutResTimer = nil;
				dmfChatTimer = nil;
				if (dmfTimerBar) then
					dmfTimerBar:Stop();
					dmfTimerBar = nil;
				end
				NWBDmfFrameStartStuckButton:Show();
				NWBDmfFrameStopStuckButton:Hide();
			end
		elseif (event == "PLAYER_CAMPING") then
			if (GetTime() - lastDmfLogoutStartClick < 10) then
				if (UnitIsGhost("player")) then
					local logoutTime = 20;
					local duration = logoutTime - NWB.db.global.dmfAutoResTime;
					if (NWB.db.global.dmfAutoRes) then
						NWB:print("Target Sayge and spam press your Interact With Target keybind now, resurrection in " .. duration ..  " seconds.");
						dmfLogoutResTimer = C_Timer.NewTimer(duration, function()
							RetrieveCorpse();
						end)
						dmfChatTickerCount = math.floor(duration);
						dmfChatTimer = C_Timer.NewTicker(1, function()
							NWB:dmfChatTicker();
						end, math.floor(duration))
						if (NWB.db.global.dmfChatCountdown) then
							NWB:dmfSendGroup("Starting resurrection countdown.");
						end
						dmfTimerBar = NWB:createTimerBar(NWBDmfFrame:GetWidth(), 30, duration, "Resurrection");
						dmfTimerBar:SetPoint("TOP", NWBDmfFrame, "BOTTOM", 0, 0);
						dmfTimerBar:SetFill(true);
						dmfTimerBar:SetColor(255, 165, 0);
						dmfTimerBar:Start();
						NWBDmfFrameStartLogoutButton:Hide();
						NWBDmfFrameStopLogoutButton:Show();
						--NWBDmfFrameStartStuckButton:Hide();
						--NWBDmfFrameStopStuckButton:Show();
					else
						NWB:print("Logout started (Auto resurrection disabled).");
					end
				else
					NWB:print("You must be a ghost to use this.");
				end
			end
		elseif (event == "UPDATE_BINDINGS") then
			NWB:updateInteractBindText();
		elseif (event == "PLAYER_UNGHOST") then
			local _, _, zone = NWB:GetPlayerZonePosition();
			if (NWB:verifyDmfZone()) then
				NWBDmfFrameStartLogoutButton:Show();
				NWBDmfFrameStopLogoutButton:Hide();
				--NWBDmfFrameStartStuckButton:Show();
				--NWBDmfFrameStopStuckButton:Hide();
			end
		end
	end)

	function NWB:createTimerBar(width, height, duration, label)
		local bar = NWB.candyBar:New("Interface\\RaidFrame\\Raid-Bar-Hp-Fill", width, height);
		bar:SetLabel(label);
		bar:SetDuration(duration);
		return bar;
	end

	function NWB.cancelLogout()
		if (dmfLogoutResTimer) then
			dmfLogoutResTimer:Cancel();
			dmfChatTimer:Cancel();
			dmfLogoutResTimer = nil;
			dmfChatTimer = nil;
			NWBDmfFrameStartLogoutButton:Show();
			NWBDmfFrameStopLogoutButton:Hide();
			--NWBDmfFrameStartStuckButton:Show();
			--NWBDmfFrameStopStuckButton:Hide();
			if (NWB.db.global.dmfChatCountdown) then
				NWB:dmfSendGroup("Cancelled resurrection countdown.");
			else
				NWB:print("Cancelled resurrection countdown.");
			end
			if (dmfTimerBar) then
				dmfTimerBar:Stop();
				dmfTimerBar = nil;
			end
			NWBDmfFrameStopLogoutButton:Hide();
		end
	end

	hooksecurefunc("CancelLogout", NWB.cancelLogout);

	function NWB:dmfChatTicker(first)
		dmfChatTickerCount = dmfChatTickerCount - 1;
		if (NWB.db.global.dmfChatCountdown and NWB.db.global.dmfAutoRes) then
			if (dmfChatTickerCount == 10) then
				NWB:dmfSendGroup("Resurrection in 10 seconds.");
			elseif (dmfChatTickerCount == 5) then
				NWB:dmfSendGroup("Resurrection in 5 seconds.");
			elseif (dmfChatTickerCount == 4) then
				NWB:dmfSendGroup("Resurrection in 4 seconds.");
			elseif (dmfChatTickerCount == 3) then
				NWB:dmfSendGroup("Resurrection in 3 seconds.");
			elseif (dmfChatTickerCount == 2) then
				NWB:dmfSendGroup("Resurrection in 2 seconds.");
			elseif (dmfChatTickerCount == 1) then
				NWB:dmfSendGroup("Resurrection in 1 second.");
			elseif (dmfChatTickerCount == 0) then
				NWB:dmfSendGroup("Resurrecting Now!");
			end
		end
	end

	function NWB:dmfSendGroup(msg)
		if (IsInRaid()) then
			SendChatMessage(msg, "RAID");
		elseif (IsInGroup()) then
			SendChatMessage(msg, "PARTY");
		end
	end

	function NWB:verifyDmfZone()
		local _, _, zone = NWB:GetPlayerZonePosition();
		if ((zone == 1429 and NWB.faction == "Horde") or (zone == 1412 and NWB.faction == "Alliance")) then
			return true;
		end
	end

	function NWB:verifyDmfPos()
		--English only for starters while testing.
		--if (not LOCALE_enUS and not LOCALE_enGB) then
		--	return;
		--end
		if (not UnitIsGhost("player")) then
			return;
		end
		if (NWB.faction == "Horde") then
			local x, y, zone = NWB:GetPlayerZonePosition();
			--Only works within a square around Goldshire DMF.
			if (zone ~= 1429 or (y > 0.69853476638874 or y < 0.6824626793253
					or x > 0.42938295086608 or x < 0.41670588083958)) then
				return;
			end
		elseif (NWB.faction == "Alliance") then
			--Only works within a square around Mulgore DMF.
			local x, y, zone = NWB:GetPlayerZonePosition();
			if (zone ~= 1412 or (y > 0.394447705692 or y < 0.37847691674407
					or x > 0.37333657662182 or x < 0.36484996019735)) then
				return;
			end
		end
		return true;
	end

	function NWB:dmfPosTicker()
		if (not doDmfScan or not NWB:verifyDmfZone()) then
			NWB:debug("Stopping DMF scan.");
			NWB:disableDmfFrame();
			clickedDmfFrameClose = nil;
			return;
		end
		if (NWB:verifyDmfPos()) then
			NWB:enableDmfFrame();
		else
			NWB:disableDmfFrame();
		end
		C_Timer.After(1, function()
			NWB:dmfPosTicker();
		end)
	end

	SLASH_NWBDMFHELPERCMD1, SLASH_NWBDMFHELPERCMD2 = '/dmfhelper', '/stuckhelper';
	function SlashCmdList.NWBDMFHELPERCMD(msg, editBox)
		NWBDmfFrame:Show();
	end

	function NWB:enableDmfFrame()
		local pvpType = GetZonePVPInfo();
		if (not UnitIsGhost("player") or not NWB.db.global.dmfFrame or pvpType ~= "hostile") then
			return;
		end
		if (NWB.db.global.dmfFrame and not NWBDmfFrame:IsShown() and not clickedDmfFrameClose) then
			NWBDmfFrame:Show();
			NWB:debug("Showing DMF frame.");
		end
	end

	function NWB:disableDmfFrame()
		clickedDmfFrameClose = nil;
		if (NWBDmfFrame:IsShown()) then
			NWBDmfFrame:Hide();
			NWB:debug("Hiding DMF frame.");
		end
	end
end