local _, Addon = ...
local Core = Addon.Core
local Functions = Addon.Functions
local ProfileManager = Addon.ProfileManager
local SellyManager = Addon.SellyManager
local ExportManager = Addon.ExportManager
local UI = Addon.UI
local Colors = Addon.Colors
local Items = Addon.Items

----------------------------------------------------------------------------------------
-- PROFILE STRUCTURE
----------------------------------------------------------------------------------------

-- ProfileName
-- - .SellGray = false
-- - .SellGrayBoE = false
-- - .SellWhite = false
-- - .SellWhiteBoE = false
-- - .SellGreen = false
-- - .SellGreenBoE = false
-- - .SellBlue = false
-- - .SellBlueBoE = false
-- - .SellPurple = false
-- - .SellPurpleBoE = false
-- - .Whitelist = Table
-- - .OptionAutoRepair = false
-- - .OptionAutoSell = false
-- - .TotalEarnedCopper = 0

-- Relevance:
-- SellyManager:LoadProfile
-- SellyManager:SaveProfile
-- SellyManager:ResetSellyManager
-- ProfileManager:CopyProfile

----------------------------------------------------------------------------------------
-- PROFILE MANAGER
----------------------------------------------------------------------------------------

function ProfileManager:IsProfileLoaded()
    return strlen(SellyLocalDB.Settings.LoadedProfile) > 0 and SellyLocalDB.Profiles[SellyLocalDB.Settings.LoadedProfile]
end

function ProfileManager:ProfileExists(ProfileName)
    return SellyLocalDB.Profiles[ProfileName]
end

function ProfileManager:LoadProfile(ProfileName)
    if (not ProfileManager:ProfileExists(ProfileName)) then
        Functions:PrintAddon("Profile "..Functions:PrintColor(ProfileName, Colors.blue).." does not exist.", "Error")
        return false
    end

    SellyLocalDB.Settings.LoadedProfile = ProfileName

    return true
end

function ProfileManager:UnloadProfile()
    SellyLocalDB.Settings.LoadedProfile = ""
end

function ProfileManager:RenameProfile(OldProfileName, NewProfileName)
    if (not ProfileManager:ProfileExists(OldProfileName)) then return end

    if (not NewProfileName) then
        ProfileManager:EnterProfileName(OldProfileName)
        return
    end

    if (OldProfileName == NewProfileName) then return end

    SellyLocalDB.Profiles[NewProfileName] = SellyLocalDB.Profiles[OldProfileName]
    SellyLocalDB.Profiles[OldProfileName] = nil

    if (SellyLocalDB.Settings.LoadedProfile == OldProfileName) then
        ProfileManager:LoadProfile(NewProfileName)
    end

    ProfileManager:UpdateProfileList()
end

function ProfileManager:EnterProfileName(OldProfileName)
    local FrameSettings = {}
    FrameSettings.Title = Core.AddonName..": Rename Profile"
    FrameSettings.Text = "Enter your new profile name:"
    FrameSettings.TextboxText = OldProfileName
    FrameSettings.HighlightTextboxText = true
    FrameSettings.LeftButtonText = "Save"
    FrameSettings.RightButtonText = "Cancel"
    UI:DisplayDialogTextbox(FrameSettings)

    UI:SetScript("OnClick", "DialogTextboxFrame.LeftButton", function(Self, Button)
        local EnteredProfileName = UI:GetText("DialogTextboxFrame.Textbox.Textbox")

        if (strlen(EnteredProfileName) == 0) then
            Functions:PrintAddon("Please enter a profile name.", "Error")
            return
        end

        if (EnteredProfileName == OldProfileName) then
            UI:Hide("DialogTextboxFrame")
            return
        end

        if (ProfileManager:ProfileExists(EnteredProfileName)) then
            Functions:PrintAddon("This profile name already exists.", "Error")
            return
        end

        UI:Hide("DialogTextboxFrame")
        ProfileManager:RenameProfile(OldProfileName, EnteredProfileName)
    end)
end

function ProfileManager:CopyProfile(ProfileName)
    if (not ProfileManager:ProfileExists(ProfileName)) then return end

    local Copy = " (Copy 1)"
    local i = 1
    while (SellyLocalDB.Profiles[ProfileName..Copy]) do
        i = i + 1
        Copy = " (Copy "..i..")"
    end

    -- Create a new profile

    SellyLocalDB.Profiles[ProfileName..Copy] = {}

    -- Copy sell settings

    for Key, ItemColor in next, Core.ItemColors, nil do
        SellyLocalDB.Profiles[ProfileName..Copy]["Sell"..ItemColor] = SellyLocalDB.Profiles[ProfileName]["Sell"..ItemColor]
        if (Key > 2) then
            SellyLocalDB.Profiles[ProfileName..Copy]["Sell"..ItemColor.."BoE"] = SellyLocalDB.Profiles[ProfileName]["Sell"..ItemColor.."BoE"]
        end
    end

    -- Copy whitelist

    SellyLocalDB.Profiles[ProfileName..Copy].WhitelistItems = {}

    for Key, WhitelistItem in next, SellyLocalDB.Profiles[ProfileName].WhitelistItems, nil do
        tinsert(SellyLocalDB.Profiles[ProfileName..Copy].WhitelistItems, WhitelistItem)
    end

    -- Copy options

    SellyLocalDB.Profiles[ProfileName..Copy].OptionAutoRepair = SellyLocalDB.Profiles[ProfileName].OptionAutoRepair
    SellyLocalDB.Profiles[ProfileName..Copy].OptionAutoSell = SellyLocalDB.Profiles[ProfileName].OptionAutoSell
    SellyLocalDB.Profiles[ProfileName..Copy].TotalEarnedCopper = 0

    ProfileManager:UpdateProfileList()
end

function ProfileManager:DeleteProfile(ProfileName, ConfirmDeletion)
    if (not ProfileManager:ProfileExists(ProfileName)) then return end

    if (not ConfirmDeletion) then
        ProfileManager:ConfirmDeletion(ProfileName)
        return
    end

    if (SellyLocalDB.Settings.LoadedProfile == ProfileName) then
        ProfileManager:UnloadProfile()
    end

    SellyLocalDB.Profiles[ProfileName] = nil

    ProfileManager:UpdateProfileList()
end

function ProfileManager:ConfirmDeletion(ProfileName)
    local FrameSettings = {}
    FrameSettings.Title = Core.AddonName..": Confirm Deletion"
    FrameSettings.Text = "Do you really want to delete "..Functions:PrintColor(ProfileName, Colors.blue).."?"
    FrameSettings.LeftButtonText = "Delete"
    FrameSettings.RightButtonText = "Cancel"
    UI:DisplayDialog(FrameSettings)

    UI:SetScript("OnClick", "DialogFrame.LeftButton", function(Self, Button)
        UI:Hide("DialogFrame")
        ProfileManager:DeleteProfile(ProfileName, true)
    end)
end

function ProfileManager:GetOrderedProfileNames()
    local OrderedProfileNames = {}
    for ProfileName in pairs(SellyLocalDB.Profiles) do
        tinsert(OrderedProfileNames, ProfileName)
    end

    table.sort(OrderedProfileNames)

    return OrderedProfileNames
end

function ProfileManager:UpdateElements()
    if (Functions:IsEmptyTable(SellyLocalDB.Profiles)) then
        UI:Show("PMIsEmptyButton", true)
    else
        UI:Hide("PMIsEmptyButton")
    end
end

function ProfileManager:UpdateProfileList()
    ProfileManager:UpdateElements()
    UI:RemoveAllScrollItems("PMScroll")

    local i = 0
    for Key, ProfileName in next, ProfileManager:GetOrderedProfileNames(), nil do
        -- Vars

        i = i + 1
        local TotalEarnedCopper = SellyLocalDB.Profiles[ProfileName].TotalEarnedCopper
        local FrameName = "ScrollItem"..i

        -- Functions

        local function SelectProfile()
            if (SellyLocalDB.Settings.LoadedProfile == ProfileName) then return end

            local IsProfileLoaded = ProfileManager:LoadProfile(ProfileName)
            if (IsProfileLoaded) then
                UI:MarkScrollItem("PMScroll", FrameName)
            end
        end

        -- Profile/scroll item

        local FrameSettings = {}
        FrameSettings.Name = FrameName
        FrameSettings.ScrollFrameName = "PMScroll"
        FrameSettings.Title = ProfileName
        FrameSettings.Info = Functions:PrintGold(TotalEarnedCopper)
        FrameSettings.CustomIcons = {}

        local CustomIcon = {}
        CustomIcon.Name = "Delete"
        CustomIcon.AssetName = "Trash.blp"
        CustomIcon.AssetHoverName = "Trash-Hover.blp"
        CustomIcon.Size = { 16, 16 }
        CustomIcon.Point1 = { "RIGHT", FrameName, "RIGHT", -10, 0 }
        tinsert(FrameSettings.CustomIcons, CustomIcon)

        CustomIcon = {}
        CustomIcon.Name = "Rename"
        CustomIcon.AssetName = "Pen.blp"
        CustomIcon.AssetHoverName = "Pen-Hover.blp"
        CustomIcon.Size = { 16, 16 }
        CustomIcon.Point1 = { "RIGHT", FrameName, "RIGHT", -35, 0 }
        tinsert(FrameSettings.CustomIcons, CustomIcon)

        UI:CreateScrollItem(FrameSettings)

        -- Context menu

        FrameSettings = {}
        FrameSettings.ClickFrameName = FrameName
        FrameSettings.Items = {}

        local Item = {}
        Item.Text = "Edit Profile..."
        Item.Func = function(Self, Button) SelectProfile(); SellyManager:DisplaySellyManager(ProfileName) end
        tinsert(FrameSettings.Items, Item)

        Item = {}
        Item.Text = "Rename Profile..."
        Item.Func = function(Self, Button) ProfileManager:RenameProfile(ProfileName) end
        tinsert(FrameSettings.Items, Item)

        Item = {}
        Item.Text = "Copy Profile..."
        Item.Func = function(Self, Button) ProfileManager:CopyProfile(ProfileName) end
        tinsert(FrameSettings.Items, Item)

        Item = {}
        Item.Text = "Export Profile..."
        Item.Func = function(Self, Button)
            ExportManager:DisplayExportManager(ProfileName)
        end
        tinsert(FrameSettings.Items, Item)

        Item = {}
        Item.Text = "-"
        tinsert(FrameSettings.Items, Item)

        Item = {}
        Item.Text = "Delete Profile"
        Item.Func = function(Self, Button) ProfileManager:DeleteProfile(ProfileName) end
        tinsert(FrameSettings.Items, Item)

        UI:CreateContextMenu(FrameSettings)

        -- Mark loaded profile

        if (SellyLocalDB.Settings.LoadedProfile == ProfileName) then
            UI:MarkScrollItem("PMScroll", FrameName, true)
        end

        -- Select profile / Show context menu

        UI:SetScript("OnMouseUp", FrameName, function(Self, Button)
            if (Button == "LeftButton") then
                SelectProfile()
            elseif (Button == "RightButton") then
                UI:ShowContextMenu(FrameName)
            end
        end)

        -- Edit profile

        UI:SetScript("OnDoubleClick", FrameName, function(Self, Button)
            SellyManager:DisplaySellyManager(ProfileName)
        end)

        -- Rename profile

        UI:SetScript("OnClick", FrameName..".Rename", function(Self, Button)
            ProfileManager:RenameProfile(ProfileName)
        end)

        -- Delete profile

        UI:SetScript("OnClick", FrameName..".Delete", function(Self, Button)
            ProfileManager:DeleteProfile(ProfileName)
        end)

    end
end
