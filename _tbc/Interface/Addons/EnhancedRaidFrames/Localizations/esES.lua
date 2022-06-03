-- Enhanced Raid Frames is a World of Warcraft® user interface addon.
-- Copyright (c) 2017-2021 Britt W. Yazel
-- This code is licensed under the MIT license (see LICENSE for details)

local L = LibStub("AceLocale-3.0"):NewLocale("EnhancedRaidFrames", "esES", false)

if not L then return end

--[[Translation missing --]]
L["Aborting."] = "Aborting."
--[[Translation missing --]]
L["Animations"] = "Animations"
--[[Translation missing --]]
L["Attached to Cursor"] = "Attached to Cursor"
--[[Translation missing --]]
L["Aura Watch List"] = "Aura Watch List"
--[[Translation missing --]]
L["auras_desc"] = "The list of buffs, debuffs, and/or wildcards to watch in this position"
--[[Translation missing --]]
L["auras_usage"] = "Any valid aura name or spell ID found in the game, spelled correctly, should work"
--[[Translation missing --]]
L["Background Opacity"] = "Background Opacity"
--[[Translation missing --]]
L["backgroundAlpha_desc"] = "The opacity percentage of the raid frame background"
--[[Translation missing --]]
L["Blizzard Default"] = "Blizzard Default"
--[[Translation missing --]]
L["blizzardRaidOptionsButton_desc"] = "Launch the built-in raid profiles interface configuration menu"
--[[Translation missing --]]
L["Bottom Center"] = "Bottom Center"
--[[Translation missing --]]
L["Bottom Left"] = "Bottom Left"
--[[Translation missing --]]
L["Bottom Right"] = "Bottom Right"
--[[Translation missing --]]
L["Color"] = "Color"
--[[Translation missing --]]
L["Color By Debuff Type"] = "Color By Debuff Type"
--[[Translation missing --]]
L["Color By Remaining Time"] = "Color By Remaining Time"
--[[Translation missing --]]
L["colorByDebuff_desc"] = "Color is determined by the type of debuff"
--[[Translation missing --]]
L["colorByTime_desc"] = "Color is determined based on the remaining time"
--[[Translation missing --]]
L["colorByTime_high_desc"] = "The time (in seconds) for the upper boundary"
--[[Translation missing --]]
L["colorByTime_low_desc"] = "The time (in seconds) for the lower boundary"
--[[Translation missing --]]
L["colorOverride_desc"] = "this will override the normal coloring"
--[[Translation missing --]]
L["combatWildcard_desc"] = "if the unit is combat flagged"
--[[Translation missing --]]
L["Countdown"] = "Countdown"
--[[Translation missing --]]
L["Curse"] = "Curse"
--[[Translation missing --]]
L["curseWildcard_desc"] = "any curse debuffs"
--[[Translation missing --]]
L["customRange_desc"] = "Overrides the default out-of-range indicator distance (default 40 yards)"
--[[Translation missing --]]
L["customRangeCheck_desc"] = "Changes the default 40 yard out-of-range distance to the specified distance"
--[[Translation missing --]]
L["Data import Failed."] = "Data import Failed."
--[[Translation missing --]]
L["Decoding failed."] = "Decoding failed."
--[[Translation missing --]]
L["Decompression failed."] = "Decompression failed."
--[[Translation missing --]]
L["Default Icon Visibility"] = "Default Icon Visibility"
--[[Translation missing --]]
L["Disease"] = "Disease"
--[[Translation missing --]]
L["diseaseWildcard_desc"] = "any disease debuffs"
--[[Translation missing --]]
L["Example"] = "Example"
--[[Translation missing --]]
L["Experimental"] = "Experimental"
--[[Translation missing --]]
L["Experimental Options"] = "Experimental Options"
--[[Translation missing --]]
L["Experimental_Options_Warning"] = [=[

Warning:

Here you will fill find experimental and potentially dangerous options.

Use at your own risk.

]=]
--[[Translation missing --]]
L["Export"] = "Export"
--[[Translation missing --]]
L["frameScale_desc"] = "The the scale of the raidframe relative to the normal size"
--[[Translation missing --]]
L["General"] = "General"
--[[Translation missing --]]
L["General Options"] = "General Options"
--[[Translation missing --]]
L["generalOptions_desc"] = "Below you will find general configuration options. Please expand the 'Enhanced Raid Frames' menu item in the left-hand column to configure aura indicators, raid icons, and more"
--[[Translation missing --]]
L["Glow At Countdown Time"] = "Glow At Countdown Time"
--[[Translation missing --]]
L["glowRemainingSecs_desc1"] = "The amount of time (in seconds) remaining on the buff or debuff countdown before the glowing starts"
--[[Translation missing --]]
L["glowRemainingSecs_desc2"] = "'0' means it will always glow"
--[[Translation missing --]]
L["Horizontal Offset"] = "Horizontal Offset"
--[[Translation missing --]]
L["horizontalOffset_desc"] = "The horizontal offset percentage relative to the starting position"
--[[Translation missing --]]
L["Icon"] = "Icon"
--[[Translation missing --]]
L["Icon and Visuals"] = "Icon and Visuals"
--[[Translation missing --]]
L["Icon Opacity"] = "Icon Opacity"
--[[Translation missing --]]
L["Icon Options"] = "Icon Options"
--[[Translation missing --]]
L["Icon Position"] = "Icon Position"
--[[Translation missing --]]
L["Icon Size"] = "Icon Size"
--[[Translation missing --]]
L["iconAlpha_desc"] = "The opacity percentage of the raid icon"
--[[Translation missing --]]
L["iconOptions_desc"] = "Configure how the raid marker icon should appear on the raid frames"
--[[Translation missing --]]
L["iconPosition_desc"] = "Position of the raid icon relative to the frame"
--[[Translation missing --]]
L["iconSize_desc"] = "The size of the raid icon in pixels"
--[[Translation missing --]]
L["Import"] = "Import"
--[[Translation missing --]]
L["Import or Export the current profile:"] = "Import or Export the current profile:"
--[[Translation missing --]]
L["ImportExport_Desc"] = [=[

Below you will find a text representation of your Enhanced Raid Frame profile.

To export this profile, select and copy all of the text below and paste it somewhere safe.

To import a profile, replace all of the text below and press accept.

]=]
--[[Translation missing --]]
L["ImportExport_WarningDesc"] = [=[

Copying and pasting profile data can be a time consuming experience. It may stall your game for multiple seconds.

WARNING: This will overwrite the current profile, and any changes you have made will be lost.
]=]
--[[Translation missing --]]
L["ImportWarning"] = "Are you absolutely certain you wish to import this profile? The current profile will be overwritten."
--[[Translation missing --]]
L["Indicator Color"] = "Indicator Color"
--[[Translation missing --]]
L["Indicator Font"] = "Indicator Font"
--[[Translation missing --]]
L["Indicator Glow Effect"] = "Indicator Glow Effect"
--[[Translation missing --]]
L["Indicator Options"] = "Indicator Options"
--[[Translation missing --]]
L["Indicator Size"] = "Indicator Size"
--[[Translation missing --]]
L["indicatorAlpha_desc"] = "The opacity percentage of the indicator icon"
--[[Translation missing --]]
L["indicatorColor_desc1"] = "The solid color used for the indicator when not showing the buff or debuff icon"
--[[Translation missing --]]
L["indicatorColor_desc2"] = "unless augmented by other color options"
--[[Translation missing --]]
L["indicatorFont_desc"] = "The the font used for the indicators"
--[[Translation missing --]]
L["indicatorGlow_desc"] = "Display a glow animation effect on the indicator to make it easier to spot"
--[[Translation missing --]]
L["indicatorOptions_desc"] = "Please select an indicator position from the dropdown menu below"
--[[Translation missing --]]
L["indicatorSize_desc"] = "The size of the indicator in pixels"
--[[Translation missing --]]
L["instructions_desc1"] = "The box to the right contains the list of auras to watch at the selected position"
--[[Translation missing --]]
L["instructions_desc2"] = "Type the names or spell IDs of each aura, each on a separate line"
--[[Translation missing --]]
L["Magic"] = "Magic"
--[[Translation missing --]]
L["magicWildcard_desc"] = "any magic debuffs"
--[[Translation missing --]]
L["meOnly_desc"] = "Only only show this indicator on myself"
--[[Translation missing --]]
L["Middle Center"] = "Middle Center"
--[[Translation missing --]]
L["Middle Left"] = "Middle Left"
--[[Translation missing --]]
L["Middle Right"] = "Middle Right"
--[[Translation missing --]]
L["Mine Only"] = "Mine Only"
--[[Translation missing --]]
L["mineOnly_desc"] = "Only show buffs and debuffs cast by me"
--[[Translation missing --]]
L["missingOnly_desc"] = "Show only when the buff or debuff is missing"
--[[Translation missing --]]
L["No data to import."] = "No data to import."
--[[Translation missing --]]
L["None"] = "None"
--[[Translation missing --]]
L["Open the Blizzard Raid Profiles Menu"] = "Open the Blizzard Raid Profiles Menu"
--[[Translation missing --]]
L["Out-of-Range"] = "Out-of-Range"
--[[Translation missing --]]
L["Out-of-Range Opacity"] = "Out-of-Range Opacity"
--[[Translation missing --]]
L["Override Default Distance"] = "Override Default Distance"
--[[Translation missing --]]
L["Poison"] = "Poison"
--[[Translation missing --]]
L["poisonWildcard_desc"] = "any poison debuffs"
--[[Translation missing --]]
L["Position"] = "Position"
--[[Translation missing --]]
L["Power Bar Vertical Offset"] = "Power Bar Vertical Offset"
--[[Translation missing --]]
L["powerBarOffset_desc"] = "Apply a vertical offset to icons and indicators to keep them from overlapping the power bar (mana/rage/energy)"
--[[Translation missing --]]
L["Profile"] = "Profile"
--[[Translation missing --]]
L["Profiles"] = "Profiles"
--[[Translation missing --]]
L["pvpWildcard_desc"] = "if the unit is PvP flagged"
--[[Translation missing --]]
L["Raidframe Scale"] = "Raidframe Scale"
--[[Translation missing --]]
L["rangeAlpha_desc"] = "The opacity percentage of the raid frame when out-of-range"
--[[Translation missing --]]
L["Select a Custom Distance"] = "Select a Custom Distance"
--[[Translation missing --]]
L["Show Countdown Swipe"] = "Show Countdown Swipe"
--[[Translation missing --]]
L["Show Icon"] = "Show Icon"
--[[Translation missing --]]
L["Show On Me Only"] = "Show On Me Only"
--[[Translation missing --]]
L["Show Only if Missing"] = "Show Only if Missing"
--[[Translation missing --]]
L["Show Raid Icons"] = "Show Raid Icons"
--[[Translation missing --]]
L["Show Text"] = "Show Text"
--[[Translation missing --]]
L["Show Tooltip"] = "Show Tooltip"
--[[Translation missing --]]
L["showBuffs_desc"] = "Show the standard raid frame buff icons"
--[[Translation missing --]]
L["showCountdownSwipe_desc"] = "Show the clockwise swipe animation indicating the time left on the buff or debuff"
--[[Translation missing --]]
L["showDebuffs_desc"] = "Show the standard raid frame debuff icons"
--[[Translation missing --]]
L["showDispellableDebuffs_desc"] = "Show the standard raid frame dispellable icons"
--[[Translation missing --]]
L["showIcon_desc1"] = "Show an icon if the buff or debuff is currently on the unit"
--[[Translation missing --]]
L["showIcon_desc2"] = "if unchecked, a solid indicator color will be used"
--[[Translation missing --]]
L["showRaidIcons_desc"] = "Show the raid marker icon on the raid frames"
--[[Translation missing --]]
L["showText_desc"] = "The text to show on the indicator frame"
--[[Translation missing --]]
L["showTooltip_desc"] = "Show the tooltip on mouseover"
--[[Translation missing --]]
L["Stack Size"] = "Stack Size"
--[[Translation missing --]]
L["Stock Buff Icons"] = "Stock Buff Icons"
--[[Translation missing --]]
L["Stock Debuff Icons"] = "Stock Debuff Icons"
--[[Translation missing --]]
L["Stock Dispellable Icons"] = "Stock Dispellable Icons"
--[[Translation missing --]]
L["Text"] = "Text"
--[[Translation missing --]]
L["Text Color"] = "Text Color"
--[[Translation missing --]]
L["Text Size"] = "Text Size"
--[[Translation missing --]]
L["textColor_desc1"] = "The color used for the indicator text"
--[[Translation missing --]]
L["textColor_desc2"] = "unless augmented by other text color options"
--[[Translation missing --]]
L["textSize_desc"] = "The size of the text (in pixels)"
--[[Translation missing --]]
L["Time #1"] = "Time #1"
--[[Translation missing --]]
L["Time #2"] = "Time #2"
--[[Translation missing --]]
L["Tooltip Location"] = "Tooltip Location"
--[[Translation missing --]]
L["tooltipLocation_desc"] = "The specified location where the tooltip should appear"
--[[Translation missing --]]
L["Tooltips"] = "Tooltips"
--[[Translation missing --]]
L["Top Center"] = "Top Center"
--[[Translation missing --]]
L["Top left"] = "Top left"
--[[Translation missing --]]
L["Top Right"] = "Top Right"
--[[Translation missing --]]
L["totWildcard_desc"] = "if the unit is the target of target"
--[[Translation missing --]]
L["Vertical Offset"] = "Vertical Offset"
--[[Translation missing --]]
L["verticalOffset_desc"] = "The vertical offset percentage relative to the starting position"
--[[Translation missing --]]
L["Visibility and Behavior"] = "Visibility and Behavior"
--[[Translation missing --]]
L["Wildcards"] = "Wildcards"
--[[Translation missing --]]
L["zeroMeansIgnored_desc"] = "'0' means this time is ignored"


