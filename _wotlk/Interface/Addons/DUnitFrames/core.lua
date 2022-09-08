-- By D4KiR

local HIDDEN = CreateFrame("FRAME", "HIDDEN", UIParent)
HIDDEN:Hide()

function DUFHPHeight()
	local height = DUFGetConfig("hpheight", 27)
	if height >= 28 then
		height = 38
	end
	return height
end

function DUFDottedNumber(num)
	local revnum = tostring(num):reverse()
	local ret = ""
	for i = 0, strlen(revnum), 4 do
		local first = string.sub(revnum, i, i + 3)
		if first ~= nil then
			if i ~= 0 then
				ret = ret .. "."
			end
			ret = ret .. first
		end
	end
	return ret:reverse()
end

hooksecurefunc("UnitFramePortrait_Update", function(self)
	if self.unit == nil or self.portrait == nil then return end

	--if self:GetName() == "TargetFrameToT" then return end -- IMPORTANT

	if self.dufsetportrai then return end
	self.dufsetportrai = true

	if UnitIsPlayer(self.unit) then
		local class, classEng, classID = UnitClass(self.unit)
		local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
		if t then
			if DUFGetConfig("portraitmode") ~= "Default" then
				if DUFGetConfig("portraitmode") ~= "Old" then
					self.portrait:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-CLASSES-CIRCLES-"  .. DUFGetConfig("portraitmode", "New"))
					self.portrait:SetTexCoord(unpack(t))
				elseif DUFGetConfig("portraitmode") == "Old" then
					self.portrait:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-CLASSES-CIRCLES-OLD")
					self.portrait:SetTexCoord(unpack(t))
				else
					self.portrait:SetTexCoord(0, 1, 0, 1)
				end
			else
				self.portrait:SetTexCoord(0, 1, 0, 1)
			end
		else
			self.portrait:SetTexCoord(0, 1, 0, 1)
		end
	else
		self.portrait:SetTexCoord(0, 1, 0, 1)
	end

	if self.unit == "player" and ComboPointPlayerFrame then
		if DUFGetConfig("hidecombopoints", false) then
			ComboPointPlayerFrame:SetParent(HIDDEN)
		end
	end

	self.dufsetportrai = false
end)

function DUFClamp(va, mi, ma)
	if va < mi then
		va = mi
	elseif va > ma then
		va = ma
	end
	return va
end

local f = CreateFrame("Frame")
PlayerFrame.a = 0
function f.Think()
	if DUFGetConfig("hidewhenfull", false) then
		local powernotfull = false

		local manacur = UnitPower("PLAYER", Enum.PowerType.Mana)
		local manamax = UnitPowerMax("PLAYER", Enum.PowerType.Mana)
		if manacur and manacur < manamax then
			powernotfull = true
		end

		local energiecur = UnitPower("PLAYER", Enum.PowerType.Energy)
		local energiemax = UnitPowerMax("PLAYER", Enum.PowerType.Energy)
		if energiecur and energiecur < energiemax then
			powernotfull = true
		end

		if not powernotfull and UnitHealth("PLAYER") >= UnitHealthMax("PLAYER") and
		not UnitExists("TARGET") and
		not MouseIsOver(PlayerFrame) then
			PlayerFrame.a = PlayerFrame.a - 0.05
		else
			PlayerFrame.a = PlayerFrame.a + 0.05
		end
		PlayerFrame.a = DUFClamp(PlayerFrame.a, 0, 1)
		PlayerFrame:SetAlpha(PlayerFrame.a)
	else
		if PlayerFrame.a ~= 1 then
			PlayerFrame.a = 1
			PlayerFrame:SetAlpha(1)
		end
	end
	C_Timer.After(0.02, f.Think)
end
f.Think()