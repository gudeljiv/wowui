-- timer.lua creates s.timer:Start(duration,func) to delay/throttle functions
--
-- s.timer:Start(3,hellofunc) will wait 3 seconds to run hellofunc, restarting the clock if called again.
-- Note: if an inline function is used (s.timer:Start(3,function() print("hi") end)), then each call will
-- start a new timer; it uses the function as a key to which timer to restart

local _,s = ...
s.timer = {}

local times = {} -- lookup by function, the duration to wait before running the function
local running = {} -- ordered list, the current functions waiting to run

local frame = CreateFrame("Frame")
frame:Hide()

-- a function waiting to run will have its duration reset when the timer is restarted
function s.timer:Start(duration,func)
    times[func] = duration
    if not tContains(running,func) then
        tinsert(running,func)
    end
    frame:Show()
end

-- returns whether the given func is waiting to run
function s.timer:IsRunning(func)
    return tContains(running,func)
end

-- stops a timed func waiting to run
function s.timer:Stop(func)
    for i=#running,1,-1 do
        if running[i]==func then
            tremove(running,i)
        end
    end
end

-- every frame, run through each running timer and see if it's ready to run, and run if so
frame:SetScript("OnUpdate",function(self,elapsed)
    local tick = false

    for i=#running,1,-1 do
        local func = running[i]
        times[func] = times[func] - elapsed
        if times[func] < 0 then
            tremove(running,i)
            func(s)
        end
        tick = true
    end

    if not tick then
        self:Hide()
    end
end)
