local _, xVermin = ...

function AOE(type, skill)
	local type = type or 'bool'
	local skill = skill or 'Cleave'
	local inRange = 0

	for i = 1, 40 do
		if UnitExists('nameplate' .. i) and IsSpellInRange(skill, 'nameplate' .. i) == 1 and CheckInteractDistance('nameplate' .. i, 3) then
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

local f = CreateFrame('Frame', 'RotationFrame1', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 15, 0)
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

local buffs = {
	['Feign Dead'] = true
}

-- white -> skip
-- green -> single target
-- red -> aoe
PlayerFrame:HookScript(
	'OnUpdate',
	function()
		haveBuff = false

		for buff in pairs(buffs) do
			for i = 1, 40 do
				local B = UnitBuff('player', i)
				if B and B == buff then
					haveBuff = true
				end
			end
		end

		if IsAltKeyDown() or ChatFrame1EditBox:IsVisible() or IsMounted() or haveBuff then
			f:SetBackdropColor(1, 1, 1, 1) -- white
		else
			if InCombatLockdown() then
				if AOE() then
					f:SetBackdropColor(1, 0, 0, 1) -- red
				else
					f:SetBackdropColor(0, 1, 0, 1) -- green
				end
			else
				f:SetBackdropColor(1, 1, 1, 1) -- white
			end
		end
	end
)

local f = CreateFrame('Frame', 'RotationFrame2', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 25, 0)
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

local f = CreateFrame('Frame', 'RotationFrame3', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetWidth(3)
f:SetHeight(40)
f:ClearAllPoints()
f:SetPoint('LEFT', PlayerFrame, 'RIGHT', 0, 6)
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
f:SetBackdropColor(1, 0, 0, 0.9)

local f = CreateFrame('Frame', 'RotationFrame4', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 35, 0)
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

local f = CreateFrame('Frame', 'RotationFrame5', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 45, 0)
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
f:SetBackdropColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

local f = CreateFrame('Frame', 'RotationFrame6', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 55, 0)
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
