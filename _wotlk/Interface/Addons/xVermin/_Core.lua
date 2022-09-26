local _, xVermin = ...

-- RAID_CLASS_COLORS["SHAMAN"] = {r = 0 / 255, g = 112 / 255, b = 222 / 255, colorStr = "ff0070DE"}
xVermin.Class = select(2, UnitClass('player'))
xVermin.ClassColor = RAID_CLASS_COLORS[xVermin.Class]

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

local function FixCVar()
	SetCVar('autoQuestWatch', 1)
	SetCVar('autoQuestProgress', 1)
	SetCVar('instantQuestText', 1)
	SetCVar('nameplateMaxDistance', 80)
	SetCVar('ffxGlow', '1')
	SetCVar('ffxDeath', '0')
	SetCVar('ffxNether', '0')
	SetCVar('violenceLevel', '5')
	SetCVar('cameraDistanceMaxZoomFactor', 4.0)
	SetCVar('chatClassColorOverride', 0)
	SetCVar('ShowClassColorInFriendlyNameplate', 1)
	SetCVar('scriptErrors', '1')
	SetCVar('alwaysShowActionBars', '1')
	SetCVar('AutoInteract', '0')
	SetCVar('cursorsizepreferred', '0')
end

local frame = CreateFrame('Frame', 'CVarSet')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		if event == 'PLAYER_ENTERING_WORLD' and isInitialLogin then
			if not InCombatLockdown() then
				FixCVar()
			else
				self:RegisterEvent('PLAYER_REGEN_ENABLED')
			end
		end

		if event == 'PLAYER_REGEN_ENABLED' then
			FixCVar()
			self:UnregisterEvent('PLAYER_REGEN_ENABLED')
		end
	end
)

function xVermin:FormatValue(self)
	if (self >= 10000) then
		return ('%.1fk'):format(self / 1e3)
	else
		return self
	end
end

-- function xVermin:FormatValue(value)
-- 	if value >= 1e6 then
-- 		return tonumber(format("%.1f", value/1e6)).."m"
-- 	elseif value >= 1e4 then
-- 		return tonumber(format("%.1f", value/1e3)).."k"
-- 	else
-- 		return value
-- 	end
-- end

function xVermin:FormatNumber(number, divider)
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

function xVermin:Round(number, decimals)
	if not number then
		return 0
	end
	local power = 10 ^ (decimals or 0)
	return floor(number * power) / power
end

function xVermin:ColorGradient(perc, ...)
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

function xVermin:TimeFormat(time)
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

function xVermin:hex2rgb(hex)
	hex = hex:gsub('#', '')
	local r = Rounds(tonumber('0x' .. hex:sub(1, 2)) / 255, 2)
	local g = Round(tonumber('0x' .. hex:sub(3, 4)) / 255, 2)
	local b = Round(tonumber('0x' .. hex:sub(5, 6)) / 255, 2)
	return {r = r, g = g, b = b, a = 1}
end
