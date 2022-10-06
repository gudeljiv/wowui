local _, xVermin = ...

local killcountlist, killcounttotal, names, counts, total, percentages, playerGUID, petGUID
local sortedKillLog = {}
local tStart = time()
local combatTimer = time()
local timeticker = nil
local pullkills, pullxp, totalxp = 0
local xppadding = 45

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

local kc = CreateFrame("Frame", "KillCountFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
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
kc:SetBackdropColor(0, 0, 0, 0.6)
kc:SetFrameStrata("BACKGROUND")
kc:CreateBeautyBorder(6)
kc.isMoving = false

----------------------------
-- Title of the frame
----------------------------
local kctitle = CreateFrame("Frame", "KillCountTitle", kc)
kctitle:SetPoint("TOP", kc, "TOP", 0, -10)
kctitle.text = kctitle:CreateFontString(nil, "ARTWORK")
kctitle.text:SetFont(xVermin.Config.font.arial, 14, "NONE")
kctitle.text:SetPoint("TOP", kctitle, "TOP", 0, 0)
kctitle.text:SetText("Kill Tracker")
kctitle.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
kctitle:SetWidth(kctitle.text:GetStringWidth())
kctitle:SetHeight(kctitle.text:GetStringHeight())

----------------------------
-- Total kills
----------------------------
local kctotal = CreateFrame("Frame", "KillCountTotal", kc)
kctotal:SetPoint("TOPLEFT", kc, "TOPLEFT", 10, -35)
kctotal.text = kctotal:CreateFontString(nil, "ARTWORK")
kctotal.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kctotal.text:SetPoint("TOPLEFT", kctotal, "TOPLEFT", 0, 0)
kctotal.text:SetText("Total: 0")
kctotal.text:SetJustifyH("LEFT")
kctotal.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
kctotal:SetWidth(kctotal.text:GetStringWidth())
kctotal:SetHeight(kctotal.text:GetStringHeight())

----------------------------
-- Timer
----------------------------
local kctimer = CreateFrame("Frame", "KillCountTimer", kc)
kctimer:SetPoint("TOPRIGHT", kc, "TOPRIGHT", -10, -35)
kctimer.text = kctimer:CreateFontString(nil, "ARTWORK")
kctimer.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kctimer.text:SetPoint("TOPRIGHT", kctimer, "TOPRIGHT", 0, 0)
kctimer.text:SetText("00:00")
kctimer.text:SetJustifyH("RIGHT")
kctimer.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
kctimer:SetWidth(kctimer.text:GetStringWidth())
kctimer:SetHeight(kctimer.text:GetStringHeight())

----------------------------
-- Kill list wrapper
----------------------------

local killlist_wrapper = CreateFrame("Frame", "WrapperKillListFrame", kc, BackdropTemplateMixin and "BackdropTemplate")
killlist_wrapper:SetPoint("TOPLEFT", kc, "TOPLEFT", 0, -55)
killlist_wrapper:SetFrameStrata("LOW")
killlist_wrapper:SetBackdropColor(0, 0, 0, 0)

----------------------------
-- Kill list names
----------------------------
local kclistnames = CreateFrame("Frame", "KillCountListNames", kc)
kclistnames:SetPoint("TOPLEFT", kc, "TOPLEFT", 10, -55)
kclistnames.text = kclistnames:CreateFontString(nil, "ARTWORK")
kclistnames.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kclistnames.text:SetPoint("TOPLEFT", kclistnames, "TOPLEFT", 0, 0)
kclistnames.text:SetText("")
kclistnames.text:SetJustifyH("LEFT")
kclistnames.text:SetTextColor(1, 1, 1, 1)

----------------------------
-- Kill list counts
----------------------------
local kclistvalues = CreateFrame("Frame", "KillCountListValues", kc)
kclistvalues:SetPoint("TOPRIGHT", kc, "TOPRIGHT", -10, -55)
kclistvalues.text = kclistvalues:CreateFontString(nil, "ARTWORK")
kclistvalues.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kclistvalues.text:SetPoint("TOPRIGHT", kclistvalues, "TOPRIGHT", 0, 0)
kclistvalues.text:SetText("")
kclistvalues.text:SetJustifyH("RIGHT")
kclistvalues.text:SetTextColor(1, 1, 1, 1)

----------------------------
-- Kill list percentages
----------------------------
local kclistpercentages = CreateFrame("Frame", "KillCountListPercentages", kc)
kclistpercentages:SetPoint("TOPRIGHT", kc, "TOPRIGHT", -10, -55)
kclistpercentages.text = kclistpercentages:CreateFontString(nil, "ARTWORK")
kclistpercentages.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kclistpercentages.text:SetPoint("TOPRIGHT", kclistpercentages, "TOPRIGHT", 0, 0)
kclistpercentages.text:SetText("")
kclistpercentages.text:SetJustifyH("RIGHT")
kclistpercentages.text:SetTextColor(1, 1, 1, 1)
kclistpercentages:Hide()

----------------------------
-- Wrapper frame for reset and timer buttons
----------------------------
local resettimer_wrapper = CreateFrame("Frame", "WrapperResetTimer", kc, BackdropTemplateMixin and "BackdropTemplate")
resettimer_wrapper:SetPoint("BOTTOMLEFT", kc, "BOTTOMLEFT", 0, 10)
resettimer_wrapper:SetFrameStrata("LOW")
resettimer_wrapper:SetBackdropColor(0, 0, 0, 0)

----------------------------
-- Reset data button
----------------------------
local kcreset = CreateFrame("Frame", "KillCountReset", resettimer_wrapper)
kcreset:SetPoint("BOTTOMLEFT", resettimer_wrapper, "BOTTOMLEFT", 10, 0)
kcreset:SetFrameStrata("LOW")
kcreset.text = kcreset:CreateFontString(nil, "ARTWORK")
kcreset.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kcreset.text:SetPoint("BOTTOMLEFT", kcreset, "BOTTOMLEFT", 0, 0)
kcreset.text:SetText("Reset")
kcreset.text:SetTextColor(50 / 255, 200 / 255, 50 / 255, 1)
kcreset:SetWidth(kcreset.text:GetStringWidth())
kcreset:SetHeight(kcreset.text:GetStringHeight())

----------------------------
-- Timer controls
----------------------------
local kctimerstartstop = CreateFrame("Frame", "KillCountTimerStartStop", resettimer_wrapper)
kctimerstartstop:SetPoint("BOTTOMRIGHT", resettimer_wrapper, "BOTTOMRIGHT", -10, 0)
kctimerstartstop:SetFrameStrata("LOW")
kctimerstartstop.text = kctimerstartstop:CreateFontString(nil, "ARTWORK")
kctimerstartstop.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kctimerstartstop.text:SetPoint("BOTTOMRIGHT", kctimerstartstop, "BOTTOMRIGHT", 0, 0)
kctimerstartstop.text:SetText("Stop")
kctimerstartstop.text:SetTextColor(255 / 255, 255 / 255, 255 / 255, 1)
kctimerstartstop:SetWidth(kctimerstartstop.text:GetStringWidth())
kctimerstartstop:SetHeight(kctimerstartstop.text:GetStringHeight())

----------------------------
-- Separation line
----------------------------

local separation_line = resettimer_wrapper:CreateLine()
separation_line:SetColorTexture(1, 1, 1, 0.8)
separation_line:SetThickness(1)
separation_line:SetStartPoint("TOPLEFT", 10, 5)
separation_line:SetEndPoint("TOPRIGHT", -10, 5)

----------------------------
-- Experience per hour
----------------------------

local xpperhourframe_wrapper = CreateFrame("Frame", "XPPerHourWrapper", kc, BackdropTemplateMixin and "BackdropTemplate")
xpperhourframe_wrapper:SetPoint("BOTTOMLEFT", separation_line, "TOPLEFT", 0, 5)
xpperhourframe_wrapper:SetFrameStrata("LOW")
xpperhourframe_wrapper:SetBackdropColor(0, 0, 0, 0)

local xpperhourframe_left = CreateFrame("Frame", "KillCountTimerStartStop", xpperhourframe_wrapper)
xpperhourframe_left:SetPoint("BOTTOMLEFT", xpperhourframe_wrapper, "BOTTOMLEFT", 0, 0)
xpperhourframe_left:SetFrameStrata("LOW")
xpperhourframe_left.text = xpperhourframe_left:CreateFontString(nil, "ARTWORK")
xpperhourframe_left.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
xpperhourframe_left.text:SetPoint("BOTTOMLEFT", xpperhourframe_left, "BOTTOMLEFT", 0, 0)

local xpperhourframe_right = CreateFrame("Frame", "XPPerHourRight", xpperhourframe_wrapper)
xpperhourframe_right:SetPoint("BOTTOMRIGHT", xpperhourframe_wrapper, "BOTTOMRIGHT", 0, 0)
xpperhourframe_right:SetFrameStrata("LOW")
xpperhourframe_right.text = xpperhourframe_right:CreateFontString(nil, "ARTWORK")
xpperhourframe_right.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
xpperhourframe_right.text:SetPoint("BOTTOMRIGHT", xpperhourframe_right, "BOTTOMRIGHT", 0, 0)

----------------------------
-- Total experience in session
----------------------------
local totalxpframe = CreateFrame("Frame", "TotalExperience", kc)
totalxpframe:SetPoint("BOTTOMLEFT", xpperhourframe_wrapper, "BOTTOMLEFT", 0, 15)
totalxpframe:SetFrameStrata("LOW")
totalxpframe.text = totalxpframe:CreateFontString(nil, "ARTWORK")
totalxpframe.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
totalxpframe.text:SetPoint("BOTTOMLEFT", totalxpframe, "BOTTOMLEFT", 0, 0)
totalxpframe.text:SetText("Total experience:")
totalxpframe:SetWidth(totalxpframe.text:GetStringWidth())
totalxpframe:SetHeight(totalxpframe.text:GetStringHeight())

local totalxpframevalue = CreateFrame("Frame", "TotalExperienceValue", kc)
totalxpframevalue:SetPoint("BOTTOMRIGHT", xpperhourframe_wrapper, "BOTTOMRIGHT", 0, 15)
totalxpframevalue:SetFrameStrata("LOW")
totalxpframevalue.text = totalxpframevalue:CreateFontString(nil, "ARTWORK")
totalxpframevalue.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
totalxpframevalue.text:SetPoint("BOTTOMRIGHT", totalxpframevalue, "BOTTOMRIGHT", 0, 0)
totalxpframevalue.text:SetJustifyH("RIGHT")
totalxpframevalue.text:SetText("0")
totalxpframevalue:SetWidth(totalxpframevalue.text:GetStringWidth())
totalxpframevalue:SetHeight(totalxpframevalue.text:GetStringHeight())

----------------------------
-- Experience in one pull
----------------------------
local pullxpframe = CreateFrame("Frame", "PullExperience", kc)
pullxpframe:SetPoint("BOTTOMLEFT", totalxpframe, "BOTTOMLEFT", 0, 15)
pullxpframe:SetFrameStrata("LOW")
pullxpframe.text = pullxpframe:CreateFontString(nil, "ARTWORK")
pullxpframe.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
pullxpframe.text:SetPoint("BOTTOMLEFT", pullxpframe, "BOTTOMLEFT", 0, 0)
pullxpframe.text:SetText("Pull experience:")
pullxpframe:SetWidth(pullxpframe.text:GetStringWidth())
pullxpframe:SetHeight(pullxpframe.text:GetStringHeight())

local pullxpframevalue = CreateFrame("Frame", "PullExperienceValue", kc)
pullxpframevalue:SetPoint("BOTTOMRIGHT", totalxpframevalue, "BOTTOMRIGHT", 0, 15)
pullxpframevalue:SetFrameStrata("LOW")
pullxpframevalue.text = pullxpframevalue:CreateFontString(nil, "ARTWORK")
pullxpframevalue.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
pullxpframevalue.text:SetPoint("BOTTOMRIGHT", pullxpframevalue, "BOTTOMRIGHT", 0, 0)
pullxpframevalue.text:SetJustifyH("RIGHT")
pullxpframevalue.text:SetText("0")
pullxpframevalue:SetWidth(pullxpframevalue.text:GetStringWidth())
pullxpframevalue:SetHeight(pullxpframevalue.text:GetStringHeight())

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- FUNCTIONS --------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function StartTimer()
	tStart = time()
	timeticker =
		C_Timer.NewTicker(
		1,
		function()
			kctimer.text:SetText(xVermin:TimeFormat(time() - tStart))
		end
	)
	kctimerstartstop.text:SetText("Stop")
end

local function StopTimer()
	if timeticker then
		timeticker:Cancel()
	end
	kctimerstartstop.text:SetText("Start")
end

local function RestartTimer()
	kctimer.text:SetText("00:00")
	kctimerstartstop.text:SetText("Stop")
	StopTimer()
	StartTimer()
end

local function ResetTimer()
	kctimer.text:SetText("00:00")
	kctimerstartstop.text:SetText("Stop")
	StopTimer()
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
			if a.count == b.count then
				return a.name < b.name
			end
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
		values = values .. xVermin:FormatNumber(value.count) .. "\n"
		percentages = percentages .. xVermin:Round((value.count / total * 100), 1) .. "%" .. "\n"
	end

	kctotal.text:SetText("Total: " .. total .. " (" .. pullkills .. ")")
	kclistnames.text:SetText(names)
	kclistvalues.text:SetText(values)
	kclistpercentages.text:SetText(percentages)

	pullxpframevalue.text:SetText(xVermin:FormatNumber(xKillCount.experience.pulltotal))
	totalxpframevalue.text:SetText(xVermin:FormatNumber(xKillCount.experience.totaltotal))
	pullxpframevalue:SetSize(pullxpframevalue.text:GetStringWidth(), pullxpframevalue.text:GetStringHeight())
	totalxpframevalue:SetSize(totalxpframevalue.text:GetStringWidth(), totalxpframevalue.text:GetStringHeight())

	local w = math.max(kclistnames.text:GetStringWidth() + kclistpercentages.text:GetStringWidth() + 40, xpperhourframe_wrapper:GetWidth())
	local h = kctitle.text:GetStringHeight() + kctotal.text:GetStringHeight() + kclistnames.text:GetStringHeight() + 86 + xppadding
	kc:SetSize(math.max(w, 270), math.max(h, 125))
	resettimer_wrapper:SetSize(kc:GetWidth(), kcreset.text:GetStringHeight())

	kclistnames:SetSize(kclistnames.text:GetStringWidth(), kclistnames.text:GetStringHeight())
	kclistvalues:SetSize(kclistvalues.text:GetStringWidth(), kclistvalues.text:GetStringHeight())
	kclistpercentages:SetSize(kclistpercentages.text:GetStringWidth(), kclistpercentages.text:GetStringHeight())

	killlist_wrapper:SetSize(kc:GetWidth(), kclistnames.text:GetStringHeight())
end

local XPPERHOUR_MAXXP, XPPERHOUR_XP, XPPERHOUR_TIME
local function CalcXPPerHour()
	XPPERHOUR_MAXXP = XPPERHOUR_MAXXP or UnitXPMax("player")
	XPPERHOUR_XP = XPPERHOUR_XP or UnitXP("player")
	XPPERHOUR_TIME = XPPERHOUR_TIME or time() - 1
	local Time = time() - XPPERHOUR_TIME

	if XPPERHOUR_MAXXP < UnitXPMax("player") then
		XPPERHOUR_XP = XPPERHOUR_XP - XPPERHOUR_MAXXP
		XPPERHOUR_MAXXP = UnitXPMax("player")
	end

	local XP = UnitXP("player") - XPPERHOUR_XP
	local XpPerHour = math.floor(3600 * XP / Time)
	local TimeElapsed = math.floor(Time / 60)
	local UntilDing = XP > 0 and (XPPERHOUR_MAXXP - UnitXP("player")) / (60 * XP / Time) or 0

	local output_left = string.format("|c" .. xVermin.Color.Classes.mage .. "XP/hr|r: %sk", floor(XpPerHour / 100) / 10)
	local output_right = string.format("|c" .. xVermin.Color.yellow .. "Ding:|r %sm  |c" .. xVermin.Color.yellow .. "Time:|r %sm", math.floor(UntilDing), TimeElapsed)

	xpperhourframe_left.text:SetText(output_left)
	xpperhourframe_right.text:SetText(output_right)
	xpperhourframe_wrapper:SetSize(kc:GetWidth() - 20, xpperhourframe_left.text:GetStringHeight())
	xpperhourframe_left:SetSize(xpperhourframe_left.text:GetStringWidth(), xpperhourframe_left.text:GetStringHeight())
	xpperhourframe_right:SetSize(xpperhourframe_right.text:GetStringWidth(), xpperhourframe_right.text:GetStringHeight())
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

	if xKillCount.show then
		kc:ClearAllPoints()
		kc:SetPoint(xKillCount.position.from, (xKillCount.position.anchor and xKillCount.position.anchor or nil), xKillCount.position.to, xKillCount.position.x, xKillCount.position.y)
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
					xKillCount.experience.pulltotal = 0
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

local cxphtimer = nil
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
			pullxpframe:Hide()
			pullxpframevalue:Hide()
			totalxpframe:Hide()
			totalxpframevalue:Hide()
			xpperhourframe_left:Hide()
			xpperhourframe_right:Hide()
			xpperhourframe_wrapper:Hide()
		else
			if event ~= "PLAYER_REGEN_ENABLED" then
				CalculateTotalExperience(event, isInitialLogin, isReloadingUi)
			end
		end

		if event == "PLAYER_REGEN_DISABLED" then
			pullxpframe.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
			totalxpframe.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
		end
		if event == "PLAYER_REGEN_ENABLED" then
			pullxpframe.text:SetTextColor(1, 1, 1, 1)
			totalxpframe.text:SetTextColor(1, 1, 1, 1)
		end

		if not cxphtimer then
			cxphtimer =
				C_Timer.NewTicker(
				1,
				function()
					CalcXPPerHour()
				end
			)
		end

		DisplayData()
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

--------------------------------
-- Move main frame
--------------------------------
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

			local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
			xKillCount.position.from = point
			xKillCount.position.anchor = relativeTo and relativeTo:GetName() or nil
			xKillCount.position.to = relativePoint
			xKillCount.position.x = xOfs
			xKillCount.position.y = yOfs
		end
	end
)

--------------------------------
-- Hide main frame
--------------------------------
kc:SetScript(
	"OnHide",
	function(self)
		if (self.isMoving) then
			self:StopMovingOrSizing()
			self.isMoving = false
		end
	end
)

--------------------------------
-- Show/Hide percentages
--------------------------------
killlist_wrapper:SetScript(
	"OnEnter",
	function()
		kclistvalues:Hide()
		kclistpercentages:Show()
	end
)

killlist_wrapper:SetScript(
	"OnLeave",
	function()
		kclistvalues:Show()
		kclistpercentages:Hide()
	end
)

--------------------------------
-- Reset button click
--------------------------------
kcreset:SetScript(
	"OnMouseDown",
	function(self, button)
		if button == "LeftButton" then
			xKillCount.killLog = {}
			sortedKillLog = {}
			pullkills = 0

			xKillCount.experience.totaltotal = 0
			xKillCount.experience.pulltotal = 0

			XPPERHOUR_MAXXP = UnitXPMax("player")
			XPPERHOUR_XP = UnitXP("player")
			XPPERHOUR_TIME = time() - 1

			ResetTimer()
			DisplayData()
		end
	end
)

--------------------------------
-- Timer button controls
--------------------------------
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

local function kcMessages()
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

	kcMessages()
end
