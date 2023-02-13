---@type GL
local _, GL = ...;

---@class AwardDialogInterface
GL:tableSet(GL, "Interface.Dialogs.AwardDialog", {});
local AwardDialog = GL.Interface.Dialogs.AwardDialog; ---@type AwardDialogInterface

function AwardDialog:open(Dialog)
    local AceGUI = GL.AceGUI;

    Dialog.checkPlusOne = GL:toboolean(Dialog.checkPlusOne);
    Dialog.checkOS = GL:toboolean(Dialog.checkOS);
    Dialog.checkPlusOne = GL:toboolean(Dialog.checkPlusOne);
    Dialog.checkOS = GL:toboolean(Dialog.checkOS);
    Dialog.checkPlusOne = GL:toboolean(Dialog.checkPlusOne);
    Dialog.boostedRollCost = GL.BoostedRolls:toPoints(Dialog.boostedRollCost);

    -- Create a container/parent frame
    local Frame = AceGUI:Create("GargulAwardDialog");
    Frame:SetLayout("Flow");
    Frame:SetWidth(320);
    Frame:SetQuestion(Dialog.question);
    Frame:OnYes(Dialog.OnYes or function () end);
    Frame:OnNo(Dialog.OnNo or function () end);

    if (Dialog.checkPlusOne) then
        local PlusOneCheckBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.PlusOne");

        if (PlusOneCheckBox) then
            PlusOneCheckBox:SetValue(true);
        end
    end

    if (Dialog.checkOS) then
        local OSCheckBox = GL.Interface:get(self, "CheckBox.OffSpec");

        if (OSCheckBox) then
            OSCheckBox:SetValue(true);
        end
    end

    if (Dialog.checkPlusOne) then
        local PlusOneCheckBox = GL.Interface:get(self, "CheckBox.PlusOne");

        if (PlusOneCheckBox) then
            PlusOneCheckBox:SetValue(true);
        end
    end

    --- Adjust the value of the boosted roll cost editbox
    local BoostedRollsCostEditBox = GL.Interface:get(self, "EditBox.Cost");

    if (BoostedRollsCostEditBox) then
        local cost = 0;
        if (Dialog.isBR) then
            cost = Dialog.boostedRollCost;
        end

        BoostedRollsCostEditBox:SetText(cost);
    end
end

GL:debug("Interface/AwardDialog.lua");