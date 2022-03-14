local _, xVermin = ...

local size = 125
local scale = 1.4
local bars = {}
local pet = false

local f = CreateFrame('Frame', xVerminReputationFrame, UIParent)
f:SetScale(scale)
f:SetSize(size, 12)
f:SetPoint('BOTTOMLEFT', ChatFrame1, 'BOTTOMRIGHT', 5, 50)

local function CreateBar(input)
	f.Wrapper = CreateFrame('Frame', input.frameStatusBar .. '_wrap', UIParent)
	f.Wrapper:SetScale(1)
	f.Wrapper:SetSize(size * scale, 30)
	f.Wrapper:SetPoint('CENTER', f, 0, 0)
	f.Wrapper:SetAlpha(0)

	f.Bar = CreateFrame('StatusBar', input.frameStatusBar, UIParent)
	f.Bar:SetScale(1)
	f.Bar:SetSize(size * scale, 2)
	f.Bar:SetPoint('CENTER', f.Wrapper, 0, -10)
	f.Bar:SetStatusBarTexture('Interface\\AddOns\\xVermin\\Media\\statusbarTexture')
	f.Bar:SetAlpha(0)

	f.Bar.Value = f.Bar:CreateFontString(nil, 'ARTWORK')
	f.Bar.Value:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
	f.Bar.Value:SetShadowOffset(0, 0)
	f.Bar.Value:SetPoint('LEFT', f.Bar, 'LEFT', 2, 10)
	f.Bar.Value:SetVertexColor(1, 1, 1)

	f.Bar.Value2 = f.Bar:CreateFontString(nil, 'ARTWORK')
	f.Bar.Value2:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
	f.Bar.Value2:SetShadowOffset(0, 0)
	f.Bar.Value2:SetPoint('LEFT', f.Bar, 'LEFT', 2, 10)
	f.Bar.Value2:SetVertexColor(1, 1, 1)

	f.Bar.FactionName = f.Bar:CreateFontString(nil, 'ARTWORK')
	f.Bar.FactionName:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
	f.Bar.FactionName:SetShadowOffset(0, 0)
	f.Bar.FactionName:SetPoint('RIGHT', f.Bar, 'RIGHT', -2, 10)
	f.Bar.FactionName:SetVertexColor(1, 1, 1)
	f.Bar.FactionName:SetWordWrap()
	f.Bar.FactionName:SetJustifyH('RIGHT')
	f.Bar.FactionName:SetWidth(size / scale)

	f.Bar.FactionName2 = f.Bar:CreateFontString(nil, 'ARTWORK')
	f.Bar.FactionName2:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
	f.Bar.FactionName2:SetShadowOffset(0, 0)
	f.Bar.FactionName2:SetPoint('RIGHT', f.Bar, 'RIGHT', -2, 10)
	f.Bar.FactionName2:SetVertexColor(1, 1, 1)

	f.Bar.Standing = f.Bar:CreateFontString(nil, 'ARTWORK')
	f.Bar.Standing:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
	f.Bar.Standing:SetShadowOffset(0, 0)
	f.Bar.Standing:SetPoint('LEFT', f.Bar, 'LEFT', 2, -10)
	f.Bar.Standing:SetVertexColor(1, 1, 1)

	f.Bar.Background = f.Bar:CreateTexture(nil, 'BACKGROUND')
	f.Bar.Background:SetAllPoints(f.Bar)
	f.Bar.Background:SetTexture('Interface\\AddOns\\xVermin\\Media\\statusbarTexture')
	f.Bar.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

	f.Bar.BackgroundShadow = CreateFrame('Frame', nil, f.Bar, BackdropTemplateMixin and 'BackdropTemplate')
	f.Bar.BackgroundShadow:SetFrameStrata('BACKGROUND')
	f.Bar.BackgroundShadow:SetPoint('TOPLEFT', -4, 4)
	f.Bar.BackgroundShadow:SetPoint('BOTTOMRIGHT', 4, -4)
	f.Bar.BackgroundShadow:SetBackdrop(
		{
			BgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
			edgeFile = 'Interface\\AddOns\\xVermin\\Media\\textureGlow',
			edgeSize = 4,
			insets = {left = 3, right = 3, top = 3, bottom = 3}
		}
	)
	f.Bar.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
	f.Bar.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)

	f.Bar.Below = f.Bar:CreateTexture(nil, 'BACKGROUND')
	f.Bar.Below:SetHeight(14)
	f.Bar.Below:SetWidth(14)
	f.Bar.Below:SetTexture('Interface\\AddOns\\xVermin\\Media\\textureArrowBelow')

	f.Bar.Above = f.Bar:CreateTexture(nil, 'BACKGROUND')
	f.Bar.Above:SetHeight(14)
	f.Bar.Above:SetWidth(14)
	f.Bar.Above:SetTexture('Interface\\AddOns\\xVermin\\Media\\textureArrowAbove')
	f.Bar.Above:SetPoint('BOTTOM', f.Bar.Below, 'TOP', 0, f.Bar:GetHeight())
end

local function UpdateBarPosition()
	local anchor
	for key, value in pairs(bars) do
		if not value.hidden then
			if value.isWatched then
				anchor = _G[value.frameStatusBar .. '_wrap']
				if _G['PlayerXPFrameStatusBar'] and _G['PlayerXPFrameStatusBar']:GetAlpha() > 0 then
					_G[value.frameStatusBar .. '_wrap']:ClearAllPoints()
					if pet then
						_G[value.frameStatusBar .. '_wrap']:SetPoint('BOTTOM', PetXPFrameStatusBar, 'TOP', 0, 30)
					else
						_G[value.frameStatusBar .. '_wrap']:SetPoint('BOTTOM', PlayerXPFrameStatusBar, 'TOP', 0, 30)
					end
				else
					_G[value.frameStatusBar .. '_wrap']:SetPoint('BOTTOMLEFT', ChatFrame1, 'BOTTOMRIGHT', 5, 0)
				end
			end
		end
	end

	local counter = 1
	for key, value in pairs(bars) do
		if not value.hidden then
			if not value.isWatched then
				_G[value.frameStatusBar .. '_wrap']:ClearAllPoints()
				if anchor then
					_G[value.frameStatusBar .. '_wrap']:SetPoint('BOTTOM', anchor, 'TOP', 0, 30 * counter)
				else
					if _G['PlayerXPFrameStatusBar'] and _G['PlayerXPFrameStatusBar']:GetAlpha() > 0 then
						if pet then
							_G[value.frameStatusBar .. '_wrap']:SetPoint('BOTTOM', PetXPFrameStatusBar, 'TOP', 0, 30 * counter)
						else
							_G[value.frameStatusBar .. '_wrap']:SetPoint('BOTTOM', PlayerXPFrameStatusBar, 'TOP', 0, 30 * counter)
						end
					else
						_G[value.frameStatusBar .. '_wrap']:SetPoint('BOTTOMLEFT', ChatFrame1, 'BOTTOMRIGHT', 5, 30 * (counter - 1))
					end
				end
				counter = counter + 1
			end
		end
	end
end

local function UpdateBarVisibility()
end

local function UpdateBarValueAndColor()
	for key, value in pairs(bars) do
		if not value.hidden then
			if value.FactionInfo.earnedValue < 0 then
				standing = 'UNFRIENDLY'
				color = {r = 238 / 255, g = 102 / 255, b = 34 / 255}
				standingValue = 3000 + value.FactionInfo.earnedValue
				topValue = 3000
			end

			if value.FactionInfo.earnedValue < -3000 then
				standing = 'HOSTILE'
				color = {r = 255 / 255, g = 0 / 255, b = 0 / 255}
				standingValue = 6000 + value.FactionInfo.earnedValue
				topValue = 3000
			end

			if value.FactionInfo.earnedValue < -6000 then
				standing = 'HATED'
				color = {r = 255 / 255, g = 0 / 255, b = 0 / 255}
				standingValue = 42000 + value.FactionInfo.earnedValue
				topValue = 36000
			end

			if value.FactionInfo.earnedValue >= 0 then
				standing = 'NEUTRAL'
				color = {r = 255 / 255, g = 255 / 255, b = 0 / 255}
				standingValue = value.FactionInfo.earnedValue
				topValue = 3000
			end

			if value.FactionInfo.earnedValue > 3000 then
				standing = 'FRIENDLY'
				color = {r = 0 / 255, g = 255 / 255, b = 0 / 255}
				standingValue = value.FactionInfo.earnedValue - 3000
				topValue = 6000
			end

			if value.FactionInfo.earnedValue > 9000 then
				standing = 'HONORED'
				color = {r = 0 / 255, g = 255 / 255, b = 136 / 255}
				standingValue = value.FactionInfo.earnedValue - 9000
				topValue = 12000
			end

			if value.FactionInfo.earnedValue > 21000 then
				standing = 'REVERED'
				color = {r = 0 / 255, g = 255 / 255, b = 204 / 255}
				standingValue = value.FactionInfo.earnedValue - 21000
				topValue = 21000
			end

			if value.FactionInfo.earnedValue > 42000 then
				standing = 'EXALTED'
				color = {r = 0 / 255, g = 255 / 255, b = 255 / 255}
				standingValue = value.FactionInfo.earnedValue - 42000
				topValue = 999
			end

			_G[value.frameStatusBar]:SetMinMaxValues(0, topValue)
			_G[value.frameStatusBar]:SetValue(standingValue)
			_G[value.frameStatusBar]:SetStatusBarColor(color.r, color.g, color.b, 1)
			_G[value.frameStatusBar].Value:SetText(standingValue .. '/' .. topValue)
			_G[value.frameStatusBar].FactionName:SetText(value.FactionInfo.name)
			_G[value.frameStatusBar].Value2:SetText(xVermin:Round(standingValue / topValue * 100) .. '%')
			_G[value.frameStatusBar].FactionName2:SetText(standing)

			_G[value.frameStatusBar].Value:Show()
			_G[value.frameStatusBar].Value2:Hide()
			_G[value.frameStatusBar].FactionName:Show()
			_G[value.frameStatusBar].FactionName2:Hide()

			_G[value.frameStatusBar .. '_wrap']:SetFrameStrata('HIGH')
			_G[value.frameStatusBar .. '_wrap']:SetScript(
				'OnEnter',
				function()
					_G[value.frameStatusBar].Value:Hide()
					_G[value.frameStatusBar].Value2:Show()
					_G[value.frameStatusBar].FactionName:Hide()
					_G[value.frameStatusBar].FactionName2:Show()
				end
			)

			_G[value.frameStatusBar .. '_wrap']:SetScript(
				'OnLeave',
				function()
					_G[value.frameStatusBar].Value:Show()
					_G[value.frameStatusBar].Value2:Hide()
					_G[value.frameStatusBar].FactionName:Show()
					_G[value.frameStatusBar].FactionName2:Hide()
				end
			)
		end
	end
end

local function UpdateBars(self, event)
	local factionIndex = 1

	local numFactions = GetNumFactions()
	while factionIndex <= numFactions do
		local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus =
			GetFactionInfo(factionIndex)

		if isHeader and isCollapsed then
			ExpandFactionHeader(factionIndex)
			numFactions = GetNumFactions()
		end

		if hasRep or not isHeader then
			if not bars[name] then
				bars[name] = {
					factionIndex = factionIndex,
					frameStatusBar = 'XVRB' .. factionIndex,
					hidden = true,
					barCreated = false,
					timer = false,
					FactionInfo = {}
				}
			end

			bars[name].isWatched = isWatched
			bars[name].FactionInfo.name = name
			bars[name].FactionInfo.earnedValue_old = bars[name].FactionInfo.earnedValue and bars[name].FactionInfo.earnedValue or earnedValue
			bars[name].FactionInfo.earnedValue = earnedValue
			bars[name].FactionInfo.topValue = topValue

			if _G[bars[name].frameStatusBar .. '_wrap'] then
				_G[bars[name].frameStatusBar .. '_wrap']:SetScript('OnEnter', nil)
				_G[bars[name].frameStatusBar .. '_wrap']:SetScript('OnLeave', nil)
				_G[bars[name].frameStatusBar .. '_wrap']:SetFrameStrata('BACKGROUND')
			end

			if not bars[name].isWatched then
				if bars[name].FactionInfo.earnedValue_old ~= bars[name].FactionInfo.earnedValue then
					if not bars[name].barCreated then
						CreateBar(bars[name])
						bars[name].barCreated = true
					end

					if bars[name].hidden then
						C_Timer.After(
							1,
							function()
								securecall('UIFrameFadeIn', _G[bars[name].frameStatusBar], 1, 0, 0.8)
							end
						)
						bars[name].hidden = false
					end

					if bars[name].timer then
						bars[name].timer:Cancel()
						bars[name].timer = false
					end

					bars[name].timer =
						C_Timer.NewTimer(
						30,
						function()
							securecall('UIFrameFadeOut', _G[bars[name].frameStatusBar], 1, 0.8, 0)
							bars[name].hidden = true
							bars[name].timer = false
							_G[bars[name].frameStatusBar].fadeInfo.finishedFunc = UpdateBarPosition
						end
					)
				end

				if not bars[name].timer and not bars[name].hidden then
					securecall('UIFrameFadeOut', _G[bars[name].frameStatusBar], 1, 0.8, 0)
					bars[name].hidden = true
				end
			end

			if bars[name].isWatched then
				if bars[name].hidden then
					bars[name].hidden = false
					if not bars[name].barCreated then
						CreateBar(bars[name])
						bars[name].barCreated = true
					end
					securecall('UIFrameFadeIn', _G[bars[name].frameStatusBar], 1, 0, 0.8)
				end
				if bars[name].timer then
					bars[name].timer:Cancel()
					bars[name].timer = false
				end
			end
		end
		factionIndex = factionIndex + 1
	end

	UpdateBarValueAndColor()
	UpdateBarPosition()
end

if _G['PetXPFrameStatusBar'] then
	PetFrame:HookScript(
		'OnShow',
		function()
			pet = true
			UpdateBarPosition()
		end
	)
	PetFrame:HookScript(
		'OnHide',
		function()
			pet = false
			UpdateBarPosition()
		end
	)
end

local wf = CreateFrame('Frame')
wf:RegisterEvent('UPDATE_FACTION')
wf:SetScript('OnEvent', UpdateBars)
