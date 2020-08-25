local ZGV = ZygorGuidesViewer

local ItemScore = {}
ZGV.ItemScore = ItemScore

-- Stat keywords:
-- Only stats defined in this table are valid. Use entry in blizz when filling rule sets

local locale=GetLocale()
if locale=="enGB" then locale="enUS" end  -- just in case.


ItemScore.Keywords = {
	[1] = {blizz="AGILITY", zgvdisplay="Agility",regex=ITEM_MOD_AGILITY},
	[2] = {blizz="INTELLECT", zgvdisplay="Intellect",regex=ITEM_MOD_INTELLECT},
	[3] = {blizz="SPIRIT", zgvdisplay="Spirit",regex=ITEM_MOD_SPIRIT},
	[4] = {blizz="STAMINA", zgvdisplay="Stamina",regex=ITEM_MOD_STAMINA},
	[5] = {blizz="STRENGTH", zgvdisplay="Strength",regex=ITEM_MOD_STRENGTH},
	[6] = {blizz="ARMOR", zgvdisplay="Armor",regex=ARMOR_TEMPLATE}, -- base armor on gear
	[7] = {blizz="ARMOR_PENETRATION", zgvdisplay="Armor Penetration",regex=ITEM_MOD_ARMOR_PENETRATION_RATING},
	[8] = {blizz="ATTACK_POWER", zgvdisplay="Attack Power",regex=ITEM_MOD_ATTACK_POWER},
	[9] = {blizz="BLOCK", zgvdisplay="Block",regex=ITEM_MOD_BLOCK_RATING},
	[10] = {blizz="BLOCK_VALUE", zgvdisplay="Block Value",regex=ITEM_MOD_BLOCK_VALUE},
	[11] = {blizz="CRIT", zgvdisplay="Critical Strike %",regex=ITEM_MOD_CRIT_RATING},
	[12] = {blizz="CRIT_MELEE", zgvdisplay="Critical Strike Melee %",regex=ITEM_MOD_CRIT_MELEE_RATING},
	[13] = {blizz="CRIT_RANGED", zgvdisplay="Critical Strike Ranged %",regex=ITEM_MOD_CRIT_RANGED_RATING},
	[14] = {blizz="CRIT_SPELL", zgvdisplay="Critical Strike Spell% ",regex=ITEM_MOD_CRIT_SPELL_RATING},
	[15] = {blizz="DAMAGE_PER_SECOND", zgvdisplay="Damage Per Second",regex=DPS_TEMPLATE},
	[16] = {blizz="DEFENSE_SKILL", zgvdisplay="Defense",regex=ITEM_MOD_DEFENSE_SKILL_RATING},
	[17] = {blizz="DODGE", zgvdisplay="Dodge",regex=ITEM_MOD_DODGE_RATING},
	[18] = {blizz="EXTRA_ARMOR", zgvdisplay="Extra Armor",regex=ITEM_MOD_EXTRA_ARMOR},
	[19] = {blizz="FERAL_ATTACK_POWER", zgvdisplay="Feral Attack Power",regex=ITEM_MOD_FERAL_ATTACK_POWER},
	[20] = {blizz="HEALTH_REGEN", zgvdisplay="Health Per 5 Sec.",regex=ITEM_MOD_HEALTH_REGEN},
	[21] = {blizz="HEALTH_REGENERATION", zgvdisplay="Health Regeneration",regex=ITEM_MOD_HEALTH_REGEN},
	[22] = {blizz="HEALTH", zgvdisplay="Health",regex=ITEM_MOD_HEALTH},
	[23] = {blizz="HIT", zgvdisplay="Hit",regex=ITEM_MOD_HIT_RATING},
	[24] = {blizz="HIT_MELEE", zgvdisplay="Hit Melee %",regex=ITEM_MOD_HIT_MELEE_RATING},
	[25] = {blizz="HIT_RANGED", zgvdisplay="Hit Ranged %",regex=ITEM_MOD_HIT_RANGED_RATING},
	[26] = {blizz="HIT_SPELL", zgvdisplay="Hit Spell %",regex=ITEM_MOD_HIT_SPELL_RATING},
	[27] = {blizz="MANA", zgvdisplay="Mana",regex=ITEM_MOD_MANA},
	[28] = {blizz="MANA_REGENERATION", zgvdisplay="Mana Regeneration",regex=ITEM_MOD_MANA_REGENERATION},
	[29] = {blizz="PARRY", zgvdisplay="Parry",regex=ITEM_MOD_PARRY_RATING},
	[30] = {blizz="RANGED_ATTACK_POWER", zgvdisplay="Ranged Attack Power",regex=ITEM_MOD_RANGED_ATTACK_POWER},
	[31] = {blizz="SPELL_DAMAGE_DONE", zgvdisplay="Spell Bonus Damage",regex=ITEM_MOD_SPELL_DAMAGE_DONE},
	[32] = {blizz="SPELL_HEALING_DONE", zgvdisplay="Spell Bonus Healing",regex=ITEM_MOD_SPELL_HEALING_DONE},
	[33] = {blizz="SPELL_PENETRATION", zgvdisplay="Spell Penetration",regex=ITEM_MOD_SPELL_PENETRATION},
	[34] = {blizz="SPELL_POWER", zgvdisplay="Spell Power",regex=ITEM_MOD_SPELL_POWER},
	--[35] = {blizz="WEAPONSPEED", zgvdisplay="Weapon Speed",regex=""},
}
ItemScore.KeywordsSpellSchools = {}
local SchoolPatterns = {
	enUS	= "([+-]+)([0-9]+) %s Spell Damage",
	deDE	= "([+-]+)([0-9]+) %szauberschaden",
	esES	= "([+-]+)([0-9]+) de daño de Hechizos .*%s",
	esMX	= "([+-]+)([0-9]+) daño con hechizos .*%s",
	frFR	= "([+-]+)([0-9]+) aux dégâts des sorts .*%s",
	ptBR	= "([+-]+)([0-9]+) Dano Mágico .*%s",
	ruRU = {
		"([+-]+)([0-9]+) к урону от заклинаний светлой магии",
		"([+-]+)([0-9]+) к урону от заклинаний огня",
		"([+-]+)([0-9]+) к урону от сил природы",
		"([+-]+)([0-9]+) к урону от заклинаний магии льда",
		"([+-]+)([0-9]+) к урону от заклинаний темной магии",
		"([+-]+)([0-9]+) к урону от заклинаний тайной магии"
	},
	koKR	= "%s 주문 공격력 ([+-]+)([0-9]+)", -- untested
	zhCN	= "([+-]+)([0-9]+) %s法术伤害", -- untested
	zhTW	= "([+-]+)([0-9]+) %s法术伤害", -- untested
}
local SchoolNamesEng = {"Holy","Fire","Nature","Frost","Shadow","Arcane"}
local pattern = SchoolPatterns[locale]
if pattern then
	for i=1,6 do
		local school = _G["SPELL_SCHOOL"..i.."_CAP"]
		local blizz = "SPELL_DAMAGE_DONE_"..SchoolNamesEng[i]:upper()
		local zgvdisplay = SchoolNamesEng[i].." Spell Damage"
		local regex = (type(pattern)=="string" and pattern:format(school)) or (type(pattern)=="table" and SchoolPatterns[locale][i]) or ""
		table.insert(ItemScore.KeywordsSpellSchools,{blizz=blizz,zgvdisplay=zgvdisplay,regex=regex})
	end
end
-- SPELL_DAMAGE_DONE_

for i,v in pairs(ItemScore.Keywords) do -- convert blizzard templates to lua regex match
	ItemScore.Keywords[i].regex = (ItemScore.Keywords[i].regex):gsub("1%$",""):gsub("2%$",""):gsub("3%$",""):gsub("4%$","")
	ItemScore.Keywords[i].regex = (ItemScore.Keywords[i].regex):gsub("%%d","([0-9]+)"):gsub("%%c","([+-]+)"):gsub("%%s","([0-9.]+)"):gsub("%%([0-9]+)%$","%%")
end


ItemScore.KnownKeyWords = {}
for i,v in pairs(ItemScore.Keywords) do -- create lookup table for use in popups, since GetItemStats/Delta fails on suffix items, and we need to use our cached data instead
	ItemScore.KnownKeyWords[v.blizz] = v.zgvdisplay
end

ItemScore.rules = {
	["DRUID"] = {
		[1] = { -- simmed 191007
			name="Balance",
			itemtypes = { CLOTH=1, LEATHER=1, TH_STAFF=1, MACE=1, TH_MACE=1, DAGGER=1, FIST=1 },
			stats = {MANA_REGENERATION = 0.204, SPELL_PENETRATION = 0.200, SPELL_DAMAGE_DONE = 0.136, SPELL_DAMAGE_DONE_ARCANE = 0.136, CRIT_SPELL = 0.82, HIT_SPELL = 0.80, HIT = 0.80, INTELLECT = 0.078, SPELL_DAMAGE_DONE_NATURE = 0.051, SPIRIT = 0.021, STRENGTH = 0.010, CRIT = 0.05, DAMAGE_PER_SECOND = 0.012},
			caps = { HIT_SPELL=4, },
		},
		[2] = { -- simmed 191007
			name="Feral DPS", 
			itemtypes = { CLOTH=1, LEATHER=1, TH_STAFF=1, MACE=1, TH_MACE=1, DAGGER=1, FIST=1 },
			stats = {MANA_REGENERATION = 0.526, HIT = 3.05, CRIT = 2.75, CRIT_MELEE = 2.75, AGILITY = 0.246, INTELLECT = 0.221, STRENGTH = 0.126, ATTACK_POWER = 0.114, SPIRIT = 0.032, SPELL_DAMAGE_DONE = 0.024, SPELL_PENETRATION = 0.020, HIT_SPELL = 0.17, CRIT_SPELL = 0.06},
			caps = { HIT=5, },
		},
		[3] = { -- backported
			name="Feral TANK", 
			itemtypes = { CLOTH=1, LEATHER=1, TH_STAFF=1, MACE=1, TH_MACE=1, DAGGER=1, FIST=1 },
			stats = {  ARMOR = 3.8,  EXTRA_ARMOR = 3.8,  STAMINA = 1.65,  DEFENSE_SKILL = 2,  AGILITY = 1.44,  DODGE = 1.44,  HIT = 1,  HIT_MELEE = 1,  STRENGTH = 0.8,  ATTACK_POWER = 0.64,  CRIT = 0.34,  CRIT_MELEE = 0.34,  ARMOR_PENETRATION = 0.2,  FERAL_ATTACK_POWER = 0.64,  HEALTH = 0.08,  HEALTH_REGENERATION = 0.2,  INTELLECT = 0.01,  MANA = 0.009,  MANA_REGENERATION = 0.3,  SPELL_HEALING_DONE = 0.025,  SPIRIT = 0.05},
			caps = { HIT=5, },
		},
		[4] = { -- backported
			name="Restoration", 
			itemtypes = { CLOTH=1, LEATHER=1, TH_STAFF=1, MACE=1, TH_MACE=1, DAGGER=1, FIST=1 },
			stats = {  SPELL_HEALING_DONE = 3.85,  MANA_REGENERATION = 1.7,  SPIRIT = 1.21,  INTELLECT = 1,  CRIT_SPELL = 0.87,  STAMINA = 0.5,  ARMOR = 0.005,  DEFENSE_SKILL = 0.075,  DODGE = 0.05,  EXTRA_ARMOR = 0.005,  HEALTH = 0.05,  HEALTH_REGENERATION = 0.01,  MANA = 0.09,  PARRY = 0.06, },
			caps = { HIT_SPELL=4, },
		}
	},
	["HUNTER"] = { -- cloth/leather only till 40, mail from 40
		[1] = { -- simmed 191007
			name="Beast Mastery", 
			itemtypes = { CLOTH=-40, LEATHER=-40, MAIL=40, BOW=1, CROSSBOW=1, GUN=1, TH_SWORD=1, TH_AXE=1, SWORD=1, AXE=1, FIST=1, TH_POLE=1, DAGGER=1, TH_STAFF=1, THROWN=1 },
			stats = {MP5 = 0.292, AGILITY = 0.176, INTELLECT = 0.092, SPIRIT = 0.030, HIT_RANGED = 0.08, HIT = 0.08, HIT_SPELL = 0.07, STRENGTH = 0.005, CRIT = 0.04, CRIT_RANGED = 0.04, CRIT_SPELL = 0.03, DAMAGE_PER_SECOND = 1},
			caps = { HIT=5, },
		},
		[2] = { -- simmed 191007
			name="Marksmanship", 
			itemtypes = { CLOTH=-40, LEATHER=-40, MAIL=40, BOW=1, CROSSBOW=1, GUN=1, TH_SWORD=1, TH_AXE=1, SWORD=1, AXE=1, FIST=1, TH_POLE=1, DAGGER=1, TH_STAFF=1, THROWN=1 },
			stats = {MP5 = 0.370, AGILITY = 0.197, INTELLECT = 0.098, HIT_SPELL = 0.41, HIT = 0.38, HIT_RANGED = 0.38, STRENGTH = 0.035, SPIRIT = 0.032, CRIT = 0.28, CRIT_RANGED = 0.28, ATTACK_POWER = 0.027, CRIT_SPELL = 0.25, DAMAGE_PER_SECOND = 1},
			caps = { HIT=5, },
		},
		[3] = { -- simmed 191007
			name="Survival", 
			itemtypes = { CLOTH=-40, LEATHER=-40, MAIL=40, BOW=1, CROSSBOW=1, GUN=1, TH_SWORD=1, TH_AXE=1, SWORD=1, AXE=1, FIST=1, TH_POLE=1, DAGGER=1, TH_STAFF=1, THROWN=1 },
			stats = {MANA_REGENERATION = 0.391, AGILITY = 0.247, INTELLECT = 0.121, SPIRIT = 0.073, ATTACK_POWER = 0.053, CRIT_SPELL = 0.38, SPELL_DAMAGE_DONE = 0.037, HIT_RANGED = 0.32, HIT = 0.32, SPELL_PENETRATION = 0.032, CRIT = 0.29, CRIT_RANGED = 0.29, HIT_SPELL = 0.26, STRENGTH = 0.023, DAMAGE_PER_SECOND = 1},
			caps = { HIT=5, },
		},
	},
	["MAGE"] = {
		[1] = { -- simmed 191007
			name="Arcane", 
			itemtypes = {CLOTH=1, TH_STAFF=1, DAGGER=1, SWORD=1, WAND=1,  },
			stats = {MP5 = 0.324, INTELLECT = 0.159, HIT_SPELL = 1.55, SPELL_DAMAGE_DONE = 0.117, SPELL_DAMAGE_DONE_FIRE = 0.100, SPELL_DAMAGE_DONE_FROST = 0.100, SPELL_DAMAGE_DONE_ARCANE = 0.100, SPIRIT = 0.079, CRIT_SPELL = 0.55, HIT = 0.07, DAMAGE_PER_SECOND = 0.012},
			caps = { HIT_SPELL=4, },
		},
		[2] = { -- simmed 191007
			name="Fire", 
			itemtypes = {CLOTH=1, TH_STAFF=1, DAGGER=1, SWORD=1, WAND=1,  },
			stats = {SPELL_PENETRATION = 0.340, MANA_REGENERATION = 0.333, SPELL_DAMAGE_DONE = 0.158, SPELL_DAMAGE_DONE_FIRE = 0.158, HIT_SPELL = 1.07, HIT = 1.07, INTELLECT = 0.099, CRIT_SPELL = 0.74, SPIRIT = 0.055, SPELL_DAMAGE_DONE_FROST = 0.041, SPELL_DAMAGE_DONE_ARCANE = 0.041, DAMAGE_PER_SECOND = 0.012},
			caps = { HIT_SPELL=4, },
		},
		[3] = { -- simmed 191007
			name="Frost", 
			itemtypes = {CLOTH=1, TH_STAFF=1, DAGGER=1, SWORD=1, WAND=1,  },
			stats = {MP5 = 0.369, SPELL_PENETRATION = 0.298, SPELL_DAMAGE_DONE = 0.176, SPELL_DAMAGE_DONE_FROST = 0.176, SPELL_DAMAGE_DONE_FIRE = 0.073, SPELL_DAMAGE_DONE_ARCANE = 0.070, INTELLECT = 0.113, HIT_SPELL = 1.08, HIT = 1.08, CRIT_SPELL = 0.87, SPIRIT = 0.079, CRIT = 0.05, DAMAGE_PER_SECOND = 0.012},
			caps = { HIT_SPELL=4, },
		}
	},
	["PALADIN"] = { -- cloth/leather/mail only till 40, plate from 40
		[1] = { -- backported
			name="Holy", 
			itemtypes = {CLOTH=1, LEATHER=1, MAIL=1, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, MACE=1, TH_MACE=1, TH_POLE=1, SWORD=1, TH_SWORD=1},
			stats = {  SPELL_HEALING_DONE = 5.06,  INTELLECT = 1.24,  CRIT_SPELL = 1,  MANA_REGENERATION = 0.54,  STAMINA = 0.5,  SPIRIT = 0.28,  AGILITY = 0.05,  ARMOR = 0.005,  BLOCK = 0.05,  DEFENSE_SKILL = 0.075,  DODGE = 0.05,  EXTRA_ARMOR = 0.005,  HEALTH = 0.05,  HEALTH_REGENERATION = 0.1,  MANA = 0.009,  PARRY = 0.06, },
			caps = { HIT_SPELL=4, },
		},
		[2] = { -- backported
			name="Protection", 
			itemtypes = {CLOTH=-40, LEATHER=-40, MAIL=-40, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, MACE=1, TH_MACE=1, TH_POLE=1, SWORD=1, TH_SWORD=1},
			stats = {  STAMINA = 5.46,  DEFENSE_SKILL = 2.05,  DODGE = 2,  PARRY = 2,  BLOCK = 2,  BLOCK_VALUE = 0.15,  HIT = 1.44,  HIT_MELEE = 1.44,  HIT_SPELL = 1,  STRENGTH = 0.9,  AGILITY = 0.6,  ARMOR = 0.5,  SPELL_DAMAGE_DONE = 0.44,  SPELL_DAMAGE_DONE_HOLY = 0.44,  SPELL_POWER = 0.44,  INTELLECT = 0.2,  HEALTH_REGENERATION = 2,  ARMOR_PENETRATION = 0.09,  ATTACK_POWER = 0.06,  CRIT = 1.65,  CRIT_MELEE = 0.65,  CRIT_SPELL = 0.6,  DAMAGE_PER_SECOND = 0.77,  EXTRA_ARMOR = 0.02,  HEALTH = 0.09,  MANA = 0.045,  MANA_REGENERATION = 1,  SPELL_PENETRATION = 0.03,  SPIRIT = 0.05, },
				 
			caps = { HIT=5, },
		},
		[3] = { -- simmed 191007
			name="Retribution", 
			itemtypes = {CLOTH=-40, LEATHER=-40, MAIL=-40, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, MACE=1, TH_MACE=1, TH_POLE=1, SWORD=1, TH_SWORD=1},
			stats = {CRIT = 1.18, CRIT_MELEE = 1.18, AGILITY = 0.111, HIT = 0.95, HIT_MELEE = 0.95, MANA_REGENERATION = 0.053, STRENGTH = 0.053, ATTACK_POWER = 0.041, SPELL_DAMAGE_DONE = 0.035,  SPELL_DAMAGE_DONE_HOLY = 0.035, INTELLECT = 0.030, CRIT_SPELL = 0.01, DAMAGE_PER_SECOND = 1},
			caps = { HIT=5, },
		}
	},
	["PRIEST"] = {
		[1] = { -- backported
			name="Discipline", 
			itemtypes = { CLOTH=1, MACE=1, DAGGER=1, TH_STAFF=1, WAND=1, },
			stats = {  SPELL_HEALING_DONE = 3.72,  MANA_REGENERATION = 2.48,  SPIRIT = 2.19,  INTELLECT = 2,  CRIT_SPELL = 1.52,  AGILITY = 0.05,  ARMOR = 0.005,  DEFENSE_SKILL = 0.075,  DODGE = 0.5,  EXTRA_ARMOR = 0.005,  HEALTH = 0.05,  HEALTH_REGENERATION = 0.1,  MANA = 0.09,  PARRY = 0.6,  STAMINA = 0.5, },
			caps = { HIT_SPELL=4, },
		},
		[2] = { -- backported
			name="Holy", 
			itemtypes = { CLOTH=1, MACE=1, DAGGER=1, TH_STAFF=1, WAND=1, },
			stats = {  SPELL_HEALING_DONE = 3.81,  MANA_REGENERATION = 2.73,  SPIRIT = 2.73,  INTELLECT = 2,  CRIT_SPELL = 1.64,  AGILITY = 0.05,  ARMOR = 0.005,  DEFENSE_SKILL = 0.075,  DODGE = 0.5,  EXTRA_ARMOR = 0.005,  HEALTH = 0.05,  HEALTH_REGENERATION = 0.1,  MANA = 0.09,  PARRY = 0.6,  STAMINA = 0.5, },
			caps = { HIT_SPELL=4, },
		},
		[3] = { -- backported
			name="Shadow", 
			itemtypes = { CLOTH=1, MACE=1, DAGGER=1, TH_STAFF=1, WAND=1, },
			stats = {  HIT_SPELL = 8.84,  SPELL_DAMAGE_DONE = 7.21,  SPELL_DAMAGE_DONE_SHADOW = 7.21,  SPELL_POWER = 7.23,  MANA_REGENERATION = 5,  INTELLECT = 4.19,  CRIT_SPELL = 2.36,  SPIRIT = 1,  AGILITY = 0.05,  ARMOR = 0.005,  DEFENSE_SKILL = 0.075,  DODGE = 0.5,  EXTRA_ARMOR = 0.005,  HEALTH = 0.05,  HEALTH_REGENERATION = 0.1,  MANA = 0.017,  PARRY = 0.6,  SPELL_PENETRATION = 0.08,  STAMINA = 0.5, },
			caps = { HIT_SPELL=4, },
		}
	},
	["ROGUE"] = {
		[1] = { -- simmed 191007
			name="Assassination", 
			itemtypes = { CLOTH=1, LEATHER=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, SWORD=1, THROWN=1, },
			stats = {HIT = 2.20, CRIT = 2.09, CRIT_MELEE = 2.09, AGILITY = 0.154, STRENGTH = 0.096, ATTACK_POWER = 0.095, SPIRIT = 0.013, HIT_SPELL = 0.11, DAMAGE_PER_SECOND = 1},
			caps = { HIT=24, },
		},
		[2] = { -- simmed 191007
			name="Combat", 
			itemtypes = { CLOTH=1, LEATHER=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, SWORD=1, THROWN=1, },
			stats = {AGILITY = 0.200, CRIT = 1.86, CRIT_MELEE = 1.86, STRENGTH = 0.120, HIT = 1.18, HIT_MELEE = 1.18, ATTACK_POWER = 0.117, CRIT_SPELL = 0.07, DAMAGE_PER_SECOND = 1},
			caps = { HIT=24, },
		},
		[3] = { -- simmed 191007
			name="Subtlety", 
			itemtypes = { CLOTH=1, LEATHER=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, SWORD=1, THROWN=1, },
			stats = {CRIT = 1.44, CRIT_MELEE = 1.44, HIT = 1.38, HIT_MELEE = 1.38, AGILITY = 0.125, ATTACK_POWER = 0.88, STRENGTH = 0.082, DAMAGE_PER_SECOND = 1},
			caps = { HIT=24, },
		}
	},
	["SHAMAN"] = { -- cloth/leather only till 40, mail from 40
		[1] = {  -- simmed 191007
			name="Elemental", 
			itemtypes = { CLOTH=-40, LEATHER=-40, MAIL=40, SHIELD=1, AXE=1, TH_AXE=1, DAGGER=1, FIST=1, MACE=1, TH_MACE=1, TH_STAFF=1, },
			stats = {SPELL_PENETRATION = 0.330, MANA_REGENERATION = 0.295, SPELL_DAMAGE_DONE = 0.254, SPELL_DAMAGE_DONE_NATURE = 0.254, INTELLECT = 0.237, HIT = 1.43, HIT_SPELL = 1.43, CRIT_SPELL = 0.53, SPIRIT = 0.006, DAMAGE_PER_SECOND = 0.012},
			caps = { HIT_SPELL=4, },
		},
		[2] = { -- simmed 191007
			name="Enhancement",
			itemtypes = { CLOTH=-40, LEATHER=-40, MAIL=40, SHIELD=1, AXE=1, TH_AXE=1, DAGGER=1, FIST=1, MACE=1, TH_MACE=1, TH_STAFF=1, },
			stats = {AGILITY = 0.131, CRIT = 1.04, CRIT_MELEE = 1.04, HIT = 1.00, HIT_MELEE = 1.00, ATTACK_POWER = 0.073, STRENGTH = 0.071, MANA_REGENERATION = 0.013, SPELL_PENETRATION = 0.010, HIT_SPELL = 0.09, CRIT_SPELL = 0.05, DAMAGE_PER_SECOND = 1},
			caps = { HIT=24, },
		},
		[3] = { -- backported
			name="Restoration", 
			itemtypes = { CLOTH=1, LEATHER=1, MAIL=40, SHIELD=1, AXE=1, TH_AXE=1, DAGGER=1, FIST=1, MACE=1, TH_MACE=1, TH_STAFF=1, },
			stats = {  MANA_REGENERATION = 5.28,  INTELLECT = 1.33,  SPELL_HEALING_DONE = 1,  CRIT_SPELL = 0.9,  SPIRIT = 0.61,  AGILITY = 0.05,  ARMOR = 0.005,  BLOCK = 0.05,  DEFENSE_SKILL = 0.075,  DODGE = 0.05,  EXTRA_ARMOR = 0.005,  HEALTH = 0.05,  HEALTH_REGENERATION = 0.1,  MANA = 0.009,  PARRY = 0.06,  STAMINA = 0.5, },
			caps = { HIT_SPELL=4, },
		}
	},
	["WARLOCK"] = {
		[1] = { -- backported
			name="Affliction", 
			itemtypes = { CLOTH=1, DAGGER=1, WAND=1, TH_STAFF=1, SWORD=1, },
			stats = {  SPELL_POWER = 8.4,  SPELL_DAMAGE_DONE = 8.4,  SPELL_DAMAGE_DONE_SHADOW = 8.4,  CRIT_SPELL = 4.29,  HIT_SPELL = 1,  SPELL_PENETRATION = 0.8,  INTELLECT = 0.7,  STAMINA = 0.5,  SPIRIT = 0.1,  AGILITY = 0.05,  ARMOR = 0.005,  DEFENSE_SKILL = 0.075,  DODGE = 0.05,  EXTRA_ARMOR = 0.005,  HEALTH = 0.05,  HEALTH_REGENERATION = 0.1,  MANA = 0.03,  MANA_REGENERATION = 0.1,  PARRY = 0.06, },
			caps = { HIT_SPELL=4, },
		},
		[2] = { -- backported
			name="Demonology", 
			itemtypes = { CLOTH=1, DAGGER=1, WAND=1, TH_STAFF=1, SWORD=1, },
			stats = {  SPELL_DAMAGE_DONE = 8.4,  SPELL_DAMAGE_DONE_SHADOW = 8.4,  SPELL_POWER = 8.4,  CRIT_SPELL = 7.26,  HIT_SPELL = 1,  SPELL_PENETRATION = 0.8,  INTELLECT = 0.7,  SPIRIT = 0.5,  STAMINA = 0.5,  AGILITY = 0.05,  ARMOR = 0.005,  DEFENSE_SKILL = 0.075,  DODGE = 0.5,  EXTRA_ARMOR = 0.005,  HEALTH = 0.05,  HEALTH_REGENERATION = 0.1,  MANA = 0.03,  MANA_REGENERATION = 1,  PARRY = 0.6, },
			caps = { HIT_SPELL=4, },
		},
		[3] = { -- backported
			name="Destruction", 
			itemtypes = { CLOTH=1, DAGGER=1, WAND=1, TH_STAFF=1, SWORD=1, },
			stats = {  SPELL_DAMAGE_DONE = 11.2,  SPELL_DAMAGE_DONE_SHADOW = 11.2,  SPELL_POWER = 11.2,  CRIT_SPELL = 9.57,  HIT_SPELL = 1,  SPELL_PENETRATION = 0.8,  INTELLECT = 0.78,  SPIRIT = 0.52,  STAMINA = 0.5,  AGILITY = 0.05,  ARMOR = 0.005,  DEFENSE_SKILL = 0.075,  DODGE = 0.5,  EXTRA_ARMOR = 0.005,  HEALTH = 0.05,  HEALTH_REGENERATION = 0.1,  MANA = 0.028,  MANA_REGENERATION = 0.65,  PARRY = 0.06, },
			caps = { HIT_SPELL=4, },
		}
	},
	["WARRIOR"] = { -- cloth/leather,mail only till 40, plate from 40
		[1] = { -- simmed 191007
			name="Arms", 
			itemtypes = {CLOTH=-40, LEATHER=-40, MAIL=-40, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, TH_MACE=1, TH_POLE=1, TH_STAFF=1, SWORD=1, TH_SWORD=1, OFFHAND=1, MISCARM=1, THROWN=1,  },
			stats = {CRIT = 1.73, CRIT_MELEE = 1.73, STRENGTH = 0.156, HIT = 1.46, HIT_MELEE = 1.46, AGILITY = 0.079, ATTACK_POWER = 0.070, DAMAGE_PER_SECOND = 1},
			caps = { HIT=5, },
		},
		[2] = { -- simmed 191007
			name="Fury", 
			itemtypes = {CLOTH=-40, LEATHER=-40, MAIL=-40, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, TH_MACE=1, TH_POLE=1, TH_STAFF=1, SWORD=1, TH_SWORD=1, OFFHAND=1, MISCARM=1, THROWN=1,  },
			stats = {CRIT = 3.32, CRIT_MELEE = 3.32, STRENGTH = 0.285, HIT = 2.24, HIT_MELEE = 2.24, AGILITY = 0.160, ATTACK_POWER = 0.135, DAMAGE_PER_SECOND = 1},
			caps = { HIT=5, },
		},
		[3] = { -- backported
			name="Prot", 
			itemtypes = {CLOTH=-40, LEATHER=-40, MAIL=-40, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, TH_MACE=1, TH_POLE=1, TH_STAFF=1, SWORD=1, TH_SWORD=1, OFFHAND=1, MISCARM=1, THROWN=1,  },
			stats = {  STAMINA = 7,  ARMOR = 6.96,  PARRY = 6,  DODGE = 6,  DEFENSE_SKILL = 5.82,  STRENGTH = 3.33,  AGILITY = 2.59,  BLOCK_VALUE = 2.35,  BLOCK = 1.95,  HEALTH_REGENERATION = 2,  ARMOR_PENETRATION = 0.19,  ATTACK_POWER = 0.06,  CRIT = 0.38,  CRIT_MELEE = 0.38,  EXTRA_ARMOR = 0.02,  HEALTH = 0.09,  HIT = 0.63,  HIT_MELEE = 0.63,  SPIRIT = 0.05, },
			caps = { HIT=5, },
		}
	},
}
ItemScore.Builds={}
for class,classData in pairs(ItemScore.rules) do
	ItemScore.Builds[ZGV.ClassToNumber[class]] = {}
	for buildid,builddata in pairs(classData) do
		ItemScore.Builds[ZGV.ClassToNumber[class]][buildid] = builddata.name
	end
end



ItemScore.Unique_Equipped_Families = { }-- those items are unique equipped, but do not return GetItemUniqueness values


ItemScore.Item_Weapon_Types = {
	[0] = "AXE",
	[1] = "TH_AXE",
	[2] = "BOW",
	[3] = "GUN",
	[4] = "MACE",
	[5] = "TH_MACE",
	[6] = "TH_POLE",
	[7] = "SWORD",
	[8] = "TH_SWORD",
	[9] = "WARGLAIVE",
	[10] = "TH_STAFF",
	[11] = "DRUID_BEAR",
	[12] = "DRUID_CAT",
	[13] = "FIST",
	[14] = "MISCWEAP",
	[15] = "DAGGER",
	[16] = "THROWN",
	[17] = "SPEAR",
	[18] = "CROSSBOW",
	[19] = "WAND",
	[20] = "FISHPOLE",
	}

ItemScore.Item_Armor_Types = {
	[0] = "JEWELERY", -- necklace, rings and trinkets, also some cosmetic armor
	[1] = "CLOTH",
	[2] = "LEATHER",
	[3] = "MAIL",
	[4] = "PLATE",
	[5] = "COSMETIC",
	[6] = "SHIELD",
	}

ItemScore.TypeToSlot = {
	INVTYPE_WEAPON = INVSLOT_MAINHAND, -- dual wield handled in GetValidSlots
	INVTYPE_WEAPONMAINHAND = INVSLOT_MAINHAND,
	INVTYPE_2HWEAPON = INVSLOT_MAINHAND, -- titan fury hanndled in GetValidSlots
	INVTYPE_WEAPONOFFHAND = INVSLOT_OFFHAND,
	INVTYPE_SHIELD = INVSLOT_OFFHAND,
	INVTYPE_THROWN = INVSLOT_RANGED,
	INVTYPE_RANGED = INVSLOT_RANGED,
	INVTYPE_RANGEDRIGHT = INVSLOT_RANGED,
	INVTYPE_HOLDABLE = INVSLOT_OFFHAND,
	INVTYPE_HEAD = INVSLOT_HEAD,
	INVTYPE_NECK = INVSLOT_NECK,
	INVTYPE_SHOULDER = INVSLOT_SHOULDER,
	INVTYPE_CLOAK = INVSLOT_BACK,
	INVTYPE_CHEST = INVSLOT_CHEST,
	INVTYPE_ROBE = INVSLOT_CHEST,
	INVTYPE_WRIST = INVSLOT_WRIST,
	INVTYPE_HAND = INVSLOT_HAND,
	INVTYPE_WAIST = INVSLOT_WAIST,
	INVTYPE_LEGS = INVSLOT_LEGS,
	INVTYPE_FEET = INVSLOT_FEET,
	INVTYPE_FINGER = INVSLOT_FINGER1, -- second slot handled in GetValidSlots
	INVTYPE_TRINKET = INVSLOT_TRINKET1, -- second slot handled in GetValidSlots
}

ItemScore.SkillNames = { -- gets trimmed in a moment										-- needs checking
	-- Thanks go to simonstone for zhTW translation
	--{id=95,		enUS="Defense",			deDE="Verteidigung",		esES="Defensa",			esMX="Defensa",			frFR="Défense",			itIT="Defense",			ptBR="Defesa",			ruRU="Защита",				koKR="방어",		zhCN="防御",	zhTW="防禦",	},	  
	DUALWIELD = {id=118,	enUS="Dual Wield",		deDE="Beidhändigkeit",		esES="Empuñadura dual",		esMX="Doble empuñadura",	frFR="Ambidextrie",		itIT="Dual Wield",		ptBR="Empunhar Duas Armas",	ruRU="Бой двумя руками",		koKR="쌍수 무기",		zhCN="双武器",	zhTW="雙持",	},		      
	SWORD = {id=43,		enUS="Swords",			deDE="Schwerter",		esES="Espadas",			esMX="Espadas",			frFR="Epées",			itIT="Swords",			ptBR="Espadas",			ruRU="Мечи",				koKR="도검류",		zhCN="单手剑",	zhTW="單手劍",	},	      
	WAND = {id=228,		enUS="Wands",			deDE="Zauberstäbe",		esES="Varitas",			esMX="Varitas",			frFR="Baguettes",		itIT="Wands",			ptBR="Varinhas",		ruRU="Жезлы",				koKR="마법봉류",		zhCN="魔杖",	zhTW="魔杖",	},	      
	TH_SWORD = {id=55,	enUS="Two-Handed Swords",	deDE="Zweihandschwerter",	esES="Espadas de dos manos",	esMX="Espadas de dos manos",	frFR="Epées à deux mains",	itIT="Two-Handed Swords",	ptBR="Espadas de Duas Mãos",	ruRU="Двуручные мечи",			koKR="양손 도검류",	zhCN="双手剑",	zhTW="雙手劍",	},		      
	THROWN = {id=176,	enUS="Thrown",			deDE="Wurfwaffen",		esES="Armas arrojadizas",	esMX="Armas arrojadizas",	frFR="Armes de jet",		itIT="Thrown",			ptBR="Arremesso",		ruRU="Метательное оружие",		koKR="투척 무기류",	zhCN="投掷武器",	zhTW="投擲武器",	},	      
	FIST = {id=473,		enUS="Fist Weapons",		deDE="Faustwaffen",		esES="Armas de puño",		esMX="Armas de puño",		frFR="Armes de pugilat",	itIT="Fist Weapons",		ptBR="Armas de punho",		ruRU="Кистевое оружие",			koKR="장착 무기류",	zhCN="拳套",	zhTW="拳套",	},	      
	TH_MACE = {id=160,	enUS="Two-Handed Maces",	deDE="Zweihandstreitkolben",	esES="Mazas de dos manos",	esMX="Mazas de dos manos",	frFR="Masses à deux mains",	itIT="Two-Handed Maces",	ptBR="Maças de Duas Mãos",	ruRU="Двуручное дробящее оружие",	koKR="양손 둔기류",	zhCN="双手锤",	zhTW="雙手錘",	},		      
	TH_AXE = {id=172,	enUS="Two-Handed Axes",		deDE="Zweihandäxte",		esES="Hachas de dos manos",	esMX="Hachas de dos manos",	frFR="Haches à deux mains",	itIT="Two-Handed Axes",		ptBR="Machados de Duas Mãos",	ruRU="Двуручные топоры",		koKR="양손 도끼류",	zhCN="双手斧",	zhTW="雙手斧",	},		      
	AXE = {id=44,		enUS="Axes",			deDE="Äxte",			esES="Hachas",			esMX="Hachas",			frFR="Haches",			itIT="Axes",			ptBR="Machados",		ruRU="Топоры",				koKR="도끼류",		zhCN="单手斧",	zhTW="單手斧",	},		      
	GUN = {id=46,		enUS="Guns",			deDE="Schusswaffen",		esES="Armas de fuego",		esMX="Armas de fuego",		frFR="Armes à feu",		itIT="Guns",			ptBR="Armas de Fogo",		ruRU="Огнестрельное оружие",		koKR="총기류",		zhCN="枪械",	zhTW="槍械",	},		      
	TH_POLE = {id=229,	enUS="Polearms",		deDE="Stangenwaffen",		esES="Armas de asta",		esMX="Armas de asta",		frFR="Armes d'hast",		itIT="Polearms",		ptBR="Armas de Haste",		ruRU="Древковое оружие",		koKR="장창류",		zhCN="长柄武器",	zhTW="長柄武器",	},	      
	BOW = {id=45,		enUS="Bows",			deDE="Bogen",			esES="Arcos",			esMX="Arcos",			frFR="Arcs",			itIT="Bows",			ptBR="Arcos",			ruRU="Луки",				koKR="활류",		zhCN="弓",	zhTW="弓",	},		      
	CROSSBOW = {id=226,	enUS="Crossbows",		deDE="Armbrüste",		esES="Ballestas",		esMX="Ballestas",		frFR="Arbalètes",		itIT="Crossbows",		ptBR="Bestas",			ruRU="Арбалеты",			koKR="석궁류",		zhCN="弩",	zhTW="弩",	},		      
	TH_STAFF = {id=136,	enUS="Staves",			deDE="Stäbe",			esES="Bastones",		esMX="Bastones",		frFR="Bâtons",			itIT="Staves",			ptBR="Báculos",			ruRU="Посохи",				koKR="지팡이류",		zhCN="法杖",	zhTW="法杖",	},		      
	-- {id=162,		enUS="Unarmed",			deDE="Unbewaffnet",		esES="Sin armas",		esMX="Sin armas",		frFR="Mains nues",		itIT="Unarmed",			ptBR="Combate desarmado",	ruRU="Рукопашный бой",			koKR="맨손 전투",		zhCN="徒手战斗",	zhTW="未裝備",	},		      
	MACE = {id=54,		enUS="Maces",			deDE="Streitkolben",		esES="Mazas",			esMX="Mazas",			frFR="Masse",			itIT="Maces",			ptBR="Maças",			ruRU="Дробящее оружие",			koKR="둔기류",		zhCN="单手锤",	zhTW="單手錘",	},	      
	DAGGER = {id=173,	enUS="Daggers",			deDE="Dolche",			esES="Dagas",			esMX="Dagas",			frFR="Dagues",			itIT="Daggers",			ptBR="Adagas",			ruRU="Кинжалы",				koKR="단검류",		zhCN="匕首",	zhTW="匕首",	},		      
	PLATE = {id=293,	enUS="Plate Mail",		deDE="Plattenpanzer",		esES="Armadura de placas",	esMX="Armadura de placas",	frFR="Armure en plaques",	itIT="Plate Mail",		ptBR="Armadura de Placa",	ruRU="Латы",				koKR="판금 갑옷",		zhCN="板甲",	zhTW="鎧甲",	},		      
	MAIL = {id=413,		enUS="Mail",			deDE="Schwere Rüstung",		esES="Mallas",			esMX="Mallas",			frFR="Mailles",			itIT="Mail",			ptBR="Malha",			ruRU="Кольчужные доспехи",		koKR="사슬",		zhCN="锁甲",	zhTW="鎖甲",	},	      
	CLOTH = {id=415,	enUS="Cloth",			deDE="Stoff",			esES="Tela",			esMX="Tela",			frFR="Tissu",			itIT="Cloth",			ptBR="Tecido",			ruRU="Тканевые доспехи",		koKR="천",		zhCN="布甲",	zhTW="布甲",	},		      
	SHIELD = {id=433,	enUS="Shield",			deDE="Schild",			esES="Escudo",			esMX="Escudo",			frFR="Bouclier",		itIT="Shield",			ptBR="Escudo",			ruRU="Щит",				koKR="방패",		zhCN="盾牌",	zhTW="盾牌",	},		      
	LEATHER = {id=414,	enUS="Leather",			deDE="Leder",			esES="Cuero",			esMX="Cuero",			frFR="Cuir",			itIT="Leather",			ptBR="Couro",			ruRU="Кожаные доспехи",			koKR="가죽",		zhCN="皮甲",	zhTW="皮甲",	},		      
}
ItemScore.SkillNamesRev={}

for i,skillset in pairs(ItemScore.SkillNames) do -- drop other languages
	local name = skillset[locale] or skillset.enUS
	ItemScore.SkillNames[i] = name
	ItemScore.SkillNamesRev[name] = i
end

-- Build simpler defaults table for use in options
ItemScore.Defaults = {}
for class,specs in pairs(ItemScore.rules) do
 ZGV.ItemScore.Defaults[class] = {}
 for spec,data in pairs(specs) do
	ZGV.ItemScore.Defaults[class][spec] = {}

	for name,v in pairs(data.stats) do
		table.insert(ZGV.ItemScore.Defaults[class][spec],{name=name,weight=v})
	end
	sort(ZGV.ItemScore.Defaults[class][spec],function(a,b) return a.name<b.name end)
 end
end 