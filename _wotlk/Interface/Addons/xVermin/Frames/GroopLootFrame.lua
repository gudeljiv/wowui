local _, xVermin = ...

local function RepositionLootFrames()
	-- if not _G["LootRollMoverAnchor_Frame"] then return end
	-- if not LRMDB then return end
	local frame = _G['GroupLootContainer']
	frame:ClearAllPoints()
	frame:SetPoint('LEFT', CustomContainer_Combat, 'RIGHT', 380, 250)
	-- frame:CreateBeautyBorder(8)
	frame:SetScale(0.8)

	local itemName, itemLevel, itemLevel, itemQuality, itemBOP, canDE, r, g, b

	for i = 1, NUM_GROUP_LOOT_FRAMES do
		frame = _G['GroupLootFrame' .. i]

		if frame and frame.rollID then
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

			-- print(frame.rollID)
			if frame.rollID and frame.rollID ~= nil then 
				_, itemName, _, itemQuality, itemBOP, _, _, canDE = GetLootRollItemInfo(frame.rollID)
				itemLink = GetLootRollItemLink(frame.rollID)
				_, _, _, itemLevel = GetItemInfo(itemLink)
				r, g, b = GetItemQualityColor(itemQuality)
			end

			if itemLevel then
				if not frame.ItemLevelText then 
					frame.ItemLevelText = frame.IconFrame:CreateFontString(nil, 'ARTWORK')
					frame.ItemLevelText:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE')
					frame.ItemLevelText:SetShadowOffset(0, 0)
					frame.ItemLevelText:SetPoint('TOP', frame.IconFrame, 'TOP', 0, 0)
					frame.ItemLevelText:SetVertexColor(r, g, b)
				end
				frame.ItemLevelText:SetText(itemLevel)
			end

			if not frame.BOPText then 
				frame.BOPText = frame.IconFrame:CreateFontString(nil, 'ARTWORK')
				frame.BOPText:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
				frame.BOPText:SetShadowOffset(0, 0)
				frame.BOPText:SetPoint('BOTTOM', frame.IconFrame, 'BOTTOM', 2, 0)
				frame.BOPText:SetVertexColor(1, 1, 1)
				frame.BOPText:SetText(itemBOP and "BOP" or "BOE")
			end

		end
	end
end

hooksecurefunc('GroupLootContainer_OnLoad', RepositionLootFrames)
hooksecurefunc('GroupLootContainer_RemoveFrame', RepositionLootFrames)
hooksecurefunc('GroupLootFrame_OnShow', RepositionLootFrames)
hooksecurefunc('GroupLootFrame_OpenNewFrame', RepositionLootFrames)
hooksecurefunc('GroupLootFrame_OnEvent', RepositionLootFrames)
-- hooksecurefunc('GroupLootContainer_Update', RepositionLootFrames)
