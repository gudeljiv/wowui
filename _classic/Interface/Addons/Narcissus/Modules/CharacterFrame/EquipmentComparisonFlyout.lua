local _, addon = ...
local API = addon.API;

--Parent: Narci_EquipmentFlyoutFrame (Narcissus.xml)
local ComparisonFrame, EquipmentFlyoutFrame;
local IS_GAP_ADJUSTED = false;
local COMPARISON_HEIGHT = 160;
local FORMAT_DIGIT = "%.2f";

local FormatLargeNumbers = NarciAPI.FormatLargeNumbers --BreakUpLargeNumbers;
local GetItemExtraEffect = NarciAPI.GetItemExtraEffect;
local IsItemSocketable = NarciAPI.IsItemSocketable;

local DoesItemExist = C_Item.DoesItemExist;
local GetItemLink = C_Item.GetItemLink;
local GetItemIcon = C_Item.GetItemIcon;
local GetItemName = C_Item.GetItemName;
local GetItemQuality = C_Item.GetItemQuality;
local GetItemInfoInstant = API.GetItemInfoInstant;

local GetCombatRating = GetCombatRating;
local GetCombatRatingBonus = GetCombatRatingBonus;

local IsItemDataCached = C_Item.IsItemDataCached;

local GetItemStatsByTooltipItemLocation = NarciAPI.GetItemStatsByTooltipItemLocation;


local STAT_NAME_ITEM_LEVEL = STAT_AVERAGE_ITEM_LEVEL;
local STAT_NAME_STRENGTH = _G["SPELL_STAT1_NAME"];
local STAT_NAME_AGILITY = _G["SPELL_STAT2_NAME"];
local STAT_NAME_STAMINA = _G["SPELL_STAT3_NAME"];
local STAT_NAME_INTELLCT = _G["SPELL_STAT4_NAME"];
local STAT_NAME_SPIRIT = _G["SPELL_STAT5_NAME"];


do
    local expansionID = NarciClassicAPI.GetExpansionID();
    if expansionID == 1 then
        function GetCombatRating()
            return 0
        end

        function GetCombatRatingBonus()
            return 0
        end
    end
end


local EventListner = CreateFrame("Frame");

local function RequestingItemData_OnUpdate(self, elapsed)
    self.t = self.t + elapsed;
    if self.t >= 0 then
        self.t = nil;
        self:SetScript("OnUpdate", nil);
        self:OnItemDataLoaded();
    end
end

function EventListner:RequestItemData(itemLocation)
    self.pendingItemLocation = itemLocation;
    self.t = -0.2;
    self:SetScript("OnUpdate", RequestingItemData_OnUpdate);
end

function EventListner:OnItemDataLoaded()
    if self.pendingItemLocation then
        Narci_Comparison_SetComparison(self.pendingItemLocation);
        self.pendingItemLocation = nil;
    end
end

function EventListner:ClearRequest()
    self:SetScript("OnUpdate", nil);
    self.pendingItemLocation = nil;
    self.t = nil;
end


local GetGemBorderTexture = NarciAPI.GetGemBorderTexture;
local GetSlotNameAndTexture = NarciAPI.GetSlotNameAndTexture;

local CR_ConvertRatio = {      --Combat Rating number/percent
    ["stamina"] = 10,              -- 1 stamina = 10 HP
};

Narci.ConvertRatio = CR_ConvertRatio;

local GetItemQualityColor = NarciAPI.GetItemQualityColor;

local function SetCombatRatingRatio()
    local _;
	local mastery, bonusCoeff = 0, 0--##GetMasteryEffect();
	local masteryBonus = 0 --##GetCombatRatingBonus(CR_MASTERY) * bonusCoeff;
	local masteryBase;
	if (masteryBonus > 0) then
        masteryBase = mastery - masteryBonus;
    else
        masteryBase = 0;
    end
    local critChance, critRating = Narci.GetEffectiveCrit();
	local extraCritChance = GetCombatRatingBonus(critRating);
	local critBase = critChance - extraCritChance;
	local versatilityBase = 0--##GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE);
    local hasteBase = GetHaste() - GetCombatRatingBonus(CR_HASTE_MELEE);
    CR_ConvertRatio.critBase = critBase;
    CR_ConvertRatio.hasteBase = hasteBase;
    CR_ConvertRatio.masteryBase = masteryBase;
    CR_ConvertRatio.versatilityBase = versatilityBase;

    local crit = math.max(GetCombatRating(CR_CRIT_MELEE), GetCombatRating(CR_CRIT_RANGED), GetCombatRating(CR_CRIT_SPELL));
    local critBonus = math.max(GetCombatRatingBonus(CR_CRIT_MELEE), GetCombatRatingBonus(CR_CRIT_RANGED), GetCombatRatingBonus(CR_CRIT_SPELL));
    local haste = GetCombatRating(CR_HASTE_MELEE);
    mastery = 0 --##GetCombatRating(CR_MASTERY);
    local versatility = 0 --##GetCombatRating(CR_VERSATILITY_DAMAGE_DONE);
    local stamina = UnitStat("player", LE_UNIT_STAT_STAMINA);
    local Health = UnitHealth("player");

    _, bonusCoeff = 0, 0--##GetMasteryEffect();
    masteryBonus = 0 --##GetCombatRatingBonus(CR_MASTERY) * bonusCoeff;

    if crit == 0 then
        CR_ConvertRatio.crit = 0;
    else
        CR_ConvertRatio.crit = critBonus / crit;
    end
    if haste == 0 then
        CR_ConvertRatio.haste = 0;
    else
        CR_ConvertRatio.haste = GetCombatRatingBonus(CR_HASTE_MELEE) / haste;
    end
    if mastery == 0 then
        CR_ConvertRatio.mastery = 0;
    else
        CR_ConvertRatio.mastery = masteryBonus / mastery;
    end
    if versatility == 0 then
        CR_ConvertRatio.versatility = 0;
    else
        CR_ConvertRatio.versatility = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) / versatility;
    end

    CR_ConvertRatio.stamina = 10 --Health / stamina;
    --[[
    print(STAT_CRITICAL_STRIKE.." "..math.floor(1/CR_ConvertRatio.crit + 0.5))
    print(STAT_HASTE.." "..math.floor(1/CR_ConvertRatio.haste + 0.5))
    print(STAT_MASTERY.." "..math.floor(1/CR_ConvertRatio.mastery + 0.5))
    print(STAT_VERSATILITY.." "..math.floor(1/CR_ConvertRatio.versatility + 0.5))
    --]]

    -----------------------
    --print("Combat Rating Ratio Refreshed")
end

local ColorTable = {
    Green = {r = 124, g = 197, b = 118},    --7cc576
    Red = {r = 255, g = 80, b = 80},        --ff5050 (1, 0.3137, 0.3137)
    Positive = {r = 98, g = 239, b = 165},
    Positive2 = {r = 135, g = 220, b = 153},
    Corrupt = {r = 148, g = 109, b = 209},  --946dd1
}

local function TextColor(Fontstring, color)
    local r, g, b = color.r/255, color.g/255, color.b/255
    Fontstring:SetTextColor(r, g, b);
end


local function ComparisonFrame_AdjustGap()
    local frame = ComparisonFrame;
    local defaultV1 = 60;
    local defaultV2 = 110;  --116
    local maxStringWidth = 60; --Default Gap is 80 = 60 + 20
    
    local statString = frame.StatFrames;
    for i=1, #statString do
        local tempWidth = statString[i].Label:GetWidth();
        if maxStringWidth < tempWidth then
            maxStringWidth = tempWidth;
        end
    end
    
    local ajustedV1 = maxStringWidth + 30;
    local ajustedV2 = math.floor(defaultV2 -(ajustedV1 - defaultV1));
    local extraWidth = 0;
    local minimumGap = 60;

    if ajustedV2 < minimumGap then
        extraWidth = math.floor(minimumGap - ajustedV2);
        ajustedV2 = minimumGap;
        frame:SetWidth(frame:GetWidth() + extraWidth)
    end

    frame.GuideLineV1:SetPoint("LEFT", ajustedV1, 0)
    frame.GuideLineV2:SetPoint("LEFT", frame.GuideLineV1, ajustedV2, 0)
    IS_GAP_ADJUSTED = true;
end


--[[
local function GetItemEnchant(itemLink)
    local EnchantID = 0;
    local _, a = string.find(itemLink, ":%d+:.-:")
    local _, b = string.find(itemLink, ":%d+:")

    if (b + 1) < (a -1) then
        EnchantID = string.sub(itemLink, b+1, a-1)
    end

    return tonumber(EnchantID)
end
--]]


local function CacheTooltip(itemLink)
    NarciCacheTooltip:SetHyperlink(itemLink)
end

local ItemStats = NarciAPI_GetItemStats;

local function DisplayComparison(frameIndex, name, number, baseNumber, ratio, customColor)
    local Textframe = ComparisonFrame["StatFrame"..frameIndex];
    Textframe.Label:SetText(name);

    --[[
    if not (number or baseNumber) then            --Set Number to "-"
        Textframe.Arrow:Hide();
        Textframe.NumDiff:Hide();
        Textframe.PctDiff:Hide();
        Textframe.Num:SetText("-");
        return;
    end
    --]]

    number = number or 0;
    baseNumber = baseNumber or 0;

    local differentialNumber = number - baseNumber;

    if differentialNumber > 0 then
        Textframe.Arrow:Show()
        Textframe.Arrow:SetTexCoord(0, 0.5, 0, 1)

        Textframe.NumDiff:Show();
        Textframe.PctDiff:Show();
        TextColor(Textframe.NumDiff, ColorTable.Green)
        TextColor(Textframe.PctDiff, ColorTable.Green)
    elseif differentialNumber < 0 then
        Textframe.Arrow:Show()
        Textframe.Arrow:SetTexCoord(0.5, 1, 0, 1)

        Textframe.NumDiff:Show();
        Textframe.PctDiff:Show();
        TextColor(Textframe.NumDiff, ColorTable.Red)
        TextColor(Textframe.PctDiff, ColorTable.Red)
    else
        Textframe.Arrow:Hide()
        Textframe.NumDiff:Hide();
        Textframe.PctDiff:Hide();
    end

    differentialNumber = math.abs(differentialNumber)

    local labelAlpha = 1;
    if number ~= 0 then
        Textframe.Num:SetText(number);
        Textframe:Show();
    else
        Textframe.Num:SetText("|cff808080-|r");
        labelAlpha = 0.6;
    end
    Textframe.NumDiff:SetText(differentialNumber);

    if customColor then
        Textframe.Label:SetTextColor(customColor[1], customColor[2], customColor[3], labelAlpha);
    else
        Textframe.Label:SetTextColor(0.92, 0.92, 0.92, labelAlpha);
    end

    if ratio then
        if name ~= STAT_NAME_STAMINA then
            Textframe.PctDiff:SetText(string.format(FORMAT_DIGIT, ratio*differentialNumber).."%");
        else
            Textframe.PctDiff:SetText(FormatLargeNumbers(ratio*differentialNumber));
        end
    else
        Textframe.PctDiff:SetText("");
    end
end

local function EmptyComparison()
    DisplayComparison(1, STAT_NAME_ITEM_LEVEL);
    DisplayComparison(2, STAT_NAME_STRENGTH);
    DisplayComparison(3, STAT_NAME_AGILITY);
    DisplayComparison(4, STAT_NAME_STAMINA);
    DisplayComparison(5, STAT_NAME_INTELLCT);
    DisplayComparison(6, STAT_NAME_SPIRIT);
    --DisplayComparison(7, STAT_VERSATILITY);
end

local function UntruncateText(frame, fontstring)
    local n = 1;
    frame:SetWidth(frame.WidthBAK)
    while fontstring:IsTruncated() do
        frame:SetWidth(frame.WidthBAK + 20*n);
        n = n + 1;
    end
end

local HEART_LEVEL = 0;
local CURRENT_SPEC = 1;
local MAX_TIER = 5;

local GetAllTierInfo = C_AzeriteEmpoweredItem.GetAllTierInfo;
local GetPowerInfo = C_AzeriteEmpoweredItem.GetPowerInfo;
local IsPowerSelected = C_AzeriteEmpoweredItem.IsPowerSelected;
local GetPowerText = C_AzeriteEmpoweredItem.GetPowerText;   --azeriteEmpoweredItemLocation, powerID, level
local IsPowerAvailableForSpec = C_AzeriteEmpoweredItem.IsPowerAvailableForSpec;
local TierInfos;

local function GetActiveTraits(itemLocation, itemButton)
    if not itemLocation then return; end
    local shouldCache = false;
    local PowerIDs, azeritePowerName, icon, unlockLevel, azeritePowerDescription;
    local ActiveTraits = {}  --[tier] = {PowerID, icon, name, description, unlockLevel}
    if (not DoesItemExist(itemLocation)) or (not C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(itemLocation)) then return; end
    TierInfos = GetAllTierInfo(itemLocation);
    if not TierInfos then return; end

    for i = 1, MAX_TIER do
        if (not TierInfos[i]) or (not TierInfos[i].azeritePowerIDs) then
            if shouldCache then
                if itemButton then
                    itemButton:Disable();
                    C_Timer.After(0.2, function()
                        itemButton:Enable();
                    end)
                end
            end
            return ActiveTraits;
        end
        ActiveTraits[i] = {}
        PowerIDs = TierInfos[i].azeritePowerIDs;
        unlockLevel = TierInfos[i].unlockLevel or 0;
        for k, PowerID in pairs(PowerIDs) do
            azeritePowerName, _, icon = GetSpellInfo(GetPowerInfo(PowerID) and GetPowerInfo(PowerID).spellID);
            azeritePowerDescription = GetPowerText(itemLocation, PowerID, 0);
            
            if not azeritePowerDescription.description or azeritePowerDescription.description == "" then
                shouldCache = true;
                --print("shoud cache".." "..azeritePowerName)
            end
            if IsPowerSelected(itemLocation, PowerID) then
                ActiveTraits[i] = {PowerID, icon, azeritePowerName, azeritePowerDescription.description};
                break;
            else
                ActiveTraits[i] = {PowerID, nil, "", ""};
            end
        end
        tinsert(ActiveTraits[i], unlockLevel);
    end
    if shouldCache then
        if itemButton then
            itemButton:Disable();
            C_Timer.After(0.2, function()
                itemButton:Enable();
            end)
        end
    end
    return ActiveTraits;
end

local TraitsCache = {};

local function BuildAzeiteTraitsFrame(TraitsFrame, itemLocation, itemButton)
    TraitsCache = GetActiveTraits(itemLocation, itemButton);
    if not TraitsCache then return; end

    local rightSpec = false;
    for i = 1, MAX_TIER do
        local button = TraitsFrame.Traits[i];
        button.Icon:Hide();
        if (TraitsCache[i]) and (TraitsCache[i][5]) then
            if TraitsCache[i][5] > HEART_LEVEL then
                button.Level:SetText(TraitsCache[i][5]);
                button.Level:Show();
                button.Border0:SetTexCoord(0.5, 0.75, 0, 1);            --Desaturated
                button.Border1:SetDesaturated(true);
            else
                button.Level:Hide();
                button.Icon:SetTexture(TraitsCache[i][2]);
                button.Icon:Show();
                rightSpec = IsPowerAvailableForSpec(TraitsCache[i][1], CURRENT_SPEC);
                if rightSpec then
                    button.Border0:SetTexCoord(0, 0.25, 0, 1);          --Saturated
                    button.Border1:SetDesaturated(false);
                    button.Icon:SetDesaturated(false);
                else
                    if TraitsCache[i][2] then                           --Hasn't pick traits
                        button.Border0:SetTexCoord(0.5, 0.75, 0, 1);    --Desaturated
                        button.Border1:SetDesaturated(true);
                        button.Icon:SetDesaturated(true);
                    else
                        button.Border0:SetTexCoord(0, 0.25, 0, 1);      --Saturated
                        button.Border1:SetDesaturated(false);
                        button.Icon:SetDesaturated(false);
                    end
                end
            end
            button:Show();

            if i == 1 then
                TraitsFrame.Name1:SetText(TraitsCache[i][3]);
                TraitsFrame.Description1:SetText(TraitsCache[i][4]);
                if rightSpec then
                    TraitsFrame.Description1:SetTextColor(0.9, 0.8, 0.5);
                else
                    TraitsFrame.Description1:SetTextColor(0.5, 0.5, 0.5);
                end
            elseif i == 2 then
                TraitsFrame.Name2:SetText(TraitsCache[i][3]);
                TraitsFrame.Description2:SetText(TraitsCache[i][4]);
                if rightSpec then
                    TraitsFrame.Description2:SetTextColor(0.9, 0.8, 0.5);
                else
                    TraitsFrame.Description2:SetTextColor(0.5, 0.5, 0.5);
                end           
            end
        else
            button.Border0:SetTexCoord(0.5, 0.75, 0, 1);            --Desaturated
            button.Border1:SetDesaturated(true);
            button:Hide();
        end
    end

    --Base Item--
    if not EquipmentFlyoutFrame.BaseItem then return; end 
    TraitsCache = GetActiveTraits(EquipmentFlyoutFrame.BaseItem);
    if not TraitsCache or EquipmentFlyoutFrame.BaseItem == itemLocation then 
        for i = 1, MAX_TIER do
            TraitsFrame.Traits[i].BaseTrait:Hide();
        end
        return;
    end
    for i = 1, MAX_TIER do
        local button = TraitsFrame.Traits[i];
        local tinybutton = button.BaseTrait;
        if (TraitsCache[i]) and (TraitsCache[i][5]) then
            if TraitsCache[i][2] then
                tinybutton.Icon:SetTexture(TraitsCache[i][2]);
                tinybutton:Show();
                button:Show();
            else
                tinybutton:Hide();
            end
        else
            tinybutton:Hide();
        end
    end

    wipe(TraitsCache);
end


function Narci_Comparison_SetComparison(itemLocation, itemButton)
    local frame = ComparisonFrame;
    local FlyOut = EquipmentFlyoutFrame;
    local slotName, slotTexture = GetSlotNameAndTexture(FlyOut.slotID);


    if not DoesItemExist(itemLocation) then
        frame.Label:SetText(CURRENTLY_EQUIPPED);
        frame.ItemName:SetText(EMPTY);
        frame.ItemName:SetTextColor(0.6, 0.6, 0.6);
        frame.EquipLoc:SetText(slotName)
        frame.Icon:SetTexture(slotTexture);
        frame.BonusButton1:Hide();
        frame.BonusButton2:Hide();
        EmptyComparison();
        EventListner:ClearRequest();
        return;
    end

    --it seems C_Item.IsItemDataCached does not include caching tooltip text, so we'll have to update the comparison tooltip by a timer.
    EventListner:RequestItemData(itemLocation);


    local itemLink = GetItemLink(itemLocation);
    CacheTooltip(itemLink);
    local itemIcon = GetItemIcon(itemLocation);
    local name = GetItemName(itemLocation);
    local quality = GetItemQuality(itemLocation);
    local r, g, b = GetItemQualityColor(quality);

    local stats = GetItemStatsByTooltipItemLocation(itemLocation) --ItemStats(itemLocation);
    local baseStats = GetItemStatsByTooltipItemLocation(FlyOut.BaseItem) --ItemStats(FlyOut.BaseItem);

    local _, _, itemSubType = GetItemInfoInstant(itemLink);

    frame.ItemName:SetText(name);
    frame.ItemName:SetTextColor(r, g, b);
    frame.Icon:SetTexture(itemIcon);
    if FlyOut.slotID then
        if FlyOut.slotID == -1 then
            return
        end
        frame.EquipLoc:SetText(slotName);
    end
    frame.Label:SetText(itemSubType);

    DisplayComparison(1, STAT_NAME_ITEM_LEVEL, stats.ilvl, baseStats.ilvl, nil, {1, 0.82, 0});
    DisplayComparison(2, STAT_NAME_STRENGTH, stats.strength, baseStats.strength);
    DisplayComparison(3, STAT_NAME_STAMINA, stats.stamina, baseStats.stamina, CR_ConvertRatio.stamina);
    DisplayComparison(4, STAT_NAME_AGILITY, stats.agility, baseStats.agility);
    DisplayComparison(5, STAT_NAME_INTELLCT, stats.intellect, baseStats.intellect);
    DisplayComparison(6, STAT_NAME_SPIRIT, stats.spirit, baseStats.spirit);
    --DisplayComparison(7, STAT_VERSATILITY, stats.versatility, baseStats.versatility, CR_ConvertRatio.versatility);

    NarciRefVirtualTooltip:SetHyperlink(itemLink)    --Used to hook the Pawn upgrade notification (if supported)

    local iconPos;
    if stats.GemIcon and stats.GemPos then
        iconPos = frame[stats.GemPos];
        if iconPos then
            frame.BonusButton1.BonusIcon:SetTexture(stats.GemIcon);
            frame.BonusButton1:ClearAllPoints();
            frame.BonusButton1:SetPoint("LEFT", iconPos.Num, "RIGHT", 4, 0);
            frame.BonusButton1:Show();
        else
            frame.BonusButton1:Hide();
        end
    else
        frame.BonusButton1:Hide();
    end

    if stats.EnchantPos then
        iconPos = frame[stats.EnchantPos];
        if iconPos then
            frame.BonusButton2.BonusIcon:SetTexture(136244);
            frame.BonusButton2:ClearAllPoints();
            if frame.BonusButton1:IsShown() and ( stats.GemPos == stats.EnchantPos)then
                frame.BonusButton2:SetPoint("LEFT", iconPos.Num, "RIGHT", 14, 0);
            else
                frame.BonusButton2:SetPoint("LEFT", iconPos.Num, "RIGHT", 4, 0);
            end
            frame.BonusButton2:Show();
        else
            frame.BonusButton2:Hide();
        end
    else
        frame.BonusButton2:Hide();
    end

    if not IS_GAP_ADJUSTED then
        ComparisonFrame_AdjustGap()
    end

    frame:SetFrameStrata("TOOLTIP");


    --Gem check
    local GemName, GemLink = IsItemSocketable(itemLink);

    if GemName then
        local itemSubClassID = 9;
        local _, gemID, gemIcon, borderTexture;
        if GemLink then
            gemID, _, _, _, gemIcon, _, itemSubClassID = GetItemInfoInstant(GemLink);
            borderTexture = GetGemBorderTexture(itemSubClassID, gemIcon);
        else
            borderTexture = GetGemBorderTexture(nil);
        end
        frame.GemSlot.GemBorder:SetTexture(borderTexture);
        frame.GemSlot.GemIcon:SetTexture(gemIcon);
        frame.GemSlot:Show();
        frame.GemSlot.GemIcon:Show();
    else
        frame.GemSlot:Hide();
    end

    --SubTooltip
    local SubTooltip = frame.SubTooltip;
    local TraitsFrame = SubTooltip.AzeriteTraits;
    local extraText = SubTooltip.Description;
    local headerText = SubTooltip.Header.Text;

    --Azerite Empowered Items
    if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(itemLocation) then
        headerText:SetText(NARCI_AZERITE_POWERS);
        SubTooltip.Header:SetWidth(math.max(74, headerText:GetWidth() + 14))
        BuildAzeiteTraitsFrame(TraitsFrame, itemLocation, itemButton);
        extraText:Hide();
        TraitsFrame:Show();
        SubTooltip:Show();
        return;
    else
        TraitsFrame:Hide();
    end

    --Extra Effect (Trinket/Usable)
    --print("CacheCheck Extra: "..tostring(C_Item.IsItemDataCachedByID(itemLink)))
    local headline, str = GetItemExtraEffect(itemLink, false);
    if not headline then
        headline, str = GetItemExtraEffect(itemLink)
    end

    if headline then
        TextColor(extraText, ColorTable.Positive2);
        extraText:SetText(str);
        headerText:SetText(headline);
        SubTooltip.Header:SetWidth(math.max(74, headerText:GetWidth() + 14))
        extraText:Show();
        SubTooltip:Show();
    else
        extraText:Hide();
        SubTooltip:Hide();
    end

    UntruncateText(SubTooltip, SubTooltip.Description)

    ----
end

--FlyOut Tooltip
local function UpdateSpectIDAndPrimaryStat()
    local PrimaryStatsList = {
        [LE_UNIT_STAT_STRENGTH] = NARCI_STAT_STRENGTH,
        [LE_UNIT_STAT_AGILITY] = NARCI_STAT_AGILITY,
        [LE_UNIT_STAT_INTELLECT] = NARCI_STAT_INTELLECT,
    };

    local currentSpec = nil --##GetSpecialization() or 1;
    local _, primaryStatID;
    if currentSpec then
        CURRENT_SPEC, _, _, _, _, primaryStatID = GetSpecializationInfo(currentSpec);
        PRIMARY_STAT_NAME = PrimaryStatsList[primaryStatID] or PRIMARY_STAT_NAME;
    end
end




EventListner:RegisterEvent("PLAYER_ENTERING_WORLD");
EventListner:RegisterEvent("PLAYER_LEVEL_UP");
--##EventListner:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
--##EventListner:RegisterEvent("AZERITE_ITEM_POWER_LEVEL_CHANGED");
EventListner:SetScript("OnEvent",function(self,event,...)
    if event == "PLAYER_ENTERING_WORLD" then
        self:UnregisterEvent(event);
        ComparisonFrame = Narci_Comparison;
        EquipmentFlyoutFrame = Narci_EquipmentFlyoutFrame;
    end

    if event ~= "AZERITE_ITEM_POWER_LEVEL_CHANGED" then
        if ( not self.pauseUpdate ) then
            self.pauseUpdate = true;
            C_Timer.After(0.5, function()    -- only want 1 update per 0.5s
                self.pauseUpdate = nil;
                SetCombatRatingRatio();
            end)
        end
    end

    if event == "ACTIVE_TALENT_GROUP_CHANGED" then
        UpdateSpectIDAndPrimaryStat();
    end

    if event == "AZERITE_ITEM_POWER_LEVEL_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
        local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem();
        if azeriteItemLocation then
            --Credit: flowerpew     Bug Fix: Can't retrieve level if Heart of Azeroth is in the bank
            if AzeriteUtil.IsAzeriteItemLocationBankBag(azeriteItemLocation) then
                HEART_LEVEL = 0;
            else
                HEART_LEVEL = C_AzeriteItem.GetPowerLevel(azeriteItemLocation) or 0;
            end
        else
            HEART_LEVEL = 0;
        end
        UpdateSpectIDAndPrimaryStat();
    end
end)


function Narci_Comparison_Resize()
    local frame = ComparisonFrame;
    local extraHeight = math.floor(frame.PawnText:GetHeight() + frame.ItemName:GetHeight() + 0.5)
    frame:SetHeight(COMPARISON_HEIGHT + extraHeight)
    frame.Icon:SetWidth(frame:GetHeight());
end


function Narci_CreateAzeriteTraitTooltip(self)
    self.Traits = { self.Trait1 };
    local maximumTraits = 5;
    local offset = 1;
    local startOffset = 8;
    local numButtons = 0;
    local trait;
    for i = 2, maximumTraits do
        trait = CreateFrame("Button", nil, self, "Narci_SubTooltip_Trait_Template");
        trait:SetPoint("LEFT", self.Traits[i-1], "RIGHT", offset, 0);
        tinsert(self.Traits, trait);
    end
end

function Narci:GetCombatRatings()
    local NA = "N/A";
    local crit = CR_ConvertRatio.crit;
    local haste = CR_ConvertRatio.haste;
    local mastery = CR_ConvertRatio.mastery;
    local versatility = CR_ConvertRatio.versatility;
    crit = math.floor( (1 / crit*100 + 0.5)) / 100 or NA;
    haste = math.floor( (1 / haste*100 + 0.5)) / 100 or NA;
    mastery = math.floor( (1 / mastery*100 + 0.5)) / 100 or NA;
    versatility = math.floor( (1 / versatility*100 + 0.5)) / 100 or NA;

    local YELLOW = "|cFFFFD100";
    local GREY = "|cffa6a6a6";
    local headline = "Conversion Rate";
    local str = string.format("1 Percentage of Stat requires:\nCrit: %s\nHaste: %s\nMastery: %s\nVersatility: %s", crit, haste, mastery, versatility);
    
    print(YELLOW.."1% Stat Requires:")
    print(crit..GREY.."  Critical Strike |r");
    print(haste..GREY.."  Haste |r");
    print(mastery..GREY.."  Mastery |r");
    print(versatility..GREY.."  Versatility |r");
    print(GREY.."1 Stamina  |r"..CR_ConvertRatio.stamina.." HP");
    return str;
end

local function ConvertRatingToPercentage(name, value)
    if CR_ConvertRatio[name] then
        return  string.format(" (%.2f%%)", math.floor( 100 * CR_ConvertRatio[name] * value )/100);
    else
        return ""
    end
end

NarciAPI.ConvertRatingToPercentage = ConvertRatingToPercentage;


--[[
hooksecurefunc("DressUpItemLink", function(link)
    local str = string.match(link, "item[%-?%d:]+")
    local _, a = string.find(link, ":%d+:.-:")
    local _, b = string.find(link, ":%d+:")
    local strp = nil;
    if b + 1 < a -1 then
        strp = string.sub(link, b+1, a-1)
    end

    --local EnchantID = strp.match(strp, "%d%d+")
    --print(str)
    --print(strp)
end)
--]]

--[[
function PrintStats(slotID)
    --GetItemStats(C_Item.GetItemLink(ItemLocation:CreateFromEquipmentSlot(slotID)))
    local _, GemLink = GetItemGem(C_Item.GetItemLink(ItemLocation:CreateFromEquipmentSlot(slotID)), 1)
    print(GemLink)
    GemStats = GetItemStats(GemLink);
end
--]]