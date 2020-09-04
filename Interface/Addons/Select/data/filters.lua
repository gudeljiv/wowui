-- filter.lua contains all the functions that extract items and spells from the cache to populate flyout entries
-- the list of items and spells are stored in the s.list named "results"

local _,s = ...
s.filters = {}

s.list:Create("results") -- the results that will be used to populate a flyout
s.list:Create("subresults") -- the results of a single entry (could be one item/spell or expanded to many)

local isClassicClient = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC

-- takes entries, a table of {{"none","item1"},{"none","item2"},{"spell","heal"},etc} and populates the results list
function s.filters:ExpandEntries(entries)
    s.list:Reset("results")
    for _,entry in ipairs(entries) do
        local filter,search = entry[1],entry[2]
        if s.filters[filter] then
            s.list:Reset("subresults")
            -- run the filter, which should add to subresults list
            s.filters[filter](self,search)
            -- sort subresults here
            s.list:Sort("subresults")
            -- add subresults to the main results
            s.list:AddToList("subresults","results",filter~="equipslot") -- except for equipslot, all results should be unique
        end
    end
end

-- returns true if arg and compareTo match. arg is a [Cc][Aa][Ss][Ee]-insensitive pattern, isEqual(arg,"Any")
-- to get an exact match we need to append ^ and $ to the pattern (otherwise Many would equal Any)
local function isEqual(arg,compareTo)
	return compareTo:match(format("^%s$",arg)) and true
end

-- takes a name and returns the full name including subtext (like "Polymorph(Turtle) or Heroic Strike(Rank 3)")
function getFullSpellName(name)
    if (name or ""):match("%(.+%)") then -- if a subtext is explicitly defined, then use it
        return name
    end
    local spellName = GetSpellInfo(name)
    if spellName then
        local subText = GetSpellSubtext(spellName)
        if subText and subText~="" then
            return format("%s(%s)",spellName,subText)
        else
            return spellName
        end
    end
end


--[[ none:search 

    An entry with a name and no filter:search term is looking for a single item or spell.
    The search has to be the whole item or spell name; this doesn't do a search but confirms it exists.
]]

-- full name used only, such as /select Hearthstone, Soulstone; could be an item, spell, mount or toy
-- only one result is added in this filter (in theory, things that are different don't share the same name)
function s.filters:none(search)
    -- if this is an item in bags or on person
    if GetItemCount(search)>0 then
        local itemID = GetItemInfoInstant(search)
        if itemID then
            return s.list:Add("subresults","item","item","item","item:"..itemID,true)
        end
    end
    -- look for spell next; when mounts are spelled out, they're treated as spells too
    local spellName = getFullSpellName(search)
    if spellName then
        return s.list:Add("subresults","spell","spell","spell",spellName,true)
    end
    -- if this is a named item with no count, maybe it's a toy
    if not isClassicClient then
        local itemID = GetItemInfoInstant(search)
        if itemID and PlayerHasToy(itemID) then
            local toyName = GetItemInfo(itemID) or search -- if toy isn't cached on client for some reason, use the user-supplied name
            return s.list:Add("subresults","toy","item","item",toyName,true)
        end
    end
end

--[[ equipslot:slot

    /select equipslot:16 will add all items that can go into slot 16. In addition, selecting the item will attempt to equip it.
]]

local equipLocs = {
	["INVTYPE_AMMO"] = 0, -- Ammo
	["INVTYPE_HEAD"] = 1, -- Head
	["INVTYPE_NECK"] = 2, -- Neck
	["INVTYPE_SHOULDER"] = 3, -- Shoulder
	["INVTYPE_BODY"] = 4, -- Shirt
	["INVTYPE_CHEST"] = 5, -- Chest
	["INVTYPE_ROBE"] = 5, -- Chest
	["INVTYPE_WAIST"] = 6, -- Waist
	["INVTYPE_LEGS"] = 7, -- Legs
	["INVTYPE_FEET"] = 8, -- Feet
	["INVTYPE_WRIST"] = 9, -- Wrist
	["INVTYPE_HAND"] = 10, -- Hands
	["INVTYPE_FINGER"] = {11,12}, -- Fingers
	["INVTYPE_TRINKET"] = {13,14}, -- Trinkets
	["INVTYPE_CLOAK"] = 15, -- Cloaks
	["INVTYPE_WEAPON"] = {16,17}, -- One-Hand
	["INVTYPE_SHIELD"] = 17, -- Shield
	["INVTYPE_2HWEAPON"] = 16, -- Two-Handed
	["INVTYPE_WEAPONMAINHAND"] = 16, -- Main-Hand Weapon
	["INVTYPE_WEAPONOFFHAND"] = 17, -- Off-Hand Weapon
	["INVTYPE_HOLDABLE"] = 17, -- Held In Off-Hand
	["INVTYPE_RANGED"] = 18, -- Bows
	["INVTYPE_THROWN"] = 18, -- Ranged
	["INVTYPE_RANGEDRIGHT"] = 18, -- Wands, Guns, and Crossbows
	["INVTYPE_RELIC"] = 18, -- Relics
	["INVTYPE_TABARD"] = 19, --Tabard
}

if select(2,UnitClass("player"))=="WARRIOR" then
    equipLocs["INVTYPE_2HWEAPON"] = {16,17}
end

function s.filters:equipslot(slot)
    local slot = tonumber(slot)
    if slot and slot>=0 and slot<=19 then
        local cache = s.cache:Get("equip")
        for bagNumber,bag in pairs(cache) do
            for bagSlot,itemID in pairs(bag) do
                local _,_,_,itemEquipLoc = GetItemInfoInstant(itemID)
                local equipLoc = equipLocs[itemEquipLoc]
                if equipLoc then
                    if (type(equipLoc)=="number" and slot==equipLoc) or (type(equipLoc)=="table" and (slot==equipLoc[1] or slot==equipLoc[2])) then
                        if s.settings:Get("EquipslotOnlySoulbound") and tonumber(bagNumber) then -- if option to include only soulbound (and this is a bag and not worn)
                            if C_Item.IsBound(ItemLocation:CreateFromBagAndSlot(bagNumber,bagSlot)) then
                                s.list:Add("subresults","equipslot","macro","macrotext",format("/equipslot %d %s",slot,itemID))
                            end
                        else -- if EquipslotOnlySoulbound not set (or bag is worn), then always add
                            s.list:Add("subresults","equipslot","macro","macrotext",format("/equipslot %d %s",slot,itemID))
                        end
                    end
                end
            end
        end
    end
end
s.filters.e = s.filters.equipslot

--[[ item:arg

    /select item:123 will add an item with itemID 123
    /select item:text wil add all items in a person's bags or person that contain the text
]]

function s.filters:item(arg)
    if tonumber(arg) then -- if this is item:<itemID> then look for single item to add
        if GetItemCount("item:"..arg)>0 then
            s.list:Add("subresults","item","item","item","item:"..arg,true)
        end
    else -- partial search term, look for all items that contain the text in their name
        for itemID,name in pairs(s.cache:Get("item")) do
            if name:match(arg) then
                s.list:Add("subresults","item","item","item","item:"..itemID,true)
            end
        end     
    end
end
s.filters.i = s.filters.item

--[[ spell:arg

    /select spell:123 will add a spell with spellID 123
    /select spell:text will add all spells from the player's spellbook that contain the text
]]

function s.filters:spell(arg)
    if tonumber(arg) then
        local spellName = arg --getFullSpellName(arg)
        if spellName then
            s.list:Add("subresults","spell","spell","spell",spellName,true)
        end
    else
        for _,spell in ipairs(s.cache:Get("spell")) do
            if type(spell)=="table" then -- this is a flyout spell
                if spell[1]:match(arg) or spell[2]:match(arg) then
                    local spellName = spell[2] --getFullSpellName(spell[2])
                    if spellName then
                        s.list:Add("subresults","spell","spell","spell",spellName,true)
                    end
                end
            elseif spell:match(arg) then
                local spellName = spell --getFullSpellName(spell)
                if spellName then
                    s.list:Add("subresults","spell","spell","spell",spellName,true)
                end
            end
        end
    end
end
s.filters.s = s.filters.spell

--[[ type: arg

    /select type:arg will look for any items with arg in the GetItemInfo type or subtype returns
]]

function s.filters:type(arg)
    -- many quest items don't have a "Quest" in a type field, but GetContainerItemQuestInfo (not available in classic)
    -- has them flagged as quests. Check those firsts if not on classic client
    if not isClassicClient and ("quest"):match(arg) then
        for i=0,4 do
            for j=1,GetContainerNumSlots(i) do
                local isQuestITem, questID, isActive = GetContainerItemQuestInfo(i,j)
                if isQuestITem or questID or isActive then
                    s.list:Add("subresults","item","item","item","item:"..GetContainerItemID(i,j),true)
                end
            end
        end
    end
    -- now look for items that match GetItemInfo fields
    for itemID,name in pairs(s.cache:Get("item")) do
        if GetItemCount(name)>0 then
            local _,_,_,_,_,itemType,itemSubtype,_,itemSlot = GetItemInfo(itemID)
            if itemType and (itemType:match(arg) or itemSubtype:match(arg) or itemSlot:match(arg)) then
                s.list:Add("subresults","item","item","item","item:"..itemID,true)
            end
        end
    end
end
s.filters.t = s.filters.type

--[[ mount:arg

    /select mount:id, mount:any, mount:flying, mount:land, mount:aquatic, mount:favorite,
            mount:fflying, mount:fland, mount:faquatic
]]

if not isClassicClient then

    function s.filters:mount(arg)

        local cache = s.cache:Get("mount")

        -- if arg is a number, like mount:118089, then look for that specific mount
        local mountSpellID = tonumber(arg)
        if mountSpellID then -- this is a numerical mount (like m:118089)
            for _,mountSet in pairs(cache) do
                if mountSet[mountID] then
                    s.list:Add("subresults","mount","spell","spell",mountSet[mountID],true)
                end
            end
            return -- don't bother looking further if a number isn't identified as a mount
        end

        local mountSet
        local fflying = isEqual(arg,"fflying") or isEqual(arg,"favflying")
        local fland = isEqual(arg,"fland") or isEqual(arg,"favland")
        local faquatic = isEqual(arg,"faquatic") or isEqual(arg,"favaquatic")

        if isEqual(arg,"flying") or fflying then
            mountSet = cache.flying
            favoriteSet = fflying
        elseif isEqual(arg,"land") or fland then
            mountSet = cache.land
            favoriteSet = fland
        elseif isEqual(arg,"aquatic") or faquatic then
            mountSet = cache.aquatic
            favoriteSet = faquatic
        end

        local any = isEqual(arg,"any")
        local favorite = isEqual(arg,"favorite")

        if mountSet then -- flying, land or aquatic mounts
            for mountID,spellName in pairs(mountSet) do
                local mountName,mountSpellID,_,_,canSummon,_,isFavorite,isFactionSpecific,faction,_,isCollected = C_MountJournal.GetMountInfoByID(mountID)
                if mountName and (not s.settings:Get("OnlySummonableMounts") or canSummon) then -- if any complaints about unusable mounts showing up, uncomment canSummon
                    if not favoriteSet or isFavorite then
                        s.list:Add("subresults","mount","spell","spell",spellName,true)
                    end
                end
            end
        else -- favorite, any or name search
            for _,mountSet in pairs(cache) do
                for mountID,spellName in pairs(mountSet) do
                    local mountName,mountSpellID,_,_,canSummon,_,isFavorite,isFactionSpecific,faction,_,isCollected = C_MountJournal.GetMountInfoByID(mountID)
                    if mountName and canSummon then
                        if (favorite and isFavorite) or any or mountName:match(arg) or spellName:match(arg) then
                            s.list:Add("subresults","mount","spell","spell",spellName,true)
                        end
                    end
                end
            end
        end

    end
    s.filters.m = s.filters.mount
end

--[[ toy:arg

    /select toy:partial name, toy:any, toy:favorite
]]

 if not isClassicClient then

    function s.filters:toy(arg)
        local any = isEqual(arg,"any")
        local favorite = isEqual(arg,"favorite")

        for toyName,itemID in pairs(s.cache:Get("toy")) do
            if any or (favorite and C_ToyBox.GetIsFavorite(itemID)) or toyName:match(arg) then
                s.list:Add("subresults","toy","item","item",toyName,true)
            end
        end
    end

end

--[[ profession:arg

    /select profession:any, profession:primary, profession:secondary
]]

local professions = {} -- to minimize garbage creation, reusing same table
local function addprof(entry) -- local function to add GetProfessions() results to search
    tinsert(professions,entry or false)
end

if not isClassicClient then

    function s.filters:profession(arg)
        wipe(professions)
        --s.utils:RunForEach(function(entry) tinsert(professions,entry or false) end,GetProfessions())
        s.utils:RunForEach(addprof,GetProfessions())

        local any = isEqual(arg,"any")
        local primaryOnly = isEqual(arg,"primary")
        local secondaryOnly = isEqual(arg,"secondary")
        
        for index,profession in pairs(professions) do
            if profession then
                local name,_,_,_,numSpells,offset = GetProfessionInfo(profession)
                if (index<3 and primaryOnly) or (index>2 and secondaryOnly) or any or name:match(arg) then
                    for i=1,numSpells do
                        local _,spellID = GetSpellBookItemInfo(offset+i,"professions")
                        s.list:Add("subresults","profession","spell","spell",(GetSpellInfo(spellID)),true)
                    end
                end
            end
        end
    end

end

--[[ pet:arg

    /select pet:full name, pet:favorite, pet:any

    This is an unsupported/undocumented filter because SetMacroItem/Spell does not work for battle pets.
    So all battle pets get a revive battle pets icon for the macro (and their species icon in the menu) and that's it.
 ]]

 if not isClassicClient then

    function s.filters:pet(arg)
        local any = isEqual(arg,"any")
        local favorite = isEqual(arg,"favorite")

        -- rather than digging through the journal, if a name is provided, try to find it
        if not any and not favorite then
            local name = arg:gsub("%[[A-Z][a-z]%]",function(c) return c:sub(2,2) end) -- convert arg to a regular string
            local speciesID,petID = C_PetJournal.FindPetIDByName(name)
            if petID then
                local _,customName,_,_,_,_,_,realName = C_PetJournal.GetPetInfoByPetID(petID)
                s.list:Add("subresults","battlepet","macro","macrotext",format("/summonpet %s",customName or realName),true)
                return
            end
        end

        -- if here, then the pet wasn't found (not full name) or this is a favorite or any search
        -- the following can create 150-200k of garbage...why? pets are officially unsupported so this is permitted to stay
        for i=1,C_PetJournal.GetNumPets() do
            local petID,_,owned,customName,_,isFavorite,_,realName = C_PetJournal.GetPetInfoByIndex(i)
            if petID and owned then
                if any or (favorite and isFavorite) or (customName and customName:match(arg)) or (realName and realName:match(arg)) then
                    s.list:Add("subresults","battlepet","macro","macrotext",format("/summonpet %s",customName or realName),true)
                end
            end
        end
    end
    s.filters.p = s.filters.pet

end
