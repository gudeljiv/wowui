-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local _, TSM = ...
local GreatDealsSearch = TSM.Shopping:NewPackage("GreatDealsSearch")
local Vararg = TSM.Include("Util.Vararg")
local ItemInfo = TSM.Include("Service.ItemInfo")
local private = {
	filter = nil,
}



-- ============================================================================
-- Module Functions
-- ============================================================================

function GreatDealsSearch.OnEnable()
	local appData = TSMAPI.AppHelper and TSMAPI.AppHelper:FetchData("SHOPPING_SEARCHES")
	if not appData then
		return
	end
	for _, info in pairs(appData) do
		local realmName, data = unpack(info)
		if TSMAPI.AppHelper:IsCurrentRealm(realmName) then
			private.filter = assert(loadstring(data))().greatDeals
			if private.filter == "" then
				break
			end
			-- populate item info cache
			for _, item in Vararg.Iterator(strsplit(";", private.filter)) do
				item = strsplit("/", item)
				ItemInfo.FetchInfo(item)
			end
			break
		end
	end
end

function GreatDealsSearch.GetFilter()
	return private.filter
end
