local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'NugKeyFeedbackMirror',
	function()
		NugKeyFeedbackMirror:ClearAllPoints()
		NugKeyFeedbackMirror:SetPoint('CENTER', UIParent, 'CENTER', 0, -275)
	end
)
