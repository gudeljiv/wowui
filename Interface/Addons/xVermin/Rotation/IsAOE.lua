local _, xVermin = ...

function AOE(type)
	local type = type or "bool"
	local inRange = 0

	for i = 1, 40 do
		if UnitExists("nameplate" .. i) and IsSpellInRange("Cleave", "nameplate" .. i) == 1 then
			inRange = inRange + 1
		end
	end
	if type == "bool" then
		if inRange > 1 then
			return true
		else
			return false
		end
	end
	if type == "number" then
		return inRange
	end
end

local f = CreateFrame("Frame", "RotationFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
f:SetWidth(5)
f:SetHeight(5)
f:ClearAllPoints()
f:SetPoint("RIGHT", CustomContainer_Combat, "LEFT", -5, 0)
f:SetFrameStrata("BACKGROUND")
f:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = "",
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)


PlayerFrame:HookScript(
	"OnUpdate",
	function()
		if InCombatLockdown() then 
			if AOE() then
				f:SetBackdropColor(1, 0, 0, 1)
			else
				f:SetBackdropColor(0, 1, 0, 1)
			end
		else
			f:SetBackdropColor(1, 1, 1, 1)
		end
	end
)
