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

local frame, frameBorder, frameCount, color, B_spellId, D_spellId, B_unitCaster, D_unitCaster

local function SkinTarget(init)
	if TargetFrame:IsShown() and init then
		TargetFrameHealthBarText:ClearAllPoints()
		TargetFrameHealthBarText:SetPoint("CENTER", TargetFrame, "CENTER", -50, 7)
		TargetFrameManaBarText:SetScale(0.8)

		for i = 1, 32 do
			_, B_spellId, _, _, _, _, B_unitCaster = UnitBuff("target", i)
			_, D_spellId, _, _, _, _, D_unitCaster = UnitDebuff("target", i)

			-- if (B_spellId) then
			frame = _G["TargetFrameBuff" .. i]
			frameBorder = _G["TargetFrameBuff" .. i .. "Border"]
			frameCount = _G["TargetFrameBuff" .. i .. "Count"]

			if UnitIsPlayer("target") then
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
			else
				if (frame ~= nil) then
					frame:Hide()
				end
			end
			-- end

			-- if (D_spellId) then
			frame = _G["TargetFrameDebuff" .. i]
			frameBorder = _G["TargetFrameDebuff" .. i .. "Border"]
			frameCount = _G["TargetFrameDebuff" .. i .. "Count"]
			if D_unitCaster == "player" then
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
			else
				if (frame ~= nil) then
					frame:Hide()
				end
			end
			-- end
		end
	end
end

local function SkinPet()
	if PetFrame:IsShown() then
		for i = 1, 32 do
			-- _, B_spellId = UnitBuff("pet", i)
			-- _, D_spellId = UnitDebuff("pet", i)

			-- if (B_spellId) then
			frame = _G["PetFrameBuff" .. i]
			frameBorder = _G["PetFrameBuff" .. i .. "Border"]
			frameCount = _G["PetFrameBuff" .. i .. "Count"]

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
			-- end

			-- if (D_spellId) then
			frame = _G["PetFrameDebuff" .. i]
			frameBorder = _G["PetFrameDebuff" .. i .. "Border"]
			frameCount = _G["PetFrameBuff" .. i .. "Count"]

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
			-- end
		end
	end
end

-- hooksecurefunc("TargetFrame_UpdateAuras", SkinTarget)
TargetFrame:HookScript("OnUpdate", SkinTarget)
SkinTarget(true)

local pf = CreateFrame("Frame")
pf:RegisterUnitEvent("UNIT_AURA", "pet")
pf:SetScript("OnEvent", SkinPet)

-- local tf = CreateFrame("Frame")
-- tf:RegisterUnitEvent("UNIT_AURA", "target")
-- tf:RegisterEvent("PLAYER_TARGET_CHANGED")
-- tf:SetScript("OnEvent", SkinTarget)
