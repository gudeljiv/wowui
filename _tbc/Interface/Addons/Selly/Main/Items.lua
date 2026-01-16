local _, Addon = ...
local Core = Addon.Core
local Items = Addon.Items
local Functions = Addon.Functions
local ProfileManager = Addon.ProfileManager
local UI = Addon.UI
local Assets = Addon.Assets
local Colors = Addon.Colors
local Events = Addon.Events2

----------------------------------------------------------------------------------------
-- ITEMS
----------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------
-- HELPER
----------------------------------------------------------------------------------------

function Items:GetItemNameByLink(ItemLink)
    local ItemString = string.match(ItemLink, "item[%-?%d:]+")
    if (not ItemString) then return "" end

	local _, ItemName = strsplit(":", ItemString)
    return Functions:Condition(ItemName, ItemName, "")
end

function Items:GetItemIDByLink(ItemLink)
    local ItemID = C_Item.GetItemInfoInstant(ItemLink)
    if (ItemID) then
        return ItemID
    end

    local ItemID = string.match(ItemLink, "item:(%d+)")
    return Functions:Condition(ItemID, tonumber(ItemID), 0)
end

function Items:GetItemID(ItemNameOrIDOrLink)
    if (not ItemNameOrIDOrLink) then return 0 end

    if (Functions:StartsWith(ItemNameOrIDOrLink, "|")) then
        ItemID = Items:GetItemIDByLink(ItemNameOrIDOrLink)
        if (ItemID > 0) then
            return ItemID
        end
    else
        local ItemID = C_Item.GetItemInfoInstant(ItemNameOrIDOrLink)
        if (ItemID) then
            return ItemID
        end
    end

    local ItemName, ItemLink = C_Item.GetItemInfo(ItemNameOrIDOrLink)
    if (ItemLink) then
        ItemID = string.match(ItemLink, "item:(%d+)")
        if (ItemID) then
            return tonumber(ItemID)
        end
    end

    return 0
end
