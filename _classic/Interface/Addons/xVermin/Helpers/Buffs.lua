local _, xVermin = ...

local shift = -38

-- xVermin.CheckIfLoadedWithTimer("SUFUnitplayer", function()
-- 	local buffs = {}

-- 	if xVermin.Class == "PRIEST" then
-- 		buffs = {
-- 			{ ["spell_id"] = 1243, ["short_name"] = "pwf", ["name"] = "Power Word: Fortitude", ["found"] = false },
-- 			{ ["spell_id"] = 588, ["short_name"] = "if", ["name"] = "Inner Fire", ["found"] = false },
-- 		}
-- 	end
-- 	if xVermin.Class == "DRUID" then
-- 		buffs = {
-- 			{ ["spell_id"] = 1126, ["short_name"] = "motw", ["name"] = "Mark of the Wild", ["found"] = false },
-- 			{ ["spell_id"] = 467, ["short_name"] = "thorns", ["name"] = "Thorns", ["found"] = false },
-- 			{ ["spell_id"] = 16864, ["short_name"] = "omen", ["name"] = "Omen of Clarity", ["found"] = false },
-- 		}
-- 	end
-- 	if xVermin.Class == "WARLOCK" then
-- 		buffs = {
-- 			{ ["spell_id"] = 687, ["short_name"] = "demonskin", ["name"] = "Demon Skin", ["found"] = false },
-- 		}
-- 	end

-- 	if not buffs or #buffs == 0 then
-- 		return
-- 	end

-- 	for index, buff in pairs(buffs) do
-- 		if IsSpellKnown(buff.spell_id) then
-- 			local frame = _G[buff.short_name]
-- 			if not frame then
-- 				frame = CreateFrame(
-- 					"Button",
-- 					"buffbutton_" .. buff.short_name,
-- 					UIParent,
-- 					"SecureActionButtonTemplate,ActionButtonTemplate"
-- 				)
-- 				frame:SetAttribute("type1", "macro")
-- 				frame:SetAttribute("macrotext1", "/cast [@player] " .. buff.name)
-- 				frame:SetFrameStrata("HIGH")
-- 				frame:CreateBeautyBorder(6)
-- 				frame:SetSize(36, 36)
-- 				frame:RegisterForClicks("AnyUp")
-- 				frame.texture = frame:CreateTexture(nil, "BACKGROUND")
-- 				frame.texture:SetSize(frame:GetSize())
-- 				frame.texture:SetPoint("CENTER")
-- 				frame.texture:SetTexture(GetSpellTexture(buff.spell_id))

-- 				-- frame.cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
-- 				-- frame.cooldown:SetAllPoints(frame)
-- 				-- frame.cooldown:SetDrawEdge(false)
-- 				-- frame.cooldown:SetDrawSwipe(false)
-- 			end

-- 			print(index, buff.short_name)

-- 			local x = (index - 1) * shift
-- 			frame:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", x, 120)
-- 		end
-- 	end

-- 	UIParent:HookScript("OnUpdate", function()
-- 		local name, duration, expirationTime
-- 		local player_buffs = {}

-- 		for index, buff in pairs(buffs) do
-- 			if IsSpellKnown(buff.spell_id) then
-- 				buff.found = false
-- 				for i = 1, 40 do
-- 					name, _, _, _, duration, expirationTime = UnitBuff("player", i)
-- 					if name == buff.name then
-- 						buff.found = true
-- 						local timeRemaining = expirationTime - GetTime()
-- 						buff.timeRemaining = timeRemaining
-- 						if timeRemaining <= 30 then
-- 							buff.found = false
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end

-- 		for index, buff in pairs(buffs) do
-- 			if IsSpellKnown(buff.spell_id) then
-- 				if not buff.found then
-- 					table.insert(player_buffs, buff.short_name)
-- 				else
-- 					_G["buffbutton_" .. buff.short_name]:SetAlpha(0)
-- 				end
-- 			end
-- 		end

-- 		for i, buff in pairs(player_buffs) do
-- 			_G["buffbutton_" .. buff]:SetAlpha(1)
-- 			if not InCombatLockdown() then
-- 				_G["buffbutton_" .. buff]:Show()
-- 			end
-- 		end
-- 	end)
-- end)
