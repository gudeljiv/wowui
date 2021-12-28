local _, xVermin = ...

local function SkinTalents()
	for i = 1, 20 do
		local frame = _G["PlayerTalentFrameTalent" .. i]
		local frameSlot = _G["PlayerTalentFrameTalent" .. i .. "Slot"]
		if (frame ~= nil) then
			frame:CreateBeautyBorder(8)
			frameSlot:Hide()
		end
	end
end

local playerTalentFrameHooked = false
local addonLoadedFrame = CreateFrame("Frame")
addonLoadedFrame:RegisterEvent("ADDON_LOADED")
addonLoadedFrame:SetScript(
	"OnEvent",
	function(self, event, arg1, ...)
		if not playerTalentFrameHooked and arg1 == "Blizzard_TalentUI" then
			hooksecurefunc(
				PlayerTalentFrame,
				"Show",
				function()
					SkinTalents()
				end
			)
			-- hooksecurefunc(
			-- 	TalentFrame,
			-- 	"Hide",
			-- 	function()
			-- 		print("Hiding PlayerTalentFrame")
			-- 	end
			-- )
			playerTalentFrameHooked = true
		end
	end
)
