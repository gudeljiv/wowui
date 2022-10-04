local _, xVermin = ...

function ReportActionButtons()
	local lActionSlot = 0
	for lActionSlot = 1, 120 do
		local lActionText = GetActionText(lActionSlot)
		local lActionTexture = GetActionTexture(lActionSlot)
		if lActionTexture then
			local lMessage = 'Slot ' .. lActionSlot .. ': [' .. lActionTexture .. ']'
			if lActionText then
				lMessage = lMessage .. ' "' .. lActionText .. '"'
			end
			ChatFrame7:AddMessage(lMessage)
		end
	end
end

SLASH_XRAB1 = '/xrab'
SlashCmdList['XRAB'] = function(msg)
	ReportActionButtons()
end
