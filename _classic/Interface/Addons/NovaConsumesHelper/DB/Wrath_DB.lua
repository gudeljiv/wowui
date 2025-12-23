---------------------------
---NovaConsumesHelper DB--
---------------------------
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local _, NCH = ...;

if (not NCH.isWrath) then
	return;
end
local L = LibStub("AceLocale-3.0"):GetLocale("NovaConsumesHelper");
NCH.slots = {};
NCH.protSlots = {};
local tinsert = tinsert;

NCH.flasks = {
	
};

NCH.potions = {
	
};

NCH.shortPotions = {
	--[[[1] = {
		name = "",
		spellID = ,
		itemID = ,
		icon = ,
		desc = "",
		label = "Pot",
	},]]
};

NCH.foods = {
	
};
 
NCH.foods2 = {
	
};

NCH.tempEnchants = {
	
};

NCH.scrolls = {

};

NCH.misc = {
	[1] = {
		name = "Savory Deviate Delight",
		spellID = 8219,
		itemID = 6657,
		icon = 134302,
		desc = "Changes your character display.",
		label = "Sav",
		sharedSpellIDs = {8220}, --Needs a 2nd spellID, male and female diff buffs.
	},
};

--Flask, Pot1, Pot2, Pot3, Pot4, Food, Oil, Misc1, Misc2, Misc3, Misc4, Misc4, Misc5
NCH.slots[1] = {name = L["Flask"], configSlot = 1};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[1], v);
end

---Extra slots at the bottom of config options.
NCH.slots[19] = {name = L["Flask 2"], configSlot = 54};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[19], v);
end

NCH.slots[20] = {name = L["Flask 3"], configSlot = 55};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[20], v);
end


NCH.slots[21] = {name = L["Flask 4"], configSlot = 56};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[21], v);
end


NCH.slots[22] = {name = L["Flask 5"], configSlot = 57};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[22], v);
end


NCH.slots[2] = {name = L["Potion 1"], configSlot = 2};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[2], v);
end

NCH.slots[3] = {name = L["Potion 2"], configSlot = 3};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[3], v);
end

NCH.slots[4] = {name = L["Potion 3"], configSlot = 4};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[4], v);
end

NCH.slots[5] = {name = L["Potion 4"], configSlot = 5};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[5], v);
end

NCH.slots[6] = {name = L["Potion 5"], configSlot = 6};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[6], v);
end

NCH.slots[7] = {name = L["Potion 6"], configSlot = 15};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[7], v);
end

NCH.slots[8] = {name = L["Potion 7"], configSlot = 16};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[8], v);
end

---Extra slots at the bottom of config options.
NCH.slots[23] = {name = L["Potion 8"], configSlot = 19};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[23], v);
end
NCH.slots[24] = {name = L["Potion 9"], configSlot = 20};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[24], v);
end
NCH.slots[25] = {name = L["Potion 10"], configSlot = 21};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[25], v);
end
NCH.slots[26] = {name = L["Potion 11"], configSlot = 22};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[26], v);
end
NCH.slots[27] = {name = L["Potion 12"], configSlot = 23};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[27], v);
end
NCH.slots[28] = {name = L["Potion 13"], configSlot = 24};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[28], v);
end
NCH.slots[29] = {name = L["Potion 14"], configSlot = 25};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[29], v);
end
----------------------


NCH.slots[9] = {name = L["Food 1"], configSlot = 7};
for k, v in pairs(NCH.foods) do
	tinsert(NCH.slots[9], v);
end

NCH.slots[10] = {name = L["Food 2"], configSlot = 8};
for k, v in pairs(NCH.foods) do
	tinsert(NCH.slots[10], v);
end

---Extra slots at the bottom of config options.
NCH.slots[30] = {name = L["Food 3"], configSlot = 26};
for k, v in pairs(NCH.foods) do
	tinsert(NCH.slots[30], v);
end

NCH.slots[31] = {name = L["Food 4"], configSlot = 27};
for k, v in pairs(NCH.foods) do
	tinsert(NCH.slots[31], v);
end

NCH.slots[32] = {name = L["Food 5"], configSlot = 28};
for k, v in pairs(NCH.foods) do
	tinsert(NCH.slots[32], v);
end
----------------------


NCH.slots[11] = {name = L["Main Hand Oils/Stones/Enchants 1"], configSlot = 9};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "mainhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "MH";
		t.mainhand = true;
		tinsert(NCH.slots[11], t);
	end
end

NCH.slots[12] = {name = L["Off Hand Oils/Stones/Enchants 1"], configSlot = 10};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "offhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "OH";
		t.offhand = true;
		tinsert(NCH.slots[12], t);
	end
end

---Extra slots at the bottom of config options.
NCH.slots[33] = {name = L["Main Hand Oils/Stones/Enchants 2"], configSlot = 36};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "mainhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "MH";
		t.mainhand = true;
		tinsert(NCH.slots[33], t);
	end
end

NCH.slots[34] = {name = L["Main Hand Oils/Stones/Enchants 3"], configSlot = 37};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "mainhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "MH";
		t.mainhand = true;
		tinsert(NCH.slots[34], t);
	end
end

NCH.slots[35] = {name = L["Off Hand Oils/Stones/Enchants 2"], configSlot = 38};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "offhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "OH";
		t.offhand = true;
		tinsert(NCH.slots[35], t);
	end
end

NCH.slots[36] = {name = L["Off Hand Oils/Stones/Enchants 3"], configSlot = 39};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "offhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "OH";
		t.offhand = true;
		tinsert(NCH.slots[36], t);
	end
end

NCH.slots[13] = {name = L["Scroll 1"], configSlot = 11};
for k, v in pairs(NCH.scrolls) do
	tinsert(NCH.slots[13], v);
end

NCH.slots[37] = {name = L["Scroll 2"], configSlot = 40};
for k, v in pairs(NCH.scrolls) do
	tinsert(NCH.slots[37], v);
end

NCH.slots[38] = {name = L["Scroll 3"], configSlot = 41};
for k, v in pairs(NCH.scrolls) do
	tinsert(NCH.slots[38], v);
end

NCH.slots[14] = {name = L["Miscellaneous 1"], configSlot = 12};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[14], v);
end

NCH.slots[15] = {name = L["Miscellaneous 2"], configSlot = 13};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[15], v);
end

NCH.slots[16] = {name = L["Miscellaneous 3"], configSlot = 14};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[16], v);
end

NCH.slots[17] = {name = L["Miscellaneous 4"], configSlot = 17};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[17], v);
end

NCH.slots[18] = {name = L["Miscellaneous 5"], configSlot = 18};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[18], v);
end

---Extra slots at the bottom of config options.
NCH.slots[39] = {name = L["Miscellaneous 6"], configSlot = 29};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[39], v);
end

NCH.slots[40] = {name = L["Miscellaneous 7"], configSlot = 30};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[40], v);
end

NCH.slots[41] = {name = L["Miscellaneous 8"], configSlot = 31};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[41], v);
end

NCH.slots[42] = {name = L["Miscellaneous 9"], configSlot = 32};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[42], v);
end

NCH.slots[43] = {name = L["Miscellaneous 10"], configSlot = 33};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[43], v);
end

NCH.slots[44] = {name = L["Miscellaneous 11"], configSlot = 34};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[44], v);
end

NCH.slots[45] = {name = L["Miscellaneous 12"], configSlot = 35};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[45], v);
end
----------------------

NCH.slots[46] = {name = L["Short Duration (DPS) Pots 1"], configSlot = 42};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[46], v);
end

NCH.slots[47] = {name = L["Short Duration (DPS) Pots 2"], configSlot = 43};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[47], v);
end

NCH.slots[48] = {name = L["Short Duration (DPS) Pots 3"], configSlot = 44};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[48], v);
end

NCH.slots[49] = {name = L["Short Duration (DPS) Pots 4"], configSlot = 45};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[49], v);
end

NCH.slots[50] = {name = L["Short Duration (DPS) Pots 5"], configSlot = 46};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[50], v);
end

NCH.slots[51] = {name = L["Short Duration (DPS) Pots 6"], configSlot = 47};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[51], v);
end

NCH.slots[52] = {name = L["Short Duration (DPS) Pots 7"], configSlot = 48};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[52], v);
end

NCH.slots[53] = {name = L["Short Duration (DPS) Pots 8"], configSlot = 49};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[53], v);
end

NCH.slots[54] = {name = L["Short Duration (DPS) Pots 9"], configSlot = 50};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[54], v);
end

NCH.slots[55] = {name = L["Short Duration (DPS) Pots 10"], configSlot = 51};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[55], v);
end

NCH.slots[56] = {name = L["Short Duration (DPS) Pots 11"], configSlot = 52};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[56], v);
end

NCH.slots[57] = {name = L["Short Duration (DPS) Pots 12"], configSlot = 53};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[57], v);
end


NCH.protectionPots = {
	
};

function NCH:auditDatabase()
	print("Starting audit.");
	for k, v in ipairs(NCH.slots) do
		for item, itemData in ipairs(v) do
			if ((not itemData.spellID and not itemData.enchantID) or not itemData.name or not itemData.icon or not itemData.desc or not itemData.label) then
				print("Missing data:", itemData.name, itemData.itemID);
			end
			if (itemData.itemID) then
				local item = Item:CreateFromItemID(itemData.itemID);
				item:ContinueOnItemLoad(function()
					local itemName = item:GetItemName();
					if (itemName ~= itemData.name) then
						print("Item name mismatch:", itemData.name, " -> " .. itemName);
					end
					local icon = item:GetItemIcon();
					if (icon ~= itemData.icon) then
						print("Icon mismatch:", itemData.name, " -> " .. itemData.icon,  " -> " .. icon);
					end
				end);
			end
			--No real way to check spellIDs linked to itemID I guess.
			--[[if (itemData.spellID) then
				local spell = Spell:CreateFromSpellID(itemData.spellID);
				spell:ContinueOnSpellLoad(function()
					local spellName = spell:GetSpellName();
					if (spellName ~= itemData.name) then
						print("Spell name mismatch:", itemData.name, " -> " .. spellName);
					end
					local icon = spell:GetSpellTexure();
					if (icon ~= itemData.icon) then
						print("Icon mismatch:", itemData.name, " -> " .. itemData.icon,  " -> " .. icon);
					end
				end);
			end]]
		end
	end
end

function NCH:scanForUnique()
	print("Starting unique scan.");
	local tooltipScanner = CreateFrame("GameTooltip", "NCH_UniqueScanner", nil, "GameTooltipTemplate");
	tooltipScanner:SetOwner(WorldFrame, "ANCHOR_NONE");
	local tooltipLines = {
		[1] = NCH_UniqueScannerTextLeft2,
		[2] = NCH_UniqueScannerTextLeft3,
		[3] = NCH_UniqueScannerTextLeft4,
	};
	local slots = {NCH.flasks, NCH.potions, NCH.shortPotions, NCH.foods, NCH.foods2, NCH.tempEnchants, NCH.scrolls, NCH.misc}
	for k, v in ipairs(slots) do
		for item, itemData in ipairs(v) do
			if (itemData.itemID) then
				local item = Item:CreateFromItemID(itemData.itemID);
				item:ContinueOnItemLoad(function()
					local itemLink = item:GetItemLink();
					tooltipScanner:SetHyperlink(itemLink);
					local found;
		            for i = 1, 5 do
			            local text = _G["NCH_UniqueScannerTextLeft" .. i]:GetText();
			            if (text and strmatch(text, "Unique")) then
			            	if (itemData.unique) then
			            		print("|cFF00FF00Unique flag set:|r", item:GetItemName());
			            	else
			            		print("|cFFFF0000Missing unique flag:|r", item:GetItemName());
			            	end
			            	found = true;
			            end
		            end
		            if (itemData.unique and not found) then
		            	print("|cFFFF0000Not unique item with flag set:|r", item:GetItemName());
		            end
				end);
			end
		end
	end
end