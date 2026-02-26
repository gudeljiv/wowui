local _, nMainbar = ...
local cfg = nMainbar.Config

if not cfg.showPicomenu then
    return
end

-- Saved Variable Setup
if BagsShown == nil then
    BagsShown = false
end

-- Bags Position Management
local bagsConfig = {
    offsetX = 0,
    offsetY = 0,
}

-- Load position from config
if nMainbar.Config.bags then
    bagsConfig.offsetX = nMainbar.Config.bags.offsetX or 0
    bagsConfig.offsetY = nMainbar.Config.bags.offsetY or 0
end

-- Function to position all bag buttons
local function UpdateBagsPosition()
    local offsetX = (nMainbar.Config.bags and nMainbar.Config.bags.offsetX) or bagsConfig.offsetX
    local offsetY = (nMainbar.Config.bags and nMainbar.Config.bags.offsetY) or bagsConfig.offsetY
    
    -- Clear frame position - with nil checks
    if MainMenuBarBackpackButton then
        MainMenuBarBackpackButton:ClearAllPoints()
    end
    
    if CharacterBag0Slot then CharacterBag0Slot:ClearAllPoints() end
    if CharacterBag1Slot then CharacterBag1Slot:ClearAllPoints() end
    if CharacterBag2Slot then CharacterBag2Slot:ClearAllPoints() end
    if CharacterBag3Slot then CharacterBag3Slot:ClearAllPoints() end
    
    -- Set new frame position with offsets - with nil checks
    if MainMenuBarBackpackButton then
        MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", WorldFrame, "BOTTOMRIGHT", offsetX, offsetY)
    end
    
    if CharacterBag0Slot and MainMenuBarBackpackButton then
        CharacterBag0Slot:SetPoint("BOTTOMRIGHT", MainMenuBarBackpackButton, "BOTTOMLEFT", 0, 0)
    end
    
    if CharacterBag1Slot and CharacterBag0Slot then
        CharacterBag1Slot:SetPoint("RIGHT", CharacterBag0Slot, "LEFT", 0, 0)
    end
    
    if CharacterBag2Slot and CharacterBag1Slot then
        CharacterBag2Slot:SetPoint("RIGHT", CharacterBag1Slot, "LEFT", 0, 0)
    end
    
    if CharacterBag3Slot and CharacterBag2Slot then
        CharacterBag3Slot:SetPoint("RIGHT", CharacterBag2Slot, "LEFT", 0, 0)
    end
end

-- DON'T call UpdateBagsPosition here - wait for ADDON_LOADED
-- UpdateBagsPosition()

-- Make bags draggable with SHIFT + Left Click
local isDragging = false
local dragStartX, dragStartY

local function EnableBagsDragging()
    if not MainMenuBarBackpackButton then return end
    
    -- Create an invisible frame over all bags for easier dragging
    local dragFrame = CreateFrame("Frame", "nMainbarBagsDragFrame", UIParent)
    dragFrame:SetFrameStrata("HIGH")
    dragFrame:SetFrameLevel(100)
    dragFrame:EnableMouse(false)  -- Start disabled, only enable when SHIFT is held
    dragFrame:SetMovable(true)
    dragFrame:RegisterForDrag("LeftButton")
    
    -- Position dragFrame to cover all bag buttons
    local function UpdateDragFrameSize()
        if MainMenuBarBackpackButton and CharacterBag3Slot then
            dragFrame:ClearAllPoints()
            dragFrame:SetPoint("BOTTOMLEFT", CharacterBag3Slot, "BOTTOMLEFT", -5, -5)
            dragFrame:SetPoint("TOPRIGHT", MainMenuBarBackpackButton, "TOPRIGHT", 5, 5)
        end
    end
    
    C_Timer.After(1, UpdateDragFrameSize)
    
    -- Monitor SHIFT key to enable/disable mouse
    dragFrame:SetScript("OnUpdate", function(self)
        if IsShiftKeyDown() then
            if not self:IsMouseEnabled() then
                self:EnableMouse(true)
            end
        else
            if self:IsMouseEnabled() and not isDragging then
                self:EnableMouse(false)
            end
        end
    end)
    
    dragFrame:SetScript("OnDragStart", function(self)
        if IsShiftKeyDown() then
            isDragging = true
            local scale = UIParent:GetEffectiveScale()
            local x, y = GetCursorPosition()
            dragStartX = x / scale
            dragStartY = y / scale
            
            -- Show a visual indicator
            if not self.dragIndicator then
                self.dragIndicator = self:CreateTexture(nil, "OVERLAY")
                self.dragIndicator:SetAllPoints(self)
                self.dragIndicator:SetColorTexture(0.2, 0.8, 0.2, 0.3)
            end
            self.dragIndicator:Show()
            
            -- Switch to dragging update mode
            self:SetScript("OnUpdate", function(self)
                if isDragging then
                    local scale = UIParent:GetEffectiveScale()
                    local x, y = GetCursorPosition()
                    local currentX = x / scale
                    local currentY = y / scale
                    
                    local deltaX = currentX - dragStartX
                    local deltaY = currentY - dragStartY
                    
                    -- Live preview
                    local baseX = (nMainbar.Config.bags and nMainbar.Config.bags.offsetX) or 0
                    local baseY = (nMainbar.Config.bags and nMainbar.Config.bags.offsetY) or 0
                    
                    if MainMenuBarBackpackButton then
                        MainMenuBarBackpackButton:ClearAllPoints()
                        MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", WorldFrame, "BOTTOMRIGHT", 
                            baseX + deltaX, baseY + deltaY)
                    end
                    
                    if CharacterBag0Slot and MainMenuBarBackpackButton then
                        CharacterBag0Slot:ClearAllPoints()
                        CharacterBag0Slot:SetPoint("BOTTOMRIGHT", MainMenuBarBackpackButton, "BOTTOMLEFT", 0, 0)
                    end
                    
                    if CharacterBag1Slot and CharacterBag0Slot then
                        CharacterBag1Slot:ClearAllPoints()
                        CharacterBag1Slot:SetPoint("RIGHT", CharacterBag0Slot, "LEFT", 0, 0)
                    end
                    
                    if CharacterBag2Slot and CharacterBag1Slot then
                        CharacterBag2Slot:ClearAllPoints()
                        CharacterBag2Slot:SetPoint("RIGHT", CharacterBag1Slot, "LEFT", 0, 0)
                    end
                    
                    if CharacterBag3Slot and CharacterBag2Slot then
                        CharacterBag3Slot:ClearAllPoints()
                        CharacterBag3Slot:SetPoint("RIGHT", CharacterBag2Slot, "LEFT", 0, 0)
                    end
                else
                    -- Back to SHIFT detection mode
                    if IsShiftKeyDown() then
                        if not self:IsMouseEnabled() then
                            self:EnableMouse(true)
                        end
                    else
                        if self:IsMouseEnabled() then
                            self:EnableMouse(false)
                        end
                    end
                end
            end)
        end
    end)
    
    dragFrame:SetScript("OnDragStop", function(self)
        if isDragging then
            isDragging = false
            local scale = UIParent:GetEffectiveScale()
            local x, y = GetCursorPosition()
            local endX = x / scale
            local endY = y / scale
            
            local deltaX = endX - dragStartX
            local deltaY = endY - dragStartY
            
            -- Update config
            if not nMainbar.Config.bags then
                nMainbar.Config.bags = {}
            end
            
            nMainbar.Config.bags.offsetX = (nMainbar.Config.bags.offsetX or 0) + deltaX
            nMainbar.Config.bags.offsetY = (nMainbar.Config.bags.offsetY or 0) + deltaY
            
            -- Save config
            if nMainbar.SaveConfig then
                nMainbar.SaveConfig()
            end
            
            -- Update position
            UpdateBagsPosition()
            UpdateDragFrameSize()
            
            -- Hide indicator
            if self.dragIndicator then
                self.dragIndicator:Hide()
            end
            
            -- Re-enable SHIFT detection
            self:SetScript("OnUpdate", function(self)
                if IsShiftKeyDown() then
                    if not self:IsMouseEnabled() then
                        self:EnableMouse(true)
                    end
                else
                    if self:IsMouseEnabled() and not isDragging then
                        self:EnableMouse(false)
                    end
                end
            end)
            
            if cfg.debug then
                print("|cff00FF00nMainbar:|r Bags Position - X:", math.floor(nMainbar.Config.bags.offsetX), "Y:", math.floor(nMainbar.Config.bags.offsetY))
            end
        end
    end)
    
    dragFrame:SetScript("OnEnter", function(self)
        if IsShiftKeyDown() then
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
            GameTooltip:AddLine("|cff00FF00nMainbar Bags|r")
            GameTooltip:AddLine("Shift + Linksklick zum Verschieben", 1, 1, 1)
            GameTooltip:Show()
        end
    end)
    
    dragFrame:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    
    nMainbar.bagsDragFrame = dragFrame
end

-- MicroButtonAndBagsBar structure may not exist in Midnight
if MicroButtonAndBagsBar and MicroButtonAndBagsBar.MicroBagBar then
    MicroButtonAndBagsBar.MicroBagBar:ClearAllPoints()
    MicroButtonAndBagsBar.MicroBagBar:Hide()
end

if CharacterMicroButton then
    CharacterMicroButton:ClearAllPoints()
    CharacterMicroButton:SetPoint("BOTTOMLEFT", UIParent, 9000, 9000)
end

if MoveMicroButtons then
    hooksecurefunc("MoveMicroButtons", function(anchor, achorTo, relAnchor, x, y, isStacked)
        if not isStacked and CharacterMicroButton then
            CharacterMicroButton:ClearAllPoints()
            CharacterMicroButton:SetPoint("BOTTOMLEFT", UIParent, 9000, 9000)
        end
    end)
end

-- Show Bags
local function BagShow()
    if MainMenuBarBackpackButton then MainMenuBarBackpackButton:Show() end
    if CharacterBag0Slot then CharacterBag0Slot:Show() end
    if CharacterBag1Slot then CharacterBag1Slot:Show() end
    if CharacterBag2Slot then CharacterBag2Slot:Show() end
    if CharacterBag3Slot then CharacterBag3Slot:Show() end
end

-- Hide Bags
local function BagHide()
    if MainMenuBarBackpackButton then MainMenuBarBackpackButton:Hide() end
    if CharacterBag0Slot then CharacterBag0Slot:Hide() end
    if CharacterBag1Slot then CharacterBag1Slot:Hide() end
    if CharacterBag2Slot then CharacterBag2Slot:Hide() end
    if CharacterBag3Slot then CharacterBag3Slot:Hide() end
end

-- Used to toggle bag with keybind or slash command /neavbag.
local function ToggleBags()
    if not BagsShown then
        BagShow()
        BagsShown = true
    else
        BagHide()
        BagsShown = false
    end
end

-- Hides or shows bags on start up depending on saved variable.
local function onEvent(self, event, ...)
    local name = ...
    if name == "nMainbar" then
        -- Update position from saved config first
        UpdateBagsPosition()
        
        -- Hook bag positioning to prevent WoW from resetting positions
        if MainMenuBarBackpackButton and not MainMenuBarBackpackButton.nMainbarHooked then
            hooksecurefunc(MainMenuBarBackpackButton, "ClearAllPoints", function(self)
                if not isDragging then
                    C_Timer.After(0, UpdateBagsPosition)
                end
            end)
            MainMenuBarBackpackButton.nMainbarHooked = true
        end
        
        if BagsShown then
            BagShow()
        else
            BagHide()
        end
        
        -- Enable dragging after addon is loaded
        C_Timer.After(2, function()
            EnableBagsDragging()
        end)
    end
end

local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", onEvent)
addon:RegisterEvent("ADDON_LOADED")

-- Slash Command
SlashCmdList["nBag_Toggle"] = function()
    ToggleBags()
end
SLASH_nBag_Toggle1 = "/neavbag"

-- Make UpdateBagsPosition available globally for GUI
nMainbar.UpdateBagsPosition = UpdateBagsPosition
