local _, xVermin = ...

function AOE(type)
	local type = type or "bool"
	local inRange = 0

	for i = 1, 40 do
		if UnitExists("nameplate" .. i) and IsSpellInRange("Cleave", "nameplate" .. i) == 1 then
			inRange = inRange + 1
		end
	end
	if type == "bool" then
		if inRange > 1 then
			return true
		else
			return false
		end
	end
	if type == "number" then
		return inRange
	end
end

local f = CreateFrame("Frame", "RotationFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
f:SetWidth(5)
f:SetHeight(5)
f:ClearAllPoints()
f:SetPoint("RIGHT", CustomContainer_Combat, "LEFT", -5, 0)
f:SetFrameStrata("BACKGROUND")
f:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = "",
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)


PlayerFrame:HookScript(
	"OnUpdate",
	function()
		if InCombatLockdown() then 
			if AOE() then
				f:SetBackdropColor(1, 0, 0, 1)
			else
				f:SetBackdropColor(0, 1, 0, 1)
			end
		else
			f:SetBackdropColor(0, 0, 1, 1)
		end
	end
)

-- local function CheckDebuff(d)
-- 	for i=1,40 do 
-- 		local debuff = UnitDebuff("target",i)
-- 		if debuff then 
-- 			if debuff == d then
-- 				return false
-- 			else
-- 				return true
-- 			end
-- 		end
-- 	end
-- end

-- local function Show()
-- 	if not InCombatLockdown() then return end
	
-- 	t_hp_percentage = tonumber(string.format("%.0f", UnitHealth("target") / UnitHealthMax("target") * 100))

-- 	if not CheckDebuff("Rend") and t_hp_percentage > 20 and not UnitIsDead("target") then
-- 		f:SetBackdropColor(1, 0, 0, 1)
-- 		f:Show()
-- 	else
-- 		f:Hide()
-- 	end
-- end

-- TargetFrame:HookScript("OnUpdate", Show)
-- TargetFrame:HookScript(
-- 	"OnHide",
-- 	function(self)
-- 		f:Hide()
-- 	end
-- )




-- local targetHP = format("%.0f", (UnitHealth("target") / UnitHealthMax("target")) * 100)


-- PlayerFrame:HookScript("OnUpdate", THealthShow)

-- f:RegisterEvent("PLAYER_TARGET_CHANGED")
-- f:RegisterEvent("PLAYER_TARGET_CHANGED")
-- f:SetScript("OnEvent", function(self, event, unit, ...)

-- 	if event == "UNIT_AURA" then
-- 		if unit ~= "target" then return end
-- 		if InCombatLockdown() then return end

-- 		for i=1,40 do 
-- 			local debuff = UnitDebuff("target",i)
-- 			print(debuff)
-- 			if debuff and debuff == "Rend" then 
-- 				print("rend")
-- 			else
-- 				print("no rend")
-- 			end 
-- 		end

-- 	else
-- 		-- Event must be PLAYER_TARGET_CHANGED
-- 		-- since that's the only other event ever registered.
-- 		if UnitCanAttack("player", "target") then
-- 			self:RegisterEvent("UNIT_AURA")
-- 			self:GetScript("OnEvent")(self, "UNIT_AURA", "target")
-- 			self:Show()
-- 		else
-- 			self:Hide()
-- 			self:UnregisterEvent("UNIT_AURA")
-- 		end
-- 	end
-- end)

-- PlayerFrame:HookScript(
-- 	"OnUpdate",
-- 	function()
-- 		-- if Rotation.AOE() then
-- 		-- 	print("aoe")
-- 		-- else
-- 		-- 	print("single target")
-- 		-- end

-- 		if not InCombatLockdown() then return end

-- 		local data = {
-- 			player = {
-- 				health ={ 
-- 					current = UnitHealth("player"),
-- 					max = UnitHealthMax("player"),
-- 					percentage = string.format("%.f", data.player.health.current / data.player.health.max * 100),
-- 				},
-- 				mana ={ 
-- 					current = UnitMana("player"),
-- 					max = UnitManaMax("player"),
-- 					percentage = string.format("%.f", data.player.mana.current / data.player.mana.max * 100),
-- 				},
-- 				xp ={ 
-- 					current = UnitXP("player"),
-- 					max = UnitXPMax("player"),
-- 					percentage = string.format("%.f", data.player.xp.current / data.player.xp.max * 100),
-- 				}
-- 			},
-- 			target = {
-- 				health ={ 
-- 					current = UnitHealth("target"),
-- 					max = UnitHealthMax("target"),
-- 					percentage = string.format("%.f", data.target.health.current / data.target.health.max * 100),
-- 				},
-- 				mana ={ 
-- 					current = UnitMana("target"),
-- 					max = UnitManaMax("target"),
-- 					percentage = string.format("%.f", data.target.mana.current / data.target.mana.max * 100),
-- 				},
-- 				xp ={ 
-- 					current = UnitXP("target"),
-- 					max = UnitXPMax("target"),
-- 					percentage = string.format("%.f", data.target.xp.current / data.target.xp.max * 100),
-- 				}
-- 			}
-- 		}

		


-- 	end
-- )
