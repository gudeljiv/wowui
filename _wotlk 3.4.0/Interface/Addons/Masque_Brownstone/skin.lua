local MSQ = LibStub and LibStub("Masque", true)
if not MSQ then return end

local AddOn, Core = ...

----------------------------------------
-- Locals
---


-- Skin Info
local Version = GetAddOnMetadata(AddOn, "Version")
local Websites = {
	"https://github.com/rgd87/Masque_Brownstone",
}


MSQ:AddSkin("Brownstone", {
	Shape = "Square",
	Masque_Version = 80300,
	Description = "This is a skin",
	Version = Version,
	Author = "d87",
    Websites = Websites,
    Template = "Blizzard",

	Backdrop = {
		TexCoords = {0.2, 0.8, 0.2, 0.8},
        Texture = [[Interface\Buttons\UI-EmptySlot]],
		Width = 40,
		Height = 40,
    },
    Pushed = {
		Texture = "Interface\\AddOns\\Masque_Brownstone\\Textures\\tPushed3",
		Width = 40,
        Height = 40,
        -- BlendMode = "ADD",
		DrawLayer = "ARTWORK",
		DrawLevel = 3,
	},
	Normal = {
		Texture = "Interface\\AddOns\\Masque_Brownstone\\Textures\\tNormal3",
		Width = 40,
        Height = 40,
        DrawLayer = "ARTWORK",
        DrawLevel = 0,
	},
	Checked = {
		Texture = "Interface\\AddOns\\Masque_Brownstone\\Textures\\tChecked",
		Width = 33,
        Height = 33,
        BlendMode = "ADD",
		-- Color = { 1, 246/255, 0, 0.9 },
	},
	Highlight = {
		Texture = "Interface\\AddOns\\Masque_Brownstone\\Textures\\tHighlighted",
		Width = 33,
        Height = 33,
        BlendMode = "ADD",
		-- Color = { 0, 144/255, 1, 0.9 },
	},
	Border = {
        Hide = true,
        Width = 60,
        Height = 60,
        OffsetX = 0.5,
        OffsetY = 0.5,
        BlendMode = "ADD",
        Texture = [[Interface\Buttons\UI-ActionButton-Border]],
    },
	Icon = {
		-- TexCoords = { 0.05, 0.95, 0.05, 0.95 },
		Width = 36,
		Height = 36,
	},
	Cooldown = {
		Width = 33,
		Height = 32,
		OffsetX = 0,
        OffsetY = 0,
        DrawLayer = "ARTWORK",
		DrawLevel = -3,
		Texture = "Interface\\AddOns\\Masque_Brownstone\\Textures\\SoftSwipe",
	},
	Count = { -- anchor BOTTOMRIGHT
	--	Width = 36,b
		JustifyV = "BOTTOM",
	},
	Name = { -- anchor BOTTOM
		Width = 51,
		JustifyV = "BOTTOM",
	},
	HotKey = { -- anchor TOPLEFT
		Width = 34,
		OffsetX = 1,
		OffsetY = -3,
		JustifyH = "RIGHT",
		JustifyV = "TOP",
	},
	Gloss = {
		Hide = true,
    },
})
