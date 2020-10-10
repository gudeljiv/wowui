local _, xVermin = ...

RAID_CLASS_COLORS["SHAMAN"] = {r = 0 / 255, g = 112 / 255, b = 222 / 255, colorStr = "ff0070DE"}
xVermin.Class = select(2, UnitClass("player"))
xVermin.ClassColor = RAID_CLASS_COLORS[xVermin.Class]

SLASH_RELOAD1 = "/rl"
SlashCmdList["RELOAD"] = function(msg)
	ReloadUI()
end

local function FixCVar()
	SetCVar("autoQuestWatch", 0)
	SetCVar("autoQuestProgress", 0)
	SetCVar("instantQuestText", 1)
	SetCVar("nameplateMaxDistance", 80)
	SetCVar("ffxGlow", "1")
	SetCVar("ffxDeath", "0")
	SetCVar("ffxNether", "0")
	SetCVar("violenceLevel", "5")
	SetCVar("cameraDistanceMaxZoomFactor", 4.0)
	SetCVar("chatClassColorOverride", 0)
	SetCVar("ShowClassColorInFriendlyNameplate", 1)
	SetCVar("scriptErrors", "1")
	SetCVar("alwaysShowActionBars", "1")
	SetCVar("AutoInteract", "0")
end

local frame = CreateFrame("Frame", "CVarSet")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if event == "PLAYER_ENTERING_WORLD" and isInitialLogin then
			if not InCombatLockdown() then
				FixCVar()
			else
				self:RegisterEvent("PLAYER_REGEN_ENABLED")
			end
		end

		if event == "PLAYER_REGEN_ENABLED" then
			FixCVar()
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		end
	end
)

function xVermin:FormatValue(self)
	if (self >= 10000) then
		return ("%.1fk"):format(self / 1e3)
	else
		return self
	end
end

function xVermin:FormatNumber(num, divider)
	if not divider then
		divider = "."
	end
	if not num then
		return 0
	end
	if abs(num) < 1000 then
		return num
	end
	local neg = num < 0 and "-" or ""
	local left, mid, right = tostring(abs(num)):match("^([^%d]*%d)(%d*)(.-)$")
	return ("%s%s%s%s"):format(neg, left, mid:reverse():gsub("(%d%d%d)", "%1" .. divider):reverse(), right)
end

function xVermin:Round(num, decimals)
	if not num then
		return 0
	end
	if not decimals then
		decimals = 0
	end
	return string.format("%." .. decimals .. "f", num)
end

function xVermin:ColorGradient(perc, ...)
	if perc >= 1 then
		r, g, b = select(select("#", ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		r, g, b = ...
		return r, g, b
	end

	num = select("#", ...) / 3
	segment, relperc = math.modf(perc * (num - 1))
	r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...)
	return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
end

function xVermin:TimeFormat(time)
	local days = floor(time / 86400)
	local hours = floor(mod(time, 86400) / 3600)
	local minutes = floor(mod(time, 3600) / 60)
	local seconds = floor(mod(time, 60))
	if (time > 3599) then
		return format("%01d:%02d:%02d", hours, minutes, seconds)
	else
		return format("%02d:%02d", minutes, seconds)
	end
end
