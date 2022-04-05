-- scope stuff
gearquipper = gearquipper or {};
local c = gearquipper;

local slotStateBoxes;
local secureActionButtons = {};

c.MACROACTION_NEW = "MACROACTION_NEW";
c.MACROACTION_EDIT = "MACROACTION_EDIT";
c.MACROACTION_DELETE = "MACROACTION_DELETE";

----- general ui stuff -----

function c:InitUI(paperDollFrame)
    if paperDollFrame then
        c.paperDollFrame = paperDollFrame;
        c.paperDollFrame.paperDollButton = c.paperDollFrame.paperDollButton or c:CreatePaperDollButton();
        c.paperDollFrame.paperDollLabel = c.paperDollFrame.paperDollLabel or c:CreatePaperDollLabel();

        c.paperDollFrame:HookScript("OnShow", function()
            if GQ_OPTIONS[c.OPT_MENUOPEN] then
                c:ToggleUI(true);
            end
            c:SetSlotInfo();
            c:SetPaperDollLabelText();

            if c:IsSwitching() or c:IsInCombat() then
                c:LockUI();
            else
                c:UnlockUI();
            end
        end);
        c.paperDollFrame:HookScript("OnHide", function()
            GQ_OPTIONS[c.OPT_MENUOPEN] = GqUiFrame.isOpen;
            c:CloseQuickBars();
        end);
        InterfaceOptionsFrameOkay:HookScript("OnClick", function(self)
            c:SaveCloakAndHelmet();
        end);

        GameMenuButtonMacros:HookScript("OnClick", function()
            if not MacroFrame.gearQuipperHooked then
                MacroNewButton:HookScript("OnClick", function()
                    c.macroAction = {
                        [c.FIELD_NAME] = c.MACROACTION_NEW,
                        [c.FIELD_TYPE] = MacroFrame.selectedTab
                    };
                end);
                MacroEditButton:HookScript("OnClick", function()
                    c.macroAction = {
                        [c.FIELD_NAME] = c.MACROACTION_EDIT,
                        [c.FIELD_TYPE] = MacroFrame.selectedTab,
                        [c.FIELD_ID] = MacroFrame.selectedMacro
                    };
                end);
                MacroDeleteButton:HookScript("OnClick", function()
                    c.macroAction = {
                        [c.FIELD_NAME] = c.MACROACTION_DELETE,
                        [c.FIELD_TYPE] = MacroFrame.selectedTab,
                        [c.FIELD_ID] = MacroFrame.selectedMacro
                    };
                end);
                MacroFrame.gearQuipperHooked = true;
            end
        end);

        GameTooltip:HookScript("OnTooltipSetItem", function(self)
            if GQ_OPTIONS[c.OPT_SHOWITEMTOOLTIP] and self and self:GetOwner() then
                local ownerName = self:GetOwner():GetName();
                if ownerName then
                    local slotId = c:GetSlotId(ownerName:gsub("Character", ""));
                    if slotId then
                        local setName = c:LoadCurrentSetName();
                        local itemString = c:LoadSlot(slotId, setName);
                        if setName and not (c:LoadPartialOption(setName) or c:LoadSlotState(slotId, setName)) and
                            not c:IsSetItem(slotId, itemString) then
                            GameTooltip:AddLine(" ");
                            GameTooltip:AddDoubleLine(c:FormatTextWithColor(c:GetText("Expected Item:"), "ff0000"),
                                c:GetItemLink(itemString));
                        end
                    else
                        local name, itemLink = self:GetItem();
                        local itemString = c:GetItemString(itemLink);
                        if itemString then
                            c:ShowItemToolTip(itemString);
                        end
                    end
                end
            end
        end);

        -- hook character slots for quickslots on empty slot
        for slotId, slotName in pairs(c:GetSlotInfo()) do
            local frame = _G["Character" .. slotName];
            if frame then
                frame:HookScript("OnClick", function(self, button)
                    if button == "LeftButton" then
                        if frame.quickbar then
                            frame.quickbar:Hide();
                            frame.quickbar = nil;
                        elseif c:GetItemString(slotId) == c.VALUE_NONE then
                            c:CloseQuickBars();
                            frame.quickbar = c:OpenQuickBar(slotId);
                        end
                    end
                end)
            end
        end

        c:HookBlizzardFrameScripts();
        c:InitUiFrame();

        c:CreateSecureActionButtons();
    end
end

function c:HookBlizzardFrameScripts()
    -- hook blizzard frame scripts for side-by-side display
    local otherFrameNames, newFrameHasBeenHooked = {"CraftFrame", "TradeSkillFrame", "BankFrame"};
    for _, frameName in ipairs(otherFrameNames) do
        local frame = _G[frameName];
        if frame and not c.isFrameHooked[frameName] then
            frame:HookScript("OnShow", function(self)
                c:SetBlizzardFramePositions();
            end);
            frame:HookScript("OnHide", function(self)
                c:SetBlizzardFramePositions();
            end);
            c.isFrameHooked[frameName] = true;
            newFrameHasBeenHooked = true;
        end
    end

    if newFrameHasBeenHooked then
        c:SetBlizzardFramePositions();
    end
end

function c:CreatePaperDollButton()
    local button = CreateFrame("Button", "GQ_PaperDollButton", c.paperDollFrame);
    button:SetPoint("TOPRIGHT", c.paperDollFrame, "TOPRIGHT", -40, -45);
    button:SetWidth(50);
    button:SetHeight(20);
    button:SetText("GQ");
    button:SetNormalFontObject("GameFontNormal");
    button:RegisterForClicks("LeftButtonUp");
    button:SetScript("OnClick", function()
        c:ToggleUI();
    end);

    local ntex = button:CreateTexture("GQ_PaperDollButtonIconTexture");
    ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up");
    ntex:SetTexCoord(0, 0.625, 0, 0.6875);
    ntex:SetAllPoints();
    button:SetNormalTexture(ntex);

    local htex = button:CreateTexture();
    htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight");
    htex:SetTexCoord(0, 0.625, 0, 0.6875);
    htex:SetAllPoints();
    button:SetHighlightTexture(htex);

    local ptex = button:CreateTexture();
    ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down");
    ptex:SetTexCoord(0, 0.625, 0, 0.6875);
    ptex:SetAllPoints();
    button:SetPushedTexture(ptex);

    local dtex = button:CreateTexture();
    dtex:SetTexture("Interface/Buttons/UI-Panel-Button-Disabled");
    dtex:SetTexCoord(0, 0.625, 0, 0.6875);
    dtex:SetAllPoints();
    button:SetDisabledTexture(dtex);

    return button;
end

function c:DisablePaperDollButton()
    c.paperDollFrame.paperDollButton:Disable();
end

function c:EnablePaperDollButton()
    c.paperDollFrame.paperDollButton:Enable();
end

function c:CreatePaperDollLabel()
    local label = CreateFrame("Frame", "GQ_PaperDollLabel", c.paperDollFrame);
    label:SetPoint("CENTER", c.paperDollFrame, "CENTER", 0, -5);
    label:SetFrameStrata("HIGH");
    label:SetWidth(200);
    label:SetHeight(20);
    label:EnableMouse();
    label:SetScript("OnEnter", function(self)
        self:SetAlpha(0);
    end);
    label:SetScript("OnLeave", function(self)
        self:SetAlpha(1);
    end);

    label.text = label:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    label.text:SetPoint("CENTER", 0, 0);

    return label;
end

function c:SetPaperDollLabelText(setName)
    if GQ_OPTIONS[c.OPT_SHOWCURRENTSET] then
        setName = setName or c:LoadCurrentSetName();
        if not setName then
            c.paperDollFrame.paperDollLabel.text:SetFormattedText("%s%s: %s", "|cffff0000", c:GetText("Current set"),
                c:GetText("Unknown"));
        elseif c:GetTableSize(c:GetIgnoredItems()) > 0 then
            c.paperDollFrame.paperDollLabel.text:SetFormattedText("%s%s: \"%s\"", "|cff6977f0",
                c:GetText("Current set"), setName);
        elseif c:IsSetComplete() then
            c.paperDollFrame.paperDollLabel.text:SetFormattedText("%s%s: \"%s\"", "|cffffcc00",
                c:GetText("Current set"), setName);
        else
            c.paperDollFrame.paperDollLabel.text:SetFormattedText("%s%s: \"%s\"", "|cffff0000",
                c:GetText("Current set"), setName);
        end
        c.paperDollFrame.paperDollLabel:Show();
    else
        c.paperDollFrame.paperDollLabel:Hide();
    end
end

function c:ShowAddSetDialog()
    StaticPopupDialogs["GQ_DIALOG_ADDSET"] = StaticPopupDialogs["GQ_DIALOG_ADDSET"] or {
        text = c:GetText("Enter a name for this set:"),
        button1 = c:GetText("Apply"),
        button2 = c:GetText("Cancel"),
        hasEditBox = true,
        maxLetters = 30,
        EditBoxOnEnterPressed = function(self)
            local parent = self:GetParent();
            local setName = c:Trim(self:GetText());
            if c:IsValidSetName(setName) then
                c:SaveSet(setName, false);
                c:UpdateBroker();
            else
                c:Println(c:GetText(
                    "Invalid set name: \"%s\". Set names must [1] not be empty, [2] be unique (case insensitive) and [3] not contain \"$\" (reserved).",
                    setName));
            end
            parent:Hide();
        end,
        EditBoxOnEscapePressed = function(self)
            self:GetParent():Hide();
        end,
        OnAccept = function(self, data, data2)
            local setName = c:Trim(self.editBox:GetText());
            if c:IsValidSetName(setName) then
                c:SaveSet(setName, false);
                c:UpdateBroker();
            else
                c:Println(c:GetText(
                    "Invalid set name: \"%s\". Set names must [1] not be empty, [2] be unique (case insensitive) and [3] not contain \"$\" (reserved).",
                    setName));
            end
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3
    };

    StaticPopup_Show("GQ_DIALOG_ADDSET");
end

function c:ShowDeleteSetDialog(setName)
    if setName then
        StaticPopupDialogs["GQ_DIALOG_DELETESET"] = StaticPopupDialogs["GQ_DIALOG_DELETESET"] or {
            text = c:GetText("Do you really want to delete \"%s\"?", "%s"),
            button1 = c:GetText("Yes"),
            button2 = c:GetText("No"),
            EditBoxOnEscapePressed = function(self)
                self:GetParent():Hide();
            end,
            OnAccept = function(self, data)
                if data and tContains(c:LoadSetNames(), data) then
                    c:DeleteSet(data);
                    GqUiFrame_BtnSaveSet:Hide();
                    GqUiFrame_BtnDeleteSet:Hide();
                    c:UpdateBroker();
                end
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3
        };

        local dialog = StaticPopup_Show("GQ_DIALOG_DELETESET", setName);
        if dialog then
            dialog.data = setName;
        end
    end
end

function c:ShowResetDialog()
    StaticPopupDialogs["GQ_DIALOG_RESET"] = StaticPopupDialogs["GQ_DIALOG_RESET"] or {
        text = c:GetText("This will reset GearQuipper to defaults. All your sets will be lost.\n\nAre you sure?"),
        button1 = c:GetText("Reset"),
        button2 = c:GetText("Cancel"),
        OnEscapePressed = function()
            self:Hide();
        end,
        OnAccept = function()
            GQ_OPTIONS = {};
            GQ_DATA = {};
            GQ_AUX = {};
            c:ToggleUI(false);
            c:Init();
            c:SaveDefaultSet();
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3
    };

    StaticPopup_Show("GQ_DIALOG_RESET");
end

function c:ShowLoadSaveActionSlotsDialog(self)
    StaticPopupDialogs["GQ_DIALOG_LOADSAVEACTIONSLOTS"] = StaticPopupDialogs["GQ_DIALOG_LOADSAVEACTIONSLOTS"] or {
        text = c:GetText(
            "Your current action configuration differs from \"%s\".\n\nClick \"Save\" to replace the action slots saved in \"%s\" with your current ones\n\nor\n\nClick \"Load\" to replace your current action slots by the actions saved in \"%s\".",
            c:LoadCurrentSetName(), c:LoadCurrentSetName(), c:LoadCurrentSetName()),
        button1 = c:GetText("Save"),
        button2 = c:GetText("Cancel"),
        button3 = c:GetText("Load"),
        OnAccept = function(self, data, data2)
            c:SaveActionConfiguration(c:LoadCurrentSetName());
        end,
        OnCancel = function(self, data, data2)
            if data then
                data:SetChecked(false);
            end
        end,
        OnAlt = function(self, data, data2)
            c:LoadActionConfiguration(c:LoadCurrentSetName());
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3
    };

    local dialog = StaticPopup_Show("GQ_DIALOG_LOADSAVEACTIONSLOTS");
    dialog.data = self;
end

function c:ShowDeleteScriptDialog(script)
    if script then
        StaticPopupDialogs["GQ_DIALOG_DELETESCRIPT"] = StaticPopupDialogs["GQ_DIALOG_DELETESCRIPT"] or {
            text = c:GetText("Do you really want to delete \"%s\"?", "%s"),
            button1 = c:GetText("Yes"),
            button2 = c:GetText("No"),
            OnAccept = function(self, data)
                if data then
                    c:DeleteScript(data);
                    c:ClearScriptEditorFields();
                    c:RefreshScripts();
                end
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3
        };

        local dialog = StaticPopup_Show("GQ_DIALOG_DELETESCRIPT", script[c.FIELD_NAME]);
        if dialog then
            dialog.data = script;
        end
    end
end

function c:ShowSaveScriptAfterClosingDialog(script, unsavedScriptText)
    if script then
        StaticPopupDialogs["GQ_DIALOG_SAVESCRIPTAFTERCLOSING"] =
            StaticPopupDialogs["GQ_DIALOG_SAVESCRIPTAFTERCLOSING"] or {
                text = c:GetText(
                    "Warning! You did not save your script.\n\nWe could not prevent Blizzard from closing the window, but we can still save your script for you.\n\nDo you want to save your script \"%s\" now?",
                    "%s"),
                button1 = c:GetText("Yes"),
                button2 = c:GetText("No"),
                OnAccept = function(self, data)
                    if data then
                        c:SaveScript(script, unsavedScriptText);
                    end
                end,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                preferredIndex = 3
            };

        local dialog = StaticPopup_Show("GQ_DIALOG_SAVESCRIPTAFTERCLOSING", script[c.FIELD_NAME]);
        if dialog then
            dialog.data = script;
        end
    end
end

function c:SetSlotInfo(slotId, color)
    if not slotId then
        for slotId, _ in pairs(c:GetSlotInfo()) do
            c:SetSlotInfo(slotId);
        end
        return;
    else
        local slot = _G["Character" .. c:GetSlotInfo()[slotId]];
        if not slot.gqTex then
            slot.slotId = slotId;
            slot.gqTex = slot:CreateTexture(slot:GetName() .. "IconTexture", "OVERLAY");
            slot.gqTex:SetAllPoints();
        end

        if GQ_OPTIONS[c.OPT_SHOWSLOTBACKDROPS] and not color then
            local setName = c:LoadCurrentSetName();

            if c:LoadPartialOption(setName) and not c:LoadSlotState(slotId, setName) then
                color = "white";
            elseif c:IsIgnoredItem(slotId) then
                color = "blue";
            elseif c:IsSetItem(slotId, c:LoadSlot(slotId, setName)) then
                color = "green";
            else
                color = "red";
            end
        end

        if color == "red" then
            slot.gqTex:SetColorTexture(1, 0, 0, 0.2);
            slot.gqInfo = c:GetText("|cffff0000Expected Item:|r %s", c:GetItemLink(c:LoadSlot(slotId)));
        else
            slot.gqInfo = nil;
            if color == "white" then
                slot.gqTex:SetColorTexture(1, 1, 1, 0.2);
            elseif color == "blue" then
                slot.gqTex:SetColorTexture(0, 0, 1, 0.2);
            else
                -- "green" (actually empty)
                slot.gqTex:SetColorTexture(0, 0, 0, 0);
            end
        end
    end
end

function c:GetSlotStateBoxes()
    if not slotStateBoxes then
        slotStateBoxes = {};
        for slotId, slotName in pairs(c:GetSlotInfo()) do
            slotStateBoxes[slotId] = c:CreateSlotStateBox(slotName, _G["Character" .. slotName]);
        end
    end
    return slotStateBoxes;
end

function c:ShowSlotStateBoxes()
    if GqUiFrame:IsVisible() and c:LoadPartialOption() then
        for slotId, checkBox in pairs(c:GetSlotStateBoxes()) do
            c:SetSlotState(slotId, c:LoadSlotState(slotId));
            checkBox:Show();
        end
    end
end

function c:HideSlotStateBoxes()
    for _, checkBox in pairs(c:GetSlotStateBoxes()) do
        checkBox:Hide();
    end
end

function c:CreateSlotStateBox(slotName, parent)
    local checkbutton = CreateFrame("CheckButton", slotName .. "StateBox", parent, "UICheckButtonTemplate");
    checkbutton:SetWidth(24);
    checkbutton:SetHeight(24);
    checkbutton:SetPoint("BOTTOMLEFT", -3, -3);
    checkbutton:RegisterForClicks("LeftButtonUp");
    checkbutton:SetScript("OnClick", function(self)
        local slotId = c:GetSlotId(slotName);
        c:SaveSlotState(slotId, self:GetChecked());
        if GqUiFrame:IsVisible() then
            c:RefreshSetList();
        end

        if not self:GetChecked() then
            c:SetSlotInfo(slotId, "white");
            return;
        elseif not c:IsSetItem(slotId, c:LoadSlot(slotId)) then
            c:SaveSlot(slotId);
        end
        c:SetSlotInfo(slotId, "green");
    end);

    local S = c:GetElvUiSkinModule();
    if S then
        S:HandleCheckBox(checkbutton);
    end

    return checkbutton;
end

function c:SetSlotState(slotId, value)
    c:GetSlotStateBoxes()[slotId]:SetChecked(value);
end

function c:GetSlotState(slotId)
    return c:GetSlotStateBoxes()[slotId]:GetChecked();
end

function c:ShowItemToolTip(itemString)
    local sets = c:GetItemSets(itemString);
    if sets and table.getn(sets) > 0 then
        -- if _G["GameTooltipTextRight1"] then
        --     GameTooltipTextRight1:SetText("hi");
        -- end
        
        GameTooltip:AddLine(" ");
        GameTooltip:AddDoubleLine(c:GetText("GearQuipper set(s):"), table.concat(sets, ", "));
    end
end

local function GetContainersForItems(itemStrings)
    local result = {};
    if itemStrings then
        if c:IsAddonEnabled("AdiBags") then
            for slotId = 0, 255 do
                local frame = _G["AdiBagsItemButton" .. slotId];
                if frame and frame.bag and frame.slot then
                    local itemString = c:GetItemString(GetContainerItemLink(frame.bag, frame.slot));
                    if c:IsEmpty(itemString) or not c:TableContains(itemStrings, itemString) then
                        tinsert(result, frame);
                    end
                end

                if c:IsAtBank() then
                    local frame = _G["AdiBagsBankItemButton" .. slotId];
                    if frame and frame.bag and frame.slot then
                        local itemString = c:GetItemString(GetContainerItemLink(frame.bag, frame.slot));
                        if c:IsEmpty(itemString) or not c:TableContains(itemStrings, itemString) then
                            tinsert(result, frame);
                        end
                    end
                end
            end
        elseif c:IsAddonEnabled("ArkInventory") then
            -- I'm just guessing here...
            for invId = 0, 5 do
                for bagId = 0, 8 do
                    for slotId = 1, MAX_CONTAINER_ITEMS do
                        local frameName = "ARKINV_Frame" .. invId .. "ScrollContainerBag" .. bagId .. "Item" .. slotId;
                        local arkFrame = _G[frameName];
                        if arkFrame then
                            local arkData = arkFrame.ARK_Data;
                            if arkData then
                                local itemString = c:GetItemString(
                                    GetContainerItemLink(arkData.blizzard_id, arkData.slot_id));
                                if c:IsEmpty(itemString) or not c:TableContains(itemStrings, itemString) then
                                    tinsert(result, arkFrame);
                                end
                            end
                        end
                    end
                end
            end
        elseif c:IsAddonEnabled("TBag") and TInvItm and TInvItm[TInvFrame.playerid] then
            -- I'm just guessing here...
            for bagId = 1, 13 do
                for slotId = 1, MAX_CONTAINER_ITEMS do
                    local match = false;
                    local tbagFrame = _G["TInvainerFrame" .. bagId .. "Item" .. slotId];
                    if tbagFrame then
                        if TInvItm[TInvFrame.playerid][bagId] and TInvItm[TInvFrame.playerid][bagId][slotId] and
                            TInvItm[TInvFrame.playerid][bagId][slotId]["il"] then
                            local itemString = TInvItm[TInvFrame.playerid][bagId][slotId]["il"]; -- .. ":" .. UnitLevel("player") .. ":::::::::"; -- messy workaround
                            local itemName = TInvItm[TInvFrame.playerid][bagId][slotId]["in"];
                            if not itemName then
                                break;
                            end
                            for _, is in ipairs(itemStrings) do
                                if not match and c:GetItemName(is) == itemName then
                                    match = true;
                                    break;
                                end
                            end
                        end

                        if not match then
                            tinsert(result, tbagFrame);
                        end
                    end
                end
            end
        else
            -- default player bags / bagnon containers
            for bagId = 0, NUM_BAG_SLOTS do
                local bagSize = GetContainerNumSlots(bagId);

                for slotId = 1, MAX_CONTAINER_ITEMS do
                    if c:IsAddonEnabled("Bagnon") then
                        local frameName = "ContainerFrame" .. bagId .. "Item" .. slotId;
                        if _G[frameName] and _G[frameName].info then
                            local itemString = c:GetItemString(_G[frameName].info.link);
                            if c:IsEmpty(itemString) or not c:TableContains(itemStrings, itemString) then
                                tinsert(result, _G[frameName]);
                            end
                        end
                    else
                        local frameName = "ContainerFrame" .. (bagId + 1) .. "Item" .. (bagSize - slotId + 1);
                        if _G[frameName] then
                            local itemString = c:GetItemString(GetContainerItemLink(bagId, slotId));
                            if c:IsEmpty(itemString) or not c:TableContains(itemStrings, itemString) then
                                tinsert(result, _G[frameName]);
                            end
                        end
                    end
                end
            end

            if c:IsAtBank() then
                -- default bank container
                for invId = 48, 75 do
                    local frameName = "BankFrameItem" .. (invId - 47);
                    if _G[frameName] then
                        local itemString = c:GetItemString(GetContainerItemLink(-1, invId - 47));
                        if c:IsEmpty(itemString) or not c:TableContains(itemStrings, itemString) then
                            tinsert(result, _G[frameName]);
                        end
                    end
                end

                -- default bank bags
                for bagId = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
                    local bagSize = GetContainerNumSlots(bagId);
                    for slotId = 1, bagSize do
                        if _G["BankFrame"] and _G["BankFrame"]:IsVisible() then
                            local frameName = "ContainerFrame" .. (bagId + 1) .. "Item" .. (bagSize - slotId + 1);
                            if _G[frameName] then
                                local itemString = c:GetItemString(GetContainerItemLink(bagId, slotId));
                                if c:IsEmpty(itemString) or not c:TableContains(itemStrings, itemString) then
                                    tinsert(result, _G[frameName]);
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return result;
end

local function ResetFrameAlpha(frameName)
    if _G[frameName] then
        _G[frameName]:SetAlpha(1);
    end
end

function c:HighlightItemsEquipped(itemStrings, setName)
    if not itemStrings then
        -- reset
        for id, name in pairs(c:GetSlotInfo()) do
            ResetFrameAlpha("Character" .. name);
        end
    else
        -- set
        for id, name in pairs(c:GetSlotInfo()) do
            _G["Character" .. name]:SetAlpha(0.35);
        end
        for _, itemString in pairs(itemStrings) do
            local slotId = c:IsItemEquipped(itemString);
            if slotId and (not c:LoadPartialOption(setName) or c:LoadSlotState(slotId, setName)) then
                ResetFrameAlpha("Character" .. c:GetSlotInfo()[slotId]);
            end
        end
    end
end

function c:HighlightItemsInBags(itemStrings)
    if c:IsAddonEnabled("AdiBags") then
        -- reset alpha
        -- I'm just guessing here...
        for slotId = 0, 255 do
            ResetFrameAlpha("AdiBagsItemButton" .. slotId);
        end
        if c:IsAtBank() then
            for slotId = 0, 255 do
                ResetFrameAlpha("AdiBagsBankItemButton" .. slotId);
            end
        end
    elseif c:IsAddonEnabled("ArkInventory") then
        -- reset alpha
        -- I'm just guessing here...
        for invId = 0, 5 do
            for bagId = 0, 8 do
                for slotId = 1, MAX_CONTAINER_ITEMS do
                    ResetFrameAlpha("ARKINV_Frame" .. invId .. "ScrollContainerBag" .. bagId .. "Item" .. slotId);
                end
            end
        end
    elseif c:IsAddonEnabled("TBag") then
        -- reset alpha
        -- I'm just guessing here...
        for bagId = 1, 13 do
            for slotId = 1, MAX_CONTAINER_ITEMS do
                ResetFrameAlpha("TInvainerFrame" .. bagId .. "Item" .. slotId);
            end
        end
    else
        -- default / bagnon frames
        -- reset alpha
        for bagId = 0, 24 do
            for slotId = 1, MAX_CONTAINER_ITEMS do
                ResetFrameAlpha("ContainerFrame" .. bagId .. "Item" .. slotId);
            end
        end

        if c:IsAtBank() then
            for invId = 48, 75 do
                ResetFrameAlpha("BankFrameItem" .. (invId - 47));
            end
        end
    end

    -- set alpha
    for _, frame in ipairs(GetContainersForItems(itemStrings)) do
        frame:SetAlpha(0.35);
    end
end

----- experimental -----

function c:CreateSecureActionButtons()
    for _, setName in ipairs(c:LoadSetNames()) do
        local macrotext;

        local mainHandItem = c:LoadSlot(INVSLOT_MAINHAND, setName);
        if c:IsEmpty(mainHandItem) then
            macrotext = string.format("/unequipslot %s", INVSLOT_MAINHAND);
        else
            macrotext = string.format("/equipslot %s %s", INVSLOT_MAINHAND, c:GetItemName(mainHandItem));
        end

        local offHandItem = c:LoadSlot(INVSLOT_OFFHAND, setName);
        if c:IsEmpty(offHandItem) then
            macrotext = string.format("/unequipslot %s", INVSLOT_OFFHAND);
        else
            macrotext = string.format("/equipslot %s %s", INVSLOT_OFFHAND, c:GetItemName(offHandItem));
        end

        local rangedItem = c:LoadSlot(INVSLOT_RANGED, setName);
        if c:IsEmpty(rangedItem) then
            macrotext = string.format("/unequipslot %s", INVSLOT_RANGED);
        else
            macrotext = string.format("/equipslot %s %s", INVSLOT_RANGED, c:GetItemName(rangedItem));
        end

        c:SetSecureAction(setName, macrotext);
    end
end

function c:CreateSecureActionButton(setName)
    if setName then
        if not secureActionButtons[setName] then
            local button = CreateFrame("Button", "GQ_SecureActionButton_" .. setName, UIParent,
                "SecureActionButtonTemplate");
            button:RegisterForClicks("AnyUp");
            button:SetAttribute("type", "macro");
            secureActionButtons[setName] = button;
        end
        return secureActionButtons[setName];
    end
end

function c:SetSecureAction(setName, macrotext)
    if setName and macrotext then
        local button = c:CreateSecureActionButton(setName);
        button:SetAttribute("macrotext", macrotext);
    end
end

function c:CallSecureAction(setName)
    if secureActionButtons[setName] then
        -- experimental
        -- C_Timer.After(0.1, function()
        --	secureActionButtons[setName]:Click();
        -- end);
    end
end
