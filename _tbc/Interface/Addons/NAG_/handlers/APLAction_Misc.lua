--- @module "APLAction_Misc"
--- Miscellaneous APL action functions for the NAG addon
---
--- This module provides utility functions for various miscellaneous actions and operations.
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

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)
local RC = ns.RC



-- Lua APIs (WoW optimized where available)
local format = string.format

local sort = table.sort
local concat = table.concat
local ipairs = ipairs
local type = type
local tostring = tostring

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local StateManager = ns.StateManager
local SpecCompat = ns.SpecCompat
local DisplayManager = ns.DisplayManager
local OverlayManager = ns.OverlayManager

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ============================ NAG-SPECIFIC HELPERS ============================

-- ============================ ROTATION SWITCHING HELPERS ============================
--- Smart rotation switching helper that replaces hardcoded SelectRotation calls.
--- Automatically detects current spec and switches to optimal rotation based on context.
--- Call this at the start of your rotation to automatically switch to the optimal rotation.
--- @return boolean Whether a rotation switch occurred
function NAG:SmartRotationSwitch()
    -- Use specIndex (1,2,3) for internal operations - get from StateManager (single source of truth)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()

    if not specIndex or specIndex == 0 then
        NAG:Warn("SmartRotationSwitch: No valid specialization available")
        return false
    end

    local classModule = NAG:GetClassModule()
    if not classModule then
        NAG:Warn("SmartRotationSwitch: No class module available")
        return false
    end

    -- Use the smart switching system (no parameters needed - defaults to current spec)
    return classModule:SmartRotationSwitch()
end

-- ============================ APL ACTION MAPPINGS ============================
-- These functions map to the Go APL actions in apl_actions_misc.go

-- ============================ TARGET MANAGEMENT ============================

--- Changes the current target to the specified unit and shows a targeting overlay.
--- TODO: verify this is correct
--- Maps to APLActionChangeTarget in Go.
--- @param newTarget string The new target unit (e.g., "target", "focus", "mouseover")
--- @return boolean Always returns true for APL compatibility
--- @usage NAG:ChangeTarget("focus")
function NAG:ChangeTarget(newTarget)
    if not newTarget then
        self:Error("ChangeTarget: No target unit provided")
        return false
    end


    -- Show targeting overlay on all active display frames
    for _, displayFrame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
        OverlayManager:ShowOverlay(displayFrame, "target", newTarget)
    end

    -- Always return true for APL compatibility
    return true
end

-- ============================ AURA MANAGEMENT ============================

--- Cancels an aura if it is active and shows an overlay for cancellation.
--- Maps to APLActionCancelAura in Go.
--- @param auraId number The ID of the aura to cancel
--- @return boolean False if the aura is not active or cancellation failed, true if successful
function NAG:CancelAura(auraId)
    if not auraId or not self:AuraIsActive(auraId) then
        return false
    end


    if not NAG.Frame then
        self:Error("CancelAura: NAG.Frame not found")
        return false
    end

    -- Set the aura spell as the next spell to display (like NAG:Cast does)
    -- This makes the spell appear in the rotation display
    if not self.nextSpell then
        -- No spell currently set, use as primary
        self.nextSpell = self:NormalizePrimaryAction(auraId, { context = "cancel_aura_primary" })
    else
        -- Primary already has a spell, add to secondary
        self:AddSecondarySpell(auraId)
    end

    -- Show cancel overlay on all active display frames

    -- Show on group display if active
    if DisplayManager:IsGroupDisplayMode() then
        local mainGroupFrame = DisplayManager.groupFrames and DisplayManager.groupFrames[ns.FRAME_GROUPS.MAIN]
        if mainGroupFrame and mainGroupFrame.iconFrames and mainGroupFrame.iconFrames[1] then
            local anchorFrame = mainGroupFrame.iconFrames[1]
            if OverlayManager then
                local customConfig = {
                    icon = "Interface\\Buttons\\UI-Panel-MinimizeButton-Up", -- Red X texture
                    size = 1.25, -- Larger X for better visibility
                    alpha = 1.0, -- Semi-transparent for better visibility
                    pulse = true, -- Add pulsing animation
                    color = {1, 0, 0, 0.75} -- Red color with matching alpha
                }
                OverlayManager:ShowCancelAura(anchorFrame, auraId, customConfig)
            end
        end
    end

    -- Show on legacy frame if enabled (can show on both if both are active)
    if DisplayManager:IsLegacyFrameEnabled() and NAG.Frame and NAG.Frame.iconFrames then
        local anchorFrame = NAG.Frame.iconFrames["primary"]
        if anchorFrame then
            local customConfig = {
                icon = "Interface\\Buttons\\UI-Panel-MinimizeButton-Up", -- Red X texture
                size = 1.25, -- Larger X for better visibility
                alpha = 1.0, -- Semi-transparent for better visibility
                pulse = true, -- Add pulsing animation
                color = {1, 0, 0, 0.75} -- Red color with matching alpha
            }
            OverlayManager:ShowCancelAura(anchorFrame, auraId, customConfig)
        end
    end

    return true -- Return true to stop rotation and display the cancel aura
end

--- Activates an aura (alias to Cast for APL compatibility).
--- Maps to APLActionActivateAura in Go.
--- @param auraId number The ID of the aura to activate
--- @return boolean Result of the cast operation
function NAG:ActivateAura(auraId)
    return self:CastSpell(auraId)
end

--- Activates an aura with a specific number of stacks.
--- Maps to APLActionActivateAuraWithStacks in Go.
--- @param auraId number The ID of the aura to activate
--- @param numStacks number The number of stacks to apply
--- @return boolean Always returns true
--- @usage NAG:ActivateAuraWithStacks(12345, 3)
function NAG:ActivateAuraWithStacks(auraId, numStacks)
    return true
end

--- Activates all stat buff proc auras (not yet implemented).
--- Maps to APLActionActivateAllStatBuffProcAuras in Go.
--- @param swapSet string|number The item swap set to use (ItemSwapSet.Main, ItemSwapSet.Swap1, etc.)
--- @param statType1 number First stat type to match (-1 for any)
--- @param statType2 number Second stat type to match (-1 for any)
--- @param statType3 number Third stat type to match (-1 for any)
--- @return boolean Always returns false (not implemented)
function NAG:ActivateAllStatBuffProcAuras(swapSet, statType1, statType2, statType3)
    -- One-time warning per session to avoid spam
    if not self._statBuffProcAurasWarningShown then
        self:Error("ActivateAllStatBuffProcAuras is not yet fully implemented. Parameters: swapSet=%s, statType1=%s, statType2=%s, statType3=%s",
            tostring(swapSet), tostring(statType1), tostring(statType2), tostring(statType3))
        self._statBuffProcAurasWarningShown = true
    end
    return false
end

--- Triggers the internal cooldown for an aura.
--- TODO: verify this is correct
--- Maps to APLActionTriggerICD in Go.
--- @param auraId number The ID of the aura
--- @return boolean Always returns true for APL compatibility
--- @usage NAG:TriggerICD(73643)
function NAG:TriggerICD(auraId)
    if not auraId then
        self:Error("TriggerICD: No auraId provided")
        return false
    end

    -- TriggerICD: Use the item to trigger its ICD (put it on cooldown)
    -- This is for desyncing ICDs before combat starts
    return NAG:CastSpell(auraId)
end

--- Shows a cancel prompt for Metamorphosis without cancelling automatically.
--- Displays a cancel overlay/symbol and text; does not alter rotation result.
--- @return boolean Always returns false so the APL evaluation continues
function NAG:CancelMeta()
    local auraId = 103958 -- Metamorphosis
    if not self:AuraIsActive(auraId) then
        return false
    end

    -- Show overlay on all active primary frames
    local frames = DisplayManager:GetActivePrimaryFrames()
    for _, anchorFrame in ipairs(frames) do
        OverlayManager:ShowCancelMeta(anchorFrame, auraId)
    end

    return false
end

-- ============================ ITEM MANAGEMENT ============================

--- Swaps items according to the provided swap set.
--- TODO: verify this is correct
--- Maps to APLActionItemSwap in Go.
--- @param swapSet any The swap set identifier (enum value, string, or table payload)
--- @return boolean True if the swap overlay was shown, false otherwise
--- @usage NAG:ItemSwap({12345, 67890})
function NAG:ItemSwap(swapSet)
    if not swapSet then return false end

    local evaluationPayload = swapSet
    if type(evaluationPayload) ~= "table" then
        evaluationPayload = { swapSet = evaluationPayload }
    end

    local isActive, details = self:EvaluateItemSwapSet(evaluationPayload)
    if isActive then
        print(format("[ItemSwap] ItemSwap(%s): already active (%s), skipping overlay",
            tostring(swapSet), tostring(details and details.resolvedName)))
        return false
    end


    local frames = DisplayManager:GetActivePrimaryFrames()
    if #frames == 0 then return false end

    for _, displayFrame in ipairs(frames) do
        OverlayManager:ShowOverlay(displayFrame, "itemswap", swapSet)
    end

    return true
end


-- ============================ MOVEMENT ============================

--- No-op function for moving to a specified range (always returns false).
--- Maps to APLActionMove in Go.
--- @param range number The target range to move to
--- @return boolean Always returns false
function NAG:MoveToRange(range)
    return false
end


--- Placeholder for moving the player for a specific duration.
--- Maps to APLActionMoveDuration in Go.
--- @param duration number The duration to move for
--- @return boolean True if the action was successful
--- @usage NAG:MoveDuration(2)
function NAG:MoveDuration(duration)
    -- TODO: Implement logic for moving for a specific duration.
    -- One-time warning per session to avoid spam
    if not self._moveDurationWarningShown then
        self:Error("MoveDuration is not yet fully implemented.")
        self._moveDurationWarningShown = true
    end
    return false
end

-- ============================ CUSTOM ROTATION ============================

--- Stub for CustomRotation, which is not supported in this environment.
--- Maps to APLActionCustomRotation in Go.
--- @return nil Always returns nil and prints an error
--- @usage NAG:CustomRotation()
function NAG:CustomRotation()
    self:Error("CustomRotation is not supported in this environment.")
    return nil
end

-- ===================== STUBS for non-supported functions =======================

--- Stub for AddComboPoints, which is not supported in this environment.
--- @return nil Always returns nil and prints an error
--- @usage NAG:AddComboPoints()
function NAG:AddComboPoints()
    self:Error("AddComboPoints is not supported in this environment.")
    return nil
end

--- Casts the Paladin's primary seal (stub for compatibility).
--- @return boolean Always returns true
--- @usage NAG:CastPaladinPrimarySeal()
function NAG:CastPaladinPrimarySeal()
    return true
end
