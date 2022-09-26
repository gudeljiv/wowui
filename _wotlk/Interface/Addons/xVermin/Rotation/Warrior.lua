local _, xVermin = ...

local function CheckDebuff(d, unit)
	for i = 1, 40 do
		local debuff = UnitDebuff(unit, i)
		if debuff then
			if debuff == d then
				return false
			else
				return true
			end
		end
	end
end

local function CheckBuff(d, unit)
	for i = 1, 40 do
		local buff = UnitBuff(unit, i)
		if buff then
			if buff == d then
				return false
			else
				return true
			end
		end
	end
end

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

-- local RotationTextureFrame = CreateFrame('Frame', 'RotationTextureFrame', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
-- RotationTextureFrame:SetSize(30, 30)
-- RotationTextureFrame:SetPoint('CENTER', 200, 50)
-- RotationTextureFrame:CreateBeautyBorder(8)
-- RotationTextureFrame.texture = RotationTextureFrame:CreateTexture(nil, 'BACKGROUND')
-- RotationTextureFrame.texture:SetPoint('CENTER')
-- RotationTextureFrame.texture:SetTexture(GetSpellTexture(78))

local data = {}

local skills = {}
skills['revenge'] = '#89CFF0'

PlayerFrame:HookScript(
	'OnUpdate',
	function()
		-- if AOE('Heroic Strike') then
		-- 	print('aoe')
		-- else
		-- 	print('single target')
		-- end

		-- if not InCombatLockdown() then
		-- 	return
		-- end

		-- data.player.health.current = UnitHealth('player')
		-- data.player.health.max = UnitHealthMax('player')
		-- data.player.health.percentage = string.format('%.f', data.player.health.current / data.player.health.max * 100)
		-- data.player.mana.current = UnitMana('player')
		-- data.player.mana.max = UnitManaMax('player')
		-- data.player.mana.percentage = string.format('%.f', data.player.mana.current / data.player.mana.max * 100)
		-- data.player.xp.current = UnitXP('player')
		-- data.player.xp.max = UnitXPMax('player')
		-- data.player.xp.percentage = string.format('%.f', data.player.xp.current / data.player.xp.max * 100)

		-- data.target.health.current = UnitHealth('target')
		-- data.target.health.max = UnitHealthMax('target')
		-- data.target.health.percentage = string.format('%.f', data.target.health.current / data.target.health.max * 100)
		-- data.target.mana.current = UnitMana('target')
		-- data.target.mana.max = UnitManaMax('target')
		-- data.target.mana.percentage = string.format('%.f', data.target.mana.current / data.target.mana.max * 100)
		-- data.target.xp.current = UnitXP('target')
		-- data.target.xp.max = UnitXPMax('target')
		-- data.target.xp.percentage = string.format('%.f', data.target.xp.current / data.target.xp.max * 100)

		-- data = {
		-- 	player = {
		-- 		health = {
		-- 			current = UnitHealth('player'),
		-- 			max = UnitHealthMax('player'),
		-- 			percentage = string.format('%.f', data.player.health.current / data.player.health.max * 100)
		-- 		},
		-- 		mana = {
		-- 			current = UnitMana('player'),
		-- 			max = UnitManaMax('player'),
		-- 			percentage = string.format('%.f', data.player.mana.current / data.player.mana.max * 100)
		-- 		},
		-- 		xp = {
		-- 			current = UnitXP('player'),
		-- 			max = UnitXPMax('player'),
		-- 			percentage = string.format('%.f', data.player.xp.current / data.player.xp.max * 100)
		-- 		}
		-- 	},
		-- 	target = {
		-- 		health = {
		-- 			current = UnitHealth('target'),
		-- 			max = UnitHealthMax('target'),
		-- 			percentage = string.format('%.f', data.target.health.current / data.target.health.max * 100)
		-- 		},
		-- 		mana = {
		-- 			current = UnitMana('target'),
		-- 			max = UnitManaMax('target'),
		-- 			percentage = string.format('%.f', data.target.mana.current / data.target.mana.max * 100)
		-- 		},
		-- 		xp = {
		-- 			current = UnitXP('target'),
		-- 			max = UnitXPMax('target'),
		-- 			percentage = string.format('%.f', data.target.xp.current / data.target.xp.max * 100)
		-- 		}
		-- 	}
		-- }

		-- print('target % ', data.target.xp.current)
		RotationFrame6:SetBackdropColor(xVermin:hex2rgb(skills.revenge).r, xVermin:hex2rgb(skills.revenge).g, xVermin:hex2rgb(skills.revenge).b, xVermin:hex2rgb(skills.revenge).a)
		-- print(skills.revenge, xVermin:hex2rgb(skills.revenge).r, xVermin:hex2rgb(skills.revenge).g, xVermin:hex2rgb(skills.revenge).b, xVermin:hex2rgb(skills.revenge).a)

		-- if IsSpellInRange('Revenge', 'target') == 1 and select(1, IsUsableSpell('Revenge')) then
		-- 	RotationFrame6:SetBackdropColor(xVermin:hex2rgb(skills.revenge))
		-- else
		-- 	RotationFrame6:SetBackdropColor(1, 1, 1, 1)
		-- end
	end
)
