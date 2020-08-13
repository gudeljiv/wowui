local _, xVermin = ...

local ReplacedDebuffTypeColor = {}
ReplacedDebuffTypeColor["none"] = {r = 0.80, g = 0, b = 0}
ReplacedDebuffTypeColor["Magic"] = {r = 0.20, g = 0.60, b = 1.00}
ReplacedDebuffTypeColor["Curse"] = {r = 0.60, g = 0.00, b = 1.00}
ReplacedDebuffTypeColor["Disease"] = {r = 0.60, g = 0.40, b = 0}
ReplacedDebuffTypeColor["Poison"] = {r = 0.00, g = 0.60, b = 0}
ReplacedDebuffTypeColor[""] = ReplacedDebuffTypeColor["none"]

local frame, frameBorder, frameCount, color, B_spellId, D_spellId, B_unitCaster, D_unitCaster, petName, targetName, hasPet, isHunterPet

local function SkinTarget()
	if TargetFrame:IsShown() then
		hasPet, isHunterPet = HasPetUI()
		if hasPet then
			petName = UnitName("pet")
			targetName = UnitName("target")
		end

		for i = 1, 32 do
			B_spellName, B_spellId, _, _, _, _, B_unitCaster = UnitBuff("target", i)
			D_spellName, D_spellId, _, _, _, _, D_unitCaster = UnitDebuff("target", i)

			------------------------------------------------------------------------------------------------------------------------------------------------------
			-- BUFFS ---------------------------------------------------------------------------------------------------------------------------------------------
			------------------------------------------------------------------------------------------------------------------------------------------------------
			frame = _G["TargetFrameBuff" .. i]
			frameBorder = _G["TargetFrameBuff" .. i .. "Border"]
			frameCount = _G["TargetFrameBuff" .. i .. "Count"]

			if UnitIsPlayer("target") or (petName ~= nil and targetName ~= nil and targetName == petName) then
				if frameBorder then
					frameBorder:Hide()
				end

				if frameCount then
					frameCount:SetFont(xVermin.Config.font.atari, xVermin.Config.buff.fontsize - 1, xVermin.Config.buff.outline)
					frameCount:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 2)
				end

				if frame then
					frame:CreateBeautyBorder(xVermin.Config.buff.bordersize)
					frame:SetBeautyBorderTexture(xVermin.Config.border.default)
					frame:SetScale(xVermin.Config.buff.scale)
				end
			else
				if frame then
					frame:Hide()
				end
			end

			------------------------------------------------------------------------------------------------------------------------------------------------------
			-- DEBUFFS -------------------------------------------------------------------------------------------------------------------------------------------
			------------------------------------------------------------------------------------------------------------------------------------------------------
			frame = _G["TargetFrameDebuff" .. i]
			frameBorder = _G["TargetFrameDebuff" .. i .. "Border"]
			frameCount = _G["TargetFrameDebuff" .. i .. "Count"]

			if D_unitCaster == "player" then
				if frameBorder then
					frameBorder:Hide()
				end

				if frameCount then
					frameCount:SetFont(xVermin.Config.font.arial, xVermin.Config.debuff.fontsize - 1, xVermin.Config.debuff.outline)
					frameCount:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 3, 0)
				end

				if select(4, UnitDebuff("target", i)) then
					color = xVermin.Config.ReplacedDebuffTypeColor[select(4, UnitDebuff("target", i))]
				else
					color = xVermin.Config.ReplacedDebuffTypeColor["none"]
				end

				if frame then
					frame:CreateBeautyBorder(xVermin.Config.debuff.bordersize)
					frame:SetBeautyBorderTexture(xVermin.Config.border.colorize)
					frame:SetBeautyBorderColor(color.r, color.g, color.b)
					frame:SetScale(xVermin.Config.buff.scale)
				end
			else
				if frame then
				-- frame:Hide()
				end
			end
		end
	end
end

local function SkinPet()
	if PetFrame:IsShown() then
		for i = 1, 32 do
			B_spellName, B_spellId, _, _, _, _, B_unitCaster = UnitBuff("pet", i)
			D_spellName, D_spellId, _, _, _, _, D_unitCaster = UnitDebuff("pet", i)

			------------------------------------------------------------------------------------------------------------------------------------------------------
			-- BUFFS ---------------------------------------------------------------------------------------------------------------------------------------------
			------------------------------------------------------------------------------------------------------------------------------------------------------
			frame = _G["PetFrameBuff" .. i]
			frameBorder = _G["PetFrameBuff" .. i .. "Border"]
			frameCount = _G["PetFrameBuff" .. i .. "Count"]

			if frameBorder then
				frameBorder:Hide()
			end

			if frameCount then
				frameCount:SetFont(xVermin.Config.font.atari, xVermin.Config.petbuff.fontsize, xVermin.Config.petbuff.outline)
				frameCount:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 2)
			end

			if frame then
				frame:CreateBeautyBorder(xVermin.Config.petbuff.bordersize)
				frame:SetBeautyBorderTexture(xVermin.Config.border.default)
			end

			------------------------------------------------------------------------------------------------------------------------------------------------------
			-- DEBUFFS -------------------------------------------------------------------------------------------------------------------------------------------
			------------------------------------------------------------------------------------------------------------------------------------------------------
			frame = _G["PetFrameDebuff" .. i]
			frameBorder = _G["PetFrameDebuff" .. i .. "Border"]
			frameCount = _G["PetFrameBuff" .. i .. "Count"]

			if frameBorder then
				frameBorder:Hide()
			end

			if frameCount then
				frameCount:SetFont(xVermin.Config.font.atari, xVermin.Config.petdebuff.fontsize, xVermin.Config.petdebuff.outline)
				frameCount:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 2)
			end

			if select(4, UnitDebuff("pet", i)) then
				color = xVermin.Config.ReplacedDebuffTypeColor[select(4, UnitDebuff("target", i))]
			else
				color = xVermin.Config.ReplacedDebuffTypeColor["none"]
			end

			if frame then
				frame:CreateBeautyBorder(xVermin.Config.petdebuff.bordersize)
				frame:SetBeautyBorderTexture(xVermin.Config.border.colorize)
				frame:SetBeautyBorderColor(color.r, color.g, color.b)
			end
		end
	end
end

local tf = CreateFrame("Frame")
tf:RegisterEvent("PLAYER_TARGET_CHANGED")
tf:SetScript("OnEvent", SkinTarget)
TargetFrame:HookScript("OnUpdate", SkinTarget)
hooksecurefunc("TargetFrame_UpdateAuras", SkinTarget)

local pf = CreateFrame("Frame")
pf:RegisterUnitEvent("UNIT_AURA", "pet")
pf:SetScript("OnEvent", SkinPet)
PetFrame:HookScript("OnUpdate", SkinPet)
