local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, addonName)
    if event == "PLAYER_LOGIN" or addonName == "ItemRack" then
        self:UnregisterEvent("ADDON_LOADED")
        self:UnregisterEvent("PLAYER_LOGIN")

        -- Ensure ItemRack is fully loaded before modifying
        if ItemRack then

            -- Ensure AppendRuneID exists before overriding
            if not ItemRack.AppendRuneID then
                function ItemRack.AppendRuneID(bag, slot)
                    return ""
                end
            end

            -- Disable engraving-related checks
            function ItemRack.AppendRuneID(bag, slot)
                return "" -- Prevents errors by returning an empty string
            end

            -- Ensure GetID exists before attempting to hook
            if type(ItemRack.GetID) == "function" then
                hooksecurefunc(ItemRack, "GetID", function() end)
            end
        end
    end
end)
