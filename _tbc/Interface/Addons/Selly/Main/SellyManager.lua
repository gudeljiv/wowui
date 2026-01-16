local _, Addon = ...
local Core = Addon.Core
local ExportManager = Addon.ExportManager
local Functions = Addon.Functions
local ProfileManager = Addon.ProfileManager
local SellyManager = Addon.SellyManager
local UI = Addon.UI
local Colors = Addon.Colors

SellyManager.CurrentProfileName = ""
SellyManager.CurrentProfile = {}
SellyManager.IsNewProfile = true

function SellyManager:DisplaySellyManager(ProfileName)
    SellyManager.CurrentProfileName = ""
    SellyManager.CurrentProfile = {}
    SellyManager.IsNewProfile = true

    if (ProfileName and SellyLocalDB.Profiles[ProfileName]) then
        SellyManager.IsNewProfile = false
        SellyManager.CurrentProfileName = ProfileName
        SellyManager.CurrentProfile = SellyLocalDB.Profiles[ProfileName]
    end

    SellyManager:ResetSellyManager()

    if (not SellyManager.IsNewProfile) then
        SellyManager:LoadProfile()
    end

    UI:Show("SellyManager")
end

function SellyManager:ResetSellyManager()
    for Key, ItemColor in next, Core.ItemColors, nil do
        UI:SetChecked("SMCheckSell"..ItemColor, false)
        if (Key > 2) then
            UI:SetChecked("SMCheckSell"..ItemColor.."BoE", false)
            UI:SetEnabled("SMCheckSell"..ItemColor.."BoE", false)
        end
    end

    UI:SetChecked("SMCheckOptionAutoRepair", true)
    UI:SetChecked("SMCheckOptionAutoSell", false)

    UI:SetText("SFWhitelistTextbox.Textbox", "")
end

function SellyManager:LoadProfile()
    local WhitelistItems = ""

    for Key, ItemColor in next, Core.ItemColors, nil do

        local IsChecked = SellyManager.CurrentProfile["Sell"..ItemColor]
        UI:SetChecked("SMCheckSell"..ItemColor, IsChecked)

        if (Key > 2) then
            UI:SetChecked("SMCheckSell"..ItemColor.."BoE", SellyManager.CurrentProfile["Sell"..ItemColor.."BoE"])
            UI:SetEnabled("SMCheckSell"..ItemColor.."BoE", IsChecked)
        end

    end

    for Key, WhitelistItem in next, SellyManager.CurrentProfile.WhitelistItems, nil do
        WhitelistItems = WhitelistItems..Functions:Condition(strlen(WhitelistItems) > 0, "\n", "")..WhitelistItem
    end

    UI:SetChecked("SMCheckOptionAutoRepair", SellyManager.CurrentProfile.OptionAutoRepair)
    UI:SetChecked("SMCheckOptionAutoSell", SellyManager.CurrentProfile.OptionAutoSell)

    UI:SetText("SFWhitelistTextbox.Textbox", WhitelistItems)
end

function SellyManager:SaveProfile(NewProfileName)
    local ProfileName = Functions:Condition(NewProfileName, NewProfileName, SellyManager.CurrentProfileName)

    if (SellyManager.IsNewProfile and not NewProfileName) then
        SellyManager:EnterProfileName()
        return
    end

    -- Create Profile if not exists

    if (not SellyLocalDB.Profiles[ProfileName]) then
        SellyLocalDB.Profiles[ProfileName] = {}
    end

    -- Which items should be sold

    for Key, ItemColor in next, Core.ItemColors, nil do
        SellyLocalDB.Profiles[ProfileName]["Sell"..ItemColor] = UI:GetChecked("SMCheckSell"..ItemColor)
        if (Key > 2) then
            SellyLocalDB.Profiles[ProfileName]["Sell"..ItemColor.."BoE"] = UI:GetChecked("SMCheckSell"..ItemColor.."BoE")
        end
    end

    -- Whitelist

    SellyLocalDB.Profiles[ProfileName].WhitelistItems = {}
    
    local WhitelistItems = Functions:Split(UI:GetText("SFWhitelistTextbox.Textbox"), "\n")
    for Key, WhitelistItem in next, WhitelistItems, nil do
        WhitelistItem = Functions:Trim(WhitelistItem)
        if (strlen(WhitelistItem) > 1) then
            tinsert(SellyLocalDB.Profiles[ProfileName].WhitelistItems, WhitelistItem)
        end
    end

    -- Options

    SellyLocalDB.Profiles[ProfileName].OptionAutoRepair = UI:GetChecked("SMCheckOptionAutoRepair")
    SellyLocalDB.Profiles[ProfileName].OptionAutoSell = UI:GetChecked("SMCheckOptionAutoSell")

    -- Total earned copper

    if (SellyManager.IsNewProfile) then
        SellyLocalDB.Profiles[ProfileName].TotalEarnedCopper = 0
    end

    UI:Hide("SellyManager")
    ProfileManager:LoadProfile(ProfileName)
    ProfileManager:UpdateProfileList()
end

function SellyManager:EnterProfileName()
    local FrameSettings = {}
    FrameSettings.Title = Core.AddonName..": Save Profile"
    FrameSettings.Text = "Enter your profile name:"
    FrameSettings.LeftButtonText = "Save"
    FrameSettings.RightButtonText = "Cancel"
    UI:DisplayDialogTextbox(FrameSettings)

    UI:SetScript("OnClick", "DialogTextboxFrame.LeftButton", function(Self, Button)
        local EnteredProfileName = UI:GetText("DialogTextboxFrame.Textbox.Textbox")

        if (strlen(EnteredProfileName) == 0) then
            Functions:PrintAddon("Please enter a profile name.", "Error")
            return
        end

        if (ProfileManager:ProfileExists(EnteredProfileName)) then
            Functions:PrintAddon("This profile name already exists.", "Error")
            return
        end

        UI:Hide("DialogTextboxFrame")
        SellyManager:SaveProfile(EnteredProfileName)
    end)
end
