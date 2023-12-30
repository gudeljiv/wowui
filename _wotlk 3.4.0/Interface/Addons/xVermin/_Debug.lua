local _, xVermin = ...

local mbk, bs, txp, kc, override = false

local function PrintLog()
	xVermin:LogBreak(true)
	ChatFrame6:AddMessage('/xd or /xdebug')
	ChatFrame6:AddMessage('\124cffFFFF00(mbk)\124r Mobs to kill: ' .. (mbk and '\124cff00FF00true\124r' or '\124cffFF0000false\124r'))
	ChatFrame6:AddMessage('\124cffFFFF00(bs)\124r Skin buffs: ' .. (bs and '\124cff00FF00true\124r' or '\124cffFF0000false\124r'))
	ChatFrame6:AddMessage('\124cffFFFF00(txp)\124r Total XP: ' .. (txp and '\124cff00FF00true\124r' or '\124cffFF0000false\124r'))
	ChatFrame6:AddMessage('\124cffFFFF00(kc)\124r Kill Count: ' .. (kc and '\124cff00FF00true\124r' or '\124cffFF0000false\124r'))
end

function xVermin:Debug(msg)
	ChatFrame6Tab:Click()
	if msg == 'mbk' then
		mbk = not mbk
		module = 'mbk'
	end
	if msg == 'bs' then
		bs = not bs
		module = 'bs'
	end
	if msg == 'txp' then
		txp = not txp
		module = 'txp'
	end
	if msg == 'kc' then
		kc = not kc
		module = 'kc'
	end
	PrintLog()
end

SLASH_DEBUG1 = '/xd'
SLASH_DEBUG2 = '/xdebug'
SlashCmdList['DEBUG'] = function(msg)
	xVermin:Debug(msg)
end

function xVermin:Log(message, source)
	if source == 'mbk' and mbk then
		ChatFrame6:AddMessage(message)
	end
	if source == 'bs' and bs then
		ChatFrame6:AddMessage(message)
	end
	if source == 'txp' and txp then
		ChatFrame6:AddMessage(message)
	end
	if source == 'kc' and kc then
		ChatFrame6:AddMessage(message)
	end
end

function xVermin:LogBreak(override, source)
	if (source and source == module) or override then
		ChatFrame6:AddMessage('--------------------------------------------------------')
	end
end
