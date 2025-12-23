local L = LibStub("AceLocale-3.0"):NewLocale("NovaConsumesHelper", "enUS", true, true);

L["missingSlot"] = "No item currently equipped in %s slot.";
L["missingSpellname"] = "Missing spell name for spellID %s, couldn't create cast macro.";

L["leftClickMinimapButton"] = "Left-Click|r Show/Hide Consumes";
L["rightClickMinimapButton"] = "Right-Click|r Open Config";

L["minimapButtonTitle"] = "Show Minimap Button";
L["minimapButtonDesc"] = "Show button on the minimap?";

L["showLabelsTitle"] = "Show Desc Labels";
L["showLabelsDesc"] = "Show small description labels on each consume, it may help you to remember which button is which consume.";

L["loadInDungeonsTitle"] = "Load In Dungeons";
L["loadInDungeonsDesc"] = "Load consumes frame inside dungeons.";

L["loadInRaidsTitle"] = "Load In Raids";
L["loadInRaidsDesc"] = "Load consumes frame inside raids.";

L["loadInBattlegroundsTitle"] = "Load In Battlegrounds";
L["loadInBattlegroundsDesc"] = "Load consumes frame inside battlegrounds.";

L["loadInArenaTitle"] = "Load In Arena";
L["loadInArenaDesc"] = "Load consumes frame inside arena.";

L["loadEverywhereTitle"] = "Load Everywhere";
L["loadEverywhereDesc"] = "Load consumes frame everywhere in the world, even outside dungs/raids etc.";

L["loadInPartyGroupTitle"] = "Load in Party Group";
L["loadInPartyGroupDesc"] = "Load consumes frame while in a 5 man group while anywhere in the world.";

L["loadInRaidGroupTitle"] = "Load in Raid Group";
L["loadInRaidGroupDesc"] = "Load consumes frame while in a raid group while anywhere in the world.";

L["consumesListDesc"] = "Choose what consumes to show";

L["generalOptionsDesc"] = "Consumes Bar Display Options";

L["lowDurationThresholdTitle"] = "Low Duration Threshold";
L["lowDurationThresholdDesc"] = "When a buff is under this many seconds duration it will show a timer in red text and let you click it to refresh the buff.";

L["buttonSizeTitle"] = "Button Size";
L["buttonSizeDesc"] = "How big do you want each consume button to be?";

L["consumesSlotUniversalDesc"] = "Choose if to display a consume for this %s slot."

L["buttonsWideTitle"] = "Buttons Per Row";
L["buttonWideDesc"] = "How many consume buttons wide to display before starting a new row?";

L["paddingTitle"] = "Padding";
L["paddingDesc"] = "The padding between each button.";

L["growthDirectionTitle"] = "Growth Direction";
L["growthDirectionDesc"] = "Grow the buttons up or down once a row has reached the buttons wide limit?";

L["borderAnimationTitle"] = "Border Animation";
L["borderAnimationDesc"] = "When a consume is missing this border animation will show around the button.";
					
L["minLevelTitle"] = "Min Level";
L["minLevelDesc"] = "Minimum character level required to display the consumes frame for alts.";

L["showItemCountTitle"] = "Show Item Count";
L["showItemCountDesc"] = "Show how many of each consume you have as a number on the button.";

L["showItemCountWhenBuffedTitle"] = "Item Count When Buffed";
L["showItemCountWhenBuffedDesc"] = "Show item counts even when buffed and the button is greyed out.";

L["hideWhenBuffedTitle"] = "Hide When Buffed";
L["hideWhenBuffedDesc"] = "This will hide the consume button for a specific buff when you have that buff active, so the consumes only shows when you are missing that buff.";

L["resetFramePositionTitle"] = "Reset Frame Position";
L["resetFramePositionDesc"] = "Reset the consumes bar back to default position in middle of the screen.";

L["alwaysShowDurationTitle"] = "Always Show Duration";
L["alwaysShowDurationDesc"] = "Always show duration on the button even when the button is disabled when buffed? Disable this if you just want it to show a green checkmark like earlier versions.";

L["showTooltipsTitle"] = "Show Tooltips";
L["showTooltipsDesc"] = "Show item tooltips when you mouseover a consume button.";

L["hideInCapitalCityTitle"] = "Hide in Capital City";
L["hideInCapitalCityDesc"] = "Hide the consumes bar while you're in capital cities.";

L["lockAllFramesTitle"] = "Lock All Frames";
L["lockAllFramesDesc"] = "Lock and Unlock all frames so you can move them around (You can also type /nch lock and /nch unlock).";

L["protListDesc"] = "Choose what Protection Potions to show"

L["protOptionsDesc"] = "Protection Potions Display Options";
L["greaterProtListDesc"] = "Greater";
L["lesserProtListDesc"] = "Lesser";

L["protShowGreaterArcaneTitle"] = "Greater Arcane";
L["protShowGreaterArcaneDesc"] = "Show Greater Arcane potions on the bar?";

L["protShowGreaterFireTitle"] = "Greater Fire";
L["protShowGreaterFireDesc"] = "Show Greater Fire potions on the bar?";

L["protShowGreaterFrostTitle"] = "Greater Frost";
L["protShowGreaterFrostDesc"] = "Show Greater Frost potions on the bar?";

L["protShowGreaterNatureTitle"] = "Greater Nature";
L["protShowGreaterNatureDesc"] = "Show Greater Nature potions on the bar?";

L["protShowGreaterShadowTitle"] = "Greater Shadow";
L["protShowGreaterShadowDesc"] = "Show Greater Shadow potions on the bar?";

L["protShowGreaterHolyTitle"] = "Greater Holy";
L["protShowGreaterHolyDesc"] = "Show Greater Holy potions on the bar?";

L["protShowFrozenRuneTitle"] = "Frozen Rune";
L["protShowFrozenRuneDesc"] = "Show Frozen Runes on the bar?";

L["protShowFireTitle"] = "Fire";
L["protShowFireDesc"] = "Show Fire potions on the bar?";

L["protShowFrostTitle"] = "Frost";
L["protShowFrostDesc"] = "Show Frost potions on the bar?";

L["protShowNatureTitle"] = "Nature";
L["protShowNatureDesc"] = "Show Nature potions on the bar?";

L["protShowShadowTitle"] = "Shadow";
L["protShowShadowDesc"] = "Show Shadow potions on the bar?";

L["protShowHolyTitle"] = "Holy";
L["protShowHolyDesc"] = "Show Holy potions on the bar?";

L["protShowHolyTitle"] = "Holy";
L["protShowHolyDesc"] = "Show Holy potions on the bar?";

L["extraSlotsDesc"] = "Extra Bonus Slots  |cFF9CD6DE(Scroll Down)|r";
L["extraSlotsDesc2"] = "These are extra slots that were added to the addon after creation, use them if you want lots of consumes shown (or just use profiles to swap between sets instead).";

L["showProgressTextTitle"] = "Show Absorb Text";
L["showProgressTextDesc"] = "Show text near the button to show how much absorb is left?";

L["progressTextPositionTitle"] = "Absorb Text Position";
L["progressTextPositionDesc"] = "Where should the absorb text be displayed?";

L["showProgressBarTitle"] = "Show Absorb Bar";
L["showProgressBarDesc"] = "Show a progress bar near the button to show how much absorb is left?";

L["progressBarPositionTitle"] = "Absorb Bar Position";
L["progressBarPositionDesc"] = "Where should the absorb bar be displayed?";

L["colorizeTextBySchoolTitle"] = "School Colors Text"
L["colorizeTextBySchoolDesc"] = "Colorize the absorb amount left by magic school type?";

L["protAbsorbTextDesc"] = "|cFFFFFF00A Note on Absorb amounts:|r The classic game client doesn't give exact absorb buff numbers so we need to guess and start off with an average of the minimum and maximum a potion can give. Then we subtract incoming damage from that. Your actual absorb amount left could be slightly more or less than shown but it will be close enough to be a good indicator.";

L["hideXTitle"] = "Hide the X";
L["hideXDesc"] = "Hide the red X that's displayed on missing buff buttons";

L["inverseDesaturateTitle"] = "Reverse Desaturate";
L["inverseDesaturateDesc"] = "This will make it so buttons are greyed out when you don't have the buff instead of when you do.";

L["alphaTitle"] = "Bar Alpha";
L["alphaDesc"] = "Set how transparent the bar should be.";

L["desaturateAlphaTitle"] = "Desaturate Alpha";
L["desaturateAlphaDesc"] = "Set how transparent a button should be when desaturated (greyed out).";

L["hideWhenNoItemsTitle"] = "Hide When No Items";
L["hideWhenNoItemsDesc"] = "Hide the button for a consume when you have none of that item in your bags.";

L["hideUniqueTitle"] = "Hide Unique Items";
L["hideUniqueDesc"] = "Hide unique items when you have none in your bags (like zanza/r.o.i.d.s etc), this is only for items that are unique (1) and not multiple use unique items.";

L["disableMenuBarTitle"] = "Disable Mouseover Menu";
L["disableMenuBarDesc"] = "Disable the config and profiles button from showing when you mouseover the bar (also effects protection potions bar).";

L["disableStateAutomationTitle"] = "Disable Load Automation";
L["disableStateAutomationDesc"] = "Disable the consumes bar from loading itself via the load options that are ticked, instead you must left click the minimap button or type /nch show and hide to load the bar (also effects protection potions bar).";