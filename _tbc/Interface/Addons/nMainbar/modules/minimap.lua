local _, nMainbar = ...
local cfg = nMainbar.Config

-- LibDBIcon integration for minimap button
local ldb = LibStub:GetLibrary("LibDataBroker-1.1", true)
local icon = LibStub:GetLibrary("LibDBIcon-1.0", true)

if not ldb or not icon then
    return
end

-- Store settingsCategoryID globally for access from minimap button
nMainbar.settingsCategoryID = nil

-- Create data broker object
local nMainbarLDB = ldb:NewDataObject("nMainbar", {
    type = "launcher",
    label = "nMainbar",
    icon = 5872030, -- inv_crestupgrade_xalatath_gilded
    OnClick = function(clickedFrame, button)
        if button == "LeftButton" then
            -- Open settings - use multiple fallback methods
            if Settings and Settings.OpenToCategory then
                -- Modern API - try with stored category ID first
                if nMainbar.settingsCategoryID then
                    Settings.OpenToCategory(nMainbar.settingsCategoryID)
                else
                    -- Fallback: search for category
                    local category = Settings.GetCategory("nMainbar")
                    if category then
                        Settings.OpenToCategory(category:GetID())
                    end
                end
            elseif InterfaceOptionsFrame_OpenToCategory then
                -- Classic API
                InterfaceOptionsFrame_OpenToCategory("nMainbar")
                InterfaceOptionsFrame_OpenToCategory("nMainbar")
            end
        end
    end,
    OnTooltipShow = function(tooltip)
        if not tooltip or not tooltip.AddLine then return end
        tooltip:AddLine("|cffCC3333n|rMainbar")
        tooltip:AddLine(" ")
        tooltip:AddLine("|cffFFFFFFLeft-click:|r Open Settings", 0.8, 0.8, 0.8)
    end,
})

-- Initialize minimap button
local function InitMinimapButton()
    -- Initialize saved variables for minimap if not exists
    if not nMainbarConfig then
        nMainbarConfig = {}
    end
    
    if not nMainbarConfig.minimap then
        nMainbarConfig.minimap = {
            hide = false,
            minimapPos = 220,
            radius = 80,
        }
    end
    
    -- Register with LibDBIcon
    icon:Register("nMainbar", nMainbarLDB, nMainbarConfig.minimap)
    
    -- Apply visibility setting
    if nMainbarConfig.minimap.hide then
        icon:Hide("nMainbar")
    else
        icon:Show("nMainbar")
    end
end

-- Store functions for GUI access
nMainbar.ShowMinimapButton = function()
    if icon and nMainbarConfig and nMainbarConfig.minimap then
        nMainbarConfig.minimap.hide = false
        icon:Show("nMainbar")
    end
end

nMainbar.HideMinimapButton = function()
    if icon and nMainbarConfig and nMainbarConfig.minimap then
        nMainbarConfig.minimap.hide = true
        icon:Hide("nMainbar")
    end
end

nMainbar.IsMinimapButtonShown = function()
    if nMainbarConfig and nMainbarConfig.minimap then
        return not nMainbarConfig.minimap.hide
    end
    return true -- Default to shown
end

-- Initialize on login with delay to ensure settings are registered
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        -- Delay initialization to ensure GUI is registered first
        C_Timer.After(2, function()
            InitMinimapButton()
        end)
        self:UnregisterEvent("PLAYER_LOGIN")
    end
end)
