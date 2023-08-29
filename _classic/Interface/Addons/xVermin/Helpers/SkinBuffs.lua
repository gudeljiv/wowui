local _, xVermin = ...

-- local ReplacedDebuffTypeColor = {}
-- ReplacedDebuffTypeColor['none'] = {r = 0.80, g = 0, b = 0}
-- ReplacedDebuffTypeColor['Magic'] = {r = 0.20, g = 0.60, b = 1.00}
-- ReplacedDebuffTypeColor['Curse'] = {r = 0.60, g = 0.00, b = 1.00}
-- ReplacedDebuffTypeColor['Disease'] = {r = 0.60, g = 0.40, b = 0}
-- ReplacedDebuffTypeColor['Poison'] = {r = 0.00, g = 0.60, b = 0}
-- ReplacedDebuffTypeColor[''] = ReplacedDebuffTypeColor['none']

local count = 0
local frame, frameBorder, frameCount, color, B_spellId
local D_spellId, B_unitCaster, D_unitCaster
local frameCooldown, B_spellName, D_spellName
local MaxTargetBuffs = MAX_TARGET_BUFFS

local function SkinTarget(init)
	if init or TargetFrame:IsShown() then
		for i = 1, MaxTargetBuffs do
			B_spellName, B_spellId, _, _, _, _, B_unitCaster = UnitBuff('target', i)
			D_spellName, D_spellId, _, _, _, _, D_unitCaster = UnitDebuff('target', i)

			------------------------------------------------------------------------------------------------------------------------------------------------------
			-- BUFFS ---------------------------------------------------------------------------------------------------------------------------------------------
			------------------------------------------------------------------------------------------------------------------------------------------------------
			frame = _G['TargetFrameBuff' .. i]
			frameBorder = _G['TargetFrameBuff' .. i .. 'Border']
			frameCount = _G['TargetFrameBuff' .. i .. 'Count']
			frameCooldown = _G['TargetFrameBuff' .. i .. 'Cooldown']
			if frameCooldown then
				frameCooldown:SetSwipeTexture('', 0, 0, 0, 0)
			end

			if frameBorder then
				frameBorder:Hide()
			end

			if frameCount then
				frameCount:SetFont(xVermin.Config.font.atari, xVermin.Config.buff.fontsize, xVermin.Config.buff.outline)
				frameCount:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 0, 2)
			end

			if frame then
				frame:CreateBeautyBorder(xVermin.Config.buff.bordersize)
				frame:SetBeautyBorderTexture(xVermin.Config.border.default)

				frame:SetSize(28, 28)
			end

			------------------------------------------------------------------------------------------------------------------------------------------------------
			-- DEBUFFS -------------------------------------------------------------------------------------------------------------------------------------------
			------------------------------------------------------------------------------------------------------------------------------------------------------
			frame = _G['TargetFrameDebuff' .. i]
			frameBorder = _G['TargetFrameDebuff' .. i .. 'Border']
			frameCount = _G['TargetFrameDebuff' .. i .. 'Count']
			frameCooldown = _G['TargetFrameDebuff' .. i .. 'Cooldown']
			if frameCooldown then
				frameCooldown:SetSwipeTexture('', 0, 0, 0, 0)
			end

			if frameBorder then
				frameBorder:Hide()
			end

			if frameCount then
				frameCount:SetFont(xVermin.Config.font.arial, xVermin.Config.debuff.fontsize, xVermin.Config.debuff.outline)
				frameCount:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 3, 0)
			end

			if select(4, UnitDebuff('target', i)) then
				color = xVermin.Config.ReplacedDebuffTypeColor[select(4, UnitDebuff('target', i))]
			else
				color = xVermin.Config.ReplacedDebuffTypeColor['none']
			end

			if frame then
				frame:CreateBeautyBorder(xVermin.Config.debuff.bordersize)
				frame:SetBeautyBorderTexture(xVermin.Config.border.colorize)
				frame:SetBeautyBorderColor(color.r, color.g, color.b)

				frame:SetSize(28, 28)
			end
		end
	end
end

local function SkinPet(init)
	if init or PetFrame:IsShown() then
		for i = 1, MaxTargetBuffs do
			if _G['PetFrameBuff' .. i] then
				_G['PetFrameBuff' .. i]:Hide()
			end
			if _G['PetFrameDebuff' .. i] then
				_G['PetFrameDebuff' .. i]:Hide()
			end
		end
	end
end

local function SkinFocus(init)
	if init or FocusFrame:IsShown() then
		for i = 1, MaxTargetBuffs do
			B_spellName, B_spellId, _, _, _, _, B_unitCaster = UnitBuff('focus', i)
			D_spellName, D_spellId, _, _, _, _, D_unitCaster = UnitDebuff('focus', i)

			------------------------------------------------------------------------------------------------------------------------------------------------------
			-- BUFFS ---------------------------------------------------------------------------------------------------------------------------------------------
			------------------------------------------------------------------------------------------------------------------------------------------------------
			frame = _G['FocusFrameBuff' .. i]
			frameBorder = _G['FocusFrameBuff' .. i .. 'Border']
			frameCount = _G['FocusFrameBuff' .. i .. 'Count']
			frameCooldown = _G['FocusFrameBuff' .. i .. 'Cooldown']
			if frameCooldown then
				frameCooldown:SetSwipeTexture('', 0, 0, 0, 0)
			end

			if frameBorder then
				frameBorder:Hide()
			end

			if frameCount then
				frameCount:SetFont(xVermin.Config.font.atari, xVermin.Config.buff.fontsize, xVermin.Config.buff.outline)
				frameCount:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 0, 2)
			end

			if frame then
				frame:CreateBeautyBorder(xVermin.Config.buff.bordersize)
				frame:SetBeautyBorderTexture(xVermin.Config.border.default)
				frame:SetSize(28, 28)
			end

			------------------------------------------------------------------------------------------------------------------------------------------------------
			-- DEBUFFS -------------------------------------------------------------------------------------------------------------------------------------------
			------------------------------------------------------------------------------------------------------------------------------------------------------
			frame = _G['FocusFrameDebuff' .. i]
			frameBorder = _G['FocusFrameDebuff' .. i .. 'Border']
			frameCount = _G['FocusFrameDebuff' .. i .. 'Count']
			frameCooldown = _G['FocusFrameDebuff' .. i .. 'Cooldown']
			if frameCooldown then
				frameCooldown:SetSwipeTexture('', 0, 0, 0, 0)
			end

			if frameBorder then
				frameBorder:Hide()
			end

			if frameCount then
				frameCount:SetFont(xVermin.Config.font.arial, xVermin.Config.debuff.fontsize, xVermin.Config.debuff.outline)
				frameCount:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 3, 0)
			end

			if select(4, UnitDebuff('focus', i)) then
				color = xVermin.Config.ReplacedDebuffTypeColor[select(4, UnitDebuff('focus', i))]
			else
				color = xVermin.Config.ReplacedDebuffTypeColor['none']
			end

			if frame then
				frame:CreateBeautyBorder(xVermin.Config.debuff.bordersize)
				frame:SetBeautyBorderTexture(xVermin.Config.border.colorize)
				frame:SetBeautyBorderColor(color.r, color.g, color.b)
				frame:SetSize(28, 28)
			end
		end
	end
end

hooksecurefunc('TargetFrame_UpdateAuras', SkinTarget)
-- TargetFrame:HookScript('OnUpdate', SkinTarget)
-- FocusFrame:HookScript('OnUpdate', SkinFocus)
PetFrame:HookScript('OnUpdate', SkinPet)
SkinTarget(true)
-- SkinFocus(true)
SkinPet(true)
