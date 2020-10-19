SortedTooltip = {}

local i = 0

function SortedTooltip.Schedule(func)
    local tooltipDelay = Sorted_GetSetting("tooltipDelay")
    if tooltipDelay == 0 then
        func()
        return
    end
    i = i + 1
    local id = i
    C_Timer.After(tooltipDelay, function()
        if i == id then
            func()
        end
    end)
end

function SortedTooltip.Cancel()
    GameTooltip:Hide()
    if not Sorted_IsClassic() then
        BattlePetTooltip:Hide()
    end
    i = i + 1
end

local function CreateLocalized()
    GameTooltip:SetOwner(SortedTooltip.parent, SortedTooltip.anchor)
    GameTooltip:ClearLines()
    GameTooltip:AddLine(SortedTooltip.text)
    GameTooltip:Show()
end
function SortedTooltip.CreateLocalized(parent, anchor, key, arg1, arg2, arg3)
    SortedTooltip.parent = parent
    SortedTooltip.anchor = anchor
    SortedTooltip.text = Sorted.Localize(key, arg1, arg2, arg3)
    SortedTooltip.Schedule(CreateLocalized)
end