local Masque = LibStub("Masque", true)
if not Masque then return end

Masque:AddSkin("ElvUI", {
	Author = "Lorade",
	Version = "11.0.0",
	Masque_Version = 110000,
	Shape = "Square",
	Backdrop = {
		Width = 38,
		Height = 38,
		Color = {1,1,1,1},
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\Backdrop]],
	},
	Icon = {
		Width = 36,
		Height = 36,
		TexCoords = {0.07,0.93,0.07,0.93},
	},
	Flash = {
		Width = 38,
		Height = 38,
		Color = {1, 1, 1, 0.5},
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\Flash]],
	},
	Cooldown = {
		Width = 38,
		Height = 38,
	},
	Pushed = {
		Width = 38,
		Height = 38,
		Color = {1, 0.8, 0.0, 0.25},
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\Flash]],
	},
	Normal = {
		Width = 38,
		Height = 38,
		Static = true,
		Color = {0, 0, 0, 1},
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\Normal]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 38,
		Height = 38,
		BlendMode = "ADD",
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\Border]],
	},
	Border = {
		Width = 38,
		Height = 38,
		BlendMode = "ADD",
		Color = {0, 0, 0, 1},
		OffsetX = 0,
		OffsetY = 0,
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\Border]],
	},
	Gloss = {
		Hide = true,
	},
	AutoCastable = {
		Width = 38,
		Height = 38,
		OffsetX = 0.5,
		OffsetY = -0.5,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 38,
		Height = 38,
		BlendMode = "ADD",
		Color = {1, 1, 1, 0.25},
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\Highlight]],
	},
	Name = {
		Width = 38,
		Height = 10,
		OffsetY = 2,
	},
	Count = {
		Width = 38,
		Height = 10,
		OffsetX = -2,
		OffsetY = 2,
		FontSize = 13,
	},
	HotKey = {
		Width = 38,
		Height = 10,
		OffsetX = -1,
		OffsetY = -2,
	},
	AutoCast = {
		Width = 38,
		Height = 38,
		OffsetX = 1,
		OffsetY = -1,
	},
}, true)

Masque:AddSkin("ElvUI - Hide Empties", {
	Template = "ElvUI",
	Backdrop = {
		Width = 38,
		Height = 38,
		Color = {1,1,1,1},
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\Backdrop_Hidden_Empties]],
	},
	Normal = {
		Width = 38,
		Height = 38,
		Static = true,
		Color = {0, 0, 0, 0},
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\Normal]],
	},
		Border = {
		Width = 38,
		Height = 38,
		BlendMode = "ADD",
		Color = {0, 0, 0, 0},
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\Border]],
	},
}, true)

Masque:AddSkin("ElvUI - No Backdrop", {
	Template = "ElvUI",
	Backdrop = {
		Width = 38,
		Height = 38,
		Color = {1,1,1,1},
		Texture = [[Interface\AddOns\Masque_ElvUI\Textures\No_Backdrop]],
	},
}, true)