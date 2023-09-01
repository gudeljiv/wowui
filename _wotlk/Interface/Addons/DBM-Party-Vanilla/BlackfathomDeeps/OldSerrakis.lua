local mod	= DBM:NewMod("OldSerrakis", "DBM-Party-Vanilla", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230814030644")
mod:SetCreatureID(4830)
--mod:SetEncounterID(1667)

mod:RegisterCombat("combat")
