--- @module "APLSequences"
--- APL sequence handlers for the NAG addon
---
--- This module provides utility functions for APL sequences and sequence management.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================
local WoWAPI = ns.WoWAPI

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)
local RC = ns.RC


-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitIsEnemy = _G.UnitIsEnemy
local UnitCanAttack = _G.UnitCanAttack


local format = string.format



local strmatch = strmatch
local strfind = strfind
local strlower = strlower

local tinsert = tinsert
local tremove = tremove
local wipe = wipe

local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

-- Enhanced error handling
local pcall = ns.pcall

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local StateManager = ns.StateManager
local DataManager = ns.DataManager
local DisplayManager = ns.DisplayManager
local OverlayManager = ns.OverlayManager

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


--- Updates the display of active sequence spells. This function ensures that sequence spells
--- remain visible across frames while the sequence is active.
--- @return boolean True if sequence display was updated, false otherwise
--- @usage local updated = NAG:UpdateActiveSequenceDisplay() -- Update sequence display
--- @local Internal utility function for sequence management
function NAG:UpdateActiveSequenceDisplay()
    if not NAG.RightSlots.activeSequence then
        return false
    end

    -- Check if we need to re-display the sequence
    if NAG.RightSlots._lockSequence then
        -- Get the stored sequence spells
        local sequenceSpells = NAG.RightSlots.sequence

        if sequenceSpells and #sequenceSpells > 0 then
            return true
        else
            return false
        end
    end

    return false
end

--- Initializes a strict sequence of actions (spell IDs or wait commands) to be executed in order.
--- A StrictSequence only activates when ALL listed actions are ready and castable at once.
--- @param name string The name of the sequence.
--- @param forceMain boolean|nil Optional flag to force first spell to main frame (default: true).
--- @param ... any Variable arguments: spell IDs (number) or wait commands (string) to perform in sequence.
--- @return boolean True if the sequence is active and should block main rotation, false otherwise.
--- @usage NAG:StrictSequence("sequenceName", 12345) -- forceMain optional: one action => defaults to true
--- @usage NAG:StrictSequence("sequenceName", nil, 12345, "NAG:Wait(2)", 67890)
--- @usage NAG:StrictSequence("sequenceName", true, 12345, 67890) -- Force first spell to main frame
--- @see NAG:SpellCastSequence
function NAG:StrictSequence(name, forceMain, ...)
    if not name or type(name) ~= "string" then
        self:Error("StrictSequence: Invalid sequence name")
        return false
    end

    -- When forceMain is omitted and only one action is given: ("name", spellId) => ("name", true, spellId)
    local actions
    if select("#", ...) == 0 and type(forceMain) == "number" then
        actions = { forceMain }
        forceMain = true
    else
        if forceMain == nil then forceMain = true end
        actions = { ... }
    end

    -- Check if this is called from APL system (functions) or direct call (spell IDs)
    local isAPLCall = false
    if #actions > 0 and type(actions[1]) == "function" then
        isAPLCall = true
    end

    if #actions == 0 then
        self:Error("StrictSequence: No actions provided")
        return false
    end

    -- Initialize sequence completion tracking if not exists
    if not NAG.RightSlots.completedSequences then
        NAG.RightSlots.completedSequences = {}
    end

    -- CRITICAL: Allow StrictSequence to interrupt regular sequences
    -- If there's an active regular sequence, StrictSequence should take priority
    if NAG.RightSlots.activeSequence and NAG.RightSlots.sequenceType == "regular" then
        local interruptedSequence = NAG.RightSlots.activeSequence
        self:Debug(format("StrictSequence: Interrupting regular sequence '%s' with StrictSequence '%s'",
            interruptedSequence, name))

        -- Reset the regular sequence state
        NAG.RightSlots:resetSequence()

        -- Clear any regular sequence tracking
        if self.sequenceSpells and self.sequenceSpells[interruptedSequence] then
            self.sequenceSpells[interruptedSequence] = nil
            self.sequencePosition[interruptedSequence] = nil
        end
    end

    -- Check if this sequence is already active
    if NAG.RightSlots.activeSequence == name then
        -- Ensure the sequence is locked when it's already active
        NAG.RightSlots._lockSequence = true

        -- If sequence is active but has no spells left, it means it's completing
        if #NAG.RightSlots.sequence == 0 then
            return forceMain
        end

        -- Display logic: Show first spell in main frame if forceMain is true (even for active sequences)
        if forceMain and #NAG.RightSlots.sequence > 0 then
            local firstSpellId = NAG.RightSlots.sequence[1]

            -- Set context flag to bypass sequence interruption check
            self._castingFromSequence = true
            self._castingFromStrictSequence = true
            self:CastSpell(firstSpellId, nil, ns.SPELL_POSITIONS.PRIMARY)
            self._castingFromSequence = false
            self._castingFromStrictSequence = false

            -- Mark that we're showing the first spell in middle to prevent duplication in right frames
            NAG.RightSlots.forceMainActive = true
        else
            NAG.RightSlots.forceMainActive = false
        end

        -- CRITICAL: For active sequences, return based on forceMain
        if not forceMain then
            return false
        else
            return true
        end
    end
    -- If we get here, this is a new sequence or a sequence that was interrupted

    -- Check if this sequence was previously interrupted and should be restored
    if self.interruptedSequences and self.interruptedSequences[name] then
        self:Debug(format("StrictSequence: Restoring previously interrupted sequence '%s'", name))
        local restored = self:RestoreSequence(name)
    end

    -- Parse arguments to extract spell IDs and function calls
    local spellIds = {}
    local hasValidSpells = false

    for i, action in ipairs(actions) do
        local spellId = nil

        if type(action) == "number" then
            -- Direct spell ID
            spellId = action
        elseif type(action) == "function" then
            if isAPLCall then
                -- APL system call - execute the function to get the action
                local success, result = pcall(action)
                if success then
                    -- The result should be a spell ID or action result
                    if type(result) == "number" then
                        spellId = result
                    else
                        -- Skip non-numeric results and continue to next iteration
                        spellId = nil
                    end
                else
                    self:Error(format("StrictSequence: APL function execution failed: %s", tostring(result)))
                    -- Skip failed function calls and continue to next iteration
                    spellId = nil
                end
            else
                -- Direct function call like NAG:CastSpell(spellId)
                local funcStr = tostring(action)
                local extractedId = strmatch(funcStr, "%((%d+)%)")
                if extractedId then
                    spellId = tonumber(extractedId)
                end
            end
        elseif type(action) == "string" then
            -- String action - could be a wait command or spell name
            if action:match("^NAG:Wait%(") then
                -- Wait command - extract duration
                local duration = strmatch(action, "NAG:Wait%((%d+%.?%d*)%)")
                if duration then
                    -- For now, skip wait commands in strict sequences
                    -- TODO: Implement wait handling for strict sequences
                    spellId = nil
                else
                    self:Error(format("StrictSequence: Invalid wait command format: %s", action))
                    spellId = nil
                end
            else
                -- Try to resolve spell name to ID
                local resolvedId = self:ResolveSpellName(action)
                if resolvedId then
                    spellId = resolvedId
                else
                    self:Error(format("StrictSequence: Could not resolve spell name: %s", action))
                    spellId = nil
                end
            end
        end

        -- Validate the spell ID and resolve to spellbook ID so stored list matches display/cooldown
        if spellId and type(spellId) == "number" then
            local resolvedId = self:ResolveEffectiveSpellId(spellId) or spellId
            -- Check if this is a known spell (IsKnown so enchant/tinker IDs in sequences work)
            if self:IsKnown(resolvedId) then
                tinsert(spellIds, resolvedId)
                hasValidSpells = true
            else
                -- Skip unknown spells but continue processing
                spellId = nil
            end
        end
    end

    if not hasValidSpells then
        -- Only throw error if this is a new sequence, not if it's an active sequence that's completing
        if NAG.RightSlots.activeSequence == name then
            self:Info("StrictSequence: Active sequence has no valid spells left, allowing completion")
            self:Info(format("StrictSequence: Returning %s for no valid spells (forceMain=%s)",
                tostring(forceMain and true or false), tostring(forceMain)))
            return forceMain and true or false
        else
            return false
        end
    end

    -- CRITICAL FIX: Check if this sequence is already active - if so, continue without checking readiness
    if NAG.RightSlots.activeSequence == name and NAG.RightSlots.sequenceType == "strict" then
        -- Sequence is already active and is a strict sequence, continue without checking readiness
        NAG.RightSlots._lockSequence = true

        -- If sequence is active but has no spells left, it means it's completing
        if #NAG.RightSlots.sequence == 0 then
            return forceMain
        end

        -- Display logic: Show first spell in main frame if forceMain is true (even for active sequences)
        if forceMain and #NAG.RightSlots.sequence > 0 then
            local firstSpellId = NAG.RightSlots.sequence[1]
            self._castingFromSequence = true
            self._castingFromStrictSequence = true
            self:CastSpell(firstSpellId, nil, ns.SPELL_POSITIONS.PRIMARY)
            self._castingFromSequence = false
            self._castingFromStrictSequence = false
            NAG.RightSlots.forceMainActive = true
        else
            NAG.RightSlots.forceMainActive = false
        end

        -- CRITICAL: For active sequences, return based on forceMain
        if not forceMain then
            return false
        else
            return true
        end
    end

    -- CRITICAL FIX: Check if this sequence was recently completed to prevent immediate re-initialization
    if NAG.RightSlots.completedSequences and NAG.RightSlots.completedSequences[name] then
        local completionTime = NAG.RightSlots.completedSequences[name]
        local timeSinceCompletion = GetTime() - completionTime

        -- If sequence was completed less than 0.2 seconds ago, don't re-initialize
        if timeSinceCompletion < 0.2 then
            return false
        else
            -- Clear the completion record if it's old enough
            NAG.RightSlots.completedSequences[name] = nil
        end
    end

    -- STRICT SEQUENCE: Require ALL spells ready before activating (wowsims semantics).
    -- Store the full spellIds list in the sequence (like wowsims: sequence = all subactions, not a filtered list).
    local allSpellsReady = true
    local readySpells = {}

    for i, spellId in ipairs(spellIds) do
        local timeToReady = self:TimeToReady(spellId)

        if timeToReady and timeToReady <= 0.5 then
            if self:SpellCanCast(spellId) then
                tinsert(readySpells, spellId)
            else
                allSpellsReady = false
            end
        else
            allSpellsReady = false
        end
    end

    if not allSpellsReady then
        return false
    end

    if #readySpells == 0 then
        return false
    end

    -- CRITICAL FIX: Check for valid target before initializing sequence to prevent flickering
    if not UnitExists("target") or not UnitCanAttack("player", "target") then
        return false
    end

    -- Set this as the active sequence and initialize tracking
    NAG.RightSlots.activeSequence = name
    NAG.RightSlots.sequenceProgress = 1
    NAG.RightSlots.unrelatedCastCount = 0
    NAG.RightSlots.sequenceType = "strict" -- Mark this as a strict sequence

    -- CRITICAL FIX: Set forceMainActive based on forceMain parameter
    NAG.RightSlots.forceMainActive = forceMain and true or false

    -- CRITICAL FIX: Set initialization time to prevent premature resetting
    NAG.RightSlots.sequenceInitTime = GetTime()

    -- Store the original sequence for tracking completion
    if not NAG.RightSlots.originalSequence then
        NAG.RightSlots.originalSequence = {}
    end
    -- Store full spell list in sequence (wowsims: sequence = all subactions; readiness only gates activation)
    NAG.RightSlots.originalSequence[name] = {}
    for i, spellId in ipairs(spellIds) do
        NAG.RightSlots.originalSequence[name][i] = spellId
    end
    NAG.RightSlots.originalSequenceCount = #spellIds

    if #NAG.RightSlots.sequence == 0 then
        wipe(NAG.RightSlots.sequence)
        for i, spellId in ipairs(spellIds) do
            tinsert(NAG.RightSlots.sequence, spellId)
        end
    end

    NAG.RightSlots._lockSequence = true

    if not self.strictSequenceSpells[name] then
        self.strictSequenceSpells[name] = spellIds
        self.strictSequencePosition[name] = 1
    end
    self.isSequenceActive = true

    -- Display logic: Show first spell in main frame if forceMain is true
    if forceMain and #NAG.RightSlots.sequence > 0 then
        local firstSpellId = NAG.RightSlots.sequence[1]

        -- Set context flags to bypass sequence interruption check and user position overrides
        self._castingFromSequence = true
        self._castingFromStrictSequence = true
        self:CastSpell(firstSpellId, nil, ns.SPELL_POSITIONS.PRIMARY)
        self._castingFromSequence = false
        self._castingFromStrictSequence = false

        -- Mark that we're showing the first spell in middle to prevent duplication in right frames
        NAG.RightSlots.forceMainActive = true
    else
        NAG.RightSlots.forceMainActive = false
    end

    -- Return behavior based on forceMain:
    -- - forceMain == true: Return true to block APL execution (first spell in main frame)
    -- - forceMain == false: Return false to allow APL to continue (visual guide only)
    return forceMain and true or false
end

--- Executes the next action in the strict spell cast sequence. Handles waits and spell casts.
--- @return boolean True if the sequence is still active, false if it has completed or encountered an error.
--- @usage NAG:SpellCastSequence() -- Execute next action in active sequence
--- @see NAG:StrictSequence
--- @local This function is used to execute the next action in the strict spell cast sequence.
function NAG:SpellCastSequence()
    if not self.isSequenceActive then return false end
    if self.waitInProgress then return true end

    for name, actions in pairs(self.strictSequenceSpells) do
        -- DISABLE OLD SYSTEM: Skip if RightSlots system is active for this sequence
        if not (NAG.RightSlots and NAG.RightSlots.activeSequence == name) then
            local index = self.strictSequencePosition[name]
            local nextAction = actions[index]
            if type(nextAction) == "string" and nextAction:match("^NAG:Wait%((%d+%.?%d*)%)$") then
                local duration = tonumber(nextAction:match("%d+%.?%d*")) or 0
                self:Wait(duration)
                return true
            elseif type(nextAction) == "number" then
                if self:IsSecondarySpell(nextAction) then
                    self:AddSecondarySpell(nextAction)
                    return false
                else
                    -- Use RIGHT position for strict sequence spells
                    -- Set flag to bypass user position overrides
                    self._castingFromStrictSequence = true
                    local result = self:CastSpell(nextAction, nil, ns.SPELL_POSITIONS.RIGHT)
                    self._castingFromStrictSequence = false
                    return result
                end
            elseif nextAction == nil then
                self.strictSequencePosition[name] = 1
                self.isSequenceActive = false
                return false
            elseif type(nextAction) == "number" then
                if nextAction ~= StateManager:GetLastCastId() then
                    self:ResetStrictSequence(name)
                    self:Warn(
                        format("SpellCastSequence: Resetting sequence %s due to unexpected spell ID: %s", name, nextAction))
                    self.isSequenceActive = false -- Reset the flag when the sequence ends
                    return false
                end
            else
                self:Error(format("SpellCastSequence: Unexpected nextAction type: %s", type(nextAction)))
                self.isSequenceActive = false
                self:ResetStrictSequence(name)
                return false
            end
        end
    end

    return false
end

--- Tracks spell casts and updates sequence progress
--- @param spellId number The ID of the spell that was cast
--- @return nil
--- @usage NAG:TrackSequenceCast(12345) -- Track spell cast for sequence progress
--- @local
function NAG:TrackSequenceCast(spellId)
    if not spellId or spellId == 0 then return end

    -- Check if we have an active StrictSequence
    if not NAG.RightSlots.activeSequence or NAG.RightSlots.sequenceType ~= "strict" then
        return
    end

    local sequenceName = NAG.RightSlots.activeSequence
    local castSpellInfo = WoWAPI.GetSpellInfo(spellId)
    local castSpellName = castSpellInfo and castSpellInfo.name or "Unknown"

    -- Check if the cast spell is part of the active sequence (any position)
    -- Match by spellId first (CLEU may report same or different ID), then by name (ranks/overrides)
    local spellFound = false
    local spellIndex = nil

    for i, sequenceSpellId in ipairs(NAG.RightSlots.sequence) do
        if spellId == sequenceSpellId then
            spellFound = true
            spellIndex = i
            break
        end
        local spellInfo = WoWAPI.GetSpellInfo(sequenceSpellId)
        if castSpellName == (spellInfo and spellInfo.name or "Unknown") then
            spellFound = true
            spellIndex = i
            break
        end
    end

    if spellFound then
        -- Remove the spell from the sequence (any position)
        tremove(NAG.RightSlots.sequence, spellIndex)
        NAG.RightSlots.unrelatedCastCount = 0

        -- CRITICAL: Check if this was the LAST spell in the original sequence
        -- Completion is triggered when the final spell (last spell passed to API) is cast
        local isLastSpell = false
        if NAG.RightSlots.originalSequence and NAG.RightSlots.originalSequence[sequenceName] then
            local originalSequence = NAG.RightSlots.originalSequence[sequenceName]
            local originalCount = NAG.RightSlots.originalSequenceCount

            if originalCount and originalCount > 0 then
                local lastSpellId = originalSequence[originalCount]
                local spellInfo = WoWAPI.GetSpellInfo(lastSpellId)

                if castSpellName == (spellInfo and spellInfo.name or "Unknown") then
                    isLastSpell = true
                end
            end
        end

        -- If this was the last spell OR if no spells remain, complete the sequence
        if isLastSpell or #NAG.RightSlots.sequence == 0 then
            -- Get the sequence name before clearing it
            local completedSequenceName = NAG.RightSlots.activeSequence

            -- Sequence is complete - unlock and clear RightSlots state
            NAG.RightSlots._lockSequence = false
            NAG.RightSlots.activeSequence = nil
            NAG.RightSlots.sequenceType = nil

            -- Clear UI overlays
            if OverlayManager then
                OverlayManager:ClearAllSequenceArrows()
            end

            -- CRITICAL: Clean up StrictSequence tracking structures
            if completedSequenceName and NAG.strictSequenceSpells then
                -- Clear the sequence tracking data
                NAG.strictSequenceSpells[completedSequenceName] = nil
                if NAG.strictSequencePosition then
                    NAG.strictSequencePosition[completedSequenceName] = nil
                end

                -- Reset the global sequence active flag if no more sequences are active
                if next(NAG.strictSequenceSpells) == nil then
                    NAG.isSequenceActive = false
                end

                -- Clear completion tracking to allow immediate restart
                if NAG.RightSlots.completedSequences then
                    NAG.RightSlots.completedSequences[completedSequenceName] = nil
                end

                -- Clear original sequence tracking
                if NAG.RightSlots.originalSequence then
                    NAG.RightSlots.originalSequence[completedSequenceName] = nil
                end
                NAG.RightSlots.originalSequenceCount = nil

                -- StrictSequences don't modify positions - no restoration needed
                -- Display system reads from currentRotation.spellLocations directly
            end
        end
    end
end

-- Initialize target tracking for sequence reset logic
if not NAG.lastTargetGUID then
    NAG.lastTargetGUID = nil
end

if not NAG.unrelatedCastHistory then
    NAG.unrelatedCastHistory = {}
end

--- Handles target changes and resets sequences if needed.
--- @param newTargetGUID string The GUID of the new target
--- @return nil
--- @usage NAG:HandleTargetChange("targetGUID") -- Handle target change event
--- @local
function NAG:HandleTargetChange(newTargetGUID)
    if not newTargetGUID then return end

    -- Check if target actually changed
    if NAG.lastTargetGUID == newTargetGUID then
        return
    end

    NAG.lastTargetGUID = newTargetGUID

    -- Reset StrictSequences on target change
    -- CRITICAL: Don't reset StrictSequences on target change - they should continue until completion
    -- Only reset if the target change is significant (e.g., switching to a completely different target)
    if NAG.RightSlots.activeSequence and NAG.RightSlots.sequenceType == "strict" then
        -- For StrictSequences, only reset if we're switching to a completely different target type
        -- (e.g., from enemy to friendly, or from one enemy type to another)
        local oldTargetType = NAG.lastTargetType
        local newTargetType = UnitIsEnemy("target", "player") and "enemy" or "friendly"

        if oldTargetType and oldTargetType ~= newTargetType then
            self:Debug(format("Target type changed from %s to %s during StrictSequence '%s' - resetting sequence",
                oldTargetType, newTargetType, NAG.RightSlots.activeSequence))
            NAG.RightSlots:resetSequence()

            -- Clear UI overlays
            if OverlayManager then
                OverlayManager:ClearAllSequenceArrows()
            end
        end

        -- Store the new target type
        NAG.lastTargetType = newTargetType
    end

    -- Clear unrelated cast history on target change
    wipe(NAG.unrelatedCastHistory)
end

--- Tracks unrelated spell casts for StrictSequence reset logic.
--- @param spellId number The spell ID that was cast
--- @return boolean True if the spell was unrelated to the active sequence
--- @usage local wasUnrelated = NAG:TrackUnrelatedCast(12345) -- Track unrelated cast
--- @local
function NAG:TrackUnrelatedCast(spellId)
    if not spellId or spellId == 0 then return false end

    -- Check if we have an active StrictSequence
    if not NAG.RightSlots.activeSequence or NAG.RightSlots.sequenceType ~= "strict" then
        return false
    end

    local sequenceName = NAG.RightSlots.activeSequence
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    local spellName = spellInfo and spellInfo.name or "Unknown"

    -- DISABLE: Unrelated cast detection for StrictSequences
    -- This prevents DOT damage and other spell effects from resetting sequences
    local disableUnrelatedCastDetection = true
    if disableUnrelatedCastDetection then
        return false
    end

    -- SPECIAL HANDLING: AoE spells (effect = 27, aura = 4) might have different timing
    -- Check if this is an AoE spell and give it special consideration
    local isAoESpell = false
    local spellEntry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if spellEntry and spellEntry.effect == 27 and spellEntry.aura == 4 then
        isAoESpell = true
    end

    -- Check if the cast spell is part of the active sequence (current remaining spells)
    local isSequenceSpell = false
    if NAG.RightSlots.sequence and #NAG.RightSlots.sequence > 0 then
        for i, sequenceSpellId in ipairs(NAG.RightSlots.sequence) do
            -- FIX: Use spell name comparison instead of ID comparison for consistency
            local sequenceSpellInfo = WoWAPI.GetSpellInfo(sequenceSpellId)

            if (sequenceSpellInfo and sequenceSpellInfo.name) and spellName == (sequenceSpellInfo and sequenceSpellInfo.name) then
                isSequenceSpell = true
                break
            end
        end
    end

    -- Also check the main frame spell if forceMainActive is true
    local nextIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell) or nil
    local nextResolveId = nextIdentity and (NAG.GetActionResolveId and NAG:GetActionResolveId(nextIdentity)) or nil
    if not isSequenceSpell and NAG.RightSlots.forceMainActive and nextResolveId == spellId then
        isSequenceSpell = true
    end

    -- CRITICAL FIX: Also check if the spell is part of the original sequence
    -- This prevents false "unrelated cast" detection when the first spell is in the main frame
    if not isSequenceSpell and NAG.RightSlots.originalSequence and NAG.RightSlots.originalSequence[sequenceName] then
        for i, originalSpellId in ipairs(NAG.RightSlots.originalSequence[sequenceName]) do
            local originalSpellInfo = WoWAPI.GetSpellInfo(originalSpellId)
            -- FIX: Use spell name comparison instead of ID comparison for consistency
            if (originalSpellInfo and originalSpellInfo.name) and spellName == (originalSpellInfo and originalSpellInfo.name) then
                isSequenceSpell = true
                break
            end
        end
    end

    -- Debug logging for spell detection
    if isSequenceSpell then
        --     spellId, spellName, sequenceName))
        -- If it's a sequence spell, clear unrelated cast history
        wipe(NAG.unrelatedCastHistory)
    else
        --     spellId, spellName, sequenceName))

        tinsert(NAG.unrelatedCastHistory, spellId)

        -- Keep only the last 3 unrelated casts for performance
        if #NAG.unrelatedCastHistory > 3 then
            tremove(NAG.unrelatedCastHistory, 1)
        end

        -- Reset StrictSequence if we have 2 or more unrelated casts
        -- SPECIAL: Be more lenient with AoE spells
        local requiredUnrelatedCasts = isAoESpell and 6 or 4
        if #NAG.unrelatedCastHistory >= requiredUnrelatedCasts then
            --   NAG.RightSlots.activeSequence, #NAG.unrelatedCastHistory, requiredUnrelatedCasts, tostring(isAoESpell)))
            NAG.RightSlots:resetSequence()

            -- Clear UI overlays
            if OverlayManager then
                OverlayManager:ClearAllSequenceArrows()
            end

            -- Clear unrelated cast history
            wipe(NAG.unrelatedCastHistory)
            return true
        end
    end

    return false
end

--- Handles the completion of a spell cast, advancing sequences as needed.
--- @param spellId number The ID of the spell that was cast.
--- @return boolean True if the spell cast was handled successfully, false otherwise.
--- @usage NAG:SpellCastSucceeded(73643)
--- @local This function is used to handle the completion of a spell cast, advancing sequences as needed.
function NAG:SpellCastSucceeded(spellId)
    if not spellId then
        self:Warn("SpellCastSucceeded: spellId is nil")
        return false
    end
    if spellId == 20424 then return false end

    -- Track unrelated casts for StrictSequence reset logic
    local wasUnrelatedCast = self:TrackUnrelatedCast(spellId)
    if wasUnrelatedCast then
        -- Sequence was reset due to unrelated casts, no need to process further
        return true
    end
    for name, actions in pairs(self.sequenceSpells) do
        local index = self.sequencePosition[name]
        local nextAction = actions[index]
        if type(nextAction) == "function" then
            local nextSpell = strmatch(tostring(nextAction), "%((%d+)%)")
            if spellId == tonumber(nextSpell) then
                self.sequencePosition[name] = self.sequencePosition[name] + 1
                if #actions < self.sequencePosition[name] then
                    -- Mark as completed but don't reset - let it remain inactive
                    if not NAG.RightSlots.completedSequences then
                        NAG.RightSlots.completedSequences = {}
                    end
                    NAG.RightSlots.completedSequences[name] = GetTime()
                    -- Unlock the sequence since it's now completed
                    if NAG.RightSlots.activeSequence == name then
                        NAG.RightSlots._lockSequence = false
                    end
                end
            end
        else
            local nextSpell = tonumber(nextAction)
            if spellId == nextSpell then
                self.sequencePosition[name] = self.sequencePosition[name] + 1
                if #actions < self.sequencePosition[name] then
                    -- Mark as completed but don't reset - let it remain inactive
                    if not NAG.RightSlots.completedSequences then
                        NAG.RightSlots.completedSequences = {}
                    end
                    NAG.RightSlots.completedSequences[name] = GetTime()
                    -- Unlock the sequence since it's now completed
                    if NAG.RightSlots.activeSequence == name then
                        NAG.RightSlots._lockSequence = false
                    end
                end
            end
        end
    end

    -- Handle progressive sequence advancement using RightSlots system
    if NAG.RightSlots.activeSequence and NAG.RightSlots.sequenceType then
        local sequenceName = NAG.RightSlots.activeSequence
        local sequenceType = NAG.RightSlots.sequenceType

        if sequenceType == "strict" then
            -- DISABLED: Old order-sensitive StrictSequence logic
            -- The new TrackSequenceCast function handles all StrictSequence completion properly
            -- This prevents conflicts and ensures consistent behavior
            -- StrictSequence advancement is now handled by TrackSequenceCast with order-independent logic
            return true
        elseif sequenceType == "regular" then
            -- Handle Regular Sequence advancement
            if self.sequenceSpells[sequenceName] then
                local actualIndex = NAG.RightSlots.actualSpellIndex and NAG.RightSlots.actualSpellIndex[sequenceName] or
                    1
                local actions = self.sequenceSpells[sequenceName]



                if actualIndex <= #actions then
                    local currentAction = actions[actualIndex]
                    local currentSpellId = nil

                    -- Extract spell ID from action
                    if type(currentAction) == "number" then
                        currentSpellId = currentAction
                    elseif type(currentAction) == "function" then
                        local funcStr = tostring(currentAction)
                        local extractedId = strmatch(funcStr, "%((%d+)%)")
                        if extractedId then
                            currentSpellId = tonumber(extractedId)
                        end
                    end

                    -- Check if the cast spell matches the current sequence spell
                    if currentSpellId and spellId == currentSpellId then

                        -- Advance to next position
                        self.sequencePosition[sequenceName] = actualIndex + 1
                        NAG.RightSlots.sequenceProgress = actualIndex + 1

                        -- Check if sequence is completed
                        if actualIndex + 1 > #actions then

                            -- Mark as completed
                            if not NAG.RightSlots.completedSequences then
                                NAG.RightSlots.completedSequences = {}
                            end
                            NAG.RightSlots.completedSequences[sequenceName] = GetTime()

                            -- Clear active sequence
                            NAG.RightSlots.activeSequence = nil
                            NAG.RightSlots.sequenceType = nil

                            return true
                        end

                        return true
                    end
                end
            end
        end
    end

    -- DISABLED: Old StrictSequence completion logic
    -- The new TrackSequenceCast function handles all sequence completion properly
    -- This prevents conflicts and ensures consistent behavior
    -- for name, actions in pairs(self.strictSequenceSpells) do
    --     -- Old system processing removed - let the new RightSlots system handle it
    -- end

    return false -- TODO added 10/25
end

--- Initializes a progressive sequence of actions (spell IDs or functions) to be executed in order.
--- A Sequence progresses after each spell cast, preserving state between rotation cycles.
--- Does NOT require all spells to be ready before starting (unlike StrictSequence).
--- @param name string The name of the sequence.
--- @param forceMain boolean|nil Optional flag to force first spell to main frame (default: true).
--- @param ... any Variable arguments: spell IDs or functions to perform in sequence.
--- @return boolean True if the sequence is active and should block main rotation, false otherwise.
--- @usage NAG:Sequence("sequenceName", nil, spell1, spell2, spell3)
--- @usage NAG:Sequence("sequenceName", true, spell1, spell2, spell3) -- Force first spell to main frame
function NAG:Sequence(name, forceMain, ...)
    if not name or type(name) ~= "string" then
        self:Error("Sequence: Invalid sequence name")
        return false
    end

    -- Direct parameter assignment (no polymorphic parsing)
    if forceMain == nil then forceMain = true end -- Default to true for forceMain
    local actions = { ... }

    -- Check if this is called from APL system (functions) or direct call (spell IDs)
    local isAPLCall = false
    if #actions > 0 and type(actions[1]) == "function" then
        isAPLCall = true
    end

    if #actions == 0 then
        self:Error("Sequence: No actions provided")
        return false
    end

    -- REGULAR SEQUENCE: Track progression and show next spell
    -- Initialize sequence tracking if not exists
    if not self.sequenceSpells[name] then
        self.sequenceSpells[name] = {}
        self.sequencePosition[name] = 1
    end

    -- Store actions if not already stored
    if #self.sequenceSpells[name] == 0 then
        for i, action in ipairs(actions) do
            self.sequenceSpells[name][i] = action
        end
    end

    -- Set up sequence tracking for SpellCastSucceeded
    NAG.RightSlots.activeSequence = name
    NAG.RightSlots.sequenceType = "regular"
    NAG.RightSlots.sequenceProgress = self.sequencePosition[name] or 1

    -- Store the actual spell index for cast confirmation
    if not NAG.RightSlots.actualSpellIndex then
        NAG.RightSlots.actualSpellIndex = {}
    end

    -- Parse arguments to extract spell IDs
    local spellIds = {}
    local hasValidSpells = false

    for i, action in ipairs(actions) do
        local spellId = nil

        if type(action) == "number" then
            -- Direct spell ID
            spellId = action
        elseif type(action) == "function" then
            if isAPLCall then
                -- APL system call - execute the function to get the action
                local success, result = pcall(action)
                if success then
                    -- The result should be a spell ID or action result
                    if type(result) == "number" then
                        spellId = result
                    else
                        -- Skip non-numeric results and continue to next iteration
                        spellId = nil
                    end
                else
                    self:Error(format("Sequence: APL function execution failed: %s", tostring(result)))
                    -- Skip failed function calls and continue to next iteration
                    spellId = nil
                end
            else
                -- Direct function call like NAG:CastSpell(spellId)
                local funcStr = tostring(action)
                local extractedId = strmatch(funcStr, "%((%d+)%)")
                if extractedId then
                    spellId = tonumber(extractedId)
                end
            end
        elseif type(action) == "string" then
            -- Wait command or other string action
            if not action:match("^NAG:Wait%((%d+%.?%d*)%)$") then
                self:Warn(format("Sequence: Unknown string action: %s", action))
            end
        end

        if spellId then
            -- Validate spell ID
            local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL) or
                DataManager:Get(spellId, DataManager.EntityTypes.ITEM)
            if entity then
                tinsert(spellIds, spellId)
                hasValidSpells = true
            else
                self:Error(format("Sequence: Invalid spell ID at position %d: %d", i, spellId))
            end
        end
    end

    if not hasValidSpells then
        return false
    end

    -- Get current position in sequence
    local currentIndex = self.sequencePosition[name] or 1

    -- Check if sequence is completed
    if currentIndex > #spellIds then
        -- Sequence is completed, return false until reset
        return false
    end

    -- Find the next known and castable spell starting from current position
    local nextSpellId = nil
    local nextIndex = currentIndex
    local actualSpellIndex = currentIndex -- Track the actual spell index in the original actions

    for i = currentIndex, #spellIds do
        local spellId = spellIds[i]
        if self:IsKnown(spellId) then
            -- Spell is known, check if it can be cast
            if self:SpellCanCast(spellId) then
                nextSpellId = spellId
                nextIndex = i
                actualSpellIndex = i -- This is the actual spell position in the original actions
                break
            else
                -- Known spell cannot be cast, skip the entire sequence
                --    name, spellId, spellName))
                return false
            end
        end
    end

    -- If no castable spell found, return false
    if not nextSpellId then
        return false
    end

    -- Store the actual spell index for cast confirmation
    NAG.RightSlots.actualSpellIndex[name] = actualSpellIndex

    -- Display the next spell (don't advance position until cast is confirmed)
    if forceMain then
        -- Show in main frame and return cast result
        -- Set flag to bypass user position overrides for sequence spells
        self._castingFromStrictSequence = true
        local result = self:CastSpell(nextSpellId, nil, ns.SPELL_POSITIONS.PRIMARY)
        self._castingFromStrictSequence = false
        return result
    else
        -- Show in right frame and return cast result
        -- Set flag to bypass user position overrides for sequence spells
        self._castingFromStrictSequence = true
        local result = self:CastSpell(nextSpellId, nil, ns.SPELL_POSITIONS.RIGHT)
        self._castingFromStrictSequence = false
        return result
    end
end

--- Resets all sequences (non-strict).
--- @return boolean True if the sequences are reset successfully.
--- @usage NAG:ResetSequences() -- Reset all regular sequences
function NAG:ResetSequences()
    self.sequencePosition = {}
    self.sequenceSpells = {}
    -- Reset right-side sequence slots
    NAG.RightSlots:reset()
    return true
end

--- Resets all strict sequences.
--- @return boolean True if the strict sequences are reset successfully.
--- @usage NAG:ResetStrictSequences() -- Reset all strict sequences
function NAG:ResetStrictSequences()
    -- Clear all sequence tracking data
    self.strictSequencePosition = {}
    self.strictSequenceSpells = {}

    -- Reset the global sequence active flag
    self.isSequenceActive = false

    -- Clear completion tracking to allow immediate restart
    if NAG.RightSlots.completedSequences then
        wipe(NAG.RightSlots.completedSequences)
    end

    -- Clear original sequence tracking
    if NAG.RightSlots.originalSequence then
        wipe(NAG.RightSlots.originalSequence)
    end
    NAG.RightSlots.originalSequenceCount = nil

    -- Reset right-side sequence slots
    NAG.RightSlots:resetSequence()

    return true
end

--- Resets a specific sequence by name.
--- @param name string The name of the sequence to reset.
--- @return boolean True if the sequence is reset successfully.
--- @usage NAG:ResetSequence("sequenceName")
function NAG:ResetSequence(name)
    if not name then
        self:Error("ResetSequence: Invalid sequence name")
        return false
    end

    -- Reset sequence position back to start instead of clearing it
    self.sequencePosition[name] = 1

    -- Clear completed sequences tracking for this sequence
    if NAG.RightSlots.completedSequences then
        NAG.RightSlots.completedSequences[name] = nil
    end

    -- Reset right-side sequence slots if this is the active sequence
    if NAG.RightSlots.activeSequence == name then
        NAG.RightSlots:reset()
    end

    return false
end

--- Resets a specific strict sequence by name.
--- @param name string The name of the strict sequence to reset.
--- @return boolean True if the strict sequence is reset successfully.
--- @usage NAG:ResetStrictSequence("strictSequenceName")
function NAG:ResetStrictSequence(name)
    -- Clear the sequence tracking data
    self.strictSequencePosition[name] = nil
    self.strictSequenceSpells[name] = nil

    -- Reset the global sequence active flag if no more sequences are active
    -- Reset the global sequence active flag if no more sequences are active
    if next(self.strictSequenceSpells) == nil then
        self.isSequenceActive = false
    end

    -- Clear completion tracking to allow immediate restart
    if NAG.RightSlots.completedSequences then
        NAG.RightSlots.completedSequences[name] = nil
    end

    -- Clear original sequence tracking
    if NAG.RightSlots.originalSequence then
        NAG.RightSlots.originalSequence[name] = nil
    end
    NAG.RightSlots.originalSequenceCount = nil

    -- Reset right-side sequence slots if this is the active sequence
    if NAG.RightSlots.activeSequence == name then
        NAG.RightSlots:resetSequence()
    else
        NAG.RightSlots:reset()
    end

    return true
end

--- Checks if a sequence is complete (all actions performed).
--- @param name string The name of the sequence.
--- @return boolean True if the sequence is complete, false otherwise.
--- @usage NAG:SequenceIsComplete("sequenceName")
function NAG:SequenceIsComplete(name)
    if not name then
        self:Warn("SequenceIsComplete: name is nil")
        return false
    end
    if self.sequenceSpells[name] and #self.sequenceSpells[name] >= self.sequencePosition[name] then
        return false
    end
    return true
end

--- Checks if a sequence is currently active (regular or strict).
--- @param name string The name of the sequence.
--- @return boolean True if the sequence is active, false otherwise.
--- @usage NAG:SequenceIsActive("BearWeave")
function NAG:SequenceIsActive(name)
    if not name then
        self:Warn("SequenceIsActive: name is nil")
        return false
    end
    return NAG.RightSlots and NAG.RightSlots.activeSequence == name
end

--- Checks if a sequence is ready to be executed (all spells off cooldown).
--- @param name string The name of the sequence.
--- @param ... number The spells in the sequence.
--- @return boolean True if the sequence is ready, false otherwise.
--- @usage NAG:SequenceIsReady("sequenceName", 73643, 12345)
function NAG:SequenceIsReady(name, ...)
    if not name then
        self:Warn("SequenceIsReady: name is nil")
        return false
    end
    if select('#', ...) == 0 then return false end -- No spells provided, not ready
    local sequence = { ... }
    return self:SequenceTimeToReady(name, unpack(sequence)) == 0
end

--- Checks if a strict sequence is ready to be executed (all spells off cooldown).
--- @param sequence table The spells in the strict sequence.
--- @return boolean True if the strict sequence is ready, false otherwise.
--- @usage NAG:StrictSequenceIsReady({73643, 12345})
function NAG:StrictSequenceIsReady(sequence)
    return self:StrictSequenceTimeToReady(sequence) == 0
end

--- Returns the maximum time to ready for a sequence (seconds until all spells are available).
--- @param sequenceName string The name of the sequence.
--- @param ... number The spells in the sequence.
--- @return number The maximum time to ready for the sequence.
--- @usage NAG:SequenceTimeToReady("sequenceName", 73643, 12345)
function NAG:SequenceTimeToReady(sequenceName, ...)
    if not sequenceName then
        self:Warn("SequenceTimeToReady: sequenceName is nil")
        return 0
    end
    local sequence = { ... }
    local maxttr = 0
    for i = 1, #sequence do
        if type(sequence[i]) == "number" then
            local ttr = self:SpellTimeToReady(sequence[i])
            if ttr > maxttr then maxttr = ttr end
        end
        -- skip non-number entries
    end
    return maxttr
end

--- Returns the maximum time to ready for a strict sequence (seconds until all spells are available).
--- @param sequence table The spells in the strict sequence.
--- @return number The maximum time to ready for the strict sequence.
--- @usage NAG:StrictSequenceTimeToReady({73643, 12345})
function NAG:StrictSequenceTimeToReady(sequence)
    local maxttr = 0
    for _, spellId in ipairs(sequence) do
        local ttr = self:SpellTimeToReady(spellId)
        if ttr > maxttr then
            maxttr = ttr
        end
    end
    return maxttr
end

-- Test sequence completion cooldown
-- luacheck: globals SLASH_NAGTESTCOOLDOWN1 SlashCmdList
SLASH_NAGTESTCOOLDOWN1 = "/nagtestcooldown"
SlashCmdList["NAGTESTCOOLDOWN"] = function(msg)
    -- Initialize completed sequences if not exists
    if not NAG.RightSlots.completedSequences then
        NAG.RightSlots.completedSequences = {}
    end

    local result1 = NAG:StrictSequence("cooldownTest", NAG:CastSpell(113858), NAG:CastSpell(104232))
    NAG.RightSlots:resetSequence()

    local result2 = NAG:StrictSequence("cooldownTest", NAG:CastSpell(113858), NAG:CastSpell(104232))


    -- Test 4: Wait and try again (simulate time passing)
    -- Simulate 3 seconds passing by adjusting the completion time
    if NAG.RightSlots.completedSequences and NAG.RightSlots.completedSequences["cooldownTest"] then
        NAG.RightSlots.completedSequences["cooldownTest"] = GetTime() - 3.0
    end

    local result3 = NAG:StrictSequence("cooldownTest", NAG:CastSpell(113858), NAG:CastSpell(104232))
end

--- Manually restores a previously interrupted sequence.
--- This can be called from APL to restore a sequence that was interrupted by a high-priority spell.
--- @param sequenceName string The name of the sequence to restore
--- @return boolean True if the sequence was restored, false otherwise
--- @usage NAG:RestoreInterruptedSequence("mySequence")
--- @local
function NAG:RestoreInterruptedSequence(sequenceName)
    if not sequenceName then
        self:Error("RestoreInterruptedSequence: Invalid sequence name")
        return false
    end

    local restored = self:RestoreSequence(sequenceName)

    return restored
end

-- Test command for sequence interruption debugging
-- luacheck: globals SLASH_NAGTESTINTERRUPT1
SLASH_NAGTESTINTERRUPT1 = "/nagtestinterrupt"
SlashCmdList["NAGTESTINTERRUPT"] = function(msg)
    -- First, try to cast the high-priority spell
    local castResult = NAG:CastSpell(80240)

    -- Then try the sequence
    local sequenceResult = NAG:Sequence("someName449", 26297, 348, 104232, 5782)

    -- Check if spell 80240 should interrupt
    local shouldInterrupt = NAG:ShouldInterruptSequence(80240)

    -- Check completed sequences
    if NAG.RightSlots.completedSequences then
        local completedCount = 0
        for name, _ in pairs(NAG.RightSlots.completedSequences) do
            completedCount = completedCount + 1
        end
    end

    -- Check interrupted sequences
    if NAG.interruptedSequences then
        local interruptedCount = 0
        for name, _ in pairs(NAG.interruptedSequences) do
            interruptedCount = interruptedCount + 1
        end
    end
end

-- Test command for optimized arrow logic
-- luacheck: globals SLASH_NAGTESTOPTIMIZEDARROWS1
SLASH_NAGTESTOPTIMIZEDARROWS1 = "/nagtestoptimizedarrows"
SlashCmdList["NAGTESTOPTIMIZEDARROWS"] = function(msg)

    -- Test 1: Sequence with forceMain == true (should show arrow from main to right1)
    local result = NAG:Sequence("testOptimizedArrows1", true, 6673, 1249459, 100)

    -- Simulate UpdateIcons to trigger arrow creation
    NAG:UpdateIcons(6673, {}) -- Main spell + empty spell table

    -- Reset for next test
    NAG.RightSlots:resetSequence()

    -- Test 2: Sequence with forceMain == false (should show arrow from right1 to right2)
    NAG:Sequence("testOptimizedArrows2", false, 6673, 1249459, 100)

    -- Simulate UpdateIcons to trigger arrow creation
    NAG:UpdateIcons(nil, {}) -- No main spell

    -- Reset for next test
    NAG.RightSlots:resetSequence()

    -- Test 3: Single spell sequence (should have no arrows)
    NAG:Sequence("testOptimizedArrows3", true, 6673)

    -- Simulate UpdateIcons
    NAG:UpdateIcons(6673, {})

    -- Reset for next test
    NAG.RightSlots:resetSequence()

    -- Test 4: Two spell sequence (should have 1 arrow)
    NAG:Sequence("testOptimizedArrows4", false, 6673, 1249459)

    -- Simulate UpdateIcons
    NAG:UpdateIcons(nil, {})

    -- Reset for next test
    NAG.RightSlots:resetSequence()

end

--- Checks if sequences should be reset due to invalid conditions.
--- Called periodically to ensure sequences are reset when conditions are no longer valid.
--- @return nil
--- @usage NAG:CheckSequenceResetConditions() -- Check and reset sequences if needed
--- @local Internal utility function for sequence management
function NAG:CheckSequenceResetConditions()

    -- Check if player has no valid target
    if not UnitExists("target") or not UnitCanAttack("player", "target") then
        if NAG.RightSlots.activeSequence then
            --self:Debug(format("🔄 No valid target - resetting active sequence '%s'", NAG.RightSlots.activeSequence))
            NAG.RightSlots:resetSequence()

            -- Clear UI overlays
            if OverlayManager then
                OverlayManager:ClearAllSequenceArrows()
            end
        end
        return
    end

    -- Check if no action is currently shown in the main frame
    -- CRITICAL FIX: Only check for empty main frame when forcemain is false
    -- When forcemain is true, the main frame is intentionally empty as we're displaying the sequence there
    local currentMainIdentity = NAG.NormalizePrimaryAction and NAG:NormalizePrimaryAction(NAG.nextSpell) or nil
    local currentMainId = currentMainIdentity and (NAG.GetActionResolveId and NAG:GetActionResolveId(currentMainIdentity)) or nil
    if not currentMainId or currentMainId == 0 then
        if NAG.RightSlots.activeSequence then
            -- CRITICAL FIX: Don't reset sequences that were just initialized
            -- Check if the sequence was initialized very recently (within the last 0.5 seconds)
            if NAG.RightSlots.sequenceInitTime then
                local timeSinceInit = GetTime() - NAG.RightSlots.sequenceInitTime
                if timeSinceInit < 0.5 then
                    return
                end
            end

            -- Skip this check entirely if forcemain is active
            if NAG.RightSlots.forceMainActive then
                return
            end

            if NAG.RightSlots.sequenceType == "strict" then
                -- CRITICAL FIX: For strictsequences, be extremely conservative about resetting
                -- Only reset if the main frame has been empty for a very long time
                if not NAG.RightSlots._mainFrameEmptyCount then
                    NAG.RightSlots._mainFrameEmptyCount = 0
                end

                -- CRITICAL FIX: Only increment the counter if we're not preserving the sequence
                -- This prevents the counter from reaching the threshold when we're protecting the sequence
                local shouldIncrementCounter = true

                -- Don't increment counter if sequence was recently initialized
                if NAG.RightSlots.sequenceInitTime then
                    local timeSinceInit = GetTime() - NAG.RightSlots.sequenceInitTime
                    if timeSinceInit < 0.5 then
                        shouldIncrementCounter = false
                    end
                end

                if shouldIncrementCounter then
                    NAG.RightSlots._mainFrameEmptyCount = NAG.RightSlots._mainFrameEmptyCount + 1
                end

                -- CRITICAL FIX: Use a much higher threshold for strictsequences
                -- They should be very resilient to temporary empty frames
                local resetThreshold = 50

                -- Only reset if main frame has been empty for the threshold frames
                if NAG.RightSlots._mainFrameEmptyCount >= resetThreshold then
                    self:Debug(format("No action in main frame for %d frames - resetting StrictSequence '%s'",
                        NAG.RightSlots._mainFrameEmptyCount, NAG.RightSlots.activeSequence))
                    NAG.RightSlots:resetSequence()

                    -- Clear UI overlays
                    if OverlayManager then
                        OverlayManager:ClearAllSequenceArrows()
                    end
                end
            else
                -- REGULAR SEQUENCES: Reset immediately if no action in main frame
                -- Regular sequences should not be preserved when main frame is empty
                self:Debug(format("No action in main frame - resetting regular sequence '%s'",
                    NAG.RightSlots.activeSequence))
                NAG.RightSlots:resetSequence()

                -- Clear UI overlays
                if OverlayManager then
                    OverlayManager:ClearAllSequenceArrows()
                end
            end
        end
        return
    else
        -- Reset the empty frame counter when there is a main spell
        if NAG.RightSlots and NAG.RightSlots._mainFrameEmptyCount then
            NAG.RightSlots._mainFrameEmptyCount = 0
        end
    end
end


local SEQUENCE_STEP_POOL = {}
for i = 1, 20 do
    SEQUENCE_STEP_POOL[i] = { spellId = nil, isCurrent = false, index = nil }
end
local sequenceStepPoolIndex = 0

local function getNextSequenceStep()
    sequenceStepPoolIndex = sequenceStepPoolIndex + 1
    if sequenceStepPoolIndex > #SEQUENCE_STEP_POOL then
        sequenceStepPoolIndex = 1
    end
    local step = SEQUENCE_STEP_POOL[sequenceStepPoolIndex]
    step.spellId = nil
    step.isCurrent = false
    step.index = nil
    return step
end


local sequenceDisplayData = {
    steps = {}
}

--- Returns the current sequence display data for group display integration.
--- @return table|nil Table with sequence display info, or nil if no sequence is active.
--- @usage local data = NAG:GetSequenceDisplayData() -- Get current sequence display data
--- @local Internal utility function for sequence management
function NAG:GetSequenceDisplayData()
    local rs = self.RightSlots
    if not rs or not rs.activeSequence or not rs.sequence or #rs.sequence == 0 then
        return nil
    end

    local data = sequenceDisplayData
    data.name = rs.activeSequence
    data.type = rs.sequenceType or "regular"
    data.forceMainActive = rs.forceMainActive or false
    data.progress = rs.sequenceProgress or 1

    -- Wipe and rebuild steps array
    wipe(data.steps)
    sequenceStepPoolIndex = 0

    for i, spellId in ipairs(rs.sequence) do
        local step = getNextSequenceStep()
        step.spellId = spellId
        step.isCurrent = (i == data.progress)
        step.index = i
        table.insert(data.steps, step)
    end

    data.completed = false
    if rs.completedSequences and rs.completedSequences[data.name] then
        data.completed = true
    end
    -- Optionally, add original sequence info if available
    if rs.originalSequence and rs.originalSequence[data.name] then
        data.originalSteps = rs.originalSequence[data.name]
        data.originalCount = rs.originalSequenceCount
    end
    return data
end

--- Determines if a spell should interrupt an active regular sequence.
--- High-priority spells like cooldowns should interrupt regular sequences.
--- @param spellId number The spell ID to check
--- @return boolean True if the spell should interrupt a regular sequence
--- @usage local shouldInterrupt = NAG:ShouldInterruptSequence(12345) -- Check if spell should interrupt
--- @local Internal utility function for sequence management
function NAG:ShouldInterruptSequence(spellId)
    if not spellId then return false end

    -- Get the spell entity
    local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entity then
        self:Debug(format("ShouldInterruptSequence: No entity found for spell %d", spellId))
        return false
    end

    -- Check if this is a cooldown spell (long cooldown)
    if entity.cooldown and entity.cooldown > 30 then
        self:Debug(format("ShouldInterruptSequence: Spell %d has long cooldown (%d), should interrupt", spellId,
            entity.cooldown))
        return true
    end

    -- Check if this is marked as a high-priority spell
    if entity.flags and entity.flags.highPriority then
        self:Debug(format("ShouldInterruptSequence: Spell %d is marked as high-priority, should interrupt", spellId))
        return true
    end

    -- Check if this is a major cooldown by name patterns
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    if spellInfo and spellInfo.name then
        local lowerName = strlower(spellInfo.name)
        -- Common cooldown patterns
        local cooldownPatterns = {
            "bloodlust", "heroism", "time warp", "ancient hysteria",
            "avatar", "recklessness", "berserking", "combat readiness",
            "shield wall", "last stand", "shield block",
            "divine shield", "divine protection", "lay on hands",
            "ice block", "cold snap", "evocation",
            "shadowform", "power infusion", "inner focus",
            "trueshot aura", "rapid fire", "aspect of the wild",
            "nature's swiftness", "elemental mastery", "blood fury",
            "berserking", "arcane power", "presence of mind",
            "dark soul" -- Add Dark Soul pattern for Warlock cooldowns
        }

        for _, pattern in ipairs(cooldownPatterns) do
            if strfind(lowerName, pattern) then
                return true
            end
        end
    end

    return false
end

--- Stores the state of a sequence for later restoration.
--- @param sequenceName string The name of the sequence to store
--- @return nil
--- @usage NAG:StoreSequenceState("mySequence") -- Store sequence state for restoration
--- @local Internal utility function for sequence management
function NAG:StoreSequenceState(sequenceName)
    if not sequenceName then return end

    -- Initialize storage if not exists
    if not self.interruptedSequences then
        self.interruptedSequences = {}
    end

    -- Store the current sequence state
    if self.sequenceSpells and self.sequenceSpells[sequenceName] then
        self.interruptedSequences[sequenceName] = {
            spells = self.sequenceSpells[sequenceName],
            position = self.sequencePosition[sequenceName] or 1,
            timestamp = GetTime()
        }
        --     sequenceName, self.sequencePosition[sequenceName] or 1))
    end
end

--- Restores a previously interrupted sequence.
--- @param sequenceName string The name of the sequence to restore
--- @return boolean True if the sequence was restored, false otherwise
--- @local Internal utility function for sequence management
function NAG:RestoreSequence(sequenceName)
    if not sequenceName or not self.interruptedSequences or not self.interruptedSequences[sequenceName] then
        return false
    end

    local storedState = self.interruptedSequences[sequenceName]

    -- Restore the sequence state
    if not self.sequenceSpells then self.sequenceSpells = {} end
    if not self.sequencePosition then self.sequencePosition = {} end

    self.sequenceSpells[sequenceName] = storedState.spells
    self.sequencePosition[sequenceName] = storedState.position

    -- Clear the stored state
    self.interruptedSequences[sequenceName] = nil

    --     sequenceName, storedState.position))

    return true
end

--- Check if a spell ID is displayed at a specific position.
--- @param spellId number The spell ID to check
--- @param position string The position to check (e.g., "primary", "left1", "right2")
--- @return boolean True if the spell is displayed at that position
--- @usage NAG:IsSpellAtPosition(12345, "primary")
--- @local Internal utility function for sequence management
function NAG:IsSpellAtPosition(spellId, position)
    if not spellId or not position then return false end
    -- Resolve so rank/variant (e.g. 33697) matches frame showing spellbook ID (e.g. 20572)
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    local iconFrame = DisplayManager.iconFrames[position]
    if not iconFrame then
        return false
    end

    return iconFrame.spellId == spellId and iconFrame:IsVisible()
end

--- Check if a spell ID is displayed anywhere in the NAG frames.
--- @param spellId number The spell ID to check
--- @return table|nil Returns position info if found, nil if not found
--- @usage NAG:GetSpellPosition(12345)
--- @local Internal utility function for sequence management
function NAG:GetSpellPosition(spellId)
    if not spellId then return nil end
    -- Resolve so rank/variant matches frame showing spellbook ID
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    for position, iconFrame in pairs(DisplayManager.iconFrames) do
        if iconFrame.spellId == spellId and iconFrame:IsVisible() then
            return {
                position = position,
                frame = iconFrame,
                isPrimary = position == ns.SPELL_POSITIONS.PRIMARY,
                isAOE = position == ns.SPELL_POSITIONS.AOE,
                isLeft = strmatch(position, "^" .. ns.SPELL_POSITIONS.LEFT) ~= nil,
                isRight = strmatch(position, "^" .. ns.SPELL_POSITIONS.RIGHT) ~= nil,
                isAbove = strmatch(position, "^" .. ns.SPELL_POSITIONS.ABOVE) ~= nil,
                isBelow = strmatch(position, "^" .. ns.SPELL_POSITIONS.BELOW) ~= nil
            }
        end
    end

    return nil
end

--- Get all spells currently displayed in NAG frames.
--- @return table Table of displayed spells with their positions
--- @usage local spells = NAG:GetDisplayedSpells() -- Get all displayed spells
--- @local Internal utility function for sequence management
function NAG:GetDisplayedSpells()
    local displayedSpells = {}
    -- Group display mode
    if DisplayManager.groupFrames then
        for groupKey, groupFrame in pairs(DisplayManager.groupFrames) do
            if groupFrame.iconFrames then
                for pos, iconFrame in pairs(groupFrame.iconFrames) do
                    if (iconFrame.spellId or iconFrame.itemId) and iconFrame:IsVisible() then
                        table.insert(displayedSpells, {
                            spellId = iconFrame.spellId,
                            itemId = iconFrame.itemId,
                            groupKey = groupKey,
                            position = pos,
                            frame = iconFrame
                        })
                    end
                end
            end
        end
    end
    -- Legacy display mode
    if NAG.Frame and NAG.Frame.iconFrames then
        for position, iconFrame in pairs(NAG.Frame.iconFrames) do
            if (iconFrame.spellId or iconFrame.itemId) and iconFrame:IsVisible() then
                table.insert(displayedSpells, {
                    spellId = iconFrame.spellId,
                    itemId = iconFrame.itemId,
                    position = position,
                    groupKey = iconFrame.groupKey or ns.SPELL_POSITIONS.PRIMARY, -- Use the groupKey set on the frame
                    frame = iconFrame
                })
            end
        end
    end
    return displayedSpells
end

--- Check if a spell is displayed in left positions.
--- @param spellId number The spell ID to check
--- @return boolean True if found in any left position
--- @usage NAG:IsSpellInLeftPositions(12345)
--- @local Internal utility function for sequence management
function NAG:IsSpellInLeftPositions(spellId)
    if not spellId then return false end
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then spellId = resolved end
    end

    for position, iconFrame in pairs(DisplayManager.iconFrames) do
        if strmatch(position, "^left") and iconFrame.spellId == spellId and iconFrame:IsVisible() then
            return true
        end
    end

    return false
end

--- Check if a spell is displayed in right positions.
--- @param spellId number The spell ID to check
--- @return boolean True if found in any right position
--- @usage NAG:IsSpellInRightPositions(12345)
--- @local Internal utility function for sequence management
function NAG:IsSpellInRightPositions(spellId)
    if not spellId then return false end
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then spellId = resolved end
    end

    for position, iconFrame in pairs(DisplayManager.iconFrames) do
        if strmatch(position, "^right") and iconFrame.spellId == spellId and iconFrame:IsVisible() then
            return true
        end
    end

    return false
end

--- Check if a spell is displayed in above positions.
--- @param spellId number The spell ID to check
--- @return boolean True if found in any above position
--- @usage NAG:IsSpellInAbovePositions(12345)
--- @local Internal utility function for sequence management
function NAG:IsSpellInAbovePositions(spellId)
    if not spellId then return false end
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then spellId = resolved end
    end

    for position, iconFrame in pairs(DisplayManager.iconFrames) do
        if strmatch(position, "^above") and iconFrame.spellId == spellId and iconFrame:IsVisible() then
            return true
        end
    end

    return false
end

--- Check if a spell is displayed in below positions.
--- @param spellId number The spell ID to check
--- @return boolean True if found in any below position
--- @usage NAG:IsSpellInBelowPositions(12345)
--- @local Internal utility function for sequence management
function NAG:IsSpellInBelowPositions(spellId)
    if not spellId then return false end
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then spellId = resolved end
    end

    for position, iconFrame in pairs(DisplayManager.iconFrames) do
        if strmatch(position, "^below") and iconFrame.spellId == spellId and iconFrame:IsVisible() then
            return true
        end
    end

    return false
end

--- Check if a spell is displayed as the primary spell.
--- @param spellId number The spell ID to check
--- @return boolean True if the spell is the primary spell
--- @usage NAG:IsPrimarySpell(12345)
--- @local Internal utility function for sequence management
function NAG:IsPrimarySpell(spellId)
    return self:IsSpellAtPosition(spellId, ns.SPELL_POSITIONS.PRIMARY)
end

--- Check if a spell is displayed as the AOE spell.
--- @param spellId number The spell ID to check
--- @return boolean True if the spell is the AOE spell
--- @usage NAG:IsAOESpell(12345)
--- @local Internal utility function for sequence management
function NAG:IsAOESpell(spellId)
    return self:IsSpellAtPosition(spellId, ns.SPELL_POSITIONS.AOE)
end

--- Get all positions where a spell is displayed.
--- @param spellId number The spell ID to check
--- @return table Array of positions where the spell is displayed
--- @usage NAG:GetSpellPositions(12345)
--- @local Internal utility function for sequence management
function NAG:GetSpellPositions(spellId)
    if not spellId then return {} end
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then spellId = resolved end
    end

    local positions = {}

    for position, iconFrame in pairs(DisplayManager.iconFrames) do
        if iconFrame.spellId == spellId and iconFrame:IsVisible() then
            tinsert(positions, position)
        end
    end

    return positions
end

--- Check if any spell is displayed at a specific position.
--- @param position string The position to check (e.g., "primary", "left1", "right2")
--- @return boolean True if any spell is displayed at that position
--- @usage NAG:IsPositionOccupied("primary")
--- @local Internal utility function for sequence management
function NAG:IsPositionOccupied(position)
    if not position then return false end

    local iconFrame = DisplayManager.iconFrames[position]
    if not iconFrame then
        return false
    end

    return iconFrame.spellId ~= nil and iconFrame:IsVisible()
end

--- Get the spell ID displayed at a specific position.
--- @param position string The position to check (e.g., "primary", "left1", "right2")
--- @return number|nil The spell ID at that position, or nil if no spell
--- @usage NAG:GetSpellAtPosition("primary")
--- @local Internal utility function for sequence management
function NAG:GetSpellAtPosition(position)
    if not position then return nil end

    local iconFrame = DisplayManager.iconFrames[position]
    if not iconFrame or not iconFrame:IsVisible() then
        return nil
    end

    return iconFrame.spellId
end

--- Count how many positions a spell is displayed in.
--- @param spellId number The spell ID to check
--- @return number The number of positions where the spell is displayed
--- @usage NAG:GetSpellDisplayCount(12345)
--- @local Internal utility function for sequence management
function NAG:GetSpellDisplayCount(spellId)
    if not spellId then return 0 end
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then spellId = resolved end
    end

    local count = 0

    for _, iconFrame in pairs(DisplayManager.iconFrames) do
        if iconFrame.spellId == spellId and iconFrame:IsVisible() then
            count = count + 1
        end
    end

    return count
end

--- Check if a spell is displayed in any secondary position (non-primary, non-AOE).
--- @param spellId number The spell ID to check
--- @return boolean True if the spell is in a secondary position
--- @usage NAG:IsSpellInSecondaryPosition(12345)
--- @local Internal utility function for sequence management
function NAG:IsSpellInSecondaryPosition(spellId)
    if not spellId then return false end
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then spellId = resolved end
    end

    for position, iconFrame in pairs(DisplayManager.iconFrames) do
        if iconFrame.spellId == spellId and iconFrame:IsVisible() then
            -- Check if it's not primary or AOE
            if position ~= ns.SPELL_POSITIONS.PRIMARY and position ~= ns.SPELL_POSITIONS.AOE then
                return true
            end
        end
    end

    return false
end
