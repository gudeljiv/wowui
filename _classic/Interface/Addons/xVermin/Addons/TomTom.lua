local _, xVermin = ...

TomTomCrazyArrow:HookScript(
	'OnUpdate',
	function()
		-- if Questie_BaseFrame and Questie_BaseFrame:IsVisible() then
		-- 	TomTomCrazyArrow:SetPoint('TOPRIGHT', self, 'TOPLEFT', -20, -10)
		-- 	TomTomCrazyArrow:Show()
		-- else
		-- 	TomTomCrazyArrow:SetPoint('TOPRIGHT', CustomContainer_2, 'TOPLEFT', -20, -10)
		-- 	TomTomCrazyArrow:Show()
		-- end

		TomTomCrazyArrow:ClearAllPoints()
		TomTomCrazyArrow:SetPoint('BOTTOM', CustomContainer_Combat, 'TOP', 0, 40)
	end
)


-- xVermin.CheckIfLoadedWithTimer(
-- 	'TradeSkillFrame.SearchBox',
-- 	function()
-- 		print("asd")
-- 		TradeSkillFrame.SearchBox:ClearAllPoints()
-- 		TradeSkillFrame.SearchBox:SetWidth(300)
-- 		TradeSkillFrame.SearchBox:SetPoint("LEFT", TradeSkillRankFrame, "RIGHT", 20, 0)
-- 		TradeSkillFrame.HaveMats:ClearAllPoints()
-- 		TradeSkillFrame.HaveMats:SetPoint("TOPLEFT", TradeSkillFrame.SearchBox, "BOTTOMLEFT", 0,2)
-- 	end
-- )