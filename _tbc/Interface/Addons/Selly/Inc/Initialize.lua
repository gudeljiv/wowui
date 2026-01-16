local AddonName, Addon = ...
local Core = Addon.Core
local Initialize = Addon.Initialize
local Functions = Addon.Functions
local Assets = Addon.Assets
local UI = Addon.UI
local ProfileManager = Addon.ProfileManager
local Items = Addon.Items
local Colors = Addon.Colors

function Initialize:Init()
    Initialize:Settings()
    Initialize:Assets()
    Initialize:GUI()
    Initialize:Profiles()
    Initialize:Done()
end

function Initialize:Settings()
    if (not SellyGlobalDB) then SellyGlobalDB = {} end
    
    if (not SellyLocalDB) then SellyLocalDB = {} end
    if (not SellyLocalDB.Profiles) then SellyLocalDB.Profiles = {} end
    if (not SellyLocalDB.Settings) then SellyLocalDB.Settings = {} end

    if (not SellyLocalDB.Settings.LoadedProfile) then SellyLocalDB.Settings.LoadedProfile = "" end
    if (not SellyLocalDB.Settings.MinimapIconPosition) then SellyLocalDB.Settings.MinimapIconPosition = 180 end

    if (SellyLocalDB.Settings.IsAddonEnabled == nil) then SellyLocalDB.Settings.IsAddonEnabled = true end
end

function Initialize:Assets()
    -- for SoundFileName, SoundFilePath in next, Assets.Sounds, nil do
    --     MuteSoundFile(Assets.Sounds[SoundFileName])
    --     PlaySoundFile(Assets.Sounds[SoundFileName])
    --     UnmuteSoundFile(Assets.Sounds[SoundFileName])
    -- end

    local Preloader = CreateFrame("Button", nil, UIParent)
    Preloader:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)
    Preloader:SetSize(0, 0)

    for ImageFileName, ImageFilePath in next, Assets.Images, nil do
        Preloader:SetNormalTexture(ImageFilePath)
    end

    Preloader:Hide()
end

function Initialize:GUI()
    UI:CreateProfileManager()
    UI:CreateSellyManager()
    UI:CreateExportManager()
    UI:CreateProfileManagerTitleButtons()
    UI:CreateDialog()
    UI:CreateDialogTextbox()
    UI:CreateMinimapIcon()

    UI:CreateVendorOptions()
end

function Initialize:Profiles()
    if (strlen(SellyLocalDB.Settings.LoadedProfile) > 0) then
        local IsProfileLoaded = ProfileManager:LoadProfile(SellyLocalDB.Settings.LoadedProfile)
        if (IsProfileLoaded) then
            Functions:PrintAddon("Loaded profile "..Functions:PrintColor(SellyLocalDB.Settings.LoadedProfile, "Blue")..".")
        end
    end

    ProfileManager:UpdateProfileList()
end

function Initialize:Done()
    local AddonVersion = C_AddOns.GetAddOnMetadata(AddonName, "Version")
    Functions:PrintAddon("Initialized. (v"..AddonVersion..")")

    if (not SellyLocalDB.Settings.IsAddonEnabled) then
        Functions:PrintAddon(Functions:PrintColor("Disabled", Colors.red)..".")
    end
end
