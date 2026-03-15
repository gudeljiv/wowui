--- @module "VanillaCommon"

local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local Version = ns.Version
if not Version:IsClassicEra() then return end

--local GetSpellInfo = GetSpellInfo
local WoWAPI = ns.WoWAPI
local CreateFrame = _G.CreateFrame
-- Lua APIs (using WoW's optimized versions where available)

local tinsert = tinsert


--- Updates the stable pets information for the Hunter class.
-- This function retrieves the stable pet information and processes each pet's spell data.
--- @function ns.HUNTER_UpdateStablePets
--- @usage
-- ns.HUNTER_UpdateStablePets()
function ns.HUNTER_UpdateStablePets()
    local rightSideSpells = {}
    local petsIDs = {
        { spellId = 883, familyName = "" },   -- Call Pet 1
    }

    for i, pet in ipairs(petsIDs) do
        local petFamily = nil
        local talents = nil
        if ns.Version:IsCata() or ns.Version:IsSoD() then
            local petInfo = WoWAPI.GetStablePetInfo(i)
            if petInfo then
                petFamily = petInfo.familyName
                talents = petInfo.specialization
            end
        end

        if petFamily then
            -- Add the pet spell through the processor
            NAG:GetModule("DataManager"):AddSpell(pet.spellId, { "Spells", "Hunter", "Pet", petFamily }, {
                petFamily = petFamily,
                talents = talents,
                stableSlot = i
            })

            pet.familyName = petFamily
        else
            pet.familyName = "Unknown"
        end
    end
end

NAG.Rune = {}
local isEngravingAvailable = _G.C_Engraving ~= nil


function NAG:GetRuneInfo(spellID)
    if not Version:IsSoD() then return nil end

    for i = 1, C_Engraving.GetNumRuneCategories() do
        local categoryInfo = C_Engraving.GetRuneCategoryInfo(i)
        for j = 1, categoryInfo.numRunes do
            local runeInfo = C_Engraving.GetRuneInfo(i, j)
            if runeInfo and runeInfo.learnedAbilitySpellIDs then
                for _, learnedSpellID in ipairs(runeInfo.learnedAbilitySpellIDs) do
                    if learnedSpellID == spellID then
                        return runeInfo
                    end
                end
            end
        end
    end
    return nil
end

--- Checks if a specific rune is active.
--- @function NAG:IsRuneActive
--- @param spellID number The spell ID of the rune to check.
--- @usage NAG:IsRuneActive(spellID)
-- @return boolean True if the rune is active, false otherwise.
function NAG:IsRuneActive(spellID)
    if not Version:IsSoD() then return false end

    local runeInfo = self:GetRuneInfo(spellID)
    if runeInfo then
        return C_Engraving.IsRuneEquipped(runeInfo.categoryID, runeInfo.runeIndex)
    end
    return false
end

-- Function to initialize the rune data
function NAG.InitializeRunes()
    -- Clear any existing data
    NAG.Rune = {}

    -- Check if engraving is available (SoD specific)
    if not isEngravingAvailable then
        NAG:Warn("Engraving is not available in this version of the game.")
        return
    end

    -- Check if engraving mode is enabled
    local engravingEnabled = C_Engraving.IsEngravingEnabled()
    if not engravingEnabled then
        NAG:Warn("Engraving is not enabled.")
        return
    end

    -- Get the total number of known runes
    local numRunes = C_Engraving.GetNumRunesKnown()
    NAG:Debug("Number of known runes: " .. numRunes)

    -- Get all rune categories
    local categories = C_Engraving.GetRuneCategories(false, true)
    NAG:Debug("Rune categories found: " .. #categories)

    -- Populate runes for each category
    for _, category in ipairs(categories) do
        local runesInCategory = C_Engraving.GetRunesForCategory(category, true)
        NAG.Rune[category] = {}

        for _, runeInfo in ipairs(runesInCategory) do
            local runeID = runeInfo.skillLineAbilityID
            local isEquipped = C_Engraving.IsRuneEquipped(runeID)
            local engravableSlots = NAG.GetEngravableSlotsForRune(runeID)

            -- Store rune information in NAG.Rune table
            tinsert(NAG.Rune[category], {
                id = runeID,
                name = runeInfo.name,
                description = runeInfo.description,
                icon = runeInfo.icon,
                equipped = isEquipped,
                engravableSlots = engravableSlots,
            })

            NAG:Debug("Rune ID: " ..
                runeID ..
                ", Name: " ..
                runeInfo.name ..
                ", Equipped: " .. tostring(isEquipped) .. ", Engravable Slots: " .. table.concat(engravableSlots, ", "))
        end
    end
end

-- Function to retrieve engravable slots for a rune
function NAG.GetEngravableSlotsForRune(runeID)
    local engravableSlots = {}

    if isEngravingAvailable then
        for slotID = 0, 19 do
            if C_Engraving.IsEquipmentSlotEngravable(slotID) and C_Engraving.IsKnownRuneSpell(runeID) then
                -- Check if the rune can be applied to this slot
                -- This is an approximation, as we don't have a direct API to check per-rune slot compatibility
                tinsert(engravableSlots, slotID)
            end
        end
    end

    return engravableSlots
end

-- Function to update rune information
function NAG.RefreshRuneData()
    C_Engraving.RefreshRunesList()
    NAG.InitializeRunes()
end

-- Event handling to refresh rune data on updates
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ENGRAVING_MODE_CHANGED")
eventFrame:RegisterEvent("RUNE_UPDATED")
eventFrame:SetScript("OnEvent", function(frameSelf, event)
    NAG.RefreshRuneData()
end)

-- Initialize runes when script loads
NAG.InitializeRunes()
