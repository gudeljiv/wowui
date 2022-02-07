local L = LibStub("AceLocale-3.0"):NewLocale("Postal", "itIT")
if not L then return end
L["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt-Click|r per spedire questo oggetto a %s."
L["|cffeda55fControl-Click|r to attach similar items."] = "Control-Click per allegare oggetti simili"
L["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fCtrl-Click|r per rimandarla al mittente."
L["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fShift-Click|r per prendere il contenuto."
L[ [=[|cFFFFCC00*|r Selected mail will be batch opened or returned to sender by clicking Open or Return.
|cFFFFCC00*|r You can Shift-Click 2 checkboxes to mass select every mail between the 2 checkboxes.
|cFFFFCC00*|r You can Ctrl-Click a checkbox to mass select or unselect every mail from that sender.
|cFFFFCC00*|r Select will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r Select will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r Le lettere selezionate saranno aperte o rimandate al mittente cliccando su Apri o Rimanda
|cFFFFCC00*|r Con Shift-Click puoi selezionare due spunti per selezionare tutte le lettere tra i due spunti.
|cFFFFCC00*|r Con Ctrl-Click su uno spunto puoi selezionare o deselezionare tutte le lettere di quel mittente.
|cFFFFCC00*|r Seleziona non cancellerà mai nessuna lettera (le lettere senza testo saranno cancellate automaticamente dal gioco quando sono stati presi tutti gli allegati e i soldi).
|cFFFFCC00*|r Seleziona salterà tutte le lettere P.C. e le lettere da Blizzard.
|cFFFFCC00*|r Disabilita l'opzione testuale per fermare lo spam durante l'apertura delle lettere]=]
L[ [=[|cFFFFCC00*|r Shift-Click to take item/money from mail.
|cFFFFCC00*|r Ctrl-Click to return mail.
|cFFFFCC00*|r Alt-Click to move an item from your inventory to the current outgoing mail (same as right click in default UI).]=] ] = [=[|cFFFFCC00*|r Shift-Click per prendere gli oggetti o le monete dalla posta.
|cFFFFCC00*|r Ctrl-Click per rimandare indietro la posta.
|cFFFFCC00*|r Alt-Click per muovere un oggetto dall'inventario alla lettera in uscita attuale (come il tasto destro del mouse nell' UI di default).]=]
L[ [=[|cFFFFCC00*|r Simple filters are available for various mail types.
|cFFFFCC00*|r Shift-Click the Open All button to override the filters and take ALL mail.
|cFFFFCC00*|r OpenAll will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r OpenAll will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r Semplici filtri sono disponibili per vari tipi di lettere.
|cFFFFCC00*|r Shift-Click sul bottone Apri Tutto per non tener conto dei filtri e raccogliere TUTTE le lettere.
|cFFFFCC00*|r Apri Tutto non cancellerà mai nessuna lettera (le lettere senza testo saranno cancellate automaticamente dal gioco quando sono stati presi tutti gli allegati e i soldi).
|cFFFFCC00*|r Apri Tutto salterà tutte le lettere P.C. e le lettere da Blizzard.
|cFFFFCC00*|r Disabilita l'opzione Testuale per bloccare lo spam in chat durante l'apertura delle lettere]=]
L[ [=[|cFFFFCC00*|r This module will list your contacts, friends, guild mates, alts and track the last 10 people you mailed.
|cFFFFCC00*|r It will also autocomplete all names in your BlackBook.]=] ] = [=[|cFFFFCC00*|r Questo modulo elencherà i tuoi contatti, gli amici, i compagni di gilda, gli alts e le ultime 10 persone a cui avrai scritto.
|cFFFFCC00*|r Completerà anche automaticamente tutti i nomi presenti nella Lista.]=]
L["A button that collects all attachments and coins from mail."] = "Un pulsante che raccoglie tutti gli allegati e le monete dalle lettere."
L["Add check boxes to the inbox for multiple mail operations."] = "Aggiunge spunti per la posta in arrivo per operazioni di posta multipla."
L["Add Contact"] = "Aggiungi Contatto"
L["Add multiple item mail tooltips"] = "Aggiunge più voci alle informazioni nella lettera"
L["Adds a contact list next to the To: field."] = "Aggiunge una lista dei contatti vicino al campo A:"
L["AH-related mail"] = "Lettera relativa alla Casa d'Aste"
L["All Alts"] = "Tutti gli Alt"
L["Allows you to copy the contents of a mail."] = "Ti permette di copiare il contenuto di una lettera"
L["Alts"] = "Alts"
L["Auto-Attach similar items on Control-Click"] = "Allega in automatico oggetti simili con Control-Click"
L["Autofill last person mailed"] = "Completa automaticamente con l'ultima persona a cui hai scritto"
L["Auto-Send on Alt-Click"] = "Auto invia con Alt-Click"
L["BlackBook"] = "Lista Nera"
L["Block incoming trade requests while in a mail session."] = "Blocca le richieste di commercio mentre si stanno leggendo le lettere."
L["CarbonCopy"] = "Copia Carbone"
L["Chat Output"] = "Resoconto Chat"
L["Choose"] = "Scegli"
L["Clear list"] = "Pulisci lista"
L["Collected"] = "Raccolti"
L["Contacts"] = "Contatti"
L["Copy From"] = "Copia da"
L["Copy this mail"] = "Copia questa lettera"
L["Delete"] = "Cancella"
L["Disable Blizzard's auto-completion popup menu"] = "Disabilita il menù popup di auto-completamento della Blizzard"
L["DoNotWant"] = "Non-Lo-Voglio"
L["Enable Alt-Click to send mail"] = "Abilita Alt-Click per mandare le lettere"
L["Exclude randoms you interacted with"] = "Esculdi persone a caso con cui hai interagito"
L["Express"] = "Veloce"
L["Friends"] = "Amici"
L["Guild"] = "Gilda"
L["Help"] = "Aiuto"
L["In Progress"] = "In elaborazione"
L["Keep free space"] = "Mantieni uno spazio libero"
L["Mouse click short cuts for mail."] = "Tasti di scelta rapida per le lettere."
L["Name auto-completion options"] = "Opzioni di auto-completamento del nome"
L["New Profile"] = "Nuovo Profilo"
L["New Profile Name:"] = "Nome del Nuovo Profilo:"
L["Non-AH related mail"] = "Lettere non relative alla Casa d'Aste"
L["Not all messages are shown, refreshing mailbox soon to continue Open All..."] = "Non tutti i messaggi sono stati visualizzati, ricarica la casella postale per continuare ad aprire tutto"
L["Not taking more items as there are now only %d regular bagslots free."] = "Non prendo altri oggetti se ci sono solo %d posti liberi nelle borse"
L["Open"] = "Apri"
L["Open All"] = "Apri Tutto"
L["Open all Auction cancelled mail"] = "Apri tutte le lettere annullate della casa d'aste"
L["Open all Auction expired mail"] = "Apri tutte le lettere scadute della casa d'aste"
L["Open all Auction successful mail"] = "Apri tutte le lettere di successo della casa d'aste"
L["Open all Auction won mail"] = "Apri tutte le lettere di vincita della casa d'aste"
L["Open all mail with attachments"] = "Apri tutte le lettere con allegati"
L["Open all Outbid on mail"] = "Apri tutte le lettere di offerta superata"
L["Open mail from the Postmaster"] = "Apri tutte le lettere dal Postino"
L["OpenAll"] = "Apri-tutto"
L["Opening Speed"] = "Velocità d'apertura"
L["Other options"] = "Altre opzioni"
L["Part %d"] = "Parte %d"
L["Please post bugs or suggestions at the wowace forums thread at |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. When posting bugs, indicate your locale and Postal's version number v%s."] = "Per favore riporta bug o suggerimenti al thread del forum wowace |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. Quando riporti un bug, indica la localizzazione e la versione v%s di Postal."
L["Prints the amount of money collected during a mail session."] = "Scrivi l'ammontare di monete raccolte durante una sessione di posta"
L["Processing Message"] = "Messaggio in elaborazione"
L["Profile"] = "Profilo"
L["Rake"] = "Somma"
L["Recently Mailed"] = "Spedite Recentemente"
L["Refreshing mailbox..."] = "Ricaricamento casella postale"
L["Remove Contact"] = "Rimuovi Contatto"
L["Reset Profile"] = "Resetta il profilo"
L["Return"] = "Rimanda"
L["Select"] = "Seleziona"
L["Set subject field to value of coins sent if subject is blank."] = "Indica l'ammontare di monete mandate nel campo del soggetto se è lasciato bianco"
L["Shows a clickable visual icon as to whether a mail will be returned or deleted on expiry."] = "Mostra un'icona visiva cliccabile se una lettera verrà restituita o cancellata alla scadenza."
L["Skipping"] = "Saltare"
L["Some Messages May Have Been Skipped."] = "Alcuni messaggi potrebbero esser stati saltati."
L["Thaumaturge Vashreen"] = "Taumaturgo Vashreen"
L["The Postmaster"] = "Il Postino"
L["There are %i more messages not currently shown."] = "Ci sono più di %i messaggi non correntemente mostrati."
L["There are %i more messages not currently shown. More should become available in %i seconds."] = "Ci sono più di %i messaggi non correntemente mostrati. Altri saranno visibili in %i secondi."
L["TradeBlock"] = "Blocca Scambio"
L["Use Mr.Plow after opening"] = "Usa Mr.Plow dopo aver aperto"
L["Use Postal's auto-complete"] = "Usa l'auto-completamento di Postal"
L["Verbose mode"] = "Modalità Testuale"
L["Wire"] = "telegramma"
