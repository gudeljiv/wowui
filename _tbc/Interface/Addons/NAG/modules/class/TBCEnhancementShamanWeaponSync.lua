--- @module "NAG.TBCEnhancementShamanWeaponSync"
--- Module for TBC Enhancement Shaman weapon synchronization
---
--- This module helps TBC Enhancement Shamans synchronize their dual-wield weapons
--- to maximize damage output by ensuring both weapons hit simultaneously.
--- Synchronized weapons consume only one Flurry charge and increase Windfury proc chances.
---
--- RECOMMENDED SYNC MACRO:
--- /startattack
--- /nagattack
---
--- /nagattack fires DoEmote("SIT") when MH is not ahead (OH leads past 50%%), enabling stagger in one press.
---
--- ALTERNATIVE (MORE RELIABLE, NO TARGET SWAP):
--- /stopattack
--- /startattack
--- /nagattack
---
--- WHEN TO PRESS THE MACRO:
--- With equal weapon speeds (e.g. 2.7 / 2.7), you sync by resetting BOTH swing timers at the same moment.
--- The least-waste timing is: press the macro IMMEDIATELY AFTER the *later* of the two swings.
--- On the bar, this is when one hand just reset to ~0% progress and the other hand is also still very low.
--- If you press mid-swing (progress is high), you throw away a lot of swing time and can lose DPS.
--- Optimal synchronization usually means the next MH/OH swings land within ~0.1–0.2s (configurable threshold).
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitCanAttack = _G.UnitCanAttack
local InCombatLockdown = _G.InCombatLockdown
local UnitExists = _G.UnitExists
local UnitLevel = _G.UnitLevel
local CreateFrame = _G.CreateFrame
local DoEmote = _G.DoEmote
local C_Timer = _G.C_Timer
local GetMacroInfo = _G.GetMacroInfo
local EditMacro = _G.EditMacro
local hooksecurefunc = _G.hooksecurefunc
local math = math
local max = math.max
local min = math.min
local abs = math.abs

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
--- @type StateManager
--- @type DataManager
local StateManager, DataManager

--- @type DisplayManager
--- @type OptionsFactory
--- @type TimerManager
local DisplayManager, OptionsFactory, TimerManager

--- @type SpecCompat
local SpecCompat

local L = LibStub("AceLocale-3.0"):GetLocale("NAG")

-- Initialize swing timer library.
-- LibClassicSwingTimerAPI uses UnitAttackSpeed (haste-included) and UNIT_ATTACK_SPEED to keep
-- MH/OH speeds and swing timers correct when haste effects (buffs, temporary effects) change.
local swingTimerLib = LibStub("LibClassicSwingTimerAPI")

-- Constants
local SYNC_THRESHOLD = 0.35       -- Default "synced" threshold (seconds): weapons are synced when within 0.35s
local UPDATE_INTERVAL = 0.016    -- Approximately 60 FPS for smooth updates
local MIN_LEVEL_FOR_DUAL_WIELD = 10 -- Minimum level for dual-wield (Shaman gets it at level 10)
local DIFF_BAR_MAX_SECONDS = 1.0 -- Clamp sync-diff bar at 1s for readability
local SIT_STOP_DELAY = 0.20      -- You reported SIT takes ~0.2s before the toon actually stops auto-attacking
local SIT_SPLIT_PAD = 0.10       -- Safety pad for split logic ("- 0.1s")
local SIT_REPLAN_COOLDOWN = 0.75  -- Minimum seconds between SIT plan attempts (prevents thrash)
local ORDER_FIX_WINDOW_PROGRESS = 0.02 -- Small window around mid for order-only corrections (allows fixing OH-first even when close)
local TARGET_REACHED_WINDOW_PROGRESS = 0.01 -- Small window for "MH reached target" (prevents early cancellation like MH p=0.38)
local CLOSE_DIFF_FAST_RETRY_SECONDS = 0.08 -- When we're already very close but still OH-first, retry faster
local CLOSE_DIFF_FAST_RETRY_THRESHOLD = 0.15 -- Expand fast-retry region for more aggressive correction
local SIT_PREPLAN_MAX_DELAY = 0.30 -- Do not schedule pre-plan farther out than this
local ATTACK_SPAM_RECENCY_WINDOW = 0.30 -- Baseline recency window for /nagattack spam
local ATTACK_SPAM_FIRE_GRACE_WINDOW = 0.45 -- Looser recency at SIT fire to absorb timer/frame jitter
local ATTACK_SPAM_MIN_PRESSES = 3 -- Baseline minimum /nagattack presses per second
local MIN_SIT_ACTION_SPACING_SECONDS = 0.25 -- Minimum spacing between SIT actions in the same planning window
local MAX_SIT_FOLLOWUPS_PER_PLAN = 8 -- Allow multiple SITs in one swing window when correction needs are large
local MIN_EFFECTIVE_SIT_DELAY_SECONDS = 0.10 -- Do not schedule micro followups below this delay
local POST_SIT_SETTLE_WINDOW_SECONDS = 0.55 -- Short lockout after a SIT to avoid replan thrash
local SIT_LIVE_INTERVAL = 0.10 -- Fire SIT every 100ms when holding OH (live mode, no scheduling)
local MAX_DESIRED_MH_STAGGER_SECONDS = 0.49 -- MH ahead by more than this is considered over-staggered and needs correction
local PERFECT_SYNC_TIE_HYSTERESIS_SECONDS = 0.10 -- Require short persistence before tie-perfect correction to avoid thrash
local SIT_OH_SECOND_HALF_MIN_PROGRESS = 0.50 -- SIT is only effective when OH is in the second half of its swing
local SIT_SPAM_INTERVAL = 0.10 -- Seconds between SIT emotes when holding OH (live mode)
local HASTE_CHANGE_SIT_LOCKOUT_SECONDS = 0.4 -- Don't fire SIT right after haste/speed change; let swing timers settle
local BAR_TEXT_SCALE = 0.65 -- Reduce bar label/value font size by 35%
local WEAPON_SYNC_GATE_TTL_SECONDS = 5 -- Seconds of rotation inactivity before weapon sync auto-disables

-- ============================ ON-DEMAND GATE (ROTATION-DRIVEN) ============================

local function getWeaponSyncGate()
    if ns.tbcEnhancementWeaponSyncGateEnabled == nil then
        ns.tbcEnhancementWeaponSyncGateEnabled = false
    end
    return ns.tbcEnhancementWeaponSyncGateEnabled
end

local function getWeaponSyncGateLastEnable()
    if ns.tbcEnhancementWeaponSyncGateLastEnable == nil then
        ns.tbcEnhancementWeaponSyncGateLastEnable = 0
    end
    return ns.tbcEnhancementWeaponSyncGateLastEnable
end

local function isWeaponSyncGateExpired(now)
    local lastEnable = getWeaponSyncGateLastEnable()
    if lastEnable <= 0 then
        return true
    end
    return (now - lastEnable) > WEAPON_SYNC_GATE_TTL_SECONDS
end

--- Returns true when the TBC Enhancement weapon sync (bars + auto stagger) is gated on by a rotation call.
--- @return boolean
function NAG:IsTBCEnhancementWeaponSyncEnabled()
    if not getWeaponSyncGate() then
        return false
    end
    local now = GetTime()
    if isWeaponSyncGateExpired(now) then
        ns.tbcEnhancementWeaponSyncGateEnabled = false
        return false
    end
    return true
end

--- Enable the TBC Enhancement weapon sync gate (bars + auto stagger). Called from rotation when active.
--- @return boolean Always false so it never short-circuits rotation strings
function NAG:EnableTBCEnhancementWeaponSync()
    local now = GetTime()
    local wasEnabled = getWeaponSyncGate()
    ns.tbcEnhancementWeaponSyncGateEnabled = true
    ns.tbcEnhancementWeaponSyncGateLastEnable = now

    local mod = NAG:GetModule("TBCEnhancementShamanWeaponSync", true)
    if mod and mod.UpdateVisibility and not wasEnabled then
        mod:UpdateVisibility()
    end

    local TimerManager = ns.TimerManager or (NAG and NAG.GetModule and NAG:GetModule("TimerManager", true))
    if TimerManager and TimerManager.Create then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "tbcEnhancementWeaponSyncGateExpire")
        TimerManager:Create(
            TimerManager.Categories.UI_NOTIFICATION,
            "tbcEnhancementWeaponSyncGateExpire",
            function()
                local expiredNow = GetTime()
                if isWeaponSyncGateExpired(expiredNow) then
                    ns.tbcEnhancementWeaponSyncGateEnabled = false
                    if mod and mod.UpdateVisibility then
                        mod:UpdateVisibility()
                    end
                end
            end,
            WEAPON_SYNC_GATE_TTL_SECONDS,
            false
        )
    end
    return false
end

-- ============================ SYNC MATH HELPERS ============================
--- Compute the "phase" difference between MH and OH swings.
--- For equal-speed weapons, the swing cycle is circular: a hit that just happened (ttn ~ speed)
--- and a hit that is about to happen (ttn ~ 0) are actually very close, not "speed apart".
--- This prevents false "huge desync" spikes in the brief window between MH and OH hits.
--- @param mhTimeToNext number
--- @param ohTimeToNext number
--- @param mhSpeed number
--- @param ohSpeed number
--- @return number
local function computeSyncPhaseDifference(mhTimeToNext, ohTimeToNext, mhSpeed, ohSpeed)
    local raw = abs(mhTimeToNext - ohTimeToNext)
    if not mhSpeed or not ohSpeed or mhSpeed <= 0 or ohSpeed <= 0 then
        return raw
    end

    -- Use normalized phase (remaining fraction of swing) so we still handle wrap-boundary cases
    -- even if mhSpeed/ohSpeed differ slightly (which can happen due to timer data quirks).
    local mhPhaseRemaining = mhTimeToNext / mhSpeed
    local ohPhaseRemaining = ohTimeToNext / ohSpeed

    -- Clamp defensively into [0, 1]
    if mhPhaseRemaining < 0 then mhPhaseRemaining = 0 end
    if mhPhaseRemaining > 1 then mhPhaseRemaining = 1 end
    if ohPhaseRemaining < 0 then ohPhaseRemaining = 0 end
    if ohPhaseRemaining > 1 then ohPhaseRemaining = 1 end

    local phaseRaw = abs(mhPhaseRemaining - ohPhaseRemaining)
    if phaseRaw > 1 then
        phaseRaw = 1
    end
    local phaseWrapped = 1 - phaseRaw
    local phaseDiff = min(phaseRaw, phaseWrapped)

    local cycle = (mhSpeed + ohSpeed) / 2
    if cycle <= 0 then
        return raw
    end
    return phaseDiff * cycle
end

--- Determine which hand "leads" when using circular sync math.
--- For wrap-boundary cases (where wrapped distance is used), the weapon with the *larger* time-to-next
--- is the one that just reset (already swung) and therefore led the pairing.
--- @param mhTimeToNext number
--- @param ohTimeToNext number
--- @param mhSpeed number
--- @param ohSpeed number
--- @return string  "MH"|"OH"|"TIE"
local function computeSyncedLeaderHand(mhTimeToNext, ohTimeToNext, mhSpeed, ohSpeed)
    if not mhSpeed or not ohSpeed or mhSpeed <= 0 or ohSpeed <= 0 then
        if mhTimeToNext < ohTimeToNext then return "MH" end
        if ohTimeToNext < mhTimeToNext then return "OH" end
        return "TIE"
    end

    -- Determine wrap-boundary using phase (speed-mismatch tolerant).
    local mhPhaseRemaining = mhTimeToNext / mhSpeed
    local ohPhaseRemaining = ohTimeToNext / ohSpeed

    if mhPhaseRemaining < 0 then mhPhaseRemaining = 0 end
    if mhPhaseRemaining > 1 then mhPhaseRemaining = 1 end
    if ohPhaseRemaining < 0 then ohPhaseRemaining = 0 end
    if ohPhaseRemaining > 1 then ohPhaseRemaining = 1 end

    local phaseRaw = abs(mhPhaseRemaining - ohPhaseRemaining)
    if phaseRaw > 1 then
        phaseRaw = 1
    end

    -- If the direct phase distance is > 0.5, the shorter path wraps around the boundary.
    if phaseRaw > 0.5 then
        -- Wrap-boundary: the hand with higher phase remaining is the one that just reset (already swung) => it led.
        if mhPhaseRemaining > ohPhaseRemaining then return "MH" end
        if ohPhaseRemaining > mhPhaseRemaining then return "OH" end
        return "TIE"
    end

    -- Normal case: whichever will swing next (smaller ttn) "leads".
    if mhTimeToNext < ohTimeToNext then return "MH" end
    if ohTimeToNext < mhTimeToNext then return "OH" end
    return "TIE"
end

-- ============================ UI HELPERS ============================
--- Create a simple status bar with an optional label/value text.
--- @param parent Frame
--- @param name string
--- @param r number
--- @param g number
--- @param b number
--- @param a number
--- @return Frame
local function createStatusBar(parent, name, r, g, b, a)
    local bar = CreateFrame("StatusBar", name, parent)
    bar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)
    bar:SetStatusBarColor(r, g, b, a)

    local bg = bar:CreateTexture(nil, "BACKGROUND", nil, -7)
    bg:SetAllPoints()
    bg:SetColorTexture(0, 0, 0, 0.35)
    bar.bg = bg

    local label = bar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", bar, "LEFT", 6, 0)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("MIDDLE")
    bar.label = label

    local valueText = bar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    valueText:SetPoint("RIGHT", bar, "RIGHT", -6, 0)
    valueText:SetJustifyH("RIGHT")
    valueText:SetJustifyV("MIDDLE")
    bar.valueText = valueText

    return bar
end

-- Default settings
local defaults = {
    class = {
        enabled = true,
        -- UI visibility is now controlled ONLY by debugEnabled (per request).
        -- The module logic continues running regardless of this setting.
        debugEnabled = false, -- Default off: keep sync logic running, hide bars until toggled
        -- Legacy UI settings kept for backward compat (no longer user-facing / no longer gate logic):
        showBar = true,
        hideOutOfCombat = false,
        showOnlyWhenDesynced = false,
        debugAutoStopAttack = true, -- Default ON: Auto SIT assist (spams DoEmote("SIT") in the desync window to help re-sync)
        debugPrintSwingState = true, -- Print swing state periodically (throttled) while module is visible
        debugPrintSyncSteps = false, -- Print sync step messages (throttled) to chat
        debugPrintSitSchedule = true, -- Print SIT scheduling decisions (why plan started/not started, SIT fired/skipped)
        debugPrintThrottle = 0.75, -- seconds between prints to avoid chat spam
        debugWindowProgress = 0.12, -- Wider window around 0.5 (more practical with real desync)
        orderFixWindowProgress = ORDER_FIX_WINDOW_PROGRESS, -- Narrower window to trigger order-correction plans when already close
        sitReplanCooldown = SIT_REPLAN_COOLDOWN, -- Cooldown between plan attempts
        targetReachedWindowProgress = TARGET_REACHED_WINDOW_PROGRESS, -- Separate tolerance for "MH reached target" (do NOT reuse entry window)
        attackSpamRecencyWindow = ATTACK_SPAM_RECENCY_WINDOW, -- "Current spam" recency window (seconds)
        attackSpamFireGraceWindow = ATTACK_SPAM_FIRE_GRACE_WINDOW, -- Fire-time grace window (seconds)
        attackSpamMinPresses = ATTACK_SPAM_MIN_PRESSES, -- Minimum presses in 1s for spam detection
        minEffectiveSitDelay = MIN_EFFECTIVE_SIT_DELAY_SECONDS, -- Minimum delay for scheduled SIT follow-ups
        postSitSettleWindow = POST_SIT_SETTLE_WINDOW_SECONDS, -- Block new plans briefly after a SIT fire
        autoSitInterval = 0.10, -- Legacy (no longer used): was used for SIT spam; kept for backward compat in DB
        sitStopDelay = SIT_STOP_DELAY, -- Estimated delay between SIT and auto-attack actually stopping (seconds)
        sitSplitPad = SIT_SPLIT_PAD, -- Safety pad for split logic ("- 0.1s")
        -- Live mode: SIT fires every sitSpamInterval when OH past mid + need correction (no scheduling).
        sitSpamInterval = SIT_SPAM_INTERVAL, -- Seconds between SIT emotes in spam mode
        bar = {
            width = 300,
            height = 40,
            alpha = 1.0,
            point = "CENTER",
            x = 0,
            y = -150,
            showBorder = true,
            borderColor = { r = 1, g = 1, b = 1, a = 1 },
            borderThickness = 2,
            -- Bar colors
            colors = {
                background = { r = 0.1, g = 0.1, b = 0.1, a = 0.8 },
                synchronized = { r = 0.2, g = 0.8, b = 0.2, a = 0.9 },      -- Green when synced
                desynchronized = { r = 0.8, g = 0.2, b = 0.2, a = 0.9 },      -- Red when out of sync
                mainhand = { r = 0.4, g = 0.6, b = 1.0, a = 0.8 },            -- Blue for main-hand
                offhand = { r = 1.0, g = 0.6, b = 0.4, a = 0.8 },             -- Orange for off-hand
                syncWindow = { r = 1.0, g = 1.0, b = 0.2, a = 0.7 },          -- Yellow for sync window
            },
        },
        -- "Synced" definition (per user drill): weapons are considered synced when within 0.35s of each other.
        syncThreshold = SYNC_THRESHOLD,      -- seconds
        -- If MH hits harder than OH, you typically want MH to land first (or at the same time) when synced.
        -- If false: either order is acceptable as long as within syncThreshold.
        mhMustLeadWhenSynced = true,
        -- Optional: if enforcing MH-leading, you can bias the plan to make MH land slightly earlier than OH.
        -- 0.00 = allow perfect tie; small values (e.g. 0.03–0.08) encourage MH-first.
        mhLeadTimeSeconds = 0.05,
        macroTimingWindow = 0.25, -- Window (seconds): only suggest pressing right after the later swing, when the other swing was also recent
        showSyncWindow = true,    -- Show optimal sync window indicator
        showText = true,          -- Show text countdown
        textSize = 16,
        textColor = { r = 1, g = 1, b = 1, a = 1 },
    }
}

-- Local state
local frame = nil
local isDragging = false
local lastUpdate = 0

--- @class TBCEnhancementShamanWeaponSync:CoreModule
local TBCEnhancementShamanWeaponSync = NAG:CreateModule("TBCEnhancementShamanWeaponSync", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "SHAMAN",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.CLASS,
        ns.DEBUG_CATEGORIES.UI
    },
    -- ZERO-BOILERPLATE: Declarative event and message handlers
    eventHandlers = {
        PLAYER_REGEN_DISABLED = true,  -- Combat start
        PLAYER_REGEN_ENABLED = true,   -- Combat end
        UPDATE_MACROS = true,          -- Macro edits/changes
    },
    messageHandlers = {
        NAG_SPEC_UPDATED = "OnSpecUpdated",
        NAG_FRAME_UPDATED = true,
        NAG_SHAMAN_BAR_SCALE_UPDATED = true,
    },
    cleuHandlers = {
        SWING_DAMAGE = "HandleCLEUSwingDamage",
    },
    -- Slash commands (user-facing): quickly show/hide the debug bars without hunting through options.
    slashCommands = {
        ["weaponsync"] = {
            handler = "HandleWeaponSyncSlashCommand",
            help = "Toggle the Enhancement Weapon Sync debug bars. Usage: /nag weaponsync [show|hide|toggle]",
            root = "nag",
            path = { "weaponsync" },
            category = "Class"
        }
    },
    defaultState = {
        frame = nil,
        isDragging = false
    }
})
-- Add module to namespace
ns.TBCEnhancementShamanWeaponSync = TBCEnhancementShamanWeaponSync
local module = TBCEnhancementShamanWeaponSync

function TBCEnhancementShamanWeaponSync:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    StateManager = NAG:GetModule("StateManager")
    DataManager = NAG:GetModule("DataManager")
    DisplayManager = NAG:GetModule("DisplayManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    TimerManager = NAG:GetModule("TimerManager")
    SpecCompat = NAG:GetModule("SpecCompat")

    -- Check game version - only works in TBC
    local Version = ns.Version
    if not Version:IsTBC() then
        self:Debug("TBCEnhancementShamanWeaponSync only works in TBC - current version not supported")
        self:SetEnabledState(false)
        return
    end

    -- Check if player is a Shaman
    local playerClass = NAG.CLASS_FILENAME
    if playerClass ~= "SHAMAN" then
        self:Debug("Not a Shaman, skipping initialization")
        self:SetEnabledState(false)
        return
    end

    -- Check if player is high enough level for dual-wield
    local playerLevel = UnitLevel("player")
    if playerLevel < MIN_LEVEL_FOR_DUAL_WIELD then
        self:Debug("Player level too low for dual-wield, skipping initialization")
        self:SetEnabledState(false)
        return
    end

    -- Register for swing timer events
    if swingTimerLib then
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_START", function(_, unitId, speed, expirationTime, hand)
            if unitId == "player" then
                self.forceInstantUpdate = true
                self:UpdateDisplay()
                self.forceInstantUpdate = false
            end
        end)
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_UPDATE", function(_, unitId, speed, expirationTime, hand)
            if unitId == "player" then
                self.forceInstantUpdate = true
                self:UpdateDisplay()
                self.forceInstantUpdate = false
            end
        end)
    end
end

-- ============================ MACRO AUTO-PATCH (TBC ENH SHAMAN ONLY) ============================

--- Attempt to append `/nagattack` into any macro body that contains `/startattack`.
--- Runs once per session, only for TBC Enhancement Shaman, and never duplicates an existing `/nagattack`.
--- If a macro would exceed 255 chars, it is skipped and a warning is printed.
--- @param forceRescan boolean|nil Allow re-scan on macro changes
function TBCEnhancementShamanWeaponSync:TryAutoPatchStartAttackMacros(forceRescan)
    if self._macroNagattackPatched and not forceRescan then
        return
    end

    local now = GetTime()
    local throttleSeconds = 0.50
    if forceRescan and self._macroNagattackLastScan and (now - self._macroNagattackLastScan) < throttleSeconds then
        return
    end
    self._macroNagattackLastScan = now

    local Version = ns.Version
    if not (Version and Version.IsTBC and Version:IsTBC()) then
        if not forceRescan then
            self._macroNagattackPatched = true
        end
        return
    end

    if NAG.CLASS_FILENAME ~= "SHAMAN" then
        if not forceRescan then
            self._macroNagattackPatched = true
        end
        return
    end

    if SpecCompat then
        local specStatus = SpecCompat:GetSpecializationStatus()
        if specStatus and specStatus.available and specStatus.specIndex and specStatus.specIndex ~= 2 then
            -- Enhancement-only: if spec is known and not Enhancement, do not patch.
            return
        end
        -- If spec is unknown/unavailable, allow patch (matches isTBCEnhancementShaman behavior).
    end

    local inCombat = (InCombatLockdown and InCombatLockdown()) or UnitAffectingCombat("player")
    if inCombat then
        if not self._macroNagattackCombatWarned then
            self._macroNagattackCombatWarned = true
            self:Debug("Macro auto-patch skipped (in combat). Waiting for combat end to auto-inject /nagattack.")
        end
        self._macroNagattackPendingAfterCombat = true
        return
    end

    if not GetMacroInfo or not EditMacro then
        self:Debug("Macro APIs unavailable; cannot auto-inject /nagattack.")
        if not forceRescan then
            self._macroNagattackPatched = true
        end
        return
    end

    local patched = 0
    local skippedAlready = 0
    local skippedTooLong = 0
    local scannedWithStart = 0
    local skippedTooLongNames = nil

    for id = 1, 120 do
        local name, icon, body = GetMacroInfo(id)
        if name and body then
            local lowerBody = string.lower(body)
            if string.find(lowerBody, "/startattack", 1, true) then
                scannedWithStart = scannedWithStart + 1
                if string.find(lowerBody, "/nagattack", 1, true) then
                    skippedAlready = skippedAlready + 1
                else
                    local newBody = body .. "\n/nagattack"
                    if string.len(newBody) > 255 then
                        skippedTooLong = skippedTooLong + 1
                        self:Debug("Macro too long, skipped /nagattack injection: id=%d name=%s len=%d",
                            id, tostring(name), string.len(newBody))
                        -- Collect a few names for a user-facing warning (debug-only logs are often disabled).
                        if not skippedTooLongNames then
                            skippedTooLongNames = {}
                        end
                        if #skippedTooLongNames < 5 then
                            skippedTooLongNames[#skippedTooLongNames + 1] = tostring(name)
                        end
                    else
                        EditMacro(id, name, icon, newBody)
                        patched = patched + 1
                    end
                end
            end
        end
    end

    self._macroNagattackPendingAfterCombat = false
    if not forceRescan then
        self._macroNagattackPatched = true
    end
    self:Debug("Macro auto-patch done: patched=%d scannedWithStart=%d skippedAlready=%d skippedTooLong=%d",
        patched, scannedWithStart, skippedAlready, skippedTooLong)

    -- User-facing warning: macro injection can fail silently if debug is off.
    if skippedTooLong > 0 and (patched > 0 or scannedWithStart > 0) then
        -- Throttle the warning to avoid chat spam if UPDATE_MACROS fires repeatedly.
        local now2 = GetTime()
        local warnThrottle = 8.0
        if not self._macroNagattackTooLongWarnAt or (now2 - self._macroNagattackTooLongWarnAt) >= warnThrottle then
            self._macroNagattackTooLongWarnAt = now2
            local suffix = ""
            if skippedTooLongNames and #skippedTooLongNames > 0 then
                suffix = string.format(" (e.g. %s)", table.concat(skippedTooLongNames, ", "))
            end
            self:Print(string.format(
                "WeaponSync: %d macro(s) with /startattack are too long to auto-add /nagattack (255 char limit)%s. Please add /nagattack manually.",
                skippedTooLong,
                suffix
            ))
        end
    end
end

-- ============================ SLASH COMMANDS ============================

--- /nag weaponsync [show|hide|toggle]
--- @param input string|nil
function TBCEnhancementShamanWeaponSync:HandleWeaponSyncSlashCommand(input)
    if not (self.db and self.db.class) then
        self:Print("WeaponSync: database not ready yet.")
        return
    end

    local cmd = (input and input ~= "") and string.lower(tostring(input)) or "toggle"
    cmd = string.gsub(cmd, "^%s+", "")
    cmd = string.gsub(cmd, "%s+$", "")

    local newValue
    if cmd == "show" or cmd == "on" or cmd == "1" then
        newValue = true
    elseif cmd == "hide" or cmd == "off" or cmd == "0" then
        newValue = false
    elseif cmd == "toggle" or cmd == "" then
        newValue = not (self.db.class.debugEnabled and true or false)
    else
        self:Print("WeaponSync: usage: /nag weaponsync [show|hide|toggle]")
        return
    end

    self.db.class.debugEnabled = newValue
    self:UpdateVisibility()
    self:Print(string.format("WeaponSync bars: %s", newValue and "shown" or "hidden"))
end

function TBCEnhancementShamanWeaponSync:OnSpecUpdated(message)
    self:TryAutoPatchStartAttackMacros(true)
end

function TBCEnhancementShamanWeaponSync:UPDATE_MACROS()
    self:TryAutoPatchStartAttackMacros(true)
end

--- Hook macro API calls to detect edits from macro manager addons.
--- This complements UPDATE_MACROS, which is not always reliable across all macro addons.
function TBCEnhancementShamanWeaponSync:HookMacroApis()
    if self._macroApisHooked then
        return
    end
    self._macroApisHooked = true

    if not hooksecurefunc then
        return
    end

    local function onMacroEdited()
        -- If we can't modify macros right now (combat lockdown), queue for combat end.
        local inCombat = (InCombatLockdown and InCombatLockdown()) or UnitAffectingCombat("player")
        if inCombat then
            self._macroNagattackPendingAfterCombat = true
            return
        end
        self:TryAutoPatchStartAttackMacros(true)
    end

    -- Most macro UIs/addons go through these APIs.
    if EditMacro then
        hooksecurefunc("EditMacro", onMacroEdited)
    end
    if _G.CreateMacro then
        hooksecurefunc("CreateMacro", onMacroEdited)
    end
    if _G.DeleteMacro then
        hooksecurefunc("DeleteMacro", onMacroEdited)
    end
end

--- Debug helper: returns current swing info snapshot.
--- @return table
function TBCEnhancementShamanWeaponSync:GetSwingDebugSnapshot()
    if not swingTimerLib then
        return { ok = false, reason = "no swingTimerLib" }
    end

    local now = GetTime()
    local mhSpeed, mhExpiration = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    local ohSpeed, ohExpiration = swingTimerLib:UnitSwingTimerInfo("player", "offhand")

    if not mhSpeed or not mhExpiration or not ohSpeed or not ohExpiration or ohSpeed == 0 then
        return { ok = false, reason = "missing swing info", now = now, mhSpeed = mhSpeed, ohSpeed = ohSpeed }
    end

    local mhTimeToNext = max(0, mhExpiration - now)
    local ohTimeToNext = max(0, ohExpiration - now)
    local mhProgress = min(1.0, 1.0 - (mhTimeToNext / mhSpeed))
    local ohProgress = min(1.0, 1.0 - (ohTimeToNext / ohSpeed))

    return {
        ok = true,
        now = now,
        mhSpeed = mhSpeed,
        ohSpeed = ohSpeed,
        mhTimeToNext = mhTimeToNext,
        ohTimeToNext = ohTimeToNext,
        mhProgress = mhProgress,
        ohProgress = ohProgress,
        syncDifference = computeSyncPhaseDifference(mhTimeToNext, ohTimeToNext, mhSpeed, ohSpeed),
    }
end

-- ============================ CLEU: MH/OH DAMAGE LOGGING ============================
--- Log MH vs OH swing damage to help decide whether MH should lead when synced.
--- @param timestamp number
--- @param subEvent string
--- @param hideCaster boolean
--- @param sourceGUID string
--- @param sourceName string|nil
--- @param sourceFlags number|nil
--- @param sourceRaidFlags number|nil
--- @param destGUID string|nil
--- @param destName string|nil
--- @param destFlags number|nil
--- @param destRaidFlags number|nil
--- @param amount number
--- @param overkill number|nil
--- @param school number|nil
--- @param resisted number|nil
--- @param blocked number|nil
--- @param absorbed number|nil
--- @param critical boolean|nil
--- @param glancing boolean|nil
--- @param crushing boolean|nil
--- @param isOffHand boolean|nil
function TBCEnhancementShamanWeaponSync:HandleCLEUSwingDamage(timestamp, subEvent, hideCaster,
    sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
    destGUID, destName, destFlags, destRaidFlags,
    amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand)

    local playerGUID = NAG and NAG.state and NAG.state.player and NAG.state.player.guid
    if not playerGUID or sourceGUID ~= playerGUID then
        return
    end

    -- Defensive: amount can be nil for some malformed logs; ignore.
    if not amount then
        return
    end

    local now = GetTime()
    local isOH = isOffHand and true or false

    -- IMPORTANT: combat log swing amounts are affected by armor, crits, glancing, procs, buffs, etc.
    -- They are NOT a clean proxy for base weapon damage. For deciding MH-vs-OH priority, we print
    -- the base weapon damage estimate from NAG:WeaponDamage("mainhand"/"offhand").
    local mhBaseWeaponDamage = (NAG and NAG.WeaponDamage) and (NAG:WeaponDamage("mainhand") or 0) or 0
    local ohBaseWeaponDamage = (NAG and NAG.WeaponDamage) and (NAG:WeaponDamage("offhand") or 0) or 0

    self:Debug("SWING_%s_HIT @ %.3f amount=%d crit=%s | baseWD: MH=%.1f OH=%.1f | target=%s",
        isOH and "OH" or "MH",
        now,
        amount,
        tostring(critical and true or false),
        mhBaseWeaponDamage,
        ohBaseWeaponDamage,
        tostring(destName or "unknown"))
end

--- Debug helper: can be called from a macro via /run to log current swing state.
function TBCEnhancementShamanWeaponSync:DebugLogSwingState(tag)
    if not self:ShouldEmitDebugOutput() then return end
    self._debugState = self._debugState or {}

    local throttle = self.db.class.debugPrintThrottle or 0.75
    local now = GetTime()
    if self._debugState.lastPrintAt and (now - self._debugState.lastPrintAt) < throttle then
        return
    end
    self._debugState.lastPrintAt = now

    local s = self:GetSwingDebugSnapshot()
    if not s.ok then
        self:Debug("%s @ %.3f - no swing info (%s)", tostring(tag or "state"), now, tostring(s.reason))
        return
    end

    self:Debug("%s @ %.3f | MH ttn=%.3f p=%.3f | OH ttn=%.3f p=%.3f | diff=%.3f",
        tostring(tag or "state"),
        s.now,
        s.mhTimeToNext, s.mhProgress,
        s.ohTimeToNext, s.ohProgress,
        s.syncDifference
    )
end

--- True when verbose WeaponSync chat/debug output should be emitted.
--- Gated behind the debug bar visibility toggle.
--- @return boolean
function TBCEnhancementShamanWeaponSync:ShouldEmitDebugOutput()
    return self.db and self.db.class and self.db.class.debugEnabled == true
end

--- Print a sync step message (throttled).
--- @param key string
--- @param message string
--- @param throttleSeconds number|nil
function TBCEnhancementShamanWeaponSync:MaybePrintSyncStep(key, message, throttleSeconds)
    return -- prints disabled
    --[[
    if not self:ShouldEmitDebugOutput() then
        return
    end
    self._debugState = self._debugState or {}
    local st = self._debugState
    st.syncStepPrints = st.syncStepPrints or {}

    local now = GetTime()
    local throttle = throttleSeconds or self.db.class.debugPrintThrottle or 0.75
    local entry = st.syncStepPrints[key]
    if entry and entry.lastAt and (now - entry.lastAt) < throttle then
        return
    end

    st.syncStepPrints[key] = {
        lastAt = now,
        lastMessage = message
    }

    self:Print(message)
    ]]
end

--- Print high-fidelity SIT trace logs (gated by debug bar setting).
--- @param message string
function TBCEnhancementShamanWeaponSync:PrintSitTrace(message)
    return -- prints disabled
    --[[
    if not self:ShouldEmitDebugOutput() then
        return
    end
    self:Print(string.format("WeaponSync TRACE @ %.3f | %s", GetTime(), tostring(message)))
    ]]
end

--- Print SIT scheduling decisions (gated by debugPrintSitSchedule). Use for diagnosing "no SITs" or "too many SITs".
--- @param key string Throttle key (same key = same throttle window)
--- @param message string
--- @param force boolean|nil If true, skip throttle
function TBCEnhancementShamanWeaponSync:PrintSitSchedule(key, message, force)
    return -- prints disabled
    --[[
    if not (self.db and self.db.class and self.db.class.debugPrintSitSchedule) then
        return
    end
    self._debugState = self._debugState or {}
    local st = self._debugState
    st.sitSchedulePrints = st.sitSchedulePrints or {}
    local throttle = self.db.class.debugPrintThrottle or 0.75
    local entry = st.sitSchedulePrints[key]
    local now = GetTime()
    if not force and entry and entry.lastAt and (now - entry.lastAt) < throttle then
        return
    end
    st.sitSchedulePrints[key] = { lastAt = now }
    self:Print(string.format("|cff00aaffWeaponSync SIT|r @ %.2f | %s", now, tostring(message)))
    ]]
end

function TBCEnhancementShamanWeaponSync:ModuleEnable()
    -- Double check all conditions before enabling

    -- Check game version - only works in TBC
    local Version = ns.Version
    if not Version:IsTBC() then
        self:Debug("TBCEnhancementShamanWeaponSync only works in TBC - current version not supported")
        self:SetEnabledState(false)
        return
    end

    -- ============================ MODULE INITIALIZATION ============================
    local playerClass = NAG.CLASS_FILENAME
    if playerClass ~= "SHAMAN" then
        self:Debug("Not a Shaman, skipping enable")
        self:SetEnabledState(false)
        return
    end

    -- One-time macro patch: auto-inject /nagattack into any /startattack macro (Enhancement-only).
    self:TryAutoPatchStartAttackMacros()
    self:HookMacroApis()

    -- Delayed rescan: some clients/macro addons update macro bodies shortly after login.
    if C_Timer and C_Timer.After then
        C_Timer.After(2.0, function()
            -- Re-check enabled state defensively.
            if self:IsEnabled() then
                self:TryAutoPatchStartAttackMacros(true)
            end
        end)
    end

    -- Create or show the frame
    if not frame then
        self:CreateFrames()
    end

    -- Start update loop
    if frame then
        frame:SetScript("OnUpdate", function(frameSelf, elapsed)
            lastUpdate = lastUpdate + elapsed
            if lastUpdate >= UPDATE_INTERVAL then
                TBCEnhancementShamanWeaponSync:UpdateDisplay()
                lastUpdate = 0
            end
        end)
        self:UpdateFrameSettings()
        -- Update visibility after settings so we can override alpha/mouse for debug gating
        self:UpdateVisibility()
    end
end

function TBCEnhancementShamanWeaponSync:ModuleDisable()
    self:Debug("Disabling TBCEnhancementShamanWeaponSync")
    self:CancelSitPrePlan("module_disabled")
    self:CancelSitPlan("module_disabled", GetTime(), -1, -1)

    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end

    -- ZERO-BOILERPLATE: Events are automatically unregistered via declarative patterns
end

function TBCEnhancementShamanWeaponSync:CreateFrames()
    -- Create main frame
    frame = CreateFrame("Frame", "NAGTBCShamanWeaponSync", UIParent)
    frame:SetSize(self.db.class.bar.width, self.db.class.bar.height)
    frame:SetPoint(self.db.class.bar.point, self.db.class.bar.x, self.db.class.bar.y)

    -- Create background
    local bgTexture = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    bgTexture:SetAllPoints()
    bgTexture:SetColorTexture(
        self.db.class.bar.colors.background.r,
        self.db.class.bar.colors.background.g,
        self.db.class.bar.colors.background.b,
        self.db.class.bar.colors.background.a
    )
    frame.bgTexture = bgTexture

    -- Create stacked bars (no overlap)
    frame.bars = frame.bars or {}

    local colors = (self.db.class.bar and self.db.class.bar.colors) or {}
    local mhColor = colors.mainhand or { r = 0.4, g = 0.6, b = 1.0, a = 0.8 }
    local ohColor = colors.offhand or { r = 1.0, g = 0.6, b = 0.4, a = 0.8 }
    frame.bars.mh = createStatusBar(frame, "NAGTBCShamanWeaponSync_MH", mhColor.r, mhColor.g, mhColor.b, mhColor.a)
    frame.bars.mh.label:SetText("MH swing")

    frame.bars.oh = createStatusBar(frame, "NAGTBCShamanWeaponSync_OH", ohColor.r, ohColor.g, ohColor.b, ohColor.a)
    frame.bars.oh.label:SetText("OH swing")

    local syncWindowColor = colors.syncWindow or { r = 1.0, g = 1.0, b = 0.2, a = 0.7 }
    frame.bars.countdown = createStatusBar(frame, "NAGTBCShamanWeaponSync_Countdown", syncWindowColor.r, syncWindowColor.g, syncWindowColor.b, 0.8)
    frame.bars.countdown.label:SetText("Macro")

    frame.bars.diff = createStatusBar(frame, "NAGTBCShamanWeaponSync_Diff", 1.0, 0.2, 0.2, 0.85)
    frame.bars.diff.label:SetText("Sync diff")

    -- Set up dragging
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())

    frame:SetScript("OnDragStart", function()
        local canDrag = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
        if canDrag and not UnitAffectingCombat("player") then
            frame:StartMoving()
            isDragging = true
        end
    end)

    frame:SetScript("OnDragStop", function()
        if isDragging then
            frame:StopMovingOrSizing()
            isDragging = false

            local left, bottom = frame:GetLeft(), frame:GetBottom()
            if left and bottom then
                frame:SetParent(UIParent)
                frame:ClearAllPoints()
                frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
            end
            local point, _, _, x, y = frame:GetPoint(1)
            self.db.class.bar.point = point
            self.db.class.bar.x = x
            self.db.class.bar.y = y
        end
    end)

    -- Apply initial settings
    self:UpdateFrameSettings()
end

function TBCEnhancementShamanWeaponSync:NAG_FRAME_UPDATED()
    self:UpdateFrameSettings()
    self:UpdateVisibility()
end

function TBCEnhancementShamanWeaponSync:NAG_SHAMAN_BAR_SCALE_UPDATED()
    self:UpdateFrameSettings()
end

function TBCEnhancementShamanWeaponSync:UpdateFrameSettings()
    if not frame then return end

    local settings = self.db.class.bar

    -- Update size
    frame:SetSize(settings.width, settings.height)

    -- Update position (parent to UIParent so coords are consistent after drag)
    frame:SetParent(UIParent)
    frame:ClearAllPoints()
    frame:SetPoint(settings.point, settings.x, settings.y)

    local sm = NAG:GetModule("ShamanWeaveModule", true)
    local barScale = (sm and sm.GetShamanBarScale and sm:GetShamanBarScale()) or 1
    frame:SetScale(barScale)

    -- Alpha/mouse state is controlled by UpdateVisibility().
    -- Do not force alpha here or hidden bars can briefly flash when this function runs.

    -- Update background color
    frame.bgTexture:SetColorTexture(
        settings.colors.background.r,
        settings.colors.background.g,
        settings.colors.background.b,
        settings.colors.background.a
    )

    -- Update stacked bar layout
    local barHeight = settings.height / 4
    local bars = frame.bars
    if bars and bars.mh and bars.oh and bars.countdown and bars.diff then
        bars.mh:ClearAllPoints()
        bars.mh:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
        bars.mh:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
        bars.mh:SetHeight(barHeight)

        bars.oh:ClearAllPoints()
        bars.oh:SetPoint("TOPLEFT", bars.mh, "BOTTOMLEFT", 0, 0)
        bars.oh:SetPoint("TOPRIGHT", bars.mh, "BOTTOMRIGHT", 0, 0)
        bars.oh:SetHeight(barHeight)

        bars.countdown:ClearAllPoints()
        bars.countdown:SetPoint("TOPLEFT", bars.oh, "BOTTOMLEFT", 0, 0)
        bars.countdown:SetPoint("TOPRIGHT", bars.oh, "BOTTOMRIGHT", 0, 0)
        bars.countdown:SetHeight(barHeight)

        bars.diff:ClearAllPoints()
        bars.diff:SetPoint("TOPLEFT", bars.countdown, "BOTTOMLEFT", 0, 0)
        bars.diff:SetPoint("TOPRIGHT", bars.countdown, "BOTTOMRIGHT", 0, 0)
        bars.diff:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
        bars.diff:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)

        local baseTextSize = settings.textSize or 16
        local textSize = math.floor(math.max(8, baseTextSize * BAR_TEXT_SCALE) + 0.5)
        local textColor = settings.textColor or { r = 1, g = 1, b = 1, a = 1 }
        local fontPath = "Fonts\\FRIZQT__.TTF"
        bars.mh.label:SetFont(fontPath, textSize, "OUTLINE")
        bars.mh.valueText:SetFont(fontPath, textSize, "OUTLINE")
        bars.oh.label:SetFont(fontPath, textSize, "OUTLINE")
        bars.oh.valueText:SetFont(fontPath, textSize, "OUTLINE")
        bars.countdown.label:SetFont(fontPath, textSize, "OUTLINE")
        bars.countdown.valueText:SetFont(fontPath, textSize, "OUTLINE")
        bars.diff.label:SetFont(fontPath, textSize, "OUTLINE")
        bars.diff.valueText:SetFont(fontPath, textSize, "OUTLINE")

        bars.mh.label:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
        bars.mh.valueText:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
        bars.oh.label:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
        bars.oh.valueText:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
        bars.countdown.label:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
        bars.countdown.valueText:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
        bars.diff.label:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
        bars.diff.valueText:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
    end
end

-- ============================ SIT LIVE (NO SCHEDULING) ============================
--- Cancel any pending SIT timers and clear plan state. (Legacy - used by ModuleDisable.)
--- @param reason string
--- @param now number
--- @param mhProgress number
--- @param ohProgress number
function TBCEnhancementShamanWeaponSync:CancelSitPlan(reason, now, mhProgress, ohProgress)
    self._debugState = self._debugState or {}
    local st = self._debugState

    if st.sitTimers then
        for _, timer in ipairs(st.sitTimers) do
            if timer and timer.Cancel then
                timer:Cancel()
            end
        end
    end
    if st.sitTimer1 and st.sitTimer1.Cancel then
        st.sitTimer1:Cancel()
    end
    if st.sitTimer2 and st.sitTimer2.Cancel then
        st.sitTimer2:Cancel()
    end
    if st.sitSpamTimer and st.sitSpamTimer.Cancel then
        st.sitSpamTimer:Cancel()
    end
    st.sitTimers = nil
    st.sitTimer1 = nil
    st.sitTimer2 = nil
    st.sitSpamTimer = nil
    st.sitPlanTargetMhProgress = nil

    if st.sitPlanActive then
        self:PrintSitSchedule("plan_cancel", string.format("Plan CANCELLED: %s | MH p=%.2f OH p=%.2f", tostring(reason), mhProgress or -1, ohProgress or -1), true)
        self:Debug("SIT_PLAN_CANCEL @ %.3f reason=%s | MH p=%.3f OH p=%.3f",
            now, tostring(reason), mhProgress or -1, ohProgress or -1)
        local diff = st.lastSyncDifference or -1
        local leader = st.lastLeaderHand or "unknown"
        self:MaybePrintSyncStep(
            "sit_plan_cancel",
            string.format("WeaponSync: plan cancel (%s) | diff=%.3f | leader=%s", tostring(reason), diff, tostring(leader)),
            self.db.class.debugPrintThrottle
        )
    end

    st.sitPlanActive = false
    st.lastSitPlanEndAt = now
end

--- Cancel any pending proactive pre-plan timer.
--- @param reason string|nil
function TBCEnhancementShamanWeaponSync:CancelSitPrePlan(reason)
    self._debugState = self._debugState or {}
    local st = self._debugState

    if st.sitPrePlanTimer and st.sitPrePlanTimer.Cancel then
        st.sitPrePlanTimer:Cancel()
    end
    st.sitPrePlanTimer = nil
    st.sitPrePlanActive = false

    if reason then
        self:Debug("SIT_PREPLAN_CANCEL reason=%s", tostring(reason))
        self:PrintSitTrace(string.format("PREPLAN_CANCEL reason=%s", tostring(reason)))
    end
end

--- Returns true when /nagattack spam is active enough to allow SIT execution.
--- Uses strict baseline checks plus a fire-time grace window and recent-press fallback.
--- @param now number
--- @param cachedStats table|nil Optional pre-fetched spam stats (avoids redundant GetAttackSpamStats).
--- @return boolean
function TBCEnhancementShamanWeaponSync:IsAttackSpamActiveForSitFire(now, cachedStats)
    local stats = cachedStats or ((NAG and NAG.GetAttackSpamStats) and NAG:GetAttackSpamStats() or nil)
    if not stats then
        return false
    end

    local recencyFire = self.db and self.db.class and self.db.class.attackSpamFireGraceWindow or ATTACK_SPAM_FIRE_GRACE_WINDOW
    local minPresses = self.db and self.db.class and self.db.class.attackSpamMinPresses or ATTACK_SPAM_MIN_PRESSES

    local recentEnough = stats.lastPressAgo and stats.lastPressAgo <= recencyFire
    local enoughPresses = (stats.pressesLast1s or 0) >= minPresses
    if recentEnough and enoughPresses then
        return true
    end

    -- Frame-order jitter guard: accept "recent activity" for this tick if presses are sufficient.
    local st = (NAG and NAG.state and NAG.state.attackSpam) or nil
    local recentlyActive = st and st.attackPressedUntil and st.attackPressedUntil > now
    return recentlyActive and enoughPresses or false
end

-- ============================ PRESS-TRIGGERED SIT (FAST PATH) ============================
--- Fire SIT immediately when /nagattack is pressed, if MH is not ahead and conditions are met.
--- Enables stagger in one single weapon swing instead of waiting for OnUpdate (100ms interval).
--- @return boolean True if SIT was fired
function TBCEnhancementShamanWeaponSync:TryFireSitOnPress()
    if not DoEmote then
        return false
    end
    local gateActive = NAG.IsTBCEnhancementWeaponSyncEnabled and NAG:IsTBCEnhancementWeaponSyncEnabled()
    local autoSitEnabled = gateActive and (self.db and self.db.class and self.db.class.debugAutoStopAttack)
    if not autoSitEnabled then
        return false
    end
    if not swingTimerLib then
        return false
    end

    local s = self:GetSwingDebugSnapshot()
    if not s.ok then
        return false
    end

    local now = s.now
    local mhSpeed, ohSpeed = s.mhSpeed, s.ohSpeed
    local mhTimeToNext, ohTimeToNext = s.mhTimeToNext, s.ohTimeToNext
    local mhProgress, ohProgress = s.mhProgress, s.ohProgress
    local syncDifference = s.syncDifference

    local leaderHand = computeSyncedLeaderHand(mhTimeToNext, ohTimeToNext, mhSpeed, ohSpeed)
    -- Only fire when MH is NOT ahead - per user: "would only work while MH isn't ahead"
    -- When OH leads, SIT holds OH so MH can catch up. When TIE or MH leads, SIT would hold both (no benefit).
    if leaderHand ~= "OH" then
        return false
    end

    local syncThreshold = self.db.class.syncThreshold or SYNC_THRESHOLD
    local isSynchronized = syncDifference <= syncThreshold
    local mhMustLeadWhenSynced = self.db.class.mhMustLeadWhenSynced
    local mhLeadTimeSeconds = self.db.class.mhLeadTimeSeconds or 0
    if mhLeadTimeSeconds < 0 then mhLeadTimeSeconds = 0 end
    local mhLeads = (leaderHand == "MH")
    local isSyncedOrderOK = (not mhMustLeadWhenSynced) or mhLeads
    local isEffectivelySynchronized = isSynchronized and isSyncedOrderOK
    local tooPerfectSync = syncDifference <= mhLeadTimeSeconds
    local needsMhLeadStagger = mhMustLeadWhenSynced and tooPerfectSync
    local needsMhTooFarAhead = mhMustLeadWhenSynced and (leaderHand == "MH") and (syncDifference > MAX_DESIRED_MH_STAGGER_SECONDS)
    local needsOrderFix = mhMustLeadWhenSynced and (leaderHand ~= "MH") and (not isEffectivelySynchronized)
    local needsStaggerCorrection = needsOrderFix
        or (needsMhLeadStagger and (leaderHand ~= "MH") and (leaderHand ~= "TIE"))
        or needsMhTooFarAhead

    local hasStableSwingTimers = (mhTimeToNext > 0) and (ohTimeToNext > 0)
    local ohPastMid = ohProgress >= SIT_OH_SECOND_HALF_MIN_PROGRESS
    local hasValidSpeeds = mhSpeed and mhSpeed > 0 and ohSpeed and ohSpeed > 0

    self._debugState = self._debugState or {}
    local st = self._debugState
    local sinceHasteChange = now - (st.lastHasteChangeAt or 0)
    local hasteSettled = sinceHasteChange >= HASTE_CHANGE_SIT_LOCKOUT_SECONDS

    local remainingOk = true
    if NAG and NAG.RemainingTime then
        local rt = NAG:RemainingTime()
        remainingOk = not (rt and rt < 2)
    end

    local targetAttackable = UnitExists("target") and UnitCanAttack("player", "target")

    if needsStaggerCorrection
        and (not isEffectivelySynchronized)
        and hasStableSwingTimers
        and ohPastMid
        and hasValidSpeeds
        and hasteSettled
        and remainingOk
        and targetAttackable
    then
        DoEmote("SIT")
        st.lastSitActionAt = now
        self:PrintSitSchedule("sit_press", string.format("SIT fired (press) | MH p=%.2f OH p=%.2f diff=%.2f", mhProgress, ohProgress, syncDifference))
        return true
    end
    return false
end


function TBCEnhancementShamanWeaponSync:UpdateVisibility()
    if not frame then return end

    -- IMPORTANT:
    -- In WoW, hiding a frame stops its OnUpdate from firing. This module's logic runs on OnUpdate,
    -- so we keep the frame shown and instead "visually hide" it by setting alpha to 0 and disabling mouse.

    -- In edit mode: force visible, raise strata/level above NAG display frames
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        frame:SetFrameStrata("DIALOG")
        frame:SetFrameLevel(200)
        frame:Show()
        frame:SetAlpha(self.db.class.bar.alpha or 1.0)
        frame:EnableMouse(true)
        return
    end

    local gateActive = NAG.IsTBCEnhancementWeaponSyncEnabled and NAG:IsTBCEnhancementWeaponSyncEnabled()
    local debugEnabled = self.db.class.debugEnabled and true or false

    -- Per request: the ONLY thing this toggle changes is bar visibility.
    -- We show the UI iff rotation gate is active AND debugEnabled is true.
    local showUI = gateActive and debugEnabled

    local level = DisplayManager and DisplayManager.GetRecommendedClassBarFrameLevel and DisplayManager:GetRecommendedClassBarFrameLevel() or 50
    frame:SetFrameStrata("MEDIUM")
    frame:SetFrameLevel(level)
    frame:Show()

    if showUI then
        frame:SetAlpha(self.db.class.bar.alpha or 1.0)
        frame:EnableMouse(true)
    else
        frame:SetAlpha(0)
        frame:EnableMouse(false)
    end
end

function TBCEnhancementShamanWeaponSync:UpdateDisplay()
    -- Do NOT gate logic behind any UI toggle.
    if not frame or isDragging then return end
    -- In edit mode, visibility is managed by UpdateVisibility - don't dim/hide so user can position
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        return
    end

    -- Check if we have valid weapon data
    if not swingTimerLib then
        -- Do not Hide(): keep OnUpdate alive. Just make the UI invisible.
        frame:Show()
        frame:SetAlpha(0)
        frame:EnableMouse(false)
        return
    end

    local mhSpeed, mhExpiration = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    local ohSpeed, ohExpiration = swingTimerLib:UnitSwingTimerInfo("player", "offhand")

    -- Need at least main-hand weapon
    if not mhSpeed or not mhExpiration then
        frame:Show()
        frame:SetAlpha(0)
        frame:EnableMouse(false)
        return
    end

    -- If no off-hand (shield or no weapon), hide the sync bar
    if not ohSpeed or not ohExpiration or ohSpeed == 0 then
        frame:Show()
        frame:SetAlpha(0)
        frame:EnableMouse(false)
        return
    end

    local currentTime = GetTime()
    local maxWidth = frame:GetWidth()

    -- Calculate time until next swing for both weapons
    local mhTimeToNext = max(0, mhExpiration - currentTime)
    local ohTimeToNext = max(0, ohExpiration - currentTime)

    -- Calculate swing progress (0 to 1, where 0 = just swung, 1 = about to swing)
    -- Progress increases as time passes toward the next swing
    local mhProgress = min(1.0, 1.0 - (mhTimeToNext / mhSpeed))
    local ohProgress = min(1.0, 1.0 - (ohTimeToNext / ohSpeed))

    -- Calculate sync difference
    local syncDifference = computeSyncPhaseDifference(mhTimeToNext, ohTimeToNext, mhSpeed, ohSpeed)
    local syncThreshold = self.db.class.syncThreshold or SYNC_THRESHOLD
    local isSynchronized = syncDifference <= syncThreshold

    -- Some situations produce "idle" swing info (e.g. no target / not actively swinging) where ttn can be 0.
    -- We should never fire SIT automation in those cases.
    local hasStableSwingTimers = (mhTimeToNext > 0) and (ohTimeToNext > 0)

    -- If MH must lead when synced, check order. Important nuance:
    -- For wrap-boundary cases (one hand just swung, the other is about to swing),
    -- "leader" should be the hand that already swung (timer reset to near full),
    -- not the one with the smaller time-to-next.
    local leaderHand = computeSyncedLeaderHand(mhTimeToNext, ohTimeToNext, mhSpeed, ohSpeed)
    local mhMustLeadWhenSynced = self.db.class.mhMustLeadWhenSynced
    local mhLeadTimeSeconds = self.db.class.mhLeadTimeSeconds or 0
    if mhLeadTimeSeconds < 0 then mhLeadTimeSeconds = 0 end
    -- Strict MH-leading mode (per request): MH must be slightly ahead; ties are NOT acceptable.
    local mhLeads = (leaderHand == "MH")
    local isSyncedOrderOK = (not mhMustLeadWhenSynced) or mhLeads
    -- "Effective" synced for our drill: within time threshold AND strict MH-leading order (if enforced).
    local isEffectivelySynchronized = isSynchronized and isSyncedOrderOK
    -- Desired default state is not perfect sync: MH should be slightly ahead.
    -- If we're too perfectly synced (or near-perfect), we still want correction toward MH-leading stagger.
    -- This must include tie states, not just MH-leading states.
    local tooPerfectSync = syncDifference <= mhLeadTimeSeconds
    local needsMhLeadStagger = mhMustLeadWhenSynced and tooPerfectSync
    local needsMhTooFarAhead = mhMustLeadWhenSynced and (leaderHand == "MH") and (syncDifference > MAX_DESIRED_MH_STAGGER_SECONDS)
    local isPerfectTie = mhMustLeadWhenSynced and tooPerfectSync and (leaderHand == "TIE")

    -- Persist key state for other helpers (runtime-only)
    self._debugState = self._debugState or {}
    if isPerfectTie then
        if not self._debugState.tiePerfectSince then
            self._debugState.tiePerfectSince = currentTime
        end
    else
        self._debugState.tiePerfectSince = nil
    end
    local perfectTieStable = (not isPerfectTie) or
        (self._debugState.tiePerfectSince and (currentTime - self._debugState.tiePerfectSince) >= PERFECT_SYNC_TIE_HYSTERESIS_SECONDS)

    self._debugState.lastSyncDifference = syncDifference
    self._debugState.lastLeaderHand = leaderHand
    self._debugState.lastNeedsMhLeadStagger = needsMhLeadStagger
    self._debugState.lastNeedsMhTooFarAhead = needsMhTooFarAhead
    self._debugState.lastTooPerfectSync = tooPerfectSync
    self._debugState.lastPerfectTieStable = perfectTieStable

    -- Log haste/speed changes (LibClassicSwingTimerAPI uses UnitAttackSpeed + UNIT_ATTACK_SPEED)
    -- When haste procs, swing timers can momentarily show wrong phase; suppress SIT until they settle.
    local lastMh = self._debugState._prevMhSpeed
    local lastOh = self._debugState._prevOhSpeed
    if (lastMh and abs((mhSpeed or 0) - lastMh) > 0.01) or (lastOh and abs((ohSpeed or 0) - lastOh) > 0.01) then
        self._debugState.lastHasteChangeAt = currentTime
        self:PrintSitSchedule("speed_change", string.format("Haste/speed changed: MH %.3f->%.3f OH %.3f->%.3f",
            lastMh or 0, mhSpeed or 0, lastOh or 0, ohSpeed or 0), true)
    end
    self._debugState._prevMhSpeed = mhSpeed
    self._debugState._prevOhSpeed = ohSpeed

    -- UI visibility is handled only by UpdateVisibility(). Do not hide/return here based on sync state.
    self:UpdateVisibility()

    local bars = frame.bars
    if not bars or not bars.mh or not bars.oh or not bars.countdown or not bars.diff then
        return
    end

    -- ============================ MH / OH SWING BARS ============================
    bars.mh:SetMinMaxValues(0, 1)
    bars.mh:SetValue(mhProgress)
    bars.mh.valueText:SetText(string.format("%.2fs", mhTimeToNext))

    bars.oh:SetMinMaxValues(0, 1)
    bars.oh:SetValue(ohProgress)
    bars.oh.valueText:SetText(string.format("%.2fs", ohTimeToNext))

    -- Detect optimal macro timing:
    -- Pressing the macro resets BOTH swing timers to start now.
    -- For equal-speed weapons, the best time is immediately after the *later* swing, as long as the other swing
    -- was also recent (otherwise you discard too much of the earlier swing cycle).
    local macroTimingWindow = self.db.class.macroTimingWindow or 0.25
    local mhTimeSinceSwing = max(0, min(mhSpeed, mhSpeed - mhTimeToNext))
    local ohTimeSinceSwing = max(0, min(ohSpeed, ohSpeed - ohTimeToNext))

    local swingOffset = abs(mhTimeSinceSwing - ohTimeSinceSwing) -- how far apart the last MH/OH swings occurred
    local timeSinceLaterSwing = min(mhTimeSinceSwing, ohTimeSinceSwing)

    -- Suggest pressing only when:
    -- - you're currently desynced (beyond syncThreshold)
    -- - the offset isn't huge (<= macroTimingWindow)
    -- - you're still very close to the later swing (<= macroTimingWindow)
    local optimalMacroTime = hasStableSwingTimers
        and (not isSynchronized)
        and (swingOffset > syncThreshold)
        and (swingOffset <= macroTimingWindow)
        and (timeSinceLaterSwing <= macroTimingWindow)

    -- ============================ COUNTDOWN BAR (WHEN TO PRESS MACRO) ============================
    local maxSwingSpeed = max(mhSpeed, ohSpeed)
    local timeUntilLaterSwing = max(mhTimeToNext, ohTimeToNext)

    bars.countdown:SetMinMaxValues(0, maxSwingSpeed)
    bars.countdown:SetValue(max(0, maxSwingSpeed - timeUntilLaterSwing))

    -- Additional debug guidance based on your observed behavior:
    -- If OH has passed mid-swing and MH is still before mid-swing, suggest "spam sync macro" to hold OH around mid.
    local debugEnabled = self.db.class.debugEnabled
    local midWindow = self.db.class.debugWindowProgress or 0.12
    local orderFixWindow = self.db.class.orderFixWindowProgress or ORDER_FIX_WINDOW_PROGRESS
    local targetReachedWindow = self.db.class.targetReachedWindowProgress or TARGET_REACHED_WINDOW_PROGRESS
    local mhBeforeMid = mhProgress < (0.5 - midWindow)
    local mhAtMidOrAfter = mhProgress >= (0.5 - midWindow)
    local ohAfterMid = ohProgress > (0.5 + midWindow)
    local ohNearMid = abs(ohProgress - 0.5) <= midWindow
    -- Narrower checks used for "order-only" corrections when already close.
    local mhBeforeMidForFix = mhProgress <= (0.5 - orderFixWindow)
    local ohAfterMidForFix = ohProgress >= (0.5 + orderFixWindow)

    -- "Spam sync macro" guidance should not be gated behind debugEnabled (users want help).
    -- IMPORTANT: if MH-leading order is required, a "synced-but-OH-first" state should be treated as needing correction.
    local suggestSpamMacro = hasStableSwingTimers and (((not isEffectivelySynchronized) and ohAfterMid and mhBeforeMid) or needsMhLeadStagger or needsMhTooFarAhead)

    -- Expose to other systems (runtime-only): whether we currently advise spamming the macro.
    self._debugState = self._debugState or {}
    self._debugState.lastSuggestSpamMacro = suggestSpamMacro

    -- Detect whether the user is *actually* spamming the macro.
    -- We cannot observe /startattack directly; instead the macro should include `/nagattack` (slash hook).
    -- Cache GetAttackSpamStats for this frame (avoid 3-4x calls per frame).
    local spamStats = (NAG and NAG.GetAttackSpamStats) and NAG:GetAttackSpamStats() or {
        pressesLast1s = 0,
        lastPressAt = nil,
        lastPressAgo = nil,
        avgInterval = nil,
    }
    local isSpammingAttack = (spamStats and (spamStats.pressesLast1s or 0) >= 3 and spamStats.lastPressAgo and spamStats.lastPressAgo <= 0.30)

    -- Print advice changes (always on, edge-triggered, separately throttled from tick prints)
    self._debugState = self._debugState or {}
    self._debugState.lastIsSynchronized = isSynchronized
    self._debugState.lastIsEffectivelySynchronized = isEffectivelySynchronized
    self._debugState.lastMhProgress = mhProgress
    self._debugState.lastOhProgress = ohProgress
    self._debugState.lastMhSpeed = mhSpeed
    self._debugState.lastOhSpeed = ohSpeed
    self._debugState.lastIsSpammingAttack = isSpammingAttack
    self._debugState.lastAttackAvgInterval = spamStats and spamStats.avgInterval or nil
    self._debugState.lastAttackPressesLast1s = spamStats and spamStats.pressesLast1s or 0
    self._debugState.lastAttackLastPressAt = spamStats and spamStats.lastPressAt or nil
    self._debugState.lastAttackLastPressAgo = spamStats and spamStats.lastPressAgo or nil
    local advice = "WAIT"
    if needsMhLeadStagger then
        advice = "STAGGER_MH_AHEAD"
    elseif needsMhTooFarAhead then
        advice = "TRIM_MH_LEAD"
    elseif isSynchronized then
        advice = isSyncedOrderOK and "SYNCED" or "FIX_MH_FIRST"
    elseif suggestSpamMacro then
        advice = "SPAM_SYNC_MACRO"
    elseif optimalMacroTime then
        advice = "PRESS_NOW"
    end

    if advice ~= self._debugState.lastAdvicePrinted then
        self._debugState.lastAdvicePrinted = advice
        self:MaybePrintSyncStep(
            "advice",
            string.format(
                "WeaponSync: %s | diff=%.3f | leader=%s | spamming=%s",
                advice,
                syncDifference,
                tostring(leaderHand),
                tostring(isSpammingAttack)
            ),
            self.db.class.debugPrintThrottle
        )
    end

    -- Production: suppress chat prints. Advice is still shown on the bar.
    local now = GetTime()
    local adviceThrottle = self.db.class.debugPrintThrottle or 0.75
    if advice ~= self._debugState.lastAdvice then
        self._debugState.lastAdvice = advice
        if (not self._debugState.lastAdvicePrintAt) or ((now - self._debugState.lastAdvicePrintAt) >= adviceThrottle) then
            self._debugState.lastAdvicePrintAt = now
            self:Debug("advice=%s @ %.3f | MH ttn=%.3f p=%.3f | OH ttn=%.3f p=%.3f | diff=%.3f | leader=%s | spam=%s presses1s=%d avg=%.3f",
                advice, now,
                mhTimeToNext, mhProgress,
                ohTimeToNext, ohProgress,
                syncDifference,
                tostring(leaderHand),
                tostring(isSpammingAttack),
                spamStats and (spamStats.pressesLast1s or 0) or 0,
                spamStats and (spamStats.avgInterval or -1) or -1
            )
        end
    end

    if needsMhLeadStagger then
        bars.countdown:SetStatusBarColor(1.0, 0.6, 0.2, 0.9)
        bars.countdown.valueText:SetText(isSpammingAttack and "SPAM TO RE-STAGGER (detected)" or "SPAM TO RE-STAGGER")
    elseif needsMhTooFarAhead then
        bars.countdown:SetStatusBarColor(1.0, 0.6, 0.2, 0.9)
        bars.countdown.valueText:SetText(isSpammingAttack and "SPAM TO TRIM MH LEAD (detected)" or "SPAM TO TRIM MH LEAD")
    elseif isSynchronized then
        bars.countdown:SetStatusBarColor(0.2, 0.8, 0.2, 0.9)
        if isSyncedOrderOK then
            bars.countdown.valueText:SetText(string.format("SYNCED (<= %.2fs)", syncThreshold))
        else
            -- Within threshold, but order is wrong (for MH-leading drill). Treat as needing correction.
            bars.countdown.valueText:SetText(string.format("FIX: MH MUST LEAD (<= %.2fs)", syncThreshold))
        end
    elseif suggestSpamMacro then
        bars.countdown:SetStatusBarColor(1.0, 0.6, 0.2, 0.9)
        bars.countdown.valueText:SetText(isSpammingAttack and "SPAM SYNC MACRO (detected)" or "SPAM SYNC MACRO (not detected)")
    elseif optimalMacroTime then
        if self.db.class.showSyncWindow then
            bars.countdown:SetStatusBarColor(1.0, 1.0, 0.2, 0.9)
        end
        bars.countdown.valueText:SetText("PRESS NOW")
    else
        local c = (self.db.class.bar.colors and self.db.class.bar.colors.syncWindow) or { r = 1.0, g = 1.0, b = 0.2, a = 0.7 }
        bars.countdown:SetStatusBarColor(c.r, c.g, c.b, 0.6)
        bars.countdown.valueText:SetText(string.format("in %.2fs", timeUntilLaterSwing))
    end

    -- Live SIT: monitor swing state every frame, fire SIT every 100ms when holding OH until MH leads.
    -- No scheduling - just fire inline when conditions are met. Removes too_close_to_swing guard.
    self._debugState.lastHasStableSwingTimers = hasStableSwingTimers

    local st = self._debugState
    local gateActive = NAG.IsTBCEnhancementWeaponSyncEnabled and NAG:IsTBCEnhancementWeaponSyncEnabled()
    local autoSitEnabled = gateActive and (self.db.class.debugAutoStopAttack and true or false)
    local needsOrderFix = mhMustLeadWhenSynced and (leaderHand ~= "MH") and (not isEffectivelySynchronized)
    -- Exclude needsMhLeadStagger when MH already leads: "too perfect" but MH ahead = acceptable, don't fire.
    -- For TIE: require perfectTieStable (0.1s persistence) to avoid spamming SIT on momentary tie flickers.
    local needsStaggerCorrection = needsOrderFix
        or (needsMhLeadStagger and (leaderHand ~= "MH") and (leaderHand ~= "TIE" or perfectTieStable))
        or needsMhTooFarAhead

    -- Live fire: need correction + OH past mid + spam active + 100ms since last SIT
    local sitInterval = self.db.class.sitSpamInterval or SIT_LIVE_INTERVAL
    local sinceLastSit = now - (st.lastSitActionAt or 0)
    local intervalElapsed = sinceLastSit >= sitInterval
    local sinceHasteChange = now - (st.lastHasteChangeAt or 0)
    local hasteSettled = sinceHasteChange >= HASTE_CHANGE_SIT_LOCKOUT_SECONDS
    local ohPastMid = ohProgress >= SIT_OH_SECOND_HALF_MIN_PROGRESS
    local hasValidSpeeds = mhSpeed and mhSpeed > 0 and ohSpeed and ohSpeed > 0
    local spamActive = self:IsAttackSpamActiveForSitFire(now, spamStats)
    local remainingOk = true
    if NAG and NAG.RemainingTime then
        local rt = NAG:RemainingTime()
        remainingOk = not (rt and rt < 2)
    end

    local targetAttackable = UnitExists("target") and UnitCanAttack("player", "target")

    if autoSitEnabled
        and needsStaggerCorrection
        and (not isEffectivelySynchronized)
        and hasStableSwingTimers
        and ohPastMid
        and hasValidSpeeds
        and spamActive
        and intervalElapsed
        and hasteSettled
        and remainingOk
        and targetAttackable
    then
        if DoEmote then
            DoEmote("SIT")
            st.lastSitActionAt = now
            self:PrintSitSchedule("sit_fired", string.format("SIT fired (live) | MH p=%.2f OH p=%.2f diff=%.2f", mhProgress, ohProgress, syncDifference))
        end
    end

    -- Periodic printing (always available; not gated behind debugEnabled)
    if self.db.class.debugPrintSwingState then
        local throttle = self.db.class.debugPrintThrottle or 0.75
        if (not self._debugState.lastTickPrintAt) or ((now - self._debugState.lastTickPrintAt) >= throttle) then
            self._debugState.lastTickPrintAt = now
            -- Keep the "tick" print format stable for log parsing
            self:Debug("tick @ %.3f | MH ttn=%.3f p=%.3f | OH ttn=%.3f p=%.3f | diff=%.3f",
                now,
                mhTimeToNext, mhProgress,
                ohTimeToNext, ohProgress,
                syncDifference
            )
        end
    end

    -- ============================ SYNC DIFFERENCE BAR ============================
    local diffMax = DIFF_BAR_MAX_SECONDS
    bars.diff:SetMinMaxValues(0, diffMax)
    bars.diff:SetValue(min(syncDifference, diffMax))
    bars.diff.valueText:SetText(string.format("%.3fs", syncDifference))

    if syncDifference <= self.db.class.syncThreshold then
        local sc = (self.db.class.bar.colors and self.db.class.bar.colors.synchronized) or { r = 0.2, g = 0.8, b = 0.2, a = 0.9 }
        bars.diff:SetStatusBarColor(sc.r, sc.g, sc.b, 0.8)
    else
        local dc = (self.db.class.bar.colors and self.db.class.bar.colors.desynchronized) or { r = 0.8, g = 0.2, b = 0.2, a = 0.9 }
        bars.diff:SetStatusBarColor(dc.r, dc.g, dc.b, 0.8)
    end

    -- ============================ OPTIONAL: HIDE/SHOW TEXT ============================
    local showText = self.db.class.showText
    bars.mh.label:SetShown(showText)
    bars.mh.valueText:SetShown(showText)
    bars.oh.label:SetShown(showText)
    bars.oh.valueText:SetShown(showText)
    bars.countdown.label:SetShown(showText)
    bars.countdown.valueText:SetShown(showText)
    bars.diff.label:SetShown(showText)
    bars.diff.valueText:SetShown(showText)
end

function TBCEnhancementShamanWeaponSync:PLAYER_REGEN_DISABLED(event)
    -- Combat start
    self:PrintSitTrace("COMBAT_STATE entered_combat")
    self:UpdateVisibility()
end

function TBCEnhancementShamanWeaponSync:PLAYER_REGEN_ENABLED(event)
    -- Combat end
    self:PrintSitTrace("COMBAT_STATE left_combat")
    self:UpdateVisibility()
    -- Always rescan on combat end (safe OOC). This also catches macro manager addons
    -- that don't reliably fire UPDATE_MACROS while in combat.
    self:TryAutoPatchStartAttackMacros(true)
end

function TBCEnhancementShamanWeaponSync:GetOptions()
    return {
        type = "group",
        name = L["TBC Weapon Sync"] or "TBC Weapon Sync",
        order = 26,
        childGroups = "tab",
        width = "full",
        args = {
            debugEnabled = OptionsFactory:CreateToggle(
                L["Debug Enabled"] or "Debug Enabled",
                L["Show the Weapon Sync bars (debug UI). Disabling this hides the bars but does not disable syncing logic."] or "Show the Weapon Sync bars (debug UI). Disabling this hides the bars but does not disable syncing logic.",
                function() return self.db.class.debugEnabled end,
                function(info, value)
                    self.db.class.debugEnabled = value
                    self:UpdateVisibility()
                end,
                { width = "full", order = 0 }
            ),
            debugSettings = {
                type = "group",
                name = L["Debug UI Settings"] or "Debug UI Settings",
                inline = false,
                order = 1,
                hidden = function() return not self.db.class.debugEnabled end,
                args = {
            debugAutoStopAttack = OptionsFactory:CreateToggle(
                L["Auto SIT Assist (experimental)"] or "Auto SIT Assist (experimental)",
                L["Auto SIT: when OH is past mid-swing, fire /sit every 100ms to hold OH until MH leads. Monitors swing state live (no scheduling)."] or "Auto SIT: when OH is past mid-swing, fire /sit every 100ms to hold OH until MH leads. Monitors swing state live (no scheduling).",
                function() return self.db.class.debugAutoStopAttack end,
                function(info, value)
                    self.db.class.debugAutoStopAttack = value
                end,
                        { width = "full", order = 2.2 }
            ),
            sitSpamInterval = OptionsFactory:CreateRange(
                L["SIT Interval (seconds)"] or "SIT Interval (seconds)",
                L["Seconds between SIT emotes when holding OH (default 0.10 = 100ms). Lower = faster correction."] or "Seconds between SIT emotes when holding OH (default 0.10 = 100ms). Lower = faster correction.",
                function() return self.db.class.sitSpamInterval end,
                function(info, value)
                    self.db.class.sitSpamInterval = value
                end,
                        { min = 0.05, max = 0.30, step = 0.01, order = 2.21 }
            ),
            sitStopDelay = OptionsFactory:CreateRange(
                L["SIT Stop Delay"] or "SIT Stop Delay",
                L["Estimated seconds between SIT and auto-attack actually stopping (you reported ~0.20s)"] or "Estimated seconds between SIT and auto-attack actually stopping (you reported ~0.20s)",
                function() return self.db.class.sitStopDelay end,
                function(info, value)
                    self.db.class.sitStopDelay = value
                end,
                        { min = 0.05, max = 0.50, step = 0.01, order = 2.25 }
            ),
            sitSplitPad = OptionsFactory:CreateRange(
                L["SIT Split Pad"] or "SIT Split Pad",
                L["Safety pad used for the split condition (\"- 0.1s\")"] or "Safety pad used for the split condition (\"- 0.1s\")",
                function() return self.db.class.sitSplitPad end,
                function(info, value)
                    self.db.class.sitSplitPad = value
                end,
                        { min = 0.00, max = 0.30, step = 0.01, order = 2.26 }
            ),
            sitReplanCooldown = OptionsFactory:CreateRange(
                L["SIT Replan Cooldown (seconds)"] or "SIT Replan Cooldown (seconds)",
                L["Minimum seconds between SIT plan attempts (prevents spam if conditions flicker)"] or "Minimum seconds between SIT plan attempts (prevents spam if conditions flicker)",
                function() return self.db.class.sitReplanCooldown end,
                function(info, value)
                    self.db.class.sitReplanCooldown = value
                end,
                        { min = 0.10, max = 2.00, step = 0.05, order = 2.265 }
            ),
            orderFixWindowProgress = OptionsFactory:CreateRange(
                L["Order Fix Window (progress)"] or "Order Fix Window (progress)",
                L["Narrow window around 0.5 progress used to trigger MH-first corrections even when swings are already close. Lower = more sensitive."] or "Narrow window around 0.5 progress used to trigger MH-first corrections even when swings are already close. Lower = more sensitive.",
                function() return self.db.class.orderFixWindowProgress end,
                function(info, value)
                    self.db.class.orderFixWindowProgress = value
                end,
                        { min = 0.00, max = 0.10, step = 0.01, order = 2.266 }
            ),
            targetReachedWindowProgress = OptionsFactory:CreateRange(
                L["Target Reached Window (progress)"] or "Target Reached Window (progress)",
                L["How close MH must be to the plan target before we stop the plan. This should be small (default 0.01) to avoid cancelling early."] or "How close MH must be to the plan target before we stop the plan. This should be small (default 0.01) to avoid cancelling early.",
                function() return self.db.class.targetReachedWindowProgress end,
                function(info, value)
                    self.db.class.targetReachedWindowProgress = value
                end,
                        { min = 0.00, max = 0.05, step = 0.01, order = 2.267 }
            ),
            debugPrintSwingState = OptionsFactory:CreateToggle(
                L["Print Swing State"] or "Print Swing State",
                L["Print swing state periodically (throttled) while this module is visible"] or "Print swing state periodically (throttled) while this module is visible",
                function() return self.db.class.debugPrintSwingState end,
                function(info, value)
                    self.db.class.debugPrintSwingState = value
                end,
                        { width = "full", order = 2.3 }
            ),
            debugPrintSyncSteps = OptionsFactory:CreateToggle(
                L["Print Sync Steps"] or "Print Sync Steps",
                L["Print sync step messages (throttled) to chat for troubleshooting"] or "Print sync step messages (throttled) to chat for troubleshooting",
                function() return self.db.class.debugPrintSyncSteps end,
                function(info, value)
                    self.db.class.debugPrintSyncSteps = value
                end,
                        { width = "full", order = 2.31 }
            ),
            debugPrintSitSchedule = OptionsFactory:CreateToggle(
                L["Print SIT Schedule"] or "Print SIT Schedule",
                L["Print SIT scheduling decisions to chat: why plan started/blocked, SIT fired/skipped, spam start/stop. Use to diagnose 'no SITs' or 'too many SITs'."] or "Print SIT scheduling decisions to chat: why plan started/blocked, SIT fired/skipped, spam start/stop. Use to diagnose 'no SITs' or 'too many SITs'.",
                function() return self.db.class.debugPrintSitSchedule end,
                function(info, value)
                    self.db.class.debugPrintSitSchedule = value
                end,
                        { width = "full", order = 2.32 }
            ),
                }
            },
            syncThreshold = OptionsFactory:CreateRange(
                L["Synced Threshold (seconds)"] or "Synced Threshold (seconds)",
                L["Weapons are considered synced when within this many seconds of each other (default: 0.35s)"] or "Weapons are considered synced when within this many seconds of each other (default: 0.35s)",
                function() return self.db.class.syncThreshold end,
                function(info, value)
                    self.db.class.syncThreshold = value
                end,
                { min = 0.05, max = 1.0, step = 0.01, order = 3 }
            ),
            mhMustLeadWhenSynced = OptionsFactory:CreateToggle(
                L["MH Must Lead When Synced"] or "MH Must Lead When Synced",
                L["If enabled: when synced, MH should hit first (or same time) if MH hits harder than OH. If disabled: either order is OK when within the synced threshold."] or "If enabled: when synced, MH should hit first (or same time) if MH hits harder than OH. If disabled: either order is OK when within the synced threshold.",
                function() return self.db.class.mhMustLeadWhenSynced end,
                function(info, value)
                    self.db.class.mhMustLeadWhenSynced = value
                end,
                { width = "full", order = 3.1 }
            ),
            mhLeadTimeSeconds = OptionsFactory:CreateRange(
                L["MH Lead Time (seconds)"] or "MH Lead Time (seconds)",
                L["When MH-leading is enforced, bias the SIT plan so MH ends up slightly earlier than OH. 0.00 allows an exact tie; small values like 0.03–0.08 encourage MH-first."] or "When MH-leading is enforced, bias the SIT plan so MH ends up slightly earlier than OH. 0.00 allows an exact tie; small values like 0.03–0.08 encourage MH-first.",
                function() return self.db.class.mhLeadTimeSeconds end,
                function(info, value)
                    self.db.class.mhLeadTimeSeconds = value
                end,
                { min = 0.00, max = 0.20, step = 0.01, order = 3.15 }
            ),
            macroTimingWindow = OptionsFactory:CreateRange(
                L["Macro Timing Window"] or "Macro Timing Window",
                L["Time window (seconds) to press the sync macro right after the later swing"] or "Time window (seconds) to press the sync macro right after the later swing",
                function() return self.db.class.macroTimingWindow end,
                function(info, value)
                    self.db.class.macroTimingWindow = value
                end,
                { min = 0.05, max = 0.5, step = 0.01, order = 4 }
            ),
            macroHeader = OptionsFactory:CreateHeader(L["Sync Macro"] or "Sync Macro", { order = 5 }),
            macroInfo = {
                type = "description",
                name = "|cffffd700Weapon Sync Macro:|r\n|cff00ff00/startattack|r\n|cff00ff00/nagattack|r\n\n|cffffd700Alternative (more reliable, no target swap):|r\n\n|cff00ff00/stopattack|r\n|cff00ff00/startattack|r\n|cff00ff00/nagattack|r\n\n|cffffd700When to Press:|r\nWith equal-speed weapons, press |cffff0000IMMEDIATELY AFTER|r the *later* of the two swings.\nOn the bar, that's when one hand just reset to ~0% progress and the other hand is still low.\n\n|cffffd700/nagattack = SIT when MH not ahead:|r\nEach press fires SIT immediately when OH leads (past 50%%). One press at the right moment = stagger in one swing.\nNo need to spam; OnUpdate still fires SIT every 100ms when holding if needed.",
                order = 6,
                fontSize = "medium",
                width = "full"
            },
            showSyncWindow = OptionsFactory:CreateToggle(
                L["Show Sync Window"] or "Show Sync Window",
                L["Show yellow highlight when both weapons are about to swing"] or "Show yellow highlight when both weapons are about to swing",
                function() return self.db.class.showSyncWindow end,
                function(info, value)
                    self.db.class.showSyncWindow = value
                end,
                { width = "full", order = 7 }
            ),
            showText = OptionsFactory:CreateToggle(
                L["Show Text"] or "Show Text",
                L["Show synchronization status text"] or "Show synchronization status text",
                function() return self.db.class.showText end,
                function(info, value)
                    self.db.class.showText = value
                end,
                { width = "full", order = 8 }
            ),
            barSettings = {
                name = L["Bar Settings"],
                type = "group",
                order = 10,
                inline = false,
                args = {
                    width = OptionsFactory:CreateRange(
                        L["Width"],
                        L["Width"],
                        function() return self.db.class.bar.width end,
                        function(info, value)
                            self.db.class.bar.width = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 200, max = 1000, step = 10, order = 10 }
                    ),
                    height = OptionsFactory:CreateRange(
                        L["Height"],
                        L["Height"],
                        function() return self.db.class.bar.height end,
                        function(info, value)
                            self.db.class.bar.height = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 20, max = 100, step = 5, order = 20 }
                    ),
                    alpha = OptionsFactory:CreateRange(
                        L["Alpha"],
                        L["Alpha"],
                        function() return self.db.class.bar.alpha end,
                        function(info, value)
                            self.db.class.bar.alpha = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 0, max = 1, step = 0.05, order = 30 }
                    ),
                    positionHeader = OptionsFactory:CreateHeader(L["Position"], { order = 40 }),
                    xOffset = OptionsFactory:CreateRange(
                        L["X Offset"],
                        L["X Offset"],
                        function() return self.db.class.bar.x end,
                        function(info, value)
                            self.db.class.bar.x = value
                            self:UpdateFrameSettings()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 50 }
                    ),
                    yOffset = OptionsFactory:CreateRange(
                        L["Y Offset"],
                        L["Y Offset"],
                        function() return self.db.class.bar.y end,
                        function(info, value)
                            self.db.class.bar.y = value
                            self:UpdateFrameSettings()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 60 }
                    ),
                    textHeader = OptionsFactory:CreateHeader(L["Text Settings"], { order = 80 }),
                    textSize = OptionsFactory:CreateRange(
                        L["Text Size"],
                        L["Text Size"],
                        function() return self.db.class.bar.textSize end,
                        function(info, value)
                            self.db.class.bar.textSize = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 10, max = 32, step = 1, order = 90 }
                    ),
                    textColor = OptionsFactory:CreateColor(
                        L["Text Color"],
                        L["Text Color"],
                        function()
                            local c = self.db.class.bar.textColor
                            if not c then
                                c = { r = 1, g = 1, b = 1, a = 1 }
                                self.db.class.bar.textColor = c
                            end
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.textColor = { r = r, g = g, b = b, a = a }
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 100 }
                    ),
                }
            },
            appearanceSettings = {
                name = L["Appearance"],
                type = "group",
                order = 20,
                inline = false,
                args = {
                    showBorder = OptionsFactory:CreateToggle(
                        L["Show Border"],
                        L["Show Border"],
                        function() return self.db.class.bar.showBorder end,
                        function(info, value)
                            self.db.class.bar.showBorder = value
                            self:UpdateFrameSettings()
                        end,
                        { order = 10 }
                    ),
                    borderColor = OptionsFactory:CreateColor(
                        L["Border Color"],
                        L["Border Color"],
                        function()
                            local c = self.db.class.bar.borderColor
                            if not c then
                                c = { r = 1, g = 1, b = 1, a = 1 }
                                self.db.class.bar.borderColor = c
                            end
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.borderColor = { r = r, g = g, b = b, a = a }
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 20 }
                    ),
                    colorHeader = OptionsFactory:CreateHeader(L["Bar Colors"], { order = 30 }),
                    synchronizedColor = OptionsFactory:CreateColor(
                        L["Synchronized Color"] or "Synchronized Color",
                        L["Color when weapons are synchronized"] or "Color when weapons are synchronized",
                        function()
                            self.db.class.bar.colors = self.db.class.bar.colors or {}
                            local c = self.db.class.bar.colors.synchronized
                            if not c then
                                c = { r = 0.2, g = 0.8, b = 0.2, a = 0.9 }
                                self.db.class.bar.colors.synchronized = c
                            end
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.synchronized = { r = r, g = g, b = b, a = a }
                        end,
                        { hasAlpha = true, order = 40 }
                    ),
                    desynchronizedColor = OptionsFactory:CreateColor(
                        L["Desynchronized Color"] or "Desynchronized Color",
                        L["Color when weapons are out of sync"] or "Color when weapons are out of sync",
                        function()
                            self.db.class.bar.colors = self.db.class.bar.colors or {}
                            local c = self.db.class.bar.colors.desynchronized
                            if not c then
                                c = { r = 0.8, g = 0.2, b = 0.2, a = 0.9 }
                                self.db.class.bar.colors.desynchronized = c
                            end
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.desynchronized = { r = r, g = g, b = b, a = a }
                        end,
                        { hasAlpha = true, order = 50 }
                    ),
                    mainhandColor = OptionsFactory:CreateColor(
                        L["Main-Hand Color"] or "Main-Hand Color",
                        L["Color for main-hand weapon swing bar"] or "Color for main-hand weapon swing bar",
                        function()
                            self.db.class.bar.colors = self.db.class.bar.colors or {}
                            local c = self.db.class.bar.colors.mainhand
                            if not c then
                                c = { r = 0.4, g = 0.6, b = 1.0, a = 0.8 }
                                self.db.class.bar.colors.mainhand = c
                            end
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.mainhand = { r = r, g = g, b = b, a = a }
                        end,
                        { hasAlpha = true, order = 60 }
                    ),
                    offhandColor = OptionsFactory:CreateColor(
                        L["Off-Hand Color"] or "Off-Hand Color",
                        L["Color for off-hand weapon swing bar"] or "Color for off-hand weapon swing bar",
                        function()
                            self.db.class.bar.colors = self.db.class.bar.colors or {}
                            local c = self.db.class.bar.colors.offhand
                            if not c then
                                c = { r = 1.0, g = 0.6, b = 0.4, a = 0.8 }
                                self.db.class.bar.colors.offhand = c
                            end
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.offhand = { r = r, g = g, b = b, a = a }
                        end,
                        { hasAlpha = true, order = 70 }
                    ),
                }
            }
        }
    }
end

