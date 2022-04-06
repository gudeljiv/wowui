-- scope stuff
gearquipper = gearquipper or {};
local c = gearquipper;

local quickBars;
local slotSize, slotMargin = 38, 8;

function c:CreateQuickBar(slotId)
	local parent = _G["Character" .. c:GetSlotInfo()[slotId]];
	local frame = CreateFrame("Frame", "GQ_QuickBar_" .. slotId, parent);

    frame:SetHeight(slotSize + slotMargin);
	frame:SetPoint("TOPLEFT", parent, "TOPLEFT", slotSize, (slotMargin / 2));
	frame:SetFrameStrata("HIGH");
	frame:SetScript("OnHide", function(self)
		c:HighlightItemsInBags();
		ClearCursor();
	end);

    frame.border = frame:CreateTexture("GQ_QuickBarBorderTex", "BORDER");
    frame.border:SetPoint("TOPLEFT");
	frame.border:SetTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot.blp");
	frame.border:SetHeight(slotSize + slotMargin);

	local S = c:GetElvUiSkinModule();
	if S then
		S:HandleFrame(frame);
	end

	return frame;
end

function c:CreateQuickSlot(slotId, index)
	local frame = CreateFrame("Button", "GQ_QuickSlot_" .. slotId .. "_" .. index, quickBars[slotId], "GqQuickSlotTemplate");
    frame:SetWidth(slotSize);
    frame:SetHeight(slotSize);
	frame:SetPoint("TOPLEFT", quickBars[slotId], "TOPLEFT", (slotSize * (index - 1)) + (slotMargin * (index - 1)) + slotMargin, -(slotMargin / 2));
	frame:SetFrameStrata("HIGH");

	frame:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
		GameTooltip:SetHyperlink(self.link);
		GameTooltip:Show();
	end);
	frame:SetScript("OnLeave", function()
		GameTooltip:Hide();
	end);
	frame:SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			ClearCursor();

			local itemString = self:GetAttribute("item2");
			--local itemLink = c:GetItemLink(itemString);
			local bagId, bagSlotId = c:FindItemInBags(itemString);
			if not bagId and c:IsAtBank() then
				-- item not in bag -> check in bank
				local bagSpaceCache = c:GetBagSpace();
				if c:GetItemFromBank(itemString, bagSpaceCache) then
					C_Timer.After(c:GetHomeLatency(100) / 1000, function()
						EquipItemByName(itemString, slotId);
					end);
				end
			else
				EquipItemByName(itemString, slotId);
			end

			c:CloseQuickBar(slotId);
			GameTooltip:Hide();
		end
	end);

	return frame;
end

function c:AddQuickSlot(slotId, slotIndex, itemEntry)
	local quickBar = quickBars[slotId];
	quickBar.slots[slotIndex] = quickBar.slots[slotIndex] or c:CreateQuickSlot(slotId, slotIndex);
	local quickSlot = quickBar.slots[slotIndex];
	local texture, count, locked, quality, readable, lootable, link = GetContainerItemInfo(itemEntry[c.ITEM_BAG_ID], itemEntry[c.ITEM_SLOT_ID]);

	quickSlot.link = link;
	quickSlot:SetAttribute("item2", itemEntry[c.ITEM_STRING]);
	quickSlot.icon:SetTexture(texture);
	if count > 1 then
		quickSlot.count:SetText(count);
		quickSlot.count:Show();
	else
		quickSlot.count:Hide();
	end

	if quality > 1 then
		quickSlot.glow:SetVertexColor(GetItemQualityColor(quality));
		quickSlot.glow:Show();
	else
		quickSlot.glow:Hide();
	end

	quickSlot:Show();
end

function c:OpenQuickBar(slotId)
	if not c:IsInCombat() and slotId then
		local matchingItems, noSlots = c:GetMatchingItems(slotId);

		if noSlots > 0 then
			quickBars = quickBars or {};
			quickBars[slotId] = quickBars[slotId] or c:CreateQuickBar(slotId);
			quickBars[slotId]:SetWidth((slotSize * noSlots) + (slotMargin * (noSlots - 1)));
			quickBars[slotId].border:SetWidth((slotSize * noSlots) + (slotMargin * (noSlots - 1)) + (slotMargin * 2));
			quickBars[slotId]:Show();

			local S = c:GetElvUiSkinModule();
			if S then
				quickBars[slotId]:SetWidth((slotSize * noSlots) + (slotMargin * (noSlots - 1)) + 16);
			end

			quickBars[slotId].slots = quickBars[slotId].slots or {};
			local itemStrings = {};

			for index, itemEntry in ipairs(matchingItems) do
				c:AddQuickSlot(slotId, index, itemEntry);
				tinsert(itemStrings, itemEntry[c.ITEM_STRING]);
			end

			c:HighlightItemsInBags(itemStrings);
			GameTooltip:Hide();

			return quickBars[slotId];
		end
	end
end

function c:CloseQuickBars()
	if not c:IsInCombat() and quickBars then
		for slotId, quickBar in pairs(quickBars) do
			c:CloseQuickBar(slotId);

			-- remove slot attached quickbars
			local frame = _G["Character" .. c:GetSlotInfo(slotId)];
			if frame and frame.quickbar then
				frame.quickbar = nil;
			end
		end
	end
end

function c:CloseQuickBar(slotId)
	if not c:IsInCombat() and quickBars and quickBars[slotId] then
		quickBars[slotId]:Hide();
		for index, slot in pairs(quickBars[slotId].slots) do
			slot:Hide();
		end
	end
end