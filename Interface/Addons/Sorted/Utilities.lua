local DEMO = false -- For screenshot taking with meme items and player names
function Sorted_IsDemo()
    return DEMO
end
if DEMO then
    local f = CreateFrame("Frame", "White", UIParent)
    f:SetAllPoints()
    f:SetFrameStrata("FULLSCREEN")
    local t = f:CreateTexture("")
    t:SetTexture("Interface\\GLUES\\Models\\UI_OrcClan\\White8x8")
    t:SetAllPoints()
end
Sorted_DemoData = {
    {
        ["realm"]=GetRealmName(),
        ["name"]="Illidan",
        ["class"]="DEMONHUNTER",
        ["level"]="70",
        ["race"]="Night Elf",
        ["faction"]="Alliance"
    },
    {
        ["realm"]=GetRealmName(),
        ["name"]="Arthas",
        ["class"]="DEATHKNIGHT",
        ["level"]="80",
        ["race"]="Human",
        ["faction"]="Alliance"
    },
    {
        ["realm"]=GetRealmName(),
        ["name"]="Anduin",
        ["class"]="PALADIN",
        ["level"]="120",
        ["race"]="Human",
        ["faction"]="Alliance"
    },
    {
        ["realm"]=GetRealmName(),
        ["name"]="Jaina",
        ["class"]="MAGE",
        ["level"]="110",
        ["race"]="Human",
        ["faction"]="Alliance"
    },
    {
        ["realm"]=GetRealmName(),
        ["name"]="Thrall",
        ["class"]="SHAMAN",
        ["level"]="90",
        ["race"]="Orc",
        ["faction"]="Horde"
    },
    {
        ["realm"]=GetRealmName(),
        ["name"]="Tyrande",
        ["class"]="PRIEST",
        ["level"]="60",
        ["race"]="Night Elf",
        ["faction"]="Alliance"
    },
    {
        ["realm"]=GetRealmName(),
        ["name"]="Gul'dan",
        ["class"]="WARLOCK",
        ["level"]="100",
        ["race"]="Orc",
        ["faction"]="Horde"
    },
    {
        ["realm"]=GetRealmName(),
        ["name"]="Garona",
        ["class"]="ROGUE",
        ["level"]="60",
        ["race"]="Orc",
        ["faction"]="Horde"
    },
}

-- Detect Classic WoW
local classic = string.sub(GetBuildInfo(), 1, 1) == "1"
function Sorted_IsClassic()
    return classic
end
local bfa = string.sub(GetBuildInfo(), 1, 1) == "8"
function Sorted_IsBfA()
    return bfa
end
local shadowlands = string.sub(GetBuildInfo(), 1, 1) == "9"
function Sorted_IsShadowlands()
    return shadowlands
end


-- Settings
Sorted_settingsProfiles = {}
Sorted_defaultSettings = {   -- Defaults
    ["scale"] = 1.1,
    ["iconSize"] = 21,
    ["backdropAlpha"] = 1,
    ["font"] = "Friz Quadrata TT",
    ["fontSize"] = 0,
    ["smoothScrolling"] = 2,
    ["keepFilters"] = 2,
    ["animations"] = 2,
    ["favoritesOnTop"] = 2,
    ["combineStacks"] = 1,
    ["fontOutline"] = 0,
    ["categoriesWidth"] = 120,
    ["categoriesUseIcons"] = 1,
    ["profileName"] = Sorted.Localize("CONFIG_PROFILES_DEFAULT_NAME"),
    ["scrollSpeed"] = 3,
    ["smoothingAmount"] = 0.15,
    ["tooltipDelay"] = 0.01,
    ["iconBorders"] = 1,
    ["padding"] = 2,
}

  -- Default fonts
local clientLocale = GetLocale()
local fontPath = "Fonts\\FRIZQT__.ttf"
if clientLocale == "koKR" then
    fontPath = "Fonts\\K_Pagetext.ttf"
elseif clientLocale == "zhCN" then
    fontPath = "Fonts\\ARKai_T.ttf"
elseif clientLocale == "zhTW" then
    fontPath = "Fonts\\blei00d.ttf"
elseif clientLocale == "ruRU" then
    fontPath = "Fonts\\MORPHEUS_CYR.ttf"
end
local LSM = LibStub("LibSharedMedia-3.0")
for k,v in pairs(LSM:List("font")) do
    if fontPath == LSM:Fetch("font", v) then
        Sorted_defaultSettings["font"] = v
    end
end


local function Sorted_GetSettings(guid)
    if not guid then guid = UnitGUID("player") end
    local data = Sorted_GetData(guid)
    if not data then
        return nil
    end
    local settings = Sorted_settingsProfiles[data.settingsProfile]
    if not settings then
        Sorted_GetData(guid).settingsProfile = Sorted_CreateNewSettingsProfile(Sorted_GetData(guid).name.."  ("..Sorted_GetData(guid).realm..")")
        settings = Sorted_settingsProfiles[Sorted_GetData(guid).settingsProfile]
    end
    return settings
end

function SortedSettings_SetDefault(self)
    for k,v in pairs(Sorted_defaultSettings) do
       self[k] = v
    end
end

function Sorted_CreateCopyOfSettingsProfile(origIndex)
    local newIndex = Sorted_CreateNewSettingsProfile(Sorted_settingsProfiles[origIndex].profileName.." - Copy")
    local originalSettings = Sorted_settingsProfiles[origIndex]
    local newSettings = Sorted_settingsProfiles[newIndex]
    for k,v in pairs(originalSettings) do
        if k ~= "profileName" then
            if type(v) == "table" then
                newSettings[k] = {}
                Sorted_CopyTable(v, newSettings[k])
            else
                newSettings[k] = v
            end
        end
    end
    return newIndex
end

function Sorted_CreateNewSettingsProfile(name)
    local index = 0
    for k, v in pairs(Sorted_settingsProfiles) do
        if k > index then
            index = k
        end
    end
    index = index + 1
    Sorted_settingsProfiles[index] = {}
    if not name then
        Sorted_settingsProfiles[index].profileName = UnitName("player").."  ("..GetRealmName()..")"
    else
        Sorted_settingsProfiles[index].profileName = name
    end
    return index
end

function Sorted_GetSetting(setting, guid)
    local t = Sorted_GetSettings(guid)
    if not t then return Sorted_defaultSettings[setting] end
    if not t[setting] then
        if setting == "categories" then
            t[setting] = {}
            Sorted_CopyTable(Sorted_defaultCategories, t[setting])
        else
            t[setting] = Sorted_defaultSettings[setting]
        end
    end
    return t[setting]
end

function Sorted_SetSetting(setting, value, guid)
    Sorted_GetSettings(guid)[setting] = value
end

function Sorted_ReloadAllSettings()
    Sorted_UpdateFonts()
    Sorted_SetScale(Sorted_GetSetting("scale"))
    SortedFrameRightPanel_Update()
    if not Sorted_GetData(UnitGUID("player")).minimized then
        SortedFrame_MinimizeRightPanel()
        SortedFrame_MaximizeRightPanel()
    else
        SortedFrame_MinimizeRightPanel()
    end
    Sorted_UpdateBackdropAlpha()
    Sorted_UpdateItemButtons()
    --Sorted_SelectCategoryButton(nil)
    SortedFilterButtons_Update(SortedFrameFilterButtons)
    SortedSubcategoryFrame_Update()
    Sorted_FilterItems()
    Sorted_UpdateIconBorders()
    Sorted_ScrollToTop()
    Sorted_UpdateFrameSizes()
    SortedMoneyText:UpdateMoneyText()
end

function Sorted_UpdateFonts()
    local flags
    local shadowX, shadowY
    if Sorted_GetSetting("fontOutline") > 0 then
        flags = "OUTLINE"
        shadowX, shadowY = 0, 0
        if Sorted_GetSetting("fontOutline") > 1 then
            flags = "THICKOUTLINE"
        end
    else
        shadowX, shadowY = 2, -2
    end
    local sizeMod = Sorted_GetSetting("fontSize")
    local path = Sorted_GetFontPath(Sorted_GetSetting("font"))
    SortedSmallFont:SetFont(path, 10 + sizeMod, flags)
    Sorted11Font:SetFont(path, 11 + sizeMod, flags)
    Sorted12Font:SetFont(path, 12 + sizeMod, flags)
    Sorted13Font:SetFont(path, 13 + sizeMod, flags)
    SortedButtonFont:SetFont(path, 10 + sizeMod, flags)
    SortedCheckboxFont:SetFont(path, 10 + sizeMod, flags)
    SortedTitleFont:SetFont(path, 12 + sizeMod, flags)
    SortedTabFont:SetFont(path, 12 + sizeMod, flags)
    SortedTabSelectedFont:SetFont(path, 12 + sizeMod, flags)

    SortedSmallFont:SetShadowOffset(shadowX, shadowY)
    Sorted11Font:SetShadowOffset(shadowX, shadowY)
    Sorted12Font:SetShadowOffset(shadowX, shadowY)
    Sorted13Font:SetShadowOffset(shadowX, shadowY)
    SortedButtonFont:SetShadowOffset(shadowX, shadowY)
    SortedCheckboxFont:SetShadowOffset(shadowX, shadowY)
    SortedTitleFont:SetShadowOffset(shadowX, shadowY)
    SortedTabFont:SetShadowOffset(shadowX, shadowY)
    SortedTabSelectedFont:SetShadowOffset(shadowX, shadowY)

    SortedFrameTabsMenu:UpdateWidth()
    SortedTabsFrame:UpdateWidths()
end

function Sorted_UpdateIconBorders()
    if Sorted_GetSetting("iconBorders") == 1 then
        for _, itemList in pairs(Sorted_itemLists) do
            for _, itemButton in pairs(itemList.itemButtons) do
                itemButton.iconGlow:Hide()
            end
        end
    else
        for _, itemList in pairs(Sorted_itemLists) do
            for _, itemButton in pairs(itemList.itemButtons) do
                if not itemButton.filtered then
                    itemButton.iconGlow:Show()
                end
            end
        end
    end
end



function Sorted_TransmogCollected(itemID, itemLink)
    local _, sourceID = C_TransmogCollection.GetItemInfo(itemLink)
    if not sourceID then
        sourceID = C_TransmogCollection.GetItemInfo(itemID)
    end
    if sourceID then
        local categoryID, visualID, canEnchant, icon, isCollected, itemLink, transmogLink = C_TransmogCollection.GetAppearanceSourceInfo(sourceID)
        if isCollected then
            return 4
        end
        for _, sourceID in pairs(C_TransmogCollection.GetAllAppearanceSources(visualID)) do
            categoryID, visualID, canEnchant, icon, isCollected, itemLink, transmogLink = C_TransmogCollection.GetAppearanceSourceInfo(sourceID)
            if isCollected then
                return 3
            end
        end
        if C_TransmogCollection.PlayerCanCollectSource(sourceID) then
            return 2
        else
            return 1
        end
    end
    return 0
end





table.insert(UISpecialFrames, "SortedConfigFrame")


function Sorted_GetFonts()
    return LSM:List("font")
end
function Sorted_GetFontPath(font)
    return LSM:Fetch("font", font)
end


function Sorted_CurrentPlayerName()
    if DEMO then
        if Sorted_currentPlayerSelected then
            return "Illidan"
        else
            return "Arthas"
        end
    else
        return UnitName("player")
    end
end

local SORTED_ITEM_QUALITY_COLORS = {
    [0] = { r=0.6,  g=0.6,  b=0.6  }, -- Poor
    [1] = { r=0.95, g=0.95, b=0.95 }, -- Common
    [2] = { r=0.45, g=1,    b=0.1  }, -- Uncommon
    [3] = { r=0,    g=0.65, b=1    }, -- Rare
    [4] = { r=0.9,  g=0.4,  b=1    }, -- Epic
    [5] = { r=1,    g=0.55, b=0.15 }, -- Legendary
    [6] = { r=1,    g=0.85, b=0.55 }, -- Artifact
    [7] = { r=0.25, g=0.9,  b=1    }, -- Heirloom
    [8] = { r=1,    g=0.8,  b=0    }  -- WoW Token
}
function Sorted_GetItemQualityColor(itemQuality)
    if itemQuality then
        return SORTED_ITEM_QUALITY_COLORS[itemQuality].r, SORTED_ITEM_QUALITY_COLORS[itemQuality].g, SORTED_ITEM_QUALITY_COLORS[itemQuality].b
    else
        return 1, 1, 1
    end
end

local SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS = {
    [0] = ITEM_QUALITY_COLORS[0],   -- Poor
    [1] = ITEM_QUALITY_COLORS[1],   -- Common
    [2] = {r=0.2,  g=1,    b=0   }, -- Uncommon
    [3] = {r=0,    g=0.6,  b=1   }, -- Rare
    [4] = {r=0.9,  g=0,    b=1   }, -- Epic
    [5] = {r=1,    g=0.3,  b=0.0 }, -- Legendary
    [6] = {r=1,    g=0.75, b=0.3 }, -- Artifact
    [7] = {r=0.15, g=1,    b=1   }, -- Heirloom
    [8] = {r=1,    g=0.8,  b=0   }  -- WoW Token
}
function Sorted_GetItemQualityHighlightColor(itemQuality)
    return SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS[itemQuality].r, SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS[itemQuality].g, SORTED_ITEM_QUALITY_HIGHLIGHT_COLORS[itemQuality].b
end

local SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS = {}
-- Generate highlight text colours that are good enough for most quality levels
for k,v in pairs(SORTED_ITEM_QUALITY_COLORS) do
    SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[k] = {
        r = math.sqrt(v.r),
        g = math.sqrt(v.g),
        b = math.sqrt(v.b)
    }
end
SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[3] = {r=0.45, g=0.82, b=1}
SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[7] = {r=0.75, g=1, b=1}
function Sorted_GetItemQualityHighlightTextColor(itemQuality)
    return SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[itemQuality].r, SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[itemQuality].g, SORTED_ITEM_QUALITY_HIGHLIGHT_TEXT_COLORS[itemQuality].b
end

local SORTED_BAG_TYPES = {
    [0] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_BAG"),
    [1] = Sorted.Localize("SUBFILTER_SUBTYPE_QUIVER_QUIVER"),
    [2] = Sorted.Localize("SUBFILTER_SUBTYPE_QUIVER_AMMO_POUCH"),
    [4] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_SOUL"),
    [8] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_LEATHERWORKING"),
    [16] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_INSCRIPTION"),
    [32] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_HERB"),
    [64] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_ENCHANTING"),
    [128] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_ENGINEERING"),
    [256] = KEYRING,
    [512] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_GEM"),
    [1024] = Sorted.Localize("SUBFILTER_SUBTYPE_CONTAINER_MINING")
}
function Sorted_GetBagTypeName(itemFamily)
    return SORTED_BAG_TYPES[itemFamily]
end




local SORTED_ALLCONTAINERS = {
    ["BANK"] = { BANK_CONTAINER },
    ["BAGS"] = { BACKPACK_CONTAINER },
    ["ALL"] = { BACKPACK_CONTAINER, BANK_CONTAINER }
}
for i = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do 
    table.insert(SORTED_ALLCONTAINERS["BANK"], i) 
    table.insert(SORTED_ALLCONTAINERS["ALL"], i) 
    SORTED_ALLCONTAINERS["CONTAINER"..i] = { i }
end
for i = 1, NUM_BAG_SLOTS do 
    table.insert(SORTED_ALLCONTAINERS["BAGS"], i) 
    table.insert(SORTED_ALLCONTAINERS["ALL"], i) 
    SORTED_ALLCONTAINERS["CONTAINER"..i] = { i }
end
if Sorted_IsClassic() then
    SORTED_ALLCONTAINERS["KEYRING"] = { KEYRING_CONTAINER }
    table.insert(SORTED_ALLCONTAINERS["ALL"], KEYRING_CONTAINER)
else
    SORTED_ALLCONTAINERS["REAGENT"] = { REAGENTBANK_CONTAINER }
    table.insert(SORTED_ALLCONTAINERS["ALL"], REAGENTBANK_CONTAINER)
end
function Sorted_ContainersOfType(type)
    return SORTED_ALLCONTAINERS[type]
end
function Sorted_GetContainerType(container)
    for containerType, t in pairs(SORTED_ALLCONTAINERS) do
        for k, containerID in pairs(t) do
            if containerType~="ALL" and string.sub(containerType, 1, 9) ~= "CONTAINER" and containerID == container then
                return containerType
            end
        end
    end
end
function Sorted_ContainerIsType(container, type)
    for _, containerID in pairs(Sorted_ContainersOfType(type)) do
        if container == containerID then
            return true
        end
    end
    return false
end
function Sorted_ItemGoesInBag(itemID, containerID)
    if containerID == BACKPACK_CONTAINER or containerID == BANK_CONTAINER then return true end
    if containerID == KEYRING_CONTAINER then
        return GetItemFamily(itemID) == 256
    else
        if GetContainerNumSlots(containerID) > 0 then
            local itemFamily = GetItemFamily(itemID)
            local containerFamily = GetItemFamily(GetInventoryItemID("player", ContainerIDToInventoryID(containerID)))
            if containerFamily == 0 then return true end
            return bit.band(itemFamily, containerFamily) ~= 0 and select(9, GetItemInfo(itemID)) ~= "INVTYPE_BAG"
        end
    end
end



local Sorted_StatSearchStrings = {
    ["ITEM_MOD_STAMINA"] = {"stam","stamina"},
    ["ITEM_MOD_STAMINA_SHORT"] = {"stam","stamina"},
    ["ITEM_MOD_STRENGTH"] = {"str","strength"},
    ["ITEM_MOD_STRENGTH_SHORT"] = {"str","strength"},
    ["ITEM_MOD_AGILITY"] = {"agi","agility"},
    ["ITEM_MOD_AGILITY_SHORT"] = {"agi","agility"},
    ["ITEM_MOD_INTELLECT"] = {"int","intellect"},
    ["ITEM_MOD_INTELLECT_SHORT"] = {"int","intellect"},
    ["ITEM_MOD_SPIRIT"] = {"spirit"},
    ["ITEM_MOD_SPIRIT_SHORT"] = {"spirit"},
    ["ITEM_MOD_ARMOR_PENETRATION_RATING"] = {"penetration"},
    ["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = {"penetration"},
    ["ITEM_MOD_ATTACK_POWER"] = {"att","attack","power"},
    ["ITEM_MOD_ATTACK_POWER_SHORT"] = {"att","attack","power"},
    ["ITEM_MOD_MELEE_ATTACK_POWER_SHORT"] = {"att","attack","melee","power"},
    ["ITEM_MOD_RANGED_ATTACK_POWER"] = {"att","attack","range","ranged","power"},
    ["ITEM_MOD_RANGED_ATTACK_POWER_SHORT"] = {"att","attack","range","ranged","power"},
    ["ITEM_MOD_BLOCK_RATING"] = {"block"},
    ["ITEM_MOD_BLOCK_RATING_SHORT"] = {"block"},
    ["ITEM_MOD_BLOCK_VALUE"] = {"block"},
    ["ITEM_MOD_BLOCK_VALUE_SHORT"] = {"block"},
    ["ITEM_MOD_CRIT_MELEE_RATING"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_MELEE_RATING_SHORT"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_RANGED_RATING"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_RANGED_RATING_SHORT"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_RATING"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_RATING_SHORT"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_SPELL_RATING"] = {"crit","critical"},
    ["ITEM_MOD_CRIT_SPELL_RATING_SHORT"] = {"crit","critical"},
    ["ITEM_MOD_CR_AVOIDANCE_SHORT"] = {"avoid","avoidance"},
    ["ITEM_MOD_CR_SPEED_SHORT"] = {"speed"},
    ["ITEM_MOD_DEFENSE_SKILL_RATING"] = {"defense"},
    ["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = {"defense"},
    ["ITEM_MOD_HASTE_MELEE_RATING"] = {"haste"},
    ["ITEM_MOD_HASTE_MELEE_RATING_SHORT"] = {"haste"},
    ["ITEM_MOD_HASTE_RANGED_RATING"] = {"haste"},
    ["ITEM_MOD_HASTE_RANGED_RATING_SHORT"] = {"haste"},
    ["ITEM_MOD_HASTE_RATING"] = {"haste"},
    ["ITEM_MOD_HASTE_RATING_SHORT"] = {"haste"},
    ["ITEM_MOD_HASTE_SPELL_RATING"] = {"haste"},
    ["ITEM_MOD_HASTE_SPELL_RATING_SHORT"] = {"haste"},
    ["ITEM_MOD_HEALTH"] = {"health"},
    ["ITEM_MOD_HEALTH_SHORT"] = {"health"},
    ["ITEM_MOD_HEALTH_REGEN"] = {"health"},
    ["ITEM_MOD_HEALTH_REGENERATION"] = {"health"},
    ["ITEM_MOD_HEALTH_REGENERATION_SHORT"] = {"health"},
    ["ITEM_MOD_HEALTH_REGEN_SHORT"] = {"health"},
    ["ITEM_MOD_HIT_MELEE_RATING"] = {"hit"},
    ["ITEM_MOD_HIT_MELEE_RATING_SHORT"] = {"hit"},
    ["ITEM_MOD_HIT_RANGED_RATING"] = {"hit"},
    ["ITEM_MOD_HIT_RANGED_RATING_SHORT"] = {"hit"},
    ["ITEM_MOD_HIT_RATING"] = {"hit"},
    ["ITEM_MOD_HIT_RATING_SHORT"] = {"hit"},
    ["ITEM_MOD_HIT_SPELL_RATING"] = {"hit"},
    ["ITEM_MOD_HIT_SPELL_RATING_SHORT"] = {"hit"},
    ["ITEM_MOD_MANA"] = {"mana"},
    ["ITEM_MOD_MANA_SHORT"] = {"mana"},
    ["ITEM_MOD_MANA_REGENERATION"] = {"mana"},
    ["ITEM_MOD_MANA_REGENERATION_SHORT"] = {"mana"},
    ["ITEM_MOD_MASTERY_RATING"] = {"mast","master","mastery"},
    ["ITEM_MOD_MASTERY_RATING_SHORT"] = {"mast","master","mastery"},
    ["ITEM_MOD_MASTERY_RATING_SPELL"] = {"mast","master","mastery"},
    ["ITEM_MOD_MASTERY_RATING_TWO_SPELLS"] = {"mast","master","mastery"},
    ["ITEM_MOD_PARRY_RATING"] = {"parry"},
    ["ITEM_MOD_PARRY_RATING_SHORT"] = {"parry"},
    ["ITEM_MOD_POWER_REGEN0_SHORT"] = {"mana","mp5"},
    ["ITEM_MOD_POWER_REGEN1_SHORT"] = {"rage"},
    ["ITEM_MOD_POWER_REGEN2_SHORT"] = {"focus"},
    ["ITEM_MOD_POWER_REGEN3_SHORT"] = {"energy"},
    ["ITEM_MOD_PVP_POWER"] = {"pvp"},
    ["ITEM_MOD_PVP_POWER_SHORT"] = {"pvp"},
    ["ITEM_MOD_PVP_PRIMARY_STAT_SHORT"] = {"pvp"},
    ["ITEM_MOD_RESILIENCE_RATING"] = {"resil","resilience"},
    ["ITEM_MOD_RESILIENCE_RATING_SHORT"] = {"resil","resilience"},
    ["ITEM_MOD_SPELL_DAMAGE_DONE"] = {"spell","dmg","damage"},
    ["ITEM_MOD_SPELL_DAMAGE_DONE_SHORT"] = {"spell","dmg","damage"},
    ["ITEM_MOD_SPELL_HEALING_DONE"] = {"heal","healing"},
    ["ITEM_MOD_SPELL_HEALING_DONE_SHORT"] = {"heal","healing"},
    ["ITEM_MOD_SPELL_PENETRATION"] = {"spell","penetration"},
    ["ITEM_MOD_SPELL_PENETRATION_SHORT"] = {"spell","penetration"},
    ["ITEM_MOD_SPELL_POWER"] = {"spell","power"},
    ["ITEM_MOD_SPELL_POWER_SHORT"] = {"spell","power"},
    ["ITEM_MOD_VERSATILITY"] = {"vers","versa","versatile","versatility"},
    ["ITEM_MOD_CR_LIFESTEAL_SHORT"] = {"leech"},
}
function Sorted_SearchStatTable(statTable, searchString)
    if statTable then
        searchString = searchString:lower()
        for word in searchString:gmatch("%S+") do
            local wordFound = false
            for statName,v in pairs(statTable) do
                if Sorted_StatSearchStrings[statName] then
                    for k,s in pairs(Sorted_StatSearchStrings[statName]) do
                        if word==s then
                            wordFound = true
                        end
                    end
                end
            end
            if not wordFound then return false end
        end
        return true
    end
    return false
end

function Sorted_GetClassColor(class)
    return (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
end

function Sorted.GetRaceName(raceID) 
    if type(raceID) == "number" then
        return C_CreatureInfo.GetRaceInfo(raceID).raceName
    else
        return raceID
    end
end

local bindTypes = {
    [1] = Sorted.Localize("SUBFILTER_BINDING_ON_PICKUP_SHORT"),
    [2] = Sorted.Localize("SUBFILTER_BINDING_ON_EQUIP_SHORT"),
    [3] = Sorted.Localize("SUBFILTER_BINDING_ON_USE_SHORT"),
    [4] = Sorted.Localize("SUBFILTER_BINDING_ON_PICKUP_SHORT"),
    [9] = Sorted.Localize("SUBFILTER_BINDING_SOULBOUND_SHORT"),
}
local bindColors = {
    [1] = "|cffffaa55",
    [2] = "|cffffee77",
    [3] = "|cffee99bb",
    [4] = "|cffffaa55",

    -- Soulbound
    [5] = "|cff888899",
    [6] = "|cffaa8877",
    [7] = "|cffbbaa66",
    [8] = "|cffaa7799",
    [9] = "|cffaa8877",
}
function Sorted_FormatBindType(bindType, bound)
    if bound then 
        return bindColors[bindType + 5]..bindTypes[9]
    elseif bindType > 0 then
        return bindColors[bindType]..bindTypes[bindType]
    else
        return ""
    end
end

local expansionColors = {
    [0] = "|cffffe517",
    [1] = "|cff95c257",
    [2] = "|cff67baf5",
    [3] = "|cffff9924",
    [4] = "|cff5dc786",
    [5] = "|cffcf6348",
    [6] = "|cffd4f235",
    [7] = "|cffa9adc7",
    [8] = "|cfffae6cf",
}
local expansionStrings = {
    [1] = Sorted.Localize("SUBFILTER_EXPANSION_TBC_SHORT"),
    [2] = Sorted.Localize("SUBFILTER_EXPANSION_WOTLK_SHORT"),
    [3] = Sorted.Localize("SUBFILTER_EXPANSION_CATA_SHORT"),
    [4] = Sorted.Localize("SUBFILTER_EXPANSION_MOP_SHORT"),
    [5] = Sorted.Localize("SUBFILTER_EXPANSION_WOD_SHORT"),
    [6] = Sorted.Localize("SUBFILTER_EXPANSION_LEGION_SHORT"),
    [7] = Sorted.Localize("SUBFILTER_EXPANSION_BFA_SHORT"),
    [8] = Sorted.Localize("SUBFILTER_EXPANSION_SHADOW_SHORT"),
}
function Sorted_ExpacColor(expacID)
    return expansionColors[expacID]
end
function Sorted_FormatExpac(expacID)
    if expansionStrings[expacID] then
        return expansionColors[expacID]..expansionStrings[expacID]
    else
        return ""
    end
end

function Sorted_FormatTime(time)
    if time > 31536000 then
        if time > 63072000 then
            return math.floor(time / 31536000).." "..Sorted.Localize("SUBFILTER_TIME_YEARS_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_YEAR_SHORT")
        end

    elseif time >= 2419200 then
        if time >= 4838400 then
            return math.floor(time / 2419200).." "..Sorted.Localize("SUBFILTER_TIME_MONTHS_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_MONTH_SHORT")
        end

    elseif time >= 604800 then
        if time >= 1209600 then
            return math.floor(time / 604800).." "..Sorted.Localize("SUBFILTER_TIME_WEEKS_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_WEEK_SHORT")
        end

    elseif time >= 86400 then
        if time >= 172800 then
            return math.floor(time / 86400).." "..Sorted.Localize("SUBFILTER_TIME_DAYS_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_DAY_SHORT")
        end

    elseif time >= 3600 then
        if time >= 7200 then
            return math.floor(time / 3600).." "..Sorted.Localize("SUBFILTER_TIME_HOURS_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_HOUR_SHORT")
        end

    elseif time >= 60 then
        if time >= 120 then
            return math.floor(time / 60).." "..Sorted.Localize("SUBFILTER_TIME_MINUTES_SHORT")
        else
            return "1 "..Sorted.Localize("SUBFILTER_TIME_MINUTE_SHORT")
        end

    elseif time >= 0 then
        if time == 1 then
            return "1 "..Sorted.Localize("SUBFILTER_TIME_SECOND_SHORT")
        else
            return time.." "..Sorted.Localize("SUBFILTER_TIME_SECONDS_SHORT")
        end
    else
        return ""
    end
end

function Sorted_VendorGreys()
    if MerchantFrame:IsVisible() then
        for k,bagID in pairs(Sorted_ContainersOfType("BAGS")) do
            for slotID = 1,36 do
                local _, _, _, quality, _, _, _, _, noValue = GetContainerItemInfo(bagID, slotID)
                if (quality == 0) and (not noValue) then
                    UseContainerItem(bagID, slotID)
                end
            end
        end
    end
end

function Sorted_ItemKey(itemLink)
    if string.find(itemLink, "item:138019:") then
        return "138019"
    elseif string.find(itemLink, "|Hitem") then
        local a,b = string.match(itemLink, "|Hitem:(%d*:)%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:(.-)|h")
        return a..b
    else
        local a = string.match(itemLink, "|H(.-)|h")
        return a
    end
end

function Sorted_FormatValueString(value)
    if value < 100 then
        return GetMoneyString(value)
    elseif value < 10000 then
        return GetMoneyString(math.floor(value / 100) * 100)
    elseif value < 10000000 then
        return GetMoneyString(math.floor(value / 10000) * 10000)
    else
        local n = math.floor(value / 10000000) * 10000
        local s = ""..n
        n = GetMoneyString(n)
        return n:sub(1, #s-4).."K"..n:sub(#s-3)
    end
end

function Sorted_GetValueColor(value)
    if value < 100 then return {r=0.6, g=0.35, b=0.15}
    elseif value < 10000 then return {r=0.6, g=0.6, b=0.6}
    elseif value < 10000000 then return {r=0.8, g=0.6, b=0.1}
    elseif value < 10000000000 then return {r=1, g=0.9, b=0.25}
    else return {r=1, g=0.6, b=0.1}
    end
end


-- TABLE UTILITIES

-- Prints a table in a neat format
function Sorted_PrintTable(t,indent, key)
    local s = ""
    if indent then
        for i = 1,indent do s=s.."  " end
    else
        indent = 0
    end
    if type(t) == "table" then
        if key then print(s.."["..key.."] = {")
        else print(s.."{") end
        for k,v in pairs(t) do
            Sorted_PrintTable(v,indent+1,k)
        end
        print(s.."},")
    else
        if key then print(s.."["..key.."] = "..tostring(t))
        else print(s..tostring(t)) end
    end
end

-- Copies contents of t1 into t2
function Sorted_CopyTable(t1, t2)
    for key, value in pairs(t1) do
        if type(value) == "table" then
            t2[key] = {}
            Sorted_CopyTable(value, t2[key])
        else
            t2[key] = value
        end
    end
end

-- Deletes empty inner tables
function Sorted_CleanTable(t)
    if type(t) == "table" then
        local empty = true
        for k, v in pairs(t) do
            if Sorted_CleanTable(v) then
                t[k] = nil
            else
                empty = false
            end
        end
        if empty then
            return true
        end
    end
    return false
end




-- Dealing with other bag frames
GoodbyeInferiorBagFrames = CreateFrame("Frame")
GoodbyeInferiorBagFrames:Hide()

local function KillFrame(name, removeSpecial)
    _G[name]:UnregisterAllEvents()
    _G[name]:SetParent(GoodbyeInferiorBagFrames)
    _G[name]:HookScript("OnShow", function(self) self:Hide() end)
    _G[name]:SetScript("OnHide", function(self) end)
    if removeSpecial then
        for k,v in pairs(UISpecialFrames) do
            if v == name then
                table.remove(UISpecialFrames, k)
                return
            end
        end
    end
end

function Sorted_HideBlizzFrames()
    for i = 1, NUM_CONTAINER_FRAMES do
        KillFrame("ContainerFrame"..i, true)
    end
    KillFrame("BankFrame", true)
    
    if not Sorted_IsClassic() then
        _G["CharacterBag0Slot"]:Hide()
        _G["CharacterBag1Slot"]:Hide()
        _G["CharacterBag2Slot"]:Hide()
        _G["CharacterBag3Slot"]:Hide()
        _G["MicroButtonAndBagsBar"].MicroBagBar:Hide()
    end

    --local BlizzUpdateContainerFrameAnchors = UpdateContainerFrameAnchors
    local BlizzContainerFrame_Update = ContainerFrame_Update
    local BlizzContainerFrame_GenerateFrame = ContainerFrame_GenerateFrame

    UpdateContainerFrameAnchors = function() end
    ContainerFrame_Update = function(self)
        if (self:GetParent():GetID() < 0 or self:GetParent():GetID() > NUM_BAG_SLOTS) or (self:GetID() < 1 or self:GetID() > 36) then
            BlizzContainerFrame_Update(self)
        end
    end
    ContainerFrame_GenerateFrame = function(frame, size, id)
        if (frame:GetParent():GetID() < 0 or frame:GetParent():GetID() > NUM_BAG_SLOTS) then
            BlizzContainerFrame_GenerateFrame(frame, size, id)
        end
    end
end

function Sorted_HideElvUIFrames()
    if _G["ElvUI_ContainerFrame"] then
        KillFrame("ElvUI_ContainerFrame", true)
        KillFrame("ElvUI_BankContainerFrame", true)
    end
end

function Sorted_HideGW2UIFrames()
    if _G["GwBagFrame"] then
        KillFrame("GwBagFrame", true)
        KillFrame("GwBankFrame", true)
        local function KillItemButton(bag, slot)
            local frame = "ContainerFrame"..(bag+1).."Item"..slot
            if _G[frame] then
                _G[frame].gwBackdrop:Hide()
                _G[frame]:SetHighlightTexture("")
            end
        end
        for k,v in pairs(Sorted_ContainersOfType("BAGS")) do
            for i = 1,36 do
                KillItemButton(v, i)
            end
        end
        for k,v in pairs(Sorted_ContainersOfType("BANK")) do
            for i = 1,36 do
                KillItemButton(v, i)
            end
        end
    end
end