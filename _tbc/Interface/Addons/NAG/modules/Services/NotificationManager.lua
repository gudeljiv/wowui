--- @module "NAG.NotificationManager"
--- UI notification system for displaying user-facing messages
---
--- Provides a movable, resizable notification bar for important messages
--- that need more visibility than chat output.
---
--- Features:
--- - Movable/resizable notification frame
--- - Auto-hide after duration or persistent display
--- - Message types: info, warning, error, success
--- - Message queue for multiple notifications
--- - Custom hide conditions via callback functions
--- - Position persistence in database
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Lua APIs
local format = string.format
local type = type

-- Table operations
local tinsert = tinsert
local tremove = tremove
local wipe = wipe

-- WoW APIs
local GetTime = _G.GetTime
local CreateFrame = _G.CreateFrame
local C_Timer = C_Timer

-- ============================ MODULE DEFAULTS ============================

local defaults = {
    char = {
        position = {
            point = "TOP",
            relativePoint = "TOP",
            xOfs = 0,
            yOfs = -200
        },
        width = 400,
        height = 60,
        enabled = true,
        autoHideDuration = 5, -- seconds
    }
}

-- ============================ MODULE CREATION ============================

local NotificationManager = NAG:CreateModule("NotificationManager", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,

    slashCommands = {
        -- NEW HIERARCHICAL FORMAT:
        ["notification_test"] = {
            handler = "TestNotification",
            help = "Test the notification system",
            root = "nagdebug",
            path = {"notification", "test"},
            category = "Debug"
        },
        ["notification_clear"] = {
            handler = "ClearAllNotifications",
            help = "Clear all active notifications",
            root = "nagdebug",
            path = {"notification", "clear"},
            category = "System"
        }
    }
})

-- ============================ MODULE STATE ============================

NotificationManager.frame = nil
NotificationManager.messageQueue = {}
NotificationManager.currentMessage = nil
NotificationManager.hideTimer = nil

-- Message type colors
NotificationManager.typeColors = {
    info = {0.2, 0.6, 1.0, 1.0},      -- Blue
    warning = {1.0, 0.8, 0.0, 1.0},   -- Yellow/Gold
    error = {1.0, 0.2, 0.2, 1.0},     -- Red
    success = {0.2, 1.0, 0.4, 1.0},   -- Green
}

-- ============================ FRAME CREATION ============================

function NotificationManager:CreateNotificationFrame()
    if self.frame then
        return self.frame
    end

    -- Create main frame
    local frame = CreateFrame("Frame", "NAGNotificationFrame", UIParent, "BackdropTemplate")
    frame:SetSize(self.db.char.width, self.db.char.height)
    frame:SetFrameStrata("HIGH")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:Hide()

    -- Set backdrop
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.9)
    frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

    -- Create message text
    frame.messageText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.messageText:SetPoint("CENTER")
    frame.messageText:SetJustifyH("CENTER")
    frame.messageText:SetJustifyV("MIDDLE")
    frame.messageText:SetWordWrap(true)
    frame.messageText:SetWidth(frame:GetWidth() - 20)

    -- Create close button
    frame.closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.closeButton:SetPoint("TOPRIGHT", -2, -2)
    frame.closeButton:SetSize(20, 20)
    frame.closeButton:SetScript("OnClick", function()
        self:HideNotification()
    end)

    -- Drag handlers
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)

    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        NotificationManager:SavePosition()
    end)

    -- Resize button (bottom right corner)
    frame.resizeButton = CreateFrame("Button", nil, frame)
    frame.resizeButton:SetSize(16, 16)
    frame.resizeButton:SetPoint("BOTTOMRIGHT", -2, 2)
    frame.resizeButton:EnableMouse(true)
    frame.resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    frame.resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    frame.resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

    frame.resizeButton:SetScript("OnMouseDown", function()
        frame:StartSizing("BOTTOMRIGHT")
    end)

    frame.resizeButton:SetScript("OnMouseUp", function()
        frame:StopMovingOrSizing()
        NotificationManager:SaveSize()
        -- Update text width
        frame.messageText:SetWidth(frame:GetWidth() - 20)
    end)

    frame:SetResizable(true)
    -- Classic WoW uses SetResizeBounds instead of SetMinResize/SetMaxResize
    frame:SetResizeBounds(200, 40, 800, 200)

    self.frame = frame

    -- Restore saved position
    self:RestorePosition()

    return frame
end

-- ============================ POSITION MANAGEMENT ============================

function NotificationManager:SavePosition()
    if not self.frame then return end

    local point, _, relativePoint, xOfs, yOfs = self.frame:GetPoint()
    self.db.char.position = {
        point = point,
        relativePoint = relativePoint,
        xOfs = xOfs,
        yOfs = yOfs
    }
end

function NotificationManager:RestorePosition()
    if not self.frame then return end

    local pos = self.db.char.position
    self.frame:ClearAllPoints()
    self.frame:SetPoint(pos.point, UIParent, pos.relativePoint, pos.xOfs, pos.yOfs)
end

function NotificationManager:SaveSize()
    if not self.frame then return end

    self.db.char.width = self.frame:GetWidth()
    self.db.char.height = self.frame:GetHeight()
end

-- ============================ MESSAGE DISPLAY ============================

--- Show a user message in the notification frame
--- @param message string The message to display
--- @param messageType? string Type: "info", "warning", "error", "success" (default: "info")
--- @param duration? number How long to show in seconds (default: from settings, 0 = persistent)
--- @param options? table Additional options
---   - hideCondition: function() return boolean end - Custom hide condition
---   - onHide: function() - Callback when message is hidden
function NotificationManager:ShowUserMessage(message, messageType, duration, options)
    if not self.db.char.enabled then
        -- Fallback to chat if notifications disabled
        self:Print(message)
        return
    end

    messageType = messageType or "info"
    duration = duration or self.db.char.autoHideDuration
    options = options or {}

    -- Create notification data
    local notification = {
        message = message,
        type = messageType,
        duration = duration,
        timestamp = GetTime(),
        hideCondition = options.hideCondition,
        onHide = options.onHide
    }

    -- If currently showing a message, queue this one
    if self.currentMessage then
        tinsert(self.messageQueue, notification)
        return
    end

    -- Show immediately
    self:DisplayNotification(notification)
end

function NotificationManager:DisplayNotification(notification)
    if not self.frame then
        self:CreateNotificationFrame()
    end

    self.currentMessage = notification

    -- Set message text
    self.frame.messageText:SetText(notification.message)

    -- Set color based on type
    local color = self.typeColors[notification.type] or self.typeColors.info
    self.frame:SetBackdropBorderColor(unpack(color))
    self.frame.messageText:SetTextColor(unpack(color))

    -- Show frame
    self.frame:Show()

    -- Set up auto-hide timer if duration > 0
    if notification.duration > 0 then
        if self.hideTimer then
            self.hideTimer:Cancel()
        end

        self.hideTimer = C_Timer.NewTimer(notification.duration, function()
            self:CheckHideCondition()
        end)
    end

    -- If there's a custom hide condition, check it periodically
    if notification.hideCondition then
        self:StartHideConditionCheck()
    end
end

function NotificationManager:StartHideConditionCheck()
    -- Check every 0.5 seconds if the hide condition is met
    if self.conditionCheckTimer then
        self.conditionCheckTimer:Cancel()
    end

    self.conditionCheckTimer = C_Timer.NewTicker(0.5, function()
        self:CheckHideCondition()
    end)
end

function NotificationManager:CheckHideCondition()
    if not self.currentMessage then
        return
    end

    -- Check custom hide condition if present
    if self.currentMessage.hideCondition then
        local shouldHide = self.currentMessage.hideCondition()
        if shouldHide then
            self:HideNotification()
        end
    else
        -- No custom condition, just hide
        self:HideNotification()
    end
end

function NotificationManager:HideNotification()
    if not self.frame then return end

    -- Call onHide callback if present
    if self.currentMessage and self.currentMessage.onHide then
        self.currentMessage.onHide()
    end

    -- Cancel timers
    if self.hideTimer then
        self.hideTimer:Cancel()
        self.hideTimer = nil
    end

    if self.conditionCheckTimer then
        self.conditionCheckTimer:Cancel()
        self.conditionCheckTimer = nil
    end

    -- Hide frame
    self.frame:Hide()
    self.currentMessage = nil

    -- Show next message in queue if any
    if #self.messageQueue > 0 then
        local nextMessage = tremove(self.messageQueue, 1)
        -- Small delay before showing next message
        C_Timer.After(0.5, function()
            self:DisplayNotification(nextMessage)
        end)
    end
end

function NotificationManager:ClearAllNotifications()
    wipe(self.messageQueue)
    self:HideNotification()
    self:Print("All notifications cleared")
end

-- ============================ MODULE LIFECYCLE ============================

function NotificationManager:ModuleInitialize()
    self.initialized = true
end

function NotificationManager:ModuleEnable()
    -- Create frame on demand
    -- Register global method after database is ready
    self:RegisterGlobalMethod()
end

function NotificationManager:ModuleDisable()
    if self.hideTimer then
        self.hideTimer:Cancel()
        self.hideTimer = nil
    end
    if self.conditionCheckTimer then
        self.conditionCheckTimer:Cancel()
        self.conditionCheckTimer = nil
    end
    if self.frame then
        self.frame:Hide()
    end
    wipe(self.messageQueue)
    self.currentMessage = nil
end

-- ============================ SLASH COMMAND HANDLERS ============================

function NotificationManager:TestNotification(args)
    -- Parse arguments: type, duration, message
    local messageType, duration, message

    if args and args ~= "" then
        local parts = {strsplit(" ", args)}
        messageType = parts[1] or "info"
        duration = tonumber(parts[2]) or 5
        message = args:gsub("^%S+%s+%S+%s+", "") -- Remove first two words

        if message == "" or message == args then
            message = "This is a test notification!"
        end
    else
        messageType = "info"
        duration = 5
        message = "This is a test notification!"
    end

    self:ShowUserMessage(message, messageType, duration)
    self:Print(format("Test notification sent: type=%s, duration=%ds", messageType, duration))
end

-- ============================ PUBLIC API ============================

--- Add NAG:ShowUserMessage() method to main addon
function NotificationManager:RegisterGlobalMethod()
    if NAG then
        NAG.ShowUserMessage = function(_, message, messageType, duration, options)
            NotificationManager:ShowUserMessage(message, messageType, duration, options)
        end
        self:Debug("Registered NAG:ShowUserMessage() global method")
    end
end

-- Also expose on namespace for utility access
ns.NotificationManager = NotificationManager

return NotificationManager

