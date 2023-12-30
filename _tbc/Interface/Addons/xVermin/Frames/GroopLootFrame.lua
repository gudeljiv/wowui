local _, xVermin = ...

local function RepositionLootFrames()
	-- if not _G["LootRollMoverAnchor_Frame"] then return end
	-- if not LRMDB then return end
	local frame = _G['GroupLootContainer']
	frame:ClearAllPoints()
	frame:SetPoint('LEFT', CustomContainer_Combat, 'RIGHT', 380, 250)
	-- frame:CreateBeautyBorder(8)
	frame:SetScale(0.8)

	for i = 1, NUM_GROUP_LOOT_FRAMES do
		frame = _G['GroupLootFrame' .. i]
		-- if frame and frame ~= nil and CanAccessObject(frame) then
		if frame and frame ~= nil then
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

hooksecurefunc('GroupLootContainer_OnLoad', RepositionLootFrames)
hooksecurefunc('GroupLootContainer_RemoveFrame', RepositionLootFrames)
hooksecurefunc('GroupLootFrame_OnShow', RepositionLootFrames)
hooksecurefunc('GroupLootFrame_OpenNewFrame', RepositionLootFrames)
hooksecurefunc('GroupLootFrame_OnEvent', RepositionLootFrames)
hooksecurefunc('GroupLootContainer_Update', RepositionLootFrames)
