-- LIB Output

MIPO.name = MIPO.name or "X"

function MIPOmsg(str)
	print("|c0000ffff" .. "[" .. "|cff8888ff" .. MIPO.name .. "|c0000ffff" .. "] " .. str)
end

function MIPO.deb(str)
	if MIPO.DEBUG then
		print("[DEB] " .. str)
	end
end

function MIPOpTab(tab)
	print("pTab", tab)
	if type(tab) == "table" then
		for i, v in pairs(tab) do
			if type(v) == "table" then
				pTab(v)
			else
				print(i, v)
			end
		end
	else
		print(tostring(tab) .. " is not a table.")
	end
	print("----------------------------------")
end
