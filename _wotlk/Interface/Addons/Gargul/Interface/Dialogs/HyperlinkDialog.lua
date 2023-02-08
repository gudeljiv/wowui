---@type GL
local _, GL = ...;

---@class HyperlinkDialogInterface
GL:tableSet(GL, "Interface.Dialogs.HyperlinkDialog", {});
local HyperlinkDialog = GL.Interface.Dialogs.HyperlinkDialog; ---@type HyperlinkDialogInterface

function HyperlinkDialog:open(Dialog)
    local AceGUI = GL.AceGUI;
    Dialog.hyperlink = tostring(Dialog.hyperlink);
    Dialog.description = tostring(Dialog.description);

    if (GL:empty(Dialog.hyperlink)) then
        return;
    end

    -- Create a container/parent frame
    local Frame = AceGUI:Create("GargulHyperlinkDialog");
    Frame:SetLayout("Flow");
    Frame:SetWidth(320);
    Frame:SetDescription(Dialog.description);
    Frame:SetHyperlink(Dialog.hyperlink);

    if (Dialog.OnConfirm) then
        Frame:EnableHyperLinkButton();
        Frame:SetOnConfirm(function (_, _, value)
            if (Dialog.OnConfirm(value)
                and Dialog.closeOnConfirm
            ) then
                Frame:Close();
            end
        end);
    end
end

GL:debug("Interface/HyperlinkDialog.lua");