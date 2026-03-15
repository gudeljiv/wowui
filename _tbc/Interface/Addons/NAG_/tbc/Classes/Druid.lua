local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitGUID = _G.UnitGUID
local UnitIsUnit = _G.UnitIsUnit
local GetNumGroupMembers = _G.GetNumGroupMembers
local IsInRaid = _G.IsInRaid
local GetTime = _G.GetTime
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- ============================ FERAL DETECTION CACHE ============================
local FERAL_FORM_ID = 768
local BEAR_FORM_ID = 5487
local DIRE_BEAR_FORM_ID = 9634
local FERAL_CONFIRM_SECONDS = 2.0 -- Require sustained Cat Form before tagging as feral
local FERAL_SCAN_INTERVAL = 2.0
local MANGLE_REFRESH_BUFFER_SECONDS = 3.0
local FERAL_SPEC_INDEX = 2
local FERAL_SHRED_ASSIGNMENT_KEY = "feralShredAssignmentEnabled"

local feralCache = {
    lastScanTime = 0,
    lastRosterKey = "",
    lastInCombat = false,
    feralPresent = false,
    guardianPresent = false,
    catFormSeenAtByGuid = {},
    bearFormSeenAtByGuid = {},
}

--- Returns true when the current spec is Feral.
--- @return boolean
local function IsFeralSpecActive()
    local specCompat = ns.SpecCompat
    if not specCompat or not specCompat.GetCurrentSpecIndex then
        specCompat = NAG:GetModule("SpecCompat", true)
        ns.SpecCompat = specCompat
    end
    if not specCompat or not specCompat.GetCurrentSpecIndex then
        return false
    end
    return specCompat:GetCurrentSpecIndex() == FERAL_SPEC_INDEX
end

--- Returns whether the dedicated feral Shred assignment is effectively enabled.
--- Defaults to ON while grouped when unset.
--- @return boolean
function NAG:IsFeralShredAssignmentEnabled()
    if not IsFeralSpecActive() then
        return false
    end

    local classModule = self:GetClassModule()
    local explicitState = classModule and classModule.db and classModule.db.char and
        classModule.db.char[FERAL_SHRED_ASSIGNMENT_KEY] or nil
    if explicitState ~= nil then
        return explicitState == true
    end

    return self:PlayerIsInGroup() == true
end

--- Update feral/guardian cache with a lightweight roster scan.
--- Cached and re-scanned on roster changes, combat start, or scan interval.
local function UpdateDruidGroupCache()
    local now = GetTime and GetTime() or 0
    local inCombat = NAG:InCombat() == true
    local memberCount = NAG:GetNumGroupMembers() or 0
    local inRaid = NAG:PlayerIsInRaid() or false
    local rosterKey = string.format("%s:%d", inRaid and "raid" or "party", memberCount)

    if memberCount == 0 then
        feralCache.lastRosterKey = rosterKey
        feralCache.lastInCombat = inCombat
        feralCache.lastScanTime = now
        feralCache.feralPresent = false
        feralCache.guardianPresent = false
        feralCache.catFormSeenAtByGuid = {}
        feralCache.bearFormSeenAtByGuid = {}
        return
    end

    if rosterKey ~= feralCache.lastRosterKey or inCombat ~= feralCache.lastInCombat then
        feralCache.lastRosterKey = rosterKey
        feralCache.lastInCombat = inCombat
        feralCache.lastScanTime = 0
        feralCache.feralPresent = false
        feralCache.guardianPresent = false
        feralCache.catFormSeenAtByGuid = {}
        feralCache.bearFormSeenAtByGuid = {}
    end

    if now > 0 and (now - feralCache.lastScanTime) < FERAL_SCAN_INTERVAL then
        return
    end

    feralCache.lastScanTime = now
    feralCache.feralPresent = false
    feralCache.guardianPresent = false

    local function scanUnit(unit)
        if not unit or UnitIsUnit and UnitIsUnit(unit, "player") then
            return
        end
        if UnitClassBase and UnitClassBase(unit) ~= "DRUID" then
            return
        end

        local guid = UnitGUID and UnitGUID(unit) or unit
        if not guid then
            return
        end

        local hasCatForm = NAG:UnitAura(unit, FERAL_FORM_ID, "HELPFUL") ~= false
        if hasCatForm then
            local seenAt = feralCache.catFormSeenAtByGuid[guid]
            if not seenAt then
                feralCache.catFormSeenAtByGuid[guid] = now
            elseif (now - seenAt) >= FERAL_CONFIRM_SECONDS then
                feralCache.feralPresent = true
            end
        else
            feralCache.catFormSeenAtByGuid[guid] = nil
        end

        local hasBearForm = (NAG:UnitAura(unit, DIRE_BEAR_FORM_ID, "HELPFUL") ~= false)
            or (NAG:UnitAura(unit, BEAR_FORM_ID, "HELPFUL") ~= false)
        if hasBearForm then
            local seenAt = feralCache.bearFormSeenAtByGuid[guid]
            if not seenAt then
                feralCache.bearFormSeenAtByGuid[guid] = now
            elseif (now - seenAt) >= FERAL_CONFIRM_SECONDS then
                feralCache.guardianPresent = true
            end
        else
            feralCache.bearFormSeenAtByGuid[guid] = nil
        end
    end

    if inRaid then
        for i = 1, memberCount do
            scanUnit("raid" .. i)
            if feralCache.feralPresent and feralCache.guardianPresent then
                break
            end
        end
    else
        for i = 1, 4 do
            if memberCount == 0 then
                break
            end
            scanUnit("party" .. i)
            if feralCache.feralPresent and feralCache.guardianPresent then
                break
            end
        end
    end
end

--- Returns true when Shred is likely usable (i.e., you're probably behind the target).
--- Practical heuristic for in-the-wild play:
--- - If you're solo (not in a party/raid), assume you won't consistently be behind the target.
--- - If the target is targeting you, assume you're in front of it.
--- This avoids suggesting Shred in situations where it commonly cannot be cast.
--- @return boolean
function NAG:FeralCanLikelyShred()
    if not self:IsFeralShredAssignmentEnabled() then
        return false
    end

    -- Respect group overrides via StateManager (used by tests / debug tooling)
    if not self:PlayerIsInGroup() then
        return false
    end

    -- If the target is currently targeting the player, assume we're not behind it
    if self:UnitExists("target") and self:UnitExists("targettarget") and UnitIsUnit and UnitIsUnit("targettarget", "player") then
        return false
    end

    -- If we're tanking (high threat), also assume we can't reliably be behind
    if self:UnitIsPrimaryTarget() then
        return false
    end

    return true
end

--- Determine if another druid in the group/raid is actively feral (Cat Form sustained).
--- @return boolean True if a feral druid is detected, false otherwise
local function HasFeralDruidInGroup()
    UpdateDruidGroupCache()
    return feralCache.feralPresent
end

--- Determine if another druid in the group/raid is actively in Bear Form (sustained).
--- @return boolean True if a guardian druid is detected, false otherwise
local function HasGuardianDruidInGroup()
    UpdateDruidGroupCache()
    return feralCache.guardianPresent
end

--- Should refresh Mangle early to protect a feral's bleed damage.
--- Exposed as NAG method for use in rotation strings.
--- @return boolean
function NAG:ShouldRefreshMangleForFeral()
    UpdateDruidGroupCache()
    return feralCache.feralPresent
end

--- Should show Mangle in BELOW position for feral DPS.
--- Only when a guardian druid is present and another feral is detected.
--- @return boolean
local function ShouldShowMangleBelowForFeral()
    return HasGuardianDruidInGroup() or HasFeralDruidInGroup()
end

--- Get the display position for Feral Mangle based on group composition.
--- @return string
function NAG:GetFeralManglePosition()
    if ShouldShowMangleBelowForFeral() then
        return NAG.SPELL_POSITIONS.BELOW
    end
    return NAG.SPELL_POSITIONS.PRIMARY
end

--- Determine whether Feral should cast Mangle and where to show it.
--- Priority-style rules are based on WoWSims TBC feral rotation logic.
--- @return boolean shouldMangle True if Mangle should be cast
--- @return string|nil position Spell position for display when true
function NAG:ShouldMangle()
    if self:RemainingTime() < 12 then
        return false
    end

    local timeToTick = self:TimeToEnergyTickWithGCD()
    local energy = self:CurrentEnergyAtGCD()
    local mangleCost = self:IsKnownTierset(38447) and 35 or 40
    local manglePosition = self:GetFeralManglePosition()
    local comboPoints = self:CurrentComboPoints()
    local canLikelyShred = self:FeralCanLikelyShred() == true

    if comboPoints >= 5 then
        if not self:DotIsActive(1079) or (self:DotRemainingTime(1079) <= 0.5) then
            return false
        end
    end

    local ripDue = (comboPoints >= 4) and
        (not self:DotIsActive(1079) or (self:DotRemainingTime(1079) <= timeToTick))

    -- Mangle down and Rip isn't due
    if (not self:DotIsActiveGlobal("target", 33876)) and (not ripDue) then
        return true, manglePosition
    end

    -- Mangle will drop before next energy tick and Rip isn't due
    if self:DotIsActiveGlobal("target", 33876) and (self:DotRemainingTime(33876) <= timeToTick) and (not ripDue) then
        return true, manglePosition
    end

    -- Mangle trick window (energy band depends on 2p T6)
    if self:IsKnownTierset(38447) then
        if (timeToTick <= 1.0) and (energy >= 50) and (energy < 57) then
            return true, self.SPELL_POSITIONS.PRIMARY
        end
    elseif (timeToTick <= 1.0) and (energy >= 60) and (energy < 62) then
        return true, self.SPELL_POSITIONS.PRIMARY
    end

    -- If Shred is unlikely (solo / being targeted / tanking), use Mangle as the primary builder instead of waiting for Shred windows.
    if (not canLikelyShred) and (energy >= mangleCost) then
        return true, self.SPELL_POSITIONS.PRIMARY
    end

    -- Enough energy for Mangle but not enough time to Shred before next tick
    if canLikelyShred and (energy >= mangleCost) and (energy < 42) and (timeToTick <= 1.0) then
        return true, self.SPELL_POSITIONS.PRIMARY
    end

    return false
end

function NAG:ManglePosition()
    local _, pos = NAG:ShouldMangle()
    return pos
end

--- Cast the Cat Form placeholder and show a Powershift overlay.
--- @return boolean True if placeholder was triggered, false otherwise
function NAG:CastPowershiftPlaceholder()
    local casted = self:CastPlaceholder(768)
    if casted then
        self:ShowCustomOverlay("Powershift")
    end
    return casted
end

--- Build a debug snapshot for TBC feral finisher/powershift gating.
--- Mirrors key checks in the Feral (DPS) rotation string.
--- @return table snapshot Diagnostic fields for powershift, rip, and bite gates.
function NAG:GetFeralDebugSnapshot()
    local comboPoints = self:CurrentComboPoints()
    local ripActive = self:DotIsActive(1079) == true
    local remainingTime = self:RemainingTime() or 0
    local ripBaseDuration = self:DotBaseDuration(1079) or 0
    local ripPctThreshold = ripBaseDuration * 0.8
    local hasShredEnergy = self:HasEnergy(5221) == true

    local powershift = {
        inCatForm = self:AuraIsActive(768) == true,
        manaPercentBase = self:CurrentManaPercentBase() or 0,
        manaGate = (self:CurrentManaPercentBase() or 0) > 0.35,
        energyAtGCD = self:CurrentEnergyAtGCD() or 0,
        timeToTickWithGCD = self:TimeToEnergyTickWithGCD() or 0,
    }
    powershift.energyLowGate = powershift.energyAtGCD < 10
    powershift.energyBandGate = powershift.energyAtGCD <= 21 and powershift.energyAtGCD > 10
    powershift.tickGate = powershift.timeToTickWithGCD > 1.0
    powershift.energyGate = powershift.energyLowGate or (powershift.energyBandGate and powershift.tickGate)
    powershift.passes = powershift.inCatForm and powershift.manaGate and powershift.energyGate

    if not powershift.inCatForm then
        powershift.firstFailure = "not_in_cat_form"
    elseif not powershift.manaGate then
        powershift.firstFailure = "mana_percent_base_le_0_35"
    elseif not powershift.energyGate then
        powershift.firstFailure = "energy_gate_failed"
    else
        powershift.firstFailure = "pass"
    end

    local rip = {
        comboPoints = comboPoints,
        comboGate = comboPoints >= 5,
        ripActive = ripActive,
        ripMissingGate = not ripActive,
        remainingTime = remainingTime,
        remainingAtLeast10Gate = remainingTime >= 10,
        ripBaseDuration = ripBaseDuration,
        ripPctThreshold = ripPctThreshold,
        remainingAtLeast80PctRipGate = remainingTime >= ripPctThreshold,
    }
    rip.passes = rip.comboGate and rip.ripMissingGate and rip.remainingAtLeast10Gate and rip.remainingAtLeast80PctRipGate

    if not rip.comboGate then
        rip.firstFailure = "combo_points_lt_5"
    elseif not rip.ripMissingGate then
        rip.firstFailure = "rip_already_active"
    elseif not rip.remainingAtLeast10Gate then
        rip.firstFailure = "remaining_time_lt_10"
    elseif not rip.remainingAtLeast80PctRipGate then
        rip.firstFailure = "remaining_time_lt_0_8_rip_base_duration"
    else
        rip.firstFailure = "pass"
    end

    local biteMain = {
        comboPoints = comboPoints,
        comboGate = comboPoints >= 5,
        ripActive = ripActive,
        ripActiveGate = ripActive,
    }
    biteMain.passes = biteMain.comboGate and biteMain.ripActiveGate

    if not biteMain.comboGate then
        biteMain.firstFailure = "combo_points_lt_5"
    elseif not biteMain.ripActiveGate then
        biteMain.firstFailure = "rip_not_active"
    else
        biteMain.firstFailure = "pass"
    end

    local biteEmergency = {
        comboPoints = comboPoints,
        comboGate = comboPoints >= 1,
        remainingTime = remainingTime,
        executeWindowGate = remainingTime <= 3,
        hasShredEnergy = hasShredEnergy,
        isPrimaryTarget = self:UnitIsPrimaryTarget() == true,
    }
    biteEmergency.energyOrTankGate = (not biteEmergency.hasShredEnergy) or biteEmergency.isPrimaryTarget
    biteEmergency.passes = biteEmergency.comboGate and biteEmergency.executeWindowGate and biteEmergency.energyOrTankGate

    if not biteEmergency.comboGate then
        biteEmergency.firstFailure = "combo_points_lt_1"
    elseif not biteEmergency.executeWindowGate then
        biteEmergency.firstFailure = "remaining_time_gt_3"
    elseif not biteEmergency.energyOrTankGate then
        biteEmergency.firstFailure = "has_shred_energy_and_not_primary_target"
    else
        biteEmergency.firstFailure = "pass"
    end

    local clearcastingShred = (self:AuraIsActive(16864) == true) and (self:FeralCanLikelyShred() == true)
    local clearcastingMangle = (self:AuraIsActive(16864) == true) and (self:FeralCanLikelyShred() ~= true)

    return {
        powershift = powershift,
        rip = rip,
        biteMain = biteMain,
        biteEmergency = biteEmergency,
        biteAny = biteMain.passes or biteEmergency.passes,
        likelyPreemptedByEarlierRule = clearcastingShred or clearcastingMangle or powershift.passes,
        preemptReason = clearcastingShred and "clearcasting_shred"
            or (clearcastingMangle and "clearcasting_mangle")
            or (powershift.passes and "powershift")
            or "none",
    }
end

--- Cast Mangle if rotation rules say we should.
--- @return boolean True if Mangle was triggered, false otherwise
function NAG:CastMangleIfNeeded()
    local shouldMangle, position = self:ShouldMangle()
    if shouldMangle then
        return self:Cast(33876, nil, position)
    end
    return false
end

-- TBC Druid spec spell locations
-- Note: TBC Druid uses indices 1, 2, 4 (index 3 is duplicate Feral in SpecializationCompat)
defaults.class.specSpellLocations = {
    [1] = { -- Balance
        -- ABOVE spells (Buffs, maintenance)
        [24858] = NAG.SPELL_POSITIONS.ABOVE,    -- Moonkin Form (maintain)

        -- BELOW spells (DoTs that should expire before reapplying)
        [8921] = NAG.SPELL_POSITIONS.BELOW,     -- Moonfire

        -- LEFT spells (Cooldowns, racials)
        [33831] = NAG.SPELL_POSITIONS.LEFT,     -- Force of Nature
        [20572] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,     -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,     -- Arcane Torrent (BE Racial)

        -- RIGHT spells (Optional raid utility)
        [770] = NAG.SPELL_POSITIONS.RIGHT,      -- Faerie Fire (optional, melee group utility)
        [5570] = NAG.SPELL_POSITIONS.RIGHT,     -- Insect Swarm (optional, higher-level targets)

        -- AOE spells
        [16914] = NAG.SPELL_POSITIONS.AOE,      -- Hurricane

        -- PRIMARY spells (default, not explicitly set)
        -- Starfire (26986) - main filler
    },
    [2] = { -- Feral Combat (DPS)
        -- ABOVE spells (Buffs, maintenance, forms)
		--[16864] = NAG.SPELL_POSITIONS.ABOVE,     -- Omen of Clarity (Clearcasting proc) - TBC ID: 16864
		[99] = NAG.SPELL_POSITIONS.RIGHT,        -- Demo Roar
        [16857] = NAG.SPELL_POSITIONS.RIGHT,    -- Faerie Fire (Feral) (if assigned)
		--[16979] = NAG.SPELL_POSITIONS.ABOVE,    -- charge

        -- LEFT spells (Cooldowns, procs, racials)
        [6807] = NAG.SPELL_POSITIONS.LEFT,      -- Maul
        [20572] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,     -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,     -- Arcane Torrent (BE Racial)

    },
    [4] = { -- Restoration
        -- ABOVE spells (Buffs, maintenance, forms)
        [5420] = NAG.SPELL_POSITIONS.ABOVE,     -- Tree of Life (maintain)

        -- BELOW spells (HoTs on tanks - focus unit)
        [33763] = NAG.SPELL_POSITIONS.BELOW,    -- Lifebloom (maintain 3 stacks on focus)
        [774] = NAG.SPELL_POSITIONS.BELOW,      -- Rejuvenation (maintain on focus)
        [8936] = NAG.SPELL_POSITIONS.BELOW,     -- Regrowth (maintain HoT on focus)

        -- LEFT spells (Cooldowns, emergency heals, racials)
        [16188] = NAG.SPELL_POSITIONS.LEFT,     -- Nature's Swiftness
        [18562] = NAG.SPELL_POSITIONS.LEFT,     -- Swiftmend
        [20572] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,     -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,     -- Arcane Torrent (BE Racial)

        -- PRIMARY spells (default, not explicitly set)
        -- Rejuvenation (26982) - spot heal raid
        -- Regrowth (26980) - filler
        -- Healing Touch (26979) - with Nature's Swiftness
    },
}

-- Class assignments for raid coordination
-- Self-heal when low health (generic rotation)
defaults.class.recommendSelfHeal = true
defaults.class.selfHealThreshold = 0.35

defaults.class.classAssignments = {
    {
        id = "faerie_fire",
        name = "Faerie Fire",
        description = "Apply armor reduction debuff on targets (conflicts with Sunder Armor/Expose Armor)",
        spellIds = {770, 778, 9749, 9907, 26993}, -- All ranks (includes Feral version)
        category = "debuff",
    },
    {
        id = "mark_of_the_wild",
        name = "Mark of the Wild",
        description = "Provide stats buff to raid (coordinate with other Druids)",
        spellIds = {1126, 5232, 6756, 5234, 8907, 9884, 9885, 26990}, -- All ranks
        category = "buff",
    },
    {
        id = "innervate",
        name = "Innervate",
        description = "Provide mana regeneration (coordinate with other healers/Druids)",
        spellIds = {29166}, -- Innervate
        category = "utility",
    },
    {
        id = "faerie_fire_feral",
        name = "Faerie Fire (Feral)",
        description = "Apply armor reduction debuff on targets (usually done by Balance Druid, conflicts with Sunder Armor/Expose Armor)",
        spellIds = {16857, 17390, 17391, 17392, 27011}, -- All ranks of Faerie Fire (Feral)
        category = "debuff",
    },
    {
        id = "demoralizing_roar",
        name = "Demoralizing Roar",
        description = "Reduce enemy attack power (usually done by Arms Warrior, coordinate with other tanks)",
        spellIds = {99, 1735, 9490, 9747, 9898, 26998}, -- All ranks
        category = "debuff",
    },
}

if UnitClassBase('player') ~= "DRUID" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec (Wrath 5176, Moonfire 8921)
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "DRUID",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(5185)) and NAG:Cast(5185)
    or (not NAG:AuraIsActive(1126)) and NAG:SpellCanCast(1126) and NAG:Cast(1126)
    or (not NAG:AuraIsActive(467)) and NAG:SpellCanCast(467) and NAG:Cast(467)
    or (NAG:SpellCanCast(8921) and (not NAG:DotIsActive(8921, "target"))) and NAG:Cast(8921)
    or (NAG:SpellCanCast(5176)) and NAG:Cast(5176)
]],
}

-- Balance Rotation
local balanceRotation = {
    -- Core identification
    name = "Balance",
    specIndex = 1,
    class = "DRUID",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/30/2025",
    rotationString = [[
    -- Maintain Moonkin Form
    (not NAG:AuraIsActive(24858)) and NAG:SpellCanCast(24858) and NAG:Cast(24858)
    -- AoE: Hurricane on 4+ targets when you can stand still
    or (NAG:NumberTargets() >= 4 and (not NAG:UnitIsMoving())) and NAG:NotSpamCast(16914)
    or (NAG:NumberTargets() >= 4 and (not NAG:UnitIsMoving()) and NAG:SpellCanCast(16914)) and NAG:Cast(16914)
    -- Big CD: Force of Nature (left)
    or (NAG:SpellCanCast(33831)) and NAG:CastWithOverlay(33831, "CD", NAG.SPELL_POSITIONS.LEFT)
    -- Optional: Faerie Fire for melee groups (refresh after it expires)
    or (NAG:ShouldUseFaerieFire() and (not NAG:DotIsActive(770)) and NAG:SpellCanCast(770)) and
        NAG:Cast(770, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- Maintain Moonfire (late refresh to avoid clipping)
    or (((not NAG:DotIsActive(8921)) or (NAG:DotRemainingTime(8921) <= 2)) and NAG:SpellCanCast(8921)) and NAG:Cast(8921)
    -- Optional: Insect Swarm when in group and target is higher level (late refresh)
    or (NAG:PlayerIsInGroup() and (UnitLevel("target") or 0) > (UnitLevel("player") or 0) and
        ((not NAG:DotIsActive(5570)) or (NAG:DotRemainingTime(5570) <= 2)) and
        NAG:SpellCanCast(5570)) and
        NAG:Cast(5570, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- Movement filler: Moonfire or Insect Swarm when moving
    or (NAG:UnitIsMoving() and NAG:SpellCanCast(8921) and (not NAG:DotIsActive(8921))) and NAG:Cast(8921)
    or (NAG:UnitIsMoving() and NAG:SpellCanCast(5570) and (not NAG:DotIsActive(5570))) and NAG:Cast(5570)
    -- Cast Starfire (main filler)
    or NAG:NotSpamCast(2912)
    -- If a DoT will drop before Starfire finishes (or GCD ends), refresh it first
    or (NAG:DotIsActive(8921) and (NAG:DotRemainingTime(8921) <=
        ((NAG:SpellCastTime(2912) > NAG:GCDTimeValue()) and
        NAG:SpellCastTime(2912) or NAG:GCDTimeValue())))
        and NAG:Cast(8921)
    or (NAG:PlayerIsInGroup() and (UnitLevel("target") or 0) > (UnitLevel("player") or 0) and
        NAG:DotIsActive(5570) and (NAG:DotRemainingTime(5570) <=
        ((NAG:SpellCastTime(2912) > NAG:GCDTimeValue()) and
        NAG:SpellCastTime(2912) or NAG:GCDTimeValue())))
        and NAG:Cast(5570, nil, NAG.SPELL_POSITIONS.RIGHT)
    or (NAG:SpellCanCast(2912)) and NAG:Cast(2912)
    -- Cast Wrath (fast/efficient filler)
    or (NAG:SpellCanCast(5176)) and NAG:Cast(5176)
    ]],

    -- Tracked IDs for optimization
    spells = {24858, 8921, 5570, 2912, 5176, 33831, 770, 16914},
    items = {},
    auras = {24858, 8921, 5570, 770}, -- Moonkin Form, Moonfire, Insect Swarm, Faerie Fire

    -- Optional metadata
    guide = [[
Balance Druid Rotation Guide (TBC)

Core Mechanics:
- Balance Druids are ranged DPS casters focusing on arcane and nature damage.
- Moonkin Form provides spell crit and mana cost reduction - always maintain it.
- DoTs (Moonfire, Insect Swarm) should be refreshed late or after expiration to avoid clipping ticks.
- Starfire is the primary heavy filler; Wrath is the fast/efficient filler.
- TBC does not have Eclipse or Starfall for Balance.

Rotation Priority (Single Target):
1. Maintain Moonkin Form (provides spell crit and mana cost reduction).
2. Optional: Faerie Fire when grouped with melee (raid utility; refresh after it expires).
3. Cast Force of Nature on cooldown when the target will live for the full duration.
4. Maintain Moonfire (refresh after it expires; 12s duration).
5. Optional: Insect Swarm when grouped and the target is higher level (refresh after it expires; 12s duration).
6. Cast Starfire as the primary filler when you can stand still.
7. Cast Wrath as a faster filler or when conserving mana.

AoE Rotation:
2-3 targets:
- Multi-dot Moonfire/Insect Swarm on targets that will live long enough for full ticks.
- Proceed with single target rotation (favor Starfire/Wrath between refreshes).

4+ targets:
- Cast Hurricane when you can channel safely (primary AoE).
- Use Moonfire/Insect Swarm while moving or to finish stragglers.
- Proceed with single target rotation when AoE ends.

DoT Management:
- Avoid clipping DoTs; refresh at the end of their duration.
- Moonfire: 12 second duration with an initial hit.
- Insect Swarm: 12 second duration and reduces the target's hit chance.

Mana Management:
- Moonkin Form: Provides mana cost reduction
- Balance Druids can still run low on long fights - plan Innervate usage.
- Consider downranking if mana becomes a limiting factor.

Movement:
- Starfire and Wrath require standing still.
- Moonfire and Insect Swarm are instant and can be used while moving.
- Hurricane is channeled and requires standing still.

Raid Coordination:
- Faerie Fire: usually assigned to one Balance Druid for consistency.
- Insect Swarm: may be assigned for utility (hit reduction) or skipped to save mana.
- Mark of the Wild: Coordinate with other Druids for raid-wide stats buff
- Innervate: Coordinate with other healers/Druids for mana regeneration
- Usually 1-2 Balance Druids per raid for debuff coverage and DPS
    ]],
    author = "Rakizi",
}


local bearRotationEspi = {
    -- Core identification
    name = "Feral (Tank)",
    specIndex = 2, -- Feral
    class = "DRUID",

    -- Required parameters
    -- IMPORTANT: Only ONE default rotation should exist per specIndex.
    -- Feral defaults to Cat rotation which will prompt/select Bear for AoE.
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,

    lastModified = "06/01/2025",

    -- Rotation Logic
    rotationString = [[
   NAG:AuraIsActive(768) and NAG:SelectRotation("Feral (DPS)")
    -- Form selection: if we're in Bear rotation but it's single-target, prompt/shift back to Cat.
    -- This prevents "no rotation" stalls when logging in / idling in non-feral forms (e.g., Travel Form).
    -- This avoids "no rotation selected" stalls when logging in while in Travel Form.
    or (not NAG:AuraIsActive(9634)) and (not NAG:AuraIsActive(768)) and NAG:Cast(9634, nil, NAG.SPELL_POSITIONS.AOE)
    or (not NAG:AuraIsActive(9634)) and (not NAG:AuraIsActive(768)) and NAG:Cast(768, nil, NAG.SPELL_POSITIONS.PRIMARY)
    -- Self buffs / solo sustain (LEFT)
    or (not NAG:AuraIsActive(9885) and not NAG:AuraIsActive(21849)) and NAG:Cast(9885, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((not NAG:InCombat()) and ((NAG:AuraIsActive(9885) and (NAG:AuraRemainingTime(9885) < 120)) or (NAG:AuraIsActive(21849) and (NAG:AuraRemainingTime(21849) < 120)))) and NAG:Cast(9885, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:GetNumGroupMembers() == 0) and ((not NAG:AuraIsActive(26992)) or (NAG:AuraRemainingTime(26992) < 60))) and NAG:Cast(26992, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:GetNumGroupMembers() == 0) and (NAG:CurrentHealthPercent() < 0.4)) and NAG:Cast(33763, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:GetNumGroupMembers() == 0) and (NAG:CurrentHealthPercent() < 0.3)) and NAG:Cast(26980, nil, NAG.SPELL_POSITIONS.LEFT)

	-- Maul
	or (NAG:CurrentRage() >= 40 and not NAG:IsQueued(6807)) and NAG:Cast(6807)

    -- Utility
	-- Maintain Demoralizing Roar if assigned
    or (not NAG:DotIsActive(99) or NAG:DotRemainingTime(99) < 5) and NAG:UnitDistance("target") <= 8 and NAG:Cast(99)
	-- Maintain fff if assigned
    or (not NAG:DotIsActive(16857)) and NAG:Cast(16857)
	-- Maintain omen
    or not(NAG:InCombat()) and (not NAG:AuraIsActive(16864)) and NAG:Cast(16864)
	-- add taunt?

	-- charge if further than 8 yards
	or (NAG:UnitDistance("target") > 8) and NAG:Cast(16979)

    -- Always be in Bear Form (9634)
    or (not NAG:AuraIsActive(9634)) and NAG:Cast(9634)

	-- lacerate(<3s remaining)
    or (NAG:DotIsActive(33745) and (NAG:DotRemainingTime(33745) < 3)) and NAG:Cast(33745)

	-- mangle (refresh early if a feral is in the group)
	or (NAG:ShouldRefreshMangleForFeral() and NAG:DotIsActiveGlobal("target", 33876) and (NAG:DotRemainingTime(33876) <= 3.0)) and NAG:Cast(33878)
	-- mangle
	or NAG:Cast(33878)

    -- lacerate(<5 stacks or <5s remaining)
    or NAG:NumberTargets(5) < 3 and (not NAG:DotIsActive(33745) or (NAG:DotNumStacks(33745) < 5 or NAG:DotRemainingTime(33745) < 5)) and NAG:Cast(33745)

    -- swipe
    or (NAG:NumberTargets(5) > 1 or (NAG:DotIsActive(33745) and NAG:DotNumStacks(33745) == 5)) and NAG:Cast(769)

    -- pooling rage placeholder with auto attack
    or NAG:CastWithSwingOverlay(6603, "Pool\nRage")
    ]],

    -- Tracked IDs
    spells = {
	6807, -- Maul
	99, --demo Roar
	16857, -- faerie fire Feral
	16979, --charge
	9634, --bear form
	33878, --mangle
	33745, --lacerate
	769, --swipe
    },
    items = {
    },
    auras = {},
    runes = {},

	author = "espi",
}


local catRotationEspi = {
    -- Core identification
    name = "Feral (DPS)",
    specIndex = 2, -- Feral
    class = "DRUID",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,

    lastModified = "06/01/2025",

    -- Rotation Logic
    rotationString = [[
    NAG:AuraIsActive(9634) and NAG:SelectRotation("Feral (Tank)")
    -- Form selection: default feral rotation should always prompt a form.
    -- Use Bear for AoE (2+ targets), otherwise Cat for primary (single target).
    -- This avoids "no rotation selected" stalls when logging in while in Travel Form.
    or (not NAG:AuraIsActive(9634)) and (not NAG:AuraIsActive(768)) and NAG:Cast(9634, nil, NAG.SPELL_POSITIONS.AOE)
    or (not NAG:AuraIsActive(9634)) and (not NAG:AuraIsActive(768)) and NAG:Cast(768, nil, NAG.SPELL_POSITIONS.PRIMARY)
    -- Self buffs / solo sustain (LEFT)
    or (not NAG:AuraIsActive(9885) and not NAG:AuraIsActive(21849)) and NAG:Cast(9885, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((not NAG:InCombat()) and ((NAG:AuraIsActive(9885) and (NAG:AuraRemainingTime(9885) < 120)) or (NAG:AuraIsActive(21849) and (NAG:AuraRemainingTime(21849) < 120)))) and NAG:Cast(9885, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:GetNumGroupMembers() == 0) and ((not NAG:AuraIsActive(26992)) or (NAG:AuraRemainingTime(26992) < 60))) and NAG:Cast(26992, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:GetNumGroupMembers() == 0) and (NAG:CurrentHealthPercent() < 0.4)) and NAG:Cast(33763, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:GetNumGroupMembers() == 0) and (NAG:CurrentHealthPercent() < 0.3)) and NAG:Cast(26980, nil, NAG.SPELL_POSITIONS.LEFT)

	-- Maintain ff if assigned
    -- If target is far, show FF in primary position
    or ((not NAG:UnitDebuffGlobal("target", 16857)) and (NAG:UnitDistance("target") >= 10)) and
        NAG:Cast(16857, nil, NAG.SPELL_POSITIONS.PRIMARY)
    or (not  NAG:UnitDebuffGlobal("target", 16857)) and NAG:Cast(16857)
	-- Maintain omen (refresh out of combat if less than 3 minutes remaining)
    or ((not NAG:AuraIsActive(16864)) or ((not NAG:InCombat()) and (NAG:AuraRemainingTime(16864) < 180))) and NAG:Cast(16864)

    -- dash if further than 10 yards (only in Cat Form)
    or (NAG:AuraIsActive(768) and NAG:UnitDistance("target") > 10) and NAG:Cast(33357, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Always be in Cat Form (768)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)

    -- Clearcasting builder: Shred only when assigned and likely behind; otherwise Mangle
    or (NAG:AuraIsActive(16870) and NAG:IsFeralShredAssignmentEnabled() and NAG:FeralCanLikelyShred()) and NAG:Cast(5221)
    --or (NAG:AuraIsActive(16870) and (not NAG:FeralCanLikelyShred())) and NAG:Cast(33876)

    -- if energy <=21 then powershift
	or (NAG:AuraIsActive(768) and NAG:CurrentManaPercentBase() > 0.35 and
        ((NAG:CurrentEnergyAtGCD() < 10) or
        (NAG:CurrentEnergyAtGCD() <= 21 and NAG:CurrentEnergyAtGCD() > 10 and NAG:TimeToEnergyTickWithGCD() > 1.0))) and NAG:CastPowershiftPlaceholder()

    -- If 5 CP and no Rip, apply Rip first
    or (NAG:CurrentComboPoints() >= 5 and (not NAG:DotIsActive(1079))
        and (NAG:RemainingTime() >= 10)
        and (NAG:RemainingTime() >= (NAG:DotBaseDuration(1079) * 0.8))) and NAG:Cast(1079)

    -- If 5 CP and Rip is active or remaining time is less than 10 seconds, use Ferocious Bite
    or (NAG:CurrentComboPoints() >= 5 and (NAG:DotIsActive(1079) or NAG:RemainingTime() <= 10)) and NAG:Cast(22568)

    -- Emergency: if target is dying soon, use Ferocious Bite immediately (if possible)
    or ((NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() <= 3)
        and ((not NAG:IsFeralShredAssignmentEnabled()) or (not NAG:HasEnergy(5221)) or NAG:UnitIsPrimaryTarget())) and NAG:Cast(22568)

    or NAG:CastMangleIfNeeded()
    -- If Shred is unassigned or unlikely (solo / being targeted / tanking), use Mangle as filler instead.
    or ((not NAG:IsFeralShredAssignmentEnabled()) or (not NAG:FeralCanLikelyShred())) and NAG:Cast(33876)
    -- Shred
    or (NAG:IsFeralShredAssignmentEnabled() and NAG:FeralCanLikelyShred()) and NAG:Cast(5221)
    --mangle fallback
    or  NAG:Cast(33876)
    ]],

    -- Tracked IDs
    spells = {
	16857, -- faerie fire Feral
	16979, --charge
	768, --cAT form
	33876, --mangle
	1079, --rip
	5221, --Shred
	22568, --bite
    },
    items = {
    },
    auras = {},
    runes = {},

	author = "espi",
}

-- Restoration Rotation (Experimental)
-- Restoration Healing Rotation (spec 4)
-- Hybrid: uses both focus (tank) and mouseover healing.
-- Focus-based logic retained for tank healing; mouseover via HealingStateManager.
-- devOnly: visible only when Developer Mode is enabled
local restorationRotation = {
    name = "Restoration",
    specIndex = 4,
    description = "Hybrid focus+mouseover healing: Tree of Life, Lifebloom stacks, Rejuvenation, Regrowth.",
    class = "DRUID",
    default = true,
    enabled = true,
    devOnly = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "02/08/2026",
    rotationString = [[
-- Maintain Tree of Life
(not NAG:AuraIsActive(5420)) and NAG:SpellCanCast(5420) and NAG:Cast(5420)

-- Dispel: Remove Curse on mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverNeedsDispel() and NAG:SpellCanCast(2782)) and NAG:Cast(2782)

-- Maintain 3 stacks of Lifebloom on focus (tank)
or ((NAG:UnitExists("focus") and (NAG:AuraNumStacks(33763, "focus") < 3 or (not NAG:AuraIsActive(33763, "focus")))) and NAG:SpellCanCast(33763)) and NAG:Cast(33763)

-- Maintain Rejuvenation on focus (tank)
or ((NAG:UnitExists("focus") and (not NAG:AuraIsActive(774, "focus"))) and NAG:SpellCanCast(774)) and NAG:Cast(774)

-- Maintain Regrowth HoT on focus (tank)
or ((NAG:UnitExists("focus") and (not NAG:AuraIsActive(8936, "focus"))) and NAG:SpellCanCast(8936)) and NAG:Cast(8936)

-- Nature's Swiftness for emergency (instant Healing Touch)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 25
    and NAG:SpellCanCast(16188) and (not NAG:AuraIsActive(16188))) and NAG:Cast(16188)

-- Healing Touch with Nature's Swiftness active
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 30
    and NAG:AuraIsActive(16188) and NAG:SpellCanCast(5185)) and NAG:Cast(5185)

-- Swiftmend on critical mouseover (instant)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 40
    and NAG:SpellCanCast(18562)
    and (NAG:MouseoverHasBuff(774) or NAG:MouseoverHasBuff(8936))) and NAG:Cast(18562)

-- Rejuvenation on mouseover raid spot healing
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 80
    and (not NAG:MouseoverHasBuff(774)) and NAG:SpellCanCast(774)) and NAG:Cast(774)

-- Regrowth filler on mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 70
    and NAG:SpellCanCast(8936)) and NAG:Cast(8936)

-- Damage filler: Wrath (if nothing to heal)
or NAG:SpellCanCast(5176) and NAG:Cast(5176)
    ]],

    spells = {774, 2782, 5176, 5185, 5420, 8936, 16188, 18562, 33763},
    items = {},
    auras = {774, 5420, 8936, 16188, 33763},
    author = "Smufrik",
}

-- Feral DPS Macros
local feralDPSMacros = {
    {
        name = "Power Shift",
        body = "#showtooltip Cat Form\n/cast !Cat Form"
    },
}

--- @class Druid : ClassBase
local Druid = NAG:CreateClassModule("DRUID", defaults)
if not Druid then return end

function Druid:SetupClassDefaults()
    -- Attach macros to rotations
    --feralCombatRotation.macros = feralDPSMacros
    -- Note: For TBC Druid, SpecializationCompat uses indices 1, 2, 4 (index 3 is duplicate Feral)
    -- We use the actual spec indices from SpecializationCompat for consistency
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, balanceRotation)  -- Balance
    --ns.AddRotationToDefaults(self.defaults, 2, feralCombatRotation)  -- Feral Combat
    ns.AddRotationToDefaults(self.defaults, 2, catRotationEspi)  -- Feral DPS
    ns.AddRotationToDefaults(self.defaults, 2, bearRotationEspi)  -- Feral Tank
    ns.AddRotationToDefaults(self.defaults, 4, restorationRotation)  -- Restoration (index 4, not 3)
end

local BaseGetOptions = Druid.GetOptions
function Druid:GetOptions()
    local options = BaseGetOptions(self)
    options.args = options.args or {}
    options.args.settings = options.args.settings or { type = "group", args = {} }
    options.args.settings.args = options.args.settings.args or {}
    options.args.settings.args.selfHeal = {
        type = "group",
        name = "Self-heal when low",
        order = 20,
        inline = true,
        args = {
            selfHealDesc = {
                type = "description",
                name = "The threshold is only used when the active rotation includes the self-heal suggestion (e.g. Generic rotation). Other rotations ignore these settings.",
                order = 0,
                fontSize = "medium",
            },
            recommendSelfHeal = {
                type = "toggle",
                name = "Recommend self-heal when low health",
                desc = "When the rotation includes self-heal (e.g. Generic), suggest a heal when your health is below the threshold.",
                order = 1,
                get = function() return self:GetSetting("class", "recommendSelfHeal", true) end,
                set = function(_, val) self:SetSetting("class", "recommendSelfHeal", val) end,
                width = "full",
            },
            selfHealThreshold = {
                type = "range",
                name = "Self-heal threshold (health %)",
                desc = "When the rotation includes self-heal, suggest it when health is below this percentage (10-60%).",
                order = 2,
                min = 0.1,
                max = 0.6,
                step = 0.05,
                get = function() return self:GetSetting("class", "selfHealThreshold", 0.35) end,
                set = function(_, val) self:SetSetting("class", "selfHealThreshold", val) end,
                width = "full",
            },
        }
    }
    return options
end

NAG.Class = Druid

