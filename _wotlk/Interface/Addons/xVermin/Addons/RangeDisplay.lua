local _, xVermin = ...

xVermin:CheckIfLoadedWithTimer(
	'RangeDisplayMainFrame_playertarget',
	function()
		RangeDisplayMainFrame_playertarget:SetPoint('CENTER', UIParent, 'CENTER', 0, -20)
		RangeDisplayMainFrame_playertarget.ClearAllPoints = function()
		end
		RangeDisplayMainFrame_playertarget.SetPoint = function()
		end
	end
)

xVermin:CheckIfLoadedWithTimer(
	'RangeDisplayMainFrame_mouseover',
	function()
		RangeDisplayMainFrame_mouseover:SetPoint('CENTER', UIParent, 'CENTER', 0, -35)
		RangeDisplayMainFrame_mouseover.ClearAllPoints = function()
		end
		RangeDisplayMainFrame_mouseover.SetPoint = function()
		end
	end
)
