local _, nMainbar = ...
local cfg = nMainbar.Config

-- MicroMenu Mouseover Module - KORRIGIERTE VERSION
-- Versteckt nur die TEXTURES der Buttons, nicht die Buttons selbst
-- Dadurch bleiben die Buttons klickbar!

local microMenuFrame = nil
local fadeTimer = nil
local isMouseOver = false
local trackedTextures = {}

-- Function to find the MicroMenu frame
local function FindMicroMenu()
    if MicroMenuContainer then
        return MicroMenuContainer
    elseif MicroMenu then
        return MicroMenu
    elseif MicroButtonAndBagsBar then
        return MicroButtonAndBagsBar
    end
    return nil
end

-- Rekursiv alle Textures in einem Frame sammeln
local function CollectTextures(frame, textures)
    textures = textures or {}
    
    if not frame then return textures end
    
    -- Sammle alle Texture Regions
    local regions = {frame:GetRegions()}
    for _, region in ipairs(regions) do
        if region:IsObjectType("Texture") then
            table.insert(textures, region)
        end
    end
    
    -- Sammle Textures von allen Children
    local numChildren = frame:GetNumChildren()
    for i = 1, numChildren do
        local child = select(i, frame:GetChildren())
        if child then
            CollectTextures(child, textures)
        end
    end
    
    return textures
end

-- Setze Alpha für alle Textures (nicht für die Frames!)
local function SetTexturesAlpha(alpha, instant)
    if not microMenuFrame then return end
    
    -- Sammle alle Textures neu (für Addon-Kompatibilität)
    trackedTextures = CollectTextures(microMenuFrame)
    
    if instant then
        for _, texture in ipairs(trackedTextures) do
            if texture and texture:IsShown() then
                texture:SetAlpha(alpha)
            end
        end
    else
        -- Smooth fade für alle Textures
        local currentAlpha = trackedTextures[1] and trackedTextures[1]:GetAlpha() or 1
        local step = (alpha - currentAlpha) / 10
        local count = 0
        
        if fadeTimer then
            fadeTimer:Cancel()
        end
        
        fadeTimer = C_Timer.NewTicker(0.02, function()
            count = count + 1
            local newAlpha = currentAlpha + (step * count)
            
            for _, texture in ipairs(trackedTextures) do
                if texture and texture:IsShown() then
                    if count >= 10 then
                        texture:SetAlpha(alpha)
                    else
                        texture:SetAlpha(newAlpha)
                    end
                end
            end
            
            if count >= 10 and fadeTimer then
                fadeTimer:Cancel()
            end
        end)
    end
end

-- Function to show MicroMenu
local function ShowMicroMenu()
    isMouseOver = true
    SetTexturesAlpha(1, false)
end

-- Function to hide MicroMenu
local function HideMicroMenu()
    if not isMouseOver then
        SetTexturesAlpha(cfg.microMenu.hiddenAlpha, false)
    end
end

-- Setup mouseover detection
local function SetupMouseover()
    microMenuFrame = FindMicroMenu()
    
    if not microMenuFrame then
        C_Timer.After(1, SetupMouseover)
        return
    end
    
    -- Set initial alpha
    if cfg.microMenu.mouseover then
        SetTexturesAlpha(cfg.microMenu.hiddenAlpha, true)
    else
        SetTexturesAlpha(1, true)
    end
    
    -- Hook direkt auf das MicroMenu Frame
    -- Da nur die Textures transparent sind, bleiben die Buttons klickbar
    if not microMenuFrame.nMainbarHooked then
        microMenuFrame:EnableMouse(true)
        
        microMenuFrame:HookScript("OnEnter", function()
            if cfg.microMenu.mouseover then
                isMouseOver = true
                ShowMicroMenu()
            end
        end)
        
        microMenuFrame:HookScript("OnLeave", function()
            if cfg.microMenu.mouseover then
                isMouseOver = false
                C_Timer.After(0.5, HideMicroMenu)
            end
        end)
        
        microMenuFrame.nMainbarHooked = true
    end
    
    -- Periodisch Textures neu sammeln für Addon-Kompatibilität
    C_Timer.NewTicker(5, function()
        if cfg.microMenu.mouseover and not isMouseOver then
            SetTexturesAlpha(cfg.microMenu.hiddenAlpha, true)
        end
    end)
end

-- Function to apply mouseover setting
function nMainbar.ApplyMicroMenuMouseover()
    if not microMenuFrame then
        microMenuFrame = FindMicroMenu()
    end
    
    if not microMenuFrame then return end
    
    if cfg.microMenu.mouseover then
        if not isMouseOver then
            SetTexturesAlpha(cfg.microMenu.hiddenAlpha, true)
        end
    else
        SetTexturesAlpha(1, true)
    end
end

-- Initialize on login
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        C_Timer.After(2, function()
            SetupMouseover()
            nMainbar.ApplyMicroMenuMouseover()
        end)
        self:UnregisterEvent("PLAYER_LOGIN")
    end
end)
