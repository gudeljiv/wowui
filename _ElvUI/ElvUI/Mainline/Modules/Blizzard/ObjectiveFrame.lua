local E, L, V, P, G = unpack(ElvUI)
local B = E:GetModule('Blizzard')

local _G = _G
local min = min
local CreateFrame = CreateFrame
local GetInstanceInfo = GetInstanceInfo
local RegisterStateDriver = RegisterStateDriver
local UnregisterStateDriver = UnregisterStateDriver
local IsInJailersTower = IsInJailersTower
local hooksecurefunc = hooksecurefunc

local function IsFramePositionedLeft(frame)
	local x = frame:GetCenter()
	local screenWidth = E.screenWidth
	local positionedLeft = false

	if x and x < (screenWidth * 0.5) then
		positionedLeft = true
	end

	return positionedLeft
end

local function MawBuffsList_OnShow(list)
	list.button:SetHighlightAtlas('jailerstower-animapowerbutton-highlight', true)
	list.button:SetPushedAtlas('jailerstower-animapowerbutton-normalpressed', true)
	list.button:SetButtonState('PUSHED', true)
	list.button:SetButtonState('NORMAL')
end

local function RewardsFrame_SetPosition(block)
	local rewardsFrame = _G.ObjectiveTrackerBonusRewardsFrame
	rewardsFrame:ClearAllPoints()

	if E.db.general.bonusObjectivePosition == 'RIGHT' or (E.db.general.bonusObjectivePosition == 'AUTO' and IsFramePositionedLeft(_G.ObjectiveTrackerFrame)) then
		rewardsFrame:Point('TOPLEFT', block, 'TOPRIGHT', -10, -4)
	else
		rewardsFrame:Point('TOPRIGHT', block, 'TOPLEFT', 10, -4)
	end
end

local function AutoHider_OnHide()
	if not _G.ObjectiveTrackerFrame.collapsed then
		if E.db.general.objectiveFrameAutoHideInKeystone then
			_G.ObjectiveTracker_Collapse()
		else
			local _, _, difficultyID = GetInstanceInfo()
			if difficultyID ~= 8 then -- ignore hide in keystone runs
				_G.ObjectiveTracker_Collapse()
			end
		end
	end
end

local function AutoHider_OnShow()
	if _G.ObjectiveTrackerFrame.collapsed then
		_G.ObjectiveTracker_Expand()
	end
end

function B:SetObjectiveFrameHeight()
	local top = _G.ObjectiveTrackerFrame:GetTop() or 0
	local screenHeight = E.screenHeight
	local gapFromTop = screenHeight - top
	local maxHeight = screenHeight - gapFromTop
	local objectiveFrameHeight = min(maxHeight, E.db.general.objectiveFrameHeight)

	_G.ObjectiveTrackerFrame:Height(objectiveFrameHeight)
end

function B:SetObjectiveFrameAutoHide()
	if not _G.ObjectiveTrackerFrame.AutoHider then return end --Kaliel's Tracker prevents B:MoveObjectiveFrame() from executing

	if E.db.general.objectiveFrameAutoHide then
		RegisterStateDriver(_G.ObjectiveTrackerFrame.AutoHider, 'objectiveHider', '[@arena1,exists][@arena2,exists][@arena3,exists][@arena4,exists][@arena5,exists][@boss1,exists][@boss2,exists][@boss3,exists][@boss4,exists][@boss5,exists] 1;0')
	else
		UnregisterStateDriver(_G.ObjectiveTrackerFrame.AutoHider, 'objectiveHider')
	end
end

function B:HandleMawBuffsFrame()
	if not IsInJailersTower() then return end

	local container = _G.ScenarioBlocksFrame.MawBuffsBlock.Container
	container.List:ClearAllPoints()

	local buffsPos = E.db.general.torghastBuffsPosition or 'AUTO'
	if buffsPos == 'RIGHT' or (buffsPos == 'AUTO' and IsFramePositionedLeft(_G.ScenarioBlocksFrame)) then
		container.List:Point('TOPLEFT', container, 'TOPRIGHT', 15, 1)
		container.List:SetScript('OnShow', MawBuffsList_OnShow)
	else
		container.List:Point('TOPRIGHT', container, 'TOPLEFT', 15, 1)
	end
end

function B:MoveObjectiveFrame()
	local holder = CreateFrame('Frame', 'ObjectiveFrameHolder', E.UIParent)
	holder:Point('TOPRIGHT', E.UIParent, 'TOPRIGHT', -135, -300)
	holder:Size(130, 22)

	E:CreateMover(holder, 'ObjectiveFrameMover', L["Objective Frame"], nil, nil, B.HandleMawBuffsFrame, nil, nil, 'general,blizzUIImprovements')
	holder:SetAllPoints(_G.ObjectiveFrameMover)

	local tracker = _G.ObjectiveTrackerFrame
	tracker:SetClampedToScreen(false)
	tracker:ClearAllPoints()
	tracker:Point('TOP', holder, 'TOP')
	tracker:SetMovable(true)
	tracker:SetUserPlaced(true) -- UIParent.lua line 3090 stops it from being moved <3
	B:SetObjectiveFrameHeight()

	hooksecurefunc('BonusObjectiveTracker_AnimateReward', RewardsFrame_SetPosition)

	tracker.AutoHider = CreateFrame('Frame', nil, tracker, 'SecureHandlerStateTemplate')
	tracker.AutoHider:SetAttribute('_onstate-objectiveHider', 'if newstate == 1 then self:Hide() else self:Show() end')
	tracker.AutoHider:SetScript('OnHide', AutoHider_OnHide)
	tracker.AutoHider:SetScript('OnShow', AutoHider_OnShow)
	B:SetObjectiveFrameAutoHide()

	B:RegisterEvent('ZONE_CHANGED_NEW_AREA', 'HandleMawBuffsFrame')
	B:HandleMawBuffsFrame()
end
