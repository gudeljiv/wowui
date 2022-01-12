local _, xVermin = ...

local function Skin()
	for i = 1, 20 do
		local frame = _G["MerchantItem" .. i .. "ItemButton"]
		local texture = _G["MerchantItem" .. i .. "SlotTexture"]
		if (frame ~= nil) then
			frame:CreateBeautyBorder(8)
			texture:Hide()
		end
	end
end

local MerchantFrameHooked = false
local addonLoadedFrame = CreateFrame("Frame")
addonLoadedFrame:RegisterEvent("ADDON_LOADED")
addonLoadedFrame:SetScript(
	"OnEvent",
	function(self, event, arg1, ...)
		if not MerchantFrameHooked then
			hooksecurefunc(
				MerchantFrame,
				"Show",
				function()
					Skin()
				end
			)
			MerchantItemFrameHooked = true
		end
	end
)
