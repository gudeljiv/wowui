local _, xVermin = ...

-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) ammo count
-----------------------------------------------------------------------------------------------------------------------------
-- if xVermin.Class == 'HUNTER' then
-- 	local ac = CreateFrame('Frame', 'CustomContainer_AmmoCount', CustomContainer_Combat)
-- 	ac:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, 0)
-- 	ac:SetWidth(1)
-- 	ac:SetHeight(1)
-- 	ac.text = ac:CreateFontString(nil, 'ARTWORK')
-- 	ac.text:SetFont(xVermin.Config.font.arial, 10, 'NONE')
-- 	ac.text:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, 0)
-- 	ac.text:SetText('')

-- 	CharacterAmmoSlotCount:Hide()

-- 	UIParent:HookScript(
-- 		'OnUpdate',
-- 		function()
-- 			local ammoCount = GetInventoryItemCount('player', GetInventorySlotInfo('AmmoSlot'))
-- 			ac.text:SetText(ammoCount)
-- 		end
-- 	)
-- end

-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) reagent count
-----------------------------------------------------------------------------------------------------------------------------
-- if xVermin.Class == 'PALADIN' then
-- 	local rc = CreateFrame('Frame', 'CustomContainer_ReagentCount', CustomContainer_Combat)
-- 	rc:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, 0)
-- 	rc:SetWidth(1)
-- 	rc:SetHeight(1)
-- 	rc.text = rc:CreateFontString(nil, 'ARTWORK')
-- 	rc.text:SetFont(xVermin.Config.font.arial, 10, 'NONE')
-- 	rc.text:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, 0)
-- 	rc.text:SetText('')

-- 	UIParent:HookScript(
-- 		'OnUpdate',
-- 		function()
-- 			local reagentCount = GetItemCount(21177)
-- 			rc.text:SetText(reagentCount)
-- 		end
-- 	)
-- end

-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) speed
-----------------------------------------------------------------------------------------------------------------------------
local speed
local us = CreateFrame('Frame', 'CustomContainer_CombatUnitSpeed', CustomContainer_Combat)
us:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, 0)
us:SetWidth(1)
us:SetHeight(1)
us.text = us:CreateFontString(nil, 'ARTWORK')
us.text:SetFont(xVermin.Config.font.arial, 10, 'NONE')
us.text:SetPoint('BOTTOMRIGHT', CustomContainer_Combat, 'TOPRIGHT', -1, 3)
us.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

local usVisible = false

UIParent:HookScript(
	'OnUpdate',
	function()
		speed = math.floor(GetUnitSpeed('player') / 0.07 + 0.5) -- weird lua rounding
		if speed and speed ~= '0' then
			usVisible = true
			us.text:SetText(speed .. '%')
		else
			usVisible = false
			us.text:SetText('')
		end
	end
)

-----------------------------------------------------------------------------------------------------------------------------
-- BAGFREE SLOTS
-----------------------------------------------------------------------------------------------------------------------------

local numberOfFreeSlots, BagType, fs

fbs = CreateFrame('Frame', 'CustomContainer_CombatFreeBagSpace', CustomContainer_Combat)
fbs:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, 0)
fbs:SetWidth(10)
fbs:SetHeight(10)
fbs.text = fbs:CreateFontString(nil, 'ARTWORK')
fbs.text:SetFont(xVermin.Config.font.arial, 10, 'NONE')
fbs.text:SetPoint('LEFT', CustomContainer_Combat, 'LEFT', 5, 0)

local function CalculateFreeBagSpace()
	for bag = 0, 4 do
		numberOfFreeSlots, BagType = C_Container.GetContainerNumFreeSlots(bag)
		if (BagType == 0) then
			fs = fs + numberOfFreeSlots
		end
		fbs.text:SetText(fs)
		fbs.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
	end
end

local f = CreateFrame('frame')
f:RegisterEvent('BAG_UPDATE')
f:RegisterEvent('BAG_UPDATE_DELAYED')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		fs = 0
		if event == 'PLAYER_ENTERING_WORLD' and (isInitialLogin or isReloadingUi) then
			CalculateFreeBagSpace()
		end
		if event ~= 'PLAYER_ENTERING_WORLD' then
			CalculateFreeBagSpace()
		end
	end
)

-----------------------------------------------------------------------------------------------------------------------------
-- HONOR
-----------------------------------------------------------------------------------------------------------------------------

local hc = CreateFrame('Frame', 'CustomContainer_CombatHonorPointsCount', CustomContainer_Combat)
hc:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, 0)
hc:SetWidth(10)
hc:SetHeight(10)
hc.text = hc:CreateFontString(nil, 'ARTWORK')
hc.text:SetFont(xVermin.Config.font.arial, 10, 'NONE')
hc.text:SetPoint('TOPLEFT', CustomContainer_Combat, 'BOTTOMLEFT', 1, -3)

local jc = CreateFrame('Frame', 'CustomContainer_CombatJusticePointsCount', CustomContainer_Combat)
jc:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, 0)
jc:SetWidth(10)
jc:SetHeight(10)
jc.text = jc:CreateFontString(nil, 'ARTWORK')
jc.text:SetFont(xVermin.Config.font.arial, 10, 'NONE')
jc.text:SetPoint('TOP', CustomContainer_Combat, 'BOTTOM', 0, -3)

local vc = CreateFrame('Frame', 'CustomContainer_CombatValorPointsCount', CustomContainer_Combat)
vc:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, 0)
vc:SetWidth(10)
vc:SetHeight(10)
vc.text = vc:CreateFontString(nil, 'ARTWORK')
vc.text:SetFont(xVermin.Config.font.arial, 10, 'NONE')
vc.text:SetPoint('TOPRIGHT', CustomContainer_Combat, 'BOTTOMRIGHT', -1, -3)

local function GetHonorPoints()
	local name, CurrentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(1901)
	if CurrentAmount > 0 then
		hc.text:SetText(xVermin.FormatNumber(CurrentAmount))
	else
		hc.text:SetText('')
	end
	hc.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
end

local function GetJusticePoints()
	local name, CurrentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(395)
	if CurrentAmount > 0 then
		jc.text:SetText(xVermin.FormatNumber(CurrentAmount))
	else
		jc.text:SetText('')
	end
	jc.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
end

local function GetValorPoints()
	local name, CurrentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(396)
	if CurrentAmount > 0 then
		vc.text:SetText(xVermin.FormatNumber(CurrentAmount))
	else
		vc.text:SetText('')
	end
	vc.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
end

local f = CreateFrame('frame')
f:RegisterEvent('CHAT_MSG_COMBAT_HONOR_GAIN')
f:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		GetHonorPoints()
		GetJusticePoints()
		GetValorPoints()
	end
)


