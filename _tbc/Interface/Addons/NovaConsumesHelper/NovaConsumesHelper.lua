------------------------
--Nova Consumes Helper--
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local addonName, NCH = ...;
_G["NCH"] = NCH;

local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata;
NCH.expansionNum = 1;
local _, _, _, tocVersion = GetBuildInfo();
if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
	NCH.isClassic = true;
	NCH.showProtectionPots = true;
elseif (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) then
	NCH.isTBC = true;
	NCH.expansionNum = 2;
	NCH.showProtectionPots = true;
elseif (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) then
	NCH.isWrath = true;
	NCH.expansionNum = 3;
elseif (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC) then
	NCH.isCata = true;
	NCH.expansionNum = 4;
elseif (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC) then
	NCH.isMOP = true; --Later expansion project id's will likely need updating once Blizzard decides on the names.
	NCH.expansionNum = 5;
end
if (NCH.isClassic and C_Seasons and C_Seasons.GetActiveSeason() == 2) then
	NCH.isSOD = true;
end
local showProtectionPots = NCH.showProtectionPots;

NCH.LSM = LibStub("LibSharedMedia-3.0");
NCH.customGlow = LibStub("LibCustomGlow-1.0");
NCH.DDM = LibStub("LibUIDropDownMenu-4.0");
NCH.version = GetAddOnMetadata("NovaConsumesHelper", "Version") or 9999;
NCH.version = tonumber(NCH.version);
NCH.realm = GetRealmName();
NCH.faction = UnitFactionGroup("player");
NCH.class = select(2, UnitClass("player"));
NCH.acr = LibStub:GetLibrary("AceConfigRegistry-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("NovaConsumesHelper");
local LDB = LibStub:GetLibrary("LibDataBroker-1.1");
NCH.LDBIcon = LibStub("LibDBIcon-1.0");
NCH.prefixColor = "|cFFFF6900";
NCH.Masque = LibStub("Masque", true);
if (NCH.Masque) then
	NCH.MasqueGroup = NCH.Masque:Group("NovaConsumesHelper");
end

local function init()
	NCH:loadConsumeSlotOptions();
	NCH:loadExpansionOptions();
    NCH:loadDatabase();
    NCH:loadClassDefaults();
    NCH:checkNewVersion();
	NCH:createBroker();
	NCH:updateConfigOptions();
	NCH:loadConsumesFrame();
	if (showProtectionPots) then
		--NCH:updateProtConfigOptions();
		NCH:buildAbsorbData();
		NCH:loadProtFrame();
		NCH:loadCurrentAbsorbs();
	end
end

local GetSpellInfo = GetSpellInfo;
function NCH.GetSpellInfo(spellIdentifier, bookType)
	if (GetSpellInfo) then
		--No need for bookType we don't use it anywhere and passing nil breaks the function, bit strange.
		--return GetSpellInfo(spellIdentifier, bookType);
		return GetSpellInfo(spellIdentifier);
	else
		local data = C_Spell.GetSpellInfo(spellIdentifier);
		if (data) then --Second arg rank is always nil in original func.
			return data.name, nil, data.iconID, data.castTime, data.minRange, data.maxRange, data.spellID, data.originalIconID;
		end
	end
end

local f = CreateFrame("Frame");
f:RegisterEvent("ADDON_LOADED");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:SetScript("OnEvent", function(self, event, addon)
	if (event == "ADDON_LOADED") then
		if (addon == addonName) then
			init();
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		NCH:cacheSpellNames();
		NCH:buildConsumesButtons(); --Build buttons again once ingame when equipped items are loaded properly.
		C_Timer.After(10, function()
			NCH:buildConsumesButtons();
		end)
		f:UnregisterEvent("PLAYER_ENTERING_WORLD");
	end
end)

function NCH:print(msg, prefix, tbcCheck)
	print("|cFFFFFF00[Consumes]:|r |cFFFFFFFF" .. msg);
end

SLASH_NCHCMD1, SLASH_NCHCMD2, SLASH_NCHCMD3 = '/nch', '/novaconsumeshelper', '/novaconsumehelper';
function SlashCmdList.NCHCMD(msg, editBox)
	if (msg) then
		msg = strlower(msg);
	end
	if (msg == "options" or msg == "option" or msg == "opt" or msg == "config" or msg == "menu") then
		NCH:openConfig();
	elseif (msg == "show") then
		NCH:showConsumesFrame();
		if (showProtectionPots) then
			NCH:showProtFrame();
		end
	elseif (msg == "hide") then
		NCH:hideConsumesFrame();
		if (showProtectionPots) then
			NCH:hideProtFrame()
		end
	elseif (msg == "toggle") then
		NCH:toggleAllFrames();
	elseif (msg == "lock") then
		if (NCH.db.global.lockAllFrames) then
			NCH:print("Frames are already locked, type /nch unlock to unlock them.");
			return;
		else
			NCH:print("Locking All Frames, to unlock them again type /nch unlock.")
		end
		NCH.db.global.lockAllFrames = true;
		NCH:updateFrameLocks();
	elseif (msg == "unlock") then
		if (not NCH.db.global.lockAllFrames) then
			NCH:print("Frames are already unlocked, type /nch lock to lock them.");
		else
			NCH:print("Unlocking all frames.");
		end
		NCH.db.global.lockAllFrames = false;
		NCH:updateFrameLocks();
	elseif (msg ~= nil and msg ~= "") then
		NCH:print("Please type /nch config.");
	else
		NCH:openConfig();
	end
end

function NCH:openConfig(showProfiles, showProtPotions)
	if (InterfaceOptionsFrame and InterfaceOptionsFrame:IsShown()) then
		InterfaceOptionsFrame:Hide();
	elseif (SettingsPanel and SettingsPanel:IsShown()) then
			SettingsPanel:Hide();
	else
		Settings.OpenToCategory("NovaConsumesHelper");
		if (showProfiles) then
			LibStub("AceConfigDialog-3.0"):SelectGroup("NovaConsumesHelper", "profiles"); --The table key not category name.
		elseif (showProtPotions) then
			LibStub("AceConfigDialog-3.0"):SelectGroup("NovaConsumesHelper", "protection"); --The table key not category name.
		end
		NCH:loadConsumeSlotOptions();
		NCH.acr:NotifyChange("NovaConsumesHelper");
	end
end

function NCH:toggleAllFrames()
	local isShown = NCH:toggleConsumesFrame();
	if (showProtectionPots) then
		if (isShown) then
			NCH:toggleProtFrame(true);
		else
			NCH:toggleProtFrame(nil, true);
		end
	end
end

local NCHLDB;
function NCH:createBroker()
	local data = {
		type = "launcher",
		label = "NCH",
		text = "NovaConsumesHelper",
		icon = "Interface\\Icons\\inv_potion_41",
		OnClick = function(self, button)
			if (button == "LeftButton" and IsShiftKeyDown()) then
				NCH:openConfig();
			elseif (button == "LeftButton" and IsControlKeyDown()) then
				NCH:openConfig();
			elseif (button == "LeftButton") then
				NCH:toggleAllFrames();
			elseif (button == "RightButton" and IsShiftKeyDown()) then
				NCH:openConfig();
			elseif (button == "RightButton") then
				NCH:openConfig();
			end
		end,
		OnEnter = function(self, button)
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
			NCH:updateMinimapButton(GameTooltip, self);
			GameTooltip:Show()
		end,
		OnLeave = function(self, button)
			GameTooltip:Hide()
			if (GameTooltip.NCHSeparator) then
				GameTooltip.NCHSeparator:Hide();
			end
			if (GameTooltip.NCHSeparator2) then
				GameTooltip.NCHSeparator2:Hide();
			end
		end,
	};
	NCHLDB = LDB:NewDataObject("NCH", data);
	NCH.LDBIcon:Register("NovaConsumesHelper", NCHLDB, NCH.db.global.minimapIcon);
	--Raise the frame level so users can see if it clashes with an existing icon and they can drag it.
	local frame = NCH.LDBIcon:GetMinimapButton("NovaConsumesHelper");
	if (frame) then
		frame:SetFrameLevel(9);
	end
end
    
function NCH:updateMinimapButton(tooltip, frame)
	tooltip = tooltip or GameTooltip;
	if (not tooltip:IsOwned(frame)) then
		if (tooltip.NCHSeparator) then
			tooltip.NCHSeparator:Hide();
		end
		if (tooltip.NCHSeparator2) then
			tooltip.NCHSeparator2:Hide();
		end
		return;
	end
	tooltip:ClearLines();
	tooltip:AddLine("Nova Consumes Helper");
	if (not tooltip.NCHSeparator) then
		tooltip.NCHSeparator = tooltip:CreateTexture(nil, "BORDER");
		tooltip.NCHSeparator:SetColorTexture(0.6, 0.6, 0.6, 0.85);
		tooltip.NCHSeparator:SetHeight(1);
		tooltip.NCHSeparator:SetPoint("LEFT", 10, 0);
		tooltip.NCHSeparator:SetPoint("RIGHT", -10, 0);
		tooltip.NCHSeparator:Hide();
	end
	--tooltip:AddLine("test");
	tooltip:AddLine(" ");
	tooltip.NCHSeparator:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
	tooltip.NCHSeparator:Show();
	tooltip:AddLine("|cFF9CD6DE" .. L["leftClickMinimapButton"]);
	tooltip:AddLine("|cFF9CD6DE" .. L["rightClickMinimapButton"]);
	--tooltip:AddLine("|cFF9CD6DE" .. L["shiftLeftClickMinimapButton"]);
	--tooltip:AddLine("|cFF9CD6DE" .. L["shiftRightClickMinimapButton"]);
	--tooltip:AddLine("|cFF9CD6DE" .. L["controlLeftClickMinimapButton"]);
	tooltip:Show();
	C_Timer.After(0.1, function()
		NCH:updateMinimapButton(tooltip, frame);
	end)
end

--NCH.isDebug = true;
function NCH:debug(...)
	local data = ...;
	if (data and NCH.isDebug) then
		if (type(data) == "table") then
			UIParentLoadAddOn("Blizzard_DebugTools");
			--DevTools_Dump(data);
    		DisplayTableInspectorWindow(data);
    	else
			print("NCHDebug:", ...);
		end
	end
end

function NCH:pairsByKeys(t, f)
	local a = {};
	for n in pairs(t) do
		tinsert(a, n);
	end
	table.sort(a, f);
	local i = 0;
	local iter = function()
		i = i + 1;
		if (a[i] == nil) then
			return nil;
		else
			return a[i], t[a[i]];
		end
	end
	return iter;
end

local capitalZones;
if (NCH.faction == "Horde") then
	capitalZones = {
		[1454] = true, --Org.
		[1456] = true, --UC.
		[1458] = true, --TB.
		[1954] = true, --Silvermoon.
		[1955] = true, --Shat.
		[125] = true, --Dal.
		[126] = true, --Dal sewers.
	};
else
	capitalZones = {
		[1453] = true, --SW.
		[1455] = true, --IF.
		[1457] = true, --Darn.
		[1947] = true, --Exodar.
		[1955] = true, --Shat.
		[125] = true, --Dal.
		[126] = true, --Dal sewers.
	};
end
function NCH.isInCapitalCity()
	local zone = C_Map.GetBestMapForUnit("player");
	if (capitalZones[zone]) then
		return true;
	end
end

local slotLocales = {
	[1] = INVTYPE_HEAD,
	[2] = INVTYPE_NECK,
	[3] = INVTYPE_SHOULDER,
	[4] = INVTYPE_BODY,
	[5] = INVTYPE_CHEST,
	[6] = INVTYPE_WAIST,
	[7] = INVTYPE_LEGS,
	[8] = INVTYPE_FEET,
	[9] = INVTYPE_WRIST,
	[10] = INVTYPE_HAND,
	[11] = INVTYPE_FINGER,
	[12] = INVTYPE_FINGER,
	[13] = INVTYPE_TRINKET,
	[14] = INVTYPE_TRINKET,
	[15] = INVTYPE_CLOAK,
	[16] = INVTYPE_WEAPONMAINHAND,
	[17] = INVTYPE_WEAPONOFFHAND,
	[18] = INVTYPE_RANGED,
	[19] = INVTYPE_TABARD,
};

function NCH_SlotCheck(slot)
	local itemID = GetInventoryItemID("player", slot);
	if (not itemID) then
		local slotString = "Unknown";
		if (slotLocales[slot]) then
			slotString = slotLocales[slot];
		end
		NCH:print(string.format(L["missingSlot"], slotString));
	end
end

function NCH_PrintMissingSlot(slot)
	local slotString = "Unknown";
	if (slotLocales[slot]) then
		slotString = slotLocales[slot];
	end
	NCH:print(string.format(L["missingSlot"], slotString));
end

function NCH_PrintMissingSpellName(spellID)
	NCH:print(string.format(L["missingSpellname"], spellID));
end

local f = CreateFrame("Frame");
f:RegisterEvent("BAG_UPDATE_COOLDOWN");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "BAG_UPDATE_COOLDOWN") then
		NCH:updateConsumesGCDs();
		if (showProtectionPots) then
			NCH:updateProtGCDs();
		end
	end
end)

--Throddle certain events so we wait for all data to be collected before running a function.
--Avoid running a func multiple times, or sending multiple comms etc.
local throddle = true;
NCH.currentThroddles = {};
function NCH:throddleEventByFunc(event, time, func, ...)
	if (NCH.currentThroddles[func] == nil) then
		--Must be false and not nil.
		NCH.currentThroddles[func] = ... or false;
		C_Timer.After(time, function()
			self[func](self, NCH.currentThroddles[func]);
			NCH.currentThroddles[func] = nil;
		end)
	elseif (not throddle) then
		self[func](...);
	end
end