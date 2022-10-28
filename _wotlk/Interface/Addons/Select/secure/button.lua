-- button.lua handles the buttons placed on flyouts

local _,s = ...
s.button = {}

-- creates a new button; calling function will need to position it
function s.button:Create(flyout)
    local button = CreateFrame("Button",nil,flyout,"SecureActionButtonTemplate")
    button:SetSize(36,36)
    button.icon = button:CreateTexture(nil,"BACKGROUND")
    button.border = button:CreateTexture(nil,"BORDER")
    button.border:SetAllPoints(true)
    button.count = button:CreateFontString(nil,"BORDER","NumberFontNormal")
    button.count:SetJustifyH("RIGHT")
    button.count:SetPoint("BOTTOMRIGHT",-3,3)
    button.selected = button:CreateTexture(nil,"ARTWORK")
    button.selected:SetAllPoints(true)
    button.selected:SetBlendMode("ADD")
    button.highlight = button:CreateTexture(nil,"HIGHLIGHT")
    button.highlight:SetAllPoints(true)
    button.highlight:SetBlendMode("ADD")
    button.cooldown = CreateFrame("Cooldown",nil,button,"CooldownFrameTemplate")
    button.cooldown:SetAllPoints(true)

    s.button:Style(button) -- sets style depending on UseFlatStyle settings

    button:RegisterForClicks("AnyUp","AnyDown")

    button:SetScript("OnHide",s.button.OnHide)
    button:SetScript("OnMouseDown",s.button.OnMouseDown)
    button:SetScript("OnMouseUp",s.button.OnMouseUp)
    button:SetScript("OnEnter",s.button.OnEnter)
    button:SetScript("OnLeave",s.button.OnLeave)

    s.button.OnHide(button) -- reset visuals on newly created button

    -- where the magic happens: pre-click wrap handler will hide parent flyout and copy the
    -- button's attributes to the action button further up the parent chain. if an option is
    -- set to use a flyout button as it's clicked, or while alt is held, that's done because
    -- of the alt-type* or type2 attributes of the buttons
    SecureHandlerWrapScript(button,"OnClick",button,[[
        local flyout = self:GetParent()
        local action = flyout:GetParent():GetParent()
        local root = action:GetParent()

        flyout:Hide() -- hide opened flyout

        -- if Use But Don't Select with Alt (or Right Click) is enabled, leave immediately, don't select
        if root:GetAttribute("DontSelectWithAlt") and (IsAltKeyDown() or (button=="RightButton" and root:GetAttribute("UseOnRightClick"))) then
            return
        end

        local attribClass = self:GetAttribute("attribClass")
        local attribType = self:GetAttribute("attribType")
        local attribKey = self:GetAttribute("attribKey")
        local attribValue = self:GetAttribute("attribValue")

        -- don't select an empty button
        if not attribClass or attribClass=="empty" then
            return
        end

        -- copy attributes to action
        action:SetAttribute("attribClass",attribClass)
        action:SetAttribute("attribType",attribType)
        action:SetAttribute("attribKey",attribKey)
        action:SetAttribute("attribValue",attribValue)

        -- copy attributes to flyout also for persistence (remember for state changes)
        flyout:SetAttribute("attribClass",attribClass)
        flyout:SetAttribute("attribType",attribType)
        flyout:SetAttribute("attribKey",attribKey)
        flyout:SetAttribute("attribValue",attribValue)

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

    ]])

    return button
end

-- resets button to hide extra stuff
function s.button:OnHide()
    self.count:Hide()
    self.selected:Hide()
    self.cooldown:Hide()
    self.icon:SetVertexColor(1,1,1)
end

function s.button:OnMouseDown()
    if s.settings:Get("UseFlatStyle") then
        self.icon:SetVertexColor(0.5,0.5,0.5)
    else
        self.border:SetTexture("Interface\\Buttons\\UI-Quickslot-Depress")
        self.border:SetTexCoord(0,1,0,1)
        self.border:SetVertexColor(1,1,1)
    end
end

function s.button:OnMouseUp()
    if s.settings:Get("UseFlatStyle") then
        self.icon:SetVertexColor(1,1,1)
    else
        s.button:SetBorder(self,self.forRarity,self.rarity)
        self.icon:SetVertexColor(1,1,1)
    end
end

function s.button:OnEnter()
    GameTooltip:SetOwner(self,"ANCHOR_LEFT")
    s.tooltip:Set(self)
end

function s.button:OnLeave()
    GameTooltip:Hide()
end

-- the button.border texture doubles as a rarity border and pushed texture, use this to set the border
-- and call it again with button.forRarity, button.rarity to return to its previous set
function s.button:SetBorder(button,forRarity,rarity)
    button.forRarity = forRarity
    button.rarity = rarity
    local useFlatStyle = s.settings:Get("UseFlatStyle")

    if useFlatStyle then
        button.border:SetTexture("Interface\\AddOns\\Select\\media\\border")
        button.border:SetTexCoord(0,0.28125,0,0.28125)
    else
        if forRarity then
            button.border:SetTexture("Interface\\Common\\WhiteIconFrame")
            button.border:SetTexCoord(0,1,0,1)
        else
            button.border:SetTexture("Interface\\Buttons\\UI-Quickslot2")
            button.border:SetTexCoord(0.1875,0.796875,0.1875,0.796875) -- 12/64,51/64,12/64,51/64
        end        
    end

    if forRarity and BAG_ITEM_QUALITY_COLORS[rarity] then
        button.border:SetVertexColor(BAG_ITEM_QUALITY_COLORS[rarity].r, BAG_ITEM_QUALITY_COLORS[rarity].g, BAG_ITEM_QUALITY_COLORS[rarity].b)
    elseif useFlatStyle then
        button.border:SetVertexColor(0.33,0.33,0.33)
    else
        button.border:SetVertexColor(1,1,1)
    end
end

-- this updates the unsecure bits on a button: icon, count, cooldown, rarity, etc from its attributes
-- (wait to call this until the flyout's OnShow; doesn't need to be called after every s:FillFlyout)
function s.button:UpdateDisplay(button)
    local attribClass = button:GetAttribute("attribClass")
    local attribValue = button:GetAttribute("attribValue")

    -- highlight button with selected texture (yellow border) if this is the currently-selected item or spell for the flyout
    -- (equisplot selection will be handled separately)
    if attribClass~="equipslot" and attribClass==button:GetParent():GetAttribute("attribClass") and attribValue==button:GetParent():GetAttribute("attribValue") then
        button.selected:Show()
    end

    if attribClass=="item" then
        local _,_,rarity,_,_,_,_,_,_,icon = GetItemInfo(attribValue)
        button.icon:SetTexture(icon)
        rarity = s.cache:Get("rarity")[attribValue] or rarity
        s.button:SetBorder(button,true,rarity)
        local count = GetItemCount(attribValue)
        if count>1 then
            button.count:SetText(count)
            button.count:Show()
        end
        local itemID = tonumber(attribValue:match("item:(%d+)"))
        if itemID then
            CooldownFrame_Set(button.cooldown,GetItemCooldown(itemID))
        end
    elseif attribClass=="spell" or attribClass=="mount" or attribClass=="profession" then
        button.icon:SetTexture(GetSpellTexture(attribValue))
        button.count:SetText(attribValue)
        s.button:SetBorder(button,false)
        if attribValue then
            CooldownFrame_Set(button.cooldown,GetSpellCooldown(attribValue))
        end
    elseif attribClass=="equipslot" then
        local slot,itemID = (attribValue or ""):match("/equipslot (%d+) (.+)")
        if itemID then
            -- doing separate "selected" for equipslot to only choose actually-equipped item
            if button:GetParent():GetAttribute("attribClass")=="equipslot" then
                slot = tonumber(slot or "")
                local flyoutSlot = tonumber((button:GetParent():GetAttribute("attribValue") or ""):match("/equipslot (%d+) ") or "")
                if slot and slot==flyoutSlot and (GetInventoryItemLink("player",slot) or ""):match(itemID) then
                    button.selected:Show()
                end
            end
            local _,_,rarity,_,_,_,_,_,_,icon = GetItemInfo(itemID)
            rarity = s.cache:Get("rarity")[itemID] or rarity
            button.icon:SetTexture(icon)
            s.button:SetBorder(button,true,rarity)
            itemID = tonumber(attribValue:match("item:(%d+)")) -- need to pull out numerical itemID for cooldown
            if itemID then
                CooldownFrame_Set(button.cooldown,GetItemCooldown(itemID))
            end
        end
    elseif attribClass=="toy" then
        s.button:SetBorder(button,false)
        local itemID,_,_,_,icon = GetItemInfoInstant(attribValue)
        button.icon:SetTexture(icon)
        if itemID then
            CooldownFrame_Set(button.cooldown,GetItemCooldown(itemID))
        end
    elseif attribClass=="battlepet" then
        s.button:SetBorder(button,false)
        local name = attribValue:match("/summonpet (.+)")
        local speciesID = C_PetJournal.FindPetIDByName(name)
        if speciesID then
            local _,icon = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
            button.icon:SetTexture(icon)
        end
    elseif attribClass=="empty" then
        s.button:SetBorder(button,false)
        button.cooldown:Hide()
        button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end    
end

-- this updates the secure bits on a button: attribClass, attribType, attribKey, attribValue,
-- and the use attributes when the button is clicked. (the actual selecting happens in the
-- wrap that never changes and was defined when the button was created)
-- call this during s:FillFlyout; no need to call it again until next s:FillFlyout.
-- note: must not be InCombatLockdown before calling this (not checking in this function,
-- and assuming it's already checked)
function s.button:SetAttributes(button,attribClass,attribType,attribKey,attribValue)
    -- set attributes of the button to select (pass to the action button)
    s.utils:SetAttributes(button,attribClass,attribType,attribKey,attribValue)
    
    -- set the use attributes that determine if the item or spell is used while clicked
    if attribClass=="empty" then -- for "empty" buttons (when no results found)
        button:SetAttribute("type",nil)
        button:SetAttribute("type2",nil)
        button:SetAttribute("alt-type*",nil)
    elseif attribClass=="equipslot" then -- equipslot buttons always run their macro and ignore use options
        button:SetAttribute("type","macro")
        button:SetAttribute("type2",nil)
        button:SetAttribute("alt-type*",nil)
        button:SetAttribute("macrotext",attribValue)
    elseif s.settings:Get("UseWhenSelecting") then -- any click will use the item or spell
        button:SetAttribute("type",attribType)
        button:SetAttribute("type2",nil)
        button:SetAttribute("alt-type*",nil)
        button:SetAttribute(attribKey,attribValue)
    elseif s.settings:Get("UseOnRightClick") then -- right click or alt will use the item or spell
        button:SetAttribute("type",nil)
        button:SetAttribute("type2",attribType)
        button:SetAttribute("alt-type*",attribType)
        button:SetAttribute(attribKey.."2",attribValue)
        button:SetAttribute("alt-"..attribKey.."*",attribValue)
    else -- with no option enabled, only alt will use the item or spell as it's selecting
        button:SetAttribute("type",nil)
        button:SetAttribute("type2",nil)
        button:SetAttribute("alt-type*",attribType)
        button:SetAttribute("alt-"..attribKey.."*",attribValue)
    end
end

-- styles the button to be a normal WoW item button or a flat style depending on UseFlatStyle setting
function s.button:Style(button)
    if s.settings:Get("UseFlatStyle") then
        button.icon:SetTexCoord(0.075,0.925,0.075,0.925)
        button.icon:SetPoint("TOPLEFT",1,-1)
        button.icon:SetPoint("BOTTOMRIGHT",-1,1)

        button.highlight:SetTexture("Interface\\AddOns\\Select\\media\\border")
        button.highlight:SetTexCoord(0.5,0.78125,0,0.28125)
        button.highlight:SetVertexColor(0.5,0.75,1,0.75)

        button.selected:SetTexture("Interface\\AddOns\\Select\\media\\border")
        button.selected:SetTexCoord(0,0.28125,0.5,0.78125)
        button.selected:SetVertexColor(1,0.82,0)
    else
        button.icon:SetTexCoord(0.046875,0.953125,0.046875,0.953125)
        button.icon:SetPoint("TOPLEFT",2,-2)
        button.icon:SetPoint("BOTTOMRIGHT",-2,2)
        
        button.selected:SetTexture("Interface\\Buttons\\CheckButtonHilight")
        button.selected:SetTexCoord(0,1,0,1)
        button.selected:SetVertexColor(1,1,1)
   
        button.highlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
        button.highlight:SetTexCoord(0,1,0,1)
        button.highlight:SetVertexColor(1,1,1)
    end

end