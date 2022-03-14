local ActionBars = {'Action', 'MultiBarBottomLeft', 'MultiBarBottomRight', 'MultiBarRight', 'MultiBarLeft'}
local c

local function PrintActions()
	for _, barName in pairs(ActionBars) do
		for i = 1, 12 do
			local button = _G[barName .. 'Button' .. i]
			local slot = ActionButton_GetPagedID(button) or ActionButton_CalculateAction(button) or button:GetAttribute('action') or 0
			if HasAction(slot) then
				local actionName, _
				local actionType, id = GetActionInfo(slot)

				if actionType == 'macro' then
					-- The first return value from GetMacroSpell is the spell name,
					-- so there's no need for an additional call to GetSpellInfo.
					actionName, _, id = GetMacroSpell(id)
				elseif actionType == 'item' then
					actionName = GetItemInfo(id)
				elseif actionType == 'spell' then
					actionName = GetSpellInfo(id)
				end

				if actionName then
					c = GetSpellPowerCost(actionName)
					print(button:GetName(), actionType, (GetSpellLink(id)), actionName, c['mana'])
				end
			end
		end
	end
end
