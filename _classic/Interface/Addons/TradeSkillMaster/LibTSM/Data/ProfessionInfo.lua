-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local ProfessionInfo = TSM.Init("Data.ProfessionInfo") ---@class Data.ProfessionInfo
local OptionalMatData = TSM.LibTSMData:Include("OptionalMat")



-- ============================================================================
-- Module Functions
-- ============================================================================

function ProfessionInfo.GetOptionalMatByItemLevel(itemLevel)
	for itemString, info in pairs(OptionalMatData.Info) do
		if info.absItemLevel == itemLevel then
			return itemString
		end
	end
	return nil
end

function ProfessionInfo.GetOptionalMatByRelItemLevel(relItemLevel)
	for itemString, info in pairs(OptionalMatData.Info) do
		if info.relItemLevels and info.relItemLevels[relItemLevel] and not info.ignored then
			return itemString
		end
	end
	return nil
end

function ProfessionInfo.GetOptionalMatByStatModifier(statModifier)
	for itemString, info in pairs(OptionalMatData.Info) do
		if info.statModifier == statModifier then
			return itemString
		end
	end
	return nil
end
