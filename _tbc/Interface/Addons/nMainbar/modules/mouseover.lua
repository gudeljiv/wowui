local _, nMainbar = ...
local cfg = nMainbar.Config

-- Mouse Over Code

local function EnableMouseOver(self, bar, min, max, alpha, hiddenAlpha)
    local minAlpha = hiddenAlpha or 0
    local barFrame = bar and _G[bar] or nil

    for i = min, max do
        local button = _G[self..i]

        local mouseOverFrame = CreateFrame("Frame", nil, barFrame or UIParent)
        mouseOverFrame:SetFrameStrata("LOW")
        mouseOverFrame:SetFrameLevel(1)
        mouseOverFrame:EnableMouse()
        mouseOverFrame:SetPoint("TOPLEFT", self..min, -5, 5)
        mouseOverFrame:SetPoint("BOTTOMRIGHT", self..max, 5, 5)

        if barFrame then
            hooksecurefunc(barFrame, "SetAlpha", function(self, alpha)
                if button and button.cooldown then
                    button.cooldown:SetSwipeColor(0, 0, 0, alpha)
                    button.cooldown:SetDrawSwipe(alpha > 0)
                    button.cooldown:SetDrawEdge(alpha > 0)
                    button.cooldown:SetDrawBling(alpha > 0)
                end
        end)

        if ValidateActionBarTransition then
            hooksecurefunc("ValidateActionBarTransition", function(self)
                if barFrame and barFrame:IsShown() then
                    if not MouseIsOver(mouseOverFrame) then
                        if barFrame then barFrame:SetAlpha(minAlpha) end
                    end
                end
            end)
        end

        mouseOverFrame:SetScript("OnShow", function()
            if not MouseIsOver(button) then
                if barFrame then barFrame:SetAlpha(minAlpha) end
            end
        end)

        mouseOverFrame:SetScript("OnEnter", function()
            if barFrame then barFrame:SetAlpha(alpha) end
        end)

        mouseOverFrame:SetScript("OnLeave", function()
            if not MouseIsOver(button) then
                if barFrame then barFrame:SetAlpha(minAlpha) end
            end
        end)
        end
    end
end

-- Extra Bar Right

if cfg.multiBarRight.mouseover then
    EnableMouseOver("MultiBarRightButton", "MultiBarRight", 1, 12, cfg.multiBarRight.alpha, cfg.multiBarRight.hiddenAlpha)
end

-- Pet Bar

if cfg.petBar.mouseover then
    EnableMouseOver("PetActionButton", "PetActionBarFrame", 1, NUM_PET_ACTION_SLOTS, cfg.petBar.alpha, cfg.petBar.hiddenAlpha)
end

-- Stance Bar

if cfg.stanceBar.mouseover then
    EnableMouseOver("StanceButton", "StanceBarFrame", 1, NUM_STANCE_SLOTS, cfg.stanceBar.alpha, cfg.stanceBar.hiddenAlpha)
end

-- Bottom Right Bar (Fake)

if cfg.useFakeBottomRightBar and cfg.multiBarBottomRight.mouseover then
    EnableMouseOver("FakeMultiBarBottomRight1Button", "FakeMultiBarBottomRight1", 1, 12, cfg.multiBarBottomRight.alpha, cfg.multiBarBottomRight.hiddenAlpha)
end
