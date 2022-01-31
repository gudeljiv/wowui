
local _, ns = ...
local config = ns.Config

local select = select

local fmod = math.fmod
local floor = math.floor
local gsub = string.gsub
local format = string.format

local day, hour, minute = 86400, 3600, 60

local function FormatValue(value)
    if value < 1e3 then
        return floor(value)
    elseif value >= 1e12 then
        return string.format("%.3ft", value/1e12)
    elseif value >= 1e9 then
        return string.format("%.3fb", value/1e9)
    elseif value >= 1e6 then
        return string.format("%.2fm", value/1e6)
    elseif value >= 1e3 then
        return string.format("%.1fk", value/1e3)
    end
end

local function DeficitValue(value)
    if value == 0 then
        return ""
    else
        return "-"..FormatValue(value)
    end
end

ns.cUnit = function(unit)
    if unit:match("vehicle") then
        return "player"
    elseif unit:match("party%d") then
        return "party"
    elseif unit:match("arena%d") then
        return "arena"
    elseif unit:match("boss%d") then
        return "boss"
    elseif unit:match("partypet%d") then
        return "pet"
    else
        return unit
    end
end

ns.FormatTime = function(time)
    if time >= day then
        return format("%dd", floor(time/day + 0.5))
    elseif time>= hour then
        return format("%dh", floor(time/hour + 0.5))
    elseif time >= minute then
        return format("%dm", floor(time/minute + 0.5))
    end

    return format("%d", fmod(time, minute))
end

local function GetUnitStatus(unit)
    if UnitIsDead(unit) then
        return DEAD
    elseif UnitIsGhost(unit) then
        return "Ghost"
    elseif not UnitIsConnected(unit) then
        return PLAYER_OFFLINE
    else
        return ""
    end
end

local function GetFormattedText(text, cur, max, alt)
    local perc = (cur/max)*100

    if alt then
        text = gsub(text, "$alt", ((alt > 0) and format("%s", FormatValue(alt)) or ""))
    end

    local r, g, b = oUF.ColorGradient(cur, max, unpack(oUF.smoothGradient or oUF.colors.smooth))
    text = gsub(text, "$cur", format("%s", (cur > 0 and FormatValue(cur)) or ""))
    text = gsub(text, "$max", format("%s", FormatValue(max)))
    text = gsub(text, "$deficit", format("%s", DeficitValue(max-cur)))
    text = gsub(text, "$perc", format("%d", perc).."%%")
    text = gsub(text, "$smartperc", format("%d", perc))
    text = gsub(text, "$smartcolorperc", format("|cff%02x%02x%02x%d|r", r*255, g*255, b*255, perc))
    text = gsub(text, "$colorperc", format("|cff%02x%02x%02x%d", r*255, g*255, b*255, perc).."%%|r")

    return text
end

ns.GetHealthText = function(unit, cur, max)
    local uconf = config.units[ns.cUnit(unit)]

    if not cur then
        cur = UnitHealth(unit)
        max = UnitHealthMax(unit)
    end

    local healthString
    if UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit) then
        healthString = GetUnitStatus(unit)
    elseif cur == max and uconf and uconf.healthTagFull then
        healthString = GetFormattedText(uconf.healthTagFull, cur, max)
    elseif uconf and uconf.healthTag then
        healthString = GetFormattedText(uconf.healthTag, cur, max)
    else
        if cur == max then
            healthString = FormatValue(cur)
        else
            healthString = FormatValue(cur).."/"..FormatValue(max)
        end
    end

    return healthString
end

ns.GetPowerText = function(unit, cur, max)
    local uconf = config.units[ns.cUnit(unit)]

    if not cur then
        max = UnitPower(unit)
        cur = UnitPowerMax(unit)
    end

    local alt = UnitPower(unit, ALTERNATE_POWER_INDEX)
    local powerType = UnitPowerType(unit)

    local powerString
    if UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit) then
        powerString = ""
    elseif max == 0 then
        powerString = ""
    elseif not UnitHasMana(unit) or powerType ~= 0 or UnitHasVehicleUI(unit) and uconf and uconf.powerTagNoMana then
        powerString = GetFormattedText(uconf.powerTagNoMana, cur, max, alt)
    elseif (cur == max) and uconf and uconf.powerTagFull then
        powerString = GetFormattedText(uconf.powerTagFull, cur, max, alt)
    elseif uconf and uconf.powerTag then
        powerString = GetFormattedText(uconf.powerTag, cur, max, alt)

    else
        if cur == max then
            powerString = FormatValue(cur)
        else
            powerString = FormatValue(cur).."/"..FormatValue(max)
        end
    end

    return powerString
end

ns.MultiCheck = function(what, ...)
    for i = 1, select("#", ...) do
        if what == select(i, ...) then
            return true
        end
    end

    return false
end

ns.utf8sub = function(string, index)
    local bytes = string:len()
    if bytes <= index then
        return string
    else
        local length, currentIndex = 0, 1

        while currentIndex <= bytes do
            length = length + 1
            local char = string:byte(currentIndex)

            if char > 240 then
                currentIndex = currentIndex + 4
            elseif char > 225 then
                currentIndex = currentIndex + 3
            elseif char > 192 then
                currentIndex = currentIndex + 2
            else
                currentIndex = currentIndex + 1
            end

            if length == index then
                break
            end
        end

        if length == index and currentIndex <= bytes then
            return string:sub(1, currentIndex - 1)
        else
            return string
        end
    end
end
