local DongleUtils = {}
PerfectRaid.utils = DongleUtils

function DongleUtils.RGBToHex(r, g, b)
	return string.format("%02x%02x%02x", r, g, b)
end


function DongleUtils.RGBPercToHex(r, g, b)
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end


function DongleUtils.HexToRGB(hex)
	local rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
	return tonumber(rhex, 16), tonumber(ghex, 16), tonumber(bhex, 16)
end


function DongleUtils.HexToRGBPerc(hex)
	local rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
	return tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255
end


function DongleUtils.ColorGradient(perc, ...)
	local num = select("#", ...)
	local hexes = type(select(1, ...)) == "string"

	if perc >= 1 then
		if hexes then return select(num, ...)
		else return select(num-2, ...), select(num-1, ...), select(num, ...) end
	end

	if perc <= 0 then
		if hexes then return select(1, ...)
		else return select(1, ...), select(2, ...), (select(3, ...)) end
	end

	if not hexes then num = num / 3 end

	local segment, relperc = math.modf(perc*(num-1))
	local r1, g1, b1, r2, g2, b2
	if hexes then
		r1, g1, b1 = DongleUtils.HexToRGBPerc(select(segment+1, ...))
		r2, g2, b2 = DongleUtils.HexToRGBPerc(select(segment+2, ...))
	else
		r1, g1, b1 = select((segment*3)+1, ...), select((segment*3)+2, ...), select((segment*3)+3, ...)
		r2, g2, b2 = select((segment*3)+4, ...), select((segment*3)+5, ...), select((segment*3)+6, ...)
	end

	if hexes then
		return DongleUtils.RGBToHex(r1 + (r2-r1)*relperc,
			g1 + (g2-g1)*relperc,
			b1 + (b2-b1)*relperc)
	else
		return r1 + (r2-r1)*relperc,
			g1 + (g2-g1)*relperc,
			b1 + (b2-b1)*relperc
	end
end


function DongleUtils.GetHPSeverity(perc, class)
	if not class then return DongleUtils.ColorGradient(perc, 1,0,0, 1,1,0, 0,1,0)
	else
		local c = RAID_CLASS_COLORS[class]
		return DongleUtils.ColorGradient(perc, 1,0,0, 1,1,0, c.r,c.g,c.b)
	end
end
