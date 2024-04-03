local L = LibStub("AceLocale-3.0"):NewLocale("NovaInstanceTracker", "ptBR");
if (not L) then
	return;
end

L["noTimer"] = "Sem temporizador"; --No timer
L["noCurrentTimer"] = "Sem temporizador atual"; --No current timer
L["noActiveTimers"] = "Sem temporizadores ativos";	--No active timers
L["second"] = "segundo"; --Second (singular).
L["seconds"] = "segundos"; --Seconds (plural).
L["minute"] = "minuto"; --Minute (singular).
L["minutes"] = "minutos"; --Minutes (plural).
L["hour"] = "hora"; --Hour (singular).
L["hours"] = "horas"; --Hours (plural).
L["day"] = "dia"; --Day (singular).
L["days"] = "dias"; --Days (plural).
L["secondMedium"] = "seg"; --Second (singular).
L["secondsMedium"] = "segs"; --Seconds (plural).
L["minuteMedium"] = "min"; --Minute (singular).
L["minutesMedium"] = "mins"; --Minutes (plural).
L["hourMedium"] = "hora"; --Hour (singular).
L["hoursMedium"] = "horas"; --Hours (plural).
L["dayMedium"] = "dia"; --Day (singular).
L["daysMedium"] = "dias"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "d"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Começa em %s"; --"Starts in 1hour".
L["endsIn"] = "Termina em %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova Instance Tracker está desatualizado, por favor atualize em https://www.curseforge.com/wow/addons/nova-instance-tracker";
L["Options"] = "Opções";
L["Reset Data"] = "Redefinir dados"; --A button to Reset data.

L["Error"] = "Erro";
L["delete"] = "Excluir";
L["confirmInstanceDeletion"] = "Confirmar exclusão da instância";
L["confirmCharacterDeletion"] = "Confirmar exclusão do personagem";

-------------
---Config---
-------------
--There are 2 types of strings here, the names end in Title or Desc L["exampleTitle"] and L["exampleDesc"].
--Title must not be any longer than 21 characters (maybe less for chinese characters because they are larger).
--Desc can be any length.

---General Options---
L["generalHeaderDesc"] = "Opções gerais";

L["chatColorTitle"] = "Cor da mensagem do bate-papo";
L["chatColorDesc"] = "Qual cor as mensagens no bate-papo devem ter?";

L["resetColorsTitle"] = "Redefinir cores";
L["resetColorsDesc"] = "Redefine as cores para as padrão.";

L["timeStampFormatTitle"] = "Formato do carimbo de tempo";
L["timeStampFormatDesc"] = "Define qual formato de carimbo de tempo usar, 12 horas (1:23pm) ou 24 horas (13:23).";

L["timeStampZoneTitle"] = "Horário local / Hora do reino";
L["timeStampZoneDesc"] = "Usa a Horário local ou a hora do reino para os carimbos de tempo?";

L["minimapButtonTitle"] = "Botão do minimapa";
L["minimapButtonDesc"] = "Mostra o botão do NIT no minimapa?";

---Sounds---
L["soundsHeaderDesc"] = "Sons";

L["soundsTextDesc"] = "Defina o som na opção 'Nenhum' para desativá-lo.";

L["disableAllSoundsTitle"] = "Desativar todos os sons";
L["disableAllSoundsDesc"] = "Desativa todos os sons deste addon.";

L["extraSoundOptionsTitle"] = "Opções de som adicionais";
L["extraSoundOptionsDesc"] = "Ative isso para mostrar todos os sons de todos os seus addons de uma vez nas listas suspensas aqui.";

L["notesHeaderDesc"] = "Algumas notas:";
L["notesDesc"] = "Este addon faz o possível para determinar quando você pode entrar em mais instâncias, mas o sistema de bloqueio da Blizzard às vezes tem falhas e você pode ser bloqueado antes de atingir o limite correto. Às vezes, você só pode entrar em 4 por hora, mas outras vezes, pode entrar em 6 por hora.";

L["logHeaderDesc"] = "Janela de registro";

L["openInstanceLogFrameTitle"] = "Registro de instâncias";

L["logSizeTitle"] = "Quantas instâncias são mostradas no registro?";
L["logSizeDesc"] = "Quantas instâncias você deseja que sejam mostradas no registro? Um máximo de 300 é armazenado, 100 são exibidos por padrão (você pode abrir o registro digitando /NIT).";

L["enteredMsgTitle"] = "Mensagem de entrada";
L["enteredMsgDesc"] = "Isso imprimirá uma mensagem na sua janela principal de bate-papo quando você entrar em uma instância com um ícone X para excluir a nova instância do banco de dados, se desejar.";

L["instanceResetMsgTitle"] = "Reiniciar no grupo";
L["instanceResetMsgDesc"] = "Isso mostrará uma mensagem para o seu grupo ou raide indicando quais instâncias foram reiniciadas com sucesso, se você for o líder do grupo. Por exemplo: 'Caverna Ululante reiniciada.'";

L["raidEnteredMsgTitle"] = "Entrada no raide";
L["raidEnteredMsgDesc"] = "Isso imprimirá uma mensagem na sua janela de bate-papo principal quando você entrar em um raide com um ícone X para excluir a nova instância do banco de dados, se desejar.";

L["pvpEnteredMsgTitle"] = "Entrada no JxJ";
L["pvpEnteredMsgDesc"] = "Isso imprimirá uma mensagem na sua janela de bate-papo principal quando você entrar em uma instância JxJ com um ícone X para excluir a nova instância do banco de dados, se desejar.";

L["noRaidInstanceMergeMsgTitle"] = "Ocultar mescla de instância";
L["noRaidInstanceMergeMsgDesc"] = "Oculta a mensagem de mescla de instâncias quando você entra em um raide e detecta o mesmo ID.";

L["showMoneyTradedChatTitle"] = "Ouro negociado";
L["showMoneyTradedChatDesc"] = "Mostra no bate-papo quando você der ou receber ouro de alguém? (Ajuda a manter o controle de quem você pagou ou de quem recebeu ouro em grupos).";

L["instanceStatsHeaderDesc"] = "Saída de estatísticas no final da masmorra";

L["instanceStatsTextDesc"] = "Selecione aqui quais estatísticas mostrar no bate-papo do grupo ou na sua janela de bate-papo ao sair de uma masmorra.";

L["instanceStatsOutputTitle"] = "Estatísticas";
L["instanceStatsOutputDesc"] = "Mostra estatísticas sobre a masmorra ao sair?";

L["instanceStatsOutputWhereTitle"] = "Onde mostrar estatísticas";
L["instanceStatsOutputWhereDesc"] = "Onde você deseja que as estatísticas sejam mostradas, na janela de bate-papo para você mesmo ou no bate-papo do grupo?";

L["instanceStatsOutputMobCountTitle"] = "Quantidade";
L["instanceStatsOutputMobCountDesc"] = "Mostra quantos inimigos foram mortos dentro da masmorra?";

L["instanceStatsOutputXPTitle"] = "Experiência";
L["instanceStatsOutputXPDesc"] = "Mostra quanto de experiência foi obtida dentro da masmorra?";

L["instanceStatsOutputAverageXPTitle"] = "Experiência média";
L["instanceStatsOutputAverageXPDesc"] = "Mostra a experiência média por morte dentro da masmorra?";

L["instanceStatsOutputTimeTitle"] = "Tempo";
L["instanceStatsOutputTimeDesc"] = "Mostra quanto tempo você passou dentro da masmorra?";

L["instanceStatsOutputGoldTitle"] = "Ouro obtido";
L["instanceStatsOutputGoldDesc"] = "Mostra quanto ouro foi obtido dos inimigos dentro da masmorra?";

L["instanceStatsOutputAverageGroupLevelTitle"] = "Nível médio";
L["instanceStatsOutputAverageGroupLevelDesc"] = "Mostra o nível médio do grupo dentro da masmorra?";

L["showAltsLogTitle"] = "Mostrar alts";
L["showAltsLogDesc"] = "Mostra personagens alternativos no registro de instâncias?";

L["timeStringTypeTitle"] = "Tipo de formato de tempo";
L["timeStringTypeDesc"] = "Qual formato de string de tempo usar no registro de instâncias?\n|cFFFFFF00Longo:|r 1 minuto 30 segundos\n|cFFFFFF00Médio:|r 1 min 30 segs\n|cFFFFFF00Curto:|r 1m30s";

L["showLockoutTimeTitle"] = "Tempo de bloqueio";
L["showLockoutTimeDesc"] = "Isso mostrará o tempo restante de bloqueio no registro de instâncias para as instâncias nas últimas 24 horas; se desmarcado, mostrará o tempo de entrada como nas versões anteriores.";

L["colorsHeaderDesc"] = "Cores";

L["mergeColorTitle"] = "Cor da junção de instâncias";
L["mergeColorDesc"] = "De que cor deve ser a mensagem no bate-papo quando uma instância anterior e os dados são mesclados?";

L["detectSameInstanceTitle"] = "Detectar mesma instância";
L["detectSameInstanceDesc"] = "Detecta automaticamente se você entrar na mesma instância novamente para que o addon não conte como 2 instâncias separadas?";

L["showStatsInRaidTitle"] = "Estatísticas no raide";
L["showStatsInRaidDesc"] = "Mostra estatísticas quando você estiver em um raide? Desative isso para mostrar estatísticas apenas para o grupo quando você estiver em um grupo de 5 pessoas (essa opção só funciona quando o bate-papo do grupo é a saída de estatísticas).";

L["printRaidInsteadTitle"] = "Imprimir no raide";
L["printRaidInsteadDesc"] = "Se você tiver a opção de desativar o envio de estatísticas para o bate-papo do raide, isso as imprimirá na sua janela de bate-papo para que você possa vê-las.";

L["statsOnlyWhenActivityTitle"] = "Somente com atividade";
L["statsOnlyWhenActivityDesc"] = "Mostra estatísticas apenas quando alguma atividade ocorrer dentro da masmorra? Isso significa apenas se você matou alguns inimigos, obteve experiência, saqueou ouro, etc. Isso fará com que estatísticas vazias não sejam mostradas.";

L["show24HourOnlyTitle"] = "Últimas 24 horas";
L["show24HourOnlyDesc"] = "Mostra apenas instâncias das últimas 24 horas no registro de instâncias?";

L["trimDataHeaderDesc"] = "Limpeza de dados";

L["trimDataBelowLevelTitle"] = "Nível máximo a excluir";
L["trimDataBelowLevelDesc"] = "Selecione o nível máximo de personagens para excluir do banco de dados; todos os personagens deste nível e inferiores serão excluídos.";

L["trimDataBelowLevelButtonTitle"] = "Excluir personagens";
L["trimDataBelowLevelButtonDesc"] = "Clique neste botão para excluir todos os personagens com o nível selecionado e mais baixo deste banco de dados do addon.";

L["trimDataTextDesc"] = "Excluir vários personagens do banco de dados:";
L["trimDataText2Desc"] = "Excluir um personagem do banco de dados:";

L["trimDataCharInputTitle"] = "Entrada para excluir um personagem";
L["trimDataCharInputDesc"] = "Digite aqui um personagem para excluir, no formato Nome-Reino (sensível a maiúsculas e minúsculas). Nota: Isso exclui permanentemente os dados de contagem de feitiços.";

L["trimDataBelowLevelButtonConfirm"] = "Tem certeza de que deseja excluir todos os personagens abaixo do nível %s do banco de dados?";
L["trimDataCharInputConfirm"] = "Tem certeza de que deseja excluir este personagem %s do banco de dados?";

L["trimDataMsg2"] = "Excluindo todos os personagens abaixo do nível %s.";
L["trimDataMsg3"] = "Excluído: %s.";
L["trimDataMsg4"] = "Concluído, nenhum personagem encontrado.";
L["trimDataMsg5"] = "Concluído, %s personagens excluídos.";
L["trimDataMsg6"] = "Por favor, insira um nome de personagem válido para excluir do banco de dados.";
L["trimDataMsg7"] = "Este nome de personagem %s não inclui um reino, por favor insira Nome-Reino.";
L["trimDataMsg8"] = "Erro ao excluir %s do banco de dados, personagem não encontrado (o nome diferencia maiúsculas de minúsculas).";
L["trimDataMsg9"] = "Personagem %s excluído do banco de dados.";


L["instanceFrameSelectAltMsg"] = "Seleciona qual personagem alternativo mostrar se 'Mostrar alts' não estiver marcado. Ou qual personagem alternativo colorir se 'Mostrar alts' estiver marcado.";

L["enteredDungeon"] = "Nova instância %s %s, clique";
L["enteredDungeon2"] = "se esta não for uma nova instância.";
L["enteredRaid"] = "Nova instância %s, este raide não conta para o bloqueio.";
L["loggedInDungeon"] = "Você entrou em %s %s, clique";
L["loggedInDungeon2"] = "para excluir esta instância do banco de dados, se não for uma nova instância.";
L["reloadDungeon"] = "Interface recarregada detectada %s, carregando dados da última instância em vez de criar uma nova.";
L["thisHour"] = "esta hora";
L["statsError"] = "Erro ao encontrar estatísticas para a instância %s.";
L["statsMobs"] = "Inimigos:";
L["statsXP"] = "EXP:";
L["statsAverageXP"] = "EXP média por inimigo:";
L["statsRunsPerLevel"] = "instâncias por nível:";
L["statsRunsNextLevel"] = "instâncias até o próximo nível:";
L["statsTime"] = "Tempo:";
L["statsAverageGroupLevel"] = "Nível médio do grupo:";
L["statsGold"] = "Ouro";
L["sameInstance"] = "Mesma ID de instância que a última detectada %s, mesclando entradas do banco de dados.";
L["deleteInstance"] = "instância excluída [%s] %s (%s atrás) do banco de dados.";
L["deleteInstanceError"] = "Erro ao excluir %s.";
L["countString"] = "Você entrou em %s instâncias na última hora e %s nas últimas 24 horas";
L["countStringColorized"] = "Você entrou em %s %s %s instâncias na última hora e %s %s %s nas últimas 24 horas";
L["now"] = "agora";
L["in"] = "em";
L["active24"] = "Bloqueio de 24h ativo";
L["nextInstanceAvailable"] = "Próxima instância disponível";
L["gave"] = "Deu";
L["received"] = "Recebeu";
L["to"] = "para";
L["from"] = "de";
L["playersStillInside"] = "foi reiniciado (Jogadores que ainda estão dentro da instância antiga podem sair dela e entrar na nova).";
L["Gold"] = "Ouro";
L["gold"] = "ouro";
L["silver"] = "prata";
L["copper"] = "cobre";
L["newInstanceNow"] = "Uma nova instância pode ser entrada agora";
L["thisHour"] = "esta hora";
L["thisHour24"] = "estas 24 horas";
L["openInstanceFrame"] = "Registro de instâncias";
L["openYourChars"] = "Seus personagens";
L["openTradeLog"] = "Registro de negócio";
L["config"] = "Opções";
L["thisChar"] = "Este personagem";
L["yourChars"] = "Personagens";
L["instancesPastHour"] = "instâncias na última hora.";
L["instancesPastHour24"] = "instâncias nas últimas 24 horas.";
L["leftOnLockout"] = "restantes em bloqueio";

L["tradeLog"] = "Negócio";
L["pastHour"] = "Última hora";
L["pastHour24"] = "Últimas 24 horas";
L["older"] = "Antigo";
L["raid"] = "Raide";
L["alts"] = "Alts";
L["deleteEntry"] = "Excluir entrada";
L["lastHour"] = "Última hora";
L["lastHour24"] = "Últimas 24h";
L["entered"] = "Entrado";
L["ago"] = "atrás";
L["stillInDungeon"] = "Ainda dentro da masmorra";
L["leftOnLockout"] = "restantes em bloqueio";
L["leftOnDailyLockout"] = "restante em bloqueio diário";
L["noLockout"] = "Sem bloqueio para este raide";
L["unknown"] = "Desconhecido";
L["instance"] = "Instância";
L["timeEntered"] = "Hora de entrada";
L["timeLeft"] = "Hora de saída";
L["timeInside"] = "Tempo dentro";
L["mobCount"] = "Quantidade de inimigos";
L["experience"] = "Experiência";
L["experienceShort"] = "EXP";
L["rawGoldMobs"] = "Ouro ganho dos inimigos";
L["enteredLevel"] = "Nível ao entrar";
L["leftLevel"] = "Nível ao sair";
L["averageGroupLevel"] = "Nível médio do grupo";
L["currentLockouts"] = "bloqueios atuais";
L["repGains"] = "Ganhos de reputação";
L["groupMembers"] = "Membros do grupo";
L["tradesWhileInside"] = "Negociações enquanto dentro";
L["noDataInstance"] = "Nenhum dado disponível para esta instância.";
L["restedOnlyText"] = "Descansado";
L["restedOnlyTextTooltip"] = "Mostra apenas personagens com experiência descansada? Desmarque isso para mostrar todos os personagens alternativos, inclusive os de nível máximo e aqueles sem experiência descansada.";

L["deleteEntry"] = "Excluir entrada"; --Example: "Delete entry 5";
L["online"] = "Conectado";
L["maximum"] = "Máx";
L["level"] = "Nível";
L["rested"] = "Descansado";
L["realmGold"] = "Ouro do reino para";
L["total"] = "Total";
L["guild"] = "Guilda";
L["resting"] = "Descansando";
L["notResting"] = "Não descansando";
L["rested"] = "Descansado";
L["restedBubbles"] = "Bolhas de descanso";
L["restedState"] = "Estado de descanso";
L["bagSlots"] = "Espaços na bolsa";
L["durability"] = "Durabilidade";
L["items"] = "Itens";
L["ammunition"] = "Munição";
L["petStatus"] = "Status do mascote";
L["name"] = "Nome";
L["family"] = "Família";
L["happiness"] = "Felicidade";
L["loyaltyRate"] = "Taxa de lealdade";
L["petExperience"] = "EXP do mascote";
L["unspentTrainingPoints"] = "Pontos de treinamento não gastos";
L["professions"] = "Profissões";
L["lastSeenPetDetails"] = "Detalhes do último mascote visto";
L["currentPet"] = "Mascote atual";
L["noPetSummoned"] = "Nenhum mascote invocado";
L["noProfessions"] = "Nenhuma profissão encontrada.";
L["cooldowns"] = "Tempos de recarga";
L["left"] = "restantes"; -- This is left as in "time left";
L["ready"] = "Pronto.";
L["pvp"] = "JxJ";
L["rank"] = "Posto";
L["lastWeek"] = "Semana passada";
L["attunements"] = "Harmonizações";
L["currentRaidLockouts"] = "Bloqueios de raide atuais";
L["none"] = "Nenhum.";


L["instanceStatsOutputRunsPerLevelTitle"] = "Execuções por nível";
L["instanceStatsOutputRunsPerLevelDesc"] = "Mostra quantas execuções são necessárias por nível?";

L["instanceStatsOutputRunsNextLevelTitle"] = "Execuções até o próximo nível";
L["instanceStatsOutputRunsNextLevelDesc"] = "Mostra quantas execuções adicionais são necessárias para alcançar o próximo nível?";

L["instanceWindowWidthTitle"] = "Largura da janela de instância";
L["instanceWindowWidthDesc"] = "Qual deve ser a largura da janela de instância?";

L["instanceWindowHeightTitle"] = "Altura da janela de instância";
L["instanceWindowHeightDesc"] = "Qual deve ser a altura da janela de instância?";

L["charsWindowWidthTitle"] = "Largura da janela de personagens";
L["charsWindowWidthDesc"] = "Qual deve ser a largura da janela de informações dos personagens?";

L["charsWindowHeightTitle"] = "Altura da janela de personagens";
L["charsWindowHeightDesc"] = "Qual deve ser a altura da janela de informações dos personagens?";

L["tradeWindowWidthTitle"] = "Largura da janela de negócio";
L["tradeWindowWidthDesc"] = "Qual deve ser a largura da janela de negócio?";

L["tradeWindowHeightTitle"] = "Altura da janela de negócio";
L["tradeWindowHeightDesc"] = "Qual deve ser a altura da janela de negócio?";

L["resetFramesTitle"] = "Redefinir janelas";
L["resetFramesDesc"] = "Redefine todas as janelas para o centro da tela e os tamanhos para os valores padrão.";

L["resetFramesMsg"] = "Redefinindo todas as posições e tamanhos das janelas.";

L["statsRep"] = "Reputação:";

L["instanceStatsOutputRepTitle"] = "Reputação ganha";
L["instanceStatsOutputRepDesc"] = "Mostra quanto de reputação foi ganho enquanto dentro da masmorra?";

L["instanceStatsOutputHKTitle"] = "Abates honoráveis";
L["instanceStatsOutputHKDesc"] = "Mostra quantos abates honoráveis foram ganhos enquanto dentro de um campo de batalha?";

L["experiencePerHour"] = "EXP/Hora";

L["instanceStatsOutputXpPerHourTitle"] = "Mostrar EXP/Hora";
L["instanceStatsOutputXpPerHourDesc"] = "Mostra quanto de experiência por hora foi ganho enquanto dentro da masmorra?";

L["autoDialogueDesc"] = "Diálogo automático com NPC";

L["autoSlavePensTitle"] = "Pátio dos Escravos";
L["autoSlavePensDesc"] = "Diálogo automático com NPC ao final do Pátio dos Escravos na gaiola?";

L["autoCavernsFlightTitle"] = "Cavernas do Tempo";
L["autoCavernsFlightDesc"] = "Diálogo automático com dragão próximo à pedra de invocação nas Cavernas do Tempo para voar para baixo? (Somente se a missão 'Para o covil do mestre' estiver completa)";

L["autoBlackMorassTitle"] = "Lamaçal Negro";
L["autoBlackMorassDesc"] = "Diálogo automático com NPC no início do Lamaçal Negro para obter sua tocha? (Somente se a missão 'Herói da prole' estiver completa)";

L["autoSfkDoorTitle"] = "Bastilha da Presa Negra";
L["autoSfkDoorDesc"] = "Diálogo automático com NPC na Bastilha da Presa Negra que abre a porta?";

L["honorGains"] = "Ganhos de honra";
L["Honor"] = "Honra";
L["Won"] = "Vitórias";
L["Lost"] = "Derrotas";
L["Arena"] = "Arena";
L["Arena Points"] = "Pontos de Arena";


L["stillInArena"] = "Ainda dentro";
L["stillInBattleground"] = "Ainda dentro";

L["resetAllInstancesConfirm"] = "Tem certeza de que deseja excluir todos os dados de instâncias do registro?";
L["All Instance log data has been deleted."] = "Todos os dados de registro de instâncias foram excluídos.";

L["resetAllInstancesTitle"] = "Redefinir dados";
L["resetAllInstancesDesc"] = "Isso redefinirá todos os dados de instância e excluirá tudo do registro. Isso não redefinirá as trocas.";

L["autoCavernsArthasTitle"] = "Expurgo de Stratholme";
L["autoCavernsArthasDesc"] = "Diálogo automático com Arthas em Expurgo de Stratholme em Wrath.";

L["Mythic Plus"] = "Mítico+";
L["mythicPlusShort"] = "Mítico+";

L["noCurrentRaidLockouts"] = "Não há bloqueios de banda atuais.";

L["weeklyQuests"] = "Missões semanais";
L["dailyQuests"] = "Missões diárias";

L["openLockouts"] = "Bloqueios";

L["autoGammaBuffDesc"] = "Bônus de gama automático";

L["autoGammaBuffTitle"] = "Bônus de gama automático";
L["autoGammaBuffDesc"] = "Receba automaticamente o bônus de gama apropriado para a sua classe quando falar com o NPC de gama em uma masmorra de gama.";

L["autoGammaBuffReminderTitle"] = "Lembrete de bônus de gama";
L["autoGammaBuffReminderDesc"] = "Imprime uma mensagem no bate-papo no início da masmorra lembrando você de obter o bônus se não o tiver.";

L["autoGammaBuffTypeTitle"] = "Tipo de bônus de gama";
L["autoGammaBuffTypeDesc"] = "Qual tipo de bônus você deseja? A seleção automática escolherá entre corpo a corpo/distância/curador/tanque de acordo com a sua especialização. Ou você pode sobrescrevê-lo com uma seleção diferente. A seleção de bônus é uma configuração específica do personagem.";

L["dungeonPopTimerTitle"] = "Temporizador de aparecimento de masmorra";
L["dungeonPopTimerDesc"] = "Mostra um temporizador na janela de fila da masmorra indicando quanto tempo resta para clicar em entrar.";

L["autoWrathDailiesTitle"] = "Obter missões diárias de Wrath automaticamente";
L["autoWrathDailiesDesc"] = "Receba e entregue automaticamente as missões diárias de Wrath do Arquimago Lan'dalock em Dalaran.";

L["gammaConfigWarning"] = "A escolha do bônus de gama é específica do personagem, se você mudá-la neste personagem, não afetará seus outros personagens.";
L["autoGammaBuffReminder"] = "Obtenha o bônus de gama de %s.";
L["Sunreaver Warden"] = "Guarda Solaro";
L["Silver Covenant Warden"] = "Guarda do Pacto de Prata";
L["note"] = "Nota:";
L["Click an entry to post stats."] = "Clique uma entrada para publicar estatísticas.";

L["Show Alts"] = "Mostrar alts";
L["showAltsTooltip"] = "Mostra todas as alternativas no registro de instâncias? (Os bloqueios são por personagem)";

L["PvE"] = "JxE"; --Must be 3 letters max to fit. (PvP already exists further up)
L["Hold to drag"] = "Mantenha pressionado para arrastar";
L["Raid Lockouts (Including Alts)"] = "Bloqueios de raide (Incluindo alts)";
L["No trade logs found."] = "Nenhum registro de negócio encontrado.";
L["Today"] = "Hoje";
L["Yesterday"] = "Ontem";

L["Level Log"] = "Registro";
L["Mouseover log entry for more info"] = "Passe o mouse sobre a entrada do registro para obter mais informações";
L["Current Level"] = "Nível atual";
L["Leveling history for"] = "Histórico de nivelamento para";
L["Unknown Time"] = "Hora desconhecida";
L["Unknown Zone"] = "Zona desconhecida";
L["Zone"] = "Zona";
L["SubZone"] = "Subzona";
L["Ding"] = "Subir para"; --Level up.
L["Map coords"] = "Coordenadas";
L["Gold owned at start of level"] = "Ouro possuído no início do nível";
L["Gold change during this level"] = "Alteração do ouro durante este nível";
L["Quests completed during this level"] = "Missões completadas durante este nível";
L["Mobs that gave exp during this level"] = "Criaturas que deram experiência durante este nível";
L["Played time this level"] = "Tempo jogado neste nível";
L["Total Played"] = "Total jogado";
L["firstTimeSeeingCharPlayed"] = "A primeira vez que este personagem foi visto foi neste nível, é provável que o tempo jogado para este nível esteja incorreto.";
L["Left-Click"] = "Clique Esq.";
L["Right-Click"] = "Clique Dir.";
L["Shift Left-Click"] = "Shift + Clique Esq.";
L["Shift Right-Click"] = "Shift + Clique Dir.";
L["Control Left-Click"] = "Ctrl + Clique Esq.";
L["Middle-Click"] = "Clique Meio";

L["Lockouts"] = "Bloqueios";
L["Instance"] = "Instância";
L["ZoneID"] = "ID da Zona";
L["Show dungeons and raids?"] = "Mostra masmorras e raides?";
L["Show battleground and arena instances?"] = "Mostra campos de batalha e arena?";
L["Party"] = "Grupo";
L["Guild"] = "Guilda";
L["Copy Paste"] = "Copiar/Colar";
L["Print"] = "Imprimir";
L["Post Stats for log"] = "Publicar estatísticas";
L["Alts (Mouseover names for info)"] = "Alts (Passe o mouse sobre os nomes para informações)";
L["Min Level"] = "Nível mínimo";
L["No guild"] = "Sem guilda";
L["No guild rank"] = "Sem cargo na guilda";
L["Show leveling history for"] = "Mostrar histórico de nivelamento para";
L["Test Instance"] = "Instância de teste";
L["Long"] = "Longo";
L["Medium"] = "Médio";
L["Short"] = "Curto";
L["Chat Window"] = "Janela de bate-papo";
L["Group Chat (Party/Raid)"] = "Bate-papo em grupo";
L["12 hour"] = "12 horas";
L["24 hour"] = "24 horas";


L["Molten Core"] = "Núcleo Derretido";
L["Onyxia's Lair"] = "Covil da Onyxia";
L["Blackwing Lair"] = "Covil Asa Negra";
L["Naxxramas"] = "Naxxramas";
L["Karazhan"] = "Karazhan";
L["The Shattered Halls"] = "Salões Despedaçados";
L["Serpentshrine Cavern"] = "Caverna do Serpentário";
L["The Arcatraz"] = "Arcatraz";
L["Black Morass"] = "Lamaçal Negro";
L["Battle of Mount Hyjal"] = "Batalha pelo Monte Hyjal";
L["Black Temple"] = "Templo Negro";
L["Hellfire Citadel"] = "Cidadela Fogo do Inferno";
L["Coilfang Reservoir"] = "Reservatório Presacurva";
L["Shadow Labyrinth"] = "Labirinto Soturno";
L["Auchindoun"] = "Auchindoun";
L["Tempest Keep"] = "Bastilha da Tormenta";
L["Caverns of Time"] = "Cavernas do Tempo";
L["deletedCharOnRealm"] = "Personagem %s excluído no reino [%s].";
L["deletedCharOnRealmNewInfo"] = "Personagem %s excluído no reino [%s], registrando nova informação.";


L["Time"] = "Tempo";
L["Show time?"] = "Mostrar tempo?";
L["Show Zone where trade happened?"] = "Mostrar zona onde ocorreu a troca?";
L["Time Ago"] = "Tempo decorrido";
L["Show how long ago?"] = "Mostrar quanto tempo atrás?";
L["Records"] = "Registros";
L["How many trade records to show?"] = "Quantos registros de troca mostrar?";
L["Current Hour Lockouts"] = "Bloqueios da hora atual";
L["Current Dungeon Stats"] = "Estatísticas atuais da masmorra";
L["Log Entry"] = "Entrada de registro";
L["Local Time"] = "Horário local";
L["Server Time"] = "Hora do reino";
L["Example"] = "Exemplo";


--Abbreviated days/months.
L["Mon"] = "Seg";
L["Tue"] = "Ter";
L["Wed"] = "Qua";
L["Thu"] = "Qui";
L["Fri"] = "Sex";
L["Sat"] = "Sáb";
L["Sun"] = "Dom";

L["Jan"] = "Jan";
L["Feb"] = "Fev";
L["Mar"] = "Mar";
L["Apr"] = "Abr";
L["May"] = "Mai";
L["Jun"] = "Jun";
L["Jul"] = "Jul";
L["Aug"] = "Ago";
L["Sep"] = "Set";
L["Oct"] = "Out";
L["Nov"] = "Nov";
L["Dec"] = "Dez";