--- @module "SpellAutocomplete"
--- Reusable spell/item autocomplete widget for AceGUI
--- Provides dropdown with icon display and keyboard navigation
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local AceGUI = ns.AceGUI or LibStub("AceGUI-3.0")
local WoWAPI = ns.WoWAPI
local CreateFrame = _G.CreateFrame

-- Lua APIs
local strlower = strlower
local strfind = strfind
local tinsert = tinsert
local sort = table.sort
local max = math.max
local min = math.min

-- ============================ SPELL AUTOCOMPLETE WIDGET ============================

--- Register custom AceGUI widget for spell/item autocomplete
--- Provides hover tooltips showing spell/item information
--- Usage:
--- ```lua
--- local widget = AceGUI:Create("NAG_SpellAutocomplete")
--- widget:SetLabel("Spell ID")
--- widget:SetSpells(spellArray)  -- Array of {name="Name", value=123, type="spell"|"item", displayText="Optional"}
--- widget:SetCallback(function(spellID) print("Selected: " .. spellID) end)
--- ```
--- Entry format:
--- - name: Display name for searching
--- - value: Spell or item ID
--- - type: "spell" (default) or "item" - determines tooltip method
--- - displayText: Optional formatted text with icon (e.g., "|T:20:20|t Name")
local Type = "NAG_SpellAutocomplete"
local Version = 1

local function Constructor()
    -- Create base EditBox widget
    local widget = AceGUI:Create("EditBox")
    widget.type = Type

    -- Store original methods
    local oldOnAcquire = widget.OnAcquire
    local oldOnRelease = widget.OnRelease

    -- Spell data
    widget.spells = {}
    widget.filteredSpells = {}
    widget.selectedIndex = 1
    widget.suppressDropdown = false  -- Flag to suppress dropdown during programmatic updates

    -- Create dropdown frame
    local dropdown = CreateFrame("Frame", nil, nil, "TooltipBorderedFrameTemplate")
    dropdown:Hide()
    dropdown:SetFrameStrata("FULLSCREEN_DIALOG")
    dropdown:SetFrameLevel(1000)
    dropdown:SetClampedToScreen(true)
    dropdown:SetMovable(false)
    dropdown:EnableMouse(true)
    widget.dropdown = dropdown

    -- Scroll frame
    local scrollFrame = CreateFrame("ScrollFrame", nil, dropdown, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", dropdown, "TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", dropdown, "BOTTOMRIGHT", -28, 8)
    widget.scrollFrame = scrollFrame

    -- Content frame
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetWidth(1)
    content:SetHeight(1)
    scrollFrame:SetScrollChild(content)
    widget.content = content

    widget.buttons = {}

    -- Hide all textures on editbox to remove any icons
    local function HideEditBoxTextures(editbox)
        if editbox.Left then editbox.Left:Hide() end
        if editbox.Right then editbox.Right:Hide() end
        if editbox.Middle then editbox.Middle:Hide() end
        if editbox.Mid then editbox.Mid:Hide() end
        -- Hide all children textures
        for i = 1, editbox:GetNumChildren() do
            local child = select(i, editbox:GetChildren())
            if child and child:IsObjectType("Texture") then
                child:Hide()
            end
        end
    end

    -- Add placeholder
    local placeholder = widget.editbox:CreateFontString(nil, "OVERLAY", "GameFontDisable")
    placeholder:SetPoint("LEFT", widget.editbox, "LEFT", 5, 0)
    placeholder:SetText("Search...")
    placeholder:SetTextColor(0.8, 0.8, 0.8, 0.6)
    placeholder:SetJustifyH("LEFT")
    widget.placeholder = placeholder

    -- Remove any texture/icon from editbox
    HideEditBoxTextures(widget.editbox)

    -- Update placeholder visibility
    local function UpdatePlaceholder()
        if widget.editbox:GetText() == "" then
            placeholder:Show()
        else
            placeholder:Hide()
        end
    end

    -- Filter and show suggestions
    local function UpdateSuggestions(searchText)
        -- Don't show dropdown if suppressed (programmatic update)
        if widget.suppressDropdown then
            GameTooltip:Hide()
            dropdown:Hide()
            return
        end

        if not searchText or searchText == "" then
            GameTooltip:Hide()
            dropdown:Hide()
            return
        end

        local query = strlower(searchText)

        -- Separate prefix matches from substring matches
        local prefixMatches = {}
        local substringMatches = {}

        -- Check if query is numeric (for ID search)
        local isNumericQuery = query:match("^%d+$")

        for _, spell in ipairs(widget.spells) do
            local nameLower = strlower(spell.name or "")
            local spellID = spell.value

            -- Search by name
            local nameStartIndex = strfind(nameLower, query, 1, true)

            -- Search by ID (if query is numeric)
            local idMatches = false
            local idPrefixMatch = false
            if isNumericQuery and spellID then
                local idStr = tostring(spellID)
                if idStr == query then
                    -- Exact ID match - highest priority
                    idMatches = true
                elseif idStr:find("^" .. query) then
                    -- ID starts with query (e.g., "114" matches "114867")
                    idPrefixMatch = true
                end
            end

            -- Prioritize: name prefix > exact ID match > name substring > ID prefix
            if nameStartIndex == 1 then
                tinsert(prefixMatches, spell)
            elseif idMatches then
                -- Exact ID match goes to prefix matches (high priority)
                tinsert(prefixMatches, spell)
            elseif nameStartIndex or idPrefixMatch then
                -- Name substring match or ID prefix match
                tinsert(substringMatches, spell)
            end
        end

        -- Sort both lists alphabetically by name
        local function byName(a, b)
            return strlower(a.name or "") < strlower(b.name or "")
        end
        sort(prefixMatches, byName)
        sort(substringMatches, byName)

        -- Merge with prefix matches first, then substrings; cap at 10
        widget.filteredSpells = {}
        for i = 1, #prefixMatches do
            if #widget.filteredSpells >= 10 then break end
            tinsert(widget.filteredSpells, prefixMatches[i])
        end
        for i = 1, #substringMatches do
            if #widget.filteredSpells >= 10 then break end
            tinsert(widget.filteredSpells, substringMatches[i])
        end

        if #widget.filteredSpells == 0 then
            GameTooltip:Hide()
            dropdown:Hide()
            return
        end

        -- Clear buttons
        for _, button in ipairs(widget.buttons) do
            button:Hide()
        end

        -- Create/show buttons
        local buttonHeight = 20
        local totalHeight = 0

        for i, spell in ipairs(widget.filteredSpells) do
            local button = widget.buttons[i]
            if not button then
                button = CreateFrame("Button", nil, content)
                button:SetHeight(buttonHeight)
                button:SetPoint("LEFT")
                button:SetPoint("RIGHT")

                local highlight = button:CreateTexture(nil, "BACKGROUND")
                highlight:SetAllPoints()
                highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
                highlight:SetBlendMode("ADD")
                highlight:SetAlpha(0.3)
                highlight:Hide()
                button.highlight = highlight

                local text = button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
                text:SetPoint("LEFT", 5, 0)
                text:SetPoint("RIGHT", -5, 0)
                text:SetJustifyH("LEFT")
                text:SetNonSpaceWrap(false)
                text:SetWordWrap(false)
                text:SetWidth(dropdown:GetWidth() - 24)
                button.text = text

                button:SetScript("OnEnter", function()
                    widget.selectedIndex = i
                    for j, btn in ipairs(widget.buttons) do
                        btn.highlight:SetShown(j == i)
                    end

                    -- Show tooltip
                    local entry = button.entry
                    if entry and entry.value then
                        GameTooltip:SetOwner(button, "ANCHOR_RIGHT")

                        -- Determine if this is a spell or item based on type field
                        if entry.type == "item" then
                            pcall(function() GameTooltip:SetItemByID(entry.value) end)
                        else
                            -- Default to spell - wrap in pcall for non-spellbook IDs
                            pcall(function() GameTooltip:SetSpellByID(entry.value) end)
                        end

                        GameTooltip:Show()
                    end
                end)

                button:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)

                -- Click should use the current entry for this button
                button:SetScript("OnClick", function()
                    local entry = button.entry
                    if not entry then
                        return
                    end
                    -- Suppress dropdown when programmatically setting text from selection
                    widget.suppressDropdown = true
                    widget.editbox:SetText(entry.name)
                    widget.suppressDropdown = false
                    widget.editbox:ClearFocus()
                    widget.selectedSpellID = entry.value
                    GameTooltip:Hide()
                    dropdown:Hide()
                    if widget.callback then
                        widget.callback(entry.value)
                    end
                end)

                tinsert(widget.buttons, button)
            end

            button:Show()
            button:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -(i - 1) * buttonHeight)
            button:SetPoint("RIGHT", content, "RIGHT", 0, 0)

            -- Set text - use displayText if available, otherwise just name
            local displayText = spell.displayText or spell.name or ""
            if displayText and displayText ~= "" then
                button.text:SetText(displayText)
            else
                button.text:SetText(spell.name or "Unknown")
            end
            -- Store the entry on the button
            button.entry = spell

            totalHeight = totalHeight + buttonHeight
        end

        content:SetHeight(totalHeight)
        local dropdownWidth = max(240, widget.editbox:GetWidth())
        content:SetWidth(dropdownWidth - 16)
        dropdown:SetWidth(dropdownWidth)
        dropdown:SetHeight(min(totalHeight + 16, 200))
        dropdown:ClearAllPoints()
        dropdown:SetPoint("TOPLEFT", widget.editbox, "BOTTOMLEFT", 0, -2)

        -- Reparent dropdown to top-level frame right before showing to ensure correct layering
        local function reparentToTopFrame()
            if not widget.editbox or not widget.editbox:GetParent() then
                return
            end

            local parent = widget.editbox:GetParent()
            local maxDepth = 15
            local depth = 0
            local topFrame = parent

            -- Walk up to find the highest frame in the hierarchy (usually the main dialog frame)
            while parent and depth < maxDepth do
                local grandParent = parent:GetParent()
                if not grandParent or grandParent == UIParent then
                    topFrame = parent
                    break
                end
                parent = grandParent
                topFrame = parent
                depth = depth + 1
            end

            -- Reparent dropdown to top-level frame with maximum frame level
            if topFrame and topFrame.GetFrameLevel then
                dropdown:SetParent(topFrame)
                dropdown:SetFrameStrata("FULLSCREEN_DIALOG")
                local topLevel = topFrame:GetFrameLevel() or 100
                dropdown:SetFrameLevel(topLevel + 100)
            end
        end

        reparentToTopFrame()
        dropdown:Show()

        widget.selectedIndex = 1
        if widget.buttons[1] then
            for i, btn in ipairs(widget.buttons) do
                btn.highlight:SetShown(i == 1)
            end
        end
    end

    -- WIDGET POOL SAFETY: Raw HookScript is safe here because:
    -- 1. This code runs in Constructor - creates fresh widget each time
    -- 2. widget.editbox is created fresh here (line ~40), owned by this widget instance
    -- 3. When widget releases to pool, editbox is cleared (OnRelease line ~491-497)
    -- 4. Next Constructor creates NEW editbox with NEW hooks - no pollution
    -- 5. These are NOT shared TreeGroup buttons - each widget owns its editbox
    -- 6. Hooks are part of the widget's lifecycle and die when widget is released
    -- No cleanup needed - hooks die with the widget instance
    widget.editbox:HookScript("OnTextChanged", function(self)
        UpdatePlaceholder()
        local text = self:GetText()
        UpdateSuggestions(text)
    end)

    widget.editbox:HookScript("OnEditFocusGained", function(self)
        placeholder:Hide()
        local text = self:GetText()
        if text and text ~= "" then
            UpdateSuggestions(text)
        end
    end)

    widget.editbox:HookScript("OnEditFocusLost", function(self)
        UpdatePlaceholder()
        GameTooltip:Hide()
        C_Timer.After(0.2, function()
            dropdown:Hide()
        end)
    end)

    widget.editbox:HookScript("OnKeyDown", function(self, key)
        -- Handle ENTER key for both dropdown selection and direct numeric entry
        if key == "ENTER" then
            -- Check if we have a dropdown selection
            local spell = widget.filteredSpells[widget.selectedIndex]
            if spell and dropdown:IsShown() then
                -- Existing dropdown selection logic
                widget.suppressDropdown = true
                self:SetText(spell.name)
                widget.suppressDropdown = false
                self:ClearFocus()
                widget.selectedSpellID = spell.value
                GameTooltip:Hide()
                dropdown:Hide()
                if widget.callback then
                    widget.callback(spell.value)
                end
            else
                -- Handle direct numeric ID entry
                local text = self:GetText()
                local numericID = tonumber(text)

                if numericID and numericID > 0 then
                    -- Validate with GetSpellInfo (returns SpellInfo table)
                    local spellInfo = WoWAPI.GetSpellInfo(numericID)
                    local spellName = spellInfo and spellInfo.name

                    if spellName and spellName ~= "" then
                        -- Valid spell ID - accept it
                        widget.suppressDropdown = true
                        self:SetText(spellName)  -- Show spell name instead of ID
                        widget.suppressDropdown = false
                        self:ClearFocus()
                        widget.selectedSpellID = numericID
                        GameTooltip:Hide()
                        dropdown:Hide()
                        if widget.callback then
                            widget.callback(numericID)
                        end
                    else
                        -- Invalid spell ID or name not loaded - still accept numeric ID
                        widget.suppressDropdown = true
                        self:SetText(tostring(numericID))  -- Keep the ID displayed
                        widget.suppressDropdown = false
                        self:ClearFocus()
                        widget.selectedSpellID = numericID
                        GameTooltip:Hide()
                        dropdown:Hide()
                        if widget.callback then
                            widget.callback(numericID)
                        end
                        NAG:Print("|cFFFFAA00Accepted spell ID: " .. numericID .. " (name not available)|r")
                    end
                end
            end
        elseif key == "ESCAPE" then
            GameTooltip:Hide()
            dropdown:Hide()
            self:ClearFocus()  -- Allow user to escape out of the input field
        elseif key == "DOWN" or key == "UP" then
            -- Only handle UP/DOWN if dropdown is shown
            if not dropdown:IsShown() then return end
            widget.content:SetWidth(max(240, widget.editbox:GetWidth()) - 16)

            if key == "DOWN" then
                widget.selectedIndex = widget.selectedIndex + 1
                if widget.selectedIndex > #widget.filteredSpells then
                    widget.selectedIndex = 1
                end
                for i, btn in ipairs(widget.buttons) do
                    btn.highlight:SetShown(i == widget.selectedIndex)
                end
            elseif key == "UP" then
                widget.selectedIndex = widget.selectedIndex - 1
                if widget.selectedIndex < 1 then
                    widget.selectedIndex = #widget.filteredSpells
                end
                for i, btn in ipairs(widget.buttons) do
                    btn.highlight:SetShown(i == widget.selectedIndex)
                end
            end
        end
    end)

    -- Method to set spells
    function widget:SetSpells(spells)
        self.spells = spells or {}
    end

    -- Method to set callback
    function widget:SetCallback(callback)
        self.callback = callback
    end

    -- Store original SetText
    local originalSetText = widget.SetText

    -- Override SetText to suppress dropdown during programmatic updates
    function widget:SetText(text)
        self.suppressDropdown = true
        originalSetText(self, text)
        -- Clear flag after a tiny delay to let OnTextChanged fire
        C_Timer.After(0, function()
            self.suppressDropdown = false
        end)
    end

    -- Override OnAcquire
    widget.OnAcquire = function(self)
        if oldOnAcquire then oldOnAcquire(self) end
        self.spells = {}
        self.filteredSpells = {}
        self.selectedIndex = 1
        self.selectedSpellID = nil
        self.suppressDropdown = false
        UpdatePlaceholder()
        -- Hide textures again when widget is acquired
        HideEditBoxTextures(self.editbox)
    end

    -- Override OnRelease
    widget.OnRelease = function(self)
        GameTooltip:Hide()
        dropdown:Hide()
        -- Reset parent
        dropdown:SetParent(nil)
        if oldOnRelease then oldOnRelease(self) end
    end

    -- Note: Dropdown reparenting happens in UpdateSuggestions() right before showing
    -- to ensure correct layering. No need to reparent in Show() override.

    UpdatePlaceholder()

    return widget
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)

-- ============================ END SPELL AUTOCOMPLETE WIDGET ============================

