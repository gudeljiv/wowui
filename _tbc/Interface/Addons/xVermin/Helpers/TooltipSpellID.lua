local _, xVermin = ...

local function HandleItem(self, unit, index, filter)
	-- Prevent duplicate spell ID lines
	for i = 1, self:NumLines() do
		if _G["GameTooltipTextLeft" .. i]:GetText():find("Spell ID") then
			return
		end
	end

	local id
	if unit then
		local _, _, _, _, _, _, _, _, _, spellId = UnitAura(unit, index, filter)
		id = spellId
	else
		local _, spellId = self:GetSpell()
		id = spellId
	end

	if id then
		self:AddLine(" ")
		self:AddLine(_G.ORANGE_FONT_COLOR_CODE .. "Spell ID: " .. _G.NORMAL_FONT_COLOR_CODE .. id)
	end
	-- self:Show() REMOVED — this was causing a re-trigger loop
end
hooksecurefunc(GameTooltip, "SetUnitAura", HandleItem)
hooksecurefunc(GameTooltip, "SetUnitBuff", HandleItem)
hooksecurefunc(GameTooltip, "SetUnitDebuff", HandleItem)
GameTooltip:HookScript("OnTooltipSetSpell", HandleItem)
