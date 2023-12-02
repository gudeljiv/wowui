-- Enhanced Raid Frames is a World of Warcraft® user interface addon.
-- Copyright (c) 2017-2021 Britt W. Yazel
-- This code is licensed under the MIT license (see LICENSE for details)

local L = LibStub("AceLocale-3.0"):NewLocale("EnhancedRaidFrames", "koKR", false)

if not L then return end

--[[Translation missing --]]
L["Aborting."] = "Aborting."
L["Animations"] = "애니메이션"
L["Attached to Cursor"] = "커서에 부착"
L["Aura Watch List"] = "효과 주시 목록"
L["auras_desc"] = "이 위치에서 주시할 강화 효과, 약화 효과 및/또는 와일드카드 목록입니다."
L["auras_usage"] = "게임에서 찾은 유효한 효과 이름 또는 주문 ID가 철자가 정확해야 작동합니다."
L["Background Opacity"] = "배경 불투명도"
L["backgroundAlpha_desc"] = "공격대창 배경의 불투명도 비율입니다."
L["Blizzard Default"] = "블리자드 기본"
--[[Translation missing --]]
L["blizzardRaidOptionsButton_desc"] = "Launch the built-in raid profiles interface configuration menu"
L["Bottom Center"] = "중앙 하단"
L["Bottom Left"] = "좌측 하단"
L["Bottom Right"] = "우측 하단"
L["Color"] = "색상"
L["Color By Debuff Type"] = "약화 효과 유형별 색상"
L["Color By Remaining Time"] = "남은 시간별 색상"
L["colorByDebuff_desc"] = "색상은 약화 효과 유형에 따라 결정됩니다."
L["colorByTime_desc"] = "남은 시간에 따라 색상이 결정됩니다."
--[[Translation missing --]]
L["colorByTime_high_desc"] = "The time (in seconds) for the upper boundary"
--[[Translation missing --]]
L["colorByTime_low_desc"] = "The time (in seconds) for the lower boundary"
L["colorOverride_desc"] = "이는 보통 색상 지정을 재정의함"
--[[Translation missing --]]
L["combatWildcard_desc"] = "if the unit is combat flagged"
L["Countdown"] = "초읽기"
L["Curse"] = "저주"
L["curseWildcard_desc"] = "모든 저주 약화 효과"
L["customRange_desc"] = "기본 범위 밖 표시기 거리를 재정의합니다(기본 40미터)."
L["customRangeCheck_desc"] = "기본 40미터 범위 밖 거리를 지정된 거리로 변경합니다."
--[[Translation missing --]]
L["Data import Failed."] = "Data import Failed."
--[[Translation missing --]]
L["Decoding failed."] = "Decoding failed."
--[[Translation missing --]]
L["Decompression failed."] = "Decompression failed."
L["Default Icon Visibility"] = "기본 아이콘 표시"
L["Disease"] = "질병"
L["diseaseWildcard_desc"] = "모든 질병 약화 효과"
L["Example"] = "예"
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
L["frameScale_desc"] = "보통 크기에 대한 공격대창의 크기 비율입니다."
L["General"] = "일반"
L["General Options"] = "일반 옵션"
L["generalOptions_desc"] = "아래에서 일반 구성 옵션을 찾을 수 있습니다. 효과 표시기, 공격대 아이콘 등을 구성하려면 왼쪽 열의 'Enhanced Raid Frames' 메뉴 항목을 확장하세요."
--[[Translation missing --]]
L["Glow At Countdown Time"] = "Glow At Countdown Time"
L["glowRemainingSecs_desc1"] = "반짝임을 시작하기 전 강화 효과 또는 약화 효과 초읽기에 남은 시간 (초) 입니다."
L["glowRemainingSecs_desc2"] = "'0'은 항상 반짝임을 뜻함"
--[[Translation missing --]]
L["Horizontal Offset"] = "Horizontal Offset"
--[[Translation missing --]]
L["horizontalOffset_desc"] = "The horizontal offset percentage relative to the starting position"
L["Icon"] = "아이콘"
--[[Translation missing --]]
L["Icon and Visuals"] = "Icon and Visuals"
L["Icon Opacity"] = "아이콘 불투명도"
L["Icon Options"] = "아이콘 옵션"
L["Icon Position"] = "아이콘 위치"
L["Icon Size"] = "아이콘 크기"
L["iconAlpha_desc"] = "공격대 아이콘의 불투명도 비율입니다."
L["iconOptions_desc"] = "공격대 표시기 아이콘이 공격대창에 표시되는 방식을 구성합니다"
L["iconPosition_desc"] = "창을 기준으로 한 공격대 아이콘의 위치입니다."
L["iconSize_desc"] = "공격대 아이콘 크기 (픽셀)"
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
L["Indicator Color"] = "표시기 색상"
L["Indicator Font"] = "표시기 글꼴"
L["Indicator Glow Effect"] = "표시기 반짝임 효과"
L["Indicator Options"] = "표시기 옵션"
L["Indicator Size"] = "표시기 크기"
L["indicatorAlpha_desc"] = "표시기 아이콘의 불투명도 비율입니다."
L["indicatorColor_desc1"] = "강화 효과 또는 약화 효과 아이콘이 표시되지 않을 때 표시기에 사용되는 단색입니다."
L["indicatorColor_desc2"] = "다른 색상 옵션으로 보강하지 않는 한"
L["indicatorFont_desc"] = "표시기에 사용되는 글꼴입니다."
L["indicatorGlow_desc"] = "쉽게 찾을 수 있도록 표시기에 반짝임 애니메이션 효과를 표시합니다."
L["indicatorOptions_desc"] = "아래 드롭다운 메뉴에서 표시기 위치를 고르세요"
L["indicatorSize_desc"] = "표시기 크기 (픽셀)"
--[[Translation missing --]]
L["instructions_desc1"] = "The box to the right contains the list of auras to watch at the selected position"
L["instructions_desc2"] = "각 효과의 이름 또는 주문 ID를 각각 별도의 줄에 입력하세요."
L["Magic"] = "마법"
L["magicWildcard_desc"] = "모든 마법 약화 효과"
L["meOnly_desc"] = "이 표시기는 자신에게만 표시"
L["Middle Center"] = "정중앙"
L["Middle Left"] = "좌측 중단"
L["Middle Right"] = "우측 중단"
L["Mine Only"] = "내 것만"
L["mineOnly_desc"] = "내가 시전한 강화 효과 및 약화 효과만 표시"
L["missingOnly_desc"] = "강화 효과 또는 약화 효과가 없을 때만 표시"
--[[Translation missing --]]
L["No data to import."] = "No data to import."
L["None"] = "없음"
L["Open the Blizzard Raid Profiles Menu"] = "블리자드 공격대 프로필 메뉴 열기"
L["Out-of-Range"] = "사거리 밖"
L["Out-of-Range Opacity"] = "사거리 밖 불투명도"
L["Override Default Distance"] = "기본 거리 재정의"
L["Poison"] = "독"
L["poisonWildcard_desc"] = "모든 독 약화 효과"
L["Position"] = "위치"
--[[Translation missing --]]
L["Power Bar Vertical Offset"] = "Power Bar Vertical Offset"
--[[Translation missing --]]
L["powerBarOffset_desc"] = "Apply a vertical offset to icons and indicators to keep them from overlapping the power bar (mana/rage/energy)"
--[[Translation missing --]]
L["Profile"] = "Profile"
L["Profiles"] = "프로필"
--[[Translation missing --]]
L["pvpWildcard_desc"] = "if the unit is PvP flagged"
L["Raidframe Scale"] = "공격대창 크기 비율"
L["rangeAlpha_desc"] = "사거리 밖일 때 공격대창의 불투명도 비율입니다."
L["Select a Custom Distance"] = "사용자 지정 거리 선택"
L["Show Countdown Swipe"] = "초읽기 바늘 표시"
L["Show Icon"] = "아이콘 표시"
L["Show On Me Only"] = "나에게만 표시"
L["Show Only if Missing"] = "빠진 경우에만 표시"
L["Show Raid Icons"] = "공격대 아이콘 표시"
L["Show Text"] = "문자 표시"
L["Show Tooltip"] = "툴팁 표시"
L["showBuffs_desc"] = "표준 공격대창 강화 효과 아이콘을 표시합니다."
L["showCountdownSwipe_desc"] = "강화 효과 또는 약화 효과에 남은 시간을 나타내는 시계 방향 바늘 애니메이션을 표시합니다."
L["showDebuffs_desc"] = "표준 공격대창 약화 효과 아이콘을 표시합니다."
L["showDispellableDebuffs_desc"] = "표준 공격대창 해제 가능 아이콘을 표시합니다."
L["showIcon_desc1"] = "강화 효과 또는 약화 효과가 현재 유닛에 있는 경우 아이콘을 표시합니다."
L["showIcon_desc2"] = "끄면 단색 표시기 색상이 사용됨"
L["showRaidIcons_desc"] = "공격대창에 공격대 표시기 아이콘을 표시합니다."
L["showText_desc"] = "표시기 창에 표시할 문자입니다."
L["showTooltip_desc"] = "마우스 오버 시 툴팁을 표시합니다."
--[[Translation missing --]]
L["Stack Size"] = "Stack Size"
--[[Translation missing --]]
L["Stock Buff Icons"] = "Stock Buff Icons"
--[[Translation missing --]]
L["Stock Debuff Icons"] = "Stock Debuff Icons"
--[[Translation missing --]]
L["Stock Dispellable Icons"] = "Stock Dispellable Icons"
L["Text"] = "문자"
L["Text Color"] = "문자 색상"
L["Text Size"] = "문자 크기"
L["textColor_desc1"] = "표시기 문자에 사용되는 색상입니다."
L["textColor_desc2"] = "다른 문자 색상 옵션으로 보태지 않는 한"
L["textSize_desc"] = "문자 크기 (픽셀)"
L["Time #1"] = "시간 #1"
L["Time #2"] = "시간 #2"
L["Tooltip Location"] = "툴팁 위치"
L["tooltipLocation_desc"] = "툴팁이 표시되어야 하는 지정된 위치"
L["Tooltips"] = "툴팁"
L["Top Center"] = "중앙 상단"
L["Top left"] = "좌측 상단"
L["Top Right"] = "우측 상단"
L["totWildcard_desc"] = "유닛이 대상의 대상인 경우"
--[[Translation missing --]]
L["Vertical Offset"] = "Vertical Offset"
--[[Translation missing --]]
L["verticalOffset_desc"] = "The vertical offset percentage relative to the starting position"
--[[Translation missing --]]
L["Visibility and Behavior"] = "Visibility and Behavior"
L["Wildcards"] = "와일드카드"
L["zeroMeansIgnored_desc"] = "'0'은 이 시간이 무시됨을 뜻합니다."


