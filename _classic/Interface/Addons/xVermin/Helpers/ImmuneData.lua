local _, xVermin = ...
local xppadding = 45

-- -- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- ---- FRAMES -----------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- local immune_data = CreateFrame('Frame', 'ImmuneData', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
-- immune_data:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
-- immune_data:SetFrameStrata('LOW')
-- immune_data:SetBackdrop(
-- 	{
-- 		bgFile = xVermin.Config.background.white,
-- 		edgeFile = '',
-- 		tile = false,
-- 		tileSize = 0,
-- 		edgeSize = 0,
-- 		insets = {left = 0, right = 0, top = 0, bottom = 0}
-- 	}
-- )
-- immune_data:SetBackdropColor(0, 0, 0, 0.6)
-- immune_data:SetFrameStrata('BACKGROUND')
-- immune_data:CreateBeautyBorder(6)
-- immune_data.isMoving = false
-- immune_data:Show()

-- ----------------------------
-- -- Title of the frame
-- ----------------------------
-- local immune_data_title = CreateFrame('Frame', 'ImmuneDataTitle', immune_data)
-- immune_data_title:SetPoint('TOP', immune_data, 'TOP', 0, -10)
-- immune_data_title.text = immune_data_title:CreateFontString(nil, 'ARTWORK')
-- immune_data_title.text:SetFont(xVermin.Config.font.arial, 14, 'NONE')
-- immune_data_title.text:SetPoint('TOP', immune_data_title, 'TOP', 0, 0)
-- immune_data_title.text:SetText('Immune list')
-- immune_data_title.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
-- immune_data_title:SetWidth(immune_data_title.text:GetStringWidth())
-- immune_data_title:SetHeight(immune_data_title.text:GetStringHeight())

-- ----------------------------
-- -- Kill list wrapper
-- ----------------------------
-- local immune_data_wrapper = CreateFrame('Frame', 'ImmuneDataWrapper', immune_data, BackdropTemplateMixin and 'BackdropTemplate')
-- immune_data_wrapper:SetPoint('TOPLEFT', immune_data, 'TOPLEFT', 0, -55)
-- immune_data_wrapper:SetFrameStrata('LOW')
-- immune_data_wrapper:SetBackdropColor(0, 0, 0, 0)

-- ----------------------------
-- -- Kill list names
-- ----------------------------
-- local immune_data_list = CreateFrame('Frame', 'ImmuneDataList', immune_data)
-- immune_data_list:SetPoint('TOPLEFT', immune_data, 'TOPLEFT', 10, -55)
-- immune_data_list.text = immune_data_list:CreateFontString(nil, 'ARTWORK')
-- immune_data_list.text:SetFont(xVermin.Config.font.arial, 8, 'NONE')
-- immune_data_list.text:SetPoint('TOPLEFT', immune_data_list, 'TOPLEFT', 0, 0)
-- immune_data_list.text:SetText('')
-- immune_data_list.text:SetJustifyH('LEFT')
-- immune_data_list.text:SetTextColor(1, 1, 1, 1)

-- local immune_data_list_spells = CreateFrame('Frame', 'ImmuneDataListValues', kc)
-- immune_data_list_spells:SetPoint('TOPRIGHT', immune_data, 'TOPRIGHT', -10, -55)
-- immune_data_list_spells.text = immune_data_list_spells:CreateFontString(nil, 'ARTWORK')
-- immune_data_list_spells.text:SetFont(xVermin.Config.font.arial, 8, 'NONE')
-- immune_data_list_spells.text:SetPoint('TOPRIGHT', immune_data_list_spells, 'TOPRIGHT', 0, 0)
-- immune_data_list_spells.text:SetText('')
-- immune_data_list_spells.text:SetJustifyH('RIGHT')
-- immune_data_list_spells.text:SetTextColor(1, 1, 1, 1)


-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---- FRAME EVENTS -----------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- immune_data:EnableMouse(true)
-- immune_data:SetMovable(true)
-- immune_data:SetClampedToScreen(true)

-- --------------------------------
-- -- Move main frame
-- --------------------------------
-- immune_data:SetScript(
-- 	'OnMouseDown',
-- 	function(self, button)
-- 		if button == 'LeftButton' and not self.isMoving then
-- 			self:StartMoving()
-- 			self.isMoving = true
-- 		end
-- 	end
-- )

-- immune_data:SetScript(
-- 	'OnMouseUp',
-- 	function(self, button)
-- 		if button == 'LeftButton' and self.isMoving then
-- 			self:StopMovingOrSizing()
-- 			self.isMoving = false

-- 			-- local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
-- 			-- xKillCount.position.from = point
-- 			-- xKillCount.position.anchor = relativeTo and relativeTo:GetName() or nil
-- 			-- xKillCount.position.to = relativePoint
-- 			-- xKillCount.position.x = xOfs
-- 			-- xKillCount.position.y = yOfs
-- 		end
-- 	end
-- )


-- local sortedTable = {}
-- -- Function to sort the table by NPC names and then by subnodes
-- local function SortData(data)
-- 	-- Function to sort a table by keys
-- 	local function sortTableKeys(tbl)
-- 		local sortedKeys = {}
-- 		for key in pairs(tbl) do
-- 			table.insert(sortedKeys, key)
-- 		end
-- 		table.sort(sortedKeys)
-- 		return sortedKeys
-- 	end

-- 	-- Function to sort a table of spells
-- 	local function sortSpells(spells)
-- 		table.sort(spells)
-- 		return spells
-- 	end

-- 	-- Sort the main table by NPC names
	
-- 	local sortedKeys = sortTableKeys(data)
-- 	for _, key in ipairs(sortedKeys) do
-- 		sortedTable[key] = sortSpells(data[key])
-- 	end


-- 	-- Print the sorted data
-- 	for npc, spells in pairs(sortedTable) do
-- 		-- print(npc .. ":")
-- 		for _, spell in ipairs(spells) do
-- 			-- print("  " .. spell)
-- 		end
-- 	end
-- end



-- local function DisplayData()
-- 	-- if xKillCount.show then
-- 	-- 	kc:Show()
-- 	-- else
-- 	-- 	kc:Hide()
-- 	-- 	return
-- 	-- end

-- 	local xNPC = ''
-- 	local xSPELLS = ''

-- 	for npc, spells in pairs(sortedTable) do
-- 		-- print(npc, spells)
-- 		xNPC = xNPC .. npc .. '\n'
-- 		if spells then 
-- 			for k, spell in pairs(spells) do
-- 				-- print(spell)
-- 				xSPELLS = xSPELLS .. spell .. ', '
-- 			end
-- 			if xSPELLS ~= "" then
-- 				xSPELLS = xSPELLS:sub(1, -3)
-- 			end
-- 		end
-- 		xSPELLS = xSPELLS .. '\n'
-- 	end

-- 	print(xNPC, xSPELLS)

-- 	immune_data_list.text:SetText(xNPC)
-- 	immune_data_list_spells.text:SetText(xSPELLS)

-- 	local w = math.max(immune_data_list.text:GetStringWidth() + immune_data_list_spells.text:GetStringWidth() + 40)
-- 	local h = immune_data_list.text:GetStringHeight() + 86 + xppadding
-- 	immune_data:SetSize(math.max(w, 270), math.max(h, 125))

-- 	immune_data_list:SetSize(immune_data_list.text:GetStringWidth(), immune_data_list.text:GetStringHeight())
-- 	immune_data_list_spells:SetSize(immune_data_list_spells.text:GetStringWidth(), immune_data_list_spells.text:GetStringHeight())

-- 	immune_data_wrapper:SetSize(immune_data:GetWidth(), immune_data_list.text:GetStringHeight())
-- end




local al_frame = CreateFrame("Frame");
al_frame:RegisterEvent("ADDON_LOADED");
al_frame:SetScript(
	"OnEvent", 
	function (_, event, arg1, ...)
		if event == "ADDON_LOADED" then
			if not xVerminSavedData.SpellImmuneData or xVerminSavedData.SpellImmuneData == nil or type(xVerminSavedData.SpellImmuneData) ~= "table" then
				xVerminSavedData.SpellImmuneData = {}
			end

			-- SortData(xVerminSavedData.SpellImmuneData)
			-- DisplayData()
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

SLASH_id_settings1 = '/id'
SlashCmdList['id_settings'] = function(msg, ...)
	ChatFrame7Tab:Click()
	local exists = false
	local unitName = ''
	local spellName = msg
	
	if not UnitExists("target") or not spellName then
		-- print("TARGET or SPELL missing")
		ChatFrame7:AddMessage('TARGET or SPELL missing')
		return 
	end

	unitName = UnitName("target")

	if xVerminSavedData.SpellImmuneData[unitName] then
		for i, savedSpellName in ipairs(xVerminSavedData.SpellImmuneData[unitName]) do
			if string.lower(savedSpellName) == string.lower(spellName) then
				exists = true
				table.remove(xVerminSavedData.SpellImmuneData[unitName], i)
			end
		end
	end

	if not exists then
		if not xVerminSavedData.SpellImmuneData[unitName] or type(xVerminSavedData.SpellImmuneData[unitName]) ~= "table" then
			xVerminSavedData.SpellImmuneData[unitName] = {}
		end
		table.insert(xVerminSavedData.SpellImmuneData[unitName], spellName)
	end

	spellName = string.upper(spellName)
	unitName = string.upper(unitName)
	-- ChatFrame7:AddMessage('--------------------------------------------------------------------------------------------------------')
	ChatFrame7:AddMessage('Immune spell '.. (exists and '\124cffFF0000REMOVED\124r' or '\124cff00FF00ADDED\124r') ..' for ' .. unitName .. ' > ' .. (exists and '\124cffFF0000'.. spellName ..'\124r' or '\124cff00FF00'.. spellName ..'\124r'))
	-- ChatFrame7:AddMessage('--------------------------------------------------------------------------------------------------------')
end