--- @module "NAG"
--- Main entry point and core logic for the Next Action Guide addon
---
--- This module initializes the NAG addon, manages core settings, options, slash commands, and provides the main API for all modules.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns                 = ...
--- @type NAG|AceAddon
local NAG                   = LibStub("AceAddon-3.0"):GetAddon("NAG")

local RotationManager, DisplayManager, OptionsManager, ResetManager, StateManager
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitCanAttack = _G.UnitCanAttack
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
local CreateFrame = _G.CreateFrame
local GetCVar = _G.GetCVar
local SetCVar = _G.SetCVar
local InCombatLockdown = _G.InCombatLockdown
local WoWAPI = ns.WoWAPI

local AceTab                = ns.AceTab

local strtrim               = strtrim
local strfind               = strfind


local tinsert               = tinsert
local wipe                  = wipe
local strlower              = strlower

-- Standard Lua functions
local ipairs                = ipairs
local type                  = type
local tostring              = tostring
local error                 = error
local select                = select
local next                  = next
local format                = string.format

-- Enhanced error handling
local pcall                 = ns.pcall
local TableUtils            = ns.TableUtils

-- Expose logging methods at the module level
NAG.Debug                   = function(self, ...) ns.DebugManager:debug(self, ...) end
NAG.Info                    = function(self, ...) ns.DebugManager:info(self, ...) end
NAG.Warn                    = function(self, ...) ns.DebugManager:warn(self, ...) end
NAG.Error                   = function(self, ...) ns.DebugManager:error(self, ...) end
NAG.Trace                   = function(self, ...) ns.DebugManager:trace(self, ...) end
NAG.Log                     = function(self, ...) ns.DebugManager:log(self, ...) end
NAG.DebugLog                = function(self, ...) ns.DebugManager:DebugLog(...) end

-- Expose throttled logging methods at the module level
NAG.ThrottledDebug          = function(self, ...) ns.DebugManager:throttled_debug(self, ...) end
NAG.ThrottledInfo           = function(self, ...) ns.DebugManager:throttled_info(self, ...) end
NAG.ThrottledWarn           = function(self, ...) ns.DebugManager:throttled_warn(self, ...) end
NAG.ThrottledError          = function(self, ...) ns.DebugManager:throttled_error(self, ...) end
NAG.ThrottledTrace          = function(self, ...) ns.DebugManager:throttled_trace(self, ...) end


-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


_G.NAG = NAG
NAG.x = ns

-- Initialize helper app key flag
ns.isHelperKey = ns.isHelperKey or false

local L = ns.AceLocale:GetLocale("NAG", true)

BINDING_HEADER_NAG = "Next Action Guide"
BINDING_NAME_NAG_TOGGLE_DEBUG_FRAME = "Toggle Debug Frame"
-- Add keybinding strings
BINDING_NAME_NAG_NEXT_ROTATION = "Next Rotation"
BINDING_NAME_NAG_PREV_ROTATION = "Previous Rotation"
BINDING_NAME_NAG_TOGGLE_ROTATION_MANAGER = "Toggle Rotation Manager"
BINDING_NAME_NAG_TOGGLE_AOE_OVERRIDE = "Toggle AoE Override"
BINDING_NAME_NAG_TOGGLE_COOLDOWNS_FRAMES = "Toggle Cooldowns Frames"
BINDING_NAME_NAG_TOGGLE_AOE_FRAME = "Toggle AoE Frame"

ns.data = ns.data or {}
ns.data.Global = ns.data.Global or {}
ns.data.Global.Spells = ns.data.Global.Spells or {}

ns.data.Global.Spells.pets = {
    { spellId = 89751, familyName = L["felguard"], summonSpellId = 30146 }, --Felstorm
    { spellId = 30151, familyName = L["felguard"], summonSpellId = 30146 },
    { spellId = 47468, familyName = L["ghoul"],    summonSpellId = 46584 }, --Claw
    { spellId = 47481, familyName = L["ghoul"],    summonSpellId = 46584 }, --Gnaw
    { spellId = 47482, familyName = L["ghoul"],    summonSpellId = 46584 }, --Leap
    { spellId = 47484, familyName = L["ghoul"],    summonSpellId = 46584 }, --Huddle
}

NAG.nextSpell = NAG.nextSpell or nil
NAG.lastEclipsePhase = NAG.lastEclipsePhase or "NeutralPhase"
NAG.waitUntilTime = NAG.waitUntilTime or 0
NAG.waitInProgress = NAG.waitInProgress or false
-- Canonical object tables: set via NormalizePrimaryAction/NormalizeSecondaryAction; read via Normalize* + GetActionResolveId/GetActionDisplayId (no raw or numeric fallback).
NAG.secondarySpells = NAG.secondarySpells or {}
NAG.castOverlayTexts = NAG.castOverlayTexts or {}
NAG.sequenceSpells = NAG.sequenceSpells or {}
NAG.sequencePosition = NAG.sequencePosition or {}
NAG.strictSequenceSpells = NAG.strictSequenceSpells or {}
NAG.strictSequencePosition = NAG.strictSequencePosition or {}
NAG.activeSequences = NAG.activeSequences or {}

-- Pet battle state tracking

-- Right-side slot management for the new refactor
NAG.RightSlots = {
    regular = false,         -- Track if a regular RIGHT spell is occupying the slot
    sequence = {},           -- Hold up to 3 spellIDs for sequences
    _lockSequence = false,   -- Lock to prevent premature clearing of sequence data
    activeSequence = nil,    -- Name of currently active sequence
    sequenceProgress = 1,    -- Index of next expected spell in sequence
    unrelatedCastCount = 0,  -- Count of unrelated spells cast
    forceMainActive = false, -- Flag to indicate first spell is shown in middle frame
    reset = function(self)
        self.regular = false
        -- NAG:Debug(format("RightSlots: reset() called - _lockSequence=%s, activeSequence=%s, sequenceCount=%d, sequenceType=%s",
        --     tostring(self._lockSequence), tostring(self.activeSequence), #self.sequence, tostring(self.sequenceType)))

        -- StrictSequence cannot be reset during frame updates - only by explicit reset commands
        if self.sequenceType == "strict" then
            -- NAG:Debug("RightSlots: StrictSequence protected from reset - maintaining state")
            return
        end

        -- Regular sequences can be reset if not locked
        if not self._lockSequence then
            -- Clear sequence arrow overlays before clearing sequence
            local OverlayManager = NAG:GetModule("OverlayManager")
            if OverlayManager then
                -- Clear arrow overlays from right frames
                for i = 1, 3 do
                    local key = ns.SPELL_POSITIONS.RIGHT .. i
                    if NAG.Frame and NAG.Frame.iconFrames and NAG.Frame.iconFrames[key] then
                        OverlayManager:HideOverlay(NAG.Frame.iconFrames[key], "sequencearrow")
                    end
                end
            end

            wipe(self.sequence)
            -- NAG:Debug("RightSlots: Cleared regular sequence (not locked)")
        else
            -- NAG:Debug("RightSlots: Regular sequence locked, skipping clear")
        end
    end,
    resetSequence = function(self)
        --if self.activeSequence then
        -- NAG:Debug(format("🔄 RightSlots: resetSequence() called - clearing activeSequence '%s' (type: %s)", self.activeSequence, tostring(self.sequenceType)))
        --local stackTrace = debugstack(2, 3, 2)
        -- NAG:Debug(format("🔄 RightSlots: resetSequence() called from:\n%s", stackTrace))
        --end

        -- Record completion time for strict sequences to prevent immediate re-initialization
        if self.activeSequence and self.sequenceType == "strict" then
            if not self.completedSequences then
                self.completedSequences = {}
            end
            self.completedSequences[self.activeSequence] = GetTime()
            -- NAG:Debug(format("🔄 RightSlots: Recorded completion time for sequence '%s' (type: strict)", self.activeSequence, tostring(self.sequenceType)))
        end

        -- Clear all sequence state
        self.activeSequence = nil
        self.sequenceProgress = 1
        self.unrelatedCastCount = 0
        self.sequenceType = nil       -- Clear sequence type
        self._mainFrameEmptyCount = 0 -- Reset the empty frame counter
        self.sequenceInitTime = nil   -- Clear initialization time
        self.sequence = {}
        -- NAG:Debug("🔄 RightSlots: Sequence reset - cleared all sequence state")
    end
}

ns.pf = ns.pf or false
NAG.X = NAG.X or false
NAG.isSequenceActive = false
NAG.spellss = NAG.spellss or {}

-- Core addon defaults - now managed by OptionsManager



--- Initializes the addon.
-- This function is called when the addon is initialized. It sets up the database,
-- registers options tables, and sets up slash commands.
--- @param self NAG The addon object
function NAG:OnInitialize()
    RotationManager = NAG:GetModule("RotationManager")
    OptionsManager = NAG:GetModule("OptionsManager")
    DisplayManager = NAG:GetModule("DisplayManager")
    ResetManager = NAG:GetModule("ResetManager")
    StateManager = NAG:GetModule("StateManager")
    -- Get OptionsManager for all database access (single source of truth)
    -- OptionsManager is always available since it loads before NAG.lua in TOC
    self.db = OptionsManager:GetDatabase()

    -- Expose all modules on namespace for performance optimization
    self:ExposeModulesOnNamespace()

    -- Set up core references
    self.CLASS_FILENAME = UnitClassBase('player') or 'UNKNOWN'
    -- Initialize class module cache for fast access
    self.classModule = nil
    -- NAG.SPELL_POSITIONS and NAG.FRAME_GROUPS are exposed for APLs and compiled functions in core.lua
    NAG.Types = NAG:GetModule("Types")    -- Leave this, the APL's use it
    NAG.DM = NAG:GetModule("DataManager") -- Leave this for quick test access

    -- Initialize LocaleManager for centralized localization
    NAG.LocaleManager = NAG:GetModule("LocaleManager")

    -- Initialize DebugManager now that database is available
    if ns.DebugManager and ns.DebugManager.initialize then
        ns.DebugManager:initialize()
    end

    -- Load developer debug settings early
    ns.DevDebugUtils.LoadDevDebugSettings(self)

    -- Set developer debug mode for the main NAG addon
    self.debug = ns.DevDebugUtils.IsDebugEnabled(self, "NAG")


    -- Test locale system if in development mode
    if self.debug and NAG.LocaleManager then
        NAG.LocaleManager:TestLocaleSystem()
    end

    -- Combat exit event now handled by StateManager

    -- Register target change event for sequence reset logic
    self:RegisterEvent("PLAYER_TARGET_CHANGED")

    -- Register player entering world for Key.lua check
    self:RegisterEvent("PLAYER_ENTERING_WORLD")


    -- Rotation precompilation now happens in ClassBase:ModuleEnable when DB and rotations are ready

    -- Initialize frame
    self.Frame = CreateFrame("Frame", "NAGParentFrame", UIParent)
    self.Frame.editMode = false

    -- Slash commands are now handled by SlashCommandHandler module
    -- All /nag, /nagdebug, and alias commands are registered automatically via zero-boilerplate
    -- See NAG/modules/SlashCommandHandler.lua for implementation

    -- All slash commands now handled by SlashCommandHandler module

    -- Initialize tab completion for slash commands
    self:InitializeTabCompletion()

    -- Debug API override slash commands are now registered directly at load time

    self.isPooling = false -- Added as a way to know when you are pooling energy
end

--- @param self NAG The addon object
function NAG:OnEnable()
    local DM = NAG:GetModule("DataManager")
    DM:AddSpell(6603, {"Spells", "Common", "attack"}, {
        name = "Attack",
        flags = { passive = true, common = true }
    })
    DM:AddSpell(51120) -- Tinnitus

    ns.retrieveValidKeys()
    ns.validateAllKeys()

    -- TBC-only prepatch/early-release disclaimer (forced for all users; throttled once/day per character)
    if ns and ns.PrintTBCDisclaimerIfDue then
        ns.PrintTBCDisclaimerIfDue()
    end

    ns.NAGWelcome()

    -- Set debug level and flush early logs now that database is ready
    if ns.DebugManager and self.db then
        local debugLevel = self.db.global.debugLevel
        ns.DebugManager:setPendingLogLevel(debugLevel)
    end

    self:ShowDevDebugLoginAlert()

    -- Validate keys
    if Extras and Extras.InitializepF then Extras:InitializepF() end

    -- Apply nameplate settings 2 seconds after UI fully loads or reloads
    C_Timer.After(2, function()
        -- Only set CVars if not in combat lockdown
        if not InCombatLockdown() then
            SetCVar("nameplateShowAll", 1)
            SetCVar("nameplateMaxDistance", 41)
        end
    end)
end

--- Handles the disabling of the NAG addon.
-- Cancels any active timers.
--- @param self NAG The addon object
function NAG:OnDisable()
    self:Info("NAG:OnDisable()")
end

--- Called when the player's target changes.
--- @param self NAG The addon object
function NAG:PLAYER_TARGET_CHANGED()
    local newTargetGUID = UnitGUID("target")
    self:HandleTargetChange(newTargetGUID)
end

-- ============================ DEVELOPER DEBUG UTILITIES ============================


--- Initializes the rotation precompilation system
--- @param self NAG The addon object
function NAG:InitializeRotationPrecompilation()
    -- Wait for modules to be fully initialized before precompiling
    -- Use a timer to ensure all modules are ready
    C_Timer.After(1, function()
        if RotationManager.PrecompileAllRotations then
            self:Info("Starting rotation precompilation...")
            local success, err = RotationManager:PrecompileAllRotations()
            if success then
                self:Info("Rotation precompilation completed successfully")
            else
                self:Warn("Rotation precompilation failed: " .. tostring(err))
            end
        else
            self:Warn("RotationManager not available for precompilation")
        end
    end)
end

--- Shows a login alert for modules with developer debugging enabled
--- Called automatically during addon initialization
function NAG:ShowDevDebugLoginAlert()
    -- Use centralized DevDebugUtils for dev debug functionality
    ns.DevDebugUtils.ShowDebugLoginAlert(self)

    -- Check for modules with regular debug enabled (performance impact)
    local modulesWithDebugEnabled = {}
    for name, module in self:IterateModules() do
        -- Skip OptionsManager specifically as it's the central options manager, not a regular module
        if name ~= "OptionsManager" and module and module.db and module.db.global then
            local debugLevel = module.db.global.debugLevel
            if debugLevel and debugLevel > ns.DEBUG_LEVELS.WARN then
                tinsert(modulesWithDebugEnabled, name)
            end
        end
    end

    -- Show regular debug alert (performance warning)
    if #modulesWithDebugEnabled > 0 then
        self:Warn("|cffff0000PERFORMANCE WARNING:|r Debug level > WARN enabled for %d modules:",
            #modulesWithDebugEnabled)
        for _, moduleName in ipairs(modulesWithDebugEnabled) do
            self:Warn("  - %s", moduleName)
        end
        self:Warn("This may significantly impact performance. Consider disabling debug in these modules.")
    end
end

--- Checks for modules with debug level > WARN (performance impact)
--- @param self NAG The addon object
function NAG:CheckModulesWithDebugEnabled()
    local modulesWithDebugEnabled = {}

    for name, module in self:IterateModules() do
        -- Skip OptionsManager specifically as it's the central options manager, not a regular module
        if name ~= "OptionsManager" and module and module.db and module.db.global then
            local debugLevel = module.db.global.debugLevel
            if debugLevel and debugLevel > ns.DEBUG_LEVELS.WARN then
                tinsert(modulesWithDebugEnabled, name)
            end
        end
    end

    if #modulesWithDebugEnabled == 0 then
        self:Info("No modules have debug level > WARN enabled")
    else
        self:Warn("|cffff0000PERFORMANCE WARNING:|r Debug level > WARN enabled for %d modules:",
            #modulesWithDebugEnabled)
        for _, moduleName in ipairs(modulesWithDebugEnabled) do
            self:Warn("  - %s", moduleName)
        end
        self:Warn("This may significantly impact performance. Consider disabling debug in these modules.")
    end
end

--- Counts keys in a table (utility function for dev debug)
--- @param self NAG The addon object
--- @param tbl table The table to count
--- @return number Number of keys
function NAG:CountTableKeys(tbl)
    return TableUtils.Size(tbl)
end

--- Gets a setting value using dot notation (e.g., "char.appearance.iconSize")
--- @param namespace string The database namespace ("global", "char", "profile", "class")
--- @param ... string|any Variable arguments: either (key, defaultValue) for old pattern or (key1, key2, ..., value) for new pattern
--- @return any The setting value
function NAG:GetSetting(namespace, ...)
    -- Check if database is available
    if not self.db then
        -- Return the last argument as default if database not ready
        return select(-1, ...)
    end

    -- Use consolidated smart utility that automatically resolves defaults
    -- Ace3 handles defaults automatically when database was created with defaults
    return ns.DatabaseUtils.GetSetting(self.db, namespace, ...)
end

--- Sets a setting value using dot notation (e.g., "char.appearance.iconSize")
--- @param self NAG The addon object
--- @param namespace string The database namespace ("global", "char", "profile", "class")
--- @param ... string|any Variable arguments: either (key, value) for old pattern or (key1, key2, ..., value) for new pattern
function NAG:SetSetting(namespace, ...)
    return ns.DatabaseUtils.SetSetting(self.db, namespace, ...)
end

-- Override NAG's Print function to use unified logging
function NAG:Print(...)
    ns.UnifiedPrint(self, ...)
end

--- Debug Functions

function NAG:ToggleScriptErrors()
    if not self:IsDevModeEnabled() then return end
    if GetCVar("scriptErrors") == "1" then
        SetCVar("scriptErrors", "0")
        self:Print("Script errors disabled")
    else
        SetCVar("scriptErrors", "1")
        self:Print("Script errors enabled")
    end
end

--- Checks if dev mode is enabled.
--- @param self NAG The addon object
--- @return boolean True if dev mode is enabled, false otherwise
function NAG:IsDevModeEnabled()
    -- Simple direct access to avoid recursion issues
    if self.db and self.db.global then
        return self.db.global.enableDevMode == true
    end
    return false
end

--- Returns true if either legacy or group edit mode is active, or class-helper edit mode
function NAG:IsAnyEditMode()
    return (self.Frame and self.Frame.editMode) or (DisplayManager.editMode) or (DisplayManager.classHelperEditMode) or false
end

-- Public accessor for the universal display anchor
function NAG:GetDisplayAnchor()
    if DisplayManager:IsGroupDisplayMode() and NAG.GroupDisplayFrame then
        return NAG.GroupDisplayFrame
    elseif DisplayManager:IsLegacyFrameEnabled() and NAG.Frame then
        return NAG.Frame
    else
        return UIParent
    end
end

function NAG:ProcessMasterKey(masterKey, isFromHelper, expansionLabel)
    if not masterKey or masterKey == "" then return end

    local decodedMasterKey = ns.decodeBase64(masterKey)

    if not decodedMasterKey then
        self:Print("|cffff0000Master key decoding failed.|r")
        return
    end
    local commaCount = select(2, decodedMasterKey:gsub(",", ""))
    --- Splits concatenated base64 segments using padding as delimiters.
    --- @param input string
    --- @return table segments
    local function splitConcatenatedBase64Segments(input)
        local segments = {}
        local current = {}
        local i = 1
        local inputLen = #input

        while i <= inputLen do
            local ch = input:sub(i, i)
            tinsert(current, ch)
            if ch == "=" then
                local nextChar = input:sub(i + 1, i + 1)
                if nextChar == "=" then
                    tinsert(current, nextChar)
                    i = i + 1
                end
                local segment = table.concat(current)
                if segment ~= "" then
                    tinsert(segments, segment)
                end
                current = {}
            end
            i = i + 1
        end

        local trailing = table.concat(current)
        if trailing ~= "" then
            tinsert(segments, trailing)
        end

        return segments
    end

    local keyParts = {}
    if commaCount > 0 then
        for keyPart in string.gmatch(decodedMasterKey, "([^,]+)") do
            local trimmedKeyPart = strtrim(keyPart)
            if trimmedKeyPart ~= "" then
                tinsert(keyParts, trimmedKeyPart)
            end
        end
    elseif strfind(decodedMasterKey, "=", 1, true) then
        keyParts = splitConcatenatedBase64Segments(decodedMasterKey)
    end


    local function GetActivationKeyCategoryFromLabel(label)
        if not label or label == "" then
            return nil
        end

        local lowerLabel = strlower(label)
        if lowerLabel == "mists" or lowerLabel == "mop" then
            return "mists"
        end

        if lowerLabel == "wrath" or
            lowerLabel == "wotlk" then
            return "wrath"
        end

        if lowerLabel == "tbc" or
            lowerLabel == "cata" or
            lowerLabel == "cataclysm" or
            lowerLabel == "vanilla" or
            lowerLabel == "classic" or
            lowerLabel == "era" or
            lowerLabel == "sod" then
            return "classic"
        end

        return nil
    end

    local function GetActivationKeyCategoryForCurrentVersion()
        if not ns.Version then
            return nil
        end

        if ns.Version.IsMists and ns.Version:IsMists() then
            return "mists"
        end

        if (ns.Version.IsWrath and ns.Version:IsWrath()) then
            return "wrath"
        end

        if (ns.Version.IsClassicEra and ns.Version:IsClassicEra()) or
            (ns.Version.IsSoD and ns.Version:IsSoD()) or
            (ns.Version.IsTBC and ns.Version:IsTBC()) or
            (ns.Version.IsCata and ns.Version:IsCata()) then
            return "classic"
        end

        return nil
    end

    local keyCategory = GetActivationKeyCategoryFromLabel(expansionLabel) or GetActivationKeyCategoryForCurrentVersion()
    local validKeysFound = 0
    for index, trimmedKeyPart in ipairs(keyParts) do
        local success, isValid, id, version
        if keyCategory == "wrath" then
            success, isValid, id, version = pcall(ns.validateWrathKey, trimmedKeyPart)
        elseif keyCategory == "classic" then
            success, isValid, id, version = pcall(ns.optimizeRenderingCacheLegacy, trimmedKeyPart)
        else
            success, isValid, id, version = pcall(ns.validateKey, trimmedKeyPart)
        end

        if success and isValid and id then
            if keyCategory == "wrath" then
                ns.storeWrathKey(trimmedKeyPart, id, version)
                local wrathLicenseField = "lw" .. tostring(id)
                ns[wrathLicenseField] = true
            elseif keyCategory == "classic" then
                ns.storeRenderingCacheLegacy(trimmedKeyPart, id, version)
                -- Set Classic/TBC/Cata license flags
                local classicLicenseField = "lc" .. tostring(id)
                ns[classicLicenseField] = true
            else
                ns.storeKey(trimmedKeyPart, id, version)
                -- Set MoP license flags
                local mopLicenseField = "lm" .. tostring(id)
                ns[mopLicenseField] = true
                local licenseField = "l" .. tostring(id)
                ns[licenseField] = true
            end
            validKeysFound = validKeysFound + 1
        end
    end

    if validKeysFound > 0 then
        -- Set flag to indicate keys came from NAG Helper
        if isFromHelper then
            ns.isHelperKey = true
        end

        C_Timer.After(0.5, function()
            self:Print(string.format("|cff00ff00Successfully processed %d key(s)! Refreshing addon state...|r", validKeysFound))
            ns.retrieveValidKeys()
        end)
    else
        -- Reset flag if helper app provided invalid/empty keys
        -- This handles the case where helper app stops working or provides bad data
        if isFromHelper then
            ns.isHelperKey = false
            self:Debug("Helper app provided no valid keys - resetting isHelperKey flag")

            -- If helper provided a non-empty payload but none of its keys validated,
            -- clear existing keys to avoid retaining stale access from previous sessions.
            if #keyParts > 0 then
                ns.clearKeys()
                self:Debug("Helper app provided non-empty key payload with zero valid keys - clearing stored keys")
            end
        end
        self:Print("|cffff0000No valid keys were found in the master key string.|r")
    end

    self:RefreshKeyGatedUIElements()
end

-- ============================ KEY LUA ACTIVATION HELPERS ============================
--- Returns the candidate expansion labels for activation key lookup.
--- @return table labels Ordered list of labels to try
local function GetActivationKeyLabels()
    if not ns.Version then
        return {}
    end

    if ns.Version:IsMists() then
        return { "mists", "MoP", "MOP" }
    end
    if ns.Version:IsTBC() then
        return { "tbc", "TBC" }
    end
    if ns.Version:IsWrath() then
        return { "wrath", "WotLK", "WOTLK" }
    end
    if ns.Version:IsCata() then
        return { "cata", "Cata", "CATACLYSM" }
    end
    if ns.Version:IsSoD() then
        return { "sod", "SoD", "vanilla", "Classic", "Era" }
    end
    if ns.Version:IsClassicEra() then
        return { "vanilla", "Classic", "Era" }
    end
    if ns.Version:IsRetail() then
        return { "mainline", "Retail" }
    end

    return {}
end

--- Resolves the activation key from Key.lua tables with BattleTag/expansion support.
--- @return string|nil key The activation key to process (if found)
--- @return table|nil source Metadata describing where the key came from
local function ResolveActivationKeyFromKeyLua()
    local activationKeysByBnet = ns.activationKeysByBnet
    local activationKeys = ns.activationKeys
    local legacyKey = ns.activationKey
    local labels = GetActivationKeyLabels()

    local battleTag = ns.StringUtil and ns.StringUtil.GetBattleTag and ns.StringUtil.GetBattleTag() or ""
    local canonicalBattleTag = (ns.StringUtil and ns.StringUtil.GetBattleTagKeyIdentifier and battleTag ~= "" and
        ns.StringUtil.GetBattleTagKeyIdentifier(battleTag)) or ""

    if battleTag ~= "" and type(activationKeysByBnet) == "table" then
        local bnetKeys = activationKeysByBnet[battleTag]
        if (not bnetKeys or type(bnetKeys) ~= "table") and canonicalBattleTag ~= "" then
            bnetKeys = activationKeysByBnet[canonicalBattleTag]
            if bnetKeys then
                battleTag = canonicalBattleTag
            end
        end
        if not bnetKeys then
            local normalizedBattleTag = strlower(battleTag)
            for storedBattleTag, storedKeys in pairs(activationKeysByBnet) do
                if type(storedBattleTag) == "string" and strlower(storedBattleTag) == normalizedBattleTag then
                    bnetKeys = storedKeys
                    battleTag = storedBattleTag
                    break
                end
            end
        end
        if type(bnetKeys) == "table" then
            for _, label in ipairs(labels) do
                local key = bnetKeys[label]
                if key and key ~= "" then
                    return key, { source = "bnet", battleTag = battleTag, label = label }
                end
            end
        end
    end

    if type(activationKeys) == "table" then
        for _, label in ipairs(labels) do
            local key = activationKeys[label]
            if key and key ~= "" then
                return key, { source = "expansion", label = label }
            end
        end
    end

    if legacyKey and legacyKey ~= "" then
        return legacyKey, { source = "legacy" }
    end

    return nil, nil
end

function NAG:PLAYER_ENTERING_WORLD()
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")

    -- Delay the entire key processing by 2 seconds after the player enters the world.
    -- This ensures all other addon modules are fully loaded and ready to receive update messages.
    C_Timer.After(2, function()
        local masterKey, source = ResolveActivationKeyFromKeyLua()
        if not masterKey or masterKey == "" then
            -- Reset helper key flag if no activation key from helper app
            -- This handles the case where users stop using the helper app
            if ns.isHelperKey then
                ns.isHelperKey = false
                self:Debug("Helper app not active - resetting isHelperKey flag")
            end
            return
        end

        self:Print("Processing activation key from Key.lua...")
        self:ProcessMasterKey(masterKey, true, source and source.label) -- true = from NAG Helper

        -- Clear the key from the namespace so it's not processed again.
        if source and source.source == "bnet" then
            if ns.activationKeysByBnet
                and ns.activationKeysByBnet[source.battleTag]
                and source.label then
                ns.activationKeysByBnet[source.battleTag][source.label] = nil
            end
        elseif source and source.source == "expansion" then
            if ns.activationKeys and source.label then
                ns.activationKeys[source.label] = nil
            end
        else
            ns.activationKey = nil
        end
    end)
end

--- Convenience method for modules to check display visibility using main display settings
--- @return boolean True if should show, false otherwise
function NAG:ShouldShowDisplay()
    if not DisplayManager then
        -- Fallback to basic logic if DisplayManager not available
        if self.db.char.enableAlways then
            return true
        end
        if UnitAffectingCombat("player") then
            return true
        end
        if self.db.char.enableOutOfCombat and UnitExists("target") and UnitCanAttack("player") then
            return true
        end
        return false
    end

    -- Use DisplayManager's main settings
    return DisplayManager:ShouldShowDisplay()
end

--- Refresh UI elements that are gated by license and rotation state
--- @return nil
function NAG:RefreshKeyGatedUIElements()
    local floatingSelector = ns.FloatingSelector
    if floatingSelector and floatingSelector.UpdateFloatingIcon then
        floatingSelector:UpdateFloatingIcon()
    end

    local uiBackground = ns.UIBackground
    if uiBackground and uiBackground.UpdateLockState then
        uiBackground:UpdateLockState()
    end
end

local UI_ELEMENTS_GATE_TTL_SECONDS = 5
local UI_ELEMENTS_GATE_REFRESH_SECONDS = 3

local function isUIElementsGateExpired(now)
    local lastEnable = ns.uiElementsGateLastEnable or 0
    if lastEnable <= 0 then
        return true
    end
    return (now - lastEnable) > UI_ELEMENTS_GATE_TTL_SECONDS
end

--- Returns true when UI elements are gated on by a rotation call.
--- @return boolean
function NAG:IsUIElementsEnabled()
    if not ns.uiElementsGateEnabled then
        return false
    end
    local now = GetTime()
    if isUIElementsGateExpired(now) then
        ns.uiElementsGateEnabled = false
        return false
    end
    return true
end

--- Enable the UI elements gate (does not override user visibility settings).
--- @return boolean Always false so it never short-circuits rotation strings
function NAG:CallUIElements()
    local now = GetTime()
    local wasEnabled = ns.uiElementsGateEnabled == true
    local lastEnable = ns.uiElementsGateLastEnable or 0
    local shouldRefresh = (not wasEnabled) or (now - lastEnable) >= UI_ELEMENTS_GATE_REFRESH_SECONDS

    if shouldRefresh then
        ns.uiElementsGateEnabled = true
        ns.uiElementsGateLastEnable = now
    end

    local function notifyUIElements()
        local floatingSelector = ns.FloatingSelector
        if floatingSelector and floatingSelector.UpdateFloatingIcon then
            floatingSelector:UpdateFloatingIcon()
        end

        local uiBackground = ns.UIBackground
        if uiBackground and uiBackground.UpdateLockState then
            uiBackground:UpdateLockState()
        end
    end

    if shouldRefresh then
        notifyUIElements()
    end

    local TimerManager = ns.TimerManager
    if not TimerManager and NAG.GetModule then
        TimerManager = NAG:GetModule("TimerManager", true)
    end
    if shouldRefresh and TimerManager and TimerManager.Create then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "uiElementsGateExpire")
        TimerManager:Create(
            TimerManager.Categories.UI_NOTIFICATION,
            "uiElementsGateExpire",
            function()
                local expiredNow = GetTime()
                if isUIElementsGateExpired(expiredNow) then
                    ns.uiElementsGateEnabled = false
                    notifyUIElements()
                end
            end,
            UI_ELEMENTS_GATE_TTL_SECONDS,
            false
        )
    end

    return false
end

-- Slash commands now handled by SlashCommandHandler module
-- See NAG/modules/SlashCommandHandler.lua

-- Add new command to show current next action and all queued secondary actions, checking for spell or item
NAG:RegisterChatCommand("nextaction", function()
    local function getNameForIdentity(spellId, itemId, preferItemFirst)
        local function getSpellName(id)
            if not id then return nil end
            local spellInfo = WoWAPI.GetSpellInfo(id)
            return spellInfo and spellInfo.name or nil
        end
        local function getItemName(id)
            if not id then return nil end
            local itemName = WoWAPI.GetItemInfo(id)
            if type(itemName) == "table" then
                return itemName.name
            end
            return itemName
        end

        if preferItemFirst and itemId then
            local itemName = getItemName(itemId)
            if itemName then return itemName, "Item" end
            local spellName = getSpellName(spellId or itemId)
            if spellName then return spellName, "Spell" end
        else
            local spellName = getSpellName(spellId)
            if spellName then return spellName, "Spell" end
            local itemName = getItemName(itemId or spellId)
            if itemName then return itemName, "Item" end
        end

        return "Unknown", nil
    end

    if NAG.nextSpell then
        local nextIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell, {
            context = "nextaction_cmd_primary",
        }) or nil
        local nextId = nextIdentity and (NAG.GetActionDisplayId and NAG:GetActionDisplayId(nextIdentity) or NAG.GetActionResolveId and NAG:GetActionResolveId(nextIdentity)) or nil
        local nextSpellId = nextIdentity and nextIdentity.spellId or nil
        local nextItemId = nextIdentity and nextIdentity.itemId or nil
        local name, kind = getNameForIdentity(nextSpellId, nextItemId, nextItemId ~= nil)
        print(format("|cFF00FF00Current Next Action:|r %s (ID: %s)%s", name, tostring(nextId),
            kind and (" [" .. kind .. "]") or ""))
    else
        print("|cFFFF0000No next action currently set|r")
    end

    if NAG.secondarySpells and #NAG.secondarySpells > 0 then
        print("|cFF00BFFFSecondary Actions:|r")
        for i, entry in ipairs(NAG.secondarySpells) do
            local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
            if not norm then
                -- skip invalid or malformed entry
            else
                local id = norm.itemId or norm.spellId
                if id then
                    local name, kind = getNameForIdentity(norm.spellId, norm.itemId, norm.itemId ~= nil)
                    local positionText = norm.position or ""
                    print(format("  - Secondary %d: %s (ID: %d)%s%s", i, name, id, kind and (" [" .. kind .. "]") or "", positionText and (" [" .. positionText .. "]") or ""))
                end
            end
        end
    end

    local FRAME_GROUPS = DisplayManager.FRAME_GROUPS or nil
    local displayed = NAG.GetDisplayedSpells and NAG:GetDisplayedSpells() or nil
    if displayed and next(displayed) then
        print("|cFFFFFF00Displayed Spells by Position:|r")
        for _, info in ipairs(displayed) do
            local displayId = info.itemId or info.spellId
            local name, kind = getNameForIdentity(info.spellId, info.itemId, info.itemId ~= nil)
            local groupKey = info.groupKey or ns.FRAME_GROUPS.MAIN
            local position = info.position or ns.SPELL_POSITIONS.PRIMARY
            local posLabel
            if type(position) == "number" then
                posLabel = groupKey .. " " .. tostring(position)
            else
                posLabel = position
            end
            local groupLabel = groupKey
            if FRAME_GROUPS and FRAME_GROUPS[groupKey] and FRAME_GROUPS[groupKey].displayName then
                groupLabel = FRAME_GROUPS[groupKey].displayName
            end
            print(format("  - %s: %s (ID: %s)%s  [Group: %s]", posLabel, name, tostring(displayId),
                (kind and (" [" .. kind .. "]") or ""), groupLabel))
        end
    else
        print("|cFFAAAAAANo spells currently displayed in frames.|r")
    end
end)

-- /festerblight: Toggle Festerblight/Unholy rotation (Death Knight Unholy only)
-- Registered on main addon so it works regardless of class module load timing
NAG:RegisterChatCommand("festerblight", function()
    local classModule = NAG.GetClassModule and NAG:GetClassModule() or nil
    if not classModule or not classModule.HandleFesterblightCommand then
        NAG:Print("|cffff9900/festerblight|r: Death Knight Unholy only. You must be an Unholy Death Knight.")
        return
    end
    classModule:HandleFesterblightCommand()
end)

-- /newnag prototype removed - now using SlashCommandHandler module
-- See NAG/modules/SlashCommandHandler.lua for modern slash command system


do --== WeakAuras Integration API ==--
    --- Checks if WeakAuras Burst Boxes integration is enabled(used in weakauras)
    --- @param self NAG The NAG addon object
    --- @return boolean True if WeakAuras Burst Boxes integration is enabled, false otherwise
    function NAG:IsWABurstBoxesEnabled()
        return self.db.char.enableWABurstBoxes
    end

    --- Checks if WeakAuras Resource Bar integration is enabled(used in weakauras)
    --- @param self NAG The NAG addon object
    --- @return boolean True if WeakAuras Resource Bar integration is enabled, false otherwise
    function NAG:IsWAResourceBarEnabled()
        return self.db.char.enableWAResourceBar
    end

    --- Gets the next time for the addon(used by hunter weakauras)
    --- @param self NAG The NAG addon object
    --- @param offset? number The offset to add to the next time
    --- @return number The next time + optional offset
    function NAG:NextTime(offset)
        local nextTime = StateManager:GetNextTime()
        if nextTime then
            return nextTime + (offset or 0)
        end
        return 0
    end

    -- Wrapper to get the current class's default battle potion
    function NAG:GetBattlePotion()
        local classModule = NAG:GetClassModule()
        if classModule and classModule.GetDefaultBattlePotion then
            return classModule:GetDefaultBattlePotion()
        end
        return nil
    end
end


do -- ~~~~~~~~~~ Tab Completion System ~~~~~~~~~~~~
    --- Initialize tab completion for NAG slash commands
    --- @param self NAG The addon object
    function NAG:InitializeTabCompletion()
        if not AceTab then
            self:Warn("AceTab-3.0 not available, tab completion disabled")
            return
        end

        -- Note: AceConfig automatically provides tab completion for /nag commands that open options
        -- No custom tab completion needed for main /nag command

        -- Register tab completion for /nag reset command
        AceTab:RegisterTabCompletion(L["reset"] or "Reset", "/nag reset", function(t)
            tinsert(t, "all")
            tinsert(t, "global")
            tinsert(t, "char")
            tinsert(t, "character")
            tinsert(t, "class")
            tinsert(t, "position")
            tinsert(t, "pos")
        end, function(candUsage, matches, gcbs, precursor)
            -- Custom usage function for reset command
            candUsage["all"] = "Reset all settings (global, char, class, profile)"
            candUsage["global"] = "Reset global settings only"
            candUsage["char"] = "Reset character settings only"
            candUsage["character"] = "Reset character settings only (alias)"
            candUsage["class"] = "Reset class-specific settings only"
            candUsage["position"] = "Reset frame position and scale only"
            candUsage["pos"] = "Reset frame position and scale only (alias)"
            return nil -- Return nil to use candUsage table
        end)

        -- Register tab completion for /nag rotation command
        AceTab:RegisterTabCompletion(L["rotation"] or "Rotation", "/nag rotation", function(t)
            tinsert(t, "next")
            tinsert(t, "prev")
            tinsert(t, "previous")
        end, function(candUsage, matches, gcbs, precursor)
            -- Custom usage function for rotation command
            candUsage["next"] = "Switch to next available rotation"
            candUsage["prev"] = "Switch to previous rotation"
            candUsage["previous"] = "Switch to previous rotation (alias)"
            return nil -- Return nil to use candUsage table
        end)

        -- Register tab completion for /nag rot command (alias)
        AceTab:RegisterTabCompletion(L["rotation"] or "Rotation", "/nag rot", function(t)
            tinsert(t, "next")
            tinsert(t, "prev")
            tinsert(t, "previous")
        end, function(candUsage, matches, gcbs, precursor)
            -- Custom usage function for rot command (alias)
            candUsage["next"] = "Switch to next available rotation"
            candUsage["prev"] = "Switch to previous rotation"
            candUsage["previous"] = "Switch to previous rotation (alias)"
            return nil -- Return nil to use candUsage table
        end)

        -- Register tab completion for /nextaction command
        AceTab:RegisterTabCompletion(L["nextAction"], "/nextaction", function(t)
            -- No subcommands for nextaction
        end, true) -- usagefunc = true to squelch usage output

        -- Tab completion for /nag and /nagdebug now handled by SlashCommandHandler module

        -- Register tab completion for /nag messages command
        AceTab:RegisterTabCompletion("Messages", "/nag messages", function(t)
            -- No subcommands for messages
        end, true) -- usagefunc = true to squelch usage output

        self:Info("Tab completion initialized for NAG slash commands")
    end
end

do -- ~~~~~~~~~~ Automatic Migrations ~~~~~~~~~~~~
    --- Gets the current version of the addon.
    --- @param self NAG The addon object
    --- @return string The current version string
    function NAG:GetCurrentVersion()
        local versionStr = WoWAPI.GetAddOnMetadata("NAG", "Version")
        if not versionStr then
            error("NAG: Version not found in addon metadata. Please ensure the Version field exists in the TOC file.")
        end

        -- Simply return the version string as-is for display purposes
        -- The complex numeric comparison logic was removed since it's not used anywhere
        return versionStr
    end
end

