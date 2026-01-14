local ADDON_NAME = ...

local silent = false
--[==[@debug@
silent = true -- do not show localization errors in dev
--@end-debug@]==]

local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "enUS", true --[[isDefault]], silent)

if not L then
    return
end

L["ClassicProfessionFilter"] = true
L["Filter your profession window for specific patterns/recipes"] = true
L["Include materials when searching recipes"] = true
L["Search Materials"] = true

