-- menu.lua handles the creation and update of the S000M buttons that are /clicked
-- it opens a flyout at the cursor's position for the current state

local _, s = ...
s.menu = {}

function s.menu:Create(action)
	local index = action:GetID()
	local selectline = action:GetAttribute("selectline")

	local menu = CreateFrame("Button", format("S%03dM", index), action, "SecureHandlerClickTemplate,SecureHandlerStateTemplate")
	menu:RegisterForClicks("AnyUp")

	menu:SetScript("PreClick", s.menu.PreClick)

	-- _onstate-select: when state changes, hide its flyout if open and copy the new state's flyout attributes to the parent action
	menu:SetAttribute(
		"_onstate-select",
		[[
        local oldstate = self:GetAttribute("activelist")
        local action = self:GetParent()
        local root = action:GetParent()

        -- if state is changing, hide open flyout if it's the one open
        if oldstate and oldstate~=newstate then
            local oldFlyoutFrame = self:GetParent():GetParent():GetFrameRef(oldstate)
            if oldFlyoutFrame and oldFlyoutFrame:IsVisible() then
                oldFlyoutFrame:Hide()
            end
        end
        
        -- update unit if state changes it
        local selectline = action:GetAttribute("selectline")
        local _,unit = SecureCmdOptionParse(selectline)
        if unit ~= action:GetAttribute("unit") then
            action:SetAttribute("unit",unit)
        end

        -- copy attributes of new flyout to the action button
        local flyout = root:GetFrameRef(newstate)
        if flyout then
            local attribClass = flyout:GetAttribute("attribClass")
            local attribType = flyout:GetAttribute("attribType")
            local attribKey = flyout:GetAttribute("attribKey")
            local attribValue = flyout:GetAttribute("attribValue")

            -- copy attributes to action
            action:SetAttribute("attribClass",attribClass)
            action:SetAttribute("attribType",attribType)
            action:SetAttribute("attribKey",attribKey)
            action:SetAttribute("attribValue",attribValue)

            -- finally set the attributes to set behavior of /click S000A
            action:SetAttribute("type",attribType)
            if attribKey then
                action:SetAttribute(attribKey,attribValue)
            end

            -- special case for equipslot: change /equipslot slot to /use slot (but leave attribKey/Value alone)
            if attribClass == "equipslot" then
                local slot = attribValue:match("/equipslot (%d+) ")
                if slot then
                    action:SetAttribute("macrotext","/use "..slot)
                end
            end            
        end

        self:SetAttribute("activelist",newstate)
    ]]
	)

	-- _onclick: the /click of S000M opens the flyout menu, hiding any previous one if it exists
	menu:SetAttribute(
		"_onclick",
		[[
        local flyoutFrame = self:GetParent():GetParent():GetFrameRef(self:GetAttribute("activelist"))
        if flyoutFrame then
            if flyoutFrame:IsVisible() then
                flyoutFrame:Hide()
            else
                flyoutFrame:SetParent(self)
                flyoutFrame:ClearAllPoints()
                local direction = flyoutFrame:GetAttribute("direction")
                if direction=="down" then
                    flyoutFrame:SetPoint("TOP","$cursor",0,2)
                elseif direction=="left" then
                    flyoutFrame:SetPoint("RIGHT","$cursor",2,0)
                elseif direction=="right" then
                    flyoutFrame:SetPoint("LEFT","$cursor",-2,0)
                else
                    flyoutFrame:SetPoint("BOTTOM","$cursor",0,-2)
                end
            end
            flyoutFrame:SetFrameStrata("FULLSCREEN_DIALOG")
            flyoutFrame:RegisterAutoHide(0.5)
            flyoutFrame:Show()
        end

    ]]
	)

	RegisterStateDriver(menu, "select", selectline)

	return menu
end

function s.menu:UpdateStateDriver(action)
	UnregisterStateDriver(action.menu, "select")
	RegisterStateDriver(action.menu, "select", action:GetAttribute("selectline"))
end

function s.menu:PreClick()
	if not InCombatLockdown() then
		local list = self:GetAttribute("activelist")
		if list and s.root.flyouts[list] then
			s.flyout:Fill(s.root.flyouts[list])
		end
	end
end
