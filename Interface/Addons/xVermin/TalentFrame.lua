local function SkinTalents()
	for i = 1, 46 do
		local frame = _G["TalentFrameTalent" .. i]
		local frameSlot = _G["TalentFrameTalent" .. i .. "Slot"]
		if (frame ~= nil) then
			frame:CreateBeautyBorder(8)
		end
		if (frameSlot ~= nil) then
			frameSlot:Hide()
		end
	end
end

local pf = CreateFrame("Frame")
pf:RegisterEvent("PLAYER_TALENT_UPDATE")
pf:RegisterEvent("INSPECT_TALENT_READY")
pf:RegisterEvent("PET_TALENT_UPDATE")
pf:RegisterEvent("PET_TALENT_UPDATE")
pf:SetScript("OnEvent", SkinTalents)
