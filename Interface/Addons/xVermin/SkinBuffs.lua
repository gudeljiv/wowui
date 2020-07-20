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
		-- print(select(3, UnitBuff("target", 1)))
		local numBuffs = 0
		for i = 1, 32 do
			-- if (select(3, UnitBuff("target", i))) then
			_, spellId, _, _, _, _, unitCaster = UnitBuff("target", i)
			if (spellId) then
				local frame = _G["TargetFrameBuff" .. i]
				local frameBorder = _G["TargetFrameBuff" .. i .. "Border"]
				local frameCount = _G["TargetFrameBuff" .. i .. "Count"]
				-- print(frame:GetName(), i)
				if (frameBorder ~= nil) then
					frameBorder:Hide()
				end

				if (frameCount ~= nil) then
					frameCount:SetFont(config.font.atari, config.buff.fontsize, config.buff.outline)
					frameCount:SetPoint(unpack(config.buff.position))
				end

				if (frame ~= nil) then
					frame:CreateBeautyBorder(config.buff.bordersize)
					frame:SetBeautyBorderTexture(config.border.default)
					frame:SetScale(config.buff.scale)
				end
			end
		end

		local numDebuffs = 0
		for i = 1, 32 do
			-- if (select(3, UnitDebuff("target", i))) then
			_, spellId, _, _, _, _, unitCaster = UnitDebuff("target", i)
			if (spellId) then
				-- print(spellId, unitCaster, UnitDebuff("target", i))
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
					frame:SetBeautyBorderTexture(config.border.colorize)
					frame:SetBeautyBorderColor(color.r, color.g, color.b)
					frame:SetScale(config.buff.scale)
				end
			end
		end
	end
end

local function SkinPet()
	if PetFrame:IsShown() then
		local numBuffs = 0
		for i = 1, 32 do
			-- if (select(3, UnitBuff("pet", i))) then
			_, spellId = UnitBuff("pet", i)
			if (spellId) then
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
					frame:SetBeautyBorderTexture(config.border.default)
				end
			end
		end

		local numDebuffs = 0
		for i = 1, 32 do
			-- if (select(3, UnitDebuff("pet", i))) then
			_, spellId = UnitDebuff("pet", i)
			if (spellId) then
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
					frame:SetBeautyBorderTexture(config.border.colorize)
					frame:SetBeautyBorderColor(color.r, color.g, color.b)
				end
			end
		end
	end
end

hooksecurefunc("TargetFrame_UpdateAuras", SkinTarget)

local pf = CreateFrame("Frame")
pf:RegisterUnitEvent("UNIT_AURA", "pet")
pf:SetScript("OnEvent", SkinPet)

-- local tf = CreateFrame("Frame")
-- tf:RegisterUnitEvent("UNIT_AURA", "target")
-- tf:RegisterEvent("PLAYER_TARGET_CHANGED")
-- tf:SetScript("OnEvent", SkinTarget)
