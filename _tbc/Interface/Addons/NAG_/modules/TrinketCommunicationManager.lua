--- @module "NAG.TrinketCommunicationManager"
--- Manages communication and data exchange for trinket-related operations in NAG.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

local _, ns = ...
local GetTime = _G.GetTime
local UnitName = _G.UnitName
local UnitAffectingCombat = _G.UnitAffectingCombat
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type DataManager
local DataManager

--- @type TrinketRegistrationManager
--- @type TrinketTrackingManager
local TrinketRegistrationManager, TrinketTrackingManager
local WoWAPI = ns.WoWAPI
local IsInInstance = _G.IsInInstance
local UnitInRaid = _G.UnitInRaid
local UnitInParty = _G.UnitInParty

-- Enhanced error handling
local pcall = ns.pcall

local L = ns.AceLocale:GetLocale("NAG", true)
local AceSerializer = ns.AceSerializer
local AceGUI = ns.AceGUI


-- Constants
local ADDON_PREFIX = "NAGTrinket"
local REQUEST_TIMEOUT = 3.0 -- Wait 3 seconds for responses
local MESSAGE_TYPES = {
    REQUEST = "REQUEST",
    RESPONSE = "RESPONSE"
}

-- Default settings
local defaults = {
    char = {
        -- Character-specific settings
        enabled = true,
        shareRegistrations = true, -- Whether to share trinket registrations
        acceptRegistrations = true -- Whether to accept trinket registrations from others
    }
}

---@class TrinketCommunicationManager : CoreModule
local TrinketCommunicationManager = NAG:CreateModule("TrinketCommunicationManager", defaults, {
    defaultState = {
        pendingRequests = {},    -- Store pending trinket requests with request IDs
        responseData = {},       -- Store received responses
        pendingValidations = {}, -- Store validations pending due to combat
        activeWindow = nil,      -- Track if any registration window is currently open
        nextRequestId = 1        -- Counter for generating unique request IDs
    },
    -- Event handlers
    eventHandlers = {
        CHAT_MSG_ADDON = true,
        PLAYER_REGEN_ENABLED = true,
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.EVENTS
    }
})
local module = TrinketCommunicationManager
ns.TrinketCommunicationManager = TrinketCommunicationManager

function TrinketCommunicationManager:ModuleInitialize()
    -- Register addon prefix for communication
    if not C_ChatInfo.IsAddonMessagePrefixRegistered(ADDON_PREFIX) then
        C_ChatInfo.RegisterAddonMessagePrefix(ADDON_PREFIX)
    end
end

function TrinketCommunicationManager:ModuleEnable()
    -- Nothing special needed on enable

    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    DataManager = NAG:GetModule("DataManager")
    TrinketRegistrationManager = NAG:GetModule("TrinketRegistrationManager")
    TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")

    -- ============================ MODULE INITIALIZATION ============================
end

function TrinketCommunicationManager:ModuleDisable()
    -- Clear any pending requests

    wipe(self.state.pendingRequests)
    wipe(self.state.responseData)
    self.state.activeWindow = nil
end

--- Check if a sender name matches the current player (handles realm names)
--- @param senderName string The sender name to check
--- @return boolean True if the sender is the current player
function TrinketCommunicationManager:IsSelfSender(senderName)
    if not senderName then return false end

    local playerName = UnitName("player")
    if not playerName then return false end

    -- Exact match
    if senderName == playerName then
        return true
    end

    -- Check if player name is contained in sender name (handles realm names)
    if strfind(senderName, playerName, 1, true) then
        return true
    end

    return false
end

--- Generate a unique request ID
--- @return string A unique request ID
function TrinketCommunicationManager:GenerateRequestId()
    local requestId = string.format("%s_%d_%d", UnitName("player"), GetTime(), self.state.nextRequestId)
    self.state.nextRequestId = self.state.nextRequestId + 1
    return requestId
end

--- Request trinket data from other players
--- @param itemId number The ID of the trinket
--- @return boolean Whether the request was sent successfully
function TrinketCommunicationManager:RequestTrinketData(itemId)
    if not itemId then return false end

    -- First, check if we already have reliable data for this trinket
    local existingData, dataSource = self:GetReliableTrinketData(itemId)
    if existingData then
        if self.debug then
            self:Debug("Already have reliable data for itemId: %d from %s source, skipping request",
                itemId, dataSource)
        end
        return false
    end

    -- Note: Analysis is not needed here since RequestTrinketData is only called
    -- when we already know the trinket needs registration (from StartRegistration)

    -- Generate a unique request ID for this request
    local requestId = self:GenerateRequestId()
    local message = string.format("%s:%d:%s", MESSAGE_TYPES.REQUEST, itemId, requestId)
    local requestTime = GetTime()

    -- Store the request with the request ID
    self.state.pendingRequests[itemId] = {
        requestId = requestId,
        time = requestTime,
        responses = {},
        userInitiated = true -- Mark this as a user-initiated request
    }

    -- Debug print for request start
    if self.debug then
        self:Debug("Starting trinket data request for itemId: %d with requestId: %s at time: %.2f", itemId,
            requestId, requestTime)
    end

    -- Clear any old response data
    self.state.responseData[itemId] = nil

    -- Send the request to all available channels
    local sent = false

    -- Try guild first
    if GetGuildInfo('player') then
        C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "GUILD")
        self:Debug("Sent trinket request to GUILD channel")
        sent = true
    end

    -- Check if in group
    local inInstance, instanceType = IsInInstance()

    -- Try raid if applicable
    if UnitInRaid("player") and instanceType == 'none' then
        C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "RAID")
        self:Debug("Sent trinket request to RAID channel")
        sent = true
    end

    -- Try party if applicable
    if UnitInParty("player") and instanceType == 'none' then
        C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "PARTY")
        self:Debug("Sent trinket request to PARTY channel")
        sent = true
    end

    -- Try instance chat if in instance
    if inInstance then
        C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "INSTANCE_CHAT")
        self:Debug("Sent trinket request to INSTANCE_CHAT channel")
        sent = true
    end

    -- Always try YELL as a last resort
    C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "YELL")
    self:Debug("Sent trinket request to YELL channel")
    sent = true

    return sent
end

--- Check if we have received any responses for a trinket
--- @param itemId number The ID of the trinket
--- @return table|nil The collected trinket data if available
function TrinketCommunicationManager:CheckTrinketResponses(itemId)
    local request = self.state.pendingRequests[itemId]
    if not request then return nil end

    local currentTime = GetTime()
    local elapsedTime = currentTime - request.time

    -- Debug print for checking responses
    if self.debug then
        self:Debug("Checking responses for itemId: %d. Time elapsed: %.2f / %.2f seconds", itemId,
            elapsedTime, REQUEST_TIMEOUT)
    end

    -- Check if we've waited long enough
    if elapsedTime < REQUEST_TIMEOUT then
        if self.debug then
            self:Debug("Still waiting for responses (%.2f seconds remaining)",
                REQUEST_TIMEOUT - elapsedTime)
        end
        return nil -- Still waiting for responses
    end

    -- Process responses and return the most common/reliable data
    local data = self.state.responseData[itemId]

    -- Debug print for request completion
    if data then
        if self.debug then
            self:Debug("Request complete for itemId: %d. Received data from %s", itemId,
                data.sender or "unknown")
        end
    else
        if self.debug then self:Debug("Request timeout for itemId: %d. No responses received", itemId) end
    end

    -- Clear the request
    self.state.pendingRequests[itemId] = nil

    return data
end

--- Validate trinket data before sending to ensure it's complete and reliable
--- @param itemId number The ID of the trinket
--- @param trinketData table The trinket data to validate
--- @return boolean Whether the data is valid and complete enough to send
function TrinketCommunicationManager:ValidateTrinketDataForSending(itemId, trinketData)
    if not itemId or not trinketData then
        self:Debug("Missing itemId or trinketData for validation")
        return false
    end

    -- Check if we have the basic required fields
    if not trinketData.buffId or type(trinketData.buffId) ~= "number" then
        if self.debug then self:Debug("Invalid or missing buffId for itemId: %d", itemId) end
        return false
    end

    if not trinketData.duration or type(trinketData.duration) ~= "number" or trinketData.duration <= 0 then
        if self.debug then self:Debug("Invalid or missing duration for itemId: %d", itemId) end
        return false
    end

    -- Verify the buff spell actually exists
    local spellInfo = WoWAPI.GetSpellInfo(trinketData.buffId)
    local buffName = spellInfo and spellInfo.name
    if not buffName then
        if self.debug then self:Debug("Buff spell %d does not exist for itemId: %d", trinketData.buffId, itemId) end
        return false
    end

    -- Verify the item actually exists
    local itemName = WoWAPI.GetItemInfo(itemId)
    if not itemName then
        if self.debug then self:Debug("Item %d does not exist", itemId) end
        return false
    end

    -- For custom registrations, we should have stats
    if trinketData.stats and #trinketData.stats > 0 then
        -- Validate that all stat IDs are valid
        for _, statId in ipairs(trinketData.stats) do
            if not NAG.Types:GetType("Stat"):GetNameByValue(statId) then
                if self.debug then self:Debug("Invalid stat ID %d in trinket data for itemId: %d", statId, itemId) end
                return false
            end
        end
    end

    -- Validate ICD if present
    if trinketData.icd and (type(trinketData.icd) ~= "number" or trinketData.icd < 0) then
        if self.debug then self:Debug("Invalid ICD value for itemId: %d", itemId) end
        return false
    end

    -- Validate proc type if present
    if trinketData.procType and trinketData.procType ~= "proc" and trinketData.procType ~= "use" then
        if self.debug then self:Debug("Invalid proc type '%s' for itemId: %d", trinketData.procType, itemId) end
        return false
    end

    if self.debug then self:Debug("Trinket data validation passed for itemId: %d", itemId) end
    return true
end

--- Check if we have reliable trinket data for a given item ID
--- @param itemId number The ID of the trinket
--- @return table|nil The trinket data if we have reliable information, nil otherwise
--- @return string The source of the data ("analysis" or "none")
function TrinketCommunicationManager:GetReliableTrinketData(itemId)
    if not itemId then return nil, "none" end

    -- Delegate to TrinketTrackingManager for unified analysis
    local result = TrinketTrackingManager:AnalyzeTrinket(itemId)
    if result and result.trinketInfo then
        local trinketInfo = result.trinketInfo

        -- Convert trinketInfo to trinketData format for validation
        local trinketData = {
            buffId = trinketInfo.buffId,
            duration = trinketInfo.duration,
            icd = trinketInfo.icd or 0,
            procType = trinketInfo.procType,
            stats = {}
        }

        -- Convert statType fields to stats array
        if trinketInfo.statType1 and trinketInfo.statType1 ~= -1 then
            tinsert(trinketData.stats, trinketInfo.statType1)
        end
        if trinketInfo.statType2 and trinketInfo.statType2 ~= -1 then
            tinsert(trinketData.stats, trinketInfo.statType2)
        end
        if trinketInfo.statType3 and trinketInfo.statType3 ~= -1 then
            tinsert(trinketData.stats, trinketInfo.statType3)
        end

        -- Validate before returning
        if self:ValidateTrinketDataForSending(itemId, trinketData) then
            return trinketData, "analysis"
        else
            if self.debug then
                self:Debug("Analysis data validation failed for itemId: %d", itemId)
            end
        end
    end

    return nil, "none"
end

--- Handle incoming addon messages
function TrinketCommunicationManager:CHAT_MSG_ADDON(event, prefix, message, channel, sender)
    if prefix ~= ADDON_PREFIX then return end

    local messageType, rest = strsplit(":", message, 2)

    if messageType == MESSAGE_TYPES.REQUEST then
        -- Don't respond to requests while in combat
        if UnitAffectingCombat("player") then
            if self.debug then self:Debug("Ignoring trinket request from %s - player is in combat", sender) end
            return
        end

        -- Handle trinket data request
        local itemId, requestId = strsplit(":", rest, 2)
        itemId = tonumber(itemId)
        if not itemId then return end

        -- Don't respond to our own requests
        if self:IsSelfSender(sender) then
            if self.debug then self:Debug("Ignoring trinket request from ourselves (%s) for itemId: %d", sender, itemId) end
            return
        end

        if self.debug then
            self:Debug("Received trinket request from %s for itemId: %d with requestId: %s", sender,
                itemId, requestId or "none")
        end

        -- Get reliable trinket data using the new function
        local trinketData, dataSource = self:GetReliableTrinketData(itemId)

        -- Send response if we have valid data and sharing is enabled
        if trinketData and self.db.char.shareRegistrations then
            if self.debug then
                self:Debug("Sending validated trinket data from %s source for itemId: %d", dataSource,
                    itemId)
            end
            -- Send response with our data directly to the requester
            self:SendResponse(itemId, trinketData, sender, requestId)
        else
            if not trinketData then
                if self.debug then self:Debug("No reliable data available for itemId: %d", itemId) end
            else
                if self.debug then self:Debug("Sharing disabled for itemId: %d", itemId) end
            end
        end
    elseif messageType == MESSAGE_TYPES.RESPONSE then
        -- Handle trinket data response
        local itemId, requestId, serializedData = strsplit(":", rest, 3)
        itemId = tonumber(itemId)
        if not itemId then return end

        if self.debug then
            self:Debug("Received trinket data response from %s for itemId: %d with requestId: %s", sender,
                itemId, requestId or "none")
        end

        -- Check if we have a pending request for this itemId and requestId
        local request = self.state.pendingRequests[itemId]
        if not request or request.requestId ~= requestId then
            if self.debug then
                self:Debug(
                    "No matching request found for itemId: %d with requestId: %s, ignoring response", itemId,
                    requestId or "none")
            end
            return
        end

        -- Check if this response is from ourselves (shouldn't happen, but safety check)
        if self:IsSelfSender(sender) then
            if self.debug then self:Debug("Ignoring response from ourselves (%s) for itemId: %d", sender, itemId) end
            return
        end

        -- Check if we already have a response for this request
        if request.responses[sender] then
            if self.debug then self:Debug("Already have a response from %s for this request, ignoring duplicate", sender) end
            return
        end

        -- Parse the trinket data from the response
        if self.debug then self:Debug("Attempting to deserialize data: %s", serializedData) end
        local trinketData = self:DeserializeTrinketData(serializedData)
        if not trinketData then
            self:Debug("Failed to deserialize trinket data from response")
            return
        end
        if self.debug then
            self:Debug("Successfully deserialized trinket data: buffId=%d, duration=%.1f",
                trinketData.buffId, trinketData.duration)
        end

        -- Validate the received data before processing
        if not self:ValidateTrinketDataForSending(itemId, trinketData) then
            if self.debug then
                self:Debug("Received invalid trinket data from %s for itemId: %d, ignoring", sender,
                    itemId)
            end
            return
        end

        -- Store the response data
        self.state.responseData[itemId] = {
            sender = sender,
            buffId = trinketData.buffId,
            duration = trinketData.duration,
            icd = trinketData.icd,
            type = trinketData.type,
            buffType = trinketData.buffType
        }
        if self.debug then self:Debug("Stored response data for itemId: %d from %s", itemId, sender) end

        -- Add response to pending request
        request.responses[sender] = trinketData
        if self.debug then self:Debug("Added response to pending request for itemId: %d", itemId) end

        -- Only show validation window if this was a user-initiated request
        if request.userInitiated then
            -- Don't show validation window if in combat
            if UnitAffectingCombat("player") then
                if self.debug then self:Debug("Delaying trinket validation window - player is in combat") end
                -- Store the data to show after combat
                if not self.state.pendingValidations then
                    self.state.pendingValidations = {}
                end
                self.state.pendingValidations[itemId] = {
                    trinketData = trinketData,
                    sender = sender,
                    time = GetTime()
                }
                return
            end

            -- Show validation window with the received data
            self:ShowValidationWindow(itemId, trinketData, sender)
        else
            self:Debug("Response received for non-user-initiated request, not showing validation window")
        end
    end
end

--- Shows the validation window for received trinket data
--- @param itemId number The ID of the trinket
--- @param trinketData table The received trinket data
--- @param sender string The player who sent the data
function TrinketCommunicationManager:ShowValidationWindow(itemId, trinketData, sender)
    -- Validate inputs
    if not itemId or type(itemId) ~= "number" then
        self:Debug("Invalid itemId provided to ShowValidationWindow")
        return
    end

    if not trinketData or type(trinketData) ~= "table" then
        if self.debug then self:Debug("Invalid trinketData provided to ShowValidationWindow: %s", type(trinketData)) end
        return
    end

    if not sender or type(sender) ~= "string" then
        self:Debug("Invalid sender provided to ShowValidationWindow")
        return
    end

    -- Validate required trinket data fields
    if not trinketData.buffId or type(trinketData.buffId) ~= "number" then
        self:Debug("Invalid or missing buffId in trinketData")
        return
    end

    if not trinketData.duration or type(trinketData.duration) ~= "number" then
        self:Debug("Invalid or missing duration in trinketData")
        return
    end

    -- Check if any window is already open
    if self.state.activeWindow then
        if self.debug then self:Debug("Registration window already open, skipping new window for trinket: %d", itemId) end
        return
    end

    if TrinketRegistrationManager.frame then
        TrinketRegistrationManager.frame:Hide()
        TrinketRegistrationManager.frame:ReleaseChildren()
    end

    -- Debug print received data
    if self.debug then
        self:Debug("Received trinket data from %s:", sender)
        local itemName = WoWAPI.GetItemInfo(itemId)
        self:Debug("  ItemID: %d (%s)", itemId, itemName or "Unknown")
        self:Debug("  Type: %s", trinketData.procType or "proc")
        local spellInfo = WoWAPI.GetSpellInfo(trinketData.buffId)
        self:Debug("  BuffID: %d (%s)", trinketData.buffId, spellInfo and spellInfo.name or "Unknown")
        self:Debug("  Duration: %.1f seconds", trinketData.duration)
    end
    if trinketData.icd and trinketData.icd > 0 then
        if self.debug then self:Debug("  Internal Cooldown: %.1f seconds", trinketData.icd) end
    end
    if trinketData.stats then
        local statsText = "  Stats:"
        for _, statId in ipairs(trinketData.stats) do
            local statName = NAG.Types:GetType("Stat"):GetNameByValue(statId)
            if statName then
                statsText = statsText .. " " .. statName
            end
        end
        self:Debug(statsText)
    end

    -- Create the main frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("NAG - Trinket registration")
    frame:SetLayout("List")
    frame:SetWidth(400)
    frame:SetCallback("OnClose", function(widget)
        -- Clear the active window state when closed
        self.state.activeWindow = nil
        AceGUI:Release(widget)
    end)

    -- Mark this window as active
    self.state.activeWindow = {
        itemId = itemId,
        frame = frame
    }

    -- Create content container
    local content = AceGUI:Create("SimpleGroup")
    content:SetFullWidth(true)
    content:SetLayout("List")
    frame:AddChild(content)

    -- Add description header
    local descHeader = AceGUI:Create("Label")
    descHeader:SetFullWidth(true)
    descHeader:SetText("|cFFFFD100NAG Trinket Registration|r")
    descHeader:SetFontObject(GameFontNormalLarge)
    content:AddChild(descHeader)

    -- Add description text
    local descText = AceGUI:Create("Label")
    descText:SetFullWidth(true)
    descText:SetText(
        "NAG needs to register this trinket to accurately track its procs and cooldowns for optimal DPS suggestions. Another player has shared their trinket data with you.")
    content:AddChild(descText)

    -- Add source info
    local sourceText = AceGUI:Create("Label")
    sourceText:SetFullWidth(true)
    sourceText:SetText(string.format("|cFF888888Data received from: |r|cFF00FF00%s|r", sender))
    content:AddChild(sourceText)

    -- Add spacing
    local spacer1 = AceGUI:Create("Label")
    spacer1:SetFullWidth(true)
    spacer1:SetText(" ")
    content:AddChild(spacer1)

    -- Get item info for display
    local itemName, _, itemQuality, _, _, _, _, _, _, itemTexture = WoWAPI.GetItemInfo(itemId)
    local qualityColor = itemQuality and ITEM_QUALITY_COLORS[itemQuality] or ITEM_QUALITY_COLORS[1]
    local itemLabel = AceGUI:Create("Label")
    itemLabel:SetFullWidth(true)
    itemLabel:SetText(string.format("|T%s:24:24:0:0|t %s%s|r", itemTexture or "Interface\\Icons\\INV_Misc_QuestionMark",
        qualityColor.hex, itemName or itemId))
    itemLabel:SetFontObject(GameFontNormalLarge)
    content:AddChild(itemLabel)

    -- Add spacing
    local spacer2 = AceGUI:Create("Label")
    spacer2:SetFullWidth(true)
    spacer2:SetText(" ")
    content:AddChild(spacer2)

    -- Create trinket type display
    local typeGroup = AceGUI:Create("InlineGroup")
    typeGroup:SetTitle("Trinket Type")
    typeGroup:SetLayout("List")
    typeGroup:SetFullWidth(true)
    content:AddChild(typeGroup)

    local typeLabel = AceGUI:Create("Label")
    typeLabel:SetFullWidth(true)
    typeLabel:SetText(trinketData.procType == "use" and "On-Use Trinket" or "Proc Trinket")
    typeGroup:AddChild(typeLabel)

    -- Create buff info group
    local buffGroup = AceGUI:Create("InlineGroup")
    buffGroup:SetTitle("Buff Information")
    buffGroup:SetLayout("List")
    buffGroup:SetFullWidth(true)
    content:AddChild(buffGroup)

    -- Add buff info
    local spellInfo = WoWAPI.GetSpellInfo(trinketData.buffId)
    local buffName = "Unknown"
    local buffIcon = "Interface\\Icons\\INV_Misc_QuestionMark"
    if spellInfo and spellInfo.name then
        buffName = spellInfo.name
        buffIcon = spellInfo.iconID or buffIcon
    end
    local buffLabel = AceGUI:Create("Label")
    buffLabel:SetFullWidth(true)
    buffLabel:SetText(string.format("|T%s:24:24:0:0|t |cFF00FF00%s|r (ID: %d)",
        buffIcon, buffName, trinketData.buffId))
    buffGroup:AddChild(buffLabel)

    local durationLabel = AceGUI:Create("Label")
    durationLabel:SetFullWidth(true)
    durationLabel:SetText(string.format("Duration: |cFF00FF00%.1f|r seconds", trinketData.duration))
    buffGroup:AddChild(durationLabel)

    if trinketData.icd and trinketData.icd > 0 then
        local icdLabel = AceGUI:Create("Label")
        icdLabel:SetFullWidth(true)
        icdLabel:SetText(string.format("Internal Cooldown: |cFF00FF00%.1f|r seconds", trinketData.icd))
        buffGroup:AddChild(icdLabel)
    end

    -- Add spacing
    local spacer3 = AceGUI:Create("Label")
    spacer3:SetFullWidth(true)
    spacer3:SetText(" ")
    content:AddChild(spacer3)

    -- Create stats display group
    local statGroup = AceGUI:Create("InlineGroup")
    statGroup:SetTitle("Trinket Stats")
    statGroup:SetLayout("List")
    statGroup:SetFullWidth(true)
    content:AddChild(statGroup)

    if trinketData.stats and #trinketData.stats > 0 then
        for _, statId in ipairs(trinketData.stats) do
            local statName = NAG.Types:GetType("Stat"):GetNameByValue(statId)
            if statName then
                local statLabel = AceGUI:Create("Label")
                statLabel:SetFullWidth(true)
                statLabel:SetText("• " .. statName)
                statGroup:AddChild(statLabel)
            end
        end
    else
        local noStatsLabel = AceGUI:Create("Label")
        noStatsLabel:SetFullWidth(true)
        noStatsLabel:SetText("No stats information available")
        statGroup:AddChild(noStatsLabel)
    end

    -- Create button group
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetFullWidth(true)
    buttonGroup:SetLayout("Flow")
    content:AddChild(buttonGroup)

    -- Add buttons
    local confirmBtn = AceGUI:Create("Button")
    confirmBtn:SetText("Accept & Register")
    confirmBtn:SetWidth(150)
    confirmBtn:SetCallback("OnClick", function()
        TrinketRegistrationManager:CompleteTrinketRegistration(
            itemId,
            trinketData.buffId,
            trinketData.duration,
            trinketData.stats,
            trinketData.icd
        )
        frame:Release()
    end)
    buttonGroup:AddChild(confirmBtn)

    local manualBtn = AceGUI:Create("Button")
    manualBtn:SetText("Fresh Registration")
    manualBtn:SetWidth(150)
    manualBtn:SetCallback("OnClick", function()
        frame:Release()
        TrinketRegistrationManager:InitiateManualRegistration(itemId)
    end)
    buttonGroup:AddChild(manualBtn)

    local cancelBtn = AceGUI:Create("Button")
    cancelBtn:SetText("Cancel")
    cancelBtn:SetWidth(150)
    cancelBtn:SetCallback("OnClick", function()
        frame:Release()
    end)
    buttonGroup:AddChild(cancelBtn)

    -- Show the frame
    frame:Show()
end

--- Serialize trinket data for transmission
--- @param data table The data to serialize
--- @return string|nil The serialized data, or nil if serialization failed
function TrinketCommunicationManager:SerializeTrinketData(data)
    if not AceSerializer then
        self:Debug("AceSerializer not available")
        return nil
    end

    local success, serialized = pcall(function() return AceSerializer:Serialize(data) end)
    if not success then
        if self.debug then self:Debug("Failed to serialize trinket data: %s", tostring(serialized)) end
        return nil
    end

    return serialized
end

--- Deserialize trinket data from transmission
--- @param serializedData string The serialized data
--- @return table|nil The deserialized data, or nil if deserialization failed
function TrinketCommunicationManager:DeserializeTrinketData(serializedData)
    if not AceSerializer then
        self:Debug("AceSerializer not available")
        return nil
    end

    if not serializedData or type(serializedData) ~= "string" then
        self:Debug("Invalid serialized data provided")
        return nil
    end

    -- AceSerializer:Deserialize returns (success, data) or (success, error)
    local success, data = AceSerializer:Deserialize(serializedData)
    if not success then
        if self.debug then self:Debug("Failed to deserialize trinket data: %s", tostring(data)) end
        return nil
    end

    -- Additional validation to ensure we got a proper table
    if not data or type(data) ~= "table" then
        if self.debug then self:Debug("Deserialized data is not a table: %s", type(data)) end
        return nil
    end

    -- Validate required fields
    if not data.buffId or type(data.buffId) ~= "number" then
        self:Debug("Deserialized data missing or invalid buffId")
        return nil
    end

    if not data.duration or type(data.duration) ~= "number" then
        self:Debug("Deserialized data missing or invalid duration")
        return nil
    end

    return data
end

--- Send a response with trinket data directly to a specific player
--- @param itemId number The ID of the trinket
--- @param data table The trinket data to send
--- @param targetPlayer string The player to send the response to
--- @param requestId string The request ID to include in the response
--- @return boolean Whether the response was sent successfully
function TrinketCommunicationManager:SendResponse(itemId, data, targetPlayer, requestId)
    if not (itemId and data and targetPlayer) then
        self:Debug("SendResponse: Missing required parameters")
        return false
    end

    -- Additional validation before sending
    if not self:ValidateTrinketDataForSending(itemId, data) then
        if self.debug then self:Debug("SendResponse: Data validation failed for itemId: %d", itemId) end
        return false
    end

    -- Don't send to ourselves
    if self:IsSelfSender(targetPlayer) then
        if self.debug then
            self:Debug("SendResponse: Attempted to send data to ourselves (%s) for itemId: %d",
                targetPlayer, itemId)
        end
        return false
    end

    -- Format the data for transmission
    local responseData = {
        type = data.procType or "proc",
        buffType = "custom",
        buffId = data.buffId,
        duration = data.duration,
        icd = data.icd or 0,
        stats = data.stats or {},          -- Include stats in response
        procType = data.procType or "proc" -- Ensure procType is included
    }

    -- Debug print the response data
    if self.debug then
        self:Debug("Sending trinket data to %s:", targetPlayer)
        self:Debug("  Type: %s", responseData.type)
        self:Debug("  BuffID: %d", responseData.buffId)
        self:Debug("  Duration: %.1f seconds", responseData.duration)
        self:Debug("  ICD: %.1f seconds", responseData.icd)
    end
    if responseData.stats then
        local statsText = "  Stats:"
        for _, statId in ipairs(responseData.stats) do
            local statName = NAG.Types:GetType("Stat"):GetNameByValue(statId)
            if statName then
                statsText = statsText .. " " .. statName
            end
        end
        self:Debug(statsText)
    end

    -- Serialize the trinket data
    local serializedData = self:SerializeTrinketData(responseData)
    if not serializedData then
        if self.debug then self:Debug("Failed to serialize trinket data for itemId: %d", itemId) end
        return false
    end

    -- Format the response message with request ID
    local message = string.format("%s:%d:%s:%s",
        MESSAGE_TYPES.RESPONSE,
        itemId,
        requestId or "",
        serializedData
    )

    -- Send the response directly to the target player using whisper
    if self.debug then
        self:Debug("Sending response for itemId: %d to %s with requestId: %s", itemId, targetPlayer,
            requestId or "none")
    end

    -- Use whisper to send directly to the player
    C_ChatInfo.SendAddonMessage(ADDON_PREFIX, message, "WHISPER", targetPlayer)
    return true
end

--- Handle combat end event (migrated from StateManager)
function TrinketCommunicationManager:PLAYER_REGEN_ENABLED(event)
    -- Check if we have any pending validations
    if not self.state.pendingValidations then return end

    if self.debug then self:Debug("Combat ended, checking pending trinket validations") end

    -- Show pending validations
    for itemId, data in pairs(self.state.pendingValidations) do
        -- Only show validations that are less than 5 minutes old
        -- and no window is currently open
        if (GetTime() - data.time) < 300 and not self.state.activeWindow then
            if self.debug then self:Debug("Showing delayed validation window for itemId: %d", itemId) end
            self:ShowValidationWindow(itemId, data.trinketData, data.sender)
            break -- Only show one window
        else
            if self.debug then
                self:Debug(
                    "Skipping validation request for itemId: %d - window already open or request too old", itemId)
            end
        end
    end

    -- Clear pending validations
    wipe(self.state.pendingValidations)
end
