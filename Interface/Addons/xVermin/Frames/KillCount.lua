local _, xVermin = ...

local killcountlist, killcounttotal, names, counts, total, percentages
local sortedKillLog = {}
local killLog = {}

local _, class, _ = UnitClass("player")
local color = RAID_CLASS_COLORS[class]
if class == "SHAMAN" then
	color = {
		b = 0.86666476726532,
		g = 0.4392147064209,
		r = 0
	}
end

local defaults = {}
defaults = {
	show = true,
	position = {from = "TOPLEFT", anchor = "UIParent", to = "TOPLEFT", x = 5, y = -350},
	killLog = {}
}

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

kc:EnableMouse(true)
kc:SetMovable(true)
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

local kctitle = CreateFrame("Frame", "KillCountTitle", kc)
kctitle:SetPoint("CENTER", kc, "CENTER", 0, 0)
kctitle:SetWidth(1)
kctitle:SetHeight(1)
kctitle.text = kctitle:CreateFontString(nil, "ARTWORK")
kctitle.text:SetFont(xVermin.Config.font.arial, 14, "NONE")
kctitle.text:SetPoint("TOP", kc, "TOP", 0, -10)
kctitle.text:SetText("Kill Tracker")
kctitle.text:SetTextColor(color.r, color.g, color.b, 1)

local kctotal = CreateFrame("Frame", "KillCountTotal", kc)
kctotal:SetPoint("CENTER", kc, "CENTER", 0, 0)
kctotal:SetWidth(1)
kctotal:SetHeight(1)
kctotal.text = kctotal:CreateFontString(nil, "ARTWORK")
kctotal.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kctotal.text:SetPoint("TOP", kc, "TOP", 0, -30)
kctotal.text:SetText("Total: 0")
kctotal.text:SetTextColor(color.r, color.g, color.b, 1)

local kclistnames = CreateFrame("Frame", "KillCountListNames", kc)
kclistnames:SetPoint("LEFT", kc, "LEFT", 0, 0)
kclistnames:SetWidth(1)
kclistnames:SetHeight(1)
kclistnames.text = kclistnames:CreateFontString(nil, "ARTWORK")
kclistnames.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kclistnames.text:SetPoint("TOPLEFT", kc, "TOPLEFT", 10, -50)
kclistnames.text:SetText("")
kclistnames.text:SetJustifyH("LEFT")
kclistnames.text:SetTextColor(1, 1, 1, 1)

local kclistvalues = CreateFrame("Frame", "KillCountListValues", kc)
kclistvalues:SetPoint("RIGHT", kc, "RIGHT", 0, 0)
kclistvalues:SetWidth(1)
kclistvalues:SetHeight(1)
kclistvalues.text = kclistvalues:CreateFontString(nil, "ARTWORK")
kclistvalues.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kclistvalues.text:SetPoint("TOPRIGHT", kc, "TOPRIGHT", -10, -50)
kclistvalues.text:SetText("")
kclistvalues.text:SetJustifyH("RIGHT")
kclistvalues.text:SetTextColor(1, 1, 1, 1)

local kclistpercentages = CreateFrame("Frame", "KillCountListValues", kc)
kclistpercentages:SetPoint("RIGHT", kc, "RIGHT", 0, 0)
kclistpercentages:SetWidth(1)
kclistpercentages:SetHeight(1)
kclistpercentages.text = kclistpercentages:CreateFontString(nil, "ARTWORK")
kclistpercentages.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kclistpercentages.text:SetPoint("TOPRIGHT", kc, "TOPRIGHT", -10, -50)
kclistpercentages.text:SetText("")
kclistpercentages.text:SetJustifyH("RIGHT")
kclistpercentages.text:SetTextColor(1, 1, 1, 1)
kclistpercentages:Hide()

local kcreset = CreateFrame("Frame", "KillCountReset", kc)
kcreset:SetPoint("BOTTOM", kc, "BOTTOM", 0, 10)
kcreset:SetFrameStrata("MEDIUM")
kcreset.text = kcreset:CreateFontString(nil, "ARTWORK")
kcreset.text:SetFont(xVermin.Config.font.arial, 14, "NONE")
kcreset.text:SetPoint("BOTTOM", kc, "BOTTOM", 0, 10)
kcreset.text:SetText("Reset")
kcreset.text:SetTextColor(0.2, 0.8, 0.2, 1)
kcreset:SetWidth(kcreset.text:GetStringWidth())
kcreset:SetHeight(kcreset.text:GetStringHeight())

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

local function SendToTable(name)
	if (xKillCount.killLog[name] ~= nil) then
		xKillCount.killLog[name].count = xKillCount.killLog[name].count + 1
	else
		xKillCount.killLog[name] = {
			name = name,
			count = 1
		}
	end

	SortData()
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

local function DisplayData()
	names = ""
	counts = ""
	percentages = ""
	total = 0

	for key, value in pairs(sortedKillLog) do
		total = total + value.count
	end

	for key, value in pairs(sortedKillLog) do
		names = names .. value.name .. "\n"
		counts = counts .. value.count .. "\n"
		percentages = percentages .. xVermin:Round((value.count / total * 100), 1) .. "%" .. "\n"
	end

	kctotal.text:SetText("Total: " .. total)
	kclistnames.text:SetText(names)
	kclistvalues.text:SetText(counts)
	kclistpercentages.text:SetText(percentages)

	local w = kclistnames.text:GetStringWidth() + kclistpercentages.text:GetStringWidth() + 20
	local h = kctitle.text:GetStringHeight() + kctotal.text:GetStringHeight() + kclistnames.text:GetStringHeight() + 75
	kc:SetSize(math.max(w, 150), math.max(h, 85))

	if xKillCount and xKillCount.show then
		kc:ClearAllPoints()
		kc:SetPoint(xKillCount.position.from, (xKillCount.position.anchor and xKillCount.position.anchor or nil), xKillCount.position.to, xKillCount.position.x, xKillCount.position.y)
		kc:Show()
	else
		kc:Hide()
	end
end

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
end

kc:RegisterEvent("ADDON_LOADED")
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
		local _, eventType, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()

		-- problem imam sa petom
		-- or ((class == "HUNTER" or class == "WARLOCK") and eventType == "UNIT_DIED")
		if (eventType == "PARTY_KILL" and sourceName == UnitName("player")) then
			SendToTable(destName)
			DisplayData()
		end
	end
)

kcreset:SetScript(
	"OnMouseDown",
	function(self, button)
		if button == "LeftButton" then
			xKillCount.killLog = {}
			sortedKillLog = {}
			DisplayData()
		end
	end
)

DisplayData()

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
	end
	if (msg == "hide") then
		xKillCount.show = false
	end

	Print()
	DisplayData()
end
