local name, methods = ...

methods.clientLang = GetLocale()
local clinetError = "Client language not supported. Addon will not work."
methods.title = GetAddOnMetadata("GrimoireKeeper", "title")
methods.version = "v" .. GetAddOnMetadata("GrimoireKeeper", "version")

methods.lang = {}
methods.lang['saved'] = "known grimoires"
methods.lang['reseted'] = "reseted"
methods.lang['usage'] = "usage: /gk [list | reset]"
methods.lang['loaded'] = "loaded"
methods.lang['list'] = "list"
methods.lang['reset'] = "reset"

if methods.clientLang == "frFR" then
    print(methods.title .. ": " .. clinetError)
elseif clientLang == "deDE" then
    print(methods.title .. ": " .. clinetError)
elseif methods.clientLang == "enGB" or methods.clientLang == "enUS" then
    print(methods.title .. " loaded: enGB")
elseif methods.clientLang == "itIT" then
    print(methods.title .. ": " .. clinetError)
elseif methods.clientLang == "koKR" then -- (Korea) RTL - right-to-left
    print(methods.title .. ": " .. clinetError)
elseif methods.clientLang == "zhCN" then -- LTR left-to-right in WoW
    print(methods.title .. ": " .. clinetError)
elseif methods.clientLang == "zhTW" then -- LTR left-to-right in WoW
    print(methods.title .. ": " .. clinetError)
elseif methods.clientLang == "ruRU" then
    print(methods.title .. " загруженный: ruRU")
elseif methods.clientLang == "esES" then
    print(methods.title .. ": " .. clinetError)
elseif methods.clientLang == "esMX" then
    print(methods.title .. ": " .. clinetError)
elseif methods.clientLang == "ptBR" then
    print(methods.title .. ": " .. clinetError)
else
    print(methods.title .. ": " .. clinetError)
end

-- All spell and all ranks. This is the only way to get all spell ID...

methods.tableSpellRank = {
    -- Imp
    [0] = {3110, 7799, 7800, 7801, 7802, 11762, 11763}, -- Firebolt 1-7
    [1] = {6307, 7804, 7805, 11766, 11767}, -- Blood Pact
    [2] = {2947, 8316, 8317, 11700, 11701}, -- Fire Shiled
    [3] = {4511}, -- Phace shift
    -- Voidwalker
    [4] = {3716, 7809, 7810, 7811, 11774, 11775}, -- Torment
    [5] = {7812, 19438, 19440, 19441, 19442, 19443}, -- Secrifice
    [6] = {17767, 17850, 17851, 17852, 17853, 17854}, -- Consume Shadows
    [7] = {17735, 17750, 17751, 17752}, -- Suffering
    -- Succubus
    [8] = {7814, 7815, 7816, 11778, 11779, 11780}, -- Lash of Pain
    [9] = {6360, 7813, 11784, 11785}, -- Shooting Kiss
    [10] = {6358}, -- Seduction
    [11] = {7870}, -- Lesser Invisibility
    -- Felhunter
    [12] = {19505, 19731, 19734, 19736}, -- Devour Magic
    [13] = {19478, 19655, 19656, 19660}, -- Tainted Blood
    [14] = {19244, 19647}, -- Spell Lock
    -- Paranoia
    [15] = {19480}
}

-- There is no connection between SpellID and ItemID. So we need to connect them

methods.tableSpellIdToItemId = {
    -- Firebolt 1-7
    [3110] = nil, [7799] = 16302, [7800] = 16316, [7801] = 16317, [7802] = 16318, [11762] = 16319, [1176] = 16320,
    -- Blood pact 1-5
    [6307] = 16321, [7804] = 16322, [7805] = 16323, [11766] = 16324, [1176] = 16325,
    -- Fire Shild
    [2947] = 16326, [8316] = 16327, [8317] = 16328, [11700] = 16329, [11701] = 16330,
    -- Phase shift
    [4511] = 16331,
    -- Torment
    [3716] = nil, [7809] = 16346, [7810] = 16347, [7811] = 16348,[11774] = 16349, [11775] = 16350,
    -- Secrifice
    [7812] = 16351, [19438] = 16352, [19440] = 16353, [19441] = 16354, [19442] = 16355, [1944] = 16356,
    -- Consume Shadows
    [17767] = 16357, [17850] = 16358, [17851] = 16359, [17852] = 16360, [17853] = 16361, [17854] = 16362,
    -- Suffering
    [17735] = 16363, [17750] = 16364, [17751] = 16365, [17752] = 16366,
     -- Lash of Pain
    [7814] = nil, [7815] = 16368, [7816] = 16371, [11778] = 16372, [11779] = 16373, [11780] = 16374,
    -- Shooting Kiss
    [6360] = 16375, [7813] = 16376, [11784] = 16377, [11785] = 16378,
    -- Seduction
    [6358] = 16379,
    -- Lesser Invisibility
    [7870] = 16380,
    -- Devour Magic
    [19505] = nil, [19731] = 16381, [19734] = 16382, [19736] = 16383,
    -- Tainted Blood
    [19478] = 16384, [19655] = 16385, [19656] = 16386, [19660] = 16387,
    -- Spell Lock
    [19244] = 16388, [19647] = 16389,
    -- Paranoia
    [19480] = 16390,
}

methods.SummonPetIds = {
    [688] = true, -- Imp
    [691] = true, -- Felhunter
    [697] = true, -- Voidwalker
    [712] = true -- Succubus
}
