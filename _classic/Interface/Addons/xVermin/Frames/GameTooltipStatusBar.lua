local _, xVermin = ...

local cfg = {
	fontSize = 14,
	fontOutline = false,
	position = {
		'BOTTOMRIGHT',
		UIParent,
		'BOTTOMRIGHT',
		-27.35,
		27.35
	},
	disableFade = false, -- Can cause errors or a buggy tooltip!
	showOnMouseover = true,
	hideInCombat = false, -- Hide unit frame tooltips during combat
	reactionBorderColor = false,
	itemqualityBorderColor = true,
	abbrevRealmNames = false,
	hideRealmText = false, -- Hide the coalesced/interactive realm text
	showPlayerTitles = true,
	showUnitRole = false,
	showPVPIcons = false, -- Show pvp icons instead of just a prefix
	showMouseoverTarget = true,
	showItemLevel = false,
	showSpecializationIcon = false,
	healthbar = {
		showHealthValue = true,
		healthFormat = '$cur / $max', -- Possible: $cur, $max, $deficit, $perc, $smartperc, $smartcolorperc, $colorperc
		healthFullFormat = '$cur', -- if the tooltip unit has 100% hp
		fontSize = 12,
		font = 'Fonts\\ARIALN.ttf',
		showOutline = true,
		textPos = 'CENTER', -- Possible 'TOP' 'BOTTOM' 'CENTER'
		reactionColoring = false, -- Overrides customColor
		customColor = {
			apply = false,
			r = 0,
			g = 1,
			b = 1
		}
	}
}

local select = select
local tonumber = tonumber

local modf = math.modf
local gsub = string.gsub
local format = string.format

local bar = GameTooltipStatusBar
bar.Text = bar:CreateFontString(nil, 'OVERLAY')
bar.Text:SetPoint('CENTER', bar, cfg.healthbar.textPos, 0, 1)

if cfg.healthbar.showOutline then
	bar.Text:SetFont(cfg.healthbar.font, cfg.healthbar.fontSize, 'THINOUTLINE')
	bar.Text:SetShadowOffset(0, 0)
else
	bar.Text:SetFont(cfg.healthbar.font, cfg.healthbar.fontSize)
	bar.Text:SetShadowOffset(1, -1)
end

local function ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select('#', ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		local r, g, b = ...
		return r, g, b
	end

	local num = select('#', ...) / 3

	local segment, relperc = modf(perc * (num - 1))
	local r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...)

	return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
end

local function FormatValue(value)
	if value >= 1e6 then
		return tonumber(format('%.1f', value / 1e6)) .. 'm'
	elseif value >= 1e3 then
		return tonumber(format('%.1f', value / 1e3)) .. 'k'
	else
		return value
	end
end

local function DeficitValue(value)
	if value == 0 then
		return ''
	else
		return '-' .. FormatValue(value)
	end
end

local function GetHealthTag(text, cur, max)
	local perc = format('%d', (cur / max) * 100)

	if max == 1 then
		return perc
	end

	local r, g, b = ColorGradient(cur / max, 1, 0, 0, 1, 1, 0, 0, 1, 0)
	text = gsub(text, '$cur', format('%s', FormatValue(cur)))
	text = gsub(text, '$max', format('%s', FormatValue(max)))
	text = gsub(text, '$deficit', format('%s', DeficitValue(max - cur)))
	text = gsub(text, '$perc', format('%d', perc) .. '%%')
	text = gsub(text, '$smartperc', format('%d', perc))
	text = gsub(text, '$smartcolorperc', format('|cff%02x%02x%02x%d|r', r * 255, g * 255, b * 255, perc))
	text = gsub(text, '$colorperc', format('|cff%02x%02x%02x%d', r * 255, g * 255, b * 255, perc) .. '%%|r')

	return text
end

GameTooltipStatusBar:HookScript(
	'OnValueChanged',
	function(self, value)
		if self.Text then
			self.Text:SetText('')
		end

		if not value then
			return
		end

		local min, max = self:GetMinMaxValues()

		if (value < min) or (value > max) or (value == 0) or (value == 1) then
			return
		end

		if not self.Text then
			CreateHealthString(self)
		end

		local fullString = GetHealthTag(cfg.healthbar.healthFullFormat, value, max)
		local normalString = GetHealthTag(cfg.healthbar.healthFormat, value, max)

		-- if RealMobHealth addon is loadad let him handle all the values
		if IsAddOnLoaded('RealMobHealth') then
			return
		end

		local perc = (value / max) * 100
		if perc >= 100 and currentValue ~= 1 then
			self.Text:SetText(fullString)
		elseif perc < 100 and currentValue ~= 1 then
			self.Text:SetText(normalString)
		else
			self.Text:SetText('')
		end
	end
)
