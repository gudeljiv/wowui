local _, xVermin = ...

-- ============================================================
--  PetTargetMarker
--  Vizualno oznacava nameplate moba kojeg tvoj pet targetira.
--  Radi za Huntera i Warlocka.
-- ============================================================

local ADDON = "PetTargetMarker"

-- Glow boja po klasi (R, G, B, A)
local GLOW_COLOR = {
	HUNTER = { 0.67, 0.83, 0.45, 1 }, -- zelena
	WARLOCK = { 0.58, 0.51, 0.79, 1 }, -- ljubicasta
}
-- ProcGlow postavke
local GLOW_START_ANIM = true -- animacija pri pojavi
local GLOW_DURATION = 1 -- trajanje jednog loopa (sekunde)

-- ============================================================

local eventFrame = CreateFrame("Frame")
-- [npFrame] = frame na kojeg je glow aktivan (PlaterAnchorFrame ili npFrame)
local glowFrames = {}

-- Keširan LCG handle (Blizzard ga bundla u nekim verzijama)
local LCG = nil
local function GetLCG()
	if LCG then
		return LCG
	end
	if LibStub then
		LCG = LibStub("LibCustomGlow-1.0", true)
	end
	return LCG
end

-- Vraca Plater-ov health bar frame ako postoji, inace root nameplate frame
local function GetGlowFrame(npFrame)
	return npFrame.PlaterAnchorFrame or npFrame
end

-- ============================================================
--  Glow on/off
-- ============================================================
local function StartGlow(npFrame)
	if glowFrames[npFrame] then
		return
	end
	local lib = GetLCG()
	if not lib then
		return
	end
	local _, class = UnitClass("player")
	local color = GLOW_COLOR[class] or { 1, 1, 0, 1 }

	local gf = GetGlowFrame(npFrame)

	lib.ProcGlow_Start(gf, {
		color = color,
		startAnim = GLOW_START_ANIM,
		duration = GLOW_DURATION,
		key = ADDON,
	})
	glowFrames[npFrame] = gf
end

local function StopGlow(npFrame)
	local gf = glowFrames[npFrame]
	if not gf then
		return
	end
	local lib = GetLCG()
	if lib then
		lib.ProcGlow_Stop(gf, ADDON)
	end
	glowFrames[npFrame] = nil
end

-- ============================================================
--  Markiranje / odmarkiranje jednog nameplate
-- ============================================================
local function MarkAsTarget(npFrame, yes)
	if yes then
		StartGlow(npFrame)
	else
		StopGlow(npFrame)
	end
end

-- ============================================================
--  Provjeri klasu igrac - da li ima peta
-- ============================================================
local function PlayerHasPet()
	local _, class = UnitClass("player")
	if class ~= "HUNTER" and class ~= "WARLOCK" then
		return false
	end
	return UnitExists("pet")
end

-- ============================================================
--  Glavna update funkcija — prolazi sve vidljive nameplate
-- ============================================================
local function UpdateAllNameplates()
	if not PlayerHasPet() then
		for npFrame in pairs(glowFrames) do
			StopGlow(npFrame)
		end
		return
	end

	-- Proci kroz sve nameplate unitove (max 40)
	for i = 1, 40 do
		local unit = "nameplate" .. i
		if UnitExists(unit) then
			local npFrame = C_NamePlate and C_NamePlate.GetNamePlateForUnit(unit)
			if npFrame then
				local isPetTarget = UnitIsUnit(unit, "pettarget")
				MarkAsTarget(npFrame, isPetTarget)
			end
		end
	end
end

-- ============================================================
--  Cleanup kad nameplate nestane
-- ============================================================
local function CleanupNameplate(npFrame)
	StopGlow(npFrame)
end

-- ============================================================
--  Event handler
-- ============================================================
-- eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
-- eventFrame:RegisterEvent("PLAYER_LOGIN")
-- eventFrame:RegisterEvent("UNIT_TARGET") -- pet promijenio target
-- eventFrame:RegisterEvent("UNIT_PET") -- pet se pojavio / nestao
-- eventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
-- eventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")

-- eventFrame:SetScript("OnEvent", function(self, event, unit, ...)
-- 	if event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then
-- 		-- Reset
-- 		wipe(glowFrames)
-- 		UpdateAllNameplates()
-- 	elseif event == "UNIT_TARGET" then
-- 		-- Samo nas zanima kada pet promijeni target
-- 		if unit == "pet" then
-- 			UpdateAllNameplates()
-- 		end
-- 	elseif event == "UNIT_PET" then
-- 		-- Pet se pojavio ili nestao
-- 		UpdateAllNameplates()
-- 	elseif event == "NAME_PLATE_UNIT_ADDED" then
-- 		-- Nova nameplate — provjeri je li pet target
-- 		if PlayerHasPet() then
-- 			local npFrame = C_NamePlate and C_NamePlate.GetNamePlateForUnit(unit)
-- 			if npFrame then
-- 				local isPetTarget = UnitIsUnit(unit, "pettarget")
-- 				MarkAsTarget(npFrame, isPetTarget)
-- 			end
-- 		end
-- 	elseif event == "NAME_PLATE_UNIT_REMOVED" then
-- 		-- Nameplate nestala — pocisti
-- 		local npFrame = C_NamePlate and C_NamePlate.GetNamePlateForUnit(unit)
-- 		if npFrame then
-- 			CleanupNameplate(npFrame)
-- 		end
-- 	end
-- end)

-- ============================================================
--  Slash komanda za reload / debug
-- ============================================================
SLASH_PTMARKER1 = "/ptm"
SlashCmdList["PTMARKER"] = function(msg)
	msg = msg:lower()
	if msg == "reload" then
		ReloadUI()
	else
		-- Mali status ispis
		local hasPet = PlayerHasPet()
		local ptName = hasPet and UnitName("pettarget") or "—"
		local petName = hasPet and UnitName("pet") or "—"
		print(string.format("|cff00ff96[PetTargetMarker]|r Pet: %s  |  Pet target: %s", petName, ptName))
	end
end

print("|cff00ff96[PetTargetMarker]|r Ucitan. Komanda: /ptm")
