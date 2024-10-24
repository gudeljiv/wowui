﻿local L = LibStub("AceLocale-3.0"):NewLocale("TotemTimers_GUI", "zhTW")
if not L then return end

L["Air"] = "風之"
L["Automatic"] = "自動"
L["Bottom"] = "置底"
L["Cast Button 1"] = "施法按鈕1"
L["Cast Button 2"] = "施法按鈕2"
L["Clickthrough"] = "點擊穿越"
L["Clickthrough Desc"] = "取消任何點擊功能按鈕的計時器"
L["Crowd Control"] = "控場選項"
L["Down"] = "下"
L["Earth"] = "大地"
L["Enable"] = "啟用"
L["Fire"] = "火焰"
L["Left"] = "左"
L["none"] = "無"
L["Right"] = "右"
L["Top"] = "置頂"
L["Totems"] = "圖騰"
L["TotemTimers"] = true
L["Up"] = "上"
L["Version"] = "版本"
L["vertical"] = "豎直方向"
L["Water"] = "水之"

L["Blizz Style"] = "內建格式"
L["Color Timer Bars"] = "計時條上色"
L["Color Timer Bars according to their elements."] = "根據元素計時條上色"
L["Debug"] = "除錯"
L["Displays timer bars underneath times"] = "顯示計時條在時間下方"
L["Fulmination Aura"] = "撼天雷電光環"
L["Fulmination Aura Desc"] = "如果使用魔獸世界內置的PowerAuras並且閃電盾堆疊到9層時，則顯示了一個光環圍繞你的角色。"
L["Fulmination Glow"] = "撼天雷電輝光"
L["Fulmination Glow Desc"] = "如果閃電盾堆疊到9層時，讓大地震擊冷卻計時器與動作列按鈕顯示大地震擊輝光。"
L["General"] = "一般"
L["Hide Blizzard Timers"] = "隱藏內建計時"
L["Hide Default Totem Bar"] = "隱藏預設圖騰條"
L["Hide Default Totem Bar Desc"] = "如果你取消這個你應該重新載入你的界面。"
L["Hide In Vehicles"] = "騎乘時隱藏"
L["Hide In Vehicles Desc"] = "騎乘時隱藏TotemTimers。騎乘時不要改變設定"
L["Lock"] = "鎖定"
L["Locks the position of TotemTimers"] = "鎖定TotemTimers位置"
L["RaidTotems"] = "團隊圖騰"
L["RaidTotems Desc"] = "設定圖騰組法術根據團隊圖騰插件發送的圖騰來分配。"
L["Red Flash Color"] = "紅光閃爍"
L["RedFlash Desc"] = "如果啟用到期時間紅光閃爍，否則淡入或淡出。"
L["Reset All"] = "重置全部"
L["Reset Positions"] = "重置位置"
L["Show Key Bindings"] = "顯示快捷鍵"
L["Shows key bindings on totem timers"] = "在圖騰計時上顯示快捷鍵"
L["Shows tooltips on timer and totem buttons"] = "在計時跟圖騰按鈕上顯示提示"
L["Show Timer Bars"] = "顯示計時條"
L["Show Tooltips"] = "顯示提示"
L["Stop Pulse"] = "停止脈衝"
L["Stop Pulse Desc"] = "\"如果一個計時器停止其圖標會出現一個大而可見脈衝效果\""
L["Time Color"] = "計時顏色"
L["Time Font"] = "計時字型"
L["Timer Bar Color"] = "計時條顏色"
L["Timer Bar Texture"] = "計時條材質"
L["Timers On Buttons"] = "按鈕上的計時"
L["Timers on Buttons is now set in Game Options -> Actionbars -> Show Numbers on Cooldowns"] = "在按鈕上的計時器現在在遊戲選項→動作條→顯示冷卻數字設定"
L["Tooltips At Buttons"] = "在按鈕上顯示提示"
L["Tooltips At Buttons Desc"] = "在圖騰按鈕的右側顯示提示."

L["Advanced Options"] = "進階設定"
L["Always Visible Desc"] = "圖騰選單總是可見像動作條一樣四處拖動。"
L["Arrangement"] = "排列方式"
L["Basic layout of the four timer buttons, loose lets you move them individually"] = "4個計時按鈕的基本樣式，自由排列讓你單獨移動"
L["box"] = "方格排列"
L["Button Size"] = "按鈕大小"
L["Cast Button Position"] = "施法按鈕位置"
L["Cast Button Position Desc"] = "設定圖騰額外自訂的按鈕位置與旁邊的圖騰計時"
L["Cast Button Size"] = "施法按鈕大小"
L["Cast Button Size Desc"] = "設定圖騰額外自訂的按鈕大小與旁邊的圖騰計時關聯大小"
L["Enable Pulse Bar"] = "啟用脈動條"
L["Enables the four totem timer buttons and menus"] = "啟用4個圖騰計時按鈕和選單"
L["horizontal"] = "水平方向"
L["Keybindings desc"] = "如果啟用，如果圖騰選單顯示圖騰按鈕將會有按鍵1-9|n你必須重登設定才會生效。"
L["loose"] = "自由排列"
L["Mini Icons Desc"] = "在標示圖騰分配的計時按鈕右下顯示小圖示來啟動多施法法術和計時按鈕將會施放。"
L["Open On Rightclick"] = "右鍵點擊開啟"
L["Player Range"] = "玩家範圍"
L["Player Range Desc"] = "如果玩家超出範圍在圖騰計時上顯示紅點"
L["Pulse desc"] = "在計時裡面顯示綠色狀態條直到充滿圖騰脈動。"
L["Raid Member Range"] = "團隊成員範圍"
L["Raid Range Tooltip"] = "團隊距離提示"
L["Range Desc"] = "在左下角顯示有多少團隊成員沒有獲得你的圖騰增益"
L["Reverse Key Bindings"] = "反向快捷鍵"
L["Reverse Key Desc"] = "鎖定按鍵9-1而不是1-9|n你必須重登這個設定才會生效。"
L["Rightclick Desc"] = "右鍵開啟圖騰選單而不是經過計時按鈕。 用滑鼠中鍵按鈕可以圖騰解散而不是右鍵點擊。"
L["RR Tooltip Desc"] = "滑鼠經過時顯示團隊成員清單沒有在你圖騰範圍內"
L["Scales the timer buttons"] = "縮放圖騰按鈕"
L["Scaling"] = "縮放"
L["Sets the font size of time strings"] = "設定計時字串的字型大小"
L["Sets the format in which times are displayed"] = "設定計時顯示格式"
L["Sets the space between timer buttons"] = "設定計時按鈕之間的間隔"
L["Sets the space between timer buttons and timer bars"] = "設定計時按鈕跟計時條之間的間隔"
L["Sets the width of timer bars."] = "設定計時條的寬度"
L["Show Mini Icons"] = "顯示小圖示"
L["Show Totem Cooldowns"] = "顯示圖騰冷卻"
L["Spacing"] = "間隔"
L["Timer Bar Position"] = "計時條位置"
L["Timer Bar Position Desc"] = "設定在哪一方的圖示計時器顯示的時間"
L["Timer Bar Width"] = "計時條寬度"
L["Timer Bar Width Desc"] = "設定計時條寬度。"
L["Timer Button 1"] = "計時按鈕1"
L["Timer Button 2"] = "計時按鈕2"
L["Timer Button 3"] = "計時按鈕3"
L["Timer Button 4"] = "計時按鈕4"
L["Timers"] = "計時"
L["Timers On Buttons Desc"] = "計時顯示在按鈕上而不是在他們旁邊。如果啟用，武器追蹤只會顯示時間當雙持時只有主手武器。"
L["Time Size"] = "計時大小"
L["Time Spacing"] = "計計時隔"
L["Time Style"] = "計時格式"
L["Totem Cooldowns desc"] = "所有圖騰顯示冷卻就像額外的計時條不再冷卻。"
L["Totem menu direction"] = "圖騰選單方向"
L["Totem menu direction desc"] = "設定圖騰選單開啟方向。 自動確定方向基於計時的位置。"
L["Totem Menu Key Bindings"] = "圖騰選單快捷鍵"
L["Totem Menus Always Visible"] = "圖騰選單總是可見"
L["Totem Menu Spacing"] = "圖騰選單間隔"
L["Totem Menu Spacing Desc"] = "在圖騰選單設定按鈕間隔。只允許如果選單總是可見。"

L["Ankh Tracker"] = "復生追蹤"
L["Ankh Tracker Desc"] = "顯示你復生能力剩餘冷卻時間以及在你背包的復生數目。也被用來儲存或是載入圖騰設定。"
L["Button 4"] = "按鈕4"
L["EarthShieldDesc"] = "顯示大地之盾剩餘時間和次數。 可用於投大地之盾。"
L["EarthShieldOptionsDesc"] = "如果為了滑鼠按鈕'改寫'像設定一樣被選擇，當離開戰鬥盾被施放在最後一人或是被團隊圖騰插件分配。預設用法:離開戰鬥指向你大地之盾目標之後用右鍵點擊按鈕施放法術。那麼你可以指向任何一人，然而用右鍵點擊大地之盾仍然會施放在相同的人身上，甚至在戰鬥中。"
L["Earth Shield Tracker"] = "大地之盾追蹤"
L["ES Charges only"] = "只有消耗"
L["ES Charges only desc"] = "停用時間顯示,在其位置上顯示大地之盾的層數|n 在你下一次施放大地之盾時生效"
L["ES Main Tank Desc"] = "滑鼠停留時顯示了一個選單，裡面最多包含 4個你隊伍/團隊中的主坦克。"
L["ES Main Tank menu"] = "主坦選單"
L["esrecast"] = "改寫 (最後目標/團隊圖騰)"
L["Leftclick"] = "左鍵點擊"
L["Middle Button"] = "中鍵按鈕"
L["Rightclick"] = "右鍵點擊"
L["Shield Tracker"] = "盾追蹤"
L["Trackers"] = "追蹤"
L["Weapon Buff Tracker"] = "武器增益追蹤"
L["WeaponDesc"] = "顯示武器剩餘增益時間。左鍵點擊施放選擇的武器增益，右鍵點擊開啟選單選擇增益。一個圖示顯示兩個增益，第一個左鍵點擊施放左邊增益和第二個左鍵點擊右邊增益。"

L["Color"] = "顏色"
L["disabled warnings desc"] = "即使追蹤禁用，到期增益警告還是會顯示"
L["EarthShield warnings"] = "大地之盾警告"
L["Maelstrom notification"] = "氣漩通知"
L["Messages"] = "訊息"
L["Shield expiration warnings"] = "盾到期警告"
L["Show warnings of disabled trackers"] = "禁用追蹤顯示警告"
L["Sound"] = "聲音"
L["Totem Desctruction Desc"] = "警告如果圖騰在到期前被銷毀。"
L["Totem Destruction Message"] = "圖騰銷毀訊息"
L["Totem Expiration Desc"] = "圖騰到期之後警告。"
L["Totem Expiration Message"] = "圖騰到期訊息"
L["Totem Expiration Warning"] = "圖騰到期警告"
L["Totem Warning Desc"] = "在圖騰10秒到期前警告。"
L["Warnings"] = "警報"
L["Weapon buff warnings"] = "武器增益警告"

L["Cooldowns"] = "冷卻"
L["Duration"] = "期間"
L["ECD Button Size"] = "增強冷卻按鈕大小"
L["ECD Font Size"] = "增強冷卻字型大小"
L["EnhanceCDs"] = "增強冷卻設定"
L["Flame Shock on top"] = "烈焰震擊在頂部"
L["Flame Shock on top desc"] = "顯示烈焰震擊時間與氣旋武器條在冷卻計時器上方"
L["Hide OOC Desc"] = "改變這個設定下一次戰鬥才會生效"
L["Hide out of combat"] = "離開戰鬥隱藏"
L["Lava Surge Aura"] = "熔岩奔騰光環"
L["Lava Surge Aura Desc"] = "如果使用魔獸世界內置的熔岩奔騰特效PowerAuras，則顯示了一個光環圍繞你的角色。"
L["Lava Surge Glow"] = "熔岩奔騰輝光"
L["Lava Surge Glow Desc"] = "當熔岩奔騰特效發動時，讓熔岩爆發的冷卻時間計時器和動作列按鈕發出熔岩爆發的輝光。"
L["Long Cooldowns"] = "長時冷卻"
L["Maelstrom Bar Height"] = "氣漩條高度"
L["OOC Opacity"] = "離開戰鬥透明度"
L["OOC Opacity Desc"] = "離開戰鬥控制不透明的按鈕，0 = 透明, 1 = 不透明"
L["Show OmniCC counters"] = "顯示OmniCC計數"
L["Spells"] = "法術"

L["Arena"] = "競技場"
L["Battleground"] = "戰場"
L["Copy All"] = "複製所有"
L["Copy CC Settings"] = "複製控場設定"
L["Copy EnhanceCDs Settings"] = "複製增強冷卻設定"
L["Copy Frame Positions"] = "複製框架位置"
L["Copy From"] = "複製從"
L["Copy General Settings"] = "複製一般設定"
L["Copy Settings"] = "複製設定"
L["Copy To"] = "複製到"
L["Copy Totem Settings"] = "複製圖騰設定"
L["Copy Totem Timer Settings"] = "複製圖騰計時器設定"
L["Copy Tracker Settings"] = "複製追蹤設定"
L["Copy Warnings"] = "複製警告"
L["Create Profile"] = "創建設定檔"
L["default"] = "預設"
L["Delete Profile"] = "刪除設定檔"
L["Manage Profiles"] = "管理設定檔"
L["New Name"] = "新名稱"
L["Party"] = "隊伍"
L["Profile"] = "設定檔"
L["Profile already exists."] = "設定檔已經存在"
L["Profiles"] = "設定檔"
L["Raid"] = "團隊"
L["Really delete profile?"] = "確定刪除設定檔？"
L["Really reset frame positions?"] = "確定重置框架位置？"
L["Reset Frame Positions"] = "重置框架位置"
L["Reset Profile"] = "重置設定檔"
L["Select Profiles"] = "選擇設定檔"
L["Solo"] = "單獨"
L["You cannot delete the default profile."] = "你無法刪除預設的設定檔."
L["You need to enter a profile name first."] = "你需要先輸入一個設定檔名稱."
