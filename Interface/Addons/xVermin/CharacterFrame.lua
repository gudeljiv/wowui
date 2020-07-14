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
			CharacterAmmoSlot
		}
	) do
		v:CreateBeautyBorder(8)
		itemLink = GetInventoryItemLink("player", GetInventorySlotInfo(v:GetName():gsub("Character", "")))
		if (itemLink) then
			_, _, itemRarity = GetItemInfo(itemLink)
			if (itemRarity and itemRarity > 1) then
				r, g, b = GetItemQualityColor(itemRarity)
				v:SetBeautyBorderTexture(config.border.neutral)
				v:SetBeautyBorderColor(r, g, b, 1)
			else
				-- v:SetBeautyShadowTexture(config.border.shadow)
				-- v:SetBeautyBorderTexture(config.border.normal)
				-- v:SetBeautyBorderColor(0, 0, 0, 1)
			end
		else
			-- v:SetBeautyShadowTexture(config.border.shadow)
			-- v:SetBeautyBorderTexture(config.border.normal)
			-- v:SetBeautyBorderColor(0, 0, 0, 1)
		end
	end
end

local f = CreateFrame("Frame")
frame:SetScript("OnEvent", BorderItemSlots)
frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
