----------------------------------------------------------------------
-- Leatrix Sounds Locale
----------------------------------------------------------------------

-- Create locale structure
local GameLocale = GetLocale()
local void, Leatrix_Sounds = ...
local function localeFunc(L, key) return key end
local L = setmetatable({}, {__index = localeFunc})
Leatrix_Sounds.L = L

if LeaSoundsDB and LeaSoundsDB.UseEnglishLanguage and LeaSoundsDB.UseEnglishLanguage == "On" then return end

-- Locale override (enUS, zhCN, zhTW, ruRU, koKR, deDE, esMX, frFR, itIT, ptBR)
-- GameLocale = "enUS"

-- zhCN: Simplified Chinese (People's Republic of China)
if GameLocale == "zhCN" then
L["Burning Crusade Classic Anniversary"] = "燃烧的远征周年纪念版"
L["Cataclysm"] = "旧世经典：大地的裂变"
L["Classic Era"] = "旧世经典"
L["Effects"] = "效果"
L["Help"] = "帮助"
L["If checked, music will be shown in the listing."] = "如果选中，音乐将显示在列表中。"
L["If checked, sound effects will be shown in the listing."] = "如果选中，声音效果将显示在列表中。"
L["If checked, unknown sound files will be shown in the listing.|n|nThese are typically newer sound files which do not have names yet.|n|nNote that some unknown sound files may not be currently playable."] = "如果选中，未知音频文件将显示在列表中。|n|n这些通常是较新的音频文件，还没有严格命名。|n|n请注意，某些未知的音频文件当前可能无法播放。"
L["LEATRIX SOUNDS: THIS IS FOR THE WAR WITHIN ONLY!"] = "LEATRIX SOUNDS：这只能在正式服生效！"
L["Midnight"] = "至暗之夜"
L["Music"] = "音乐"
L["No search results found"] = "未找到搜索结果"
L["Oops!"] = "啊！"
L["result"] = "结果"
L["results"] = "个结果"
L["Searches can consist of up to 10 keywords.  Keywords prefixed with ! are excluded from search results.|n|nWhile a track is selected, you can press W and S to play the previous and next track, E to replay the currently selected track or Q to stop playback.|n|nHold SHIFT and click to print (left-click) or insert (right-click) the selected track details in chat.|n|nHold CONTROL and click to print (left-click) or insert (right-click) the selected track ID in chat."] = "搜索最多可包含10个关键字。前缀为!从搜索结果中排除。|n|n选中音频时，您可以按W和S播放上一条和下一条音频，按E重播当前选定的条，按Q停止播放。|n|n按住SHIFT并单击以在聊天框中直接打印（左键单击）或在聊天输入框插入（右键单击）选定的曲目详细信息。|n|n按住CTRL并单击以在聊天框中直接打印（左键单击）或在聊天输入框插入（右键单击）所选音频ID。"
L["SFX"] = "音效"
L["So I guess there's nothing to see here."] = "所以我想这里什么也没找到。"
L["Sound Files"] = "音频文件"
L["Stop"] = "停止"
L["The War Within"] = "地心之战"
L["Toggle panel"] = "开关插件面板"
L["Unknown"] = "未知音频"
L["You need to select at least one sound category."] = "您需要至少选择一个音频类别。"

end

-- zhTW: Traditional Chinese (Taiwan)
if GameLocale == "zhTW" then

end

-- ruRU: Russian
if GameLocale == "ruRU" then

end

-- koKR: Korean
if GameLocale == "koKR" then
L["Burning Crusade Classic Anniversary"] = "불타는 성전 클래식 기념일"
L["Cataclysm"] = "대격변"
L["Classic Era"] = "클래식 시대"
L["Effects"] = "효과"
L["Help"] = "도움"
L["If checked, music will be shown in the listing."] = "음악이 목록에 표시됩니다."
L["If checked, sound effects will be shown in the listing."] = "사운드 효과가 목록에 표시됩니다."
L["If checked, unknown sound files will be shown in the listing.|n|nThese are typically newer sound files which do not have names yet.|n|nNote that some unknown sound files may not be currently playable."] = "알 수 없는 사운드 파일이 목록에 표시됩니다.|n|n이는 일반적으로 아직 이름이 지정되지 않은 최신 사운드 파일입니다.|n|n일부 알 수 없는 사운드 파일은 현재 재생이 불가능할 수 있습니다."
L["LEATRIX SOUNDS: THIS IS FOR THE WAR WITHIN ONLY!"] = "LEATRIX SOUNDS: 이것은 본 서버에서만 작동합니다!"
L["Midnight"] = "한밤"
L["Music"] = "음악"
L["No search results found"] = "검색 결과 없음"
L["Oops!"] = "이런!"
L["result"] = "결과"
L["results"] = "결과"
L["Searches can consist of up to 10 keywords.  Keywords prefixed with ! are excluded from search results.|n|nWhile a track is selected, you can press W and S to play the previous and next track, E to replay the currently selected track or Q to stop playback.|n|nHold SHIFT and click to print (left-click) or insert (right-click) the selected track details in chat.|n|nHold CONTROL and click to print (left-click) or insert (right-click) the selected track ID in chat."] = "검색어는 최대 10개까지 입력 가능합니다. ! 로 시작하는 검색어는 결과에서 제외됩니다.|n|n트랙 선택 시 W/S 키로 이전/다음 트랙 재생, E 키로 현재 트랙 재재생, Q 키로 재생 중지 가능합니다.|n|nSHIFT 키를 누른 상태에서 클릭하면 선택한 트랙 정보를 채팅창에 인쇄 (왼쪽 클릭) 또는 삽입 (오른쪽 클릭)합니다. |n|nCTRL 키를 누른 상태에서 클릭하면 선택한 트랙 ID를 채팅에 인쇄 (왼쪽 클릭) 하거나 삽입 (오른쪽 클릭) 할 수 있습니다."
L["SFX"] = "음향 효과"
L["So I guess there's nothing to see here."] = "아무것도 찾지 못한 것 같습니다."
L["Sound Files"] = "사운드 파일"
L["Stop"] = "중지"
L["The War Within"] = "내부 전쟁"
L["Toggle panel"] = "설정창 전환"
L["Unknown"] = "불명"
L["You need to select at least one sound category."] = "최소한 하나의 사운드 카테고리를 선택해야 합니다."

end

-- deDE: German
if GameLocale == "deDE" then
	
end

-- esMX: Spanish (Mexico)
if GameLocale == "esMX" then

end

-- esES: Spanish (Spain)
if GameLocale == "esES" then

end

-- frFR: French
if GameLocale == "frFR" then

end

-- itIT: Italian
if GameLocale == "itIT" then

end

-- ptBR: Portugese (Brazil)
if GameLocale == "ptBR" then

end
