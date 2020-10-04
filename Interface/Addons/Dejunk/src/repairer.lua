-- Repairer: handles the process of repairing.

local _, Addon = ...
local Core = Addon.Core
local DB = Addon.DB
local Dejunker = Addon.Dejunker
local GetCoinTextureString = _G.GetCoinTextureString
local GetMoney = _G.GetMoney
local GetRepairAllCost = _G.GetRepairAllCost
local ITEM_REPAIR_SOUND_ID = _G.SOUNDKIT.ITEM_REPAIR
local L = Addon.Libs.L
local PlaySound = _G.PlaySound
local RepairAllItems = _G.RepairAllItems
local Repairer = Addon.Repairer

-- Variables
local REPAIR_DELAY = 0.5
local repairInterval = 0

local isRepairing = false
local totalRepairCost = 0

-- ============================================================================
-- OnUpdate Scripts
-- ============================================================================

-- Set as the OnUpdate function during the repairing process.
local function repairer_OnUpdate(self, elapsed)
	if (GetMoney() >= totalRepairCost) then
		RepairAllItems()
		PlaySound(ITEM_REPAIR_SOUND_ID)
		Core:Print(L.REPAIRED_ALL_ITEMS:format(GetCoinTextureString(totalRepairCost)))
		Repairer:StopRepairing()
		return
	else -- Repairs probably impossible
    if Dejunker:IsBusy() then return end -- Wait until junk has been sold
		Core:Print(L.REPAIRED_NO_ITEMS)
		Repairer:StopRepairing()
		return
	end
end

-- Used as a short delay prior to UpdateRepairs() in order to circumvent erroneous GetRepairAllCost() returns.
local function start_OnUpdate(self, elapsed)
	repairInterval = (repairInterval + elapsed)

	if (repairInterval >= REPAIR_DELAY) then
		local repairCost, canRepair = GetRepairAllCost()

		if (not canRepair) or (repairCost <= 0) then
			Repairer:StopRepairing()
			return
		end

		totalRepairCost = repairCost
		repairInterval = REPAIR_DELAY

		self.OnUpdate = repairer_OnUpdate
	end
end

-- ============================================================================
-- General Functions
-- ============================================================================

-- Event handler.
function Repairer:OnEvent(event, ...)
	if (event == "MERCHANT_SHOW") then
		if DB.Profile.AutoRepair then self:StartRepairing() end
	elseif (event == "MERCHANT_CLOSED") then
		if self:IsRepairing() then self:StopRepairing() end
  end
end

-- Starts the repairing process.
function Repairer:StartRepairing()
  isRepairing = true
	repairInterval = 0
	self.OnUpdate = start_OnUpdate
end

-- Cancels the repairing process.
function Repairer:StopRepairing()
  isRepairing = false
	totalRepairCost = 0
	self.OnUpdate = nil
end

-- Checks whether or not the Repairer is active.
-- @return - boolean
function Repairer:IsRepairing()
  return isRepairing
end
