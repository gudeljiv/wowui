local ZGV = ZygorGuidesViewer
if not ZGV then return end


ZGV.Skills = {}
local Skills = ZGV.Skills


tinsert(ZGV.startups,{"Skills setup",function(self)
	Skills:CleanSkillTable()
	Skills:MakeSkillsPopup()

	Skills.WorkerFrame=CreateFrame("FRAME")
	Skills.WorkerFrame:Show()

	local _,name = UnitClass("player")
	Skills.ClassNameForTrainers = name:lower():gsub("^%l", string.upper)
end})

function Skills:CleanSkillTable()
	local _,classname = UnitClass("player")

	for class,classdata in pairs(Skills.SkillTraining) do
		-- remove skills not for current class
		if class~=classname then 
			Skills.SkillTraining[class]=nil 
		else
			for level,skills in pairs(classdata) do
				for i,skilldata in ipairs(skills) do
					-- remove wrong faction and race skills
					if (skilldata.faction and not ZGV:RaceClassMatch(skilldata.faction)) or (skilldata.race and not ZGV:RaceClassMatch(skilldata.race)) then
						skills[i]=nil
					else
					-- query server for names, ranks and icons
						skilldata.faction = nil
						skilldata.race = nil
						local s = Spell:CreateFromSpellID(skilldata[1])
						local name, rank, icon = GetSpellInfo(skilldata[1])
						skilldata.name = name
						skilldata.rank = s:GetSpellSubtext() -- most likely empty right now, but will trigger UpdateSkillRank
						skilldata.icon = icon
					end
				end
			end
		end
	end

	local required_talents = {}
	Skills.TalentsDependants = {}

	-- clone talent locks, set condition env
	for level=1,60 do
		local skills = Skills.SkillTraining[classname][level]
		if skills then
			for _,skilldata in ipairs(skills) do
				if type(skilldata.optional)=="string" then
					skilldata.optional_raw = skilldata.optional
					skilldata.optional = ZGV.Parser.MakeCondition(skilldata.optional_raw)
					setfenv(skilldata.optional,ZGV.Parser.ConditionEnv)
				end

				if skilldata.req and (not skilldata.talent) and required_talents[skilldata.req] then
					skilldata.talent = required_talents[skilldata.req]
					required_talents[skilldata.skill] = required_talents[skilldata.req]
				end

				if skilldata.req then
					Skills.TalentsDependants[skilldata.req] = skilldata[1]
				end
			end
		end
	end
end

function Skills:IsDependantKnown(skill)
	if not Skills.TalentsDependants[skill] then return false end

	local dep = Skills.TalentsDependants[skill]
	if IsSpellKnown(dep) or IsPlayerSpell(dep) then return true end
	return Skills:IsDependantKnown(dep)
end

function Skills:MakeSkillsPopup()
	local CHAIN = ZGV.ChainCall
	local FONT=ZGV.Font
	local FONTBOLD=ZGV.FontBold
	local MAXWIDTH=350

	local BUTTON_HEIGHT = 30

	local limits = {normal=5,optional=3,future=3}


	Skills.SkillsPopup = ZGV.PopupHandler:NewPopup("ZGVSkillsTraining","skills")
	local popup = Skills.SkillsPopup
	popup.text:SetText("")
	popup.text2:SetText("You have new class skills available:")
	popup.acceptbutton:SetText("Find trainer")

	for set,limit in pairs(limits) do
		popup[set.."header"] = CHAIN(popup:CreateFontString(nil,"LOW")) 
			:SetFont(FONT,12) 
		.__END
		popup[set.."headerdecor"] = CHAIN(popup:CreateTexture(nil,"LOW")) 
			:SetSize(1,1) 
			:SetPoint("TOP",popup[set.."header"],"BOTTOM") 
			:SetPoint("LEFT",popup,"LEFT",5,0) 
			:SetPoint("RIGHT",popup,"RIGHT",-5,0) 
			:SetTexture(ZGV.DIR.."\\Skins\\white")
			:SetVertexColor(0.7,0.7,0.7,1)
		.__END

		popup[set.."more"] = CHAIN(ZGV.UI:Create("Button",popup)) 
			:SetPoint("LEFT",popup[set.."header"],"RIGHT",10,0) 
			:SetPoint("RIGHT",popup,"RIGHT",-10,0) 
			:SetFont(FONT,10) 
			:SetBackdropColor(0,0,0,0)         
			:SetBackdropBorderColor(0,0,0,0)   
			:SetNormalBackdropColor(0,0,0,0)   
			:SetHighlightBackdropColor(0,0,0,0)
			:SetText("And more...")
			:SetScript("OnClick",function() popup:ToggleSet(set) end)
		.__END
		CHAIN(ZGVSkillsTraining[set.."more"]:GetFontString())
			:ClearAllPoints()
			:SetPoint("RIGHT",ZGVSkillsTraining[set.."more"],"RIGHT")
	end

	popup.normalheader:SetText("Essential")
	popup.optionalheader:SetText("Optional")
	popup.futureheader:SetText("Future")

	popup.normalcontent = CHAIN(CreateFrame("Frame", nil, popup))
			:SetPoint("TOPLEFT")
			:SetPoint("BOTTOMRIGHT")
			:SetWidth(290)
			:SetHeight(100)
		.__END
		popup.normalscroll = CHAIN(ZGV.UI:Create("ScrollChild",popup,nil,popup.normalcontent))
			:SetPoint("TOPLEFT",popup.normalheader,"BOTTOMLEFT",0,-10)
			:SetPoint("RIGHT",popup,"RIGHT",-16,0)
			:SetHeight(100)
			:Show()
			.__END
		popup.normalscroll:SetHideWhenUseless(true)

	popup.optionalcontent = CHAIN(CreateFrame("Frame", nil, popup))
			:SetPoint("TOPLEFT")
			:SetPoint("BOTTOMRIGHT")
			:SetWidth(290)
			:SetHeight(100)
		.__END
		popup.optionalscroll = CHAIN(ZGV.UI:Create("ScrollChild",popup,nil,popup.optionalcontent))
			:SetPoint("TOPLEFT",popup.optionalheader,"BOTTOMLEFT",0,-10)
			:SetPoint("RIGHT",popup,"RIGHT",-16,0)
			:SetHeight(100)
			:Show()
			.__END
		popup.optionalscroll:SetHideWhenUseless(true)

	popup.futurecontent = CHAIN(CreateFrame("Frame", nil, popup))
			:SetPoint("TOPLEFT")
			:SetPoint("BOTTOMRIGHT")
			:SetWidth(290)
			:SetHeight(100)
		.__END
		popup.futurescroll = CHAIN(ZGV.UI:Create("ScrollChild",popup,nil,popup.futurecontent))
			:SetPoint("TOPLEFT",popup.futureheader,"BOTTOMLEFT",0,-10)
			:SetPoint("RIGHT",popup,"RIGHT",-16,0)
			:SetHeight(100)
			:Show()
			.__END
		popup.futurescroll:SetHideWhenUseless(true)

	popup.normalheader:SetPoint("TOPLEFT",popup.text2,"BOTTOMLEFT",0,-10)
	popup.optionalheader:SetPoint("TOPLEFT",popup.normalscroll,"BOTTOMLEFT",0,-10)
	popup.futureheader:SetPoint("TOPLEFT",popup.normalscroll ,"BOTTOMLEFT",0,-10)


	local function make_button(parent)
		local button = 	CHAIN(CreateFrame("Button"))
			:SetSize(275,BUTTON_HEIGHT)
			:SetParent(parent)
		.__END
		button:SetScript("OnEnter",function()
			if button.spell then
				GameTooltip:SetOwner(button, "ANCHOR_CURSOR")
				GameTooltip:SetSpellByID(button.spell)
				GameTooltip:Show()
			end
		end)
		button:SetScript("OnLeave",function()
			GameTooltip:FadeOut()
		end)

		
		button.texture = CHAIN(button:CreateTexture(nil,"LOW")) 
			:SetSize(BUTTON_HEIGHT,BUTTON_HEIGHT) 
			:SetPoint("TOPLEFT",button) 
		.__END

		button.caption = CHAIN(button:CreateFontString(nil,"LOW")) 
			:SetPoint("LEFT",button.texture,"RIGHT",7,7) 
			:SetFont(FONT,12) 
			:SetText("caption")
		.__END
		button.cost = CHAIN(button:CreateFontString(nil,"LOW")) 
			:SetPoint("LEFT",button.texture,"RIGHT",7,-7) 
			:SetFont(FONT,12) 
			:SetText("cost")
		.__END


		button.remove = CHAIN(CreateFrame("Button"))
			:SetParent(button)
			:SetSize(12,12)
			:SetNormalTexture(ZGV.DIR.."\\Skins\\ban")
			:SetPoint("RIGHT",button)
			:SetBackdropColor(0,0,0,0)
			:SetBackdropBorderColor(0,0,0,0)
			:SetScript("OnClick", function(self) Skills:BanLearnableSkills(button.spell) end)
			:SetScript("OnEnter",function()
				GameTooltip:SetOwner(button, "ANCHOR_CURSOR")
				GameTooltip:AddLine("Don't report this skill")
				GameTooltip:Show()
			end)
			:SetScript("OnLeave",function()
				GameTooltip:FadeOut()
			end)
		.__END

		return button
	end




	popup.normal = {}
	popup.optional = {}
	popup.future = {}

	local BUTTON_MARGIN = 5

	function popup:AdjustSize()
		local offsets = 10 + 10 + 5 + 10 --Logo and top + text and buttons + buttons and bottom + header and icons
		local height = offsets + self.text:GetStringHeight() + self.text2:GetStringHeight() + self.logo:GetHeight() + self.acceptbutton:GetHeight()
		height = height + (popup.normalheader:GetStringHeight()+20)
		if popup.optionalheader:IsVisible() then height = height + (popup.optionalheader:GetStringHeight()+20) end
		if popup.futureheader:IsVisible() then height = height + (popup.futureheader:GetStringHeight()+20) end

		for set,limit in pairs(limits) do
			local scrollheight=0
			for i,button in ipairs(popup[set]) do 
				if button:IsVisible() then 
					scrollheight=scrollheight+button:GetHeight()+BUTTON_MARGIN
				end 
			end
			if scrollheight>0 then
				popup[set.."content"]:SetHeight(scrollheight)
				scrollheight = math.min(scrollheight,(BUTTON_HEIGHT+BUTTON_MARGIN)*limit)
				height = height + scrollheight
				popup[set.."scroll"]:SetHeight(scrollheight)
			end
		end

		local minWidth = self.acceptbutton:GetWidth() + self.declinebutton:GetWidth() + self.settings:GetWidth()
		local width = min(max(minWidth,max(self.text:GetStringWidth(),self.text2:GetStringWidth())) + 50 , MAXWIDTH)

		self:SetSize(width,height)
	end

	function popup:returnMinimizeSettings(count)
		local notifcationText = ZGV.L['notifcenter_skill_text']:format((popup.counts and popup.counts.normal) or count or 0)
		local title = ZGV.L['notifcenter_skill_title_'..popup.mode]
		local tooltipText = "Click to show the skill popup again"
		local priority = 1
		local removetime = nil
		local poptime = 5
		local quiet = popup:IsVisible()

		return notifcationText,title,tooltipText,priority,poptime,removetime,quiet
	end

	function popup:ToggleSet(set)
		if #popup[set]<=limits[set] then return end

		local state = not popup[set.."more"].expanded
		popup[set.."more"].expanded = state

		if state then
			popup[set.."more"]:SetText("- hide extra skills")
		else
			popup[set.."more"]:SetText("+"..(popup.counts[set]-limits[set]).." more")
		end

		local height=0
		local width = (#popup[set]>limits[set] and state) and 265 or 275
		for i,but in ipairs(popup[set]) do
			if i>limits[set] and not state then 
				but:Hide()
			else
				but:Show()
				but:SetWidth(width)
				height=height+but:GetHeight()+BUTTON_MARGIN
			end
		end

		popup[set.."content"]:SetHeight(height)
		popup[set.."scroll"]:TotalValue(height)
		popup[set.."scroll"]:SetValue(0)
		popup[set.."scroll"]:SetVerticalScroll(0)

		popup:AdjustSize()
	end

	function popup:OnAccept()
		ZGV.WhoWhere:FindNPC("Class"..Skills.ClassNameForTrainers)
		if popup.ResetTimer then ZGV:CancelTimer(popup.ResetTimer) end
		popup.ResetTimer = ZGV:ScheduleTimer(function() popup.LastTrainer = nil end,15*60)
	end

	function popup:OnDecline()
		if popup.ResetTimer then ZGV:CancelTimer(popup.ResetTimer) end
		popup.ResetTimer = ZGV:ScheduleTimer(function() popup.LastTrainer = nil end,15*60)
	end

	function popup:DisplaySkills(data,forceShow)
		for i,but in ipairs(popup.normal) do but:Hide() end
		for i,but in ipairs(popup.optional) do but:Hide() end
		for i,but in ipairs(popup.future) do but:Hide() end

		popup.optionalheader:Hide()
		popup.optionalheaderdecor:Hide()
		popup.futureheader:Hide()
		popup.futureheaderdecor:Hide()

		popup.normalmore:Hide()
		popup.optionalmore:Hide()
		popup.futuremore:Hide()

		popup.counts = {normal=#data[1],optional=#data[2],future=#data[3]}

		if #data[1]>limits.normal then
			popup.normalmore:Show()
			popup.normalmore:SetText("+"..(#data[1]-limits.normal).." more")
		end

		for i,skill in ipairs(data[1]) do
			popup.normal[i] = popup.normal[i] or make_button(popup.normalcontent)
			local but = popup.normal[i]

			if i==1 then
				but:SetPoint("TOPLEFT",popup.normalcontent,"TOPLEFT",0,0)
			else
				but:SetPoint("TOPLEFT",popup.normal[i-1],"BOTTOMLEFT",0,-BUTTON_MARGIN)
			end

			but.texture:SetTexture(skill[2])
			but.caption:SetText(skill[1].." "..skill[4])
			but.cost:SetText(ZGV.GetMoneyString(skill[5]))
			but.spell = skill[3]

			if i>limits.normal then 
				but:Hide()
			else
				but:Show()
			end
			popup.optionalheader:SetPoint("TOPLEFT",popup.normalscroll,"BOTTOMLEFT",0,-10)
			popup.futureheader:SetPoint("TOPLEFT",popup.normalscroll,"BOTTOMLEFT",0,-10)
		end


		if #data[2]>0 then
			popup.optionalheader:Show()
			popup.optionalheaderdecor:Show()
			if #data[2]>limits.optional then
				popup.optionalmore:Show()
				popup.optionalmore:SetText("+"..(#data[2]-limits.optional).." more")
			end

			for i,skill in ipairs(data[2]) do
				popup.optional[i] = popup.optional[i] or make_button(popup.optionalcontent)
				local but = popup.optional[i]

				if i==1 then
					but:SetPoint("TOPLEFT",popup.optionalcontent,"TOPLEFT",0,0)
				else
					but:SetPoint("TOPLEFT",popup.optional[i-1],"BOTTOMLEFT",0,-BUTTON_MARGIN)
				end

				but.texture:SetTexture(skill[2])
				but.caption:SetText(skill[1].." "..skill[4])
				but.cost:SetText(ZGV.GetMoneyString(skill[5]))
				but.spell = skill[3]

				if i>limits.optional then 
					but:Hide()
				else
					but:Show()
				end
			end
			popup.futureheader:SetPoint("TOPLEFT",popup.optionalscroll,"BOTTOMLEFT",0,-10)
		end

		if #data[3]>0 then
			popup.futureheader:Show()
			popup.futureheaderdecor:Show()
			if #data[3]>limits.future then
				popup.futuremore:Show()
				popup.futuremore:SetText("+"..(#data[3]-limits.future).." more")
			end

			for i,skill in ipairs(data[3]) do
				popup.future[i] = popup.future[i] or make_button(popup.futurecontent)
				local but = popup.future[i]
				but.caption:SetTextColor(0.7,0.7,0.7,0.7)
				but.texture:SetDesaturated(true)

				if i==1 then
					but:SetPoint("TOPLEFT",popup.futurecontent,"TOPLEFT",0,0)
				else
					but:SetPoint("TOPLEFT",popup.future[i-1],"BOTTOMLEFT",0,-BUTTON_MARGIN)
				end

				but.texture:SetTexture(skill[2])
				but.caption:SetText(skill[1].." "..skill[4])
				but.cost:SetText("in "..skill[6].. " level"..(skill[6]>1 and "s" or ""))
				but.spell = skill[3]

				if i>limits.future then 
					but:Hide()
				else
					but:Show()
				end
			end
		end

		popup.count = #data[1]

		if forceShow then
			Skills.SkillsPopup:Show()
		else
			ZGV.PopupHandler:QueuePush(self)
		end
	end

	if ZGV.db.profile.n_popup_skills_login then 
		ZGV:ScheduleTimer(function() 
			Skills:ShowSkillPopup() 
		end,1) 
	end
	Skills.SkillDistanceTimer = ZGV:ScheduleRepeatingTimer(function() Skills:MaybeShowPopupByDistance() end, 2)	
end

function Skills:BanLearnableSkills(skillid)
	local name, rank, icon = GetSpellInfo(skillid)
	if name then
		ZGV.db.char.bannedskills[name] = true
		Skills:RefreshSkillPopup()
	end
end



function Skills:GetLearnableSkills(level)
	local level = level or UnitLevel("player")
	local _,classname = UnitClass("player")

	local function get_by_name(arr,sdata)
		for i,v in ipairs(arr) do
			if v.name==sdata.name then return v end
		end
		table.insert(arr,{name=sdata.name, icon=sdata.icon, ranks={}, skill=sdata[1]})
		return arr[#arr]
	end

	local results,opt_results,future_results = {},{},{}

	for slevel=1,60 do
		local skills=Skills.SkillTraining[classname][slevel]
		if slevel<=level and skills then
			for _,sdata in pairs(skills) do
				local skill=sdata[1]
				if not (IsSpellKnown(skill) or IsPlayerSpell(skill) or Skills:IsDependantKnown(skill)) -- already known
				   and not ZGV.db.char.bannedskills[sdata.name] -- not banned
				   and (not sdata.talent or IsSpellKnown(sdata.talent) or IsPlayerSpell(sdata.talent)) -- no required talent, or talent known
				   then
					if (sdata.optional==true) or (type(sdata.optional)=="function" and sdata.optional())  then
						if ZGV.db.profile.n_popup_skills_optional then
							local entry = get_by_name(opt_results,sdata)
							table.insert(entry.ranks,{skill=sdata.skill,rank=(sdata.rank or ""):gsub("%D+", ""),cost=sdata[1],req=sdata.req,talent=sdata.talent})
						end
					else
						local entry = get_by_name(results,sdata)
						table.insert(entry.ranks,{skill=sdata.skill,rank=(sdata.rank or ""):gsub("%D+", ""),cost=sdata[1],req=sdata.req,talent=sdata.talent})
					end
				end
			end
		end
	end

	if ZGV.db.profile.n_popup_skills_future then
		for slevel=level+1,60 do
			local skills=Skills.SkillTraining[classname][slevel]
			if #future_results>0 then break end

			if skills then
				for _,sdata in pairs(skills) do
					if (not sdata.talent or IsSpellKnown(sdata.talent) or IsPlayerSpell(sdata.talent)) 
					   and not Skills:IsDependantKnown(sdata[1])
					   and not ZGV.db.char.bannedskills[sdata.name] -- not banned
					   then
						local entry = get_by_name(future_results,sdata)
						entry.level = slevel-level
						table.insert(entry.ranks,{skill=sdata.skill,rank=(sdata.rank or ""):gsub("%D+", ""),cost=sdata[1],req=sdata.req,talent=sdata.talent})
					end
				end
			end
		end
	end
	
	-- show only if core skills are found
	if #results==0 then return end

	sort(results,function(a,b) return a.name<b.name end)
	sort(opt_results,function(a,b) return a.name<b.name end)
	sort(future_results,function(a,b) return a.name<b.name end)

	local display = {}

	for index,data in ipairs({results,opt_results,future_results}) do
		display[index]={}
		for _,skill in ipairs(data) do
			local minrank,maxrank,cost,ranks = nil,nil,0,""

			for _,rank in ipairs(skill.ranks) do
				if (not minrank) or (minrank>(tonumber(rank.rank) or 0)) then minrank=tonumber(rank.rank) or 0 end
				if (not maxrank) or (maxrank<(tonumber(rank.rank) or 0)) then maxrank=tonumber(rank.rank) or 0 end
				cost = cost + (rank.cost or 0)
			end

			local rankmsg = ""
			if minrank and maxrank and (minrank~=0 and maxrank~=0) then
				if minrank~=maxrank then 
					rankmsg = "ranks "..minrank.."-"..maxrank
				else
					rankmsg = "rank "..minrank
				end
			end
					
			table.insert(display[index],{skill.name,skill.icon,skill.skill,rankmsg,cost,skill.level})
		end
	end

	return display
end

function Skills:RefreshSkillPopup()
	if Skills.SkillsPopup:IsVisible() then
		Skills.SkillsPopup:Hide()
		Skills:ShowSkillPopup(nil,Skills.SkillsPopup.mode,"forceShow")
	elseif ZGV.NotificationCenter.GetButton("ZGVSkillsTraining") then
		ZGV.NotificationCenter.RemoveButton("ZGVSkillsTraining")
		Skills:ShowSkillNotification(nil,Skills.SkillsPopup.mode,"forceQuiet")
	end
end

function Skills:ShowSkillPopup(level,mode,forceShow)
	if not ZGV.db.profile.n_popup_skills then return end
	Skills.SkillsPopup.mode = mode or "default"

	local display = Skills:GetLearnableSkills(level)
	if display then Skills.SkillsPopup:DisplaySkills(display,forceShow) end
end

function Skills:ShowSkillNotification(level,mode,forceQuiet)
	if not ZGV.db.profile.n_popup_skills then return end
	Skills.SkillsPopup.mode = mode or "default"

	local display = Skills:GetLearnableSkills(level)

	if not display then return end

	local skills = #display[1]

	if skills==0 then return end

	local notifcationText,title,tooltipText,priority,poptime,removetime,quiet = Skills.SkillsPopup:returnMinimizeSettings(skills)

	ZGV.NotificationCenter.AddButton(
		"ZGVSkillsTraining",
		title,
		notifcationText,
		ZGV.DIR.."\\Skins\\icons-notificationcenter",
		{0,0.125,0,1},
		function() Skills:ShowSkillPopup(level,Skills.SkillsPopup.mode) end,
		tooltipText,
		priority,
		poptime,
		removetime,
		quiet or forceQuiet,
		OnOpen,
		"skills",
		{skills=skills})
end

local dist_threshold_show = 30
local dist_threshold_hide = 50
-- lifted from WhoWHere
local function CalcStep()
	if Skills.thread then
		local ok,err = coroutine.resume(Skills.thread)
		if not ok then print(ok,err) end
		if coroutine.status(Skills.thread)=="dead" then
			Skills.thread=nil
			Skills.WorkerFrame:SetScript("OnUpdate",nil)
		end
	end
	if Skills.SkillTrainerInDistance then
		if Skills.SkillsPopup.LastTrainer~=Skills.SkillTrainerInDistance then
			ZGV:Debug("&skills popup, showing by distance")
			Skills:ShowSkillPopup(nil,"distance")
			Skills.SkillsPopup.LastTrainer = Skills.SkillTrainerInDistance
		else
			ZGV:Debug("&skills popup, already shown for this npc")
		end
		Skills.SkillTrainerInDistance = nil
	end
end

-- lifted from WhoWHere
local function CalcThread()
	local x,y,m=LibRover:GetPlayerPosition()
	local parse=ZGV.NPCData.parseNPC
	local mindist,minid
	for id,data in ZGV.NPCData:iterate("Class"..Skills.ClassNameForTrainers) do
		local npc=parse(data)
		if tonumber(npc.m) and npc.m>0 then
			npc.x=npc.x*0.01
			npc.y=npc.y*0.01
			local dist=ZGV.HBD:GetZoneDistance(m,x,y,npc.m,npc.x,npc.y)

			if dist then
				if dist<dist_threshold_show then
					ZGV:Debug("&skills popup, found by distance "..id)
					Skills.SkillTrainerInDistance = id
					return true
				elseif npc.m==Skills.SkillSearchByMap and (npc.m~=Skills.SkillTrainerShownByMap) then
					ZGV:Debug("&skills popup, found for capital "..Skills.SkillSearchByMap)
					Skills.SkillTrainerShownByMap = Skills.SkillSearchByMap
					Skills:ShowSkillPopup(nil,"city")
					return true
				end
			--elseif Skills.SkillsPopup.LastTrainer==id and dist>dist_threshold_hide then
			--	Skills.SkillsPopup:DoFadeOut()
			end


		end
		coroutine.yield()
	end
	return false
end

local capitals = {
	[1455] = "Ironforge",
	[1453] = "Stormwind City",
	[1458] = "Undercity",
	[1457] = "Darnassus",
	[1454] = "Orgrimmar",
	[1456] = "Thunder Bluff",
}


function Skills:MaybeShowPopupByDistance()
	if not ZGV.db.profile.n_popup_skills then ZGV:Debug("&skills popup, disabled") return end
	
	local x,y,m=LibRover:GetPlayerPosition()

	if ZGV.db.profile.n_popup_skills_town and m and Skills.SkillTrainerShownByMap~=m then -- we changed maps, and care about town popups
		if capitals[m] then
			ZGV:Debug("&skills popup, new map - capital")
			Skills.SkillSearchByMap = m
		else
			ZGV:Debug("&skills popup, new map - not capital")
			Skills.SkillTrainerShownByMap = m -- mark map as having the popup already shown, so we don't retry it here
			Skills.SkillSearchByMap = nil
		end
	end

	if ZGV.db.profile.n_popup_skills_town or ZGV.db.profile.n_popup_skills_dist then
		Skills.WorkerFrame:SetScript("OnUpdate",CalcStep)
		Skills.thread = coroutine.create(CalcThread)
	end

end