---@param menuTypeStr "SELF"|"PARTY"|"RAID"
---@return integer
local function GetInsertIndex(menuTypeStr)
    if menuTypeStr == "SELF" then
        if not SetRoleButtonsConfig.selfInsertIndex then
            return 6 -- default SELF
        else
            return SetRoleButtonsConfig.selfInsertIndex
        end
    elseif menuTypeStr == "PARTY" then
        if not SetRoleButtonsConfig.partyInsertIndex then
            return 6 -- default PARTY
        else
            return SetRoleButtonsConfig.partyInsertIndex
        end
    elseif menuTypeStr == "RAID" then
        if not SetRoleButtonsConfig.raidInsertIndex then
            return 6 -- default RAID
        else
            return SetRoleButtonsConfig.raidInsertIndex
        end
    else
        -- print("DEBUG: wtf")
        return 6
    end
end


---@param menuTypeStr "SELF"|"PARTY"|"RAID"
---@return boolean
local function GetToggleValue(menuTypeStr)
    if menuTypeStr =="SELF" then
        if SetRoleButtonsConfig.toggleSelfMenu ~= nil then
            return SetRoleButtonsConfig.toggleSelfMenu
        else
            return true
        end
    elseif menuTypeStr == "PARTY" then
        if SetRoleButtonsConfig.togglePartyMenu ~= nil then
            return SetRoleButtonsConfig.togglePartyMenu
        else
            return true
        end
    elseif menuTypeStr == "RAID" then
        if SetRoleButtonsConfig.toggleRaidMenu ~= nil then
            return SetRoleButtonsConfig.toggleRaidMenu
        else
            return true
        end
    else
        -- print("DEBUG: WTF")
        return true
    end
end

local function SRB_OnSetRoleButtonClicked(unit, roleStr)
    if not unit then
        return
    end
    UnitSetRole(unit, roleStr)
end

---@param menuTypeStr "SELF"|"PARTY"|"RAID"
---@param rootDescription RootMenuDescriptionProxy
---@param contextData any
local function SRB_InsertRoleButtons(menuTypeStr, rootDescription, contextData)
    if not contextData or not contextData.unit then
        return
    end

    local unit = contextData.unit

    local roleHeader = MenuUtil.CreateTitle("Set Role")
    local roleDivider = MenuUtil:CreateDivider()
    
    local roleTank = MenuUtil.CreateRadio(
        CreateAtlasMarkup(GetMicroIconForRole("TANK"), 16, 16) .. " Tank",
        function() return UnitGroupRolesAssigned(unit) == "TANK" end,
        function() SRB_OnSetRoleButtonClicked(unit, "TANK") end
    )

    local roleHeal = MenuUtil.CreateRadio(
        CreateAtlasMarkup(GetMicroIconForRole("HEALER"), 16, 16) .. " Heal",
        function() return UnitGroupRolesAssigned(unit) == "HEALER" end,
        function() SRB_OnSetRoleButtonClicked(unit, "HEALER") end
    )

    local roleDPS = MenuUtil.CreateRadio(
        CreateAtlasMarkup(GetMicroIconForRole("DAMAGER"), 16, 16) .. " DPS",
        function() return UnitGroupRolesAssigned(unit) == "DAMAGER" end,
        function() SRB_OnSetRoleButtonClicked(unit, "DAMAGER") end
    )

    local insertIndex = GetInsertIndex(menuTypeStr)
    rootDescription:Insert(roleHeader, insertIndex)
    rootDescription:Insert(roleTank, insertIndex+1)
    rootDescription:Insert(roleHeal, insertIndex+2)
    rootDescription:Insert(roleDPS, insertIndex+3)
    rootDescription:Insert(roleDivider, insertIndex+4)
end

local srbFrame = CreateFrame("Frame", "SetRoleButtonsFrame")

--#region Options Menu
local title = "SetRoleButtons"
local category = Settings.RegisterVerticalLayoutCategory(title)
do
    local name = "Add Buttons to SELF"
	local variable = "SRB_ToggleSelfMenu"
	local defaultValue = true

    local function SetValue(value)
		SetRoleButtonsConfig.toggleSelfMenu = value
	end

	local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, function() return GetToggleValue("SELF") end, SetValue)

	local tooltip = "Show role buttons in your own context menu? Requires reload to apply."
	Settings.CreateCheckbox(category, setting, tooltip)
end
do
    local name = "Buttons SELF Position Index"
	local variable = "SRB_SelfIndexSlider"
	local minValue = 1
	local maxValue = 30
	local step = 1
    local defaultValue = 6

	local function SetValue(value)
		SetRoleButtonsConfig.selfInsertIndex = value
	end

	local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, function() return GetInsertIndex("SELF") end, SetValue)

	local tooltip = "Menu item position from top to bottom. Requires reload to apply."
	local options = Settings.CreateSliderOptions(minValue, maxValue, step)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
	Settings.CreateSlider(category, setting, options, tooltip)
end
do
    local name = "Add Buttons to PARTY Units"
	local variable = "SRB_TogglePartyMenu"
	local defaultValue = true

    local function SetValue(value)
		SetRoleButtonsConfig.togglePartyMenu = value
	end

	local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, function() return GetToggleValue("PARTY") end, SetValue)

	local tooltip = "Show role buttons in party member context menus? Requires reload to apply."
	Settings.CreateCheckbox(category, setting, tooltip)
end
do
    local name = "Buttons PARTY Position Index"
	local variable = "SRB_PartyIndexSlider"
	local minValue = 1
	local maxValue = 30
	local step = 1
    local defaultValue = 6

	local function SetValue(value)
		SetRoleButtonsConfig.partyInsertIndex = value
	end

	local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, function() return GetInsertIndex("PARTY") end, SetValue)

	local tooltip = "Menu item position from top to bottom. Requires reload to apply."
	local options = Settings.CreateSliderOptions(minValue, maxValue, step)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
	Settings.CreateSlider(category, setting, options, tooltip)
end
do
    local name = "Add Buttons to RAID Units"
	local variable = "SRB_ToggleRaidMenu"
	local defaultValue = true

    local function SetValue(value)
		SetRoleButtonsConfig.toggleRaidMenu = value
	end

	local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, function() return GetToggleValue("RAID") end, SetValue)

	local tooltip = "Show role buttons in raid member context menus? Requires reload to apply."
	Settings.CreateCheckbox(category, setting, tooltip)
end
do
    local name = "Buttons RAID Position Index"
	local variable = "SRB_RaidIndexSlider"
	local minValue = 1
	local maxValue = 30
	local step = 1
    local defaultValue = 6

	local function SetValue(value)
		SetRoleButtonsConfig.raidInsertIndex = value
	end

	local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, function() return GetInsertIndex("RAID") end, SetValue)

	local tooltip = "Menu item position from top to bottom. Requires reload to apply."
	local options = Settings.CreateSliderOptions(minValue, maxValue, step)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
	Settings.CreateSlider(category, setting, options, tooltip)
end
Settings.RegisterAddOnCategory(category);
--#endregion

-- Startup / Init
srbFrame:RegisterEvent("ADDON_LOADED")
srbFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "SetRoleButtons" then
        if not SetRoleButtonsConfig then
            SetRoleButtonsConfig = {
                selfInsertIndex = 6,
                partyInsertIndex = 6,
                raidInsertIndex = 6,
                toggleSelfMenu = true,
                togglePartyMenu = true,
                toggleRaidMenu = true
            }
        end

        -- PARTY member right-click menu
        if GetToggleValue("PARTY") then
            Menu.ModifyMenu("MENU_UNIT_PARTY",
                function(owner, rootDescription, contextData)
                    SRB_InsertRoleButtons("PARTY", rootDescription, contextData)
                end)
        end
        -- RAID member right-click menu
        if GetToggleValue("RAID") then
            Menu.ModifyMenu("MENU_UNIT_RAID_PLAYER",
                function(owner, rootDescription, contextData)
                    SRB_InsertRoleButtons("RAID", rootDescription, contextData)
                end)
        end
        -- PLAYER right-click menu
        if GetToggleValue("SELF") then
            Menu.ModifyMenu("MENU_UNIT_SELF",
                function(owner, rootDescription, contextData)
                    SRB_InsertRoleButtons("SELF", rootDescription, contextData)
                end)
        end
    end
end)