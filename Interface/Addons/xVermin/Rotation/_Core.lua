local _, ns = ...

function ns.inRange(type)
	local type = type or "bool"
	local inRange = 0
	for i = 1, 40 do
		if UnitExists("nameplate" .. i) and IsSpellInRange("Cleave", "nameplate" .. i) == 1 then
			inRange = inRange + 1
		end
	end
	if type == "bool" then
		if inRange > 1 then
			return true
		else
			return false
		end
	end
	if type == "number" then
		return inRange
	end
end
