-- root.lua contains the base frame in the secure frame heiarchy and also contains UpdateSecureFrames()
-- which handles to setup of this heiarchy

local _,s = ...

-- this frame is a secure frame that serves as the topmost frame in the heiarchy: root <- action <- menu <- flyout <- button
-- it also has as attributes global settings that descended frames can get in a security environment
s.root = CreateFrame("Button",nil,UIParent,"SecureHandlerBaseTemplate")

s.root.actions = {} -- actions will be stored here, indexed by the macro index
s.root.flyouts = {} -- flyouts will be stored herer, indexed by their list ("item1, item2, spell:etc")

-- this is called from UPDATE_MACROs in s.main, and creates any needed secure frames due to macro changes
function s.root:UpdateSecureFrames()

    local activeMacros = s.macro:GetActiveMacros() -- indexed by macro index, the /selectline if it contains a /select

    -- first flag all flyouts as inactive
    for _,flyout in pairs(s.root.flyouts) do
        flyout.inactive = true
    end

    for index,selectline in pairs(activeMacros) do
        -- if action doesn't exist, create action and menu
        if not s.root.actions[index] then
            s.root.actions[index] = s.action:Create(index,selectline)
            s.root.actions[index].menu = s.menu:Create(s.root.actions[index])
        end

        -- create flyouts that haven't already been made
        for _,list in pairs({strsplit(";",selectline)}) do
            list = list:gsub("%[.-%]",""):trim() -- remove [condition] text from sublist and trim whitespace
            -- create new flyouts for each distinct list
            if string.len(list)>0 then
                if not s.root.flyouts[list] then -- flyout has not been made yet
                    s.root.flyouts[list] = s.flyout:Create(list) -- create flyout for this list
                else
                    s.root.flyouts[list].inactive = nil -- flyout is still used, clear its inactive flag
                end
            end
        end

        -- newly created flyouts have no default attribute; that will be handled in fillmissing

        -- if selectline has changed, update menu's state driver
        if s.root.actions[index]:GetAttribute("selectline")~=selectline then
            s.root.actions[index]:SetAttribute("selectline",selectline)
            s.menu:UpdateStateDriver(s.root.actions[index])
        end

        -- now that flyouts are created, fill the action with the menu state's current flyout's selected state, if any
        s.action:Fill(s.root.actions[index])
    end

end

-- find any flyouts or actions with missing attributes and fill them in; this should only happen out of combat and
-- after cache is data loaded; keep trying until both conditions are met
function s.root:FillMissing()
    if not InCombatLockdown() and s.cache:IsDataLoaded() then
        -- run LoadDefault on all flyouts (will do nothing if attributes already exist)
        for _,flyout in pairs(s.root.flyouts) do
            s.flyout:LoadDefault(flyout)
        end
        -- for any empty action, fill the action by loading attributes from the menu state's flyout
        for _,action in pairs(s.root.actions) do
            local attribClass = action:GetAttribute("attribClass")
            if not attribClass or attribClass=="empty" then
                s.action:Fill(action)
            end
        end
        s.macro:UpdateAllIcons()
    else
        C_Timer.After(0.5,s.root.FillMissing)
    end
end

