local _, xVermin = ...

local f = CreateFrame("Frame")
f:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		DEFAULT_CHAT_FRAME.editBox:SetText("/dejunk destroy start")
		ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
	end
)
f:RegisterEvent("BAG_UPDATE")
