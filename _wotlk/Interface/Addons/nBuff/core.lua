local _, nBuff = ...
local cfg = nBuff.Config

local _G = _G
local unpack = unpack

local function formatTime(seconds)
	if (seconds >= 86400) then
		return '|cffffffff%dd|r', ceil(seconds / 86400)
	end

	if (seconds >= 3600) then
		return '|cffffffff%dh|r', ceil(seconds / 3600)
	end

	if (seconds >= 60) then
		return '|cffffffff%dm|r', ceil(seconds / 60)
	end

	return '|cffffffff%d|r', seconds
end

-- local origSecondsToTimeAbbrev = _G.SecondsToTimeAbbrev
-- local function ____SecondsToTimeAbbrev(seconds)
-- origSecondsToTimeAbbrev(seconds)

-- 	if (seconds >= 86400) then
-- 		return '|cffffffff%dd|r', ceil(seconds / 86400)
-- 	end

-- 	if (seconds >= 3600) then
-- 		return '|cffffffff%dh|r', ceil(seconds / 3600)
-- 	end

-- 	if (seconds >= 60) then
-- 		return '|cffffffff%dm|r', ceil(seconds / 60)
-- 	end

-- 	return '|cffffffff%d|r', seconds
-- end
-- SecondsToTimeAbbrev = SecondsToTimeAbbrevHook

BuffFrame:SetScript('OnUpdate', nil)

TempEnchant1:ClearAllPoints()
TempEnchant1:SetPoint('TOPRIGHT', MinimapCluster, 'TOPLEFT', 0, -65)
TempEnchant2:ClearAllPoints()
TempEnchant2:SetPoint('TOPRIGHT', TempEnchant1, 'TOPLEFT', -cfg.paddingX, 0)

local function UpdateFirstButton(self)
	if (self and self:IsShown()) then
		self:ClearAllPoints()

		if (BuffFrame.numEnchants == 1) then
			self:SetPoint('TOPRIGHT', TempEnchant1, 'TOPLEFT', -cfg.paddingX, 0)
			return
		elseif (BuffFrame.numEnchants == 2) then
			self:SetPoint('TOPRIGHT', TempEnchant2, 'TOPLEFT', -cfg.paddingX, 0)
			return
		elseif (BuffFrame.numEnchants == 3) then
			self:SetPoint('TOPRIGHT', TempEnchant3, 'TOPLEFT', -cfg.paddingX, 0)
			return
		else
			self:SetPoint('TOPRIGHT', TempEnchant1)
			return
		end
	end
end

local function CheckFirstButton()
	if (BuffButton1) then
		UpdateFirstButton(BuffButton1)
	end
end

hooksecurefunc(
	'BuffFrame_UpdateAllBuffAnchors',
	function()
		local previousBuff, aboveBuff
		local numBuffs = 0
		local numTotal = BuffFrame.numEnchants

		for i = 1, BUFF_ACTUAL_DISPLAY do
			local buff = _G['BuffButton' .. i]

			numBuffs = numBuffs + 1
			numTotal = numTotal + 1

			buff:ClearAllPoints()
			if (numBuffs == 1) then
				UpdateFirstButton(buff)
			elseif (numBuffs > 1 and mod(numTotal, cfg.buffPerRow) == 1) then
				if (numTotal == cfg.buffPerRow + 1) then
					buff:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, -cfg.paddingY)
				else
					buff:SetPoint('TOP', aboveBuff, 'BOTTOM', 0, -cfg.paddingY)
				end

				aboveBuff = buff
			else
				buff:SetPoint('TOPRIGHT', previousBuff, 'TOPLEFT', -cfg.paddingX, 0)
			end

			previousBuff = buff
		end
	end
)

hooksecurefunc(
	'DebuffButton_UpdateAnchors',
	function(self, index)
		local numBuffs = BUFF_ACTUAL_DISPLAY + BuffFrame.numEnchants

		local debuffSpace = cfg.buffSize + cfg.paddingY
		local numRows = ceil(numBuffs / cfg.buffPerRow)

		local rowSpacing
		if (numRows and numRows > 1) then
			rowSpacing = -numRows * debuffSpace
		else
			rowSpacing = -debuffSpace
		end

		local buff = _G[self .. index]
		buff:ClearAllPoints()
		if (index == 1) then
			buff:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, rowSpacing)
		elseif (index >= 2 and mod(index, cfg.buffPerRow) == 1) then
			buff:SetPoint('TOP', _G[self .. (index - cfg.buffPerRow)], 'BOTTOM', 0, -cfg.paddingY)
		else
			buff:SetPoint('TOPRIGHT', _G[self .. (index - 1)], 'TOPLEFT', -cfg.paddingX, 0)
		end
	end
)

for i = 1, NUM_TEMP_ENCHANT_FRAMES do
	local button = _G['TempEnchant' .. i]
	button:SetScale(cfg.buffScale)
	button:SetSize(cfg.buffSize, cfg.buffSize)

	button:SetScript(
		'OnShow',
		function()
			CheckFirstButton()
		end
	)

	button:SetScript(
		'OnHide',
		function()
			CheckFirstButton()
		end
	)

	local icon = _G['TempEnchant' .. i .. 'Icon']
	icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)

	local duration = _G['TempEnchant' .. i .. 'Duration']
	duration:ClearAllPoints()
	duration:SetPoint('BOTTOM', button, 'BOTTOM', 0, -2)
	duration:SetFont(cfg.durationFont, cfg.buffFontSize, 'THINOUTLINE')
	duration:SetShadowOffset(0, 0)
	duration:SetDrawLayer('OVERLAY')

	local border = _G['TempEnchant' .. i .. 'Border']
	border:ClearAllPoints()
	border:SetPoint('TOPRIGHT', button, 1, 1)
	border:SetPoint('BOTTOMLEFT', button, -1, -1)
	border:SetTexture(cfg.borderDebuff)
	border:SetTexCoord(0, 1, 0, 1)
	border:SetVertexColor(0.9, 0.25, 0.9)

	button.Shadow = button:CreateTexture('$parentBackground', 'BACKGROUND')
	button.Shadow:SetPoint('TOPRIGHT', border, 3.35, 3.35)
	button.Shadow:SetPoint('BOTTOMLEFT', border, -3.35, -3.35)
	button.Shadow:SetTexture('Interface\\AddOns\\nBuff\\media\\textureShadow')
	button.Shadow:SetVertexColor(0, 0, 0, 1)
end

hooksecurefunc(
	'AuraButton_Update',
	function(self, index)
		local button = _G[self .. index]

		if (button and not button.Shadow) then
			if (button) then
				if (self:match('Debuff')) then
					button:SetSize(cfg.debuffSize, cfg.debuffSize)
					button:SetScale(cfg.debuffScale)
				else
					button:SetSize(cfg.buffSize, cfg.buffSize)
					button:SetScale(cfg.buffScale)
				end
			end

			local icon = _G[self .. index .. 'Icon']
			if (icon) then
				icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)
			end

			local duration = _G[self .. index .. 'Duration']
			if (duration) then
				duration:ClearAllPoints()
				duration:SetPoint('BOTTOM', button, 'BOTTOM', 0, -2)
				if (self:match('Debuff')) then
					duration:SetFont(cfg.durationFont, cfg.debuffFontSize, 'THINOUTLINE')
				else
					duration:SetFont(cfg.durationFont, cfg.buffFontSize, 'THINOUTLINE')
				end
				duration:SetShadowOffset(0, 0)
				duration:SetDrawLayer('OVERLAY')
			end

			local count = _G[self .. index .. 'Count']
			if (count) then
				count:ClearAllPoints()
				count:SetPoint('TOPRIGHT', button)
				if (self:match('Debuff')) then
					count:SetFont(cfg.countFont, cfg.debuffCountSize, 'THINOUTLINE')
				else
					count:SetFont(cfg.countFont, cfg.buffCountSize, 'THINOUTLINE')
				end
				count:SetShadowOffset(0, 0)
				count:SetDrawLayer('OVERLAY')
			end

			local border = _G[self .. index .. 'Border']
			if (border) then
				border:SetTexture(cfg.borderDebuff)
				border:SetPoint('TOPRIGHT', button, 1, 1)
				border:SetPoint('BOTTOMLEFT', button, -1, -1)
				border:SetTexCoord(0, 1, 0, 1)
			end

			if (button and not border) then
				if (not button.texture) then
					button.texture = button:CreateTexture('$parentOverlay', 'ARTWORK')
					button.texture:SetParent(button)
					button.texture:SetTexture(cfg.borderBuff)
					button.texture:SetPoint('TOPRIGHT', button, 1, 1)
					button.texture:SetPoint('BOTTOMLEFT', button, -1, -1)
					button.texture:SetVertexColor(unpack(cfg.buffBorderColor))
				end
			end

			if (button) then
				if (not button.Shadow) then
					button.Shadow = button:CreateTexture('$parentShadow', 'BACKGROUND')
					button.Shadow:SetTexture('Interface\\AddOns\\nBuff\\media\\textureShadow')
					button.Shadow:SetPoint('TOPRIGHT', button.texture or border, 3.35, 3.35)
					button.Shadow:SetPoint('BOTTOMLEFT', button.texture or border, -3.35, -3.35)
					button.Shadow:SetVertexColor(0, 0, 0, 1)
				end
			end
		end
	end
)

local function getMilliseconds(time)
	local milliseconds = floor((time % 60) % 1 * 10)
	return milliseconds
end

local function formatTime(time)
	-- IF YOU ARE READING THIS YOU ARE PROBABLY A NERD AS WELL
	-- IF YOU KNOW A BETTER WAY TO WRITE THIS CODE PLEASE DM ME
	-- This all is a mess because of the different options in which to display the timestamp
	-- I really tried my best ok

	local timeStamp = 'hm'
	local isSecondsOption = false
	local isMillisecondsOption = false
	local showSecondsThreshold = 60
	local seconds = floor(time % 60)
	local minutes = floor(time / 60)
	local hours = floor(time / 60 / 60)
	local hourMins = ceil(time / 60 % 60) -- This calculates minutes beyond 1 hour
	local milliseconds = 0

	-- Used so we don't accidentally compare numbers with strings
	local str = ''
	local hourMinsStr = hourMins
	local secondsStr = seconds

	local isBelowShowSecThreshold = isSecondsOption and minutes < showSecondsThreshold
	local isBelowShowMillisecThreshold = isMillisecondsOption and minutes < 1 and seconds < 5

	-- Determine if we show time as "h:mm" if not we fall back to minutes
	if
		timeStamp == 'hm' and
			((minutes >= 59 and not isBelowShowSecThreshold) or -- Cases like 1h, 1:01h
				(minutes >= 60 and isBelowShowSecThreshold))
	 then -- Cases like 1:00:59
		-- Display as 2h / 1h etc without minutes
		if hourMins == 60 then
			hours = ceil(time / 60 / 60)
		end

		-- Display floored hour
		if minutes >= 59 then
			str = str .. hours
		end

		-- Determine if we show hourMins
		if
			(minutes >= 60 and hourMins < 60) or -- Cases like 1:01h through 1:59h
				(isBelowShowSecThreshold and minutes >= 59 and hourMins <= 60)
		 then -- Cases like 2:00:59
			if isBelowShowSecThreshold then
				-- Determine if we need to show hourMins as a zero (because it ranges between 1 and 60, and 60 == 0)
				if hourMins == 60 then
					hourMins = 0
					hourMinsStr = hourMins
				else
					-- If we show seconds we need to floor the hourMins
					hourMinsStr = floor(time / 60 % 60)
				end
			end

			-- Determine if we need to prepend hourMins with a zero
			if hourMins < 10 then
				hourMinsStr = 0 .. hourMinsStr
			end

			str = str .. ':' .. hourMinsStr
		end

		-- Determine if we show seconds
		if isBelowShowSecThreshold then
			-- Determine if we need to prepend seconds with a zero
			if seconds < 10 then
				secondsStr = 0 .. secondsStr
			end

			str = str .. ':' .. secondsStr
		end

		-- Determine if we show the "h" affix
		if not isBelowShowSecThreshold then
			str = str .. 'h'
		end
	else
		-- Determine if we show seconds
		if isBelowShowSecThreshold then
			if minutes >= 1 then
				-- Add minutes
				str = str .. minutes

				-- Determine if we need to prepend seconds with a zero
				if seconds < 10 then
					secondsStr = 0 .. secondsStr
				end

				str = str .. ':' .. secondsStr
			else
				-- Only show seconds / ms
				str = seconds

				if isBelowShowMillisecThreshold then
					milliseconds = getMilliseconds(time)
					str = str .. '.' .. milliseconds
				end

				str = str .. 's'
			end
		else
			-- If duration is less than an hour and seconds option is not toggled
			if minutes < 1 then
				str = seconds
				if isBelowShowMillisecThreshold then
					milliseconds = getMilliseconds(time)
					str = str .. '.' .. milliseconds
				end

				str = str .. 's'
			else
				minutes = ceil(time / 60)
				str = str .. minutes .. 'm'
			end
		end
	end

	return str
end

local function onAuraDurationUpdate(aura, time)
	local duration = getglobal(aura:GetName() .. 'Duration')

	if (time) then
		duration:SetText(formatTime(time))
		duration:SetTextColor(1, 1, 1)
		duration:Show()
	else
		duration:Hide()
	end
end

hooksecurefunc('AuraButton_UpdateDuration', onAuraDurationUpdate)
