-- local function OnMouseWheel(self, delta)
--     local scrollBar = _G["GlyphFrameScrollFrameScrollBar"]
--     if not scrollBar then return end

--     local currentValue = scrollBar:GetValue()
--     local minVal, maxVal = scrollBar:GetMinMaxValues()
--     local scrollIncrement = 20  -- Adjust this for faster or slower scrolling

--     local newValue = currentValue - (delta * scrollIncrement)
--     newValue = math.max(minVal, math.min(newValue, maxVal))

--     scrollBar:SetValue(newValue)
-- end


-- local function SetupMouseWheelScrolling(frameName)
--     local frame = _G[frameName]
--     if frame then
--         frame:EnableMouseWheel(true)
--         frame:SetScript("OnMouseWheel", OnMouseWheel)
--     end
-- end

-- local function OnAddonLoaded(addonName)
--     if addonName == "Blizzard_GlyphUI" then
--         -- SetupMouseWheelScrolling("GlyphFrameScrollFrameScrollChild")  -- Setup for the main frame
--         SetupMouseWheelScrolling("GlyphFrameScrollFrameScrollBar")  -- Setup specifically for the scrollbar as well
--     end
-- end

-- local frame = CreateFrame("Frame")
-- frame:RegisterEvent("ADDON_LOADED")
-- frame:SetScript("OnEvent", function(self, event, addonName)
--     OnAddonLoaded(addonName)
-- end)
