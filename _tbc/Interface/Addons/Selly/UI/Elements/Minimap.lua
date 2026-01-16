local AddonName, Addon = ...
local Core = Addon.Core
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets

UI.Minimap = nil

function UI:CreateMinimapIcon()
    local LibDataBroker = LibStub("LibDataBroker-1.1")
    local LibDBIcon = LibStub("LibDBIcon-1.0")

    UI.Minimap = LibDataBroker:NewDataObject(AddonName, {
        type = "data source",
        icon = Assets.Images["Logo-Minimap.blp"],

        OnClick = function(Self, Button)
            if Button == "LeftButton" then
                UI:Toggle("ProfileManager")
            elseif Button == "RightButton" then
                UI:ToggleAddon()
            end
        end,
        
        OnTooltipShow = function(Tooltip)
            Tooltip:AddLine(Core.AddonName)
        end,
    })

    LibDBIcon:Register(AddonName, UI.Minimap, {
        hide = false,
        minimapPos = SellyLocalDB.Settings.MinimapIconPosition,
        radius = Functions:Condition(Core.IsRetail, 100, 80)
    })

    _G["LibDBIcon10_"..AddonName]:HookScript("OnDragStop", function(Self)
        SellyLocalDB.Settings.MinimapIconPosition = math.floor(Self.db.minimapPos)
    end)
end
