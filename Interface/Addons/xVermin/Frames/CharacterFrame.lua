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

		itemLink = GetInventoryItemLink("player", GetInventorySlotInfo(v:GetName():gsub("Character", "")))
		if (itemLink) then
			_, _, itemRarity = GetItemInfo(itemLink)
			if (itemRarity and itemRarity > 1) then
				r, g, b = GetItemQualityColor(itemRarity)
				v:SetBeautyBorderTexture(xVerminConfig.border.colorize)
				v:SetBeautyBorderColor(r, g, b, 1)
			else
				v:SetBeautyBorderTexture(xVerminConfig.border.default)
				v:SetBeautyBorderColor(1, 1, 1, 1)
			end
		else
			v:SetBeautyBorderTexture(xVerminConfig.border.default)
			v:SetBeautyBorderColor(1, 1, 1, 1)
		end
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", BorderItemSlots)
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
