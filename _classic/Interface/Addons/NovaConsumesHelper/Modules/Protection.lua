-------------------------------
---NovaConsumesHelper frames--
-------------------------------
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local _, NCH = ...;
if (not NCH.showProtectionPots) then
	--Don't load protection pots after TBC.
	return;
end
local L = LibStub("AceLocale-3.0"):GetLocale("NovaConsumesHelper");
local GetPlayerAuraBySpellID = C_UnitAuras.GetPlayerAuraBySpellID;
local GetItemCount = C_Item.GetItemCount;
local protFrame;
local waitingCombatEnd, combatEndIncludeButtonUpdate;
local eating = {};
local consumesData = {};
local spellNameCache = {};
local GetSpellInfo = NCH.GetSpellInfo;
local isInCapitalCity = NCH.isInCapitalCity;
local numPotsDisplayed = 0;
local autoAbsorbPosition;
local MasqueGroup = NCH.MasqueGroup;

local combatFrame = CreateFrame("Frame");
combatFrame:SetScript('OnEvent', function(self, event, ...)
	if (event == "PLAYER_REGEN_ENABLED") then
		NCH:updateProtFrame();
		NCH:updateProtVisibility();
		NCH:updateProtCounts();
		combatFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
		if (combatEndIncludeButtonUpdate) then
			combatEndIncludeButtonUpdate = nil;
			NCH:buildProtButtons();
		end
		waitingCombatEnd = nil;
	end
end)

local f = CreateFrame("Frame");
f:RegisterEvent("UNIT_AURA");
f:RegisterEvent("BAG_UPDATE_DELAYED");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
f:RegisterEvent("AREA_POIS_UPDATED");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "UNIT_AURA") then
		local unit = ...;
		if (unit == "player") then
			NCH:updateProtFrame();
		end
	elseif (event == "BAG_UPDATE_DELAYED") then
		C_Timer.After(0.2, function()
			NCH:updateProtCounts();
		end);
	elseif (event == "PLAYER_ENTERING_WORLD" or event == "AREA_POIS_UPDATED") then
		NCH:updateProtVisibility();
		C_Timer.After(2, function()
			NCH:updateProtVisibility();
		end);
	elseif (event == "PLAYER_EQUIPMENT_CHANGED") then
		local slot = ...;
		if (slot == 16 or slot == 17 or slot == 18) then
			if (InCombatLockdown()) then
				waitingCombatEnd = true;
				combatEndIncludeButtonUpdate = true;
				combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
				return;
			else
				NCH:buildProtButtons();
			end
		end
	end
end)

function NCH:resetProtFramePosition()
	if (protFrame) then
		protFrame.resetPosition();
		NCH:print("Frame position has been reset.");
	end
end

--Keep local config vars for speed reasons.
local showLabels, showItemCount, showTooltips, hideInCapitalCity, showProgressText, progressTextPosition, showProgressBar, progressBarPosition;
local colorizeTextBySchool, inverseDesaturate, desaturateAlpha, hideWhenNoItems, disableStateAutomation, buttonFont, labelFontSize, timerFontSize, countFontSize;
function NCH:updateProtConfigOptions()
	showLabels = NCH.db.global.showLabelsProt;
	showItemCount = NCH.db.global.showItemCountProt;
	showTooltips = NCH.db.global.showTooltipsProt;
	hideInCapitalCity = NCH.db.global.hideInCapitalCityProt;
	showProgressText = NCH.db.global.showProgressText;
	progressTextPosition = NCH.db.global.progressTextPosition;
	showProgressBar = NCH.db.global.showProgressBar;
	progressBarPosition = NCH.db.global.progressBarPosition;
	colorizeTextBySchool = NCH.db.global.colorizeTextBySchool;
	inverseDesaturate = NCH.db.global.inverseDesaturateProt;
	desaturateAlpha = NCH.db.global.desaturateAlphaProt;
	hideWhenNoItems = NCH.db.global.hideWhenNoItemsProt;
	disableStateAutomation = NCH.db.global.disableStateAutomation;
	buttonFont = NCH.db.global.timerFontSize;
	timerFontSize = NCH.db.global.timerFontSize;
	countFontSize = NCH.db.global.countFontSize;
	labelFontSize = NCH.db.global.labelFontSize;
	if (protFrame) then
		protFrame.padding = NCH.db.global.paddingProt;
		protFrame.growthDirection = NCH.db.global.growthDirectionProt;
		protFrame.buttonsWide = NCH.db.global.buttonsWideProt;
		protFrame.updateTopBar();
		protFrame:SetAlpha(NCH.db.global.alphaProt);
		protFrame.disableMenuBar = NCH.db.global.disableMenuBar;
	end
	NCH:buildProtButtons();
	NCH:updateProtVisibility();
	NCH:updateProtFrame();
	NCH:updateProtProgressPositions();
end

function NCH:updateProtVisibility()
	if (not protFrame) then
		return;
	end
	if (disableStateAutomation) then
		return;
	end
	if (InCombatLockdown()) then
		if (not waitingCombatEnd) then
			waitingCombatEnd = true;
			combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		end
		return;
	end
	local enabled;
	local db = NCH.db.global;
	if (UnitInBattleground("player")) then
		if (db.loadInBattlegroundsProt) then
			if (not (IsActiveBattlefieldArena and IsActiveBattlefieldArena())) then
				enabled = true;
			end
		end
	else
		local instance, instanceType = IsInInstance();
		if (instance) then
			if (db.loadInDungeonsProt and instanceType == "party") then
				enabled = true;
			end
			if (db.loadInRaidsProt and instanceType == "raid") then
				enabled = true;
			end
		end
		if (db.loadInPartyGroupProt and IsInGroup() and not IsInRaid()) then
			enabled = true;
		end
		if (db.loadInRaidGroupProt and IsInRaid()) then
			enabled = true;
		end
	end
	if (db.loadEverywhereProt) then
		--PvP overrides this.
		if (not UnitInBattleground("player") and not (IsActiveBattlefieldArena and IsActiveBattlefieldArena())) then
			enabled = true;
		end
	end
	if (UnitLevel("player") < db.minLevel) then
		enabled = false;
	end
	if (hideInCapitalCity and isInCapitalCity()) then
		enabled = false;
	end
	if (NCH.expansionNum > 2) then
		--Classic and TBC.
		enabled = false;
	end
	if (enabled and numPotsDisplayed > 0) then
		protFrame:Show();
	else
		protFrame:Hide();
	end
end

function NCH:resetAllButtonPoints()
	if (not protFrame) then
		return;
	end
	protFrame.clearAllButtonPoints();
	NCH:updateProtFrame();
end

function NCH:loadProtFrame()
	if (not NCH.db.global.enableProtFrame) then
		return;
	end
	if (not protFrame) then
		protFrame = NCH:createButtonsFrame("NCHProtFrame", -52, 50, NCH.db.global.buttonSizeProt, NCH.db.global.buttonSizeProt, true, true);
		protFrame.onUpdateFunction = "updateProtFrame";
		protFrame.fs.t = "|cFFFFFF00Set prot potions\nin config";
		protFrame.topBar.configButton:SetScript("OnClick", function(self, arg)
			NCH:openConfig(nil, true);
		end)
		NCH:updateProtConfigOptions();
		protFrame:Hide();
		NCH:updateProtVisibility();
	end
	NCH:loadProtData();
	NCH:protUpdateFrameLocks();
end

local function getTimeString(seconds)
	local d = math.floor((seconds % (86400*365)) / 86400);
	local h = math.floor((seconds % 86400) / 3600);
	local m = math.floor((seconds % 3600) / 60);
	local s = math.floor((seconds % 60));
	if (d >= 1) then
		return d .. "d";
	elseif (h >= 1) then
		return h .. "h";
	elseif (m >= 1) then
		return m .. "m";
	end
	return s .. "s";
end

function NCH:loadProtData(loadOnly)
	consumesData = {};
	local config = NCH.db.global;
	local configHasItemsSet;
	for _, slotData in ipairs(NCH.protectionPots) do
		local skip;
		if (hideWhenNoItems) then
			local itemCount = GetItemCount(slotData.itemID, nil, true);
			if (itemCount and itemCount < 1) then
				skip = true;
			end
		end
		if (config["protShow" .. slotData.type] and not skip) then
			tinsert(consumesData, slotData);
		end
		configHasItemsSet = true;
		--local slotNum = slotData.configSlot;
		--for k, v in ipairs(slotData) do
			--if (v.name == config["protSlot" .. slotNum]) then
			--if (config["protShow" .. slotData.type]) then
			--	tinsert(consumesData, slotData);
			--end
		--end
	end
	if (configHasItemsSet) then
		--If some items are set in config set this on the frame for checks in UI.lua
		protFrame.hasItemsLoaded = true;
	else
		protFrame.hasItemsLoaded = false;
	end
	if (not loadOnly) then
		NCH:buildProtButtons();
	end
end

local function getTempWeaponEnchants()
	local mh, mhTime, _, mhID, oh, ohTime, _, ohID = GetWeaponEnchantInfo();
	if (mhID and mhTime) then
		mhTime = math.floor(mhTime/1000);
	end
	if (ohID and ohTime) then
		ohTime = math.floor(ohTime/1000);
	end
	return mhID, mhTime, ohID, ohTime;
end

local function getBuffDuration(spellID)
	local data = GetPlayerAuraBySpellID(spellID);
	if (data) then
		return data.expirationTime - GetTime(), data.expirationTime;
	end
end

function NCH:updateProtFrame(isOnUpdate)
	if (not protFrame) then
		return;
	end
	local hasAnyBuff;
	local updateItemCounts; --Update itemcounts if a button display state changes.
	for k, v in ipairs(consumesData) do
		local consumeActive, duration;
		if (v.spellID) then
			duration = getBuffDuration(v.spellID);
			if (not duration and v.sharedSpellIDs) then
				for _, id in pairs(v.sharedSpellIDs) do
					duration = getBuffDuration(id);
					if (duration) then
						break;
					end
				end
			end
			if (duration) then
				consumeActive = true;
			end
		end
		local button = protFrame.buttons[k];
		if (not consumeActive) then
			button.show = true;
			--button.disabled = false;
			if (button.desaturate) then
				updateItemCounts = true;
			end
			--button.desaturate = false;
			button.desaturate = inverseDesaturate and true or false;
			button.fs:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.5, "OUTLINE");
			--button.fs:SetText("|cFFFF0000x");
			button.checkTexture:SetTexture();
			--NCH:showGlow(button.borderFrame);
		else
			button.show = true;
			if (not button.desaturate) then
				updateItemCounts = true;
			end
			--button.desaturate = true;
			button.desaturate = not inverseDesaturate;
			--button.disabled = true;
			--[[if (alwaysShowDuration) then
				if (duration) then
					button.fs:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.35, "OUTLINE");
					button.fs:SetText("|cFFFFFF00" .. getTimeString(duration));
				else
					button.fs:SetText("");
				end
			else
				button.fs:SetText("");
			end]]
			if (autoAbsorbPosition ~= 5) then
				button.checkTexture:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready");
			else
				button.checkTexture:SetTexture();
			end
			--NCH:hideGlow(button.borderFrame);
		end
		if (MasqueGroup) then
			button.icon:SetDesaturated(button.desaturate);
		else
			button.NormalTexture:SetDesaturated(button.desaturate);
		end
		if (button.desaturate) then
			button:SetAlpha(desaturateAlpha);
		else
			button:SetAlpha(1);
		end
		--if (consumesData.spellID) then
		--	CooldownFrame_Set(button.cooldown, start, duration, enable, false, modRate);
		--end
		if (showLabels and v.label) then
			button.label:SetText(v.label);
		else
			button.label:SetText("");
		end
		if (consumeActive) then
			hasAnyBuff = true;
		end
	end
	protFrame.hasAnyBuff = hasAnyBuff;
	if (InCombatLockdown()) then
		if (not waitingCombatEnd) then
			waitingCombatEnd = true;
			combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		end
		return;
	end
	NCH:updateProtFrameOutOfCombat(isOnUpdate);
	if (updateItemCounts) then
		NCH:updateProtCounts();
	end
end

function NCH:updateProtFrameOutOfCombat(isOnUpdate)
	if (not InCombatLockdown()) then
		protFrame.sortButtons(isOnUpdate);
	end
end

function NCH_UpdateProtFrame()
	NCH:updateProtFrame();
end

function NCH:updateProtCounts()
	if (not protFrame or not showItemCount) then
		return;
	end
	if (InCombatLockdown()) then
		if (not waitingCombatEnd) then
			waitingCombatEnd = true;
			combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		end
		return;
	end
	for k, v in ipairs(consumesData) do
		local button = protFrame.buttons[k];
		--if ((button.desaturate and not NCH.db.global.showItemCountWhenBuffedProt) or v.noItemUseSpell) then
		--	button.itemCount:SetText("");
		--else
			local itemCount = GetItemCount(v.itemID, nil, true);
			if (itemCount) then
				--local itemText = "|cFF00FF00" .. itemCount;
				local itemText = "|cFFFFFFFF" .. itemCount;
				if (itemCount == 0) then
					itemText = "|cFFFF0000" .. itemCount;
				end
				button.itemCount:SetText(itemText);
			end
		--end
	end
end

function NCH:hideAllProtItemCounts()
	if (not protFrame) then
		return;
	end
	--[[if (InCombatLockdown()) then
		if (not waitingCombatEnd) then
			waitingCombatEnd = true;
			combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		end
		return;
	end]]
	for k, v in ipairs(consumesData) do
		protFrame.buttons[k].itemCount:SetText("");
	end
end

function NCH:onProtButtonClick(button)
	--[[if (button.itemID) then
		local start, duration, enable = C_Container.GetItemCooldown(button.itemID);
		CooldownFrame_Set(button.cooldown, start, duration, enable, false, 1);
	end]]
	NCH:updateProtFrame()
end

function NCH:updateProtGCDs()
	--if (InCombatLockdown()) then
	--	return;
	--end
	for k, v in ipairs(consumesData) do
		local button = protFrame.buttons[k];
		if (button.itemID and not button.hideCooldown) then
			local start, duration, enable = C_Container.GetItemCooldown(button.itemID);
			CooldownFrame_Set(button.cooldown, start, duration, enable, false, 1);
		end
	end
end

function NCH:toggleProtFrame(showOnly, hideOnly)
	if (not protFrame) then
		return;
	end
	if (protFrame:IsShown() and not showOnly) then
		protFrame:Hide();
	elseif (not hideOnly) then
		protFrame:Show();
	end
	return protFrame:IsShown();
end

function NCH:showProtFrame()
	if (not protFrame) then
		return;
	end
	protFrame:Show();
end

function NCH:hideProtFrame()
	if (not protFrame) then
		return;
	end
	protFrame:Hide();
end

function NCH:buildProtButtons()
	if (not protFrame) then
		return;
	end
	if (InCombatLockdown()) then
		waitingCombatEnd = true;
		combatEndIncludeButtonUpdate = true;
		combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		return;
	end
	NCH:loadProtData(true);
	NCH:cacheSpellNames();
	for k, v in pairs(protFrame.buttons) do
		v.show = false;
	end
	numPotsDisplayed = 0;
	for k, v in ipairs(consumesData) do
		local button = protFrame.buttons[k] or protFrame:getButton(k);
		button.show = true;
		
		if (MasqueGroup) then
			button.icon:SetTexture(v.icon);
		else
			--This should be able to ise button.cion even without masque installed but it looks odd with the icon not fitting right.
			--Using old method for now if no masque, need to find time to work out the issue later.
			button:SetNormalTexture(v.icon);
			button.NormalTexture:SetAllPoints();
			
			if (not button.pushedTexture) then
				button.pushedTexture = button:CreateTexture("Texture", "Background")
			end
			button.pushedTexture:SetTexture(v.icon);
			button.pushedTexture:SetPoint("CENTER");
			button.pushedTexture:SetSize(button:GetWidth()/1.2, button:GetHeight()/1.2);
			button:SetPushedTexture(button.pushedTexture);
		end
		
		--[[button.normalTexture = button:CreateTexture("Texture", "Background")
		button.normalTexture:SetTexture(v.icon);
		button.normalTexture:SetAllPoints(button);
		button:SetNormalTexture(button.normalTexture);
		
		button.pushedTexture = button:CreateTexture("Texture", "Background")
		button.pushedTexture:SetTexture(v.icon);
		button.pushedTexture:SetPoint("CENTER");
		button.pushedTexture:SetSize(button:GetWidth()/1.2, button:GetHeight()/1.2);
		button:SetPushedTexture(button.pushedTexture);]]
		
		button:SetAttribute("macrotext", "/use [@player] item:" .. v.itemID .. "\n/run NCH_UpdateProtFrame()");

		button.onClickFunction = "onProtButtonClick";
		button.itemID = v.itemID;
		button.hideCooldown = v.hideCooldown;
		if (showTooltips) then
			button.tooltipItemID = v.itemID;
			button.tooltipSpellID = v.spellID;
		else
			button.tooltipItemID = nil;
			button.tooltipSpellID = nil;
		end
		button.spellID = v.spellID;
		button:Show();
		numPotsDisplayed = k;
	end
	NCH:updateProtFrame();
	NCH:updateProtCounts();
	NCH:updateProtFrameSize();
	NCH:updateProtVisibility();
	protFrame.sortButtons();
	protFrame.updateSize(nil, nil);
	protFrame.updateBorder();
end

function NCH:updateProtFrameSize()
	protFrame.buttonWidth = NCH.db.global.buttonSizeProt;
	protFrame.buttonHeight = NCH.db.global.buttonSizeProt;
	protFrame.updateDimensions();
end


local currentAbsorbs = {};
local spells = {};
function NCH:buildAbsorbData()
	for k, v in pairs(NCH.protectionPots) do
		local average = math.floor(v.minAbsorb + ((v.maxAbsorb - v.minAbsorb) / 2));
		spells[v.spellID] = {v.school, v.minAbsorb, v.maxAbsorb, average};
	end
end

local function setAutoAbsorbFramePosition()
	--if (not protFrame) then
	--	return;
	--end
	--1 top, 2 bottom, 3 middle, 4 left, 5 right.
	--left and right not added yet.
	local buttonsWide = protFrame.buttonsWide;
	local position = 1;
	if (buttonsWide == 1) then
		--If the bar is 1 column vertical then it can be right or left.
		if (progressBarPosition == 1 or progressBarPosition == 2) then
			--Force right side if top or bottom is set while it's vertical.
			position = 3;
		else
			position = progressBarPosition;
		end
	elseif (buttonsWide >= numPotsDisplayed) then
		--If the bar is 1 row horizontal then it can be top or bottom.
		if (progressBarPosition == 3 or progressBarPosition == 4) then
			--Force top side if right or left is set while it's vertical.
			position = 1;
		else
			position = progressBarPosition;
		end
	else
		--If there are multiple rows then it has to be in the middle of the button to not clash.
		position = 5;
	end
	autoAbsorbPosition = position;
end

--function NCH:setAutoAbsorbFramePosition()
--	setAutoAbsorbFramePosition();
--end

function NCH:updateProtProgressPositions()
	setAutoAbsorbFramePosition();
	for k, v in pairs(protFrame.buttons) do
		v.progressBar:ClearAllPoints();
		v.fs2:ClearAllPoints();
		if (autoAbsorbPosition == 5) then
			if (showProgressBar) then
				if (showProgressText) then
					v.progressBar:SetPoint("LEFT", 3, 0);
					v.progressBar:SetPoint("RIGHT", -3, 0);
					v.progressBar:SetPoint("BOTTOM", 0, 12);
					v.fs2:SetPoint("TOP", 0, -3);
				else
					v.progressBar:SetPoint("LEFT", 3, 0);
					v.progressBar:SetPoint("RIGHT", -3, 0);
					v.progressBar:SetPoint("CENTER", 0, 0);
				end
			else
				v.fs2:SetPoint("CENTER", 0, 2);
			end
		else
			--Set bar position first so we can adjust text position baded on if the bar is shown on the same side.
			if (autoAbsorbPosition == 1) then
				v.progressBar:SetPoint("LEFT");
				v.progressBar:SetPoint("RIGHT");
				v.progressBar:SetPoint("BOTTOM", v, "TOP", 0, 2);
			else
				v.progressBar:SetPoint("LEFT");
				v.progressBar:SetPoint("RIGHT");
				v.progressBar:SetPoint("TOP", v, "BOTTOM", 0, -2);
			end
			--Then set the text either above the button or above the bar if the bar is shown.
			if (progressTextPosition == 1) then
				if (showProgressBar) then
					if (autoAbsorbPosition == 1) then
						v.fs2:SetPoint("BOTTOM", v, "TOP", 0, 8);
					else
						v.fs2:SetPoint("BOTTOM", v, "TOP", 0, 2);
					end
				else
					v.fs2:SetPoint("BOTTOM", v, "TOP", 0, 2);
				end
			else
				if (showProgressBar) then
					if (autoAbsorbPosition == 2) then
						v.fs2:SetPoint("TOP", v, "BOTTOM", 0, -8);
					else
						v.fs2:SetPoint("TOP", v, "BOTTOM", 0, -2);
					end
				else
					v.fs2:SetPoint("TOP", v, "BOTTOM", 0, -2);
				end
			end
		end
	end
	NCH:updateAllAbsorbButtons();
end

local function addAbsorb(spellID)
	 if (spellID and spells[spellID]) then
	 	local school, min, max, average = spells[spellID][1], spells[spellID][2], spells[spellID][3], spells[spellID][4];
	 	currentAbsorbs[spellID] = average;
	 	NCH:updateAbsorbDisplay(spellID);
	 end
end

local function removeAbsorb(spellID)
	if (spellID and spells[spellID]) then
		--local school = spells[spellID];
		currentAbsorbs[spellID] = nil;
		NCH:updateAbsorbDisplay(spellID)
	end
end

local function damageAbsorbed(spellID, amount)
	if (spellID and currentAbsorbs[spellID] and amount) then
		currentAbsorbs[spellID] = currentAbsorbs[spellID] - amount;
		NCH:updateAbsorbDisplay(spellID);
	end
end

local schoolColors = {
	[2] = "FFFFE680", --Holy.
	[4] = "FFFF8000", --Fire.
	[8] = "FF4DFF4D", --Nature.
	[16] = "FF80FFFF", --Frost.
	[32] = "FF8080FF", --Shadow.
	[64] = "FFFF80FF", --Arcane.
};

function NCH:updateAbsorbDisplay(spellID)
	if (not spellID) then
		NCH:debug("missing spellID in update absorb func");
		return;
	end
	local button;
	local textColor = "FFFFFF00";
	if (colorizeTextBySchool) then
		local school = spells[spellID] and spells[spellID][1];
		if (school and schoolColors[school]) then
			textColor = schoolColors[school];
		end
	end
	for k, v in pairs(protFrame.buttons) do
		if (v.spellID == spellID) then
			button = v;
		end
	end
	--currentAbsorbs[spellID] = 1000
	if (button) then
		if (next(currentAbsorbs)) then
			if (currentAbsorbs[button.spellID]) then
				local percent = (currentAbsorbs[button.spellID] / spells[spellID][4]) * 100;
				local barWidth = button.progressBar:GetWidth();
				local barPosition = barWidth - ((percent / 100) * barWidth);
				if (currentAbsorbs[button.spellID] < 100) then
					--Becaus we just guess an average absorb amount to start with we could reach below 0 before the absorb runs out.
					--Just display 100 as a minimum so user knows there's some left atleast.
					if (showProgressText) then
						button.fs2:SetText("|c" .. textColor .. "100");
					else
						button.fs2:SetText("");
					end
					if (showProgressBar) then
						button.progressBar.texture:SetPoint("RIGHT", -barPosition, 0);
						button.progressBar:Show();
					else
						button.progressBar:Hide();
					end
				else
					if (showProgressText) then
						button.fs2:SetText("|c" .. textColor .. currentAbsorbs[button.spellID]);
					else
						button.fs2:SetText("");
					end
					if (showProgressBar) then
						button.progressBar.texture:SetPoint("RIGHT", -barPosition, 0);
						button.progressBar:Show();
					else
						button.progressBar:Hide();
					end
				end
			else
				button.fs2:SetText("");
				button.progressBar:Hide();
			end
		else
			button.fs2:SetText("");
			button.progressBar:Hide();
		end
	end
end

function NCH:updateAllAbsorbButtons()
	for k, v in pairs(protFrame.buttons) do
		NCH:updateAbsorbDisplay(v.spellID);
	end
end

function NCH:loadCurrentAbsorbs()
	for k, v in pairs(NCH.protectionPots) do
		local data = GetPlayerAuraBySpellID(v.spellID);
		if (data) then
			addAbsorb(v.spellID);
		end
	end
end

--[[local function damageAbsorbed(school, amount)
	if (currentAbsorbs[school]) then
		currentAbsorbs[school] = currentAbsorbs[school] - amount;
	end
end]]

local myGUID = UnitGUID("player");
local function combatLogEventUnfiltered(...)
	local _, subEvent, _, sourceGUID, _, _, _, destGUID = ...;
	if (destGUID == myGUID) then
		if (subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_REFRESH") then
	        local spellID = select(12, ...);
	        if (spellID and spells[spellID]) then
				addAbsorb(spellID);
			end
	    elseif (subEvent == "SPELL_AURA_REMOVED") then
	        local spellID = select(12, ...);
	        if (spellID and spells[spellID]) then
				removeAbsorb(spellID);
			end
	    elseif (subEvent == "SPELL_ABSORBED") then
	        if (select(21, ...)) then
	            local absorbSpellID = select(19, ...);
				if (absorbSpellID and spells[absorbSpellID]) then
		            --local school = select(21, ...);
		            local amount = select(22, ...);
		            damageAbsorbed(absorbSpellID, amount);
	            end
	        else
	            local absorbSpellID = select(16, ...);
	           if (absorbSpellID and spells[absorbSpellID]) then
		            --local school = select(18, ...);
		            local amount = select(19, ...);
		            damageAbsorbed(absorbSpellID, amount);
	            end
	        end
	    end
    end
end

local f = CreateFrame("Frame");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
f:SetScript('OnEvent', function(self, event, ...)
	combatLogEventUnfiltered(CombatLogGetCurrentEventInfo());
end)

function NCH:protUpdateFrameLocks()
	if (protFrame) then
		if (NCH.db.global.lockAllFrames) then
			protFrame.locked = true;
		else
			protFrame.locked = nil;
		end
		protFrame.topBar.updateText();
	end
end