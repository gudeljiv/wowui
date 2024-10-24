-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local _, TSM = ...
local ItemTooltip = TSM.Init("Service.ItemTooltip")
local Builder = TSM.Include("Service.ItemTooltipClasses.Builder")
local Wrapper = TSM.Include("Service.ItemTooltipClasses.Wrapper")



-- ============================================================================
-- Module Functions
-- ============================================================================

function ItemTooltip.CreateBuilder()
	return Builder.Create()
end

function ItemTooltip.SetWrapperPopulateFunction(func)
	Wrapper.SetPopulateFunction(func)
end
