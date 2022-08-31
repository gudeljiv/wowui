-- Enhanced Raid Frames is a World of Warcraft® user interface addon.
-- Copyright (c) 2017-2021 Britt W. Yazel
-- This code is licensed under the MIT license (see LICENSE for details)

local L = LibStub("AceLocale-3.0"):NewLocale("EnhancedRaidFrames", "zhCN", false)

if not L then return end

--[[Translation missing --]]
L["Aborting."] = "Aborting."
L["Animations"] = "动画效果"
L["Attached to Cursor"] = "附着在光标上"
L["Aura Watch List"] = "光环监视列表"
L["auras_desc"] = "在这里显示监视的增益、减益法术和“wildcards”列表"
L["auras_usage"] = "任何有效的光环名称或法术ID在正确拼写的情况下都应该可以正常工作"
L["Background Opacity"] = "背景不透明度"
L["backgroundAlpha_desc"] = "团队框架背景的不透明度百分比"
L["Blizzard Default"] = "暴雪原生默认"
L["blizzardRaidOptionsButton_desc"] = "打开系统自带的团队框架界面设置菜单"
L["Bottom Center"] = "下部中间"
L["Bottom Left"] = "下部左侧"
L["Bottom Right"] = "下部右侧"
L["Color"] = "颜色"
L["Color By Debuff Type"] = "默认颜色"
L["Color By Remaining Time"] = "根据剩余时间显示颜色"
L["colorByDebuff_desc"] = "根据减益法术的类型来决定颜色"
L["colorByTime_desc"] = "根据剩余时间来决定颜色"
--[[Translation missing --]]
L["colorByTime_high_desc"] = "The time (in seconds) for the upper boundary"
--[[Translation missing --]]
L["colorByTime_low_desc"] = "The time (in seconds) for the lower boundary"
L["colorOverride_desc"] = "这将代替默认的颜色"
--[[Translation missing --]]
L["combatWildcard_desc"] = "if the unit is combat flagged"
L["Countdown"] = "倒数计时"
L["Curse"] = "诅咒"
L["curseWildcard_desc"] = "任何诅咒类型的减益"
L["customRange_desc"] = "代替默认的超出距离指示器（默认为40码）"
L["customRangeCheck_desc"] = "将默认的40码超出距离指示器修改为指定的距离"
--[[Translation missing --]]
L["Data import Failed."] = "Data import Failed."
--[[Translation missing --]]
L["Decoding failed."] = "Decoding failed."
--[[Translation missing --]]
L["Decompression failed."] = "Decompression failed."
L["Default Icon Visibility"] = "系统默认图标的可见性"
L["Disease"] = "疾病"
L["diseaseWildcard_desc"] = "任何疾病类型的减益"
L["Example"] = "举例"
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
L["frameScale_desc"] = "团队框架相对于正常尺寸的比例"
L["General"] = "通常"
L["General Options"] = "通常设置"
L["generalOptions_desc"] = "配置团队标记图标在团队框架上如何显示"
L["Glow At Countdown Time"] = "倒计时发光"
L["glowRemainingSecs_desc1"] = "在增益或减益法术倒计时发光开始之前的时间长度（单位为秒）"
L["glowRemainingSecs_desc2"] = "“0”代表将一直发光"
L["Horizontal Offset"] = "水平位置补偿"
L["horizontalOffset_desc"] = "水平位置相对于起始位置的补偿百分比"
L["Icon"] = "图标"
L["Icon and Visuals"] = "图标和视觉效果"
L["Icon Opacity"] = "图标不透明度"
L["Icon Options"] = "图标设置"
L["Icon Position"] = "图标位置"
L["Icon Size"] = "图标大小"
L["iconAlpha_desc"] = "图标不透明度的百分比"
--[[Translation missing --]]
L["iconOptions_desc"] = "Configure how the raid marker icon should appear on the raid frames"
L["iconPosition_desc"] = "图标相对于团队框架的位置"
L["iconSize_desc"] = "图标的像素大小"
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
L["Indicator Color"] = "指示器颜色"
L["Indicator Font"] = "指示器字体"
L["Indicator Glow Effect"] = "指示器发光效果"
L["Indicator Options"] = "指示器设置"
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


