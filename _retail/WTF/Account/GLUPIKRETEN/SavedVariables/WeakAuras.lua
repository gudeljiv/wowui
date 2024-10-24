
WeakAurasSaved = {
	["dynamicIconCache"] = {
	},
	["editor_tab_spaces"] = 4,
	["displays"] = {
		["SwingTimerAPI 3"] = {
			["sparkWidth"] = 10,
			["iconSource"] = 0,
			["xOffset"] = 0,
			["displayText"] = "%p",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["url"] = "https://wago.io/t1O2uIIyf/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "local MAJOR, MINOR = \"LibClassicSwingTimerAPI\", 3\n-- local lib = LibStub:NewLibrary(MAJOR, MINOR)\nlocal lib = lib or {}\nif not lib then\n    return\nend\n\nlocal frame = CreateFrame(\"Frame\")\nlocal C_Timer, tonumber = C_Timer, tonumber\nlocal GetSpellInfo, GetTime, CombatLogGetCurrentEventInfo = GetSpellInfo, GetTime, CombatLogGetCurrentEventInfo\nlocal UnitAttackSpeed, UnitAura, UnitGUID, UnitRangedDamage = UnitAttackSpeed, UnitAura, UnitGUID, UnitRangedDamage\n\nlocal reset_swing_spells = {\n    [16589] = true, -- Noggenfogger Elixir\n    [2645] = true, -- Ghost Wolf\n    [51533] = true, -- Feral Spirit\n    [2764] = true, -- Throw\n    [3018] = true, -- Shoots,\n    [5384] = true, -- Feign Death\n    [5019] = true, -- Shoot\n    [75] = true, -- Auto Shot\n    [20066] = true, -- Repentance\n}\n\nlocal prevent_swing_speed_update = {\n    [768] = true, -- Cat Form\n    [5487] = true, -- Bear Form\n    [9634] = true, -- Dire Bear Form\n}\n\nlocal next_melee_spells = {\n    [47450] = true, -- Heroic Strike (rank 13)\n    [47449] = true, -- Heroic Strike (rank 12)\n    [30324] = true, -- Heroic Strike (rank 11)\n    [29707] = true, -- Heroic Strike (rank 10)\n    [25286] = true, -- Heroic Strike (rank 9)\n    [11567] = true, -- Heroic Strike (rank 18)\n    [11566] = true, -- Heroic Strike (rank 7)\n    [11565] = true, -- Heroic Strike (rank 6)\n    [11564] = true, -- Heroic Strike (rank 5)\n    [1608] = true, -- Heroic Strike (rank 4)\n    [285] = true, -- Heroic Strike (rank 3)\n    [284] = true, -- Heroic Strike (rank 2)\n    [78] = true, -- Heroic Strike (rank 1)\n    [47520] = true, -- Cleave (rank 8)\n    [47519] = true, -- Cleave (rank 7)\n    [25231] = true, -- Cleave (rank 6)\n    [20569] = true, -- Cleave (rank 5)\n    [11609] = true, -- Cleave (rank 4)\n    [11608] = true, -- Cleave (rank 3)\n    [7369] = true, -- Cleave (rank 2)\n    [845] = true, -- Cleave (rank 1)\n    [48996] = true, -- Raptor Strike (rank 11)\n    [48995] = true, -- Raptor Strike (rank 10)\n    [27014] = true, -- Raptor Strike (rank 9)\n    [14266] = true, -- Raptor Strike (rank 8)\n    [14265] = true, -- Raptor Strike (rank 7)\n    [14264] = true, -- Raptor Strike (rank 6)\n    [14263] = true, -- Raptor Strike (rank 5)\n    [14262] = true, -- Raptor Strike (rank 4)\n    [14261] = true, -- Raptor Strike (rank 3)\n    [14260] = true, -- Raptor Strike (rank 2)\n    [2973] = true, -- Raptor Strike (rank 1)\n    [6807] = true, -- Maul (rank 1)\n    [6808] = true, -- Maul (rank 2)\n    [6809] = true, -- Maul (rank 3)\n    [8972] = true, -- Maul (rank 4)\n    [9745] = true, -- Maul (rank 5)\n    [9880] = true, -- Maul (rank 6)\n    [9881] = true, -- Maul (rank 7)\n    [26996] = true, -- Maul (rank 8)\n    [48479] = true, -- Maul (rank 9)\n    [48480] = true, -- Maul (rank 10)\n}\n\nlocal noreset_swing_spells = {\n    [23063] = true, -- Dense Dynamite\n    [4054] = true, -- Rough Dynamite\n    [4064] = true, -- Rough Copper Bomb\n    [4061] = true, -- Coarse Dynamite\n    [8331] = true, -- Ez-Thro Dynamite\n    [4065] = true, -- Large Copper Bomb\n    [4066] = true, -- Small Bronze Bomb\n    [4062] = true, -- Heavy Dynamite\n    [4067] = true, -- Big Bronze Bomb\n    [4068] = true, -- Iron Grenade\n    [23000] = true, -- Ez-Thro Dynamite II\n    [12421] = true, -- Mithril Frag Bomb\n    [4069] = true, -- Big Iron Bomb\n    [12562] = true, -- The Big One\n    [12543] = true, -- Hi-Explosive Bomb\n    [19769] = true, -- Thorium Grenade\n    [19784] = true, -- Dark Iron Bomb\n    [30216] = true, -- Fel Iron Bomb\n    [19821] = true, -- Arcane Bomb\n    [39965] = true, -- Frost Grenade\n    [30461] = true, -- The Bigger One\n    [30217] = true, -- Adamantite Grenade\n    [35476] = true, -- Drums of Battle\n    [35475] = true, -- Drums of War\n    [35477] = true, -- Drums of Speed\n    [35478] = true, -- Drums of Restoration\n    [56641] = true, -- Steady Shot (rank 1)\n    [34120] = true, -- Steady Shot (rank 2)\n    [49051] = true, -- Steady Shot (rank 3)\n    [49052] = true, -- Steady Shot (rank 4)\n    [19434] = true, -- Aimed Shot (rank 1)\n    [1464] = true, -- Slam (rank 1)\n    [8820] = true, -- Slam (rank 2)\n    [11604] = true, -- Slam (rank 3)\n    [11605] = true, -- Slam (rank 4)\n    [25241] = true, -- Slam (rank 5)\n    [25242] = true, -- Slam (rank 6)\n    [47474] = true, -- Slam (rank 7)\n    [47475] = true, -- Slam (rank 8)\n    [48467] = true, -- Hurricane (rank 5)\n    [27012] = true, -- Hurricane (rank 4)\n    [17402] = true, -- Hurricane (rank 3)\n    [17401] = true, -- Hurricane (rank 2)\n    [16914] = true, -- Hurricane (rank 1)\n    [12051] = true, -- Evocation\n    [58434] = true, -- Volley (rank 6)\n    [58431] = true, -- Volley (rank 5)\n    [27022] = true, -- Volley (rank 4)\n    [14295] = true, -- Volley (rank 3)\n    [14294] = true, -- Volley (rank 2)\n    [1510] = true, -- Volley (rank 1)\n    --35474 Drums of Panic DO reset the swing timer, do not add\n}\n\nlocal prevent_reset_swing_auras = {\n    [53817] = true, -- Maelstrom Weapon\n}\n\nlocal pause_swing_spells = {\n    [1464] = true, -- Slam (rank 1)\n    [8820] = true, -- Slam (rank 2)\n    [11604] = true, -- Slam (rank 3)\n    [11605] = true, -- Slam (rank 4)\n    [25241] = true, -- Slam (rank 5)\n    [25242] = true, -- Slam (rank 6)\n    [47474] = true, -- Slam (rank 7)\n    [47475] = true, -- Slam (rank 8)\n}\n\nlocal ranged_swing = {\n    [75] = true, -- Auto Shot\n    [3018] = true, -- Shoot\n    [2764] = true, -- Throw\n    [5019] = true, -- Shoot\n}\n\nlocal reset_ranged_swing = {\n    [58433] = true, -- Volley\n    [58432] = true, -- Volley\n    [42234] = true, -- Volley\n    [42245] = true, -- Volley\n    [42244] = true, -- Volley\n    [42243] = true,  -- Volley\n}\n\n-- lib.callbacks = lib.callbacks or LibStub(\"CallbackHandler-1.0\"):New(lib)\n\nfunction lib:Fire(event, ...)\n    WeakAuras.ScanEvents(event, ...)\nend\n\nfunction lib:ADDON_LOADED(_, addOnName)\n    if addOnName ~= MAJOR then\n        return\n    end\n    \n    self.unitGUID = UnitGUID(\"player\")\n    \n    local mainSpeed, offSpeed = UnitAttackSpeed(\"player\")\n    local now = GetTime()\n    \n    self.mainSpeed = mainSpeed\n    self.offSpeed = offSpeed or 0\n    \n    self.lastMainSwing = now\n    self.mainExpirationTime = self.lastMainSwing + self.mainSpeed\n    self.firstMainSwing = false\n    \n    self.lastOffSwing = now\n    self.offExpirationTime = self.lastMainSwing + self.mainSpeed\n    self.firstOffSwing = false\n    \n    self.lastRangedSwing = now\n    self.rangedSpeed = UnitRangedDamage(\"player\") or 0\n    self.rangedExpirationTime = self.lastRangedSwing + self.rangedSpeed\n    \n    self.mainTimer = nil\n    self.offTimer = nil\n    self.rangedTimer = nil\n    self.calculaDeltaTimer = nil\n    \n    self.casting = false\n    self.channeling = false\n    self.isAttacking = false\n    self.preventSwingReset = false\n    self.skipNextAttack = nil\n    self.skipNextAttackCount = 0\n    \n    self.skipNextAttackSpeedUpdate = nil\n    self.skipNextAttackSpeedUpdateCount = 0\nend\n\nlib:ADDON_LOADED(\"\",MAJOR)\n\nfunction lib:CalculateDelta()\n    if self.offSpeed > 0 and self.mainExpirationTime ~= nil and self.offExpirationTime ~= nil then\n        self:Fire(\"SWING_TIMER_DELTA\", self.mainExpirationTime - self.offExpirationTime)\n    end\nend\n\nfunction lib:SwingStart(hand, startTime, isReset)\n    if hand == \"mainhand\" then\n        if self.mainTimer and isReset then\n            self.mainTimer:Cancel()\n        end\n        self.lastMainSwing = startTime\n        local mainSpeed, _ = UnitAttackSpeed(\"player\")\n        self.mainSpeed = mainSpeed\n        self.mainExpirationTime = self.lastMainSwing + self.mainSpeed\n        self:Fire(\"SWING_TIMER_START\", self.mainSpeed, self.mainExpirationTime, hand)\n        if self.mainSpeed > 0 and self.mainExpirationTime - GetTime() > 0 then\n            self.mainTimer = C_Timer.NewTimer(self.mainExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"mainhand\")\n            end)\n        end\n    elseif hand == \"offhand\" then\n        if self.offTimer and isReset then\n            self.offTimer:Cancel()\n        end\n        self.lastOffSwing = startTime\n        local _, offSpeed = UnitAttackSpeed(\"player\")\n        self.offSpeed = offSpeed or 0\n        self.offExpirationTime = self.lastOffSwing + self.offSpeed\n        if self.calculaDeltaTimer then\n            self.calculaDeltaTimer:Cancel()\n        end\n        if self.offSpeed > 0 and self.firstOffSwing == false and self.isAttacking then\n            self.offExpirationTime = self.lastOffSwing + (self.offSpeed / 2)\n            self:CalculateDelta()\n            self:Fire(\"SWING_TIMER_UPDATE\", self.offSpeed, self.offExpirationTime, hand)\n        elseif self.offSpeed > 0 then\n            self:Fire(\"SWING_TIMER_START\", self.offSpeed, self.offExpirationTime, hand)\n            self.calculaDeltaTimer = C_Timer.NewTimer(self.offSpeed / 2, function()\n                    self:CalculateDelta()\n            end)\n        end\n        if self.offSpeed > 0 and self.offExpirationTime - GetTime() > 0 then\n            self.offTimer = C_Timer.NewTimer(self.offExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"offhand\")\n            end)\n        end\n    elseif hand == \"ranged\" then\n        if self.rangedTimer and isReset then\n            self.rangedTimer:Cancel()\n        end\n        self.rangedSpeed = UnitRangedDamage(\"player\") or 0\n        if self.rangedSpeed ~= nil and self.rangedSpeed > 0 then\n            self.rangedSpeed = self.rangedSpeed\n            self.lastRangedSwing = startTime\n            self.rangedExpirationTime = self.lastRangedSwing + self.rangedSpeed\n            self:Fire(\"SWING_TIMER_START\", self.rangedSpeed, self.rangedExpirationTime, hand)\n            if self.rangedExpirationTime - GetTime() > 0 then\n                self.rangedTimer = C_Timer.NewTimer(self.rangedExpirationTime - GetTime(), function()\n                        self:SwingEnd(\"ranged\")\n                end)\n            end\n        end\n    end\nend\n\nfunction lib:SwingEnd(hand)\n    self:Fire(\"SWING_TIMER_STOP\", hand)\n    if (self.casting or self.channeling) and self.isAttacking and hand ~= \"ranged\" then\n        local now = GetTime()\n        self:SwingStart(hand, now, true)\n        self:Fire(\"SWING_TIMER_CLIPPED\", hand)\n    end\nend\n\nfunction lib:SwingTimerInfo(hand)\n    if hand == \"mainhand\" then\n        return self.mainSpeed, self.mainExpirationTime, self.lastMainSwing\n    elseif hand == \"offhand\" then\n        return self.offSpeed, self.offExpirationTime, self.lastOffSwing\n    elseif hand == \"ranged\" then\n        return self.rangedSpeed, self.rangedExpirationTime, self.lastRangedSwing\n    end\nend\n\nfunction lib:COMBAT_LOG_EVENT_UNFILTERED(_, ts, subEvent, _, sourceGUID, _, _, _, destGUID, _, _, _, amount, overkill, _, resisted, _, _, _, _, _, isOffHand)\n    local now = GetTime()\n    if subEvent == \"SPELL_EXTRA_ATTACKS\" and sourceGUID == self.unitGUID then\n        self.skipNextAttack = ts\n        self.skipNextAttackCount = resisted\n    elseif (subEvent == \"SWING_DAMAGE\" or subEvent == \"SWING_MISSED\") and sourceGUID == self.unitGUID then\n        local isOffHand = isOffHand\n        if subEvent == \"SWING_MISSED\" then\n            isOffHand = overkill\n        end\n        if\n        self.skipNextAttack ~= nil\n        and tonumber(self.skipNextAttack)\n        and (ts - self.skipNextAttack) < 0.04\n        and tonumber(self.skipNextAttackCount)\n        and not isOffHand\n        then\n            if self.skipNextAttackCount > 0 then\n                self.skipNextAttackCount = self.skipNextAttackCount - 1\n                return false\n            end\n        end\n        if isOffHand then\n            self.firstOffSwing = true\n            self:SwingStart(\"offhand\", now, false)\n            self:SwingStart(\"ranged\", now, true)\n        else\n            self.firstMainSwing = true\n            self:SwingStart(\"mainhand\", now, false)\n            self:SwingStart(\"ranged\", now, true)\n        end\n    elseif subEvent == \"SWING_MISSED\" and amount ~= nil and amount == \"PARRY\" and destGUID == self.unitGUID then\n        if self.mainTimer then\n            self.mainTimer:Cancel()\n        end\n        local swing_timer_reduced_40p = self.mainExpirationTime - (0.4 * self.mainSpeed)\n        local min_swing_time = 0.2 * self.mainSpeed\n        if swing_timer_reduced_40p < min_swing_time then\n            self.mainExpirationTime = min_swing_time\n        else\n            self.mainExpirationTime = swing_timer_reduced_40p\n        end\n        self:Fire(\"SWING_TIMER_UPDATE\", self.mainSpeed, self.mainExpirationTime, \"mainhand\")\n        if self.mainSpeed > 0 and self.mainExpirationTime - GetTime() > 0 then\n            self.mainTimer = C_Timer.NewTimer(self.mainExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"mainhand\")\n            end)\n        end\n    elseif (subEvent == \"SPELL_AURA_APPLIED\" or subEvent == \"SPELL_AURA_REMOVED\") and sourceGUID == self.unitGUID then\n        local spell = amount\n        if spell and prevent_swing_speed_update[spell] then\n            self.skipNextAttackSpeedUpdate = now\n            self.skipNextAttackSpeedUpdateCount = 2\n        end\n        if spell and prevent_reset_swing_auras[spell] then\n            self.preventSwingReset = subEvent == \"SPELL_AURA_APPLIED\"\n        end\n    elseif (subEvent == \"SPELL_DAMAGE\" or subEvent == \"SPELL_MISSED\") and sourceGUID == self.unitGUID then\n        local spell = amount\n        if reset_ranged_swing[spell] then\n            self:SwingStart(\"ranged\", GetTime(), true)\n        end\n    end\nend\n\nfunction lib:UNIT_ATTACK_SPEED()\n    local now = GetTime()\n    if\n    self.skipNextAttackSpeedUpdate\n    and tonumber(self.skipNextAttackSpeedUpdate)\n    and (now - self.skipNextAttackSpeedUpdate) < 0.04\n    and tonumber(self.skipNextAttackSpeedUpdateCount)\n    then\n        self.skipNextAttackSpeedUpdateCount = self.skipNextAttackSpeedUpdateCount - 1\n        return\n    end\n    if self.mainTimer then\n        self.mainTimer:Cancel()\n    end\n    if self.offTimer then\n        self.offTimer:Cancel()\n    end\n    local mainSpeedNew, offSpeedNew = UnitAttackSpeed(\"player\")\n    offSpeedNew = offSpeedNew or 0\n    if mainSpeedNew > 0 and self.mainSpeed > 0 and mainSpeedNew ~= self.mainSpeed then\n        local multiplier = mainSpeedNew / self.mainSpeed\n        local timeLeft = (self.lastMainSwing + self.mainSpeed - now) * multiplier\n        self.mainSpeed = mainSpeedNew\n        self.mainExpirationTime = now + timeLeft\n        self:Fire(\"SWING_TIMER_UPDATE\", self.mainSpeed, self.mainExpirationTime, \"mainhand\")\n        if self.mainSpeed > 0 and self.mainExpirationTime - GetTime() > 0 then\n            self.mainTimer = C_Timer.NewTimer(self.mainExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"mainhand\")\n            end)\n        end\n    end\n    if offSpeedNew > 0 and self.offSpeed > 0 and offSpeedNew ~= self.offSpeed then\n        local multiplier = offSpeedNew / self.offSpeed\n        local timeLeft = (self.lastOffSwing + self.offSpeed - now) * multiplier\n        self.offSpeed = offSpeedNew\n        self.offExpirationTime = now + timeLeft\n        if self.calculaDeltaTimer ~= nil then\n            self.calculaDeltaTimer:Cancel()\n        end\n        self:Fire(\"SWING_TIMER_UPDATE\", self.offSpeed, self.offExpirationTime, \"offhand\")\n        if self.offSpeed > 0 and self.offExpirationTime - GetTime() > 0 then\n            self.offTimer = C_Timer.NewTimer(self.offExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"offhand\")\n            end)\n        end\n    end\nend\n\nfunction lib:UNIT_SPELLCAST_INTERRUPTED_OR_FAILED(_, _, _, spell)\n    self.casting = false\n    if spell and pause_swing_spells[spell] and self.pauseSwingTime then\n        self.pauseSwingTime = nil\n        if self.mainSpeed > 0 then\n            if self.mainExpirationTime < GetTime() and self.isAttacking then\n                self.mainExpirationTime = self.mainExpirationTime + self.mainSpeed\n            end\n            self:Fire(\"SWING_TIMER_UPDATE\", self.mainSpeed, self.mainExpirationTime, \"mainhand\")\n            self.mainTimer = C_Timer.NewTimer(self.mainExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"mainhand\")\n            end)\n        end\n        if self.offSpeed > 0 then\n            if self.offExpirationTime < GetTime() and self.isAttacking then\n                self.offExpirationTime = self.offExpirationTime + self.offSpeed\n            end\n            self:Fire(\"SWING_TIMER_UPDATE\", self.offSpeed, self.offExpirationTime, \"offhand\")\n            self.offTimer = C_Timer.NewTimer(self.offExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"offhand\")\n            end)\n        end\n    end\nend\nfunction lib:UNIT_SPELLCAST_INTERRUPTED(...)\n    self:UNIT_SPELLCAST_INTERRUPTED_OR_FAILED(...)\nend\nfunction lib:UNIT_SPELLCAST_FAILED(...)\n    self:UNIT_SPELLCAST_INTERRUPTED_OR_FAILED(...)\nend\n\nfunction lib:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spell)\n    local now = GetTime()\n    if spell ~= nil and next_melee_spells[spell] then\n        self:SwingStart(\"mainhand\", now, false)\n        self:SwingStart(\"ranged\", now, true)\n    end\n    if (spell and reset_swing_spells[spell]) or (self.casting and not self.preventSwingReset) then\n        self:SwingStart(\"mainhand\", now, true)\n        self:SwingStart(\"offhand\", now, true)\n        self:SwingStart(\"ranged\", now, not ranged_swing[spell]) -- set reset flag to true if the spell is not in list of ranged swing spells\n    end\n    if spell and pause_swing_spells[spell] and self.pauseSwingTime then\n        local offset = now - self.pauseSwingTime\n        self.pauseSwingTime = nil\n        if self.mainSpeed > 0 then\n            self.mainExpirationTime = self.mainExpirationTime + offset\n            self:Fire(\"SWING_TIMER_UPDATE\", self.mainSpeed, self.mainExpirationTime, \"mainhand\")\n            self.mainTimer = C_Timer.NewTimer(self.mainExpirationTime - now, function()\n                    self:SwingEnd(\"mainhand\")\n            end)\n        end\n        if self.offSpeed > 0 then\n            self.offExpirationTime = self.offExpirationTime + offset\n            self:Fire(\"SWING_TIMER_UPDATE\", self.offSpeed, self.offExpirationTime, \"offhand\")\n            self.offTimer = C_Timer.NewTimer(self.offExpirationTime - now, function()\n                    self:SwingEnd(\"offhand\")\n            end)\n        end\n    end\n    if self.casting and spell ~= 6603 then -- 6603=Auto Attack prevent set casting to false when auto attack is toggle on\n        self.casting = false\n    end\nend\n\nfunction lib:UNIT_SPELLCAST_START(_, unit, _, spell)\n    if spell then\n        local now = GetTime()\n        local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(spell)\n        local endOfCast = now + (castTime / 1000) -- endOfCast is not use anywhere\n        self.casting = true\n        self.preventSwingReset = self.preventSwingReset or noreset_swing_spells[spell]\n        if spell and pause_swing_spells[spell] then\n            self.pauseSwingTime = now\n            if self.mainSpeed > 0 then\n                self:Fire(\"SWING_TIMER_PAUSED\", \"mainhand\")\n                if self.mainTimer then\n                    self.mainTimer:Cancel()\n                end\n            end\n            if self.offSpeed > 0 then\n                self:Fire(\"SWING_TIMER_PAUSED\", \"offhand\")\n                if self.offTimer then\n                    self.offTimer:Cancel()\n                end\n            end\n        end\n    end\nend\n\nfunction lib:UNIT_SPELLCAST_CHANNEL_START(_, _, _, spell)\n    self.casting = true\n    self.channeling = true\n    self.preventSwingReset = noreset_swing_spells[spell]\nend\n\nfunction lib:UNIT_SPELLCAST_CHANNEL_STOP()\n    self.channeling = false\nend\n\nfunction lib:PLAYER_EQUIPMENT_CHANGED(_, equipmentSlot)\n    if equipmentSlot == 16 or equipmentSlot == 17 or equipmentSlot == 18 then\n        local now = GetTime()\n        self:SwingStart(\"mainhand\", now, true)\n        self:SwingStart(\"offhand\", now, true)\n        self:SwingStart(\"ranged\", now, true)\n    end\nend\n\nfunction lib:PLAYER_ENTER_COMBAT()\n    local now = GetTime()\n    self.isAttacking = true\n    if now > (self.offExpirationTime - (self.offSpeed / 2)) then\n        if self.offTimer then\n            self.offTimer:Cancel()\n        end\n        self:SwingStart(\"offhand\", now, true)\n    end\nend\n\nfunction lib:PLAYER_LEAVE_COMBAT()\n    self.isAttacking = false\n    self.firstMainSwing = false\n    self.firstOffSwing = false\nend\n\nframe:RegisterEvent(\"COMBAT_LOG_EVENT_UNFILTERED\")\nframe:RegisterEvent(\"PLAYER_EQUIPMENT_CHANGED\")\nframe:RegisterEvent(\"PLAYER_ENTER_COMBAT\")\nframe:RegisterEvent(\"PLAYER_LEAVE_COMBAT\")\nframe:RegisterUnitEvent(\"UNIT_ATTACK_SPEED\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_START\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_INTERRUPTED\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_FAILED\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_SUCCEEDED\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_CHANNEL_START\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_CHANNEL_STOP\", \"player\")\nframe:RegisterEvent(\"ADDON_LOADED\")\n\nframe:SetScript(\"OnEvent\", function(_, event, ...)\n        if event == \"COMBAT_LOG_EVENT_UNFILTERED\" then\n            lib[event](lib, event, CombatLogGetCurrentEventInfo())\n        else\n            lib[event](lib, event, ...)\n        end\nend)",
					["do_custom"] = true,
				},
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["sparkOffsetY"] = 0,
			["load"] = {
				["use_namerealm"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "HUNTER",
					["multi"] = {
						["HUNTER"] = true,
						["SHAMAN"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["shadowXOffset"] = 1,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["texture"] = "Blizzard",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 30400,
			["alpha"] = 0,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["outline"] = "OUTLINE",
			["sparkOffsetX"] = 0,
			["wagoID"] = "t1O2uIIyf",
			["parent"] = "Swing Timer Fixed",
			["shadowYOffset"] = -1,
			["cooldownSwipe"] = true,
			["sparkRotationMode"] = "AUTO",
			["automaticWidth"] = "Auto",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
						["event"] = "Conditions",
						["use_unit"] = true,
						["custom_type"] = "event",
						["custom"] = "",
						["spellIds"] = {
						},
						["names"] = {
						},
						["events"] = "",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(t)\n    return t[1] or t[3] or t[5] or t[7] or t[8] or t[2]\nend",
				["activeTriggerMode"] = 1,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 59,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["cooldownEdge"] = false,
			["cooldown"] = false,
			["displayIcon"] = "136243",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 30,
			["orientation"] = "HORIZONTAL",
			["zoom"] = 0,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["fontSize"] = 12,
			["source"] = "import",
			["displayText_format_p_time_legacy_floor"] = false,
			["displayText_format_p_time_mod_rate"] = true,
			["customTextUpdate"] = "event",
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["icon"] = false,
			["id"] = "SwingTimerAPI 3",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["justify"] = "LEFT",
			["sparkHeight"] = 30,
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["config"] = {
			},
			["sparkHidden"] = "NEVER",
			["sparkRotation"] = 0,
			["useCooldownModRate"] = true,
			["width"] = 30,
			["authorOptions"] = {
			},
			["uid"] = "E4TdTpsSFpS",
			["inverse"] = false,
			["wordWrap"] = "WordWrap",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Swing Timer Fixed"] = {
			["controlledChildren"] = {
				"Alpha Options 3", -- [1]
				"Swing Timer 3", -- [2]
				"SwingTimerAPI 3", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "t1O2uIIyf",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = -200,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/t1O2uIIyf/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["names"] = {
						},
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 59,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["source"] = "import",
			["scale"] = 1,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 30400,
			["id"] = "Swing Timer Fixed",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["selfPoint"] = "CENTER",
			["uid"] = "3Ve0BMHgtks",
			["config"] = {
			},
			["borderInset"] = 1,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["authorOptions"] = {
			},
		},
		["Swing Timer 3"] = {
			["sparkWidth"] = 16,
			["sparkOffsetX"] = 0,
			["wagoID"] = "t1O2uIIyf",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/t1O2uIIyf/1",
			["icon"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "custom",
						["event"] = "Health",
						["unit"] = "player",
						["customDuration"] = "function()\n    return aura_env.speed, aura_env.expirationTime\nend",
						["spellIds"] = {
						},
						["events"] = "SWING_TIMER_START SWING_TIMER_UPDATE ",
						["custom_type"] = "event",
						["names"] = {
						},
						["custom"] = "function(event, speed, expirationTime, hand)\n    if event ~= \"OPTIONS\" and hand == \"ranged\" and speed ~= nil and expirationTime ~= nil then\n        aura_env.speed = speed\n        aura_env.expirationTime = expirationTime\n        return true\n    else\n        return false\n    end\nend",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["names"] = {
						},
						["type"] = "unit",
						["spellIds"] = {
						},
						["use_alwaystrue"] = true,
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
						["event"] = "Conditions",
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(t)\n    return t[1] or t[2]\nend",
				["activeTriggerMode"] = 1,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 59,
			["selfPoint"] = "CENTER",
			["alpha"] = 1,
			["barColor"] = {
				0.81176470588235, -- [1]
				0.90980392156863, -- [2]
				0.46274509803922, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["parent"] = "Swing Timer Fixed",
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_LEFT",
					["anchorYOffset"] = 0,
					["text_visible"] = false,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [3]
				{
					["text_shadowXOffset"] = 1,
					["text_text_format_t_time_legacy_floor"] = false,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_text_format_t_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = -1,
					["text_visible"] = false,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_text"] = "%t",
					["text_text_format_n_format"] = "none",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_t_time_mod_rate"] = true,
				}, -- [4]
				{
					["border_size"] = 1,
					["border_anchor"] = "fg",
					["type"] = "subborder",
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "Square Full White",
					["border_offset"] = 0,
				}, -- [5]
			},
			["height"] = 20,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.lastRangedSwing = 0\naura_env.speed = UnitRangedDamage(\"player\") or 0\naura_env.expirationTime = aura_env.lastRangedSwing + aura_env.speed\n\n",
					["do_custom"] = true,
				},
			},
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "HUNTER",
					["multi"] = {
						["HUNTER"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["source"] = "import",
			["authorOptions"] = {
			},
			["backgroundColor"] = {
				0.30196078431373, -- [1]
				0.32156862745098, -- [2]
				0.29411764705882, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["uid"] = "CvZeRMYbsyC",
			["zoom"] = 0,
			["sparkDesaturate"] = false,
			["width"] = 261,
			["sparkHeight"] = 30,
			["texture"] = "Melli",
			["spark"] = false,
			["sparkTexture"] = "GarrMission_EncounterBar-Spark",
			["semver"] = "1.0.0",
			["tocversion"] = 30400,
			["sparkHidden"] = "BOTH",
			["id"] = "Swing Timer 3",
			["frameStrata"] = 4,
			["anchorFrameType"] = "SCREEN",
			["icon_side"] = "RIGHT",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = true,
			["version"] = 1,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -1,
						["variable"] = "incombat",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.5, -- [4]
							},
							["property"] = "backgroundColor",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = -1,
						["variable"] = "incombat",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
							["property"] = "barColor",
						}, -- [1]
					},
				}, -- [2]
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["iconSource"] = -1,
		},
		["Alpha Options 3"] = {
			["iconSource"] = 0,
			["xOffset"] = 0,
			["displayText"] = "Alpha Options - Luxthos",
			["yOffset"] = 0,
			["displayText_format_p_time_dynamic"] = false,
			["url"] = "https://wago.io/t1O2uIIyf/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "\n\n",
					["do_custom"] = false,
				},
			},
			["keepAspectRatio"] = false,
			["selfPoint"] = "BOTTOM",
			["desc"] = "",
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
						[57] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "HUNTER",
					["multi"] = {
						["HUNTER"] = true,
						["SHAMAN"] = true,
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["shadowXOffset"] = 1,
			["regionType"] = "icon",
			["blendMode"] = "BLEND",
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 30400,
			["alpha"] = 0,
			["uid"] = "p)SxhM4pTF3",
			["fixedWidth"] = 200,
			["outline"] = "OUTLINE",
			["wagoID"] = "t1O2uIIyf",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["shadowYOffset"] = -1,
			["cooldownSwipe"] = true,
			["customTextUpdate"] = "event",
			["cooldownEdge"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showOnCooldown",
						["subeventPrefix"] = "SPELL",
						["use_genericShowOn"] = true,
						["spellName"] = 0,
						["custom_hide"] = "custom",
						["names"] = {
						},
						["type"] = "custom",
						["use_eventtype"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "timed",
						["spellIds"] = {
						},
						["event"] = "Combat Log",
						["eventtype"] = "PLAYER_REGEN_DISABLED",
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["events"] = "PLAYER_ENTERING_WORLD PLAYER_REGEN_ENABLED PLAYER_REGEN_DISABLED PLAYER_TARGET_CHANGED PLAYER_ALIVE PLAYER_DEAD PLAYER_UNGHOST",
						["custom"] = "function(event, ...)\n    local data = WeakAuras.GetData(aura_env.id)\n    local frame = WeakAuras.GetRegion(data.parent)\n    \n    if frame then\n        local alpha = 1\n        local cfgAlpha = aura_env.config\n        \n        if not UnitAffectingCombat(\"player\") then\n            alpha = cfgAlpha[\"ooc-alpha\"]\n        end\n        \n        if UnitExists(\"target\") then\n            local isEnemy = UnitCanAttack(\"player\", \"target\") or UnitIsEnemy(\"player\", \"target\")\n            \n            if (not isEnemy and cfgAlpha[\"friendly-alpha\"]) or (isEnemy and cfgAlpha[\"enemy-alpha\"]) then\n                alpha = 1\n            end\n        end\n        \n        frame:SetAlpha(alpha)\n        \n        return true\n    end\n    \n    return false\nend\n\n\n",
						["custom_type"] = "event",
						["unit"] = "player",
						["use_track"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["custom"] = "",
						["eventtype"] = "PLAYER_REGEN_DISABLED",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 59,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["discrete_rotation"] = 0,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 32,
			["rotate"] = true,
			["fontSize"] = 12,
			["source"] = "import",
			["mirror"] = false,
			["config"] = {
				["ooc-alpha"] = 1,
				["enemy-alpha"] = false,
				["friendly-alpha"] = false,
			},
			["cooldown"] = false,
			["authorOptions"] = {
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 1,
					["step"] = 0.05,
					["width"] = 2,
					["min"] = 0,
					["key"] = "ooc-alpha",
					["default"] = 1,
					["name"] = "Out of Combat Alpha",
					["desc"] = "Change the alpha of the groups when out of combat.",
				}, -- [1]
				{
					["type"] = "toggle",
					["default"] = true,
					["width"] = 1,
					["name"] = "Ignore on Enemy Target",
					["useDesc"] = true,
					["key"] = "enemy-alpha",
					["desc"] = "Enable to show full opacity on enemy target.",
				}, -- [2]
				{
					["type"] = "toggle",
					["default"] = true,
					["width"] = 1,
					["name"] = "Ignore on Friendly Target",
					["useDesc"] = true,
					["key"] = "friendly-alpha",
					["desc"] = "Enable to show full opacity on friendly target.",
				}, -- [3]
			},
			["displayIcon"] = "136243",
			["automaticWidth"] = "Auto",
			["desaturate"] = false,
			["displayText_format_p_time_precision"] = 1,
			["parent"] = "Swing Timer Fixed",
			["semver"] = "1.0.0",
			["width"] = 32,
			["justify"] = "LEFT",
			["useCooldownModRate"] = true,
			["id"] = "Alpha Options 3",
			["zoom"] = 0,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["wordWrap"] = "WordWrap",
			["icon"] = true,
			["inverse"] = false,
			["anchorPoint"] = "CENTER",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["preferToUpdate"] = false,
		},
	},
	["editor_font_size"] = 12,
	["lastArchiveClear"] = 1665421427,
	["minimap"] = {
		["minimapPos"] = 208.1063254226053,
		["hide"] = false,
	},
	["lastUpgrade"] = 1669379054,
	["dbVersion"] = 59,
	["registered"] = {
	},
	["login_squelch_time"] = 10,
	["frame"] = {
		["xOffset"] = -1543.667053222656,
		["yOffset"] = -146.1669921875,
		["height"] = 942.33349609375,
		["width"] = 892.666748046875,
	},
	["editor_theme"] = "Monokai",
}
