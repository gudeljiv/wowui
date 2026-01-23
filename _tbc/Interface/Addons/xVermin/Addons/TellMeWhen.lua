local _, xVermin = ...

for group = 1, 10 do
	for icon = 1, 100 do
		xVermin.CheckIfLoadedWithTimer("TellMeWhen_Group" .. group .. "_Icon" .. icon, function()
			_G["TellMeWhen_Group" .. group .. "_Icon" .. icon]:CreateBeautyBorder(8)

			if _G["TellMeWhen_Group" .. group .. "_Icon" .. icon .. "IconModule_TextsCount"] then
				_G["TellMeWhen_Group" .. group .. "_Icon" .. icon .. "IconModule_TextsCount"]:Hide()
			end
		end)
	end
end

-- /run TellMeWhen_Group3_Icon1IconModule_TextsCount:Hide()
