local _, xVermin = ...

local function QualityILVL(frame, rollID)
	local itemName, itemLevel, itemLevel, itemQuality, itemBOP, canDE, r, g, b

	_, itemName, _, itemQuality, itemBOP, _, _, canDE = GetLootRollItemInfo(frame.rollID)
	itemLink = GetLootRollItemLink(frame.rollID)
	_, _, _, itemLevel = GetItemInfo(itemLink)
	r, g, b = GetItemQualityColor(itemQuality)
	print(frame.rollID, itemName, itemQuality, itemBOP, itemLink, itemQuality, r, g, b)

	if itemLevel then
		if not frame.ItemLevelText then 
			frame.ItemLevelText = frame.IconFrame:CreateFontString(nil, 'ARTWORK')
			frame.ItemLevelText:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE')
			frame.ItemLevelText:SetShadowOffset(0, 0)
			frame.ItemLevelText:SetPoint('TOP', frame.IconFrame, 'TOP', 0, 0)
		end
		frame.ItemLevelText:SetVertexColor(r or 1, g or 1, b or 1)
		frame.ItemLevelText:SetText(itemLevel)
	end

	if not frame.BOPText then 
		frame.BOPText = frame.IconFrame:CreateFontString(nil, 'ARTWORK')
		frame.BOPText:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
		frame.BOPText:SetShadowOffset(0, 0)
		frame.BOPText:SetPoint('BOTTOM', frame.IconFrame, 'BOTTOM', 2, 0)
		frame.BOPText:SetVertexColor(1, 1, 1)
	end
	frame.BOPText:SetText(itemBOP and "BOP" or "BOE")
end



local function HandleLootFrames()
	
	local frame = _G['GroupLootContainer']
	frame:ClearAllPoints()
	frame:SetPoint('LEFT', CustomContainer_Combat, 'RIGHT', 380, 250)
	-- frame:CreateBeautyBorder(8)
	frame:SetScale(0.8)

	for i = 1, NUM_GROUP_LOOT_FRAMES do
		frame = _G['GroupLootFrame' .. i]

		if frame then
			if i == 1 then
				frame:ClearAllPoints()
				frame:SetPoint('LEFT', CustomContainer_Combat, 'RIGHT', 380, 250)
				-- frame:CreateBeautyBorder(8)
				frame:SetScale(1)
			elseif i > 1 then
				frame:ClearAllPoints()
				frame:SetPoint('BOTTOM', 'GroupLootFrame' .. (i - 1), 'TOP', 0, 5)
				-- frame:CreateBeautyBorder(8)
				frame:SetScale(1)
			end

		end
	end
	
end

local function HandleLootFramesOnShow()

	local frame = _G['GroupLootContainer']
	frame:ClearAllPoints()
	frame:SetPoint('LEFT', CustomContainer_Combat, 'RIGHT', 380, 250)
	-- frame:CreateBeautyBorder(8)
	frame:SetScale(0.8)

	for i = 1, NUM_GROUP_LOOT_FRAMES do
		frame = _G['GroupLootFrame' .. i]

		if frame then
			if i == 1 then
				frame:ClearAllPoints()
				frame:SetPoint('LEFT', CustomContainer_Combat, 'RIGHT', 380, 250)
				-- frame:CreateBeautyBorder(8)
				frame:SetScale(1)
			elseif i > 1 then
				frame:ClearAllPoints()
				frame:SetPoint('BOTTOM', 'GroupLootFrame' .. (i - 1), 'TOP', 0, 5)
				-- frame:CreateBeautyBorder(8)
				frame:SetScale(1)
			end

			if show_ilvl and frame.rollID then 
				QualityILVL(frame, rollID)
			end

		end
	end

end

hooksecurefunc('GroupLootContainer_OnLoad', HandleLootFrames)
hooksecurefunc('GroupLootContainer_RemoveFrame', HandleLootFrames)
hooksecurefunc('GroupLootFrame_OnShow', HandleLootFramesOnShow)
hooksecurefunc('GroupLootFrame_OpenNewFrame', HandleLootFrames)
hooksecurefunc('GroupLootFrame_OnEvent', HandleLootFrames)
-- hooksecurefunc('GroupLootContainer_Update', RepositionLootFrames)
