----------------------------------------------------------------------------------------------------------------
--FREE SLOTS ---------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

local numberOfFreeSlots, BagType, fs

fbs = CreateFrame("Frame", "CustomContainer_CombatFreeBagSpace", CustomContainer_Combat)
fbs:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
fbs:SetWidth(10)
fbs:SetHeight(10)
fbs.text = fbs:CreateFontString(nil, "ARTWORK")
fbs.text:SetFont(config.font.arial, 8, "NONE")
fbs.text:SetPoint("TOPLEFT", CustomContainer_Combat, "BOTTOMLEFT", 0, -3)

local function CalculateFreeBagSpace()
	for bag = 0, 4 do
		numberOfFreeSlots, BagType = GetContainerNumFreeSlots(bag)
		if (BagType == 0) then
			fs = fs + numberOfFreeSlots
		end
		fbs.text:SetText(fs)
		fbs.text:SetTextColor(0.058, 0.901, 0.466, 1)
	end
end

local f = CreateFrame("frame")
f:SetScript(
	"OnEvent",
	function(self, event)
		fs = 0
		CalculateFreeBagSpace()
	end
)

f:RegisterEvent("BAG_UPDATE")
f:RegisterEvent("BAG_UPDATE_DELAYED")
