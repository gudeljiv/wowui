local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type DB
local DB = GL.DB;

---@type Data
local Constants = GL.Data.Constants;

---@type Events
local Events = GL.Events;

---@type Settings
local Settings = GL.Settings;

---@type GDKP
local GDKP = GL.GDKP;

---@type GDKPPot
local GDKPPot;

---@type GDKPAuction
local GDKPAuction;

---@class GDKPSession
GDKP.Session = {
    _initialized = false,
    broadcastInProgress = false,
    includeTradeInSession = true,
    inProgress = false,
    lastOutBidNotificationShownAt = 0,
    requestingData = false,
    timerId = 0, -- ID of the timer event

    ItemHistory = {}, -- Historical data for items
};

---@type GDKPSession
local Session = GDKP.Session;

---@return void
function Session:_init()
    GL:debug("Session:_init");

    if (self._initialized) then
        return;
    end

    GDKPPot = GL.GDKP.Pot;
    GDKPAuction = GDKP.Auction;
    self._initialized = true;

    Events:register("GDKPSessionTradeCompletedListener", "GL.TRADE_COMPLETED", function (_, Details)
        self:registerGoldTrade(Details);
    end);

    Events:register("GDKPSessionTradeInitiatedListener", "GL.TRADE_SHOW", function (_, Details)
        self:tradeInitiated(Details);
    end);

    Events:register("GDKPSessionAuctionCreatedListener", "GL.GDKP_AUCTION_CREATED", function (_, sessionID)
        if (Settings:get("GDKP.announcePotAfterAuction")
            and sessionID == self:activeSessionID()
        ) then
            local total = tonumber(GDKP.Pot:total()) or 0;
            if (total < 1) then
                return;
            end

            GL:sendChatMessage(string.format("Pot was updated, it now holds %sg", tostring(total)), "GROUP");
        end
    end);

    Events:register("GDKPSessionGroupRosterUpdatedListener", "GL.GROUP_ROSTER_UPDATE_THROTTLED", function ()
        GDKPPot:clearUnavailablePlayerDetails(self:activeSessionID()); -- Reset raiders who left
        GDKPPot:calculateCuts(self:activeSessionID()); -- Calculate cuts for potential new joiners
        GL.Interface.GDKP.Distribute.Overview:refresh(); -- Refresh the distribution overview in case it's opened
    end);

    local Instance = self:getActive();
    if (Instance and not Instance.lockedAt) then
        GL.Ace:ScheduleTimer(function ()
            if (not self:userIsAllowedToBroadcast()) then
                return;
            end

            local Window = GL.Interface.GDKP.Auctioneer:open();

            if (Window) then
                Window.Minimize.MinimizeButton:Click();
            end

            GL.Interface.Alerts:fire("GargulNotification", {
                message = string.format("|c00BE3333%s!|r", L.GDKP_ACTIVATED),
            });
        end, 5);
    end
end

--- Copper owed to player based on everything bought, earned, cut, etc. This is the bottom line for this session!
--- The return value can be negative, in which case it's the player who owes you money
---
---@param player string
---@param sessionID string
---@return number
function Session:copperOwedToPlayer(player, sessionID)
    GL:debug("Session:owedToPlayer");

    local Instance = self:byID(sessionID);
    if (not Instance) then
        return;
    end

    -- You can't owe yourself anything
    if (GL:iEquals(player, GL.User.name)) then
        return 0;
    end

    local GoldTraded = GL:tableGet(Instance, "GoldTrades." .. player, {
        from = 0,
        to = 0,
    });

    local goldMailed = GL:tableGet(Instance, "GoldMails." .. player, 0);

    local playerCutInCopper = 0;
    -- Only include the player cut if the current GDKP session is locked and ready for payout
    if (Instance.lockedAt) then
        playerCutInCopper = GL:tableGet(Instance, "Pot.Cuts." .. player, 0) * 10000;
    end

    local copperReceived = GoldTraded.from;
    local copperGiven = GoldTraded.to + goldMailed;
    local copperSpentByPlayer = self:goldSpentByPlayer(player, Instance.ID) * 10000;
    local copperToReceive = copperSpentByPlayer - copperReceived;
    local copperToGive = playerCutInCopper - copperToReceive - copperGiven;

    return copperToGive;
end

function Session:tradeInitiated(Details)
    GL:debug("Session:tradeInitiated");

    if (not Details.partner) then
        return;
    end

    local Instance = self:getActive();

    -- Check if the GDKP session exists and is locked for payout
    if (not Instance) then
        return;
    end

    local message = "";
    local playerCut = 0;
    if (Instance.lockedAt) then
        playerCut = GL:tableGet(Instance, "Pot.Cuts." .. Details.partner, 0) or 0;
    end

    local GoldTrades = GL:tableGet(Instance, "GoldTrades." .. Details.partner, {
        from = 0,
        to = 0,
    });

    local playerCutInCopper = playerCut * 10000;
    local copperReceived = GoldTrades.from;
    local copperGiven = GoldTrades.to;
    local copperSpentByPlayer = self:goldSpentByPlayer(Details.partner) * 10000;
    local copperToReceive = copperSpentByPlayer - copperReceived;
    local copperToGive = playerCutInCopper - copperToReceive - copperGiven;

    local balanceMessage = " ";
    local whisperMessage = nil;
    if (copperToGive > 0) then
        local due = GL:copperToMoney(copperToGive);
        balanceMessage = string.format("|c00F7922ETo give: %s|r", due);
        whisperMessage = string.format("I owe you %s. Enjoy!", due);

    elseif (copperToGive < 0) then
        local owed = GL:copperToMoney(copperToGive * -1);
        balanceMessage = string.format("|c0092FF00To receive: %s|r", owed);
        whisperMessage = string.format("You owe me %s. Thank you!", owed);
    end

    if (whisperMessage and Settings:get("GDKP.whisperGoldDetails")) then
        GL:sendChatMessage(whisperMessage, "WHISPER", nil, Details.partner);
    end

    message = string.format(
        "|c00967FD2GDKP Session|r\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s",
        GL:copperToMoney(copperSpentByPlayer),
        GL:copperToMoney(copperGiven),
        GL:copperToMoney(copperReceived),
        GL:copperToMoney(playerCutInCopper),
        balanceMessage
    );

    -- Just to be sure!
    if (not TradeFrame:IsShown()) then
        return;
    end

    -- Show the gold details window
    do
        self.includeTradeInSession = true;

        local Window = GL.AceGUI:Create("InlineGroup");
        Window:SetLayout("Flow");
        Window:SetWidth(190);
        Window:SetHeight(30);
        Window.frame:SetParent(TradeFrame);
        Window.frame:SetScript("OnHide", function()
            GL.Interface:release(Window);
            Window.frame:Hide();
        end);
        Window:SetPoint("TOPLEFT", TradeFrame, "TOPRIGHT", 0, 9);
        Window.frame:Show();

        local DescriptionLabel = GL.AceGUI:Create("Label");
        DescriptionLabel:SetFullWidth(true);
        DescriptionLabel:SetFontObject(_G["GameFontNormalSmall"]);
        DescriptionLabel:SetText(message);
        DescriptionLabel:SetColor(1, .95686, .40784);
        Window:AddChild(DescriptionLabel);

        local IncludeTradeInSession = GL.AceGUI:Create("CheckBox");
        IncludeTradeInSession:SetValue(false);
        IncludeTradeInSession:SetLabel("Exclude from GDKP");
        IncludeTradeInSession:SetDescription("Gold traded will not be added to amount given or received");
        IncludeTradeInSession:SetFullWidth(true);
        IncludeTradeInSession.text:SetTextColor(1, .95686, .40784);
        IncludeTradeInSession:SetCallback("OnValueChanged", function()
            self.includeTradeInSession = not IncludeTradeInSession:GetValue();
        end);
        Window:AddChild(IncludeTradeInSession);
    end

    -- Add the gold to the trade window
    if (playerCutInCopper > 0
        and copperToGive
        and Settings:get("GDKP.addGoldToTradeWindow")
    ) then
        if (copperToGive > GetMoney()) then
            GL:error("You don't have enough money to pay " .. Details.partner);
        else
            GL.TradeWindow:setCopper(copperToGive, Details.partner, function(success)
                if (success) then
                    return;
                end

                GL:error(string.format(
                    "Unable to add %s to the trade window. Try adding it manually!",
                    GL:copperToMoney(copperToGive)
                ));
            end);
        end
    end
end

---@param player string
---@param sessionID string
---@return number
function Session:goldSpentByPlayer(player, sessionID)
    GL:debug("Session:goldSpentByPlayer");

    sessionID = sessionID or self:activeSessionID();
    local Instance = self:byID(sessionID);
    if (not Instance) then
        return 0;
    end

    local spent = 0;
    for _, Sale in pairs(Instance.Auctions or {}) do
        if (not Sale.deletedAt and Sale.price and Sale.Winner.name == player and GL:higherThanZero(Sale.price)) then
            spent = spent + Sale.price;

            if (Sale.paid) then
                spent = spent - Sale.paid
            end
        end
    end

    return spent;
end

---@param player string
---@param sessionID string
---@return number
function Session:goldBidByPlayer(player, sessionID)
    GL:debug("Session:goldBidByPlayer");

    sessionID = sessionID or self:activeSessionID();
    local Instance = self:byID(sessionID);
    if (not Instance) then
        return 0;
    end

    local bid = 0;
    for _, Sale in pairs(Instance.Auctions or {}) do
        if (not Sale.deletedAt
            and Sale.price
            and Sale.Winner.name ~= player
            and GL:higherThanZero(Sale.price)
            and Sale.Bids
        ) then
            for bidder, Bid in pairs(Sale.Bids or {}) do
                if (type(Bid) == "table"
                    and Bid.bid
                    and bidder == player
                ) then
                    bid = bid + Bid.bid;
                    break;
                end
            end
        end
    end

    return bid;
end

---@param Details table
---@return void
function Session:registerGoldTrade(Details)
    GL:debug("Session:registerTrade");

    -- The player didn't want to include this trade
    if (not self.includeTradeInSession) then
        return;
    end

    local Instance = self:getActive();

    if (not Instance) then
        return;
    end

    local myGold = Details.myGold;
    local theirGold = Details.theirGold;

    -- No gold was involved in this trade
    if (myGold <= 0 and theirGold <= 0) then
        return;
    end

    Instance.GoldTrades = Instance.GoldTrades or {};
    Instance.GoldTrades[Details.partner] = Instance.GoldTrades[Details.partner] or {
        to = 0,
        from = 0,
    };

    Instance.GoldTrades[Details.partner].from = Instance.GoldTrades[Details.partner].from + theirGold;
    Instance.GoldTrades[Details.partner].to = Instance.GoldTrades[Details.partner].to + myGold;

    Events:fire("GL.GDKP_GOLD_TRADED");

    self:store(Instance);
end

---@param player string
---@param copper number
---@return void
function Session:registerGoldMail(player, copper)
    GL:debug("Session:registerGoldMail");

    local Instance = self:getActive();

    if (not Instance) then
        return;
    end

    Instance.GoldMails = Instance.GoldMails or {};
    Instance.GoldMails[player] = Instance.GoldMails[player] or 0;
    Instance.GoldMails[player] = Instance.GoldMails[player] + copper;

    Events:fire("GL.GDKP_GOLD_MAILED");

    self:store(Instance);
end

---@param ID string
---@return table|nil
function Session:byID(ID)
    GL:debug("Session:sessionByID");

    if (not ID) then
        return;
    end

    return DB:get("GDKP.Ledger." .. ID);
end

---@param itemLinkOrID string|number
---@return table
function Session:itemHistory(itemLinkOrID)
    GL:debug("Session:itemHistory");

    local itemID;
    local concernsID = GL:higherThanZero(tonumber(itemLinkOrID));

    if (concernsID) then
        itemID = itemLinkOrID;
    else
        itemID = GL:getItemIDFromLink(itemLinkOrID);
    end

    itemID = tonumber(itemID) or 0;
    if (itemID < 1) then
        return;
    end

    if (self.ItemHistory[itemID]) then
        return self.ItemHistory[itemID];
    end

    local timesSold = 0;
    local totalSaleValue = 0;
    local lastSoldTimestamp = 0;
    local lastSoldPrice = 0;
    for _, Instance in pairs(DB:get("GDKP.Ledger") or {}) do
        for _, Auction in pairs(Instance.Auctions or {}) do
            if (type(Auction) == "table"
                and Auction.itemID == itemID
                and not Auction.deletedAt
                and GL:higherThanZero(Auction.price)
            ) then
                timesSold = timesSold + 1;
                totalSaleValue = totalSaleValue + Auction.price;

                if (Auction.createdAt > lastSoldTimestamp) then
                    lastSoldTimestamp = Auction.createdAt;
                    lastSoldPrice = Auction.price;
                end
            end
        end
    end

    local averageSaleValue = 0;
    if (timesSold > 0) then
        averageSaleValue = math.floor(totalSaleValue / timesSold);
    end

    self.ItemHistory[itemID] = {
        timesSold = timesSold,
        totalSaleValue = totalSaleValue,
        averageSaleValue = averageSaleValue,
        lastSoldTimestamp = lastSoldTimestamp,
        lastSoldPrice = lastSoldPrice,
    };

    return self.ItemHistory[itemID];
end

---@param itemLink string
---@return table
function Session:tooltipLines(itemLink)
    GL:debug("Session:tooltipLines");

    if (not Settings:get("GDKP.showHistoryOnTooltip")) then
        return {};
    end

    local Details = self:itemHistory(itemLink);

    if (not Details
        or Details.timesSold <= 0
    ) then
        return {};
    end

    local itemID = GL:getItemIDFromLink(itemLink);

    if (itemID == Constants.GDKP.potIncreaseItemID) then
        return {};
    end

    local PerItemSettings = GDKP:settingsForItemID(itemID);

    local Lines = {
        string.format("\n|c00967FD2GDKP Data (sold %sx)|r", Details.timesSold),
        string.format("Last sold for: %sg", Details.lastSoldPrice),
        string.format("Average price: %sg ", Details.averageSaleValue),
        string.format("Minimum bid: %sg", PerItemSettings.minimum),
        string.format("Increment: %sg", PerItemSettings.increment),
    };

    return Lines;
end

---@return table|boolean
function Session:getActive()
    GL:debug("Session:getActive");

    local activeSessionIdentifier = DB:get("GDKP.activeSession", false);

    if (not activeSessionIdentifier) then
        return false;
    end

    return DB:get("GDKP.Ledger." .. activeSessionIdentifier, false);
end

---@param SessionObj table
---@return boolean
function Session:store(SessionObj)
    GL:debug("Session:store");

    if (type(SessionObj) ~= "table"
        or GL:empty(SessionObj)
        or GL:empty(SessionObj.ID)
        or SessionObj.lockedAt
    ) then
        return false;
    end

    DB:set("GDKP.Ledger." .. SessionObj.ID, SessionObj);

    return true;
end

---@param sessionID string
---@return boolean
function Session:setActive(sessionID)
    GL:debug("Session:setActive");

    local Instance = self:byID(sessionID);
    if (not Instance
        or Instance.deletedAt
        or DB:get("GDKP.activeSession") == sessionID
    ) then
        return false;
    end

    DB:set("GDKP.activeSession", sessionID);

    Events:fire("GL.GDKP_SESSION_ACTIVATED", sessionID);
    Events:fire("GL.GDKP_ACTIVE_SESSION_CHANGED");

    return true;
end

---@return string|boolean
function Session:activeSessionID()
    return DB:get("GDKP.activeSession", false);
end

--- Check whether the current user owns a GDKP session
---
---@return boolean
function Session:ownedByUser()
    GL:debug("Session:ownedByUser");

    for _, Instance in pairs (DB:get("GDKP.Ledger") or {}) do
        if (GL:tableGet(Instance or {}, "CreatedBy.uuid") == GL.User.id) then
            return true;
        end
    end

    return false;
end

---@return boolean
function Session:exists(sessionIdentifier)
    GL:debug("Session:exists");

    return not not DB:get("GDKP.Ledger." .. sessionIdentifier .. ".ID");
end

---@param title string
---@param managementCut number
---@return table|boolean
function Session:create(title, managementCut)
    GL:debug("Session:createSession");

    if (type(title) ~= "string" or GL:empty(title)) then
        return false;
    end

    managementCut = strtrim(managementCut);
    if (not GL:empty(managementCut)
        and tonumber(managementCut)
        and not GL:higherThanZero(tonumber(managementCut))
    ) then
        return false;
    end

    local Instance = {
        title = GL:capitalize(string.sub(title, 0, 30)),
        createdAt = GetServerTime(),
        managementCut = managementCut,
        Auctions = {},
        CreatedBy = {
            class = GL.User.class,
            name = GL.User.name,
            guild = GL.User.Guild.name,
            uuid = GL.User.id,
        },
        Pot = {
            Mutators = Settings:get("GDKP.Mutators", {}),
        },
        Raiders = {},
    };

    local checksum = Instance.createdAt .. GL:stringHash(Instance);
    Instance.ID = checksum;

    DB:set("GDKP.Ledger." .. checksum, Instance);
    Events:fire("GL.GDKP_SESSION_CREATED", Instance);

    return Instance;
end

---@param sessionID string
---@param title string
---@param managementCut number|nil
---@return boolean|table
function Session:edit(sessionID, title, managementCut)
    GL:debug("Session:createSession");

    if (type(title) ~= "string" or GL:empty(title)) then
        return false;
    end

    local Instance = self:byID(sessionID);

    if (not Instance) then
        return false;
    end

    if (not GL:empty(managementCut)
        and tonumber(managementCut)
        and not GL:higherThanZero(tonumber(managementCut))
    ) then
        return false;
    end

    if (not GL:empty(managementCut)) then
        Instance.managementCut = tonumber(managementCut);
    else
        Instance.managementCut = 0;
    end

    Instance.title = GL:capitalize(string.sub(title, 0, 30));
    DB:set("GDKP.Ledger." .. Instance.ID, Instance);
    Events:fire("GL.GDKP_SESSION_CHANGED", Instance, self:byID(sessionID));

    return Instance;
end

---@param sessionID string
---@return boolean
function Session:lock(sessionID)
    GL:debug("Session:lock");

    local Instance = self:byID(sessionID);

    if (not Instance or Instance.lockedAt) then
        return false;
    end

    Instance.lockedAt = GetServerTime();
    self:store(Instance);

    Events:fire("GL.GDKP_SESSION_LOCKED", Instance);
    return true;
end

---@param sessionID string
---@return boolean
function Session:unlock(sessionID)
    GL:debug("Session:lock");

    local Instance = self:byID(sessionID);
    if (not Instance or not Instance.lockedAt) then
        return false;
    end

    Instance.lockedAt = nil;
    self:store(Instance);

    Events:fire("GL.GDKP_SESSION_UNLOCKED", Instance);
    return true;
end

---@param sessionID string
---@return boolean
function Session:toggleLock(sessionID)
    GL:debug("Session:toggleLock");

    local Instance = self:byID(sessionID);
    if (not Instance) then
        return false;
    end

    if (Instance.lockedAt) then
        return self:unlock(sessionID);
    end

    return self:lock(sessionID);
end

---@param sessionID string
---@return boolean
function Session:delete(sessionID)
    GL:debug("Session:delete");

    local Instance = self:byID(sessionID);

    if (not Instance) then
        return false;
    end

    -- This session is the currently active one, clear it
    if (DB:get("GDKP.activeSession") == sessionID) then
        self:clearActive();
    end

    -- There are no auctions attached to this session, we can safely remove it!
    if (GL:empty(Instance.Auctions)) then
        DB:set("GDKP.Ledger." .. sessionID, nil);

    -- There are auctions, mark the Session as deleted but keep it for 24h still
    else
        DB:set("GDKP.Ledger." .. sessionID .. ".deletedAt", GetServerTime());
    end

    Events:fire("GL.GDKP_SESSION_CHANGED", Instance);
    Events:fire("GL.GDKP_SESSION_DELETED", sessionID);

    return true;
end

---@param sessionID string
---@return boolean
function Session:restore(sessionID)
    GL:debug("Session:restore");

    local Instance = self:byID(sessionID);

    if (not Instance or not Instance.deletedAt) then
        return false;
    end

    DB:set("GDKP.Ledger." .. sessionID .. ".deletedAt", nil);

    Events:fire("GL.GDKP_SESSION_CHANGED", Instance, self:byID(sessionID));
    Events:fire("GL.GDKP_SESSION_RESTORED", sessionID);

    return true;
end

--- Clear the currently active session
---
---@return void
function Session:clearActive()
    GL:debug("Session:clearActive");

    local activeSession = DB:get("GDKP.activeSession");
    if (not activeSession) then
        return false;
    end

    DB:set("GDKP.activeSession", nil);

    Events:fire("GL.GDKP_ACTIVE_SESSION_CLEARED", activeSession);
    Events:fire("GL.GDKP_ACTIVE_SESSION_CHANGED");

    return true;
end

---@return boolean
function Session:userIsAllowedToBroadcast()
    GL:debug("Session:userIsAllowedToBroadcast");

    return not GL.User.isInGroup or (
        GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist)
    );
end

GL:debug("GDKP.lua");