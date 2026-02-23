local _, xVermin = ...

local shift = -38
local buffs = {}
local ticker = nil
local initialized = false
local pendingRefresh = false

local function loadSpells()
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
		if IsSpellKnownOrOverridesKnown(xVermin.GetSpellID("Demon Armor")) then
			buffs = {
				{
					["spell_id"] = xVermin.GetSpellID("Demon Armor"),
					["short_name"] = "demonarmor",
					["name"] = "Demon Armor",
					["found"] = false,
				},
			}
		elseif IsSpellKnownOrOverridesKnown(xVermin.GetSpellID("Demon Skin")) then
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
end

local function UpdateBuffs()
	-- ChatFrame7:AddMessage("--------------------------------------------------------------")
	-- ChatFrame7:AddMessage("Event: UpdateBuffs")

	local player_buffs = {}

	for index, buff in pairs(buffs) do
		-- ChatFrame7:AddMessage("Checking buff: " .. buff.name)
		if IsSpellKnownOrOverridesKnown(buff.spell_id) then
			buff.found = false
			for i = 1, 40 do
				local name, _, _, _, duration, expirationTime = UnitBuff("player", i)
				if not name then
					break
				end
				if name == buff.name then
					local timeRemaining = expirationTime - GetTime()
					if timeRemaining > 30 then
						buff.found = true
					end
					break
				end
			end
		end
	end

	for index, buff in pairs(buffs) do
		if IsSpellKnownOrOverridesKnown(buff.spell_id) then
			-- ChatFrame7:AddMessage("Buff: " .. buff.name .. " found: " .. tostring(buff.found))
			if not buff.found then
				table.insert(player_buffs, buff.short_name)
			else
				_G["buffbutton_" .. buff.short_name]:Hide()
			end
		end
	end

	for i, short_name in ipairs(player_buffs) do
		local x = (i - 1) * shift
		local btn = _G["buffbutton_" .. short_name]
		-- ChatFrame7:AddMessage("Showing buff button for: " .. short_name)
		if btn then
			btn:ClearAllPoints()
			btn:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", x, 70)
			btn:Show()
		end
	end
end

local function StartTicker()
	-- ChatFrame7:AddMessage("Starting buff check ticker...")
	if ticker then
		ticker:Cancel()
	end
	ticker = C_Timer.NewTicker(1, function()
		if not InCombatLockdown() then
			UpdateBuffs()
		end
	end)
end

local function Refresh()
	loadSpells()

	if not buffs or #buffs == 0 then
		return
	end

	for index, buff in pairs(buffs) do
		if IsSpellKnownOrOverridesKnown(buff.spell_id) then
			local frame = _G["buffbutton_" .. buff.short_name]
			if not frame then
				frame = CreateFrame("Button", "buffbutton_" .. buff.short_name, UIParent, "SecureActionButtonTemplate")
				frame:SetAttribute("type1", "macro")
				frame:SetAttribute("macrotext1", "/cast [@player] " .. buff.name)
				frame:SetFrameStrata("MEDIUM")
				frame:SetSize(36, 36)
				frame:RegisterForClicks("AnyDown")

				-- frame:CreateBeautyBorder(6)

				-- Icon texture
				-- frame.icon = frame:CreateTexture(nil, "BACKGROUND")
				-- frame.icon:SetAllPoints()
				-- frame.icon:SetTexture(GetSpellTexture(buff.spell_id))

				-- -- Cooldown frame (the swipe animation)
				-- frame.cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
				-- frame.cooldown:SetAllPoints()
				-- frame.cooldown:SetDrawEdge(true)

				-- -- Count text (for charges/stacks)
				-- frame.count = frame:CreateFontString(nil, "OVERLAY")
				-- frame.count:SetFontObject("NumberFontNormal")
				-- frame.count:SetPoint("BOTTOMRIGHT", -2, 2)

				-- -- Hotkey text
				-- frame.hotkey = frame:CreateFontString(nil, "OVERLAY")
				-- frame.hotkey:SetFontObject("NumberFontNormalSmallGray")
				-- frame.hotkey:SetPoint("TOPLEFT", 2, -2)
				-- frame.hotkey:SetText("") -- Set keybind here if needed

				-- Highlight when moused over
				frame:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
				frame:GetHighlightTexture():SetBlendMode("ADD")

				-- Pushed texture
				-- frame:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")

				-- Normal texture (the border)
				-- frame:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2")

				-- Optional: Check if spell is ready
				-- frame:SetScript("OnUpdate", function(self, elapsed)
				--  local start, duration = GetSpellCooldown(buff.spell_id)
				--  if start and duration then
				--      if duration > 0 then
				--          self.cooldown:SetCooldown(start, duration)
				--      else
				--          self.cooldown:Clear()
				--      end
				--  end
				-- end)
			end

			local x = (index - 1) * shift
			frame:SetPoint("BOTTOMRIGHT", SUFUnitplayer, "TOPRIGHT", x, 70)
		end
	end

	UpdateBuffs()
end

-- Events registered at load time so nothing is missed
local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:RegisterEvent("SPELLS_CHANGED")
ev:RegisterEvent("PLAYER_LEVEL_UP")
ev:RegisterEvent("PLAYER_REGEN_ENABLED")
ev:RegisterEvent("UNIT_AURA")

ev:SetScript("OnEvent", function(self, event)
	if not initialized then
		return
	end -- wait for CheckIfLoadedWithTimer

	-- ChatFrame7:AddMessage("Event triggered: " .. event)

	if event == "UNIT_AURA" then
		if not InCombatLockdown() then
			UpdateBuffs()
		end
		return
	end

	if event == "PLAYER_REGEN_ENABLED" then
		if pendingRefresh then
			pendingRefresh = false
			Refresh()
			StartTicker()
		else
			UpdateBuffs()
		end
		return
	end

	if InCombatLockdown() then
		pendingRefresh = true
	else
		Refresh()
		StartTicker()
	end
end)

-- Frame creation waits for SUF, then unlocks event processing
xVermin.CheckIfLoadedWithTimer("SUFUnitplayer", function()
	-- ChatFrame7:AddMessage("SUFUnitplayer loaded, initializing buff helper...")
	Refresh()
	StartTicker()
	initialized = true
end)
