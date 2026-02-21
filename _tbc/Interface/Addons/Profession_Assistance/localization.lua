PA_LOCALIZATION = {
	-- Slash Command --
	['PA'] = 'PA',
	
	-- Options Panel --
	['Main'] = 'Main',
	['Options'] = 'Options',
	['Professions'] = 'Professions',
	['Global'] = 'Global',
	
	-- buttons --
	['Enable chat'] = 'Enable chat',
	['Shown when'] = 'Shown when',
	['On Shift'] = 'On Shift',
	
	['Enable Master'] = 'Enable Master',
	['Master switch'] = 'Master switch',
	
	['Show Icons'] = 'Show Icons',
	['Show icons in front of result items'] = 'Show icons in front of result items',
	
	['Minimap Button'] = 'Minimap Button',
	['Enable Minimap'] = 'Enable Minimap',
	['Toggle minimap button'] = 'Toggle minimap button',
	
	['Herbalism Locations'] = 'Herbalism Locations',
	['Enable Herbalism'] = 'Enable Herbalism',
	['Toggle herbalism locations on herbs'] = 'Toggle herbalism locations on herbs',
	
	['Toggle chat herbalism locations on herbs'] = 'Toggle chat herbalism locations on herbs',
	['Hold Shift to show Herbalism locations'] = 'Hold Shift to show Herbalism locations',
	
	['Milling'] = 'Milling',
	['Enable Milling'] = 'Enable Milling',
	['Toggle milling information on herbs'] = 'Toggle milling information on herbs',
	['Toggle chat information on herbs'] = 'Toggle chat information on herbs',
	['Hold Shift to show Milling information'] = 'Hold Shift to show Milling information',
	
	['Enable Herb'] = 'Enable Herb',
	['Toggle herb information on pigments'] = 'Toggle herb information on pigments',
	['Toggle chat information on pigments'] = 'Toggle chat information on pigments',
	['Hold Shift to show Herb information'] = 'Hold Shift to show Herb information',
	
	['Mining Locations'] = 'Mining Locations',
	['Enable Mining'] = 'Enable Mining',
	['Toggle mining locations on ores'] = 'Toggle mining locations on ores',
	['Toggle chat mining locations on ores'] = 'Toggle chat mining locations on ores',
	['Hold Shift to show Mining locations'] = 'Hold Shift to show Mining locations',
	
	['Prospecting'] = 'Prospecting',
	['Enable Prospecting'] = 'Enable Prospecting',
	['Toggle prospecting information on ores'] = 'Toggle prospecting information on ores',
	['Toggle chat information on ores'] = 'Toggle chat information on ores',
	['Hold Shift to show Prospecting information'] = 'Hold Shift to show Prospecting information',
	
	['Enable Ore'] = 'Enable Ore',
	['Toggle ore information on gems'] = 'Toggle ore information on gems',
	['Toggle chat information on gems'] = 'Toggle chat information on gems',
	['Hold Shift to show Ore information'] = 'Hold Shift to show Ore information',
	
	['Enchanting'] = 'Enchanting',
	["Enable Enchanting"] = "Enable Enchanting",
	["Toggle Disenchanting information on gear"] = "Toggle Disenchanting information on gear",
	["Toggle chat information on gear"] = "Toggle chat information on gear",
	["Hold Shift to show Disenchanting information"] = "Hold Shift to show Disenchanting information",
	
	['Enable Materials'] = 'Enable Materials',
	['Toggle gear source information on enchanting materials'] = 'Toggle gear source information on enchanting materials',
	['Toggle chat information on enchanting materials'] = 'Toggle chat information on enchanting materials',
	['Hold Shift to show Material information'] = 'Hold Shift to show Material information',
	
	-- Tooltip Info --
	['Found in'] = 'Found in',
	
	['Milling outcome'] = 'Milling outcome',
	['Milled from'] = 'Milled from',
	
	['Prospecting outcome'] = 'Prospecting outcome',
	['Prospected from'] = 'Prospected from',
	
	['Disenchant into'] = 'Disenchant into',
	['Disenchant from'] = 'Disenchant from',
	
	['Nodes'] = 'Nodes',
	
	-- Custom translations required --
	['Frozen Herb'] = 'Frozen Herb',
	['Netherdust Bush'] = 'Netherdust Bush',
	['Firethorn'] = 'Firethorn',
	['Sha-Touched Herb'] = 'Sha-Touched Herb',
	['Withered Herb'] = 'Withered Herb',
	['Fel-Encrusted Herb'] = 'Fel-Encrusted Herb',
	['World Quest'] = 'World Quest',
}

local L, locale = PA_LOCALIZATION, GetLocale()
if (locale == 'deDE') then
	L["Main"] = "Hauptmenü"
	L["Options"] = "Optionen"
	L["Professions"] = "Berufe"

	L["Enable chat"] = "Aktiviere Chat"
	L["Shown when"] = "Angezeigt wenn"
	L["On Shift"] = "Umschalttaste gedrückt"
	
	L["Master switch"] = "Hauptschalter"
	
	L["Minimap Button"] = "Minimap Symbol"
	L["Enable Minimap"] = "Aktiviere Minimap"
	L["Toggle minimap button"] = "Minimap Symbol AN/AUS"
	
	L["Herbalism Locations"] = "Kräutervorkommen"
	L["Enable Herbalism"] = "Aktiviere Kräuterkunde"
	L["Toggle herbalism locations on herbs"] = "Krätervorkommen AN/AUS"
	
	L["Toggle chat herbalism locations on herbs"] = "Kräutervorkommen im Chat AN/AUS"
	L["Hold Shift to show Herbalism locations"] = "Umschalttaste gedrückt halten um Kräutervorkommen anzuzeigen"
	
	L["Milling"] = "Mahlen"
	L["Enable Milling"] = "Aktiviere Mahlen"
	L["Toggle milling information on herbs"] = "Mahl Infos auf Kräutern AN/AUS"
	L["Toggle chat information on herbs"] = "Information über Kräuter im Chat AN/AUS"
	L["Hold Shift to show Milling information"] = "Umschalttaste halten um Mahlinfo anzuzeigen"
	
	L["Enable Herb"] = "Aktiviere Kräuter"
	L["Toggle herb information on pigments"] = "Kräuter Infos auf Pigmenten AN/AUS"
	L["Toggle chat information on pigments"] = "Information über Pigmente im Chat AN/AUS"
	L["Hold Shift to show Herb information"] = "Umschalttaste halten um Kräuterinfo anzuzeigen"
	
	L["Mining Locations"] = "Erzvorkommen"
	L["Enable Mining"] = "Aktiviere Bergbau"
	L["Toggle mining locations on ores"] = "Erzvorkommen AN/AUS"
	L["Toggle chat mining locations on ores"] = "Erzvorkommen im Chat AN/AUS"
	L["Hold Shift to show Mining locations"] = "Umschalttaste gedrückt halten um Erzvorkommen anzuzeigen"
	
	L["Prospecting"] = "Sondieren"
	L["Enable Prospecting"] = "Aktiviere Sondieren"
	
	L["Toggle chat information on ores"] = "Information über Erze im Chat AN/AUS"
	L["Hold Shift to show Prospecting information"] = "Umschalttaste halten um Sondierinfo anzuzeigen"
	
	L["Enable Ore"] = "Aktiviere Erz"
	L["Toggle ore information on gems"] = "Erz Infos auf Edelsteinen AN/AUS"
	L["Toggle chat information on gems"] = "Information über Edelsteine im Chat AN/AUS"
	L["Hold Shift to show Ore information"] = "Umschalttaste halten um Erzinfo anzuzeigen"
	
	L["Enchanting"] = "Verzauberkunst"
	L["Enable Materials"] = "Aktiviere Materialien"
	L["Toggle chat information on enchanting materials"] = "Informationen über Enchantmaterialien im Chat AN/AUS"
	L["Hold Shift to show Material information"] = "Umschalttaste halten um Materialinfo anzuzeigen"
	
	L["Milled from"] = "Gemahlen von"
	
	L["Prospected from"] = "Sondiert aus"
end

if (locale == 'esES') then
	-- Options Panel --
	L["Main"] = "Principal"
	L["Options"] = "Opciones"
	L["Professions"] = "Profesiones"
	L["Global"] = "Global"
	-- buttons --
	L["Enable chat"] = "Mostrar en el chat"
	L["Shown when"] = "Cuándo mostrar"
	L["On Shift"] = "Con Shift"

	L["Enable Master"] = "Interruptor maestro"
	L["Master switch"] = "Habilitar interruptor maestro"

	L["Show Icons"] = "Mostrar iconos"
	L["Show icons in front of result items"] = "Mostrar iconos delante de los objetos resultantes"

	L["Minimap Button"] = "Botón del minimapa"
	L["Enable Minimap"] = "Habilitar botón del minimapa"
	L["Toggle minimap button"] = "Mostrar botón del minimapa"

	L["Herbalism Locations"] = "Localizaciones de Herboristería"
	L["Enable Herbalism"] = "Activar Herboristería"
	L["Toggle herbalism locations on herbs"] = "Mostrar localizaciones de herboristería en las hierbas"

	L["Toggle chat herbalism locations on herbs"] = "Mostrar localizaciones de herboristería en al chat"
	L["Hold Shift to show Herbalism locations"] = "Mantén Shift para mostrar localizaciones de herboristería"

	L["Milling"] = "Molienda"
	L["Enable Milling"] = "Activar molienda"
	L["Toggle milling information on herbs"] = "Mostrar información de molienda en las hierbas"
	L["Toggle chat information on herbs"] = "Mostrar información de molienda en el chat"
	L["Hold Shift to show Milling information"] = "Mantén Shift para mostrar información de la molienda"

	L["Enable Herb"] = "Habilitar en hierbas"
	L["Toggle herb information on pigments"] = "Mostrar información sobre las hierbas en los pigmentos"
	L["Toggle chat information on pigments"] = "Mostrar información de los pigmentos en el chat"
	L["Hold Shift to show Herb information"] = "Mantén Shift para mostrar la información de hierbas"

	L["Mining Locations"] = "Localizaciones de Minería"
	L["Enable Mining"] = "Habilitar Minería"
	L["Toggle mining locations on ores"] = "Mostrar localizaciones de minería en las menas"
	L["Toggle chat mining locations on ores"] = "Mostrar localizaciones de minería en el chat"
	L["Hold Shift to show Mining locations"] = "Mantén Shift para mostrar localizaciones de minería"

	L["Prospecting"] = "Prospección"
	L["Enable Prospecting"] = "Habilitar Prospección"
	L["Toggle prospecting information on ores"] = "Mostrar información de prospección en las menas"
	L["Toggle chat information on ores"] = "Mostrar información de prospección en el chat"
	L["Hold Shift to show Prospecting information"] = "Mantén Shift para mostrar la información de prospección"

	L["Enable Ore"] = "Habilitar Menas"
	L["Toggle ore information on gems"] = "Mostrar información de menas en las gemas"
	L["Toggle chat information on gems"] = "Mostrar información de gemas en el chat"
	L["Hold Shift to show Ore information"] = "Mantén Shift para mostrar información de menas"

	L["Enchanting"] = "Encantamiento"
	L["Enable Enchanting"] = "Habilitar Encantamiento"
	L["Toggle Disenchanting information on gear"] = "Mostrar información de desencantamiento en el equipo"
	L["Toggle chat information on gear"] = "Mostrar información de desencantamiento en el chat"
	L["Hold Shift to show Disenchanting information"] = "Mantén Shift para mostrar información de desencantamiento"

	L["Enable Materials"] = "Habilitar materiales"
	L["Toggle gear source information on enchanting materials"] =
	"Mostrar equipo de origen en los materiales de encantamiento"
	L["Toggle chat information on enchanting materials"] = "Mostrar información de materiales de encantamiento en el chat"
	L["Hold Shift to show Material information"] = "Mantén Shift para mostrar información de materiales"
	-- Tooltip Info --
	L["Found in"] = "Encontrado en"

	L["Milling outcome"] = "Resultados de la molienda"
	L["Milled from"] = "Molido de"

	L["Prospecting outcome"] = "Resultados de la prospección"
	L["Prospected from"] = "Prospectado de"

	L["Disenchant into"] = "Se desencanta en"
	L["Disenchant from"] = "Desencantado de"

	L["Nodes"] = "Nodos"
	-- Custom translations required --
	L["Frozen Herb"] = "Hierba congelada"
	L["Netherdust Bush"] = "Arbusto de polvo abisal"
	L["Firethorn"] = "Espino de fuego"
	L["Sha-Touched Herb"] = "Hierba influenciada por el Sha"
	L["Withered Herb"] = "Hierba marchita"
	L["Fel-Encrusted Herb"] = "Hierba con costra vil"
	L["World Quest"] = "Misión de mundo"
end

if (locale == 'esMX') then
	-- None
end

if (locale == 'frFR') then
	L["Main"] = "Principal"
	
	L["Enable chat"] = "Activer le chat"
	
	L["Enable Minimap"] = "Activer la minicarte"
	
	L["Enable Herbalism"] = "Activer l'herboristerie"
	
	L["Enable Herb"] = "Activer l'herbe"
	
	L["Prospecting"] = "Prospection"
	
end

if (locale == 'itIT') then
	L["Options"] = "Opzioni"
	L["Professions"] = "Professioni"
	L["Global"] = "Globale"
	
	L["Enable Minimap"] = "Abilita Minimappa"
	
	L["Enable Herbalism"] = "Abilita Erbalismo"
	
	L["Enable Milling"] = "Abilita Pestatura"
	
end

if (locale == 'ptBR') then
	-- None
end

if (locale == 'ruRU') then
	L["Main"] = "Главное"
	L["Options"] = "Настройки"
	L["Professions"] = "Профессии"
	L["Global"] = "Глобальный"
	
	L["Enable chat"] = "Включить чат"
	L["Shown when"] = "Отображать когда"
	
	L["Herbalism Locations"] = "Локации травничества"
	L["Enable Herbalism"] = "Включить травничество"
	
	L["Milling"] = "Измельчение"
	
	L["Enable Herb"] = "Включить траву"
	
	L["Prospecting"] = "Просеивание"
	
	L["Enable Ore"] = "Включить руду"
	
	L["Enchanting"] = "Наложение чар"
	
	L["Prospected from"] = "Просеивается из"
end

if (locale == 'koKR') then
	L["PA"] = "프어"
	
	L["Main"] = "메인"
	L["Options"] = "옵션"
	L["Professions"] = "전문 기술들"
	L["Global"] = "글로벌"
	
	L["Enable chat"] = "채팅 활성화"
	
	L["Minimap Button"] = "미니맵 버튼"
	L["Enable Minimap"] = "미니맵 활성화"
	L["Toggle minimap button"] = "미니맵 버튼 토글"
	
	L["Herbalism Locations"] = "약초채집 지역"
	L["Enable Herbalism"] = "약초채집 활성화"
	L["Toggle herbalism locations on herbs"] = "약초에서 약초채집 위치 토글"
	
	L["Toggle chat herbalism locations on herbs"] = "약초에 대한 약초채집 정보 채팅 토글"
	L["Hold Shift to show Herbalism locations"] = "약초채집 위치를 표시하려면 Shift 키를 누르고 계세요"
	
	L["Milling"] = "제분"
	L["Enable Milling"] = "제분 활성화"
	L["Toggle milling information on herbs"] = "약초에 대한 제분 정보 토글"
	L["Toggle chat information on herbs"] = "약초에 대한 채팅 정보 토글"
	L["Hold Shift to show Milling information"] = "제분 정보를 표시하려면 Shift 키를 누르고 계세요"
	
	L["Enable Herb"] = "약초 활성화"
	L["Toggle herb information on pigments"] = "안료에 대한 약초 정보 토글"
	L["Toggle chat information on pigments"] = "안료에 대한 채팅 정보 토글"
	
	L["Mining Locations"] = "채광 지역"
	L["Enable Mining"] = "채광 활성화"
	L["Toggle mining locations on ores"] = "광석에 대한 채굴 위치 토글"
	L["Toggle chat mining locations on ores"] = "광석에서 채굴 위치 채팅 토글"
	L["Hold Shift to show Mining locations"] = "채광 정보를 표시하려면 Shift 키를 누르고 계세요"
	
	L["Prospecting"] = "예상"
	L["Enable Prospecting"] = "예상 활성화"
	L["Toggle prospecting information on ores"] = "광석에 대한 탐사 정보 토글"
	L["Toggle chat information on ores"] = "광석에 대한 채팅 정보 토글"
	L["Hold Shift to show Prospecting information"] = "예상 정보를 표시하려면 Shift 키를 누르고 계세요"
	
	L["Enable Ore"] = "광석 활성화"
	L["Toggle ore information on gems"] = "보석에 대한 광석 정보 토글"
	L["Toggle chat information on gems"] = "보석에 대한 채팅 정보 토글"
	L["Hold Shift to show Ore information"] = "광석 정보를 표시하려면 Shift 키를 누르고 계세요"
	
	L["Enchanting"] = "마법부여"
	
	L["Enable Materials"] = "재료 활성화"
	L["Toggle gear source information on enchanting materials"] = "마법부여 재료에 대한 장비 소스 정보 토글"
	L["Toggle chat information on enchanting materials"] = "마법부여 재료에 대한 채팅 정보 토글"
	L["Hold Shift to show Material information"] = "재료 정보를 표시하려면 Shift 키를 누르고 계세요"
	
	L["Milled from"] = "제분 from"
	L["Prospected from"] = "예상 from"
end

if (locale == 'zhCN') then
	-- Options Panel --
	L["Main"] = "主要"
	L["Options"] = "选项"
	L["Professions"] = "专业"
	L["Global"] = "全局"
	
	-- buttons --
	L["Enable chat"] = "启用 聊天框"
	L["Shown when"] = "在以下情况下显示"
	L["On Shift"] = "按住 Shift"
	
	L["Enable Master"] = "启用 专业助手"
	L["Master switch"] = "开/关 专业助手"
	
	L["Show Icons"] = "显示图标"
	L["Show icons in front of result items"] = "在提示中显示图标"
	
	L["Minimap Button"] = "小地图按钮"
	L["Enable Minimap"] = "启用 小地图按钮"
	L["Toggle minimap button"] = "启用/禁用 小地图按钮"
	
	L["Herbalism Locations"] = "采药位置"
	L["Enable Herbalism"] = "启用 采药位置"
	L["Toggle herbalism locations on herbs"] = "启用/禁用 草药的采集位置信息"
	
	L["Toggle chat herbalism locations on herbs"] = "启用/禁用 草药的采集位置信息（聊天框）"
	L["Hold Shift to show Herbalism locations"] = "按住 Shift 以显采药位置信息"
	
	L["Milling"] = "研磨"
	L["Enable Milling"] = "启用 草药的研磨产物"
	L["Toggle milling information on herbs"] = "启用/禁用 草药的研磨产物信息"
	L["Toggle chat information on herbs"] = "启用/禁用 草药的研磨产物信息（聊天框）"
	L["Hold Shift to show Milling information"] = "按住 Shift 以显示草药的研磨产物信息"
	
	L["Enable Herb"] = "启用 颜料的草药来源"
	L["Toggle herb information on pigments"] = "启用/禁用 颜料的草药来源信息"
	L["Toggle chat information on pigments"] = "启用/禁用 颜料的草药来源信息（聊天框）"
	L["Hold Shift to show Herb information"] = "按住 Shift 以显示颜料的草药来源信息"
	
	L["Mining Locations"] = "采矿位置"
	L["Enable Mining"] = "启用 采矿位置"
	L["Toggle mining locations on ores"] = "启用/禁用 矿石的采矿位置信息"
	L["Toggle chat mining locations on ores"] = "启用/禁用 矿石的采矿位置信息（聊天框）"
	L["Hold Shift to show Mining locations"] = "按住 Shift 以显示采矿位置信息"
	
	L["Prospecting"] = "选矿"
	L["Enable Prospecting"] = "启用 矿石的选矿产物"
	L["Toggle prospecting information on ores"] = "启用/禁用 矿石的选矿信息"
	L["Toggle chat information on ores"] = "启用/禁用 矿石的选矿信息（聊天框）"
	L["Hold Shift to show Prospecting information"] = "按住 Shift 以显示矿石的选矿产物信息"
	
	L["Enable Ore"] = "启用 宝石的选矿来源"
	L["Toggle ore information on gems"] = "启用/禁用 宝石的选矿来源信息"
	L["Toggle chat information on gems"] = "启用/禁用 宝石的选矿来源信息（聊天框）"
	L["Hold Shift to show Ore information"] = "按住 Shift 以显示宝石的选矿来源信息"
	
	L["Enchanting"] = "附魔"
	L["Enable Enchanting"] = "启用 附魔分解的产物"
	L["Toggle Disenchanting information on gear"] = "启用/禁用 附魔分解的产物信息"
	L["Toggle chat information on gear"] = "启用/禁用 附魔分解的产物信息（聊天框）"
	L["Hold Shift to show Disenchanting information"] = "按住 Shift 以显示附魔分解的产物信息"
	
	L["Enable Materials"] = "启用 附魔材料的来源"
	L["Toggle gear source information on enchanting materials"] = "启用/禁用 附魔材料的来源信息"
	L["Toggle chat information on enchanting materials"] = "启用/禁用 附魔材料的来源信息（聊天框）"
	L["Hold Shift to show Material information"] = "按住 Shift 以显示附魔材料的来源信息"
	
	-- Tooltip Info --
	L["Found in"] = "发现于"
	
	L["Milling outcome"] = "研磨产物"
	L["Milled from"] = "颜料来源"
	
	L["Prospecting outcome"] = "选矿产物"
	L["Prospected from"] = "选矿来源"
	
	L["Disenchant into"] = "分解产物"
	L["Disenchant from"] = "分解来源"
	
	L["Nodes"] = "采集点"
	
	-- Custom translations required --
	L["Frozen Herb"] = "冰冷的草药"
	L["Netherdust Bush"] = "灵尘灌木丛"
	L["Firethorn"] = "火棘"
	L["Sha-Touched Herb"] = "染煞草药"
	L["Withered Herb"] = "枯萎的草药"
	L["Fel-Encrusted Herb"] = "被邪能包裹的草药"
	L["World Quest"] = "世界任务"
end

if (locale == 'zhTW') then
	L["Main"] = "主要"
	L["Options"] = "選項"
	L["Professions"] = "專業技能"
	L["Global"] = "全域"
	
	L["Enable chat"] = "啟用聊天"
	L["Shown when"] = "何時顯示"
	
	L["Minimap Button"] = "小地圖按鈕"
	L["Enable Minimap"] = "啟用小地圖"
	
	L["Herbalism Locations"] = "草藥位置"
	L["Enable Herbalism"] = "啟用草藥"
	
	L["Milling"] = "研磨"
	L["Enable Milling"] = "啟用研磨"
	
	L["Enable Herb"] = "啟用草藥"
	
	L["Mining Locations"] = "採礦位置"
	L["Enable Mining"] = "啟用採礦"
	
	L["Prospecting"] = "探勘"
	L["Enable Prospecting"] = "啟用探勘"
	
	L["Enable Ore"] = "啟用礦石"
	
	L["Enchanting"] = "附魔"
	
	L["Enable Materials"] = "啟用材料"
	
	L["Prospected from"] = "探勘自"
end