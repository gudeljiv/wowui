local _, helpers = ...
local Aptechka = Aptechka

local pixelperfect = helpers.pixelperfect

local LSM = LibStub("LibSharedMedia-3.0")

LSM:Register("statusbar", "Gradient", [[Interface\AddOns\Aptechka\gradient.tga]])
LSM:Register("font", "ClearFont", [[Interface\AddOns\Aptechka\ClearFont.ttf]], GetLocale() ~= "enUS" and 15)

--[[
2 shield icon border
0 shield icon texture
0 normal icon texture
0 corner indicators
0 text3 fontstring

-2 status bar bg
-2 debuff type texture
-4 absorb sidebar fg
-5 absorb sidebar bg
-5 absorb checkered fill
-5 incoming healing
-5 heal absorb checkered
-6 healthbar
-6 powerbar
-8 powerbar bg
-8 healthbar bg
]]

local MakeBorder = function(self, tex, left, right, top, bottom, level)
    local t = self:CreateTexture(nil,"BORDER",nil,level)
    t:SetTexture(tex)
    t:SetPoint("TOPLEFT", self, "TOPLEFT", left, -top)
    t:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -right, bottom)
    return t
end


local function multiplyColor(mul, r,g,b,a)
    return r*mul, g*mul, b*mul, a
end

local HealthBarSetColorFG = function(self, r,g,b,a, mul)
    self:SetStatusBarColor(r*mul, g*mul, b*mul, a)
end
local HealthBarSetColorBG = function(self, r,g,b,a, mul)
    self:SetVertexColor(r*mul, g*mul, b*mul, a)
end

local formatMissingHealth = function(text, mh)
    if mh < 1000 then
        text:SetFormattedText("-%d", mh)
    elseif mh < 10000 then
        text:SetFormattedText("-%.1fk", mh / 1e3)
    else
        text:SetFormattedText("-%.0fk", mh / 1e3)
    end
end

local SetJob_HealthBar = function(self, job)
    local c
    if job.classcolor then
        c = self.parent.classcolor
    elseif job.color then
        c = job.color
    end
    if c then
        local r,g,b,a = unpack(c)
        local mulFG = Aptechka.db.fgColorMultiplier or 1
        local mulBG = Aptechka.db.bgColorMultiplier or 0.2
        self:SetColor(r,g,b,a,mulFG)
        self.bg:SetColor(r,g,b,a,mulBG)
    end
end
local OnDead = function(self)
    self.power:Hide()
end
local OnAlive = function(self)
    if not self.power.disabled then
        self.power:Show()
    else
        self.power:Hide()
    end
end
local PowerBar_OnPowerTypeChange = function(powerbar, powerType, isDead)
    local self = powerbar:GetParent()
    powerType = powerType or self.power.powerType
    self.power.powerType = powerType

    local isVertical = Aptechka.db.healthOrientation == "VERTICAL"
    if powerType ~= "MANA" or isDead then
        self.power.disabled = true
        self.power:Hide()
        if isVertical then
            -- self.health:SetPoint("TOPLEFT", self, "TOPLEFT",0,0)
            self.health:SetPoint("TOPRIGHT", self, "TOPRIGHT",0,0)
        else
            -- self.health:SetPoint("TOPLEFT", self, "TOPLEFT",0,0)
            self.health:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT",0,0)
        end
    else
        self.power.disabled = nil
        self.power:Show()
        if isVertical then
            self.health:SetPoint("TOPLEFT", self, "TOPLEFT",0,0)
            self.health:SetPoint("TOPRIGHT", self.power, "TOPLEFT",0,0)
        else
            self.health:SetPoint("TOPLEFT", self, "TOPLEFT",0,0)
            self.health:SetPoint("BOTTOMLEFT", self.power, "TOPLEFT",0,0)
        end
    end

    -- if self.healfeedbackpassive then
    --     self.healfeedbackpassive:ClearAllPoints()
    --     if self.power:IsShown() and Aptechka.db.healthOrientation == "VERTICAL" then
    --         self.healfeedbackpassive:SetPoint("TOPRIGHT", self.power, "TOPLEFT", 0,0)
    --     else
    --         self.healfeedbackpassive:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0,0)
    --     end
    -- end
end
local SetJob_Indicator = function(self,job)
    if job.showDuration then
        self.cd:SetReverse(not job.reverseDuration)
        self.cd:SetCooldown(job.expirationTime - job.duration,job.duration,0,0)
        self.cd:Show()
    elseif job.showStacks then
        local stime = 300
        local completed = (job.showStacks - job.stacks) * stime
        local total = job.showStacks * stime
        local start = GetTime() - completed
        self.cd:SetReverse(true)
        self.cd:SetCooldown(start, total)
    else
        self.cd:Hide()
    end

    local color
    if job.foreigncolor and job.isforeign then
        color = job.foreigncolor
    else
        color = job.color or { 1,1,1,1 }
    end
    self.color:SetVertexColor(unpack(color))

    if job.fade then
        if self.traceJob ~= job or not self.blink:IsPlaying() then


            if self.blink:IsPlaying() then
                self.blink:Stop()
                if self.traceJob ~= job then
                    self.jobs[self.traceJob] = nil
                end
            end
            self.traceJob = job
            -- if job.noshine then
            --     self.blink.a2:SetChange(1)
            -- else
                self.blink.a2:SetFromAlpha(1)
                self.blink.a2:SetToAlpha(0)
            -- end
            self.blink.a2:SetDuration(job.fade)
            self.blink:Play()

        end
    else
        if self.traceJob then
            self.jobs[self.traceJob] = nil
            self.blink:Stop()
            self.traceJob = nil
        end
    end
    -- if job.pulse and (not self.currentJob or job.priority > self.currentJob.priority) then
        -- if not self.pulse:IsPlaying() then self.pulse:Play() end
    -- end
end

local CreateIndicator = function (parent,width,height,point,frame,to,x,y,nobackdrop)
    local f = CreateFrame("Frame",nil,parent)
    local w = pixelperfect(width)
    local h = pixelperfect(height)
    local border = pixelperfect(2)

    f:SetWidth(w); f:SetHeight(h);
    if not nobackdrop then
    f:SetBackdrop{
        bgFile = "Interface\\BUTTONS\\WHITE8X8", tile = true, tileSize = 0,
        insets = {left = -border, right = -border, top = -border, bottom = -border},
    }
    f:SetBackdropColor(0, 0, 0, 1)
    end
    f:SetFrameLevel(6)
    local t = f:CreateTexture(nil,"ARTWORK")
    t:SetTexture[[Interface\BUTTONS\WHITE8X8]]
    t:SetAllPoints(f)
    f.color = t
    local icd = CreateFrame("Cooldown",nil,f, "CooldownFrameTemplate")
    icd.noCooldownCount = true -- disable OmniCC for this cooldown

        icd:SetEdgeTexture("Interface\\Cooldown\\edge");
        icd:SetSwipeColor(0, 0, 0);
        icd:SetDrawEdge(false);
        -- icd:SetDrawSwipe(true);
        icd:SetHideCountdownNumbers(true);


    icd:SetReverse(true)
    icd:SetAllPoints(f)
    f.cd = icd
    f:SetPoint(point,frame,to,x,y)
    f.parent = parent
    f.SetJob = SetJob_Indicator

    local pag = f:CreateAnimationGroup()
    local pa1 = pag:CreateAnimation("Scale")
    pa1:SetScale(2,2)
    pa1:SetDuration(0.2)
    pa1:SetOrder(1)
    local pa2 = pag:CreateAnimation("Scale")
    pa2:SetScale(0.5,0.5)
    pa2:SetDuration(0.8)
    pa2:SetOrder(2)

    f.pulse = pag

    local bag = f:CreateAnimationGroup()
    bag:SetLooping("NONE")
    local ba1 = bag:CreateAnimation("Alpha")
    ba1:SetFromAlpha(0)
    ba1:SetToAlpha(1)
    ba1:SetDuration(0.1)
    ba1:SetOrder(1)
    local ba2 = bag:CreateAnimation("Alpha")
    ba2:SetFromAlpha(1)
    ba2:SetToAlpha(0)
    ba2:SetDuration(0.7)
    ba2:SetOrder(2)
    bag.a2 = ba2

    bag:SetScript("OnFinished",function(ag)
        local self = ag:GetParent()
        ag:Stop()
        self:Hide()
        return Aptechka.FrameSetJob(self.parent, self.traceJob, false)
    end)
    f.blink = bag


    f.SetMinMaxValues = function(self, min, max )
        self._min = min
        self._max = max
    end
    f:SetMinMaxValues(0,1)
    f.SetValue = function(self, val)
        local duration = 259200 -- 3 days
        local progress = (val - self._min) / (self._max - self._min)
        local start = GetTime() - duration * progress
        self.cd:SetCooldown(start, duration,0,0)
    end

    f:Hide()
    return f
end


local SetJob_Corner = function(self,job)
    local color
    if job.foreigncolor and job.isforeign then
        color = job.foreigncolor
    else
        color = job.color or { 1,1,1,1 }
    end
    if job.pulse then
        -- UIFrameFlash(self, 0.15, 0.15, 1.2, true)
        if not self.pulse.done and not self.pulse:IsPlaying() then self.pulse:Play() end
    end
    self.color:SetVertexColor(unpack(color))

    if job.scale then
        self:SetScale(job.scale)
    else
        self:SetScale(1)
    end

    if job.fade then
        if (self.traceJob ~= job or not self.blink:IsPlaying()) or job.resetAnimation then

            if self.blink:IsPlaying() then
                self.blink:Stop()
                if self.traceJob ~= job then
                    self.jobs[self.traceJob] = nil
                end
            end
            self.traceJob = job
            self.blink.a2:SetFromAlpha(1)
            self.blink.a2:SetToAlpha(0)
            self.blink.a2:SetDuration(job.fade)
            self.blink:Play()

        end
    else
        if self.traceJob then
            self.jobs[self.traceJob] = nil
            self.blink:Stop()
            self.traceJob = nil
        end
    end

    -- if job.pulse and (not self.currentJob or job.priority > self.currentJob.priority) then
        -- if not self.pulse:IsPlaying() then self.pulse:Play() end
    -- end
end
local Corner_PulseAnimOnFinished = function(self)
    self.pulses = self.pulses + 1
    if self.pulses > 10 then
        local ag = self:GetParent()
        ag:Stop()
        ag.done = true
    end
end
local Corner_PulseAnimGroupOnPlay = function(ag)
    ag.a2.pulses = 0
end
local Corner_OnHide = function(self)
    self.pulse.done = false
end
local Corner_BlinkAnimOnFinished = function(ag)
    local self = ag:GetParent()
    ag:Stop()
    self:Hide()
    return Aptechka.FrameSetJob(self.parent, self.traceJob, false)
end
local CreateCorner = function (parent,w,h,point,frame,to,x,y, orientation, zOrderMod)
    local f = CreateFrame("Frame",nil,parent)
    f:SetWidth(w); f:SetHeight(h);

    zOrderMod = zOrderMod or 0

    local t = f:CreateTexture(nil,"ARTWORK", nil, 0+zOrderMod )
    t:SetTexture[[Interface\AddOns\Aptechka\corner]]
    if orientation == "BOTTOMLEFT" then
        -- (ULx,ULy,LLx,LLy,URx,URy,LRx,LRy);
        -- 00 1
        t:SetTexCoord(1,0,1,1,0,0,0,1)
    elseif orientation == "TOPRIGHT" then
        t:SetTexCoord(0,1,0,0,1,1,1,0)
    elseif orientation == "TOPLEFT" then
        t:SetTexCoord(1,1,0,1,1,0,0,0)
    end
    t:SetAllPoints(f)

    if point == "TOPRIGHT" then
        t:SetTexCoord(0,1,1,0)
    elseif point == "TOPLEFT" then
        t:SetTexCoord(1,0,1,0)
    elseif point == "BOTTOMLEFT" then
        t:SetTexCoord(1,0,0,1)
    end

    f.color = t
    f:SetPoint(point,frame,to,x,y)
    f.parent = parent
    f.SetJob = SetJob_Corner

    local bag = f:CreateAnimationGroup()
    bag:SetLooping("NONE")
    local ba1 = bag:CreateAnimation("Alpha")
    ba1:SetFromAlpha(0)
    ba1:SetToAlpha(1)
    ba1:SetDuration(0.1)
    ba1:SetOrder(1)
    local ba2 = bag:CreateAnimation("Alpha")
    ba2:SetFromAlpha(1)
    ba2:SetToAlpha(0)
    ba2:SetDuration(0.7)
    ba2:SetOrder(2)
    bag.a2 = ba2

    bag:SetScript("OnFinished", Corner_BlinkAnimOnFinished)
    f.blink = bag

    local pag = f:CreateAnimationGroup()
    pag:SetLooping("REPEAT")
    local pa1 = pag:CreateAnimation("Alpha")
    pa1:SetFromAlpha(1)
    pa1:SetToAlpha(0)
    pa1:SetDuration(0.15)
    pa1:SetOrder(1)
    local pa2 = pag:CreateAnimation("Alpha")
    pa2:SetFromAlpha(0)
    pa2:SetToAlpha(1)
    pa2:SetDuration(0.15)
    pa2:SetOrder(2)
    pag.a2 = pa2
    pa2:SetScript("OnFinished", Corner_PulseAnimOnFinished)

    pag:SetScript("OnPlay", Corner_PulseAnimGroupOnPlay)
    f.pulse = pag

    f:SetScript("OnHide", Corner_OnHide)

    f:Hide()
    return f
end


local StatusBarOnUpdate = function(self, time)
    self.OnUpdateCounter = (self.OnUpdateCounter or 0) + time
    if self.OnUpdateCounter < 0.05 then return end
    self.OnUpdateCounter = 0

    local timeLeft = self.expires - GetTime()

    if self.pandemic and timeLeft < self.pandemic then
        local color = self.currentJob.color
        -- self.pandot:Show()
        self:SetStatusBarColor(color[1]*0.75, color[2]*0.75, color[3]*0.75)
        self.pandemic = nil
    end

    self:SetValue(timeLeft)
end
local SetJob_StatusBar = function(self,job)
    local color
    if job.foreigncolor and job.isforeign then
        color = job.foreigncolor
    else
        color = job.color or { 1,1,1,1 }
    end

    if job.showStacks then
        self:SetMinMaxValues(0, job.showStacks)
        self:SetValue(job.stacks)
        self:SetScript("OnUpdate", nil)
        self:SetStatusBarColor(unpack(color))
    else
        self.expires = job.expirationTime
        local pandemic = job.refreshTime
        self.pandemic = pandemic
        self:SetMinMaxValues(0, job.duration)
        local timeLeft = self.expires - GetTime()
        if pandemic and pandemic >= timeLeft then
            self:SetStatusBarColor(color[1]*0.75, color[2]*0.75, color[3]*0.75)
        else
            self:SetStatusBarColor(unpack(color))
        end
        if not job.showDuration then
            self:SetMinMaxValues(0, 1)
            self:SetValue(1)
            self:SetScript("OnUpdate", nil)
        else
            self:SetValue(timeLeft)
            self:SetScript("OnUpdate", StatusBarOnUpdate)
        end
    end

    self.bg:SetVertexColor(color[1]*0.25, color[2]*0.25, color[3]*0.25)
    -- self.pandot:SetVertexColor(color[1]*0.6, color[2]*0.6, color[3]*0.6)
end
local CreateStatusBar = function (parent,width,height,point,frame,to,x,y,nobackdrop, isVertical)
    local f = CreateFrame("StatusBar",nil,parent)
    local w = pixelperfect(width)
    local h = pixelperfect(height)
    local border = pixelperfect(2)
    f:SetWidth(w); f:SetHeight(h);
    if not nobackdrop then
    f:SetBackdrop{
        bgFile = "Interface\\BUTTONS\\WHITE8X8", tile = true, tileSize = 0,
        insets = {left = -border, right = -border, top = -border, bottom = -border},
    }
    f:SetBackdropColor(0, 0, 0, 1)
    end
    f:SetFrameLevel(7)

    if isVertical then
        f:SetOrientation("VERTICAL")
    end

    f:SetStatusBarTexture[[Interface\BUTTONS\WHITE8X8]]
    -- f:SetMinMaxValues(0,100)
    -- f:SetStatusBarColor(1,1,1)

    local bg = f:CreateTexture(nil,"ARTWORK",nil,-2)
    bg:SetTexture[[Interface\BUTTONS\WHITE8X8]]
    bg:SetAllPoints(f)
    f.bg = bg


    -- local pandot = f:CreateTexture(nil, "ARTWORK", nil, -1)
    -- pandot:SetTexture[[Interface\BUTTONS\WHITE8X8]]
    -- pandot:SetWidth(pixelperfect(3))
    -- pandot:SetHeight(pixelperfect(3))
    -- pandot:SetPoint("CENTER", f, "RIGHT", -pixelperfect(4), 0)
    -- f.pandot = pandot

    f:SetPoint(point,frame,to,x,y)
    f.parent = parent
    f.SetJob = SetJob_StatusBar
    f:SetScript("OnUpdate", StatusBarOnUpdate)

    -- local pag = f:CreateAnimationGroup()
    -- local pa1 = pag:CreateAnimation("Scale")
    -- pa1:SetScale(2,2)
    -- pa1:SetDuration(0.2)
    -- pa1:SetOrder(1)
    -- local pa2 = pag:CreateAnimation("Scale")
    -- pa2:SetScale(0.5,0.5)
    -- pa2:SetDuration(0.8)
    -- pa2:SetOrder(2)

    -- f.pulse = pag

    f:Hide()
    return f
end
AptechkaDefaultConfig.GridSkin_CreateIndicator = CreateIndicator


--[[
local SetJob_RoundIndicator = function(self,job)
    local color
    if job.foreigncolor and job.isforeign then
        color = job.foreigncolor
    else
        color = job.color or { 1,1,1,1 }
    end
    self.color:SetVertexColor(unpack(color))
end
local CreateRoundIndicator = function (parent,width,height,point,frame,to,x,y)
    local ri = CreateFrame("Frame",nil, parent)
    ri:SetFrameLevel(7)
    ri:SetWidth(width); ri:SetHeight(height)
    ri:SetPoint(point,frame,to,x,y)
    local ritex = ri:CreateTexture(nil,"OVERLAY", nil, 2)
    ritex:SetAllPoints(ri)
    ritex:SetTexture("Interface\\AddOns\\Aptechka\\roundIndicator")
    ri.color = ritex

    ri:Hide()

    ri.SetJob = SetJob_RoundIndicator
    return ri
end
]]

local SetJob_Icon = function(self,job)
    if job.fade then self.jobs[job.name] = nil; return end
    if job.showDuration then
        self.cd:SetReverse(not job.reverseDuration)
        self.cd:SetCooldown(job.expirationTime - job.duration,job.duration)
        self.cd:Show()
    else
        self.cd:Hide()
    end
    self.texture:SetTexture(job.texture)

    if self.stacktext then
        if job.stacks then self.stacktext:SetText(job.stacks > 1 and job.stacks or "") end
    end
    -- if job.pulse and (not self.currentJob or job.priority > self.currentJob.priority) then
        -- if not self.pulse:IsPlaying() then self.pulse:Play() end
    -- end
end

local CreateShieldIcon = function(parent,w,h,alpha,point,frame,to,x,y)
    local icon = CreateFrame("Frame",nil,parent)
    icon:SetWidth(w); icon:SetHeight(h)
    icon:SetPoint(point,frame,to,x,y)
    icon:SetFrameLevel(7)

    local shield = icon:CreateTexture(nil, "ARTWORK", nil, 2)
    shield:SetTexture([[Interface\AchievementFrame\UI-Achievement-IconFrame]])
    shield:SetTexCoord(0,0.5625,0,0.5625)
    shield:SetWidth(h*1.8)
    shield:SetHeight(h*1.8)
    shield:SetPoint("CENTER", icon,"CENTER",0,0)
    -- shield:Hide()

    local icontex = icon:CreateTexture(nil,"ARTWORK")
    icontex:SetTexCoord(.1, .9, .1, .9)
    icontex:SetPoint("TOPLEFT",icon, "TOPLEFT",0,0)
    icontex:SetPoint("BOTTOMRIGHT",icon, "BOTTOMRIGHT",0,0)
    icontex:SetWidth(h);
    icontex:SetHeight(h);

    icon.texture = icontex
    icon:SetAlpha(alpha)

    local icd = CreateFrame("Cooldown",nil,icon, "CooldownFrameTemplate")
    icd.noCooldownCount = true -- disable OmniCC for this cooldown
    icd:SetReverse(true)
    icd:SetDrawEdge(false)
    icd:SetAllPoints(icontex)
    icon.cd = icd

    icon:Hide()

    icon.SetJob = SetJob_Icon

    return icon
end

local CreateIcon = function(parent,w,h,alpha,point,frame,to,x,y)
    w = pixelperfect(w)
    h = pixelperfect(h)

    local icon = CreateFrame("Frame",nil,parent)
    icon:SetWidth(w); icon:SetHeight(h)
    icon:SetPoint(point,frame,to,x,y)
    local icontex = icon:CreateTexture(nil,"ARTWORK")
    icontex:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    icon:SetFrameLevel(6)
    icontex:SetPoint("TOPLEFT",icon, "TOPLEFT",0,0)
    icontex:SetPoint("BOTTOMRIGHT",icon, "BOTTOMRIGHT",0,0)
    -- icontex:SetWidth(h);
    -- icontex:SetHeight(h);
    icon.texture = icontex
    icon:SetAlpha(alpha)

    local icd = CreateFrame("Cooldown",nil,icon, "CooldownFrameTemplate")
    icd.noCooldownCount = true -- disable OmniCC for this cooldown
    icd:SetHideCountdownNumbers(true)
    icd:SetReverse(true)
    icd:SetDrawEdge(false)
    icd:SetAllPoints(icontex)
    icon.cd = icd

    local pag = icon:CreateAnimationGroup()
    local pa1 = pag:CreateAnimation("Scale")
    pa1:SetScale(2,2)
    pa1:SetDuration(.2)
    pa1:SetOrder(1)
    local pa2 = pag:CreateAnimation("Scale")
    pa2:SetScale(.5,.5)
    pa2:SetDuration(.8)
    -- pa2:SetSmoothing("OUT")
    pa2:SetOrder(2)

    icon.pulse = pag

    local stackframe = CreateFrame("Frame", nil, icon)
    stackframe:SetAllPoints(icon)
    local stacktext = stackframe:CreateFontString(nil,"ARTWORK")
    stacktext:SetDrawLayer("ARTWORK",1)
    local stackFont = LSM:Fetch("font",  Aptechka.db.nameFontName)
    local stackFontSize = Aptechka.db.stackFontSize
    stacktext:SetFont(stackFont, stackFontSize, "OUTLINE")
    -- stackframe:SetFrameLevel(7)

    stacktext:SetJustifyH"RIGHT"
    stacktext:SetPoint("BOTTOMRIGHT",icontex,"BOTTOMRIGHT", 3,-1)
    stacktext:SetTextColor(1,1,1)
    icon.stacktext = stacktext
    icon.SetJob = SetJob_Icon

    return icon
end
AptechkaDefaultConfig.GridSkin_CreateIcon = CreateIcon


local DebuffTypeColor = DebuffTypeColor
local helpful_color = { r = 0, g = 1, b = 0}
local function SetJob_DebuffIcon(self, debuffType, expirationTime, duration, icon, count, isBossAura)
    if expirationTime then
        self.cd:SetReverse(true)
        self.cd:SetCooldown(expirationTime - duration, duration)
        self.cd:Show()
    else
        self.cd:Hide()
    end
    self.texture:SetTexture(icon)

    if count then self.stacktext:SetText(count > 1 and count) end

    local color
    if debuffType == "Helpful" then
        color = helpful_color
    else
        color = debuffType and DebuffTypeColor[debuffType] or DebuffTypeColor["none"]
    end
    self.debuffTypeTexture:SetVertexColor(color.r, color.g, color.b, 1)

    if isBossAura then
        self:SetScale(Aptechka.db.debuffBossScale)
    else
        self:SetScale(1)
    end
end

local SetDebuffOrientation = function(self, orientation, size)
    local it = self.texture
    local dtt = self.debuffTypeTexture
    local text = self.stacktext
    -- local w = self.width
    -- local h = self.height
    local w = size
    local h = size
    local p = pixelperfect(1)
    it:ClearAllPoints()
    dtt:ClearAllPoints()

    -- local simple = false
    -- local corner = true

    -- if simple then
    --     it:SetSize(pixelperfect(h - 2), pixelperfect(h - 2*p))
    --     it:SetPoint("TOPLEFT", self, "TOPLEFT", p, -p)
    --     dtt:SetSize(h, h)
    --     dtt:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    -- elseif corner then
    --     self:SetSize(h,h)
    --     it:SetSize(h,h)
    --     it:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)

    --     dtt:SetTexture[[Interface\AddOns\Aptechka\corner]]
    --     dtt:SetTexCoord(1,1,0,1,1,0,0,0)
    --     dtt:SetSize(h*0.6, h*0.6)
    --     dtt:SetDrawLayer("ARTWORK", 3)
    --     dtt:SetPoint("TOPLEFT", self, "TOPLEFT", 0,0)

    if orientation == "VERTICAL" then
        local dttLen = h*0.22
        self:SetSize(h + dttLen,h)
        it:SetSize(h,h)
        it:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
        dtt:SetSize(dttLen,h)
        dtt:SetPoint("TOPLEFT", it, "TOPRIGHT", 0, 0)
        dtt:SetTexCoord(0,1,0,1)
        text:SetPoint("BOTTOMRIGHT", it,"BOTTOMRIGHT", 2,-1)
    else
        local dttLen = h*0.25
        self:SetSize(h,w + dttLen)
        dtt:SetSize(w, dttLen)
        dtt:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
        dtt:SetTexCoord(0,1,0,0,1,1,1,0)
        it:SetSize(h,h)
        it:SetPoint("BOTTOMLEFT", dtt, "TOPLEFT", 0, 0)
        text:SetPoint("BOTTOMRIGHT", it,"BOTTOMRIGHT", 3,1)
    end
end

local AlignDebuffIcons = function(icons, orientation)
    local attachTo, attachPoint
    if orientation == "VERTICAL" then
        for i,icon in ipairs(icons) do
            if i == 1 then
                attachTo = icons.parent
                attachPoint = "BOTTOMLEFT"
            else
                attachTo = icons[i-1]
                attachPoint = "TOPLEFT"
            end
            icon:ClearAllPoints()
            icon:SetPoint("BOTTOMLEFT", attachTo, attachPoint, 0,0)
        end
    else
        for i,icon in ipairs(icons) do
            if i == 1 then
                attachTo = icons.parent.power
                attachPoint = "TOPLEFT"
            else
                attachTo = icons[i-1]
                attachPoint = "BOTTOMRIGHT"
            end
            icon:ClearAllPoints()
            icon:SetPoint("BOTTOMLEFT", attachTo, attachPoint, 0,0)
        end
    end
end

local CreateDebuffIcon = function(parent, width, height, alpha, point, frame, to, x, y)
    local icon = CreateIcon(parent, width, height, alpha, point, frame, to, x, y)

    local w = pixelperfect(width)
    local h = pixelperfect(height)

    local icontex = icon.texture
    icontex:SetTexCoord(.2, .8, .2, .8)

    local dttex = icon:CreateTexture(nil, "ARTWORK", nil, -2)
    dttex:SetTexture([[Interface\AddOns\Aptechka\debuffType]])
    icon.debuffTypeTexture = dttex

    icon.SetOrientation = SetDebuffOrientation

    icon:SetOrientation("VERTICAL", w)

    icon.SetJob = SetJob_DebuffIcon

    icon:Hide()

    return icon
end

local SetJob_ProgressIcon = function(self, job)
    SetJob_Icon(self, job)

    self.cd:SetReverse(job.reverseDuration)

    local r,g,b
    local job_color = job.color
    if job_color then
        r,g,b = unpack(job_color)
    else
        r,g,b = 0.75, 1, 0.2
    end
    self.cd:SetSwipeColor(r,g,b)
end

local CreateProgressIcon = function(parent, width, height, alpha, point, frame, to, x, y)
    local icon = CreateIcon(parent, width, height, alpha, point, frame, to, x, y)
    local border = pixelperfect(3)
    local frameborder = MakeBorder(icon, "Interface\\BUTTONS\\WHITE8X8", -border, -border, -border, -border, -2)
    frameborder:SetVertexColor(0,0,0,1)
    frameborder:SetDrawLayer("ARTWORK", 2)

    icon:SetFrameStrata("MEDIUM")
    -- icon:SetFrameLevel(7)

    local cdf = icon.cd
    cdf.noCooldownCount = true -- disable OmniCC for this cooldown
    -- cdf:SetEdgeTexture("Interface\\Cooldown\\edge");
    cdf:SetSwipeColor(0.8, 1, 0.2, 1);
    cdf:SetDrawEdge(false);
    cdf:SetSwipeTexture("Interface\\BUTTONS\\WHITE8X8")
    cdf:SetHideCountdownNumbers(true);
    -- cdf:SetReverse(false)
    cdf:ClearAllPoints()
    local offset = border - pixelperfect(1)
    cdf:SetPoint("TOPLEFT", -offset, offset)
    cdf:SetPoint("BOTTOMRIGHT", offset, -offset)

    cdf:SetScript("OnCooldownDone", function(self)
        self:GetParent():Hide()
    end)

    local iconSubFrame = CreateFrame("Frame", nil, icon)
    iconSubFrame:SetAllPoints(icon)
    iconSubFrame:SetFrameLevel(8)
    local icontex = icon.texture
    icontex:SetParent(iconSubFrame)
    icontex:SetDrawLayer("ARTWORK", 5)

    icon.SetJob = SetJob_ProgressIcon

    icon:Hide()

    return icon
end

local Text1_SetColor = function(self, r,g,b)
    self:SetTextColor(r,g,b)
end
local Text1_SetColorInverted = function(self, r,g,b)
    self:SetTextColor(r*0.2,g*0.2,b*0.2)
end
local SetJob_Text1 = function(self,job)
    if job.healthtext then
        self:SetFormattedText("-%.0fk", (self.parent.vHealthMax - self.parent.vHealth) / 1e3)
    elseif job.nametext then
        self:SetText(self.parent.name)
    elseif job.text then
        self:SetText(job.text)
    end
    local c
    if job.classcolor then
        c = self.parent.classcolor
    elseif job.color then
        c = job.textcolor or job.color
    end
    if c then
        local r,g,b,a = unpack(c)
        local mul = Aptechka.db.nameColorMultiplier or 1
        self:SetColor(multiplyColor(mul, r,g,b,a))
    end
end
local SetJob_Text2 = function(self,job) -- text2 is always green
    if job.healthtext then
        self:SetFormattedText("-%d", (self.parent.vHealthMax - self.parent.vHealth))
    elseif job.inchealtext then
        self:SetFormattedText("+%d", self.parent.vIncomingHeal)
    elseif job.nametext then
        self:SetText(self.parent.name)
    elseif job.text then
        self:SetText(job.text)
    end

    local c
    if job.percentColor then
        self:SetTextColor(helpers.PercentColor(job.text))
        self:SetFormattedText("%.0f%%", job.text*100)
    else
        if job.color then
            c = job.textcolor or job.color
            self:SetTextColor(unpack(c))
        end
    end
end

----------------
-- HEAL ABSORB
----------------
local HealAbsorbUpdatePositionVertical = function(self, p, health, parent)
    local frameLength = parent.frameLength
    self:SetHeight(p*frameLength)
    local offset = (health-p)*frameLength
    self:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, offset)
    self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 0, offset)
end
local HealAbsorbUpdatePositionHorizontal = function(self, p, health, parent)
    local frameLength = parent.frameLength
    self:SetWidth(p*frameLength)
    local offset = (health-p)*frameLength
    self:SetPoint("TOPLEFT", parent, "TOPLEFT", offset, 0)
    self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", offset, 0)
end
local HealAbsorbSetValue = function(self, p, health)
    if p < 0.005 then
        self:Hide()
        return
    end

    local parent = self.parent

    if p > health then
        p = health
    end

    self:Show()
    self:UpdatePosition(p, health, parent)
end

local function CreateHealAbsorb(hp)
    local healAbsorb = hp:CreateTexture(nil, "ARTWORK", nil, -5)

    healAbsorb:SetHorizTile(true)
    healAbsorb:SetVertTile(true)
    healAbsorb:SetTexture("Interface\\AddOns\\Aptechka\\shieldtex", "REPEAT", "REPEAT")
    healAbsorb:SetVertexColor(0.5,0.1,0.1, 0.65)
    healAbsorb:SetBlendMode("ADD")

    healAbsorb.UpdatePositionVertical = HealAbsorbUpdatePositionVertical
    healAbsorb.UpdatePositionHorizontal = HealAbsorbUpdatePositionHorizontal
    healAbsorb.UpdatePosition = HealAbsorbUpdatePositionVertical

    healAbsorb.SetValue = HealAbsorbSetValue
    return healAbsorb
end
--------------------
-- ABSORB BAR
--------------------
local AbsorbUpdatePositionVertical = function(self, p, health, parent)
    local frameLength = parent.frameLength
    self:SetHeight(p*frameLength)
    local offset = health*frameLength
    self:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, offset)
    self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 0, offset)
end
local AbsorbUpdatePositionHorizontal = function(self, p, health, parent)
    local frameLength = parent.frameLength
    self:SetWidth(p*frameLength)
    local offset = health*frameLength
    self:SetPoint("TOPLEFT", parent, "TOPLEFT", offset, 0)
    self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", offset, 0)
end
local AbsorbSetValue = function(self, p, health)
    if p + health > 1 then
        p = 1 - health
    end

    if p < 0.005 then
        self:Hide()
        return
    end

    local parent = self.parent

    self:Show()
    self:UpdatePosition(p, health, parent)
end
local function CreateAbsorbBar(hp)
    local absorb = hp:CreateTexture(nil, "ARTWORK", nil, -5)

    absorb:SetHorizTile(true)
    absorb:SetVertTile(true)
    absorb:SetTexture("Interface\\AddOns\\Aptechka\\shieldtex", "REPEAT", "REPEAT")
    absorb:SetVertexColor(0,0,0, 0.65)
    -- absorb:SetBlendMode("ADD")

    absorb.UpdatePositionVertical = AbsorbUpdatePositionVertical
    absorb.UpdatePositionHorizontal = AbsorbUpdatePositionHorizontal
    absorb.UpdatePosition = AbsorbUpdatePositionVertical

    absorb.SetValue = AbsorbSetValue
    return absorb
end

--------------------
-- INCOMING HEAL
--------------------
local function CreateIncominHealBar(hp)
    local hpi = hp:CreateTexture(nil, "ARTWORK", nil, -5)

    -- hpi:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
    hpi:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    hpi:SetVertexColor(0,0,0, 0.5)

    hpi.UpdatePositionVertical = AbsorbUpdatePositionVertical
    hpi.UpdatePositionHorizontal = AbsorbUpdatePositionHorizontal
    hpi.UpdatePosition = AbsorbUpdatePositionVertical

    hpi.SetValue = AbsorbSetValue
    return hpi
end


local AlignAbsorbVertical = function(self, absorb_height, missing_health_height)
    self:SetHeight(absorb_height)
    if absorb_height >= missing_health_height then
        self:SetPoint("TOPLEFT", self:GetParent(), "TOPLEFT", -3 ,0)
    else
        self:SetPoint("TOPLEFT", self:GetParent(), "TOPLEFT", -3, -(missing_health_height - absorb_height))
    end
end
local AlignAbsorbHorizontal = function(self, absorb_height, missing_health_height)
    self:SetWidth(absorb_height)
    if absorb_height >= missing_health_height then
        self:SetPoint("BOTTOMRIGHT", self:GetParent(), "BOTTOMRIGHT", 0 ,-3)
    else
        self:SetPoint("BOTTOMRIGHT", self:GetParent(), "BOTTOMRIGHT", -(missing_health_height - absorb_height), -3)
    end
end
local CreateAbsorbSideBar_SetValue = function(self, p, h)
    if p > 1 then p = 1 end
    if p < 0 then p = 0 end
    if p <= 0.015 then self:Hide(); return; else self:Show() end

    local frameLength = self.parent.frameLength

    local missing_health_height = (1-h)*frameLength
    local absorb_height = p*frameLength

    self:AlignAbsorb(absorb_height, missing_health_height)
end

local function CreateAbsorbSideBar(hp)
    local absorb = CreateFrame("Frame", nil, hp)
    absorb:SetParent(hp)
    -- absorb:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT",0,0)
    absorb:SetPoint("TOPLEFT",hp,"TOPLEFT",-3,0)
    absorb:SetWidth(3)

    local at = absorb:CreateTexture(nil, "ARTWORK", nil, -4)
    at:SetTexture[[Interface\BUTTONS\WHITE8X8]]
    at:SetVertexColor(.7, .7, 1, 1)
    at:SetAllPoints(absorb)

    local atbg = absorb:CreateTexture(nil, "ARTWORK", nil, -5)
    atbg:SetTexture[[Interface\BUTTONS\WHITE8X8]]
    atbg:SetVertexColor(0,0,0,1)
    atbg:SetPoint("TOPLEFT", at, "TOPLEFT", -1,1)
    atbg:SetPoint("BOTTOMRIGHT", at, "BOTTOMRIGHT", 1,-1)

    absorb.AlignAbsorb = AlignAbsorbVertical

    absorb.SetValue = CreateAbsorbSideBar_SetValue
    absorb:SetValue(0)
    return absorb
end


    local hour, minute = 3600, 60
    local format = string.format
    local ceil = math.ceil
    local function FormatTime(s)
        if s >= hour then
            return "%dh", ceil(s / hour)
        elseif s >= minute then
            return "%dm", ceil(s / minute)
        end
        return "%ds", floor(s)
    end

    local Text3_OnUpdate = function(t3frame,time)
        local remains = t3frame.text.expirationTime - GetTime()
        if remains >= 0 then
            t3frame.text:SetText(string.format("%.1f", remains))
        else
            t3frame:SetScript("OnUpdate", nil)
        end
    end
    local Text3_OnUpdateForward = function(t3frame,time)
        local elapsed = GetTime() - t3frame.text.startTime
        if elapsed >= 0 then
            t3frame.text:SetFormattedText(FormatTime(elapsed))
        end
    end
    local Text3_HideFunc = function(self)
        self.frame:SetScript("OnUpdate",nil)
        self:Hide()
    end
local SetJob_Text3 = function(self,job)
    -- if job.startTime then
        -- self.expirationTime = nil
        -- self.startTime = job.startTime
    -- end
    if job.expirationTime then
        self.expirationTime = job.expirationTime
        self.startTime = nil
        self.frame:SetScript("OnUpdate",Text3_OnUpdate) --.frame is for text3 container
    elseif job.startTime then
        self.startTime = job.startTime
        self.expirationTime = nil
        self.frame:SetScript("OnUpdate",Text3_OnUpdateForward) --.frame is for text3 container
    else
        self.frame:SetScript("OnUpdate",nil)
    end

    if job.text then
        self:SetText(job.text)
    end

    local c = job.textcolor or job.color
    if c then
        self:SetTextColor(unpack(c))
    else
        self:SetTextColor(1,1,1)
    end
end
local CreateTextTimer = function(parent,point,frame,to,x,y,hjustify,fontsize,font,flags)
    local text3container = CreateFrame("Frame", nil, parent) -- We need frame to create OnUpdate handler for time updates
    local text3 = text3container:CreateFontString(nil, "ARTWORK")
    text3container.text = text3
--~     text3container:Hide()
    text3:SetPoint(point,frame,to,x,y)--"TOPLEFT",self,"TOPLEFT",-2,0)
    text3:SetJustifyH"LEFT"
    text3:SetFont(font, fontsize or 11, flags)
    text3.SetJob = SetJob_Text3
    text3.HideFunc = Text3_HideFunc
    text3.parent = parent
    text3.frame = text3container
    return text3
end
AptechkaDefaultConfig.GridSkin_CreateTextTimer = CreateTextTimer


local border_backdrop = {
    edgeFile = "Interface\\Addons\\Aptechka\\border", tileEdge = true, edgeSize = 14,
    insets = {left = -2, right = -2, top = -2, bottom = -2},
}
local SetJob_Border = function(self,job)
    if job.color then
        local r,g,b = unpack(job.color)
        self:SetBackdropBorderColor(r,g,b,0.5)
    end
end

local ordered_jobs = {}
local table_wipe = table.wipe
local table_sort = table.sort
local table_insert = table.insert
local sortfunc = function(a,b)
    local ap = a.priority or 80
    local bp = b.priority or 80
    if ap == bp then
        return a.expirationTime > b.expirationTime
    else
        return ap > bp
    end
end
local SetJob_Bars = function(self, _job)
    table_wipe(ordered_jobs)

    for name, job in pairs(self.jobs) do
        table_insert(ordered_jobs, job)
    end

    self.currentJob = ordered_jobs[1]

    table_sort(ordered_jobs, sortfunc)

    local frame = self:GetParent()

    for i, widgetname in ipairs(self.widgets) do
        local bar = frame[widgetname]
        local ojob = ordered_jobs[i]
        -- print(i, widgetname, ojob and ojob.name)
        if ojob then
            bar:SetJob(ojob)
            bar.currentJob = ojob
            bar:Show()
        else
            bar.currentJob = nil
            bar:Hide()
        end
    end
end


local CreateBars = function(self, optional_widgets)
    local  bars = CreateFrame("Frame", nil, self)
    bars.widgets = { "bar1", "bar2", "bar3" }
    bars.rawAssignments = true
    bars.SetJob = SetJob_Bars

    for i, widget in ipairs(bars.widgets) do
        self[widget] = optional_widgets[widget](self)
    end

    return bars
end

local OnMouseEnterFunc = function(self)
    self.mouseover:Show()
end
local OnMouseLeaveFunc = function(self)
    self.mouseover:Hide()
end


local optional_widgets = {
        raidbuff = function(self) return CreateIndicator(self,5,5,"TOPLEFT",self,"TOPLEFT",0,0) end,
        totemCluster1 = function(self) return CreateIndicator(self,5,5,"TOPLEFT",self,"TOPLEFT",7,0) end,
        totemCluster2 = function(self) return CreateIndicator(self,5,5,"TOPLEFT",self,"TOPLEFT",14,0) end,
        totemCluster3 = function(self) return CreateIndicator(self,5,5,"TOPLEFT",self,"TOPLEFT",21,0) end,
        --top
        spell1  = function(self) return CreateIndicator(self,9,9,"BOTTOMRIGHT",self,"BOTTOMRIGHT",0,0) end,
        --bottomright
        spell2  = function(self) return CreateIndicator(self,9,9,"TOP",self,"TOP",0,0) end,
        --topright
        spell3  = function(self) return CreateIndicator(self,9,9,"TOPRIGHT",self,"TOPRIGHT",0,0) end,
        --bottom
        spell4  = function(self) return CreateIndicator(self,7,7,"BOTTOM",self,"BOTTOM",0,0) end,
        --left
        spell5  = function(self) return CreateIndicator(self,7,7,"LEFT",self,"LEFT",0,0) end,

        -- shieldicon = function(self) return CreateShieldIcon(self,15,15,1,"CENTER",self,"TOPLEFT",14,0) end,
        shieldicon = function(self) return CreateProgressIcon(self,15,15,1,"TOPRIGHT",self,"TOPRIGHT",2,-12) end,

        bar1    = function(self) return CreateStatusBar(self, 21, 6, "BOTTOMRIGHT",self, "BOTTOMRIGHT",0,0) end,
        bar2    = function(self)
            if self.bar1 then
                return CreateStatusBar(self, 21, 4, "BOTTOMLEFT", self.bar1, "TOPLEFT",0, pixelperfect(1))
            end
        end,
        bar3    = function(self)
            if self.bar2 then
                return CreateStatusBar(self, 21, 4, "BOTTOMLEFT", self.bar2, "TOPLEFT",0, pixelperfect(1))
            end
        end,
        bar4    = function(self) return CreateStatusBar(self, 21, 5, "TOPRIGHT", self, "TOPRIGHT",0,2) end,

        bars = CreateBars,

        vbar1   = function(self) return CreateStatusBar(self, 4, 20, "TOPRIGHT", self, "TOPRIGHT",-9,2, nil, true) end,

        smist  = function(self) return CreateIndicator(self,7,7,"TOPRIGHT",self.vbar1,"TOPLEFT",-1,0) end,
}

local function Reconf(self)
    local config = AptechkaDefaultConfig

    local db = Aptechka.db
    local isVertical = db.healthOrientation == "VERTICAL"

    local texpath = LSM:Fetch("statusbar", db.healthTexture)
    self.health:SetStatusBarTexture(texpath)
    self.health:GetStatusBarTexture():SetDrawLayer("ARTWORK",-6)
    self.health.bg:SetTexture(texpath)

    local texpath2 = LSM:Fetch("statusbar", db.powerTexture)
    self.power:SetStatusBarTexture(texpath2)
    self.power:GetStatusBarTexture():SetDrawLayer("ARTWORK",-2)
    self.power.bg:SetTexture(texpath2)

    if not db.fgShowMissing then
        -- Blizzard's StatusBar SetFillStyle is bad, because even if it reverses direction,
        -- it still cuts tex coords from the usual direction
        -- So i'm using custom status bar for health and power
        self.health:SetFillStyle("STANDARD")
        self.power:SetFillStyle("STANDARD")

        -- self.health.SetColor = HealthBarSetColorInverted
        -- self.power.SetColor = HealthBarSetColorInverted
        -- self.text1.SetColor = Text1_SetColorInverted
        -- self.text1:SetShadowOffset(0,0)
        self.health.absorb2:SetVertexColor(0.7,0.7,1, 0.65)
        self.health.incoming:SetVertexColor(0.3, 1,0.4, 0.4)
    else
        self.health:SetFillStyle("REVERSE")
        self.power:SetFillStyle("REVERSE")
        -- self.health.SetColor = HealthBarSetColor
        -- self.power.SetColor = HealthBarSetColor
        -- self.text1.SetColor = Text1_SetColor
        -- self.text1:SetShadowOffset(1,-1)
        self.health.absorb2:SetVertexColor(0,0,0, 0.65)
        self.health.incoming:SetVertexColor(0,0,0, 0.4)
    end
    Aptechka.FrameSetJob(self,config.HealthBarColor,true)
    Aptechka.FrameSetJob(self,config.PowerBarColor,true)
    Aptechka.FrameSetJob(self,config.UnitNameStatus,true)

    local nameFont = LSM:Fetch("font",  Aptechka.db.nameFontName)
    local nameFontSize = Aptechka.db.nameFontSize
    local nameFontOutline = Aptechka.db.nameFontOutline
    local outline = nameFontOutline == "OUTLINE" and "OUTLINE"
    self.text1:SetFont(nameFont, nameFontSize, outline)
    if nameFontOutline == "SHADOW" then
        self.text1:SetShadowOffset(1,-1)
    else
        self.text1:SetShadowOffset(0,0)
    end

    local stackFont = LSM:Fetch("font", Aptechka.db.stackFontName)
    local stackFontSize = Aptechka.db.stackFontSize
    for i, icon in ipairs(self.debuffIcons) do
        icon.stacktext:SetFont(stackFont, stackFontSize, "OUTLINE")
    end

    if isVertical then
        self.health:SetOrientation("VERTICAL")
        self.power:SetOrientation("VERTICAL")

        local frameLength = db.height
        self.health.frameLength = frameLength

        self.health:ClearAllPoints()
        self.health:SetPoint("TOPLEFT",self,"TOPLEFT",0,0)
        self.health:SetPoint("TOPRIGHT",self,"TOPRIGHT",0,0)
        self.health:SetHeight(frameLength)

        self.power:ClearAllPoints()
        self.power:SetWidth(4)
        self.power:SetPoint("TOPRIGHT",self,"TOPRIGHT",0,0)
        self.power:SetHeight(frameLength)
        self.power:OnPowerTypeChange()

        local  absorb = self.health.absorb
        absorb:ClearAllPoints()
        absorb:SetWidth(3)
        absorb.orientation = "VERTICAL"
        absorb.AlignAbsorb = AlignAbsorbVertical
        Aptechka:UNIT_ABSORB_AMOUNT_CHANGED(nil, self.unit)

        local healAbsorb = self.health.healabsorb
        healAbsorb:ClearAllPoints()
        healAbsorb.UpdatePosition = healAbsorb.UpdatePositionVertical

        local absorb2 = self.health.absorb2
        absorb2:ClearAllPoints()
        absorb2.UpdatePosition = absorb2.UpdatePositionVertical

        local hpi = self.health.incoming
        hpi:ClearAllPoints()
        hpi.UpdatePosition = hpi.UpdatePositionVertical

        local debuffSize = pixelperfect(Aptechka.db.debuffSize)
        for i, icon in ipairs(self.debuffIcons) do
            icon:SetOrientation("VERTICAL", debuffSize)
        end
        self.debuffIcons:Align("VERTICAL")

        self.bossdebuff:SetPoint("BOTTOMLEFT", self.debuffIcons[1], "BOTTOMRIGHT",0,0)

    else
        self.health:SetOrientation("HORIZONTAL")
        self.power:SetOrientation("HORIZONTAL")

        local frameLength = db.width
        self.health.frameLength = frameLength

        self.health:ClearAllPoints()
        self.health:SetPoint("TOPLEFT",self,"TOPLEFT",0,0)
        self.health:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT",0,0)
        self.health:SetWidth(frameLength)

        self.power:ClearAllPoints()
        self.power:SetHeight(4)
        self.power:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT",0,0)
        self.power:SetWidth(frameLength)
        self.power:OnPowerTypeChange()

        local absorb = self.health.absorb
        absorb:ClearAllPoints()
        absorb:SetHeight(3)
        absorb.orientation = "HORIZONTAL"
        absorb.AlignAbsorb = AlignAbsorbHorizontal
        Aptechka:UNIT_ABSORB_AMOUNT_CHANGED(nil, self.unit)

        local healAbsorb = self.health.healabsorb
        healAbsorb:ClearAllPoints()
        healAbsorb.UpdatePosition = healAbsorb.UpdatePositionHorizontal

        local absorb2 = self.health.absorb2
        absorb2:ClearAllPoints()
        absorb2.UpdatePosition = absorb2.UpdatePositionHorizontal

        local hpi = self.health.incoming
        hpi:ClearAllPoints()
        hpi.UpdatePosition = hpi.UpdatePositionHorizontal

        local debuffSize = pixelperfect(Aptechka.db.debuffSize)
        for i, icon in ipairs(self.debuffIcons) do
            icon:SetOrientation("HORIZONTAL", debuffSize)
        end
        self.debuffIcons:Align("HORIZONTAL")

        self.bossdebuff:SetPoint("BOTTOMLEFT", self.debuffIcons[1], "TOPLEFT",0,0)
    end

end

AptechkaDefaultConfig.GridSkin = function(self)
    Aptechka = _G.Aptechka

    local db = Aptechka.db

    local config = AptechkaDefaultConfig

    local texture = LSM:Fetch("statusbar", db.healthTexture)
    local powertexture = LSM:Fetch("statusbar", db.powerTexture)
    local font = LSM:Fetch("font",  Aptechka.db.nameFontName)
    local fontsize = Aptechka.db.nameFontSize
    local manabar_width = config.manabarwidth
    local outlineSize = pixelperfect(2)

    self.ReconfigureUnitFrame = Reconf

    local outline = MakeBorder(self, "Interface\\BUTTONS\\WHITE8X8", -outlineSize, -outlineSize, -outlineSize, -outlineSize, -2)
    outline:SetVertexColor(0,0,0,1)

    -- local powerbar = CreateFrame("StatusBar", nil, self)
    local powerbar = Aptechka.CreateCustomStatusBar(nil, self, "VERTICAL")
    powerbar:SetWidth(4)
    powerbar:SetPoint("TOPRIGHT",self,"TOPRIGHT",0,0)
    powerbar:SetHeight(db.height)
    powerbar:SetStatusBarTexture(powertexture)
    powerbar:GetStatusBarTexture():SetDrawLayer("ARTWORK",-6)
    powerbar:SetMinMaxValues(0,100)
    powerbar:SetOrientation("VERTICAL")
    -- powerbar:SetStatusBarColor(0.5,0.5,1)
    powerbar.SetJob = SetJob_HealthBar
    powerbar.OnPowerTypeChange = PowerBar_OnPowerTypeChange
    powerbar.SetColor = HealthBarSetColorFG

    local pbbg = powerbar:CreateTexture(nil,"ARTWORK",nil,-8)
    pbbg:SetAllPoints(powerbar)
    pbbg:SetTexture(powertexture)
    pbbg.SetColor = HealthBarSetColorBG
    powerbar.bg = pbbg


    -- local hp = CreateFrame("StatusBar", nil, self)
    local hp = Aptechka.CreateCustomStatusBar(nil, self, "VERTICAL")
    --hp:SetAllPoints(self)
    hp:SetPoint("TOPLEFT",self,"TOPLEFT",0,0)
    hp:SetPoint("TOPRIGHT",powerbar,"TOPRIGHT",0,0)
    hp:SetHeight(db.height)
    hp:GetStatusBarTexture():SetDrawLayer("ARTWORK",-6)
    hp:SetMinMaxValues(0,100)
    hp:SetOrientation("VERTICAL")
    hp.parent = self
    hp.SetJob = SetJob_HealthBar
    hp.SetColor = HealthBarSetColorFG
    --hp:SetValue(0)

    local hpbg = hp:CreateTexture(nil,"ARTWORK",nil,-8)
    hpbg:SetAllPoints(hp)
    hpbg:SetTexture(texture)
    hpbg.SetColor = HealthBarSetColorBG
    hp.bg = hpbg

    --[[
    ----------------------
    -- HEALTH LOST EFFECT
    ----------------------

    hplost = hp:CreateTexture(nil, "ARTWORK", nil, -4)
    hplost:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    hplost:SetVertexColor(0.8, 0, 0)
    hp.lost = hplost

    hp._SetValue = hp.SetValue
    hp.SetValue = function(self, v)
        local max = 100
        local vp = v/max
        local hl = self.lost
        local offset = vp*hl.maxheight
        hl:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, offset)
        hl:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, offset)
        -- self.lost:SmoothFade(v)
        hl:SetNewHealthTarget(vp)
        self:_SetValue(v)
    end

    hplost:SetPoint("BOTTOMLEFT", hp, "BOTTOMLEFT", 0, 0)
    hplost:SetPoint("BOTTOMRIGHT", hp, "BOTTOMRIGHT", 0, 0)

    hplost.currentvalue = 0
    hplost.endvalue = 0

    hplost.UpdateDiff = function(self)
        local diff = self.currentvalue - self.endvalue
        if diff > 0 then
            self:SetHeight((diff)*self.maxheight)
            self:SetAlpha(1)
        else
            self:SetHeight(1)
            self:SetAlpha(0)
        end
    end

    hp:SetScript("OnUpdate", function(self, time)
        self._elapsed = (self._elapsed or 0) + time
        if self._elapsed < 0.025 then return end
        self._elapsed = 0


        local hl = self.lost
        local diff = hl.currentvalue - hl.endvalue
        if diff > 0 then
            local d = (diff > 0.1) and diff/15 or 0.006
            hl.currentvalue = hl.currentvalue - d
            -- self:SetValue(self.currentvalue)
            hl:UpdateDiff()
        end
    end)

    hplost.SetNewHealthTarget = function(self, vp)
        if vp >= self.currentvalue then
            self.currentvalue = vp
            self.endvalue = vp
            -- self:SetValue(vp)
            self:UpdateDiff()
        else
            self.endvalue = vp
        end
    end
    ]]

    ------------------------
    -- Mouseover highlight
    ------------------------

    local mot = hp:CreateTexture(nil,"OVERLAY")
    mot:SetAllPoints(hp)
    mot:SetTexture(136810)
    -- /dump GetFileIDFromPath("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    -- mot:SetVertexColor(0.7,0.7,1)
    mot:SetTexCoord(0,1,0,0.9)
    mot:SetAlpha(0.1)
    mot:SetBlendMode("ADD")
    mot:Hide()
    self.mouseover = mot

    --------------------

    local absorb = CreateAbsorbSideBar(hp)
    absorb.parent = hp
    hp.absorb = absorb

    -------------------

    local absorb2 = CreateAbsorbBar(hp)
    absorb2.parent = hp
    hp.absorb2 = absorb2

    -------------------

    local healAbsorb = CreateHealAbsorb(hp)
    healAbsorb.parent = hp
    hp.healabsorb = healAbsorb

    -----------------------

    local hpi = CreateIncominHealBar(hp)
    hpi.parent = hp
    hp.incoming = hpi

    local p4 = pixelperfect(3.5)
    local border = CreateFrame("Frame", nil, self)
    border:SetPoint("TOPLEFT", self, "TOPLEFT", -p4, p4)
    border:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", p4, -p4)
    border:SetBackdrop(border_backdrop)
    border:SetBackdropBorderColor(1, 1, 1, 0.5)
    border.SetJob = SetJob_Border
    border:Hide()


    local text = hp:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    text:SetPoint("CENTER",self,"CENTER",0,0)
    text:SetJustifyH"CENTER"
    text:SetFont(font, fontsize)
    text:SetTextColor(1, 1, 1)
    text:SetShadowColor(0,0,0)
    text:SetShadowOffset(1,-1)
    text.SetColor = Text1_SetColor
    text.SetJob = SetJob_Text1
    text.parent = self

    local text2 = hp:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    text2:SetPoint("TOP",text,"BOTTOM",0,0)
    text2:SetJustifyH"CENTER"
    text2:SetFont(font, fontsize-2)
    text2.SetJob = SetJob_Text2
    text2:SetTextColor(0.2, 1, 0.2)
    text2.parent = self

    local icon = CreateIcon(self,24,24,0.4,"CENTER",self,"CENTER",0,0)
    local progressIcon = CreateProgressIcon(self,18,18, 1,"TOPLEFT",self,"TOPLEFT",-3,3)

    local raidicon = CreateFrame("Frame",nil,self)
    raidicon:SetWidth(20); raidicon:SetHeight(20)
    raidicon:SetPoint("CENTER",hp,"TOPLEFT",0,0)
    local raidicontex = raidicon:CreateTexture(nil,"OVERLAY")
    raidicontex:SetAllPoints(raidicon)
    raidicon.texture = raidicontex
    raidicon:SetAlpha(0.3)


    local centericon = CreateFrame("Frame",nil,self)
    centericon:SetWidth(20); centericon:SetHeight(20)
    centericon:SetPoint("CENTER",hp,"CENTER",0,14)
    centericon:SetFrameLevel(7)
    local centericontex = centericon:CreateTexture(nil,"OVERLAY")
    centericontex:SetAllPoints(centericon)
    centericon.texture = centericontex
    centericon:SetAlpha(1)


    local roleicon = CreateFrame("Frame",nil,self)
    roleicon:SetWidth(13); roleicon:SetHeight(13)
    -- roleicon:SetPoint("BOTTOMLEFT",hp,"CENTER",-20,-23)
    -- roleicon:SetPoint("TOPLEFT",hp,"TOPLEFT",1,-8)
    roleicon:SetPoint("BOTTOMLEFT",hp,"BOTTOMLEFT",-8, -8)
    local roleicontex = roleicon:CreateTexture(nil,"OVERLAY")
    roleicontex:SetAllPoints(roleicon)
    roleicontex:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES"); --("Interface\\AddOns\\Aptechka\\roles")
    -- roleicontex:SetVertexColor(0,0,0,0.2)
    roleicon.texture = roleicontex


    -- local topind = CreateIndicator(self,9,9,"TOP",self,"TOP",0,0)
    -- local tr = CreateIndicator(self,9,9,"TOPRIGHT",self,"TOPRIGHT",0,0)
    -- local br = CreateIndicator(self,9,9,"BOTTOMRIGHT",self,"BOTTOMRIGHT",0,0)
    -- local btm = CreateIndicator(self,7,7,"BOTTOM",self,"BOTTOM",0,0)
    -- local left = CreateIndicator(self,7,7,"LEFT",self,"LEFT",0,0)
    -- local tl = CreateIndicator(self,5,5,"TOPLEFT",self,"TOPLEFT",0,0)
    local text3 = CreateTextTimer(self,"TOPLEFT",self,"TOPLEFT",2,0,"LEFT",fontsize-3,font)--,"OUTLINE")

    -- local bar1 = CreateStatusBar(self, 21, 6, "BOTTOMRIGHT",self, "BOTTOMRIGHT",0,0)
    -- local bar2 = CreateStatusBar(self, 21, 4, "BOTTOMLEFT", bar1, "TOPLEFT",0,1)
    -- local bar3 = CreateStatusBar(self, 21, 4, "TOPRIGHT", self, "TOPRIGHT",0,1)
    -- local vbar1 = CreateStatusBar(self, 4, 19, "TOPRIGHT", self, "TOPRIGHT",-9,2, nil, true)

    local debuffSize = Aptechka.db.debuffSize
    self.debuffIcons = { parent = self }
    self.debuffIcons.Align = AlignDebuffIcons

    for i=1, 4 do
        local dicon = CreateDebuffIcon(self, debuffSize, debuffSize, 1, "BOTTOMLEFT", self, "BOTTOMLEFT", 0,0)
        table.insert(self.debuffIcons, dicon)
    end

    self.debuffIcons:Align("VERTICAL")

    -- local brcorner = CreateCorner(self, 21, 21, "BOTTOMRIGHT", self, "BOTTOMRIGHT",0,0)
    local blcorner = CreateCorner(self, 16, 16, "BOTTOMLEFT", self.debuffIcons[1], "BOTTOMRIGHT",0,0, "BOTTOMLEFT") --last arg changes orientation

    local trcorner = CreateCorner(self, 16, 30, "TOPRIGHT", self, "TOPRIGHT",0,0, "TOPRIGHT")
    self.healfeedback = trcorner

    -- local roundIndicator = CreateRoundIndicator(self, 13, 13, "BOTTOMLEFT", self, "BOTTOMLEFT",-8, -8)
    -- self.dispel = roundIndicator

    self.health = hp
    self.text1 = text
    self.text2 = text2
    self.healthtext = self.text2
    self.text3 = text3
    self.power = powerbar

    self.border = border

    self._optional_widgets = optional_widgets

    if not Aptechka.widget_list then
        local list = {}
        for slot in pairs(optional_widgets) do
            list[slot] = slot
        end
        list["raidbuff"] = "raidbuff"
        list["healfeedback"] = "healfeedback"
        list["icon"] = "icon"
        list["bar1"] = nil
        list["bar2"] = nil
        list["bar3"] = nil
        Aptechka.widget_list = list
    end

    for id, spell in pairs(config.auras) do
        if type(spell.assignto) == "string" then
            local widget = spell.assignto
            if not self[widget] and optional_widgets[widget] then
                self[widget] = optional_widgets[widget](self, optional_widgets)
            end
        else
            for _,widget in ipairs(spell.assignto) do
                if not self[widget] and optional_widgets[widget] then
                    self[widget] = optional_widgets[widget](self, optional_widgets)
                end
            end
        end
    end

    self.bossdebuff = blcorner
    self.icon = icon
    self.castIcon = progressIcon
    self.raidicon = raidicon
    self.roleicon = roleicon
    self.healabsorb = healAbsorb
    self.absorb = absorb
    self.absorb2 = absorb2
    self.centericon = centericon

    self.OnMouseEnterFunc = OnMouseEnterFunc
    self.OnMouseLeaveFunc = OnMouseLeaveFunc
    self.OnDead = OnDead
    self.OnAlive = OnAlive
end















do
    local function CustomStatusBar_SetStatusBarTexture(self, texture)
        self._texture:SetTexture(texture)
    end
    local function CustomStatusBar_GetStatusBarTexture(self)
        return self._texture
    end
    local function CustomStatusBar_SetStatusBarColor(self, r,g,b,a)
        self._texture:SetVertexColor(r,g,b,a)
    end
    local function CustomStatusBar_SetMinMaxValues(self, min, max)
        if max > min then
            self._min = min
            self._max = max
        else
            self._min = 0
            self._max = 1
        end
    end

    local function CustomStatusBar_SetFillStyle(self, fillStyle)
        self._reversed = fillStyle == "REVERSE"
        self:_Configure()
    end
    local function CustomStatusBar_SetOrientation(self, orientation)
        self._orientation = orientation
        self:_Configure()
    end

    local function CustomStatusBar_ResizeVertical(self, value)
        local len = self._height or self:GetHeight()
        self._texture:SetHeight(len*value)
    end
    local function CustomStatusBar_ResizeHorizontal(self, value)
        local len = self._width or self:GetWidth()
        self._texture:SetWidth(len*value)
    end

    local function CustomStatusBar_MakeCoordsVerticalStandard(self, p)
        -- left,right, bottom - (bottom-top)*pos , bottom
        return 0,1, 1-p, 1
    end
    local function CustomStatusBar_MakeCoordsVerticalReversed(self, p)
        return 0,1, 0, p
    end
    local function CustomStatusBar_MakeCoordsHorizontalStandard(self, p)
        return 0,p,0,1
    end
    local function CustomStatusBar_MakeCoordsHorizontalReversed(self, p)
        return 1-p,1,0,1
    end

    local function CustomStatusBar_SetWidth(self, w)
        self:_SetWidth(w)
        self._width = w
    end

    local function CustomStatusBar_SetHeight(self, w)
        self:_SetHeight(w)
        self._height = w
    end

    local function CustomStatusBar_Configure(self)
        local isReversed = self._reversed
        local orientation = self._orientation
        local t = self._texture
        t:ClearAllPoints()
        if orientation == "VERTICAL" then
            self._Resize = CustomStatusBar_ResizeVertical
            if isReversed then
                t:SetPoint("TOPLEFT")
                t:SetPoint("TOPRIGHT")
                self.MakeCoords = CustomStatusBar_MakeCoordsVerticalReversed
            else
                t:SetPoint("BOTTOMLEFT")
                t:SetPoint("BOTTOMRIGHT")
                self.MakeCoords = CustomStatusBar_MakeCoordsVerticalStandard
            end
        else
            self._Resize = CustomStatusBar_ResizeHorizontal
            if isReversed then
                t:SetPoint("TOPRIGHT")
                t:SetPoint("BOTTOMRIGHT")
                self.MakeCoords = CustomStatusBar_MakeCoordsHorizontalReversed
            else
                t:SetPoint("TOPLEFT")
                t:SetPoint("BOTTOMLEFT")
                self.MakeCoords = CustomStatusBar_MakeCoordsHorizontalStandard
            end
        end
        self:SetValue(self._value)
    end

    local function CustomStatusBar_SetValue(self, val)
        local min = self._min
        local max = self._max
        self._value = val
        local pos = (val-min)/(max-min)
        if pos > 1 then pos = 1 end
        local tex = self._texture
        if pos <= 0 then tex:Hide(); return end

        tex:Show()

        self:_Resize(pos)
        self._texture:SetTexCoord(self:MakeCoords(pos))
    end


    function Aptechka.CreateCustomStatusBar(name, parent, orientation)
        local f = CreateFrame("Frame", name, parent)
        f._min = 0
        f._max = 100
        f._value = 0

        local t = f:CreateTexture(nil, "ARTWORK")

        f._texture = t


        f.SetStatusBarTexture = CustomStatusBar_SetStatusBarTexture
        f.GetStatusBarTexture = CustomStatusBar_GetStatusBarTexture
        f.SetStatusBarColor = CustomStatusBar_SetStatusBarColor
        f.SetMinMaxValues = CustomStatusBar_SetMinMaxValues
        f.SetFillStyle = CustomStatusBar_SetFillStyle
        f.SetOrientation = CustomStatusBar_SetOrientation
        f._Configure = CustomStatusBar_Configure
        f.SetValue = CustomStatusBar_SetValue

        -- As i later found out, parent:GetHeight() doesn't immediately return the correct values on login, leading to infinite bars
        -- So i had to move from attachment by opposing corners to attachment by neighboring corners + SetHeight/SetWidth

        f._SetWidth = f.SetWidth
        f.SetWidth = CustomStatusBar_SetWidth
        f._SetHeight = f.SetHeight
        f.SetHeight = CustomStatusBar_SetHeight

        f:SetOrientation(orientation or "HORIZONTAL")

        f:Show()

        return f
    end
end