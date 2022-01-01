-- NAMESPACE / CLASS: AutoRoll
-- OPTIONS: AutoRoll_PCDB

AutoRoll = CreateFrame("Frame")

AutoRoll.COIN_IDS = {
    19698, -- Zulian Coin
    19699, -- Razzashi Coin
    19700, -- Hakkari Coin
    19701, -- Gurubashi Coin
    19702, -- Vilebranch Coin
    19703, -- Witherbark Coin
    19704, -- Sandfury Coin
    19705, -- Skullsplitter Coin
    19706, -- Bloodscalp Coin
}

AutoRoll.BIJOUS_IDS = {
    19707, -- Red Hakkari Bijou
    19708, -- Blue Hakkari Bijou
    19709, -- Yellow Hakkari Bijou
    19710, -- Orange Hakkari Bijou
    19711, -- Green Hakkari Bijou
    19712, -- Purple Hakkari Bijou
    19713, -- Bronze Hakkari Bijou
    19714, -- Silver Hakkari Bijou
    19715, -- Gold Hakkari Bijou
}

AutoRoll.SCARAB_IDS = {
  20858,
  20859,
  20860,
  20861,
  20862,
  20863,
  20864,
  20865,
}

AutoRoll.IDOL_IDS = {
  20866,
  20867,
  20868,
  20869,
  20870,
  20871,
  20872,
  20873,
  20874,
  20875,
  20876,
  20877,
  20878,
  20879,
  20881,
  20882,
}

AutoRoll.ItemSubTypes = {
    -- ARMOR
    "Cloth",
    "Leather",
    "Mail",
    "Plate",
    "Shields",
    "Librams",
    "Idols",
    "Totems",
    "Sigils",

    -- WEAPONS
    "One-Handed Axes",
    "Two-Handed Axes",
    "Bows",
    "Guns",
    "One-Handed Maces",
    "Two-Handed Maces",
    "Polearms",
    "One-Handed Swords",
    "Two-Handed Swords",
    "Staves",
    "Fist Weapons",
    "Daggers",
    "Thrown",
    "Spears",
    "Crossbows",
    "Wands",
    "Fishing Poles",

    -- TRADE GOODS
    "Trade Goods"
}

AutoRoll.ItemRarities = {
    "Poor",
    "Common",
    "Uncommon",
    "Rare",
    "Epic",
    "Legendary"
}

AutoRoll.FilterStrings = {
    "Bijou",
    "Coin",
}

AutoRoll.FilterEndStrings = {
    "Scarab$",
    "Idol$",
}

do -- Private Scope

    local ADDON_NAME = "AutoRoll"

    local defaults = {
        ["rules"] = {},
        ["printRolls"] = false,
        ["enabled"] = true,
        ["filterRolls"] = true,
        ["enableHistory"] = false,
        ["history"] = {},
        ["historySize"] = 50,
        ["debug"] = false,
    }

    -- REGISTER EVENTS
    AutoRoll:RegisterEvent("ADDON_LOADED")
    AutoRoll:RegisterEvent("START_LOOT_ROLL")
    AutoRoll:RegisterEvent("CONFIRM_LOOT_ROLL")
    AutoRoll:RegisterEvent("PLAYER_ENTERING_WORLD")

    AutoRoll:SetScript("OnEvent", function(self, event, arg1, ...)
        AutoRoll:onEvent(self, event, arg1, ...)
    end)

    -- REGISTER ROLL FILTER
    function rollFiler(_, _, message)
        if AutoRoll_PCDB["filterRolls"] and not string.match(message, "won:") then
            for _, str in pairs(AutoRoll.FilterStrings) do
                if string.match(message, str) then return true end
            end
            for _, str in pairs(AutoRoll.FilterEndStrings) do
                if string.match(message, str) then return true end
            end
        end
        return false
    end

    ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", rollFiler)

    -- INITIALIZATION
    function Init()
        LoadOptions()
    end

    function LoadOptions()
        AutoRoll_PCDB = AutoRoll_PCDB or AutoRollUtils:deepcopy(defaults)

        for key,value in pairs(defaults) do
            if (AutoRoll_PCDB[key] == nil) then
                AutoRoll_PCDB[key] = value
            end
        end
    end

    function AutoRoll:onEvent(self, event, ...)
        if event == "ADDON_LOADED" then
            if select(1, ...) == ADDON_NAME then
                Init()
                PrintHelp()
                AutoRoll.RollHistory.Create()
            end
        end

        if AutoRoll_PCDB["enabled"] then
            if event == "START_LOOT_ROLL" then
                EvaluateActiveRolls()
            end

            if event == "PLAYER_ENTERING_WORLD" then
                EvaluateActiveRolls()
            end

            if event == "CONFIRM_LOOT_ROLL" then
                local rollId = select(1, ...)
                local roll = select(2, ...)

                ConfirmLootRoll(rollId, roll)
            end
        end
    end

    function PrintHelp()
        local colorHex = "2979ff"
        print("|cff"..colorHex.."AutoRoll loaded")
        print("-- Use the following commands: ")
        print("--       /ar NEED [item-link]")
        print("--       /ar GREED [item-link]")
        print("--       /ar PASS [item-link]")
        print("--       /ar IGNORE [item-link]")
    end

    function SaveRule(key, rule)
        -- Get Existing
        local rules = AutoRoll_PCDB["rules"]

        -- Make Mutations
        if (type(key) == "number") then
            local itemName, itemLink = GetItemInfo(key)

            if rule == nil then
                print("Removed rule for "..(itemLink or "item:"..key))
                rules[tonumber(key)] = nil
            else
                rules[tonumber(key)] = AutoRollUtils:getRuleValue(rule)
                print("Remembered "..rule:upper().." on "..(itemLink or "item:"..key))
            end
        elseif (type(key) == "string") then
            if rule == nil then
                print("Removed rule for "..key)
                rules[key:lower()] = nil
            else
                rules[key:lower()] = AutoRollUtils:getRuleValue(rule)
                print("Remembered "..rule:upper().." on "..key)
            end
        end

        -- Save
        AutoRoll_PCDB["rules"] = rules
    end

    function EvaluateActiveRolls()
        local rules = AutoRoll_PCDB["rules"]

        for index,RollID in ipairs(GetActiveLootRollIDs()) do
            local itemId = AutoRollUtils:rollID2itemID(RollID)
            local _, _, _, quality, bindOnPickUp, canNeed, canGreed, _ = GetLootRollItemInfo(RollID)
            local itemName, itemLink, itemRarity, _, _, _, itemSubType = GetItemInfo(itemId)

            -- start by checking the exact item ID
            local ruleKey = itemId
            local rule = rules[ruleKey]

            -- In case it's not found, check rule combinations
            if not rule then
                if itemRarity and itemSubType then
                    local rarity = AutoRollUtils:getRarityStringFromInteger(itemRarity)
                    if rarity then
                        ruleKey = rarity.."%+"..itemSubType:lower()
                        rule = rules[ruleKey]
                    end
                end
            end

            -- In case it's not found, check item sub type
            if not rule then
                if itemSubType then
                    ruleKey = itemSubType:lower()
                    rule = rules[ruleKey]
                end
            end

            -- In case it's not found, check item rarity
            if not rule then
                if itemRarity then
                    ruleKey = AutoRollUtils:getRarityStringFromInteger(itemRarity)
                    rule = rules[ruleKey]
                end
            end

            -- Proceed only if we found an established rule
            if rule then
                if rule > -1 then
                    local shouldRoll = (rule == AutoRollUtils.ROLL.NEED and canNeed) or (rule == AutoRollUtils.ROLL.GREED and canGreed) or (rule == AutoRollUtils.ROLL.PASS)

                    if shouldRoll then
                        if AutoRoll_PCDB["printRolls"] then
                            local ruleString = AutoRollUtils:getRuleString(AutoRoll_PCDB["rules"][ruleKey])
                            print("AutoRoll: "..ruleString:upper().." on "..GetLootRollItemLink(RollID))
                        end

                        RollOnLoot(RollID, rule)
                    end
                end
            end

            -- Save loot roll
            local event = {
              itemId = itemId,
              rollId = RollID,
              buttons = {}
            }

            AutoRoll.RollHistory.Add(event)
        end
    end

    function CheckItemType(cmd, rule)
        return SaveIfFound(cmd, rule, "cloth")
        or SaveIfFound(cmd, rule, "leather")
        or SaveIfFound(cmd, rule, "mail")
        or SaveIfFound(cmd, rule, "plate")
        or SaveIfFound(cmd, rule, "shields")
        or SaveIfFound(cmd, rule, "trade goods")
        or SaveIfFound(cmd, rule, "miscellaneous")
    end

    function CheckItemRarity(cmd, rule)
        return SaveIfFound(cmd, rule, "poor")
        or SaveIfFound(cmd, rule, "uncommon")
        or SaveIfFound(cmd, rule, "common")
        or SaveIfFound(cmd, rule, "rare")
        or SaveIfFound(cmd, rule, "epic")
        or SaveIfFound(cmd, rule, "legendary")
    end

    function SaveIfFound(cmd, rule, keyword)
        if string.match(cmd, keyword) then
            AutoRoll.SaveRule(keyword, rule)
            return true
        end
        return false
    end

    function CheckRuleCombinations(cmd, rule)
        for _,itemRarity in ipairs(AutoRoll.ItemRarities) do
            for _,itemType in ipairs(AutoRoll.ItemSubTypes) do
                if CheckRuleCombination(cmd, rule, itemRarity, itemType) then
                    return true
                end
            end
        end
        return false
    end

    function CheckRuleCombination(cmd, rule, itemRarity, itemType)
        local keyword = itemRarity:lower().."%+"..itemType:lower()
        return SaveIfFound(cmd, rule, keyword)
    end

    -- Expose Functions
    AutoRoll.SaveRule = SaveRule
    AutoRoll.CheckItemType = CheckItemType
    AutoRoll.CheckItemRarity = CheckItemRarity
    AutoRoll.CheckRuleCombinations = CheckRuleCombinations

end

return AutoRoll
