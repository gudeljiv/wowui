-- FSR

if MIPOBUILD ~= "RETAIL" then
	local tick = 0.01

	local now = GetTime()
	nexttick = now + 2

	local oldmana = 0

	local mpt = 2
	local fsr = 5

	local max = 2
	local gain = true

	local oldener = 0

	local mana = 0
	local manamax = 0
	local ener = 0
	local enermax = 0

	local frame = CreateFrame("FRAME")
	frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	local tex = frame:CreateTexture(nil, "BACKGROUND")
	tex:SetAllPoints()
	tex:SetColorTexture(1, 1, 1, 0)
	local function eventHandler(self, event, unit, a, b, c, ...)
		now = GetTime()
		if event == "UNIT_SPELLCAST_SUCCEEDED" then
			mana = UnitPower("player", Enum.PowerType.Mana)
			manamax = UnitPowerMax("player", Enum.PowerType.Mana)
			ener = UnitPower("player", Enum.PowerType.Energy)
			enermax = UnitPowerMax("player", Enum.PowerType.Energy)

			if unit == "player" and event == "UNIT_SPELLCAST_SUCCEEDED" and oldmana ~= mana then
				oldmana = mana
				--local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(b)

				local costs = GetSpellPowerCost(b)
				if costs[1] ~= nil and costs[1].cost > 0 then
					max = fsr
					gain = false
					nexttick = now + fsr
				end
			end
			if unit == "player" and event == "UNIT_SPELLCAST_SUCCEEDED" and oldener ~= ener then
				oldener = ener
			end
		end
	end
	frame:SetScript("OnEvent", eventHandler)

	frame:SetFrameStrata("HIGH")
	local glow = frame:CreateTexture(nil, "OVERLAY")
	glow:SetDrawLayer("OVERLAY", 7)
	--glow:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	--glow:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	glow:SetColorTexture(1, 1, 1, 1)
	glow:SetWidth(1)
	--glow:SetVertexColor(1, 1, 1)
	--glow:SetBlendMode("ADD")

	function FSR_Think()
		now = GetTime()
		mana = UnitPower("player", Enum.PowerType.Mana)
		manamax = UnitPowerMax("player", Enum.PowerType.Mana)
		ener = UnitPower("player", Enum.PowerType.Energy)
		enermax = UnitPowerMax("player", Enum.PowerType.Energy)
		local t = UnitPowerType("player")
		local full = false
		if t == Enum.PowerType.Mana then
			if mana < manamax then
				frame:Show()
				if gain then
					-- GAIN MANA
					if oldmana + 10 < mana or oldmana - 10 > mana or now >= nexttick then
						oldmana = mana
						max = mpt
						nexttick = now + mpt
					end
				elseif not gain then
					-- LOSE MANA
					gain = true
					--max = mpt
				end
			else
				full = true
			end
		elseif t == Enum.PowerType.Energy then
			max = 2
			local percent = (nexttick - now) / max
			if oldener < ener then
				oldener = ener
				nexttick = now + max
			elseif ener == enermax and percent <= 0.0 then
				nexttick = now + max
			end
		end

		local scale = 1
		if tonumber(GetCVar("useUiScale")) == 1 then
			scale = tonumber(GetCVar("uiscale"))
		end

		local percent = 0
		if max > 2 then
			percent = (nexttick - now) / max
		else
			percent = (max - (nexttick - now)) / max
		end

		if percent > 1 then
			full = true
		end

		if MIPOGetConfig("showtickbar", true) == false then -- if false, hide it
			full = true
		end

		if full or UnitIsDead("player") then
			frame:Hide()
		else
			frame:Show()
		end

		local mb = PlayerFrameManaBar
		if ElvUF_Player ~= nil and ElvUF_Player:IsShown() then
			mb = ElvUF_Player.Power
			frame:SetFrameStrata("HIGH")
		elseif SUFUnitplayer ~= nil and SUFUnitplayer:IsShown() then
			mb = SUFUnitplayer.powerBar
			frame:SetFrameStrata("HIGH")
		elseif XPerl_PlayerstatsFramemanaBar ~= nil and XPerl_PlayerstatsFramemanaBar:IsShown() then
			mb = XPerl_PlayerstatsFramemanaBar
			frame:SetFrameStrata("HIGH")
		end

		frame:SetParent(mb)
		frame:SetHeight(mb:GetHeight())-- * scale)--_G.UIParent:GetScale())
		frame:SetWidth(mb:GetWidth())-- * scale)--_G.UIParent:GetScale())
	
		frame:SetPoint("LEFT", mb, "LEFT")
		glow:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
		glow:SetHeight(mb:GetHeight() * 1)
		
		--tex:SetColorTexture(1, 1, 1, 0.8)

		local newsize = mb:GetWidth() * percent
		MiPoPercent = percent
		frame:SetWidth(newsize)
	end
	C_Timer.NewTicker(tick, FSR_Think)
end