local _, xVermin = ...

SpellBookFrame:HookScript(
	'OnShow',
	function(self)
		for i = 1, 50 do
			local frame = _G['SpellButton' .. i]
			local frameBackground = _G['SpellButton' .. i .. 'Background']
			if (frame ~= nil) then
				frame:CreateBeautyBorder(8)
				frameBackground:Hide()
			end
		end
	end
)
