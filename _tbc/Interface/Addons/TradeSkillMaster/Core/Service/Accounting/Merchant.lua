-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local _, TSM = ...
local Merchant = TSM.Accounting:NewPackage("Merchant")
local Event = TSM.Include("Util.Event")
local Math = TSM.Include("Util.Math")
local ItemString = TSM.Include("Util.ItemString")
local ItemInfo = TSM.Include("Service.ItemInfo")
local private = {
	repairMoney = 0,
	couldRepair = nil,
	repairCost = 0,
	pendingSales = {
		itemString = {},
		quantity = {},
		copper = {},
		insertTime = {},
	},
}



-- ============================================================================
-- Module Functions
-- ============================================================================

function Merchant.OnInitialize()
	Event.Register("MERCHANT_SHOW", private.SetupRepairCost)
	Event.Register("BAG_UPDATE_DELAYED", private.OnMerchantUpdate)
	Event.Register("UPDATE_INVENTORY_DURABILITY", private.AddRepairCosts)
	Event.Register("MERCHANT_CLOSED", private.OnMerchantClosed)
	hooksecurefunc("UseContainerItem", private.CheckMerchantSale)
	hooksecurefunc("BuyMerchantItem", private.OnMerchantBuy)
	hooksecurefunc("BuybackItem", private.OnMerchantBuyback)
end



-- ============================================================================
-- Repair Cost Tracking
-- ============================================================================

function private.SetupRepairCost()
	private.repairMoney = GetMoney()
	private.couldRepair = CanMerchantRepair()
	-- if merchant can repair set up variables so we can track repairs
	if private.couldRepair then
		private.repairCost = GetRepairAllCost()
	end
end

function private.OnMerchantUpdate()
	-- Could have bought something before or after repair
	private.repairMoney = GetMoney()
	-- log any pending sales
	for i, insertTime in ipairs(private.pendingSales.insertTime) do
		if GetTime() - insertTime < 5 then
			TSM.Accounting.Transactions.InsertVendorSale(private.pendingSales.itemString[i], private.pendingSales.quantity[i], private.pendingSales.copper[i])
		end
	end
	wipe(private.pendingSales.itemString)
	wipe(private.pendingSales.quantity)
	wipe(private.pendingSales.copper)
	wipe(private.pendingSales.insertTime)
end

function private.AddRepairCosts()
	if private.couldRepair and private.repairCost > 0 then
		local cash = GetMoney()
		if private.repairMoney > cash then
			-- this is probably a repair bill
			local cost = private.repairMoney - cash
			TSM.Accounting.Money.InsertRepairBillExpense(cost)
			-- reset money as this might have been a single item repair
			private.repairMoney = cash
			-- reset the repair cost for the next repair
			private.repairCost = GetRepairAllCost()
		end
	end
end

function private.OnMerchantClosed()
	private.couldRepair = nil
	private.repairCost = 0
end


-- ============================================================================
-- Merchant Purchases / Sales Tracking
-- ============================================================================

function private.CheckMerchantSale(bag, slot, onSelf)
	-- check if we are trying to sell something to a vendor
	if (not MerchantFrame:IsShown() and not TSM.UI.VendoringUI.IsVisible()) or onSelf then
		return
	end

	local itemString = ItemString.Get(GetContainerItemLink(bag, slot))
	local _, quantity = GetContainerItemInfo(bag, slot)
	local copper = ItemInfo.GetVendorSell(itemString)
	if not itemString or not quantity or not copper then
		return
	end
	tinsert(private.pendingSales.itemString, itemString)
	tinsert(private.pendingSales.quantity, quantity)
	tinsert(private.pendingSales.copper, copper)
	tinsert(private.pendingSales.insertTime, GetTime())
end

function private.OnMerchantBuy(index, quantity)
	local _, _, price, batchQuantity = GetMerchantItemInfo(index)
	local itemString = ItemString.Get(GetMerchantItemLink(index))
	if not itemString or not price or price <= 0 then
		return
	end
	quantity = quantity or batchQuantity
	local copper = Math.Round(price / batchQuantity)
	TSM.Accounting.Transactions.InsertVendorBuy(itemString, quantity, copper)
end

function private.OnMerchantBuyback(index)
	local _, _, price, quantity = GetBuybackItemInfo(index)
	local itemString = ItemString.Get(GetBuybackItemLink(index))
	if not itemString or not price or price <= 0 then
		return
	end
	local copper = Math.Round(price / quantity)
	TSM.Accounting.Transactions.InsertVendorBuy(itemString, quantity, copper)
end
