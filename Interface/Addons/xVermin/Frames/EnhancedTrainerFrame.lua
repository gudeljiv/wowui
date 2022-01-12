local _, xVermin = ...

local function TrainerFunc(frame)

	-- Make the frame double-wide
	UIPanelWindows["ClassTrainerFrame"] = {area = "override", pushable = 1, xoffset = -16, yoffset = 12, bottomClampOverride = 140 + 12, width = 714, height = 487, whileDead = 1}

	-- Size the frame
	_G["ClassTrainerFrame"]:SetSize(714, 487)

	-- Lower title text slightly
	_G["ClassTrainerNameText"]:ClearAllPoints()
	_G["ClassTrainerNameText"]:SetPoint("TOP", _G["ClassTrainerFrame"], "TOP", 0, -18)

	-- Expand the skill list to full height
	_G["ClassTrainerListScrollFrame"]:ClearAllPoints()
	_G["ClassTrainerListScrollFrame"]:SetPoint("TOPLEFT", _G["ClassTrainerFrame"], "TOPLEFT", 25, -75)
	_G["ClassTrainerListScrollFrame"]:SetSize(295, 336)

	-- Create additional list rows
	do

		local oldSkillsDisplayed = CLASS_TRAINER_SKILLS_DISPLAYED

		-- Position existing buttons
		for i = 1 + 1, CLASS_TRAINER_SKILLS_DISPLAYED do
			_G["ClassTrainerSkill" .. i]:ClearAllPoints()
			_G["ClassTrainerSkill" .. i]:SetPoint("TOPLEFT", _G["ClassTrainerSkill" .. (i - 1)], "BOTTOMLEFT", 0, 1)
		end

		-- Create and position new buttons
		_G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + 12
		for i = oldSkillsDisplayed + 1, CLASS_TRAINER_SKILLS_DISPLAYED do
			local button = CreateFrame("Button", "ClassTrainerSkill" .. i, ClassTrainerFrame, "ClassTrainerSkillButtonTemplate")
			button:SetID(i)
			button:Hide()
			button:ClearAllPoints()
			button:SetPoint("TOPLEFT", _G["ClassTrainerSkill" .. (i - 1)], "BOTTOMLEFT", 0, 1)
		end

		hooksecurefunc("ClassTrainer_SetToTradeSkillTrainer", function()
			_G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + 12
			ClassTrainerListScrollFrame:SetHeight(336)
			ClassTrainerDetailScrollFrame:SetHeight(336)
		end)

		hooksecurefunc("ClassTrainer_SetToClassTrainer", function()
			_G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + 11
			ClassTrainerListScrollFrame:SetHeight(336)
			ClassTrainerDetailScrollFrame:SetHeight(336)
		end)

	end

	-- Set highlight bar width when shown
	hooksecurefunc(_G["ClassTrainerSkillHighlightFrame"], "Show", function()
		ClassTrainerSkillHighlightFrame:SetWidth(290)
	end)

	-- Move the detail frame to the right and stretch it to full height
	_G["ClassTrainerDetailScrollFrame"]:ClearAllPoints()
	_G["ClassTrainerDetailScrollFrame"]:SetPoint("TOPLEFT", _G["ClassTrainerFrame"], "TOPLEFT", 352, -74)
	_G["ClassTrainerDetailScrollFrame"]:SetSize(296, 336)
	-- _G["ClassTrainerSkillIcon"]:SetHeight(500) -- Debug

	-- Hide detail scroll frame textures
	_G["ClassTrainerDetailScrollFrameTop"]:SetAlpha(0)
	_G["ClassTrainerDetailScrollFrameBottom"]:SetAlpha(0)

	-- Hide expand tab (left of All button)
	_G["ClassTrainerExpandTabLeft"]:Hide()

	-- Get frame textures
	local regions = {_G["ClassTrainerFrame"]:GetRegions()}

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
	ClassTrainerHorizontalBarLeft:Hide()

	-- Set skills list backdrop
	local RecipeInset = _G["ClassTrainerFrame"]:CreateTexture(nil, "ARTWORK")
	RecipeInset:SetSize(304, 361)
	RecipeInset:SetPoint("TOPLEFT", _G["ClassTrainerFrame"], "TOPLEFT", 16, -72)
	RecipeInset:SetTexture("Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg")

	-- Set detail frame backdrop
	local DetailsInset = _G["ClassTrainerFrame"]:CreateTexture(nil, "ARTWORK")
	DetailsInset:SetSize(302, 339)
	DetailsInset:SetPoint("TOPLEFT", _G["ClassTrainerFrame"], "TOPLEFT", 348, -72)
	DetailsInset:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated")

	-- Move bottom button row
	_G["ClassTrainerTrainButton"]:ClearAllPoints()
	_G["ClassTrainerTrainButton"]:SetPoint("RIGHT", _G["ClassTrainerCancelButton"], "LEFT", -1, 0)

	-- Position and size close button
	_G["ClassTrainerCancelButton"]:SetSize(80, 22)
	_G["ClassTrainerCancelButton"]:SetText(CLOSE)
	_G["ClassTrainerCancelButton"]:ClearAllPoints()
	_G["ClassTrainerCancelButton"]:SetPoint("BOTTOMRIGHT", _G["ClassTrainerFrame"], "BOTTOMRIGHT", -42, 54)

	-- Position close box
	_G["ClassTrainerFrameCloseButton"]:ClearAllPoints()
	_G["ClassTrainerFrameCloseButton"]:SetPoint("TOPRIGHT", _G["ClassTrainerFrame"], "TOPRIGHT", -30, -8)

	-- Position dropdown menus
	ClassTrainerFrameFilterDropDown:ClearAllPoints()
	ClassTrainerFrameFilterDropDown:SetPoint("TOPLEFT", ClassTrainerFrame, "TOPLEFT", 501, -40)

	-- Position money frame
	ClassTrainerMoneyFrame:ClearAllPoints()
	ClassTrainerMoneyFrame:SetPoint("TOPLEFT", _G["ClassTrainerFrame"], "TOPLEFT", 143, -49)
	ClassTrainerGreetingText:Hide()
end

if IsAddOnLoaded("Blizzard_TrainerUI") then
	TrainerFunc()
else
	local f = CreateFrame("FRAME")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function(self, event, arg1)
		if arg1 == "Blizzard_TrainerUI" then
			TrainerFunc()
			f:UnregisterAllEvents()
		end
	end)
end