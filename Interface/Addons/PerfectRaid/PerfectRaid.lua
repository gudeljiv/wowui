--[[-------------------------------------------------------------------------
  Copyright (c) 2006, Jim Whitehead II <cladhaire@gmail.com>
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

      * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
      * Redistributions in binary form must reproduce the above
        copyright notice, this list of conditions and the following
        disclaimer in the documentation and/or other materials provided
        with the distribution.
      * Neither the name of PerfectRaid nor the names of its contributors
        may be used to endorse or promote products derived from this software
        without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
---------------------------------------------------------------------------]]

local frames = {}
local unavail = {}
local aggro = {}

assert(DongleStub, string.format("PerfectRaid requires DongleStub."))

local L = PerfectRaidLocals
local utils
PerfectRaid = {}
PerfectRaid.rev = tonumber(string.match("$Revision$", "(%d+)") or 1)

-- This needs to be visible elsewhere
local OnAttributeChanged

function PerfectRaid:Initialize()
	self.frames = frames
	self.aggro = aggro

	local class = select(2, UnitClass("player"))

	self.defaults = {
		profile = {
			headers = {
				["*"] = {
					manaheight = 0,
					showRaid = true,
				},
			},
			positions = {},
			hideparty = true,
			showmanaonly = true,
			clickcast = true,
			locked = false,
			showraidicons = true,
			raidiconposition = "MHBAR",
			showroles = true,
			showroletank = true,
			highlight = {
				mouseover = true,
				tooltip = false,
				curse = (class == "DRUID" or class == "MAGE"),
				disease = (class == "PRIEST" or class == "PALADIN" or class == "SHAMAN"),
				magic = (class == "PRIEST" or class == "PALADIN"),
				poison = (class == "DRUID" or class == "PALADIN" or class == "SHAMAN"),
			},
		},
	}

	if not ClickCastFrames then
		ClickCastFrames = {}
	end

	utils = self.utils
end

function PerfectRaid:Enable()
	self.db = self:InitializeDB("PerfectRaidDB", self.defaults)
	self.db.global.sv_version = self.rev

	self:RegisterEvent("GROUP_ROSTER_UPDATE")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("UNIT_MAXHEALTH")
	self:RegisterEvent("UNIT_POWER_UPDATE")
	self:RegisterEvent("UNIT_MAXPOWER", "UNIT_MAXPOWER")
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("PLAYER_ALIVE", function() self:UNIT_HEALTH("UNIT_HEALTH", "player") end)
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "FullUpdate")

	-- Create our raid frames
	self:UpdateRaidFrames()
end

function PerfectRaid:UpdateRaidFrames()
	-- Hide all existing raid frames, in case we deleted one
	if not InCombatLockdown() then
		local idx = 1
		repeat
			local name = "PRHeader"..idx
			local header = getglobal(name)
			if header then
				header:Hide()
			end
			idx = idx + 1
		until not header
	end

	-- Create our raid frames
	for idx,entry in ipairs(self.db.profile.headers) do
		self:CreateRaidFrame(idx)
	end
end

function PerfectRaid:SavePosition(name)
    local f = getglobal(name)
    local x,y = f:GetLeft(), f:GetTop()
    local s = f:GetEffectiveScale()

    x,y = x*s,y*s

	local opt = self.db.profile.positions[name]
	if not opt then
		self.db.profile.positions[name] = {}
		opt = self.db.profile.positions[name]
	end
    opt.PosX = x
    opt.PosY = y
end

function PerfectRaid:RestorePosition(name)
	local f = getglobal(name)
	local opt = self.db.profile.positions[name]
	if not opt then
		self.db.profile.positions[name] = {}
		opt = self.db.profile.positions[name]
	end

	local x = opt.PosX
	local y = opt.PosY

    local s = f:GetEffectiveScale()

    if not x or not y then
        f:ClearAllPoints()
        f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
        return
    end

    x,y = x/s,y/s

    f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end

local function OnDragStart(frame)
	local parent = frame.dragparent
	if not PerfectRaid.db.profile.locked then
		parent:StartMoving()
		PerfectRaid.moving = parent
        PerfectRaid.movingButton = frame
	end
end

local function OnDragStop(frame)
	local parent = frame.dragparent
	parent:StopMovingOrSizing()
	PerfectRaid:SavePosition(parent:GetName())
	PerfectRaid.moving = nil
    PerfectRaid.movingButton = nil
end

function PerfectRaid:CreateRaidFrame(idx)
	local options = self.db.profile.headers[idx]
	local name = "PRHeader"..idx
	local template = "SecureGroupHeaderTemplate"

	local frame = getglobal(name)

	if not frame then
		frame = CreateFrame("Frame", name, UIParent, template)
		frame.title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")

		frame.title:SetPoint("BOTTOM", frame, "TOP", 0, 3)

		frame.backdrop = {
			bgFile = "Interface\\AddOns\\PerfectRaid\\images\\bgFile",
			tile = true, tileSize = 32,
			edgeFile = "Interface\\AddOns\\PerfectRaid\\images\\edgeFile",
			edgeSize = 16,
			insets = {
				left = 6,
				right = 5,
				top = 6,
				bottom = 5
			},
		}

	end

	-- Position backdrop
	frame.idx = idx
	frame.title:SetText(options.title or "")

	if options.disabled then
		frame:Hide()
		return
	end

	if options.hBackdrop then
		frame:SetBackdrop(frame.backdrop)
		frame:SetBackdropColor(0,0,0,.7)
		frame:SetBackdropBorderColor(0,0,0,.7)
	else
		frame:SetBackdrop(nil)
	end

	local yoffset = options.alignbottom and 1 or -1

	-- Set the frame's scale
	frame:SetScale(options.scale)

	frame:SetAttribute("point", options.alignbottom and "BOTTOM" or "TOP")
	frame:SetAttribute("groupFilter", options.filter or "")
	frame:SetAttribute("template", "SecureUnitButtonTemplate")
	frame:SetAttribute("templateType", "Button")
	frame:SetAttribute("yOffset", yoffset)
	frame:SetAttribute("sortMethod", options.sortType)
	frame:SetAttribute("strictFiltering", options.strict)
	frame:SetAttribute("groupBy", options.groupBy)
	local groupOrder
	if options.groupBy == "CLASS" then
		groupOrder="WARRIOR,DEATHKNIGHT,PRIEST,DRUID,SHAMAN,MONK,PALADIN,MAGE,ROGUE,WARLOCK,HUNTER"
	elseif options.groupBy == "GROUP" then
		groupOrder="1,2,3,4,5,6,7,8"
	end
	frame:SetAttribute("groupingOrder", groupOrder)
	frame:SetAttribute("maxColumns", options.numColumns)
	frame:SetAttribute("unitsPerColumn", options.maxUnits)
	frame:SetAttribute("columnSpacing", options.colSpacing)
	frame:SetAttribute("columnAnchorPoint", options.colAnchor)
	frame:SetAttribute("showParty", options.showParty)
	frame:SetAttribute("showRaid", options.showRaid)
	frame:SetAttribute("showPlayer", options.showPlayer)
	frame:SetAttribute("showSolo", options.showSolo)

	frame.dragparent = dragparent or frame
	frame.initialConfigFunction = PerfectRaid.ConfigureButton
    frame:SetAttribute("initialConfigFunction", [===[
        local header = self:GetParent()
        self:SetAttribute("toggleForVehicle", true)
        header:CallMethod("initialConfigFunction", self:GetName())
    ]===])

	frame:SetMovable(true)
	frame:SetClampedToScreen(true)

    -- HACK: Do everything while out of combat, because we are cheaters
    local startingIndex = frame:GetAttribute("startingIndex")
    frame:SetAttribute("startingIndex", -39)
    frame:Show()
    frame:Hide()
    frame:SetAttribute("startingIndex", startindIndex)

	frame:Show()
	self:RestorePosition(name)
	return frame
end

function PerfectRaid:GetColoredName(unit, idx)
	local class = select(2, UnitClass(unit)) or "WARRIOR"
	local color = RAID_CLASS_COLORS[class]
	local group = ""
	if idx then
		group = string.format("%s-", select(3, GetRaidRosterInfo(idx)))
	end

	return string.format("%s|cFF%02x%02x%02x%s|r", group, color.r*255, color.g*255, color.b*255, UnitName(unit) or "Unknown")
end

function PerfectRaid:CHAT_MSG_SYSTEM(event, msg)
	if msg == ERR_RAID_YOU_LEFT then
		for unit,tbl in pairs(frames) do
			for frame in pairs(tbl) do
				frame.unit = nil
				frame.unitname = nil
			end
		end
	end
end

function PerfectRaid:UNIT_HEALTH(event, unit)
	if not frames[unit] then return end
	local health = UnitHealth(unit)
	local max = UnitHealthMax(unit)

	-- Hack to fix api issue
	if max < health then max = health end
	local deficit = max - health
	local perc = UnitHealthMax(unit) / health
	local class = select(2, UnitClass(unit))
	local perc = (health/max) or 0
	local hasaggro = false

	if deficit > 999 then
		deficit = string.format("%.1fk", deficit / 1000)
	elseif deficit == 0 then
		deficit = ""
	end

	--TODO: Seperate this out properly into the logical module
	if aggro[unit] and aggro[unit] >= 15 then
		if deficit == "" then
			deficit = "|cFFFF1111"..L["Aggro"]
		else
			deficit = "|cFFFF1111"..deficit.."|r"
		end		
		hasaggro = true
	end

	if UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) then
		local status

		unavail[unit] = true

		if UnitIsDead(unit) then
			status = L["Dead"]
		elseif UnitIsGhost(unit) then
			status = L["Ghost"]
		elseif not UnitIsConnected(unit) then
			status = L["Offline"]
		end

		for frame in pairs(frames[unit]) do
			frame.healthbar:SetValue(max)
			frame.manabar:SetValue(max)
			frame.status:SetText(status)
			frame.healthbar:SetStatusBarColor(0.3, 0.3, 0.3)
			frame.manabar:SetStatusBarColor(0.3, 0.3, 0.3)
			frame:SetBackdropBorderColor(0.3, 0.3, 0.3)
		end
	else
		if unavail[unit] then
			for frame in pairs(frames[unit]) do
				local options = self.db.profile.headers[frame.header.idx]
				if options.colorclass then
					local c = frame.classcolor
					frame.healthbar:SetStatusBarColor(c.r,c.g,c.b)
				else
					frame.healthbar:SetStatusBarColor(utils.GetHPSeverity(perc))
				end

				local color = frame.manacolor
				frame.manabar:SetStatusBarColor(color.r, color.g, color.b)

				local value = health
				if options.reverse then
					value = max - health
				end

				frame.healthbar:SetMinMaxValues(0, max)
				frame.healthbar:SetValue(value)
				frame.status:SetText(nil)
			end
			unavail[unit] = nil
		end

		for frame in pairs(frames[unit]) do
				local options = self.db.profile.headers[frame.header.idx]
				if options.colorclass then
					local c = frame.classcolor
					frame.healthbar:SetStatusBarColor(c.r,c.g,c.b)
				else
					frame.healthbar:SetStatusBarColor(utils.GetHPSeverity(perc))
				end

			local value = health
			if options.reverse then
				value = max - health
			end

			frame.healthbar:SetValue(value)
			if options.deficit then
				frame.status:SetText(deficit)
			elseif hasaggro then
				frame.status:SetText("|cFFFF1111"..L["Aggro"])
			else
				frame.status:SetText(nil)
			end
		end
	end
end

function PerfectRaid:UNIT_POWER_UPDATE(event, unit, powerType)
	if not frames[unit] then return end
    local currentType, currentToken = UnitPowerType(unit)
    if currentToken == powerType then
        local mana, currentPower = UnitPower(unit, currentType)
        for frame in pairs(frames[unit]) do
            frame.manabar:SetValue(mana)
        end
    end
end

function PerfectRaid:UNIT_MAXPOWER(event, unit, powerType)
	if not frames[unit] then return end

    local currentType, currentToken = UnitPowerType(unit)
    if currentToken == powerType then
        local max = UnitPowerMax(unit, currentType)
        local mana = UnitPower(unit, currentType)
        for frame in pairs(frames[unit]) do
            frame.manabar:SetMinMaxValues(0, max)
            self:UNIT_POWER_UPDATE(nil, unit, powerType)
        end
	end
end

function PerfectRaid:UNIT_MAXHEALTH(event, unit)
	if not frames[unit] then return end
	local max = UnitHealthMax(unit)
	local health = UnitHealth(unit)
	for frame in pairs(frames[unit]) do
		frame.healthbar:SetMinMaxValues(0, max)
		self:UNIT_HEALTH(nil, unit)
	end
end

local function OnShow(frame)
	local self = PerfectRaid
	local unit = frame:GetAttribute("unit")
	if unit == nil then
        return
	end

	local unitname = UnitName(unit)
	if not frame.unitname then
		frame.unitname = unitname
	else
		if frame.unitname == unitname then
			return
		end
	end
end

local function OnHide(frame)
    if frame == PerfectRaid.movingButton then
        PerfectRaid.moving:StopMovingOrSizing()
    end
end

function OnAttributeChanged(frame, name, value)
	if name ~= "unit" then return end

	local self = PerfectRaid

	-- This code finds all instances of the current frame
	-- and clears them from the unit table.  This is exhaustive
	-- to ensure nothing is left referencing this frame.
	for unit,tbl in pairs(frames) do
		if tbl[frame] and frame:GetAttribute("unit") ~= unit then
			tbl[frame] = nil
		end
	end

	-- If we've been given a unit, instead of nil
	if value then
        -- Get the modified unit, rather than using the one we're given
        vaulue = SecureButton_GetModifiedUnit(frame)

		-- Register us for frame updates under the correct unit ID.
		frames[value] = frames[value] or {}
		frames[value][frame] = true

		-- Use the unitname to check if we need to update config
		-- even if the unitID changed.
		local unitname = UnitName(value)
		if not frame.unit then
			frame.unit = value
			frame.unitname = unitname
		else
			if frame.unit == value and frame.unitname == unitname then
				return
			end
		end

		-- Set the variables we use to check/clear
		frame.unit = value
		frame.unitname = unitname

		-- Do Visual Configuration here
		local unit = value
		frame.idx = value:match("^raid(%d+)$")
		local nametext = self:GetColoredName(unit, frame.options.showgroupnum and frame.idx)
		frame.name:SetText(nametext)
		--	frame.name:SetText(UnitName(unit))G

		local class = select(2, UnitClass(unit)) or "WARRIOR"
		frame.class = class
		frame.classcolor = RAID_CLASS_COLORS[class]
		frame.manacolor = PowerBarColor[UnitPowerType(unit)]

		local color = frame.classcolor
		frame.healthbar:SetStatusBarColor(color.r, color.g, color.b)
		frame.healthbar:SetMinMaxValues(0, UnitHealthMax(unit))
		frame.healthbar:SetValue(UnitHealth(unit))
		--	frame:SetBackdropBorderColor(color.r, color.g, color.b)

		local color = frame.manacolor
		frame.manabar:SetStatusBarColor(color.r, color.g, color.b)
		frame.manabar:SetMinMaxValues(0, UnitPowerMax(unit))
		frame.manabar:SetValue(UnitPower(unit))

		-- Show/Hide the mana bar depending on unit power type
		local manaheight = frame.options.manaheight or 0
		if UnitPowerType(unit) == 0 and manaheight > 0 then
			frame.manabar:Show()
		 elseif self.db.profile.showmanaonly then
			frame.manabar:Hide()
		end

		frame.status:SetText(nil)

		for name,module in self:IterateModules() do
			if type(module.ShowButton) == "function" then
				module:ShowButton(frame)
			end
		end

		self:UNIT_HEALTH(nil, unit)
		self:UNIT_POWER_UPDATE(nil, unit)
		self:TriggerMessage("PERFECTRAID_FRAME_LAYOUT_CHANGED");
	end

	-- Hide any empty parents

	local parent = frame:GetParent()
	if value == nil then
		local num = parent:GetNumChildren()
		local visible = nil
		for i=1,num do
			local button = parent:GetAttribute("child"..i)
			if button and button:IsShown() then visible = true end
		end
		local method
		if visible then method = "Show" else method = "Hide" end

		if parent.title then
			parent.title[method](parent.title)
		end
	else
		parent.title:Show()
	end
end

function PerfectRaid.ConfigureButton(header, buttonName)
    local self = PerfectRaid

    local button
    if type(buttonName) == "string" then
        button = _G[buttonName]
    end

    button:SetWidth(225)
    button:SetHeight(14)

    if self.db.profile.clickcast then
		ClickCastFrames[button] = true
	end

	button:SetAttribute("*type1", "target")

	local bg = button:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetTexture("Interface\\AddOns\\PerfectRaid\\images\\Highlight")
	bg:Hide()
	button.bg = bg

	--button:SetScript("OnEnter", function(frame) bg:Show() end)
	--button:SetScript("OnLeave", function(frame) bg:Hide() end)

	local parent = button:GetParent()
	button.dragparent = parent.dragparent
	button.header = parent
	button.headerName = parent:GetName()

	local options = self.db.profile.headers[parent.idx]
	button.options = options

    -- Change with vehicle state:
    button:SetAttribute("toggleForVehicle", not not options.vehicleSwap)

	local leftbox = CreateFrame("Frame", nil, button)
	button.leftbox = leftbox

	local rightbox = CreateFrame("Frame", nil, button)
	button.rightbox = rightbox

	local bar = CreateFrame("StatusBar", nil, button)
	button.healthbar = bar

	local raise = CreateFrame("Frame", nil, button.healthbar)
	raise:SetAllPoints()
	button.raise = raise
	--raise:Show()

	local font = raise:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	button.status = font

	local bar = CreateFrame("StatusBar", nil, button.healthbar)
	button.manabar = bar

	local font = button.healthbar:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	button.name = font

	button:SetClampedToScreen(true)
	button:RegisterForDrag("LeftButton")

	for name,module in self:IterateModules() do
		if type(module.ConfigureButton) == "function" then
			module:ConfigureButton(button)
		end
	end

	self:UpdateButtonLayout(button)

	button:SetScript("OnShow", OnShow)
	button:SetScript("OnDragStart", OnDragStart)
	button:SetScript("OnDragStop", OnDragStop)
	button:SetScript("OnAttributeChanged", OnAttributeChanged)
    button:SetScript("OnHide", OnHide)
end

function PerfectRaid:UpdateButtonLayout(button)
	if not button then
		self:Print(debugstack())
	end
	local parent = button:GetParent()
	local options = self.db.profile.headers[parent.idx]

	button.leftbox:ClearAllPoints()
	button.leftbox:SetPoint("TOPLEFT", 0, 0)
	button.leftbox:SetPoint("BOTTOMRIGHT", button, "BOTTOMLEFT", 70, 0)

	button.rightbox:ClearAllPoints()
	button.rightbox:SetPoint("TOPRIGHT", 0, 0)
	button.rightbox:SetPoint("BOTTOMLEFT", button, "BOTTOMRIGHT", -70, 0)

	button.healthbar:ClearAllPoints()
	button.healthbar:SetPoint("TOPLEFT", button.leftbox, "TOPRIGHT", 0, -1)
	button.healthbar:SetPoint("BOTTOMRIGHT", button.rightbox, "BOTTOMLEFT", 0, 1)
	button.healthbar:SetStatusBarTexture("Interface\\AddOns\\PerfectRaid\\images\\smooth")

	button.manabar:ClearAllPoints()
	button.manabar:SetPoint("BOTTOMLEFT", 0, 0)
	button.manabar:SetPoint("BOTTOMRIGHT", 0, 0)
	if options.manaheight == 0 then
		button.manabar:Hide()
	else
		button.manabar:Show()
		button.manabar:SetHeight(options.manaheight or 0)
	end

	button.manabar:SetStatusBarTexture("Interface\\AddOns\\PerfectRaid\\images\\smooth")

	button.status:ClearAllPoints()
	button.status:SetPoint("RIGHT", -2, 0)

	if options.alignright then
		button.name:ClearAllPoints()
		button.name:SetPoint("RIGHT", button.rightbox, "RIGHT", 0, 0)
		button.name:SetPoint("LEFT", button.rightbox, "LEFT", 2, 0)
		button.name:SetJustifyH("LEFT")
	else
		button.name:ClearAllPoints()
		button.name:SetPoint("RIGHT", button.leftbox, "RIGHT", -2, 0)
		button.name:SetPoint("LEFT", button.leftbox, "LEFT", 0, 0)
		button.name:SetJustifyH("RIGHT")
	end

	for name,module in self:IterateModules() do
		if type(module.UpdateButtonLayout) == "function" then
			module:UpdateButtonLayout(button, options)
		end
	end
end

function PerfectRaid:GROUP_ROSTER_UPDATE()
	if self.moving then
		self.moving:StopMovingOrSizing()
	end

	-- Update group numbers here
	for unit,list in pairs(self.frames) do
		for frame in pairs(list) do
			if frame.idx then
				local nametext = self:GetColoredName(unit, frame.options.showgroupnum and frame.idx)
				frame.name:SetText(nametext)
			end
		end
	end
 end

function PerfectRaid:UNIT_DISPLAYPOWER(event, unit)
	if not frames[unit] then return end
	local color = PowerBarColor[UnitPowerType(unit)]
	local show = UnitPowerType(unit) == 0
	local max = UnitPowerMax(unit)
	local mana = UnitPower(unit)
	local manaonly = self.db.profile.showmanaonly

	for frame in pairs(frames[unit]) do
		frame.manacolor = color
		local bar = frame.manabar
		bar:SetStatusBarColor(color.r, color.g, color.b)
		bar:SetMinMaxValues(0, max)
		bar:SetValue(mana)

		if show and frame.options.manaheight > 0 then
			bar:Show()
		elseif manaonly then
			bar:Hide()
		end
	 end
end

local updateMethods = {
    "UNIT_DISPLAYPOWER",
    "UNIT_HEALTH",
    "UNIT_MAXHEALTH",
	"UNIT_POWER_UPDATE",
	"UNIT_MAXPOWER",
}

function PerfectRaid:FullUpdate()
    for unit, tbl in pairs(frames) do
        for idx, method in ipairs(updateMethods) do
            self[method](self, method, unit)
        end
    end

    for name,module in self:IterateModules() do
        if type(module.FullUpdate) == "function" then
            module:FullUpdate()
        end
    end
end

PerfectRaid = DongleStub("Dongle-1.1"):New("PerfectRaid", PerfectRaid)
