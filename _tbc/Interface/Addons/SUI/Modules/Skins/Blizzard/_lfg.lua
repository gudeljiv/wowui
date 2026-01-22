local Module = SUI:NewModule("Skins.LFG");

function Module:OnEnable()
    if (SUI:Color()) then
        local function SafeSkin(frame)
            if frame then
                SUI:Skin(frame, true)
            end
        end

        SafeSkin(PVEFrame)
        SafeSkin(PVEFrame and PVEFrame.shadows)
        SafeSkin(PVEFrame and PVEFrame.NineSlice)
        SafeSkin(LFGListFrame and LFGListFrame.SearchPanel and LFGListFrame.SearchPanel.ResultsInset)
        SafeSkin(LFGListFrame and LFGListFrame.SearchPanel and LFGListFrame.SearchPanel.ResultsInset and LFGListFrame.SearchPanel.ResultsInset.NineSlice)
        SafeSkin(PVEFrameLeftInset)
        SafeSkin(PVEFrameLeftInset and PVEFrameLeftInset.NineSlice)
        SafeSkin(LFDParentFrameInset)
        SafeSkin(LFDParentFrameInset and LFDParentFrameInset.NineSlice)
        SafeSkin(RaidFinderFrameRoleInset)
        SafeSkin(RaidFinderFrameRoleInset and RaidFinderFrameRoleInset.NineSlice)
        SafeSkin(RaidFinderFrameBottomInset)
        SafeSkin(RaidFinderFrameBottomInset and RaidFinderFrameBottomInset.NineSlice)
        SafeSkin(LFGListFrame)
        SafeSkin(LFGListFrame and LFGListFrame.CategorySelection)
        SafeSkin(LFGListFrame and LFGListFrame.CategorySelection and LFGListFrame.CategorySelection.Inset)
        SafeSkin(LFGListFrame and LFGListFrame.CategorySelection and LFGListFrame.CategorySelection.Inset and LFGListFrame.CategorySelection.Inset.NineSlice)
        SafeSkin(LFGListFrame and LFGListFrame.ApplicationViewer)
        SafeSkin(LFGListFrame and LFGListFrame.ApplicationViewer and LFGListFrame.ApplicationViewer.Inset)
        SafeSkin(LFGListFrame and LFGListFrame.ApplicationViewer and LFGListFrame.ApplicationViewer.Inset and LFGListFrame.ApplicationViewer.Inset.NineSlice)
        SafeSkin(LFGListFrame and LFGListFrame.EntryCreation)
        SafeSkin(LFGListFrame and LFGListFrame.EntryCreation and LFGListFrame.EntryCreation.Inset)
        SafeSkin(LFGListFrame and LFGListFrame.EntryCreation and LFGListFrame.EntryCreation.Inset and LFGListFrame.EntryCreation.Inset.NineSlice)
        SafeSkin(LFGListFrame and LFGListFrame.ApplicationViewer and LFGListFrame.ApplicationViewer.NameColumnHeader)
        SafeSkin(LFGListFrame and LFGListFrame.ApplicationViewer and LFGListFrame.ApplicationViewer.RoleColumnHeader)
        SafeSkin(LFGListFrame and LFGListFrame.ApplicationViewer and LFGListFrame.ApplicationViewer.ItemLevelColumnHeader)
        SafeSkin(LFGApplicationViewerRatingColumnHeader)
        SafeSkin(LFDRoleCheckPopup)
        SafeSkin(LFDRoleCheckPopup and LFDRoleCheckPopup.Border)
        SafeSkin(PVPReadyDialog)
        SafeSkin(PVPReadyDialog and PVPReadyDialog.Border)

        local f = CreateFrame("Frame")
        f:RegisterEvent("ADDON_LOADED")
        f:SetScript("OnEvent", function(self, event, name)
            if name == "Blizzard_PVPUI" then
                SafeSkin(PlunderstormFrame and PlunderstormFrame.Inset)
                SafeSkin(PlunderstormFrame and PlunderstormFrame.Inset and PlunderstormFrame.Inset.NineSlice)
            end
        end)

        local textures = {
            LFDQueueFrameBackground,
            LFDParentFrameRoleBackground,
            PVEFrameTopFiligree,
            PVEFrameBottomFiligree,
            PVEFrameBlueBg,
        }
        local filtered = {}
        for _, texture in ipairs(textures) do
            if texture then
                table.insert(filtered, texture)
            end
        end
        if #filtered > 0 then
            SUI:Skin(filtered, true, true)
        end

        -- Tabs
        SafeSkin(PVEFrameTab1)
        SafeSkin(PVEFrameTab2)
        SafeSkin(PVEFrameTab3)
        SafeSkin(PVEFrameTab4)
    end
end
