local _, xVermin = ...

-- local function BehindCheck(self, event, ...)
-- 	-- "You must be behind the target"
-- 	-- print('asd', select(2, ...), select(2, ...):find('behind'))
-- 	if InCombatLockdown() and UnitExists('target') and not UnitIsDeadOrGhost('target') then
-- 		if select(2, ...) and select(2, ...):find('behind') ~= nil then
-- 			RotationFrame1:SetBackdropColor(0, 0, 1, 1)
-- 		end
-- 	end
-- end

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('UI_ERROR_MESSAGE')
-- f:SetScript('OnEvent', BehindCheck)

-- PlayerFrame:HookScript('OnUpdate', BehindCheck)

-- if not behindCheck then
-- 	behindCheck = CreateFrame('Frame')
-- end

-- behindCheck:RegisterEvent('UI_ERROR_MESSAGE')
-- behindCheck:SetScript(
-- 	'OnEvent',
-- 	function(self, event, ...)
-- 		if (select(1, ...):find('behind') ~= nil) then
-- 			return false
-- 		end
-- 	end
-- )
-- behindCheck:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')

-- return true
