local _, xVermin = ...

local function AutoRepair()
	if (CanMerchantRepair() == true) then
		local repairAllCost, canRepair = GetRepairAllCost()
		if (canRepair == true) then
			if (repairAllCost <= GetMoney()) then
				RepairAllItems(false)
				ChatFrame7:AddMessage('Your items have been repaired for ' .. GetCoinText(repairAllCost, ', ') .. '.', 255, 255, 0)
			else
				ChatFrame7:AddMessage("You don't have enough money for repair!", 255, 0, 0)
			end
		end
	end
end

local f = CreateFrame('frame')
f:SetScript('OnEvent', AutoRepair)
f:RegisterEvent('MERCHANT_SHOW')
