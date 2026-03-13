--- ============================ HEADER ============================
--[[
    ShareInGame.lua - In-Game Data Sharing Module

    This module allows other parts of the addon to send serialized data
    (e.g., rotations, talent builds, configs) to other players via
    clickable chat links — similar to how WeakAuras works.

    License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
    Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
    Discord: https://discord.gg/ebonhold
]]

--- ======= LOCALIZE =======
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local OptionsFactory
local L = ns.AceLocale:GetLocale("NAG", true)
local LibBase64 = ns.LibBase64

-- Use LibJSON from Core.lua (already loaded)
local LibJSON = ns.LibJSON

-- WoW API
local C_ChatInfo = C_ChatInfo
local StaticPopup_Show = StaticPopup_Show
local SendChatMessage = SendChatMessage
local UnitInArena = _G.UnitInArena
local UnitInBattleground = _G.UnitInBattleground
local GetTime = _G.GetTime
local UnitName = _G.UnitName
local UnitAffectingCombat = _G.UnitAffectingCombat


local strmatch = strmatch
local strsub = strsub
local strsplit = strsplit
local tinsert = tinsert

-- Standard Lua functions
local format = format
local tonumber = tonumber
local tostring = tostring
local type = type
local pairs = pairs
local ipairs = ipairs
local ceil = ceil
local min = math.min

-- Enhanced error handling
local pcall = ns.pcall

-- Constants
local ADDON_PREFIX = "NAG_SHARE"
local MAX_CHUNK_SIZE = 240 -- Safe limit for addon message payload
local REQUEST_TIMEOUT = 60 -- Timeout for incomplete transfers (seconds)
local MESSAGE_TYPES = {
    REQUEST = "REQ",
    RESPONSE = "RESP",
    CHUNK = "CHUNK",
    COMPLETE = "COMPLETE"
}

-- Default settings (minimal, background-only)
local defaults = {
    global = {
        -- debugLevel automatically provided by CoreModule.lua
        enableCompression = true,
        chunkTimeout = REQUEST_TIMEOUT,
        blockAllShares = false,
        allowGuildShares = true
    }
}

-- Create the module
--- @class ShareInGame
local ShareInGame = NAG:CreateModule("ShareInGame", defaults, {
    moduleType = ns.MODULE_TYPES.CORE,
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,

    -- Define default state structure
    defaultState = {
        outgoingMessages = {}, -- msgID -> { chunks, totalChunks, data, target, messageType, name }
        incomingMessages = {}, -- msgID -> { chunks, totalChunks, sender, messageType, name, timestamp }
        handlers = {},         -- messageType -> handler function
        nextMsgID = 1
    },

    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.UTILITIES
    }
})
local module = ShareInGame
ns.ShareInGame = ShareInGame

-- ~~~~~~~~~~ MODULE INITIALIZATION ~~~~~~~~~~

function ShareInGame:ModuleInitialize()
    OptionsFactory = NAG:GetModule("OptionsFactory")
    -- Register addon message prefix
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_PREFIX)

    -- Hook SetItemRef for chat link handling
    self:HookSetItemRef()

    -- Start cleanup timer
    self:ScheduleRepeatingTimer("CleanupStaleMessages", 30)
end

function ShareInGame:ModuleEnable()

end

function ShareInGame:ModuleDisable()
    -- Cancel cleanup timer

    self:CancelAllTimers()
end

-- ~~~~~~~~~~ CHAT LINK HANDLING ~~~~~~~~~~

function ShareInGame:HookSetItemRef()
    -- Hook the SetItemRef function to handle our custom chat links
    hooksecurefunc("SetItemRef", function(link, text, button)
        local linkType = strmatch(link, "|H([^:]+):")
        if linkType == "NAGShare" then
            self:HandleShareLink(link, text, button)
        end
    end)
end

function ShareInGame:HandleShareLink(link, text, button)
    local _, messageType, msgID, sender = strsplit(":", link, 4)

    if not messageType or not msgID or not sender then
        self:Error("Invalid share link format")
        return
    end

    -- Extract the display name from the link text
    local displayName = strmatch(text, "%[(.+)%]")
    if not displayName then
        displayName = "Unknown Data"
    end

    -- Show confirmation dialog
    StaticPopup_Show("NAG_SHARE_CONFIRM", displayName, sender, {
        messageType = messageType,
        msgID = msgID,
        sender = sender,
        displayName = displayName
    })
end

-- ~~~~~~~~~~ SENDING DATA ~~~~~~~~~~

--- Send data to another player via addon messages
--- @param name string The display name for the data
--- @param dataTable table The data to send
--- @param targetPlayer string The target player name
--- @param messageType string The type of data being sent
function ShareInGame:Send(name, dataTable, targetPlayer, messageType)
    if not name or not dataTable or not targetPlayer or not messageType then
        self:Error("Send: Invalid parameters")
        return false
    end

    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end

    -- Generate unique message ID
    local msgID = self:GenerateMessageID()

    -- Serialize the data
    local serialized = self:SerializeData(dataTable)
    if self.debug then self:Debug("[Send] Full serialized string: %s (length: %d)", serialized, #serialized) end
    if not serialized then
        self:Error("Send: Failed to serialize data")
        return false
    end

    -- Base64 encode the entire serialized string
    local encoded = LibBase64:encode(serialized)
    self:Trace("[Send] Full base64-encoded string length:", #encoded)

    -- Split into chunks (now splitting the base64 string)
    local chunks = self:SplitIntoChunks(encoded, msgID, messageType)
    if not chunks then
        self:Error("Send: Failed to split data into chunks")
        return false
    end

    -- Store outgoing message info
    self.state.outgoingMessages[msgID] = {
        chunks = chunks,
        totalChunks = #chunks,
        data = dataTable,
        target = targetPlayer,
        messageType = messageType,
        name = name,
        timestamp = GetTime()
    }

    -- Send the chunks
    for i, chunk in ipairs(chunks) do
        if self.debug then self:Trace("[Send] Sending chunk %d/%d (length: %d): %s", i, #chunks, #chunk, chunk) end
        C_ChatInfo.SendAddonMessage(ADDON_PREFIX, chunk, "WHISPER", targetPlayer)
        if self.debug then self:Trace("Sent chunk %d/%d to %s", i, #chunks, targetPlayer) end
    end

    -- Create and send chat link
    local link = format("|cff33ccff|HNAGShare:%s:%s:%s|h[Click to receive '%s']|h|r",
        messageType, msgID, UnitName("player"), name)

    -- Send the link to chat
    SendChatMessage(format("NAG Share: %s", link), "WHISPER", nil, targetPlayer)

    if self.debug then self:Info("Sent %s to %s (%d chunks)", name, targetPlayer, #chunks) end
    return true
end

-- ~~~~~~~~~~ RECEIVING DATA ~~~~~~~~~~

function ShareInGame:CHAT_MSG_ADDON(event, prefix, message, channel, sender)
    if prefix ~= ADDON_PREFIX then return end

    local messageType, msgID, chunkIndex, totalChunks, payload = strsplit("|", message, 5)

    if not messageType or not msgID then
        self:Error("Invalid addon message format")
        return
    end

    if messageType == MESSAGE_TYPES.CHUNK then
        self:HandleChunk(msgID, tonumber(chunkIndex), tonumber(totalChunks), payload, sender)
    elseif messageType == MESSAGE_TYPES.REQUEST then
        self:HandleRequest(msgID, payload, sender)
    elseif messageType == MESSAGE_TYPES.RESPONSE then
        self:HandleResponse(msgID, payload, sender)
    elseif messageType == MESSAGE_TYPES.COMPLETE then
        self:HandleComplete(msgID, payload, sender)
    end
end

function ShareInGame:HandleChunk(msgID, chunkIndex, totalChunks, payload, sender)
    if not msgID or not chunkIndex or not totalChunks or not payload then
        self:Error("Invalid chunk message")
        return
    end
    self:Trace("[HandleChunk] chunkIndex type: " .. type(chunkIndex) .. ", value: " .. tostring(chunkIndex))
    self:Trace("[HandleChunk] RAW payload (first 200 chars): " ..
        (payload and string.sub(payload, 1, 200) or "<nil>") ..
        " (length: " .. (payload and tostring(#payload) or "0") .. ")")
    self:Trace("[HandleChunk] Storing chunk " ..
        tostring(chunkIndex) .. ": " .. (payload and string.sub(payload, 1, 50) or "<nil>"))

    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end

    -- Initialize incoming message if not exists
    if not self.state.incomingMessages[msgID] then
        self.state.incomingMessages[msgID] = {
            chunks = {},
            totalChunks = totalChunks,
            sender = sender,
            timestamp = GetTime()
        }
    end

    local msg = self.state.incomingMessages[msgID]

    -- Store the base64 chunk as-is
    msg.chunks[chunkIndex] = payload
    self:Trace("[HandleChunk] Stored chunk " ..
        tostring(chunkIndex) ..
        " for msgID " .. tostring(msgID) .. " (length: " .. (payload and tostring(#payload) or "0") .. ")")

    -- Check if we have all chunks
    if self:HasAllChunks(msg) then
        self:ProcessCompleteMessage(msgID)
    end
end

function ShareInGame:HandleRequest(msgID, payload, sender)
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end

    -- Check if incoming shares should be blocked
    if self:ShouldBlockIncomingShare(sender) then
        self:Error(format("Incoming share request from %s blocked due to combat/encounter status or global block.",
            sender))
        return
    end

    -- Extract message info from payload
    local messageType, name = strsplit(":", payload, 2)

    -- Check if we have a handler for this message type
    local handlerEntry = self.state.handlers[messageType]
    if not handlerEntry then
        if self.debug then self:Debug("No handler registered for message type: %s", messageType) end
        return
    end

    -- Call the handler
    if handlerEntry.requireConfirmation ~= false then
        -- Show confirmation dialog, store pending
        local pendingKey = tostring(msgID) .. ":" .. tostring(messageType)
        self._pendingShares = self._pendingShares or {}
        self._pendingShares[pendingKey] = {
            handler = handlerEntry.fn,
            sender = sender,
            data = { messageType = messageType, name = name, msgID = msgID },
            messageType = messageType
        }
        StaticPopup_Show("NAG_SHARE_CONFIRM", name, sender, { _pendingKey = pendingKey })
        if self.debug then self:Info("Prompted user to accept share '%s' from %s", name, sender) end
    else
        -- No confirmation required, call handler directly
        handlerEntry.fn(sender, { messageType = messageType, name = name, msgID = msgID })
        if self.debug then self:Info("Processed share '%s' from %s (no confirmation)", name, sender) end
    end
end

function ShareInGame:HandleResponse(msgID, payload, sender)
    -- Handle response to our request (future enhancement)
    if self.debug then self:Debug("Received response for msgID: %s from %s", msgID, sender) end
end

function ShareInGame:HandleComplete(msgID, payload, sender)
    -- Handle completion notification (future enhancement)
    if self.debug then self:Debug("Received completion notification for msgID: %s from %s", msgID, sender) end
end

-- ~~~~~~~~~~ DATA PROCESSING (UPDATED) ~~~~~~~~~~

function ShareInGame:ProcessCompleteMessage(msgID)
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    local msg = self.state.incomingMessages[msgID]
    if not msg then return end
    -- Log the contents of msg.chunks
    local chunkWall = "[ProcessCompleteMessage] msg.chunks lengths: "
    for i = 1, msg.totalChunks do
        local chunk = msg.chunks[i]
        chunkWall = chunkWall .. (chunk and tostring(#chunk) or "<nil>")
        if i < msg.totalChunks then chunkWall = chunkWall .. ", " end
    end
    self:Trace(chunkWall)
    for i = 1, msg.totalChunks do
        local chunk = msg.chunks[i]
        self:Trace("[ProcessCompleteMessage] Chunk " ..
            tostring(i) .. "/" .. tostring(msg.totalChunks) .. " length: " .. (chunk and tostring(#chunk) or "<nil>"))
    end
    -- Concatenate all base64 chunks
    local encoded = ""
    for i = 1, msg.totalChunks do
        local chunk = msg.chunks[i]
        if not chunk then
            self:Error("Missing chunk " .. tostring(i) .. " for msgID " .. tostring(msgID))
            return
        end
        encoded = encoded .. chunk
    end
    if self.debug then
        self:Trace("[ProcessCompleteMessage] Full reassembled base64 string length: %s",
            tostring(#encoded))
    end
    if self.debug then
        self:Trace("[ProcessCompleteMessage] Base64 string (first 200 chars): %s",
            string.sub(encoded, 1, 200))
    end
    -- Base64 decode the full string
    local serialized = LibBase64:decode(encoded)
    if not serialized or serialized == "" then
        self:Error("[ProcessCompleteMessage] Base64 decode returned nil or empty string!")
    end
    if self.debug then
        self:Trace("[ProcessCompleteMessage] Decoded serialized string length: %s",
            serialized and tostring(#serialized) or 0)
    end
    if self.debug then
        self:Trace("[ProcessCompleteMessage] Decoded string (first 200 chars): %s",
            serialized and string.sub(serialized, 1, 200) or "<nil>")
    end
    -- Proceed as before
    if self.debug then self:Trace("[Deserialize] Full reassembled string: %s", serialized) end
    local data = self:DeserializeData(serialized)
    if not data then
        self:Error(format("Failed to deserialize data for msgID %s", msgID))
        return
    end
    -- Centralized handler/confirmation logic
    local handlerEntry = self.state.handlers[data.messageType]
    if handlerEntry and type(handlerEntry) == "table" and handlerEntry.fn then
        if handlerEntry.requireConfirmation ~= false then
            -- Show confirmation dialog, store pending
            local pendingKey = tostring(msgID) .. ":" .. tostring(data.messageType)
            self._pendingShares = self._pendingShares or {}
            self._pendingShares[pendingKey] = {
                handler = handlerEntry.fn,
                sender = msg.sender,
                data = data,
                messageType = data.messageType
            }
            StaticPopup_Show("NAG_SHARE_CONFIRM", data.name or data.messageType, msg.sender, { _pendingKey = pendingKey })
            if self.debug then
                self:Info("Prompted user to accept share '%s' from %s", data.name or data.messageType,
                    msg.sender)
            end
        else
            -- No confirmation required, call handler directly
            handlerEntry.fn(msg.sender, data)
            if self.debug then
                self:Info("Processed share '%s' from %s (no confirmation)", data.name or data.messageType,
                    msg.sender)
            end
        end
    else
        self:Error("[ProcessCompleteMessage] No handler for message type: " .. tostring(data.messageType))
    end
    -- Clean up
    self.state.incomingMessages[msgID] = nil
end

-- ~~~~~~~~~~ UTILITY FUNCTIONS ~~~~~~~~~~

--- Check if incoming shares should be blocked
--- @param sender string The sender's name
--- @return boolean True if shares should be blocked
function ShareInGame:ShouldBlockIncomingShare(sender)
    -- Always block if global block is enabled (unless guild override)
    if self.db.global.blockAllShares then
        -- Check if guild override is enabled and sender is in guild
        if self.db.global.allowGuildShares and sender then
            local guildName = GetGuildInfo(sender)
            if guildName and guildName == GetGuildInfo("player") then
                return false -- Allow guild members to override
            end
        end
        return true -- Block all others
    end

    -- Always block during combat
    if UnitAffectingCombat("player") then
        return true
    end

    -- Always block during encounters
    if UnitInBattleground("player") or UnitInArena("player") then
        return true
    end

    return false
end

function ShareInGame:GenerateMessageID()
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end

    local msgID = self.state.nextMsgID
    self.state.nextMsgID = self.state.nextMsgID + 1
    return tostring(msgID)
end

function ShareInGame:SplitIntoChunks(encodedData, msgID, messageType)
    local chunks = {}
    local dataLen = #encodedData
    local chunkCount = ceil(dataLen / MAX_CHUNK_SIZE)

    for i = 1, chunkCount do
        local startPos = (i - 1) * MAX_CHUNK_SIZE + 1
        local endPos = min(i * MAX_CHUNK_SIZE, dataLen)
        local chunkData = strsub(encodedData, startPos, endPos)
        if self.debug then self:Trace("[SplitIntoChunks] Chunk %d: (base64 len: %d)", i, #chunkData) end
        local chunk = format("%s|%s|%d|%d|%s",
            MESSAGE_TYPES.CHUNK, msgID, i, chunkCount, chunkData)
        tinsert(chunks, chunk)
    end
    return chunks
end

function ShareInGame:HasAllChunks(msg)
    if #msg.chunks ~= msg.totalChunks then
        return false
    end

    for i = 1, msg.totalChunks do
        if not msg.chunks[i] then
            return false
        end
    end

    return true
end

function ShareInGame:SerializeData(dataTable)
    -- Use LibCompress if available and enabled
    local enableCompression = false
    local global = self.db.global.enableCompression
    if global then
        enableCompression = true
    end

    -- Try compression if enabled
    if enableCompression then
        local ok, LibCompress = pcall(function() return LibStub("LibCompress", true) end)
        if ok and LibCompress and LibJSON then
            local ok2, jsonStr = pcall(LibJSON.Serialize, dataTable)
            if ok2 and jsonStr then
                local ok3, compressed = pcall(LibCompress.CompressLZW, LibCompress, jsonStr)
                if type(compressed) == "string" and compressed ~= jsonStr then
                    -- Try decompressing to verify
                    local ok4, test = pcall(LibCompress.DecompressLZW, LibCompress, compressed)
                    if ok4 and test == jsonStr then
                        self:Debug("[SerializeData] Using COMPRESSED header (compression verified)")
                        return "COMPRESSED:" .. compressed
                    else
                        self:Warn(
                            "[SerializeData] Compression output did not decompress to original; falling back to JSON.")
                    end
                else
                    self:Warn("[SerializeData] Compression failed or returned input unchanged; falling back to JSON.")
                end
            else
                self:Error("[SerializeData] JSON serialization failed: " .. tostring(jsonStr))
            end
        else
            if not ok or not LibCompress then
                self:Warn("[SerializeData] LibCompress not available.")
            end
        end
    end

    -- Fallback to JSON (LibJSON is already loaded from Core.lua)
    if LibJSON then
        local ok, jsonStr = pcall(LibJSON.Serialize, dataTable)
        if ok and jsonStr then
            self:Trace("[SerializeData] Using JSON header (compression not used or failed)")
            return "JSON:" .. jsonStr
        else
            self:Error("[SerializeData] JSON serialization failed: " .. tostring(jsonStr))
        end
    else
        self:Error("[SerializeData] LibJSON not available for fallback.")
    end

    -- Last resort: simple table serialization
    return "SIMPLE:" .. self:SimpleSerialize(dataTable)
end

function ShareInGame:DeserializeData(serialized)
    -- Robust against self-send: sender and receiver are the same, so version mismatch is not the issue
    local dataFormat, data = strsplit(":", serialized, 2)
    self:Trace("[Deserialize] Format: " .. tostring(dataFormat))
    if dataFormat == "COMPRESSED" then
        local ok, LibCompress = pcall(function() return LibStub("LibCompress", true) end)
        if not ok or not LibCompress then
            self:Error("[Deserialize] LibCompress not available or failed to load.")
            return nil
        end
        if not LibJSON then
            self:Error("[Deserialize] LibJSON not available or failed to load.")
            return nil
        end
        -- Log type and length of COMPRESSED data
        self:Trace("[Deserialize] COMPRESSED data type: " .. type(data) .. ", length: " .. (data and #data or "nil"))
        -- Hex dump of COMPRESSED data (first 64 bytes)
        if type(data) == "string" then
            local hex = ""
            for i = 1, math.min(64, #data) do
                hex = hex .. string.format("%02X ", data:byte(i))
            end
            self:Trace("[Deserialize] COMPRESSED data hex (first 64 bytes): " .. hex)
        end
        -- Decompress with pcall
        local ok2, decompressed = pcall(LibCompress.DecompressLZW, LibCompress, data)
        if not ok2 then
            self:Error("[Deserialize] DecompressLZW error: " .. tostring(decompressed))
            return nil
        end
        self:Trace("[Deserialize] Decompressed string: " .. tostring(decompressed))
        if decompressed then
            self:Trace("[Deserialize] Decompressed string length: " .. tostring(#decompressed))
            local hex = ""
            for i = 1, math.min(64, #decompressed) do
                hex = hex .. string.format("%02X ", decompressed:byte(i))
            end
            self:Trace("[Deserialize] Decompressed hex (first 64 bytes): " .. hex)
            local ok3, result = pcall(LibJSON.Deserialize, decompressed)
            if not ok3 then
                self:Error("[Deserialize] JSON error: " .. tostring(result))
            end
            return ok3 and result or nil
        end
    elseif dataFormat == "JSON" then
        if LibJSON then
            local ok, result = pcall(LibJSON.Deserialize, data)
            if not ok then
                self:Error("[Deserialize] JSON error: " .. tostring(result))
            end
            return ok and result or nil
        else
            self:Warn("[Deserialize] LibJSON not available for JSON format.")
        end
    elseif dataFormat == "SIMPLE" then
        return self:SimpleDeserialize(data)
    end
    return nil
end

function ShareInGame:SimpleSerialize(tbl)
    -- Simple table serialization for basic data structures
    -- This is a basic implementation - consider using proper JSON for complex data
    local result = {}

    for k, v in pairs(tbl) do
        if type(v) == "string" then
            tinsert(result, format("%s=%q", k, v))
        elseif type(v) == "number" or type(v) == "boolean" then
            tinsert(result, format("%s=%s", k, tostring(v)))
        end
    end

    return table.concat(result, ",")
end

function ShareInGame:SimpleDeserialize(data)
    -- Simple table deserialization
    local result = {}

    for k, v in data:gmatch("([^=]+)=([^,]+)") do
        if v:match("^%d+$") then
            result[k] = tonumber(v)
        elseif v == "true" then
            result[k] = true
        elseif v == "false" then
            result[k] = false
        else
            -- Remove quotes from strings
            result[k] = v:gsub("^\"(.*)\"$", "%1")
        end
    end

    return result
end

-- ~~~~~~~~~~ HANDLER REGISTRATION ~~~~~~~~~~

--- Register a handler for a specific message type
--- @param messageType string The type of message to handle
--- @param handler function The handler function(sender, data)
--- @param requireConfirmation boolean? Whether to require user confirmation (default true)
function ShareInGame:RegisterHandler(messageType, handler, requireConfirmation)
    if not messageType or type(handler) ~= "function" then
        self:Error("RegisterHandler: Invalid parameters")
        return
    end
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    -- Store handler and confirmation flag
    self.state.handlers[messageType] = {
        fn = handler,
        requireConfirmation = requireConfirmation ~= false -- default true
    }
    if self.debug then
        self:Debug("Registered handler for message type: %s (requireConfirmation=%s)", messageType,
            tostring(requireConfirmation ~= false))
    end
end

--- Unregister a handler for a specific message type
--- @param messageType string The type of message to unregister
function ShareInGame:UnregisterHandler(messageType)
    if not messageType then
        self:Error("UnregisterHandler: Invalid message type")
        return
    end
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end
    self.state.handlers[messageType] = nil
    if self.debug then self:Debug("Unregistered handler for message type: %s", messageType) end
end

-- ~~~~~~~~~~ CENTRALIZED CONFIRMATION LOGIC ~~~~~~~~~~

-- Store pending share data for confirmation
ShareInGame._pendingShares = ShareInGame._pendingShares or {}

-- Override the static popup to call a central accept/decline handler
StaticPopupDialogs["NAG_SHARE_CONFIRM"] = {
    text = "Do you want to receive '%s' from %s?",
    button1 = "Accept",
    button2 = "Decline",
    OnAccept = function(self, data)
        local ShareInGame = NAG:GetModule("ShareInGame")
        if data and data._pendingKey then
            ShareInGame:HandleShareAccept(data._pendingKey)
        end
    end,
    OnCancel = function(self, data)
        local ShareInGame = NAG:GetModule("ShareInGame")
        if data and data._pendingKey then
            ShareInGame:HandleShareDecline(data._pendingKey)
        end
    end,
    timeout = 30,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}

function ShareInGame:HandleShareAccept(pendingKey)
    local pending = self._pendingShares and self._pendingShares[pendingKey]
    if pending then
        if pending.handler then
            pending.handler(pending.sender, pending.data)
            if self.debug then
                self:Info("Accepted and processed share '%s' from %s",
                    pending.data.name or pending.messageType, pending.sender)
            end
        end
        self._pendingShares[pendingKey] = nil
    end
end

function ShareInGame:HandleShareDecline(pendingKey)
    local pending = self._pendingShares and self._pendingShares[pendingKey]
    if pending then
        if self.debug then
            self:Info("Declined share '%s' from %s",
                pending.data and pending.data.name or pending.messageType, pending.sender)
        end
        self._pendingShares[pendingKey] = nil
    end
end

-- ~~~~~~~~~~ CLEANUP ~~~~~~~~~~

function ShareInGame:CleanupStaleMessages()
    -- Ensure state is initialized
    if not self.state then
        self:InitializeState()
    end

    local currentTime = GetTime()
    local timeout = self.db.global.chunkTimeout

    -- Clean up incoming messages
    for msgID, msg in pairs(self.state.incomingMessages) do
        if currentTime - msg.timestamp > timeout then
            if self.debug then self:Debug("Cleaning up stale incoming message: %s", msgID) end
            self.state.incomingMessages[msgID] = nil
        end
    end

    -- Clean up outgoing messages
    for msgID, msg in pairs(self.state.outgoingMessages) do
        if currentTime - msg.timestamp > timeout then
            if self.debug then self:Debug("Cleaning up stale outgoing message: %s", msgID) end
            self.state.outgoingMessages[msgID] = nil
        end
    end
end

-- ~~~~~~~~~~ MODULE EXPORTS ~~~~~~~~~~


-- ~~~~~~~~~~ USER CONTROLS ~~~~~~~~~~

--- Get options for user controls
--- @return table Options table for AceConfig
function ShareInGame:GetOptions()
    return {
        type = "group",
        name = L["Share In Game"] or "Share In Game",
        desc = L["Control sharing functionality with other players"] or "Control sharing functionality with other players",
        order = 200,
        args = {
            enableCompression = OptionsFactory:CreateToggle(L["enableCompression"] or "Enable Compression", L["enableCompressionDesc"] or "Enable compression for shared data (reduces message size)",
                function() return self:GetSetting("global", "enableCompression") end,
                function(_, value)
                    self:SetSetting("global", "enableCompression", value)
                end,
                { order = 4 }
            ),
            chunkTimeout = OptionsFactory:CreateRange(L["chunkTimeout"] or "Chunk Timeout", L["chunkTimeoutDesc"] or "Timeout for message chunks in seconds",
                function() return self:GetSetting("global", "chunkTimeout") end,
                function(_, value)
                    self:SetSetting("global", "chunkTimeout", value)
                end,
                {
                    order = 3,
                    min = 5,
                    max = 60,
                    step = 1
                }
            ),
            blockAllShares = OptionsFactory:CreateToggle(L["blockAllShares"] or "Block All Incoming Shares", L["blockAllSharesDesc"] or "Block all incoming shares from other players",
                function() return self:GetSetting("global", "blockAllShares") end,
                function(_, value)
                    self:SetSetting("global", "blockAllShares", value)
                end,
                { order = 1 }
            ),
            allowGuildShares = OptionsFactory:CreateToggle(L["allowGuildShares"] or "Allow Guild Member Shares", L["allowGuildSharesDesc"] or "Allow guild members to share even when blocking is enabled",
                function() return self:GetSetting("global", "allowGuildShares") end,
                function(_, value)
                    self:SetSetting("global", "allowGuildShares", value)
                end,
                { order = 2 }
            )
        }
    }
end
