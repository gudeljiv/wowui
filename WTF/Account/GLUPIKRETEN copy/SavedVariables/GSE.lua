
GSEOptions = {
	["HideLoginMessage"] = false,
	["Update2415"] = true,
	["resetOOC"] = true,
	["Update2410"] = true,
	["use2"] = false,
	["STANDARDFUNCS"] = "|cff55ddcc",
	["showGSEUsers"] = false,
	["UnfoundSpellIDs"] = {
	},
	["Update2305"] = true,
	["COMMENT"] = "|cff55cc55",
	["use14"] = false,
	["Updated801"] = true,
	["CreateGlobalButtons"] = false,
	["EQUALS"] = "|cffccddee",
	["use11"] = false,
	["sendDebugOutputToChatWindow"] = false,
	["overflowPersonalMacros"] = false,
	["autoCreateMacroStubsClass"] = true,
	["debug"] = false,
	["useTranslator"] = false,
	["use6"] = false,
	["CommandColour"] = "|cFF00FF00",
	["PromptSample"] = true,
	["UNKNOWN"] = "|cffff6666",
	["UseWLMExportFormat"] = true,
	["DefaultImportAction"] = "MERGE",
	["DisabledSequences"] = {
	},
	["showGSEoocqueue"] = true,
	["DebugPrintModConditionsOnKeyPress"] = false,
	["sendDebugOutputToDebugOutput"] = false,
	["hideSoundErrors"] = false,
	["ErroneousSpellID"] = {
	},
	["AddInPacks"] = {
		["Samples"] = {
			["Name"] = "Samples",
			["Version"] = "2.4.15",
			["SequenceNames"] = {
				"Assorted Sample Macros", -- [1]
			},
		},
	},
	["STRING"] = "|cff888888",
	["clearUIErrors"] = false,
	["DefaultDisabledMacroIcon"] = "Interface\\Icons\\INV_MISC_BOOK_08",
	["Update2411"] = true,
	["TitleColour"] = "|cFFFF0000",
	["hideUIErrors"] = false,
	["initialised"] = true,
	["autoCreateMacroStubsGlobal"] = false,
	["DebugModules"] = {
		["Translator"] = false,
		["GUI"] = false,
		["Storage"] = false,
		["Versions"] = false,
		["Editor"] = false,
		["API"] = false,
		["Viewer"] = false,
		["Transmission"] = false,
	},
	["INDENT"] = "|cffccaa88",
	["MacroResetModifiers"] = {
		["Alt"] = false,
		["LeftControl"] = false,
		["LeftButton"] = false,
		["LeftAlt"] = false,
		["AnyMod"] = false,
		["RightButton"] = false,
		["Shift"] = false,
		["Button5"] = false,
		["RightShift"] = false,
		["LeftShift"] = false,
		["Control"] = false,
		["RightControl"] = false,
		["MiddleButton"] = false,
		["Button4"] = false,
		["RightAlt"] = false,
	},
	["filterList"] = {
		["All"] = false,
		["Spec"] = true,
		["Global"] = true,
		["Class"] = true,
	},
	["EmphasisColour"] = "|cFFFFFF00",
	["UseVerboseExportFormat"] = false,
	["WOWSHORTCUTS"] = "|cffddaaff",
	["RealtimeParse"] = false,
	["deleteOrphansOnLogout"] = false,
	["ActiveSequenceVersions"] = {
	},
	["UnfoundSpells"] = {
		[""] = true,
		["Charge"] = true,
		["Hamstring"] = true,
		["Cleave"] = true,
		["Execute"] = true,
		["Whirlwind"] = true,
		["Battle Stance"] = true,
		["Sweeping Strikes"] = true,
		["Mortal Strike"] = true,
		["Thunder Clap"] = true,
		["Rend"] = true,
		["null"] = true,
		["Bloodrage"] = true,
		["Overpower"] = true,
		["Null"] = true,
		["Heroic Strike"] = true,
	},
	["AuthorColour"] = "|cFF00D1FF",
	["requireTarget"] = false,
	["showMiniMap"] = {
		["hide"] = true,
	},
	["NUMBER"] = "|cffffaa00",
	["use12"] = false,
	["use13"] = false,
	["NormalColour"] = "|cFFFFFFFF",
	["CONCAT"] = "|cffcc7777",
	["saveAllMacrosLocal"] = true,
	["setDefaultIconQuestionMark"] = true,
	["KEYWORD"] = "|cff88bbdd",
	["use1"] = false,
}
GSELibrary = {
	{
		["ARMS_LEVELING_"] = {
			["Dungeon"] = 1,
			["Talents"] = "CLASSIC",
			["Default"] = 1,
			["SpecID"] = 1,
			["Author"] = "Barbarach@Blaumeux",
			["MacroVersions"] = {
				{
					"/cast [mod:shift] Sweeping Strikes", -- [1]
					"/cast Execute", -- [2]
					"/cast Overpower", -- [3]
					"/castsequence  reset=target  Rend, , Null", -- [4]
					"/cast Mortal Strike", -- [5]
					"/cast [nomod] Heroic Strike", -- [6]
					"/cast [mod:shift] Cleave", -- [7]
					["LoopLimit"] = "",
					["PostMacro"] = {
					},
					["Head"] = false,
					["Neck"] = false,
					["Belt"] = false,
					["Ring1"] = false,
					["KeyPress"] = {
						"/targetenemy [noharm,nodead]", -- [1]
						"/cast Charge", -- [2]
						"/cast [combat] Bloodrage", -- [3]
					},
					["Ring2"] = false,
					["Trinket2"] = false,
					["StepFunction"] = "Priority",
					["KeyRelease"] = {
						"/startattack", -- [1]
					},
					["PreMacro"] = {
						"/cast [nocombat] Battle Stance", -- [1]
					},
					["Trinket1"] = false,
				}, -- [1]
				{
					"/cast [mod:shift] Sweeping Strikes", -- [1]
					"/cast Execute", -- [2]
					"/cast Overpower", -- [3]
					"/cast Whirlwind", -- [4]
					"/cast Thunder Clap", -- [5]
					"/castsequence  reset=target  Rend, , Null", -- [6]
					"/cast Mortal Strike", -- [7]
					"/cast [nomod] Heroic Strike", -- [8]
					"/cast [mod:shift] Cleave", -- [9]
					["LoopLimit"] = "",
					["PostMacro"] = {
					},
					["Head"] = false,
					["Neck"] = false,
					["Belt"] = false,
					["Ring1"] = false,
					["Trinket1"] = false,
					["Ring2"] = false,
					["KeyPress"] = {
						"/targetenemy [noharm,nodead]", -- [1]
						"/cast Charge", -- [2]
						"/cast [combat] Bloodrage", -- [3]
					},
					["StepFunction"] = "Priority",
					["KeyRelease"] = {
						"/startattack", -- [1]
					},
					["PreMacro"] = {
						"/cast [nocombat] Battle Stance", -- [1]
					},
					["Trinket2"] = false,
				}, -- [2]
			},
			["ManualIntervention"] = false,
		},
		["ARMS"] = {
			["Dungeon"] = 1,
			["Talents"] = "CLASSIC",
			["Default"] = 1,
			["SpecID"] = 1,
			["Author"] = "Barbarach@Blaumeux",
			["MacroVersions"] = {
				{
					"/cast [mod:shift] Sweeping Strikes", -- [1]
					"/cast Execute", -- [2]
					"/cast Overpower", -- [3]
					"/castsequence  reset=target  Rend, , Null", -- [4]
					"/cast Mortal Strike", -- [5]
					"/cast [nomod] Heroic Strike", -- [6]
					"/cast [mod:shift] Cleave", -- [7]
					["LoopLimit"] = "",
					["PostMacro"] = {
					},
					["Head"] = false,
					["Neck"] = false,
					["Belt"] = false,
					["Ring1"] = false,
					["KeyPress"] = {
						"/targetenemy [noharm,nodead]", -- [1]
						"/cast Charge", -- [2]
						"/cast [combat] Bloodrage", -- [3]
					},
					["Ring2"] = false,
					["Trinket2"] = false,
					["StepFunction"] = "Priority",
					["KeyRelease"] = {
						"/startattack", -- [1]
					},
					["PreMacro"] = {
						"/cast [nocombat] Battle Stance", -- [1]
					},
					["Trinket1"] = false,
				}, -- [1]
				{
					"/cast [mod:shift] Sweeping Strikes", -- [1]
					"/cast Execute", -- [2]
					"/cast Overpower", -- [3]
					"/cast Whirlwind", -- [4]
					"/cast Thunder Clap", -- [5]
					"/castsequence  reset=target  Rend, , Null", -- [6]
					"/cast Mortal Strike", -- [7]
					"/cast [nomod] Heroic Strike", -- [8]
					"/cast [mod:shift] Cleave", -- [9]
					["LoopLimit"] = "",
					["PostMacro"] = {
					},
					["Head"] = false,
					["Neck"] = false,
					["Belt"] = false,
					["Ring1"] = false,
					["Trinket1"] = false,
					["Ring2"] = false,
					["KeyPress"] = {
						"/targetenemy [noharm,nodead]", -- [1]
						"/cast Charge", -- [2]
						"/cast [combat] Bloodrage", -- [3]
					},
					["StepFunction"] = "Priority",
					["KeyRelease"] = {
						"/startattack", -- [1]
					},
					["PreMacro"] = {
						"/cast [nocombat] Battle Stance", -- [1]
					},
					["Trinket2"] = false,
				}, -- [2]
			},
			["ManualIntervention"] = false,
		},
	}, -- [1]
	[0] = {
	},
}
