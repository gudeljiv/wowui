local _, xVermin = ...

function AOE(type)
	local type = type or 'bool'
	local inRange = 0

	for i = 1, 40 do
		if UnitExists('nameplate' .. i) and IsSpellInRange('Cleave', 'nameplate' .. i) == 1 and CheckInteractDistance('nameplate' .. i, 3) then
			-- 1 = Inspect, 28 yards
			-- 2 = Trade, 11.11 yards
			-- 3 = Duel, 9.9 yards
			-- 4 = Follow, 28 yards
			-- print("nameplate"..i,CheckInteractDistance("nameplate"..i, 3))
			inRange = inRange + 1
		end
	end
	if type == 'bool' then
		if inRange > 1 then
			return true
		else
			return false
		end
	end
	if type == 'number' then
		return inRange
	end
end

local f = CreateFrame('Frame', 'RotationFrame', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetWidth(5)
f:SetHeight(5)
f:ClearAllPoints()
f:SetPoint('RIGHT', CustomContainer_Combat, 'LEFT', -5, 0)
f:SetFrameStrata('BACKGROUND')
f:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = '',
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)

PlayerFrame:HookScript(
	'OnUpdate',
	function()
		if InCombatLockdown() and not ChatFrame1EditBox:IsVisible() and not IsMounted() then
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

local f = CreateFrame('Frame', 'RotationFrame2', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetWidth(5)
f:SetHeight(5)
f:ClearAllPoints()
f:SetPoint('RIGHT', CustomContainer_Combat, 'LEFT', -15, 0)
f:SetFrameStrata('BACKGROUND')
f:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = '',
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
f:SetBackdropColor(1, 1, 1, 1)

-- TargetFrame:HookScript(
-- 	"OnUpdate",
-- 	function()
-- 		if InCombatLockdown() and not ChatFrame1EditBox:IsVisible() then
-- 			local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")
-- 			-- if name then
-- 			-- 	print(name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId)
-- 			-- end
-- 			-- if name then
-- 			-- 	f:SetBackdropColor(1, 0, 1, 1)
-- 			-- end
-- 		end
-- 	end
-- )

-- ChatFrame1EditBox:HookScript("OnShow", function()
-- 	print("show")
-- end)

-- ChatFrame1EditBox:HookScript("OnHide", function()
-- 	print("hide")
-- end)
