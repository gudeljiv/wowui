-- settings.lua handles global settings such as UseWhenSelecting, UseOnRightClick, etc.
-- see saved for per-character saved flyout values

local _,s = ...
s.settings = {}

SelectSettings = {}

s.settings.defaults = {
	UseWhenSelecting = false,
	UseOnRightClick = false,
	DontSelectWithAlt = false,
	DontAddToMacroTooltip = false,
    EquipslotOnlySoulbound = false,
    OnlySummonableMounts = false,
    UseFlatStyle = false,
    ShowSubtext = WOW_PROJECT_ID == WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC, -- default to true for classic clients
}

-- load up values from savedvar; call at PLAYER_LOGIN or later
function s.settings:Load()
    -- set defaults if undefined
    for k,v in pairs(s.settings.defaults) do
        if SelectSettings[k]==nil then
            SelectSettings[k] = v
        end
    end
    -- and set in root
    for k,v in pairs(SelectSettings) do
        s.root:SetAttribute(k,v)
    end
end

function s.settings:Get(setting)
    return SelectSettings[setting]
end

-- in addition to setting it in the savedvar, also set it in root so it can be accessed in secure environment
function s.settings:Set(setting,value)
    SelectSettings[setting] = value
    s.root:SetAttribute(setting,value)
    if setting=="UseFlatStyle" then
        s.settings:UpdateFlatStyle()
    end
end

-- changes all flyouts and their buttons to the current style; called when style changes
function s.settings:UpdateFlatStyle()
    for _,flyout in pairs(s.root.flyouts) do
        flyout:Hide()
        if not flyout.inactive then -- only style active flyouts
            s.flyout:Style(flyout)
            for _,button in ipairs(flyout.buttons) do
                s.button:Style(button)
            end
        end
    end
end
