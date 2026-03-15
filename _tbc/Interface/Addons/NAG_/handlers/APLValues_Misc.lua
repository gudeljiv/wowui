--- @module "APLValues_Misc"
--- Miscellaneous APL value functions for the NAG addon
---
--- This module provides utility functions for various miscellaneous operations and conditions.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
---
--- luacheck: ignore GetSpellInfo
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================

-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitIsDead = _G.UnitIsDead
local GetNetStats = _G.GetNetStats
local GetInventoryItemID = _G.GetInventoryItemID

local format = string.format
local max = math.max



local strlower = strlower

local wipe = wipe

local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local StateManager = ns.StateManager
local Types = ns.Types
local SpecCompat = ns.SpecCompat

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- Checks if the player has a specific talent.
--- @function NAG:HasTalent
--- @param talentId number The talent ID to check
--- @return boolean True if the talent is selected, false otherwise
--- @usage if NAG:HasTalent(12345) then
function NAG:HasTalent(talentId)
    if not talentId then
        self:Error("HasTalent: No talent ID provided")
        return false
    end

    return StateManager:HasTalent(talentId)
end

--- Checks if a pet is currently active (exists and is not dead).
--- @function NAG:PetIsActive
--- @return boolean True if a pet is active, false otherwise.
--- @usage NAG:PetIsActive()
function NAG:PetIsActive()
    return UnitExists("pet") and not UnitIsDead("pet")
end

--- Gets the effective number of group members (respects group/raid overrides for testing).
--- Returns 0 if not in a group, or the number of group members if in a party/raid.
--- @function NAG:GetNumGroupMembers
--- @return number The number of group members (0 if solo, >0 if in group/raid)
--- @usage if NAG:GetNumGroupMembers() > 0 then
function NAG:GetNumGroupMembers()
    return StateManager:GetEffectiveGroupMemberCount()
end

--- Returns false to disable a clause while preserving structure.
--- @local
--- Used to hide/disable rotation clauses without removing them from the rotation string.
--- Hidden clauses can be toggled in the RotationEditor UI.
--- @function NAG:Hidden
--- @return boolean Always returns false
--- @usage or NAG:Hidden() and (condition) and NAG:CastSpell(123)
function NAG:Hidden()
    return false
end

-- ============================ ITEM SWAP HELPERS ============================

local function canonicalSwapSetName(name)
    if type(name) ~= "string" then
        name = tostring(name or "")
    end
    name = strlower(name)
    if name == "" then
        return nil
    end
    return name
end

local function sanitizeExpectedItems(map)
    if type(map) ~= "table" then
        return nil
    end

    local sanitized = {}
    for inventorySlot, itemId in pairs(map) do
        if type(inventorySlot) ~= "number" then
            inventorySlot = tonumber(inventorySlot)
        end
        if type(itemId) == "table" then
            itemId = itemId.id or itemId.itemId
        end
        if inventorySlot and type(inventorySlot) == "number" and itemId and itemId > 0 then
            sanitized[inventorySlot] = itemId
        end
    end

    if next(sanitized) then
        return sanitized
    end

    return nil
end

local function collectEnumNameForValue(enumType, enumValue)
    if not enumType or type(enumValue) ~= "number" then
        return nil
    end
    if enumType.GetNameByValue then
        return canonicalSwapSetName(enumType:GetNameByValue(enumValue))
    end
    for key, value in pairs(enumType) do
        if type(value) == "number" and value == enumValue then
            return canonicalSwapSetName(key)
        end
    end
    return nil
end

local TRINKET_SLOTS = { 13, 14 }
local TRINKET_SLOT_SET = {
    [13] = true,
    [14] = true
}

--- @local
--- Evaluate whether the requested item swap set matches equipped items.
--- Provides detailed print-based debugging of resolution steps.
--- @param swapSet any Swap identifier or payload
--- @return boolean isActive True if swap is active and items match
--- @return table details Diagnostic information
function NAG:EvaluateItemSwapSet(swapSet)
    local swapType = Types and Types:GetType("SwapSet")

    local defaultSwapName = "main"
    local requestedRaw = swapSet
    local overrideItems

    if type(swapSet) == "table" then
        overrideItems = swapSet.items or swapSet.expected
        swapSet = swapSet.swapSet or swapSet.set or swapSet[1] or swapSet.swap_set or swapSet.name
    end

    local resolvedName
    local resolvedEnumValue

    if type(swapSet) == "number" then
        resolvedEnumValue = swapSet
        resolvedName = collectEnumNameForValue(swapType, swapSet)
    elseif type(swapSet) == "string" then
        resolvedName = canonicalSwapSetName(swapSet)
        if swapType and resolvedName then
            local prefixedKey = nil
            if swapType.GetValues then
                for key, value in pairs(swapType:GetValues()) do
                    if canonicalSwapSetName(key) == resolvedName then
                        resolvedEnumValue = value
                        break
                    end
                end
            else
                prefixedKey = resolvedName
            end
            if not resolvedEnumValue then
                local enumValue = swapType and swapType[resolvedName]
                if type(enumValue) == "number" then
                    resolvedEnumValue = enumValue
                end
            end
        end
    end

    if not resolvedName then
        resolvedName = defaultSwapName
    end
    resolvedName = canonicalSwapSetName(resolvedName)
    if not resolvedName then
        resolvedName = defaultSwapName
    end

    local expectedMap
    if overrideItems then
        expectedMap = sanitizeExpectedItems(overrideItems)
    end

    local swapState = StateManager and StateManager.state and StateManager.state.player and
        StateManager.state.player.equipment and StateManager.state.player.equipment.itemSwap

    local currentActiveName = canonicalSwapSetName(swapState and swapState.activeSet or defaultSwapName) or defaultSwapName

    if not expectedMap and swapState and swapState.enabled and swapState.expectedSets then
        expectedMap = swapState.expectedSets[resolvedName]
    end

    local details = {
        requestedRaw = requestedRaw,
        resolvedName = resolvedName,
        enumValue = resolvedEnumValue,
        currentActiveName = currentActiveName,
        mismatches = {},
        overrideUsed = overrideItems ~= nil,
        expectedSlots = {},
        matchedSlots = {}
    }

    local itemsMatch = true
    local slotCount = 0
    local reservedTrinketSlots = {}

    local function matchTrinket(expectedId)
        for _, slotId in ipairs(TRINKET_SLOTS) do
            if not reservedTrinketSlots[slotId] then
                local equippedId = GetInventoryItemID("player", slotId)
                if equippedId == expectedId then
                    reservedTrinketSlots[slotId] = true
                    return slotId, equippedId
                end
            end
        end
        return nil, nil
    end

    if expectedMap and next(expectedMap) then
        for inventorySlot, expectedId in pairs(expectedMap) do
            if expectedId and expectedId > 0 then
                slotCount = slotCount + 1
                details.expectedSlots[inventorySlot] = expectedId
                if TRINKET_SLOT_SET[inventorySlot] then
                    local foundSlot, equippedId = matchTrinket(expectedId)
                    if foundSlot then
                        details.matchedSlots[inventorySlot] = foundSlot
                    else
                        itemsMatch = false
                        details.mismatches[inventorySlot] = {
                            expected = expectedId,
                            actual = nil
                        }
                    end
                else
                    local equippedId = GetInventoryItemID("player", inventorySlot)
                    if equippedId ~= expectedId then
                        itemsMatch = false
                        details.mismatches[inventorySlot] = {
                            expected = expectedId,
                            actual = equippedId
                        }
                    else
                        details.matchedSlots[inventorySlot] = inventorySlot
                    end
                end
            end
        end
    end

    details.expectedSlotCount = slotCount
    details.itemsMatch = itemsMatch
    details.swapEnabled = swapState and swapState.enabled or false
    details.stateActive = currentActiveName

    local isActive = (currentActiveName == resolvedName) and itemsMatch
    return isActive, details
end

--- Checks whether the specified swap set is currently active.
--- @param swapSet any The swap set identifier to compare against (defaults to Main)
--- @return boolean True if the requested swap set is active, false otherwise
function NAG:ActiveItemSwapSet(swapSet)
    local isActive = self:EvaluateItemSwapSet(swapSet)
    return isActive and true or false
end

-- Network latency tracking with outlier removal
local networkStats = {
    lastUpdate = 0,
    updateInterval = 0.5, -- Update every 0.5 seconds
    readings = {},        -- Store last 10 readings
    maxReadings = 10,
    currentAverage = 0    -- Cached average
}

--- Gets the current network latency with outlier removal and caching.
--- Reads GetNetStats() only once every 0.5 seconds, maintains a rolling average
--- of the last 10 readings, discards the top 2 highest and lowest values,
--- and returns the average of the remaining 6 values.
--- @function NAG:GetNetStats
--- @return number The average network latency in seconds
--- @usage local latency = NAG:GetNetStats()
--- @local This function is used to get the current network latency with outlier removal and caching.
function NAG:GetNetStats()
    local currentTime = GetTime()

    -- Check if we need to update
    if currentTime - networkStats.lastUpdate < networkStats.updateInterval then
        return networkStats.currentAverage
    end

    -- Update the timestamp
    networkStats.lastUpdate = currentTime

    -- Get current network stats
    local _, _, lagHome, lagWorld = GetNetStats()
    local currentLag = math.max(lagHome or 0, lagWorld or 0) / 1000 -- Convert to seconds

    -- Add new reading to the array
    table.insert(networkStats.readings, currentLag)

    -- Keep only the last maxReadings
    if #networkStats.readings > networkStats.maxReadings then
        table.remove(networkStats.readings, 1)
    end

    -- Calculate new average with outlier removal
    if #networkStats.readings >= 6 then -- Need at least 6 readings for outlier removal
        -- Create a copy for sorting
        local sortedReadings = {}
        for i, value in ipairs(networkStats.readings) do
            sortedReadings[i] = value
        end

        -- Sort the readings
        table.sort(sortedReadings)

        -- Remove top 2 highest and lowest values
        local startIndex = 3                 -- Skip lowest 2
        local endIndex = #sortedReadings - 2 -- Skip highest 2

        -- Calculate average of remaining values
        local sum = 0
        local count = 0
        for i = startIndex, endIndex do
            sum = sum + sortedReadings[i]
            count = count + 1
        end

        networkStats.currentAverage = count > 0 and (sum / count) or currentLag
    else
        -- Not enough readings yet, use simple average
        local sum = 0
        for _, value in ipairs(networkStats.readings) do
            sum = sum + value
        end
        networkStats.currentAverage = #networkStats.readings > 0 and (sum / #networkStats.readings) or currentLag
    end

    return networkStats.currentAverage
end

--- Gets debug information about the network stats tracking.
--- @function NAG:GetNetStatsDebug
--- @return table Debug information about network stats
--- @usage local debug = NAG:GetNetStatsDebug()
--- @local This function is used to get the debug information about the network stats tracking.
function NAG:GetNetStatsDebug()
    return {
        lastUpdate = networkStats.lastUpdate,
        updateInterval = networkStats.updateInterval,
        readingsCount = #networkStats.readings,
        maxReadings = networkStats.maxReadings,
        currentAverage = networkStats.currentAverage,
        allReadings = networkStats.readings -- Copy of all readings for analysis
    }
end

--- Gets the amount of damage taken in the last global cooldown (1.5s).
--- @function NAG:DamageTakenLastGlobal
--- @return number The amount of damage taken in the last 1.5 seconds
--- @usage if NAG:DamageTakenLastGlobal() > 0 then
function NAG:DamageTakenLastGlobal()
    -- Placeholder: Damage tracking needs to be implemented.
    -- This will likely involve listening to COMBAT_LOG_EVENT_UNFILTERED
    -- and tracking damage taken by the player in the last 1.5 seconds.
    return 0
end


-- ============================ ROTATION SELECTION (APL) ============================

-- Small anti-flap window for APL-driven rotation switching.
-- CRITICAL: Never block switching back to the safe fallback rotation ("Protection").
local APL_ROTATION_SWITCH_THROTTLE_SECONDS = 1.25

--- Gets (and lazily creates) runtime-only APL rotation switch state.
--- This must never use the DB (runtime state only).
--- @return table state
local function getAplRotationSwitchState()
    local state = NAG._aplRotationSwitchState
    if not state then
        state = {
            lastSwitchAt = 0,
            lastSpec = nil,
            lastRotation = nil,
        }
        NAG._aplRotationSwitchState = state
    end
    return state
end

--- Selects a rotation by name for the current specialization.
--- This function allows APL authors to dynamically change rotations based on conditions.
--- @function NAG:SelectRotation
--- @param rotationName string The full name of the rotation to select
--- @return boolean True if the rotation was successfully selected, false otherwise
--- @return string|nil Error message if selection failed
--- @usage local success, err = NAG:SelectRotation("Frost 2H")
function NAG:SelectRotation(rotationName)
    if not rotationName then
        NAG:Warn("SelectRotation: Missing rotationName")
        return false, "Missing rotationName"
    end

    local classModule = NAG:GetClassModule()
    if not classModule then
        NAG:Warn("SelectRotation: No class module available")
        return false, "Class module not available"
    end

    local currentSpec = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not currentSpec then
        NAG:Warn("SelectRotation: No specialization selected")
        return false, "No specialization selected"
    end

    -- No-op: already selected
    if classModule.GetSelectedRotation and classModule:GetSelectedRotation(currentSpec) == rotationName then
        return true
    end

    -- Anti-flap throttle (Paladin Prot): never block "Protection" fallback;
    -- only throttle entry into "Prot Seal Twisting" to prevent rapid ping-pong.
    local state = getAplRotationSwitchState()
    local now = GetTime() or 0
    if rotationName == "Prot Seal Twisting" then
        local lastAt = (state and state.lastSwitchAt) or 0
        local since = now - lastAt
        if since >= 0 and since < APL_ROTATION_SWITCH_THROTTLE_SECONDS then
            return false, "Rotation switch throttled"
        end
    end

    local success, err = classModule:SelectRotation(currentSpec, rotationName)
    if success then
        if state then
            state.lastSwitchAt = now
            state.lastSpec = currentSpec
            state.lastRotation = rotationName
        end
        -- Rotation compilation is now handled in ClassBase:SelectRotation()
        NAG:Debug("SelectRotation: Successfully selected rotation '%s' for specIndex %d", rotationName, currentSpec)
        return true
    else
        NAG:Warn("SelectRotation: Failed to select rotation: %s", tostring(err))
        return false, err
    end
end

-- Initialize WeakAuras cache table if it doesn't exist
if not NAG.weakAurasCache then
    NAG.weakAurasCache = {}
end

--- Checks if a WeakAuras pack is installed by verifying WeakAuras is loaded and an aura with the specified name exists.
--- Uses a cache to avoid repeated checks for the same aura name, improving performance.
--- Cache is cleared when entering/leaving combat.
--- @param auraName string The name of the WeakAuras aura to check for.
--- @return boolean True if WeakAuras is installed and the aura exists, false otherwise.
--- @usage NAG:IsWeakAurasPackInstalled("My Custom Aura")
--- @local This function is used to check if a WeakAuras aura exists
function NAG:IsWeakAurasPackInstalled(auraName)
    if not auraName or type(auraName) ~= "string" then
        self:Error(format("IsWeakAurasPackInstalled: Invalid auraName provided: %s", tostring(auraName)))
        return false
    end

    -- Check cache first for performance
    if NAG.weakAurasCache[auraName] ~= nil then
        return NAG.weakAurasCache[auraName]
    end

    -- Check if WeakAuras addon is installed and loaded
    if not WeakAuras then
        self:Debug("IsWeakAurasPackInstalled: WeakAuras not found")
        NAG.weakAurasCache[auraName] = false
        return false
    end

    local auraExists = false

    -- Check if an aura with the specified name exists in active regions
    if WeakAuras.regions and WeakAuras.regions[auraName] then
        auraExists = true
        self:Debug(format("IsWeakAurasPackInstalled: Found aura '%s' in WeakAuras.regions", auraName))
    else
        -- Check in WeakAurasSaved if the aura exists but might not be active
        if WeakAurasSaved and WeakAurasSaved.displays then
            for displayName, _ in pairs(WeakAurasSaved.displays) do
                if displayName == auraName then
                    auraExists = true
                    self:Debug(format("IsWeakAurasPackInstalled: Found aura '%s' in WeakAurasSaved.displays", auraName))
                    break
                end
            end
        end

        -- If still not found, try checking WeakAuras.ids (alternative storage method)
        if not auraExists and WeakAuras.ids then
            for id, displayName in pairs(WeakAuras.ids) do
                if displayName == auraName then
                    auraExists = true
                    self:Debug(format("IsWeakAurasPackInstalled: Found aura '%s' in WeakAuras.ids with ID %s", auraName,
                        tostring(id)))
                    break
                end
            end
        end
    end

    if not auraExists then
        self:Debug(format("IsWeakAurasPackInstalled: Aura '%s' not found in any WeakAuras storage", auraName))
    end

    -- Cache the result
    NAG.weakAurasCache[auraName] = auraExists
    return auraExists
end

--- Clears the WeakAuras cache. Called when entering/leaving combat to ensure fresh checks.
--- @usage NAG:ClearWeakAurasCache()
--- @local This function is used to clear the WeakAuras cache
function NAG:ClearWeakAurasCache()
    if NAG.weakAurasCache then
        wipe(NAG.weakAurasCache)
    end
end

--- Debug function to list all available WeakAuras auras. Use this to find the exact names.
--- @usage NAG:DebugWeakAurasList()
--- @local This function is used to debug the WeakAuras list
function NAG:DebugWeakAurasList()
    if not WeakAuras then
        self:Print("WeakAuras not found")
        return
    end

    self:Print("=== WeakAuras Debug Info ===")

    -- Check WeakAuras.regions
    if WeakAuras.regions then
        self:Print("Active auras in WeakAuras.regions:")
        for name, _ in pairs(WeakAuras.regions) do
            self:Print("  - " .. tostring(name))
        end
    else
        self:Print("WeakAuras.regions is nil")
    end

    -- Check WeakAuras.ids
    if WeakAuras.ids then
        self:Print("Auras in WeakAuras.ids:")
        for id, name in pairs(WeakAuras.ids) do
            self:Print("  - " .. tostring(name) .. " (ID: " .. tostring(id) .. ")")
        end
    else
        self:Print("WeakAuras.ids is nil")
    end

    -- Check WeakAurasSaved.displays
    if WeakAurasSaved and WeakAurasSaved.displays then
        self:Print("Saved auras in WeakAurasSaved.displays:")
        for name, _ in pairs(WeakAurasSaved.displays) do
            self:Print("  - " .. tostring(name))
        end
    else
        self:Print("WeakAurasSaved.displays is nil")
    end

    self:Print("=== End Debug Info ===")
end
