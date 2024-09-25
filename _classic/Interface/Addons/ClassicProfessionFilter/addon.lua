local ADDON_NAME, ADDON = ...
local MODULE_NAME = "addon"


ADDON[1] = {} -- CPF, Addon
ADDON[2] = {} -- C, Config
ADDON[3] = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME, true) -- L, Locale
local CPF, C, L = unpack(ADDON)

--[==[@debug@
_G["CPF"] = CPF --Expose internals on the Plugin lib
print(ADDON_NAME, MODULE_NAME)
--@end-debug@]==]


---------------------------------------------
-- CONSTANTS
---------------------------------------------
CPF.ADDON_NAME = ADDON_NAME
CPF.VERSION = GetAddOnMetadata(ADDON_NAME, "Version")

CPF.IS_RELEASE_VERSION = CPF.VERSION:match("^%d+.%d+.%d+$") ~= nil
--[==[@debug@
CPF.IS_RELEASE_VERSION = false
--@end-debug@]==]


---------------------------------------------
-- VARIABLES
---------------------------------------------
CPF.isDebug = false

---------------------------------------------
-- METHODS
---------------------------------------------
function CPF:debug(...)
    if ( CPF.isDebug ) then
        print("[" .. CPF.ADDON_NAME .. "]", ...)
    end
end

function CPF:debugf(format, ...)
    if ( CPF.isDebug ) then
        CPF:debug(string.format(format, ...))
    end
end

function CPF:trace(...)
    --[=[@alpha@
    CPF:debug(...)
    --@end-alpha@]=]
end

function CPF:tracef(...)
    --[=[@alpha@
    CPF:debugf(...)
    --@end-alpha@]=]
end

function CPF:strmatch(str, filter)
    --[[
        This algorithm is straight forward. We use string.sub to check all possible substrings
        for a match. A single match is enough and immediately returns true.

        The length of the filter string imposes two important constraints
            1. The length of string.sub
            2. The final index for string.sub

        EXAMPLES
            strmatch("Mooncloth", "cloth") => TRUE
                            "Mooncloth"     "cloth"
                sub(1,5)    |Moonc    |     MISMATCH
                sub(2,6)    | ooncl   |     MISMATCH
                sub(3,7)    |  onclo  |     MISMATCH
                sub(4,8)    |   nclot |     MISMATCH
                sub(5,9)    |    cloth|     MATCH; immediately return true

            strmatch("Mooncloth", "Rune") => FALSE
                            "Mooncloth"     "Rune"
                sub(1,4)    |Moon     |     MISMATCH
                sub(2,5)    | oonc    |     MISMATCH
                sub(3,6)    |  oncl   |     MISMATCH
                sub(4,7)    |   nclo  |     MISMATCH
                sub(5,8)    |    clot |     MISMATCH
                sub(6,9)    |     loth|     MISMATCH

            strmatch("Mooncloth", "Mooncloth") => TRUE
                            "Mooncloth"     "Mooncloth"
                sub(1,9)    |Mooncloth|     MATCH; immediately return true

            strmatch("Mooncloth", "Runecloth") => FALSE
                            "Mooncloth"     "Runecloth"
                sub(1,9)    |Mooncloth|     MISMATCH

            strmatch("Mooncloth", "") => TRUE
                            "Mooncloth"     ""
                sub(1,0)    |         |     MATCH; immediately return true
    ]]

    if ( str and filter ) then
        for i=1, str:len()-filter:len()+1, 1 do
            if ( str:sub(i, i+filter:len()-1) == filter ) then
                return true
            end
        end
    end

    return false
end


---------------------------------------------
-- EVENTS & CALLBACKS
---------------------------------------------
CPF.callbacks = LibStub("CallbackHandler-1.0"):New(CPF)
CPF.eventCallbacks = LibStub("CallbackHandler-1.0"):New(CPF, "RegisterEvent", "UnregisterEvent", false)

local frame = CreateFrame("frame")
frame:SetScript("OnEvent", function(self, event, ...)
    CPF.eventCallbacks:Fire(event, ...)
end)

function CPF.eventCallbacks:OnUsed(target, event)
    frame:RegisterEvent(event)
end
function CPF.eventCallbacks:OnUnused(target, event)
    frame:UnregisterEvent(event)
end

local onDemandInitializers = {}
function CPF:InitializeOnDemand(addonName, func)
    if IsAddOnLoaded(addonName) then
        func()
    else
        onDemandInitializers[addonName] = onDemandInitializers[addonName] or {}
        tinsert(onDemandInitializers[addonName], func)
    end
end
CPF.RegisterEvent("onDemandInitializers", "ADDON_LOADED", function(event, addonName)
    if onDemandInitializers[addonName] then
        for _,initializer in pairs(onDemandInitializers[addonName]) do
            initializer()
        end
    end
end)


---------------------------------------------
-- INITIALIZE
---------------------------------------------
--[==[@debug@
LoadAddOn("Blizzard_DebugTools")
--@end-debug@]==]

CPF.RegisterCallback(MODULE_NAME, "initialize", function(event)
end)

CPF.RegisterEvent(MODULE_NAME, "ADDON_LOADED", function(event, addonName)
    if ( addonName == CPF.ADDON_NAME ) then
        CPF.UnregisterEvent(MODULE_NAME, "ADDON_LOADED")

        -- Initialize addon modules
        CPF.callbacks:Fire("initialize")
    end
end)


