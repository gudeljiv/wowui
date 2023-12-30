local _, xVermin = ...

local function CraftFunc()
	-- Make the craft frame double-wide
	UIPanelWindows['CraftFrame'] = {area = 'override', pushable = 1, xoffset = -16, yoffset = 12, bottomClampOverride = 140 + 12, width = 714, height = 487, whileDead = 1}

	-- Size the craft frame
	_G['CraftFrame']:SetWidth(714)
	_G['CraftFrame']:SetHeight(487)

	-- Adjust title text
	_G['CraftFrameTitleText']:ClearAllPoints()
	_G['CraftFrameTitleText']:SetPoint('TOP', _G['CraftFrame'], 'TOP', 0, -18)

	-- Expand the crafting list to full height
	_G['CraftListScrollFrame']:ClearAllPoints()
	_G['CraftListScrollFrame']:SetPoint('TOPLEFT', _G['CraftFrame'], 'TOPLEFT', 25, -75)
	_G['CraftListScrollFrame']:SetSize(295, 336)

	-- Create additional list rows
	local oldCraftsDisplayed = CRAFTS_DISPLAYED

	-- Position existing buttons
	_G['Craft1Cost']:ClearAllPoints()
	_G['Craft1Cost']:SetPoint('RIGHT', _G['Craft1'], 'RIGHT', -30, 0)
	for i = 1 + 1, CRAFTS_DISPLAYED do
		_G['Craft' .. i]:ClearAllPoints()
		_G['Craft' .. i]:SetPoint('TOPLEFT', _G['Craft' .. (i - 1)], 'BOTTOMLEFT', 0, 1)
		_G['Craft' .. i .. 'Cost']:ClearAllPoints()
		_G['Craft' .. i .. 'Cost']:SetPoint('RIGHT', _G['Craft' .. i], 'RIGHT', -30, 0)
	end

	-- Create and position new buttons
	_G.CRAFTS_DISPLAYED = _G.CRAFTS_DISPLAYED + 14
	for i = oldCraftsDisplayed + 1, CRAFTS_DISPLAYED do
		local button = CreateFrame('Button', 'Craft' .. i, CraftFrame, 'CraftButtonTemplate')
		button:SetID(i)
		button:Hide()
		button:ClearAllPoints()
		button:SetPoint('TOPLEFT', _G['Craft' .. (i - 1)], 'BOTTOMLEFT', 0, 1)
		_G['Craft' .. i .. 'Cost']:ClearAllPoints()
		_G['Craft' .. i .. 'Cost']:SetPoint('RIGHT', _G['Craft' .. i], 'RIGHT', -30, 0)
	end

	-- Move craft frame points (such as Beast Training)
	CraftFramePointsLabel:ClearAllPoints()
	CraftFramePointsLabel:SetPoint('TOPLEFT', CraftFrame, 'TOPLEFT', 100, -50)
	CraftFramePointsText:ClearAllPoints()
	CraftFramePointsText:SetPoint('LEFT', CraftFramePointsLabel, 'RIGHT', 3, 0)

	-- Fix default UI bug causing training points to show in profession frames
	hooksecurefunc(
		CraftFramePointsText,
		'Show',
		function()
			if CraftRankFrame:IsShown() then
				CraftFramePointsLabel:Hide()
				CraftFramePointsText:Hide()
			end
		end
	)

	-- Set highlight bar width when shown
	hooksecurefunc(
		_G['CraftHighlightFrame'],
		'Show',
		function()
			_G['CraftHighlightFrame']:SetWidth(290)
		end
	)

	-- Move the craft detail frame to the right and stretch it to full height
	_G['CraftDetailScrollFrame']:ClearAllPoints()
	_G['CraftDetailScrollFrame']:SetPoint('TOPLEFT', _G['CraftFrame'], 'TOPLEFT', 352, -74)
	_G['CraftDetailScrollFrame']:SetSize(298, 336)
	-- _G["CraftReagent1"]:SetHeight(500) -- Debug

	-- Hide detail scroll frame textures
	_G['CraftDetailScrollFrameTop']:SetAlpha(0)
	_G['CraftDetailScrollFrameBottom']:SetAlpha(0)

	-- Create texture for skills list
	local RecipeInset = _G['CraftFrame']:CreateTexture(nil, 'ARTWORK')
	RecipeInset:SetSize(304, 361)
	RecipeInset:SetPoint('TOPLEFT', _G['CraftFrame'], 'TOPLEFT', 16, -72)
	RecipeInset:SetTexture('Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg')

	-- Set detail frame backdrop
	local DetailsInset = _G['CraftFrame']:CreateTexture(nil, 'ARTWORK')
	DetailsInset:SetSize(302, 339)
	DetailsInset:SetPoint('TOPLEFT', _G['CraftFrame'], 'TOPLEFT', 348, -72)
	DetailsInset:SetTexture('Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated')

	-- Hide expand tab (left of All button)
	_G['CraftExpandTabLeft']:Hide()

	-- Get craft frame textures
	local regions = {_G['CraftFrame']:GetRegions()}

	-- Set top left texture
	regions[2]:SetTexture('Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left')
	regions[2]:SetSize(512, 512)

	-- Set top right texture
	regions[3]:ClearAllPoints()
	regions[3]:SetPoint('TOPLEFT', regions[2], 'TOPRIGHT', 0, 0)
	regions[3]:SetTexture('Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right')
	regions[3]:SetSize(256, 512)

	-- Hide bottom left and bottom right textures
	regions[4]:Hide()
	regions[5]:Hide()

	-- Hide skills list dividing bar
	regions[9]:Hide()
	regions[10]:Hide()

	-- Move create button row
	_G['CraftCreateButton']:ClearAllPoints()
	_G['CraftCreateButton']:SetPoint('RIGHT', _G['CraftCancelButton'], 'LEFT', -1, 0)

	-- Position and size close button
	_G['CraftCancelButton']:SetSize(80, 22)
	_G['CraftCancelButton']:SetText(CLOSE)
	_G['CraftCancelButton']:ClearAllPoints()
	_G['CraftCancelButton']:SetPoint('BOTTOMRIGHT', _G['CraftFrame'], 'BOTTOMRIGHT', -42, 54)

	-- Position close box
	_G['CraftFrameCloseButton']:ClearAllPoints()
	_G['CraftFrameCloseButton']:SetPoint('TOPRIGHT', _G['CraftFrame'], 'TOPRIGHT', -30, -8)

	-- Position dropdown menu
	CraftFrameFilterDropDown:ClearAllPoints()
	CraftFrameFilterDropDown:ClearAllPoints()
	CraftFrameFilterDropDown:SetPoint('TOPLEFT', CraftFrame, 'TOPLEFT', 510, -40)

	-- ElvUI fixes
	local function ElvUIFixes()
		local E = unpack(ElvUI)
		if E.private.skins.blizzard.enable and E.private.skins.blizzard.craft then
			regions[2]:Hide()
			regions[3]:Hide()
			RecipeInset:Hide()
			DetailsInset:Hide()
			_G['CraftFrame']:SetHeight(512)
			_G['CraftCancelButton']:ClearAllPoints()
			_G['CraftCancelButton']:SetPoint('BOTTOMRIGHT', _G['CraftFrame'], 'BOTTOMRIGHT', -42, 78)
			_G['CraftRankFrame']:ClearAllPoints()
			_G['CraftRankFrame']:SetPoint('TOPLEFT', _G['CraftFrame'], 'TOPLEFT', 24, -44)
		end
	end

	-- Run ElvUI fixes when ElvUI has loaded
	if IsAddOnLoaded('ElvUI') then
		ElvUIFixes()
	else
		local waitFrame = CreateFrame('FRAME')
		waitFrame:RegisterEvent('ADDON_LOADED')
		waitFrame:SetScript(
			'OnEvent',
			function(self, event, arg1)
				if arg1 == 'ElvUI' then
					ElvUIFixes()
					waitFrame:UnregisterAllEvents()
				end
			end
		)
	end

	-- Fix for CraftMaster moving the craft create button
	hooksecurefunc(
		CraftCreateButton,
		'SetFrameLevel',
		function()
			CraftCreateButton:ClearAllPoints()
			CraftCreateButton:SetPoint('RIGHT', CraftCancelButton, 'LEFT', -1, 0)
		end
	)

	-- Classic Profession Filter addon fixes
	if IsAddOnLoaded('ClassicProfessionFilter') and CraftFrame.SearchBox and CraftFrame.HaveMats and CraftFrame.HaveMats.text and CraftFrame.SearchMats and CraftFrame.SearchMats.text then
		CraftFrame.SearchBox:ClearAllPoints()
		CraftFrame.SearchBox:SetPoint('LEFT', CraftRankFrame, 'RIGHT', 20, -10)

		CraftFrame.HaveMats:ClearAllPoints()
		CraftFrame.HaveMats:SetPoint('LEFT', CraftFrame.SearchBox, 'RIGHT', 10, 8)
		CraftFrame.HaveMats.text:SetText(L['Have mats?'])
		CraftFrame.HaveMats:SetHitRectInsets(0, -CraftFrame.HaveMats.text:GetStringWidth() + 4, 0, 0)
		CraftFrame.HaveMats.text:SetJustifyH('LEFT')
		CraftFrame.HaveMats.text:SetWordWrap(false)
		if CraftFrame.HaveMats.text:GetWidth() > 80 then
			CraftFrame.HaveMats.text:SetWidth(80)
			CraftFrame.HaveMats:SetHitRectInsets(0, -80 + 4, 0, 0)
		end

		CraftFrame.SearchMats:ClearAllPoints()
		CraftFrame.SearchMats:SetPoint('BOTTOMLEFT', CraftFrame.HaveMats, 'BOTTOMLEFT', 0, -16)
		CraftFrame.SearchMats.text:SetText(L['Search mats?'])
		CraftFrame.SearchMats:SetHitRectInsets(0, -CraftFrame.SearchMats.text:GetStringWidth() + 2, 0, 0)
		CraftFrame.SearchMats.text:SetJustifyH('LEFT')
		CraftFrame.SearchMats.text:SetWordWrap(false)
		if CraftFrame.SearchMats.text:GetWidth() > 80 then
			CraftFrame.SearchMats.text:SetWidth(80)
			CraftFrame.SearchMats:SetHitRectInsets(0, -80 + 4, 0, 0)
		end
	end
end

-- -- Run function when Craft UI has loaded
-- if IsAddOnLoaded('Blizzard_CraftUI') then
-- 	CraftFunc()
-- else
-- 	local waitFrame = CreateFrame('FRAME')
-- 	waitFrame:RegisterEvent('ADDON_LOADED')
-- 	waitFrame:SetScript(
-- 		'OnEvent',
-- 		function(self, event, arg1)
-- 			if arg1 == 'Blizzard_CraftUI' then
-- 				CraftFunc()
-- 				waitFrame:UnregisterAllEvents()
-- 			end
-- 		end
-- 	)
-- end

local function CraftReagent()
	for i = 1, 40 do
		local frame = _G['CraftReagent' .. i .. 'Count']
		if frame then
			frame:SetScale(0.6)
		end
	end
end

-- -- Run function when Craft UI has loaded
if IsAddOnLoaded('Blizzard_CraftUI') then
	CraftReagent()
else
	local waitFrame = CreateFrame('FRAME')
	waitFrame:RegisterEvent('ADDON_LOADED')
	waitFrame:SetScript(
		'OnEvent',
		function(self, event, arg1)
			if arg1 == 'Blizzard_CraftUI' then
				CraftReagent()
				waitFrame:UnregisterAllEvents()
			end
		end
	)
end
