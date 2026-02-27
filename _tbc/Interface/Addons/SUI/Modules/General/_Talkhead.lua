local Module = SUI:NewModule("General.Talkhead");

function Module:OnEnable()
    local db = SUI.db.profile.general.cosmetic.talkinghead
    if not db then
        if TalkingHeadFrame and TalkingHeadFrame.PlayCurrent then
            hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function()
                TalkingHeadFrame:Hide()
            end)
        elseif type(TalkingHeadFrame_PlayCurrent) == "function" then
            hooksecurefunc("TalkingHeadFrame_PlayCurrent", function()
                if TalkingHeadFrame then
                    TalkingHeadFrame:Hide()
                end
            end)
        end
    end
end
