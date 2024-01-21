local setmetatable = setmetatable
local GetLocale = GetLocale

local L = {}

if (GetLocale() == "ruRU") then

end

LibStub("TotemPlates").L = setmetatable(L, {
    __index = function(t, k)
        return k
    end
})