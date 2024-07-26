local _, ns = ...

local RUNE_SLOTS_CATEGORIES = {
  -- Season of Discovery: Phase 1.
  Enum.InventoryType.IndexChestType,
  Enum.InventoryType.IndexLegsType,
  Enum.InventoryType.IndexHandType,
  -- Season of Discovery: Phase 2.
  Enum.InventoryType.IndexWaistType,
  Enum.InventoryType.IndexFeetType,
  -- Season of Discovery: Phase 3
  Enum.InventoryType.IndexHeadType,
  Enum.InventoryType.IndexWristType,
    -- Season of Discovery: Phase 4
  Enum.InventoryType.IndexFingerType,
  Enum.InventoryType.IndexCloakType,
}

function ns.Initialize()
  ns.initialized = true
  ns.knownRunesCache = {}

  ns.GetRunesForCategory = C_Engraving.GetRunesForCategory
  C_Engraving.GetRunesForCategory = ns.GetAllRunesForCategory

  ns.GetRuneCategories = C_Engraving.GetRuneCategories
  C_Engraving.GetRuneCategories = ns.GetAllRuneCategories

  hooksecurefunc("EngravingFrame_UpdateRuneList", ns.PostUpdateRuneList)
  hooksecurefunc("EngravingFrameSpell_OnClick", ns.PostRuneClick)

  for _, button in pairs(EngravingFrame.scrollFrame.buttons) do
    button:HookScript("OnEnter", ns.PostRuneMouseover)
  end
end

function ns.RemoveRuneFromResult(runes, skillLineAbilityID)
  for i, rune in ipairs(runes) do
    if rune.skillLineAbilityID == skillLineAbilityID then
      table.remove(runes, i)
      return
    end
  end
end

function ns.GetAllRunesForCategory(category, _)
  ownedOnly = C_Engraving.IsEquippedFilterEnabled()

  -- NOTE(Blizzard Bug):
  -- Filter head = 1, wrists = 9 - they were accidentally added in P2 and left
  -- behind.
--   if category == 1 or category == 9 then
--     return {}
--   end

  local runes = ns.GetRunesForCategory(category, ownedOnly)

  -- NOTE(Blizzard Bug):
  -- Blizzard introduced a bug where Shadowfind is both a rune and a QoL
  -- book. Filter it out here.
  ns.RemoveRuneFromResult(runes, 48274)

  return runes
end

function ns.GetAllRuneCategories(category, _)
  ownedOnly = false
  return ns.GetRuneCategories(category, ownedOnly)
end

function ns.PostUpdateRuneList()
  for _, button in pairs(EngravingFrame.scrollFrame.buttons) do
    local skillLineAbilityID = button.skillLineAbilityID or 0
    if skillLineAbilityID > 0 then
      if C_Engraving.IsRuneEquipped(skillLineAbilityID) then
        button.disabledBG:Show()
        button.disabledBG:SetColorTexture(0, 1, 0, 0.5)
        button.disabledBG:SetBlendMode("ADD")
        button.icon:SetDesaturated(false)
      elseif ns.IsRuneKnown(skillLineAbilityID) then
        button.disabledBG:Hide()
        button.icon:SetDesaturated(false)
        button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
      else
        button.disabledBG:Show()
        button.disabledBG:SetColorTexture(0.33, 0.33, 0.33, 1)
        button.disabledBG:SetBlendMode("MOD")
        button.icon:SetDesaturated(true)
        button:RegisterForClicks()
      end
    end
  end
end

function ns.PostRuneClick(button, mouse)
  if InCombatLockdown() then
    return
  end
  if mouse == "RightButton" then
    local rune = C_Engraving.GetCurrentRuneCast()
    if rune and rune.equipmentSlot then
      PickupInventoryItem(rune.equipmentSlot)
      if StaticPopup1:IsVisible() and StaticPopup1Button1:IsVisible() then
        StaticPopup1Button1:Click()
      end
      ClearCursor()
    end
  end
end

function ns.PostRuneMouseover(button)
  local regions = {GameTooltip:GetRegions()}
  for _, region in ipairs(regions) do
    if region:IsObjectType("FontString") then
      local text = region:GetText() or ""
      local r, g, b, a = region:GetTextColor()
      if string.find(text, "<.+>") and g == 1 and a == 1 and not ns.IsRuneKnown(button.skillLineAbilityID or 0) then
        region:SetText(ns.L["Rune not known yet!"])
        region:SetTextColor(1, 0, 0, 1)
      end
    end
  end
end

function ns.IsRuneKnown(skillLineAbilityID)
  if ns.knownRunesCache[skillLineAbilityID] then
    return true
  end
  for _, category in ipairs(RUNE_SLOTS_CATEGORIES) do
    local knownRunesForCategory = ns.GetRunesForCategory(category, true)
    for _, rune in ipairs(knownRunesForCategory) do
      if rune.skillLineAbilityID == skillLineAbilityID then
        ns.knownRunesCache[skillLineAbilityID] = true
        return true
      end
    end
  end
  return false
end

if C_Engraving.IsEngravingEnabled() then
  local f = CreateFrame("Frame")
  f:RegisterEvent("PLAYER_ENTERING_WORLD")
  f:RegisterEvent("PLAYER_REGEN_ENABLED")
  f:RegisterEvent("RUNE_UPDATED")
  f:SetScript("OnEvent", function(self, event, ...)
    if not InCombatLockdown() and not ns.initialized and C_AddOns.IsAddOnLoaded("Blizzard_EngravingUI") then
      ns.Initialize()
      f:UnregisterEvent("PLAYER_ENTERING_WORLD")
      f:UnregisterEvent("PLAYER_REGEN_ENABLED")
    end
    if not InCombatLockdown() and event == "RUNE_UPDATED" then
      EngravingFrame_UpdateRuneList(EngravingFrame)
    end
  end)
end
