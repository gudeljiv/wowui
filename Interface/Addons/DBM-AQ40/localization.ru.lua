if GetLocale() ~= "ruRU" then return end

local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization{
	name = "Пророк Скерам"
}

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization{
	name = "Семейство жуков"
}
L:SetMiscLocalization{
	Yauj = "Принцесса Яудж",
	Vem = "Вем",
	Kri = "Лорд Кри"
}

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization{
	name = "Боевой страж Сартура"
}

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization{
	name = "Фанкрисс Непреклонный"
}
--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization{
	name = "Нечистотон"
}
L:SetWarningLocalization{
	WarnFreeze	= "Заморожен: %d/3",
	WarnShatter	= "Shatter: %d/3"
}
L:SetOptionLocalization{
	WarnFreeze	= "Announce Freeze status",
	WarnShatter	= "Announce Shatter status"
}
L:SetMiscLocalization{
	Slow 		= "замедляется!",
	Freezing 	= "замораживается!",
	Frozen	 	= "застывает!",
	Phase4 		= "начинает раскалываться!",
	Phase5 		= "едва держится!",
	Phase6 		= "взрывается!",

	HitsRemain	= "Hits Remaining",
	Frost		= "Frost",
	Physical	= "Physical"
}
-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization{
	name = "Принцесса Хухуран"
}
---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization{
	name = "Императоры-близнецы"
}
L:SetMiscLocalization{
	Veklor = "Император Век'лор",
	Veknil = "Император Век'нилаш"
}

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization{
	name = "К'Тун"
}
L:SetWarningLocalization{
	WarnEyeTentacle 	= "Глазной отросток",
	WarnClawTentacle2	= "Когтещупальце",
	WarnGiantEyeTentacle	= "Огромное глазастое щупальце",
	WarnGiantClawTentacle	= "Гигантский когтещуп",
	WarnWeakened 		= "К'Тун ослаблен!"
}
L:SetTimerLocalization{
	TimerEyeTentacle	= "Глазных отроски",
	TimerGiantEyeTentacle	= "Гигантский глазной отросток",
	TimerClawTentacle	= "Когтещупальце",
	TimerGiantClawTentacle	= "Гигантское когтещупальце",
	TimerWeakened		= "Ослаблен закончен"
}
L:SetOptionLocalization{
	WarnEyeTentacle			= "Show warning for Eye Tentacle",
	WarnClawTentacle2		= "Show warning for Claw Tentacle",
	WarnGiantEyeTentacle	= "Show warning for Giant Eye Tentacle",
	WarnGiantClawTentacle	= "Show warning for Giant Claw Tentacle",
	SpecWarnWeakened		= "Show special warning when boss weaken",
	TimerEyeTentacle		= "Show timer for next Eye Tentacle",
	TimerClawTentacle		= "Show timer for next Claw Tentacle",
	TimerGiantEyeTentacle	= "Show timer for next Giant Eye Tentacle",
	TimerGiantClawTentacle	= "Show timer for next Giant Claw Tentacle",
	TimerWeakened			= "Show timer for boss weaken duration",
	RangeFrame				= "Show range frame (10)"
}
L:SetMiscLocalization{
	Stomach		= "Живота",
	Eye			= "Око К'Туна",
	FleshTent	= "Мясистое щупальце",--Localized so it shows on frame in users language, not senders
	Weakened 	= "ослаблен!",
	NotValid	= "AQ40 partially cleared. %s optional bosses remain."
}
----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization{
	name = "Оуро"
}
L:SetWarningLocalization{
	WarnSubmerge		= "Закапывание",
	WarnEmerge			= "Появление"
}
L:SetTimerLocalization{
	TimerSubmerge		= "Закапывание",
	TimerEmerge			= "Появление"
}
L:SetOptionLocalization{
	WarnSubmerge		= "Показывать предупреждение о закапывании",
	TimerSubmerge		= "Показывать таймер до закапывания",
	WarnEmerge			= "Показывать предупреждение о появлении",
	TimerEmerge			= "Показывать таймер до появления"
}
----------------
-- AQ40 Trash --
----------------
L = DBM:GetModLocalization("AQ40Trash")

L:SetGeneralLocalization{
	name = "АК40: Треш"
}
