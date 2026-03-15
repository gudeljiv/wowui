--- @module "NAG.TrinketRegistrationManager"
--- Manages trinket registration functionality for NAG.
---
--- This module provides functions for checking and managing trinket registration.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
--
-- luacheck: ignore GetSpellInfo
-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
--Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture
local GetItemIcon = C_Item and C_Item.GetItemIconByID or _G.GetItemIcon

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type DataManager
--- @type Types
local DataManager, Types
local WoWAPI = ns.WoWAPI

--- @type TrinketTrackingManager
--- @type TooltipParser
--- @type TrinketCommunicationManager
local TrinketTrackingManager, TooltipParser, TrinketCommunicationManager

local TableUtils = ns.TableUtils
local GetItemQualityColor = GetItemQualityColor

local L = ns.AceLocale:GetLocale("NAG", true)


--Libs
local LSM = ns.LibSharedMedia
local AceGUI = ns.AceGUI
local AceConfigRegistry = ns.AceConfigRegistry

-- Lua APIs (using WoW's optimized versions where available)
local GetTime = _G.GetTime
local CreateFrame = _G.CreateFrame
local format = string.format -- WoW's optimized version if available

local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains

local sort = table.sort
local concat = table.concat


-- Constants
local CONSTANTS = {
    TRINKET_SLOTS = { 13, 14 },
    REGISTRATION_STEPS = {
        INITIAL = 1,
        PROC_TYPE = 2,
        STAT_TYPE = 3,
        BUFF_DETECTION = 4,
        TIMING = 5,
        COMPLETE = 6
    },
    STAT_TYPES = {} -- Will be initialized after Types module is loaded
}

-- Default settings
local defaults = {
    char = {
        -- Character-specific settings
        enabled = true,
        ignoredTrinkets = {}, -- Trinkets the user has chosen to ignore
    },
    global = {
        -- Global settings
        customTrinkets = {},          -- User-registered trinket data
        registrationInProgress = nil, -- Current registration session
    },
}

--- @class TrinketRegistrationManager: CoreModule
local TrinketRegistrationManager = NAG:CreateModule("TrinketRegistrationManager", defaults, {
    defaultState = {
        currentRegistration = nil, -- Current registration session
        isRegistering = false,
        trinketAnalysisCache = {}, -- Cache for analyzed trinket data
    },

    -- Event handlers (migrated from StateManager)
    eventHandlers = {
        -- PLAYER_EQUIPMENT_CHANGED removed - now only triggered by TrinketTrackingManager when needed
    },
    messageHandlers = {
        NAG_EXPANSION_DATA_LOADED = true
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.MANAGERS
    }
})
local module = TrinketRegistrationManager
ns.TrinketRegistrationManager = TrinketRegistrationManager

-- Make sure AceGUI is available
if not AceGUI then
    error("TrinketRegistrationManager requires AceGUI-3.0")
end

do -- Module Lifecycle
    function TrinketRegistrationManager:ModuleInitialize()
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        DataManager = NAG:GetModule("DataManager")
        TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")
        TrinketCommunicationManager = NAG:GetModule("TrinketCommunicationManager")

        TooltipParser = NAG:GetModule("TooltipParser")
        Types = NAG:GetModule("Types")
        -- NAG.Types is always available since it loads before other modules
    end

    function TrinketRegistrationManager:ModuleEnable()
        -- ============================ MODULE INITIALIZATION ============================
        self:InitializeStatTypes()
        -- Clear any stale registration data
        self.state.currentRegistration = nil
        self:SetSetting("global", "registrationInProgress", nil)

        -- Hide frame if it exists
        if self.frame then
            self.frame:Hide()
        end

        -- Late-enable path: initialize immediately if data is already ready.
        self:InitializeDataDependentRegistration("ModuleEnable")
    end

    function TrinketRegistrationManager:ModuleDisable()
        -- Hide frame

        if self.frame then
            self.frame:Hide()
        end

        -- Clear cache
        if self.state and self.state.trinketAnalysisCache then
            wipe(self.state.trinketAnalysisCache)
        end

        -- Reset state
        if self.state then
            self.state.currentRegistration = nil
            self.state.isRegistering = false
        end
        self._startupRegistrationInitialized = false
    end

    function TrinketRegistrationManager:InitializeStatTypes()
        -- Initialize STAT_TYPES after Types module is loaded
        CONSTANTS.STAT_CATEGORIES = {
            PRIMARY = {
                NAG.Types:GetType("Stat").STRENGTH,
                NAG.Types:GetType("Stat").AGILITY,
                NAG.Types:GetType("Stat").STAMINA,
                NAG.Types:GetType("Stat").INTELLECT,
                NAG.Types:GetType("Stat").SPIRIT
            },
            SECONDARY = {
                NAG.Types:GetType("Stat").HIT,
                NAG.Types:GetType("Stat").CRIT,
                NAG.Types:GetType("Stat").HASTE,
                NAG.Types:GetType("Stat").EXPERTISE,
                NAG.Types:GetType("Stat").DODGE,
                NAG.Types:GetType("Stat").PARRY,
                NAG.Types:GetType("Stat").MASTERY
            },
            POWER = {
                NAG.Types:GetType("Stat").ATTACK_POWER,
                NAG.Types:GetType("Stat").RANGED_ATTACK_POWER,
                NAG.Types:GetType("Stat").SPELL_POWER,
                NAG.Types:GetType("Stat").SPELL_PENETRATION
            },
            DEFENSE = {
                NAG.Types:GetType("Stat").RESILIENCE,
                NAG.Types:GetType("Stat").ARMOR,
                NAG.Types:GetType("Stat").BONUS_ARMOR,
                NAG.Types:GetType("Stat").ARCANE_RESISTANCE,
                NAG.Types:GetType("Stat").FIRE_RESISTANCE,
                NAG.Types:GetType("Stat").FROST_RESISTANCE,
                NAG.Types:GetType("Stat").NATURE_RESISTANCE,
                NAG.Types:GetType("Stat").SHADOW_RESISTANCE
            },
            RESOURCES = {
                NAG.Types:GetType("Stat").HEALTH,
                NAG.Types:GetType("Stat").MANA,
                NAG.Types:GetType("Stat").MP5
            }
        }

        -- Build flat STAT_TYPES array with localized names
        CONSTANTS.STAT_TYPES = {}
        for category, stats in pairs(CONSTANTS.STAT_CATEGORIES) do
            for _, statId in ipairs(stats) do
                -- Get localized name from the Types registry
                local statName = NAG.Types:GetType("Stat"):GetNameByValue(statId)
                local name = L[string.lower(statName)] or statName
                tinsert(CONSTANTS.STAT_TYPES, { id = statId, name = name, category = category })
            end
        end

        -- Sort stats by category and name
        table.sort(CONSTANTS.STAT_TYPES, function(a, b)
            if a.category == b.category then
                return a.name < b.name
            end
            return a.category < b.category
        end)

        -- Frame will be created on-demand when needed
        -- Don't create frame during initialization

        -- Startup trinket registration is now handled by the data-ready lifecycle boundary.
    end
end

--- Initializes startup trinket registration after expansion data is ready.
--- @param source string|nil Source identifier for diagnostics.
--- @return boolean initialized True if initialization ran.
function TrinketRegistrationManager:InitializeDataDependentRegistration(source)
    if self._startupRegistrationInitialized then
        return true
    end

    if not (DataManager and DataManager.IsDataReady and DataManager:IsDataReady()) then
        return false
    end

    self._startupRegistrationInitialized = true
    self:ReRegisterCustomTrinkets()
    self:VerifyCustomTrinketRegistration()
    self:DebugRegisteredTrinkets()
    if self.debug then
        self:Debug("Initialized startup trinket registration (%s)", tostring(source or "unknown"))
    end
    return true
end

--- Data-ready startup boundary callback for trinket registration initialization.
--- @param message string The message name.
function TrinketRegistrationManager:NAG_EXPANSION_DATA_LOADED(message)
    self:InitializeDataDependentRegistration("NAG_EXPANSION_DATA_LOADED")
end

--- Create the registration UI frame
function TrinketRegistrationManager:CreateRegistrationFrame()
    self:Debug("Creating registration frame")

    -- Create the frame if it doesn't exist
    if not self.frame then
        local frame = AceGUI:Create("Frame")
        self:Debug("Created new AceGUI frame")
        frame:SetTitle("NAG Trinket Registration")
        frame:SetLayout("Fill")
        frame:SetWidth(350)
        frame:EnableResize(true)
        frame:SetCallback("OnClose", function(widget)
            self:Debug("Frame closed")
            self:CancelRegistration()
            AceGUI:Release(widget)
            self.frame = nil
        end)
        self.frame = frame
    else
        self:Debug("Frame already exists")
    end

    -- Frame is created but not automatically shown
    -- It will be shown when user actually needs it
    self:Debug("Frame created (not shown)")

    return self.frame
end

--- Check if a trinket needs registration
function TrinketRegistrationManager:CheckTrinketRegistration(itemId)
    if not itemId then
        self:Debug("No itemId provided")
        return false
    end

    if self.debug then self:Debug("=== Checking if trinket %d needs registration ===", itemId) end

    -- Skip if trinket is ignored
    local ignoredTrinkets = self.db.char.ignoredTrinkets
    if ignoredTrinkets[itemId] then
        if self.debug then self:Debug("Trinket %d is in ignore list", itemId) end
        return false
    end

    -- Check if trinket is already in our custom database (highest priority)
    local customTrinkets = self.db.global.customTrinkets
    if customTrinkets[itemId] then
        local customData = customTrinkets[itemId]
        if customData and customData.buffId and customData.duration then
            if self.debug then
                self:Debug("Trinket %d found in custom database with buffId: %d, duration: %.1f", itemId,
                    customData.buffId, customData.duration)
            end
            return false
        else
            if self.debug then self:Debug("Trinket %d found in custom database but data is incomplete", itemId) end
        end
    end


    -- Check if trinket is in DataManager (more thorough check)
    local trinketData = DataManager:Get(itemId, DataManager.EntityTypes.ITEM)
    if trinketData then
        if self.debug then self:Debug("Trinket %d found in DataManager", itemId) end

        -- Check if it has proc/spell data
        if trinketData.procId or trinketData.spellId then
            local spellId = trinketData.procId or trinketData.spellId
            local spellData = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if spellData and spellData.duration and spellData.duration > 0 then
                if self.debug then
                    self:Debug(
                        "Trinket %d has valid spell data in DataManager (spellId: %d, duration: %.1f)", itemId, spellId,
                        spellData.duration)
                end
                return false
            else
                if self.debug then self:Debug("Trinket %d in DataManager but missing valid spell data", itemId) end
            end
        else
            if self.debug then self:Debug("Trinket %d in DataManager but missing procId/spellId", itemId) end
        end
    else
        if self.debug then self:Debug("Trinket %d not found in DataManager", itemId) end
    end

    -- Additional check: see if we have any related spells for this item in DataManager
    local relatedSpells = DataManager:GetRelated(itemId, DataManager.EntityTypes.ITEM, DataManager.EntityTypes.SPELL)
    if relatedSpells and next(relatedSpells) then
        if self.debug then self:Debug("Trinket %d has related spells in DataManager", itemId) end
        -- Check if any of the related spells have valid duration
        for spellId, _ in pairs(relatedSpells) do
            local spellData = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if spellData and spellData.duration and spellData.duration > 0 then
                if self.debug then
                    self:Debug("Trinket %d has valid related spell %d with duration %.1f", itemId, spellId,
                        spellData.duration)
                end
                return false
            end
        end
    end

    -- Final check: ensure our custom trinkets are properly registered in DataManager
    -- This handles the case where custom trinkets exist but weren't properly re-registered
    local customTrinkets = self.db.global.customTrinkets
    if customTrinkets and customTrinkets[itemId] then
        local customData = customTrinkets[itemId]
        if customData and customData.buffId and customData.duration then
            if self.debug then self:Debug("Found custom trinket %d but it's not in DataManager, re-registering", itemId) end
            -- Re-register this specific trinket
            self:ReRegisterSingleTrinket(itemId, customData)
            return false
        end
    end

    if self.debug then self:Debug("Trinket %d needs registration - not found in any database", itemId) end
    return true
end

--- Event handler for equipment changes
--- @deprecated
--- @param event string The event name
--- @param equipmentSlot number The equipment slot that changed
--- @param hasCurrent boolean Whether the slot has a current item
function TrinketRegistrationManager:PLAYER_EQUIPMENT_CHANGED(event, equipmentSlot, hasCurrent)
    if self.debug then self:Debug("Equipment changed in slot %d", equipmentSlot) end

    -- Only process trinket slots
    if not tContains(CONSTANTS.TRINKET_SLOTS, equipmentSlot) then
        self:Debug("Slot is not a trinket slot, ignoring")
        return
    end

    -- Cancel any existing registration
    if self.state.currentRegistration then
        self:Debug("Canceling existing registration")
        self:CancelRegistration()
    end

    -- Check if new trinket needs registration
    local itemId = GetInventoryItemID("player", equipmentSlot)
    if itemId then
        if self.debug then self:Debug("Checking trinket: %s", tostring(itemId)) end

        -- Debug the current state of the trinket
        self:DebugTrinketState(itemId)

        if self:CheckTrinketRegistration(itemId) then
            self:Debug("Starting registration for unregistered trinket")
            self:StartRegistration(itemId)
        else
            if self.debug then self:Debug("Trinket %d does not need registration - already registered", itemId) end
        end
    else
        if self.debug then self:Debug("No item found in slot %d", equipmentSlot) end
    end
end

--- Start the registration process for a trinket
function TrinketRegistrationManager:StartRegistration(itemId)
    local itemName = WoWAPI.GetItemInfo(itemId)
    local startTime = GetTime()
    local REQUEST_TIMEOUT = 3.0     -- Match TrinketCommunicationManager's timeout
    self:Debug("Starting registration for trinket: %s (ItemID: %d) at time: %.2f", itemName, itemId, startTime)

    -- Try to get data from other players first, but only if the module exists
    if TrinketCommunicationManager then
        self:Debug("TrinketCommunicationManager found, attempting to request data from other players")
        -- Request data from other players
        if TrinketCommunicationManager:RequestTrinketData(itemId) then
            self:Debug("Data request sent successfully, waiting 3.0 seconds for responses")

            -- Create a function to check responses that we can cancel if needed
            local function checkResponses()
                local checkTime = GetTime()
                local timeElapsed = checkTime - startTime

                -- Get current response data
                local data = TrinketCommunicationManager:CheckTrinketResponses(itemId)

                -- If we have data and less than timeout has passed, show validation
                if data then
                    self:Debug("Received trinket data from %s after %.2f seconds", data.sender, timeElapsed)
                    return -- Let TrinketCommunicationManager handle showing the validation window
                end

                -- If we've waited long enough and still no data, do manual registration
                if timeElapsed >= REQUEST_TIMEOUT then
                    self:Debug("No responses received after %.2f seconds, proceeding with manual registration",
                        timeElapsed)
                    self:InitiateManualRegistration(itemId)
                else
                    -- Still waiting
                    self:Debug("Still waiting for responses (%.2f seconds remaining)", REQUEST_TIMEOUT - timeElapsed)
                    C_Timer.After(0.1, checkResponses)
                end
            end

            -- Start checking for responses
            C_Timer.After(0.1, checkResponses)
            return
        else
            self:Debug("Failed to send data request, falling back to manual registration")
        end
    else
        self:Debug("TrinketCommunicationManager not available, proceeding with manual registration")
    end

    -- If we get here, either no comm module or couldn't send request
    self:InitiateManualRegistration(itemId)
end

--- Initiate the manual registration process
function TrinketRegistrationManager:InitiateManualRegistration(itemId)
    local itemName = WoWAPI.GetItemInfo(itemId)
    self:Debug("Starting manual registration for %s (ItemID: %d)", itemName, itemId)

    -- Create frame if it doesn't exist
    if not self.frame then
        self:Debug("Creating registration frame")
        self:CreateRegistrationFrame()
    end

    -- Store registration data
    self.state.currentRegistration = {
        itemId = itemId,
        step = CONSTANTS.REGISTRATION_STEPS.INITIAL,
        data = {}
    }

    -- Save current registration in case of reload
    self:SetSetting("global", "registrationInProgress", self.state.currentRegistration)
    self:Debug("Registration data stored. Starting with step: %d", CONSTANTS.REGISTRATION_STEPS.INITIAL)

    -- Show initial popup
    self:Debug("Showing initial registration step")
    self:ShowInitialStep()
end

--- Show the current registration step
function TrinketRegistrationManager:ShowRegistrationStep()
    if not self.state.currentRegistration then
        self:Debug("No current registration to show")
        return
    end

    local step = self.state.currentRegistration.step
    local frame = self.frame

    if not frame then
        self:Debug("Creating frame as it doesn't exist")
        frame = self:CreateRegistrationFrame()
    end

    if self.debug then self:Debug("Showing registration step %d", step) end

    -- Clear previous content
    frame:ReleaseChildren()

    -- Update content based on current step
    if step == CONSTANTS.REGISTRATION_STEPS.INITIAL then
        self:ShowInitialStep()
    elseif step == CONSTANTS.REGISTRATION_STEPS.PROC_TYPE then
        self:ShowProcTypeStep()
    elseif step == CONSTANTS.REGISTRATION_STEPS.STAT_TYPE then
        self:ShowStatTypeStep()
    elseif step == CONSTANTS.REGISTRATION_STEPS.BUFF_DETECTION then
        self:ShowBuffDetectionStep()
    elseif step == CONSTANTS.REGISTRATION_STEPS.TIMING then
        self:ShowTimingStep()
    end

    -- Ensure frame is shown
    frame:Show()
end

--- Show the proc type selection step
function TrinketRegistrationManager:ShowProcTypeStep()
    local frame = self.frame
    if not frame then return end

    -- Clear previous content
    frame:ReleaseChildren()

    -- Get item info
    local itemId = self.state.currentRegistration.itemId
    local itemName = WoWAPI.GetItemInfo(itemId)

    -- Create main container
    local mainContainer = AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("Flow")
    mainContainer:SetFullWidth(true)
    mainContainer:SetHeight(400)     -- Increased height for better content display
    frame:AddChild(mainContainer)

    -- Add header
    local headerLabel = AceGUI:Create("Label")
    headerLabel:SetText(format("What type of trinket is %s?", itemName))
    headerLabel:SetFontObject(GameFontNormalLarge)
    headerLabel:SetFullWidth(true)
    headerLabel:SetJustifyH("CENTER")
    mainContainer:AddChild(headerLabel)

    -- Add description group
    local descGroup = AceGUI:Create("SimpleGroup")
    descGroup:SetLayout("Flow")
    descGroup:SetFullWidth(true)
    descGroup:SetHeight(150)
    mainContainer:AddChild(descGroup)

    -- Try to auto-detect proc type using TrinketTrackingManager
    local autoDetectedProcType = nil
    local result = TrinketTrackingManager:AnalyzeTrinket(itemId)
    if result and result.trinketInfo and result.trinketInfo.procType then
        autoDetectedProcType = result.trinketInfo.procType
    end

    if autoDetectedProcType then
        local autoDetectLabel = AceGUI:Create("Label")
        autoDetectLabel:SetText("|cFF00FF00Auto-detected as a " ..
            (autoDetectedProcType == "use" and "On-Use" or "Proc") ..
            " trinket.|r")
        autoDetectLabel:SetFullWidth(true)
        descGroup:AddChild(autoDetectLabel)

        -- Add button to use auto-detected type
        local autoBtn = AceGUI:Create("Button")
        autoBtn:SetText("Use Auto-Detected Type")
        autoBtn:SetWidth(200)
        autoBtn:SetCallback("OnClick", function()
            self.state.currentRegistration.data.procType = autoDetectedProcType
            self.state.currentRegistration.step = CONSTANTS.REGISTRATION_STEPS.STAT_TYPE
            self:ShowRegistrationStep()
        end)
        descGroup:AddChild(autoBtn)

        -- Add note that they can still choose manually
        local noteLabel = AceGUI:Create("Label")
        noteLabel:SetText("You can also select the type manually below.")
        noteLabel:SetFullWidth(true)
        descGroup:AddChild(noteLabel)
    end

    -- Add trinket type descriptions
    local typeDescGroup = AceGUI:Create("SimpleGroup")
    typeDescGroup:SetLayout("Flow")
    typeDescGroup:SetFullWidth(true)
    typeDescGroup:SetHeight(120)
    mainContainer:AddChild(typeDescGroup)

    -- Add On-Use description
    local useDesc = AceGUI:Create("Label")
    useDesc:SetText("|cFF00FF00On-Use Trinket:|r\n" ..
        "• Requires manual activation\n" ..
        "• Usually has a cooldown\n" ..
        "• Example: Clicking the trinket to activate it")
    useDesc:SetFullWidth(true)
    typeDescGroup:AddChild(useDesc)

    -- Add Proc description
    local procDesc = AceGUI:Create("Label")
    procDesc:SetText("|cFF00FF00Proc Trinket:|r\n" ..
        "• Activates automatically\n" ..
        "• Usually has a chance to proc\n" ..
        "• Example: Has a chance to trigger when you cast spells")
    procDesc:SetFullWidth(true)
    typeDescGroup:AddChild(procDesc)

    -- Create button group
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    buttonGroup:SetHeight(100)
    mainContainer:AddChild(buttonGroup)

    -- Add proc button
    local procBtn = AceGUI:Create("Button")
    procBtn:SetText("Proc Trinket")
    procBtn:SetWidth(150)
    -- Highlight if auto-detected as proc
    if autoDetectedProcType == "proc" then
        procBtn:SetText("|cFF00FF00Proc Trinket|r")
    end
    procBtn:SetCallback("OnClick", function()
        self.state.currentRegistration.data.procType = "proc"
        self.state.currentRegistration.step = CONSTANTS.REGISTRATION_STEPS.STAT_TYPE
        self:ShowRegistrationStep()
    end)
    buttonGroup:AddChild(procBtn)

    -- Add on-use button
    local useBtn = AceGUI:Create("Button")
    useBtn:SetText("On-Use Trinket")
    useBtn:SetWidth(150)
    -- Highlight if auto-detected as use
    if autoDetectedProcType == "use" then
        useBtn:SetText("|cFF00FF00On-Use Trinket|r")
    end
    useBtn:SetCallback("OnClick", function()
        self.state.currentRegistration.data.procType = "use"
        self.state.currentRegistration.step = CONSTANTS.REGISTRATION_STEPS.STAT_TYPE
        self:ShowRegistrationStep()
    end)
    buttonGroup:AddChild(useBtn)

    -- Create navigation group
    local navGroup = AceGUI:Create("SimpleGroup")
    navGroup:SetLayout("Flow")
    navGroup:SetFullWidth(true)
    navGroup:SetHeight(50)
    mainContainer:AddChild(navGroup)

    -- Add back button
    local backBtn = AceGUI:Create("Button")
    backBtn:SetText("Back")
    backBtn:SetWidth(100)
    backBtn:SetCallback("OnClick", function()
        self.state.currentRegistration.step = CONSTANTS.REGISTRATION_STEPS.INITIAL
        self:ShowRegistrationStep()
    end)
    navGroup:AddChild(backBtn)

    -- Add cancel button
    local cancelBtn = AceGUI:Create("Button")
    cancelBtn:SetText("Cancel")
    cancelBtn:SetWidth(100)
    cancelBtn:SetCallback("OnClick", function()
        self:CancelRegistration()
    end)
    navGroup:AddChild(cancelBtn)

    -- Add help text
    local helpLabel = AceGUI:Create("Label")
    helpLabel:SetText(
        "|cFF00FF00Tip:|r If you're not sure, check the trinket's tooltip for words like 'Use:' or 'Chance on hit'")
    helpLabel:SetFullWidth(true)
    helpLabel:SetJustifyH("CENTER")
    mainContainer:AddChild(helpLabel)

    -- Set frame height
    frame:SetHeight(450)
    frame:Show()
end

--- Show the stat type selection step
function TrinketRegistrationManager:ShowStatTypeStep()
    local frame = self.frame
    if not frame then return end

    -- Get current registration data
    local registration = self.state.currentRegistration
    if not registration then return end

    -- Make sure stats table exists
    registration.data.stats = registration.data.stats or {}

    -- Try to auto-detect trinket stats using TooltipParser
    local autoDetectedStats = {}
    local hasAutoDetectedStats = false

    -- Get item ID from registration
    local itemId = registration.itemId
    if itemId then
        -- Use TrinketTrackingManager for analysis
        local result = TrinketTrackingManager:AnalyzeTrinket(itemId)
        if result and result.trinketInfo then
            local trinketInfo = result.trinketInfo

            -- Convert statType fields to stats array
            local stats = {}
            if trinketInfo.statType1 and trinketInfo.statType1 ~= -1 then
                tinsert(stats, trinketInfo.statType1)
            end
            if trinketInfo.statType2 and trinketInfo.statType2 ~= -1 then
                tinsert(stats, trinketInfo.statType2)
            end
            if trinketInfo.statType3 and trinketInfo.statType3 ~= -1 then
                tinsert(stats, trinketInfo.statType3)
            end

            if #stats > 0 then
                autoDetectedStats = stats
                hasAutoDetectedStats = true
                -- Pre-populate registration data with auto-detected stats
                registration.data.stats = CopyTable(autoDetectedStats)
            end

            -- If we auto-detected a proc type, store it
            if trinketInfo.procType then
                registration.data.procType = trinketInfo.procType
            end

            -- If we auto-detected buff ID, duration, or ICD, store them too
            if trinketInfo.buffId then
                registration.data.buffId = trinketInfo.buffId
            end
            if trinketInfo.duration and trinketInfo.duration > 0 then
                registration.data.duration = trinketInfo.duration
            end
            if trinketInfo.icd and trinketInfo.icd > 0 then
                registration.data.icd = trinketInfo.icd
            end
        end
    end

    -- Create main container
    local mainContainer = AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("Flow")
    mainContainer:SetFullWidth(true)
    mainContainer:SetHeight(600)
    frame:AddChild(mainContainer)

    -- Add header
    local headerLabel = AceGUI:Create("Label")
    headerLabel:SetText(format("What stats does Item %d provide?", itemId))
    headerLabel:SetFontObject(GameFontNormalLarge)
    headerLabel:SetFullWidth(true)
    headerLabel:SetJustifyH("CENTER")
    mainContainer:AddChild(headerLabel)

    -- Add description
    local descLabel = AceGUI:Create("Label")
    descLabel:SetText("Select all stats that this trinket provides when it activates.\n" ..
        "You can find this information in the trinket's tooltip.")
    descLabel:SetFullWidth(true)
    descLabel:SetJustifyH("CENTER")
    mainContainer:AddChild(descLabel)

    -- Add auto-detection notice if we found stats
    if hasAutoDetectedStats then
        local autoDetectLabel = AceGUI:Create("Label")
        autoDetectLabel:SetText("|cFF00FF00Auto-detected stats:|r " ..
            table.concat(self:GetStatNames(autoDetectedStats), ", "))
        autoDetectLabel:SetFullWidth(true)
        autoDetectLabel:SetJustifyH("CENTER")
        mainContainer:AddChild(autoDetectLabel)

        -- Add button to use auto-detected stats
        local autoBtn = AceGUI:Create("Button")
        autoBtn:SetText("Use Auto-Detected Stats")
        autoBtn:SetWidth(200)
        autoBtn:SetCallback("OnClick", function()
            self.state.currentRegistration.step = CONSTANTS.REGISTRATION_STEPS.BUFF_DETECTION
            self:ShowRegistrationStep()
        end)
        mainContainer:AddChild(autoBtn)

        -- Add note that they can still choose manually
        local noteLabel = AceGUI:Create("Label")
        noteLabel:SetText("You can also select stats manually below.")
        noteLabel:SetFullWidth(true)
        noteLabel:SetJustifyH("CENTER")
        mainContainer:AddChild(noteLabel)
    end

    -- Create scroll container for stats
    local scrollContainer = AceGUI:Create("ScrollFrame")
    scrollContainer:SetLayout("Flow")
    scrollContainer:SetFullWidth(true)
    scrollContainer:SetHeight(300)
    mainContainer:AddChild(scrollContainer)

    -- Add stats by category
    for category, stats in pairs(CONSTANTS.STAT_CATEGORIES) do
        -- Create category group
        local group = AceGUI:Create("InlineGroup")
        group:SetTitle(category)
        group:SetFullWidth(true)
        group:SetLayout("Flow")
        scrollContainer:AddChild(group)

        -- Add checkboxes for each stat in this category
        for _, statId in ipairs(stats) do
            local checkbox = AceGUI:Create("CheckBox")
            local statName = NAG.Types:GetType("Stat"):GetNameByValue(statId)
            checkbox:SetLabel(statName)

            -- Check the box if stat was auto-detected or previously selected
            checkbox:SetValue(tContains(registration.data.stats, statId))

            checkbox:SetCallback("OnValueChanged", function(widget, event, value)
                self:UpdateStatSelection(statId, value)
            end)
            group:AddChild(checkbox)
        end
    end

    -- Add help text
    local helpLabel = AceGUI:Create("Label")
    helpLabel:SetText("|cFF00FF00Tip:|r Look for stats that are added when the trinket activates, not the base stats.")
    helpLabel:SetFullWidth(true)
    helpLabel:SetJustifyH("CENTER")
    mainContainer:AddChild(helpLabel)

    -- Add navigation buttons
    local navGroup = AceGUI:Create("SimpleGroup")
    navGroup:SetLayout("Flow")
    navGroup:SetFullWidth(true)
    navGroup:SetHeight(50)
    mainContainer:AddChild(navGroup)

    -- Add back button
    local backBtn = AceGUI:Create("Button")
    backBtn:SetText("Back")
    backBtn:SetWidth(100)
    backBtn:SetCallback("OnClick", function()
        self.state.currentRegistration.step = CONSTANTS.REGISTRATION_STEPS.PROC_TYPE
        self:ShowRegistrationStep()
    end)
    navGroup:AddChild(backBtn)

    -- Add continue button
    local continueBtn = AceGUI:Create("Button")
    continueBtn:SetText("Continue")
    continueBtn:SetWidth(100)
    continueBtn:SetCallback("OnClick", function()
        if #registration.data.stats > 0 then
            self.state.currentRegistration.step = CONSTANTS.REGISTRATION_STEPS.BUFF_DETECTION
            self:ShowRegistrationStep()
        else
            local errorLabel = AceGUI:Create("Label")
            errorLabel:SetText("|cFFFF0000Please select at least one stat|r")
            errorLabel:SetFullWidth(true)
            errorLabel:SetJustifyH("CENTER")
            mainContainer:AddChild(errorLabel)
            C_Timer.After(2, function()
                errorLabel:Release()
            end)
        end
    end)
    navGroup:AddChild(continueBtn)

    -- Add cancel button
    local cancelBtn = AceGUI:Create("Button")
    cancelBtn:SetText("Cancel")
    cancelBtn:SetWidth(100)
    cancelBtn:SetCallback("OnClick", function()
        self:CancelRegistration()
    end)
    navGroup:AddChild(cancelBtn)

    -- Set frame height
    frame:SetHeight(650)
    frame:Show()
end

--- Update stat selection
function TrinketRegistrationManager:UpdateStatSelection(statId, selected)
    if not self.state.currentRegistration then return end

    -- Initialize stats table if needed
    self.state.currentRegistration.data.stats = self.state.currentRegistration.data.stats or {}

    if selected then
        -- Add stat if selected
        tinsert(self.state.currentRegistration.data.stats, statId)
    else
        -- Remove stat if unselected
        for i, id in ipairs(self.state.currentRegistration.data.stats) do
            if id == statId then
                tremove(self.state.currentRegistration.data.stats, i)
                break
            end
        end
    end
end

--- Function to round duration to match Blizzard's standard
local function RoundDuration(duration)
    if duration <= 0 then return duration end
    -- Round to nearest 0.5
    return math.floor(duration * 2 + 0.5) / 2
end

--- Function to update buff list with icons
local function UpdateBuffList(self)
    local scroll = self.state.buffListScroll
    if not scroll then return end

    scroll:ReleaseChildren()

    -- Sort buffs by name
    local sortedBuffs = {}
    for spellId, buffInfo in pairs(self.state.detectedBuffs) do
        local spellInfo = WoWAPI.GetSpellInfo(spellId)
        local name = spellInfo and spellInfo.name or nil
        tinsert(sortedBuffs, {
            spellId = spellId,
            name = name or "Unknown",
            info = buffInfo
        })
    end
    table.sort(sortedBuffs, function(a, b) return a.name < b.name end)

    -- Create buff entries
    for _, buffData in ipairs(sortedBuffs) do
        local buffGroup = AceGUI:Create("SimpleGroup")
        buffGroup:SetLayout("Flow")
        buffGroup:SetFullWidth(true)
        buffGroup:SetHeight(32) -- Reduced height

        -- Create buff icon
        local icon = AceGUI:Create("Icon")
        icon:SetImage(GetSpellTexture(buffData.spellId))
        icon:SetImageSize(24, 24) -- Slightly smaller icon
        icon:SetWidth(24)
        icon:SetHeight(24)
        buffGroup:AddChild(icon)

        -- Create info text
        local infoLabel = AceGUI:Create("Label")
        local duration = buffData.info.maxDuration or buffData.info.duration
        local durationText = duration > 0 and format("%.1fs", duration) or "?"
        local icdText = ""

        -- Debug output to check values
        if self.debug then
            self:Debug("Buff: %s, Duration: %s, ICD: %s", buffData.name, tostring(duration),
                tostring(buffData.info.icd))
        end

        -- Ensure ICD is properly displayed
        if buffData.info.icd and buffData.info.icd > 0 then
            icdText = format(", ICD: %.1fs", buffData.info.icd)
        end

        infoLabel:SetText(format("%s (%s%s)",
            buffData.name,
            durationText,
            icdText))
        infoLabel:SetWidth(240) -- Increased width for buff info
        buffGroup:AddChild(infoLabel)

        -- Add spacer to push button to the right
        local spacer = AceGUI:Create("SimpleGroup")
        spacer:SetWidth(5) -- Small gap between info and button
        spacer:SetHeight(1)
        buffGroup:AddChild(spacer)

        -- Create select button
        local selectBtn = AceGUI:Create("Button")
        selectBtn:SetText("Apply")
        selectBtn:SetWidth(90) -- Keep button width the same
        selectBtn:SetCallback("OnClick", function()
            -- Populate the manual entry fields with the detected values
            self.state.spellIdEdit:SetText(tostring(buffData.spellId))
            self.state.durationEdit:SetText(tostring(buffData.info.maxDuration or buffData.info.duration))
            self.state.icdEdit:SetText(tostring(buffData.info.icd or "0"))
        end)
        buffGroup:AddChild(selectBtn)

        scroll:AddChild(buffGroup)
    end
end

--- Show the buff detection step
function TrinketRegistrationManager:ShowBuffDetectionStep()
    local frame = self.frame
    frame:ReleaseChildren()

    local itemId = self.state.currentRegistration.itemId
    local itemName = WoWAPI.GetItemInfo(itemId)

    -- Create main container
    local mainContainer = AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("Flow")
    mainContainer:SetFullWidth(true)
    mainContainer:SetHeight(500)
    frame:AddChild(mainContainer)

    -- Create header with item info
    local headerGroup = AceGUI:Create("InlineGroup")
    headerGroup:SetLayout("Flow")
    headerGroup:SetFullWidth(true)
    headerGroup:SetHeight(80)
    mainContainer:AddChild(headerGroup)

    -- Add item icon and name
    local itemIcon = AceGUI:Create("Icon")
    itemIcon:SetImage(GetItemIcon(itemId))
    itemIcon:SetImageSize(32, 32)
    itemIcon:SetWidth(32)
    itemIcon:SetHeight(32)
    headerGroup:AddChild(itemIcon)

    local nameLabel = AceGUI:Create("Label")
    nameLabel:SetText(format("|cFFFFD100%s|r", itemName))
    nameLabel:SetFontObject(GameFontNormalLarge)
    nameLabel:SetWidth(250)
    headerGroup:AddChild(nameLabel)

    -- Add instruction text
    local instructionText =
    "Click the trinket or use abilities in combat to trigger it's effect. The buff will be tracked for selection."

    local instructionLabel = AceGUI:Create("Label")
    instructionLabel:SetText(instructionText)
    instructionLabel:SetFullWidth(true)
    instructionLabel:SetFontObject(GameFontNormal)
    mainContainer:AddChild(instructionLabel)

    -- Create buff tracking section with fixed height
    local buffGroup = AceGUI:Create("InlineGroup")
    buffGroup:SetTitle("Detected Buffs")
    buffGroup:SetLayout("Fill")     -- Changed to Fill for proper scrolling
    buffGroup:SetFullWidth(true)
    buffGroup:SetHeight(235)        -- Fixed height for buff section
    mainContainer:AddChild(buffGroup)

    -- Create scroll container
    local scrollContainer = AceGUI:Create("ScrollFrame")
    scrollContainer:SetLayout("List")       -- Changed to List for better buff entry layout
    scrollContainer:SetFullWidth(true)
    scrollContainer:SetFullHeight(true)     -- Take full height of parent
    buffGroup:AddChild(scrollContainer)

    -- Store scroll frame for updates
    self.state.buffListScroll = scrollContainer

    -- Initialize buff tracking
    self.state.detectedBuffs = self.state.detectedBuffs or {}

    -- Take initial buff snapshot
    self.state.buffSnapshot = {}
    local i = 1
    while true do
        local name, _, _, _, _, expirationTime, _, _, _, spellId = UnitBuff("player", i)
        if not name then break end
        self.state.buffSnapshot[spellId] = true
        i = i + 1
    end

    -- Add manual entry section
    local manualGroup = AceGUI:Create("InlineGroup")
    manualGroup:SetLayout("Flow")
    manualGroup:SetFullWidth(true)
    manualGroup:SetHeight(10)
    mainContainer:AddChild(manualGroup)

    -- Add spell ID input
    self.state.spellIdEdit = AceGUI:Create("EditBox")
    self.state.spellIdEdit:SetLabel("Spell ID")
    self.state.spellIdEdit:SetWidth(80)
    manualGroup:AddChild(self.state.spellIdEdit)

    -- Add duration input
    self.state.durationEdit = AceGUI:Create("EditBox")
    self.state.durationEdit:SetLabel("Duration (sec)")
    self.state.durationEdit:SetWidth(85)
    manualGroup:AddChild(self.state.durationEdit)

    -- Add ICD input
    self.state.icdEdit = AceGUI:Create("EditBox")
    self.state.icdEdit:SetLabel("ICD (sec)")
    self.state.icdEdit:SetWidth(80)
    manualGroup:AddChild(self.state.icdEdit)

    -- Add manual entry button
    local addBtn = AceGUI:Create("Button")
    addBtn:SetText("Add")
    addBtn:SetWidth(60)
    addBtn:SetCallback("OnClick", function()
        local spellId = tonumber(self.state.spellIdEdit:GetText())
        local duration = tonumber(self.state.durationEdit:GetText())
        local icd = tonumber(self.state.icdEdit:GetText()) or 0

        if not spellId or not duration then
            self:ShowError("Please enter valid Spell ID and Duration")
            return
        end

        -- Stop monitoring
        self.state.isMonitoringBuffs = false
        self.state.stopMonitoring = true

        -- Store registration data
        local registrationData = {
            itemId = self.state.currentRegistration.itemId,
            buffId = spellId,
            duration = duration,
            stats = self.state.currentRegistration.data.stats,
            icd = icd
        }

        -- Show confirmation
        local itemName = WoWAPI.GetItemInfo(registrationData.itemId)
        local spellInfo = WoWAPI.GetSpellInfo(spellId)
        StaticPopupDialogs["NAG_TRINKET_REGISTRATION_CONFIRM"] = {
            text = format("Register %s with:\n\nBuff: %s\nDuration: %.1f\nICD: %.1f\n\nIs this correct?",
                itemName or "Unknown",
                spellInfo and spellInfo.name or "Unknown",
                duration,
                icd),
            button1 = "Yes",
            button2 = "No",
            OnAccept = function()
                if self.frame then
                    self.frame:Hide()
                end
                self:CompleteTrinketRegistration(
                    registrationData.itemId,
                    registrationData.buffId,
                    registrationData.duration,
                    registrationData.stats,
                    registrationData.icd
                )
            end,
            OnCancel = function()
                self.state.isMonitoringBuffs = true
                self.state.stopMonitoring = false
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3
        }
        StaticPopup_Show("NAG_TRINKET_REGISTRATION_CONFIRM")
    end)
    manualGroup:AddChild(addBtn)

    -- Add navigation buttons
    local navGroup = AceGUI:Create("SimpleGroup")
    navGroup:SetLayout("Flow")
    navGroup:SetFullWidth(true)
    navGroup:SetHeight(40)
    mainContainer:AddChild(navGroup)

    -- Back button
    local backBtn = AceGUI:Create("Button")
    backBtn:SetText("Back")
    backBtn:SetWidth(100)
    backBtn:SetCallback("OnClick", function()
        self.state.currentRegistration.step = CONSTANTS.REGISTRATION_STEPS.STAT_TYPE
        self:ShowRegistrationStep()
    end)
    navGroup:AddChild(backBtn)

    -- Cancel button
    local cancelBtn = AceGUI:Create("Button")
    cancelBtn:SetText("Cancel")
    cancelBtn:SetWidth(100)
    cancelBtn:SetCallback("OnClick", function()
        self:CancelRegistration()
    end)
    navGroup:AddChild(cancelBtn)

    -- Start buff monitoring
    self.state.isMonitoringBuffs = true
    self:MonitorBuffs()

    -- Set frame dimensions
    frame:SetHeight(550)
    frame:SetWidth(400)
    frame:Show()
end

-- Add throttle variable at the top with other locals
local lastBuffUpdate = 0
local BUFF_UPDATE_THRESHOLD = 0.1 -- 100ms threshold

--- Monitor buffs for detection
function TrinketRegistrationManager:MonitorBuffs()
    -- Check if we should stop monitoring
    if not self.state.isMonitoringBuffs or self.state.stopMonitoring then
        return
    end

    -- Throttle updates
    local currentTime = GetTime()
    if (currentTime - lastBuffUpdate) < BUFF_UPDATE_THRESHOLD then
        C_Timer.After(0.1, function()
            self:MonitorBuffs()
        end)
        return
    end
    lastBuffUpdate = currentTime

    -- Check for new buffs
    local i = 1
    local changes = false
    while true do
        local name, _, _, _, _, expirationTime, _, _, _, spellId = UnitBuff("player", i)
        if not name then break end

        -- Initialize buff tracking if needed
        if not self.state.detectedBuffs[spellId] then
            self.state.detectedBuffs[spellId] = {
                duration = 0,
                maxDuration = 0,
                lastProcTime = 0,
                firstProcTime = 0,
                icdValues = {},
                icd = nil,
                isActive = false,        -- Track if buff is currently active
                lastFullDurationTime = 0 -- Track when we last saw a full duration
            }
            changes = true
        end

        local buffInfo = self.state.detectedBuffs[spellId]
        local currentTime = GetTime()
        local duration = RoundDuration(expirationTime - currentTime)

        -- If this is close to max duration we've seen (within 0.1s), consider it a fresh proc
        if duration >= (buffInfo.maxDuration - 0.1) then
            -- Update max duration if this is higher
            if duration > buffInfo.maxDuration then
                buffInfo.maxDuration = duration
            end

            -- If we've seen a full duration before, calculate ICD
            if buffInfo.lastFullDurationTime > 0 then
                local timeBetweenProcs = currentTime - buffInfo.lastFullDurationTime

                -- Only consider reasonable times (between 1 second and 10 minutes)
                if timeBetweenProcs >= 1 and timeBetweenProcs < 600 then
                    -- Store this ICD value with a rolling cap to prevent unbounded growth
                    tinsert(buffInfo.icdValues, timeBetweenProcs)
                    if #buffInfo.icdValues > 50 then
                        tremove(buffInfo.icdValues, 1)
                    end
                    if self.debug then
                        self:Trace("New proc for %s - Time since last full duration proc: %.1f seconds",
                            name, timeBetweenProcs)
                    end

                    -- Find lowest reasonable ICD value
                    local lowestICD = timeBetweenProcs
                    for _, icdValue in ipairs(buffInfo.icdValues) do
                        if icdValue < lowestICD then
                            lowestICD = icdValue
                        end
                    end

                    -- Update ICD
                    buffInfo.icd = RoundDuration(lowestICD)
                    if self.debug then self:Debug("Updated ICD for %s to %.1f seconds", name, buffInfo.icd) end
                    changes = true
                end
            end

            -- Update last full duration time
            buffInfo.lastFullDurationTime = currentTime
            changes = true
        end

        -- Update active state
        if not buffInfo.isActive then
            buffInfo.isActive = true
            changes = true
        end

        i = i + 1
    end

    -- Check for buffs that dropped
    for spellId, buffInfo in pairs(self.state.detectedBuffs) do
        if buffInfo.isActive then
            -- Check if buff is still present
            local stillActive = false
            local j = 1
            while true do
                local currentSpellId = select(10, UnitBuff("player", j))
                if not currentSpellId then break end
                if currentSpellId == spellId then
                    stillActive = true
                    break
                end
                j = j + 1
            end

            -- If buff dropped, mark it as inactive
            if not stillActive then
                buffInfo.isActive = false
                changes = true
            end
        end
    end

    -- Only update UI if there were changes
    if changes then
        UpdateBuffList(self)
    end

    -- Continue monitoring
    C_Timer.After(0.1, function()
        self:MonitorBuffs()
    end)
end

--- Show the timing measurement step
function TrinketRegistrationManager:ShowTimingStep()
    local frame = self.frame
    frame:ReleaseChildren()     -- Clear previous content

    local itemId = self.state.currentRegistration.itemId
    local itemName = WoWAPI.GetItemInfo(itemId)
    local buffId = self.state.currentRegistration.data.buffId
    local isProcTrinket = self.state.currentRegistration.data.procType == "proc"

    -- Create main container
    local mainContainer = AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("Flow")
    mainContainer:SetFullWidth(true)
    mainContainer:SetHeight(300)
    frame:AddChild(mainContainer)

    -- Create header group
    local headerGroup = AceGUI:Create("SimpleGroup")
    headerGroup:SetLayout("Flow")
    headerGroup:SetFullWidth(true)
    headerGroup:SetHeight(60)
    mainContainer:AddChild(headerGroup)

    -- Add description text
    local descLabel = AceGUI:Create("Label")
    descLabel:SetText(format("Measuring %s duration", itemName))
    descLabel:SetFontObject(GameFontNormalLarge)
    descLabel:SetFullWidth(true)
    headerGroup:AddChild(descLabel)

    -- Add help text
    local helpLabel = AceGUI:Create("Label")
    helpLabel:SetText(isProcTrinket and
        "Wait for the trinket to proc 3 times to measure duration..." or
        "Use the trinket 3 times to measure duration...")
    helpLabel:SetFontObject(GameFontNormal)
    helpLabel:SetFullWidth(true)
    headerGroup:AddChild(helpLabel)

    -- Create status group
    local statusGroup = AceGUI:Create("SimpleGroup")
    statusGroup:SetLayout("Flow")
    statusGroup:SetFullWidth(true)
    statusGroup:SetHeight(60)
    mainContainer:AddChild(statusGroup)

    -- Add status text
    local statusLabel = AceGUI:Create("Label")
    statusLabel:SetText("Waiting for first measurement...")
    statusLabel:SetFontObject(GameFontHighlight)
    statusLabel:SetFullWidth(true)
    statusGroup:AddChild(statusLabel)

    -- Store references for updates
    self.state.timingData = {
        procStart = 0,
        procEnd = 0,
        lastProcTime = 0,
        measurements = {},
        measuring = true,
        statusText = statusLabel
    }

    -- Start monitoring buff
    self:MonitorBuff(buffId)

    -- Create button group
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    buttonGroup:SetHeight(100)
    mainContainer:AddChild(buttonGroup)

    -- Add manual entry button
    local manualBtn = AceGUI:Create("Button")
    manualBtn:SetText("Enter Duration Manually")
    manualBtn:SetWidth(200)
    manualBtn:SetCallback("OnClick", function()
        -- Clear content
        frame:ReleaseChildren()

        -- Create manual entry container
        local entryContainer = AceGUI:Create("SimpleGroup")
        entryContainer:SetLayout("Flow")
        entryContainer:SetFullWidth(true)
        entryContainer:SetHeight(200)
        frame:AddChild(entryContainer)

        -- Add entry text
        local entryLabel = AceGUI:Create("Label")
        entryLabel:SetText("Enter the buff duration (in seconds):")
        entryLabel:SetFontObject(GameFontNormalLarge)
        entryLabel:SetFullWidth(true)
        entryContainer:AddChild(entryLabel)

        -- Add edit box
        local editBox = AceGUI:Create("EditBox")
        editBox:SetLabel("Duration (seconds)")
        editBox:SetWidth(200)
        editBox:SetCallback("OnEnterPressed", function(widget, _, text)
            local duration = tonumber(text)
            if not duration or duration <= 0 then
                local errorLabel = AceGUI:Create("Label")
                errorLabel:SetText("|cFFFF0000Please enter a valid duration|r")
                errorLabel:SetFullWidth(true)
                entryContainer:AddChild(errorLabel)
                C_Timer.After(2, function()
                    errorLabel:Release()
                end)
                return
            end

            -- Hide registration frame before completing registration
            frame:Hide()

            self:CompleteTrinketRegistration(duration)
        end)
        entryContainer:AddChild(editBox)

        -- Add confirm button
        local confirmBtn = AceGUI:Create("Button")
        confirmBtn:SetText("Confirm")
        confirmBtn:SetWidth(100)
        confirmBtn:SetCallback("OnClick", function()
            local duration = tonumber(editBox:GetText())
            if not duration or duration <= 0 then
                local errorLabel = AceGUI:Create("Label")
                errorLabel:SetText("|cFFFF0000Please enter a valid duration|r")
                errorLabel:SetFullWidth(true)
                entryContainer:AddChild(errorLabel)
                C_Timer.After(2, function()
                    errorLabel:Release()
                end)
                return
            end

            self:CompleteTrinketRegistration(duration)
        end)
        entryContainer:AddChild(confirmBtn)
    end)
    buttonGroup:AddChild(manualBtn)

    -- Add navigation buttons
    local backBtn = AceGUI:Create("Button")
    backBtn:SetText("Back")
    backBtn:SetWidth(100)
    backBtn:SetCallback("OnClick", function()
        self.state.timingData.measuring = false
        self.state.currentRegistration.step = CONSTANTS.REGISTRATION_STEPS.BUFF_DETECTION
        self:ShowRegistrationStep()
    end)
    buttonGroup:AddChild(backBtn)

    local closeBtn = AceGUI:Create("Button")
    closeBtn:SetText("Cancel")
    closeBtn:SetWidth(100)
    closeBtn:SetCallback("OnClick", function()
        self.state.timingData.measuring = false
        self:CancelRegistration()
    end)
    buttonGroup:AddChild(closeBtn)

    -- Calculate and set the final frame height
    local totalHeight = 60     -- Header group
        + 60                   -- Status group
        + 100                  -- Button group
        + 40                   -- Padding

    frame:SetHeight(totalHeight)
    frame:Show()
end

--- Monitor a specific buff for timing measurements
function TrinketRegistrationManager:MonitorBuff(buffId)
    if not self.state.timingData.measuring then return end

    local hasAura = false
    local i = 1
    while true do
        local name, _, _, _, _, expirationTime, _, _, _, spellId = UnitBuff("player", i)
        if not name then break end

        if spellId == buffId then
            hasAura = true
            local currentTime = GetTime()

            -- If we weren't tracking this proc yet
            if self.state.timingData.procStart == 0 then
                self.state.timingData.procStart = currentTime
                self.state.timingData.lastProcTime = expirationTime - currentTime
                if self.debug then
                    self:Debug("Started measuring proc: %.2f seconds remaining",
                        self.state.timingData.lastProcTime)
                end
            end
            break
        end
        i = i + 1
    end

    -- If we were tracking a proc and it's gone
    if not hasAura and self.state.timingData.procStart > 0 then
        local currentTime = GetTime()
        local duration = currentTime - self.state.timingData.procStart

        -- If the duration seems valid (not too short/long)
        if duration > 1 and duration < 300 then
            table.insert(self.state.timingData.measurements, duration)
            local count = #self.state.timingData.measurements

            -- Update status text
            if self.state.timingData.statusText then
                self.state.timingData.statusText:SetText(format(
                    "Measurements: %d/3\nLast duration: %.1f seconds",
                    count, duration
                ))
            end

            -- If we have enough measurements
            if count >= 3 then
                -- Calculate average duration
                local total = 0
                for _, d in ipairs(self.state.timingData.measurements) do
                    total = total + d
                end
                local avgDuration = total / count

                -- Complete registration with measured duration
                self:CompleteTrinketRegistration(avgDuration)
                return
            end
        end

        -- Reset for next measurement
        self.state.timingData.procStart = 0
    end

    -- Continue monitoring if still measuring
    if self.state.timingData.measuring then
        C_Timer.After(0.1, function()
            self:MonitorBuff(buffId)
        end)
    end
end

--- Complete the trinket registration process
function TrinketRegistrationManager:CompleteTrinketRegistration(itemIdOrDuration, buffId, duration, stats, icd)
    -- Handle both parameter formats
    local itemId, finalDuration, finalBuffId, finalStats, finalProcType

    if type(itemIdOrDuration) == "number" and not buffId then
        -- Called with just duration from buff detection
        if not self.state.currentRegistration then
            self:Debug("No active registration found!")
            return
        end

        itemId = self.state.currentRegistration.itemId
        finalDuration = itemIdOrDuration
        finalBuffId = self.state.currentRegistration.data.buffId
        finalStats = self.state.currentRegistration.data.stats
        finalProcType = self.state.currentRegistration.data.procType or "proc"
    else
        -- Called with all parameters
        itemId = itemIdOrDuration
        finalDuration = duration
        finalBuffId = buffId
        finalStats = stats
        finalProcType = self.state.currentRegistration and self.state.currentRegistration.data.procType or "proc"
    end

    -- Debug output for registration
    self:Debug("=== Completing Trinket Registration ===")
    if self.debug then self:Debug("ItemId: %d", itemId) end
    if self.debug then self:Debug("BuffId: %d", finalBuffId) end
    if self.debug then self:Debug("Duration: %.1f", finalDuration) end
    if self.debug then self:Debug("Type: %s", finalProcType) end
    self:Debug("Stats:")
    if finalStats then
        for _, statId in ipairs(finalStats) do
            for _, statType in ipairs(CONSTANTS.STAT_TYPES) do
                if statType.id == statId then
                    if self.debug then self:Trace("  - %s (ID: %d)", statType.name, statId) end
                end
            end
        end
    else
        self:Debug("  No stats provided")
    end

    -- Add to DataManager first
    -- Create item path and data
    local itemPath = { "Items", "Trinket", "custom" }
    local itemData = {
        procId = finalBuffId, -- This is crucial - it tells DataManager this is a proc trinket
        spellId = finalBuffId,
        duration = finalDuration,
        ICD = icd or 0, -- Add ICD to item data
        flags = {
            trinket = true,
            proc = finalProcType == "proc",
            use = finalProcType == "use",
            custom = true
        }
    }

    -- Add the item to DataManager
    local itemEntry = DataManager:AddItem(itemId, itemPath, itemData)

    -- Create spell path and data for the proc
    local spellPath = { "Spells", "Trinket", finalProcType }
    local spellData = {
        duration = finalDuration,
        parentId = itemId,
        parentType = DataManager.EntityTypes.ITEM,
        ICD = icd or 0, -- Add ICD to spell data
        flags = {
            proc = finalProcType == "proc",
            use = finalProcType == "use",
            trinket = true,
            custom = true
        }
    }

    -- Add the spell to DataManager
    local spellEntry = DataManager:AddSpell(finalBuffId, spellPath, spellData)

    -- Store the data in our custom trinkets
    local customTrinkets = self.db.global.customTrinkets
    customTrinkets[itemId] = {
        buffId = finalBuffId,
        duration = finalDuration,
        stats = finalStats,
        icd = icd or 0,
        procType = finalProcType -- Store the proc type
    }
    self.db.global.customTrinkets = customTrinkets

    -- Verify stored data
    self:Debug("\nVerifying stored data:")
    local storedData = customTrinkets[itemId]
    if storedData then
        self:Debug("Data saved successfully:")
        if self.debug then self:Debug("  BuffId: %d", storedData.buffId) end
        if self.debug then self:Debug("  Duration: %.1f", storedData.duration) end
        if self.debug then self:Debug("  Type: %s", storedData.procType) end
        if storedData.stats then
            self:Debug("  Stats:")
            for _, statId in ipairs(storedData.stats) do
                for _, statType in ipairs(CONSTANTS.STAT_TYPES) do
                    if statType.id == statId then
                        if self.debug then self:Trace("    - %s (ID: %d)", statType.name, statId) end
                    end
                end
            end
        else
            self:Debug("  No stats stored")
        end
    else
        self:Debug("Failed to save data!")
    end

    -- Clean up registration state
    self.state.currentRegistration = nil
    self.state.buffListScroll = nil
    self.state.detectedBuffs = nil
    self.state.buffSnapshot = nil
    self.state.isRegistering = false
    self.state.stopMonitoring = false
    self.state.isMonitoringBuffs = false
    -- Clean up edit box references
    self.state.spellIdEdit = nil
    self.state.durationEdit = nil
    self.state.icdEdit = nil

    -- Hide and clear frame
    if self.frame then
        self.frame:Hide()
        self.frame:ReleaseChildren()
    end

    -- Print confirmation
    local itemName = WoWAPI.GetItemInfo(itemId)
    print(format("|cFFFFFF00[NAG]|r Successfully registered trinket: %s", itemName or "Unknown"))
end

--- Cancel the current registration process
function TrinketRegistrationManager:CancelRegistration()
    -- Stop buff monitoring
    self.state.isMonitoringBuffs = false
    self.state.stopMonitoring = false
    self.state.isRegistering = false

    -- Clear all registration state
    self.state.currentRegistration = nil
    self.state.buffListScroll = nil
    self.state.detectedBuffs = nil
    self.state.buffSnapshot = nil
    -- Clean up edit box references
    self.state.spellIdEdit = nil
    self.state.durationEdit = nil
    self.state.icdEdit = nil

    -- Hide and clear frame
    if self.frame then
        self.frame:Hide()
        self.frame:ReleaseChildren()
    end
end

--- Helper function to create a button
function TrinketRegistrationManager:CreateButton(parent, text, width, height)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetSize(width or 100, height or 25)
    button:SetText(text)
    return button
end

--- Helper function to create text
function TrinketRegistrationManager:CreateText(parent, text, template)
    local fontString = parent:CreateFontString(nil, "OVERLAY", template or "GameFontNormal")
    fontString:SetText(text)
    fontString:SetJustifyH("CENTER")
    fontString:SetJustifyV("MIDDLE")
    return fontString
end

--- Show the initial registration step
function TrinketRegistrationManager:ShowInitialStep()
    self:Debug("Entering ShowInitialStep")

    -- Check if TrinketCommunicationManager has an active window
    if TrinketCommunicationManager.state.activeWindow then
        self:Debug("TrinketCommunicationManager has an active window, skipping initial step")
        return
    end

    -- Create or get frame
    local frame = self.frame
    if not frame then
        self:Debug("No frame exists, creating new one")
        frame = self:CreateRegistrationFrame()
    end

    -- Clear the frame
    self:Debug("Clearing frame children")
    frame:ReleaseChildren()

    -- Get item info
    local itemId = self.state.currentRegistration.itemId
    if not itemId then
        self:Debug("No itemId in current registration")
        return
    end

    local itemName, _, itemRarity, _, _, _, _, _, _, itemTexture = WoWAPI.GetItemInfo(itemId)
    if not itemName then
        self:Debug("Could not get item info for " .. tostring(itemId))
        return
    end

    self:Debug("Got item info: " .. itemName)

    -- Create main container with Flow layout
    local mainContainer = AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("Flow")
    mainContainer:SetFullWidth(true)
    mainContainer:SetFullHeight(true)
    frame:AddChild(mainContainer)
    self:Debug("Created main container")

    -- Create centered content container
    local contentContainer = AceGUI:Create("SimpleGroup")
    contentContainer:SetLayout("Flow")
    contentContainer:SetWidth(350)      -- Increased width for better readability
    contentContainer:SetHeight(250)     -- Increased height for more content
    mainContainer:AddChild(contentContainer)
    self:Debug("Created content container")

    -- Add item icon and name group
    local itemGroup = AceGUI:Create("SimpleGroup")
    itemGroup:SetLayout("Flow")
    itemGroup:SetFullWidth(true)
    itemGroup:SetHeight(40)
    contentContainer:AddChild(itemGroup)

    -- Add item icon
    local icon = AceGUI:Create("Icon")
    icon:SetImage(itemTexture)
    icon:SetImageSize(32, 32)
    icon:SetWidth(32)
    icon:SetHeight(32)
    itemGroup:AddChild(icon)
    self:Debug("Added item icon")

    -- Add item name with proper color
    local hexColor = select(4, GetItemQualityColor(itemRarity))
    local nameLabel = AceGUI:Create("Label")
    nameLabel:SetText(format("|c%s%s|r", hexColor, itemName))
    nameLabel:SetFontObject(GameFontNormalLarge)
    nameLabel:SetWidth(300)
    itemGroup:AddChild(nameLabel)
    self:Debug("Added item name")

    -- Add description with more detailed information
    local descLabel = AceGUI:Create("Label")
    descLabel:SetText(format("This trinket needs to be registered to help track its effects.\n\n" ..
        "The registration process will help us understand:\n" ..
        "1. Whether it's an On-Use or Proc trinket\n" ..
        "2. What stats it provides\n" ..
        "3. How long its effects last\n\n" ..
        "Would you like to register %s now?", itemName))
    descLabel:SetFontObject(GameFontNormal)
    descLabel:SetFullWidth(true)
    descLabel:SetJustifyH("CENTER")
    contentContainer:AddChild(descLabel)
    self:Debug("Added description")

    -- Add button group
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    buttonGroup:SetHeight(40)
    contentContainer:AddChild(buttonGroup)

    -- Add Yes button with more descriptive text
    local yesBtn = AceGUI:Create("Button")
    yesBtn:SetText("Start Registration")
    yesBtn:SetWidth(150)
    yesBtn:SetCallback("OnClick", function()
        self:Debug("Yes button clicked")
        self.state.currentRegistration.step = CONSTANTS.REGISTRATION_STEPS.PROC_TYPE
        self:ShowRegistrationStep()
    end)
    buttonGroup:AddChild(yesBtn)

    -- Add No button with more descriptive text
    local noBtn = AceGUI:Create("Button")
    noBtn:SetText("Not Now")
    noBtn:SetWidth(150)
    noBtn:SetCallback("OnClick", function()
        self:Debug("No button clicked")
        self:CancelRegistration()
    end)
    buttonGroup:AddChild(noBtn)
    self:Debug("Added buttons")

    -- Add Never ask button with more descriptive text
    local neverAskBtn = AceGUI:Create("Button")
    neverAskBtn:SetText("Don't ask about this trinket again")
    neverAskBtn:SetFullWidth(true)
    neverAskBtn:SetCallback("OnClick", function()
        self:Debug("Never ask button clicked")
        self:BlacklistTrinket(itemId, "user_ignored")
    end)
    contentContainer:AddChild(neverAskBtn)

    -- Add help text
    local helpLabel = AceGUI:Create("Label")
    helpLabel:SetText("|cFF00FF00Tip:|r You can always register this trinket later by right-clicking it in your bags.")
    helpLabel:SetFullWidth(true)
    helpLabel:SetJustifyH("CENTER")
    contentContainer:AddChild(helpLabel)

    -- Make sure frame is shown
    frame:Show()
    self:Debug("Frame shown with all content")
end

--- Resume an in-progress registration
function TrinketRegistrationManager:ResumeRegistration()
    local registration = self.db.global.registrationInProgress
    if not registration then return end

    -- Restore registration state
    self.state.currentRegistration = registration

    -- Show current step
    self:ShowRegistrationStep()

    -- Clear saved state
    self:SetSetting("global", "registrationInProgress", nil)
end

--- Print all registered trinkets
function TrinketRegistrationManager:PrintRegisteredTrinkets()
    local customTrinkets = self.db.global.customTrinkets
    if not next(customTrinkets) then
        print("|cFFFFFF00[NAG]|r No custom trinkets registered.")
        return
    end

    print("|cFFFFFF00[NAG]|r Registered Trinkets:")
    print("----------------------------------------")

    for itemId, data in pairs(customTrinkets) do
        local itemName = WoWAPI.GetItemInfo(itemId)
        local spellInfo = WoWAPI.GetSpellInfo(data.buffId)
        local buffName = spellInfo and spellInfo.name or nil
        local aura = NAG:UnitAura("player", data.buffId)
        local remainingTime = aura and NAG:ItemRemainingTime(data.buffId) or 0

        -- Get additional trinket data from DataManager and TrinketTrackingManager
        local dmItem = DataManager:Get(itemId, DataManager.EntityTypes.ITEM)
        local dmSpell = DataManager:Get(data.buffId, DataManager.EntityTypes.SPELL)
        local trinketInfo = TrinketTrackingManager:GetTrinketInfo(itemId)

        -- Print basic info
        print(format("|cFF00FF00%s|r (ID: %d)", itemName or "Unknown", itemId))
        print(format("  Buff: |cFF00FFFF%s|r (ID: %d)", buffName or "Unknown", data.buffId))

        -- Print type info
        local procType = data.procType or "Unknown"
        if procType == "proc" then
            procType = "Proc"
        elseif procType == "use" then
            procType = "On-Use"
        end
        print(format("  Type: |cFFFFFF00%s|r", procType))

        -- Print timing info
        print(format("  Duration: %.1f seconds", data.duration))
        if data.icd and data.icd > 0 then
            print(format("  ICD: %.1f seconds", data.icd))
        end

        -- Print GCD info
        local isGCD = false
        if dmSpell and dmSpell.flags and dmSpell.flags.gcd then
            isGCD = true
        elseif trinketInfo and trinketInfo.triggersGCD then
            isGCD = true
        end
        print(format("  Triggers GCD: |cFF%s%s|r", isGCD and "FF0000" or "00FF00", isGCD and "Yes" or "No"))

        -- Print current status
        print(format("  Status: %s", isActive and
            format("|cFF00FF00Active|r (%.1f seconds remaining)", remainingTime) or
            "|cFFFF0000Not Active|r"))

        -- Print cooldown info if available
        if dmSpell and dmSpell.cooldown then
            print(format("  Cooldown: %.1f seconds", dmSpell.cooldown))
        end

        -- Print stats
        if data.stats and #data.stats > 0 then
            print("  Stats:")
            for _, statId in ipairs(data.stats) do
                for _, statType in ipairs(CONSTANTS.STAT_TYPES) do
                    if statType.id == statId then
                        print(format("    - %s (ID: %d)", statType.name, statId))
                    end
                end
            end
        else
            print("  Stats: None registered")
        end

        -- Print additional flags if available
        if dmItem and dmItem.flags then
            local flags = {}
            for flag, value in pairs(dmItem.flags) do
                if value == true then
                    tinsert(flags, flag)
                end
            end
            if #flags > 0 then
                print("  Flags: " .. table.concat(flags, ", "))
            end
        end

        print("----------------------------------------")
    end
end

--- Called when a buff is detected during registration
function TrinketRegistrationManager:OnBuffDetected(buffId, duration)
    if not self.state.isRegistering or not self.state.currentRegistration then
        return
    end

    -- Stop monitoring for new buffs
    self.state.stopMonitoring = true
    self.state.isMonitoringBuffs = false

    -- Update registration data
    self.state.currentRegistration.data.buffId = buffId
    self.state.currentRegistration.data.duration = duration

    -- Show confirmation dialog
    local itemName = WoWAPI.GetItemInfo(self.state.currentRegistration.itemId)
    local spellInfo = WoWAPI.GetSpellInfo(buffId)
    local buffName = spellInfo and spellInfo.name or nil

    StaticPopupDialogs["NAG_TRINKET_REGISTRATION_CONFIRM"] = {
        text = format("Confirm registration for %s:\n\nBuff: %s\nDuration: %.1f seconds\n\nIs this correct?",
            itemName or "Unknown Item",
            buffName or "Unknown Buff",
            duration),
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            -- Complete registration with the detected duration
            self:CompleteTrinketRegistration(duration)
        end,
        OnCancel = function()
            -- Reset registration state
            self.state.currentRegistration = nil
            self.state.isRegistering = false
            self.state.stopMonitoring = false
            self.state.isMonitoringBuffs = false

            -- Hide and clear frame
            if self.frame then
                self.frame:Hide()
                self.frame:ReleaseChildren()
            end
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3
    }

    StaticPopup_Show("NAG_TRINKET_REGISTRATION_CONFIRM")
end

--- Re-registers all custom trinkets with DataManager
function TrinketRegistrationManager:ReRegisterCustomTrinkets()
    local customTrinkets = self.db.global.customTrinkets
    if not customTrinkets then
        self:Debug("No custom trinkets found to re-register")
        return
    end

    local count = 0
    count = TableUtils and TableUtils.Size(customTrinkets) or 0
    if self.debug then self:Debug("Re-registering %d custom trinkets", count) end

    for itemId, data in pairs(customTrinkets) do
        -- Validate the data first
        if not data or not data.buffId or not data.duration then
            if self.debug then self:Debug("Skipping invalid trinket data for itemId: %d", itemId) end
        else
            if self.debug then
                self:Debug("Processing custom trinket: %d with buff: %d, duration: %.1f", itemId,
                    data.buffId, data.duration)
            end

            -- Always re-register to ensure data consistency
            -- Create item path and data
            local itemPath = { "Items", "Trinket", "custom" }
            local itemData = {
                procId = data.buffId,
                spellId = data.buffId,
                duration = data.duration,
                ICD = data.icd or 0,
                flags = {
                    trinket = true,
                    proc = data.procType == "proc",
                    use = data.procType == "use",
                    custom = true
                }
            }

            -- Always add/update the item in DataManager
            local itemEntry = DataManager:AddItem(itemId, itemPath, itemData)
            if self.debug then self:Debug("Added/updated item: %d in DataManager", itemId) end

            -- Create spell path and data for the proc
            local spellPath = { "Spells", "Trinket", data.procType or "proc" }
            local spellData = {
                duration = data.duration,
                parentId = itemId,
                parentType = DataManager.EntityTypes.ITEM,
                ICD = data.icd or 0,
                flags = {
                    proc = data.procType == "proc",
                    use = data.procType == "use",
                    trinket = true,
                    custom = true
                }
            }

            -- Always add/update the spell in DataManager
            local spellEntry = DataManager:AddSpell(data.buffId, spellPath, spellData)
            if self.debug then self:Debug("Added/updated spell: %d in DataManager", data.buffId) end
        end
    end

    self:Debug("Custom trinket re-registration complete")
end

--- Debug output of registered trinkets
function TrinketRegistrationManager:DebugRegisteredTrinkets()
    local customTrinkets = self.db.global.customTrinkets
    if not customTrinkets or not next(customTrinkets) then
        self:Debug("No user-registered trinkets found")
        return
    end

    self:Debug("=== User Registered Trinkets ===")
    for itemId, data in pairs(customTrinkets) do
        if not itemId or not data then
            self:Debug("Skipping entry with missing itemId or data: %s", tostring(itemId))
        else
            local itemName = WoWAPI.GetItemInfo(itemId)
            local spellInfo = data.buffId and WoWAPI.GetSpellInfo(data.buffId)
            local buffName = spellInfo and spellInfo.name
            local safeItemId = tonumber(itemId) or 0
            local safeBuffId = tonumber(data.buffId) or 0
            local safeDuration = tonumber(data.duration) or 0
            if not data.buffId or not data.duration then
                self:Debug("Trinket %s (ID: %s) missing buffId or duration, skipping.", itemName or "Unknown",
                    tostring(itemId))
            else
                if self.debug then
                    self:Debug("Trinket: %s (ID: %d)\n" ..
                        "  Buff: %s (ID: %d)\n" ..
                        "  Duration: %.1f seconds", itemName or "Unknown", safeItemId, buffName or "Unknown", safeBuffId,
                        safeDuration)
                end
                if data.stats and #data.stats > 0 then
                    self:Debug("  Stats:")
                    for _, statId in ipairs(data.stats) do
                        for _, statType in ipairs(CONSTANTS.STAT_TYPES) do
                            if statType.id == statId then
                                if self.debug then self:Trace("    - %s (ID: %d)", statType.name, statId) end
                            end
                        end
                    end
                else
                    self:Debug("  Stats: None")
                end
            end
        end
    end
    self:Debug("==============================")
end

--- Add navigation buttons to the current frame
function TrinketRegistrationManager:AddNavigationButtons()
    local frame = self.frame
    if not frame then return end

    -- Create button group
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    frame:AddChild(buttonGroup)

    -- Back button
    local backBtn = AceGUI:Create("Button")
    backBtn:SetText(L["back"])
    backBtn:SetWidth(100)
    backBtn:SetCallback("OnClick", function()
        self.state.currentRegistration.step = self.state.currentRegistration.step - 1
        self:ShowRegistrationStep()
    end)
    buttonGroup:AddChild(backBtn)

    -- Continue button
    local continueBtn = AceGUI:Create("Button")
    continueBtn:SetText(L["continue"])
    continueBtn:SetWidth(100)
    continueBtn:SetCallback("OnClick", function()
        -- Validate current step
        if self:ValidateCurrentStep() then
            self.state.currentRegistration.step = self.state.currentRegistration.step + 1
            self:ShowRegistrationStep()
        end
    end)
    buttonGroup:AddChild(continueBtn)

    -- Cancel button
    local cancelBtn = AceGUI:Create("Button")
    cancelBtn:SetText(L["cancel"])
    cancelBtn:SetWidth(100)
    cancelBtn:SetCallback("OnClick", function()
        self:CancelRegistration()
    end)
    buttonGroup:AddChild(cancelBtn)
end

--- Validate the current registration step
function TrinketRegistrationManager:ValidateCurrentStep()
    if not self.state.currentRegistration then return false end

    local step = self.state.currentRegistration.step
    if step == CONSTANTS.REGISTRATION_STEPS.STAT_TYPE then
        -- Validate stat selection
        local stats = self.state.currentRegistration.data.stats or {}
        if #stats == 0 then
            self:ShowError(L["selectAtLeastOneStat"])
            return false
        end
    end
    -- Add validation for other steps as needed

    return true
end

--- Show an error message in the current frame
function TrinketRegistrationManager:ShowError(message)
    local frame = self.frame
    if not frame then return end

    local errorLabel = AceGUI:Create("Label")
    errorLabel:SetText("|cFFFF0000" .. message .. "|r")
    errorLabel:SetFullWidth(true)
    frame:AddChild(errorLabel)

    C_Timer.After(2, function()
        errorLabel:Release()
    end)
end

function TrinketRegistrationManager:BlacklistTrinket(itemId, reason)
    self:Debug("Blacklisting trinket " .. tostring(itemId) .. " for reason: " .. tostring(reason))
    local ignoredTrinkets = self.db.char.ignoredTrinkets
    ignoredTrinkets[itemId] = reason or "user_ignored"
    self.db.char.ignoredTrinkets = ignoredTrinkets
    self:CancelRegistration()
end

--- Helper function to get stat names from stat IDs
function TrinketRegistrationManager:GetStatNames(statIds)
    if not statIds or #statIds == 0 then return {} end

    local names = {}
    for _, statId in ipairs(statIds) do
        -- Try to get name from Types registry first
        local statName = NAG.Types:GetType("Stat"):GetNameByValue(statId)
        if statName then
            -- Try to get localized name
            local localizedName = L[string.lower(statName)] or statName
            tinsert(names, localizedName)
        else
            -- Fallback if stat not found
            tinsert(names, format("Unknown Stat (%d)", statId))
        end
    end
    return names
end

--- Debug function to show the current state of trinket registration
--- @param itemId number The ID of the trinket to debug
function TrinketRegistrationManager:DebugTrinketState(itemId)
    if not itemId then
        self:Debug("DebugTrinketState: No itemId provided")
        return
    end

    if self.debug then self:Debug("=== Debug Trinket State for ItemID: %d ===", itemId) end

    -- Check custom database
    local customData = self.db.global.customTrinkets[itemId]
    if customData then
        self:Debug("✓ Found in custom database:")
        if self.debug then self:Debug("  BuffId: %d", customData.buffId or 0) end
        if self.debug then self:Debug("  Duration: %.1f", customData.duration or 0) end
        if self.debug then self:Debug("  ProcType: %s", customData.procType or "unknown") end
        if customData.stats then
            if self.debug then self:Debug("  Stats: %d entries", #customData.stats) end
        end
    else
        self:Debug("✗ Not found in custom database")
    end

    -- Check DataManager
    local dmItem = DataManager:Get(itemId, DataManager.EntityTypes.ITEM)
    if dmItem then
        self:Debug("✓ Found in DataManager:")
        if self.debug then self:Debug("  ProcId: %s", tostring(dmItem.procId or "nil")) end
        if self.debug then self:Debug("  SpellId: %s", tostring(dmItem.spellId or "nil")) end
        if dmItem.procId or dmItem.spellId then
            local spellId = dmItem.procId or dmItem.spellId
            local dmSpell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if dmSpell then
                if self.debug then self:Debug("  Spell Duration: %.1f", dmSpell.duration or 0) end
            else
                self:Debug("  Spell not found in DataManager")
            end
        end
    else
        self:Debug("✗ Not found in DataManager")
    end

    -- Check related spells
    local relatedSpells = DataManager:GetRelated(itemId, DataManager.EntityTypes.ITEM, DataManager.EntityTypes.SPELL)
    if relatedSpells and next(relatedSpells) then
        self:Debug("✓ Has related spells in DataManager:")
        for spellId, _ in pairs(relatedSpells) do
            local spellData = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if spellData then
                if self.debug then self:Trace("  Spell %d: duration %.1f", spellId, spellData.duration or 0) end
            end
        end
    else
        self:Debug("✗ No related spells in DataManager")
    end

    -- Check if ignored
    local ignoredTrinkets = self.db.char.ignoredTrinkets
    if ignoredTrinkets[itemId] then
        self:Debug("⚠ Trinket is in ignore list")
    end

    self:Debug("=== End Debug ===")
end

--- Re-register a single custom trinket with DataManager
--- @param itemId number The ID of the trinket
--- @param data table The trinket data
function TrinketRegistrationManager:ReRegisterSingleTrinket(itemId, data)
    if not itemId or not data or not data.buffId or not data.duration then
        self:Debug("Invalid data for single trinket re-registration")
        return
    end

    if self.debug then
        self:Debug("Re-registering single trinket: %d with buff: %d, duration: %.1f", itemId, data.buffId,
            data.duration)
    end

    -- Create item path and data
    local itemPath = { "Items", "Trinket", "custom" }
    local itemData = {
        procId = data.buffId,
        spellId = data.buffId,
        duration = data.duration,
        ICD = data.icd or 0,
        flags = {
            trinket = true,
            proc = data.procType == "proc",
            use = data.procType == "use",
            custom = true
        }
    }

    -- Add/update the item in DataManager
    local itemEntry = DataManager:AddItem(itemId, itemPath, itemData)
    if self.debug then self:Debug("Added/updated item: %d in DataManager", itemId) end

    -- Create spell path and data for the proc
    local spellPath = { "Spells", "Trinket", data.procType or "proc" }
    local spellData = {
        duration = data.duration,
        parentId = itemId,
        parentType = DataManager.EntityTypes.ITEM,
        ICD = data.icd or 0,
        flags = {
            proc = data.procType == "proc",
            use = data.procType == "use",
            trinket = true,
            custom = true
        }
    }

    -- Add/update the spell in DataManager
    local spellEntry = DataManager:AddSpell(data.buffId, spellPath, spellData)
    if self.debug then self:Debug("Added/updated spell: %d in DataManager", data.buffId) end
end

--- Verify that all custom trinkets are properly registered in DataManager
function TrinketRegistrationManager:VerifyCustomTrinketRegistration()
    local customTrinkets = self.db.global.customTrinkets
    if not customTrinkets then
        self:Debug("No custom trinkets to verify")
        return
    end

    self:Debug("=== Verifying Custom Trinket Registration ===")
    local verifiedCount = 0
    local totalCount = 0

    for itemId, data in pairs(customTrinkets) do
        totalCount = totalCount + 1

        if not data or not data.buffId or not data.duration then
            if self.debug then self:Debug("Trinket %d has invalid data, skipping verification", itemId) end
        else
            -- Check if item exists in DataManager
            local dmItem = DataManager:Get(itemId, DataManager.EntityTypes.ITEM)
            local dmSpell = DataManager:Get(data.buffId, DataManager.EntityTypes.SPELL)

            if dmItem and dmSpell then
                if self.debug then self:Debug("✓ Trinket %d properly registered in DataManager", itemId) end
                verifiedCount = verifiedCount + 1
            else
                if self.debug then self:Debug("✗ Trinket %d missing from DataManager, re-registering", itemId) end
                self:ReRegisterSingleTrinket(itemId, data)
                verifiedCount = verifiedCount + 1
            end
        end
    end

    if self.debug then self:Debug("Verification complete: %d/%d trinkets properly registered", verifiedCount, totalCount) end
    self:Debug("=== End Verification ===")
end
