-- macro.lua handles adding /click [btn:2]S000M;S000A to /select macros
-- while no secure stuff happens in this module, EditMacro can't happen in combat

local _,s = ...
s.macro = {}

local activeMacros = {} -- lookup table of macros currently containing a /select command: key=macro index (1-138), value=selectline in macro
local isUpdatingMacros = nil -- becomes true while macros updating to prevent triggering new events
local isModernClient = select(4,GetBuildInfo())>=100000

-- returns a table where key is a macro index and value is the selectline. the macro index is also the action index in the frame tree,
-- and S000M;S000A buttons are numbered from this index. if a macro is renamed so its index changes, so does its S000M;S000A buttons
function s.macro:GetActiveMacros()
    return activeMacros
end

-- takes a strsplit of a macro body and returns the selectline (and clickline if one exists)
local function getLines(...)
    local selectline
    for i=1,select("#",...) do
        local line = select(i,...)
        if line:match("^/select%s+[^%s]") then
            selectline = line:trim()
        elseif selectline and line:match("^/click ") then
            return selectline, line:trim() -- return selectline and first line that contains a /click after it
        end
    end
    return selectline -- no clickline to return if we reached here
end

-- go through each macro and if it has a /select, add/repair its /click [btn:2]S000M;S000A line.
-- also update activeMacros to reflect whether the macro index has a select (indexes and their selectline)
function s.macro:UpdateAllMacros(callback)
    if not isUpdatingMacros and not InCombatLockdown() then
        isUpdatingMacros = true -- potential EditMacros may trigger new calls to update macros, using this flag to prevent re-running
        for i=1,138 do
            local _,_,body = GetMacroInfo(i)
            if body and body:match("/select ") then -- this macro has a /select
                if select(4,GetBuildInfo())==100000 then -- annoyingly, in Dragonflight beta (but not ptr!) a button needs passed to /click to cast stuff
                    -- X should be LeftButton in theory, but that's too many characters and any single character works
                    clicklineFormat = "/click [btn:2]S%03dM;S%03dA X"
                else
                    clicklineFormat = "/click [btn:2]S%03dM;S%03dA"
                end
                local correctClickline = format(clicklineFormat,i,i)
                local selectline,clickline = getLines(strsplit("\n",body))
                local newBody -- if macro needs a new body it will go here
                if selectline then
                    if not clickline then
                        newBody = body:gsub(s.utils:GetEscapedText(selectline),selectline.."\n"..correctClickline)
                    elseif clickline ~= correctClickline then
                        newBody = body:gsub(s.utils:GetEscapedText(clickline),correctClickline)
                    end
                    local icon = isModernClient and 134400 or "INV_MISC_QUESTIONMARK"
                    if newBody then -- clickline added/changed, the macro's body needs to be changed
                        EditMacro(i,nil,icon,newBody)
                    else --if isModernClient then -- reasserting inv_misc_questionmark
                        EditMacro(i,nil,icon)
                    end
                    activeMacros[i] = selectline:match("/select%s+(.+)"):trim()
                else
                    activeMacros[i] = nil -- has /select but it's not the start of a line
                end
            else
                activeMacros[i] = nil -- does not have /select or has no macro
            end
        end
        isUpdatingMacros = nil
        if type(callback)=="function" then -- if function passed to run after macros are done updating, call it
            callback(s)
        end
    end
end

-- indexed by macro index, whether the macro in that index needs updated
local iconsToUpdate = {}

-- updates all macro icons, regardless of attribute changes (gear can change in /equipslot macros outside of state changes)
function s.macro:UpdateAllIcons()
    for index in pairs(s.macro:GetActiveMacros()) do
        s.macro:UpdateIcon(index)
    end
end

-- updates the icon of the macro at the given index; if this is called in response to OnAttributeChanged it could be among 4-6 calls in the same
-- execution thread, so this waits a frame before doing the actual update
function s.macro:UpdateIcon(index)
    if index and index>0 then
        iconsToUpdate[index] = true
        s.timer:Start(0,s.macro.UpdateNeededIcons)
    end
end

-- goes through all icons waiting to update and updates them
function s.macro:UpdateNeededIcons()
    local stillNeedsUpdated
    for index in pairs(iconsToUpdate) do
        local action = _G[format("S%03dA",index)]
        if action then
            local attribClass = action:GetAttribute("attribClass")
            local attribValue = action:GetAttribute("attribValue")
            local unit = action:GetAttribute("unit") -- set in state handler and action pre-click handler
            if attribClass=="item" then
                SetMacroItem(index,attribValue,unit)
            elseif attribClass=="spell" or attribClass=="mount" or attribClass=="profession" then
                if tonumber(attribValue) then -- if spell:id and not named spell
                    SetMacroSpell(index,(GetSpellInfo(attribValue)),unit)
                else
                    SetMacroSpell(index,attribValue,unit)
                end
            elseif attribClass=="equipslot" then
                --local itemID = attribValue:match("/equipslot %d+ (.+)")
                local slot = attribValue:match("/equipslot (%d+) ")
                if slot then
                    local itemID = (GetInventoryItemLink("player",slot) or ""):match("\124H(item:.-)\124h") 
                    SetMacroItem(index,itemID or "",unit)
                end
            elseif attribClass=="toy" then -- toys can't SetMacroItem to a name, it needs to be "item:itemID"
                local itemID = GetItemInfoInstant(attribValue)
                if itemID then
                    SetMacroItem(index,"item:"..itemID,unit)
                else -- itemID not found, come back later and try again
                    C_Timer.After(0.5,function() s.macro:UpdateIcon(index) end)
                end
            elseif attribClass=="battlepet" then
                SetMacroSpell(index,(GetSpellInfo(125439))) -- Revive Battle Pet icon
            elseif attribClass=="empty" then
                SetMacroSpell(index,"")
            end
        end
    end
    wipe(iconsToUpdate)
end
