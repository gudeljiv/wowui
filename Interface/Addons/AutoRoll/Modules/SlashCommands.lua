-- COMMANDS
SLASH_AR1 = '/ar';
SLASH_AR2 = '/autoroll';

SlashCmdList["AR"] = function(msg)
    local cmd = msg:lower()

    local rule = string.match(cmd, "^(%S*)")
    local itemIdString = AutoRollUtils:getItemId(cmd)

    if (rule == "enable") then
        AutoRoll_PCDB["enabled"] = true
        print("AutoRoll Enabled.")
        return
    end

    if (rule == "disable") then
        AutoRoll_PCDB["enabled"] = false
        print("AutoRoll Disabled.")
        return
    end

    if (rule == "need") or (rule == "greed") or (rule == "pass") then
        -- Item Link Rules
        if itemIdString then
            AutoRoll.SaveRule(itemIdString, rule)
            return
        end

        -- Item Rarity + Item Type Rules
        if AutoRoll.CheckRuleCombinations(cmd, rule) then
            return
        end

        -- Item Type Rules
        if AutoRoll.CheckItemType(cmd, rule) then
            return
        end

        -- Item Rarity Rules
        if AutoRoll.CheckItemRarity(cmd, rule) then
            return
        end

        -- Zul'Gurub Coins
        if string.match(cmd, "coins") then
            for index,itemId in ipairs(AutoRoll.COIN_IDS) do
                AutoRoll.SaveRule(itemId, rule)
            end
            return
        end

        -- Zul'Gurub Bijous
        if string.match(cmd, "bijous") then
            for index,itemId in ipairs(AutoRoll.BIJOUS_IDS) do
                AutoRoll.SaveRule(itemId, rule)
            end
            return
        end

        -- Ahn'Qiraj Scarabs
        if string.match(cmd, "scarabs") then
            for index,itemId in ipairs(AutoRoll.SCARAB_IDS) do
                AutoRoll.SaveRule(itemId, rule)
            end
            return
        end

        -- Ahn'Qiraj Idols
        if string.match(cmd, "idols") then
            for index,itemId in ipairs(AutoRoll.IDOL_IDS) do
                AutoRoll.SaveRule(itemId, rule)
            end
            return
        end
    end

    if (rule == "reset") or (rule == "ignore") or (rule == "clear") or (rule == "remove") then
        if itemIdString then
            AutoRoll.SaveRule(itemIdString, nil)
            return
        end

        -- Zul'Gurub Coins
        if string.match(cmd, "coins") then
            for index,itemId in ipairs(AutoRoll.COIN_IDS) do
                AutoRoll.SaveRule(itemId, nil)
            end
            return
        end

        -- Zul'Gurub Bijous
        if string.match(cmd, "bijous") then
            for index,itemId in ipairs(AutoRoll.BIJOUS_IDS) do
                AutoRoll.SaveRule(itemId, nil)
            end
            return
        end

        -- Ahn'Qiraj Scarabs
        if string.match(cmd, "scarabs") then
            for index,itemId in ipairs(AutoRoll.SCARAB_IDS) do
                AutoRoll.SaveRule(itemId, nil)
            end
        end

        -- Ahn'Qiraj Idols
        if string.match(cmd, "idols") then
            for index,itemId in ipairs(AutoRoll.IDOL_IDS) do
                AutoRoll.SaveRule(itemId, nil)
            end
        end

        if string.match(cmd, "all rules") then
            local rules = AutoRoll_PCDB["rules"]

            for itemId,ruleNum in pairs(rules) do
                if itemId then
                    AutoRoll.SaveRule(itemId, nil)
                end
            end

            AutoRoll_PCDB["rules"] = {}
            return
        end
    end

    if cmd == "printing" then
        local willPrint = not AutoRoll_PCDB["printRolls"]

        if willPrint then
            print("AutoRoll - Printing ENABLED")
        else
            print("AutoRoll - Printing DISABLED")
        end

        AutoRoll_PCDB["printRolls"] = willPrint
        return
    end

    if cmd == "debug" then
        local willDebug = not AutoRoll_PCDB["debug"]

        if willDebug then
            print("AutoRoll - Debug ENABLED")
        else
            print("AutoRoll - Debug DISABLED")
        end

        AutoRoll_PCDB["debug"] = willDebug
        AutoRoll.RollHistory.ConfigDebugButton()
        return
    end

    if cmd == "filter rolls" then
        local willFilter = not AutoRoll_PCDB["filterRolls"]

        if willFilter then
            print("AutoRoll - Filtering rolls ENABLED")
        else
            print("AutoRoll - Filtering rolls DISABLED")
        end

        AutoRoll_PCDB["filterRolls"] = willFilter
        return
    end

    if cmd == "rules" then
        print("AutoRoll - Rules")

        local rules = AutoRoll_PCDB["rules"]
        if rules then
            local count = 0

            for itemId,ruleNum in pairs(rules) do
                local _, itemLink = GetItemInfo(itemId)
                local rule = AutoRollUtils:getRuleString(ruleNum)

                if rule then
                    print(rule:upper().." on "..(itemLink or "item:"..itemId))
                end
                count = count + 1
            end

            if count == 0 then
                print("-- You haven't added any rules yet.")
            else
                return
            end
        end

    end

    if cmd == "history" then
        AutoRoll.RollHistory.Show()
    end

    -- No rules matched, print help
    print("AutoRoll - Commands")
    print("-- Adding custom rules:")
    print("--       /ar [need,greed,pass] [item-link]")
    print("--       /ar [need,greed,pass] [item-rarity]+[item-type] e.g. /ar need rare+wrands")
    print("-- Adding predefined rules:")
    print("--       /ar [need,greed,pass] [coins,bijous,scarabs,idols]")
    print("-- List current rules:")
    print("--       /ar rules")
    print("-- Removing rules:")
    print("--       /ar [clear,ignore,remove,reset] [item-link]")
    print("--       /ar [clear,ignore,remove,reset] all rules")
    print("-- Only show the winner of rolls in the chat (toggle):")
    print("--       /ar filter rolls")
    print("-- Know when AutoRoll automates rolls (toggle):")
    print("--       /ar printing")
    print("-- Enabling/Disabling the addon")
    print("--       /ar enable")
    print("--       /ar disable")

end
