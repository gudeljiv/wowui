local Module = SUI:NewModule("Skins.Quest");

function Module:OnEnable()
    if (SUI:Color()) then
        local function SafeSkin(frame)
            if frame then
                SUI:Skin(frame, true)
            end
        end

        SafeSkin(QuestFrame)
        SafeSkin(QuestFrame and QuestFrame.NineSlice)
        SafeSkin(QuestFrameInset)
        SafeSkin(QuestFrameInset and QuestFrameInset.NineSlice)
        SafeSkin(QuestLogPopupDetailFrame)
        SafeSkin(QuestLogPopupDetailFrame and QuestLogPopupDetailFrame.NineSlice)
        SafeSkin(ObjectiveTrackerFrame)
        SafeSkin(ObjectiveTrackerFrame and ObjectiveTrackerFrame.Header)
        SafeSkin(CampaignQuestObjectiveTracker)
        SafeSkin(CampaignQuestObjectiveTracker and CampaignQuestObjectiveTracker.Header)
        SafeSkin(QuestObjectiveTracker)
        SafeSkin(QuestObjectiveTracker and QuestObjectiveTracker.Header)
        SafeSkin(ProfessionsRecipeTracker)
        SafeSkin(ProfessionsRecipeTracker and ProfessionsRecipeTracker.Header)
        SafeSkin(ScenarioObjectiveTracker)
        SafeSkin(ScenarioObjectiveTracker and ScenarioObjectiveTracker.Header)

        local textures = {
            QuestNPCModelTopBorder,
            QuestNPCModelRightBorder,
            QuestNPCModelTopRightCorner,
            QuestNPCModelBottomRightCorner,
            QuestNPCModelBottomBorder,
            QuestNPCModelBottomLeftCorner,
            QuestNPCModelLeftBorder,
            QuestNPCModelTopLeftCorner,
            QuestNPCModelTextTopBorder,
            QuestNPCModelTextRightBorder,
            QuestNPCModelTextTopRightCorner,
            QuestNPCModelTextBottomRightCorner,
            QuestNPCModelTextBottomBorder,
            QuestNPCModelTextBottomLeftCorner,
            QuestNPCModelTextLeftBorder,
            QuestNPCModelTextTopLeftCorner
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
    end
end
