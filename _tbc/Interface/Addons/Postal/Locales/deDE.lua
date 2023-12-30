local L = LibStub("AceLocale-3.0"):NewLocale("Postal", "deDE")
if not L then return end

L["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt-Klick|r, um diesen Gegenstand an %s zu senden."
L["|cffeda55fControl-Click|r to attach similar items."] = "|cffeda55fStrg-Klick|r, um ähnliche Gegenstände anzuhängen."
L["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fStrg-Klick|r, um diesen Gegenstand zurückzusenden."
L["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fShift-Klick|r, um die Gegenstände zu entnehmen."
L[ [=[|cFFFFCC00*|r Selected mail will be batch opened or returned to sender by clicking Open or Return.
|cFFFFCC00*|r You can Shift-Click 2 checkboxes to mass select every mail between the 2 checkboxes.
|cFFFFCC00*|r You can Ctrl-Click a checkbox to mass select or unselect every mail from that sender.
|cFFFFCC00*|r Select will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r Select will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r Ausgewählte Nachrichten werden alle geöffnet oder zurückgeschickt bei Klick auf Öffnen oder Zurückschicken.
|cFFFFCC00*|r Du kannst auf zwei Kontrollkästchen Shift-Klicken, um alle Nachrichten dazwischen auszuwählen.
|cFFFFCC00*|r Du kannst mit Strg-Klick auf ein Kontrollkästchen alle Nachrichten dieses Absenders aus- oder abwählen.
|cFFFFCC00*|r "Auswählen" löscht nie Nachrichten (Nachrichten ohne Text werden automatisch vom Spiel gelöscht, sobald alle angehängten Gegenstände oder Gold entnommen wurden).
|cFFFFCC00*|r "Auswählen" überspringt Nachnahmesendungen und Nachrichten von Blizzard.
|cFFFFCC00*|r Deaktiviere den ausführlichen Modus, um den Chatspam beim Öffnen von Post abzustellen.]=]
L[ [=[|cFFFFCC00*|r Shift-Click to take item/money from mail.
|cFFFFCC00*|r Ctrl-Click to return mail.
|cFFFFCC00*|r Alt-Click to move an item from your inventory to the current outgoing mail (same as right click in default UI).]=] ] = [=[|cFFFFCC00*|r Shift-Klick, um Gegenstände/Gold aus Nachrichten zu entnehmen.
|cFFFFCC00*|r Strg-Klick, um die Nachricht zurückzuschicken.
|cFFFFCC00*|r Alt-Klick, um einen Gegenstand aus dem Inventar an die ausgehende Nachricht anzuhängen (gleich dem Rechtsklick der Standard-UI).
|cFFFFCC00*|r Ermöglicht das Durchblättern des Postfachs mit dem Mausrad.]=]
L[ [=[|cFFFFCC00*|r Simple filters are available for various mail types.
|cFFFFCC00*|r Shift-Click the Open All button to override the filters and take ALL mail.
|cFFFFCC00*|r OpenAll will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r OpenAll will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r Einfache Filter sind für verschiedene Nachrichtstypen verfügbar.
|cFFFFCC00*|r Shift-Klick auf den Knopf ''Alle öffnen" ignoriert Filter und öffnet alle Nachrichten.
|cFFFFCC00*|r "Alle öffnen" löscht niemals Nachrichten (Nachrichten ohne Text werden automatisch vom Spiel gelöscht sobald alle angehängten Gegenstände oder Gold entnommen wurden).
|cFFFFCC00*|r "Alle öffnen" überspringt Nachnahmesendungen und Nachrichten von Blizzard.
|cFFFFCC00*|r Deaktiviere den ausführlichen Modus, um den Chatspam beim Öffnen von Post abzustellen.]=]
L[ [=[|cFFFFCC00*|r This module will list your contacts, friends, guild mates, alts and track the last 10 people you mailed.
|cFFFFCC00*|r It will also autocomplete all names in your BlackBook.]=] ] = [=[|cFFFFCC00*|r Dieses Modul zeigt eine Liste deiner Kontakte, Freunde, Gildenmitglieder und Alts und merkt sich die letzten 10 Empfänger gesendeter Nachrichten.
|cFFFFCC00*|r Außerdem vervollständigt es automatisch alle Namen in deinem schwarzen Buch.]=]
L["A button that collects all attachments and coins from mail."] = "Eine Taste, die alle Anhänge und Geld von Nachrichten entnimmt."
L["Add check boxes to the inbox for multiple mail operations."] = "Fügt dem Posteingang Kontrollkästchen für zusätzliche Bearbeitungsmöglichkeiten von Nachrichten hinzu."
L["Add Contact"] = "Kontakt hinzufügen"
L["Add multiple item mail tooltips"] = "Enthaltene Gegenstände den Nachrichtentooltips hinzufügen"
L["Adds a contact list next to the To: field."] = "Setzt eine Kontaktliste neben das Empfängerfeld."
L["AH-related mail"] = "Auktionshausnachrichten"
L["All Alts"] = "Alle Charaktere"
L["Allows you to copy the contents of a mail."] = "Erlaubt Dir, die Inhalte einer Nachricht zu kopieren."
L["Alts"] = "Twinks"
L["Auto-Attach similar items on Control-Click"] = "Automatisches Anhängen ähnlicher Gegenstände bei STRG-Klick"
L["Autofill last person mailed"] = "Namen der zuletzt angeschriebenen Person automatisch einfügen"
L["Auto-Send on Alt-Click"] = "Automatisches Senden per Alt-Klick"
L["BlackBook"] = "Schwarzes Buch"
L["Block incoming trade requests while in a mail session."] = "Blockt eingehende Handelsversuche von Spielern, solange der Briefkasten geöffnet ist."
L["CarbonCopy"] = "Kopie"
L["Chat Output"] = "Chatausgabe"
L["Choose"] = "Auswählen"
L["Clear list"] = "Liste leeren"
L["Collected"] = "Gesammelt"
L["Contacts"] = "Kontakte"
L["Copy From"] = "Kopieren von"
L["Copy this mail"] = "Diese Nachricht kopieren"
L["Delete"] = "Löschen"
L["Disable Blizzard's auto-completion popup menu"] = "Blizzards Auto-Vervollständigungs-Popup-Menü deaktivieren"
L["DoNotWant"] = "Unerwünscht-Taste"
L["Enable Alt-Click to send mail"] = "Alt-Klick aktivieren, um Nachrichten zu senden."
L["Exclude randoms you interacted with"] = "Zufallsspieler, mit denen Du Kontakt hattest, ausschließen"
L["Express"] = "Express"
L["Friends"] = "Freunde"
L["Guild"] = "Gilde"
L["Help"] = "Hilfe"
L["In Progress"] = "In Bearbeitung"
L["Keep free space"] = "Platz freihalten"
L["Mouse click short cuts for mail."] = "Mauskürzel für Nachrichten."
L["Name auto-completion options"] = "Optionen für automatische Namensvervollständigung"
L["New Profile"] = "Neues Profil"
L["New Profile Name:"] = "Neuer Profilname:"
L["Non-AH related mail"] = "Nicht-AH betreffende Nachricht"
L["Not all messages are shown, refreshing mailbox soon to continue Open All..."] = "Es werden nicht alle Nachrichten angezeigt, aktualisiere den Posteingang umgehend, um mit \"Alle öffnen\" fortzufahren."
L["Not taking more items as there are now only %d regular bagslots free."] = "Es werden keine weiteren Gegenstände angenommen, weil nur mehr %s reguläre Taschenplätze frei sind."
L["Open"] = "Öffnen"
L["Open All"] = "Alle öffnen"
L["Open all Auction cancelled mail"] = "Alle 'Auktion abgebrochen'-Nachrichten öffnen"
L["Open all Auction expired mail"] = "Alle 'Auktion abgelaufen'-Nachrichten öffnen"
L["Open all Auction successful mail"] = "Alle 'Auktion erfolgreich'-Nachrichten öffnen"
L["Open all Auction won mail"] = "Alle 'Auktion gewonnen'-Nachrichten öffnen"
L["Open all mail with attachments"] = "Alle Nachrichten mit Anhängen öffnen"
L["Open all Outbid on mail"] = "Alle 'Überboten'-Nachrichten öffnen"
L["Open mail from the Postmaster"] = "Nachrichten vom Postmeister öffnen"
L["OpenAll"] = "Alles öffnen"
L["Opening Speed"] = "Öffnungsgeschwindigkeit"
L["Other options"] = "Weitere Optionen"
L["Part %d"] = "Teil %d"
L["Please post bugs or suggestions at the wowace forums thread at |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. When posting bugs, indicate your locale and Postal's version number v%s."] = "Bitte melde Fehler oder Anregungen im Wowace-Forumsthread unter |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. Wenn du Fehler meldest, gebe bitte deine Sprache und Postals Versionsnummer v%s an."
L["Prints the amount of money collected during a mail session."] = "Gibt im Chat aus, wie viel Gold bei einer Nachrichtensitzung am Briefkasten entnommen wurde."
L["Processing Message"] = "Bearbeite Nachricht"
L["Profile"] = "Profil"
L["Rake"] = "Summieren"
L["Recently Mailed"] = "Kürzlich versendet"
L["Refreshing mailbox..."] = "Aktualisiere Posteingang..."
L["Remove Contact"] = "Kontakt entfernen"
L["Reset Profile"] = "Profil zurücksetzen"
L["Return"] = "Zurück"
L["Select"] = "Auswählen"
L["Set subject field to value of coins sent if subject is blank."] = "Setzt den Betreff auf die Menge des verschickten Goldes, falls der Betreff leer ist."
L["Shows a clickable visual icon as to whether a mail will be returned or deleted on expiry."] = "Zeigt ein anklickbares visuelles Symbol, ob eine Mail zurückgeschickt oder nach ihrem Ablauf gelöscht werden wird"
L["Skipping"] = "Überspringe"
L["Some Messages May Have Been Skipped."] = "Einige Nachrichten können ausgelassen worden sein."
L["Thaumaturge Vashreen"] = "Thaumaturg Vashreen"
L["The Postmaster"] = "Der Postmeister"
L["There are %i more messages not currently shown."] = "Es gibt %i weitere Nachrichten, die im Moment nicht angezeigt werden."
L["There are %i more messages not currently shown. More should become available in %i seconds."] = "Es gibt %i weitere Nachrichten, die im Moment nicht angezeigt werden. Weitere sollten in %i Sekunden verfügbar sein."
L["TradeBlock"] = "Handelsblock"
L["Use Mr.Plow after opening"] = "Mr.Plow (Zusatzaddon) nach dem Öffnen verwenden"
L["Use Postal's auto-complete"] = "Postals automatische Vervollständigung verwenden"
L["Verbose mode"] = "Ausführlicher Modus"
L["Wire"] = "Geldbetrag im Betreff"
