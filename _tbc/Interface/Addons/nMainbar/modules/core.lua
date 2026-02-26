local _, nMainbar = ...
local cfg = nMainbar.Config

    -- Functions

function nMainbar:IsTaintable()
    return (InCombatLockdown() or (UnitAffectingCombat("player") or UnitAffectingCombat("pet")))
end

function nMainbar:CreateAnchor(name, width, height, location)
    local anchorFrame = CreateFrame("Frame", name.."_Anchor", UIParent, "BackdropTemplate")
    anchorFrame:SetSize(width, height)
    anchorFrame:SetScale(1)
    anchorFrame:SetPoint(unpack(location))
    anchorFrame:SetFrameStrata("HIGH")
    anchorFrame:SetMovable(true)
    anchorFrame:SetClampedToScreen(true)
    anchorFrame:SetUserPlaced(true)
    anchorFrame:SetBackdrop({bgFile="Interface\\MINIMAP\\TooltipBackdrop-Background",})
    anchorFrame:EnableMouse(true)
    anchorFrame:RegisterForDrag("LeftButton")
    anchorFrame:Hide()

    anchorFrame.text = anchorFrame:CreateFontString(nil, "OVERLAY")
    anchorFrame.text:SetAllPoints(anchorFrame)
    anchorFrame.text:SetFont(STANDARD_TEXT_FONT, 13)
    anchorFrame.text:SetText(name)

    anchorFrame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)

    anchorFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    return anchorFrame
end

-- End Caps - Updated for modern API

if cfg.MainMenuBar.hideGryphons then
    -- Modern WoW uses different frame structure
    if MainMenuBar and MainMenuBar.EndCaps then
        if MainMenuBar.EndCaps.LeftEndCap then
            MainMenuBar.EndCaps.LeftEndCap:SetAlpha(0)
        end
        if MainMenuBar.EndCaps.RightEndCap then
            MainMenuBar.EndCaps.RightEndCap:SetAlpha(0)
        end
    end
end

-- Fill Status Bar Gap - Updated for modern API
-- DISABLED: This creates the unwanted lines/strokes left and right of the action bar
-- We hide this texture to remove those visual artifacts

local MainMenuBarArtFrame_BottomArt = nil
if not MainMenuBarArtFrame_BottomArt then
    local parentFrame = MainMenuBar or UIParent
    MainMenuBarArtFrame_BottomArt = parentFrame:CreateTexture("MainMenuBarBottomArt", "OVERLAY")
    MainMenuBarArtFrame_BottomArt:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 0)
    MainMenuBarArtFrame_BottomArt:SetColorTexture(0.40, 0.40, 0.40, 1.0)
    MainMenuBarArtFrame_BottomArt:SetSize(1024, 1)
    -- Hide this texture to remove the unwanted strokes/lines
    MainMenuBarArtFrame_BottomArt:Hide()
end

--  Update Action Bars - Updated for Midnight

if OverrideActionBar then
    OverrideActionBar:SetScale(cfg.vehicleBar.scale)
end

if MultiActionBar_Update then
	hooksecurefunc("MultiActionBar_Update", function(self)
		if nMainbar:IsTaintable() then
			return
		end

		-- Right Bars Scale & Alpha
		if MultiBarLeft then
			MultiBarLeft:SetAlpha(cfg.multiBarRight.alpha)
			MultiBarLeft:SetScale(cfg.multiBarRight.scale)
		end
		
		if MultiBarRight then
			MultiBarRight:SetAlpha(cfg.multiBarRight.alpha)
			MultiBarRight:SetScale(cfg.multiBarRight.scale)
		end

		-- Move Right Bars (Checks if player is using stacking right bar option.)
		if VerticalMultiBarsContainer and GetCVar then
			local layout = GetCVar("multiBarRightVerticalLayout")
			if layout == "0" then
				VerticalMultiBarsContainer:ClearAllPoints()
				VerticalMultiBarsContainer:SetPoint("TOPRIGHT", UIParent, "RIGHT", -2, (VerticalMultiBarsContainer:GetHeight() / 2))
			end
		end
	end)
end

-- Extra Action Button - Updated for Midnight

local ExtraActionBarFrameLocation = {"CENTER", UIParent, "CENTER", -300, -150}
local ExtraActionButton = ExtraActionButton1 or ExtraAbilityContainer
local ExtraActionBarFrameAnchor

if ExtraActionButton then
    ExtraActionBarFrameAnchor = nMainbar:CreateAnchor("EAB", ExtraActionButton:GetWidth(), ExtraActionButton:GetHeight(), ExtraActionBarFrameLocation)

    SlashCmdList["nMainbar_MoveExtraActionBar"] = function()
        if InCombatLockdown() then
            print("|cffCC3333n|rMainbar: "..ERR_NOT_IN_COMBAT)
            return
        end
        if not ExtraActionBarFrameAnchor:IsShown() then
            ExtraActionBarFrameAnchor:Show()
        else
            ExtraActionBarFrameAnchor:Hide()
        end
    end
    SLASH_nMainbar_MoveExtraActionBar1 = "/moveextraactionbar"

    ExtraActionButton:ClearAllPoints()
    ExtraActionButton:SetPoint("CENTER", ExtraActionBarFrameAnchor)
end

-- Possess Bar - Updated for Midnight

if PossessBarFrame then
    PossessBarFrame:SetScale(cfg.possessBar.scale)
    PossessBarFrame:SetAlpha(cfg.possessBar.alpha)
end

-- Stance Bar - Updated for Midnight

if StanceBar then
    -- Hide old textures if they exist
    if StanceBarLeft then StanceBarLeft:SetTexture(nil) end
    if StanceBarMiddle then StanceBarMiddle:SetTexture(nil) end
    if StanceBarRight then StanceBarRight:SetTexture(nil) end

    if StanceBarFrame then
        StanceBarFrame:SetFrameStrata("MEDIUM")
        StanceBarFrame:SetScale(cfg.stanceBar.scale)
        StanceBarFrame:SetAlpha(cfg.stanceBar.alpha)
        
        -- Ensure all stance buttons are properly anchored to the frame
        if StanceBarFrame.StanceButtons then
            for i, button in ipairs(StanceBarFrame.StanceButtons) do
                if button and button.ClearAllPoints then
                    button:ClearAllPoints()
                    if i == 1 then
                        -- First button anchors to the frame
                        button:SetPoint("BOTTOMLEFT", StanceBarFrame, "BOTTOMLEFT", 0, 0)
                    else
                        -- Other buttons anchor to previous button
                        button:SetPoint("LEFT", StanceBarFrame.StanceButtons[i-1], "RIGHT", 6, 0)
                    end
                end
            end
        end

        if cfg.stanceBar.hide then
            if StanceBar_Update then
                hooksecurefunc("StanceBar_Update", function()
                    if StanceBarFrame:IsShown() and not nMainbar:IsTaintable() then
                        RegisterStateDriver(StanceBarFrame, "visibility", "hide")
                    end
                end)
            end
        end
    end
end

-- Pet Bar - Updated for Midnight

if PetActionBarFrame then
    -- Hide old textures if they exist
    if SlidingActionBarTexture0 then SlidingActionBarTexture0:SetTexture(nil) end
    if SlidingActionBarTexture1 then SlidingActionBarTexture1:SetTexture(nil) end
    
    PetActionBarFrame:SetFrameStrata("MEDIUM")
    PetActionBarFrame:SetScale(cfg.petBar.scale)
    PetActionBarFrame:SetAlpha(cfg.petBar.alpha)

    if cfg.petBar.vertical then
        for i = 2, 10 do
            local button = _G["PetActionButton"..i]
            if button then
                button:ClearAllPoints()
                button:SetPoint("TOP", _G["PetActionButton"..(i - 1)], "BOTTOM", 0, -8)
            end
        end
    end
end

if PetActionButton_SetHotkeys then
	hooksecurefunc("PetActionButton_SetHotkeys", function(self)
		local hotkey = _G[self:GetName().."HotKey"]
		if hotkey and not cfg.button.showKeybinds then
			hotkey:Hide()
		end
	end)
end

if not cfg.button.showKeybinds then
    for i = 1, NUM_PET_ACTION_SLOTS, 1 do
        local buttonName = _G["PetActionButton"..i]
        if buttonName and PetActionButton_SetHotkeys then
            PetActionButton_SetHotkeys(buttonName)
        end
    end
end

    -- Move exit vehicle button - Updated for Midnight

if MainMenuBarVehicleLeaveButton_Update then
	hooksecurefunc("MainMenuBarVehicleLeaveButton_Update", function()
		if MainMenuBarVehicleLeaveButton then
			MainMenuBarVehicleLeaveButton:ClearAllPoints()
			-- Position relative to MainMenuBar or fallback to UIParent
			local anchorFrame = MainMenuBar or UIParent
			MainMenuBarVehicleLeaveButton:SetPoint("CENTER", anchorFrame, "BOTTOMRIGHT", -30, 100)
		end
	end)
end

    -- First-Run Setup: Enable Action Bar Artwork

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        -- Check if this is first installation
        if not nMainbarSettings then
            nMainbarSettings = { firstRun = false }
            
            -- Enable Action Bar Art (Leistenverzierung)
            if EditModeManagerFrame and EditModeManagerFrame.SetActionBarVisibility then
                C_Timer.After(1, function()
                    -- Try to enable the artwork via Edit Mode settings
                    if Settings and Settings.SetValue then
                        local setting = Settings.GetSetting("PROXY_SHOW_ACTIONBAR_BACKGROUND")
                        if setting then
                            Settings.SetValue("PROXY_SHOW_ACTIONBAR_BACKGROUND", true)
                        end
                    end
                end)
            end
        end
        
        -- Apply combined bags setting
        if cfg.combinedBags ~= nil then
            C_CVar.SetCVar("combinedBags", cfg.combinedBags and "1" or "0")
        end
        
        self:UnregisterEvent("PLAYER_LOGIN")
    end
end)
