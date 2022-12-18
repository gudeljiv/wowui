local iconpath = "Interface\\GLUES\\CHARACTERCREATE\\UI-CharacterCreate-Classes"
local iconCutoff = 6

local function iconOffset(col, row)
	local offsetString = (col * 64 + iconCutoff) .. ":" .. ((col + 1) * 64 - iconCutoff)
	return offsetString .. ":" .. (row * 64 + iconCutoff) .. ":" .. ((row + 1) * 64 - iconCutoff)
end

local function isInEnabledPhase(phaseText) 

	local showTooltip = false;
	
	if LBISSettings.PhaseTooltip[LBIS.L["PreRaid"]] == true then
		if strfind(phaseText, "0") ~= nil then
			showTooltip = true;
		end
	end
	if LBISSettings.PhaseTooltip[LBIS.L["Phase 1"]] == true then
		if strfind(phaseText, "1") ~= nil then
			showTooltip = true;
		end
	end
	
	return showTooltip;
end

local function buildCombinedTooltip(entry, combinedTooltip, foundCustom)

	local classCount = {};
	local combinedSpecs = {};

	for k, v in pairs(entry) do
		if LBISSettings.Tooltip[k] and isInEnabledPhase(v.PhaseList) and foundCustom[k] == nil then
			local classSpec = LBIS.ClassSpec[k]

			classCount[classSpec.Class..v.Bis..v.Phase] = (classCount[classSpec.Class..v.Bis..v.Phase] or 0) + 1;
			if (combinedSpecs[classSpec.Class..v.Bis..v.Phase] == nil) then
				combinedSpecs[classSpec.Class..v.Bis..v.Phase] = { Class = classSpec.Class, Spec = classSpec.Spec, Bis = v.Bis, Phase = v.Phase }
			else				
				combinedSpecs[classSpec.Class..v.Bis..v.Phase].Spec = combinedSpecs[classSpec.Class..v.Bis..v.Phase].Spec..", "..classSpec.Spec;
			end
		end
	end
	
	for _, v in pairs(combinedSpecs) do
		if (v.Class ~= "Druid" and classCount[v.Class..v.Bis..v.Phase] == 3) then
			v.Spec = "";
		elseif (v.Class == "Druid" and classCount[v.Class..v.Bis..v.Phase] == 4) then
			v.Spec = "";
		end
		table.insert(combinedTooltip, { Class = v.Class, Spec = v.Spec, Bis = v.Bis, Phase = v.Phase })
	end
end

local function buildCustomTooltip(priorityEntry, combinedTooltip)

	local foundCustom = {}
	local showTooltip = false;
	if LBISSettings.ShowCustom and priorityEntry ~= nil then
		for k, v in pairs(priorityEntry) do
		
			local classSpec = LBIS.ClassSpec[k]
			foundCustom[k] = true;
				
			table.insert(combinedTooltip, { Class = classSpec.Class, Spec = classSpec.Spec, Bis = "Custom", Phase = "#"..v })
		end
	end

	return foundCustom;
end

local function buildTooltip(tooltip, combinedTooltip)

	if #combinedTooltip > 0 then
		local r,g,b = .9,.8,.5
		tooltip:AddLine(" ",r,g,b,true)
		tooltip:AddLine(LBIS.L["# Best for:"],r,g,b,true)
	end

	for k, v in pairs(combinedTooltip) do
		local class = LBIS.ENGLISH_CLASS[v.Class]:upper()
		local color = RAID_CLASS_COLORS[class]
		local coords = CLASS_ICON_TCOORDS[class]
		local classfontstring = "|T" .. iconpath .. ":14:14:::256:256:" .. iconOffset(coords[1] * 4, coords[3] * 4) .. "|t"
		
        if v.Phase == "0" then
            tooltip:AddDoubleLine(classfontstring .. " " .. v.Class .. " " .. v.Spec, v.Bis, color.r, color.g, color.b, color.r, color.g, color.b, true)
        else
            tooltip:AddDoubleLine(classfontstring .. " " .. v.Class .. " " .. v.Spec, v.Bis.." "..string.gsub(v.Phase, "0", "P"), color.r, color.g, color.b, color.r, color.g, color.b, true)
        end
	end
end

local function CheckRecipe(tt, classID)
	if classID == Enum.ItemClass.Recipe then
		tt.isFirstMoneyLine = not tt.isFirstMoneyLine
		return tt.isFirstMoneyLine
	end
end

local function onTooltipSetItem(tooltip, ...)

	local _, itemLink = tooltip:GetItem()
    if not itemLink then return end
	local itemString = string.match(itemLink, "item[%-?%d:]+")
	local itemId = tonumber(({ strsplit(":", itemString) })[2])

	LBIS:GetItemInfo(itemId, function(item)
		local combinedTooltip = {};
		local foundCustom = {};

		if CheckRecipe(tooltip, item.Class) then
			return;
		end

		if LBIS.CustomList.Items[itemId] then
			foundCustom = buildCustomTooltip(LBIS.CustomList.Items[itemId], combinedTooltip)
		end

		if LBIS.Items[itemId] then
			buildCombinedTooltip(LBIS.Items[itemId], combinedTooltip, foundCustom)
		end

		buildTooltip(tooltip, combinedTooltip);
	end)
end

local function onTooltipSetSpell(tooltip, ...)

	local _, spellId = tooltip:GetSpell()
    if not spellId then return end

	local combinedTooltip = {};

	if LBIS.Spells[spellId] then
		buildCombinedTooltip(LBIS.Spells[spellId], combinedTooltip, {})
	end

	buildTooltip(tooltip, combinedTooltip);
end

local hookStore = {};
local function hookScript(tip, script, prehook)
	if not hookStore[tip] then hookStore[tip] = {} end
	local control
	-- check for existing hook
	control = hookStore[tip][script]
	if control then
		control[1] = prehook or control[1]
		return
	end
	-- prepare upvalues
	local orig = tip:GetScript(script)
	control = {prehook}
	hookStore[tip][script] = control
	-- install hook stub
	local stub = function(...)
		local h
		-- prehook
		h = control[1]
		if h then h(...) end
		-- original hook
		if orig then orig(...) end
	end
	tip:SetScript(script, stub)
end

local function registerTooltip(tooltip)

	hookScript(tooltip, "OnTooltipSetItem", onTooltipSetItem);
	hookScript(tooltip, "OnTooltipSetSpell", onTooltipSetSpell);

end

local function linkWranglerHook(frame)
	registerTooltip(frame)
end

LBIS:RegisterEvent("PLAYER_ENTERING_WORLD" , function ()
	LBIS.EventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")

	registerTooltip(GameTooltip);
	registerTooltip(ShoppingTooltip1);
	registerTooltip(ShoppingTooltip2);

	registerTooltip(ItemRefTooltip);
	registerTooltip(ItemRefShoppingTooltip1)
	registerTooltip(ItemRefShoppingTooltip2)

	if LinkWrangler then
        LinkWrangler.RegisterCallback("EdrikGameFixes", linkWranglerHook, "allocate", "allocatecomp")
    end

    LBIS:Startup();
end);