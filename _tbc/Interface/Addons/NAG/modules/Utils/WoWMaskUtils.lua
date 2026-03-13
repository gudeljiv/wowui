--- @module "NAG.WoWMaskUtils"
--- Provides helpers for decoding numeric WoW mask values (proc masks, spell flags, etc).
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
local _, ns = ...
local bitLib = bit

local band = bitLib.band
local lshift = bitLib.lshift
local bor = bitLib.bor

local sort = table.sort

local WoWMaskUtils = {}
ns.WoWMaskUtils = WoWMaskUtils

local function bitValue(index)
    return lshift(1, index)
end

local function combine(...)
    local value = 0
    for i = 1, select("#", ...) do
        value = bor(value, select(i, ...))
    end
    return value
end

-- NOTE: These masks mirror the WoWSims simulation constants defined in
-- extern/wowsims-mop/sim/core/flags.go (they are NOT Blizzard native bitmasks).
local MASK_DEFINITIONS = {
    procMask = {
        base = {
            ProcMaskEmpty = 1,
            ProcMaskMeleeMHAuto = 2,
            ProcMaskMeleeOHAuto = 4,
            ProcMaskMeleeMHSpecial = 8,
            ProcMaskMeleeOHSpecial = 16,
            ProcMaskRangedAuto = 32,
            ProcMaskRangedSpecial = 64,
            ProcMaskSpellDamage = 128,
            ProcMaskSpellHealing = 256,
            ProcMaskSpellProc = 512,
            ProcMaskMeleeProc = 1024,
            ProcMaskRangedProc = 2048,
            ProcMaskSpellDamageProc = 4096,
        },
        composites = {
            ProcMaskMeleeMH = combine(2, 8),
            ProcMaskMeleeOH = combine(4, 16),
            ProcMaskMeleeWhiteHit = combine(2, 4),
            ProcMaskWhiteHit = combine(2, 4, 32),
            ProcMaskMeleeSpecial = combine(8, 16),
            ProcMaskMeleeOrRangedSpecial = combine(8, 16, 64),
            ProcMaskMelee = combine(2, 4, 8, 16),
            ProcMaskRanged = combine(32, 64),
            ProcMaskMeleeOrRanged = combine(2, 4, 8, 16, 32, 64),
            ProcMaskDirect = combine(2, 4, 8, 16, 32, 64, 128),
            ProcMaskSpecial = combine(8, 16, 64, 128),
            ProcMaskMeleeOrMeleeProc = combine(2, 4, 8, 16, 1024),
            ProcMaskRangedOrRangedProc = combine(32, 64, 2048),
            ProcMaskSpellOrSpellProc = combine(128, 512),
            ProcMaskProc = combine(512, 1024, 2048),
        },
    },
    spellFlag = {
        base = {
            SpellFlagIgnoreArmor = 2,
            SpellFlagIgnoreTargetModifiers = 4,
            SpellFlagIgnoreAttackerModifiers = 8,
            SpellFlagApplyArmorReduction = 16,
            SpellFlagCannotBeDodged = 32,
            SpellFlagBinary = 64,
            SpellFlagBypassAbsorbs = 128,
            SpellFlagChanneled = 256,
            SpellFlagCastWhileChanneling = 512,
            SpellFlagDisease = 1024,
            SpellFlagHelpful = 2048,
            SpellFlagMeleeMetrics = 4096,
            SpellFlagNoOnCastComplete = 8192,
            SpellFlagNoMetrics = 16384,
            SpellFlagNoLogs = 32768,
            SpellFlagAPL = 65536,
            SpellFlagMCD = 131072,
            SpellFlagReactive = 262144,
            SpellFlagNoOnDamageDealt = 524288,
            SpellFlagPrepullOnly = 1048576,
            SpellFlagEncounterOnly = 2097152,
            SpellFlagPotion = 4194304,
            SpellFlagPrepullPotion = 8388608,
            SpellFlagCombatPotion = 16777216,
            SpellFlagNoSpellMods = 33554432,
            SpellFlagCanCastWhileMoving = 67108864,
            SpellFlagPassiveSpell = 134217728,
            SpellFlagSupressDoTApply = 268435456,
            SpellFlagSwapped = 536870912,
            SpellFlagAoE = 1073741824,
            SpellFlagRanged = 2147483648,
            SpellFlagReadinessTrinket = 4294967296,
            SpellFlagAgentReserved1 = 8589934592,
            SpellFlagAgentReserved2 = 17179869184,
            SpellFlagAgentReserved3 = 34359738368,
            SpellFlagAgentReserved4 = 68719476736,
        },
        composites = {
            SpellFlagIgnoreModifiers = combine(4, 8),
        },
    },
    spellSchool = {
        base = {
            SpellSchoolNone = 0,
            SpellSchoolPhysical = 1,
            SpellSchoolArcane = 2,
            SpellSchoolFire = 4,
            SpellSchoolFrost = 8,
            SpellSchoolHoly = 16,
            SpellSchoolNature = 32,
            SpellSchoolShadow = 64,
        },
        composites = {
            SpellSchoolChaos = combine(2, 4, 8, 16, 32, 64),
            SpellSchoolShadowFlame = combine(4, 64),
            SpellSchoolShadowFrost = combine(8, 64),
            SpellSchoolPlague = combine(32, 64),
            SpellSchoolFirestorm = combine(4, 32),
            SpellSchoolElemental = combine(4, 32, 8),
        },
    },
}

for _, definition in pairs(MASK_DEFINITIONS) do
    local ordered = {}
    for name, value in pairs(definition.base) do
        ordered[#ordered + 1] = {name = name, value = value}
    end
    sort(ordered, function(a, b)
        return a.value < b.value
    end)
    definition._orderedBase = ordered
end

local function normalizeValue(value)
    if type(value) == "number" then
        return value
    end
    if type(value) == "string" then
        local numeric = tonumber(value)
        if numeric then
            return numeric
        end
    end
    return nil
end

local function getExactMatch(definition, numeric)
    if numeric == nil then
        return nil
    end
    if definition.composites then
        for name, compositeValue in pairs(definition.composites) do
            if compositeValue == numeric then
                return {name}
            end
        end
    end
    for name, baseValue in pairs(definition.base) do
        if baseValue == numeric then
            return {name}
        end
    end
    return nil
end

local function extractTokens(definition, numeric)
    if not definition or not numeric then
        return {}
    end
    local exact = getExactMatch(definition, numeric)
    if exact then
        return exact
    end
    local tokens = {}
    local orderedBase = definition._orderedBase or definition.base
    if orderedBase then
        for _, data in ipairs(orderedBase) do
            local baseValue = data.value or definition.base[data.name]
            if baseValue and baseValue ~= 0 and band(numeric, baseValue) == baseValue then
                tokens[#tokens + 1] = data.name or data
            end
        end
    end
    return tokens
end

local function formatTokens(tokens, numeric)
    if tokens and #tokens > 0 then
        return table.concat(tokens, " | ")
    end
    if numeric == nil then
        return ""
    end
    return tostring(numeric)
end

function WoWMaskUtils:GetMaskTokens(maskType, value)
    local numeric = normalizeValue(value)
    local definition = MASK_DEFINITIONS[maskType]
    if not definition then
        return {}, numeric
    end
    return extractTokens(definition, numeric), numeric
end

function WoWMaskUtils:FormatMask(maskType, value)
    local tokens, numeric = self:GetMaskTokens(maskType, value)
    return formatTokens(tokens, numeric)
end

function WoWMaskUtils:GetProcMaskTokens(value)
    return self:GetMaskTokens("procMask", value)
end

function WoWMaskUtils:FormatProcMask(value)
    return self:FormatMask("procMask", value)
end

function WoWMaskUtils:GetSpellFlagTokens(value)
    return self:GetMaskTokens("spellFlag", value)
end

function WoWMaskUtils:FormatSpellFlags(value)
    return self:FormatMask("spellFlag", value)
end

function WoWMaskUtils:GetSpellSchoolTokens(value)
    return self:GetMaskTokens("spellSchool", value)
end

function WoWMaskUtils:FormatSpellSchool(value)
    return self:FormatMask("spellSchool", value)
end

return WoWMaskUtils

