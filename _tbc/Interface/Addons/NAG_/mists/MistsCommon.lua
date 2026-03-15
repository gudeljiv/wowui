--- @module "MistsCommon"

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local WoWAPI = ns.WoWAPI



--- Updates the stable pets information for the Hunter class.
-- This function retrieves the stable pet information and processes each pet's spell data.
--- @function ns.HUNTER_UpdateStablePets
--- @usage
-- ns.HUNTER_UpdateStablePets()
function ns.HUNTER_UpdateStablePets()
    local rightSideSpells = {}
    local petsIDs = {
        { spellId = 883,   familyName = "" }, -- Call Pet 1
        { spellId = 83242, familyName = "" }, -- Call Pet 2
        { spellId = 83243, familyName = "" }, -- Call Pet 3
        { spellId = 83244, familyName = "" }, -- Call Pet 4
        { spellId = 83245, familyName = "" }  -- Call Pet 5
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
