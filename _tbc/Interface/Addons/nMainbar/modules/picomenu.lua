local _, nMainbar = ...
local cfg = nMainbar.Config
local L = nMainbar.L

-- Don't return early - we need to create the picomenu so it can be toggled

-- Modern API compatibility for IsAddOnLoaded
local IsAddOnLoaded = C_AddOns and C_AddOns.IsAddOnLoaded or IsAddOnLoaded

    -- Pico Menu Dropdown

local x, x2, n = nil, false
local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
local BLOCKED_IN_COMBAT = "UI Action Blocked"

local menuFrame = CreateFrame("Frame", "picomenuDropDownMenu", MainMenuBar, "UIDropDownMenuTemplate")

local menuList = {
    {
        text = MAINMENU_BUTTON,
        isTitle = true,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = CHARACTER_BUTTON,
        icon = "Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle",
        func = function()
            if ToggleCharacter then ToggleCharacter("PaperDollFrame") end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = L["Specialization, Talents & Spellbook"],
        icon = "Interface\\AddOns\\nMainbar\\Media\\picomenu\\picomenuTalents",
        func = function()
            -- Modern API for Midnight - Opens full PlayerSpells frame (Spec, Talents, Spellbook)
            if PlayerSpellsUtil and PlayerSpellsUtil.TogglePlayerSpellsFrame then
                PlayerSpellsUtil.TogglePlayerSpellsFrame()
            elseif ToggleTalentFrame then
                ToggleTalentFrame()
            elseif PlayerSpellsFrame then
                PlayerSpellsFrame:ToggleFrame()
            end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = ACHIEVEMENT_BUTTON,
        icon = "Interface\\AddOns\\nMainbar\\Media\\picomenu\\picomenuAchievement",
        func = function()
            if ToggleAchievementFrame then
                ToggleAchievementFrame()
            end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = QUESTLOG_BUTTON,
        icon = "Interface\\GossipFrame\\ActiveQuestIcon",
        func = function()
            if ToggleQuestLog then ToggleQuestLog() end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = COMMUNITIES_FRAME_TITLE,
        icon = "Interface\\GossipFrame\\TabardGossipIcon",
        arg1 = IsInGuild("player"),
        func = function()
            if ToggleGuildFrame then ToggleGuildFrame() end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = SOCIAL_BUTTON,
        icon = "Interface\\FriendsFrame\\PlusManz-BattleNet",
        func = function()
            if ToggleFriendsFrame then ToggleFriendsFrame() end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = PLAYER_V_PLAYER,
        icon = "Interface\\MINIMAP\\TRACKING\\BattleMaster",
        func = function()
            if TogglePVPUI then TogglePVPUI() end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = DUNGEONS_BUTTON,
        icon = "Interface\\LFGFRAME\\BattleNetWorking0",
        func = function()
            if ToggleLFDParentFrame then ToggleLFDParentFrame() end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = CHALLENGES,
        icon = "Interface\\BUTTONS\\UI-GroupLoot-DE-Up",
        func = function()
            PVEFrame_ToggleFrame("ChallengesFrame",nil)
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = RAID,
        icon = "Interface\\TARGETINGFRAME\\UI-TargetingFrame-Skull",
        func = function()
            if ToggleRaidFrame then ToggleRaidFrame() end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = MOUNTS,
        icon = "Interface\\MINIMAP\\TRACKING\\StableMaster",
        func = function()
            if not nMainbar:IsTaintable() then
                ToggleCollectionsJournal(1)
            else
                UIErrorsFrame:AddMessage(BLOCKED_IN_COMBAT, 1, 0, 0)
            end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = PETS,
        icon = "Interface\\MINIMAP\\TRACKING\\StableMaster",
        func = function()
            if not nMainbar:IsTaintable() then
                ToggleCollectionsJournal(2)
            else
                UIErrorsFrame:AddMessage(BLOCKED_IN_COMBAT, 1, 0, 0)
            end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = TOY_BOX,
        icon = "Interface\\MINIMAP\\TRACKING\\Reagents",
        func = function()
            if not nMainbar:IsTaintable() then
                ToggleCollectionsJournal(3)
            else
                UIErrorsFrame:AddMessage(BLOCKED_IN_COMBAT, 1, 0, 0)
            end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = HEIRLOOMS,
        icon = "Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle",
        func = function()
            if not nMainbar:IsTaintable() then
                ToggleCollectionsJournal(4)
            else
                UIErrorsFrame:AddMessage(BLOCKED_IN_COMBAT, 1, 0, 0)
            end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = WARDROBE,
        icon = "Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle",
        func = function()
            if not nMainbar:IsTaintable() then
                ToggleCollectionsJournal(5)
            else
                UIErrorsFrame:AddMessage(BLOCKED_IN_COMBAT, 1, 0, 0)
            end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = "Housing Dashboard",
        icon = "Interface\\ICONS\\inv_misc_kingsring1",
        func = function()
            -- Toggle Housing Dashboard (War Within feature)
            if C_PlayerInfo and C_PlayerInfo.ToggleHousingDashboard then
                C_PlayerInfo.ToggleHousingDashboard()
            elseif ToggleWarboardUI then
                ToggleWarboardUI()
            elseif ShowUIPanel and PlayerChoiceFrame then
                -- Fallback attempt
                if not PlayerChoiceFrame:IsShown() then
                    ShowUIPanel(PlayerChoiceFrame)
                else
                    HideUIPanel(PlayerChoiceFrame)
                end
            else
                -- If none work, try to find and click the microbutton
                if HousingMicroButton and HousingMicroButton:IsVisible() then
                    HousingMicroButton:Click()
                elseif _G["HousingMicroButton"] then
                    _G["HousingMicroButton"]:Click()
                else
                    print("|cffCC3333nMainbar|r: Housing Dashboard nicht verfügbar / Housing Dashboard not available")
                end
            end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = ENCOUNTER_JOURNAL,
        icon = "Interface\\MINIMAP\\TRACKING\\Profession",
        func = function()
            ToggleEncounterJournal()
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = GM_EMAIL_NAME,
        icon = "Interface\\CHATFRAME\\UI-ChatIcon-Blizz",
        func = function()
            if ToggleHelpFrame then ToggleHelpFrame() end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {
        text = BATTLEFIELD_MINIMAP,
        colorCode = "|cff999999",
        icon = "Interface\\MINIMAP\\TRACKING\\Battlemaster",
        disabled = not (ToggleBattlefieldMap and BattlefieldMapFrame),
        func = function()
            if ToggleBattlefieldMap then
                ToggleBattlefieldMap()
            end
        end,
        notCheckable = true,
        fontObject = Game13Font,
    },
}

local addonMenuTable = {
    {
        text = "                               ",
        isTitle = true,
        notCheckable = true,
        fontObject = Game13Font,
    },
    {   text = ADDONS,
        hasArrow = true,
        notCheckable = true,
        fontObject = Game13Font,
        menuList = {
            {
                text = ADDONS,
                isTitle = true,
                notCheckable = true,
                fontObject = Game13Font,
            },
        }
    }
}

local function UpdateAddOnTable()
    if IsAddOnLoaded("oUF_NeavRaid") and not v1 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v1 = true
        addonMenuTable[2].menuList[n] = {
            text = "NeavRaid",
            func = function()
                SlashCmdList["oUF_Neav_Raid_AnchorToggle"]("toggle")
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("VuhDo") and not v2 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v2 = true
        addonMenuTable[2].menuList[n] = {
            text = "VuhDo",
            func = function()
                SlashCmdList["VUHDO"]("toggle")
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if (IsAddOnLoaded("Grid") or IsAddOnLoaded("Grid2")) and not v3 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v3 = true
        addonMenuTable[2].menuList[n] = {
            text = "Grid",
            func = function()
                if IsAddOnLoaded("Grid2") then
                    ToggleFrame(Grid2LayoutFrame)
                elseif IsAddOnLoaded("Grid") then
                    ToggleFrame(GridLayoutFrame)
                end
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("Omen") and not v4 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v4 = true
        addonMenuTable[2].menuList[n] = {
            text = "Omen",
            func = function()
                if IsShiftKeyDown() then
                    Omen:Toggle()
                else
                    Omen:ShowConfig()
                end
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("PhoenixStyle") and not v5 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v5 = true
        addonMenuTable[2].menuList[n] = {
            text = "PhoenixStyle",
            func = function()
                ToggleFrame(PSFmain1)
                ToggleFrame(PSFmain2)
                ToggleFrame(PSFmain3)
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("DBM-Core") and not v6 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v6 = true
        addonMenuTable[2].menuList[n] = {
            text = "DBM",
            func = function()
                DBM:LoadGUI()
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("Skada") and not v7 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v7 = true
        addonMenuTable[2].menuList[n] = {
            text = "Skada",
            func = function()
                Skada:ToggleWindow()
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("Recount") and not v8 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v8 = true
        addonMenuTable[2].menuList[n] = {
            text = "Recount",
            func = function()
                ToggleFrame(Recount.MainWindow)
                if Recount.MainWindow:IsShown() then
                    Recount:RefreshMainWindow()
                end
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("TinyDPS") and not v9 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v9 = true
        addonMenuTable[2].menuList[n] = {
            text = "TinyDPS",
            func = function()
                ToggleFrame(tdpsFrame)
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("Numeration") and not v10 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v10 = true
        addonMenuTable[2].menuList[n] = {
            text = "Numeration",
            func = function()
                if not IsShiftKeyDown() then
                    Numeration:ToggleVisibility()
                else
                    StaticPopup_Show("RESET_DATA")
                end
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("AtlasLoot") and not v11 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v11 = true
        addonMenuTable[2].menuList[n] = {
            text = "AtlasLoot",
            func = function()
                AtlasLoot.GUI:Toggle()
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("Altoholic") and not v12 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v12 = true
        addonMenuTable[2].menuList[n] = {
            text = "Altoholic",
            func = function()
                ToggleFrame(AltoholicFrame)
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("Details") and not v13 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v13 = true
        addonMenuTable[2].menuList[n] = {
            text = "Details",
            func = function()
                if not IsShiftKeyDown() then
                    _detalhes:ToggleWindow(1)
                    _detalhes:ToggleWindow(2)
                else
                    _detalhes.tabela_historico:resetar()
                end
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if IsAddOnLoaded("BigWigs") and not v14 then
        x = true
        n = (#addonMenuTable[2].menuList)+1
        v14 = true
        addonMenuTable[2].menuList[n] = {
            text = "BigWigs",
            func = function()
                if BigWigsOptions then
                    BigWigsOptions:Open()
                else
                    LoadAddOn("BigWigs_Options")
                    BigWigsOptions:Open()
                end
            end,
            notCheckable = true,
            keepShownOnClick = true,
            fontObject = Game13Font,
        }
    end

    if x and not x2 then
        table.insert(menuList, addonMenuTable[1])
        table.insert(menuList, addonMenuTable[2])
        x2 = true
    end
end

    -- Pico Menu Button

local picoMenu = CreateFrame("Button", "nMainbarPicoMenu", UIParent)  -- Direkt an UIParent für höchste Priorität
picoMenu:SetFrameStrata("HIGH")  -- HIGH statt MEDIUM
picoMenu:SetFrameLevel(100)  -- Sehr hoher Level
picoMenu:SetToplevel(true)
picoMenu:SetSize(30, 30)

-- Position relative to available frames
if MainMenuBarArtFrame and MainMenuBarArtFrame.RightEndCap then
	picoMenu:SetPoint("BOTTOM", MainMenuBarArtFrame.RightEndCap, 0, 8)
elseif MainMenuBar then
	picoMenu:SetPoint("BOTTOM", MainMenuBar, "BOTTOM", 250, 8)
else
	picoMenu:SetPoint("BOTTOM", UIParent, "BOTTOM", 300, 33)
end

picoMenu:RegisterForClicks("Anyup")
picoMenu:RegisterEvent("ADDON_LOADED")
picoMenu:RegisterEvent("PLAYER_ENTERING_WORLD")
picoMenu:RegisterEvent("PLAYER_LEVEL_UP")
picoMenu:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
picoMenu:RegisterEvent("PLAYER_TALENT_UPDATE")

picoMenu:SetNormalTexture("Interface\\AddOns\\nMainbar\\Media\\picomenu\\picomenuNormal")
picoMenu:GetNormalTexture():SetSize(30, 30)

picoMenu:SetHighlightTexture("Interface\\AddOns\\nMainbar\\Media\\picomenu\\picomenuHighlight")
picoMenu:GetHighlightTexture():SetAllPoints(picoMenu:GetNormalTexture())

-- TODO: MicroButtonAlertTemplate is gone.
-- local alertFrame = CreateFrame("Frame", "nMainbarAlertFrame", picoMenu, "MicroButtonAlertTemplate")
-- alertFrame:SetSize(220,100)
-- alertFrame.Text:SetText(TALENT_MICRO_BUTTON_UNSPENT_TALENTS)
-- alertFrame:SetPoint("BOTTOM", picoMenu, "TOP", 0, 10)

picoMenu:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        UpdateAddOnTable()
    elseif event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LEVEL_UP" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "PLAYER_TALENT_UPDATE" then
        -- if C_SpecializationInfo.CanPlayerUseTalentUI() and GetNumUnspentTalents() > 0 then
        --     alertFrame:Show()
        -- else
        --     alertFrame:Hide()
        -- end
    end
end)

-- Picomenu Position Management - Bind to ActionBar Art
local picoMenuConfig = {
    baseX = 300,
    baseY = 8,
    lastScale = 1,
    lastArtShown = false
}

-- Load position from config
if nMainbar.Config.picomenu then
    picoMenuConfig.baseX = nMainbar.Config.picomenu.offsetX or 300
    picoMenuConfig.baseY = nMainbar.Config.picomenu.offsetY or 8
end

local function UpdatePicoMenuPosition()
    local pm = nMainbar.Config.picomenu
    picoMenu:ClearAllPoints()
    if pm and pm.useAbs and pm.absX and pm.absY then
        -- Restore absolute screen position (saved after manual drag)
        picoMenu:SetPoint("CENTER", UIParent, "CENTER", pm.absX, pm.absY)
    else
        -- Default: relative to MainMenuBar
        local offsetX = (pm and pm.offsetX) or picoMenuConfig.baseX
        local offsetY = (pm and pm.offsetY) or picoMenuConfig.baseY
        if MainMenuBar then
            picoMenu:SetPoint("BOTTOM", MainMenuBar, "BOTTOM", offsetX, offsetY)
        else
            picoMenu:SetPoint("CENTER", UIParent, "CENTER", offsetX, offsetY - 250)
        end
    end
end

-- Initial position after everything is loaded
C_Timer.After(2, UpdatePicoMenuPosition)

picoMenu:SetMovable(true)
picoMenu:SetClampedToScreen(true)

local function SavePicoMenuPosition()
    -- Store position as absolute screen coordinates (relative to UIParent CENTER)
    -- This avoids any dependency on MainMenuBar being loaded at save time
    local x, y = picoMenu:GetCenter()
    local uiScale = UIParent:GetEffectiveScale()
    local screenW = GetScreenWidth()
    local screenH = GetScreenHeight()
    -- Normalize to UIParent-relative offsets from center
    local cx = (screenW / 2)
    local cy = (screenH / 2)
    local offsetX = (x or cx) - cx
    local offsetY = (y or cy) - cy

    if not nMainbar.Config.picomenu then
        nMainbar.Config.picomenu = {}
    end
    nMainbar.Config.picomenu.absX = offsetX
    nMainbar.Config.picomenu.absY = offsetY
    nMainbar.Config.picomenu.useAbs = true
    nMainbar.SaveConfig()
end

picoMenu:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" and IsShiftKeyDown() then
        self:StartMoving()
        self._isMoving = true
    else
        self:GetNormalTexture():ClearAllPoints()
        self:GetNormalTexture():SetPoint("CENTER", 1, -1)
    end
end)

picoMenu:SetScript("OnMouseUp", function(self, button)
    if self._isMoving then
        self:StopMovingOrSizing()
        self._isMoving = false
        SavePicoMenuPosition()
        return
    end

    self:GetNormalTexture():ClearAllPoints()
    self:GetNormalTexture():SetPoint("CENTER")

    if button == "LeftButton" then
        if self:IsMouseOver() then
            if DropDownList1 and DropDownList1:IsShown() then
                DropDownList1:Hide()
            else
                -- Modern API: Use MenuUtil or fallback to EasyMenu
                if MenuUtil and MenuUtil.CreateContextMenu then
                    MenuUtil.CreateContextMenu(self, function(ownerRegion, rootDescription)
                        for _, item in ipairs(menuList) do
                            if item.isTitle then
                                rootDescription:CreateTitle(item.text)
                            elseif item.text == "" then
                                rootDescription:CreateDivider()
                            elseif item.hasArrow and item.menuList then
                                local submenu = rootDescription:CreateButton(item.text, function() end)
                                if item.icon then
                                    submenu:AddInitializer(function(button, description, menu)
                                        local texture = button:AttachTexture()
                                        if texture then
                                            texture:SetTexture(item.icon)
                                            texture:SetSize(16, 16)
                                            texture:SetPoint("LEFT")
                                        end
                                        return button.fontString:SetPoint("LEFT", texture, "RIGHT", 5, 0)
                                    end)
                                end
                                for _, subitem in ipairs(item.menuList) do
                                    if subitem.func then
                                        local subButton = submenu:CreateButton(subitem.text, subitem.func)
                                        if subitem.icon then
                                            subButton:AddInitializer(function(button, description, menu)
                                                local texture = button:AttachTexture()
                                                if texture then
                                                    texture:SetTexture(subitem.icon)
                                                    texture:SetSize(16, 16)
                                                    texture:SetPoint("LEFT")
                                                end
                                                return button.fontString:SetPoint("LEFT", texture, "RIGHT", 5, 0)
                                            end)
                                        end
                                        if subitem.disabled then
                                            subButton:SetEnabled(false)
                                        end
                                    end
                                end
                            elseif item.func then
                                local button = rootDescription:CreateButton(item.text, item.func)
                                if item.icon then
                                    button:AddInitializer(function(button, description, menu)
                                        local texture = button:AttachTexture()
                                        if texture then
                                            texture:SetTexture(item.icon)
                                            texture:SetSize(16, 16)
                                            texture:SetPoint("LEFT")
                                        end
                                        return button.fontString:SetPoint("LEFT", texture, "RIGHT", 5, 0)
                                    end)
                                end
                                if item.disabled then
                                    button:SetEnabled(false)
                                end
                            end
                        end
                    end)
                elseif EasyMenu then
                    -- Fallback for older versions
                    EasyMenu(menuList, menuFrame, self, 3, 290, "MENU", 5)
                end
            end
        end
    else
        if self:IsMouseOver() then
            if not GameMenuFrame:IsVisible() then
                ShowUIPanel(GameMenuFrame)
            else
                HideUIPanel(GameMenuFrame)
            end
        end
    end

    GameTooltip:Hide()
end)

picoMenu:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 25, -5)
    GameTooltip:AddLine(MAINMENU_BUTTON)
    GameTooltip:Show()
end)

picoMenu:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Make the picomenu globally accessible for toggling
nMainbar.picoMenu = picoMenu

-- Register event to set visibility after config is loaded
local visibilityFrame = CreateFrame("Frame")
visibilityFrame:RegisterEvent("PLAYER_LOGIN")
visibilityFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        -- Config is now loaded, apply the saved visibility setting
        if cfg.showPicomenu then
            picoMenu:Show()
        else
            picoMenu:Hide()
        end
        self:UnregisterEvent("PLAYER_LOGIN")
    end
end)

    -- Note: We don't manipulate HelpOpenWebTicketButton anymore
    -- to avoid Edit Mode conflicts. It stays in its default position.
