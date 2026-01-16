local AddonName, Addon = ...

--------------------------------------------
-- NAMESPACES
--------------------------------------------

Addon.Core = {}
Addon.Main = {}
Addon.Functions = {}
Addon.Initialize = {}
Addon.UI = {}
Addon.Assets = {}
Addon.ProfileManager = {}
Addon.SellyManager = {}
Addon.ExportManager = {}
Addon.Items = {}
Addon.Events1 = {}
Addon.Events2 = {}
Addon.Colors = {}
Addon.Json = {}

--------------------------------------------
-- VARS
--------------------------------------------

Addon.Core.AddonName = "Selly"
Addon.Core.AddonNameShort = Addon.Core.AddonName
Addon.Core.FrameNameShort = Addon.Core.AddonNameShort.."."

Addon.Core.IsClassicEra = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
Addon.Core.IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
Addon.Core.IsClassic = not Addon.Core.IsClassicEra and not Addon.Core.IsRetail

Addon.Core.ItemColors = { "Gray", "White", "Green", "Blue", "Purple" }

--------------------------------------------
-- ASSETS
--------------------------------------------

local AssetsPath = "Interface\\AddOns\\"..AddonName.."\\Assets"

Addon.Assets.Fonts = {}
Addon.Assets.Fonts["Asap.ttf"] =                        AssetsPath.."\\Fonts\\Asap.ttf"

Addon.Assets.Images = {}
Addon.Assets.Images["Logo.blp"] =                       AssetsPath.."\\Images\\Logo.blp"                    -- 32x32
Addon.Assets.Images["Logo-Minimap.blp"] =               AssetsPath.."\\Images\\Logo-Minimap.blp"            -- 32x32
Addon.Assets.Images["Logo-Minimap-Disabled.blp"] =      AssetsPath.."\\Images\\Logo-Minimap-Disabled.blp"   -- 32x32
Addon.Assets.Images["Check.blp"] =                      AssetsPath.."\\Images\\Check.blp"
Addon.Assets.Images["Check-Hover.blp"] =                AssetsPath.."\\Images\\Check-Hover.blp"
Addon.Assets.Images["Close.blp"] =                      AssetsPath.."\\Images\\Close.blp"                   -- 32x32
Addon.Assets.Images["Close-Hover.blp"] =                AssetsPath.."\\Images\\Close-Hover.blp"             -- 32x32
Addon.Assets.Images["Settings.blp"] =                   AssetsPath.."\\Images\\Settings.blp"                -- 32x32
Addon.Assets.Images["Settings-Hover.blp"] =             AssetsPath.."\\Images\\Settings-Hover.blp"          -- 32x32
Addon.Assets.Images["Plus.blp"] =                       AssetsPath.."\\Images\\Plus.blp"                    -- 32x32
Addon.Assets.Images["Plus-Hover.blp"] =                 AssetsPath.."\\Images\\Plus-Hover.blp"              -- 32x32
Addon.Assets.Images["Trash.blp"] =                      AssetsPath.."\\Images\\Trash.blp"                   -- 32x32
Addon.Assets.Images["Trash-Hover.blp"] =                AssetsPath.."\\Images\\Trash-Hover.blp"             -- 32x32
Addon.Assets.Images["Pen.blp"] =                        AssetsPath.."\\Images\\Pen.blp"                     -- 32x32
Addon.Assets.Images["Pen-Hover.blp"] =                  AssetsPath.."\\Images\\Pen-Hover.blp"               -- 32x32
Addon.Assets.Images["Import.blp"] =                     AssetsPath.."\\Images\\Import.blp"                  -- 32x32
Addon.Assets.Images["Import-Hover.blp"] =               AssetsPath.."\\Images\\Import-Hover.blp"            -- 32x32

Addon.Assets.Sounds = {}

--------------------------------------------
-- COLORS
--------------------------------------------

Addon.Colors.white			= "#ffffff"
Addon.Colors.black			= "#000000"
Addon.Colors.green			= "#1EFF0C"
Addon.Colors.red			= "#ff0000"
Addon.Colors.heirloom		= "#E6CC80"
Addon.Colors.heirloom2		= "#ffeaad"
Addon.Colors.orange		    = "#ffd100"
Addon.Colors.orange2		= "#FF8000"
Addon.Colors.orange3		= "#ffd100"
Addon.Colors.purple		    = "#A335EE"
Addon.Colors.whisper		= "#FF7EFF"
Addon.Colors.grey			= "#cccccc"
Addon.Colors.gray			= "#cccccc"
Addon.Colors.blue			= "#34c0eb"
Addon.Colors.disabled		= "#5c5c5c"

Addon.Colors.itemGray		= "#9d9d9d"
Addon.Colors.itemWhite		= "#ffffff"
Addon.Colors.itemGreen		= "#1eff00"
Addon.Colors.itemBlue		= "#0070dd"
Addon.Colors.itemPurple		= "#a335ee"

--------------------------------------------
-- EVENTS #1
--------------------------------------------

Addon.Events1 = CreateFrame("Frame")
Addon.Events1:SetScript("OnEvent", function(Self, Event, ...) Addon.Events1[Event](Addon, ...) end)

Addon.Events1:RegisterEvent("ADDON_LOADED")
Addon.Events1:RegisterEvent("MERCHANT_SHOW")
Addon.Events1:RegisterEvent("MERCHANT_CLOSED")

--------------------------------------------
-- EVENTS #2
--------------------------------------------

Addon.Events2 = CreateFrame("Frame")
Addon.Events2:SetScript("OnEvent", function(Self, Event, ...) Addon.Events2[Event](Addon, ...) end)

--------------------------------------------
-- INIT
--------------------------------------------

function Addon.Events1:ADDON_LOADED(WhichAddonName)
    if (WhichAddonName ~= AddonName) then return end

    Addon.Initialize:Init()
    Addon.Events1:UnregisterEvent("ADDON_LOADED")
end
