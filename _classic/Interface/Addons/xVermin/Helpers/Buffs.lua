
local _, xVermin = ...

local shift = -38

if xVermin.Class == "DRUID" then

	xVermin.CheckIfLoadedWithTimer(
		'SUFUnitplayer',
		function()

			local motw = CreateFrame("Button", "buffbutton_motw", UIParent, "SecureActionButtonTemplate,ActionButtonTemplate");
			motw:SetAttribute("type1", "macro");
			motw:SetAttribute("macrotext1", "/cast Mark of the Wild");
			motw:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", 0, 120)
			motw:CreateBeautyBorder(4)
			motw:SetSize(36,36)
			motw:RegisterForClicks("AnyUp")
			motw.texture = motw:CreateTexture(nil, 'BACKGROUND')
			motw.texture:SetSize(motw:GetSize())
			motw.texture:SetPoint('CENTER')
			motw.texture:SetTexture(GetSpellTexture(6756))

			local thorns = CreateFrame("Button", "buffbutton_thorns", UIParent, "SecureActionButtonTemplate,ActionButtonTemplate");
			thorns:SetAttribute("type1", "macro");
			thorns:SetAttribute("macrotext1", "/cast Thorns");
			thorns:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", -38, 120)
			thorns:CreateBeautyBorder(4)
			thorns:SetSize(36,36)
			thorns:RegisterForClicks("AnyUp")
			thorns.texture = thorns:CreateTexture(nil, 'BACKGROUND')
			thorns.texture:SetSize(thorns:GetSize())
			thorns.texture:SetPoint('CENTER')
			thorns.texture:SetTexture(GetSpellTexture(1075))

			local omen = CreateFrame("Button", "buffbutton_omen", UIParent, "SecureActionButtonTemplate,ActionButtonTemplate");
			omen:SetAttribute("type1", "macro");
			omen:SetAttribute("macrotext1", "/cast Omen Of Clarity");
			omen:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", -76, 120)
			omen:CreateBeautyBorder(4)
			omen:SetSize(36,36)
			omen:RegisterForClicks("AnyUp")
			omen.texture = omen:CreateTexture(nil, 'BACKGROUND')
			omen.texture:SetSize(omen:GetSize())
			omen.texture:SetPoint('CENTER')
			omen.texture:SetTexture(GetSpellTexture(16864))

			local buffs = {
				motw, thorns, omen
			}
			
			for i, buff in pairs(buffs) do
				local x = (i - 1) * shift
				buff:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", x, 120)
			end

			UIParent:HookScript(
				'OnUpdate',
				function()
					local o = false
					local m = false
					local t = false
					local name, duration, expirationTime
					local buffs = {}
					for i=1,40 do 
						name, _, _, _, duration, expirationTime = UnitBuff("player",i);
						if name == "Mark of the Wild" or name == "Gift of the Wild" then 
							m = true 
							if expirationTime - GetTime() <= 30 then m = false end
						end
						if name == "Thorns" then 
							t = true 
							if expirationTime - GetTime() <= 30 then t = false end
						end
						if name == "Omen of Clarity" then 
							o = true 
							if expirationTime - GetTime() <= 30 then o = false end
						end
					end

					if not m then
						table.insert(buffs, motw)
						-- motw:Show()
					else 
						-- motw:Hide() 
						motw:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 2000, -2000)
					end
					if not t then 
						table.insert(buffs, thorns)
						-- thorns:Show()
					else 
						-- thorns:Hide() 
						thorns:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 2000, -2000)
					end
					if not o then 
						table.insert(buffs, omen)
						-- omen:Show() 
					else 
						-- omen:Hide() 
						omen:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 2000, -2000)
					end

					for i, buff in pairs(buffs) do
						local x = (i - 1) * shift
						buff:ClearAllPoints()
						buff:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", x, 70)
						-- buff:SetFrameStrata("HIGH")
					end
				end
			)
	
		end
	)

end