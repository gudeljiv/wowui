--- @module "NAG.RenderingProfileStabilizer"
--- Runtime render-profile stabilizer for high-frequency update loops.
---
--- This module maintains a short-lived "stabilized" window so UI/profile checks
--- don't thrash during intense combat/roster churn. State is runtime-only.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local GetTime = _G.GetTime
local IsInRaid = _G.IsInRaid
local IsInGroup = _G.IsInGroup
local GetNumGroupMembers = _G.GetNumGroupMembers
local UnitInRaid = _G.UnitInRaid
local InCombatLockdown = _G.InCombatLockdown

-- ============================ MODULE ============================

--- @class RenderingProfileStabilizer : CoreModule
local RenderingProfileStabilizer = NAG:CreateModule("RenderingProfileStabilizer", nil, {
    moduleType = ns.MODULE_TYPES.CORE,
    debugCategories = { ns.DEBUG_CATEGORIES.SERVICES },
    eventHandlers = {
        PLAYER_REGEN_DISABLED = true,
        GROUP_ROSTER_UPDATE = true,
    }
})

ns.RenderingProfileStabilizer = RenderingProfileStabilizer

-- ============================ STATE ============================

RenderingProfileStabilizer._stabilizedUntil = 0
RenderingProfileStabilizer._lastStabilizeTime = 0
RenderingProfileStabilizer._windowSeconds = 6 * 60 * 60
RenderingProfileStabilizer._extendInRaid = true
RenderingProfileStabilizer._extendInCombat = true

-- ============================ INTERNAL HELPERS ============================

--- @return boolean
function RenderingProfileStabilizer:_IsRaidContext()
    if UnitInRaid and UnitInRaid("player") then return true end
    if IsInRaid and IsInRaid() then return true end
    if IsInGroup and IsInGroup() and GetNumGroupMembers and (GetNumGroupMembers() or 0) >= 10 then
        return true
    end
    return false
end

--- @return boolean
function RenderingProfileStabilizer:_IsCombatContext()
    if InCombatLockdown then
        return InCombatLockdown() == true
    end
    return false
end

--- @param now number
--- @return boolean extended
function RenderingProfileStabilizer:_MaybeExtendExpiredWindow(now)
    now = now or GetTime()

    if (self._stabilizedUntil or 0) <= 0 then
        return false
    end

    if (self._stabilizedUntil or 0) > now then
        return false
    end

    local shouldExtend = false
    if self._extendInRaid and self:_IsRaidContext() then
        shouldExtend = true
    elseif self._extendInCombat and self:_IsCombatContext() then
        shouldExtend = true
    end

    if not shouldExtend then
        return false
    end

    self._stabilizedUntil = now + (self._windowSeconds or 0)
    self._lastStabilizeTime = now

    if self.debug then
        self:Debug(
            "RenderingProfileStabilizer: Extended window until %.2f (%.0fs)",
            self._stabilizedUntil,
            self._windowSeconds
        )
    end

    return true
end

-- ============================ PUBLIC API ============================

--- @return boolean
function RenderingProfileStabilizer:IsStabilized()
    local now = GetTime()
    if (self._stabilizedUntil or 0) > now then
        return true
    end
    if self:_MaybeExtendExpiredWindow(now) then
        return true
    end
    return false
end

--- @param now number
function RenderingProfileStabilizer:Stabilize(now)
    now = now or GetTime()
    local untilTime = now + (self._windowSeconds or 0)
    if untilTime > (self._stabilizedUntil or 0) then
        self._stabilizedUntil = untilTime
        self._lastStabilizeTime = now
        if self.debug then
            self:Debug("RenderingProfileStabilizer: Stabilized window until %.2f (%.0fs)", self._stabilizedUntil, self._windowSeconds)
        end
    end
end

--- Clears any active stabilization window immediately.
--- Used when keys are cleared so runtime checks re-evaluate real license state.
function RenderingProfileStabilizer:ClearStabilization()
    self._stabilizedUntil = 0
    self._lastStabilizeTime = 0
end

-- ============================ EVENTS ============================

local function _IsRuntimeProfileReady()
    if ns.checkLicenseOnly then
        return ns.checkLicenseOnly() == true
    end
    if ns.checkBase then
        local _, baseOk = ns.checkBase()
        return baseOk == true
    end
    return false
end

function RenderingProfileStabilizer:PLAYER_REGEN_DISABLED()
    if _IsRuntimeProfileReady() then
        self:Stabilize(GetTime())
    end
end

function RenderingProfileStabilizer:GROUP_ROSTER_UPDATE()
    if not self:_IsRaidContext() then
        return
    end

    if _IsRuntimeProfileReady() then
        self:Stabilize(GetTime())
    end
end


