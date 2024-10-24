local ChocolateBar = LibStub("AceAddon-3.0"):GetAddon("ChocolateBar")
local Jostle2 = ChocolateBar.Jostle2
local bottomFrames = {}
local topFrames = {}
Jostle2.hooks = {}
local _G, pairs = _G, pairs
local UnitHasVehicleUI = UnitHasVehicleUI and UnitHasVehicleUI or function() end

local blizzardFrames = {
	'MicroButtonAndBagsBar',
	'TutorialFrameParent',
	'FramerateLabel',
	'DurabilityFrame',
	'StatusTrackingBarManager',
	'MinimapCluster',
}

local blizzardFramesData = {}

local start = GetTime()
local nextTime = 0
local fullyInitted = false
local Jostle2Frame = CreateFrame("Frame")

if ChocolateBar:IsRetail() then
	Jostle2.Frame  = Jostle2Frame
	Jostle2Frame:SetScript("OnUpdate", function(this, elapsed)
		local now = GetTime()
		if now - start >= 3 then
			fullyInitted = true
			for k,_ in pairs(blizzardFramesData) do
				blizzardFramesData[k] = nil
			end
			this:SetScript("OnUpdate", function(this, elapsed)
				if GetTime() >= nextTime then
					Jostle2:Refresh()
					--this:Hide()
				end
			end)
		end
	end)

	function Jostle2Frame:Schedule(time)
		time = time or 0
		nextTime = GetTime() + time
		self:Show()
	end

	Jostle2Frame:UnregisterAllEvents()
	--Jostle2Frame:SetScript("OnEvent", function(this, event, ...)
	--	ChocolateBar.Debug(Jostle2,event)
	--	return Jostle2[event](Jostle2, ...)
	--end)

	--Jostle2Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
end

local function GetScreenTop()
	local bottom = GetScreenHeight()
	for _,frame in pairs(topFrames) do
		if frame.IsShown and frame:IsShown() and frame.GetBottom and frame:GetBottom() and frame:GetBottom() < bottom then
			bottom = frame:GetBottom()
		end
	end
	return bottom
end

local function GetScreenBottom()
	local top = 0
	local isBottomAdjusting = false
	for _,frame in pairs(bottomFrames) do
		if frame.IsShown and frame:IsShown() and frame.GetTop and frame:GetTop() and frame:GetTop() > top then
			top = frame:GetTop()
			isBottomAdjusting = true
		end
	end
	return top
end

local function isMinimapClusterUserPlaced()
    return not (UIParent:GetTop() * UIParent:GetScale() == MinimapCluster:GetTop() * UIParent:GetScale()) 
end


function Jostle2:RegisterBottom(frame)
	if frame and not bottomFrames[frame] then
		bottomFrames[frame] = frame
		Jostle2Frame:Schedule()
	end
end

function Jostle2:RegisterTop(frame)
	if frame and not topFrames[frame] then
		topFrames[frame] = frame
		Jostle2Frame:Schedule()
	end
end

function Jostle2:Unregister(frame)
	if frame and topFrames[frame] then
		topFrames[frame] = nil
	elseif frame and bottomFrames[frame] then
		bottomFrames[frame] = nil
		Jostle2Frame:Schedule()
	end
end

if not Jostle2.hooks.UIParent_ManageFramePositions then
	Jostle2.hooks.UIParent_ManageFramePositions = true
	hooksecurefunc("UIParent_ManageFramePositions", function()
		if Jostle2.UIParent_ManageFramePositions then
			Jostle2:UIParent_ManageFramePositions()
		end
	end)
end

function Jostle2:UIParent_ManageFramePositions()
	--ChocolateBar:Debug("UIParent_ManageFramePositions")
	--self:Refresh(MinimapCluster)
end

local tmp = {}
local queue = {}
local inCombat = false
function Jostle2:ProcessQueue()
	if not inCombat and HasFullControl() then
		for k in pairs(queue) do
			self:Refresh(k)
			queue[k] = nil
		end
	end
end

function Jostle2:Refresh(...)
	if not fullyInitted then
		return
	end

	local screenHeight = GetScreenHeight()
	local topOffset = GetScreenTop() or screenHeight
	local bottomOffset = GetScreenBottom() or 0
	if topOffset ~= screenHeight or bottomOffset ~= 0 then
		Jostle2Frame:Schedule(10)
	end

	local frames
	-- check for frames in parameter list
	if select('#', ...) >= 1 then
		for k in pairs(tmp) do
			tmp[k] = nil
			--ChocolateBar:Debug(k)
		end
		for i = 1, select('#', ...) do
			tmp[i] = select(i, ...)
		end
		frames = tmp
	else
		frames = blizzardFrames
	end

	if inCombat or not HasFullControl() and not UnitHasVehicleUI("player") then
		for _,frame in ipairs(frames) do
			if type(frame) == "string" then
				frame = _G[frame]
			end
			if frame then
				queue[frame] = true
			end
		end
		return
	end

	-- setup blizzardFramesData
	for _,frame in ipairs(frames) do
		if type(frame) == "string" then
			frame = _G[frame]
		end

		local framescale = frame and frame.GetScale and frame:GetScale() or 1

		if frame and not blizzardFramesData[frame] and frame.GetTop and frame:GetCenter() and select(2, frame:GetCenter()) then
			if select(2, frame:GetCenter()) <= screenHeight / 2 or frame == MultiBarRight then
				blizzardFramesData[frame] = {y = frame:GetBottom(), top = false}
			else
				blizzardFramesData[frame] = {y = frame:GetTop() - screenHeight / framescale, top = true}
			end
		end

	end

	--ChocolateBar:Debug("setting frame 1")

	-- move the blizzardFrames 
	for _,frame in ipairs(frames) do

		if type(frame) == "string" then
			frame = _G[frame]
		end

		if frame == MinimapCluster and isMinimapClusterUserPlaced() then
			return
		end

		local framescale = frame and frame.GetScale and frame:GetScale() or 1

		if frame then
			local anchor
			local anchorAlt
			local width, height = GetScreenWidth(), GetScreenHeight()
			local x

			if frame:GetRight() and frame:GetLeft() then
				local anchorFrame = UIParent
				if frame == GroupLootFrame1 or frame == FramerateLabel then
					x = 0
					anchor = ""
				elseif frame:GetRight() / framescale <= width / 2 then
					x = frame:GetLeft() / framescale
					anchor = "LEFT"
				else
					x = frame:GetRight() - width / framescale
					anchor = "RIGHT"
				end
				local y = blizzardFramesData[frame].y
				local offset = 0
				if blizzardFramesData[frame].top then
					anchor = "TOP" .. anchor
					offset = ( topOffset - height ) / framescale
				else
					anchor = "BOTTOM" .. anchor
					offset = bottomOffset / framescale
				end
				
				if frame == FramerateLabel then
					anchorFrame = WorldFrame
				end

				if not InCombatLockdown() then
					frame:ClearAllPoints()
					frame:SetPoint(anchor, anchorFrame, anchorAlt or anchor, x, y + offset)

				end
			end
		end
	end
end
