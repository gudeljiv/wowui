-------------------------------
---NovaConsumesHelper frames--
-------------------------------
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local _, NCH = ...;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaConsumesHelper");
local GetPlayerAuraBySpellID = C_UnitAuras.GetPlayerAuraBySpellID;
local GetItemCount = C_Item.GetItemCount;
local mainFrame;
local waitingCombatEnd, combatEndIncludeButtonUpdate;
local eating = {};
local consumesData = {};
local spellNameCache = {};
local GetSpellInfo = NCH.GetSpellInfo;
local isInCapitalCity = NCH.isInCapitalCity;
local MasqueGroup = NCH.MasqueGroup;

for k, v in pairs(NCH.foods) do
	if (v.eatingID) then
		eating[v.eatingID] = true;
	end
end

local combatFrame = CreateFrame("Frame");
combatFrame:SetScript('OnEvent', function(self, event, ...)
	if (event == "PLAYER_REGEN_ENABLED") then
		NCH:updateConsumesFrame();
		NCH:updateConsumesVisibility();
		NCH:updateConsumesCounts();
		combatFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
		if (combatEndIncludeButtonUpdate) then
			combatEndIncludeButtonUpdate = nil;
			NCH:buildConsumesButtons();
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
			NCH:updateConsumesFrame();
		end
	elseif (event == "BAG_UPDATE_DELAYED") then
		C_Timer.After(0.2, function()
			NCH:updateConsumesCounts();
		end);
		NCH:throddleEventByFunc(event, 0.5, "loadConsumesData", ...);
	elseif (event == "PLAYER_ENTERING_WORLD" or event == "AREA_POIS_UPDATED") then
		NCH:updateConsumesVisibility();
		C_Timer.After(2, function()
			NCH:updateConsumesVisibility();
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
				NCH:buildConsumesButtons();
			end
		end
	end
end)

function NCH:resetFramePosition()
	if (mainFrame) then
		mainFrame.resetPosition();
		NCH:print("Frame position has been reset.");
	end
end

--Keep local config vars for speed reasons.
local lowDurationThreshold = 300;
local hideWhenBuffed, showLabels, borderAnimation, showItemCount, alwaysShowDuration, showTooltips, hideInCapitalCity, hideX, inverseDesaturate, desaturateAlpha;
local hideWhenNoItems, hideUniqueItems, disableMenuBar, disableStateAutomation, buttonFont, labelFontSize, timerFontSize, countFontSize;
function NCH:updateConfigOptions()
	lowDurationThreshold = NCH.db.global.lowDurationThreshold;
	hideWhenBuffed = NCH.db.global.hideWhenBuffed;
	showLabels = NCH.db.global.showLabels;
	borderAnimation = NCH.db.global.borderAnimation;
	showItemCount = NCH.db.global.showItemCount;
	alwaysShowDuration = NCH.db.global.alwaysShowDuration;
	showTooltips = NCH.db.global.showTooltips;
	hideInCapitalCity = NCH.db.global.hideInCapitalCity;
	hideX =  NCH.db.global.hideX;
	inverseDesaturate =  NCH.db.global.inverseDesaturate;
	desaturateAlpha = NCH.db.global.desaturateAlpha;
	hideWhenNoItems = NCH.db.global.hideWhenNoItems;
	hideUniqueItems = NCH.db.global.hideUniqueItems;
	disableStateAutomation = NCH.db.global.disableStateAutomation;
	buttonFont = NCH.db.global.timerFontSize;
	labelFontSize = NCH.db.global.labelFontSize;
	timerFontSize = NCH.db.global.timerFontSize;
	countFontSize = NCH.db.global.countFontSize;
	if (mainFrame) then
		mainFrame.padding = NCH.db.global.padding;
		mainFrame.growthDirection = NCH.db.global.growthDirection;
		mainFrame.buttonsWide = NCH.db.global.buttonsWide;
		mainFrame.hideWhenNoItems = NCH.db.global.hideWhenNoItems;
		mainFrame.updateTopBar();
		mainFrame:SetAlpha(NCH.db.global.alpha);
		mainFrame.disableMenuBar = NCH.db.global.disableMenuBar;
	end
	NCH:buildConsumesButtons();
	NCH:updateConsumesVisibility();
	NCH:updateConsumesFrame();
end

function NCH:updateConsumesVisibility()
	if (not mainFrame) then
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
		if (db.loadInBattlegrounds) then
			if (not (IsActiveBattlefieldArena and IsActiveBattlefieldArena())) then
				enabled = true;
			end
		end
		if (db.loadInArena) then
			if (IsActiveBattlefieldArena and IsActiveBattlefieldArena()) then
				enabled = true;
			end
		end
	else
		local instance, instanceType = IsInInstance();
		if (instance) then
			if (db.loadInDungeons and instanceType == "party") then
				enabled = true;
			end
			if (db.loadInRaids and instanceType == "raid") then
				enabled = true;
			end
		end
		if (db.loadInPartyGroup and IsInGroup() and not IsInRaid()) then
			enabled = true;
		end
		if (db.loadInRaidGroup and IsInRaid()) then
			enabled = true;
		end
	end
	if (db.loadEverywhere) then
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
	if (enabled) then
		mainFrame:Show();
	else
		mainFrame:Hide();
	end
end

function NCH:resetAllButtonPoints()
	if (not mainFrame) then
		return;
	end
	mainFrame.clearAllButtonPoints();
	NCH:updateConsumesFrame();
end

function NCH:loadConsumesFrame()
	if (not mainFrame) then
		mainFrame = NCH:createButtonsFrame("NCHMainFrame", -52, 130, NCH.db.global.buttonSize, NCH.db.global.buttonSize);
		mainFrame.onUpdateFunction = "updateConsumesFrame";
		NCH:updateConfigOptions();
		mainFrame:Hide();
		NCH:updateConsumesVisibility();
	end
	NCH:loadConsumesData();
	NCH:consumesUpdateFrameLocks();
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

function NCH:loadConsumesData(loadOnly)
	consumesData = {};
	local config = NCH.config;
	local configHasItemsSet;
	for _, slotData in ipairs(NCH.slots) do
		local slotNum = slotData.configSlot;
		for k, v in ipairs(slotData) do
			if (v.name == config["consumesSlot" .. slotNum]) then
				local skip;
				if (v.itemID and (hideWhenNoItems or (hideUniqueItems and v.unique))) then
					local itemCount = GetItemCount(v.itemID, nil, true);
					if (itemCount and itemCount < 1) then
						skip = true;
					end
				end
				if (not skip) then
					tinsert(consumesData, v);
				end
				configHasItemsSet = true;
			end
		end
	end
	if (configHasItemsSet) then
		--If some items are set in config set this on the frame for checks in UI.lua
		mainFrame.hasItemsLoaded = true;
	else
		mainFrame.hasItemsLoaded = false;
	end
	if (not loadOnly) then
		NCH:buildConsumesButtons();
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

function NCH:showGlow(frame)
	if (not frame.noBuff) then
		if (borderAnimation == 1) then
			NCH.customGlow.PixelGlow_Start(frame, nil, 16, nil, 3, nil, nil, nil, nil, nil, 4);
		elseif (borderAnimation == 2) then
			NCH.customGlow.ButtonGlow_Start(frame);
		end
	end
end

function NCH:hideGlow(frame)
	if (borderAnimation == 1) then
		NCH.customGlow.PixelGlow_Stop(frame);
	elseif (borderAnimation == 2) then
		NCH.customGlow.ButtonGlow_Stop(frame);
	end
end

function NCH:updateAllGlows()
	for k, v in pairs(mainFrame.buttons) do
		NCH.customGlow.PixelGlow_Stop(v.borderFrame);
		NCH.customGlow.ButtonGlow_Stop(v.borderFrame);
	end
	NCH:updateConsumesFrame();
end

function NCH:updateConsumesFrame(isOnUpdate)
	if (not mainFrame) then
		return;
	end
	local hasAnyBuff;
	local updateItemCounts; --Update itemcounts if a button display state changes.
	for k, v in ipairs(consumesData) do
		local consumeActive, duration, lowDuration, eating;
		if (v.enchantID) then
			local mhID, mhTime, ohID, ohTime = getTempWeaponEnchants()
			if (mhID and mhID == v.enchantID and v.mainhand) then
				if (mhTime and mhTime < lowDurationThreshold) then
					lowDuration = mhTime;
				end
				duration = mhTime;
				consumeActive = true;
			elseif (ohID and ohID == v.enchantID and v.offhand) then
				if (ohTime and ohTime < lowDurationThreshold) then
					lowDuration = ohTime;
				end
				consumeActive = true;
				duration = ohTime;
			end
			if (not duration and v.spellID) then
				--If enchant doesn't show on the weapon then check buffs instead (like for rogue poisons in later expansions).
				duration = getBuffDuration(v.spellID);
				if (duration) then
					if (duration < lowDurationThreshold) then
						lowDuration = duration;
					end
					consumeActive = true;
				end
			end
		elseif (v.spellID) then
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
				if (duration < lowDurationThreshold) then
					lowDuration = duration;
				end
				consumeActive = true;
			end
			if (v.eatingID and (not duration or duration < lowDurationThreshold)) then
				local duration = getBuffDuration(v.eatingID);
				if (duration) then
					eating = duration;
				end
			end
		end
		local button = mainFrame.buttons[k];
		if (eating) then
			--if (eating > 0 and not LOCALE_koKR and not LOCALE_zhCN and not LOCALE_zhTW) then
			if (eating > 0) then
				if (not button.desaturate) then
					updateItemCounts = true;
				end
				--button.desaturate = true;
				button.desaturate = not inverseDesaturate;
				button.fs:SetText("");
				button.fs2:SetText("");
				button.disabled = true;
				button.fsEating:SetText("|cFFFFFF00" .. L["Eat"] .. "\n" .. math.floor(eating) .. "s");
			end
		elseif (not consumeActive) then
			button.show = true;
			button.disabled = false;
			if (button.desaturate) then
				updateItemCounts = true;
			end
			--button.desaturate = false;
			button.desaturate = inverseDesaturate and true or false;
			button.fs:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.5, "OUTLINE");
			if (hideX) then
				button.fs:SetText("");
			else
				button.fs:SetText("|cFFFF0000x");
			end
			button.fs2:SetText("");
			button.checkTexture:SetTexture();
			NCH:showGlow(button.borderFrame);
			button.fsEating:SetText("");
		else
			if (lowDuration) then
				button.fs:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.5, "OUTLINE");
				button.fs:SetText("|cFFFF0000" .. getTimeString(lowDuration));
				button.fs2:SetText("");
				button.show = true;
				if (button.desaturate) then
					updateItemCounts = true;
				end
				--button.desaturate = false;
				button.desaturate = inverseDesaturate and true or false;
				button.disabled = false;
				button.checkTexture:SetTexture();
			else
				if (hideWhenBuffed) then
					button.show = false;
					if (button.desaturate) then
						updateItemCounts = true;
					end
					--button.desaturate = false;
					button.desaturate = inverseDesaturate and true or false;
				else
					button.show = true;
					if (not button.desaturate) then
						updateItemCounts = true;
					end
					--button.desaturate = true;
					button.desaturate = not inverseDesaturate;
				end
				button.disabled = true;
				button.fs:SetText("");
				if (alwaysShowDuration) then
					button.checkTexture:SetTexture();
					button.fs2:SetText("|cFF00FF00" .. getTimeString(duration));
				else
					button.checkTexture:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready");
					button.fs2:SetText("");
				end
			end
			button.fsEating:SetText("");
			NCH:hideGlow(button.borderFrame);
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
		if (showLabels and v.label and not eating) then
			button.label:SetText(v.label);
		else
			button.label:SetText("");
		end
		if (consumeActive) then
			hasAnyBuff = true;
		end
		if (button.noDisable) then
			button.disabled = false;
		end
	end
	mainFrame.hasAnyBuff = hasAnyBuff;
	if (InCombatLockdown()) then
		if (not waitingCombatEnd) then
			waitingCombatEnd = true;
			combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		end
		return;
	end
	NCH:updateConsumesFrameOutOfCombat(isOnUpdate);
	if (updateItemCounts) then
		NCH:updateConsumesCounts();
	end
end

function NCH:updateConsumesFrameOutOfCombat(isOnUpdate)
	if (not InCombatLockdown()) then
		mainFrame.sortButtons(isOnUpdate);
	end
end

function NCH_UpdateConsumesFrame()
	NCH:updateConsumesFrame();
end

function NCH:updateConsumesCounts()
	if (not mainFrame or not showItemCount) then
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
		local button = mainFrame.buttons[k];
		if ((button.desaturate and not NCH.db.global.showItemCountWhenBuffed) or v.noItemUseSpell) then
			button.itemCount:SetText("");
		elseif (v.itemID) then
			local itemCount = GetItemCount(v.itemID, nil, true);
			if (itemCount) then
				--local itemText = "|cFF00FF00" .. itemCount;
				local itemText = "|cFFFFFFFF" .. itemCount;
				if (itemCount == 0) then
					itemText = "|cFFFF0000" .. itemCount;
				end
				button.itemCount:SetText(itemText);
			end
		end
	end
end

function NCH:hideAllItemCounts()
	if (not mainFrame) then
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
		mainFrame.buttons[k].itemCount:SetText("");
	end
end

function NCH:onButtonClick(button)
	--[[if (button.itemID) then
		local start, duration, enable = C_Container.GetItemCooldown(button.itemID);
		CooldownFrame_Set(button.cooldown, start, duration, enable, false, 1);
	end]]
	NCH:updateConsumesFrame()
end

function NCH:updateConsumesGCDs()
	--if (InCombatLockdown()) then
	--	return;
	--end
	for k, v in ipairs(consumesData) do
		local button = mainFrame.buttons[k];
		if (button.itemID and not button.hideCooldown) then
			local start, duration, enable = C_Container.GetItemCooldown(button.itemID);
			CooldownFrame_Set(button.cooldown, start, duration, enable, false, 1);
		elseif (button.spellID and not button.hideCooldown) then
			--Why does C_Spell.GetSpellCooldown and C_Container.GetItemCooldown have diff return structures?
			--Use older GetSpellCooldown for now until era has the C_Spell version, when both mop and classic have it I'll update this.
			local start, duration, enable = GetSpellCooldown(button.spellID);
			CooldownFrame_Set(button.cooldown, start, duration, enable, false, 1);
		end
	end
end

function NCH:toggleConsumesFrame(showOnly, hideOnly)
	if (not mainFrame) then
		return;
	end
	if (mainFrame:IsShown() and not showOnly) then
		mainFrame:Hide();
	elseif (not hideOnly) then
		mainFrame:Show();
	end
	return mainFrame:IsShown();
end

function NCH:showConsumesFrame()
	if (not mainFrame) then
		return;
	end
	mainFrame:Show();
end

function NCH:hideConsumesFrame()
	if (not mainFrame) then
		return;
	end
	mainFrame:Hide();
end

function NCH:buildConsumesButtons()
	if (not mainFrame) then
		return;
	end
	if (InCombatLockdown()) then
		waitingCombatEnd = true;
		combatEndIncludeButtonUpdate = true;
		combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		return;
	end
	NCH:cacheSpellNames();
	NCH:loadConsumesData(true);
	for k, v in pairs(mainFrame.buttons) do
		v.show = false;
	end
	for k, v in ipairs(consumesData) do
		local button = mainFrame.buttons[k] or mainFrame:getButton(k);
		button.show = true;
	
		if (MasqueGroup) then
			button.icon:SetTexture(v.icon);
		else
			--This should be able to ise button.icon even without masque installed but it looks odd with the icon not fitting right.
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
		button.NormalTexture:SetAllPoints();
		button:SetNormalTexture(button.normalTexture);
		
		button.pushedTexture = button:CreateTexture("Texture", "Background")
		button.pushedTexture:SetTexture(v.icon);
		button.pushedTexture:SetPoint("CENTER");
		button.pushedTexture:SetSize(button:GetWidth()/1.2, button:GetHeight()/1.2);
		button:SetPushedTexture(button.pushedTexture);]]
		
		--button.label:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.35, "OUTLINE");
		--button.fs:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.5, "OUTLINE");
		--button.fs2:SetFont(STANDARD_TEXT_FONT, button:GetWidth() * 0.35, "OUTLINE");
		
		if (v.enchantID) then
			if (v.noItemUseSpell) then
				if (v.offhand) then
					local itemID = GetInventoryItemID("player", 17);
					if (not itemID) then
						button:SetAttribute("macrotext", "/run NCH_PrintMissingSlot(17)");
					else
						local spellName = spellNameCache[v.spellID];
						if (not spellName) then
							local name = GetSpellInfo(v.spellID);
							if (name) then
								spellNameCache[v.spellID] = name;
								spellName = name;
							end
						end
						if (spellName) then
							button:SetAttribute("macrotext", "/cast [@none] " .. spellName .. "\n/use 17\n/click StaticPopup1Button1\n/run NCH_UpdateConsumesFrame()\n/run NCH_SlotCheck(17)");
						else
							button:SetAttribute("macrotext", "/run NCH_PrintMissingSpellName(" .. v.spellID .. ")");
						end
					end
				else
					local itemID = GetInventoryItemID("player", 16);
					if (not itemID) then
						button:SetAttribute("macrotext", "/run NCH_PrintMissingSlot(16)");
					else
						local spellName = spellNameCache[v.spellID];
						if (not spellName) then
							local name = GetSpellInfo(v.spellID);
							if (name) then
								spellNameCache[v.spellID] = name;
								spellName = name;
							end
						end
						if (spellName) then
							button:SetAttribute("macrotext", "/cast [@none] " .. spellName .. "\n/use 16\n/click StaticPopup1Button1\n/run NCH_UpdateConsumesFrame()\n/run NCH_SlotCheck(16)");
						else
							button:SetAttribute("macrotext", "/run NCH_PrintMissingSpellName(" .. v.spellID .. ")");
						end
					end
				end
			elseif (v.rangedWeapon) then
				local itemID = GetInventoryItemID("player", 18);
				if (not itemID) then
					button:SetAttribute("macrotext", "/run NCH_PrintMissingSlot(18)");
				else
					button:SetAttribute("macrotext", "/use item:" .. v.itemID .. "\n/use 18\n/click StaticPopup1Button1\n/run NCH_UpdateConsumesFrame()\n/run NCH_SlotCheck(18)");
				end
			elseif (v.offhand) then
				local itemID = GetInventoryItemID("player", 17);
				if (not itemID) then
					button:SetAttribute("macrotext", "/run NCH_PrintMissingSlot(17)");
				else
					button:SetAttribute("macrotext", "/use item:" .. v.itemID .. "\n/use 17\n/click StaticPopup1Button1\n/run NCH_UpdateConsumesFrame()\n/run NCH_SlotCheck(17)");
				end
			else
				local itemID = GetInventoryItemID("player", 16);
				if (not itemID) then
					button:SetAttribute("macrotext", "/run NCH_PrintMissingSlot(16)");
				else
					button:SetAttribute("macrotext", "/use item:" .. v.itemID .. "\n/use 16\n/click StaticPopup1Button1\n/run NCH_UpdateConsumesFrame()\n/run NCH_SlotCheck(16)");
				end
			end
		else
			button:SetAttribute("macrotext", "/use [@player] item:" .. v.itemID .. "\n/run NCH_UpdateConsumesFrame()")
		end
		button.onClickFunction = "onButtonClick";
		button.itemID = v.itemID;
		button.spellID = v.spellID;
		button.borderFrame.noBuff = v.noBuff;
		button.hideCooldown = v.hideCooldown;
		button.noDisable = v.noDisable;
		if (showTooltips) then
			button.tooltipItemID = v.itemID;
			button.tooltipSpellID = v.spellID;
		else
			button.tooltipItemID = nil;
			button.tooltipSpellID = nil;
		end
		button:Show();
	end
	NCH:updateConsumesFrame();
	NCH:updateConsumesCounts();
	NCH:updateConsumesFrameSize();
	mainFrame.sortButtons();
	mainFrame.updateSize(nil, nil);
	mainFrame.updateBorder();
end

function NCH:updateConsumesFrameSize()
	mainFrame.buttonWidth = NCH.db.global.buttonSize;
	mainFrame.buttonHeight = NCH.db.global.buttonSize;
	mainFrame.updateDimensions();
end

--Just cache consumes spells that don't come from an item (like shaman imbues).
--We can't cast spells by spellID in macros.
function NCH:cacheSpellNames()
	for k, v in pairs(NCH.tempEnchants) do
		if (v.noItemUseSpell) then
			local name = GetSpellInfo(v.spellID);
			if (name) then
				spellNameCache[v.spellID] = name;
			end
		end
	end
end

function NCH:consumesUpdateFrameLocks()
	if (mainFrame) then
		if (NCH.db.global.lockAllFrames) then
			mainFrame.locked = true;
		else
			mainFrame.locked = nil;
		end
		mainFrame.topBar.updateText();
	end
end