local function ensureCorrectPaneVisible()
    if PaperDollFrame:IsVisible() and CharacterFrameExpandButton and not CharacterStatsPane:IsShown() then
        CharacterFrameExpandButton:Click()
    end
    if PetPaperDollFrame:IsVisible() and CharacterFrameExpandButton and not CharacterStatsPane:IsShown() then
        CharacterFrameExpandButton:Click()
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "AutoExpandCharacterInfo" then
        -- Secure hook into the ToggleCharacter function to ensure default behavior
        hooksecurefunc("ToggleCharacter", function(panel)
            C_Timer.After(0.01, function()  -- Delay slightly to ensure UI updates are correctly processed
                ensureCorrectPaneVisible()
            end)
        end)

        -- Ensure visibility on tab clicks for character and pet stats
        for i = 1, CharacterFrame.numTabs do
            local tab = _G["CharacterFrameTab" .. i]
            tab:HookScript("OnClick", function()
                C_Timer.After(0.01, function()  -- Delay slightly to ensure UI updates are correctly processed
                    ensureCorrectPaneVisible()
                end)
            end)
        end
    elseif event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
        ensureCorrectPaneVisible()
    end
end)
