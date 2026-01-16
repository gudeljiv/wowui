local AddonName, Addon = ...
local Core = Addon.Core
local Initialize = Addon.Initialize
local Functions = Addon.Functions
local Assets = Addon.Assets
local UI = Addon.UI
local ProfileManager = Addon.ProfileManager
local SellyManager = Addon.SellyManager
local ExportManager = Addon.ExportManager
local Colors = Addon.Colors
local Events = Addon.Events1
local Items = Addon.Items
local Main = Addon.Main

--------------------------------------------
-- CREATE PROFILE MANAGER
--------------------------------------------

function UI:CreateProfileManager()
    local FrameSettings = {}
    FrameSettings.Name = "ProfileManager"
    FrameSettings.Title = Core.AddonName
    FrameSettings.Size = { 300, 400 }
    UI:CreateMainFrame(FrameSettings)
    UI:SetScript("OnHide", FrameSettings.Name, function() UI:HideContextMenus() end)

    FrameSettings = {}
    FrameSettings.Name = "PMScroll"
    FrameSettings.ParentFrameName = "ProfileManager"
    FrameSettings.Point1 = { "TOPLEFT", "ProfileManager", "TOPLEFT", 10, -40 }
    FrameSettings.Point2 = { "BOTTOMRIGHT", "ProfileManager", "BOTTOMRIGHT", -27, 10 }
    UI:CreateScrollFrame(FrameSettings)

    FrameSettings = {}
    FrameSettings.Name = "PMIsEmptyButton"
    FrameSettings.ParentFrameName = "PMScroll"
    FrameSettings.Size = { 32, 32 }
    FrameSettings.Point1 = { "CENTER", 0, 20 }
    FrameSettings.AssetName = "Plus.blp"
    FrameSettings.AssetHoverName = "Plus-Hover.blp"
    UI:CreateImageButton(FrameSettings)

    UI:SetScript("OnClick", "PMIsEmptyButton", function(Self, Button)
        SellyManager:DisplaySellyManager()
    end)

    FrameSettings = {}
    FrameSettings.Name = "PMIsEmptyLabel"
    FrameSettings.ParentFrameName = "PMIsEmptyButton"
    FrameSettings.Text = "Create a profile."
    FrameSettings.Point1 = { "CENTER", 0, -35 }
    FrameSettings.FontSize = 16
    FrameSettings.FontColor = Colors.grey
    UI:CreateLabel(FrameSettings)
end

--------------------------------------------
-- CREATE SELLY MANAGER
--------------------------------------------

function UI:CreateSellyManager()
    local FrameSettings = {}
    FrameSettings.Name = "SellyManager"
    FrameSettings.Title = Core.AddonName..": Manager"
    FrameSettings.Size = { 330, 500 }
    UI:CreateMainFrame(FrameSettings)

    for Key, ItemColor in next, Core.ItemColors, nil do
        local LastItemColor = ""
        local LastAnchorFrameName = "SellyManager"
        local IndentX, IndentY = unpack({ 10, -40 })

        if (Key > 1) then
            LastItemColor = Core.ItemColors[(Key - 1)]
            LastAnchorFrameName = "SMCheckSell"..LastItemColor
            IndentX, IndentY = unpack({ 0, -30 })
        end

        FrameSettings = {}
        FrameSettings.Name = "SMCheckSell"..ItemColor
        FrameSettings.Text = "Sell "..ItemColor
        FrameSettings.ParentFrameName = "SellyManager"
        FrameSettings.Point1 = { "TOPLEFT", LastAnchorFrameName, "TOPLEFT", IndentX, IndentY }
        FrameSettings.FontColor = Colors["item"..ItemColor]
        UI:CreateCheckbox(FrameSettings)

        if (Key > 2) then

                FrameSettings = {}
                FrameSettings.Name = "SMCheckSell"..ItemColor.."BoE"
                FrameSettings.Text = "Sell BoE"
                FrameSettings.ParentFrameName = "SellyManager"
                FrameSettings.Point1 = { "TOPLEFT", "SMCheckSell"..ItemColor, "TOPLEFT", 120, 0 }
                FrameSettings.FontColor = Colors["item"..ItemColor]
                UI:CreateCheckbox(FrameSettings)
                UI:SetEnabled(FrameSettings.Name, false)

                UI:SetScript("OnClick", "SMCheckSell"..ItemColor, function(Self)
                    if (Self:GetChecked()) then
                        UI:SetEnabled("SMCheckSell"..ItemColor.."BoE", true)
                    else
                        UI:SetChecked("SMCheckSell"..ItemColor.."BoE", false)
                        UI:SetEnabled("SMCheckSell"..ItemColor.."BoE", false)
                    end
                end)

        end
    end

    local LastCheckboxColor = Core.ItemColors[#Core.ItemColors]

    FrameSettings = {}
    FrameSettings.Name = "SFGroupBoxOptions"
    FrameSettings.Title = "Options"
    FrameSettings.ParentFrameName = "SellyManager"
    FrameSettings.Point1 = { "TOPLEFT", "SMCheckSell"..LastCheckboxColor, "BOTTOMLEFT", 5, -15 }
    FrameSettings.Size = { UI:GetFrame("SellyManager"):GetWidth() - 30, 55 }
    UI:CreateGroupBox(FrameSettings)

        FrameSettings = {}
        FrameSettings.Name = "SMCheckOptionAutoRepair"
        FrameSettings.Text = "Repair"
        FrameSettings.ParentFrameName = "SFGroupBoxOptions"
        FrameSettings.Point1 = { "TOPLEFT", "SFGroupBoxOptions", "TOPLEFT", 10, -15 }
        UI:CreateCheckbox(FrameSettings)
        TooltipText = { "Repairs if available." }
        UI:SetCustomTooltip(FrameSettings.Name, FrameSettings.Text, TooltipText)

            FrameSettings = {}
            FrameSettings.Name = "SMCheckOptionAutoSell"
            FrameSettings.Text = "Auto-Sell"
            FrameSettings.ParentFrameName = "SFGroupBoxOptions"
            FrameSettings.Point1 = { "TOPLEFT", "SMCheckOptionAutoRepair", "TOPLEFT", 120, 0 }
            UI:CreateCheckbox(FrameSettings)
            TooltipText = {
                "Sells as soon as the",
                "merchant window is open.\n",
                Functions:PrintColor("Beware!", Colors.red),
                "Can lead to unwanted sales."
            }
            UI:SetCustomTooltip(FrameSettings.Name, FrameSettings.Text, TooltipText)

    FrameSettings = {}
    FrameSettings.Name = "SFWhitelistLabel"
    FrameSettings.Text = "Whitelist Items"
    FrameSettings.ParentFrameName = "SellyManager"
    FrameSettings.Point1 = { "TOPLEFT", "SFGroupBoxOptions", "BOTTOMLEFT", 0, -10 }
    FrameSettings.FontSize = 12
    UI:CreateLabel(FrameSettings)
    TooltipText = {
        "Add all item names that should \"not\" be sold (line by line).",
        "You can also add partial names by entering an asterisk * before or after the name.",
        "(Example: Recipe*)\n",
        "Items can also be added by shift-clicking on the item in your bag."
    }
    UI:SetCustomTooltip(FrameSettings.Name, FrameSettings.Text, TooltipText)

    FrameSettings = {}
    FrameSettings.Name = "SFWhitelistTextbox"
    FrameSettings.ParentFrameName = "SellyManager"
    FrameSettings.Point1 = { "TOPLEFT", "SFWhitelistLabel", "TOPLEFT", -2, -20 }
    FrameSettings.Point2 = { "BOTTOMRIGHT", "SellyManager", "BOTTOMRIGHT", -35, 60 }
    UI:CreateMultiLineTextbox(FrameSettings)

    FrameSettings = {}
    FrameSettings.Name = "SFSaveButton"
    FrameSettings.Text = "Save"
    FrameSettings.ParentFrameName = "SellyManager"
    FrameSettings.Point1 = { "TOPLEFT", "SFWhitelistTextbox", "BOTTOMLEFT", 0, -10 }
    FrameSettings.Point2 = { "BOTTOMRIGHT", "SellyManager", "BOTTOMRIGHT", -15, 15 }
    UI:CreateButton(FrameSettings)

    UI:SetScript("OnClick", "SFSaveButton", function(Self, Button)
        SellyManager:SaveProfile()
    end)
end

--------------------------------------------
-- CREATE IMPORT MANAGER
--------------------------------------------

function UI:CreateExportManager()
    local FrameSettings = {}
    FrameSettings.Name = "ExportManager"
    FrameSettings.Title = Core.AddonName..": Import/Export Profile"
    FrameSettings.Size = { 500, 300 }
    UI:CreateMainFrame(FrameSettings)

    FrameSettings = {}
    FrameSettings.Name = "ExportManager.Textbox"
    FrameSettings.ParentFrameName = "ExportManager"
    FrameSettings.Point1 = { "TOPLEFT", "ExportManager", "TOPLEFT", 10, -40 }
    FrameSettings.Point2 = { "BOTTOMRIGHT", "ExportManager", "BOTTOMRIGHT", -30, 60 }
    UI:CreateMultiLineTextbox(FrameSettings)

    FrameSettings = {}
    FrameSettings.Name = "EMOptionsButton"
    FrameSettings.Text = "[OPTION]"
    FrameSettings.ParentFrameName = "ExportManager"
    FrameSettings.Point1 = { "TOPLEFT", "ExportManager.Textbox", "BOTTOMLEFT", 0, -10 }
    FrameSettings.Point2 = { "BOTTOMRIGHT", "ExportManager", "BOTTOMRIGHT", -10, 10 }
    UI:CreateButton(FrameSettings)
end

--------------------------------------------
-- CREATE PROFILE MANAGER TITLE BUTTONS
--------------------------------------------

function UI:CreateProfileManagerTitleButtons()
    local FrameSettings = {}
    FrameSettings.Name = "ButtonImport"
    FrameSettings.ParentFrameName = "ProfileManager"
    FrameSettings.Size = { 16, 16 }
    FrameSettings.Point1 = { "LEFT", "ProfileManager.CloseButton", "LEFT", -28, 0 }
    FrameSettings.AssetName = "Import.blp"
    FrameSettings.AssetHoverName = "Import-Hover.blp"
    UI:CreateImageButton(FrameSettings)

    UI:SetScript("OnClick", "ButtonImport", function(Self, Button)
        ExportManager:DisplayImportManager()
    end)

    FrameSettings = {}
    FrameSettings.Name = "ButtonCreateProfile"
    FrameSettings.ParentFrameName = "ProfileManager"
    FrameSettings.Size = { 16, 16 }
    FrameSettings.Point1 = { "LEFT", "ButtonImport", "LEFT", -28, 0 }
    FrameSettings.AssetName = "Plus.blp"
    FrameSettings.AssetHoverName = "Plus-Hover.blp"
    UI:CreateImageButton(FrameSettings)

    UI:SetScript("OnClick", "ButtonCreateProfile", function(Self, Button)
        SellyManager:DisplaySellyManager()
    end)
end

--------------------------------------------
-- CREATE DIALOGS
--------------------------------------------

function UI:CreateDialog()
    local FrameSettings = {}
    FrameSettings.Name = "DialogFrame"
    FrameSettings.Title = "[TITLE]"
    FrameSettings.Size = { 300, 150 }
    UI:CreateMainFrame(FrameSettings)

    UI:SetScript("OnKeyUp", "DialogFrame", function(Self, Key)
        if (Key ~= "ESCAPE") then return end
        UI:Hide("DialogFrame")
    end)

    FrameSettings = {}
    FrameSettings.Name = "DialogFrame.Label"
    FrameSettings.Text = "[TEXT]"
    FrameSettings.ParentFrameName = "DialogFrame"
    FrameSettings.Point1 = { "TOPLEFT", "DialogFrame", "TOPLEFT", 15, -50 }
    FrameSettings.Point2 = { "TOPRIGHT", "DialogFrame", "TOPRIGHT", -15, 0 }
    FrameSettings.FontSize = 16
    UI:CreateLabel(FrameSettings)

    FrameSettings = {}
    FrameSettings.Name = "DialogFrame.LeftButton"
    FrameSettings.Text = "[LBTN]"
    FrameSettings.ParentFrameName = "DialogFrame"
    FrameSettings.Point1 = { "BOTTOMLEFT", "DialogFrame.Label", "BOTTOMLEFT", 0, -60 }
    UI:CreateButton(FrameSettings)

    FrameSettings = {}
    FrameSettings.Name = "DialogFrame.RightButton"
    FrameSettings.Text = "[RBTN]"
    FrameSettings.ParentFrameName = "DialogFrame"
    FrameSettings.Point1 = { "BOTTOMRIGHT", "DialogFrame.Label", "BOTTOMRIGHT", 0, -60 }
    UI:CreateButton(FrameSettings)
end

function UI:CreateDialogTextbox()
    local FrameSettings = {}
    FrameSettings.Name = "DialogTextboxFrame"
    FrameSettings.Title = "[TITLE]"
    FrameSettings.Size = { 300, 150 }
    UI:CreateMainFrame(FrameSettings)

    UI:SetScript("OnKeyUp", "DialogTextboxFrame", function(Self, Key)
        if (Key ~= "ESCAPE") then return end
        UI:Hide("DialogTextboxFrame")
    end)

    FrameSettings = {}
    FrameSettings.Name = "DialogTextboxFrame.Label"
    FrameSettings.Text = "[TEXT]"
    FrameSettings.ParentFrameName = "DialogTextboxFrame"
    FrameSettings.Point1 = { "TOPLEFT", "DialogTextboxFrame", "TOPLEFT", 15, -50 }
    FrameSettings.Point2 = { "TOPRIGHT", "DialogTextboxFrame", "TOPRIGHT", -15, 0 }
    FrameSettings.FontSize = 16
    UI:CreateLabel(FrameSettings)

    FrameSettings = {}
    FrameSettings.Name = "DialogTextboxFrame.Textbox"
    FrameSettings.ParentFrameName = "DialogTextboxFrame"
    FrameSettings.Point1 = { "BOTTOMLEFT", "DialogTextboxFrame.Label", "BOTTOMLEFT", 0, -60 }
    FrameSettings.Point2 = { "BOTTOMRIGHT", "DialogTextboxFrame", "BOTTOMRIGHT", -10, 0 }
    UI:CreateTextbox(FrameSettings)

    FrameSettings = {}
    FrameSettings.Name = "DialogTextboxFrame.LeftButton"
    FrameSettings.Text = "[LBTN]"
    FrameSettings.ParentFrameName = "DialogTextboxFrame"
    FrameSettings.Point1 = { "BOTTOMLEFT", "DialogTextboxFrame.Textbox", "BOTTOMLEFT", 0, -50 }
    UI:CreateButton(FrameSettings)

    FrameSettings = {}
    FrameSettings.Name = "DialogTextboxFrame.RightButton"
    FrameSettings.Text = "[RBTN]"
    FrameSettings.ParentFrameName = "DialogTextboxFrame"
    FrameSettings.Point1 = { "BOTTOMRIGHT", "DialogTextboxFrame.Textbox", "BOTTOMRIGHT", 0, -50 }
    UI:CreateButton(FrameSettings)

    UI:SetScript("OnKeyUp", "DialogTextboxFrame.Textbox.Textbox", function(Self, Key)
        if (Key ~= "ENTER") then return end
        UI:Click("DialogTextboxFrame.LeftButton")
    end)
end

--------------------------------------------
-- CREATE VENDOR OPTIONS
--------------------------------------------

function UI:CreateVendorOptions()
    local VendorFrame = _G["MerchantFrame"]
    local SellButton = UI:GetFrame("SellButton")

    if (not SellButton) then
        SellButton = CreateFrame("Button", UI:FrameName("SellButton"), VendorFrame, "UIPanelButtonTemplate")
        SellButton:SetSize(80, 30)
        SellButton:SetText("Selly")
        UI:SetScript("OnClick", SellButton, function() Main:SellItems() end)
    end

    if (VendorFrame) then
        SellButton:SetPoint("TOPRIGHT", VendorFrame, "TOPRIGHT", Functions:Condition(Core.IsRetail, -170, -10), -27)
        SellButton:Show()
    else
        SellButton:Hide()
    end
end

--------------------------------------------
-- TOGGLE UI'S
--------------------------------------------

function UI:ToggleAddon()
    SellyLocalDB.Settings.IsAddonEnabled = not SellyLocalDB.Settings.IsAddonEnabled

    if (SellyLocalDB.Settings.IsAddonEnabled) then
        UI.Minimap.icon = Assets.Images["Logo-Minimap.blp"]
        UI:SetText("ProfileManager.Title", Core.AddonName)
        UI:SetTextColor("ProfileManager.Title", "#ffd100")

        Main:PrepareSellButton()

        Functions:PrintAddon(Functions:PrintColor("Enabled", Colors.green)..".")
    else
        UI.Minimap.icon = Assets.Images["Logo-Minimap-Disabled.blp"]
        UI:SetText("ProfileManager.Title", Core.AddonName.." "..Functions:PrintColor("(Disabled)", Colors.red))
        UI:SetTextColor("ProfileManager.Title", "#ffd100")

        Main:PrepareSellButton()

        Functions:PrintAddon(Functions:PrintColor("Disabled", Colors.red)..".")
    end
end

function UI:Toggle(FrameName)
    if (UI:IsVisible(FrameName)) then
        UI:Hide(FrameName)
    else
        UI:Show(FrameName)
    end
end
