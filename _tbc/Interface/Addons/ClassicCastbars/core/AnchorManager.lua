local _, namespace = ...
local AnchorManager = {}
namespace.AnchorManager = AnchorManager

local anchors = {
    target = {
        "SUFUnittarget",
        "XPerl_Target",
        "Perl_Target_Frame",
        "ElvUF_Target",
        "oUF_TukuiTarget",
        "btargetUnitFrame",
        "DUF_TargetFrame",
        "GwTargetUnitFrame",
        "PitBull4_Frames_Target",
        "oUF_Target",
        "SUI_targetFrame",
        "gUI4_UnitTarget",
        "oUF_Adirelle_Target",
        "oUF_AftermathhTarget",
        "LUFUnittarget",
        "oUF_LumenTarget",
        "TukuiTargetFrame",
        "CG_UnitFrame_2",
        "TargetFrame", -- Blizzard frame should always be last
    },

    party = {
        "SUFHeaderpartyUnitButton%d",
        "XPerl_party%d",
        "ElvUF_PartyGroup1UnitButton%d",
        "TukuiPartyUnitButton%d",
        "DUF_PartyFrame%d",
        "PitBull4_Groups_PartyUnitButton%d",
        "oUF_Raid%d",
        "GwPartyFrame%d",
        "gUI4_GroupFramesGroup5UnitButton%d",
        "PartyMemberFrame%d",
        "CompactRaidFrame%d",
        "CompactPartyFrameMember%d",
        "CompactRaidGroup1Member%d",
    },

    --@version-bcc@
    focus = {
        "SUFUnitfocus",
        "XPerl_Focushighlight",
        "ElvUF_Focus",
        "oUF_TukuiFocus",
        "bfocusUnitFrame",
        "DUF_FocusFrame",
        "GwFocusUnitFrame",
        "PitBull4_Frames_Focus",
        "oUF_Focus",
        "SUI_focusFrame",
        "gUI4_UnitFocus",
        "oUF_Adirelle_Focus",
        "Stuf.units.focus",
        "oUF_AftermathhFocus",
        "LUFUnitfocus",
        "oUF_LumenFocus",
        "FocusFrame",
    },

    arena = {
        "ElvUF_Arena%d",
        "oUF_TukuiArena%d",
        "barena%dUnitFrame",
        "oUF_Arena%d",
        "oUF_Adirelle_Arena%d",
        "Stuf.units.arena%d",
        "sArenaEnemyFrame%d",
        "oUF_LumenArena%d",
        "ArenaEnemyFrame%d",
    },
    --@end-version-bcc@
}

local _G = _G
local strmatch = _G.string.match
local strfind = _G.string.find
local gsub = _G.string.gsub
local UnitGUID = _G.UnitGUID
local GetNamePlateForUnit = _G.C_NamePlate.GetNamePlateForUnit
local GetNumGroupMembers = _G.GetNumGroupMembers

local function GetUnitFrameForUnit(unitType, unitID, hasNumberIndex)
    local anchorNames = anchors[unitType]
    if not anchorNames then return end

    for i = 1, #anchorNames do
        local name = anchorNames[i]
        if hasNumberIndex then
            name = format(name, strmatch(unitID, "%d+")) -- add unit index to unitframe name
        end

        local unitFrame = _G[name]
        if unitFrame then
            if unitType == "party" or unitType == "arena" then
                return unitFrame, name
            end

            if unitFrame:IsVisible() then -- unit frame exists and also is in use (for party/arena we need to ignore this check)
                return unitFrame, name
            end
        end
    end
end

local function GetPartyFrameForUnit(unitID)
    if unitID == "party-testmode" then
        return GetUnitFrameForUnit("party", "party1", true)
    end

    -- Dont show party castbars in raid
    if GetNumGroupMembers() > 5 then return end

    local guid = UnitGUID(unitID)
    if not guid then return end

    local useCompact = GetCVarBool("useCompactPartyFrames")

    -- raid frames are recycled so frame10 might be party2 and so on, so we need
    -- to loop through them all and check if the unit matches. Same thing with party
    -- frames for custom addons
    for i = 1, 40 do
        local frame, frameName = GetUnitFrameForUnit("party", "party"..i, true)
        if frame and ((frame.unit and UnitGUID(frame.unit) == guid) or frame.lastGUID == guid) and frame:IsShown() then
            if useCompact then
                if strfind(frameName, "PartyMemberFrame") == nil then
                    return frame
                end
            else
                return frame
            end
        end
    end
end

local anchorCache = {
    player = UIParent,  -- special case for player/focus casting bar
    focus = (_G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC) and UIParent or nil,
    target = nil, -- will be set later
}

function AnchorManager:GetAnchor(unitID)
    if anchorCache[unitID] then
        return anchorCache[unitID]
    end

    local unitType, count = gsub(unitID, "%d", "") -- party1 -> party etc

    local frame
    if unitType == "nameplate" then
        frame = GetNamePlateForUnit(unitID)
    elseif unitID == "nameplate-testmode" then
        frame = GetNamePlateForUnit("target")
    elseif unitType == "party" or unitType == "party-testmode" then
        frame = GetPartyFrameForUnit(unitID)
    elseif unitType == "arena-testmode" then
        frame = GetUnitFrameForUnit("arena", "arena1", true)
    else -- target/focus
        frame = GetUnitFrameForUnit(unitType, unitID, count > 0)
    end

    if frame and unitType == "target" then
        anchors[unitID] = nil
        anchorCache[unitID] = frame
    end

    if _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_CLASSIC then
        if frame and unitType == "focus" then
            anchors[unitID] = nil
            anchorCache[unitID] = frame
        end
    end

    return frame
end
