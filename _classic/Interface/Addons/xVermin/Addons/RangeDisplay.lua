local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'RangeDisplayMainFrame_playertarget',
	function()
		RangeDisplayMainFrame_playertarget:SetPoint('CENTER', UIParent, 'CENTER', 0, -20)
	end
)

xVermin.CheckIfLoadedWithTimer(
	'RangeDisplayMainFrame_mouseover',
	function()
		RangeDisplayMainFrame_mouseover:SetPoint('CENTER', UIParent, 'CENTER', 0, -35)
	end
)
