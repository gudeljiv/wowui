--- ============================ HEADER ============================
--[[
    AdvancedPredictionEngine.lua - Machine Learning-Inspired Prediction Algorithms for NAG

    Provides advanced algorithms for spell prediction enhancement including:
    - Adaptive learning rates
    - Temporal weighting (exponential decay)
    - Anomaly detection (Z-score, IQR)
    - Contextual clustering
    - Iterative prediction optimization

    Authors: NAG Team
    License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
    Status: Development
]]

--- ============================ LOCALIZE ============================
local _, ns = ...
local GetTime = _G.GetTime
local L = ns.AceLocale:GetLocale("NAG")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Lua APIs
local floor = math.floor
local abs = math.abs
local max = math.max
local min = math.min
local sqrt = math.sqrt
local exp = math.exp
local log = math.log

-- Table operations
local pairs = pairs
local ipairs = ipairs
local type = type

--- ============================ CONTENT ============================

-- Default settings
local defaults = {
    global = {
        version = 1,
    },
    char = {
        enabled = true,
        -- Adaptive Learning Rate settings
        learningRateBase = 0.1,        -- Base learning rate (0.0-1.0)
        learningRateDecayFactor = 0.05, -- Decay factor for learning rate reduction
        learningRateMin = 0.01,        -- Minimum learning rate
        -- Temporal Weighting settings
        temporalWeightingEnabled = true,
        temporalHalfLife = 3600,       -- Half-life in seconds (default: 1 hour)
        -- Anomaly Detection settings
        anomalyDetectionEnabled = true,
        anomalyDetectionMethod = "both", -- "zscore", "iqr", or "both"
        anomalyZScoreThreshold = 3.0,   -- Z-score threshold for anomalies
        anomalyIQRMultiplier = 1.5,     -- IQR multiplier for anomaly detection
    }
}

--- @class AdvancedPredictionEngine: CoreModule
local AdvancedPredictionEngine = NAG:CreateModule("AdvancedPredictionEngine", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = "spelllearner",
    optionsOrder = 4,
    optionsComposers = {
        ["spelllearner"] = true
    },
    debugCategories = {ns.DEBUG_CATEGORIES.FEATURES},
})
local module = AdvancedPredictionEngine
ns.AdvancedPredictionEngine = AdvancedPredictionEngine

do -- Ace3 lifecycle methods
    --- Initialize the module
    function AdvancedPredictionEngine:ModuleInitialize()
        -- Module is ready to use
    end

    --- Enable the module
    function AdvancedPredictionEngine:ModuleEnable()
        if not self.db.char.enabled then
            self:Debug("AdvancedPredictionEngine is disabled")
            return
        end
    end

    --- Disable the module
    function AdvancedPredictionEngine:ModuleDisable()
    end
end

-- ============================ STATISTICAL HELPER FUNCTIONS ============================

--- Calculate mean of a numeric array
--- @param values table Array of numbers
--- @return number|nil Mean value or nil if empty
local function CalculateMean(values)
    if not values or #values == 0 then return nil end
    local sum = 0
    for _, value in ipairs(values) do
        if type(value) == "number" then
            sum = sum + value
        end
    end
    return sum / #values
end

--- Calculate standard deviation
--- @param values table Array of numbers
--- @param mean number|nil Pre-calculated mean (optional)
--- @return number|nil Standard deviation or nil if empty
local function CalculateStdDev(values, mean)
    if not values or #values == 0 then return nil end
    local m = mean or CalculateMean(values)
    if not m then return nil end

    local variance = 0
    local count = 0
    for _, value in ipairs(values) do
        if type(value) == "number" then
            variance = variance + (value - m) ^ 2
            count = count + 1
        end
    end
    if count == 0 then return nil end
    return sqrt(variance / count)
end

--- Calculate variance
--- @param values table Array of numbers
--- @param mean number|nil Pre-calculated mean (optional)
--- @return number|nil Variance or nil if empty
local function CalculateVariance(values, mean)
    if not values or #values == 0 then return nil end
    local m = mean or CalculateMean(values)
    if not m then return nil end

    local variance = 0
    local count = 0
    for _, value in ipairs(values) do
        if type(value) == "number" then
            variance = variance + (value - m) ^ 2
            count = count + 1
        end
    end
    if count == 0 then return nil end
    return variance / count
end

--- Calculate quartiles (Q1, Q2, Q3) for IQR calculation
--- @param values table Array of numbers (will be sorted)
--- @return number|nil Q1
--- @return number|nil Q2
--- @return number|nil Q3
local function CalculateQuartiles(values)
    if not values or #values == 0 then return nil, nil, nil end

    -- Create sorted copy
    local sorted = {}
    for _, value in ipairs(values) do
        if type(value) == "number" then
            table.insert(sorted, value)
        end
    end
    if #sorted == 0 then return nil, nil, nil end

    table.sort(sorted)

    local n = #sorted
    local q1Idx = floor(n * 0.25) + 1
    local q2Idx = floor(n * 0.5) + 1
    local q3Idx = floor(n * 0.75) + 1

    q1Idx = min(q1Idx, n)
    q2Idx = min(q2Idx, n)
    q3Idx = min(q3Idx, n)

    return sorted[q1Idx], sorted[q2Idx], sorted[q3Idx]
end

-- ============================ ADAPTIVE LEARNING RATE ============================

--- Calculate adaptive learning rate based on observation count and variance
--- @param observationCount number Number of observations
--- @param variance number|nil Variance of observations (optional)
--- @param baseRate number|nil Base learning rate (optional, uses setting)
--- @param decayFactor number|nil Decay factor (optional, uses setting)
--- @return number Learning rate (0.0-1.0)
function AdvancedPredictionEngine:CalculateAdaptiveLearningRate(observationCount, variance, baseRate, decayFactor)
    if not self.db.char.enabled then
        return 0.1 -- Default fallback
    end

    local base = baseRate or self.db.char.learningRateBase
    local decay = decayFactor or self.db.char.learningRateDecayFactor
    local minRate = self.db.char.learningRateMin

    observationCount = observationCount or 0

    -- Base learning rate decreases with observation count
    local rate = base / (1 + decay * observationCount)

    -- Apply variance penalty if provided
    if variance and variance > 0 then
        local variancePenalty = min(variance / 0.5, 1.0) -- Penalize high variance (max at 0.5 variance)
        rate = rate * (1 - variancePenalty * 0.3) -- Reduce rate by up to 30% for high variance
    end

    -- Ensure minimum rate
    rate = max(rate, minRate)

    if self.debug then
        self:Debug("AdaptiveLearningRate: count=%d, variance=%s, rate=%.4f",
            observationCount, variance or "nil", rate)
    end

    return rate
end

--- Apply learning rate to update consolidated data with new observation
--- @param consolidated table Consolidated data structure
--- @param newObservation number|table New observation value
--- @param learningRate number Learning rate to apply
--- @param currentAverage number|nil Current average (optional, will calculate if not provided)
--- @return number Updated average
function AdvancedPredictionEngine:ApplyLearningRate(consolidated, newObservation, learningRate, currentAverage)
    if not consolidated or not newObservation then
        return currentAverage or 0
    end

    -- Handle table-based observations (like runes)
    if type(newObservation) == "table" then
        local updated = {}
        local avg = currentAverage or (consolidated.average or {})

        for key, value in pairs(newObservation) do
            if type(value) == "number" then
                local current = type(avg) == "table" and avg[key] or 0
                updated[key] = current + learningRate * (value - current)
            end
        end
        return updated
    end

    -- Handle number-based observations
    if type(newObservation) == "number" then
        local current = currentAverage or (consolidated.average or 0)
        return current + learningRate * (newObservation - current)
    end

    return currentAverage or 0
end

-- ============================ TEMPORAL WEIGHTING ============================

--- Calculate temporal weights using exponential decay
--- @param observations table Array of observations with timestamp field
--- @param halfLife number|nil Half-life in seconds (optional, uses setting)
--- @return table Array of weights corresponding to observations
function AdvancedPredictionEngine:CalculateTemporalWeights(observations, halfLife)
    if not observations or #observations == 0 then
        return {}
    end

    if not self.db.char.temporalWeightingEnabled then
        -- Return uniform weights if disabled
        local weights = {}
        for i = 1, #observations do
            weights[i] = 1.0
        end
        return weights
    end

    local hl = halfLife or self.db.char.temporalHalfLife
    if hl <= 0 then hl = 3600 end -- Default 1 hour

    local decayRate = log(2) / hl
    local now = GetTime()
    local weights = {}

    for i, obs in ipairs(observations) do
        local timestamp = obs.timestamp or obs.t or 0
        local age = now - timestamp
        if age < 0 then age = 0 end -- Handle future timestamps

        weights[i] = exp(-decayRate * age)
    end

    if self.debug then
        local totalWeight = 0
        for _, w in ipairs(weights) do
            totalWeight = totalWeight + w
        end
        self:Debug("TemporalWeights: %d observations, halfLife=%.1fs, totalWeight=%.2f",
            #observations, hl, totalWeight)
    end

    return weights
end

--- Apply temporal weighting to calculate weighted average
--- @param observations table Array of observations with values
--- @param weights table Array of weights (from CalculateTemporalWeights)
--- @param valueExtractor function|nil Function to extract value from observation (optional)
--- @return number|table Weighted average
function AdvancedPredictionEngine:ApplyTemporalWeighting(observations, weights, valueExtractor)
    if not observations or #observations == 0 then
        return nil
    end

    if not weights or #weights ~= #observations then
        -- Fallback to simple average
        return CalculateMean(observations)
    end

    -- Normalize weights
    local totalWeight = 0
    for _, w in ipairs(weights) do
        totalWeight = totalWeight + w
    end

    if totalWeight == 0 then
        return CalculateMean(observations)
    end

    -- Extract first value to determine type
    local firstValue = observations[1]
    if valueExtractor then
        firstValue = valueExtractor(firstValue)
    end

    -- Handle table-based values (like runes)
    if type(firstValue) == "table" then
        local weighted = {}
        local keyWeights = {}

        for i, obs in ipairs(observations) do
            local value = valueExtractor and valueExtractor(obs) or obs
            local weight = weights[i] / totalWeight

            if type(value) == "table" then
                for key, val in pairs(value) do
                    if type(val) == "number" then
                        weighted[key] = (weighted[key] or 0) + val * weight
                        keyWeights[key] = (keyWeights[key] or 0) + weight
                    end
                end
            end
        end

        -- Normalize by key weights
        for key, total in pairs(weighted) do
            if keyWeights[key] and keyWeights[key] > 0 then
                weighted[key] = total / keyWeights[key]
            end
        end

        return weighted
    end

    -- Handle number-based values
    local weightedSum = 0
    for i, obs in ipairs(observations) do
        local value = valueExtractor and valueExtractor(obs) or obs
        if type(value) == "number" then
            weightedSum = weightedSum + value * (weights[i] / totalWeight)
        end
    end

    return weightedSum
end

-- ============================ ANOMALY DETECTION ============================

--- Detect anomalies using Z-score method
--- @param values table Array of numeric values
--- @param threshold number|nil Z-score threshold (optional, uses setting)
--- @return table Array of indices flagged as anomalies
function AdvancedPredictionEngine:DetectZScoreAnomalies(values, threshold)
    if not values or #values == 0 then
        return {}
    end

    local thresh = threshold or self.db.char.anomalyZScoreThreshold
    local mean = CalculateMean(values)
    local stdDev = CalculateStdDev(values, mean)

    if not mean or not stdDev or stdDev == 0 then
        return {} -- Cannot detect anomalies without variance
    end

    local anomalies = {}
    for i, value in ipairs(values) do
        if type(value) == "number" then
            local zScore = abs((value - mean) / stdDev)
            if zScore > thresh then
                table.insert(anomalies, i)
            end
        end
    end

    if self.debug and #anomalies > 0 then
        self:Debug("ZScoreAnomalies: Found %d anomalies out of %d values (threshold=%.2f)",
            #anomalies, #values, thresh)
    end

    return anomalies
end

--- Detect anomalies using IQR (Interquartile Range) method
--- @param values table Array of numeric values
--- @param multiplier number|nil IQR multiplier (optional, uses setting)
--- @return table Array of indices flagged as anomalies
function AdvancedPredictionEngine:DetectIQRAnomalies(values, multiplier)
    if not values or #values == 0 then
        return {}
    end

    local mult = multiplier or self.db.char.anomalyIQRMultiplier
    local q1, q2, q3 = CalculateQuartiles(values)

    if not q1 or not q3 then
        return {} -- Cannot calculate quartiles
    end

    local iqr = q3 - q1
    local lowerBound = q1 - mult * iqr
    local upperBound = q3 + mult * iqr

    local anomalies = {}
    for i, value in ipairs(values) do
        if type(value) == "number" then
            if value < lowerBound or value > upperBound then
                table.insert(anomalies, i)
            end
        end
    end

    if self.debug and #anomalies > 0 then
        self:Debug("IQRAnomalies: Found %d anomalies out of %d values (Q1=%.2f, Q3=%.2f, IQR=%.2f)",
            #anomalies, #values, q1, q3, iqr)
    end

    return anomalies
end

--- Detect temporal anomalies (sudden changes inconsistent with trend)
--- @param observations table Array of observations with timestamp and value
--- @param window number|nil Window size for trend calculation (optional)
--- @return table Array of indices flagged as anomalies
function AdvancedPredictionEngine:DetectTemporalAnomalies(observations, window)
    if not observations or #observations < 3 then
        return {} -- Need at least 3 observations
    end

    local win = window or 5
    win = min(win, #observations - 1)

    local anomalies = {}
    local values = {}
    for _, obs in ipairs(observations) do
        local value = obs.value or obs
        if type(value) == "number" then
            table.insert(values, value)
        end
    end

    if #values < 3 then
        return {}
    end

    -- Calculate moving average and std dev for each point
    for i = 2, #values - 1 do
        local startIdx = max(1, i - win)
        local endIdx = min(#values, i + win)

        local windowValues = {}
        for j = startIdx, endIdx do
            if j ~= i then -- Exclude current point
                table.insert(windowValues, values[j])
            end
        end

        local windowMean = CalculateMean(windowValues)
        local windowStdDev = CalculateStdDev(windowValues, windowMean)

        if windowMean and windowStdDev and windowStdDev > 0 then
            local zScore = abs((values[i] - windowMean) / windowStdDev)
            if zScore > 2.5 then -- Lower threshold for temporal anomalies
                table.insert(anomalies, i)
            end
        end
    end

    if self.debug and #anomalies > 0 then
        self:Debug("TemporalAnomalies: Found %d anomalies out of %d observations",
            #anomalies, #observations)
    end

    return anomalies
end

--- Filter anomalies from observations using specified methods
--- @param observations table Array of observations
--- @param valueExtractor function|nil Function to extract value from observation
--- @param methods string|table Method(s) to use: "zscore", "iqr", "temporal", or "both"
--- @return table Filtered observations
--- @return table Anomaly indices
function AdvancedPredictionEngine:FilterAnomalies(observations, valueExtractor, methods)
    if not observations or #observations == 0 then
        return observations, {}
    end

    if not self.db.char.anomalyDetectionEnabled then
        return observations, {}
    end

    local method = methods or self.db.char.anomalyDetectionMethod
    if method == "none" then
        return observations, {}
    end

    -- Extract values
    local values = {}
    for i, obs in ipairs(observations) do
        local value = valueExtractor and valueExtractor(obs) or obs
        if type(value) == "number" then
            table.insert(values, value)
        else
            -- For table values, use first numeric value or skip
            if type(value) == "table" then
                for _, v in pairs(value) do
                    if type(v) == "number" then
                        table.insert(values, v)
                        break
                    end
                end
            end
        end
    end

    if #values == 0 then
        return observations, {}
    end

    local anomalyIndices = {}
    local anomalySet = {}

    -- Apply Z-score method
    if method == "zscore" or method == "both" then
        local zAnomalies = self:DetectZScoreAnomalies(values)
        for _, idx in ipairs(zAnomalies) do
            if not anomalySet[idx] then
                table.insert(anomalyIndices, idx)
                anomalySet[idx] = true
            end
        end
    end

    -- Apply IQR method
    if method == "iqr" or method == "both" then
        local iqrAnomalies = self:DetectIQRAnomalies(values)
        for _, idx in ipairs(iqrAnomalies) do
            if not anomalySet[idx] then
                table.insert(anomalyIndices, idx)
                anomalySet[idx] = true
            end
        end
    end

    -- Apply temporal method
    if method == "temporal" then
        local tempAnomalies = self:DetectTemporalAnomalies(observations)
        for _, idx in ipairs(tempAnomalies) do
            if not anomalySet[idx] then
                table.insert(anomalyIndices, idx)
                anomalySet[idx] = true
            end
        end
    end

    -- Filter out anomalies
    if #anomalyIndices > 0 then
        table.sort(anomalyIndices) -- Sort descending for safe removal
        local filtered = {}
        local anomalyIdx = 1
        for i = 1, #observations do
            if anomalyIdx <= #anomalyIndices and i == anomalyIndices[anomalyIdx] then
                anomalyIdx = anomalyIdx + 1
                -- Skip this observation
            else
                table.insert(filtered, observations[i])
            end
        end

        if self.debug then
            self:Debug("FilterAnomalies: Removed %d anomalies, %d remaining",
                #anomalyIndices, #filtered)
        end

        return filtered, anomalyIndices
    end

    return observations, {}
end

-- ============================ CONTEXTUAL CLUSTERING ============================

--- Calculate context hash for grouping similar observations
--- @param context table Context data (combat state, buffs, etc.)
--- @return string Context hash
function AdvancedPredictionEngine:CalculateContextHash(context)
    if not context or type(context) ~= "table" then
        return "default"
    end

    -- Create a simple hash from key context fields
    local parts = {}

    if context.inCombat ~= nil then
        table.insert(parts, "combat:" .. tostring(context.inCombat))
    end

    if context.targetHealthPercent then
        local healthBucket = floor(context.targetHealthPercent / 25) * 25 -- 0-25, 25-50, etc.
        table.insert(parts, "targetHP:" .. healthBucket)
    end

    if context.playerHealthPercent then
        local healthBucket = floor(context.playerHealthPercent / 25) * 25
        table.insert(parts, "playerHP:" .. healthBucket)
    end

    if context.combatState then
        table.insert(parts, "state:" .. tostring(context.combatState))
    end

    -- Hash active buffs (limit to first 5 for performance)
    if context.activeBuffs then
        local buffCount = 0
        for _ in pairs(context.activeBuffs) do
            buffCount = buffCount + 1
        end
        table.insert(parts, "buffs:" .. buffCount)
    end

    if #parts == 0 then
        return "default"
    end

    return table.concat(parts, "|")
end

--- Cluster observations by context
--- @param observations table Array of observations with context field
--- @param contextKeys table|nil Specific context keys to use for clustering
--- @return table Clustered observations {[contextHash] = {observations...}}
function AdvancedPredictionEngine:ClusterByContext(observations, contextKeys)
    if not observations or #observations == 0 then
        return {}
    end

    local clusters = {}

    for _, obs in ipairs(observations) do
        local context = obs.context
        local hash = self:CalculateContextHash(context)

        if not clusters[hash] then
            clusters[hash] = {}
        end
        table.insert(clusters[hash], obs)
    end

    if self.debug then
        local clusterCount = 0
        for _ in pairs(clusters) do
            clusterCount = clusterCount + 1
        end
        self:Debug("ClusterByContext: %d observations clustered into %d contexts",
            #observations, clusterCount)
    end

    return clusters
end

-- ============================ OPTIONS UI ============================

--- Compose options for SpellLearner category
--- @param options table Options structure
--- @param context table Context
--- @return table Modified options
function AdvancedPredictionEngine:spelllearner(options, context)
    if not options.args then options.args = {} end
    if not options.args.advancedEngine then
        options.args.advancedEngine = {
            type = "group",
            name = L["advancedEngine"] or "Advanced Prediction Engine",
            desc = L["advancedEngineDesc"] or "Machine learning-inspired algorithms for prediction enhancement",
            order = 4,
            args = {}
        }
    end

    local args = options.args.advancedEngine.args

    args.enabled = OptionsFactory:CreateToggle(L["enabled"] or "Enabled", L["enabledDesc"] or "Enable or disable this module/feature",
        function() return self:GetSetting("char", "enabled") end,
        function(_, v) self:SetSetting("char", "enabled", v) end,
        { order = 1 }
    )

    args.learningRateHeader = {
        type = "header",
        name = L["learningRateHeader"] or "Adaptive Learning Rate",
        order = 10,
    }

    args.learningRateBase = OptionsFactory:CreateRange(L["learningRateBase"] or "Base Learning Rate", L["learningRateBaseDesc"] or "Initial learning rate for new spells (0.0-1.0)",
        function() return self:GetSetting("char", "learningRateBase") end,
        function(_, v) self:SetSetting("char", "learningRateBase", v) end,
        { order = 11, min = 0.01, max = 1.0, step = 0.01 }
    )

    args.learningRateDecayFactor = OptionsFactory:CreateRange(L["learningRateDecayFactor"] or "Decay Factor", L["learningRateDecayFactorDesc"] or "How quickly learning rate decreases with more observations",
        function() return self:GetSetting("char", "learningRateDecayFactor") end,
        function(_, v) self:SetSetting("char", "learningRateDecayFactor", v) end,
        { order = 12, min = 0.01, max = 0.5, step = 0.01 }
    )

    args.learningRateMin = OptionsFactory:CreateRange(L["learningRateMin"] or "Minimum Learning Rate", L["learningRateMinDesc"] or "Minimum learning rate floor",
        function() return self:GetSetting("char", "learningRateMin") end,
        function(_, v) self:SetSetting("char", "learningRateMin", v) end,
        { order = 13, min = 0.001, max = 0.1, step = 0.001 }
    )

    args.temporalHeader = {
        type = "header",
        name = L["temporalHeader"] or "Temporal Weighting",
        order = 20,
    }

    args.temporalWeightingEnabled = OptionsFactory:CreateToggle(L["temporalWeightingEnabled"] or "Enable Temporal Weighting", L["temporalWeightingEnabledDesc"] or "Weight recent observations more heavily",
        function() return self:GetSetting("char", "temporalWeightingEnabled") end,
        function(_, v) self:SetSetting("char", "temporalWeightingEnabled", v) end,
        { order = 21 }
    )

    args.temporalHalfLife = OptionsFactory:CreateRange(L["temporalHalfLife"] or "Half-Life (seconds)", L["temporalHalfLifeDesc"] or "Time for observation weight to decay to 50%",
        function() return self:GetSetting("char", "temporalHalfLife") end,
        function(_, v) self:SetSetting("char", "temporalHalfLife", v) end,
        { order = 22, min = 60, max = 86400, step = 60 }
    )

    args.anomalyHeader = {
        type = "header",
        name = L["anomalyHeader"] or "Anomaly Detection",
        order = 30,
    }

    args.anomalyDetectionEnabled = OptionsFactory:CreateToggle(L["anomalyDetectionEnabled"] or "Enable Anomaly Detection", L["anomalyDetectionEnabledDesc"] or "Automatically filter out statistical outliers",
        function() return self:GetSetting("char", "anomalyDetectionEnabled") end,
        function(_, v) self:SetSetting("char", "anomalyDetectionEnabled", v) end,
        { order = 31 }
    )

    args.anomalyDetectionMethod = OptionsFactory:CreateSelect(L["anomalyDetectionMethod"] or "Detection Method", L["anomalyDetectionMethodDesc"] or "Method to use for anomaly detection",
        function() return self:GetSetting("char", "anomalyDetectionMethod") end,
        function(_, v) self:SetSetting("char", "anomalyDetectionMethod", v) end,
        {
            order = 32,
            values = {
                zscore = "Z-Score",
                iqr = "IQR",
                both = "Both (Z-Score + IQR)",
                temporal = "Temporal",
                none = "None"
            }
        }
    )

    args.anomalyZScoreThreshold = OptionsFactory:CreateRange(L["anomalyZScoreThreshold"] or "Z-Score Threshold", L["anomalyZScoreThresholdDesc"] or "Standard deviations from mean to flag as anomaly",
        function() return self:GetSetting("char", "anomalyZScoreThreshold") end,
        function(_, v) self:SetSetting("char", "anomalyZScoreThreshold", v) end,
        { order = 33, min = 1.0, max = 5.0, step = 0.1 }
    )

    args.anomalyIQRMultiplier = OptionsFactory:CreateRange(L["anomalyIQRMultiplier"] or "IQR Multiplier", L["anomalyIQRMultiplierDesc"] or "Multiplier for interquartile range anomaly detection",
        function() return self:GetSetting("char", "anomalyIQRMultiplier") end,
        function(_, v) self:SetSetting("char", "anomalyIQRMultiplier", v) end,
        { order = 34, min = 1.0, max = 3.0, step = 0.1 }
    )

    return options
end

