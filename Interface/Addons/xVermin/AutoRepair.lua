local _, xVermin = ...

function AutoRepair()
	if (CanMerchantRepair() == true) then
		local repairAllCost, canRepair = GetRepairAllCost()
		if (canRepair == true) then
			if (repairAllCost <= GetMoney()) then
				RepairAllItems(false)
				CahtFrame6:AddMessage("Your items have been repaired for " .. GetCoinText(repairAllCost, ", ") .. ".", 255, 255, 0)
			else
				CahtFrame6:AddMessage("You don't have enough money for repair!", 255, 0, 0)
			end
		end
	end
end

local f = CreateFrame("frame")
f:SetScript("OnEvent", AutoRepair)
f:RegisterEvent("MERCHANT_SHOW")
