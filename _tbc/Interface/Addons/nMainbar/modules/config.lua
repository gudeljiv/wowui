local _, nMainbar = ...

-- Color Helper Function - Compatible with all WoW versions
local function MakeColor(r, g, b, a)
    -- IMPORTANT: CreateColor in Midnight returns userdata without GetRGBA/GetRGB
    -- We MUST create our own table instead of trying to extend it
    return {
        r = r, 
        g = g, 
        b = b, 
        a = a or 1,
        GetRGBA = function(self) 
            return self.r, self.g, self.b, self.a 
        end,
        GetRGB = function(self) 
            return self.r, self.g, self.b 
        end
    }
end

nMainbar.Config = {
    showPicomenu = true,
    combinedBags = false,  -- Taschen kombinieren
    debug = false,  -- Debug mode
    
    picomenu = {
        offsetX = 300,  -- X-Position relativ zu MainMenuBar
        offsetY = 8,    -- Y-Position relativ zu MainMenuBar
    },
    
    bags = {
        offsetX = 0,  -- X-Position relativ zu WorldFrame BOTTOMRIGHT
        offsetY = 0,  -- Y-Position relativ zu WorldFrame BOTTOMRIGHT
    },
    
    microMenu = {
        mouseover = true,  -- MicroMenu nur bei Mouseover anzeigen (Standard: aktiviert)
        hiddenAlpha = 0,   -- Transparenz wenn versteckt
        alpha = 1,         -- Transparenz wenn sichtbar
    },

    button = {
        showVehicleKeybinds = true,
        showKeybinds = false,
        showMacroNames = false,
        buttonOutOfRange = false,

        watchbarFontsize = 12,
        watchbarFont = STANDARD_TEXT_FONT,

        countFontsize = 19,
        countFont = "Interface\\AddOns\\nMainbar\\Media\\font.ttf",

        macronameFontsize = 15,
        macronameFont = "Interface\\AddOns\\nMainbar\\Media\\font.ttf",

        hotkeyFontsize = 18,
        hotkeyFont = "Interface\\AddOns\\nMainbar\\Media\\font.ttf",

        petHotKeyFontsize = 15,
    },

    color = {   -- Red, Green, Blue, Alpha
        Normal = MakeColor(1.0, 1.0, 1.0, 1.0),
        Mouseover = MakeColor(1.0, 1.0, 1.0, 1.0),  -- Mouseover-Rand (Standard: weiß = Textur-Originalfarbe)
        IsEquipped = MakeColor(0.0, 1.0, 0.0, 1.0),
        OutOfRange = MakeColor(0.8, 0.1, 0.1, 1.0),
        OutOfMana = MakeColor(0.3, 0.3, 1.0, 1.0),
        NotUsable = MakeColor(0.35, 0.35, 0.35, 1.0),

        HotKeyText = MakeColor(0.6, 0.6, 0.6, 1.0),
        MacroText = MakeColor(1.0, 1.0, 1.0, 1.0),
        CountText = MakeColor(1.0, 1.0, 1.0, 1.0),
    },

    -- Default mouseover color (for reset) - white = no tint = original texture color
    defaultMouseoverColor = {r = 1.0, g = 1.0, b = 1.0, a = 1.0},

    MainMenuBar = {
        moveableExtraBars = false,  -- Deaktiviert - verursacht Positionsprobleme
        hideGryphons = false,
    },

    vehicleBar = {
        scale = 0.80,
    },

    petBar = {
        mouseover = false,
        scale = 1,
        hiddenAlpha = 0,
        alpha = 1,
        vertical = false,
    },

    stanceBar = {
        hide = false,
        scale = 1,
        alpha = 1,
    },

    possessBar = {
        scale = 1,
        alpha = 1,
    },

    multiBarRight = {
        mouseover = false,
        scale = 1,
        hiddenAlpha = 0,
        alpha = 1,
    },

    multiBarBottomLeft = {
        mouseover = false,
        hiddenAlpha = 0,
        alpha = 1,
    },

    multiBarBottomRight = {
        mouseover = false,
        hiddenAlpha = 0,
        alpha = 1,
    },
}

-- Load saved config on ADDON_LOADED
local configFrame = CreateFrame("Frame")
configFrame:RegisterEvent("ADDON_LOADED")
configFrame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "nMainbar" then
        -- Merge saved config with defaults
        if nMainbarConfig then
            for k, v in pairs(nMainbarConfig) do
                -- NEVER merge 'color' table - it must use MakeColor()
                if k ~= "color" and k ~= "mouseoverColor" then
                    if type(v) == "table" and type(nMainbar.Config[k]) == "table" then
                        for k2, v2 in pairs(v) do
                            nMainbar.Config[k][k2] = v2
                        end
                    else
                        nMainbar.Config[k] = v
                    end
                end
            end
            -- Restore saved mouseover color (reject old wrong gold default)
            if nMainbarConfig.mouseoverColor then
                local mc = nMainbarConfig.mouseoverColor
                local wasOldGold = (mc.r == 1.0 and mc.b == 0.0 and mc.g ~= 1.0)
                if not wasOldGold then
                    nMainbar.Config.color.Mouseover = MakeColor(mc.r, mc.g, mc.b, mc.a)
                end
            end
        end
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

-- Helper to save config immediately
function nMainbar.SaveConfig()
    nMainbarConfig = {}
    for k, v in pairs(nMainbar.Config) do
        if k ~= "color" then  -- Don't save colors (except mouseover)
            nMainbarConfig[k] = v
        end
    end
    -- Save mouseover color separately (it's user-configurable)
    nMainbarConfig.mouseoverColor = {
        r = nMainbar.Config.color.Mouseover.r,
        g = nMainbar.Config.color.Mouseover.g,
        b = nMainbar.Config.color.Mouseover.b,
        a = nMainbar.Config.color.Mouseover.a,
    }
end
