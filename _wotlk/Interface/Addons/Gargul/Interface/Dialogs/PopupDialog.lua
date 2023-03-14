---@type GL
local _, GL = ...;

---@class PopupDialogInterface
GL:tableSet(GL, "Interface.Dialogs.PopupDialog", {});
local PopupDialog = GL.Interface.Dialogs.PopupDialog; ---@type PopupDialogInterface

function PopupDialog:open(Dialog)
    local AceGUI = GL.AceGUI;

    if (type(Dialog) == "string") then
        Dialog = self[Dialog];
    end

    -- Create a container/parent frame
    local Frame = AceGUI:Create("GargulPopupDialog");
    Frame:SetLayout("Flow");
    Frame:SetWidth(320);
    Frame:SetQuestion(Dialog.question or "");
    Frame:OnYes(Dialog.OnYes or function () end);
    Frame:OnNo(Dialog.OnNo or function () end);
    Frame:OnCancel(Dialog.OnCancel or function () end);

    if (Dialog.withCancel) then
        Frame:IncludeCancel();
    end
end

-- Clear soft-reserve data confirmation
PopupDialog.CLEAR_SOFTRES_CONFIRMATION = {
    question = "Are you sure you want to clear all existing soft-reserve data?",
    OnYes = function ()
       GL.Interface.SoftRes.Overview:close();
       GL.SoftRes:clear();
       GL.SoftRes:draw();
   end,
}

-- Broadcast soft-reserve data confirmation
PopupDialog.BROADCAST_SOFTRES_CONFIRMATION = {
    question = "Are you sure you want to broadcast your softres data to everyone in your party/raid?",
    OnYes = function ()
        GL.SoftRes:broadcast();
    end,
}

-- Clear boosted roll data confirmation
PopupDialog.CLEAR_BOOSTEDROLLS_CONFIRMATION = {
    question = "Are you sure you want to clear all boosted roll data?",
    OnYes = function ()
        GL.Interface.BoostedRolls.Overview:close();
        GL.BoostedRolls:clear();
        GL.BoostedRolls:draw();
   end,
}

-- Import new boosted roll data confirmation
PopupDialog.NEW_BOOSTEDROLLS_IMPORT_CONFIRMATION = {
    question = "Are you sure you want to clear your existing boosted roll data and import new data?",
    OnYes = function ()
        GL.Interface.BoostedRolls.Importer:import();
    end,
    OnNo = function ()
        GL.Interface.BoostedRolls.Importer:close();
        GL.BoostedRolls:draw();
    end,
}

-- Broadcast boosted roll data confirmation
PopupDialog.BROADCAST_BOOSTEDROLLS_CONFIRMATION = {
    question = "Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?",
    OnYes = function ()
        GL.BoostedRolls:broadcast();
    end,
}

-- Clear plus one data confirmation
PopupDialog.CLEAR_PLUSONES_CONFIRMATION = {
    question = "Are you sure you want to clear all plus one data?",
    OnYes = function ()
        GL.Interface.PlusOnes.Overview:close();
        GL.PlusOnes:clearPlusOnes();
        GL.PlusOnes:draw();
   end,
}

-- Import new plus one data confirmation
PopupDialog.NEW_PLUSONES_IMPORT_CONFIRMATION = {
    question = "Are you sure you want to clear your existing plus one data and import new data?",
    OnYes = function ()
        GL.Interface.PlusOnes.Importer:import();
    end,
    OnNo = function ()
        GL.Interface.PlusOnes.Importer:close();
        GL.PlusOnes:draw();
    end,
}

-- Broadcast plus one data confirmation
PopupDialog.BROADCAST_PLUSONES_CONFIRMATION = {
    question = "Are you sure you want to broadcast your plus one data to everyone in your party/raid?",
    OnYes = function ()
        GL.PlusOnes:broadcast();
    end,
}

-- Broadcast soft-reserve data confirmation
PopupDialog.BROADCAST_TMB_CONFIRMATION = {
    question = "Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!",
    OnYes = function ()
        GL.TMB:broadcast();
    end,
}

-- Reset settings to defaults confirmation
PopupDialog.RESET_TO_DEFAULTS_CONFIRMATION = {
    question = "Are you sure you want to reset Gargul to its default settings? DKP, Soft reserves and loot priorities will remain untouched!",
    OnYes = function ()
        GL.Settings:resetToDefault();
    end,
}

-- Add a resut table confirmation dialog to Blizzard's global StaticPopupDialogs object
PopupDialog.RESET_AWARD_HISTORY_CONFIRMATION = {
    question = "",
    OnYes = {},
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
PopupDialog.ROLLOFF_AWARD_CONFIRMATION = {
    question = "",
    OnYes = {},
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
PopupDialog.CLEAR_ROLLOFF_CONFIRMATION = {
    question = "Are you sure you want to clear everything?",
    OnYes = function ()
        GL.RollOff:reset();
    end,
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
PopupDialog.AWARD_CONFIRMATION = {
    question = "",
    OnYes = {},
}

GL:debug("Interface/PopupDialog.lua");