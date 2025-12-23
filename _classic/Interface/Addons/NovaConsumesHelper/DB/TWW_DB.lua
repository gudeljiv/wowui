---------------------------
---NovaConsumesHelper DB--
---------------------------
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local _, NCH = ...;

if (not NCH.isTWW) then
	return;
end
local L = LibStub("AceLocale-3.0"):GetLocale("NovaConsumesHelper");
NCH.slots = {};
local tinsert = tinsert;

NCH.flasks = {

};


NCH.slots[1] = {name = L["Flask"], configSlot = 1};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[1], v);
end



function NCH:auditDatabase()
	print("Starting audit.")
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