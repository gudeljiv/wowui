local _, xVermin = ...

local killcountlist, killcounttotal, names, counts, total, percentages, playerGUID, petGUID
local sortedKillLog = {}
local tStart = time()
local combatTimer = time()
local timeticker = nil
local pullkills, pullxp, totalxp = 0
local xppadding = 20

local defaults = {
	show = false,
	position = {from = "TOPLEFT", anchor = "UIParent", to = "TOPLEFT", x = 5, y = -350},
	killLog = {},
	experience = {totaltotal = 0, pulltotal = 0}
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- FRAMES -----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

kc = CreateFrame("Frame", "KillCountFrame", UIParent)
kc:SetWidth(100)
kc:SetHeight(200)
kc:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 5, -350)
kc:SetFrameStrata("LOW")
kc:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = "",
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
kc:SetBackdropColor(0, 0, 0, 0.4)
kc:SetFrameStrata("BACKGROUND")
kc:CreateBeautyBorder(6)

local kctitle = CreateFrame("Frame", "KillCountTitle", kc)
kctitle:SetPoint("TOP", kc, "TOP", 0, -10)
kctitle:SetWidth(1)
kctitle:SetHeight(1)
kctitle.text = kctitle:CreateFontString(nil, "ARTWORK")
kctitle.text:SetFont(xVermin.Config.font.arial, 14, "NONE")
kctitle.text:SetPoint("TOP", kctitle, "TOP", 0, 0)
kctitle.text:SetText("Kill Tracker")
kctitle.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

local kctotal = CreateFrame("Frame", "KillCountTotal", kc)
kctotal:SetPoint("TOPLEFT", kc, "TOPLEFT", 10, -35)
kctotal:SetWidth(1)
kctotal:SetHeight(1)
kctotal.text = kctotal:CreateFontString(nil, "ARTWORK")
kctotal.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kctotal.text:SetPoint("TOPLEFT", kctotal, "TOPLEFT", 0, 0)
kctotal.text:SetText("Total: 0")
kctotal.text:SetJustifyH("LEFT")
kctotal.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

local kctimer = CreateFrame("Frame", "KillCountTimer", kc)
kctimer:SetPoint("TOPRIGHT", kc, "TOPRIGHT", -10, -35)
kctimer:SetWidth(1)
kctimer:SetHeight(1)
kctimer.text = kctimer:CreateFontString(nil, "ARTWORK")
kctimer.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kctimer.text:SetPoint("TOPRIGHT", kctimer, "TOPRIGHT", 0, 0)
kctimer.text:SetText("00:00")
kctimer.text:SetJustifyH("RIGHT")
kctimer.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

local kclistnames = CreateFrame("Frame", "KillCountListNames", kc)
kclistnames:SetPoint("TOPLEFT", kc, "TOPLEFT", 10, -55)
kclistnames:SetWidth(1)
kclistnames:SetHeight(1)
kclistnames.text = kclistnames:CreateFontString(nil, "ARTWORK")
kclistnames.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kclistnames.text:SetPoint("TOPLEFT", kclistnames, "TOPLEFT", 0, 0)
kclistnames.text:SetText("")
kclistnames.text:SetJustifyH("LEFT")
kclistnames.text:SetTextColor(1, 1, 1, 1)

local kclistvalues = CreateFrame("Frame", "KillCountListValues", kc)
kclistvalues:SetPoint("TOPRIGHT", kc, "TOPRIGHT", -10, -55)
kclistvalues:SetWidth(1)
kclistvalues:SetHeight(1)
kclistvalues.text = kclistvalues:CreateFontString(nil, "ARTWORK")
kclistvalues.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kclistvalues.text:SetPoint("TOPRIGHT", kclistvalues, "TOPRIGHT", 0, 0)
kclistvalues.text:SetText("")
kclistvalues.text:SetJustifyH("RIGHT")
kclistvalues.text:SetTextColor(1, 1, 1, 1)

local kclistpercentages = CreateFrame("Frame", "KillCountListPercentages", kc)
kclistpercentages:SetPoint("TOPRIGHT", kc, "TOPRIGHT", -10, -55)
kclistpercentages:SetWidth(1)
kclistpercentages:SetHeight(1)
kclistpercentages.text = kclistpercentages:CreateFontString(nil, "ARTWORK")
kclistpercentages.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kclistpercentages.text:SetPoint("TOPRIGHT", kclistpercentages, "TOPRIGHT", 0, 0)
kclistpercentages.text:SetText("")
kclistpercentages.text:SetJustifyH("RIGHT")
kclistpercentages.text:SetTextColor(1, 1, 1, 1)
kclistpercentages:Hide()

local kctimerstartstop = CreateFrame("Frame", "KillCountTimerStartStop", kc)
kctimerstartstop:SetPoint("BOTTOMRIGHT", kc, "BOTTOMRIGHT", -10, 10)
kctimerstartstop:SetFrameStrata("LOW")
kctimerstartstop.text = kctimerstartstop:CreateFontString(nil, "ARTWORK")
kctimerstartstop.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kctimerstartstop.text:SetPoint("BOTTOMRIGHT", kctimerstartstop, "BOTTOMRIGHT", 0, 0)
kctimerstartstop.text:SetText("Stop")
kctimerstartstop.text:SetTextColor(220 / 255, 0 / 255, 100 / 255, 1)
kctimerstartstop:SetWidth(kctimerstartstop.text:GetStringWidth())
kctimerstartstop:SetHeight(kctimerstartstop.text:GetStringHeight())

local kcreset = CreateFrame("Frame", "KillCountReset", kc)
kcreset:SetPoint("BOTTOMLEFT", kc, "BOTTOMLEFT", 10, 30)
kcreset:SetFrameStrata("LOW")
kcreset.text = kcreset:CreateFontString(nil, "ARTWORK")
kcreset.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kcreset.text:SetPoint("BOTTOMLEFT", kcreset, "BOTTOMLEFT", 0, 0)
kcreset.text:SetText("Reset")
kcreset.text:SetTextColor(50 / 255, 200 / 255, 50 / 255, 1)
kcreset:SetWidth(kcreset.text:GetStringWidth())
kcreset:SetHeight(kcreset.text:GetStringHeight())

local pullxp = CreateFrame("Frame", "PullExperience", kc)
pullxp:SetPoint("BOTTOMLEFT", kc, "BOTTOMLEFT", 10, 20)
pullxp:SetFrameStrata("LOW")
pullxp.text = pullxp:CreateFontString(nil, "ARTWORK")
pullxp.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
pullxp.text:SetPoint("BOTTOMLEFT", pullxp, "BOTTOMLEFT", 0, 0)
pullxp.text:SetText("Pull experience:")

local pullxpvalue = CreateFrame("Frame", "PullExperienceValue", kc)
pullxpvalue:SetPoint("BOTTOMRIGHT", kc, "BOTTOMRIGHT", -10, 20)
pullxpvalue:SetFrameStrata("LOW")
pullxpvalue.text = pullxpvalue:CreateFontString(nil, "ARTWORK")
pullxpvalue.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
pullxpvalue.text:SetPoint("BOTTOMRIGHT", pullxpvalue, "BOTTOMRIGHT", 0, 0)
pullxpvalue.text:SetJustifyH("RIGHT")
pullxpvalue.text:SetText("0")

local totalxp = CreateFrame("Frame", "TotalExperience", kc)
totalxp:SetPoint("BOTTOMLEFT", kc, "BOTTOMLEFT", 10, 10)
totalxp:SetFrameStrata("LOW")
totalxp.text = totalxp:CreateFontString(nil, "ARTWORK")
totalxp.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
totalxp.text:SetPoint("BOTTOMLEFT", totalxp, "BOTTOMLEFT", 0, 0)
totalxp.text:SetText("Total experience:")

local totalxpvalue = CreateFrame("Frame", "TotalExperienceValue", kc)
totalxpvalue:SetPoint("BOTTOMRIGHT", kc, "BOTTOMRIGHT", -10, 10)
totalxpvalue:SetFrameStrata("LOW")
totalxpvalue.text = pullxpvalue:CreateFontString(nil, "ARTWORK")
totalxpvalue.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
totalxpvalue.text:SetPoint("BOTTOMRIGHT", totalxpvalue, "BOTTOMRIGHT", 0, 0)
totalxpvalue.text:SetJustifyH("RIGHT")
totalxpvalue.text:SetText("0")

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- FUNCTIONS --------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function StopTimer()
	if timeticker then
		timeticker:Cancel()
	end
	kctimerstartstop.text:SetText("Start")
end

local function StartTimer()
	timeticker =
		C_Timer.NewTicker(
		1,
		function()
			kctimer.text:SetText(xVermin:TimeFormat(time() - tStart))
		end
	)
	kctimerstartstop.text:SetText("Stop")
end

local function RestartTimer()
	kctimer.text:SetText("00:00")
	kctimerstartstop.text:SetText("Stop")
	StopTimer()
	tStart = time()
	StartTimer()
end

local function SortData()
	sortedKillLog = {}
	for k, v in pairs(xKillCount.killLog) do
		table.insert(
			sortedKillLog,
			{
				name = v.name,
				count = v.count
			}
		)
	end

	table.sort(
		sortedKillLog,
		function(a, b)
			return a.count > b.count
		end
	)
end

local function SendToTable(name, source)
	if (xKillCount.killLog[name] ~= nil) then
		xKillCount.killLog[name].count = xKillCount.killLog[name].count + 1
	else
		xKillCount.killLog[name] = {
			name = name,
			count = 1
		}
	end

	pullkills = pullkills + 1

	SortData()
end

local function DisplayData()
	if xKillCount.show then
		kc:ClearAllPoints()
		kc:SetPoint(xKillCount.position.from, (xKillCount.position.anchor and xKillCount.position.anchor or nil), xKillCount.position.to, xKillCount.position.x, xKillCount.position.y)
		kc:Show()
	else
		kc:Hide()
		return
	end

	names = ""
	values = ""
	percentages = ""
	total = 0

	for key, value in pairs(sortedKillLog) do
		total = total + value.count
	end

	for key, value in pairs(sortedKillLog) do
		names = names .. value.name .. "\n"
		values = values .. value.count .. "\n"
		percentages = percentages .. xVermin:Round((value.count / total * 100), 1) .. "%" .. "\n"
	end

	kctotal.text:SetText("Total: " .. total .. " (" .. pullkills .. ")")
	kclistnames.text:SetText(names)
	kclistvalues.text:SetText(values)
	kclistpercentages.text:SetText(percentages)

	totalxpvalue.text:SetText("Total experience: " .. xKillCount.experience.totaltotal)
	pullxpvalue.text:SetText("Pull experience: " .. xKillCount.experience.pulltotal)

	local w = kclistnames.text:GetStringWidth() + kclistpercentages.text:GetStringWidth() + 40
	local h = kctitle.text:GetStringHeight() + kctotal.text:GetStringHeight() + kclistnames.text:GetStringHeight() + 80 + xppadding
	kc:SetSize(math.max(w, 250), math.max(h, 125))
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- LOADING ----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function OnAddonLoaded()
	if not xKillCount or xKillCount == nil then
		xKillCount = {}
	end

	for setting, value in pairs(defaults) do
		if xKillCount[setting] == nil then
			xKillCount[setting] = value
		end
	end

	SortData()
	DisplayData()
	StopTimer()
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- ADDON EVENTS -----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

kc:RegisterEvent("ADDON_LOADED")
kc:RegisterEvent("PLAYER_REGEN_DISABLED")
kc:RegisterEvent("PLAYER_REGEN_ENABLED")
kc:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

kc:SetScript(
	"OnEvent",
	function(self, event, ...)
		local args = {...}
		if event == "ADDON_LOADED" then
			if args[1] == "xVermin" then
				OnAddonLoaded()
			end
		end

		if xKillCount and xKillCount.show then
			if event == "PLAYER_REGEN_DISABLED" then
				if time() - combatTimer > 3 then
					pullkills = 0
					combatTimer = time()
				end
				kc:EnableMouse(false)
				kc:SetMovable(false)
			end

			if event == "PLAYER_REGEN_ENABLED" then
				kc:EnableMouse(true)
				kc:SetMovable(true)
			end

			if event == "COMBAT_LOG_EVENT_UNFILTERED" then
				local _, eventType, _, sourceGUID, sourceName, _, _, destGUID, destName = CombatLogGetCurrentEventInfo()
				local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand
				local spellId, spellName, spellSchool

				if UnitExists("pet") and sourceGUID == UnitGUID("pet") then
					if eventType == "SWING_DAMAGE" then
						amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, CombatLogGetCurrentEventInfo())
					elseif eventType == "SPELL_DAMAGE" then
						spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, CombatLogGetCurrentEventInfo())
					end

					if (overkill and overkill ~= -1) then
						SendToTable(destName, "pet")
						combatTimer = time()
					end
				else
					if (eventType == "PARTY_KILL" and sourceGUID == UnitGUID("player")) then
						SendToTable(destName, "player")
						combatTimer = time()
					end
				end
			end

			DisplayData()
		end
	end
)

------------------------------
-- Calculate XP
------------------------------
local gained = 0
local maxxp, currentxp

local function CalculateTotalExperience(event, isInitialLogin, isReloadingUi)
	if event == "PLAYER_REGEN_DISABLED" then
		if time() - combatTimer > 3 then
			xKillCount.experience.pulltotal = 0
			combatTimer = time()
		end
	end
	if event == "PLAYER_ENTERING_WORLD" and (isInitialLogin or isReloadingUi) then
		xKillCount.experience.pulltotal = 0
		maxxp = UnitXPMax("player")
		currentxp = UnitXP("player")
	else
		newxp = UnitXP("player")
		if event == "PLAYER_LEVEL_CHANGED" then
			gained = maxxp - currentxp + newxp
			maxxp = UnitXPMax("player")
		else
			gained = newxp - currentxp
		end
		xKillCount.experience.totaltotal = xKillCount.experience.totaltotal + gained
		xKillCount.experience.pulltotal = xKillCount.experience.pulltotal + gained

		currentxp = newxp

		DisplayData()
	end
end

local experience = CreateFrame("Frame")
experience:RegisterEvent("PLAYER_XP_UPDATE")
experience:RegisterEvent("PLAYER_LEVEL_CHANGED")
experience:RegisterEvent("PLAYER_ENTERING_WORLD")
experience:RegisterEvent("PLAYER_REGEN_DISABLED")
experience:RegisterEvent("PLAYER_REGEN_ENABLED")
experience:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if UnitLevel("player") == MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
			xppadding = 0
			pullxp:Hide()
			totalxp:Hide()
		else
			if event ~= "PLAYER_REGEN_ENABLED" then
				pullxp:Show()
				totalxp:Show()
				CalculateTotalExperience(event, isInitialLogin, isReloadingUi)
			end
		end

		if event == "PLAYER_REGEN_DISABLED" then
			pullxp.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
			totalxp.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
		end
		if event == "PLAYER_REGEN_ENABLED" then
			pullxp.text:SetTextColor(1, 1, 1, 1)
			totalxp.text:SetTextColor(1, 1, 1, 1)
		end
	end
)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- FRAME EVENTS -----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

kc:EnableMouse(true)
kc:SetMovable(true)
kc:SetClampedToScreen(true)

kc:SetScript(
	"OnMouseDown",
	function(self, button)
		if button == "LeftButton" and not self.isMoving then
			self:StartMoving()
			self.isMoving = true
		end
	end
)

kc:SetScript(
	"OnMouseUp",
	function(self, button)
		if button == "LeftButton" and self.isMoving then
			self:StopMovingOrSizing()
			self.isMoving = false
		end
		local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
		xKillCount.position.from = point
		xKillCount.position.anchor = relativeTo and relativeTo:GetName() or nil
		xKillCount.position.to = relativePoint
		xKillCount.position.x = xOfs
		xKillCount.position.y = yOfs
	end
)

kc:SetScript(
	"OnHide",
	function(self)
		if (self.isMoving) then
			self:StopMovingOrSizing()
			self.isMoving = false
		end
	end
)

kc:SetScript(
	"OnEnter",
	function()
		kclistvalues:Hide()
		kclistpercentages:Show()
	end
)

kc:SetScript(
	"OnLeave",
	function()
		kclistvalues:Show()
		kclistpercentages:Hide()
	end
)

kcreset:SetScript(
	"OnMouseDown",
	function(self, button)
		if button == "LeftButton" then
			xKillCount.killLog = {}
			sortedKillLog = {}
			pullkills = 0

			xKillCount.experience.totaltotal = 0
			xKillCount.experience.pulltotal = 0

			DisplayData()
		end
	end
)

kctimerstartstop:SetScript(
	"OnMouseDown",
	function(self, button)
		if button == "LeftButton" then
			if (not timeticker or (timeticker and timeticker:IsCancelled())) then
				RestartTimer()
			else
				StopTimer()
			end
		end
	end
)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- SLASH COMMAND ----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function Print()
	ChatFrame1:AddMessage("\124cffFFFF00(show/hide)\124r Show/Hide KillCount window: " .. (xKillCount.show and "\124cff00FF00show\124r" or "\124cffFF0000show\124r") .. "/" .. (not xKillCount.show and "\124cff00FF00hide\124r" or "\124cffFF0000hide\124r"))
	ChatFrame1:AddMessage("\124cffFFFF00(reset)\124r Reset KillCount window position")
end

SLASH_kc_settings1 = "/kc"
SlashCmdList["kc_settings"] = function(msg)
	ChatFrame1Tab:Click()
	if (msg == "reset") then
		for setting, value in pairs(defaults) do
			xKillCount[setting] = value
		end
	end
	if (msg == "show") then
		xKillCount.show = true
		DisplayData()
		kc:Show()
	end
	if (msg == "hide") then
		xKillCount.show = false
		kc:Hide()
	end

	Print()
end
