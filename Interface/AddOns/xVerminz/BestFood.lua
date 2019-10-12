local CONSUMABLES = {
    ["FOOD"] = {
        { 4536, 117, 787, 6290, 4604, 2681, 2070, 2679, 7097, 4540, 4656, 961, 5057, 16166, 19223, 17344 }, -- 61 hps
        { 12238, 4592, 5095, 1326, 6890, 4537, 2287, 4605, 414, 4541, 5066, 17119, 6316, 16167, 19304, 18633 }, -- 243 hps
        { 4593, 3770, 4606, 7228, 733, 4538, 5478, 422, 5526, 4542, 2685, 16170, 19305, 1119 }, -- 552 hps
        { 3771, 8364, 4544, 4594, 4539, 4607, 1707, 18632, 6807, 16169, 8543, 17407, 19224 }, -- 874.8 hps
        { 6887, 3927, 4599, 16766, 13546, 13930, 4608, 4602, 21552, 4601, 9681, 21030, 19306, 17408, 16168, 18635 }, -- 1392 hps
        { 8952, 8950, 8932, 8957, 13935, 8948, 13933, 8953, 21031, 11444, 21033, 23160, 19225, 22324, 11415, 16171, 12763 }, -- 2148 hps
        { 5349, 1113, 1114, 1487, 8075, 8076, 22895 }, -- conjured
        { 19994 }
    },
    ["BUFF"] = {
        { 2888, 5472, 6888, 2680, 12224, 17197, 17198, 11584, 5474, 7806, 7807, 7808, 17199 }, -- 2 stam/spi
        { 2684, 5525, 2683, 2687, 3220, 5477, 724, 3662, 5476 }, -- 4 stam/spi
        { 5527, 3665, 1017, 1082, 3666, 3726, 3664, 5480, 12209, 3663, 3727 }, -- 6 stam/spi
        { 4457, 3729, 13851, 12213, 12214, 12210, 3728, 12212, 20074, 6038, 12211 }, -- 8 stam/spi
        { 12218, 16971, 17222, 18045, 12216, 12215 } -- 12 stam/spi
    },
    ["DRINK"] = {
        { 159 }, -- 151.2 mps
        { 1179, 17404 }, -- 436.8 mps
        { 1205, 9451, 19299 }, -- 835.2 mps
        { 1708, 10841 }, -- 1344.6 mps
        { 19300, 1645 }, -- 1992 mps
        { 8766 }, -- 2934 mps
        { 18300 }, -- 4200 mps
        { 5350, 2288, 2136, 3772, 8077, 8078, 8079 } -- conjured
    },
    ["HEALINGPOTIONS"] = {
        { 118 },
        { 4596, 858 },
        { 929 },
        { 1710 },
        { 3928, 18839 },
        { 13446 },
    }
}

local function Classify (id)
    for consumableType, consumableLists in pairs(CONSUMABLES) do
        for rank, consumables in ipairs(consumableLists) do
            for subrank, consumableID in ipairs(consumables) do
                if id == consumableID then
                    if (consumableType == "FOOD" and rank == 8) or (consumableType == "DRINKS" and rank == 8) then
                        return consumableType, rank + subrank
                    else
                        return consumableType, rank
                    end
                end
            end
        end
    end
    return nil, nil
end

local function CreateOrUpdateMacro(macroName, nomodID, modID)
    local macrotext = nil
    
    if macroName == "Food" then macrotext = string.format("#showtooltip\n/use [mod:alt] item:%d; item:%d", modID, nomodID) end
    if macroName == "FeedPet" then macrotext = string.format("#showtooltip\n/cast Feed Pet\n/use item:%d", nomodID) end
    if macroName == "Drink" then macrotext = string.format("#showtooltip\n/use item:%d", nomodID) end
    if macroName == "HP" then macrotext = string.format("#showtooltip\n/use item:%d", nomodID) end

    local macroID = GetMacroIndexByName(macroName)
    if macroID == 0 then
        CreateMacro(macroName, "Inv_misc_questionmark", macrotext, nil, nil)
    else
        EditMacro(macroID, macroName, "Inv_misc_questionmark", macrotext, nil, nil)
    end
end

local function UpdateMacros()
    local best = {
        ["FOOD"] = {},
        ["BUFF"] = {},
        ["DRINK"] = {},
        ["HEALINGPOTIONS"] = {},
    }
    local playerlevel = UnitLevel("player")
    for bag = 0,4 do
        for slot = 1,GetContainerNumSlots(bag) do
            local id = GetContainerItemID(bag, slot)
            local type, rank = Classify(id)
            if type ~= nil then
                local itemcount = GetItemCount(id)
                local itemlevel = select(5, GetItemInfo(id))
                if 
                (
                    itemlevel and 
                    playerlevel >= itemlevel and 
                    (
                        best[type][1] == nil or 
                        rank > best[type][2] or 
                        (
                            rank == best[type][2] and 
                            itemcount < best[type][3]
                        )
                    )
                ) then
                    best[type] = {id, rank, itemcount}
                end
            end
        end
    end

    -- print("-----------------------")
    -- print(best["FOOD"][0])
    -- print(best["FOOD"][1])
    -- print(best["FOOD"][2])
    -- print(best["FOOD"][3])
    -- print(best["FOOD"][4])
    -- print(best["FOOD"][5])
    -- print(best["FOOD"][6])
    -- print(best["FOOD"][7])
    -- print("-----------------------")

    CreateOrUpdateMacro("Food", best["FOOD"][1], best["BUFF"][1])
    CreateOrUpdateMacro("FeedPet", best["FOOD"][1], best["BUFF"][1])
    CreateOrUpdateMacro("Drink", best["DRINK"][1])
    CreateOrUpdateMacro("HP", best["HEALINGPOTIONS"][1])
end

local function EventHandler(self, event, ...)
    if event == "BAG_UPDATE_DELAYED" or event == "PLAYER_LEVEL_UP" then
        if InCombatLockdown() then 
            NeedsFoodBadly.dirty = true
        else
            UpdateMacros()
        end
    elseif event == "PLAYER_REGEN_ENABLED" and NeedsFoodBadly.dirty then
        UpdateMacros()
        NeedsFoodBadly.dirty = false
    end
end

NeedsFoodBadly = CreateFrame("frame")
NeedsFoodBadly:RegisterEvent("BAG_UPDATE")
NeedsFoodBadly:RegisterEvent("BAG_UPDATE_DELAYED")
NeedsFoodBadly:RegisterEvent("PLAYER_REGEN_ENABLED")
NeedsFoodBadly:RegisterEvent("PLAYER_LEVEL_UP")

NeedsFoodBadly.dirty = false
NeedsFoodBadly:SetScript("OnEvent", EventHandler)
