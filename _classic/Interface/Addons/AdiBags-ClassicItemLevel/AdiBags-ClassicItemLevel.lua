local _, ns = ...

local addon = LibStub('AceAddon-3.0'):GetAddon('AdiBags')
local L = setmetatable({}, {__index = addon.L})

local mod = addon:NewModule("ClassicItemLevel", 'ABEvent-1.0')
mod.uiName = L['Classic item level']
mod.uiDesc = L['Adds Classic-compatable item level text to items']

local maxLevelColors = {}
do
	local t = maxLevelColors
	t[1], t[2], t[3] = GetItemQualityColor(2)
	t[4], t[5], t[6] = GetItemQualityColor(3)
	t[7], t[8], t[9] = GetItemQualityColor(4)
	t[10], t[11], t[12] = GetItemQualityColor(5)
end

function mod:OnInitialize()
	self.db = addon.db:RegisterNamespace(self.moduleName, {
		profile = {
			equippableOnly = true,
			minLevel = 1,
			ignoreJunk = true,
		},
	})
end

function mod:OnEnable()
	self:RegisterMessage('AdiBags_UpdateButton', 'UpdateButton')
	self:SendMessage('AdiBags_UpdateAllButtons')
end

function mod:OnDisable()
	self:SendMessage('AdiBags_UpdateAllButtons')
end

function mod:GetOptions()
	return {
		equippableOnly = {
			name = L['Only equippable items'],
			desc = L['Do not show level of items that cannot be equipped.'],
			type = 'toggle',
			order = 10,
		},
		minLevel = {
			name = L['Mininum level'],
			desc = L['Do not show levels under this threshold.'],
			type = 'range',
			min = 1,
			max = 1000,
			step = 1,
			bigStep = 10,
			order = 30,
		},
		ignoreJunk = {
			name = L['Ignore low quality items'],
			desc = L['Do not show level of poor quality items.'],
			type = 'toggle',
			order = 40,
		},
	}, addon:GetOptionHandler(self)
end

local function CreateText(button)
	local text = button:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
	text:SetPoint("TOPLEFT", button, 3, -2)
	text:SetAlpha(1)
	text:Show()
	button.ClassicItemLevelText = text
	return text
end

local function isMaxLevel(level)
	return level == 60
end

function mod:UpdateButton(event, button)
	local settings = self.db.profile
	local link = button:GetItemLink()
	local text = button.ClassicItemLevelText

	if link then
		local _, _, quality, _, reqLevel, _, _, _, loc = GetItemInfo(link)
		local item = Item:CreateFromBagAndSlot(button.bag, button.slot)
		local playerLevel = UnitLevel('player')
		local ignoreHighLevel = false
		local level = nil

		if reqLevel and reqLevel > 0 and not isMaxLevel(playerLevel) then
			level = reqLevel
		elseif item then
			level = item:GetCurrentItemLevel()
			ignoreHighLevel = true
		end

		if level == nil then
			level = 0
		end

		if level >= settings.minLevel
			and (quality ~= LE_ITEM_QUALITY_POOR or not settings.ignoreJunk)
			and (loc ~= "" or not settings.equippableOnly)
		then
			if not text then
				text = CreateText(button)
			end
			text:SetText(level)
			-- text:SetTextColor(getTextColor(playerLevel, level, ignoreHighLevel, quality, (loc ~= "")))
			text:SetAlpha(1)
			return
		end
	end
	if text then
		text:SetAlpha(0)
	end
end

local function GetY(r, g, b)
	return 0.3 * r + 0.59 * g + 0.11 * b
end

local function RGBToHCY(r, g, b)
	local min, max = min(r, g, b), max(r, g, b)
	local chroma = max - min
	local hue
	if chroma > 0 then
		if r == max then
			hue = ((g - b) / chroma) % 6
		elseif g == max then
			hue = (b - r) / chroma + 2
		elseif b == max then
			hue = (r - g) / chroma + 4
		end
		hue = hue / 6
	end
	return hue, chroma, GetY(r, g, b)
end

local function HCYtoRGB(hue, chroma, luma)
	local r, g, b = 0, 0, 0
	if hue then
		local h2 = hue * 6
		local x = chroma * (1 - abs(h2 % 2 - 1))
		if h2 < 1 then
			r, g, b = chroma, x, 0
		elseif h2 < 2 then
			r, g, b = x, chroma, 0
		elseif h2 < 3 then
			r, g, b = 0, chroma, x
		elseif h2 < 4 then
			r, g, b = 0, x, chroma
		elseif h2 < 5 then
			r, g, b = x, 0, chroma
		else
			r, g, b = chroma, 0, x
		end
	end
	local m = luma - GetY(r, g, b)
	return r + m, g + m, b + m
end

local function colorGradient(a, b, ...)
	local perc
	if(b == 0) then
		perc = 0
	else
		perc = a / b
	end

	if perc >= 1 then
		local r, g, b = select(select('#', ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		local r, g, b = ...
		return r, g, b
	end

	local num = select('#', ...) / 3
	local segment, relperc = math.modf(perc*(num-1))
	local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

	local h1, c1, y1 = RGBToHCY(r1, g1, b1)
	local h2, c2, y2 = RGBToHCY(r2, g2, b2)
	local c = c1 + (c2-c1) * relperc
	local	y = y1 + (y2-y1) * relperc
	if h1 and h2 then
		local dh = h2 - h1
		if dh < -0.5  then
			dh = dh + 1
		elseif dh > 0.5 then
			dh = dh - 1
		end
		return HCYtoRGB((h1 + dh * relperc) % 1, c, y)
	else
		return HCYtoRGB(h1 or h2, c, y)
	end

end

function getTextColor(playerLevel, level, ignoreHighLevel, quality, equipabble)
	if not equipabble then return 1,1,1 end
	if isMaxLevel(playerLevel) then
		local minLevel = 58
		local maxLevel = 90

		if level < minLevel then
			return GetItemQualityColor(0)
		else
			return colorGradient(level - minLevel, maxLevel - minLevel, unpack(maxLevelColors))
		end
	elseif level and level > 1 then
		local color
		local delta = playerLevel - level
		if delta < 0 and not ignoreHighLevel then
			color = QuestDifficultyColors.impossible
		elseif delta > 8 then
			color = QuestDifficultyColors.trivial
		else
			return GetItemQualityColor(quality)
		end
		return color.r, color.g, color.b
	else
		return 1, 1, 1
	end
end
