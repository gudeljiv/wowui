-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local _, TSM = ...
local Auctioning = TSM.Tooltip:NewPackage("Auctioning")
local L = TSM.Include("Locale").GetTable()
local ItemString = TSM.Include("Util.ItemString")
local ItemInfo = TSM.Include("Service.ItemInfo")
local private = {}



-- ============================================================================
-- Module Functions
-- ============================================================================

function Auctioning.OnInitialize()
	TSM.Tooltip.Register(TSM.Tooltip.CreateInfo()
		:SetHeadings(L["TSM Auctioning"])
		:SetSettingsModule("Auctioning")
		:AddSettingEntry("postQuantity", false, private.PopulatePostQuantityLine)
		:AddSettingEntry("operationPrices", false, private.PopulatePricesLine)
	)
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.PopulatePostQuantityLine(tooltip, itemString)
	local postCap, stackSize = nil, nil
	if itemString == ItemString.GetPlaceholder() then
		postCap = 5
		stackSize = TSM.IsWowClassic() and 200
	elseif ItemInfo.IsSoulbound(itemString) then
		return
	else
		itemString = TSM.Groups.TranslateItemString(itemString)
		local _, operation = TSM.Operations.GetFirstOperationByItem("Auctioning", itemString)
		if not operation then
			return
		end

		postCap = TSM.Auctioning.Util.GetPrice("postCap", operation, itemString)
		stackSize = TSM.IsWowClassic() and TSM.Auctioning.Util.GetPrice("stackSize", operation, itemString)
	end
	if TSM.IsWowClassic() then
		tooltip:AddTextLine(L["Post Quantity"], postCap and stackSize and postCap.."x"..stackSize or "---")
	else
		tooltip:AddTextLine(L["Post Quantity"], postCap or "---")
	end
end

function private.PopulatePricesLine(tooltip, itemString)
	local minPrice, normalPrice, maxPrice = nil, nil, nil
	if itemString == ItemString.GetPlaceholder() then
		minPrice = 20
		normalPrice = 24
		maxPrice = 29
	elseif ItemInfo.IsSoulbound(itemString) then
		return
	else
		itemString = TSM.Groups.TranslateItemString(itemString)
		local _, operation = TSM.Operations.GetFirstOperationByItem("Auctioning", itemString)
		if not operation then
			return
		end

		minPrice = TSM.Auctioning.Util.GetPrice("minPrice", operation, itemString)
		normalPrice = TSM.Auctioning.Util.GetPrice("normalPrice", operation, itemString)
		maxPrice = TSM.Auctioning.Util.GetPrice("maxPrice", operation, itemString)
	end
	tooltip:AddValueLine(L["Min/Normal/Max Prices"], minPrice, normalPrice, maxPrice)
end
