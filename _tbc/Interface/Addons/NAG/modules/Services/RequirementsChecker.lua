--- @module "NAG.RequirementsChecker"
--- Runtime spell requirements checking using DB2-generated data
---
--- Provides dynamic checking of spell requirements like stance/form requirements,
--- aura requirements, and other casting prerequisites extracted from DB2 files.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
--- Discord: https://discord.gg/ebonhold

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type StateManager
--- @type DataManager
local StateManager, DataManager
local WoWAPI = ns.WoWAPI
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitName = _G.UnitName
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
local IsSpellInRange = C_Spell and C_Spell.IsSpellInRange or _G.IsSpellInRange

-- Localize frequently used functions
local format = string.format
local pairs = pairs
local type = type


--- @class RequirementsChecker : CoreModule
local RequirementsChecker = NAG:CreateModule("RequirementsChecker", nil, {
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.SERVICES,
        ns.DEBUG_CATEGORIES.DATA
    }
})
local module = RequirementsChecker
ns.RequirementsChecker = RequirementsChecker



-- Cache for requirement descriptions to avoid repeated logging
local requirementDescriptionCache = {}

-- Cache for spell validation to avoid checking non-existent spells
local spellValidationCache = {}

-- Known bitmask values that represent spell restrictions (not actual spell IDs)
local KNOWN_BITMASKS = {
    -- ExcludeCasterAuraState bitmasks
    [12] = "Cannot be used while shapeshifted",

    -- ExcludeTargetAuraSpell bitmasks (these are complex restrictions)
    [65219] = "Cannot be used on targets with protection/immunity auras",
    [61988] = "Cannot be used on targets with certain auras",
    [61431] = "Cannot be used on targets with certain auras: No pet in dalaran?",
    [79636] = "Cannot be used on targets with certain auras, no feather fall",
    [3436] = "Cannot be used on targets with certain auras",

}

--- Ace3 lifecycle: Called when module is initialized
function RequirementsChecker:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    StateManager = NAG:GetModule("StateManager")
    DataManager = NAG:GetModule("DataManager")
end

--- Ace3 lifecycle: Called when module is enabled
function RequirementsChecker:ModuleEnable()
    -- ============================ MODULE INITIALIZATION ============================
    NAG:ThrottledDebug("RequirementsChecker: Enabled - now using DataManager for all requirement data",
        "requirements_checker_enabled")
    -- Clear caches to ensure fresh data
    self:ClearAllCaches()
end

function RequirementsChecker:ModuleDisable()
end

--- Check if a spell ID is valid (exists in the game)
--- @param spellId number The spell ID to validate
--- @return boolean True if the spell ID is valid
function RequirementsChecker:IsValidSpellId(spellId)
    if not spellId or spellId <= 0 then
        return false
    end

    -- Check cache first
    if spellValidationCache[spellId] ~= nil then
        return spellValidationCache[spellId]
    end

    -- Check if it's a known bitmask (not a real spell ID)
    if KNOWN_BITMASKS[spellId] then
        spellValidationCache[spellId] = false
        NAG:ThrottledTrace(
            format("RequirementsChecker: Spell ID %d is a known bitmask (%s), not a real spell", spellId,
                KNOWN_BITMASKS[spellId]), "requirements_checker_bitmask_" .. spellId)
        return false
    end

    -- Try to get spell info from WoW API
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    local spellName = spellInfo and spellInfo.name
    local isValid = spellName ~= nil and spellName ~= ""

    -- Cache the result
    spellValidationCache[spellId] = isValid

    if not isValid then
        NAG:ThrottledTrace(format("RequirementsChecker: Spell ID %d is invalid (not found in WoW API)", spellId),
            "requirements_checker_invalid_spell_" .. spellId)
    end

    return isValid
end

--- Check if a value is a known bitmask
--- @param value number The value to check
--- @return boolean True if the value is a known bitmask
function RequirementsChecker:IsKnownBitmask(value)
    return KNOWN_BITMASKS[value] ~= nil
end

--- Get the description for a known bitmask
--- @param value number The bitmask value
--- @return string|nil The description or nil if not a known bitmask
function RequirementsChecker:GetBitmaskDescription(value)
    return KNOWN_BITMASKS[value]
end

--- Check if a spell has any requirements
--- @param spellId number The spell ID to check
--- @return boolean True if the spell has requirements
function RequirementsChecker:HasRequirements(spellId)
    local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)

    if not entry then
        return false
    end

    -- Check if any requirement fields are present
    local requirementFields = {
        "class", "stance", "shapeshiftForm", "auraState", "casterAuraState", "targetAuraState",
        "requiredCasterAura", "requiredTargetAura", "excludeCasterAura", "excludeTargetAura",
        "excludeCasterAuraState", "excludeTargetAuraState", "facingFlags", "minFaction",
        "minReputation", "requiredArea", "requiredAuraVision", "requiredSpellFocus"
    }

    for _, field in ipairs(requirementFields) do
        if entry[field] ~= nil then
            return true
        end
    end

    return false
end

--- Get all requirements for a spell
--- @param spellId number The spell ID to get requirements for
--- @return table|nil The requirements table or nil if no requirements
function RequirementsChecker:GetRequirements(spellId)
    -- Get the spell entry from DataManager

    local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)

    if not entry then
        return nil
    end

    -- Extract requirement fields from the entry
    local requirements = {}
    local requirementFields = {
        "class", "stance", "shapeshiftForm", "auraState", "casterAuraState", "targetAuraState",
        "requiredCasterAura", "requiredTargetAura", "excludeCasterAura", "excludeTargetAura",
        "excludeCasterAuraState", "excludeTargetAuraState", "facingFlags", "minFaction",
        "minReputation", "requiredArea", "requiredAuraVision", "requiredSpellFocus"
    }

    for _, field in ipairs(requirementFields) do
        if entry[field] ~= nil then
            requirements[field] = entry[field]
        end
    end

    -- Check for special overrides (any expansion can provide these)
    -- This allows each expansion to define their own SpellRequirementsOverrides table
    -- in their data files (e.g., ns.mists.overrides.SpellRequirementsOverrides)
    -- After DataLoader processing, this becomes ns.overrides.SpellRequirementsOverrides for universal access
    local overrides = nil
    if ns.overrides and ns.overrides.SpellRequirementsOverrides then
        overrides = ns.overrides.SpellRequirementsOverrides
        NAG:ThrottledTrace("RequirementsChecker: Found SpellRequirementsOverrides in universal namespace (ns.overrides)",
            "requirements_checker_overrides_found_" .. spellId)
    end

    if overrides and overrides:HasOverride(spellId) then
        requirements = overrides:MergeWithBase(spellId, requirements)
    end

    return next(requirements) and requirements or nil
end

--- Check if a spell requires a specific shapeshift form
--- @param spellId number The spell ID to check
--- @return boolean True if the spell requires a shapeshift form
function RequirementsChecker:RequiresShapeshiftForm(spellId)
    local req = self:GetRequirements(spellId)
    return req and req.shapeshiftForm ~= nil
end

--- Get the required shapeshift form for a spell
--- @param spellId number The spell ID to get the form for
--- @return number|nil The required shapeshift form ID or nil
function RequirementsChecker:GetRequiredShapeshiftForm(spellId)
    local req = self:GetRequirements(spellId)
    return req and req.shapeshiftForm
end

--- Check if a spell requires a specific aura state
--- @param spellId number The spell ID to check
--- @return boolean True if the spell requires an aura state
function RequirementsChecker:RequiresAuraState(spellId)
    local req = self:GetRequirements(spellId)
    return req and req.auraState ~= nil
end

--- Get the required aura state for a spell
--- @param spellId number The spell ID to get the aura state for
--- @return number|nil The required aura state or nil
function RequirementsChecker:GetRequiredAuraState(spellId)
    local req = self:GetRequirements(spellId)
    return req and req.auraState
end

--- Check if a spell requires a specific caster aura
--- @param spellId number The spell ID to check
--- @return boolean True if the spell requires a caster aura
function RequirementsChecker:RequiresCasterAura(spellId)
    local req = self:GetRequirements(spellId)
    return req and req.requiredCasterAura ~= nil
end

--- Get the required caster aura for a spell
--- @param spellId number The spell ID to get the caster aura for
--- @return number|nil The required caster aura ID or nil
function RequirementsChecker:GetRequiredCasterAura(spellId)
    local req = self:GetRequirements(spellId)
    return req and req.requiredCasterAura
end

--- Check if a spell can be cast based on current requirements
--- @param spellId number The spell ID to check
--- @return boolean True if the spell can be cast
--- @return string|nil Error message if the spell cannot be cast
function RequirementsChecker:CanCastSpell(spellId)
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    local spellName = spellInfo and spellInfo.name or format("Spell %d", spellId)

    local req = self:GetRequirements(spellId)
    if not req then
        NAG:ThrottledTrace(format("RequirementsChecker: No requirements for %s - can cast", spellName),
            "requirements_checker_no_reqs_" .. spellId)
        return true -- No requirements, can cast
    end

    -- Only log requirements description once per spell to reduce spam
    if not requirementDescriptionCache[spellId] then
        local description = self:GetRequirementsDescription(spellId)
        if description then
            NAG:ThrottledDebug(format("RequirementsChecker: Found requirements for %s: %s", spellName, description),
                "requirements_checker_desc_" .. spellId)
            requirementDescriptionCache[spellId] = description
        end
    end

    -- Check shapeshift form requirements
    if req.shapeshiftForm then
        NAG:ThrottledTrace(format("RequirementsChecker: Checking shapeshift form requirement: %d", req.shapeshiftForm),
            "requirements_checker_shapeshift_check_" .. spellId)
        local currentForm = StateManager:GetShapeshiftFormID()

        -- For stance/aura spells, shapeshiftForm means "this spell will put you into this form"
        -- So we should allow casting if we're NOT in the required form, and block if we ARE
        if currentForm == req.shapeshiftForm then
            local formName = self:GetShapeshiftFormName(req.shapeshiftForm)
            local errorMsg = format("Already in %s", formName or format("Form %d", req.shapeshiftForm))
            NAG:ThrottledInfo(
                format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg),
                "requirements_shapeshift_form")
            return false, errorMsg
        else
            NAG:ThrottledTrace(format("RequirementsChecker: Shapeshift form requirement met for %s", spellName),
                "requirements_checker_shapeshift_met_" .. spellId)
        end
    end

    -- Check aura state requirements
    if req.auraState then
        NAG:ThrottledTrace(format("RequirementsChecker: Checking aura state requirement: %d", req.auraState),
            "requirements_checker_aura_state_check_" .. spellId)
        local hasAuraState = self:HasAuraState(req.auraState)

        if not hasAuraState then
            local errorMsg = format("Requires aura state %d", req.auraState)
            NAG:ThrottledInfo(
                format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg),
                "requirements_aura_state")
            return false, errorMsg
        else
            NAG:ThrottledTrace(format("RequirementsChecker: Aura state requirement met for %s", spellName),
                "requirements_checker_aura_state_met_" .. spellId)
        end
    end

    -- Check caster aura requirements
    if req.requiredCasterAura then
        NAG:ThrottledTrace(format("RequirementsChecker: Checking required caster aura: %d", req.requiredCasterAura),
            "requirements_checker_caster_aura_check_" .. spellId)

        -- Check if it's a valid spell ID
        if not self:IsValidSpellId(req.requiredCasterAura) then
            NAG:ThrottledTrace(
                format("RequirementsChecker: Required caster aura %d is not a valid spell ID, skipping check for %s",
                    req.requiredCasterAura, spellName), "requirements_checker_invalid_caster_aura_" .. spellId)
        else
            -- Valid spell ID, check if the aura is active
            local hasAura = NAG:AuraIsActive(req.requiredCasterAura)
            if not hasAura then
                local spellInfo = WoWAPI.GetSpellInfo(req.requiredCasterAura)
                local auraName = spellInfo and spellInfo.name or format("Aura %d", req.requiredCasterAura)
                local errorMsg = format("Requires %s", auraName)
                NAG:ThrottledInfo(
                    format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg),
                    "requirements_caster_aura")
                return false, errorMsg
            else
                NAG:ThrottledTrace(format("RequirementsChecker: Required caster aura met for %s", spellName),
                    "requirements_checker_caster_aura_met_" .. spellId)
            end
        end
    end

    -- Check excluded caster auras
    if req.excludeCasterAura then
        NAG:ThrottledTrace(format("RequirementsChecker: Checking excluded caster aura: %d", req.excludeCasterAura),
            "requirements_checker_exclude_caster_check_" .. spellId)

        -- Check if it's a known bitmask
        if self:IsKnownBitmask(req.excludeCasterAura) then
            local bitmaskDesc = self:GetBitmaskDescription(req.excludeCasterAura)
            NAG:ThrottledTrace(
                format("RequirementsChecker: Excluded caster aura %d is a known bitmask: %s", req.excludeCasterAura,
                    bitmaskDesc), "requirements_checker_bitmask_caster_" .. spellId)

            -- Handle specific bitmask values
            if req.excludeCasterAura == 12 then
                -- Bitmask 12 = "Cannot be used while shapeshifted"
                local hasShapeshift = self:HasStance()
                if hasShapeshift then
                    local errorMsg = "Cannot be used while shapeshifted"
                    NAG:ThrottledInfo(
                        format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg),
                        "requirements_exclude_caster_aura")
                    return false, errorMsg
                else
                    NAG:ThrottledTrace(
                        format("RequirementsChecker: Shapeshift restriction check passed for %s", spellName),
                        "requirements_checker_shapeshift_restriction_passed_" .. spellId)
                end
            else
                -- For other bitmasks, we'll skip the check for now as they're complex
                NAG:ThrottledTrace(
                    format("RequirementsChecker: Skipping complex bitmask check %d for %s", req.excludeCasterAura,
                        spellName),
                    "requirements_checker_skip_complex_bitmask_" .. spellId)
            end
        else
            -- Check if it's a valid spell ID
            if not self:IsValidSpellId(req.excludeCasterAura) then
                NAG:ThrottledTrace(
                    format("RequirementsChecker: Excluded caster aura %d is not a valid spell ID, skipping check for %s",
                        req.excludeCasterAura, spellName), "requirements_checker_invalid_exclude_caster_" .. spellId)
            else
                -- Valid spell ID, check if the aura is active
                local hasAura = NAG:AuraIsActive(req.excludeCasterAura)
                if hasAura then
                    local spellInfo = WoWAPI.GetSpellInfo(req.excludeCasterAura)
                    local auraName = spellInfo and spellInfo.name or format("Aura %d", req.excludeCasterAura)
                    local errorMsg = format("Cannot cast while %s is active", auraName)
                    NAG:ThrottledInfo(
                        format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg),
                        "requirements_exclude_caster_aura")
                    return false, errorMsg
                else
                    NAG:ThrottledTrace(
                        format("RequirementsChecker: Excluded caster aura check passed for %s", spellName),
                        "requirements_checker_exclude_caster_passed_" .. spellId)
                end
            end
        end
    end

    -- Check target aura requirements
    if req.requiredTargetAura then
        NAG:ThrottledTrace(format("RequirementsChecker: Checking required target aura: %d", req.requiredTargetAura),
            "requirements_checker_target_aura_check_" .. spellId)

        -- Check if it's a valid spell ID
        if not self:IsValidSpellId(req.requiredTargetAura) then
            NAG:ThrottledTrace(
                format("RequirementsChecker: Required target aura %d is not a valid spell ID, skipping check for %s",
                    req.requiredTargetAura, spellName), "requirements_checker_invalid_target_aura_" .. spellId)
        else
            -- Valid spell ID, check if the target has the aura
            local hasAura = NAG:AuraIsActive(req.requiredTargetAura, "target")
            if not hasAura then
                local spellInfo = WoWAPI.GetSpellInfo(req.requiredTargetAura)
                local auraName = spellInfo and spellInfo.name or format("Aura %d", req.requiredTargetAura)
                local errorMsg = format("Target requires %s", auraName)
                NAG:ThrottledInfo(
                    format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg),
                    "requirements_target_aura")
                return false, errorMsg
            else
                NAG:ThrottledTrace(format("RequirementsChecker: Required target aura met for %s", spellName),
                    "requirements_checker_target_aura_met_" .. spellId)
            end
        end
    end

    -- Check excluded target auras
    if req.excludeTargetAura then
        NAG:ThrottledTrace(format("RequirementsChecker: Checking excluded target aura: %d", req.excludeTargetAura),
            "requirements_checker_exclude_target_check_" .. spellId)

        -- Check if it's a known bitmask
        if self:IsKnownBitmask(req.excludeTargetAura) then
            local bitmaskDesc = self:GetBitmaskDescription(req.excludeTargetAura)
            NAG:ThrottledTrace(
                format("RequirementsChecker: Excluded target aura %d is a known bitmask: %s", req.excludeTargetAura,
                    bitmaskDesc), "requirements_checker_bitmask_target_" .. spellId)

            -- For now, we'll skip complex target aura bitmask checks as they're difficult to validate
            NAG:ThrottledTrace(
                format("RequirementsChecker: Skipping complex target bitmask check %d for %s", req.excludeTargetAura,
                    spellName), "requirements_checker_skip_target_bitmask_" .. spellId)
        else
            -- Check if it's a valid spell ID
            if not self:IsValidSpellId(req.excludeTargetAura) then
                NAG:ThrottledTrace(
                    format("RequirementsChecker: Excluded target aura %d is not a valid spell ID, skipping check for %s",
                        req.excludeTargetAura, spellName), "requirements_checker_invalid_exclude_target_" .. spellId)
            else
                -- Valid spell ID, check if the target has the aura
                local hasAura = NAG:AuraIsActive(req.excludeTargetAura, "target")
                if hasAura then
                    local spellInfo = WoWAPI.GetSpellInfo(req.excludeTargetAura)
                    local auraName = spellInfo and spellInfo.name or format("Aura %d", req.excludeTargetAura)
                    local errorMsg = format("Cannot cast while target has %s", auraName)
                    NAG:ThrottledInfo(
                        format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg),
                        "requirements_exclude_target_aura")
                    return false, errorMsg
                else
                    NAG:ThrottledTrace(
                        format("RequirementsChecker: Excluded target aura check passed for %s", spellName),
                        "requirements_checker_exclude_target_passed_" .. spellId)
                end
            end
        end
    end

    -- Check for OR conditions (special cases where requirements are OR instead of AND)
    if req.hasOrCondition then
        NAG:ThrottledTrace(
            format("RequirementsChecker: Checking OR condition for %s: %s", spellName,
                req.orConditionDescription or "Unknown"), "requirements_checker_or_condition_" .. spellId)

        local conditionsMet = false
        local conditionDetails = {}

        -- Check target aura state (if present)
        if req.targetAuraState then
            local hasTargetState = self:HasTargetAuraState(req.targetAuraState)
            table.insert(conditionDetails,
                format("Target aura state %d: %s", req.targetAuraState, tostring(hasTargetState)))
            if hasTargetState then
                conditionsMet = true
            end
        end

        -- Check required caster aura (if present)
        if req.requiredCasterAura then
            local hasCasterAura = NAG:AuraIsActive(req.requiredCasterAura)
            local spellInfo = WoWAPI.GetSpellInfo(req.requiredCasterAura)
            local auraName = spellInfo and spellInfo.name or format("Aura %d", req.requiredCasterAura)
            table.insert(conditionDetails, format("%s: %s", auraName, tostring(hasCasterAura)))
            if hasCasterAura then
                conditionsMet = true
            end
        end

        if conditionsMet then
            NAG:ThrottledTrace(
                format("RequirementsChecker: OR condition met for %s - %s", spellName,
                    table.concat(conditionDetails, ", ")),
                "requirements_checker_or_condition_met_" .. spellId)
        else
            local errorMsg = req.orConditionDescription or "OR condition not met"
            NAG:ThrottledInfo(
                format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg),
                "requirements_or_condition")
            return false, errorMsg
        end
    else
        -- Check target aura state requirements (normal case - AND logic)
        if req.targetAuraState then
            NAG:ThrottledTrace(
                format("RequirementsChecker: Checking target aura state requirement: %d", req.targetAuraState),
                "requirements_checker_target_aura_state_check_" .. spellId)
            local hasAuraState = self:HasTargetAuraState(req.targetAuraState)

            if not hasAuraState then
                local errorMsg = format("Target requires aura state %d", req.targetAuraState)
                NAG:ThrottledInfo(
                    format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg),
                    "requirements_target_aura_state")
                return false, errorMsg
            else
                NAG:ThrottledTrace(format("RequirementsChecker: Target aura state requirement met for %s", spellName),
                    "requirements_checker_target_aura_state_met_" .. spellId)
            end
        end
    end

    -- Check class requirements
    -- NOTE: Class requirements are redundant since the game won't allow us to have spells from other classes
    -- The WoW client automatically filters spells by class, so this check is unnecessary
    -- if req.class then
    --     if NAG.debug then NAG:Trace("RequirementsChecker: Checking class requirement: %s", req.class) end
    --     local playerClass = select(2, UnitClass("player"))
    --
    --     if playerClass ~= req.class then
    --         local errorMsg = format("Requires %s class", req.class)
    --         NAG:ThrottledInfo(format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg), "requirements_class")
    --         return false, errorMsg
    --     else
    --         if NAG.debug then NAG:Trace("RequirementsChecker: Class requirement met for %s", spellName) end
    --     end
    -- end

    -- Check facing requirements (disabled due to WoW API limitations)
    -- if req.facingFlags then
    --     if NAG.debug then NAG:Debug("RequirementsChecker: Checking facing requirement: %d", req.facingFlags) end
    --     local canFace = self:CheckFacingRequirement(req.facingFlags)
    --     if NAG.debug then NAG:Debug("RequirementsChecker: Facing requirement met: %s", tostring(canFace)) end
    --
    --     if not canFace then
    --         local errorMsg = "Requires facing target"
    --         NAG:Info(format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg))
    --         return false, errorMsg
    --     else
    --         if NAG.debug then NAG:Debug("RequirementsChecker: Facing requirement met for %s", spellName) end
    --     end
    -- end

    -- Check area requirements
    if req.requiredArea then
        NAG:ThrottledTrace(format("RequirementsChecker: Checking area requirement: %d", req.requiredArea),
            "requirements_checker_area_check_" .. spellId)
        local inArea = self:IsInRequiredArea(req.requiredArea)

        if not inArea then
            local areaName = C_Map.GetMapInfo(req.requiredArea)
            local areaText = areaName and areaName.name or format("Area %d", req.requiredArea)
            local errorMsg = format("Must be in: %s", areaText)
            NAG:ThrottledInfo(
                format("RequirementsChecker: %s cannot cast %s - %s", UnitName("player"), spellName, errorMsg),
                "requirements_area")
            return false, errorMsg
        else
            NAG:ThrottledTrace(format("RequirementsChecker: Area requirement met for %s", spellName),
                "requirements_checker_area_met_" .. spellId)
        end
    end

    NAG:ThrottledTrace(format("RequirementsChecker: All requirements met for %s - can cast", spellName),
        "requirements_checker_all_met_" .. spellId)
    return true
end

--- Get a human-readable name for a shapeshift form ID
--- @param formId number The shapeshift form ID
--- @return string|nil The form name or nil if unknown
function RequirementsChecker:GetShapeshiftFormName(formId)
    -- Try to get the actual form name from WoW API first
    local name, texture, active, default, spellId = GetShapeshiftFormInfo(formId)
    if name and type(name) == "string" and name ~= "" then
        -- If we got a valid name from the API, use it
        return name
    elseif spellId then
        -- If we have a spell ID, try to get the spell name
        local spellInfo = WoWAPI.GetSpellInfo(spellId)
        local spellName = spellInfo and spellInfo.name
        if spellName then
            return spellName
        end
    end

    -- Fallback to hardcoded mappings for common forms
    --TODO FIX THESE
    local formNames = {
        -- Druid forms (these are more reliable)
        [1] = "Cat Form",
        [2] = "Bear Form",
        [3] = "Travel Form",
        [4] = "Aquatic Form",
        [5] = "Bear Form",
        [6] = "Moonkin Form",
        [7] = "Tree of Life Form",

        -- Warrior stances
        [71] = "Defensive Stance",  -- Classic Defensive Stance
        [2457] = "Battle Stance",
        [2458] = "Berserker Stance",

        -- Priest forms
        [15473] = "Shadowform",

        -- Rogue stealth
        [1784] = "Stealth",

        -- Monk stances (MoP+)
        [103985] = "Stance of the Fierce Tiger",
        [103986] = "Stance of the Sturdy Ox",
        [103987] = "Stance of the Wise Serpent",

        -- Warlock forms
        [47241] = "Metamorphosis",
    }

    return formNames[formId]
end

--- Check if the player has a specific aura state
--- @param auraState number The aura state to check
--- @return boolean True if the player has the aura state
function RequirementsChecker:HasAuraState(auraState)
    -- Aura state 1 = Server-side script (Dummy aura) - cannot be validated client-side
    -- Examples: "Apply Aura: Dummy (1)" from spells like "Cleave" and "Item - Warrior T16 DPS 2P Bonus"
    -- These are server-side scripts that handle effects like rage generation, cleave procs, etc.
    if auraState == 1 then
        NAG:ThrottledTrace(
            "RequirementsChecker: HasAuraState(1) - Server-side script (Dummy aura), cannot validate client-side",
            "requirements_checker_aura_state_1")
        return true -- Assume true since we can't validate server-side scripts
    end

    -- Aura state 2 = target health below 20%
    if auraState == 2 then
        local targetHealth = UnitHealth("target")
        local targetMaxHealth = UnitHealthMax("target")
        if targetHealth > 0 and targetMaxHealth > 0 then
            local healthPercent = (targetHealth / targetMaxHealth) * 100
            local hasState = healthPercent <= 20
            NAG:ThrottledTrace(format("RequirementsChecker: HasAuraState(2) - target health: %.1f%% (<=20%%: %s)",
                healthPercent, tostring(hasState)), "requirements_checker_aura_state_2_health")
            return hasState
        else
            NAG:ThrottledTrace("RequirementsChecker: HasAuraState(2) - no target or invalid health",
                "requirements_checker_aura_state_2_no_target")
            return false
        end
    end

    -- For other aura states, check if the player has the aura
    local hasAuraState = NAG:AuraIsActive(auraState)
    NAG:ThrottledTrace(format("RequirementsChecker: HasAuraState(%d) - %s", auraState, tostring(hasAuraState)),
        "requirements_checker_aura_state_" .. auraState)
    return hasAuraState
end

--- Check if the target has a specific aura state
--- @param auraState number The aura state to check
--- @return boolean True if the target has the aura state
function RequirementsChecker:HasTargetAuraState(auraState)
    -- Aura state 2 = target health below 20%
    if auraState == 2 then
        local targetHealth = UnitHealth("target")
        local targetMaxHealth = UnitHealthMax("target")
        if targetHealth > 0 and targetMaxHealth > 0 then
            local healthPercent = (targetHealth / targetMaxHealth) * 100
            local hasState = healthPercent <= 20
            NAG:ThrottledTrace(
                format("RequirementsChecker: HasTargetAuraState(2) - target health: %.1f%% (<=20%%: %s)",
                    healthPercent, tostring(hasState)), "requirements_checker_target_aura_state_2_health")
            return hasState
        else
            NAG:ThrottledTrace("RequirementsChecker: HasTargetAuraState(2) - no target or invalid health",
                "requirements_checker_target_aura_state_2_no_target")
            return false
        end
    end

    -- For other aura states, log and return false for now
    NAG:ThrottledTrace(
        format("RequirementsChecker: HasTargetAuraState(%d) - not implemented, returning false", auraState),
        "requirements_checker_target_aura_state_not_impl_" .. auraState)
    return false
end

--- Check if the player has a stance active
--- @return boolean True if the player has a stance active
function RequirementsChecker:HasStance()
    local formID = StateManager:GetShapeshiftFormID()
    local hasStance = formID ~= nil
    NAG:ThrottledTrace(format("RequirementsChecker: HasStance() - formID: %s, hasStance: %s",
        tostring(formID), tostring(hasStance)), "requirements_checker_has_stance")
    return hasStance
end

--- Check facing requirement
--- @param facingFlags number The facing flags
--- @return boolean True if facing requirement is met
function RequirementsChecker:CheckFacingRequirement(facingFlags)
    if not facingFlags then
        NAG:ThrottledTrace("RequirementsChecker: CheckFacingRequirement() - no facingFlags provided, returning true",
            "requirements_checker_facing_no_flags")
        return true
    end

    -- NOTE: Facing requirement detection is currently disabled due to WoW API restrictions
    -- UnitPosition() doesn't work on non-friendlies, and IsSpellInRange() is unreliable for facing detection
    -- This allows "enable out of combat" functionality to work properly
    -- TODO: Investigate alternative methods for facing detection if needed
    NAG:ThrottledTrace("RequirementsChecker: CheckFacingRequirement() - facing requirements disabled, returning true",
        "requirements_checker_facing_disabled")
    return true
end

--- Check if player is in required area
--- @param areaId number The required area ID
--- @return boolean True if player is in the required area
function RequirementsChecker:IsInRequiredArea(areaId)
    if not areaId then
        NAG:ThrottledTrace("RequirementsChecker: IsInRequiredArea() - no areaId provided, returning true",
            "requirements_checker_area_no_id")
        return true
    end

    local currentAreaId = C_Map.GetBestMapForUnit("player")
    local inRequiredArea = currentAreaId == areaId

    NAG:ThrottledTrace(format("RequirementsChecker: IsInRequiredArea(%d) - current area: %s, in required area: %s",
        areaId, tostring(currentAreaId), tostring(inRequiredArea)), "requirements_checker_area_check_" .. areaId)

    return inRequiredArea
end

--- Get a formatted description of spell requirements
--- @param spellId number The spell ID to get requirements for
--- @return string|nil Formatted requirements description or nil if no requirements
function RequirementsChecker:GetRequirementsDescription(spellId)
    local req = self:GetRequirements(spellId)
    if not req then
        NAG:ThrottledTrace(
            format("RequirementsChecker: GetRequirementsDescription(%d) - no requirements found", spellId),
            "requirements_checker_desc_no_reqs_" .. spellId)
        return nil
    end

    NAG:ThrottledTrace(format("RequirementsChecker: GetRequirementsDescription(%d) - building description", spellId),
        "requirements_checker_desc_building_" .. spellId)
    local parts = {}

    if req.shapeshiftForm then
        local formName = self:GetShapeshiftFormName(req.shapeshiftForm) or format("Form %d", req.shapeshiftForm)
        table.insert(parts, format("Requires: %s", formName))
        NAG:ThrottledTrace(format("RequirementsChecker: Added shapeshift form requirement: %s", formName),
            "requirements_checker_desc_shapeshift_" .. spellId)
    end

    if req.requiredCasterAura then
        local spellInfo = WoWAPI.GetSpellInfo(req.requiredCasterAura)
        local auraName = spellInfo and spellInfo.name or format("Aura %d", req.requiredCasterAura)
        table.insert(parts, format("Requires: %s", auraName))
        NAG:ThrottledTrace(format("RequirementsChecker: Added required caster aura: %s", auraName),
            "requirements_checker_desc_caster_aura_" .. spellId)
    end

    if req.excludeCasterAura then
        local spellInfo = WoWAPI.GetSpellInfo(req.excludeCasterAura)
        local auraName = spellInfo and spellInfo.name or format("Aura %d", req.excludeCasterAura)
        table.insert(parts, format("Cannot cast while: %s", auraName))
        NAG:ThrottledTrace(format("RequirementsChecker: Added excluded caster aura: %s", auraName),
            "requirements_checker_desc_exclude_caster_" .. spellId)
    end

    if req.requiredTargetAura then
        local spellInfo = WoWAPI.GetSpellInfo(req.requiredTargetAura)
        local auraName = spellInfo and spellInfo.name or format("Aura %d", req.requiredTargetAura)
        table.insert(parts, format("Target requires: %s", auraName))
        NAG:ThrottledTrace(format("RequirementsChecker: Added required target aura: %s", auraName),
            "requirements_checker_desc_target_aura_" .. spellId)
    end

    if req.excludeTargetAura then
        local spellInfo = WoWAPI.GetSpellInfo(req.excludeTargetAura)
        local auraName = spellInfo and spellInfo.name or format("Aura %d", req.excludeTargetAura)
        table.insert(parts, format("Cannot cast while target has: %s", auraName))
        NAG:ThrottledTrace(format("RequirementsChecker: Added excluded target aura: %s", auraName),
            "requirements_checker_desc_exclude_target_" .. spellId)
    end

    -- Check for OR conditions
    if req.hasOrCondition then
        table.insert(parts, req.orConditionDescription or "OR condition required")
        NAG:ThrottledTrace(
            format("RequirementsChecker: Added OR condition description: %s", req.orConditionDescription or "Unknown"),
            "requirements_checker_desc_or_condition_" .. spellId)
    else
        if req.targetAuraState then
            if req.targetAuraState == 2 then
                table.insert(parts, "Target health below 20%")
                NAG:ThrottledTrace("RequirementsChecker: Added target health requirement (aura state 2)",
                    "requirements_checker_desc_target_health_" .. spellId)
            else
                table.insert(parts, format("Target requires aura state %d", req.targetAuraState))
                NAG:ThrottledTrace(
                    format("RequirementsChecker: Added target aura state requirement: %d", req.targetAuraState),
                    "requirements_checker_desc_target_aura_state_" .. spellId)
            end
        end
    end

    if req.class then
        table.insert(parts, format("Requires %s class", req.class))
        NAG:ThrottledTrace(format("RequirementsChecker: Added class requirement: %s", req.class),
            "requirements_checker_desc_class_" .. spellId)
    end

    if req.stance then
        local stanceName = self:GetShapeshiftFormName(req.stance) or format("Stance %d", req.stance)
        table.insert(parts, format("Requires: %s", stanceName))
        NAG:ThrottledTrace(format("RequirementsChecker: Added stance requirement: %s", stanceName),
            "requirements_checker_desc_stance_" .. spellId)
    end

    if req.facingFlags then
        table.insert(parts, "Requires facing target")
        NAG:ThrottledTrace(format("RequirementsChecker: Added facing requirement: %d", req.facingFlags),
            "requirements_checker_desc_facing_" .. spellId)
    end

    if req.requiredArea then
        local areaName = C_Map.GetMapInfo(req.requiredArea)
        local areaText = areaName and areaName.name or format("Area %d", req.requiredArea)
        table.insert(parts, format("Must be in: %s", areaText))
        NAG:ThrottledTrace(
            format("RequirementsChecker: Added area requirement: %s (ID: %d)", areaText, req.requiredArea),
            "requirements_checker_desc_area_" .. spellId)
    end

    if #parts > 0 then
        local description = table.concat(parts, " | ")
        NAG:ThrottledTrace(format("RequirementsChecker: Final description for spell %d: %s", spellId, description),
            "requirements_checker_desc_final_" .. spellId)
        return description
    end

    NAG:ThrottledTrace(format("RequirementsChecker: No requirement parts found for spell %d", spellId),
        "requirements_checker_desc_no_parts_" .. spellId)
    return nil
end

--- Clear the requirement description cache (useful for testing or when requirements change)
function RequirementsChecker:ClearRequirementCache()
    wipe(requirementDescriptionCache)
    NAG:ThrottledTrace("RequirementsChecker: Cleared requirement description cache",
        "requirements_checker_clear_req_cache")
end

--- Clear the spell validation cache (useful for testing or when spell data changes)
function RequirementsChecker:ClearSpellValidationCache()
    wipe(spellValidationCache)
    NAG:ThrottledTrace("RequirementsChecker: Cleared spell validation cache", "requirements_checker_clear_spell_cache")
end

--- Clear all caches (useful for testing or when data changes)
function RequirementsChecker:ClearAllCaches()
    self:ClearRequirementCache()
    self:ClearSpellValidationCache()
    NAG:ThrottledTrace("RequirementsChecker: Cleared all caches", "requirements_checker_clear_all_caches")
end

--- Debug function to test requirements for a specific spell
--- @param spellId number The spell ID to test
function RequirementsChecker:TestSpellRequirements(spellId)
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    local spellName = spellInfo and spellInfo.name or format("Spell %d", spellId)
    NAG:ThrottledInfo(format("RequirementsChecker: === TESTING SPELL REQUIREMENTS ==="),
        "requirements_checker_test_start_" .. spellId)
    NAG:ThrottledInfo(format("RequirementsChecker: Spell: %s (ID: %d)", spellName, spellId),
        "requirements_checker_test_spell_" .. spellId)

    -- Check if we have requirements data
    local req = self:GetRequirements(spellId)
    if not req then
        NAG:ThrottledInfo(format("RequirementsChecker: No requirements data found for %s", spellName),
            "requirements_checker_test_no_reqs_" .. spellId)
        return
    end

    -- Show all requirements
    NAG:ThrottledInfo(format("RequirementsChecker: Requirements found for %s:", spellName),
        "requirements_checker_test_reqs_found_" .. spellId)

    -- Log all requirement fields found
    for key, value in pairs(req) do
        NAG:ThrottledInfo(format("  - %s: %s", key, tostring(value)),
            "requirements_checker_test_field_" .. spellId .. "_" .. key)
    end

    if req.shapeshiftForm then
        local formName = self:GetShapeshiftFormName(req.shapeshiftForm) or format("Form %d", req.shapeshiftForm)
        NAG:ThrottledInfo(format("  - Shapeshift Form: %s (ID: %d)", formName, req.shapeshiftForm),
            "requirements_checker_test_shapeshift_" .. spellId)
    end

    if req.auraState then
        NAG:ThrottledInfo(format("  - Aura State: %d", req.auraState), "requirements_checker_test_aura_state_" .. spellId)
    end

    if req.requiredCasterAura then
        local spellInfo = WoWAPI.GetSpellInfo(req.requiredCasterAura)
        local auraName = spellInfo and spellInfo.name or format("Aura %d", req.requiredCasterAura)
        NAG:ThrottledInfo(format("  - Required Caster Aura: %s (ID: %d)", auraName, req.requiredCasterAura),
            "requirements_checker_test_caster_aura_" .. spellId)
    end

    if req.excludeCasterAura then
        local spellInfo = WoWAPI.GetSpellInfo(req.excludeCasterAura)
        local auraName = spellInfo and spellInfo.name or format("Aura %d", req.excludeCasterAura)
        NAG:ThrottledInfo(format("  - Excluded Caster Aura: %s (ID: %d)", auraName, req.excludeCasterAura),
            "requirements_checker_test_exclude_caster_" .. spellId)
    end

    if req.requiredTargetAura then
        local spellInfo = WoWAPI.GetSpellInfo(req.requiredTargetAura)
        local auraName = spellInfo and spellInfo.name or format("Aura %d", req.requiredTargetAura)
        NAG:ThrottledInfo(format("  - Required Target Aura: %s (ID: %d)", auraName, req.requiredTargetAura),
            "requirements_checker_test_target_aura_" .. spellId)
    end

    if req.excludeTargetAura then
        local spellInfo = WoWAPI.GetSpellInfo(req.excludeTargetAura)
        local auraName = spellInfo and spellInfo.name or format("Aura %d", req.excludeTargetAura)
        NAG:ThrottledInfo(format("  - Excluded Target Aura: %s (ID: %d)", auraName, req.excludeTargetAura),
            "requirements_checker_test_exclude_target_" .. spellId)
    end

    if req.targetAuraState then
        NAG:ThrottledInfo(format("  - Target Aura State: %d", req.targetAuraState),
            "requirements_checker_test_target_aura_state_" .. spellId)
    end

    if req.class then
        NAG:ThrottledInfo(format("  - Class: %s", req.class), "requirements_checker_test_class_" .. spellId)
    end

    if req.stance then
        NAG:ThrottledInfo(format("  - Stance: %s", tostring(req.stance)), "requirements_checker_test_stance_" .. spellId)
    end

    if req.facingFlags then
        NAG:ThrottledInfo(format("  - Facing Flags: %d", req.facingFlags), "requirements_checker_test_facing_" .. spellId)
    end

    if req.requiredArea then
        NAG:ThrottledInfo(format("  - Required Area: %d", req.requiredArea), "requirements_checker_test_area_" .. spellId)
    end

    -- Test the actual requirement check
    local canCast, errorMsg = self:CanCastSpell(spellId)
    NAG:ThrottledInfo(format("RequirementsChecker: Can cast %s: %s", spellName, tostring(canCast)),
        "requirements_checker_test_can_cast_" .. spellId)
    if not canCast then
        NAG:ThrottledInfo(format("RequirementsChecker: Error: %s", errorMsg),
            "requirements_checker_test_error_" .. spellId)
    end

    NAG:ThrottledInfo(format("RequirementsChecker: === END TEST ==="), "requirements_checker_test_end_" .. spellId)
end

--- Debug function to check what's in DataManager for a spell
--- @param spellId number The spell ID to check
function RequirementsChecker:TestDataManagerSpell(spellId)
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    local spellName = spellInfo and spellInfo.name or format("Spell %d", spellId)
    NAG:ThrottledInfo(format("RequirementsChecker: === TESTING DATAMANAGER SPELL ==="),
        "requirements_checker_datamanager_start_" .. spellId)
    NAG:ThrottledInfo(format("RequirementsChecker: Spell: %s (ID: %d)", spellName, spellId),
        "requirements_checker_datamanager_spell_" .. spellId)

    -- Get the spell entry from DataManager

    local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)

    if not entry then
        NAG:ThrottledInfo(format("RequirementsChecker: No DataManager entry found for %s", spellName),
            "requirements_checker_datamanager_no_entry_" .. spellId)
        return
    end

    NAG:ThrottledInfo(format("RequirementsChecker: DataManager entry found for %s:", spellName),
        "requirements_checker_datamanager_entry_found_" .. spellId)
    NAG:ThrottledInfo(format("  - Name: %s", tostring(entry.name)), "requirements_checker_datamanager_name_" .. spellId)
    NAG:ThrottledInfo(format("  - Path: %s", table.concat(entry.path or {}, " > ")),
        "requirements_checker_datamanager_path_" .. spellId)

    -- Show flags
    local flags = {}
    for flag, _ in pairs(entry.flags or {}) do
        table.insert(flags, flag)
    end
    NAG:ThrottledInfo(format("  - Flags: %s", table.concat(flags, ", ")),
        "requirements_checker_datamanager_flags_" .. spellId)

    -- Check if raw data exists
    if entry.raw then
        NAG:ThrottledInfo(format("RequirementsChecker: Raw data found for %s:", spellName),
            "requirements_checker_datamanager_raw_found_" .. spellId)
        for key, value in pairs(entry.raw) do
            NAG:ThrottledInfo(format("  - %s: %s", key, tostring(value)),
                "requirements_checker_datamanager_raw_" .. spellId .. "_" .. key)
        end
    else
        NAG:ThrottledInfo(format("RequirementsChecker: No raw data found for %s", spellName),
            "requirements_checker_datamanager_no_raw_" .. spellId)
    end

    -- Check for requirement fields in the entry
    local requirementFields = {
        "class", "stance", "shapeshiftForm", "auraState", "casterAuraState", "targetAuraState",
        "requiredCasterAura", "requiredTargetAura", "excludeCasterAura", "excludeTargetAura",
        "excludeCasterAuraState", "excludeTargetAuraState", "facingFlags", "minFaction",
        "minReputation", "requiredArea", "requiredAuraVision", "requiredSpellFocus"
    }

    local hasRequirements = false
    for _, field in ipairs(requirementFields) do
        if entry[field] ~= nil then
            if not hasRequirements then
                NAG:ThrottledInfo(format("RequirementsChecker: Requirement fields found for %s:", spellName),
                    "requirements_checker_datamanager_req_fields_" .. spellId)
                hasRequirements = true
            end
            NAG:ThrottledInfo(format("  - %s: %s", field, tostring(entry[field])),
                "requirements_checker_datamanager_field_" .. spellId .. "_" .. field)
        end
    end

    if not hasRequirements then
        NAG:ThrottledInfo(format("RequirementsChecker: No requirement fields found for %s", spellName),
            "requirements_checker_datamanager_no_req_fields_" .. spellId)
    end

    NAG:ThrottledInfo(format("RequirementsChecker: === END DATAMANAGER TEST ==="),
        "requirements_checker_datamanager_end_" .. spellId)
end

-- Export the module for global access
