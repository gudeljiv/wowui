--- @module "NAG.APLValidatorFallback"
--- Fallback function argument definitions for validation
--- This is a standalone data file (non-Ace module) that can be used
--- as a fallback when schema-based validation is unavailable
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local UnitCanAttack = _G.UnitCanAttack

-- ~~~~~~~~~~ FALLBACK DATA ~~~~~~~~~~
-- Function argument definitions
-- Format: { required = {types}, optional = {types} }
-- Types can be a string for single type or array for multiple allowed types
-- This table provides fallback validation data when schema-based validation fails

--- @class APLValidatorFallback
--- @field functionArgs table Function argument definitions
local APLValidatorFallback = {
    functionArgs = {}
}

ns.APLValidatorFallback = APLValidatorFallback

APLValidatorFallback.functionArgs = {
    -- Spell related functions
    SpellIsKnown = { required = { "id" } },
    IsKnownSpell = { required = { "id" } },
    IsKnownEnchant = { required = { "id" } },
    IsKnownTierset = { required = { "id" } },
    SpellCanCast = { required = { "id" }, optional = { "tolerance" } },
    SpellTimeToReady = { required = { "id" } },
    TimeToReady = { required = { "id" } },
    TimeToReadyEnchant = { required = { "id" } },
    SpellTimeToReadyWithGCD = { required = { "id" } },
    SpellCastTime = { required = { "id" } },
    SpellTravelTime = { required = { "id" } },
    SpellCPM = { required = { "id" } },
    SpellCurrentCost = { required = { "id" } },
    SpellIsChanneling = { required = { "id" } },
    SpellIsCasting = { required = { "id" } },
    SpellChanneledTicks = { required = { "id" } },
    SpellNumCharges = { required = { "id" } },
    SpellTimeToCharge = { required = { "id" } },
    SpellChannelTime = { required = {} },
    SpellInFlight = { required = { "id" } },
    SpellLastCast = { required = {} },
    IsReadySpell = { required = { "id" }, optional = { "tolerance" } },

    -- Aura related functions
    AuraIsKnown = { required = { "id" }, optional = { "sourceUnit" } },
    AuraIsActive = { required = { "id" }, optional = { "sourceUnit" } },
    AuraIsActiveWithReactionTime = { required = { "id" }, optional = { "sourceUnit" } },
    AuraIsInactiveWithReactionTime = { required = { "id" }, optional = { "sourceUnit" } },
    AuraRemainingTime = { required = { "id" }, optional = { "sourceUnit" } },
    ItemRemainingTime = { required = { "id" } },
    AuraNumStacks = { required = { "id" }, optional = { "sourceUnit", "boolean" } },
    AuraInternalCooldown = { required = { "id" }, optional = { "sourceUnit" } },
    AuraICDIsReady = { required = { "id" }, optional = { "sourceUnit", "boolean" } },
    AuraIcdIsReadyWithReactionTime = { required = { "id" }, optional = { "sourceUnit" } },
    AuraShouldRefresh = { required = { "id", "maxOverlap" }, optional = { "sourceUnit" } },
    AuraIsInactive = { required = { "id" }, optional = { "sourceUnit", "boolean" } },
    IsActiveAura = { required = { "id" }, optional = { "sourceUnit" } },
    IsActiveEnchant = { required = { "id" } },
    GetKnownMaxStacks = { required = { "id" } },
    CheckRaidBuffs = { required = { "threshold" } },
    CheckRaidDebuffs = { required = {} },
    ThreatPercent = { required = {}, optional = { "source", "target" } },

    -- DoT related functions
    DotIsActive = { required = { "id" }, optional = { "targetUnit" } },
    DotIsActiveGlobal = { required = { "id" }, optional = { "unit" } },
    DotRemainingTime = { required = { "id" }, optional = { "targetUnit" } },
    DotRemainingTimeGlobal = { required = { "id" }, optional = { "unit" } },
    DotPercentIncrease = { required = { "id" }, optional = { "targetUnit" } },

    DotTickFrequency = { required = { "id" }, optional = { "targetUnit" } },
    DotLowestRemainingTime = { required = { "id" } },
    DotIsActiveOnAllTargets = { required = { "id" } },

    -- Casting actions
    Cast = { required = { "id" }, optional = { { "tolerance", "position" }, "position" } },
    CastSpell = { required = { "id" }, optional = { "tolerance", "boolean" } },
    CastWithSecondary = { required = { "primarySpellId", "secondarySpellId" }, description = "Casts a primary spell with a secondary spell effect" },
    ActivateAura = { required = { "id" } },
    ActivateAuraWithStacks = { required = { "id", "expression" } },
    ActivateAllStatBuffProcAuras = { required = { "swapSet", "statType1", "statType2", "statType3" } },
    CastFriendlySpell = { required = { "id" } },

    -- TODO: These i think need a unit, but our current implementation doesn't support it
    Multidot = { required = { "id" }, optional = { "maxDots", "maxOverlap", "position", "range" } },
    StrictMultidot = { required = { "id" }, optional = { "maxDots", "maxOverlap", "position", "range" } },

    Multishield = { required = { "id" }, optional = { "maxShields", "maxOverlap" } },
    CastAllStatBuffCooldowns = { required = {}, optional = { { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, { "typeValidator", "Stat" } } },
    CastDebuff = { required = { "id" }, optional = { "tolerance" } },
    CastBuff = { required = { "id" }, optional = { "tolerance" } },
    IsSecondarySpell = { required = { "id" } },
    ClearSecondarySpellCache = { required = {} },
    AddSecondarySpell = { required = { "id" } },
    ShouldMultidot = { required = { "id" }, optional = { "maxDots", "maxOverlap", "range" } },
    CastPlaceholder = { required = { "id" }, optional = { { "tolerance", "position" }, "position" } },
    CastPlaceholderWithOverlay = { required = { "id", "text" }, optional = { "position" } },
    CanExecuteSpell = { required = { "id" }, optional = { "unit", "tolerance" } },
    UseCooldowns = { required = {} },

    -- Movement actions
    Move = { required = { "rangeFromTarget" } },
    MoveToRange = { required = { "rangeFromTarget" } },
    MoveDuration = { required = { "duration" } },

    -- Item actions
    ItemSwap = { optional = { "swapSet" } },

    -- Target actions
    ChangeTarget = { required = { "newTarget" } },
    TargetUnit = { required = { "newTarget" } },

    -- Time and combat functions
    Wait = { required = { "expression" } },
    WaitUntil = { required = { "expression" } },
    Schedule = { required = { "time", "callable" } },
    CurrentTime = { required = {} },
    CurrentTimePercent = { required = {} },
    RemainingTime = { required = {} },
    RemainingTimePercent = { required = {} },
    TimeToPercent = { required = { "threshold" } },
    TimeOnTarget = { required = {} },

    -- Core functions (alias targets)
    IsActive = { required = { "id" }, optional = { "sourceUnit", "boolean" } },
    IsReady = { required = { "id" } },
    Cmp = { required = { "expression", "expression", "expression" } },
    DamageTakenLastGlobal = { required = {} },
    DruidCurrentEclipsePhase = { required = {} },
    CurrentGenericResource = { required = {} },
    AvgRemHP = { required = {} },

    -- Resource functions
    CurrentHealth = { required = {}, optional = { "sourceUnit" } },
    MaxHealth = { required = {} },
    CurrentHealthPercent = { optional = { "unit" } },
    CurrentMana = { required = {}, optional = { "sourceUnit" } },
    CurrentManaPercent = { optional = { "sourceUnit" } },
    CurrentRage = { required = {} },
    MaxRage = { required = {} },
    CurrentEnergy = { required = {} },
    MaxEnergy = { required = {} },
    EnergyRegenPerSecond = { required = {} },
    EnergyTimeToTarget = { required = { "expression" } },
    CurrentFocus = { required = {} },
    MaxFocus = { required = {} },
    FocusRegenPerSecond = { required = {} },
    FocusTimeToTarget = { required = { "expression" } },
    CurrentComboPoints = { required = {} },
    MaxComboPoints = { required = {} },
    CurrentRunicPower = { required = {} },
    MaxRunicPower = { required = {} },
    CurrentLunarEnergy = { required = {} },
    CurrentSolarEnergy = { required = {} },
    CurrentHolyPower = { required = {} },
    CurrentSoulShards = { required = {} },
    CurrentDemonicFury = { required = {} },
    CurrentArcaneCharges = { required = {} },
    CurrentBurningEmbers = { required = {} },
    CurrentAttackPower = { required = {} },
    CurrentAlternate = { required = {} },
    CurrentMaelstrom = { required = {} },
    HasComboPoints = { required = { "id" } },
    HasChi = { required = { "id" } },
    HasRunicPower = { required = { "id" }, optional = { "tolerance" } },
    HasRage = { required = { "id" }, optional = { "tolerance" } },
    HasMana = { required = { "id" }, optional = { "tolerance" } },
    HasEnergy = { required = { "id" }, optional = { "tolerance" } },
    HasSoulShards = { required = { "id" }, optional = { "tolerance" } },
    HasLunarPower = { required = { "id" }, optional = { "tolerance" } },
    HasHolyPower = { required = { "id" }, optional = { "tolerance" } },
    HasBurningEmber = { required = { "id" }, optional = { "tolerance" } },
    HasFocus = { required = { "id" }, optional = { "tolerance" } },
    HasResource = { required = { "id", "expression", "tolerance" } },
    GetModifiedSpellPowerCost = { required = { "id" } },
    GetResourceType = { required = {} },
    GetCurrentResource = { required = { "expression" } },
    GetCurrentResourcePercent = { required = { "expression" } },
    GetSecondaryResourceType = { required = {} },
    GetSecondaryResource = { required = {} },
    GetSecondaryResourcePercent = { required = {} },
    PredictResourceValue = { required = { "time", "expression" } },
    PredictResourceValuePercent = { required = { "time", "expression" } },
    PredictResourceAfterSpell = { required = { "time", "expression", "expression" } },
    PredictResourceAfterSequence = { required = { "time", "expression", "expression" } },
    GetRunicPowerRegen = { required = {} },
    PredictRunicPowerFromAutoAttacks = { required = { "time" } },
    GetHasteFactor = { required = {} },
    GetRageRegen = { required = {} },
    GetEnergyRegen = { required = {} },
    GetFocusRegen = { required = {} },
    GetManaRegen = { required = {} },
    SpiritRegen = { required = {} },

    -- Monk-specific Chi functions (aliases)
    MonkCurrentChi = { required = {} },
    MonkMaxChi = { required = {} },

    -- Rune functions
    CurrentRuneCount = { required = { { "typeValidator", "RuneType" } } },
    CurrentNonDeathRuneCount = { required = { { "typeValidator", "RuneType" } } },
    CurrentRuneActive = { required = { { "typeValidator", "RuneSlot" } } },
    CurrentRuneDeath = { required = { { "typeValidator", "RuneSlot" } } },
    RuneCooldown = { required = { { "typeValidator", "RuneType" } } },
    NextRuneCooldown = { required = { { "typeValidator", "RuneType" } } },
    RuneSlotCooldown = { required = { { "typeValidator", "RuneSlot" } } },
    RuneIsEquipped = { required = { "id" } },

    -- Sequence functions
    Sequence = { required = { "sequenceName" }, optional = { "boolean" }, vararg = "spellOrItemOrExpression" },
    StrictSequence = { required = { "sequenceName" }, optional = { "boolean" }, vararg = "spellOrItemOrExpression" },
    SequenceIsComplete = { required = { "sequenceName" } },
    SequenceIsReady = { required = { "sequenceName" }, vararg = "expression" },
    SequenceTimeToReady = { required = { "sequenceName" }, vararg = "expression" },
    StrictSequenceIsReady = { required = { "sequenceName" } },
    StrictSequenceTimeToReady = { required = { "sequenceName" } },
    SpellCastSequence = { required = {} },
    ResetSequences = { required = {} },
    ResetStrictSequences = { required = {} },
    ResetSequence = { required = { "sequenceName" } },
    ResetStrictSequence = { required = { "sequenceName" } },

    -- Target/combat state functions
    IsExecutePhase = { required = { "threshold" } },
    NumberTargets = { required = {}, optional = { "range", "useMeleeFallback" } },
    UnitDistance = { required = {}, optional = { "sourceUnit", "maxRange" }, description = "Gets the distance to a specific unit in yards (defaults to target)" },
    BossSpellIsCasting = { required = { "spellId" }, optional = { "targetUnit" } },
    BossSpellTimeToReady = { required = { "spellId" }, optional = { "targetUnit" } },
    UnitIsMoving = { required = {}, optional = { "unit" } },
    IsPlayerMoving = { required = {} },
    UnitExists = { required = {}, optional = { "unit" } },
    UnitCanAttack = { required = {}, optional = { "sourceUnit", "targetUnit" } },

    -- Pet functions
    PetIsActive = { required = {} },
    PetHealth = { required = {} },
    PetHealthPercent = { required = {} },
    PetSpellIsReady = { required = { "id" } },
    PetCast = { required = { "id" } },
    HunterCurrentPetFocus = { required = {} },
    HunterCurrentPetFocusPercent = { required = {} },
    HunterPetIsActive = { required = {} },
    -- Class-specific functions
    TotemRemainingTime = { required = { "totemSlotOrSpellId" }, description = "Gets remaining time for a totem by slot number (1-4) or spell ID (e.g., 115313 for Jade Serpent Statue)" },
    IsTotemActive = { required = { "totemSlotOrSpellId" }, description = "Checks if a totem is active by slot number (1-4) or spell ID (e.g., 115313 for Jade Serpent Statue)" },
    CatExcessEnergy = { required = {} },
    CatNewSavageRoarDuration = { required = {} },
    WarlockShouldRecastDrainSoul = { required = {} },
    WarlockShouldRefreshCorruption = { optional = { "targetUnit" } },
    WarlockPetIsActive = { required = {} },
    WarlockCurrentPetMana = { required = {} },
    WarlockCurrentPetManaPercent = { required = {} },
    WarlockHandOfGuldanInFlight = { required = {} },
    WarlockHauntInFlight = { required = {} },
    CurrentSealRemainingTime = { required = {} },
    MageCurrentCombustionDotEstimate = { required = {} },
    DebugDoTTracking = { required = { "id" } },
    BrewmasterMonkCurrentStaggerPercent = { required = {} },
    ShamanFireElementalDuration = { required = {} },
    ShamanCanSnapshotStrongerFireElemental = { required = {} },
    Pooling = { required = {} },
    StopPooling = { required = {} },
    RogueHaT = { required = {} },
    DeadlyCalm = { required = {} },
    WarriorShouldSlamOverride = { required = {} },

    -- Misc functions
    AutocastOtherCooldowns = { required = {}, optional = { "enableTrinketSlot1", "enableTrinketSlot2", "enableDefaultBattlePotion", "enableGloveSlot", "enableBeltSlot" } },
    TimeToEnergyTick = { required = {} },
    EnergyThreshold = { required = { "expression" } },
    GCDIsReady = { required = {} },
    GCDTimeToReady = { required = {} },
    AutoTimeToNext = { required = {} },
    AutoSwingTime = { optional = { { "typeValidator", "SwingType" } } },

    -- Cat form specific functions
    CatOptimalRotationAction = { required = {} },
    GuardianHotwDpsRotation = { optional = { "rotationType" } },
    CustomRotation = { required = {} },

    -- Stat procs
    AllTrinketStatProcsActive = { required = {}, optional = { { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, "minIcdSeconds" }, description = "Checks if all trinkets of the specified stat types have active procs" },
    AnyTrinketStatProcsActive = { required = {}, optional = { { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, "minIcdSeconds" }, description = "Checks if any trinket of the specified stat types has an active proc" },
    TrinketProcsMinRemainingTime = { required = {}, optional = { { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, "minIcdSeconds" }, description = "Gets the minimum remaining time of trinket procs for the specified stat types" },
    TrinketProcsMaxRemainingICD = { required = {}, optional = { { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, "minIcdSeconds" }, description = "Gets the maximum remaining ICD of trinket procs for the specified stat types" },
    NumEquippedStatProcTrinkets = { required = {}, optional = { { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, "minIcdSeconds" }, description = "Gets the number of equipped trinkets that match the specified stat types" },
    NumStatBuffCooldowns = { required = {}, optional = { { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, { "typeValidator", "Stat" } }, description = "Gets the number of stat buff cooldowns available for the specified stat types" },
    AnyStatBuffCooldownsActive = { required = {}, optional = { { "typeValidator", "Stat" }, { "typeValidator", "Stat" }, { "typeValidator", "Stat" } }, description = "Checks if any stat buff cooldowns of the specified stat types are currently active" },

    -- Misc actions
    TriggerICD = { required = { "id" } },
    HasTalent = { required = { "id" } },
    HasGlyph = { required = { "id" } },
    GetNetStats = { required = {} },
    GetNetStatsDebug = { required = {} },
    SelectRotation = { required = { "expression" } },
    IsWeakAurasPackInstalled = { required = { "expression" } },
    ClearWeakAurasCache = { required = {} },
    DebugWeakAurasList = { required = {} },
    SmartRotationSwitch = { required = {} },
    AddComboPoints = { required = {} },
    CastPaladinPrimarySeal = { required = {} },

    -- Buff/Debuff type functions
    RaidBuffIsActive = { required = { { "typeValidator", "BuffType" } } },
    RaidDebuffIsActive = { required = { { "typeValidator", "DebuffType" } } },

    -- Target type functions
    TargetMobType = { required = { "mobType", "targetUnit" } },

    -- Encounter/Combat functions
    InCombat = { optional = { "unit" } },
    InEncounter = { required = {} },
    CurrentEncounterId = { required = {} },
    PrepullActive = { required = {} },
    PrepullSecondsRemaining = { required = {} },

    -- Cancel action functions
    CancelBladestorm = { required = {} },
    CancelAstralCommunion = { required = {} },
    GuideAstralCommunion = { required = {} },

    -- Operator functions
    APLValueConst = { required = { "expression" } },
    GetAPLValueType = { required = { "expression" } },
    GetAPLValueBool = { required = { "expression" } },
    GetAPLValueInt = { required = { "expression" } },
    GetAPLValueFloat = { required = { "expression" } },
    GetAPLValueDuration = { required = { "expression" } },
    GetAPLValueString = { required = { "expression" } },
    CoerceAPLValue = { required = { "expression", "expression" } },
    GetHighestPriorityType = { required = { "expression" } },
    CoerceAllToSameType = { required = { "expression" } },
    APLValueCompare = { required = { "expression", "expression", "expression" } },
    EvaluateAPLValueCompare = { required = { "expression" } },
    APLValueMath = { required = { "expression", "expression", "expression" } },
    EvaluateAPLValueMath = { required = { "expression" } },
    APLValueMax = { required = { "expression" } },
    EvaluateAPLValueMax = { required = { "expression" } },
    APLValueMin = { required = { "expression" } },
    EvaluateAPLValueMin = { required = { "expression" } },
    APLValueAnd = { required = { "expression" } },
    EvaluateAPLValueAnd = { required = { "expression" } },
    APLValueOr = { required = { "expression" } },
    EvaluateAPLValueOr = { required = { "expression" } },
    APLValueNot = { required = { "expression" } },
    EvaluateAPLValueNot = { required = { "expression" } },
    Const = { required = { "expression" } },
    And = { required = {}, vararg = "expression" },
    Or = { required = {}, vararg = "expression" },
    Not = { required = { "expression" } },
    Math = { required = { "expression", "expression", "expression" } },
    Max = { required = {}, vararg = "expression" },
    Min = { required = {}, vararg = "expression" },
}

return APLValidatorFallback

