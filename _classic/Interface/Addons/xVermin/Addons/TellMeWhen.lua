local _, xVermin = ...

for group = 1, 10 do
	for icon = 1, 100 do
		xVermin.CheckIfLoadedWithTimer(
		"TellMeWhen_Group" .. group .. "_Icon" .. icon,
		function()
			_G["TellMeWhen_Group" .. group .. "_Icon" .. icon]:CreateBeautyBorder(8)
		end)
	end
end