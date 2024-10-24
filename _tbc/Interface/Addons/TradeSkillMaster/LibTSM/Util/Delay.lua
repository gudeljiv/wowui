-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

--- Delay Functions
-- @module Delay

local _, TSM = ...
local Delay = TSM.Init("Util.Delay")
local Debug = TSM.Include("Util.Debug")
local Log = TSM.Include("Util.Log")
local TempTable = TSM.Include("Util.TempTable")
local private = {
	delays = {},
	frameNumber = 0,
	frame = nil,
}
local CALLBACK_TIME_WARNING_THRESHOLD_MS = 20
local MIN_TIME_DURATION = 0.0001



-- ============================================================================
-- Module Loading
-- ============================================================================

Delay:OnModuleLoad(function()
	private.frame = CreateFrame("Frame")
	private.frame:SetScript("OnUpdate", private.ProcessDelays)
	private.frame:Show()
end)



-- ============================================================================
-- Module Functions
-- ============================================================================

--- Call a callback after a set amount of time.
-- Note that the delay may be up to 1 frame time longer than requested.
-- @tparam[opt] string label A label for the delay (to allow it to be cancelled)
-- @tparam number duration The amount of time to delay for
-- @tparam function callback The function called when the delay is finished
-- @tparam[opt] number repeatDelay The amount of time to set this delay for once it completes
-- @param[opt=nil] context A context value to pass along to the callback (ignored if the delay was previously started)
function Delay.AfterTime(label, duration, callback, repeatDelay, context)
	if type(label) == "number" then
		-- no label specified
		assert(not repeatDelay)
		duration, callback, repeatDelay, context = label, duration, callback, repeatDelay
		label = nil
	end
	assert(type(duration) == "number" and type(callback) == "function" and (not repeatDelay or type(repeatDelay) == "number"))
	repeatDelay = repeatDelay and max(repeatDelay, MIN_TIME_DURATION) or nil
	duration = max(duration, MIN_TIME_DURATION)

	if label then
		for _, delay in ipairs(private.delays) do
			if delay.label == label then
				-- delay is already running, so just return
				return
			end
		end
	else
		label = Debug.GetStackLevelLocation(2)
	end

	local delayTbl = TempTable.Acquire()
	delayTbl.endTime = GetTime() + duration
	delayTbl.callback = callback
	delayTbl.label = label
	delayTbl.repeatDelay = repeatDelay
	delayTbl.context = context
	tinsert(private.delays, delayTbl)
end

--- Call a callback after a set number of frames.
-- Note that the delay may be up to 1 frame time longer than requested.
-- @tparam[opt] string label A label for the delay (to allow it to be cancelled)
-- @tparam number duration The number of frames to delay for
-- @tparam function callback The function called when the delay is finished
-- @tparam[opt] number repeatDelay The number of frames to set this delay for once it completes
-- @param[opt=nil] context A context value to pass along to the callback (ignored if the delay was previously started)
function Delay.AfterFrame(label, duration, callback, repeatDelay, context)
	if type(label) == "number" then
		-- no label specified
		assert(not repeatDelay)
		duration, callback, repeatDelay, context = label, duration, callback, repeatDelay
		label = nil
	end
	assert(type(duration) == "number" and type(callback) == "function" and (not repeatDelay or type(repeatDelay) == "number"))
	repeatDelay = repeatDelay and max(repeatDelay, 1) or nil
	duration = max(duration, 1)

	if label then
		for _, delay in ipairs(private.delays) do
			if delay.label == label then
				-- delay is already running, so just return
				return
			end
		end
	else
		label = Debug.GetStackLevelLocation(2)
		assert(label)
	end

	local delayTbl = TempTable.Acquire()
	delayTbl.endFrame = private.frameNumber + duration
	delayTbl.callback = callback
	delayTbl.label = label
	delayTbl.repeatDelay = repeatDelay
	delayTbl.context = context
	tinsert(private.delays, delayTbl)
end

--- Cancel a delay.
-- This works for both time and frame delays.
-- @tparam string label The label the delay was created with
function Delay.Cancel(label)
	for i, delay in ipairs(private.delays) do
		if delay.label == label then
			TempTable.Release(tremove(private.delays, i))
			return
		end
	end
end



-- ============================================================================
-- Main Delay Callback
-- ============================================================================

function private.ProcessDelays()
	private.frameNumber = private.frameNumber + 1
	-- the delays can change as we do our callbacks, so keep looping through them until there are no more pending
	while true do
		local pendingLabel, pendingCallback, pendingContext = nil, nil, nil
		for i, delay in ipairs(private.delays) do
			assert(delay.endFrame or delay.endTime)
			if delay.endFrame and delay.endFrame <= private.frameNumber then
				pendingLabel = delay.label
				pendingCallback = delay.callback
				pendingContext = delay.context
				if delay.repeatDelay then
					delay.endFrame = private.frameNumber + delay.repeatDelay
				else
					TempTable.Release(tremove(private.delays, i))
				end
				break
			elseif delay.endTime and delay.endTime <= GetTime() then
				pendingLabel = delay.label
				pendingCallback = delay.callback
				pendingContext = delay.context
				if delay.repeatDelay then
					delay.endTime = GetTime() + delay.repeatDelay
				else
					TempTable.Release(tremove(private.delays, i))
				end
				break
			end
		end
		if not pendingLabel then
			-- no more pending delays to process
			assert(not pendingCallback)
			break
		end
		local startTime = debugprofilestop()
		pendingCallback(pendingContext)
		local timeTaken = debugprofilestop() - startTime
		if timeTaken > CALLBACK_TIME_WARNING_THRESHOLD_MS then
			Log.Warn("Delay callback (%s) took %0.2fms", pendingLabel, timeTaken)
		end
	end
end
