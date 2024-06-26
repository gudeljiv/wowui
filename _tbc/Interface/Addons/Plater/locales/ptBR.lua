local L = LibStub("AceLocale-3.0"):NewLocale("PlaterNameplates", "ptBR") 
if not L then return end 

L["OPTIONS_ALPHA"] = "Alpha"
L["OPTIONS_ANCHOR"] = "Fixar"
L["OPTIONS_ANCHOR_BOTTOM"] = "Inferior"
L["OPTIONS_ANCHOR_BOTTOMLEFT"] = "Inferior Esquerdo"
L["OPTIONS_ANCHOR_BOTTOMRIGHT"] = "Inferior Direito"
L["OPTIONS_ANCHOR_CENTER"] = "Centro"
L["OPTIONS_ANCHOR_INNERBOTTOM"] = "Interno Inferior"
L["OPTIONS_ANCHOR_INNERLEFT"] = "Interno Esquerdo"
L["OPTIONS_ANCHOR_INNERRIGHT"] = "Interno Direita"
L["OPTIONS_ANCHOR_INNERTOP"] = "Interno Superior"
L["OPTIONS_ANCHOR_LEFT"] = "Esquerda"
L["OPTIONS_ANCHOR_RIGHT"] = "Direita"
L["OPTIONS_ANCHOR_TOP"] = "Superior"
L["OPTIONS_ANCHOR_TOPLEFT"] = "Superior Esquerdo"
L["OPTIONS_ANCHOR_TOPRIGHT"] = "Superior Direito"
L["OPTIONS_CANCEL"] = "Cancelar"
L["OPTIONS_COLOR"] = "Cores"
L["OPTIONS_ENABLED"] = "Habilitar"
L["OPTIONS_ERROR_CVARMODIFY"] = "cvars não podem ser alterados durante o combate."
L["OPTIONS_ERROR_EXPORTSTRINGERROR"] = "Falha ao exportar"
L["OPTIONS_FONT"] = "Fonte"
L["OPTIONS_FRIENDLY"] = "Amigável"
L["OPTIONS_GENERALSETTINGS_HEALTHBAR_ANCHOR_TITLE"] = "Aparência da Barra de Vida"
L["OPTIONS_GENERALSETTINGS_HEALTHBAR_BGCOLOR"] = "Barra de Vida: cor de fundo e Alpha"
L["OPTIONS_GENERALSETTINGS_HEALTHBAR_BGTEXTURE"] = "Barra de Vida: Textura de Fundo"
L["OPTIONS_GENERALSETTINGS_HEALTHBAR_TEXTURE"] = "Barra de Vida: Textura"
L["OPTIONS_GENERALSETTINGS_TRANSPARENCY_ANCHOR_TITLE"] = "Transparência é Usada Para"
L["OPTIONS_GENERALSETTINGS_TRANSPARENCY_RANGECHECK"] = "Verificação de Alcance"
L["OPTIONS_GENERALSETTINGS_TRANSPARENCY_RANGECHECK_ALPHA"] = "Alpha"
L["OPTIONS_GENERALSETTINGS_TRANSPARENCY_RANGECHECK_SPEC_DESC"] = "Feitiço para verificação de alcance nesta especialização."
L["OPTIONS_HOSTILE"] = "Hostil"
L["OPTIONS_NEUTRAL"] = "Neutro"
L["OPTIONS_OKAY"] = "OK"
L["OPTIONS_OUTLINE"] = "Rascunho"
L["OPTIONS_PLEASEWAIT"] = "Isso pode levar alguns segundos"
L["OPTIONS_PROFILE_CONFIG_EXPORTINGTASK"] = "Plater está exportando o perfil atual"
L["OPTIONS_PROFILE_CONFIG_EXPORTPROFILE"] = "Exportar Perfil"
L["OPTIONS_PROFILE_CONFIG_IMPORTPROFILE"] = "Importar Perfil"
L["OPTIONS_PROFILE_CONFIG_MOREPROFILES"] = "Obtenha mais perfis no Wago.io"
L["OPTIONS_PROFILE_CONFIG_OPENSETTINGS"] = "Abrir configurações de perfil"
L["OPTIONS_PROFILE_CONFIG_PROFILENAME"] = "Novo nome do perfil"
L["OPTIONS_PROFILE_CONFIG_PROFILENAME_DESC"] = "Um novo perfil é criado com a String importada.  Inserir o nome de um perfil que já existe o substituirá."
L["OPTIONS_PROFILE_ERROR_PROFILENAME"] = "Nome de perfil inválido"
L["OPTIONS_PROFILE_ERROR_STRINGINVALID"] = "Arquivo de perfil inválido."
L["OPTIONS_PROFILE_ERROR_WRONGTAB"] = "Arquivo de perfil inválido. Importe scripts ou mods na guia de scripts/mods."
L["OPTIONS_PROFILE_IMPORT_OVERWRITE"] = "O perfil '%s' já existe, Deseja substituir?"
L["OPTIONS_SETTINGS_COPIED"] = "configurações copiadas."
L["OPTIONS_SETTINGS_FAIL_COPIED"] = "falha ao obter as configurações da guia selecionada."
L["OPTIONS_SHADOWCOLOR"] = "Cor da Sombra"
L["OPTIONS_SIZE"] = "Tamanho."
L["OPTIONS_STATUSBAR_TEXT"] = "Agora você pode importar perfis, mods, scripts, animações e tabelas de cores de |cFFFFAA00http://wago.io|r"
L["OPTIONS_TABNAME_ADVANCED"] = "Avançado."
L["OPTIONS_TABNAME_ANIMATIONS"] = "Feedback de feitiço"
L["OPTIONS_TABNAME_AUTO"] = "Auto"
L["OPTIONS_TABNAME_BUFF_LIST"] = "Lista de Buff"
L["OPTIONS_TABNAME_BUFF_SETTINGS"] = "Buff Config"
L["OPTIONS_TABNAME_BUFF_SPECIAL"] = "Buff Especiais"
L["OPTIONS_TABNAME_BUFF_TRACKING"] = "Rastreamento de Buff"
L["OPTIONS_TABNAME_CASTBAR"] = "Barra de Lançamento"
--[[Translation missing --]]
L["OPTIONS_TABNAME_CASTCOLORS"] = "\"Cast Colors and Names\""
L["OPTIONS_TABNAME_COMBOPOINTS"] = "Pontos de Combo"
L["OPTIONS_TABNAME_GENERALSETTINGS"] = "Config Gerais"
L["OPTIONS_TABNAME_MODDING"] = "Modulos"
L["OPTIONS_TABNAME_NPC_COLORNAME"] = "Nomes e Cores de NPCs"
L["OPTIONS_TABNAME_NPCENEMY"] = "NPC Inimigo"
L["OPTIONS_TABNAME_NPCFRIENDLY"] = "NPC Amigo"
L["OPTIONS_TABNAME_PERSONAL"] = "Barra pessoal"
L["OPTIONS_TABNAME_PLAYERENEMY"] = "Jogador Inimigo"
L["OPTIONS_TABNAME_PLAYERFRIENDLY"] = "Jogador Amigo"
L["OPTIONS_TABNAME_PROFILES"] = "Perfis "
L["OPTIONS_TABNAME_SCRIPTING"] = "Scripts"
L["OPTIONS_TABNAME_SEARCH"] = "Pesquisar"
L["OPTIONS_TABNAME_STRATA"] = "Nível e estratos"
L["OPTIONS_TABNAME_TARGET"] = "Alvo"
L["OPTIONS_TABNAME_THREAT"] = "Ameaça / Aggro"
L["OPTIONS_TEXTURE"] = "Textura"
L["OPTIONS_THREAT_AGGROSTATE_ANOTHERTANK"] = "Aggro em outro Tank"
L["OPTIONS_THREAT_AGGROSTATE_HIGHTHREAT"] = "Ameaça alta"
L["OPTIONS_THREAT_AGGROSTATE_NOAGGRO"] = "Sem Aggro"
L["OPTIONS_THREAT_AGGROSTATE_NOTANK"] = "Sem Aggro nos Tanks"
L["OPTIONS_THREAT_AGGROSTATE_NOTINCOMBAT"] = "Unidade fora de combate"
L["OPTIONS_THREAT_AGGROSTATE_ONYOU_LOWAGGRO"] = "Aggro em você, mas é baixo"
L["OPTIONS_THREAT_AGGROSTATE_ONYOU_LOWAGGRO_DESC"] = "a unidade está atacando você, mas outros podem tomar o Aggro."
L["OPTIONS_THREAT_AGGROSTATE_ONYOU_SOLID"] = "Aggro em Você"
L["OPTIONS_THREAT_AGGROSTATE_TAPPED"] = "Unidade Perdida"
L["OPTIONS_THREAT_COLOR_DPS_ANCHOR_TITLE"] = "Cor ao Jogar como DPS ou HEALER"
L["OPTIONS_THREAT_COLOR_DPS_HIGHTHREAT_DESC"] = "A unidade começa a atacar você."
L["OPTIONS_THREAT_COLOR_DPS_NOAGGRO_DESC"] = "A unidade não está atacando você."
L["OPTIONS_THREAT_COLOR_DPS_NOTANK_DESC"] = "A unidade não está atacando você ou outro tank e provavelmente está atacando o Healer ou dps do seu grupo."
L["OPTIONS_THREAT_COLOR_DPS_ONYOU_SOLID_DESC"] = "A unidade está atacando você."
L["OPTIONS_THREAT_COLOR_OVERRIDE_ANCHOR_TITLE"] = "Substituir cores padrão"
L["OPTIONS_THREAT_COLOR_OVERRIDE_DESC"] = "Modifique as cores padrão definidas pelo jogo para unidades neutras, hostis e amigáveis. Durante o combate, essas cores serão substituídas também se as cores de ameaça puderem mudar a cor da barra de saúde."
L["OPTIONS_THREAT_COLOR_TANK_ANCHOR_TITLE"] = "Cor ao Jogar como TANK"
L["OPTIONS_THREAT_COLOR_TANK_ANOTHERTANK_DESC"] = "A unidade está com outro tank do seu grupo."
L["OPTIONS_THREAT_COLOR_TANK_NOAGGRO_DESC"] = "A unidade não tem Aggro em você"
L["OPTIONS_THREAT_COLOR_TANK_NOTINCOMBAT_DESC"] = "A unidade não está em combate."
L["OPTIONS_THREAT_COLOR_TANK_ONYOU_SOLID_DESC"] = "A unidade está atacando você e você tem um aggro sólido."
L["OPTIONS_THREAT_COLOR_TAPPED_DESC"] = "Quando alguém reivindicou a unidade (quando você não recebe experiência ou pilhagem por matá-la)."
L["OPTIONS_THREAT_DPS_CANCHECKNOTANK"] = "Marque para Unidade sem Aggro no Tank"
L["OPTIONS_THREAT_DPS_CANCHECKNOTANK_DESC"] = "Quando você não tem aggro como curandeiro ou dps, verifique se o inimigo está atacando outra unidade que não é um tank."
L["OPTIONS_THREAT_MODIFIERS_ANCHOR_TITLE"] = "Modificação de ameaças"
L["OPTIONS_THREAT_MODIFIERS_BORDERCOLOR"] = "Cor de Borda"
L["OPTIONS_THREAT_MODIFIERS_HEALTHBARCOLOR"] = "Cor da Barra de Saúde"
L["OPTIONS_THREAT_MODIFIERS_NAMECOLOR"] = "Cor do Nome"
L["OPTIONS_XOFFSET"] = "Deslocamento X"
L["OPTIONS_YOFFSET"] = "Deslocamento Y"

