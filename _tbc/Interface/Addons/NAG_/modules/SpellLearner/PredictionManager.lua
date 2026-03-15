--- ============================ HEADER ============================
--[[
    PredictionManager.lua - Spell Observation Accumulation Module for NAG

    Receives captured spells with preState/postState from SpellLearnerStateManager.
    Uses SpellAnalyzer to convert state snapshots into spell effect deltas.
    Accumulates raw observations per spell for learning purposes.
    Provides consolidation functions to process accumulated data.

    Authors: NAG Team
    License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
    Status: Development

    Part of the SpellLearner system refactor - handles observation accumulation
    and data consolidation without confidence scoring or machine learning.
]]

--- ============================ LOCALIZE ============================
local _, ns = ...
local InCombatLockdown = _G.InCombatLockdown
local WoWAPI = ns.WoWAPI
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type OptionsFactory
--- @type SpellLearnerStateManager
--- @type SpellAnalyzer
--- @type AdvancedPredictionEngine
local OptionsFactory, SpellLearnerStateManager, SpellAnalyzer, AdvancedPredictionEngine


local L = ns.AceLocale:GetLocale("NAG", true)


-- WoW API
local GetTime = _G.GetTime

-- Lua APIs (WoW optimized versions)
local format = string.format
local max = math.max
local min = math.min

-- Table operations
local tinsert = tinsert
local pairs = pairs
local ipairs = ipairs
local type = type
local next = next
local unpack = unpack

--- ============================ CONTENT ============================

-- Default settings
local defaults = {
    global = {
        version = 1,
        maxObservationsPerSpell = 10, -- Limit observations (ring-cap target)
    },
    char = {
        enabled = false,            -- Disabled by default - use commands to enable
        autoConsolidate = true,     -- Automatically consolidate when observation threshold is reached
        consolidationThreshold = 5, -- Number of observations before auto-consolidation (reduced from 10)
        -- Contextual learning settings
        contextualLearningEnabled = true, -- Enable context-aware consolidation
        contextTolerance = 0.3,    -- Context similarity threshold (0.0-1.0)
        -- Database structure for consolidated data only (raw observations stored in SpellLearnerStateManager)
        consolidated = {},          -- [spellId] = consolidated_data
        stats = {
            totalObservations = 0,
            spellsCaptured = 0,
            lastConsolidation = 0,
        }
    }
}

--- @class PredictionManager: CoreModule
local PredictionManager = NAG:CreateModule("PredictionManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = "spelllearner",
    optionsOrder = 2,
    messageHandlers = {
        NAG_SPELL_LEARNED = true
    },
    optionsComposers = {
        ["spelllearner"] = true  -- Inject into unified SpellLearner category
    },
})
local module = PredictionManager
ns.PredictionManager = PredictionManager

do -- Ace3 lifecycle methods
    --- Initialize the module
    function PredictionManager:ModuleInitialize()
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        OptionsFactory = NAG:GetModule("OptionsFactory")
        SpellLearnerStateManager = NAG:GetModule("SpellLearnerStateManager", true)
        SpellAnalyzer = NAG:GetModule("SpellAnalyzer")
        AdvancedPredictionEngine = NAG:GetModule("AdvancedPredictionEngine")
        -- ============================ MODULE INITIALIZATION ============================
        -- Ensure SpellAnalyzer is available
                -- Ensure SpellLearnerStateManager is available
        if not SpellLearnerStateManager then
            self:Info("SpellLearnerStateManager module not found - awaiting updated capture pipeline")
        end

        -- Initialize in-memory observation storage (raw observations are not persisted)
        self.observations = {}

        -- Initialize prediction database structure after CoreModule database is ready
        self:InitializePredictionDatabase()
    end

    --- Enable the module
    function PredictionManager:ModuleEnable()
        -- Check if module is enabled

        if not self.db.char.enabled then
            self:Debug("PredictionManager is disabled by default. Use a command to enable it.")
            return
        end

        -- ZERO-BOILERPLATE: Messages are automatically registered via declarative patterns
        -- No enable-time self-tests; module remains idle until real messages arrive
    end

    --- Disable the module
    function PredictionManager:ModuleDisable()
        self:Debug("Disabling PredictionManager")
    end
end

do -- Database Management
    --- Initialize the database structure (called after CoreModule database is ready)
    function PredictionManager:InitializePredictionDatabase()
        -- Check if database is ready
        if not self.db then
            self:Debug("Database not ready, deferring prediction database initialization")
            return
        end
        local consolidated = self.db.char.consolidated
        if not consolidated or type(consolidated) ~= "table" then
            self.db.char.consolidated = {}
        end

        local stats = self.db.char.stats
        if not stats or type(stats) ~= "table" then
            self.db.char.stats = {
                totalObservations = 0,
                spellsCaptured = 0,
                lastConsolidation = 0,
            }
        end

        -- Raw observations are maintained in-memory (self.observations)

        self:Debug("Prediction database initialized")
    end

    --- Clear all accumulated data
    function PredictionManager:ClearAllData()
        -- Clear consolidated data
        self.db.char.consolidated = {}
        self.db.char.stats.totalObservations = 0
        self.db.char.stats.spellsCaptured = 0
        self.db.char.stats.lastConsolidation = GetTime()

        -- Clear raw observations (in-memory)
        self.observations = {}

        self:Info("All prediction data cleared")
    end

    --- Clear data for a specific spell
    --- @param spellId number The spell ID to clear data for
    function PredictionManager:ClearSpellData(spellId)
        if not spellId then return end

        local spellChanges = self:GetSpellChanges()

        local observationCount = 0
        if spellChanges and spellChanges[spellId] then
            observationCount = #spellChanges[spellId]
            spellChanges[spellId] = nil
            local currentTotal = self.db.char.stats.totalObservations
            self.db.char.stats.totalObservations = currentTotal - observationCount
        end

        local consolidated = self.db.char.consolidated
        if consolidated[spellId] then
            consolidated[spellId] = nil
            self.db.char.consolidated = consolidated
        end

        local spellInfo = WoWAPI.GetSpellInfo(spellId)
        local spellName = spellInfo and spellInfo.name or tostring(spellId)
        if self.debug then self:Info("Cleared %d observations for %s", observationCount, spellName) end
    end

    --- Get the spell changes database from SpellLearnerStateManager
    --- @return table|nil The spellChanges table or nil if not available
    function PredictionManager:GetSpellChanges()
        -- Return in-memory observations table
        return self.observations
    end
end

do -- Core Observation Functions
    --- Record a new observation for a spell
    --- @param spellId number The spell ID
    --- @param delta table The delta analysis from SpellAnalyzer
    function PredictionManager:RecordObservation(spellId, delta)
        self:Debug("🔍 PredictionManager:RecordObservation called with spellId: %d, delta: %s", spellId,
            delta and "exists" or "nil")
        self:Debug("🔍 Module enabled: %s", self.db.char.enabled)

        -- Check if module is enabled
        if not self.db.char.enabled then
            self:Debug("🚨 PredictionManager is disabled, not recording observation")
            return
        end

        if not spellId or not delta then
            self:Debug("🚨 RecordObservation called with invalid parameters - spellId: %s, delta: %s", spellId, delta)
            return
        end

        self:Debug("🔍 Calling StoreObservation...")

        -- Store the observation
        local success = self:StoreObservation(spellId, delta)

        if success then
            -- Check if we should auto-consolidate
            self:CheckAutoConsolidation(spellId)
        end
    end

    --- Store an analysis result as an observation
    --- @param spellId number The spell ID
    --- @param analysis table The analysis result from SpellAnalyzer
    function PredictionManager:StoreObservation(spellId, analysis)
        self:Debug("🔍 PredictionManager:StoreObservation called with spellId: %d", spellId)

        local spellChanges = self:GetSpellChanges()

        if not spellChanges then
            self:Debug("🚨 In-memory observations table missing")
            return false
        end

        -- Initialize spell observations if needed (fallback creation logic)
        local isNewSpell = not spellChanges[spellId]
        if isNewSpell then
            self:Debug("🔍 Creating new spell entry for %d", spellId)
            spellChanges[spellId] = {}
            local currentSpells = self.db.char.stats.spellsCaptured
            self.db.char.stats.spellsCaptured = currentSpells + 1
        end

        local observations = spellChanges[spellId]
        self:Debug("🔍 Current observation count for spell %d: %d", spellId, #observations)

        -- Add timestamp to analysis
        analysis.timestamp = GetTime()

        -- Extract context from preState if available (stored in analysis by SpellAnalyzer or passed separately)
        -- Context should already be in analysis if SpellAnalyzer preserves it from preState

        -- Store the observation
        tinsert(observations, analysis)
        local currentTotal = self.db.char.stats.totalObservations
        self.db.char.stats.totalObservations = currentTotal + 1

        self:Debug("🔍 Stored observation, new count: %d, total observations: %d", #observations, currentTotal + 1)

        -- Limit observations per spell to prevent memory bloat
        local maxObs = self.db.global.maxObservationsPerSpell
        if #observations > maxObs then
            -- Remove oldest observation
            table.remove(observations, 1)
            local newTotal = self.db.char.stats.totalObservations - 1
            self.db.char.stats.totalObservations = newTotal
            self:Debug("🔍 Removed oldest observation, trimmed to: %d", #observations)
        end

        local spellInfo = WoWAPI.GetSpellInfo(spellId)
        local spellName = spellInfo and spellInfo.name or tostring(spellId)
        if self.debug then self:Debug("✅ Successfully stored observation for %s (%d total)", spellName, #observations) end
        return true
    end

    --- Check if auto-consolidation should be triggered for a spell
    --- @param spellId number The spell ID to check
    function PredictionManager:CheckAutoConsolidation(spellId)
        self:Debug("🔍 PredictionManager:CheckAutoConsolidation called for spell %d", spellId)
        self:Debug("🔍 Auto-consolidate enabled: %s", self.db.char.autoConsolidate)
        self:Debug("🔍 Consolidation threshold: %d", self.db.char.consolidationThreshold)

        local spellChanges = self:GetSpellChanges()
        if not spellChanges then
            self:Debug("🚨 CheckAutoConsolidation: No observations table")
            return
        end

        local observations = spellChanges[spellId]
        if not observations then
            self:Debug("🔍 CheckAutoConsolidation: No observations found for spell %d", spellId)
            return
        end

        local observationCount = #observations
        self:Debug("🔍 CheckAutoConsolidation: Spell %d has %d observations", spellId, observationCount)

        if observationCount >= self.db.char.consolidationThreshold then
            self:Debug("🔍 CheckAutoConsolidation: Threshold reached! Triggering ProcessSpell for %d", spellId)
            local result = self:ProcessSpell(spellId)
            if result then
                self:Debug("✅ CheckAutoConsolidation: Successfully consolidated %d observations for spell %d",
                    observationCount, spellId)
            else
                self:Debug("🚨 CheckAutoConsolidation: Failed to consolidate observations for spell %d", spellId)
            end
        else
            self:Debug("🔍 CheckAutoConsolidation: Threshold not reached yet. Need %d more observations",
                self.db.char.consolidationThreshold - observationCount)
        end
    end
end

do -- Data Consolidation Functions
    --- Process and consolidate all observations for a specific spell
    --- @param spellId number The spell ID to process
    --- @return table|nil Consolidated spell data or nil if no observations
    function PredictionManager:ProcessSpell(spellId)
        self:Debug("🔍 PredictionManager:ProcessSpell called for spell %d", spellId)

        if not spellId then
            self:Debug("🚨 ProcessSpell: Invalid spellId provided")
            return nil
        end

        local spellChanges = self:GetSpellChanges()

        if not spellChanges then
            self:Debug("🚨 ProcessSpell: No observations table available")
            return nil
        end

        local observations = spellChanges[spellId]

        if not observations or #observations == 0 then
            if self.debug then self:Debug("🔍 ProcessSpell: No observations found for spell %d", spellId) end
            if self.debug then self:Debug("No observations found for spell %d", spellId) end
            return nil
        end

        self:Debug("🔍 ProcessSpell: Found %d observations for spell %d", #observations, spellId)

        local consolidated = self:ConsolidateObservations(spellId, observations)

        if not consolidated then
            self:Debug("🚨 ProcessSpell: ConsolidateObservations returned nil for spell %d", spellId)
            return nil
        end

        -- Store consolidated data
        local consolidatedData = self.db.char.consolidated
        consolidatedData[spellId] = consolidated
        self.db.char.consolidated = consolidatedData
        self.db.char.stats.lastConsolidation = GetTime()

        self:Debug("🔍 ProcessSpell: Stored consolidated data for spell %d", spellId)
        self:Debug("🔍 ProcessSpell: Consolidated data keys: %s", next(consolidated) and "has data" or "empty")
        if consolidated.cost and consolidated.cost.resources then
            self:Debug("🔍 ProcessSpell: Cost resources: %s",
                next(consolidated.cost.resources) and "has resources" or "no resources")
        end
        if consolidated.applies and consolidated.applies.buffs then
            self:Debug("🔍 ProcessSpell: Applies buffs: %s",
                next(consolidated.applies.buffs) and "has buffs" or "no buffs")
        end

        local spellInfo = WoWAPI.GetSpellInfo(spellId)
        local spellName = spellInfo and spellInfo.name or tostring(spellId)
        if self.debug then self:Info("Consolidated %d observations for %s", #observations, spellName) end
        if self.debug then
            self:Debug("✅ ProcessSpell: Successfully consolidated %d observations for %s", #observations,
                spellName)
        end

        return consolidated
    end

    --- Consolidate multiple observations into a single data structure
    --- @param spellId number The spell ID being processed
    --- @param observations table Array of analysis results
    --- @return table Consolidated spell data
    function PredictionManager:ConsolidateObservations(spellId, observations)
        -- Add nil checks for observations array
        if not observations or type(observations) ~= "table" or #observations == 0 then
            self:Debug(
                "ConsolidateObservations: observations is nil, empty, or not a table, returning empty consolidated data")
            return {
                spellId = spellId,
                observationCount = 0,
                firstSeen = 0,
                lastSeen = 0,
                cost = { resources = {}, secondary = {}, runes = {} },
                generates = { resources = {}, secondary = {}, runes = {} },
                applies = { buffs = {}, debuffs = {} },
                consumes = { buffs = {}, debuffs = {} },
                cooldowns = { triggered = {}, reset = {} }
            }
        end

        -- Apply anomaly detection if enabled
        local filteredObservations = observations
 if AdvancedPredictionEngine.db and AdvancedPredictionEngine.db.char.anomalyDetectionEnabled then
            -- Filter anomalies for each resource type
            filteredObservations, _ = AdvancedPredictionEngine:FilterAnomalies(observations, function(obs)
                -- Extract a representative value for anomaly detection
                if obs.cost and obs.cost.resources then
                    for _, value in pairs(obs.cost.resources) do
                        if type(value) == "number" then
                            return value
                        end
                    end
                end
                return nil
            end)
            if #filteredObservations < #observations then
                self:Debug("ConsolidateObservations: Filtered %d anomalies, %d observations remaining",
                    #observations - #filteredObservations, #filteredObservations)
            end
        end

        -- Note: Context-aware consolidation is handled separately via ConsolidateByContext
        -- to avoid recursion. This function handles regular consolidation.

        local consolidated = {
            spellId = spellId,
            observationCount = #filteredObservations,
            firstSeen = filteredObservations[1] and filteredObservations[1].timestamp or 0,
            lastSeen = filteredObservations[#filteredObservations] and filteredObservations[#filteredObservations].timestamp or 0,

            -- 🔧 FIX: Include runes in consolidated effects structure
            cost = { resources = {}, secondary = {}, runes = {} },
            generates = { resources = {}, secondary = {}, runes = {} },
            applies = { buffs = {}, debuffs = {} },
            consumes = { buffs = {}, debuffs = {} },
            cooldowns = { triggered = {}, reset = {} }
        }

        -- Apply temporal weighting if enabled
        local weights = nil
 if AdvancedPredictionEngine.db and AdvancedPredictionEngine.db.char.temporalWeightingEnabled then
            weights = AdvancedPredictionEngine:CalculateTemporalWeights(filteredObservations)
        end

        -- Process each observation (with temporal weighting if available)
        for i, observation in ipairs(filteredObservations) do
            self:MergeObservationData(consolidated, observation, weights and weights[i])
        end

        -- Calculate frequencies and averages
        self:CalculateConsolidatedStats(consolidated, #filteredObservations, weights)

        return consolidated
    end

    --- Consolidate observations by context (context-aware consolidation)
    --- @param spellId number The spell ID being processed
    --- @param observations table Array of analysis results with context
    --- @return table Consolidated spell data with context-specific data
    function PredictionManager:ConsolidateByContext(spellId, observations)
                -- Cluster observations by context
        local clusters = AdvancedPredictionEngine:ClusterByContext(observations)

        -- Temporarily disable context-aware consolidation to avoid recursion
        local wasEnabled = self.db.char.contextualLearningEnabled
        self.db.char.contextualLearningEnabled = false

        -- Consolidate each context cluster (using regular consolidation)
        local contextConsolidated = {}
        for contextHash, clusterObservations in pairs(clusters) do
            if #clusterObservations > 0 then
                -- Regular consolidation for this context cluster (recursion-safe)
                local contextData = self:ConsolidateObservations(spellId, clusterObservations)
                contextConsolidated[contextHash] = contextData
            end
        end

        -- Restore context-aware consolidation setting
        self.db.char.contextualLearningEnabled = wasEnabled

        -- Create overall consolidated data with context-specific data
        local consolidated = {
            spellId = spellId,
            observationCount = #observations,
            firstSeen = observations[1] and observations[1].timestamp or 0,
            lastSeen = observations[#observations] and observations[#observations].timestamp or 0,
            contexts = contextConsolidated,

            -- Overall consolidated data (from all contexts)
            cost = { resources = {}, secondary = {}, runes = {} },
            generates = { resources = {}, secondary = {}, runes = {} },
            applies = { buffs = {}, debuffs = {} },
            consumes = { buffs = {}, debuffs = {} },
            cooldowns = { triggered = {}, reset = {} }
        }

        -- Also create overall consolidated data (for backward compatibility)
        local weights = nil
        if AdvancedPredictionEngine.db and AdvancedPredictionEngine.db.char.temporalWeightingEnabled then
            weights = AdvancedPredictionEngine:CalculateTemporalWeights(observations)
        end

        for i, observation in ipairs(observations) do
            self:MergeObservationData(consolidated, observation, weights and weights[i])
        end

        self:CalculateConsolidatedStats(consolidated, #observations, weights)

        return consolidated
    end

    --- Get observations matching a specific context
    --- @param spellId number The spell ID
    --- @param context table Context data to match
    --- @return table|nil Array of matching observations or nil
    function PredictionManager:GetContextualObservations(spellId, context)
                local spellChanges = self:GetSpellChanges()
        if not spellChanges or not spellChanges[spellId] then
            return nil
        end

        local observations = spellChanges[spellId]
        if not observations or #observations == 0 then
            return nil
        end

        local contextHash = AdvancedPredictionEngine:CalculateContextHash(context)
        local matching = {}

        for _, obs in ipairs(observations) do
            if obs.context then
                local obsHash = AdvancedPredictionEngine:CalculateContextHash(obs.context)
                if obsHash == contextHash then
                    table.insert(matching, obs)
                end
            end
        end

        return #matching > 0 and matching or nil
    end

    --- Merge a single observation into consolidated data
    --- @param consolidated table The consolidated data structure
    --- @param observation table A single observation to merge
    --- @param weight number|nil Temporal weight for this observation (optional)
    function PredictionManager:MergeObservationData(consolidated, observation, weight)
        -- Add nil check for the entire observation
        if not observation or type(observation) ~= "table" then
            self:Debug("MergeObservationData: observation is nil or not a table, skipping")
            return
        end

        -- Get weight for this observation
        local obsWeight = weight or 1.0

        -- Merge resource costs
        if observation.cost then
            if observation.cost.resources then
                self:MergeResourceData(consolidated.cost.resources, observation.cost.resources, obsWeight)
            end
            if observation.cost.secondary then
                self:MergeResourceData(consolidated.cost.secondary, observation.cost.secondary, obsWeight)
            end
            -- 🔧 FIX: Handle rune costs specifically
            if observation.cost.runes then
                if not consolidated.cost.runes then
                    consolidated.cost.runes = {}
                end
                self:MergeResourceData(consolidated.cost.runes, observation.cost.runes, obsWeight)
            end
        end

        -- Merge resource generation
        if observation.generates then
            if observation.generates.resources then
                self:MergeResourceData(consolidated.generates.resources, observation.generates.resources, obsWeight)
            end
            if observation.generates.secondary then
                self:MergeResourceData(consolidated.generates.secondary, observation.generates.secondary, obsWeight)
            end
            -- 🔧 FIX: Handle rune generation specifically
            if observation.generates.runes then
                if not consolidated.generates.runes then
                    consolidated.generates.runes = {}
                end
                self:MergeResourceData(consolidated.generates.runes, observation.generates.runes, obsWeight)
            end
        end

        -- Merge applied effects
        if observation.applies then
            if observation.applies.buffs then
                self:MergeEffectData(consolidated.applies.buffs, observation.applies.buffs)
            end
            if observation.applies.debuffs then
                self:MergeEffectData(consolidated.applies.debuffs, observation.applies.debuffs)
            end
        end

        -- Merge consumed effects
        if observation.consumes then
            if observation.consumes.buffs then
                self:MergeEffectData(consolidated.consumes.buffs, observation.consumes.buffs)
            end
            if observation.consumes.debuffs then
                self:MergeEffectData(consolidated.consumes.debuffs, observation.consumes.debuffs)
            end
        end

        -- Merge cooldown data
        if observation.cooldowns then
            if observation.cooldowns.triggered then
                self:MergeCooldownData(consolidated.cooldowns.triggered, observation.cooldowns.triggered)
            end
            if observation.cooldowns.reset then
                self:MergeCooldownData(consolidated.cooldowns.reset, observation.cooldowns.reset)
            end
        end
    end

    --- Merge resource data (costs/generation)
    --- @param consolidated table Consolidated resource data
    --- @param observation table Observation resource data
    --- @param weight number|nil Temporal weight for this observation (optional)
    function PredictionManager:MergeResourceData(consolidated, observation, weight)
        -- Add nil check to prevent "bad argument #1 to 'pairs'" error
        if not observation or type(observation) ~= "table" then
            self:Debug("MergeResourceData: observation is nil or not a table, skipping")
            return
        end

        local w = weight or 1.0 -- Default weight is 1.0

        for resource, amount in pairs(observation) do
            if not consolidated[resource] then
                consolidated[resource] = { values = {}, weights = {}, count = 0, totalWeight = 0 }
            end

            tinsert(consolidated[resource].values, amount)
            tinsert(consolidated[resource].weights, w)
            consolidated[resource].count = consolidated[resource].count + 1
            consolidated[resource].totalWeight = (consolidated[resource].totalWeight or 0) + w
        end
    end

    --- Merge effect data (buffs/debuffs)
    --- @param consolidated table Consolidated effect data
    --- @param observation table Observation effect data
    function PredictionManager:MergeEffectData(consolidated, observation)
        -- Add nil check to prevent "bad argument #1 to 'pairs'" error
        if not observation or type(observation) ~= "table" then
            self:Debug("MergeEffectData: observation is nil or not a table, skipping")
            return
        end

        for effectId, data in pairs(observation) do
            if not consolidated[effectId] then
                consolidated[effectId] = {
                    occurrences = 0,
                    stackData = {},
                    durationData = {}
                }
            end

            consolidated[effectId].occurrences = consolidated[effectId].occurrences + 1

            -- Track stacks
            local stacks = data.stacks or data.stacksAdded or data.stacksRemoved or 1
            tinsert(consolidated[effectId].stackData, stacks)

            -- Track duration if present
            if data.duration and data.duration > 0 then
                tinsert(consolidated[effectId].durationData, data.duration)
            end
        end
    end

    --- Merge cooldown data
    --- @param consolidated table Consolidated cooldown data
    --- @param observation table Observation cooldown data
    function PredictionManager:MergeCooldownData(consolidated, observation)
        -- Add nil check to prevent "bad argument #1 to 'pairs'" error
        if not observation or type(observation) ~= "table" then
            self:Debug("MergeCooldownData: observation is nil or not a table, skipping")
            return
        end

        for cdId, data in pairs(observation) do
            if not consolidated[cdId] then
                consolidated[cdId] = {
                    occurrences = 0,
                    durationData = {}
                }
            end

            consolidated[cdId].occurrences = consolidated[cdId].occurrences + 1

            if data.duration then
                tinsert(consolidated[cdId].durationData, data.duration)
            end
        end
    end

    --- Calculate final statistics for consolidated data
    --- @param consolidated table The consolidated data structure
    --- @param totalObservations number Total number of observations
    --- @param weights table|nil Array of temporal weights (optional)
    function PredictionManager:CalculateConsolidatedStats(consolidated, totalObservations, weights)
        -- Add nil checks to prevent errors when data structures are missing
        if not consolidated then
            self:Debug("CalculateConsolidatedStats: consolidated is nil, skipping")
            return
        end

        -- Calculate resource averages
        if consolidated.cost and consolidated.cost.resources then
            self:CalculateResourceAverages(consolidated.cost.resources, totalObservations)
        end
        if consolidated.cost and consolidated.cost.secondary then
            self:CalculateResourceAverages(consolidated.cost.secondary, totalObservations)
        end
        if consolidated.cost and consolidated.cost.runes then
            self:CalculateResourceAverages(consolidated.cost.runes, totalObservations)
        end
        if consolidated.generates and consolidated.generates.resources then
            self:CalculateResourceAverages(consolidated.generates.resources, totalObservations)
        end
        if consolidated.generates and consolidated.generates.secondary then
            self:CalculateResourceAverages(consolidated.generates.secondary, totalObservations)
        end
        if consolidated.generates and consolidated.generates.runes then
            self:CalculateResourceAverages(consolidated.generates.runes, totalObservations)
        end

        -- Calculate effect frequencies
        if consolidated.applies and consolidated.applies.buffs then
            self:CalculateEffectStats(consolidated.applies.buffs, totalObservations)
        end
        if consolidated.applies and consolidated.applies.debuffs then
            self:CalculateEffectStats(consolidated.applies.debuffs, totalObservations)
        end
        if consolidated.consumes and consolidated.consumes.buffs then
            self:CalculateEffectStats(consolidated.consumes.buffs, totalObservations)
        end
        if consolidated.consumes and consolidated.consumes.debuffs then
            self:CalculateEffectStats(consolidated.consumes.debuffs, totalObservations)
        end

        -- Calculate cooldown frequencies
        if consolidated.cooldowns and consolidated.cooldowns.triggered then
            self:CalculateCooldownStats(consolidated.cooldowns.triggered, totalObservations)
        end
        if consolidated.cooldowns and consolidated.cooldowns.reset then
            self:CalculateCooldownStats(consolidated.cooldowns.reset, totalObservations)
        end
    end

    --- Calculate averages for resource data
    --- @param resourceData table Resource data to calculate averages for
    --- @param totalObservations number Total number of observations
    function PredictionManager:CalculateResourceAverages(resourceData, totalObservations)
        for resource, data in pairs(resourceData) do
            if data.values and #data.values > 0 then
                -- Check if we have temporal weights
                local hasWeights = data.weights and #data.weights == #data.values
                local totalWeight = data.totalWeight or (#data.values)
                -- 🔧 FIX: Handle both number values and table values (for runes)
                self:Debug("🔍 CalculateResourceAverages: Processing resource '%s' with %d values", resource, #data
                    .values)

                -- Check if we're dealing with table-based values (like runes)
                local firstValue = data.values[1]
                local isTableBased = type(firstValue) == "table"

                self:Debug("🔍 CalculateResourceAverages: Resource '%s' is %s", resource,
                    isTableBased and "table-based (runes)" or "number-based")

                if isTableBased then
                    -- Handle table-based values (e.g., runes = { Unholy = 1, Frost = 1 })
                    local sums = {}
                    local counts = {}

                    for _, value in ipairs(data.values) do
                        self:Debug("🔍 CalculateResourceAverages: Processing table value: %s",
                            type(value) == "table" and "table" or tostring(value))

                        if type(value) == "table" then
                            for k, v in pairs(value) do
                                if type(v) == "number" then
                                    sums[k] = (sums[k] or 0) + v
                                    counts[k] = (counts[k] or 0) + 1
                                    self:Debug("🔍 CalculateResourceAverages: Added %s: %d (total: %d, count: %d)", k, v,
                                        sums[k], counts[k])
                                end
                            end
                        end
                    end

                    -- Calculate averages for each key in the table
                    local averages = {}
                    local minValues = {}
                    local maxValues = {}

                    for k, sum in pairs(sums) do
                        averages[k] = sum / counts[k]
                        self:Debug("🔍 CalculateResourceAverages: Average for %s: %.2f", k, averages[k])

                        -- Calculate min/max for this key
                        local keyValues = {}
                        for _, value in ipairs(data.values) do
                            if type(value) == "table" and value[k] then
                                table.insert(keyValues, value[k])
                            end
                        end
                        if #keyValues > 0 then
                            minValues[k] = min(unpack(keyValues))
                            maxValues[k] = max(unpack(keyValues))
                        end
                    end

                    data.average = averages
                    data.frequency = data.count / totalObservations
                    data.min = minValues
                    data.max = maxValues
                else
                    -- Handle number-based values (traditional resources)
                    local sum = 0
                    local weightedSum = 0

                    if hasWeights then
                        -- Use weighted average
                        for i, value in ipairs(data.values) do
                            if type(value) == "number" then
                                local w = data.weights[i] or 1.0
                                weightedSum = weightedSum + value * w
                                self:Debug("🔍 CalculateResourceAverages: Added weighted value: %d * %.2f = %.2f (running sum: %.2f)",
                                    value, w, value * w, weightedSum)
                            end
                        end
                        data.average = weightedSum / totalWeight
                    else
                        -- Use simple average
                        for _, value in ipairs(data.values) do
                            if type(value) == "number" then
                                sum = sum + value
                                self:Debug("🔍 CalculateResourceAverages: Added number value: %d (running sum: %d)", value, sum)
                            else
                                self:Debug("🔍 CalculateResourceAverages: Skipping non-number value: %s", tostring(value))
                            end
                        end
                        data.average = sum / #data.values
                    end

                    data.frequency = data.count / totalObservations
                    data.min = min(unpack(data.values))
                    data.max = max(unpack(data.values))

                    self:Debug("🔍 CalculateResourceAverages: Number-based average for %s: %.2f (%s)",
                        resource, data.average, hasWeights and "weighted" or "simple")
                end

                -- Clear raw values and weights to save memory
                data.values = nil
                data.weights = nil
                data.totalWeight = nil

                self:Debug("🔍 CalculateResourceAverages: Completed processing for resource '%s'", resource)
            else
                self:Debug("🔍 CalculateResourceAverages: Skipping resource '%s' - no values available", resource)
            end
        end
    end

    --- Calculate statistics for effect data
    --- @param effectData table Effect data to calculate stats for
    --- @param totalObservations number Total number of observations
    function PredictionManager:CalculateEffectStats(effectData, totalObservations)
        for effectId, data in pairs(effectData) do
            data.frequency = data.occurrences / totalObservations

            -- Calculate stack averages
            if data.stackData and #data.stackData > 0 then
                local sum = 0
                for _, stacks in ipairs(data.stackData) do
                    sum = sum + stacks
                end
                data.averageStacks = sum / #data.stackData
                data.stackData = nil -- Clear to save memory
            end

            -- Calculate duration averages
            if data.durationData and #data.durationData > 0 then
                local sum = 0
                for _, duration in ipairs(data.durationData) do
                    sum = sum + duration
                end
                data.averageDuration = sum / #data.durationData
                data.durationData = nil -- Clear to save memory
            end
        end
    end

    --- Calculate statistics for cooldown data
    --- @param cooldownData table Cooldown data to calculate stats for
    --- @param totalObservations number Total number of observations
    function PredictionManager:CalculateCooldownStats(cooldownData, totalObservations)
        for cdId, data in pairs(cooldownData) do
            data.frequency = data.occurrences / totalObservations

            if data.durationData and #data.durationData > 0 then
                local sum = 0
                for _, duration in ipairs(data.durationData) do
                    sum = sum + duration
                end
                data.averageDuration = sum / #data.durationData
                data.durationData = nil -- Clear to save memory
            end
        end
    end
end

do -- Query Functions
    --- Get consolidated data for a specific spell
    --- @param spellId number The spell ID to get data for
    --- @return table|nil Consolidated spell data or nil if not found
    function PredictionManager:GetConsolidatedData(spellId)
        if not spellId then return nil end

        local consolidated = self.db.char.consolidated
        return consolidated[spellId]
    end

    --- Get observation count for a specific spell
    --- @param spellId number The spell ID to check
    --- @return number Number of observations for the spell
    function PredictionManager:GetObservationCount(spellId)
        if not spellId then return 0 end

        local spellChanges = self:GetSpellChanges()
        if not spellChanges then return 0 end

        local observations = spellChanges[spellId]
        return observations and #observations or 0
    end

    --- Get statistics about all accumulated data
    --- @return table Statistics about observations and consolidated data
    function PredictionManager:GetStats()
        return {
            totalObservations = self.db.char.stats.totalObservations,
            spellsCaptured = self.db.char.stats.spellsCaptured,
            consolidatedSpells = self:CountConsolidatedSpells(),
            lastConsolidation = self.db.char.stats.lastConsolidation,
        }
    end

    --- Count the number of spells with consolidated data
    --- @return number Number of spells with consolidated data
    function PredictionManager:CountConsolidatedSpells()
        local consolidated = self.db.char.consolidated
        local count = 0
        for _ in pairs(consolidated) do
            count = count + 1
        end
        return count
    end
end

do -- Message Handlers
    --- @param message string The message name
    --- @param spellId number The spell ID that was learned
    --- @param preState table Pre-cast state snapshot
    --- @param postState table Post-cast state snapshot
    function PredictionManager:NAG_SPELL_LEARNED(message, spellId, preState, postState)
        --print(string.format("🔍 PredictionManager: Message received! spellId=%d, preState=%s, postState=%s", spellId, preState and "exists" or "nil", postState and "exists" or "nil"))
        self:Debug("🔍 PredictionManager:OnSpellLearned received: %s, spellId: %d, preState: %s, postState: %s", message,
            spellId, preState and "exists" or "nil", postState and "exists" or "nil")

        -- Use SpellAnalyzer to convert states into spell effects
        local analysis = SpellAnalyzer:Analyze(preState, postState)

        self:Debug("🔍 SpellAnalyzer:Analyze result: %s", analysis and "success" or "failed")
        if analysis then
            self:Debug("🔍 Analysis contains: %s resource costs, %s buff applies",
                next(analysis.cost.resources) and "resource costs" or "no costs",
                next(analysis.applies.buffs) and "buff applies" or "no buff applies")
        end

        if analysis then
            -- Extract and store context from preState
            if preState and preState.context then
                analysis.context = preState.context
            elseif preState then
                -- Fallback: create minimal context if not available
                analysis.context = {
                    inCombat = InCombatLockdown() or false,
                    combatState = "solo"
                }
            end

            self:RecordObservation(spellId, analysis)
        else
            self:Debug("🚨 SpellAnalyzer:Analyze returned nil for spell %d", spellId)
            -- 🔍 DEBUG: Add detailed analysis of why analysis failed
            if not preState then
                self:Debug("🚨 PreState is nil - cannot analyze")
            elseif not postState then
                self:Debug("🚨 PostState is nil - cannot analyze")
            else
                self:Debug("🚨 Both states exist but analysis returned nil - checking state structure")
                self:Debug("🚨 PreState keys: %s resources, %s buffs, %s debuffs, %s cooldowns",
                    preState.resources and "resources" or "no resources",
                    preState.buffs and "buffs" or "no buffs",
                    preState.debuffs and "debuffs" or "no debuffs",
                    preState.cooldowns and "cooldowns" or "no cooldowns")
                self:Debug("🚨 PostState keys: %s resources, %s buffs, %s debuffs, %s cooldowns",
                    postState.resources and "resources" or "no resources",
                    postState.buffs and "buffs" or "no buffs",
                    postState.debuffs and "debuffs" or "no debuffs",
                    postState.cooldowns and "cooldowns" or "no cooldowns")
            end
        end
    end
end

do -- Options UI
    --- Composer for unified SpellLearner category
    --- @param options table The options structure to inject into
    --- @param context table Optional context information
    --- @return table Modified options structure
    function PredictionManager:spelllearner(options, context)
        if not options.args then options.args = {} end
        if not options.args.predictionManager then
            options.args.predictionManager = {
                type = "group",
                name = L["predictionManager"] or "Prediction Manager",
                order = 2,
                childGroups = "tab",
                args = {
                    general = {
                        type = "group",
                        name = L["general"] or "General",
                        order = 1,
                        args = {}
                    },
                    stats = {
                        type = "group",
                        name = L["statistics"] or "Statistics",
                        order = 2,
                        args = {}
                    }
                }
            }
        end

        local generalArgs = options.args.predictionManager.args.general.args
        local statsArgs = options.args.predictionManager.args.stats.args

        generalArgs.enabled = OptionsFactory:CreateToggle(
            function() return L["enabled"] or "Enabled" end,
            function() return L["enabledDesc"] or "Enable or disable this module/feature" end,
            function() return self:GetSetting("char", "enabled") end,
            function(_, value)
                self:SetSetting("char", "enabled", value)
                if value then
                    self:Enable()
                else
                    self:Disable()
                end
            end,
            { order = 1 }
        )
        generalArgs.autoConsolidate = OptionsFactory:CreateToggle(
            function() return L["autoConsolidate"] or "Auto Consolidate" end,
            function()
                return L["autoConsolidateDesc"] or
                    "Automatically consolidate observations when threshold is reached"
            end,
            function() return self:GetSetting("char", "autoConsolidate") end,
            function(_, value)
                self:SetSetting("char", "autoConsolidate", value)
            end,
            { order = 2 }
        )
        generalArgs.consolidationThreshold = OptionsFactory:CreateRange(
            function() return L["consolidationThreshold"] or "Consolidation Threshold" end,
            function()
                return L["consolidationThresholdDesc"] or
                    "Number of observations before auto-consolidation triggers"
            end,
            function() return self:GetSetting("char", "consolidationThreshold") end,
            function(_, value)
                self:SetSetting("char", "consolidationThreshold", value)
            end,
            {
                order = 3,
                min = 5,
                max = 50,
                step = 1
            }
        )

        generalArgs.contextualHeader = {
            type = "header",
            name = L["contextualHeader"] or "Contextual Learning",
            order = 10,
        }

        generalArgs.contextualLearningEnabled = OptionsFactory:CreateToggle(L["contextualLearningEnabled"] or "Enable Contextual Learning", L["contextualLearningEnabledDesc"] or "Group observations by context (combat state, buffs, target health) for more accurate predictions",
            function() return self:GetSetting("char", "contextualLearningEnabled") end,
            function(_, v) self:SetSetting("char", "contextualLearningEnabled", v) end,
            { order = 11 }
        )

        generalArgs.contextTolerance = OptionsFactory:CreateRange(L["contextTolerance"] or "Context Tolerance", L["contextToleranceDesc"] or "Context similarity threshold for grouping observations (0.0-1.0)",
            function() return self:GetSetting("char", "contextTolerance") end,
            function(_, v) self:SetSetting("char", "contextTolerance", v) end,
            { order = 12, min = 0.0, max = 1.0, step = 0.1 }
        )

        statsArgs.totalObservations = {
            type = "description",
            name = function()
                local stats = self:GetStats()
                return format(L["totalObservations"] or "Total Observations: %d", stats.totalObservations)
            end,
            order = 1,
        }
        statsArgs.spellsCaptured = {
            type = "description",
            name = function()
                local stats = self:GetStats()
                return format(L["spellsCaptured"] or "Spells Captured: %d", stats.spellsCaptured)
            end,
            order = 2,
        }
        statsArgs.consolidatedSpells = {
            type = "description",
            name = function()
                local stats = self:GetStats()
                return format(L["consolidatedSpells"] or "Consolidated Spells: %d", stats.consolidatedSpells)
            end,
            order = 3,
        }
        statsArgs.clearAllData = OptionsFactory:CreateExecute(
            function() return L["clearAllData"] or "Clear All Data" end,
            function()
                return L["clearAllDataDesc"] or
                    "Clear all accumulated observations and consolidated data"
            end,
            function()
                self:ClearAllData()
            end,
            {
                order = 10,
                confirm = true
            }
        )

        return options
    end

    --- Gets the options table for module settings
    --- @return table The options table for AceConfig
    function PredictionManager:GetOptions()
        return {
            type = "group",
            name = L["SpellLearner"] or "SpellLearner",
            order = 25,
            childGroups = "tab",
            args = {
                predictionManager = {
                    type = "group",
                    name = L["predictionManager"] or "Prediction Manager",
                    order = 2,
                    childGroups = "tab",
                    args = {
                        general = {
                            type = "group",
                            name = L["general"] or "General",
                            order = 1,
                            args = {
                        enabled = OptionsFactory:CreateToggle(
                            function() return L["enabled"] or "Enabled" end,
                            function() return L["enabledDesc"] or "Enable or disable this module/feature" end,
                            function() return self:GetSetting("char", "enabled") end,
                            function(_, value)
                                self:SetSetting("char", "enabled", value)
                                if value then
                                    self:Enable()
                                else
                                    self:Disable()
                                end
                            end,
                            { order = 1 }
                        ),
                        autoConsolidate = OptionsFactory:CreateToggle(
                            function() return L["autoConsolidate"] or "Auto Consolidate" end,
                            function()
                                return L["autoConsolidateDesc"] or
                                    "Automatically consolidate observations when threshold is reached"
                            end,
                            function() return self:GetSetting("char", "autoConsolidate") end,
                            function(_, value)
                                self:SetSetting("char", "autoConsolidate", value)
                            end,
                            { order = 2 }
                        ),
                        consolidationThreshold = OptionsFactory:CreateRange(
                            function() return L["consolidationThreshold"] or "Consolidation Threshold" end,
                            function()
                                return L["consolidationThresholdDesc"] or
                                    "Number of observations before auto-consolidation triggers"
                            end,
                            function() return self:GetSetting("char", "consolidationThreshold") end,
                            function(_, value)
                                self:SetSetting("char", "consolidationThreshold", value)
                            end,
                            {
                                order = 3,
                                min = 5,
                                max = 50,
                                step = 1
                            }
                        ),
                    }
                },
                stats = {
                    type = "group",
                    name = L["statistics"] or "Statistics",
                    order = 2,
                    args = {
                        totalObservations = {
                            type = "description",
                            name = function()
                                local stats = self:GetStats()
                                return format(L["totalObservations"] or "Total Observations: %d", stats.totalObservations)
                            end,
                            order = 1,
                        },
                        spellsCaptured = {
                            type = "description",
                            name = function()
                                local stats = self:GetStats()
                                return format(L["spellsCaptured"] or "Spells Captured: %d", stats.spellsCaptured)
                            end,
                            order = 2,
                        },
                        consolidatedSpells = {
                            type = "description",
                            name = function()
                                local stats = self:GetStats()
                                return format(L["consolidatedSpells"] or "Consolidated Spells: %d", stats.consolidatedSpells)
                            end,
                            order = 3,
                        },
                        clearAllData = OptionsFactory:CreateExecute(
                            function() return L["clearAllData"] or "Clear All Data" end,
                            function()
                                return L["clearAllDataDesc"] or
                                    "Clear all accumulated observations and consolidated data"
                            end,
                            function()
                                self:ClearAllData()
                            end,
                            {
                                order = 10,
                                confirm = true
                            }
                        ),
                    }
                },
                    }
                },
            }
        }
    end
end
