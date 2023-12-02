-- File: ClickLinks.lua
-- Name: Click Links
-- Author: tannerng
-- Description: Makes URLs clickable
-- Version: 1.0.9

URL_PATTERNS = {
    -- X://Y most urls
    "^(%a[%w+.-]+://%S+)",
    "%f[%S](%a[%w+.-]+://%S+)",
    -- www.X.Y domain and path
    "^(www%.[-%w_%%]+%.(%a%a+)/%S+)",
    "%f[%S](www%.[-%w_%%]+%.(%a%a+)/%S+)",
    -- www.X.Y domain
    "^(www%.[-%w_%%]+%.(%a%a+))",
    "%f[%S](www%.[-%w_%%]+%.(%a%a+))",
    -- emaild
    "(%S+@[%w_.-%%]+%.(%a%a+))",
    -- ip address with port and path
    "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d/%S+)",
    "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d/%S+)",
    -- ip address with port
    "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d)%f[%D]",
    "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d:[0-6]?%d?%d?%d?%d)%f[%D]",
    -- ip address with path
    "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%/%S+)",
    "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%/%S+)",
    -- ip address
    "^([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d)%f[%D]",
    "%f[%S]([0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d%.[0-2]?%d?%d)%f[%D]",
    
    -- x.y.z shit disabled for now, probabaly forever
    --"^([-%w_%%]+%.[-%w_%%]+%.(%a%a+))",
    --"%f[%S]([-%w_%%]+%.[-%w_%%]+%.(%a%a+))",
    --"^([-%w_%%]+%.(%a%a+))",
    --"%f[%S]([-%w_%%]+%.(%a%a+))"
}

function formatURL(url)
    url = "|cff".."149bfd".."|Hurl:"..url.."|h["..url.."]|h|r ";
    return url;
end


function makeClickable(self, event, msg, ...)    
    for k,p in pairs(URL_PATTERNS) do
        if string.find(msg, p) then
            msg = string.gsub(msg, p, formatURL("%1"))
        end
    end
    
    return false, msg, ...
end

StaticPopupDialogs["CLICK_LINK_CLICKURL"] = {
    text = "Copy & Paste the link into your browser",
    button1 = "Close",
    OnAccept = function()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3, 
    OnShow = 
        function (self, data)
            self.editBox:SetText(data.url)
            self.editBox:HighlightText()
        end,
    hasEditBox = true
}

local SetHyperlink = ItemRefTooltip.SetHyperlink
function ItemRefTooltip:SetHyperlink(link)
     if (string.sub(link, 1, 3) == "url") then
        local url = string.sub(link, 5);
        local d = {}
        d.url = url
        StaticPopup_Show("CLICK_LINK_CLICKURL", "", "", d)
     else
        SetHyperlink(self, link)
     end
end

local CHAT_TYPES = {
    "AFK",
    "BATTLEGROUND_LEADER",
    "BATTLEGROUND",
    "BN_WHISPER",
    "BN_WHISPER_INFORM",
    "CHANNEL",
    "COMMUNITIES_CHANNEL",
    "DND",
    "EMOTE",
    "GUILD",
    "OFFICER",
    "PARTY_LEADER",
    "PARTY",
    "RAID_LEADER",
    "RAID_WARNING",
    "RAID",
    "SAY",
    "WHISPER",
    "WHISPER_INFORM",
    "YELL",
    "SYSTEM"
}

for _, type in pairs(CHAT_TYPES) do
    ChatFrame_AddMessageEventFilter("CHAT_MSG_" .. type, makeClickable)
end
