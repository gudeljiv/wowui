local _, xVermin = ...

local CheckDebuff = function(d, unit)
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

local CheckBuff = function(d, unit)
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

local RotationTextureFrame1 = CreateFrame('Frame', 'RotationTextureFrame1', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
RotationTextureFrame1:SetSize(30, 30)
RotationTextureFrame1:SetPoint('TOPLEFT', 0, 40)
RotationTextureFrame1:SetScale(0.4)
RotationTextureFrame1:CreateBeautyBorder(8)
RotationTextureFrame1:SetClampedToScreen(true)
RotationTextureFrame1.texture = RotationTextureFrame1:CreateTexture(nil, 'BACKGROUND')
RotationTextureFrame1.texture:SetSize(RotationTextureFrame1:GetSize())
RotationTextureFrame1.texture:SetPoint('CENTER')
RotationTextureFrame1.texture:SetTexture(GetSpellTexture(78))
RotationTextureFrame1:Hide()

local RotationTextureFrame2 = CreateFrame('Frame', 'RotationTextureFrame2', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
RotationTextureFrame2:SetSize(30, 30)
RotationTextureFrame2:SetPoint('TOPLEFT', 30, 40)
RotationTextureFrame2:SetScale(0.4)
RotationTextureFrame2:CreateBeautyBorder(8)
RotationTextureFrame2:SetClampedToScreen(true)
RotationTextureFrame2.texture = RotationTextureFrame2:CreateTexture(nil, 'BACKGROUND')
RotationTextureFrame2.texture:SetSize(RotationTextureFrame2:GetSize())
RotationTextureFrame2.texture:SetPoint('CENTER')
RotationTextureFrame2.texture:SetTexture(GetSpellTexture(78))
RotationTextureFrame2:Hide()

local RotationTextureFrame3 = CreateFrame('Frame', 'RotationTextureFrame3', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
RotationTextureFrame3:SetSize(30, 30)
RotationTextureFrame3:SetPoint('TOPLEFT', 600, 40)
RotationTextureFrame3:SetScale(0.4)
RotationTextureFrame3:CreateBeautyBorder(8)
RotationTextureFrame3:SetClampedToScreen(true)
RotationTextureFrame3.texture = RotationTextureFrame3:CreateTexture(nil, 'BACKGROUND')
RotationTextureFrame3.texture:SetSize(RotationTextureFrame3:GetSize())
RotationTextureFrame3.texture:SetPoint('CENTER')
RotationTextureFrame3.texture:SetTexture(GetSpellTexture(78))
RotationTextureFrame3:Hide()

local data = {}
local skills = {}
local skill = {}
skills['revenge'] = '#7bd079'

skills['HOW'] = 57623
skills['IT'] = 49909
skills['PS'] = 49921
skills['FS'] = 55268
skills['HB'] = 51411
skills['OB'] = 51425
skills['PES'] = 50842
skills['BS'] = 49930
skills['BT_full'] = 45529

local RTF = function(xframe, xtype, xid)
	local f = _G['RotationTextureFrame' .. xframe]

	if xid == 'clear' then
		f:Hide()
		return
	end

	xid = skills[xid] and skills[xid] or xid

	if xtype == 'GetSpellTexture' or xtype == 1 then
		f.texture:SetTexture(GetSpellTexture(xid))
	end

	if xtype == 'GetItemIcon' or xtype == 2 then
		f.texture:SetTexture(GetItemIcon(xid))
	end

	f:Show()
end
xRTF = RTF

local RTFH = function(xframe)
	local f = _G['RotationTextureFrame' .. xframe]
	f:Hide()
end
xRTFH = RTFH

-- PlayerFrame:HookScript(
-- 	'OnUpdate',
-- 	function()
-- 		if AOE('Heroic Strike') then
-- 			print('aoe')
-- 		else
-- 			print('single target')
-- 		end

-- 		if not InCombatLockdown() then
-- 			return
-- 		end

-- 		data = {
-- 			player = {
-- 				health = {
-- 					current = UnitHealth('player'),
-- 					max = UnitHealthMax('player'),
-- 					percentage = string.format('%.f', UnitHealth('player') / UnitHealthMax('player') * 100)
-- 				},
-- 				mana = {
-- 					current = UnitMana('player'),
-- 					max = UnitManaMax('player'),
-- 					percentage = string.format('%.f', UnitMana('player') / UnitManaMax('player') * 100)
-- 				},
-- 				xp = {
-- 					current = UnitXP('player'),
-- 					max = UnitXPMax('player'),
-- 					percentage = string.format('%.f', UnitXP('player') / UnitXPMax('player') * 100)
-- 				}
-- 			},
-- 			target = {
-- 				health = {
-- 					current = UnitHealth('target'),
-- 					max = UnitHealthMax('target'),
-- 					percentage = string.format('%.f', UnitHealth('target') / UnitHealthMax('target') * 100)
-- 				},
-- 				mana = {
-- 					current = UnitMana('target'),
-- 					max = UnitManaMax('target'),
-- 					percentage = string.format('%.f', UnitMana('target') / UnitManaMax('target') * 100)
-- 				},
-- 				xp = {
-- 					current = UnitXP('target'),
-- 					max = UnitXPMax('target'),
-- 					percentage = string.format('%.f', UnitXP('target') / UnitXPMax('target') * 100)
-- 				}
-- 			},
-- 			pet = {
-- 				health = {
-- 					current = UnitHealth('pet'),
-- 					max = UnitHealthMax('pet'),
-- 					percentage = string.format('%.f', UnitHealth('pet') / UnitHealthMax('pet') * 100)
-- 				},
-- 				mana = {
-- 					current = UnitMana('pet'),
-- 					max = UnitManaMax('pet'),
-- 					percentage = string.format('%.f', UnitMana('pet') / UnitManaMax('pet') * 100)
-- 				},
-- 				xp = {
-- 					current = UnitXP('pet'),
-- 					max = UnitXPMax('pet'),
-- 					percentage = string.format('%.f', UnitXP('pet') / UnitXPMax('pet') * 100)
-- 				}
-- 			}
-- 		}

-- 		-- print('target % ', data.target.xp.current)
-- 		-- RotationFrame6:SetBackdropColor(xVermin.HEX2RGB(skills.revenge).r, xVermin.HEX2RGB(skills.revenge).g, xVermin.HEX2RGB(skills.revenge).b)
-- 		-- print(skills.revenge, xVermin.HEX2RGBraw(skills.revenge).r, xVermin.HEX2RGBraw(skills.revenge).g, xVermin.HEX2RGBraw(skills.revenge).b)

-- 		-- if IsSpellInRange('Revenge', 'target') == 1 and select(1, IsUsableSpell('Revenge')) then
-- 		-- 	RotationFrame6:SetBackdropColor(xVermin.HEX2RGB(skills.revenge))
-- 		-- else
-- 		-- 	RotationFrame6:SetBackdropColor(1, 1, 1, 1)
-- 		-- end
-- 	end
-- )

-- local function Rotation()
-- 	if xVermin.Class ~= 'WARRIOR' then
-- 		return
-- 	end

-- 	if xAOE(10) == 1 and not IsCurrentSpell('Heroic Strike') and UnitPower('player') > 40 then
-- 		if not xVermin.R6_Occupied then
-- 			xVermin.R6_Occupied = true
-- 			RotationFrame6:SetBackdropColor(0, 1, 0.7, 1)
-- 		end
-- 	end

-- 	if xAOE(10) > 1 and not IsCurrentSpell('Cleave') and UnitPower('player') > 40 then
-- 		if not xVermin.R6_Occupied then
-- 			xVermin.R6_Occupied = true
-- 			RotationFrame6:SetBackdropColor(0, 0.2, 0.8, 1)
-- 		end
-- 	end

-- 	if xAOE(10) == 0 or UnitPower('player') < 40 or IsCurrentSpell('Heroic Strike') or IsCurrentSpell('Cleave') then
-- 		xVermin.R6_Occupied = false
-- 	end

-- 	if not xVermin.R6_Occupied then
-- 		RotationFrame6:SetBackdropColor(1, 1, 1, 1)
-- 	end
-- end

-- PlayerFrame:HookScript('OnUpdate', Rotation)
