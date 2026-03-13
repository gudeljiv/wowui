--- @module "NAG.LeaderboardViewAdapter"
--- Service-facing adapter for leaderboard viewer data selection and filtering.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas

-- ============================ LOCALIZE ============================

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ DEFAULTS ============================

local defaults = {
    char = {},
}

-- ============================ MODULE ============================

local LeaderboardViewAdapter = NAG:CreateModule("LeaderboardViewAdapter", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    databaseRoot = "leaderboard",
    optionsCategory = ns.MODULE_CATEGORIES.LEADERBOARD,
    debugCategories = { ns.DEBUG_CATEGORIES.FEATURES },
})

ns.LeaderboardViewAdapter = LeaderboardViewAdapter

-- ============================ HELPERS ============================

function LeaderboardViewAdapter:GetLeaderboardService()
    if not self._leaderboardService then
        self._leaderboardService = NAG:GetModule("LeaderboardService", true)
    end
    return self._leaderboardService
end

function LeaderboardViewAdapter:GetMetricSchema(metricId, service)
    local leaderboardService = service or self:GetLeaderboardService()
    if not leaderboardService then
        return nil
    end
    if type(leaderboardService.GetMetricSchema) == "function" then
        return leaderboardService:GetMetricSchema(metricId)
    end
    if type(leaderboardService.GetMetricProvider) ~= "function" then
        return nil
    end
    local provider = leaderboardService:GetMetricProvider(metricId)
    return type(provider) == "table" and provider.schema or nil
end

--- Apply schema-driven eventType filtering for a metric.
--- When the metric has no provider (e.g. class-specific metric viewed on another class), pass through all records so synced data is displayed.
--- @param metricId string
--- @param records table
--- @param service table|nil
--- @return table
function LeaderboardViewAdapter:FilterRecordsByMetricType(metricId, records, service)
    local schema = self:GetMetricSchema(metricId, service)
    if not schema then
        return records or {}
    end
    local leaderboardService = service or self:GetLeaderboardService()
    if leaderboardService and type(leaderboardService.FilterRecordsByMetricType) == "function" then
        return leaderboardService:FilterRecordsByMetricType(metricId, records or {})
    end
    return records or {}
end

--- Resolve rows for leaderboard viewer state.
--- @param metricId string
--- @param viewMode string
--- @param scopeFilter string
--- @param classFilter string
--- @param limit number
--- @param currentIdentity table|nil
--- @return table
function LeaderboardViewAdapter:GetRows(metricId, viewMode, scopeFilter, classFilter, limit, currentIdentity)
    local service = self:GetLeaderboardService()
    if not service or type(metricId) ~= "string" or metricId == "" then
        return {}
    end
    if type(service.GetDisplayRows) == "function" then
        return service:GetDisplayRows(metricId, viewMode, scopeFilter, classFilter, limit, currentIdentity) or {}
    end
    local mode = tostring(viewMode or "local")
    local scope = tostring(scopeFilter or "all"):lower()
    if mode == "merged" and type(service.GetCombinedTopX) == "function" then
        return self:FilterRecordsByMetricType(metricId, service:GetCombinedTopX(metricId, limit, scope, classFilter) or {}, service)
    end
    return self:FilterRecordsByMetricType(metricId, service:GetTop(metricId, limit, false, scope, classFilter) or {}, service)
end

return LeaderboardViewAdapter
