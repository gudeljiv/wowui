local function Calculate()
	local now = time()

	local oldestKey, oldestTime
	local count = 0

	local durationStr = nil

	local instances = {}

	for k, v in pairs(aura_env.db.History) do
		if not (now > v.last + 3600 or v.last > now + 3600) then
			count = count + 1
			instances[#instances + 1] = v
			if not oldestTime or v.last < oldestTime then
				oldestKey = k
				oldestTime = v.last
			end
		end
	end

	table.sort(
		instances,
		function(k1, k2)
			return k1.create < k2.create
		end
	)

	local durationStr = nil
	for k, v in pairs(instances) do
		local time = v.last - v.create
		local minutes = math.floor(time / 60)
		local seconds = time % 60

		if (durationStr ~= nil) then
			durationStr = durationStr .. " - "
		else
			durationStr = ""
		end

		durationStr = durationStr .. minutes .. ":" .. string.format("%02d", seconds)
	end

	local rem = oldestTime and (oldestTime + 3600 - now)

	local instanceStr

	if count > 0 then
		instanceStr = string.format("You have entered %d instances recently.\n More instances will be available in %s.", count, rem and SecondsToTime(rem) or "n/a")
	end

	return instanceStr or "", durationStr or ""
end
