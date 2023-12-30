function ConfirmLootRoll_OnLoad()
	-- ConfirmLootRollFrame:RegisterEvent("CONFIRM_DISENCHANT_ROLL");
	ConfirmLootRollFrame:RegisterEvent("CONFIRM_LOOT_ROLL");
	StaticPopupDialogs["CONFIRM_LOOT_ROLL"] = nil;
end

function ConfirmLootRoll_OnEvent(Event, ...)
	local arg1, arg2 = ...;
	ConfirmLootRoll(arg1, arg2);
end