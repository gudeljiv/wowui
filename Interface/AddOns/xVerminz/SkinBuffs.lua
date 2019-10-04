
-------------------------------------------
-- ADD BORDER TO BUFFS AND DEBUFFS ON TARGET FRAME
-------------------------------------------

DebuffTypeColor = { };
DebuffTypeColor["none"]		= { r = 0.80, g = 0, b = 0 };
DebuffTypeColor["Magic"]	= { r = 0.20, g = 0.60, b = 1.00 };
DebuffTypeColor["Curse"]	= { r = 0.60, g = 0.00, b = 1.00 };
DebuffTypeColor["Disease"]	= { r = 0.60, g = 0.40, b = 0 };
DebuffTypeColor["Poison"]	= { r = 0.00, g = 0.60, b = 0 };
DebuffTypeColor[""]			= DebuffTypeColor["none"];

borderBuff = "Interface\\AddOns\\xVerminz\\media\\textureOverlay"
borderDebuff = "Interface\\AddOns\\xVerminz\\media\\textureDebuff"
font = "Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf"

local function SkinTarget()
	if TargetFrame:IsShown() then
		numBuffs = 0
		for i=1, MAX_TARGET_BUFFS do
			if( select(3, UnitBuff("target", i)) ) then
				numBuffs = numBuffs + 1
			end
		end

		numDebuffs = 0
		for i=1, MAX_TARGET_DEBUFFS do
			if( select(3, UnitDebuff("target", i)) ) then
				numDebuffs = numDebuffs + 1
			end
		end
		
		for i=1, numBuffs do
			local frame = _G["TargetFrameBuff"..i]
			local frameBorder = _G["TargetFrameBuff"..i.."Border"];
			local frameCount = _G["TargetFrameBuff"..i.."Count"];
			if (frameBorder~=nil) then frameBorder:Hide() end
			
			if (frameCount~=nil) then
				frameCount:SetFont(font, 10, 'THINOUTLINE')
				frameCount:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 2)
			end

			if (frame~=nil) then
				frame:CreateBeautyBorder(6)
				frame:SetBeautyBorderTexture(borderBuff)
				frame:SetScale(1.3);
			end
		end

		for i=1, numDebuffs do
			local frame = _G["TargetFrameDebuff"..i]
			local frameBorder = _G["TargetFrameDebuff"..i.."Border"];
			local frameCount = _G["TargetFrameBuff"..i.."Count"];
			if (frameBorder~=nil) then frameBorder:Hide() end
			
			if (frameCount~=nil) then
				frameCount:SetFont(font, 10, 'THINOUTLINE')
				frameCount:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 2)
			end

			if ( select(4, UnitDebuff("target", i)) ) then
				color = DebuffTypeColor[select(4, UnitDebuff("target", i))];
			else
				color = DebuffTypeColor["none"];
			end

			if (frame~=nil) then
				frame:CreateBeautyBorder(6)
				frame:SetBeautyBorderTexture(borderDebuff)
				frame:SetBeautyBorderColor(color.r, color.g, color.b)
				frame:SetScale(1.3);
			end
		end
	end
end

local function SkinPet()
	if PetFrame:IsShown() then
		numBuffs = 0
		for i=1, MAX_TARGET_BUFFS do
			if( select(3, UnitBuff("pet", i)) ) then
				numBuffs = numBuffs + 1
			end
		end

		numDebuffs = 0
		for i=1, MAX_TARGET_BUFFS do
			if( select(3, UnitDebuff("pet", i)) ) then
				numDebuffs = numDebuffs + 1
			end
		end
		
		for i=1, numBuffs do
			local frame = _G["PetFrameBuff"..i]
			local frameBorder = _G["PetFrameBuff"..i.."Border"];
			local frameCount = _G["PetFrameBuff"..i.."Count"];
			if (frameBorder~=nil) then frameBorder:Hide() end
			
			if (frameCount~=nil) then
				frameCount:SetFont(font, 10, 'THINOUTLINE')
				frameCount:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 2)
			end

			if (frame~=nil) then
				frame:CreateBeautyBorder(4)
				frame:SetBeautyBorderTexture(borderBuff)
			end
		end

		for i=1, numDebuffs do
			local frame = _G["PetFrameDebuff"..i]
			local frameBorder = _G["PetFrameDebuff"..i.."Border"];
			local frameCount = _G["PetFrameBuff"..i.."Count"];
			if (frameBorder~=nil) then frameBorder:Hide() end
			
			if (frameCount~=nil) then
				frameCount:SetFont(font, 10, 'THINOUTLINE')
				frameCount:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 2)
			end

			if ( select(4, UnitDebuff("pet", i)) ) then
				color = DebuffTypeColor[select(4, UnitDebuff("target", i))];
			else
				color = DebuffTypeColor["none"];
			end

			if (frame~=nil) then
				frame:CreateBeautyBorder(4)
				frame:SetBeautyBorderTexture(borderDebuff)
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
hooksecurefunc("PetFrame_UpdateAuras", SkinPet)
