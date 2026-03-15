--- @module "NAG.WarriorArmsCSWindow"
--- Arms CS Window tracking via NAG message bus (no direct WoW events)
---
--- Public API:
---   - IsCSWindowActive(): boolean
---   - WasEarlySlamInThisCSWindow(): boolean
---   - ShouldSlamOverride(): boolean  -- true iff CS window active AND early Slam occurred (GCD #1 or #2)
---
--- Rule: If the 1st or 2nd GCD after Colossus Smash (CS) was Slam, then prefer Slam over Overpower
---       for the remainder of that CS window.
---
---   - "NAG_SPELL_CAST_SUCCEEDED", payload: (source, unit, castGUID, spellId, spellName)
---
--- License: CC BY-NC 4.0
--- Authors: @Rakizi, @Fonsas

-- ============================ LOCALIZE ============================

local _, ns = ...
local GetTime = _G.GetTime
local UnitGUID = _G.UnitGUID
local L = ns.AceLocale:GetLocale("NAG")
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Lua / WoW API
local format = string.format

-- ============================ CONSTANTS ============================

-- Minimal spell ID references; prefer central data when available
-- These IDs are expansion-stable for classic to cata (existing module uses same)
local COLOSSUS_SMASH = 86346 -- Debuff
local SLAM = 1464            -- Slam
local OVERPOWER = 7384       -- Overpower
local MORTAL_STRIKE = 12294  -- Mortal Strike

-- Fallback CS window duration if aura duration is unavailable via messages
local CS_WINDOW_DURATION = 6.5

-- Minimal whitelist of GCD-consuming Arms spells relevant to this decision
local GCD_SPELLS = {
    [SLAM] = true,
    [OVERPOWER] = true,
    [MORTAL_STRIKE] = true,
}

-- ============================ DEFAULTS ============================

local defaults = {
    global = {
        enabled = true,
        debugLevel = ns.DEBUG_LEVELS.ERROR
    }
}

-- ============================ MODULE CREATION ============================

--- @class WarriorArmsCSWindow : CoreModule
--- @field state table Runtime CS window state
local WarriorArmsCSWindow = NAG:CreateModule("WarriorArmsCSWindow", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "WARRIOR",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    debugCategories = { ns.DEBUG_CATEGORIES.CLASS, ns.DEBUG_CATEGORIES.COMBAT },

    messageHandlers = {
        NAG_SPELL_CAST_SUCCEEDED = true,
    },
    eventHandlers = {
        PLAYER_TARGET_CHANGED = true,
    },
    cleuHandlers = {
        SPELL_AURA_APPLIED = "HandleCLEUColossusSmash",
        SPELL_AURA_REFRESH = "HandleCLEUColossusSmash",
        SPELL_AURA_REMOVED = "HandleCLEUColossusSmash",
    },

    -- Default runtime state
    defaultState = {
        active = false,
        targetGUID = nil,
        appliedAt = 0,
        expiresAt = 0,
        gcdIndex = 0,
        earlySlam = false,
        tfbZeroAtCS = false,
        playerGUID = nil,
    }
})


-- ============================ LIFECYCLE ============================

function WarriorArmsCSWindow:ModuleInitialize()
    -- Cache player GUID
    self.state.playerGUID = UnitGUID("player")
    self.state.playerClass = NAG.CLASS_FILENAME
    self.state.isWarrior = self.state.playerClass == "WARRIOR"
    self:Debug("WarriorArmsCSWindow initialized - player GUID: %s", self.state.playerGUID)
end

function WarriorArmsCSWindow:ModuleEnable()
    if not self.state.isWarrior then
        self:Debug("WarriorArmsCSWindow enabled on non-warrior - module remains inert")
        return
    end
    self:Debug("WarriorArmsCSWindow enabled - message-driven CS window tracking active")
end

function WarriorArmsCSWindow:ModuleDisable()
    self:Debug("WarriorArmsCSWindow disabled - clearing CS window state")
    self:ClearCSWindow()
end

-- ============================ MESSAGE HANDLERS ============================

--- Handle CLEU Colossus Smash auras directly
function WarriorArmsCSWindow:HandleCLEUColossusSmash(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, auraType, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if not self.state.isWarrior then return end

    local sub = subEvent
    if sub ~= "SPELL_AURA_APPLIED" and sub ~= "SPELL_AURA_REFRESH" and sub ~= "SPELL_AURA_REMOVED" then
        return
    end

    -- Only consider player-sourced CS
    if sourceGUID ~= self.state.playerGUID then
        return
    end

    if spellId ~= COLOSSUS_SMASH then
        return
    end

    local now = GetTime()

    if sub == "SPELL_AURA_APPLIED" or sub == "SPELL_AURA_REFRESH" then
        -- Start/reset CS window
        self.state.active = true
        self.state.targetGUID = destGUID
        self.state.appliedAt = now
        self.state.expiresAt = now + CS_WINDOW_DURATION
        self.state.gcdIndex = 0
        self.state.earlySlam = false
        -- New rule: if CS was cast while TFB (60503) was NOT active, force Slam override for this window
        local tfbActive = false
        if NAG and NAG.AuraIsActive then
            tfbActive = NAG:AuraIsActive(60503) == true
        end
        self.state.tfbZeroAtCS = not tfbActive

        self:Debug("CS window %s - target: %s, expires at: %.2f",
            (sub == "SPELL_AURA_REFRESH" and "refreshed" or "applied"),
            tostring(destGUID), self.state.expiresAt)
    elseif sub == "SPELL_AURA_REMOVED" then
        -- End window only if this is the tracked target
        if self.state.active and self.state.targetGUID == destGUID then
            self:Debug("CS window removed from target: %s", tostring(destGUID))
            self:ClearCSWindow()
        end
    end
end

--- Handle spell cast success messages
--- @param message string "NAG_SPELL_CAST_SUCCEEDED"
--- @param unit string Unit token
--- @param castGUID string Cast GUID
--- @param spellId number Spell ID
--- @param spellName string Spell name
function WarriorArmsCSWindow:NAG_SPELL_CAST_SUCCEEDED(message, unit, castGUID, spellId, spellName)
    if not self.state.isWarrior then return end
    if unit ~= "player" then return end
    if not self.state.active then return end

    local now = GetTime()
    if now > self.state.expiresAt then
        -- Defensive expiry on any relevant message receipt
        self:Debug("CS window expired during cast handling - clearing state")
        self:ClearCSWindow()
        return
    end

    if not GCD_SPELLS[spellId] then
        return
    end

    -- Increment GCD index and check early Slam condition
    self.state.gcdIndex = self.state.gcdIndex + 1
    if self.state.gcdIndex <= 2 and spellId == SLAM then
        self.state.earlySlam = true
        self:Debug("Early Slam detected on GCD #%d - Slam overrides Overpower for this CS window", self.state.gcdIndex)
    end
end

--- Handle target change event (migrated from StateManager)
--- @param event string The event name
--- @param newGuid string|nil New target GUID
function WarriorArmsCSWindow:PLAYER_TARGET_CHANGED(event, newGuid)
    if not self.state.isWarrior then return end
    if not self.state.active then return end

    local now = GetTime()
    if now > self.state.expiresAt then
        self:Debug("CS window expired on target change - clearing state")
        self:ClearCSWindow()
    end
end

-- ============================ STATE MANAGEMENT ============================

function WarriorArmsCSWindow:ClearCSWindow()
    self.state.active = false
    self.state.targetGUID = nil
    self.state.appliedAt = 0
    self.state.expiresAt = 0
    self.state.gcdIndex = 0
    self.state.earlySlam = false
    self.state.tfbZeroAtCS = false
end

-- ============================ PUBLIC API ============================

--- Is a CS window currently active (and not expired)?
--- @return boolean
function WarriorArmsCSWindow:IsCSWindowActive()
    if not self.state.active then
        return false
    end
    local now = GetTime()
    if now > self.state.expiresAt then
        self:ClearCSWindow()
        return false
    end
    return true
end

--- Was Slam cast in GCD #1 or #2 of the current CS window?
--- @return boolean
function WarriorArmsCSWindow:WasEarlySlamInThisCSWindow()
    if not self:IsCSWindowActive() then
        return false
    end
    return self.state.earlySlam
end

--- Should Slam override Overpower for the remainder of this CS window?
--- @return boolean
function WarriorArmsCSWindow:ShouldSlamOverride()
    return self:IsCSWindowActive() and (self.state.earlySlam or self.state.tfbZeroAtCS)
end

-- ============================ OPTIONS (DEV) ============================

--- Inject developer options into splash screen (dev-mode only)
--- @param options table
--- @param context table
--- @return table
function WarriorArmsCSWindow:splash(options, context)
    if not NAG:IsDevModeEnabled() then
        return options
    end

    if options.args and options.args.controlGroup and options.args.controlGroup.args then
        options.args.controlGroup.args.warriorArmsCSWindowDev = {
            type = "group",
            name = L["warriorArmsCSWindowDev"] or "Warrior Arms CS Window (Dev)",
            desc = L["warriorArmsCSWindowDevDesc"] or "Developer controls for Arms CS window tracking",
            order = 210,
            inline = true,
            args = {
                status = {
                    type = "description",
                    name = function()
                        if not self:IsCSWindowActive() then
                            return "|cffff0000CS Window: Inactive|r"
                        end
                        local remaining = self.state.expiresAt - GetTime()
                        local statusText = format("|cff00ff00CS Window: Active|r (%.1fs remaining)", remaining)
                        if self.state.earlySlam then
                            statusText = statusText .. " |cffff9900[SLAM OVERRIDE ACTIVE]|r"
                        end
                        return statusText
                    end,
                    order = 1,
                    width = "full",
                    fontSize = "medium"
                },
                gcdIndex = {
                    type = "description",
                    name = function()
                        if not self:IsCSWindowActive() then
                            return "GCD Index: N/A"
                        end
                        return format("GCD Index: %d", self.state.gcdIndex)
                    end,
                    order = 2,
                    width = "full",
                    fontSize = "medium"
                },
                targetInfo = {
                    type = "description",
                    name = function()
                        if not self:IsCSWindowActive() then
                            return "Target: N/A"
                        end
                        return format("Target: %s", self.state.targetGUID or "Unknown")
                    end,
                    order = 3,
                    width = "full",
                    fontSize = "medium"
                },
                clearWindow = {
                    type = "execute",
                    name = L["clearWindow"] or "Clear CS Window",
                    desc = L["clearWindowDesc"] or "Manually clear the current CS window state",
                    order = 4,
                    width = "full",
                    func = function()
                        self:ClearCSWindow()
                        self:Info("CS window manually cleared")
                        if ns.AceConfigRegistry then
                            ns.AceConfigRegistry:NotifyChange("NAG")
                        end
                    end
                }
            }
        }
    end

    return options
end

-- ============================ EXPORT ============================

ns.WarriorArmsCSWindow = WarriorArmsCSWindow
