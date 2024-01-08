local _, xVermin = ...

local interrupt_warning = CreateFrame('Frame', 'InterruptWarningFrame')
interrupt_warning:SetPoint('TOP', UIParent, 'TOP', 0, -100)
interrupt_warning.text = interrupt_warning:CreateFontString(nil, 'ARTWORK')
interrupt_warning.text:SetFont(xVermin.Config.font.arial, 40, 'NONE')
interrupt_warning.text:SetShadowOffset(1, -1)
interrupt_warning.text:SetPoint('TOP', interrupt_warning, 'TOP', 0, 0)
interrupt_warning.text:SetText('INTERRUPT NOW')
interrupt_warning.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
interrupt_warning:SetWidth(interrupt_warning.text:GetStringWidth())
interrupt_warning:SetHeight(interrupt_warning.text:GetStringHeight())
interrupt_warning:Hide()

_G.IfUnitIsCastingInteruptible = false

local HandleRotationFrame = function(on)
	if on then
		RotationFrame3:SetBackdropColor(0, 1, 0, 1)
		interrupt_warning:Show()
	else
		RotationFrame3:SetBackdropColor(1, 1, 1, 1)
		interrupt_warning:Hide()
	end
	return
end

local HandleUnit = function(unit)

	-- if xVermin.IfUnitIsCastingInteruptible(unit) then
	-- print(_G.IfUnitIsCastingInteruptible)
	if _G.IfUnitIsCastingInteruptible then
		-- WARRIOR INTERRUPT
		if (xVermin.Class == 'WARRIOR') then
			local _, battle = GetShapeshiftFormInfo(1) -- ako je battle stance
			local _, defensive = GetShapeshiftFormInfo(2) -- ako je defensive stance
			local _, berserker = GetShapeshiftFormInfo(3) -- ako je berserker stance
			if defensive and IsEquippedItemType('Shields') then
			-- if defensive then
				if IsSpellInRange('Shield Bash', unit) == 1 and select(2, GetSpellCooldown('Shield Bash')) == 0 then
					HandleRotationFrame(true)
				end
			end
			if berserker then
				if IsSpellInRange('Pummel', unit) == 1 and select(2, GetSpellCooldown('Pummel')) == 0 then
					HandleRotationFrame(true)
				end
			end
			if battle and IsEquippedItemType('Shields') then
			-- if battle then
				if IsSpellInRange('Shield Bash', unit) == 1 and select(2, GetSpellCooldown('Shield Bash')) == 0 then
					HandleRotationFrame(true)
				end
			end
		end

		-- PALADIN INTERRUPT
		if (xVermin.Class == 'PALADIN') then
			if select(2, GetSpellCooldown('Arcane Torrent')) == 0 and CheckInteractDistance(unit, 3) then
				HandleRotationFrame(true)
			end
		end

		-- DRUID INTERRUPT
		if (xVermin.Class == 'DRUID') then
			local _, bear = GetShapeshiftFormInfo(1) -- ako je bear form
			local _, aquatic = GetShapeshiftFormInfo(2) -- ako je aquatic form
			local _, cat = GetShapeshiftFormInfo(3) -- ako je cat form
			local _, travel = GetShapeshiftFormInfo(4) -- ako je travel form
			local _, moonkin = GetShapeshiftFormInfo(5) -- ako je moonkin form
			local _, tree = GetShapeshiftFormInfo(6) -- ako je tree form
			if bear and select(2, GetSpellCooldown('Bash')) == 0 and CheckInteractDistance(unit, 3) then
				HandleRotationFrame(true)
			end
		-- if cat and select(2, GetSpellCooldown('Maim')) == 0 and CheckInteractDistance(unit, 3) then
		-- 	HandleRotationFrame(true)
		-- end
		end

		-- DEATHKNIGHT INTERRUPT
		if xVermin.Class == 'DEATHKNIGHT' then
			if select(2, GetSpellCooldown('Mind Freeze')) == 0 and IsSpellInRange('Mind Freeze', unit) == 1 then
				HandleRotationFrame(true)
			end
		end

		-- SHAMAN INTERRUPT
		if xVermin.Class == 'SHAMAN' then
			if select(2, GetSpellCooldown('Earth Shock')) == 0 and IsSpellInRange('Earth Shock', unit) == 1 then
				HandleRotationFrame(true)
			end
		end

		-- HUNTER INTERRUPT
		if xVermin.Class == 'HUNTER' then
			if select(2, GetSpellCooldown('Silencing Shot')) == 0 and IsSpellInRange('Silencing Shot', unit) == 1 then
				HandleRotationFrame(true)
			end
			if select(2, GetSpellCooldown('Intimidation')) == 0 and IsSpellInRange('Intimidation', unit) == 1 then
				HandleRotationFrame(true)
			end
		end
	else
		HandleRotationFrame(false)
	end
end


xVermin.Interrupt = function(input)
	
	local unit = "target"

	if input ~= nil and input == false then 
		HandleRotationFrame(false)
		return 
	end

	local HRF = false

	-- WARRIOR INTERRUPT
	if (xVermin.Class == 'WARRIOR') then
		local _, battle = GetShapeshiftFormInfo(1) -- ako je battle stance
		local _, defensive = GetShapeshiftFormInfo(2) -- ako je defensive stance
		local _, berserker = GetShapeshiftFormInfo(3) -- ako je berserker stance
		if defensive then
			if IsSpellInRange('Shield Bash', unit) == 1 and select(2, GetSpellCooldown('Shield Bash')) == 0 then
				HRF = true
			end
		end
		if berserker then
			if IsSpellInRange('Pummel', unit) == 1 and select(2, GetSpellCooldown('Pummel')) == 0 then
				HRF = true
			end
		end
		if battle and IsEquippedItemType('Shields') then
			if IsSpellInRange('Shield Bash', unit) == 1 and select(2, GetSpellCooldown('Shield Bash')) == 0 then
				HRF = true
			end
		end
	end

	-- PALADIN INTERRUPT
	if (xVermin.Class == 'PALADIN') then
		if select(2, GetSpellCooldown('Arcane Torrent')) == 0 and CheckInteractDistance(unit, 3) then
			HRF = true
		end
	end

	-- DRUID INTERRUPT
	if (xVermin.Class == 'DRUID') then
		local _, bear = GetShapeshiftFormInfo(1) -- ako je bear form
		local _, aquatic = GetShapeshiftFormInfo(2) -- ako je aquatic form
		local _, cat = GetShapeshiftFormInfo(3) -- ako je cat form
		local _, travel = GetShapeshiftFormInfo(4) -- ako je travel form
		local _, moonkin = GetShapeshiftFormInfo(5) -- ako je moonkin form
		local _, tree = GetShapeshiftFormInfo(6) -- ako je tree form
		if bear and select(2, GetSpellCooldown('Bash')) == 0 and CheckInteractDistance(unit, 3) then
			HRF = true
		end
	-- if cat and select(2, GetSpellCooldown('Maim')) == 0 and CheckInteractDistance(unit, 3) then
	-- 	HRF = true
	-- end
	end

	-- DEATHKNIGHT INTERRUPT
	if xVermin.Class == 'DEATHKNIGHT' then
		if select(2, GetSpellCooldown('Mind Freeze')) == 0 and IsSpellInRange('Mind Freeze', unit) == 1 then
			HRF = true
		end
	end

	-- SHAMAN INTERRUPT
	if xVermin.Class == 'SHAMAN' then
		if select(2, GetSpellCooldown('Earth Shock')) == 0 and IsSpellInRange('Earth Shock', unit) == 1 then
			HRF = true
		end
	end

	-- HUNTER INTERRUPT
	if xVermin.Class == 'HUNTER' then
		if select(2, GetSpellCooldown('Silencing Shot')) == 0 and IsSpellInRange('Silencing Shot', unit) == 1 then
			HRF = true
		end
		if select(2, GetSpellCooldown('Intimidation')) == 0 and IsSpellInRange('Intimidation', unit) == 1 then
			HRF = true
		end
	end

	if HRF then 
		HandleRotationFrame(true)
	else 
		HandleRotationFrame(false)
	end

end
xInterrupt = xVermin.Interrupt

-- CheckInteractDistance
-- 1 = Inspect, 28 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
-- UIParent:HookScript(
-- 	'OnUpdate',
-- 	function(self)
-- 		if not UnitExists('target') then
-- 			HandleRotationFrame(false)
-- 		end
-- 	end
-- )

UIParent:HookScript(
	'OnUpdate',
	function(self)
		if UnitExists('focus') then
			HandleUnit('focus')
		elseif UnitExists('target') then
			HandleUnit('target')
		else
			return
		end
	end
)



-- hooksecurefunc(
-- 	ClassicCastbars, 
-- 	"StartCast", 
-- 	function(...)

-- 		dump(...) 
		
-- 	end
-- )


-- hooksecurefunc(
-- 	ClassicCastbars,
-- 	'StartCast',
-- 	function(self, unitGUID, unitID)

-- 		local cast = activeTimers[unitGUID]
-- 		print(cast.isUninterruptible)
-- 	end
-- )


