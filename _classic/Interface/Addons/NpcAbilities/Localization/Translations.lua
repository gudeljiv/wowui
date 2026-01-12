local addonName = ...

_G["NpcAbilitiesTranslations"] = {}
local translationsFrame = CreateFrame("Frame")

local function addonLoaded(self, event, addonLoadedName)
    if addonLoadedName == addonName then
        _G["NpcAbilitiesTranslations"]["en"] = {
            options = {
                generalOptionsTitle = "General options",
                languageDropdownLabel = "Select language:",
                languages = {
                    en = "English",
                    es = "Spanish",
                    fr = "French",
                    de = "German",
                    pt = "Portuguese",
                    ru = "Russian",
                    ko = "Korean",
                    cn = "Chinese"
                },
                hotkeyModeLabel = "Select hotkey mode (on hold, some keys may not work as expected):",
                hotkeyModes = {
                    toggle = "Toggle",
                    hold = "Hold"
                },
                hotkeyButtonLabel = "Register toggle abilities description hotkey (Right-click to unbind)",
                hotkeyButtonInstructionText = "Press button..",
                hotkeyButtonNotBoundText = "Not Bound",
                abilityFieldsOptionsTitle = "Ability fields display and where",
                abilityFieldsDisplayModes = {
                    title = "After ability name",
                    separate = "As separate line"
                },
                displayAbilitiesMechanicLabel = "Display ability mechanic",
                displayAbilitiesMechanicDisplayModeLabel = "Where to display the ability mechanic",
                displayAbilitiesRangeLabel = "Display ability range",
                displayAbilitiesRangeDisplayModeLabel = "Where to display the ability range",
                displayAbilitiesCastTimeLabel = "Display ability cast time",
                displayAbilitiesCastTimeDisplayModeLabel = "Where to display the ability cast time",
                displayAbilitiesCooldownLabel = "Display ability cooldown",
                displayAbilitiesCooldownDisplayModeLabel = "Where to display the ability cooldown",
                displayAbilitiesDispelTypeLabel = "Display ability dispel type",
                displayAbilitiesDispelTypeDisplayModeLabel = "Where to display the ability dispel type",
                hideOptionsTitle = "Hide abilities",
                hideOptionsHotkeyModeLabel = "Register hide abilities hotkey (Right-click to unbind)",
                hideAbilitiesInInstanceLabel = "Hide abilities in instances (PVP and PVE)",
                displayLocationTitle = "Display Location",
                displayLocationLabel = "Where to display abilities:",
                displayLocations = {
                    tooltip = "Tooltip only",
                    target_frame = "Target frame only",
                    both = "Both"
                },
                displayPriorityIndicatorsLabel = "Show danger indicators (color-coded abilities)",
                delayedTooltipLoadingLabel = "Attempt to load ability data last in the tooltip (requires reload)",
            },
             game = {
                 hotkeyExplanatoryTextOne = "Press",
                 hotkeyExplanatoryTextTwo = "for details",
                 hotkeyNotBoundText = "Hotkey not bound",
                 mechanicText = "Mechanic",
                 rangeText = "Range",
                 castTimeText = "Cast time",
                 cooldownText = "Cooldown",
                 dispelTypeText = "Dispel type"
             }
        }

        _G["NpcAbilitiesTranslations"]["es"] = {
            options = {
                generalOptionsTitle = "Opciones generales",
                languageDropdownLabel = "Seleccionar idioma:",
                languages = {
                    en = "Inglés",
                    es = "Español",
                    fr = "Francés",
                    de = "Alemán",
                    pt = "Portugués",
                    ru = "Ruso",
                    ko = "Coreano",
                    cn = "Chino"
                },
                displayAbilitiesMechanicLabel = "Mostrar mecánica de habilidades",
                hotkeyModeLabel = "Seleccionar modo de tecla rápida (al mantener, algunas teclas pueden no funcionar como se espera):",
                hotkeyModes = {
                    toggle = "Alternar",
                    hold = "Mantener"
                },
                hotkeyButtonLabel = "Registrar tecla rápida para la descripción de habilidades de alternancia (Clic derecho para desvincular)",
                hotkeyButtonInstructionText = "Pulsa el botón..",
                hotkeyButtonNotBoundText = "No obligado",
                abilityFieldsOptionsTitle = "Campos de habilidades y su ubicación",
                abilityFieldsDisplayModes = {
                    title = "Después del nombre de la habilidad",
                    separate = "En una línea separada"
                },
                displayAbilitiesMechanicLabel = "Mostrar mecánica de la habilidad",
                displayAbilitiesMechanicDisplayModeLabel = "Dónde mostrar la mecánica de la habilidad",
                displayAbilitiesRangeLabel = "Mostrar rango de la habilidad",
                displayAbilitiesRangeDisplayModeLabel = "Dónde mostrar el rango de la habilidad",
                displayAbilitiesCastTimeLabel = "Mostrar tiempo de lanzamiento de la habilidad",
                displayAbilitiesCastTimeDisplayModeLabel = "Dónde mostrar el tiempo de lanzamiento de la habilidad",
                displayAbilitiesCooldownLabel = "Mostrar enfriamiento de habilidad",
                displayAbilitiesCooldownDisplayModeLabel = "Dónde mostrar el enfriamiento de la habilidad",
                displayAbilitiesDispelTypeLabel = "Mostrar tipo de disipación de la habilidad",
                displayAbilitiesDispelTypeDisplayModeLabel = "Dónde mostrar el tipo de disipación de la habilidad",
                hideOptionsTitle = "Ocultar habilidades",
                hideOptionsHotkeyModeLabel = "Registrar tecla rápida para ocultar habilidades (Clic derecho para desvincular)",
                hideAbilitiesInInstanceLabel = "Ocultar habilidades en instancias (PVP y PVE)",
                displayLocationTitle = "Ubicación de visualización",
                displayLocationLabel = "Dónde mostrar habilidades:",
                displayLocations = {
                    tooltip = "Solo tooltip",
                    target_frame = "Solo marco de objetivo",
                    both = "Ambos"
                },
                displayPriorityIndicatorsLabel = "Mostrar indicadores de peligro (habilidades con colores)",
                delayedTooltipLoadingLabel = "Intentar cargar datos de habilidades al final del tooltip (requiere recarga)",
            },
            game = {
                hotkeyExplanatoryTextOne = "Presione",
                hotkeyExplanatoryTextTwo = "para más detalles",
                hotkeyNotBoundText = "Tecla de acceso rápido no vinculado",
                mechanicText = "Mecánica",
                rangeText = "Alcance",
                castTimeText = "Tiempo de lanzamiento",
                cooldownText = "Enfriamiento",
                dispelTypeText = "Tipo de disipación",
            }
        }

        _G["NpcAbilitiesTranslations"]["de"] = {
            options = {
                generalOptionsTitle = "Allgemeine Optionen",
                languageDropdownLabel = "Sprache auswählen:",
                languages = {
                    en = "Englisch",
                    es = "Spanisch",
                    fr = "Französisch",
                    de = "Deutsch",
                    pt = "Portugiesisch",
                    ru = "Russisch",
                    ko = "Koreanisch",
                    cn = "Chinesisch"
                },
                displayAbilitiesMechanicLabel = "Fähigkeitsmechanik anzeigen",
                hotkeyModeLabel = "Hotkey-Modus auswählen (bei Halten funktionieren einige Tasten möglicherweise nicht wie erwartet):",
                hotkeyModes = {
                    toggle = "Umschalten",
                    hold = "Halten"
                },
                hotkeyButtonLabel = "Hotkey für Umschaltfähigkeitenbeschreibung registrieren (Rechtsklick zum Aufheben der Bindung)",
                hotkeyButtonInstructionText = "Taste drücken..",
                hotkeyButtonNotBoundText = "Nicht gebunden",
                abilityFieldsOptionsTitle = "Anzeigeoptionen für Fähigkeitsfelder und deren Position",
                abilityFieldsDisplayModes = {
                    title = "Nach dem Fähigkeitsnamen",
                    separate = "In einer separaten Zeile"
                },
                displayAbilitiesMechanicLabel = "Fähigkeitsmechanik anzeigen",
                displayAbilitiesMechanicDisplayModeLabel = "Position der Anzeige der Fähigkeitsmechanik",
                displayAbilitiesRangeLabel = "Fähigkeitsreichweite anzeigen",
                displayAbilitiesRangeDisplayModeLabel = "Position der Anzeige der Fähigkeitsreichweite",
                displayAbilitiesCastTimeLabel = "Zauberzeit der Fähigkeit anzeigen",
                displayAbilitiesCastTimeDisplayModeLabel = "Position der Anzeige der Zauberzeit",
                displayAbilitiesCooldownLabel = "Fähigkeitsabklingzeit anzeigen",
                displayAbilitiesCooldownDisplayModeLabel = "Wo die Abklingzeit der Fähigkeit angezeigt wird",
                displayAbilitiesDispelTypeLabel = "Art der Bannung anzeigen",
                displayAbilitiesDispelTypeDisplayModeLabel = "Position der Anzeige der Bannungsart",
                hideOptionsTitle = "Fähigkeiten ausblenden",
                hideOptionsHotkeyModeLabel = "Hotkey zum Ausblenden von Fähigkeiten registrieren (Rechtsklick zum Aufheben der Bindung)",
                hideAbilitiesInInstanceLabel = "Fähigkeiten in Instanzen ausblenden (PVP und PVE)",
                displayLocationTitle = "Anzeigeort",
                displayLocationLabel = "Wo Fähigkeiten anzeigen:",
                displayLocations = {
                    tooltip = "Nur Tooltip",
                    target_frame = "Nur Zielrahmen",
                    both = "Beides"
                },
                displayPriorityIndicatorsLabel = "Gefahrenindikatoren anzeigen (farbcodierte Fähigkeiten)",
                delayedTooltipLoadingLabel = "Versuchen, Fähigkeitsdaten zuletzt im Tooltip zu laden (erfordert Neuladen)",
            },
            game = {
                hotkeyExplanatoryTextOne = "Drücken Sie",
                hotkeyExplanatoryTextTwo = "für Details",
                hotkeyNotBoundText = "Hotkey nicht gebunden",
                mechanicText = "Mechanik",
                rangeText = "Reichweite",
                castTimeText = "Zauberzeit",
                cooldownText = "Abklingzeit",
                dispelTypeText = "Bannart",
            }
        }

        _G["NpcAbilitiesTranslations"]["fr"] = {
            options = {
                generalOptionsTitle = "Options générales",
                languageDropdownLabel = "Sélectionner la langue :",
                languages = {
                    en = "Anglais",
                    es = "Espagnol",
                    fr = "Français",
                    de = "Allemand",
                    pt = "Portugais",
                    ru = "Russe",
                    ko = "Coréen",
                    cn = "Chinois"
                },
                displayAbilitiesMechanicLabel = "Afficher la mécanique des capacités",
                hotkeyModeLabel = "Sélectionner le mode de raccourci (en maintenant, certaines touches peuvent ne pas fonctionner comme prévu) :",
                hotkeyModes = {
                    toggle = "Basculer",
                    hold = "Maintenir"
                },
                hotkeyButtonLabel = "Enregistrer le raccourci pour la description des capacités à bascule (clic droit pour dissocier)",
                hotkeyButtonInstructionText = "Appuyez sur le bouton..",
                hotkeyButtonNotBoundText = "Non lié",
                abilityFieldsOptionsTitle = "Options d'affichage des champs de compétence et leur emplacement",
                abilityFieldsDisplayModes = {
                    title = "Après le nom de la compétence",
                    separate = "Sur une ligne séparée"
                },
                displayAbilitiesMechanicLabel = "Afficher la mécanique de la compétence",
                displayAbilitiesMechanicDisplayModeLabel = "Où afficher la mécanique de la compétence",
                displayAbilitiesRangeLabel = "Afficher la portée de la compétence",
                displayAbilitiesRangeDisplayModeLabel = "Où afficher la portée de la compétence",
                displayAbilitiesCastTimeLabel = "Afficher le temps d'incantation de la compétence",
                displayAbilitiesCastTimeDisplayModeLabel = "Où afficher le temps d'incantation",
                displayAbilitiesCooldownLabel = "Afficher le temps de recharge des compétences",
                displayAbilitiesCooldownDisplayModeLabel = "Où afficher le temps de recharge des compétences",
                displayAbilitiesDispelTypeLabel = "Afficher le type de dissipation de la compétence",
                displayAbilitiesDispelTypeDisplayModeLabel = "Où afficher le type de dissipation",
                hideOptionsTitle = "Masquer les capacités",
                hideOptionsHotkeyModeLabel = "Enregistrer le raccourci pour masquer les capacités (clic droit pour dissocier)",
                hideAbilitiesInInstanceLabel = "Masquer les capacités en instance (PVP et PVE)",
                displayLocationTitle = "Emplacement d'affichage",
                displayLocationLabel = "Où afficher les capacités:",
                displayLocations = {
                    tooltip = "Infobulle uniquement",
                    target_frame = "Cadre de cible uniquement",
                    both = "Les deux"
                },
                displayPriorityIndicatorsLabel = "Afficher les indicateurs de danger (capacités colorées)",
                delayedTooltipLoadingLabel = "Tenter de charger les données des capacités en dernier dans l'infobulle (nécessite un rechargement)",
            },
            game = {
                hotkeyExplanatoryTextOne = "Appuyez sur",
                hotkeyExplanatoryTextTwo = "pour plus de détails",
                hotkeyNotBoundText = "Raccourci clavier non lié",
                mechanicText = "Mécanique",
                rangeText = "Portée",
                castTimeText = "Temps d'incantation",
                cooldownText = "Temps de recharge",
                dispelTypeText = "Type de dissipation",
            }
        }

        _G["NpcAbilitiesTranslations"]["pt"] = {
            options = {
                generalOptionsTitle = "Opções gerais",
                languageDropdownLabel = "Selecionar idioma:",
                languages = {
                    en = "Inglês",
                    es = "Espanhol",
                    fr = "Francês",
                    de = "Alemão",
                    pt = "Português",
                    ru = "Russo",
                    ko = "Coreano",
                    cn = "Chinês"
                },
                displayAbilitiesMechanicLabel = "Exibir mecânica das habilidades",
                hotkeyModeLabel = "Selecionar modo de atalho (ao segurar, algumas teclas podem não funcionar como esperado):",
                hotkeyModes = {
                    toggle = "Alternar",
                    hold = "Segurar"
                },
                hotkeyButtonLabel = "Registrar atalho para descrição das habilidades de alternância (Clique com o botão direito para desvincular)",
                hotkeyButtonInstructionText = "Pressione o botão ..",
                hotkeyButtonNotBoundText = "Não vinculado",
                abilityFieldsOptionsTitle = "Opções de exibição dos campos de habilidade e seu local",
                abilityFieldsDisplayModes = {
                    title = "Após o nome da habilidade",
                    separate = "Em uma linha separada"
                },
                displayAbilitiesMechanicLabel = "Exibir mecânica da habilidade",
                displayAbilitiesMechanicDisplayModeLabel = "Onde exibir a mecânica da habilidade",
                displayAbilitiesRangeLabel = "Exibir alcance da habilidade",
                displayAbilitiesRangeDisplayModeLabel = "Onde exibir o alcance da habilidade",
                displayAbilitiesCastTimeLabel = "Exibir tempo de conjuração da habilidade",
                displayAbilitiesCastTimeDisplayModeLabel = "Onde exibir o tempo de conjuração",
                displayAbilitiesCooldownLabel = "Exibir recarga da habilidade",
                displayAbilitiesCooldownDisplayModeLabel = "Onde exibir a recarga da habilidade",
                displayAbilitiesDispelTypeLabel = "Exibir tipo de dissipação da habilidade",
                displayAbilitiesDispelTypeDisplayModeLabel = "Onde exibir o tipo de dissipação",
                hideOptionsTitle = "Ocultar habilidades",
                hideOptionsHotkeyModeLabel = "Registrar atalho para ocultar habilidades (Clique com o botão direito para desvincular)",
                hideAbilitiesInInstanceLabel = "Ocultar habilidades em instâncias (PVP e PVE)",
                displayLocationTitle = "Local de exibição",
                displayLocationLabel = "Onde exibir habilidades:",
                displayLocations = {
                    tooltip = "Apenas tooltip",
                    target_frame = "Apenas quadro de alvo",
                    both = "Ambos"
                },
                displayPriorityIndicatorsLabel = "Mostrar indicadores de perigo (habilidades com cores)",
                delayedTooltipLoadingLabel = "Tentar carregar dados de habilidades por último no tooltip (requer recarregamento)",
            },
            game = {
                hotkeyExplanatoryTextOne = "Prima",
                hotkeyExplanatoryTextTwo = "para detalhes",
                hotkeyNotBoundText = "Tecla de atalho não ligada",
                mechanicText = "Mecânica",
                rangeText = "Alcance",
                castTimeText = "Tempo de lançamento",
                cooldownText = "Recarga",
                dispelTypeText = "Tipo de dissipação",
            }
        }

        _G["NpcAbilitiesTranslations"]["ru"] = {
            options = {
                generalOptionsTitle = "Общие настройки",
                languageDropdownLabel = "Выберите язык:",
                languages = {
                    en = "Английский",
                    es = "Испанский",
                    fr = "Французский",
                    de = "Немецкий",
                    pt = "Португальский",
                    ru = "Русский",
                    ko = "Корейский",
                    cn = "Китайский"
                },
                displayAbilitiesMechanicLabel = "Показывать механику способностей",
                hotkeyModeLabel = "Выберите режим горячих клавиш (при удержании некоторые клавиши могут работать некорректно):",
                hotkeyModes = {
                    toggle = "Переключение",
                    hold = "Удерживание"
                },
                hotkeyButtonLabel = "Назначить горячую клавишу для переключения описания способностей (Правый клик для сброса)",
                hotkeyButtonInstructionText = "Нажмите кнопку...",
                hotkeyButtonNotBoundText = "Не связан",
                abilityFieldsOptionsTitle = "Настройки отображения полей умений и их расположение",
                abilityFieldsDisplayModes = {
                    title = "После названия умения",
                    separate = "На отдельной строке"
                },
                displayAbilitiesMechanicLabel = "Показать механику умения",
                displayAbilitiesMechanicDisplayModeLabel = "Где отображать механику умения",
                displayAbilitiesRangeLabel = "Показать радиус действия умения",
                displayAbilitiesRangeDisplayModeLabel = "Где отображать радиус действия умения",
                displayAbilitiesCastTimeLabel = "Показать время применения умения",
                displayAbilitiesCastTimeDisplayModeLabel = "Где отображать время применения",
                displayAbilitiesCooldownLabel = "Показывать время восстановления способности",
                displayAbilitiesCooldownDisplayModeLabel = "Где отображать время восстановления способности",
                displayAbilitiesDispelTypeLabel = "Показать тип рассеивания умения",
                displayAbilitiesDispelTypeDisplayModeLabel = "Где отображать тип рассеивания",
                hideOptionsTitle = "Скрытие способностей",
                hideOptionsHotkeyModeLabel = "Назначить горячую клавишу для скрытия способностей (Правый клик для сброса)",
                hideAbilitiesInInstanceLabel = "Скрывать способности в подземельях (PVP и PVE)",
                displayLocationTitle = "Место отображения",
                displayLocationLabel = "Где отображать способности:",
                displayLocations = {
                    tooltip = "Только подсказка",
                    target_frame = "Только рамка цели",
                    both = "Оба"
                },
                displayPriorityIndicatorsLabel = "Показать индикаторы опасности (цветные способности)",
                delayedTooltipLoadingLabel = "Попытаться загрузить данные о способностях последними в подсказке (требует перезагрузки)",
            },
            game = {
                hotkeyExplanatoryTextOne = "Нажмите",
                hotkeyExplanatoryTextTwo = "чтобы узнать подробности",
                hotkeyNotBoundText = "Горячая клавиша не привязана",
                mechanicText = "Механика",
                rangeText = "Дальность",
                castTimeText = "Время произнесения",
                cooldownText = "Восстановление",
                dispelTypeText = "Тип рассеивания",
            }
        }

        _G["NpcAbilitiesTranslations"]["ko"] = {
            options = {
                generalOptionsTitle = "일반 옵션",
                languageDropdownLabel = "언어 선택:",
                languages = {
                    en = "영어",
                    es = "스페인어",
                    fr = "프랑스어",
                    de = "독일어",
                    pt = "포르투갈어",
                    ru = "러시아어",
                    ko = "한국어",
                    cn = "중국어"
                },
                displayAbilitiesMechanicLabel = "능력 메커니즘 표시",
                hotkeyModeLabel = "단축키 모드 선택 (누르고 있을 때 일부 키가 예상대로 작동하지 않을 수 있음):",
                hotkeyModes = {
                    toggle = "전환",
                    hold = "누르기"
                },
                hotkeyButtonLabel = "전환 능력 설명 단축키 등록 (우클릭으로 해제)",
                hotkeyButtonInstructionText = "버튼을 누르세요..",
                hotkeyButtonNotBoundText = "구속되지 않음",
                abilityFieldsOptionsTitle = "능력치 필드 표시 및 위치 설정",
                abilityFieldsDisplayModes = {
                    title = "능력 이름 뒤에 표시",
                    separate = "별도의 줄에 표시"
                },
                displayAbilitiesMechanicLabel = "능력 메커니즘 표시",
                displayAbilitiesMechanicDisplayModeLabel = "능력 메커니즘 표시 위치",
                displayAbilitiesRangeLabel = "능력 범위 표시",
                displayAbilitiesRangeDisplayModeLabel = "능력 범위 표시 위치",
                displayAbilitiesCastTimeLabel = "능력 시전 시간 표시",
                displayAbilitiesCastTimeDisplayModeLabel = "능력 시전 시간 표시 위치",
                displayAbilitiesCooldownLabel = "스킬 쿨타임 표시",
                displayAbilitiesCooldownDisplayModeLabel = "스킬 쿨타임을 표시할 위치",
                displayAbilitiesDispelTypeLabel = "능력 해제 타입 표시",
                displayAbilitiesDispelTypeDisplayModeLabel = "능력 해제 타입 표시 위치",
                hideOptionsTitle = "능력 숨기기",
                hideOptionsHotkeyModeLabel = "능력 숨기기 단축키 등록 (우클릭으로 해제)",
                hideAbilitiesInInstanceLabel = "인스턴스( PVP 및 PVE)에서 능력 숨기기",
                displayLocationTitle = "표시 위치",
                displayLocationLabel = "능력을 표시할 위치:",
                displayLocations = {
                    tooltip = "툴팁만",
                    target_frame = "대상 프레임만",
                    both = "둘 다"
                },
                displayPriorityIndicatorsLabel = "위험 지표 표시 (색상으로 구분된 능력)",
                delayedTooltipLoadingLabel = "툴팁에서 능력 데이터를 마지막으로 로드 시도 (다시 로드 필요)",
            },
            game = {
                hotkeyExplanatoryTextOne = "자세한 내용을 보려면",
                hotkeyExplanatoryTextTwo = "를 누르세요.",
                hotkeyNotBoundText = "단축키가 바인딩되지 않았습니다.",
                mechanicText = "메커니즘",
                rangeText = "범위",
                castTimeText = "시전 시간",
                cooldownText = "쿨타임",
                dispelTypeText = "해제 유형",
            }
        }

        _G["NpcAbilitiesTranslations"]["cn"] = {
            options = {
                generalOptionsTitle = "通用选项",
                languageDropdownLabel = "选择语言：",
                languages = {
                    en = "英语",
                    es = "西班牙语",
                    fr = "法语",
                    de = "德语",
                    pt = "葡萄牙语",
                    ru = "俄语",
                    ko = "韩语",
                    cn = "中文"
                },
                displayAbilitiesMechanicLabel = "显示技能机制",
                hotkeyModeLabel = "选择快捷键模式（按住时，某些按键可能无法正常工作）：",
                hotkeyModes = {
                    toggle = "切换",
                    hold = "按住"
                },
                hotkeyButtonLabel = "注册切换技能描述快捷键（右键单击解绑",
                hotkeyButtonInstructionText = "按按钮..",
                hotkeyButtonNotBoundText = "未绑定",
                abilityFieldsOptionsTitle = "技能字段显示与位置设置",
                abilityFieldsDisplayModes = {
                    title = "在技能名称后显示",
                    separate = "单独一行显示"
                },
                displayAbilitiesMechanicLabel = "显示技能机制",
                displayAbilitiesMechanicDisplayModeLabel = "技能机制显示位置",
                displayAbilitiesRangeLabel = "显示技能范围",
                displayAbilitiesRangeDisplayModeLabel = "技能范围显示位置",
                displayAbilitiesCastTimeLabel = "显示技能施法时间",
                displayAbilitiesCastTimeDisplayModeLabel = "技能施法时间显示位置",
                displayAbilitiesCooldownLabel = "显示技能冷却时间",
                displayAbilitiesCooldownDisplayModeLabel = "显示技能冷却时间的位置",
                displayAbilitiesDispelTypeLabel = "显示技能驱散类型",
                displayAbilitiesDispelTypeDisplayModeLabel = "技能驱散类型显示位置",
                hideOptionsTitle = "隐藏技能",
                hideOptionsHotkeyModeLabel = "注册隐藏技能快捷键（右键单击解绑）",
                hideAbilitiesInInstanceLabel = "在副本（PVP 和 PVE）中隐藏技能",
                displayLocationTitle = "显示位置",
                displayLocationLabel = "在哪里显示技能:",
                displayLocations = {
                    tooltip = "仅提示框",
                    target_frame = "仅目标框架",
                    both = "两者都"
                },
                displayPriorityIndicatorsLabel = "显示危险指示器（彩色技能）",
                delayedTooltipLoadingLabel = "尝试在工具提示中最后加载技能数据（需要重新加载）",
            },
            game = {
                hotkeyExplanatoryTextOne = "按",
                hotkeyExplanatoryTextTwo = "了解详细信息",
                hotkeyNotBoundText = "热键未绑定",
                mechanicText = "机制",
                rangeText = "范围",
                castTimeText = "施法时间",
                cooldownText = "冷却时间",
                dispelTypeText = "驱散类型",
            }
        }
    end
end


translationsFrame:RegisterEvent("ADDON_LOADED")
translationsFrame:SetScript("OnEvent", addonLoaded)
