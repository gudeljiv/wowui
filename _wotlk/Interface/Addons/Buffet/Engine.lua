local _, ns = ...

-- Imports
local Utility = ns.Utility
local Locales = ns.Locales

-- Local namespace
local Engine = ns.Engine or {}
local ActiveConst = ns.ActiveConst

local string_gsub = string.gsub
local string_match = string.match
local string_lower = string.lower

if not Engine.ScanTooltip then
    function Engine.ScanTooltip(itemLink)
        local texts = {}
        local tooltip = Utility.GetTooltip()
        tooltip:SetHyperlink(itemLink)

        local lineCount = 0
        for i = 2, tooltip:NumLines() do
            local text = _G["buffetTooltipTextLeft" .. i]:GetText() or ""
            text = Utility.Trim(text)
            if text ~= "" then
                texts[lineCount] = text
                lineCount = lineCount + 1
            end
        end
        tooltip:Hide()

        return texts
    end
end

function Engine.ParseTexts(texts, itemData)
    local itemDescription = ""
    local usable = false

    for i, v in pairs(texts) do
        local text = string_lower(v);

        -- Food and Drink
        if Locales.KeyWords.FoodAndDrink then
            if not itemData.isFoodAndDrink and Utility.StringContains(text, Locales.KeyWords.FoodAndDrink:lower()) then
                itemData.isFoodAndDrink = true
            end
        end

        -- Conjured item
        if not itemData.isConjured then
            if type(Locales.KeyWords.ConjuredItem) == "table" then
                for _, s in pairs(Locales.KeyWords.ConjuredItem) do
                    if Utility.StringContains(text, s:lower()) then
                        itemData.isConjured = true
                        break
                    end
                end
            elseif type(Locales.KeyWords.ConjuredItem) == "string" then
                if Utility.StringContains(text, Locales.KeyWords.ConjuredItem:lower()) then
                    itemData.isConjured = true
                end
            end
        end

        -- Bandage
        if not itemData.isBandage and Engine.CheckBandage(text, itemData.itemClassId, itemData.itemSubClassId) then
            itemData.isBandage = true
        end

        -- Potion
        if not itemData.isPotion and Engine.CheckPotion(text, itemData.itemClassId, itemData.itemSubClassId) then
            itemData.isPotion = true
        end

        -- Toxic potion
        if Locales.KeyWords.ToxicPotion then
            if not itemData.isToxicPotion and Utility.StringContains(text, Locales.KeyWords.ToxicPotion:lower()) then
                itemData.isToxicPotion = true
            end
        end

        -- well fed
        if not itemData.isWellFed then
            if type(Locales.KeyWords.WellFed) == "table" then
                for _, s in pairs(Locales.KeyWords.WellFed) do
                    if Utility.StringContains(text, s:lower()) then
                        itemData.isWellFed = true
                        break
                    end
                end
            elseif type(Locales.KeyWords.WellFed) == "string" then
                if Utility.StringContains(text, Locales.KeyWords.WellFed:lower()) then
                    itemData.isWellFed = true
                end
            end
        end

        -- OverTime
        if not itemData.isOverTime and Utility.StringContains(text, Locales.KeyWords.OverTime:lower()) then
            itemData.isOverTime = true
        end

        -- Usable item
        if not usable  and Engine.CheckUsable(text) then
            usable = true
        end

        -- if usable, we should be on the line with health/mana value
        if usable and itemDescription == "" then
            itemDescription = text
        end
    end

    if usable and itemDescription ~= "" then
        -- health
        itemData.isHealth = Engine.CheckHealth(itemDescription, itemData.isBandage)
        -- mana
        if Utility.StringContains(itemDescription, Locales.KeyWords.Mana:lower()) then
            itemData.isMana = true
        end

        if itemData.isHealth or itemData.isMana then
            -- FU Blizzard
            itemDescription = Engine.ReplaceFakeSpace(itemDescription)
            -- Utility.Debug("desc: ", itemDescription)

            -- parse for health and/or mana
            itemData = Engine.ParseValues(itemData, itemDescription)
        end
    end

    itemData = Engine.PostParseUpdate(itemData)

    itemData = Engine.CheckStaticData(itemData)

    return itemData
end

function Engine.GetPvpStatus()
    -- all off by default
    local inBg, inRatedBg, inArena, inRatedArena, inBrawl = false, false, false, false, false

    if Utility.IsClassic then
        local r = UnitInBattleground("player")
        inBg = (r ~= nil)
    end

    if Utility.IsTBC then
        local r = UnitInBattleground("player")
        inBg = (r ~= nil)
        inArena, inRatedArena = IsActiveBattlefieldArena()
    end

    if Utility.IsWLK then
        local r = UnitInBattleground("player")
        inBg = (r ~= nil)
        inArena, inRatedArena = IsActiveBattlefieldArena()
    end

    if Utility.IsCataclysm then
        local r = UnitInBattleground("player")
        inBg = (r ~= nil)
        inArena, inRatedArena = IsActiveBattlefieldArena()
    end

    if Utility.IsRetail then
        inBg = C_PvP.IsBattleground() -- since version 8.2.0
        inRatedBg = C_PvP.IsRatedBattleground() -- since version 8.2.0
        inArena = C_PvP.IsArena() -- since version 8.2.0
        inRatedArena = C_PvP.IsRatedArena() -- since version 8.2.0
        inBrawl = C_PvP.IsInBrawl() -- since version 7.2.0
    end

    return inBg, inRatedBg, inArena, inRatedArena, inBrawl
end

function Engine.CheckRestrictionEntry(entry)
    local matchMode = entry.matchMode or "any"
    local conditions = 0
    local matches = 0

    if entry.inInstanceIds ~= nil then
        conditions = conditions + 1
        if Utility.IsPlayerInInstanceId(entry.inInstanceIds) then
            matches = matches + 1
        end
    end
    if entry.inMapIds ~= nil then
        conditions = conditions + 1
        if Utility.IsPlayerInMapId(entry.inMapIds) then
            matches = matches + 1
        end
    end
    if entry.inInstanceTypes ~= nil then
        conditions = conditions + 1
        if Utility.IsPlayerInInstanceType(entry.inInstanceTypes) then
            matches = matches + 1
        end
    end
    if entry.inSubZones ~= nil then
        conditions = conditions + 1
        if Utility.IsPlayerInSubZoneName(entry.inSubZones) then
            matches = matches + 1
        end
    end

    if entry.pvp ~= nil then
        local inBg, inRatedBg, inArena, inRatedArena, inBrawl = Engine.GetPvpStatus()

        if entry.pvp.bg ~= nil then
            conditions = conditions + 1
            if entry.pvp.bg == true and inBg then
                matches = matches + 1
            end
        end

        if entry.pvp.arena ~= nil then
            conditions = conditions + 1
            if entry.pvp.arena == true and inArena then
                matches = matches + 1
            end
        end

        if entry.pvp.brawl ~= nil then
            conditions = conditions + 1
            if entry.pvp.brawl == true and inBrawl then
                matches = matches + 1
            end
        end

        if entry.pvp.ratedBg ~= nil then
            conditions = conditions + 1
            if entry.pvp.ratedBg == true and inRatedBg then
                matches = matches + 1
            end
        end

        if entry.pvp.ratedArena ~= nil then
            conditions = conditions + 1
            if entry.pvp.ratedArena == true and inRatedArena then
                matches = matches + 1
            end
        end
    end

    if matchMode == "none" then
        return matches == 0
    end
    if matchMode == "one" then
        return matches == 1
    end
    if matchMode == "any" then
        return matches >= 1
    end
    if matchMode == "all" then
        return matches == conditions
    end

    -- allow for exact matches
    if type(matchMode) == "number" then
        return matches == matchMode
    end

    return false
end

function Engine.CheckStaticData(itemData)
    if ActiveConst.StaticItemData then
        if ActiveConst.StaticItemData[itemData.itemId] ~= nil then
            local staticData = ActiveConst.StaticItemData[itemData.itemId]
            if staticData.isHealth ~= nil then
                itemData.isHealth = staticData.isHealth
            end
            if staticData.isMana ~= nil then
                itemData.isMana = staticData.isMana
            end
            if staticData.isFoodAndDrink ~= nil then
                itemData.isFoodAndDrink = staticData.isFoodAndDrink
            end
            if staticData.isPotion ~= nil then
                itemData.isPotion = staticData.isPotion
            end
            if staticData.isBandage ~= nil then
                itemData.isBandage = staticData.isBandage
            end
            if staticData.modifiers ~= nil then
                for _, entry in pairs(staticData.modifiers) do
                    conditionValid = true
                    if entry.conditions then
                        for _, condition in pairs(entry.conditions) do
                            if condition.profession then
                                if not Utility.TableContainsValue(Utility.skillLineIds, condition.profession) then
                                    conditionValid = false
                                    break
                                end
                            end
                        end
                    end
                    if conditionValid then
                        if itemData.isHealth and entry.healthFactor then
                            itemData.health = itemData.health * entry.healthFactor
                        end
                        if itemData.isMana and entry.manaFactor then
                            itemData.mana = itemData.mana * entry.manaFactor
                        end
                    end
                end
            end
        end
    end
    return itemData
end

-- return true if the item is restricted, false otherwise
function Engine.CheckRestriction(itemId)
    -- check restricted items against rules
    if ActiveConst.Restrictions[itemId] ~= nil then
        for _, entry in pairs(ActiveConst.Restrictions[itemId]) do
            local valid = Engine.CheckRestrictionEntry(entry)
            if valid then
                return false, true -- if one entry is valid, item is not currently restricted
            end
        end
        return true, true -- no valid entry
    end
    return false, false -- no entry
end

function Engine.ExtractValue(value, indexes)
    if indexes then
        if type(indexes) == "table" then
            local value1 = Engine.StripThousandSeparator(value[indexes[1]])
            local value2 = Engine.StripThousandSeparator(value[indexes[2]])
            return (tonumber(value1) + tonumber(value2)) / 2
        elseif type(indexes) == "number" then
            local value = Engine.StripThousandSeparator(value[indexes])
            return tonumber(value)
        end
    end
    return 0
end

function Engine.LoopPattern(itemData, itemDescription, patterns)
    for k, v in ipairs(patterns) do
        local value = Engine.Match(itemDescription, v.pattern)
        if value and (#value > 0) then
            if v.healthIndex then
                itemData.health = Engine.ExtractValue(value, v.healthIndex)
                if v.pct then
                    itemData.health = itemData.health / 100
                end
            end
            if v.manaIndex then
                itemData.mana = Engine.ExtractValue(value, v.manaIndex)
                if v.pct then
                    itemData.mana = itemData.mana / 100
                end
            end
            itemData.isPct = v.pct
            break
        end
    end
    return itemData
end

function Engine.ParseValues(itemData, itemDescription)
    if itemData.isHealth and itemData.isMana then
        if Utility.StringContains(itemDescription, Locales.KeyWords.Restores:lower()) then
            -- loop on mixed Health+Mana pattern here
            itemData = Engine.LoopPattern(itemData, itemDescription, Locales.Patterns.HealthAndMana)
            if itemData.isOverTime and itemData.health and (itemData.health > 0) and itemData.mana and (itemData.mana > 0) then
                local overTime = string_match(itemDescription, Locales.Patterns.OverTime)
                if overTime then
                    itemData.isOverTime = true
                    itemData.overTime = tonumber(overTime)
                end
            end
        end
    else
        if itemData.isHealth then
            if itemData.isBandage then
                if Utility.StringContains(itemDescription, Locales.KeyWords.Heals:lower()) then
                    -- loop on Bandage pattern here
                    itemData = Engine.LoopPattern(itemData, itemDescription, Locales.Patterns.Bandage)
                end
            else
                if Utility.StringContains(itemDescription, Locales.KeyWords.Restores:lower()) then
                    -- loop on Health pattern here
                    itemData = Engine.LoopPattern(itemData, itemDescription, Locales.Patterns.Health)
                    if itemData.health and (itemData.health > 0) and itemData.isOverTime then
                        local overTime = string_match(itemDescription, Locales.Patterns.OverTime)
                        if overTime then
                            itemData.isOverTime = true
                            itemData.overTime = tonumber(overTime)
                        end
                    end
                elseif Locales.KeyWords.Consume ~= nil and Utility.StringContains(itemDescription, Locales.KeyWords.Consume:lower()) then
                    -- loop on Health pattern here
                    itemData = Engine.LoopPattern(itemData, itemDescription, Locales.Patterns.Health)
                    if itemData.health and (itemData.health > 0) and itemData.isOverTime then
                        local overTime = string_match(itemDescription, Locales.Patterns.OverTime)
                        if overTime then
                            itemData.isOverTime = true
                            itemData.overTime = tonumber(overTime)
                        end
                    end
                end
            end
        end
        if itemData.isMana then
            if Utility.StringContains(itemDescription, Locales.KeyWords.Restores:lower()) then
                -- loop on Mana pattern here
                itemData = Engine.LoopPattern(itemData, itemDescription, Locales.Patterns.Mana)
                if itemData.mana and (itemData.mana > 0) and itemData.isOverTime then
                    local overTime = string_match(itemDescription, Locales.Patterns.OverTime)
                    if overTime then
                        itemData.isOverTime = true
                        itemData.overTime = tonumber(overTime)
                    end
                end
            end
        end
    end
    return itemData
end

function Engine.Match(text, pattern)
    local p = {string_match(text, pattern)}
    return p
end

function Engine.ReplaceFakeSpace(text)
    local t = string_gsub(text, " ", " ") -- WTF Blizzard !
    return t
end

function Engine.StripThousandSeparator(text)
    if type(Locales.ThousandSeparator) == "string" then
        text = string_gsub(text, Locales.ThousandSeparator, "")
    elseif type(Locales.ThousandSeparator) == "table" then
        for i, v in ipairs(Locales.ThousandSeparator) do
            text = string_gsub(text, v, "")
        end
    end
    return text
end

ns.Engine = Engine
