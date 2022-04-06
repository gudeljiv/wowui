-- scope stuff
gearquipper = gearquipper or {};
gearquipper.localizations["deDE"] = gearquipper.localizations["deDE"] or {};

-- keys
local L = gearquipper.localizations["deDE"];

L["AddOn loaded: Version: %s. Type /gq for options."]                                                   = "AddOn geladen: Version %s. Tippe /gq für Optionen.";
L["yes"]                                                                                                = "ja";
L["no"]                                                                                                 = "nein";
L["Yes"]                                                                                                = "Ja";
L["No"]                                                                                                 = "Nein";
L["default"]                                                                                            = "Standard";
L["Enter a name for this set:"]                                                                         = "Gib einen Namen für dieses Set ein:";
L["Switch to set:"]                                                                                     = "Zu Set wechseln:";
L["Add set..."]                                                                                         = "Set hinzufügen...";
L["Remove set"]                                                                                         = "Set löschen";
L["Apply"]                                                                                              = "Annehmen";
L["Cancel"]                                                                                             = "Abbrechen";
L["Do you really want to delete \"%s\"?"]                                                               = "Willst Du \"%s\" wirklich löschen?";
L["Switching interrupted by combat. It will be re-attempted once combat is over."]                      = "Set-Wechsel wurde durch einen Kampf unterbrochen. Es wird noch einmal versucht, sobald der Kampf vorüber ist.";
L["Unknown command. Possible parameters are: /gq ..."]                                                  = "Unbekannter Befehl. Mögliche Befehle sind: /gq ...";
L["The AddOn has not been initialized due to an error. Please relog and try again."]                    = "Das AddOn wurde aufgrund eines Fehlers nicht initialisiert. Bitte logge dich neu ein und versuche es erneut.";
L["reset -> Resets the GearQuipper addon (e.g. in case of errors)."]                                    = "reset -> Setzt GearQuipper zurück (z.B. wenn Fehler auftreten).";
L["Reset"]                                                                                              = "Zurücksetzen";
L["This will reset GearQuipper to defaults. All your sets will be lost.\n\nAre you sure?"]              = "Dies wird GearQuipper auf Werkseinstellungen zurücksetzen. Alle deine Sets werden gelöscht.\n\nBist du sicher?";
L["Current set"]                                                                                        = "Aktuelles Set";
L["Visit https://www.curseforge.com/wow/addons/gearquipper for support, feedback and updates."]         = "Besuche https://www.curseforge.com/wow/addons/gearquipper für Support, Feedback und Updates."
L["switch [setname1] [setname2] ... -> Switches between specified sets. See Curseforge page for macro examples."] = "switch [setname1] [setname2] ... -> Wechselt zwischen den angegebenen Sets. Für Makro-Nutzung.";
L["Macro warning: There is no set named \"%s\"."]                                                       = "Makro-Warnung: Es gibt kein Set namens \"%s\".";

L["Empty"]                                                                                              = "Leer";
L["<%s> Saved slot %s (%s): %s"]                                                                        = "<%s> Slot %s (%s) gespeichert: %s";
L["<%s> Saved action slot %s: %s"]                                                                      = "<%s> Action-Slot %s gespeichert: %s";
L["Macro \"%s\""]                                                                                       = "Makro \"%s\"";
L["Combat ended. Switch to set \"%s\" complete."]                                                       = "Kampf beendet. Wechsel zu Set \"%s\" abgeschlossen.";
L["Confirm changes in chat"]                                                                            = "Änderungen im Chat bestätigen";
L["Reset GearQuipper"]                                                                                  = "GearQuipper zurücksetzen";
L["Highlight switched slots"]                                                                           = "Gewechselte Slots hervorheben";
L["|cffff0000Expected Item:|r %s"]                                                                      = "|cffff0000Erwartetes Item:|r %s";
L["Not enough bag space. Switching aborted."]                                                           = "Nicht genug Platz in den Taschen. Set-Wechsel abgebrochen.";
L["Not enough bag space. Current space: %s, needed: %s"]                                                = "Nicht genug Platz in den Taschen. Freier Platz: %s, benötigt: %s";
L["None"]                                                                                               = "Keine";
L["Save set"]                                                                                           = "Set speichern";
L["Saved helmet visibility:"]                                                                           = "Helm-Sichtbarkeit gespeichert:";
L["Saved cloak visibility:"]                                                                            = "Umhang-Sichtbarkeit gespeichert:";
L["visible"]                                                                                            = "sichtbar";
L["not visible"]                                                                                        = "nicht sichtbar";
L["on mount"]                                                                                           = "beim mounten";
L["on dismount"]                                                                                        = "beim dismounten";
L["on entering stealth"]                                                                                = "Verstohlenheit ein";
L["on leaving stealth"]                                                                                 = "Verstohlenheit aus";
L["Saved event:"]                                                                                       = "Event gespeichert:";
L["[Previous set]"]                                                                                     = "[vorheriges Set]";
L["Invalid set name: \"%s\". Set names must [1] not be empty, [2] be unique (case insensitive) and [3] not contain \"$\" (reserved)."] = "Ungültiger Set-Name: \"%s\". Set-Namen müssen [1] nicht leer sein, [2] einzigartig sein (ignoriert Groß-/Kleinschreibung) und [3] dürfen nicht \"$\" enthalten (reserviert).";
L["Preferences"]                                                                                        = "Einstellungen";

L["Removed event:"]                                                                                     = "Event gelöscht:";
L["<%s> Saved slot state for %s (%s): %s"]                                                              = "<%s> Slot-Status für %s (%s) gespeichert: %s";
L["active"]                                                                                             = "aktiv";
L["not active"]                                                                                         = "nicht aktiv";
L["Always"]                                                                                             = "Immer";
L["Character menu open"]                                                                                = "Charakter-Menü offen";
L["GearQuipper menu open"]                                                                              = "GearQuipper-Menü offen";
L["Save/Load action slots with your sets"]                                                              = "Action-Slots mit deinen Sets laden/speichern";
L["Enable partial sets"]                                                                                = "Aktiviere partielle Sets";
L["Update to version %s complete."]                                                                     = "Update auf Version %s komplett.";
L["partial"]                                                                                            = "partiell";
L["Show \"current set\" label"]                                                                         = "Zeige \"Aktuelles Set\"-Label";
L["Set \"%s\" has been saved."]                                                                         = "Set \"%s\" wurde gespeichert.";
L["Partial"]                                                                                            = "Partiell";
L["Affects action slots"]                                                                               = "Betrifft Action-Slots";
L["Your current action configuration differs from \"%s\".\n\nClick \"Save\" to replace the action slots saved in \"%s\" with your current ones\n\nor\n\nClick \"Load\" to replace your current action slots by the actions saved in \"%s\"."] = "Deine Action-Bars weichen ab von denen in \"%s\".\n\nKlicke \"Speichern\", um die Action-Slots in \"%s\" durch deine aktuellen zu ersetzen\n\noder\n\nKlicke \"Laden\", um deine aktuellen Action-Slots durch diese zu ersetzen, die in \"%s\" gespeichert sind.";
L["Save"]                                                                                               = "Speichern";
L["Load"]                                                                                               = "Laden";
L["on < choose event >"]                                                                                = "wenn < Event wählen >";
L["< choose set >"]                                                                                     = "< Set wählen >";
L["< choose zone >"]                                                                                    = "< Zone wählen >";
L["< subzone (optional) >"]                                                                             = "< Subzone (optional) >";
L["... equip set:"]                                                                                     = "... rüste Set aus:";
L["This event already exists."]                                                                         = "Dieses Event gibt es bereits.";
L["Add event..."]                                                                                       = "Event hinzufügen...";
L["Remove event"]                                                                                       = "Event löschen";
L["GearQuipper - New event binding"]                                                                    = "GearQuipper - Neue Event-Bindung";
L["on joining party"]                                                                                   = "Party-Beitritt";
L["on leaving party"]                                                                                   = "Party verlassen";
L["on joining raid"]                                                                                    = "Raid-Beitritt";
L["on leaving raid"]                                                                                    = "Raid verlassen";
L["on entering battleground"]                                                                           = "BG-Beitritt";
L["on leaving battleground"]                                                                            = "BG verlassen";
L["on entering zone"]                                                                                   = "Zone betreten";
L["on leaving zone"]                                                                                    = "Zone verlassen";
L["on enabling PvP"]                                                                                    = "PvP aktiviert";
L["on disabling PvP"]                                                                                   = "PvP deaktiviert";
L["on enabling AFK"]                                                                                    = "AFK aktiviert";
L["on disabling AFK"]                                                                                   = "AFK deaktiviert";
L["in PvE situations"]                                                                                  = "in PvE-Situationen";
L["in PvP situations"]                                                                                  = "in PvP-Situationen";
L["on spell start"]                                                                                     = "Zauber (Start)";
L["on spell succeed"]                                                                                   = "Zauber (Erfolg)";
L["on submerge (water)"]                                                                                = "beim Abtauchen";
L["on emerge (water)"]                                                                                  = "beim Auftauchen";
L["Never"]                                                                                              = "Niemals";

L["Maximum search results (%s) exceeded."]                                                              = "Maximale Suchtreffer (%s) überschritten.";
L["GearQuipper set(s):"]                                                                                = "GearQuipper Set(s):";
L["Disable events"]                                                                                     = "Events deaktivieren";
L["Show item tooltips"]                                                                                 = "Zeige Ausrüstungs-Tooltips"
L["[Previous equipment]"]                                                                               = "[vorherige Ausrüstung]";
L["-> Bank"]                                                                                            = "-> Bank";
L["-> Bag"]                                                                                             = "-> Rucks.";

L["Features"]                                                                                           = "Funktionen";
L["Visual Settings"]                                                                                    = "Visuelle Einstellungen";
L["Ignore manually switched items for the next event triggered set switch"]                             = "Ignoriere manuell gewechselte Ausrüstung beim nächsten durch ein Event ausgelösten Setwechsel";

L["Not enough bank space to push \"%s\" to bank. Free: %s, needed: %s."]                                = "Nicht genug Platz in der Bank, um \"%s\" einzulagern. Frei: %s, benötigt: %s.";
L["Not enough bag space to pull \"%s\" from bank. Free: %s, needed: %s."]                               = "Nicht genug Platz in den Taschen, um \"%s\" zu tragen. Frei: %s, benötigt: %s.";
L["save [setname] -> Saves the specified set or the current set if omitted."]                           = "save [setname] -> Speichert das angegebene Set oder das aktuelle Set, wenn keines angegeben wurde.";
L["Switch to \"%s\" queued."]                                                                           = "Wechsel zu \"%s\" eingereiht.";

L["custom script"]                                                                                      = "eigenes Script";
L["Your Scripts"]                                                                                       = "Deine Scripts";
L["Current Script Name:"]                                                                               = "Aktueller Script-Name:";
L["Script Text"]                                                                                        = "Script-Text";
L["New Script %s"]                                                                                      = "Neues Script %s";
L["Invalid script name: At least 4 charaters."]                                                         = "Ungültiger Script-Name: Mindestens 4 Buchstaben.";
L["Script saved: %s"]                                                                                   = "Script gespeichert: %s";
L["New Script"]                                                                                         = "Neues Script";
L["Delete Script"]                                                                                      = "Script löschen";
L["Test Script"]                                                                                        = "Script testen";
L["Save Script"]                                                                                        = "Script speichern";
L["Start testing script..."]                                                                            = "Starte Script-Test...";
L["Script test finished without errors."]                                                               = "Script-Test ohne Fehler abgeschlossen.";
L["Warning! You did not save your script.\n\nWe could not prevent Blizzard from closing the window, but we can still save your script for you.\n\nDo you want to save your script \"%s\" now?"] = "Achtung! Du hast Dein Script nicht gespeichert.\n\nWir konnten Blizzard nicht davon abhalten, das Fenster zu schlißen, aber wir können Dein Script immer noch für Dich speichern.\n\nWillst Du Dein Script \"%s\" jetzt speichern?";
L["Please select a script or create a new one using the button below."]                                 = "Bitte wähle ein Script aus oder\nerstelle ein neues Script mit dem Button unten links.";
L["Error in script: \n%s"]                                                                              = "Fehler in Script: \n%s"
L["< choose script >"]                                                                                  = "< Script wählen >";
L["Status: %s"]                                                                                         = "Status: %s";
L["OK"]                                                                                                 = "OK";
L["Not OK"]                                                                                             = "Nicht OK";
L["Loading user scripts:"]                                                                              = "Lade Nutzer-Scripte:";
L["Finished loading user scripts."]                                                                     = "Laden von Nutzer-Scripten abgeschlossen.";
L["Loading \"%s\"..."]                                                                                  = "Lade \"%s\"...";
L["Skipping \"%s\", because there is no script text."]                                                  = "Überspringe \"%s\", weil der Skript-Text leer ist.";

L["Script Editor (EXPERIMENTAL!)"]                                                                      = "Script Editor (EXPERIMENTAL!)";
L["on enter combat"]                                                                                    = "Kampf betreten";
L["on leave combat"]                                                                                    = "Kampf verlassen";
L["Queue/combat chat notifications"]                                                                    = "Chat-Benachrichtigungen für Set-Warteschlange (Kampf etc.)";
L["Experimental Features"]                                                                              = "Experimentelle Funktionen";
L["Enable script editor (Beware: Might crash the addon or the game! Needs relog.)"]                     = "Skript-Editor aktivieren (Achtung: Kann Addon oder Spiel zum Absturz bringen! Benötigt Relog.)";

L["Show slot background colors"]                                                                        = "Zeige Slot-Hintergrundfarben";
L["Debug mode enabled. Type '/gq debug' or relog/reload to disable."]                                   = "Debug-Modus aktiv. Tippe '/gq debug' oder logge dich neu ein, um ihn zu deaktivieren.";
L["Debug mode disabled."]                                                                               = "Debug-Modus verlassen.";

L["Data broker initialized."]                                                                           = "Data broker initialisiert.";
L["%s will switch to %s %s"]                                                                            = "%s wird zu %s wechseln %s";
L["Active event bindings:"]                                                                             = "Aktive Event-Bindungen:";
L["Event bindings disabled."]                                                                           = "Event-Bindungen deaktiviert.";
L["Current set: %s"]                                                                                    = "Aktuelles Set: %s";
L["Unknown"]                                                                                            = "Unbekannt";
L["- Currently Switching -"]                                                                            = "- Wechselt gerade das Set -";
L["Switch set to:"]                                                                                     = "Set wechseln zu:";
L["Show data broker tooltip"]                                                                           = "Zeige Tooltip für Data-Broker";

L["toggleevents -> Toggles event bindings enabled or disabled."]                                        = "toggleevents -> Schaltet Eventbindungen ein oder aus.";
L["Event bindings %s."]                                                                                 = "Eventbindungen %s.";
L["enabled"]                                                                                            = "eingeschaltet";
L["disabled"]                                                                                           = "ausgeschaltet";

L["%s could not be pushed to bank."]                                                                    = "%s konnte nicht erfolgreich eingelagert werden.";
L["%s could not be pulled from bank."]                                                                  = "%s konnte nicht erfolgreich ausgelagert werden.";

L["Action finished. Switch to set \"%s\" complete."]                                                    = "Aktion beendet. Wechsel zu Set \"%s\" abgeschlossen.";
L["Switching interrupted by action. It will be re-attempted once the action is finished."]              = "Set-Wechsel wurde durch eine Aktion unterbrochen. Es wird noch einmal versucht, sobald die Aktion abgeschlossen ist.";
L["Missing Items: %s"]                                                                                  = "Fehlende Gegenstände: %s";
L["Expected Item:"]                                                                                     = "Erwarteter Gegenstand:";

L["Automatically uprank spells on your sets' action bars"]                                              = "Action-Slots automatisch auf neue Zauber-Ränge hochstufen"
L["Uprank from any rank (will uprank any lower rank to max rank)"]                                      = "Hochstufen aller Ränge (stuft jeden niedrigeren Rang auf den maximalen Rang hoch)"
L["Spell database updated."]                                                                            = "Zauber-Datenbank aktualisiert.";

L["Affects helmet visibility:"]                                                                         = "Betrifft Helm-Sichtbarkeit:";
L["Affects cloak visibility:"]                                                                          = "Betrifft Umhang-Sichtbarkeit:";

L["Save gear when:"]                                                                                    = "Ausrüstung speichern wenn:";
L["Save action slots when:"]                                                                            = "Action-Slots speichern wenn:";

L["on shapeshift (enter)"]                                                                              = "Gestaltwandeln"
L["on shapeshift (leave)"]                                                                              = "Gestalt verlassen"
L["< choose form >"]                                                                                    = "< Gestalt wählen >";
L["on aura change"]                                                                                     = "Aurawechsel";
L["< none >"]                                                                                           = "< keine >";
L["< choose aura >"]                                                                                    = "< Aura wählen >";

L["Deprecated event"]                                                                                   = "Veraltetes Event";
L["Replace me!"]                                                                                        = "Ersetze mich!";

L["Options"]                                                                                            = "Optionen";

L["Set \"%s\" was incompletely pushed to bank."]                                                        = "Set \"%s\" unvollständig eingelagert.";
L["Set \"%s\" was incompletely pulled from bank."]                                                      = "Set \"%s\" unvollständig ausgelagert.";

L["Set switch delay: %sms"]                                                                             = "Setwechsel-Verzögerung: %sms";
L["(Increase if you experience issues with\n automated event switches)"]                                = "(Erhöhen, wenn Probleme mit event-\nautomatisierten Setwechseln auftreten)"

L["on stance change"]                                                                                   = "Haltungsswechsel";
L["< choose stance >"]                                                                                  = "< Haltung wählen >";

L["AddOn reset complete."]                                                                              = "AddOn-Reset abgeschlossen.";