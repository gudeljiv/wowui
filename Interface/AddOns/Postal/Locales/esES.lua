local L = LibStub("AceLocale-3.0"):NewLocale("Postal", "esMX")
if not L then return end
L["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt-Clic|r para enviar este objeto a %s"
L["|cffeda55fControl-Click|r to attach similar items."] = "|cffeda55fCtrl-Clic|r para adjuntar objetos similares."
L["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fCtrl-Clic|r para devolver correo al que te lo envió."
L["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fShift-Clic|r para tomar el contenido."
L[ [=[|cFFFFCC00*|r Selected mail will be batch opened or returned to sender by clicking Open or Return.
|cFFFFCC00*|r You can Shift-Click 2 checkboxes to mass select every mail between the 2 checkboxes.
|cFFFFCC00*|r You can Ctrl-Click a checkbox to mass select or unselect every mail from that sender.
|cFFFFCC00*|r Select will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r Select will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r El correo seleccionado puede ser abierto por lotes o devuelto al remitente haciendo clic en Abrir o Devolver.
|cFFFFCC00*|r Puedes hacer Shift-Clic en 2 casillas de verificación para seleccionar el total de los correos entre las 2 casillas de verificación.
|cFFFFCC00*|r Puedes hacer Ctrl-Clic en una casilla de verificación para seleccionar o desmarcar el total de cada correo de ese remitente.
|cFFFFCC00*|r Selecciona para nunca eliminar ningún correo (correo sin texto es automáticamente borrado por el juego cuando se toman todos los objetos adjuntos y el oro).
|cFFFFCC00*|r Selecciona para omitir correos C.R. y correos de Blizzard.
|cFFFFCC00*|r Desactive la opción Modo detallado para detener el spam del chat al abrir el correo.]=]
L[ [=[|cFFFFCC00*|r Shift-Click to take item/money from mail.
|cFFFFCC00*|r Ctrl-Click to return mail.
|cFFFFCC00*|r Alt-Click to move an item from your inventory to the current outgoing mail (same as right click in default UI).]=] ] = [=[|cFFFFCC00*|r Shift-Clic para tomar objetos/dinero del correo.
|cFFFFCC00*|r Ctrl-Clic para devolver el correo.
|cFFFFCC00*|r Alt-Clic para mover un objeto del inventario al correo de salida actual (igual que clic derecho en la IU predeterminado).
|cFFFFCC00*|r Rueda del ratón para desplazarse en la bandeja de entrada.]=]
L[ [=[|cFFFFCC00*|r Simple filters are available for various mail types.
|cFFFFCC00*|r Shift-Click the Open All button to override the filters and take ALL mail.
|cFFFFCC00*|r OpenAll will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r OpenAll will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r Filtros sencillos están disponibles para los diferentes tipos de correo.
|cFFFFCC00*|r Shift-Clic en el botón Abrir todo para ignorar los filtros y abrir todos los correos.
|cFFFFCC00*|r Abrir todo nunca eliminara ningún correo (correo sin texto es automáticamente borrado por el juego cuando se toman todos los objetos adjuntos y el oro).
|cFFFFCC00*|r Abrir todo omitirá correos C.R. y correos de Blizzard.
|cFFFFCC00*|r Desactive la opción Modo detallado para detener el spam del chat al abrir el correo.]=]
L[ [=[|cFFFFCC00*|r This module will list your contacts, friends, guild mates, alts and track the last 10 people you mailed.
|cFFFFCC00*|r It will also autocomplete all names in your BlackBook.]=] ] = [=[|cFFFFCC00*|r Este módulo te mostrara tus contactos, amigos, compañeros de hermandad, personajes secundarios y listara las ultimas 10 personas a las que mandaste un correo.
|cFFFFCC00*|r Además autocompletará todos los nombres en tu libro negro.]=]
L["A button that collects all attachments and coins from mail."] = "Un botón que recoge todo lo adjunto y el dinero de los correos."
L["Add check boxes to the inbox for multiple mail operations."] = "Añade casillas de verificación a la bandeja de entrada para múltiples operaciones de correo."
L["Add Contact"] = "Añadir contacto"
L["Add multiple item mail tooltips"] = "Añadir ventana emergente en correos con múltiples objetos"
L["Adds a contact list next to the To: field."] = "Añade una lista de contactos al lado del campo Para:"
L["AH-related mail"] = "(Correo relacionado con la casa de subastas)"
L["All Alts"] = "Cualquier personaje"
L["Allows you to copy the contents of a mail."] = "Te permite copiar el contenido de un correo."
L["Alts"] = "Personajes secundarios"
L["Auto-Attach similar items on Control-Click"] = "Autoadjuntar objetos similares con Ctrl-Clic"
L["Autofill last person mailed"] = "Autorellenar con la última persona que mandaste correo"
L["Auto-Send on Alt-Click"] = "Autoenviar con Alt-Clic"
L["BlackBook"] = "Libro negro"
L["Block incoming trade requests while in a mail session."] = "Bloquea las solicitudes entrantes de comercio mientras se está en una sesión de correo."
L["CarbonCopy"] = "Copia al carbón"
L["Chat Output"] = "Chat de salida"
L["Choose"] = "Elegir"
L["Clear list"] = "Limpiar lista"
L["Collected"] = "Recogido"
L["Contacts"] = "Contactos"
L["Copy From"] = "Copiar de"
L["Copy this mail"] = "Copiar este correo"
L["Delete"] = "Borrar"
L["Disable Blizzard's auto-completion popup menu"] = "Desactivar la ventana emergente de autocompletado de Blizzard"
L["DoNotWant"] = "No quiero"
L["Enable Alt-Click to send mail"] = "Habilitar Alt-Clic para enviar correo"
L["Exclude randoms you interacted with"] = "Excluir aleatorios con los que tú interactuaste"
L["Express"] = "Rápido"
L["Friends"] = "Amigos"
L["Guild"] = "Hermandad"
L["Help"] = "Ayuda"
L["In Progress"] = "En progreso"
L["Keep free space"] = "Mantener espacio libre"
L["Mouse click short cuts for mail."] = "Atajos para el correo con clics del ratón."
L["Name auto-completion options"] = "Opciones de autocompletado de nombre"
L["New Profile"] = "Nuevo perfil "
L["New Profile Name:"] = "Nombre del perfil nuevo:"
L["Non-AH related mail"] = "Correo no relacionado con la casa de subastas"
L["Not all messages are shown, refreshing mailbox soon to continue Open All..."] = "No se muestran todos los mensajes, refrescando el buzón antes de seguir abriendo todo..."
L["Not taking more items as there are now only %d regular bagslots free."] = "No se tomarán más objetos ya que solo quedan %d espacios libres en las bolsas."
L["Open"] = "Abrir"
L["Open All"] = "Abrir todo"
L["Open all Auction cancelled mail"] = "Abrir todo el correo de subastas canceladas"
L["Open all Auction expired mail"] = "Abrir todo el correo de subastas expiradas"
L["Open all Auction successful mail"] = "Abrir todo el correo de subastas exitosas"
L["Open all Auction won mail"] = "Abrir todo el correo de subastas ganadas"
L["Open all mail with attachments"] = "Abrir todo el correo con adjuntos"
L["Open all Outbid on mail"] = "Abrir todo el correo de sobrepujas"
L["Open mail from the Postmaster"] = "Abrir todo el correo del Jefe de correos"
L["OpenAll"] = "Abrir todo"
L["Opening Speed"] = "Velocidad de apertura"
L["Other options"] = "Otras opciones"
L["Part %d"] = "Parte %d"
L["Please post bugs or suggestions at the wowace forums thread at |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. When posting bugs, indicate your locale and Postal's version number v%s."] = "Por favor, informe de errores o sugerencias en el hilo del foro de Wowace en |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. Al publicar errores, indique su localización y el número de versión de Postal v%s."
L["Prints the amount of money collected during a mail session."] = "Muestra la cantidad de dinero reunida durante una sesión de correo."
L["Processing Message"] = "Procesando mensaje"
L["Profile"] = "Perfil"
L["Rake"] = "Rastrillo"
L["Recently Mailed"] = "Enviado recientemente"
L["Refreshing mailbox..."] = "Refrescando buzón..."
L["Remove Contact"] = "Eliminar contacto"
L["Reset Profile"] = "Restablecer perfil"
L["Return"] = "Devolver"
L["Select"] = "Seleccionar"
L["Set subject field to value of coins sent if subject is blank."] = "Establece el campo Asunto con el valor del dinero enviado si el asunto está en blanco."
L["Shows a clickable visual icon as to whether a mail will be returned or deleted on expiry."] = "Muestra un icono visual interactivo si un correo se devolverá o borrará al expirar."
L["Skipping"] = "Omitir"
L["Some Messages May Have Been Skipped."] = "Algunos mensajes pueden haberse omitido."
L["Thaumaturge Vashreen"] = "Taumaturgo Vahsreen"
L["The Postmaster"] = "El Jefe de correos"
L["There are %i more messages not currently shown."] = "Hay %i mensajes más por mostrar."
L["There are %i more messages not currently shown. More should become available in %i seconds."] = "Hay %i mensajes más por mostrar. Estarán disponibles en %i segundos."
L["TradeBlock"] = "Bloquear comercio"
L["Use Mr.Plow after opening"] = "Utilice Mr.Plow después de abrir"
L["Use Postal's auto-complete"] = "Usar el autocompletado de Postal"
L["Verbose mode"] = "Modo detallado"
L["Wire"] = "Telegrama"
