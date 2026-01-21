local AddonName, SAO = ...
local GetItemInfo = C_Item and C_Item.GetItemInfo or GetItemInfo
function SAO.GetItemText(self, itemID)
local name,_,_,_,_,_,_,_,_,icon = GetItemInfo(itemID)
if name then
return "|T"..icon..":0|t "..name
end
end
function SAO.AddItemOverlayOption(self, spellID, itemID)
local itemTextFunc = function()
local itemText = self:GetItemText(itemID)
if itemText then
return itemText
else
local item = Item:CreateFromItemID(itemID)
return function(callback)
item:ContinueOnItemLoad(callback)
end
end
end
self:AddOverlayOption(spellID, spellID, 0, itemTextFunc)
end
local function registerHealingTranc(self, label, spellID)
self:RegisterAura(label, 0, spellID, "genericarc_05", "Left + Right (Flipped)", 1.5, 192, 192, 192, false)
end
function SAO.RegisterAuraEyeOfGruul(self, label, spellID)
if self.IsTBC() then
registerHealingTranc(self, label, spellID)
end
end
function SAO.RegisterAuraSoulPreserver(self, label, spellID)
if self.IsWrath() then
registerHealingTranc(self, label, spellID)
end
end
function SAO.AddEyeOfGruulOverlayOption(self, spellID)
if self.IsTBC() then
self:AddItemOverlayOption(spellID, 28823)
end
end
function SAO.AddSoulPreserverOverlayOption(self, spellID)
if self.IsWrath() then
self:AddItemOverlayOption(spellID, 37111)
end
end
