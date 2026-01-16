local _, Addon = ...
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets
local Colors = Addon.Colors

--------------------------------------------
-- SET CUSTOM TOOLTIP
--------------------------------------------

function UI:SetCustomTooltip(FrameName, Title, Text)
    local Frame = UI:GetFrame(FrameName)

    local function Set()
        GameTooltip:SetOwner(Frame, "ANCHOR_TOP")
        GameTooltip:ClearLines()

        if (Title and strlen(Title) > 0) then
            GameTooltip:AddLine(Functions:PrintColor(Title, Colors.orange))
        end

        if (Text and not Functions:IsEmptyTable(Text)) then
            for Key, Line in next, Text, nil do
                GameTooltip:AddLine(Functions:PrintColor(Line, Colors.white))
            end
        end

        GameTooltip:Show()
    end

    UI:HookScript("OnEnter", FrameName, function(Self) Set() end)
    UI:HookScript("OnLeave", FrameName, function(Self) GameTooltip:Hide() end)
end

--------------------------------------------
-- SET TOOLTIP FOR ITEM
--------------------------------------------

function UI:SetItemTooltip(FrameName, ItemID, Hook)
    local Frame = UI:GetFrame(FrameName)

    local function Set()
        GameTooltip:SetOwner(Frame, "ANCHOR_CURSOR")
        GameTooltip:ClearLines()
        GameTooltip:SetItemByID(ItemID)
        GameTooltip:Show()
    end

    UI:HookScript("OnEnter", FrameName, function(Self) Set() end)
    UI:HookScript("OnLeave", FrameName, function(Self) GameTooltip:Hide() end)
end

function UI:UnsetTooltip(FrameName, Hook)
    local Frame = UI:GetFrame(FrameName)
    
    UI:HookScript("OnEnter", FrameName, function(Self) GameTooltip:ClearLines() end)
end
