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

local L = LibStub("AceLocale-3.0"):NewLocale("Skillet", "esES")
if not L then return end

L[" days"] = "días (acento)"
L["About"] = "Acerca de"
L["ABOUTDESC"] = "Imprime información acerca de Skillet"
--[[Translation missing --]]
L["Add Recipe to Ignored List"] = "Add Recipe to Ignored List"
L["Add to Ignore Materials"] = "Añadir a Materiales ignorados"
L["alts"] = "Alter"
L["Appearance"] = "Apariencia"
L["APPEARANCEDESC"] = "\"Opciones que controlan como Skillet es mostrado\" apariencia descendente"
L["bank"] = "banco"
L["Blizzard"] = "Blizzard (tormenta de hielo, si no es la marca del juego)"
L["Buy Reagents"] = "Comprar materiales"
L["buyable"] = "comprable"
L["Buyout"] = "precio de compra en subasta, Precio final"
L["By Difficulty"] = "Por Dificultad"
L["By Item Level"] = "Por Nivel del Objeto"
L["By Level"] = "Por Nivel"
L["By Name"] = "Por Nombre"
L["By Quality"] = "Por Calidad"
L["By Skill Level"] = "Por Nivel de Habilidad"
L["can be created by crafting reagents"] = "Puede ser creado por materiales creados"
L["can be created from reagents in your inventory"] = "puede ser creado con los reactivos de tu inventario"
--[[Translation missing --]]
L["can be created from reagents on all characters"] = "can be created from reagents on all characters"
L["can be created from reagents on other characters"] = "puede ser creado con los materiales de todos tus caracteres"
L["can be created with reagents bought at vendor"] = "puede ser creado con materiales comprados al vendedor"
--[[Translation missing --]]
L["Changing profession to"] = "Changing profession to"
L["Clear"] = "Limpiar"
--[[Translation missing --]]
L["Click"] = "Click"
L["click here to add a note"] = "Click aquí para añadir una nota"
L["Click to toggle favorite"] = "click para intercambiar favoritos"
L["Collapse all groups"] = "Contraer todos los grupos"
L["Config"] = "Configuración"
L["CONFIGDESC"] = "\"Abre una ventana de configuración para Skillet \" configuracion  descendente"
L["CONFIRMQUEUECLEARDESC"] = "Usa Alt Click Izq en vez de click Izquierdo para limpiar la cola de la lista"
L["CONFIRMQUEUECLEARNAME"] = "usa Alt click para limpiar la cola de la lista"
--[[Translation missing --]]
L["Conflict with the addon TradeSkillMaster"] = "Conflict with the addon TradeSkillMaster"
L["Copy"] = "copia"
L["Could not find bag space for"] = "No puedo encontrar un espacio en la bolsa para"
L["craftable"] = "Manufacturable"
--[[Translation missing --]]
L["CRAFTBUTTONSDESC"] = "Include Craft buttons in frame"
--[[Translation missing --]]
L["CRAFTBUTTONSNAME"] = "Include Craft buttons"
L["Crafted By"] = "Manufacturado por"
L["Create"] = [=[Crea
]=]
L["Create All"] = "Crear Todo"
L["Cut"] = "corta el objeto del grupo"
L["DBMarket"] = "Data base Mercado \"DBMARKET\""
L["Delete"] = "Borrar"
--[[Translation missing --]]
L["DISPLAYITEMLEVELDESC"] = "If the item to be crafted has an item level, that level will be displayed along with the recipe"
--[[Translation missing --]]
L["DISPLAYITEMLEVELNAME"] = "Display item level"
L["DISPLAYREQUIREDLEVELDESC"] = "Si el elemento fabricado requiere un nivel mínimo para utilizar, este nivel será mostrado con la receta"
L["DISPLAYREQUIREDLEVELNAME"] = "Mostrar nivel necesario"
L["DISPLAYSHOPPINGLISTATAUCTIONDESC"] = "Mostrar una Lista de la Compra de los objetos que son necesarios para fabricar recetas encoladas pero que no están en tus bolsas"
L["DISPLAYSHOPPINGLISTATAUCTIONNAME"] = "Mostrar Lista de la Compra en la Subasta"
L["DISPLAYSHOPPINGLISTATBANKDESC"] = "Mostrar una Lista de la Compra de los elementos que son necesarios para fabricar recetas encoladas pero que no están en tus bolsas"
L["DISPLAYSHOPPINGLISTATBANKNAME"] = "Mostrar Lista de la Compra en los Bancos"
L["DISPLAYSHOPPINGLISTATGUILDBANKDESC"] = "Muestra una lista de compra de Objetos que son necesarios para manufacturar las recetas encoladaspe ro no estan en bolsas"
L["DISPLAYSHOPPINGLISTATGUILDBANKNAME"] = "Muestra lista de compra en Banco de Hermandad"
L["DISPLAYSHOPPINGLISTATMERCHANTDESC"] = "muestra la lista de la compra de objetos que son necesarios para crear la lista de recetas pero que no están  en tu bolsa"
L["DISPLAYSHOPPINGLISTATMERCHANTNAME"] = "muestra la lista de la compra en los Vendedores"
L["Draenor Engineering"] = "Ingeniería de Draenor"
L["Empty Group"] = [=[Grupo vacío
]=]
L["Enabled"] = "Habilitado"
L["Enchant"] = "Encantar"
L["ENHANCHEDRECIPEDISPLAYDESC"] = "Cuando activo, nombres de las recetas tendrán uno o más caracteres '+' añadido a su nombre para indicar la dificultad de la receta."
L["ENHANCHEDRECIPEDISPLAYNAME"] = "Mostrar la dificultad de la receta como texto"
L["Expand all groups"] = "Expandir todos los grupos"
L["Features"] = "Características"
L["FEATURESDESC"] = "Comportamiento opcional que puede activarse y desactivarse"
L["Filter"] = "Filtro"
--[[Translation missing --]]
L["Flat"] = "Flat"
L["Flush All Data"] = "Limpiar todos los datos"
L["Flush Recipe Data"] = "Limpiar datos de recetas"
L["FLUSHALLDATADESC"] = [=[Limpiar todos los datos de Skillet
]=]
L["FLUSHRECIPEDATADESC"] = "Limpiar los datos de las recetas de skillet"
L["From Selection"] = [=[De la selección
]=]
L["Glyph "] = "Glifo "
L["Gold earned"] = "Oro ganado"
L["Grouping"] = "Agrupando"
L["has cooldown of"] = "Tiene un tiempo de reutilización de"
L["have"] = "Tiene"
L["Hide trivial"] = "Ocultar Triviales"
L["Hide uncraftable"] = "Ocultar Imposibles de Crear"
--[[Translation missing --]]
L["HIDEBLIZZARDFRAMEDESC"] = "Hide Blizzard TradeSkill frame when showing Skillet frame"
--[[Translation missing --]]
L["HIDEBLIZZARDFRAMENAME"] = "Hide Blizzard Frame"
--[[Translation missing --]]
L["Ignore"] = "Ignore"
L["IGNORECLEARDESC"] = "Quitar todas las entradas de la lista de Materiales Ignorados"
L["Ignored List"] = "Lista de Ignorados"
L["Ignored Materials Clear"] = "quitar Materiales ignorados "
L["Ignored Materials List"] = [=[Lista de materiales ignorados
]=]
L["IGNORELISTDESC"] = "Abrir el marco de la lista de Materiales ignorados"
L["Illusions"] = "Ilusiones not sure what it is"
L["in your inventory"] = "En tu inventario"
L["Include alts"] = "Incluir Alts"
L["Include bank"] = "Incluir banco"
L["Include guild"] = "Incluir Hermandad"
--[[Translation missing --]]
L["INCLUDEREAGENTSDESC"] = "Add reagent names to the item text that is searched."
--[[Translation missing --]]
L["INCLUDEREAGENTSNAME"] = "Include Reagents in Search"
L["Inventory"] = "Inventario"
L["INVENTORYDESC"] = "Información del Inventario"
--[[Translation missing --]]
L["InvSlot"] = "InvSlot"
L["is now disabled"] = "ahora esta deshabilitado"
L["is now enabled"] = "ahora esta habilitado"
L["Learned"] = "Aprendido"
L["Library"] = "Librería"
L["Link Recipe"] = "Enlaza la receta"
L["LINKCRAFTABLEREAGENTSDESC"] = "Si puedes crear un reactivo necesario para la receta actual, clickenado el reactivo le llevará a su receta."
L["LINKCRAFTABLEREAGENTSNAME"] = "Hacer reactivos clickeables"
L["Load"] = "Cargar"
--[[Translation missing --]]
L["Lock/Unlock"] = "Lock/Unlock"
L["Market"] = "Market"
L["Merge items"] = "Merge items"
L["Move Down"] = "Mover abajo"
L["Move to Bottom"] = "Mover al Final"
L["Move to Top"] = "Mover al Inicio"
L["Move Up"] = "Mover arriba"
L["need"] = "necesita"
--[[Translation missing --]]
L["New"] = "New"
L["New Group"] = "nuevo grupo"
L["No Data"] = "No Datos"
--[[Translation missing --]]
L["No headers, try again"] = "No headers, try again"
L["No such queue saved"] = "Esta cola no esta guardada"
L["None"] = "Ninguno"
L["not yet cached"] = "aún no en caché"
L["Notes"] = "Notas"
L["Number of items to queue/create"] = "Número de elementos a encolar/crear"
L["Options"] = "Opciones"
L["Order by item"] = "ordenar por objeto"
L["Paste"] = "pegar"
L["Pause"] = "Pausar"
L["Plugins"] = "accesorios"
--[[Translation missing --]]
L["Press"] = "Press"
--[[Translation missing --]]
L["Press Okay to continue changing professions"] = "Press Okay to continue changing professions"
--[[Translation missing --]]
L["Press Process to continue"] = "Press Process to continue"
L["Process"] = "Procesando"
L["Purchased"] = "Comprado"
L["Queue"] = "Encolar"
L["Queue All"] = "Encolar Todo"
L["Queue is empty"] = "La cola esta vacía"
L["Queue is not empty. Overwrite?"] = "La cola no esta vacía. Sobrescribir?"
L["Queue with this name already exsists. Overwrite?"] = "La cola con este nombre ya existe. Sobrescribir?"
L["QUEUECRAFTABLEREAGENTSDESC"] = "Si puedes crear un reactivo necesario para la receta actual, y no tienes suficientes, entonces estos reactivos serán añadidos a la cola"
L["QUEUECRAFTABLEREAGENTSNAME"] = "Encolar reactivos fabricables"
L["QUEUEGLYPHREAGENTSDESC"] = "Si puede crear un producto necesario para la receta actual, y no tiene suficiente, entonces el producto será añadido a la cola. Esta opción es solo para Gilfos."
L["QUEUEGLYPHREAGENTSNAME"] = "Cola de productos necesarios para Gilfos"
L["QUEUEONLYVIEWDESC"] = "ver ventana independiente de la cola solo cuando esta seleccionado, muestra ambos, ventana independiente de la cola y la ventana de skillet cuando no seleccionado"
L["QUEUEONLYVIEWNAME"] = "Mostar solo Cola independiente"
L["Queues"] = "Encolado Guardar/ Cargar"
--[[Translation missing --]]
L["reagent id seems corrupt!"] = "reagent id seems corrupt!"
L["Reagents"] = "Componentes"
L["reagents in inventory"] = "reactivos en el inventario"
L["Really delete this queue?"] = "Borrar esta cola realmente?"
L["Remove Favorite"] = "Quitar de favoritos"
--[[Translation missing --]]
L["Remove Recipe from Ignored List"] = "Remove Recipe from Ignored List"
--[[Translation missing --]]
L["Rename"] = "Rename"
L["Rename Group"] = [=[Renombrar grupo
]=]
L["Rescan"] = "Rescanear"
L["Reset"] = "Reposicionar"
L["Reset Recipe Filter"] = "Reiniciar filtro de recetas"
L["RESETDESC"] = "Resetear posicion de skillet"
L["RESETRECIPEFILTERDESC"] = "Resetear filtro de recetas"
L["Retrieve"] = "Recuperar"
L["Same faction"] = [=[Misma facción
]=]
L["Save"] = "Guardar"
L["Scale"] = "Escala"
L["SCALEDESC"] = "Escala de la venta de Habilidades de Comercio (predeterminado 1.0)"
--[[Translation missing --]]
L["SCALETOOLTIPDESC"] = "Set scale of skill and reagent tooltips to match recipe tooltip (global uiscale)."
--[[Translation missing --]]
L["SCALETOOLTIPNAME"] = "Scale All Tooltips"
L["Scan completed"] = "Escaneo completado"
L["Scanning tradeskill"] = "Escaneando Habilidades de Comercio"
L["Search"] = [=[Buscar
]=]
L["Select All"] = "Selecciona todo"
L["Select None"] = "Selecciona nada"
L["Select skill difficulty threshold"] = "Selecciona el umbral de nivel de habilidad"
L["Selected Addon"] = "Addon Seleccionado"
L["Selection"] = [=[Selección
]=]
L["Sells for "] = "Se vende por"
L["Set Favorite"] = "Añadir Favorito"
--[[Translation missing --]]
L["shift-click to link"] = "shift-click to link"
L["Shopping Clear"] = "Limpia lista compra"
L["Shopping List"] = "Lista Compra"
L["SHOPPINGCLEARDESC"] = "Limpia lista de la compra"
L["SHOPPINGLISTDESC"] = "Mostrar la Lista de la Compra"
L["Show favorite recipes only. Click on a star on the left side of a recipe to set favorite."] = "Muestra solo recetas favoritas. Clicka en la estrella de la izquierda en una receta para añadirla a favorita"
L["SHOWBANKALTCOUNTSDESC"] = "Cuando se calcula y se muestra contador de elementos fabricables, incluir elementos de tu banco y de tus otros caracteres."
L["SHOWBANKALTCOUNTSNAME"] = "Incluir contenido del banco y caracter alt"
L["SHOWCRAFTCOUNTSDESC"] = "Mostrar el número de veces que se puede elaborar una receta, no el número total de elementos elaborables"
L["SHOWCRAFTCOUNTSNAME"] = "Mostrar Contador Fabricación"
L["SHOWCRAFTERSTOOLTIPDESC"] = "Muestra el carácter alternativo que puede manufacturar un objeto en la información de las notas de este objeto."
L["SHOWCRAFTERSTOOLTIPNAME"] = "Muestra los artesanos en la información de las notas."
L["SHOWDETAILEDRECIPETOOLTIPDESC"] = "Mostrar un tooltip detallado cuando se cierne sobre recetas en el panel izquierdo"
L["SHOWDETAILEDRECIPETOOLTIPNAME"] = "Mostrar tooltip detallado para recipientes"
L["SHOWFULLTOOLTIPDESC"] = "Muestra toda la información acerca de un objeto para crearlo. Si Ud. lo desactiva solo vera la información de las notas compacta (mantener Ctrl para mostral toda la informacion de las notas)"
L["SHOWFULLTOOLTIPNAME"] = "Usar la información de las notas normal."
L["SHOWITEMNOTESTOOLTIPDESC"] = "Añadir notas proporcionadas para un elemento al tooltip para ese elemento"
L["SHOWITEMNOTESTOOLTIPNAME"] = "Añadir notas usuario especificadas al tooltip"
L["SHOWITEMTOOLTIPDESC"] = "Muestra Notas de información de objetos manufacturables, en vez de la nota de la receta."
L["SHOWITEMTOOLTIPNAME"] = "Muestra Nota de información cuando es posible"
L["SHOWMAXUPGRADEDESC"] = "Cuando seleccionado, muestra una mejora de la receta como \"(actual /máximo)\". Cuando no selcionas muestra como \"(Actual)\""
L["SHOWMAXUPGRADENAME"] = "Muestra las recetas mejorables como (Actual/Máximo)"
L["SHOWRECIPESOURCEFORLEARNEDDESC"] = "Muestra donde se adquirieron las Recetas aprendidas"
L["SHOWRECIPESOURCEFORLEARNEDNAME"] = [=[Muestra el origen de la Receta para las Recetas aprendidas

]=]
L["Skillet Trade Skills"] = "Skillet - Habilidades de Comercio"
L["Skipping"] = "Saltarse"
L["Sold amount"] = "Cantidad vendida"
L["SORTASC"] = "Ordenar la lista de recetas del mayor (arriba) al menor (abajo)"
L["SORTDESC"] = "Ordenar la lista de recetas del menor (arriba) al mayor (abajo)"
L["Sorting"] = "Sorting"
L["Source:"] = "Procedencia::"
L["STANDBYDESC"] = "Intercambio pausa on/off"
L["STANDBYNAME"] = "Pausa"
L["Start"] = "Iniciar"
--[[Translation missing --]]
L["SubClass"] = "SubClass"
--[[Translation missing --]]
L["SUPPORTCRAFTINGDESC"] = "Include support for Crafting professions (requires a /reload)"
--[[Translation missing --]]
L["SUPPORTCRAFTINGNAME"] = "Support Crafting"
L["Supported Addons"] = "Addons Soportados"
L["SUPPORTEDADDONSDESC"] = "Addons soportados que pueden o son usados para rastrear el inventario"
L["This merchant sells reagents you need!"] = "¡Este mercader vende los reactivos que necesitas!"
--[[Translation missing --]]
L["TOOLTIPSCALEDESC"] = "Scales the recipe list, detail item and reagent tooltips"
L["Total Cost:"] = "Coste Total:"
L["Total spent"] = "Total gastado"
--[[Translation missing --]]
L["TRADEBUTTONSDESC"] = "Include TradeSkill buttons in frame"
--[[Translation missing --]]
L["TRADEBUTTONSNAME"] = "Include TradeSkill buttons"
L["Trained"] = "Aprendido"
L["TRANSPARAENCYDESC"] = "Transparencia de la ventana principal de las Habilidades de Comercio"
L["Transparency"] = "Transparencia"
L["Unknown"] = "Desconocido"
L["Unlearned"] = "Por aprender"
L["USEALTCURRVENDITEMSDESC"] = "Los objetos vendidos con monedas alternativas son consideradas como material del vendedor"
L["USEALTCURRVENDITEMSNAME"] = "Usar objetos comprados con monedas alternativas"
L["USEBLIZZARDFORFOLLOWERSDESC"] = "Usar la interfaz de Blizzard para las habilidades de los seguidores de ciudadela."
L["USEBLIZZARDFORFOLLOWERSNAME"] = "Usar la interfaz de Blizzard  para seguidores"
L["USEGUILDBANKASALTDESC"] = "Usa el contenido de banco de hermandad como otro Alter"
L["USEGUILDBANKASALTNAME"] = "Usa el banco de hermandad como otro Alter"
L["Using Bank for"] = "Usando el banco para"
L["Using Reagent Bank for"] = "Usando materiales del banco para"
L["VENDORAUTOBUYDESC"] = "Si tiene recetas en cola y habla con un vendedor que vende algo necesario para las recetas, se adquiere automáticamente."
L["VENDORAUTOBUYNAME"] = "Automáticamente comprar los reactivos"
L["VENDORBUYBUTTONDESC"] = "Muestra un botón cuando hable con los vendedores que le permitirá ver los reactivos necesarios para todas las recetas en cola."
L["VENDORBUYBUTTONNAME"] = "Mostrar botón comprar reactivos en proveedores"
L["View Crafters"] = "Ver artesanos"

