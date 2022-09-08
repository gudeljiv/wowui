
function DUFNN(value, short)
	value = tonumber(value) or value
	if DUFGetConfig("numbermode", "X.X Dynamic") == "X Dynamic" then
		if value > 999999999 then
			if short then
				return format("%.0f B", value / 1000000000)
			end
			return format("%.0f B", value / 1000000000)
		elseif value > 999999 then
			if short then
				return format("%.0f M", value / 1000000)
			end
			return format("%.0f M", value / 1000000)
		elseif value > 999 then
			if short then
				return format("%.0f K", value / 1000)
			end
			return format("%.0f K", value / 1000)
		else
			return value
		end
	elseif DUFGetConfig("numbermode", "X.X Dynamic") == "X.X Dynamic" then
		if value > 999999999 then
			if short then
				return format("%.1f B", value / 1000000000)
			end
			return format("%.1f B", value / 1000000000)
		elseif value > 999999 then
			if short then
				return format("%.1f M", value / 1000000)
			end
			return format("%.1f M", value / 1000000)
		elseif value > 999 then
			if short then
				return format("%.1f K", value / 1000)
			end
			return format("%.1f K", value / 1000)
		else
			return value
		end
	elseif DUFGetConfig("numbermode", "X.X Dynamic") == "X.XX Dynamic" then
		if value > 999999999 then
			if short then
				return format("%.2f B", value / 1000000000)
			end
			return format("%.2f B", value / 1000000000)
		elseif value > 999999 then
			if short then
				return format("%.2f M", value / 1000000)
			end
			return format("%.2f M", value / 1000000)
		elseif value > 999 then
			if short then
				return format("%.2f K", value / 1000)
			end
			return format("%.2f K", value / 1000)
		else
			return value
		end
	elseif DUFGetConfig("numbermode", "X.X Dynamic") == "X.XXX" then
		return DUFDottedNumber(value)
	elseif DUFGetConfig("numbermode", "X.X Dynamic") == "XK" then
		return format("%.0f K", value / 1000)
	elseif DUFGetConfig("numbermode", "X.X Dynamic") == "X.XK" then
		return format("%.1f K", value / 1000)
	elseif DUFGetConfig("numbermode", "X.X Dynamic") == "X.XXK" then
		return format("%.2f K", value / 1000)
	else
		return value
	end
end

function DUFPN(vcur, vmax)
	if vcur == nil or vmax == nil then return end
	vcur = tonumber(vcur)
	vmax = tonumber(vmax)
	if vmax > 0 then
		local value = vcur / vmax * 100
		if DUFGetConfig("percentmode", "X.X%") == "X.X%" then
			value = string.format("%.1f", value)
		elseif DUFGetConfig("percentmode", "X.X%") == "X.XX%" then
			value = string.format("%.2f", value)
		end
		return value .. "%"
	else
		return ""
	end
end