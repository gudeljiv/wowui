local LibDBIcon = LibStub("LibDBIcon-1.0")
local Module = SUI:NewModule("Maps.Minimap");

function Module:OnEnable()

    local db = {
        maps = SUI.db.profile.maps,
        queueicon = SUI.db.profile.edit.queueicon
    }
    local isAddOnLoaded = C_AddOns and C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

    if db then
        if not (isAddOnLoaded and isAddOnLoaded("SexyMap")) then
            if db.maps.buttons then
                local EventFrame = CreateFrame("Frame")
                EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
                EventFrame:SetScript("OnEvent", function()
                    local buttons = LibDBIcon:GetButtonList()
                    for i = 1, #buttons do
                        LibDBIcon:ShowOnEnter(buttons[i], true)
                    end
                end)
            end
        end

        local function GetQueueStatusButton()
            return _G.QueueStatusButton or _G.MiniMapLFGFrame
        end

        local function QueueStatusButton_Reposition()
            if isAddOnLoaded and isAddOnLoaded("EditModeExpanded") then return end
            local queueButton = GetQueueStatusButton()
            if not queueButton then return end
            queueButton:SetParent(UIParent)
            queueButton:SetFrameLevel(1)
            queueButton:SetScale(0.8, 0.8)
            queueButton:ClearAllPoints()
            queueButton:SetPoint(db.queueicon.point, UIParent, db.queueicon.point, db.queueicon.x, db.queueicon.y)
        end
        
        local queueButton = GetQueueStatusButton()
        if queueButton and queueButton.UpdatePosition then
            hooksecurefunc(queueButton, "UpdatePosition", QueueStatusButton_Reposition)
        elseif queueButton and queueButton.HookScript then
            queueButton:HookScript("OnShow", QueueStatusButton_Reposition)
        end
        QueueStatusButton_Reposition()
    end
end
