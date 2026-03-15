--[[

	This file is part of 'Masque: Squarish', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque_Squarish.

	* File...: Skins.lua
	* Author.: StormFX

	Squarish Skins

	Credits:
	- "Masque: SimpleSquare" port & "Thin" variant by Phanx.
	- "ButtonFacade: SimpleSquare" Port by Moonwitch.
	- Original "cyCircled: SimpleSquare" skin by ScythXIII.
]]

local Masque = LibStub and LibStub("Masque", true)
if not Masque then return end

local _, Core = ...

----------------------------------------
-- Internal
---

local L = Core.Locale

----------------------------------------
-- Locals
---

local API_VERSION = 110208

-- Skin Info
local Version = "11.2.8"
local Websites = {
	"https://github.com/SFX-WoW/Masque_Squarish",
	"https://www.curseforge.com/wow/addons/masque-squarish",
	"https://addons.wago.io/addons/masque-squarish",
	"https://www.wowinterface.com/downloads/info26494",
}

-- Base Paths
local PATH_BASE = [[Interface\AddOns\Masque_Squarish\Textures\Base\]]
local PATH_THIN = [[Interface\AddOns\Masque_Squarish\Textures\Thin\]]
local PATH_MODERN = [[Interface\AddOns\Masque\Textures\Modern\]]

-- Texture Strings
local AUTOCAST_MASK = [[Interface\AddOns\Masque\Textures\Square\AutoCast-Mask]]
local BASE_BORDER = PATH_BASE.."Border"
local THIN_BORDER = PATH_THIN.."Border"
local COOLDOWN_EDGE = PATH_MODERN.."Edge"
local COOLDOWN_MASK = PATH_MODERN.."Mask"

----------------------------------------
-- Squarish
---

Masque:AddSkin("Squarish", {
	API_VERSION = API_VERSION,
	Shape = "Modern",
	Template = "Blizzard Classic",

	-- [ Info ]
	Authors = {"StormFX", "|cff999999Phanx|r", "|cff999999Moonwitch|r", "|cff999999ScythXIII|r"},
	Description = L["A port of the original SimpleSquare skin for cyCircled."],
	Discord = "https://discord.gg/7MTWRgDzz8",
	Version = Version,
	Websites = Websites,

	-- [ UI ]
	Group = "Squarish",
	Order = 1,

	-- [ Skin ]
	-- Mask = Template.Mask,
	Backdrop = {
		Texture = PATH_BASE.."Backdrop",
		Width = 44,
		Height = 44,
	},
	Icon = {
		Backpack = [[Interface\Icons\INV_Misc_Bag_08]],
		TexCoords = {0.05, 0.95, 0.05, 0.95},
	},
	-- Shadow = Template.Shadow,
	Normal = {
		Texture = PATH_BASE.."Normal",
		Width = 44,
		Height = 44,
	},
	-- Disabled = Template.Disabled,
	Pushed = {
		Texture = PATH_BASE.."Glow",
		Width = 44,
		Height = 44,
	},
	Flash = {
		Color = {1, 0, 0, 0.4},
		DrawLevel = -1,
		UseColor = true,
	},
	Checked = {
		Texture = BASE_BORDER,
		Color = {1, 0.97, 0, 0.9},
		Width = 44,
		Height = 44,
	},
	SlotHighlight = "Checked",
	Border = {
		Texture = BASE_BORDER,
		Width = 44,
		Height = 44,
	},
	DebuffBorder = "Border",
	EnchantBorder = "Border",
	IconBorder = "Border",
	-- Gloss = Template.Gloss,
	-- NewAction = Template.NewAction,
	-- SpellHighlight = Template.SpellHighlight,
	-- IconOverlay = Template.IconOverlay,
	-- IconOverlay2 = Template.IconOverlay2,
	-- NewItem = Template.NewItem,
	QuestBorder = {
		Border = [[Interface\ContainerFrame\UI-Icon-QuestBang]],
		Texture = [[Interface\ContainerFrame\UI-Icon-QuestBorder]],
		Width = 38,
		Height = 38,
	},
	-- UpgradeIcon = Template.UpgradeIcon,
	-- ContextOverlay = Template.ContextOverlay,
	-- SearchOverlay = Template.SearchOverlay,
	-- JunkIcon = Template.JunkIcon,
	-- Duration = Template.Duration,
	Name = {
		OffsetY = 3,
	},
	Highlight = {
		Texture = BASE_BORDER,
		Color = {0, 0.57, 1, 0.9},
		Width = 44,
		Height = 44,
	},
	-- [ TextOverlayContainer (Retail) ]
	Count = {
		OffsetX = -3,
		OffsetY = 3,
	},
	HotKey = {
		OffsetX = -3,
		OffsetY = -3,
	},
	-- [ AutoCastShine (Classic) ]
	-- AutoCastable = Template.AutoCastable,
	-- AutoCastShine = Template.AutoCastShine,
	-- [ AutoCastOverlay (Retail) ]
	-- AutoCast_Frame = Template.AutoCast_Frame,
	-- AutoCast_Shine = Template.AutoCast_Shine,
	AutoCast_Mask = {
		Texture = AUTOCAST_MASK,
		Width = 30,
		Height = 30,
	},
	AutoCast_Corners = {
		Atlas = "UI-HUD-ActionBar-PetAutoCast-Corners",
		Width = 40,
		Height = 40,
		OffsetY = -0.5,
	},
	-- [ Cooldowns ]
	Cooldown = {
		Texture = COOLDOWN_MASK,
		EdgeTexture = COOLDOWN_EDGE,
		Color = {0, 0, 0, 0.7},
		Width = 31,
		Height = 31,
		Anchor = "Icon",
	},
	CooldownLoC = "Cooldown",
	ChargeCooldown = "Cooldown",
	-- [ SpellAlerts ]
	SpellAlert = {
		Width = 38,
		Height = 38,
		AltGlow = {
			Height = 47,
			Width = 47,
		},
		Classic = {
			Height = 32,
			Width = 32,
		},
		Modern = {
			Height = 32,
			Width = 32,
		},
		["Modern-Lite"] = {
			Height = 33,
			Width = 33,
		},
	},
	AssistedCombatHighlight = {
		Width = 47,
		Height = 47,
	},
})

Masque:AddSkin("Squarish Thin", {
	-- API_VERSION = Template.API_VERSION,
	-- Shape = Template.Shape,
	Template = "Squarish",

	-- [ Info ]
	Authors = {"StormFX", "|cff999999Phanx|r"},
	Description = L["A thinner version of Squarish."],
	-- Discord = Template.Discord,
	-- Version = Template.Version,
	-- Websites = Template.Websites,

	-- [ UI ]
	-- Group = Template.Group,
	Order = 2,
	Title = "Thin",

	-- [ Skin ]
	-- Mask = Template.Mask,
	-- Backdrop = Template.Backdrop,
	-- Icon = Template.Icon,
	-- Shadow = Template.Shadow,
	Normal = {
		Texture = PATH_THIN.."Normal",
		Width = 44,
		Height = 44,
	},
	-- Disabled = Template.Disabled,
	Pushed = {
		Texture = PATH_THIN.."Glow",
		Width = 44,
		Height = 44,
	},
	-- Flash = Template.Flash,
	Checked = {
		Texture = THIN_BORDER,
		Color = {1, 0.97, 0, 0.9},
		Width = 44,
		Height = 44,
	},
	SlotHighlight = "Checked",
	Border = {
		Texture = THIN_BORDER,
		Width = 44,
		Height = 44,
	},
	DebuffBorder = "Border",
	EnchantBorder = "Border",
	IconBorder = "Border",
	-- Gloss = Template.Gloss,
	-- NewAction = Template.NewAction,
	-- SpellHighlight = Template.SpellHighlight,
	-- IconOverlay = Template.IconOverlay,
	-- IconOverlay2 = Template.IconOverlay2,
	-- NewItem = Template.NewItem,
	-- QuestBorder = Template.QuestBorder,
	-- UpgradeIcon = Template.UpgradeIcon,
	-- ContextOverlay = Template.ContextOverlay,
	-- SearchOverlay = Template.SearchOverlay,
	-- JunkIcon = Template.JunkIcon,
	-- Duration = Template.Duration,
	Name = {
		OffsetY = 1.5,
	},
	Highlight = {
		Texture = THIN_BORDER,
		Color = {0, 0.57, 1, 0.9},
		Width = 44,
		Height = 44,
	},
	-- [ TextOverlayContainer (Retail) ]
	HotKey = {
		OffsetX = -1,
		OffsetY = -1,
	},
	Count = {
		OffsetX = -1,
		OffsetY = 1,
	},
	-- [ AutoCastShine (Classic) ]
	-- AutoCastable = Template.AutoCastable,
	-- AutoCastShine = Template.AutoCastShine,
	-- [ AutoCastOverlay (Retail) ]
	-- AutoCast_Frame = Template.AutoCast_Frame,
	-- AutoCast_Shine = Template.AutoCast_Shine,
	AutoCast_Mask = {
		Texture = AUTOCAST_MASK,
		Width = 32,
		Height = 32,
	},
	-- AutoCast_Corners = Template.AutoCast_Corners,
	-- [ Cooldowns ]
	Cooldown = {
		Texture = COOLDOWN_MASK,
		EdgeTexture = COOLDOWN_EDGE,
		Color = {0, 0, 0, 0.7},
		Width = 34,
		Height = 34,
	},
	CooldownLoC = "Cooldown",
	ChargeCooldown = "Cooldown",
	-- [ SpellAlerts ]
	SpellAlert = {
		Width = 40,
		Height = 40,
		AltGlow = {
			Height = 49,
			Width = 49,
		},
		Classic = {
			Height = 34,
			Width = 34,
		},
		Modern = {
			Height = 34,
			Width = 34,
		},
		["Modern-Lite"] = {
			Height = 35,
			Width = 35,
		},
	},
	AssistedCombatHighlight = {
		Width = 49,
		Height = 49,
	},
})
