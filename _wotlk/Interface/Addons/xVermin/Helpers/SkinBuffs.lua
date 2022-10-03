local _, xVermin = ...

local ReplacedDebuffTypeColor = {}
ReplacedDebuffTypeColor['none'] = {r = 0.80, g = 0, b = 0}
ReplacedDebuffTypeColor['Magic'] = {r = 0.20, g = 0.60, b = 1.00}
ReplacedDebuffTypeColor['Curse'] = {r = 0.60, g = 0.00, b = 1.00}
ReplacedDebuffTypeColor['Disease'] = {r = 0.60, g = 0.40, b = 0}
ReplacedDebuffTypeColor['Poison'] = {r = 0.00, g = 0.60, b = 0}
ReplacedDebuffTypeColor[''] = ReplacedDebuffTypeColor['none']
local count = 0

local frame, frameBorder, frameCount, color, B_spellId, D_spellId, B_unitCaster, D_unitCaster, petName, targetName, hasPet, isHunterPet
local frameCooldown, B_spellName, D_spellName

local function SkinTarget()
	if TargetFrame:IsShown() then
		hasPet, isHunterPet = HasPetUI()
		if hasPet then
			petName = UnitName('pet')
			targetName = UnitName('target')
		end

		for i = 1, 32 do
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

			-- if UnitIsPlayer("target") or (petName ~= nil and targetName ~= nil and targetName == petName) then
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
				-- frame:SetScale(xVermin.Config.buff.scale)
				frame:SetSize(28, 28)
			end
			-- else
			-- 	if frame then
			-- 		frame:Hide()
			-- 	end
			-- end

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

			-- if D_unitCaster == "player" or UnitName("target") == UnitName("player") then
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
				-- frame:SetScale(xVermin.Config.buff.scale)
				frame:SetSize(28, 28)
			end
			-- else
			-- if frame then
			-- frame:Hide()
			-- end
			-- end
		end
	end
end

local function SkinPet()
	if PetFrame:IsShown() then
		for i = 1, 32 do
			if _G['PetFrameBuff' .. i] then
				_G['PetFrameBuff' .. i]:Hide()
			end
			if _G['PetFrameDebuff' .. i] then
				_G['PetFrameDebuff' .. i]:Hide()
			end
		end

	-- for i = 1, 32 do
	-- 	B_spellName, B_spellId, _, _, _, _, B_unitCaster = UnitBuff('pet', i)
	-- 	D_spellName, D_spellId, _, _, _, _, D_unitCaster = UnitDebuff('pet', i)

	-- 	------------------------------------------------------------------------------------------------------------------------------------------------------
	-- 	-- BUFFS ---------------------------------------------------------------------------------------------------------------------------------------------
	-- 	------------------------------------------------------------------------------------------------------------------------------------------------------
	-- 	frame = _G['PetFrameBuff' .. i]
	-- 	frameBorder = _G['PetFrameBuff' .. i .. 'Border']
	-- 	frameCount = _G['PetFrameBuff' .. i .. 'Count']
	-- 	frameCooldown = _G['PetFrameBuff' .. i .. 'Cooldown']
	-- 	if frameCooldown then
	-- 		frameCooldown:SetSwipeTexture('', 0, 0, 0, 0)
	-- 	end

	-- 	if frameBorder then
	-- 		frameBorder:Hide()
	-- 	end

	-- 	if frameCount then
	-- 		frameCount:SetFont(xVermin.Config.font.atari, xVermin.Config.petbuff.fontsize, xVermin.Config.petbuff.outline)
	-- 		frameCount:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 0, 2)
	-- 	end

	-- 	if frame then
	-- 		frame:CreateBeautyBorder(xVermin.Config.petbuff.bordersize)
	-- 		frame:SetBeautyBorderTexture(xVermin.Config.border.default)
	-- 		frame:SetSize(21, 21)
	-- 	end

	-- 	------------------------------------------------------------------------------------------------------------------------------------------------------
	-- 	-- DEBUFFS -------------------------------------------------------------------------------------------------------------------------------------------
	-- 	------------------------------------------------------------------------------------------------------------------------------------------------------
	-- 	frame = _G['PetFrameDebuff' .. i]
	-- 	frameBorder = _G['PetFrameDebuff' .. i .. 'Border']
	-- 	frameCount = _G['PetFrameDebuff' .. i .. 'Count']
	-- 	frameCooldown = _G['PetFrameDebuff' .. i .. 'Cooldown']
	-- 	if frameCooldown then
	-- 		frameCooldown:SetSwipeTexture('', 0, 0, 0, 0)
	-- 	end

	-- 	if frameBorder then
	-- 		frameBorder:Hide()
	-- 	end

	-- 	if frameCount then
	-- 		frameCount:SetFont(xVermin.Config.font.atari, xVermin.Config.petdebuff.fontsize, xVermin.Config.petdebuff.outline)
	-- 		frameCount:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 0, 2)
	-- 	end

	-- 	if select(4, UnitDebuff('pet', i)) then
	-- 		color = xVermin.Config.ReplacedDebuffTypeColor[select(4, UnitDebuff('target', i))]
	-- 	else
	-- 		color = xVermin.Config.ReplacedDebuffTypeColor['none']
	-- 	end

	-- 	if frame then
	-- 		frame:CreateBeautyBorder(xVermin.Config.petdebuff.bordersize)
	-- 		frame:SetBeautyBorderTexture(xVermin.Config.border.colorize)
	-- 		frame:SetBeautyBorderColor(color.r, color.g, color.b)
	-- 		frame:SetSize(21, 21)
	-- 	end
	-- end
	end
end

local function SkinFocus()
	if FocusFrame:IsShown() then
		hasPet, isHunterPet = HasPetUI()
		if hasPet then
			petName = UnitName('pet')
			focusName = UnitName('focus')
		end

		for i = 1, 32 do
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
				-- frame:SetScale(xVermin.Config.buff.scale)
				frame:SetSize(28, 28)
			end
			-- else
			-- 	if frame then
			-- 		frame:Hide()
			-- 	end
			-- end

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

			-- if D_unitCaster == "player" or UnitName("focus") == UnitName("player") then
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
				-- frame:SetScale(xVermin.Config.buff.scale)
				frame:SetSize(28, 28)
			end
			-- else
			-- if frame then
			-- frame:Hide()
			-- end
			-- end
		end
	end
end

local tf = CreateFrame('Frame')
-- tf:RegisterEvent('PLAYER_ENTERING_WORLD')
-- tf:RegisterEvent('PLAYER_TARGET_CHANGED')
-- tf:RegisterEvent('UNIT_AURA', 'target')
-- tf:SetScript('OnEvent', SkinTarget)
TargetFrame:HookScript('OnUpdate', SkinTarget)
-- hooksecurefunc('TargetFrame_UpdateAuras', SkinTarget)

local ff = CreateFrame('Frame')
-- ff:RegisterEvent('PLAYER_ENTERING_WORLD')
-- ff:RegisterEvent('PLAYER_FOCUS_CHANGED')
-- ff:RegisterEvent('UNIT_AURA', 'focus')
-- ff:SetScript('OnEvent', SkinFocus)
FocusFrame:HookScript('OnUpdate', SkinFocus)
-- hooksecurefunc("FocusFrame_UpdateAuras", SkinFocus)

local pf = CreateFrame('Frame')
-- pf:RegisterUnitEvent('PLAYER_ENTERING_WORLD')
-- pf:RegisterUnitEvent('UNIT_AURA', 'pet')
-- pf:SetScript(
-- 	'OnEvent',
-- 	function(self, event, ...)
-- 		xVermin:CheckIfLoadedWithTimer(
-- 			'PetFrame',
-- 			function()
-- 				SkinPet()
-- 			end
-- 		)
-- 	end
-- )
PetFrame:HookScript('OnUpdate', SkinPet)

TargetFrameToT:HookScript(
	'OnShow',
	function()
		for i = 1, 32 do
			if _G['TargetFrameToTBuff' .. i] then
				_G['TargetFrameToTBuff' .. i]:Hide()
			end
			if _G['TargetFrameToTDebuff' .. i] then
				_G['TargetFrameToTDebuff' .. i]:Hide()
			end
		end
	end
)

FocusFrameToT:HookScript(
	'OnShow',
	function()
		for i = 1, 32 do
			if _G['FocusFrameToTBuff' .. i] then
				_G['FocusFrameToTBuff' .. i]:Hide()
			end
			if _G['FocusFrameToTDebuff' .. i] then
				_G['FocusFrameToTDebuff' .. i]:Hide()
			end
		end
	end
)

-- hooksecurefunc(
-- 	TargetFrameToT,
-- 	'Hide',
-- 	function(self)
-- 		self:Show()
-- 	end
-- )
-- hooksecurefunc(
-- 	FocusFrameToT,
-- 	'Hide',
-- 	function(self)
-- 		self:Show()
-- 	end
-- )
