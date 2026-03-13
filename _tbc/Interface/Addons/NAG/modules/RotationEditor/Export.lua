--- @module "RotationEditor.Export"
--- Export functions for RotationEditor (class format export)
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Module references
local EditorUtils = ns.RotationEditorUtils

-- Localizations
local AceGUI = ns.AceGUI
local WoWAPI = ns.WoWAPI
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local Version = ns.Version

-- Get SpecCompat module
local SpecCompat = NAG:GetModule("SpecCompat")

-- Lua APIs
local format = string.format
local tinsert = tinsert
local tostring = tostring
local type = type
local pairs = pairs
local ipairs = ipairs
local sort = table.sort
local next = next

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local Export = {}
ns.RotationEditorExport = Export

-- ~~~~~~~~~~ UTILITY FUNCTIONS ~~~~~~~~~~

--- Format arbitrary text as a Lua long string literal, preserving inner quotes.
--- @param text any The text to wrap in a long string literal
--- @return string The formatted long string literal
function Export:FormatLongStringLiteral(text)
    local value = tostring(text or "")
    local equals = ""

    while value:find("]" .. equals .. "]", 1, true) do
        equals = equals .. "="
    end

    return format("[%s[%s]%s]", equals, value, equals)
end

-- ~~~~~~~~~~ CLASS FORMAT EXPORT ~~~~~~~~~~

-- Helper functions for rotation serialization
local function SanitizeRotationIdentifier(name)
    local sanitized = (name or "Rotation"):gsub("[^%w]+", "")
    if sanitized == "" then
        sanitized = "Rotation"
    end
    sanitized = sanitized:gsub("^%u", string.lower)
    if sanitized == "" then
        sanitized = "rotation"
    end
    return sanitized .. "Rotation"
end

local function ReserveUniqueName(base, usedNames)
    local name = base
    local index = 2
    while usedNames[name] do
        name = base .. tostring(index)
        index = index + 1
    end
    usedNames[name] = true
    return name
end

function Export:SerializeRotationConfig(config, options)
    options = options or {}
    local lines = {}
    local usedNames = options.usedNames or {}

    local varBase = SanitizeRotationIdentifier(config.name)
    local varName = ReserveUniqueName(varBase, usedNames)

    local className = options.className or config.class or "UNKNOWN"

    tinsert(lines, format("local %s = {", varName))
    tinsert(lines, format("    name = %q,", config.name or "Unnamed"))
    if config.specIndex then
        tinsert(lines, format("    specIndex = %d,", config.specIndex))
    end
    tinsert(lines, format("    class = %q,", className))
    tinsert(lines, format("    default = %s,", tostring(config.default or false)))
    tinsert(lines, format("    enabled = %s,", tostring(config.enabled ~= false)))

    if config.gameType then
        tinsert(lines, format("    gameType = %s,", self:FormatGameType(config.gameType)))
    end

    if config.rotationType then
        tinsert(lines, format("    rotationType = %s,", self:FormatRotationType(config.rotationType)))
    end

    if config.enableSmartSwitching ~= nil then
        tinsert(lines, format("    enableSmartSwitching = %s,", tostring(config.enableSmartSwitching)))
    end

    if config.customConditions and #config.customConditions > 0 then
        tinsert(lines, "")
        tinsert(lines, "    -- Custom conditions for smart switching")
        tinsert(lines, "    customConditions = {")
        for _, condition in ipairs(config.customConditions) do
            tinsert(lines, "        {")
            tinsert(lines, format("            type = ns.CUSTOM_CONDITION_TYPES.%s,", self:FormatConditionType(condition.type)))

            if condition.type == ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT then
                if type(condition.value) == "table" then
                    if condition.value.operator == "range" then
                        tinsert(lines, format("            value = { min = %d, max = %d, operator = %q },",
                            condition.value.min or 1, condition.value.max or 3, condition.value.operator))
                    else
                        tinsert(lines, format("            value = { value = %d, operator = %q },",
                            condition.value.value or 1, condition.value.operator or "gte"))
                    end
                    if condition.value.range then
                        tinsert(lines, format("            range = %d", condition.value.range))
                    end
                end
            elseif condition.type == ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE then
                tinsert(lines, format("            value = %q", condition.value or "dualWield"))
            elseif condition.type == ns.CUSTOM_CONDITION_TYPES.AURA_ACTIVE then
                if type(condition.value) == "table" then
                    tinsert(lines, "            value = {")
                    tinsert(lines, format("                spellId = %d,", condition.value.spellId or condition.value.spellID or 0))
                    tinsert(lines, format("                unit = %q,", condition.value.unit or "player"))
                    tinsert(lines, format("                operator = %q", condition.value.operator or "active"))
                    if condition.value.stacks then
                        tinsert(lines, format(",                stacks = %d", condition.value.stacks))
                    end
                    tinsert(lines, "            }")
                end
            elseif condition.type == ns.CUSTOM_CONDITION_TYPES.GROUP_CONTEXT then
                if type(condition.value) == "table" then
                    tinsert(lines, format("            value = {%s}", table.concat(condition.value, ", ")))
                end
            elseif condition.type == ns.CUSTOM_CONDITION_TYPES.ASSIGNMENT then
                if type(condition.value) == "table" then
                    local assignmentIds = {}
                    for _, assignmentId in ipairs(condition.value) do
                        tinsert(assignmentIds, format("%q", assignmentId))
                    end
                    tinsert(lines, format("            value = {%s}", table.concat(assignmentIds, ", ")))
                elseif type(condition.value) == "string" then
                    tinsert(lines, format("            value = %q", condition.value))
                end
            end

            tinsert(lines, "        },")
        end
        tinsert(lines, "    },")
    end

    if config.prePull and #config.prePull > 0 then
        tinsert(lines, "    prePull = {")
        for _, action in ipairs(config.prePull) do
            tinsert(lines, format('        { time = %s, action = %q },', tostring(action.time), action.action or ""))
        end
        tinsert(lines, "    },")
    end

    if config.lastModified then
        tinsert(lines, format("    lastModified = %q,", EditorUtils.FormatDate(config.lastModified)))
    end

    tinsert(lines, "    rotationString = [[")
    tinsert(lines, config.rotationString or "")
    tinsert(lines, "    ]],")

    if config.spells and #config.spells > 0 then
        tinsert(lines, "    spells = {" .. table.concat(config.spells, ", ") .. "},")
    end
    if config.items and #config.items > 0 then
        tinsert(lines, "    items = {" .. table.concat(config.items, ", ") .. "},")
    end
    if config.auras and #config.auras > 0 then
        tinsert(lines, "    auras = {" .. table.concat(config.auras, ", ") .. "},")
    end
    if config.runes and #config.runes > 0 then
        tinsert(lines, "    runes = {" .. table.concat(config.runes, ", ") .. "},")
    end

    if config.glyphs and (config.glyphs.major or config.glyphs.minor) then
        tinsert(lines, "    glyphs = {")
        if config.glyphs.major and #config.glyphs.major > 0 then
            tinsert(lines, "        major = {" .. table.concat(config.glyphs.major, ", ") .. "},")
        end
        if config.glyphs.minor and #config.glyphs.minor > 0 then
            tinsert(lines, "        minor = {" .. table.concat(config.glyphs.minor, ", ") .. "},")
        end
        tinsert(lines, "    },")
    end

    if config.consumables and next(config.consumables) then
        tinsert(lines, "    consumables = {")
        if config.consumables.prepotId then
            tinsert(lines, format("        prepotId = %d,", config.consumables.prepotId))
        end
        if config.consumables.potId then
            tinsert(lines, format("        potId = %d,", config.consumables.potId))
        end
        if config.consumables.flaskId then
            tinsert(lines, format("        flaskId = %d,", config.consumables.flaskId))
        end
        if config.consumables.foodId then
            tinsert(lines, format("        foodId = %d,", config.consumables.foodId))
        end
        tinsert(lines, "    },")
    end

    if config.useCustomSpellLocations and config.spellLocations and next(config.spellLocations) then
        tinsert(lines, "")
        tinsert(lines, "    -- Rotation-specific spell locations")
        tinsert(lines, "    useCustomSpellLocations = true,")
        tinsert(lines, "    spellLocations = {")

        local spellIds = {}
        for spellId in pairs(config.spellLocations) do
            tinsert(spellIds, spellId)
        end
        sort(spellIds)

        for _, spellId in ipairs(spellIds) do
            local position = config.spellLocations[spellId]
            tinsert(lines, format("        [%d] = %q,", spellId, position))
        end
        tinsert(lines, "    },")
    end

    if config.groups and #config.groups > 0 then
        tinsert(lines, "    groups = {")
        for _, group in ipairs(config.groups) do
            tinsert(lines, "        {")
            tinsert(lines, format("            name = %q,", group.name or ""))
            tinsert(lines, "            actions = {")
            for _, action in ipairs(group.actions or {}) do
                tinsert(lines, format("                %s,", self:FormatLongStringLiteral(action)))
            end
            tinsert(lines, "            }")
            tinsert(lines, "        },")
        end
        tinsert(lines, "    },")
    end

    if config.variables and #config.variables > 0 then
        tinsert(lines, "    variables = {")
        for _, var in ipairs(config.variables) do
            tinsert(lines, "        {")
            tinsert(lines, format("            name = %q,", var.name or ""))
            tinsert(lines, format("            value = %s", self:FormatLongStringLiteral(var.value)))
            tinsert(lines, "        },")
        end
        tinsert(lines, "    },")
    end

    if config.author then
        tinsert(lines, format("    author = %q", config.author))
    elseif config.authors and #config.authors > 0 then
        tinsert(lines, format("    author = %q", config.authors[1]))
    end

    tinsert(lines, "}")

    return table.concat(lines, "\n"), varName
end

--- Format a single rotation config into a class file block (like Monk.lua)
--- @param editorState table|nil Editor state containing workingConfig
--- @return string Serialized rotation block
function Export:FormatRotationForClassFile(editorState)
    if not editorState or not editorState.workingConfig then
        return "-- Invalid editor state"
    end

    local serialized = self:SerializeRotationConfig(editorState.workingConfig, {
        usedNames = {}
    })

    return serialized
end

local function NormalizeSpecConstantName(specName, fallback)
    if not specName or specName == "" then
        return fallback
    end

    local constant = specName:upper()
    constant = constant:gsub("[^%w]+", "_")
    constant = constant:gsub("_+", "_")
    constant = constant:gsub("^_", "")
    constant = constant:gsub("_$", "")
    if constant == "" then
        constant = fallback
    end
    if constant:match("^[%d]") then
        constant = fallback
    end
    return constant
end

function Export:CollectSpecEntries(classToken, rotationsBySpec, specSpellLocations, shouldIncludeSpec)
    local specEntries = {}
    local specIndexToConst = {}

    local function isSpecIncluded(specIndex)
        if not shouldIncludeSpec then
            return true
        end
        return shouldIncludeSpec(specIndex)
    end

    local function addSpecEntry(specIndex, constant, index, isStandard)
        specIndex = tonumber(specIndex) or specIndex
        if not specIndex or specIndexToConst[specIndex] or not isSpecIncluded(specIndex) then
            return
        end
        specIndexToConst[specIndex] = constant
        tinsert(specEntries, {
            specIndex = specIndex,
            constant = constant,
            index = index,
            isStandard = isStandard
        })
    end

    -- Get classID for API calls
    local classID = select(3, UnitClass("player"))
    if not classID then
        -- Try to get from classToken if UnitClass fails
        local classMap = {
            WARRIOR = 1, PALADIN = 2, HUNTER = 3, ROGUE = 4, PRIEST = 5,
            DEATHKNIGHT = 6, SHAMAN = 7, MAGE = 8, WARLOCK = 9, MONK = 10, DRUID = 11
        }
        classID = classMap[classToken]
    end

    if classID then
        local numSpecs = SpecCompat:GetNumSpecsForClass(classID) or 4
        for specIndex = 1, numSpecs do
        local specName = SpecCompat:GetSpecName(specIndex)
            if specName then
                local constant = NormalizeSpecConstantName(specName, "SPEC" .. tostring(specIndex))
                addSpecEntry(specIndex, constant, specIndex, true)  -- Use specIndex as key
            end
        end
    end

    local function ensureSpecEntry(specIndex)
        specIndex = tonumber(specIndex) or specIndex
        if not specIndex or specIndexToConst[specIndex] then
            return
        end
        -- Get spec name from API using specIndex
        local classID = select(3, UnitClass("player"))
        local classMap = {
            WARRIOR = 1, PALADIN = 2, HUNTER = 3, ROGUE = 4, PRIEST = 5,
            DEATHKNIGHT = 6, SHAMAN = 7, MAGE = 8, WARLOCK = 9, MONK = 10, DRUID = 11
        }
        if not classID then
            classID = classMap[classToken]
        end
        local specName = classID and SpecCompat:GetSpecName(specIndex) or nil
        local constant = NormalizeSpecConstantName(specName, "SPEC_" .. tostring(specIndex))
        addSpecEntry(specIndex, constant, specIndex, false)  -- Use specIndex as key
    end

    if rotationsBySpec then
        for specKey, specRotations in pairs(rotationsBySpec) do
            if specRotations and next(specRotations) then
                ensureSpecEntry(specKey)
            end
        end
    end

    if specSpellLocations then
        for specKey, locations in pairs(specSpellLocations) do
            if locations and next(locations) then
                ensureSpecEntry(specKey)
            end
        end
    end

    sort(specEntries, function(a, b)
        if a.isStandard ~= b.isStandard then
            return a.isStandard and not b.isStandard
        end
        if a.isStandard and b.isStandard then
            return a.index < b.index
        end
        return a.index < b.index
    end)

    return specEntries, specIndexToConst
end

local SPELL_POSITION_LOOKUP = {}
do
    for key, value in pairs(NAG.SPELL_POSITIONS or {}) do
        if type(value) == "string" then
            SPELL_POSITION_LOOKUP[value:upper()] = key
        end
    end
end

local POSITION_ORDER = {
    { key = "ABOVE", comment = "-- ABOVE spells" },
    { key = "BELOW", comment = "-- BELOW spells" },
    { key = "RIGHT", comment = "-- RIGHT spells" },
    { key = "LEFT", comment = "-- LEFT spells" },
    { key = "AOE", comment = "-- AOE spells" },
    { key = "PRIMARY", comment = "-- PRIMARY spells" },
    { key = "SEQUENCE", comment = "-- SEQUENCE spells" },
    { key = "IGNORE", comment = "-- IGNORE spells" },
}

local function NormalizePositionKey(position)
    if type(position) ~= "string" then
        return nil
    end
    local upper = position:upper()

    for _, entry in ipairs(POSITION_ORDER) do
        if upper:find(entry.key, 1, true) then
            return entry.key
        end
    end

    if SPELL_POSITION_LOOKUP[upper] then
        return SPELL_POSITION_LOOKUP[upper]
    end

    return upper
end

local function BuildSpellLocationLines(spellMap)
    if not spellMap or not next(spellMap) then
        return { "-- (empty)" }
    end

    local grouped = {}
    for spellID, position in pairs(spellMap) do
        local key = NormalizePositionKey(position)
        grouped[key] = grouped[key] or {}
        tinsert(grouped[key], spellID)
    end

    local lines = {}

    for _, entry in ipairs(POSITION_ORDER) do
        local spells = grouped[entry.key]
        if spells and #spells > 0 then
            sort(spells)
            tinsert(lines, entry.comment)
            for _, spellID in ipairs(spells) do
                local posExpr
                if NAG.SPELL_POSITIONS and NAG.SPELL_POSITIONS[entry.key] then
                    posExpr = "NAG.SPELL_POSITIONS." .. entry.key
                else
                    posExpr = format("%q", tostring(spellMap[spellID]))
                end
                local comment = ""
                local info = WoWAPI and WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellID)
                if info and info.name then
                    comment = format("   -- %s", info.name)
                end
            tinsert(lines, format("[%d] = %s,%s", spellID, posExpr, comment))
            end
            tinsert(lines, "")
        end
        grouped[entry.key] = nil
    end

    for key, spells in pairs(grouped) do
        sort(spells)
        tinsert(lines, format("-- %s spells", key or "UNKNOWN"))
        for _, spellID in ipairs(spells) do
            local posExpr
            if key and NAG.SPELL_POSITIONS and NAG.SPELL_POSITIONS[key] then
                posExpr = "NAG.SPELL_POSITIONS." .. key
            else
                posExpr = format("%q", tostring(spellMap[spellID]))
            end
            local comment = ""
            local info = WoWAPI and WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellID)
            if info and info.name then
                comment = format("   -- %s", info.name)
            end
            tinsert(lines, format("[%d] = %s,%s", spellID, posExpr, comment))
        end
        tinsert(lines, "")
    end

    if lines[#lines] == "" then
        lines[#lines] = nil
    end

    if #lines == 0 then
        tinsert(lines, "-- (empty)")
    end

    return lines
end

function Export:FormatSpecSpellLocations(specSpellLocations, specIndexToConst, includedSpecs)
    if not specSpellLocations or not next(specSpellLocations) then
        return nil
    end

    local specIndices = {}
    for specKey in pairs(specSpellLocations) do
        local specIndex = tonumber(specKey) or specKey
        -- Include if it's a numeric specIndex and is included in export
        if type(specIndex) == "number" and (not includedSpecs or includedSpecs[specIndex]) then
            tinsert(specIndices, specIndex)
        end
    end

    if #specIndices == 0 then
        return nil
    end

    sort(specIndices)

    local function getSpecLocations(specIndex)
        return specSpellLocations[specIndex] or specSpellLocations[tostring(specIndex)]
    end

    local lines = {}
    tinsert(lines, "defaults.class.specSpellLocations = {")

    for _, specIndex in ipairs(specIndices) do
        tinsert(lines, format("    [%d] = {  -- Spec %d", specIndex, specIndex))
        local locationLines = BuildSpellLocationLines(getSpecLocations(specIndex))
        for _, line in ipairs(locationLines) do
            if line == "" then
                tinsert(lines, "")
            else
                tinsert(lines, "        " .. line)
            end
        end
        tinsert(lines, "    },")
    end

    tinsert(lines, "}")
    return table.concat(lines, "\n")
end

function Export:FormatClassModuleFile(editorState, exportOptions)
    if not editorState or not editorState.classModule then
        return "-- Class module not available for export"
    end

    exportOptions = exportOptions or {}

    local classModule = editorState.classModule
    local classToken = (classModule.className or NAG.CLASS_FILENAME or "UNKNOWN"):upper()
    local moduleVarName = classToken

    local rotationsBySpec = (classModule.db and classModule.db.class and classModule.db.class.rotations) or {}
    local specSpellLocations = (classModule.defaults and classModule.defaults.class and classModule.defaults.class.specSpellLocations) or {}

    local selectionMode = exportOptions.mode or "all"
    local selectedRotations = exportOptions.selectedRotations or {}

    local function getSpecRotations(specIndex)
        return rotationsBySpec[specIndex] or rotationsBySpec[tostring(specIndex)]
    end

    local function getSelectedSpecRotations(specIndex)
        return selectedRotations[specIndex] or selectedRotations[tostring(specIndex)]
    end

    local function hasSelectedRotations(specIndex)
        specIndex = tonumber(specIndex) or specIndex
        if selectionMode ~= "selected" then
            local specRotations = getSpecRotations(specIndex)
            return specRotations and next(specRotations) ~= nil
        end
        local specSelection = getSelectedSpecRotations(specIndex)
        if not specSelection then
            return false
        end
        for _, isSelected in pairs(specSelection) do
            if isSelected then
                return true
            end
        end
        return false
    end

    local function isRotationIncluded(specIndex, rotationName)
        specIndex = tonumber(specIndex) or specIndex
        if selectionMode ~= "selected" then
            return true
        end
        local specSelection = getSelectedSpecRotations(specIndex)
        return specSelection and specSelection[rotationName] == true
    end

    local includeSpecCallback
    if selectionMode == "selected" then
        includeSpecCallback = function(specIndex)
            return hasSelectedRotations(specIndex)
        end
    end

    local specEntries, specIndexToConst = self:CollectSpecEntries(classToken, rotationsBySpec, specSpellLocations,
        includeSpecCallback)
    if #specEntries == 0 then
        return "-- No rotations selected for export"
    end

    local usedNames = {}
    local rotationBlocks = {}
    local setupLines = {}
    local includedSpecIndices = {}
    local rotationCount = 0

    for _, entry in ipairs(specEntries) do
        local specIndex = entry.specIndex
        local specRotations = getSpecRotations(specIndex)
        if specRotations and next(specRotations) then
            local rotationNames = {}
            for rotationName in pairs(specRotations) do
                if isRotationIncluded(specIndex, rotationName) then
                    tinsert(rotationNames, rotationName)
                end
            end
            sort(rotationNames)

            for _, rotationName in ipairs(rotationNames) do
                local rotationConfig = EditorUtils.CopyTable(specRotations[rotationName])
                rotationConfig.name = rotationConfig.name or rotationName
                rotationConfig.class = classToken
                rotationConfig.rotationString = rotationConfig.rotationString or ""

                local block, varName = self:SerializeRotationConfig(rotationConfig, {
                    className = classToken,
                    usedNames = usedNames
                })
                tinsert(rotationBlocks, block)

                -- Use direct specIndex number with optional comment
                local specComment = ""
                local specName = specIndexToConst[specIndex] and specIndexToConst[specIndex]:gsub("_", " ") or ""
                if specName and specName ~= "" then
                    specComment = format("  -- %s", specName)
                end
                tinsert(setupLines, format("    ns.AddRotationToDefaults(self.defaults, %d, %s)%s", specIndex, varName, specComment))
                includedSpecIndices[specIndex] = true
                rotationCount = rotationCount + 1
            end
        end
    end

    if rotationCount == 0 then
        return "-- No rotations selected for export"
    end

    local specSpellLocationsBlock = self:FormatSpecSpellLocations(specSpellLocations, specIndexToConst, includedSpecIndices)

    local lines = {}
    tinsert(lines, "local _, ns = ...")
    tinsert(lines, "--- @type NAG|AceAddon")
    tinsert(lines, "local NAG = LibStub(\"AceAddon-3.0\"):GetAddon(\"NAG\")")
    tinsert(lines, "local L = ns.AceLocale:GetLocale(\"NAG\", true)")
    tinsert(lines, "--- @type Version")
    tinsert(lines, "local Version = ns.Version")
    tinsert(lines, "local WoWAPI = ns.WoWAPI")
    tinsert(lines, "")
    tinsert(lines, "local defaults = ns.InitializeClassDefaults()")
    if specSpellLocationsBlock then
        tinsert(lines, specSpellLocationsBlock)
    end
    tinsert(lines, "")
    tinsert(lines, format("if UnitClassBase('player') ~= %q then return end", classToken))
    tinsert(lines, "")

    -- Rotation definitions (before module creation)
    for index, block in ipairs(rotationBlocks) do
        tinsert(lines, block)
        if index ~= #rotationBlocks then
            tinsert(lines, "")
        end
    end

    tinsert(lines, "")
    tinsert(lines, format("--- @class %s : ClassBase", moduleVarName))
    tinsert(lines, format("local %s = NAG:CreateClassModule(%q, defaults)", moduleVarName, classToken))
    tinsert(lines, format("if not %s then return end", moduleVarName))
    tinsert(lines, "")
    tinsert(lines, format("function %s:SetupClassDefaults()", moduleVarName))
    if #setupLines > 0 then
        for _, setupLine in ipairs(setupLines) do
            tinsert(lines, setupLine)
        end
    else
        tinsert(lines, "    -- No rotations to register")
    end
    tinsert(lines, "end")
    tinsert(lines, "")
    tinsert(lines, format("function %s:RegisterSpellTracking()", moduleVarName))
    tinsert(lines, "    -- TODO: Export spell tracking if needed")
    tinsert(lines, "end")
    tinsert(lines, "")
    tinsert(lines, format("NAG.Class = %s", moduleVarName))

    return table.concat(lines, "\n")
end

-- ============================ STANDALONE EXPORT UI ============================

function Export:ShowStandaloneExportUI()
    local classModule = NAG:GetClassModule()
    if not classModule or not classModule.db or not classModule.db.class then
        NAG:Error("Class module not available for export.")
        return
    end

    local rotationsBySpec = classModule.db.class.rotations or {}
    local hasRotations = false
    for _, specRotations in pairs(rotationsBySpec) do
        if specRotations and next(specRotations) then
            hasRotations = true
            break
        end
    end
    if not hasRotations then
        NAG:Error("No rotations available to export.")
        return
    end

    local classToken = (classModule.className or NAG.CLASS_FILENAME or "UNKNOWN"):upper()
    local specSpellLocations = (classModule.defaults and classModule.defaults.class and classModule.defaults.class.specSpellLocations) or {}
    local specEntries = self:CollectSpecEntries(classToken, rotationsBySpec, specSpellLocations)

    if #specEntries == 0 then
        NAG:Error("No rotations available to export.")
        return
    end

    if self.standaloneExportFrame then
        self.standaloneExportFrame:Hide()
        AceGUI:Release(self.standaloneExportFrame)
        self.standaloneExportFrame = nil
    end

    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Rotation Export Browser")
    frame:SetLayout("Fill")
    frame:SetWidth(620)
    frame:SetHeight(720)
    frame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.standaloneExportFrame == widget then
            self.standaloneExportFrame = nil
        end
    end)
    self.standaloneExportFrame = frame

    local function getSpecRotations(specIndex)
        return rotationsBySpec[specIndex] or rotationsBySpec[tostring(specIndex)]
    end

    local selectionState = {}
    for _, entry in ipairs(specEntries) do
        local specIndex = entry.specIndex
        local specRotations = getSpecRotations(specIndex)
        if specRotations and next(specRotations) then
            selectionState[specIndex] = selectionState[specIndex] or {}
            for rotationName in pairs(specRotations) do
                if selectionState[specIndex][rotationName] == nil then
                    selectionState[specIndex][rotationName] = true
                end
            end
        end
    end

    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout("List")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    frame:AddChild(container)

    local info = AceGUI:Create("Label")
    info:SetText("Generate class module exports without opening the visual editor.")
    info:SetFullWidth(true)
    container:AddChild(info)

    local mode = "all"

    local summaryLabel = AceGUI:Create("Label")
    summaryLabel:SetFullWidth(true)
    container:AddChild(summaryLabel)

    local modeDropdown = AceGUI:Create("Dropdown")
    modeDropdown:SetLabel("Export Mode")
    modeDropdown:SetList({
        all = "All rotations",
        selected = "Selected rotations"
    })
    modeDropdown:SetValue("all")
    modeDropdown:SetFullWidth(true)
    container:AddChild(modeDropdown)

    local buttonRow = AceGUI:Create("SimpleGroup")
    buttonRow:SetFullWidth(true)
    buttonRow:SetLayout("Flow")
    container:AddChild(buttonRow)

    local selectAllBtn = AceGUI:Create("Button")
    selectAllBtn:SetText("Select All")
    selectAllBtn:SetWidth(120)
    buttonRow:AddChild(selectAllBtn)

    local selectNoneBtn = AceGUI:Create("Button")
    selectNoneBtn:SetText("Select None")
    selectNoneBtn:SetWidth(120)
    buttonRow:AddChild(selectNoneBtn)

    local generateBtn = AceGUI:Create("Button")
    generateBtn:SetText("Generate Export")
    generateBtn:SetWidth(180)
    buttonRow:AddChild(generateBtn)

    local selectionGroup = AceGUI:Create("InlineGroup")
    selectionGroup:SetTitle("Rotation Selection")
    selectionGroup:SetFullWidth(true)
    selectionGroup:SetFullHeight(true)
    selectionGroup:SetLayout("Fill")
    container:AddChild(selectionGroup)

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    selectionGroup:AddChild(scroll)

    local rotationCheckboxes = {}

    local function getSpecDisplayName(entry)
        local name
        -- Get spec name from API using specIndex
        if entry.specIndex or entry.index then
            local specIndex = entry.specIndex or entry.index
            local classID = select(3, UnitClass("player"))
            local classMap = {
                WARRIOR = 1, PALADIN = 2, HUNTER = 3, ROGUE = 4, PRIEST = 5,
                DEATHKNIGHT = 6, SHAMAN = 7, MAGE = 8, WARLOCK = 9, MONK = 10, DRUID = 11
            }
            if not classID then
                classID = classMap[classToken]
            end
            if classID and specIndex then
                name = SpecCompat:GetSpecName(specIndex)
            end
        end
        return name or format("Spec %s", tostring(entry.specIndex or entry.index or "Unknown"))
    end

    for _, entry in ipairs(specEntries) do
        local specIndex = entry.specIndex
        local specRotations = getSpecRotations(specIndex)
        if specRotations and next(specRotations) then
            local rotationNames = {}
            for rotationName in pairs(specRotations) do
                tinsert(rotationNames, rotationName)
            end
            sort(rotationNames)

            local heading = AceGUI:Create("Heading")
            heading:SetText(getSpecDisplayName(entry) .. format(" (%d)", #rotationNames))
            heading:SetFullWidth(true)
            scroll:AddChild(heading)

            for _, rotationName in ipairs(rotationNames) do
                local checkbox = AceGUI:Create("CheckBox")
                checkbox:SetLabel(rotationName)
                checkbox:SetFullWidth(true)
                checkbox.specIndex = specIndex
                checkbox.rotationName = rotationName
                checkbox:SetValue(selectionState[specIndex][rotationName])
                checkbox:SetCallback("OnValueChanged", function(widget, _, value)
                    selectionState[widget.specIndex][widget.rotationName] = value and true or false
                    updateSummary()
                end)
                scroll:AddChild(checkbox)
                tinsert(rotationCheckboxes, checkbox)
            end
        end
    end

    local function updateSelectionControls()
        local isSelectedMode = mode == "selected"
        for _, checkbox in ipairs(rotationCheckboxes) do
            checkbox:SetDisabled(not isSelectedMode)
        end
        selectAllBtn:SetDisabled(not isSelectedMode)
        selectNoneBtn:SetDisabled(not isSelectedMode)
    end

    local function updateSummary()
        local totalSelected = 0
        local totalRotations = 0
        for _, specRotations in pairs(selectionState) do
            for _, isSelected in pairs(specRotations) do
                totalRotations = totalRotations + 1
                if isSelected then
                    totalSelected = totalSelected + 1
                end
            end
        end

        if mode == "selected" then
            summaryLabel:SetText(format("Rotations selected: %d / %d", totalSelected, totalRotations))
        else
            summaryLabel:SetText(format("All rotations will be exported (%d total).", totalRotations))
        end
    end

    modeDropdown:SetCallback("OnValueChanged", function(_, _, key)
        mode = key or "all"
        updateSelectionControls()
        updateSummary()
    end)

    selectAllBtn:SetCallback("OnClick", function()
        for _, checkbox in ipairs(rotationCheckboxes) do
            checkbox:SetValue(true)
            selectionState[checkbox.specIndex][checkbox.rotationName] = true
        end
        updateSummary()
    end)

    selectNoneBtn:SetCallback("OnClick", function()
        for _, checkbox in ipairs(rotationCheckboxes) do
            checkbox:SetValue(false)
            selectionState[checkbox.specIndex][checkbox.rotationName] = false
        end
        updateSummary()
    end)

    generateBtn:SetCallback("OnClick", function()
        local editorState = { classModule = classModule }
        if mode ~= "selected" then
            self:ShowClassModuleExport(editorState, { mode = "all" })
            return
        end

        local selected = {}
        local hasSelection = false
        for specIndex, specRotations in pairs(selectionState) do
            for rotationName, isSelected in pairs(specRotations) do
                if isSelected then
                    selected[specIndex] = selected[specIndex] or {}
                    selected[specIndex][rotationName] = true
                    hasSelection = true
                end
            end
        end

        if not hasSelection then
            NAG:Error("Select at least one rotation to export.")
            return
        end

        self:ShowClassModuleExport(editorState, {
            mode = "selected",
            selectedRotations = selected
        })
    end)

    local function initializeCheckboxStates()
        for _, checkbox in ipairs(rotationCheckboxes) do
            local isSelected = selectionState[checkbox.specIndex][checkbox.rotationName]
            checkbox:SetValue(isSelected)
        end
    end

    initializeCheckboxStates()
    updateSelectionControls()
    updateSummary()
end

--- Format game type enum
--- @param gameType number The game type value
--- @return string The formatted enum name
function Export:FormatGameType(gameType)
    -- Map numeric values to enum names
    if gameType == 1 then return "Version.GAME_TYPES.RETAIL"
    elseif gameType == 2 then return "Version.GAME_TYPES.CLASSIC_VANILLA"
    elseif gameType == 3 then return "Version.GAME_TYPES.CLASSIC_TBC"
    elseif gameType == 4 then return "Version.GAME_TYPES.CLASSIC_WRATH"
    elseif gameType == 5 then return "Version.GAME_TYPES.CLASSIC_CATA"
    elseif gameType == 6 then return "Version.GAME_TYPES.CLASSIC_MISTS"
    else return tostring(gameType)
    end
end

--- Format rotation type enum
--- @param rotationType string The rotation type value
--- @return string The formatted enum name
function Export:FormatRotationType(rotationType)
    if rotationType == ns.ROTATION_TYPES.SINGLE_TARGET then
        return "ns.ROTATION_TYPES.SINGLE_TARGET"
    elseif rotationType == ns.ROTATION_TYPES.AOE then
        return "ns.ROTATION_TYPES.AOE"
    elseif rotationType == ns.ROTATION_TYPES.CUSTOM then
        return "ns.ROTATION_TYPES.CUSTOM"
    else
        return format("%q", tostring(rotationType))
    end
end

--- Format condition type enum
--- @param conditionType string The condition type value
--- @return string The formatted enum constant name
function Export:FormatConditionType(conditionType)
    -- Map condition type values to their constant names
    if conditionType == ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE then
        return "WEAPON_TYPE"
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT then
        return "TARGET_COUNT"
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.AURA_ACTIVE then
        return "AURA_ACTIVE"
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.GROUP_CONTEXT then
        return "GROUP_CONTEXT"
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.ASSIGNMENT then
        return "ASSIGNMENT"
    elseif conditionType == ns.CUSTOM_CONDITION_TYPES.CUSTOM_FUNCTION then
        return "CUSTOM_FUNCTION"
    else
        return tostring(conditionType):upper():gsub("[^%w_]", "_")
    end
end

--- Show class format export dialog
--- @param editorState table The editor state for this instance
function Export:ShowClassFormatExport(editorState)
    local formatted = self:FormatRotationForClassFile(editorState)

    -- Create display frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Export Rotation - Class File Format")
    frame:SetLayout("Fill")
    frame:SetWidth(900)
    frame:SetHeight(700)
    frame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
    end)

    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout("List")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    frame:AddChild(container)

    -- Info label
    local info = AceGUI:Create("Label")
    info:SetText("Copy this into your class file (e.g., Monk.lua)")
    info:SetFullWidth(true)
    container:AddChild(info)

    -- Code display
    local codeBox = AceGUI:Create("MultiLineEditBox")
    codeBox:SetLabel("Rotation Code")
    codeBox:SetText(formatted)
    codeBox:SetFullWidth(true)
    codeBox:SetFullHeight(true)
    codeBox:SetNumLines(30)

    -- Enable syntax highlighting with 4-space indentation to match manual formatting
    local SyntaxHL = ns.RotationEditorSyntaxHighlighting
    if SyntaxHL and codeBox.editBox then
        SyntaxHL.EnableAPLSyntaxHighlighting(codeBox.editBox, 4, {
            preserveExistingIndent = true,
            forceInitialIndent = true
        })
    end
    codeBox:DisableButton(true)
    codeBox:SetCallback("OnTextChanged", function() end) -- Make read-only
    container:AddChild(codeBox)

    -- Select all text
    if codeBox.editBox then
        codeBox.editBox:HighlightText()
        codeBox.editBox:SetFocus()
    end

    -- Close button
    local closeBtn = AceGUI:Create("Button")
    closeBtn:SetText("Close")
    closeBtn:SetWidth(150)
    closeBtn:SetCallback("OnClick", function()
        frame:Hide()
    end)
    container:AddChild(closeBtn)
end

function Export:ShowClassModuleExport(editorState, exportOptions)
    local formatted = self:FormatClassModuleFile(editorState, exportOptions)

    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Export Class Module File")
    frame:SetLayout("Fill")
    frame:SetWidth(900)
    frame:SetHeight(700)
    frame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
    end)

    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout("List")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    frame:AddChild(container)

    local info = AceGUI:Create("Label")
    info:SetText("Copy the generated class module into your class file (e.g., Monk.lua)")
    info:SetFullWidth(true)
    container:AddChild(info)

    local codeBox = AceGUI:Create("MultiLineEditBox")
    codeBox:SetLabel("Class Module Code")
    codeBox:SetText(formatted)
    codeBox:SetFullWidth(true)
    codeBox:SetFullHeight(true)
    codeBox:SetNumLines(30)

    local SyntaxHL = ns.RotationEditorSyntaxHighlighting
    if SyntaxHL and codeBox.editBox then
        SyntaxHL.EnableAPLSyntaxHighlighting(codeBox.editBox, 4, {
            preserveExistingIndent = true,
            forceInitialIndent = true
        })
    end
    codeBox:DisableButton(true)
    codeBox:SetCallback("OnTextChanged", function() end)
    container:AddChild(codeBox)

    if codeBox.editBox then
        codeBox.editBox:HighlightText()
        codeBox.editBox:SetFocus()
    end

    local closeBtn = AceGUI:Create("Button")
    closeBtn:SetText("Close")
    closeBtn:SetWidth(150)
    closeBtn:SetCallback("OnClick", function()
        frame:Hide()
    end)
    container:AddChild(closeBtn)
end

return Export


