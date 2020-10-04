local _, xVermin = ...

local killcountlist, killcounttotal, names, counts, total
local tempKillLog = {}
local sortedKillLog = {}

local _, class, _ = UnitClass("player")
local color = RAID_CLASS_COLORS[class]
if class == "SHAMAN" then
	color = {
		b = 0.86666476726532,
		g = 0.4392147064209,
		r = 0
	}
end

kcc = CreateFrame("Frame", "KillCountContainer", UIParent)
kcc:SetWidth(100)
kcc:SetHeight(200)
kcc:SetPoint("TOPRIGHT", MonkeyQuestFrame, "BOTTOMRIGHT", 0, -5)

kc = CreateFrame("Frame", "KillCount", kcc)
kc:SetWidth(100)
kc:SetHeight(200)
kc:SetPoint("TOPRIGHT", MonkeyQuestFrame, "BOTTOMRIGHT", 0, -5)
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
kclistnames.text:SetPoint("TOPLEFT", kc, "TOPLEFT", 5, -50)
kclistnames.text:SetText("")
kclistnames.text:SetJustifyH("LEFT")
kclistnames.text:SetTextColor(1, 1, 1, 1)

local kclistvalues = CreateFrame("Frame", "KillCountListValues", kc)
kclistvalues:SetPoint("RIGHT", kc, "RIGHT", 0, 0)
kclistvalues:SetWidth(1)
kclistvalues:SetHeight(1)
kclistvalues.text = kclistvalues:CreateFontString(nil, "ARTWORK")
kclistvalues.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
kclistvalues.text:SetPoint("TOPRIGHT", kc, "TOPRIGHT", -5, -50)
kclistvalues.text:SetText("")
kclistvalues.text:SetJustifyH("RIGHT")
kclistvalues.text:SetTextColor(1, 1, 1, 1)

local kcreset = CreateFrame("Frame", "KillCountReset", kc)
kcreset:SetPoint("BOTTOM", kc, "BOTTOM", 0, 10)
kcreset:SetFrameStrata("HIGH")
kcreset.text = kcreset:CreateFontString(nil, "ARTWORK")
kcreset.text:SetFont(xVermin.Config.font.arial, 14, "NONE")
kcreset.text:SetPoint("BOTTOM", kc, "BOTTOM", 0, 10)
kcreset.text:SetText("Reset")
kcreset.text:SetTextColor(0.2, 0.8, 0.2, 1)
kcreset:SetWidth(kcreset.text:GetStringWidth())
kcreset:SetHeight(kcreset.text:GetStringHeight())

local function SendToTable(name)
	if (tempKillLog[name] ~= nil) then
		tempKillLog[name].count = tempKillLog[name].count + 1
	else
		tempKillLog[name] = {
			name = name,
			count = 1
		}
	end

	sortedKillLog = {}
	for k, v in pairs(tempKillLog) do
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
	total = 0

	for key, value in pairs(sortedKillLog) do
		names = names .. value.name .. "\n"
		counts = counts .. value.count .. "\n"
		total = total + value.count
	end

	kctotal.text:SetText("Total: " .. total)
	kclistnames.text:SetText(names)
	kclistvalues.text:SetText(counts)

	-- kc:SetSize((kclistnames.text:GetStringWidth() + kclistvalues.text:GetStringWidth()), kclistnames.text:GetStringHeight())
	-- print("W: " .. kclistnames.text:GetStringWidth() + kclistvalues.text:GetStringWidth())
	-- print("H: " .. kctitle.text:GetStringHeight() + kctotal.text:GetStringHeight() + kclistnames.text:GetStringHeight())

	local w = kclistnames.text:GetStringWidth() + kclistvalues.text:GetStringWidth() + 20
	local h = kctitle.text:GetStringHeight() + kctotal.text:GetStringHeight() + kclistnames.text:GetStringHeight() + 75
	kc:SetSize(math.max(w, 150), math.max(h, 85))
end

kc:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
kc:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		local _, eventType, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
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
			sortedKillLog = {}
			DisplayData()
		end
	end
)

DisplayData()
