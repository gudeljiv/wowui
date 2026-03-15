--- @module 'NAG.CacheDiagnostics'
--- Comprehensive cache diagnostics and visualization tool for all NAG cache systems
--- Provides TreeGroup GUI and slash commands for cache inspection, testing, and optimization
--- License: CC BY-NC 4.0
--- Authors: Rakizi

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================
local TableUtils = ns.TableUtils
local ASTCache = ns.ASTCache
local TablePool = ns.TablePool

-- Libraries
local AceGUI = ns.AceGUI
local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs
local format = string.format
local pairs = pairs
local ipairs = ipairs
local tostring = tostring
local tinsert = table.insert
local GetTime = _G.GetTime

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- @class CacheDiagnostics : CoreModule
local defaults = {
    global = {
        autoRefresh = true,
        refreshInterval = 1.0,
        showMemoryUsage = true,
        showHitRates = true,
        showDetailedStats = true,
        windowWidth = 800,
        windowHeight = 600
    },
    char = {}
}

local CacheDiagnostics = NAG:CreateModule("CacheDiagnostics", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    debugCategories = { ns.DEBUG_CATEGORIES.DIAGNOSTICS },

    slashCommands = {
        ["cachediag"] = {
            handler = "ShowCacheDiagnosticsGUI",
            help = "Open cache diagnostics GUI",
            root = "nagdebug",
            category = "Data"
        },
        ["cachestats"] = {
            handler = "PrintAllCacheStats",
            help = "Print cache statistics to chat",
            root = "nagdebug",
            category = "Data"
        },
        ["cacheclear"] = {
            handler = "ClearAllCaches",
            help = "Clear all cache systems and reset stats",
            root = "nagdebug",
            category = "Data"
        }
    }
})

if not CacheDiagnostics then return end

-- ============================ MODULE INITIALIZATION ============================

function CacheDiagnostics:ModuleInitialize()
    self.guiFrame = nil
    self.refreshTimer = nil
    self.currentTab = nil
    self.contentFrame = nil
end

function CacheDiagnostics:ModuleEnable()
    self:Info("CacheDiagnostics module enabled - use /nag cachediag to open GUI")
end

function CacheDiagnostics:ModuleDisable()
    self:StopAutoRefresh()
    if self.guiFrame and self.guiFrame.Hide then
        self.guiFrame:Hide()
    end
end

-- ============================ STATISTICS COLLECTION ============================

--- Collect statistics from APL Evaluation Cache
--- @return table Statistics data
function CacheDiagnostics:GetAPLEvaluationStats()
    local APLEvaluationCache = NAG:GetModule("APLEvaluationCache", true)
    if not APLEvaluationCache then
        return {
            available = false,
            error = "Module not found"
        }
    end

    local stats = APLEvaluationCache:GetStats()
    local enabled = APLEvaluationCache:GetSetting("global", "enableCache", false)
    local debugStats = APLEvaluationCache:GetSetting("global", "enableDebugStats", false)
    local maxEntries = APLEvaluationCache:GetSetting("global", "maxCacheEntries", 1000)

    return {
        available = true,
        enabled = enabled,
        debugStats = debugStats,
        maxEntries = maxEntries,
        totalEvaluations = stats.totalEvaluations or 0,
        totalCalls = stats.totalCalls or 0,
        totalCacheHits = stats.totalCacheHits or 0,
        totalHitRate = stats.totalHitRate or 0,
        avgEvaluationTime = stats.avgEvaluationTime or 0,
        lastEvaluationTime = stats.lastEvaluationTime or 0
    }
end

--- Collect statistics from AST Cache
--- @return table Statistics data
function CacheDiagnostics:GetASTCacheStats()
    if not ASTCache then
        return {
            available = false,
            error = "ASTCache not found"
        }
    end

    local stats = ASTCache.GetStatistics()
    return {
        available = true,
        hits = stats.hits or 0,
        misses = stats.misses or 0,
        evictions = stats.evictions or 0,
        totalSize = stats.totalSize or 0,
        maxSize = stats.maxSize or 50,
        hitRate = stats.hitRate or 0
    }
end

--- Collect statistics from API Cache
--- @return table Statistics data
function CacheDiagnostics:GetAPICacheStats()
    if not ns.GetCacheStats then
        return {
            available = false,
            error = "API Cache functions not found"
        }
    end

    local stats = ns.GetCacheStats()
    local sizes = ns.GetCacheSizes()

    return {
        available = true,
        spell = {
            hits = stats.spellHits or 0,
            misses = stats.spellMisses or 0,
            size = sizes.spellCache or 0,
            hitRate = self:CalculateHitRate(stats.spellHits, stats.spellMisses)
        },
        item = {
            hits = stats.itemHits or 0,
            misses = stats.itemMisses or 0,
            size = sizes.itemCache or 0,
            hitRate = self:CalculateHitRate(stats.itemHits, stats.itemMisses)
        },
        action = {
            hits = stats.actionHits or 0,
            misses = stats.actionMisses or 0,
            size = sizes.actionCache or 0,
            hitRate = self:CalculateHitRate(stats.actionHits, stats.actionMisses)
        },
        macro = {
            hits = stats.macroHits or 0,
            misses = stats.macroMisses or 0,
            size = sizes.macroCache or 0,
            hitRate = self:CalculateHitRate(stats.macroHits, stats.macroMisses)
        }
    }
end

--- Collect statistics from Aura Cache
--- @return table Statistics data
function CacheDiagnostics:GetAuraCacheStats()
    if not ns.GetAuraCacheStats then
        return {
            available = false,
            error = "Aura Cache functions not found"
        }
    end

    local stats = ns.GetAuraCacheStats()
    local sizes = ns.GetAuraCacheSizes()

    return {
        available = true,
        hits = stats.hits or 0,
        misses = stats.misses or 0,
        snapshots = stats.snapshots or 0,
        hitRate = self:CalculateHitRate(stats.hits, stats.misses),
        units = sizes or {}
    }
end

--- Get TablePool statistics
--- @return table TablePool statistics
function CacheDiagnostics:GetTablePoolStats()
    if not TablePool then
        return {
            available = false,
            error = "TablePool not found"
        }
    end

    local stats = TablePool:GetStats()
    return {
        available = true,
        totalAcquisitions = stats.totalAcquisitions or 0,
        totalReleases = stats.totalReleases or 0,
        poolHits = stats.poolHits or 0,
        poolMisses = stats.poolMisses or 0,
        hitRate = (stats.hitRate or 0) * 100, -- Convert to percentage
        smallPoolSize = stats.smallSize or 0,
        mediumPoolSize = stats.mediumSize or 0,
        largePoolSize = stats.largeSize or 0,
        -- Calculate leak detection (acquisitions should roughly equal releases)
        leakCount = (stats.totalAcquisitions or 0) - (stats.totalReleases or 0)
    }
end

--- Collect statistics from TTD Calculation Cache
--- @return table Statistics data
function CacheDiagnostics:GetTTDCalculationStats()
    local TTDManager = NAG:GetModule("TTDManager", true)
    if not TTDManager then
        return {
            available = false,
            error = "Module not found"
        }
    end

    -- Count cache entries
    local cacheEntries = 0
    if TTDManager.state and TTDManager.state.calculationCache then
        for _ in pairs(TTDManager.state.calculationCache) do
            cacheEntries = cacheEntries + 1
        end
    end

    -- Count units and samples
    local unitCount = 0
    local totalSamples = 0
    if TTDManager.state and TTDManager.state.units then
        for guid, unitData in pairs(TTDManager.state.units) do
            unitCount = unitCount + 1
            if unitData and unitData.samples then
                totalSamples = totalSamples + #unitData.samples
            end
        end
    end

    local userInterval = (TTDManager.state and TTDManager.state.userInterval) or 0.75

    return {
        available = true,
        cacheEntries = cacheEntries,
        unitCount = unitCount,
        totalSamples = totalSamples,
        avgSamples = unitCount > 0 and (totalSamples / unitCount) or 0,
        userInterval = userInterval
    }
end

--- Collect statistics from Learned Prediction Cache
--- @return table Statistics data
function CacheDiagnostics:GetLearnedPredictionStats()
    local LearnedPredictionProvider = NAG:GetModule("LearnedPredictionProvider", true)
    if not LearnedPredictionProvider then
        return {
            available = false,
            error = "Module not found"
        }
    end

    local stats = LearnedPredictionProvider.cacheStats or {}
    local total = (stats.hits or 0) + (stats.misses or 0)
    local hitRate = total > 0 and ((stats.hits or 0) / total * 100) or 0

    -- Count cached entries
    local cachedCount = 0
    if LearnedPredictionProvider.cache then
        for _, cache in pairs(LearnedPredictionProvider.cache) do
            for _ in pairs(cache) do
                cachedCount = cachedCount + 1
            end
        end
    end

    return {
        available = true,
        enabled = LearnedPredictionProvider.db.char.enableCache or false,
        cacheTTL = LearnedPredictionProvider.db.char.cacheTTL or 5.0,
        hits = stats.hits or 0,
        misses = stats.misses or 0,
        evictions = stats.evictions or 0,
        hitRate = hitRate,
        cachedEntries = cachedCount
    }
end

--- Collect statistics from Tooltip Parser Cache
--- @return table Statistics data
function CacheDiagnostics:GetTooltipParserStats()
    local TooltipParser = NAG:GetModule("TooltipParser", true)
    if not TooltipParser then
        return {
            available = false,
            error = "Module not found"
        }
    end

    local stats = TooltipParser:GetCacheStats()
    local total = (stats.hits or 0) + (stats.misses or 0)
    local hitRate = total > 0 and ((stats.hits or 0) / total * 100) or 0

    return {
        available = true,
        enabled = stats.enabled or false,
        cacheTTL = TooltipParser.db.global.cacheTTL or 300,
        cacheMaxSize = stats.maxSize or 1000,
        size = stats.size or 0,
        hits = stats.hits or 0,
        misses = stats.misses or 0,
        hitRate = hitRate
    }
end

--- Collect statistics from Spellbook Resolution Cache
--- @return table Statistics data
function CacheDiagnostics:GetSpellbookResolutionStats()
    local SpellbookManager = NAG:GetModule("SpellbookManager", true)
    if not SpellbookManager then
        return {
            available = false,
            error = "Module not found"
        }
    end

    local stats = SpellbookManager:GetStats()
    local resolutionCacheEntries = stats.resolutionCacheEntries or 0

    return {
        available = true,
        resolutionCacheEntries = resolutionCacheEntries,
        threshold = 1000, -- From SpellbookManager.lua line 367, 375
        cleanupInterval = 300 -- 5 minutes, from SpellbookManager.lua line 338
    }
end

--- Collect all cache statistics
--- @return table Combined statistics from all caches
function CacheDiagnostics:CollectAllStats()
    return {
        aplEvaluation = self:GetAPLEvaluationStats(),
        ast = self:GetASTCacheStats(),
        api = self:GetAPICacheStats(),
        aura = self:GetAuraCacheStats(),
        ttdCalculation = self:GetTTDCalculationStats(),
        learnedPrediction = self:GetLearnedPredictionStats(),
        tooltipParser = self:GetTooltipParserStats(),
        spellbookResolution = self:GetSpellbookResolutionStats(),
        tablePool = self:GetTablePoolStats()
    }
end

--- Calculate hit rate percentage
--- @param hits number Number of cache hits
--- @param misses number Number of cache misses
--- @return number Hit rate as percentage (0-100)
function CacheDiagnostics:CalculateHitRate(hits, misses)
    hits = hits or 0
    misses = misses or 0
    local total = hits + misses
    if total == 0 then return 0 end
    return (hits / total) * 100
end

--- Get color for hit rate display
--- @param hitRate number Hit rate percentage
--- @return string Color code
function CacheDiagnostics:GetHitRateColor(hitRate)
    if hitRate >= 80 then
        return "|cFF00FF00" -- Green
    elseif hitRate >= 50 then
        return "|cFFFFAA00" -- Yellow
    else
        return "|cFFFF0000" -- Red
    end
end

-- ============================ CACHE MANAGEMENT ============================

--- Clear all caches and reset statistics
function CacheDiagnostics:ClearAllCaches()
    local cleared = {}

    -- APL Evaluation Cache
    local APLEvaluationCache = NAG:GetModule("APLEvaluationCache", true)
    if APLEvaluationCache then
        APLEvaluationCache:ClearCache()
        APLEvaluationCache:ResetStats()
        tinsert(cleared, "APL Evaluation Cache")
    end

    -- AST Cache
    if ASTCache then
        ASTCache.Clear()
        ASTCache.ResetStatistics()
        tinsert(cleared, "AST Cache")
    end

    -- API Cache
    if ns.ClearAPICache and ns.ResetCacheStats then
        ns.ClearAPICache("all")
        ns.ResetCacheStats()
        tinsert(cleared, "API Cache")
    end

    -- Aura Cache
    if ns.ClearAuraCache and ns.ResetAuraCacheStats then
        ns.ClearAuraCache()
        ns.ResetAuraCacheStats()
        tinsert(cleared, "Aura Cache")
    end

    -- TTD Calculation Cache
    local TTDManager = NAG:GetModule("TTDManager", true)
    if TTDManager and TTDManager.ClearCalculationCache then
        TTDManager:ClearCalculationCache()
        tinsert(cleared, "TTD Calculation Cache")
    end

    -- Learned Prediction Cache
    local LearnedPredictionProvider = NAG:GetModule("LearnedPredictionProvider", true)
    if LearnedPredictionProvider and LearnedPredictionProvider.cache then
        -- Clear all prediction type caches
        for _, cache in pairs(LearnedPredictionProvider.cache) do
            wipe(cache)
        end
        -- Reset stats
        if LearnedPredictionProvider.cacheStats then
            LearnedPredictionProvider.cacheStats.hits = 0
            LearnedPredictionProvider.cacheStats.misses = 0
            LearnedPredictionProvider.cacheStats.evictions = 0
        end
        tinsert(cleared, "Learned Prediction Cache")
    end

    -- Tooltip Parser Cache
    local TooltipParser = NAG:GetModule("TooltipParser", true)
    if TooltipParser and TooltipParser.ClearCache then
        TooltipParser:ClearCache()
        tinsert(cleared, "Tooltip Parser Cache")
    end

    -- Spellbook Resolution Cache
    local SpellbookManager = NAG:GetModule("SpellbookManager", true)
    if SpellbookManager and SpellbookManager.ClearCaches then
        SpellbookManager:ClearCaches()
        tinsert(cleared, "Spellbook Resolution Cache")
    end

    if #cleared > 0 then
        self:Print("|cFF00FF00Cleared caches:|r " .. table.concat(cleared, ", "))
    else
        self:Print("|cFFFF0000No caches available to clear|r")
    end
end

--- Estimate memory usage for all caches
--- @return table Memory usage estimates in KB
function CacheDiagnostics:EstimateMemoryUsage()
    local memory = {
        total = 0
    }

    -- AST Cache (rough estimate: 5KB per cached AST)
    local astStats = self:GetASTCacheStats()
    if astStats.available then
        memory.ast = astStats.totalSize * 5 -- KB
        memory.total = memory.total + memory.ast
    end

    -- API Cache (rough estimate: 0.5KB per entry)
    local apiStats = self:GetAPICacheStats()
    if apiStats.available then
        memory.api = (apiStats.spell.size + apiStats.item.size +
                     apiStats.action.size + apiStats.macro.size) * 0.5
        memory.total = memory.total + memory.api
    end

    -- Aura Cache (rough estimate: 1KB per unit snapshot)
    local auraStats = self:GetAuraCacheStats()
    if auraStats.available then
        local unitCount = 0
        for _ in pairs(auraStats.units) do unitCount = unitCount + 1 end
        memory.aura = unitCount * 1
        memory.total = memory.total + memory.aura
    end

    -- TTD Calculation Cache (rough estimate: 0.1KB per entry)
    local ttdStats = self:GetTTDCalculationStats()
    if ttdStats.available then
        memory.ttdCalculation = ttdStats.cacheEntries * 0.1
        memory.total = memory.total + memory.ttdCalculation
    end

    -- Learned Prediction Cache (rough estimate: 0.2KB per entry)
    local predictionStats = self:GetLearnedPredictionStats()
    if predictionStats.available then
        memory.learnedPrediction = predictionStats.cachedEntries * 0.2
        memory.total = memory.total + memory.learnedPrediction
    end

    -- Tooltip Parser Cache (rough estimate: 0.5KB per entry)
    local tooltipStats = self:GetTooltipParserStats()
    if tooltipStats.available then
        memory.tooltipParser = tooltipStats.size * 0.5
        memory.total = memory.total + memory.tooltipParser
    end

    -- Spellbook Resolution Cache (rough estimate: 0.05KB per entry)
    local spellbookStats = self:GetSpellbookResolutionStats()
    if spellbookStats.available then
        memory.spellbookResolution = spellbookStats.resolutionCacheEntries * 0.05
        memory.total = memory.total + memory.spellbookResolution
    end

    return memory
end

--- Check cache health and identify issues
--- @return table Health check results with warnings and suggestions
function CacheDiagnostics:CheckCacheHealth()
    local health = {
        warnings = {},
        suggestions = {},
        overall = "good"
    }

    local stats = self:CollectAllStats()

    -- APL Evaluation Cache checks
    if stats.aplEvaluation.available then
        if not stats.aplEvaluation.enabled then
            tinsert(health.suggestions, "APL Evaluation Cache is disabled - consider enabling for performance gains")
        elseif stats.aplEvaluation.totalCalls > 100 and stats.aplEvaluation.totalHitRate < 50 then
            tinsert(health.warnings, "APL Evaluation Cache has low hit rate (" ..
                   format("%.1f%%", stats.aplEvaluation.totalHitRate) .. ")")
            health.overall = "warning"
        end
    end

    -- AST Cache checks
    if stats.ast.available then
        if stats.ast.evictions > 10 then
            tinsert(health.warnings, "AST Cache has high eviction rate - consider increasing max size")
            health.overall = "warning"
        end
        if stats.ast.totalSize > 0 and stats.ast.hitRate < 50 then
            tinsert(health.warnings, "AST Cache has low hit rate (" ..
                   format("%.1f%%", stats.ast.hitRate) .. ")")
            health.overall = "warning"
        end
    end

    -- API Cache checks
    if stats.api.available then
        local totalCalls = 0
        local totalHits = 0
        for _, cache in pairs({"spell", "item", "action", "macro"}) do
            local cacheStats = stats.api[cache]
            totalCalls = totalCalls + cacheStats.hits + cacheStats.misses
            totalHits = totalHits + cacheStats.hits
        end

        if totalCalls > 100 then
            local overallRate = (totalHits / totalCalls) * 100
            if overallRate < 60 then
                tinsert(health.warnings, "API Cache has low overall hit rate (" ..
                       format("%.1f%%", overallRate) .. ")")
                health.overall = "warning"
            end
        end
    end

    -- TTD Calculation Cache checks
    if stats.ttdCalculation.available then
        if stats.ttdCalculation.cacheEntries > 1000 then
            tinsert(health.warnings, "TTD Calculation Cache has high entry count (" ..
                   tostring(stats.ttdCalculation.cacheEntries) .. ")")
            health.overall = "warning"
        end
    end

    -- Learned Prediction Cache checks
    if stats.learnedPrediction.available then
        if not stats.learnedPrediction.enabled then
            tinsert(health.suggestions, "Learned Prediction Cache is disabled - consider enabling for performance")
        elseif stats.learnedPrediction.cachedEntries > 0 then
            local total = stats.learnedPrediction.hits + stats.learnedPrediction.misses
            if total > 100 and stats.learnedPrediction.hitRate < 50 then
                tinsert(health.warnings, "Learned Prediction Cache has low hit rate (" ..
                       format("%.1f%%", stats.learnedPrediction.hitRate) .. ")")
                health.overall = "warning"
            end
        end
    end

    -- Tooltip Parser Cache checks
    if stats.tooltipParser.available then
        if not stats.tooltipParser.enabled then
            tinsert(health.suggestions, "Tooltip Parser Cache is disabled - consider enabling for performance")
        elseif stats.tooltipParser.size > 0 then
            local total = stats.tooltipParser.hits + stats.tooltipParser.misses
            if total > 100 and stats.tooltipParser.hitRate < 50 then
                tinsert(health.warnings, "Tooltip Parser Cache has low hit rate (" ..
                       format("%.1f%%", stats.tooltipParser.hitRate) .. ")")
                health.overall = "warning"
            end
        end
    end

    -- Spellbook Resolution Cache checks
    if stats.spellbookResolution.available then
        if stats.spellbookResolution.resolutionCacheEntries > 800 then
            tinsert(health.warnings, "Spellbook Resolution Cache approaching threshold (" ..
                   tostring(stats.spellbookResolution.resolutionCacheEntries) .. "/1000)")
            health.overall = "warning"
        end
    end

    if #health.warnings == 0 and #health.suggestions == 0 then
        tinsert(health.suggestions, "All caches operating normally")
    end

    return health
end

-- ============================ GUI IMPLEMENTATION ============================

--- Show the main cache diagnostics GUI
function CacheDiagnostics:ShowCacheDiagnosticsGUI()
    if self.guiFrame then
        -- Focus existing window
        self.guiFrame:Show()
        return
    end

    -- Create main frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("NAG Cache Diagnostics")
    frame:SetStatusText("Cache System Analysis and Management")
    frame:SetLayout("Fill")
    frame:SetWidth(self.db.global.windowWidth)
    frame:SetHeight(self.db.global.windowHeight)

    frame:SetCallback("OnClose", function(widget)
        self:StopAutoRefresh()
        AceGUI:Release(widget)
        self.guiFrame = nil
        self.contentFrame = nil
        self.currentTab = nil
    end)

    self.guiFrame = frame

    -- Create TreeGroup
    local tree = ns.CreateTreeGroup()
    tree:SetLayout("Fill")
    tree:SetTree(self:GetTreeStructure())
    tree:SetCallback("OnGroupSelected", function(widget, event, group)
        self:OnTabSelected(widget, group)
    end)

    frame:AddChild(tree)
    self.treeGroup = tree

    -- Select first tab
    tree:SelectByPath("overview")

    -- Start auto-refresh if enabled
    if self.db.global.autoRefresh then
        self:StartAutoRefresh()
    end
end

--- Get tree structure for TreeGroup
--- @return table Tree structure
function CacheDiagnostics:GetTreeStructure()
    return {
        {
            value = "overview",
            text = "Overview",
            icon = "Interface\\Icons\\INV_Misc_Book_09"
        },
        {
            value = "apl_eval",
            text = "APL Evaluation Cache",
            icon = "Interface\\Icons\\INV_Misc_Note_01",
            children = {
                { value = "apl_eval_stats", text = "Statistics" },
                { value = "apl_eval_config", text = "Configuration" },
                { value = "apl_eval_perf", text = "Performance" }
            }
        },
        {
            value = "ast",
            text = "AST Cache",
            icon = "Interface\\Icons\\INV_Misc_Note_02",
            children = {
                { value = "ast_stats", text = "Statistics" },
                { value = "ast_entries", text = "Entries" },
                { value = "ast_manage", text = "Management" }
            }
        },
        {
            value = "api",
            text = "API Cache",
            icon = "Interface\\Icons\\INV_Misc_Note_03",
            children = {
                { value = "api_spell", text = "Spell Cache" },
                { value = "api_item", text = "Item Cache" },
                { value = "api_action", text = "Action Cache" },
                { value = "api_macro", text = "Macro Cache" }
            }
        },
        {
            value = "aura",
            text = "Aura Cache",
            icon = "Interface\\Icons\\Spell_Holy_MindVision",
            children = {
                { value = "aura_stats", text = "Statistics" },
                { value = "aura_units", text = "Unit Snapshots" },
                { value = "aura_memory", text = "Memory Usage" }
            }
        },
        {
            value = "ttd_calculation",
            text = "TTD Calculation Cache",
            icon = "Interface\\Icons\\INV_Misc_Note_04",
            children = {
                { value = "ttd_stats", text = "Statistics" },
                { value = "ttd_manage", text = "Management" }
            }
        },
        {
            value = "learned_prediction",
            text = "Learned Prediction Cache",
            icon = "Interface\\Icons\\INV_Misc_Note_05",
            children = {
                { value = "prediction_stats", text = "Statistics" },
                { value = "prediction_config", text = "Configuration" }
            }
        },
        {
            value = "tooltip_parser",
            text = "Tooltip Parser Cache",
            icon = "Interface\\Icons\\INV_Misc_Note_06",
            children = {
                { value = "tooltip_stats", text = "Statistics" },
                { value = "tooltip_config", text = "Configuration" }
            }
        },
        {
            value = "spellbook_resolution",
            text = "Spellbook Resolution Cache",
            icon = "Interface\\Icons\\INV_Misc_Book_11",
            children = {
                { value = "spellbook_stats", text = "Statistics" },
                { value = "spellbook_manage", text = "Management" }
            }
        },
        {
            value = "tablepool",
            text = "TablePool",
            icon = "Interface\\Icons\\INV_Misc_Bag_08",
            children = {
                { value = "tablepool_stats", text = "Statistics" },
                { value = "tablepool_pools", text = "Pool Status" }
            }
        }
    }
end

--- Handle tab selection
--- @param widget table TreeGroup widget (the container itself)
--- @param group string Selected group unique value
function CacheDiagnostics:OnTabSelected(widget, group)
    self.currentTab = group

    -- Clear current content
    widget:ReleaseChildren()

    -- Build content for selected tab based on group value
    if group == "overview" then
        self:BuildOverviewTab(widget)
    elseif group == "apl_eval\001apl_eval_stats" then
        self:BuildAPLEvalStatsTab(widget)
    elseif group == "apl_eval\001apl_eval_config" then
        self:BuildAPLEvalConfigTab(widget)
    elseif group == "apl_eval\001apl_eval_perf" then
        self:BuildAPLEvalPerfTab(widget)
    elseif group == "ast\001ast_stats" then
        self:BuildASTStatsTab(widget)
    elseif group == "ast\001ast_entries" then
        self:BuildASTEntriesTab(widget)
    elseif group == "ast\001ast_manage" then
        self:BuildASTManageTab(widget)
    elseif group == "api\001api_spell" then
        self:BuildAPISpellTab(widget)
    elseif group == "api\001api_item" then
        self:BuildAPIItemTab(widget)
    elseif group == "api\001api_action" then
        self:BuildAPIActionTab(widget)
    elseif group == "api\001api_macro" then
        self:BuildAPIMacroTab(widget)
    elseif group == "aura\001aura_stats" then
        self:BuildAuraStatsTab(widget)
    elseif group == "aura\001aura_units" then
        self:BuildAuraUnitsTab(widget)
    elseif group == "aura\001aura_memory" then
        self:BuildAuraMemoryTab(widget)
    elseif group == "ttd_calculation\001ttd_stats" then
        self:BuildTTDStatsTab(widget)
    elseif group == "ttd_calculation\001ttd_manage" then
        self:BuildTTDManageTab(widget)
    elseif group == "learned_prediction\001prediction_stats" then
        self:BuildPredictionStatsTab(widget)
    elseif group == "learned_prediction\001prediction_config" then
        self:BuildPredictionConfigTab(widget)
    elseif group == "tooltip_parser\001tooltip_stats" then
        self:BuildTooltipStatsTab(widget)
    elseif group == "tooltip_parser\001tooltip_config" then
        self:BuildTooltipConfigTab(widget)
    elseif group == "spellbook_resolution\001spellbook_stats" then
        self:BuildSpellbookStatsTab(widget)
    elseif group == "spellbook_resolution\001spellbook_manage" then
        self:BuildSpellbookManageTab(widget)
    elseif group == "tablepool\001tablepool_stats" then
        self:BuildTablePoolStatsTab(widget)
    elseif group == "tablepool\001tablepool_pools" then
        self:BuildTablePoolPoolsTab(widget)
    end
end

-- ============================ TAB BUILDERS ============================

--- Build Overview tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildOverviewTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    -- Title
    local title = AceGUI:Create("Heading")
    title:SetText("Cache Systems Overview")
    title:SetFullWidth(true)
    scroll:AddChild(title)

    -- Collect all stats
    local stats = self:CollectAllStats()
    local memory = self:EstimateMemoryUsage()
    local health = self:CheckCacheHealth()

    -- Health Status
    local healthLabel = AceGUI:Create("Label")
    local healthColor = health.overall == "good" and "|cFF00FF00" or "|cFFFFAA00"
    healthLabel:SetText(format("%sOverall Status: %s|r", healthColor, health.overall:upper()))
    healthLabel:SetFullWidth(true)
    healthLabel:SetFontObject(GameFontNormalLarge)
    scroll:AddChild(healthLabel)

    -- Warnings
    if #health.warnings > 0 then
        local warningHeader = AceGUI:Create("Heading")
        warningHeader:SetText("Warnings")
        warningHeader:SetFullWidth(true)
        scroll:AddChild(warningHeader)

        for _, warning in ipairs(health.warnings) do
            local warningLabel = AceGUI:Create("Label")
            warningLabel:SetText("|cFFFF0000• " .. warning .. "|r")
            warningLabel:SetFullWidth(true)
            scroll:AddChild(warningLabel)
        end
    end

    -- Suggestions
    if #health.suggestions > 0 then
        local suggestionHeader = AceGUI:Create("Heading")
        suggestionHeader:SetText("Suggestions")
        suggestionHeader:SetFullWidth(true)
        scroll:AddChild(suggestionHeader)

        for _, suggestion in ipairs(health.suggestions) do
            local suggestionLabel = AceGUI:Create("Label")
            suggestionLabel:SetText("|cFF00FFFF• " .. suggestion .. "|r")
            suggestionLabel:SetFullWidth(true)
            scroll:AddChild(suggestionLabel)
        end
    end

    -- Summary Statistics
    local summaryHeader = AceGUI:Create("Heading")
    summaryHeader:SetText("Cache Summary")
    summaryHeader:SetFullWidth(true)
    scroll:AddChild(summaryHeader)

    -- APL Evaluation Cache Summary
    if stats.aplEvaluation.available then
        local aplLabel = AceGUI:Create("Label")
        local statusColor = stats.aplEvaluation.enabled and "|cFF00FF00" or "|cFFAAAAAA"
        local hitRateColor = self:GetHitRateColor(stats.aplEvaluation.totalHitRate)
        aplLabel:SetText(format(
            "%sAPL Evaluation Cache:|r %s%s|r | Hit Rate: %s%.1f%%|r | Calls: %d",
            "|cFFFFFF00",
            statusColor,
            stats.aplEvaluation.enabled and "ENABLED" or "DISABLED",
            hitRateColor,
            stats.aplEvaluation.totalHitRate,
            stats.aplEvaluation.totalCalls
        ))
        aplLabel:SetFullWidth(true)
        scroll:AddChild(aplLabel)
    end

    -- AST Cache Summary
    if stats.ast.available then
        local astLabel = AceGUI:Create("Label")
        local hitRateColor = self:GetHitRateColor(stats.ast.hitRate)
        astLabel:SetText(format(
            "%sAST Cache:|r Size: %d/%d | Hit Rate: %s%.1f%%|r | Evictions: %d",
            "|cFFFFFF00",
            stats.ast.totalSize,
            stats.ast.maxSize,
            hitRateColor,
            stats.ast.hitRate,
            stats.ast.evictions
        ))
        astLabel:SetFullWidth(true)
        scroll:AddChild(astLabel)
    end

    -- API Cache Summary
    if stats.api.available then
        local totalSize = stats.api.spell.size + stats.api.item.size +
                         stats.api.action.size + stats.api.macro.size
        local totalHits = stats.api.spell.hits + stats.api.item.hits +
                         stats.api.action.hits + stats.api.macro.hits
        local totalMisses = stats.api.spell.misses + stats.api.item.misses +
                           stats.api.action.misses + stats.api.macro.misses
        local totalHitRate = self:CalculateHitRate(totalHits, totalMisses)
        local hitRateColor = self:GetHitRateColor(totalHitRate)

        local apiLabel = AceGUI:Create("Label")
        apiLabel:SetText(format(
            "%sAPI Cache:|r Total Entries: %d | Hit Rate: %s%.1f%%|r | Hits: %d | Misses: %d",
            "|cFFFFFF00",
            totalSize,
            hitRateColor,
            totalHitRate,
            totalHits,
            totalMisses
        ))
        apiLabel:SetFullWidth(true)
        scroll:AddChild(apiLabel)
    end

    -- Aura Cache Summary
    if stats.aura.available then
        local auraLabel = AceGUI:Create("Label")
        local hitRateColor = self:GetHitRateColor(stats.aura.hitRate)
        auraLabel:SetText(format(
            "%sAura Cache:|r Hit Rate: %s%.1f%%|r | Snapshots: %d | Hits: %d | Misses: %d",
            "|cFFFFFF00",
            hitRateColor,
            stats.aura.hitRate,
            stats.aura.snapshots,
            stats.aura.hits,
            stats.aura.misses
        ))
        auraLabel:SetFullWidth(true)
        scroll:AddChild(auraLabel)
    end

    -- TTD Calculation Cache Summary
    if stats.ttdCalculation.available then
        local ttdLabel = AceGUI:Create("Label")
        ttdLabel:SetText(format(
            "%sTTD Calculation Cache:|r Entries: %d | Units: %d | Samples: %d | Interval: %.2fs",
            "|cFFFFFF00",
            stats.ttdCalculation.cacheEntries,
            stats.ttdCalculation.unitCount,
            stats.ttdCalculation.totalSamples,
            stats.ttdCalculation.userInterval
        ))
        ttdLabel:SetFullWidth(true)
        scroll:AddChild(ttdLabel)
    end

    -- Learned Prediction Cache Summary
    if stats.learnedPrediction.available then
        local predLabel = AceGUI:Create("Label")
        local statusColor = stats.learnedPrediction.enabled and "|cFF00FF00" or "|cFFAAAAAA"
        local hitRateColor = self:GetHitRateColor(stats.learnedPrediction.hitRate)
        predLabel:SetText(format(
            "%sLearned Prediction Cache:|r %s%s|r | Hit Rate: %s%.1f%%|r | Entries: %d | TTL: %.1fs",
            "|cFFFFFF00",
            statusColor,
            stats.learnedPrediction.enabled and "ENABLED" or "DISABLED",
            hitRateColor,
            stats.learnedPrediction.hitRate,
            stats.learnedPrediction.cachedEntries,
            stats.learnedPrediction.cacheTTL
        ))
        predLabel:SetFullWidth(true)
        scroll:AddChild(predLabel)
    end

    -- Tooltip Parser Cache Summary
    if stats.tooltipParser.available then
        local tooltipLabel = AceGUI:Create("Label")
        local statusColor = stats.tooltipParser.enabled and "|cFF00FF00" or "|cFFAAAAAA"
        local hitRateColor = self:GetHitRateColor(stats.tooltipParser.hitRate)
        tooltipLabel:SetText(format(
            "%sTooltip Parser Cache:|r %s%s|r | Hit Rate: %s%.1f%%|r | Size: %d/%d | TTL: %ds",
            "|cFFFFFF00",
            statusColor,
            stats.tooltipParser.enabled and "ENABLED" or "DISABLED",
            hitRateColor,
            stats.tooltipParser.hitRate,
            stats.tooltipParser.size,
            stats.tooltipParser.cacheMaxSize,
            stats.tooltipParser.cacheTTL
        ))
        tooltipLabel:SetFullWidth(true)
        scroll:AddChild(tooltipLabel)
    end

    -- Spellbook Resolution Cache Summary
    if stats.spellbookResolution.available then
        local spellbookLabel = AceGUI:Create("Label")
        local thresholdColor = stats.spellbookResolution.resolutionCacheEntries > 800 and "|cFFFFAA00" or "|cFF00FF00"
        spellbookLabel:SetText(format(
            "%sSpellbook Resolution Cache:|r Entries: %s%d|r/%d | Cleanup: %ds",
            "|cFFFFFF00",
            thresholdColor,
            stats.spellbookResolution.resolutionCacheEntries,
            stats.spellbookResolution.threshold,
            stats.spellbookResolution.cleanupInterval
        ))
        spellbookLabel:SetFullWidth(true)
        scroll:AddChild(spellbookLabel)
    end

    -- Memory Usage
    local memoryHeader = AceGUI:Create("Heading")
    memoryHeader:SetText("Estimated Memory Usage")
    memoryHeader:SetFullWidth(true)
    scroll:AddChild(memoryHeader)

    local memoryLabel = AceGUI:Create("Label")
    memoryLabel:SetText(format(
        "Total: %.1f KB | AST: %.1f KB | API: %.1f KB | Aura: %.1f KB | TTD: %.1f KB | Prediction: %.1f KB | Tooltip: %.1f KB | Spellbook: %.1f KB",
        memory.total,
        memory.ast or 0,
        memory.api or 0,
        memory.aura or 0,
        memory.ttdCalculation or 0,
        memory.learnedPrediction or 0,
        memory.tooltipParser or 0,
        memory.spellbookResolution or 0
    ))
    memoryLabel:SetFullWidth(true)
    scroll:AddChild(memoryLabel)

    -- Action Buttons
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    scroll:AddChild(buttonGroup)

    local clearButton = AceGUI:Create("Button")
    clearButton:SetText("Clear All Caches")
    clearButton:SetWidth(150)
    clearButton:SetCallback("OnClick", function()
        self:ClearAllCaches()
        self:RefreshCurrentTab()
    end)
    buttonGroup:AddChild(clearButton)

    local refreshButton = AceGUI:Create("Button")
    refreshButton:SetText("Refresh")
    refreshButton:SetWidth(100)
    refreshButton:SetCallback("OnClick", function()
        self:RefreshCurrentTab()
    end)
    buttonGroup:AddChild(refreshButton)
end

--- Build APL Evaluation Cache Statistics tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildAPLEvalStatsTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetAPLEvaluationStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    -- Status
    local statusLabel = AceGUI:Create("Label")
    local statusColor = stats.enabled and "|cFF00FF00" or "|cFFAAAAAA"
    statusLabel:SetText(format("%sCache Status: %s|r", statusColor, stats.enabled and "ENABLED" or "DISABLED"))
    statusLabel:SetFullWidth(true)
    statusLabel:SetFontObject(GameFontNormalLarge)
    scroll:AddChild(statusLabel)

    -- Statistics
    local statsHeader = AceGUI:Create("Heading")
    statsHeader:SetText("Statistics")
    statsHeader:SetFullWidth(true)
    scroll:AddChild(statsHeader)

    self:AddStatLabel(scroll, "Total Evaluations", tostring(stats.totalEvaluations))
    self:AddStatLabel(scroll, "Total Calls", tostring(stats.totalCalls))
    self:AddStatLabel(scroll, "Total Cache Hits", tostring(stats.totalCacheHits))

    local hitRateColor = self:GetHitRateColor(stats.totalHitRate)
    self:AddStatLabel(scroll, "Hit Rate", format("%s%.2f%%|r", hitRateColor, stats.totalHitRate))

    self:AddStatLabel(scroll, "Avg Evaluation Time", format("%.4f seconds", stats.avgEvaluationTime))
    self:AddStatLabel(scroll, "Last Evaluation Time", format("%.4f seconds", stats.lastEvaluationTime))

    -- Configuration
    local configHeader = AceGUI:Create("Heading")
    configHeader:SetText("Configuration")
    configHeader:SetFullWidth(true)
    scroll:AddChild(configHeader)

    self:AddStatLabel(scroll, "Debug Stats", stats.debugStats and "Enabled" or "Disabled")
    self:AddStatLabel(scroll, "Max Cache Entries", tostring(stats.maxEntries))
end

--- Build APL Evaluation Cache Configuration tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildAPLEvalConfigTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local APLEvaluationCache = NAG:GetModule("APLEvaluationCache", true)
    if not APLEvaluationCache then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: APLEvaluationCache module not found|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("APL Evaluation Cache Settings")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    -- Enable Cache
    local enableCheck = AceGUI:Create("CheckBox")
    enableCheck:SetLabel("Enable Cache")
    enableCheck:SetValue(APLEvaluationCache:GetSetting("global", "enableCache", false))
    enableCheck:SetCallback("OnValueChanged", function(widget, event, value)
        APLEvaluationCache:SetSetting("global", "enableCache", value)
        self:Print(format("APL Evaluation Cache %s", value and "enabled" or "disabled"))
    end)
    enableCheck:SetFullWidth(true)
    scroll:AddChild(enableCheck)

    -- Enable Debug Stats
    local debugCheck = AceGUI:Create("CheckBox")
    debugCheck:SetLabel("Enable Debug Statistics")
    debugCheck:SetValue(APLEvaluationCache:GetSetting("global", "enableDebugStats", false))
    debugCheck:SetCallback("OnValueChanged", function(widget, event, value)
        APLEvaluationCache:SetSetting("global", "enableDebugStats", value)
    end)
    debugCheck:SetFullWidth(true)
    scroll:AddChild(debugCheck)

    -- Track Performance
    local perfCheck = AceGUI:Create("CheckBox")
    perfCheck:SetLabel("Track Performance")
    perfCheck:SetValue(APLEvaluationCache:GetSetting("global", "trackPerformance", false))
    perfCheck:SetCallback("OnValueChanged", function(widget, event, value)
        APLEvaluationCache:SetSetting("global", "trackPerformance", value)
    end)
    perfCheck:SetFullWidth(true)
    scroll:AddChild(perfCheck)

    -- Actions
    local actionsHeader = AceGUI:Create("Heading")
    actionsHeader:SetText("Actions")
    actionsHeader:SetFullWidth(true)
    scroll:AddChild(actionsHeader)

    local clearButton = AceGUI:Create("Button")
    clearButton:SetText("Clear Cache")
    clearButton:SetWidth(150)
    clearButton:SetCallback("OnClick", function()
        APLEvaluationCache:ClearCache()
        self:Print("APL Evaluation Cache cleared")
        self:RefreshCurrentTab()
    end)
    scroll:AddChild(clearButton)

    local resetButton = AceGUI:Create("Button")
    resetButton:SetText("Reset Statistics")
    resetButton:SetWidth(150)
    resetButton:SetCallback("OnClick", function()
        APLEvaluationCache:ResetStats()
        self:Print("APL Evaluation Cache statistics reset")
        self:RefreshCurrentTab()
    end)
    scroll:AddChild(resetButton)
end

--- Build APL Evaluation Cache Performance tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildAPLEvalPerfTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetAPLEvaluationStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Performance Metrics")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    -- Performance Summary
    local perfLabel = AceGUI:Create("Label")
    local perfText = format(
        "Average Evaluation Time: %.4f seconds\n" ..
        "Last Evaluation Time: %.4f seconds\n" ..
        "Total Evaluations: %d\n" ..
        "Total Calls: %d\n" ..
        "Calls per Evaluation: %.2f",
        stats.avgEvaluationTime,
        stats.lastEvaluationTime,
        stats.totalEvaluations,
        stats.totalCalls,
        stats.totalEvaluations > 0 and (stats.totalCalls / stats.totalEvaluations) or 0
    )
    perfLabel:SetText(perfText)
    perfLabel:SetFullWidth(true)
    scroll:AddChild(perfLabel)

    -- Cache Effectiveness
    local effectHeader = AceGUI:Create("Heading")
    effectHeader:SetText("Cache Effectiveness")
    effectHeader:SetFullWidth(true)
    scroll:AddChild(effectHeader)

    local effectLabel = AceGUI:Create("Label")
    local hitRateColor = self:GetHitRateColor(stats.totalHitRate)
    local effectText = format(
        "Hit Rate: %s%.2f%%|r\n" ..
        "Total Hits: %d\n" ..
        "Total Misses: %d\n" ..
        "Estimated Time Saved: %.4f seconds",
        hitRateColor,
        stats.totalHitRate,
        stats.totalCacheHits,
        stats.totalCalls - stats.totalCacheHits,
        stats.totalCacheHits * 0.0001 -- Rough estimate of time saved per hit
    )
    effectLabel:SetText(effectText)
    effectLabel:SetFullWidth(true)
    scroll:AddChild(effectLabel)
end

--- Build AST Cache Statistics tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildASTStatsTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetASTCacheStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("AST Cache Statistics")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    self:AddStatLabel(scroll, "Current Size", format("%d / %d", stats.totalSize, stats.maxSize))
    self:AddStatLabel(scroll, "Cache Hits", tostring(stats.hits))
    self:AddStatLabel(scroll, "Cache Misses", tostring(stats.misses))

    local hitRateColor = self:GetHitRateColor(stats.hitRate)
    self:AddStatLabel(scroll, "Hit Rate", format("%s%.2f%%|r", hitRateColor, stats.hitRate))

    self:AddStatLabel(scroll, "Evictions", tostring(stats.evictions))

    -- Efficiency Analysis
    local analysisHeader = AceGUI:Create("Heading")
    analysisHeader:SetText("Efficiency Analysis")
    analysisHeader:SetFullWidth(true)
    scroll:AddChild(analysisHeader)

    local utilization = stats.maxSize > 0 and (stats.totalSize / stats.maxSize * 100) or 0
    local utilizationColor = utilization > 80 and "|cFFFFAA00" or "|cFF00FF00"

    local analysisLabel = AceGUI:Create("Label")
    analysisLabel:SetText(format(
        "Cache Utilization: %s%.1f%%|r\n" ..
        "Eviction Rate: %.2f%%\n" ..
        "Total Requests: %d",
        utilizationColor,
        utilization,
        (stats.hits + stats.misses) > 0 and (stats.evictions / (stats.hits + stats.misses) * 100) or 0,
        stats.hits + stats.misses
    ))
    analysisLabel:SetFullWidth(true)
    scroll:AddChild(analysisLabel)
end

--- Build AST Cache Entries tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildASTEntriesTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    if not ASTCache then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: ASTCache not found|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Cached AST Entries")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    local entries = ASTCache.GetAllEntries()
    local entryCount = 0
    for _ in pairs(entries) do entryCount = entryCount + 1 end

    if entryCount == 0 then
        local emptyLabel = AceGUI:Create("Label")
        emptyLabel:SetText("No entries in cache")
        emptyLabel:SetFullWidth(true)
        scroll:AddChild(emptyLabel)
        return
    end

    -- Sort entries by hits
    local sortedEntries = {}
    for key, entry in pairs(entries) do
        tinsert(sortedEntries, {key = key, data = entry})
    end
    table.sort(sortedEntries, function(a, b) return a.data.hits > b.data.hits end)

    -- Display entries
    for i, entry in ipairs(sortedEntries) do
        local entryLabel = AceGUI:Create("Label")
        entryLabel:SetText(format(
            "%d. Hash: %s | Hits: %d | String Length: %d",
            i,
            entry.key,
            entry.data.hits,
            entry.data.rotationStringLength
        ))
        entryLabel:SetFullWidth(true)
        scroll:AddChild(entryLabel)
    end
end

--- Build AST Cache Management tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildASTManageTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    if not ASTCache then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: ASTCache not found|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Cache Management")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    -- Current Settings
    local stats = self:GetASTCacheStats()
    local settingsLabel = AceGUI:Create("Label")
    settingsLabel:SetText(format(
        "Current Max Size: %d entries\n" ..
        "Current Size: %d entries\n" ..
        "Memory Usage (est): %.1f KB",
        stats.maxSize,
        stats.totalSize,
        stats.totalSize * 5
    ))
    settingsLabel:SetFullWidth(true)
    scroll:AddChild(settingsLabel)

    -- Actions
    local actionsHeader = AceGUI:Create("Heading")
    actionsHeader:SetText("Actions")
    actionsHeader:SetFullWidth(true)
    scroll:AddChild(actionsHeader)

    local clearButton = AceGUI:Create("Button")
    clearButton:SetText("Clear Cache")
    clearButton:SetWidth(150)
    clearButton:SetCallback("OnClick", function()
        ASTCache.Clear()
        self:Print("AST Cache cleared")
        self:RefreshCurrentTab()
    end)
    scroll:AddChild(clearButton)

    local resetStatsButton = AceGUI:Create("Button")
    resetStatsButton:SetText("Reset Statistics")
    resetStatsButton:SetWidth(150)
    resetStatsButton:SetCallback("OnClick", function()
        ASTCache.ResetStatistics()
        self:Print("AST Cache statistics reset")
        self:RefreshCurrentTab()
    end)
    scroll:AddChild(resetStatsButton)
end

--- Build API Cache Spell tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildAPISpellTab(container)
    self:BuildAPICacheTypeTab(container, "spell", "Spell Cache")
end

--- Build API Cache Item tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildAPIItemTab(container)
    self:BuildAPICacheTypeTab(container, "item", "Item Cache")
end

--- Build API Cache Action tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildAPIActionTab(container)
    self:BuildAPICacheTypeTab(container, "action", "Action Cache")
end

--- Build API Cache Macro tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildAPIMacroTab(container)
    self:BuildAPICacheTypeTab(container, "macro", "Macro Cache")
end

--- Build generic API cache type tab
--- @param container table AceGUI container
--- @param cacheType string Cache type (spell, item, action, macro)
--- @param title string Tab title
function CacheDiagnostics:BuildAPICacheTypeTab(container, cacheType, title)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetAPICacheStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local cacheStats = stats[cacheType]
    if not cacheStats then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: Cache type not found|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText(title .. " Statistics")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    self:AddStatLabel(scroll, "Cache Size", tostring(cacheStats.size))
    self:AddStatLabel(scroll, "Cache Hits", tostring(cacheStats.hits))
    self:AddStatLabel(scroll, "Cache Misses", tostring(cacheStats.misses))

    local hitRateColor = self:GetHitRateColor(cacheStats.hitRate)
    self:AddStatLabel(scroll, "Hit Rate", format("%s%.2f%%|r", hitRateColor, cacheStats.hitRate))

    -- Additional info
    local infoHeader = AceGUI:Create("Heading")
    infoHeader:SetText("Cache Information")
    infoHeader:SetFullWidth(true)
    scroll:AddChild(infoHeader)

    local totalRequests = cacheStats.hits + cacheStats.misses
    local infoLabel = AceGUI:Create("Label")
    local infoText = format(
        "Total Requests: %d\n" ..
        "Memory Usage (est): %.1f KB\n" ..
        "Permanent Storage: %s",
        totalRequests,
        cacheStats.size * 0.5,
        (cacheType == "spell" or cacheType == "item") and "Yes" or "No (TTL-based)"
    )
    infoLabel:SetText(infoText)
    infoLabel:SetFullWidth(true)
    scroll:AddChild(infoLabel)

    -- Actions
    local actionsHeader = AceGUI:Create("Heading")
    actionsHeader:SetText("Actions")
    actionsHeader:SetFullWidth(true)
    scroll:AddChild(actionsHeader)

    local clearButton = AceGUI:Create("Button")
    clearButton:SetText("Clear " .. title)
    clearButton:SetWidth(150)
    clearButton:SetCallback("OnClick", function()
        if ns.ClearAPICache then
            ns.ClearAPICache(cacheType)
            self:Print(title .. " cleared")
            self:RefreshCurrentTab()
        end
    end)
    scroll:AddChild(clearButton)
end

--- Build Aura Cache Statistics tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildAuraStatsTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetAuraCacheStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Aura Cache Statistics")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    self:AddStatLabel(scroll, "Cache Hits", tostring(stats.hits))
    self:AddStatLabel(scroll, "Cache Misses", tostring(stats.misses))
    self:AddStatLabel(scroll, "Snapshots", tostring(stats.snapshots))

    local hitRateColor = self:GetHitRateColor(stats.hitRate)
    self:AddStatLabel(scroll, "Hit Rate", format("%s%.2f%%|r", hitRateColor, stats.hitRate))

    -- Cache Info
    local infoHeader = AceGUI:Create("Heading")
    infoHeader:SetText("Cache Configuration")
    infoHeader:SetFullWidth(true)
    scroll:AddChild(infoHeader)

    local infoLabel = AceGUI:Create("Label")
    infoLabel:SetText("Cache TTL: 50ms (0.05 seconds)\nOptimized for high-frequency aura checks")
    infoLabel:SetFullWidth(true)
    scroll:AddChild(infoLabel)
end

--- Build Aura Cache Unit Snapshots tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildAuraUnitsTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetAuraCacheStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Unit Aura Snapshots")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    -- Display unit snapshots
    for unit, counts in pairs(stats.units) do
        local unitLabel = AceGUI:Create("Label")
        unitLabel:SetText(format(
            "%s: %d buffs, %d debuffs",
            unit:upper(),
            counts.buffs or 0,
            counts.debuffs or 0
        ))
        unitLabel:SetFullWidth(true)
        scroll:AddChild(unitLabel)
    end
end

--- Build Aura Cache Memory Usage tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildAuraMemoryTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetAuraCacheStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Memory Usage Analysis")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    -- Calculate total snapshots
    local totalBuffs = 0
    local totalDebuffs = 0
    for unit, counts in pairs(stats.units) do
        totalBuffs = totalBuffs + (counts.buffs or 0)
        totalDebuffs = totalDebuffs + (counts.debuffs or 0)
    end

    local memoryLabel = AceGUI:Create("Label")
    memoryLabel:SetText(format(
        "Total Cached Buffs: %d\n" ..
        "Total Cached Debuffs: %d\n" ..
        "Estimated Memory: %.1f KB\n" ..
        "Units Tracked: %d",
        totalBuffs,
        totalDebuffs,
        (totalBuffs + totalDebuffs) * 0.5,
        TableUtils.Size(stats.units)
    ))
    memoryLabel:SetFullWidth(true)
    scroll:AddChild(memoryLabel)

    -- Actions
    local actionsHeader = AceGUI:Create("Heading")
    actionsHeader:SetText("Actions")
    actionsHeader:SetFullWidth(true)
    scroll:AddChild(actionsHeader)

    local clearButton = AceGUI:Create("Button")
    clearButton:SetText("Clear Aura Cache")
    clearButton:SetWidth(150)
    clearButton:SetCallback("OnClick", function()
        if ns.ClearAuraCache then
            ns.ClearAuraCache()
            self:Print("Aura Cache cleared")
            self:RefreshCurrentTab()
        end
    end)
    scroll:AddChild(clearButton)

    local resetButton = AceGUI:Create("Button")
    resetButton:SetText("Reset Statistics")
    resetButton:SetWidth(150)
    resetButton:SetCallback("OnClick", function()
        if ns.ResetAuraCacheStats then
            ns.ResetAuraCacheStats()
            self:Print("Aura Cache statistics reset")
            self:RefreshCurrentTab()
        end
    end)
    scroll:AddChild(resetButton)
end

--- Build TablePool Statistics tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildTablePoolStatsTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    -- Title
    local title = AceGUI:Create("Heading")
    title:SetText("TablePool Statistics")
    title:SetFullWidth(true)
    scroll:AddChild(title)

    local stats = self:GetTablePoolStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000TablePool not available: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    -- Hit Rate
    local hitRateColor = self:GetHitRateColor(stats.hitRate)
    self:AddStatLabel(scroll, "Hit Rate", format("%s%.2f%%|r", hitRateColor, stats.hitRate))

    -- Acquisition/Release Stats
    self:AddStatLabel(scroll, "Total Acquisitions", tostring(stats.totalAcquisitions))
    self:AddStatLabel(scroll, "Total Releases", tostring(stats.totalReleases))
    self:AddStatLabel(scroll, "Pool Hits", tostring(stats.poolHits))
    self:AddStatLabel(scroll, "Pool Misses", tostring(stats.poolMisses))

    -- Leak Detection
    local leakColor = stats.leakCount > 100 and "|cFFFF0000" or "|cFF00FF00"
    self:AddStatLabel(scroll, "Potential Leaks", format("%s%d|r (acquisitions - releases)", leakColor, stats.leakCount))

    -- Pool Sizes
    local poolSizeHeader = AceGUI:Create("Heading")
    poolSizeHeader:SetText("Pool Sizes")
    poolSizeHeader:SetFullWidth(true)
    scroll:AddChild(poolSizeHeader)

    self:AddStatLabel(scroll, "Small Pool", tostring(stats.smallPoolSize))
    self:AddStatLabel(scroll, "Medium Pool", tostring(stats.mediumPoolSize))
    self:AddStatLabel(scroll, "Large Pool", tostring(stats.largePoolSize))

    -- Clear button
    local clearButton = AceGUI:Create("Button")
    clearButton:SetText("Clear TablePool")
    clearButton:SetWidth(150)
    clearButton:SetCallback("OnClick", function()
        if TablePool and TablePool.Clear then
            TablePool:Clear()
            self:Print("TablePool cleared and statistics reset")
            self:RefreshCurrentTab()
        end
    end)
    scroll:AddChild(clearButton)
end

--- Build TablePool Pools Status tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildTablePoolPoolsTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    -- Title
    local title = AceGUI:Create("Heading")
    title:SetText("TablePool Pool Status")
    title:SetFullWidth(true)
    scroll:AddChild(title)

    local stats = self:GetTablePoolStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000TablePool not available|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    -- Pool efficiency analysis
    local efficiencyHeader = AceGUI:Create("Heading")
    efficiencyHeader:SetText("Pool Efficiency")
    efficiencyHeader:SetFullWidth(true)
    scroll:AddChild(efficiencyHeader)

    local totalPooled = stats.smallPoolSize + stats.mediumPoolSize + stats.largePoolSize
    local efficiency = stats.totalAcquisitions > 0 and (stats.poolHits / stats.totalAcquisitions * 100) or 0

    self:AddStatLabel(scroll, "Total Tables Pooled", tostring(totalPooled))
    self:AddStatLabel(scroll, "Pool Efficiency", format("%.2f%% (hits/acquisitions)", efficiency))

    -- Usage recommendations
    local recHeader = AceGUI:Create("Heading")
    recHeader:SetText("Recommendations")
    recHeader:SetFullWidth(true)
    scroll:AddChild(recHeader)

    local recommendations = {}
    if stats.leakCount > 100 then
        tinsert(recommendations, "|cFFFF0000High leak count detected - check for missing Release() calls|r")
    end
    if stats.hitRate < 50 and stats.totalAcquisitions > 100 then
        tinsert(recommendations, "|cFFFFAA00Low hit rate - pool may need warmup or size adjustment|r")
    end
    if stats.hitRate > 80 then
        tinsert(recommendations, "|cFF00FF00Good hit rate - pool is working efficiently|r")
    end
    if totalPooled > 500 then
        tinsert(recommendations, "|cFFFFAA00Large pool size - consider if all tables are needed|r")
    end

    if #recommendations == 0 then
        tinsert(recommendations, "|cFF00FF00No issues detected - pool operating normally|r")
    end

    for _, rec in ipairs(recommendations) do
        local recLabel = AceGUI:Create("Label")
        recLabel:SetText("• " .. rec)
        recLabel:SetFullWidth(true)
        scroll:AddChild(recLabel)
    end
end

--- Build TTD Calculation Cache Statistics tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildTTDStatsTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetTTDCalculationStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("TTD Calculation Cache Statistics")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    self:AddStatLabel(scroll, "Cache Entries", tostring(stats.cacheEntries))
    self:AddStatLabel(scroll, "Tracked Units", tostring(stats.unitCount))
    self:AddStatLabel(scroll, "Total Samples", tostring(stats.totalSamples))
    self:AddStatLabel(scroll, "Average Samples per Unit", format("%.1f", stats.avgSamples))
    self:AddStatLabel(scroll, "User Interval", format("%.2f seconds", stats.userInterval))

    -- Cache Info
    local infoHeader = AceGUI:Create("Heading")
    infoHeader:SetText("Cache Information")
    infoHeader:SetFullWidth(true)
    scroll:AddChild(infoHeader)

    local infoLabel = AceGUI:Create("Label")
    infoLabel:SetText("Dynamic TTL based on user interval\nCache entries cleaned up after 3× interval\nGUID-based invalidation on unit removal")
    infoLabel:SetFullWidth(true)
    scroll:AddChild(infoLabel)
end

--- Build TTD Calculation Cache Management tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildTTDManageTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local TTDManager = NAG:GetModule("TTDManager", true)
    if not TTDManager then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: TTDManager module not found|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("TTD Calculation Cache Management")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    local stats = self:GetTTDCalculationStats()
    local settingsLabel = AceGUI:Create("Label")
    settingsLabel:SetText(format(
        "Current Cache Entries: %d\n" ..
        "Tracked Units: %d\n" ..
        "User Interval: %.2f seconds\n" ..
        "Cleanup Age: %.2f seconds (3× interval)",
        stats.cacheEntries,
        stats.unitCount,
        stats.userInterval,
        stats.userInterval * 3
    ))
    settingsLabel:SetFullWidth(true)
    scroll:AddChild(settingsLabel)

    -- Actions
    local actionsHeader = AceGUI:Create("Heading")
    actionsHeader:SetText("Actions")
    actionsHeader:SetFullWidth(true)
    scroll:AddChild(actionsHeader)

    local clearButton = AceGUI:Create("Button")
    clearButton:SetText("Clear Cache")
    clearButton:SetWidth(150)
    clearButton:SetCallback("OnClick", function()
        TTDManager:ClearCalculationCache()
        self:Print("TTD Calculation Cache cleared")
        self:RefreshCurrentTab()
    end)
    scroll:AddChild(clearButton)

    local cleanupButton = AceGUI:Create("Button")
    cleanupButton:SetText("Run Cleanup")
    cleanupButton:SetWidth(150)
    cleanupButton:SetCallback("OnClick", function()
        TTDManager:CleanupCache()
        self:Print("TTD Calculation Cache cleanup completed")
        self:RefreshCurrentTab()
    end)
    scroll:AddChild(cleanupButton)
end

--- Build Learned Prediction Cache Statistics tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildPredictionStatsTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetLearnedPredictionStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Learned Prediction Cache Statistics")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    -- Status
    local statusLabel = AceGUI:Create("Label")
    local statusColor = stats.enabled and "|cFF00FF00" or "|cFFAAAAAA"
    statusLabel:SetText(format("%sCache Status: %s|r", statusColor, stats.enabled and "ENABLED" or "DISABLED"))
    statusLabel:SetFullWidth(true)
    statusLabel:SetFontObject(GameFontNormalLarge)
    scroll:AddChild(statusLabel)

    -- Statistics
    local statsHeader = AceGUI:Create("Heading")
    statsHeader:SetText("Statistics")
    statsHeader:SetFullWidth(true)
    scroll:AddChild(statsHeader)

    self:AddStatLabel(scroll, "Cache Hits", tostring(stats.hits))
    self:AddStatLabel(scroll, "Cache Misses", tostring(stats.misses))
    self:AddStatLabel(scroll, "Cache Evictions", tostring(stats.evictions))
    self:AddStatLabel(scroll, "Cached Entries", tostring(stats.cachedEntries))

    local hitRateColor = self:GetHitRateColor(stats.hitRate)
    self:AddStatLabel(scroll, "Hit Rate", format("%s%.2f%%|r", hitRateColor, stats.hitRate))

    -- Configuration
    local configHeader = AceGUI:Create("Heading")
    configHeader:SetText("Configuration")
    configHeader:SetFullWidth(true)
    scroll:AddChild(configHeader)

    self:AddStatLabel(scroll, "Cache TTL", format("%.1f seconds", stats.cacheTTL))
end

--- Build Learned Prediction Cache Configuration tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildPredictionConfigTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local LearnedPredictionProvider = NAG:GetModule("LearnedPredictionProvider", true)
    if not LearnedPredictionProvider then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: LearnedPredictionProvider module not found|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Learned Prediction Cache Settings")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    -- Enable Cache
    local enableCheck = AceGUI:Create("CheckBox")
    enableCheck:SetLabel("Enable Cache")
    enableCheck:SetValue(LearnedPredictionProvider.db.char.enableCache or false)
    enableCheck:SetCallback("OnValueChanged", function(widget, event, value)
        LearnedPredictionProvider.db.char.enableCache = value
        self:Print(format("Learned Prediction Cache %s", value and "enabled" or "disabled"))
    end)
    enableCheck:SetFullWidth(true)
    scroll:AddChild(enableCheck)

    -- Actions
    local actionsHeader = AceGUI:Create("Heading")
    actionsHeader:SetText("Actions")
    actionsHeader:SetFullWidth(true)
    scroll:AddChild(actionsHeader)

    local clearButton = AceGUI:Create("Button")
    clearButton:SetText("Clear Cache")
    clearButton:SetWidth(150)
    clearButton:SetCallback("OnClick", function()
        if LearnedPredictionProvider.cache then
            for _, cache in pairs(LearnedPredictionProvider.cache) do
                wipe(cache)
            end
            if LearnedPredictionProvider.cacheStats then
                LearnedPredictionProvider.cacheStats.hits = 0
                LearnedPredictionProvider.cacheStats.misses = 0
                LearnedPredictionProvider.cacheStats.evictions = 0
            end
            self:Print("Learned Prediction Cache cleared")
            self:RefreshCurrentTab()
        end
    end)
    scroll:AddChild(clearButton)
end

--- Build Tooltip Parser Cache Statistics tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildTooltipStatsTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetTooltipParserStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Tooltip Parser Cache Statistics")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    -- Status
    local statusLabel = AceGUI:Create("Label")
    local statusColor = stats.enabled and "|cFF00FF00" or "|cFFAAAAAA"
    statusLabel:SetText(format("%sCache Status: %s|r", statusColor, stats.enabled and "ENABLED" or "DISABLED"))
    statusLabel:SetFullWidth(true)
    statusLabel:SetFontObject(GameFontNormalLarge)
    scroll:AddChild(statusLabel)

    -- Statistics
    local statsHeader = AceGUI:Create("Heading")
    statsHeader:SetText("Statistics")
    statsHeader:SetFullWidth(true)
    scroll:AddChild(statsHeader)

    self:AddStatLabel(scroll, "Cache Size", format("%d / %d", stats.size, stats.cacheMaxSize))
    self:AddStatLabel(scroll, "Cache Hits", tostring(stats.hits))
    self:AddStatLabel(scroll, "Cache Misses", tostring(stats.misses))

    local hitRateColor = self:GetHitRateColor(stats.hitRate)
    self:AddStatLabel(scroll, "Hit Rate", format("%s%.2f%%|r", hitRateColor, stats.hitRate))

    -- Configuration
    local configHeader = AceGUI:Create("Heading")
    configHeader:SetText("Configuration")
    configHeader:SetFullWidth(true)
    scroll:AddChild(configHeader)

    self:AddStatLabel(scroll, "Cache TTL", format("%d seconds", stats.cacheTTL))
    self:AddStatLabel(scroll, "Max Cache Size", tostring(stats.cacheMaxSize))
end

--- Build Tooltip Parser Cache Configuration tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildTooltipConfigTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local TooltipParser = NAG:GetModule("TooltipParser", true)
    if not TooltipParser then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: TooltipParser module not found|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Tooltip Parser Cache Settings")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    -- Enable Cache
    local enableCheck = AceGUI:Create("CheckBox")
    enableCheck:SetLabel("Enable Cache")
    enableCheck:SetValue(TooltipParser.db.global.cacheEnabled or false)
    enableCheck:SetCallback("OnValueChanged", function(widget, event, value)
        TooltipParser.db.global.cacheEnabled = value
        self:Print(format("Tooltip Parser Cache %s", value and "enabled" or "disabled"))
    end)
    enableCheck:SetFullWidth(true)
    scroll:AddChild(enableCheck)

    -- Actions
    local actionsHeader = AceGUI:Create("Heading")
    actionsHeader:SetText("Actions")
    actionsHeader:SetFullWidth(true)
    scroll:AddChild(actionsHeader)

    local clearButton = AceGUI:Create("Button")
    clearButton:SetText("Clear Cache")
    clearButton:SetWidth(150)
    clearButton:SetCallback("OnClick", function()
        TooltipParser:ClearCache()
        self:Print("Tooltip Parser Cache cleared")
        self:RefreshCurrentTab()
    end)
    scroll:AddChild(clearButton)
end

--- Build Spellbook Resolution Cache Statistics tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildSpellbookStatsTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local stats = self:GetSpellbookResolutionStats()

    if not stats.available then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. (stats.error or "Unknown error") .. "|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Spellbook Resolution Cache Statistics")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    local thresholdColor = stats.resolutionCacheEntries > 800 and "|cFFFFAA00" or "|cFF00FF00"
    self:AddStatLabel(scroll, "Cache Entries", format("%s%d|r / %d", thresholdColor, stats.resolutionCacheEntries, stats.threshold))
    self:AddStatLabel(scroll, "Cleanup Threshold", tostring(stats.threshold))
    self:AddStatLabel(scroll, "Cleanup Interval", format("%d seconds (%.1f minutes)", stats.cleanupInterval, stats.cleanupInterval / 60))

    -- Cache Info
    local infoHeader = AceGUI:Create("Heading")
    infoHeader:SetText("Cache Information")
    infoHeader:SetFullWidth(true)
    scroll:AddChild(infoHeader)

    local infoLabel = AceGUI:Create("Label")
    infoLabel:SetText("Memory pressure cleanup: full wipe if entries > 1000\nPeriodic cleanup runs every 5 minutes\nNo TTL-based expiration")
    infoLabel:SetFullWidth(true)
    scroll:AddChild(infoLabel)
end

--- Build Spellbook Resolution Cache Management tab
--- @param container table AceGUI container
function CacheDiagnostics:BuildSpellbookManageTab(container)
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local SpellbookManager = NAG:GetModule("SpellbookManager", true)
    if not SpellbookManager then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: SpellbookManager module not found|r")
        errorLabel:SetFullWidth(true)
        scroll:AddChild(errorLabel)
        return
    end

    local heading = AceGUI:Create("Heading")
    heading:SetText("Spellbook Resolution Cache Management")
    heading:SetFullWidth(true)
    scroll:AddChild(heading)

    local stats = self:GetSpellbookResolutionStats()
    local settingsLabel = AceGUI:Create("Label")
    settingsLabel:SetText(format(
        "Current Cache Entries: %d\n" ..
        "Cleanup Threshold: %d\n" ..
        "Cleanup Interval: %d seconds",
        stats.resolutionCacheEntries,
        stats.threshold,
        stats.cleanupInterval
    ))
    settingsLabel:SetFullWidth(true)
    scroll:AddChild(settingsLabel)

    -- Actions
    local actionsHeader = AceGUI:Create("Heading")
    actionsHeader:SetText("Actions")
    actionsHeader:SetFullWidth(true)
    scroll:AddChild(actionsHeader)

    local clearButton = AceGUI:Create("Button")
    clearButton:SetText("Clear Cache")
    clearButton:SetWidth(150)
    clearButton:SetCallback("OnClick", function()
        SpellbookManager:ClearCaches()
        self:Print("Spellbook Resolution Cache cleared")
        self:RefreshCurrentTab()
    end)
    scroll:AddChild(clearButton)

    local invalidateButton = AceGUI:Create("Button")
    invalidateButton:SetText("Invalidate Cache")
    invalidateButton:SetWidth(150)
    invalidateButton:SetCallback("OnClick", function()
        SpellbookManager:InvalidateCache()
        self:Print("Spellbook cache invalidated")
        self:RefreshCurrentTab()
    end)
    scroll:AddChild(invalidateButton)
end

-- ============================ HELPER METHODS ============================

--- Add a statistic label to a container
--- @param container table AceGUI container
--- @param label string Label text
--- @param value string Value text
function CacheDiagnostics:AddStatLabel(container, label, value)
    local statLabel = AceGUI:Create("Label")
    statLabel:SetText(format("|cFFFFFF00%s:|r %s", label, value))
    statLabel:SetFullWidth(true)
    container:AddChild(statLabel)
end

--- Refresh the current tab
function CacheDiagnostics:RefreshCurrentTab()
    if not self.currentTab or not self.treeGroup then return end
    -- Re-trigger the selection callback
    self:OnTabSelected(self.treeGroup, self.currentTab)
end

--- Start auto-refresh timer
function CacheDiagnostics:StartAutoRefresh()
    if self.refreshTimer then
        self:StopAutoRefresh()
    end

    self.refreshTimer = C_Timer.NewTicker(self.db.global.refreshInterval, function()
        if self.guiFrame and self.currentTab then
            self:RefreshCurrentTab()
        else
            self:StopAutoRefresh()
        end
    end)
end

--- Stop auto-refresh timer
function CacheDiagnostics:StopAutoRefresh()
    if self.refreshTimer then
        self.refreshTimer:Cancel()
        self.refreshTimer = nil
    end
end

-- ============================ SLASH COMMAND HANDLERS ============================

--- Print all cache statistics to chat
function CacheDiagnostics:PrintAllCacheStats()
    self:Print("|cFF00FF00=== NAG Cache Statistics ===|r")

    local stats = self:CollectAllStats()

    -- APL Evaluation Cache
    if stats.aplEvaluation.available then
        self:Print("|cFFFFFF00APL Evaluation Cache:|r")
        self:Print(format("  Status: %s", stats.aplEvaluation.enabled and "ENABLED" or "DISABLED"))
        self:Print(format("  Hit Rate: %.2f%%", stats.aplEvaluation.totalHitRate))
        self:Print(format("  Calls: %d | Hits: %d", stats.aplEvaluation.totalCalls, stats.aplEvaluation.totalCacheHits))
    end

    -- AST Cache
    if stats.ast.available then
        self:Print("|cFFFFFF00AST Cache:|r")
        self:Print(format("  Size: %d/%d", stats.ast.totalSize, stats.ast.maxSize))
        self:Print(format("  Hit Rate: %.2f%%", stats.ast.hitRate))
        self:Print(format("  Hits: %d | Misses: %d | Evictions: %d", stats.ast.hits, stats.ast.misses, stats.ast.evictions))
    end

    -- API Cache
    if stats.api.available then
        self:Print("|cFFFFFF00API Cache:|r")
        for _, cacheType in ipairs({"spell", "item", "action", "macro"}) do
            local cache = stats.api[cacheType]
            self:Print(format("  %s: Size=%d, Hit Rate=%.2f%%",
                cacheType:upper(), cache.size, cache.hitRate))
        end
    end

    -- Aura Cache
    if stats.aura.available then
        self:Print("|cFFFFFF00Aura Cache:|r")
        self:Print(format("  Hit Rate: %.2f%%", stats.aura.hitRate))
        self:Print(format("  Hits: %d | Misses: %d | Snapshots: %d",
            stats.aura.hits, stats.aura.misses, stats.aura.snapshots))
    end

    -- TTD Calculation Cache
    if stats.ttdCalculation.available then
        self:Print("|cFFFFFF00TTD Calculation Cache:|r")
        self:Print(format("  Cache Entries: %d | Units: %d | Samples: %d | Interval: %.2fs",
            stats.ttdCalculation.cacheEntries,
            stats.ttdCalculation.unitCount,
            stats.ttdCalculation.totalSamples,
            stats.ttdCalculation.userInterval))
    end

    -- Learned Prediction Cache
    if stats.learnedPrediction.available then
        self:Print("|cFFFFFF00Learned Prediction Cache:|r")
        self:Print(format("  Status: %s | TTL: %.1fs",
            stats.learnedPrediction.enabled and "ENABLED" or "DISABLED",
            stats.learnedPrediction.cacheTTL))
        self:Print(format("  Hit Rate: %.2f%% | Entries: %d",
            stats.learnedPrediction.hitRate,
            stats.learnedPrediction.cachedEntries))
        self:Print(format("  Hits: %d | Misses: %d | Evictions: %d",
            stats.learnedPrediction.hits,
            stats.learnedPrediction.misses,
            stats.learnedPrediction.evictions))
    end

    -- Tooltip Parser Cache
    if stats.tooltipParser.available then
        self:Print("|cFFFFFF00Tooltip Parser Cache:|r")
        self:Print(format("  Status: %s | TTL: %ds | Max Size: %d",
            stats.tooltipParser.enabled and "ENABLED" or "DISABLED",
            stats.tooltipParser.cacheTTL,
            stats.tooltipParser.cacheMaxSize))
        self:Print(format("  Hit Rate: %.2f%% | Size: %d",
            stats.tooltipParser.hitRate,
            stats.tooltipParser.size))
        self:Print(format("  Hits: %d | Misses: %d",
            stats.tooltipParser.hits,
            stats.tooltipParser.misses))
    end

    -- Spellbook Resolution Cache
    if stats.spellbookResolution.available then
        self:Print("|cFFFFFF00Spellbook Resolution Cache:|r")
        self:Print(format("  Entries: %d/%d | Cleanup Interval: %ds",
            stats.spellbookResolution.resolutionCacheEntries,
            stats.spellbookResolution.threshold,
            stats.spellbookResolution.cleanupInterval))
    end

    -- TablePool
    if stats.tablePool.available then
        self:Print("|cFFFFFF00TablePool:|r")
        self:Print(format("  Hit Rate: %.2f%%", stats.tablePool.hitRate))
        self:Print(format("  Acquisitions: %d | Releases: %d | Leak: %d",
            stats.tablePool.totalAcquisitions, stats.tablePool.totalReleases, stats.tablePool.leakCount))
        self:Print(format("  Pool Sizes - Small: %d | Medium: %d | Large: %d",
            stats.tablePool.smallPoolSize, stats.tablePool.mediumPoolSize, stats.tablePool.largePoolSize))
    end

    self:Print("|cFF00FF00========================|r")
end

return CacheDiagnostics

