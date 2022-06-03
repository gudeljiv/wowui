local UnitExists = UnitExists

local weaktable = {__mode = "k"}
local aggroHighlights = setmetatable({}, weaktable)

local UnitThreatSituation = _G.UnitThreatSituation

local function GetThreatStatusColor(statusIndex)
    if statusIndex == 0 then
        return 0.69, 0.69, 0.69
    end

    if statusIndex == 1 then
        return 1, 1, 0.47
    end

    if statusIndex == 2 then
        return 1, 0.6, 0
    end

    if statusIndex == 3 then
        return 1, 0, 0
    end
end

local function CompactUnitFrame_UpdateAggroHighlight(frame)
    local aggroHighlight = aggroHighlights[frame]

    if not aggroHighlight then
        return
    end

    local displayedUnit = frame.displayedUnit

    if not UnitExists(displayedUnit) or displayedUnit:find("target$") then
        aggroHighlight:Hide()
        return
    end

    local status = UnitThreatSituation(displayedUnit)

    if status and status > 0 then
        aggroHighlight:SetVertexColor(GetThreatStatusColor(status))
        aggroHighlight:Show()
    else
        aggroHighlight:Hide()
    end
end

do
    local function getTexture(frame, name)
        while not frame:GetName() do
            frame = frame:GetParent()
        end

        name = name and string.gsub(name, "%$parent", frame:GetName())
        return name and _G[name]
    end

    local function createTexture(frame, name, layer, subLayer)
        return getTexture(frame, name) or frame:CreateTexture(name, layer, nil, subLayer)
    end

    local texCoords = {
        ["Raid-AggroFrame"] = {0.00781250, 0.55468750, 0.00781250, 0.27343750}
    }

    local function setUpFunc(frame)
        if frame:IsForbidden() or aggroHighlights[frame] then
            return
        end

        aggroHighlights[frame] = createTexture(frame, "$parentAggroHighlight", "ARTWORK")
        aggroHighlights[frame]:SetTexture("Interface\\RaidFrame\\Raid-FrameHighlights")
        aggroHighlights[frame]:SetTexCoord(unpack(texCoords["Raid-AggroFrame"]))
        aggroHighlights[frame]:SetAllPoints(frame)
    end

    hooksecurefunc("DefaultCompactUnitFrameSetup", setUpFunc)
    hooksecurefunc("DefaultCompactMiniFrameSetup", setUpFunc)

    local compactRaidFrameReservation_GetFrame

    hooksecurefunc(
        "CompactRaidFrameReservation_GetFrame",
        function(self, key)
            compactRaidFrameReservation_GetFrame = self.reservations[key]
        end
    )

    local frameCreationSpecifiers = {
        raid = {mapping = UnitGUID, setUpFunc = setUpFunc},
        pet = {setUpFunc = setUpFunc},
        flagged = {mapping = UnitGUID, setUpFunc = setUpFunc},
        target = {setUpFunc = setUpFunc}
    }

    hooksecurefunc(
        "CompactRaidFrameContainer_GetUnitFrame",
        function(self, unit, frameType)
            if not compactRaidFrameReservation_GetFrame then
                local info = frameCreationSpecifiers[frameType]
                local mapping

                if info.mapping then
                    mapping = info.mapping(unit)
                else
                    mapping = unit
                end

                local frame = self.frameReservations[frameType].reservations[mapping]
                info.setUpFunc(frame)
            end
        end
    )
end

hooksecurefunc(
    "CompactUnitFrame_OnEvent",
    function(self, event, ...)
        if event == self.updateAllEvent and (not self.updateAllFilter or self.updateAllFilter(self, event, ...)) then
            return
        end

        local unit = ...

        if unit == self.unit or unit == self.displayedUnit then
            if event == "UNIT_THREAT_SITUATION_UPDATE" then
                CompactUnitFrame_UpdateAggroHighlight(self)
            end
        end
    end
)

hooksecurefunc("CompactUnitFrame_UpdateAll", CompactUnitFrame_UpdateAggroHighlight)

hooksecurefunc(
    "CompactUnitFrame_UpdateUnitEvents",
    function(frame)
        if not aggroHighlights[frame] then
            return
        end

        local unit = frame.unit
        local displayedUnit

        if unit ~= frame.displayedUnit then
            displayedUnit = frame.displayedUnit
        end

        frame:RegisterUnitEvent("UNIT_THREAT_SITUATION_UPDATE", unit, displayedUnit)
    end
)

hooksecurefunc(
    "CompactPartyFrame_Generate",
    function()
        local name = CompactPartyFrame:GetName()

        for i = 1, MEMBERS_PER_RAID_GROUP do
            local frame = _G[name .. "Member" .. i]

            if frame.unit then
                CompactUnitFrame_UpdateUnitEvents(frame)
            end
        end
    end
)
