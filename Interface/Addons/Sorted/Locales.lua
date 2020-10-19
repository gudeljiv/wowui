Sorted = {}

local locales = {
    [1] = "enUS",
    [2] = "enGB",
    [3] = "frFR",
    [4] = "deDE",
    [5] = "itIT",
    [6] = "koKR",
    [7] = "zhCN",
    [8] = "zhTW",
    [9] = "ruRU",
    [10] = "esES",
    [11] = "esMX",
    [12] = "ptBR",
}
local localizations = {}
for _, locale in pairs(locales) do
    localizations[locale] = {}
end

local function ParseTSV()
-- Tab Separated Values spreadsheet imported directly from https://docs.google.com/spreadsheets/d/17eIDO0UU86-DUYjvu_ZyJ_9b8kMA9kTbAMDiQ0elXQA/edit?usp=sharing
local tsv = 
[[TITLE	Sorted.	Sorted.	Sorted.	Sorted.	Sorted.	Sorted.	Sorted.	Sorted.	Sorted.	Sorted.	Sorted.	Sorted.
NOTES	Modern bag interface with efficient searching and filters.	Modern bag interface with efficient searching and filters.		Moderne Taschendarstellung mit effzienter Suche und Filtern		효율적인 검색 및 필터 기능을 갖춘 현대적인 가방 인터페이스.		摩登酷炫的背包介面，並帶有高效搜尋以及過濾分類功能。				
CATEGORY_WEAPONS	Weapons	Weapons	Armes	Waffen	Armi	무기	武器	武器	Оружие	Armas	Armas	Armas
CATEGORY_ARMOR	Armor	Armour	Armure	Rüstung	Armature	방어구	护甲	護甲	Доспехи	Armadura	Armadura	Armadura
CATEGORY_ACCESSORIES	Accessories	Accessories	Accessoires	Accessoires	Accessori	장비	配件	配件	Аксессуары	Accesorios	Accesorios	Acessórios
CATEGORY_CONTAINERS	Containers	Containers	Conteneurs	Behälter	Borse	가방류	容器	容器	Сумки	Recipientes	Contenedores	Recipientes
CATEGORY_GEMS	Gems	Gems	Gemmes	Edelsteine	Gemme	보석	宝石	寶石	Камни	Gemas	Gemas	Gemas
CATEGORY_ITEM_ENHANCEMENTS	Item Enhancements	Item Enhancements	Améliorations d’objet	Gegenstandsverbesserungen	Potenziamenti oggetto	아이템 강화	物品附魔	物品附魔	Улуч. предметов	Mejoras de objetos	Mejoras de objetos	Aperfeiçoamentos de Itens
CATEGORY_CONSUMABLES	Consumables	Consumables	Consommables	Verbrauchbare Gegenstände	Consumabili	소비용품	消耗品	消耗品	Расход. предметы	Consumibles	Consumibles	Consumíveis
CATEGORY_GLYPHS	Glyphs	Glyphs	Glyphes	Glyphen	Glifi	문양	雕文	雕紋	Символы	Glifos	Glifos	Glifos
CATEGORY_TRADE_GOODS	Trade Goods	Trade Goods	Fournitures d’artisanat	Handwerkswaren	Beni commerciali	직업용품	杂货	商品	Хоз. товары	Objetos comerciales	Objetos comerciables	Mercadorias
CATEGORY_RECIPES	Recipes	Recipes	Recettes	Rezepte	Ricette	제조법	配方	配方	Рецепты	Recetas	Recetas	Receitas
CATEGORY_BATTLE_PETS	Battle Pets	Battle Pets	Mascottes de combat	Kampfhaustiere	Mascotte da combattimento	전투 애완동물	战斗宠物	戰寵	Питомцы	Mascotas de duelo	Mascotas de duelo	Mascotes de Batalha
CATEGORY_QUEST_ITEMS	Quest Items	Quest Items	Objets de quête	Questgegenstände	Oggetti di missione	퀘스트 아이템	任务物品	任務物品	Для задания	Objetos de misión	Objetos con misión	Itens de missão
CATEGORY_MISCELLANEOUS	Miscellaneous	Miscellaneous	Divers	Verschiedenes	Varie	기타	杂项	雜項	Разное	Miscelánea	Miscelánea	Diversos
ITEM_BACKPACK	Backpack	Backpack		Rucksack		배낭		背包	Рюкзак			
ITEM_UNKNOWN_KEYSTONE	Mythic Keystone	Mythic Keystone		Mythischer Schlüsselstein		신화 쐐기돌		傳奇鑰石	Ключ			
ITEM_MYTHIC_KEYSTONE	Keystone: %s	Keystone: %s		Schlüsselstein: %s		쐐기돌: %s		鑰石：%s	Ключ: %s			
ITEM_PET_CAGED	Pet Cage: %s	Pet Cage: %s		Haustierkäfig: %s		애완동물 우리: %s		寵物籠：%s	Клетка для питомца			
COLUMN_FAVORITES	Favorites	Favourites		Favoriten		즐겨찾기		最愛	Избранное			
COLUMN_QUANTITY	Quantity	Quantity		Menge		수량		數量	Кол-во			
COLUMN_ICON	Icon	Icon		Symbol		아이콘		圖示	Значок			
COLUMN_NAME	Name	Name		Name		이름		名稱	Имя			
COLUMN_NAME_SHORT	Name	Name		Name		이름		名稱	Имя			
COLUMN_RARITY_SHORT	Rarity	Rarity		Seltenheit		희귀도		稀有度	Редкость			
COLUMN_REQUIRED_LEVEL	Required Level	Required Level		Benötigtes Level		최소 요구 레벨		需求等級	Рек. уровень			
COLUMN_REQUIRED_LEVEL_SHORT	Req	Req		Ben.		최소렙		需求	рек.			
COLUMN_ITEM_LEVEL	Item Level	Item Level		Gegenstandslevel		아이템 레벨		物品等級	Ур. предмета			
COLUMN_ITEM_LEVEL_SHORT	Lvl	Lvl		Lvl		템렙		等級	ур.			
COLUMN_TIME_ADDED	Time Added	Time Added		Hinzugefügt		획득 시기		加入時間	Время			
COLUMN_TIME_ADDED_SHORT	Age	Age		Alter		획득		時間	Время			
COLUMN_TYPE	Type	Type		Typ		종류		類型	Тип			
COLUMN_TYPE_SHORT	Type	Type		Typ		종류		類型	Тип			
COLUMN_BINDING	Binding	Binding		Bindung		귀속		綁定類型	Привязка			
COLUMN_BINDING_SHORT	Bind	Bind		Bind		귀속		綁定	Перс.			
COLUMN_EXPANSION	Expansion	Expansion		Erweiterung		확장팩		資料片	Расширение			
COLUMN_EXPANSION_SHORT	Expac	Expac		Erw.		확팩		資料片	Расш.			
COLUMN_SELL_PRICE	Sell Price	Sell Price		Verkaufspreis		판매 가격		售出價格	Цена продажи			
COLUMN_SELL_PRICE_SHORT	Value	Value		Wert		값		售價	Цена			
TAB_BANK	Bank	Bank		Bank		은행		銀行	Банк			
TAB_REAGENTS	Reagents	Reagents		Reagenzien		재료 은행		材料銀行	Хранилище			
BUTTON_SELL_GRAYS	Sell Grays	Sell Greys		Verkaufe Wertloses		잡동사니 판매		賣出垃圾	Продажа			
BUTTON_DEPOSIT_REAGENTS	Deposit Reagents	Deposit Reagents		Reagenzien lagern		모든 재료 보관		存入材料	Сложить предметы			
BUTTON_BUY_REAGENTS	Purchase	Purchase		Kaufen		구입		購買	Покупка			
WARNING_BUY_REAGENTS	This tab gives you additional storage for raw profession materials.\nDo you wish to purchase this tab?	This tab gives you additional storage for raw profession materials.\nDo you wish to purchase this tab?		Dieser Tab gibt Dir zusätzlichen Platz für Rohmaterialien für Berufe. Willst du diesen Tab kaufen?		이 보관함에는 직업용품을 추가로 보관할 수 있습니다.\n이 보관함을 구입하시겠습니까?		此標籤為您提供了額外的存儲專業原料的空間。\n您想要購買此標籤頁嗎？	Эта вкладка дает вам дополнительное хранилище для материалов профессии.\nВы хотите приобрести эту вкладку?			
WARNING_NO_ITEMS_FOUND	No items found	No items found		Keine Gegenstände gefunden		아이템을 찾을 수 없음		沒找到物品	Пусто			
WARNING_BANK_NOT_CACHED	Visit a banker once on %s\n to see their bank contents here	Visit a banker once on %s\n to see their bank contents here		Besuche den Banker einmalig um den Bankinhalt hier zu sehen		%s의 은행원에게 방문하여\n이곳에서 은행 확인		訪問銀行行員一次在 %s\n來查閱他們的銀行物品	Посетите банкира один раз, чтобы увидеть содержимое банка			
WARNING_REAGENTS_NOT_CACHED	Visit a banker once on %s\n to see the contents of their reagent bank here	Visit a banker once on %s\n to see the contents of their reagent bank here		Besuche den Banker einmalig um den Inhalt der Reagenzienbank hier zu sehen		%s의 은행원에게 방문하여\n이곳에서 재료 은행 확인		訪問銀行行員一次在 %s\n來查閱他們的材料銀行物品	Посетите банкира один раз, чтобы увидеть содержимое банка реагентов			
WARNING_REAGENTS_NOT_PURCHASED	Visit a banker on %s\n to purchase their reagent bank	Visit a banker on %s\n to purchase their reagent bank		Besuche den Banker einmalig um Reagenzienbankplätze zu kaufen		%s의 은행원에게 방문하여\n 재료 은행 구입		訪問銀行行員在 %s\n來購買他們的材料銀行	Посетите банкира, чтобы купить банк реагентов			
DROPDOWN_MENU_EQUIPMENT_SET	Equipment Sets	Equipment Sets		Ausrüstungssets		장비 구성		套裝設定	Комплект			
DROPDOWN_MENU_EQUIPMENT_SET_NONE	No Equipment Set	No Equipment Set		Kein Ausrüstungsset		장비 구성 없음		無套裝設定	Без комплекта			
DROPDOWN_MENU_CLEAR	Clear	Clear		Löschen		초기화		清除	Очистить			
FILTER_TYPE	Type	Type		Typ		종류		類型	Тип			
FILTER_EQUIP_LOCATION	Equip Location	Equip Location		Ausrüstungsplatz		착용 부위		裝備位置	Ячейка экипировки			
FILTER_SUBTYPE	Subtype	Subtype		Untertyp		소분류		子類別	Тип			
FILTER_STATS	Stats	Stats		Attribute		능력치		屬性	Характеристики			
FILTER_QUALITY	Quality	Quality		Qualität		품질		品質	Качество			
FILTER_TIME_ADDED	Time Added	Time Added		Hinzugefügt am		획득 시간		加入時間	Добавлено			
FILTER_BINDING	Binding	Binding		Bindung		귀속		綁定	Перс.			
FILTER_EXPANSION	Expansion	Expansion		Erweiterung		확장팩		資料片	Расширение			
FILTER_LEVEL	Level	Level		Level		레벨		等級	Уровень			
FILTER_MARKER_ICON	Marker Icon	Marker Icon		Markersymbol		징표		標記圖示	Метка			
FILTER_NAME_SEARCH	Name Search	Name Search		Namenssuche		이름 검색		名稱搜尋	Поиск			
FILTER_SPECIFIC_ITEMS	Specific Items	Specific Items		Spezifische Gegenstände		특정 아이템		特定物品	Спец. предметы			
SUBFILTER_TYPE_ARMOR	Armor	Armour		Rüstung		방어구		護甲	Броня			
SUBFILTER_TYPE_BATTLE_PET	Battle Pet	Battle Pet		Kampfhaustiere		전투 애완동물		戰寵	Питомцы			
SUBFILTER_TYPE_CONSUMABLE	Consumable	Consumable		Verbrauchbares		소모성		消耗品	Расх. материал			
SUBFILTER_TYPE_CONTAINER	Container	Container		Container		가방		容器	Сумки			
SUBFILTER_TYPE_GEM	Gem	Gem		Edelstein		보석		寶石	Камни			
SUBFILTER_TYPE_GLYPH	Glyph	Glyph		Glyph		문양		雕紋	Символы			
SUBFILTER_TYPE_ITEM_ENHANCEMENT	Item Enhancement	Item Enhancement		Itemverbesserung		아이템 강화		物品附魔	Улуч. предмета			
SUBFILTER_TYPE_KEY	Key	Key		Schlüssel		열쇠		鑰匙	Ключ			
SUBFILTER_TYPE_MISCELLANEOUS	Miscellaneous	Miscellaneous		Verschiedenes		기타		雜項	Разное			
SUBFILTER_TYPE_REAGENT	Reagent	Reagent		Reagenz		재료		試劑	Реагент			
SUBFILTER_TYPE_RECIPE	Recipe	Recipe		Rezept		습득서		配方	Рецепт			
SUBFILTER_TYPE_PROJECTILE	Projectile	Projectile		Projektil		발사체		發射物	Снаряд			
SUBFILTER_TYPE_QUEST	Quest	Quest		Quest		퀘스트		任務	Задание			
SUBFILTER_TYPE_QUIVER	Quiver	Quiver		Köcher		화살통		箭袋	Колчан			
SUBFILTER_TYPE_TRADE_GOODS	Trade Good	Trade Good		Handelswaren		직업용품		商品	Хоз. товар			
SUBFILTER_TYPE_WEAPON	Weapon	Weapon		Waffe		무기		武器	Оружие			
SUBFILTER_EQUIP_LOCATION_HEAD	Head	Head		Kopf		머리		頭部	Голова			
SUBFILTER_EQUIP_LOCATION_NECK	Neck	Neck		Hals		목		頸部	Шея			
SUBFILTER_EQUIP_LOCATION_SHOULDER	Shoulder	Shoulder		Schulter		어깨		肩部	Плечи			
SUBFILTER_EQUIP_LOCATION_BACK	Back	Back		Rücken		등		背部	Спина			
SUBFILTER_EQUIP_LOCATION_CHEST	Chest	Chest		Brust		가슴		胸部	Грудь			
SUBFILTER_EQUIP_LOCATION_SHIRT	Shirt	Shirt		Hemd		속옷		襯衣	Рубашка			
SUBFILTER_EQUIP_LOCATION_TABARD	Tabard	Tabard		Wappenrock		겉옷		外袍	Накидка			
SUBFILTER_EQUIP_LOCATION_WRIST	Wrist	Wrist		Handgelenk		손목		手腕	Запястье			
SUBFILTER_EQUIP_LOCATION_HANDS	Hands	Hands		Hände		손		手	Кисти			
SUBFILTER_EQUIP_LOCATION_WAIST	Waist	Waist		Hüfte		허리		腰部	Пояс			
SUBFILTER_EQUIP_LOCATION_LEGS	Legs	Legs		Beine		다리		腿部	Ноги			
SUBFILTER_EQUIP_LOCATION_FEET	Feet	Feet		Füße		발		腳	Обувь			
SUBFILTER_EQUIP_LOCATION_FINGER	Finger	Finger		Finger		손가락		手指	Палец			
SUBFILTER_EQUIP_LOCATION_TRINKET	Trinket	Trinket		Schmuck		장신구		飾品	Аксессуар			
SUBFILTER_EQUIP_LOCATION_OFF_HAND	Off-Hand	Off-Hand		Nebenhand		보조장비		副手	Левая рука			
SUBFILTER_EQUIP_LOCATION_RELIC	Relic	Relic		Relikt		유물		聖物	Реликвия			
SUBFILTER_EQUIP_LOCATION_ONE_HAND	One-Handed	One-Handed		Einhändig		한손		單手	Одноручное			
SUBFILTER_EQUIP_LOCATION_TWO_HAND	Two-Handed	Two-Handed		Zweihändig		양손		雙手	Двуручное			
SUBFILTER_EQUIP_LOCATION_RANGED	Ranged	Ranged		Fernkampf		원거리		遠程	Дальний бой			
SUBFILTER_SUBTYPE_ARMOR_PLATE	Plate	Plate		Platte		판금		鎧甲	Латы			
SUBFILTER_SUBTYPE_ARMOR_MAIL	Mail	Mail		Kette		사슬		鎖甲	Кольчуга			
SUBFILTER_SUBTYPE_ARMOR_LEATHER	Leather	Leather		Leder		가죽		皮甲	Кожа			
SUBFILTER_SUBTYPE_ARMOR_CLOTH	Cloth	Cloth		Kleidung		천		布甲	Ткань			
SUBFILTER_SUBTYPE_ARMOR_COSMETIC	Cosmetic	Cosmetic		Kosmetisch		장식		造型	Косметика			
SUBFILTER_SUBTYPE_ARMOR_GENERIC	Generic	Generic		Generisch		포괄적		一般	Общий			
SUBFILTER_SUBTYPE_ARMOR_SHIELDS	Shields	Shields		Schild		방패		盾牌	Щиты			
SUBFILTER_SUBTYPE_ARMOR_LIBRAMS	Librams	Librams		Librams		고서		聖契	Весы			
SUBFILTER_SUBTYPE_ARMOR_IDOLS	Idols	Idols		Idole		우상		雕像	Идолы			
SUBFILTER_SUBTYPE_ARMOR_TOTEMS	Totems	Totems		Totems		토템		圖騰	Тотемы			
SUBFILTER_SUBTYPE_ARMOR_SIGILS	Sigils	Sigils		Siegel		인장		符印	Сигилы			
SUBFILTER_SUBTYPE_BATTLE_PET_HUMANOID	Humanoid	Humanoid		Menschlich		인간형		人形生物	Гуманоид			
SUBFILTER_SUBTYPE_BATTLE_PET_DRAGON	Dragon	Dragon		Drache		용족		龍類	Дракон			
SUBFILTER_SUBTYPE_BATTLE_PET_FLYING	Flying	Flying		Fliegend		비행		飛行	Летающий			
SUBFILTER_SUBTYPE_BATTLE_PET_UNDEAD	Undead	Undead		Untot		언데드		不死	Нежить			
SUBFILTER_SUBTYPE_BATTLE_PET_CRITTER	Critter	Critter		Kleintier		동물		小動物	Зверек			
SUBFILTER_SUBTYPE_BATTLE_PET_MAGICAL	Magical	Magical		Magisch		마법		魔法	Магический			
SUBFILTER_SUBTYPE_BATTLE_PET_ELEMENTAL	Elemental	Elemental		Elementar		정령		元素	Элементаль			
SUBFILTER_SUBTYPE_BATTLE_PET_BEAST	Beast	Beast		Biest		야수		野獸	Животное			
SUBFILTER_SUBTYPE_BATTLE_PET_WATER	Water	Water		Wasser		물		水棲	Водный			
SUBFILTER_SUBTYPE_BATTLE_PET_MECHANICAL	Mechanical	Mechanical		Mechanisch		기계		機械	Механизм			
SUBFILTER_SUBTYPE_CONSUMABLE_BOMBS_AND_DEVICES	Bombs and Devices	Bombs and Devices		Bomben und Geräte		폭탄물과 장치		爆裂物與裝置	Бомбы/устройства			
SUBFILTER_SUBTYPE_CONSUMABLE_POTIONS	Potions	Potions		Tränke		물약		藥水	Зелья			
SUBFILTER_SUBTYPE_CONSUMABLE_ELIXIRS	Elixirs	Elixirs		Elixire		비약		藥劑	Эликсиры			
SUBFILTER_SUBTYPE_CONSUMABLE_FLASKS	Flasks	Flasks		Flaschen		영약		精煉藥劑	Настои			
SUBFILTER_SUBTYPE_CONSUMABLE_FOOD_AND_DRINK	Food & Drink	Food & Drink		Essen und Trinken		음식과 음료		食物和飲料	Еда/питьё			
SUBFILTER_SUBTYPE_CONSUMABLE_BANDAGES	Bandages	Bandages		Bandagen		붕대		繃帶	Бинты			
SUBFILTER_SUBTYPE_CONSUMABLE_VANTUS_RUNES	Vantus Runes	Vantus Runes		Vantus Runen		반투스 룬		梵陀符文	Вант. руны			
SUBFILTER_SUBTYPE_CONSUMABLE_OTHER	Other	Other		Anderes		그 외		其他	Другое			
SUBFILTER_SUBTYPE_CONTAINER_BAG	All-Purpose Bag	All-Purpose Bag		Tasche		가방		背包	Сумка			
SUBFILTER_SUBTYPE_CONTAINER_SOUL	Soul Bag	Soul Bag		Seelentasche		영혼석 가방		靈魂袋	Сумка душ			
SUBFILTER_SUBTYPE_CONTAINER_HERB	Herb Bag	Herb Bag		Kräutertasche		약초 가방		草藥包	Сумка травника			
SUBFILTER_SUBTYPE_CONTAINER_ENCHANTING	Enchanting Bag	Enchanting Bag		Verzauberungstasche		마법부여 가방		附魔包	Сумка зачаровывателя			
SUBFILTER_SUBTYPE_CONTAINER_ENGINEERING	Engineering Bag	Engineering Bag		Ingenieurstasche		기계공학 가방		工程包	Сумка инженера			
SUBFILTER_SUBTYPE_CONTAINER_GEM	Gem Bag	Gem Bag		Edelsteintasche		보석 가방		寶石包	Сумка ювелира			
SUBFILTER_SUBTYPE_CONTAINER_MINING	Mining Bag	Mining Bag		Bergbautasche		채광 가방		礦石包	Сумка шахтера			
SUBFILTER_SUBTYPE_CONTAINER_LEATHERWORKING	Leatherworking Bag	Leatherworking Bag		Lederverarbeitungstasche		가죽세공 가방		製皮包	Сумка снятия шкур			
SUBFILTER_SUBTYPE_CONTAINER_INSCRIPTION	Inscription Bag	Inscription Bag		Inschriftentasche		주문각인 가방		銘文包	Сумка начертателя			
SUBFILTER_SUBTYPE_CONTAINER_TACKLE	Tackle Box	Tackle Box		Angelkasten		낚시 가방		釣餌箱	Ящик для снастей			
SUBFILTER_SUBTYPE_CONTAINER_COOKING	Cooking Bag	Cooking Bag		Kochtasche		요리 가방		烹飪包	Сумка повара			
SUBFILTER_SUBTYPE_GEM_INTELLECT	Intellect	Intellect		Intellekt		지능		智力	Интеллект			
SUBFILTER_SUBTYPE_GEM_AGILITY	Agility	Agility		Agilität		민첩		敏捷	Ловкость			
SUBFILTER_SUBTYPE_GEM_STRENGTH	Strength	Strength		Stärke		힘		力量	Сила			
SUBFILTER_SUBTYPE_GEM_STAMINA	Stamina	Stamina		Ausdauer		체력		耐力	Выносливость			
SUBFILTER_SUBTYPE_GEM_SPIRIT	Spirit	Spirit		Geist		영혼		精神	Дух			
SUBFILTER_SUBTYPE_GEM_CRITICAL_STRIKE	Critical Strike	Critical Strike		Kritischer Schlag		치명타		致命一擊	Критический удар			
SUBFILTER_SUBTYPE_GEM_MASTERY	Mastery	Mastery		Meisterschaft		특화		精通	Искусность			
SUBFILTER_SUBTYPE_GEM_HASTE	Haste	Haste		Tempo		가속		加速	Скорость			
SUBFILTER_SUBTYPE_GEM_VERSATILITY	Versatility	Versatility		Vielseitigkeit		유연성		臨機應變	Универсальность			
SUBFILTER_SUBTYPE_GEM_OTHER	Other	Other		Anderes		그 외		其他	Другое			
SUBFILTER_SUBTYPE_GEM_MULTIPLE_STATS	Multiple Stats	Multiple Stats		Mehrere Attribute		다중 능력치		多項屬性	Неск. характеристик			
SUBFILTER_SUBTYPE_GEM_ARTIFACT_RELIC	Artifact Relic	Artefact Relic		Artefaktrelikt		유물 보석		神兵聖物	Реликвия артефакта			
SUBFILTER_SUBTYPE_GLYPH_WARRIOR	Warrior	Warrior		Krieger		전사		戰士	Воин			
SUBFILTER_SUBTYPE_GLYPH_PALADIN	Paladin	Paladin		Paladin		성기사		聖騎士	Паладин			
SUBFILTER_SUBTYPE_GLYPH_HUNTER	Hunter	Hunter		Jäger		사냥꾼		獵人	Охотник			
SUBFILTER_SUBTYPE_GLYPH_ROGUE	Rogue	Rogue		Schurke		도적		盜賊	Разбойник			
SUBFILTER_SUBTYPE_GLYPH_PRIEST	Priest	Priest		Priester		사제		牧師	Жрец			
SUBFILTER_SUBTYPE_GLYPH_DEATH_KNIGHT	Death Knight	Death Knight		Todesritter		죽음의 기사		死亡騎士	Рыцарь смерти			
SUBFILTER_SUBTYPE_GLYPH_SHAMAN	Shaman	Shaman		Schamane		주술사		薩滿	Шаман			
SUBFILTER_SUBTYPE_GLYPH_MAGE	Mage	Mage		Magier		마법사		法師	Маг			
SUBFILTER_SUBTYPE_GLYPH_WARLOCK	Warlock	Warlock		Hexenmeister		흑마법사		術士	Чернокнижник			
SUBFILTER_SUBTYPE_GLYPH_MONK	Monk	Monk		Mönch		수도사		武僧	Монах			
SUBFILTER_SUBTYPE_GLYPH_DRUID	Druid	Druid		Druide		드루이드		德魯伊	Друид			
SUBFILTER_SUBTYPE_GLYPH_DEMON_HUNTER	Demon Hunter	Demon Hunter		Dämonenjäger		악마 사냥꾼		惡魔獵人	Охотник на демонов			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_HEAD	Head	Head		Kopf		머리		頭部	Голова			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_NECK	Neck	Neck		Hals		목		頸部	Шея			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_SHOULDER	Shoulder	Shoulder		Schulter		어깨		肩部	Плечи			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_CLOAK	Cloak	Cloak		Umhang		등		背部	Плащ			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_CHEST	Chest	Chest		Brust		가슴		胸部	Грудь			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_WRIST	Wrist	Wrist		Handgelenk		손목		手腕	Запястья			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_HANDS	Hands	Hands		Hände		손		手	Кисти			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_WAIST	Waist	Waist		Hüfte		허리		腰部	Пояс			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_LEGS	Legs	Legs		Beine		다리		腿部	Ноги			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_FEET	Feet	Feet		Füße		발		腳	Обувь			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_FINGER	Finger	Finger		Finger		손가락		手指	Палец			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_ONE_HAND	One-Handed Weapons	One-Handed Weapons		Einhandwaffen		한손 무기		單手武器	Одноручное			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_TWO_HAND	Two-Handed Weapons	Two-Handed Weapons		Zweihandwaffen		양손 무기		雙手武器	Двуручное			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_SHIELD_OFF_HAND	Shield/Offhand	Shield/Offhand		Schild/Nebenhand		방패/보조무기		盾牌/副手	Щит/левая рука			
SUBFILTER_SUBTYPE_ITEM_ENHANCEMENT_MISCELLANEOUS	Misc	Misc		Verschidenes		기타		雜項	Разное			
SUBFILTER_SUBTYPE_KEY_KEY	Key	Key		Schlüssel		열쇠		鑰匙	Ключ			
SUBFILTER_SUBTYPE_KEY_LOCKPICK	Lockpick	Lockpick		Dietrich		자물쇠		開鎖器	Отмычка			
SUBFILTER_SUBTYPE_MISCELLANEOUS_JUNK	Junk	Junk		Schrott		잡동사니		垃圾	Мусор			
SUBFILTER_SUBTYPE_MISCELLANEOUS_REAGENTS	Spell Reagents	Spell Reagents		Zauberreagenzien		주문 재료		施法材料	Для заклинаний			
SUBFILTER_SUBTYPE_MISCELLANEOUS_COMPANION_PETS	Companion Pets	Companion Pets		Begleithaustiere		전투 애완동물		寵物夥伴	Питомцы			
SUBFILTER_SUBTYPE_MISCELLANEOUS_HOLIDAY	Holiday	Holiday		Feiertag		이벤트		節慶用品	Праздничные			
SUBFILTER_SUBTYPE_MISCELLANEOUS_OTHER	Other	Other		Anderes		그 외		其他	Другое			
SUBFILTER_SUBTYPE_MISCELLANEOUS_MOUNT	Mount	Mount		Reittier		탈것		坐騎	Транспорт			
SUBFILTER_SUBTYPE_MISCELLANEOUS_MOUNT_EQUIPMENT	Mount Equipment	Mount Equipment		Reittierausrüstung		탈것 장비		坐騎裝備	Добавление трапспорта			
SUBFILTER_SUBTYPE_RECIPE_BOOK	Book	Book		Buch		책		書籍	Книга			
SUBFILTER_SUBTYPE_RECIPE_LEATHERWORKING	Leatherworking	Leatherworking		Lederverarbeitung		가죽세공		製皮	Снятие шкур			
SUBFILTER_SUBTYPE_RECIPE_TAILORING	Tailoring	Tailoring		Schneidern		주문각인		裁縫	Портняжное дело			
SUBFILTER_SUBTYPE_RECIPE_ENGINEERING	Engineering	Engineering		Ingenieurwissenschaft		기계공학		工程學	Инженерное дело			
SUBFILTER_SUBTYPE_RECIPE_BLACKSMITHING	Blacksmithing	Blacksmithing		Schmiedekunst		대장기술		鍛造	Кузнечное дело			
SUBFILTER_SUBTYPE_RECIPE_COOKING	Cooking	Cooking		Kochen		요리		烹飪	Кулинария			
SUBFILTER_SUBTYPE_RECIPE_ALCHEMY	Alchemy	Alchemy		Alchemie		연금술		煉金術	Алхимия			
SUBFILTER_SUBTYPE_RECIPE_FIRST_AID	First Aid	First Aid		Erste Hilfe		응급치료		急救	Первая помощь			
SUBFILTER_SUBTYPE_RECIPE_ENCHANTING	Enchanting	Enchanting		Verzauberkunst		마법부여		附魔	Наложение чар			
SUBFILTER_SUBTYPE_RECIPE_FISHING	Fishing	Fishing		Angeln		낚시		釣魚	Рыбная ловля			
SUBFILTER_SUBTYPE_RECIPE_JEWELCRAFTING	Jewelcrafting	Jewelcrafting		Juwelenschleifen		보석세공		珠寶設計	Ювелирное дело			
SUBFILTER_SUBTYPE_RECIPE_INSCRIPTION	Inscription	Inscription		Inschriftenkunde		주문각인		銘文	Начертание			
SUBFILTER_SUBTYPE_PROJECTILE_ARROW	Arrow	Arrow		Pfeil		화살		箭	Стрела			
SUBFILTER_SUBTYPE_PROJECTILE_BULLET	Bullet	Bullet		Kugel		탄약		子彈	Пуля			
SUBFILTER_SUBTYPE_QUIVER_QUIVER	Quiver	Quiver		Köcher		화살통		箭袋	Колчан			
SUBFILTER_SUBTYPE_QUIVER_AMMO_POUCH	Ammo Pouch	Ammo Pouch		Munitionsbeutel		탄약 주머니		彈藥袋	Боеприпасы			
SUBFILTER_SUBTYPE_TRADE_GOODS_PARTS	Parts	Parts		Teile		부품		零件	Запчасти			
SUBFILTER_SUBTYPE_TRADE_GOODS_JEWELCRAFTING	Jewelcrafting	Jewelcrafting		Juwelenschleifen		보석세공		珠寶設計	Ювелирное дело			
SUBFILTER_SUBTYPE_TRADE_GOODS_CLOTH	Cloth	Cloth		Kleidung		천		布料	Ткань			
SUBFILTER_SUBTYPE_TRADE_GOODS_LEATHER	Leather	Leather		Lederverarbeitung		가죽		皮革	Кожа			
SUBFILTER_SUBTYPE_TRADE_GOODS_METAL_AND_STONE	Metal & Stone	Metal & Stone		Metall & Stein		금속 & 돌		金屬與石頭	Металл/камень			
SUBFILTER_SUBTYPE_TRADE_GOODS_COOKING	Cooking	Cooking		Kochen		요리		烹飪	Кулинария			
SUBFILTER_SUBTYPE_TRADE_GOODS_HERB	Herb	Herb		Kräuter		약초		草藥	Травничество			
SUBFILTER_SUBTYPE_TRADE_GOODS_ELEMENTAL	Elemental	Elemental		Elementar		원소		元素材料	Стихия			
SUBFILTER_SUBTYPE_TRADE_GOODS_ENCHANTING	Enchanting	Enchanting		Verzauberkunst		마법부여		附魔	Наложение чар			
SUBFILTER_SUBTYPE_TRADE_GOODS_INSCRIPTION	Inscription	Inscription		Inschriftenkunde		주문각인		銘文	Начертание			
SUBFILTER_SUBTYPE_TRADE_GOODS_OTHER	Other	Other		Andere		그 외		其他	Другое			
SUBFILTER_SUBTYPE_WEAPON_AXES	Axes	Axes		Äxte		도끼		斧	Топоры			
SUBFILTER_SUBTYPE_WEAPON_MACES	Maces	Maces		Keulen		둔기		錘	Булавы			
SUBFILTER_SUBTYPE_WEAPON_SWORDS	Swords	Swords		Schwerter		도검		劍	Мечи			
SUBFILTER_SUBTYPE_WEAPON_DAGGERS	Daggers	Daggers		Dolche		단검		匕首	Кинжалы			
SUBFILTER_SUBTYPE_WEAPON_POLEARMS	Polearms	Polearms		Stangenwaffen		장창		長柄	Древковое			
SUBFILTER_SUBTYPE_WEAPON_FIST	Fist Weapons	Fist Weapons		Faustwaffen		장착무기		拳套	Кистевое			
SUBFILTER_SUBTYPE_WEAPON_GLAIVES	Warglaives	Warglaives		Kriegsgleven		전투검		戰刃	Боевые клинки			
SUBFILTER_SUBTYPE_WEAPON_WANDS	Wands	Wands		Zauberstäbe		마법봉		魔杖	Жезлы			
SUBFILTER_SUBTYPE_WEAPON_STAVES	Staves	Staves		Stäbe		지팡이		法杖	Посохи			
SUBFILTER_SUBTYPE_WEAPON_BOWS	Bows	Bows		Bögen		활		弓	Луки			
SUBFILTER_SUBTYPE_WEAPON_CROSSBOWS	Crossbows	Crossbows		Armbrüste		석궁		弩	Арбалет			
SUBFILTER_SUBTYPE_WEAPON_GUNS	Guns	Guns		Pistolen		총		槍械	Ружьё			
SUBFILTER_SUBTYPE_WEAPON_THROWN	Thrown	Thrown		Wurfwaffen		투척		投擲武器	Метательное			
SUBFILTER_SUBTYPE_WEAPON_FISHING_POLES	Fishing Poles	Fishing Poles		Angelruten		낚싯대		魚竿	Удочки			
SUBFILTER_SUBTYPE_WEAPON_MISCELLANEOUS	Miscellaneous	Miscellaneous		Verschiedenes		기타		雜項	Разное			
SUBFILTER_STATS_STAMINA	Stamina	Stamina		Ausdauer		체력		耐力	Выносливость			
SUBFILTER_STATS_STRENGTH	Strength	Strength		Stärke		힘		力量	Сила			
SUBFILTER_STATS_AGILITY	Agility	Agility		Beweglichkeit		민첩		敏捷	Ловкость			
SUBFILTER_STATS_INTELLECT	Intellect	Intellect		Intellekt		지능		智力	Интеллект			
SUBFILTER_STATS_CRITICAL_STRIKE	Critical Strike	Critical Strike		Kritische Trefferchance		치명타		致命一擊	Крит. удар			
SUBFILTER_STATS_HASTE	Haste	Haste		Tempo		가속		加速	Скорость			
SUBFILTER_STATS_MASTERY	Mastery	Mastery		Meisterschaft		특화		精通	Искусность			
SUBFILTER_STATS_VERSATILITY	Versatility	Versatility		Vielseitigkeit		유연성		臨機應變	Универсальность			
SUBFILTER_STATS_SPEED	Speed	Speed		Geschwindigkeit		이동속도		速度	Скор. передвижения			
SUBFILTER_STATS_INDESTRUCTIBLE	Indestructible	Indestructible		Unzerstörbar		파괴 불가		永不磨損	Броня			
SUBFILTER_STATS_LEECH	Leech	Leech		Lebensraub		생기흡수		汲取	Самоисцеление			
SUBFILTER_STATS_AVOIDANCE	Avoidance	Avoidance		Vermeidung		회피		迴避	Узбегание			
SUBFILTER_QUALITY_HEIRLOOM	Heirloom	Heirloom		Erbstück		계승		傳家寶	Наследие			
SUBFILTER_QUALITY_ARTIFACT	Artifact	Artefact		Artefakt		유물		神器	Артефакт			
SUBFILTER_QUALITY_LEGENDARY	Legendary	Legendary		Legendär		전설		傳奇	Легендарное			
SUBFILTER_QUALITY_EPIC	Epic	Epic		Episch		영웅		史詩	Эпичное			
SUBFILTER_QUALITY_RARE	Rare	Rare		Selten		희귀		精良	Редкое			
SUBFILTER_QUALITY_UNCOMMON	Uncommon	Uncommon		Ungewöhnlich		고급		良好	Необычное			
SUBFILTER_QUALITY_COMMON	Common	Common		Gewöhnlich		일반		普通	Обычное			
SUBFILTER_QUALITY_POOR	Poor	Poor		Armbrüste		하급		粗劣	Хлам			
SUBFILTER_TIME_SECOND_SHORT	Sec	Sec		Sek.		초		秒	сек			
SUBFILTER_TIME_SECONDS	Seconds	Seconds		Sekunden		초		秒	Секунд			
SUBFILTER_TIME_SECONDS_SHORT	Secs	Secs		Sek.		초		秒	сек.			
SUBFILTER_TIME_MINUTE_SHORT	Min	Min		Min.		분		分	мин.			
SUBFILTER_TIME_MINUTES	Minutes	Minutes		Minuten		분		分鐘	минут			
SUBFILTER_TIME_MINUTES_SHORT	Mins	Mins		Min.		분		分	мин.			
SUBFILTER_TIME_HOUR_SHORT	Hour	Hour		Stunde		시간		小時	час			
SUBFILTER_TIME_HOURS	Hours	Hours		Stunden		시간		小時	часов			
SUBFILTER_TIME_HOURS_SHORT	Hrs	Hrs		h		시간		小時	ч.			
SUBFILTER_TIME_DAY_SHORT	Day	Day		Tag		일		天	день			
SUBFILTER_TIME_DAYS	Days	Days		Tage		일		天	дней			
SUBFILTER_TIME_DAYS_SHORT	Days	Days		Tage		일		天	дн.			
SUBFILTER_TIME_WEEK_SHORT	Week	Week		Woche		주		週	неделя			
SUBFILTER_TIME_WEEKS	Weeks	Weeks		Wochen		주		週	недель			
SUBFILTER_TIME_WEEKS_SHORT	Wks	Wks		W.		주		週	н.			
SUBFILTER_TIME_MONTH_SHORT	Mnth	Mnth		Mon.		개월		月	месяц			
SUBFILTER_TIME_MONTHS	Months	Months		Monate		개월		月	месяцев			
SUBFILTER_TIME_MONTHS_SHORT	Mths	Mths		Mon.		개월		月	мес.			
SUBFILTER_TIME_YEAR_SHORT	Year	Year		Jahr		년		年	год			
SUBFILTER_TIME_YEARS	Years	Years		Jahre		년		年	лет			
SUBFILTER_TIME_YEARS_SHORT	Yrs	Yrs		J.		년		年	г.			
SUBFILTER_BINDING_NONE	None	None		Nichts		없음		無	нет			
SUBFILTER_BINDING_ON_EQUIP	Bind on Equip	Bind on Equip		Binden beim Anlegen		착용 시 귀속		裝備後				
SUBFILTER_BINDING_ON_EQUIP_SHORT	Equip	Equip		Anlegen		착귀		裝綁				
SUBFILTER_BINDING_ON_PICKUP	Bind on Pickup	Bind on Pickup		Binden beim Aufnehmen		획득 시 귀속		拾取後				
SUBFILTER_BINDING_ON_PICKUP_SHORT	Pickup	Pickup		Aufnehmen		획귀		拾綁				
SUBFILTER_BINDING_ON_USE	Bind on Use	Bind on Use		Binden beim Benutzen		사용 시 귀속		使用後				
SUBFILTER_BINDING_ON_USE_SHORT	Use	Use		Benutzen		사용		用綁	Исп.			
SUBFILTER_BINDING_SOULBOUND	Soulbound	Soulbound		Seelengebunden		계정 귀속		靈魂綁定				
SUBFILTER_BINDING_SOULBOUND_SHORT	Bound	Bound		Gebunden		계귀		綁定				
SUBFILTER_EXPANSION_TBC	The Burning Crusade	The Burning Crusade		The Burning Crusade		불타는 성전		燃燒的遠征	The Burning Crusade			
SUBFILTER_EXPANSION_TBC_SHORT	TBC	TBC		TBC		불성		遠征	TBC			
SUBFILTER_EXPANSION_WOTLK	Wrath of the Lich King	Wrath of the Lich King		Wrath of the Lich King		리치왕의 분노		巫妖王之怒	Wrath of the Lich King			
SUBFILTER_EXPANSION_WOTLK_SHORT	Wrath	Wrath		Wrath		리분		巫妖王	Lich King			
SUBFILTER_EXPANSION_CATA	Cataclysm	Cataclysm		Cataclysm		대격변		浩劫與重生	Cataclysm			
SUBFILTER_EXPANSION_CATA_SHORT	Cata	Cata		Cata		격변		浩劫	Cata			
SUBFILTER_EXPANSION_MOP	Mists of Pandaria	Mists of Pandaria		Mists of Pandaria		판다리아의 안개		潘達利亞迷霧	Mists of Pandaria			
SUBFILTER_EXPANSION_MOP_SHORT	MoP	MoP		MoP		판다		潘達	MoP			
SUBFILTER_EXPANSION_WOD	Warlords of Draenor	Warlords of Draenor		Warlords of Draenor		드레노어의 전쟁군주		德拉諾之霸	Warlords of Draenor			
SUBFILTER_EXPANSION_WOD_SHORT	WoD	WoD		WoD		드군		德拉諾	WoD			
SUBFILTER_EXPANSION_LEGION	Legion	Legion		Legion		군단		軍臨天下	Legion			
SUBFILTER_EXPANSION_LEGION_SHORT	Legion	Legion		Legion		군단		軍臨	Legion			
SUBFILTER_EXPANSION_BFA	Battle for Azeroth	Battle for Azeroth		Battle for Azeroth		격전의 아제로스		決戰艾澤拉斯	Battle for Azeroth			
SUBFILTER_EXPANSION_BFA_SHORT	BfA	BfA		BfA		격아		決戰	BfA			
SUBFILTER_EXPANSION_SHADOW	Shadowlands	Shadowlands		Shadowlands		어둠땅		暗影之境	Shadowlands			
SUBFILTER_EXPANSION_SHADOW_SHORT	Shadow	Shadow		Shadow		둠땅		暗影	Shadow			
SUBFILTER_LEVEL_ITEM_LEVEL	Item Level	Item Level		Gegenstandslevel		아이템 레벨		物品等級	Ур. предмета			
SUBFILTER_LEVEL_REQUIRED_LEVEL	Required Level	Required Level		Benötigtes Level		착용 레벨		需求等級	Треб. уровень			
SUBFILTER_MARKER_ICON_NONE	None	None		Nichts		없음		無	нет			
SUBFILTER_SPECIFIC_ITEMS_ID	ID	ID		ID		ID		ID	ID			
SUBFILTER_SPECIFIC_ITEMS_NAME	Name	Name		Name		이름		名稱	Имя			
CONFIG_APPEARANCE	Appearance	Appearance		Aussehen		외형		外觀	Внешность			
CONFIG_BEHAVIOR	Behavior	Behavior		Verhalten		동작		動作	Поведение			
CONFIG_CATEGORIES	Categories	Categories		Kategorien		분류		類別	Категории			
CONFIG_COLUMNS	Columns	Columns		Spalten		열		欄目	Столбцы			
CONFIG_PROFILES	Profiles	Profiles		Profile		프로필		設定檔	Профили			
CONFIG_APPEARANCE_SCALE	Scale	Scale		Skalierung		크기 비율		縮放	Масштаб			
CONFIG_APPEARANCE_ICON_SIZE	Icon Size	Icon Size		Symbolgröße		아이콘 크기		圖示尺寸	Размер значков			
CONFIG_APPEARANCE_ICON_BORDERS	Icon Borders	Icon Borders		Symbolränder		아이콘 테두리		圖示外框	Границы значков			
CONFIG_APPEARANCE_SPACING	Spacing	Spacing		Abstand		간격		間距	Интервал			
CONFIG_APPEARANCE_BACKDROP_OPACITY	Backdrop Opacity	Backdrop Opacity		Hintergrunddeckkraft		배경 투명도		背景透明度	Прозрачность			
CONFIG_APPEARANCE_FONT	Font	Font		Schrift		폰트		字體	Шрифт			
CONFIG_APPEARANCE_FONT_SIZE	Size	Size		Größe		크기		尺寸	Размер			
CONFIG_APPEARANCE_FONT_SIZE_1	Tiny	Tiny		Winzig		매우 작음		超小				
CONFIG_APPEARANCE_FONT_SIZE_2	Small	Small		Kleintier		작음		小				
CONFIG_APPEARANCE_FONT_SIZE_3	Normal	Normal		Normal		기본		普通				
CONFIG_APPEARANCE_FONT_SIZE_4	Large	Large		Groß		큼		大				
CONFIG_APPEARANCE_FONT_SIZE_5	Huge	Huge		Riesig		매우 큼		超大				
CONFIG_APPEARANCE_FONT_OUTLINE	Outline	Outline		Outline		외곽선		描邊				
CONFIG_APPEARANCE_FONT_OUTLINE_1	None	None		Nichts		없음		無				
CONFIG_APPEARANCE_FONT_OUTLINE_2	Thin	Thin		Dünn		얇음		細				
CONFIG_APPEARANCE_FONT_OUTLINE_3	Thick	Thick		Dick		굵음		粗				
CONFIG_APPEARANCE_SIDE_PANE_WIDTH	Side Pane Width	Side Pane Width		Seitenpanelbreite		측면 칸 넓이		側窗格寬度	Ширина бок. панели			
CONFIG_APPEARANCE_ALWAYS_USE_ICONS	Always Use Icons	Always Use Icons		Immer Symbole benutzen		항상 아이콘 사용		永遠使用圖示	Всегда исп. значки			
CONFIG_BEHAVIOR_SCROLL_WHEEL_SPEED	Wheel Scroll Speed	Wheel Scroll Speed		Mausradgeschwindigkeit		스크롤 속도		滾輪捲動速度	Скорость прокрутки			
CONFIG_BEHAVIOR_SMOOTH_SCROLLING	Smooth Scrolling	Smooth Scrolling		Sanftes Scrollen		부드러운 스크롤		平滑捲動	Плавная прокрутка			
CONFIG_BEHAVIOR_SMOOTH_SCROLLING_POWER	Smoothing Strength	Smoothing Strength		Sanftheit-Stärke		부드러움 강도		平滑強度	Сглаживание			
CONFIG_BEHAVIOR_ANIMATIONS	Animations	Animations		Animationen		애니메이션		動畫效果	Анимация			
CONFIG_BEHAVIOR_RESET_WINDOW	Reset Window on Close	Reset Window on Close		Fenster beim Schließen zurücksetzen		닫으면 창 초기화		關閉後重設視窗	Сброс при закрытии			
CONFIG_BEHAVIOR_COMBINE_STACKS	Combine Stacks	Combine Stacks		Stapel kombinieren		갯수 합치기		合併堆疊	Объед. пачки			
CONFIG_BEHAVIOR_TOOLTIP_DELAY	Tooltip Delay	Tooltip Delay		Tooltip-Verzögerung		툴팁 등장 속도		工具提示延遲	Задержка подсказки			
CONFIG_BEHAVIOR_TOOLTIP_DELAY_SECOND	Second	Second		Sekunden		초		秒	Секунда			
CONFIG_BEHAVIOR_TOOLTIP_DELAY_SECONDS	Seconds	Seconds		Sekunden		초		秒	Секунд			
CONFIG_CATEGORIES_NAME	Name	Name		Name		이름		名稱	Имя			
CONFIG_CATEGORIES_ICON	Icon	Icon		Symbol		아이콘		圖示	Значок			
CONFIG_CATEGORIES_FILTERS	Filters	Filters		Filter		필터		類別篩選	Фильтр			
CONFIG_CATEGORIES_ADD	Add Category	Add Category		Kategorie hinzufügen		분류 추가		新增類別	Доб. категорию			
CONFIG_CATEGORIES_DEFAULT_NAME	New Category	New Category		Neue Kategorie		새 분류		新類別	Новая категория			
CONFIG_COLUMNS_COLUMN	Column	Column		Spalte		열		欄目	Столбец			
CONFIG_COLUMNS_WIDTH	Width	Width		Breite		넓이		寬度	Ширина			
CONFIG_COLUMNS_ENABLED	Enabled	Enabled		Aktiviert		활성화		啟用	Вкл.			
CONFIG_PROFILES_PROFILE	Settings Profile	Settings Profile		Einstellungsprofil		사용중인 프로필		配置設定檔	Настройки профиля			
CONFIG_PROFILES_NAME	Name	Name		Name		이름		名稱	Имя			
CONFIG_PROFILES_NEW	New	New		Neu		생성		新	Новый			
CONFIG_PROFILES_COPY	Copy	Copy		Kopieren		복사		複製	Копир.			
CONFIG_PROFILES_DELETE	Delete	Delete		Löschen		삭제		刪除	Удалить			
CONFIG_PROFILES_DEFAULT_NAME	New Profile	New Profile		Neues Profil		새 프로필		新設定檔	Новый профиль			
TOOLTIP_TITLE_ACCOUNT_GOLD	Account Gold	Account Gold		Accountweites Gold		계정 골드		帳號金錢	Золото акквунта			
TOOLTIP_TITLE_BAGS	Bags	Bags		Taschen		가방		背包	Сумки			
TOOLTIP_TITLE_BANK	Bank Bags	Bank Bags		Bankfächer		은행 가방		銀行容器	Сумки банка			
TOOLTIP_TITLE_REAGENTS	Reagent Bank	Reagent Bank		Reagenzienbank		재료 가방		材料銀行	Банк реагентов			
TOOLTIP_CONFIG	Configure Sorted.	Configure Sorted.		Sorted. konfigurieren		Sorted. 설정		設置Sorted。	Настройки			
TOOLTIP_MINIMISE	Hide Side Panel	Hide Side Panel		Seitenpanel verstecken		측면 칸 숨기기		隱藏側窗格	Скрыть боковую панель			
TOOLTIP_MAXIMISE	Show Side Panel	Show Side Panel		Seitenpanel anzeigen		측면 칸 보이기		顯示側窗格	Показать боковую панель			
TOOLTIP_KEYRING	Keyring	Keyring		Schlüsselring		열쇠고리		鑰匙圈	Брелок			
TOOLTIP_CONTAINER_BACKPACK	Backpack	Backpack		Rucksack		배낭		背包	Рюкзак			
TOOLTIP_CONTAINER_BANK	Bank	Bank		Bankfächer		은행		銀行	Банк			
TOOLTIP_CONTAINER_REAGENTS	Reagents	Reagents		Reagenzien		재료 은행		材料銀行	Реагенты			
TOOLTIP_CLEANUP_BAGS	< Click to Clean Up Bags >	< Click to Clean Up Bags >		Klicken um Tasche aufzuräumen		< 가방 정리하기 >		< 點擊以整理背包 >	<Щелкните, чтобы очистить сумки>			
TOOLTIP_CLEANUP_BANK	< Click to Clean Up Bank >	< Click to Clean Up Bank >		Klicken um Bank aufzuräumen		< 은행 정리하기 >		< 點擊以整理銀行 >	<Щелкните, чтобы очистить банк>			
TOOLTIP_CLEANUP_REAGENTS	< Click to Clean Up Reagents >	< Click to Clean Up Reagents >		Klicken um Reagenzien aufzuräumen		< 재료 은행 정리하기 >		< 點擊以整理材料銀行 >	<Щелкните, чтобы очистить банк реагентов>			
TOOLTIP_FORGET_CHARACTER	Forget %s\n|cffffffffFree up memory by clearing the data that Sorted has kept on this characters.\n|cffff000000You will no longer be able to preview their items!	Forget %s\n|cffffffffFree up memory by clearing the data that Sorted has kept on this characters.\n|cffff000000You will no longer be able to preview their items!				%s 지우기\n|cffffffff이 캐릭터에 대한 Sorted의 데이터를 지워 메모리를 확보합니다. \n|cffff000000더 이상 이 캐릭터의 아이템을 확인할 수 없습니다!		遺忘 %s\n|cffffffff通過清除Sorted保留在此\n角色的數據來釋放記憶體。\n|cffff000000您將不再能夠預覽他們的物品！	Удалить\n|cffffffffОсвободите память, очистив данные, которые Sorted сохранил для персонажей.\n|cffffffffВы больше не сможете просмотреть их!			
TOOLTIP_CONFIG_ALWAYS_USE_ICONS	Always Use Icons:\n|cffffffffHides the default category buttons and forces Sorted \nto use the icons instead, which usually only show when \nthe side pane is minimised.\n\n|cffffee00With this checked, and the side pane maximised, the entire height\nof the window will be used for the category's checkbuttons.\nIn this case, the side pane hides automatically.	Always Use Icons:\n|cffffffffHides the default category buttons and forces Sorted \nto use the icons instead, which usually only show when \nthe side pane is minimised.\n\n|cffffee00With this checked, and the side pane maximised, the entire height\nof the window will be used for the category's checkbuttons.\nIn this case, the side pane hides automatically.				항상 아이콘 사용하기:\n|cffffffffSorted가 원래의 카테고리 버튼 대신 아이콘을 사용하도록 합니다.\n일반적으론 측면 칸을 접은 경우에만 나타납니다.\n\n|cffffee00이 옵션을 체크하면 세부 분류를 고를 수 있는 공간이 최대화됩니다.\n기존의 대분류 버튼은 자동으로 숨겨집니다.		永遠使用圖示:\n|cffffffff隱藏預設的類別文字按鈕，強制改用圖示\n就像是隱藏側窗格時所顯示的樣子\n\n|cffffee00勾選後,顯示側窗格時，整塊區域都會用來\n顯示類別的核取方塊，此時側窗格也會自動隱藏。	Всегда использовать значки:\n|cffffffffСкрывает кнопки категорий по умолчанию и заставляет Sorted использовать вместо них значки, которые обычно отображаются, только когда боковая панель свернута.			
TOOLTIP_CONFIG_SCROLL_WHEEL_SPEED	Wheel Scroll Speed:\n|cffffffffAdjust how far Sorted should scroll\nper each step of the scroll wheel.\n\n|cffffee00(You can hold ALT at any time to scroll quickly)	Wheel Scroll Speed:\n|cffffffffAdjust how far Sorted should scroll\nper each step of the scroll wheel.\n\n|cffffee00(You can hold ALT at any time to scroll quickly)				스크롤 속도:\n|cffffffff마우스 휠의 한 단계마다 Sorted가 스크롤할 범위를 조정합니다.\n\n|cffffee00(언제든지 ALT를 누르고 있으면 빠르게 스크롤할 수 있습니다)		滾輪捲動速度:\n|cffffffff調整Sorted的滾輪\n每一步應滾動的距離。\n\n|cffffee00(您可以隨時按住ALT快速滾動)	Скорость прокрутки колеса:\n|cffffffffУстановите, насколько далеко Sorted должен прокручивать на каждом шаге колеса прокрутки.\n|cffffffff(Вы можете удерживать ALT для быстрой прокрутки).			
TOOLTIP_CONFIG_SMOOTH_SCROLLING	Smooth Scrolling:\n|cffffffffToggles whether Sorted should smoothly animate\nwhen scrolling. Raise the smoothing strength to\nincrease the duration of the animation.\n\n|cffffee00(Disable to improve performance)	Smooth Scrolling:\n|cffffffffToggles whether Sorted should smoothly animate\nwhen scrolling. Raise the smoothing strength to\nincrease the duration of the animation.\n\n|cffffee00(Disable to improve performance)				부드러운 스크롤:\n|cffffffff스크롤 할 때 Sorted가 부드러운 애니메이션을 가하도록 조정합니다.\n부드러움 강도를 높여서 애니메이션 속도를 늘릴 수 있습니다.\n\n|cffffee00(비활성화하면 성능이 향상됨)		平滑捲動:\n|cffffffff切換Sorted是否有平滑的捲動動畫\n滾動時，提高平滑強度\n以增加動畫的持續時間。\n\n|cffffee00(停用來提高性能)	Плавная прокрутка:\n|cffffffffВключает, должна ли Sorted  плавную анимацию при прокрутке.\n|cffffffffУвеличьте сглаживание, чтобы увеличить продолжительность анимации.			
TOOLTIP_CONFIG_RESET_ON_CLOSE	Reset Window on Close:\n|cffffffffLeave unchecked to have Sorted remember\nyour searching, filtering, and sorting options\nafter closing and reopening the window.	Reset Window on Close:\n|cffffffffLeave unchecked to have Sorted remember\nyour searching, filtering, and sorting options\nafter closing and reopening the window.				닫으면 창 초기화:\n|cffffffffSorted를 닫았다가 다시 열었을 때\n검색, 분류 및 정렬 우선도를 그대로 두려면\n체크하지 마십시오.		關閉後重設視窗:\n|cffffffff取消勾選以讓Sorted記憶\n您的搜尋，過濾和排序選項\n在關閉並重新開啟視窗之後。	Сбросить окно при закрытии:\n|cffffffffСнимите флажок, чтобы Sorted запомнил параметры поиска, фильтрации и сортировки после закрытия и повторного открытия окна.			
TOOLTIP_CONFIG_COMBINE_STACKS	Combine Stacks:\n|cffffffffMerges identical items into one line.\nInteracting with an item will interact with\nthe largest stack of that item in your bags.	Combine Stacks:\n|cffffffffMerges identical items into one line.\nInteracting with an item will interact with\nthe largest stack of that item in your bags.				갯수 합치기:\n|cffffffff같은 아이템을 한 줄로 합칩니다.\n아이템을 사용하면 해당 아이템 묶음 중\n가장 큰 묶음을 사용합니다.		合併堆疊:\n|cffffffff將相同的物品合併為一行。\n與物品進行互動將與您背包中\n該物品的最大堆疊物品互動。	Объединить стопки:\n|cffffffffСоединяет идентичные элементы в одну строку.			
TOOLTIP_CONFIG_REMOVE_CATEGORY	Remove "%s"	Remove "%s"				"%s" 삭제		移除 "%s"	Удалить "%s"			
TOOLTIP_BUY_BANK_SLOT	Purchase Bag Slot	Purchase Bag Slot				가방 칸 구입		購買背包格位	Купить слот			
DIALOG_DELETE_CHARACTER_DATA	You will no longer be able to preview %s's items until you next play that character	You will no longer be able to preview %s's items until you next play that character				해당 캐릭터를 다시 플레이하기 전까지 %s의 아이템을 확인할 수 없을 것입니다.		在你下次玩此角色前你再也無法預覽 %s的物品	Вы больше не сможете просматривать предметы, пока не сыграете этим персонажем в следующий раз.			
DIALOG_DELETE_SETTINGS_PROFILE	Are you sure you want to delete the settings for profile '%s'?	Are you sure you want to delete the settings for profile '%s'?				%s' 프로필 설정을 정말로 삭제하시겠습니까?		您確定想要刪除設定檔 '%s'的配置嗎？	Вы действительно хотите удалить настройки для профиля '%s'?			
DIALOG_BUTTON_ACCEPT	Accept	Accept		Annehmen		승락		接受	Принять			
DIALOG_BUTTON_CANCEL	Cancel	Cancel		Abbrechen		취소		取消	Отмена			
DIALOG_BUTTON_DELETE	Delete	Delete		Löschen		삭제		刪除	Удалить			
WARNING_BANK_NOT_CACHED	Visit a banker once to see your\nbank contents from anywhere	Visit a banker once to see your\nbank contents from anywhere				어디서나 은행 보관함을 보려면\n은행원에게 방문						
WARNING_BANK_NOT_CACHED_OTHER	Visit a banker once on %s\nto see their bank contents here	Visit a banker once on %s\nto see their bank contents here				%s의 은행원에게 방문하여\n이곳에서 은행 확인						
WARNING_REAGENTBANK_NOT_PURCHASED	Visit a banker to purchase\nthe reagent bank	Visit a banker to purchase\nthe reagent bank				은행원에게 방문하여\n재료 은행 구입						
WARNING_REAGENTBANK_NOT_PURCHASED_OTHER	Visit a banker on %s\nto purchase their reagent bank	Visit a banker on %s\nto purchase their reagent bank				%s의 은행원에게 방문하여\n재료 은행 구입						
WARNING_REAGENTBANK_PURCHASE	This tab gives you additional storage for raw profession materials.\nDo you wish to purchase this tab?	This tab gives you additional storage for raw profession materials.\nDo you wish to purchase this tab?				이 보관함에는 직업용품을 추가로 보관할 수 있습니다.\n이 보관함을 구입하시겠습니까?						
WARNING_NO_ITEMS_FOUND	No items found	No items found				아이템을 찾을 수 없음						]]

    for row in string.gmatch(tsv, "[^\r\n]+") do
        local key = string.match(row, "(.-)\t")
        localizations["enUS"][key], localizations["enGB"][key], localizations["frFR"][key], localizations["deDE"][key],
        localizations["itIT"][key], localizations["koKR"][key], localizations["zhCN"][key], localizations["zhTW"][key],
        localizations["ruRU"][key], localizations["esES"][key], localizations["esMX"][key], localizations["ptBR"][key]
            = string.match(row, ".-\t(.-)\t(.-)\t(.-)\t(.-)\t(.-)\t(.-)\t(.-)\t(.-)\t(.-)\t(.-)\t(.-)\t(.*)")
    end

    for locale, keys in pairs(localizations) do
        for key, s in pairs(keys) do
            localizations[locale][key] = s:gsub("\\n", "\r\n")
        end
    end
end
ParseTSV()

local clientLocale = GetLocale()
function Sorted.Localize(key, arg1, arg2, arg3)
    if arg1 then
        if localizations[clientLocale][key] and localizations[clientLocale][key] ~= "" then
            return localizations[clientLocale][key]:format(arg1, arg2, arg3)
        elseif localizations["enUS"][key] then
            return localizations["enUS"][key]:format(arg1, arg2, arg3)
        else
            return "["..key..":"..tostring(arg1)..":"..tostring(arg2)..":"..tostring(arg3).."]"
        end
    else
        if localizations[clientLocale][key] and localizations[clientLocale][key] ~= "" then
            return localizations[clientLocale][key]
        elseif localizations["enUS"][key] then
            return localizations["enUS"][key]
        else
            return "["..key.."]"
        end
    end
end