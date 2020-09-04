-- action.lua handles the creation and update of the S000A actions that are /clicked
-- this uses the item or spell that was last selected when the macro is hit

local _, s = ...
s.action = {}

function s.action:Create(index, selectline)
	local action = CreateFrame("Button", format("S%03dA", index), s.root, "SecureActionButtonTemplate")
	action:SetID(index)
	action.isActive = true

	action:SetAttribute("selectline", selectline)

	-- [@unit] conditions don't trigger a state change. pre-click wrap will set unit
	SecureHandlerWrapScript(
		action,
		"OnClick",
		action,
		[[
        local selectline = self:GetAttribute("selectline")
        if selectline then
            local _,unit = SecureCmdOptionParse(selectline)
            if unit ~= self:GetAttribute("unit") then
                self:SetAttribute("unit",unit)
            end
        end
    ]]
	)

	action:SetScript("OnAttributeChanged", s.action.OnAttributeChanged)

	return action
end

function s.action:OnAttributeChanged(key, value)
	s.macro:UpdateIcon(self:GetID())
end

-- sets the action's attribute based on menu's current state; returns true if it successfully set
-- false means that flyouts need filled
function s.action:Fill(action)
	local menu = action.menu
	local list = menu:GetAttribute("activelist")
	if list and s.root.flyouts[list] then
		s.utils:CopyAttributes(s.root.flyouts[list], action)
		-- local attribClass,attribType,attribKey,attribValue = s.utils:GetAttributes(s.root.flyouts[list])
		-- s.utils:SetAttributes(action,attribClass,attribType,attribKey,attribValue)

		local attribClass, attribType, attribKey, attribValue = s.utils:GetAttributes(action)

		-- finally set the attributes to set behavior of /click S000A
		action:SetAttribute("type", attribType)
		if attribKey then
			action:SetAttribute(attribKey, attribValue)
		end

		-- special case for equipslot: change /equipslot slot to /use slot (but leave attribKey/Value alone)
		if attribClass == "equipslot" then
			local slot = attribValue:match("/equipslot (%d+) ")
			if slot then
				action:SetAttribute("macrotext", "/use " .. slot)
			end
		end

		return true
	end
end
