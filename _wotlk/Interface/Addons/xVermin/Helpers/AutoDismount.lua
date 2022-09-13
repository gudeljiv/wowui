local _, xVermin = ...

local errorMessages = {
	[ERR_ATTACK_MOUNTED] = true,
	[ERR_MOUNT_ALREADYMOUNTED] = true,
	[ERR_NOT_WHILE_MOUNTED] = true,
	[ERR_TAXIPLAYERALREADYMOUNTED] = true,
	[SPELL_FAILED_NOT_MOUNTED] = true
}

local function CheckDismount(self, event, ...)
	if not IsMounted() or not errorMessages[select(2, ...)] then
		return
	end
	Dismount()
	UIErrorsFrame:Clear()
end

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('UI_ERROR_MESSAGE')
-- f:SetScript('OnEvent', CheckDismount)

-- local function BehindCheck(self, event, ...)
-- 	-- "You must be behind the target"
-- 	-- print('asd', select(2, ...), select(2, ...):find('behind'))
-- 	if InCombatLockdown() and UnitExists('target') and not UnitIsDeadOrGhost('target') then
-- 		if select(2, ...) and select(2, ...):find('behind') ~= nil then
-- 			RotationFrame:SetBackdropColor(0, 0, 1, 1)
-- 		end
-- 	end
-- end

-- local f2 = CreateFrame('Frame')
-- f2:RegisterEvent('UI_ERROR_MESSAGE')
-- f2:SetScript('OnEvent', BehindCheck)

-- PlayerFrame:HookScript('OnUpdate', BehindCheck)
