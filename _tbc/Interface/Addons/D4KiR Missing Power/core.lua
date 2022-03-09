-- By D4KiR

--[[ ### CONFIG START ### ]]--

local CONFIG = {}

--[[ General ]]--
-- Time for start setup
CONFIG.waittime = 2

--[[ Transparency Fade ]]--
-- Minimum Transparency
CONFIG.min = 0.1
-- Maximum Transparency
CONFIG.max = 0.9
-- Transparency distance
CONFIG.dir = 0.1
-- Transparency tick
CONFIG.tick = 0.1

--[[ ActionBars ]]--
local MIPOActionBars = {
	"ActionButton",
	"MultiBarBottomLeftButton",
	"MultiBarBottomRightButton",
	"MultiBarRightButton",
	"MultiBarLeftButton",
	"StanceButton",
	"AB",
	"DominosActionButton",
	"BT4",
	"ElvUI_Bar1Button",
	"ElvUI_Bar2Button",
	"ElvUI_Bar3Button",
	"ElvUI_Bar4Button",
	"ElvUI_Bar5Button",
	"ElvUI_Bar6Button",
	"ElvUI_StanceBar",
	"ActionBar1",
	"ActionBar2",
	"ActionBar3",
	"ActionBar4",
	"ActionBar5",
	"ActionBar6",
	"ActionBar7",
	"ActionBar8",
	"ActionBar9",
	"ActionBar10",
	"MAIStance"
}
--[[ ### CONFIG END ### ]]--



--[[ Functions, do not change, write me! ]]--

local setup = true
local ready = false

local ActionButtons = {}
local MIPOActionButtons = {}

local color = {}
color.r = 0.3
color.g = 0.3
color.b = 1.0
color.a = 1

local cur = CONFIG.min
local dir = CONFIG.dir

function MIPOGetActionFromButton(button, action)
	if strfind(button:GetName(), "MAI") then
		local id = button.sbsid or button.spellid
		local at = "spell"
		return id, at
	end
	local abslot = nil
	if ActionButton_GetPagedID and ActionButton_CalculateAction then
		abslot = action or button.action or button:GetAttribute("action") or ActionButton_GetPagedID(button) or ActionButton_CalculateAction(button) or 0
	else
		abslot = action or button.action or button:GetAttribute("action") or 0
	end
	if abslot ~= nil then
		local at, id, subType
		if type(abslot) == "number" and HasAction(abslot) then
			at, id, subType = GetActionInfo(abslot)
			return id, at
		end
		if button.GetAction then
			at, id = button:GetAction()
		end
		if button.GetID then
			id = button:GetID()
		end
		return id, at
	else
		return
	end
end

local loaded = false
function MIPOShowOOM(init)
	if init then
		loaded = true
	end
	if loaded then
		if setup and not InCombatLockdown() then
			setup = false
			
			for _, ab in pairs(MIPOActionBars) do
				for i = 1, 120 do
					local NAME = ab .. i
					if _G[NAME] == nil then
						NAME = ab .. "Button" .. i
					end

					if _G[NAME] ~= nil then
						local BTNNAME = NAME .. "OOM"
						if _G[BTNNAME] == nil then
							-- OOM
							_G[BTNNAME] = CreateFrame("FRAME", BTNNAME, _G[NAME])
							local OOM = _G[BTNNAME]
							OOM:SetWidth(_G[NAME]:GetWidth())
							OOM:SetHeight(_G[NAME]:GetHeight())
							OOM:ClearAllPoints()
							OOM:SetPoint("TOPLEFT", _G[NAME], "TOPLEFT", 0, -_G[NAME]:GetHeight())
							OOM.texture = OOM:CreateTexture("MyTexture", "ARTWORK")
							OOM.texture:SetColorTexture(color.r, color.g, color.b, color.a)
							OOM.texture:SetAllPoints(OOM)
							OOM:SetFrameStrata("BACKGROUND")
							OOM.OldHide = OOM.OldHide or OOM.Hide
							OOM.Hide = function(self, forced)
								if forced == true then
									self:SetAlpha(0)
								end
							end
							OOM.OldShow = OOM.OldShow or OOM.Show
							OOM.Show = function(self, forced)
								if forced == true then
									self:SetAlpha(MIPOGetConfig("poweralpha", 0.7))
								end
							end

							-- Next
							local BTNNAMENEXT = BTNNAME .. "Next"
							_G[BTNNAMENEXT] = CreateFrame("FRAME", BTNNAMENEXT, _G[NAME])
							local OOMNext = _G[BTNNAMENEXT]
							OOMNext:SetWidth(_G[NAME]:GetWidth())
							OOMNext:SetHeight(_G[NAME]:GetHeight())
							OOMNext:ClearAllPoints()
							OOMNext:SetPoint("TOPLEFT", _G[NAME], "TOPLEFT", 0, -36)
							OOMNext.texture = OOMNext:CreateTexture("MyTexture", "ARTWORK")
							OOMNext.texture:SetColorTexture(0, 0, 0, color.a)
							OOMNext.texture:SetAllPoints(OOMNext)
							OOMNext:SetFrameStrata("BACKGROUND")
							OOMNext.OldHide = OOMNext.OldHide or OOMNext.Hide
							OOMNext.Hide = function(self, forced)
								if forced == true then
									self:SetAlpha(0)
								end
							end
							OOMNext.OldShow = OOMNext.OldShow or OOMNext.Show
							OOMNext.Show = function(self, forced)
								if forced == true then
									self:SetAlpha(MIPOGetConfig("poweralpha", 0.7) / 2)
								end
							end

							-- NextReady
							if MIPOBUILD ~= "RETAIL" then
								local BTNNAMENEXTREADY = BTNNAME .. "NextReady"
								_G[BTNNAMENEXTREADY] = CreateFrame("FRAME", BTNNAMENEXTREADY, _G[NAME])
								OOMNextReady = _G[BTNNAMENEXTREADY]
								OOMNextReady:SetWidth(_G[NAME]:GetWidth())
								OOMNextReady:SetHeight(_G[NAME]:GetHeight())
								OOMNextReady:ClearAllPoints()
								OOMNextReady:SetPoint("TOPLEFT", _G[NAME], "TOPLEFT", 0, -36)
								OOMNextReady.texture = OOMNextReady:CreateTexture("MyTexture", "ARTWORK")
								OOMNextReady.texture:SetColorTexture(0, 0, 0, color.a)
								OOMNextReady.texture:SetAllPoints(OOMNextReady)
								OOMNextReady:SetFrameStrata("BACKGROUND")
								OOMNextReady.OldHide = OOMNextReady.OldHide or OOMNextReady.Hide
								OOMNextReady.Hide = function(self, forced)
									if forced == true then
										self:SetAlpha(0)
									end
								end
								OOMNextReady.OldShow = OOMNextReady.OldShow or OOMNextReady.Show
								OOMNextReady.Show = function(self, forced)
									if forced == true then
										self:SetAlpha(color.a)
									end
								end
								OOMNextReady:SetAlpha(0)
							end

							-- AmountCounter
							local BTNNAMEAMOUNTCOUNTER = BTNNAME .. "AmountCounter"
							_G[BTNNAMEAMOUNTCOUNTER] = CreateFrame("FRAME", BTNNAMEAMOUNTCOUNTER, _G[NAME])
							local OOMAmountCounter = _G[BTNNAMEAMOUNTCOUNTER]
							OOMAmountCounter:SetWidth(_G[NAME]:GetWidth())
							OOMAmountCounter:SetHeight(_G[NAME]:GetHeight())
							OOMAmountCounter:ClearAllPoints()
							OOMAmountCounter:SetPoint("CENTER", _G[NAME], "CENTER", 0, 0)

							OOMAmountCounter.text = OOMAmountCounter:CreateFontString(nil, "ARTWORK")
							OOMAmountCounter.text:SetFont(STANDARD_TEXT_FONT, MIPOGetConfig("fontsize", 12), "OUTLINE")
							OOMAmountCounter.text:SetText("")
							OOMAmountCounter.text:SetTextColor(1, 1, 1, 0.9)
							OOMAmountCounter.text:SetPoint("CENTER", _G[NAME], "CENTER", 0, 0)

							OOMAmountCounter:SetFrameStrata("BACKGROUND")
							OOMAmountCounter.OldHide = OOMAmountCounter.OldHide or OOMAmountCounter.Hide
							OOMAmountCounter.Hide = function(self, forced)
								if forced == true then
									self:SetAlpha(0)
								end
							end
							OOMAmountCounter.OldShow = OOMAmountCounter.OldShow or OOMAmountCounter.Show
							OOMAmountCounter.Show = function(self, forced)
								if forced == true then
									self:SetAlpha(0.9)
								end
							end
							OOMAmountCounter:Show(true)

							OOM:Hide(true)
							OOMNext:Hide(true)
							if OOMNextReady ~= nil then
								OOMNextReady:Hide(true)
								OOMNextReady.show = false
							end
							OOMAmountCounter:Hide(true)
						end
						if ActionButtons[BTNNAME] == nil then
							ActionButtons[BTNNAME] = {}
							ActionButtons[BTNNAME].name = NAME
							ActionButtons[BTNNAME].btn = _G[BTNNAME]
							ActionButtons[BTNNAME].nr = i
						end
					end
				end
			end

			ready = true
			MIPO_InitSetting()
			MIPOShowOOM()
		elseif ready then
			if UnitInVehicle then
				if UnitInVehicle("PLAYER") then
					return
				end
			end

			if MIPOUpdate then
				MIPOUpdate = false

				MIPOActionButtons = {} -- new table
				for btnname, ab in pairs(ActionButtons) do
					local ABTN = _G[ab.name]
					
					local id, at = MIPOGetActionFromButton(ABTN, ABTN._state_action)
					local name = nil
					local spellId = nil
					if at == "macro" then
						id = GetMacroSpell(id)
					end
					name, _, _, _, _, _, spellId = GetSpellInfo(id)
					if string.find(ab.name, "StanceButton") and not string.find(ab.name, "MAIStanceButton") and id ~= nil then
						_, _, _, id = GetShapeshiftFormInfo(ab.nr);
						name, _, _, _, _, _, spellId = GetSpellInfo(id)
					end
					local cost = -1
					if name then
						local costs = GetSpellPowerCost(spellId)
						if costs ~= nil and costs[1] ~= nil and (at == "spell" or at == "macro") then
							local ptid, ptname = UnitPowerType("PLAYER")
							cost = costs[1].cost
							typ = costs[1].type
							if costs[2] ~= nil and costs[2].type == ptid and costs[2].cost ~= 0 then
								cost = costs[2].cost
								typ = costs[2].type
							end
							if costs[3] ~= nil and costs[3].type == ptid and costs[3].cost ~= 0  then
								cost = costs[3].cost
								typ = costs[3].type
							end
						end
					end

					if cost >= 0 then
						MIPOActionButtons[btnname] = ActionButtons[btnname]
					end
				end
			end

			for btnname, ab in pairs(MIPOActionButtons) do
				local ABTN = _G[ab.name]
				--local layer, sublevel = _G[ab.name .. "Icon"]:GetDrawLayer()
				local OOM = _G[btnname]
				local OOMNext = _G[btnname .. "Next"]
				local OOMNextReady = _G[btnname .. "NextReady"]
				local OOMAmountCounter = _G[btnname .. "AmountCounter"]
				OOM:Hide(true)
				OOMNext:Hide(true)
				if OOMNextReady ~= nil then
					OOMNextReady:Hide(true)
					OOMNextReady.show = false
				end
				if OOMAmountCounter.text.fs ~= MIPOGetConfig("fontsize", 12) then
					OOMAmountCounter.text.fs = MIPOGetConfig("fontsize", 12)
					OOMAmountCounter.text:SetFont(STANDARD_TEXT_FONT, MIPOGetConfig("fontsize", 12), "OUTLINE")
				end

				local id, at = MIPOGetActionFromButton(ABTN, ABTN._state_action)
				local name = nil
				local spellId = nil
				if at == "macro" then
					id = GetMacroSpell(id)
				end

				name, _, _, _, _, _, spellId = GetSpellInfo(id)
				if string.find(ab.name, "StanceButton") and not string.find(ab.name, "MAIStanceButton") and id ~= nil then
					_, _, _, id = GetShapeshiftFormInfo(ab.nr);
					name, _, _, _, _, _, spellId = GetSpellInfo(id)
				end
				local ph = 0
				local p = 0
				local cost = 0
				local typ = 0
				local shownext = true
				local regen = 0
				local amount = 0
				if name then
					local costs = GetSpellPowerCost(spellId)
					if costs ~= nil and costs[1] ~= nil and (at == "spell" or at == "macro") then
						local ptid, ptname = UnitPowerType("PLAYER")
						cost = costs[1].cost
						typ = costs[1].type
						if costs[2] ~= nil and costs[2].type == ptid and costs[2].cost ~= 0 then
							cost = costs[2].cost
							typ = costs[2].type
						end
						if costs[3] ~= nil and costs[3].type == ptid and costs[3].cost ~= 0  then
							cost = costs[3].cost
							typ = costs[3].type
						end

						-- COLOR
						local r = 1.0
						local g = 1.0
						local b = 1.0
						local pbc = PowerBarColor[typ]
						if pbc ~= nil then
							r = pbc.r or r
							g = pbc.g or g
							b = pbc.b or b
						end
						r = mathC(r, 0.3, 1.0)
						g = mathC(g, 0.3, 1.0)
						b = mathC(b, 0.3, 1.0)

						-- TYPES
						local mana = UnitPower("player", Enum.PowerType.Mana)
						local rage = UnitPower("player", Enum.PowerType.Rage)
						local ener = UnitPower("player", Enum.PowerType.Energy)
						local focu = UnitPower("player", Enum.PowerType.Focus)
						local rune = UnitPower("player", Enum.PowerType.RunicPower)
						local luna = UnitPower("player", Enum.PowerType.LunarPower)
						local pain = UnitPower("player", Enum.PowerType.Pain)
						local fury = UnitPower("player", Enum.PowerType.Fury)
						local mael = UnitPower("player", Enum.PowerType.Maelstrom)
						local insa = UnitPower("player", Enum.PowerType.Insanity)
						local holy = UnitPower("player", Enum.PowerType.HolyPower)
						local chi = UnitPower("player", Enum.PowerType.Chi)

						if typ == Enum.PowerType.Mana then
							color.r = r
							color.g = g
							color.b = b
							if cost > mana then
								p = mana / cost
							else
								p = 0
							end
							regen = GetPowerRegen() * 2
							if cost > 0 then
								amount = mana / cost
							else
								amount = 0
							end
						elseif typ == Enum.PowerType.Rage then
							color.r = r
							color.g = g
							color.b = b
							if cost > rage then
								p = rage / cost
							else
								p = 0
							end
							shownext = true
							regen = GetPowerRegen() / -2
							if cost > 0 then
								amount = rage / cost
							else
								amount = 0
							end
						elseif typ == Enum.PowerType.Energy or typ == Enum.PowerType.ComboPoints then
							color.r = r
							color.g = g
							color.b = b
							if cost > ener then
								p = ener / cost
							else
								p = 0
							end
							if GetPowerRegen then
								regen = GetPowerRegen()
							else
								regen = 20
							end
							if cost > 0 then
								amount = ener / cost
							else
								amount = 0
							end
							if MIPOGetConfig("experiment", false) and MiPoPercent then
								if cost-ener > 0 and MiPoPercent > 0 then
									if cost - (ener + 20) < 0 then
										amount = 1 - MiPoPercent
									else
										amount = 0
									end
								else
									amount = 0
								end
							end
						elseif typ == Enum.PowerType.Focus then
							color.r = r
							color.g = g
							color.b = b
							if cost > focu then
								p = focu / cost
							else
								p = 0
							end
							shownext = true
							regen = GetPowerRegen() / -2
							if cost > 0 then
								amount = focu / cost
							else
								amount = 0
							end
						elseif typ == Enum.PowerType.RunicPower then
							color.r = r
							color.g = g
							color.b = b
							if cost > rune then
								p = rune / cost
							else
								p = 0
							end
							shownext = true
							regen = GetPowerRegen()
							if cost > 0 then
								amount = rune / cost
							else
								amount = 0
							end
						elseif typ == Enum.PowerType.LunarPower then
							color.r = r
							color.g = g
							color.b = b
							if cost > luna then
								p = luna / cost
							else
								p = 0
							end
							shownext = false
							regen = GetPowerRegen()
							if cost > 0 then
								amount = luna / cost
							else
								amount = 0
							end
						elseif typ == Enum.PowerType.Pain then
							color.r = r
							color.g = g
							color.b = b
							if cost > pain then
								p = pain / cost
							else
								p = 0
							end
							shownext = true
							regen = GetPowerRegen()
							if cost > 0 then
								amount = pain / cost
							else
								amount = 0
							end
						elseif typ == Enum.PowerType.Fury then
							color.r = r
							color.g = g
							color.b = b
							if cost > fury then
								p = fury / cost
							else
								p = 0
							end
							shownext = true
							regen = GetPowerRegen()
							if cost > 0 then
								amount = fury / cost
							else
								amount = 0
							end
						elseif typ == Enum.PowerType.Maelstrom then
							color.r = r
							color.g = g
							color.b = b
							if cost > mael then
								p = mael / cost
							else
								p = 0
							end
							shownext = true
							regen = GetPowerRegen()
							if cost > 0 then
								amount = mael / cost
							else
								amount = 0
							end
						elseif typ == Enum.PowerType.HolyPower then
							color.r = r
							color.g = g
							color.b = b
							if cost > holy then
								p = holy / cost
							else
								p = 0
							end
							shownext = true
							regen = GetPowerRegen()
							if cost > 0 then
								amount = holy / cost
							else
								amount = 0
							end
						elseif typ == Enum.PowerType.Insanity then
							color.r = r
							color.g = g
							color.b = b
							if cost > insa then
								p = insa / cost
							else
								p = 0
							end
							shownext = true
							regen = GetPowerRegen()
							if cost > 0 then
								amount = insa / cost
							else
								amount = 0
							end
						elseif typ == Enum.PowerType.Chi then
							color.r = r
							color.g = g
							color.b = b
							if cost > chi then
								p = chi / cost
							else
								p = 0
							end
							shownext = true
							regen = GetPowerRegen()
							if cost > 0 then
								amount = chi / cost
							else
								amount = 0
							end
						elseif typ > 0 and typ ~= 5 and typ ~= 7 and typ ~= 10 and typ ~= 15 and typ ~= 16 then
							local _, englishClass, _ = UnitClass("player")
							print("Send this to missing power Developer [POWERTYP]: " .. typ .. " Class: " .. englishClass .. " WoW: " .. tostring(MIPOBUILD))
							print(UnitPowerType("PLAYER"))
							--pTab(Enum.PowerType)
						end

						if OOM.texture ~= nil then
							OOM.texture:SetColorTexture(color.r, color.g, color.b)
							OOMNext.texture:SetColorTexture(color.r, color.g, color.b)
							if OOMNextReady ~= nil then
								OOMNextReady.texture:SetColorTexture(color.r, color.g, color.b)
							end
							if MIPOGetConfig("customcolor", false) then
								OOMAmountCounter.text:SetTextColor( MIPOGetConfig("ccolr", 0), MIPOGetConfig("ccolg", 0), MIPOGetConfig("ccolb", 0) )
							else
								OOMAmountCounter.text:SetTextColor(color.r + 0.2, color.g + 0.2, color.b + 0.2)
							end
						end
					end

					OOMAmountCounter:ClearAllPoints()
					OOMAmountCounter:SetPoint("CENTER", ABTN, "CENTER", 0, 0)
					OOMAmountCounter:Show(true)
					OOMAmountCounter:SetFrameStrata(ABTN:GetFrameStrata())
					if amount > 0 and at ~= nil and MIPOGetConfig("showamountcounter", true) and (at == "spell" or at == "macro") then
						OOMAmountCounter:SetAlpha(1)
					else
						OOMAmountCounter:SetAlpha(0)
					end

					local decimals = MIPOGetConfig( "decimals", 1 )
					local amo = -1
					if decimals == 0 or amount > 99 then
						amo = math.floor( amount )
					else
						amo = format( "%." .. decimals .. "f", amount )
					end
					if MIPOGetConfig("displayiflowerthanx", 10) > 0 then
						if amount < MIPOGetConfig("displayiflowerthanx", 10) then
							OOMAmountCounter.text:SetText(amo)
						else
							OOMAmountCounter.text:SetText("")
						end
					else
						OOMAmountCounter.text:SetText(amo)
					end

					local ax = "CENTER"
					local ay = "CENTER"
					local px = 0
					local py = 0
					if MIPOGetConfig("fontx", 0) < 0 then
						ax = "LEFT"
						px = 2
					elseif MIPOGetConfig("fontx", 0) > 0 then
						ax = "RIGHT"
						px = -2
					end
					if MIPOGetConfig("fonty", 0) < 0 then
						ay = "BOTTOM"
						py = 2
					elseif MIPOGetConfig("fonty", 0) > 0 then
						ay = "TOP"
						py = -2
					end
					OOMAmountCounter.text:SetSize(OOM:GetWidth(), OOM:GetWidth())
					OOMAmountCounter.text:SetPoint("CENTER", ABTN, "CENTER", MIPOGetConfig("fontx", 0) + px, MIPOGetConfig("fonty", 0) + py)
					OOMAmountCounter.text:SetJustifyH(ax)
					OOMAmountCounter.text:SetJustifyV(ay)

					if p <= 0 then
						if OOMNextReady ~= nil then
							OOMNextReady:SetFrameStrata("BACKGROUND")
							OOMNextReady:SetHeight(0.1)
							OOMNextReady:Hide(true)
							OOMNextReady.show = false
						end

						OOM:SetHeight(0.1)
						OOMNext:SetHeight(0.1)

						OOM:Hide(true)
						OOM:SetFrameStrata("BACKGROUND")
						OOM:SetAlpha(0)
						OOMNext:Hide(true)
						OOMNext:SetFrameStrata("BACKGROUND")
						OOMNext:SetAlpha(0)
					else
						OOM:Show(true)
						OOM:SetFrameStrata(ABTN:GetFrameStrata())
						OOM:SetAlpha(MIPOGetConfig("poweralpha", 0.7))
						if shownext and MIPOBUILD ~= "RETAIL" then
							OOMNext:Show(true)
							OOMNext:SetFrameStrata(ABTN:GetFrameStrata())
							OOMNext:SetAlpha(MIPOGetConfig("poweralpha", 0.7) / 2)
						end

						local h = ABTN:GetHeight()
						local y = h * p - h
						OOM:ClearAllPoints()
						OOM:SetPoint("TOPLEFT", ABTN, "TOPLEFT", 0, y)
						OOM:SetHeight(h * p)

						h = ABTN:GetHeight()
						ph = h / cost * regen
						y = y + ph
						if y > 0 then
							if MIPOGetConfig("hideoverlap", true) then -- overlap disabled
								ph = ph - y
								y = 0
							end
							if MIPOGetConfig("shownextready", true) then
								if OOMNextReady ~= nil then
									OOMNextReady:SetFrameStrata(OOM:GetFrameStrata())
									OOMNextReady:SetHeight(h)
									OOMNextReady:ClearAllPoints()
									OOMNextReady:SetPoint("TOPLEFT", ABTN, "TOPLEFT", 0, 0)
									OOMNextReady:Show(true)
									OOMNextReady.show = true
								end

								OOM:Hide(true)
								OOMNext:Hide(true)
							end
						end
						OOMNext:ClearAllPoints()
						OOMNext:SetPoint("TOPLEFT", ABTN, "TOPLEFT", 0, y)
						OOMNext:SetHeight(ph)
					end
				else
					OOM:SetFrameStrata("BACKGROUND")
					OOMNext:SetFrameStrata("BACKGROUND")

					if OOMNextReady ~= nil then
						OOMNextReady:SetFrameStrata("BACKGROUND")
						OOMNextReady:SetHeight(0.1)
						OOMNextReady:Hide(true)
						OOMNextReady.show = false
					end

					OOM:SetHeight(0.1)
					OOMNext:SetHeight(0.1)

					OOMNext:Hide(true)
					OOMNext:SetAlpha(0)

					OOM:Hide(true)
					OOM:SetAlpha(0)
				end
			end
		end
	end
end

function MIPOBlink_Think()
	if ready and MIPOBUILD ~= "RETAIL" then
		cur = cur + dir
		if cur > CONFIG.max then
			cur = CONFIG.max
			dir = -CONFIG.dir
		elseif cur < CONFIG.min then
			cur = CONFIG.min
			dir = CONFIG.dir
		end

		for btnname, ab in pairs(MIPOActionButtons) do
			local OOMNextReady = _G[btnname .. "NextReady"]
			if OOMNextReady ~= nil and OOMNextReady.show then
				OOMNextReady:SetAlpha(cur)
			end
		end
	end

	C_Timer.After(CONFIG.tick, MIPOBlink_Think)
end
MIPOBlink_Think()

local power = -1
local mana = -1
function MIPOThink()
	if power ~= UnitPower("PLAYER") or mana ~= UnitPower("PLAYER", Enum.PowerType.Mana) then
		power = UnitPower("PLAYER")
		mana = UnitPower("PLAYER", Enum.PowerType.Mana)
		MIPOShowOOM()
	end

	C_Timer.After(0.1, MIPOThink)
end
MIPOThink()



local frame = CreateFrame("FRAME")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
frame:RegisterEvent("SPELLS_CHANGED")
frame:RegisterEvent("UNIT_SPELLCAST_START")
--frame:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")
frame:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
--frame:RegisterEvent("SPELL_UPDATE_USABLE")

local MPLoaded = false
local function eventHandler(self, event, unit, powertype, ...)
	if event == "PLAYER_ENTERING_WORLD" and not MPLoaded then
		MPLoaded = true
		C_Timer.After(1, function()
			MIPOUpdate = true
			MIPOShowOOM(true)
		end)
	elseif event == "UPDATE_SHAPESHIFT_FORM" or event == "ACTIONBAR_PAGE_CHANGED" then
		C_Timer.After(0.8, function()
			MIPOUpdate = true
			MIPOShowOOM()
		end)
	else
		MIPOShowOOM()
	end
end
frame:SetScript("OnEvent", eventHandler)



local frame2 = CreateFrame("FRAME")
frame2:RegisterEvent("UNIT_POWER_UPDATE")
--frame2:RegisterEvent("UNIT_POWER_FREQUENT")
local function eventHandler2(self, event, unit, powertype, ...)
	if event == "UNIT_POWER_UPDATE" and unit == "player" and ready then
		MIPOShowOOM()
	end
end
frame2:SetScript("OnEvent", eventHandler2)
