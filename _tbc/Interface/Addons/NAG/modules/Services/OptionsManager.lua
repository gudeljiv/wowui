--- @module "NAG.OptionsManager"
--- Centralized Ace3 options management for NAG addon
---
--- Handles all options registration, category group creation, and lifecycle for the Next Action Guide addon.
---
--- DATABASE ARCHITECTURE:
--- OptionsManager owns the centralized NAG.db database which contains:
--- - Global settings (debug levels, dev mode, addon-wide preferences)
--- - Cross-module character settings (WeakAuras integration, autocast settings)
--- - Cross-module class settings (display preferences)
---
--- Module-specific data (rotations, customRotations, selectedRotations) is owned by
--- individual modules (e.g., ClassBase.lua) and accessed through their GetSetting/SetSetting methods.
---
--- This hybrid approach provides centralized configuration for addon-wide settings while
--- maintaining proper data ownership and module isolation.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
--- Discord: https://discord.gg/ebonhold
--
-- NOTE: This is a service/manager module and should NOT inherit from CoreModule.
-- It is created as a plain Ace3 module using NAG:NewModule("OptionsManager", {})


-- ============================ LOCALIZE ============================

local _, ns = ...
local WoWAPI = ns.WoWAPI
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- WoW APIs
local StaticPopupDialogs = _G.StaticPopupDialogs
local StaticPopup_Show = _G.StaticPopup_Show
local StaticPopup_OnClick = _G.StaticPopup_OnClick
local YES = _G.YES
local NO = _G.NO
local ACCEPT = _G.ACCEPT
local CANCEL = _G.CANCEL
local CLOSE = _G.CLOSE
local OKAY = _G.OKAY
local ReloadUI = _G.ReloadUI

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type DisplayManager
--- @type ResetManager
--- @type OptionsFactory
local DisplayManager, ResetManager, OptionsFactory, KeybindManager


local AceConfigDialog = ns.AceConfigDialog
local AceConfigRegistry = ns.AceConfigRegistry
local AceDBOptions = ns.AceDBOptions
local AceDB = ns.AceDB
local L = ns.AceLocale:GetLocale("NAG", true)
local AceGUI = ns.AceGUI

ns.OptionsFactory = OptionsFactory
-- Namespace tables (static, no lifecycle management needed)
local Version = ns.Version
local TableUtils = ns.TableUtils

local tinsert = tinsert
local wipe = wipe
local pairs = pairs
local type = type
local format = string.format
local sort = table.sort
local strfind = strfind

-- Enhanced error handling
local pcall = ns.pcall

local OPTIONS_NOTIFY_DEBOUNCE_SEC = 0.12
local OPTIONS_BUILD_WARN_THRESHOLD_SEC = 0.03
local OPTIONS_BUILD_LOG_EVERY = 25

-- ============================ DATABASE ARCHITECTURE ============================
--
-- NAG uses a hybrid database architecture:
--
-- 1. CENTRALIZED DATABASE (NAG.db) - Owned by OptionsManager
--    - Contains: Global settings, cross-module settings, legacy data
--    - Purpose: Settings that affect the entire addon or multiple modules
--
-- 2. MODULE NAMESPACES - Owned by individual modules
--    - Contains: Module-specific settings, module data
--    - Access: self:GetSetting("namespace", "key")
--    - Purpose: Settings and data owned by specific modules
--
-- 3. SHARED DATA - Owned by specific modules but accessible to others
--    - Contains: Cross-module data like rotations, customRotations, selectedRotations
--    - Access: Through owning module's GetSetting/SetSetting methods
--    - Purpose: Data that modules need to share but one module owns
--
-- This hybrid approach provides:
-- - Centralized configuration for addon-wide settings
-- - Module isolation for module-specific data
-- - Shared access to cross-module data through proper ownership
-- - Backward compatibility for existing code
--
-- ============================ DEFAULTS ============================

-- Proper Ace3 defaults structure with all namespaces
-- Note: Module-specific data (rotations, customRotations, selectedRotations)
-- is owned by ClassBase.lua and should not be defined here
local defaults = {
    global = {
        combatMetricsBaseline = false, -- Combat analytics baseline setting

        -- Rotation bundle inbox (parallel import system)
        -- Stores bulk-delivered rotation import strings until the matching class logs in and consumes them.
        -- NOTE: This is intentionally global so one paste can distribute rotations to alts.
        rotationBundleInbox = {},

        keys = {
            legacy = {
                current = {},    -- Fresh keys using original validation (MoP)
                old = {}         -- Legacy keys identified for stealth mode (MoP)
            },
            current = {},        -- New format keys (MoP)
            keysMigrated = false, -- Flag to track if keys have been migrated
            classic = {
                legacy = {
                    current = {}, -- Classic/TBC keys using 'b' suffix validation
                    old = {}      -- Legacy Classic keys (if needed)
                },
                current = {}      -- New format Classic keys
            },
            wrath = {
                legacy = {
                    current = {}, -- Wrath keys using 'w' suffix validation
                    old = {}      -- Legacy Wrath keys (if needed)
                },
                current = {}      -- New format Wrath keys
            }
        },
        UpDLETddvrsC = "0.0.0",
        lastSentSpam = nil,
        feedbackQueue = {},
        -- Core global settings
        enableWelcome = true, -- Enable welcome message
        inputDelay = .100,

        enableEncounterTimer = false, -- Enable encounter timer
        encounterDuration = 180,      -- Encounter duration in seconds (default 3 minutes)

        -- Version tracking
        version = nil,
        -- Debug settings
        enableDevMode = false,              -- Enable dev mode
        debugLevel = ns.DEBUG_LEVELS.ERROR, -- Debug level (0-5)
        debugOutputChannel = 1,             -- Chat frame for debug output (1 = default, 2–10 = ChatFrame2–10)

    },
    char = {
        -- Character-specific settings that are NOT module-specific
        -- Note: Module-specific settings (rotations, customRotations, selectedRotations)
        -- are owned by ClassBase.lua and accessed through module methods

        enableBuffSuggestions = false,
        enableDebuffSuggestions = false,
        buffSuggestionThreshold = 50,

        -- Display settings
        showKeybinds = true, -- Show keybind text on main display frames

        -- WeakAuras integration (these are used by multiple modules)
        enableWAResourceBar = true,
        enableWABurstBoxes = true,

          -- Shows spells queued with NAG:CastQueue(spell1, spell2, spell3)
        -- APL authors can explicitly specify spell sequences for display
        predictionQueue = {
            enabled = false,          -- Disabled by default; enable via DevMode toggle
            numPredictions = 2,       -- Number of prediction spells (1-3)
            spacing = 2,              -- Mellanrum mellan frames
            direction = "RIGHT",      -- Riktning: RIGHT, LEFT, UP, DOWN

            -- Per-frame storlek (kan skilja från main icon)
            frameWidth = 44,
            frameHeight = 44,

            -- Styling för queue frames
            showBorders = true,
            showKeybinds = true,
            alpha = 0.9,

            -- Debug logging
            debug = true              -- Enable detailed prediction debug output
        },
    },
    class = {
        -- Class-specific settings that are NOT module-specific
        -- Note: Module-specific data (rotations, customRotations) is owned by ClassBase.lua
        -- and should be accessed through ClassBase:GetSetting() methods

        display = {
            enabled = true,
        },
        -- Class-specific module settings can be added here if needed
        -- but should not duplicate data owned by other modules
    },
}

-- Create as a plain Ace3 module (not CoreModule)
--- @class OptionsManager
local OptionsManager = NAG:NewModule("OptionsManager", {})
local module = OptionsManager
ns.OptionsManager = OptionsManager

-- Store defaults explicitly since NewModule doesn't handle defaults like CreateModule does
OptionsManager.defaults = defaults

--- global access to the OptionsManager module


-- Store the database instance locally
OptionsManager.db = nil

-- ============================ CONTENT ============================

-- Dialog definitions (license/key flows)
StaticPopupDialogs["NAG_ENTER_KEY"] = {
    text = L["enterKeyPrompt"] or "Enter your license key:",
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = true,
    editBoxWidth = 300,
    maxLetters = 0,
    enterClicksFirstButton = true,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(1000)
        local editBox = dialog:GetEditBox()
        if editBox then
            editBox:SetText("")
            editBox:SetFocus()
        end
    end,
    EditBoxOnEnterPressed = function(dialog)
        StaticPopup_OnClick(dialog:GetParent(), 1)
    end,
    OnAccept = function(dialog)
        local editBox = dialog:GetEditBox()
        if not editBox then return end
        local inputValue = editBox:GetText()
        if not inputValue or inputValue == "" then
            NAG:Error("No key entered")
            return
        end

        ns.isHelperKey = false

        ns.clearKeys()
        local decodedKeys = ns.splitDecodedString(inputValue)
        if not decodedKeys then
            NAG:Error("Failed to decode key")
            return
        end

        ns.processKeys(decodedKeys)
		print("Processed keys, now validating...", #decodedKeys) -- Debug print
        local validKeys = ns.retrieveValidKeys()
        if #validKeys == 0 then
            NAG:Error("Invalid key")
            return
        end

        if Version then
            local keyExpansion = nil
            if #validKeys > 0 then
                keyExpansion = ns.identifyProfileCategory(validKeys[1])
            end

            if keyExpansion then
                local currentGameType = Version:GetGameType() or "unknown"
                local isValidExpansion = false
                local expansionName = ""

                if keyExpansion == "mists" then
                    expansionName = "Mists of Pandaria Classic"
                    if Version.IsMists and Version:IsMists() then
                        isValidExpansion = true
                    end
                elseif keyExpansion == "wrath" then
                    expansionName = "Wrath of the Lich King Classic"
                    if Version.IsWrath and Version:IsWrath() then
                        isValidExpansion = true
                    end
                elseif keyExpansion == "classic" then
                    expansionName = "Classic"
                    if (Version.IsClassicEra and Version:IsClassicEra()) or
                       (Version.IsTBC and Version:IsTBC()) or
                       (Version.IsCata and Version:IsCata()) then
                        isValidExpansion = true
                    end
                end

                if not isValidExpansion then
                    ns.clearKeys()
                    NAG:Error(format(
                        "The keys you entered are for %s, but you are currently on %s. Keys are expansion-specific and cannot be used across different game versions.",
                        expansionName,
                        currentGameType
                    ))
                    return
                end
            end
        end

        OptionsManager:RequestOptionsRefresh("license_key_update")
        local ResetManager = NAG:GetModule("ResetManager", true)
        if ResetManager and ResetManager.ShowReloadDialog then
            ResetManager:ShowReloadDialog()
        else
            ReloadUI()
        end
    end,
    OnCancel = function() end,
    EditBoxOnEscapePressed = function(editBox)
        editBox:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

StaticPopupDialogs["NAG_DISCORD_URL"] = {
    text = L["getKeyInstructions"] or
        "Visit our Discord to generate a key:|n|cff00ffff%s|r|n|nClick 'Copy' to copy the URL.",
    button1 = CLOSE,
    hasEditBox = true,
    editBoxWidth = 250,
    enterClicksFirstButton = true,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
        local textFS = dialog:GetTextFontString()
        if textFS and textFS.SetText then
            textFS:SetText((textFS:GetText() or ""):format(
                "https://discord.com/channels/963490632851132456/1288840702851285093"))
        end
        local editBox = dialog:GetEditBox()
        if editBox then
            editBox:SetText("https://discord.com/channels/963490632851132456/1288840702851285093")
            editBox:HighlightText()
            editBox:SetFocus()
        end
    end,
    EditBoxOnEnterPressed = function(dialog)
        StaticPopup_OnClick(dialog:GetParent(), 1)
    end,
    OnAccept = function(dialog)
        local editBox = dialog:GetEditBox()
        if editBox then
            editBox:HighlightText()
            editBox:SetFocus()
        end
    end,
    EditBoxOnEscapePressed = function(editBox)
        editBox:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Internal state
OptionsManager.initialized = false

-- Composition system for dynamic options modification
OptionsManager.composers = {}
OptionsManager.optionsNotifyDebounceSec = OPTIONS_NOTIFY_DEBOUNCE_SEC

--- Requests a debounced options refresh to avoid notify storms.
--- @param reason string|nil Short reason used for diagnostics.
function OptionsManager:RequestOptionsRefresh(reason)
    self._optionsRefreshStats = self._optionsRefreshStats or {
        requests = 0,
        flushes = 0,
        lastReason = nil
    }
    local stats = self._optionsRefreshStats
    stats.requests = (stats.requests or 0) + 1
    stats.lastReason = reason or "unspecified"

    if self._optionsRefreshTimer then
        return
    end

    local delaySec = self.optionsNotifyDebounceSec or OPTIONS_NOTIFY_DEBOUNCE_SEC
    self._optionsRefreshTimer = C_Timer.NewTimer(delaySec, function()
        self._optionsRefreshTimer = nil
        stats.flushes = (stats.flushes or 0) + 1
        AceConfigRegistry:NotifyChange("NAG")
    end)
end

--- Ace3 lifecycle: Called when module is registered
function OptionsManager:OnInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    DisplayManager = NAG:GetModule("DisplayManager")
    ResetManager = NAG:GetModule("ResetManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    KeybindManager = NAG:GetModule("KeybindManager")

    self:InitializeDatabase()
    self._optionsPerf = {
        builds = 0,
        modulesScanned = 0,
        modulesWithOptions = 0,
        lastBuildMs = 0,
        totalBuildMs = 0,
        slowBuilds = 0,
    }

    -- Set the default size for the options window to 800x600
    AceConfigDialog:SetDefaultSize("NAG", 794, 775)

    -- Add options to Blizzard Interface Options frame (Settings API exists in Retail only; TBC/Classic use /nag)
    if _G.Settings then
        AceConfigDialog:AddToBlizOptions("NAG", "Next Action Guide")
    end

    self.initialized = true

    -- Register options with Ace3 using function pattern for true dynamic behavior
    AceConfigRegistry:RegisterOptionsTable("NAG", function(uiType, uiName, appName)
        local options = self:GetOptions()

        -- Validate the options table to catch any structural issues
        local success, errorMsg = pcall(function()
            AceConfigRegistry:ValidateOptionsTable(options, "NAG")
        end)

        if not success then
            NAG:Warn("Options validation failed: " .. tostring(errorMsg))
            -- Return a minimal valid options table to prevent crashes
            return {
                type = "group",
                args = {
                    error = {
                        type = "description",
                        name = "|cffff0000Options validation failed. Check chat for errors.|r",
                        order = 1
                    }
                }
            }
        end

        return options
    end)

    -- Send DATABASE_LOADED instead of DATABASE_READY
    -- This allows MigrationManager to run migrations before modules access the database
end

--- Ace3 lifecycle: Called when module is enabled
function OptionsManager:OnEnable()

    -- Reset transient UI dirty flags
    self._predictionDirty = false

    NAG:SendMessage("NAG_DATABASE_LOADED")
    -- No need to re-register options - they are built dynamically each time
end

--- Ace3 lifecycle: Called when module is disabled
function OptionsManager:OnDisable()
    if self._optionsRefreshTimer then
        self._optionsRefreshTimer:Cancel()
        self._optionsRefreshTimer = nil
    end
end

--- Initialize the Ace3 database with proper profile system
---
--- This creates the centralized NAG.db database that contains:
--- - Global settings (debug levels, dev mode, addon-wide preferences)
--- - Cross-module character settings (WeakAuras integration, autocast settings)
--- - Cross-module class settings (display preferences)
---
--- Module-specific data (rotations, customRotations, selectedRotations) is owned by
--- individual modules and accessed through their GetSetting/SetSetting methods.
function OptionsManager:InitializeDatabase()
    -- Create the centralized NAG.db for cross-module settings
    -- Module-specific data is owned by individual modules
    self.db = AceDB:New("NAGDB", self.defaults)

    -- DEBUG: Log database creation details (using Info level for visibility)
    NAG:Info("InitializeDatabase: Created NAG.db with type: " .. type(self.db))
    NAG:Info("InitializeDatabase: NAG.db.RegisterNamespace type: " .. type(self.db.RegisterNamespace))

    -- Store reference to main database
    NAG.db = self.db
    -- Dedicated leaderboard persistence root (cleanly split from NAGDB)
    self.leaderboardDb = AceDB:New("NAGLeaderboardDB", {})
    NAG.leaderboardDbRoot = self.leaderboardDb

    -- DEBUG: Log what we're setting as NAG.db
    NAG:Info("InitializeDatabase: Set NAG.db to: " .. type(NAG.db))
    if NAG.db then
        -- Lua 5.1 compatible way to get table keys
        local keys = {}
        for key, _ in pairs(NAG.db) do
            table.insert(keys, tostring(key))
        end
        NAG:Info("InitializeDatabase: NAG.db keys: " .. table.concat(keys, ", "))
    end

    -- DEBUG: Log after database setup
    NAG:Info("InitializeDatabase: Database setup complete, NAG.db type: " .. type(NAG.db))
    NAG:Info("InitializeDatabase: Leaderboard DB root type: " .. type(NAG.leaderboardDbRoot))
end

--- Gets the main database instance (for NAG.lua access)
--- @return AceDBObject-3.0 The main database instance
function OptionsManager:GetDatabase()
    return self.db
end

--- Gets the dedicated leaderboard database root instance.
--- @return AceDBObject-3.0 The leaderboard database root instance
function OptionsManager:GetLeaderboardDatabase()
    return self.leaderboardDb
end

--- Gets a setting value using dot notation (e.g., "char.appearance.iconSize")
--- @param self OptionsManager
--- @param namespace string The database namespace ("global", "char", "class")
--- @param ... string|any Variable arguments: either (key, defaultValue) for old pattern or (key1, key2, ..., value) for new pattern
--- @return any The setting value
function OptionsManager:GetSetting(namespace, ...)
    if not self.db then
        -- Use Warn level for database initialization issues
        NAG:Warn("OptionsManager:GetSetting - Database not initialized!")
        return select(-1, ...) -- Return the last argument as default
    end

    -- Use consolidated smart utility that automatically resolves defaults
    -- Ace3 handles defaults automatically when database was created with defaults
    return ns.DatabaseUtils.GetSetting(self.db, namespace, ...)
end

--- Set a setting in the appropriate namespace
--- @param namespace string The namespace to set the setting in
--- @param ... string|any Variable arguments: either (key, value) for old pattern or (key1, key2, ..., value) for new pattern
function OptionsManager:SetSetting(namespace, ...)
    if not self.db then
        -- Use Warn level for database initialization issues
        NAG:Warn("OptionsManager:SetSetting - Database not initialized!")
        return
    end

    -- Use shared utility for consistent setting access
    local success = ns.DatabaseUtils.SetSetting(self.db, namespace, ...)
    if success then
        self:SendMessage("NAG_SETTING_CHANGED", namespace, ...)
    end
    return success
end

-- ============================ SIMPLE NAMESPACE ACCESS ============================



--- Gets the keys section from NAG's database
--- @return table The keys settings
function OptionsManager:GetKeys()
    return self.db.global.keys
end

--- Sets the keys section in the database
--- @param keys table The keys to set
function OptionsManager:SetKeys(keys)
    self.db.global.keys = keys
end

--- Updates keys in the database (preserves existing structure)
--- @param keys table The keys to update
function OptionsManager:UpdateKeys(keys)
    local currentKeys = self:GetSetting("global", "keys", {
        legacy = { current = {}, old = {} },
        current = {}
    })

    -- Merge the new keys into existing structure
    for section, sectionKeys in pairs(keys) do
        if type(sectionKeys) == "table" then
            if not currentKeys[section] then
                currentKeys[section] = {}
            end
            for key, value in pairs(sectionKeys) do
                currentKeys[section][key] = value
            end
        end
    end

    self.db.global.keys = currentKeys
end

-- ============================ MODULE INTEGRATION HELPERS ============================

--- Creates a base options group structure
---
--- This function creates options groups for centralized/cross-module settings.
--- For module-specific options, modules should implement their own GetOptions() method
--- or use the optionsComposers system for dynamic integration.
---
--- @param name string The name of the group
--- @param category string The category of the group
--- @param getter function The getter function for options (optional)
--- @param setter function The setter function for options (optional)
--- @return table The options group structure
function OptionsManager:CreateOptionsGroup(name, category, getter, setter)
    return {
        type = "group",
        name = function() return L[name] or name end,
        desc = function() return L[name .. "Desc"] or "" end,
        order = ns.GetCategoryOrder(category),
        childGroups = ns.GetCategoryLayout(category),
        get = getter,
        set = setter,
        args = {}
    }
end

--- Gets the complete options table for NAG
--- @return table The complete options table
function OptionsManager:GetOptions()
    -- Recursion protection
    if self._buildingOptions then
        return {
            type = "group",
            name = L["Next Action Guide"] or "Next Action Guide",
            desc = L["Configure your settings"] or "Configure your settings",
            childGroups = "tab",
            args = {}
        }
    end

    self._buildingOptions = true
    local buildStartMs = debugprofilestop and debugprofilestop() or 0

    local version = NAG.GetCurrentVersion and NAG:GetCurrentVersion() or "?"
    local versionStr = tostring(version)
    local options = {}

    -- Create all categories dynamically for consistency
    for _, category in pairs(ns.MODULE_CATEGORIES) do
        options[category] = {
            type = "group",
            name = category:upper(), -- Display name in uppercase
            desc = category .. " settings",
            childGroups = ns.GetCategoryLayout(category),
            order = ns.GetCategoryOrder(category),
            args = {}
        }
    end

    -- Discover and integrate module GetOptions()
    self:IntegrateModuleOptions(options)

    -- Add standard Ace3 options and populate special categories
    -- Populate special categories with their content
    if options.splash then
        local splashContent = self:CreateSplashOptions()
        if splashContent and splashContent.args then
            for key, value in pairs(splashContent.args) do
                options.splash.args[key] = value
            end
        end
    end

    if options.reset then
        local resetContent = self:CreateResetOptions()
        if resetContent and resetContent.args then
            for key, value in pairs(resetContent.args) do
                options.reset.args[key] = value
            end
        end
    end

    if options.acknowledgements then
        local ackContent = self:CreateAcknowledgementsOptions()
        if ackContent and ackContent.args then
            for key, value in pairs(ackContent.args) do
                options.acknowledgements.args[key] = value
            end
        end
    end



    -- Populate debug category with debug controls and tools
    if options.debug then
        local debugContent = self:CreateDebugOptions()
        if debugContent and debugContent.args then
            for key, value in pairs(debugContent.args) do
                options.debug.args[key] = value
            end
        end
    end

    if options.ui then
        local uiContent = self:CreateUIOptions()
        if uiContent and uiContent.args then
            for key, value in pairs(uiContent.args) do
                options.ui.args[key] = value
            end
        end
    end

    -- Apply ALL composers in a single phase (after all content is populated)
    self:ApplyAllComposers(options)

    self._buildingOptions = false
    local buildElapsedMs = (debugprofilestop and debugprofilestop() or buildStartMs) - buildStartMs
    local perf = self._optionsPerf
    if perf then
        perf.builds = (perf.builds or 0) + 1
        perf.lastBuildMs = buildElapsedMs
        perf.totalBuildMs = (perf.totalBuildMs or 0) + buildElapsedMs
        if buildElapsedMs >= (OPTIONS_BUILD_WARN_THRESHOLD_SEC * 1000) then
            perf.slowBuilds = (perf.slowBuilds or 0) + 1
            NAG:Warn("Options build took %.1fms (build #%d)", buildElapsedMs, perf.builds)
        elseif (perf.builds % OPTIONS_BUILD_LOG_EVERY) == 0 then
            local avgMs = perf.totalBuildMs / perf.builds
            NAG:Debug("Options build stats: builds=%d avg=%.1fms last=%.1fms", perf.builds, avgMs, buildElapsedMs)
        end
    end

    return {
        type = "group",
        name = "Next Action Guide " .. versionStr,
        desc = L["Configure your settings"] or "Configure your settings",
        childGroups = "tab",
        args = options
    }
end

--- Composition system for dynamic options modification
--- @param targetPath string The dot-notation path to the target (e.g., "ui.args.groupFramesModern")
--- @param composer function|string The composer function that modifies the options, or method name to call on the module
--- @param module table The module registering the composer
--- @param order number The execution order (lower numbers execute first)
--- @param allowOverwrite boolean Whether to allow this composer to replace the entire structure (default: false)
function OptionsManager:RegisterOptionsComposer(targetPath, composer, module, order, allowOverwrite)
    if type(targetPath) ~= "string" or (type(composer) ~= "function" and type(composer) ~= "string") then
        return
    end

    self.composers = self.composers or {}
    self.composers[targetPath] = self.composers[targetPath] or {}

    -- Check if this module already has a composer registered for this path
    for _, existingComposer in ipairs(self.composers[targetPath]) do
        if existingComposer.module == module then
            return
        end
    end

    tinsert(self.composers[targetPath], {
        composer = composer,
        module = module,
        order = order or 100,
        allowOverwrite = allowOverwrite or false
    })

    -- Sort by order
    sort(self.composers[targetPath], function(a, b) return a.order < b.order end)
end

--- Apply composers to a specific target
--- @param targetPath string The target path
--- @param options table The options to modify
--- @param context table Additional context for composers
--- @return table The modified options
function OptionsManager:ApplyComposers(targetPath, options, context)
    local composers = self.composers and self.composers[targetPath] or {}

    if #composers == 0 then
        return options
    end

    for i, composerData in ipairs(composers) do
        local success, result

        -- Handle method names (like Ace3 does) vs direct functions
        if type(composerData.composer) == "string" then
            -- Composer is a method name, call it on the module with proper self context
            success, result = pcall(composerData.module[composerData.composer], composerData.module, options, context)
        else
            -- Composer is a function, call it directly
            success, result = pcall(composerData.composer, options, context, composerData.module)
        end

        if success and result then
            -- Check if this composer is trying to replace the structure
            if not composerData.allowOverwrite and type(result) == "table" then
                -- Verify the result maintains the expected structure
                local isReplacement = false

                -- Check if it's a complete replacement (missing expected keys)
                if options.type and not result.type then
                    isReplacement = true
                elseif options.args and not result.args then
                    isReplacement = true
                elseif options.args and result.args then
                    -- Check if we're losing significant existing content
                    local existingCount = TableUtils.Size(options.args)
                    local resultCount = TableUtils.Size(result.args)

                    if existingCount > 0 and resultCount < existingCount * 0.5 then
                        isReplacement = true
                    end
                end

                -- Continue with the result but log the warning if needed
            end

            options = result
        end
    end

    return options
end

--- Apply nested path composers to the options structure
--- @param options table The options structure to modify
function OptionsManager:ApplyAllComposers(options)
    -- Apply ALL composers in a single phase (after all content is populated)
    if not self.composers then
        return
    end

    -- Apply category-level composers first
    for category in pairs(options) do
        if self.composers[category] then
            options[category] = self:ApplyComposers(category, options[category], {})
        end
    end

    -- Apply nested path composers (module-level and deeper)
    for path, composers in pairs(self.composers) do
        -- Only process nested paths (containing .args.)
        if strfind(path, "%.args%.") then
            local target = self:GetOptionsByPath(options, path)
            if target then
                local modified = self:ApplyComposers(path, target, {})
                self:SetOptionsByPath(options, path, modified)
            end
        end
    end
end

--- Get options by dot notation path
--- @param options table The options structure
--- @param path string The dot-notation path
--- @return table|nil The options at the path, or nil if not found
function OptionsManager:GetOptionsByPath(options, path)
    return TableUtils.GetNested(options, path)
end

--- Set options by dot notation path
--- @param options table The options structure
--- @param path string The dot-notation path
--- @param value table The value to set
--- @return boolean True if successful, false otherwise
function OptionsManager:SetOptionsByPath(options, path, value)
    return TableUtils.SetNested(options, path, value)
end

-- Healing modules shown under FEATURES > Healing System (sub-groups)
local HEALING_SYSTEM_MODULES = {
    HealingDispelManager = true,
    HealingStateManager = true,
    HealingPriorityManager = true,
    HealingTargetIndicator = true,
}

-- Hunter weave modules shown under CLASS > Hunter weave (sub-groups)
local HUNTER_WEAVE_MODULES = {
    HunterSteadyWeaveBar = true,
}

--- Integrate module options into the main options structure
--- @param options table The main options structure
function OptionsManager:IntegrateModuleOptions(options)
    local moduleCount = NAG.modules and TableUtils.Size(NAG.modules) or 0
    local modulesWithOptions = 0
    local integrationStartMs = debugprofilestop and debugprofilestop() or 0
    NAG:Trace("IntegrateModuleOptions called, NAG.modules count: " .. moduleCount)
    for moduleName, module in pairs(NAG.modules) do
        -- Skip OptionsManager itself to prevent recursion
        if moduleName == "OptionsManager" then
        elseif module.GetOptions then
            -- Check if module should be hidden
            local shouldSkip = false
            if module.hidden and type(module.hidden) == "function" then
                local success, shouldHide = pcall(function() return module:hidden() end)
                if success and shouldHide then
                    shouldSkip = true
                end
            end

            if not shouldSkip then
                NAG:Trace("Processing module: " .. moduleName .. " (type: " .. type(module) .. ")")
                local success, moduleOptions, errorMsg = pcall(function() return module:GetOptions() end)
                if not success then
                    NAG:Warn("GetOptions() call failed for module " .. moduleName .. ": " .. tostring(errorMsg))
                end
                if success then
                    if moduleOptions and type(moduleOptions) == "table" then
                        modulesWithOptions = modulesWithOptions + 1
                        -- Validate the module's options table
                        local validationSuccess, validationError = pcall(function()
                            AceConfigRegistry:ValidateOptionsTable(moduleOptions, moduleName)
                        end)

                        if not validationSuccess then
                            NAG:Warn("Options validation failed for " .. moduleName .. ": " .. tostring(validationError))
                            -- Skip this module's options to prevent crashes
                            shouldSkip = true
                        end

                        -- Skip the rest of processing if validation failed
                        if not shouldSkip then
                            local category = module.optionsCategory or
                                ns.GetDefaultCategory(module.moduleType or ns.MODULE_TYPES.FEATURE)

                            if options[category] then
                                -- Insert unified developer options at the bottom if available
                                local hasDeveloperOptions = false

                                -- Check for unified developer options (preferred method)
                                if module.CreateDeveloperOptions and type(module.CreateDeveloperOptions) == "function" then
                                    local success, developerOptions = pcall(function()
                                        return module
                                            :CreateDeveloperOptions()
                                    end)
                                    if success and developerOptions and type(developerOptions) == "table" then
                                        hasDeveloperOptions = true
                                    end
                                end

                                -- If we have developer options, add them intelligently
                                if hasDeveloperOptions then
                                    local success, developerOptions = pcall(function()
                                        return module
                                            :CreateDeveloperOptions()
                                    end)
                                    if success and developerOptions and type(developerOptions) == "table" then
                                        -- Check if this module has a tabbed structure
                                        local hasTabs = false
                                        if moduleOptions.childGroups == "tab" then
                                            hasTabs = true
                                        end

                                        if hasTabs then
                                            -- For tabbed modules, add developer options to the first tab
                                            local firstTab = nil
                                            for tabName, tabData in pairs(moduleOptions.args) do
                                                if type(tabData) == "table" and tabData.type == "group" then
                                                    firstTab = tabName
                                                    break
                                                end
                                            end

                                            if firstTab and moduleOptions.args[firstTab] and moduleOptions.args[firstTab].args then
                                                -- Add developer options to the first tab
                                                for key, value in pairs(developerOptions) do
                                                    moduleOptions.args[firstTab].args[key] = value
                                                end
                                            else
                                                -- Fallback: add to root level
                                                for key, value in pairs(developerOptions) do
                                                    moduleOptions.args[key] = value
                                                end
                                            end
                                        else
                                            -- For non-tabbed modules, add to root level
                                            for key, value in pairs(developerOptions) do
                                                moduleOptions.args[key] = value
                                            end
                                        end
                                    end
                                end

                                -- Apply module's optionsOrder if specified
                                if module.optionsOrder then
                                    moduleOptions.order = module.optionsOrder
                                end

                                -- Store module options (composers will be applied later in unified phase)
                                -- Healing modules go under FEATURES > Healing System as sub-groups
                                if category == "features" and HEALING_SYSTEM_MODULES[moduleName] then
                                    if not options.features.args.HealingSystem then
                                        options.features.args.HealingSystem = {
                                            type = "group",
                                            name = L["healingSystem"] or "Healing System",
                                            desc = L["healingSystemDesc"] or "Mouseover and group healing, dispel, priority, and target glow.",
                                            childGroups = "tree",
                                            order = 5,
                                            hidden = function() return not NAG:IsDevModeEnabled() end,
                                            args = {},
                                        }
                                    end
                                    options.features.args.HealingSystem.args[moduleName] = moduleOptions
                                    NAG:Trace("Stored options for " .. moduleName .. " in features > Healing System")
                                elseif category == "class" and HUNTER_WEAVE_MODULES[moduleName] then
                                    if not options.class.args.HunterWeave then
                                        options.class.args.HunterWeave = {
                                            type = "group",
                                            name = "Hunter weave",
                                            desc = "Hunter Steady Shot / Aimed Shot weave bar settings.",
                                            childGroups = "tree",
                                            order = 25,
                                            args = {},
                                        }
                                    end
                                    options.class.args.HunterWeave.args[moduleName] = moduleOptions
                                    NAG:Trace("Stored options for " .. moduleName .. " in class > Hunter weave")
                                else
                                    options[category].args[moduleName] = moduleOptions
                                    NAG:Trace("Stored options for " .. moduleName .. " in " .. category)
                                end
                            end
                        end
                    else
                        NAG:Warn("GetOptions returned nil or non-table for: " .. moduleName)
                    end
                else
                    NAG:Warn("GetOptions failed for: " .. moduleName .. ": " .. tostring(errorMsg))
                end
            end
        end
    end

    local perf = self._optionsPerf
    if perf then
        perf.modulesScanned = moduleCount
        perf.modulesWithOptions = modulesWithOptions
        local elapsedMs = (debugprofilestop and debugprofilestop() or integrationStartMs) - integrationStartMs
        if elapsedMs >= 25 then
            NAG:Warn("IntegrateModuleOptions scanned=%d withOptions=%d in %.1fms", moduleCount, modulesWithOptions, elapsedMs)
        end
    end
end

--- Refresh all options and notify UI
function OptionsManager:RefreshOptions()
    self:RequestOptionsRefresh("RefreshOptions")
end

--- Clear all composers (useful for testing or cleanup)
function OptionsManager:ClearComposers()
    wipe(self.composers or {})
end

--- Get information about registered composers (for debugging)
--- @return table Information about registered composers
function OptionsManager:GetComposerInfo()
    local info = {}
    for path, composers in pairs(self.composers or {}) do
        info[path] = {
            count = #composers,
            composers = {}
        }
        for i, composerData in ipairs(composers) do
            info[path].composers[i] = {
                order = composerData.order,
                module = composerData.module and composerData.module:GetName() or "unknown"
            }
        end
    end
    return info
end

function OptionsManager:CreateSplashOptions()
    local function generateClassIcons()
        local classIcons = {
            [0] = 'Interface\\AddOns\\NAG\\Media\\NAGlogo.png:40:40:0:5:64:64:5:59:5:59',
            [1] = '626008:30:30:0:0:64:64:5:59:5:59',
            [2] = '626003:30:30:0:0:64:64:5:59:5:59',
            [3] = '626000:30:30:0:0:64:64:5:59:5:59',
            [4] = '626005:30:30:0:0:64:64:5:59:5:59',
            [5] = '626004:30:30:0:0:64:64:5:59:5:59',
            [6] = '135771:30:30:0:0:64:64:5:59:5:59',
            [7] = '626006:30:30:0:0:64:64:5:59:5:59',
            [8] = '626001:30:30:0:0:64:64:5:59:5:59',
            [9] = '626007:30:30:0:0:64:64:5:59:5:59',
            [10] = '626002:30:30:0:0:64:64:5:59:5:59',
            [11] = '625999:30:30:0:0:64:64:5:59:5:59',
            [12] = '1247264:30:30:0:0:64:64:5:59:5:59',
            [13] = '4574311:30:30:0:0:64:64:5:59:5:59',
            [99] = 'Interface\\AddOns\\NAG\\Media\\NAGLogo-GOLD.png:40:40:0:5:64:64:5:59:5:59',
        }
        -- Check appropriate flags based on current expansion
        local nagLogo = nil
        local flagPrefix = nil
        if ns.Version and ns.Version.IsMists and ns.Version:IsMists() then
            -- MoP flags
            nagLogo = ns.lm99 and 99 or (ns.lm0 and 0 or nil)
            flagPrefix = "lm"
        elseif ns.Version and (ns.Version.IsWrath and ns.Version:IsWrath()) then
            nagLogo = ns.lw99 and 99 or (ns.lw0 and 0 or nil)
            flagPrefix = "lw"
        elseif ns.Version and ((ns.Version.IsClassicEra and ns.Version:IsClassicEra()) or
                               (ns.Version.IsTBC and ns.Version:IsTBC()) or
                               (ns.Version.IsCata and ns.Version:IsCata())) then
            -- Legacy rendering profile flags (ns.lc0-99) for Classic Era, TBC, Cata
            nagLogo = ns.lc99 and 99 or (ns.lc0 and 0 or nil)
            flagPrefix = "lc"
        end

        local order = nagLogo and { nagLogo, 6, 12, 10, 11, 13, 3, 8, 2, 5, 4, 7, 1, 9 } or
            { 6, 12, 10, 11, 13, 3, 8, 2, 5, 4, 7, 1, 9 }
        local icons = "|n|n"
        for _, classId in ipairs(order) do
            -- Check appropriate flags based on expansion
            if flagPrefix and ns[flagPrefix .. classId] then
                local iconPath = classIcons[classId]
                icons = icons .. "|T" .. iconPath .. "|t "
            end
        end
        icons = icons .. "|n|n"
        return icons
    end
    local splashOptions = {
        logoGroup = {
            type = "group",
            name = "",
            order = 1,
            inline = true,
            args = {
                logo = {
                    type = "description",
                    order = 1,
                    name = "",
                    fontSize = "medium",
                    image = function()
                        -- Check appropriate flags based on current expansion
                        local showGoldLogo = false
                        if ns.Version and ns.Version.IsMists and ns.Version:IsMists() then
                            -- MoP flags
                            showGoldLogo = ns.lm99
                        elseif ns.Version and (ns.Version.IsWrath and ns.Version:IsWrath()) then
                            showGoldLogo = ns.lw99
                        elseif ns.Version and ((ns.Version.IsClassicEra and ns.Version:IsClassicEra()) or
                                               (ns.Version.IsTBC and ns.Version:IsTBC()) or
                                               (ns.Version.IsCata and ns.Version:IsCata())) then
                            -- Legacy rendering profile flags (ns.lc0-99) for Classic Era, TBC, Cata
                            showGoldLogo = ns.lc99
                        end
                        return showGoldLogo and "Interface\\AddOns\\NAG\\Media\\NAGlogo-GOLD.png" or
                            "Interface\\AddOns\\NAG\\Media\\NAGlogo.png"
                    end,
                    imageWidth = 200,
                    imageHeight = 200,
                    width = "full",
                },
            },
        },
        frameControlsGroup = {
            type = "group",
            name = L["frameControlsGroup"] or "Frame Controls",
            order = 2,
            inline = true,
            args = {
                frameEditMode = {
                    type = "execute",
                    name = function()
                        local isEditMode = NAG:IsAnyEditMode()
                        return isEditMode and "Lock Frame Position" or "Unlock Frame Position"
                    end,
                    desc = L["unlockFrameDescription"] or "Unlock frame for movement",
                    order = 1,
                    width = "double",
                    func = function()
                        local isEditMode = NAG:IsAnyEditMode()

                        if isEditMode then
                            -- Lock both systems
                            if DisplayManager:IsGroupDisplayMode() then
                                DisplayManager:DisableEditMode()
                            end
                            if DisplayManager:IsLegacyFrameEnabled() then
                                DisplayManager:ToggleFrameEditMode(false)
                            end
                        else
                            -- Unlock both systems
                            if DisplayManager:IsGroupDisplayMode() then
                                DisplayManager:EnableEditMode()
                            end
                            if DisplayManager:IsLegacyFrameEnabled() then
                                DisplayManager:ToggleFrameEditMode(true)
                            end
                        end
                    end,
                },
            },
        },
        controlGroup = {
            type = "group",
            name = L["controls"] or "Controls",
            order = 3,
            inline = true,
            args = {
                enableWelcome = OptionsFactory:CreateToggle(
                    L["Enable Welcome"] or "Enable Welcome",
                    L["Enable Welcome Desc"] or "Show welcome message on login",
                    function(info) return self:GetSetting("global", "enableWelcome") end,
                    function(info, value) self:SetSetting("global", "enableWelcome", value) end,
                    { order = 1 }
                ),
                predictionQueueEnabled = OptionsFactory:CreateToggle(L["predictionQueueEnabled"] or "Enable Prediction Queue", L["predictionQueueEnabledDesc"] or "Show multiple upcoming spell recommendations",
                    function(info) return self:GetSetting("char", "predictionQueue.enabled") end,
                    function(info, value)
                        self:SetSetting("char", "predictionQueue.enabled", value)
                        self:RequestOptionsRefresh("prediction_queue_enabled")
                    end,
                    { order = 2, hidden = function() return not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) end }
                ),
                predictionQueueNumSpells = OptionsFactory:CreateRange(L["predictionQueueNumSpells"] or "Number of Spells", L["predictionQueueNumSpellsDesc"] or "Number of additional spell icons to show in the prediction queue",
                    function(info) return self:GetSetting("char", "predictionQueue.numPredictions") or 2 end,
                    function(info, value)
                        self:SetSetting("char", "predictionQueue.numPredictions", value)
                        self:RequestOptionsRefresh("prediction_queue_count")
                    end,
                    { order = 3, min = 1, max = 3, step = 1, hidden = function() return not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) end }
                ),
            },
        },
        licenseGroup = {
            type = "group",
            name = L["license"] or "License",
            order = 5,
            inline = true,
            args = {
                classIcons = {
                    type = "description",
                    order = 1,
                    name = generateClassIcons,
                    fontSize = "medium",
                    width = "full",
                },
                status = {
                    type = "description",
                    name = function()
                        -- Check appropriate flags based on current expansion
                        local coreFlag, godFlag
                        if ns.Version and ns.Version.IsMists and ns.Version:IsMists() then
                            -- MoP flags
                            coreFlag = ns.lm0
                            godFlag = ns.lm99
                        elseif ns.Version and (ns.Version.IsWrath and ns.Version:IsWrath()) then
                            coreFlag = ns.lw0
                            godFlag = ns.lw99
                        elseif ns.Version and ((ns.Version.IsClassicEra and ns.Version:IsClassicEra()) or
                                               (ns.Version.IsTBC and ns.Version:IsTBC()) or
                                               (ns.Version.IsCata and ns.Version:IsCata())) then
                            -- Legacy rendering profile flags (ns.lc0-99) for Classic Era, TBC, Cata
                            coreFlag = ns.lc0
                            godFlag = ns.lc99
                        end

                        -- Check appropriate flags based on expansion
                        local hasLicense = (coreFlag or godFlag)

                        -- Helper app-managed keys (external NAG Helper)
                        if ns.isHelperKey and hasLicense then
                            return "|cffffff00License being managed by the NAG Helper External App.|n" ..
                                "Keep it minimized in the tray and it will handle addon updates and license keys automatically."
                        end

                        return "|cffffff00" .. (ns.d and ns.d > 0 and hasLicense and
                            "Your Next Action Guide is activated for the classes shown above.|n" ..
                            "Key valid for " .. ns.d .. " days (new key available in " .. (ns.d - 2) .. " days)" or
                            "Your Next Action Guide advanced class features are currently inactive.")
                    end,
                    order = 2,
                    fontSize = "medium",
                    width = "full",
                },
                buttonGroup = {
                    type = "group",
                    name = "",
                    order = 3,
                    inline = true,
                    args = {
                        enterKey = {
                            type = "execute",
                            name = L["enterKey"] or "Enter License Key",
                            desc = L["enterKeyDesc"] or "Enter or update your license key",
                            width = "normal",
                            order = 1,
                            func = function()
                                local d = StaticPopupDialogs["NAG_ENTER_KEY"]
                                if d then
                                    d.text = (L and L["enterKeyPrompt"]) or "Enter your license key:"
                                end
                                StaticPopup_Show("NAG_ENTER_KEY")
                            end,
                        },
                        getKey = {
                            type = "execute",
                            name = L["getKey"] or "Get License Key",
                            desc = L["getKeyDesc"] or "Visit Discord to generate a new key",
                            width = "normal",
                            order = 2,
                            func = function()
                                local discordUrl = "https://discord.com/channels/963490632851132456/1288840702851285093"
                                local d = StaticPopupDialogs["NAG_DISCORD_URL"]
                                if d then
                                    d.text = (L and L["getKeyInstructions"]) or
                                        "Visit our Discord to generate a key:|n|cff00ffff%s|r|n|nClick 'Copy' to copy the URL."
                                end
                                StaticPopup_Show("NAG_DISCORD_URL", discordUrl)
                            end,
                        },
                        resetKey = {
                            type = "execute",
                            name = L["resetKey"] or "Reset Key",
                            desc = L["resetKeyDesc"] or "Clear all license key information from the database",
                            width = "normal",
                            order = 3,
                            func = function()
                                if ResetManager then
                                    ResetManager:ShowResetConfirmDialog(L["resetKeysConfirm"],
                                        function() ResetManager:ResetKeys() end)
                                end
                            end,
                        },
                    },
                },
            },
        },
        messageGroup = {
            type = "group",
            name = "",
            order = 99,
            inline = true,
            args = {
                developedBy = {
                    type = "description",
                    order = 2,
                    fontSize = "medium",
                    name = function()
                        return "|cFF00FFFF" .. L["developedBy"] .. "|r"
                    end,
                    width = "full",
                },
            },
        },
    }

    return {
        type = "group",
        name = L["splash"] or "Welcome",
        desc = L["splashDesc"] or "Welcome and license information",
        order = 1,
        childGroups = "tab",
        args = splashOptions
    }
end

--- Creates UI options with tree structure
--- @return table The UI options group
function OptionsManager:CreateUIOptions()
    return {
        type = "group",
        name = "UI",
        desc = L["Display and frame settings"] or "Display and frame settings",
        childGroups = "tree",
        order = 2,
        args = {
            uiHeader = {
                type = "header",
                name = L["uiSettings"] or "UI Settings",
                order = 1,
            },
        }
    }
end

--- Creates class options with tree structure
--- @return table The class options group
function OptionsManager:CreateClassOptions()
    return {
        type = "group",
        name = L["Class"] or "Class",
        desc = L["Class-specific settings"] or "Class-specific settings",
        childGroups = "tree",
        order = 3,
        args = {
            classHeader = {
                type = "header",
                name = L["classSettings"] or "Class Settings",
                order = 1,
            }
        }
    }
end

--- Creates features options with tree structure
--- @return table The features options group
function OptionsManager:CreateFeaturesOptions()
    return {
        type = "group",
        name = L["Features"] or "Features",
        desc = L["Feature settings"] or "Feature settings",
        childGroups = "tree",
        order = 4,
        args = {
            featureHeader = {
                type = "header",
                name = L["featureSettings"] or "Feature Settings",
                order = 1,
            }
        }
    }
end

--- Creates debug options with tree structure
--- @return table The debug options group
function OptionsManager:CreateDebugOptions()
    return {
        type = "group",
        name = L["Debug"] or "Debug",
        desc = L["Debug and development settings"] or "Debug and development settings",
        childGroups = "tree",
        order = 5,
        args = {
            debugSettingsGroup = {
                type = "group",
                name = "",
                desc = L["debugSettingsGroupDesc"] or "Configure global debug settings and view category status",
                order = 10,
                inline = true,
                args = {
                    -- Global Debug Control
                    globalDebugLevel = OptionsFactory:CreateSelect(L["globalDebugLevel"] or "Debug Level", L["globalDebugLevelDesc"] or "Set the debug level for all modules. Only messages at or above this level will be logged.",
                        function(info)
                            return self:GetSetting("global", "debugLevel")
                        end,
                        function(info, value)
                            self:SetSetting("global", "debugLevel", value)
                        end,
                        {
                            order = 1,
                            width = "double",
                            values = {
                                [ns.DEBUG_LEVELS.NONE] = "None - No debug output",
                                [ns.DEBUG_LEVELS.ERROR] = "Error - Only errors and critical issues",
                                [ns.DEBUG_LEVELS.WARN] = "Warning - Errors and warnings",
                                [ns.DEBUG_LEVELS.INFO] = "Info - Errors, warnings, and general info",
                                [ns.DEBUG_LEVELS.DEBUG] = "Debug - Detailed debug information",
                                [ns.DEBUG_LEVELS.TRACE] = "Trace - Maximum detail for troubleshooting"
                            }
                        }
                    ),

                    enableDevMode = OptionsFactory:CreateToggle(L["enableDevMode"] or "Enable Developer Mode", L["enableDevModeDesc"] or "Enable additional developer features and debugging options. Required to see advanced debug tools and per-module controls.",
                        function()
                            return NAG:IsDevModeEnabled()
                        end,
                        function(_, value)
                            self:SetSetting("global", "enableDevMode", value)
                        end,
                        {
                            order = 2,
                            width = "default"
                        }
                    ),

                    debugOutputChannel = OptionsFactory:CreateSelect(L["debugOutputChannel"] or "Debug Output Channel", L["debugOutputChannelDesc"] or "Chat window for debug messages. Use a separate tab to keep debug output away from your main chat.",
                        function(info)
                            return self:GetSetting("global", "debugOutputChannel", 1)
                        end,
                        function(info, value)
                            self:SetSetting("global", "debugOutputChannel", value)
                        end,
                        {
                            order = 3,
                            width = "default",
                            values = function()
                                local vals = {}
                                local getInfo = _G.GetChatWindowInfo
                                for i = 1, 10 do
                                    local name
                                    if getInfo then
                                        name = select(1, getInfo(i))
                                    end
                                    if name and name ~= "" then
                                        vals[i] = name
                                    else
                                        vals[i] = (i == 1) and "Chat 1 (Default)" or ("Chat " .. i)
                                    end
                                end
                                return vals
                            end
                        }
                    ),

                    -- Per-level output channels (optional overrides; 0 = use main)
                    debugOutputChannelByLevel = {
                        type = "group",
                        name = L["debugOutputChannelsByLevel"] or "Channels by level",
                        desc = L["debugOutputChannelsByLevelDesc"] or "Override the output channel per severity. Default = use main setting.",
                        order = 3.5,
                        inline = true,
                        args = {
                            levelError = OptionsFactory:CreateSelect("Error", "Channel for ERROR messages",
                                function() return self:GetSetting("global", "debugOutputChannelByLevel." .. tostring(ns.DEBUG_LEVELS.ERROR), 0) end,
                                function(_, v) self:SetSetting("global", "debugOutputChannelByLevel." .. tostring(ns.DEBUG_LEVELS.ERROR), v) end,
                                { order = 1, width = "half", values = function()
                                    local vals = { [0] = "Default" }; local gi = _G.GetChatWindowInfo
                                    for i = 1, 10 do local n = gi and select(1, gi(i)) or nil; vals[i] = (n and n ~= "") and n or ("Chat " .. i) end
                                    return vals
                                end }),
                            levelWarn = OptionsFactory:CreateSelect("Warning", "Channel for WARN messages",
                                function() return self:GetSetting("global", "debugOutputChannelByLevel." .. tostring(ns.DEBUG_LEVELS.WARN), 0) end,
                                function(_, v) self:SetSetting("global", "debugOutputChannelByLevel." .. tostring(ns.DEBUG_LEVELS.WARN), v) end,
                                { order = 2, width = "half", values = function()
                                    local vals = { [0] = "Default" }; local gi = _G.GetChatWindowInfo
                                    for i = 1, 10 do local n = gi and select(1, gi(i)) or nil; vals[i] = (n and n ~= "") and n or ("Chat " .. i) end
                                    return vals
                                end }),
                            levelInfo = OptionsFactory:CreateSelect("Info", "Channel for INFO messages",
                                function() return self:GetSetting("global", "debugOutputChannelByLevel." .. tostring(ns.DEBUG_LEVELS.INFO), 0) end,
                                function(_, v) self:SetSetting("global", "debugOutputChannelByLevel." .. tostring(ns.DEBUG_LEVELS.INFO), v) end,
                                { order = 3, width = "half", values = function()
                                    local vals = { [0] = "Default" }; local gi = _G.GetChatWindowInfo
                                    for i = 1, 10 do local n = gi and select(1, gi(i)) or nil; vals[i] = (n and n ~= "") and n or ("Chat " .. i) end
                                    return vals
                                end }),
                            levelDebug = OptionsFactory:CreateSelect("Debug", "Channel for DEBUG messages",
                                function() return self:GetSetting("global", "debugOutputChannelByLevel." .. tostring(ns.DEBUG_LEVELS.DEBUG), 0) end,
                                function(_, v) self:SetSetting("global", "debugOutputChannelByLevel." .. tostring(ns.DEBUG_LEVELS.DEBUG), v) end,
                                { order = 4, width = "half", values = function()
                                    local vals = { [0] = "Default" }; local gi = _G.GetChatWindowInfo
                                    for i = 1, 10 do local n = gi and select(1, gi(i)) or nil; vals[i] = (n and n ~= "") and n or ("Chat " .. i) end
                                    return vals
                                end }),
                            levelTrace = OptionsFactory:CreateSelect("Trace", "Channel for TRACE messages",
                                function() return self:GetSetting("global", "debugOutputChannelByLevel." .. tostring(ns.DEBUG_LEVELS.TRACE), 0) end,
                                function(_, v) self:SetSetting("global", "debugOutputChannelByLevel." .. tostring(ns.DEBUG_LEVELS.TRACE), v) end,
                                { order = 5, width = "half", values = function()
                                    local vals = { [0] = "Default" }; local gi = _G.GetChatWindowInfo
                                    for i = 1, 10 do local n = gi and select(1, gi(i)) or nil; vals[i] = (n and n ~= "") and n or ("Chat " .. i) end
                                    return vals
                                end }),
                        }
                    },

                    -- Debug Status Display
                    debugStatus = {
                        type = "description",
                        name = "",
                        order = 4,
                        width = "full",
                        fontSize = "medium",
                        func = function()
                            local status = {}
                            tinsert(status, "|cff00ff00Debug Status:|r")

                            -- Show current debug level
                            local currentLevel = self:GetSetting("global", "debugLevel")
                            local levelNames = {
                                [ns.DEBUG_LEVELS.NONE] = "None",
                                [ns.DEBUG_LEVELS.ERROR] = "Error",
                                [ns.DEBUG_LEVELS.WARN] = "Warning",
                                [ns.DEBUG_LEVELS.INFO] = "Info",
                                [ns.DEBUG_LEVELS.DEBUG] = "Debug",
                                [ns.DEBUG_LEVELS.TRACE] = "Trace"
                            }
                            tinsert(status,
                                format("  Debug Level: |cff00ff00%s|r", levelNames[currentLevel] or "Unknown"))

                            -- Show dev mode status
                            local devMode = NAG:IsDevModeEnabled()
                            tinsert(status,
                                format("  Developer Mode: |cff00ff00%s|r", devMode and "Enabled" or "Disabled"))

                            -- Show debug output channel (use chat window name when available)
                            local ch = self:GetSetting("global", "debugOutputChannel", 1)
                            local chLabel
                            if _G.GetChatWindowInfo then
                                local name = select(1, _G.GetChatWindowInfo(ch))
                                chLabel = (name and name ~= "" and name) or format("Chat %d", ch)
                            else
                                chLabel = format("Chat %d", ch)
                            end
                            tinsert(status,
                                format("  Debug Output: |cff00ff00%s|r", chLabel))
                            -- Per-level overrides summary (when any level uses a custom channel)
                            local overrides = {}
                            for lvl, name in pairs({ [ns.DEBUG_LEVELS.ERROR] = "Error", [ns.DEBUG_LEVELS.WARN] = "Warn", [ns.DEBUG_LEVELS.INFO] = "Info", [ns.DEBUG_LEVELS.DEBUG] = "Debug", [ns.DEBUG_LEVELS.TRACE] = "Trace" }) do
                                local v = self:GetSetting("global", "debugOutputChannelByLevel." .. tostring(lvl), 0)
                                if v and tonumber(v) and tonumber(v) ~= 0 then
                                    local lab = _G.GetChatWindowInfo and (select(1, _G.GetChatWindowInfo(v)) or "")
                                    tinsert(overrides, name .. "→" .. ((lab and lab ~= "") and lab or ("Chat " .. v)))
                                end
                            end
                            if #overrides > 0 then
                                tinsert(status, format("  Per-level: |cff00ff00%s|r", table.concat(overrides, ", ")))
                            end

                            -- Note: Testing mode now uses unified encounter timer system
                            -- See EncounterStopwatch.lua for configuration

                            return table.concat(status, "\n")
                        end
                    }
                }
            },

            -- Performance Settings Group
            performanceSettingsGroup = {
                type = "group",
                name = L["performanceSettingsGroup"] or "Performance",
                desc = L["performanceSettingsGroupDesc"] or "Performance optimization settings",
                order = 12,
                inline = true,
                args = {
                    enablePerformanceOptimizations = OptionsFactory:CreateToggle(L["enablePerformanceOptimizations"] or "Enable Performance Optimizations", L["enablePerformanceOptimizationsDesc"] or "Enable caching and performance optimizations for better performance",
                        function(info) return self:GetSetting("global", "enablePerformanceOptimizations", true) end,
                        function(info, value) self:SetSetting("global", "enablePerformanceOptimizations", value) end,
                        {
                            order = 1,
                            width = "default"
                        }
                    ),
                    enableThrottling = OptionsFactory:CreateToggle(L["enableThrottling"] or "Enable Throttling", L["enableThrottlingDesc"] or "Enable throttling for high-frequency updates to reduce performance impact",
                        function(info) return self:GetSetting("global", "enableThrottling", true) end,
                        function(info, value) self:SetSetting("global", "enableThrottling", value) end,
                        {
                            order = 2,
                            width = "default"
                        }
                    ),
                    enableMemoryManagement = OptionsFactory:CreateToggle(L["enableMemoryManagement"] or "Enable Memory Management", L["enableMemoryManagementDesc"] or "Enable object pooling and memory optimizations",
                        function(info) return self:GetSetting("global", "enableMemoryManagement", true) end,
                        function(info, value) self:SetSetting("global", "enableMemoryManagement", value) end,
                        {
                            order = 3,
                            width = "default"
                        }
                    ),
                    cacheCleanupInterval = OptionsFactory:CreateRange(L["cacheCleanupInterval"] or "Cache Cleanup Interval", L["cacheCleanupIntervalDesc"] or "Interval in seconds for automatic cache cleanup",
                        function(info) return self:GetSetting("global", "cacheCleanupInterval", 30) end,
                        function(info, value) self:SetSetting("global", "cacheCleanupInterval", value) end,
                        {
                            order = 4,
                            width = "double",
                            min = 10,
                            max = 300,
                            step = 10,
                            bigStep = 30
                        }
                    ),
                    throttleInterval = OptionsFactory:CreateRange(L["throttleInterval"] or "Throttle Interval", L["throttleIntervalDesc"] or "Minimum interval in seconds between throttled function calls",
                        function(info) return self:GetSetting("global", "throttleInterval", 0.1) end,
                        function(info, value) self:SetSetting("global", "throttleInterval", value) end,
                        {
                            order = 5,
                            width = "double",
                            min = 0.01,
                            max = 1.0,
                            step = 0.01,
                            bigStep = 0.05
                        }
                    ),
                    performanceStatus = {
                        type = "description",
                        name = "",
                        order = 6,
                        width = "full",
                        fontSize = "medium",
                        func = function()
                            local status = {}
                            tinsert(status, "|cff00ff00Performance Status:|r")

                            -- Show current performance settings
                            local optimizations = self:GetSetting("global", "enablePerformanceOptimizations", true)
                            local throttling = self:GetSetting("global", "enableThrottling", true)
                            local memory = self:GetSetting("global", "enableMemoryManagement", true)
                            local cleanupInterval = self:GetSetting("global", "cacheCleanupInterval", 30)
                            local throttleInterval = self:GetSetting("global", "throttleInterval", 0.1)

                            tinsert(status, format("  Optimizations: |cff00ff00%s|r", optimizations and "Enabled" or "Disabled"))
                            tinsert(status, format("  Throttling: |cff00ff00%s|r", throttling and "Enabled" or "Disabled"))
                            tinsert(status, format("  Memory Management: |cff00ff00%s|r", memory and "Enabled" or "Disabled"))
                            tinsert(status, format("  Cache Cleanup: |cff00ff00%s seconds|r", cleanupInterval))
                            tinsert(status, format("  Throttle Interval: |cff00ff00%s seconds|r", throttleInterval))

                            return table.concat(status, "\n")
                        end
                    }
                }
            },

            -- Category Management Actions
            categoryActionsGroup = {
                type = "group",
                name = "",
                order = 15,
                inline = true,
                args = {
                    enableAllCategories = {
                        type = "execute",
                        name = L["enableAllCategories"] or "Enable All",
                        desc = L["enableAllCategoriesDesc"] or "Enable debug output for all categories",
                        order = 1,
                        width = 0.5,
                        func = function()
                            for _, category in pairs(ns.DEBUG_CATEGORIES) do
                                self:SetSetting("global", "debugCategories." .. category, true)
                            end

                            self:RequestOptionsRefresh("enable_all_debug_categories")
                        end
                    },
                    disableAllCategories = {
                        type = "execute",
                        name = L["disableAllCategories"] or "Disable All",
                        desc = L["disableAllCategoriesDesc"] or "Disable debug output for all categories",
                        order = 2,
                        width = 0.5,
                        func = function()
                            for _, category in pairs(ns.DEBUG_CATEGORIES) do
                                self:SetSetting("global", "debugCategories." .. category, false)
                            end

                            self:RequestOptionsRefresh("disable_all_debug_categories")
                        end
                    }
                }
            },

            -- Category Status Display
            categoryStatus = {
                type = "description",
                name = function()
                    local enabledCategories = {}
                    local disabledCategories = {}

                    for _, category in pairs(ns.DEBUG_CATEGORIES) do
                        local isEnabled = self:GetSetting("global", "debugCategories." .. category)
                        if isEnabled then
                            tinsert(enabledCategories, category:upper())
                        else
                            tinsert(disabledCategories, category:upper())
                        end
                    end

                    local status = "|cff00ff00Enabled Categories:|r "
                    if #enabledCategories > 0 then
                        status = status .. table.concat(enabledCategories, ", ")
                    else
                        status = status .. "None"
                    end

                    status = status .. "\n|cffff0000Disabled Categories:|r "
                    if #disabledCategories > 0 then
                        status = status .. table.concat(disabledCategories, ", ")
                    else
                        status = status .. "None"
                    end

                    -- Show current mode
                    if #enabledCategories > 0 then
                        status = status ..
                            "\n\n|cffff9900Mode: Filtering Mode|r - Only DEBUG/TRACE from enabled categories will be shown"
                        status = status ..
                            "\n|cffff9900Note: ERROR/WARN/INFO messages from all modules will still be shown|r"
                    else
                        status = status .. "\n\n|cffff9900Mode: Global Mode|r - Using global debug level for all modules"
                    end

                    return status
                end,
                order = 16,
                width = "full",
                fontSize = "medium",
            },

            debugTools = {
                type = "group",
                name = L["debugTools"] or "Debug Tools",
                desc = L["debugToolsDesc"] or "Development and debugging tools",
                order = 18,
                childGroups = "tree",
                hidden = function() return not NAG:IsDevModeEnabled() end,
                args = self:CreateModernModuleDebugOptions()
            }
        }
    }
end

function OptionsManager:CreateResetOptions()
    return {
        type = "group",
        name = L["Reset Options"] or "Reset Options",
        desc = L["Reset various categories of settings to their default values"] or "Reset various categories of settings to their default values",
        childGroups = "tree",
        args = {
            -- Warning header
            warningHeader = {
                type = "header",
                name = L["warningHeader"] or "Reset Options",
                order = 1,
            },
            warningDesc = {
                type = "description",
                name =
                "|cFFFF0000WARNING:|r These actions will permanently delete your current settings and cannot be undone. Your license key information will be preserved.",
                order = 2,
                fontSize = "medium",
                width = "full",
            },

            -- Complete reset section
            completeResetHeader = {
                type = "header",
                name = L["completeResetHeader"] or "Complete Reset",
                order = 10,
            },
            resetAll = {
                type = "execute",
                name = L["resetAll"] or "Reset All Settings",
                desc = L["resetAllDesc"] or
                    "Reset ALL settings to their default values. This includes global, character, and class settings. Your license key information will be preserved.",
                order = 11,
                width = "full",
                confirm = true,
                confirmText = L["resetAllConfirm"] or "Are you sure you want to reset ALL NAG settings to defaults?",
                func = function()
                    ResetManager:PerformSmartReset("all")
                end,
            },

            -- Selective reset section
            selectiveResetHeader = {
                type = "header",
                name = L["selectiveResetHeader"] or "Selective Reset",
                order = 20,
            },
            selectiveResetDesc = {
                type = "description",
                name = L["selectiveResetDesc"] or "Reset specific categories of settings:",
                order = 21,
                fontSize = "medium",
                width = "full",
            },

            -- Global settings reset
            resetGlobal = {
                type = "execute",
                name = L["resetGlobal"] or "Reset Global Settings",
                desc = L["resetGlobalDesc"] or
                    "Reset all global settings (debug levels, developer mode, testing settings) to their default values.",
                order = 22,
                width = 1,
                confirm = true,
                confirmText = L["resetGlobalConfirm"] or
                    "Are you sure you want to reset all global settings to defaults?",
                func = function()
                    ResetManager:PerformSmartReset("global")
                end,
            },

            -- Character settings reset
            resetChar = {
                type = "execute",
                name = L["resetCharacter"] or "Reset Character Settings",
                desc = L["resetCharacterDesc"] or
                    "Reset all character-specific settings (position, character-specific preferences) to their default values.",
                order = 23,
                width = 1,
                confirm = true,
                confirmText = L["resetCharacterConfirm"] or
                    "Are you sure you want to reset all character-specific settings to defaults?",
                func = function()
                    ResetManager:PerformSmartReset("char")
                end,
            },

            -- Class settings reset
            resetClass = {
                type = "execute",
                name = L["resetClass"] or "Reset Class Settings",
                desc = L["resetClassDesc"] or
                    "Reset all class-specific settings (class rotations, class-specific preferences) to their default values.",
                order = 24,
                width = 1,
                confirm = true,
                confirmText = L["resetClassConfirm"] or
                    "Are you sure you want to reset all class-specific settings to defaults?",
                func = function()
                    ResetManager:PerformSmartReset("class")
                end,
            },

            -- Position reset
            resetPosition = {
                type = "execute",
                name = L["resetPosition"] or "Reset Position",
                desc = L["resetPositionDesc"] or "Reset the module frame to its default position.",
                order = 25,
                width = 1,
                confirm = true,
                confirmText = L["resetPositionConfirm"] or "Are you sure you want to reset the frame position to default?",
                func = function()
                    ResetManager:ResetPosition()
                end,
            },
        }
    }
end

function OptionsManager:CreateAcknowledgementsOptions()
    local CLASS_IDS = {
        WARRIOR = 1,
        PALADIN = 2,
        HUNTER = 3,
        ROGUE = 4,
        PRIEST = 5,
        DEATHKNIGHT = 6,
        SHAMAN = 7,
        MAGE = 8,
        WARLOCK = 9,
        MONK = 10,
        DRUID = 11,
        DEMONHUNTER = 12,
        EVOKER = 13
    }
    local contributors = {
        DEATHKNIGHT = { "@rakizi", "@Fonsas", "@darkfrog", "@headrippa" },
        DEMONHUNTER = {},
        DRUID = { "@rakizi", "@Fonsas", "@darkfrog", "@repikas" },
        EVOKER = {},
        HUNTER = { "@rakizi", "@Fonsas", "@bicarbdx", "@pummel" },
        MAGE = { "@rakizi", "@Fonsas", "@repikas" },
        MONK = { '@Mantipper', '@Fonsas' },
        PALADIN = { "@rakizi", "@Fonsas", "@surveillant", "@mysto" },
        PRIEST = { "@rakizi", "@Fonsas", "@JiW" },
        ROGUE = { "@rakizi", "@Fonsas", "@bicarbdx", "@sqwurrely", "@darkfrog" },
        SHAMAN = { "@rakizi", "@Fonsas", "@mysto", "@jiw", "@jeb" },
        WARLOCK = { "@rakizi", "@Fonsas" },
        WARRIOR = { "@rakizi", "@Fonsas", "@mysto" },
    }

    -- Build class contributors args
    local classContributorsArgs = {}
    for class, discordHandles in pairs(contributors) do
        if #discordHandles > 0 then
            classContributorsArgs[class] = {
                type = "group",
                name = '',
                order = CLASS_IDS[class] or 99,
                inline = true,
                args = {
                    contributors = {
                        type = "description",
                        name = function()
                            local classID = CLASS_IDS[class]
                            local classInfo = classID and WoWAPI.GetClassInfo(classID)
                            local classColor = RAID_CLASS_COLORS[class]
                            local className = classInfo and classInfo.className or class
                            local handles = {}
                            for i = 1, #discordHandles do
                                handles[i] = discordHandles[i]
                            end
                            for i = #handles, 2, -1 do
                                local j = math.random(i)
                                handles[i], handles[j] = handles[j], handles[i]
                            end
                            return format("|c%s%s:|r %s",
                                classColor.colorStr,
                                className,
                                table.concat(handles, ", "))
                        end,
                        order = 1,
                        fontSize = "medium",
                        width = "full",
                    },
                },
            }
        end
    end

    return {
        type = "group",
        name = L["Acknowledgements"] or "Acknowledgements",
        desc = L["Special thanks and acknowledgements to contributors"] or "Special thanks and acknowledgements to contributors",
        childGroups = "tree",
        args = {
            generalThanks = {
                type = "group",
                name = "",
                order = 1,
                inline = true,
                args = {
                    header = {
                        type = "header",
                        name = L["Special Thanks"] or "Special Thanks",
                        order = 1,
                    },
                    description = {
                        type = "description",
                        name =
                            "Next Action Guide would not be possible without the support and contributions of many individuals in the Ebon Hold community. " ..
                            "We extend our heartfelt thanks to everyone who has helped make this addon what it is today.",
                        order = 2,
                        fontSize = "medium",
                        width = "full",
                    },
                    generalContributors = {
                        type = "description",
                        name = function()
                            local text = "\n|cFFFFD100Core Contributors:|r\n\n"
                            text = text .. "• |cFF00FF00Rakizi|r - Lead Developer & NAG Project Maintainer (@rakizi)\n"
                            text = text .. "• |cFF00FF00Fonsas|r - Development & God of all the rest (@fonsas)\n"
                            text = text .. "\n|cFFFFD100Special Thanks:|r\n\n"
                            text = text .. "• " .. L["specialThanks"] .. "\n"
                            text = text .. "• The WoWSims team for their incredible work\n"
                            text = text .. "• Class Discord communities for their valuable feedback\n"
                            text = text .. "• All our supporters and testers\n"
                            return text
                        end,
                        order = 3,
                        fontSize = "medium",
                        width = "full",
                    },
                },
            },
            classContributors = {
                type = "group",
                name = L["classContributors"] or "Cata Class Contributors",
                order = 2,
                args = classContributorsArgs,
            },
        }
    }
end

-- Create modern, organized module debug options
function OptionsManager:CreateModernModuleDebugOptions()
    local args = {}

    -- Initialize search term if not set
    if not self.moduleSearchTerm then
        self.moduleSearchTerm = ""
    end

    -- Debug Categories Section
    args.categoriesHeader = {
        type = "header",
        name = L["categoriesHeader"] or "Debug Categories",
        order = 1,
    }
    -- Search for modules
    args.moduleSearch = OptionsFactory:CreateInput(L["moduleSearch"] or "Search Modules", L["moduleSearchDesc"] or "Type to filter modules by name",
        function()
            return self.moduleSearchTerm or ""
        end,
        function(info, value)
            self.moduleSearchTerm = value:lower()
            self:RequestOptionsRefresh("module_debug_search")
        end,
        { order = 2, width = "full" }
    )

    args.categoriesDesc = {
        type = "description",
        name =
        "Enable debug output for specific categories of modules. Only affects DEBUG and TRACE messages. WARN, ERROR, and INFO messages follow the global debug level.",
        order = 3,
        fontSize = "medium",
        width = "full",
    }

    -- Create category groups using Ace3 group functionality
    local order = 10
    local categoryGroups = {
        core = {
            name = L["core"] or "Core & Services",
            categories = { ns.DEBUG_CATEGORIES.SERVICES, ns.DEBUG_CATEGORIES.MANAGERS, ns.DEBUG_CATEGORIES.UTILITIES },
            order = order
        },
        display = {
            name = L["OptionsManagerDisplay"] or "Display & UI",
            categories = { ns.DEBUG_CATEGORIES.DISPLAY, ns.DEBUG_CATEGORIES.RENDERERS },
            order = order + 10
        },
        features = {
            name = L["features"] or "Features & Data",
            categories = { ns.DEBUG_CATEGORIES.FEATURES, ns.DEBUG_CATEGORIES.DATA, ns.DEBUG_CATEGORIES.PROCESSORS },
            order = order + 20
        },
        events = {
            name = L["events"] or "Events & Handlers",
            categories = { ns.DEBUG_CATEGORIES.EVENTS, ns.DEBUG_CATEGORIES.HANDLERS },
            order = order + 30
        },
        class = {
            name = L["OptionsManagerClass"] or "Class & Combat",
            categories = { ns.DEBUG_CATEGORIES.CLASS, ns.DEBUG_CATEGORIES.COMBAT },
            order = order + 40
        },
        debug = {
            name = L["OptionsManagerDebug"] or "Debug & Development",
            categories = { ns.DEBUG_CATEGORIES.DEBUG, ns.DEBUG_CATEGORIES.TESTS },
            order = order + 50
        }
    }

    -- Create category group sections using Ace3 groups
    for groupKey, group in pairs(categoryGroups) do
        args[groupKey .. "Group"] = {
            type = "group",
            name = group.name,
            order = group.order,
            inline = true,
            args = {}
        }

        -- Individual category toggles for this group
        for i, category in ipairs(group.categories) do
            args[groupKey .. "Group"].args[category .. "Toggle"] = OptionsFactory:CreateToggle(
                category:upper(),
                "Enable DEBUG/TRACE output for " .. category:upper() .. " category modules",
                function()
                    return self:GetSetting("global", "debugCategories." .. category)
                end,
                function(_, value)
                    self:SetSetting("global", "debugCategories." .. category, value)
                end,
                { order = i, width = 0.3 }
            )
        end
    end

    -- Note: Category Management Actions and Status Display are handled in the main debug group
    -- to avoid duplication. This section focuses on individual category controls.

    -- Module Overrides Section (for special cases)
    args.overridesHeader = {
        type = "header",
        name = L["overridesHeader"] or "Module Overrides",
        order = 100,
    }

    args.overridesDesc = {
        type = "description",
        name =
        "Override category settings for specific modules. Use this to completely disable debug output for problematic modules.",
        order = 101,
        fontSize = "medium",
        width = "full",
    }


    -- Create module override groups (organized by type) - but as inline groups, not nested tabs
    local moduleGroups = {
        core = { name = "Core Modules", modules = {} },
        display = { name = "Display & UI", modules = {} },
        features = { name = "Features", modules = {} },
        services = { name = "Services", modules = {} },
        debug = { name = "Debug Tools", modules = {} }
    }

    -- Categorize modules
    for moduleName, module in NAG:IterateModules() do
        local group = "core" -- default

        -- Categorize based on module name
        if moduleName:find("Display") or moduleName:find("UI") or moduleName:find("Frame") then
            group = "display"
        elseif moduleName:find("Manager") or moduleName:find("Service") then
            group = "services"
        elseif moduleName:find("APL") or moduleName:find("Spell") or moduleName:find("Combat") or moduleName:find("Data") then
            group = "features"
        elseif moduleName:find("Debug") or moduleName:find("Test") then
            group = "debug"
        end

        table.insert(moduleGroups[group].modules, moduleName)
    end

    -- Create module override groups as inline groups, not nested tabs
    local moduleOrder = 110
    for groupKey, group in pairs(moduleGroups) do
        if #group.modules > 0 then
            args[groupKey .. "OverridesGroup"] = {
                type = "group",
                name = group.name,
                order = moduleOrder,
                inline = false,
                args = {}
            }

            -- Sort modules alphabetically
            table.sort(group.modules)

            -- Create module toggles for this group
            for i, moduleName in ipairs(group.modules) do
                -- Check if module should be shown based on search filter
                local shouldShow = true
                if self.moduleSearchTerm and self.moduleSearchTerm ~= "" then
                    if not moduleName:lower():find(self.moduleSearchTerm) then
                        shouldShow = false
                    end
                end

                if shouldShow then
                    args[groupKey .. "OverridesGroup"].args[moduleName .. "Override"] = OptionsFactory:CreateToggle(
                        moduleName,
                        "Completely disable debug output for " .. moduleName .. " (overrides category settings)",
                        function()
                            local moduleDB = self.db and self.db:GetNamespace(moduleName, true)
                            local v = moduleDB and moduleDB.global and moduleDB.global.debugEnabled
                            return v == false -- Show as enabled when debug is disabled (inverted logic)
                        end,
                        function(_, value)
                            local moduleDB = self.db and self.db:GetNamespace(moduleName, true)
                            if moduleDB and moduleDB.global then
                                moduleDB.global.debugEnabled = not value -- Inverted logic
                            end
                        end,
                        { order = i, width = "full" }
                    )
                end
            end

            moduleOrder = moduleOrder + 10
        end
    end

    return args
end
