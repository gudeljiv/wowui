local select, string_gsub, tostring, pairs, ipairs = select, string.gsub, tostring, pairs, ipairs

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local AURA_TYPE_DEBUFF = AURA_TYPE_DEBUFF
local AURA_TYPE_BUFF = AURA_TYPE_BUFF

local UnitName, UnitAura, UnitRace, UnitClass, UnitGUID, UnitIsUnit, UnitExists = UnitName, UnitAura, UnitRace, UnitClass, UnitGUID, UnitIsUnit, UnitExists
local UnitCastingInfo, UnitChannelInfo = UnitCastingInfo, UnitChannelInfo
local GetSpellInfo = GetSpellInfo
local FindAuraByName = AuraUtil.FindAuraByName
local GetTime = GetTime

local Core = LibStub("TotemPlates")
local L = Core.L

local EventListener = Core:NewModule("EventListener", 100, {
    test = true,
})

function EventListener:Initialize()
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:RegisterEvent("UNIT_NAME_UPDATE")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:SetScript("OnEvent", self.OnEvent)
end

function EventListener:OnEvent(event, ...)
    self[event](self, ...)
end

function EventListener:UpdateFrameOnce()
    if Core.db.npTotems or Core.db.totemPulseEnabled then
        self:RegisterEvent("PLAYER_ENTERING_WORLD")
        self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
        self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
        self:RegisterEvent("PLAYER_TARGET_CHANGED")
        self:RegisterEvent("UNIT_NAME_UPDATE")
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    end
    if not Core.db.npTotems and not Core.db.totemPulseEnabled then
        self:UnregisterAllEvents("PLAYER_ENTERING_WORLD")
    end
end

function EventListener:PLAYER_ENTERING_WORLD()
    Core:SendMessage("PLAYER_ENTERING_WORLD")
end

function EventListener:NAME_PLATE_UNIT_ADDED(unit)
    Core:SendMessage("NAME_PLATE_UNIT_ADDED", unit)
end

function EventListener:NAME_PLATE_UNIT_REMOVED(unit)
    Core:SendMessage("NAME_PLATE_UNIT_REMOVED", unit)
end

function EventListener:PLAYER_TARGET_CHANGED()
    Core:SendMessage("PLAYER_TARGET_CHANGED")
end

function EventListener:UNIT_NAME_UPDATE(unit)
    Core:SendMessage("UNIT_NAME_UPDATE", unit)
end

function EventListener:COMBAT_LOG_EVENT_UNFILTERED()
    local _,eventType,_,sourceGUID,_,_,_,destGUID,_,_,_,spellID,spellName = CombatLogGetCurrentEventInfo()
    Core:SendMessage("COMBAT_LOG_EVENT_UNFILTERED", eventType, sourceGUID, destGUID, spellID, spellName)
end