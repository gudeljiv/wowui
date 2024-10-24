local L = LibStub("AceLocale-3.0"):NewLocale("TotemTimers_GUI", "koKR")
if not L then return end

L["Air"] = "바람"
L["Automatic"] = "자동"
L["Bottom"] = "하단"
L["Cast Button 1"] = "시전 버튼 1"
L["Cast Button 2"] = "시전 버튼 2"
L["Clickthrough"] = "클릭 사용 안함" -- Needs review
L["Clickthrough Desc"] = "타이머 버튼 클릭 기능을 사용하지 않습니다." -- Needs review
L["Crowd Control"] = "군중 제어" -- Needs review
L["Down"] = "아래"
L["Earth"] = "대지"
L["Enable"] = "사용"
L["Fire"] = "불"
L["Left"] = "좌측"
L["none"] = "없음"
L["Right"] = "우측"
L["Top"] = "상단"
L["Totems"] = "토템"
L["TotemTimers"] = true
L["Up"] = "위"
L["Version"] = "버전"
L["vertical"] = "수직"
L["Water"] = "물"

L["Blizz Style"] = "기본 스타일"
L["Color Timer Bars"] = "타이머 바 색상"
L["Color Timer Bars according to their elements."] = "요소에 따른 타이머 바의 색상을 변경합니다."
L["Debug"] = "디버그"
L["Displays timer bars underneath times"] = "시간 아래에 타이머 바를 표시합니다."
L["Fulmination Aura"] = "성난 부르짖음 효과"
L["Fulmination Aura Desc"] = "번개 보호막 9중첩 효과 발동시 PowerAuras처럼 캐릭터 주변에 효과를 표시합니다." -- Needs review
L["Fulmination Glow"] = "성난 부르짖음 깜박임"
L["Fulmination Glow Desc"] = "번개 보호막 9중첩 효과 발동시 타이머와 행동 단축바의 대지 충격 아이콘에 깜박임 효과를 표시합니다." -- Needs review
L["General"] = "일반"
L["Hide Blizzard Timers"] = "블리자드 타이머 숨김"
L["Hide Default Totem Bar"] = "기본 토템 바 숨김"
L["Hide Default Totem Bar Desc"] = "선택을 취소할 경우 효과 적용을 위해 당신의 UI를 재시작하시기 바랍니다."
L["Hide In Vehicles"] = "탑승시 숨김"
L["Hide In Vehicles Desc"] = "차량 탑승시 토템 타이머를 숨깁니다. 탑승중 이 설정은 변경되지 않습니다."
L["Lock"] = "잠금"
L["Locks the position of TotemTimers"] = "토템 타이머의 위치를 잠금니다."
L["RaidTotems"] = true
L["RaidTotems Desc"] = "RaidTotems 애드온에 의해 선정된 다중 주문을 시전합니다."
L["Red Flash Color"] = "붉은색 반짝임 색상"
L["RedFlash Desc"] = "사용시 만료중에 있는 토템은 적색으로 반짝입니다. 그외에는 밝았다 어두워집니다."
L["Reset All"] = "전체 초기화"
L["Reset Positions"] = "위치 초기화"
L["Show Key Bindings"] = "단축키 표시"
L["Shows key bindings on totem timers"] = "토템 타이머 위에 단축키를 표시합니다."
L["Shows tooltips on timer and totem buttons"] = "타이머나 토템 버튼 위에 마우스 오버시 툴팁을 표시합니다."
L["Show Timer Bars"] = "타이버 바 표시"
L["Show Tooltips"] = "툴팁 표시"
L["Stop Pulse"] = "맥박 중지"
L["Stop Pulse Desc"] = "\"타이머가 중지되면 해당 아이콘을 크게 표시하는 맥박을 사용하지 않습니다.\""
L["Time Color"] = "시간 색상"
L["Time Font"] = "시간 글꼴"
L["Timer Bar Color"] = "타이머 바 색상"
L["Timer Bar Texture"] = "타이머 바 무늬"
L["Timers On Buttons"] = "버튼에 타이머"
L["Timers on Buttons is now set in Game Options -> Actionbars -> Show Numbers on Cooldowns"] = "Timers on Buttons is now set in Game Options -> Actionbars -> Show Numbers on Cooldowns" -- Requires localization
L["Tooltips At Buttons"] = "버튼의 툴팁"
L["Tooltips At Buttons Desc"] = "TT 버튼 위에 툴팁을 표시합니다."

L["Advanced Options"] = "고급 옵션"
L["Always Visible Desc"] = "토템 메뉴를 항상 표시하고 행동 단축바처럼 드래그 할 수 있습니다."
L["Arrangement"] = "배열"
L["Basic layout of the four timer buttons, loose lets you move them individually"] = "개별 타이머 버튼 4개의 기본 배치를 당신은 개인적으로 이동시킬 수 있습니다."
L["box"] = "박스"
L["Button Size"] = "버튼 크기"
L["Cast Button Position"] = "시전 버튼 위치"
L["Cast Button Position Desc"] = "토템 타이머에 추가 사용자 토템 버튼의 위치를 설정합니다."
L["Cast Button Size"] = "시전 버튼 크기"
L["Cast Button Size Desc"] = "토템 타이머에 추가 사용자 토템 버튼의 크기를 설정합니다."
L["Enable Pulse Bar"] = "진행 과정바 사용"
L["Enables the four totem timer buttons and menus"] = "4개의 토템 타이머 버튼과 메뉴를 사용합니다."
L["horizontal"] = "수평"
L["Keybindings desc"] = "사용시, 토템 메뉴를 표시할 때 토템 버튼에 1-9의 단축키를 표시합니다.|n이 설정의 효과 적용을 위해 당신은 UI를 재시작 합니다."
L["loose"] = "개별"
L["Mini Icons Desc"] = "타이머 버튼의 우측 하단에 재시전 할 수 있는 토템 버튼을 지시하는 작은 아이콘을 표시합니다."
L["Open On Rightclick"] = "오른쪽 클릭시 열기"
L["Player Range"] = "플레이어 거리"
L["Player Range Desc"] = "플레이어가 범위를 벗어나면 토템 타이머 위에 붉은 점으로 표시합니다."
L["Pulse desc"] = "타이머 내부에 토템의 지속 시간이 채워질 때까지의 과정을 녹색의 상태 바로 표시합니다."
L["Raid Member Range"] = "공격대원 거리"
L["Raid Range Tooltip"] = "공격대 거리 툴팁"
L["Range Desc"] = "왼쪽 모서리에 당신의 토템 버프를 받지 못하는 공격대원을 수를 표시합니다."
L["Reverse Key Bindings"] = "단축키 반대로"
L["Reverse Key Desc"] = "단축키 순서를 1-9에서 9-1로 변경합니다.|n이 설정의 효과 적용을 위해 당신은 UI를 재시작 합니다."
L["Rightclick Desc"] = "타이머 버튼에 오른쪽 클릭시 토템 메뉴를 엽니다. 가운데 버튼 클릭시 해당 토템을 회수합니다."
L["RR Tooltip Desc"] = "토템 타이머에 마우스 오버시 당신의 토템에서 거리를 벗어난 공격대원들의 목록을 표시합니다."
L["Scales the timer buttons"] = "타이머 버튼 크기를 설정합니다."
L["Scaling"] = "비율"
L["Sets the font size of time strings"] = "시간 글꼴의 크기를 설정합니다."
L["Sets the format in which times are displayed"] = "어떤 형식으로 시간을 표시할지 설정합니다."
L["Sets the space between timer buttons"] = "타이머 버튼의 간격을 설정합니다."
L["Sets the space between timer buttons and timer bars"] = "타이머 버튼과 타이머 바의 간격을 설정합니다."
L["Sets the width of timer bars."] = "타이머 바의 너비를 설정합니다."
L["Show Mini Icons"] = "작은 아이콘 표시"
L["Show Totem Cooldowns"] = "토템 재사용 대기시간 표시"
L["Spacing"] = "간격"
L["Timer Bar Position"] = "타이머 바 위치"
L["Timer Bar Position Desc"] = "시간 타이머 아이콘을 어느 위치에 표시할지 설정합니다."
L["Timer Bar Width"] = "타이머 바 너비"
L["Timer Bar Width Desc"] = "타이머 바의 너비를 설정합니다."
L["Timer Button 1"] = "타이머 버튼 1"
L["Timer Button 2"] = "타이머 버튼 2"
L["Timer Button 3"] = "타이머 버튼 3"
L["Timer Button 4"] = "타이머 버튼 4"
L["Timers"] = "타이머"
L["Timers On Buttons Desc"] = "버튼 위에 타이머를 표시합니다. 쌍수 무기일때 추적기에는 주 무기의 시간을 표시합니다."
L["Time Size"] = "타이머 크기"
L["Time Spacing"] = "타이머 간격"
L["Time Style"] = "타이머 스타일"
L["Totem Cooldowns desc"] = "재사용 대기시간을 가지고 있는 모든 토템의 대기시간을 타이머 가운데에 표시합니다."
L["Totem menu direction"] = "토템 메뉴 방향"
L["Totem menu direction desc"] = "토템 메뉴가 열릴때 방향입니다. 자동은 타이머 위치를 기준으로 방향을 결정합니다."
L["Totem Menu Key Bindings"] = "토템 메뉴 단축키"
L["Totem Menus Always Visible"] = "토템 메뉴 항상 표시"
L["Totem Menu Spacing"] = "토템 메뉴 간격"
L["Totem Menu Spacing Desc"] = "토템 메뉴 버튼 간격을 설정합니다. 메뉴 항상 표시때 적용됩니다."

L["Ankh Tracker"] = "윤회 추적"
L["Ankh Tracker Desc"] = "가방에 있는 십자가의 수량과 윤회 능력의 남은 재사용 대기시간을 표시합니다."
L["Button 4"] = "버튼 4"
L["EarthShieldDesc"] = "대지 보호막의 남은 시간과 갯수를 표시합니다. 클릭시 대지 보호막을 시전합니다."
L["EarthShieldOptionsDesc"] = "만약 '재시전'을 선택한다면, 마지막으로 보호막을 받은 플레이어에게 시전을 하거나 RaidTotems 애드온에 의해 선택된 플레이어에게 시전합니다."
L["Earth Shield Tracker"] = "대지 보호막 추적"
L["ES Charges only"] = "Charges only" -- Requires localization
L["ES Charges only desc"] = "Disables the time display and shows ES charges in its place|nChanges take effect the next time you cast ES" -- Requires localization
L["ES Main Tank Desc"] = "마우스 오버시 당신의 공격대/파티원의 방어전담 4명까지 메뉴에 표시합니다." -- Needs review
L["ES Main Tank menu"] = "ES 메인 탱커 메뉴"
L["esrecast"] = "재시전 (마지막 대상)"
L["Leftclick"] = "왼쪽 클릭"
L["Middle Button"] = "가운데 클릭"
L["Rightclick"] = "오른쪽 클릭"
L["Shield Tracker"] = "보호막 추척"
L["Trackers"] = "추적기"
L["Weapon Buff Tracker"] = "무기 버프 추적"
L["WeaponDesc"] = "오른쪽 클릭을 통해 시전할 버프를 선택하고, 첫번째 왼쪽 클릭시 주무기에 버프 시전을 하고 두번째 왼쪽 클릭시 보조무기에 버프를 시전합니다."

L["Color"] = "색상"
L["disabled warnings desc"] = "추적기를 사용하지 않아도, 버프 만료 및 사라짐 경고를 표시합니다."
L["EarthShield warnings"] = "대지의 보호막 경고"
L["Maelstrom notification"] = "소용돌이치는 무기 경고"
L["Messages"] = "메시지"
L["Shield expiration warnings"] = "보호막 만료 경고"
L["Show warnings of disabled trackers"] = "사용하지 않는 추적기 경고 표시"
L["Sound"] = "효과음"
L["Totem Desctruction Desc"] = "토템 만료전 파괴시 경고합니다."
L["Totem Destruction Message"] = "토템 파괴 메시지"
L["Totem Expiration Desc"] = "토템 만료시 경고합니다."
L["Totem Expiration Message"] = "토템 만료 메시지"
L["Totem Expiration Warning"] = "토템 만료 경고"
L["Totem Warning Desc"] = "토템 만료 10초전 경고합니다."
L["Warnings"] = "경고"
L["Weapon buff warnings"] = "무기 버프 경고"

L["Cooldowns"] = "재사용 대기시간" -- Needs review
L["Duration"] = "지속시간"
L["ECD Button Size"] = "ECD 버튼 크기"
L["ECD Font Size"] = "ECD 글꼴 크기"
L["EnhanceCDs"] = true
L["Flame Shock on top"] = "상단에 화염 충격"
L["Flame Shock on top desc"] = "화염 충격 지속시간과 소용돌이치는 무기 바에 유지시간을 표시합니다." -- Needs review
L["Hide OOC Desc"] = "이 설정의 효과는 다음 전투 후 변경됩니다."
L["Hide out of combat"] = "비 전투 상태시 숨김"
L["Lava Surge Aura"] = "용암 쇄도 효과"
L["Lava Surge Aura Desc"] = "용암 쇄도 효과 발동시 PowerAuras처럼 캐릭터 주변에 효과를 표시합니다." -- Needs review
L["Lava Surge Glow"] = "용암 쇄도 깜박임"
L["Lava Surge Glow Desc"] = "용암 쇄도 효과 발동시 타이머와 행동 단축바의 용암 쇄도 아이콘에 깜박임 효과를 표시합니다." -- Needs review
L["Long Cooldowns"] = "긴 재사용 대기시간" -- Needs review
L["Maelstrom Bar Height"] = "소용돌이치는 무기 바 높이"
L["OOC Opacity"] = "OOC 투명도"
L["OOC Opacity Desc"] = "전투 상태시 버튼의 불투명도를 조절합니다, 0 = 투명, 1 = 불투명"
L["Show OmniCC counters"] = "OmniCC 카운터 표시"
L["Spells"] = "주문" -- Needs review

L["Arena"] = "투기장" -- Needs review
L["Battleground"] = "전장" -- Needs review
L["Copy All"] = "전체 복사" -- Needs review
L["Copy CC Settings"] = "CC 설정 복사" -- Needs review
L["Copy EnhanceCDs Settings"] = "EnhanceCDs 설정 복사" -- Needs review
L["Copy Frame Positions"] = "창 위치 복사" -- Needs review
L["Copy From"] = "Copy From" -- Requires localization
L["Copy General Settings"] = "일반 설정 복사" -- Needs review
L["Copy Settings"] = "복사 설정" -- Needs review
L["Copy To"] = "Copy To" -- Requires localization
L["Copy Totem Settings"] = "토템 설정 복사" -- Needs review
L["Copy Totem Timer Settings"] = "토템 타이머 설정 복사" -- Needs review
L["Copy Tracker Settings"] = "추적 설정 복사" -- Needs review
L["Copy Warnings"] = "복사 경고" -- Needs review
L["Create Profile"] = "새로운 프로필" -- Needs review
L["default"] = "기본값" -- Needs review
L["Delete Profile"] = "프로필 삭제" -- Needs review
L["Manage Profiles"] = "프로필 관리" -- Needs review
L["New Name"] = "새로운 이름" -- Needs review
L["Party"] = "파티" -- Needs review
L["Profile"] = "프로필" -- Needs review
L["Profile already exists."] = "프로필이 이미 존재합니다." -- Needs review
L["Profiles"] = "프로필" -- Needs review
L["Raid"] = "공격대" -- Needs review
L["Really delete profile?"] = "정말 프로필을 삭제하시겠습니까?" -- Needs review
L["Really reset frame positions?"] = "정말 창 위치를 재설정 하시겠습니까?" -- Needs review
L["Reset Frame Positions"] = "창 위치 초기화" -- Needs review
L["Reset Profile"] = "프로필 초기화" -- Needs review
L["Select Profiles"] = "프로필 선택" -- Needs review
L["Solo"] = "솔로잉" -- Needs review
L["You cannot delete the default profile."] = "당신은 기본 프로필을 삭제할 수 없습니다." -- Needs review
L["You need to enter a profile name first."] = "프로필 이름을 입력하여야합니다." -- Needs review
