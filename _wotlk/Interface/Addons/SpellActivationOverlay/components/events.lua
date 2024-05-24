local AddonName, SAO = ...
local Module = "events"

-- Optimize frequent calls
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local GetSpellInfo = GetSpellInfo
local UnitGUID = UnitGUID

-- Events starting with SPELL_AURA e.g., SPELL_AURA_APPLIED
-- This should be invoked only if the buff is done on the player i.e., UnitGUID("player") == destGUID
function SAO.SPELL_AURA(self, ...)
    local _, event, _, _, _, _, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo();

    --[[ Aura event chart

    For un-stackable auras:
    - "SPELL_AURA_APPLIED" = buff is being applied now
    - "SPELL_AURA_REMOVED" = buff is being removed now

    For stackable auras:
    - "SPELL_AURA_APPLIED" = first stack applied
    - "SPELL_AURA_APPLIED_DOSE" = second stack applied or beyond
    - "SPELL_AURA_REMOVED_DOSE" = removed a stack, but there is at least one stack left
    - "SPELL_AURA_REMOVED" = removed last remaining stack

    For any aura:
    - "SPELL_AURA_REFRESH" = buff is refreshed, usually the remaining time is reset to its max duration
    ]]
    local auraApplied = event:sub(0,18) == "SPELL_AURA_APPLIED"; -- includes "SPELL_AURA_APPLIED" and "SPELL_AURA_APPLIED_DOSE"
    local auraRemovedLast = event == "SPELL_AURA_REMOVED";
    local auraRemovedDose = event == "SPELL_AURA_REMOVED_DOSE";
    local auraRefresh = event == "SPELL_AURA_REFRESH";
    if not auraApplied and not auraRemovedLast and not auraRemovedDose and not auraRefresh then
        return; -- Not an event we're interested in
    end

    -- Use the game's aura from CLEU to find its corresponding aura item in SAO, if any
    local auras;
    if not self.IsEra() then
        auras = self.RegisteredAurasBySpellID[spellID];
    else
        -- Due to Classic Era limitation, aura is registered by its spell name
        auras = self.RegisteredAurasBySpellID[spellName];
        if (auras) then
            -- Must fetch spellID from aura, because spellID from CLEU is most likely 0 at this point
            -- We can fetch any aura from auras because all auras store the same spellID
            for _, auraStacks in pairs(auras) do
                spellID = auraStacks[1][3]; -- [1] for first aura in auraStacks, [3] because spellID is the third item
                break;
            end
        end
    end
    if not auras then
        -- This spell is not tracked by SAO
        return;
    end

    local count = 0; -- Number of stacks of the aura, unless the aura is count-agnostic (see below)
    local countAgnostic; -- Flag to tell that we don't care what is the exact stack count
    if auras[0] then
        -- An aura which defined stacks == 0 means the aura is count-agnostic
        -- What matters is whether or not the buff is found, independently of its number of stacks
        -- Please note, count-agnostic auras may or may not be stackable, they just don't care about the number of stacks, if any
        countAgnostic = true;
    else
        -- If there is no aura with stacks == 0, this must mean that this aura is stackable
        -- Unlike count-agnostic auras, non-count-agnostic auras are *always* stackable
        countAgnostic = false;
        -- To handle stackable auras, we must find the aura (ugh!) to get its number of stacks
        -- In an ideal world, we'd use a stack count from the combat log which, unfortunately, is unavailable
        if event ~= "SPELL_AURA_REMOVED" then -- No need to find aura with complete removal: the buff is not there anymore
            count = select(3, self:FindPlayerAuraByID(spellID)) or 0;
        end
    end

    --[[ Check if the spell is currently displayed, and if yes, with which count
    Reminder: returned count will always be zero if tracking a count-agnostic aura
    Possible values:
    - 1 or more, if the aura is displayed and it is a stackable aura, in which case the value indicates the number of stacks
    - 0, if the aura is displayed and either the aura is not stackable or the effect is count-agnostic
    - nil, if the aura is not displayed
    ]]
    local displayedCount = self:GetAuraMarker(spellID);
    local isDisplayed = displayedCount ~= nil;

    -- Handle unique case first: aura refresh
    if (auraRefresh) then
        if (
            -- Aura is already visible
            (isDisplayed)
        and
            -- The number of stacks is supported
            (auras[count])
        ) then
            -- Reactivate aura timer
            self:RefreshAura(spellID);
        end

        -- Can return now, because SPELL_AURA_REFRESH is used only to refresh timer
        return;
    end

    -- Now, we are in a situation where either we got a buff (SPELL_AURA_APPLIED*) or lost it (SPELL_AURA_REMOVED*)

    -- Check if we should activate the aura effect
    if (not isDisplayed) then
        if (
        --[[ Aura is enabled, either because:
        - it was added now (SPELL_AURA_APPLIED)
        - or was upgraded (SPELL_AURA_APPLIED_DOSE)
        - or was downgraded but still visible (SPELL_AURA_REMOVED_DOSE)
        ]]
            (auraApplied or auraRemovedDose)
        and
            -- The number of stacks is supported
            (auras[count])
        ) then
            -- Activate aura
            self:DisplayAllAuras(spellID, count, auras[count]);
        end

        -- Can return now, because a non-displayed is either displayed now, or nothing can be done with it
        return;
    end

    --[[ At this point:
    - isDisplayed == true, meaning the aura is currently displayed on screen
    - displayedCount equals to either:
      - 0 for count-agnostic auras
      - otherwise, the number of currently displayed stacks
    ]]

    if (countAgnostic) then
        if (
            -- The aura is completely removed (SPELL_AURA_REMOVED)
            (auraRemovedLast)
        ) then
            -- Aura just disappeared completely
            -- For count-agnostic aura, it does not matter which count it came from, if the aura is missing: hide it
            self:UndisplayAura(spellID);
        end

        -- Can return now: count-agnostic auras of displayed auras are either un-displayed, or nothing can be done with it
        return;
    end

    if (
        -- Number of stacks changed
        (displayedCount ~= count)
    and
        -- The new stack count allows it to be visible
        (auraApplied or auraRemovedDose)
    and
        -- The number of stacks is supported
        (auras[count])
    ) then
        -- Deactivate old aura and activate the new one
        self:ChangeAuraCount(spellID, displayedCount, count, auras[count]);
        return;
    end

    if (
        --[[ The aura should not be visible, either because:
        - the aura is completely removed (SPELL_AURA_REMOVED)
        - or the aura has changed stacks to an unsupported stack count
        ]]
        (auraRemovedLast or ((auraApplied or auraRemovedDose) and displayedCount ~= count and not auras[count]))
    ) then
        -- Aura just disappeared or is not supported for this number of stacks
        self:UndisplayAura(spellID);
    end
end

-- The (in)famous CLEU event
function SAO.COMBAT_LOG_EVENT_UNFILTERED(self, ...)
    local _, event, _, _, _, _, _, destGUID = CombatLogGetCurrentEventInfo();

    if ( (event:sub(0,11) == "SPELL_AURA_") and (destGUID == UnitGUID("player")) ) then
        self:SPELL_AURA(...);
    end
end

local arePendingEffectsRegistered = false;
function SAO.LOADING_SCREEN_DISABLED(self, ...)
    -- Register effects right after the loading screen ends
    -- Initially, this was called after PLAYER_LOGIN
    -- But in some situations, PLAYER_LOGIN is "too soon" to be able to use the game's glow engine
    if not arePendingEffectsRegistered then
        arePendingEffectsRegistered = true;
        self:RegisterPendingEffectsAfterPlayerLoggedIn();
    end

    -- Check if auras are still there after a loading screen
    -- This circumvents a limitation of the CLEU which may not trigger during a loading screen
    for spellID, stacks in pairs(self.ActiveOverlays) do
        if not self:IsFakeSpell(spellID) and not self:FindPlayerAuraByID(spellID) then
            self:DeactivateOverlay(spellID);
            self:RemoveGlow(spellID);
        end
    end
end

function SAO.PLAYER_ENTERING_WORLD(self, ...)
    C_Timer.NewTimer(1, function() self:CheckAllCounterActions() end);
end

function SAO.SPELL_UPDATE_USABLE(self, ...)
    self:CheckAllCounterActions();
end

function SAO.PLAYER_REGEN_ENABLED(self, ...)
    self:CheckAllCounterActions(true);
end

function SAO.PLAYER_REGEN_DISABLED(self, ...)
    self:CheckAllCounterActions(true);
end

-- Specific spellbook update
function SAO.SPELLS_CHANGED(self, ...)
    for glowID, _ in pairs(self.RegisteredGlowSpellNames) do
        self:RefreshSpellIDsByName(glowID, true);
    end
end

-- Specific spell learned
function SAO.LEARNED_SPELL_IN_TAB(self, ...)
    local spellID, skillInfoIndex, isGuildPerkSpell = ...;
    self:LearnNewSpell(spellID);
end

-- Event receiver
function SAO.OnEvent(self, event, ...)
    if self[event] then
        self[event](self, ...);
    end
    self:InvokeClassEvent(event, ...)
end
