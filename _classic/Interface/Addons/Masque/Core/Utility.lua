--[[

	This file is part of 'Masque', an add-on for World of Warcraft. For bug reports,
	suggestions and license information, please visit https://github.com/SFX-WoW/Masque.

	* File...: Core\Utility.lua
	* Author.: StormFX

	Utility Functions

]]

local _, Core = ...

----------------------------------------
-- Lua API
---

local type = type

----------------------------------------
-- Functions
---

-- An empty function.
function Core.NoOp() end

-- Returns the scale factor for a button.
local function GetScaleSize(Button)
	local Scale = (Button and Button.__MSQ_Scale) or 1
	return 36 / Scale
end

----------------------------------------
-- Color
---

-- Returns a set of color values.
function Core.GetColor(Color, Alpha)
	if type(Color) == "table" then
		return Color[1] or 1, Color[2] or 1, Color[3] or 1, Alpha or Color[4] or 1
	else
		return 1, 1, 1, Alpha or 1
	end
end

----------------------------------------
-- Points
---

-- Clears and sets the points for a region.
function Core.SetPoints(Region, Button, Skin, Default, SetAllPoints)
	Region:ClearAllPoints()

	local Anchor, Regions = Skin.Anchor, Button.__Regions
	Anchor = (Anchor and Regions) and Regions[Anchor]

	if SetAllPoints then
		Region:SetAllPoints(Anchor or Button)
	else
		local Point = Skin.Point
		local RelPoint = Skin.RelPoint or Point

		if not Point then
			Point = Default and Default.Point

			if Point then
				RelPoint = Default.RelPoint or Point
			else
				Point = "CENTER"
				RelPoint = Point
			end
		end

		local OffsetX = Skin.OffsetX
		local OffsetY = Skin.OffsetY

		if Default and not OffsetX and not OffsetY then
			OffsetX = Default.OffsetX or 0
			OffsetY = Default.OffsetY or 0
		end

		Region:SetPoint(Point, Anchor or Button, RelPoint, OffsetX or 0, OffsetY or 0)
	end
end

----------------------------------------
-- Scale
---

-- Returns the x and y scale of a button.
function Core.GetScale(Button)
	local ScaleSize = GetScaleSize(Button)
	local w, h = Button:GetSize()
	local x = (w or ScaleSize) / ScaleSize
	local y = (h or ScaleSize) / ScaleSize
	return x, y
end

----------------------------------------
-- Size
---

-- Returns a height and width.
function Core.GetSize(Width, Height, xScale, yScale, Button)
	local ScaleSize = GetScaleSize(Button)
	local w = (Width or ScaleSize) * xScale
	local h = (Height or ScaleSize) * yScale
	return w, h
end

----------------------------------------
-- TexCoords
---

-- Returns a set of texture coordinates.
function Core.GetTexCoords(Coords)
	if type(Coords) == "table" then
		return Coords[1] or 0, Coords[2] or 1, Coords[3] or 0, Coords[4] or 1
	else
		return 0, 1, 0, 1
	end
end

----------------------------------------
-- Type Skin
---

-- Returns a skin based on the button type.
function Core.GetTypeSkin(Button, Type, Skin)
	if Button.__MSQ_IsAura then
		return Skin[Type] or Skin.Aura or Skin
	elseif Button.__MSQ_IsItem then
		if Type == "ReagentBag" then
			return Skin.ReagentBag or Skin.BagSlot or Skin.Item or Skin
		else
			return Skin[Type] or Skin.Item or Skin
		end
	else
		return Skin[Type] or Skin
	end
end

----------------------------------------
-- API
---

-- Temporary function to catch add-ons using deprecated API.
function Core.API:Register(Addon)
	if type(Addon) ~= "string" then
		return
	end

	local Warn = Core.db.profile.CB_Warn

	if Warn[Addon] then
		print("|cffff8800Masque Warning:|r", Addon, "called the deprecated API method, '|cff0099ffRegister|r'.  Please notify the author or post in the relevant issue on the Masque project page.")
		Warn[Addon] = false
	end
end
