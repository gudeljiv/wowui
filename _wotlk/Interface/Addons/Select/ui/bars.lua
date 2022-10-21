-- bars.lua handles modifications to action bars such as the yellow arrow on actionbutton mouseover and bar tooltips

local _,s = ...
s.bars = {}

-- a little arrow overlay to indicate the actionbar button beneath the mouse contains a select macro
s.bars.arrow = CreateFrame("Frame",nil,UIParent)
s.bars.arrow:SetSize(20,20)
s.bars.arrow.texture = s.bars.arrow:CreateTexture(nil,"OVERLAY")
s.bars.arrow.texture:SetAllPoints(true)
s.bars.arrow.texture:SetTexture("Interface\\Buttons\\Arrow-Up-Up")

local arrowHooks = {} -- table indexed by action button frame for hooks to show the above little arrow

function s.bars:SetAction(actionSlot)
    local actionType,index = GetActionInfo(actionSlot)
    if actionType=="macro" and index and s.macro:GetActiveMacros()[index] then
        local focus = GetMouseFocus()
        if focus then
            local actionID = focus:GetAttribute("action") or focus.action
            if actionID and actionID==actionSlot then -- at this point we're positive mouse is over an actionbar button that contains a macro
                local action = _G[format("S%03dA",index)]
                if action then -- and there's a /select within this macro
                    s.tooltip:Set(action)
                    if GetCVarBool("UberTooltips") then -- if cvar enabled for expanded tooltips
                        -- for actionbar macro tooltip, add the /select macro name
                        local macroName = (GetMacroInfo(index) or ""):trim()
                        if macroName and macroName~="" then
                            GameTooltip:AddLine(format("\124cff88bbffSelect macro:\124r %s",macroName))
                        end
                        if not s.settings:Get("DontAddToMacroTooltip") then
                            local menu = _G[format("S%03dM",index)]
                            if menu then
                                local activeList = (menu:GetAttribute("activelist") or ""):trim()
                                if activeList then
                                    GameTooltip:AddLine(format("\124cff88bbffSelect from:\124r %s",activeList),0.85,0.85,0.85,1)
                                end
                            end
                        end
                        GameTooltip:Show()

                        -- if we've not added a hook to show the arrow for this button, create one
                        if not arrowHooks[focus] then
                            arrowHooks[focus] = 1
                            focus:HookScript("OnEnter",s.bars.OnEnter)
                            focus:HookScript("OnLeave",s.bars.OnLeave)
                            s.bars.OnEnter(focus)
                        end

                    end
                end
            end
        end
    end
end

-- when GameTooltip:SetAction is used, check if that action slot has a S000A macro and generate a tooltip for that if so
hooksecurefunc(GameTooltip,"SetAction",s.bars.SetAction)

-- this displays the little yellow arrow over action buttons that contain /select macros
function s.bars:OnEnter()
	local action = self:GetAttribute("action") or self.action
	if action then
        local actionType,index = GetActionInfo(action)
        if actionType=="macro" and s.macro:GetActiveMacros()[index] then
            s.bars.arrow:ClearAllPoints()
            s.bars.arrow:SetParent(self)
            local actionButton = s.root.actions[index]
            local direction = "up" -- most of the time arrow will point up
            -- if there's a direction defined, it's an attribute of the currently flyout based on menu's state
            if actionButton and actionButton.menu:GetAttribute("activelist") then
                local flyout = s.root.flyouts[actionButton.menu:GetAttribute("activelist")]
                if flyout and flyout:GetAttribute("direction") then
                    direction = flyout:GetAttribute("direction")
                end
            end
            if direction=="up" then
                s.bars.arrow.texture:SetTexCoord(0,1,0,1) -- no rotation
                s.bars.arrow:SetPoint("TOP",self,"TOP",1,11)
            elseif direction=="down" then
                s.bars.arrow.texture:SetTexCoord(0,1,1,0) -- 180 degree rotation
                s.bars.arrow:SetPoint("BOTTOM",self,"BOTTOM",1,-11)
            elseif direction=="left" then
                s.bars.arrow.texture:SetTexCoord(1,0,0,0,1,1,0,1) -- 270 (-90) degree rotation
                s.bars.arrow:SetPoint("LEFT",self,"LEFT",-11,1)
            elseif direction=="right" then -- 90 degree rotation
                s.bars.arrow.texture:SetTexCoord(0,1,1,1,0,0,1,0)
                s.bars.arrow:SetPoint("RIGHT",self,"RIGHT",11,-1)
            end
			s.bars.arrow:Show()
		end
	end
end

-- this hides the little yellow arrow over action buttons that contain /select macros
function s.bars:OnLeave(self)
	s.bars.arrow:Hide()
end
