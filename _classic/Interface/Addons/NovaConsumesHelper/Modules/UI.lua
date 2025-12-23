-------------------------------
---NovaConsumesHelper frames--
-------------------------------
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local _, NCH = ...;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaConsumesHelper");
local MasqueGroup = NCH.MasqueGroup;

function NCH:createButtonsFrame(name, x, y, buttonWidth, buttonHeight, loadExtraText, loadProgressBar)
	if (_G[name]) then
		return;
	end
	local frame = CreateFrame("Frame", name, UIParent, "BackdropTemplate");
	frame.useAnchor = true; --Use a 1 pixel frame anchor so the frame grows in the right directions.
	frame.defaultX = x;
	frame.defaultY = y;
	frame:EnableMouse(true);
	frame:SetClampedToScreen(true);
	frame.resetPosition = function()
		frame:ClearAllPoints();
		frame:SetPoint("TOPLEFT", UIParent, "CENTER", frame.defaultX or 0, frame.defaultY or 0);
		frame.savePosition();
	end
	frame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		insets = {top = 0, left = 0, bottom = 0, right = 0},
		edgeFile = [[Interface/Buttons/WHITE8X8]], 
		edgeSize = 1,
	});
	frame:SetBackdropColor(0, 0, 0, 0.3);
	frame:SetBackdropBorderColor(1, 1, 1, 0.5);
	
	frame.fs = frame:CreateFontString("$parentFS", "ARTWORK");
	frame.fs:SetPoint("CENTER", 0, 1);
	--frame.fs:SetFontObject(GameFontHighlightSmallOutline);
	frame.fs:SetFont(STANDARD_TEXT_FONT, 11);
	frame.fs.t = "|cFFFFFF00Set consumes\nin config";
	
	if (frame.useAnchor) then
		frame.anchor = CreateFrame("Frame", name .."Anchor", UIParent);
		frame.anchor:SetSize(1, 1);
		frame:SetParent(frame.anchor);
		frame:SetPoint("TOPLEFT", frame.anchor, "CENTER");
		frame.anchor:SetPoint("TOPLEFT", UIParent, "CENTER", x or 0, y or 0);
		frame.anchor:SetMovable(true);
	else
		frame:SetPoint("TOPLEFT", UIParent, "CENTER", x or 0, y or 0);
		frame:SetMovable(true);
		frame:SetUserPlaced(false);
	end
	frame.savePosition = function()
		local db = NCH.db.global;
		if (frame.anchor) then
			frame.anchor:SetUserPlaced(false);
			local frameName = frame.anchor:GetName();
			db[frameName .. "_point"], _, db[frameName .. "_relativePoint"], db[frameName .. "_x"], db[frameName .. "_y"] = frame.anchor:GetPoint();
		else
			frame:SetUserPlaced(false);
			local frameName = frame:GetName();
			db[frameName .. "_point"], _, db[frameName .. "_relativePoint"], db[frameName .. "_x"], db[frameName .. "_y"] = frame:GetPoint();
		end
	end
	frame.loadPosition = function()
		if (frame.anchor) then
			if (NCH.db.global[frame.anchor:GetName() .. "_point"]) then
				frame.anchor:ClearAllPoints();
				frame.anchor.ignoreFramePositionManager = true;
				--frame.ignoreFramePositionManager = true;
				local db = NCH.db.global;
				local frameName = frame.anchor:GetName();
				frame.anchor:SetPoint(db[frameName .. "_point"], nil, db[frameName .. "_relativePoint"], db[frameName .. "_x"], db[frameName .. "_y"]);
				frame.anchor:SetUserPlaced(false);
				--frame:SetUserPlaced(false);
			end
		else
			if (NCH.db.global[frame:GetName() .. "_point"]) then
				frame:ClearAllPoints();
				frame.ignoreFramePositionManager = true;
				local db = NCH.db.global;
				local frameName = frame:GetName();
				frame:SetPoint(db[frameName .. "_point"], nil, db[frameName .. "_relativePoint"], db[frameName .. "_x"], db[frameName .. "_y"]);
				frame:SetUserPlaced(false);
			end
		end
	end
	frame.loadPosition();
	
	--This top bar acts like it's invisible by changing alpha and hiding buttons/fonts.
	--This lets us show the frame when entering the space with mouse.
	local topBar = CreateFrame("Frame", name, frame, "BackdropTemplate");
	topBar:SetHeight(17);
	topBar:EnableMouse(true);
	topBar:SetPropagateMouseClicks(true); --Have mouseclicks pass though the frame.
	topBar:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, -2);
	--topBar:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -2);
	topBar:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		insets = {top = 0, left = 1, bottom = 2, right = 1},
		--edgeFile = [[Interface/Buttons/WHITE8X8]], 
		--edgeSize = 1,
	});
	topBar:SetBackdropColor(0, 0, 0, 0);
	topBar.updateText = function()
		if (not frame.locked) then
			if (frame.hasButtonsShown) then
				--If buttons are showing.
				topBar:SetBackdropColor(0, 0, 0, 0.3);
				if (frame.buttonWidthCount < 2) then
					topBar.fs:SetText("");
				else
					topBar.fs:SetText("|cFF9CD6DEDrag");
				end
			else
				--Else if no buttons are showing becaus no consuems are set yet (likely first run of the addon).
				--Then we always show the top bar.
				topBar:SetBackdropColor(0, 0, 0, 0.3);
				topBar.fs:SetText("|cFF9CD6DEDrag");
			end
		else
			topBar:SetBackdropColor(0, 0, 0, 0.3);
			topBar.fs:SetText("|cFF9CD6DELocked");
		end
		topBar.disable();
	end
	topBar.enable = function()
		if (not frame.disableMenuBar) then
			topBar.updateText();
			topBar.configButton:Show();
			topBar.profilesButton:Show();
			topBar.enabled = true;
		end
	end
	topBar.disable = function()
		if (not topBar.isMouseOver()) then
			topBar:SetBackdropColor(0, 0, 0, 0);
			topBar.configButton:Hide();
			topBar.profilesButton:Hide();
			topBar.fs:SetText("");
			topBar.enabled = nil;
		end
	end
	topBar.isMouseOver = function()
		--if (topBar:IsMouseOver() or topBar.configButton:IsMouseOver() or topBar.profilesButton:IsMouseOver() or topBar.profilesButton.Button:IsMouseOver()) then
		if (topBar:IsMouseOver() or topBar.configButton:IsMouseOver() or topBar.profilesButton:IsMouseOver()) then
			return true;
		end
		if (topBar.profilesButton.profilesListFrame and topBar.profilesButton.profilesListFrame:IsMouseOver()) then
			return true;
		end
		if (frame:IsMouseOver() and not frame.hasButtonsShown) then
			return true;
		end
		--[[for i = 1, 3 do
			local dropdown = _G["L_DropDownList" .. i]
			if (dropdown and dropdown.dropdown == topBar.profilesButton) then
				if (dropdown:IsMouseOver()) then
					return true;
				end
			end
		end]]
	end
	
	topBar.fs = topBar:CreateFontString("$parentTimerText", "OVERLAY");
	topBar.fs:SetPoint("LEFT", 7, 2);
	--topBar.fs:SetFont(STANDARD_TEXT_FONT, topBar:GetHeight() * 0.7, "OUTLINE");
	topBar.fs:SetFont(STANDARD_TEXT_FONT, 10);
	topBar:SetScript("OnEnter", function(self)
		topBar.enable();
	end)
	topBar:SetScript("OnLeave", function(self)
		topBar.disable();
	end)
	--Using SetPropagateMouseClicks() here lets us drag the frame without the click going through.
	--But does lets the click go through if we just click and don't hold mouse down to drag, I assume because the click through is on mouse up.
	topBar:SetScript("OnMouseDown", function(self, button)
		if (InCombatLockdown()) then
			return;
		end
		local f;
		if (frame.anchor) then
			f = frame.anchor;
		else
			f = self:GetParent();
		end
		if (button == "LeftButton" and not f.isMoving and not frame.locked) then
			f:StartMoving();
			f.isMoving = true;
		end
		topBar:SetPropagateMouseClicks(false);
	end)
	topBar:SetScript("OnMouseUp", function(self, button)
		local f;
		if (frame.anchor) then
			f = frame.anchor;
		else
			f = self:GetParent();
		end
		if (button == "LeftButton" and f.isMoving) then
			f:StopMovingOrSizing();
			f.isMoving = false;
			frame.savePosition();
		end
		if (not InCombatLockdown()) then
			topBar:SetPropagateMouseClicks(true);
		end
	end)
	topBar:SetScript("OnHide", function(self)
		local f;
		if (frame.anchor) then
			f = frame.anchor;
		else
			f = self:GetParent();
		end
		if (f.isMoving) then
			f:StopMovingOrSizing();
			f.isMoving = false;
		end
		topBar:SetPropagateMouseClicks(true);
	end)
	topBar.configButton = CreateFrame("Button", "$parentConfigButton", topBar, "UIPanelButtonTemplate");
	topBar.configButton:SetPoint("TOPRIGHT", -4, -2);
	topBar.configButton:SetWidth(12);
	topBar.configButton:SetHeight(10);
	topBar.configButton:SetText("|TInterface\\Buttons\\UI-OptionsButton:10|t");
	topBar.configButton:SetScript("OnClick", function(self, arg)
		NCH:openConfig();
	end)
	topBar.configButton:Hide();
	
	topBar.profilesButton = CreateFrame("Button", "$parentNormalButton", topBar, "NCH_EJButtonTemplate");
	topBar.profilesButton:SetSize(5, 16);
	topBar.profilesButton:SetAlpha(0.9);
	--topBar.profilesButton:SetPoint("RIGHT", -34, 1);
	--topBar.profilesButton:SetText("|cFFFFFFFF" .. L["Profiles"]);
	topBar.profilesButton:SetPoint("RIGHT", -34, 1);
	topBar.profilesButton:SetText("|cFFFFFFFFP");
	topBar.profilesButton:SetScript("OnClick", function(self, arg)
		if (NCH.profilesListFrame and NCH.profilesListFrame:IsShown()) then
			NCH.profilesListFrame:Hide();
		else
			NCH:openProfilesList(topBar.profilesButton);
		end
	end);
	topBar.profilesButton:Hide();
		
	frame.topBar = topBar;
	frame.updateTopBar = function()
		local growDown = (frame.growthDirection == 1);
		if (growDown) then
			topBar:ClearAllPoints();
			topBar:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, -2);
			topBar.fs:SetPoint("CENTER", -2, 1);
			topBar.configButton:SetPoint("TOPRIGHT", -4, -2);
		else
			topBar:ClearAllPoints();
			topBar:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 2);
			topBar.fs:SetPoint("CENTER", -2, 0);
			topBar.configButton:SetPoint("TOPRIGHT", -4, -4);
		end
	end
	frame.topBar.lastUpdate = 0;
	frame.topBar:SetScript("OnUpdate", function(self)
		--Update throddle.
		if (GetTime() - frame.topBar.lastUpdate > 0.05) then
			frame.topBar.lastUpdate = GetTime();
			--Hacky fix for frame occasionally not hiding for now.
			if (topBar.enabled and not topBar.isMouseOver()) then
				topBar.disable();
			end
		end
	end)
	--[[frame.tooltip = CreateFrame("Frame", frame:GetName() .. "Tooltip", frame, "TooltipBorderedFrameTemplate");
	frame.tooltip:SetPoint("BOTTOM", frame, "TOP", 0, 2);
	frame.tooltip:SetFrameStrata("TOOLTIP");
	frame.tooltip:SetFrameLevel(999);
	frame.tooltip.fs = frame.tooltip:CreateFontString(frame:GetName() .. "NCHTooltipFS", "ARTWORK");
	frame.tooltip.fs:SetPoint("CENTER", 0, 0);
	--frame.tooltip.fs:SetFont(NCH.regionFont, 11);
	frame.tooltip.fs:SetJustifyH("LEFT");
	frame.showTooltip = function()
		--Use a function to show tooltip so we can disable showing tooltip if frame isn't being dragged for first install.
		frame.tooltip:Show();
	end]]

	frame.showAlpha = function()
		frame:SetBackdropColor(0, 0, 0, 0.3);
	end
	frame.hideAlpha = function()
		frame:SetBackdropColor(0, 0, 0, 0);
	end
	
	frame:SetScript("OnEnter", function(self)
		--[[local point = frame:GetPoint();
		frame.tooltip:ClearAllPoints();
		if (point == "TOPRIGHT" or point == "TOPLEFT") then
			frame.tooltip:SetPoint("TOP", frame, "BOTTOM", 0, -2);
		else
			frame.tooltip:SetPoint("BOTTOM", frame, "TOP", 0, 2);
		end
		if (frame.tooltip.fs:GetText() and frame.tooltip.fs:GetText() ~= "") then
			frame.showTooltip();
		end]]
		if (not frame.hasButtonsShown) then
			topBar.enable();
		end
	end)
	frame:SetScript("OnLeave", function(self)
		--frame.tooltip:Hide();
		if (not topBar.isMouseOver()) then
			topBar.disable();
		end
	end)
	--[[frame.tooltip:Hide();
	frame.updateTooltip = function(text)
		frame.tooltip.fs:SetText(text);
		frame.tooltip:SetWidth(frame.tooltip.fs:GetStringWidth() + 18);
		frame.tooltip:SetHeight(frame.tooltip.fs:GetStringHeight() + 12);
	end]]
	--[[frame.OnMouseUpFunc = function(self, button)
		if (button == "LeftButton" and frame.isMoving) then
			frame:StopMovingOrSizing();
			frame.isMoving = false;
			frame.savePosition();
		end
	end
	frame.OnMouseDownFunc = function(self, button, shift)
		if (button == "LeftButton" and not frame.isMoving) then
			if (shift or not frame.locked) then
				frame:StartMoving();
				frame.isMoving = true;
			end
		end
	end
	frame.OnHideFunc = function(self, button)
		if (frame.isMoving) then
			frame:StopMovingOrSizing();
			frame.isMoving = false;
		end
	end
	frame:SetScript("OnMouseDown", function(self, button)
		frame.OnMouseDownFunc(self, button);
	end)
	frame:SetScript("OnMouseUp", function(self, button)
		frame.OnMouseUpFunc(self, button);
	end)
	frame:SetScript("OnHide", function(self)
		frame.OnHideFunc(self);
	end)]]
	frame.buttons = {};
	frame.buttonWidth = buttonWidth;
	frame.buttonHeight = buttonHeight;
	frame.getButton = function(parent, id)
		for k, v in ipairs(frame.buttons) do
			if (v.count == id) then
				return v;
			end
		end
		local count = #frame.buttons + 1;
	
		local button = CreateFrame("Button", "$parentButton" .. id, frame, "ActionButtonTemplate,SecureActionButtonTemplate");
		button:SetAttribute("type1", "macro");
		--button:RegisterForClicks("AnyUp", "AnyDown")
		button:RegisterForClicks("AnyDown")
		button:SetWidth(frame.buttonWidth);
		button:SetHeight(frame.buttonHeight);
		
		button.borderFrame = CreateFrame("Frame", "$parentBorderFrame", button, "BackdropTemplate");
		local borderSpacing = 0.5;
		button.borderFrame:SetPoint("TOP", 0, borderSpacing);
		button.borderFrame:SetPoint("BOTTOM", 0, -borderSpacing);
		button.borderFrame:SetPoint("LEFT", -borderSpacing, 0);
		button.borderFrame:SetPoint("RIGHT", borderSpacing, 0);
		--button.borderFrame:SetBackdrop({
		--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			--tileEdge = true,
		--	edgeSize = 12,
			--insets = {top = 5, left = 5, bottom = 5, right = 5},
		--});
		
		button.label = button:CreateFontString("$parentLabel", "ARTWORK");
		button.label:SetPoint("top", 0, 1);
		button.label:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.35, "OUTLINE");
		
		button.fs = button:CreateFontString("$parentTimerText", "OVERLAY");
		button.fs:SetPoint("CENTER", 0, 0);
		button.fs:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.5, "OUTLINE");
		
		button.fs2 = button:CreateFontString("$parentTimerText", "OVERLAY");
		button.fs2:SetPoint("CENTER", 0, 0);
		button.fs2:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.35, "OUTLINE");
		
		if (loadExtraText) then
			button.fs2 = button:CreateFontString("$parentText2", "OVERLAY");
			button.fs2:SetPoint("BOTTOM", button, "TOP", 0, 8);
			--button.fs2:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.5, "OUTLINE");
			button.fs2:SetFontObject(NCH_GameFontItemCount);
		end
		if (loadProgressBar) then
			local f = CreateFrame("Frame", "$parentProgressBar", button, "BackdropTemplate");
			f:SetSize(1, 4);
			f:SetBackdrop({
				bgFile = "Interface\\Buttons\\WHITE8x8",
				insets = {top = 0, left = 0, bottom = 0, right = 0},
				--edgeFile = [[Interface/Buttons/WHITE8X8]], 
				--edgeSize = 1,
			});
			f:SetBackdropColor(1, 0, 0, 0.7);
			--f:SetBackdropBorderColor(1, 1, 1, 1);
			f:SetPoint("LEFT");
			f:SetPoint("RIGHT");
			f:SetPoint("BOTTOM", button, "TOP", 0, 2);
			f.texture = f:CreateTexture("$parentCheckTexture");
			f.texture:SetAllPoints();
			f.texture:SetColorTexture(0, 0.78, 0, 0.9)
			f:Hide();
			button.progressBar = f;
		end
		button.itemCount = button:CreateFontString("$parentItemCount", "ARTWORK");
		button.itemCount:SetPoint("BOTTOMRIGHT", 0, 0);
		--button.itemCount:SetFontObject(GameFontHighlightSmallOutline);
		--button.itemCount:SetFontObject(GameFontHighlightOutline);
		button.itemCount:SetFontObject(NCH_GameFontItemCount);
		
		button.fsEating = button:CreateFontString("$parentFSEating", "ARTWORK");
		button.fsEating:SetPoint("CENTER", 0, 1);
		button.fsEating:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE");
		
		button.checkTexture = button:CreateTexture("$parentCheckTexture", "ARTWORK", nil, 3);
		button.checkTexture:SetPoint("CENTER", 0, 0);
		button.checkTexture:SetSize(button:GetWidth() * 0.6, button:GetWidth() * 0.6);
	
		button:HookScript("OnClick", function(self, b)
			if (button.onClickFunction) then
				--If we declare an on click function for this button.
				NCH[button.onClickFunction](self, button);
			end
		end)
		
		button:HookScript("OnEnter", function(self, b)
			if (button.tooltipItemID) then
				GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
				GameTooltip:SetItemByID(button.tooltipItemID);
				GameTooltip:Show();
			elseif (button.tooltipSpellID) then
				GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
				GameTooltip:SetSpellByID(button.tooltipSpellID);
				GameTooltip:Show();
			end
		end)
		button:HookScript("OnLeave", function(self, b)
			if (button.tooltipItemID) then
				GameTooltip:Hide();
			end
		end)
		
		button.cooldown:SetEdgeTexture("Interface\\Cooldown\\edge");
		button.cooldown:SetSwipeColor(0, 0, 0);
		button.cooldown:SetHideCountdownNumbers(false);
		button.cooldown.currentCooldownType = COOLDOWN_TYPE_NORMAL;
		
		--[[button:SetScript("OnEnter", function(self)
			topBar:Show();
		end)
		button:SetScript("OnLeave", function(self)
			if (not topBar:IsMouseOver() and not frame:IsMouseOver()) then
				topBar:Hide();
			end
		end)]]
		
		frame.buttons[id] = button;
		if (NCH.MasqueGroup) then
			NCH.MasqueGroup:AddButton(button);
		end
		return button;
	end
	frame.clearAllPoints = function(parent)
		for k, v in ipairs(frame.buttons) do
			v:ClearAllPoints();
		end
	end
	
	frame.growthDirection = 1; --Down, can be changed in options.
	frame.buttonsWide = 5;
	frame.padding = 3;
	frame.borderSpacing = 2;
	frame.buttonWidthCount = 0;
	frame.buttonHeightCount = 0;
	frame.clearAllButtonPoints = function(isOnUpdate)
		for k, v in pairs(frame.buttons) do
			v:ClearAllPoints();
		end
	end
	frame.lastButtonCount = 0;
	frame.sortButtons = function(isOnUpdate)
		local buttonsWide = frame.buttonsWide;
		local padding = frame.padding;
		local growDown = (frame.growthDirection == 1);
		local lastFrame, lastStartRow;
		local count = 0;
		local buttonWidthCount, buttonHeightCount = 0, 0;
		for k, v in ipairs(frame.buttons) do
			if (v.show) then
				count = count + 1;
				if (growDown) then
					if (count == 1) then
						v:SetPoint("TOPLEFT", frame.borderSpacing, -frame.borderSpacing);
						lastStartRow = v;
						buttonWidthCount = 1;
						buttonHeightCount = 1;
					else
						--if (count % (buttonsWide + 1) == 0) then
						if ((count - 1) % buttonsWide == 0) then
							--If we've reached max buttons for the last row and starting a new one.
							v:SetPoint("TOPLEFT", lastStartRow, "BOTTOMLEFT", 0, -padding);
							lastStartRow = v;
							buttonHeightCount = buttonHeightCount + 1;
							buttonWidthCount = buttonsWide;
						else
							v:SetPoint("TOPLEFT", lastFrame, "TOPRIGHT", padding, 0);
							if (buttonWidthCount < buttonsWide) then
								buttonWidthCount = buttonWidthCount + 1;
							end
						end
					end
				else
					if (count == 1) then
						v:SetPoint("BOTTOMLEFT", frame.borderSpacing, frame.borderSpacing);
						lastStartRow = v;
						buttonWidthCount = 1;
						buttonHeightCount = 1;
					else
						--if (count % (buttonsWide + 1) == 0) then
						if ((count - 1) % buttonsWide == 0) then
							--If we've reached max buttons for the last row and starting a new one.
							v:SetPoint("BOTTOMLEFT", lastStartRow, "TOPLEFT", 0, padding);
							lastStartRow = v;
							buttonHeightCount = buttonHeightCount + 1;
							buttonWidthCount = buttonsWide;
						else
							v:SetPoint("BOTTOMLEFT", lastFrame, "BOTTOMRIGHT", padding, 0);
							if (buttonWidthCount < buttonsWide) then
								buttonWidthCount = buttonWidthCount + 1;
							end
						end
					end
				end
				v:Show();
				lastFrame = v;
				--Handled desaturate in the update func instead, so it can be done in combat.
				--if (v.desaturate) then
				--	v.normalTexture:SetDesaturated(true);
				--else
				--	v.normalTexture:SetDesaturated(false);
				--end
			else
				v:ClearAllPoints();
				v:Hide();
			end
			if (v.disabled) then
				--Set normal texture display before we disable.
				--If button is still held down when button is disabled then the pushed texture gets stuck displaying.
				v:SetButtonState("NORMAL");
				v:Disable();
			else
				v:Enable();
			end
		end
		frame.buttonWidthCount = buttonWidthCount;
		frame.buttonHeightCount = buttonHeightCount;
		if (not isOnUpdate) then
			frame.updateSize(buttonWidthCount * frame.buttonWidth, buttonHeightCount * frame.buttonHeight, "sortButtons");
		end
		if (count > 0) then
			frame.hasButtonsShown = true;
			--frame.fs:Hide();
			--frame.topBar.disable();
		else
			frame.hasButtonsShown = false;
			--frame.topBar.enable();
			--frame.fs:Show();
		end
		if (frame.lastButtonCount ~= count) then
			frame.updateSize();
		end
		frame.lastButtonCount = count;
	end
	frame.updateDisplayState = function(fromTimer)
		if (frame.hasItemsLoaded and not frame.hasButtonsShown) then
			--If some items are set in config but we're not showing any buttons becaus of other options like hide when no items in bags etc.
			frame.fs:Hide();
			frame.hideAlpha();
		elseif (frame.hasAnyBuff and not frame.hasButtonsShown) then
			--If we have hide when buff enabled and a buff is up and no buttons shown we must have all buffs.
			frame.fs:Hide();
			frame.hideAlpha();
		elseif (frame.hasButtonsShown) then
			--Show background when any buttons are displayed.
			frame.fs:Hide();
			frame.showAlpha();
		else
			frame.fs:SetText(frame.fs.t);
			frame.fs:Show();
			frame.showAlpha();
		end
		if (not fromTimer) then
			--Temp fix for now, upate this again again shortly after. seems to be an issue with auras not showing as applied fast enough?
			C_Timer.After(0.2, function()
				frame.updateDisplayState(true);
			end)
		end
	end
	frame.updateBorder = function()
		if (frame.hasItemsLoaded and not frame.hasButtonsShown) then
			frame:SetBackdropBorderColor(0, 0, 0, 0);
		elseif (frame.hasAnyBuff and not frame.hasButtonsShown) then
			--Don't show border if we are hidding buttons when buffed.
			frame:SetBackdropBorderColor(0, 0, 0, 0);
		elseif (frame.hasButtonsShown) then
			--Don't show border if we have buttons shown (not first install).
			frame:SetBackdropBorderColor(0, 0, 0, 0);
		else
			frame:SetBackdropBorderColor(1, 1, 1, 0.5);
		end
	end
	frame.updateSize = function(width, height, source)
		local widthPadding = frame.padding * (frame.buttonWidthCount - 1);
		local heightPadding = frame.padding * (frame.buttonHeightCount - 1);
		--If no width/height specified, or no buttons displayed, set to size of 3 buttons.
		--Size + border spacing + padding.
		if (not frame.hasButtonsShown) then
			frame:SetSize(frame.buttonWidth * 4 + (frame.borderSpacing * 2) + widthPadding, frame.buttonHeight + (frame.borderSpacing * 2) + heightPadding);
			topBar:SetWidth(frame.buttonWidth * 4 + (frame.borderSpacing * 2) + widthPadding);
		else
			if (not width) then
				--If no width specified (by updateButtons() in Main.lua).
				--Then use our current buttons setup.
				width = frame.buttonWidthCount * frame.buttonWidth;
				height =  frame.buttonHeightCount * frame.buttonHeight;
			end
			if (frame.buttonWidthCount < 3) then
				topBar:SetWidth(frame.buttonWidth * 3 + (frame.borderSpacing * 2) + widthPadding);
			else
				topBar:SetWidth(width + (frame.borderSpacing * 2) + widthPadding);
			end
			frame:SetSize(width + (frame.borderSpacing * 2) + widthPadding, height + (frame.borderSpacing * 2) + heightPadding);
			--Restrict width of top bar to 3 buttons wide.
			--if (frame.buttonWidthCount > 3) then
			--	topBar:SetWidth(frame.buttonWidth * 3 + (frame.borderSpacing * 2) + widthPadding);
			--else
				--topBar:SetWidth(width + (frame.borderSpacing * 2) + widthPadding);
			--end
		end
		frame.updateDisplayState();
		if (frame.anchor) then
			if (frame.growthDirection == 1) then
				frame:ClearAllPoints();
				frame:SetPoint("TOPLEFT", frame.anchor, "CENTER");
			else
				frame:ClearAllPoints();
				frame:SetPoint("BOTTOMLEFT", frame.anchor, "CENTER");
			end
		end
	end
	frame.updateSize();
	frame.lastUpdate = 0;
	frame:SetScript("OnUpdate", function(self)
		--Update throddle.
		if (GetTime() - frame.lastUpdate > 1) then
			frame.lastUpdate = GetTime();
			--frame:sortButtons(); -Sort
			if (frame.onUpdateFunction) then
				--If we declare an update function for this frame to run when shown.
				NCH[frame.onUpdateFunction](self, true);
				--Hacky fix for frame occasionally not hiding for now.
				if (topBar.enabled and not topBar.isMouseOver() and not frame:IsMouseOver()) then
					topBar.disable();
				end
			end
		end
	end)
	frame.updateDimensions = function()
		local width = frame.buttonWidth;
		local height = frame.buttonHeight;
		local textureHeight = height;
		if (textureHeight > 22) then
			textureHeight = 22;
		end
		for k, v in ipairs(frame.buttons) do
			v:SetWidth(width);
			v:SetHeight(height);
			if (not MasqueGroup) then
				v.NormalTexture:SetSize(textureHeight - 2, textureHeight - 2);
			end
			
			v.label:SetFont(STANDARD_TEXT_FONT, v:GetWidth() * 0.35, "OUTLINE");
			v.fs:SetFont(STANDARD_TEXT_FONT, v:GetWidth() * 0.5, "OUTLINE");
			--v.itemCount:SetFontObject(NumberFontNormal);
			v.checkTexture:SetSize(v:GetWidth() * 0.6, v:GetWidth() * 0.6);
		end
		frame:SetSize(width, height);
		--frame.displayTab:SetSize(width, height);
		frame.updateDisplayState();
	end
	return frame;
end

function NCH:createListFrame(name, x, y, buttonWidth, buttonHeight)
	local frame = CreateFrame("Frame", name, UIParent, "TooltipBorderedFrameTemplate");
	frame:SetBackdropColor(0, 0, 0, 1);
	frame:SetFrameStrata("HIGH");
	--frame:EnableMouse(true);
	frame:SetClampedToScreen(true);
	--frame:SetBackdrop({
	--	bgFile = "Interface\\Buttons\\WHITE8x8",
	--	insets = {top = 0, left = 0, bottom = 0, right = 0},
	--	edgeFile = [[Interface/Buttons/WHITE8X8]], 
	--	edgeSize = 1,
	--});
	--frame:SetBackdropColor(0, 0, 0, 0.8);
	--frame:SetBackdropBorderColor(1, 1, 1, 0.5);
	
	frame.lastUpdate = 0;
	frame:SetScript("OnUpdate", function(self)
		--Update throddle.
		if (GetTime() - frame.lastUpdate > 0.1) then
			frame.lastUpdate = GetTime();
			--Hacky fix for frame occasionally not hiding for now.
			if (not frame:IsMouseOver() and not frame.anchorFrame:IsMouseOver()) then
				frame:Hide();
			end
		end
	end)
	
	frame.title = frame:CreateFontString(name .. "LineFSTitle", "ARTWORK");
	frame.title:SetPoint("TOP", 0, -5);
	frame.title:SetFontObject(GameFontNormalSmall);
			
	frame.lineFrames = {};
	frame.getLineFrame = function(count, data)
		if (not frame.lineFrames[count]) then
			frame.createlineFrame(count, data);
		end
		return frame.lineFrames[count];
	end
	frame.createlineFrame = function(count)
		if (not frame.lineFrames[count]) then
			local obj = CreateFrame("Button", name .. "SimpleLine" .. count, frame);
			obj:RegisterForClicks("LeftButtonDown", "RightButtonDown");
			--[[obj.normalTex = obj:CreateTexture("$parentNormalTexture", "ARTWORK");
			obj.normalTex:SetAlpha(0.5);
			obj.normalTex:SetTexture("Interface\\Addons\\NovaRaidCompanion\\Media\\TrainerTextures2");
			obj.normalTex:SetTexCoord(0.00195313, 0.57421875, 0.65820313, 0.75000000);]]
			--normal:SetColorTexture(1, 1, 1);
			
			obj.highlightTex = obj:CreateTexture("$parentHighlightTexture", "HIGHLIGHT");
			obj.highlightTex:SetAlpha(0.5);
			--UI-EJ-BossButton-Highlight.
			obj.highlightTex:SetTexture("Interface\\ClassTrainerFrame\\TrainerTextures");
			obj.highlightTex:SetTexCoord(0.00195313, 0.57421875, 0.75390625, 0.84570313);
			obj:SetHighlightTexture(obj.highlightTex);
			
			--[[obj.pushedTexture = obj:CreateTexture(nil, nil);
			obj.pushedTexture:SetTexture("Interface\\Buttons\\UI-Quickslot-Depress");
			obj.pushedTexture:SetAllPoints();
			obj.pushedTexture:SetPoint("CENTER");
			obj:SetPushedTexture(obj.pushedTexture);]]
			
			obj.count = count;
			--local bg = obj:CreateTexture(nil, "HIGHLIGHT");
			--bg:SetAllPoints(obj);
			--obj.texture = bg;
			obj.leftTexture = obj:CreateTexture(nil);
			obj.leftTexture:SetSize(50, 41);
			obj.leftTexture:SetScale(0.8);
			obj.leftTexture:SetPoint("LEFT", 42, 0);
			obj.fs = obj:CreateFontString(name .. "LineFS" .. count, "ARTWORK");
			obj.fs:SetPoint("LEFT", 1, 0);
			obj.fs:SetFontObject(GameFontNormalSmall);
			--They don't quite line up properly without justify on top of set point left.
			obj.fs:SetJustifyH("LEFT");
			obj:EnableMouse(true);
			frame.lineFrames[count] = obj;
		end
	end
	frame.hideAllLineFrames = function()
		for k, v in pairs(frame.lineFrames) do
			v:Hide();
		end
	end
	frame:Hide();
	return frame;
end

local seperator;
function NCH:openProfilesList(anchorFrame)
	if (not anchorFrame.profilesListFrame) then
		NCH.profilesListFrame = NCH:createListFrame("NCHProfilesListFrame");
		anchorFrame.profilesListFrame = NCH.profilesListFrame;
	end
	local frame = NCH.profilesListFrame;
	frame.anchorFrame = anchorFrame;
	frame:SetPoint("LEFT", anchorFrame, "CENTER");
	--frame:SetSize(100, 100);
	frame:hideAllLineFrames();
	frame.title:SetText("Select Profile");
	
	local profiles = NCH:getActiveProfiles();
	if (next(profiles)) then
		local count = 0;
		local startOffset, offset, height, padding = 25, 0, 14, 0;
		local maxWidth = 0;
		for k, v in NCH:pairsByKeys(profiles) do
			count = count +1;
			local lineFrame = frame.getLineFrame(count);
			lineFrame:ClearAllPoints();
			lineFrame:SetPoint("LEFT", frame, "TOPLEFT", 6, -(startOffset + offset + padding));
			offset = offset + height + padding;
			lineFrame.fs:SetText("|cFFFFFFFF" .. k);
			lineFrame:SetHeight(lineFrame.fs:GetHeight() + 3);
			local stringWidth = lineFrame.fs:GetStringWidth();
			if (stringWidth > maxWidth) then
				maxWidth = stringWidth;
			end
			lineFrame:SetScript("OnClick", function(self, arg)
				if (InCombatLockdown()) then
					NCH:print("You can't swap profiles in combat.")
				else
					NCH:setProfile(k);
					NCH:print("Changed profile to: |cFF00FF00" .. k .. "|r");
					frame:Hide();
					_G["NCHMainFrame"].topBar.updateText();
				end
			end)
			lineFrame:Show();
		end
		
		--Add a "open profile settings" line.
		local lineFrame = frame.getLineFrame(count + 1);
		lineFrame:ClearAllPoints();
		lineFrame:SetPoint("LEFT", frame, "TOPLEFT", 6, -(startOffset + offset + padding + 3));
		offset = offset + height + padding;
		lineFrame.fs:SetText("|cFFFFFF00Profile Settings");
		lineFrame:SetHeight(lineFrame.fs:GetHeight() + 3);
		local stringWidth = lineFrame.fs:GetStringWidth();
		if (stringWidth > maxWidth) then
			maxWidth = stringWidth;
		end
		lineFrame:SetScript("OnClick", function(self, arg)
			if (InCombatLockdown()) then
				NCH:print("You can't open profile settings in combat.")
			else
				NCH:openConfig(true);
				frame:Hide();
				_G["NCHMainFrame"].topBar.updateText();
			end
		end)
		lineFrame:Show();
		
		if (not seperator) then
			seperator = frame:CreateTexture(nil, "BORDER");
			seperator:SetColorTexture(0.6, 0.6, 0.6, 0.85);
			seperator:SetHeight(1);
			seperator:SetPoint("LEFT", 5, 0);
			seperator:SetPoint("RIGHT", -5, 0);
		end
		seperator:SetPoint("TOP", lineFrame.fs, "top", 0, 4);
	
		for k, v in pairs(frame.lineFrames) do
			v:SetWidth(maxWidth + 4);
		end
		frame:SetWidth(maxWidth + 15);
		frame:SetHeight(startOffset + offset);
		frame:Show();
	else
		NCH:print("No custom profiles found, only default profile created.");
	end
end

--[[function NCH:addDropDownMenu(name, parent)
	local frame = NCH.DDM:Create_UIDropDownMenu(name, parent)
	--frame:SetPoint("TOPLEFT", -14, -17);
	--frame:SetFrameStrata("HIGH");
	--frame:SetFrameLevel(2);
	--frame:SetSize(width, height);
	--NCH.DDM:UIDropDownMenu_SetWidth(frame, width)
	frame.tooltip = CreateFrame("Frame", name .. "Tooltip", frame, "TooltipBorderedFrameTemplate");
	frame.tooltip:SetPoint("TOPLEFT", 30, 45);
	frame.tooltip:SetFrameStrata("TOOLTIP");
	frame.tooltip:SetFrameLevel(9);
	frame.tooltip.fs = frame.tooltip:CreateFontString(name .. "TooltipFS", "ARTWORK");
	frame.tooltip.fs:SetPoint("CENTER", 0, 0);
	frame.tooltip.fs:SetFontObject(GameFontSmall);
	--frame.tooltip.fs:SetText("|Cffffd000");
	--frame.tooltip:SetWidth(frame.tooltip.fs:GetStringWidth() + 18);
	--frame.tooltip:SetHeight(frame.tooltip.fs:GetStringHeight() + 12);
	frame.tooltip:Hide();
	frame.initialize = function(dropdown)
		local profiles = NCH:getActiveProfiles();
		local currentProfile = "Test";
		for k, v in NCH:pairsByKeys(profiles) do
			local info = NCH.DDM:UIDropDownMenu_CreateInfo()
			info.text = k;
			info.checked = false;
			info.value = k;
			info.func = function(self)
				NCH.DDM:UIDropDownMenu_SetSelectedValue(dropdown, self.value)
				NCH:updateConfigOptions();
			end
			NCH.DDM:UIDropDownMenu_AddButton(info);
		end
		if (not NCH.DDM:UIDropDownMenu_GetSelectedValue(frame)) then
			--If no value set then it's first load, set current char.
			NCH.DDM:UIDropDownMenu_SetSelectedValue(frame, currentProfile);
		end
	end
	frame:HookScript("OnShow", frame.initialize);
	frame:HookScript("OnEnter", function(self)
		frame.tooltip:Show();
	end)
	frame:HookScript("OnLeave", function(self)
		frame.tooltip:Hide();
	end)
	return frame;
end]]