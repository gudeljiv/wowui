local _, Addon = ...
local Core = Addon.Core
local ExportManager = Addon.ExportManager
local Functions = Addon.Functions
local ProfileManager = Addon.ProfileManager
local SellyManager = Addon.SellyManager
local UI = Addon.UI
local Colors = Addon.Colors
local Json = Addon.Json

----------------------------------------------------------------------------------------
-- EXPORT
----------------------------------------------------------------------------------------

--------------------------------------------
-- EXPORT: DISPLAY EXPORT MANAGER
--------------------------------------------

function ExportManager:DisplayExportManager(ProfileName)
    if (not ProfileManager:ProfileExists(ProfileName)) then return end

    local ExportedProfile = ExportManager:ExportProfile(ProfileName, SellyLocalDB.Profiles[ProfileName])

    UI:SetText("EMOptionsButton", Functions:PrintColor("Highlight Text", Colors.orange))
    UI:SetScript("OnClick", "EMOptionsButton", function(Self, Button)
        UI:HighlightText("ExportManager.Textbox.Textbox")
    end)

    UI:Show("ExportManager")

    UI:SetText("ExportManager.Textbox.Textbox", ExportedProfile)
    UI:SetFocus("ExportManager.Textbox.Textbox")
    UI:HighlightText("ExportManager.Textbox.Textbox")
end

--------------------------------------------
-- EXPORT: EXPORT PROFILE
--------------------------------------------

function ExportManager:ExportProfile(ProfileName, Profile)
    local JsonProfile = Json:Encode(Profile)
    local Result = ProfileName.."|"..JsonProfile

    return ExportManager:Encode(ProfileName.."|"..JsonProfile)
end

----------------------------------------------------------------------------------------
-- IMPORT
----------------------------------------------------------------------------------------

--------------------------------------------
-- IMPORT: DISPLAY IMPORT MANAGER
--------------------------------------------

function ExportManager:DisplayImportManager()
    UI:SetText("EMOptionsButton", Functions:PrintColor("Import", Colors.orange))
    UI:DisableButton("EMOptionsButton")

    UI:SetScript("OnClick", "EMOptionsButton", function(Self, Button)
        local CurrentText = UI:GetText("ExportManager.Textbox.Textbox")
        if (strlen(CurrentText) == 0) then return end

        local IsProfileImported = ExportManager:ImportProfile(CurrentText)
        if (not IsProfileImported) then return end

        UI:Hide("ExportManager")
    end)

    UI:Show("ExportManager")

    UI:SetText("ExportManager.Textbox.Textbox", "")
    UI:SetFocus("ExportManager.Textbox.Textbox")

    UI:SetScript("OnKeyUp", "ExportManager.Textbox.Textbox", function(Self, Key)
        local CurrentText = UI:GetText("ExportManager.Textbox.Textbox")
        if (strlen(CurrentText) > 0) then
            UI:EnableButton("EMOptionsButton")
        else
            UI:DisableButton("EMOptionsButton")
        end
    end)
end

--------------------------------------------
-- IMPORT: IMPORT PROFILE
--------------------------------------------

function ExportManager:ImportProfile(EncodedProfile)
    if (not EncodedProfile) then return false end

    local DecodedProfile = ExportManager:Decode(EncodedProfile)
    if (not DecodedProfile) then
        Functions:PrintAddon("The imported profile could not be decoded.", "Error")
        return false
    end

    if (not Functions:StringContains(DecodedProfile, "|")) then
        Functions:PrintAddon("The imported profile is wrong formatted. (1)", "Error")
        return false
    end

    local Split = Functions:Split(DecodedProfile, "|", 2)
    local ProfileName = Split[1]
    local JsonProfile = Split[2]

    if (not JsonProfile or strlen(JsonProfile) == 0) then
        Functions:PrintAddon("The imported profile is empty.", "Error")
        return false
    end

    if (not Functions:StringContains(JsonProfile, "{") or not Functions:StringContains(JsonProfile, "}")) then
        Functions:PrintAddon("The imported profile is wrong formatted. (2)", "Error")
        return false
    end

    if (strlen(ProfileName) == 0 or SellyLocalDB.Profiles[ProfileName]) then
        ProfileName = "New profile"
        local i = 1
        while (SellyLocalDB.Profiles[ProfileName]) do
            i = i + 1
            ProfileName = "New profile "..i
        end
    end

    SellyLocalDB.Profiles[ProfileName] = Json:Decode(JsonProfile)
    ProfileManager:UpdateProfileList()

    Functions:PrintAddon("Profile imported: "..Functions:PrintColor(ProfileName, Colors.blue))

    return true
end

----------------------------------------------------------------------------------------
-- DEFLATE (ENCODE/DECODE)
----------------------------------------------------------------------------------------

function ExportManager:Encode(Value)
    local LibDeflate = LibStub("LibDeflate")

	local Result = LibDeflate:CompressDeflate(Value)
	Result = LibDeflate:EncodeForWoWAddonChannel(Result)
	Result = LibDeflate:EncodeForPrint(Result)
	
	return Result
end

function ExportManager:Decode(Value)
    local LibDeflate = LibStub("LibDeflate")

	local Result = LibDeflate:DecodeForPrint(Value)
    if (not Result) then return end

	Result = LibDeflate:DecodeForWoWAddonChannel(Result)
    if (not Result) then return end
    
	Result = LibDeflate:DecompressDeflate(Result)
	
	return Result
end
