--- @module "NAG.EntityBehaviorValidator"
--- Validates EntityBehavior implementations against NAG handlers
---
--- This module provides comprehensive testing and validation of EntityBehaviors
--- to ensure consistency between NAG: handlers and entity: method calls.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ======= LOCALIZE =======
local _, ns = ...
local GetTime = _G.GetTime
local L = ns.AceLocale:GetLocale("NAG")
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Module dependencies (resolved in ModuleInitialize)
local DataManager, StateManager, RotationManager

-- ============================ MODULE DEFAULTS ============================
local defaults = {
    char = {
        enabled = false,
        validationLevel = "warnings", -- "silent", "warnings", "debug", "verbose"
        outputDestination = "chat", -- "chat", "debug", "file"
        monitorEntityTypes = {
            Spell = true,
            Item = true,
            Trinket = true,
            Aura = true,
            Dot = true,
            Totem = true,
            Enchant = true
        },
        performanceSettings = {
            samplingRate = 1.0, -- 1.0 = test everything, 0.1 = test 10%
            maxLogEntries = 1000
        }
    }
}

-- ============================ MODULE CREATION ============================
local EntityBehaviorValidator = NAG:CreateModule("EntityBehaviorValidator", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,

    -- Automatic slash command registration
    slashCommands = {
        -- HIERARCHICAL FORMAT:
        ["entity_behavior_validator"] = {
            handler = "HandleSlashCommand",
            help = "EntityBehavior validation commands",
            root = "nagdebug",
            path = {"entity", "behavior", "validator"},
            aliases = {"ebv"}, -- Short alias for convenience
            category = "Debug"
        }
    },

    -- Automatic debug category assignment
    debugCategories = {ns.DEBUG_CATEGORIES.VALIDATION, ns.DEBUG_CATEGORIES.SERVICES},

    -- Automatic state management
    defaultState = {
        isMonitoring = false,
        validationResults = {},
        handlerMappings = {},
        testResults = {},
        logEntries = {}
    }
})

-- ============================ HANDLER MAPPINGS REGISTRY ============================
-- Maps NAG handler functions to their EntityBehavior equivalents
local HANDLER_MAPPINGS = {
    -- Spell behaviors
    ["SpellReady"] = {
        entityType = "Spell",
        behaviorMethod = "IsReady",
        description = "Check if spell is ready to cast"
    },
    ["SpellActive"] = {
        entityType = "Spell",
        behaviorMethod = "IsActive",
        description = "Check if spell buff/effect is active"
    },
    ["SpellTime"] = {
        entityType = "Spell",
        behaviorMethod = "RemainingTime",
        description = "Get spell buff/effect remaining time"
    },
    ["SpellCharges"] = {
        entityType = "Spell",
        behaviorMethod = "GetCharges",
        description = "Get spell charges"
    },
    ["SpellStacks"] = {
        entityType = "Spell",
        behaviorMethod = "GetStacks",
        description = "Get spell buff stacks"
    },

    -- Item behaviors
    ["ItemReady"] = {
        entityType = "Item",
        behaviorMethod = "IsReady",
        description = "Check if item is ready to use"
    },
    ["ItemActive"] = {
        entityType = "Item",
        behaviorMethod = "IsActive",
        description = "Check if item buff is active"
    },
    ["ItemTime"] = {
        entityType = "Item",
        behaviorMethod = "RemainingTime",
        description = "Get item buff remaining time"
    },

    -- Trinket behaviors
    ["TrinketReady"] = {
        entityType = "Trinket",
        behaviorMethod = "IsReady",
        description = "Check if trinket is ready to use"
    },
    ["TrinketActive"] = {
        entityType = "Trinket",
        behaviorMethod = "IsActive",
        description = "Check if trinket buff/proc is active"
    },
    ["TrinketTime"] = {
        entityType = "Trinket",
        behaviorMethod = "RemainingTime",
        description = "Get trinket buff/proc remaining time"
    },

    -- Aura behaviors
    ["AuraActive"] = {
        entityType = "Aura",
        behaviorMethod = "IsActive",
        description = "Check if aura is active"
    },
    ["AuraTime"] = {
        entityType = "Aura",
        behaviorMethod = "RemainingTime",
        description = "Get aura remaining time"
    },
    ["AuraStacks"] = {
        entityType = "Aura",
        behaviorMethod = "GetStacks",
        description = "Get aura stacks"
    },

    -- DoT behaviors
    ["DotActive"] = {
        entityType = "Dot",
        behaviorMethod = "IsActive",
        description = "Check if DoT is active on target"
    },
    ["DotTime"] = {
        entityType = "Dot",
        behaviorMethod = "RemainingTime",
        description = "Get DoT remaining time"
    }
    -- Note: DotTickDamage removed - function doesn't exist in NAG handlers
}

-- ============================ INITIALIZATION ============================
function EntityBehaviorValidator:ModuleInitialize()
    -- Assign module dependencies
    DataManager = NAG:GetModule("DataManager")
    StateManager = NAG:GetModule("StateManager")
    RotationManager = NAG:GetModule("RotationManager")

    -- Initialize validation state
    self.state.handlerMappings = HANDLER_MAPPINGS
    self.state.validationResults = {}
    self.state.testResults = {}
    self.state.logEntries = {}

    self:Debug("EntityBehaviorValidator initialized")
end

function EntityBehaviorValidator:ModuleEnable()
    -- Apply settings and start monitoring if enabled
    if self:GetSetting("char", "enabled", false) then
        self:EnableValidation()
    end

    self:Info("EntityBehaviorValidator enabled")
end

-- ============================ VALIDATION CONTROL ============================
--- Enable real-time validation monitoring
function EntityBehaviorValidator:EnableValidation()
    if self.state.isMonitoring then
        self:Warn("Validation already enabled")
        return
    end

    self.state.isMonitoring = true
    self:SetSetting("char", "enabled", true)

    -- Hook into EntityBehaviors.ExecuteBehavior for monitoring
    self:HookEntityBehaviorExecution()

    self:Info("EntityBehavior validation enabled")
    self:Print("EntityBehavior validation is now |cff00ff00ACTIVE|r")
end

--- Disable real-time validation monitoring
function EntityBehaviorValidator:DisableValidation()
    if not self.state.isMonitoring then
        self:Warn("Validation already disabled")
        return
    end

    self.state.isMonitoring = false
    self:SetSetting("char", "enabled", false)

    -- Unhook EntityBehaviors monitoring
    self:UnhookEntityBehaviorExecution()

    self:Info("EntityBehavior validation disabled")
    self:Print("EntityBehavior validation is now |cffff0000INACTIVE|r")
end

--- Toggle validation on/off
function EntityBehaviorValidator:ToggleValidation()
    if self.state.isMonitoring then
        self:DisableValidation()
    else
        self:EnableValidation()
    end
end

-- ============================ ENTITYBEHAVIOR MONITORING ============================
--- Hook into EntityBehaviors.ExecuteBehavior for monitoring
function EntityBehaviorValidator:HookEntityBehaviorExecution()
    if not ns.EntityBehaviors then
        self:Error("EntityBehaviors not available for hooking")
        return
    end

    -- Store original function
    if not self.originalExecuteBehavior then
        self.originalExecuteBehavior = ns.EntityBehaviors.ExecuteBehavior
    end

    -- Create hooked version
    ns.EntityBehaviors.ExecuteBehavior = function(entityType, entityId, behaviorName, entity, ...)
        local result = self.originalExecuteBehavior(entityType, entityId, behaviorName, entity, ...)

        -- Log the call if monitoring is enabled
        if self.state.isMonitoring then
            self:LogEntityBehaviorCall(entityType, entityId, behaviorName, entity, result, ...)
        end

        return result
    end

    self:Debug("Hooked EntityBehaviors.ExecuteBehavior")
end

--- Unhook EntityBehaviors monitoring
function EntityBehaviorValidator:UnhookEntityBehaviorExecution()
    if self.originalExecuteBehavior then
        ns.EntityBehaviors.ExecuteBehavior = self.originalExecuteBehavior
        self:Debug("Unhooked EntityBehaviors.ExecuteBehavior")
    end
end

--- Log an EntityBehavior call for analysis
function EntityBehaviorValidator:LogEntityBehaviorCall(entityType, entityId, behaviorName, entity, result, ...)
    -- Check sampling rate
    local samplingRate = (self.db.char.performanceSettings and self.db.char.performanceSettings.samplingRate) or 1.0
    if math.random() > samplingRate then return end

    -- Check if we should monitor this entity type
    local monitorTypes = self.db.char.monitorEntityTypes
    if not monitorTypes[entityType] then return end

    local logEntry = {
        timestamp = GetTime(),
        entityType = entityType,
        entityId = entityId,
        behaviorName = behaviorName,
        result = result,
        args = {...}
    }

    -- Add to log entries (with size limit)
    table.insert(self.state.logEntries, logEntry)
    local maxEntries = (self.db.char.performanceSettings and self.db.char.performanceSettings.maxLogEntries) or 1000
    if #self.state.logEntries > maxEntries then
        table.remove(self.state.logEntries, 1)
    end

    -- Output based on validation level
    local validationLevel = self.db.char.validationLevel
    if validationLevel == "verbose" then
        self:OutputValidationLog(logEntry)
    end
end

-- ============================ HANDLER COMPARISON ============================
--- Compare NAG handler result with EntityBehavior result
function EntityBehaviorValidator:CompareHandlerResults(handlerName, entityId, ...)
    local mapping = self.state.handlerMappings[handlerName]
    if not mapping then
        self:Warn("No mapping found for handler: " .. tostring(handlerName))
        return false
    end

    -- Get entity from DataManager
    local entity = self:GetEntityFromDataManager(mapping.entityType, entityId)
    if not entity then
        self:Warn(string.format("Entity not found: %s[%s]", mapping.entityType, tostring(entityId)))
        return false
    end

    -- Get NAG handler result (would need to call actual NAG handler)
    local nagResult = self:CallNAGHandler(handlerName, entityId, ...)

    -- Get EntityBehavior result
    local behaviorResult = ns.EntityBehaviors.ExecuteBehavior(
        mapping.entityType,
        entityId,
        mapping.behaviorMethod,
        entity,
        ...
    )

    -- Compare results
    local match = self:CompareResults(nagResult, behaviorResult)

    -- Log comparison result
    local comparisonResult = {
        handlerName = handlerName,
        entityId = entityId,
        entityType = mapping.entityType,
        behaviorMethod = mapping.behaviorMethod,
        nagResult = nagResult,
        behaviorResult = behaviorResult,
        match = match,
        timestamp = GetTime()
    }

    table.insert(self.state.validationResults, comparisonResult)

    -- Output if there's a mismatch or if in debug mode
    if not match or self.db.char.validationLevel == "debug" then
        self:OutputComparisonResult(comparisonResult)
    end

    return match
end

--- Compare two results for equality (handles different data types)
function EntityBehaviorValidator:CompareResults(result1, result2)
    -- Handle nil cases
    if result1 == nil and result2 == nil then return true end
    if result1 == nil or result2 == nil then return false end

    -- Handle different types
    if type(result1) ~= type(result2) then return false end

    -- For numbers, allow small floating point differences
    if type(result1) == "number" then
        return math.abs(result1 - result2) < 0.001
    end

    -- For other types, direct comparison
    return result1 == result2
end

-- ============================ APL STRING ANALYSIS ============================
--- Parse NAG rotation string to extract entity references
--- NAG rotation strings use NAG:FunctionName(id) format, not SimC format
function EntityBehaviorValidator:ParseAPLForEntities(rotationString)
    if not rotationString then return {} end

    local entities = {}

    -- Use RotationManager's spell extraction patterns for comprehensive coverage
    local spellPatterns = RotationManager.GetSpellExtractionPatterns and
                         RotationManager:GetSpellExtractionPatterns() or {}

    -- Extract spell IDs from NAG Cast/Channel function calls
    for _, pattern in ipairs(spellPatterns) do
        for spellId in string.gmatch(rotationString, pattern) do
            local id = tonumber(spellId)
            if id then
                entities[id] = entities[id] or {}
                entities[id].type = "Spell"
                entities[id].behaviors = entities[id].behaviors or {}
                -- All spells from Cast/Channel functions can potentially use these behaviors
                entities[id].behaviors.IsKnown = true
                entities[id].behaviors.IsReady = true
                entities[id].behaviors.IsActive = true
            end
        end
    end

    -- NAG function call patterns (actual format used in NAG rotation strings)
    local conditionPatterns = {
        -- NAG Aura functions
        {"NAG:AuraIsActive%((%d+)", "Aura", "IsActive"}, -- NAG:AuraIsActive(spellId)
        {"NAG:IsActiveAura%((%d+)", "Aura", "IsActive"}, -- Compatibility: legacy IsActiveAura(spellId)
        {"NAG:IsActive%((%d+)", "Aura", "IsActive"}, -- NAG:IsActive(spellId) - generic
        {"NAG:AuraRemainingTime%((%d+)", "Aura", "RemainingTime"}, -- NAG:AuraRemainingTime(spellId)
        {"NAG:AuraNumStacks%((%d+)", "Aura", "GetStacks"}, -- NAG:AuraNumStacks(spellId)

        -- NAG Spell functions
        {"NAG:IsReadySpell%((%d+)", "Spell", "IsReady"}, -- NAG:IsReadySpell(spellId)
        {"NAG:SpellIsKnown%((%d+)", "Spell", "IsKnown"}, -- NAG:SpellIsKnown(spellId)
        {"NAG:SpellTimeToReady%((%d+)", "Spell", "TimeToReady"}, -- NAG:SpellTimeToReady(spellId)
        {"NAG:SpellNumCharges%((%d+)", "Spell", "GetCharges"}, -- NAG:SpellNumCharges(spellId)
        {"NAG:IsReady%((%d+)", "Spell", "IsReady"}, -- NAG:IsReady(spellId) - generic

        -- NAG DoT functions
        {"NAG:DotIsActive%((%d+)", "Dot", "IsActive"}, -- NAG:DotIsActive(spellId)
        {"NAG:DotRemainingTime%((%d+)", "Dot", "RemainingTime"}, -- NAG:DotRemainingTime(spellId)

        -- NAG Item functions
        {"NAG:ItemRemainingTime%((%d+)", "Item", "RemainingTime"}, -- NAG:ItemRemainingTime(itemId)
        {"NAG:IsReady%((%d+)", "Item", "IsReady"}, -- NAG:IsReady(itemId) - for items/trinkets

        -- NAG Totem functions
        {"NAG:IsTotemActive%((%d+)", "Totem", "IsActive"}, -- NAG:IsTotemActive(totemId)

        -- NAG Cast functions (these reference spells)
        {"NAG:Cast%((%d+)", "Spell", "IsReady"}, -- NAG:Cast(spellId) implies spell readiness check
        {"NAG:CastSpell%((%d+)", "Spell", "IsReady"}, -- NAG:CastSpell(spellId) implies spell readiness check

        -- Legacy SimC patterns (keep for compatibility if any exist)
        {"spell%.(%d+)%.ready", "Spell", "IsReady"},
        {"buff%.(%d+)%.active", "Aura", "IsActive"},
        {"debuff%.(%d+)%.active", "Dot", "IsActive"}
    }

    for _, patternInfo in ipairs(conditionPatterns) do
        local pattern, entityType, behaviorName = patternInfo[1], patternInfo[2], patternInfo[3]
        for entityId in string.gmatch(rotationString, pattern) do
            local id = tonumber(entityId)
            if id then
                entities[id] = entities[id] or {}
                entities[id].type = entityType
                entities[id].behaviors = entities[id].behaviors or {}
                entities[id].behaviors[behaviorName] = true
            end
        end
    end

    return entities
end

--- Run comprehensive test on all entities found in rotation strings
--- @param enableComparison boolean Whether to compare NAG handlers vs EntityBehaviors
function EntityBehaviorValidator:RunRotationTests(enableComparison)
    local testResults = {}
    local totalTests = 0
    local failedTests = 0
    local comparisonMismatches = 0

    -- Get all class rotations
    local classRotations = self:GetAllClassRotations()

    if not next(classRotations) then
        self:Print("No rotations found to test")
        return testResults
    end

    for className, rotations in pairs(classRotations) do
        self:Info(string.format("Testing rotations for %s", className))

        for rotationName, rotationString in pairs(rotations) do
            local entities = self:ParseAPLForEntities(rotationString)

            for entityId, entityInfo in pairs(entities) do
                if entityInfo.behaviors then
                    for behaviorName, _ in pairs(entityInfo.behaviors) do
                        totalTests = totalTests + 1

                        -- Test this specific entity behavior
                        local success = self:TestEntityBehavior(entityInfo.type, entityId, behaviorName, enableComparison)
                        if not success then
                            failedTests = failedTests + 1
                            table.insert(testResults, {
                                className = className,
                                rotationName = rotationName,
                                entityType = entityInfo.type,
                                entityId = entityId,
                                behaviorName = behaviorName,
                                success = false
                            })
                        end
                    end
                end
            end
        end
    end

    -- Output results
    local modeText = enableComparison and " (with NAG handler comparison)" or ""
    self:Print(string.format("Rotation tests completed: %d total, %d failed%s", totalTests, failedTests, modeText))

    if failedTests > 0 then
        self:Print(string.format("|cffff0000Found %d issues:|r", failedTests))
        for _, result in ipairs(testResults) do
            if not result.success then
                self:Print(string.format("  %s.%s: %s[%d].%s",
                    result.className, result.rotationName,
                    result.entityType, result.entityId, result.behaviorName))
            end
        end
    else
        self:Print("|cff00ff00All rotation tests passed!|r")
    end

    if enableComparison then
        self:Print("|cff00ffffComparison mode: Check chat/debug for NAG vs EntityBehavior value mismatches|r")
    end

    return testResults
end

-- ============================ UTILITY METHODS ============================

--- Maps EntityBehavior entity types to DataManager entity types
--- @param entityType string The EntityBehavior entity type
--- @return string|nil The corresponding DataManager entity type
function EntityBehaviorValidator:MapEntityType(entityType)
    local entityTypeMap = {
        ["Spell"] = DataManager.EntityTypes.SPELL,
        ["Item"] = DataManager.EntityTypes.ITEM,
        ["Trinket"] = DataManager.EntityTypes.ITEM, -- Trinkets are items in DataManager
        ["Aura"] = DataManager.EntityTypes.SPELL, -- Auras are typically spells in DataManager
        ["Dot"] = DataManager.EntityTypes.SPELL, -- DoTs are spells in DataManager
        ["Totem"] = DataManager.EntityTypes.TOTEM,
        ["Pet"] = DataManager.EntityTypes.PET,
        ["Enchant"] = DataManager.EntityTypes.ENCHANT,
        ["Talent"] = DataManager.EntityTypes.TALENT,
        ["BattlePet"] = DataManager.EntityTypes.BATTLEPET
    }

    return entityTypeMap[entityType]
end

--- Gets an entity from DataManager using the correct API
--- @param entityType string The EntityBehavior entity type
--- @param entityId number The entity ID
--- @return table|nil The entity data or nil if not found
function EntityBehaviorValidator:GetEntityFromDataManager(entityType, entityId)
    local dataManagerEntityType = self:MapEntityType(entityType)
    if not dataManagerEntityType then
        self:Debug("GetEntityFromDataManager: Unknown entity type mapping - %s", entityType)
        return nil
    end

    -- Try the primary entity type first
    local entity = DataManager:Get(entityId, dataManagerEntityType)
    if entity then
        return entity
    end

    -- If not found, try alternative entity types (entities can have multiple flags)
    local alternativeTypes = {
        ["Aura"] = {DataManager.EntityTypes.SPELL, DataManager.EntityTypes.ITEM}, -- Auras can be spells or items
        ["Dot"] = {DataManager.EntityTypes.SPELL}, -- DoTs are spells
        ["Spell"] = {DataManager.EntityTypes.ITEM}, -- Some spells might be items
        ["Item"] = {DataManager.EntityTypes.SPELL}, -- Some items might be spells
        ["Trinket"] = {DataManager.EntityTypes.ITEM} -- Trinkets are items
    }

    local alternatives = alternativeTypes[entityType]
    if alternatives then
        for _, altType in ipairs(alternatives) do
            entity = DataManager:Get(entityId, altType)
            if entity then
                self:Debug("GetEntityFromDataManager: Found %s[%d] as %s instead of %s",
                    entityType, entityId, altType, dataManagerEntityType)
                return entity
            end
        end
    end

    return nil
end
--- Test a specific entity behavior and optionally compare with NAG handler
function EntityBehaviorValidator:TestEntityBehavior(entityType, entityId, behaviorName, compareWithNAG)
    local entity = self:GetEntityFromDataManager(entityType, entityId)
    if not entity then
        self:Debug("TestEntityBehavior: Entity not found - %s[%d]", entityType, entityId)
        return false
    end

    -- Try to execute the behavior
    local success, behaviorResult = pcall(ns.EntityBehaviors.ExecuteBehavior,
        entityType, entityId, behaviorName, entity)

    if not success then
        self:Debug("TestEntityBehavior: Behavior execution failed - %s[%d].%s: %s",
            entityType, entityId, behaviorName, tostring(behaviorResult))
        return false
    end

    -- If comparison is requested, also test NAG handler consistency
    if compareWithNAG then
        local handlerName = self:FindHandlerForBehavior(entityType, behaviorName)
        if handlerName then
            local nagResult = self:CallNAGHandler(handlerName, entityId)
            local match = self:CompareResults(nagResult, behaviorResult)

            if not match then
                self:Warn("Value mismatch: %s[%d].%s - NAG: %s vs Entity: %s",
                    entityType, entityId, behaviorName,
                    tostring(nagResult), tostring(behaviorResult))
            else
                self:Debug("Value match: %s[%d].%s - Both returned: %s",
                    entityType, entityId, behaviorName, tostring(behaviorResult))
            end
        end
    end

    return success
end

--- Find the NAG handler name for a given entity type and behavior
--- @param entityType string The EntityBehavior entity type
--- @param behaviorName string The behavior method name
--- @return string|nil The handler name or nil if not found
function EntityBehaviorValidator:FindHandlerForBehavior(entityType, behaviorName)
    -- Reverse lookup in handler mappings
    for handlerName, mapping in pairs(self.state.handlerMappings) do
        if mapping.entityType == entityType and mapping.behaviorMethod == behaviorName then
            return handlerName
        end
    end
    return nil
end

--- Get all class rotations for testing
function EntityBehaviorValidator:GetAllClassRotations()
    local rotations = {}

    -- Get the class module using NAG's established pattern
    local classModule = NAG:GetClassModule()
    if not classModule then
        self:Debug("GetAllClassRotations: No class module available")
        return rotations
    end

    local playerClass = NAG.CLASS_FILENAME

    -- Get all available rotations for all specs (showAllSpecs = true)
    local availableRotations, displayNames = classModule:GetAvailableRotations(nil, true)

    if availableRotations then
        rotations[playerClass] = {}

        -- Convert the available rotations to the expected format
        for rotationName, rotationConfig in pairs(availableRotations) do
            if rotationConfig and rotationConfig.rotationString then
                rotations[playerClass][rotationName] = rotationConfig.rotationString
            end
        end
    end

    return rotations
end

--- Call NAG handler (implementation for common handlers)
function EntityBehaviorValidator:CallNAGHandler(handlerName, entityId, ...)
    if not NAG then
        self:Error("NAG addon not available")
        return nil
    end

    -- Map handler names to actual NAG functions that exist in handlers
    local handlerMap = {
        -- Spell behaviors - using actual handler functions
        ["SpellReady"] = function(id, ...) return NAG:IsReadySpell(id, ...) end,
        ["SpellActive"] = function(id, ...) return NAG:AuraIsActive(id, ...) end, -- Use AuraIsActive for spell effects
        ["SpellTime"] = function(id, ...) return NAG:AuraRemainingTime(id, ...) end, -- Use AuraRemainingTime for spell effects
        ["SpellCharges"] = function(id, ...) return NAG:SpellNumCharges(id, ...) end,
        ["SpellStacks"] = function(id, ...) return NAG:AuraNumStacks(id, ...) end,
        ["SpellKnown"] = function(id, ...) return NAG:SpellIsKnown(id, ...) end,

        -- Item behaviors - using IsActive pattern for items
        ["ItemReady"] = function(id, ...) return NAG:IsReady(id, ...) end, -- Use generic IsReady for items
        ["ItemActive"] = function(id, ...) return NAG:IsActive(id, ...) end, -- Use generic IsActive for items
        ["ItemTime"] = function(id, ...) return NAG:ItemRemainingTime(id, ...) end, -- Use actual ItemRemainingTime

        -- Trinket behaviors - trinkets are items, use item functions
        ["TrinketReady"] = function(id, ...) return NAG:IsReady(id, ...) end, -- Use generic IsReady for trinkets
        ["TrinketActive"] = function(id, ...) return NAG:IsActive(id, ...) end, -- Use generic IsActive for trinkets
        ["TrinketTime"] = function(id, ...) return NAG:ItemRemainingTime(id, ...) end, -- Use ItemRemainingTime for trinkets

        -- Aura behaviors - using actual handler functions
        ["AuraActive"] = function(id, ...) return NAG:AuraIsActive(id, ...) end, -- Use actual AuraIsActive
        ["AuraTime"] = function(id, ...) return NAG:AuraRemainingTime(id, ...) end, -- Use actual AuraRemainingTime
        ["AuraStacks"] = function(id, ...) return NAG:AuraNumStacks(id, ...) end, -- Use actual AuraNumStacks

        -- DoT behaviors - using actual handler functions
        ["DotActive"] = function(id, ...) return NAG:DotIsActive(id, ...) end, -- Use actual DotIsActive
        ["DotTime"] = function(id, ...) return NAG:DotRemainingTime(id, ...) end, -- Use actual DotRemainingTime
        -- Note: DotTickDamage doesn't exist in handlers, removing this mapping
    }

    local handlerFunc = handlerMap[handlerName]
    if handlerFunc then
        local success, result = pcall(handlerFunc, entityId, ...)
        if success then
            return result
        else
            self:Debug(string.format("Handler %s failed: %s", handlerName, tostring(result)))
            return nil
        end
    else
        self:Debug(string.format("Unknown handler: %s", handlerName))
        return nil
    end
end

--- Output validation log entry
function EntityBehaviorValidator:OutputValidationLog(logEntry)
    local message = string.format("[EBV] %s[%d].%s() = %s",
        logEntry.entityType, logEntry.entityId, logEntry.behaviorName, tostring(logEntry.result))

    local outputDest = self:GetSetting("char", "outputDestination", "chat")
    if outputDest == "chat" then
        self:Print(message)
    elseif outputDest == "debug" then
        self:Debug(message)
    end
end

--- Output comparison result
function EntityBehaviorValidator:OutputComparisonResult(result)
    local status = result.match and "|cff00ff00MATCH|r" or "|cffff0000MISMATCH|r"
    local message = string.format("[EBV] %s %s[%d].%s: NAG=%s vs Entity=%s",
        status, result.entityType, result.entityId, result.behaviorMethod,
        tostring(result.nagResult), tostring(result.behaviorResult))

    local outputDest = self:GetSetting("char", "outputDestination", "chat")
    if outputDest == "chat" then
        if not result.match then
            self:Print(message)
        end
    elseif outputDest == "debug" then
        self:Debug(message)
    end
end

-- ============================ SLASH COMMAND HANDLING ============================
function EntityBehaviorValidator:HandleSlashCommand(args)
    local command = args and args:lower() or ""

    if command == "" or command == "help" then
        self:ShowHelp()
    elseif command == "on" or command == "enable" then
        self:EnableValidation()
    elseif command == "off" or command == "disable" then
        self:DisableValidation()
    elseif command == "toggle" then
        self:ToggleValidation()
    elseif command == "test" then
        self:RunRotationTests()
    elseif command == "compare" then
        self:RunRotationTests(true) -- Enable comparison mode
    elseif command == "status" then
        self:ShowStatus()
    elseif command == "clear" then
        self:ClearResults()
    else
        self:Print("Unknown command: " .. command)
        self:ShowHelp()
    end
end

function EntityBehaviorValidator:ShowHelp()
    self:Print("EntityBehavior Validator Commands:")
    self:Print("  /nagdebug entity behavior validator on|enable - Enable real-time validation")
    self:Print("  /nagdebug entity behavior validator off|disable - Disable real-time validation")
    self:Print("  /nagdebug entity behavior validator toggle - Toggle validation on/off")
    self:Print("  /nagdebug entity behavior validator test - Run comprehensive rotation tests")
    self:Print("  /nagdebug entity behavior validator compare - Run tests with NAG handler comparison")
    self:Print("  /nagdebug entity behavior validator status - Show current status")
    self:Print("  /nagdebug entity behavior validator clear - Clear validation results")
    self:Print("  /nagdebug entity behavior validator help - Show this help")
    self:Print(" ")
    self:Print("Short alias: /ebv <command> (same as above)")
end

function EntityBehaviorValidator:ShowStatus()
    local status = self.state.isMonitoring and "|cff00ff00ACTIVE|r" or "|cffff0000INACTIVE|r"
    self:Print("EntityBehavior Validator Status: " .. status)
    self:Print(string.format("  Validation Level: %s", self:GetSetting("char", "validationLevel", "warnings")))
    self:Print(string.format("  Log Entries: %d", #self.state.logEntries))
    self:Print(string.format("  Validation Results: %d", #self.state.validationResults))
end

function EntityBehaviorValidator:ClearResults()
    self.state.logEntries = {}
    self.state.validationResults = {}
    self.state.testResults = {}
    self:Print("Validation results cleared")
end

-- Export module
ns.EntityBehaviorValidator = EntityBehaviorValidator
