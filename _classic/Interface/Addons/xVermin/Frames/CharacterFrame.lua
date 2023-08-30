local _, xVermin = ...

-- local function SetGlowBorder(self)
-- 	self.Glowborder = CreateFrame("Frame", nil, self, BackdropTemplateMixin and "BackdropTemplate")
-- 	self.Glowborder:SetFrameLevel(0)
-- 	self.Glowborder:SetPoint("TOPLEFT", self, "TOPLEFT", -6, 6)
-- 	self.Glowborder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 6, -6)
-- 	self.Glowborder:SetBackdrop(
-- 		{
-- 			bgFile = xVermin.Config.border.default,
-- 			edgeFile =  xVermin.Config.border.default,
-- 			tile = false,
-- 			tileSize = 16,
-- 			edgeSize = 4,
-- 			insets = {left = -4, right = -4, top = -4, bottom = -4}
-- 		}
-- 	)
-- 	self.Glowborder:SetBackdropColor(0, 0, 0, 0)
-- 	self.Glowborder:SetBackdropBorderColor(0, 0, 0, 1)
-- end

local function BorderItemSlots()
	local itemLink, r, g, b, itemLink

	for i, v in pairs(
		{
			CharacterHeadSlot,
			CharacterNeckSlot,
			CharacterShoulderSlot,
			CharacterBackSlot,
			CharacterChestSlot,
			CharacterWristSlot,
			CharacterHandsSlot,
			CharacterWaistSlot,
			CharacterLegsSlot,
			CharacterFeetSlot,
			CharacterFinger0Slot,
			CharacterFinger1Slot,
			CharacterTrinket0Slot,
			CharacterTrinket1Slot,
			CharacterMainHandSlot,
			CharacterSecondaryHandSlot,
			CharacterRangedSlot,
			CharacterAmmoSlot,
			CharacterTabardSlot,
			CharacterShirtSlot
		}
	) do
		v:CreateBeautyBorder(8)

		itemLink = GetInventoryItemLink('player', GetInventorySlotInfo(v:GetName():gsub('Character', '')))

		if v.ItemLevelText then
			v.ItemLevelText:SetText('')
		end

		if itemLink then
			local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(itemLink)
			if itemQuality and itemQuality > 1 then
				r, g, b = GetItemQualityColor(itemQuality)
				v:SetBeautyBorderTexture(xVermin.Config.border.colorize)
				v:SetBeautyBorderColor(r, g, b, 1)
			else
				v:SetBeautyBorderTexture(xVermin.Config.border.default)
				v:SetBeautyBorderColor(1, 1, 1, 1)
			end

			if itemLevel then
				if not v.ItemLevelText then
					v.ItemLevelText = v:CreateFontString(nil, 'ARTWORK')
					v.ItemLevelText:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
					v.ItemLevelText:SetShadowOffset(0, 0)
					v.ItemLevelText:SetPoint('BOTTOMRIGHT', v, 'BOTTOMRIGHT', -2, 2)
					v.ItemLevelText:SetVertexColor(1, 1, 0)
				end
				v.ItemLevelText:SetText(itemLevel)
			end
		else
			v:SetBeautyBorderTexture(xVermin.Config.border.default)
			v:SetBeautyBorderColor(1, 1, 1, 1)
		end
	end
end

CharacterModelFrameRotateRightButton:Hide()
CharacterModelFrameRotateLeftButton:Hide()

local f = CreateFrame('Frame')
f:RegisterEvent('UNIT_INVENTORY_CHANGED')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
-- f:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
f:SetScript('OnEvent', BorderItemSlots)
