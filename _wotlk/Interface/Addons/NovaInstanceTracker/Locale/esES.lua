local L = LibStub("AceLocale-3.0"):NewLocale("NovaInstanceTracker", "esES");
if (not L) then
	return;
end

L["noTimer"] = "Sin temporizador"; --No timer
L["noCurrentTimer"] = "Sin temporizador actual"; --No current timer
L["noActiveTimers"] = "Sin temporizadores activos";	--No active timers
L["second"] = "segundo"; --Second (singular).
L["seconds"] = "segundos"; --Seconds (plural).
L["minute"] = "minuto"; --Minute (singular).
L["minutes"] = "minutos"; --Minutes (plural).
L["hour"] = "hora"; --Hour (singular).
L["hours"] = "horas"; --Hours (plural).
L["day"] = "día"; --Day (singular).
L["days"] = "días"; --Days (plural).
L["secondMedium"] = "seg"; --Second (singular).
L["secondsMedium"] = "segs"; --Seconds (plural).
L["minuteMedium"] = "min"; --Minute (singular).
L["minutesMedium"] = "mins"; --Minutes (plural).
L["hourMedium"] = "hora"; --Hour (singular).
L["hoursMedium"] = "horas"; --Hours (plural).
L["dayMedium"] = "día"; --Day (singular).
L["daysMedium"] = "días"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "d"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Comienza en %s"; --"Starts in 1hour".
L["endsIn"] = "Termina en %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Nova Instance Tracker está desactualizado, por favor actualiza en https://www.curseforge.com/wow/addons/nova-instance-tracker";
L["Options"] = "Opciones";
L["Reset Data"] = "Restablecer datos"; --A button to Reset data.

L["Error"] = "Error";
L["delete"] = "Eliminar";
L["confirmInstanceDeletion"] = "Confirmar eliminación de estancia";
L["confirmCharacterDeletion"] = "Confirmar eliminación de personaje";

-------------
---Config---
-------------
--There are 2 types of strings here, the names end in Title or Desc L["exampleTitle"] and L["exampleDesc"].
--Title must not be any longer than 21 characters (maybe less for chinese characters because they are larger).
--Desc can be any length.

---General Options---
L["generalHeaderDesc"] = "Opciones generales";

L["chatColorTitle"] = "Color de mensaje de chat";
L["chatColorDesc"] = "¿De qué color deberían ser los mensajes en el chat?";

L["resetColorsTitle"] = "Restablecer colores";
L["resetColorsDesc"] = "Restablece los colores a los predeterminados.";

L["timeStampFormatTitle"] = "Formato de marca de tiempo";
L["timeStampFormatDesc"] = "Establece qué formato de marca de tiempo usar, 12 horas (1:23pm) o 24 horas (13:23).";

L["timeStampZoneTitle"] = "Hora local / Hora del reino";
L["timeStampZoneDesc"] = "¿Usa la hora local o la hora del reino para las marcas de tiempo?";

L["minimapButtonTitle"] = "Botón del minimapa";
L["minimapButtonDesc"] = "¿Muestra el botón NIT en el minimapa?";

---Sounds---
L["soundsHeaderDesc"] = "Sonidos";

L["soundsTextDesc"] = "Establece el sonido en \"Ninguno\" para desactivarlo.";

L["disableAllSoundsTitle"] = "Desactivar todos los sonidos";
L["disableAllSoundsDesc"] = "Desactiva todos los sonidos de este addon.";

L["extraSoundOptionsTitle"] = "Opciones de sonido adicionales";
L["extraSoundOptionsDesc"] = "Activa esto para mostrar todos los sonidos de todos tus addons de una vez en las listas desplegables aquí.";

L["notesHeaderDesc"] = "Algunas notas:";
L["notesDesc"] = "Este addon hace todo lo posible para determinar cuándo puedes entrar más estancias, pero el sistema de bloqueo de Blizzard a veces tiene errores y puedes quedar bloqueado antes de alcanzar el límite correcto. A veces solo puedes entrar 4 por hora, pero otras veces puedes entrar 6 por hora.";

L["logHeaderDesc"] = "Ventana de registro";

L["openInstanceLogFrameTitle"] = "Registro de estancias";

L["logSizeTitle"] = "¿Cuántas estancias se muestran en el registro?";
L["logSizeDesc"] = "¿Cuántas estancias deseas que se muestren en el registro? Se almacenan un máximo de 300, 100 se muestran por defecto (puedes abrir el registro escribiendo /NIT).";

L["enteredMsgTitle"] = "Mensaje de entrada";
L["enteredMsgDesc"] = "Esto imprimirá un mensaje en tu ventana principal de chat cuando entres a una estancia con un icono X para eliminar la nueva estancia de la base de datos si lo deseas.";

L["instanceResetMsgTitle"] = "Reinicio en grupo";
L["instanceResetMsgDesc"] = "Esto mostrará un mensaje a tu grupo o banda indicando qué estancias se reiniciaron correctamente si eres el líder del grupo. Ejemplo: \"Cuevas de los Lamentos se reinició.\"";

L["raidEnteredMsgTitle"] = "Mensaje de entrada a banda";
L["raidEnteredMsgDesc"] = "Esto imprimirá un mensaje en tu ventana de chat principal cuando entres a una banda con un icono X para eliminar la nueva estancia de la base de datos si lo deseas.";

L["pvpEnteredMsgTitle"] = "Mensaje de entrada a JcJ";
L["pvpEnteredMsgDesc"] = "Esto imprimirá un mensaje en tu ventana de chat principal cuando entres a una estancia de JcJ con un icono X para eliminar la nueva estancia de la base de datos si lo deseas.";

L["noRaidInstanceMergeMsgTitle"] = "Ocultar junta de banda";
L["noRaidInstanceMergeMsgDesc"] = "Oculta el mensaje de junta de estancias cuando entres a una banda y detectes la misma ID.";

L["showMoneyTradedChatTitle"] = "Oro comerciado";
L["showMoneyTradedChatDesc"] = "¿Muestra en el chat cuando des o recibas oro de alguien? (Ayuda a llevar un registro de a quién le has pagado o de quién has recibido oro en grupos).";

L["instanceStatsHeaderDesc"] = "Salida de estadísticas al final de la mazmorra";

L["instanceStatsTextDesc"] = "Selecciona aquí qué estadísticas mostrar en el chat del grupo o en tu ventana de chat al salir de una mazmorra.";

L["instanceStatsOutputTitle"] = "Estadísticas";
L["instanceStatsOutputDesc"] = "¿Muestra estadísticas sobre la mazmorra al salir?";
			
L["instanceStatsOutputWhereTitle"] = "A dónde mostrar estadísticas";
L["instanceStatsOutputWhereDesc"] = "¿Dónde deseas mostrar las estadísticas, en la ventana de chat para ti mismo o en el chat grupal?";

L["instanceStatsOutputMobCountTitle"] = "Cantidad";
L["instanceStatsOutputMobCountDesc"] = "¿Muestra cuántos enemigos fueron matados dentro de la mazmorra?";

L["instanceStatsOutputXPTitle"] = "Experiencia";
L["instanceStatsOutputXPDesc"] = "¿Muestra cuánta experiencia se obtuvo dentro de la mazmorra?";

L["instanceStatsOutputAverageXPTitle"] = "Experiencia promedio";
L["instanceStatsOutputAverageXPDesc"] = "¿Muestra la experiencia promedio por muerte dentro de la mazmorra?";

L["instanceStatsOutputTimeTitle"] = "Tiempo";
L["instanceStatsOutputTimeDesc"] = "¿Muestra cuánto tiempo pasaste dentro de la mazmorra?";

L["instanceStatsOutputGoldTitle"] = "Oro obtenido";
L["instanceStatsOutputGoldDesc"] = "¿Muestra cuánto oro se obtuvo de los enemigos dentro de la mazmorra?";

L["instanceStatsOutputAverageGroupLevelTitle"] = "Nivel promedio";
L["instanceStatsOutputAverageGroupLevelDesc"] = "¿Muestra el nivel promedio del grupo dentro de la mazmorra?";


L["showAltsLogTitle"] = "Mostrar alts";
L["showAltsLogDesc"] = "¿Muestra personajes alternativos en el registro de estancias?";

L["timeStringTypeTitle"] = "Formato de cadena de tiempo";
L["timeStringTypeDesc"] = "¿Qué formato de cadena de tiempo usar en el registro de estancias?\n|cFFFFFF00Largo:|r 1 minuto 30 segundos\n|cFFFFFF00Medio:|r 1 min 30 segs\n|cFFFFFF00Corto:|r 1m30s";

L["showLockoutTimeTitle"] = "Tiempo de bloqueo";
L["showLockoutTimeDesc"] = "Esto mostrará el tiempo de bloqueo restante en el registro de estancias para las estancias en las últimas 24 horas; si está desmarcado, mostrará el tiempo de entrada como en versiones anteriores.";

L["colorsHeaderDesc"] = "Colores";

L["mergeColorTitle"] = "Color de junta de estancias";
L["mergeColorDesc"] = "¿De qué color debería ser el mensaje en el chat cuando se detecta la misma estancia que la anterior y los datos se juntan?";

L["detectSameInstanceTitle"] = "Detectar misma estancia";
L["detectSameInstanceDesc"] = "¿Detecta automáticamente si vuelves a entrar a la misma estancia para que el addon no lo cuente como 2 estancias separadas?";

L["showStatsInRaidTitle"] = "Estadísticas en banda";
L["showStatsInRaidDesc"] = "¿Muestra estadísticas cuando estás en una banda? Desactiva esto para mostrar estadísticas solo al grupo cuando estás en un grupo de 5 personas (esta opción solo funciona cuando tienes el chat grupal como salida de estadísticas).";

L["printRaidInsteadTitle"] = "Imprimir en banda";
L["printRaidInsteadDesc"] = "Si tienes la opción de desactivar el envío de estadísticas al chat de banda, entonces esto las imprimirá en tu ventana de chat para que puedas verlas.";

L["statsOnlyWhenActivityTitle"] = "Si hay actividad";
L["statsOnlyWhenActivityDesc"] = "¿Muestra estadísticas solo cuando ocurrió alguna actividad dentro de la mazmorra? Esto significa solo si eliminaste algunos enemigos, obtuviste experiencia, saqueaste oro, etc. Esto hará que no se muestren estadísticas vacías.";


L["show24HourOnlyTitle"] = "Últimas 24 horas";
L["show24HourOnlyDesc"] = "¿Muestra solo estancias de las últimas 24 horas en el registro de estancias?";

L["trimDataHeaderDesc"] = "Limpieza de datos";

L["trimDataBelowLevelTitle"] = "Nivel máximo a eliminar";
L["trimDataBelowLevelDesc"] = "Selecciona el nivel máximo de personajes para eliminar de la base de datos; todos los personajes de este nivel y menos serán eliminados.";

L["trimDataBelowLevelButtonTitle"] = "Eliminar personajes";
L["trimDataBelowLevelButtonDesc"] = "Haz clic en este botón para eliminar todos los personajes con el nivel seleccionado y más bajo de esta base de datos del addon.";

L["trimDataTextDesc"] = "Eliminar varios personajes de la base de datos:";
L["trimDataText2Desc"] = "Elimina un personaje de la base de datos:";

L["trimDataCharInputTitle"] = "Entrada para eliminar un personaje";
L["trimDataCharInputDesc"] = "Escribe aquí un personaje para eliminar, en el formato Nombre-Reino (sensible a mayúsculas y minúsculas). Nota: Esto elimina permanentemente los datos de recuento de hechizos.";

L["trimDataBelowLevelButtonConfirm"] = "¿Estás seguro de que deseas eliminar todos los personajes por debajo del nivel %s de la base de datos?";
L["trimDataCharInputConfirm"] = "¿Estás seguro de que deseas eliminar este personaje %s de la base de datos?";

L["trimDataMsg2"] = "Eliminando todos los personajes por debajo del nivel %s.";
L["trimDataMsg3"] = "Eliminado: %s.";
L["trimDataMsg4"] = "Hecho, no se encontraron personajes.";
L["trimDataMsg5"] = "Hecho, se eliminaron %s personajes.";
L["trimDataMsg6"] = "Por favor, introduce un nombre de personaje válido para eliminar de la base de datos.";
L["trimDataMsg7"] = "Este nombre de personaje %s no incluye un reino, por favor ingresa Nombre-Reino.";
L["trimDataMsg8"] = "Error al eliminar %s de la base de datos, personaje no encontrado (el nombre distingue mayúsculas y minúsculas).";
L["trimDataMsg9"] = "Se eliminó %s de la base de datos.";


L["instanceFrameSelectAltMsg"] = "Selecciona qué personaje alternativo mostrar si \"Mostrar alts\" no está marcado.\nO qué personaje alternativo colorear si \"Mostrar alts\" está marcado.";

L["enteredDungeon"] = "Nueva estancia %s %s, haz clic";
L["enteredDungeon2"] = "si esta no es una nueva estancia.";
L["enteredRaid"] = "Nueva estancia %s, esta banda no cuenta para el bloqueo.";
L["loggedInDungeon"] = "Has iniciado sesión dentro de %s %s, si esta no es una nueva estancia haz clic";
L["loggedInDungeon2"] = "para eliminar esta estancia de la base de datos.";
L["reloadDungeon"] = "Se ha detectado una recarga de interfaz %s, cargando los datos de la última estancia en lugar de crear una nueva.";
L["thisHour"] = "esta hora";
L["statsError"] = "Error al encontrar estadísticas para la estancia %s.";
L["statsMobs"] = "Enemigos:";
L["statsXP"] = "EXP:";
L["statsAverageXP"] = "EXP promedio por enemigo:";
L["statsRunsPerLevel"] = "estancias por nivel:";
L["statsRunsNextLevel"] = "estancias hasta el siguiente nivel:";
L["statsTime"] = "Tiempo:";
L["statsAverageGroupLevel"] = "Nivel promedio del grupo:";
L["statsGold"] = "Oro";
L["sameInstance"] = "Misma ID de estancia que la última detectada %s, juntando entradas de la base de datos.";
L["deleteInstance"] = "estancia eliminada [%s] %s (%s atrás) de la base de datos.";
L["deleteInstanceError"] = "Error al eliminar %s.";
L["countString"] = "Has entrado %s estancias en la última hora y %s en las últimas 24 horas";
L["countStringColorized"] = "Has entrado %s %s %s estancias en la última hora y %s %s %s en las últimas 24 horas";
L["now"] = "ahora";
L["in"] = "en";
L["active24"] = "Bloqueo de 24h activo";
L["nextInstanceAvailable"] = "Siguiente estancia disponible";
L["gave"] = "Dio";
L["received"] = "Recibió";
L["to"] = "a";
L["from"] = "de";
L["playersStillInside"] = "ha sido reiniciado (Los jugadores que aún están dentro de la estancia antigua pueden salir de ella y entrar en la nueva).";
L["Gold"] = "Oro";
L["gold"] = "oro";
L["silver"] = "plata";
L["copper"] = "cobre";
L["newInstanceNow"] = "Una nueva estancia se puede entrar ahora";
L["thisHour"] = "esta hora";
L["thisHour24"] = "estas 24 horas";
L["openInstanceFrame"] = "Registro de estancias";
L["openYourChars"] = "Tus personajes";
L["openTradeLog"] = "Registro de comercio";
L["config"] = "Opciones";
L["thisChar"] = "Este personaje";
L["yourChars"] = "Personajes";
L["instancesPastHour"] = "estancias en la última hora.";
L["instancesPastHour24"] = "estancias en las últimas 24 horas.";
L["leftOnLockout"] = "restantes en bloqueo";

L["tradeLog"] = "Comercio";
L["pastHour"] = "Última hora";
L["pastHour24"] = "Últimas 24 horas";
L["older"] = "Antiguo";
L["raid"] = "Banda";
L["alts"] = "Alts";
L["deleteEntry"] = "Eliminar entrada";
L["lastHour"] = "Última hora";
L["lastHour24"] = "Últimas 24h";
L["entered"] = "Entrado";
L["ago"] = "atrás";
L["stillInDungeon"] = "Todavía dentro de la mazmorra";
L["leftOnLockout"] = "restantes en bloqueo";
L["leftOnDailyLockout"] = "restante en bloqueo diario";
L["noLockout"] = "Sin bloqueo para esta banda";
L["unknown"] = "Desconocido";
L["instance"] = "Estancia";
L["timeEntered"] = "Hora de entrada";
L["timeLeft"] = "Hora de salida";
L["timeInside"] = "Tiempo dentro";
L["mobCount"] = "Cantidad de enemigos";
L["experience"] = "Experiencia";
L["experienceShort"] = "EXP";
L["rawGoldMobs"] = "Oro ganado de los enemigos";
L["enteredLevel"] = "Nivel al entrar";
L["leftLevel"] = "Nivel al salir";
L["averageGroupLevel"] = "Nivel promedio del grupo";
L["currentLockouts"] = "bloqueos actuales";
L["repGains"] = "Ganancias de reputación";
L["groupMembers"] = "Miembros del grupo";
L["tradesWhileInside"] = "Comercios mientras estaba dentro";
L["noDataInstance"] = "No hay datos disponibles para esta estancia.";
L["restedOnlyText"] = "Solo descansado";
L["restedOnlyTextTooltip"] = "¿Muestra solo personajes con experiencia de descanso? Desmarca esto para mostrar todos los personajes alternativos, incluso los de nivel máximo y aquellos sin experiencia de descanso.";
L["deleteEntry"] = "Eliminar entrada"; --Example: "Delete entry 5";
L["online"] = "Conectado";
L["maximum"] = "Máx";
L["level"] = "Nivel";
L["rested"] = "Descansado";
L["realmGold"] = "Oro del reino para";
L["total"] = "Total";
L["guild"] = "Hermandad";
L["resting"] = "Descansando";
L["notResting"] = "No descansando";
L["rested"] = "Descansado";
L["restedBubbles"] = "Burbujas de descanso";
L["restedState"] = "Estado de descanso";
L["bagSlots"] = "Casillas en la bolsa";
L["durability"] = "Durabilidad";
L["items"] = "Objetos";
L["ammunition"] = "Munición";
L["petStatus"] = "Estado de mascota";
L["name"] = "Nombre";
L["family"] = "Familia";
L["happiness"] = "Felicidad";
L["loyaltyRate"] = "Tasa de lealtad";
L["petExperience"] = "EXP de mascota";
L["unspentTrainingPoints"] = "Puntos de entrenamiento no gastados";
L["professions"] = "Profesiones";
L["lastSeenPetDetails"] = "Detalles de la última mascota vista";
L["currentPet"] = "Mascota actual";
L["noPetSummoned"] = "No hay mascota";
L["lastSeenPetDetails"] = "Detalles de la última mascota vista";
L["noProfessions"] = "No se encontraron profesiones.";
L["cooldowns"] = "Reutilizaciones";
L["left"] = "restantes"; -- This is left as in "time left";
L["ready"] = "Listo.";
L["pvp"] = "JcJ";
L["rank"] = "Rango";
L["lastWeek"] = "La semana pasada";
L["attunements"] = "Armonizaciones";
L["currentRaidLockouts"] = "Bloqueos de banda actuales";
L["none"] = "Ninguno.";


L["instanceStatsOutputRunsPerLevelTitle"] = "Veces por nivel";
L["instanceStatsOutputRunsPerLevelDesc"] = "¿Muestra cuántas veces se necesita por nivel?";

L["instanceStatsOutputRunsNextLevelTitle"] = "Veces al próximo nivel";
L["instanceStatsOutputRunsNextLevelDesc"] = "¿Muestra cuántas veces más necesitas hacer la estancia para alcanzar tu próximo nivel?";

L["instanceWindowWidthTitle"] = "Anchura de la ventana de estancia";
L["instanceWindowWidthDesc"] = "¿Qué anchura debería tener la ventana de estancia?";

L["instanceWindowHeightTitle"] = "Altura de la ventana de estancia";
L["instanceWindowHeightDesc"] = "¿Qué altura debería tener la ventana de estancia?";

L["charsWindowWidthTitle"] = "Anchura de la ventana de personajes";
L["charsWindowWidthDesc"] = "¿Qué anchura debería tener la ventana de información de personajes?";

L["charsWindowHeightTitle"] = "Altura de la ventana de personajes";
L["charsWindowHeightDesc"] = "¿Qué altura debería tener la ventana de información de personajes?";

L["tradeWindowWidthTitle"] = "Anchura de la ventana de comercio";
L["tradeWindowWidthDesc"] = "¿Qué achura debería tener la ventana de comercio?";

L["tradeWindowHeightTitle"] = "Altura de la ventana de comercio";
L["tradeWindowHeightDesc"] = "¿Qué altura debería tener la ventana de comercio?";

L["resetFramesTitle"] = "Restablecer ventanas";
L["resetFramesDesc"] = "Restablece todas las ventanas al centro de la pantalla y los tamaños a los valores predeterminados.";

L["resetFramesMsg"] = "Restableciendo todas las posiciones y tamaños de las ventanas.";

L["statsRep"] = "Reputación:";

L["instanceStatsOutputRepTitle"] = "Reputación ganada";
L["instanceStatsOutputRepDesc"] = "¿Muestra cuánta reputación se ganó mientras se está dentro de la mazmorra?";

L["instanceStatsOutputHKTitle"] = "Muertes con honor";
L["instanceStatsOutputHKDesc"] = "¿Muestra cuántas muertes con honor se ganaron mientras se está dentro de un campo de batalla?";

L["experiencePerHour"] = "EXP/Hora";

L["instanceStatsOutputXpPerHourTitle"] = "Mostrar EXP/Hora";
L["instanceStatsOutputXpPerHourDesc"] = "¿Muestra cuánta experiencia por hora se ganó mientras se está dentro de la mazmorra?";

L["autoDialogueDesc"] = "Diálogo automático con PNJ";

L["autoSlavePensTitle"] = "Recinto de los Esclavos";
L["autoSlavePensDesc"] = "¿Diálogo automático con el PNJ al final de Recinto de los Esclavos en la jaula?";

L["autoCavernsFlightTitle"] = "Cavernas del Tiempo";
L["autoCavernsFlightDesc"] = "¿Diálogo automático con el dragón cerca de la piedra de invocación en Cavernas del Tiempo para volar hacia abajo? (Solo si la misión \"La caverna del maestro\" está completada)";

L["autoBlackMorassTitle"] = "La Ciénaga Negra";
L["autoBlackMorassDesc"] = "¿Diálogo automático con el PNJ al comienzo de La Ciénaga Negra para obtener tu antorcha? (Solo si la misión \"Adalid del linaje\" está completada)";

L["autoSfkDoorTitle"] = "Castillo de Colmillo Oscuro";
L["autoSfkDoorDesc"] = "¿Diálogo automático con el PNJ en Castillo de Colmillo Oscuro que abre la puerta?";


L["honorGains"] = "Ganancias de honor";
L["Honor"] = "Honor";
L["Won"] = "Ganado";
L["Lost"] = "Perdido";
L["Arena"] = "Arena";
L["Arena Points"] = "Puntos de arena";

L["stillInArena"] = "Aún dentro";
L["stillInBattleground"] = "Aún dentro";

L["resetAllInstancesConfirm"] = "¿Estás seguro de que quieres eliminar todos los datos de estancia del registro?";
L["All Instance log data has been deleted."] = "Se han eliminado todos los datos del registro de estancias.";

L["resetAllInstancesTitle"] = "Restablecer datos";
L["resetAllInstancesDesc"] = "Esto restablecerá todos los datos de estancia y eliminará todo del registro. Esto no restablece los intercambios.";

L["autoCavernsArthasTitle"] = "La Matanza de Stratholme";
L["autoCavernsArthasDesc"] = "Diálogo automático con Arthas en La Matanza de Stratholme en Wrath.";

L["Mythic Plus"] = "Mítico+";
L["mythicPlusShort"] = "Mítico+";

L["noCurrentRaidLockouts"] = "No hay bloqueos de banda actuales.";

L["weeklyQuests"] = "Misiones semanales";
L["dailyQuests"] = "Misiones diarias";

L["openLockouts"] = "Bloqueos";

L["autoGammaBuffDesc"] = "Beneficio gamma";

L["autoGammaBuffTitle"] = "Beneficio gamma automático";
L["autoGammaBuffDesc"] = "Obtén automáticamente el beneficio gamma adecuado para tu clase cuando hables con el PNJ de gamma en una mazmorra gamma.";

L["autoGammaBuffReminderTitle"] = "Recordatorio de beneficio gamma";
L["autoGammaBuffReminderDesc"] = "Imprime un mensaje en el chat al inicio de la mazmorra recordándote obtener el beneficio si no lo tienes.";

L["autoGammaBuffTypeTitle"] = "Tipo de beneficio gamma";
L["autoGammaBuffTypeDesc"] = "¿Qué tipo de beneficio deseas? La selección automática elegirá entre cuerpo a cuerpo/rango/sanador/tanque según tu especialización. O puedes sobrescribirlo con una selección diferente. La selección de beneficio es una opción de configuración específica del personaje.";

L["dungeonPopTimerTitle"] = "Temporizador de aparición de mazmorra";
L["dungeonPopTimerDesc"] = "Muestra un temporizador en la ventana de cola de la mazmorra que indica cuánto tiempo queda para hacer clic en entrar.";

L["autoWrathDailiesTitle"] = "Obtener misiones diaras de Wrath automáticamente";
L["autoWrathDailiesDesc"] = "Obtiene y entrega automáticamente las misiones diarias de Wrath de Archimago Lan'dalock en Dalaran.";

			
L["gammaConfigWarning"] = "La elección del beneficio gamma es específica del personaje, si lo cambias en este personaje, no afectará a tus otros personajes.";
L["autoGammaBuffReminder"] = "Obtén el beneficio de mazmorra gamma de %s.";
L["Sunreaver Warden"] = "Celador Atracasol";
L["Silver Covenant Warden"] = "Celador de El Pacto de Plata";
L["note"] = "Nota:";
L["Click an entry to post stats."] = "Haz clic una entrada para publicar estadísticas.";

L["Show Alts"] = "Mostrar alts";
L["showAltsTooltip"] = "¿Muestra todos los alts en el registro de estancias? (Los bloqueos son por personaje)";
L["PvE"] = "JcE"; --Must be 3 letters max to fit. (PvP already exists further up)
L["Hold to drag"] = "Mantén presionado para arrastrar";
L["Raid Lockouts (Including Alts)"] = "Bloqueos de banda (incluso alts)";
L["No trade logs found."] = "No se encontraron registros de comercio.";
L["Today"] = "Hoy";
L["Yesterday"] = "Ayer";

L["Level Log"] = "Registro de nivel";
L["Mouseover log entry for more info"] = "Pasar el ratón para obtener más información";
L["Current Level"] = "Nivel actual";
L["Leveling history for"] = "Historial de nivelación para";
L["Unknown Time"] = "Hora desconocida";
L["Unknown Zone"] = "Zona desconocida";
L["Zone"] = "Zona";
L["SubZone"] = "Subzona";
L["Ding"] = "Subir a"; --Level up.
L["Map coords"] = "Coordenadas";
L["Gold owned at start of level"] = "Oro poseído al inicio del nivel";
L["Gold change during this level"] = "Oro ganado durante este nivel";
L["Quests completed during this level"] = "Misiones completadas durante este nivel";
L["Mobs that gave exp during this level"] = "Criaturas que dieron experiencia durante este nivel";
L["Played time this level"] = "Tiempo jugado en este nivel";
L["Total Played"] = "Total jugado";
L["firstTimeSeeingCharPlayed"] = "La primera vez que se ve a este personaje fue en este nivel, es probable que el tiempo jugado para este nivel esté incorrecto.";
L["Left-Click"] = "Clic Izq.";
L["Right-Click"] = "Clic Der.";
L["Shift Left-Click"] = "Mayús Clic Izq.";
L["Shift Right-Click"] = "Mayús Clic Der.";
L["Control Left-Click"] = "Control Clic Izq.";
L["Middle-Click"] = "Clic Central";

L["Lockouts"] = "Bloqueos";
L["Instance"] = "Estancia";
L["ZoneID"] = "ID de zona";
L["Show dungeons and raids?"] = "¿Muestra mazmorras y bandas?";
L["Show battleground and arena instances?"] = "¿Muestra campos de batalla y arenas?";
L["Party"] = "Grupo";
L["Guild"] = "Hermandad";
L["Copy Paste"] = "Copiar/Pegar";
L["Print"] = "Imprimir";
L["Post Stats for log"] = "Publicar estadísticas";
L["Alts (Mouseover names for info)"] = "Alts (Pasar el ratón sobre nombres para info.)";
L["Min Level"] = "Nivel mínimo";
L["No guild"] = "Sin hermandad";
L["No guild rank"] = "Sin rango en la hermandad";
L["Show leveling history for"] = "Mostrar historial de nivelación para";
L["Test Instance"] = "Estancia de prueba";
L["Long"] = "Largo";
L["Medium"] = "Medio";
L["Short"] = "Corto";
L["Chat Window"] = "Ventana de chat";
L["Group Chat (Party/Raid)"] = "Chat de grupo (grupo/banda)";
L["12 hour"] = "12 horas";
L["24 hour"] = "24 horas";


L["Molten Core"] = "Núcleo de Magma";
L["Onyxia's Lair"] = "Guarida de Onyxia";
L["Blackwing Lair"] = "Guarida de Alanegra";
L["Naxxramas"] = "Naxxramas";
L["Karazhan"] = "Karazhan";
L["The Shattered Halls"] = "Las Salas Arrasadas";
L["Serpentshrine Cavern"] = "Caverna Santuario Serpiente";
L["The Arcatraz"] = "El Arcatraz";
L["Black Morass"] = "La Ciénaga Negra";
L["Battle of Mount Hyjal"] = "Batalla del Monte Hyjal";
L["Black Temple"] = "Templo Oscuro";
L["Hellfire Citadel"] = "Ciudadela del Fuego Infernal";
L["Coilfang Reservoir"] = "Reserva Colmillo Torcido";
L["Shadow Labyrinth"] = "Laberinto de las Sombras";
L["Auchindoun"] = "Auchindoun";
L["Tempest Keep"] = "El Castillo de la Tempestad";
L["Caverns of Time"] = "Cavernas del Tiempo";
L["deletedCharOnRealm"] = "Personaje %s eliminado en el reino [%s].";
L["deletedCharOnRealmNewInfo"] = "Personaje %s eliminado en el reino [%s], registrando nueva información.";


L["Time"] = "Tiempo";
L["Show time?"] = "¿Muestra tiempo?";
L["Show Zone where trade happened?"] = "¿Muestra zona donde ocurrió el comercio?";
L["Time Ago"] = "Tiempo transcurrido";
L["Show how long ago?"] = "¿Muestra hace cuánto?";
L["Records"] = "Registros";
L["How many trade records to show?"] = "¿Cuántos registros de comercio mostrar?";
L["Current Hour Lockouts"] = "Bloqueos de la hora actual";
L["Current Dungeon Stats"] = "Estadísticas actuales de mazmorra";
L["Log Entry"] = "Entrada de registro";
L["Local Time"] = "Hora local";
L["Server Time"] = "Hora del reino";
L["Example"] = "Ejemplo";

--Abbreviated days/months.
L["Mon"] = "Lun";
L["Tue"] = "Mart";
L["Wed"] = "Miérc";
L["Thu"] = "Juev";
L["Fri"] = "Vier";
L["Sat"] = "Sáb";
L["Sun"] = "Dom";

L["Jan"] = "Ene";
L["Feb"] = "Feb";
L["Mar"] = "Mar";
L["Apr"] = "Abr";
L["May"] = "May";
L["Jun"] = "Jun";
L["Jul"] = "Jul";
L["Aug"] = "Ago";
L["Sep"] = "Sep";
L["Oct"] = "Oct";
L["Nov"] = "Nov";
L["Dec"] = "Dic";