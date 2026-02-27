local Module = SUI:NewModule("Chat.Quickjoin");

function Module:OnEnable()
    local db = SUI.db.profile.chat.quickjoin
    local button = QuickJoinToastButton
    if not button then
        return
    end

    if (db) then
        button:Show()
        button.Show = function()
            button:SetPoint("TOPLEFT", ChatFrame1, "TOPLEFT", 50, 40)
        end
    else
        button:Hide()
        button.Show = function()
        end
    end
end
