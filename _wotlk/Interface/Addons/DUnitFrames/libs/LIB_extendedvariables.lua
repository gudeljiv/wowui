
local EVVersion = 19
local EVLatest = nil
local EVLoaded = false

EVBUILD = "CLASSIC"
if select(4, GetBuildInfo()) > 90000 then
	EVBUILD = "RETAIL"
elseif select(4, GetBuildInfo()) > 29999 then
	EVBUILD = "WRATH"
elseif select(4, GetBuildInfo()) > 19999 then
	EVBUILD = "TBC"
end

local function EVOnEvent(self, event, ...)
	if GEVVersion == nil then
		GEVVersion = 0
	end

	if EVVersion > GEVVersion then
		GEVVersion = EVVersion
		EVLatest = true
	elseif EVVersion < GEVVersion then
		EVLatest = false
	end

	if event == "PLAYER_ENTERING_WORLD" and not EVLoaded then
		if EVLatest then
			EVLoaded = true

			function DBNameByUnit(unit)
				if UnitExists(unit) and UnitIsPlayer(unit) then
					local name, realm = UnitName(unit)
					if realm and realm ~= "" then
						name = name .. "-" .. realm
					else
						name = name .. "-" .. GetRealmName()
					end
					return name
				else
					return ""
				end
			end

			if EVTAB == nil then
				EVTAB = {}
			end

			if MAITAB then
				EVTAB = MAITAB
			elseif MIPO then
				EVTAB = MIPO
			elseif HPTAB then
				EVTAB = HPTAB
			elseif THTAB then
				EVTAB = THTAB
			elseif DRFTAB then
				EVTAB = DRFTAB
			elseif LOCTAB then
				EVTAB = LOCTAB
			end

			-- "GLOBALS"
			local covenants = {}
			covenants[1] = "covenantchoice-celebration-kyriansigil" -- Kyrian
			covenants[2] = "covenantchoice-celebration-venthyrsigil" -- Venthyr
			covenants[3] = "covenantchoice-celebration-nightfaesigil" -- Nightfae
			covenants[4] = "covenantchoice-celebration-necrolordsigil" -- Necrolord

			local covenantsIcons = {}
			covenantsIcons[1] = "Interface\\icons\\ui_sigil_kyrian"
			covenantsIcons[2] = "Interface\\icons\\ui_sigil_venthyr"
			covenantsIcons[3] = "Interface\\icons\\ui_sigil_nightfae"
			covenantsIcons[4] = "Interface\\icons\\ui_sigil_necrolord"

			local covspells = {}
			covspells[1] = {} -- Kyrian
			covspells[2] = {} -- Venthyr
			covspells[3] = {} -- Nightfae
			covspells[4] = {} -- Necrolord

			tinsert(covspells[1], 324739)
			tinsert(covspells[1], 312202)
			tinsert(covspells[1], 306830)
			tinsert(covspells[1], 326434)
			tinsert(covspells[1], 308491)
			tinsert(covspells[1], 307443)
			tinsert(covspells[1], 310454)
			tinsert(covspells[1], 304971)
			tinsert(covspells[1], 325013)
			tinsert(covspells[1], 323547)
			tinsert(covspells[1], 324386)
			tinsert(covspells[1], 312321)
			tinsert(covspells[1], 307865)
			
			tinsert(covspells[2], 300728)
			tinsert(covspells[2], 311648)
			tinsert(covspells[2], 317009)
			tinsert(covspells[2], 323546)
			tinsert(covspells[2], 324149)
			tinsert(covspells[2], 314793)
			tinsert(covspells[2], 326860)
			tinsert(covspells[2], 316958)
			tinsert(covspells[2], 323673)
			tinsert(covspells[2], 323654)
			tinsert(covspells[2], 320674)
			tinsert(covspells[2], 321792)
			tinsert(covspells[2], 317349)

			tinsert(covspells[3], 310143)
			tinsert(covspells[3], 324701)
			tinsert(covspells[3], 324128)
			tinsert(covspells[3], 323639)
			tinsert(covspells[3], 323764)
			tinsert(covspells[3], 328231)
			tinsert(covspells[3], 314791)
			tinsert(covspells[3], 327104)
			tinsert(covspells[3], 328278)
			tinsert(covspells[3], 328282)
			tinsert(covspells[3], 328620)
			tinsert(covspells[3], 328622)
			tinsert(covspells[3], 328281)
			tinsert(covspells[3], 327661)
			tinsert(covspells[3], 328305)
			tinsert(covspells[3], 328923)
			tinsert(covspells[3], 325640)
			tinsert(covspells[3], 325886)
				
			tinsert(covspells[4], 324631)
			tinsert(covspells[4], 315443)
			tinsert(covspells[4], 329554)
			tinsert(covspells[4], 325727)
			tinsert(covspells[4], 325028)
			tinsert(covspells[4], 324220)
			tinsert(covspells[4], 325216)
			tinsert(covspells[4], 328204)
			tinsert(covspells[4], 324724)
			tinsert(covspells[4], 328547)
			tinsert(covspells[4], 326059)
			tinsert(covspells[4], 325289)
			tinsert(covspells[4], 324143)

			local covspellsbyid = {}
			for i, v in pairs(covspells) do
				for j, w in pairs(v) do
					covspellsbyid[w] = i
				end
			end

			local covenantssizes = {
				[1] = {57,  100},
				[2] = {95,  100},
				[3] = {100, 100},
				[4] = {83,  100}
			}

			function EVGetCovenantSize(id, size)
				if id >= 1 and id <= 4 then
					return size / 100 * covenantssizes[id][1], size
				else
					return 1, 1
				end
			end
			
			function EVSameFaction(unit)
				if unit == nil then return false end
				return UnitFactionGroup(unit) == UnitFactionGroup("PLAYER")
			end



			if EVTAB.ILVL == nil then
				EVTAB.ILVL = {}
			end
	
			-- ITEM LEVEL
			if GetAverageItemLevel then
				local ilvlqueue = {}

				function UnitILvl(unit)
					local ilvl = 0

					if UnitIsPlayer(unit) and UnitIsConnected(unit) then
						if GetInspectInfo and GetInspectInfo(unit) then -- TINYINSPECT
							local tab = GetInspectInfo(unit)
							if tab.ilevel and tab.ilevel > 0 and tab.ilevel ~= EVTAB.ILVL[DBNameByUnit(unit)] then
								EVTAB.ILVL[DBNameByUnit(unit)] = tab.ilevel
							end
						end

						if EVTAB.ILVL[DBNameByUnit(unit)] then
							ilvl = EVTAB.ILVL[DBNameByUnit(unit)]
						elseif EVLoaded and UnitExists(unit) then
							local name = DBNameByUnit(unit)
							if not tContains(ilvlqueue, name) then
								tinsert(ilvlqueue, name)

								if EVSameFaction(unit) then
									C_ChatInfo.SendAddonMessage("EVILvl", "ASK" .. "," .. DBNameByUnit(unit), "WHISPER", name)
								end
							end
						end
					end
					return ilvl
				end
		
				function EVSendILvl()
					local overall, equipped = GetAverageItemLevel()
					local prefix = "EVILvl"
					data = "RECEIVE" .. "," .. equipped .. "," .. DBNameByUnit("PLAYER")

					if IsInRaid(LE_PARTY_CATEGORY_HOME) then
						C_ChatInfo.SendAddonMessage(prefix, data, "RAID")
					elseif IsInRaid(LE_PARTY_CATEGORY_INSTANCE) or IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
						C_ChatInfo.SendAddonMessage(prefix, data, "INSTANCE_CHAT")
					elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
						C_ChatInfo.SendAddonMessage(prefix, data, "PARTY")
					end
				end
				
				local EVILvlAntiSpam = {}
				C_ChatInfo.RegisterAddonMessagePrefix("EVILvl")
				local function ILvlOnEvent(self, event, prefix, ...)                    
					if event == "CHAT_MSG_ADDON" then
						if prefix == "EVILvl" then
							local msg, channel, name = ...
							local art, t2, t3 = strsplit(",", msg)
							if art == "RECEIVE" then
								ilvl = t2
								guid = t3
								EVTAB.ILVL[guid] = tonumber(ilvl)
							elseif art == "ASK" then
								local guid = t2
								if not EVILvlAntiSpam[name] then
									EVILvlAntiSpam[name] = true

									C_ChatInfo.SendAddonMessage("EVILvl", "RECEIVE" .. "," .. UnitILvl("PLAYER") .. "," .. DBNameByUnit("PLAYER"), channel, name)

									C_Timer.After(1, function()
										EVILvlAntiSpam[name] = false
									end)
								end
							end
						end
					elseif event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" then
						EVSendILvl()
					end
				end
				local fILvl = CreateFrame("Frame")
				fILvl:RegisterEvent("CHAT_MSG_ADDON")
				fILvl:RegisterEvent("PLAYER_ENTERING_WORLD")
				fILvl:RegisterEvent("GROUP_ROSTER_UPDATE")
				fILvl:SetScript("OnEvent", ILvlOnEvent)
		
				function EVILvlThink()
					local overall, equipped = GetAverageItemLevel()
		
					if equipped ~= EVTAB.ILVL[DBNameByUnit("PLAYER")] then
						EVTAB.ILVL[DBNameByUnit("PLAYER")] = equipped
				
						EVSendILvl()
					end
		
					C_Timer.After(1, EVILvlThink)
				end
		
				function EVSetupILvl()
					EVILvlThink()
				end
				EVSetupILvl()
				
				if EVTAB["cg"] == nil then
					EVTAB["cg"] = true
				end

				SLASH_CG1 = "/cg"
				SLASH_CG2 = "/checkgear"
				SlashCmdList["CG"] = function(msg)
					if msg == "0" then
						EVTAB["cg"] = false
						print("|cFFFF6060" .. "CheckGear turned OFF")
					elseif msg == "1" then
						EVTAB["cg"] = true
						print("|cFF60FF60" .. "CheckGear turned ON")
					else
						if EVTAB["cg"] then
							print("|cFF60FF60" .. "CheckGear is ON")
						else
							print("|cFF60FF60" .. "CheckGear is OFF")
						end
					end
				end 

				if EVTAB["ilvl"] == nil then
					EVTAB["ilvl"] = true
				end

				SLASH_ILVL1 = "/ilvl"
				SLASH_ILVL2 = "/itemlevel"
				SlashCmdList["ILVL"] = function(msg)
					if msg == "0" then
						EVTAB["ilvl"] = false
						print("|cFFFF6060" .. "ItemLevel turned OFF")
					elseif msg == "1" then
						EVTAB["ilvl"] = true
						print("|cFF60FF60" .. "ItemLevel turned ON")
					else
						if EVTAB["ilvl"] then
							print("|cFF60FF60" .. "ItemLevel is ON")
						else
							print("|cFF60FF60" .. "ItemLevel is OFF")
						end
					end
				end 

				SLASH_EV1 = "/ev"
				SLASH_EV2 = "/extendedvariables"
				SlashCmdList["EV"] = function(msg)
					print("|cFF60FF60" .. "----- ----- ----- ----- -----")
					print("|cFF60FF60" .. "[EV] Extended Variables")
					if EVTAB["cg"] then
						print("|cFF60FF60" .. "• CheckGear is ON (/cg 0: off, /cg 1: on)")
					else
						print("|cFF60FF60" .. "• CheckGear is OFF (/cg 0: off, /cg 1: on)")
					end
					if EVTAB["ilvl"] then
						print("|cFF60FF60" .. "• ItemLevel is ON (/ilvl 0: off, /ilvl 1: on)")
					else
						print("|cFF60FF60" .. "• ItemLevel is OFF (/ilvl 0: off, /ilvl 1: on)")
					end
					print("|cFF60FF60" .. "----- ----- ----- ----- -----")
				end 

				-- BLIZZARD
				local ids = {
					1, -- KOPF
					2, -- HALS
					3, -- SCHULTER
					--4, -- HEMD
					5, -- BRUST
					6, -- TAILLE
					7, -- BEINE
					8, -- FÜßE
					9, -- HANDGELENK
					10, -- HÄNDE
					11, -- RING 1
					12, -- RING 2
					13, -- SCHMUCK 1
					14, -- SCHMUCK 2
					15, -- UMHANG
					16, -- WAFFE 1
					17, -- WAFFE 2
					--18, -- ?
					--19, -- WAPPENROCK 
				}
				
				local eids = {
					5, 11, 12, 15, 16
				}
				
				function MAICheckGems(ItemLink)
					local gems = {
						"EMPTY_SOCKET_RED",
						"EMPTY_SOCKET_YELLOW",
						"EMPTY_SOCKET_BLUE",
						"EMPTY_SOCKET_META",
						"EMPTY_SOCKET_PRISMATIC"
					}
				
					local stats = GetItemStats(ItemLink)
					
					if stats then
						for i, v in pairs(gems) do
							if stats[v] then
								return true
							end
						end
					end
				
					return false
				end

				local wasbad = false
				function EVCheckGear(unit)
					local items = 0
					local ilvlsum = 0
					local worked = true

					local printtab = {}

					for i, id in pairs(ids) do
						local ItemID = GetInventoryItemID(unit, id)
						if ItemID then
							local ItemLink = GetInventoryItemLink(unit, id)
							if ItemLink then
								local test, itemid, enchant, gem1, gem2, gem3, gem4 = string.split(":", ItemLink)
								local ilvl = GetDetailedItemLevelInfo(ItemLink)
								if ilvl then
									ilvlsum = ilvlsum + ilvl
									items = items + 1
								else
									worked = false
								end

								if UnitLevel(unit) >= 60 then
									if tContains(eids, id) and enchant == "" then
										tinsert(printtab, ItemLink .. " |cFFFF0000" .. ADDON_MISSING .."|r (" .. ENCHANTS .. ")")
									end
									
									if MAICheckGems(ItemLink) and gem1 == "" then
										tinsert(printtab, ItemLink .. " |cFFFF0000" .. ADDON_MISSING .."|r (" .. AUCTION_CATEGORY_GEMS .. ")")
									end
								end
							end
						end
					end

					local ilvl = 0
					if worked and items > 0 then
						local name = DBNameByUnit(unit)
						ilvl = ilvlsum/items
						EVTAB.ILVL[name] = ilvl
					end

					if EVTAB["cg"] then
						if #printtab > 0 then
							wasbad = true
							print("|cFFFFFF00---------- ---------- ---------- ---------- ---------- ---------- ----------")
							if ilvl > 0 then
								print("|cFFFFFF00" .. BAG_FILTER_EQUIPMENT .. " " .. string.format("%.1f", ilvl) .. " (/cg 0: off, /cg 1: on)")
							else
								print("|cFFFFFF00" .. BAG_FILTER_EQUIPMENT)
							end

							for i, line in pairs(printtab) do
								print(line)
							end
							print("|cFFFFFF00---------- ---------- ---------- ---------- ---------- ---------- ----------")
						elseif wasbad then
							wasbad = false
							if ilvl > 0 then
								print("|cFF00FF00" .. BAG_FILTER_EQUIPMENT .. " " .. string.format("%.1f", ilvl) .. ": " .. GMSURVEYRATING4 )
							else
								print("|cFF00FF00" .. BAG_FILTER_EQUIPMENT .. ": " .. GMSURVEYRATING4 )
							end
						end
					end
				end
				C_Timer.After(4, function()
					EVCheckGear("PLAYER")

					local f = CreateFrame("FRAME")
					f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
					f:RegisterEvent("PLAYER_ENTERING_WORLD")
					f:SetScript("OnEvent", function(event, ...)
						EVCheckGear("PLAYER")
					end)
				end)

				-- TARGET
				local tf = _G["TargetFrameTextureFrame"]
				tf.text = tf:CreateFontString(nil, "ARTWORK")
				tf.text:SetPoint("CENTER", tf, "TOPRIGHT", -74, -6)
				tf.text:SetFont(STANDARD_TEXT_FONT, 8, "")
				tf.text:SetText("")
				tf.text:SetShadowOffset(1, -1)

				function EVILVLTFThink()
					local tf = _G["TargetFrameTextureFrame"]
					local ilvl = UnitILvl("TARGET")
					if EVTAB["ilvl"] then
						if tf.ilvl ~= ilvl then
							tf.ilvl = ilvl

							if ilvl > 0 then
								tf.text:SetText(string.format("%.1f", ilvl))
							else
								tf.text:SetText("")
							end
						end
					else
						tf.text:SetText("")
					end

					C_Timer.After(0.1, EVILVLTFThink)
				end
				EVILVLTFThink()
			end


		
			-- COVENANT
			if C_Covenants then
				if EVTAB.COV == nil then
					EVTAB.COV = {}
				end
				local covqueue = {}

				function UnitCovenantID(name)
					local cov = -1
					if name == nil or name == "" then
						return cov
					end
					if not string.find(name, "-") then
						name = DBNameByUnit(name)
					end
					if EVTAB.COV[name] then
						cov = EVTAB.COV[name]
					elseif EVLoaded then
						if name and name ~= "" and not tContains(covqueue, name) then
							tinsert(covqueue, name)

							if EVSameFaction(unit) then
								C_ChatInfo.SendAddonMessage("EVCov", "ASK" .. "," .. name, "WHISPER", name)
							end
						end
					end
					return cov
				end
		
				function UnitCovenantName(name)
					if not string.find(name, "-") then
						name = DBNameByUnit(name)
					end
					local cov = UnitCovenantID(name)
					if cov > -1 and C_Covenants.GetCovenantData(cov) then
						return C_Covenants.GetCovenantData(cov).name
					else
						return ""
					end
				end

				local covcolors = {}
				--               A R G B
				covcolors[1] = "ffffffff" -- Kyrian "ff2bd9f0"
				covcolors[2] = "ff2bb557" -- Venthyr
				covcolors[3] = "ffafafff" -- Nightfae
				covcolors[4] = "ffde1b14" -- Necrolord

				function UnitCovenantNameColored(name)
					if not string.find(name, "-") then
						name = DBNameByUnit(name)
					end
					local cov = UnitCovenantID(name)
					if cov > -1 and C_Covenants.GetCovenantData(cov) then
						return "|T".. covenantsIcons[cov] .. ":16:16|t" .. " " .. "|c" .. covcolors[cov] .. C_Covenants.GetCovenantData(cov).name
					else
						return ""
					end
				end
		
				function EVSendCov()
					local data = C_Covenants.GetActiveCovenantID()
					local prefix = "EVCov"
					data = "RECEIVE" .. "," .. data .. "," .. DBNameByUnit("PLAYER")

					if IsInRaid(LE_PARTY_CATEGORY_HOME) then
						C_ChatInfo.SendAddonMessage(prefix, data, "RAID")
					elseif IsInRaid(LE_PARTY_CATEGORY_INSTANCE) or IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
						C_ChatInfo.SendAddonMessage(prefix, data, "INSTANCE_CHAT")
					elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
						C_ChatInfo.SendAddonMessage(prefix, data, "PARTY")
					end
				end

				local EVCovAntiSpam = {}
				C_ChatInfo.RegisterAddonMessagePrefix("EVCov")
				local function CovOnEvent(self, event, prefix, ...)                    
					if event == "CHAT_MSG_ADDON" then
						if prefix == "EVCov" then
							local msg, channel, name = ...
							local art, t2, t3 = strsplit(",", msg)
							if art == "RECEIVE" then
								cov = t2
								guid = t3
								EVTAB.COV[guid] = tonumber(cov)
							elseif art == "ASK" then
								local guid = t2
								if not EVCovAntiSpam[name] then
									EVCovAntiSpam[name] = true

									C_ChatInfo.SendAddonMessage("EVCov", "RECEIVE" .. "," .. UnitCovenantID(DBNameByUnit("PLAYER")) .. "," .. DBNameByUnit("PLAYER"), channel, name)

									C_Timer.After(1, function()
										EVCovAntiSpam[name] = false
									end)
								end
							end
						end
					elseif event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" then
						EVSendCov()
					end
				end
				local fCov = CreateFrame("Frame")
				fCov:RegisterEvent("CHAT_MSG_ADDON")
				fCov:RegisterEvent("PLAYER_ENTERING_WORLD")
				fCov:RegisterEvent("GROUP_ROSTER_UPDATE")
				fCov:SetScript("OnEvent", CovOnEvent)
		
				function EVCovThink()
					local data = C_Covenants.GetActiveCovenantID()
		
					if data ~= EVTAB.COV[DBNameByUnit("PLAYER")] then
						EVTAB.COV[DBNameByUnit("PLAYER")] = data
				
						EVSendCov()
					end
		
					C_Timer.After(1, EVCovThink)
				end
		
				function EVSetupCov()
					EVCovThink()
				end
				EVSetupCov()



				-- Combatlog
				function EVCovCL(...)
					local _, subevent, _, sourceGUID = ...
					if subevent == "SPELL_CAST_SUCCESS" then
						if #sourceGUID >= 6 and sourceGUID:sub(0, 6) == "Player" then
							local spellId = select(12, ...)
							if covspellsbyid[spellId] ~= nil then
								local _, _, _, _, _, name, realm = GetPlayerInfoByGUID(sourceGUID)

								if realm then
									name = name .. "-" .. realm
								end
								EVTAB.COV[name] = covspellsbyid[spellId]
							end
						end
					end
				end
				local fCovCL = CreateFrame("Frame")
				fCovCL:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
				fCovCL:SetScript("OnEvent", function()
					EVCovCL(CombatLogGetCurrentEventInfo())
				end)

				-- Target Aura
				function EVThinkTargetCov()
					if UnitExists("TARGET") and UnitIsPlayer("TARGET") then
						if EVTAB.COV[DBNameByUnit("TARGET")] == nil then
							for i = 1, 40 do
								local name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId = UnitAura("TARGET", i)
								if name then
									if covspellsbyid[spellId] then
										EVTAB.COV[DBNameByUnit("TARGET")] = covspellsbyid[spellId]
									end
								else
									break
								end
							end
						end
					end

					C_Timer.After(0.5, EVThinkTargetCov)
				end
				EVThinkTargetCov()

				-- BLIZZARD
				-- Tooltip
				local function OnGameTooltipSetUnit(tooltip)
					local unit = select(2, tooltip:GetUnit())
					if not unit then
						return
					end

					--if EVSameFaction(unit) then
						local covenant = UnitCovenantName(unit)
						if covenant ~= "" then
							tooltip:AddDoubleLine(UnitCovenantNameColored(unit) .. "|r")
							tooltip:Show()
						end
					--end
				end
				GameTooltip:HookScript("OnTooltipSetUnit", OnGameTooltipSetUnit)

				-- LFG
				hooksecurefunc("LFGListApplicationViewer_UpdateApplicantMember", function(member, id, index)
					local name, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage, assignedRole, relationship = C_LFGList.GetApplicantMemberInfo(id, index)
					EVTAB.ILVL[name] = itemLevel
					if name then
						local cov = UnitCovenantID(name)
						if covenantsIcons[cov] then
							member.Name:SetText("|T".. covenantsIcons[cov] .. ":24:24|t" .. " " .. member.Name:GetText())
						end
					end
				end)

				-- CompactRaidGroup
				function CRGThink()
					local rid = 1
					for g = 1, 8 do
						for m = 1, 5 do
							local pmf = _G["CompactRaidGroup" .. g .. "Member" .. m]

							if pmf then
								if pmf.CovenantIcon == nil then-- Covenant Icon
									pmf.CovenantIcon = pmf:CreateTexture(nil, "ARTWORK")
									pmf.CovenantIcon:SetDrawLayer("ARTWORK", 7)
									pmf.CovenantIcon:SetSize(20, 20)
									pmf.CovenantIcon:SetPoint("CENTER", pmf, "TOPRIGHT", -10 - 1, -10 - 1)
								end

								if UnitCovenantID and UnitIsPlayer("RAID" .. rid) and UnitCovenantID(DBNameByUnit("RAID" .. rid)) > -1 then
									local cov = UnitCovenantID(DBNameByUnit("RAID" .. rid))
									pmf.CovenantIcon:Show()
									local sw, sh = EVGetCovenantSize(cov, 20)
									pmf.CovenantIcon:SetSize(sw, sh)
									pmf.CovenantIcon:SetAtlas(covenants[cov])
								else
									pmf.CovenantIcon:Hide()
								end	
							end

							rid = rid + 1
						end
					end

					C_Timer.After(0.5, CRGThink)
				end
				CRGThink()

				-- PartyMemberFrames
				for i = 1, 4 do
					local pmf = _G["PartyMemberFrame" .. i .. "Texture"]:GetParent()

					-- Covenant Icon
					pmf.CovenantIcon = pmf:CreateTexture(nil, "ARTWORK")
					pmf.CovenantIcon:SetDrawLayer("ARTWORK", 7)
					pmf.CovenantIcon:SetSize(20, 20)
					pmf.CovenantIcon:SetPoint("CENTER", pmf, "TOPLEFT", 36, -6)
				end
				function PFEThink()
					for i = 1, 4 do
						local pmf = _G["PartyMemberFrame" .. i .. "Texture"]:GetParent()

						if UnitCovenantID and UnitIsPlayer("PARTY" .. i) and UnitCovenantID(DBNameByUnit("PARTY" .. i)) > -1 then
							local cov = UnitCovenantID(DBNameByUnit("PARTY" .. i))
							pmf.CovenantIcon:Show()
							local sw, sh = EVGetCovenantSize(cov, 20)
							pmf.CovenantIcon:SetSize(sw, sh)
							pmf.CovenantIcon:SetAtlas(covenants[cov])
						else
							pmf.CovenantIcon:Hide()
						end	
					end

					C_Timer.After(0.5, PFEThink)
				end
				PFEThink()

				-- TARGET
				local tf = _G["TargetFrameTextureFrame"]
				-- Covenant Icon
				tf.CovenantIcon = tf:CreateTexture(nil, "ARTWORK")
				tf.CovenantIcon:SetDrawLayer("ARTWORK", 7)
				tf.CovenantIcon:SetSize(20, 20)
				tf.CovenantIcon:SetPoint("CENTER", tf, "TOPRIGHT", -104, -22)

				function EVCOVTFThink()
					local pmf = _G["TargetFrameTextureFrame"]
					if UnitCovenantID and UnitExists("TARGET") and UnitIsPlayer("TARGET") and UnitCovenantID(DBNameByUnit("TARGET")) > -1 then
						local cov = UnitCovenantID(DBNameByUnit("TARGET"))
						pmf.CovenantIcon:Show()
						local sw, sh = EVGetCovenantSize(cov, 20)
						pmf.CovenantIcon:SetSize(sw, sh)
						pmf.CovenantIcon:SetAtlas(covenants[cov])
					else
						pmf.CovenantIcon:Hide()
					end

					C_Timer.After(0.1, EVCOVTFThink)
				end
				EVCOVTFThink()
			end
		end
	end
end
local fEV = CreateFrame("Frame")
fEV:RegisterEvent("PLAYER_ENTERING_WORLD")
fEV:RegisterEvent("ADDON_LOADED")
fEV:SetScript("OnEvent", EVOnEvent)
