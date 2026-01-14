local L = LibStub("AceLocale-3.0"):NewLocale("Postal", "koKR")
if not L then return end

L["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt-클릭|r으로 이 아이템을 %s님에게 보냅니다."
L["|cffeda55fControl-Click|r to attach similar items."] = "|cffeda55fCtrl-클릭|r으로 같은 종류의 아이템을 첨부합니다."
L["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fCtrl-클릭|r으로 반송합니다."
L["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fShift-클릭|r으로 내용물을 수취합니다."
L[ [=[|cFFFFCC00*|r Selected mail will be batch opened or returned to sender by clicking Open or Return.
|cFFFFCC00*|r You can Shift-Click 2 checkboxes to mass select every mail between the 2 checkboxes.
|cFFFFCC00*|r You can Ctrl-Click a checkbox to mass select or unselect every mail from that sender.
|cFFFFCC00*|r Select will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r Select will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r 열기 또는 반송 버튼을 클릭하면 선택된 우편을 모두 열거나 반송합니다.
|cFFFFCC00*|r 2개의 체크 박스를 Shift-클릭하면 2개 체크 박스 사이의 모든 우편을 선택할 수 있습니다.
|cFFFFCC00*|r 체크 박스를 Ctrl-클릭하면 발송자의 모든 우편물을 선택하거나 해제할 수 있습니다.
|cFFFFCC00*|r 선택된 우편물은 삭제하지 않습니다 (기본적으로 내용이 없는 우편물은 첨부된 모든 아이템과 골드를 취득하면 자동으로 삭제됩니다).
|cFFFFCC00*|r 선택된 대금 청구 우편물과 블리자드 우편물은 무시합니다.
|cFFFFCC00*|r 우편을 여는 동안 대화 스팸을 중지하려면 대화창 메시지 표시 옵션을 비활성하세요.]=]
L[ [=[|cFFFFCC00*|r Shift-Click to take item/money from mail.
|cFFFFCC00*|r Ctrl-Click to return mail.
|cFFFFCC00*|r Alt-Click to move an item from your inventory to the current outgoing mail (same as right click in default UI).]=] ] = [=[|cFFFFCC00*|r Shift-클릭으로 우편에서 아이템/돈을 바로 취득 합니다.
|cFFFFCC00*|r Ctrl-클릭으로 우편물을 반송합니다.
|cFFFFCC00*|r Alt-클릭으로 아이템을 가방에서 우편함으로 바로 등록합니다.(기본 UI의 우-클릭과 같은 기능)]=]
L[ [=[|cFFFFCC00*|r Simple filters are available for various mail types.
|cFFFFCC00*|r Shift-Click the Open All button to override the filters and take ALL mail.
|cFFFFCC00*|r OpenAll will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r OpenAll will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r 간단한 필터는 다양한 우편 유형에 사용할 수 있습니다.
|cFFFFCC00*|r 모두 열기 버튼을 Shift-클릭하면 필터를 무시하고 모든 우편물을 바로 받습니다.
|cFFFFCC00*|r 모두 열기는 우편물을 삭제하지 않습니다. (기본적으로 내용이 없는 우편물은 첨부된 모든 아이템과 골드를 취득하면 자동으로 삭제됩니다).
|cFFFFCC00*|r 모두 열기는 대금 청구 우편과 블리자드 우편을 무시합니다.
|cFFFFCC00*|r 우편을 여는 동안 대화 스팸을 중지하려면 대화창 메시지 표시 옵션을 비활성하세요.]=]
L[ [=[|cFFFFCC00*|r This module will list your contacts, friends, guild mates, alts and track the last 10 people you mailed.
|cFFFFCC00*|r It will also autocomplete all names in your BlackBook.]=] ] = [=[|cFFFFCC00*|r 이 모듈은 당신의 연락처, 친구, 길드, 내 캐릭터 등 마지막으로 우편을 보낸 10명의 인원만 기억합니다.
|cFFFFCC00*|r 또한 주소록에 있는 모든 이름들을 자동완성 합니다.]=]
L["A button that collects all attachments and coins from mail."] = "편지에 첨부된 모든 물품과 골드를 수집하는 버튼입니다."
L["Add check boxes to the inbox for multiple mail operations."] = "여러 개의 우편을 동시에 작업할 수 있도록 받은 우편함에 체크 박스를 추가합니다."
L["Add Contact"] = "연락처 추가"
L["Add multiple item mail tooltips"] = "여러 아이템 우편물 툴팁 추가"
L["Adds a contact list next to the To: field."] = "받는이: 영역 옆에 연락처 목록을 추가합니다."
L["AH-related mail"] = "경매 관련 우편"
L["All Alts"] = "모든 다른 캐릭터"
L["Allows you to copy the contents of a mail."] = "편지의 내용을 복사합니다."
L["Alts"] = "현재 서버 다른 캐릭터"
L["Auto-Attach similar items on Control-Click"] = "Ctrl-클릭으로 같은 종류의 아이템 자동 첨부하기"
L["Autofill last person mailed"] = "마지막 수신자 자동 입력"
L["Auto-Send on Alt-Click"] = "Alt-클릭으로 자동 보내기"
L["BlackBook"] = "주소록"
L["Block incoming trade requests while in a mail session."] = "우편함이 열려 있는 동안 거래 요청을 차단합니다."
L["CarbonCopy"] = "복사본"
L["Chat Output"] = "대화창 출력"
L["Choose"] = "선택"
L["Clear list"] = "목록 삭제"
L["Collected"] = "수집되었습니다: "
L["Contacts"] = "연락처"
L["Copy From"] = "복사해오기"
L["Copy this mail"] = "이 편지 복사"
L["Delete"] = "삭제"
L["Disable Blizzard's auto-completion popup menu"] = "블리자드의 자동 완성 팝업 메뉴 비활성화"
L["DoNotWant"] = "반송된 우편"
L["Enable Alt-Click to send mail"] = "Alt-클릭으로 우편 보내기"
L["Exclude randoms you interacted with"] = "불규칙적인 거래자 제외"
L["Express"] = "빠른 우편"
L["Friends"] = "친구"
L["Guild"] = "길드"
L["Help"] = "도움말"
L["In Progress"] = "처리 중"
L["Keep free space"] = "여유 공간 유지"
L["Mouse click short cuts for mail."] = "마우스 클릭으로 빠르게 우편을 보냅니다."
L["Name auto-completion options"] = "이름 자동 완성 설정"
L["New Profile"] = "새 프로필"
L["New Profile Name:"] = "새 프로필 이름:"
L["Non-AH related mail"] = "경매장 외의 우편"
L["Not all messages are shown, refreshing mailbox soon to continue Open All..."] = "모든 메시지가 표시되지 않았습니다. 모두 열기를 계속 하기 위해 곧 우편함을 갱신합니다..."
L["Not taking more items as there are now only %d regular bagslots free."] = "현재 가방의 여유 공간이 %d칸으로 더이상 아이템을 가질 수 없습니다."
L["Open"] = "열기"
L["Open All"] = "모두 열기"
L["Open all Auction cancelled mail"] = "경매 취소된 우편 모두 열기"
L["Open all Auction expired mail"] = "경매 기한 만료된 우편 모두 열기"
L["Open all Auction successful mail"] = "경매 판매된 우편 모두 열기"
L["Open all Auction won mail"] = "경매 낙찰된 우편 모두 열기"
L["Open all mail with attachments"] = "우편에 첨부된 모든 물품 열기"
L["Open all Outbid on mail"] = "경매 상위 입찰된 우편 모두 열기"
L["Open mail from the Postmaster"] = "우체국장에게 받은 편지 열기"
L["OpenAll"] = "모두 열기"
L["Opening Speed"] = "열기 속도"
L["Other options"] = "기타 설정"
L["Part %d"] = "구성원 %d"
L["Please post bugs or suggestions at the wowace forums thread at |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. When posting bugs, indicate your locale and Postal's version number v%s."] = "|cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r의 wowace 포럼에서 버그 제보나 제안을 할 수 있습니다. 버그 제보 시, 귀하의 지역 언어와 버전 번호(v%s)를 알려주세요."
L["Prints the amount of money collected during a mail session."] = "우편함을 열고 있는 동안 수집되는 총 금액을 대화창에 출력합니다."
L["Processing Message"] = "메시지를 처리 중입니다:"
L["Profile"] = "프로필"
L["Rake"] = "우편 금액"
L["Recently Mailed"] = "최근 보낸 우편"
L["Refreshing mailbox..."] = "우편함을 갱신 중입니다..."
L["Remove Contact"] = "연락처 제거"
L["Reset Profile"] = "프로필 초기화"
L["Return"] = "반송"
L["Select"] = "선택"
L["Set subject field to value of coins sent if subject is blank."] = "우편으로 골드를 보낼 때 제목이 비어있는 경우 제목을 금액으로 채웁니다."
L["Shows a clickable visual icon as to whether a mail will be returned or deleted on expiry."] = "만료되어 반송되었거나 삭제된 메일에 클릭 가능한 시각적 아이콘을 표시합니다."
L["Skipping"] = "무시"
L["Some Messages May Have Been Skipped."] = "몇몇 메시지는 무시될 수 있습니다."
L["Thaumaturge Vashreen"] = "마력술사 바시린"
L["The Postmaster"] = "우체국장"
L["There are %i more messages not currently shown."] = "현재 %i개 이상의 메시지를 표시할 수 없습니다."
L["There are %i more messages not currently shown. More should become available in %i seconds."] = "현재 %i개 이상의 메시지를 표시할 수 없습니다. %i초 후에 이용이 가능합니다."
L["TradeBlock"] = "거래 차단"
L["Use Mr.Plow after opening"] = "개봉 뒤 Mr.Plow 사용"
L["Use Postal's auto-complete"] = "Postal의 자동 완성 사용"
L["Verbose mode"] = "대화창 메시지 표시"
L["Wire"] = "금액 표시"
