-- VARIABLES

local lastStr = "";
local tradeSkills = {};
local nodeNameList = {};
local shiftIsDown = false;
local nodeList = {
    { name = "Peacebloom",                      skill = 1,      type = "Herbalism"},
    { name = "Silverleaf",                      skill = 1,      type = "Herbalism"},
    { name = "Earthroot",                       skill = 15,     type = "Herbalism"},
    { name = "Mageroyal",                       skill = 50,     type = "Herbalism"},
    { name = "Briarthorn",                      skill = 70,     type = "Herbalism"},
    { name = "Stranglekelp",                    skill = 85,     type = "Herbalism"},
    { name = "Bruiseweed",                      skill = 100,    type = "Herbalism"},
    { name = "Wild Steelbloom",                 skill = 115,    type = "Herbalism"},
    { name = "Grave Moss",                      skill = 120,    type = "Herbalism"},
    { name = "Kingsblood",                      skill = 125,    type = "Herbalism"},
    { name = "Liferoot",                        skill = 150,    type = "Herbalism"},
    { name = "Fadeleaf",                        skill = 160,    type = "Herbalism"},
    { name = "Goldthorn",                       skill = 170,    type = "Herbalism"},
    { name = "Khadgar's Whisker",               skill = 185,    type = "Herbalism"},
    { name = "Wintersbite",                     skill = 195,    type = "Herbalism"},
    { name = "Firebloom",                       skill = 205,    type = "Herbalism"},
    { name = "Purple Lotus",                    skill = 210,    type = "Herbalism"},
    { name = "Arthas' Tears",                   skill = 220,    type = "Herbalism"},
    { name = "Sungrass",                        skill = 230,    type = "Herbalism"},
    { name = "Blindweed",                       skill = 235,    type = "Herbalism"},
    { name = "Ghost Mushroom",                  skill = 245,    type = "Herbalism"},
    { name = "Gromsblood",                      skill = 250,    type = "Herbalism"},
    { name = "Golden Sansam",                   skill = 260,    type = "Herbalism"},
    { name = "Dreamfoil",                       skill = 270,    type = "Herbalism"},
    { name = "Mountain Silversage",             skill = 280,    type = "Herbalism"},
    { name = "Plaguebloom",                     skill = 285,    type = "Herbalism"},
    { name = "Icecap",                          skill = 290,    type = "Herbalism"},
    { name = "Black Lotus",                     skill = 300,    type = "Herbalism"},
    { name = "Arcanite Lode",                   skill = 310,    type = "Mining"},    
    { name = "Ooze Covered Arcanite Lode",      skill = 310,    type = "Mining"},    
    { name = "Rich Thorium Vein",               skill = 275,    type = "Mining"},    
    { name = "Ooze Covered Rich Thorium Vein",  skill = 275,    type = "Mining"},    
    { name = "Ooze Covered Thorium Vein",       skill = 245,    type = "Mining"},    
    { name = "Small Thorium Vein",              skill = 245,    type = "Mining"},    
    { name = "Dark Iron Deposit",               skill = 230,    type = "Mining"},    
    { name = "Ooze Covered Truesilver Deposit", skill = 230,    type = "Mining"},    
    { name = "Truesilver Deposit",              skill = 230,    type = "Mining"},    
    { name = "Ooze Covered Mithril Deposit",    skill = 175,    type = "Mining"},    
    { name = "Mithril Deposit",                 skill = 175,    type = "Mining"},    
    { name = "Ooze Covered Gold Vein",          skill = 155,    type = "Mining"},    
    { name = "Gold Vein",                       skill = 155,    type = "Mining"},    
    { name = "Indurium Mineral Vein",           skill = 150,    type = "Mining"},    
    { name = "Iron Deposit",                    skill = 125,    type = "Mining"},    
    { name = "Ooze Covered Iron Deposit",       skill = 100,    type = "Mining"},    
    { name = "Lesser Bloodstone Deposit",       skill = 75,     type = "Mining"},
    { name = "Silver Vein",                     skill = 75,     type = "Mining"},
    { name = "Ooze Covered Silver Vein",        skill = 75,     type = "Mining"},
    { name = "Incendicite Mineral Vein",        skill = 65,     type = "Mining"},
    { name = "Tin Vein",                        skill = 65,     type = "Mining"},
    { name = "Small Obsidian Chunk",            skill = 1,      type = "Mining"},
    { name = "Large Obsidian Chunk",            skill = 1,      type = "Mining"},
    { name = "Copper Vein",                     skill = 1,      type = "Mining"}
}

local colorCodes = {
    gray    = "|cFF7F7F7F",
    green   = "|cFF40BF40",
    yellow  = "|cFFFFFF00",
    orange  = "|cFFFF7F19",
    red     = "|cFFFF1919",
}

-- FUNCTIONS

local function split(s, delimiter)
    local result = {};

    for match in string.gmatch(s, delimiter) do
       table.insert(result, match);
    end

    return result;
end

local function validNode(nodeName)
    for key, value in pairs(nodeNameList) do
        if string.match(nodeName, key) then
            return key;
        end
    end
end

local function getNodeInfo(nodeName)
    for index, node in pairs(nodeList) do
        if (node.name == nodeName) then
            return node;
        end
    end
end

local function shiftKeyDown()
    if (IsShiftKeyDown() and not shiftIsDown) then
        shiftIsDown = true;
        return true;
    end
end

local function shiftKeyUp()
    if (not IsShiftKeyDown() and shiftIsDown) then
        shiftIsDown = false;
        return true;
    end
end

local function getSkillColor(nodeSkill, skillRank)
    local color;

    if skillRank < nodeSkill then
        color = "red";
    elseif skillRank >= nodeSkill + 100 then
        color = "gray";
    elseif skillRank >= nodeSkill + 50 then
        color = "green";
    elseif skillRank >= nodeSkill + 25 then
        color = "yellow";
    elseif skillRank >= nodeSkill then
        color = "orange";
    end

    return colorCodes[color];
end

local function isMinimap(frame)
    local parent = frame:GetOwner();
    
    if parent then
        local name = parent:GetName();

        if (name and name == "Minimap") then
            return true;
        end
    end
end

local function getSkillInfo(skillName)
    if skillName then
        local skillIndex = tradeSkills[skillName];

        if skillIndex then
            local skillName, _, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(skillIndex);

            if skillName and skillRank and skillMaxRank then
                return {
                    name = skillName,
                    rank = skillRank,
                    max = skillMaxRank
                }
            end
        end
    end
end

local function updateTradeSkills()
    for i = 1, GetNumSkillLines() do
        local skillName, _, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i);

        tradeSkills[skillName] = i
    end

    -- Adds the player's profession node names into a list (for easy access)
    for i, value in ipairs(nodeList) do 
        if (tradeSkills[value.type]) then
            nodeNameList[value.name] = true;
        end
    end
end

local function skillFilter(self, event, msg, author, ...)
    if (string.match(msg, "Your skill in")) then
        local name = string.match(msg, "Your skill in (.+) has increased");
        local skillInfo = getSkillInfo(name);

        if skillInfo then
            local color = "green";

            if (skillInfo.rank >= skillInfo.max) then
                color = "red"
            elseif (skillInfo.rank >= skillInfo.max - 15) then
                color = "orange";
            elseif (skillInfo.rank >= skillInfo.max - 50) then
                color = "yellow";
            end

            local newMsg = string.gsub(msg, "(%d+)", colorCodes[color] .. skillInfo.rank .. " / " .. skillInfo.max);
            return false, newMsg, author, ...;
        end
    end
end

local function updateToolTip()
    local text = _G["GameTooltipTextLeft" .. 1]:GetText();
    local strTable = split(text, "[^\r\n]+"); --[^%s]+     [^\r\n]+
    local finalText = "";
    lastStr = text;

    for i = 1, #strTable do
        local str = validNode(strTable[i]);

        if (str and nodeNameList[str]) then
            local nodeInfo = getNodeInfo(str);

            if nodeInfo then
                local skillInfo = getSkillInfo(nodeInfo.type);

                if skillInfo then
                    local color = getSkillColor(nodeInfo.skill, skillInfo.rank);
                    str = color .. str;

                    if IsShiftKeyDown() then
                        str = str .. " (" .. skillInfo.rank .. " / " .. nodeInfo.skill .. ")";
                    end

                    finalText = finalText .. str

                    if i < #strTable then
                        finalText = finalText .. "\n";
                    end
                end
            end
        end
    end

    if #finalText > 0 then
        _G["GameTooltipTextLeft" .. 1]:SetText(finalText);
    end
end

-- EVENTS

local worldEventFrame = CreateFrame("Frame");
worldEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
worldEventFrame:RegisterEvent("LEARNED_SPELL_IN_TAB");
worldEventFrame:SetScript("OnEvent", function(self, event, addonName)
    if (event == "PLAYER_ENTERING_WORLD" or event == "LEARNED_SPELL_IN_TAB") then
        updateTradeSkills();
    end
end)

local startupFrame = CreateFrame("Frame");
startupFrame:RegisterEvent("ADDON_LOADED");
startupFrame:SetScript("OnEvent", function(self, event, addonName)
    if (event == "ADDON_LOADED" and addonName == "SkillInfoPlus") then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFC95656Skill Info+ loaded");
    end

    self:UnregisterAllEvents();
end)

-- Apparently, OnTooltipSetItem does not fire on every tooltip occurance (like on minimap)
GameTooltip:HookScript("OnUpdate", function(self)
    if (isMinimap(self)) then
        local currentStr = _G["GameTooltipTextLeft".. 1]:GetText();

        if (currentStr ~= lastStr or shiftKeyDown() or shiftKeyUp()) then
            updateToolTip();
        end
    end
end)

GameTooltip:HookScript("OnShow", function(self)
    if (isMinimap(self)) then
        updateToolTip();
    end
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_SKILL", skillFilter);