local Module = SUI:NewModule("Skins.Frames");

function Module:OnEnable()
    if (SUI:Color()) then
        local function SafeSkin(frame)
            if frame then
                SUI:Skin(frame, true)
            end
        end

        SafeSkin(GameMenuFrame)
        SafeSkin(GameMenuFrame and GameMenuFrame.Header)
        SafeSkin(GameMenuFrame and GameMenuFrame.Border)
        SafeSkin(StaticPopup1)
        SafeSkin(StaticPopup1 and StaticPopup1.Border)
        SafeSkin(StaticPopup2)
        SafeSkin(StaticPopup2 and StaticPopup2.Border)
        SafeSkin(StaticPopup3)
        SafeSkin(StaticPopup3 and StaticPopup3.Border)
        SafeSkin(EditModeManagerFrame)
        SafeSkin(EditModeManagerFrame and EditModeManagerFrame.Border)
        SafeSkin(VehicleSeatIndicator)
        SafeSkin(ReportFrame)
        SafeSkin(ReportFrame and ReportFrame.Border)
        SafeSkin(ReadyStatus and ReadyStatus.Border)
        SafeSkin(LFGDungeonReadyStatus and LFGDungeonReadyStatus.Border)
        SafeSkin(LFGDungeonReadyDialog)
        SafeSkin(LFGDungeonReadyDialog and LFGDungeonReadyDialog.Border)
        SafeSkin(PVPMatchScoreboard and PVPMatchScoreboard.Content)
        SafeSkin(QueueStatusFrame)
        SafeSkin(QueueStatusFrame and QueueStatusFrame.NineSlice)
        SafeSkin(LFGListInviteDialog)
        SafeSkin(LFGListInviteDialog and LFGListInviteDialog.Border)

        if PVPMatchScoreboard and PVPMatchScoreboard.HookScript then
            PVPMatchScoreboard:HookScript("OnShow", function()
                SUI:Skin(PVPMatchScoreboard, true)
            end)
        end

        -- Tabs
        SafeSkin(PVPScoreboardTab1)
        SafeSkin(PVPScoreboardTab2)
        SafeSkin(PVPScoreboardTab3)
    end
end
