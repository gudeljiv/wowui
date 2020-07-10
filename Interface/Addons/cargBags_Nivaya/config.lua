local addon, ns = ...

-- local defaultFont = GetLocale() == "ruRU" and [[Interface\AddOns\cargBags_Nivaya\media\pixel_cyr.ttf]] or [[Interface\AddOns\cargBags_Nivaya\media\pixel.ttf]]
local defaultFont = GetLocale() == "ruRU" and [[Interface\AddOns\cargBags_Nivaya\media\FRIZQT__.ttf]] or [[Interface\AddOns\cargBags_Nivaya\media\FRIZQT__.ttf]]

ns.options = {

filterArtifactPower = true, --set to 'false' to disable the category for items that give Artifact Power

itemSlotSize = 32,	-- Size of item slots

sizes = {
	bags = {
		columnsSmall = 8,
		columnsLarge = 10,
		largeItemCount = 64,	-- Switch to columnsLarge when >= this number of items in your bags
	},
	bank = {
		columnsSmall = 12,
		columnsLarge = 14,
		largeItemCount = 96,	-- Switch to columnsLarge when >= this number of items in the bank
	},	
},


--------------------------------------------------------------
-- Anything below this is only effective when not using RealUI
--------------------------------------------------------------

fonts = {
	-- Font to use for bag captions and other strings
	standard = {
		defaultFont, 	-- Font path
		10, 						-- Font Size
		"THINOUTLINE",	-- Flags
	},
	
	--Font to use for the dropdown menu
	dropdown = {
		defaultFont, 	-- Font path
		10, 						-- Font Size
		"THINOUTLINE",	-- Flags
	},

	-- Font to use for durability and item level
	itemInfo = {
		defaultFont, 	-- Font path
		10, 						-- Font Size
		"THINOUTLINE",	-- Flags
	},

	-- Font to use for number of items in a stack
	itemCount = {
		defaultFont, 	-- Font path
		10, 						-- Font Size
		"THINOUTLINE",	-- Flags
	},

},

colors = {
	background = {0.05, 0.05, 0.05, 0.75},	-- r, g, b, opacity
},


}
