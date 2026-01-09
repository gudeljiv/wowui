local _, xVermin = ...

local shift = -38
local buffs = {}

local loadSpells = function()
	buffs = {}
	if xVermin.Class == "PRIEST" then
		buffs = {
			{
				["spell_id"] = xVermin.GetSpellID("Power Word: Fortitude"),
				["short_name"] = "pwf",
				["name"] = "Power Word: Fortitude",
				["found"] = false,
			},
			{
				["spell_id"] = xVermin.GetSpellID("Inner Fire"),
				["short_name"] = "if",
				["name"] = "Inner Fire",
				["found"] = false,
			},
		}
	end
	if xVermin.Class == "DRUID" then
		buffs = {
			{
				["spell_id"] = xVermin.GetSpellID("Mark of the Wild"),
				["short_name"] = "motw",
				["name"] = "Mark of the Wild",
				["found"] = false,
			},
			{
				["spell_id"] = xVermin.GetSpellID("Thorns"),
				["short_name"] = "thorns",
				["name"] = "Thorns",
				["found"] = false,
			},
			{
				["spell_id"] = xVermin.GetSpellID("Omen of Clarity"),
				["short_name"] = "omen",
				["name"] = "Omen of Clarity",
				["found"] = false,
			},
		}
	end
	if xVermin.Class == "WARLOCK" then
		buffs = {
			{
				["spell_id"] = xVermin.GetSpellID("Demon Skin"),
				["short_name"] = "demonskin",
				["name"] = "Demon Skin",
				["found"] = false,
			},
		}
	end
end

local function Refresh()
	loadSpells()
	xVermin.CheckIfLoadedWithTimer("SUFUnitplayer", function()
		loadSpells()

		if not buffs or #buffs == 0 then
			return
		end

		for index, buff in pairs(buffs) do
			-- print(buff.short_name, buff.spell_id, IsSpellKnown(buff.spell_id))
			if IsSpellKnown(buff.spell_id) then
				local frame = _G["buffbutton_" .. buff.short_name]
				if not frame then
					-- print("buffbutton_" .. buff.short_name .. " created")
					frame = CreateFrame(
						"Button",
						"buffbutton_" .. buff.short_name,
						UIParent,
						"SecureActionButtonTemplate,ActionButtonTemplate"
					)
					frame:SetAttribute("type1", "macro")
					frame:SetAttribute("macrotext1", "/cast [@player] " .. buff.name)
					frame:SetFrameStrata("MEDIUM")
					frame:CreateBeautyBorder(6)
					frame:SetSize(36, 36)
					frame:RegisterForClicks("AnyUp")
					frame.texture = frame:CreateTexture(nil, "BACKGROUND")
					frame.texture:SetSize(frame:GetSize())
					frame.texture:SetPoint("CENTER")
					frame.texture:SetTexture(GetSpellTexture(buff.spell_id))

					-- frame.cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
					-- frame.cooldown:SetAllPoints(frame)
					-- frame.cooldown:SetDrawEdge(false)
					-- frame.cooldown:SetDrawSwipe(false)
				end

				local x = (index - 1) * shift
				frame:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", x, 120)
			end
		end

		UIParent:HookScript("OnUpdate", function()
			local name, duration, expirationTime
			local player_buffs = {}

			if InCombatLockdown() then
				return
			end

			for index, buff in pairs(buffs) do
				if IsSpellKnown(buff.spell_id) then
					buff.found = false
					for i = 1, 40 do
						name, _, _, _, duration, expirationTime = UnitBuff("player", i)
						if name == buff.name then
							buff.found = true
							local timeRemaining = expirationTime - GetTime()
							buff.timeRemaining = timeRemaining
							if timeRemaining <= 30 then
								buff.found = false
							end
						end
					end
				end
			end

			for index, buff in pairs(buffs) do
				-- print(buff.short_name .. " found: " .. tostring(buff.found), buff.spell_id)
				if IsSpellKnown(buff.spell_id) then
					if not buff.found then
						table.insert(player_buffs, buff.short_name)
					else
						_G["buffbutton_" .. buff.short_name]:Hide()
					end
				end
			end

			for i, short_name in pairs(player_buffs) do
				local x = (i - 1) * shift
				-- print("buffbutton_" .. short_name .. " show at " .. x)
				_G["buffbutton_" .. short_name]:ClearAllPoints()
				_G["buffbutton_" .. short_name]:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", x, 70)
				_G["buffbutton_" .. short_name]:Show()
			end
		end)
	end)
end

local ev = CreateFrame("Frame")
local pendingRefresh = false
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("SPELLS_CHANGED")
ev:RegisterEvent("LEARNED_SPELL_IN_TAB")
ev:RegisterEvent("PLAYER_LEVEL_UP")
ev:RegisterEvent("PLAYER_REGEN_ENABLED")

ev:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_ENABLED" then
		if pendingRefresh then
			pendingRefresh = false
			C_Timer.After(0.5, Refresh)
		end
		return
	end

	if InCombatLockdown() then
		pendingRefresh = true
	else
		C_Timer.After(0.5, Refresh)
	end
end)
