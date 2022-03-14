-- LIB Math

function mathR(num, dec)
	dec = dec or 2
	return tonumber(string.format("%." .. dec .. "f", num))
end

function mathC(input, min, max)
	if input < min then
		input = min
	elseif input > max then
		input = max
	end
	return input
end

function RGBToDec(rgb)
	return mathR(rgb / 255, 2)
end
