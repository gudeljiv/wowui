local L = LibStub("AceLocale-3.0"):NewLocale("Postal", "ruRU")
if not L then return end

L["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt+щелчок|r чтобы выслать предмет в адрес %s."
L["|cffeda55fControl-Click|r to attach similar items."] = "|cffeda55fControl+щелчок|r чтобы прикрепить аналогичные предеметы."
L["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fCtrl+щелчок|r чтобы вернуть отправителю."
L["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fShift+щелчок|r чтобы взять содержимое."
L[ [=[|cFFFFCC00*|r Selected mail will be batch opened or returned to sender by clicking Open or Return.
|cFFFFCC00*|r You can Shift-Click 2 checkboxes to mass select every mail between the 2 checkboxes.
|cFFFFCC00*|r You can Ctrl-Click a checkbox to mass select or unselect every mail from that sender.
|cFFFFCC00*|r Select will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r Select will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r Все выбранные письма будут открыты или возвращены отправителю при нажатии "Открыть" или "Вернуть".
|cFFFFCC00*|r Вы можете нажать Shift+щелчок на 2 флажка для массового выбора писем между этими 2 отмеченными флажками.
|cFFFFCC00*|r Вы можете нажать Ctrl+щелчок по флажку для массового выбора или отмены выбора всех писем от данного отправителя.
|cFFFFCC00*|r Отмеченные письма никогда не будут удаляться (письма без текста автоматически удаляются игрой после получения вложенных предметов или денег).
|cFFFFCC00*|r Письма с выкупом и письма от Blizzard будут пропущены при выборе.
|cFFFFCC00*|r Отключите детальный режим для прекращения спама в чат при открытии писем.]=]
L[ [=[|cFFFFCC00*|r Shift-Click to take item/money from mail.
|cFFFFCC00*|r Ctrl-Click to return mail.
|cFFFFCC00*|r Alt-Click to move an item from your inventory to the current outgoing mail (same as right click in default UI).]=] ] = [=[|cFFFFCC00*|r Shift+щелчок снимает с почты предметы/деньги.
|cFFFFCC00*|r Ctrl+щелчок возвращает почту.
|cFFFFCC00*|r Alt+щелчок помещает предмет из вашего инвентаря в исходящую почту (как щелчок правой кнопкой в стандартном UI).
|cFFFFCC00*|r Колесо мыши прокручивает список входящей почты.]=]
L[ [=[|cFFFFCC00*|r Simple filters are available for various mail types.
|cFFFFCC00*|r Shift-Click the Open All button to override the filters and take ALL mail.
|cFFFFCC00*|r OpenAll will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r OpenAll will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r Простые фильтры доступны для различных типов почты.
|cFFFFCC00*|r Shift+щелчок по кнопке "Открыть все" игнорирует фильтры и снимет ВСЮ почту.
|cFFFFCC00*|r "Открыть все" не будет удалять почту (письма без текста автоматически удаляются игрой после получения вложенных предметов или денег).
|cFFFFCC00*|r "Открыть все" будет пропускать письма с выкупом и письма от Blizzard.
|cFFFFCC00*|r Отключите детальный режим для прекращения спама в чат при открытии писем.]=]
L[ [=[|cFFFFCC00*|r This module will list your contacts, friends, guild mates, alts and track the last 10 people you mailed.
|cFFFFCC00*|r It will also autocomplete all names in your BlackBook.]=] ] = [=[|cFFFFCC00*|r Этот модуль будет выводить список ваших контактов, друзей, согильдийцев, альтов и отслеживать последних 10 людей, которым вы отправили почту.
|cFFFFCC00*|r Будут также автозаполнены все имена в вашем черном списке.]=]
L["A button that collects all attachments and coins from mail."] = "Кнопка, которая собирает все монеты и вложения с почты."
L["Add check boxes to the inbox for multiple mail operations."] = "Добавляет окно для пометки во входящей почте, для многочисленных операций."
L["Add Contact"] = "Добавить контакт"
L["Add multiple item mail tooltips"] = "Добавить подсказку для почты со множеством вещей."
L["Adds a contact list next to the To: field."] = "Добавляет список контактов в поле адресата."
L["AH-related mail"] = "Аукционные письма"
L["All Alts"] = "Все альты"
L["Allows you to copy the contents of a mail."] = "Позволяет скопировать текст письма."
L["Alts"] = "Альты"
L["Auto-Attach similar items on Control-Click"] = "Control+щелчок автоматически прикрепляет аналогичные предметы"
L["Autofill last person mailed"] = "Ввести в строку адреса имя последнего, кому было отправлено письмо"
L["Auto-Send on Alt-Click"] = "Автопосылка по Alt+щелчок"
L["BlackBook"] = "Черный список"
L["Block incoming trade requests while in a mail session."] = "Блокировать все запросы на торговлю во время массовой отправки почты."
L["CarbonCopy"] = "Скрытая копия"
L["Chat Output"] = "Вывод чата"
L["Choose"] = "Выбор"
L["Clear list"] = "Очистить список"
L["Collected"] = "Собрано"
L["Contacts"] = "Контакты"
L["Copy From"] = "Копировать из"
L["Copy this mail"] = "Скопировать письмо"
L["Delete"] = "Удалить"
L["Disable Blizzard's auto-completion popup menu"] = "Выключить всплывающее меню авто-заполнения Blizzard"
L["DoNotWant"] = "НеХоЧу!"
L["Enable Alt-Click to send mail"] = "Включить посылку почты по Alt+щелчок"
L["Exclude randoms you interacted with"] = "Исключать ПУГов, с которыми вы встречались."
L["Express"] = "Доставка"
L["Friends"] = "Друзья"
L["Guild"] = "Гильдия"
L["Help"] = "Справка"
L["In Progress"] = "Обрабатывается"
L["Keep free space"] = "Оставлять свободное место"
L["Mouse click short cuts for mail."] = "Щелчки мыши при открытой почте применяются как ссылки"
L["Name auto-completion options"] = "Настройки авто-заполнения имён"
L["New Profile"] = "Новый профиль"
L["New Profile Name:"] = "Имя нового профиля:"
L["Non-AH related mail"] = "Почта не с аукциона"
L["Not all messages are shown, refreshing mailbox soon to continue Open All..."] = "Не все письма показаны, почтовый ящик вскоре будет обновлен. Для продолжения нажмите \"Открыть всё\"."
L["Not taking more items as there are now only %d regular bagslots free."] = "Не брать больше вещей если в сумках осталось только %d свободных мест."
L["Open"] = "Открыть"
L["Open All"] = "Открыть всё"
L["Open all Auction cancelled mail"] = "Открывать все письма с прерванных аукционов"
L["Open all Auction expired mail"] = "Открывать все письма с несостоявшихся аукционов"
L["Open all Auction successful mail"] = "Открыть все письма с успешных аукционов"
L["Open all Auction won mail"] = "Открывать все письма с выигранных аукционов"
L["Open all mail with attachments"] = "Окрыть все письма с вложениями"
L["Open all Outbid on mail"] = "Открыть все письма с перебитыми ставками"
L["Open mail from the Postmaster"] = "Окрыть все письма Почтальон"
L["OpenAll"] = "Открыть всё"
L["Opening Speed"] = "Скорость открытия"
L["Other options"] = "Прочие опции"
L["Part %d"] = "Часть %d"
L["Please post bugs or suggestions at the wowace forums thread at |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. When posting bugs, indicate your locale and Postal's version number v%s."] = "Пожалуйста, сообщите об ошибках или предложениях на форуме wowace |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. При отправке ошибки, сообщите язык вашего клиента и номер версии Postal v%s."
L["Prints the amount of money collected during a mail session."] = "Сообщить сумму денег, собранных за сеанс работы с почтой"
L["Processing Message"] = "Обработка сообщения"
L["Profile"] = "Профиль"
L["Rake"] = "Сбор"
L["Recently Mailed"] = "Недавние корреспонденты"
L["Refreshing mailbox..."] = "Обновление списка писем"
L["Remove Contact"] = "Удалить контакт"
L["Reset Profile"] = "Сброс профиля"
L["Return"] = "Вернуть"
L["Select"] = "Выбор"
L["Set subject field to value of coins sent if subject is blank."] = "Писать в теме письма количество монет, если тема не указана."
L["Shows a clickable visual icon as to whether a mail will be returned or deleted on expiry."] = "Показывать кликабельную визуальную иконку, независимо от того, была ли почта возвращена или удалена."
L["Skipping"] = "Пропускаем"
L["Some Messages May Have Been Skipped."] = "Некоторые сообщения могли быть пропущены."
L["Thaumaturge Vashreen"] = "Чудотворец Вашрин"
L["The Postmaster"] = "Почтальон"
L["There are %i more messages not currently shown."] = "В данный момент не показано ещё %i сообщений."
L["There are %i more messages not currently shown. More should become available in %i seconds."] = "В данный момент не показано ещё %i сообщений. Они будут доставлены через %i секунд."
L["TradeBlock"] = "Блокировать торговлю"
L["Use Mr.Plow after opening"] = "Использовать Mr.Plow после открытия"
L["Use Postal's auto-complete"] = "Авто-завершение использования Postal."
L["Verbose mode"] = "Детальный режим"
L["Wire"] = "Оценка"
