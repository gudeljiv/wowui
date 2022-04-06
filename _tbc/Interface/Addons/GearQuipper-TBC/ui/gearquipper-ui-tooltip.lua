-- scope stuff
gearquipper = gearquipper or {};
local c = gearquipper;

-- todo: tooltip option

local ITEMSTATS_EXCLUDE = {"ITEM_MOD_INTELLECT_SHORT", "ITEM_MOD_STRENGTH_SHORT", "ITEM_MOD_AGILITY_SHORT",
                           "ITEM_MOD_STAMINA_SHORT", "ITEM_MOD_INTELLECT_SHORT", "ITEM_MOD_SPIRIT_SHORT"};

local ITEMSTATS_FIX = {"ITEM_MOD_SPELL_DAMAGE_DONE_SHORT", "ITEM_MOD_SPELL_POWER_SHORT",
                       "ITEM_MOD_SPELL_HEALING_DONE_SHORT", "ITEM_MOD_POWER_REGEN0_SHORT"};

local function FixTranslationGlitches()
    if ITEM_MOD_CRIT_RATING_SHORT == "Kritischer Trefferwert" then
        ITEM_MOD_CRIT_RATING_SHORT = "Kritische Trefferwertung";
    end
    if ITEM_MOD_HIT_RATING_SHORT == "Trefferwert" then
        ITEM_MOD_HIT_RATING_SHORT = "Trefferwertung";
    end
    if ITEM_MOD_RESILIENCE_RATING_SHORT == "PvP-Abhärtung" then
        ITEM_MOD_RESILIENCE_RATING_SHORT = "Abhärtungswertung";
    end
end

local PATTERNS;
local function CreatePatterns()
    PATTERNS = {
        ["ARMOR"] = "(([+-]?)(%d+) " .. ARMOR .. ")",
        ["BLOCK"] = "(([+-]?)(%d+) " .. BLOCK .. ")",
        ["ITEM_MOD_INTELLECT_SHORT"] = "(([+-]?)(%d+) " .. ITEM_MOD_INTELLECT_SHORT .. ")",
        ["ITEM_MOD_STRENGTH_SHORT"] = "(([+-]?)(%d+) " .. ITEM_MOD_STRENGTH_SHORT .. ")",
        ["ITEM_MOD_AGILITY_SHORT"] = "(([+-]?)(%d+) " .. ITEM_MOD_AGILITY_SHORT .. ")",
        ["ITEM_MOD_STAMINA_SHORT"] = "(([+-]?)(%d+) " .. ITEM_MOD_STAMINA_SHORT .. ")",
        ["ITEM_MOD_SPIRIT_SHORT"] = "(([+-]?)(%d+) " .. ITEM_MOD_SPIRIT_SHORT .. ")",
        ["ITEM_MOD_ATTACK_POWER_SHORT"] = "(([+-]?)(%d+) " .. ATTACK_POWER_TOOLTIP .. ")",
        ["ITEM_MOD_CRIT_RATING_SHORT"] = "(([+-]?)(%d+) " .. ITEM_MOD_CRIT_RATING_SHORT .. ")",
        ["ITEM_MOD_HIT_RATING_SHORT"] = "(([+-]?)(%d+) " .. ITEM_MOD_HIT_RATING_SHORT .. ")",
        ["ITEM_MOD_RESILIENCE_RATING_SHORT"] = "(([+-]?)(%d+) " .. ITEM_MOD_RESILIENCE_RATING_SHORT .. ")"
    };
end

local function MathSignToAscii(number)
    if number > 0 then
        return 43;
    end
    return 45;
end

local function FormatComparedStats(oldText, comparedValue)
    local comparedValueText;
    if comparedValue > 0 then
        comparedValueText = c:FormatTextWithColor("+" .. comparedValue, "00ff00");
    elseif comparedValue < 0 then
        comparedValueText = c:FormatTextWithColor(comparedValue, "ff0000");
    else
        return oldText; -- show nothing if difference is 0
    end
    return string.format("%s (%s)", oldText, comparedValueText);
end

local function AddScanResult(result, name, matches)
    if matches and table.getn(matches) > 2 then
        local match, sign, value = unpack(matches);
        result[name] = result[name] or 0;
        if sign == "-" then
            result[name] = result[name] - value;
        else
            result[name] = result[name] + value;
        end
        return true;
    end
end

local function IsGreenOrWhite(r, g, b)
    r, g, b = c:MathRound(r, 1), c:MathRound(g, 1), c:MathRound(b, 1);
    return (g == 1 and r + g + b == 1) or (g == 1 and r + g + b == 3) or (g == 0.8 and r + b + g == 1.8);
end

local function ScanTooltip(tooltip)
    local result = {};
    for i = 1, tooltip:NumLines() do
        local left = _G[tooltip:GetName() .. "TextLeft" .. i];
        if left then
            local text = left:GetText();
            if text then
                local r, g, b = left:GetTextColor();
                if IsGreenOrWhite(r, g, b) then
                    for name, pattern in pairs(PATTERNS) do
                        if AddScanResult(result, name, {string.match(text, pattern)}) then
                            break
                        end
                    end
                end
            end
        end
    end
    return result;
end

local function FixStatValues(name, value)
    if c:TableContains(ITEMSTATS_FIX, name) then
        return value + 1;
    end
    return value;
end

local function GetAdditionalStats(itemLink, stats)
    stats = stats or {};
    for name, value in pairs(GetItemStats(itemLink)) do
        if not c:TableContains(ITEMSTATS_EXCLUDE, name) then
            stats[name] = stats[name] or 0;
            stats[name] = stats[name] + FixStatValues(name, value);
        end
    end
    return stats;
end

function c:InitTooltips()
    FixTranslationGlitches();
    CreatePatterns();

    GQ_Item_Summary_Tooltip = CreateFrame("GameTooltip", "GQ_Item_Summary_Tooltip", UIParent, "GameTooltipTemplate");
    -- GQ_Item_Summary_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
    GQ_Item_Summary_Tooltip:SetAllPoints();
    GQ_Item_Summary_Tooltip:AddFontStrings(GQ_Item_Summary_Tooltip:CreateFontString("$parentTextLeft1", nil,
        "GameTooltipText"), GQ_Item_Summary_Tooltip:CreateFontString("$parentTextRight1", nil, "GameTooltipText"));

    GQ_Item_Summary_Tooltip.frame = CreateFrame("Frame", GQ_Item_Summary_Tooltip:GetName() .. "_Frame", GQ_Item_Summary_Tooltip);
    GQ_Item_Summary_Tooltip.frame:SetAllPoints();
    GQ_Item_Summary_Tooltip.frame:Show();

    GQ_Item_Summary_Tooltip:AddLine("HELLO!");
    GQ_Item_Summary_Tooltip:Show();

    GameTooltip:SetScript("OnTooltipSetItem", function(self)
        if (not IsModifiedClick("COMPAREITEMS") and not self:IsEquippedItem()) then
            GameTooltip_ShowCompareItem(self);
        else
            local shoppingTooltip1, shoppingTooltip2 = unpack(self.shoppingTooltips);
            shoppingTooltip1:Hide();
            shoppingTooltip2:Hide();
        end
        if (BattlePetTooltip) then
            BattlePetTooltip:Hide();
        end

        local _, mouseOverItemLink = self:GetItem();
        if mouseOverItemLink then
            -- local comparedItemLink1, comparedItemLink2;

            local gttValues = ScanTooltip(GameTooltip); -- scanned stats from tooltip
            gttValues = GetAdditionalStats(mouseOverItemLink, gttValues); -- additional stats from api

            -- c:DumpTable(gttValues);
            GQ_Item_Summary_Tooltip:AddLine("HELLO!");
            GQ_Item_Summary_Tooltip:Show();
            -- local gttValues = ScanTooltip(GameTooltip);
            -- local gttValues = ScanTooltip(GameTooltip);

            -- if ShoppingTooltip1 and ShoppingTooltip1:IsVisible() then
            --     local _, comparedItemLink = ShoppingTooltip1:GetItem();
            --     comparedItemLink1 = comparedItemLink;
            --     ProcessShoppingTooltip(ShoppingTooltip1, mouseOverItemLink, comparedItemLink);
            -- end
            -- if ShoppingTooltip2 and ShoppingTooltip2:IsVisible() then
            --     local _, comparedItemLink = ShoppingTooltip2:GetItem();
            --     comparedItemLink2 = comparedItemLink;
            --     ProcessShoppingTooltip(ShoppingTooltip2, mouseOverItemLink, comparedItemLink);
            -- end

            -- ProcessGametooltip(GameTooltip, mouseOverItemLink, comparedItemLink1, comparedItemLink2);
        end
    end);
end
