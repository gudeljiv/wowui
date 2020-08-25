local ZGV=ZygorGuidesViewer
if not ZGV then return end

ZGV.QuestDB = {}
local QuestDB = ZGV.QuestDB

local L = ZGV.L
local RaceClassMatch = ZGV.RaceClassMatch

ZGV.Quest_Guide_Cache = {}

function ZGV.QuestDB:Init()
	-- move quests from faction array to common
	if UnitFactionGroup("player")=="Alliance" then 
		ZGV.Quest_Cache = ZGV.Quest_Cache_Turnin_Alliance
		ZGV.Quest_Cache_Accept = ZGV.Quest_Cache_Accept_Alliance
		ZGV.Quest_Cache_Horde_Turnin = nil
		ZGV.Quest_Cache_Horde_Accept = nil
	elseif UnitFactionGroup("player")=="Horde" then 
		ZGV.Quest_Cache = ZGV.Quest_Cache_Turnin_Horde		
		ZGV.Quest_Cache_Accept = ZGV.Quest_Cache_Accept_Horde		
		ZGV.Quest_Cache_Alliance_Turnin = nil
		ZGV.Quest_Cache_Alliance_Accept = nil
	else
		ZGV.Quest_Cache = {}
		ZGV.Quest_Cache_Accept = {}
		ZGV.Quest_Cache_Horde_Turnin = nil
		ZGV.Quest_Cache_Horde_Accept = nil
		ZGV.Quest_Cache_Alliance_Turnin = nil
		ZGV.Quest_Cache_Alliance_Accept = nil
	end
	
	-- clear blocks that cannot be reached, set valid functions where needed
	for gname,guidequests in pairs(ZGV.Quest_Cache) do
		for index,questdata in pairs(guidequests) do if type(questdata)=="table" then
			local wipe = false
			-- only conditions cannot change during single gameplay session, so depending on RCM result either unset the condition (if RCM is valid), or remove whole quest pack (if invalid)
			if questdata.cond then 
				if RaceClassMatch(_,questdata.cond) then
					questdata.cond = nil
				else
					guidequests[index] = nil
				end
			end

			-- only if conditions result on the other hand can change at any time, so create them from string, set enviroment, and leave it to be queried properly
			if questdata.cond_if then 
				questdata.cond_if_raw = questdata.cond_if
				questdata.cond_if = ZGV.Parser.MakeCondition(questdata.cond_if_raw)
				setfenv(questdata.cond_if,ZGV.Parser.ConditionEnv)
			end

			-- explode strings to array
			if type(questdata.ids)=="string" then
				local exploded = {}
				for quest in questdata.ids:gmatch('([^,]+)') do
					exploded[tonumber(quest)] = true
				end
				questdata.ids = exploded
			end
		end end
	end

	for gname,guidequests in pairs(ZGV.Quest_Cache_Accept) do
		for index,questdata in pairs(guidequests) do if type(questdata)=="table" then
			local wipe = false
			-- only conditions cannot change during single gameplay session, so depending on RCM result either unset the condition (if RCM is valid), or remove whole quest pack (if invalid)
			if questdata.cond then 
				if RaceClassMatch(_,questdata.cond) then
					questdata.cond = nil
				else
					guidequests[index] = nil
				end
			end

			-- only if conditions result on the other hand can change at any time, so create them from string, set enviroment, and leave it to be queried properly
			if questdata.cond_if then 
				questdata.cond_if_raw = questdata.cond_if
				questdata.cond_if = ZGV.Parser.MakeCondition(questdata.cond_if_raw)
				setfenv(questdata.cond_if,ZGV.Parser.ConditionEnv)
			end

			-- explode strings to array
			if type(questdata.ids)=="string" then
				local exploded = {}
				for quest in questdata.ids:gmatch('([^,]+)') do
					exploded[tonumber(quest)] = true
				end
				questdata.ids = exploded
			end
		end end
	end

end

function ZGV.QuestDB:GetGuidesForQuest(id)
	if not id then return false end
	if not ZGV.Quest_Cache then return false end
	if not ZGV.Quest_Cache_Accept then return false end

	local results = {}

	id = tonumber(id)
	local find_action = "accept" -- find accept step, assuming the quest is not completed
	if IsQuestFlaggedCompleted(id) then find_action = "turnin" end -- if it is, route to turnin step and pause

	if find_action == "accept" then
		for guideTitle,guide in pairs(ZGV.Quest_Cache_Accept) do
			for j,questpack in pairs(guide) do
				if questpack.ids[id] then
					results[guideTitle]=true
				end

			end
		end
	else
		for guideTitle,guide in pairs(ZGV.Quest_Cache) do
			for j,questpack in pairs(guide) do
				if questpack.ids[id] then
					results[guideTitle]=true
				end

			end
		end
	end
	
	for guideTitle,v in pairs(results) do
		local guide = ZGV:GetGuideByTitle(guideTitle)
		if guide then
			guide:Parse(true)
			local guide_checked = false
			for stepNum,step in pairs(guide.steps) do
				for _,goal in pairs(step.goals) do
					if goal.action==find_action and goal.questid==id then
						results[guideTitle]=stepNum
						guide_checked = true
						break
					end
					if guide_checked then break end
				end
				if guide_checked then break end
			end
		else
			results[guideTitle] = nil
		end
	end

	if next(results) then
		return true, results
	else
		return false, results
	end
end

hooksecurefunc("QuestLog_SetSelection",function(questIndex) ZGV.QuestDB:SetQuestForButton(questIndex) end) -- CLASSIC FIX modified

function ZGV.QuestDB:CreateButton()
	local iconFrame = CreateFrame("Button", "ZygorQuestFinder", QuestLogFrame)
	iconFrame:SetSize(24,24)
	iconFrame:SetPoint("TOPRIGHT",QuestLogFrame,"TOPRIGHT",-70,-180)
	iconFrame:SetScript("OnLeave",function() GameTooltip:Hide() end)
	iconFrame:SetScript("OnClick", function(...) ZGV.QuestDB:SuggestGuidesForQuest(ZGV.QuestDB.questID) end)
	iconFrame:SetScript("OnEnter",function(self)
		GameTooltip:ClearAllPoints()
		GameTooltip:ClearLines()
		GameTooltip:SetOwner(self,"ANCHOR_TOPLEFT")
		GameTooltip:AddLine(L['questframe_button']:format(ZGV.QuestDB.questName))
		GameTooltip:Show()
	end)

	iconFrame.tex=iconFrame:CreateTexture("ZygorQuestFinderTexture","OVERLAY")
	iconFrame.tex:SetAllPoints(true)
	iconFrame.tex:SetTexture(ZGV.DIR.."\\Skins\\findinzygor")
	--iconFrame.tex:SetTexCoord(0,0,0,1/2 , 1,0,1,1/2)

	iconFrame:Hide()

	ZGV.QuestDB.SearchIcon = iconFrame
end

function ZGV.QuestDB:SetQuestForButton(questIndex)
	local questLogTitleText, _, _, _, _, _, _, questID, _ = GetQuestLogTitle(questIndex);
	if not ZGV.Quest_Cache then return false end

	local status,results = ZGV.QuestDB:GetGuidesForQuest(questID)
	if ZGV.QuestDB:GetGuidesForQuest(questID) then
		ZGV.QuestDB.questID = questID
		ZGV.QuestDB.questName = questLogTitleText
		ZGV.QuestDB.SearchIcon:Show()
	else
		ZGV.QuestDB.SearchIcon:Hide()
	end

end

function ZGV.QuestDB:MaybeShowButton()
	if not ZGV.CurrentGuide then 
		ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Hide()
		return 
	end

	if not ZGV.CurrentGuide.QuestSearchID then 
		ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Hide()
		return 
	end
	
	if ZGV.CurrentStep:IsComplete() then
		ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Hide()
		return 
	end
		
	local show_button = true
	for i,goal in pairs(ZGV.CurrentStep.goals) do
		if goal.questid==ZGV.CurrentGuide.QuestSearchID then
			ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Hide()
			if goal.action=="turnin" then 
				ZGV.CurrentGuide.QuestSearchID = nil 
				end -- stop tracking once we display turnin step for this quest
			return
		end
	end

	ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Show()
	ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial.Blink:Stop();
	ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial.Blink:Play();
end

function ZGV.QuestDB:MaybeStopOnThisStep()
	if not ZGV.CurrentGuide then return false end
	if not ZGV.CurrentGuide.QuestSearchID then return false end
	
	local show_button = true
	for i,goal in pairs(ZGV.CurrentStep.goals) do
		if goal.questid==ZGV.CurrentGuide.QuestSearchID and goal.action=="turnin" then
			return true
		end
	end
	return false
end

function ZGV.QuestDB:SuggestGuidesForQuest(questID)
	ZGV.GuideMenu:Show("QuestSearch",tonumber(questID))
end

function ZGV.QuestDB:FocusNextStepForQuest()
	if not ZGV.CurrentGuide then return false end
	if not ZGV.CurrentGuide.QuestSearchID then return false end

	local questID = ZGV.CurrentGuide.QuestSearchID
	
	for i,step in ipairs(ZGV.CurrentGuide.steps) do
		if i>ZGV.CurrentStepNum then
			for j,goal in pairs(step.goals) do
				if goal.questid==questID then
					ZGV:FocusStep(i,true)
					return true
				end
			end
		end
	end

	return false
end

--[[
Checks if given quest can be done by given character, either now or in future
params:
	int questid
returns
	bool status - if quest can be done now, in future (after prequests are done), or never (done already, breadcrumb made impossible)
	str comment - explanationi
--]]
ZGV.QuestDB.VALID_NOW = 1
ZGV.QuestDB.VALID_FUTURE = 2
ZGV.QuestDB.VALID_NEVER = -1
local VALID_NOW = ZGV.QuestDB.VALID_NOW
local VALID_FUTURE = ZGV.QuestDB.VALID_FUTURE
local VALID_NEVER = ZGV.QuestDB.VALID_NEVER


function ZGV.QuestDB:IsQuestPossible(questid)
	if not ZGV.db.profile.beta_use_chains then return VALID_NOW,"chains disabled" end

	local otherid,_

	-- is our successor completed?
	local future = ZGV.RevChains[questid] 
	if future then
		if type(future)=="number" then
			if (PlayerIsOnQuest(future) or ZGV.completedQuests[future]) then return VALID_NEVER,"never, followup completed: "..future end
		else
			for _,otherid in pairs(future) do
				if (PlayerIsOnQuest(otherid) or ZGV.completedQuests[otherid]) then return VALID_NEVER,"never, followup completed: "..otherid end
			end
		end
	end

	-- do we have any active/completed 'or' siblings?
	local siblings = ZGV.ChainsSiblings[questid]
	if siblings then
		for _,otherid in pairs(siblings) do
			if (PlayerIsOnQuest(otherid) or ZGV.completedQuests[otherid]) then return VALID_NEVER,"never, sibling completed: "..otherid end
		end
	end

	-- do we have any prereqs?
	local prereqs = ZGV.Chains[questid]
	if not prereqs then return VALID_NOW,"valid, no prereqs" end -- no prereqs, we are good

	-- prereqs exist
	local state,comment = VALID_NEVER,"untested"

	-- get turn in goals in current step
	local turnins = {}
	if ZGV.CurrentStep and ZGV.CurrentStep.goals then
		for _,goal in pairs(ZGV.CurrentStep.goals) do
			if goal.action=="turnin" then turnins[goal.questid]=true end
		end
	end

	if type(prereqs)=="number" then -- single quest
		if ZGV.ChainsBreadcrumbs[prereqs] then
			state,comment = VALID_NOW,"valid, single prereq bread "..prereqs -- quest is possible, as only prereq is a breadcrumb
		else

			if ZGV.completedQuests[prereqs] then
				state,comment = VALID_NOW,"valid, single prereq "..prereqs -- single prereq quest that is completed
			elseif turnins[prereqs] and (ZGV.questsbyid[prereqs] and ZGV.questsbyid[prereqs].inlog) then
				state,comment = VALID_NOW,"valid, completed prereq "..prereqs -- single prereq quest that will be completed in the same step
			elseif ZGV.ChainsInProgress[prereqs] and (ZGV.questsbyid[prereqs] and ZGV.questsbyid[prereqs].inlog) then
				state,comment = VALID_NOW,"valid, prereq in log "..prereqs -- single prereq quest in progress
			else
				state,comment = VALID_FUTURE,"future, single prereq "..prereqs -- single prereq quest not yet done
			end
		end
	else -- table, so more complicated
		if prereqs[1]=="AND" then -- all must be either completed or be breadcrumbs
			for _,otherid in pairs(prereqs) do if tonumber(otherid) then
				local turnin_ready = turnins[otherid] and (ZGV.questsbyid[otherid] and ZGV.questsbyid[otherid].inlog)
				local in_progress = ZGV.ChainsInProgress[otherid] and (ZGV.questsbyid[otherid] and ZGV.questsbyid[otherid].inlog) 
				if not (ZGV.ChainsBreadcrumbs[otherid] or ZGV.completedQuests[otherid] or turnin_ready or in_progress) then return VALID_FUTURE,"future, one of AND prereqs failed: "..otherid end
			end end
			return VALID_NOW,"all of AND prereqs passed"
		else -- or mode, so any must be completed, or all must be breadcrumbs
			local all_breads = true
			for _,otherid in pairs(prereqs) do if tonumber(otherid) then
				local turnin_ready = turnins[otherid] and (ZGV.questsbyid[otherid] and ZGV.questsbyid[otherid].inlog)
				local in_progress = ZGV.ChainsInProgress[otherid] and (ZGV.questsbyid[otherid] and ZGV.questsbyid[otherid].inlog) 
				if ZGV.completedQuests[otherid] or turnin_ready or in_progress then return VALID_NOW,"valid, one of OR prereqs passed: "..otherid end
				if not ZGV.ChainsBreadcrumbs[otherid] then all_breads = false end
			end end
			if all_breads then
				state,comment = VALID_NOW,"valid, all or OR prereqs are bread"
			else
				state,comment = VALID_FUTURE,"future, all of OR prereqs failed"
			end
		end
	end
	
	return state,comment
end

local function log_chain(text)
	ZGV.db.char.chain_log = (ZGV.db.char.chain_log or "") .. "\n"..text
end

function ZGV.QuestDB:GetChain(questinput,onlyincomplete,results,message)
	if not results then results = {} end
	if type(questinput) == "number" then
		if onlyincomplete and ZGV.completedQuests[questinput] then 
			if message then log_chain(questinput.." skip completed "..message) end
			return results end

		if not ZGV.ChainsBreadcrumbs[questinput] then 
			if message then log_chain(questinput.." "..message) end
			results[questinput] = results[questinput] or true
			local message = message and "from quest "..questinput
			if ZGV.Chains[questinput] then ZGV.QuestDB:GetChain(ZGV.Chains[questinput],onlyincomplete,results,message) end
		end
	else
		for i,v in pairs(questinput) do
			if tonumber(v) then
				if not ZGV.ChainsBreadcrumbs[tonumber(v)] then 
					results[v] = results[v] or true
					local message = message and "from quest "..v
					if ZGV.Chains[v] then ZGV.QuestDB:GetChain(ZGV.Chains[v],onlyincomplete,results,message) end
				end
			end
		end
	end
	return results
end

function ZGV.QuestDB:GetChainFuture(questinput,onlyincomplete,results,message)
	if not results then results = {} end
	if type(questinput) == "number" then
		if onlyincomplete and ZGV.completedQuests[questinput] then 
			if message then log_chain(questinput.." skip completed "..message) end
			return results end

		if not ZGV.ChainsBreadcrumbs[questinput] then 
			if message then log_chain(questinput.." "..message) end
			results[questinput] = results[questinput] or true
			local message = message and "from quest "..questinput
			if ZGV.RevChains[questinput] then ZGV.QuestDB:GetChainFuture(ZGV.RevChains[questinput],onlyincomplete,results,message) end
		end
	else
		for i,v in pairs(questinput) do
			if tonumber(v) then
				results[v] = results[v] or true
				local message = message and "from quest "..v
				if ZGV.RevChains[v] then ZGV.QuestDB:GetChainFuture(ZGV.RevChains[v],onlyincomplete,results,message) end
			end
		end
	end
	return results
end


-- parameters:
--  guide - object or nil - if given, specified guide will be used as starting point, otherwise we will use guide suggested for current level
--  forcestep - int or nil - if given, we will use given level as suggested starting point for a guide, if not, we will work out what the point really is
--  nofuture - bool or nil - should we skip checking quests in future guides
-- by default, no params are given. guide,force,true are used when catching up on requirements for specific guide
local function sis_catchup_log(message)
	table.insert(ZGV.db.char.SISlog,message)
	ZGV:Debug(message)
end

function ZGV.QuestDB:FindStartingPoint(guide,forcestep,nofuture)
	ZGV.db.char.SISquests = nil
	ZGV.db.char.SISguides = nil
	ZGV.db.char.SISdestination = nil

	ZGV.db.char.SISlog = ZGV.db.char.SISlog or {}
	table.wipe(ZGV.db.char.SISlog)


	if guide then sis_catchup_log("&fsp: override: using guide "..guide.title) end
	if forcestep then sis_catchup_log("&fsp: override: starting with step "..forcestep) end

	local level = level or math.floor(ZGV:GetPlayerPreciseLevel())

	if not guide then
		ZGV:Print("Finding proper starter section.")
		local gs = ZGV:FindSuggestedGuides()
		if gs['LEVELING'] then gs=gs['LEVELING'] end
		if not gs or #gs==0 then
			ZGV:Print("No guides suggested for your char. Please open guide menu and select the guide you want to use.")
		elseif #gs==1 then
			guide = gs[1]
		else --many
			local was_excl
			for gi,sugguide in ipairs(gs) do
				if sugguide.condition_suggested_exclusive then
					guide = gs[1]
					was_excl=true
					break
				end
			end
			if not was_excl then
				if not ZGV.db.profile.beta_use_chains then ZGV:Print("There were "..#gs.." guides suggested. Loading first one.") end
				guide = gs[1]
			end
		end
	end

	if not guide then sis_catchup_log("&fsp: no guide found, abort") return end

	if not ZGV.db.profile.beta_use_chains then -- BETA early exit
		ZGV:SetGuide(guide.title,1)
		sis_catchup_log("&fsp: chains disabled, abort")
		return
	end

	if UnitXP("player")==0 and UnitLevel("player")==1 then -- fresh character, just load starter guide
		ZGV:SetGuide(guide.title,1)
		sis_catchup_log("&fsp: fresh char, no magic needed")
		return
	end


	guide:Parse(true)

	local guides = {} -- we will use this to find earlier step, since we may need to move between guides
	table.insert(guides,guide.title)

	sis_catchup_log("&fsp: suggested guide is" ..guide.title)

	local ding_step
	if forcestep then
		ding_step = forcestep
	else
		for s,step in ipairs(guide.steps) do
			for g,goal in ipairs(step.goals) do
				if (goal.action == "ding" or goal.action == "level") then
					if (goal.level==level) then
						ding_step = s
						break
					end
				end
			end
			if ding_step then break end
		end
	end

	if ding_step then
		sis_catchup_log("&fsp: > ding for level "..level.." found at step "..ding_step)
	else
		sis_catchup_log("&fsp: > no ding for "..level..", starting at step 1")
		ding_step = 1
	end

	local starter_guide = guide
	local accept_step
	if forcestep then
		accept_step = forcestep
	else
		for s=ding_step,#starter_guide.steps do
			local step = starter_guide.steps[s]
			if step:AreRequirementsMet() then
				for g,goal in pairs(step.goals) do
					if goal.action == "accept" then
						local state,comment = ZGV.QuestDB:IsQuestPossible(goal.questid)
						local complete = goal:IsComplete()
						if not complete and (state>0) then
							sis_catchup_log("&fsp: > possible accept found at step "..s)
							accept_step = s
							break
						end
					end
				end
			end
			if accept_step then break end
		end
		accept_step = accept_step or ding_step -- if there are no accept steps after ding, fall back to ding
	end

	-- store which guides are not to be used (wrong race starters)
	local reject_guides = {}
	for i,iguide in pairs(ZGV.registeredguides) do
		if iguide.condition_suggested_race and not iguide.condition_suggested_race() then
			reject_guides[iguide.title] = true
		end
	end

	-- get future guides
	sis_catchup_log("&fsp: > finding all future guides")
	if not nofuture then
		local future_guide = starter_guide
		while true do
			if not future_guide.next then break end
			future_guide = ZGV:GetGuideByTitle(future_guide.next)
			if not future_guide then break end
			table.insert(guides,future_guide.title)
		end
	end

	-- get past guides
	sis_catchup_log("&fsp: > finding all past guides")
	local past_guide = starter_guide
	local abort = 50
	while true do
		local prev_guide_found = false
		for i,prevguide in pairs(ZGV.registeredguides) do
			if ZGV:SanitizeGuideTitle(prevguide.next) == past_guide.title then
				if not prevguide.condition_suggested_exclusive or prevguide.condition_suggested_race() then
					past_guide=prevguide
					prev_guide_found = true
					table.insert(guides,1,past_guide.title) -- previous, so insert at start
				end
			end
		end
		if not prev_guide_found then -- there is no previous guide, nothing more to do
			sis_catchup_log("&fsp: >>> no previous guide, terminate loop")
			break
		end
		abort = abort - 1
		if abort == 0 then sis_catchup_log("&fsp: > endless loop? abort after 50") break end
	end

	-- get all quests for starter and future guides, as well as their past chains
	local quests = {}
	local flag_future = false
	for _,guide in pairs(guides) do
		if guide==starter_guide.title then flag_future = true end -- do not check any guides that are in past, chains will handle them
		if flag_future then
			if ZGV.Quest_Cache_Accept[guide] then
				for j,questpack in pairs(ZGV.Quest_Cache_Accept[guide]) do
					for quest,_ in pairs(questpack.ids) do
						if not ZGV.ChainsBreadcrumbs[quest] then -- ignore breadcrumbs
							local state,comment = ZGV.QuestDB:IsQuestPossible(tonumber(quest))
							if state~=VALID_NOW then
								local message = ZGV.db.profile.debug and "from guide "..guide
								ZGV.QuestDB:GetChain(tonumber(quest),"only incomplete",quests,message)
							end
						end
					end
				end
			end
		end
	end

	-- mark which guides will be skipped by sis catchup
	sis_catchup_log("&fsp: >> marking required guides")
	local used_guides = {}
	for quest,_ in pairs(quests) do 
		for guideTitle,guide in pairs(ZGV.Quest_Cache_Accept) do
			if not reject_guides[guideTitle] then
				for j,questpack in pairs(guide) do
					if questpack.ids[quest] then
						quests[quest] = guideTitle
						used_guides[guideTitle] = true
					end
				end
			end
		end
	end

	local flag_future = false
	for _,guide in pairs(guides) do
		if guide==starter_guide.title then flag_future = true end
		if flag_future then
			used_guides[guide] = nil -- don't store future guides
		else
			used_guides[guide] = used_guides[guide] or -1
		end
	end

	used_guides[starter_guide.title] = accept_step -- marking that we only plan on sis-skipping through suggested guide up to specific point only

	ZGV.db.char.SISquests = quests
	ZGV.db.char.SISguides = used_guides
	ZGV.db.char.SISdestination = {starter_guide.title,accept_step}

	-- go from first guide, and look for a guide we have marked as needed
	sis_catchup_log("&fsp: >> locating earliest guides")
	local load_guide
	for _,guide in pairs(guides) do
		if used_guides[guide] and used_guides[guide]~=-1 then
			load_guide = guide
			sis_catchup_log("&fsp: >> done "..load_guide)
			break
		end
	end

	if load_guide then 
		sis_catchup_log("&fsp: >> loading "..load_guide)
		load_guide = ZGV:GetGuideByTitle(load_guide)
		load_guide:Parse(true)
		sis_catchup_log("&fsp: >> locating first relevant step")
		local load_step
		for si,step in pairs(load_guide.steps) do
			if step:AreRequirementsMet() then
				for _,goal in pairs(step.goals) do
					if goal.questid and goal.action=="accept" and ZGV.db.char.SISquests[goal.questid] then
						sis_catchup_log("&fsp: >> found at "..si)
						load_step = si
						break
					end
				end
				if load_step then break end
			end
		end
		if not forcestep and load_step > accept_step and load_guide.title==starter_guide.title then
			sis_catchup_log("&fsp: >> first relevant step after our accept. shouldn't be possible")
			ZGV.db.char.SISdestination = {starter_guide.title,load_step}
		end

		ZGV:SetGuide(load_guide.title,load_step or 1)
	end
end

function ZGV.QuestDB:MaybeSkipThisGoal(goal)
	if not goal then return false,"no goal" end -- sanity check

	if ZGV.CurrentGuide and (ZGV.db.char.guideTurnInsOnly == ZGV.CurrentGuide.title) then
		if goal.action~="turnin" then return true,"turnins only" end -- in "let me turn in my quests" mode, skip everything that is not turnin
	end

	if not (ZGV.db.char.SISquests and ZGV.db.char.SISguides) then return false,"no catchup" end -- if we are not in sis catchup, don't skip anything extra
	if not ZGV.db.char.SISguides[ZGV.CurrentGuide.title] then return false,"not catchup guide" end -- if we are in sis catchup, but not one of needed guides, don't skip anything extra

	local end_guide,end_step = ZGV.db.char.SISdestination[1],ZGV.db.char.SISdestination[2]

	if ZGV.db.char.SISdestination and ZGV.db.char.SISquests then
		if ZGV.CurrentGuide.title == end_guide and goal.parentStep.num>=end_step then -- if we are in final guide, don't skip after reaching target step
			return false,"don't skip past target"
		end
	end

	if goal.questid and ZGV.completedQuests[goal.questid] then return false,"don't skip completed" end -- don't flag quests completed as skippable

	-- if we are here, we are in valid sis catchup step. skip what is needed
	if (goal.level or 0) > ZGV:GetPlayerPreciseLevel() then return false,"incomplete ding" end

	if not goal.questid then return true,"no quest" end -- skip all non quest related goals

	if not ZGV.db.char.SISquests[goal.questid] then 
		local quest = ZGV.questsbyid[goal.questid]
		if quest and quest.inlog then 
			if ZGV.CurrentGuide.title == end_guide then
				return false,"accepted" -- don't skip accepted quests in final guide, even in not in not required for future quests
			elseif (ZGV.Chains[goal.questid] and not ZGV.RevChains[goal.questid]) then
				return false,"end of chain" -- don't skip end of chain quests, since they usually give good rewards
			else
				return true,"skip" -- skip it, since it is not reward-worthy and not in final guide
			end
		else
			return true,"not on list" -- skip quests not on our list
		end
	end 
	
	return false,"don't skip" -- don't skip this
end

function ZGV.QuestDB:GetStepTag(stepdata)
	if not ZGV.CurrentGuide then return end
	if not ZGV.db.char.SISdestination then return end
	if (ZGV.CurrentGuide.title==ZGV.db.char.SISdestination[1]) and (stepdata.num==ZGV.db.char.SISdestination[2]) then
		return L["sis_start"]
	end
	if (ZGV.CurrentGuide.title==ZGV.db.char.SISdestination[1]) and (stepdata.num>ZGV.db.char.SISdestination[2]) then
		return
	end

	if not (ZGV.db.char.SISquests and ZGV.db.char.SISguides) then return end
	if not ZGV.db.char.SISguides[ZGV.CurrentGuide.title] then return end

	local end_guide,end_step = ZGV.db.char.SISdestination[1],ZGV.db.char.SISdestination[2]

	local quest_found, quest_valid, quest_progress,needs_grind
	for _,goal in pairs(stepdata.goals) do
		if goal.questid then
			quest_found = true
			local quest = ZGV.questsbyid[goal.questid]
			if quest and quest.inlog then 
				if ZGV.CurrentGuide.title == end_guide then
					quest_progress = true -- don't skip accepted quests in final guide, even in not in not required for future quests
				elseif (ZGV.Chains[goal.questid] and not ZGV.RevChains[goal.questid]) then
					quest_progress = true -- don't skip end of chain quests, since they usually give good rewards
				end			
			end
			if ZGV.db.char.SISquests[goal.questid] then 
				quest_valid = true
			end
		end
		if (goal.level or 0) > ZGV:GetPlayerPreciseLevel() then needs_grind = true end
	end

	local message = L["sis_irrelevant"]
	if quest_found then message = L["sis_skipping"] end
	if quest_progress then message = L["sis_progress"] end
	if quest_valid then message = L["sis_required"] end
	if needs_grind then message = L["sis_level"] end
	if stepdata:IsComplete() then message = L["sis_complete"] end

	return message
end

function ZGV.QuestDB:Cancel()
	ZGV.db.char.SISquests = nil
	ZGV.db.char.SISguides = nil
	ZGV.db.char.SISdestination = nil

	-- if visible, show to update buttons
	if ZGV.QuestDB.GuideHelperMenu and ZGV.QuestDB.GuideHelperMenu:IsVisible() then
		ZGV.QuestDB:ShowGuideHelper()
	end
end

function ZGV.QuestDB:ShowGuideHelper()
	if not ZGV.QuestDB.GuideHelperMenu then
		local ui = ZGV.UI
		local SkinData = ui.SkinData
		local CHAIN = ZGV.ChainCall
		local FONT=ZGV.Font
		local FONTBOLD=ZGV.FontBold

		local popup = CHAIN(ui:Create("Frame",UIParent,name))
			:SetSize(375,150) -- The height can change later.
			:CanDrag(1)
			:SetAlpha(ZGV.db.profile.opacitymain) --This only gets set once per popup. --TODO it should be able to change dynamically.
			:SetPoint("TOP",0,-50)
			:SetFrameStrata("DIALOG")
			:Hide() -- Done before script is set. After self.private is not intialized yet.
			:SetScript("OnShow", function(self)
				self:SetScale(ZGV.db.profile.framescale)
				self:AdjustSize()

				-- Makes esc get rid of the popup without bringing up interface window
				self.holder:Show()

			end)
			:SetScale(ZGV.db.profile.framescale)
		.__END

		-- Place holder to make esc work properly without hiding the popup. We hide it outself.
		popup.holder = CreateFrame("Frame")
		popup.holder.hideOnEscape = true

		popup.minimize = CHAIN(CreateFrame("Button",nil,popup))
				:SetPoint("TOPRIGHT",popup,"TOPRIGHT",-5,-5) :SetSize(15,15)
				:SetScript("OnClick",function() popup:Hide() end)
		.__END
		ZGV.F.AssignButtonTexture(popup.minimize,(SkinData("TitleButtons")),6,32)

		function popup:AdjustSize() 
			local height = 30 + self.header:GetStringHeight()+5 + self.subheader_catchup:GetStringHeight()+10 + self.button_catchup_best:GetHeight() + self.button_catchup_curent:GetHeight() + self.subheader_cleanup:GetStringHeight()+10 + self.button_cleanup:GetHeight()
			self:SetHeight(height)
		end

		popup.header=CHAIN(popup:CreateFontString(nil,"ARTWORK"))
			:SetPoint("TOP",0,-10)
			:SetFont(FONTBOLD,ZGV.db.profile.fontsize+6) --text is set later --TODO make font size change dynamically
			:SetText(L["sis_dialog_header"])
		.__END
		popup.background = CHAIN(popup:CreateTexture(nil,"BACKGROUND")) 
			:SetPoint("TOP",popup.header,"BOTTOM",0,-10)
			:SetPoint("LEFT",0,0)
			:SetPoint("RIGHT",0,0)
			:SetPoint("BOTTOM",0,0)
			:SetColorTexture(unpack(SkinData("SecBackdropColor")))
		.__END


		popup.subheader_catchup=CHAIN(popup:CreateFontString(nil,"ARTWORK")) --Not needed in most popups, but is used in SIS
			:SetPoint("TOP",popup.background,"TOP",0,-10)
			:SetPoint("LEFT",popup.background,"LEFT",30,0)
			:SetPoint("RIGHT",popup.background,"RIGHT",-5,0)
			:SetFont(FONTBOLD,ZGV.db.profile.fontsize+2) --text is set later
			:SetJustifyH("left")
			:SetText(L["sis_dialog_subheader_catchup"])
		.__END
		popup.subheader_catchup_icon = CHAIN(popup:CreateTexture())
			:SetPoint("TOPRIGHT",popup.subheader_catchup,"TOPLEFT",-5,2)
			:SetSize(20,20)
			:SetTexture(ZGV.DIR.."\\Skins\\generalicons-big-color")
			:SetTexCoord(0,0.25,0,1)
		.__END

		popup.button_catchup_best = CHAIN(ui:Create("Button",popup))
			:SetPoint("TOP",popup.subheader_catchup,"BOTTOM",0,-5)
			:SetPoint("LEFT",popup.background,"LEFT",5,0)
			:SetPoint("RIGHT",popup.background,"RIGHT",-5,0)
			:SetShown(true)
			:SetText(L['sis_dialog_button_catchup_best'])
			:SetFont(FONT,ZGV.db.profile.fontsize)
			:SetScript("OnClick",function() popup:Hide() ZGV.QuestDB:FindStartingPoint() end)
		.__END
		popup.button_catchup_curent = CHAIN(ui:Create("Button",popup))
			:SetPoint("TOP",popup.button_catchup_best,"BOTTOM")
			:SetPoint("LEFT",popup.background,"LEFT",5,0)
			:SetPoint("RIGHT",popup.background,"RIGHT",-5,0)
			:SetWidth(80)
			:SetShown(true)
			:SetText(L['sis_dialog_button_catchup_curent'])
			:SetFont(FONT,ZGV.db.profile.fontsize)
			:SetScript("OnClick",function() popup:Hide() ZGV.QuestDB:FindStartingPoint(ZGV.CurrentGuide,ZGV.CurrentStep.num,true) end)
		.__END
		popup.button_catchup_disable = CHAIN(ui:Create("Button",popup))
			:SetPoint("TOP",popup.subheader_catchup,"BOTTOM",0,-5)
			:SetPoint("LEFT",popup.background,"LEFT",5,0)
			:SetPoint("RIGHT",popup.background,"RIGHT",-5,0)
			:SetShown(true)
			:SetText(L['sis_dialog_button_catchup_cancel'])
			:SetFont(FONT,ZGV.db.profile.fontsize)
			:SetScript("OnClick",function() ZGV.QuestDB:Cancel() ZGV.QuestDB:ShowGuideHelper() end)
			:Hide()
		.__END

		popup.subheader_cleanup = CHAIN(popup:CreateFontString(nil,"ARTWORK")) --Not needed in most popups, but is used in SIS
			:SetPoint("TOP",popup.button_catchup_curent,"BOTTOM",0,-10)
			:SetPoint("LEFT",popup.background,"LEFT",30,0)
			:SetPoint("RIGHT",popup.background,"RIGHT",-5,0)
			:SetFont(FONTBOLD,ZGV.db.profile.fontsize+2) --text is set later
			:SetJustifyH("left")
			:SetText(L["sis_dialog_subheader_cleanup"])
		.__END
		popup.subheader_cleanup_icon = CHAIN(popup:CreateTexture())
			:SetPoint("TOPRIGHT",popup.subheader_cleanup,"TOPLEFT",-5,3)
			:SetSize(20,20)
			:SetTexture(ZGV.DIR.."\\Skins\\generalicons-big-color")
			:SetTexCoord(0.25,0.50,0,1)
		.__END

		popup.button_cleanup = CHAIN(ui:Create("Button",popup))
			:SetPoint("TOP",popup.subheader_cleanup,"BOTTOM",0,-5)
			:SetPoint("LEFT",popup.background,"LEFT",5,0)
			:SetPoint("RIGHT",popup.background,"RIGHT",-5,0)
			:SetWidth(80)
			:SetShown(true)
			:SetText(L['sis_dialog_button_cleanup'])
			:SetFont(FONT,ZGV.db.profile.fontsize)
			:SetScript("OnClick",function() popup:Hide() ZGV:ShowQuestCleanup() end)
		.__END

		popup.button_catchup_best:SetHeight(popup.button_catchup_best:GetStringHeight()+30)
		popup.button_catchup_best:SetWidth(popup:GetWidth())
		popup.button_catchup_best:GetFontString():SetJustifyH("left")
		popup.button_catchup_best:GetFontString():SetPoint("LEFT",25,0)
		popup.button_catchup_best:GetFontString():SetWidth(popup:GetWidth()-30)
		popup.button_catchup_best:GetFontString():SetWordWrap(true)
		popup.button_catchup_best:SetTexture(SkinData("StepLineIcons"))
		popup.button_catchup_best.tex:SetTexCoord(17/32,18/32,0,1)
		popup.button_catchup_best.tex:ClearAllPoints()
		popup.button_catchup_best.tex:SetPoint("LEFT",3,0)
		popup.button_catchup_best.tex:SetSize(12,12)

		popup.button_catchup_curent:SetHeight(popup.button_catchup_curent:GetStringHeight()+30)
		popup.button_catchup_curent:SetWidth(popup:GetWidth())
		popup.button_catchup_curent:GetFontString():SetJustifyH("left")
		popup.button_catchup_curent:GetFontString():SetPoint("LEFT",25,0)
		popup.button_catchup_curent:GetFontString():SetWidth(popup:GetWidth()-30)
		popup.button_catchup_curent:GetFontString():SetWordWrap(true)
		popup.button_catchup_curent:SetTexture(SkinData("StepLineIcons"))
		popup.button_catchup_curent.tex:SetTexCoord(17/32,18/32,0,1)
		popup.button_catchup_curent.tex:ClearAllPoints()
		popup.button_catchup_curent.tex:SetPoint("LEFT",3,0)
		popup.button_catchup_curent.tex:SetSize(12,12)

		popup.button_catchup_disable:SetHeight(popup.button_catchup_disable:GetStringHeight()+20)
		popup.button_catchup_disable:SetWidth(popup:GetWidth())
		popup.button_catchup_disable:GetFontString():SetJustifyH("left")
		popup.button_catchup_disable:GetFontString():SetPoint("LEFT",25,0)
		popup.button_catchup_disable:GetFontString():SetWidth(popup:GetWidth()-30)
		popup.button_catchup_disable:GetFontString():SetWordWrap(true)
		popup.button_catchup_disable:SetTexture(SkinData("TitleButtons"))
		popup.button_catchup_disable.tex:SetTexCoord(5/32,6/32,0,0.25)
		popup.button_catchup_disable.tex:ClearAllPoints()
		popup.button_catchup_disable.tex:SetPoint("LEFT",3,0)
		popup.button_catchup_disable.tex:SetSize(12,12)
		popup.button_catchup_disable.tex:SetVertexColor(1,0,0,1)

		popup.button_cleanup:SetHeight(popup.button_cleanup:GetStringHeight()+20)
		popup.button_cleanup:SetWidth(popup:GetWidth())
		popup.button_cleanup:GetFontString():SetJustifyH("left")
		popup.button_cleanup:GetFontString():SetPoint("LEFT",25,0)
		popup.button_cleanup:GetFontString():SetWidth(popup:GetWidth()-30)
		popup.button_cleanup:GetFontString():SetWordWrap(true)
		popup.button_cleanup:SetTexture(SkinData("StepLineIcons"))
		popup.button_cleanup.tex:SetTexCoord(17/32,18/32,0,1)
		popup.button_cleanup.tex:ClearAllPoints()
		popup.button_cleanup.tex:SetPoint("LEFT",3,0)
		popup.button_cleanup.tex:SetSize(12,12)

		ZGV.QuestDB.GuideHelperMenu = popup
	end

	local popup = ZGV.QuestDB.GuideHelperMenu

	popup.button_catchup_best:SetEnabled(true)
	popup.button_catchup_best:SetAlpha(1)

	if ZGV.CurrentGuide.type=="LEVELING" then
		popup.button_catchup_curent:SetEnabled(true)
		popup.button_catchup_curent:SetAlpha(1)
		popup.button_cleanup:SetEnabled(true)
		popup.button_cleanup:SetAlpha(1)
	else
		popup.button_catchup_curent:SetEnabled(false)
		popup.button_catchup_curent:SetAlpha(0.5)
		popup.button_cleanup:SetEnabled(false)
		popup.button_cleanup:SetAlpha(0.5)
	end

	if ZGV.db.profile.beta_use_chains then
		popup.button_catchup_curent:SetEnabled(true)
		popup.button_catchup_curent:SetAlpha(1)
		popup.button_catchup_best:SetEnabled(true)
		popup.button_catchup_best:SetAlpha(1)
	else
		popup.button_catchup_curent:SetEnabled(false)
		popup.button_catchup_curent:SetAlpha(0.5)
		popup.button_catchup_best:SetEnabled(false)
		popup.button_catchup_best:SetAlpha(0.5)

	end
	
	if ZGV.db.char.SISquests then
		popup.button_catchup_disable:Show()
		popup.button_catchup_curent:Hide()
		popup.button_catchup_best:Hide()
		popup.subheader_cleanup:SetPoint("TOP",popup.button_catchup_disable,"BOTTOM",0,-10)
	else
		popup.button_catchup_disable:Hide()
		popup.button_catchup_curent:Show()
		popup.button_catchup_best:Show()
		popup.subheader_cleanup:SetPoint("TOP",popup.button_catchup_curent,"BOTTOM",0,-10)
	end

	ZGV.QuestDB.GuideHelperMenu:Show()
end

function ZGV.QuestDB:ExplainStep()
	ZGV.db.char.chain_log = ""
	local verbose_status = {[-1] = "will never be acceptable", [1]="is acceptable now", [2]="not possible, maybe in future"}
	if not ZGV.CurrentGuide then return end
	if not ZGV.CurrentStep then return end
	for _,goal in pairs(ZGV.CurrentStep.goals) do
		if goal.action == "accept" then
			local quest = goal.questid
			local state,comment = ZGV.QuestDB:IsQuestPossible(quest)
			local complete = goal:IsComplete()

			print("Quest",quest,verbose_status[state],comment)
			print(" - goal is complete:",complete)
			print(" - would goal be skipped:",ZGV.QuestDB:MaybeSkipThisGoal(goal))
			if ZGV.ChainsBreadcrumbs[prereqs] then 
				print("- is a breadcrumb") 
			end
			if ZGV.ChainsSiblings[questid] then
				print(" - has siblings",table.concat(ZGV.ChainsSiblings[questid],","))
			end
			local chain = ZGV.QuestDB:GetChain(quest,nil,nil,"")
			local chaintxt = ""  for i,v in pairs(chain) do chaintxt=chaintxt..i.."-"..tostring(PlayerIsOnQuest(i)).."-"..tostring(ZGV.completedQuests[i])..", " end
			local chainmsg = ZGV.db.char.chain_log:gsub("\n",", ")
			print(" - quests in chain",chaintxt)
			print(" - chain messages",chainmsg)
			print(" ")
		end
	end
end

tinsert(ZGV.startups,{"Quest DB",function(self)
	ZGV.QuestDB:Init()
	ZGV.QuestDB:CreateButton()
end})