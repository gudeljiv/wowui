local _, xVermin = ...

local GOLD = "|cFFE6BF42"
local SILVER = "|cFF939193"
local COPPER = "|cFFAD6C4C"
local WHITE = "|cFFFFFFFF"

local function HandleItem(self, ...)
	-- Duplicate guard
	for i = 1, self:NumLines() do
		if (_G[self:GetName() .. "TextLeft" .. i]:GetText() or ""):find("Item ID:") then
			return
		end
	end

	local _, itemLink = self:GetItem()
	if not itemLink then
		return
	end

	local itemId = GetItemInfoInstant(itemLink)
	if not itemId then
		return
	end

	local itemName, _, itemQuality, itemLevel, _, _, _, _, _, _, sellPrice = GetItemInfo(itemLink)

	self:AddLine(" ")
	self:AddLine(_G.ORANGE_FONT_COLOR_CODE .. "Item ID:|r " .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. "|r")

	if itemLevel then
		local line = _G[self:GetName() .. "TextLeft1"]
		if (line:GetText() or "") == "Currently Equipped" then
			line = _G[self:GetName() .. "TextLeft2"]
		end
		local lineText = line:GetText() or ""
		if not lineText:find("%(") then
			line:SetText(lineText .. " (|r" .. _G.NORMAL_FONT_COLOR_CODE .. itemLevel .. "|r)")
		end
	end

	if sellPrice and sellPrice > 0 then
		local itemcount = GetItemCount(itemId)
		if itemcount > 1 then
			local itempriceTotal = sellPrice * itemcount
			self:AddDoubleLine(
				_G.ORANGE_FONT_COLOR_CODE .. "Vendor price:|r " .. WHITE .. GetMoneyString(sellPrice) .. "|r",
				_G.ORANGE_FONT_COLOR_CODE .. itemcount .. "x:|r " .. WHITE .. GetMoneyString(itempriceTotal) .. "|r"
			)
		else
			self:AddLine(_G.ORANGE_FONT_COLOR_CODE .. "Vendor price:|r " .. WHITE .. GetMoneyString(sellPrice) .. "|r")
		end
	end

	self:AddLine(" ")
end

for _, tooltip in pairs({
	GameTooltip,
	ItemRefTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
	AtlasLootTooltip,
}) do
	xVermin.CheckIfLoadedWithTimer(tooltip:GetName(), function()
		tooltip:HookScript("OnTooltipSetItem", HandleItem)
	end)
end
