local _, xVermin = ...

-- LootFrame:Hide()
-- LootFrame.Show = function()
-- end

LootFrame:HookScript(
	'OnShow',
	function()
		local numLootItems = GetNumLootItems()
		for i = GetNumLootItems(), 1, -1 do
			local frame = _G['LootButton' .. i]
			if (frame ~= nil) then
				frame:CreateBeautyBorder(6)
			end
		end
	end
)
