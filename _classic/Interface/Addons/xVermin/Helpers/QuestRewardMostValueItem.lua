local _, xVermin = ...

local MostValue = CreateFrame('Frame', 'xVermin_QuestRewardGoldIconFrame', _G.QuestInfoRewardsFrame)
MostValue:SetFrameStrata('HIGH')
MostValue:Size(19)
MostValue:Hide()

MostValue.Icon = MostValue:CreateTexture(nil, 'OVERLAY')
MostValue.Icon:SetAllPoints(MostValue)
MostValue.Icon:SetTexture(xVermin.Config.texture.coins)
MostValue.Icon:SetTexCoord(0.33, 0.66, 0.022, 0.66)

xVermin.QuestRewardGoldIconFrame = MostValue

hooksecurefunc(
	_G.QuestFrameRewardPanel,
	'Hide',
	function()
		if xVermin.QuestRewardGoldIconFrame then
			xVermin.QuestRewardGoldIconFrame:Hide()
		end
	end
)

function QUEST_COMPLETE()
	local firstItem = _G.QuestInfoRewardsFrameQuestInfoItem1
	print(firstItem)
	if not firstItem then
		return
	end

	local numQuests = GetNumQuestChoices()
	if numQuests < 2 then
		return
	end

	local bestValue, bestItem = 0
	for i = 1, numQuests do
		local questLink = GetQuestItemLink('choice', i)
		local _, _, amount = GetQuestItemInfo('choice', i)
		local itemSellPrice = questLink and select(11, GetItemInfo(questLink))

		local totalValue = (itemSellPrice and itemSellPrice * amount) or 0
		if totalValue > bestValue then
			bestValue = totalValue
			bestItem = i
		end
	end

	print(bestItem)

	if bestItem then
		local btn = _G['QuestInfoRewardsFrameQuestInfoItem' .. bestItem]
		if btn and btn.type == 'choice' then
			xVermin.QuestRewardGoldIconFrame:ClearAllPoints()
			xVermin.QuestRewardGoldIconFrame:Point('TOPRIGHT', btn, 'TOPRIGHT', -2, -2)
			xVermin.QuestRewardGoldIconFrame:Show()
		end
	end
end

local f = CreateFrame('Frame')
f:RegisterEvent('QUEST_COMPLETE', QUEST_COMPLETE)
f:RegisterEvent('QUEST_ITEM_UPDATE', QUEST_COMPLETE)
f:RegisterEvent('GET_ITEM_INFO_RECEIVED', QUEST_COMPLETE)
