-------------------------------------------
-- Making characterslots nicely bordered
-------------------------------------------
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
	itemLink = GetInventoryItemLink("player", GetInventorySlotInfo(v:GetName():gsub("Character", "")))
	v:CreateBeautyBorder(8)
	if (itemLink) then
		_, _, itemRarity = GetItemInfo(itemLink)
		r, g, b = GetItemQualityColor(itemRarity)
		v:SetBeautyBorderTexture(config.border.neutral)
		v:SetBeautyBorderColor(r, g, b)
	end
end
