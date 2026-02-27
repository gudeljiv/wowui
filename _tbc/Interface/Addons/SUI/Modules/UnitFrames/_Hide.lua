local Module = SUI:NewModule("UnitFrames.Hide");

function Module:OnEnable()
    local db = SUI.db.profile.unitframes
    hooksecurefunc("PlayerFrame_UpdateStatus", function()
        -- pvpbadge
        if not (db.pvpbadge) then
            local function SafeSetAlpha(frame, alpha)
                if frame and frame.SetAlpha then
                    frame:SetAlpha(alpha)
                end
            end

            local playerFrame = _G.PlayerFrame
            local targetFrame = _G.TargetFrame
            local focusFrame = _G.FocusFrame

            local playerContext = playerFrame and playerFrame.PlayerFrameContent
                and playerFrame.PlayerFrameContent.PlayerFrameContentContextual
            local targetContext = targetFrame and targetFrame.TargetFrameContent
                and targetFrame.TargetFrameContent.TargetFrameContentContextual
            local focusContext = focusFrame and focusFrame.TargetFrameContent
                and focusFrame.TargetFrameContent.TargetFrameContentContextual

            SafeSetAlpha(playerContext and playerContext.PrestigeBadge, 0)
            SafeSetAlpha(playerContext and playerContext.PrestigePortrait, 0)
            SafeSetAlpha(targetContext and targetContext.PrestigeBadge, 0)
            SafeSetAlpha(targetContext and targetContext.PrestigePortrait, 0)
            SafeSetAlpha(focusContext and focusContext.PrestigeBadge, 0)
            SafeSetAlpha(focusContext and focusContext.PrestigePortrait, 0)

            SafeSetAlpha((playerContext and playerContext.PVPIcon) or _G.PlayerPVPIcon, 0)
            SafeSetAlpha((targetContext and targetContext.PvpIcon) or _G.TargetFrameTextureFramePVPIcon, 0)
            SafeSetAlpha((focusContext and focusContext.PvpIcon) or _G.FocusFrameTextureFramePVPIcon, 0)
        end
    end)
end
