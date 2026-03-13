--- @module "SpellFlash"
--- Spell flashing module for NAG addon
---
--- Provides visual feedback by flashing action buttons for recommended spells.
--- Integrates with NAG's rotation system to show which spells to cast next.
---
--- FEATURES:
--- - Flashes action buttons for recommended spells
--- - Primary spell (NAG.nextSpell) with golden glow
--- - Secondary spells (NAG.secondarySpells) with blue glow
--- - Supports multiple UI addons (ElvUI, Bartender4, Dominos, etc.)
--- - Smart suppression to prevent spam after casting
--- - Configurable flash settings and timing
--- - Proper integration with NAG's messaging system
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
local GetTime = _G.GetTime
local UnitAffectingCombat = _G.UnitAffectingCombat
local CreateFrame = _G.CreateFrame
local GetMacroInfo = _G.GetMacroInfo
local L = ns.AceLocale:GetLocale("NAG")
local GetActionInfo = _G.GetActionInfo
-- Enhanced error handling
local pcall = ns.pcall

-- ============================ CONTENT ============================

--- @class SpellFlash : CoreModule
--- @field defaults table Module-specific database defaults
--- @field state table Module state management
--- @field buttonCache table Cached button information for performance
--- @field recentlyCast table Recently cast spells for suppression
--- @field updateTimer table Timer for update loop
--- @field spellCastFrame table Event frame for spell cast tracking
local SpellFlash = NAG:CreateModule("SpellFlash", {
    global = {
        debugLevel = ns.DEBUG_LEVELS.ERROR
    },
    char = {
        enabled = false,
        -- Flash settings
        flashOutOfCombat = true,
        normalSuppressionTime = 0.5,
        dotSuppressionTime = 2.0,
        updateFrequency = 0.1, -- 10 FPS instead of 60 FPS

        -- UI settings
        flashIntensity = 1.0,
        flashDuration = 0.3,
        glowColor = {r = 1.0, g = 0.8, b = 0.0, a = 1.0}, -- Golden glow by default

        -- Advanced settings
        enableSmartSuppression = true,
        enableDoTDetection = true,
        enableFormDetection = true,

        -- Glow animation settings
        disableGlowAnimations = false, -- Set to true to disable the scaling animations
        useStaticGlow = false, -- Use a static glow instead of animated glow

        -- Secondary spell glow color
        secondarySpellGlowColor = {r = 0.2, g = 0.6, b = 1.0, a = 1.0} -- Blue for secondary spells
    }
}, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = "features",
    debugCategories = {ns.DEBUG_CATEGORIES.FEATURES},

    -- Automatic event registration
    eventHandlers = {
        ["UNIT_SPELLCAST_SUCCEEDED"] = "OnSpellCastSucceeded",
        ["UNIT_SPELLCAST_START"] = "OnSpellCastStart",
        ["PLAYER_REGEN_DISABLED"] = "OnCombatStart",
        ["PLAYER_REGEN_ENABLED"] = "OnCombatEnd",
        ["ACTIONBAR_SLOT_CHANGED"] = "OnActionBarSlotChanged"
    },

    -- Automatic message registration
    messageHandlers = {
        ["NAG_ROTATION_CHANGED"] = "OnRotationUpdated",  -- Unified rotation change message
        ["NAG_NEXT_SPELL_UPDATED"] = "OnNextSpellUpdated"
    },

    -- Automatic slash command registration
    slashCommands = {
        ["spellflash"] = {
            handler = "HandleSpellFlashCommand",
            help = "SpellFlash commands - use 'help' for options",
            root = "nagdebug",
            category = "Debug"
        }
    }
})

-- ============================ STATE MANAGEMENT ============================

--- Initialize module state
function SpellFlash:ModuleInitialize()
    -- Initialize state tables
    self.state = {
        isFlashing = false,
        lastRecommendedSpell = nil,
        lastCheckTime = 0,
        currentFlashingButtons = {},
        buttonSpellCache = {},
        buttonCacheTime = {},
        recentlyCast = {},
        reusableSpellsToFlash = {},
    }

    -- Cache for ActionBarButtonSpellActivationAlert template availability (nil = unknown, true = use template, false = fallback only)
    self._spellActivationTemplateAvailable = nil

    -- Create spell cast tracking frame
    self.spellCastFrame = CreateFrame("Frame")
    self.spellCastFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    self.spellCastFrame:RegisterEvent("UNIT_SPELLCAST_START")
    self.spellCastFrame:SetScript("OnEvent", function(_, event, unit, _, spellID)
        if unit == "player" and spellID then
            if event == "UNIT_SPELLCAST_START" then
                self:OnSpellCastStart(spellID)
            elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
                self:OnSpellCastSucceeded(spellID)
            end
        end
    end)

    self:Debug("SpellFlash module initialized")
end

--- Enable the module
function SpellFlash:ModuleEnable()
    self:Debug("Enabling SpellFlash")

    -- Start update timer
    self:StartUpdateTimer()

    -- Clear any existing glows
    self:ClearAllGlows()
end

--- Disable the module
function SpellFlash:ModuleDisable()
    self:Debug("Disabling SpellFlash")

    -- Stop update timer
    self:StopUpdateTimer()

    -- Clear all glows
    self:ClearAllGlows()

    -- Reset state
    self.state.isFlashing = false
    self.state.lastRecommendedSpell = nil
end

-- ============================ UPDATE SYSTEM ============================

--- Start the update timer
function SpellFlash:StartUpdateTimer()
    if self.updateTimer then
        self.updateTimer:Cancel()
    end

    local frequency = self:GetSetting("char", "updateFrequency", 0.1)
    if frequency < 0.1 then
        frequency = 0.1 -- Guardrail: prevent overly aggressive ticker rates.
    end
    self.updateTimer = C_Timer.NewTicker(frequency, function()
        self:UpdateFlashing()
    end)

    self:Debug("Started update timer with frequency: " .. frequency .. "s")
end

--- Stop the update timer
function SpellFlash:StopUpdateTimer()
    if self.updateTimer then
        self.updateTimer:Cancel()
        self.updateTimer = nil
    end
end

--- Main update function for spell flashing
function SpellFlash:UpdateFlashing()
    if not self.state then
        return
    end

    if not self:ShouldFlash() then
        if self.state.isFlashing then
            self:ClearAllGlows()
            self.state.isFlashing = false
        end
        return
    end

    local recommendedSpells = self:GetRecommendedSpells()
    if not recommendedSpells or #recommendedSpells == 0 then
        if self.state.isFlashing then
            self:ClearAllGlows()
            self.state.isFlashing = false
        end
        return
    end

    local primarySpell = recommendedSpells[1]

    -- Check if we need to update (spell changed or time elapsed)
    local currentTime = GetTime()
    local needsUpdate = false

    -- Ensure lastCheckTime is initialized
    if not self.state.lastCheckTime then
        self.state.lastCheckTime = 0
    end

    if primarySpell ~= self.state.lastRecommendedSpell then
        needsUpdate = true
        self.state.lastRecommendedSpell = primarySpell
        self:Debug("New recommended spell: " .. (GetSpellInfo(primarySpell) or "Unknown"))
    elseif currentTime - self.state.lastCheckTime > 0.1 then -- 10 FPS check
        needsUpdate = true
        self.state.lastCheckTime = currentTime
    end

    if not needsUpdate then
        return
    end

    -- Find spells to flash (all non-suppressed spells)
    local spellsToFlash = self.state.reusableSpellsToFlash or {}
    wipe(spellsToFlash)
    self.state.reusableSpellsToFlash = spellsToFlash
    for _, spellID in ipairs(recommendedSpells) do
        if not self:IsSpellSuppressed(spellID) then
            spellsToFlash[#spellsToFlash + 1] = spellID
        end
    end

    -- Fallback to primary spell if all are suppressed
    if #spellsToFlash == 0 and #recommendedSpells > 0 then
        spellsToFlash[1] = recommendedSpells[1]
    end

    -- Update glows
    self:UpdateGlows(spellsToFlash)
end

-- ============================ SPELL DETECTION ============================

--- Get recommended spells from NAG
--- @return table Array of spell IDs (primary first, then secondary)
function SpellFlash:GetRecommendedSpells()
    if not NAG then
        return {}
    end

    local spells = {}

    -- Get primary spell from NAG.nextSpell
    if NAG.nextSpell then
        local spellID = self:ResolveSpellIdentifier(NAG.nextSpell)
        if spellID then
            table.insert(spells, spellID)
        end
    end

    -- Get secondary spells from NAG.secondarySpells (use itemId or spellId for display/cast)
    if NAG.secondarySpells and type(NAG.secondarySpells) == "table" then
        for _, entry in ipairs(NAG.secondarySpells) do
            local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
            if not norm then
                -- skip invalid or malformed entry
            else
                local id = norm.itemId or norm.spellId
                if id then
                    local spellID = self:ResolveSpellIdentifier(id)
                    if spellID then
                        table.insert(spells, spellID)
                    end
                end
            end
        end
    end

    return spells
end

--- Resolve spell identifier to spell ID
--- @param identifier string|number Spell name or ID
--- @return number|nil Spell ID
function SpellFlash:ResolveSpellIdentifier(identifier)
    if type(identifier) == "table" then
        local id = (NAG and NAG.GetActionResolveId and NAG:GetActionResolveId(identifier))
            or identifier.spellId or identifier.itemId
        return type(id) == "number" and id or nil
    elseif type(identifier) == "number" then
        return identifier
    elseif type(identifier) == "string" then
        local spellInfo = {GetSpellInfo(identifier)}
        if spellInfo[1] then
            return spellInfo[7] -- Spell ID is the 7th return value
        end
    end
    return nil
end

--- Check if a spell is a DoT (Damage over Time)
--- @param spellID number Spell ID to check
--- @return boolean True if spell is a DoT
function SpellFlash:IsDoTSpell(spellID)
    if not self:GetSetting("char", "enableDoTDetection", true) then
        return false
    end

    local spellName = GetSpellInfo(spellID)
    if not spellName then
        return false
    end

    local lowerName = string.lower(spellName)
    local dotKeywords = {
        "plague", "poison", "burn", "bleed", "dot", "over time",
        "corruption", "curse", "fever", "shock", "insect",
        "moonfire", "rake", "rip", "lacerate", "pain", "touch"
    }

    for _, keyword in ipairs(dotKeywords) do
        if string.find(lowerName, keyword) then
            return true
        end
    end

    return false
end

--- Check if a spell is suppressed (recently cast)
--- @param spellID number Spell ID to check
--- @return boolean True if spell is suppressed
function SpellFlash:IsSpellSuppressed(spellID)
    if not self:GetSetting("char", "enableSmartSuppression", true) then
        return false
    end

    if not self.state or not self.state.recentlyCast then
        return false
    end

    if not self.state.recentlyCast[spellID] then
        return false
    end

    local timeSince = GetTime() - self.state.recentlyCast[spellID]
    local suppressionTime = self:IsDoTSpell(spellID) and
        self:GetSetting("char", "dotSuppressionTime", 2.0) or
        self:GetSetting("char", "normalSuppressionTime", 0.5)

    return timeSince < suppressionTime
end

--- Check if we should flash spells
--- @return boolean True if we should flash
function SpellFlash:ShouldFlash()
    local inCombat = UnitAffectingCombat("player")
    local flashOutOfCombat = self:GetSetting("char", "flashOutOfCombat", true)

    return inCombat or flashOutOfCombat
end

-- ============================ BUTTON DETECTION ============================

--- Find buttons for a specific spell
--- @param spellID number Spell ID to find buttons for
--- @return table Array of buttons
function SpellFlash:FindButtonsForSpell(spellID)
    local foundButtons = {}
    local buttonCache = self.state.buttonSpellCache
    local buttonCacheTime = self.state.buttonCacheTime
    local currentTime = GetTime()
    local CACHE_DURATION = 2.0

    -- Check common UI addon patterns
    local buttonPatterns = {
        -- ElvUI
        "ElvUI_Bar%dButton%d",
        -- Bartender4
        "BT4Button%d",
        -- Dominos
        "DominosActionButton%d",
        -- Standard Blizzard
        "ActionButton%d",
        "MultiBarBottomLeftButton%d",
        "MultiBarBottomRightButton%d",
        "MultiBarRightButton%d",
        "MultiBarLeftButton%d"
    }

    for _, pattern in ipairs(buttonPatterns) do
        if pattern:find("ElvUI_Bar") then
            -- ElvUI has multiple bars
            for bar = 1, 15 do
                for i = 1, 12 do
                    local buttonName = string.format(pattern, bar, i)
                    local button = _G[buttonName]
                    if button and button:IsVisible() then
                        local buttonSpellID = self:GetActionButtonSpell(button, buttonCache, buttonCacheTime, currentTime, CACHE_DURATION)
                        if buttonSpellID == spellID then
                            table.insert(foundButtons, button)
                        end
                    end
                end
            end
        else
            -- Other patterns
            for i = 1, 12 do
                local buttonName = string.format(pattern, i)
                local button = _G[buttonName]
                if button and button:IsVisible() then
                    local buttonSpellID = self:GetActionButtonSpell(button, buttonCache, buttonCacheTime, currentTime, CACHE_DURATION)
                    if buttonSpellID == spellID then
                        table.insert(foundButtons, button)
                    end
                end
            end

            -- Special case for ActionButton pattern - also check action slots directly
            if pattern == "ActionButton%d" then
                for i = 1, 120 do -- Check all possible action slots
                    local buttonName = "ActionButton" .. i
                    local button = _G[buttonName]
                    if button and button:IsVisible() then
                        local buttonSpellID = self:GetActionButtonSpell(button, buttonCache, buttonCacheTime, currentTime, CACHE_DURATION)
                        if buttonSpellID == spellID then
                            table.insert(foundButtons, button)
                        end
                    end
                end
            end
        end
    end

    return foundButtons
end

--- Get spell or item ID from action button (so we can flash both spells and items, e.g. potions).
--- @param button table Action button frame
--- @param buttonCache table Button cache table
--- @param buttonCacheTime table Button cache time table
--- @param currentTime number Current time
--- @param cacheDuration number Cache duration
--- @return number|nil Spell ID or item ID
function SpellFlash:GetActionButtonSpell(button, buttonCache, buttonCacheTime, currentTime, cacheDuration)
    if not button or not button.action then
        return nil
    end

    local buttonName = button:GetName() or "Unknown"

    -- Check cache first
    if buttonCache[buttonName] and buttonCacheTime[buttonName] and
       (currentTime - buttonCacheTime[buttonName]) < cacheDuration then
        return buttonCache[buttonName]
    end

    local result = nil
    local actionType, id = GetActionInfo(button.action)

    if actionType == "spell" and type(id) == "number" then
        result = id
    elseif actionType == "item" and type(id) == "number" then
        result = id
    elseif actionType == "macro" and type(id) == "number" then
        local macroName, iconTexture, body = GetMacroInfo(id)
        if body then
            result = self:ExtractSpellFromMacro(body)
        end
    end

    -- Cache result
    buttonCache[buttonName] = result
    buttonCacheTime[buttonName] = currentTime

    return result
end

--- Extract spell ID from macro body
--- @param macroBody string Macro body text
--- @return number|nil Spell ID
function SpellFlash:ExtractSpellFromMacro(macroBody)
    if not macroBody then
        return nil
    end

    for line in string.gmatch(macroBody, "[^\r\n]+") do
        line = string.gsub(line, "^%s*", "")
        line = string.gsub(line, "%s*$", "")

        -- Skip comment lines and empty lines
        if not string.match(line, "^#") and not string.match(line, "^%s*$") and
           not string.match(line, "^/showtooltip") and not string.match(line, "^/run") then

            local patterns = {
                "^/cast%s+(.+)$",
                "^/castsequence%s+(.+)$",
                "^/use%s+(.+)$",
                "^/spell%s+(.+)$",
                "^/s%s+(.+)$"
            }

            for _, pattern in ipairs(patterns) do
                local spellPart = string.match(line, pattern)
                if spellPart then
                    -- Handle castsequence
                    if string.find(line, "castsequence") then
                        spellPart = string.match(spellPart, "^[^,;]+")
                        if spellPart then
                            spellPart = string.gsub(spellPart, "^[^%a]*", "")
                        end
                    end

                    -- Clean the spell name
                    spellPart = string.gsub(spellPart, "%[.-%]", "")
                    spellPart = string.gsub(spellPart, "%(.*%)", "")
                    spellPart = string.gsub(spellPart, "@%S+", "")
                    spellPart = string.gsub(spellPart, "reset=%S+", "")
                    spellPart = string.gsub(spellPart, "^%s*", "")
                    spellPart = string.gsub(spellPart, "%s*$", "")
                    spellPart = string.gsub(spellPart, "%s*[,;].*", "")

                    if spellPart and spellPart ~= "" then
                        local spellInfo = {GetSpellInfo(spellPart)}
                        if spellInfo[1] then
                            local spellID = spellInfo[7] -- Spell ID
                            if type(spellID) == "number" then
                                return spellID
                            end
                        end
                    end
                end
            end
        end
    end

    return nil
end

-- ============================ GLOW MANAGEMENT ============================

--- Create a fallback glow frame when ActionBarButtonSpellActivationAlert template is unavailable
--- @param glowName string Name for the glow frame
--- @param button table Parent button frame
--- @param frameWidth number Width of the glow frame
--- @param frameHeight number Height of the glow frame
--- @return table glow The created glow frame
function SpellFlash:CreateFallbackGlowFrame(glowName, button, frameWidth, frameHeight)
    local glow = CreateFrame("Frame", glowName, button)

    -- Set up basic frame properties
    glow:SetSize(frameWidth, frameHeight)
    glow:SetPoint("CENTER", button, "CENTER", 0, 0)
    glow:SetFrameLevel(button:GetFrameLevel() + 1)

    -- Create a simple outer glow texture as fallback
    local outerGlow = glow:CreateTexture(nil, "ARTWORK")
    outerGlow:SetTexture("Interface\\SpellActivationOverlay\\IconAlert")
    outerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
    outerGlow:SetSize(frameWidth * 1.2, frameHeight * 1.2)
    outerGlow:SetPoint("CENTER")
    outerGlow:SetAlpha(0.8)
    glow.outerGlow = outerGlow

    -- Create inner glow texture
    local innerGlow = glow:CreateTexture(nil, "ARTWORK")
    innerGlow:SetTexture("Interface\\SpellActivationOverlay\\IconAlert")
    innerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
    innerGlow:SetSize(frameWidth * 0.6, frameHeight * 0.6)
    innerGlow:SetPoint("CENTER")
    innerGlow:SetAlpha(0.6)
    glow.innerGlow = innerGlow

    -- Store reference for compatibility
    glow.spark = outerGlow -- Use outerGlow as spark fallback
    glow.innerGlowOver = innerGlow -- Use innerGlow as innerGlowOver fallback
    glow.outerGlowOver = outerGlow -- Use outerGlow as outerGlowOver fallback
    glow.ants = nil -- No ants texture in fallback

    self:Debug("Created fallback glow frame for " .. (button:GetName() or "Unknown") .. " (template unavailable)")

    return glow
end

--- Show custom glow on button with specified color
--- @param button table Action button frame
--- @param color table Color table with r, g, b, a values
function SpellFlash:ShowCustomGlow(button, color)
    if not button then
        return
    end

    -- Create or get existing glow frame
    local glowName = button:GetName() .. "SpellFlashGlow"
    local glow = _G[glowName]

    if not glow then
        -- Get button size first
        local frameWidth, frameHeight = button:GetSize()
        local buttonName = button:GetName() or "Unknown"

        -- Validate button size (prevent extremely large glows)
        if frameWidth <= 0 or frameHeight <= 0 or frameWidth >= 200 or frameHeight >= 200 then
            frameWidth = 40
            frameHeight = 40
            self:Warn("Invalid button size detected for " .. buttonName .. ", using fallback size")
        end

        self:Debug("Creating glow for button: " .. buttonName .. " - Size: " .. frameWidth .. "x" .. frameHeight)

        -- Use template only when known available; otherwise fallback to avoid CreateFrame errors for users
        -- where ActionBarButtonSpellActivationAlert is missing (e.g. Classic, TBC, some Retail setups).
        if self._spellActivationTemplateAvailable == false then
            glow = self:CreateFallbackGlowFrame(glowName, button, frameWidth, frameHeight)
        else
            local success, result = pcall(function()
                return CreateFrame("Frame", glowName, button, "ActionBarButtonSpellActivationAlert")
            end)

            if success and result then
                self._spellActivationTemplateAvailable = true
                glow = result
                glow:SetSize(frameWidth, frameHeight)
                glow:SetPoint("CENTER", button, "CENTER", 0, 0)
                glow:SetFrameLevel(button:GetFrameLevel() + 1)
                self:Debug("Created glow using ActionBarButtonSpellActivationAlert template")
            else
                self._spellActivationTemplateAvailable = false
                glow = self:CreateFallbackGlowFrame(glowName, button, frameWidth, frameHeight)
            end
        end
    end

    -- Set glow color on individual texture children
    if color then
        local r, g, b, a = color.r or 1, color.g or 0.8, color.b or 0, color.a or 1

        -- Apply color to all glow textures
        if glow.spark and glow.spark.SetVertexColor then
            glow.spark:SetVertexColor(r, g, b, a)
        end
        if glow.innerGlow and glow.innerGlow.SetVertexColor then
            glow.innerGlow:SetVertexColor(r, g, b, a)
        end
        if glow.innerGlowOver and glow.innerGlowOver.SetVertexColor then
            glow.innerGlowOver:SetVertexColor(r, g, b, a)
        end
        if glow.outerGlow and glow.outerGlow.SetVertexColor then
            glow.outerGlow:SetVertexColor(r, g, b, a)
        end
        if glow.outerGlowOver and glow.outerGlowOver.SetVertexColor then
            glow.outerGlowOver:SetVertexColor(r, g, b, a)
        end
        if glow.ants and glow.ants.SetVertexColor then
            glow.ants:SetVertexColor(r, g, b, a)
        end
    end

    -- Show the glow and trigger the proper animation
    glow:Show()

    -- Check if animations should be disabled
    local disableAnimations = self:GetSetting("char", "disableGlowAnimations", false)
    if glow.animIn and not disableAnimations then
        glow.animIn:Play()
    elseif disableAnimations then
        -- Skip the animation and just show the glow
        self:Debug("Glow animations disabled, showing static glow")
    end

    -- Store reference for cleanup
    if not button.spellFlashGlow then
        button.spellFlashGlow = glow
    end
end

--- Hide custom glow from button
--- @param button table Action button frame
function SpellFlash:HideCustomGlow(button)
    if not button then
        return
    end

    local glowName = button:GetName() .. "SpellFlashGlow"
    local glow = _G[glowName]

    if glow then
        -- Stop any running animations
        if glow.animIn and glow.animIn:IsPlaying() then
            glow.animIn:Stop()
        end
        if glow.animOut and glow.animOut:IsPlaying() then
            glow.animOut:Stop()
        end
        glow:Hide()
    end

    -- Also hide any stored glow reference
    if button.spellFlashGlow then
        if button.spellFlashGlow.animIn and button.spellFlashGlow.animIn:IsPlaying() then
            button.spellFlashGlow.animIn:Stop()
        end
        if button.spellFlashGlow.animOut and button.spellFlashGlow.animOut:IsPlaying() then
            button.spellFlashGlow.animOut:Stop()
        end
        button.spellFlashGlow:Hide()
    end
end

--- Update glows for spells
--- @param spellsToFlash table Array of spell IDs to flash
function SpellFlash:UpdateGlows(spellsToFlash)
    if not self.state or not self.state.currentFlashingButtons then
        return
    end

    local currentFlashingSpells = {}
    for _, button in ipairs(self.state.currentFlashingButtons) do
        if button and button.action then
            local spellID = self:GetActionButtonSpell(button, self.state.buttonSpellCache, self.state.buttonCacheTime, GetTime(), 2.0)
            if spellID then
                currentFlashingSpells[spellID] = true
            end
        end
    end

    local needsUpdate = false

    -- Check if we need to add new glows
    for _, spellID in ipairs(spellsToFlash) do
        if not currentFlashingSpells[spellID] then
            needsUpdate = true
            break
        end
    end

    -- Check if we need to remove glows
    if not needsUpdate then
        for spellID, _ in pairs(currentFlashingSpells) do
            local found = false
            for _, checkSpellID in ipairs(spellsToFlash) do
                if spellID == checkSpellID then
                    found = true
                    break
                end
            end
            if not found then
                needsUpdate = true
                break
            end
        end
    end

    if needsUpdate then
        self:ClearAllGlows()

        local flashedCount = 0
        local primaryGlowColor = self:GetSetting("char", "glowColor", {r = 1.0, g = 0.8, b = 0.0, a = 1.0})
        local secondaryGlowColor = self:GetSetting("char", "secondarySpellGlowColor", {r = 0.2, g = 0.6, b = 1.0, a = 1.0})

        for i, spellID in ipairs(spellsToFlash) do
            local buttons = self:FindButtonsForSpell(spellID)
            local spellName = GetSpellInfo(spellID) or "Unknown"
            local spellType = (i == 1) and "Primary" or "Secondary"
            self:Debug("Processing " .. spellType .. " spell: " .. spellName .. " (" .. spellID .. ") - " .. #buttons .. " buttons found")

            for _, button in ipairs(buttons) do
                -- Use primary color for first spell, secondary color for others
                local glowColor = (i == 1) and primaryGlowColor or secondaryGlowColor
                local buttonName = button:GetName() or "Unknown"
                self:Debug("  Applying glow to button: " .. buttonName .. " with color: " ..
                    string.format("r=%.2f g=%.2f b=%.2f a=%.2f", glowColor.r, glowColor.g, glowColor.b, glowColor.a))
                self:ShowCustomGlow(button, glowColor)
                table.insert(self.state.currentFlashingButtons, button)
                flashedCount = flashedCount + 1
            end
        end

        self.state.isFlashing = flashedCount > 0
        if flashedCount > 0 then
            self:Debug("Updated glows: " .. flashedCount .. " buttons now flashing")
        end
    end
end

--- Clear all glows
function SpellFlash:ClearAllGlows()
    if not self.state or not self.state.currentFlashingButtons then
        return
    end

    if #self.state.currentFlashingButtons == 0 then
        return
    end

    self:Debug("Clearing " .. #self.state.currentFlashingButtons .. " glows")

    for _, button in ipairs(self.state.currentFlashingButtons) do
        if button then
            self:HideCustomGlow(button)
        end
    end

    wipe(self.state.currentFlashingButtons)
    self.state.isFlashing = false
end

-- ============================ EVENT HANDLERS ============================

--- Handle spell cast start
--- @param spellID number Spell ID that started casting
function SpellFlash:OnSpellCastStart(spellID)
    if not self.state then
        return
    end
    self:Debug("Cast started: " .. (GetSpellInfo(spellID) or "Unknown"))
    self:ClearAllGlows()
end

--- Handle spell cast succeeded
--- @param spellID number Spell ID that was cast
function SpellFlash:OnSpellCastSucceeded(spellID)
    if not self.state or not self.state.recentlyCast then
        return
    end
    self.state.recentlyCast[spellID] = GetTime()
    self:Debug("Cast succeeded: " .. (GetSpellInfo(spellID) or "Unknown"))
    self:ClearAllGlows()
end

--- Handle combat start
function SpellFlash:OnCombatStart()
    if not self.state then
        return
    end
    self:Debug("Combat started")
end

--- Handle combat end
function SpellFlash:OnCombatEnd()
    if not self.state then
        return
    end
    self:Debug("Combat ended")
    if not self:GetSetting("char", "flashOutOfCombat", true) then
        self:ClearAllGlows()
    end
end

--- Handle action bar slot changed
function SpellFlash:OnActionBarSlotChanged()
    if not self.state or not self.state.buttonSpellCache or not self.state.buttonCacheTime then
        return
    end
    -- Clear button cache when action bars change
    wipe(self.state.buttonSpellCache)
    wipe(self.state.buttonCacheTime)
end

--- Handle rotation updated message (unified handler for NAG_ROTATION_CHANGED)
--- @param message string The message name
--- @param payload table|nil Optional payload with rotation details
function SpellFlash:OnRotationUpdated(message, payload)
    if not self.state then
        return
    end
    self:Debug("Rotation updated: %s (action: %s, dataChanged: %s, selectionChanged: %s)",
        message,
        payload and payload.action or "unknown",
        payload and tostring(payload.dataChanged) or "unknown",
        payload and tostring(payload.selectionChanged) or "unknown")
    -- Clear caches when rotation changes
    wipe(self.state.buttonSpellCache)
    wipe(self.state.buttonCacheTime)
    self.state.lastRecommendedSpell = nil
    self.state.lastCheckTime = 0
end

--- Handle next spell updated message
function SpellFlash:OnNextSpellUpdated()
    if not self.state then
        return
    end
    self:Debug("Next spell updated")
end

-- ============================ OPTIONS ============================

--- Get module options
--- @return table Options table
function SpellFlash:GetOptions()
    return {
        type = "group",
        name = L["Spell Flash"] or "Spell Flash",
        desc = L["Configure spell flashing settings"] or "Configure spell flashing settings",
        args = {
            header = {
                type = "header",
                name = L["SpellFlash - Visual Spell Recommendations"] or "SpellFlash - Visual Spell Recommendations",
                order = 0
            },
            thanks = {
                type = "description",
                name = "|cff88ff88Thanks to the NAG community for feedback and suggestions!|r\n" ..
                       "|cffaaaaaaSpecial thanks to Raw Card for initial code and testing.|r\n\n",
                order = 0.5
            },
            enabled = {
                type = "toggle",
                name = L["enabled"] or "Enabled",
                desc = L["enabledDesc"] or "Enable or disable this module/feature",
                get = function() return self:GetSetting("char", "enabled", true) end,
                set = function(_, value)
                    self:SetSetting("char", "enabled", value)
                    if value then
                        self:Enable()
                    else
                        self:Disable()
                    end
                end,
                order = 1
            },
            flashOutOfCombat = {
                type = "toggle",
                name = L["flashOutOfCombat"] or "Flash Out of Combat",
                desc = L["flashOutOfCombatDesc"] or "Flash spells when out of combat",
                get = function() return self:GetSetting("char", "flashOutOfCombat", true) end,
                set = function(_, value) self:SetSetting("char", "flashOutOfCombat", value) end,
                order = 2
            },
            updateFrequency = {
                type = "range",
                name = L["updateFrequency"] or "Update Frequency",
                desc = L["updateFrequencyDesc"] or "How often to check for spell updates (lower = more responsive)",
                min = 0.05,
                max = 0.5,
                step = 0.05,
                get = function() return self:GetSetting("char", "updateFrequency", 0.1) end,
                set = function(_, value)
                    self:SetSetting("char", "updateFrequency", value)
                    if self.updateTimer then
                        self:StartUpdateTimer()
                    end
                end,
                order = 3
            },
            glowColor = {
                type = "color",
                name = L["glowColor"] or "Primary Glow Color",
                desc = L["glowColorDesc"] or "Color of the primary spell flash glow",
                hasAlpha = true,
                get = function()
                    local color = self:GetSetting("char", "glowColor", {r = 1.0, g = 0.8, b = 0.0, a = 1.0})
                    return color.r, color.g, color.b, color.a
                end,
                set = function(_, r, g, b, a)
                    self:SetSetting("char", "glowColor", {r = r, g = g, b = b, a = a})
                end,
                order = 4
            },
            secondaryGlowColor = {
                type = "color",
                name = L["secondaryGlowColor"] or "Secondary Glow Color",
                desc = L["secondaryGlowColorDesc"] or "Color of the secondary spell flash glow",
                hasAlpha = true,
                get = function()
                    local color = self:GetSetting("char", "secondarySpellGlowColor", {r = 0.2, g = 0.6, b = 1.0, a = 1.0})
                    return color.r, color.g, color.b, color.a
                end,
                set = function(_, r, g, b, a)
                    self:SetSetting("char", "secondarySpellGlowColor", {r = r, g = g, b = b, a = a})
                end,
                order = 5
            },
            suppressionGroup = {
                type = "group",
                name = L["suppressionGroup"] or "Suppression Settings",
                desc = L["suppressionGroupDesc"] or "Configure spell suppression after casting",
                inline = true,
                order = 6,
                args = {
                    enableSmartSuppression = {
                        type = "toggle",
                        name = L["enableSmartSuppression"] or "Enable Smart Suppression",
                        desc = L["enableSmartSuppressionDesc"] or "Prevent spells from flashing immediately after being cast",
                        get = function() return self:GetSetting("char", "enableSmartSuppression", true) end,
                        set = function(_, value) self:SetSetting("char", "enableSmartSuppression", value) end,
                        order = 1
                    },
                    normalSuppressionTime = {
                        type = "range",
                        name = L["normalSuppressionTime"] or "Normal Spell Suppression",
                        desc = L["normalSuppressionTimeDesc"] or "How long to suppress normal spells after casting",
                        min = 0.1,
                        max = 3.0,
                        step = 0.1,
                        get = function() return self:GetSetting("char", "normalSuppressionTime", 0.5) end,
                        set = function(_, value) self:SetSetting("char", "normalSuppressionTime", value) end,
                        order = 2
                    },
                    dotSuppressionTime = {
                        type = "range",
                        name = L["dotSuppressionTime"] or "DoT Spell Suppression",
                        desc = L["dotSuppressionTimeDesc"] or "How long to suppress DoT spells after casting",
                        min = 0.5,
                        max = 10.0,
                        step = 0.5,
                        get = function() return self:GetSetting("char", "dotSuppressionTime", 2.0) end,
                        set = function(_, value) self:SetSetting("char", "dotSuppressionTime", value) end,
                        order = 3
                    }
                }
            },
            animationGroup = {
                type = "group",
                name = L["animationGroup"] or "Animation Settings",
                desc = L["animationGroupDesc"] or "Configure glow animation behavior",
                inline = true,
                order = 7,
                args = {
                    disableGlowAnimations = {
                        type = "toggle",
                        name = L["disableGlowAnimations"] or "Disable Glow Animations",
                        desc = L["disableGlowAnimationsDesc"] or "Disable the scaling animations that cause the 'big expansion' effect",
                        get = function() return self:GetSetting("char", "disableGlowAnimations", false) end,
                        set = function(_, value)
                            self:SetSetting("char", "disableGlowAnimations", value)
                            -- Clear existing glows to apply new setting
                            self:ClearAllGlows()
                        end,
                        order = 1
                    },
                    useStaticGlow = {
                        type = "toggle",
                        name = L["useStaticGlow"] or "Use Static Glow",
                        desc = L["useStaticGlowDesc"] or "Use a simple static glow instead of the complex animated glow (experimental)",
                        get = function() return self:GetSetting("char", "useStaticGlow", false) end,
                        set = function(_, value)
                            self:SetSetting("char", "useStaticGlow", value)
                            -- Clear existing glows to apply new setting
                            self:ClearAllGlows()
                        end,
                        order = 2
                    }
                }
            }
        }
    }
end

-- ============================ SLASH COMMANDS ============================

--- Handle spell flash slash commands
--- @param msg string Command message
function SpellFlash:HandleSpellFlashCommand(msg)
    local command = string.lower(msg or "")

    if command == "" or command == "help" then
        self:Print("SpellFlash Commands:")
        self:Print("  |cff88ff88/spellflash status|r - Show current status")
        self:Print("  |cff88ff88/spellflash test|r - Test spell detection")
        self:Print("  |cff88ff88/spellflash debug|r - Debug action bar buttons")
        self:Print("  |cff88ff88/spellflash force|r - Force update glows")
        self:Print("  |cff88ff88/spellflash clear|r - Clear all glows")
        self:Print("  |cff88ff88/spellflash toggle|r - Toggle spell flashing")
        self:Print("  |cff88ff88/spellflash sizes|r - Check button sizes and glow dimensions")
        self:Print("  |cff88ff88/spellflash noanim|r - Toggle glow animations (fixes big expansion)")

    elseif command == "status" then
        self:Print("=== SpellFlash Status ===")
        self:Print("Enabled: " .. (self:IsEnabled() and "|cff00ff00Yes|r" or "|cffff0000No|r"))
        self:Print("Flashing: " .. ((self.state and self.state.isFlashing) and "|cff00ff00Yes|r" or "|cffaaaaaaNo|r"))
        self:Print("Flash Out of Combat: " .. (self:GetSetting("char", "flashOutOfCombat", true) and "|cff00ff00Yes|r" or "|cffff0000No|r"))
        self:Print("Update Frequency: " .. self:GetSetting("char", "updateFrequency", 0.1) .. "s")

        local recommendedSpells = self:GetRecommendedSpells()
        if #recommendedSpells > 0 then
            self:Print("Recommended Spells:")
            for i, spellID in ipairs(recommendedSpells) do
                local spellName = GetSpellInfo(spellID) or "Unknown"
                local suppressed = self:IsSpellSuppressed(spellID)
                local status = suppressed and "|cffff8800Suppressed|r" or "|cff00ff00Ready|r"
                local spellType = (i == 1) and "|cffffaa00Primary|r" or "|cff00aaffSecondary|r"
                self:Print("  " .. i .. ". " .. spellName .. " (" .. spellID .. ") - " .. status .. " [" .. spellType .. "]")
            end
        else
            self:Print("No recommended spells found")
        end

    elseif command == "test" then
        self:Print("=== SpellFlash Test ===")
        local recommendedSpells = self:GetRecommendedSpells()
        if #recommendedSpells > 0 then
            for i, spellID in ipairs(recommendedSpells) do
                local spellName = GetSpellInfo(spellID) or "Unknown"
                local buttons = self:FindButtonsForSpell(spellID)
                local buttonStatus = #buttons > 0 and "|cff00ff00" .. #buttons .. " buttons|r" or "|cffff0000No buttons|r"
                local spellType = (i == 1) and "|cffffaa00Primary|r" or "|cff00aaffSecondary|r"
                self:Print("  " .. i .. ". " .. spellName .. " (" .. spellID .. ") - " .. buttonStatus .. " [" .. spellType .. "]")

                -- Debug: Show which buttons were found
                if #buttons > 0 then
                    for j, button in ipairs(buttons) do
                        local buttonName = button:GetName() or "Unknown"
                        self:Print("    Button " .. j .. ": " .. buttonName)
                    end
                end
            end
        else
            self:Print("No recommended spells found")
        end

    elseif command == "debug" then
        self:Print("=== SpellFlash Debug ===")
        self:Print("Checking main action bar buttons...")
        for i = 1, 12 do
            local buttonName = "ActionButton" .. i
            local button = _G[buttonName]
            if button then
                local actionType, id = GetActionInfo(button.action or 0)
                local spellName = ""
                if actionType == "spell" and id then
                    spellName = " (" .. (GetSpellInfo(id) or "Unknown") .. ")"
                end
                local visible = button:IsVisible() and "VISIBLE" or "HIDDEN"
                local width, height = button:GetSize()
                self:Print("  " .. buttonName .. ": " .. tostring(actionType) .. " " .. tostring(id) .. spellName .. " [" .. visible .. "] Size: " .. width .. "x" .. height)
            else
                self:Print("  " .. buttonName .. ": NOT FOUND")
            end
        end

        self:Print("Checking secondary spells...")
        if NAG.secondarySpells and type(NAG.secondarySpells) == "table" then
            for i, entry in ipairs(NAG.secondarySpells) do
                local norm = NAG.NormalizeSecondarySpellEntry and NAG:NormalizeSecondarySpellEntry(entry) or nil
                if not norm then
                    -- skip invalid or malformed entry
                else
                    local spellID = norm.spellId or norm.itemId
                    if spellID then
                        local spellName = GetSpellInfo(spellID) or "Unknown"
                        local buttons = self:FindButtonsForSpell(spellID)
                        local positionText = norm.position and (" [" .. norm.position .. "]") or ""
                        self:Print("  Secondary " .. i .. ": " .. spellName .. " (" .. spellID .. ")" .. positionText .. " - " .. #buttons .. " buttons found")
                    end
                end
            end
        else
            self:Print("  No secondary spells found")
        end

    elseif command == "clear" then
        self:ClearAllGlows()
        self:Print("All glows cleared")

    elseif command == "force" then
        self:Print("=== Force Update ===")
        self:UpdateFlashing()
        self:Print("Forced spell flash update")

    elseif command == "toggle" then
        if self:IsEnabled() then
            self:Disable()
            self:Print("SpellFlash disabled")
        else
            self:Enable()
            self:Print("SpellFlash enabled")
        end

    elseif command == "sizes" then
        self:Print("=== SpellFlash Button Sizes ===")
        self:Print("Checking button sizes and glow dimensions...")

        -- Check main action bar buttons
        for i = 1, 12 do
            local buttonName = "ActionButton" .. i
            local button = _G[buttonName]
            if button then
                local width, height = button:GetSize()
                local glowName = buttonName .. "SpellFlashGlow"
                local glow = _G[glowName]
                local glowSize = ""
                if glow then
                    local glowWidth, glowHeight = glow:GetSize()
                    glowSize = " | Glow: " .. glowWidth .. "x" .. glowHeight
                else
                    glowSize = " | No glow frame"
                end
                self:Print("  " .. buttonName .. ": " .. width .. "x" .. height .. glowSize)
            end
        end

        -- Check if there are any active glows
        if self.state and self.state.currentFlashingButtons then
            self:Print("Currently flashing buttons:")
            for i, button in ipairs(self.state.currentFlashingButtons) do
                if button then
                    local buttonName = button:GetName() or "Unknown"
                    local width, height = button:GetSize()
                    local glowName = buttonName .. "SpellFlashGlow"
                    local glow = _G[glowName]
                    if glow then
                        local glowWidth, glowHeight = glow:GetSize()
                        self:Print("  " .. buttonName .. ": Button " .. width .. "x" .. height .. " | Glow " .. glowWidth .. "x" .. glowHeight)
                    end
                end
            end
        end

    elseif command == "noanim" then
        local currentSetting = self:GetSetting("char", "disableGlowAnimations", false)
        local newSetting = not currentSetting
        self:SetSetting("char", "disableGlowAnimations", newSetting)

        if newSetting then
            self:Print("Glow animations |cffff0000disabled|r - This should fix the 'big expansion' issue")
        else
            self:Print("Glow animations |cff00ff00enabled|r - Back to normal animated glow")
        end

        -- Clear existing glows to apply new setting
        self:ClearAllGlows()

    else
        self:Print("Unknown command: " .. command)
        self:Print("Use |cffffff00/spellflash help|r to see available commands")
    end
end

-- ============================ EXPORT ============================

ns.SpellFlash = SpellFlash
