local _, nMainbar = ...

-- Localization table (fallback: key = value)
nMainbar.L = setmetatable({}, {
    __index = function(t, k) return k end
})