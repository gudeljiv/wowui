
ItemRackSettings = {
	["HideOOC"] = "OFF",
	["Cooldown90"] = "OFF",
	["ShowMinimap"] = "ON",
	["Notify"] = "ON",
	["ShowSetInTooltip"] = "OFF",
	["HideTradables"] = "OFF",
	["AllowHidden"] = "ON",
	["minimap"] = {
		["hide"] = false,
	},
	["TinyTooltips"] = "OFF",
	["MinimapTooltip"] = "OFF",
	["NotifyChatAlso"] = "OFF",
	["LargeNumbers"] = "OFF",
	["MenuOnShift"] = "OFF",
	["TrinketMenuMode"] = "ON",
	["EventsVersion"] = 18,
	["HidePetBattle"] = "ON",
	["AnchorOther"] = "ON",
	["DisableAltClick"] = "OFF",
	["MenuOnRight"] = "OFF",
	["IconPos"] = 170.481767190417,
	["CooldownCount"] = "OFF",
	["NotifyThirty"] = "OFF",
	["AnotherOther"] = "OFF",
	["ShowTooltips"] = "ON",
	["EquipToggle"] = "OFF",
	["ShowHotKeys"] = "OFF",
	["TooltipFollow"] = "ON",
	["EquipOnSetPick"] = "OFF",
	["CharacterSheetMenus"] = "ON",
	["SquareMinimap"] = "OFF",
	["AllowEmpty"] = "ON",
}
ItemRackItems = {
	["12846"] = {
		["keep"] = 1,
	},
	["13209"] = {
		["keep"] = 1,
	},
	["25653"] = {
		["keep"] = 1,
	},
	["11122"] = {
		["keep"] = 1,
	},
	["19812"] = {
		["keep"] = 1,
	},
}
ItemRackEvents = {
	["Drinking"] = {
		["Unequip"] = 1,
		["Type"] = "Buff",
		["Buff"] = "Drink",
	},
	["Buffs Gained"] = {
		["Trigger"] = "UNIT_AURA",
		["Type"] = "Script",
		["Script"] = "if arg1==\"player\" then\n  IRScriptBuffs = IRScriptBuffs or {}\n  local buffs = IRScriptBuffs\n  for i in pairs(buffs) do\n    if not AuraUtil.FindAuraByName(i,\"player\") then\n      buffs[i] = nil\n    end\n  end\n  local i,b = 1,1\n  while b do\n    b = AuraUtil.FindAuraByName(i,\"player\")\n    if b and not buffs[b] then\n      ItemRack.Print(\"Gained buff: \"..b)\n      buffs[b] = 1\n    end\n    i = i+1\n  end\nend\n--[[For script demonstration purposes. Doesn't equip anything just informs when a buff is gained.]]",
	},
	["PVP"] = {
		["Unequip"] = 1,
		["Type"] = "Zone",
		["Zones"] = {
			["Eye of the Storm"] = 1,
			["Arathi Basin"] = 1,
			["Alterac Valley"] = 1,
			["Warsong Gulch"] = 1,
			["Blade's Edge Arena"] = 1,
			["Ruins of Lordaeron"] = 1,
			["Nagrand Arena"] = 1,
		},
	},
	["Swimming"] = {
		["Trigger"] = "MIRROR_TIMER_START",
		["Type"] = "Script",
		["Script"] = "local set = \"Name of set\"\nif IsSwimming() and not IsSetEquipped(set) then\n  EquipSet(set)\n  if not SwimmingEvent then\n    function SwimmingEvent()\n      if not IsSwimming() then\n        ItemRack.StopTimer(\"SwimmingEvent\")\n        UnequipSet(set)\n      end\n    end\n    ItemRack.CreateTimer(\"SwimmingEvent\",SwimmingEvent,.5,1)\n  end\n  ItemRack.StartTimer(\"SwimmingEvent\")\nend\n--[[Equips a set when swimming and breath gauge appears and unequips soon after you stop swimming.]]",
	},
	["After Cast"] = {
		["Trigger"] = "UNIT_SPELLCAST_SUCCEEDED",
		["Type"] = "Script",
		["Script"] = "local spell = \"Name of spell\"\nlocal set = \"Name of set\"\nif arg1==\"player\" and arg2==spell then\n  EquipSet(set)\nend\n\n--[[This event will equip \"Name of set\" when \"Name of spell\" has finished casting.  Change the names for your own use.]]",
	},
	["City"] = {
		["Unequip"] = 1,
		["Type"] = "Zone",
		["Zones"] = {
			["Undercity"] = 1,
			["The Exodar"] = 1,
			["Stormwind City"] = 1,
			["Darnassus"] = 1,
			["Ironforge"] = 1,
			["Shattrath City"] = 1,
			["Thunder Bluff"] = 1,
			["Dalaran"] = 1,
			["Silvermoon City"] = 1,
			["Orgrimmar"] = 1,
		},
	},
	["Rogue Stealth"] = {
		["Unequip"] = 1,
		["Class"] = "ROGUE",
		["Type"] = "Stance",
		["Stance"] = 1,
	},
	["Mounted"] = {
		["Unequip"] = 1,
		["Type"] = "Buff",
		["Anymount"] = 1,
	},
	["Nefarian's Lair"] = {
		["Unequip"] = 1,
		["Type"] = "Zone",
		["Zones"] = {
			["Nefarian's Lair"] = 1,
		},
	},
}
