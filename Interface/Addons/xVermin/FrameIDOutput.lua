local outputFrame = CreateFrame("Frame")

local previous = nil

outputFrame:SetScript(
	"OnUpdate",
	function()
		a = GetMouseFocus()
		if previous ~= a then
			previous = a
			if a ~= nil then
				local index = GetChannelName("xVerminPrivateDEV") -- It finds General is a channel at index 1
				if (index ~= nil) then
					SendChatMessage(a:GetName(), "CHANNEL", nil, index)
				end
			end
		end
	end
)
