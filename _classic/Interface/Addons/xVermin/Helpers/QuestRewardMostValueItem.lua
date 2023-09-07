local _, xVermin = ...

local MostValue = CreateFrame('Frame', 'xVermin_QuestRewardGoldIconFrame', UIParent)
MostValue:SetFrameStrata('HIGH')
MostValue:SetSize(30, 30)
MostValue:SetPoint("CENTER")
MostValue:Hide()

MostValue.Icon = MostValue:CreateTexture("Texture", 'OVERLAY')
MostValue.Icon:SetAllPoints(MostValue)
MostValue.Icon:SetTexture(xVermin.Config.texture.coins)
MostValue.Icon:SetTexCoord(0, 0.5, 0.5, 1)
-- MostValue.Icon:SetTexture(xVermin.Config.texture.coins)
-- MostValue.Icon:SetTexCoord(0.33, 0.66, 0.022, 0.66)

xVermin.QuestRewardGoldIconFrame = MostValue

hooksecurefunc(
	_G.QuestFrameRewardPanel,
	'Hide',
	function()
		if xVermin.QuestRewardGoldIconFrame then
			xVermin.QuestRewardGoldIconFrame:Hide()
			print("hide")
		end
	end
)

-- function QUEST_COMPLETE2()
-- 	local firstItem = _G.QuestInfoRewardsFrameQuestInfoItem1
-- 	print(firstItem)
-- 	if not firstItem then
-- 		return
-- 	end

-- 	local numQuests = GetNumQuestChoices()
-- 	if numQuests < 2 then
-- 		return
-- 	end

-- 	local bestValue, bestItem = 0
-- 	for i = 1, numQuests do
-- 		local questLink = GetQuestItemLink('choice', i)
-- 		local _, _, amount = GetQuestItemInfo('choice', i)
-- 		local itemSellPrice = questLink and select(11, GetItemInfo(questLink))

-- 		local totalValue = (itemSellPrice and itemSellPrice * amount) or 0
-- 		if totalValue > bestValue then
-- 			bestValue = totalValue
-- 			bestItem = i
-- 		end
-- 	end

-- 	print(bestItem)

-- 	if bestItem then
-- 		local btn = _G['QuestInfoRewardsFrameQuestInfoItem' .. bestItem]
-- 		if btn and btn.type == 'choice' then
-- 			xVermin.QuestRewardGoldIconFrame:ClearAllPoints()
-- 			xVermin.QuestRewardGoldIconFrame:Point('TOPRIGHT', btn, 'TOPRIGHT', -2, -2)
-- 			xVermin.QuestRewardGoldIconFrame:Show()
-- 		end
-- 	end
-- end

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('QUEST_COMPLETE', QUEST_COMPLETE)
-- f:RegisterEvent('QUEST_ITEM_UPDATE', QUEST_COMPLETE)
-- f:RegisterEvent('GET_ITEM_INFO_RECEIVED', QUEST_COMPLETE)

local function QUEST_COMPLETE(self, event, ...)

	-- print(event)

	if (event == "QUEST_COMPLETE" or event == "OPTIONS") then
		-- if (not _G["NovaHighestValueQuestReward"]) then
		-- 	local f = CreateFrame("Frame", "NovaHighestValueQuestReward");
		-- 	f.fs = f:CreateFontString("NovaHighestValueQuestRewardFS", "ARTWORK");
		-- 	f.fs:SetPoint("CENTER", 0, 0);
		-- 	f.fs:SetFont("Fonts\\ARIALN.ttf", 24);
		-- 	f.texture = f:CreateTexture(nil, "ARTWORK");
		-- 	-- f.texture:SetTexture("Interface\\Icons\\INV_Misc_Coin_02");
		-- 	f.texture:SetTexture("Interface\\MONEYFRAME\\UI-GoldIcon");
		-- 	f.texture:SetAllPoints(f);
		-- 	f:SetSize(16, 16);
		-- end
		local highest, id = 0, 0;
		for i = 1, GetNumQuestChoices() do
			local link = GetQuestItemLink("choice", i);
			local name = GetQuestItemInfo("choice", i);
			if (not link) then
				return;
			end
			if (name and not link) then
				print("Missing quest itemlink for:", name);
			end
			local itemID = GetItemInfoInstant(link);
			if (itemID) then
				local _, _, itemQuality, _, _, _, _, _, _, _, sellPrice = GetItemInfo(itemID);

				-- _G["QuestInfoRewardsFrameQuestInfoItem" .. i]:CreateBeautyBorder(8)
				-- _G["QuestInfoRewardsFrameQuestInfoItem" .. i .. "NameFrame"]:Hide()
				-- _G["QuestInfoRewardsFrameQuestInfoItem" .. i .. "IconTexture"]:SetScale(0.9)
				-- _G["QuestInfoRewardsFrameQuestInfoItem" .. i .. "IconTexture"]:ClearAllPoints()
				-- _G["QuestInfoRewardsFrameQuestInfoItem" .. i .. "IconTexture"]:SetPoint("LEFT", _G["QuestInfoRewardsFrameQuestInfoItem" .. i], "LEFT", 2, 0)

				-- if (itemQuality and itemQuality > 1) then
				-- 	local r, g, b = GetItemQualityColor(itemQuality)
				-- 	_G["QuestInfoRewardsFrameQuestInfoItem" .. i]:SetBeautyBorderTexture('Interface\\AddOns\\xVermin\\media\\textureWhite')
				-- 	_G["QuestInfoRewardsFrameQuestInfoItem" .. i]:SetBeautyBorderColor(r, g, b)
				-- else
				-- 	_G["QuestInfoRewardsFrameQuestInfoItem" .. i]:SetBeautyBorderTexture('Interface\\AddOns\\xVermin\\media\\textureNormal')
				-- 	_G["QuestInfoRewardsFrameQuestInfoItem" .. i]:SetBeautyBorderColor(1, 1, 1)
				-- end

				-- QuestInfoRewardsFrameQuestInfoItem1IconTexture:SetScale(0.9)
				-- QuestInfoRewardsFrameQuestInfoItem1IconTexture:SetPoint("LEFT", QuestInfoRewardsFrameQuestInfoItem1, "LEFT", 2, 0)

				if (sellPrice and sellPrice > highest) then
					highest = sellPrice;
					id = i;
				end
			end
		end
		if (_G["QuestInfoRewardsFrameQuestInfoItem" .. id]) then
			xVermin.QuestRewardGoldIconFrame:Show();
			xVermin.QuestRewardGoldIconFrame:SetParent(_G["QuestInfoRewardsFrameQuestInfoItem" .. id]);
			xVermin_QuestRewardGoldIconFrame:SetPoint("TOPRIGHT", _G["QuestInfoRewardsFrameQuestInfoItem" .. id], "TOPRIGHT", 8, 10);
		end
	elseif (event == "QUEST_FINISHED" or event == "QUEST_TURNED_IN") then
		if (xVermin.QuestRewardGoldIconFrame) then
			xVermin.QuestRewardGoldIconFrame:Hide();
		end
	end

end


local f = CreateFrame('Frame')
f:RegisterEvent('QUEST_COMPLETE')
f:RegisterEvent('QUEST_TURNED_IN')
f:RegisterEvent('QUEST_FINISHED')
f:SetScript('OnEvent', QUEST_COMPLETE)


-- local function QuestRewardIterator(invariant)
-- 	if not QuestFrame:IsShown() then return end
-- 	local itemType = invariant.itemType
-- 	local numFunc = invariant.numFunc
-- 	local slot = invariant.slot
-- 	if not itemType then
-- 		itemType = "reward"
-- 		func = GetNumQuestRewards
-- 	end
-- 	if not slot then slot = 1
-- 	else slot = slot + 1 end
-- 	while slot > func() do
-- 		slot = 1
-- 		if numFunc == GetNumQuestRewards then
-- 			numFunc = GetNumQuestChoices
-- 			itemType = "choice"
-- 		elseif numFunc == GetNumQuestChoices then
-- 			numFunc = GetNumQuestLogRewards
-- 			itemType = "reward"
-- 		elseif numFunc == GetNumQuestLogRewards then
-- 			numFunc = GetNumQuestLogChoices
-- 			itemType = "choice"
-- 		else
-- 			invariant.itemType = nil
-- 			invariant.numFunc = nil
-- 			invariant.slot = nil
-- 			return 
-- 		end
-- 	end
-- 	local itemLink, itemName
-- 	if QuestInfoFrame.questLog then
-- 		itemLink = GetQuestLogItemLink(itemType, slot)
-- 		if itemType=="choice" then
-- 			itemName = GetQuestLogChoiceInfo(slot)
-- 		else
-- 			itemName = GetQuestLogRewardInfo(slot)
-- 		end
-- 	else
-- 		itemLink = GetQuestItemLink(itemType, slot)
-- 		itemName = GetQuestItemInfo(itemType, slot)
-- 	end
-- 	local itemFrame = _G["QuestInfoItem"..slot]
-- 	if
-- 		itemLink
-- 		and itemFrame
-- 		and itemFrame:IsShown()
-- 		and itemFrame.type==itemType
-- 		and itemFrame.name:GetText()==itemName
-- 	then
-- 		invariant.itemType = itemType
-- 		invariant.numFunc = numFunc
-- 		invariant.slot = slot
-- 		return itemLink
-- 	end
-- end
