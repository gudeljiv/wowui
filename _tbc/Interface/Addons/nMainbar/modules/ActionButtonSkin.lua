local _, nMainbar = ...
local cfg = nMainbar.Config
local Color = cfg.color

local pairs = pairs
local gsub = string.gsub

local MEDIA_PATH = "Interface\\AddOns\\nMainbar\\Media\\"

local function IsSpecificButton(self, name)
    local sbut = self:GetName():match(name)
    if sbut then
        return true
    else
        return false
    end
end

local IsSkinned = {}

-- Helper: Check if a hotkey text string represents a real keybind
local function IsRealKeybind(text)
    if not text or text == "" then return false end
    if text == "·" or text == "•" or text == "." then return false end
    if RANGE_INDICATOR and text == RANGE_INDICATOR then return false end
    return true
end

-- Helper: Aggressively suppress hotkey display on a button.
-- This prevents Blizzard from re-showing the HotKey fontstring,
-- which in Midnight causes white rectangular outlines on empty buttons.
-- The hook is smart: if real keybind text is later set, it allows showing.
local function SuppressEmptyHotkey(hotkey)
    hotkey:SetText("")
    hotkey:Hide()
    hotkey:SetAlpha(0)
    hotkey.nMainbarSuppressed = true
    
    -- Install persistent hook (once) that keeps empty hotkeys hidden
    if not hotkey.nMainbarHooked then
        hotkey.nMainbarHooked = true
        
        -- When Blizzard tries to Show() the hotkey, check if we should allow it
        hooksecurefunc(hotkey, "Show", function(self)
            if self.nMainbarSuppressed then
                self:Hide()
            end
        end)
        
        -- When Blizzard sets new text, re-evaluate if this is a real keybind
        hooksecurefunc(hotkey, "SetText", function(self, newText)
            if self.nMainbarSuppressed then
                if IsRealKeybind(newText) then
                    -- Real keybind appeared! Allow showing.
                    self.nMainbarSuppressed = false
                    self:SetAlpha(1)
                    self:Show()
                else
                    -- Still empty/placeholder, keep suppressed
                    self:Hide()
                    self:SetAlpha(0)
                end
            end
        end)
    end
end

-- Helper: Allow hotkey display (undo suppression)
local function AllowHotkey(hotkey)
    hotkey.nMainbarSuppressed = false
    hotkey:SetAlpha(1)
end

-- Debug: print all texture info for a button to chat
local function DebugButtonTextures(button)
    local buttonName = button:GetName()
    print("=== Debugging button:", buttonName, "===")
    
    local texturesToCheck = {
        "SlotBackground", "SlotArt", "SpellHighlightTexture",
        "IconBorder", "NewActionTexture", "NormalTexture",
        "NormalTexture2", "Border", "icon"
    }
    
    for _, texName in ipairs(texturesToCheck) do
        if button[texName] then
            local tex = button[texName]
            local texPath = tex:GetTexture()
            local alpha = tex:GetAlpha()
            local shown = tex:IsShown()
            print("  " .. texName .. ":", "texture=" .. tostring(texPath), "alpha=" .. tostring(alpha), "shown=" .. tostring(shown))
        end
    end
    
    -- Print HotKey info
    if button.HotKey then
        local hk = button.HotKey
        print("  HotKey: text=" .. tostring(hk:GetText()), "alpha=" .. tostring(hk:GetAlpha()), "shown=" .. tostring(hk:IsShown()), "suppressed=" .. tostring(hk.nMainbarSuppressed))
    end
    
    print("  All regions:")
    for i = 1, button:GetNumRegions() do
        local region = select(i, button:GetRegions())
        if region and region:GetObjectType() == "Texture" then
            local name = region:GetName() or "unnamed"
            local texture = region:GetTexture()
            if texture and texture ~= "" then
                print("    Region", i, ":", name, "- Texture:", texture, "- Alpha:", region:GetAlpha(), "- Shown:", region:IsShown())
            end
        end
    end
end

-- Store debug function so GUI can call it
nMainbar.DebugButtonTextures = function()
    local barPrefixes = {
        "ActionButton", "MultiBarBottomLeftButton", "MultiBarBottomRightButton",
        "MultiBarRightButton", "MultiBarLeftButton"
    }
    
    for _, prefix in ipairs(barPrefixes) do
        for i = 1, 12 do
            local button = _G[prefix .. i]
            if button then
                DebugButtonTextures(button)
            end
        end
    end
    
    for i = 1, 10 do
        local button = _G["StanceButton" .. i]
        if button then
            DebugButtonTextures(button)
        end
    end
end

-- Update mouseover highlight color on all already-skinned buttons
nMainbar.UpdateMouseoverColor = function()
    local barPrefixes = {
        "ActionButton", "MultiBarBottomLeftButton", "MultiBarBottomRightButton",
        "MultiBarRightButton", "MultiBarLeftButton",
        "PetActionButton", "StanceButton", "PossessButton",
    }
    local r, g, b, a = Color.Mouseover:GetRGBA()
    for _, prefix in ipairs(barPrefixes) do
        for i = 1, 12 do
            local button = _G[prefix .. i]
            if button then
                local hl = button:GetHighlightTexture()
                if hl then
                    hl:SetBlendMode("BLEND")
                    hl:SetVertexColor(r, g, b, a)
                end
            end
        end
    end
end

local function SkinButton(button, icon, borderOffset, shadowOffset)
    local buttonName = button:GetName()
    local border = button.Border
    local cooldown = _G[buttonName.."Cooldown"]
    local floatingBG = _G[buttonName.."FloatingBG"]
    local normalTexture = _G[buttonName.."NormalTexture2"] or _G[buttonName.."NormalTexture"]

    if not InCombatLockdown() then
        if cooldown then
            cooldown:ClearAllPoints()
            PixelUtil.SetPoint(cooldown, "TOPRIGHT", button, "TOPRIGHT", -2, -2)
            PixelUtil.SetPoint(cooldown, "BOTTOMLEFT", button, "BOTTOMLEFT", 1, 1)
        end
    end

    button:SetNormalTexture(MEDIA_PATH.."textureNormal")

    if not IsSkinned[button] then
        if icon then
            icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
            PixelUtil.SetPoint(icon, "TOPRIGHT", button, "TOPRIGHT", -1, -1)
            PixelUtil.SetPoint(icon, "BOTTOMLEFT", button, "BOTTOMLEFT", 1, 1)
        end

        if normalTexture then
            normalTexture:ClearAllPoints()
            PixelUtil.SetPoint(normalTexture, "TOPRIGHT", button, "TOPRIGHT", borderOffset, borderOffset)
            PixelUtil.SetPoint(normalTexture, "BOTTOMLEFT", button, "BOTTOMLEFT", -borderOffset, -borderOffset)
            normalTexture:SetVertexColor(Color.Normal:GetRGBA())

            button:SetCheckedTexture(MEDIA_PATH.."textureChecked")
            button:GetCheckedTexture():SetAllPoints(normalTexture)

            button:SetPushedTexture(MEDIA_PATH.."texturePushed")
            button:GetPushedTexture():SetAllPoints(normalTexture)

            -- Use textureHighlight (grayscale border) so SetVertexColor works correctly.
            button:SetHighlightTexture(MEDIA_PATH.."textureHighlight")
            local hl = button:GetHighlightTexture()
            hl:SetAllPoints(normalTexture)
            hl:SetBlendMode("BLEND")
            local mo = Color.Mouseover
            if mo then
                hl:SetVertexColor(mo:GetRGBA())
            end
        end

        if border then
            border:SetBlendMode("BLEND")
            border:SetTexture(MEDIA_PATH.."UI-ActionButton-Glow")
            border:ClearAllPoints()
            border:SetAllPoints(normalTexture)
        end

        if not button.Background then
            button.Background = button:CreateTexture(nil, "BACKGROUND", nil, -8)
            button.Background:SetTexture(MEDIA_PATH.."textureBackground")
            PixelUtil.SetPoint(button.Background, "TOPRIGHT", button, "TOPRIGHT", 14, 12)
            PixelUtil.SetPoint(button.Background, "BOTTOMLEFT", button, "BOTTOMLEFT", -14, -16)
        end

        if floatingBG then
            floatingBG:ClearAllPoints()
            floatingBG:Hide()
        end
        
        -- Hide Midnight-specific keybind highlight textures
        if button.SlotBackground then
            button.SlotBackground:Hide()
        end
        if button.SlotArt then
            button.SlotArt:Hide()
        end
        if button.SpellHighlightTexture then
            button.SpellHighlightTexture:SetAlpha(0)
        end

        if not button.Shadow then
            button.Shadow = button:CreateTexture("$parentFloatingBG", "BACKGROUND")
            button.Shadow:SetTexture(MEDIA_PATH.."textureShadow")
            button.Shadow:SetVertexColor(0.0, 0.0, 0.0, 1.0)
            PixelUtil.SetPoint(button.Shadow, "TOPRIGHT", normalTexture, "TOPRIGHT", shadowOffset, shadowOffset)
            PixelUtil.SetPoint(button.Shadow, "BOTTOMLEFT", normalTexture, "BOTTOMLEFT", -shadowOffset, -shadowOffset)
        end

        IsSkinned[button] = true
    end
end

local function UpdateVehicleButton()
    for i = 1, NUM_OVERRIDE_BUTTONS do
        local button = _G["OverrideActionBarButton"..i]
        local hotkey = _G["OverrideActionBarButton"..i.."HotKey"]
        if cfg.button.showVehicleKeybinds then
            hotkey:SetFont(cfg.button.hotkeyFont, cfg.button.hotkeyFontsize + 3, "OUTLINE")
            hotkey:SetVertexColor(Color.HotKeyText:GetRGB())
            hotkey:ClearAllPoints()
            hotkey:SetPoint("TOPRIGHT", button, -4, -8)
        else
            hotkey:Hide()
        end
    end
end

local ActionBarActionButtonMixinHook_UpdateHotkeys = function(self, actionButtonType)
    local hotkey = self.HotKey
    local text = hotkey:GetText()

    text = gsub(text, "(s%-)", "S-")
    text = gsub(text, "(a%-)", "A-")
    text = gsub(text, "(c%-)", "C-")
    text = gsub(text, "(st%-)", "C-") -- German Control "Steuerung"

    for i = 1, 30 do
        text = gsub(text, _G["KEY_BUTTON"..i], "M"..i)
    end

    for i = 1, 9 do
        text = gsub(text, _G["KEY_NUMPAD"..i], "Nu"..i)
    end

    text = gsub(text, KEY_NUMPADDECIMAL, "Nu.")
    text = gsub(text, KEY_NUMPADDIVIDE, "Nu/")
    text = gsub(text, KEY_NUMPADMINUS, "Nu-")
    text = gsub(text, KEY_NUMPADMULTIPLY, "Nu*")
    text = gsub(text, KEY_NUMPADPLUS, "Nu+")

    text = gsub(text, KEY_MOUSEWHEELUP, "MU")
    text = gsub(text, KEY_MOUSEWHEELDOWN, "MD")
    text = gsub(text, KEY_NUMLOCK, "NuL")
    text = gsub(text, KEY_PAGEUP, "PU")
    text = gsub(text, KEY_PAGEDOWN, "PD")
    text = gsub(text, KEY_SPACE, "_")
    text = gsub(text, KEY_INSERT, "Ins")
    text = gsub(text, KEY_HOME, "Hm")
    text = gsub(text, KEY_DELETE, "Del")

    hotkey:SetText(text)

    if not IsSpecificButton(self, "OverrideActionBarButton") and not self.hotkeyUpdated then
        -- Hide the keybind highlight textures in Midnight
        if self.SpellHighlightTexture then
            self.SpellHighlightTexture:SetAlpha(0)
        end
        if self.SpellActivationAlert then
            if self.SpellActivationAlert.ProcStartAnim then
                self.SpellActivationAlert.ProcStartAnim:Stop()
            end
        end
        
        -- Check if this is a button on the main action bar (ActionButton1-12)
        local buttonName = self:GetName()
        local isMainActionBar = buttonName and buttonName:match("^ActionButton%d+$")
        
        if isMainActionBar then
            -- Main action bar: respect the showKeybinds setting
            if cfg.button.showKeybinds then
                hotkey:ClearAllPoints()
                hotkey:SetPoint("TOPRIGHT", self, 0, -3)
                hotkey:SetFont(cfg.button.hotkeyFont, cfg.button.hotkeyFontsize, "OUTLINE")
                hotkey:SetVertexColor(Color.HotKeyText:GetRGB())
                hotkey:Show()
            else
                hotkey:Hide()
            end
            self.hotkeyUpdated = true
        else
            -- All other bars: Show real keybinds, aggressively hide empty ones.
            -- Empty HotKey fontstrings in Midnight cause white rectangular outlines,
            -- so we must fully suppress them (not just Hide, also SetAlpha(0) + hook).
            if IsRealKeybind(text) then
                -- Real keybind exists - show it with styling
                AllowHotkey(hotkey)
                hotkey:ClearAllPoints()
                hotkey:SetPoint("TOPRIGHT", self, 0, -3)
                hotkey:SetFont(cfg.button.hotkeyFont, cfg.button.hotkeyFontsize, "OUTLINE")
                hotkey:SetVertexColor(Color.HotKeyText:GetRGB())
                hotkey:Show()
            else
                -- No real keybind - aggressively suppress to prevent white borders
                SuppressEmptyHotkey(hotkey)
            end
            self.hotkeyUpdated = true
        end
    else
        UpdateVehicleButton()
    end
end

local ActionBarActionButtonMixinHook_Update = function(self)
    local action = self.action
    local icon = self.icon
    local border = self.Border
    local texture = GetActionTexture(action)

    local actionName = self.Name
    if actionName then
        if not cfg.button.showMacroNames then
            actionName:SetText("")
        else
            actionName:SetFont(cfg.button.macronameFont, cfg.button.macronameFontsize, "OUTLINE")
            actionName:SetVertexColor(Color.MacroText:GetRGB())
        end
    end

    if not IsSpecificButton(self, "ExtraActionButton") then
        SkinButton(self, texture and icon, 1, 4)
    end

    if border then
        if IsEquippedAction(action) then
            border:SetVertexColor(Color.IsEquipped:GetRGB())
            border:SetAlpha(1)
        else
            border:SetAlpha(0)
        end
    end
end

if ExtraActionBar_Update then
	hooksecurefunc("ExtraActionBar_Update", function(self)
		if HasExtraActionBar() and not IsSkinned[ExtraActionBarFrame] then
			local button = ExtraActionBarFrame.button
			button.style:Hide()

			SkinButton(button, button.icon, 4, 5)

			IsSkinned[ExtraActionBarFrame] = true
		end
	end)
end

local ActionBarActionButtonMixinHook_UpdateCount = function(self)
    local text = self.Count

    if text then
        text:SetPoint("BOTTOMRIGHT", self, 0, 1)
        text:SetFont(cfg.button.countFont, cfg.button.countFontsize, "OUTLINE")
        text:SetVertexColor(Color.CountText:GetRGB())
    end
end

local ActionBarActionButtonMixinHook_ShowGrid = function(self)
    if self.NormalTexture then
        self.NormalTexture:SetVertexColor(Color.Normal:GetRGBA())
    end
end

local function ActionBarActionButtonMixinHook_UpdateUsable(self, checksRange, inRange)
    local icon = self.icon
    local normalTexture = self.NormalTexture
    if not normalTexture then
        return
    end

    local isUsable, notEnoughMana = IsUsableAction(self.action)
    
    -- Check if currently out of range (if range checking is enabled)
    local isOutOfRange = false
    if cfg.button.buttonOutOfRange and self.nMainbarRangeState then
        isOutOfRange = (self.nMainbarRangeState.checksRange and not self.nMainbarRangeState.inRange)
    end
    
    -- Priority: OOR > OOM > Unusable > Normal
    if isOutOfRange then
        -- Out of range takes priority - don't change it here, UpdateRangeIndicator handles this
        icon:SetVertexColor(Color.OutOfRange:GetRGB())
        normalTexture:SetVertexColor(Color.OutOfRange:GetRGB())
    elseif notEnoughMana then
        icon:SetVertexColor(Color.OutOfMana:GetRGB())
        normalTexture:SetVertexColor(Color.OutOfMana:GetRGB())
    elseif not isUsable then
        icon:SetVertexColor(Color.NotUsable:GetRGB())
        normalTexture:SetVertexColor(Color.NotUsable:GetRGB())
    else
        icon:SetVertexColor(1.0, 1.0, 1.0)
        normalTexture:SetVertexColor(Color.Normal:GetRGBA())
    end
end

if ActionButton_UpdateRangeIndicator then
	hooksecurefunc("ActionButton_UpdateRangeIndicator", function(self, checksRange, inRange)
		if self.action and cfg.button.buttonOutOfRange then
			-- Store the range state on the button for use in UpdateUsable
			if not self.nMainbarRangeState then
				self.nMainbarRangeState = {}
			end
			self.nMainbarRangeState.checksRange = checksRange
			self.nMainbarRangeState.inRange = inRange
			
			-- Determine if out of range
			local oor = checksRange and not inRange
			
			-- Get current state
			local icon = self.icon
			local normalTexture = self.NormalTexture
			
			if not icon or not normalTexture then return end
			
			-- Check if button is usable to determine state transitions
			local isUsable, notEnoughMana = IsUsableAction(self.action)
			
			if isUsable and not notEnoughMana then
				-- Can only toggle between normal and oor when usable
				if oor then
					-- Switch to out of range
					icon:SetVertexColor(Color.OutOfRange:GetRGB())
					normalTexture:SetVertexColor(Color.OutOfRange:GetRGB())
				else
					-- Switch back to normal
					icon:SetVertexColor(1.0, 1.0, 1.0)
					normalTexture:SetVertexColor(Color.Normal:GetRGBA())
				end
			elseif notEnoughMana and not oor then
				-- Keep OOM color if not out of range
				icon:SetVertexColor(Color.OutOfMana:GetRGB())
				normalTexture:SetVertexColor(Color.OutOfMana:GetRGB())
			elseif not isUsable and not oor then
				-- Keep unusable color if not out of range  
				icon:SetVertexColor(Color.NotUsable:GetRGB())
				normalTexture:SetVertexColor(Color.NotUsable:GetRGB())
			end
		end

		if self.HotKey:GetText() == RANGE_INDICATOR then
			if checksRange then
				self.HotKey:Show()
				if inRange then
					self.HotKey:SetVertexColor(Color.HotKeyText:GetRGB())
				else
					self.HotKey:SetVertexColor(Color.OutOfRange:GetRGB())
				end
			else
				self.HotKey:Hide()
			end
		else
			if checksRange and not inRange then
				self.HotKey:SetVertexColor(Color.OutOfRange:GetRGB())
			else
				self.HotKey:SetVertexColor(Color.HotKeyText:GetRGB())
			end
		end
	end)
end

if PetActionBar_Update then
	hooksecurefunc("PetActionBar_Update", function(self)
		local button, icon
		for i=1, NUM_PET_ACTION_SLOTS, 1 do
			local buttonName = "PetActionButton"..i
			button = _G[buttonName]
			icon = _G[buttonName.."Icon"]

			if button and icon then
				SkinButton(button, icon, 1.5, 4)

				local hotkey = _G[buttonName.."HotKey"]
				if hotkey then
					if cfg.button.showKeybinds then
						hotkey:ClearAllPoints()
						hotkey:SetPoint("TOPRIGHT", buttonName, 0, -3)
						hotkey:SetFont(cfg.button.hotkeyFont, cfg.button.petHotKeyFontsize, "OUTLINE")
						hotkey:SetVertexColor(Color.HotKeyText:GetRGB())
					else
						hotkey:Hide()
					end
				end
			end
		end
	end)
end

-- Stance Bar Skinning - Modern API for Midnight
do
    local function SkinStanceButtons()
        local button, icon
        local numButtons = 10
        
        for i = 1, numButtons do
            if StanceBar and StanceBar.actionButtons then
                button = StanceBar.actionButtons[i]
            elseif StanceBarFrame and StanceBarFrame.StanceButtons then
                button = StanceBarFrame.StanceButtons[i]
            else
                button = _G["StanceButton"..i]
            end
            
            if button then
                icon = button.icon or _G["StanceButton"..i.."Icon"]
                if icon then
                    SkinButton(button, icon, 2, 4)
                end
                
                local hotkey = button.HotKey
                if hotkey then
                    hotkey:Hide()
                end
            end
        end
    end
    
    if StanceBar_UpdateState then
        hooksecurefunc("StanceBar_UpdateState", SkinStanceButtons)
    end
    
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_LOGIN")
    frame:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
    frame:SetScript("OnEvent", function(self, event)
        C_Timer.After(0.5, SkinStanceButtons)
    end)
end

if PossessBar_UpdateState then
	hooksecurefunc("PossessBar_UpdateState", function()
		local button, icon

		for i=1, NUM_POSSESS_SLOTS do
			button = _G["PossessButton"..i]
			icon = _G["PossessButton"..i.."Icon"]

			if button and icon then
				SkinButton(button, icon, 1.5, 4)
			end
		end
	end)
end

local ActionBarActionButtonMixinHook_OnLoad = function(self)
    ActionBarActionButtonMixinHook_ShowGrid(self)
    ActionBarActionButtonMixinHook_UpdateCount(self)
    ActionBarActionButtonMixinHook_UpdateHotkeys(self)
    ActionBarActionButtonMixinHook_UpdateUsable(self)

    if self.ShowGrid then
        hooksecurefunc(self, "ShowGrid", ActionBarActionButtonMixinHook_ShowGrid)
    end
    if self.Update then
        hooksecurefunc(self, "Update", ActionBarActionButtonMixinHook_Update)
    end
    if self.UpdateCount then
        hooksecurefunc(self, "UpdateCount", ActionBarActionButtonMixinHook_UpdateCount)
    end
    if self.UpdateHotkeys then
        hooksecurefunc(self, "UpdateHotkeys", ActionBarActionButtonMixinHook_UpdateHotkeys)
    end
    if self.UpdateUsable then
        hooksecurefunc(self, "UpdateUsable", ActionBarActionButtonMixinHook_UpdateUsable)
    end
end

-- Hide Possess Frame Background

do
    for _ = 2, 3 do
        for _, object in pairs({
                _G["PossessBackground1"],
                _G["PossessBackground2"],
            }) do
            if object:IsObjectType("Frame") or object:IsObjectType("Button") then
                object:UnregisterAllEvents()
                object:SetScript("OnEnter", nil)
                object:SetScript("OnLeave", nil)
                object:SetScript("OnClick", nil)
            end

            hooksecurefunc(object, "Show", function(self)
                self:Hide()
            end)

            object:Hide()
        end
    end
end

-- Force Hotkey Update

local f = CreateFrame("Frame", nil)
f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        if GetBindingKey and SetBinding then
            local bagBinding = GetBindingKey("NBAGS_TOGGLE") or "ALT-CTRL-B"
            SetBinding(bagBinding, "NBAGS_TOGGLE")
        end
        f:UnregisterEvent("PLAYER_LOGIN")

        -- Hook existing frames.
        if ActionBarActionButtonMixin and ActionBarActionButtonMixin.OnLoad then
            local ActionBarActionButtonMixin_OnLoad = ActionBarActionButtonMixin.OnLoad
            local frame = EnumerateFrames()
            while frame do
                if frame.OnLoad == ActionBarActionButtonMixin_OnLoad then
                    ActionBarActionButtonMixinHook_OnLoad(frame)
                end

                frame = EnumerateFrames(frame)
            end
        end
    end
end)
