local _, class = UnitClass("player")
local color = RAID_CLASS_COLORS[class]
if class == "SHAMAN" then
	color = {
		b = 0.86666476726532,
		g = 0.4392147064209,
		r = 0
	}
end

-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) state
-----------------------------------------------------------------------------------------------------------------------------
local cus = CreateFrame("Frame", "CustomContainer_CombatUnitState", CustomContainer_Combat)
cus:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cus:SetWidth(1)
cus:SetHeight(1)
cus.text = cus:CreateFontString(nil, "ARTWORK")
cus.text:SetFont(config.font.arial, 10, "NONE")
cus.text:SetPoint("LEFT", CustomContainer_Combat, "LEFT", 3, 0)

PlayerFrame:HookScript(
	"OnUpdate",
	function()
		cus.text:SetText("")
		if (UnitIsAFK("player")) then
			cus.text:SetText("AFK")
		end
		if (UnitIsDND("player")) then
			cus.text:SetText("DND")
		end
		-- cus.text:SetTextColor(0.058, 0.901, 0.466, 1)
		cus.text:SetTextColor(color.r, color.g, color.b, 1)
	end
)

-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) ammo count
-----------------------------------------------------------------------------------------------------------------------------
local _, class, _ = UnitClass("player")
-- or class == "WARRIOR"
if class == "HUNTER" then
	local ac = CreateFrame("Frame", "CustomContainer_AmmoCount", CustomContainer_Combat)
	ac:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
	ac:SetWidth(1)
	ac:SetHeight(1)
	ac.text = ac:CreateFontString(nil, "ARTWORK")
	ac.text:SetFont(config.font.arial, 10, "NONE")
	ac.text:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 0)

	PlayerFrame:HookScript(
		"OnUpdate",
		function()
			ac.text:SetText("")
			local ammoCount = GetInventoryItemCount("player", GetInventorySlotInfo("AmmoSlot"))
			ac.text:SetText(ammoCount)
			CharacterAmmoSlotCount:Hide()
		end
	)
end

-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) speed
-----------------------------------------------------------------------------------------------------------------------------
local speed
local us = CreateFrame("Frame", "CustomContainer_CombatUnitSpeed", CustomContainer_Combat)
us:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
us:SetWidth(1)
us:SetHeight(1)
us.text = us:CreateFontString(nil, "ARTWORK")
us.text:SetFont(config.font.arial, 10, "NONE")
us.text:SetPoint("BOTTOMRIGHT", CustomContainer_Combat, "TOPRIGHT", -1, 2)

PlayerFrame:HookScript(
	"OnUpdate",
	function()
		speed = string.format("%d", (GetUnitSpeed("Player") / 7) * 100)
		if speed and speed ~= "0" then
			us.text:SetText(speed .. "%")
		else
			us.text:SetText("")
		end
		-- us.text:SetTextColor(0.058, 0.901, 0.466, 1)
		us.text:SetTextColor(color.r, color.g, color.b, 1)
	end
)

-----------------------------------------------------------------------------------------------------------------------------
-- BAGFREE SLOTS
-----------------------------------------------------------------------------------------------------------------------------

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
		-- fbs.text:SetTextColor(0.058, 0.901, 0.466, 1)
		fbs.text:SetTextColor(color.r, color.g, color.b, 1)
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
f:RegisterEvent("PLAYER_ENTERING_WORLD")
