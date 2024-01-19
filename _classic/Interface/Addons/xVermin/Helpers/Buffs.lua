
local _, xVermin = ...

local shift = -38

if xVermin.Class == "DRUID" then

	xVermin.CheckIfLoadedWithTimer(
		'SUFUnitplayer',
		function()

			local pwf = CreateFrame("Button", "buffbutton_pwf", UIParent, "SecureActionButtonTemplate,ActionButtonTemplate");
			pwf:SetAttribute("type1", "macro");
			pwf:SetAttribute("macrotext1", "/cast Mark of the Wild");
			pwf:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", 0, 120)
			pwf:CreateBeautyBorder(4)
			pwf:SetSize(36,36)
			pwf:RegisterForClicks("AnyUp")
			pwf.texture = pwf:CreateTexture(nil, 'BACKGROUND')
			pwf.texture:SetSize(pwf:GetSize())
			pwf.texture:SetPoint('CENTER')
			pwf.texture:SetTexture(GetSpellTexture(6756))

			local inner = CreateFrame("Button", "buffbutton_inner", UIParent, "SecureActionButtonTemplate,ActionButtonTemplate");
			inner:SetAttribute("type1", "macro");
			inner:SetAttribute("macrotext1", "/cast inner");
			inner:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", -38, 120)
			inner:CreateBeautyBorder(4)
			inner:SetSize(36,36)
			inner:RegisterForClicks("AnyUp")
			inner.texture = inner:CreateTexture(nil, 'BACKGROUND')
			inner.texture:SetSize(inner:GetSize())
			inner.texture:SetPoint('CENTER')
			inner.texture:SetTexture(GetSpellTexture(1075))

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
				pwf, inner, omen
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
						if name == "inner" then 
							t = true 
							if expirationTime - GetTime() <= 30 then t = false end
						end
						if name == "Omen of Clarity" then 
							o = true 
							if expirationTime - GetTime() <= 30 then o = false end
						end
					end

					if not m then
						table.insert(buffs, pwf)
						-- pwf:Show()
					else 
						-- pwf:Hide() 
						pwf:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 2000, -2000)
					end
					if not t then 
						table.insert(buffs, inner)
						-- inner:Show()
					else 
						-- inner:Hide() 
						inner:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 2000, -2000)
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

if xVermin.Class == "PRIEST" then

	xVermin.CheckIfLoadedWithTimer(
		'SUFUnitplayer',
		function()

			local buffs = {
				{["spell_id"] = 1243, ["short_name"] = "pwf", ["name"] = "Power Word: Fortitude", ["found"] = false},
				{["spell_id"] = 588, ["short_name"] = "if", ["name"] = "Inner Fire", ["found"] = false},
			}

			for index, buff in pairs(buffs) do
				if IsSpellKnown(buff.spell_id) then
					local frame = _G[buff.short_name]
					if not frame then 
						frame = CreateFrame("Button", "buffbutton_" .. buff.short_name, UIParent, "SecureActionButtonTemplate,ActionButtonTemplate");
						frame:SetAttribute("type1", "macro");
						frame:SetAttribute("macrotext1", "/cast " .. buff.name);
						frame:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", 0, 120)
						frame:CreateBeautyBorder(4)
						frame:SetSize(36,36)
						frame:RegisterForClicks("AnyUp")
						frame.texture = frame:CreateTexture(nil, 'BACKGROUND')
						frame.texture:SetSize(frame:GetSize())
						frame.texture:SetPoint('CENTER')
						frame.texture:SetTexture(GetSpellTexture(buff.spell_id))
					end

					local x = (index - 1) * shift
					frame:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", x, 120)
				end
			end

			UIParent:HookScript(
				'OnUpdate',
				function()
					local name, duration, expirationTime
					local player_buffs = {}


					for index, buff in pairs(buffs) do
						if IsSpellKnown(buff.spell_id) then
							buff.found = false
							for i=1,40 do 
								name, _, _, _, duration, expirationTime = UnitBuff("player",i);
								if name == buff.name then 
									buff.found = true
									if expirationTime - GetTime() <= 30 then buff.found = false end
								end
							end
						end
					end

					for index, buff in pairs(buffs) do
						if IsSpellKnown(buff.spell_id) then
							if not buff.found then
								table.insert(player_buffs, buff.short_name)
							else
								_G["buffbutton_" .. buff.short_name]:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 2000, -2000)
							end
						end
					end

					for i, buff in pairs(player_buffs) do
						local x = (i - 1) * shift
						_G["buffbutton_" .. buff]:ClearAllPoints()
						_G["buffbutton_" .. buff]:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", x, 70)
					end
				end
			)
	
		end
	)

end

