local _,s = ...
s.tooltip = {}

-- this takes either an action (S000A) or flyout button and sets GameTooltip for whatever attribClass/attribValue
-- the action/button contains. The calling function should have already GameTooltip:SetOwner()
function s.tooltip:Set(button)

    local attribClass = button:GetAttribute("attribClass")
    local attribValue = button:GetAttribute("attribValue")

    if attribClass=="item" then
        local itemID = tonumber(attribValue:match("item:(%d+)") or "") -- get its numerical itemID
        if itemID then
            s.tooltip:SetByItemID(itemID) -- GameTooltip:SetItemByID() doesn't display a cooldown; so search for location
        end
    elseif attribClass=="spell" or attribClass=="mount" or attribClass=="profession" then
        local spellID = select(7,GetSpellInfo(attribValue))
        if spellID then
            GameTooltip:SetSpellByID(spellID)
            -- if there's a subtext (Heal(Rank 1) or Polymorph(Turtle)), then add that to the tooltip's title
            if s.settings:Get("ShowSubtext") then
                local subtext = GetSpellSubtext(attribValue)
                if subtext and subtext~="" then
                    local name = GetSpellInfo(attribValue)
                    GameTooltipTextLeft1:SetText(format("%s \124cffa0a0a0(%s)\124r",name,subtext))
                end
            end
        end
    elseif attribClass=="toy" then
        local toyID = GetItemInfoInstant(attribValue)
        if toyID then
            GameTooltip:ClearLines()
            GameTooltip:SetToyByItemID(toyID)
        end
    elseif attribClass=="equipslot" and button.menu then -- tooltip of action will get what's actually equipped in the slot
        local slot = tonumber(attribValue:match("/equipslot (%d+) ") or "")
        if slot then
            GameTooltip:SetInventoryItem("player",slot)
        end
    elseif attribClass=="equipslot" then -- tooltip on flyout button will get what's in the button
        local slot,itemID = attribValue:match("/equipslot (%d+) (.+)")
        if itemID then
            s.tooltip:SetByItemID(itemID) -- GameTooltip:SetItemByID() doesn't display a cooldown; so search for location
            -- now show what slot it's going to
            GameTooltip:AddLine("\124cff88bbffSelect to equip to slot \124r"..slot,1,1,1)
        end
    elseif attribClass=="battlepet" then
        local name = attribValue:match("/summonpet (.+)")
        if name then
            GameTooltip:ClearLines()
            GameTooltip:AddLine(name,1,1,1)
        end
    elseif attribClass=="empty" then
        GameTooltip:ClearLines()
        GameTooltip:AddLine("\124cffffffffNo results found\124r")
    end
    GameTooltip:Show()
end

-- GameTooltip:SetItemByID() doesn't include a cooldown. So this will look for the inventory or container item to use a
-- GameTooltip:SetInventoryItem() or GameTooltip:SetBagItem() that does include a cooldown.
-- (This is a tooltip that was verified to be due to a button under the mouse so performance is not a huge conern here;
-- not even using cache since only the equip cache has bag,slot numbers and that's just for equippable items.)
function s.tooltip:SetByItemID(itemID)
    for slot=0,19 do
        if (GetInventoryItemLink("player",slot) or ""):match(itemID) then
            GameTooltip:SetInventoryItem("player",slot)
            return
        end
    end
    for bag=0,4 do
        for slot=1,GetContainerNumSlots(bag) do
            local link = GetContainerItemLink(bag,slot)
            if link and link:match(itemID) then
                GameTooltip:SetBagItem(bag,slot)
                return
            end
        end
    end
    -- we didn't find it, so cooldown doesn't matter
    itemID = type(itemID)=="number" and itemID or tonumber((itemID or ""):match("item:(%d+)") or "")
    if itemID then
        GameTooltip:SetItemByID(itemID)
    end
end
