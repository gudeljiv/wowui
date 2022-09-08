--[[
# Element: ComboPoints

Handles the visibility and updating of the player"s class resources (like Chi Orbs or Holy Power) and combo points.

## Widget

ComboPoints - A `table` consisting of 5 StatusBars as the maximum return of [UnitPowerMax](http://wowprogramming.com/docs/api/UnitPowerMax.html).

## Sub-Widgets

.bg - A `Texture` used as a background. It will inherit the color of the main StatusBar.

## Sub-Widget Options

.multiplier - Used to tint the background based on the widget"s R, G and B values. Defaults to 1 (number)[0-1]

## Notes

A default texture will be applied if the sub-widgets are StatusBars and don"t have a texture set.
If the sub-widgets are StatusBars, their minimum and maximum values will be set to 0 and 1 respectively.

Supported class powers:
- All     - Combo Points

## Examples

    local ComboPoints = {}
    for index = 1, 5 do
        local Bar = CreateFrame("StatusBar", nil, self)

        -- Position and size.
        Bar:SetSize(16, 16)
        Bar:SetPoint("TOPLEFT", self, "BOTTOMLEFT", (index - 1) * Bar:GetWidth(), 0)

        ComboPoints[index] = Bar
    end

    -- Register with oUF
    self.ComboPoints = ComboPoints
--]]

local _, ns = ...
local oUF = ns.oUF

local _, PlayerClass = UnitClass("player")

-- sourced from FrameXML/Constants.lua
local SPELL_POWER_ENERGY = Enum.PowerType.Energy or 3
local SPELL_POWER_COMBO_POINTS = Enum.PowerType.ComboPoints or 4

-- Holds the class specific stuff.
local ClassPowerID, ClassPowerType
local ComboPointsEnable, ComboPointsDisable
local RequirePower, RequireSpell

local function UpdateColor(element, powerType)
	local color = element.__owner.colors.power[powerType]
	local r, g, b = color[1], color[2], color[3]
	for i = 1, #element do
		local bar = element[i]
		bar:SetStatusBarColor(r, g, b)

		local bg = bar.bg
		if(bg) then
			local mu = bg.multiplier or 1
			bg:SetVertexColor(r * mu, g * mu, b * mu)
		end
	end
end

local function Update(self, event, unit, powerType)

	local element = self.ComboPoints

	--[[ Callback: ComboPoints:PreUpdate(event)
	Called before the element has been updated.

	* self  - the ComboPoints element
	]]
	if(element.PreUpdate) then
		element:PreUpdate()
	end

	if(event ~= "ComboPointsDisable") then

		local cur
		if UnitHasVehicleUI("player") then
			cur = GetComboPoints("pet", "target")
		else
			cur = GetComboPoints("player", "target")
		end
		for i = 1, 5 do
			if(i > cur) then
				element[i]:Hide()
				element[i]:SetValue(0)
			else
				element[i]:Show()
				element[i]:SetValue(cur - i + 1)
			end
		end
	end
	--[[ Callback: ComboPoints:PostUpdate(cur)
	Called after the element has been updated.

	* self          - the ComboPoints element
	* cur           - the current amount of power (number)
	--]]
	if(element.PostUpdate) then
		return element:PostUpdate(cur)
	end
end

local function Path(self, ...)
	--[[ Override: ComboPoints.Override(self, event, unit, ...)
	Used to completely override the internal update function.

	* self  - the parent object
	* event - the event triggering the update (string)
	* unit  - the unit accompanying the event (string)
	* ...   - the arguments accompanying the event
	--]]
	return (self.ComboPoints.Override or Update) (self, ...)
end

local function Visibility(self, event, unit)
	local element = self.ComboPoints
	local shouldEnable

	if(ClassPowerID) then
		-- use "player" instead of unit because "SPELLS_CHANGED" is a unitless event
		if(not RequirePower or RequirePower == UnitPowerType("player")) then
			if(not RequireSpell or IsPlayerSpell(RequireSpell)) then
				self:UnregisterEvent("SPELLS_CHANGED", Visibility)
				shouldEnable = true
				unit = "player"
			else
				self:RegisterEvent("SPELLS_CHANGED", Visibility, true)
			end
		end
	elseif UnitHasVehicleUI("player") and UnitPowerType("pet") == SPELL_POWER_ENERGY then
		shouldEnable = true
		unit = "pet"
	end

	local isEnabled = element.isEnabled
	local powerType = ClassPowerType or "COMBO_POINTS"

	if(shouldEnable) then
		--[[ Override: ComboPoints:UpdateColor(powerType)
		Used to completely override the internal function for updating the widgets" colors.

		* self      - the ComboPoints element
		* powerType - the active power type (string)
		--]]
		(element.UpdateColor or UpdateColor) (element, powerType)
	end

	if(shouldEnable and not isEnabled) then
		ComboPointsEnable(self)
	elseif(not shouldEnable and (isEnabled or isEnabled == nil)) then
		ComboPointsDisable(self)
	elseif(shouldEnable and isEnabled) then
		Path(self, event, unit, powerType)
	end
end

local function VisibilityPath(self, ...)
	--[[ Override: ComboPoints.OverrideVisibility(self, event, unit)
	Used to completely override the internal visibility function.

	* self  - the parent object
	* event - the event triggering the update (string)
	* unit  - the unit accompanying the event (string)
	--]]
	return (self.ComboPoints.OverrideVisibility or Visibility) (self, ...)
end

local function ForceUpdate(element)
	return VisibilityPath(element.__owner, "ForceUpdate", element.__owner.unit)
end

do
	function ComboPointsEnable(self)
		self:RegisterEvent("UNIT_POWER_FREQUENT", Path, true)
		self:RegisterEvent("UNIT_MAXPOWER", Path, true)
		if self.unit == "player" or self.unit == "pet" then
			self:RegisterEvent("PLAYER_TARGET_CHANGED", Path, true)
		end

		self.ComboPoints.isEnabled = true

		Path(self, "ComboPointsEnable", "player", ClassPowerType)
	end

	function ComboPointsDisable(self)
		self:UnregisterEvent("UNIT_POWER_FREQUENT", Path)
		self:UnregisterEvent("UNIT_MAXPOWER", Path)
		if self.unit == "player" or self.unit == "pet" then
			self:UnregisterEvent("PLAYER_TARGET_CHANGED", Path)
		end

		local element = self.ComboPoints
		for i = 1, #element do
			element[i]:Hide()
		end

		self.ComboPoints.isEnabled = false
		Path(self, "ComboPointsDisable", "player", ClassPowerType)
	end

	if(PlayerClass == "ROGUE" or PlayerClass == "DRUID") then
		ClassPowerID = SPELL_POWER_COMBO_POINTS
		ClassPowerType = "COMBO_POINTS"

		if(PlayerClass == "DRUID") then
			RequirePower = SPELL_POWER_ENERGY
			RequireSpell = 768 -- Cat Form
		end
	end
end

local function Enable(self, unit)
	local element = self.ComboPoints
	if element then
		element.__owner = self
		element.__max = #element
		element.ForceUpdate = ForceUpdate

		if(RequirePower) then
			self:RegisterEvent("UNIT_DISPLAYPOWER", VisibilityPath, true) -- needs to be unitless for target
		end

		self:RegisterEvent("UNIT_ENTERED_VEHICLE", VisibilityPath, true) -- needs to be unitless for target
		self:RegisterEvent("UNIT_EXITED_VEHICLE", VisibilityPath, true) -- needs to be unitless for target

		element.ComboPointsEnable = ComboPointsEnable
		element.ComboPointsDisable = ComboPointsDisable

		for i = 1, #element do
			local bar = element[i]
			if(bar:IsObjectType("StatusBar")) then
				if(not bar:GetStatusBarTexture()) then
					bar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
				end

				bar:SetMinMaxValues(0, 1)
			end
		end

		return true
	end
end

local function Disable(self)
	if(self.ComboPoints) then
		ComboPointsDisable(self)

		self:UnregisterEvent("UNIT_DISPLAYPOWER", VisibilityPath)
		self:UnregisterEvent("SPELLS_CHANGED", Visibility)
		self:UnregisterEvent("UNIT_ENTERED_VEHICLE", VisibilityPath)
		self:UnregisterEvent("UNIT_EXITED_VEHICLE", VisibilityPath)
	end
end

oUF:AddElement("ComboPoints", VisibilityPath, Enable, Disable)
