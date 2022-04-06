-- scope stuff
gearquipper = gearquipper or {};
local c = gearquipper;
c.name = "GearQuipper";

GQ_OPTIONS = GQ_OPTIONS or {};
GQ_DATA = GQ_DATA or {};
GQ_AUX = GQ_AUX or {};

local GQ_VERSION = 30;

c.VALUE_NONE = "VALUE_NONE";
c.KEYWORD_NONE = "$NONE";
c.KEYWORD_PREVIOUS = "$PREVIOUS";
c.KEYWORD_PREVIOUSEQUIPMENT = "$PREVIOUSEQUIPMENT";
c.KEYWORD_PVE = "$PVE";
c.KEYWORD_PVP = "$PVP";

-- init
function c:Init()
    c:InitOptions();
    c:InitDatabase();
    c:InitBroker();
    -- c:InitTooltips();
    c:InitUI(PaperDollFrame);

    -- updates
    if not GQ_OPTIONS[c.OPT_VERSION] then
        GQ_OPTIONS[c.OPT_VERSION] = 0;
    end
    if GQ_OPTIONS[c.OPT_VERSION] < GQ_VERSION then
        -- if not GQ_OPTIONS[c.OPT_VERSION] or tonumber(GQ_OPTIONS[c.OPT_VERSION]) < 14 then
        -- add slotStates
        --	c:DataBase_Update14();
        -- end
        -- if not GQ_OPTIONS[c.OPT_VERSION] or tonumber(GQ_OPTIONS[c.OPT_VERSION]) < 17 then
        -- remove old eventbindings
        --	c:DataBase_Update17();
        -- end

        GQ_OPTIONS[c.OPT_VERSION] = GQ_VERSION; -- finish update
        c:Println(c:GetText("Update to version %s complete.", GQ_VERSION));
    end

    c:LoadCustomScripts();
    c.debugMode = false;
    c.initFinished = true;
    c:Println(c:GetText("AddOn loaded: Version: %s. Type /gq for options.", GQ_VERSION));
    c:Println(c:GetText("Visit https://www.curseforge.com/wow/addons/gearquipper for support, feedback and updates."));
end

function c:GetVersion()
    return GQ_VERSION;
end

function c:GetElvUiSkinModule()
    if ElvUI then
        local E, L, V, P, G = unpack(ElvUI);
        return E:GetModule('Skins');
    end
end

function c:LoadCustomScripts()
    if GQ_OPTIONS[c.OPT_SCRIPTEDITORENABLED] then
        local customScripts = c:LoadScripts();
        if customScripts and c:GetTableSize(customScripts) > 0 then
            c:Println(c:GetText("Loading user scripts:"));
            for scriptId, script in pairs(customScripts) do
                if script[c.FIELD_TEXT] then
                    c:Println(c:GetText("Loading \"%s\"...", script[c.FIELD_NAME]));
                    local scriptText, errorMessage = loadstring(script[c.FIELD_TEXT]);
                    if errorMessage then
                        c:Println(c:GetText("Error in script: \n%s", errorMessage));
                    else
                        local retOK, ret1 = pcall(scriptText);
                        if not retOK then
                            c:Println(c:GetText("Error in script: \n%s", ret1));
                        end
                    end
                else
                    c:Println(c:GetText("Skipping \"%s\", because there is no script text.", script[c.FIELD_NAME]));
                end
            end
            c:Println(c:GetText("Finished loading user scripts."));
        end
    end
end

function c:IsClassic()
    return WOW_PROJECT_CLASSIC and WOW_PROJECT_ID == WOW_PROJECT_CLASSIC;
end

function c:IsTBC()
    return WOW_PROJECT_BURNING_CRUSADE_CLASSIC and WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC;
end

function c:GetHomeLatency(addFixed)
    -- Home sends/receives data about your chat, guild info, item tooltips, auction house.
    -- from blue post https://us.forums.blizzard.com/en/wow/t/question-world-vs-home-latency/820575/5
    local down, up, lagHome, lagWorld = GetNetStats();
    addFixed = addFixed or 0;
    return lagHome + addFixed;
end

function c:GetWorldLatency(addFixed)
    -- World sends/receives data about your spells, abilities, character/NPC movement, combat mechanics.
    -- from blue post https://us.forums.blizzard.com/en/wow/t/question-world-vs-home-latency/820575/5
    local down, up, lagHome, lagWorld = GetNetStats();
    addFixed = addFixed or 0;
    return lagWorld + addFixed;
end

function c:GetLatency(addFixed)
    local homeLatency, worldLatency = c:GetHomeLatency(addFixed), c:GetWorldLatency(addFixed);
    if homeLatency > worldLatency then
        return homeLatency;
    else
        return worldLatency;
    end
end

-- local t = UIParent:CreateTexture("NEWTEXTR", "BACKGROUND");
-- t:SetTexture("\\Interface\\AddOns\\GearQuipper-TBC\\assets\\partial.blp");
-- t:SetSize(16, 16);
-- t:SetPoint("TOPLEFT", 0, 0);
