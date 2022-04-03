local _, xVermin = ...

local function TradeSkillFunc(frame)

	-- Make the tradeskill frame double-wide
	UIPanelWindows["TradeSkillFrame"] = {area = "override", pushable = 1, xoffset = -16, yoffset = 12, bottomClampOverride = 140 + 12, width = 714, height = 487, whileDead = 1}

	-- Size the tradeskill frame
	_G["TradeSkillFrame"]:SetWidth(714)
	_G["TradeSkillFrame"]:SetHeight(487)

	-- Adjust title text
	_G["TradeSkillFrameTitleText"]:ClearAllPoints()
	_G["TradeSkillFrameTitleText"]:SetPoint("TOP", _G["TradeSkillFrame"], "TOP", 0, -18)

	-- Expand the tradeskill list to full height
	_G["TradeSkillListScrollFrame"]:ClearAllPoints()
	_G["TradeSkillListScrollFrame"]:SetPoint("TOPLEFT", _G["TradeSkillFrame"], "TOPLEFT", 25, -75)
	_G["TradeSkillListScrollFrame"]:SetSize(295, 336)

	-- Create additional list rows
	local oldTradeSkillsDisplayed = TRADE_SKILLS_DISPLAYED

	-- Position existing buttons
	for i = 1 + 1, TRADE_SKILLS_DISPLAYED do
		_G["TradeSkillSkill" .. i]:ClearAllPoints()
		_G["TradeSkillSkill" .. i]:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i-1)], "BOTTOMLEFT", 0, 1)
	end

	-- Create and position new buttons
	_G.TRADE_SKILLS_DISPLAYED = _G.TRADE_SKILLS_DISPLAYED + 14
	for i = oldTradeSkillsDisplayed + 1, TRADE_SKILLS_DISPLAYED do
		local button = CreateFrame("Button", "TradeSkillSkill" .. i, TradeSkillFrame, "TradeSkillSkillButtonTemplate")
		button:SetID(i)
		button:Hide()
		button:ClearAllPoints()
		button:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i-1)], "BOTTOMLEFT", 0, 1)
	end

	-- Set highlight bar width when shown
	hooksecurefunc(_G["TradeSkillHighlightFrame"], "Show", function()
		_G["TradeSkillHighlightFrame"]:SetWidth(290)
	end)

	-- Move the tradeskill detail frame to the right and stretch it to full height
	_G["TradeSkillDetailScrollFrame"]:ClearAllPoints()
	_G["TradeSkillDetailScrollFrame"]:SetPoint("TOPLEFT", _G["TradeSkillFrame"], "TOPLEFT", 352, -74)
	_G["TradeSkillDetailScrollFrame"]:SetSize(298, 336)
	-- _G["TradeSkillReagent1"]:SetHeight(500) -- Debug

	-- Hide detail scroll frame textures
	_G["TradeSkillDetailScrollFrameTop"]:SetAlpha(0)
	_G["TradeSkillDetailScrollFrameBottom"]:SetAlpha(0)

	-- Create texture for skills list
	local RecipeInset = _G["TradeSkillFrame"]:CreateTexture(nil, "ARTWORK")
	RecipeInset:SetSize(304, 361)
	RecipeInset:SetPoint("TOPLEFT", _G["TradeSkillFrame"], "TOPLEFT", 16, -72)
	RecipeInset:SetTexture("Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg")

	-- Set detail frame backdrop
	local DetailsInset = _G["TradeSkillFrame"]:CreateTexture(nil, "ARTWORK")
	DetailsInset:SetSize(302, 339)
	DetailsInset:SetPoint("TOPLEFT", _G["TradeSkillFrame"], "TOPLEFT", 348, -72)
	DetailsInset:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated")

	-- Hide expand tab (left of All button)
	_G["TradeSkillExpandTabLeft"]:Hide()

	-- Get tradeskill frame textures
	local regions = {_G["TradeSkillFrame"]:GetRegions()}

	-- Set top left texture
	regions[2]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
	regions[2]:SetSize(512, 512)

	-- Set top right texture
	regions[3]:ClearAllPoints()
	regions[3]:SetPoint("TOPLEFT", regions[2], "TOPRIGHT", 0, 0)
	regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
	regions[3]:SetSize(256, 512)

	-- Hide bottom left and bottom right textures
	regions[4]:Hide()
	regions[5]:Hide()

	-- Hide skills list dividing bar
	regions[9]:Hide()
	regions[10]:Hide()

	-- Move create button row
	_G["TradeSkillCreateButton"]:ClearAllPoints()
	_G["TradeSkillCreateButton"]:SetPoint("RIGHT", _G["TradeSkillCancelButton"], "LEFT", -1, 0)

	-- Position and size close button
	_G["TradeSkillCancelButton"]:SetSize(80, 22)
	_G["TradeSkillCancelButton"]:SetText(CLOSE)
	_G["TradeSkillCancelButton"]:ClearAllPoints()
	_G["TradeSkillCancelButton"]:SetPoint("BOTTOMRIGHT", _G["TradeSkillFrame"], "BOTTOMRIGHT", -42, 54)

	-- Position close box
	_G["TradeSkillFrameCloseButton"]:ClearAllPoints()
	_G["TradeSkillFrameCloseButton"]:SetPoint("TOPRIGHT", _G["TradeSkillFrame"], "TOPRIGHT", -30, -8)

	-- Position dropdown menus
	TradeSkillInvSlotDropDown:ClearAllPoints()
	TradeSkillInvSlotDropDown:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 510, -40)
	TradeSkillSubClassDropDown:ClearAllPoints()
	TradeSkillSubClassDropDown:SetPoint("RIGHT", TradeSkillInvSlotDropDown, "LEFT", 0, 0)

	-- Classic Profession Filter addon fixes
	if IsAddOnLoaded("ClassicProfessionFilter") and TradeSkillFrame.SearchBox and TradeSkillFrame.HaveMats and TradeSkillFrame.HaveMats.text then
		TradeSkillFrame.SearchBox:ClearAllPoints()
		TradeSkillFrame.SearchBox:SetPoint("LEFT", TradeSkillRankFrame, "RIGHT", 20, -10)

		TradeSkillFrame.HaveMats:ClearAllPoints()
		TradeSkillFrame.HaveMats:SetPoint("LEFT", TradeSkillFrame.SearchBox, "RIGHT", 10, 8)
		TradeSkillFrame.HaveMats.text:SetText(L["Have mats?"])
		TradeSkillFrame.HaveMats:SetHitRectInsets(0, -TradeSkillFrame.HaveMats.text:GetStringWidth() + 4, 0, 0)
		TradeSkillFrame.HaveMats.text:SetJustifyH("LEFT")
		TradeSkillFrame.HaveMats.text:SetWordWrap(false)
		if TradeSkillFrame.HaveMats.text:GetWidth() > 80 then
			TradeSkillFrame.HaveMats.text:SetWidth(80)
			TradeSkillFrame.HaveMats:SetHitRectInsets(0, -80 + 4, 0, 0)
		end

		TradeSkillFrame.SearchMats:ClearAllPoints()
		TradeSkillFrame.SearchMats:SetPoint("BOTTOMLEFT", TradeSkillFrame.HaveMats, "BOTTOMLEFT", 0, -16)
		TradeSkillFrame.SearchMats.text:SetText(L["Search mats?"])
		TradeSkillFrame.SearchMats:SetHitRectInsets(0, -TradeSkillFrame.SearchMats.text:GetStringWidth() + 2, 0, 0)
		TradeSkillFrame.SearchMats.text:SetJustifyH("LEFT")
		TradeSkillFrame.SearchMats.text:SetWordWrap(false)
		if TradeSkillFrame.SearchMats.text:GetWidth() > 80 then
			TradeSkillFrame.SearchMats.text:SetWidth(80)
			TradeSkillFrame.SearchMats:SetHitRectInsets(0, -80 + 4, 0, 0)
		end
	end

end

-- Run function when TradeSkill UI has loaded
if IsAddOnLoaded("Blizzard_TradeSkillUI") then
	TradeSkillFunc("TradeSkill")
else
	local f = CreateFrame("FRAME")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function(self, event, arg1)
		if arg1 == "Blizzard_TradeSkillUI" then
			TradeSkillFunc("TradeSkill")
			f:UnregisterAllEvents()
		end
	end)
end