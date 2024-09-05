local _, addon = ...
local API = addon.API;

local strtrim = strtrim;
local UIParent = UIParent;

local gsub = string.gsub;
local match = string.match;
local find = string.find;
local format = string.format;
local split = string.split;
local sub = string.sub;
local tinsert = table.insert;

local floor = math.floor;
local max = math.max;

local _G = _G;
local TEXT_LOCALE = GetLocale();

local GetItemInfoInstant = API.GetItemInfoInstant;
local GetItemGem = API.GetItemGem;
local GetItemStats = API.GetItemStats;
local DoesItemExist = C_Item.DoesItemExist;


local function IsArtifactRelic(item)
    --an alternative to IsArtifactRelicItem()
    local _, _, _, _, _, classID, subclassID = GetItemInfoInstant(item);
    return classID == 3 and subclassID == 11
end

--[[
    GameTooltip Color Scheme
    1, 0.13, 0.13  --red
    0, 1, 0     --green
    1, 1, 1     --white
    1, 0.5, 1   --pink transmog
    0.5, 0.5, 0.5   --grey

    ITEM_SET_LEGACY_INACTIVE_BONUS
    ITEM_LEGACY_INACTIVE_EFFECTS
--]]

local function RoundColor(a)
    return tonumber(format("%.2f", floor(a*100+0.5)*0.01 ))
end

local function IsTextColorColor(fontstring, r, g, b)
    local textR, textG, textB = fontstring:GetTextColor();
    return (RoundColor(textR) == r) and (RoundColor(textG) == g) and (RoundColor(textB) == b)
end


local function trimComma(text)
    return strtrim(text, ":：");
end

local function Pattern_WrapBrace(text)
    return text and gsub(text, "([()（）])", "%%%1");
end

local function Pattern_WrapSpace(text)
    return text and gsub(text, "%%s", "%(%.%+%)");
end

local function Pattern_WrapNumber(text)
    if not text then return end
    text = gsub(text, "%%d", "%(%%d%)");
    text = gsub(text, "%%d%+", "%(%%d%+%)");
    return text
end

local LEFT_BRACE = "%(";
local RIGHT_BRACE = "%)";


local ON_USE = ITEM_SPELL_TRIGGER_ONUSE;
local ON_EQUIP = ITEM_SPELL_TRIGGER_ONEQUIP;
local ON_PROC = ITEM_SPELL_TRIGGER_ONPROC;
local ITEM_BONUS = Narci.L["Item Bonus"];   --Bonus: (used by Domination Shard)     --ITEM_SOCKET_BONUS
local NO_COMMA_ON_USE = trimComma(ON_USE);
local NO_COMMA_ON_EQUIP = trimComma(ON_EQUIP);
local NO_COMMA_ON_PROC = trimComma(ON_PROC);
local NO_COMMA_SET_BONUS = trimComma(ITEM_BONUS);
local GEM_MIN_LEVEL = SOCKETING_ITEM_MIN_LEVEL_I;
local GREY_FONT = "|cff959595";
local SOURCE_KNOWN = TRANSMOGRIFY_TOOLTIP_APPEARANCE_KNOWN;
local APPEARANCE_KNOWN = TRANSMOGRIFY_TOOLTIP_ITEM_UNKNOWN_APPEARANCE_KNOWN;
local APPEARANCE_UNKNOWN = TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN;

local SET_BONUS = gsub(ITEM_SET_BONUS, "%%s", "");          --"Set: %s"     --SET_BONUS_GRAY
local SOCKET_BONUS = gsub(ITEM_SOCKET_BONUS, "%%s", "");    --Socket Bonus: %s

local PATTERN_COOLDOWN_TIME = "%((%d.+) Cooldown%)$";
local PATTERN_UPGRADE_LEVEL = gsub(ITEM_UPGRADE_TOOLTIP_FORMAT, "%%d+", "(%%d+)");
local PATTERN_ITEM_SET_NAME = "(.+) %((%d+)/(%d+)%)";   --Pattern_WrapNumber( Pattern_WrapSpace( Pattern_WrapBrace( ITEM_SET_NAME) ) );
local PATTERN_CLASS_REQUIREMENT = Pattern_WrapSpace(ITEM_CLASSES_ALLOWED);
local PATTERN_AMMO_DPS = gsub(AMMO_DAMAGE_TEMPLATE, "%%s", "([%%d.]+)");

do
    if TEXT_LOCALE == "zhCN" then
        LEFT_BRACE = "（";
        RIGHT_BRACE = "）";
        PATTERN_ITEM_SET_NAME = "(.+)（(%d+)/(%d+)）"  --"%s（%d/%d）";
    elseif TEXT_LOCALE == "zhTW" then
        PATTERN_ITEM_SET_NAME = "(.+)%((%d+)/(%d+)%)";   --%s(%d/%d)
    elseif TEXT_LOCALE == "deDE" then
        PATTERN_ITEM_SET_NAME = "(.+) %((%d+)/(%d+)%)";     --"%1$s (%2$d/%3$d)"??
    end
end

local function RemoveColorString(str)
    if str then
        return gsub(str, "|[cC][fF][fF]%w%w%w%w%w%w(.*)|[rR]", "%1")
    end
end

NarciAPI.RemoveColorString = RemoveColorString;

local function FormatItemLink(link)
    return match(link, "(item:[%-?%d:]+)");
end

local function FormatString(text, removedText, keepFormat)
    if not keepFormat then
        text = strtrim(text, removedText);
        text = trimComma(text);
        text = strtrim(text);                               --remove space
        text = gsub(text, LEFT_BRACE, "\n\n"..GREY_FONT)
        text = gsub(text, RIGHT_BRACE, "|r")
    end
    return text;
end

local function TrimCooldownText(text)
    text = trimComma(text);
    local cooldownText = match(text, PATTERN_COOLDOWN_TIME);
    text = gsub(text, LEFT_BRACE..".+"..RIGHT_BRACE.."$", "");
    text = strtrim(text);
    return text, cooldownText;
end

local function ReplacePureGreenText(text)
    return gsub(text, "cFF.0FF.0", "cFF00E700");
end


----Generic Tooltip Scan----

local TP = CreateFrame("GameTooltip", "NarciVirtualTooltip", nil, "GameTooltipTemplate");
TP:SetOwner(UIParent, 'ANCHOR_NONE');
TP:SetClampedToScreen(false);
TP:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", 0, -128);
TP:Show();
TP:SetScript("OnUpdate", nil);



---- Advanced Tooltip Parser with callback ----
local Tooltip;
local TOOLTIP_NAME = "NarciUtilityTooltip";
local IS_ITEM_CACHED = {};
local IS_LINE_HOOKED = {};

local pinnedObjects, lastItem, lastText, onTextChangedCallback;

local function OnTextChanged(object, text)
    print(object.lineIndex);
    print(text);
end

local function SetTooltipItem(item)
    if not item then return end;

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    if type(item) == "number" then
        Tooltip:SetItemByID(item);
    else
        Tooltip:SetHyperlink(item);
    end

    if IS_ITEM_CACHED[item] then
        return true
    else
        IS_ITEM_CACHED[item] = true;
        return false
    end
end

local function GetPinnedLineText()
    if pinnedObjects then
        local output;
        local text;
        for i = 1, #pinnedObjects do
            text = pinnedObjects[i]:GetText() or "";
            text = strtrim(text);
            if text and text ~= "" then
                if output then
                    output = output.."\n"..text;
                else
                    output = text;
                end
            end
        end
        if output ~= lastText then
            lastText = output;
            if onTextChangedCallback then
                onTextChangedCallback(output);
            end
            return true
        end
    end
end

local function Tooltip_OnUpdate(self, elapsed)
    self.t = self.t + elapsed;
    if self.t > 0.25 then
        self.t = 0;
        self.iteration = self.iteration + 1;
        if self.iteration > 3 then
            self:SetScript("OnUpdate", nil);
        end
        SetTooltipItem(lastItem);
        GetPinnedLineText()
    end
end

local function GetCachedItemTooltipTextByLine(item, line, callbackFunc)
    if not Tooltip then
        Tooltip = CreateFrame("GameTooltip", TOOLTIP_NAME, nil, "GameTooltipTemplate");
        Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
    end

    onTextChangedCallback = callbackFunc;
    local isCached = SetTooltipItem(item);

    if item ~= lastItem then
        lastItem = item;
        lastText = nil;
        Tooltip.t = 0;
        Tooltip.iteration = 0;
        Tooltip:SetScript("OnUpdate", Tooltip_OnUpdate);
    end

    local object;
    local text;

    if pinnedObjects then
        wipe(pinnedObjects);
    else
        pinnedObjects = {};
    end
    if type(line) == "table" then
        local output;
        local _l;
        for i = 1, #line do
            _l = line[i];
            object = _G[TOOLTIP_NAME.."TextLeft".._l];
            if object then
                tinsert(pinnedObjects, object);
                if not IS_LINE_HOOKED[_l] then
                    IS_LINE_HOOKED[_l] = true;
                    object.lineIndex = _l;
                end
                text = object:GetText() or "";
                text = strtrim(text);
                if text and text ~= "" then
                    if output then
                        output = output.."\n"..text;
                    else
                        output = text;
                    end
                end
            end
        end
        return output, isCached
    else
        object = _G[TOOLTIP_NAME.."TextLeft"..line];
        pinnedObjects = {object};
        if object then
            if not IS_LINE_HOOKED[line] then
                IS_LINE_HOOKED[line] = true;
                object.lineIndex = line;
            end
            text = object:GetText();
        end
        return text, isCached
    end
end

NarciAPI.GetCachedItemTooltipTextByLine = GetCachedItemTooltipTextByLine;
-------------------------------------------------------------------




local function ShowTooltip()
    TP:SetOwner(UIParent, 'ANCHOR_NONE');
    TP:Show();
end

local LEFT_FONT_STRINGS = {
    TP.TextLeft1, TP.TextLeft2
};


local function GetItemRank(itemLink, statName)
    --Items that can get upgraded
    if not itemLink then return; end

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);
    local fontstring = _G["NarciVirtualTooltip".."TextLeft"..2];
    fontstring = fontstring:GetText() or "";
    fontstring = strtrim(fontstring, "|r");
    local rank = match(fontstring, "%d+", -2) or "";

    if statName then
        local stats = GetItemStats(itemLink) or {};
        return "|cff00ccff"..rank.."|r", stats[statName] or 0
    else
        return "|cff00ccff"..rank.."|r"
    end
end

NarciAPI.GetItemRank = GetItemRank;


local function GetItemTooltipTextByLine(item, line, keepColor)
    --It's possible that item description hasn't been cached yet
    --See TooltipParser.lua for more advanced functionalities

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    if type(item) == "number" then
        TP:SetItemByID(item);
    else
        TP:SetHyperlink(item);
    end

    local object = _G["NarciVirtualTooltipTextLeft"..line];
    if object then
        if keepColor then
            return object:GetText();
        else
            return RemoveColorString(object:GetText());
        end
    end
end

NarciAPI.GetItemTooltipTextByLine = GetItemTooltipTextByLine;


local ITEM_ENCHANT_FORMAT = gsub(ENCHANTED_TOOLTIP_LINE, "%%s", "(.+)");

local function GetItemEnchantText(itemLink, colorized)
    if not itemLink then return; end

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);
    local numLines = TP:NumLines();
    local str;
    local enchantText;
    local enchantFormat = ITEM_ENCHANT_FORMAT;
    for i = 5, numLines do
        str = _G["NarciVirtualTooltip".."TextLeft"..i];
        if str then
            str = str:GetText();
            enchantText = match(str, enchantFormat);
            if enchantText then
                enchantText = strtrim(enchantText);
                if enchantText ~= "" then
                    --print(enchantText)
                    if colorized then
                        enchantText = "|cff5fbd6b"..enchantText.."|r";
                    end
                    return enchantText
                end
            end
        else
            return
        end
    end
end

local function GetEnchantTextByEnchantID(enchantID)
    if enchantID then
        local itemLink = "item:2092:"..enchantID;
        return GetItemEnchantText(itemLink, false);
    end
end

NarciAPI.GetItemEnchantText = GetItemEnchantText;
NarciAPI.GetEnchantTextByEnchantID = GetEnchantTextByEnchantID;


local function GetEnchantTextByItemLink(itemLink, colorized)
    if not itemLink then return end;

    local _, _, _, linkType, linkID, enchantID = split(":|H", itemLink);

    if enchantID and enchantID ~= "" then
        local link = "item:2092:"..enchantID;

        TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
        TP:SetHyperlink(link);

        if not LEFT_FONT_STRINGS[5] then
            LEFT_FONT_STRINGS[5] = _G["NarciVirtualTooltipTextLeft5"];
        end

        if LEFT_FONT_STRINGS[5] then
            local enchantText = LEFT_FONT_STRINGS[5]:GetText();

            if enchantText and enchantText ~= "" then
                if colorized then
                    enchantText = "|cff5fbd6b"..enchantText.."|r";
                end
                return enchantText
            end
        end
    end
end

NarciAPI.GetEnchantTextByItemLink = GetEnchantTextByItemLink;


local function GetEnchantTextBySlot(slotID)
    local itemLink = GetInventoryItemLink("player", slotID);
    return GetEnchantTextByItemLink(itemLink);
end

NarciAPI.GetEnchantTextBySlot = GetEnchantTextBySlot;


local TEMP_ENCHANT_FORMAT = "([^+].+) %((%d+%D+)%)";
local FORMAT_COLON = ":";
if TEXT_LOCALE == "zhCN" then
    FORMAT_COLON = "：";
    TEMP_ENCHANT_FORMAT = "([^+].+)（(%d+%D+)%）";
elseif TEXT_LOCALE == "zhTW" then
    FORMAT_COLON = "：";
    TEMP_ENCHANT_FORMAT = "([^+].+)%((%d+%D+)%)";
end

local function GetTemporaryItemBuff(location1, location2)
    if not location1 then return; end

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    if location2 then
        TP:SetBagItem(location1, location2);
    else
        TP:SetInventoryItem("player", location1, nil, true);
    end
    local numLines = TP:NumLines();
    local str;
    local r, g, b;
    local buffText, durationText;
    for i = 5, numLines do
        str = _G["NarciVirtualTooltip".."TextLeft"..i];
        if str then
            str = str:GetText();
            if not match(str, FORMAT_COLON) then
                buffText, durationText = match(str, TEMP_ENCHANT_FORMAT);
                if buffText and durationText then
                    break
                end
            end
        end
    end

    --durationText: hours, hour, min, sec
    --/dump string.match("Reinforced (15 sec)", ".+ %((%d+) sec%)")
    return buffText, durationText
end

NarciAPI.GetTemporaryItemBuff = GetTemporaryItemBuff;


local function GetWeaponDamageAndSpeed(itemLink)
    if not itemLink then return; end
    local _, _, _, itemEquipLoc, _, classID, subclassID = GetItemInfoInstant(itemLink);
    if classID ~= 2 then
        return
    end
    itemEquipLoc = _G[itemEquipLoc];

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);
    local numLines = TP:NumLines();
    local fontString, leftText, rightText;

    for i = 3, numLines do
        fontString = _G["NarciVirtualTooltip".."TextLeft"..i];
        if fontString then
            leftText = fontString:GetText();
            if leftText == itemEquipLoc then
                local n = i + 1;
                fontString = _G["NarciVirtualTooltip".."TextLeft"..n];
                if fontString then
                    leftText = fontString:GetText();
                end
                fontString = _G["NarciVirtualTooltip".."TextRight"..n];
                if fontString then
                    rightText = fontString:GetText();
                end
                return leftText, rightText
            end
        else
            return
        end
    end
end

NarciAPI.GetWeaponDamageAndSpeed = GetWeaponDamageAndSpeed;


local function GetItemFlavorText(itemLink)
    if not itemLink then return; end

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);
    local numLines = TP:NumLines();
    local fontString, text;

    for i = numLines, numLines - 1, -1 do
        fontString = _G["NarciVirtualTooltip".."TextLeft"..i];
        if fontString then
            text = fontString:GetText();
            if match(text, "^[\"“]") then
                return text
            end
        else
            return
        end
    end
end

NarciAPI.GetItemFlavorText = GetItemFlavorText;


local function GetTooltipSocketInfo(itemLink)
    if not itemLink then return; end

    local tex, texID;

    for i = 1, 3 do
        tex = _G["NarciVirtualTooltipTexture"..i];
        if tex then
            tex = tex:SetTexture(nil);
        end
    end

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);

    local _, relativeFontString;
    local socketInfo, gemName, gemLink, effect;

    for i = 1, 3 do
        tex = _G["NarciVirtualTooltipTexture"..i];
        texID = tex and tex:GetTexture();
        if texID then
            if not socketInfo then
                socketInfo = {};
            end
            gemName, gemLink = GetItemGem(itemLink, i);
            _, relativeFontString = tex:GetPoint();
            if relativeFontString then
                effect = relativeFontString:GetText();
                effect = RemoveColorString(effect);
            else
                effect = nil;
            end
            socketInfo[i] = {texID, gemName, gemLink, effect};
        end
    end

    return socketInfo
end

NarciAPI.GetTooltipSocketInfo = GetTooltipSocketInfo;


local function NarciAPI_IsAppearanceKnown(itemLink)
    --Need to correspond with C_TransmogCollection.PlayerHasTransmog
    if not itemLink then    return; end
    TP:SetHyperlink(itemLink);
    local str;
    local num = TP:NumLines();
    for i = num, num - 2, -1 do
        str = nil;
        str = _G["NarciVirtualTooltip".."TextLeft"..i]
        if not str then
            return false;
        else
            str = str:GetText();
        end
        if str == SOURCE_KNOWN or str == APPEARANCE_KNOWN then
            return true;
        elseif str == APPEARANCE_UNKNOWN then
            return false;
        end
    end
    return false;
end

NarciAPI.IsAppearanceKnown = NarciAPI_IsAppearanceKnown;


local function GetItemExtraEffect(itemLink, checkBonus, keepFormat)
    if not itemLink then return; end

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);

    local num = TP:NumLines();
    local begin = 4;
    local output = "";
    local category, str;

    for i = begin, num, 1 do
        str = nil;
        str = _G["NarciVirtualTooltip".."TextLeft"..i];
        if not str then
            break;
        else
            str = str:GetText();
        end

        if find(str, ON_USE) then
            str = FormatString(str, NO_COMMA_ON_USE, keepFormat);
            if not category then    category = NO_COMMA_ON_USE; end
            output = output..str.."\n"
        elseif find(str, ON_EQUIP) then
            str = FormatString(str, NO_COMMA_ON_EQUIP, keepFormat);
            if not category then    category = NO_COMMA_ON_EQUIP; end
            output = output..str.."\n"
        elseif find(str, ON_PROC) then
            str = FormatString(str, NO_COMMA_ON_PROC, keepFormat);
            if not category then    category = NO_COMMA_ON_PROC; end
            output = output..str.."\n"
        elseif checkBonus then
            if find(str, ITEM_BONUS) then
                str = FormatString(str, NO_COMMA_SET_BONUS, keepFormat);
                if not category then    category = NO_COMMA_SET_BONUS; end
                output = output..str.."\n"
                break
            end
        end
    end
    return category, output;
end

NarciAPI.GetItemExtraEffect = GetItemExtraEffect;


local SpecialGemData = {
    --1 Movement Speed
    --2 Health Regen
    [173125] = 2,       --Revitalizing Jewel Doublet
    [173126] = 1,       --Straddling Jewel Doublet
    [25893] = 3,        --Meta Chance to Increase Spell Cast Speed
    [32410] = 4,        --Meta Chance to Increase Melee/Ranged Attack Speed
};

local function NarciAPI_GetGemBonus(item)
    --item: Gem's Item ID or hyperlink
    if not item then return; end

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    local itemID;
    if type(item) == "number" then
        TP:SetItemByID(item);
        itemID = item;
    else
        TP:SetHyperlink(item);
        itemID = GetItemInfoInstant(item);
    end
    local num = TP:NumLines();
    local bonusText;
    local str;
    local level = 0;

    local bonusID = SpecialGemData[itemID];
    if bonusID then
        if bonusID == 1 then
            bonusText = STAT_MOVEMENT_SPEED;
        elseif bonusID == 2 then
            bonusText = ITEM_MOD_HEALTH_REGENERATION_SHORT;
        elseif bonusID == 3 then
            bonusText = GetSpellInfo(32837);
        elseif bonusID == 4 then
            bonusText = STAT_ATTACK_SPEED;
        end
    end

    for i = 1, num do
        str = _G["NarciVirtualTooltip".."TextLeft"..i]
        if not str then
            return;
        else
            str = str:GetText();
            if not str then
                return;
            end
        end

        if not bonusText and sub(str, 1, 1) == "+" then
            bonusText = str;
        end

        if find(str, GEM_MIN_LEVEL) then
            level = FormatString(str, GEM_MIN_LEVEL);
        end

        if level and bonusText then return bonusText, tonumber(level); end
    end
    return bonusText, tonumber(level);
end

NarciAPI.GetGemBonus = NarciAPI_GetGemBonus;


local function GetItemEquipEffect(itemLink)
    if not itemLink then return; end

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);
    local total = TP:NumLines();
    local begin = max(total - 4, 0);
    local fontString, text;
    local effects, effectType, effectText, cooldownText;
    local numEffects;

    for i = begin, total do
        fontString = _G["NarciVirtualTooltip".."TextLeft"..i];
        if not fontString then
            break;
        else
            text = fontString:GetText();
        end
        effectType = nil;
        effectText = nil;
        cooldownText = nil;
        if find(text, ON_USE) then
            effectText, cooldownText = TrimCooldownText( strtrim(text, NO_COMMA_ON_USE) );
            effectType = "use";
        elseif find(text, ON_EQUIP) then
            effectText = RemoveColorString(text);
            effectType = "equip";
        elseif find(text, ON_PROC) then
            effectText = text;
            effectType = "proc";
        elseif find(text, ITEM_BONUS) then
            effectText = text;
            effectType = "set";
        end
        if effectType then
            if not effects then
                effects = {};
                numEffects = 0;
            end
            numEffects = numEffects + 1;
            effects[numEffects] = {effectType, effectText, cooldownText};
        end
    end
    return effects, numEffects;
end

NarciAPI.GetItemEquipEffect = GetItemEquipEffect;


local function GetItemUpgradeLevel(itemLink)
    if not itemLink then return; end

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);
    local fontString, text;
    local currentLevel, maxLevel;
    for i = 2, 3 do
        fontString = _G["NarciVirtualTooltip".."TextLeft"..i];
        if fontString then
            text = fontString:GetText();
            currentLevel, maxLevel = match(text, PATTERN_UPGRADE_LEVEL);
            if maxLevel then
                return currentLevel, maxLevel
            end
        else
            break
        end
    end
end

NarciAPI.GetItemUpgradeLevel = GetItemUpgradeLevel;


local function GetCompleteItemData(itemLink)
    --return a table of data obtained by scanning tooltip
    --upgrade level (current/max), equipmentEffects(onEquip, onUse, onProc, bonus), socket info(socket1, socket2, socket3), enchant
    --reset socket textures
    local _;
    if not itemLink then
        _, itemLink = TP:GetItem();
        itemLink = FormatItemLink(itemLink);
        if not itemLink then
            return
        end
    end

    local _, _, _, itemEquipLoc, _, classID, subclassID = GetItemInfoInstant(itemLink);
    local matchWeapon;
    if classID == 2 then
        --Find Weapon damage and attack speed by matching the texts below equip location
        itemEquipLoc = _G[itemEquipLoc];
        matchWeapon = true;
    end

    local processed = {};   --process each line once

    local numLines = TP:NumLines();
    local fontString, text;
    local match1, match2;
    local enchantText;
    local effectText, effectType, numEffects, isActive, cooldownText;
    local data, anyMatch;
    local tex, texID;
    local gemName, gemLink, gemEffect, lineIndex;

    for i = 1, 3 do
        tex = _G["NarciVirtualTooltipTexture"..i];
        texID = tex and tex:GetTexture();
        if texID then
            gemName, gemLink = GetItemGem(itemLink, i);
            _, fontString = tex:GetPoint();
            if fontString then
                gemEffect = fontString:GetText();
                gemEffect = RemoveColorString(gemEffect);
                lineIndex = tonumber(match(fontString:GetName(), "Left(%d+)$"));
                processed[lineIndex] = true;
                if lineIndex and not LEFT_FONT_STRINGS[lineIndex] then
                    LEFT_FONT_STRINGS[lineIndex] = fontString;
                end
            else
                gemEffect = nil;
            end
            if not data then
                data = {};
            end
            if not data.socketInfo then
                data.socketInfo = {};
            end
            data.socketInfo[i] = {texID, gemName, gemLink, gemEffect};
        end
    end

    for i = 2, numLines do
        if not processed[i] then
            if not LEFT_FONT_STRINGS[i] then
                LEFT_FONT_STRINGS[i] = _G["NarciVirtualTooltipTextLeft"..i];
            end
            fontString = LEFT_FONT_STRINGS[i];
            if fontString then
                text = fontString:GetText();
                anyMatch = nil;
                if i == 2 then
                    --the second line is usually item level
                    --or a special item category: difficuty, Cypher Equipment
                    if not match(text, "%d$") then
                        if not data then
                            data = {};
                        end
                        data.context = ReplacePureGreenText(text);
                        GT = data.context
                        anyMatch = true;
                    end
                else
                    if i < 5 and not match2 then
                        --upgrade level
                        match1, match2 = match(text, PATTERN_UPGRADE_LEVEL);
                        if match2 then
                            if not data then
                                data = {};
                            end
                            data.upgradeLevel = {match1, match2};
                            anyMatch = true;
                        end
                    end
                end


                if i >= 4 and not anyMatch then
                    --effects
                    if find(text, ON_USE) then
                        effectText, cooldownText = TrimCooldownText( strtrim(text, NO_COMMA_ON_USE) );
                        effectType = "use";
                    elseif find(text, ON_EQUIP) then
                        effectText = RemoveColorString(text);
                        effectType = "equip";
                    elseif find(text, ON_PROC) then
                        effectText = text;
                        effectType = "proc";
                    elseif find(text, ITEM_BONUS) or find(text, SOCKET_BONUS) then
                        effectText = text;
                        effectType = "set";
                    elseif matchWeapon then
                        if text == itemEquipLoc then
                            matchWeapon = nil;
                            local leftText, rightText;
                            fontString = _G["NarciVirtualTooltipTextRight"..i];
                            if fontString then
                                rightText = fontString:GetText();   --weapon type singular
                                if rightText then
                                    if not data then
                                        data = {};
                                    end
                                    data.itemType = rightText;
                                end
                            end
                            local n = i + 1;
                            if not LEFT_FONT_STRINGS[n] then
                                LEFT_FONT_STRINGS[n] = _G["NarciVirtualTooltipTextLeft"..n]
                            end
                            fontString = LEFT_FONT_STRINGS[n];
                            if fontString then
                                leftText = fontString:GetText();        --damage (x - y Damage)
                            end
                            fontString = _G["NarciVirtualTooltipTextRight"..n];
                            if fontString then
                                rightText = fontString:GetText();       --speed 0.00
                            end
                            if leftText and rightText then
                                if not data then
                                    data = {};
                                end
                                data.weaponInfo = {leftText, rightText};
                                anyMatch = true;
                            end
                        end
                    else
                        --enchant
                        if not enchantText then
                            enchantText = match(text, ITEM_ENCHANT_FORMAT);
                            if enchantText then
                                enchantText = strtrim(enchantText);
                                if enchantText ~= "" then
                                    if not data then
                                        data = {};
                                    end
                                    data.enchant = enchantText;
                                    anyMatch = true;
                                end
                            end
                        end
                    end

                    if effectType then
                        if not data then
                            data = {};
                        end
                        if not data.effects then
                            data.effects = {};
                            numEffects = 0;
                        end
                        isActive = not (IsTextColorColor(fontString, 1, 0.13, 0.13) or IsTextColorColor(fontString, 0.5, 0.5, 0.5));
                        numEffects = numEffects + 1;
                        data.effects[numEffects] = {effectType, effectText, isActive, cooldownText};
                        effectType = nil;
                        effectText = nil;
                        cooldownText = nil;
                        isActive = nil;
                        anyMatch = true;
                    end
                end
                if i >= numLines - 2 and not anyMatch then
                    --flavor texts, class restrictions
                    match1 = match(text, PATTERN_CLASS_REQUIREMENT);
                    if match1 then
                        isActive = IsTextColorColor(fontString, 1, 1, 1);
                        if not data then
                            data = {};
                        end
                        data.classesAllowed = {match1, isActive};
                        anyMatch = true;
                    elseif match(text, "^[\"“]") then
                        if not data then
                            data = {};
                        end
                        data.flavorText = text;
                        anyMatch = true;
                    end
                end
                --print(i.." "..tostring(anyMatch).." "..text)
                if i > 8 and not anyMatch then
                    --match item sets
                    match1, match2, _ = match(text, PATTERN_ITEM_SET_NAME);    --string.match("Test Set (1/9)", PATTERN_ITEM_SET_NAME)
                    if match1 and match2 and _ then
                        --found setName, numOwned, total
                        if not data then
                            data = {};
                        end
                        if not data.itemSet then
                            data.itemSet = {};
                            data.itemSet.itemNames = {};
                            data.itemSet.bonuses = {};
                        end
                        anyMatch = true;
                        local total = tonumber(_);
                        data.itemSet.rawName = text;
                        data.itemSet.name = match1;
                        data.itemSet.numOwned = tonumber(match2);
                        data.itemSet.total = total;

                        for j = 1 + i, total + i do
                            if not LEFT_FONT_STRINGS[j] then
                                LEFT_FONT_STRINGS[j] = _G["NarciVirtualTooltipTextLeft"..j]
                            end
                            fontString = LEFT_FONT_STRINGS[j];
                            if fontString then
                                text = fontString:GetText();
                                isActive = not IsTextColorColor(fontString, 0.5, 0.5, 0.5);
                                --print(fontString:GetTextColor());
                                tinsert(data.itemSet.itemNames, {text, isActive});
                                processed[j] = true;
                            else
                                break
                            end
                        end
                        for j = i + total + 2, numLines do
                            if not LEFT_FONT_STRINGS[j] then
                                LEFT_FONT_STRINGS[j] = _G["NarciVirtualTooltipTextLeft"..j]
                            end
                            fontString = LEFT_FONT_STRINGS[j];
                            if fontString then
                                text = fontString:GetText();
                                if find(text, SET_BONUS, 1) then
                                    --found set bonus
                                    isActive = not IsTextColorColor(fontString, 0.5, 0.5, 0.5);
                                    tinsert(data.itemSet.bonuses, {text, isActive});
                                    processed[j] = true;
                                end
                            else
                                break
                            end
                        end
                    end
                end
            else
                --No FontString
                break
            end
        end
    end

    return data
end

local function ClearTooltipTexture()
    local tex;
    for i = 1, 3 do
        tex = _G["NarciVirtualTooltipTexture"..i];
        if tex then
            tex = tex:SetTexture(nil);
        else
            break
        end
    end
    for i, fontString in pairs(LEFT_FONT_STRINGS) do
        fontString:SetText(nil);
        fontString:SetTextColor(1, 1, 1); --this should fix some coloring issue caused by using escape sequence: |cff
    end
end

local function GetCompleteItemDataFromSlot(slotID)
    ClearTooltipTexture();
    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetInventoryItem("player", slotID, false, true);
    return GetCompleteItemData();
end

local function GetCompleteItemDataByItemLink(itemLink)
    if not itemLink then return end
    ClearTooltipTexture();
    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);
    return GetCompleteItemData(itemLink);
end

local function GetCompleteItemDataFromGameTooltip()
    --for debug
    local name, itemLink = GameTooltip:GetItem();
    if itemLink then
        ClearTooltipTexture();
        TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
        TP:SetHyperlink(itemLink);
        return GetCompleteItemData(itemLink);
    end
end

NarciAPI.GetCompleteItemDataFromSlot = GetCompleteItemDataFromSlot;
NarciAPI.GetCompleteItemDataByItemLink = GetCompleteItemDataByItemLink;
NarciAPI.GetCompleteItemDataFromGameTooltip = GetCompleteItemDataFromGameTooltip;


--[[
EMPTY_SOCKET_BLUE = "Blue Socket"; 136256
EMPTY_SOCKET_COGWHEEL = "Cogwheel Socket"; 407324
EMPTY_SOCKET_CYPHER = "Crystallic Socket"; ???
EMPTY_SOCKET_DOMINATION = "Domination Socket"; 4095404
EMPTY_SOCKET_HYDRAULIC = "Sha-Touched"; 407325
EMPTY_SOCKET_META = "Meta Socket"; 136257
EMPTY_SOCKET_NO_COLOR = "Prismatic Socket"; 458977
EMPTY_SOCKET_PRISMATIC = "Prismatic Socket"; 458977
EMPTY_SOCKET_PUNCHCARDBLUE = "Blue Punchcard Socket"; 2958629
EMPTY_SOCKET_PUNCHCARDRED = "Red Punchcard Socket"; 2958630
EMPTY_SOCKET_PUNCHCARDYELLOW = "Yellow Punchcard Socket"; 2958631
EMPTY_SOCKET_RED = "Red Socket"; 136258
EMPTY_SOCKET_YELLOW = "Yellow Socket"; 136259
EMPTY_SOCKET_CYPHER = "Crystallic Socket"

RELIC_TOOLTIP_TYPE
--]]

local SocketTypes = {
    --tooltip emtpy socket texture fileID
    [136256] = "BLUE",
    [136258] = "RED",
    [136259] = "YELLOW",
    [407324] = "COGWHEEL",
    [4095404] = "DOMINATION",
    [407325] = "HYDRAULIC",
    [136257] = "META",
    [458977] = "PRISMATIC",
    [2958629] = "PUNCHCARDBLUE",
    [2958630] = "PUNCHCARDRED",
    [2958631] = "PUNCHCARDYELLOW",
};

local IsSupportedSocket = {};

for _, name in pairs(SocketTypes) do
    IsSupportedSocket[name] = true;
end


local function IsItemSocketable(itemLink, socketID)
    if not itemLink then return; end

    local gemName, gemLink = GetItemGem(itemLink, socketID or 1)
    if gemLink then
        if not IsArtifactRelic(gemLink) then
            return gemName or "...", gemLink;
        end
        return
    end

    local tex, texID;
    for i = 1, 3 do
        tex = _G["NarciVirtualTooltipTexture"..i];
        if tex then
            tex = tex:SetTexture(nil);
        end
    end

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);

    for i = 1, 3 do     --max 10
        tex = _G["NarciVirtualTooltipTexture"..i]
        texID = tex and tex:GetTexture();
        --print(texID)
        if SocketTypes[texID] then     --458977: Regular empty socket texture  --Doesn't include domination socket
            return "Empty", nil;
        end
    end
    return nil, nil;
end
NarciAPI.IsItemSocketable = IsItemSocketable;

local function GetItemSocketInfo(itemLink)
    --gemData = { {socketType, icon, gemLink(nillable) } }

    if not itemLink then return end
    ClearTooltipTexture();

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);

    local tex, texID;
    local gemName, gemLink;
    local socektInfo;
    local numSocket = 0;
    for i = 1, 3 do
        gemName, gemLink = GetItemGem(itemLink, i);
        if gemLink then
            if not socektInfo then
                socektInfo = {};
            end
            texID = select(5, GetItemInfoInstant(gemLink));
            numSocket = numSocket + 1;
            socektInfo[numSocket] = {gemName, texID, gemLink};
        else
            tex = _G["NarciVirtualTooltipTexture"..i];
            texID = tex and tex:GetTexture();
            if SocketTypes[texID] then
                if not socektInfo then
                    socektInfo = {};
                end
                numSocket = numSocket + 1;
                socektInfo[numSocket] = {SocketTypes[texID], texID, };
            end
        end
    end

    --socektInfo = { {SocketTypes[458977], 458977}, {SocketTypes[4095404], 4095404}, {SocketTypes[136257], 136257} };   --debug SL
    --socektInfo = { {SocketTypes[136257], 136257}, {SocketTypes[136259], 136259}, {SocketTypes[136256], 136256} };   --debug TBC
    return socektInfo
end

NarciAPI.GetItemSocketInfo = GetItemSocketInfo;


local function DoesItemHaveSockets(itemLink)
    --determine if item really have sockets instead of relics
    --can't determine socket order so:
    --If the item have two or more types of socket, use ItemSocketingFrame-GetSocketTypes to get socket order

    if not itemLink then return end

    local stats = GetItemStats(itemLink);

    if stats then
        local numSocket = 0;
        local subType, lastType;
        local socketIsDiverse;

        for name, count in pairs(stats) do
            subType = match(name, "^EMPTY_SOCKET_(%a+)");
            if IsSupportedSocket[subType] then
                numSocket = numSocket + count;
                if lastType then
                    socketIsDiverse = socketIsDiverse or (subType ~= lastType);
                else
                    lastType = subType;
                end
            end
        end

        if numSocket > 0 then
            return numSocket, socketIsDiverse, lastType
        end
    end
end

NarciAPI.DoesItemHaveSockets = DoesItemHaveSockets;

--[[
GameTooltip:HookScript("OnTooltipSetItem", function(self)
    local _, itemLink = self:GetItem();
    DoesItemHaveSockets(itemLink);
end);
--]]

local function GetAmmoDps(itemID)
    if not itemID then return 0 end;

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetItemByID(itemID);

    if not LEFT_FONT_STRINGS[3] then
        LEFT_FONT_STRINGS[3] = _G["NarciVirtualTooltipTextLeft3"];
    end

    if LEFT_FONT_STRINGS[3] then
        local text = LEFT_FONT_STRINGS[3]:GetText();
        if text then
            return tonumber(match(text, PATTERN_AMMO_DPS) or 0);
        else
            return 0
        end
    else
        return 0
    end
end

NarciAPI.GetAmmoDps = GetAmmoDps;


local STRENGTH = ITEM_MOD_STRENGTH_SHORT;
local AGILITY = ITEM_MOD_AGILITY_SHORT;
local STAMINA = ITEM_MOD_STAMINA_SHORT;
local INTELLECT = ITEM_MOD_INTELLECT_SHORT;
local SPIRIT = ITEM_MOD_SPIRIT_SHORT

local function GetItemStatsFromTooltip(itemLocation)
    --Get item stats from tooltip (to fix: "GetItemStats" API doesn't support items with random postfix)
    if not (itemLocation and DoesItemExist(itemLocation)) then return {} end

    local itemLink = C_Item.GetItemLink(itemLocation);

    TP:SetOwner(UIParent, "ANCHOR_PRESERVE");
    TP:SetHyperlink(itemLink);

    local _, _, _, itemEquipLoc, _, classID, subclassID = GetItemInfoInstant(itemLink);
    local matchWeapon;
    if classID == 2 then
        matchWeapon = true;
    end

    local data = {};

    data.ilvl = C_Item.GetCurrentItemLevel(itemLocation);

    local numLines = TP:NumLines();
    local fontString, text;
    local statsEnd;
    local lineProcessed;
    local statValue;

    for i = 3, numLines do
        lineProcessed = false;

        if not statsEnd then
            if not LEFT_FONT_STRINGS[i] then
                LEFT_FONT_STRINGS[i] = _G["NarciVirtualTooltipTextLeft"..i];
            end
            fontString = LEFT_FONT_STRINGS[i];
            if fontString then
                text = fontString:GetText();
                --sub(text, 1, 1) == "+" the text may have color code, thus the first character is |(124)
                statValue = match(text, "+(%d+)");
                if statValue then
                    statValue = tonumber(statValue);
                    if find(text, STRENGTH) then
                        data.strengh = statValue;
                        lineProcessed = true;
                    elseif find(text, AGILITY) then
                        data.agility = statValue;
                        lineProcessed = true;
                    elseif find(text, STAMINA) then
                        data.stamina = statValue;
                        lineProcessed = true;
                    elseif find(text, INTELLECT) then
                        data.intellect = statValue;
                        lineProcessed = true;
                    elseif find(text, SPIRIT) then
                        data.spirit = statValue;
                        lineProcessed = true;
                    end
                else
                    if statValue then
                        --last line has +, this one doesn't
                        statsEnd = true;
                    end
                end
            else
                break
            end
        end
    end

    return data
end

NarciAPI.GetItemStatsByTooltipItemLocation = GetItemStatsFromTooltip;