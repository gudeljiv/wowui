local faction = UnitFactionGroup("player")
local _,class = UnitClass("player")
RXP_.functions = {}
RXP_.functions.__index = RXP_.functions
RXP_.functions.events = {}
RXP_.stepUpdateList = {}

RXP_.functions.events.collect = {"BAG_UPDATE_DELAYED","QUEST_ACCEPTED","QUEST_TURNED_IN"}
RXP_.functions.events.buy = {"BAG_UPDATE_DELAYED","MERCHANT_SHOW"}
RXP_.functions.events.accept = {"QUEST_ACCEPTED","QUEST_TURNED_IN","QUEST_REMOVED"}
RXP_.functions.events.turnin = {"QUEST_TURNED_IN"}
RXP_.functions.events.complete = {"QUEST_LOG_UPDATE"}
RXP_.functions.events.fp = {"UI_INFO_MESSAGE","TAXIMAP_OPENED"}
RXP_.functions.events.hs = {"UNIT_SPELLCAST_SUCCEEDED"}
RXP_.functions.events.home = {"HEARTHSTONE_BOUND"}
RXP_.functions.events.fly = {"PLAYER_CONTROL_LOST","TAXIMAP_OPENED","ZONE_CHANGED"}
RXP_.functions.events.deathskip = {"CONFIRM_XP_LOSS"}
RXP_.functions.events.xp = {"PLAYER_XP_UPDATE","PLAYER_LEVEL_UP"}
RXP_.functions.events.reputation = {"UPDATE_FACTION"}
RXP_.functions.events.vendor = {"MERCHANT_SHOW","MERCHANT_CLOSED"}
RXP_.functions.events.trainer = {"TRAINER_SHOW","TRAINER_CLOSED"}
RXP_.functions.events.stable = {"PET_STABLE_SHOW","PET_STABLE_CLOSED"}
RXP_.functions.events.tame = {"UNIT_SPELLCAST_SUCCEEDED","UNIT_SPELLCAST_START"}
RXP_.functions.events.money = {"PLAYER_MONEY"}
RXP_.functions.events.train = {"TRAINER_SHOW","CHAT_MSG_SYSTEM","SKILL_LINES_CHANGED","TRAINER_UPDATE"}
RXP_.functions.events.istrained = {"LEARNED_SPELL_IN_TAB","TRAINER_UPDATE"}
RXP_.functions.events.zone = {"ZONE_CHANGED_NEW_AREA"}
RXP_.functions.events.bankdeposit = {"BANKFRAME_OPENED","BAG_UPDATE_DELAYED"}
RXP_.functions.events.skipgossip = {"GOSSIP_SHOW"}

RXP_.functions.events.bankwithdraw = RXP_.functions.events.bankdeposit
RXP_.functions.events.abandon = RXP_.functions.events.complete
RXP_.functions.events.isQuestComplete = RXP_.functions.events.complete
RXP_.functions.events.isOnQuest = RXP_.functions.events.complete
RXP_.functions.events.isQuestTurnedIn = RXP_.functions.events.complete
RXP_.functions.events.cast = RXP_.functions.events.hs
RXP_.functions.events.blastedLands = RXP_.functions.events.collect

RXP_.icons = {
accept = "|TInterface/GossipFrame/AvailableQuestIcon:0|t",
turnin = "|TInterface/GossipFrame/ActiveQuestIcon:0|t",
collect = "|TInterface/GossipFrame/VendorGossipIcon:0|t",
combat = "|TInterface/GossipFrame/BattleMasterGossipIcon:0|t",
complete = "|TInterface/GossipFrame/HealerGossipIcon:0|t",
vendor = "|TInterface/GossipFrame/BankerGossipIcon:0|t",
reputation = "|TInterface/GossipFrame/WorkOrderGossipIcon:0|t",
fly = "|TInterface/GossipFrame/TaxiGossipIcon:0|t",
fp = "|TInterface/AddOns/RXPGuides/Textures/fp:0|t",
hs = "|TInterface/MINIMAP/TRACKING/Innkeeper:0|t",
trainer = "|TInterface/GossipFrame/TrainerGossipIcon:0|t",
train = "|TInterface/GossipFrame/TrainerGossipIcon:0|t",
arrow = "|TInterface/MINIMAP/MinimapArrow:0|t",
marker = "|TInterface/WORLDSTATEFRAME/ColumnIcon-FlagCapture2:0|t",
goto = "|TInterface/MINIMAP/POIICONS:0:0:0:0:128:128:96:112:0:15|t",
deathskip = "|TInterface/MINIMAP/POIICONS:0:0:0:0:128:128:112:127:0:15|t",
home = "|TInterface/MINIMAP/POIICONS:0:0:0:0:128:128:64:79:0:15|t",
xp = "|TInterface/PETBATTLES/BattleBar-AbilityBadge-Strong-Small:0|t",
stable = "|TInterface/MINIMAP/TRACKING/StableMaster:0|t",
tame = "|TInterface/ICONS/Ability_Hunter_BeastTaming:0|t",
abandon = "|TInterface/GossipFrame/IncompleteQuestIcon:0|t",
link = "|TInterface/FriendsFrame/UI-FriendsFrame-Link:0|t",
error = "|TInterface/Buttons/UI-GroupLoot-Pass-Up:0|t",
}

RXP_.icons.buy = RXP_.icons.collect
RXP_.icons.xpto60 = RXP_.icons.xp

function RXP_.error(msg)
    print(msg)
    return
end


local IsQuestTurnedIn = C_QuestLog.IsQuestFlaggedCompleted

if not IsQuestTurnedIn then
    IsQuestTurnedIn = IsQuestFlaggedCompleted
    if not IsQuestTurnedIn then
        IsQuestTurnedIn = function(id)
            return GetQuestsCompleted()[id]
        end
    end
end

local function IsQuestComplete(id)
    for i = 1,GetNumQuestLogEntries() do
        local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(i);
        if questID == id then
            if isComplete then
                return true
            else
                return false
            end
        end
    end
end

RXP_.IsQuestTurnedIn = IsQuestTurnedIn
RXP_.IsQuestComplete = IsQuestComplete

local questConversion = {
[9684] = 63866,

}

local timer = GetTime()
local nrequests = 0
local requests = {}
local questNameCache = {}
local questObjectivesCache = {}

local db
if QuestieLoader then 
    db = QuestieLoader:ImportModule("QuestieDB")
end

function RXP_.FormatNumber(number,precision)
    if not precision then
        precision = 0
    end
    local integer = math.floor(number)
    local decimal = math.floor((number-integer)*10^precision+0.5)
    if decimal > 0 then
        decimal = '.'..tostring(decimal)
    else
        decimal = ""
    end
    integer = tostring(integer)
    local i = #integer % 3
    if i == 0 then
        i = 3
    end

    local suffix = string.sub(integer,i+1)
    integer = string.sub(integer,1,i)

    for n in string.gmatch(suffix,"%d%d%d") do
        integer = integer..","..n
    end
    return integer..decimal
end

function RXP_.GetQuestName(id)
    if not id then return end
    id = questConversion[id] or id
    
    if db and type(db.QueryQuest) == "function" and type(db.GetQuest) == "function" then
        local quest = db:GetQuest(id)
        if quest and quest.name then
            return quest.name
        end
    end
    
    if C_QuestLog.IsOnQuest(id) then
        for i = 1,GetNumQuestLogEntries() do
            local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(i);
            if questID == id then
                questNameCache[id] = questLogTitleText
                return questLogTitleText
            end
        end
    else
        local ctime = GetTime()
        if ctime - timer > 1 then
            timer = ctime
            nrequests = 0
        end

        if nrequests < 3 or requests[id] == 0 then
            if (not requests[id] or ctime-requests[id] > 3) and HaveQuestData(id) then
                requests[id] = 0
                return C_QuestLog.GetQuestInfo(id)
            elseif not requests[id] then
                requests[id] = GetTime()
            elseif ctime-requests[id] <= 3 then
                return questNameCache[id]
            else
                requests[id] = GetTime()
            end
            nrequests = nrequests + 1

        end
        return questNameCache[id]
    end
end


function RXP_.GetQuestObjectives(id,step)
    id = questConversion[id] or id
    step = step or 0
    if not id then return end
    local err = false
    if C_QuestLog.IsOnQuest(id) then
        local questInfo = {}
        for i = 1,GetNumQuestLogEntries() do
            local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(i);
            local nObj = 0
            if questID == id then
                for j = 1,GetNumQuestLeaderBoards(i) do
                    local description, objectiveType, isCompleted = GetQuestLogLeaderBoard(j,i)
                    if description then
                        nObj = nObj + 1
                        local required,fulfilled = description:match("(%d+)/(%d+)")
                        if required then
                            required = tonumber(required)
                            fulfilled = tonumber(fulfilled)
                        else
                            required = 1
                            if isCompleted then
                                fulfilled = 1
                            else
                                fulfilled = 0
                            end
                        end
                        questInfo[j] = {text = description, type = objectiveType,numRequired = required, numFulfilled = fulfilled, finished = isCompleted}
                    else
                        err = true
                        break
                    end
                end
                if err then
                    if GetNumQuestLeaderBoards(i) == 1 or nObj == 0 then
                        local fulfilled = 0
                        if isComplete then
                            fulfilled = 1
                        end
                        questInfo[1] = { text = "Objective Complete", type = "event",numRequired = 1, numFulfilled = fulfilled, finished = isComplete }
                    end
                else
                    questObjectivesCache[id] = questInfo
                    return questInfo
                end
            end
        end
    elseif db and type(db.QueryQuest) == "function" and math.abs(RXPCData.currentStep-step) > 4 and type(db.GetQuest) == "function" then
        local qInfo = {}
        local q = db:GetQuest(id)
        --print(type(q))
        local objectives
        if q and q.ObjectiveData then
            objectives = q.ObjectiveData
        else
            err = true
        end
        if objectives then
            local nObj = 0
            for i,quest in pairs(objectives) do
                nObj = nObj + 1
                local qType = quest.Type
                local objId = quest.Id
                qInfo[i] = {type = qType, finished = false, questie = true}
                if qType == "monster" then
                    local npc = db:GetNPC(objId)
                    if npc and npc.name then
                        qInfo[i].text = npc.name
                    else
                        qInfo[i].text = ""
                    end
                elseif qType == "item" then
                    qInfo[i].text = db:GetItem(objId).name
                elseif quest.Text then
                    qInfo[i].text = quest.Text
                else
                    err = true
                    break
                end
            end
        end
        if not err then
            if nObj == 0 then
                qInfo[1] = { text = "Objective Complete", type = "event",numRequired = 1, numFulfilled = 0, finished = false }
            end
            return qInfo
        end
    end
    
    if not C_QuestLog.IsOnQuest(id) or err then
        local ctime = GetTime()
        if ctime - timer > 1 then
            timer = ctime
            nrequests = 0
        end

        if nrequests < 3 or requests[id] == 0 then
            if (not requests[id] or ctime-requests[id] > 3) and HaveQuestData(id) then
                requests[id] = 0
                --print(id,GetTime()-base)
                local questInfo = C_QuestLog.GetQuestObjectives(id)
                if #questInfo == 1 and (questInfo[1].type == "" or not questInfo[1].type) then
                    questInfo[1] = { text = "Objective Complete", type = "event",numRequired = 1, numFulfilled = 0, finished = false }
                end
                return questInfo
            elseif not requests[id] then
                requests[id] = GetTime()
            elseif ctime-requests[id] <= 3 then
                return questObjectivesCache[id]
            else
                requests[id] = GetTime()
            end
            --print(id,GetTime()-base)
            nrequests = nrequests + 1
        end
        return questObjectivesCache[id]
    end
end

function RXP_.GetItemName(id)
    local name = GetItemInfo(id)
    if not name then
        RXP_.itemQueryList[id] = true
    end
    return name
end


function RXP_.SetElementComplete(self,disable)
    if not self.element.completed then
        self.element.completed = true
        self.element.skip = true
        RXP_.updateSteps = true
        RXP_.updateMap = true
    end
    if self.button then
        --print('----ok',disable)
        self.button:SetChecked(true)
        if disable then
            self.button:Disable()
        end
    end
end

function RXP_.SetElementIncomplete(self)
    if self.element.completed then
        self.element.completed = false
        RXP_.updateMap = true
    end
    if self.button then
        self.button:Enable()
        if not self.element.skip then
            self.button:SetChecked(false)
        end
    end
end

function RXP_.UpdateStepText(self)
    RXP_.updateStepText = true
    local index
    if type(self) == "number" then
        index = self
    else
        index = self.step.index
    end
    RXP_.stepUpdateList[index] = true
end

function RXP_.AldorScryerCheck(faction)
    if RXP_.version == "CLASSIC" then return true end
    local name, description, standingID, barMin, barMax, aldorRep = GetFactionInfoByID(932)
    local name, description, standingID, barMin, barMax, scryerRep = GetFactionInfoByID(934)
    
    if aldorRep and scryerRep then
        if type(faction) == "table" then
            if faction.aldor then
                faction = "Aldor"
            elseif faction.scryer then
                faction = "Scryer"
            end
        end
        if faction == "Aldor" then
            return (aldorRep > scryerRep)
        elseif faction == "Scryer" then
            return (aldorRep < scryerRep)
        end
    end
    return true
end

function RXP_.PhaseCheck(phase)
    if type(phase) == "table" then
        phase = phase.phase
    end
    
    if phase and RXPData.phase then
        local pmin,pmax
        pmin,pmax = phase:match("(%d+)%-(%d+)")
        if pmax then
            pmin = tonumber(pmin)
            pmax = tonumber(pmax)
        else
            pmin = tonumber(phase)
            pmax = 0xffff
        end
        if pmin and RXPData.phase >= pmin and RXPData.phase <= pmax then
            return true
        else
            return false
        end
    end
    
    return true
end

function RXP_.SeasonCheck(step)
    if RXPCData.SoM and step.era or step.som and not RXPCData.SoM then
        return false
    end
    return true
end

function RXP_.HardcoreCheck(step)
    local hc = RXPCData.hardcore
    if step.softcore and hc or step.hardcore and not hc then
        return false
    end
    return true
end

function RXP_.GetNpcId(unit)
    if not unit then
        unit = "target"
    end
    local _, _, _, _, _, npcId = strsplit('-', UnitGUID(unit) or '')
    return tonumber(npcId)
end


local HBD = LibStub("HereBeDragons-2.0")
local HBDPins = LibStub("HereBeDragons-Pins-2.0")



RXP_.pickUpList = {}
function RXP_.functions.accept(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        element.tag = "accept"
        local text,id = ...
        id = tonumber(id)
        if not id then return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid quest ID\n"..self) end
        element.title = ""
        element.questId = questConversion[id] or id
        --element.title = RXP_.GetQuestName(id)
        if text and text ~= "" then
            element.text = text
        else
            element.text = "Accept *quest*"
            element.requestFromServer = true
        end
        if element.text:match("%*quest%*") then
            element.retrieveText = true
        end
        element.tooltipText = RXP_.icons.accept..element.text
        
        if not RXP_.pickUpList[id] then
            RXP_.pickUpList[id] = ""
        end
        local step = RXP_.step
        local stepType = ""
        if step.hardcore then
            stepType = "!"
        elseif step.softcore then
            stepType = "#"
        end
        if step.som then
            stepType = stepType .. "+"
        elseif step.era then
            stepType = stepType .. "-"
        end
        if step.phase then
            stepType = stepType .. "["..step.phase.."]"
        end
        
        RXP_.pickUpList[id] = format("%s\n%s %s",RXP_.pickUpList[id],stepType,RXP_.currentGuideName)
        
        return element
    else
        local element = self.element
        local step = element.step
        local event,arg1,questId = ...
        local id = element.questId
        local isQuestAccepted = IsQuestTurnedIn(id) or C_QuestLog.IsOnQuest(id) or (event == "QUEST_ACCEPTED" and questId == id)
        
        if element.step.active or element.retrieveText or (element.step.index > 1 and RXP_.currentGuide.steps[element.step.index-1].active) then
            RXP_.questAccept[id] = element
            local quest = RXP_.GetQuestName(id,element)
            if quest then
                element.title = quest
                RXP_.questAccept[quest] = element
                element.text = element.text:gsub("%*quest%*",quest)
                if element.requestFromServer then
                    element.requestFromServer = nil
                    RXP_.UpdateStepText(self)
                end
            else
                element.title = ""
                element.requestFromServer = true
            end
        end

        local icon = RXP_.icons.accept
        local skip
        if step.active and db and type(db.QueryQuest) == "function" and not isQuestAccepted and not RXP_.skipPreReq[id] then
            local quest = db:GetQuest(id)
            if quest then
                local preQuest = quest:IsPreQuestGroupFulfilled() and quest:IsPreQuestSingleFulfilled()
                if quest.preQuestSingle then
                    for _,qID in pairs(quest.preQuestSingle) do
                        if RXP_.questTurnIn[qID] and (RXP_.questAccept[qID] or C_QuestLog.IsOnQuest(qID)) then
                            preQuest = quest:IsPreQuestGroupFulfilled()
                            break
                        end
                    end
                end
                if not preQuest then
                    local requiredQuests
                    requiredQuests = quest.preQuestGroup or quest.preQuestSingle or {}
                    local tooltip = RXP_.colors.tooltip.."Missing pre-requisites:|r\n"
                    for i,qid in ipairs(requiredQuests) do
                        tooltip = format("%s\n%s%s (%d)",tooltip,RXP_.icons.turnin,db:GetQuest(qid).name,qid)
                    end
                    element.tooltip = tooltip
                    element.icon = RXP_.icons.error
                    skip = RXPData.skipMissingPreReqs
                else
                    element.icon = icon
                    element.tooltip = nil
                end
            end
        else
            element.icon = icon
            element.tooltip = nil
        end


        element.tooltipText = RXP_.icons.accept..element.text
        

        if isQuestAccepted then
            RXP_.SetElementComplete(self,true)
        elseif skip then
            RXP_.SetElementComplete(self)
        elseif event == "QUEST_REMOVED" and arg1 == id and not element.skip then
            RXP_.SetElementIncomplete(self)
        end

    end

end

RXP_.turnInList = {}
function RXP_.functions.turnin(self,...)

    if type(self) == "string" then --on parse
        local element = {}
        element.tag = "turnin"
        local text,id,reward = ...
        id = tonumber(id)
        if not id then return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid quest ID\n"..self) end
        element.questId = questConversion[id] or id
        element.reward = tonumber(reward) or 0
        element.title = ""
        --element.title = RXP_.GetQuestName(id)
        if text and text ~= "" then
            element.text = text
        else
            element.text = "Turn in *quest*"
            element.requestFromServer = true
        end
        if element.text:match("%*quest%*") then
            element.retrieveText = true
        end
        element.tooltipText = RXP_.icons.turnin..element.text
        if not RXP_.turnInList[id] then
            RXP_.turnInList[id] = ""
        end
        local step = RXP_.step
        local stepType = ""
        if step.hardcore then
            stepType = "!"
        elseif step.softcore then
            stepType = "#"
        end
        if step.som then
            stepType = stepType .. "+"
        elseif step.era then
            stepType = stepType .. "-"
        end
        if step.phase then
            stepType = stepType .. "["..step.phase.."]"
        end
        
        RXP_.turnInList[id] = format("%s\n%s %s",RXP_.turnInList[id],stepType,RXP_.currentGuideName)
        return element
    else
        local element = self.element
        local step = element.step
        local event,questId = ...
        local id = element.questId
        
        
        if step.active or element.retrieveText then
            RXP_.questTurnIn[id] = element
            RXP_.questAccept[id] = RXP_.questAccept[id] or element
            local quest = RXP_.GetQuestName(id,true)
            if quest then
                element.title = quest
                RXP_.questTurnIn[quest] = element
                RXP_.questAccept[quest] = RXP_.questAccept[quest] or element
                element.text = element.text:gsub("%*quest%*",quest)
                if element.requestFromServer then
                    element.requestFromServer = nil
                    RXP_.UpdateStepText(self)
                end
            else
                element.title = ""
                element.requestFromServer = true
            end
        end
        
        local icon = RXP_.icons.turnin
        local skip
        if step.active and db and type(db.QueryQuest) == "function" and not RXP_.questAccept[id] and not RXP_.skipPreReq[id] then
            local quest = db:GetQuest(id)
            if not C_QuestLog.IsOnQuest(id) and quest and not quest.IsRepeatable then
                local requiredQuests = {}
                local preQuest = quest:IsPreQuestGroupFulfilled() and quest:IsPreQuestSingleFulfilled()
                local questList
                if not preQuest then
                    questList = quest.preQuestGroup or quest.preQuestSingle
                end
                if questList then
                    for _,qID in ipairs(questList) do
                        table.insert(requiredQuests,qID)
                    end
                end
                table.insert(requiredQuests,id)
                local tooltip = RXP_.colors.tooltip.."Missing pre-requisites:|r\n"
                for i,qid in ipairs(requiredQuests) do
                    if i < #requiredQuests then
                        tooltip = format("%s\n%s%s (%d)",tooltip,RXP_.icons.turnin,db:GetQuest(qid).name,qid)
                    else
                        tooltip = format("%s\n%s%s (%d)",tooltip,RXP_.icons.accept,db:GetQuest(qid).name,qid)
                    end
                end
                element.tooltip = tooltip
                element.icon = RXP_.icons.error
                skip = RXPData.skipMissingPreReqs
            else
                element.icon = icon
                element.tooltip = nil
            end
        else
            element.icon = icon
            element.tooltip = nil
        end
        
        element.tooltipText = element.icon..element.text
        RXP_.UpdateStepText(self)

        local isComplete = IsQuestTurnedIn(id)
        if isComplete then
            RXP_.SetElementComplete(self,true)
        elseif questId == id or skip then --repeatable quests
            RXP_.SetElementComplete(self)
        end
    end

end

local questMonster = string.gsub(QUEST_MONSTERS_KILLED,"%d+%$","")
questMonster = questMonster:gsub("%%s","%.%*"):gsub("%%d","%%d%+")
local questItem = string.gsub(QUEST_ITEMS_NEEDED,"%%s","%(%.%*%)"):gsub("%%d","%%d%+")


function RXP_.UpdateQuestCompletionData(self)
    
    local element = self.element
    if not element then return end
    local step = element.step
    local icon = RXP_.icons.complete
    local id = element.questId
    if type(id) ~= "number" then
        print('Error: Invalid quest ID at step '..element.step.index)
        return
    end
    local skip
    local objectives = RXP_.GetQuestObjectives(id,element.step.index)
    local isQuestComplete = IsQuestTurnedIn(id) or IsQuestComplete(id)
    
    local objtext
    local completed
    
    if objectives and #objectives > 0 then
        if element.obj and element.obj <= #objectives then
            local obj = objectives[element.obj]
            local t = obj.text

            if obj.type == "item" then
                icon = RXP_.icons.collect
            elseif obj.type == "monster" and (t:match(questMonster) or obj.questie) then
                icon = RXP_.icons.combat
            end

            if not obj.questie then
                if obj.type == "event" then 
                    if isQuestComplete then
                        t = string.format(t..": %d/%d",obj.numRequired,obj.numRequired)
                    else
                        t = string.format(t..": %d/%d",obj.numFulfilled,obj.numRequired)
                    end
                elseif isQuestComplete then
                    t = t:gsub(": %d+/(%d+)",": %1/%1")
                end
            end
            completed = obj.finished
            objtext = t
        else
            completed = true
            for i,obj in pairs(objectives) do
                local t = obj.text
                completed = completed and obj.finished
                if not obj.questie then
                    if obj.type == "event" then 
                        if isQuestComplete then
                            t = string.format(t..": %d/%d",obj.numRequired,obj.numRequired)
                        else
                            t = string.format(t..": %d/%d",obj.numFulfilled,obj.numRequired)
                        end
                    elseif isQuestComplete then
                        t = t:gsub(": %d+/(%d+)",": %1/%1")
                    end
                end
                if objtext then
                    objtext = objtext.."\n"..t
                else
                    objtext = t
                end
            end
        end
    else
        element.text = "Retrieving quest data..."
        element.tooltipText = nil
        
        RXP_.UpdateStepText(self)
        return
    end
    
    if step.active and db and type(db.QueryQuest) == "function" and element.obj and not isQuestComplete and not RXP_.skipPreReq[id] then
        local quest = db:GetQuest(id)
        if quest and quest.ObjectiveData and quest.ObjectiveData[element.obj] then
            local itemId = quest.ObjectiveData[element.obj].Id
            local questType = quest.ObjectiveData[element.obj].Type
            local validQuest = true
            if questType == "item" then
                validQuest = select(12,GetItemInfo(itemId)) == 12 and select(11,GetItemInfo(itemId)) == 0
            end
            if not C_QuestLog.IsOnQuest(id) and validQuest then
                local requiredQuests = {}
                local preQuest = quest:IsPreQuestGroupFulfilled() and quest:IsPreQuestSingleFulfilled()
                local questList
                if not preQuest then
                    questList = quest.preQuestGroup or quest.preQuestSingle
                end
                if questList then
                    for _,qID in ipairs(questList) do
                        table.insert(requiredQuests,qID)
                    end
                end
                table.insert(requiredQuests,id)
                local tooltip = RXP_.colors.tooltip.."Missing pre-requisites:|r\n"
                for i,qid in ipairs(requiredQuests) do
                    if i < #requiredQuests then
                        tooltip = format("%s\n%s%s (%d)",tooltip,RXP_.icons.turnin,db:GetQuest(qid).name,qid)
                    else
                        tooltip = format("%s\n%s%s (%d)",tooltip,RXP_.icons.accept,db:GetQuest(qid).name,qid)
                    end
                end
                element.tooltip = tooltip
                element.icon = RXP_.icons.error
                skip = RXPData.skipMissingPreReqs
            else
                element.icon = icon
                element.tooltip = nil
            end
        end
    else
        element.icon = icon
        element.tooltip = nil
    end

    local quest 

    if objectives then
        quest = RXP_.GetQuestName(id,element)
    end

    if quest then
        element.title = quest
    else
        element.title = ""
    end
    local prefix = objtext:sub(1,1)
    if not quest or prefix == " " or prefix == ":" then
        element.requestFromServer = true
    elseif quest then
        element.requestFromServer = nil
    end

    if element.rawtext then
        element.rawtext = element.text:gsub("%*quest%*",element.title)
    end
    local text = element.rawtext

    completed = completed or isQuestComplete

    if text then
        text = text.."\n\n"..objtext
        element.tooltipText = icon..text:gsub("\n","\n   ")
    else
        element.tooltipText = icon..objtext:gsub("\n","\n   "..icon)
        text = objtext
    end
    element.text = text
   

    RXP_.UpdateStepText(self)

    if completed then
        RXP_.SetElementComplete(self,true)
    elseif skip then
        RXP_.SetElementComplete(self)
    else
        RXP_.SetElementIncomplete(self)
    end

end

function RXP_.QueueUpdate(ref,func,lowPrio)

    local update
    if lowPrio then
        update = RXP_.updateInactiveQuest
    else
        update = RXP_.updateActiveQuest
    end

    update[ref] = func

end

function RXP_.functions.complete(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,id,obj = ...
        id = tonumber(id)
        if not (id and obj) then 
            RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid objective or quest ID\n"..self)
        end
        element.obj = tonumber(obj)
        element.dynamicText = true
        --element.title = RXP_.GetQuestName(id)
        --local objectives = RXP_.GetQuestObjectives(id)--queries the server for items/creature names associated with the quest
        element.questId = questConversion[id] or id
        if text and text ~= "" then
            element.rawtext = text
            element.text = element.rawtext
            element.tooltipText = RXP_.icons.complete..element.text
        else
            element.text = ""
            element.requestFromServer = true
        end

        return element
    end
    local event = ...
    local step = self.element.step
    
    if event then
        if step.active then
            RXP_.updateActiveQuest[self] = RXP_.UpdateQuestCompletionData
        else
            RXP_.updateInactiveQuest[self] = RXP_.UpdateQuestCompletionData
        end
    else
        RXP_.UpdateQuestCompletionData(self)
    end
end




local lastZone
function RXP_.functions.goto(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        element.tag = "goto"
        local text,zone,x,y,radius,optional = ...
        if zone then
            lastZone = zone
        else
            zone = lastZone
        end
        element.x = tonumber(x)
        element.y = tonumber(y)
        if not (element.x and element.y and zone and RXP_.mapId[zone]) then
            return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid coordinates or map name\n"..self)
        end
        element.zone = RXP_.mapId[zone]
        element.radius = tonumber(radius)
        radius = element.radius
        element.wx,element.wy,element.instance = HBD:GetWorldCoordinatesFromZone(element.x/100, element.y/100, element.zone)
        
        element.arrow = true
        element.parent = true


        element.text = text
        element.textOnly = true

        if radius then
            if optional then
                element.optional = true
            elseif radius > 0 then
                if not text or text == "" then
                    element.text = string.format("Go to %.1f,%.1f (%s)",element.x,element.y,zone)
                end
                element.parent = nil
                element.textOnly = nil
                element.tooltipText = RXP_.icons.goto..element.text
            elseif radius <= 0 then
                element.arrow = nil
            end
        end
        return element
    end
end


function RXP_.functions.hs(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        element.tag = "hs"
        local text,location = ...
        if text and text ~= "" then
            element.text = text
        else
            element.textOnly = true
            element.text = "Set your Hearthstone to "..location
        end
        element.tooltipText = RXP_.icons.hs..element.text
        return element
    end
    local event,unit,_,id = ...
    if event == "UNIT_SPELLCAST_SUCCEEDED" and unit == "player" and (id == 8690 or id == 556 or id == 348699 or id == 184871) then
        RXP_.SetElementComplete(self)
    end
end

function RXP_.functions.home(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,location = ...
        element.tag = "home"
        if text and text ~= "" then
            element.text = text
        else
            element.textOnly = true
            element.text = "Set your Hearthstone to "..location
        end
        element.tooltipText = RXP_.icons.home..element.text
        return element
    end
    if not self.element.step.active then return end
    local event = ...
    if event == "HEARTHSTONE_BOUND" then
        RXP_.SetElementComplete(self)
    end
end

function RXP_.functions.fp(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,location = ...
        element.tag = "fp"
        if text and text ~= "" then
            element.text = text
        else
            element.textOnly = true
            element.text = "Get the "..location.." flight path"
        end
        
        if location and location ~= "" and location:match("%w+") then
            for id,name in pairs(RXP_.flightPath[faction]) do
                if strupper(name):match(strupper(location)) then
                    element.fpId = id
                    break
                end
            end
        end
        
        element.tooltipText = RXP_.icons.fp..element.text
        return element
    end
    local event,arg1,arg2 = ...
    local element = self.element
    if (element.fpId and RXPCData.flightPaths[element.fpId]) or (event == "UI_INFO_MESSAGE" and arg2 == ERR_NEWTAXIPATH and self.element.step.active) then
        RXP_.SetElementComplete(self)
    end
end

RXP_.taxiTime = 0
hooksecurefunc("TakeTaxiNode", function(index)
    RXP_.taxiTime = GetTime()
end)

function RXP_.functions.fly(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,location = ...
        element.tag = "fly"

        if text and text ~= "" then
            element.text = text
        elseif not location then
            return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid text/location\n"..self)
        else
            element.text = "Fly to "..location
        end
        if location and location ~= "" and location:match("%w") then
            element.location = strupper(location)
        end
        element.tooltipText = RXP_.icons.fly..element.text
        return element
    end
    if not self.element.step.active then return end
    local event = ...
    if event == "TAXIMAP_OPENED" and not RXPData.disableFPAutomation and self.element.location then
        local FPlist = C_TaxiMap.GetAllTaxiNodes(C_Map.GetBestMapForUnit("player"))
        local fpId = {}
        for k,v in pairs(FPlist) do
            if v.slotIndex then
                fpId[v.slotIndex] = v.nodeID
            end
        end
        
        for i = 1,NumTaxiNodes() do
            local name = fpId[i] and RXP_.flightPath[faction][fpId[i]]
            if name and strupper(name):match(self.element.location) then
                local taxi = getglobal("TaxiButton"..i)
                taxi:GetScript("OnEnter")(taxi)
                return TakeTaxiNode(i)
            end
        end
    elseif (event and UnitOnTaxi("player")) or (event == "PLAYER_CONTROL_LOST" and GetTime() - RXP_.taxiTime < 1.5) then
        RXP_.SetElementComplete(self)
    end
end


--

--"CONFIRM_XP_LOSS,PLAYER_UNGHOST"
function RXP_.functions.deathskip(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text = ...
        element.tag = "deathskip"
        if text and text ~= "" then
            element.text = text
        else
            element.text = "Die and respawn at the graveyard"
        end
        element.tooltipText = RXP_.icons.deathskip..element.text
        RXP_.step.softcore = true
        return element
    end
    if not self.element.step.active then return end
    local event = ...
    if event == "CONFIRM_XP_LOSS" then
        RXP_.SetElementComplete(self)
    end
end

function RXP_.functions.collect(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        element.dynamicText = true
        local text,id,qty,questId,isQuestTurnIn = ...
        id = tonumber(id)
        if not id then
            return RXP_.error('Error parsing guide '..RXP_.currentGuideName..': No item ID provided\n'..self)
        end
        element.isQuestTurnIn = isQuestTurnIn
        element.questId = tonumber(questId)
        element.id = id
        qty = tonumber(qty)
        element.qty = qty or 1
        element.itemName = RXP_.GetItemName(id)

        if text and text ~= "" then
            element.rawtext = text
            element.tooltipText = RXP_.icons.collect..element.rawtext
        else
            element.requestFromServer = true
            element.text = " "
        end
        return element
    end

    local element = self.element
    local questId = element.questId
    local name = RXP_.GetItemName(element.id)
    
    
    if name then
        element.requestFromServer = nil
    else
        name = ""
        element.requestFromServer = true
    end
    element.itemName = name

    local count = GetItemCount(element.id)
    for i = 1,18 do
        if GetInventoryItemID("player",i) == element.id then
            count = count + 1
            break
        end
    end
    
    if (element.qty > 0 and count > element.qty) or (questId and ((not element.isQuestTurnIn and C_QuestLog.IsOnQuest(questId)) or IsQuestTurnedIn(questId))) then
        count = element.qty
    end
    
    if element.rawtext then
        element.tooltipText = RXP_.icons.collect..element.rawtext
        element.text = string.format("%s\n%s: %d/%d",element.rawtext,element.itemName,count,element.qty)
    else
        element.text = string.format("%s: %d/%d",element.itemName,count,element.qty)
        element.tooltipText = RXP_.icons.collect..element.text
    end
    
    if element.lastCount ~= count then
        RXP_.UpdateStepText(self)
    end
    element.lastCount = count
    if element.qty > 0 and count >= element.qty then
        RXP_.SetElementComplete(self,true)
    elseif element.qty == 0 and count == 0 then
        RXP_.SetElementComplete(self)
    else
        RXP_.SetElementIncomplete(self)
    end
end

function RXP_.functions.destroy(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,id = ...
        id = tonumber(id)
        if not id then
            return RXP_.error('Error parsing guide '..RXP_.currentGuideName..': No item ID provided\n'..self)
        end

        element.id = id
        element.qty = qty or 1
        element.itemName = RXP_.GetItemName(id)

        if text and text ~= "" then
            element.rawtext = text
            element.tooltipText = RXP_.icons.collect..element.rawtext
        else
            element.requestFromServer = true
            element.text = " "
        end
        return element
    end

    local element = self.element
    local step = element and element.step
    if step and step.active then
        local name = RXP_.GetItemName(element.id)

        if name then
            element.requestFromServer = nil
        else
            name = ""
            element.requestFromServer = true
        end
        element.itemName = name

        local count = GetItemCount(element.id)
     

        if element.rawtext then
            element.tooltipText = RXP_.icons.collect..element.rawtext
            element.text = element.rawtext
        else
            element.text = string.format("Throw away %s%s from your bags",RXP_.icons.collect,element.itemName)
            element.tooltipText = element.text
        end
        RXP_.UpdateStepText(self)

        if count == 0 then
            RXP_.SetElementComplete(self)
        else
            RXP_.SetElementIncomplete(self)
        end
    end
end

function RXP_.functions.xp(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,str = ...

        str = str:gsub(" ","")
        local level,xp = str:match("(%d+)([%+%.%-]?%d*)")
        element.xp = tonumber(xp)
        element.level = tonumber(level)

        if text and text ~= "" then
            element.text = text
        else
            if element.xp and element.xp ~= 0 then
                if element.xp < 0 then
                    element.text = string.format("Grind until you are %d xp away from level %s",-1*element.xp,level)
                elseif element.xp >= 1 then
                    element.text = string.format("Grind until you are %s xp into level %s",xp,level)
                else
                    element.text = string.format("Grind until you are %.0f%% into level %s",element.xp*100,level)
                end
            else
                element.text = "Grind to level "..tostring(level)
            end
        end
        if not element.xp then element.xp = 0 end
        element.tooltipText = RXP_.icons.xp..element.text
        return element
    end
    local currentXP = UnitXP("player")
    local maxXP = UnitXPMax("player")
    local level = UnitLevel("player")
    local element = self.element

    if (element.xp < 0 and (level >= element.level or (level == element.level-1 and currentXP >= maxXP + element.xp))) or
       (element.xp >= 1 and ((level > element.level) or (element.level == level and currentXP >= element.xp))) or
       (element.xp >= 0 and element.xp < 1 and ((level > element.level) or (element.level == level and currentXP >= maxXP*element.xp)))
       then
        RXP_.SetElementComplete(self,true)
    end

end

function RXP_.functions.reputation(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,faction,str = ...

        str = str:gsub(" ","")
        local standing,rep = str:match("([%d%w]+)([%+%.%-]?%d*)")
        element.faction = tonumber(faction)
        element.rep = tonumber(rep) or 0
        
        if standing then
            standing = RXP_.repStandingID[strlower(standing)]
            element.standing = standing or tonumber(standing)
        end
        
        if not (faction and standing) then
            RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid faction/standing\n"..self)
        end
        
        if text and text ~= "" then
            element.text = text
        else
            local standinglabel = getglobal("FACTION_STANDING_LABEL"..element.standing)
            local factionname = GetFactionInfoByID(element.faction)
            if element.rep and element.rep ~= 0 then
                if element.rep < 0 then
                    element.text = string.format("Grind until you are %d away from %s with %s",-1*element.rep,standinglabel,factionname)
                elseif element.rep >= 1 then
                    element.text = string.format("Grind until you are %s into %s with %s",rep,standinglabel,factionname)
                else
                    element.text = string.format("Grind until you are %.0f%% into %s with %s",element.rep*100,standinglabel,factionname)
                end
            else
                element.text = string.format("Grind to %s with %s",standinglabel,factionname)
            end
        end
        if not element.rep then element.rep = 0 end
        element.tooltipText = RXP_.icons.reputation..element.text
        return element
    end

    local element = self.element
    local name, _, standing, bottomValue, topValue, earnedValue = GetFactionInfoByID(element.faction)
    if (element.rep < 0 and (standing >= element.standing or (standing == element.standing-1 and earnedValue >= topValue + element.rep))) or
       (element.rep >= 1 and ((standing > element.standing) or (element.standing == standing and earnedValue >= bottomValue + element.rep))) or
       (element.rep >= 0 and element.rep < 1 and ((standing > element.standing) or (element.standing == standing and earnedValue >= (topValue - bottomValue)*element.rep)))
       then
    RXP_.SetElementComplete(self,true)
    end
end

function RXP_.functions.vendor(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,id = ...
        element.id = tonumber(id)
        if text and text ~= "" then
            element.text = text
        else
            element.text = "Sell junk/resupply"
        end
        element.tooltipText = RXP_.icons.vendor..element.text
        return element
    end

    local event = ...
    local id = self.element.id

    if event == "MERCHANT_SHOW" then
        self.element.activity = RXP_.GetNpcId()
    elseif event == "MERCHANT_CLOSED" and (self.element.activity == id or not id) then
        self.element.activity = nil
        RXP_.SetElementComplete(self)
    end
end

function RXP_.functions.trainer(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,id = ...
        element.id = tonumber(id)
        if text and text ~= "" then
            element.text = text
        else
            element.text = "Train skills"
        end
        element.tooltipText = RXP_.icons.trainer..element.text
        return element
    end

    local event = ...
    local id = self.element.id

    if event == "TRAINER_SHOW" then
        self.element.activity = RXP_.GetNpcId()
    elseif event == "TRAINER_CLOSED" and (self.element.activity == id or not id) then
        self.element.activity = nil
        RXP_.SetElementComplete(self)
    end
end

function RXP_.functions.stable(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,id = ...
        element.id = tonumber(id)
        if text and text ~= "" then
            element.text = text
        else
            element.text = "Stable your pet"
        end
        element.tooltipText = RXP_.icons.stable..element.text
        return element
    end

    local event = ...
    local id = self.element.id

    if event == "PET_STABLE_SHOW" then
        self.element.activity = RXP_.GetNpcId()
    elseif event == "PET_STABLE_CLOSED" and (self.element.activity == id or not id) then
        self.element.activity = nil
        RXP_.SetElementComplete(self)
    end
end

function RXP_.functions.tame(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,id = ...
        element.id = tonumber(id)
        if text and text ~= "" then
            element.text = text
        else
            element.text = "-"
        end
        element.tooltipText = RXP_.icons.tame..element.text
        return element
    end

    local event,unit,guid,spellId = ...
    local id = self.element.id

    if spellId == 1515 and unit == "player" then
        if event == "UNIT_SPELLCAST_START" then
            self.element.petId = id
        elseif id and event == "UNIT_SPELLCAST_SUCCEEDED" and id == self.element.petId then
            self.element.petId = nil
            RXP_.SetElementComplete(self)
            return
        end
    end
end

function RXP_.functions.money(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,money = ...
        local prefix = money:sub(1,1)
        if prefix == "<" then
            element.greaterThan = false
        elseif prefix == ">" then
            element.greaterThan = true
        else
            return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid arguments\n"..self)
        end
        element.money = tonumber(money:match("(%d+%.?%d*)"))
        if element.money then
            element.money = element.money * 1e4
        else
            return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid arguments\n"..self)
        end
        element.textOnly = true
        if text and text ~= "" then
            element.text = text
        end
        return element
    end
    if not self.element.step.active then return end
    if GetMoney() >= self.element.money then
        self.element.step.completed = self.element.greaterThan
    else
        self.element.step.completed = not(self.element.greaterThan)
    end
    if self.element.step.completed then
        RXP_.updateSteps = true
    end
end


function RXP_.functions.next(skip,guide)
    if skip and (type(skip) == "number" or (skip.step and not skip.step.active)) then 
        return 
    end
    guide = guide or RXP_.currentGuide
    if guide.next then
        local group = guide.group
        local next = guide.next:gsub("^%s*(.+)\\%s*",function(grp)
            group = grp
            return ""
        end)
        local nextGuide
        local guideSkip = RXP_.GetGuideTable(group,next)
        local som = RXPCData.SoM
        local hc = RXPCData.hardcore
        
        if RXP_.version ~= "CLASSIC" then
            local faction = next:match("Aldor") or next:match("Scryer")
            if not RXP_.AldorScryerCheck(faction) then
                if faction == "Aldor" then
                    next = next:gsub("Scryer","Aldor")
                elseif faction == "Scryer" then
                    next = next:gsub("Aldor","Scryer")
                end
            end
        else
            local era = "(Era)"
            local som = "(SoM)"
            
            if RXPCData.SoM then
                next = next:gsub(era,som)
            else
                next = next:gsub(som,era)
            end
        end

        nextGuide = RXP_.GetGuideTable(group,next)
       
        if nextGuide then
            if (nextGuide.era and RXPCData.SoM or nextGuide.som and not RXPCData.SoM) or 
               (nextGuide.hardcore and not(RXPCData.hardcore) or nextGuide.softcore and RXPCData.hardcore) then
               return RXP_.functions.next(nil,nextGuide)
            else
                RXP_:LoadGuide(nextGuide)
                return true
            end
        elseif guideSkip then
            return RXP_.functions.next(nil,guideSkip)
        end
    end
end




function RXP_.functions.train(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,id,rank = ...
        local spellId = tonumber(id)
        
        if spellId then
            element.id = spellId 
        else
            element.id = select(7,GetSpellInfo(id))
        end
        
        if type(spellId) ~= "number" then
            return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid spell name/id\n"..self)
        end
        if rank then
            element.rank = tonumber(rank:match("(%d+)")) or 0
        end

        if element.id and not C_Spell.IsSpellDataCached(element.id) then
            C_Spell.RequestLoadSpellData(element.id)
        end

        if text and text ~= "" then
            element.text = text
        else
            element.text = "-"
        end
        element.requestFromServer = true
        element.tooltipText = RXP_.icons.trainer..element.text
        return element
    end
    local element = self.element
    local event = ...
    local rank = element.rank or 0
    if not element.rank and C_Spell.IsSpellDataCached(element.id) then
        rank = GetSpellSubtext(element.id)
        rank = tonumber(rank:match("(%d+)")) or 0
        element.rank = rank
        element.requestFromServer = nil
    end
    if not element.title then
        element.title = GetSpellInfo(element.id)
    end

    if IsPlayerSpell(element.id) or IsSpellKnown(element.id,true) or IsSpellKnown(element.id) then
        RXP_.SetElementComplete(self,true)
    end

    if element.title then
        if element.completed or element.step.completed or not element.step.active then
            RXP_.skillList[element.title] = nil
        else
            RXP_.skillList[element.title] = element.rank
        end
    else
        element.requestFromServer = true
    end
end




function RXP_.functions.istrained(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local args = {...}
        args[1] = nil
        element.id = args
        for _,id in pairs(args) do
            if not C_Spell.IsSpellDataCached(id) then
                C_Spell.RequestLoadSpellData(id)
            end
        end
        element.textOnly = true
        return element
    end

    for _,id in pairs(self.element.id) do
        if IsPlayerSpell(id) then
            self.element.step.completed = true
            RXP_.updateSteps = true
            return
        end
    end
end

function RXP_.functions.abandon(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        element.tag = "accept"
        local text,id = ...
        id = tonumber(id)
        if not id then return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid quest ID\n"..self) end
        element.title = ""
        element.questId = id
        --element.title = RXP_.GetQuestName(id)
        if text and text ~= "" then
            element.text = text
        else
            element.text = "Abandon *quest*"
            element.requestFromServer = true
        end
        if element.text:match("%*quest%*") then
            element.retrieveText = true
        end
        --print("Q1",element.text)
        element.tooltipText = RXP_.icons.abandon..element.text
        --print(element.rawtext)
        return element
    else
        local element = self.element
        if not element.step.active then return end
        local event,_,questId = ...
        local id = element.questId
        if element.retrieveText then
            local quest = RXP_.GetQuestName(id,element)
            if quest then
                element.title = quest
                element.text = element.text:gsub("%*quest%*",quest)
                if element.requestFromServer then
                    element.requestFromServer = nil
                    RXP_.UpdateStepText(self)
                end
            else
                element.title = ""
                element.requestFromServer = true
            end
        end
        element.tooltipText = RXP_.icons.abandon..element.text


        if self.element.step.active and not C_QuestLog.IsOnQuest(id) then
            RXP_.SetElementComplete(self,true)
        else
            RXP_.SetElementIncomplete(self)
        end

    end

end

--[[
owl: 132192
cat: 132185
ravager: 132194
scorpid: 132195
dragonhawk: 132188
]]
function RXP_.functions.petFamily(self,...)
    if type(self) == "string" then
        local element = {}
        local text,id = ...
        id = tonumber(id)
        if not id then return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid icon ID\n"..self) end
        element.id = id
        if text and text ~= "" then
            element.text = text
        end
        element.textOnly = true
        return element
    end
    local id = self.element.id
    
    if RXP_.petFamily ~= id then
        self.element.step.completed = true
        RXP_.updateSteps = true
    end
end

function RXP_.functions.isQuestComplete(self,...)
    if type(self) == "string" then
        local element = {}
        local text,id = ...
        id = tonumber(id)
        if not id then return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid quest ID\n"..self) end
        element.questId = id
        if text and text ~= "" then
            element.text = text
        end
        element.textOnly = true
        return element
    end
    local id = self.element.questId
    if self.element.step.active and not (C_QuestLog.IsOnQuest(id) and IsQuestComplete(id)) then
        self.element.step.completed = true
        RXP_.updateSteps = true
    end
end

function RXP_.functions.isOnQuest(self,...)
    if type(self) == "string" then
        local element = {}
        local text,id = ...
        id = tonumber(id)
        if not id then return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid quest ID\n"..self) end
        element.questId = id
        if text and text ~= "" then
            element.text = text
        end
        element.textOnly = true
        return element
    end
    local id = self.element.questId
    if self.element.step.active and not C_QuestLog.IsOnQuest(id) then
        self.element.step.completed = true
        RXP_.updateSteps = true
    end
end

function RXP_.functions.isQuestTurnedIn(self,text,...)
    if type(self) == "string" then
        local element = {}
        local ids = {...}
        for k,v in pairs(ids) do
            ids[k] = tonumber(v)
        end
        if not ids[1] then return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid quest ID\n"..self) end
        element.questIds = ids
        if text and text ~= "" then
            element.text = text
        end
        element.textOnly = true
        return element
    end
    local ids = self.element.questIds
    local questTurnedIn = false
    for _,id in pairs(ids) do
        if IsQuestTurnedIn(id) then
            questTurnedIn = true
        end
    end
    
    if self.element.step.active and not questTurnedIn then
        self.element.step.completed = true
        RXP_.updateSteps = true
    end
end

function RXP_.functions.spellMissing(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,id,rank = ...
        local spellId = tonumber(id)

        element.id = spellId
        element.textOnly = true

        return element
    end
    if IsPlayerSpell(self.element.id) and self.element.step.active then
        RXP_.SetElementComplete(self)
        self.element.step.completed = true
        RXP_.updateSteps = true
    end

end

function RXP_.functions.zone(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,zone = ...
        local mapID = RXP_.mapId[zone]
        if not (mapID and text) then
            return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid text/map name\n"..self)
        end
        element.map = mapID
        element.icon = RXP_.icons.goto
        if text and text ~= "" then
            element.text = text
        else
            element.text = "Go to "..zone
        end
        element.tooltipText = element.icon..text
        return element
    end
    if not self.element.step.active then return end
    local zone = self.element.map
    if zone == C_Map.GetBestMapForUnit("player") then
        RXP_.SetElementComplete(self)
        self.element.step.completed = true
        RXP_.updateSteps = true
    end
end

function RXP_.functions.zoneskip(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,zone = ...
        local mapID = RXP_.mapId[zone]
        if not mapID then
            return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid text/map name\n"..self)
        end
        element.map = mapID
        if text and text ~= "" then
            element.text = text
        end
        element.textOnly = true
        return element
    end
    if not self.element.step.active then return end
    local zone = self.element.map
    if zone == C_Map.GetBestMapForUnit("player") then
        self.element.step.completed = true
        RXP_.updateSteps = true
    end
end

local function LinkOnClick(self)

RXP_.url = self.element.url
StaticPopup_Show("RXP_Link")
RXP_.url = nil
end

function RXP_.functions.link(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,url = ...
        if not (url and text) then
            return RXP_.error("Error parsing guide "..RXP_.currentGuideName..": Invalid text/url\n"..self)
        end
        element.textOnly = true
        element.url = url
        element.hideTooltip = true
        element.tooltip = "Click to view the link"
        element.text = text
        return element
    end
    if self and self.highlight then
        self.highlight:Show()
        self:SetScript("OnMouseDown",LinkOnClick)
    end
end

StaticPopupDialogs["RXP_Link"] = {
    text = "Press Ctrl+C to copy the URL to your clipboard",
    hasEditBox = 1,
    button1 = OKAY,
    OnShow = function(self)
        if RXP_.url then
            local box = getglobal(self:GetName() .. "EditBox")
            box:SetWidth(275)
            box:SetText(RXP_.url)
            box:HighlightText()
            box:SetFocus()
        end
    end,

    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1
}

function RXP_.functions.cast(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        element.tag = "hs"
        local text,id = ...
        element.id = tonumber(id)
        element.text = text or ""
        local icon = GetSpellTexture(id)
        if icon then
            element.icon = "|T"..icon..":0|t"
            element.tooltipText = element.icon..element.text
        end
        
        return element
    end
    local event,unit,_,id = ...
    local icon = GetSpellTexture(id)
    local element = self.element
    if icon then
        element.icon = "|T"..icon..":0|t"
        element.tooltipText = element.icon..element.text
    end
    if event == "UNIT_SPELLCAST_SUCCEEDED" and unit == "player" and id == element.id then
        RXP_.SetElementComplete(self)
    end
end

function RXP_.functions.unitscan(self,text,...)
    if type(self) == "string" then
        local element = {}
        local npcs = {...}
        for k,v in pairs(npcs) do
            local npc = strupper(v)
            if RXP_.guide.unitscan[npc] then
                table.insert(RXP_.guide.unitscan[npc],element)
            else
                RXP_.guide.unitscan[npc] = {element}
            end
        end
        
        if text and text ~= "" then
            element.text = text
        end
        element.textOnly = true
        return element
    end
    
end

local BLquests = {
    [2583] = {
        0, --gizzard
        1, --brain
        3, --lung
        2, --pincer
        0, --jowl
    },
    [2601] = {2,10,0,0,0},
    [2585] = {2,0,1,3,0},
    [2581] = {0,0,2,1,3},
    [2603] = {10,0,0,0,2}
}


function RXP_.functions.blastedLands(self)
    
    if type(self) == "string" then --on parse
        local element = {}
        element.text = "Collect the following items:\n14 Vulture Gizzard\n11 Basilisk Brain\n6 Scorpok Pincer\n6 Blasted Boar Lung\n5 Snickerfang Jowl"
        element.icon = RXP_.icons.collect
        element.dynamicText = true
        return element
    end
    --

    local element = self.element
    local step = self.element.step

    local id = {
        8396,
        8394,
        8392,
        8393,
        8391,
    }
    local name = {
        "Vulture Gizzard","Basilisk Brain","Blasted Boar Lung","Scorpok Pincer","Snickerfang Jowl"
    }
    
    for n,item in pairs(id) do
        local iName = GetItemInfo(item)
        if iName then
            name[n] = iName
        end
    end

    local total = {
        0,
        0,
        0,
        0,
        0,
    }
    
    for quest,items in pairs(BLquests) do
        if not IsQuestTurnedIn(quest) then
            for item,v in pairs(items) do
                total[item] = total[item] + v
            end
        end
    end
    
    local skip = true
    --element.textInactive = ""
    element.text = "Collect the following items:"
    
    for item,goal in pairs(total) do
        local itemCount = GetItemCount(id[item])
        if goal > 0 then
            if itemCount > goal then 
                itemCount = goal 
            end
            element.text = string.format("%s\n- %s: %d/%d",element.text,name[item],itemCount,goal)
        end
        if itemCount < goal then
            skip = false
        end
    end

    
    if skip then
        element.text = "Do the Blasted Lands collection quests"
        RXP_.SetElementComplete(self)
    else
        RXP_.SetElementIncomplete(self)
    end

    RXP_.UpdateStepText(self)
end

function RXP_.PutItemInBank(bagContents)
    local _,isBankOpened = GetContainerNumFreeSlots(BANK_CONTAINER);
    if CursorHasItem() and isBankOpened then
        local bank = {BANK_CONTAINER}
        for i = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
            table.insert(bank,i)
        end
        
        if not bagContents then bagContents = {} end
        for _,bag in ipairs(bank) do
            if not bagContents[bag] then bagContents[bag] = {} end
            local slots, bagtype = GetContainerNumFreeSlots(bag)
            if bagtype == 0 and slots > 0 then
                for slot = 1,GetContainerNumSlots(bag) do
                    if not (GetContainerItemInfo(bag,slot) or bagContents[bag][slot]) then
                        PickupContainerItem(bag,slot)
                        bagContents[bag][slot] = true
                        return
                    end
                end
            end
        end
        ClearCursor()
    end

end

function RXP_.PutItemInBags(bagContents)
    if CursorHasItem() then
        if not bagContents then bagContents = {} end
        for bag = BACKPACK_CONTAINER, NUM_BAG_FRAMES do
            if not bagContents[bag] then bagContents[bag] = {} end
            local slots, bagtype = GetContainerNumFreeSlots(bag)
            if bagtype == 0 and slots > 0 then
                for slot = 1,GetContainerNumSlots(bag) do
                    if not (GetContainerItemInfo(bag,slot) or bagContents[bag][slot]) then
                        PickupContainerItem(bag,slot)
                        bagContents[bag][slot] = true
                        return
                    end
                end
            end
        end
        ClearCursor()
    end
end

function RXP_.PutItemInQuiver(bagContents)
    if CursorHasItem() then
        if not bagContents then bagContents = {} end
        for bag = BACKPACK_CONTAINER, NUM_BAG_FRAMES do
            if not bagContents[bag] then bagContents[bag] = {} end
            local slots, bagtype = GetContainerNumFreeSlots(bag)
            if (bagtype == 1 or bagtype == 2) and slots > 0 then
                for slot = 1,GetContainerNumSlots(bag) do
                    if not (GetContainerItemInfo(bag,slot) or bagContents[bag][slot]) then
                        PickupContainerItem(bag,slot)
                        bagContents[bag][slot] = true
                        return
                    end
                end
            end
        end
        ClearCursor()
    end
end

function RXP_.GoThroughBags(itemList,func)
    local bagContents = {}
    for bag = BACKPACK_CONTAINER, NUM_BAG_FRAMES do
        for slot = 1,GetContainerNumSlots(bag) do
            local id = GetContainerItemID(bag, slot)
            if id then
                local name = GetItemInfo(id)
                for _,item in ipairs(itemList) do
                    if item == name or item == id then
                        func(bag,slot,bagContents)
                    end
                end
            end
        end
    end

end

function RXP_.DepositItems(itemList)
    local _,isBankOpened = GetContainerNumFreeSlots(BANK_CONTAINER);
    if itemList and isBankOpened then
        if type(itemList) ~= "table" then 
            itemList = {itemList}
        end
    else
        return
    end
    
    local text = ""
    for _,item in ipairs(itemList) do
        local id = tonumber(item) or item
        local name = GetItemInfo(id) or id
        if name then
            if text == "" then
                text = "Attempting to deposit: "..name
            else
                text = text..", "..name
            end
        end
    end
    print(text)
    
    RXP_.GoThroughBags(itemList,function(bag,slot,bagContents)
        PickupContainerItem(bag,slot)
        RXP_.PutItemInBank(bagContents)
    end)
end

function RXP_.IsItemInBags(itemList,reverseLogic)
    local _,isBankOpened = GetContainerNumFreeSlots(BANK_CONTAINER);
    if itemList and isBankOpened then
        if type(itemList) ~= "table" then 
            itemList = {itemList}
        end
    else
        return
    end
    for _,item in ipairs(itemList) do
        local itemCount = 0
        RXP_.GoThroughBags({item},function()
            itemCount = itemCount + 1
        end)
        if reverseLogic then
            if itemCount >= 1 then
                return false
            end
        else
            if itemCount < 1 then
                return false
            end
        end
    end
    return true
end

function RXP_.IsItemNotInBags(itemList)
    return RXP_.IsItemInBags(itemList,true)
end

function RXP_.GoThroughBank(itemList,func)
    
    local bank = {BANK_CONTAINER}
    for i = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
        table.insert(bank,i)
    end
    
    local bagContents = {}
    
    for _,bag in pairs(bank) do
        for slot = 1,GetContainerNumSlots(bag) do
            local id = GetContainerItemID(bag, slot)
            if id then
                local name = GetItemInfo(id)
                for _,item in ipairs(itemList) do
                    if item == name or item == id then
                        func(bag,slot,bagContents)
                    end
                end
            end
        end
    end    
    
end

function RXP_.WithdrawItems(itemList)
    local _,isBankOpened = GetContainerNumFreeSlots(BANK_CONTAINER);
    if itemList and isBankOpened then
        if type(itemList) ~= "table" then 
            itemList = {itemList}
        end
    else
        return
    end
    
    local text = ""
    for _,item in ipairs(itemList) do
        local id = tonumber(item) or item
        local name = GetItemInfo(id) or id
        if name then
            if text == "" then
                text = "Attempting to withdraw: "..name
            else
                text = text..", "..name
            end
        end
    end
    print(text)
    
    RXP_.GoThroughBank(itemList,function(bag,slot,bagContents)
        PickupContainerItem(bag,slot)
        RXP_.PutItemInBags(bagContents)
    end)
end

function RXP_.IsItemInBank(itemList,reverseLogic)
    local _,isBankOpened = GetContainerNumFreeSlots(BANK_CONTAINER);
    if itemList and isBankOpened then
        if type(itemList) ~= "table" then 
            itemList = {itemList}
        end
    else
        return
    end
    
    for _,item in ipairs(itemList) do
        local itemCount = 0
        RXP_.GoThroughBank({item},function()
            itemCount = itemCount + 1
        end)
        if reverseLogic then
            if itemCount >= 1 then
                return false
            end
        else
            if itemCount < 1 then
                return false
            end
        end
    end
    return true
end

function RXP_.IsItemNotInBank(itemList)
    return RXP_.IsItemInBank(itemList,true)
end

function RXP_.functions.bankdeposit(self,text,...)
    
    if type(self) == "string" then
        local element = {}
        local items = {...}
        for n,item in pairs(items) do
            items[n] = tonumber(item) or item
        end
        
        element.items = items
        element.text = text
        element.icon = RXP_.icons.vendor
        return element
    end

    local element = self.element

    if RXP_.IsItemNotInBags(element.items) then
        RXP_.SetElementComplete(self)
        return
    end
    RXP_.DepositItems(element.items)
end

function RXP_.functions.bankwithdraw(self,text,...)
    
    if type(self) == "string" then
        local element = {}
        local items = {...}
        for n,item in pairs(items) do
            items[n] = tonumber(item) or item
        end
        
        element.items = items
        element.text = text
        element.icon = RXP_.icons.vendor
        return element
    end
    
    local event = ...
    local element = self.element

    if RXP_.IsItemNotInBank(element.items) then
        RXP_.SetElementComplete(self)
        return
    end
    RXP_.WithdrawItems(element.items)
end

function RXP_.functions.bronzetube(self,text,rev)
    if type(self) == "string" then --on parse
        local element = {}
        element.textOnly = true
       
        if text and text ~= "" then
            element.text = text
        end
        return element
    end

    local element = self.element
    element.rev = rev
    
    local count = GetItemCount(4371)
    local total = 0
    
    
    if not(IsQuestTurnedIn(174)) then
        total = total + 1
    end
--[[    if class == "ROGUE" and not(IsQuestTurnedIn(2609)) then
        total = total + 1
    end]]
    
    if count >= total then
        self.element.step.completed = true
        RXP_.updateSteps = true
    end
end


function RXP_.functions.buy(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,id,qty = ...
        id = tonumber(id)
        if not id then
            return RXP_.error('Error parsing guide '..RXP_.currentGuideName..': No item ID provided\n'..self)
        end
        element.id = id
        qty = tonumber(qty)
        element.qty = qty or 1

        element.text = text
        return element
    end
    
    local element = self.element
    local event = ...
    local id = element.id
    local count = GetItemCount(id)
    local total = element.qty-count
    if total > 0 and event == "MERCHANT_SHOW" and element.step.active and not element.completed then
        for i=1,GetMerchantNumItems() do
            local link = GetMerchantItemLink(i)
            local itemID = link and tonumber(link:match("item:(%d+)"))
            if itemID then
                local name, texture, price, quantity = GetMerchantItemInfo(i)
                
                if itemID == id or name == id then
                    print("Buying "..name.." x"..total)
                    if quantity and quantity > 1 then
                        for n=1,math.ceil(total/quantity) do
                            BuyMerchantItem(i, quantity)
                        end
                    elseif quantity == 1 then
                        local stack = select(8,GetItemInfo(id))
                        while total > 0 do
                            local purchase = math.min(stack,total)
                            total = total - purchase
                            BuyMerchantItem(i, purchase)
                        end
                    end
                    return
                end
            end
        end
    end
    
    if count >= element.qty then
        RXP_.SetElementComplete(self)
        return
    end
    
end

function RXP_.functions.skipgossip(self,text,...)
    if type(self) == "string" then
        local element = {}
        element.args = {...}
        element.gossipId = id
        if text and text ~= "" then
            element.text = text
        end
        element.textOnly = true
        return element
    end
    
    local element = self.element
    local args = element.args
    args = args or {}
    
    if event == "GOSSIP_SHOW" then
        if #args == 0 then
            if GetNumGossipAvailableQuests() == 0 and GetNumGossipActiveQuests() == 0 then
                SelectGossipOption(1)
            end
            return
        end
        
        local id = tonumber(args[1])
        local npcId = RXP_.GetNpcId()    
        if #args == 1 then
            if id < 10 or npcId == id then
                id = 1
            else
                return
            end
            if GetNumGossipAvailableQuests() == 0 and GetNumGossipActiveQuests() == 0 then
                SelectGossipOption(id)
            end
        elseif id == npcId then
            if not self.npcId then
                element.index = 2
                element.npcId = id
            else
                element.index = ((self.index -1) % (#args-1))+2
            end
            local option = tonumber(args[element.index])
            if option then
                SelectGossipOption(option)
            end
        end
    else
        element.npcId = nil
    end
    
end

function RXP_.functions.maxLevel(self,...)
    if type(self) == "string" then --on parse
        local element = {}
        local text,str = ...

        str = str:gsub(" ","")
        local level,xp = str:match("(%d+)([%+%.%-]?%d*)")
        element.xp = tonumber(xp)
        element.level = tonumber(level)
        element.event = "PLAYER_XP_UPDATE"
        if text and text ~= "" then
            element.text = text
        end
        if not element.xp then element.xp = 0 end
        element.textOnly = true
        return element
    end
    local currentXP = UnitXP("player")
    local maxXP = UnitXPMax("player")
    local level = UnitLevel("player")
    local element = self.element
    
    if (element.xp < 0 and (level >= element.level or (level == element.level-1 and currentXP >= maxXP + element.xp))) or
       (element.xp >= 1 and ((level > element.level) or (element.level == level and currentXP >= element.xp))) or
       (element.xp >= 0 and element.xp < 1 and ((level > element.level) or (element.level == level and currentXP >= maxXP*element.xp)))
       then
        element.step.completed = true
        RXP_.updateSteps = true
        element.step.hideStep = true
    end

end
