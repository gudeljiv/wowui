local _, xVermin = ...

local function BorderItemInspectSlots(counter)
	local itemLink, r, g, b, itemLink

	for i, v in pairs(
		{
			InspectHeadSlot,
			InspectNeckSlot,
			InspectShoulderSlot,
			InspectShirtSlot,
			InspectChestSlot,
			InspectWaistSlot,
			InspectLegsSlot,
			InspectFeetSlot,
			InspectWristSlot,
			InspectHandsSlot,
			InspectFinger0Slot,
			InspectFinger1Slot,
			InspectTrinket0Slot,
			InspectTrinket1Slot,
			InspectBackSlot,
			InspectMainHandSlot,
			InspectSecondaryHandSlot,
			InspectRangedSlot,
			InspectTabardSlot
		}
	) do
		v:CreateBeautyBorder(8)

		itemLink = GetInventoryItemLink("target", i)
		-- print(i, itemLink)
		if (itemLink) then
			_, _, itemRarity = GetItemInfo(itemLink)
			if (itemRarity and itemRarity > 1) then
				r, g, b = GetItemQualityColor(itemRarity)
				v:SetBeautyBorderTexture(xVermin.Config.border.colorize)
				v:SetBeautyBorderColor(r, g, b, 1)
			else
				v:SetBeautyBorderTexture(xVermin.Config.border.default)
				v:SetBeautyBorderColor(1, 1, 1, 1)
			end
		else
			v:SetBeautyBorderTexture(xVermin.Config.border.default)
			v:SetBeautyBorderColor(1, 1, 1, 1)
		end
	end
end

local InspectFrameHooked = false
local addonLoadedFrame = CreateFrame("Frame")
addonLoadedFrame:RegisterEvent("ADDON_LOADED")
addonLoadedFrame:SetScript(
	"OnEvent",
	function(self, event, arg1, ...)
		if not InspectFrameHooked and arg1 == "Blizzard_InspectUI" then
			hooksecurefunc(
				InspectFrame,
				"Show",
				function()
					local counter = 0
					C_Timer.After(
						0.1,
						function()
							BorderItemInspectSlots(counter)
						end
					)
				end
			)
			InspectFrameHooked = true
		end
	end
)
