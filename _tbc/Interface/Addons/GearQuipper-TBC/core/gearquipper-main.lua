-- scope stuff
gearquipper = gearquipper or {};
local c = gearquipper;

local switchId, switchQueue, switching, bankAction = 0, {};
local inCombat, interruptedByCombat, interruptedBySpell;

local lastRealmname, lastCharname;
local lastMountState, lastStealthState, lastPvPState, lastAfkState, lastPartyState, lastRaidState, lastSubmergedState;
local lastDruidForm, druidShapeshiftPending;
local lastRaidRoster, lastMapId;
local lastGearAndBagsCache;

local timeoutHighlightButtons = 1;
-- local timeoutCreateSpellbookCache = 3;
-- local timeoutEquipItemFromBank = 0.6;
-- local timeoutPushPullBank = 1;
-- local timeoutRefreshSetList = 0.25;
-- local timeoutUnitAura = 1;
-- local timeoutDruidShapeshift = 0.6;
-- local timeoutSpellcastEnd = 0.6;
-- local timeoutFinishSwitch = 1;

local BANKCONTAINER_BAGID_OFFSET = 47;

c.SWITCHARG_FIRST = "SWITCHARG_FIRST";
c.SWITCHARG_ID = "SWITCHARG_ID";
c.SWITCHARG_NOTIFY = "SWITCHARG_NOTIFY";
c.SWITCHARG_ONFINISHED = "SWITCHARG_ONFINISHED";
c.SWITCHARG_SETNAME = "SWITCHARG_SETNAME";

function c:GetCharName()
    return UnitName("player");
end

function c:GetRealmName()
    return GetRealmName();
end

local function GetNextSwitchId()
    switchId = switchId + 1;
    return switchId;
end

function c:NotifyInChat(msg)
    if GQ_OPTIONS[c.OPT_HIGHLIGHTCHANGES] then
        c:Println(msg);
    end
end

local function HighlightButton(button)
    if button then
        ActionButton_ShowOverlayGlow(button);
        C_Timer.After(timeoutHighlightButtons, function()
            ActionButton_HideOverlayGlow(button);
        end);
    end
end

function c:HighlightInventorySlot(slotId)
    if GQ_OPTIONS[c.OPT_HIGHLIGHTCHANGES] then
        if c:GetSlotInfo()[slotId] then
            HighlightButton(_G["Character" .. c:GetSlotInfo()[slotId]]);
        end
    end
end

function c:HighlightActionSlot(slotId)
    if GQ_OPTIONS[c.OPT_HIGHLIGHTCHANGES] then
        HighlightButton(c:GetActionButton(slotId));
    end
end

function c:IsSwitching()
    return switching;
end

-- command handling
SLASH_GEARQUIPPER1 = "/gq";
local CMD_DEBUG = "debug";
local CMD_RESET = "reset";
local CMD_SAVE = "save";
local CMD_SWITCH = "switch";
local CMD_SWITCHWAIT = "switchwait";
local CMD_TOGGLEEVENTS = "toggleevents";

local CMD_AFFECTSHELMET = "affectshelmet";
local CMD_AFFECTSCLOAK = "affectscloak";

SlashCmdList["GEARQUIPPER"] = function(msg)
    if msg then
        if c.initFinished then
            msg = c:Trim(msg);

            if msg == CMD_DEBUG then
                c.debugMode = not c.debugMode;
                if c.debugMode then
                    c:Println("Debug mode enabled. Type '/gq debug' or relog/reload to disable.");
                else
                    c:Println("Debug mode disabled.");
                end
                return;
            elseif msg == CMD_RESET then
                c:ShowResetDialog();
                return;
            elseif c:StartsWith(msg, CMD_SWITCHWAIT, true) then
                msg = c:Trim(msg:gsub(CMD_SWITCHWAIT, ""));

                if msg ~= "" then
                    local args = c:ExtractArguments(msg);

                    if args and table.getn(args) == 2 then
                        local setName, onFinished = args[1], args[2];

                        local existingSetName = c:TableContains(c:LoadSetNames(), setName, true);
                        if existingSetName then
                            c:QueueSwitch({
                                [c.SWITCHARG_SETNAME] = existingSetName,
                                [c.SWITCHARG_ONFINISHED] = onFinished
                            });
                            return;
                        else
                            c:Println(c:GetText("Macro warning: There is no set named \"%s\".", setName));
                        end
                    end
                end
            elseif c:StartsWith(msg, CMD_SWITCH, true) then
                msg = c:Trim(msg:gsub(CMD_SWITCH, ""));
                local existingSets, setNames = c:LoadSetNames(), {};

                if msg ~= "" then
                    for _, v in ipairs(c:ExtractArguments(msg)) do
                        if string.upper(v) == c.KEYWORD_PREVIOUS then
                            table.insert(setNames, c.KEYWORD_PREVIOUS);
                        elseif string.upper(v) == c.KEYWORD_PREVIOUSEQUIPMENT then
                            table.insert(setNames, c.KEYWORD_PREVIOUSEQUIPMENT);
                        else
                            local existingSetName = c:TableContains(existingSets, v, true);
                            if existingSetName then
                                table.insert(setNames, existingSetName);
                            else
                                c:Println(c:GetText("Macro warning: There is no set named \"%s\".", v));
                            end
                        end
                    end
                else
                    setNames = c:Deepcopy(existingSets);
                end

                local noSets = table.getn(setNames);
                if noSets == 1 then
                    c:QueueSwitch({
                        [c.SWITCHARG_SETNAME] = setNames[1]
                    });
                elseif noSets > 1 then
                    local currentSet = c:LoadCurrentSetName();
                    for k, v in ipairs(setNames) do
                        if v == currentSet then
                            local index = k + 1;
                            if index > noSets then
                                index = 1;
                            end
                            c:QueueSwitch({
                                [c.SWITCHARG_SETNAME] = setNames[index]
                            });
                            return;
                        end
                    end

                    c:ResetIgnoredSlots();
                    c:QueueSwitch({
                        [c.SWITCHARG_SETNAME] = setNames[1]
                    });
                end
                return;
            elseif c:StartsWith(msg, CMD_SAVE, true) then
                msg = c:Trim(msg:gsub(CMD_SAVE, ""));

                if msg ~= "" then
                    local existingSetName = c:TableContains(c:LoadSetNames(), msg, true);
                    if existingSetName then
                        c:SaveSet(existingSetName);
                    else
                        c:Println(c:GetText("Macro warning: There is no set named \"%s\".", msg));
                    end
                else
                    local currentSetName = c:LoadCurrentSetName();
                    if currentSetName then
                        c:SaveSet(currentSetName);
                    end
                end
                return;
            elseif msg == CMD_TOGGLEEVENTS then
                local newVal, text = not c:IsEventsEnabled();
                c:SetEventsEnabled(newVal);
                c:ToggleEvents(newVal);
                if newVal then
                    text = c:GetText("enabled");
                else
                    text = c:GetText("disabled");
                end
                c:Println(c:GetText("Event bindings %s.", text));
                return;
            elseif msg == CMD_AFFECTSHELMET then
                local setName = c:LoadCurrentSetName();
                c:SetAffectsHelmet(not c:GetAffectsHelmet(setName), setName);
                return;
            elseif msg == CMD_AFFECTSCLOAK then
                local setName = c:LoadCurrentSetName();
                c:SetAffectsCloak(not c:GetAffectsCloak(setName), setName);
                return;
            end

            c:Println(c:GetText("Unknown command. Possible parameters are: /gq ..."));
            c:Println(c:GetText("affectscloak -> Toggles whether your current set affects cloak visibility or not."));
            c:Println(c:GetText("affectshelmet -> Toggles whether your current set affects helmet visibility or not."));
            c:Println(c:GetText("reset -> Resets the GearQuipper addon (e.g. in case of errors)."));
            c:Println(c:GetText("save [setname] -> Saves the specified set or the current set if omitted."));
            c:Println(c:GetText("switch [setname1] [setname2] ... -> Switches between specified sets. For macro use."));
            c:Println(c:GetText("toggleevents -> Toggles event bindings enabled or disabled."));
        else
            c:Println(c:GetText("The AddOn has not been initialized due to an error. Please relog and try again."));
        end
    end
end

-- event handling
c.eventFrame = c.eventFrame or CreateFrame("Frame");
c.eventFrame:RegisterEvent("ADDON_LOADED");
c.eventFrame:RegisterEvent("PLAYER_LOGIN");
c.eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
c.eventFrame:RegisterEvent("CRAFT_SHOW");

-- event bindings
c.eventFrame:RegisterEvent("PLAYER_FLAGS_CHANGED");
c.eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
c.eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
c.eventFrame:RegisterEvent("SPELL_UPDATE_USABLE");
c.eventFrame:RegisterEvent("MIRROR_TIMER_START");
c.eventFrame:RegisterEvent("MIRROR_TIMER_STOP");
c.eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
c.eventFrame:RegisterEvent("ZONE_CHANGED");
c.eventFrame:RegisterEvent("ZONE_CHANGED_INDOORS");
c.eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
c.eventFrame:RegisterEvent("UNIT_AURA");
c.eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
c.eventFrame:RegisterEvent("RAID_ROSTER_UPDATE");

-- core features
c.eventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
c.eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
c.eventFrame:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
c.eventFrame:RegisterEvent("ITEM_LOCK_CHANGED");
c.eventFrame:RegisterEvent("ITEM_LOCKED");
c.eventFrame:RegisterEvent("ITEM_UNLOCKED");
c.eventFrame:RegisterEvent("BANKFRAME_OPENED");
c.eventFrame:RegisterEvent("BANKFRAME_CLOSED");

-- additional core features
c.eventFrame:RegisterEvent("PLAYER_LEVEL_UP");
c.eventFrame:RegisterEvent("LEARNED_SPELL_IN_TAB");
c.eventFrame:RegisterEvent("UPDATE_MACROS");

-- socketing (new in tbc classic)
if c:IsTBC() then
    c.eventFrame:RegisterEvent("SOCKET_INFO_SUCCESS");
    c.eventFrame:RegisterEvent("SOCKET_INFO_CLOSE");
end

-- c.eventFrame:RegisterEvent("UNIT_SPELLCAST_SENT");
-- c.eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");

c.eventFrame:HookScript("OnEvent", function(self, event, arg1, arg2, arg3, ...)
    if event then
        if c.initFinished then
            if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then
                c:DebugPrint(event, arg1, arg2, arg3, ...);
            end
        end

        if event == "ADDON_LOADED" and arg1 == "GearQuipper-TBC" and not c.initFinished then
            c:Init();
        elseif event == "PLAYER_LOGIN" then
            if GwCharacterWindow then
                -- GW2_UI support
                c:InitUI(GwCharacterWindow);
            end
        elseif event == "PLAYER_ENTERING_WORLD" then
            local currentRealmName, currentCharName = GetRealmName(), c:GetCharName();
            if not c.currentSession or c.currentSession["realmName"] ~= currentRealmName or c.currentSession["charName"] ~=
                currentCharName then
                c:CreateDefaultSet();
                c:CreatePreviousEquipmentSet();

                -- set initial states
                lastMountState = IsMounted() and not UnitOnTaxi("player");
                lastStealthState = IsStealthed();
                lastPartyState = IsInGroup();
                lastRaidState = IsInRaid();
                lastPvPState = UnitIsPVP("player");
                lastAfkState = UnitIsAFK("player");
                lastSubmergedState = IsSwimming();
                lastMapId = C_Map.GetBestMapForUnit("player");

                lastDruidForm = c:GetCurrentDruidForm();
                druidShapeshiftPending = false;

                c:GetMacros();
                c:LoadCloakAndHelmet();
                c.currentSession = {
                    ["realmName"] = currentRealmName,
                    ["charName"] = currentCharName
                };

                -- C_Timer.After(timeoutCreateSpellbookCache, function()
                --     c:GetSpellCache(); -- init spell id cache
                --     c:GetLearnedSpellNameAndRank(); -- init learned spells cache
                --     --c:Println(c:GetText("Spell database updated."));
                -- end);
            else
                local currentMountState = IsMounted() and not UnitOnTaxi("player");
                if currentMountState ~= lastMountState then
                    if currentMountState then
                        c:Mounting();
                    else
                        c:Dismounting();
                    end
                    lastMountState = currentMountState;
                end

                c:NewZone();
            end
        elseif event == "CRAFT_SHOW" then
            c:HookBlizzardFrameScripts();
        elseif event == "SOCKET_INFO_UPDATE" then
            if c.socketingAction then
                -- needs timeout
                C_Timer.After(c:GetHomeLatency(100 + GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000, function()
                    -- updated sockets -> save item if it is in set(s)
                    local newItemString;
                    if c:GetSlotInfo(c.socketingAction.bagOrCharacterSlotId) and not c.socketingAction.bagSlotId then
                        -- currently equipped item
                        newItemString = c:GetItemString(GetInventoryItemLink("player",
                            c.socketingAction.bagOrCharacterSlotId)); -- c:LoadSlot(c.socketingAction.bagOrCharacterSlotId);
                    elseif c.socketingAction.bagSlotId then
                        -- item in bag
                        newItemString = c:GetItemString(GetContainerItemLink(c.socketingAction.bagOrCharacterSlotId,
                            c.socketingAction.bagSlotId));
                    end

                    if newItemString then
                        c:ReplaceItemStringInAllSets(c.socketingAction.itemString, newItemString, true);
                    end
                end);
                c.eventFrame:UnregisterEvent("SOCKET_INFO_UPDATE");
            end
        elseif event == "SOCKET_INFO_SUCCESS" then
            c.eventFrame:RegisterEvent("SOCKET_INFO_UPDATE");
        elseif event == "SOCKET_INFO_CLOSE" then
            c.eventFrame:UnregisterEvent("SOCKET_INFO_UPDATE");
            c.socketingAction = nil;
        elseif event == "UNIT_INVENTORY_CHANGED" and arg1 == "player" then
            -- ammo slot workaround
            c:EquipmentChanged();
        elseif event == "PLAYER_EQUIPMENT_CHANGED" and arg1 ~= INVSLOT_AMMO then
            c:EquipmentChanged(arg1);
        elseif event == "ACTIONBAR_SLOT_CHANGED" then
            if not c:IsSwitching() and c:LoadActionSlotsOption() and arg1 and arg1 > 0 and arg1 < 121 and
                c:SaveConditionsMet(c.OPT_SAVECHANGES_ACTIONSLOTS) and (not totemic or not totemic:IsSwitching()) then
                c:SaveActionSlot(arg1);
            end
        elseif event == "PLAYER_LEVEL_UP" then
            c:LevelUp(arg1);
        elseif event == "LEARNED_SPELL_IN_TAB" then
            local spellId = arg1;
            local spellName, spellRank = c:GetSpellName(spellId), c:GetSpellSubText(spellId);
            c:DebugPrint("Learned:", spellName, spellRank);
            c:UprankSpellOnActionSlots(spellId);
        elseif event == "UPDATE_MACROS" then
            if c.initFinished then
                c:ProcessMacroUpdate();
            end
        elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
            -- pvp state change
            local currentPvPState = UnitIsPVP("player");
            if lastPvPState ~= currentPvPState then
                if currentPvPState then
                    c:HandleEvent(c.EVENT_PVP_ENABLE);
                else
                    c:HandleEvent(c.EVENT_PVP_DISABLE);
                end
                lastPvPState = currentPvPState;
            end

            local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName,
                destFlags, destRaidFlags, spellId, spellName, spellSchool = CombatLogGetCurrentEventInfo();
            c:DebugPrint(event, subevent, spellName, spellId);

            -- if sourceName == UnitName("player") then
            if subevent == "SPELL_CAST_START" then
                c:SpellCastStart(spellId);
            elseif subevent == "SPELL_CAST_SUCCESS" then
                c:SpellCastSuccess(spellId);
            elseif subevent == "SPELL_CAST_FAILED" or subevent == "SPELL_INTERRUPT" then
                c:SpellCastEnd();
            elseif subevent == "SPELL_AURA_APPLIED" then
                c:SpellAuraApplied(spellId);
            elseif subevent == "SPELL_AURA_REMOVED" then
                c:SpellAuraRemoved(spellId);
            elseif subevent == "ENCHANT_APPLIED" then
                C_Timer.After(c:GetHomeLatency(100 + GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000, function()
                    c:CheckForNewEnchantment();
                end);
            end
            -- end
        elseif event == "ITEM_LOCK_CHANGED" then
            if not c:IsInCombat() then
                lastGearAndBagsCache = c:CacheCurrentGearAndBags();
            end
        elseif event == "ITEM_LOCKED" then
            if not c:IsSwitching() and not bankAction then
                local bagOrCharacterSlotId, bagSlotId = tonumber(arg1), tonumber(arg2);
                if IsShiftKeyDown() and bagOrCharacterSlotId then
                    -- opened socketing frame
                    local itemString;
                    if c:GetSlotInfo(bagOrCharacterSlotId) and not bagSlotId then
                        -- currently equipped item
                        itemString = c:LoadSlot(bagOrCharacterSlotId);
                    elseif bagSlotId then
                        -- item in bag
                        itemString = c:GetItemString(GetContainerItemLink(bagOrCharacterSlotId, bagSlotId));
                    end

                    if itemString then
                        c.socketingAction = {
                            bagOrCharacterSlotId = bagOrCharacterSlotId,
                            bagSlotId = bagSlotId,
                            itemString = itemString
                        };
                    end
                elseif not bagSlotId and c:GetSlotInfo(bagOrCharacterSlotId) then
                    c:OpenQuickBar(bagOrCharacterSlotId);
                end
            end
        elseif event == "ITEM_UNLOCKED" then
            c:CloseQuickBars();
            if GqUiFrame:IsVisible() then
                c:RefreshSetList();
            end
        elseif event == "UNIT_AURA" then
            C_Timer.After(c:GetHomeLatency(GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000, function()
                local currentMountState, currentStealthState = IsMounted() and not UnitOnTaxi("player"), IsStealthed();
                if currentMountState ~= lastMountState then
                    if currentMountState then
                        c:Mounting();
                    else
                        c:Dismounting();
                    end
                    lastMountState = currentMountState;
                end
                if currentStealthState ~= lastStealthState then
                    if currentStealthState then
                        c:HandleEvent(c.EVENT_STEALTH);
                    else
                        c:HandleEvent(c.EVENT_UNSTEALTH);
                    end
                    lastStealthState = currentStealthState;
                end
            end);
        elseif event == "BANKFRAME_OPENED" or event == "BANKFRAME_CLOSED" then
            if GqUiFrame:IsVisible() then
                -- timeout neccessary for closing event
                C_Timer.After(c:GetLatency(GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000, function()
                    c:RefreshSetList(true);
                end);
            end
        elseif event == "PLAYER_REGEN_ENABLED" then
            c:LeaveCombat();
        elseif event == "PLAYER_REGEN_DISABLED" then
            c:EnterCombat();
        elseif event == "PLAYER_FLAGS_CHANGED" then
            local currentAfkState = UnitIsAFK("player");
            if lastAfkState ~= currentAfkState then
                if currentAfkState then
                    c:HandleEvent(c.EVENT_AFK_ENABLE);
                else
                    c:HandleEvent(c.EVENT_AFK_DISABLE);
                end
                lastAfkState = currentAfkState;
            end
        elseif event == "GROUP_ROSTER_UPDATE" or event == "RAID_ROSTER_UPDATE" then
            local currentPartyState, currentRaidState = IsInGroup(), IsInRaid();
            if lastPartyState ~= currentPartyState then
                if currentPartyState then
                    c:HandleEvent(c.EVENT_PARTY_JOIN);
                else
                    c:HandleEvent(c.EVENT_PARTY_LEAVE);
                end
                lastPartyState = currentPartyState;
            end

            if lastRaidState ~= currentRaidState then
                if currentRaidState then
                    c:HandleEvent(c.EVENT_RAID_JOIN);
                else
                    c:HandleEvent(c.EVENT_RAID_LEAVE);
                end
                lastRaidState = currentRaidState;
            end
        elseif c:StartsWith(event, "ZONE_CHANGED") then
            if c.firstZoneEntered then
                c:NewZone();
            else
                c.firstZoneEntered = true;
            end
        elseif event == "SPELL_UPDATE_USABLE" or "MIRROR_TIMER_START" or "MIRROR_TIMER_STOP" then
            local currentSubmergedState = IsSwimming();
            if lastSubmergedState ~= currentSubmergedState then
                if currentSubmergedState then
                    c:HandleEvent(c.EVENT_SUBMERGE);
                else
                    c:HandleEvent(c.EVENT_EMERGE);
                end
                lastSubmergedState = currentSubmergedState;
            end
        end
    end
end);

function c:EquipmentChanged(slotId)
    if not c:IsSwitching() then
        if not slotId then
            -- ammo slot workaround
            local previousAmmo, currentAmmo = c:LoadSlot(INVSLOT_AMMO, c.KEYWORD_PREVIOUSEQUIPMENT),
                c:GetItemString(INVSLOT_AMMO);
            if previousAmmo ~= currentAmmo then
                slotId = INVSLOT_AMMO;
            end
        end

        if slotId and c:GetSlotInfo()[slotId] and not c:IsSwitching() and not bankAction then
            local currentSetName = c:LoadCurrentSetName();
            if currentSetName then
                if c:SaveConditionsMet() and (not c:LoadPartialOption() or c:LoadSlotState(slotId)) and
                    (slotId == INVSLOT_AMMO or not c:IsSetItem(slotId, c:LoadSlot(slotId, currentSetName))) then
                    c:SaveSlot(slotId, currentSetName);
                elseif GQ_OPTIONS[c.OPT_IGNOREMANUALITEMS] then
                    c:AddIgnoredSlot(slotId);
                end

                c:SetSlotInfo(slotId);
            end
        end

        if slotId == INVSLOT_AMMO or not c:IsSetItem(slotId, c:LoadSlot(slotId, c.KEYWORD_PREVIOUSEQUIPMENT)) then
            c:SaveSlot(slotId, c.KEYWORD_PREVIOUSEQUIPMENT, false);
        end
    end
end

function c:HandleEvent(eventType, eventSubType)
    if eventType == c.EVENT_MOUNT then
        lastMountState = true;
    elseif eventType == c.EVENT_DISMOUNT then
        lastMountState = false;
    elseif eventType == c.EVENT_STEALTH then
        lastStealthState = true;
    elseif eventType == c.EVENT_UNSTEALTH then
        lastStealthState = false;
    end

    if c:IsEventsEnabled() then
        local filter = {
            [c.FIELD_TYPE] = eventType
        };
        if eventType == c.EVENT_ZONE_ENTER or eventType == c.EVENT_ZONE_LEAVE then
            filter[c.FIELD_SUBTYPE] = c:GetZoneInfo(eventSubType);
        elseif eventType == c.EVENT_SHAPESHIFT_IN or eventType == c.EVENT_SHAPESHIFT_OUT then
            -- druid shapes
            filter[c.FIELD_SUBTYPE] = {
                name = c:GetDruidForms()[eventSubType],
                spellId = eventSubType
            };
        elseif eventType == c.EVENT_AURA_CHANGED then
            -- paladin auras
            filter[c.FIELD_SUBTYPE] = {
                name = c:GetPaladinAuras()[eventSubType],
                spellId = eventSubType
            };
        elseif eventType == c.EVENT_STANCE_CHANGED then
            -- warrior stances
            filter[c.FIELD_SUBTYPE] = {
                name = c:GetWarriorStances()[eventSubType],
                spellId = eventSubType
            };
        end

        local setBindings = c:LoadEventBindings(filter);
        if setBindings then
            local currentPvPState = UnitIsPVP("player");
            for index, binding in pairs(setBindings) do
                if (binding[c.FIELD_ENABLED] == nil or binding[c.FIELD_ENABLED]) and
                    (binding[c.FIELD_PVE] and not currentPvPState) or (binding[c.FIELD_PVP] and currentPvPState) then
                    c:QueueSwitch({
                        [c.SWITCHARG_SETNAME] = binding[c.FIELD_NAME]
                    });
                    return;
                end
            end
        end
    end
end

function c:Mounting()
    c:HandleEvent(c.EVENT_MOUNT);
    -- CastSpell(32223, "spell");
    -- check for crusader aura
    -- if GQ_OPTIONS[c.OPT_MOUNTING_CRUSADER_AURA] and not select(2, c:GetCurrentBuffs())[32223] then

    -- end

    -- will probably not work :/
end

function c:Dismounting()
    c:HandleEvent(c.EVENT_DISMOUNT);
end

function c:NewZone()
    local currentMapId = C_Map.GetBestMapForUnit("player");
    if currentMapId ~= lastMapId then
        if lastMapId then
            -- leave bg
            if c:IsZoneBattleground(lastMapId) then
                c:HandleEvent(c.EVENT_BG_LEAVE);
            end

            -- leave zone
            local lastParentMapId = c:GetZoneInfo(lastMapId)["parentMapId"];
            if lastParentMapId and lastParentMapId ~= 947 then
                -- leave parent zone
                c:HandleEvent(c.EVENT_ZONE_LEAVE, lastParentMapId);
            end
            c:HandleEvent(c.EVENT_ZONE_LEAVE, lastMapId);
        end
        lastMapId = currentMapId;

        if currentMapId then
            -- enter bg
            if c:IsZoneBattleground(currentMapId) then
                c:HandleEvent(c.EVENT_BG_ENTER);
            end

            -- enter zone
            local currentParentMapId = c:GetZoneInfo(currentMapId)["parentMapId"];
            if currentParentMapId and currentParentMapId ~= 947 then
                -- enter parent zone
                c:HandleEvent(c.EVENT_ZONE_ENTER, currentParentMapId);
            end
            c:HandleEvent(c.EVENT_ZONE_ENTER, currentMapId);
        end
    end
end

function c:GetCurrentDruidForm()
    local druidForms = c:GetDruidForms();
    for _, spellId in pairs(c:GetCurrentBuffs()) do
        if druidForms[spellId] then
            return spellId;
        end
    end
    return c.VALUE_NONE;
end

function c:EnterCombat()
    inCombat = true;
    c:LockUI();
end

function c:LeaveCombat()
    inCombat = false;
    lastGearAndBagsCache = nil;
    c:HandleEvent(c.EVENT_COMBAT_LEAVE);

    if table.getn(switchQueue) > 0 then
        c:RequeueFirst();
    elseif not c:IsSwitching() then
        c:UnlockUI();
    end
end

function c:IsInCombat()
    return InCombatLockdown() or inCombat;
end

function c:IsOnBattleground()
    local bgPosition = UnitInBattleground("player");
    if not bgPosition then
        return false;
    end
    return bgPosition;
end

function c:IsCastingSpell()
    local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, spellId = CastingInfo();
    return name;
end

function c:SpellCastStart(spellId)
    if not c:IsInCombat() then
        lastGearAndBagsCache = c:CacheCurrentGearAndBags();
    end
end

function c:SpellCastSuccess(spellId)
    -- check for enchanted items
    if not c:IsInCombat() then
        C_Timer.After(c:GetHomeLatency(100 + GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000, function()
            c:CheckForNewEnchantment();
        end);
    end

    -- check for paladin aura event
    if c:GetPaladinAuras()[spellId] then
        c:HandleEvent(c.EVENT_AURA_CHANGED, spellId);
    end

    -- check for warrior stance event
    if c:GetWarriorStances()[spellId] then
        c:HandleEvent(c.EVENT_STANCE_CHANGED, spellId);
    end
    c:SpellCastEnd();
end

function c:SpellAuraApplied(spellId)
    c:CheckDruidFormChanged(c.EVENT_SHAPESHIFT_IN);
end

function c:SpellAuraRemoved(spellId)
    if c:GetPaladinAuras()[spellId] then
        -- workaround for "no paladin aura"
        c:HandleEvent(c.EVENT_AURA_CHANGED, c.VALUE_NONE);
    elseif c:GetDruidForms()[spellId] then
        -- druid shapeshift
        c:CheckDruidFormChanged(c.EVENT_SHAPESHIFT_OUT);
    end
end

function c:SpellCastEnd()
    if not c:IsInCombat() then
        C_Timer.After(c:GetHomeLatency(100 + GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000, function()
            -- if not c:IsSwitching() and not c:IsInCombat() and not c:IsCastingSpell() then
            if table.getn(switchQueue) > 0 then
                c:RequeueFirst();
            elseif not c:IsSwitching() then
                c:UnlockUI();
            end
            -- end
        end);
    end
end

function c:CheckDruidFormChanged(eventType)
    c:DebugPrint("CheckDruidFormChanged", eventType);

    if not druidShapeshiftPending then
        druidShapeshiftPending = true;

        C_Timer.After(c:GetHomeLatency(GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000, function()
            local currentFormSpellId = c:GetCurrentDruidForm();
            if currentFormSpellId ~= lastDruidForm then
                c:DebugPrint("lastform, currentform: ", lastDruidForm, currentFormSpellId);
                c:HandleEvent(c.EVENT_SHAPESHIFT_OUT, lastDruidForm);
                c:HandleEvent(c.EVENT_SHAPESHIFT_IN, currentFormSpellId);
                lastDruidForm = currentFormSpellId;
            end
            druidShapeshiftPending = false;
        end);
    end
end

function c:CheckForNewEnchantment()
    if not c:IsInCombat() and lastGearAndBagsCache then
        local cacheType, bagId, slotId, oldItemString, newItemString = c:GetFirstChangedItem(lastGearAndBagsCache);
        c:DebugPrint("CheckForNewEnchantment", cacheType, bagId, slotId, oldItemString, newItemString);

        -- check for equal item names in case player moved items while another player casted the enchantment - just to be sure
        if oldItemString and newItemString then
            c:ReplaceItemStringInAllSets(oldItemString, newItemString, true);
        end
    end
end

function c:FinishSwitch(switchArgs)
    if c:IsSetComplete(switchArgs[c.SWITCHARG_SETNAME]) and GQ_OPTIONS[c.OPT_NOTIFYQUEUES] then
        if interruptedByCombat then
            c:Println(c:GetText("Combat ended. Switch to set \"%s\" complete.", switchArgs[c.SWITCHARG_SETNAME]));
        elseif interruptedBySpell then
            c:Println(c:GetText("Action finished. Switch to set \"%s\" complete.", switchArgs[c.SWITCHARG_SETNAME]));
        end
    end
    c:ResetIgnoredSlots();
    interruptedByCombat = false;
    interruptedBySpell = false;

    if table.getn(switchQueue) > 0 then
        local nextSet = table.remove(switchQueue, 1);
        c:SwitchToSet(nextSet);
    else
        C_Timer.After(c:GetHomeLatency(500 + GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000, function()
            c:LoadCloakAndHelmet(switchArgs[c.SWITCHARG_SETNAME]);
            c:UpdateBroker();
            c:UnlockUI();
            if c.paperDollFrame:IsVisible() then
                c:SetPaperDollLabelText();
                c:SetSlotInfo();
                c:ShowSlotStateBoxes();
                c:RefreshSetList(switchArgs[c.SWITCHARG_SETNAME]);

                if switchArgs[c.SWITCHARG_ONFINISHED] and strlen(switchArgs[c.SWITCHARG_ONFINISHED]) > 0 then
                    RunMacroText(switchArgs[c.SWITCHARG_ONFINISHED]);
                end
            end

            CloseDropDownMenus();
            PlaySound(1264);

            switching = nil;
        end);
    end
end

function c:QueueSwitch(switchArgs)
    -- for simple set name string call
    if (type(switchArgs) == "string") then
        switchArgs = {
            [c.SWITCHARG_SETNAME] = switchArgs
        };
    end

    -- complex call
    if switchArgs then
        switchArgs[c.SWITCHARG_ID] = GetNextSwitchId();
        if not c:IsSwitching() and not c:IsInCombat() and not c:IsCastingSpell() then
            -- switch immediately
            c:SwitchToSet(switchArgs);
            return;
        end

        -- queue switch
        if switchArgs[c.SWITCHARG_FIRST] and (not switchQueue[1] or switchQueue[1] ~= setName) then
            -- as first (priority) switch
            local tmp = c:Deepcopy(switchQueue);
            switchQueue = {switchArgs};
            for _, set in ipairs(tmp) do
                tinsert(switchQueue, set);
            end
        elseif not c:IsSetLastQueued(switchArgs[c.SWITCHARG_SETNAME]) then
            -- normal queue
            tinsert(switchQueue, switchArgs);
        else
            -- dont queue if already queued last
            return;
        end

        if switchArgs[c.SWITCHARG_NOTIFY] == nil or switchArgs[c.SWITCHARG_NOTIFY] then
            if switchArgs[c.SWITCHARG_SETNAME] == c.KEYWORD_PREVIOUS then
                switchArgs[c.SWITCHARG_SETNAME] = c:LoadPreviousSetName();
            end

            if GQ_OPTIONS[c.OPT_NOTIFYQUEUES] then
                c:Println(c:GetText("Switch to \"%s\" queued.", switchArgs[c.SWITCHARG_SETNAME]));
            end

            if c:IsInCombat() then
                interruptedByCombat = true;
            elseif c:IsCastingSpell() then
                interruptedBySpell = true;
            end
        end
    end
end

function c:RequeueFirst()
    -- when combat ends etc.
    -- essentially equals "start working on queue again"
    local nextSet = table.remove(switchQueue, 1);
    nextSet[c.SWITCHARG_FIRST] = true;
    nextSet[c.SWITCHARG_NOTIFY] = false;
    c:QueueSwitch(nextSet);
end

function c:IsSetQueued(setName)
    if setName then
        for _, switchArgs in ipairs(switchQueue) do
            if switchArgs[c.SWITCHARG_SETNAME] == setName then
                return true;
            end
        end
    end
end

function c:IsSetLastQueued(setName)
    if setName then
        local queuedSets = table.getn(switchQueue);
        if queuedSets > 0 then
            local lastQueuedSet = switchQueue[queuedSets];
            if lastQueuedSet and lastQueuedSet[c.SWITCHARG_SETNAME] == setName then
                return true;
            end
        end
    end
end

function c:SwitchToSet(switchArgs)
    if switchArgs then
        local setName = switchArgs[c.SWITCHARG_SETNAME];
        if setName == c.KEYWORD_PREVIOUS then
            setName = c:LoadPreviousSetName();
        end

        setName = c:TableContains(c:LoadSetNames(true), setName, true); -- case insensitive
        if setName then
            local desiredSet = c:LoadSet(setName);
            -- c:SaveSet(c.KEYWORD_PREVIOUSEQUIPMENT, false); -- unneccessary?

            local freeSpace, neededSpace, bagSpaceCache = c:CheckNeccessaryBagSpace(setName);
            if neededSpace > freeSpace then
                c:Println(c:GetText("Not enough bag space. Current space: %s, needed: %s", freeSpace, neededSpace));
                c:RefreshSetList();
            else
                switching = setName;
                CloseMerchant();
                c:LockUI(setName);
                PlaySound(1264);

                for _, slotId in ipairs(c:GetSlotSwitchOrder()) do
                    local desiredItemString = desiredSet[slotId];

                    if not c:IsSetItem(slotId, desiredItemString) and
                        (not c:LoadPartialOption(setName) or c:LoadSlotState(slotId, setName)) and
                        (not GQ_OPTIONS[c.OPT_IGNOREMANUALITEMS] or not c:IsIgnoredItem(slotId)) then

                        if c:IsInCombat() then
                            -- breaks loop if combat starts
                            if GQ_OPTIONS[c.OPT_NOTIFYQUEUES] then
                                c:Println(c:GetText(
                                    "Switching interrupted by combat. It will be re-attempted once combat is over."));
                            end
                            c:QueueSwitch({
                                [c.SWITCHARG_SETNAME] = setName,
                                [c.SWITCHARG_FIRST] = true
                            });
                            c:RefreshSetList();
                            interruptedByCombat = true;
                            return;
                        end

                        if c:IsCastingSpell() then
                            -- breaks loop if spell cast starts
                            if GQ_OPTIONS[c.OPT_NOTIFYQUEUES] then
                                c:Println(c:GetText(
                                    "Switching interrupted by action. It will be re-attempted once the action is finished."));
                            end
                            c:QueueSwitch({
                                [c.SWITCHARG_SETNAME] = setName,
                                [c.SWITCHARG_FIRST] = true
                            });
                            c:RefreshSetList();
                            interruptedBySpell = true;
                            return;
                        end

                        if c:IsEmpty(desiredItemString) then
                            if not c:UnequipItem(slotId, bagSpaceCache, c:GetItemString(slotId)) then
                                return;
                            end
                        else
                            -- prevents mh/oh swapping issues
                            if (slotId == INVSLOT_MAINHAND and c:GetItemString(INVSLOT_OFFHAND) == desiredItemString) then
                                if not c:UnequipItem(slotId, bagSpaceCache, c:GetItemString(INVSLOT_MAINHAND)) then
                                    return;
                                end
                            end

                            -- equip item
                            local itemLink = c:GetItemLink(desiredItemString);
                            if itemLink then
                                local bagId, bagSlotId = c:FindItemInBags(desiredItemString);

                                if not bagId and c:IsAtBank() then
                                    -- item not in bag -> check in bank
                                    if c:GetItemFromBank(c:GetItemString(itemLink), bagSpaceCache) then
                                        C_Timer.After(c:GetHomeLatency(100 + GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000,
                                            function()
                                                c:EquipItem(slotId, itemLink, bagSpaceCache);
                                            end);
                                    end
                                else
                                    c:EquipItem(slotId, itemLink, bagSpaceCache);
                                end
                            end
                        end

                        if GQ_OPTIONS[c.OPT_HIGHLIGHTCHANGES] then
                            c:HighlightInventorySlot(slotId);
                        end
                    end
                end

                if setName ~= c.KEYWORD_PREVIOUSEQUIPMENT then
                    if c:LoadActionSlotsOption(setName) then
                        c:LoadActionConfiguration(setName);
                    end
                    c:SaveCurrentSetName(setName);
                else
                    if c:LoadActionSlotsOption(c:LoadPreviousSetName()) then
                        c:LoadActionConfiguration(c:LoadPreviousSetName());
                    end
                    c:SaveCurrentSetName(c:LoadPreviousSetName());
                end

                c:FinishSwitch(switchArgs);
                return true;
            end
        end
    end
end

function c:UnequipItem(slotId, bagSpaceCache, itemString)
    ClearCursor();
    PickupInventoryItem(slotId);
    if not c:PutInBag(bagSpaceCache, itemString) then
        c:Println(c:GetText("Not enough bag space. Switching aborted."));
        c:RefreshSetList();
        switching = nil;
        c:UnlockUI();
        return false;
    end
    ClearCursor();
    return true;
end

function c:EquipItem(slotId, itemLink, bagSpaceCache)
    local itemString = c:GetItemString(itemLink);
    local bagId, bagSlotId = c:FindItemInBags(itemString);
    if bagId then
        c:SaveLastBagLocation(itemString, bagId, bagSlotId);
        if c:IsEmpty(slotId) then
            bagSpaceCache[bagId] = bagSpaceCache[bagId] + 1;
        end
    end

    if slotId == 0 then
        -- ammo workaround
        EquipItemByName(itemLink);
    else
        EquipItemByName(itemLink, slotId);
    end
end

function c:LoadActionConfiguration(setName)
    local actionSlots = c:LoadActionSlots(setName);
    for slotId, entry in pairs(actionSlots) do
        if slotId > 0 and slotId < 121 and entry and not c:IsSameAction(slotId, entry) then
            if c:IsInCombat() then
                -- breaks loop if combat starts
                if GQ_OPTIONS[c.OPT_NOTIFYQUEUES] then
                    c:Println(c:GetText("Switching interrupted by combat. It will be re-attempted once combat is over."));
                end
                c:QueueSwitch({
                    [c.SWITCHARG_SETNAME] = setName,
                    [c.SWITCHARG_FIRST] = true
                });
                interruptedByCombat = true;
                return;
            end

            ClearCursor();
            PickupAction(slotId);
            ClearCursor();

            if not c:IsEmpty(entry) then
                if entry[c.FIELD_TYPE] == "spell" then
                    PickupSpell(entry[c.FIELD_ID]);
                elseif entry[c.FIELD_TYPE] == "item" then
                    PickupItem(entry[c.FIELD_ID]);
                elseif entry[c.FIELD_TYPE] == "macro" then
                    PickupMacro(GetMacroIndexByName(entry[c.FIELD_ID]));
                end

                PlaceAction(slotId);
                ClearCursor();
            end

            c:HighlightActionSlot(slotId);
        end
    end

    return true;
end

function c:PutInBag(bagSpaceCache, itemString)
    if itemString then
        local lastBagId = c:LoadLastBagLocation(itemString);
        if lastBagId and bagSpaceCache[lastBagId] and bagSpaceCache[lastBagId] > 0 and
            c:PutInBackpack(bagSpaceCache, lastBagId) then
            return true;
        end
    end

    local bagIdsSorted = {};
    for bagId, freeSlots in pairs(bagSpaceCache) do
        tinsert(bagIdsSorted, bagId);
    end
    table.sort(bagIdsSorted);

    for _, bagId in ipairs(bagIdsSorted) do
        if bagSpaceCache[bagId] > 0 then
            return c:PutInBackpack(bagSpaceCache, bagId);
        end
    end
end

function c:PutInBackpack(bagSpaceCache, bagId)
    if CursorHasItem() then
        if bagId == 0 then
            PutItemInBackpack();
        else
            PutItemInBag(ContainerIDToInventoryID(bagId));
        end

        if not CursorHasItem() then
            bagSpaceCache[bagId] = bagSpaceCache[bagId] - 1;
            return true;
        end
    end
end

function c:PutInBank(bankSpaceCache, itemString)
    if itemString then
        local lastBagId, lastSlotId = c:LoadLastBankLocation(itemString);
        if lastBagId then
            if not lastSlotId and bankSpaceCache[lastBagId] > 0 then
                PutItemInBag(lastBagId);
                bankSpaceCache[lastBagId] = bankSpaceCache[lastBagId] - 1;
                return;
            else
                local invId = ContainerIDToInventoryID(lastBagId);
                if bankSpaceCache[invId] > 0 then
                    PutItemInBag(invId);
                    bankSpaceCache[invId] = bankSpaceCache[invId] - 1;
                    return;
                end
            end
        end
    end

    local invIdsSorted = {};
    for invId, freeSlots in pairs(bankSpaceCache) do
        tinsert(invIdsSorted, invId);
    end
    table.sort(invIdsSorted);

    for _, invId in ipairs(invIdsSorted) do
        if bankSpaceCache[invId] > 0 then
            PutItemInBag(invId);
            bankSpaceCache[invId] = bankSpaceCache[invId] - 1;
            return;
        end
    end
end

function c:PushSetToBank(setName)
    if setName and not bankAction then
        local error = false;
        local freeSpace, items, bankSpaceCache = c:CheckNeccessaryPushSpace(setName);
        if freeSpace >= c:GetTableSize(items) then
            CloseMerchant();
            bankAction = "push";
            for slotId, itemString in pairs(items) do
                if not c:LoadPartialOption(setName) or c:LoadSlotState(slotId, setName) then
                    ClearCursor();

                    if c:IsSetItem(slotId, itemString) then
                        PickupInventoryItem(slotId);
                    else
                        local bagId, bagSlotId = c:FindItemInBags(itemString);
                        if bagId then
                            PickupContainerItem(bagId, bagSlotId);
                        end
                    end

                    if CursorHasItem() then
                        c:PutInBank(bankSpaceCache, itemString);
                    else
                        c:Println(c:GetText("%s could not be pushed to bank.", c:GetItemLink(itemString)));
                        error = true;
                    end
                end
            end

            C_Timer.After(c:GetLatency(1000 + GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000, function()
                c:SetSlotInfo();
                bankAction = nil;
            end);

            if error then
                c:Println(c:GetText("Set \"%s\" was incompletely pushed to bank.", setName));
            end
            return not error;
        else
            c:Println(c:GetText("Not enough bank space to push \"%s\" to bank. Free: %s, needed: %s.", setName,
                freeSpace, c:GetTableSize(items)));
        end
    end
end

function c:PullSetFromBank(setName)
    if setName and not bankAction then
        local error = false;
        local freeSpace, items, bagSpaceCache = c:CheckNeccessaryPullSpace(setName);
        if freeSpace >= c:GetTableSize(items) then
            CloseMerchant();
            bankAction = "pull";
            for slotId, itemString in pairs(items) do
                if not c:LoadPartialOption(setName) or c:LoadSlotState(slotId, setName) then
                    if not c:GetItemFromBank(itemString, bagSpaceCache) then
                        c:Println(c:GetText("%s could not be pulled from bank.", c:GetItemLink(itemString)));
                        error = true;
                    end
                end
            end

            C_Timer.After(c:GetLatency(1000 + GQ_OPTIONS[c.OPT_SWITCHDELAY]) / 1000, function()
                c:SetSlotInfo();
                bankAction = nil;
            end);

            if error then
                c:Println(c:GetText("Set \"%s\" was incompletely pulled from bank.", setName));
            end
            return not error;
        else
            c:Println(c:GetText("Not enough bag space to pull \"%s\" from bank. Free: %s, needed: %s.", setName,
                freeSpace, c:GetTableSize(items)));
        end
    end
end

function c:GetItemFromBank(itemString, bagSpaceCache)
    ClearCursor();

    local bagId, bagSlotId = c:FindItemInBank(itemString);
    if bagId then
        c:SaveLastBankLocation(itemString, bagId, bagSlotId);
        if not bagSlotId then
            PickupContainerItem(-1, bagId - BANKCONTAINER_BAGID_OFFSET);
        else
            PickupContainerItem(bagId, bagSlotId);
        end
    end

    if CursorHasItem() then
        return c:PutInBag(bagSpaceCache, itemString);
    end
end
