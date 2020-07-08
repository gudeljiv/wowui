-------------------------------------------
-- ADD BORDER TO BUFFS AND DEBUFFS ON TARGET FRAME
-------------------------------------------

local ReplacedDebuffTypeColor = {}
ReplacedDebuffTypeColor["none"] = {r = 0.80, g = 0, b = 0}
ReplacedDebuffTypeColor["Magic"] = {r = 0.20, g = 0.60, b = 1.00}
ReplacedDebuffTypeColor["Curse"] = {r = 0.60, g = 0.00, b = 1.00}
ReplacedDebuffTypeColor["Disease"] = {r = 0.60, g = 0.40, b = 0}
ReplacedDebuffTypeColor["Poison"] = {r = 0.00, g = 0.60, b = 0}
ReplacedDebuffTypeColor[""] = ReplacedDebuffTypeColor["none"]

local function SkinTarget()
	if TargetFrame:IsShown() then
		local numBuffs = 0
		for i = 1, MAX_TARGET_BUFFS do
			if (select(3, UnitBuff("target", i))) then
				numBuffs = numBuffs + 1
			end
		end

		local numDebuffs = 0
		for i = 1, MAX_TARGET_DEBUFFS do
			if (select(3, UnitDebuff("target", i))) then
				numDebuffs = numDebuffs + 1
			end
		end

		for i = 1, numBuffs do
			local frame = _G["TargetFrameBuff" .. i]
			local frameBorder = _G["TargetFrameBuff" .. i .. "Border"]
			local frameCount = _G["TargetFrameBuff" .. i .. "Count"]
			if (frameBorder ~= nil) then
				frameBorder:Hide()
			end

			if (frameCount ~= nil) then
				frameCount:SetFont(config.font.atari, config.buff.fontsize, config.buff.outline)
				frameCount:SetPoint(unpack(config.buff.position))
			end

			if (frame ~= nil) then
				frame:CreateBeautyBorder(config.buff.bordersize)
				frame:SetBeautyBorderTexture(config.border.buff)
				frame:SetScale(config.buff.scale)
			end
		end

		for i = 1, numDebuffs do
			local frame = _G["TargetFrameDebuff" .. i]
			local frameBorder = _G["TargetFrameDebuff" .. i .. "Border"]
			local frameCount = _G["TargetFrameDebuff" .. i .. "Count"]
			local color

			if (frameBorder ~= nil) then
				frameBorder:Hide()
			end

			if (frameCount ~= nil) then
				frameCount:SetFont(config.font.atari, config.debuff.fontsize, config.debuff.outline)
				frameCount:SetPoint(unpack(config.debuff.position))
			end

			if (select(4, UnitDebuff("target", i))) then
				color = config.ReplacedDebuffTypeColor[select(4, UnitDebuff("target", i))]
			else
				color = config.ReplacedDebuffTypeColor["none"]
			end

			if (frame ~= nil) then
				frame:CreateBeautyBorder(config.debuff.bordersize)
				frame:SetBeautyBorderTexture(config.border.debuff)
				frame:SetBeautyBorderColor(color.r, color.g, color.b)
				frame:SetScale(config.buff.scale)
			end
		end
	end
end

local function SkinPet()
	if PetFrame:IsShown() then
		local numBuffs = 0
		for i = 1, MAX_TARGET_BUFFS do
			if (select(3, UnitBuff("pet", i))) then
				numBuffs = numBuffs + 1
			end
		end

		local numDebuffs = 0
		for i = 1, MAX_TARGET_BUFFS do
			if (select(3, UnitDebuff("pet", i))) then
				numDebuffs = numDebuffs + 1
			end
		end

		for i = 1, numBuffs do
			local frame = _G["PetFrameBuff" .. i]
			local frameBorder = _G["PetFrameBuff" .. i .. "Border"]
			local frameCount = _G["PetFrameBuff" .. i .. "Count"]
			if (frameBorder ~= nil) then
				frameBorder:Hide()
			end

			if (frameCount ~= nil) then
				frameCount:SetFont(config.font.atari, config.petbuff.fontsize, config.petbuff.outline)
				frameCount:SetPoint(unpack(config.petbuff.position))
			end

			if (frame ~= nil) then
				frame:CreateBeautyBorder(config.petbuff.bordersize)
				frame:SetBeautyBorderTexture(config.border.buff)
			end
		end

		for i = 1, numDebuffs do
			local frame = _G["PetFrameDebuff" .. i]
			local frameBorder = _G["PetFrameDebuff" .. i .. "Border"]
			local frameCount = _G["PetFrameBuff" .. i .. "Count"]
			local color

			if (frameBorder ~= nil) then
				frameBorder:Hide()
			end

			if (frameCount ~= nil) then
				frameCount:SetFont(config.font.atari, config.petdebuff.fontsize, config.petdebuff.outline)
				frameCount:SetPoint(unpack(config.petdebuff.position))
			end

			if (select(4, UnitDebuff("pet", i))) then
				color = config.ReplacedDebuffTypeColor[select(4, UnitDebuff("target", i))]
			else
				color = config.ReplacedDebuffTypeColor["none"]
			end

			if (frame ~= nil) then
				frame:CreateBeautyBorder(config.petdebuff.bordersize)
				frame:SetBeautyBorderTexture(config.border.debuff)
				frame:SetBeautyBorderColor(color.r, color.g, color.b)
			end
		end
	end
end

local function SkinFocus()
	-- if FocusFrame:IsShown() then
	-- 	numDebuffs = 0
	-- 	for i=1, MAX_FOCUS_DEBUFFS do
	-- 		if( select(3, UnitDebuff("focus", i)) ) then
	-- 			numDebuffs = numDebuffs + 1
	-- 		end
	-- 	end
	-- 	for i=1, numDebuffs do
	-- 		local frame = _G["FocusFrameDebuff"..i]
	-- 		-- frame:Hide()
	-- 		frame:SetScale(1.2);
	-- 		frame:CreateBeautyBorder(4)
	--   	end
	-- end
end

-- hooksecurefunc(TargetFrame, "Update", SkinTarget)

-- hooksecurefunc("TargetFrame_Update", SkinTarget)
-- hooksecurefunc("PetFrame_Update", SkinPet)
-- hooksecurefunc("FloatingChatFrame_UpdateBackgroundAnchors", UpdateBackgroundAnchors)
-- TargetFrame:HookScript("OnUpdate", SkinTarget)
-- PetFrame:HookScript("OnUpdate", SkinPet)
hooksecurefunc("TargetFrame_UpdateAuras", SkinTarget)
hooksecurefunc("PlayerFrame_Update", SkinPet)

-- CompactRaidFrame1Buff1
