local _, nBuff = ...
local cfg = nBuff.Config

local _G = _G
local unpack = unpack

--[[
_G.DAY_ONELETTER_ABBR = '|cffffffff%dd|r'
_G.HOUR_ONELETTER_ABBR = '|cffffffff%dh|r'
_G.MINUTE_ONELETTER_ABBR = '|cffffffff%dm|r'
_G.SECOND_ONELETTER_ABBR = '|cffffffff%d|r'

-- _G.DEBUFF_MAX_DISPLAY = 32 -- show more debuffs
-- _G.BUFF_MIN_ALPHA = 1
--]]
-- local origSecondsToTimeAbbrev = _G.SecondsToTimeAbbrev
local function SecondsToTimeAbbrevHook(seconds)
	-- origSecondsToTimeAbbrev(seconds)

	-- local tempTime
	-- if (seconds >= 86400) then
	-- 	tempTime = ceil(seconds / 86400)
	-- 	return "|cffffffff%dd|r", tempTime
	-- end

	-- if (seconds >= 3600) then
	-- 	tempTime = ceil(seconds / 3600)
	-- 	return "|cffffffff%dh|r", tempTime
	-- end

	-- if (seconds >= 60) then
	-- 	tempTime = ceil(seconds / 60)
	-- 	return "|cffffffff%dm|r", tempTime
	-- end

	local tempTime
	local threshold = 1
	if seconds >= SECONDS_PER_DAY * threshold then
		tempTime = ceil(seconds / SECONDS_PER_DAY)
		-- return DAY_ONELETTER_ABBR, tempTime;
		return "|cffffffff%dd|r", tempTime
	end
	if seconds >= SECONDS_PER_HOUR * threshold then
		tempTime = ceil(seconds / SECONDS_PER_HOUR)
		-- return HOUR_ONELETTER_ABBR, tempTime;
		return "|cffffffff%dh|r", tempTime
	end
	if seconds >= SECONDS_PER_MIN * threshold then
		tempTime = ceil(seconds / SECONDS_PER_MIN)
		-- return MINUTE_ONELETTER_ABBR, tempTime;
		return "|cffffffff%dm|r", tempTime
	end
	-- return SECOND_ONELETTER_ABBR, seconds;

	return "|cffffffff%d|r", seconds
end
SecondsToTimeAbbrev = SecondsToTimeAbbrevHook

-- BuffFrame:SetScript("OnUpdate", nil)

local function SetupTempEnchants()
	if not BuffFrame then
		return
	end

	-- Get the children of BuffFrame
	local numChildren = BuffFrame:GetNumChildren()
	local children = { BuffFrame:GetChildren() }

	local firstEnchantIndex = nil

	-- The first few unnamed buttons are typically the temp enchants
	for i = 1, math.min(3, numChildren) do
		local child = children[i]

		if child then
			child:ClearAllPoints()
			-- child:CreateBeautyBorder(8)
			if i == 1 then
				firstEnchantIndex = child
				child:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", 0, 0)
			else
				local prevChild = children[i - 1]
				if prevChild then
					child:SetPoint("TOPRIGHT", prevChild, "TOPLEFT", -cfg.paddingX, 0)
				end
			end
		end
	end
end

-- Update when enchants change
local f = CreateFrame("Frame")
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(_, event, unit)
	if event == "PLAYER_ENTERING_WORLD" or (event == "UNIT_INVENTORY_CHANGED" and unit == "player") then
		C_Timer.After(0.5, SetupTempEnchants)
	end
end)

local function CheckFirstButton()
	if BuffButton1 then
		SetupTempEnchants(BuffButton1)
	end
end

local function UpdateBuffLayout()
	SetupTempEnchants()
	local previousBuff, aboveBuff
	local numBuffs = 0
	local numTotal = BuffFrame.numEnchants

	for i = 1, BUFF_ACTUAL_DISPLAY do
		local buff = _G["BuffButton" .. i]
		if not buff then
			break
		end

		numBuffs = numBuffs + 1
		numTotal = numTotal + 1

		buff:ClearAllPoints()
		if numBuffs == 1 then
			UpdateFirstButton(buff)
		elseif numBuffs > 1 and mod(numTotal, cfg.buffPerRow) == 1 then
			if numTotal == cfg.buffPerRow + 1 then
				buff:SetPoint("TOP", firstEnchantIndex, "BOTTOM", 0, -cfg.paddingY)
			else
				buff:SetPoint("TOP", aboveBuff, "BOTTOM", 0, -cfg.paddingY)
			end
			aboveBuff = buff
		else
			buff:SetPoint("TOPRIGHT", previousBuff, "TOPLEFT", -cfg.paddingX, 0)
		end

		previousBuff = buff
	end
end

-- Hook into buff events
local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", function(self, event, unit)
	if unit == "player" then
		UpdateBuffLayout()
	end
end)

local function UpdateDebuffAnchors()
	SetupTempEnchants()
	local numBuffs = BUFF_ACTUAL_DISPLAY + BuffFrame.numEnchants

	local debuffSpace = cfg.buffSize + cfg.paddingY
	local numRows = ceil(numBuffs / cfg.buffPerRow)

	local rowSpacing
	if numRows and numRows > 1 then
		rowSpacing = -numRows * debuffSpace
	else
		rowSpacing = -debuffSpace
	end

	for i = 1, DEBUFF_ACTUAL_DISPLAY do
		local debuff = _G["DebuffButton" .. i]
		if not debuff or not debuff:IsShown() then
			break
		end

		debuff:ClearAllPoints()
		if i == 1 then
			debuff:SetPoint("TOP", firstEnchantIndex, "BOTTOM", 0, rowSpacing)
		elseif i >= 2 and mod(i, cfg.buffPerRow) == 1 then
			debuff:SetPoint("TOP", _G["DebuffButton" .. (i - cfg.buffPerRow)], "BOTTOM", 0, -cfg.paddingY)
		else
			debuff:SetPoint("TOPRIGHT", _G["DebuffButton" .. (i - 1)], "TOPLEFT", -cfg.paddingX, 0)
		end
	end
end

-- Register events to update debuff layout
local debuffFrame = CreateFrame("Frame")
debuffFrame:RegisterEvent("UNIT_AURA")
debuffFrame:SetScript("OnEvent", function(self, event, unit)
	if unit == "player" then
		UpdateDebuffAnchors()
	end
end)

-- for i = 1, NUM_TEMP_ENCHANT_FRAMES do
-- 	local button = _G["TempEnchant" .. i]
-- 	button:SetScale(cfg.buffScale)
-- 	button:SetSize(cfg.buffSize, cfg.buffSize)

-- 	button:SetScript("OnShow", function()
-- 		CheckFirstButton()
-- 	end)

-- 	button:SetScript("OnHide", function()
-- 		CheckFirstButton()
-- 	end)

-- 	local icon = _G["TempEnchant" .. i .. "Icon"]
-- 	icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)

-- 	local duration = _G["TempEnchant" .. i .. "Duration"]
-- 	duration:ClearAllPoints()
-- 	duration:SetPoint("BOTTOM", button, "BOTTOM", 0, -2)
-- 	duration:SetFont(cfg.durationFont, cfg.buffFontSize, "THINOUTLINE")
-- 	duration:SetShadowOffset(0, 0)
-- 	duration:SetDrawLayer("OVERLAY")

-- 	local border = _G["TempEnchant" .. i .. "Border"]
-- 	border:ClearAllPoints()
-- 	border:SetPoint("TOPRIGHT", button, 1, 1)
-- 	border:SetPoint("BOTTOMLEFT", button, -1, -1)
-- 	border:SetTexture(cfg.borderDebuff)
-- 	border:SetTexCoord(0, 1, 0, 1)
-- 	border:SetVertexColor(0.9, 0.25, 0.9)

-- 	button.Shadow = button:CreateTexture("$parentBackground", "BACKGROUND")
-- 	button.Shadow:SetPoint("TOPRIGHT", border, 3.35, 3.35)
-- 	button.Shadow:SetPoint("BOTTOMLEFT", border, -3.35, -3.35)
-- 	button.Shadow:SetTexture("Interface\\AddOns\\nBuff\\media\\textureShadow")
-- 	button.Shadow:SetVertexColor(0, 0, 0, 1)
-- end

local function StyleAuraButton(buttonName, index, isDebuff)
	local button = _G[buttonName .. index]
	if not button then
		return
	end

	-- Only style once
	if button.nbuffStyled then
		return
	end
	button.nbuffStyled = true

	-- Set size and scale
	if isDebuff then
		button:SetSize(cfg.debuffSize, cfg.debuffSize)
		button:SetScale(cfg.debuffScale)
	else
		button:SetSize(cfg.buffSize, cfg.buffSize)
		button:SetScale(cfg.buffScale)
	end

	-- Style icon
	local icon = _G[buttonName .. index .. "Icon"]
	if icon then
		icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)
	end

	-- Style duration text
	local duration = _G[buttonName .. index .. "Duration"]
	if duration then
		duration:ClearAllPoints()
		duration:SetPoint("BOTTOM", button, "BOTTOM", 0, -2)
		if isDebuff then
			duration:SetFont(cfg.durationFont, cfg.debuffFontSize, "THINOUTLINE")
		else
			duration:SetFont(cfg.durationFont, cfg.buffFontSize, "THINOUTLINE")
		end
		duration:SetShadowOffset(0, 0)
		duration:SetDrawLayer("OVERLAY")
	end

	-- Style count text
	local count = _G[buttonName .. index .. "Count"]
	if count then
		count:ClearAllPoints()
		count:SetPoint("TOPRIGHT", button)
		if isDebuff then
			count:SetFont(cfg.countFont, cfg.debuffCountSize, "THINOUTLINE")
		else
			count:SetFont(cfg.countFont, cfg.buffCountSize, "THINOUTLINE")
		end
		count:SetShadowOffset(0, 0)
		count:SetDrawLayer("OVERLAY")
	end

	-- Style border
	local border = _G[buttonName .. index .. "Border"]
	if border then
		border:SetTexture(cfg.borderDebuff)
		border:SetPoint("TOPRIGHT", button, 1, 1)
		border:SetPoint("BOTTOMLEFT", button, -1, -1)
		border:SetTexCoord(0, 1, 0, 1)
	end

	-- Create buff border if no debuff border exists
	if not border and not isDebuff then
		if not button.texture then
			button.texture = button:CreateTexture("$parentOverlay", "ARTWORK")
			button.texture:SetParent(button)
			button.texture:SetTexture(cfg.borderBuff)
			button.texture:SetPoint("TOPRIGHT", button, 1, 1)
			button.texture:SetPoint("BOTTOMLEFT", button, -1, -1)
			button.texture:SetVertexColor(unpack(cfg.buffBorderColor))
		end
	end

	-- Create shadow
	if not button.Shadow then
		button.Shadow = button:CreateTexture("$parentShadow", "BACKGROUND")
		button.Shadow:SetTexture("Interface\\AddOns\\nBuff\\media\\textureShadow")
		button.Shadow:SetPoint("TOPRIGHT", button.texture or border, 3.35, 3.35)
		button.Shadow:SetPoint("BOTTOMLEFT", button.texture or border, -3.35, -3.35)
		button.Shadow:SetVertexColor(0, 0, 0, 1)
	end
end

local function StyleAllAuras()
	-- Style buffs (check until we find a nil button)
	local maxBuffs = BUFF_ACTUAL_DISPLAY or 32 -- Fallback to 32
	for i = 1, maxBuffs do
		local button = _G["BuffButton" .. i]
		if button then
			StyleAuraButton("BuffButton", i, false)
		end
	end

	-- Style temp enchants
	local maxEnchants = NUM_TEMP_ENCHANT_FRAMES or 3 -- Fallback to 3
	for i = 1, maxEnchants do
		local button = _G["TempEnchant" .. i]
		if button then
			StyleAuraButton("TempEnchant", i, false)
		end
	end

	-- Style debuffs
	local maxDebuffs = DEBUFF_ACTUAL_DISPLAY or 16 -- Fallback to 16
	for i = 1, maxDebuffs do
		local button = _G["DebuffButton" .. i]
		if button then
			StyleAuraButton("DebuffButton", i, true)
		end
	end
end

-- Hook into the event system
local styleFrame = CreateFrame("Frame")
styleFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
styleFrame:RegisterEvent("UNIT_AURA")
styleFrame:SetScript("OnEvent", function(self, event, unit)
	if event == "PLAYER_ENTERING_WORLD" or unit == "player" then
		StyleAllAuras()
	end
end)

-- Also style immediately on load
StyleAllAuras()
