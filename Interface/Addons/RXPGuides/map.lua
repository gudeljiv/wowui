local addonName = ...

local HBD = LibStub("HereBeDragons-2.0")
local HBDPins = LibStub("HereBeDragons-Pins-2.0")
RXP_.activeWaypoints = {}
--local colors = RXP_.colors

RXP_.arrowFrame = CreateFrame("Frame","RXPG_ARROW",UIParent)
local af = RXP_.arrowFrame
af:SetMovable(true)
af:EnableMouse(1)
af:SetClampedToScreen(true)
af:SetSize(32,32)
af.texture = af:CreateTexture()
af.texture:SetAllPoints()
af.texture:SetTexture(RXP_.GetTexture("rxp_navigation_arrow-1"))
--af.texture:SetScale(0.5)
af.text = af:CreateFontString(nil,"OVERLAY")
af.text:SetTextColor(1,1,1,1)
af.text:SetFont(RXP_.font, 9)--,"OUTLINE")
af.text:SetJustifyH("CENTER")
af.text:SetJustifyV("CENTER")
af.text:SetPoint("TOP",af,"BOTTOM",0,-5)
af.orientation = 0
af.distance = 0
af.lowerbound = math.pi/32 --angle in radians
af.upperbound = 2*math.pi-af.lowerbound

af:SetPoint("TOP")
af:Hide()

af:SetScript("OnMouseDown", function(self, button)
    if not RXPData.lockFrames then
        af:StartMoving()
    end
end)
af:SetScript("OnMouseUp", function(self,button)
    af:StopMovingOrSizing()
end)

function RXP_.UpdateArrow(self)

    if RXPData.disableArrow or not self then
        return
    end


    if self.element then
        local x,y,instance = HBD:GetPlayerWorldPosition()
        local angle,dist = HBD:GetWorldVector(instance, x, y, self.element.wx,self.element.wy)
        local facing = GetPlayerFacing()
        if not (dist and facing) then return end
        local orientation = angle-facing
        local diff = math.abs(orientation-self.orientation)
        dist = math.floor(dist)

        if diff > self.lowerbound and diff < self.upperbound or self.forceUpdate then
            self.orientation = orientation
            self.texture:SetRotation(orientation)
            self.forceUpdate = false
        end

        if dist ~= self.distance then
            self.distance = dist
            self.text:SetText(string.format("Step %d\n(%dyd)",self.element.step.index,dist))
        end
    end


end


RXP_.arrowFrame:SetScript("OnUpdate",RXP_.UpdateArrow)

function RXP_.UpdateGotoSteps()
    if #RXP_.activeWaypoints == 0 then
        af:Hide()
        return
    end
    for i,element in ipairs(RXP_.activeWaypoints) do
        if element.step.active then

            if element.radius and element.arrow and not(element.parent and (element.parent.completed or element.parent.skip) and not element.parent.textOnly) and not element.skip then
                local x,y,instance = HBD:GetPlayerWorldPosition()
                local angle,dist = HBD:GetWorldVector(instance, x, y, element.wx,element.wy)
                if not dist then return end
                if dist <= element.radius then
                    element.skip = true
                    RXP_.updateMap = true
                    RXP_.SetElementComplete(element.frame)
                end
            end
        end
    end
end

-- The Frame Pool that will manage pins on the world and mini map
-- You must use a frame pool to aquire and release pin frames,
-- otherwise the pins will not be properly removed from the map. 
local MapPinPool = {}

MapPinPool.create = function()
    local framePool = CreateFramePool()
    framePool.creationFunc = MapPinPool.creationFunc
    framePool.resetterFunc = MapPinPool.resetterFunc

    return framePool
end

-- Create the Frame with the Frame Pool.
-- 
-- Because you cannot pass the pin data to the Frame Pool when acquiring a frame,
-- the frame is given a "render" function that can be used to bind the corect data 
-- to the frame
MapPinPool.creationFunc = function(framePool)
    local f = CreateFrame("Button", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")

    -- Styling
    f:SetBackdrop({
        bgFile = "Interface\\Addons\\" .. addonName .. "\\Textures\\white_circle",
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    f:SetWidth(0)
    f:SetHeight(0)
    f:EnableMouse()
    f:SetMouseClickEnabled(false)
    f:Hide()

    -- Active Step Indicator (A Target Icon)
    f.inner = CreateFrame("Button", nil, f, BackdropTemplateMixin and "BackdropTemplate")
    f.inner:SetBackdrop({
       bgFile = "Interface\\Addons\\" .. addonName .. "\\Textures\\map_active_step_target_icon",
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    f.inner:SetPoint("CENTER", 0, 0)
    f.inner:EnableMouse()

    -- Text
    f.text = f.inner:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    f.text:SetTextColor(unpack(RXP_.colors.mapPins))
    f.text:SetFont(RXP_.font, 14,"OUTLINE") 

    -- Renders the Pin with Step Information
    f.render = function(pin, isMiniMapPin)
        local step = pin.elements[1].step
        local stepIndex = pin.elements[1].step.index
        
        local r = f.text:GetTextColor()
        if r ~= RXP_.colors.mapPins[1] then
            f.text:SetTextColor(unpack(RXP_.colors.mapPins))
        end
        if table.getn(pin.elements) > 1 then
            f.text:SetText(stepIndex .. "+")
        else
            f.text:SetText(stepIndex)
        end
        
        
        if RXPData.mapCircle and not isMiniMapPin then
            local size = math.max(f.text:GetWidth(), f.text:GetHeight()) + 8

            if step.active then
                f:SetAlpha(1)
                f:SetWidth(size + 3)
                f:SetHeight(size + 3)
                f:SetBackdropColor(0.0, 0.0, 0.0, RXPData.worldMapPinBackgroundOpacity)
                f.inner:SetBackdropColor(1, 1, 1, 1)
                f.inner:SetWidth(size + 3)
                f.inner:SetHeight(size + 3)

                f.text:SetFont(RXP_.font, 14,"OUTLINE")
            else
                f:SetBackdropColor(0.1, 0.1, 0.1, RXPData.worldMapPinBackgroundOpacity)
                f:SetWidth(size)
                f:SetHeight(size)

                f.inner:SetBackdropColor(0, 0, 0, 0)

                f.text:SetFont(RXP_.font, 9,"OUTLINE")
            end
            f.inner:SetPoint("CENTER", f, 0, 0)
            f.inner:SetWidth(size)
            f.inner:SetHeight(size)
            f.text:SetPoint("CENTER", f, 0, 0)
            f:SetScale(RXPData.worldMapPinScale)
            f:SetAlpha(pin.opacity)
        else
            if step.active and not isMiniMapPin then
                f:SetAlpha(1)
                f:SetBackdropColor(0.0, 0.0, 0.0, RXPData.worldMapPinBackgroundOpacity)
                f.inner:SetBackdropColor(1, 1, 1, 1)
                f.inner:SetWidth(8 + 3)
                f.inner:SetHeight(8 + 3)

                f.text:SetFont(RXP_.font, 14,"OUTLINE")
            else
                local bgAlpha = isMiniMapPin and 0 or RXPData.worldMapPinBackgroundOpacity
                f:SetBackdropColor(0.1, 0.1, 0.1, bgAlpha)

                f.inner:SetBackdropColor(0, 0, 0, 0)

                f.text:SetFont(RXP_.font, 9,"OUTLINE")
            end
            f:SetWidth(f.text:GetStringWidth() + 3)
            f:SetHeight(f.text:GetStringHeight() + 5)
            
            f.inner:SetPoint("CENTER", f, 0, 0)
            f.inner:SetWidth(1)
            f.inner:SetHeight(1)
            f.text:SetPoint("CENTER", f, 0, 0)
            f:SetScale(RXPData.worldMapPinScale)
            f:SetAlpha(pin.opacity)
        end

        -- Mouse Handlers
        f:SetScript("OnEnter",function(self)
            if self:IsForbidden() or GameTooltip:IsForbidden() then return end
            GameTooltip:SetOwner(f, "ANCHOR_RIGHT",0,0)
            GameTooltip:ClearLines()

            for i,element in pairs(pin.elements) do
                local text
                if element.parent then
                    text =  element.parent.tooltipText
                elseif not element.hideTooltip then
                    text = element.tooltipText
                end
                text = text or RXP_.MainFrame.Steps.frame[element.step.index].text:GetText()
                GameTooltip:AddLine("Step "..element.step.index,unpack(RXP_.colors.mapPins))
                GameTooltip:AddLine(text)
            end

            GameTooltip:Show()
        end)

        f:SetScript("OnLeave",function(self)
            if self:IsForbidden() or GameTooltip:IsForbidden() then return end
            GameTooltip:Hide()
        end)

    end    

  return f
end

-- Hides and disables the Frame when it is released
MapPinPool.resetterFunc = function(framePool, frame)
    frame:SetHeight(0)
    frame:SetWidth(0)
    frame:Hide()
    frame:EnableMouse(0)
end

local worldMapFramePool = MapPinPool.create()
local miniMapFramePool = MapPinPool.create()

-- Calculates if a given element is close to any other provided pins
local function elementIsCloseToOtherPins(element, pins, isMiniMapPin)
    local overlap = RXPData.distanceBetweenPins or 1
    local pinDistanceMod,pinMaxDistance = 0,0
    if isMiniMapPin then
        pinMaxDistance = 25
    else
        pinDistanceMod = 5e-5*overlap^2
        pinMaxDistance = 60*overlap
    end
    for i, pin in ipairs(pins) do
        for j, pinElement in ipairs(pin.elements) do
            if not (pinElement.optional or element.optional) then
                local relativeDist,dist,dx,dy
                if element.instance == pinElement.instance then
                    dist,dx,dy = HBD:GetWorldDistance(pinElement.instance, pinElement.wx, pinElement.wy, element.wx, element.wy)
                end
                if not isMiniMapPin then
                    local zx, zy = HBD:GetZoneSize(pin.zone)
                    if dx ~= nil and zx ~= nil then
                        relativeDist = (dx/zx)^2 + (dy/zy)^2
                    end
                    if (relativeDist and relativeDist < pinDistanceMod) or (dist and dist < pinMaxDistance) then
                        return true, pin
                    end
                elseif dist and dist < pinMaxDistance then
                    return true, pin
                end
                
            end
        end
    end

    return false
end

-- Creates a list of Pin data structures.
--
-- All of the filtering and combining of steps and elements by proximity
-- is done in this step up front. Then the pins are rendered as WoW Frames 
-- using the MapPinPool.
local function generatePins(steps, numPins, startingIndex, isMiniMap)
    local pins = {}
    local numActivePins = 0
    local numSteps = table.getn(steps)
    local activeSteps = RXP_.MainFrame.CurrentStepFrame.activeSteps
    
    local numActive = 0
    
    local function GetNumPins(step)
        if step then
            for _,element in pairs(step.elements) do
                if element.tag == "goto" and not element.optional then
                    numActive = numActive + 1
                end
            end
        end
    end
    
    for _,step in pairs(activeSteps) do
        GetNumPins(step)
    end
    
    for i = RXPCData.currentStep+1,RXPCData.currentStep+numPins do
        GetNumPins(RXP_.currentGuide.steps[i])
    end
    
    if numPins < numActive then
        numPins = numActive
    end
    
    -- Loop through the steps until we create the number of pins a user 
    -- configures or until we reach the end of the current guide.
    
    local function ProcessMapPin(step)    
        -- Loop through the elements in each step. Again, we check if we
        -- already created enough pins, then we check if the element
        -- should be included on the map. 
        --
        -- If it should be, we calculate whether the element is close to 
        -- other pins. If it is, we add the element to a previous pin. 
        --
        -- If it is far enough away, we add a new pin to the map.
        local j = 0;
        while numActivePins < numPins and j < table.getn(step.elements) do
            local element = step.elements[j + 1]

            if element.text and not element.label and not element.textOnly then
                element.label = tostring(step.index)
            end

            if element.zone and (not(element.parent and (element.parent.completed or element.parent.skip)) and not element.skip) then
                local closeToOtherPin, otherPin = elementIsCloseToOtherPins(element, pins, isMiniMap)

                if closeToOtherPin and not element.optional then
                    table.insert(otherPin.elements, element)
                else
                    local pinalpha = 0
                    if isMiniMapPin then
                        pinalpha = 0.5
                    elseif element.step and element.step.active then
                        pinalpha = 1
                    else
                        pinalpha = math.max(0.4, 1 - (table.getn(pins) * 0.05))
                    end
                    table.insert(pins, {
                        elements = {element}, 
                        opacity = pinalpha, 
                        instance = element.instance,
                        wx = element.wx,
                        wy = element.wy,
                        zone = element.zone,
                        hidePin = element.optional,
                    })
                end
                if not isMiniMap then
                    table.insert(RXP_.activeWaypoints, element)
                end
                if not element.optional then
                    numActivePins = numActivePins + 1
                end
            end

            j = j + 1
        end
    end    

    for _,step in pairs(activeSteps) do
        ProcessMapPin(step)
    end

    if not isMiniMap then
        local currentStep = steps[RXPCData.currentStep]
        if not (currentStep and currentStep.active) then
            ProcessMapPin(currentStep)
        end
        local i = 0;   
        while numActivePins < numPins and (startingIndex + i < numSteps) do
            i = i + 1
            local step = steps[startingIndex + i]
            ProcessMapPin(step)
        end
    end
    return pins
end

-- Generate pins using the current guide's steps, then add the pins to the world map
local function addWorldMapPins()
    -- Calculate which pins should be on the world map
    local pins = generatePins(RXP_.currentGuide.steps, 
        RXPData.numMapPins, 
        RXPCData.currentStep, 
        false
    )

    -- Convert each "pin" data structure into a WoW frame. Then add that frame to the world map
    for i = table.getn(pins), 1, -1 do
        local pin = pins[i]
        if not pin.hidePin then
            local element = pin.elements[1]
            local worldMapFrame = worldMapFramePool:Acquire()
            worldMapFrame.render(pin, false)
            HBDPins:AddWorldMapIconWorld(RXP_, worldMapFrame, element.instance, element.wx, element.wy, HBD_PINS_WORLDMAP_SHOW_CONTINENT)
        end
    end
end

-- Generate pins using only the active steps, then add the pins to the Mini Map
local function addMiniMapPins(pins)
    if RXPData.hideMiniMapPins then return end
    -- Calculate which pins should be on the mini map
    local pins = generatePins(RXP_.currentGuide.steps, 
        RXPData.numMapPins, 
        RXPCData.currentStep, 
        true
    )

    -- Convert each "pin" data structure into a WoW frame. Then add that frame to the mini map
    for i = table.getn(pins), 1, -1 do
        local pin = pins[i]
        local element = pin.elements[1]
        local miniMapFrame = miniMapFramePool:Acquire()
        miniMapFrame.render(pin, true)
        HBDPins:AddMinimapIconWorld(RXP_, miniMapFrame, element.instance, element.wx, element.wy, true, true)
    end
end

-- Updates the arrow
local function updateArrow()
    for i,element in ipairs(RXP_.activeWaypoints) do
        if element.arrow and element.step.active and 
        not(element.parent and (element.parent.completed or element.parent.skip)) and not(element.text and (element.completed or element.skip) and not element.skip) then
            af:SetShown(not RXPData.disableArrow)
            af.dist = 0
            af.orientation = 0
            af.element = element
            af.forceUpdate = true
            return
        end
    end

    af:Hide()
end

-- Removes all pins from the map and mini map and resets all data structrures
local function resetMap()
    RXP_.activeWaypoints = {}
    RXP_.updateMap = false
    HBDPins:RemoveAllMinimapIcons(RXP_)
    HBDPins:RemoveAllWorldMapIcons(RXP_)
    worldMapFramePool:ReleaseAll()
    miniMapFramePool:ReleaseAll()
end

function RXP_.UpdateMap()
    if RXP_.currentGuide == nil then return end

    resetMap()
    addWorldMapPins()
    addMiniMapPins()
    updateArrow()
end
