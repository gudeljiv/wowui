local addonName, addon = ...

local FlightReady_DebugMode = false

-- Strategy: SECURE OVERLAY BUTTONS
-- Standard Taxi/Gossip buttons are NOT SecureActionButtons, so SetAttribute("type", "macro") does nothing.
-- We must create transparent SecureActionButtons ON TOP of them.

local overlays = {}
local SetupOverlays -- Forward Declaration

local function CreateSecureOverlay(targetButton)
    if not targetButton then return end
    
    local overlay = overlays[targetButton]
    local btnName = targetButton:GetName()

    -- 1. Creation (only if needed)
    if not overlay then
        if not btnName then return end

        -- Create secure button
        overlay = CreateFrame("Button", btnName.."_FlightReadyOverlay", UIParent, "SecureActionButtonTemplate")
        overlays[targetButton] = overlay

        -- High Strata to ensure it catches the click
        overlay:SetFrameStrata("DIALOG") 
        
        -- Setup Macro Logic
        -- Only enable if NOT in debug mode initially
        if not FlightReady_DebugMode then
             overlay:SetAttribute("type", "macro")
        end
        overlay:SetAttribute("macrotext", "/stand\n/dismount\n/cancelform\n/click "..btnName)
        
        -- Register for clicks (AnyUp + AnyDown ensures we catch standard WoW click logic)
        overlay:RegisterForClicks("AnyUp", "AnyDown") 
        
        -- Pass through Tooltip
        overlay:SetScript("OnEnter", function(self) 
            if targetButton:GetScript("OnEnter") then
                 targetButton:GetScript("OnEnter")(targetButton)
            end
        end)
        overlay:SetScript("OnLeave", function(self)
            if targetButton:GetScript("OnLeave") then
                 targetButton:GetScript("OnLeave")(targetButton)
            end
        end)
        
        -- Branding Message on Click (Throttled)
        local lastPrint = 0
        overlay:SetScript("PostClick", function()
            -- Don't print if calibrating
            if FlightReady_DebugMode then return end
            
            local now = GetTime()
            if now - lastPrint < 1 then return end -- Anti-Spam
            lastPrint = now
            
            -- Full Localization Table
            local L = {
                ["deDE"] = "Startfreigabe erteilt.",
                ["enUS"] = "Cleared for takeoff.",
                ["frFR"] = "Autorisé au décollage.",
                ["esES"] = "Autorizado para despegar.",
                ["esMX"] = "Autorizado para despegar.",
                ["itIT"] = "Autorizzato al decollo.",
                ["ptBR"] = "Autorizado para decolar.",
                ["ruRU"] = "Взлет разрешен.",
                ["zhCN"] = "准许起飞。",
                ["zhTW"] = "准許起飛。",
                ["koKR"] = "이륙 허가됨.",
            }
            
            local loc = GetLocale()
            local msg = L[loc] or L["enUS"]
            
            print("|cFF00FF00FlightReady|r: " .. msg)
        end)
    end
    
    -- 2. Positioning Logic (ABSOLUTE / UIParent)
    -- This fixes issues with parent frames having complex offsets or insets.
    -- We map the screen coordinates of the button directly to UIParent coordinates.
    
    -- Safety check: Button must be on screen
    if targetButton:IsVisible() then
        -- Parent to UIParent explicitly (to ensure high strata/visibility)
        overlay:SetParent(UIParent)
        overlay:SetFrameStrata("TOOLTIP") 
        
        -- Get Dimensions for sizing (still needed)
        local bW, bH = targetButton:GetSize()
        local uiScale = UIParent:GetEffectiveScale()
        
        -- SIZE FIX: Enforce minimum 32x32, or scaled button size
        -- Note: We want the size in 'UIParent' pixels. 
        -- If button is 10px scaled 0.9 -> 9px on screen.
        -- We want 32px on screen -> 32/0.9 size.
        -- OFFSETS
        local mode = FlightReadyDB.uiMode or "STANDARD"
        local profile = FlightReadyDB.profiles[mode]
        
        -- Fallback if profile missing (shouldn't happen)
        if not profile then profile = { offsetX=0, offsetY=0, scale=1.0, individual={} } end

        local globalX = profile.offsetX or 0
        local globalY = profile.offsetY or 0
        local w = math.max(16, (bW / uiScale) * (profile.scale or 1.0))
        local h = math.max(16, (bH / uiScale) * (profile.scale or 1.0))
        
        overlay:SetWidth(w)
        overlay:SetHeight(h)

        local indX, indY = 0, 0
        if profile.individual and profile.individual[targetButton:GetName()] then
           indX = profile.individual[targetButton:GetName()].x or 0
           indY = profile.individual[targetButton:GetName()].y or 0
        end
        
        -- ANCHOR: Absolute Positioning (Center Math)
        
        local spread = profile.spread or 1.0
        
        -- ANCHOR: Map-Relative Positioning (Unified)
        -- This is the most robust method for MoveAny compatibility.
        -- We ignore the actual TaxiButton screen position and calculate
        -- where it SHOULD be on the map surface.
        
        if TaxiRouteMap then
             -- MANUAL MAP ANCHORING
             local tx, ty = TaxiNodePosition(targetButton:GetID()) -- 0.0-1.0 coords
             local mapW, mapH = 316, 352 -- Standard dimensions constant
             
             -- Apply Spread to dimensions
             local effW = mapW * spread
             local effH = mapH * spread
             
             -- Calculate Offset from Map TopLeft
             local finalX = (tx * effW) + globalX + indX
             local finalY = (ty * effH) + globalY + indY
             
             -- Anchor to Map Frame (TopLeft)
             -- Use NEGATIVE Y because we go DOWN from TopLeft
             -- Note: globalY (Offset) is Positive for UP.
             -- Base Y is (ty * effH) downwards (Negative).
             -- So we want (-Base Y) + globalY.
             
             overlay:ClearAllPoints()
             overlay:SetPoint("CENTER", TaxiRouteMap, "TOPLEFT", finalX, -(ty * effH) + globalY + indY)
        else
            -- Fallback (Should rarely happen)
            overlay:Hide()
        end
        
        -- DEBUG: RED OVERLAY
        if not overlay.debugTex then
            overlay.debugTex = overlay:CreateTexture(nil, "OVERLAY")
            overlay.debugTex:SetAllPoints()
            overlay.debugTex:SetColorTexture(1, 0, 0, 0.5) -- Red, 50% opacity
        end
        
        if FlightReady_DebugMode then
            overlay.debugTex:Show()
            overlay:SetMovable(true)
            overlay:EnableMouse(true)
            overlay:RegisterForDrag("LeftButton")
            
            overlay:SetScript("OnDragStart", function(self)
                self:StartMoving()
            end)
            
            overlay:SetScript("OnDragStop", function(self)
                self:StopMovingOrSizing()
                
                -- SIMPLIFIED DRAG MATH (Center Delta)
                -- Current Center (UI Scale)
                local oX, oY = self:GetCenter()
                -- Target Center (Screen Scale -> UI Scale)
                local tC_X, tC_Y = targetButton:GetCenter()
                local s = UIParent:GetEffectiveScale()
                
                if oX and tC_X and s then
                    -- Convert Target to UI Scale
                    local tUI_X = tC_X / s
                    local tUI_Y = tC_Y / s
                    
                    -- Diff
                    local diffX = oX - tUI_X
                    local diffY = oY - tUI_Y
                    
                    -- Individual = TotalDiff - Global
                    -- We need access to current profile stats here
                    local mode = FlightReadyDB.uiMode or "STANDARD"
                    local profile = FlightReadyDB.profiles[mode]
                    
                    local iX = diffX - (profile.offsetX or 0)
                    local iY = diffY - (profile.offsetY or 0)
                    
                    -- Save
                    profile.individual = profile.individual or {}
                    profile.individual[targetButton:GetName()] = { x = iX, y = iY }
                    
                    print(string.format("FlightReady: Saved %s (%.1f, %.1f)", targetButton:GetName(), iX, iY))
                end
            end)
        else
            overlay.debugTex:Hide()
            overlay:SetMovable(false)
            overlay:SetScript("OnDragStart", nil)
            overlay:SetScript("OnDragStop", nil)
        end
        
        overlay:Show()
    else
        overlay:Hide() 
    end 
end

-- 1. Scan Logic
SetupOverlays = function()
    if InCombatLockdown() then return end

    -- Taxi Buttons
    for i = 1, 64 do
        local btn = _G["TaxiButton"..i]
        if btn and btn:IsVisible() then 
            CreateSecureOverlay(btn) 
        end
    end
    
    -- Gossip Title Buttons (Classic/TBC)
    for i = 1, 32 do
        local btn = _G["GossipTitleButton"..i]
        if btn and btn:IsVisible() then
            CreateSecureOverlay(btn)
        end
    end
end

local function HideOverlays()
    for btn, overlay in pairs(overlays) do
        overlay:Hide()
    end
    if calibFrame and calibFrame:IsShown() then
        calibFrame:Hide()
        SetDebugState(false)
        print("|cFF00FF00FlightReady|r: Edit mode closed (Map closed).")
    end
end

-- 2. Event Handler
local function OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...
        if name == addonName then
            FlightReadyDB = FlightReadyDB or { offsetX = 0, offsetY = 0, individual = {} }
            if not FlightReadyDB.individual then FlightReadyDB.individual = {} end

            -- Initialize Mode if nil (Will be refined in PLAYER_LOGIN)
            if not FlightReadyDB.uiMode then FlightReadyDB.uiMode = "STANDARD" end

            -- DATA STRUCTURE MIGRATION: v1 -> v2 (Profiles)
            if not FlightReadyDB.profiles then
                -- Create profiles structure
                FlightReadyDB.profiles = {
                    STANDARD = { offsetX = 0, offsetY = 0, scale = 1.0, spread = 1.0, individual = {} },
                    LEATRIX  = { offsetX = 0, offsetY = 0, scale = 2.0, spread = 1.9, individual = {} },
                    CUSTOM   = { offsetX = 0, offsetY = 0, scale = 1.0, spread = 1.0, individual = {} }
                }
                
                -- If we had previous data, migrate it to the detected mode
                -- Note: Only applies during initial migration
                if FlightReadyDB.hasInitialized and FlightReadyDB.offsetX then
                    -- Assume previous data was for the current active mode
                    -- If we haven't detected yet, we might migrate to nil.
                    -- Safer to init standard first.
                    local target = FlightReadyDB.uiMode or "STANDARD"
                    FlightReadyDB.profiles[target] = {
                        offsetX = FlightReadyDB.offsetX,
                        offsetY = FlightReadyDB.offsetY,
                        scale = FlightReadyDB.scale or 1.0,
                        individual = FlightReadyDB.individual or {}
                    }
                end
            end
                
            if not FlightReadyDB.profiles[FlightReadyDB.uiMode].spread then
                FlightReadyDB.profiles[FlightReadyDB.uiMode].spread = 1.0
            end
            
            -- DEBUG: Confirm Load
            -- print(string.format("FlightReady: Loaded. Mode: [%s]. Offset: %.1f, %.1f", FlightReadyDB.uiMode, FlightReadyDB.offsetX or 0, FlightReadyDB.offsetY or 0))
            
            -- POSITION WATCHER (For Movable Maps)
            -- Tracks TaxiButton1 movement and forces update.
            local watcher = CreateFrame("Frame")
            local lastX, lastY = 0, 0
            watcher:SetScript("OnUpdate", function(self, elapsed)
                -- Running every frame ensures smooth dragging with MoveAny
                local btn = TaxiButton1
                if btn and btn:IsVisible() then
                    local cX, cY = btn:GetCenter()
                    if cX and cY and (cX ~= lastX or cY ~= lastY) then
                        lastX, lastY = cX, cY
                        SetupOverlays() -- Force Update Position
                    end
                end
            end)
        end
    elseif event == "TAXIMAP_OPENED" or event == "GOSSIP_SHOW" then
        -- Multi-Stage Init: Try multiple times to catch late-load addons (like Leatrix after reload)
        C_Timer.After(0.1, SetupOverlays)
        C_Timer.After(0.5, SetupOverlays)
        C_Timer.After(1.0, SetupOverlays)
    elseif event == "PLAYER_LOGIN" then
        -- Advanced Detection (Leatrix Plus Settings)
        -- Only override mode if we haven't manually selected CUSTOM, 
        -- or if we are just starting up and want smart detection.
        -- Let's stick to: If user hasn't explicitly set a mode yet (or we want to be smart).
        
        -- Check Leatrix Plus DB for "EnhanceFlightMap"
        local leatrixOn = false
        if _G.LeaPlusDB and _G.LeaPlusDB["EnhanceFlightMap"] == "On" then
            leatrixOn = true
        end

        -- Auto-Switch logic:
        -- If we are currently in STANDARD but Leatrix is ON -> Switch to LEATRIX.
        -- If we are currently in LEATRIX but Leatrix is OFF -> Switch to STANDARD.
        -- If we are in CUSTOM, leave it alone.
        
        if FlightReadyDB.uiMode == "STANDARD" and leatrixOn then
            FlightReadyDB.uiMode = "LEATRIX"
            -- print("FlightReady: Auto-detected Leatrix Maps (Mode: LEATRIX)")
        elseif FlightReadyDB.uiMode == "LEATRIX" and not leatrixOn then
            FlightReadyDB.uiMode = "STANDARD"
            -- print("FlightReady: Leatrix Maps not active (Mode: STANDARD)")
        end
        

    elseif event == "TAXIMAP_CLOSED" then
        HideOverlays()
    elseif event == "UI_ERROR_MESSAGE" then
        local arg1, arg2 = ...
        if arg2 == ERR_TAXIPLAYERSHAPESHIFTED then
            -- Fallback: If overlay failed or was missed, try chat command.
            if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.editBox then
                 DEFAULT_CHAT_FRAME.editBox:SetText("/cancelform")
                 pcall(ChatEdit_SendText, DEFAULT_CHAT_FRAME.editBox, 0)
            end
        end
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("TAXIMAP_OPENED")
f:RegisterEvent("TAXIMAP_CLOSED")
f:RegisterEvent("GOSSIP_SHOW")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", OnEvent)

-- 3. Config / Calibration Logic
local function GetOffsets()
    local mode = FlightReadyDB.uiMode or "STANDARD"
    local p = FlightReadyDB.profiles[mode]
    return p.offsetX or 0, p.offsetY or 0
end

local function SetOffsets(x, y)
    local mode = FlightReadyDB.uiMode or "STANDARD"
    if not FlightReadyDB.profiles[mode] then FlightReadyDB.profiles[mode] = {} end
    FlightReadyDB.profiles[mode].offsetX = x
    FlightReadyDB.profiles[mode].offsetY = y
    SetupOverlays() -- Refresh positions immediately
end

-- Helper to Toggle Macro State
local function SetDebugState(enable)
    FlightReady_DebugMode = enable
    
    for btn, overlay in pairs(overlays) do
        if enable then
            -- Disable Macro, Enable Drag
            overlay:SetAttribute("type", nil) 
        else
             -- Enable Macro, Disable Drag
             overlay:SetAttribute("type", "macro")
        end
    end
    
    SetupOverlays() -- Refresh visual state/drag handlers
end

-- Calibration Locales
-- Calibration Locales
local CALIB_LOCALE = {
    ["enUS"] = { title="FlightReady Adjust", move="Move", profile="Profile", size="Size", spread="Spread", reset="Reset", done="Done", step="Step", up="UP", down="DOWN", left="LEFT", right="RIGHT", help="Buttons = Move ALL\nDrag Box = Move ONE", custom="Custom" },
    ["deDE"] = { title="FlightReady Anpassen", move="Bewegen", profile="Profil", size="Größe", spread="Abstand", reset="Zurücksetzen", done="Fertig", step="Schritt", up="HOCH", down="RUNTER", left="LINKS", right="RECHTS", help="Tasten = Alle bewegen\nZiehen = Eines bewegen", custom="Benutzerdef." },
    ["frFR"] = { title="Ajuster FlightReady", move="Déménagement", profile="Profil", size="Taille", spread="Ecart", reset="RàZ", done="Prêt", step="Pas", up="HAUT", down="BAS", left="GAUCHE", right="DROITE", help="Boutons = Tout bouger\nGlisser = Bouger un seul", custom="Personnalisé" },
    ["esES"] = { title="Ajustar FlightReady", move="Mover", profile="Perfil", size="Tamaño", spread="Propagar", reset="Restab", done="Hecho", step="Paso", up="ARR", down="ABA", left="IZQ", right="DER", help="Botones = Mover todo\nArrastrar = Mover uno", custom="Personaliz." },
    ["esMX"] = { title="Ajustar FlightReady", move="Mover", profile="Perfil", size="Tamaño", spread="Propagar", reset="Restab", done="Hecho", step="Paso", up="ARR", down="ABA", left="IZQ", right="DER", help="Botones = Mover todo\nArrastrar = Mover uno", custom="Personaliz." },
    ["itIT"] = { title="Regola FlightReady", move="Mossa", profile="Profilo", size="Dimens.", spread="Diffus.", reset="Reimposta", done="Fatto", step="Passo", up="SU", down="GIÙ", left="SIN", right="DES", help="Pulsanti = Muovi tutto\nTrascina = Muovi uno", custom="Personaliz." },
    ["ptBR"] = { title="Ajustar FlightReady", move="Mover", profile="Perfil", size="Tam.", spread="Espalhar", reset="Redefinir", done="Pronto", step="Passo", up="CIMA", down="BAIXO", left="ESQ", right="DIR", help="Botões = Mover tudo\nArrastar = Mover um", custom="Personaliz." },
    ["ruRU"] = { title="Настройка FlightReady", move="Двигаться", profile="Профиль", size="Размер", spread="Спред", reset="Сброс", done="Готово", step="Шаг", up="ВВЕРХ", down="ВНИЗ", left="ВЛЕВО", right="ВПРАВО", help="Кнопки = Двигать все\nПеретащить = Двигать один", custom="Пользоват." },
    ["zhCN"] = { title="FlightReady 调整", move="移动", profile="配置", size="尺寸", spread="扩散", reset="重置", done="完成", step="步长", up="上", down="下", left="左", right="右", help="按钮 = 移动全部\n拖拽 = 移动单个", custom="自定义" },
    ["zhTW"] = { title="FlightReady 調整", move="移動", profile="配置", size="尺寸", spread="擴散", reset="重置", done="完成", step="步長", up="上", down="下", left="左", right="右", help="按鈕 = 移動全部\n拖拽 = 移動單個", custom="自定義" },
    ["koKR"] = { title="FlightReady 조정", move="이동", profile="프로필", size="크기", spread="간격", reset="초기화", done="완료", step="간격", up="위", down="아래", left="왼쪽", right="오른쪽", help="버튼 = 전체 이동\n드래그 = 개별 이동", custom="사용자" },
}

-- Calibration UI Frame
local calibFrame = nil
local function ShowCalibrationUI()

    if not (TaxiFrame and TaxiFrame:IsVisible()) then
        print("|cFF00FF00FlightReady|r: Please open a Flight Path first!")
        return
    end

    if calibFrame then 
        calibFrame:Show()
        SetDebugState(true)
        return 
    end
    
    local L = CALIB_LOCALE[GetLocale()] or CALIB_LOCALE["enUS"]
    
    -- Main Frame
    calibFrame = CreateFrame("Frame", "FlightReadyCalibrationFrame", UIParent, "BackdropTemplate")
    calibFrame:SetSize(240, 400) -- Increased Height to 400 to fix overlap
    calibFrame:SetPoint("CENTER")
    calibFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    calibFrame:EnableMouse(true)
    calibFrame:SetMovable(true)
    calibFrame:SetClampedToScreen(true)
    calibFrame:RegisterForDrag("LeftButton")
    calibFrame:SetScript("OnDragStart", calibFrame.StartMoving)
    calibFrame:SetScript("OnDragStop", calibFrame.StopMovingOrSizing)
    
    calibFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    
    -- Title
    local title = calibFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", 0, -15)
    title:SetText(L.title)
    
    -- Step Logic Removed (Moved to MoveGroup)
    
    -- Step Buttons [1] [5] [10]
    -- PROFILE TOGGLE
    local profBtn = CreateFrame("Button", nil, calibFrame, "GameMenuButtonTemplate")
    profBtn:SetSize(140, 20)
    profBtn:SetPoint("TOP", 0, -40)
    
    local function UpdateProfileBtn()
        local displayMode = FlightReadyDB.uiMode
        if displayMode == "CUSTOM" then displayMode = (L.custom or "CUSTOM") end
        profBtn:SetText(L.profile..": "..displayMode)
    end
    UpdateProfileBtn()
    
    -- Forward declare size update
    local UpdateScaleUI
    
    profBtn:SetScript("OnClick", function()
        -- Toggle Mode only
        -- Cycle Mode: STANDARD -> LEATRIX -> CUSTOM -> STANDARD
        local mode = FlightReadyDB.uiMode
        if mode == "STANDARD" then
            FlightReadyDB.uiMode = "LEATRIX"
        elseif mode == "LEATRIX" then
            FlightReadyDB.uiMode = "CUSTOM"
        else
            FlightReadyDB.uiMode = "STANDARD"
        end
        
        UpdateProfileBtn()
        if UpdateScaleUI then UpdateScaleUI() end -- Refresh Scale Label
        SetupOverlays() -- Refresh Positions (will read new profile)
    end)

    -- Size Logic
    local currentScale = 1.0
    local sizeLabel = calibFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    sizeLabel:SetPoint("TOP", 0, -65)
    
    UpdateScaleUI = function()
        local mode = FlightReadyDB.uiMode or "STANDARD"
        local p = FlightReadyDB.profiles[mode] or {scale=1.0} -- Safe fallback
        currentScale = p.scale or 1.0
        local currentSpread = p.spread or 1.0
        
        sizeLabel:SetText(L.size..": " .. string.format("%.1f", currentScale))
        
        if not spreadLabel then
             spreadLabel = calibFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
             spreadLabel:SetPoint("TOP", 0, -115) -- Below Size
        end
        spreadLabel:SetText(L.spread..": " .. string.format("%.1f", currentSpread))
    end
    UpdateScaleUI()
    
    local function UpdateScale(delta)
        currentScale = currentScale + delta
        if currentScale < 0.5 then currentScale = 0.5 end
        if currentScale > 3.0 then currentScale = 3.0 end
        
        local mode = FlightReadyDB.uiMode or "STANDARD"
        if not FlightReadyDB.profiles[mode] then FlightReadyDB.profiles[mode] = {} end
        FlightReadyDB.profiles[mode].scale = currentScale
        
        UpdateScaleUI()
        SetupOverlays()
    end
    
    local function UpdateSpread(delta)
        local mode = FlightReadyDB.uiMode or "STANDARD"
        local p = FlightReadyDB.profiles[mode]
        p.spread = (p.spread or 1.0) + delta
        if p.spread < 0.1 then p.spread = 0.1 end
        if p.spread > 5.0 then p.spread = 5.0 end
        UpdateScaleUI()
        SetupOverlays()
    end
    
    local btnMinus = CreateFrame("Button", nil, calibFrame, "GameMenuButtonTemplate")
    btnMinus:SetSize(30, 20)
    btnMinus:SetPoint("TOP", -30, -80)
    btnMinus:SetText("-")
    btnMinus:SetScript("OnClick", function() UpdateScale(-0.1) end)
    
    local btnPlus = CreateFrame("Button", nil, calibFrame, "GameMenuButtonTemplate")
    btnPlus:SetSize(30, 20)
    btnPlus:SetPoint("TOP", 30, -80)
    btnPlus:SetText("+")
    btnPlus:SetScript("OnClick", function() UpdateScale(0.1) end)
    
   local btnSpMinus = CreateFrame("Button", nil, calibFrame, "GameMenuButtonTemplate")
    btnSpMinus:SetSize(30, 20)
    btnSpMinus:SetPoint("TOP", -30, -130)
    btnSpMinus:SetText("-")
    btnSpMinus:SetScript("OnClick", function() UpdateSpread(-0.1) end)
    
    local btnSpPlus = CreateFrame("Button", nil, calibFrame, "GameMenuButtonTemplate")
    btnSpPlus:SetSize(30, 20)
    btnSpPlus:SetPoint("TOP", 30, -130)
    btnSpPlus:SetText("+")
    btnSpPlus:SetScript("OnClick", function() UpdateSpread(0.1) end)

    -- MOVEMENT GROUP (Frame with border)
    -- MOVEMENT GROUP (Frame with border)
    -- MOVEMENT GROUP (Frame with border)
    local moveGroup = CreateFrame("Frame", nil, calibFrame, "BackdropTemplate")
    moveGroup:SetSize(200, 180) -- Increased Height to 180 (room for text)
    moveGroup:SetPoint("BOTTOM", 0, 45)
    moveGroup:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 16,
    })
    
    local moveLabel = moveGroup:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    moveLabel:SetPoint("TOP", 0, -8)
    moveLabel:SetText(L.move)
    
    -- Step Size Logic (Inside Group)
    local stepSize = 1
    local stepLabel = moveGroup:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    stepLabel:SetPoint("TOP", 0, -22)
    stepLabel:SetText(L.step..": "..stepSize.."px")
    
    local function SetStep(val)
        stepSize = val
        stepLabel:SetText(L.step..": "..stepSize.."px")
    end

    -- Step Buttons [1] [5] [10] (Inside Group)
    local function CreateStepBtn(val, x)
        local btn = CreateFrame("Button", nil, moveGroup, "GameMenuButtonTemplate")
        btn:SetSize(40, 20)
        btn:SetPoint("TOP", x, -40) 
        btn:SetText(val)
        btn:SetScript("OnClick", function() SetStep(val) end)
    end
    CreateStepBtn(1, -50)
    CreateStepBtn(5, 0)
    CreateStepBtn(10, 50)

    -- UPDATE FUNCTION (GLOBAL OFFSET)
    local function UpdateGlobalOffset(dx, dy)
        local curX, curY = GetOffsets()
        SetOffsets(curX + (dx * stepSize), curY + (dy * stepSize))
    end
    
    local function CreateDirBtn(text, x, y, dx, dy)
        local btn = CreateFrame("Button", nil, moveGroup, "GameMenuButtonTemplate")
        btn:SetSize(50, 30)
        btn:SetPoint("CENTER", x, y)
        btn:SetText(text)
        btn:SetScript("OnClick", function() UpdateGlobalOffset(dx, dy) end)
        return btn
    end
    
    -- Arrows inside Group 
    -- Group H=180. Center is at 90 from bottom.
    -- Text will be at bottom ~25px.
    -- Arrows need to be higher.
    -- Shift Arrows Up slightly (Y=0 is center).
    CreateDirBtn(L.up, 0, 10, 0, 1)    
    CreateDirBtn(L.down, 0, -30, 0, -1)
    CreateDirBtn(L.left, -60, -10, -1, 0)
    CreateDirBtn(L.right, 60, -10, 1, 0)
    
    
    -- Reset
    local reset = CreateFrame("Button", nil, calibFrame, "GameMenuButtonTemplate")
    reset:SetSize(80, 25)
    reset:SetPoint("BOTTOMLEFT", 15, 15)
    reset:SetText(L.reset)
    reset:SetScript("OnClick", function()
        -- 1. Determine Defaults
        local mode = FlightReadyDB.uiMode or "STANDARD"
        local defX, defY, defScale = 0, 0, 1.0
        
        if mode == "STANDARD" then
            defX, defY, defScale, defSpread = 0, 0, 1.0, 1.0
        elseif mode == "LEATRIX" then
            defX, defY, defScale, defSpread = 0, 0, 2.0, 1.9
        elseif mode == "CUSTOM" then
            defX, defY, defScale, defSpread = 0, 0, 1.0, 1.0
        end
        
        -- 2. Reset Profile Data
        FlightReadyDB.profiles[mode] = {
            offsetX = defX,
            offsetY = defY,
            scale = defScale,
            spread = defSpread,
            individual = {}
        }
        
        -- 3. Update UI
        if UpdateScaleUI then UpdateScaleUI() end
        currentScale = defScale
        
        -- 4. Refresh
        SetupOverlays()
        
        print("FlightReady: Reset current profile ("..mode..") to defaults.")
    end)


    -- Info Text (Moved into MoveGroup, safely at bottom)
    local info = moveGroup:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    info:SetPoint("BOTTOM", 0, 10)
    info:SetText(L.help)
    
    -- Close
    local close = CreateFrame("Button", nil, calibFrame, "GameMenuButtonTemplate")
    close:SetSize(80, 25)
    close:SetPoint("BOTTOMRIGHT", -15, 15)
    close:SetText(L.done)
    close:SetScript("OnClick", function()
        calibFrame:Hide()
        SetDebugState(false)
    end)
    
    calibFrame:Show()
    SetDebugState(true)
end


-- Slash Command
SLASH_FLIGHTREADY1 = "/fr"
SLASH_FLIGHTREADY2 = "/flightready"
SLASH_FLIGHTREADY3 = "/flight" -- Allow /flight too 
SlashCmdList["FLIGHTREADY"] = function(msg)
    if msg == "debug" then
        SetDebugState(not FlightReady_DebugMode)
        print("|cFF00FF00FlightReady|r: Debug Mode " .. (FlightReady_DebugMode and "ENABLED" or "DISABLED"))
    elseif msg == "edit" or msg == "config" or msg == "move" then
        ShowCalibrationUI()
    elseif msg == "values" or msg == "status" then
        local mode = FlightReadyDB.uiMode or "STANDARD"
        local p = FlightReadyDB.profiles[mode]
        local x = p.offsetX or 0
        local y = p.offsetY or 0
        local s = p.scale or 1.0
        local sp = p.spread or 1.0
        print(string.format("|cFF00FF00FlightReady|r [%s]: X=%.1f, Y=%.1f, Scale=%.1f, Spread=%.1f", mode, x, y, s, sp))
    else
        print("|cFF00FF00FlightReady|r commands:")
        print("  |cFFFFD700/fr edit|r   - Open calibration.")
        -- Debug commands hidden but active: /fr debug, /fr values
    end
end

