local Module = SUI:NewModule("Maps.Hide");

function Module:OnEnable()
    local db = SUI.db.profile.maps
    local isAddOnLoaded = C_AddOns and C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
    local function SafeHide(frame)
        if frame and frame.Hide then
            frame:Hide()
        end
    end
    local function SafeUnregisterAllEvents(frame)
        if frame and frame.UnregisterAllEvents then
            frame:UnregisterAllEvents()
        end
    end

    if not (isAddOnLoaded and isAddOnLoaded("SexyMap")) then
        if not db.date then
            SafeUnregisterAllEvents(GameTimeFrame)
            SafeHide(GameTimeFrame)
        end
        if not db.tracking then
            local tracking = MinimapCluster and MinimapCluster.Tracking
            local trackingButton = (tracking and tracking.Button) or _G.MiniMapTrackingButton
            local trackingFrame = _G.MiniMapTracking or _G.MiniMapTrackingFrame

            SafeUnregisterAllEvents(trackingButton)
            SafeHide(trackingButton)
            SafeHide(tracking and tracking.Background)
            SafeUnregisterAllEvents(trackingFrame)
            SafeHide(trackingFrame)
        end
        if not db.clock then
            SafeHide(TimeManagerClockButton)
            SafeHide(TimeManagerClockTicker)
        end

        local Hide = CreateFrame("Frame")
        Hide:RegisterEvent("ADDON_LOADED")
        Hide:RegisterEvent("PLAYER_LOGIN")
        Hide:RegisterEvent("PLAYER_ENTERING_WORLD")
        Hide:RegisterEvent("VARIABLES_LOADED")
        Hide:SetScript("OnEvent", function()
            SafeHide(MinimapCluster and MinimapCluster.BorderTop)
        end)
    end
end
