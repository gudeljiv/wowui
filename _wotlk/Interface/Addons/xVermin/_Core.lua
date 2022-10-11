local _, xVermin = ...
local RangeCheck = LibStub('LibRangeCheck-2.0')

-- RAID_CLASS_COLORS["SHAMAN"] = {r = 0 / 255, g = 112 / 255, b = 222 / 255, colorStr = "ff0070DE"}
xVermin.Class = select(2, UnitClass('player'))
xVermin.ClassColor = RAID_CLASS_COLORS[xVermin.Class]
xVermin.WaitTimeUntillAddonLoaded = 30

xVermin.Color = {
	white = 'FFFFFFFF',
	yellow = 'FFFFFF00',
	green = 'FF00FF00',
	red = 'FFFF0000',
	blue = 'FF0000FF',
	grey = 'FF808080',
	black = 'FF000000',
	cyan = 'FF00FFFF',
	teal = 'FF008080',
	navy = 'FF000080',
	purple = 'FF800080',
	maroon = 'FF800000',
	silver = 'FFC0C0C0',
	orange = 'FFFFA500',
	darkorange = 'FFFF8C00',
	royalblue = 'FF4169E1',
	Classes = {
		mage = 'FF40C7EB',
		dk = 'FFC41F3B',
		dh = 'FFFF7D0A',
		druid = 'FFFF7D0A',
		hunter = 'FFA9D271',
		monk = 'FF00FF96',
		paladin = 'FFF58CBA',
		priest = 'FFFFFFFF',
		rogue = 'FFFFF569',
		shaman = 'FF0070DE',
		warlock = 'FF8787ED',
		warrior = 'FFC79C6E'
	}
}

SLASH_RELOAD1 = '/rl'
SlashCmdList['RELOAD'] = function(msg)
	ReloadUI()
end

xVermin.FormatValue = function(self)
	if (self >= 10000) then
		return ('%.1fk'):format(self / 1e3)
	else
		return self
	end
end

xVermin.FormatNumber = function(number, divider)
	if not divider then
		divider = '.'
	end
	if not number then
		return 0
	else
		number = tonumber(number)
	end
	if abs(number) < 1000 then
		return number
	end
	local neg = number < 0 and '-' or ''
	local left, mid, right = tostring(abs(number)):match('^([^%d]*%d)(%d*)(.-)$')
	return ('%s%s%s%s'):format(neg, left, mid:reverse():gsub('(%d%d%d)', '%1' .. divider):reverse(), right)
end

xVermin.Round = function(number, decimals)
	if not number or tonumber(number) == nil then
		return 0
	end

	local mult = 10 ^ (decimals or 0)
	return math.floor(number * mult + 0.5) / mult
end
xRound = xVermin.Round

xVermin.ColorGradient = function(perc, ...)
	if perc >= 1 then
		r, g, b = select(select('#', ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		r, g, b = ...
		return r, g, b
	end

	local num = select('#', ...) / 3
	local segment, relperc = math.modf(perc * (num - 1))
	local r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...)
	return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
end

xVermin.TimeFormat = function(time)
	local days = floor(time / 86400)
	local hours = floor(mod(time, 86400) / 3600)
	local minutes = floor(mod(time, 3600) / 60)
	local seconds = floor(mod(time, 60))
	if (time > 3599) then
		return format('%01d:%02d:%02d', hours, minutes, seconds)
	else
		return format('%02d:%02d', minutes, seconds)
	end
end

xVermin.HEX2RGB = function(hex)
	hex = hex:gsub('#', '')
	local r = tonumber('0x' .. hex:sub(1, 2)) / 255
	local g = tonumber('0x' .. hex:sub(3, 4)) / 255
	local b = tonumber('0x' .. hex:sub(5, 6)) / 255
	return {r = r, g = g, b = b, a = 1}
end

xVermin.RGB2HEX = function(r, g, b, a)
	a = a or 1
	return string.format('%02x%02x%02x%02x', math.floor(a * 255), math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))
end

local keywords = {
	['and'] = 'and',
	['or'] = 'or'
}
xVermin.CheckIfLoadedWithTimer = function(condition, callback)
	local count = 0

	C_Timer.NewTicker(
		1,
		function(self)
			if (count > xVermin.WaitTimeUntillAddonLoaded) then
				self:Cancel()
			end
			count = count + 1

			local next_keyword, c
			if (condition_table) then
				condition_table = nil
			end
			local condition_table = {}
			condition_table['and'] = {}
			condition_table['or'] = {}

			condition:gsub(
				'[_%w]+',
				function(word)
					-- return keywords[word] or string.format("_G[%q]", word)
					-- text.keywords[word] = string.format('_G[%q]', word)
					if keywords[word] then
						next_keyword = keywords[word]
					else
						if next_keyword then
							table.insert(condition_table[next_keyword], word)
						else
							table.insert(condition_table, word)
						end
					end
				end
			)

			for k, v in ipairs(condition_table) do
				c = _G[v]
			end
			for k, v in ipairs(condition_table['and']) do
				c = c and _G[v]
			end
			for k, v in ipairs(condition_table['or']) do
				c = c or _G[v]
			end

			if (c) then
				callback()
				self:Cancel()
			end
		end
	)
end

xVermin.HasValue = function(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

xVermin.IfUnitIsCastingInteruptable = function(unit)
	local name_casting, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible_casting, spellId = UnitCastingInfo(unit)
	local name_channeling, text, texture, startTimeMS, endTimeMS, isTradeSkill, notInterruptible_chanelling, spellId = UnitChannelInfo(unit)
	if (name_casting ~= nil and not notInterruptible_casting) or (name_channeling ~= nil and not notInterruptible_chanelling) then
		return true
	end
	return false
end

xVermin.GetRange = function(unit)
	if UnitExists(unit) then
		minRange, maxRange = RangeCheck:GetRange(unit)
		return minRange, maxRange
	else
		return -1, -1
	end
end
