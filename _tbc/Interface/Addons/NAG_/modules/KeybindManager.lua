--- @module "NAG.KeybindManager"
--- Keybind resolution and display system for NAG addon
---
--- Provides spell keybind resolution and frame overlay system using hero-lib patterns.
--- Battle-tested framework based on hero-lib Action.lua (~500 lines vs 4,616 in old implementation).
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...

-- ============================ ADDON ACCESS ============================
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ UTILITY ACCESS ============================
local WoWAPI = ns.WoWAPI
local LSM = ns.LibSharedMedia
local format = string.format

-- ============================ WOW API LOCALIZATION ============================
local GetActionInfo = _G.GetActionInfo
local GetActionText = _G.GetActionText
local GetActionTexture = _G.GetActionTexture
local GetBindingKey = _G.GetBindingKey
local GetBonusBarOffset = _G.GetBonusBarOffset
local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture
local HasAction = _G.HasAction
local UnitClass = _G.UnitClass
local CreateFrame = _G.CreateFrame
local GetMacroSpell = _G.GetMacroSpell
local GetMacroItem = _G.GetMacroItem
local GetMacroInfo = _G.GetMacroInfo
local mathceil = math.ceil
local strsplit = strsplit
local strlower = strlower
local strsub = strsub
local strupper = strupper
local tinsert = tinsert
local tremove = tremove
local sort = table.sort
local min = math.min

-- ============================ CONSTANTS ============================

-- Action slot range: 1-180 (action bars), 73-120 (stance bars), 121-144 (override/possess/skyriding)
local MAX_ACTION_SLOTS = 180
-- NUM_ACTIONBAR_PAGES and NUM_ACTIONBAR_BUTTONS are WoW globals (6 and 12)

-- Button configuration by UI addon (from hero-lib)
local ButtonByAddOn = {
    Bartender = {
        [1] = { "BT4Button", "CLICK BT4Button%i:LeftButton" },
    },
    Blizzard = {
        [1]  = { "ActionButton",              "ACTIONBUTTON%i" },          -- Edit Mode Bar 1
        [6]  = { "MultiBarBottomLeftButton",  "MULTIACTIONBAR1BUTTON%i" }, -- Edit Mode Bar 2
        [5]  = { "MultiBarBottomRightButton", "MULTIACTIONBAR2BUTTON%i" }, -- Edit Mode Bar 3
        [3]  = { "MultiBarRightButton",       "MULTIACTIONBAR3BUTTON%i" }, -- Edit Mode Bar 4
        [4]  = { "MultiBarLeftButton",        "MULTIACTIONBAR4BUTTON%i" }, -- Edit Mode Bar 5
        [2]  = { "MultiBar5Button",           "MULTIACTIONBAR5BUTTON%i" }, -- Edit Mode Bar 6
        [7]  = { "MultiBar6Button",           "MULTIACTIONBAR6BUTTON%i" }, -- Edit Mode Bar 7
        [8]  = { "MultiBar7Button",           "MULTIACTIONBAR7BUTTON%i" }, -- Edit Mode Bar 8
        [9]  = { "MultiBar8Button",           "MULTIACTIONBAR8BUTTON%i" }, -- Unknown
        [10] = { "MultiBar9Button",           "MULTIACTIONBAR9BUTTON%i" }, -- Unknown
    },
    -- Dominos: Bar 1 uses ACTIONBUTTON1-12 (standard). Bars 2,7-10 use CLICK DominosActionButton{actionSlot}:HOTKEY.
    -- Frame names: Bar 1 = DominosActionButton1-12, Bar 2 = DominosActionButton13-24, Bar 7-10 = DominosActionButton73-120.
    Dominos = {
        [1]  = { "DominosActionButton",      "ACTIONBUTTON%i"                         },
        [2]  = { "DominosActionButton",      "CLICK DominosActionButton%i:HOTKEY" },
        [3]  = { "MultiBarRightActionButton","MULTIACTIONBAR3BUTTON%i"                },
        [4]  = { "MultiBarLeftActionButton", "MULTIACTIONBAR4BUTTON%i"                },
        [5]  = { "MultiBarBottomRightActionButton", "MULTIACTIONBAR2BUTTON%i"        },
        [6]  = { "MultiBarBottomLeftActionButton",  "MULTIACTIONBAR1BUTTON%i"         },
        [7]  = { "DominosActionButton",      "CLICK DominosActionButton%i:HOTKEY" },
        [8]  = { "DominosActionButton",      "CLICK DominosActionButton%i:HOTKEY" },
        [9]  = { "DominosActionButton",      "CLICK DominosActionButton%i:HOTKEY" },
        [10] = { "DominosActionButton",      "CLICK DominosActionButton%i:HOTKEY" },
    },
    ElvUI = {
        [1]  = { "ElvUI_Bar1Button",  "ACTIONBUTTON%i" },
        [2]  = { "ElvUI_Bar2Button",  "ELVUIBAR2BUTTON%i" },
        [3]  = { "ElvUI_Bar3Button",  "MULTIACTIONBAR3BUTTON%i" },
        [4]  = { "ElvUI_Bar4Button",  "MULTIACTIONBAR4BUTTON%i" },
        [5]  = { "ElvUI_Bar5Button",  "MULTIACTIONBAR2BUTTON%i" },
        [6]  = { "ElvUI_Bar6Button",  "MULTIACTIONBAR1BUTTON%i" },
        [7]  = { "ElvUI_Bar7Button",  "ELVUIBAR7BUTTON%i" },
        [8]  = { "ElvUI_Bar8Button",  "ELVUIBAR8BUTTON%i" },
        [9]  = { "ElvUI_Bar9Button",  "ELVUIBAR9BUTTON%i" },
        [10] = { "ElvUI_Bar10Button", "ELVUIBAR10BUTTON%i" },
    },
}

-- ============================ MODULE DEFAULTS ============================

local defaults = {
    global = {
        enableKeybinds = true,
        enableKeybindsPrimaryOnly = false,
        keybindTextColor = {1, 1, 1, 1},
        -- Per-group keybind settings (legacy and modern groups)
        keybindGroups = {
            -- Legacy groups
            primary = {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 18,
                font = "Friz Quadrata TT",
            },
            above = {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 12,
                font = "Friz Quadrata TT",
            },
            below = {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 12,
                font = "Friz Quadrata TT",
            },
            left = {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 12,
                font = "Friz Quadrata TT",
            },
            right = {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 12,
                font = "Friz Quadrata TT",
            },
            aoe = {
                anchor = "BOTTOMRIGHT",
                offsetX = -2,
                offsetY = 2,
                fontSize = 12,
                font = "Friz Quadrata TT",
            },
            -- Modern groups
            main = {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 18,
                font = "Friz Quadrata TT",
            },
            cooldowns = {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 12,
                font = "Friz Quadrata TT",
            },
            interrupts = {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 12,
                font = "Friz Quadrata TT",
            },
            defensives = {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 12,
                font = "Friz Quadrata TT",
            },
            sequence = {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 12,
                font = "Friz Quadrata TT",
            },
        },
    },
    char = {
        -- Character-specific settings
        keybindOverrides = {
            spell = {},         -- { [SpellID] = Keybind }
            item = {},         -- { [ItemID] = Keybind }
            macro = {},        -- { [MacroID] = Keybind }
            companion = {},    -- { [CompanionID] = Keybind }
            mount = {},        -- { [MountID] = Keybind }
            equipmentset = {}, -- { [EquipmentID] = Keybind }
            text = {},         -- { [ActionText] = Keybind }
            texture = {},      -- { [TextureID] = Keybind }
            flyout = {},       -- { [FlyoutID] = Keybind }
        }
    }
}

-- ============================ MODULE CREATION ============================

local KeybindManager = NAG:CreateModule("KeybindManager", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    debugCategories = {ns.DEBUG_CATEGORIES.SERVICES},

    eventHandlers = {
        ACTIONBAR_SLOT_CHANGED = true,
        UPDATE_BINDINGS = true,
        PLAYER_ENTERING_WORLD = true,
        PLAYER_SPECIALIZATION_CHANGED = true,
        PLAYER_TALENT_UPDATE = true,
        LEARNED_SPELL_IN_TAB = true,
        SPELL_UPDATE_ICON = true,
        UPDATE_SHAPESHIFT_FORM = true,
        ACTIONBAR_UPDATE_USABLE = true,
        ZONE_CHANGED_NEW_AREA = true,
        PET_BAR_UPDATE = true,
        UNIT_PET = true,
    },

    messageHandlers = {
        NAG_KEYBIND_SETTING_CHANGED = true,
    },


    slashCommands = {
        ["keybinddebug"] = {
            handler = "ShowDebugFrame",
            help = "Show KeybindManager debug frame with all scanned mappings",
            root = "nag",
        },
    },
})

local module = KeybindManager

-- ============================ FILE-LOCAL STATE ============================

-- Action slot data: { [ActionSlot] = { Slot, Type, ID, SubType, Texture, Text, CommandName, HotKey } }
local Actions = {}

-- Indexed lookup: { [Type] = { [ID] = { [slot1, slot2, ...] } } }
local ActionSlotsBy = {
    Spell = {},
    Item = {},
    Macro = {},
    Text = {},
    Texture = {},
}

-- Pet bar keybinds mapped by texture (for Hunter pet abilities)
local PetBarKeybindsByTexture = {}

-- Cache for visible frame slots (used for ElvUI and Monk bonus bars)
-- CRITICAL: For ElvUI, this cache maps action slots to the visible frames displaying them
-- ElvUI frames display slots from different bars (e.g., ElvUI_Bar1Button1 shows slot 97)
-- The keybind comes from the FRAME's position (ACTIONBUTTON1), not the slot's position
-- This cache must be populated before UpdateAction uses it for ElvUI
local visibleFrameSlotsCache = nil

-- Keybind result cache (spellID/itemID -> keybind string) to avoid repeated GetSpellTexture on display hot path
local MAX_KEYBIND_CACHE_SIZE = 64
local KEYBIND_CACHE_SENTINEL_NIL = {} -- distinct table for "cached nil"

-- ============================ HELPER FUNCTIONS ============================

--- Get bar index and slot from action slot number
--- @param actionSlot number Action slot (1-180)
--- @return number BarIndex Bar index (1-10)
--- @return number BarSlot Slot within bar (1-12)
local function GetBarInfo(actionSlot)
    local barIndex
    if actionSlot >= 145 and actionSlot <= 156 then
        barIndex = 2
    elseif actionSlot >= 157 and actionSlot <= 168 then
        barIndex = 7
    elseif actionSlot >= 169 and actionSlot <= 180 then
        barIndex = 8
    elseif actionSlot >= 121 and actionSlot <= 144 then
        barIndex = 10 -- Dummy for ignored slots
    else
        barIndex = mathceil(actionSlot / 12)
    end
    local barSlot = actionSlot % 12
    if barSlot == 0 then barSlot = 12 end
    return barIndex, barSlot
end

--- Get action slot from a button frame
--- @param frame table Action button frame
--- @return number|nil Action slot number or nil if unavailable
local function GetFrameActionSlot(frame)
    if not frame then return nil end

    local actionSlot = frame.action
    if actionSlot then
        return actionSlot
    end

    if frame.GetAttribute then
        return frame:GetAttribute("action")
    end

    return nil
end

--- Get command name and keybind for a special action button index
--- @param index number Button index (1-12)
--- @return string Command name for binding lookup
--- @return string|nil Formatted keybind string or nil
local function GetSpecialActionCommand(index)
    local specialCommand = "SPECIALACTIONBUTTON" .. index
    local key1 = GetBindingKey(specialCommand)
    if key1 then
        return specialCommand, FormatKeybind(key1)
    end

    local actionCommand = "ACTIONBUTTON" .. index
    key1 = GetBindingKey(actionCommand)
    if key1 then
        return actionCommand, FormatKeybind(key1)
    end

    return specialCommand, nil
end

--- Check if the override action bar is currently active/visible
--- @return boolean True if override action bar is visible
local function IsOverrideActionBarActive()
    local bar = _G.OverrideActionBar
    if bar and bar.IsShown and bar:IsShown() then
        return true
    end

    for i = 1, 12 do
        local frame = _G["OverrideActionBarButton" .. i]
        if frame and frame.IsShown and frame:IsShown() then
            return true
        end
    end

    return false
end

--- Get button info for action slot
--- @param actionSlot number Action slot (1-180)
--- @param blizzard boolean|nil Use Blizzard button mapping (for fallback)
--- @return string|nil ButtonBaseName Base name of button
--- @return number|nil ButtonSlot Slot number for button
local function GetButtonInfo(actionSlot, blizzard)
    local barIndex, barSlot = GetBarInfo(actionSlot)

    local buttonBaseName, buttonSlot
    if blizzard then
        buttonBaseName = ButtonByAddOn.Blizzard[barIndex][1]
        buttonSlot = barSlot
    elseif _G.Bartender4 then
        buttonBaseName = ButtonByAddOn.Bartender[1][1]
        buttonSlot = actionSlot
    elseif _G.Dominos then
        local _, playerClass = UnitClass("player")
        if GetBonusBarOffset() > 0 and (barIndex < 3 or barIndex > 6)
            and (playerClass == "ROGUE" or playerClass == "DRUID" or playerClass == "WARRIOR") then
            barIndex = 1
            buttonSlot = barSlot
        else
            -- Dominos frame names: Bar 1 = DominosActionButton1-12 (barSlot). Bar 2,7-10 = DominosActionButton{actionSlot}.
            -- Bars 3-6 = MultiBar*ActionButton1-12 (barSlot).
            if barIndex == 1 or (barIndex >= 3 and barIndex <= 6) then
                buttonSlot = barSlot
            else
                buttonSlot = actionSlot
            end
        end
        buttonBaseName = ButtonByAddOn.Dominos[barIndex][1]
    elseif _G.ElvUI and _G.ElvUI[1].ActionBars then
        buttonBaseName = ButtonByAddOn.ElvUI[barIndex][1]
        buttonSlot = barSlot
    else
        buttonBaseName = ButtonByAddOn.Blizzard[barIndex][1]
        -- For multi-action bars (bar 3+), buttonSlot should be barSlot (1-12), not actionSlot
        -- Bar 1 also uses barSlot for ACTIONBUTTON1-12
        if barIndex >= 3 then
            buttonSlot = barSlot
        else
            -- Bar 1: use barSlot for ACTIONBUTTON1-12
            buttonSlot = barSlot
        end
    end

    return buttonBaseName, buttonSlot
end

--- Get command name for action slot
--- @param actionSlot number Action slot (1-180)
--- @param blizzard boolean Use Blizzard command mapping (for fallback)
--- @return string|nil CommandName Command name for binding
local function GetCommandNameFromActionSlot(actionSlot, blizzard)
    if IsOverrideActionBarActive() and actionSlot >= 121 and actionSlot <= 132 then
        return string.format("SPECIALACTIONBUTTON%d", actionSlot - 120)
    end

    local barIndex, barSlot = GetBarInfo(actionSlot)
    local _, buttonSlot = GetButtonInfo(actionSlot)

    local commandNameFormat
    if blizzard then
        _, buttonSlot = GetButtonInfo(actionSlot, true)
        local _, playerClass = UnitClass("player")
        if GetBonusBarOffset() > 0 and (barIndex < 3 or barIndex > 6)
            and (playerClass == "ROGUE" or playerClass == "DRUID" or playerClass == "WARRIOR") then
            barIndex = 1
            -- When mapping bonus bar slots to bar 1, use barSlot (1-12) instead of action slot number
            buttonSlot = barSlot
        end
        commandNameFormat = ButtonByAddOn.Blizzard[barIndex] and ButtonByAddOn.Blizzard[barIndex][2]
    elseif _G.Bartender4 then
        commandNameFormat = ButtonByAddOn.Bartender[1][2]
    elseif _G.Dominos then
        local _, playerClass = UnitClass("player")
        if GetBonusBarOffset() > 0 and (barIndex < 3 or barIndex > 6)
            and (playerClass == "ROGUE" or playerClass == "DRUID" or playerClass == "WARRIOR") then
            barIndex = 1
            -- When mapping bonus bar slots to bar 1, use barSlot (1-12) instead of action slot number
            buttonSlot = barSlot
        end
        commandNameFormat = ButtonByAddOn.Dominos[barIndex] and ButtonByAddOn.Dominos[barIndex][2]
        -- Dominos uses action ID (not bar slot) for CLICK DominosActionButton:HOTKEY commands.
        -- Bar 1: ACTIONBUTTON1-12 (uses barSlot). Bar 2, 7-10: CLICK DominosActionButton{actionSlot}:HOTKEY.
        if commandNameFormat and commandNameFormat:find("CLICK DominosActionButton") then
            buttonSlot = actionSlot
        elseif barIndex >= 3 then
            buttonSlot = barSlot
        end
    elseif _G.ElvUI and _G.ElvUI[1].ActionBars then
        commandNameFormat = ButtonByAddOn.ElvUI[barIndex] and ButtonByAddOn.ElvUI[barIndex][2]
    else
        local _, playerClass = UnitClass("player")
        if GetBonusBarOffset() > 0 and (barIndex < 3 or barIndex > 6)
            and (playerClass == "ROGUE" or playerClass == "DRUID" or playerClass == "WARRIOR") then
            barIndex = 1
            -- When mapping bonus bar slots to bar 1, use barSlot (1-12) instead of action slot number
            buttonSlot = barSlot
        end
        commandNameFormat = ButtonByAddOn.Blizzard[barIndex] and ButtonByAddOn.Blizzard[barIndex][2]
        -- For multi-action bars (bar 3+), ensure buttonSlot is barSlot (1-12), not actionSlot
        if barIndex >= 3 then
            buttonSlot = barSlot
        end
    end

    if commandNameFormat then
        return commandNameFormat:format(buttonSlot)
    end

    return nil
end

--- Format keybind string (shorten hotkeys)
--- @param key string Raw keybind from GetBindingKey
--- @return string|nil Formatted keybind string
local function FormatKeybind(key)
    if not key then return nil end

    local replacements = {
        ["MOUSEWHEELUP"] = "WU",
        ["MOUSEWHEELDOWN"] = "WD",
        ["MOUSEWHEELLEFT"] = "WL",
        ["MOUSEWHEELRIGHT"] = "WR",
        ["NUMPADADD"] = "N+",
        ["NUMPADDIVIDE"] = "N/",
        ["NUMPADMULTIPLY"] = "N*",
        ["NUMPADMINUS"] = "N-",
        ["PAGEUP"] = "PU",
        ["PAGEDOWN"] = "PD",
        ["PAGE_UP"] = "PU",
        ["PAGE_DOWN"] = "PD",
        ["HOME"] = "HM",
        ["END"] = "EN",
        ["INSERT"] = "INS",
        ["DELETE"] = "DEL",
        ["BUTTON"] = "M",
        ["NUMPAD"] = "N",
        ["ALT"] = "A",
        ["CTRL"] = "C",
        ["SHIFT"] = "S",
    }

    -- Create ordered list for longest match first
    local orderedKeys = {}
    for k in pairs(replacements) do
        tinsert(orderedKeys, k)
    end
    sort(orderedKeys, function(a, b) return #a > #b end)

    local parts = {strsplit("-", key)}
    local modifierString = ""
    local mainKey = ""
    local modifiers = {}

    -- Process modifiers
    for i = 1, #parts - 1 do
        local modifierKey = strupper(parts[i])
        tinsert(modifiers, replacements[modifierKey] or modifierKey)
    end

    -- Process main key
    mainKey = strupper(parts[#parts])
    for _, k in ipairs(orderedKeys) do
        if mainKey:find("^" .. k) then
            mainKey = mainKey:gsub(k, replacements[k], 1)
            break
        end
    end

    if #modifiers > 0 then
        modifierString = table.concat(modifiers, "")
        return modifierString .. "-" .. mainKey
    else
        return mainKey
    end
end

--- Get all visible action button frames and the slots they're displaying
--- CRITICAL: When bonusBarOffset > 0, frames display slots from different bars
--- The keybind comes from the FRAME's button position, not the slot's command
--- @return table Map of { [actionSlot] = { frame = frame, keybind = keybind, frameButtonIndex = index } }
local function GetVisibleFrameSlots()
    local visibleSlots = {}

    -- Check all possible action button frames
    local framePatterns = {}

    -- Check if ElvUI is active
    if _G.ElvUI and _G.ElvUI[1] and _G.ElvUI[1].ActionBars then
        -- ElvUI frame patterns
        framePatterns = {
            -- Bar 1
            { pattern = "ElvUI_Bar1Button%d", count = 12, barIndex = 1 },
            -- Bar 2
            { pattern = "ElvUI_Bar2Button%d", count = 12, barIndex = 2 },
            -- Bar 3
            { pattern = "ElvUI_Bar3Button%d", count = 12, barIndex = 3 },
            -- Bar 4
            { pattern = "ElvUI_Bar4Button%d", count = 12, barIndex = 4 },
            -- Bar 5
            { pattern = "ElvUI_Bar5Button%d", count = 12, barIndex = 5 },
            -- Bar 6
            { pattern = "ElvUI_Bar6Button%d", count = 12, barIndex = 6 },
            -- Bar 7
            { pattern = "ElvUI_Bar7Button%d", count = 12, barIndex = 7 },
            -- Bar 8
            { pattern = "ElvUI_Bar8Button%d", count = 12, barIndex = 8 },
            -- Bar 9
            { pattern = "ElvUI_Bar9Button%d", count = 12, barIndex = 9 },
            -- Bar 10
            { pattern = "ElvUI_Bar10Button%d", count = 12, barIndex = 10 },
        }
    else
        -- Blizzard default frame patterns
        framePatterns = {
            -- Bar 1
            { pattern = "ActionButton%d", count = 12, barIndex = 1 },
            -- Bar 3 (MultiBarRight)
            { pattern = "MultiBarRightButton%d", count = 12, barIndex = 3 },
            -- Bar 4 (MultiBarLeft)
            { pattern = "MultiBarLeftButton%d", count = 12, barIndex = 4 },
            -- Bar 5 (MultiBarBottomRight)
            { pattern = "MultiBarBottomRightButton%d", count = 12, barIndex = 5 },
            -- Bar 6 (MultiBarBottomLeft)
            { pattern = "MultiBarBottomLeftButton%d", count = 12, barIndex = 6 },
            -- Bar 7 (MultiBar6)
            { pattern = "MultiBar6Button%d", count = 12, barIndex = 7 },
            -- Bar 8 (MultiBar7)
            { pattern = "MultiBar7Button%d", count = 12, barIndex = 8 },
        }
    end

    local bar1FrameCount = 0
    for _, frameInfo in ipairs(framePatterns) do
        for i = 1, frameInfo.count do
            local frameName = string.format(frameInfo.pattern, i)
            local frame = _G[frameName]
            if frame and frame:IsVisible() then
                local actionSlot = GetFrameActionSlot(frame)
                if actionSlot then
                    if frameInfo.barIndex == 1 then
                        bar1FrameCount = bar1FrameCount + 1
                    end

                -- CRITICAL: Get keybind from the FRAME's button position, not the slot's command
                -- When bonusBarOffset > 0, ActionButton7 might display Slot 79, but the keybind is "7" (ACTIONBUTTON7)
                -- We need the command for the frame's position (barIndex, i), not the slot's position
                local frameBarIndex = frameInfo.barIndex
                local frameButtonIndex = i

                -- Get command name for this frame's position
                local frameCommandName = nil

                -- Use ElvUI command formats if ElvUI is active
                if _G.ElvUI and _G.ElvUI[1] and _G.ElvUI[1].ActionBars then
                    local commandFormat = ButtonByAddOn.ElvUI[frameBarIndex] and ButtonByAddOn.ElvUI[frameBarIndex][2]
                    if commandFormat then
                        frameCommandName = string.format(commandFormat, frameButtonIndex)
                    end
                else
                    -- Blizzard default command formats
                    if frameBarIndex == 1 then
                        frameCommandName = string.format("ACTIONBUTTON%d", frameButtonIndex)
                    elseif frameBarIndex == 3 then
                        frameCommandName = string.format("MULTIACTIONBAR3BUTTON%d", frameButtonIndex)
                    elseif frameBarIndex == 4 then
                        frameCommandName = string.format("MULTIACTIONBAR4BUTTON%d", frameButtonIndex)
                    elseif frameBarIndex == 5 then
                        frameCommandName = string.format("MULTIACTIONBAR2BUTTON%d", frameButtonIndex)
                    elseif frameBarIndex == 6 then
                        frameCommandName = string.format("MULTIACTIONBAR1BUTTON%d", frameButtonIndex)
                    elseif frameBarIndex == 7 then
                        frameCommandName = string.format("MULTIACTIONBAR6BUTTON%d", frameButtonIndex)
                    elseif frameBarIndex == 8 then
                        frameCommandName = string.format("MULTIACTIONBAR7BUTTON%d", frameButtonIndex)
                    end
                end

                local key1, key2 = nil, nil
                local keybind = nil
                if frameCommandName then
                    key1, key2 = GetBindingKey(frameCommandName)
                    if key1 then
                        keybind = FormatKeybind(key1)
                    end
                end

                    visibleSlots[actionSlot] = {
                        frame = frame,
                        frameName = frameName,
                        frameBarIndex = frameBarIndex,
                        frameButtonIndex = frameButtonIndex,
                        keybind = keybind,
                        commandName = frameCommandName
                    }
                end
            end
        end
    end

    -- Special/override action buttons (used for stance override and other special bars)
    for i = 1, 12 do
        local frameName = "OverrideActionBarButton" .. i
        local frame = _G[frameName]
        if frame and frame:IsVisible() then
            local actionSlot = GetFrameActionSlot(frame)
            if actionSlot then
                local commandName, keybind = GetSpecialActionCommand(i)
                visibleSlots[actionSlot] = {
                    frame = frame,
                    frameName = frameName,
                    frameBarIndex = 1,
                    frameButtonIndex = i,
                    keybind = keybind,
                    commandName = commandName
                }
            end
        end
    end

    -- Extra action button (encounter-specific)
    local extraActionButton = _G.ExtraActionButton1
    if extraActionButton and extraActionButton:IsVisible() then
        local actionSlot = GetFrameActionSlot(extraActionButton)
        if actionSlot then
            local commandName = "EXTRAACTIONBUTTON1"
            local key1 = GetBindingKey(commandName)
            local keybind = key1 and FormatKeybind(key1) or nil
            visibleSlots[actionSlot] = {
                frame = extraActionButton,
                frameName = "ExtraActionButton1",
                frameBarIndex = 1,
                frameButtonIndex = 1,
                keybind = keybind,
                commandName = commandName
            }
        end
    end

    -- No debug logging needed

    return visibleSlots
end

--- Update pet bar keybinds (BONUSACTIONBUTTON1-10)
local function UpdatePetBarKeybinds()
    for textureId in pairs(PetBarKeybindsByTexture) do
        PetBarKeybindsByTexture[textureId] = nil
    end

    for i = 1, 10 do
        local buttonName = "PetActionButton" .. i
        local button = _G[buttonName]
        if button and button:IsShown() then
            local key1 = GetBindingKey("BONUSACTIONBUTTON" .. i)
            local keybind = key1 and FormatKeybind(key1) or nil
            if keybind then
                local icon = button.icon or _G[buttonName .. "Icon"]
                local texture = icon and icon.GetTexture and icon:GetTexture() or nil
                if texture then
                    PetBarKeybindsByTexture[texture] = keybind
                end
            end
        end
    end
end

--- Add action slot to index by type and ID
--- @param type string Action type ("Spell", "Item", "Macro", "Text", "Texture")
--- @param identifier number|string Action ID or identifier
--- @param actionSlot number Action slot number
local function AddActionSlotsByValue(type, identifier, actionSlot)
    local actionSlots = ActionSlotsBy[type][identifier]
    if not actionSlots then
        actionSlots = {}
        ActionSlotsBy[type][identifier] = actionSlots
    end
    tinsert(actionSlots, actionSlot)
end

--- Remove action slot from index
--- @param type string Action type
--- @param identifier number|string Action ID or identifier
--- @param actionSlot number Action slot number
local function RemoveActionSlotsByValue(type, identifier, actionSlot)
    local actionSlots = ActionSlotsBy[type][identifier]
    if not actionSlots then return end

    for i, slot in ipairs(actionSlots) do
        if slot == actionSlot then
            tremove(actionSlots, i)
            break
        end
    end

    -- Clean up empty tables
    if #actionSlots == 0 then
        ActionSlotsBy[type][identifier] = nil
    end
end

--- Clear action slot data
--- @param actionSlot number Action slot number
local function ClearAction(actionSlot)
    local prevAction = Actions[actionSlot]
    if not prevAction then return end

    local actionType, actionID = prevAction.Type, prevAction.ID
    local actionText = prevAction.Text
    local actionTexture = prevAction.Texture

    if actionTexture then
        RemoveActionSlotsByValue("Texture", actionTexture, actionSlot)
    end

    if actionText then
        RemoveActionSlotsByValue("Text", actionText, actionSlot)
    end

    if actionID then
        if actionType == "spell" then
            RemoveActionSlotsByValue("Spell", actionID, actionSlot)
        elseif actionType == "item" then
            RemoveActionSlotsByValue("Item", actionID, actionSlot)
        elseif actionType == "macro" then
            RemoveActionSlotsByValue("Macro", actionID, actionSlot)
        end
    end

    Actions[actionSlot] = nil
end

--- Get button frame name for action slot
--- @param actionSlot number Action slot number
--- @return string|nil Button frame name or nil if not found
local function GetButtonFrameName(actionSlot)
    local buttonBaseName, buttonSlot = GetButtonInfo(actionSlot)
    if not buttonBaseName then
        return nil
    end
    local frameName = buttonBaseName .. buttonSlot
    return frameName
end

--- Check if action slot is on a visible bar (filters out hidden bars for Druid/Rogue stances, disabled ElvUI bars, and non-existent Dominos buttons)
--- @param actionSlot number Action slot number
--- @return boolean isVisible True if slot is on a visible bar
local function IsActionSlotVisible(actionSlot)
    local bonusBarOffset = GetBonusBarOffset()
    local _, playerClass = UnitClass("player")

    -- For Druids/Rogues/Warriors in stance: bar 1 (slots 1-12) is hidden
    if bonusBarOffset > 0 and (playerClass == "ROGUE" or playerClass == "DRUID" or playerClass == "WARRIOR") then
        -- Bar 1 (slots 1-12) is hidden when in stance
        if actionSlot >= 1 and actionSlot <= 12 and not IsOverrideActionBarActive() then
            return false
        end
    end

    -- Check ElvUI bar visibility (bars can be disabled in ElvUI settings)
    -- CRITICAL: With ElvUI, slots from different bars can be displayed on bar 1 frames
    -- So we need to check if the slot is actually displayed on a visible frame, not just if its bar is enabled
    -- Only do this check if ElvUI is active AND Dominos is not (they're mutually exclusive)
    if _G.ElvUI and _G.ElvUI[1] and _G.ElvUI[1].ActionBars and _G.ElvUI[1].ActionBars.db and not _G.Dominos then
        -- First check if slot is displayed on a visible frame (most accurate for ElvUI)
        -- Only use cache if ElvUI is active (cache might be stale from previous session)
        if not visibleFrameSlotsCache or (visibleFrameSlotsCache._elvui ~= true) then
            visibleFrameSlotsCache = GetVisibleFrameSlots()
            visibleFrameSlotsCache._elvui = true -- Mark as ElvUI cache
        end
        local visibleInfo = visibleFrameSlotsCache[actionSlot]
        if visibleInfo then
            -- Slot is displayed on a visible frame - check if that frame's bar is enabled
            local frameBarIndex = visibleInfo.frameBarIndex
            if frameBarIndex then
                local barKey = "bar" .. tostring(frameBarIndex)
                local barConfig = _G.ElvUI[1].ActionBars.db[barKey]
                if barConfig and barConfig.enabled == false then
                    return false
                end
                -- Frame's bar is enabled, so slot is visible
                return true
            end
        end

        -- Fallback: check slot's own bar (for slots not yet in visible frames cache)
        local barIndex, _ = GetBarInfo(actionSlot)
        local barKey = "bar" .. tostring(barIndex)
        local barConfig = _G.ElvUI[1].ActionBars.db[barKey]
        if barConfig and barConfig.enabled == false then
            return false
        end
    elseif _G.Dominos then
        -- Clear ElvUI cache if Dominos is active (they're mutually exclusive)
        if visibleFrameSlotsCache and visibleFrameSlotsCache._elvui then
            visibleFrameSlotsCache = nil
        end
    end

    -- Check Dominos: verify the button frame actually exists and is visible
    -- CRITICAL: Dominos can display slots from different bars on Blizzard frames
    -- Dominos frame structure varies by version/config; when we can't find a frame, assume visible
    -- so we don't filter out all slots (which would cause Total Actions: 0)
    if _G.Dominos then
        -- First, check DominosActionButton1-12 (bar 1 or paged bars)
        for i = 1, 12 do
            local frameName = "DominosActionButton" .. i
            local frame = _G[frameName]
            if frame and GetFrameActionSlot(frame) == actionSlot then
                return frame:IsShown()
            end
        end

        -- Fallback: check Dominos frame name (for bars 2, 7-10: DominosActionButton13-120)
        local buttonName = GetButtonFrameName(actionSlot)
        if buttonName then
            local button = _G[buttonName]
            if button and button:IsShown() then
                local parent = button:GetParent()
                if not parent or parent:IsShown() then
                    return true
                end
            end
        end

        -- Dominos frame lookup failed (frame names/structure may differ by version)
        -- Assume visible so we index the slot; otherwise we'd filter ALL slots (Total Actions: 0)
        return true
    end

    -- All other bars are visible (unless filtered out above)
    return true
end

--- Update action slot data
--- @param actionSlot number Action slot number
local function UpdateAction(actionSlot)
    -- Prevent update for invalid slots
    if not actionSlot or actionSlot <= 0 or actionSlot > MAX_ACTION_SLOTS then return end

    -- Clear previous data
    ClearAction(actionSlot)

    -- Skip if slot is empty
    if not HasAction(actionSlot) then
        return
    end

    -- Filter out hidden bars for Druid/Rogue stances
    local isVisible = IsActionSlotVisible(actionSlot)
    if not isVisible then
        return
    end

    -- Get action info
    local actionType, actionID, actionSubType = GetActionInfo(actionSlot)
    if actionID then
        if actionType == "spell" then
            AddActionSlotsByValue("Spell", actionID, actionSlot)
        elseif actionType == "item" then
            AddActionSlotsByValue("Item", actionID, actionSlot)
        elseif actionType == "macro" then
            AddActionSlotsByValue("Macro", actionID, actionSlot)

            -- Extract spell/item from macro (so spells in macros can be found)
            local macroSpellID = GetMacroSpell and GetMacroSpell(actionID)
            local macroItemID = GetMacroItem and GetMacroItem(actionID)

            if macroSpellID then
                -- Normalize spell ID to handle variants (same spell name, different IDs)
                local SpellbookManager = NAG:GetModule("SpellbookManager")
                local effectiveSpellID = macroSpellID
                if SpellbookManager and SpellbookManager.ResolveEffectiveSpellID then
                    local resolved = SpellbookManager:ResolveEffectiveSpellID(macroSpellID)
                    if resolved then
                        effectiveSpellID = resolved
                    end
                end
                -- Map spell ID to macro's action slot (use normalized ID)
                AddActionSlotsByValue("Spell", effectiveSpellID, actionSlot)
            end

            if macroItemID then
                -- Map item ID to macro's action slot
                AddActionSlotsByValue("Item", macroItemID, actionSlot)
            end
        end
    end

    local actionTexture = GetActionTexture(actionSlot)
    if actionTexture then
        AddActionSlotsByValue("Texture", actionTexture, actionSlot)
    end

    local actionText = GetActionText(actionSlot)
    if actionText then
        AddActionSlotsByValue("Text", actionText, actionSlot)
    end

    -- Get command name and hotkey
    -- CRITICAL: With ElvUI, frames may display slots from different bars
    -- The keybind comes from the FRAME's position, not the slot's position
    -- For example: ElvUI_Bar1Button1 displays slot 97, but keybind is ACTIONBUTTON1
    local commandName = nil
    local rawHotKey = nil
    local actionHotKey = nil

    -- Check if this slot is displayed on a visible frame (ElvUI, Dominos, or Monk bonus bars)
    -- CRITICAL: With ElvUI/Dominos, frames can display slots from different bars
    -- The keybind comes from the FRAME's position, not the slot's bar index
    if _G.ElvUI and _G.ElvUI[1] and _G.ElvUI[1].ActionBars then
        -- ElvUI: Get keybind from visible frame position
        -- Cache visible frames to avoid calling GetVisibleFrameSlots() multiple times
        -- CRITICAL: Always refresh cache if nil to ensure all ElvUI frames are detected
        if not visibleFrameSlotsCache then
            visibleFrameSlotsCache = GetVisibleFrameSlots()
        end
        local visibleInfo = visibleFrameSlotsCache[actionSlot]
        if visibleInfo then
            -- Slot is displayed on a visible ElvUI frame - ALWAYS use frame's command name
            -- The frame's position determines the keybind, not the slot's bar index
            commandName = visibleInfo.commandName
            if visibleInfo.keybind then
                -- Use keybind from the visible frame (frame's position, not slot's position)
                actionHotKey = visibleInfo.keybind
            elseif commandName then
                -- Frame exists but cache didn't have keybind - get it directly using frame's command
                rawHotKey = GetBindingKey(commandName)
                actionHotKey = rawHotKey and FormatKeybind(rawHotKey) or nil
            end
        end
    elseif _G.Dominos then
        -- Dominos: Check if slot is displayed on DominosActionButton1-12 (bar 1 or paged bar 7)
        -- Keybind comes from frame position (1-12) -> ACTIONBUTTON1-12
        for i = 1, 12 do
            local frameName = "DominosActionButton" .. i
            local frame = _G[frameName]
            if frame and GetFrameActionSlot(frame) == actionSlot then
                commandName = string.format("ACTIONBUTTON%d", i)
                rawHotKey = GetBindingKey(commandName)
                actionHotKey = rawHotKey and FormatKeybind(rawHotKey) or nil
                break
            end
        end
    end

    -- Fallback to standard method if not found in visible frames (non-ElvUI or slot not on visible frame)
    if not actionHotKey then
        commandName = GetCommandNameFromActionSlot(actionSlot)
        rawHotKey = (commandName and GetBindingKey(commandName)) or nil

        -- Fallback to Blizzard mapping if needed
        if not rawHotKey then
            commandName = GetCommandNameFromActionSlot(actionSlot, true)
            rawHotKey = (commandName and GetBindingKey(commandName)) or nil
        end

        -- Dominos: Bars 2, 7-10 use CLICK DominosActionButton{actionSlot}:HOTKEY (fallback if primary path missed)
        if not rawHotKey and _G.Dominos and actionSlot >= 13 and actionSlot <= 132 then
            commandName = string.format("CLICK DominosActionButton%d:HOTKEY", actionSlot)
            rawHotKey = GetBindingKey(commandName)
        end

        actionHotKey = rawHotKey and FormatKeybind(rawHotKey) or nil
    end

    Actions[actionSlot] = {
        Slot = actionSlot,
        Type = actionType,
        ID = actionID,
        SubType = actionSubType,
        Texture = actionTexture,
        Text = actionText,
        CommandName = commandName,
        HotKey = actionHotKey
    }
end

--- Find action by type and identifier
--- @param type string Action type ("Spell", "Item", "Macro", "Text", "Texture")
--- @param identifier number|string Action ID or identifier
--- @return table|nil Action data or nil
local function FindAction(type, identifier)
    local actionSlots = ActionSlotsBy[type][identifier]
    if not actionSlots or #actionSlots == 0 then
        return nil
    end

    -- Sort by slot number so we consistently prefer bar 1 (slots 1-12) when multiple slots match.
    -- Only when #actionSlots > 1 (skip sort for single-slot case; cost is trivial but not on hottest path).
    if #actionSlots > 1 then
        sort(actionSlots, function(a, b) return a < b end)
    end

    -- Handle stance classes with bonus bars
    -- Rogue/Druid/Warrior: Bonus bars are ACTIVE stance bars (visible) - prefer them
    -- Monk: Bonus bars are INACTIVE stances (hidden) - exclude them
    local actionSlot
    local bonusBarOffset = GetBonusBarOffset()
    local _, playerClass = UnitClass("player")

    if bonusBarOffset > 0 and (playerClass == "ROGUE" or playerClass == "DRUID" or playerClass == "WARRIOR") then
        -- If override action bar is active, prefer override slots first (121-132), then slots 1-12
        if IsOverrideActionBarActive() then
            for _, slot in ipairs(actionSlots) do
                if slot >= 121 and slot <= 132 then
                    actionSlot = slot
                    break
                end
            end

            if not actionSlot then
                for _, slot in ipairs(actionSlots) do
                    if slot >= 1 and slot <= 12 then
                        actionSlot = slot
                        break
                    end
                end
            end
        end

        if actionSlot then
            return Actions[actionSlot]
        end

        local numPages = NUM_ACTIONBAR_PAGES or 6
        local numButtons = NUM_ACTIONBAR_BUTTONS or 12
        for _, slot in ipairs(actionSlots) do
            local low = (1 + (numPages + bonusBarOffset - 1) * numButtons)
            local high = ((numPages + bonusBarOffset) * numButtons)
            if slot >= low and slot <= high then
                actionSlot = slot
                break
            end
        end
        -- Fallback: prefer slots not on bar 1
        if not actionSlot then
            if #actionSlots == 1 then
                actionSlot = actionSlots[1]
            else
                for _, slot in ipairs(actionSlots) do
                    if slot > 12 then
                        actionSlot = slot
                        break
                    end
                end
            end
        end
        if not actionSlot then actionSlot = actionSlots[1] end
    elseif bonusBarOffset > 0 and playerClass == "MONK" then
        -- Monks: When bonusBarOffset > 0, there are multiple bonus bars (one per stance)
        -- CRITICAL: Iterate through ALL visible frames to find which ones display our target
        -- Don't assume which frame shows which slot - check frame.action directly
        -- CRITICAL: With ElvUI, prioritize bar 1 frames since that's what the user sees
        local visibleFrameSlots = GetVisibleFrameSlots()

        -- Separate slots by visibility and bar 1 priority (for ElvUI)
        local slotsWithKeybindsOnBar1 = {}
        local slotsOnBar1 = {}
        local slotsWithKeybindsOnOtherVisibleFrames = {}
        local slotsOnOtherVisibleFrames = {}
        local slotsWithKeybindsOther = {}
        local slotsOther = {}

        for _, slot in ipairs(actionSlots) do
            local visibleFrameInfo = visibleFrameSlots[slot]

            -- CRITICAL: ONLY consider slots that are displayed on visible frames
            -- Slots not on visible frames are from inactive stances and should be ignored
            if visibleFrameInfo then
                -- Get keybind from visible frame - use cached if available, otherwise get directly
                local frameKeybind = visibleFrameInfo.keybind
                if not frameKeybind or frameKeybind == "" then
                    -- Cache didn't have keybind - get it directly from frame's command
                    if visibleFrameInfo.commandName then
                        local key1, key2 = GetBindingKey(visibleFrameInfo.commandName)
                        if key1 then
                            frameKeybind = FormatKeybind(key1)
                            -- Update cache for future use
                            visibleFrameInfo.keybind = frameKeybind
                        end
                    end
                end

                -- CRITICAL: Prioritize bar 1 frames (frameBarIndex == 1) for ElvUI
                -- This ensures we get the keybind from the frame the user actually sees
                -- CRITICAL: Prefer slots on ElvUI bar 1 frames over active bonus bar slots
                -- Active bonus bar slots (1-12) are displayed on bar 1 but are from bonus bars, not the main bar
                -- ElvUI bar 1 frames can display slots from any bar (73-84, 85-96, etc.) - check frameBarIndex, not slot number
                if visibleFrameInfo.frameBarIndex == 1 then
                    -- Bar 1 frame - check if this is an active bonus bar slot (1-12) or a regular bar 1 frame slot
                    local isActiveBonusBarSlot = (slot >= 1 and slot <= 12) -- Active bonus bar slots

                    if frameKeybind and frameKeybind ~= "" then
                        if isActiveBonusBarSlot then
                            -- Active bonus bar slot - lower priority than regular bar 1 frame slots
                            tinsert(slotsWithKeybindsOnOtherVisibleFrames, slot)
                        else
                            -- Regular bar 1 frame slot (could be 73-84, 85-96, etc.) - highest priority
                            tinsert(slotsWithKeybindsOnBar1, slot)
                        end
                    else
                        if isActiveBonusBarSlot then
                            tinsert(slotsOnOtherVisibleFrames, slot)
                        else
                            tinsert(slotsOnBar1, slot)
                        end
                    end
                else
                    -- Other visible frames - lower priority than bar 1
                    if frameKeybind and frameKeybind ~= "" then
                        tinsert(slotsWithKeybindsOnOtherVisibleFrames, slot)
                    else
                        tinsert(slotsOnOtherVisibleFrames, slot)
                    end
                end
            end
            -- Ignore slots not displayed on visible frames (they're from inactive stances)
        end

        -- Select best option: prioritize bar 1 frames first, then other visible frames
        -- Better to show no keybind than wrong keybind from inactive stance
        if #slotsWithKeybindsOnBar1 > 0 then
            actionSlot = slotsWithKeybindsOnBar1[1]
        elseif #slotsOnBar1 > 0 then
            actionSlot = slotsOnBar1[1]
        elseif #slotsWithKeybindsOnOtherVisibleFrames > 0 then
            actionSlot = slotsWithKeybindsOnOtherVisibleFrames[1]
        elseif #slotsOnOtherVisibleFrames > 0 then
            actionSlot = slotsOnOtherVisibleFrames[1]
        else
            -- No visible frames displaying this spell - return nil (no keybind)
            -- Don't fall back to inactive stance slots
            actionSlot = nil
        end

        -- Update the action's HotKey from the visible frame (ensure it's always accurate)
        if actionSlot then
            local visibleInfo = visibleFrameSlots[actionSlot]
            if visibleInfo then
                -- Ensure Actions[actionSlot] exists
                if not Actions[actionSlot] then
                    Actions[actionSlot] = {}
                end
                -- Always use keybind from visible frame (most accurate)
                if visibleInfo.keybind and visibleInfo.keybind ~= "" then
                    Actions[actionSlot].HotKey = visibleInfo.keybind
                else
                    -- Get keybind directly if cache didn't have it
                    if visibleInfo.commandName then
                        local key1, key2 = GetBindingKey(visibleInfo.commandName)
                        if key1 then
                            Actions[actionSlot].HotKey = FormatKeybind(key1)
                        else
                            Actions[actionSlot].HotKey = ""
                        end
                    else
                        Actions[actionSlot].HotKey = ""
                    end
                end
            end
        end
    else
        -- For classes without bonus bars, prefer slots with keybinds and on visible bars
        -- CRITICAL: With ElvUI, frames display slots from different bars, so we must check visible frames
        -- Priority: 1) Slots with keybinds on visible frames/bars, 2) Slots with keybinds, 3) Slots on visible frames/bars, 4) First slot

        -- Check if ElvUI is active - if so, use visible frame detection like Monks
        if _G.ElvUI and _G.ElvUI[1] and _G.ElvUI[1].ActionBars then
            -- ElvUI: Use visible frame detection to find which slots are actually displayed
            local visibleFrameSlots = GetVisibleFrameSlots()

            local slotsWithKeybindsOnVisibleFrames = {}
            local slotsOnVisibleFrames = {}
            local slotsWithKeybindsOther = {}
            local slotsOther = {}

            -- Separate slots by visibility and bar 1 priority
            local slotsWithKeybindsOnBar1 = {}
            local slotsOnBar1 = {}
            local slotsWithKeybindsOnOtherVisibleFrames = {}
            local slotsOnOtherVisibleFrames = {}
            local slotsWithKeybindsOther = {}
            local slotsOther = {}

            for _, slot in ipairs(actionSlots) do
                local visibleFrameInfo = visibleFrameSlots[slot]
                local action = Actions[slot]
                local hasKeybind = action and action.HotKey and action.HotKey ~= ""

                if visibleFrameInfo then
                    -- Slot is displayed on a visible frame
                    -- CRITICAL: Prioritize bar 1 frames (frameBarIndex == 1) since that's what the user sees
                    if visibleFrameInfo.frameBarIndex == 1 then
                        -- Bar 1 frame - highest priority
                        if hasKeybind then
                            tinsert(slotsWithKeybindsOnBar1, slot)
                        else
                            tinsert(slotsOnBar1, slot)
                        end
                    else
                        -- Other visible frames - lower priority than bar 1
                        if hasKeybind then
                            tinsert(slotsWithKeybindsOnOtherVisibleFrames, slot)
                        else
                            tinsert(slotsOnOtherVisibleFrames, slot)
                        end
                    end
                else
                    -- Slot not on visible frame - lowest priority
                    if hasKeybind then
                        tinsert(slotsWithKeybindsOther, slot)
                    else
                        tinsert(slotsOther, slot)
                    end
                end
            end

            -- Select best option: prioritize bar 1 frames first, then other visible frames
            if #slotsWithKeybindsOnBar1 > 0 then
                actionSlot = slotsWithKeybindsOnBar1[1]
                -- Update the action's HotKey from the visible frame (more accurate)
                local visibleInfo = visibleFrameSlots[actionSlot]
                if visibleInfo and visibleInfo.keybind then
                    if not Actions[actionSlot] then Actions[actionSlot] = {} end
                    Actions[actionSlot].HotKey = visibleInfo.keybind
                end
            elseif #slotsOnBar1 > 0 then
                actionSlot = slotsOnBar1[1]
                -- Update the action's HotKey from the visible frame (even if empty, ensures consistency)
                local visibleInfo = visibleFrameSlots[actionSlot]
                if visibleInfo then
                    if not Actions[actionSlot] then Actions[actionSlot] = {} end
                    Actions[actionSlot].HotKey = visibleInfo.keybind or ""
                end
            elseif #slotsWithKeybindsOnOtherVisibleFrames > 0 then
                actionSlot = slotsWithKeybindsOnOtherVisibleFrames[1]
                local visibleInfo = visibleFrameSlots[actionSlot]
                if visibleInfo and visibleInfo.keybind then
                    if not Actions[actionSlot] then Actions[actionSlot] = {} end
                    Actions[actionSlot].HotKey = visibleInfo.keybind
                end
            elseif #slotsOnOtherVisibleFrames > 0 then
                actionSlot = slotsOnOtherVisibleFrames[1]
                local visibleInfo = visibleFrameSlots[actionSlot]
                if visibleInfo then
                    if not Actions[actionSlot] then Actions[actionSlot] = {} end
                    Actions[actionSlot].HotKey = visibleInfo.keybind or ""
                end
            elseif #slotsWithKeybindsOther > 0 then
                actionSlot = slotsWithKeybindsOther[1]
            elseif #slotsOther > 0 then
                actionSlot = slotsOther[1]
            else
                actionSlot = actionSlots[1]
            end
        else
            -- Non-ElvUI: Use bar index check (bars 1-6 are visible)
            local slotsWithKeybindsOnVisibleBars = {}
            local slotsWithKeybinds = {}
            local slotsOnVisibleBars = {}

            for _, slot in ipairs(actionSlots) do
                local action = Actions[slot]
                local barIndex, _ = GetBarInfo(slot)
                local hasKeybind = action and action.HotKey and action.HotKey ~= ""
                local isVisibleBar = barIndex >= 1 and barIndex <= 6

                if hasKeybind and isVisibleBar then
                    tinsert(slotsWithKeybindsOnVisibleBars, slot)
                elseif hasKeybind then
                    tinsert(slotsWithKeybinds, slot)
                elseif isVisibleBar then
                    tinsert(slotsOnVisibleBars, slot)
                end
            end

            -- Select best option based on priority
            if #slotsWithKeybindsOnVisibleBars > 0 then
                actionSlot = slotsWithKeybindsOnVisibleBars[1]
            elseif #slotsWithKeybinds > 0 then
                actionSlot = slotsWithKeybinds[1]
            elseif #slotsOnVisibleBars > 0 then
                actionSlot = slotsOnVisibleBars[1]
            else
                actionSlot = actionSlots[1]
            end
        end
    end

    if actionSlot then
        return Actions[actionSlot]
    end

    return nil
end

--- Get group key from frame (supports legacy and modern groups)
--- @param frame table The frame to get the group from
--- @return string|nil The group key (lowercase)
local function GetGroupKeyFromFrame(frame)
    if not frame then return nil end

    -- Check modern groupKey first (FRAME_GROUPS constants are already lowercase strings)
    if frame.groupKey then
        -- frame.groupKey is already a lowercase string like "main", "cooldowns", etc.
        -- from ns.FRAME_GROUPS.MAIN, ns.FRAME_GROUPS.COOLDOWNS, etc.
        return type(frame.groupKey) == "string" and string.lower(frame.groupKey) or tostring(frame.groupKey):lower()
    end

    -- Check legacy IsPrimary flag
    if frame.IsPrimary then
        return "primary"
    end

    -- Check frame name for legacy groups
    local frameName = frame.GetName and frame:GetName()
    if frameName then
        -- Legacy frame names like "NAG_FrameIconLeft1", "NAG_FrameIconAbove1", etc.
        if string.find(frameName, "Left") then
            return "left"
        elseif string.find(frameName, "Right") then
            return "right"
        elseif string.find(frameName, "Above") then
            return "above"
        elseif string.find(frameName, "Below") then
            return "below"
        elseif string.find(frameName, "AOE") or string.find(frameName, "Aoe") then
            return "aoe"
        end
    end

    return nil
end

--- Get per-group keybind settings with fallbacks
--- @param self table KeybindManager instance
--- @param groupKey string|nil The group key (lowercase)
--- @return table Settings table with anchor, offsetX, offsetY, fontSize, font
local function GetGroupKeybindSettings(self, groupKey)
    local defaults = {
        anchor = "BOTTOMLEFT",
        offsetX = 2,
        offsetY = 2,
        fontSize = 12,
        font = "Friz Quadrata TT",
    }

    if not self.db or not self.db.global then
        return defaults
    end

    -- If no group key, use default non-primary settings
    if not groupKey then
        return defaults
    end

    -- Get group-specific settings
    local keybindGroups = self.db.global.keybindGroups
    if not keybindGroups then
        -- Default based on group type
        if groupKey == "primary" or groupKey == "main" then
        return {
            anchor = "BOTTOMLEFT",
            offsetX = 2,
            offsetY = 2,
            fontSize = 18,
            font = "Friz Quadrata TT",
        }
    end
        return defaults
    end

    local groupSettings = keybindGroups[groupKey]
    if not groupSettings then
        -- Default based on group type
        if groupKey == "primary" or groupKey == "main" then
            return {
                anchor = "BOTTOMLEFT",
                offsetX = 2,
                offsetY = 2,
                fontSize = 18,
                font = "Friz Quadrata TT",
            }
        end
        return defaults
    end

    -- Merge with defaults to ensure all fields exist
    local font = groupSettings.font or defaults.font
    local fontSize = groupSettings.fontSize
    if not fontSize then
        -- Default based on group type
        fontSize = (groupKey == "primary" or groupKey == "main") and 18 or 12
    end

    return {
        anchor = groupSettings.anchor or defaults.anchor,
        offsetX = groupSettings.offsetX or defaults.offsetX,
        offsetY = groupSettings.offsetY or defaults.offsetY,
        fontSize = fontSize,
        font = font,
    }
end

-- ============================ EVENT HANDLERS ============================

--- Handle ACTIONBAR_SLOT_CHANGED event
--- @param event string Event name
--- @param actionSlot number Action slot that changed
function KeybindManager:ACTIONBAR_SLOT_CHANGED(event, actionSlot)
    self:ClearKeybindCache()
    -- For ElvUI, ensure cache is populated before updating single slot
    -- This ensures we get the correct keybind from the visible frame
    if _G.ElvUI and _G.ElvUI[1] and _G.ElvUI[1].ActionBars then
        if not visibleFrameSlotsCache then
            visibleFrameSlotsCache = GetVisibleFrameSlots()
        end
    end
    UpdateAction(actionSlot)
end

--- Handle PET_BAR_UPDATE event
--- @param event string Event name
function KeybindManager:PET_BAR_UPDATE(event)
    UpdatePetBarKeybinds()
    if self.UpdateAllKeybinds then
        self:UpdateAllKeybinds()
    end
end

--- Handle UNIT_PET event
--- @param event string Event name
--- @param unit string Unit that changed pets
function KeybindManager:UNIT_PET(event, unit)
    if unit ~= "player" then return end

    UpdatePetBarKeybinds()
    if self.UpdateAllKeybinds then
        self:UpdateAllKeybinds()
    end
end

--- Invalidate visible frame slots cache (call when ElvUI config changes or frames update)
function KeybindManager:InvalidateVisibleFrameCache()
    visibleFrameSlotsCache = nil
end

--- Clear keybind result caches (spell/item). Call when action bar or bindings change.
function KeybindManager:ClearKeybindCache()
    if self._spellKeybindCache then
        wipe(self._spellKeybindCache)
    end
    if self._itemKeybindCache then
        wipe(self._itemKeybindCache)
    end
end

--- Handle bulk update events (scan all slots)
--- @param event string Event name
function KeybindManager:UPDATE_BINDINGS(event)
    self:ClearKeybindCache()
    -- Clear visible frame cache before scanning (frames may have changed)
    visibleFrameSlotsCache = nil

    -- For ElvUI, populate cache once before scanning all slots to ensure consistency
    if _G.ElvUI and _G.ElvUI[1] and _G.ElvUI[1].ActionBars then
        visibleFrameSlotsCache = GetVisibleFrameSlots()
    end

    for i = 1, MAX_ACTION_SLOTS do
        UpdateAction(i)
    end

    UpdatePetBarKeybinds()

    -- Keep cache for ElvUI (it's used during UpdateAction), clear for others
    if not (_G.ElvUI and _G.ElvUI[1] and _G.ElvUI[1].ActionBars) then
        visibleFrameSlotsCache = nil
    end
end

KeybindManager.PLAYER_SPECIALIZATION_CHANGED = KeybindManager.UPDATE_BINDINGS
KeybindManager.PLAYER_TALENT_UPDATE = KeybindManager.UPDATE_BINDINGS
KeybindManager.LEARNED_SPELL_IN_TAB = KeybindManager.UPDATE_BINDINGS
KeybindManager.SPELL_UPDATE_ICON = KeybindManager.UPDATE_BINDINGS
KeybindManager.UPDATE_SHAPESHIFT_FORM = KeybindManager.UPDATE_BINDINGS
KeybindManager.ACTIONBAR_UPDATE_USABLE = KeybindManager.UPDATE_BINDINGS
KeybindManager.ZONE_CHANGED_NEW_AREA = KeybindManager.UPDATE_BINDINGS

--- Handle PLAYER_ENTERING_WORLD - scan when fully loaded (action bar addons may populate after login)
function KeybindManager:PLAYER_ENTERING_WORLD()
    self:UPDATE_BINDINGS("PLAYER_ENTERING_WORLD")
end

-- ============================ PUBLIC API ============================

--- Get keybind for a spell ID
--- Uses texture-based lookup which matches what's actually displayed on action bars
--- Handles spell ID variants (same spell, different IDs) by resolving through SpellbookManager
--- Checks keybind overrides first (takes priority over action bar keybinds)
--- @param spellID number Spell ID
--- @return string|nil Formatted keybind string or nil
function KeybindManager:GetSpellKeybind(spellID)
    if not self:IsEnabled() then return nil end
    if not spellID then return nil end

    -- Check keybind overrides first (takes priority over action bar keybinds)
    local keybindOverrides = self.db.char.keybindOverrides
    if keybindOverrides and keybindOverrides.spell and keybindOverrides.spell[spellID] then
        return FormatKeybind(keybindOverrides.spell[spellID])
    end

    -- Cache lookup (avoids repeated GetSpellTexture on display hot path)
    self._spellKeybindCache = self._spellKeybindCache or {}
    local cached = self._spellKeybindCache[spellID]
    if cached ~= nil then
        if cached == KEYBIND_CACHE_SENTINEL_NIL then return nil end
        return cached
    end

    -- Get texture ID from spell ID and use texture-based lookup
    local textureID = GetSpellTexture(spellID)
    if textureID then
        local keybind = self:GetTextureKeybind(textureID)
        if keybind then
            local n = 0
            for _ in pairs(self._spellKeybindCache) do n = n + 1 end
            if n >= MAX_KEYBIND_CACHE_SIZE then
                wipe(self._spellKeybindCache)
            end
            self._spellKeybindCache[spellID] = keybind
            return keybind
        end
    end

    -- Fallback to spell ID lookup if texture lookup fails (for edge cases)
    local action = FindAction("Spell", spellID)
    if action then
        local keybind = nil
        if action.Type == "macro" and action.ID and keybindOverrides and keybindOverrides.macro then
            local overrideKeybind = keybindOverrides.macro[action.ID] or keybindOverrides.macro[tostring(action.ID)]
            if overrideKeybind then
                keybind = FormatKeybind(overrideKeybind)
            end
        end
        if not keybind and action.HotKey then
            keybind = action.HotKey
        end
        if keybind then
            local n = 0
            for _ in pairs(self._spellKeybindCache) do n = n + 1 end
            if n >= MAX_KEYBIND_CACHE_SIZE then
                wipe(self._spellKeybindCache)
            end
            self._spellKeybindCache[spellID] = keybind
            return keybind
        end
    end

    -- Try resolving spell ID variant (same spell name, different ID)
    local SpellbookManager = NAG:GetModule("SpellbookManager")
    if SpellbookManager and SpellbookManager.ResolveEffectiveSpellID then
        local effectiveSpellID = SpellbookManager:ResolveEffectiveSpellID(spellID)
        if effectiveSpellID and effectiveSpellID ~= spellID then
            -- Check override for resolved ID too
            if keybindOverrides and keybindOverrides.spell and keybindOverrides.spell[effectiveSpellID] then
                local result = FormatKeybind(keybindOverrides.spell[effectiveSpellID])
                local n = 0
                for _ in pairs(self._spellKeybindCache) do n = n + 1 end
                if n >= MAX_KEYBIND_CACHE_SIZE then wipe(self._spellKeybindCache) end
                self._spellKeybindCache[spellID] = result
                return result
            end
            -- Try texture lookup with resolved ID
            local resolvedTextureID = GetSpellTexture(effectiveSpellID)
            if resolvedTextureID then
                local keybind = self:GetTextureKeybind(resolvedTextureID)
                if keybind then
                    local n = 0
                    for _ in pairs(self._spellKeybindCache) do n = n + 1 end
                    if n >= MAX_KEYBIND_CACHE_SIZE then wipe(self._spellKeybindCache) end
                    self._spellKeybindCache[spellID] = keybind
                    return keybind
                end
            end
            -- Fallback to spell ID lookup with resolved ID
            action = FindAction("Spell", effectiveSpellID)
            if action and action.HotKey then
                local n = 0
                for _ in pairs(self._spellKeybindCache) do n = n + 1 end
                if n >= MAX_KEYBIND_CACHE_SIZE then wipe(self._spellKeybindCache) end
                self._spellKeybindCache[spellID] = action.HotKey
                return action.HotKey
            end
        end
    end

    -- Fallback: match by spell name (handles ID variants when ResolveEffectiveSpellID doesn't)
    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local targetName = spellInfo and spellInfo.name
    if targetName and ActionSlotsBy and ActionSlotsBy.Spell then
        for barSpellID, actionSlots in pairs(ActionSlotsBy.Spell) do
            if actionSlots and #actionSlots > 0 then
                local barSpellInfo = WoWAPI.GetSpellInfo(barSpellID)
                if barSpellInfo and barSpellInfo.name == targetName then
                    action = FindAction("Spell", barSpellID)
                    if action and action.HotKey then
                        local n = 0
                        for _ in pairs(self._spellKeybindCache) do n = n + 1 end
                        if n >= MAX_KEYBIND_CACHE_SIZE then wipe(self._spellKeybindCache) end
                        self._spellKeybindCache[spellID] = action.HotKey
                        return action.HotKey
                    end
                    break
                end
            end
        end
    end

    local n = 0
    for _ in pairs(self._spellKeybindCache) do n = n + 1 end
    if n >= MAX_KEYBIND_CACHE_SIZE then
        wipe(self._spellKeybindCache)
    end
    self._spellKeybindCache[spellID] = KEYBIND_CACHE_SENTINEL_NIL
    return nil
end

--- Get keybind for a texture ID
--- Checks keybind overrides first (takes priority over action bar keybinds)
--- Uses texture-based lookup which matches what's actually displayed on action bars
--- @param textureID number Texture ID (file ID from GetActionTexture or GetSpellTexture)
--- @return string|nil Formatted keybind string or nil
function KeybindManager:GetTextureKeybind(textureID)
    if not self:IsEnabled() then return nil end
    if not textureID then return nil end

    -- Check keybind overrides first (takes priority over action bar keybinds)
    local keybindOverrides = self.db.char.keybindOverrides
    if keybindOverrides and keybindOverrides.texture and keybindOverrides.texture[textureID] then
        return FormatKeybind(keybindOverrides.texture[textureID])
    end

    -- Use texture-based lookup (matches what's actually on action bars)
    local action = FindAction("Texture", textureID)
    if action then
        -- Macro override takes precedence over action bar keybind
        if action.Type == "macro" and action.ID then
            local macroOverride = keybindOverrides.macro and (keybindOverrides.macro[action.ID] or keybindOverrides.macro[tostring(action.ID)])
            if macroOverride then
                return FormatKeybind(macroOverride)
            end
        end
        if action.HotKey then
            return action.HotKey
        end
    end

    -- Fallback to pet bar keybinds (Hunter pet abilities)
    local petKeybind = PetBarKeybindsByTexture[textureID]
    if petKeybind then
        return petKeybind
    end

    return nil
end

--- Get keybind for an item ID
--- Checks keybind overrides first (takes priority over action bar keybinds)
--- @param itemID number Item ID
--- @return string|nil Formatted keybind string or nil
function KeybindManager:GetItemKeybind(itemID)
    if not self:IsEnabled() then return nil end
    if not itemID then return nil end

    -- Check keybind overrides first (takes priority over action bar keybinds)
    local keybindOverrides = self.db.char.keybindOverrides
    if keybindOverrides and keybindOverrides.item and keybindOverrides.item[itemID] then
        return FormatKeybind(keybindOverrides.item[itemID])
    end

    -- Cache lookup (avoids repeated lookups on display hot path)
    self._itemKeybindCache = self._itemKeybindCache or {}
    local cached = self._itemKeybindCache[itemID]
    if cached ~= nil then
        if cached == KEYBIND_CACHE_SENTINEL_NIL then return nil end
        return cached
    end

    -- Try direct lookup
    local action = FindAction("Item", itemID)
    if action and action.HotKey then
        local n = 0
        for _ in pairs(self._itemKeybindCache) do n = n + 1 end
        if n >= MAX_KEYBIND_CACHE_SIZE then
            wipe(self._itemKeybindCache)
        end
        self._itemKeybindCache[itemID] = action.HotKey
        return action.HotKey
    end

    local n = 0
    for _ in pairs(self._itemKeybindCache) do n = n + 1 end
    if n >= MAX_KEYBIND_CACHE_SIZE then
        wipe(self._itemKeybindCache)
    end
    self._itemKeybindCache[itemID] = KEYBIND_CACHE_SENTINEL_NIL
    return nil
end

--- Get keybind for a macro ID
--- Checks keybind overrides first (takes priority over action bar keybinds)
--- @param macroID number Macro ID
--- @return string|nil Formatted keybind string or nil
function KeybindManager:GetMacroKeybind(macroID)
    if not self:IsEnabled() then return nil end
    if not macroID then return nil end

    -- Check keybind overrides first (takes priority over action bar keybinds)
    -- Support both numeric and string keys (AceDB may serialize numeric keys as strings)
    local keybindOverrides = self.db.char.keybindOverrides
    if keybindOverrides and keybindOverrides.macro then
        local keybind = keybindOverrides.macro[macroID] or keybindOverrides.macro[tostring(macroID)]
        if keybind then
            return FormatKeybind(keybind)
        end
    end

    -- Try direct lookup
    local action = FindAction("Macro", macroID)
    if action and action.HotKey then
        return action.HotKey
    end

    return nil
end

--- Rescan all action slots
function KeybindManager:RescanAllActions()
    for i = 1, MAX_ACTION_SLOTS do
        UpdateAction(i)
    end
end

-- ============================ KEYBIND OVERRIDES ============================

--- Override keybind for a spell ID
--- @param spellID number Spell ID
--- @param keybind string|nil Keybind string (nil to remove override)
function KeybindManager:OverrideSpellKeybind(spellID, keybind)
    if not spellID then return end
    if not self.db.char.keybindOverrides then
        self.db.char.keybindOverrides = {}
    end
    if not self.db.char.keybindOverrides.spell then
        self.db.char.keybindOverrides.spell = {}
    end
    if keybind then
        self.db.char.keybindOverrides.spell[spellID] = FormatKeybind(keybind)
    else
        self.db.char.keybindOverrides.spell[spellID] = nil
    end
    -- Update all keybind displays
    if self.UpdateAllKeybinds then
        self:UpdateAllKeybinds()
    end
end

--- Override keybind for an item ID
--- @param itemID number Item ID
--- @param keybind string|nil Keybind string (nil to remove override)
function KeybindManager:OverrideItemKeybind(itemID, keybind)
    if not itemID then return end
    if not self.db.char.keybindOverrides then
        self.db.char.keybindOverrides = {}
    end
    if not self.db.char.keybindOverrides.item then
        self.db.char.keybindOverrides.item = {}
    end
    if keybind then
        self.db.char.keybindOverrides.item[itemID] = FormatKeybind(keybind)
    else
        self.db.char.keybindOverrides.item[itemID] = nil
    end
    -- Update all keybind displays
    if self.UpdateAllKeybinds then
        self:UpdateAllKeybinds()
    end
end

--- Override keybind for a macro ID
--- @param macroID number Macro ID
--- @param keybind string|nil Keybind string (nil to remove override)
function KeybindManager:OverrideMacroKeybind(macroID, keybind)
    if not macroID then return end
    if not self.db.char.keybindOverrides then
        self.db.char.keybindOverrides = {}
    end
    if not self.db.char.keybindOverrides.macro then
        self.db.char.keybindOverrides.macro = {}
    end
    local id = tonumber(macroID) or macroID
    local macroOverrides = self.db.char.keybindOverrides.macro
    if keybind then
        macroOverrides[id] = FormatKeybind(keybind)
        macroOverrides[tostring(id)] = nil -- Prefer numeric key, remove string if present
    else
        macroOverrides[id] = nil
        macroOverrides[tostring(id)] = nil -- Clear both forms (handles serialized data)
    end
    self:ClearKeybindCache()
    -- Update all keybind displays
    if self.UpdateAllKeybinds then
        self:UpdateAllKeybinds()
    end
end

--- Set multiple keybind overrides at once
--- @param overrides table Table with override type keys: { spell = { [id] = keybind }, item = { [id] = keybind }, macro = { [id] = keybind } }
function KeybindManager:SetMultipleOverrides(overrides)
    if not overrides or type(overrides) ~= "table" then
        return
    end

    if not self.db.char.keybindOverrides then
        self.db.char.keybindOverrides = {}
    end

    local changesCount = 0
    for overrideType, typeOverrides in pairs(overrides) do
        if type(typeOverrides) == "table" then
            if not self.db.char.keybindOverrides[overrideType] then
                self.db.char.keybindOverrides[overrideType] = {}
            end
            for identifier, keybind in pairs(typeOverrides) do
                self.db.char.keybindOverrides[overrideType][identifier] = keybind and FormatKeybind(keybind) or nil
                changesCount = changesCount + 1
            end
        end
    end

    if changesCount > 0 and self.UpdateAllKeybinds then
        self:UpdateAllKeybinds()
    end
end

--- Add keybind overlay to a frame
--- @param frame Frame The frame to attach keybind overlay to
--- @return Frame The frame (for chaining)
function KeybindManager:AddKeybindToFrame(frame)
    if not frame then
        self:Warn("AddKeybindToFrame: nil frame provided")
        return frame
    end
    if not self:IsEnabled() then
        return frame
    end

    -- Clean up any existing keybind overlay (wrapper frame and text)
    if frame.keybindFrame then
        frame.keybindFrame:Hide()
        frame.keybindFrame:SetParent(nil)
        frame.keybindFrame = nil
    end
    frame.keybindText = nil

    -- Create wrapper frame at HIGH strata so keybinds draw above swipe overlays
    local keybindFrame = CreateFrame("Frame", nil, frame)
    keybindFrame:SetAllPoints(frame)
    keybindFrame:SetFrameStrata("HIGH")
    keybindFrame:SetFrameLevel(frame:GetFrameLevel() + 50)
    keybindFrame:EnableMouse(false)
    frame.keybindFrame = keybindFrame

    -- Create the keybind text as child of the high-strata wrapper
    frame.keybindText = keybindFrame:CreateFontString(nil, "OVERLAY")
    if not frame.keybindText then
        self:Debug("AddKeybindToFrame: Failed to create font string")
        return frame
    end

    -- Get group key and settings
    local groupKey = GetGroupKeyFromFrame(frame)
    local groupSettings = GetGroupKeybindSettings(self, groupKey)

    -- Set up the font string with explicit font initialization and error checking
    local fontPath, fontSize
    if not self.db then
        self:Debug("AddKeybindToFrame: Database not initialized, using default font")
        fontPath = "Fonts\\FRIZQT__.TTF"
        fontSize = groupSettings.fontSize
    else
        -- Use group-specific font
        local fontName = groupSettings.font or "Friz Quadrata TT"
        fontPath = (LSM and LSM:Fetch("font", fontName)) or
            (LSM and LSM.GetDefault and LSM:GetDefault("font")) or
            "Fonts\\FRIZQT__.TTF"
        fontSize = groupSettings.fontSize
    end
    local fontFlags = "OUTLINE"

    -- Validate fontPath and fontSize before calling SetFont
    if not fontPath or type(fontPath) ~= "string" then
        self:Error("Invalid fontPath: " .. tostring(fontPath))
        fontPath = "Fonts\\FRIZQT__.TTF"
    end

    if not fontSize or type(fontSize) ~= "number" then
        self:Error("Invalid fontSize: " .. tostring(fontSize))
        fontSize = 12
    end

    local scale = (frame.keybindFontSizeScale and type(frame.keybindFontSizeScale) == "number") and frame.keybindFontSizeScale or 1
    fontSize = math.floor(fontSize * scale + 0.5)

    local success = frame.keybindText:SetFont(fontPath, fontSize, fontFlags)
    if not success then
        -- Try system font as fallback
        fontPath = "Fonts\\FRIZQT__.TTF"
        success = frame.keybindText:SetFont(fontPath, fontSize, fontFlags)
        if not success then
            self:Error("Failed to set keybind text font")
            return frame
        end
    end

    -- Set anchor point and offset using per-group settings (anchor to wrapper; same geometry as frame)
    frame.keybindText:SetPoint(groupSettings.anchor, keybindFrame, groupSettings.anchor, groupSettings.offsetX, groupSettings.offsetY)

    -- Set justify based on anchor point for proper text alignment
    local justifyH = "LEFT"
    local justifyV = "BOTTOM"
    if string.find(groupSettings.anchor, "RIGHT") then
        justifyH = "RIGHT"
    elseif string.find(groupSettings.anchor, "CENTER") or groupSettings.anchor == "LEFT" or groupSettings.anchor == "RIGHT" or groupSettings.anchor == "TOP" or groupSettings.anchor == "BOTTOM" then
        justifyH = "CENTER"
    end
    if string.find(groupSettings.anchor, "TOP") then
        justifyV = "TOP"
    elseif string.find(groupSettings.anchor, "CENTER") or groupSettings.anchor == "LEFT" or groupSettings.anchor == "RIGHT" or groupSettings.anchor == "TOP" or groupSettings.anchor == "BOTTOM" then
        justifyV = "MIDDLE"
    end

    frame.keybindText:SetJustifyH(justifyH)
    frame.keybindText:SetJustifyV(justifyV)

    -- Apply color from database
    local color = self.db.global.keybindTextColor
    frame.keybindText:SetTextColor(color[1], color[2], color[3], color[4] or 1)

    -- Store group key on frame for later use
    frame._keybindGroupKey = groupKey

    -- Store reference to KeybindManager for use in frame methods
    frame.keyBindManager = self

    -- Initialize managedFrames if needed
    if not self.managedFrames then
        self.managedFrames = {}
    end
    -- Register frame in managedFrames for UpdateAllKeybinds
    self.managedFrames[frame] = true

    -- Set up UpdateKeybindText method on frame
    if not frame.UpdateKeybindText then
        function frame:UpdateKeybindText()
            local manager = self.keyBindManager
            if not manager then return end

            -- Check if keybinds are enabled
            if not manager.db.global.enableKeybinds then
                if self.keybindText then
                    self.keybindText:Hide()
                end
                return
            end

            if not self.keybindText then return end

            -- Get group key and settings (use stored group key if available)
            local groupKey = self._keybindGroupKey or GetGroupKeyFromFrame(self)

            -- Check if primary only mode is enabled
            if manager.db.global.enableKeybindsPrimaryOnly then
                -- Only show keybinds on primary/main groups
                if groupKey ~= "primary" and groupKey ~= "main" then
                    self.keybindText:Hide()
                    return
                end
            end

            local groupSettings = GetGroupKeybindSettings(manager, groupKey)

            -- Update font with error handling and diagnostics
            local fontPath, fontSize
            if not manager.db then
                fontPath = "Fonts\\FRIZQT__.TTF"
                fontSize = groupSettings.fontSize
            else
                -- Use group-specific font
                local fontName = groupSettings.font or "Friz Quadrata TT"
                if LSM and LSM.Fetch then
                    fontPath = LSM:Fetch("font", fontName)
                end
                if not fontPath then
                    if LSM and LSM.DefaultMedia and LSM.DefaultMedia.font then
                        fontPath = LSM:Fetch("font", LSM.DefaultMedia.font)
                    end
                end
                if not fontPath then
                    fontPath = "Fonts\\FRIZQT__.TTF"
                end
                fontSize = groupSettings.fontSize
            end

            -- Validate fontPath and fontSize before calling SetFont
            if not fontPath or type(fontPath) ~= "string" then
                manager:Error("Invalid fontPath in UpdateKeybindText: " .. tostring(fontPath))
                fontPath = "Fonts\\FRIZQT__.TTF"
            end

            if not fontSize or type(fontSize) ~= "number" then
                manager:Error("Invalid fontSize in UpdateKeybindText: " .. tostring(fontSize))
                fontSize = 12
            end

            local scale = (self.keybindFontSizeScale and type(self.keybindFontSizeScale) == "number") and self.keybindFontSizeScale or 1
            fontSize = math.floor((fontSize or 12) * scale + 0.5)

            local success = self.keybindText:SetFont(fontPath, fontSize, "OUTLINE")
            if not success then
                -- Try system font as fallback
                fontPath = "Fonts\\FRIZQT__.TTF"
                success = self.keybindText:SetFont(fontPath, fontSize or 12, "OUTLINE")
                if not success then
                    self.keybindText:Hide()
                    return
                end
            end

            -- Update anchor point and offset using per-group settings
            self.keybindText:ClearAllPoints()
            self.keybindText:SetPoint(groupSettings.anchor, self, groupSettings.anchor, groupSettings.offsetX, groupSettings.offsetY)

            -- Update justify based on anchor point for proper text alignment
            local justifyH = "LEFT"
            local justifyV = "BOTTOM"
            if string.find(groupSettings.anchor, "RIGHT") then
                justifyH = "RIGHT"
            elseif string.find(groupSettings.anchor, "CENTER") or groupSettings.anchor == "LEFT" or groupSettings.anchor == "RIGHT" or groupSettings.anchor == "TOP" or groupSettings.anchor == "BOTTOM" then
                justifyH = "CENTER"
            end
            if string.find(groupSettings.anchor, "TOP") then
                justifyV = "TOP"
            elseif string.find(groupSettings.anchor, "CENTER") or groupSettings.anchor == "LEFT" or groupSettings.anchor == "RIGHT" or groupSettings.anchor == "TOP" or groupSettings.anchor == "BOTTOM" then
                justifyV = "MIDDLE"
            end

            self.keybindText:SetJustifyH(justifyH)
            self.keybindText:SetJustifyV(justifyV)

            -- Update color
            local r, g, b, a
            if manager.db then
                r, g, b, a = unpack(manager.db.global.keybindTextColor)
            else
                r, g, b, a = 1, 1, 1, 1 -- Default white color
            end
            self.keybindText:SetTextColor(r, g, b, a)

            -- Get keybind for spell, item, or macro
            -- Tinkers: prefer item lookup (user binds gloves item, not the spell)
            local keybind = ""
            if self.itemId and manager.GetItemKeybind then
                keybind = manager:GetItemKeybind(self.itemId) or ""
            end
            if keybind == "" and self.spellId and manager.GetSpellKeybind then
                keybind = manager:GetSpellKeybind(self.spellId) or ""
            end
            if keybind == "" and self.macroId and manager.GetMacroKeybind then
                keybind = manager:GetMacroKeybind(self.macroId) or ""
            end

            -- Update text
            self.keybindText:SetText(keybind)
            if keybind ~= "" then
                self.keybindText:Show()
            else
                self.keybindText:Hide()
            end
        end
    end

    -- Initial update
    frame:UpdateKeybindText()

    return frame
end

--- Update all keybind displays
function KeybindManager:UpdateAllKeybinds()
    if not self:IsEnabled() or not self.managedFrames then return end

    for frame in pairs(self.managedFrames) do
        if frame and frame.UpdateKeybindText then
            frame:UpdateKeybindText()
        end
    end
end

--- Handle NAG_KEYBIND_SETTING_CHANGED message
--- @param message string Message name
--- @param setting string Setting name
--- @param value any Setting value
function KeybindManager:NAG_KEYBIND_SETTING_CHANGED(message, setting, value)
    self:ClearKeybindCache()
    -- Update all keybind displays when settings change
    self:UpdateAllKeybinds()
end

-- ============================ OPTIONS UI ============================

--- Get player spells helper function
--- @return table spells Table of { [spellID] = spellName }
local function GetPlayerSpells()
    local spells = {}
    local SpellbookManager = NAG:GetModule("SpellbookManager")
    if SpellbookManager and SpellbookManager.GetCastableSpells then
        local allSpells = SpellbookManager:GetCastableSpells()
        if allSpells then
            for spellID, spellData in pairs(allSpells) do
                if spellData and spellData.name then
                    spells[spellID] = spellData.name
                end
            end
        end
    end
    return spells
end

--- Get all macros from action bars
--- @return table macros Table of { [macroID] = { name, icon } }
local function GetActionBarMacros()
    local macros = {}
    for i = 1, MAX_ACTION_SLOTS do
        local actionType, actionID = GetActionInfo(i)
        if actionType == "macro" and actionID then
            local macroName, macroIcon = GetMacroInfo(actionID)
            if macroName and not macros[actionID] then
                macros[actionID] = { name = macroName, icon = macroIcon }
            end
        end
    end
    return macros
end

--- Get options for KeybindManager
--- @return table Options table
function KeybindManager:GetOptions()
    local OptionsFactory = NAG:GetModule("OptionsFactory")
    if not OptionsFactory then
        return { type = "group", args = {} }
    end

    -- Initialize UI state for selected spell/macro
    if not self.uiState then
        self.uiState = {
            selectedSpellID = nil,
            selectedMacroID = nil,
            selectedKeybind = "",
        }
    end

    return {
        type = "group",
        name = "Keybind Manager",
        desc = "Configure keybind display and overrides for abilities and items.",
        order = 1,
        args = {
            -- Display settings
            displaySettings = {
                type = "group",
                name = "Display Settings",
                order = 0,
                inline = true,
                args = {
                    enableKeybinds = OptionsFactory:CreateToggle(
                        "Enable Keybinds",
                        "Show keybind text on spell icons. When off, the KeybindManager module is fully disabled (no events, no scanning).",
                        function() return self.db.global.enableKeybinds end,
                        function(_, val)
                            self.db.global.enableKeybinds = val
                            if val then
                                NAG:EnableModule("KeybindManager")
                            else
                                NAG:DisableModule("KeybindManager")
                            end
                            NAG:SendMessage("NAG_KEYBIND_SETTING_CHANGED", "enableKeybinds", val)
                        end,
                        { order = 1 }
                    ),
                    primaryOnly = OptionsFactory:CreateToggle(
                        "Primary Icon Only",
                        "Show keybinds only on the primary (main) spell icon",
                        function() return self.db.global.enableKeybindsPrimaryOnly end,
                        function(_, val)
                            self.db.global.enableKeybindsPrimaryOnly = val
                            self:UpdateAllKeybinds()
                            NAG:SendMessage("NAG_KEYBIND_SETTING_CHANGED", "enableKeybindsPrimaryOnly", val)
                        end,
                        { order = 2 }
                    ),
                    textColor = OptionsFactory:CreateColor(
                        "Text Color",
                        "Color of the keybind text",
                        function() return unpack(self.db.global.keybindTextColor) end,
                        function(_, r, g, b, a)
                            self.db.global.keybindTextColor = {r, g, b, a}
                            self:UpdateAllKeybinds()
                        end,
                        { order = 3, hasAlpha = true }
                    ),
                    primaryFontSize = OptionsFactory:CreateRange(
                        "Primary Font Size",
                        "Font size for primary (main) group keybinds",
                        function()
                            local groups = self.db.global.keybindGroups
                            local primary = groups and groups.primary
                            local main = groups and groups.main
                            return (primary and primary.fontSize) or (main and main.fontSize) or 18
                        end,
                        function(_, value)
                            if not self.db.global.keybindGroups then
                                self.db.global.keybindGroups = {}
                            end
                            if not self.db.global.keybindGroups.primary then
                                self.db.global.keybindGroups.primary = {}
                            end
                            if not self.db.global.keybindGroups.main then
                                self.db.global.keybindGroups.main = {}
                            end
                            self.db.global.keybindGroups.primary.fontSize = value
                            self.db.global.keybindGroups.main.fontSize = value
                            self:UpdateAllKeybinds()
                            NAG:SendMessage("NAG_KEYBIND_SETTING_CHANGED", "primaryFontSize", value)
                        end,
                        {
                            min = 8,
                            max = 32,
                            step = 1,
                            order = 4,
                        }
                    ),
                    otherFontSize = OptionsFactory:CreateRange(
                        "Other Groups Font Size",
                        "Font size for other groups (cooldowns, interrupts, etc.)",
                        function()
                            local groups = self.db.global.keybindGroups
                            local above = groups and groups.above
                            if above and above.fontSize then
                                return above.fontSize
                            end
                            local cooldowns = groups and groups.cooldowns
                            if cooldowns and cooldowns.fontSize then
                                return cooldowns.fontSize
                            end
                            return 12
                        end,
                        function(_, value)
                            if not self.db.global.keybindGroups then
                                self.db.global.keybindGroups = {}
                            end
                            local extraGroups = {"above", "below", "left", "right", "aoe", "cooldowns", "interrupts", "defensives", "sequence"}
                            for _, groupKey in ipairs(extraGroups) do
                                if not self.db.global.keybindGroups[groupKey] then
                                    self.db.global.keybindGroups[groupKey] = {}
                                end
                                self.db.global.keybindGroups[groupKey].fontSize = value
                            end
                            self:UpdateAllKeybinds()
                            NAG:SendMessage("NAG_KEYBIND_SETTING_CHANGED", "otherFontSize", value)
                        end,
                        {
                            min = 8,
                            max = 32,
                            step = 1,
                            order = 5,
                        }
                    ),
                }
            },
            -- Keybind overrides
            spellOverride = {
                type = "group",
                name = "Spell Override",
                order = 1,
                inline = true,
                args = {
                    info = OptionsFactory:CreateDescription(
                        "Keybind overrides allow you to display custom keybinds for abilities that may not match your actual action bar keybinds. This is useful when using macros or addons that change ability locations.\n\nFormat: Use modifier keys like ALT-1, SHIFT-F, CTRL-2, or plain keys like F, G, 1, 2.",
                        nil,
                        { order = 0, fontSize = "medium" }
                    ),
                    spellSelect = {
                        type = "select",
                        name = "Select Spell or Macro",
                        desc = "Choose a spell from your spellbook or a macro from your action bars",
                        order = 1,
                        width = "normal",
                        get = function()
                            if self.uiState.selectedMacroID then
                                return "macro:" .. tostring(self.uiState.selectedMacroID)
                            end
                            if self.uiState.selectedSpellID then
                                return "spell:" .. tostring(self.uiState.selectedSpellID)
                            end
                            return ""
                        end,
                        set = function(_, value)
                            self.uiState.selectedSpellID = nil
                            self.uiState.selectedMacroID = nil
                            if type(value) == "string" then
                                if strsub(value, 1, 6) == "macro:" then
                                    self.uiState.selectedMacroID = tonumber(strsub(value, 7))
                                elseif strsub(value, 1, 6) == "spell:" then
                                    self.uiState.selectedSpellID = tonumber(strsub(value, 7))
                                end
                            end
                        end,
                        values = function()
                            local result = {}
                            local allItems = {}

                            -- Collect all spells
                            local spells = GetPlayerSpells()
                            if spells and next(spells) then
                                for id, name in pairs(spells) do
                                    local spellInfo = WoWAPI.GetSpellInfo(id)
                                    local icon = spellInfo and spellInfo.iconID
                                    local iconTexture = icon and format("|T%s:16:16:0:0|t ", icon) or ""
                                    local label = iconTexture .. name
                                    tinsert(allItems, {
                                        key = "spell:" .. tostring(id),
                                        id = id,
                                        name = name,
                                        label = label,
                                        sortName = name
                                    })
                                end
                            end

                            -- Collect all macros
                            local macros = GetActionBarMacros()
                            if macros and next(macros) then
                                for id, data in pairs(macros) do
                                    local iconTexture = data.icon and format("|T%s:16:16:0:0|t ", data.icon) or ""
                                    local label = iconTexture .. "[Macro] " .. data.name
                                    tinsert(allItems, {
                                        key = "macro:" .. tostring(id),
                                        id = id,
                                        name = data.name,
                                        label = label,
                                        sortName = data.name
                                    })
                                end
                            end

                            -- Sort all items alphabetically by name (case-insensitive)
                            sort(allItems, function(a, b)
                                return strlower(a.sortName) < strlower(b.sortName)
                            end)

                            -- Build result table in sorted order
                            for _, item in ipairs(allItems) do
                                result[item.key] = item.label
                            end

                            if not next(result) then
                                result[""] = "|cffff0000No spells or macros found. Try reloading.|r"
                            end
                            return result
                        end,
                        sorting = function()
                            -- Compute the same sorted list as values() to ensure consistent ordering
                            local allItems = {}

                            -- Collect all spells
                            local spells = GetPlayerSpells()
                            if spells and next(spells) then
                                for id, name in pairs(spells) do
                                    tinsert(allItems, {
                                        key = "spell:" .. tostring(id),
                                        sortName = name
                                    })
                                end
                            end

                            -- Collect all macros
                            local macros = GetActionBarMacros()
                            if macros and next(macros) then
                                for id, data in pairs(macros) do
                                    tinsert(allItems, {
                                        key = "macro:" .. tostring(id),
                                        sortName = data.name
                                    })
                                end
                            end

                            -- Sort all items alphabetically by name (case-insensitive)
                            sort(allItems, function(a, b)
                                return strlower(a.sortName) < strlower(b.sortName)
                            end)

                            -- Build sorting array in sorted order
                            local sorting = {}
                            for _, item in ipairs(allItems) do
                                tinsert(sorting, item.key)
                            end

                            if #sorting == 0 then
                                tinsert(sorting, "")
                            end

                            return sorting
                        end,
                    },
                    keybindInput = OptionsFactory:CreateKeybinding(
                        "Keybind",
                        "Press a keybind (supports CTRL/ALT/SHIFT modifiers)",
                        function() return self.uiState.selectedKeybind or "" end,
                        function(_, value)
                            self.uiState.selectedKeybind = value
                        end,
                        { order = 2, width = "normal" }
                    ),
                    addOverride = OptionsFactory:CreateExecute(
                        "Add Override",
                        "Add the keybind override for the selected spell or macro",
                        function()
                            if self.uiState.selectedKeybind and self.uiState.selectedKeybind ~= "" then
                                if self.uiState.selectedSpellID then
                                    self:OverrideSpellKeybind(self.uiState.selectedSpellID, self.uiState.selectedKeybind)
                                    self:Info(format("Added spell keybind override: %d -> %s", self.uiState.selectedSpellID, self.uiState.selectedKeybind))
                                    self.uiState.selectedSpellID = nil
                                    self.uiState.selectedKeybind = ""
                                    if ns.AceConfigRegistry then
                                        ns.AceConfigRegistry:NotifyChange("NAG")
                                    end
                                    return
                                elseif self.uiState.selectedMacroID then
                                    self:OverrideMacroKeybind(self.uiState.selectedMacroID, self.uiState.selectedKeybind)
                                    self:Info(format("Added macro keybind override: %d -> %s", self.uiState.selectedMacroID, self.uiState.selectedKeybind))
                                    self.uiState.selectedMacroID = nil
                                    self.uiState.selectedKeybind = ""
                                    if ns.AceConfigRegistry then
                                        ns.AceConfigRegistry:NotifyChange("NAG")
                                    end
                                    return
                                end
                            end
                            self:Error("Please select a spell or macro and enter a keybind")
                        end,
                        { order = 3 }
                    ),
                    deleteSelectedOverride = OptionsFactory:CreateExecute(
                        "Delete Selected Override",
                        "Remove the keybind override for the selected spell or macro",
                        function()
                            if self.uiState.selectedSpellID then
                                self:OverrideSpellKeybind(self.uiState.selectedSpellID, nil)
                                self:Info(format("Removed spell keybind override for: %d", self.uiState.selectedSpellID))
                                self.uiState.selectedSpellID = nil
                                self.uiState.selectedKeybind = ""
                                if ns.AceConfigRegistry then
                                    ns.AceConfigRegistry:NotifyChange("NAG")
                                end
                            elseif self.uiState.selectedMacroID then
                                self:OverrideMacroKeybind(self.uiState.selectedMacroID, nil)
                                self:Info(format("Removed macro keybind override for: %d", self.uiState.selectedMacroID))
                                self.uiState.selectedMacroID = nil
                                self.uiState.selectedKeybind = ""
                                if ns.AceConfigRegistry then
                                    ns.AceConfigRegistry:NotifyChange("NAG")
                                end
                            else
                                self:Error("Please select a spell or macro to remove its override")
                            end
                        end,
                        { order = 4 }
                    ),
                }
            },
            -- Current overrides display
            currentOverrides = {
                type = "group",
                name = "Current Overrides",
                order = 2,
                inline = true,
                args = (function()
                    local args = {}
                    local orderCounter = 1
                    local keybindOverrides = self.db.char.keybindOverrides

                    -- Spells header
                    args.spellsHeader = OptionsFactory:CreateHeader(
                        "Spells",
                        { order = orderCounter }
                    )
                    orderCounter = orderCounter + 1

                    -- Build spell overrides
                    do
                        local entries = {}
                        for spellID, keybind in pairs(keybindOverrides.spell or {}) do
                            local spellInfo = WoWAPI.GetSpellInfo(spellID)
                            local name = spellInfo and spellInfo.name or "Unknown"
                            local icon = spellInfo and spellInfo.iconID or nil
                            tinsert(entries, { name = name, id = spellID, key = keybind, icon = icon })
                        end
                        sort(entries, function(a, b) return strlower(a.name) < strlower(b.name) end)

                        for i, e in ipairs(entries) do
                            local rowKey = "spellRow_" .. tostring(e.id)
                            args[rowKey .. "_label"] = OptionsFactory:CreateDescription(
                                format("|T%s:16:16:0:0|t %s: %s", e.icon or "Interface\\Icons\\INV_Misc_QuestionMark", e.name, e.key),
                                nil,
                                { order = orderCounter, width = 1.9 }
                            )
                            args[rowKey .. "_remove"] = OptionsFactory:CreateExecute(
                                "",
                                "Remove this override",
                                function()
                                    self:OverrideSpellKeybind(e.id, nil)
                                    if ns.AceConfigRegistry then
                                        ns.AceConfigRegistry:NotifyChange("NAG")
                                    end
                                end,
                                {
                                    order = orderCounter + 0.1,
                                    width = 0.1,
                                    image = "Interface\\Buttons\\CancelButton-Up",
                                    imageWidth = 25,
                                    imageHeight = 25,
                                }
                            )
                            orderCounter = orderCounter + 1
                        end
                    end

                    -- Macros header
                    if keybindOverrides.macro and next(keybindOverrides.macro) then
                        args.macrosHeader = OptionsFactory:CreateHeader(
                            "Macros",
                            { order = orderCounter }
                        )
                        orderCounter = orderCounter + 1

                        -- Build macro overrides (macroID may be string after AceDB load)
                        do
                            local entries = {}
                            for macroID, keybind in pairs(keybindOverrides.macro or {}) do
                                local idNum = tonumber(macroID) or macroID
                                local macroName, macroIcon = GetMacroInfo(idNum)
                                if macroName then
                                    tinsert(entries, { name = macroName, id = idNum, key = keybind, icon = macroIcon })
                                end
                            end
                            sort(entries, function(a, b) return strlower(a.name) < strlower(b.name) end)

                            for i, e in ipairs(entries) do
                                local rowKey = "macroRow_" .. tostring(e.id)
                                args[rowKey .. "_label"] = OptionsFactory:CreateDescription(
                                    format("|T%s:16:16:0:0|t [Macro] %s: %s", e.icon or "Interface\\Icons\\INV_Misc_QuestionMark", e.name, e.key),
                                    nil,
                                    { order = orderCounter, width = 1.9 }
                                )
                                args[rowKey .. "_remove"] = OptionsFactory:CreateExecute(
                                    "",
                                    "Remove this override",
                                    function()
                                        self:OverrideMacroKeybind(e.id, nil)
                                        if ns.AceConfigRegistry then
                                            ns.AceConfigRegistry:NotifyChange("NAG")
                                        end
                                    end,
                                    {
                                        order = orderCounter + 0.1,
                                        width = 0.1,
                                        image = "Interface\\Buttons\\CancelButton-Up",
                                        imageWidth = 25,
                                        imageHeight = 25,
                                    }
                                )
                                orderCounter = orderCounter + 1
                            end
                        end
                    end

                    if orderCounter == 1 then
                        args.noOverrides = OptionsFactory:CreateDescription(
                            "No keybind overrides configured.",
                            nil,
                            { order = orderCounter }
                        )
                    end

                    return args
                end)(),
            },
            -- Per-group keybind display settings
            groupDisplaySettings = {
                type = "group",
                name = "Per-Group Display Settings",
                desc = "Configure keybind display (anchor, offset, font size) for each group",
                order = 3,
                childGroups = "tab",
                args = (function()
                    local args = {}
                    -- Global Defaults tab for bulk Primary/Extra Groups configuration
                    args.quickSettings = {
                        type = "group",
                        name = "Global Defaults",
                        desc = "Configure default settings for all groups. These apply to all groups unless overridden by individual group settings.",
                        order = 0,
                        args = {
                            globalDefaultsDesc = OptionsFactory:CreateDescription(
                                "|cff00ff00Global Defaults|r\n\nThese settings apply to all groups by default. Individual groups can override these settings in their own tabs.\n\n• |cffffd700Primary Group|r: Settings for the main/primary spell icon\n• |cffffd700Extra Groups|r: Settings for all other groups (Above, Below, Left, Right, AOE, Cooldowns, Interrupts, Defensives, Sequence)",
                                nil,
                                { order = 1, fontSize = "medium", width = "full" }
                            ),
                            primaryHeader = OptionsFactory:CreateHeader(
                                "Primary Group Defaults",
                                { order = 10 }
                            ),
                            primaryDesc = OptionsFactory:CreateDescription(
                                "These settings apply to the primary (main) spell icon. This is the main spell recommendation shown in the center of your action guide.",
                                nil,
                                { order = 11, fontSize = "small", width = "full" }
                            ),
                            primaryFontSize = OptionsFactory:CreateRange(
                                "Font Size",
                                "Font size for keybind text on the primary spell icon. Recommended: 18-24 for better visibility.",
                                function()
                                    local groups = self.db.global.keybindGroups
                                    local primary = groups and groups.primary
                                    return (primary and primary.fontSize) or 18
                                end,
                                function(_, val)
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    if not self.db.global.keybindGroups.primary then
                                        self.db.global.keybindGroups.primary = {}
                                    end
                                    if not self.db.global.keybindGroups.main then
                                        self.db.global.keybindGroups.main = {}
                                    end
                                    self.db.global.keybindGroups.primary.fontSize = val
                                    self.db.global.keybindGroups.main.fontSize = val
                                    self:UpdateAllKeybinds()
                                end,
                                { order = 12, min = 8, max = 32, step = 1 }
                            ),
                            primaryFont = OptionsFactory:CreateSelect(
                                "Font",
                                "Font family for keybind text on the primary spell icon. Choose a font that's easy to read at a glance.",
                                function()
                                    local groups = self.db.global.keybindGroups
                                    local primary = groups and groups.primary
                                    return (primary and primary.font) or "Friz Quadrata TT"
                                end,
                                function(_, val)
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    if not self.db.global.keybindGroups.primary then
                                        self.db.global.keybindGroups.primary = {}
                                    end
                                    if not self.db.global.keybindGroups.main then
                                        self.db.global.keybindGroups.main = {}
                                    end
                                    self.db.global.keybindGroups.primary.font = val
                                    self.db.global.keybindGroups.main.font = val
                                    self:UpdateAllKeybinds()
                                end,
                                {
                                    order = 13,
                                    values = function()
                                        return LSM and LSM:HashTable("font") or {}
                                    end,
                                    dialogControl = "LSM30_Font"
                                }
                            ),
                            primaryAnchor = OptionsFactory:CreateSelect(
                                "Anchor Point",
                                "Determines which corner or edge of the spell icon the keybind text will be anchored to. BOTTOMLEFT is the most common choice.",
                                function()
                                    local groups = self.db.global.keybindGroups
                                    local primary = groups and groups.primary
                                    return (primary and primary.anchor) or "BOTTOMLEFT"
                                end,
                                function(_, val)
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    if not self.db.global.keybindGroups.primary then
                                        self.db.global.keybindGroups.primary = {}
                                    end
                                    if not self.db.global.keybindGroups.main then
                                        self.db.global.keybindGroups.main = {}
                                    end
                                    self.db.global.keybindGroups.primary.anchor = val
                                    self.db.global.keybindGroups.main.anchor = val
                                    self:UpdateAllKeybinds()
                                end,
                                {
                                    order = 14,
                                    values = {
                                        TOPLEFT = "TOPLEFT",
                                        TOP = "TOP",
                                        TOPRIGHT = "TOPRIGHT",
                                        LEFT = "LEFT",
                                        CENTER = "CENTER",
                                        RIGHT = "RIGHT",
                                        BOTTOMLEFT = "BOTTOMLEFT",
                                        BOTTOM = "BOTTOM",
                                        BOTTOMRIGHT = "BOTTOMRIGHT",
                                    }
                                }
                            ),
                            primaryOffsetX = OptionsFactory:CreateRange(
                                "Horizontal Offset",
                                "Adjusts the horizontal position of the keybind text relative to its anchor point.\n\n• Negative values move text left\n• Positive values move text right\n• Recommended range: -5 to 5",
                                function()
                                    local groups = self.db.global.keybindGroups
                                    local primary = groups and groups.primary
                                    return (primary and primary.offsetX) or 2
                                end,
                                function(_, val)
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    if not self.db.global.keybindGroups.primary then
                                        self.db.global.keybindGroups.primary = {}
                                    end
                                    if not self.db.global.keybindGroups.main then
                                        self.db.global.keybindGroups.main = {}
                                    end
                                    self.db.global.keybindGroups.primary.offsetX = val
                                    self.db.global.keybindGroups.main.offsetX = val
                                    self:UpdateAllKeybinds()
                                end,
                                { order = 15, min = -50, max = 50, step = 1 }
                            ),
                            primaryOffsetY = OptionsFactory:CreateRange(
                                "Vertical Offset",
                                "Adjusts the vertical position of the keybind text relative to its anchor point.\n\n• Negative values move text down\n• Positive values move text up\n• Recommended range: -5 to 5",
                                function()
                                    local groups = self.db.global.keybindGroups
                                    local primary = groups and groups.primary
                                    return (primary and primary.offsetY) or 2
                                end,
                                function(_, val)
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    if not self.db.global.keybindGroups.primary then
                                        self.db.global.keybindGroups.primary = {}
                                    end
                                    if not self.db.global.keybindGroups.main then
                                        self.db.global.keybindGroups.main = {}
                                    end
                                    self.db.global.keybindGroups.primary.offsetY = val
                                    self.db.global.keybindGroups.main.offsetY = val
                                    self:UpdateAllKeybinds()
                                end,
                                { order = 16, min = -50, max = 50, step = 1 }
                            ),
                            primaryReset = OptionsFactory:CreateExecute(
                                "Reset Primary Defaults",
                                "Reset all primary group settings to their default values",
                                function()
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    if self.db.global.keybindGroups.primary then
                                        self.db.global.keybindGroups.primary.font = nil
                                        self.db.global.keybindGroups.primary.fontSize = nil
                                        self.db.global.keybindGroups.primary.anchor = nil
                                        self.db.global.keybindGroups.primary.offsetX = nil
                                        self.db.global.keybindGroups.primary.offsetY = nil
                                    end
                                    if self.db.global.keybindGroups.main then
                                        self.db.global.keybindGroups.main.font = nil
                                        self.db.global.keybindGroups.main.fontSize = nil
                                        self.db.global.keybindGroups.main.anchor = nil
                                        self.db.global.keybindGroups.main.offsetX = nil
                                        self.db.global.keybindGroups.main.offsetY = nil
                                    end
                                    self:UpdateAllKeybinds()
                                    self:Info("Primary group defaults reset")
                                end,
                                { order = 17 }
                            ),
                            -- Extra groups settings
                            extraHeader = OptionsFactory:CreateHeader(
                                "Extra Groups Defaults",
                                { order = 20 }
                            ),
                            extraDesc = OptionsFactory:CreateDescription(
                                "These settings apply to all extra groups (Above, Below, Left, Right, AOE, Cooldowns, Interrupts, Defensives, Sequence) unless individually configured in their own tabs.",
                                nil,
                                { order = 21, fontSize = "small", width = "full" }
                            ),
                            extraFontSize = OptionsFactory:CreateRange(
                                "Font Size",
                                "Font size for keybind text on all extra group icons. Recommended: 12-16 for secondary icons.",
                                function()
                                    local groups = self.db.global.keybindGroups
                                    local above = groups and groups.above
                                    return (above and above.fontSize) or 12
                                end,
                                function(_, val)
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    local extraGroups = {"above", "below", "left", "right", "aoe", "cooldowns", "interrupts", "defensives", "sequence"}
                                    for _, groupKey in ipairs(extraGroups) do
                                        if not self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey] = {}
                                        end
                                        self.db.global.keybindGroups[groupKey].fontSize = val
                                    end
                                    self:UpdateAllKeybinds()
                                end,
                                { order = 22, min = 8, max = 32, step = 1 }
                            ),
                            extraFont = OptionsFactory:CreateSelect(
                                "Font",
                                "Font family for keybind text on all extra group icons. This applies to Above, Below, Left, Right, AOE, Cooldowns, Interrupts, Defensives, and Sequence groups.",
                                function()
                                    local groups = self.db.global.keybindGroups
                                    local above = groups and groups.above
                                    return (above and above.font) or "Friz Quadrata TT"
                                end,
                                function(_, val)
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    local extraGroups = {"above", "below", "left", "right", "aoe", "cooldowns", "interrupts", "defensives", "sequence"}
                                    for _, groupKey in ipairs(extraGroups) do
                                        if not self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey] = {}
                                        end
                                        self.db.global.keybindGroups[groupKey].font = val
                                    end
                                    self:UpdateAllKeybinds()
                                end,
                                {
                                    order = 23,
                                    values = function()
                                        return LSM and LSM:HashTable("font") or {}
                                    end,
                                    dialogControl = "LSM30_Font"
                                }
                            ),
                            extraAnchor = OptionsFactory:CreateSelect(
                                "Anchor Point",
                                "Determines which corner or edge of the extra group icons the keybind text will be anchored to. BOTTOMLEFT is the most common choice.",
                                function()
                                    local groups = self.db.global.keybindGroups
                                    local above = groups and groups.above
                                    return (above and above.anchor) or "BOTTOMLEFT"
                                end,
                                function(_, val)
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    local extraGroups = {"above", "below", "left", "right", "aoe", "cooldowns", "interrupts", "defensives", "sequence"}
                                    for _, groupKey in ipairs(extraGroups) do
                                        if not self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey] = {}
                                        end
                                        self.db.global.keybindGroups[groupKey].anchor = val
                                    end
                                    self:UpdateAllKeybinds()
                                end,
                                {
                                    order = 24,
                                    values = {
                                        TOPLEFT = "TOPLEFT",
                                        TOP = "TOP",
                                        TOPRIGHT = "TOPRIGHT",
                                        LEFT = "LEFT",
                                        CENTER = "CENTER",
                                        RIGHT = "RIGHT",
                                        BOTTOMLEFT = "BOTTOMLEFT",
                                        BOTTOM = "BOTTOM",
                                        BOTTOMRIGHT = "BOTTOMRIGHT",
                                    }
                                }
                            ),
                            extraOffsetX = OptionsFactory:CreateRange(
                                "Horizontal Offset",
                                "Adjusts the horizontal position of the keybind text relative to its anchor point for all extra groups.\n\n• Negative values move text left\n• Positive values move text right\n• Recommended range: -5 to 5",
                                function()
                                    local groups = self.db.global.keybindGroups
                                    local above = groups and groups.above
                                    return (above and above.offsetX) or 2
                                end,
                                function(_, val)
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    local extraGroups = {"above", "below", "left", "right", "aoe", "cooldowns", "interrupts", "defensives", "sequence"}
                                    for _, groupKey in ipairs(extraGroups) do
                                        if not self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey] = {}
                                        end
                                        self.db.global.keybindGroups[groupKey].offsetX = val
                                    end
                                    self:UpdateAllKeybinds()
                                end,
                                { order = 25, min = -50, max = 50, step = 1 }
                            ),
                            extraOffsetY = OptionsFactory:CreateRange(
                                "Vertical Offset",
                                "Adjusts the vertical position of the keybind text relative to its anchor point for all extra groups.\n\n• Negative values move text down\n• Positive values move text up\n• Recommended range: -5 to 5",
                                function()
                                    local groups = self.db.global.keybindGroups
                                    local above = groups and groups.above
                                    return (above and above.offsetY) or 2
                                end,
                                function(_, val)
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    local extraGroups = {"above", "below", "left", "right", "aoe", "cooldowns", "interrupts", "defensives", "sequence"}
                                    for _, groupKey in ipairs(extraGroups) do
                                        if not self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey] = {}
                                        end
                                        self.db.global.keybindGroups[groupKey].offsetY = val
                                    end
                                    self:UpdateAllKeybinds()
                                end,
                                { order = 26, min = -50, max = 50, step = 1 }
                            ),
                            extraReset = OptionsFactory:CreateExecute(
                                "Reset Extra Groups Defaults",
                                "Reset all extra groups settings to their default values",
                                function()
                                    if not self.db.global.keybindGroups then
                                        self.db.global.keybindGroups = {}
                                    end
                                    local extraGroups = {"above", "below", "left", "right", "aoe", "cooldowns", "interrupts", "defensives", "sequence"}
                                    for _, groupKey in ipairs(extraGroups) do
                                        if self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey].font = nil
                                            self.db.global.keybindGroups[groupKey].fontSize = nil
                                            self.db.global.keybindGroups[groupKey].anchor = nil
                                            self.db.global.keybindGroups[groupKey].offsetX = nil
                                            self.db.global.keybindGroups[groupKey].offsetY = nil
                                        end
                                    end
                                    self:UpdateAllKeybinds()
                                    self:Info("Extra groups defaults reset")
                                end,
                                { order = 27 }
                            ),
                        }
                    }
                    local allGroups = {
                        -- Legacy groups (simplified names)
                        { key = "primary", name = "Primary", order = 1 },
                        { key = "above", name = "Above", order = 2 },
                        { key = "below", name = "Below", order = 3 },
                        { key = "left", name = "Left", order = 4 },
                        { key = "right", name = "Right", order = 5 },
                        { key = "aoe", name = "AOE", order = 6 },
                        -- Modern groups
                        { key = "main", name = "Main", order = 7 },
                        { key = "cooldowns", name = "Cooldowns", order = 8 },
                        { key = "interrupts", name = "Interrupts", order = 9 },
                        { key = "defensives", name = "Defensives", order = 10 },
                        { key = "sequence", name = "Sequence", order = 11 },
                    }

                    local anchorPoints = {
                        TOPLEFT = "TOPLEFT",
                        TOP = "TOP",
                        TOPRIGHT = "TOPRIGHT",
                        LEFT = "LEFT",
                        CENTER = "CENTER",
                        RIGHT = "RIGHT",
                        BOTTOMLEFT = "BOTTOMLEFT",
                        BOTTOM = "BOTTOM",
                        BOTTOMRIGHT = "BOTTOMRIGHT",
                    }

                    for _, group in ipairs(allGroups) do
                        local groupKey = group.key
                        args[groupKey] = {
                            type = "group",
                            name = group.name,
                            desc = format("Configure keybind display settings specifically for the %s group. These settings override the global defaults.", group.name),
                            order = group.order,
                            args = {
                                groupDesc = OptionsFactory:CreateDescription(
                                    format("|cffffd700%s Group Settings|r\n\nConfigure individual settings for the %s group. These settings override the global defaults set in the 'Global Defaults' tab.", group.name, group.name),
                                    nil,
                                    { order = 0, fontSize = "medium", width = "full" }
                                ),
                                anchor = OptionsFactory:CreateSelect(
                                    "Anchor Point",
                                    "Determines which corner or edge of the icon the keybind text will be anchored to. BOTTOMLEFT is the most common choice.",
                                    function()
                                        local keybindGroups = self.db.global.keybindGroups
                                        local groupSettings = keybindGroups and keybindGroups[groupKey]
                                        return (groupSettings and groupSettings.anchor) or "BOTTOMLEFT"
                                    end,
                                    function(_, val)
                                        if not self.db.global.keybindGroups then
                                            self.db.global.keybindGroups = {}
                                        end
                                        if not self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey] = {}
                                        end
                                        self.db.global.keybindGroups[groupKey].anchor = val
                                        self:UpdateAllKeybinds()
                                    end,
                                    {
                                        values = anchorPoints,
                                        order = 1,
                                    }
                                ),
                                offsetX = OptionsFactory:CreateRange(
                                    "Horizontal Offset",
                                    "Adjusts the horizontal position of the keybind text relative to its anchor point.\n\n• Negative values move text left\n• Positive values move text right\n• Recommended range: -5 to 5",
                                    function()
                                        local keybindGroups = self.db.global.keybindGroups
                                        local groupSettings = keybindGroups and keybindGroups[groupKey]
                                        return (groupSettings and groupSettings.offsetX) or 2
                                    end,
                                    function(_, val)
                                        if not self.db.global.keybindGroups then
                                            self.db.global.keybindGroups = {}
                                        end
                                        if not self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey] = {}
                                        end
                                        self.db.global.keybindGroups[groupKey].offsetX = val
                                        self:UpdateAllKeybinds()
                                    end,
                                    {
                                        min = -50,
                                        max = 50,
                                        step = 1,
                                        order = 2,
                                    }
                                ),
                                offsetY = OptionsFactory:CreateRange(
                                    "Vertical Offset",
                                    "Adjusts the vertical position of the keybind text relative to its anchor point.\n\n• Negative values move text down\n• Positive values move text up\n• Recommended range: -5 to 5",
                                    function()
                                        local keybindGroups = self.db.global.keybindGroups
                                        local groupSettings = keybindGroups and keybindGroups[groupKey]
                                        return (groupSettings and groupSettings.offsetY) or 2
                                    end,
                                    function(_, val)
                                        if not self.db.global.keybindGroups then
                                            self.db.global.keybindGroups = {}
                                        end
                                        if not self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey] = {}
                                        end
                                        self.db.global.keybindGroups[groupKey].offsetY = val
                                        self:UpdateAllKeybinds()
                                    end,
                                    {
                                        min = -50,
                                        max = 50,
                                        step = 1,
                                        order = 3,
                                    }
                                ),
                                fontSize = OptionsFactory:CreateRange(
                                    "Font Size",
                                    format("Font size for keybind text on %s group icons. Recommended: 12-18 for most groups, 18-24 for primary/main groups.", group.name),
                                    function()
                                        local keybindGroups = self.db.global.keybindGroups
                                        local groupSettings = keybindGroups and keybindGroups[groupKey]
                                        return (groupSettings and groupSettings.fontSize) or (groupKey == "primary" or groupKey == "main") and 18 or 12
                                    end,
                                    function(_, val)
                                        if not self.db.global.keybindGroups then
                                            self.db.global.keybindGroups = {}
                                        end
                                        if not self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey] = {}
                                        end
                                        self.db.global.keybindGroups[groupKey].fontSize = val
                                        self:UpdateAllKeybinds()
                                    end,
                                    {
                                        min = 8,
                                        max = 32,
                                        step = 1,
                                        order = 4,
                                    }
                                ),
                                font = OptionsFactory:CreateSelect(
                                    "Font",
                                    format("Font family for keybind text on %s group icons. Choose a font that's easy to read at a glance.", group.name),
                                    function()
                                        local keybindGroups = self.db.global.keybindGroups
                                        local groupSettings = keybindGroups and keybindGroups[groupKey]
                                        return (groupSettings and groupSettings.font) or "Friz Quadrata TT"
                                    end,
                                    function(_, val)
                                        if not self.db.global.keybindGroups then
                                            self.db.global.keybindGroups = {}
                                        end
                                        if not self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey] = {}
                                        end
                                        self.db.global.keybindGroups[groupKey].font = val
                                        self:UpdateAllKeybinds()
                                    end,
                                    {
                                        order = 5,
                                        values = function()
                                            return LSM and LSM:HashTable("font") or {}
                                        end,
                                        dialogControl = "LSM30_Font"
                                    }
                                ),
                                resetGroup = OptionsFactory:CreateExecute(
                                    "Reset to Defaults",
                                    format("Reset all %s group settings to their default values (will use Global Defaults)", group.name),
                                    function()
                                        if not self.db.global.keybindGroups then
                                            self.db.global.keybindGroups = {}
                                        end
                                        if self.db.global.keybindGroups[groupKey] then
                                            self.db.global.keybindGroups[groupKey].font = nil
                                            self.db.global.keybindGroups[groupKey].fontSize = nil
                                            self.db.global.keybindGroups[groupKey].anchor = nil
                                            self.db.global.keybindGroups[groupKey].offsetX = nil
                                            self.db.global.keybindGroups[groupKey].offsetY = nil
                                        end
                                        self:UpdateAllKeybinds()
                                        self:Info(format("%s group settings reset to defaults", group.name))
                                    end,
                                    { order = 6 }
                                ),
                            }
                        }
                    end

                    return args
                end)(),
            },
        }
    }
end

-- ============================ MODULE LIFECYCLE ============================

--- Initialize module
function KeybindManager:ModuleInitialize()
    -- Initialize managedFrames tracking
    self.managedFrames = {}

    -- NOTE: Do not scan here - game/action bars may not be ready. Scan runs in ModuleEnable
    -- and on PLAYER_ENTERING_WORLD; deferred scan catches late-loading action bar addons.

    -- Register preservation groups with ResetManager
    local ResetManager = NAG:GetModule("ResetManager")
    if ResetManager then
        -- Register keybindManager preservation group
        ResetManager:RegisterPreservationGroup("keybindManager", {
            name = "Keybind Manager Settings",
            description = "Preserve keybind manager specific settings and configurations",
            settings = {
                char = { "keybindOverrides" },
                global = { "keybindGroups" }
            },
            alwaysPreserve = false
        }, "KeybindManager")

        -- Register uiLayout preservation group
        ResetManager:RegisterPreservationGroup("uiLayout", {
            name = "UI Layout Settings",
            description = "Preserve UI layout and display settings across multiple modules",
            settings = {
                global = { "enableKeybinds", "keybindTextColor" }
            },
            alwaysPreserve = false
        }, "KeybindManager")
    end
end

--- Migrate keybindOverrides from PascalCase to camelCase keys
--- Converts: Item -> item, Macro -> macro, Spell -> spell, etc.
function KeybindManager:MigrateKeybindOverridesCase()
    local keybindOverrides = self.db.char.keybindOverrides
    if not keybindOverrides then
        return
    end

    -- Mapping from old PascalCase to new camelCase
    local keyMapping = {
        Item = "item",
        Macro = "macro",
        Spell = "spell",
        Companion = "companion",
        Mount = "mount",
        Equipmentset = "equipmentset",
        Text = "text",
        Texture = "texture",
        Flyout = "flyout"
    }

    local migrated = false

    -- Check each old key and migrate if it exists
    for oldKey, newKey in pairs(keyMapping) do
        if keybindOverrides[oldKey] and next(keybindOverrides[oldKey]) then
            -- Old key exists with data, migrate it
            if not keybindOverrides[newKey] then
                keybindOverrides[newKey] = {}
            end

            -- Copy all entries from old key to new key
            for identifier, keybind in pairs(keybindOverrides[oldKey]) do
                -- Only copy if not already in new key (preserve existing data)
                if not keybindOverrides[newKey][identifier] then
                    keybindOverrides[newKey][identifier] = keybind
                end
            end

            -- Remove old key after migration
            keybindOverrides[oldKey] = nil
            migrated = true

            self:Info(format("Migrated keybind overrides from '%s' to '%s'", oldKey, newKey))
        elseif keybindOverrides[oldKey] then
            -- Old key exists but is empty, just remove it
            keybindOverrides[oldKey] = nil
            migrated = true
        end
    end

    if migrated then
        -- Save the migrated data
        self:SetSetting("char", "keybindOverrides", keybindOverrides)
        self:Info("Keybind overrides migration completed")
    end
end

--- Enable module
function KeybindManager:ModuleEnable()
    -- Respect enableKeybinds setting: start disabled when user had it off (e.g. reload, login)
    if not self.db.global.enableKeybinds then
        NAG:DisableModule("KeybindManager")
        return
    end

    -- Re-register message handlers only when re-enabling (they were unregistered in ModuleDisable)
    if not self.__registeredMessages or not next(self.__registeredMessages) then
        self:RegisterMessageHandlers()
    end

    -- Run migration for keybind overrides
    self:MigrateKeybindOverridesCase()

    -- Trigger initial scan after module is enabled (game data is available)
    self:UPDATE_BINDINGS("ModuleEnable")

    -- Deferred scan: action bar addons (Bartender, Dominos, ElvUI) may populate bars after login.
    -- Run again after 1.5s to catch late population; fixes keybinds not showing until hard-assigned.
    C_Timer.After(1.5, function()
        if self:IsEnabled() then
            self:UPDATE_BINDINGS("ModuleEnable_Deferred")
        end
    end)

    -- Module is ready
end

--- Disable module
--- Fully removes keybind functionality: strips overlays from all managed frames,
--- clears in-memory state (Actions, ActionSlotsBy, PetBarKeybindsByTexture),
--- unregisters message handlers (NAG_KEYBIND_SETTING_CHANGED), and releases references.
--- Use for performance testing or to fully disable keybinds.
function KeybindManager:ModuleDisable()
    -- Stop listening for addon messages (handler no-ops when disabled, but unregister for full teardown)
    self:UnregisterMessageHandlers()

    -- Remove keybind overlays from all managed frames (destroy wrapper frame and text)
    if self.managedFrames then
        for frame in pairs(self.managedFrames) do
            if frame then
                if frame.keybindFrame then
                    frame.keybindFrame:Hide()
                    frame.keybindFrame:SetParent(nil)
                    frame.keybindFrame = nil
                end
                frame.keybindText = nil
                frame.keyBindManager = nil
                frame._keybindGroupKey = nil
                frame.UpdateKeybindText = nil
            end
        end
        self.managedFrames = {}
    end

    -- Clear file-local state to free memory and avoid stale data when re-enabled
    wipe(Actions)
    wipe(ActionSlotsBy.Spell)
    wipe(ActionSlotsBy.Item)
    wipe(ActionSlotsBy.Macro)
    wipe(ActionSlotsBy.Text)
    wipe(ActionSlotsBy.Texture)
    wipe(PetBarKeybindsByTexture)
    visibleFrameSlotsCache = nil
end

-- ============================ DEBUG FRAME ============================

--- Get debug sections for debug frame
--- @return table Array of debug sections
function KeybindManager:GetDebugSections()
    local function stanceBarDebugSection()
        local lines = {}
        local _, playerClass = UnitClass("player")
        local bonusBarOffset = GetBonusBarOffset()
        local numPages = NUM_ACTIONBAR_PAGES or 6
        local numButtons = NUM_ACTIONBAR_BUTTONS or 12

        tinsert(lines, "Stance Bar Debug:")
        tinsert(lines, format("Player Class: %s", playerClass or "Unknown"))
        tinsert(lines, format("Bonus Bar Offset: %d", bonusBarOffset))
        tinsert(lines, format("In Stance: %s", (bonusBarOffset > 0 and (playerClass == "ROGUE" or playerClass == "DRUID" or playerClass == "WARRIOR")) and "Yes" or "No"))
        tinsert(lines, "")

        if bonusBarOffset > 0 and (playerClass == "ROGUE" or playerClass == "DRUID" or playerClass == "WARRIOR") then
            local low = (1 + (numPages + bonusBarOffset - 1) * numButtons)
            local high = ((numPages + bonusBarOffset) * numButtons)
            tinsert(lines, format("Bar 1 (Slots 1-12): HIDDEN (filtered out)"))
            tinsert(lines, format("Bonus Bar Range: Slots %d-%d (DISPLAYED)", low, high))
            tinsert(lines, format("Other Bars: VISIBLE"))
            tinsert(lines, "")

            -- Count slots in different categories
            local hiddenBar1Count = 0
            local bonusBarCount = 0
            local otherBarCount = 0
            local hiddenBar1Slots = {}
            local bonusBarSlots = {}
            local otherBarSlots = {}

            for slot = 1, MAX_ACTION_SLOTS do
                local action = Actions[slot]
                if action and action.HotKey then
                    if slot >= 1 and slot <= 12 then
                        hiddenBar1Count = hiddenBar1Count + 1
                        if action.Type == "spell" then
                            local spellInfo = WoWAPI.GetSpellInfo(action.ID)
                            local spellName = spellInfo and spellInfo.name or ("Spell ID: " .. action.ID)
                            tinsert(hiddenBar1Slots, format("  Slot %d: %s (%d) - Keybind: %s", slot, spellName, action.ID, action.HotKey))
                        end
                    elseif slot >= low and slot <= high then
                        bonusBarCount = bonusBarCount + 1
                        if action.Type == "spell" then
                            local spellInfo = WoWAPI.GetSpellInfo(action.ID)
                            local spellName = spellInfo and spellInfo.name or ("Spell ID: " .. action.ID)
                            tinsert(bonusBarSlots, format("  Slot %d: %s (%d) - Keybind: %s", slot, spellName, action.ID, action.HotKey))
                        end
                    else
                        otherBarCount = otherBarCount + 1
                    end
                end
            end

            tinsert(lines, format("Tracked Slots:"))
            tinsert(lines, format("  Bar 1 (Hidden): %d slots (SHOULD BE 0)", hiddenBar1Count))
            tinsert(lines, format("  Bonus Bar (Displayed): %d slots", bonusBarCount))
            tinsert(lines, format("  Other Bars: %d slots", otherBarCount))
            tinsert(lines, "")

            if hiddenBar1Count > 0 then
                tinsert(lines, "|cffff0000WARNING: Bar 1 slots are being tracked (should be filtered):|r")
                tinsert(lines, "")
                for i = 1, min(#hiddenBar1Slots, 10) do
                    tinsert(lines, hiddenBar1Slots[i])
                end
                if #hiddenBar1Slots > 10 then
                    tinsert(lines, format("  ... and %d more hidden slots", #hiddenBar1Slots - 10))
                end
                tinsert(lines, "")
            end

            if bonusBarCount > 0 then
                tinsert(lines, "Bonus Bar Slots (Displayed):")
                for i = 1, min(#bonusBarSlots, 10) do
                    tinsert(lines, bonusBarSlots[i])
                end
                if #bonusBarSlots > 10 then
                    tinsert(lines, format("  ... and %d more bonus bar slots", #bonusBarSlots - 10))
                end
            end
        else
            tinsert(lines, "No stance filtering (not in stance or not Druid/Rogue)")
            tinsert(lines, "All action bars are visible")
        end

        return lines
    end

    local function spellKeybindsSection()
        local lines = {}
        local spellCount = 0

        -- Collect all spell keybind mappings
        local spellKeybinds = {}
        for spellID, actionSlots in pairs(ActionSlotsBy.Spell) do
            if actionSlots and #actionSlots > 0 then
                local spellInfo = WoWAPI.GetSpellInfo(spellID)
                local spellName = spellInfo and spellInfo.name or ("Spell ID: " .. spellID)

                -- Get all slots where this spell is found
                local allSlots = {}
                for _, slot in ipairs(actionSlots) do
                    local action = Actions[slot]
                    if action and action.HotKey then
                        tinsert(allSlots, {
                            slot = slot,
                            keybind = action.HotKey
                        })
                    end
                end

                if #allSlots > 0 then
                    -- Use the first slot for primary display, but show all slots if multiple
                    local primarySlot = allSlots[1]
                    local slotInfo = format("Slot: %d", primarySlot.slot)
                    if #allSlots > 1 then
                        slotInfo = slotInfo .. format(" (also on: %s)",
                            table.concat(
                                (function()
                                    local slots = {}
                                    for i = 2, #allSlots do
                                        tinsert(slots, tostring(allSlots[i].slot))
                                    end
                                    return slots
                                end)(),
                                ", "
                            )
                        )
                    end

                    tinsert(spellKeybinds, {
                        spellID = spellID,
                        spellName = spellName,
                        keybind = primarySlot.keybind,
                        slot = primarySlot.slot,
                        allSlots = allSlots,
                        slotInfo = slotInfo
                    })
                    spellCount = spellCount + 1
                end
            end
        end

        -- Sort by spell name
        sort(spellKeybinds, function(a, b)
            return a.spellName < b.spellName
        end)

        tinsert(lines, format("Total Spell Keybinds: %d", spellCount))
        tinsert(lines, "")

        -- Display up to 100 spells (to avoid overwhelming the UI)
        local displayCount = min(#spellKeybinds, 100)
        for i = 1, displayCount do
            local entry = spellKeybinds[i]
            tinsert(lines, format("|cffffd700%s|r (%d): |cff00ff00%s|r (%s)",
                entry.spellName, entry.spellID, entry.keybind, entry.slotInfo))
        end

        if #spellKeybinds > 100 then
            tinsert(lines, "")
            tinsert(lines, format("... and %d more spells (showing first 100)", #spellKeybinds - 100))
        end

        return lines
    end

    local function actionSlotsSection()
        local lines = {}
        local slotCount = 0

        -- Collect all action slots with keybinds
        local slotsWithKeybinds = {}
        for slot = 1, MAX_ACTION_SLOTS do
            local action = Actions[slot]
            if action and action.HotKey then
                slotCount = slotCount + 1
                local displayText = format("Slot %d: %s %s", slot, action.Type or "?", action.ID or "?")
                if action.Type == "spell" then
                    local spellInfo = WoWAPI.GetSpellInfo(action.ID)
                    local spellName = spellInfo and spellInfo.name or ("Spell ID: " .. action.ID)
                    displayText = format("Slot %d: Spell |cffffd700%s|r (%d)", slot, spellName, action.ID)
                elseif action.Type == "item" then
                    displayText = format("Slot %d: Item ID: %d", slot, action.ID)
                elseif action.Type == "macro" then
                    displayText = format("Slot %d: Macro ID: %d", slot, action.ID)
                end
                tinsert(slotsWithKeybinds, {
                    slot = slot,
                    displayText = displayText,
                    keybind = action.HotKey
                })
            end
        end

        -- Sort by slot number
        sort(slotsWithKeybinds, function(a, b)
            return a.slot < b.slot
        end)

        tinsert(lines, format("Action Slots with Keybinds: %d", slotCount))
        tinsert(lines, "")

        -- Display up to 100 slots (to avoid overwhelming the UI)
        local displayCount = min(#slotsWithKeybinds, 100)
        for i = 1, displayCount do
            local entry = slotsWithKeybinds[i]
            tinsert(lines, format("%s | Keybind: |cff00ff00%s|r", entry.displayText, entry.keybind))
        end

        if #slotsWithKeybinds > 100 then
            tinsert(lines, "")
            tinsert(lines, format("... and %d more slots (showing first 100)", #slotsWithKeybinds - 100))
        end

        return lines
    end

    local function statsSection()
        local lines = {}
        local totalActions = 0
        local spellCount = 0
        local itemCount = 0
        local macroCount = 0

        for _ in pairs(Actions) do
            totalActions = totalActions + 1
        end

        for _ in pairs(ActionSlotsBy.Spell) do
            spellCount = spellCount + 1
        end

        for _ in pairs(ActionSlotsBy.Item) do
            itemCount = itemCount + 1
        end

        for _ in pairs(ActionSlotsBy.Macro) do
            macroCount = macroCount + 1
        end

        -- Detect active UI
        local activeUI = "Blizzard"
        if _G.Bartender4 then
            activeUI = "Bartender4"
        elseif _G.Dominos then
            activeUI = "Dominos"
        elseif _G.ElvUI and _G.ElvUI[1].ActionBars then
            activeUI = "ElvUI"
        end

        tinsert(lines, "Statistics:")
        tinsert(lines, format("  Active UI: |cffffd700%s|r", activeUI))
        tinsert(lines, format("  Total Actions: %d", totalActions))
        tinsert(lines, format("  Spells: %d", spellCount))
        tinsert(lines, format("  Items: %d", itemCount))
        tinsert(lines, format("  Macros: %d", macroCount))
        tinsert(lines, "")
        tinsert(lines, format("  Enable Keybinds: %s", self.db.global.enableKeybinds and "|cff00ff00ON|r" or "|cffff0000OFF|r"))

        return lines
    end

    return {
        { header = "Statistics", dataFn = statsSection },
        { header = "Stance Bar Debug", dataFn = stanceBarDebugSection },
        { header = "Spell Keybinds", dataFn = spellKeybindsSection },
        { header = "Action Slots", dataFn = actionSlotsSection },
    }
end

--- Get debug controls (buttons) for debug frame
--- @return table Array of control definitions
function KeybindManager:GetDebugControls()
    return {
        {
            type = "button",
            text = "Rescan All",
            width = 120,
            onClick = function()
                -- Rescan all action slots
                self:RescanAllActions()
                self:Info("Rescanned all action slots")

                -- Refresh debug frame
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "button",
            text = "Refresh",
            width = 80,
            onClick = function()
                -- Refresh debug frame display
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        }
    }
end

--- Show debug frame
function KeybindManager:ShowDebugFrame()
    if not ns.DebugFrameUtil then
        self:Error("ShowDebugFrame failed: DebugFrameUtil not available")
        return
    end

    if not ns.AceGUI then
        self:Error("ShowDebugFrame failed: AceGUI not available")
        return
    end

    local success, err = pcall(function()
        ns.DebugFrameUtil:ShowDebugFrame(self, {
            title = "KeybindManager Debug",
            width = 800,
            height = 600,
            sections = function() return self:GetDebugSections() end,
            customControls = self:GetDebugControls(),
            refreshInterval = 2.0,
            autoRefresh = false,  -- Manual refresh by default
            showTimerControls = true,
        })
    end)

    if not success then
        self:Error("ShowDebugFrame failed: " .. tostring(err))
    end
end
