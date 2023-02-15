local _, xVermin = ...
local tsd

local HandleItem = function()
	if TRADE_SKILLS_DISPLAYED then
		for tsd = 1, TRADE_SKILLS_DISPLAYED, 1 do
			local numReagents = GetTradeSkillNumReagents(tsd)

			for i = 1, numReagents, 1 do
				local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(tsd, i)
				local reagent = _G['TradeSkillReagent' .. i]
				local name = _G['TradeSkillReagent' .. i .. 'Name']
				local count = _G['TradeSkillReagent' .. i .. 'Count']

				if name and count then
					count:SetText(playerReagentCount .. ' /' .. reagentCount)
					count:SetScale(0.65)
				end
			end
		end
	end
end

local f = CreateFrame('frame')
f:RegisterEvent('TRADE_SKILL_UPDATE')
f:RegisterEvent('TRADE_SKILL_FILTER_UPDATE')
f:RegisterEvent('UNIT_PORTRAIT_UPDATE')
f:RegisterEvent('UPDATE_TRADESKILL_RECAST')
f:SetScript('OnEvent', HandleItem)
