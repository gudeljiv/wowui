--- @module "APLAutocomplete"
--- Helper module for adding APL autocomplete to MultiLineEditBox widgets
---
--- Usage:
--- ```lua
--- local editor = AceGUI:Create("MultiLineEditBox")
--- editor:SetLabel("Action")
--- editor:SetFullWidth(true)
--- editor:SetNumLines(6)
---
--- -- Add autocomplete to existing MultiLineEditBox
--- local SchemaAccessor = NAG:GetModule("SchemaAccessor")
--- local actionData = SchemaAccessor:GetAutocompleteData("Actions")
--- ns.APLAutocomplete:AddToEditBox(editor, actionData, "Actions", function(selectedEntry, widget)
---     -- Callback when item is selected
--- end)
--- ```
---
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local AceGUI = ns.AceGUI or LibStub("AceGUI-3.0")
local GetCursorPosition = _G.GetCursorPosition
local CreateFrame = _G.CreateFrame

-- Lua APIs
local strlower = strlower
local strfind = strfind
local tinsert = tinsert
local sort = table.sort
local max = math.max
local min = math.min

-- ============================ APL AUTOCOMPLETE HELPER ============================

--- APL Autocomplete helper module
--- @class APLAutocomplete
local APLAutocomplete = {}
ns.APLAutocomplete = APLAutocomplete

--- Add autocomplete functionality to a MultiLineEditBox widget
--- @param widget table The MultiLineEditBox widget
--- @param aplData table Array of autocomplete entries
--- @param category string "Actions" or "Values"
--- @param onSelectCallback function Callback when item is selected
function APLAutocomplete:AddToEditBox(widget, aplData, category, onSelectCallback)
    if not widget or not widget.editBox then
        NAG:Error("APLAutocomplete: Invalid widget - must be MultiLineEditBox")
        return
    end

    -- Store autocomplete state on widget
    widget._aplAutocomplete = {
        aplData = aplData or {},
        filteredData = {},
        selectedIndex = 1,
        category = category,
        callback = onSelectCallback,
        buttons = {}
    }

    local acState = widget._aplAutocomplete

    -- Create dropdown frame attached to widget's scrollFrame parent
    local dropdown = CreateFrame("Frame", nil, widget.scrollFrame:GetParent(), "TooltipBorderedFrameTemplate")
    dropdown:Hide()
    dropdown:SetFrameStrata("TOOLTIP")
    dropdown:SetFrameLevel(widget.scrollFrame:GetFrameLevel() + 20)
    dropdown:SetClampedToScreen(true)
    dropdown:SetMovable(false)
    dropdown:EnableMouse(true)
    acState.dropdown = dropdown

    -- Scroll frame for dropdown
    local scrollFrameAC = CreateFrame("ScrollFrame", nil, dropdown, "UIPanelScrollFrameTemplate")
    scrollFrameAC:SetPoint("TOPLEFT", dropdown, "TOPLEFT", 8, -8)
    scrollFrameAC:SetPoint("BOTTOMRIGHT", dropdown, "BOTTOMRIGHT", -28, 8)
    acState.scrollFrame = scrollFrameAC

    -- Content frame
    local content = CreateFrame("Frame", nil, scrollFrameAC)
    content:SetWidth(1)
    content:SetHeight(1)
    scrollFrameAC:SetScrollChild(content)
    acState.content = content

    -- Lua keywords that should not trigger autocomplete
    -- Note: not/and/or are APL operators and SHOULD show in autocomplete
    local LUA_KEYWORDS = {
        ["if"] = true,
        ["then"] = true,
        ["else"] = true,
        ["elseif"] = true,
        ["end"] = true,
        ["function"] = true,
        ["return"] = true,
        ["local"] = true,
        ["true"] = true,
        ["false"] = true,
        ["nil"] = true,
    }

    -- Filter and show suggestions
    local function UpdateSuggestions(searchText)
        if not searchText or searchText == "" then
            dropdown:Hide()
            return
        end

        -- Don't show autocomplete for Lua keywords/operators
        local searchLower = strlower(searchText)
        if LUA_KEYWORDS[searchLower] then
            dropdown:Hide()
            return
        end

        local query = searchLower

        -- Separate prefix matches from substring matches
        local prefixMatches = {}
        local substringMatches = {}

        for _, entry in ipairs(acState.aplData) do
            local nameLower = strlower(entry.name or "")
            local labelLower = strlower(entry.label or "")

            -- Strip "NAG:" prefix for smarter matching
            -- This allows matching "All" against "NAG:AllTrinketStatProcsActive"
            local handlerName = nameLower:match("^nag:(.+)$") or nameLower

            -- Match against name (with and without NAG: prefix) and label
            local nameStartIndex = strfind(nameLower, query, 1, true)
            local handlerStartIndex = strfind(handlerName, query, 1, true)
            local labelStartIndex = strfind(labelLower, query, 1, true)

            -- Prioritize matches on the handler name itself (after NAG:)
            if handlerStartIndex == 1 or nameStartIndex == 1 or labelStartIndex == 1 then
                tinsert(prefixMatches, entry)
            elseif handlerStartIndex or nameStartIndex or labelStartIndex then
                tinsert(substringMatches, entry)
            end
        end

        -- Sort both lists alphabetically by label
        local function byLabel(a, b)
            return strlower(a.label or "") < strlower(b.label or "")
        end
        sort(prefixMatches, byLabel)
        sort(substringMatches, byLabel)

        -- Merge with prefix matches first, cap at 10
        acState.filteredData = {}
        for i = 1, #prefixMatches do
            if #acState.filteredData >= 10 then break end
            tinsert(acState.filteredData, prefixMatches[i])
        end
        for i = 1, #substringMatches do
            if #acState.filteredData >= 10 then break end
            tinsert(acState.filteredData, substringMatches[i])
        end

        if #acState.filteredData == 0 then
            dropdown:Hide()
            return
        end

        -- Clear buttons
        for _, button in ipairs(acState.buttons) do
            button:Hide()
        end

        -- Create/show buttons
        local buttonHeight = 40 -- Taller for two-line display
        local totalHeight = 0

        for i, entry in ipairs(acState.filteredData) do
            local button = acState.buttons[i]
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

                -- Label text (line 1)
                local labelText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                labelText:SetPoint("TOPLEFT", 5, -3)
                labelText:SetPoint("RIGHT", -5, 0)
                labelText:SetJustifyH("LEFT")
                labelText:SetNonSpaceWrap(false)
                labelText:SetWordWrap(false)
                button.labelText = labelText

                -- Description text (line 2)
                local descText = button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
                descText:SetPoint("TOPLEFT", labelText, "BOTTOMLEFT", 0, -2)
                descText:SetPoint("RIGHT", -5, 0)
                descText:SetJustifyH("LEFT")
                descText:SetNonSpaceWrap(false)
                descText:SetWordWrap(false)
                descText:SetTextColor(0.7, 0.7, 0.7, 1)
                button.descText = descText

                button:SetScript("OnEnter", function()
                    acState.selectedIndex = i
                    for j, btn in ipairs(acState.buttons) do
                        btn.highlight:SetShown(j == i)
                    end

                    -- Show tooltip with full description
                    if entry.fullDescription and entry.fullDescription ~= "" then
                        GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
                        GameTooltip:SetText(entry.label or entry.name, 1, 1, 1)
                        GameTooltip:AddLine(entry.fullDescription, 1, 0.82, 0, true)
                        GameTooltip:Show()
                    end
                end)

                button:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)

                -- Click should use the current entry
                button:SetScript("OnClick", function()
                    local currentEntry = button.entry
                    if not currentEntry then return end

                    dropdown:Hide()
                    if acState.callback then
                        acState.callback(currentEntry, widget)
                    end
                    GameTooltip:Hide()
                end)

                tinsert(acState.buttons, button)
            end

            button:Show()
            button:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -(i - 1) * buttonHeight)
            button:SetPoint("RIGHT", content, "RIGHT", 0, 0)

            -- Set text
            button.labelText:SetText(entry.label or entry.name)

            -- Set description with parameter hint
            local descriptionText = entry.description or ""
            if entry.parameterHint and entry.parameterHint ~= "" and entry.parameterHint ~= "no parameters" then
                descriptionText = "|cFF888888" .. entry.parameterHint .. "|r"
            end
            button.descText:SetText(descriptionText)

            -- Store the entry on the button
            button.entry = entry
            button.labelText:Show()
            button.descText:Show()

            totalHeight = totalHeight + buttonHeight
        end

        content:SetHeight(totalHeight)
        local dropdownWidth = max(400, widget.scrollFrame:GetWidth() or 400)
        content:SetWidth(dropdownWidth - 16)
        dropdown:SetWidth(dropdownWidth)
        dropdown:SetHeight(min(totalHeight + 16, 300))
        dropdown:ClearAllPoints()

        -- Position dropdown below the scrollFrame (where the editBox is visible)
        if widget.scrollFrame then
            dropdown:SetPoint("TOPLEFT", widget.scrollFrame, "BOTTOMLEFT", -8, 2)
        end

        dropdown:Show()

        acState.selectedIndex = 1
        if acState.buttons[1] then
            for i, btn in ipairs(acState.buttons) do
                btn.highlight:SetShown(i == 1)
            end
        end
    end

    -- WIDGET POOL SAFETY: Raw HookScript is safe here because:
    -- 1. This code runs in AddToEditBox - adds to existing MultiLineEditBox widget
    -- 2. widget.editBox is part of the MultiLineEditBox widget, owned by that widget
    -- 3. When MultiLineEditBox releases to pool, editBox is cleared and reset
    -- 4. Each AddToEditBox call hooks the specific widget instance being configured
    -- 5. These are NOT shared TreeGroup buttons - each widget owns its editBox
    -- 6. Hooks are part of the widget's lifecycle and die when widget is released
    -- No cleanup needed - hooks die with the widget instance

    -- Hook OnChar to detect typing - text is already updated when OnChar fires
    widget.editBox:HookScript("OnChar", function(self, char)
        if not acState then return end

        -- Get current text and cursor position (text is already updated by this point)
        local text = widget.editBox:GetText() or ""
        local cursorPos = widget.editBox:GetCursorPosition()

        -- Extract word at cursor, including NAG: prefix if present
        -- Matches: "NAG:Word", "Word", "NAG:", etc.
        local beforeCursor = text:sub(1, cursorPos)
        local word = beforeCursor:match("([%w_:]+)$")

        if word and #word >= 2 then
            UpdateSuggestions(word)
        else
            acState.dropdown:Hide()
        end
    end)

    -- Hook OnEditFocusLost to hide dropdown
    widget.editBox:HookScript("OnEditFocusLost", function(self)
        C_Timer.After(0.2, function()
            if acState and acState.dropdown then
                acState.dropdown:Hide()
            end
        end)
    end)

    -- Hook OnEscapePressed for dropdown hiding
    widget.editBox:HookScript("OnEscapePressed", function(self)
        if acState and acState.dropdown and acState.dropdown:IsShown() then
            acState.dropdown:Hide()
        end
    end)

    -- Add OnKeyDown handler for navigation
    widget.editBox:HookScript("OnKeyDown", function(self, key)
        if not acState or not acState.dropdown or not acState.dropdown:IsShown() then return end

        if key == "DOWN" then
            acState.selectedIndex = acState.selectedIndex + 1
            if acState.selectedIndex > #acState.filteredData then
                acState.selectedIndex = 1
            end
            for i, btn in ipairs(acState.buttons) do
                btn.highlight:SetShown(i == acState.selectedIndex)
            end
        elseif key == "UP" then
            acState.selectedIndex = acState.selectedIndex - 1
            if acState.selectedIndex < 1 then
                acState.selectedIndex = #acState.filteredData
            end
            for i, btn in ipairs(acState.buttons) do
                btn.highlight:SetShown(i == acState.selectedIndex)
            end
        elseif key == "TAB" then
            local entry = acState.filteredData[acState.selectedIndex]
            if entry and acState.callback then
                acState.dropdown:Hide()
                acState.callback(entry, widget)
            end
        end
    end)
end

--- Remove autocomplete from a widget
--- @param widget table The MultiLineEditBox widget
function APLAutocomplete:RemoveFromEditBox(widget)
    if not widget or not widget._aplAutocomplete then return end

    local acState = widget._aplAutocomplete
    if acState.dropdown then
        acState.dropdown:Hide()
        acState.dropdown:SetParent(nil)
    end

    widget._aplAutocomplete = nil
end

-- ============================ END APL AUTOCOMPLETE HELPER ============================
