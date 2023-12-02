-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_AppHelper                           --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

local _, TSM = ...



function TSM.LoadData(tag, realmOrRegion, data)
	if not TSM_APPHELPER_LOAD_DATA then return end
	TSM_APPHELPER_LOAD_DATA(tag, realmOrRegion, data)
end
