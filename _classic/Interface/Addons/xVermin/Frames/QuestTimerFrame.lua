local _, xVermin = ...


QuestTimerFrame:HookScript(
	'OnUpdate',
	function(self)
		QuestTimerFrame:ClearAllPoints()
		QuestTimerFrame:SetPoint('BOTTOMRIGHT', CustomContainer_2, 'BOTTOMLEFT', -6, -10)
	end
)
