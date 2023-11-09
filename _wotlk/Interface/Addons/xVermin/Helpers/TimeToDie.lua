local _, xVermin = ...

xTTD = 99999

local healthRecord = {}
local tickers = {}

local pattern = "Target will die in %d seconds"

local function updateEstimate(unit)
	local record = healthRecord[unit]
	tinsert(record, UnitHealth(unit)/UnitHealthMax(unit))
	local time = #record
	local dps
	if (time > 15) then
		dps = record[time-15] - record[time-14]
		for i=time-14, time-1 do
			dps = 0.9*dps + 0.1*(record[i-1]-record[i])
		end
	elseif (time > 5) then
		dps = (record[1] - record[5]) / 4
		for i=5, time-1 do
			dps = 0.8*dps + 0.2*(record[i-1]-record[i])
		end
	else
		dps = (record[1] - record[time]) / (time-1)
	end
	if (dps > 0.01) then
		local timeToDie = record[time] / dps
		-- print(pattern:format(timeToDie))
		xTTD = timeToDie
	elseif (dps < -0.01) then
		-- print("Not dying any time soon!")
		xTTD = 99999
	else
		xTTD = 99999
	end
end

local function startTracking(unit)
	if (healthRecord[unit]) then
		wipe(healthRecord[unit])
	else
		healthRecord[unit] = {}
	end
	healthRecord[unit][1] = UnitHealth(unit)/UnitHealthMax(unit)
	tickers[unit] = tickers[unit] or C_Timer.NewTicker(1, function() updateEstimate(unit) end)
end

local function stopTracking(unit)
	if tickers[unit] then
		tickers[unit]:Cancel()
		tickers[unit] = nil
	end
end

local function stopAllTracking()
	for unit, ticker in pairs(tickers) do
		ticker:Cancel()
		tickers[unit] = nil
	end
end

-- local function fTTD()
-- 	local health = UnitHealth("target")
-- 	local time_to_die = GetTime()
-- 	local text = "00:00"
-- 	local oldhealth
-- 	local health0, time0, mhealth, mtime

-- 	if oldhealth ~= health then
-- 		oldhealth = health
-- 		if health == UnitHealthMax("target") then
-- 			health0, time0, mhealth, mtime = nil
-- 			text = "00:00"
-- 			return text, -1
-- 		end
		
-- 		if not health0 then
-- 			health0, time0 = health, time
-- 			mhealth, mtime = health, time
-- 			return "00:00", -1
-- 		end
		
-- 		mhealth = (mhealth + health) * .5
-- 		mtime = (mtime + time) * .5
		
-- 		if mhealth >= health0 then
-- 			text = "00:00"
-- 			health0, time0, mhealth, mtime = nil
-- 		else
-- 			time_to_die = health * (time0 - mtime) / (mhealth - health0)
-- 			if (time_to_die <= 60) then
-- 				text = format("00:%0.2d", time_to_die)
-- 			elseif (time_to_die > 60) then
-- 				text = format("%d:%0.2d", time_to_die / 60, time_to_die % 60)
-- 			end
-- 			return text, time_to_die
-- 		end
-- 	end
-- 	return text, -1
-- end

-- UIParent:HookScript(
-- 	'OnUpdate',
-- 	function()
-- 		if UnitExists("target") and not UnitIsDeadOrGhost("target") then 
-- 			local f_out, t_out = fTTD()
-- 			print(f_out, t_out)
-- 		end
-- 	end
-- )


local frame = CreateFrame("Frame")
frame:RegisterUnitEvent("UNIT_TARGET", "player")
frame:RegisterUnitEvent("UNIT_HEALTH", "target")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:SetScript("OnEvent", function(__, event)
	if (event == "UNIT_TARGET" and InCombatLockdown() or event == "PLAYER_REGEN_DISABLED") then
		stopTracking("target")
		if (UnitExists("target") and not UnitIsDeadOrGhost("target")) then
			startTracking("target")
		end
	elseif (event == "UNIT_HEALTH" and UnitIsDeadOrGhost("target")) then
		stopTracking("target")
	elseif (event == "PLAYER_REGEN_ENABLED") then
		stopAllTracking()
	end
end)