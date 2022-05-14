local _, Addon = ...
local DB = Addon.DB
local DTL = Addon.Libs.DTL
local L = Addon.Libs.L
local ItemQuality = Addon.ItemQuality

local REASON = Addon.Filters:SellReason(
  L.IGNORE_TEXT,
  L.BY_TYPE_TEXT,
  L.IGNORE_SOULBOUND_TEXT
)

local function run(item, ignore, reason)
  if
    ignore.soulbound and
    item.Quality ~= ItemQuality.Poor
  then
    if not DTL:ScanBagSlot(item.Bag, item.Slot) then
      return Addon.Filters:IncompleteTooltipError()
    end

    if DTL:IsSoulbound() then
      return "NOT_JUNK", reason
    end
  end

  return "PASS"
end

-- Dejunker
Addon.Filters:Add(Addon.Dejunker, {
  Run = function(_, item)
    return run(item, DB.Profile.sell.ignore, REASON)
  end
})
