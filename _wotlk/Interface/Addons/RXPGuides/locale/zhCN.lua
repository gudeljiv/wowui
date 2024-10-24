local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN", false)
if not L then return end

_G["BINDING_NAME_" .. "CLICK RXPItemFrameButton1:LeftButton"] =
    "激活物品1"
_G["BINDING_NAME_" .. "CLICK RXPItemFrameButton2:LeftButton"] =
    "激活物品2"
_G["BINDING_NAME_" .. "CLICK RXPItemFrameButton3:LeftButton"] =
    "激活物品3"
_G["BINDING_NAME_" .. "CLICK RXPItemFrameButton4:LeftButton"] =
    "激活物品4"

_G["BINDING_NAME_" .. "CLICK RXPTargetFrame_FriendlyButton1:LeftButton"] =
    "激活友方目标1"
_G["BINDING_NAME_" .. "CLICK RXPTargetFrame_FriendlyButton2:LeftButton"] =
    "激活友方目标2"
_G["BINDING_NAME_" .. "CLICK RXPTargetFrame_FriendlyButton3:LeftButton"] =
    "激活友方目标3"
_G["BINDING_NAME_" .. "CLICK RXPTargetFrame_FriendlyButton4:LeftButton"] =
    "激活友方目标4"

_G["BINDING_NAME_" .. "CLICK RXPTargetFrame_EnemyButton1:LeftButton"] =
    "激活敌方目标1"
_G["BINDING_NAME_" .. "CLICK RXPTargetFrame_EnemyButton2:LeftButton"] =
    "激活敌方目标2"
_G["BINDING_NAME_" .. "CLICK RXPTargetFrame_EnemyButton3:LeftButton"] =
    "激活敌方目标3"
_G["BINDING_NAME_" .. "CLICK RXPTargetFrame_EnemyButton4:LeftButton"] =
    "激活敌方目标4"

-- 词语
L.words = {["Accept"] = _G.ACCEPT, ["Kill"] = "击杀"}

-- Communications.lua文件
L["Collected step %d - %s"] = "已收集步骤 %d - %s"
L["Completed step %d - %s"] = "已完成步骤 %d - %s"
L["Describe your issue:"] = "描述你的问题:"
L["Do not edit below this line"] = "请勿编辑此行以下内容"
L["Flying to %s ETA %s"] = "正在飞往 %s 预计到达时间 %s"
L["Give Feedback for step"] = "为步骤提供反馈"
L["I just leveled from %d to %d in %s"] = "我刚刚在 %s 从 %d 级升到了 %d 级"
L["I just leveled up to %d"] = "我刚刚升到了 %d 级"
L["Join our support discord at discord.gg/RestedXP and copy paste this form into #bug-report"] = "加入我们的支持 Discord discord.gg/RestedXP 并将此表单复制粘贴到 #bug-report 频道"
L["RestedXP Feedback Form"] = "RestedXP 反馈表单"
L["There's a new addon version (%s) available"] = "有新的插件版本 (%s) 可用"
L["There's a new version (%s) available for %s"] = "%s 有新版本 (%s) 可用"
L["day"] = "天"
L["days"] = "天"
L["hour"] = "小时"
L["hours"] = "小时"
L["minute"] = "分钟" 
L["minutes"] = "分钟"
L["second"] = "秒"
L["seconds"] = "秒"

-- functions.lua文件
L["(Skip this step if you are level %d or above)"] = "(如果你的等级是 %d 级或以上,请跳过此步骤)"
L["Attempting to deposit"] = "正在尝试存入"
L["Attempting to withdraw"] = "正在尝试取出"
L["Click to view the link"] = "点击查看链接"
L["Collect the following items:"] = "收集以下物品:"
L["Die and respawn at the graveyard"] = "死亡并在墓地复活"
L["Do the Blasted Lands collection quests"] = "完成诅咒之地的收集任务"
L["Error parsing guide"] = "解析指南时出错"
L["Fly to"] = "飞往"
L["Get the %s flight path"] = "获取 %s 飞行路线"
L["Go to"] = "前往"
L["Grind until you are %.0f%% into %s with %s"] = "刷怪直到你在 %s 达到 %.0f%% 经验值,使用 %s"
L["Grind until you are %.0f%% into level %s"] = "刷怪直到你到达 %s 级的 %.0f%% 经验值"
L["Grind until you are %d away from %s with %s"] = "刷怪直到你距离 %s 还差 %d 经验值,使用 %s"
L["Grind until you are %d xp away from level %s"] = "刷怪直到你距离 %s 级还差 %d 经验值"
L["Grind until you are %s into %s with %s"] = "刷怪直到你在 %s 达到 %s 经验值,使用 %s"
L["Grind until you are %s xp into level %s"] = "刷怪直到你在 %s 级达到 %s 经验值"
L["Missing pre-requisites"] = "缺少前置条件"
L["Objective Complete"] = "目标完成"
L["Retrieving quest data"] = "正在检索任务数据"
L["Sell junk/resupply"] = "出售垃圾物品/补给"
L["Set your Hearthstone to"] = "将你的炉石设置到"
L["Skip to step %d if you are level %d or above"] = "如果你的等级是 %d 级或以上,请跳到第 %d 步"
L["Stable your pet"] = "寄养你的宠物"
L["Throw away %s%s from your bags"] = "从你的背包中丢弃 %s%s"
L["Train skills"] = "学习技能"

-- GuideLoader.lua文件
L["Account mismatch, import string does not apply to current account"] = "账号不匹配,导入字符串不适用于当前账号"
L["Error parsing"] = "解析错误"
L["Error parsing guide"] = "解析指南时出错"
L["Failed to ReadCacheData"] = "读取缓存数据失败"
L["Guide has no name"] = "指南没有名称"
L["Guides Loaded Successfully"] = "指南加载成功"
L["Incomplete or invalid encoded string"] = "不完整或无效的编码字符串"
L["Loading Guides"] = "正在加载指南"
L["Total guides loaded: %d/%s"] = "已加载指南总数: %d/%s"
L["Unable to decode cached guide (%s), removed"] = "无法解码缓存的指南 (%s),已移除"

-- GuideWindow.lua文件
L["Activate Hardcore mode"] = "激活硬核模式"
L["Activate the Gold Assistant mode"] = "激活金币助手模式"
L["Activate the Quest Guide mode"] = "激活任务指南模式"
L["Available Guides"] = "可用指南"
L["Deactivate Hardcore mode"] = "停用硬核模式"
L["Give Feedback for step"] = "为步骤提供反馈"
L["Go to step"] = "转到步骤"
L["Gold Farming Guides"] = "金币刷怪指南"
L["Hide tips"] = "隐藏提示"
L["Import guide"] = "导入指南"
L["Leveling report"] = "升级报告"
L["Open Feedback Form"] = "打开反馈表单"
L["Reload Guide"] = "重新加载指南"
L["Select another guide"] = "选择另一个指南"
L["Step %d"] = "第 %d 步"
L["Unused Guides"] = "未使用的指南"
L["Welcome to RestedXP Guides\nRight click to pick a guide"] = "欢迎使用 RestedXP 指南\n右键点击选择指南"

-- InventoryManager.lua文件
L["%s: |c%sSet %s as junk|r"] = "%s: |c%s将 %s 设为垃圾|r"
L["%s: |c%sSet %s as useful|r"] = "%s: |c%s将 %s 设为有用|r"
L["Delete Cheapest Junk Item"] = "删除最便宜的垃圾物品"
L["RXPGuides: |c%sDeleting %sx%s|r"] = "RXPGuides: |c%s正在删除 %sx%s|r"
L["RXPGuides: |c%sInventory is full, deleting %sx%s|r"] = "RXPGuides: |c%s背包已满,正在删除 %sx%s|r"
L["RXPGuides: |c%sInventory is full, sorting arrows/bullets|r"] = "RXPGuides: |c%s背包已满,正在整理箭矢/弹药|r"
L["RXPGuides: |c%sSold junk items for|r %s"] = "RXPGuides: |c%s已出售垃圾物品,获得|r %s"
L["RXPGuides: |c%sSorting arrows/bullets|r"] = "RXPGuides: |c%s正在整理箭矢/弹药|r"

-- LevelingTracker.lua文件
L["Compare"] = "比较"
L["Enable Leveling Report Inspections"] = "启用升级报告查看"
L["Experience Sources"] = "经验来源"
L["Export"] = "导出"
L["Extras"] = "额外内容"
L["Import"] = "导入"
L["In-progress"] = "进行中"
L["Level"] = "等级"
L["Level %d time"] = "第 %d 级用时"
L["Level Splits"] = "升级分段"
L["Level Time"] = "升级时间"
L["Max"] = "最大"
L["Missing data"] = "缺少数据"
L["Reached Level"] = "达到等级"
L["Resetting level %d start time to now!"] = "正在将 %d 级的开始时间重置为现在!"
L["Send or receive inspection requests for other Leveling Reports"] = "发送或接收其他升级报告的查看请求"
L["Teamwork"] = "团队合作"
L["Temporarily hide, use '/rxp splits' to show again"] = "暂时隐藏,使用 '/rxp splits' 再次显示"
L["Time spent"] = "花费时间"
L["Time to"] = "距离"
L["Total Time"] = "总时间"
L["Unable to retrieve report for"] = "无法检索报告"
L["Zones & Dungeons"] = "区域和副本"

-- QuestLog.lua文件
L["Quest is being picked up at"] = "正在接取任务于"
L["Quest is being turned in at"] = "正在交付任务于"

-- RXPGuides.lua文件
L["Development"] = "开发"

-- SettingsPanel.lua文件
L["Abandon the following quests?"] = "放弃以下任务?"
L["Active Item Scale"] = "活动物品缩放"
L["Active Items"] = "活动物品"
L["Active Targets"] = "活动目标"
L["Active Targets Scale"] = "活动目标缩放"
L["Add main options menu to minimap"] = "将主选项菜单添加到小地图"
L["Add options menu to map"] = "将选项菜单添加到地图"
L["Adjust the leveling routes to the current season"] = "调整升级路线以适应当前赛季"
L["Adjust the leveling routes to the deathless ruleset"] = "调整升级路线以适应无死亡规则"
L["Adjust the routes to include almost every quest in the Northrend zones"] = "调整路线以包含诺森德区域的几乎所有任务"
L["Adjust the routes to include more quests"] = "调整路线以包含更多任务"
L["Adjusts the batching window tolerance, used for hearthstone batching. Increase this value if you're experiencing framerate drops when using your Hearthstone"] = "调整批处理窗口容差,用于炉石批处理。如果在使用炉石时遇到帧率下降,请增加此值"
L["Adjusts the guide routes to match increased xp rate bonuses"] = "调整指南路线以匹配增加的经验值加成"
L["Adjusts the guide routes to match the content phase\nPhase 2: Dire Maul quests\nPhase 3: 100% quest XP (SoM)\nPhase 4: ZG/Silithus quests\nPhase 5: AQ quests\nPhase 6: Eastern Plaguelands quests"] = "调整指南路线以匹配内容阶段\n第2阶段:厄运之槌任务\n第3阶段:100%任务经验值 (怀旧服)\n第4阶段:祖尔格拉布/希利苏斯任务\n第5阶段:安其拉任务\n第6阶段:东瘟疫之地任务"
L["Adjusts the size of the world map pins"] = "调整世界地图图钉的大小"
L["Advanced Settings"] = "高级设置"
L["Advertises and compares addon versions with all RXP users in party"] = "与队伍中所有 RXP 用户广告和比较插件版本"
L["Allows guides to choose quest rewards automatically"] = "允许指南自动选择任务奖励"
L["Allows the guide to automatically fly you to your destination"] = "允许指南自动将你飞往目的地"
L["Allows the guide to automatically set your home at an Innkeeper"] = "允许指南自动在旅店设置你的炉石"
L["Allows the guide to automatically skip gossip for NPCs"] = "允许指南自动跳过 NPC 对话"
L["Allows the guide to buy useful leveling spells automatically"] = "允许指南自动购买有用的升级法术"
L["Allows you to toggle items as junk by clicking on it with CTRL+RightClick or ALT+RightClick"] = "允许你通过 CTRL+右键点击 或 ALT+右键点击 将物品标记为垃圾"
L["Always Open Leveling Report With Character Panel"] = "始终在打开角色面板时显示升级报告"
L["Announce Flying Step timers"] = "通告飞行步骤计时器"
L["Announce Level Ups (Emote)"] = "通告升级 (表情)"
L["Announce Level Ups (Guild Chat)"] = "通告升级 (公会聊天)"
L["Announce Level Ups (Party Chat)"] = "通告升级 (队伍聊天)"
L["Announce in guild chat when you level up"] = "在公会聊天中通告你的升级"
L["Announce in party chat when you collect all the items relevant to a quest (.collect)"] = "当你收集到所有与任务相关的物品时在队伍聊天中通告 (.collect)"
L["Announce in party chat when you complete certain quests (.complete)"] = "当你完成某些任务时在队伍聊天中通告 (.complete)"
L["Announce in party chat when you level up"] = "在队伍聊天中通告你的升级"
L["Announce in party chat where you're flying and how long until you arrive"] = "在队伍聊天中通告你正在飞往何处以及预计到达时间"
L["Announce when Quest Step is completed"] = "通告任务步骤完成"
L["Announce when all Step items are collected"] = "通告所有步骤物品已收集"
L["Announcements"] = "通告"
L["Any items marked as junk will display a gold coin icon on the top left corner of the item icon within your bags"] = "任何标记为垃圾的物品在背包中都会在物品图标的左上角显示一个金币图标"
L["Arrow Scale"] = "箭头缩放"
L["Arrow Text Size"] = "箭头文字大小"
L["Auto Sell Junk"] = "自动出售垃圾"
L["Autohide in Raids"] = "在团队中自动隐藏"
L["Automatic quest sharing"] = "自动任务分享"
L["Automatically attempts to discard the cheapest junk item from your bags if your inventory is full"] = "如果背包已满,自动尝试丢弃最便宜的垃圾物品"
L["Automatically chooses the best calculated quest reward"] = "自动选择计算出的最佳任务奖励"
L["Automatically create a targeting macro"] = "自动创建目标宏"
L["Automatically hide when in a raid, and unhide when you leave a raid"] = "在团队中自动隐藏,离开团队时自动取消隐藏"
L["Automatically scan nearby targets"] = "自动扫描附近目标"
L["Automatically sell all gray items and all other items that you set as junk"] = "自动出售所有灰色物品和所有你设置为垃圾的其他物品"
L["Automatically skip tasks in which you don't have the required quest pre-requisites\n(Requires Questie)"] = "自动跳过你不符合任务前置条件的任务\n(需要 Questie)"
L["Automation"] = "自动化"
L["Batching window size (ms)"] = "批处理窗口大小 (毫秒)"
L["Battle.net unreachable, please exit your client, restart Battle.net, and try again"] = "无法连接 Battle.net,请退出客户端,重启 Battle.net,然后重试"
L["Buy"] = "购买"
L["Calculates item upgrades with Tactics' effective power weights"] = "使用 Tactics 的有效能力权重计算物品升级"
L["Change font size of the Guide Window"] = "更改指南窗口的字体大小"
L["Check for Addon Incompatibility"] = "检查插件不兼容性"
L["Check if targets are nearby\nWarning: This relies on ADDON_ACTION_FORBIDDEN errors from TargetUnit() to function."] = "检查目标是否在附近\n警告:这依赖于 TargetUnit() 的 ADDON_ACTION_FORBIDDEN 错误才能工作。"
L["Check loaded addons for known compatibility issues with RXP"] = "检查已加载的插件是否与 RXP 存在已知的兼容性问题"
L["Checks for heirlooms and experience buffs"] = "检查传家宝和经验增益"
L["Checks for nearby rare spawns"] = "检查附近的稀有怪"
L["Choose Theme"] = "选择主题"
L["Choose active theme"] = "选择活动主题"
L["Cleanup Orphaned Quests"] = "清理孤立任务"
L["Cleanup obsolete or leftover quests"] = "清理过时或遗留的任务"
L["Click to set a keybind"] = "点击设置快捷键"
L["Communications"] = "通讯"
L["Compare Next Level"] = "比较下一级"
L["Content phase"] = "内容阶段"
L["Create Targeting Macro"] = "创建目标宏"
L["Current step frame anchor"] = "当前步骤框架锚点"
L["Currently loaded imported guides"] = "当前加载的导入指南"
L["Dangerous Mobs Tracking"] = "危险怪物追踪"
L["Delete Cheapest Junk Item Keybind"] = "删除最便宜垃圾物品快捷键"
L["Delete imported guide"] = "删除导入的指南"
L["Detect Rate"] = "检测频率"
L["Disable Colors"] = "禁用颜色"
L["Disable dragging/resizing, use alt+left click on the main window to resize it"] = "禁用拖动/调整大小,使用 alt+左键点击 主窗口来调整其大小"
L["Discard junk items if bag is full"] = "如果背包已满则丢弃垃圾物品"
L["Displays dangerous mobs and patrols on the targeting window (WIP)"] = "在目标窗口显示危险怪物和巡逻怪 (开发中)"
L["Displays dangerous mobs and patrols on your map (WIP)"] = "在地图上显示危险怪物和巡逻怪 (开发中)"
L["Displays guides that are not applicable for your class/race such as starting zones for other races"] = "显示不适用于你的职业/种族的指南,如其他种族的起始区域"
L["Displays the best calculated item upgrade"] = "显示计算出的最佳物品升级"
L["Displays the best sellable quest reward"] = "显示最佳可出售任务奖励"
L["Distance Between Pins"] = "图钉之间的距离"
L["Dungeons"] = "副本"
L["Emergency Actions"] = "紧急行动"
L["Enable Active Targets"] = "启用活动目标"
L["Enable Addon Version Checks"] = "启用插件版本检查"
L["Enable Animations"] = "启用动画"
L["Enable Beta Features"] = "启用测试功能"
L["Enable Debug"] = "启用调试"
L["Enable Level Splits"] = "启用等级分段"
L["Enable Leveling Report Inspections"] = "启用升级报告查看"
L["Enable Leveling Tracker"] = "启用升级追踪器"
L["Enable Minimap Button"] = "启用小地图按钮"
L["Enable Talent Plan"] = "启用天赋计划"
L["Enable Talent Previews"] = "启用天赋预览"
L["Enable Talents Guides"] = "启用天赋指南"
L["Enable Tips"] = "启用提示"
L["Enable Tips Frame"] = "启用提示框架"
L["Enable Warning"] = "启用警告"
L["Enable Warning Sound"] = "启用警告音效"
L["Enable World Map Button"] = "启用世界地图按钮"
L["Enable embedded Cpt. Stadics' Vendor Treasures"] = "启用嵌入的 Cpt. Stadics' 商人宝藏"
L["Enables new features, forces reload to take effect"] = "启用新功能,需要重新加载才能生效"
L["Enables or disables the chromie time guides. Note that freshly created accounts without a level 60 character cannot access chromie time"] = "启用或禁用时光漫游指南。请注意,新创建的账号如果没有60级角色将无法使用时光漫游"
L["Enables the RestedXP Leveling Report when you open your character panel"] = "打开角色面板时启用 RestedXP 升级报告"
L["Enables the automation of the innkeeper prompt, where you can set your home location in the same server tick you're teleporting away"] = "启用旅店老板提示自动化,你可以在传送离开的同一个服务器刻度中设置你的炉石位置"
L["Experience rate change detected, reloading guide for %.2fx"] = "检测到经验值倍率变化,正在为 %.2fx 重新加载指南"
L["Experience rates"] = "经验值倍率"
L["Failed to Import Guides: Invalid Import String"] = "导入指南失败:无效的导入字符串"
L["Flash Client Icon"] = "闪烁客户端图标"
L["Flashes the game icon on taskbar when enemy target found"] = "发现敌方目标时闪烁任务栏上的游戏图标"
L["Flashes the screen corners when an emergency action is recommended"] = "推荐紧急行动时闪烁屏幕边角"
L["Flashes the screen corners when enemy target found"] = "发现敌方目标时闪烁屏幕边角"
L["Flashes the screen corners when in danger of drowning"] = "有溺水危险时闪烁屏幕边角"
L["Flight Path automation"] = "飞行路线自动化"
L["Font"] = "字体"
L["Font Path"] = "字体路径"
L["Group coordination"] = "小组协调"
L["Guide Font Size"] = "指南字体大小"
L["Guide Import"] = "指南导入"
L["Guide Routing"] = "指南路线"
L["Guide Window"] = "指南窗口"
L["Guides to import"] = "要导入的指南"
L["Hardcore mode"] = "硬核模式"
L["Hearthstone batching"] = "炉石批处理"
L["Hide Active Item window"] = "隐藏活动物品窗口"
L["Hide Background"] = "隐藏背景"
L["Hide Mini Map Pins"] = "隐藏小地图图钉"
L["Hide Splits Background"] = "隐藏分段背景"
L["Hide Targets Background"] = "隐藏目标背景"
L["Hide Window"] = "隐藏窗口"
L["Hide completed steps"] = "隐藏已完成步骤"
L["Hide waypoint arrow"] = "隐藏路径点箭头"
L["Hides the main window"] = "隐藏主窗口"
L["Highlight active map pins"] = "高亮显示活动地图图钉"
L["Highlight or list levels for each talent"] = "高亮显示或列出每个天赋的等级"
L["Historical levels to show"] = "显示的历史等级"
L["Holding the Control key modifier also toggles the quest auto accept feature on and off"] = "按住 Ctrl 键也可以开关任务自动接受功能"
L["If this option is enabled, it disables all steps involving trading or Auction House"] = "如果启用此选项,将禁用所有涉及交易或拍卖行的步骤"
L["If two or more steps are very close together, this addon will group them into a single pin on the map. Adjust this range to determine how close together two steps must be to form a group."] = "如果两个或多个步骤非常接近,此插件会将它们分组到地图上的单个图钉。调整此范围以确定两个步骤必须多近才能形成一个组。"
L["Ignore Questie announcements"] = "忽略 Questie 通告"
L["Import"] = "导入"
L["Innkeeper Bind automation"] = "旅店老板绑定自动化"
L["Join Discord"] = "加入 Discord"
L["Level Splits"] = "等级分段"
L["Level Splits Font Size"] = "等级分段字体大小"
L["Level Splits History"] = "等级分段历史"
L["Level Splits Opacity"] = "等级分段不透明度"
L["Leveling Tracker"] = "升级追踪器"
L["Loaded %d characters into import buffer"] = "已将 %d 个字符加载到导入缓冲区"
L["Loaded %d characters into import buffer, %d shown"] = "已将 %d 个字符加载到导入缓冲区,显示 %d 个"
L["Lock Frames"] = "锁定框架"
L["Look and Feel"] = "外观和感觉"
L["Loremaster Mode"] = "博学者模式"
L["Lower number to make Level Splits more transparent"] = "降低数值使等级分段更透明"
L["Macro capacity reached"] = "宏容量已达上限"
L["Make a public emote when you level up"] = "升级时发送公开表情"
L["Make background transparent"] = "使背景透明"
L["Map Pin Background Opacity"] = "地图图钉背景不透明度"
L["Map Pin Scale"] = "地图图钉缩放"
L["Map Pin color"] = "地图图钉颜色"
L["Map Pins"] = "地图图钉"
L["Mark Enemy Mobs"] = "标记敌对怪物"
L["Mark Enemy Targets"] = "标记敌对目标"
L["Mark Friendly Targets"] = "标记友好目标"
L["Mark enemy mobs with skull, cross, and square"] = "用骷髅、十字和方块标记敌对怪物"
L["Mark friendly targets with star, circle, diamond, and triangle"] = "用星星、圆圈、钻石和三角形标记友好目标"
L["Mark special enemy targets with moon"] = "用月亮标记特殊敌对目标"
L["Northrend Loremaster"] = "诺森德博学者"
L["Notice: Changing experience rates beyond 1x may cause some chapters to become hidden and certain steps may automatically skip as you out level them"] = "注意:将经验值倍率调整到 1 倍以上可能会导致某些章节被隐藏,并且某些步骤可能会因为你超出等级而自动跳过"
L["Notify on Rares"] = "稀有怪通知"
L["Notify on new target"] = "新目标通知"
L["Notify when a new rare is found"] = "发现新稀有怪时通知"
L["Notify when a new target is loaded"] = "加载新目标时通知"
L["Number of Map Pins"] = "地图图钉数量"
L["Number of map pins shown on the world map"] = "世界地图上显示的地图图钉数量"
L["Only show when in range"] = "仅在范围内显示"
L["Only shows current and future steps on the step list window"] = "步骤列表窗口仅显示当前和未来的步骤"
L["Open Feedback Form"] = "打开反馈表单"
L["Paste encoded strings"] = "粘贴编码字符串"
L["Pick Up"] = "拾取"
L["Play Sound"] = "播放音效"
L["Please restart your game client and try again"] = "请重新启动游戏客户端并重试"
L["Preview Changes"] = "预览更改"
L["Preview theme changes"] = "预览主题更改"
L["Profile changed, Reload UI for settings to take effect"] = "配置已更改,重新加载界面以使设置生效"
L["Purge All Data"] = "清除所有数据"
L["Quest Cleanup"] = "任务清理"
L["Quest Reward Automation"] = "任务奖励自动化"
L["Quest Reward Recommendation"] = "任务奖励推荐"
L["Quest Sellable Recommendation"] = "任务可售出推荐"
L["Quest auto accept/turn in"] = "任务自动接受/交付"
L["Quest auto rewards"] = "任务自动奖励"
L["RGB hex color code"] = "RGB 十六进制颜色代码"
L["Reload guides and UI"] = "重新加载指南和界面"
L["Remove"] = "移除"
L["Requires Reload to take effect"] = "需要重新加载才能生效"
L["Reset Arrow Position"] = "重置箭头位置"
L["Right Click Modifier"] = "右键点击修饰键"
L["Run Guide Configurator"] = "运行指南配置器"
L["Scale of the Active Item frame"] = "活动物品框架缩放"
L["Scale of the Active Targets frame"] = "活动目标框架缩放"
L["Scale of the Main Window, use alt+left click on the main window to resize it"] = "主窗口缩放,使用 alt+左键点击 主窗口来调整其大小"
L["Scale of the Waypoint Arrow"] = "路径点箭头缩放"
L["Scan Enemy Targets"] = "扫描敌方目标"
L["Scan Friendly Targets"] = "扫描友方目标"
L["Scan for Nearby Rares"] = "扫描附近稀有怪"
L["Scan for dangerous mobs"] = "扫描危险怪物"
L["Scan for enemy targets"] = "扫描敌方目标"
L["Scan for friendly targets"] = "扫描友方目标"
L["Season"] = "赛季"
L["Send announcements without another RXP user in group"] = "在小组中没有其他 RXP 用户时也发送通告"
L["Send or receive inspection requests for other Leveling Reports"] = "发送或接收其他升级报告的查看请求"
L["Send quest and collect step announcements even if Questie is enabled"] = "即使启用了 Questie 也发送任务和收集步骤通告"
L["Sends sound on enemy target found"] = "发现敌方目标时发出声音"
L["Set current profile as default"] = "将当前配置设为默认"
L["Set primary background"] = "设置主要背景"
L["Sets maximum number of talents to layout"] = "设置要布局的最大天赋数量"
L["Sets the current step frame to grow from bottom to top or top to bottom"] = "设置当前步骤框架从下到上或从上到下增长"
L["Show Chromie Time Guides"] = "显示时光漫游指南"
L["Show Flight Timers"] = "显示飞行计时器"
L["Show Group Quests"] = "显示小组任务"
L["Show Total Time Split"] = "显示总时间分段"
L["Show a targeting circle around active map pins"] = "在活动地图图钉周围显示目标圈"
L["Show all Enabled Frames"] = "显示所有已启用的框架"
L["Show junk item indicator"] = "显示垃圾物品指示器"
L["Show step list"] = "显示步骤列表"
L["Show unused guides"] = "显示未使用的指南"
L["Show/Hide the bottom frame listing all the steps of the current guide"] = "显示/隐藏底部框架,列出当前指南的所有步骤"
L["Size of the waypoint arrow text"] = "路径点箭头文字大小"
L["Skip Gossip"] = "跳过闲聊"
L["Skip overleveled steps"] = "跳过超出等级的步骤"
L["Skip quests with missing pre-requisites"] = "跳过缺少前置条件的任务"
L["Skip steps you're overleveled for"] = "跳过你等级过高的步骤"
L["Solo Self Found Mode"] = "单人自找模式"
L["Sound Channel"] = "声音频道"
L["Step Highlight"] = "步骤高亮"
L["Step List Background"] = "步骤列表背景"
L["Step mouseover highlight color"] = "步骤鼠标悬停高亮颜色"
L["Talent Plan Number"] = "天赋计划编号"
L["Targeting Macro"] = "目标宏"
L["Text Color"] = "文字颜色"
L["The opacity of the black circles on the map and mini map"] = "地图和小地图上黑色圆圈的不透明度"
L["This action will remove ALL guides from the database\nAre you sure?"] = "此操作将从数据库中移除所有指南\n你确定吗?"
L["This requires a reload to take effect, continue?"] = "这需要重新加载才能生效,是否继续?"
L["Threshold"] = "阈值"
L["Tips"] = "提示"
L["Toggle junk with modified right click"] = "使用修改的右键点击切换垃圾"
L["Toggles all addon frames on or off"] = "开关所有插件框架"
L["Tooltip"] = "鼠标提示"
L["Track Mobs on Map"] = "在地图上追踪怪物"
L["Trainer automation"] = "训练师自动化"
L["Vendor Treasures"] = "商人宝藏"
L["Warning"] = "警告"
L["Warning: Changing this setting mid-guide may cause quest pre-requisite failures.\nGuides were optimized for experience, disabling this option will result in a disjointed guide steps."] = "警告:在指南中途更改此设置可能导致任务前置条件失败。\n指南已为经验优化,禁用此选项将导致指南步骤不连贯。"
L["Waypoint Arrow"] = "路径点箭头"
L["When comparing, show next level's time"] = "比较时显示下一级的时间"
L["When comparing, show total time difference"] = "比较时显示总时间差异"
L["Whenever you accept a quest in the guide, the addon tries to share it with your group"] = "每当你在指南中接受任务时,插件会尝试与你的小组分享"
L["Window Scale"] = "窗口缩放"
L["Without this checked we will only send announcements if another RestedXP User is in your group"] = "如果不勾选此项,我们只会在你的小组中有其他 RestedXP 用户时发送通告"

-- Talents.lua文件
L["Available Guides"] = "可用指南"
L["Error parsing guide"] = "解析指南时出错"
L["Left click to apply talents"] = "左键点击应用天赋"
L["Loaded next guide, %s"] = "已加载下一个指南,%s"
L["Reached maximum level for guide"] = "已达到指南的最高等级"
L["Talented detected, please disable for talent guide functionality"] = "检测到 Talented,请禁用以使用天赋指南功能"
L["Too high for %s"] = "等级过高无法使用 %s"
L["Too low for %s"] = "等级过低无法使用 %s"
L["Welcome to RestedXP Guides\nRight click to pick a guide"] = "欢迎使用 RestedXP 指南\n右键点击选择指南"

-- Targeting.lua文件
L["A macro has been automatically built to aid in leveling. Please move %s to your action bars."] = "已自动创建一个宏来辅助升级。请将 %s 移动到你的动作条。"
L["Rare Found! %s is nearby."] = "发现稀有怪!%s 在附近。"
L["Targeting macro updated with:%s"] = "目标宏已更新:%s"
L["current step has no configured targets"] = "当前步骤没有配置目标"

-- AceConfigCmd-3.0.lua文件
L["'%s' '%s' - expected 'on' or 'off', or no argument to toggle."] = "'%s' '%s' - 需要 'on' 或 'off',或无参数来切换。"
L["'%s' '%s' - expected 'on', 'off' or 'default', or no argument to toggle."] = "'%s' '%s' - 需要 'on'、'off' 或 'default',或无参数来切换。"
L["'%s' - Invalid Keybinding."] = "'%s' - 无效的快捷键绑定。"
L["'%s' - expected 'RRGGBB' or 'r g b'."] = "'%s' - 需要 'RRGGBB' 或 'r g b'。"
L["'%s' - expected 'RRGGBBAA' or 'r g b a'."] = "'%s' - 需要 'RRGGBBAA' 或 'r g b a'。"
L["'%s' - expected 'on' or 'off', or no argument to toggle."] = "'%s' - 需要 'on' 或 'off',或无参数来切换。"
L["'%s' - expected 'on', 'off' or 'default', or no argument to toggle."] = "'%s' - 需要 'on'、'off' 或 'default',或无参数来切换。"
L["'%s' - values must all be either in the range 0-1 or 0-255."] = "'%s' - 所有值必须在 0-1 或 0-255 范围内。"
L["'%s' - values must all be either in the range 0..1 or 0..255."] = "'%s' - 所有值必须在 0..1 或 0..255 范围内。"
L["default"] = "默认"
L["expected number"] = "需要数字"
L["invalid input"] = "无效输入"
L["must be equal to or higher than %s"] = "必须等于或高于 %s"
L["must be equal to or lower than %s"] = "必须等于或低于 %s"
L["off"] = "关闭"
L["on"] = "开启"
L["unknown argument"] = "未知参数"
L["unknown selection"] = "未知选择"
