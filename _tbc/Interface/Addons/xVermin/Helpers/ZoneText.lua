local _, xVermin = ...

local zoneOrigSizes = {}
local zoneOrigWidths = {}
for _, f in ipairs({ ZoneTextString, PVPInfoTextString, SubZoneTextString, PVPArenaTextString }) do
	local _, size = f:GetFont()
	zoneOrigSizes[f] = size
	zoneOrigWidths[f] = f:GetWidth()
end

local zoneFrame = CreateFrame("Frame")
zoneFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
zoneFrame:RegisterEvent("ZONE_CHANGED")
zoneFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
zoneFrame:SetScript("OnEvent", function()
	local font = xVermin.Config.font.coalition
	for _, f in ipairs({ ZoneTextString, PVPInfoTextString }) do
		f:SetFont(font, zoneOrigSizes[f] * 1.6, "OUTLINE")
		f:SetShadowColor(0, 0, 0, 1)
		f:SetShadowOffset(1, -1)
		f:SetWidth(zoneOrigWidths[f] * 1.5)
	end
	for _, f in ipairs({ SubZoneTextString, PVPArenaTextString }) do
		f:SetFont(font, zoneOrigSizes[f] * 1.2, "OUTLINE")
		f:SetShadowColor(0, 0, 0, 1)
		f:SetShadowOffset(1, -1)
		f:SetWidth(zoneOrigWidths[f] * 1.5)
	end
end)
