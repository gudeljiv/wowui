--- @module "NAG.CacheRefreshManager"
--- Centralized cache refresh/work queue manager for combat stability.
---
--- WoW Lua is single-threaded: this module does not do true parallelism.
--- Instead it provides:
--- - Deduped refresh requests by cache key
--- - Per-key non-overlap locks (no refresh computed on top of another)
--- - Budgeted execution across frames (prevents sync spikes)
--- - Optional sliced/chunked jobs (compute across multiple frames)
--- - Stable jitter for periodic refreshes (reduces phase alignment)
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
--- Discord: https://discord.gg/ebonhold
---
--- @class CacheRefreshManager : CoreModule

-- ============================ LOCALIZE ============================

local _, ns = ...

local GetTime = _G.GetTime
local UnitAffectingCombat = _G.UnitAffectingCombat
local CreateFrame = _G.CreateFrame
local debugprofilestop = _G.debugprofilestop
local geterrorhandler = _G.geterrorhandler
local IsMounted = _G.IsMounted
local IsFlying = _G.IsFlying

local type = type
local tostring = tostring
local pairs = pairs
local next = next
local select = select
local xpcall = xpcall
local format = string.format

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ CONSTANTS ============================

local MIN_INTERVAL_SEC = 0.01

local PRIORITY = {
    CRITICAL_ROTATION = 1,
    COMBAT_HIGH = 2,
    COMBAT_NORMAL = 3,
    COMBAT_LOW = 4,
}

local PRIORITY_NAMES = {
    [PRIORITY.CRITICAL_ROTATION] = "CRITICAL_ROTATION",
    [PRIORITY.COMBAT_HIGH] = "COMBAT_HIGH",
    [PRIORITY.COMBAT_NORMAL] = "COMBAT_NORMAL",
    [PRIORITY.COMBAT_LOW] = "COMBAT_LOW",
}

-- ============================ QUEUE (O(1) HEAD/TAIL) ============================

local function QueueNew()
    return { items = {}, head = 1, tail = 0 }
end

local function QueueIsEmpty(q)
    return q.head > q.tail
end

local function QueueEnqueue(q, v)
    q.tail = q.tail + 1
    q.items[q.tail] = v
end

local function QueueDequeue(q)
    if q.head > q.tail then
        return nil
    end
    local v = q.items[q.head]
    q.items[q.head] = nil
    q.head = q.head + 1
    if q.head > q.tail then
        q.head = 1
        q.tail = 0
    end
    return v
end

-- ============================ HELPERS ============================

local function QueueCount(q)
    if not q then
        return 0
    end
    if q.head > q.tail then
        return 0
    end
    return (q.tail - q.head + 1)
end

local function ClampInterval(interval)
    if not interval or type(interval) ~= "number" then
        return MIN_INTERVAL_SEC
    end
    if interval < MIN_INTERVAL_SEC then
        return MIN_INTERVAL_SEC
    end
    return interval
end

local function HashStringToUnit(key)
    -- Simple deterministic hash → [0,1). Stable across sessions; not cryptographic.
    local h = 0
    local s = tostring(key or "")
    for i = 1, #s do
        h = (h * 33 + s:byte(i)) % 2147483647
    end
    return (h % 10000) / 10000
end

local function StableJitterSec(cacheKey, amplitudeSec)
    if not amplitudeSec or amplitudeSec <= 0 then
        return 0
    end
    return HashStringToUnit(cacheKey) * amplitudeSec
end

local function NowMs()
    if debugprofilestop then
        return debugprofilestop()
    end
    local t = GetTime and GetTime() or 0
    return t * 1000
end

-- ============================ MODULE ============================

local defaults = {
    global = {
        enabled = true,

        -- Execution budgets (per frame)
        budgetMsCombat = 6,
        budgetMsOutOfCombat = 4,

        -- Safety caps
        maxJobsPerTick = 25,
        maxJobsPerTickOutOfCombat = 10,
        framePollIntervalSec = 0.016,
        framePollIntervalIdleSec = 0.05,

        -- Jitter defaults (fraction of minIntervalSec)
        jitterFraction = 0.25,

        -- Error logging throttle per key
        errorLogCooldownSec = 2.0,

        -- Mutex safety: allow stealing stale locks
        mutexStealAfterSec = 2.0,
        mutexStealWarnCooldownSec = 2.0,
    },
}

local CacheRefreshManager = NAG:CreateModule("CacheRefreshManager", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    hidden = function() return not NAG:IsDevModeEnabled() end,
    debugCategories = { ns.DEBUG_CATEGORIES.SERVICES, ns.DEBUG_CATEGORIES.MANAGERS },

    slashCommands = {
        ["cache_queue"] = {
            handler = "PrintQueueStatus",
            help = "Print CacheRefreshManager queue status. Usage: /nagdebug cache queue",
            root = "nagdebug",
            path = { "cache", "queue" },
            category = "Debug",
        },
    },

    defaultState = {
        cache = {},      -- cacheKey -> { value=any, updatedAt=number, meta=table|nil }
        entries = {},    -- cacheKey -> entry
    },
})

local module = CacheRefreshManager
ns.CacheRefreshManager = CacheRefreshManager

-- ============================ LIFECYCLE ============================

function CacheRefreshManager:ModuleInitialize()
    self._frame = nil
    self._queues = {
        [PRIORITY.CRITICAL_ROTATION] = QueueNew(),
        [PRIORITY.COMBAT_HIGH] = QueueNew(),
        [PRIORITY.COMBAT_NORMAL] = QueueNew(),
        [PRIORITY.COMBAT_LOW] = QueueNew(),
    }
    self._queuedKeys = {} -- cacheKey -> true when in any queue
    self._locks = {}      -- cacheKey -> true when inProgress
    self._mutexLocks = {} -- lockKey -> true for external mutex usage
    self._mutexStealWarnAt = {} -- lockKey -> GetTime() last warn
    self._lastErrorLogAt = {} -- cacheKey -> GetTime()
    self._delayed = {} -- cacheKey -> { at=number, pr=number }
    self._perf = {
        onUpdateCalls = 0,
        idleOnUpdateCalls = 0,
        jobsProcessed = 0,
        maxLoopMs = 0,
        lastLoopMs = 0,
        queuedPeak = 0,
    }
end

function CacheRefreshManager:ModuleEnable()
    self:Start()
end

function CacheRefreshManager:ModuleDisable()
    self:Stop()
    if self._queuedKeys then
        wipe(self._queuedKeys)
    end
    if self._locks then
        wipe(self._locks)
    end
    if self._mutexLocks then
        wipe(self._mutexLocks)
    end
    if self._mutexStealWarnAt then
        wipe(self._mutexStealWarnAt)
    end
    if self._delayed then
        wipe(self._delayed)
    end

    -- Reset queues to empty without reallocating the backing tables
    if self._queues then
        for _, q in pairs(self._queues) do
            if q then
                wipe(q.items)
                q.head = 1
                q.tail = 0
            end
        end
    end
end

-- ============================ INTERNAL ENGINE ============================

function CacheRefreshManager:Start()
    if self._frame then
        self:UpdateFrameActivity()
        return
    end
    self._frame = CreateFrame("Frame")
    self._frame:Hide()
    self._frame:SetScript("OnUpdate", function(_, elapsed)
        self:OnUpdate(elapsed)
    end)
    self:UpdateFrameActivity()
end

function CacheRefreshManager:Stop()
    if not self._frame then
        return
    end
    self._frame:SetScript("OnUpdate", nil)
    self._frame:Hide()
    self._frame = nil
end

function CacheRefreshManager:GetBudgetMs()
    local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
    if inCombat then
        return self.db.global.budgetMsCombat or 6
    end
    return self.db.global.budgetMsOutOfCombat or 12
end

function CacheRefreshManager:GetFramePollIntervalSec()
    local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
    if inCombat then
        return (self.db and self.db.global and self.db.global.framePollIntervalSec) or 0.016
    end
    local isTraveling = (IsMounted and IsMounted()) or (IsFlying and IsFlying()) or false
    if isTraveling then
        return (self.db and self.db.global and self.db.global.framePollIntervalIdleSec) or 0.05
    end
    return (self.db and self.db.global and self.db.global.framePollIntervalSec) or 0.016
end

function CacheRefreshManager:ShouldRun()
    if not (self.db and self.db.global and self.db.global.enabled) then
        return false
    end
    return true
end

function CacheRefreshManager:HasPendingWork()
    return (self._queuedKeys and next(self._queuedKeys) ~= nil)
        or (self._delayed and next(self._delayed) ~= nil)
end

function CacheRefreshManager:UpdateFrameActivity()
    if not self._frame then
        return
    end
    if self:ShouldRun() and self:HasPendingWork() then
        self._frame:Show()
    else
        self._frame:Hide()
    end
end

function CacheRefreshManager:LogKeyError(cacheKey, err)
    local cooldown = self.db.global.errorLogCooldownSec or 2.0
    local now = GetTime()
    local last = self._lastErrorLogAt[cacheKey] or 0
    if (now - last) < cooldown then
        return
    end
    self._lastErrorLogAt[cacheKey] = now
    self:Error("CacheRefreshManager job error [%s]: %s", tostring(cacheKey), tostring(err))
end

function CacheRefreshManager:SafeCall(cacheKey, fn, ...)
    local handler = geterrorhandler and geterrorhandler() or function(e) return e end
    local ok, r1, r2, r3 = xpcall(fn, handler, ...)
    if not ok then
        self:LogKeyError(cacheKey, r1)
        return false, r1
    end
    return true, r1, r2, r3
end

function CacheRefreshManager:GetEntry(cacheKey)
    local e = self.state.entries[cacheKey]
    if e then
        return e
    end
    e = {
        cacheKey = cacheKey,
        queued = false,
        inProgress = false,
        pending = false,
        priority = PRIORITY.COMBAT_NORMAL,
        minIntervalSec = 0,
        lastStartAt = 0,
        lastFinishAt = 0,
        nextEligibleAt = 0,
        computeFn = nil,
        computeState = nil,
        sliced = false,
        sliceBudgetMs = nil,
        lastError = nil,
        runCount = 0,
    }
    self.state.entries[cacheKey] = e
    return e
end

function CacheRefreshManager:Enqueue(cacheKey, priority)
    if self._queuedKeys[cacheKey] then
        return
    end
    local pr = priority or PRIORITY.COMBAT_NORMAL
    if not self._queues[pr] then
        pr = PRIORITY.COMBAT_NORMAL
    end
    self._queuedKeys[cacheKey] = true
    QueueEnqueue(self._queues[pr], cacheKey)
    local queued = 0
    for _ in pairs(self._queuedKeys) do
        queued = queued + 1
    end
    self._perf.queuedPeak = math.max(self._perf.queuedPeak or 0, queued)
    self:UpdateFrameActivity()
end

function CacheRefreshManager:Delay(cacheKey, atTime, priority)
    if not cacheKey then
        return
    end
    self._delayed[cacheKey] = {
        at = atTime or (GetTime() + 0.05),
        pr = priority or PRIORITY.COMBAT_NORMAL,
    }
    self:UpdateFrameActivity()
end

function CacheRefreshManager:PumpDelayed(now)
    if not self._delayed or not next(self._delayed) then
        return
    end
    local moved = 0
    -- Keep this bounded to avoid large per-frame loops.
    for key, d in pairs(self._delayed) do
        if d and d.at and now >= d.at then
            self._delayed[key] = nil
            self:Enqueue(key, d.pr)
            moved = moved + 1
            if moved >= 10 then
                return
            end
        end
    end
end

function CacheRefreshManager:DequeueNext()
    for pr = PRIORITY.CRITICAL_ROTATION, PRIORITY.COMBAT_LOW do
        local q = self._queues[pr]
        if q and not QueueIsEmpty(q) then
            local key = QueueDequeue(q)
            if key then
                self._queuedKeys[key] = nil
                return key
            end
        end
    end
    return nil
end

function CacheRefreshManager:OnUpdate(elapsed)
    self._perf.onUpdateCalls = (self._perf.onUpdateCalls or 0) + 1
    if UnitAffectingCombat and not UnitAffectingCombat("player") then
        self._perf.idleOnUpdateCalls = (self._perf.idleOnUpdateCalls or 0) + 1
    end
    self._elapsedAccum = (self._elapsedAccum or 0) + (elapsed or 0)
    local framePollIntervalSec = self:GetFramePollIntervalSec()
    if self._elapsedAccum < framePollIntervalSec then
        return
    end
    self._elapsedAccum = 0

    if not self:ShouldRun() then
        self:UpdateFrameActivity()
        return
    end
    local now = GetTime()
    local startMs = NowMs()
    self:PumpDelayed(now)
    if not next(self._queuedKeys) then
        self._perf.lastLoopMs = NowMs() - startMs
        if self._perf.lastLoopMs > (self._perf.maxLoopMs or 0) then
            self._perf.maxLoopMs = self._perf.lastLoopMs
        end
        self:UpdateFrameActivity()
        return
    end

    local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
    local budgetMs = self:GetBudgetMs()
    local maxJobs = self.db.global.maxJobsPerTick or 25
    if not inCombat then
        local maxOOC = self.db.global.maxJobsPerTickOutOfCombat or 10
        if maxOOC < maxJobs then
            maxJobs = maxOOC
        end
    end
    startMs = NowMs()
    local processed = 0

    while processed < maxJobs do
        if (NowMs() - startMs) >= budgetMs then
            break
        end

        local key = self:DequeueNext()
        if not key then
            break
        end

        self:ProcessKey(key, startMs, budgetMs)
        processed = processed + 1
    end
    self._perf.jobsProcessed = (self._perf.jobsProcessed or 0) + processed
    self._perf.lastLoopMs = NowMs() - startMs
    if self._perf.lastLoopMs > (self._perf.maxLoopMs or 0) then
        self._perf.maxLoopMs = self._perf.lastLoopMs
    end
    self:UpdateFrameActivity()
end

function CacheRefreshManager:CanStartEntry(entry, now)
    if entry.inProgress then
        return false
    end
    if entry.nextEligibleAt and now < entry.nextEligibleAt then
        return false
    end
    return true
end

function CacheRefreshManager:ProcessKey(cacheKey, startMs, budgetMs)
    local now = GetTime()
    local entry = self:GetEntry(cacheKey)

    if not entry.computeFn then
        return
    end

    if not self:CanStartEntry(entry, now) then
        -- Not eligible yet: delay until nextEligibleAt to avoid churn.
        self:Delay(cacheKey, entry.nextEligibleAt or (now + 0.05), entry.priority)
        return
    end

    entry.inProgress = true
    self._locks[cacheKey] = true
    entry.lastStartAt = now
    entry.runCount = (entry.runCount or 0) + 1

    local ok, r1, r2 = self:SafeCall(cacheKey, entry.computeFn, entry.computeState)
    if not ok then
        entry.lastError = tostring(r1)
        entry.computeState = nil
        entry.inProgress = false
        self._locks[cacheKey] = nil
        -- Backoff by minInterval to avoid error spam storms
        entry.nextEligibleAt = now + ClampInterval(entry.minIntervalSec)
        return
    end

    -- Sliced contract: returns (done:boolean, stateOrValue:any).
    -- NOTE: We require the second return to be non-nil to treat it as sliced.
    local isSlicedReturn = (type(r1) == "boolean" and r2 ~= nil)
    if entry.sliced or isSlicedReturn then
        local done = r1 and true or false
        local stateOrValue = r2
        if done then
            self:Set(cacheKey, stateOrValue, nil)
            entry.computeState = nil
            entry.lastFinishAt = now
            entry.inProgress = false
            self._locks[cacheKey] = nil
            local interval = ClampInterval(entry.minIntervalSec)
            local frac = self.db.global.jitterFraction or 0.25
            entry.nextEligibleAt = now + interval + StableJitterSec(cacheKey, interval * frac)
            if entry.pending then
                entry.pending = false
                if entry.pendingComputeFn then
                    entry.computeFn = entry.pendingComputeFn
                    entry.pendingComputeFn = nil
                end
                self:Enqueue(cacheKey, entry.priority)
            end
        else
            entry.computeState = stateOrValue
            entry.inProgress = false
            self._locks[cacheKey] = nil
            -- Requeue immediately; the global budget loop will limit same-frame work.
            self:Enqueue(cacheKey, entry.priority)
        end
        return
    end

    -- Atomic contract: r1 is value
    self:Set(cacheKey, r1, nil)
    entry.computeState = nil
    entry.lastFinishAt = now
    entry.inProgress = false
    self._locks[cacheKey] = nil
    do
        local interval = ClampInterval(entry.minIntervalSec)
        local frac = self.db.global.jitterFraction or 0.25
        entry.nextEligibleAt = now + interval + StableJitterSec(cacheKey, interval * frac)
    end

    if entry.pending then
        entry.pending = false
        if entry.pendingComputeFn then
            entry.computeFn = entry.pendingComputeFn
            entry.pendingComputeFn = nil
        end
        self:Enqueue(cacheKey, entry.priority)
    end
end

-- ============================ PUBLIC API ============================

--- Get cached value by key.
--- @param cacheKey string
--- @return any value
--- @return table|nil meta
function CacheRefreshManager:Get(cacheKey)
    local e = self.state.cache[cacheKey]
    if not e then
        return nil, nil
    end
    return e.value, e.meta
end

--- Set cached value by key.
--- @param cacheKey string
--- @param value any
--- @param meta table|nil
function CacheRefreshManager:Set(cacheKey, value, meta)
    self.state.cache[cacheKey] = {
        value = value,
        meta = meta,
        updatedAt = GetTime(),
    }
end

--- Request a refresh computation for a cache key (deduped; non-overlapping).
--- The compute runs later within the manager budget; callers should continue reading cached values.
--- @param cacheKey string
--- @param opts table|nil
--- @param computeFn function
--- @return boolean scheduled True if it was queued or marked pending
function CacheRefreshManager:RequestRefresh(cacheKey, opts, computeFn)
    if not cacheKey or not computeFn then
        return false
    end
    opts = opts or {}

    local entry = self:GetEntry(cacheKey)

    local pr = opts.priority or entry.priority or PRIORITY.COMBAT_NORMAL
    entry.priority = pr

    local minInterval = ClampInterval(opts.minIntervalSec or entry.minIntervalSec or 0)
    entry.minIntervalSec = minInterval

    entry.sliced = opts.sliced == true
    entry.sliceBudgetMs = opts.sliceBudgetMs or entry.sliceBudgetMs

    if entry.inProgress then
        entry.pending = true
        entry.pendingComputeFn = computeFn
        return true
    end

    entry.computeFn = computeFn
    entry.pendingComputeFn = nil

    self:Enqueue(cacheKey, entry.priority)
    return true
end

--- Get cached value and request refresh if stale.
--- @param cacheKey string
--- @param opts table|nil { staleAfterSec, ... } (also forwarded to RequestRefresh)
--- @param computeFn function
--- @return any value
--- @return table|nil meta
function CacheRefreshManager:GetOrRequest(cacheKey, opts, computeFn)
    opts = opts or {}
    local entry = self.state.cache[cacheKey]
    local staleAfter = opts.staleAfterSec

    local shouldRefresh = false
    if not entry then
        shouldRefresh = true
    elseif staleAfter and type(staleAfter) == "number" then
        local age = (GetTime() - (entry.updatedAt or 0))
        if age >= staleAfter then
            shouldRefresh = true
        end
    end

    if shouldRefresh and computeFn then
        self:RequestRefresh(cacheKey, opts, computeFn)
    end

    return entry and entry.value or nil, entry and entry.meta or nil
end

--- Print current queue and lock status for debugging.
function CacheRefreshManager:PrintQueueStatus()
    local locked = 0
    for _ in pairs(self._locks) do
        locked = locked + 1
    end
    local mutexLocked = 0
    for _ in pairs(self._mutexLocks) do
        mutexLocked = mutexLocked + 1
    end
    local queued = 0
    for _ in pairs(self._queuedKeys) do
        queued = queued + 1
    end

    local c1 = QueueCount(self._queues[PRIORITY.CRITICAL_ROTATION])
    local c2 = QueueCount(self._queues[PRIORITY.COMBAT_HIGH])
    local c3 = QueueCount(self._queues[PRIORITY.COMBAT_NORMAL])
    local c4 = QueueCount(self._queues[PRIORITY.COMBAT_LOW])

    self:Print(format(
        "CacheRefreshManager: queued=%d (crit=%d, high=%d, normal=%d, low=%d), inProgress=%d, mutex=%d",
        queued, c1, c2, c3, c4, locked, mutexLocked
    ))
    self:Print(format(
        "CacheRefresh perf: onUpdate=%d idleOnUpdate=%d jobs=%d queuedPeak=%d lastLoopMs=%.2f maxLoopMs=%.2f",
        self._perf.onUpdateCalls or 0,
        self._perf.idleOnUpdateCalls or 0,
        self._perf.jobsProcessed or 0,
        self._perf.queuedPeak or 0,
        self._perf.lastLoopMs or 0,
        self._perf.maxLoopMs or 0
    ))
end

CacheRefreshManager.PRIORITY = PRIORITY
CacheRefreshManager.PRIORITY_NAMES = PRIORITY_NAMES

-- ============================ MUTEX API (NON-OVERLAP) ============================

--- Acquire a lightweight mutex lock.
--- Intended for preventing overlapping heavy computations that must run inline.
--- @param lockKey string
--- @return boolean acquired
function CacheRefreshManager:AcquireMutex(lockKey)
    if not lockKey then
        return false
    end
    local now = GetTime()
    local heldAt = self._mutexLocks[lockKey]
    if heldAt then
        local stealAfter = self.db.global.mutexStealAfterSec or 2.0
        if stealAfter > 0 and (now - heldAt) > stealAfter then
            local lastWarn = self._mutexStealWarnAt[lockKey] or 0
            local warnCooldown = self.db.global.mutexStealWarnCooldownSec or 2.0
            if (now - lastWarn) > warnCooldown then
                self._mutexStealWarnAt[lockKey] = now
                self:Warn("CacheRefreshManager mutex '%s' held for %.2fs; stealing lock",
                    tostring(lockKey), now - heldAt)
            end
            self._mutexLocks[lockKey] = now
            return true
        end
        return false
    end
    self._mutexLocks[lockKey] = now
    return true
end

--- Release a previously acquired mutex lock.
--- @param lockKey string
function CacheRefreshManager:ReleaseMutex(lockKey)
    if not lockKey then
        return
    end
    self._mutexLocks[lockKey] = nil
end

--- Check whether a mutex is locked.
--- @param lockKey string
--- @return boolean
function CacheRefreshManager:IsMutexLocked(lockKey)
    return not not (lockKey and self._mutexLocks[lockKey])
end

