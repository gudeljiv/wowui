-- Waylaid Supplies Tooltip
-- Author: Shala - Wild Growth
-- Displays a tooltip for items that fill Waylaid Shipments

local addonName, addon = ...

-- [itemID] = {rep, filledMoney, questXP, itemLevel, questLevel, repThreshold}
local supplyShipment = {
	[211365] = {300,  600,    80,   10, 9,  "Friendly"},
    [211367] = {450,  1500,   90,   10, 12, "Friendly"},
	[211839] = {500,  1500,   140,  25, 18, "Honored" },
    [211840] = {650,  2000,   180,  25, 22, "Honored" },
    [211841] = {800,  3000,   200,  25, 25, "Honored" },
    [217337] = {700,  20000,  800,  30, 28, "Revered" },
    [217338] = {850,  55000,  1500, 35, 35, "Revered" },
    [217339] = {1000, 120000, 2500, 40, 40, "Revered" },
	[221008] = {950,  38500,  1700, 45, 42, "Exalted" },
	[221009] = {1300, 84500,  2850, 45, 45, "Exalted" },
	[221010] = {1850, 154000, 4650, 45, 50, "Exalted" },
}

local function AddTooltipInfo(tooltip, itemID)
    --print("OnTooltipSetItem called", itemID)
    local shipmentData = supplyShipment[itemID]
    if shipmentData then
        local rep, filledMoney, questXP, itemLevel, questLevel = unpack(shipmentData)
        --print("rep:", rep)
        --print("filledMoney:", filledMoney)
        --print("questXP:", questXP)
        --print("itemLevel:", itemLevel)
        --print("questLevel:", questLevel)
        local supplyFactionID = (UnitFactionGroup("player") == "Horde") and 2587 or 2586
        local _, _, standingID = GetFactionInfoByID(supplyFactionID)

        local threshold
        if standingID < 5 then
            threshold = 9
        elseif standingID == 5 then
            threshold = 18
        elseif standingID < 7 then
            threshold = 28
		elseif standingID < 8 then
            threshold = 41
		elseif standingID == 8 then
            threshold = 999
        end

        local canGainReputation = questLevel >= threshold -- Using threshold instead of reputationNeeded
		--print("questLevel:", questLevel)
        --print("threshold:", threshold)
				
        local factionName
        if UnitFactionGroup("player") == "Alliance" then
            factionName = "Azeroth Commerce Authority"
        elseif UnitFactionGroup("player") == "Horde" then
            factionName = "Durotar Supply and Logistics"
        else
            factionName = "Unknown Faction"
        end

        if UnitRace("player") == "Human" then
            rep = math.ceil(rep * 1.1) -- Diplomacy racial buff, 10% reputation.Apply 10% reputation buff for humans
        end
		local repThreshold = supplyShipment[itemID][6]

 		-- Reputation line insertion
		local playerRep = GetText("FACTION_STANDING_LABEL" .. standingID, true)
		local repLine = "Current standing: " .. "|cFF00FF00" .. playerRep .. "|r"    
		
		--Tooltip text
		if canGainReputation then
            tooltip:AddDoubleLine(" ", " ")
            tooltip:AddLine("Grants reputation with " .. factionName, 0, 1, 0) -- Green color
			tooltip:AddDoubleLine("Reputation cut off: " .. "|cFFFF0000" .. repThreshold .. "|r", repLine)
			tooltip:AddDoubleLine("Rep: " .. rep .. "              Base XP: "..questXP, "Money: "..GetMoneyString(filledMoney))
            tooltip:AddDoubleLine("Quest Level: "..questLevel, "Item Level: "..itemLevel)
            tooltip:Show()
		elseif questLevel <= threshold then
			--print("No shipment data found for itemID:", itemID)
            tooltip:AddDoubleLine(" ", " ")
            tooltip:AddLine("No longer gives reputation with " .. factionName, 1, 0, 0) -- Red color
			tooltip:AddDoubleLine("Reputation cut off: " .. "|cFF00FF00" .. repThreshold .. "|r", repLine)
			tooltip:AddDoubleLine("Rep: " .. rep.. "              Base XP: "..questXP, "Money: "..GetMoneyString(filledMoney))
            tooltip:AddDoubleLine("Quest Level: "..questLevel, "Item Level: "..itemLevel)
            tooltip:Show()
		else
        end
    end
end

local function OnTooltipSetItem(tooltip)
    local itemName, itemLink = tooltip:GetItem()
    if itemLink then
        local itemID = tonumber(string.match(itemLink, "item:(%d+):"))
        if itemID then
            AddTooltipInfo(tooltip, itemID)
        end
    end
end

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" and ... == addonName then
        self:UnregisterEvent("ADDON_LOADED")
        GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
		ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
        print("OnTooltipSetItem registered successfully.")
    end
end)
frame:RegisterEvent("ADDON_LOADED")