local MSQ = LibStub and LibStub("Masque", true)
if not MSQ then
	return
end

local AddOn, Core = ...

local Version = C_AddOns.GetAddOnMetadata(AddOn, "Version")
local Websites = {
	"",
}

MSQ:AddSkin("BeautyBorder", {
	API_VERSION = 90002,
	Shape = "Square",

	Version = Version,
	Author = "xxx",
	Websites = Websites,

	Backdrop = {
		TexCoords = { 0.2, 0.8, 0.2, 0.8 },
		Texture = [[Interface\Buttons\UI-EmptySlot]],
		Width = 40,
		Height = 40,
	},
	Pushed = {
		Texture = "Interface\\AddOns\\!Beautycase\\media\\texturePushed",
		Width = 40,
		Height = 40,
		-- BlendMode = "ADD",
		DrawLayer = "ARTWORK",
		DrawLevel = 3,
	},
	Normal = {
		Texture = "Interface\\AddOns\\!Beautycase\\media\\textureNormal",
		Width = 40,
		Height = 40,
		DrawLayer = "ARTWORK",
		DrawLevel = 0,
		-- Color = {0, 144 / 255, 1, 0.9}
	},
	Checked = {
		Texture = "Interface\\AddOns\\!Beautycase\\media\\textureChecked",
		Width = 33,
		Height = 33,
		BlendMode = "ADD",
		-- Color = { 1, 246/255, 0, 0.9 },
	},
	Highlight = {
		Texture = "Interface\\AddOns\\!Beautycase\\media\\textureHighlight",
		Width = 33,
		Height = 33,
		BlendMode = "ADD",
		-- Color = {0, 144 / 255, 1, 0.9}
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
	Count = {
		-- anchor BOTTOMRIGHT
		--	Width = 36,b
		JustifyV = "BOTTOM",
	},
	Name = {
		-- anchor BOTTOM
		Width = 51,
		JustifyV = "BOTTOM",
	},
	HotKey = {
		-- anchor TOPLEFT
		Width = 34,
		OffsetX = 1,
		OffsetY = -3,
		JustifyH = "RIGHT",
		JustifyV = "TOP",
	},
	Gloss = {
		Hide = true,
	},
}, true)
