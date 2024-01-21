local select, string_lower, pairs = select, string.lower, pairs
local GetSpellInfo = GetSpellInfo
local LibStub = LibStub

local Core = LibStub("TotemPlates")
local L = Core.L

Core.frameStrata = {
    BACKGROUND = L["Background"] .. "(0)",
    LOW = L["Low"] .. "(1)",
    MEDIUM = L["Medium"] .. "(2)",
    HIGH = L["High"] .. "(3)",
    DIALOG = L["Dialog"] .. "(4)",
    FULLSCREEN = L["Fullscreen"] .. "(5)",
    FULLSCREEN_DIALOG = L["Fullscreen Dialog"] .. "(6)",
    TOOLTIP = L["Tooltip"] .. "(7)",
}

Core.frameStrataSorting = {
    [1] = "BACKGROUND",
    [2] = "LOW",
    [3] = "MEDIUM",
    [4] = "HIGH",
    [5] = "DIALOG",
    [6] = "FULLSCREEN",
    [7] = "FULLSCREEN_DIALOG",
    [8] = "TOOLTIP",
}

function Core:GetIconStyles()
    return
    {
        ["Interface\\AddOns\\TotemPlates\\Images\\Border_rounded_blp"] = L["Gladdy Tooltip round"],
        ["Interface\\AddOns\\TotemPlates\\Images\\Border_squared_blp"] = L["Gladdy Tooltip squared"],
        ["Interface\\AddOns\\TotemPlates\\Images\\Border_Gloss"] = L["Gloss (black border)"],
    }
end

---------------------
-- TOTEM STUFF
---------------------

local totemData = {
    -- Fire
    [string_lower("Searing Totem")] = {id = 3599,texture = select(3, GetSpellInfo(3599)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Flametongue Totem")] = {id = 8227,texture = select(3, GetSpellInfo(8227)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Magma Totem")] = {id = 8190,texture = select(3, GetSpellInfo(8190)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 2},
    [string_lower("Fire Nova Totem")] = {id = 1535,texture = select(3, GetSpellInfo(1535)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = { cd = 4, once = true }},
    [string_lower("Frost Resistance Totem")] = {id = 8181,texture = select(3, GetSpellInfo(8181)), color = {r = 0, g = 0, b = 0, a = 1}},
    -- Water
    [string_lower("Fire Resistance Totem")] = {id = 8184,texture = select(3, GetSpellInfo(8184)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Disease Cleansing Totem")] = {id = 8170,texture = select(3, GetSpellInfo(8170)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 5},
    [string_lower("Healing Stream Totem")] = {id = 5394,texture = select(3, GetSpellInfo(5394)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 2},
    [string_lower("Mana Tide Totem")] = {id = 16190,texture = select(3, GetSpellInfo(16190)), color = {r = 0.078, g = 0.9, b = 0.16, a = 1}, pulse = 3 },
    [string_lower("Mana Spring Totem")] = {id = 5675,texture = select(3, GetSpellInfo(5675)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 2},
    -- Earth
    [string_lower("Earthbind Totem")] = {id = 2484,texture = select(3, GetSpellInfo(2484)), color = {r = 0.5, g = 0.5, b = 0.5, a = 1}, pulse = 3},
    [string_lower("Stoneclaw Totem")] = {id = 5730,texture = select(3, GetSpellInfo(5730)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 2},
    [string_lower("Stoneskin Totem")] = {id = 8071,texture = select(3, GetSpellInfo(8071)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Strength of Earth Totem")] = {id = 8075,texture = select(3, GetSpellInfo(8075)), color = {r = 0, g = 0, b = 0, a = 1}},

    [string_lower("Tremor Totem")] = {id = 8143,texture = select(3, GetSpellInfo(8143)), color = {r = 1, g = 0.9, b = 0.1, a = 1}, pulse = 3},
    -- Air
    [string_lower("Grounding Totem")] = {id = 8177,texture = select(3, GetSpellInfo(8177)), color = {r = 0, g = 0.53, b = 0.92, a = 1}},
    [string_lower("Nature Resistance Totem")] = {id = 10595,texture = select(3, GetSpellInfo(10595)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Windfury Totem")] = {id = 8512,texture = select(3, GetSpellInfo(8512)), color = {r = 0.96, g = 0, b = 0.07, a = 1}},
    [string_lower("Sentry Totem")] = {id = 6495, texture = select(3, GetSpellInfo(6495)), color = {r = 0, g = 0, b = 0, a = 1}},
}

local totemSpellIdToPulse = {
    [GetSpellInfo(totemData[string_lower("Earthbind Totem")].id)] = totemData[string_lower("Earthbind Totem")].pulse,
    [2484] = totemData[string_lower("Earthbind Totem")].pulse,
    [GetSpellInfo(totemData[string_lower("Tremor Totem")].id)] = totemData[string_lower("Tremor Totem")].pulse,
    [8143] = totemData[string_lower("Tremor Totem")].pulse,
    [GetSpellInfo(totemData[string_lower("Disease Cleansing Totem")].id)] = totemData[string_lower("Disease Cleansing Totem")].pulse,
    [8170] = totemData[string_lower("Disease Cleansing Totem")].pulse,
    [GetSpellInfo(totemData[string_lower("Fire Nova Totem")].id)] = totemData[string_lower("Fire Nova Totem")].pulse,
    [1535] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 1
    [8498] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 2
    [8499] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 3
    [11314] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 4
    [11315] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 5
    [25546] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 6
    [25547] = totemData[string_lower("Fire Nova Totem")].pulse, -- Rank 7
    [GetSpellInfo(totemData[string_lower("Magma Totem")].id)] = totemData[string_lower("Magma Totem")].pulse,
    [8190] = totemData[string_lower("Magma Totem")].pulse, -- Rank 1
    [10585] = totemData[string_lower("Magma Totem")].pulse, -- Rank 2
    [10586] = totemData[string_lower("Magma Totem")].pulse, -- Rank 3
    [10587] = totemData[string_lower("Magma Totem")].pulse, -- Rank 4
    [25552] = totemData[string_lower("Magma Totem")].pulse, -- Rank 5
    [58731] = totemData[string_lower("Magma Totem")].pulse, -- Rank 6
    [58734] = totemData[string_lower("Magma Totem")].pulse, -- Rank 7
    [GetSpellInfo(totemData[string_lower("Healing Stream Totem")].id)] = totemData[string_lower("Healing Stream Totem")].pulse,
    [5394] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 1
    [6375] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 2
    [6377] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 3
    [10462] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 4
    [10463] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 5
    [25567] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 6
    [58755] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 7
    [58756] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 8
    [58757] = totemData[string_lower("Healing Stream Totem")].pulse, -- Rank 9
    [GetSpellInfo(totemData[string_lower("Mana Tide Totem")].id)] = totemData[string_lower("Mana Tide Totem")].pulse,
    [16190] = totemData[string_lower("Mana Tide Totem")].pulse, -- Rank 1
    [GetSpellInfo(totemData[string_lower("Stoneclaw Totem")].id)] = totemData[string_lower("Stoneclaw Totem")].pulse,
    [5730] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 1
    [6390] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 2
    [6391] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 3
    [6392] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 4
    [10427] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 5
    [10428] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 6
    [25525] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 7
    [58580] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 8
    [58581] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 9
    [58582] = totemData[string_lower("Stoneclaw Totem")].pulse, -- Rank 10
}

local totemNpcIdsToTotemData = {
    --fire
    [2523] = totemData[string_lower("Searing Totem")],
    [3902] = totemData[string_lower("Searing Totem")],
    [3903] = totemData[string_lower("Searing Totem")],
    [3904] = totemData[string_lower("Searing Totem")],
    [7400] = totemData[string_lower("Searing Totem")],
    [7402] = totemData[string_lower("Searing Totem")],
    [15480] = totemData[string_lower("Searing Totem")],
    [31162] = totemData[string_lower("Searing Totem")],
    [31164] = totemData[string_lower("Searing Totem")],
    [31165] = totemData[string_lower("Searing Totem")],
    [21995] = totemData[string_lower("Searing Totem")],
    [22209] = totemData[string_lower("Searing Totem")],
    [22895] = totemData[string_lower("Searing Totem")],
    [22896] = totemData[string_lower("Searing Totem")],
    [34687] = totemData[string_lower("Searing Totem")],
    [36532] = totemData[string_lower("Searing Totem")],
    [43423] = totemData[string_lower("Searing Totem")],
    [67380] = totemData[string_lower("Searing Totem")],
    [73477] = totemData[string_lower("Searing Totem")],
    [79238] = totemData[string_lower("Searing Totem")],
    [22896] = totemData[string_lower("Searing Totem")],
    [84519] = totemData[string_lower("Searing Totem")],
    [110730] = totemData[string_lower("Searing Totem")],
    [132178] = totemData[string_lower("Searing Totem")],
    [9637] = totemData[string_lower("Searing Totem")],

    [5950] = totemData[string_lower("Flametongue Totem")],
    [6012] = totemData[string_lower("Flametongue Totem")],
    [7423] = totemData[string_lower("Flametongue Totem")],
    [10557] = totemData[string_lower("Flametongue Totem")],
    [15485] = totemData[string_lower("Flametongue Totem")],
    [31132] = totemData[string_lower("Flametongue Totem")],
    [31133] = totemData[string_lower("Flametongue Totem")],
    [31158] = totemData[string_lower("Flametongue Totem")],
    [42605] = totemData[string_lower("Flametongue Totem")],

    [5929] = totemData[string_lower("Magma Totem")],
    [7464] = totemData[string_lower("Magma Totem")],
    [7465] = totemData[string_lower("Magma Totem")],
    [7466] = totemData[string_lower("Magma Totem")],
    [15484] = totemData[string_lower("Magma Totem")],
    [31166] = totemData[string_lower("Magma Totem")],
    [31167] = totemData[string_lower("Magma Totem")],
    [32887] = totemData[string_lower("Magma Totem")],
    [42211] = totemData[string_lower("Magma Totem")],
    [71335] = totemData[string_lower("Magma Totem")],
    [71925] = totemData[string_lower("Magma Totem")],
    [73085] = totemData[string_lower("Magma Totem")],
    [73093] = totemData[string_lower("Magma Totem")],
    [73268] = totemData[string_lower("Magma Totem")],
    [88971] = totemData[string_lower("Magma Totem")],
    [97369] = totemData[string_lower("Magma Totem")],
    [98676] = totemData[string_lower("Magma Totem")],

    [5879] = totemData[string_lower("Fire Nova Totem")],
    [6110] = totemData[string_lower("Fire Nova Totem")],
    [6111] = totemData[string_lower("Fire Nova Totem")],
    [7844] = totemData[string_lower("Fire Nova Totem")],
    [7845] = totemData[string_lower("Fire Nova Totem")],
    [14662] = totemData[string_lower("Fire Nova Totem")],
    [15482] = totemData[string_lower("Fire Nova Totem")],
    [15483] = totemData[string_lower("Fire Nova Totem")],
    [24320] = totemData[string_lower("Fire Nova Totem")],
    [32775] = totemData[string_lower("Fire Nova Totem")],
    [32776] = totemData[string_lower("Fire Nova Totem")],

    [17539] = totemData[string_lower("Totem of Wrath")],
    [22970] = totemData[string_lower("Totem of Wrath")],
    [22971] = totemData[string_lower("Totem of Wrath")],
    [30652] = totemData[string_lower("Totem of Wrath")],
    [30653] = totemData[string_lower("Totem of Wrath")],
    [30654] = totemData[string_lower("Totem of Wrath")],

    [15439] = totemData[string_lower("Fire Elemental Totem")],
    [40830] = totemData[string_lower("Fire Elemental Totem")],
    [41337] = totemData[string_lower("Fire Elemental Totem")],
    [41346] = totemData[string_lower("Fire Elemental Totem")],
    [72301] = totemData[string_lower("Fire Elemental Totem")],

    [5926] = totemData[string_lower("Frost Resistance Totem")],
    [7412] = totemData[string_lower("Frost Resistance Totem")],
    [7413] = totemData[string_lower("Frost Resistance Totem")],
    [15486] = totemData[string_lower("Frost Resistance Totem")],
    [31171] = totemData[string_lower("Frost Resistance Totem")],
    [31172] = totemData[string_lower("Frost Resistance Totem")],

    -- Water
    [5927] = totemData[string_lower("Fire Resistance Totem")],
    [7424] = totemData[string_lower("Fire Resistance Totem")],
    [7425] = totemData[string_lower("Fire Resistance Totem")],
    [15487] = totemData[string_lower("Fire Resistance Totem")],
    [31169] = totemData[string_lower("Fire Resistance Totem")],
    [31170] = totemData[string_lower("Fire Resistance Totem")],

    [5924] = totemData[string_lower("Disease Cleansing Totem")],

    [3527] = totemData[string_lower("Healing Stream Totem")],
    [3906] = totemData[string_lower("Healing Stream Totem")],
    [3907] = totemData[string_lower("Healing Stream Totem")],
    [3908] = totemData[string_lower("Healing Stream Totem")],
    [3909] = totemData[string_lower("Healing Stream Totem")],
    [14664] = totemData[string_lower("Healing Stream Totem")],
    [15488] = totemData[string_lower("Healing Stream Totem")],
    [18235] = totemData[string_lower("Healing Stream Totem")],
    [31181] = totemData[string_lower("Healing Stream Totem")],
    [31182] = totemData[string_lower("Healing Stream Totem")],
    [31185] = totemData[string_lower("Healing Stream Totem")],
    [34686] = totemData[string_lower("Healing Stream Totem")],
    [36542] = totemData[string_lower("Healing Stream Totem")],
    [37810] = totemData[string_lower("Healing Stream Totem")],
    [38428] = totemData[string_lower("Healing Stream Totem")],
    [47077] = totemData[string_lower("Healing Stream Totem")],
    [72309] = totemData[string_lower("Healing Stream Totem")],
    [72457] = totemData[string_lower("Healing Stream Totem")],
    [73890] = totemData[string_lower("Healing Stream Totem")],
    [74433] = totemData[string_lower("Healing Stream Totem")],
    [97508] = totemData[string_lower("Healing Stream Totem")],
    [112567] = totemData[string_lower("Healing Stream Totem")],
    [120357] = totemData[string_lower("Healing Stream Totem")],
    [128539] = totemData[string_lower("Healing Stream Totem")],
    [132049] = totemData[string_lower("Healing Stream Totem")],

    [10467] = totemData[string_lower("Mana Tide Totem")],
    [11100] = totemData[string_lower("Mana Tide Totem")],
    [11101] = totemData[string_lower("Mana Tide Totem")],
    [17061] = totemData[string_lower("Mana Tide Totem")],

    [3573] = totemData[string_lower("Mana Spring Totem")],
    [7414] = totemData[string_lower("Mana Spring Totem")],
    [7415] = totemData[string_lower("Mana Spring Totem")],
    [7416] = totemData[string_lower("Mana Spring Totem")],
    [15304] = totemData[string_lower("Mana Spring Totem")],
    [15489] = totemData[string_lower("Mana Spring Totem")],
    [31186] = totemData[string_lower("Mana Spring Totem")],
    [31189] = totemData[string_lower("Mana Spring Totem")],
    [31190] = totemData[string_lower("Mana Spring Totem")],

    -- Earth
    [2630] = totemData[string_lower("Earthbind Totem")],
    [22486] = totemData[string_lower("Earthbind Totem")],
    [40233] = totemData[string_lower("Earthbind Totem")],
    [74737] = totemData[string_lower("Earthbind Totem")],
    [79155] = totemData[string_lower("Earthbind Totem")],

    [3579] = totemData[string_lower("Stoneclaw Totem")],
    [3911] = totemData[string_lower("Stoneclaw Totem")],
    [3912] = totemData[string_lower("Stoneclaw Totem")],
    [3913] = totemData[string_lower("Stoneclaw Totem")],
    [7398] = totemData[string_lower("Stoneclaw Totem")],
    [7399] = totemData[string_lower("Stoneclaw Totem")],
    [14870] = totemData[string_lower("Stoneclaw Totem")],
    [15478] = totemData[string_lower("Stoneclaw Totem")],
    [31120] = totemData[string_lower("Stoneclaw Totem")],
    [31121] = totemData[string_lower("Stoneclaw Totem")],
    [31122] = totemData[string_lower("Stoneclaw Totem")],
    [40258] = totemData[string_lower("Stoneclaw Totem")],
    [102402] = totemData[string_lower("Stoneclaw Totem")],

    [5873] = totemData[string_lower("Stoneskin Totem")],
    [5919] = totemData[string_lower("Stoneskin Totem")],
    [5920] = totemData[string_lower("Stoneskin Totem")],
    [7366] = totemData[string_lower("Stoneskin Totem")],
    [7367] = totemData[string_lower("Stoneskin Totem")],
    [7368] = totemData[string_lower("Stoneskin Totem")],
    [14663] = totemData[string_lower("Stoneskin Totem")],
    [15470] = totemData[string_lower("Stoneskin Totem")],
    [15474] = totemData[string_lower("Stoneskin Totem")],
    [18177] = totemData[string_lower("Stoneskin Totem")],
    [21994] = totemData[string_lower("Stoneskin Totem")],
    [31175] = totemData[string_lower("Stoneskin Totem")],
    [31176] = totemData[string_lower("Stoneskin Totem")],
    [36550] = totemData[string_lower("Stoneskin Totem")],
    [40267] = totemData[string_lower("Stoneskin Totem")],
    [41967] = totemData[string_lower("Stoneskin Totem")],

    [5874] = totemData[string_lower("Strength of Earth Totem")],
    [5921] = totemData[string_lower("Strength of Earth Totem")],
    [5922] = totemData[string_lower("Strength of Earth Totem")],
    [7403] = totemData[string_lower("Strength of Earth Totem")],
    [15464] = totemData[string_lower("Strength of Earth Totem")],
    [15479] = totemData[string_lower("Strength of Earth Totem")],
    [21992] = totemData[string_lower("Strength of Earth Totem")],
    [30647] = totemData[string_lower("Strength of Earth Totem")],
    [31129] = totemData[string_lower("Strength of Earth Totem")],
    [40266] = totemData[string_lower("Strength of Earth Totem")],

    [15430] = totemData[string_lower("Earth Elemental Totem")],
    [24649] = totemData[string_lower("Earth Elemental Totem")],
    [39387] = totemData[string_lower("Earth Elemental Totem")],
    [40247] = totemData[string_lower("Earth Elemental Totem")],
    [72307] = totemData[string_lower("Earth Elemental Totem")],

    [5913] = totemData[string_lower("Tremor Totem")],
    [41938] = totemData[string_lower("Tremor Totem")],
    [41939] = totemData[string_lower("Tremor Totem")],

    -- Air
    [5925] = totemData[string_lower("Grounding Totem")],
    [128537] = totemData[string_lower("Grounding Totem")],
    [136251] = totemData[string_lower("Grounding Totem")],

    [7467] = totemData[string_lower("Nature Resistance Totem")],
    [7468] = totemData[string_lower("Nature Resistance Totem")],
    [7469] = totemData[string_lower("Nature Resistance Totem")],
    [15490] = totemData[string_lower("Nature Resistance Totem")],
    [31173] = totemData[string_lower("Nature Resistance Totem")],
    [31174] = totemData[string_lower("Nature Resistance Totem")],

    [6112] = totemData[string_lower("Windfury Totem")],
    [7483] = totemData[string_lower("Windfury Totem")],
    [7484] = totemData[string_lower("Windfury Totem")],
    [14666] = totemData[string_lower("Windfury Totem")],
    [15496] = totemData[string_lower("Windfury Totem")],
    [15497] = totemData[string_lower("Windfury Totem")],
    [22897] = totemData[string_lower("Windfury Totem")],
    [41940] = totemData[string_lower("Windfury Totem")],
    [41941] = totemData[string_lower("Windfury Totem")],
    [80703] = totemData[string_lower("Windfury Totem")],
    [105690] = totemData[string_lower("Windfury Totem")],
    [133684] = totemData[string_lower("Windfury Totem")],

    [3968] = totemData[string_lower("Sentry Totem")],
    [28938] = totemData[string_lower("Sentry Totem")],
    [40187] = totemData[string_lower("Sentry Totem")],
    [69505] = totemData[string_lower("Sentry Totem")],
    [70413] = totemData[string_lower("Sentry Totem")],
    [71145] = totemData[string_lower("Sentry Totem")],
    [147410] = totemData[string_lower("Sentry Totem")],

    [15447] = totemData[string_lower("Wrath of Air Totem")],
    [36556] = totemData[string_lower("Wrath of Air Totem")],
}

function Core:GetSharedTotemData()
    return totemData, totemNpcIdsToTotemData, totemSpellIdToPulse
end

function Core:AddEntriesToTable(table, entries)
    for k,v in pairs(entries) do
        if not table[k] then
            table[k] = v
        end
    end
end