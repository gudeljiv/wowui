local _, xVermin = ...

local al_frame = CreateFrame("Frame");
al_frame:RegisterEvent("ADDON_LOADED");
al_frame:SetScript(
	"OnEvent", 
	function (event, arg1)
		if event == "ADDON_LOADED" then
			if not xVerminSavedData.SpellImmuneData or xVerminSavedData.SpellImmuneData == nil or type(xVerminSavedData.SpellImmuneData) ~= "table" then
				xVerminSavedData.SpellImmuneData = {}
			end
		end
	end
);

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
local function CheckTargetImmunity(self, event, ...)
	if event == 'COMBAT_LOG_EVENT_UNFILTERED' then
		local _, eventType, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName, spellSchool, missType = CombatLogGetCurrentEventInfo()
		local unitName = UnitName("target")
		
		if unitName and (eventType == "SPELL_MISSED" or eventType == "SPELL_ABSORBED" or eventType == "SPELL_IMMUNE") then
			if destGUID == UnitGUID("target") and UnitCanAttack("player", "target") then
				if missType == "IMMUNE" then
					-- Save data to existing SavedVariables as a table
					if not xVerminSavedData.SpellImmuneData[unitName] or type(xVerminSavedData.SpellImmuneData[unitName]) ~= "table" then
						xVerminSavedData.SpellImmuneData[unitName] = {}
					end
					
					local isAlreadySaved = false
					for _, savedSpellName in ipairs(xVerminSavedData.SpellImmuneData[unitName]) do
						if savedSpellName == spellName then
							isAlreadySaved = true
							break
						end
					end
					
					if not isAlreadySaved then
						table.insert(xVerminSavedData.SpellImmuneData[unitName], spellName)
						-- print("IMMUNE: ", unitName, " --> ", spellName)
					end
				end
			end
		end

	end
end
frame:SetScript("OnEvent", CheckTargetImmunity)