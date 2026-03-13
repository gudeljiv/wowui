--- @module "Utils.AceGUIPatches"
--- Instance-specific patches for NAG's AceGUI widgets to support modern display resolutions
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...

-- Lua APIs
local math = math
local type = type

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- @type AceGUI-3.0
local AceGUI = ns.AceGUI

if not AceGUI then
    error("AceGUIPatches: AceGUI-3.0 not available")
    return
end

-- ============================ TREEGROUP WIDESCREEN PATCH ============================

--- Track NAG-owned widgets with weak keys for garbage collection safety
local nagWidgets = setmetatable({}, {__mode = "k"})

--- Patch a specific TreeGroup instance to support ultrawide monitors
--- Allows tree panels to expand up to 50% of container width instead of the hardcoded 400px limit
---
--- This patch:
--- - Allows tree panels to expand up to 50% of container width
--- - Ensures content panel maintains at least 300px width
--- - Dynamically updates resize bounds when container size changes
--- - ONLY affects the specific widget instance passed in
---
--- Historical context: The 400px limit was appropriate for 1024x768 displays
--- but is restrictive on modern ultrawide monitors (2560x1440, 3440x1440, etc.)
---
--- @param widget table TreeGroup widget instance to patch
--- @return table The patched widget
local function PatchTreeGroupForWidescreen(widget)
    if not widget or widget.type ~= "TreeGroup" then
        return widget
    end

    -- Mark this as a NAG widget
    nagWidgets[widget] = true

    -- Store original OnWidthSet method
    local originalOnWidthSet = widget.OnWidthSet

    if originalOnWidthSet then
        --- Patched OnWidthSet to allow dynamic tree width based on container size
        --- @param self table TreeGroup widget
        --- @param width number Container width in pixels
        widget.OnWidthSet = function(self, width)
            -- Store the actual tree width BEFORE calling original
            -- (original might clamp it via SetTreeWidth call on line 564)
            local treeframe = self.treeframe
            local actualTreeWidth = treeframe and treeframe:GetWidth() or 0

            -- CRITICAL: Call original OnWidthSet FIRST
            -- It will apply its hardcoded 400px limit, but we'll override it after
            local result = originalOnWidthSet(self, width)

            -- NOW calculate our dynamic max tree width:
            -- - Up to 50% of container width
            -- - But always leave at least 300px for content panel
            local maxTreeWidth = math.min(width * 0.5, width - 300)

            -- Ensure maxTreeWidth is reasonable (don't go below 100px minimum)
            if maxTreeWidth < 100 then
                maxTreeWidth = 100
            end

            -- Update treeframe resize bounds dynamically AFTER original has run
            -- This overrides the hardcoded 400px limit from TreeGroup line 561
            if treeframe then
                -- Use modern API if available (WoW 10.0+), otherwise fallback to legacy
                if treeframe.SetResizeBounds then
                    treeframe:SetResizeBounds(100, 1, maxTreeWidth, 1600)
                else
                    -- Legacy API (Classic/TBC/Wrath)
                    treeframe:SetMinResize(100, 1)
                    treeframe:SetMaxResize(maxTreeWidth, 1600)
                end

                -- CRITICAL FIX: Restore actual dragged width if it was clamped
                -- Original OnWidthSet (line 563-564) calls SetTreeWidth to clamp to 400px
                -- We need to restore the width the user actually dragged to
                local status = self.status or self.localstatus
                if status and actualTreeWidth > 400 and status.treewidth <= 400 then
                    -- Tree width was clamped! Restore it
                    status.treewidth = actualTreeWidth
                    treeframe:SetWidth(actualTreeWidth)

                    -- Recalculate content width with restored tree width
                    local contentwidth = width - actualTreeWidth - 20
                    if contentwidth < 0 then
                        contentwidth = 0
                    end
                    self.content:SetWidth(contentwidth)
                    self.content.width = contentwidth
                end
            end

            -- Return result from original
            return result
        end
    end

    return widget
end

--- Create a TreeGroup widget with NAG's widescreen patch applied
--- This is the preferred way for NAG code to create TreeGroup widgets
--- @return table TreeGroup widget with widescreen support
local function CreateTreeGroup()
    local widget = AceGUI:Create("TreeGroup")
    return PatchTreeGroupForWidescreen(widget)
end

--- Check if a widget belongs to NAG (for debugging/diagnostics)
--- @param widget table Widget to check
--- @return boolean True if widget was created by NAG
local function IsNAGWidget(widget)
    return nagWidgets[widget] == true
end

-- ============================ COLORPICKERFRAME MOP COMPAT ============================
-- MoP's ColorPickerFrame.xml expects swatchFunc; some callers only set func.
-- Without modifying LibUIDropDownMenu, we ensure swatchFunc is never nil before show.
local AceHook = LibStub("AceHook-3.0", true)
local ColorPickerFrame = _G.ColorPickerFrame
if AceHook and ColorPickerFrame then
    AceHook:HookScript(ColorPickerFrame, "OnShow", function()
        if not ColorPickerFrame.swatchFunc and ColorPickerFrame.func then
            ColorPickerFrame.swatchFunc = ColorPickerFrame.func
        end
    end)
end

-- Expose functions on namespace for NAG modules to use
ns.PatchTreeGroupForWidescreen = PatchTreeGroupForWidescreen
ns.CreateTreeGroup = CreateTreeGroup
ns.IsNAGWidget = IsNAGWidget

