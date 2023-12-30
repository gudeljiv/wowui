local _, xVermin = ...
local tsd

local HandleItem = function()
	if TRADE_SKILLS_DISPLAYED then
		for tsd = 1, TRADE_SKILLS_DISPLAYED, 1 do
			local numReagents = GetTradeSkillNumReagents(tsd)

			if numReagents then
				for i = 1, numReagents, 1 do
					local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(tsd, i)
					local reagent = _G['TradeSkillReagent' .. i]
					local name = _G['TradeSkillReagent' .. i .. 'Name']
					local originalCount = _G['TradeSkillReagent' .. i .. 'Count']
					-- print(tsd, reagent:GetName(), numReagents, reagentName, playerReagentCount .. '/' .. reagentCount)

					if originalCount then
						-- originalCount:Hide()
						-- count:SetText(playerReagentCount .. '/' .. reagentCount)
						originalCount:SetScale(0.65)
						originalCount:SetVertexColor(1, 1, 0)

					-- if not reagent.newCount then
					-- 	reagent.newCount = reagent:CreateFontString(nil, 'ARTWORK')
					-- 	reagent.newCount:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
					-- 	reagent.newCount:SetShadowOffset(0, 0)
					-- 	reagent.newCount:SetPoint('TOPLEFT', reagent, 'TOPLEFT', 2, 2)
					-- 	reagent.newCount:SetVertexColor(1, 1, 0)
					-- 	reagent.newCount:SetScale(0.65)
					-- end
					-- reagent.newCount:SetText(playerReagentCount .. '/' .. reagentCount)
					end
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
