local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)

local CLASS_ICONS = {
    WarriorFury    = "Interface\\Icons\\Ability_Warrior_Innerrage",
    WarriorArms    = "Interface\\Icons\\Ability_Warrior_Savageblow",
    WarriorProt    = "Interface\\Icons\\Ability_Warrior_Defensivestance",
    DruidBoom      = "Interface\\Icons\\Spell_Nature_Starfall",
    DruidBear      = "Interface\\Icons\\Ability_Racial_BearForm",
    DruidFeral     = "Interface\\Icons\\Ability_Druid_CatForm",
    DruidResto     = "Interface\\Icons\\Spell_Nature_HealingTouch",
    MageArc        = "Interface\\Icons\\Spell_Magic_LesserInvisibilty",
    ["Mage Fire"]  = "Interface\\Icons\\Spell_Fire_FireBolt02",
    PriestHoly     = "Interface\\Icons\\Spell_Holy_WordFortitude",
    PriestShadow   = "Interface\\Icons\\Spell_Shadow_WordPain",
    PalHoly        = "Interface\\Icons\\Spell_Holy_HolyBolt",
    PalProt        = "Interface\\Icons\\Spell_Holy_DevotionAura",
    Palret         = "Interface\\Icons\\Spell_Holy_AuraOfLight",
    ShamanEnh      = "Interface\\Icons\\Spell_Nature_LightningShield",
    ShamanEle      = "Interface\\Icons\\Spell_Nature_Lightning",
    ShamanResto    = "Interface\\Icons\\Spell_Nature_MagicImmunity",
    HunterBM       = "Interface\\Icons\\Ability_Hunter_BeastTaming",
    HunterSurv     = "Interface\\Icons\\ability_hunter_swiftstrike",
    Rogue          = "Interface\\Icons\\Ability_Stealth",
    WarlockAff     = "Interface\\Icons\\Spell_Shadow_DeathCoil",
    Warlockdest    = "Interface\\Icons\\Spell_Shadow_RainOfFire",
}

local CLASS_NAMES = {
    WarriorFury    = "Fury",
    WarriorArms    = "Arms",
    WarriorProt    = "Protection",
    DruidBoom      = "Balance",
    DruidBear      = "Bear",
    DruidFeral     = "Feral",
    DruidResto     = "Restoration",
    MageArc        = "Arcane",
    ["Mage Fire"]  = "Fire",
    PriestHoly     = "Holy",
    PriestShadow   = "Shadow",
    PalHoly        = "Holy",
    PalProt        = "Protection",
    Palret         = "Retribution",
    ShamanEnh      = "Enhancement",
    ShamanEle      = "Elemental",
    ShamanResto    = "Restoration",
    HunterBM       = "Beast Mastery",
    HunterSurv     = "Survival",
    Rogue          = "Rogue",
    WarlockAff     = "Affliction",
    Warlockdest    = "Destruction",
}

local function GetItemID(link)
    if not link then return end
    local itemID = link:match("item:(%d+)")
    return tonumber(itemID)
end

local function GetBISInfo(itemID)
    if not itemID then return nil end

    local results = {}

    for class, classData in pairs(data) do
        if type(classData) == "table" and classData.items then
            for _, slotData in ipairs(classData.items) do
                if slotData[1] then
                    for _, entry in ipairs(slotData[1]) do
                        if entry[2] == itemID then
                            table.insert(results, {
                                class = class,
                                slot = slotData.name,
                                priority = entry[1]
                            })
                        end
                    end
                end
            end
        end
    end

    return #results > 0 and results or nil
end

GameTooltip:HookScript("OnTooltipSetItem", function(self)
    local name, link = self:GetItem()
    if not link then return end

    local itemID = GetItemID(link)
    local results = GetBISInfo(itemID)

    if results then
        table.sort(results, function(a, b) return a.priority < b.priority end)
        self:AddLine(" ")
        self:AddLine("|cff00ff00AlastLootClassic|r")
        table.sort(results, function(a, b) return a.priority < b.priority end)
        for _, result in ipairs(results) do
            local icon = CLASS_ICONS[result.class]
            local iconStr = icon and ("|T" .. icon .. ":16:16:0:0|t ") or ""
            local displayName = CLASS_NAMES[result.class] or result.class
            local line = "  " .. iconStr .. "#" .. result.priority .. " " .. displayName
            self:AddLine(line, 1, 0.82, 0)
        end
        self:AddLine(" ")
        self:Show()
    end
end)