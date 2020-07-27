--[[
 Skillet: A tradeskill window replacement.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]--

local L = LibStub("AceLocale-3.0"):NewLocale("Skillet", "itIT")
if not L then return end

L[" days"] = " giorni"
L["About"] = "Riguardo a"
L["ABOUTDESC"] = "Stampa le informazioni riguardo a Skillet"
--[[Translation missing --]]
--[[ L["Add Recipe to Ignored List"] = ""--]] 
L["Add to Ignore Materials"] = true
L["alts"] = true
L["Appearance"] = "Aspetto"
L["APPEARANCEDESC"] = "Le opzioni che controllano come Skillet viene mostrato"
L["bank"] = "banca"
L["Blizzard"] = "Tempesta"
L["Buy Reagents"] = "Compra Reagenti"
L["buyable"] = "comprabile"
L["Buyout"] = true
L["By Difficulty"] = "Per Difficolta'"
L["By Item Level"] = "Per Livello Oggetto"
L["By Level"] = "Per Livello"
L["By Name"] = "Per Nome"
L["By Quality"] = "Per Qualita'"
L["By Skill Level"] = "Per Livello Abilita'"
L["can be created by crafting reagents"] = true
L["can be created from reagents in your inventory"] = "puo' essere creato con i reagenti presenti nel tuo inventario"
--[[Translation missing --]]
--[[ L["can be created from reagents on all characters"] = ""--]] 
L["can be created from reagents on other characters"] = "puo' essere creato con i reagenti presenti su tutti i tuoi personaggi"
L["can be created with reagents bought at vendor"] = true
--[[Translation missing --]]
--[[ L["Changing profession to"] = ""--]] 
L["Clear"] = "Pulisci"
--[[Translation missing --]]
--[[ L["Click"] = ""--]] 
L["click here to add a note"] = "premere qui per aggiungere una nota"
L["Click to toggle favorite"] = true
L["Collapse all groups"] = "Collassa tutti i gruppi"
L["Config"] = "Configura"
L["CONFIGDESC"] = "Apre la finestra di configurazione di Skillet"
L["CONFIRMQUEUECLEARDESC"] = "Use Alt-left-click instead of left-click to clear the queue"
L["CONFIRMQUEUECLEARNAME"] = "Use Alt-click to clear queue"
--[[Translation missing --]]
--[[ L["Conflict with the addon TradeSkillMaster"] = ""--]] 
L["Copy"] = true
L["Could not find bag space for"] = "Non trovo spazio nell borse per"
L["craftable"] = "crabile"
--[[Translation missing --]]
--[[ L["CRAFTBUTTONSDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["CRAFTBUTTONSNAME"] = ""--]] 
L["Crafted By"] = "Crato da"
L["Create"] = "Crea"
L["Create All"] = "Crea Tutti"
L["Cut"] = true
L["DBMarket"] = true
L["Delete"] = "Cancella"
--[[Translation missing --]]
--[[ L["DISPLAYITEMLEVELDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["DISPLAYITEMLEVELNAME"] = ""--]] 
L["DISPLAYREQUIREDLEVELDESC"] = "Se l'oggetto creato richiede un livello minimo per essere usato, questo livello viene mostrato a fianco della ricetta"
L["DISPLAYREQUIREDLEVELNAME"] = "Mostra livello richiesto"
L["DISPLAYSHOPPINGLISTATAUCTIONDESC"] = "Mostra una lista della spesa per gli oggetti richiesti, ma non presenti nelle borse, per creare le ricette accodate"
L["DISPLAYSHOPPINGLISTATAUCTIONNAME"] = "Mostra lista della spesa alla casa d'aste"
L["DISPLAYSHOPPINGLISTATBANKDESC"] = "Mostra una lista della spesa per gli oggetti richiesti, ma non presenti nelle borse, per creare le ricette accodate"
L["DISPLAYSHOPPINGLISTATBANKNAME"] = "Mostra una lista della spesa alla banca"
L["DISPLAYSHOPPINGLISTATGUILDBANKDESC"] = "Mostra una lista della spesa per gli oggetti richiesti, ma non presenti nelle borse, per creare le ricette accodate"
L["DISPLAYSHOPPINGLISTATGUILDBANKNAME"] = "Mostra una lista della spesa alla banca di gilda"
L["DISPLAYSHOPPINGLISTATMERCHANTDESC"] = "Display a shopping list of the items that are needed to craft queued recipes but are not in your bags"
L["DISPLAYSHOPPINGLISTATMERCHANTNAME"] = "Display Shopping List at Merchants"
L["Draenor Engineering"] = true
L["Empty Group"] = true
L["Enabled"] = "Attivato"
L["Enchant"] = "Incantamento"
L["ENHANCHEDRECIPEDISPLAYDESC"] = "Quando abilitato, le ricette avranno uno o piu' '+' per indicarne la difficolta'."
L["ENHANCHEDRECIPEDISPLAYNAME"] = "Mostra la difficolta' delle ricette come testo"
L["Expand all groups"] = "Espandi tutti i gruppi"
L["Features"] = "Caratteristiche"
L["FEATURESDESC"] = "Comportamenti opzionali che possono essere attivati o disattivati"
L["Filter"] = "Filtro"
--[[Translation missing --]]
--[[ L["Flat"] = ""--]] 
L["Flush All Data"] = true
L["Flush Recipe Data"] = true
L["FLUSHALLDATADESC"] = "Flush all Skillet data"
L["FLUSHRECIPEDATADESC"] = "Flush Skillet recipe data"
L["From Selection"] = true
L["Glyph "] = "Glifo"
L["Gold earned"] = "Oro guadagnato"
L["Grouping"] = "Raggruppamento"
L["has cooldown of"] = true
L["have"] = "hanno"
L["Hide trivial"] = "Nascondi Banali"
L["Hide uncraftable"] = "Nascondi non creabili"
--[[Translation missing --]]
--[[ L["HIDEBLIZZARDFRAMEDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["HIDEBLIZZARDFRAMENAME"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ignore"] = ""--]] 
L["IGNORECLEARDESC"] = "Clear all entries from the Ignored Materials list."
L["Ignored List"] = true
L["Ignored Materials Clear"] = true
L["Ignored Materials List"] = true
L["IGNORELISTDESC"] = "Open the Ignored Materials list frame."
L["Illusions"] = true
L["in your inventory"] = true
L["Include alts"] = "Includi alt"
L["Include bank"] = true
L["Include guild"] = "Include gilda"
--[[Translation missing --]]
--[[ L["INCLUDEREAGENTSDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["INCLUDEREAGENTSNAME"] = ""--]] 
L["Inventory"] = "Inventario"
L["INVENTORYDESC"] = "Informazioni dell'Inventario"
--[[Translation missing --]]
--[[ L["InvSlot"] = ""--]] 
L["is now disabled"] = "e' ora disabilitato"
L["is now enabled"] = "e' ora abiltiato"
L["Learned"] = true
L["Library"] = "Libreria"
L["Link Recipe"] = true
L["LINKCRAFTABLEREAGENTSDESC"] = "Se puoi creare un reagente necessario alla ricetta, cliccando il reagente ti portera' alla sua ricetta"
L["LINKCRAFTABLEREAGENTSNAME"] = "Rendi reagenti clickabili"
L["Load"] = "Carica"
--[[Translation missing --]]
--[[ L["Lock/Unlock"] = ""--]] 
L["Market"] = true
L["Merge items"] = "Unisce oggetti"
L["Move Down"] = "Muovi verso il basso"
L["Move to Bottom"] = "Muovi al fondo"
L["Move to Top"] = "Muovi all'inizio"
L["Move Up"] = "Muovi verso l'alto"
L["need"] = "necessario"
--[[Translation missing --]]
--[[ L["New"] = ""--]] 
L["New Group"] = true
L["No Data"] = "Nessun Dato"
--[[Translation missing --]]
--[[ L["No headers, try again"] = ""--]] 
L["No such queue saved"] = "Nessuna lista simile salvata"
L["None"] = "Nessuno"
L["not yet cached"] = "non ancora salvato"
L["Notes"] = "Note"
L["Number of items to queue/create"] = "Numero di oggetti da accodare/creare"
L["Options"] = "Opzioni"
L["Order by item"] = "Ordina per oggetto"
L["Paste"] = true
L["Pause"] = "Pausa"
L["Plugins"] = true
--[[Translation missing --]]
--[[ L["Press"] = ""--]] 
--[[Translation missing --]]
--[[ L["Press Okay to continue changing professions"] = ""--]] 
--[[Translation missing --]]
--[[ L["Press Process to continue"] = ""--]] 
L["Process"] = "Processo"
L["Purchased"] = "Comprato"
L["Queue"] = "Coda"
L["Queue All"] = "Accoda Tutti"
L["Queue is empty"] = "La coda e' vuota"
L["Queue is not empty. Overwrite?"] = "La coda non e' vuota. Sovrascrivere?"
L["Queue with this name already exsists. Overwrite?"] = "Una coda con questo nome esiste gia'. Sovrascrivere?"
L["QUEUECRAFTABLEREAGENTSDESC"] = "Se puoi creare il reagente per la ricetta corrente, e non ne hai a sufficenza, allora il reagente verra' aggiunto alla coda"
L["QUEUECRAFTABLEREAGENTSNAME"] = "Accoda reagenti creabili"
L["QUEUEGLYPHREAGENTSDESC"] = "Se puoi creare il reagente per la ricetta corrente, e non ne hai a sufficenza, allora il reagente verra' aggiunto alla coda. Questa opzione e' separata solo per i Glifi."
L["QUEUEGLYPHREAGENTSNAME"] = "Accoda reagenti per Glifi"
L["QUEUEONLYVIEWDESC"] = "Show Standalone Queue Window only when set, show both Standalone Queue Window and Skillet Window when clear."
L["QUEUEONLYVIEWNAME"] = "Only show Standalone Queue"
L["Queues"] = "Code"
--[[Translation missing --]]
--[[ L["reagent id seems corrupt!"] = ""--]] 
L["Reagents"] = "Reagenti"
L["reagents in inventory"] = "reagenti in inventario"
L["Really delete this queue?"] = "Vuoi cancellare veramente questa coda?"
L["Remove Favorite"] = true
--[[Translation missing --]]
--[[ L["Remove Recipe from Ignored List"] = ""--]] 
--[[Translation missing --]]
--[[ L["Rename"] = ""--]] 
L["Rename Group"] = true
L["Rescan"] = "Riscansiona"
L["Reset"] = "Comando di reimpostazione posizione"
L["Reset Recipe Filter"] = true
L["RESETDESC"] = "Descrizione del comando di reimpostazione posizione"
L["RESETRECIPEFILTERDESC"] = "Reset Recipe Filter"
L["Retrieve"] = "Recupera"
L["Same faction"] = true
L["Save"] = "Salva"
L["Scale"] = "Scala"
L["SCALEDESC"] = "Scala la finestra delle professioni (di base 1.0)"
--[[Translation missing --]]
--[[ L["SCALETOOLTIPDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SCALETOOLTIPNAME"] = ""--]] 
L["Scan completed"] = "Scansione Completa"
L["Scanning tradeskill"] = "Scansionamento Professioni"
L["Search"] = true
L["Select All"] = true
L["Select None"] = true
L["Select skill difficulty threshold"] = "Seleziona limite della difficolta' per le professioni"
L["Selected Addon"] = "Addon Selezionato"
L["Selection"] = true
L["Sells for "] = "Vendibile per "
L["Set Favorite"] = true
--[[Translation missing --]]
--[[ L["shift-click to link"] = ""--]] 
L["Shopping Clear"] = "Lista della Spesa pulita"
L["Shopping List"] = "Lista della Spesa"
L["SHOPPINGCLEARDESC"] = "Pulisci la Lista della Spesa"
L["SHOPPINGLISTDESC"] = "Mostra la lista della spesa"
L["Show favorite recipes only. Click on a star on the left side of a recipe to set favorite."] = true
L["SHOWBANKALTCOUNTSDESC"] = "Quando vengono calcolati e mostrati i conteggi per gli oggetti, includere quelli presenti in banca e su altri personaggi"
L["SHOWBANKALTCOUNTSNAME"] = "Includi banca e alt"
L["SHOWCRAFTCOUNTSDESC"] = "Mostra il numero di volte che puoi creare una ricetta, non il totale di oggetti producibili"
L["SHOWCRAFTCOUNTSNAME"] = "Mostra conteggio creabili"
L["SHOWCRAFTERSTOOLTIPDESC"] = "Mostra l'alt che e' in grado di creare l'oggetto nelle informazioni"
L["SHOWCRAFTERSTOOLTIPNAME"] = "Mostra creatori nelle informazioni"
L["SHOWDETAILEDRECIPETOOLTIPDESC"] = "Mostra un'informazione quando si passa sopra una ricetta"
L["SHOWDETAILEDRECIPETOOLTIPNAME"] = "Mostra informazioni per le ricette"
L["SHOWFULLTOOLTIPDESC"] = "Mostra tutte le informazioni su un oggetto che puo' essere creato. Se si disattiva questa opzione si vedranno solo informazioni compresse (tenere premuto Ctrl per mostrare le informazioni complete)"
L["SHOWFULLTOOLTIPNAME"] = "Usa informazioni di base"
L["SHOWITEMNOTESTOOLTIPDESC"] = "Aggiungi note pesonalizzate alle informazioni di un oggetto"
L["SHOWITEMNOTESTOOLTIPNAME"] = "Aggiungi note personalizzate alle informazioni"
L["SHOWITEMTOOLTIPDESC"] = "Mostra informazioni oggetto, invece che le informazioni ricetta."
L["SHOWITEMTOOLTIPNAME"] = "Mostra informazioni oggetto quando possibile"
L["SHOWMAXUPGRADEDESC"] = "When set, show upgradable recipes as \"(current/maximum)\". When not set, show as \"(current)\""
L["SHOWMAXUPGRADENAME"] = "Show upgradable recipes as (current/max)"
L["SHOWRECIPESOURCEFORLEARNEDDESC"] = "Show Recipe Source for Learned Recipes"
L["SHOWRECIPESOURCEFORLEARNEDNAME"] = "Show Recipe Source for Learned Recipes "
L["Skillet Trade Skills"] = "Skillet Abilità di Commercio"
L["Skipping"] = "Saltare"
L["Sold amount"] = "Ammontare di vendita"
L["SORTASC"] = "Elenca la lista ricette dal piu' alto al piu' basso"
L["SORTDESC"] = "Elenca la lista delle ricette dal piu' basso al piu' alto"
L["Sorting"] = "Riordinango"
L["Source:"] = "Sorgente:"
L["STANDBYDESC"] = "Scambia stato di attesa acceso/spento"
L["STANDBYNAME"] = "attesa"
L["Start"] = "Inizia"
--[[Translation missing --]]
--[[ L["SubClass"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUPPORTCRAFTINGDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUPPORTCRAFTINGNAME"] = ""--]] 
L["Supported Addons"] = "Addon Supportati"
L["SUPPORTEDADDONSDESC"] = "Addon supportati che possono o sono utilizzati per esaminare l'inventario"
L["This merchant sells reagents you need!"] = "Questo mercante vende i reagenti che ti servono!"
--[[Translation missing --]]
--[[ L["TOOLTIPSCALEDESC"] = ""--]] 
L["Total Cost:"] = "Costo totale:"
L["Total spent"] = "Totale speso"
--[[Translation missing --]]
--[[ L["TRADEBUTTONSDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["TRADEBUTTONSNAME"] = ""--]] 
L["Trained"] = "Allenato"
L["TRANSPARAENCYDESC"] = "Trasparenza della finestra principale"
L["Transparency"] = "Trasparenza"
L["Unknown"] = "Sconosciuto"
L["Unlearned"] = true
L["USEALTCURRVENDITEMSDESC"] = "Vendor items bought with alternate currencies are considered vendor supplied."
L["USEALTCURRVENDITEMSNAME"] = "Use vendor items bought with alternate currencies"
L["USEBLIZZARDFORFOLLOWERSDESC"] = "Use the Blizzard UI for garrison follower tradeskills"
L["USEBLIZZARDFORFOLLOWERSNAME"] = "Use Blizzard UI for followers"
L["USEGUILDBANKASALTDESC"] = "Use the contents of the guildbank as if it was another alternate."
L["USEGUILDBANKASALTNAME"] = "Use guildbank as another alt"
L["Using Bank for"] = true
L["Using Reagent Bank for"] = true
L["VENDORAUTOBUYDESC"] = "Se hai accodato ricette e parli con un mercante che vende qualdoca che ti serve per quelle ricette, verra' automaticamente acquistato."
L["VENDORAUTOBUYNAME"] = "Compra reagenti in automatico"
L["VENDORBUYBUTTONDESC"] = "Mostra un bottone quando parli ad un mercante che permette di comprare i reagenti necessari per le ricette accodate."
L["VENDORBUYBUTTONNAME"] = "Mostra pulsante dai mercanti"
L["View Crafters"] = "Mostra Creatori"

