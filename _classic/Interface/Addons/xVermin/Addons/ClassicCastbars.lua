local _, xVermin = ...

-- local function HandleCast(data, unitID, cast, spell_id)
-- 	if unitID == "target" then
-- 		local castbar = data:GetCastbarFrameIfEnabled(unitID)
-- 		if not castbar then return end
-- 		local cast = castbar._data

-- 		if not cast.isUninterruptible then
-- 			_G.UnitCastingInteruptible = true
-- 		else 
-- 			_G.UnitCastingInteruptible = false
-- 		end
-- 	end
-- end

-- hooksecurefunc(ClassicCastbars, "UNIT_SPELLCAST_START", function(data, unitID, cast, spell_id)
-- 	HandleCast(data, unitID, cast, spell_id)
-- end)

-- hooksecurefunc(ClassicCastbars, "UNIT_SPELLCAST_CHANNEL_START", function(data, unitID, cast, spell_id)
-- 	HandleCast(data, unitID, cast, spell_id)
-- end)


-- hooksecurefunc(ClassicCastbars, "PLAYER_TARGET_CHANGED", function(data, unitID, cast, spell_id)
-- 	HandleCast(data, unitID, cast, spell_id)
-- end)


-- hooksecurefunc(ClassicCastbars, "UNIT_SPELLCAST_START", HandleCast)
-- hooksecurefunc(ClassicCastbars, "UNIT_SPELLCAST_CHANNEL_START", HandleCast)
-- hooksecurefunc(ClassicCastbars, "PLAYER_TARGET_CHANGED", HandleCast)

-- hooksecurefunc(ClassicCastbars, "UNIT_SPELLCAST_INTERRUPTED", function(...) _G.UnitCastingInteruptible = false end)
-- hooksecurefunc(ClassicCastbars, "UNIT_SPELLCAST_STOP", function(...) _G.UnitCastingInteruptible = false end)
-- hooksecurefunc(ClassicCastbars, "UNIT_SPELLCAST_CHANNEL_STOP", function(...) _G.UnitCastingInteruptible = false end)
-- hooksecurefunc(ClassicCastbars, "UNIT_SPELLCAST_FAILED", function(...) _G.UnitCastingInteruptible = false end)


-- hooksecurefunc(ClassicCastbars, "DisplayCastbar", function(...)
-- 	local arg = {...}

-- 	-- Check if there are arguments
-- 	if #arg > 0 then
-- 		for i, value in ipairs(arg) do
-- 			if type(value) == "table" then
-- 				print("Argument", i, "is a table:")

-- 				-- Print the contents of the table
-- 				for key, subValue in pairs(value) do
-- 					print("      ", key, ":", subValue)
-- 				end
-- 			else
-- 				print("Argument", i, "is not a table. Value:", value)
-- 			end
-- 		end
-- 	else
-- 		print("No arguments passed.")
-- 	end
-- end)


-- local function HandleCast(data, castbar, unitID)
-- 	-- print("start cast", unitID, castbar, not castbar.isUninterruptible)
-- 	if unitID == "target" then
-- 		if not castbar.isUninterruptible then
-- 			_G.UnitCastingInteruptible = true
-- 		else
-- 			_G.UnitCastingInteruptible = false
-- 		end
-- 	end
-- end

-- xVermin.CheckIfLoadedWithTimer(
-- 	'ClassicCastbars',
-- 	function()
-- 		hooksecurefunc(ClassicCastbars, "DisplayCastbar", HandleCast)
-- 		hooksecurefunc(ClassicCastbars, "HideCastbar", function() 
-- 			-- print("stop cast")
-- 			_G.UnitCastingInteruptible = false 
-- 		end)
-- 	end
-- )

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('PLAYER_REGEN_ENABLED')
-- -- f:RegisterEvent('PLAYER_TARGET_CHANGED')
-- f:SetScript('OnEvent', function() _G.UnitCastingInteruptible = false end)