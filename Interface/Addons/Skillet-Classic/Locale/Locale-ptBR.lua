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

local L = LibStub("AceLocale-3.0"):NewLocale("Skillet", "ptBR")
if not L then return end

L[" days"] = "dias"
L["About"] = "Sobre"
L["ABOUTDESC"] = "Sobre o Skillet"
--[[Translation missing --]]
--[[ L["Add Recipe to Ignored List"] = ""--]] 
L["Add to Ignore Materials"] = "Add aos Materiais Ignorados"
L["alts"] = true
L["Appearance"] = "Aparência"
L["APPEARANCEDESC"] = "Opções de visualização do Skillet"
L["bank"] = "banco"
L["Blizzard"] = true
L["Buy Reagents"] = "Comprar Reagentes"
L["buyable"] = "comprável"
L["Buyout"] = "Comprar"
L["By Difficulty"] = "Por Dificuldade"
L["By Item Level"] = "Por Nível do Item"
L["By Level"] = "Por Nível"
L["By Name"] = "Por Nome"
L["By Quality"] = "Por Qualidade"
L["By Skill Level"] = "Por Habilidade"
L["can be created by crafting reagents"] = "pode ser criado por elaboração de reagentes"
L["can be created from reagents in your inventory"] = "Pode ser criado com reagentes do seu inventario"
--[[Translation missing --]]
--[[ L["can be created from reagents on all characters"] = ""--]] 
L["can be created from reagents on other characters"] = "Pode ser criado com reagentes de todos seus personagens"
L["can be created with reagents bought at vendor"] = true
--[[Translation missing --]]
--[[ L["Changing profession to"] = ""--]] 
L["Clear"] = "Limpar"
--[[Translation missing --]]
--[[ L["Click"] = ""--]] 
L["click here to add a note"] = "clique aqui para adicionar uma nota"
L["Click to toggle favorite"] = "Clique para alternar o favorito"
L["Collapse all groups"] = "Contrair todos os grupos"
L["Config"] = "Configuração"
L["CONFIGDESC"] = "Abre a tela de configuração do Skillet"
L["CONFIRMQUEUECLEARDESC"] = "Use Alt-left-click instead of left-click to clear the queue"
L["CONFIRMQUEUECLEARNAME"] = "Use Alt-click to clear queue"
--[[Translation missing --]]
--[[ L["Conflict with the addon TradeSkillMaster"] = ""--]] 
L["Copy"] = "Copiar"
L["Could not find bag space for"] = "Não há espaço na mochila"
L["craftable"] = "Produzivel"
--[[Translation missing --]]
--[[ L["CRAFTBUTTONSDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["CRAFTBUTTONSNAME"] = ""--]] 
L["Crafted By"] = "Feito Por"
L["Create"] = "Criar"
L["Create All"] = "Criar Todos"
L["Cut"] = "Cortar"
L["DBMarket"] = true
L["Delete"] = "Apagar"
--[[Translation missing --]]
--[[ L["DISPLAYITEMLEVELDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["DISPLAYITEMLEVELNAME"] = ""--]] 
L["DISPLAYREQUIREDLEVELDESC"] = "Se o item requer um nível minimo para ser usado, este nível será mostrado com a receita"
L["DISPLAYREQUIREDLEVELNAME"] = "Mostrar nivel necessario"
L["DISPLAYSHOPPINGLISTATAUCTIONDESC"] = "Mostrar uma lista de compras de itens necessarios para fabricação das receitas que estão na lista mas não estão na sua bolsa"
L["DISPLAYSHOPPINGLISTATAUCTIONNAME"] = "Mostra a lista de compras no leilão"
L["DISPLAYSHOPPINGLISTATBANKDESC"] = "Mostrar uma lista de compras de itens necessarios para fabricação das receitas que estão na lista mas não estão na sua bolsa"
L["DISPLAYSHOPPINGLISTATBANKNAME"] = "Mostrar lista de itens no banco"
L["DISPLAYSHOPPINGLISTATGUILDBANKDESC"] = "Mostrar uma lista de compras de itens necessarios para fabricação das receitas que estão na lista mas não estão na sua bolsa"
L["DISPLAYSHOPPINGLISTATGUILDBANKNAME"] = "Mostrar lista e itens no banco do clã"
L["DISPLAYSHOPPINGLISTATMERCHANTDESC"] = "Mostrar uma lista de compras de itens necessarios para fabricação das receitas que estão na lista mas não estão na sua bolsa"
L["DISPLAYSHOPPINGLISTATMERCHANTNAME"] = "Mostrar lista de compras nos vendedores"
L["Draenor Engineering"] = "Engenharia Draenor"
L["Empty Group"] = "Grupo vazio"
L["Enabled"] = "Hablitado"
L["Enchant"] = "Encantamento"
L["ENHANCHEDRECIPEDISPLAYDESC"] = "Quando habilitado, aparecera um ou mais caractere '+' ao lado da receita pra indicar a dificuldade"
L["ENHANCHEDRECIPEDISPLAYNAME"] = "Mostrar dificuldade da receita como um texto"
L["Expand all groups"] = "Expandir todos os grupos"
L["Features"] = "Caracteristicas"
L["FEATURESDESC"] = "Habilita ou deshabilita Caracteristicas extras"
L["Filter"] = "Filtro"
--[[Translation missing --]]
--[[ L["Flat"] = ""--]] 
L["Flush All Data"] = "Baixar dados"
L["Flush Recipe Data"] = "Baixar Dados"
L["FLUSHALLDATADESC"] = "Baixar todos os dados do Skillet"
L["FLUSHRECIPEDATADESC"] = "Baixar dados de receitas do Skillet"
L["From Selection"] = "Da seleção"
L["Glyph "] = "Glifos"
L["Gold earned"] = "Ouro ganho"
L["Grouping"] = "Agrupando"
L["has cooldown of"] = "tem espera de "
L["have"] = "possui"
L["Hide trivial"] = "Esconder triviais"
L["Hide uncraftable"] = "Esconde não produziveis"
--[[Translation missing --]]
--[[ L["HIDEBLIZZARDFRAMEDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["HIDEBLIZZARDFRAMENAME"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ignore"] = ""--]] 
L["IGNORECLEARDESC"] = "Limpa todas as entradas na lista de Materiais Ignorados"
L["Ignored List"] = "Lista de ignorados"
L["Ignored Materials Clear"] = "Limpar Materiais Ignorados"
L["Ignored Materials List"] = "Materiais Ignorados"
L["IGNORELISTDESC"] = "Abrir a lista de materiais ignorados"
L["Illusions"] = "Ilusões"
L["in your inventory"] = true
L["Include alts"] = "Incluir alts"
L["Include bank"] = "Incluir banco"
L["Include guild"] = "Incluir guilda"
--[[Translation missing --]]
--[[ L["INCLUDEREAGENTSDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["INCLUDEREAGENTSNAME"] = ""--]] 
L["Inventory"] = "Inventorio"
L["INVENTORYDESC"] = "Informações o inventario"
--[[Translation missing --]]
--[[ L["InvSlot"] = ""--]] 
L["is now disabled"] = [=[esta desabilitado
modo de espera - Skillet está desabilitado]=]
L["is now enabled"] = [=[esta habilitado
modo de espera - Skillet está habilitado]=]
L["Learned"] = "Aprendido"
L["Library"] = "Biblioteca"
L["Link Recipe"] = "Linkar receita"
L["LINKCRAFTABLEREAGENTSDESC"] = "Torna os reagentes clicaveis"
L["LINKCRAFTABLEREAGENTSNAME"] = "Fazer reagentes ser clicavel"
L["Load"] = "Carregar"
--[[Translation missing --]]
--[[ L["Lock/Unlock"] = ""--]] 
L["Market"] = "Mercado"
L["Merge items"] = "Unir itens"
L["Move Down"] = [=[Mover abaixo
reordenando a fila]=]
L["Move to Bottom"] = [=[Mover para o final
reordenando a fila]=]
L["Move to Top"] = [=[Mover para o topo
reordenando a fila]=]
L["Move Up"] = [=[Mover acima
reordenando a fila]=]
L["need"] = "necessário"
--[[Translation missing --]]
--[[ L["New"] = ""--]] 
L["New Group"] = "Novo Grupo"
L["No Data"] = "Sem informação"
--[[Translation missing --]]
--[[ L["No headers, try again"] = ""--]] 
L["No such queue saved"] = "Nenhuma fila salva"
L["None"] = "Nenhum"
L["not yet cached"] = "ainda não armazenados em cache"
L["Notes"] = "Notas"
L["Number of items to queue/create"] = "Número de itens para fila/criar"
L["Options"] = "Opções"
L["Order by item"] = "Organizar pelo item"
L["Paste"] = "Colar"
L["Pause"] = "Pausa"
L["Plugins"] = true
--[[Translation missing --]]
--[[ L["Press"] = ""--]] 
--[[Translation missing --]]
--[[ L["Press Okay to continue changing professions"] = ""--]] 
--[[Translation missing --]]
--[[ L["Press Process to continue"] = ""--]] 
L["Process"] = "Processo"
L["Purchased"] = "Comprados"
L["Queue"] = "Fila"
L["Queue All"] = "Todos na Fila"
L["Queue is empty"] = "A fila está vazia"
L["Queue is not empty. Overwrite?"] = "A fila não está vazia. Sobrescrever?"
L["Queue with this name already exsists. Overwrite?"] = "Fila com este nome ja existe, sobreescrever?"
L["QUEUECRAFTABLEREAGENTSDESC"] = "Se você pode criar um item necessario para receita, e você não tem, então o reagente sera colocado na fila"
L["QUEUECRAFTABLEREAGENTSNAME"] = "Colocar na fila reagentes fabricaveis"
L["QUEUEGLYPHREAGENTSDESC"] = "Se você pode criar um item necessario para receita, e você não tem, então o reagente sera colocado na fila"
L["QUEUEGLYPHREAGENTSNAME"] = "Colocar na fila reagente para Glifos"
L["QUEUEONLYVIEWDESC"] = "Show Standalone Queue Window only when set, show both Standalone Queue Window and Skillet Window when clear."
L["QUEUEONLYVIEWNAME"] = "Only show Standalone Queue"
L["Queues"] = "Filas"
--[[Translation missing --]]
--[[ L["reagent id seems corrupt!"] = ""--]] 
L["Reagents"] = "Reagentes"
L["reagents in inventory"] = "Reagentes no inventario"
L["Really delete this queue?"] = "Você realmente quer apagar esta fila?"
L["Remove Favorite"] = "Remover Favorito"
--[[Translation missing --]]
--[[ L["Remove Recipe from Ignored List"] = ""--]] 
--[[Translation missing --]]
--[[ L["Rename"] = ""--]] 
L["Rename Group"] = "Renomear Grupo"
L["Rescan"] = "Rescanear"
L["Reset"] = "Redefinir"
L["Reset Recipe Filter"] = "Limpar o filtro"
L["RESETDESC"] = "Redefinir posição do Skillet"
L["RESETRECIPEFILTERDESC"] = "Limpar o filtro"
L["Retrieve"] = "Recuperar"
L["Same faction"] = true
L["Save"] = "Salvar"
L["Scale"] = "Escala"
L["SCALEDESC"] = "Escala da janela principal"
--[[Translation missing --]]
--[[ L["SCALETOOLTIPDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SCALETOOLTIPNAME"] = ""--]] 
L["Scan completed"] = "Verificação concluida"
L["Scanning tradeskill"] = "Verificando as receitas"
L["Search"] = "Procurar"
L["Select All"] = "Selecionar todos"
L["Select None"] = "Limpar seleção"
L["Select skill difficulty threshold"] = ""
L["Selected Addon"] = "Addon Selecionado"
L["Selection"] = "Seleção"
L["Sells for "] = "Vender por"
L["Set Favorite"] = "Definir favorito"
--[[Translation missing --]]
--[[ L["shift-click to link"] = ""--]] 
L["Shopping Clear"] = "Limpar lista"
L["Shopping List"] = "Lista de Compras"
L["SHOPPINGCLEARDESC"] = "Limpar a lista de compras"
L["SHOPPINGLISTDESC"] = "Mostra a lista de compras"
L["Show favorite recipes only. Click on a star on the left side of a recipe to set favorite."] = "Mostrar receitas favoritas apenas. Clique em uma estrela no lado esquerdo de uma receita para definir favorito."
L["SHOWBANKALTCOUNTSDESC"] = "Quando calcular os itens possiveis de fabricação usa os itens do banco de de personagens alternativos"
L["SHOWBANKALTCOUNTSNAME"] = "Incluir itens no banco e em personagens alternativos"
L["SHOWCRAFTCOUNTSDESC"] = "Mostra o numero possivel de itens para fabricação, não o total de itens produzidos"
L["SHOWCRAFTCOUNTSNAME"] = "Mostrar a contagem de itens fabricaveis"
L["SHOWCRAFTERSTOOLTIPDESC"] = "Mostrar o nome do personagem alternativo que pode criar este item nas informações do item."
L["SHOWCRAFTERSTOOLTIPNAME"] = "Mostrar criador nas informações"
L["SHOWDETAILEDRECIPETOOLTIPDESC"] = "Mostrar toda a informação do item a ser criado. Se você desligar vera apenas uma informação parcial(Segure ctrl para a descrição completa)"
L["SHOWDETAILEDRECIPETOOLTIPNAME"] = "Mostrar dicas para as receitas"
L["SHOWFULLTOOLTIPDESC"] = "Mostrar toda a informação de um item a ser fabricado. Se você desligar, apenas vera uma pequena informação (Segure Ctrl para uma descrição completa)"
L["SHOWFULLTOOLTIPNAME"] = "Usar caixa de informação padrão"
L["SHOWITEMNOTESTOOLTIPDESC"] = "Adiciona as notas que você forneceu para um item nas informações desse item"
L["SHOWITEMNOTESTOOLTIPNAME"] = "Adicionar notas do usuários as informações do item"
L["SHOWITEMTOOLTIPDESC"] = "Mostrar informações do item a ser fabricado, em vez das informações da receita."
L["SHOWITEMTOOLTIPNAME"] = "Mostra informações quando possível"
L["SHOWMAXUPGRADEDESC"] = "When set, show upgradable recipes as \"(current/maximum)\". When not set, show as \"(current)\""
L["SHOWMAXUPGRADENAME"] = "Show upgradable recipes as (current/max)"
L["SHOWRECIPESOURCEFORLEARNEDDESC"] = "Mostrar fonte da receita para receitas aprendidas"
L["SHOWRECIPESOURCEFORLEARNEDNAME"] = "Mostrar fonte da receita para receitas aprendidas"
L["Skillet Trade Skills"] = "Skillet - Habilidades de Comercio"
L["Skipping"] = "Pulando"
L["Sold amount"] = "Total vendido"
L["SORTASC"] = "Organiza a lista do maior (topo) para o menor (abaixo)"
L["SORTDESC"] = "Organiza a lista do menor (topo) para o maior (abaixo)"
L["Sorting"] = "Ordenando"
L["Source:"] = [=[Origem:
origem da receita do item]=]
L["STANDBYDESC"] = "Habilita e desabilita o modo de espera"
L["STANDBYNAME"] = "Aguardar"
L["Start"] = "Iniciar"
--[[Translation missing --]]
--[[ L["SubClass"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUPPORTCRAFTINGDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUPPORTCRAFTINGNAME"] = ""--]] 
L["Supported Addons"] = "Addons Suportados"
L["SUPPORTEDADDONSDESC"] = "Addons suportados que são usados para escanear seu inventario"
L["This merchant sells reagents you need!"] = "Este vendedor tem itens que você precisa!"
--[[Translation missing --]]
--[[ L["TOOLTIPSCALEDESC"] = ""--]] 
L["Total Cost:"] = "Custo Total:"
L["Total spent"] = "Total gasto"
--[[Translation missing --]]
--[[ L["TRADEBUTTONSDESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["TRADEBUTTONSNAME"] = ""--]] 
L["Trained"] = [=[Aprendida
receita obtida no instrutor]=]
L["TRANSPARAENCYDESC"] = "Transparência da janela principal"
L["Transparency"] = "Transparência"
L["Unknown"] = [=[Desconhecido
origem da receita desconhecida]=]
L["Unlearned"] = "Desaprender"
L["USEALTCURRVENDITEMSDESC"] = "Vendor items bought with alternate currencies are considered vendor supplied."
L["USEALTCURRVENDITEMSNAME"] = "Use vendor items bought with alternate currencies"
L["USEBLIZZARDFORFOLLOWERSDESC"] = "Usar Interface da Blizzard para seguidores garrison"
L["USEBLIZZARDFORFOLLOWERSNAME"] = "Usar Interface da Blizzard para seguidores"
L["USEGUILDBANKASALTDESC"] = "Usar o conteúdo do banco da guilda como se fosse outro alternativo."
L["USEGUILDBANKASALTNAME"] = "Usar o banco da guilda"
L["Using Bank for"] = "Usando banco por"
L["Using Reagent Bank for"] = "Usando Reagente do banco"
L["VENDORAUTOBUYDESC"] = "Se você tiver receitas na fila e falar com um vendedor que tenha algo para aquelas receitas, isto será comprado automaticamente."
L["VENDORAUTOBUYNAME"] = "Comprar reagentes automaticamente"
L["VENDORBUYBUTTONDESC"] = "Mostra o botão de compra de reagentes nos vendedores"
L["VENDORBUYBUTTONNAME"] = "Mostrar botão de compra nos vendedores"
L["View Crafters"] = "Ver artesões"

