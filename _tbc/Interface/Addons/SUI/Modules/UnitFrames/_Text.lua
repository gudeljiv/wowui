local Module = SUI:NewModule("UnitFrames.Text");

function Module:OnEnable()
    local db = SUI.db.profile.unitframes.hitindicator
    if not (db) then
        local playerFrame = _G.PlayerFrame
        if not (playerFrame and playerFrame.HookScript) then
            return
        end

        playerFrame:HookScript("OnEvent", function()
            local content = playerFrame.PlayerFrameContent
            local hitText = content
                and content.PlayerFrameContentMain
                and content.PlayerFrameContentMain.HitIndicator
                and content.PlayerFrameContentMain.HitIndicator.HitText
            if not hitText then
                hitText = _G.PlayerHitIndicatorText or _G.PlayerHitIndicator
            end
            if hitText and hitText.Hide then
                hitText:Hide()
            end
        end)
        if PetHitIndicator then
            PetHitIndicator:SetText(nil)
            PetHitIndicator.SetText = function() end
        end
    end
end
