local _, xVermin = ...

-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) ammo count
-----------------------------------------------------------------------------------------------------------------------------
if xVermin.Class == 'HUNTER' then
	local ac = CreateFrame('Frame', 'CustomContainer_AmmoCount', CustomContainer_Combat)
	ac:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, 0)
	ac:SetWidth(1)
	ac:SetHeight(1)
	ac.text = ac:CreateFontString(nil, 'ARTWORK')
	ac.text:SetFont(xVermin.Config.font.arial, 10, 'NONE')
	ac.text:SetPoint('CENTER', CustomContainer_Combat, 'CENTER', 0, -1)

	PlayerFrame:HookScript(
		'OnUpdate',
		function()
			ac.text:SetText('')
			local ammoCount = GetInventoryItemCount('player', GetInventorySlotInfo('AmmoSlot'))
			ac.text:SetText(ammoCount)
			CharacterAmmoSlotCount:Hide()
		end
	)
end

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

PlayerFrame:HookScript(
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
fbs.text:SetPoint('LEFT', CustomContainer_Combat, 'LEFT', 5, -1)

local function CalculateFreeBagSpace()
	for bag = 0, 4 do
		numberOfFreeSlots, BagType = GetContainerNumFreeSlots(bag)
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
