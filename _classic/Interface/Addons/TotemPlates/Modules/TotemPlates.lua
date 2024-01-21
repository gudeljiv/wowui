local select, pairs, tremove, tinsert, format, strsplit, tonumber, ipairs = select, pairs, tremove, tinsert, format, strsplit, tonumber, ipairs
local UnitExists, UnitIsUnit, UnitIsEnemy, UnitGUID = UnitExists, UnitIsUnit, UnitIsEnemy, UnitGUID
local C_NamePlate = C_NamePlate
local Core = LibStub("TotemPlates")
local L = Core.L
local GetSpellInfo, CreateFrame = GetSpellInfo, CreateFrame
local totemData, npcIdToTotemData = Core:GetTotemData()

---------------------------------------------------

-- Option Helpers

---------------------------------------------------

local function GetTotemColorDefaultOptions()
    local defaultDB = {}
    local options = {}
    local indexedList = {}
    for k,v in pairs(totemData) do
        tinsert(indexedList, {name = k, id = v.id, color = v.color, texture = v.texture})
    end
    table.sort(indexedList, function (a, b)
        return a.name < b.name
    end)
    for i=1,#indexedList do
        defaultDB["totem" .. indexedList[i].id] = {color = indexedList[i].color, enabled = true, alpha = 0.6, customText = ""}
        options["npTotemsHideDisabledTotems"] = {
            order = 1,
            name = L["Hide Disabled Totem Plates"],
            desc = L["Hide Disabled Totem Plates"],
            type = "toggle",
            width = "full",
            get = function() return Core.dbi.profile.npTotemsHideDisabledTotems end,
            set = function(_, value)
                Core.dbi.profile.npTotemsHideDisabledTotems = value
                Core:UpdateFrame()
            end
        }
        options["totem" .. indexedList[i].id] = {
            order = i+1,
            name = select(1, GetSpellInfo(indexedList[i].id)),
            --inline = true,
            width  = "3.0",
            type = "group",
            icon = indexedList[i].texture,
            args = {
                headerTotemConfig = {
                    type = "header",
                    name = format("|T%s:20|t %s", indexedList[i].texture, select(1, GetSpellInfo(indexedList[i].id))),
                    order = 1,
                },
                enabled = {
                    order = 2,
                    name = L["Enabled"],
                    desc = "Enable " .. format("|T%s:20|t %s", indexedList[i].texture, select(1, GetSpellInfo(indexedList[i].id))),
                    type = "toggle",
                    width = "full",
                    get = function() return Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].enabled end,
                    set = function(_, value)
                        Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].enabled = value
                        Core:UpdateFrame()
                    end
                },
                color = {
                    type = "color",
                    name = L["Border color"],
                    desc = L["Color of the border"],
                    order = 3,
                    hasAlpha = true,
                    width = "full",
                    get = function()
                        return Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.r,
                        Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.g,
                        Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.b,
                        Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.a
                    end,
                    set = function(_, r, g, b, a)
                        Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.r,
                        Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.g,
                        Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.b,
                        Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.a = r, g, b, a
                        Core:UpdateFrame()
                    end,
                },
                alpha = {
                    type = "range",
                    name = L["Alpha"],
                    order = 4,
                    min = 0,
                    max = 1,
                    step = 0.1,
                    width = "full",
                    get = function()
                        return Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].alpha
                    end,
                    set = function(_, value)
                        Core.dbi.profile.npTotemColors["totem" .. indexedList[i].id].alpha = value
                        Core:UpdateFrame()
                    end
                },
                customText = {
                    type = "input",
                    name = L["Custom totem name"],
                    order = 5,
                    width = "full",
                    get = function() return Core.db.npTotemColors["totem" .. indexedList[i].id].customText end,
                    set = function(_, value) Core.db.npTotemColors["totem" .. indexedList[i].id].customText = value Core:UpdateFrame() end
                },
            }
        }
    end
    return defaultDB, options, indexedList
end

---------------------------------------------------

-- Core

---------------------------------------------------

local TotemPlates = Core:NewModule("Totem Plates", 2, {
    npTotems = true,
    npTotemsShowFriendly = true,
    npTotemsShowEnemy = true,
    npTotemPlatesBorderStyle = "Interface\\AddOns\\TotemPlates\\Images\\Border_rounded_blp",
    npTotemPlatesSize = 40,
    npTotemPlatesWidthFactor = 1,
    npTremorFont = "DorisPP",
    npTremorFontSize = 10,
    npTremorFontXOffset = 0,
    npTremorFontYOffset = 0,
    npTotemPlatesAlpha = 0.6,
    npTotemPlatesAlphaAlways = false,
    npTotemPlatesAlphaAlwaysTargeted = false,
    npTotemColors = select(1, GetTotemColorDefaultOptions()),
    npTotemsHideDisabledTotems = false,
})

function TotemPlates:Initialize()
    self.numChildren = 0
    self.activeTotemNameplates = {}
    self.totemPlateCache = {}
    if Core.db.npTotems then
        self:RegisterMessage("PLAYER_ENTERING_WORLD")
        self:RegisterMessage("NAME_PLATE_UNIT_ADDED")
        self:RegisterMessage("NAME_PLATE_UNIT_REMOVED")
        self:RegisterMessage("PLAYER_TARGET_CHANGED")
    end
    if Core.db.npTotems and Core.db.npTotemsShowEnemy then
        SetCVar("nameplateShowEnemyTotems", true);
    end
    if Core.db.npTotems and Core.db.npTotemsShowFriendly then
        SetCVar("nameplateShowFriendlyTotems", true);
    end
    self.addon = "Blizzard"
    if (IsAddOnLoaded("Plater")) then
        self.addon = "Plater"
    elseif (IsAddOnLoaded("Kui_Nameplates")) then
        self.addon = "Kui_Nameplates"
    elseif (IsAddOnLoaded("NeatPlates")) then
        self.addon = "NeatPlates"
    elseif (IsAddOnLoaded("TidyPlates_ThreatPlates")) then
        self.addon = "TidyPlates_ThreatPlates"
    elseif (IsAddOnLoaded("Tukui")) then
        local _, C, _ = Tukui:unpack()
        if C.NamePlates.Enable then
            self.addon = "Tukui"
        end
    elseif (IsAddOnLoaded("ElvUI")) then
        local E = unpack(ElvUI)
        if E.private.nameplates.enable then
            self.addon = "ElvUI"
        end
    end
end

---------------------------------------------------

-- Events

---------------------------------------------------

function TotemPlates:PLAYER_ENTERING_WORLD()
    self.numChildren = 0
    self.activeTotemNameplates = {}
end

function TotemPlates:PLAYER_TARGET_CHANGED()
    for k,nameplate in pairs(self.activeTotemNameplates) do
        TotemPlates:SetTotemAlpha(nameplate.totemPlateFrame, k)
    end
end

function TotemPlates:NAME_PLATE_UNIT_ADDED(unitID)
    self:OnUnitEvent(unitID)
end

function TotemPlates:NAME_PLATE_UNIT_REMOVED(unitID)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitID)
    self.activeTotemNameplates[unitID] = nil
    if nameplate.totemPlateFrame then
        nameplate.totemPlateFrame:Hide()
        nameplate.totemPlateFrame:SetParent(nil)
        tinsert(self.totemPlateCache, nameplate.totemPlateFrame)
        nameplate.totemPlateFrame = nil
    end
    if (self.addon == "ElvUI") then
        self:ToggleAddon(nameplate, true)
    end
end

---------------------------------------------------

-- TotemPlates Call

---------------------------------------------------

function TotemPlates:UpdateFrameOnce()
    if Core.db.npTotems then
        self:RegisterMessage("PLAYER_ENTERING_WORLD")
        self:RegisterMessage("NAME_PLATE_UNIT_ADDED")
        self:RegisterMessage("NAME_PLATE_UNIT_REMOVED")
        self:RegisterMessage("PLAYER_TARGET_CHANGED")
    else
        self:UnregisterAllMessages()
    end

    if Core.db.npTotems and Core.db.npTotemsShowEnemy then
        SetCVar("nameplateShowEnemyTotems", true);
    end
    if Core.db.npTotems and Core.db.npTotemsShowFriendly then
        SetCVar("nameplateShowFriendlyTotems", true);
    end

    for k,nameplate in pairs(self.activeTotemNameplates) do
        local totemDataEntry = nameplate.totemPlateFrame.totemDataEntry
        nameplate.totemPlateFrame:SetWidth(Core.db.npTotemPlatesSize * Core.db.npTotemPlatesWidthFactor)
        nameplate.totemPlateFrame:SetHeight(Core.db.npTotemPlatesSize)
        nameplate.totemPlateFrame.totemBorder:SetTexture(Core.db.npTotemPlatesBorderStyle)
        nameplate.totemPlateFrame.totemBorder:SetVertexColor(Core.db.npTotemColors["totem" .. totemDataEntry.id].color.r,
                Core.db.npTotemColors["totem" .. totemDataEntry.id].color.g,
                Core.db.npTotemColors["totem" .. totemDataEntry.id].color.b,
                Core.db.npTotemColors["totem" .. totemDataEntry.id].color.a)
        nameplate.totemPlateFrame.totemName:SetPoint("TOP", nameplate.totemPlateFrame, "BOTTOM", Core.db.npTremorFontXOffset, Core.db.npTremorFontYOffset)
        nameplate.totemPlateFrame.totemName:SetFont(Core:SMFetch("font", "npTremorFont"), Core.db.npTremorFontSize, "OUTLINE")
        nameplate.totemPlateFrame.totemName:SetText(Core.db.npTotemColors["totem" .. totemDataEntry.id].customText or "")
        self:SetTotemAlpha(nameplate.totemPlateFrame, k)

        if not Core.db.npTotems then
            nameplate.totemPlateFrame:Hide()
            self:ToggleAddon(nameplate, true)
        else
            nameplate.totemPlateFrame:Show()
            self:ToggleAddon(nameplate)
        end
        local isEnemy = UnitIsEnemy("player", nameplate.totemPlateFrame.unitID)
        if Core.db.npTotems and Core.db.npTotemsShowEnemy and isEnemy then
            nameplate.totemPlateFrame:Show()
            self:ToggleAddon(nameplate)
        elseif Core.db.npTotems and not Core.db.npTotemsShowEnemy and isEnemy then
            nameplate.totemPlateFrame:Hide()
            self:ToggleAddon(nameplate, true)
        end
        if Core.db.npTotems and Core.db.npTotemsShowFriendly and not isEnemy then
            nameplate.totemPlateFrame:Show()
            self:ToggleAddon(nameplate)
        elseif not Core.db.npTotemsShowFriendly and not isEnemy then
            nameplate.totemPlateFrame:Hide()
            self:ToggleAddon(nameplate, true)
        end
        if Core.db.npTotems and Core.db.npTotemColors["totem" .. totemDataEntry.id].enabled then
            nameplate.totemPlateFrame:Show()
            self:ToggleAddon(nameplate)
        end
        if Core.db.npTotems and not Core.db.npTotemColors["totem" .. totemDataEntry.id].enabled then
            nameplate.totemPlateFrame:Hide()
            self:ToggleAddon(nameplate, true)
        end
        if Core.db.npTotems and not Core.db.npTotemColors["totem" .. totemDataEntry.id].enabled and Core.db.npTotemsHideDisabledTotems then
            nameplate.totemPlateFrame:Hide()
            self:ToggleAddon(nameplate)
        end
    end
    for _,totemPlateFrame in ipairs(self.totemPlateCache) do
        totemPlateFrame:SetWidth(Core.db.npTotemPlatesSize * Core.db.npTotemPlatesWidthFactor)
        totemPlateFrame:SetHeight(Core.db.npTotemPlatesSize)
        totemPlateFrame.totemBorder:SetTexture(Core.db.npTotemPlatesBorderStyle)
        totemPlateFrame.totemName:SetFont(Core:SMFetch("font", "npTremorFont"), Core.db.npTremorFontSize, "OUTLINE")
        totemPlateFrame.totemName:SetPoint("TOP", totemPlateFrame, "BOTTOM", Core.db.npTremorFontXOffset, Core.db.npTremorFontYOffset)
    end
end

---------------------------------------------------

-- TotemPlates Frame

---------------------------------------------------

function TotemPlates:CreateTotemFrame(nameplate)
    nameplate.totemPlateFrame = CreateFrame("Frame")
    nameplate.totemPlateFrame:SetFrameLevel(1)
    nameplate.totemPlateFrame:SetIgnoreParentAlpha(true)
    nameplate.totemPlateFrame:SetWidth(Core.db.npTotemPlatesSize * Core.db.npTotemPlatesWidthFactor)
    nameplate.totemPlateFrame:SetHeight(Core.db.npTotemPlatesSize)
    nameplate.totemPlateFrame.totemIcon = nameplate.totemPlateFrame:CreateTexture(nil, "BACKGROUND")
    nameplate.totemPlateFrame.totemIcon:SetMask("Interface\\AddOns\\TotemPlates\\Images\\mask")
    nameplate.totemPlateFrame.totemIcon:ClearAllPoints()
    nameplate.totemPlateFrame.totemIcon:SetPoint("TOPLEFT", nameplate.totemPlateFrame, "TOPLEFT")
    nameplate.totemPlateFrame.totemIcon:SetPoint("BOTTOMRIGHT", nameplate.totemPlateFrame, "BOTTOMRIGHT")
    nameplate.totemPlateFrame.totemBorder = nameplate.totemPlateFrame:CreateTexture(nil, "BORDER")
    nameplate.totemPlateFrame.totemBorder:ClearAllPoints()
    nameplate.totemPlateFrame.totemBorder:SetPoint("TOPLEFT", nameplate.totemPlateFrame, "TOPLEFT")
    nameplate.totemPlateFrame.totemBorder:SetPoint("BOTTOMRIGHT", nameplate.totemPlateFrame, "BOTTOMRIGHT")
    nameplate.totemPlateFrame.totemBorder:SetTexture(Core.db.npTotemPlatesBorderStyle)
    nameplate.totemPlateFrame.totemName = nameplate.totemPlateFrame:CreateFontString(nil, "OVERLAY")
    nameplate.totemPlateFrame.totemName:SetFont(Core:SMFetch("font", "npTremorFont"), Core.db.npTremorFontSize, "OUTLINE")
    nameplate.totemPlateFrame.totemName:SetPoint("TOP", nameplate.totemPlateFrame, "BOTTOM", Core.db.npTremorFontXOffset, Core.db.npTremorFontYOffset)
    nameplate.totemPlateFrame.selectionHighlight = nameplate.totemPlateFrame:CreateTexture(nil, "OVERLAY")
    nameplate.totemPlateFrame.selectionHighlight:SetTexture("Interface/TargetingFrame/UI-TargetingFrame-BarFill")
    nameplate.totemPlateFrame.selectionHighlight:SetAlpha(0)
    nameplate.totemPlateFrame.selectionHighlight:SetBlendMode("ADD")
    nameplate.totemPlateFrame.selectionHighlight:SetIgnoreParentAlpha(true)
    nameplate.totemPlateFrame.selectionHighlight:SetPoint("TOPLEFT", nameplate.totemPlateFrame, "TOPLEFT", Core.db.npTotemPlatesSize/16, -Core.db.npTotemPlatesSize/16)
    nameplate.totemPlateFrame.selectionHighlight:SetPoint("BOTTOMRIGHT", nameplate.totemPlateFrame, "BOTTOMRIGHT", -Core.db.npTotemPlatesSize/16, Core.db.npTotemPlatesSize/16)
    nameplate.totemPlateFrame:SetScript('OnUpdate', TotemPlates.OnUpdate)
    nameplate.totemPlateFrame:SetScript("OnHide", function(self)
        self.parent = nil
        self:SetParent(nil)
    end)
end

---------------------------------------------------

-- Nameplate functions

---------------------------------------------------

function TotemPlates:GetAddonFrame(nameplate)
    if self.addon == "Blizzard" then
        if nameplate.UnitFrame then
            return nameplate.UnitFrame
        end
    elseif self.addon == "Plater" or self.addon == "Tukui" or self.addon == "ElvUI" then
        if nameplate.unitFrame then
            return nameplate.unitFrame
        end
    elseif self.addon == "Kui_Nameplates" then
        if nameplate.kui then
            return nameplate.kui
        end
    elseif self.addon == "NeatPlates" then
        if nameplate.extended or nameplate.carrier then
            return nameplate.extended , nameplate.carrier
        end
    elseif self.addon == "TidyPlates_ThreatPlates" then
        if nameplate.TPFrame then
            return nameplate.TPFrame
        end
    end
end



function TotemPlates:ToggleAddon(nameplate, show)
    local addonFrames = { self:GetAddonFrame(nameplate) }
    if addonFrames and #addonFrames > 0 then
        if show then
            for _, frame in ipairs(addonFrames) do
                if frame.UpdateAllElements then
                    frame:Show()
                    frame:UpdateAllElements("NAME_PLATE_UNIT_ADDED")
                else
                    frame:Show()
                end
            end
        else
            for _, frame in ipairs(addonFrames) do
                if frame.UpdateAllElements then
                    frame:UpdateAllElements("NAME_PLATE_UNIT_REMOVED")
                    frame:Hide()
                else
                    frame:Hide()
                end
            end
        end
    end
end

function TotemPlates.OnUpdate(self)
    if (UnitIsUnit("mouseover", self.unitID) or UnitIsUnit("target", self.unitID)) and Core.db.npTotemColors["totem" .. self.totemDataEntry.id].alpha > 0 then
        self.selectionHighlight:SetAlpha(.25)
    else
        self.selectionHighlight:SetAlpha(0)
    end
    if (TotemPlates.addon == "Plater" or TotemPlates.addon == "Tukui") and self.parent and self.parent.unitFrame then
        self.parent.unitFrame:Hide()
    end
end

function TotemPlates:OnUnitEvent(unitID)
    local isEnemy = UnitIsEnemy("player", unitID)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitID)
    if not nameplate then
        return
    end
    if not Core.db.npTotems then
        self:ToggleAddon(nameplate, true)
        return
    end
    if not Core.db.npTotemsShowEnemy and isEnemy then
        self:ToggleAddon(nameplate, true)
        return
    end
    if not Core.db.npTotemsShowFriendly and not isEnemy then
        self:ToggleAddon(nameplate, true)
        return
    end
    local npcType, _, _, _, _, npcId = strsplit("-", UnitGUID(unitID))
    if npcType ~= "Creature" then
        return
    end
    local totemDataEntry = npcIdToTotemData[tonumber(npcId)]
    if not totemDataEntry then
        return
    end
    if totemDataEntry and Core.db.npTotemColors["totem" .. totemDataEntry.id].enabled then-- modify this nameplates
        if #self.totemPlateCache > 0 then
            nameplate.totemPlateFrame = tremove(self.totemPlateCache, #self.totemPlateCache)
        else
            self:CreateTotemFrame(nameplate)
        end
        nameplate.totemPlateFrame.unitID = unitID
        nameplate.totemPlateFrame.totemDataEntry = totemDataEntry
        nameplate.totemPlateFrame.parent = nameplate
        nameplate.totemPlateFrame:SetParent(nameplate)
        nameplate.totemPlateFrame:ClearAllPoints()
        nameplate.totemPlateFrame:SetPoint("CENTER", nameplate, "CENTER", 0, 0)
        nameplate.totemPlateFrame.totemIcon:SetTexture(totemDataEntry.texture)
        nameplate.totemPlateFrame.totemBorder:SetVertexColor(Core.db.npTotemColors["totem" .. totemDataEntry.id].color.r,
                Core.db.npTotemColors["totem" .. totemDataEntry.id].color.g,
                Core.db.npTotemColors["totem" .. totemDataEntry.id].color.b,
                Core.db.npTotemColors["totem" .. totemDataEntry.id].color.a)
        nameplate.totemPlateFrame.totemName:SetText(Core.db.npTotemColors["totem" .. totemDataEntry.id].customText or "")
        nameplate.totemPlateFrame.parent = nameplate
        nameplate.totemPlateFrame:Show()
        TotemPlates:SetTotemAlpha(nameplate.totemPlateFrame, unitID)
        self:ToggleAddon(nameplate, false)
        self.activeTotemNameplates[unitID] = nameplate
    elseif totemDataEntry and not Core.db.npTotemColors["totem" .. totemDataEntry.id].enabled and Core.db.npTotemsHideDisabledTotems then
        if nameplate.totemPlateFrame then
            nameplate.totemPlateFrame:Hide()
            nameplate.totemPlateFrame:SetParent(nil)
            tinsert(self.totemPlateCache, nameplate.totemPlateFrame)
            nameplate.totemPlateFrame = nil
        end
        self:ToggleAddon(nameplate, false)
    else
        self:ToggleAddon(nameplate, true)
    end
end

function TotemPlates:SetTotemAlpha(totemPlateFrame, unitID)
    local targetExists = UnitExists("target")
    local totemDataEntry = totemPlateFrame.totemDataEntry
    if targetExists then
        if (UnitIsUnit(unitID, "target")) then -- is target
            if Core.db.npTotemPlatesAlphaAlwaysTargeted then
                totemPlateFrame:SetAlpha(Core.db.npTotemColors["totem" .. totemDataEntry.id].alpha)
            else
                totemPlateFrame:SetAlpha(1)
            end
        else -- is not target
            totemPlateFrame:SetAlpha(Core.db.npTotemColors["totem" .. totemDataEntry.id].alpha)
        end
    else -- no target
        if Core.db.npTotemPlatesAlphaAlways then
            totemPlateFrame:SetAlpha(Core.db.npTotemColors["totem" .. totemDataEntry.id].alpha)
        else
            totemPlateFrame:SetAlpha(0.95)
        end
    end
end

---------------------------------------------------

-- Test

---------------------------------------------------

function TotemPlates:TestOnce()
    if not self.testFrame then
        self.testFrame = CreateFrame("Frame", nil, UIParent)
        self.testFrame:SetWidth(1)
        self.testFrame:SetHeight(32)
        self.testFrame:SetPoint("CENTER", UIParent, "CENTER", 0, -140)
        self.testFrame:SetIgnoreParentScale(true)
    end
    local totemDataEntry = npcIdToTotemData[5913]
    self.testFrame:Show()
    if not self.testFrame.totemPlateFrame then
        if #self.totemPlateCache > 0 then
            self.testFrame.totemPlateFrame = tremove(self.totemPlateCache, #self.totemPlateCache)
        else
            self:CreateTotemFrame(self.testFrame)
            self.testFrame.totemPlateFrame:SetScript("OnHide", nil)
            self.testFrame.totemPlateFrame:SetScript("OnUpdate", nil)
        end
    end
    if Core.db.npTotems then
        self.testFrame.totemPlateFrame.unitID = "player"
        self.testFrame.totemPlateFrame.totemDataEntry = totemDataEntry
        self.testFrame.totemPlateFrame.parent = self.testFrame
        self.testFrame.totemPlateFrame:SetParent(self.testFrame)
        self.testFrame.totemPlateFrame:ClearAllPoints()
        self.testFrame.totemPlateFrame:SetPoint("CENTER", self.testFrame, "CENTER", 0, 0)
        self.testFrame.totemPlateFrame.totemIcon:SetTexture(totemDataEntry.texture)
        self.testFrame.totemPlateFrame.totemBorder:SetVertexColor(Core.db.npTotemColors["totem" .. totemDataEntry.id].color.r,
                Core.db.npTotemColors["totem" .. totemDataEntry.id].color.g,
                Core.db.npTotemColors["totem" .. totemDataEntry.id].color.b,
                Core.db.npTotemColors["totem" .. totemDataEntry.id].color.a)
        self.testFrame.totemPlateFrame.totemName:SetText(Core.db.npTotemColors["totem" .. totemDataEntry.id].customText or "")
        self.testFrame.totemPlateFrame.parent = self.testFrame
        self.testFrame.totemPlateFrame:Show()
        self.activeTotemNameplates["player"] = self.testFrame
    else
        self.testFrame.totemPlateFrame:Hide()
    end
end

function TotemPlates:Reset()
    if self.testFrame then
        if self.testFrame.totemPlateFrame then
            self.testFrame.totemPlateFrame:Hide()
            self.testFrame.totemPlateFrame:SetParent(nil)
            tinsert(self.totemPlateCache, self.testFrame.totemPlateFrame)
            self.testFrame.totemPlateFrame = nil
        end
        self.testFrame:Hide()
        self.activeTotemNameplates["player"] = nil
    end
end

---------------------------------------------------

-- Interface options

---------------------------------------------------

function TotemPlates:GetOptions()
    return {
        headerTotems = {
            type = "header",
            name = L["Totem Plates"],
            order = 2,
        },
        npTotems = Core:option({
            type = "toggle",
            name = L["Enabled"],
            desc = L["Turns totem icons instead of nameplates on or off."],
            order = 3,
            width = 0.9,
        }),
        npTotemsShowFriendly = Core:option({
            type = "toggle",
            name = L["Show friendly"],
            desc = L["Turns totem icons instead of nameplates on or off."],
            disabled = function() return not Core.db.npTotems end,
            order = 4,
            width = 0.65,
        }),
        npTotemsShowEnemy = Core:option({
            type = "toggle",
            name = L["Show enemy"],
            desc = L["Turns totem icons instead of nameplates on or off."],
            disabled = function() return not Core.db.npTotems end,
            order = 5,
            width = 0.6,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            disabled = function() return not Core.db.npTotems end,
            order = 4,
            args = {
                icon = {
                    type = "group",
                    name = L["Icon"],
                    order = 1,
                    args = {
                        header = {
                            type = "header",
                            name = L["Icon"],
                            order = 1,
                        },
                        npTotemPlatesSize = Core:option({
                            type = "range",
                            name = L["Totem size"],
                            desc = L["Size of totem icons"],
                            order = 5,
                            min = 20,
                            max = 100,
                            step = 1,
                            width = "full",
                        }),
                        npTotemPlatesWidthFactor = Core:option({
                            type = "range",
                            name = L["Icon Width Factor"],
                            desc = L["Stretches the icon"],
                            order = 6,
                            min = 0.5,
                            max = 2,
                            step = 0.05,
                            width = "full",
                        }),
                    },
                },
                font = {
                    type = "group",
                    name = L["Font"],
                    order = 2,
                    args = {
                        header = {
                            type = "header",
                            name = L["Font"],
                            order = 1,
                        },
                        npTremorFont = Core:option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the custom totem name"],
                            order = 11,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        npTremorFontSize = Core:option({
                            type = "range",
                            name = L["Size"],
                            desc = L["Scale of the font"],
                            order = 12,
                            min = 1,
                            max = 50,
                            step = 0.1,
                            width = "full",
                        }),
                        npTremorFontXOffset = Core:option({
                            type = "range",
                            name = L["Horizontal offset"],
                            desc = L["Scale of the font"],
                            order = 13,
                            min = -300,
                            max = 300,
                            step = 1,
                            width = "full",
                        }),
                        npTremorFontYOffset = Core:option({
                            type = "range",
                            name = L["Vertical offset"],
                            desc = L["Scale of the font"],
                            order = 14,
                            min = -300,
                            max = 300,
                            step = 1,
                            width = "full",
                        }),
                    },
                },
                alpha = {
                    type = "group",
                    name = L["Alpha"],
                    order = 4,
                    args = {
                        header = {
                            type = "header",
                            name = L["Alpha"],
                            order = 1,
                        },
                        npTotemPlatesAlphaAlways = Core:option({
                            type = "toggle",
                            name = L["Apply alpha when no target"],
                            desc = L["Always applies alpha, even when you don't have a target. Else it is 1."],
                            width = "full",
                            order = 21,
                        }),
                        npTotemPlatesAlphaAlwaysTargeted = Core:option({
                            type = "toggle",
                            name = L["Apply alpha when targeted"],
                            desc = L["Always applies alpha, even when you target the totem. Else it is 1."],
                            width = "full",
                            order = 22,
                        }),
                        npAllTotemAlphas = {
                            type = "range",
                            name = L["All totem border alphas (configurable per totem)"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            width = "full",
                            order = 23,
                            get = function()
                                local alpha, i = nil, 1
                                for _,v in pairs(Core.dbi.profile.npTotemColors) do
                                    if i == 1 then
                                        alpha = v.alpha
                                        i = i + 1
                                    else
                                        if v.alpha ~= alpha then
                                            return ""
                                        end
                                    end
                                end
                                return alpha
                            end,
                            set = function(_, value)
                                for _,v in pairs(Core.dbi.profile.npTotemColors) do
                                    v.alpha = value
                                end
                                Core:UpdateFrame()
                            end,
                        },
                    },
                },
                border = {
                    type = "group",
                    name = L["Border"],
                    order = 5,
                    args = {
                        header = {
                            type = "header",
                            name = L["Border"],
                            order = 1,
                        },
                        npTotemPlatesBorderStyle = Core:option({
                            type = "select",
                            name = L["Totem icon border style"],
                            order = 41,
                            values = Core:GetIconStyles()
                        }),
                        npAllTotemColors = {
                            type = "color",
                            name = L["All totem border color"],
                            order = 42,
                            hasAlpha = true,
                            get = function()
                                local color
                                local i = 1
                                for _,v in pairs(Core.dbi.profile.npTotemColors) do
                                    if i == 1 then
                                        color = v.color
                                        i = i + 1
                                    else
                                        if v.color.r ~= color.r or v.color.g ~= color.g or v.color.b ~= color.b or v.color.a ~= color.a then
                                            return 0, 0, 0, 0
                                        end
                                    end
                                end
                                return color.r, color.g, color.b, color.a
                            end,
                            set = function(_, r, g, b, a)
                                for _,v in pairs(Core.dbi.profile.npTotemColors) do
                                    v.color.r = r
                                    v.color.g = g
                                    v.color.b = b
                                    v.color.a = a
                                end
                                Core:UpdateFrame()
                            end,
                        },
                    },
                },
            },
        },
        npTotemColors = {
            order = 50,
            name = L["Customize Totems"],
            type = "group",
            childGroups = "tree",
            disabled = function() return not Core.db.npTotems end,
            args = select(2, GetTotemColorDefaultOptions())
        },
    }
end