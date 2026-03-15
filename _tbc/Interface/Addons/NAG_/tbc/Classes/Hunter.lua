local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
local WoWAPI = ns.WoWAPI
local IsUsableSpell = C_Spell and C_Spell.IsSpellUsable or _G.IsUsableSpell
local UnitAura = _G.UnitAura
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff

-- Safe aura check to avoid missing spell errors on clients without the aura
local function AuraActiveKnown(spellId)
    if not spellId then return false end
    local name = WoWAPI.GetSpellInfo(spellId)
    if not name then return false end
    if not NAG:SpellIsKnown(spellId) then return false end
    return NAG:AuraIsActive(spellId)
end

-- Name-based aura check (fallback when ID matching fails)
local function AuraActiveByName(unit, auraName)
    unit = unit or "player"
    if not auraName then return false end

    local function scan(filter)
        local i = 1
        while true do
            local aura = UnitAura(unit, i, filter)
            if not aura then
                break
            end
            -- WoWAPI may return a table (APICompat) or multiple returns (classic)
            local name
            if type(aura) == "table" then
                name = aura.name or aura[1]
            else
                name = select(1, aura)
            end
            if name == auraName then
                return true
            end
            i = i + 1
        end
        return false
    end

    return scan("HELPFUL|PLAYER") or scan("HELPFUL")
end

local function AuraActiveByIds(unit, ids)
    unit = unit or "player"
    if not ids then return false end
    local function scan(filter)
        local i = 1
        while true do
            local aura = UnitAura(unit, i, filter)
            if not aura then break end
            local spellId
            if type(aura) == "table" then
                spellId = aura.spellId or aura.id or aura[10]
            else
                spellId = select(10, aura)
            end
            if spellId then
                for _, id in ipairs(ids) do
                    if spellId == id then
                        return true
                    end
                end
            end
            i = i + 1
        end
        return false
    end
    return scan("HELPFUL|PLAYER") or scan("HELPFUL")
end

local function KillCommandUsable()
    if not IsUsableSpell then
        return false
    end
    local usable = select(1, IsUsableSpell(34026))
    if usable == nil then
        return false
    end
    return usable == true or usable == 1
end

-- Expose Kill Command usability helper to rotation-string sandbox
_G.KillCommandUsable = KillCommandUsable

-- Aspect rank lists (rank-agnostic checks to avoid re-suggesting active aspects)
local HAWK_IDS = {13165, 14318, 14319, 14320, 14321, 14322, 25296, 27044}
local VIPER_IDS = {34074}
local CHEETAH_IDS = {5118}
local PACK_IDS = {13159}

local function AuraActiveAny(ids)
    for _, id in ipairs(ids) do
        local name = WoWAPI.GetSpellInfo(id)
        if name and NAG:AuraIsActive(id) then
            return true
        end
    end
    return false
end

local function AspectHawkActive()
    if AuraActiveAny(HAWK_IDS) then return true end
    if AuraActiveByIds("player", HAWK_IDS) then return true end
    local hawkName = select(1, WoWAPI.GetSpellInfo(27044))
    return AuraActiveByName("player", hawkName)
end

local function AspectViperActive()
    if AuraActiveAny(VIPER_IDS) then return true end
    if AuraActiveByIds("player", VIPER_IDS) then return true end
    local viperName = select(1, WoWAPI.GetSpellInfo(34074))
    return AuraActiveByName("player", viperName)
end

local function AspectCheetahActive() return AuraActiveAny(CHEETAH_IDS) end
local function AspectPackActive() return AuraActiveAny(PACK_IDS) end

-- True when not in group or we are the only hunter in the group (for Hunter's Mark importance gating).
-- Delegates to centralized group API (player class, full group scope).
_G.HunterIsOnlyHunterInGroup = function()
    return NAG:IsOnlyClassInGroup()
end

-- Concussive Shot (5116): only when target is targeting me and not casting, and fight > 5s
local UnitCastingInfo = _G.UnitCastingInfo
local UnitGUID = _G.UnitGUID
local UnitExists = _G.UnitExists
local function HunterTargetIsTargetingMe()
    return UnitExists("target") and UnitExists("targettarget") and UnitGUID("targettarget") == UnitGUID("player")
end
local function HunterTargetNotCasting()
    if not UnitCastingInfo then return true end
    return not UnitCastingInfo("target")
end
_G.HunterTargetIsTargetingMe = HunterTargetIsTargetingMe
_G.HunterTargetNotCasting = HunterTargetNotCasting

-- Expose for rotation-string execution (loadstring runs in global env)
_G.AuraActiveKnown = AuraActiveKnown
_G.AspectHawkActive = AspectHawkActive
_G.AspectViperActive = AspectViperActive
_G.AspectCheetahActive = AspectCheetahActive
_G.AspectPackActive = AspectPackActive

-- ============================ TBC HUNTER COMMON FUNCTIONS ============================
--- Updates the stable pets information for the Hunter class.
--- TBC only has 1 active pet slot, so this is a simple stub.
--- @function ns.HUNTER_UpdateStablePets
function ns.HUNTER_UpdateStablePets()
    -- TBC Hunter only has 1 pet slot (Call Pet = spell ID 883)
    -- No multiple pet slots like later expansions
end

local defaults = ns.InitializeClassDefaults()

-- TBC Hunter spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Beast Mastery
        -- ABOVE spells (Pet summon, Aspects & Debuffs)
        [883] = NAG.SPELL_POSITIONS.BELOW,      -- Call Pet (top priority when no pet)
        [27044] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Hawk (Rank 8)
        [14322] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Hawk (lower rank, reminder on top)
        [34074] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Viper (same position as Hawk)
        [5118] = NAG.SPELL_POSITIONS.BELOW,    -- Aspect of the Cheetah
        [13159] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Pack
        [14325] = NAG.SPELL_POSITIONS.BELOW,   -- Hunter's Mark (Rank 4)
        [34026] = NAG.SPELL_POSITIONS.BELOW,   -- Kill Command
        [3043] = NAG.SPELL_POSITIONS.BELOW,    -- Scorpid Sting
        [13555] = NAG.SPELL_POSITIONS.BELOW,   -- Serpent Sting (assignment)

        -- LEFT spells (Cooldowns, racials)
        [19574] = NAG.SPELL_POSITIONS.LEFT,    -- Bestial Wrath
        [3045] = NAG.SPELL_POSITIONS.LEFT,     -- Rapid Fire
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- RIGHT spells (Melee weaving / utility)
        [14266] = NAG.SPELL_POSITIONS.LEFT,   -- Raptor Strike (forced primary when at melee)
        [27014] = NAG.SPELL_POSITIONS.LEFT,   -- Raptor Strike (Rank 9, weave)
        [5116] = NAG.SPELL_POSITIONS.LEFT,    -- Concussive Shot

    },
    [2] = { -- Marksmanship
        -- ABOVE spells (Pet summon, Aspects & Debuffs)
        [883] = NAG.SPELL_POSITIONS.BELOW,      -- Call Pet (top priority when no pet)
        [27044] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Hawk (Rank 8)
        [14322] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Hawk (lower rank, reminder on top)
        [34074] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Viper (same position as Hawk)
        [5118] = NAG.SPELL_POSITIONS.BELOW,    -- Aspect of the Cheetah
        [13159] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Pack
        [14325] = NAG.SPELL_POSITIONS.BELOW,   -- Hunter's Mark (Rank 4)
        [34026] = NAG.SPELL_POSITIONS.BELOW,   -- Kill Command
        [3043] = NAG.SPELL_POSITIONS.BELOW,    -- Scorpid Sting
        [13555] = NAG.SPELL_POSITIONS.BELOW,   -- Serpent Sting (assignment)

        -- LEFT spells (Cooldowns, racials)
        [3045] = NAG.SPELL_POSITIONS.LEFT,     -- Rapid Fire
        [27065] = NAG.SPELL_POSITIONS.LEFT,    -- Aimed Shot (Rank 7)
        [23989] = NAG.SPELL_POSITIONS.LEFT,    -- Readiness
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- RIGHT spells (Melee weaving / utility)
        [14266] = NAG.SPELL_POSITIONS.PRIMARY,   -- Raptor Strike (forced primary when at melee)
        [27014] = NAG.SPELL_POSITIONS.BELOW,   -- Raptor Strike (Rank 9, weave)
        [5116] = NAG.SPELL_POSITIONS.BELOW,    -- Concussive Shot

        -- AOE spells
        [27021] = NAG.SPELL_POSITIONS.AOE,     -- Multi-Shot (Rank 6)
    },
    [3] = { -- Survival
        -- ABOVE spells (Pet summon, Aspects & Debuffs)
        [883] = NAG.SPELL_POSITIONS.BELOW,      -- Call Pet (top priority when no pet)
        [27044] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Hawk (Rank 8)
        [14322] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Hawk (lower rank, reminder on top)
        [34074] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Viper (same position as Hawk)
        [5118] = NAG.SPELL_POSITIONS.BELOW,    -- Aspect of the Cheetah
        [13159] = NAG.SPELL_POSITIONS.BELOW,   -- Aspect of the Pack
        [14325] = NAG.SPELL_POSITIONS.BELOW,   -- Hunter's Mark (Rank 4)
        [34026] = NAG.SPELL_POSITIONS.BELOW,   -- Kill Command
        [3043] = NAG.SPELL_POSITIONS.BELOW,    -- Scorpid Sting
        [13555] = NAG.SPELL_POSITIONS.BELOW,   -- Serpent Sting (assignment)

        -- LEFT spells (Cooldowns, racials)
        [3045] = NAG.SPELL_POSITIONS.LEFT,     -- Rapid Fire
        [23989] = NAG.SPELL_POSITIONS.LEFT,    -- Readiness
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- RIGHT spells (Melee weaving / utility)
        [14266] = NAG.SPELL_POSITIONS.PRIMARY,   -- Raptor Strike (forced primary when at melee)
        [27014] = NAG.SPELL_POSITIONS.BELOW,   -- Raptor Strike (Rank 9, weave)
        [5116] = NAG.SPELL_POSITIONS.BELOW,    -- Concussive Shot

        -- AOE spells
        [27021] = NAG.SPELL_POSITIONS.AOE,     -- Multi-Shot (Rank 6)
    },
}

-- Class assignments: maintain debuffs only when user opts in (solo = "I maintain"; in group = assigned).
-- Assignments are not important when not in group; toggles mean "I maintain this" in both cases.
defaults.class.allowMultipleAssignments = true
defaults.class.recommendAspects = true         -- Opt-out toggle for all aspect management
defaults.class.viperStartManaPercent = 0.20    -- Switch TO Viper at or below this %
defaults.class.viperStopManaPercent = 0.40     -- Switch back TO Hawk at or above this %
defaults.class.classAssignments = {
    {
        id = "hunters_mark",
        name = "Hunter's Mark",
        description = "Maintain Hunter's Mark on the target (one hunter per raid usually assigned)",
        spellIds = {14325, 14324, 14323, 14322, 14321}, -- Rank 4 and lower
        category = "debuff",
    },
    {
        id = "scorpid_sting",
        name = "Scorpid Sting",
        description = "Maintain Scorpid Sting for raid armor reduction (if assigned)",
        spellIds = {3043, 14275, 14276, 14277}, -- All ranks
        category = "debuff",
    },
    {
        id = "serpent_sting",
        name = "Serpent Sting",
        description = "Maintain Serpent Sting DoT on the target (if assigned)",
        spellIds = {13555, 13554, 13553, 13552, 13551, 13550, 13549, 1978}, -- TBC ranks and base
        category = "debuff",
    },
}
defaults.char.assignmentToggles = defaults.char.assignmentToggles or {}
if defaults.char.assignmentToggles.hunters_mark == nil then
    defaults.char.assignmentToggles.hunters_mark = true  -- Hunter's Mark shown at top by default on all specs
end
if defaults.char.assignmentToggles.scorpid_sting == nil then
    defaults.char.assignmentToggles.scorpid_sting = false
end
if defaults.char.assignmentToggles.serpent_sting == nil then
    defaults.char.assignmentToggles.serpent_sting = false
end

if UnitClassBase('player') ~= "HUNTER" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
    (not NAG:AuraIsActive(13165)) and NAG:SpellCanCast(13165) and NAG:Cast(13165)
    or (NAG:SpellCanCast(1978) and (not NAG:DotIsActive(1978, "target"))) and NAG:Cast(1978)
    or (NAG:SpellCanCast(3044)) and NAG:Cast(3044)
]],
}

-- ============================ BEAST MASTERY ROTATION ============================
local beastMasteryRotation = {
    -- Core identification
    name = "Beast Mastery",
    specIndex = 1,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,

    prePull = {
        { time = -3.0, action = "NAG:Cast(14325)" },  -- Hunter's Mark (Rank 4)
        { time = -1.5, action = "NAG:Cast(27044)" },  -- Aspect of the Hawk (Rank 8)
    },

    lastModified = "12/10/2025",
    -- TBC uses function-based execution (validation skipped for TBC)
    -- Aspects first, then Kill Command > Bestial Wrath > Steady Shot
    rotationString = [[
NAG:EnableTBCHunterSteadyBars()
or NAG:PetIsActive() and KillCommandUsable() and NAG:Cast(34026)
-- No pet: summon pet first (top priority all specs)
or (not NAG:PetIsActive() and NAG:SpellIsKnown(883) and NAG:Cast(883, nil, NAG.SPELL_POSITIONS.BELOW))
-- Aspect of the Hawk (14322/27044): only force when no Hawk/Viper is active (prevents Viper/Hawk ping-pong)
or (not AspectHawkActive() and not AspectViperActive() and NAG:SpellIsKnown(27044) and NAG:Cast(27044))
or (not AspectHawkActive() and not AspectViperActive() and not NAG:SpellIsKnown(27044) and NAG:SpellIsKnown(14322) and NAG:Cast(14322))
-- Viper when mana drops below threshold; Hawk back above threshold when Viper active (Viper same position as Hawk: BELOW)
or (NAG:GetClassSetting('recommendAspects', true) and (
    (NAG:CurrentManaPercent() <= NAG:GetClassSetting('viperStartManaPercent', 0.20) and NAG:SpellIsKnown(34074) and not AspectViperActive() and NAG:Cast(34074))
    or (NAG:CurrentManaPercent() >= NAG:GetClassSetting('viperStopManaPercent', 0.40) and AspectViperActive() and NAG:SpellIsKnown(27044) and not AspectHawkActive() and NAG:Cast(27044))
))
-- Assignments: Hunter's Mark (solo/only hunter: out of combat or in combat when TTL > 20s; multi-hunter: when assigned)
or (NAG:IsAssignmentEnabled("hunters_mark") and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(14325) and NAG:SpellIsReady(14325) and (not NAG:AuraIsActive(14325, "target")) and ((not HunterIsOnlyHunterInGroup()) or (not NAG:InCombat()) or (NAG:InCombat() and NAG:RemainingTime() > 20)) and NAG:Cast(14325, nil, NAG.SPELL_POSITIONS.LEFT))
-- Prepatch prepull (no Steady Shot): cast Aimed BEFORE ensuring Auto Shot
or (not NAG:InCombat()) and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(27065) and NAG:SpellIsReady(27065) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Cast(27065, nil, NAG.SPELL_POSITIONS.PRIMARY)
-- 0) Ensure Auto Shot is ON (blocks the rest until true)
or NAG:HunterUpdateAutoShotState()
-- Out of combat opener: start with Aimed Shot (all specs, whether or not Steady Shot is known), shown in the middle
or ((not NAG:InCombat()) and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(27065) and NAG:SpellIsReady(27065) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Cast(27065, nil, NAG.SPELL_POSITIONS.PRIMARY))
--or NAG:HunterEnsureAutoShot()
-- Melee range: Raptor Strike in PRIMARY when ready and not queued (high priority)
or (NAG:HunterInMelee("target") or NAG:TargetInMeleeRange(1))
    and NAG:UnitExists("target")
    and NAG:UnitCanAttack("player", "target")
    and (not (NAG:IsQueued(14266) or NAG:IsQueued(27014)))
    and NAG:Cast(14266, nil, NAG.SPELL_POSITIONS.PRIMARY)
-- Pet check: warn if pet is not attacking while in combat
or (NAG:PetIsActive() and NAG:InCombat() and NAG:UnitExists("target")
    and ((not NAG:UnitExists("pettarget")) or (not NAG:InCombat("pet"))))
    and NAG:ShowCustomOverlay("Pet Not Attacking")
or (NAG:IsAssignmentEnabled("scorpid_sting") and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(3043) and NAG:SpellIsReady(3043) and (not NAG:AuraIsActive(3043, "target")) and NAG:Cast(3043, nil, NAG.SPELL_POSITIONS.LEFT))
or (NAG:IsAssignmentEnabled("serpent_sting") and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(13555) and NAG:SpellIsReady(13555) and (not NAG:AuraIsActive(13555, "target")) and NAG:Cast(13555, nil, NAG.SPELL_POSITIONS.LEFT))
-- Concussive Shot: only when target is targeting me, not casting, and fight > 5s
or (NAG:SpellIsKnown(5116) and NAG:SpellIsReady(5116) and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and HunterTargetIsTargetingMe() and HunterTargetNotCasting() and NAG:RemainingTime() > 5 and NAG:Cast(5116, nil, NAG.SPELL_POSITIONS.BELOW))
-- Cooldowns (LEFT position) - racials and major CDs
or (NAG:SpellIsKnown(20572) and NAG:SpellIsReady(20572) and NAG:Cast(20572, nil, NAG.SPELL_POSITIONS.LEFT))   -- Blood Fury (Orc Racial)
-- NOTE: temporary debug line to confirm HunterSafeToCast is actually being evaluated in-game.
-- It will never stop the APL (ends with `and false`), but should trigger prints if HunterSafeToCast runs.
--or (NAG:HunterIsAutoShooting() and NAG:HunterSafeToCast(34120) and false)


-- Prepatch (no Steady Shot): Aimed Shot cycle + Multi + Arcane (Steady Shot learned at 62 in TBC)
or (not NAG:SpellIsKnown(34120)) and (
    -- Aimed visibility: show whenever off GCD (even if it would clip an Auto)
    (NAG:SpellIsKnown(27065) and NAG:SpellIsReady(27065) and ((NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0) <= 0 and (not (NAG.IsCasting and NAG:IsCasting())) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Cast(27065))
    -- Base filler (prepatch): Multi-Shot > Arcane Shot (fire when ready)
    or (NAG:SpellIsKnown(27021) and NAG:SpellIsReady(27021) and NAG:Cast(27021))
    or (NAG:SpellIsKnown(27019) and NAG:SpellIsReady(27019) and NAG:Cast(27019))
    -- Prepatch (no Steady Shot): within 4s tolerance, show whichever comes off first: Aimed (if known) / Multi / Arcane
    or (NAG:SpellIsKnown(27065) and NAG:SpellTimeToReady(27065) >= 0 and NAG:SpellTimeToReady(27065) <= 4 and NAG:SpellTimeToReady(27065) <= ((NAG:SpellIsKnown(27021) and NAG:SpellTimeToReady(27021) >= 0 and NAG:SpellTimeToReady(27021)) or 999) and NAG:SpellTimeToReady(27065) <= ((NAG:SpellIsKnown(27019) and NAG:SpellTimeToReady(27019) >= 0 and NAG:SpellTimeToReady(27019)) or 999) and NAG:CastSpell(27065, 4))
    or (NAG:SpellIsKnown(27021) and NAG:SpellTimeToReady(27021) >= 0 and NAG:SpellTimeToReady(27021) <= 4 and NAG:SpellTimeToReady(27021) <= ((NAG:SpellIsKnown(27065) and NAG:SpellTimeToReady(27065) >= 0 and NAG:SpellTimeToReady(27065)) or 999) and NAG:SpellTimeToReady(27021) <= ((NAG:SpellIsKnown(27019) and NAG:SpellTimeToReady(27019) >= 0 and NAG:SpellTimeToReady(27019)) or 999) and NAG:CastSpell(27021, 4))
    or (NAG:SpellIsKnown(27019) and NAG:SpellTimeToReady(27019) >= 0 and NAG:SpellTimeToReady(27019) <= 4 and NAG:SpellTimeToReady(27019) <= ((NAG:SpellIsKnown(27065) and NAG:SpellTimeToReady(27065) >= 0 and NAG:SpellTimeToReady(27065)) or 999) and NAG:SpellTimeToReady(27019) <= ((NAG:SpellIsKnown(27021) and NAG:SpellTimeToReady(27021) >= 0 and NAG:SpellTimeToReady(27021)) or 999) and NAG:CastSpell(27019, 4))
    or ((NAG.HunterWaitForAuto and NAG:HunterWaitForAuto() > 0) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Wait(NAG:HunterWaitForAuto()))
    or ((NAG:EnableTBCHunterSteadyBars() or true) and NAG:HunterAimedHold())
)
-- TBC (Steady Shot known): 6-step APL
-- 1) Auto Shot (handled above)
-- 2) SS in wind-up (queues) if not already queued
or (NAG:SpellIsKnown(34120) and NAG:HunterInWarmUp() and (not NAG:HunterSSQueued()) and (NAG:EnableTBCHunterSteadyBars() or ((NAG.HunterEarlyGapMath and NAG:HunterEarlyGapMath()) and NAG:EnableTBCHunterSteadyEARLYgap()) or true) and NAG:Cast(34120))
-- 3) SS if safe-to-finish before Auto (and not queued)
or (NAG:SpellIsKnown(34120) and NAG:HunterSafeToCast(34120) and (not NAG:HunterInWarmUp()) and (not NAG:HunterSSQueued()) and (NAG:EnableTBCHunterSteadyBars() or ((NAG.HunterEarlyGapMath and NAG:HunterEarlyGapMath()) and NAG:EnableTBCHunterSteadyEARLYgap()) or true) and NAG:Cast(34120))
-- Debug probe disabled:
-- or (NAG.HunterDbg_MSARGates and NAG:HunterDbg_MSARGates() and false)
-- 4) MS if safe (and only as filler while we're already in a GCD/cast recovery window)
-- Extra APL guard: never suggest fillers while in/near Auto queue-zone; keep SS re-queue behavior there.
or (NAG:SpellIsKnown(34120) and (not NAG:HunterInWarmUp()) and (not (NAG.HunterAutoQueueZone and NAG:HunterAutoQueueZone())) and ((not NAG:HunterSSQueued()) or (NAG.HunterQueuedSSFillerWindowOK and NAG:HunterQueuedSSFillerWindowOK())) and not(NAG:HunterMSQueued()) and NAG:AutoSwingTime(NAG.Types:GetType("SwingType").Ranged) > 1.7 and NAG:HunterSafeToCast(27021) and NAG:IsGCDOrCastingRecently(0.200, 34120) and NAG:Cast(27021))
-- 5) AR if safe, MS not ready, and allowed
-- Extra APL guard: never suggest fillers while in/near Auto queue-zone; keep SS re-queue behavior there.
or (NAG:SpellIsKnown(34120) and not(NAG:SpellIsReady(27021)) and (not NAG:HunterInWarmUp()) and (not (NAG.HunterAutoQueueZone and NAG:HunterAutoQueueZone())) and ((not NAG:HunterSSQueued()) or (NAG.HunterQueuedSSFillerWindowOK and NAG:HunterQueuedSSFillerWindowOK())) and NAG:AutoSwingTime(NAG.Types:GetType("SwingType").Ranged) > 1.7 and NAG:HunterSafeToCast(27019) and NAG:IsGCDOrCastingRecently(0.200, 34120) and NAG:Cast(27019))
-- 6) HOLD: show Steady or Aimed swipe until it's time to start spamming (wind-up start)
or ((NAG:EnableTBCHunterSteadyBars() or true) and (
    (NAG:SpellIsKnown(34120) and NAG:HunterSteadyHold())
    or ((not NAG:SpellIsKnown(34120)) and NAG:HunterAimedHold())
))
]],
    aplProto = {},  -- Empty proto to skip schema-based parsing

    -- Tracked IDs for optimization (TBC max ranks)
    spells = {
        75,     -- Auto Shot (all hunters)
        883,    -- Call Pet (top priority when no pet)
        14325,  -- Hunter's Mark (Rank 4)
        27044,  -- Aspect of the Hawk (Rank 8)
        14322,  -- Aspect of the Hawk (lower rank, reminder on top)
        34074,  -- Aspect of the Viper
        5118,   -- Aspect of the Cheetah
        13159,  -- Aspect of the Pack
        3043,   -- Scorpid Sting
        27065,  -- Aimed Shot (Rank 7) - prepatch when Steady Shot not yet learned
        27019,  -- Arcane Shot (Rank 9)
        27021,  -- Multi-Shot (Rank 6)
        34120,  -- Steady Shot (TBC level 62+)
        34026,  -- Kill Command
        19574,  -- Bestial Wrath
        3045,   -- Rapid Fire
        20572,  -- Blood Fury (Orc Racial)
        14266,  -- Raptor Strike (forced primary when at melee)
        27014,  -- Raptor Strike (Rank 9)
        5116,   -- Concussive Shot (utility, RIGHT)
        13555,  -- Serpent Sting (assignment)
    },
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    guide = [[
Beast Mastery Hunter Rotation Guide (TBC)

Prepatch (no Steady Shot): Steady Shot is learned at 62. Before that use Aimed Shot (when safe, 3s cast) + Multi-Shot + Arcane Shot, without clipping Auto Shot.

Core Mechanics:
- Pet is your primary damage source. Best pet: Ravager.
- Kill Command procs when your hunter crits - use immediately!
- Auto Shot timing is CRITICAL - never clip autos with casts.
- Melee Weaving: Use Raptor Strike between ranged attacks for extra DPS.

Rotation Priority (Single Target):
1. Call Pet: If no pet is out, summon one first (top priority all specs).
2. Aspect of the Hawk (switch to Viper when low mana)
3. Hunter's Mark (if assigned)
4. Scorpid Sting (if assigned for raid debuff)
5. Rapid Fire + Bestial Wrath + on-use effects
6. Kill Command (when it procs)
7. Multi-Shot OR Steady Shot + Auto Shot (don't clip autos)
8. Raptor Strike (melee weave for extra damage)

Cooldowns:
- Bestial Wrath: 2min CD. Major pet damage boost + immunity.
- Rapid Fire: 5min CD. Haste buff. Sync with Bestial Wrath.

Mana Management:
- Aspect of the Viper: Switch below configurable threshold (default 20% mana).
- Aspect of the Hawk: Switch back above configurable threshold (default 40% mana, when Viper active).

Pet:
- Best pet: Ravager (highest DPS with Gore ability)
- Keep pet alive and on target at all times
- Hunter Weave Bar: enable in options to see French/melee cues
    ]],
    author = "Smufrik",
}

-- ============================ MARKSMANSHIP ROTATION ============================
local marksmanshipRotation = {
    -- Core identification
    name = "Marksmanship",
    specIndex = 2,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,

    prePull = {
        { time = -3.0, action = "NAG:Cast(14325)" },  -- Hunter's Mark (Rank 4)
        { time = -2.5, action = "NAG:Cast(27065)" },  -- Aimed Shot (Rank 7) pre-cast
        { time = -1.0, action = "NAG:Cast(27044)" },  -- Aspect of the Hawk (Rank 8)
    },

    lastModified = "12/10/2025",
    -- TBC uses function-based execution - bypass Proto AST conversion
    -- Aspects first, then Rapid Fire > Aimed Shot > Steady Shot > Arcane Shot
    rotationString = [[
NAG:EnableTBCHunterSteadyBars()
or NAG:PetIsActive() and KillCommandUsable() and NAG:Cast(34026)
-- No pet: summon pet first (top priority all specs)
or (not NAG:PetIsActive() and NAG:SpellIsKnown(883) and NAG:Cast(883))
-- Aspect of the Hawk (14322/27044): only force when no Hawk/Viper is active (prevents Viper/Hawk ping-pong)
or (not AspectHawkActive() and not AspectViperActive() and NAG:SpellIsKnown(27044) and NAG:Cast(27044))
or (not AspectHawkActive() and not AspectViperActive() and not NAG:SpellIsKnown(27044) and NAG:SpellIsKnown(14322) and NAG:Cast(14322))
-- Aspects - Priority 0 (similar to MoP logic)
or (NAG:GetClassSetting('recommendAspects', true) and (
    -- Out of combat + moving: suggest Pack (group) or Cheetah (solo)
    (NAG:UnitIsMoving() and (not NAG:InCombat()) and (
        (NAG:GetNumGroupMembers() > 0 and NAG:SpellIsKnown(13159) and not AspectPackActive() and NAG:Cast(13159))
        or (NAG:GetNumGroupMembers() == 0 and NAG:SpellIsKnown(5118) and not AspectCheetahActive() and NAG:Cast(5118))
    ))
    -- In combat or not moving: manage Hawk/Viper based on mana (Viper same position as Hawk: ABOVE)
    or ((not NAG:UnitIsMoving() or NAG:InCombat()) and (
        -- Low mana: suggest Viper if not active
        (NAG:CurrentManaPercent() <= NAG:GetClassSetting('viperStartManaPercent', 0.20) and NAG:SpellIsKnown(34074) and not AspectViperActive() and NAG:Cast(34074))
        -- Mana recovered: suggest Hawk if Viper is active (switch back)
        or (NAG:CurrentManaPercent() >= NAG:GetClassSetting('viperStopManaPercent', 0.40) and AspectViperActive() and NAG:SpellIsKnown(27044) and not AspectHawkActive() and NAG:Cast(27044))
        -- No aspect active: suggest Hawk
        or (not AspectHawkActive() and not AspectViperActive() and NAG:SpellIsKnown(27044) and NAG:Cast(27044))
    ))
))
-- Prepatch prepull (no Steady Shot): cast Aimed BEFORE ensuring Auto Shot
or ((not NAG:SpellIsKnown(34120)) and (not NAG:InCombat()) and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(27065) and NAG:SpellIsReady(27065) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Cast(27065, nil, NAG.SPELL_POSITIONS.PRIMARY))
-- 0) Ensure Auto Shot is ON (blocks the rest until true)
or NAG:HunterUpdateAutoShotState()
-- Out of combat opener: start with Aimed Shot (all specs, whether or not Steady Shot is known), shown in the middle
or ((not NAG:InCombat()) and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(27065) and NAG:SpellIsReady(27065) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Cast(27065, nil, NAG.SPELL_POSITIONS.PRIMARY))
or NAG:HunterEnsureAutoShot()
-- Melee range: Raptor Strike in PRIMARY when ready and not queued (high priority)
or (((NAG.HunterInMelee and NAG:HunterInMelee("target")) or NAG:TargetInMeleeRange(5))
    and NAG:UnitExists("target")
    and NAG:UnitCanAttack("player", "target")
    and (NAG:SpellIsKnown(14266) or NAG:SpellIsKnown(27014))
    and (NAG:SpellIsReady(14266) or NAG:SpellIsReady(27014))
    and (not (NAG.IsQueued and (NAG:IsQueued(14266) or NAG:IsQueued(27014))))
    and NAG:Cast((NAG:SpellIsReady(27014) and 27014) or 14266, nil, NAG.SPELL_POSITIONS.PRIMARY))

-- Pet check: warn if pet is not attacking while in combat
or (NAG:PetIsActive() and NAG:InCombat() and NAG:UnitExists("target")
    and ((not NAG:UnitExists("pettarget")) or (not NAG:InCombat("pet"))))
    and NAG:ShowCustomOverlay("Pet Not Attacking")
-- Assignments: maintain debuffs only when opted in (in group = assigned; solo = I maintain)
or (NAG:IsAssignmentEnabled("hunters_mark") and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(14325) and NAG:SpellIsReady(14325) and (not NAG:AuraIsActive(14325, "target")) and ((not HunterIsOnlyHunterInGroup()) or (not NAG:InCombat()) or (NAG:InCombat() and NAG:RemainingTime() > 20)) and NAG:Cast(14325))
or (NAG:IsAssignmentEnabled("scorpid_sting") and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(3043) and NAG:SpellIsReady(3043) and (not NAG:AuraIsActive(3043, "target")) and NAG:Cast(3043))
or (NAG:IsAssignmentEnabled("serpent_sting") and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(13555) and NAG:SpellIsReady(13555) and (not NAG:AuraIsActive(13555, "target")) and NAG:Cast(13555))
-- Concussive Shot: only when target is targeting me, not casting, and fight > 5s
or (NAG:SpellIsKnown(5116) and NAG:SpellIsReady(5116) and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and HunterTargetIsTargetingMe() and HunterTargetNotCasting() and NAG:RemainingTime() > 5 and NAG:Cast(5116, nil, NAG.SPELL_POSITIONS.BELOW))
-- Cooldowns (LEFT position) - use when available
or (NAG:SpellIsKnown(20572) and NAG:SpellIsReady(20572) and NAG:Cast(20572, nil, NAG.SPELL_POSITIONS.LEFT))   -- Blood Fury (Orc Racial)
or (NAG:SpellIsKnown(3045) and NAG:SpellIsReady(3045) and NAG:Cast(3045, nil, NAG.SPELL_POSITIONS.LEFT))    -- Rapid Fire (5min CD)
or (NAG:SpellIsKnown(23989) and NAG:SpellIsReady(23989) and NAG:Cast(23989, nil, NAG.SPELL_POSITIONS.LEFT)) -- Readiness (5min CD, resets CDs)
or (NAG:SpellIsKnown(27065) and NAG:SpellIsReady(27065) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Cast(27065, nil, NAG.SPELL_POSITIONS.LEFT)) -- Aimed Shot (main nuke)

-- Main rotation
-- Kill Command only when proc/usable and ready
-- French weave (slow, no major haste)
or (NAG.HunterFrenchMultiReady and NAG:HunterFrenchMultiReady()) and NAG:Cast(27021, nil, NAG.SPELL_POSITIONS.AOE)
or (NAG.HunterFrenchArcaneReady and NAG:HunterFrenchArcaneReady()) and NAG:Cast(27019)

-- General Multi-Shot for cleave only (single-target handled by French weave if active)
or (NAG:SpellIsReady(27021) and NAG:NumberTargets() >= 2) and NAG:Cast(27021, nil, NAG.SPELL_POSITIONS.AOE)

-- Melee weaving
or (NAG.HunterMeleeReady and NAG:HunterMeleeReady()) and NAG:Cast(27014, nil, NAG.SPELL_POSITIONS.BELOW)

-- Avoid clipping Steady during very fast autos (TBC only)
or (NAG:SpellIsKnown(34120) and (NAG.HunterWaitForAuto and NAG:HunterWaitForAuto() > 0) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Wait(NAG:HunterWaitForAuto()))

-- Prepatch (no Steady Shot): Aimed when ready and safe (3s cast), then wait for Auto, else Arcane fallback
-- Aimed visibility: show whenever off GCD (even if it would clip an Auto)
or (not NAG:SpellIsKnown(34120)) and (NAG:SpellIsKnown(27065) and NAG:SpellIsReady(27065) and ((NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0) <= 0 and (not (NAG.IsCasting and NAG:IsCasting())) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Cast(27065, nil, NAG.SPELL_POSITIONS.LEFT))
or (not NAG:SpellIsKnown(34120)) and (NAG:SpellIsKnown(27021) and NAG:SpellIsReady(27021) and NAG:Cast(27021))  -- Multi-Shot > Arcane in prepatch
or (not NAG:SpellIsKnown(34120)) and (NAG:SpellIsKnown(27019) and NAG:SpellIsReady(27019) and NAG:Cast(27019))
or (not NAG:SpellIsKnown(34120)) and ((NAG.HunterWaitForAuto and NAG:HunterWaitForAuto() > 0) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Wait(NAG:HunterWaitForAuto()))
or (not NAG:SpellIsKnown(34120)) and ((NAG:EnableTBCHunterSteadyBars() or true) and NAG:HunterAimedHold())
or (not NAG:SpellIsKnown(34120)) and NAG:Cast(27019)  -- Arcane Shot hard fallback when no Steady

-- TBC (Steady Shot known): Steady filler with safety
or (NAG:SpellIsKnown(34120) and NAG.HunterSafeSteady and NAG:HunterSafeSteady()) and (NAG:EnableTBCHunterSteadyBars() or ((NAG.HunterEarlyGapMath and NAG:HunterEarlyGapMath()) and NAG:EnableTBCHunterSteadyEARLYgap()) or true) and NAG:Cast(34120)
or (NAG:SpellIsKnown(34120) and (NAG:EnableTBCHunterSteadyBars() or ((NAG.HunterEarlyGapMath and NAG:HunterEarlyGapMath()) and NAG:EnableTBCHunterSteadyEARLYgap()) or true) and NAG:Cast(34120))
or NAG:Cast(27019)  -- Arcane Shot (fallback)
]],
    aplProto = {},  -- Empty proto to skip schema-based parsing

    -- Tracked IDs for optimization (TBC max ranks)
    spells = {
        883,    -- Call Pet (top priority when no pet)
        14325,  -- Hunter's Mark (Rank 4)
        27044,  -- Aspect of the Hawk (Rank 8)
        14322,  -- Aspect of the Hawk (lower rank, reminder on top)
        34074,  -- Aspect of the Viper
        5118,   -- Aspect of the Cheetah
        13159,  -- Aspect of the Pack
        3043,   -- Scorpid Sting
        27065,  -- Aimed Shot (Rank 7) - main nuke in prepatch when Steady not yet learned
        27019,  -- Arcane Shot (Rank 9)
        27021,  -- Multi-Shot (Rank 6)
        34120,  -- Steady Shot (TBC level 62+)
        34026,  -- Kill Command
        3045,   -- Rapid Fire
        23989,  -- Readiness
        20572,  -- Blood Fury (Orc Racial)
        14266,  -- Raptor Strike (forced primary when at melee)
        27014,  -- Raptor Strike (Rank 9)
        5116,   -- Concussive Shot (utility, RIGHT)
        13555,  -- Serpent Sting (assignment)
    },
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    guide = [[
Marksmanship Hunter Rotation Guide (TBC)

Prepatch (no Steady Shot): Before level 62 use Aimed Shot when ready and safe (3s cast) + Multi-Shot + Arcane Shot; never clip Auto Shot.

Core Mechanics:
- Trueshot Aura provides raid-wide AP buff.
- Aimed Shot for high burst damage at pull and during fight.
- Auto Shot timing is CRITICAL - never clip autos with casts.
- Melee Weaving: Use Raptor Strike between ranged attacks.

Rotation Priority (Single Target):
1. Call Pet: If no pet is out, summon one first (top priority all specs).
2. Aspect of the Hawk (switch to Viper when low mana)
3. Hunter's Mark (if assigned)
4. Misdirection on tank (threat management)
5. Aimed Shot at pull
6. Rapid Fire + on-use effects
7. Kill Command (when it procs)
8. Steady Shot + Auto Shot in 1:1 rotation (don't clip autos)
9. Multi-Shot (weave in when available)
10. Raptor Strike (melee weave)

Cooldowns:
- Rapid Fire: 5min CD. Haste buff.
- Readiness: 5min CD. Resets all Hunter cooldowns - use strategically!

Mana Management:
- Aspect of the Viper: Switch below configurable threshold (default 20% mana).
- Aspect of the Hawk: Switch back above configurable threshold (default 40% mana, when Viper active).

Pet:
- Best pet: Ravager (highest DPS)
- Kill Command works for all specs!
    ]],
    author = "Smufrik",
}

-- ============================ SURVIVAL ROTATION ============================
-- Note: SV Hunter in TBC is primarily a SUPPORT spec with Expose Weakness for raid utility
local survivalRotation = {
    -- Core identification
    name = "Survival",
    specIndex = 3,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,

    prePull = {
        { time = -3.0, action = "NAG:Cast(14325)" },  -- Hunter's Mark (Rank 4)
        { time = -1.5, action = "NAG:Cast(27044)" },  -- Aspect of the Hawk (Rank 8)
    },

    lastModified = "12/10/2025",
    -- TBC uses function-based execution - bypass Proto AST conversion
    -- Aspects first, then Rapid Fire > Steady Shot > Arcane Shot
    -- Survival focuses on Expose Weakness uptime (passive proc on crit)
    rotationString = [[

NAG:EnableTBCHunterSteadyBars()
or NAG:PetIsActive() and KillCommandUsable() and NAG:Cast(34026)
-- No pet: summon pet first (top priority all specs)
or (not NAG:PetIsActive() and NAG:SpellIsKnown(883) and NAG:Cast(883))
-- Aspect of the Hawk (14322/27044): only force when no Hawk/Viper is active (prevents Viper/Hawk ping-pong)
or (not AspectHawkActive() and not AspectViperActive() and NAG:SpellIsKnown(27044) and NAG:Cast(27044))
or (not AspectHawkActive() and not AspectViperActive() and not NAG:SpellIsKnown(27044) and NAG:SpellIsKnown(14322) and NAG:Cast(14322))
-- Viper when mana drops below threshold; Hawk back above threshold when Viper active (Viper same position as Hawk: BELOW)
or (NAG:GetClassSetting('recommendAspects', true) and (
    (NAG:CurrentManaPercent() <= NAG:GetClassSetting('viperStartManaPercent', 0.20) and NAG:SpellIsKnown(34074) and not AspectViperActive() and NAG:Cast(34074))
    or (NAG:CurrentManaPercent() >= NAG:GetClassSetting('viperStopManaPercent', 0.40) and AspectViperActive() and NAG:SpellIsKnown(27044) and not AspectHawkActive() and NAG:Cast(27044))
))
-- Assignments: Hunter's Mark (solo/only hunter: out of combat or in combat when TTL > 20s; multi-hunter: when assigned)
or (NAG:IsAssignmentEnabled("hunters_mark") and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(14325) and NAG:SpellIsReady(14325) and (not NAG:AuraIsActive(14325, "target")) and ((not HunterIsOnlyHunterInGroup()) or (not NAG:InCombat()) or (NAG:InCombat() and NAG:RemainingTime() > 20)) and NAG:Cast(14325, nil, NAG.SPELL_POSITIONS.LEFT))
-- Prepatch prepull (no Steady Shot): cast Aimed BEFORE ensuring Auto Shot
or (not NAG:InCombat()) and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(27065) and NAG:SpellIsReady(27065) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Cast(27065, nil, NAG.SPELL_POSITIONS.PRIMARY)
-- 0) Ensure Auto Shot is ON (blocks the rest until true)
or NAG:HunterUpdateAutoShotState()
-- Out of combat opener: start with Aimed Shot (all specs, whether or not Steady Shot is known), shown in the middle
or ((not NAG:InCombat()) and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(27065) and NAG:SpellIsReady(27065) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Cast(27065, nil, NAG.SPELL_POSITIONS.PRIMARY))
or NAG:HunterEnsureAutoShot()
-- Melee range: Raptor Strike in PRIMARY when ready and not queued (high priority)
or (NAG:HunterInMelee("target") or NAG:TargetInMeleeRange(5))
    and NAG:UnitExists("target")
    and NAG:UnitCanAttack("player", "target")
    and (not (NAG:IsQueued(14266) or NAG:IsQueued(27014)))
    and NAG:Cast(14266, nil, NAG.SPELL_POSITIONS.PRIMARY)
-- Pet check: warn if pet is not attacking while in combat
or (NAG:PetIsActive() and NAG:InCombat() and NAG:UnitExists("target")
    and ((not NAG:UnitExists("pettarget")) or (not NAG:InCombat("pet"))))
    and NAG:ShowCustomOverlay("Pet Not Attacking")
or (NAG:IsAssignmentEnabled("scorpid_sting") and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(3043) and NAG:SpellIsReady(3043) and (not NAG:AuraIsActive(3043, "target")) and NAG:Cast(3043, nil, NAG.SPELL_POSITIONS.LEFT))
or (NAG:IsAssignmentEnabled("serpent_sting") and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellIsKnown(13555) and NAG:SpellIsReady(13555) and (not NAG:AuraIsActive(13555, "target")) and NAG:Cast(13555, nil, NAG.SPELL_POSITIONS.LEFT))
-- Concussive Shot: only when target is targeting me, not casting, and fight > 5s
or (NAG:SpellIsKnown(5116) and NAG:SpellIsReady(5116) and NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and HunterTargetIsTargetingMe() and HunterTargetNotCasting() and NAG:RemainingTime() > 5 and NAG:Cast(5116, nil, NAG.SPELL_POSITIONS.BELOW))
-- Cooldowns (LEFT position) - racials and major CDs
or (NAG:SpellIsKnown(20572) and NAG:SpellIsReady(20572) and NAG:Cast(20572, nil, NAG.SPELL_POSITIONS.LEFT))   -- Blood Fury (Orc Racial)
-- NOTE: temporary debug line to confirm HunterSafeToCast is actually being evaluated in-game.
-- It will never stop the APL (ends with `and false`), but should trigger prints if HunterSafeToCast runs.
--or (NAG:HunterIsAutoShooting() and NAG:HunterSafeToCast(34120) and false)


-- Prepatch (no Steady Shot): Aimed Shot cycle + Multi + Arcane (Steady Shot learned at 62 in TBC)
or (not NAG:SpellIsKnown(34120)) and (
    -- Aimed visibility: show whenever off GCD (even if it would clip an Auto)
    (NAG:SpellIsKnown(27065) and NAG:SpellIsReady(27065) and ((NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0) <= 0 and (not (NAG.IsCasting and NAG:IsCasting())) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Cast(27065))
    -- Base filler (prepatch): Multi-Shot > Arcane Shot (fire when ready)
    or (NAG:SpellIsKnown(27021) and NAG:SpellIsReady(27021) and NAG:Cast(27021))
    or (NAG:SpellIsKnown(27019) and NAG:SpellIsReady(27019) and NAG:Cast(27019))
    -- Prepatch (no Steady Shot): within 4s tolerance, show whichever comes off first: Aimed (if known) / Multi / Arcane
    or (NAG:SpellIsKnown(27065) and NAG:SpellTimeToReady(27065) >= 0 and NAG:SpellTimeToReady(27065) <= 4 and NAG:SpellTimeToReady(27065) <= ((NAG:SpellIsKnown(27021) and NAG:SpellTimeToReady(27021) >= 0 and NAG:SpellTimeToReady(27021)) or 999) and NAG:SpellTimeToReady(27065) <= ((NAG:SpellIsKnown(27019) and NAG:SpellTimeToReady(27019) >= 0 and NAG:SpellTimeToReady(27019)) or 999) and NAG:CastSpell(27065, 4))
    or (NAG:SpellIsKnown(27021) and NAG:SpellTimeToReady(27021) >= 0 and NAG:SpellTimeToReady(27021) <= 4 and NAG:SpellTimeToReady(27021) <= ((NAG:SpellIsKnown(27065) and NAG:SpellTimeToReady(27065) >= 0 and NAG:SpellTimeToReady(27065)) or 999) and NAG:SpellTimeToReady(27021) <= ((NAG:SpellIsKnown(27019) and NAG:SpellTimeToReady(27019) >= 0 and NAG:SpellTimeToReady(27019)) or 999) and NAG:CastSpell(27021, 4))
    or (NAG:SpellIsKnown(27019) and NAG:SpellTimeToReady(27019) >= 0 and NAG:SpellTimeToReady(27019) <= 4 and NAG:SpellTimeToReady(27019) <= ((NAG:SpellIsKnown(27065) and NAG:SpellTimeToReady(27065) >= 0 and NAG:SpellTimeToReady(27065)) or 999) and NAG:SpellTimeToReady(27019) <= ((NAG:SpellIsKnown(27021) and NAG:SpellTimeToReady(27021) >= 0 and NAG:SpellTimeToReady(27021)) or 999) and NAG:CastSpell(27019, 4))
    or ((NAG.HunterWaitForAuto and NAG:HunterWaitForAuto() > 0) and (NAG:EnableTBCHunterSteadyBars() or true) and NAG:Wait(NAG:HunterWaitForAuto()))
    or ((NAG:EnableTBCHunterSteadyBars() or true) and NAG:HunterAimedHold())
)
-- TBC (Steady Shot known): 6-step APL
-- 1) Auto Shot (handled above)
-- 2) SS in wind-up (queues) if not already queued
or (NAG:SpellIsKnown(34120) and NAG:HunterInWarmUp() and (not NAG:HunterSSQueued()) and (NAG:EnableTBCHunterSteadyBars() or ((NAG.HunterEarlyGapMath and NAG:HunterEarlyGapMath()) and NAG:EnableTBCHunterSteadyEARLYgap()) or true) and NAG:Cast(34120))
-- 3) SS if safe-to-finish before Auto (and not queued)
or (NAG:SpellIsKnown(34120) and NAG:HunterSafeToCast(34120) and (not NAG:HunterInWarmUp()) and (not NAG:HunterSSQueued()) and (NAG:EnableTBCHunterSteadyBars() or ((NAG.HunterEarlyGapMath and NAG:HunterEarlyGapMath()) and NAG:EnableTBCHunterSteadyEARLYgap()) or true) and NAG:Cast(34120))
-- Debug probe disabled:
-- or (NAG.HunterDbg_MSARGates and NAG:HunterDbg_MSARGates() and false)
-- 4) MS if safe (and only as filler while we're already in a GCD/cast recovery window)
-- Extra APL guard: never suggest fillers while in/near Auto queue-zone; keep SS re-queue behavior there.
or (NAG:SpellIsKnown(34120) and (not NAG:HunterInWarmUp()) and (not (NAG.HunterAutoQueueZone and NAG:HunterAutoQueueZone())) and ((not NAG:HunterSSQueued()) or (NAG.HunterQueuedSSFillerWindowOK and NAG:HunterQueuedSSFillerWindowOK())) and not(NAG:HunterMSQueued()) and NAG:AutoSwingTime(NAG.Types:GetType("SwingType").Ranged) > 1.7 and NAG:HunterSafeToCast(27021) and NAG:IsGCDOrCastingRecently(0.200, 34120) and NAG:Cast(27021))
-- 5) AR if safe, MS not ready, and allowed
-- Extra APL guard: never suggest fillers while in/near Auto queue-zone; keep SS re-queue behavior there.
or (NAG:SpellIsKnown(34120) and not(NAG:SpellIsReady(27021)) and (not NAG:HunterInWarmUp()) and (not (NAG.HunterAutoQueueZone and NAG:HunterAutoQueueZone())) and ((not NAG:HunterSSQueued()) or (NAG.HunterQueuedSSFillerWindowOK and NAG:HunterQueuedSSFillerWindowOK())) and NAG:AutoSwingTime(NAG.Types:GetType("SwingType").Ranged) > 1.7 and NAG:HunterSafeToCast(27019) and NAG:IsGCDOrCastingRecently(0.200, 34120) and NAG:Cast(27019))
-- 6) HOLD: show Steady or Aimed swipe until it's time to start spamming (wind-up start)
or ((NAG:EnableTBCHunterSteadyBars() or true) and (
    (NAG:SpellIsKnown(34120) and NAG:HunterSteadyHold())
    or ((not NAG:SpellIsKnown(34120)) and NAG:HunterAimedHold())
))
]],
    aplProto = {},  -- Empty proto to skip schema-based parsing

    -- Tracked IDs for optimization (TBC max ranks)
    spells = {
        883,    -- Call Pet (top priority when no pet)
        14325,  -- Hunter's Mark (Rank 4)
        27044,  -- Aspect of the Hawk (Rank 8)
        14322,  -- Aspect of the Hawk (lower rank, reminder on top)
        34074,  -- Aspect of the Viper
        5118,   -- Aspect of the Cheetah
        13159,  -- Aspect of the Pack
        3043,   -- Scorpid Sting
        27065,  -- Aimed Shot (Rank 7) - prepatch when Steady not yet learned
        27019,  -- Arcane Shot (Rank 9)
        27021,  -- Multi-Shot (Rank 6)
        34120,  -- Steady Shot (TBC level 62+)
        34026,  -- Kill Command
        3045,   -- Rapid Fire
        23989,  -- Readiness
        20572,  -- Blood Fury (Orc Racial)
        14266,  -- Raptor Strike (forced primary when at melee)
        27014,  -- Raptor Strike (Rank 9)
        5116,   -- Concussive Shot (utility, RIGHT)
        34503,  -- Expose Weakness (aura - procs on crit)
        13555,  -- Serpent Sting (assignment)
    },
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    guide = [[
Survival Hunter Rotation Guide (TBC)

IMPORTANT: SV Hunter in TBC is a SUPPORT spec!
- Expose Weakness talent gives raid-wide AP buff when you crit.
- Usually 1 SV Hunter per raid for the debuff.
- SV Hunter typically handles Hunter's Mark duty.

Core Mechanics:
- Expose Weakness: Procs on YOUR crits, adds 25% of your Agility as AP to raid.
- Auto Shot timing is CRITICAL - never clip autos with casts.
- Melee Weaving: Use Raptor Strike between ranged attacks.

Rotation Priority (Single Target):
1. Call Pet: If no pet is out, summon one first (top priority all specs).
2. Aspect of the Hawk (switch to Viper when low mana)
3. Hunter's Mark (SV usually assigned this)
4. Scorpid Sting (if assigned)
5. Rapid Fire + on-use effects
6. Kill Command (when it procs)
7. Multi-Shot OR Steady Shot + Auto Shot (don't clip autos)
8. Raptor Strike (melee weave)

Cooldowns:
- Rapid Fire: 5min CD. Haste buff.
- Readiness: 5min CD. Resets all Hunter cooldowns.

Mana Management:
- Aspect of the Viper: Switch below configurable threshold (default 20% mana).
- Aspect of the Hawk: Switch back above configurable threshold (default 40% mana, when Viper active).

Raid Utility:
- Expose Weakness: 25% of your Agility as AP to entire raid (7 sec duration)
- Keep critting to maintain high uptime on Expose Weakness!
- Hunter's Mark: Usually SV Hunter's responsibility

Pet:
- Best pet: Ravager (highest DPS)
    ]],
    author = "Smufrik",
}

--- @class Hunter : ClassBase
local Hunter = NAG:CreateClassModule("HUNTER", defaults)
if not Hunter then return end

function Hunter:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, beastMasteryRotation)  -- Beast Mastery
    --ns.AddRotationToDefaults(self.defaults, 2, marksmanshipRotation)  -- Marksmanship
    ns.AddRotationToDefaults(self.defaults, 3, survivalRotation)  -- Survival
end

NAG.Class = Hunter

