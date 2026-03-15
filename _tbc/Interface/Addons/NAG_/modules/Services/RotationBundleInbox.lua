--- @module "NAG.RotationBundleInbox"
--- Parallel bulk-rotation delivery inbox (global, cross-character).
---
--- Stores rotation import strings delivered via a single encoded bundle and consumes them
--- on the appropriate character/class using the existing ImportExport + RotationManager flow.
---
--- Design goals:
--- - Do not change/replace existing single-rotation import behavior
--- - Allow one paste to deliver rotations for multiple classes (alts consume on login)
--- - Always import via `ClassBase:AddRotationFromImportString()` to keep the same pipeline
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
---

-- ============================ LOCALIZE ============================

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local UnitClassBase = _G.UnitClassBase
local time = _G.time
local strupper = strupper

local json = ns.LibJSON

-- ============================ MODULE ============================

--- @class RotationBundleInbox : CoreModule
local RotationBundleInbox = NAG:CreateModule("RotationBundleInbox", nil, {
    moduleType = ns.MODULE_TYPES.CORE,
    debugCategories = { ns.DEBUG_CATEGORIES.SERVICES },
    eventHandlers = {
        PLAYER_LOGIN = "OnPlayerLogin",
    }
})

ns.RotationBundleInbox = RotationBundleInbox

-- ============================ INTERNAL HELPERS ============================

--- Normalizes a class token to match ImportExport validation (uppercase, no spaces)
--- @param classToken string|nil
--- @return string|nil
local function normalizeClassToken(classToken)
    if type(classToken) ~= "string" then
        return nil
    end
    local normalized = strupper(classToken:gsub("%s+", ""))
    if normalized == "" then
        return nil
    end
    return normalized
end

--- Best-effort extraction of the rotation's target class from an import string.
--- Supports both legacy `NAG_ROTATION:` header strings and JSON payloads.
--- @param importString string
--- @return string|nil targetClass
function RotationBundleInbox:DetectTargetClass(importString)
    if type(importString) ~= "string" or importString == "" then
        return nil
    end

    -- JSON (WoWSims or direct)
    if importString:sub(1, 1) == "{" then
        local ok, parsed = pcall(json.Deserialize, importString)
        if ok and type(parsed) == "table" then
            return normalizeClassToken(parsed.class)
        end
        return nil
    end

    -- Legacy export header: NAG_ROTATION:CLASS:SPEC:VERSION:
    local classFromHeader = importString:match("^NAG_ROTATION:([^:]+):")
    return normalizeClassToken(classFromHeader)
end

--- Gets the inbox table from global DB, creating if missing.
--- @return table
function RotationBundleInbox:_GetInbox()
    if not (NAG and NAG.db and NAG.db.global) then
        return {}
    end
    if type(NAG.db.global.rotationBundleInbox) ~= "table" then
        NAG.db.global.rotationBundleInbox = {}
    end
    return NAG.db.global.rotationBundleInbox
end

-- ============================ PUBLIC API ============================

--- Enqueues a rotation import string into the global inbox.
--- @param importString string
--- @param source? string
--- @return boolean success
--- @return string? error
function RotationBundleInbox:Enqueue(importString, source)
    if type(importString) ~= "string" or importString == "" then
        return false, "Invalid importString"
    end

    local inbox = self:_GetInbox()
    local targetClass = self:DetectTargetClass(importString)

    inbox[#inbox + 1] = {
        importString = importString,
        targetClass = targetClass,
        addedAt = time(),
        source = source or "unknown",
        attempts = 0,
    }

    return true
end

--- Attempts to import all inbox items matching the current player's class.
--- Successful imports are removed from the inbox.
--- @return number importedCount
--- @return number remainingCount
function RotationBundleInbox:ProcessInbox()
    local inbox = self:_GetInbox()
    if not inbox or not next(inbox) then
        return 0, 0
    end

    local playerClass = UnitClassBase and UnitClassBase("player") or nil
    if not playerClass then
        return 0, #inbox
    end

    local classModule = NAG:GetClassModule()
    if not classModule then
        return 0, #inbox
    end

    local importedCount = 0

    -- Iterate backwards so we can remove safely
    for i = #inbox, 1, -1 do
        local entry = inbox[i]
        if type(entry) == "table" and type(entry.importString) == "string" then
            entry.attempts = (tonumber(entry.attempts) or 0) + 1

            -- Only attempt entries that either match our class or have unknown class.
            if not entry.targetClass or entry.targetClass == playerClass then
                local ok, err = classModule:AddRotationFromImportString(entry.importString, true)
                if ok then
                    table.remove(inbox, i)
                    importedCount = importedCount + 1
                else
                    -- If we failed and target class was unknown, try to detect now and keep for alts if mismatched.
                    if not entry.targetClass then
                        entry.targetClass = self:DetectTargetClass(entry.importString)
                        if entry.targetClass and entry.targetClass ~= playerClass then
                            -- Don't keep retrying on this character anymore.
                        end
                    end

                    if self.debug then
                        self:Debug(
                            "RotationBundleInbox: Import failed (class=%s, target=%s, attempts=%s): %s",
                            tostring(playerClass),
                            tostring(entry.targetClass),
                            tostring(entry.attempts),
                            tostring(err)
                        )
                    end
                end
            end
        else
            table.remove(inbox, i)
        end
    end

    return importedCount, #inbox
end

-- ============================ EVENTS ============================

function RotationBundleInbox:OnPlayerLogin()
    -- Keep runtime work minimal: only act if we have pending entries.
    local inbox = self:_GetInbox()
    if not inbox or not next(inbox) then
        return
    end

    local importedCount, remainingCount = self:ProcessInbox()
    if importedCount > 0 then
        NAG:Info(("Imported %d rotation(s) from bundle inbox. Remaining: %d."):format(importedCount, remainingCount))
    end
end

