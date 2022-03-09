local ActionBars = {'Action','MultiBarBottomLeft','MultiBarBottomRight','MultiBarRight','MultiBarLeft'}
local c


function PrintActions()
	for _, barName in pairs(ActionBars) do
		for i = 1, 12 do
			local button = _G[barName .. 'Button' .. i]
			local slot = ActionButton_GetPagedID(button) or ActionButton_CalculateAction(button) or button:GetAttribute('action') or 0
			if HasAction(slot) then
				local actionName, _
				local actionType, id = GetActionInfo(slot)
				
				if actionType == 'macro' then
					actionName, _ , id = GetMacroSpell(id)
					-- The first return value from GetMacroSpell is the spell name,
					-- so there's no need for an additional call to GetSpellInfo.
				elseif actionType == 'item' then
					actionName = GetItemInfo(id)
				elseif actionType == 'spell' then
					actionName = GetSpellInfo(id)
				end

				if actionName then
					if(actionType == "spell") then
						c = GetSpellPowerCost(actionName)
						print(button:GetName(), actionType, (GetSpellLink(id)), actionName, id)
					end
				end
			end
		end
	end
end

PrintActions()