--[[
AdiBags - Adirelle's bag addon.
Copyright 2010-2014 Adirelle (adirelle@gmail.com)
All rights reserved.

This file is part of AdiBags.

AdiBags is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

AdiBags is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with AdiBags.  If not, see <http://www.gnu.org/licenses/>.
--]]

local _, addon = ...

--<GLOBALS
local _G = _G
local BAG_ITEM_QUALITY_COLORS = _G.BAG_ITEM_QUALITY_COLORS
local BankButtonIDToInvSlotID = _G.BankButtonIDToInvSlotID
local BANK_CONTAINER = _G.BANK_CONTAINER
local C_Item_CanScrapItem = _G.C_Item.CanScrapItem
local C_Item_DoesItemExist = _G.C_Item.DoesItemExist
local ContainerFrame_UpdateCooldown = _G.ContainerFrame_UpdateCooldown
local format = _G.format
local GetContainerItemID = _G.GetContainerItemID
local GetContainerItemInfo = _G.GetContainerItemInfo
local GetContainerItemLink = _G.GetContainerItemLink
local GetContainerItemQuestInfo = _G.GetContainerItemQuestInfo
local GetContainerNumFreeSlots = _G.GetContainerNumFreeSlots
local GetItemInfo = _G.GetItemInfo
local hooksecurefunc = _G.hooksecurefunc
local IsBattlePayItem = _G.IsBattlePayItem
--local IsContainerItemAnUpgrade = _G.IsContainerItemAnUpgrade
local IsInventoryItemLocked = _G.IsInventoryItemLocked
local LE_ITEM_QUALITY_POOR = _G.LE_ITEM_QUALITY_POOR
local LE_ITEM_QUALITY_COMMON = _G.LE_ITEM_QUALITY_COMMON
local next = _G.next
local pairs = _G.pairs
local REAGENTBANK_CONTAINER = _G.REAGENTBANK_CONTAINER
local ReagentBankButtonIDToInvSlotID = _G.ReagentBankButtonIDToInvSlotID
local select = _G.select
local SetItemButtonDesaturated = _G.SetItemButtonDesaturated
local SplitContainerItem = _G.SplitContainerItem
local StackSplitFrame = _G.StackSplitFrame
local TEXTURE_ITEM_QUEST_BANG = _G.TEXTURE_ITEM_QUEST_BANG
local tostring = _G.tostring
local unpack = _G.unpack
local wipe = _G.wipe
--GLOBALS>

local GetSlotId = addon.GetSlotId
local GetBagSlotFromId = addon.GetBagSlotFromId

local ITEM_SIZE = addon.ITEM_SIZE

--------------------------------------------------------------------------------
-- Button initialization
--------------------------------------------------------------------------------

local buttonClass, buttonProto = addon:NewClass("ItemButton", "ItemButton", "ContainerFrameItemButtonTemplate", "ABEvent-1.0")

local childrenNames = { "Cooldown", "IconTexture", "IconQuestTexture", "Count", "Stock", "NormalTexture", "NewItemTexture" }

function buttonProto:OnCreate()
	local name = self:GetName()
	for _, childName in pairs(childrenNames) do
		if not self[childName] then
			self[childName] = _G[name..childName]
		end
	end
	self:RegisterForDrag("LeftButton")
	self:RegisterForClicks("LeftButtonUp","RightButtonUp")
	self:SetScript('OnShow', self.OnShow)
	self:SetScript('OnHide', self.OnHide)
	self:SetWidth(ITEM_SIZE)
	self:SetHeight(ITEM_SIZE)
	if ElvUI then
		self:SetTemplate(nil, true)
		self:StyleButton()
	elseif KlixUI then
		self:SetTemplate("Transparent")
		self:StyleButton(1)
	end
	self:SetNormalTexture(nil)
	if not self.ScrapIcon then
		local scrapIcon = self:CreateTexture(nil, "OVERLAY")
		scrapIcon:SetAtlas("bags-icon-scrappable")
		scrapIcon:Size(14, 12)
		scrapIcon:SetPoint("TOPRIGHT", -2, -2)
		scrapIcon:Hide()
		self.ScrapIcon = scrapIcon
	end
	if not self.Azerite then
		local azerite = self:CreateTexture(nil, "ARTWORK")
		azerite:SetAtlas("AzeriteIconFrame")
		azerite:SetTexCoord(0, 1, 0, 1)
		azerite:SetInside()
		azerite:Hide()
		self.Azerite = azerite
	end
	if not self.Corruption then
		local corruption = self:CreateTexture(nil, "ARTWORK")
		corruption:SetAtlas("Nzoth-inventory-icon")
		corruption:SetInside()
		corruption:Hide()
		self.Corruption = corruption
	end
	if not self.QuestIcon then
		local questIcon = self:CreateFontString(nil, "OVERLAY")
		questIcon:SetPoint("LEFT", 3, 0)
		if ElvUI then
			questIcon:SetFont(ElvUI[1].media.normFont, 30, "OUTLINE")
		elseif KlixUI then
			questIcon:SetFont(KlixUI[1].media.font, 30, "OUTLINE")
		end
		questIcon:SetTextColor(1, 1, 0)
		questIcon:SetText("!")
		self.QuestIcon = questIcon
	end
	if self.NewItemTexture then
		self.NewItemTexture:Hide()
	end
	self.SplitStack = nil -- Remove the function set up by the template
end

function buttonProto:OnAcquire(container, bag, slot)
	self.container = container
	self.bag = bag
	self.slot = slot
	self.stack = nil
	self:SetParent(addon.itemParentFrames[bag])
	self:SetID(slot)
	self:FullUpdate()
end

function buttonProto:OnRelease()
	self:SetSection(nil)
	self.container = nil
	self.itemId = nil
	self.itemLink = nil
	self.hasItem = nil
	self.texture = nil
	self.bagFamily = nil
	self.stack = nil
end

function buttonProto:ToString()
	return format("Button-%s-%s", tostring(self.bag), tostring(self.slot))
end

function buttonProto:IsLocked()
	return select(3, GetContainerItemInfo(self.bag, self.slot))
end

function buttonProto:SplitStack(split)
	SplitContainerItem(self.bag, self.slot, split)
end

--------------------------------------------------------------------------------
-- Generic bank button sub-type
--------------------------------------------------------------------------------

local bankButtonClass, bankButtonProto = addon:NewClass("BankItemButton", "ItemButton")
bankButtonClass.frameTemplate = "BankItemButtonGenericTemplate"

function bankButtonProto:OnAcquire(container, bag, slot)
	self.GetInventorySlot = nil -- Remove the method added by the template
	self.inventorySlot = bag == REAGENTBANK_CONTAINER and ReagentBankButtonIDToInvSlotID(slot) or BankButtonIDToInvSlotID(slot)
	return buttonProto.OnAcquire(self, container, bag, slot)
end

function bankButtonProto:IsLocked()
	return IsInventoryItemLocked(self.inventorySlot)
end

function bankButtonProto:UpdateNew()
	-- Not supported
end

function bankButtonProto:GetInventorySlot()
	return self.inventorySlot
end

function bankButtonProto:UpdateUpgradeIcon()
	if self.bag ~= BANK_CONTAINER and self.bag ~= REAGENTBANK_CONTAINER then
		buttonProto.UpdateUpgradeIcon(self)
	end
end

--------------------------------------------------------------------------------
-- Pools and acquistion
--------------------------------------------------------------------------------

local containerButtonPool = addon:CreatePool(buttonClass)
local bankButtonPool = addon:CreatePool(bankButtonClass)

function addon:AcquireItemButton(container, bag, slot)
	if bag == BANK_CONTAINER or bag == REAGENTBANK_CONTAINER then
		return bankButtonPool:Acquire(container, bag, slot)
	else
		return containerButtonPool:Acquire(container, bag, slot)
	end
end

-- Pre-spawn a bunch of buttons, when we are out of combat
-- because buttons created in combat do not work well
hooksecurefunc(addon, 'OnInitialize', function()
	addon:Debug('Prespawning buttons')
	containerButtonPool:PreSpawn(160)
end)

--------------------------------------------------------------------------------
-- Model data
--------------------------------------------------------------------------------

function buttonProto:SetSection(section)
	local oldSection = self.section
	if oldSection ~= section then
		self.section = section
		if oldSection then
			oldSection:RemoveItemButton(self)
		end
		return true
	end
end

function buttonProto:GetSection()
	return self.section
end

function buttonProto:GetItemId()
	return self.itemId
end

function buttonProto:GetItemLink()
	return self.itemLink
end

function buttonProto:GetCount()
	return select(2, GetContainerItemInfo(self.bag, self.slot)) or 0
end

function buttonProto:GetBagFamily()
	return self.bagFamily
end

local BANK_BAG_IDS = addon.BAG_IDS.BANK
function buttonProto:IsBank()
	return not not BANK_BAG_IDS[self.bag]
end

function buttonProto:IsStack()
	return false
end

function buttonProto:GetRealButton()
	return self
end

function buttonProto:SetStack(stack)
	self.stack = stack
end

function buttonProto:GetStack()
	return self.stack
end

local function SimpleButtonSlotIterator(self, slotId)
	if not slotId and self.bag and self.slot then
		return GetSlotId(self.bag, self.slot), self.bag, self.slot, self.itemId, self.stack
	end
end

function buttonProto:IterateSlots()
	return SimpleButtonSlotIterator, self
end

--------------------------------------------------------------------------------
-- Scripts & event handlers
--------------------------------------------------------------------------------

function buttonProto:OnShow()
	self:RegisterEvent('BAG_UPDATE_COOLDOWN', 'UpdateCooldown')
	self:RegisterEvent('ITEM_LOCK_CHANGED', 'UpdateLock')
	self:RegisterEvent('QUEST_ACCEPTED', 'UpdateBorder')
	self:RegisterEvent('BAG_NEW_ITEMS_UPDATED', 'UpdateNew')
	self:RegisterEvent('PLAYER_EQUIPMENT_CHANGED', 'FullUpdate')
	if self.UpdateSearch then
		self:RegisterEvent('INVENTORY_SEARCH_UPDATE', 'UpdateSearch')
	end
	self:RegisterEvent('UNIT_QUEST_LOG_CHANGED')
	self:RegisterMessage('AdiBags_UpdateAllButtons', 'Update')
	self:RegisterMessage('AdiBags_GlobalLockChanged', 'UpdateLock')
	self:FullUpdate()
end

function buttonProto:OnHide()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	if self.hasStackSplit and self.hasStackSplit == 1 then
		StackSplitFrame:Hide()
	end
end

function buttonProto:UNIT_QUEST_LOG_CHANGED(event, unit)
	if unit == "player" then
		self:UpdateBorder(event)
	end
end

--------------------------------------------------------------------------------
-- Display updating
--------------------------------------------------------------------------------

function buttonProto:CanUpdate()
	if not self:IsVisible() or addon.holdYourBreath then
		return false
	end
	return true
end

function buttonProto:FullUpdate()
	local bag, slot = self.bag, self.slot
	self.itemId = GetContainerItemID(bag, slot)
	self.itemLink = GetContainerItemLink(bag, slot)
	self.hasItem = not not self.itemId
	self.texture = GetContainerItemInfo(bag, slot)
	self.bagFamily = select(2, GetContainerNumFreeSlots(bag))
	self:Update()
end

function buttonProto:Update()
	if not self:CanUpdate() then return end
	local icon = self.IconTexture
	if self.texture then
		icon:SetTexture(self.texture)
		if ElvUI then
			icon:SetTexCoord(unpack(ElvUI[1].TexCoords))
			icon:SetInside()
		elseif KlixUI then
			icon:SetTexCoord(unpack(KlixUI[1].TexCoords))
			icon:SetInside(nil, 1, 1)
		end
	else
		icon:SetTexture()
		if ElvUI then
			icon:SetTexCoord(unpack(ElvUI[1].TexCoords))
			icon:SetInside()
		elseif KlixUI then
			icon:SetTexCoord(unpack(KlixUI[1].TexCoords))
			icon:SetInside(nil, 1, 1)
		end
	end
	local tag = (not self.itemId or addon.db.profile.showBagType) and addon:GetFamilyTag(self.bagFamily)
	if tag then
		self.Stock:SetText(tag)
		self.Stock:Show()
	else
		self.Stock:Hide()
	end
	self:UpdateCount()
	self:UpdateBorder()
	self:UpdateCooldown()
	self:UpdateLock()
	self:UpdateNew()
	self:UpdateUpgradeIcon()
	self:UpdateScrapIcon()
	self:UpdateAzerite()
	self:UpdateCorruption()
	--self:UpdateQuestIcon()
	self:UpdateKlixStyling()
	if self.UpdateSearch then
		self:UpdateSearch()
	end
	
	-- Only way i can make the none scrapitems to hide, when the scrappingmachine is opened :S
	if IsAddOnLoaded("Blizzard_ScrappingMachineUI") then
		if _G.ScrappingMachineFrame:IsShown() then
			if not self.ScrapIcon:IsShown() then
				self.searchOverlay:Show()
				self:SetAlpha(0.5)
			end
		else
			self.searchOverlay:Hide()
			self:SetAlpha(1)
		end
	end
	
	addon:SendMessage('AdiBags_UpdateButton', self)
end

function buttonProto:UpdateCount()
	local count = self:GetCount() or 0
	self.count = count
	if count > 1 then
		self.Count:SetText(count)
		self.Count:Show()
	else
		self.Count:Hide()
	end
end

function buttonProto:UpdateLock(isolatedEvent)
	if addon.globalLock then
		SetItemButtonDesaturated(self, true)
		self:Disable()
	else
		self:Enable()
		SetItemButtonDesaturated(self, self:IsLocked())
	end
	if isolatedEvent then
		addon:SendMessage('AdiBags_UpdateLock', self)
	end
end

function buttonProto:UpdateSearch()
	local _, _, _, _, _, _, _, isFiltered = GetContainerItemInfo(self.bag, self.slot)
	if isFiltered then
		self.searchOverlay:Show()
		self:SetAlpha(0.5)
	else
		self.searchOverlay:Hide()
		self:SetAlpha(1)
	end
end

function buttonProto:UpdateCooldown()
	if ElvUI then
		ElvUI[1]:RegisterCooldown(self.Cooldown)
	end
	return ContainerFrame_UpdateCooldown(self.bag, self)
end

function buttonProto:UpdateNew()
	self.BattlepayItemTexture:SetShown(IsBattlePayItem(self.bag, self.slot))
end

function buttonProto:UpdateUpgradeIcon()
	self.UpgradeIcon:SetShown(IsContainerItemAnUpgrade(self.bag, self.slot) or false)
end

function buttonProto:UpdateScrapIcon()
	local itemLocation = _G.ItemLocation:CreateFromBagAndSlot(self.bag, self.slot)
	if itemLocation then
		self.ScrapIcon:SetShown(addon.db.profile.scrapIndicator and C_Item_DoesItemExist(itemLocation) and C_Item_CanScrapItem(itemLocation) or false)
	end	
end

function buttonProto:UpdateAzerite()
	local link = GetContainerItemLink(self.bag, self.slot)
	if link then
		self.Azerite:SetShown(C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(link))
	else
		self.Azerite:Hide()
	end
end

function buttonProto:UpdateCorruption()
	local link = GetContainerItemLink(self.bag, self.slot)
	self.Corruption:SetShown(link and IsCorruptedItem(link))
end

function buttonProto:UpdateQuestIcon()
	local isQuestItem, questId, isActive = GetContainerItemQuestInfo(self.bag, self.slot)
	if questId and not isActive then
		self.QuestIcon:SetAlpha(1)
	else
		self.QuestIcon:SetAlpha(0)
	end
end

function buttonProto:UpdateKlixStyling()
	if ElvUI_KlixUI then
		self:CreateIconShadow()
	end
end

local function GetBorder(bag, slot, settings)
	if settings.questIndicator then
		local isQuestItem, questId, isActive = GetContainerItemQuestInfo(bag, slot)
		if questId and not isActive then
			--return TEXTURE_ITEM_QUEST_BANG, 1, 1, 0, settings.qualityOpacity
			return nil, 1, 1, 0, settings.qualityOpacity
		end
		if questId or isQuestItem then
			return nil, 1, 0.3, 0.3, settings.qualityOpacity
		end
	end
	if not settings.qualityHighlight then
		return
	end
	local _, _, _, quality = GetContainerItemInfo(bag, slot)
	if quality == LE_ITEM_QUALITY_POOR and settings.dimJunk then
		local v = 1 - 0.5 * settings.qualityOpacity
		return true, v, v, v, 1, "MOD"
	end
	local color = settings.allHighlight and BAG_ITEM_QUALITY_COLORS[quality] or quality ~= LE_ITEM_QUALITY_COMMON and BAG_ITEM_QUALITY_COLORS[quality]
	if color then
		return [[Interface\Buttons\UI-ActionButton-Border]], color.r, color.g, color.b, settings.qualityOpacity, "ADD"
	end
end

function buttonProto:UpdateBorder(isolatedEvent)
	if ElvUI then
		self:SetBackdropBorderColor(unpack(ElvUI[1].media.bordercolor))
	elseif KlixUI then
		self:SetBackdropBorderColor(unpack(KlixUI[1].media.bordercolor))
	end
	local texture, r, g, b, a, blendMode
	if self.hasItem then
		texture, r, g, b, a, blendMode = GetBorder(self.bag, self.slot, addon.db.profile)
	end
	local border = self.IconQuestTexture
	if not texture and texture ~= nil then
		border:Hide()
	else
		if texture == true then
			border:SetColorTexture(r, g, b, a)
		--elseif texture == TEXTURE_ITEM_QUEST_BANG then
			--border:SetTexture(texture)
			--self:SetBackdropBorderColor(r, g, b, a)
		else
			border:SetTexture()
			self:SetBackdropBorderColor(r, g, b, a)
		end
		border:SetTexCoord(0, 1, 0, 1)
		border:SetInside()
		border:SetBlendMode(blendMode or "BLEND")
		border:Show()
	end
	
	self:UpdateQuestIcon() -- place this here, else the questicon wont live update!
	
	if self.JunkIcon then
		local quality = self.hasItem and select(3, GetItemInfo(self.itemLink or self.itemId))
		self.JunkIcon:SetShown(quality == LE_ITEM_QUALITY_POOR and addon:GetInteractingWindow() == "MERCHANT")
	end
	if isolatedEvent then
		addon:SendMessage('AdiBags_UpdateBorder', self)
	end
end

--------------------------------------------------------------------------------
-- Item stack button
--------------------------------------------------------------------------------

local stackClass, stackProto = addon:NewClass("StackButton", "Frame", "ABEvent-1.0")
addon:CreatePool(stackClass, "AcquireStackButton")

function stackProto:OnCreate()
	self:SetWidth(ITEM_SIZE)
	self:SetHeight(ITEM_SIZE)
	self.slots = {}
	self:SetScript('OnShow', self.OnShow)
	self:SetScript('OnHide', self.OnHide)
	self.GetCountHook = function()
		return self.count
	end
end

function stackProto:OnAcquire(container, key)
	self.container = container
	self.key = key
	self.count = 0
	self.dirtyCount = true
	self:SetParent(container)
end

function stackProto:OnRelease()
	self:SetVisibleSlot(nil)
	self:SetSection(nil)
	self.key = nil
	self.container = nil
	wipe(self.slots)
end

function stackProto:GetCount()
	return self.count
end

function stackProto:IsStack()
	return true
end

function stackProto:GetRealButton()
	return self.button
end

function stackProto:GetKey()
	return self.key
end

function stackProto:UpdateVisibleSlot()
	local bestLockedId, bestLockedCount
	local bestUnlockedId, bestUnlockedCount
	if self.slotId and self.slots[self.slotId] then
		local _, count, locked = GetContainerItemInfo(GetBagSlotFromId(self.slotId))
		count = count or 1
		if locked then
			bestLockedId, bestLockedCount = self.slotId, count
		else
			bestUnlockedId, bestUnlockedCount = self.slotId, count
		end
	end
	for slotId in pairs(self.slots) do
		local _, count, locked = GetContainerItemInfo(GetBagSlotFromId(slotId))
		count = count or 1
		if locked then
			if not bestLockedId or count > bestLockedCount then
				bestLockedId, bestLockedCount = slotId, count
			end
		else
			if not bestUnlockedId or count > bestUnlockedCount then
				bestUnlockedId, bestUnlockedCount = slotId, count
			end
		end
	end
	return self:SetVisibleSlot(bestUnlockedId or bestLockedId)
end

function stackProto:ITEM_LOCK_CHANGED()
	return self:Update()
end

function stackProto:AddSlot(slotId)
	local slots = self.slots
	if not slots[slotId] then
		slots[slotId] = true
		self.dirtyCount = true
		self:Update()
	end
end

function stackProto:RemoveSlot(slotId)
	local slots = self.slots
	if slots[slotId] then
		slots[slotId] = nil
		self.dirtyCount = true
		self:Update()
	end
end

function stackProto:IsEmpty()
	return not next(self.slots)
end

function stackProto:OnShow()
	self:RegisterMessage('AdiBags_UpdateAllButtons', 'Update')
	self:RegisterMessage('AdiBags_PostContentUpdate')
	self:RegisterEvent('ITEM_LOCK_CHANGED')
	if self.button then
		self.button:Show()
	end
	self:Update()
end

function stackProto:OnHide()
	if self.button then
		self.button:Hide()
	end
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
end

function stackProto:SetVisibleSlot(slotId)
	if slotId == self.slotId then return end
	self.slotId = slotId
	local button = self.button
	local mouseover = false
	if button then
		if button:IsMouseOver() then
			mouseover = true
			button:GetScript('OnLeave')(button)
		end
		button.GetCount = nil
		button:Release()
	end
	if slotId then
		button = addon:AcquireItemButton(self.container, GetBagSlotFromId(slotId))
		button.GetCount = self.GetCountHook
		button:SetAllPoints(self)
		button:SetStack(self)
		button:Show()
		if mouseover then
			button:GetScript('OnEnter')(button)
		end
	else
		button = nil
	end
	self.button = button
	return true
end

function stackProto:Update()
	if not self:CanUpdate() then return end
	self:UpdateVisibleSlot()
	self:UpdateCount()
	if self.button then
		self.button:FullUpdate()
	end
end

stackProto.FullUpdate = stackProto.Update

function stackProto:UpdateCount()
	local count = 0
	for slotId in pairs(self.slots) do
		count = count + (select(2, GetContainerItemInfo(GetBagSlotFromId(slotId))) or 1)
	end
	self.count = count
	self.dirtyCount = nil
end

function stackProto:AdiBags_PostContentUpdate()
	if self.dirtyCount then
		self:UpdateCount()
	end
end

function stackProto:GetItemId()
	return self.button and self.button:GetItemId()
end

function stackProto:GetItemLink()
	return self.button and self.button:GetItemLink()
end

function stackProto:IsBank()
	return self.button and self.button:IsBank()
end

function stackProto:GetBagFamily()
	return self.button and self.button:GetBagFamily()
end

local function StackSlotIterator(self, previous)
	local slotId = next(self.slots, previous)
	if slotId then
		local bag, slot = GetBagSlotFromId(slotId)
		local _, count = GetContainerItemInfo(bag, slot)
		return slotId, bag, slot, self:GetItemId(), count
	end
end

function stackProto:IterateSlots()
	return StackSlotIterator, self
end

-- Reuse button methods
stackProto.CanUpdate = buttonProto.CanUpdate
stackProto.SetSection = buttonProto.SetSection
stackProto.GetSection = buttonProto.GetSection
