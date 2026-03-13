--- @module "APL_Class"
--- Class-specific APL logic for the NAG addon
---
--- This module provides class-specific APL logic for the NAG addon
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================
local WoWAPI = ns.WoWAPI
local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)
local RC = ns.RC


-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitName = _G.UnitName
local UnitIsDead = _G.UnitIsDead
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local GetTotemTimeLeft = _G.GetTotemTimeLeft
local IsInRaid = _G.IsInRaid
local GetTotemInfo = _G.GetTotemInfo


local floor = math.floor
local min = math.min
local max = math.max



local format = string.format
local strlower = strlower
local strupper = strupper

local tinsert = tinsert

local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local DataManager = ns.DataManager
local StateManager = ns.StateManager
local SpellTrackingManager = ns.SpellTrackingManager
local DisplayManager = ns.DisplayManager
local OverlayManager = ns.OverlayManager
local EnhancedAuraHandlers = ns.EnhancedAuraHandlers
local Snapshotter = ns.Snapshotter

local DRUID_SOLAR_ECLIPSE_SPELL_ID = 48517
local DRUID_LUNAR_ECLIPSE_SPELL_ID = 48518

-- Mage DoT tracking system (moved to SpellTrackingManager)
-- All DoT tracking functionality is now handled by SpellTrackingManager

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~







--- Determine the current Eclipse phase for a Balance Druid.
--- Returns "SolarPhase", "LunarPhase", or "NeutralPhase" if neither is active.
--- Uses GetEclipseDirection API when available, falls back to aura checking.
--- @usage NAG:DruidCurrentEclipsePhase() == "SolarPhase"
--- @return string The current Eclipse phase ("SolarPhase", "LunarPhase", or "NeutralPhase").
function NAG:DruidCurrentEclipsePhase()
    -- First try to use GetEclipseDirection for more accurate detection
    if GetEclipseDirection then
        local direction = GetEclipseDirection()
        if direction == "sun" then
            return "SolarPhase"
        elseif direction == "moon" then
            return "LunarPhase"
        elseif direction == "none" then
            return "NeutralPhase"
        end
    end

    -- Fallback to aura checking only if GetEclipseDirection API is unavailable
    -- Check for Solar Eclipse
    local solarEclipse = NAG:UnitAura("player", DRUID_SOLAR_ECLIPSE_SPELL_ID, "HELPFUL")
    if solarEclipse then
        return "SolarPhase"
    end

    -- Check for Lunar Eclipse
    local lunarEclipse = NAG:UnitAura("player", DRUID_LUNAR_ECLIPSE_SPELL_ID, "HELPFUL")
    if lunarEclipse then
        return "LunarPhase"
    end

    -- Return neutral if neither is active
    return "NeutralPhase"
end



--- Checks if the Warlock's pet is currently active.
--- @usage NAG:WarlockPetIsActive()
--- @return boolean True if the pet is active, false otherwise.
function NAG:WarlockPetIsActive()
    return UnitExists("pet") and not UnitIsDeadOrGhost("pet")
end

--- Gets the current mana of the Warlock's pet.
--- @usage NAG:WarlockCurrentPetMana()
--- @return number The current mana of the pet.
function NAG:WarlockCurrentPetMana()
    if not UnitExists("pet") then return 0 end
    -- Warlock pets use PowerType 3 for their secondary resource bar
    return UnitPower("pet", Enum.PowerType.Energy) or 0
end

local SOUL_SWAP_INHALE_SPELL_ID = 86121
local AFFLICTION_SOUL_SWAP_TAG = 1
local SOUL_SWAP_DOT_IDS = {172, 980, 30108}

--- Checks if Hand of Guldan is currently in flight
--- @usage NAG:WarlockHandOfGuldanInFlight()
--- @return boolean True if Hand of Guldan is in flight, false otherwise.
function NAG:WarlockHandOfGuldanInFlight()
    return SpellTrackingManager:IsSpellInFlight(105174)
end

--- Checks if Haunt is currently in flight
--- @usage NAG:WarlockHauntInFlight()
--- @return boolean True if Haunt is in flight, false otherwise.
function NAG:WarlockHauntInFlight()
    return SpellTrackingManager:IsSpellInFlight(48181)
end

-- TODO: Believe this needs to be updated/tested.
--- Returns the current snapshot delta for Affliction DoTs or Soul Swap Exhale.
--- Positive values indicate a stronger snapshot relative to baseline.
--- @param actionId table|number ActionID describing the spell (supports raw spellId numbers)
--- @param targetUnit? string Optional unit token (defaults to "target")
--- @return number Snapshot delta (e.g., 0.15 for +15%), or -1 when unavailable
function NAG:AfflictionCurrentSnapshot(actionId, targetUnit)
    if not Snapshotter or not Snapshotter.DotPercentIncrease then
        return -1
    end

    targetUnit = targetUnit or "target"
    if type(targetUnit) ~= "string" then
        targetUnit = "target"
    end

    if not actionId then
        return -1
    end

    local spellId
    local tag = 0
    if type(actionId) == "table" then
        spellId = actionId.spellId or actionId.spell_id or actionId.SpellID
        tag = actionId.tag or actionId.Tag or 0
    elseif type(actionId) == "number" then
        spellId = actionId
    end

    if type(spellId) ~= "number" then
        return -1
    end

    if spellId == SOUL_SWAP_INHALE_SPELL_ID and tag == AFFLICTION_SOUL_SWAP_TAG then
        local sum, count = 0, 0
        for _, dotId in ipairs(SOUL_SWAP_DOT_IDS) do
            local diff = Snapshotter:DotPercentIncrease(dotId, targetUnit)
            if diff ~= nil then
                sum = sum + diff
                count = count + 1
            end
        end
        if count == 0 then
            return -1
        end
        return sum / count
    end

    local diff = Snapshotter:DotPercentIncrease(spellId, targetUnit)
    if diff == nil then
        return -1
    end

    return diff
end

--- Returns the configured Soul Swap Exhale window in seconds.
--- @return number Exhale window duration in seconds
function NAG:AfflictionExhaleWindow()
    local classModule = self:GetClassModule()
    if not classModule or classModule.className ~= "WARLOCK" then
        return 0
    end

    local value = classModule.db
        and classModule.db.char
        and classModule.db.char.soulSwapExhaleWindow
        or 0

    if type(value) ~= "number" then
        value = 0
    end

    return value / 1000
end

--- Gets the current mana percent of the Warlock's pet.
--- @usage NAG:WarlockCurrentPetManaPercent()
--- @return number The current mana percent (0-100) of the pet.
function NAG:WarlockCurrentPetManaPercent()
    if not UnitExists("pet") then return 0 end
    -- Warlock pets use PowerType 3 for their secondary resource bar
    local current = UnitPower("pet", Enum.PowerType.Energy)
    local maxPower = UnitPowerMax("pet", Enum.PowerType.Energy)
    if not maxPower or maxPower == 0 then return 0 end
    return (current / maxPower) * 100
end

--- Returns the excess energy for a Feral Druid (not yet implemented).
--- @usage NAG:CatExcessEnergy()
--- @return number Always returns 0 (not implemented).
function NAG:CatExcessEnergy()
    -- One-time warning per session to avoid spam
    if not self._catExcessEnergyWarningShown then
        self:Error("CatExcessEnergy is not yet fully implemented.")
        self._catExcessEnergyWarningShown = true
    end
    return 0
end

--- Determines if the current Drain Soul should be recast for a better snapshot (not yet implemented).
--- @usage NAG:WarlockShouldRecastDrainSoul()
--- @return boolean Always returns false (not implemented).
function NAG:WarlockShouldRecastDrainSoul()
    --if time to die is less than 5 and #soul shards < 5  return true
    -- One-time warning per session to avoid spam
    if not self._warlockDrainSoulWarningShown then
        self:Error("WarlockShouldRecastDrainSoul is not yet fully implemented.")
        self._warlockDrainSoulWarningShown = true
    end
    return false
end

--- Returns the estimated DoT damage for a Mage's Combustion.
--- Uses actual tracked Ignite values to calculate Combustion damage, accounting for Glyph of Combustion,
--- haste scaling, and crit chance. Only considers Ignite as the source DoT.
--- @usage NAG:MageCurrentCombustionDotEstimate()
--- @return number The estimated total damage from Combustion based on current Ignite state.
function NAG:MageCurrentCombustionDotEstimate()
    return SpellTrackingManager:GetCombustionDotEstimate("target") or 0
end


--- Returns the current stagger percentage for a Brewmaster Monk.
--- Calculates the percentage of maximum health currently being staggered by checking
--- Light, Moderate and Heavy stagger debuffs.
--- @usage local staggerPct = NAG:BrewmasterMonkCurrentStaggerPercent()
--- @return number The current stagger amount as a percentage of max health (0-100)
function NAG:BrewmasterMonkCurrentStaggerPercent()
    -- Monk Stagger debuff spell IDs
    local LIGHT_STAGGER = 124275
    local MODERATE_STAGGER = 124274
    local HEAVY_STAGGER = 124273
    -- TODO: Check MultiAura?
    local lightAura = NAG:UnitAura("player", LIGHT_STAGGER, 'HARMFUL')
    local moderateAura = NAG:UnitAura("player", MODERATE_STAGGER, 'HARMFUL')
    local heavyAura = NAG:UnitAura("player", HEAVY_STAGGER, 'HARMFUL')
    local light = lightAura and lightAura.points and lightAura.points[1]
    local moderate = moderateAura and moderateAura.points and moderateAura.points[1]
    local heavy = heavyAura and heavyAura.points and heavyAura.points[1]
    local maxhp = UnitHealthMax("player")
    local current = max(light or 0, moderate or 0, heavy or 0)
    if maxhp and maxhp > 0 then
        return current / maxhp
    else
        return 0
    end
end

-- Fire Elemental spell IDs
local FIRE_ELEMENTAL_SPELL_ID = 2894     -- Fire Elemental Totem
local FIRE_ELEMENTAL_BUFF_ID = 64701     -- Fire Elemental Buff
local BASE_DURATION = 60                 -- Base duration in seconds (unglyphed)
local GLYPH_OF_FIRE_ELEMENTAL_ID = 55455 -- Glyph of Fire Elemental Totem
local GLYPHED_DURATION = 30              -- Duration in seconds when glyphed (50% reduced)

--- Gets the remaining or total duration of Fire Elemental, accounting for Glyph of Fire Elemental if present.
--- @usage NAG:ShamanFireElementalDuration()
--- @return number Duration in seconds (remaining if active, otherwise total possible duration).
function NAG:ShamanFireElementalDuration()
    -- Check if Fire Elemental is currently active
    local aura = NAG:UnitBuff("player", FIRE_ELEMENTAL_BUFF_ID)

    if aura then
        -- Return remaining duration if Fire Elemental is active
        return aura.expirationTime - NAG:NextTime()
    end

    -- Glyph of Fire Elemental Totem reduces Fire Elemental duration by 50%
    if self:HasGlyph(GLYPH_OF_FIRE_ELEMENTAL_ID) then
        return GLYPHED_DURATION
    end

    return BASE_DURATION
end

-- Additional buff IDs for snapshot checking
local BLOODLUST_BUFF_IDS = {
    2825,  -- Bloodlust
    32182, -- Heroism
    80353, -- Time Warp
    90355  -- Ancient Hysteria
}
local ELEMENTAL_MASTERY_ID = 16166
local POWER_TORRENT_ID = 74241     -- Power Torrent weapon enchant
local DMF_CARD_VOLCANIC_ID = 89091 -- Darkmoon Card: Volcanic

--- Checks if current buffs would create a stronger Fire Elemental than currently active.
--- @usage NAG:ShamanCanSnapshotStrongerFireElemental()
--- @return boolean True if current buffs would create a stronger Fire Elemental.
function NAG:ShamanCanSnapshotStrongerFireElemental()
    -- If no Fire Elemental is active, return false
    if not self:IsActiveAura(FIRE_ELEMENTAL_BUFF_ID) then
        return false
    end

    -- Get current Fire Elemental remaining duration
    local remainingDuration = self:ShamanFireElementalDuration()
    if remainingDuration <= 15 then
        return false -- Not worth resummoning if less than 15 seconds remain
    end

    -- Count active damage-increasing buffs when Fire Elemental was summoned
    local currentBuffCount = 0
    local newBuffCount = 0

    -- Helper function to check buff presence when Fire Elemental was summoned
    local function wasBuffActiveOnSummon(buffId)
        local aura = NAG:UnitAura("player", buffId)
        if aura and aura.expirationTime and aura.expirationTime - NAG:NextTime() > remainingDuration then -- RAKIZI: Changed 9/9/25 from GetTime() to NAG:NextTime()
            return true
        end
        return false
    end

    -- Check Bloodlust/Heroism buffs
    for _, buffId in ipairs(BLOODLUST_BUFF_IDS) do
        if wasBuffActiveOnSummon(buffId) then
            currentBuffCount = currentBuffCount + 1
        end
        if self:IsActiveAura(buffId) then
            newBuffCount = newBuffCount + 1
        end
    end

    -- Check Elemental Mastery
    if wasBuffActiveOnSummon(ELEMENTAL_MASTERY_ID) then
        currentBuffCount = currentBuffCount + 1
    end
    if self:IsActiveAura(ELEMENTAL_MASTERY_ID) then
        newBuffCount = newBuffCount + 1
    end

    -- Check Power Torrent proc
    if wasBuffActiveOnSummon(POWER_TORRENT_ID) then
        currentBuffCount = currentBuffCount + 1
    end
    if self:IsActiveAura(POWER_TORRENT_ID) then
        newBuffCount = newBuffCount + 1
    end

    -- Check Volcanic card proc
    if wasBuffActiveOnSummon(DMF_CARD_VOLCANIC_ID) then
        currentBuffCount = currentBuffCount + 1
    end
    if self:IsActiveAura(DMF_CARD_VOLCANIC_ID) then
        newBuffCount = newBuffCount + 1
    end

    -- Return true if we have more damage-increasing buffs now
    return newBuffCount > currentBuffCount
end

--- Calculates the duration of the new Savage Roar for Feral Druids.
--- @usage NAG:CatNewSavageRoarDuration() >= x
--- @return number Duration of Savage Roar.
function NAG:CatNewSavageRoarDuration()
    return (self:CurrentComboPoints() * 5 + 9)
end

--- Determines if the current Corruption should be recast for a better snapshot.
--- @param unit string The unit to check.
--- @usage NAG:WarlockShouldRefreshCorruption("unit")
--- @return boolean True if Corruption should be refreshed, false otherwise.
function NAG:WarlockShouldRefreshCorruption(unit)
    if not unit then
        self:Error("WarlockShouldRefreshCorruption: No unit provided")
        return false
    end
    --? if ttd < duration refresh?
    return true
end

local alreadyPooling = false
--- Triggers pooling visual overlay and WeakAuras event.
--- @usage NAG:Pooling()
--- @return boolean Always returns false.
function NAG:Pooling()
    -- Prevent multiple overlays from stacking
    if alreadyPooling then
        return false
    end


    -- Show pooling overlay on all active display frames
    local frames = DisplayManager:GetActivePrimaryFrames()
    if #frames > 0 then
        -- Set flag to prevent additional overlays
        alreadyPooling = true

        -- Show pooling overlay on all active primary frames
        for _, primaryFrame in ipairs(frames) do
            OverlayManager:ShowPooling(primaryFrame, function()
                local shouldContinue = self.isPooling == true
                -- Clear flag when pooling ends
                if not shouldContinue then
                    alreadyPooling = false
                end
                return shouldContinue
            end)
        end
    end
    return false
end

--- Hides the pooling visual overlay.
--- @usage NAG:StopPooling()
--- @return nil
--- @local This function is used to hide the pooling visual overlay.
function NAG:StopPooling()

    -- Hide pooling overlay from all active display frames
    for _, primaryFrame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
        OverlayManager:HidePooling(primaryFrame)
    end

    -- Clear pooling state
    self.isPooling = false
    alreadyPooling = false -- Also clear the overlay flag
end

--- @local
--- Triggers pooling for rogues via WeakAuras (Honor Among Thieves).
--- @usage NAG:RogueHaT()
--- @return boolean Always returns false.
function NAG:RogueHaT()
    if _G["WeakAuras"] and _G["WeakAuras"].ScanEvents then
        _G["WeakAuras"].ScanEvents("fonsas_rogue_HAT_cata", true)
    end
    return false
end

--- Triggers Deadly Calm for warriors via WeakAuras.
--- @usage NAG:DeadlyCalm()
--- @return boolean Always returns false.
function NAG:DeadlyCalm()
    if _G["WeakAuras"] and _G["WeakAuras"].ScanEvents then
        _G["WeakAuras"].ScanEvents("fonsas_war_deadlyCalm", true)
    end
    return false
end

--- Shows a cancel overlay for Bladestorm with a loop arrow and red text centered on the NAG frame.
--- Uses OverlayManager helpers; always returns false.
--- @usage NAG:CancelBladestorm()
--- @return boolean Always returns false
function NAG:CancelBladestorm()
    local BLADESTORM_AURA_ID = 46924 -- Bladestorm

    local cancelText = (L["Cancel"] or "Cancel") .. "\n" .. (L["Bladestorm"] or "Bladestorm")
    local customConfig = {
        text = cancelText,
        icon = "Interface\\Buttons\\UI-RefreshButton",
        color = { 1, 0.1, 0.1, 1 },
        iconAlpha = 0.3,
        center = true,
        xOffset = 0,
        yOffset = 0,
        duration = 0.3,
        scale = 1.2,
        textSize = 18
    }

    -- Show cancel overlay on all active display frames
    for _, anchorFrame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
        OverlayManager:ShowCancelAura(anchorFrame, BLADESTORM_AURA_ID, customConfig)
    end

    return false
end

--- Shows a cancel overlay for Astral Communion with a loop arrow and red text centered on the NAG frame.
--- Uses OverlayManager helpers; always returns false.
--- @usage NAG:CancelAstralCommunion()
--- @return boolean Always returns false
function NAG:CancelAstralCommunion()
    local ASTRAL_COMMUNION_AURA_ID = 127663 -- Astral Communion

    local cancelText = (L["Cancel"] or "Cancel") .. "\n" .. (L["Astral Communion"] or "Astral Communion")
    local customConfig = {
        text = cancelText,
        icon = "Interface\\Buttons\\UI-RefreshButton",
        color = { 1, 0.1, 0.1, 1 },
        iconAlpha = 0.3,
        center = true,
        xOffset = 0,
        yOffset = 0,
        duration = 0.3,
        scale = 1.2,
        textSize = 18
    }

    -- Show cancel overlay on all active display frames
    for _, anchorFrame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
        OverlayManager:ShowCancelAura(anchorFrame, ASTRAL_COMMUNION_AURA_ID, customConfig)
    end

    return false
end

--- Shows a guidance overlay for Astral Communion indicating the target energy range (60-40 going into moon).
--- Uses OverlayManager text overlay positioned on top of the main icon frame with timer-based persistence.
--- The overlay stays visible for 2.5 seconds after each call, preventing blinking.
--- @usage NAG:GuideAstralCommunion()
--- @return boolean Always returns false
function NAG:GuideAstralCommunion()
    -- Never guide Astral Communion while in combat
    if self:InCombat() then
        return false
    end
    local ASTRAL_COMMUNION_SPELL_ID = 127663 -- Astral Communion
    local OVERLAY_DURATION = 2.5 -- Duration in seconds to keep overlay visible

    -- Initialize state for tracking overlay visibility
    if not self._astralCommunionGuidanceState then
        self._astralCommunionGuidanceState = {
            showUntil = 0
        }
    end

    -- Update timestamp when function is called - extends visibility window
    local now = GetTime()
    self._astralCommunionGuidanceState.showUntil = now + OVERLAY_DURATION

    -- Text showing target range and moon direction
    local guidanceText = "<<<\n60-40\nMoon"

    -- Show text overlay on all active display frames when spell is being suggested
    for _, anchorFrame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
        OverlayManager:ShowTextOverlay(anchorFrame, guidanceText, nil, function()
            -- Show if within the timer window (prevents blinking)
            local currentTime = GetTime()
            if currentTime < self._astralCommunionGuidanceState.showUntil then
                return true
            end
            -- Hide if timer expired
            return false
        end, {
            id = ASTRAL_COMMUNION_SPELL_ID,
            point = "CENTER",
            relativePoint = "CENTER",
            xOffset = 0,
            yOffset = 0,
            fontColor = { 1, 1, 1, 1 }, -- White text
            fontSize = 14,
            pulse = false,
            background = {
                enable = false
            }
        })
    end

    return false
end

--- Shows a text overlay on icon frames with customizable options.
--- Displays text along the top margin of the target icon by default (just above the primary icon), with options for font size, alignment, and positioning.
--- Can target any icon frame (primary, above, below, left, right) and position text inside or outside the frame.
--- Similar to GuideAstralCommunion() but with user-specified text and customizable options.
--- The overlay persists until combat ends or the frame is hidden. Calling with the same text/id updates the existing overlay.
--- Note: Text rotation is not directly supported by WoW FontStrings. Use point/relativePoint for alignment control.
--- @param text string The text to display (required). Supports newlines with \n
--- @param options table|nil Optional configuration table with:
---   - position (string|number): Target frame position - "primary", "above1", "below1", "left1", "right1", etc.
---     Can also use NAG.SPELL_POSITIONS constants. Default: "primary"
---   - fontSize (number): Font size (default: 12)
---   - point (string): Anchor point for the text - "TOP", "BOTTOM", "CENTER", etc. (default: "BOTTOM" so the text sits just above the icon)
---   - relativePoint (string): Relative anchor point on the target frame (default: "TOP" when using the default `point`, otherwise matches `point`)
---   - xOffset (number): Horizontal offset in pixels. Positive = right, negative = left (default: 0)
---   - yOffset (number): Vertical offset in pixels. Positive = up, negative = down (default: 10 to raise the text above the icon by default)
---   - fontColor (table): RGBA color table {r, g, b, a} (default: {1, 1, 1, 1} - white)
---   - pulse (boolean): Enable pulse animation (default: false)
---   - id (string|number): Unique identifier for overlay (default: uses text as key)
---   - background (table): Background configuration {enable, color, padding, texture}
--- @usage NAG:OverlayText("BURST\nNOW") -- Default: top margin above the primary icon
--- @usage NAG:OverlayText("BURST\nNOW", {position = "primary", fontSize = 16, fontColor = {1, 0, 0, 1}})
--- @usage NAG:OverlayText("READY", {position = "above1", point = "CENTER", yOffset = 0}) -- Center of icon
--- @usage NAG:OverlayText("POOL", {position = NAG.SPELL_POSITIONS.PRIMARY, point = "BOTTOM", yOffset = -15})
--- @return boolean Always returns true
function NAG:OverlayText(text, options)
    if not text or text == "" then
        return true
    end


    if not DisplayManager or not OverlayManager then
        return true
    end

    -- Default options (using snake_case to match schema)
    options = options or {}
    local fontSize = options.font_size or 12
    -- Default to anchoring the text just above the icon (top margin)
    local point = options.point or "BOTTOM"
    local relativePoint = options.relative_point or (point == "BOTTOM" and "TOP" or point)
    local xOffset = options.x_offset or 0
    -- Default yOffset adds a gap above the icon; negative values move text closer/inside the icon
    local yOffset = options.y_offset ~= nil and options.y_offset or 10

    -- Handle font_color (FontColor message type with r, g, b, a fields)
    local fontColor = { 1, 1, 1, 1 } -- Default: white
    if options.font_color then
        local fc = options.font_color
        fontColor = {
            fc.r or fc[1] or 1,
            fc.g or fc[2] or 1,
            fc.b or fc[3] or 1,
            fc.a or fc[4] or 1
        }
    end

    local pulse = options.pulse or false
    local overlayId = options.id or text -- Use text as default ID for uniqueness
    local overlaySpellId = options.spellId
    local targetPosition = options.position or "primary" -- Default to primary frame

    -- Read background configuration (BackgroundConfig message type)
    local background = options.background or {}
    local bgEnable = background.enable or false
    local bgPadding = background.padding or 0
    local bgTexture = background.texture or "Interface\\Buttons\\WHITE8X8"

    -- Handle background.color (FontColor message type with r, g, b, a fields)
    local bgColor = { 0, 0, 0, 0.5 } -- Default: semi-transparent black
    if background.color then
        local bc = background.color
        bgColor = {
            bc.r or bc[1] or 0,
            bc.g or bc[2] or 0,
            bc.b or bc[3] or 0,
            bc.a or bc[4] or 0.5
        }
    end

    -- Normalize position to string format
    local positionKey
    if type(targetPosition) == "number" then
        -- If it's a SPELL_POSITIONS constant, convert to string
        if targetPosition == ns.SPELL_POSITIONS.PRIMARY then
            positionKey = "primary"
        elseif targetPosition == ns.SPELL_POSITIONS.AOE then
            positionKey = "aoe"
        else
            -- For numbered positions, try to match pattern
            positionKey = tostring(targetPosition)
        end
    else
        positionKey = strlower(tostring(targetPosition))
    end

    -- Get target frame(s) - supports both legacy and group display
    local targetFrames = {}
    local frame = DisplayManager:GetFrameForPosition(positionKey)
    if frame then
        tinsert(targetFrames, frame)
    end
    -- Fallback for primary: GetActivePrimaryFrames (e.g. when round + main both shown)
    if #targetFrames == 0 and positionKey == "primary" then
        local primaryFrames = DisplayManager:GetActivePrimaryFrames()
        for _, f in ipairs(primaryFrames) do
            tinsert(targetFrames, f)
        end
    end

    -- If still no frames found, return early
    if #targetFrames == 0 then
        return true
    end

    -- Build custom config - use ShowOverlay directly like pooling does
    -- This gives us full control over positioning and avoids ShowTextOverlay's default positioning
    -- We want overlay centered on icon (full-size), with text positioned at TOP of overlay (top margin)
    -- Note: We'll set size dynamically per frame to ensure full coverage
    local baseConfig = {
        -- Overlay frame positioning - CENTER on icon (full-size overlay covering icon)
        point = "CENTER",  -- Overlay centered on icon
        relativePoint = "CENTER",  -- Relative to icon center
        xOffset = 0,  -- No horizontal offset
        yOffset = 0,  -- No vertical offset (overlay covers entire icon)
        -- Text properties (ShowOverlay will create text on overlay like pooling does)
        text = text,
        textColor = fontColor,
        textSize = fontSize,
        textFont = "Friz Quadrata TT",
        textFlags = "OUTLINE",
        -- Background texture configuration
        texture = bgEnable and bgTexture or nil,
        textureAlpha = bgEnable and (bgColor[4] or bgColor.a or 0.5) or 0,
        textBackground = {
            enable = false
        },
        alpha = 1.0,  -- Text alpha
        showSpellIcon = false,
        pulse = pulse,
        -- Use spellId as unique identifier for overlay key
        spellId = overlayId
    }

    local upperPoint = string.upper(point)
    local horizontalJustify = "CENTER"
    if upperPoint:find("LEFT", 1, true) then
        horizontalJustify = "LEFT"
    elseif upperPoint:find("RIGHT", 1, true) then
        horizontalJustify = "RIGHT"
    end
    local verticalJustify = "MIDDLE"
    if upperPoint:find("TOP", 1, true) then
        verticalJustify = "TOP"
    elseif upperPoint:find("BOTTOM", 1, true) then
        verticalJustify = "BOTTOM"
    end

    -- Show overlay on all target frames using ShowOverlay directly (like pooling)
    -- This creates a full-size overlay centered on icon, then we position text at top of overlay
    for _, anchorFrame in ipairs(targetFrames) do
        -- Verify frame exists and is valid
        if anchorFrame and anchorFrame.GetName then
            local function applyTextLayout(fontString)
                if not fontString then
                    return
                end
                fontString:ClearAllPoints()
                fontString:SetPoint(point, anchorFrame, relativePoint or point, xOffset, yOffset)
                fontString:SetJustifyH(horizontalJustify)
                fontString:SetJustifyV(verticalJustify)
            end

            -- Calculate overlay size to cover entire icon
            -- size >= 1 means pixels, size < 1 means percentage
            -- Use frame width in pixels to ensure full coverage
            local frameWidth = anchorFrame:GetWidth() or 64
            local customConfig = {}
            for k, v in pairs(baseConfig) do
                customConfig[k] = v
            end
            customConfig.size = frameWidth  -- Use frame width in pixels (size >= 1 = pixels mode)

            -- Use ShowOverlay with "pooling" type as template (it supports text property)
            -- Overlay will be full-size and centered on icon
            local checkFunc
            if overlaySpellId then
                local spellIdForCheck = overlaySpellId
                checkFunc = function()
                    if not anchorFrame or not anchorFrame:IsShown() then
                        return false
                    end

                    -- Frames store spellId for spells and id for general reference
                    if anchorFrame.spellId and anchorFrame.spellId == spellIdForCheck then
                        return true
                    end
                    if anchorFrame.id and anchorFrame.id == spellIdForCheck then
                        return true
                    end

                    return false
                end
            end

            local overlay = OverlayManager:ShowOverlay(anchorFrame, "pooling", nil, checkFunc, customConfig)

            -- Update and reposition the text
            -- ShowOverlay creates text centered by default, we need to reposition it to TOP
            if overlay and overlay.text then
                overlay.text:SetText(text)
                overlay.text:SetTextColor(unpack(fontColor))
                local LSM = ns.LibSharedMedia
                local fontPath = LSM:Fetch("font", "Friz Quadrata TT") or LSM:GetDefault("font")
                local success = overlay.text:SetFont(fontPath, fontSize, "OUTLINE")
                if not success then
                    -- Fallback font
                    overlay.text:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
                end
                applyTextLayout(overlay.text)
                OverlayManager:UpdateOverlayTextBackground(overlay)
            elseif overlay then
                -- Text doesn't exist yet, but overlay does - create it manually
                overlay.text = overlay:CreateFontString(nil, "OVERLAY")
                local LSM = ns.LibSharedMedia
                local fontPath = LSM:Fetch("font", "Friz Quadrata TT") or LSM:GetDefault("font")
                local success = overlay.text:SetFont(fontPath, fontSize, "OUTLINE")
                if not success then
                    overlay.text:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
                end
                overlay.text:SetText(text)
                overlay.text:SetTextColor(unpack(fontColor))
                overlay.text:SetAlpha(1.0)
                applyTextLayout(overlay.text)
                overlay.text:Show()
                OverlayManager:UpdateOverlayTextBackground(overlay)
            end

            -- Apply background if enabled
            if overlay and overlay.texture then
                if bgEnable then
                    overlay.texture:Show()
                    overlay.texture:SetTexture(bgTexture)
                    overlay.texture:SetColorTexture(bgColor[1], bgColor[2], bgColor[3], bgColor[4])
                    -- Adjust texture size to account for padding if needed
                    -- The texture should cover the text area plus padding
                    if bgPadding > 0 and overlay.text then
                        local textWidth = overlay.text:GetStringWidth() or 0
                        local textHeight = overlay.text:GetStringHeight() or 0
                        local paddedWidth = textWidth + (bgPadding * 2)
                        local paddedHeight = textHeight + (bgPadding * 2)
                        -- Only resize if the padding would make it larger than current size
                        local currentWidth, currentHeight = overlay.texture:GetSize()
                        if paddedWidth > currentWidth or paddedHeight > currentHeight then
                            overlay.texture:SetSize(math.max(paddedWidth, currentWidth), math.max(paddedHeight, currentHeight))
                        end
                    end
                else
                    overlay.texture:Hide()
                end
            end
        end
    end

    return false
end

--- Returns whether Slam should override Overpower within the current Colossus Smash window.
--- Uses WarriorArmsCSWindow (message-driven) and caches result for ~50ms to minimize CPU.
--- @return boolean True if Slam should override Overpower for the remainder of the active CS window
function NAG:WarriorShouldSlamOverride()
    -- Small time-based cache (called ~20x/sec)
    local now = GetTime()
    local cache = self._warriorCSOverrideCache
    if cache and (now - (cache.ts or 0)) < 0.25 then
        return cache.val == true
    end

    -- Class gate: only compute for warriors
    if NAG.CLASS_FILENAME ~= "WARRIOR" then
        self._warriorCSOverrideCache = { val = false, ts = now }
        return false
    end

    -- Lazy module lookup and cache the reference
    local mod = self._warriorArmsCSWindowModule
    if not mod then
        mod = NAG:GetModule("WarriorArmsCSWindow")  -- Optional module, keep GetModule
        self._warriorArmsCSWindowModule = mod
    end

    local result = false
    if mod and mod.ShouldSlamOverride and (not mod.IsEnabled or mod:IsEnabled()) then
        result = mod:ShouldSlamOverride() == true
    end

    self._warriorCSOverrideCache = { val = result, ts = now }
    return result
end

--- Convenience inverse: returns true when Slam should NOT override Overpower within CS window.
--- @return boolean True if standard priority (no Slam override) should apply
function NAG:WarriorShouldNotSlamOverride()
    return not self:WarriorShouldSlamOverride()
end

--- Performs the optimal rotation action for a Feral Druid (Cat form) (not yet implemented).
--- @usage NAG:CatOptimalRotationAction()
--- @return boolean Always returns false (not implemented).
--- @local This function is used to perform the optimal rotation action for a Feral Druid (Cat form)
function NAG:CatOptimalRotationAction()
    -- TODO: Implement Feral Druid optimal rotation logic.
    -- One-time warning per session to avoid spam
    if not self._catOptimalRotationWarningShown then
        self:Error("CatOptimalRotationAction is not yet fully implemented.")
        self._catOptimalRotationWarningShown = true
    end
    return false
end

--- Casts a Paladin spell and shows overlays for seals or melee abilities.
--- @param spellId number The spell ID to cast.
--- @usage NAG:PaladinCast(12345)
--- @return boolean True if the spell was set up for casting, false otherwise.
function NAG:PaladinCast(spellId)
    if not spellId then return false end

    -- Check if spell can be cast
    if not self:SpellCanCast(spellId) then
        return false
    end

    -- Get spell info for custom config
    local customConfig = {
        spellIcon = GetSpellTexture(spellId)
    }

    -- Show appropriate overlay based on spell type on all active display frames
    local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if entity and entity.flags then
        local overlayType = nil
        if entity.flags.seal then
            overlayType = "guitarhero"
        elseif entity.flags.melee then
            overlayType = "startattack"
        end

        if overlayType then
            for _, displayFrame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
                OverlayManager:ShowOverlay(displayFrame, overlayType, nil, function()
                    return self:AuraIsActive(spellId)
                end, customConfig)
            end
        end
    end

    -- Set up the spell cast
    self.nextSpell = self:NormalizePrimaryAction(spellId, { context = "apl_class_primary" })

    return true
end

--- Casts a Paladin spell with a macro overlay (startattack/stopattack).
--- @param spellId number The spell ID to cast.
--- @param macro string The macro type ("STARTATTACK" or "STOPATTACK").
--- @usage NAG:PaladinCastWithMacro(12345, "STARTATTACK")
--- @return boolean True if the spell was set up for casting, false otherwise.
function NAG:PaladinCastWithMacro(spellId, macro)
    if not spellId then
        self:Warn("PaladinCastWithMacro: No spellId provided")
        return false
    end

    -- Validate macro type (case-insensitive)
    local upperMacro = strupper(macro)
    if upperMacro ~= "STARTATTACK" and upperMacro ~= "STOPATTACK" then
        self:Error(format("PaladinCastWithMacro: Invalid macro type: %s", tostring(macro)))
        return false
    end

    -- Check if spell can be cast
    if not self:SpellCanCast(spellId) then
        return false
    end

    -- Get spell info for custom config
    local customConfig = {
        spellIcon = GetSpellTexture(spellId)
    }

    -- Show appropriate overlay on all active display frames (using lowercase for overlay type)
    local overlayType = strlower(macro)
    for _, displayFrame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
        OverlayManager:ShowOverlay(displayFrame, overlayType, nil, function()
            -- Check if this spell is currently set as nextSpell
            local nextIdentity = self.NormalizePrimaryAction and self:NormalizePrimaryAction(self.nextSpell) or nil
            local nextResolveId = nextIdentity and (self.GetActionResolveId and self:GetActionResolveId(nextIdentity)) or nil
            return nextResolveId == spellId
        end, customConfig)
    end

    -- Set up the spell cast
    self.nextSpell = self:NormalizePrimaryAction(spellId, { context = "apl_class_primary" })
    self.nextMacro = upperMacro -- Store the uppercase version for consistency

    return true
end

--- Gets the remaining time for a totem.
--- @param totemType number The type/slot of the totem (1-4) or spell ID
--- @usage NAG:TotemRemainingTime(1) >= x
--- @usage NAG:TotemRemainingTime(115313) -- Jade Serpent Statue
--- @return number The remaining time for the totem in seconds.
function NAG:TotemRemainingTime(totemType)
    if not totemType then return 0 end

    -- If it's a spell ID (large number), find which totem slot it's in
    if totemType > 5 then
        for slot = 1, 4 do
            local hasTotem, totemName, startTime, duration, totemIcon, modRate, totemSpellId = GetTotemInfo(slot)
            if hasTotem and totemSpellId == totemType then
                return GetTotemTimeLeft(slot) or 0
            end
        end
        return 0
    end

    -- Traditional totem slot (1-4)
    local remainingTime = GetTotemTimeLeft(totemType)
    return remainingTime or 0
end

-- Define the spell IDs for seals
local SEAL_IDS = {
    20375, -- Seal of Command
    31801, -- Seal of Truth
    20165, -- Seal of Insight
    20154, -- Seal of Righteousness
    20164, -- Seal of Justice
    20411, -- Seal of Fury
    21084, -- Seal of the Crusader
    31892, -- Seal of Blood (Horde)
    53720, -- Seal of the Martyr (Alliance)
    53719, -- Seal of Corruption (Horde)
    53736, -- Seal of Corruption (Horde) (alt ID used in some data sets/expansions)
    31801, -- Seal of Vengeance (Alliance)
    20165, -- Seal of Light
    20357, -- Seal of Wisdom
    407798 -- Seal of Martyrdom
}

local knownSealNames
local function initializeSealNames()
    if knownSealNames then return end
    knownSealNames = {}
    for _, id in ipairs(SEAL_IDS) do
        local spell = DataManager:Get(id, DataManager.EntityTypes.SPELL)
        if spell then
            local name = spell.name
            if name then
                knownSealNames[name] = true
            end
        end
    end
end

--- Gets the remaining time for the currently active Paladin seal.
--- @usage NAG:CurrentSealRemainingTime()
--- @return number The remaining time for the active seal in seconds, or 0 if none is active.
function NAG:CurrentSealRemainingTime()
    if not knownSealNames then
        initializeSealNames()
    end
    -- Check each seal ID using our Spell table and UnitAura
    for name in pairs(knownSealNames) do
        local aura = NAG:UnitAura("player", name)
        if aura then
            local expirationTime = aura.expirationTime
            if expirationTime then
                local remainingTime = expirationTime - NAG:NextTime()
                return remainingTime > 0 and remainingTime or 0
            end
        end
    end
    return 0
end

--- Counts unique group/raid members who have a player-cast aura active.
--- Uses HELPFUL|PLAYER to ensure only auras cast by the player are counted (e.g., Renewing Mist).
--- If not in a group, returns 1 if the player has the aura (player-cast), else 0.
--- Delegates to EnhancedAuraHandlers for unified implementation.
--- @param spellId number The spell ID of the aura to count
--- @param filter string|nil Optional filter (defaults to "HELPFUL|PLAYER")
--- @return number The count of unique party/raid members with the player-cast aura
function NAG:CountRaidMembersWithAura(spellId, filter)
    return EnhancedAuraHandlers:CountRaidMembersWithAura(spellId, filter)
end

-- Small cache for average raid HP to avoid rescanning too frequently
local _avgRaidHPCache = { ts = 0, val = 1 }

-- ============================ SHARED UNIT VALIDATION HELPERS ============================

--- Shared helper to get unit HP fraction if valid (alive, connected, exists)
--- @param unit string Unit ID (e.g., "player", "raid1", "party1")
--- @return number|nil HP fraction (0.0-1.0) or nil if invalid
local function getUnitHPFraction(unit)
    if not UnitExists(unit) then return nil end
    if UnitIsDeadOrGhost(unit) then return nil end
    if UnitIsConnected and not UnitIsConnected(unit) then return nil end
    local maxhp = UnitHealthMax(unit)
    if not maxhp or maxhp <= 0 then return nil end
    local hp = UnitHealth(unit) or 0
    return hp / maxhp
end

--- Computes the average health fraction across alive, connected players in the group/raid.
--- Dead or offline players are excluded from both sum and count. Solo uses player only.
--- Results are cached for 0.8 seconds; no background scheduling is performed.
--- @usage local hpAvg = NAG:AvgRaidHP()
--- @return number Average HP as a fraction from 0.0 to 1.0
function NAG:AvgRaidHP()
    local now = GetTime()
    local cache = _avgRaidHPCache
    if cache and (now - (cache.ts or 0)) < 0.8 then
        return cache.val or 0
    end

    local sum, count = 0, 0
    local groupUnits = self:GetGroupMemberUnits()
    for i = 1, #groupUnits do
        local pct = getUnitHPFraction(groupUnits[i])
        if pct then
            sum = sum + pct
            count = count + 1
        end
    end

    local result = (count > 0) and (sum / count) or 0
    _avgRaidHPCache.val = result
    _avgRaidHPCache.ts = now
    return result
end

-- Small cache and constant for Renewing Mist-based average HP
local _avgRemHPCache = { ts = 0, val = 1 }
local RENEWING_MIST_ID = 115151 -- Renewing Mist

--- Computes average HP fraction among friendly group/raid members who currently have
--- Renewing Mist active on them from the player. Excludes dead/offline units. Solo
--- considers player only. Cached for 0.8 seconds; no timers are scheduled.
--- @usage local hpAvg = NAG:AvgRemHP()
--- @return number Average HP as a fraction from 0.0 to 1.0
function NAG:AvgRemHP()
    local now = GetTime()
    local cache = _avgRemHPCache
    if cache and (now - (cache.ts or 0)) < 0.8 then
        return cache.val or 0
    end

    -- Only meaningful for Monks; otherwise return 0
    if NAG.CLASS_FILENAME ~= "MONK" then
        _avgRemHPCache.val = 0
        _avgRemHPCache.ts = now
        return 0
    end

    local sum, count = 0, 0
    local groupUnits = self:GetGroupMemberUnits()
    for i = 1, #groupUnits do
        local unit = groupUnits[i]
        local pct = getUnitHPFraction(unit)
        if pct then
            local aura = NAG:UnitAura(unit, RENEWING_MIST_ID, "HELPFUL|PLAYER")
            if aura then
                sum = sum + pct
                count = count + 1
            end
        end
    end

    local result = (count > 0) and (sum / count) or 1.0
    _avgRemHPCache.val = result
    _avgRemHPCache.ts = now
    return result
end

-- Backwards-compatible alias to match expected casing

-- Cache for next Renewing Mist target selection (by name)
local _remTargetCache = { ts = 0, name = nil }

--- Scans party/raid to find the alive, connected friendly with the lowest HP percent
--- who does NOT currently have Renewing Mist (115151) from the player. Returns the unit's name.
--- Results are cached for 0.85 seconds to avoid frequent scans.
--- @usage local name = NAG:NextRemTargetName()
--- @return string|nil The unit name, or nil if none found or not a Monk
--- @local This function is used to find the alive, connected friendly with the lowest HP percent who does NOT currently have Renewing Mist (115151) from the player.
function NAG:NextRemTargetName()
    local now = GetTime()
    local cache = _remTargetCache
    if cache and (now - (cache.ts or 0)) < 0.85 then
        return cache.name
    end

    -- Only relevant for Monks
    if NAG.CLASS_FILENAME ~= "MONK" then
        _remTargetCache.name = nil
        _remTargetCache.ts = now
        return nil
    end

    local lowestName = nil
    local lowestFrac = 2 -- sentinel above 1.0

    if self:PlayerIsInRaid() then
        for i = 1, 40 do
            local unit = "raid" .. i
            local frac = getUnitHPFraction(unit)
            if frac then
                -- Skip if Renewing Mist from player is already active on this unit
                local aura = NAG:UnitAura(unit, RENEWING_MIST_ID, "HELPFUL|PLAYER")
                if not aura and frac < lowestFrac then
                    lowestFrac = frac
                    lowestName = UnitName(unit)
                end
            end
        end
    elseif self:PlayerIsInGroup() then
        local frac = getUnitHPFraction("player")
        if frac then
            local aura = NAG:UnitAura("player", RENEWING_MIST_ID, "HELPFUL|PLAYER")
            if not aura and frac < lowestFrac then
                lowestFrac = frac
                lowestName = UnitName("player")
            end
        end
        for i = 1, 4 do
            local unit = "party" .. i
            local frac = getUnitHPFraction(unit)
            if frac then
                local aura = NAG:UnitAura(unit, RENEWING_MIST_ID, "HELPFUL|PLAYER")
                if not aura and frac < lowestFrac then
                    lowestFrac = frac
                    lowestName = UnitName(unit)
                end
            end
        end
    else
        local frac = getUnitHPFraction("player")
        if frac then
            local aura = NAG:UnitAura("player", RENEWING_MIST_ID, "HELPFUL|PLAYER")
            if not aura and frac < lowestFrac then
                lowestFrac = frac
                lowestName = UnitName("player")
            end
        end
    end

    _remTargetCache.name = lowestName
    _remTargetCache.ts = now
    return lowestName
end

-- Lightweight overlay state (no timers, only time checks)
local _remOverlayState = { expireAt = 0, lastUpdate = 0, lastName = nil }

--- Shows an overlay on the NAG frame with the next Renewing Mist target's name.
--- Uses the same cached selection from NextRemTargetName(); overlay updates on subsequent calls.
--- @usage NAG:ShowNextRemTargetOverlay()
--- @return nil
--- @local
function NAG:ShowNextRemTargetOverlay()
    local name = self:NextRemTargetName()
    if not name then return end


    -- Show overlay on all active display frames
    for _, anchor in ipairs(DisplayManager:GetActivePrimaryFrames()) do
        -- Use pooling-style overlay to display centered name (dynamic text)
        local overlay = OverlayManager:ShowOverlay(anchor, "pooling", nil, function()
            local exp = _remOverlayState and _remOverlayState.expireAt or 0
            return GetTime() <= exp
        end)
        if overlay then
            overlay:SetFrameStrata("HIGH")
            overlay:SetFrameLevel(anchor:GetFrameLevel() + 10)
        end
        if overlay and overlay.text then
            overlay.text:SetText(name)
            overlay.text:Show()
        else
            -- Fallback to text overlay if pooling text is disabled in config
            local textOverlay = OverlayManager:ShowTextOverlay(anchor, name, nil, function()
                local exp = _remOverlayState and _remOverlayState.expireAt or 0
                return GetTime() <= exp
            end, { id = "NextRemTarget", fontSize = 9 })
            if textOverlay then
                textOverlay:SetFrameStrata("HIGH")
                textOverlay:SetFrameLevel(anchor:GetFrameLevel() + 10)
            end
        end
    end
end

--- Conditionally shows the next Renewing Mist target overlay if REM is usable.
--- Safe to call several times per second; internally throttled and uses selection cache.
--- @usage NAG:RemOverlayTick()
--- @return boolean Always returns false
--- @local Internal utility function for overlay management
function NAG:RemOverlayTick()
    -- Class gate
    if NAG.CLASS_FILENAME ~= "MONK" then return false end

    -- Only show overlay if REM is actually castable/usable now
    if not self.SpellCanCast or not self:SpellCanCast(RENEWING_MIST_ID) then
        return false
    end

    local now = GetTime()
    -- Refresh hold window if called frequently enough (<= 0.4s since last call)
    if (now - (_remOverlayState.lastUpdate or 0)) <= 0.4 then
        _remOverlayState.expireAt = now + 0.5
    elseif _remOverlayState.expireAt <= now then
        -- If already expired, start a new hold window
        _remOverlayState.expireAt = now + 0.5
    end
    _remOverlayState.lastUpdate = now

    -- Determine current best target (cached scan inside)
    local name = self:NextRemTargetName()
    if not name then return false end

    -- Only update overlay content if name changed
    if name ~= _remOverlayState.lastName then
        self:ShowNextRemTargetOverlay()
        _remOverlayState.lastName = name
    end
    return false
end

--- Lightweight variant for callers that have already validated REM usability.
--- Avoids calling SpellCanCast inside to prevent recursion when invoked from SpellCanCast.
--- @usage NAG:RemOverlayTickPrevalidated()
--- @return boolean Always returns false
--- @local Internal utility function for overlay management
function NAG:RemOverlayTickPrevalidated()
    if NAG.CLASS_FILENAME ~= "MONK" then return false end

    local now = GetTime()
    if (now - (_remOverlayState.lastUpdate or 0)) <= 0.4 then
        _remOverlayState.expireAt = now + 0.5
    elseif _remOverlayState.expireAt <= now then
        _remOverlayState.expireAt = now + 0.5
    end
    _remOverlayState.lastUpdate = now

    local name = self:NextRemTargetName()
    if not name then return false end

    -- Always show/update the overlay; ShowOverlay reuses existing frame
    self:ShowNextRemTargetOverlay()
    _remOverlayState.lastName = name
    return false
end

--- Assigns the next Renewing Mist target by name for downstream use (e.g., macros/UI)
--- Uses cached selection logic. Stores on self.nextRemTargetName and returns it.
--- @usage local name = NAG:AssignNextRemTarget()
--- @return string|nil The selected unit name or nil
--- @local Internal utility function for overlay management
function NAG:AssignNextRemTarget()
    local name = self:NextRemTargetName()
    self.nextRemTargetName = name
    return name
end

--- Checks if a specific rune is equipped.
--- @param runeId number The ID of the rune to check.
--- @usage NAG:RuneIsEquipped(12345)
--- @return boolean True if the rune is equipped, false otherwise.
function NAG:RuneIsEquipped(runeId)
    -- Iterate through all equipped runes
    if not runeId then return false end
    return C_Engraving and C_Engraving.IsRuneEquipped(runeId) or false
end

--- Predicts the player's energy after a given duration (in seconds).
--- @param duration number The duration in seconds to predict energy for.
--- @usage NAG:CatEnergyAfterDuration(3.5) >= 60
--- @return number The predicted energy after the given duration (capped at max).
function NAG:CatEnergyAfterDuration(duration)
    if not duration or type(duration) ~= "number" or duration <= 0 then
        return self:CurrentEnergy()
    end
    local currentEnergy = self:CurrentEnergy()
    local maxEnergy = self.MaxEnergy and self:MaxEnergy() or 100
    local tickRate = 2.0     -- Energy ticks every 2 seconds
    local energyPerTick = 10 -- 10 energy per tick
    local timeToNextTick = self.TimeToEnergyTick and self:TimeToEnergyTick() or tickRate

    -- How many full ticks fit in the duration (after the next tick)
    local ticks = 0
    if timeToNextTick < duration then
        ticks = 1 + math.floor((duration - timeToNextTick) / tickRate)
    end
    local predictedEnergy = currentEnergy + (ticks * energyPerTick)
    return math.min(predictedEnergy, maxEnergy)
end

--- Gets the current focus of the Hunter's pet.
--- @usage NAG:HunterCurrentPetFocus()
--- @return number The current focus value of the pet.
function NAG:HunterCurrentPetFocus()
    return UnitPower("pet", Enum.PowerType.Focus)
end

--- Gets the current focus percent (0-100) of the Hunter's pet.
--- @usage NAG:HunterCurrentPetFocusPercent()
--- @return number The current focus percent (0-100) of the pet.
function NAG:HunterCurrentPetFocusPercent()
    if not UnitExists("pet") then return 0 end
    local current = UnitPower("pet", Enum.PowerType.Focus)
    local maxPower = UnitPowerMax("pet", Enum.PowerType.Focus)
    if not maxPower or maxPower == 0 then return 0 end
    return (current / maxPower) * 100
end

--- Checks if the Hunter's pet is currently active.
--- @usage NAG:HunterPetIsActive()
--- @return boolean True if the pet exists, false otherwise.
function NAG:HunterPetIsActive()
    return UnitExists("pet")
end

--- @deprecated Use NAG:DruidCurrentEclipsePhase() instead, which returns the proper phase format ("SolarPhase", "LunarPhase", "NeutralPhase") that WoWSims expects.
--- Gets the current Eclipse direction for a Balance Druid.
--- Returns "sun" (toward Solar), "moon" (toward Lunar), or "none" if not moving or unavailable.
--- @usage NAG:DruidGetEclipseDirection() == "sun"
--- @return string The current Eclipse direction ("sun", "moon", or "none").
function NAG:DruidGetEclipseDirection()
    if GetEclipseDirection then
        return GetEclipseDirection() or "none"
    else
        return "none"
    end
end

--- Checks if the player is currently dual wielding weapons.
--- Determines dual wielding by checking if there's an item equipped in the offhand slot (slot 17).
--- @usage NAG:IsDualWield()
--- @return boolean True if the player is dual wielding, false otherwise
function NAG:IsDualWield()
    local offhandItem = GetInventoryItemLink("player", 17)
    return offhandItem ~= nil
end

--- Gets the time until the next Chi Brew charge is available
--- @return number Time in seconds until next Chi Brew charge
--- @local This function is used to get the time until the next Chi Brew charge is available.
--- @deprecated Is this used?
function NAG:MonkNextChiBrewRecharge()
    if self.CLASS_FILENAME ~= "MONK" then
        return 0
    end

    local spellId = 115399 -- Chi Brew spell ID

    -- For talent spells, check if we have charge info instead of IsKnown
    -- (IsKnown doesn't detect talent spells properly)
    local chargeInfo = WoWAPI.GetSpellCharges(spellId)
    if not chargeInfo then
        return 0
    end

    local charges, maxCharges = chargeInfo.currentCharges, chargeInfo.maxCharges

    -- If no charge system (maxCharges would be nil)
    if not maxCharges then
        return 0
    end

    -- If all charges available
    if charges >= maxCharges then
        return 0
    end

    -- If no charges but spell is on cooldown
    if charges == 0 then
        local cdInfo = WoWAPI.GetSpellCooldown(spellId)
        if cdInfo then
            local start, duration = cdInfo.startTime, cdInfo.duration
            if start > 0 and duration > 0 then
                return max(0, (start + duration) - NAG:NextTime())
            end
        end
    end

    -- Calculate time until next charge
    local chargeStart = chargeInfo.cooldownStartTime
    local chargeDuration = chargeInfo.cooldownDuration

    if chargeStart and chargeDuration and chargeDuration > 0 then
        local timeToNextCharge = (chargeStart + chargeDuration) - NAG:NextTime()
        return max(0, timeToNextCharge)
    end

    return 0
end

--- Determine if the warrior should proactively use interrupt based on prior encounter/mob history
--- and glyph presence (Glyph of Rude Interruption).
--- @usage NAG:WarriorShouldInterrupt()
--- @return boolean True if the warrior should use interrupt, false otherwise
--- @note Originally from WarriorArmsCSWindow module - moved to APL_Class for better organization
function NAG:WarriorShouldInterrupt()
    -- Class gate
    if NAG.CLASS_FILENAME ~= "WARRIOR" then return false end

    -- User preference gate
    if self.GetClassSetting and not self:GetClassSetting("enableSmartInterrupts", true) then
        return false
    end


    -- Glyph requirement
    if not self.HasGlyph or not self:HasGlyph(58372) then
        return false
    end

    -- Access persisted history
    local db = StateManager.db
    if not db or not db.global or not db.global.interruptHistory then
        return false
    end
    local history = db.global.interruptHistory

    -- If currently in an encounter we have seen interrupts before, return true
    local encounterId = StateManager.currentEncounterId or nil
    if encounterId and history.encounters[encounterId] then
        return true
    end

    -- Otherwise, check current target name against known interruptible mob history
    local targetName = UnitExists("target") and UnitName("target") or nil
    if targetName and history.mobs[targetName] then
        return true
    end

    return false
end

--- Get the number of stored combo points from the previous target (for rogue redirect functionality).
--- Returns combo points that were stored when switching targets, allowing efficient use of Redirect.
--- @usage NAG:CurrentStoredComboPoints()
--- @return number The number of stored combo points
--- @note On MoP-style clients, UnitPower("player", ComboPoints) reflects stored CP regardless of target
function NAG:CurrentStoredComboPoints()
    return UnitPower("player", Enum.PowerType.ComboPoints) or 0
end

--- Gets a class-specific setting value from the active class module's database.
--- Accesses settings from classModule.db.class namespace using dot notation.
--- @function NAG:GetClassSetting
--- @param ... string|any Variable arguments: either (key, defaultValue) or (key1, key2, ..., defaultValue)
--- @return any The setting value from classModule.db.class namespace, or defaultValue if not found
--- @usage local value = NAG:GetClassSetting("recommendAspects", true)
--- @usage local value = NAG:GetClassSetting("settings", "size", 10)
function NAG:GetClassSetting(...)
    local classModule = NAG:GetClassModule()
    if classModule and classModule.db then
        return classModule:GetSetting("class", ...)
    end
    -- Return the last argument as default if class module not available
    return select(-1, ...)
end
