local _,s = ...
s.cache = {}

-- The filter:search flyouts need to be populated when opened and when the player enters combat. (Since we
-- can't know which flyout they'll use in combat, it will be too late to set them up then.) Waiting to use
-- API calls then can add up to a cpu-bound mini freeze. To combat this, whenever a filter:search is used
-- for an item, equipslot, spell, mount or toy, the appropriate data will be cached in a low-impact scan.
-- Caches should only be enabled if they're needed. A user with simple /selects like:
--      /select Coastal Healing Potion, Hearthstone
-- will never need to search since the items are spelled out; so a cache is not needed. The default state is
-- for the cache to not run at all. But when a select like this is used:
--      /select item:Heal
-- then a cache of all items in a player's bags and on their person will allow quickly finding items
-- with "Heal" in the name without more computationally expensive container/inventory api calls.

--[[
    todo:
    - retrict mount cache to owned mounts?
    - GetInventoryItemLink doesn't work for ammo; but GetInventoryItemID does

    s.cache:Get(cacheName) - returns the contents of the given cache: "item", "equip", "spell", "mount" or "toy"
    s.cache:IsEnabled(cacheName) - returns boolean whether the cacheName is enabled
    s.cache:IsDataLoaded() - returns true if all enabled caches are completely data loaded
    s.cache:Enable(cacheName) - enables a cache, registers for its events and fills cache data if it was disabled
    s.cache:Disable(cacheName) - disables a cache, unregisters for its events and wipes cache data if it was enabled

    Notes:
    - Because "item" and "equip" caches share the same events, and both scan bags/equipment, they share the same
        "item" cache for enabling/disabling purposes.
    - To delay processing until everything is cached, wait until PLAYER_LOGIN to enable caches, and then check for
        s.cache:IsDataLoaded() periodically until it returns true. (afaik, this should only be an issue when the
        game loads a character for the first time in a session.)
    - "rarity" cache goes along with "item" and "equip"; an itemID like 165458 is blue but there are epic versions.
         the rarity cache stores the rarity for ONLY equippable items: use s.cache:Get("rarity") or rarity
    - The "mount" and "toy" caches are disabled in WoW Classic clients.
    - The toy cache is a pain.
]]

local THROTTLE_DELAY = 0.25 -- time to wait after events before updating their associated cache
local DATA_LOAD_DELAY = 0.5 -- time to wait for item or spell data cache to load
local SHARED_TIMEOUT = 10 -- the number of times (across all caches) to attempt data loads

local isClassicClient = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC

local enabledCaches = {
    item = false,
    spell = false,
    mount = false,
    toy = false
}

-- when a bag is dirty it needs updated
local dirtyBags = {[0]=true,[1]=true,[2]=true,[3]=true,[4]=true,worn=true}
-- only trying a max of 10 times for data cache to load (shared between item and spell)
local dataCacheTimeout = SHARED_TIMEOUT

-- where the cached items and spells are stored
local caches = {
    item  = {}, -- indexed by simple itemID, the name of the itemIDs seen worn and in bags (never wipes and always accumulates new items until logout/reload)
    equip = {[0]={}, [1]={}, [2]={}, [3]={}, [4]={}, worn={}}, -- updated container-specific cache of itemStrings that can be equipped
    rarity = {}, -- for unqualified itemIDs, the rarity of the item (many upgradable items have varying rarity)
    spell = {}, -- updated list of known spells in the spellbook for the current spec (for flyout spells entry is {flyname,flyoutspell})
    mount = {land={}, flying={}, aquatic={}}, -- updated lists of owned mountIDs per type
    toy   = {} -- indexed by toy name, the itemID of the toy (backwards: toys need to be SetMacroItem by name (unlike items that set by itemID) and toys must be "item:123" for cast)
}

-- items and spells not data cached are stored here while they're not data cached (ideally these will be empty most of the time)
-- mounts don't appear to use the data cache of spells, and toys have their own special problems so are excluded from this
local unloaded = {
    item = {}, -- indexed by itemID, the bag (can be "worn") where items are not data cached (need to recache that bag)
    spell = {}, -- indexed by spellID, lookup table only
}
s.cache.unloaded = unloaded -- ** debug

-- an ordered list of itemIDs in the toybox, collected or not. this is used as a data source for the toy cache
-- to avoid having to mess with the toybox filters every time there's a potentially new toy learned
local allToys = {}
local ownedToys = {} -- lookup table by itemID for toys that are known

-- cache for searches, indexed by attribClass ("item","mount",etc.), with sub-tables indexed by search (arg passed in filter)
-- with sub-tables of results found from a previous search. when an item, spell, mount, etc cache is updated, it should
-- clear the searches here too to allow keyword:search filters to reflect changes
local searches = {}
s.cache.searches = searches -- for use outside

-- clears the search cache for an attribClass; call whenever the related cache is updated (eg when a new mount is learned,
-- call s.cache:ClearSearch("mount"))
function s.cache:ClearSearch(attribClass)
    if attribClass and searches[attribClass] then
        wipe(searches[attribClass])
    end
end

-- adds the results (subresults table) of a search to the searches cache
function s.cache:AddSearch(attribClass,search,results)
    if not attribClass or SelectSettings.NoSearchCache then
        return
    end
    search = tostring(search) -- equipslot passes a number in results but search is a string
    -- create a sub-table for the attribClass if not already defined
    if not searches[attribClass] then
        searches[attribClass] = {}
    end
    -- create a nested sub-table for the search if not already defined
    if not searches[attribClass][search] then
        searches[attribClass][search] = {}
        -- subresults has some empty rows to avoid garbage creation; need to skip those
        -- (this creates some garbage. the performance tradeoff is huge, but it can be redesigned later to minimize garbage)
        for _,result in ipairs(results) do
            if result[1] then
                tinsert(searches[attribClass][search],CopyTable(result))
            end
        end
    end
end

local itemMixin = CreateFromMixins(ItemMixin) -- single static ItemMixin for interrogating items
local spellMixin = CreateFromMixins(SpellMixin) -- single static SpellMixin for interrogating spells

-- local functions
local updateItemCache, updateSpellCache, updateMountCache, updateToyCache
local loadItemData, addItemLinkToCache, loadSpellData, addSpellToCache

-- in Classic WoW, remove mount and toy cache possibilities
if isClassicClient then
    caches.mount = nil
    caches.toy = nil
    enabledCaches.mount = nil
    enabledCaches.toy = nil
end

-- gets the cache for "item", "equip", "spell", "mount" or "toy"
function s.cache:Get(cache)
    return cache and caches[cache]
end

function s.cache:IsEnabled(cache)
    return cache and enabledCaches[cache] and true
end

-- returns true if there are no items or spells in unloaded.item or unloaded.spell
function s.cache:IsDataLoaded()
    if dataCacheTimeout<=0 then
        return "timeout" -- if we hit timeout, this will evaluate to true (we did all we can!) but can also be directly checked
    elseif (enabledCaches.item and next(unloaded.item)) or (enabledCaches.spell and next(unloaded.spell)) then
        return false -- something in unloaded waiting to be loaded
    else
        return true -- everything appears to be loaded normally
    end
end

-- turns a cache on ("item", "spell", "mount", "toy") and immediately populates its cache if it was off
function s.cache:Enable(cache)
    if not cache or enabledCaches[cache]==nil then
        return
    end
    local wasEnabled = enabledCaches[cache]
    enabledCaches[cache] = true
    if not wasEnabled then -- if it was off, then we need to register their event(s) and run the update
        if cache == "item" then
            s.cache.frame:RegisterEvent("BAG_UPDATE")
            s.cache.frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
            for bag in pairs(caches.equip) do -- flag all worn/bags as dirty so they get picked up
                dirtyBags[bag] = true
            end
            updateItemCache()
        elseif cache == "spell" then
            s.cache.frame:RegisterEvent("LEARNED_SPELL_IN_TAB")
            s.cache.frame:RegisterEvent("SPELLS_CHANGED")
            updateSpellCache()
        elseif cache == "mount" then
            --s.cache.frame:RegisterEvent("MOUNT_JOURNAL_USABILITY_CHANGED") -- don't think this is needed
            s.cache.frame:RegisterEvent("COMPANION_LEARNED")
            updateMountCache()
        elseif cache == "toy" then
            s.cache.frame:RegisterEvent("NEW_TOY_ADDED")
            s.cache.frame:RegisterEvent("TOYS_UPDATED")
            s.timer:Start(DATA_LOAD_DELAY,updateToyCache) -- waiting for this awful mess rather than immediately loading
        end
    end
end

-- turns a cache off ("item", "spell", "mount", "toy") and wipes its cache if it was on
function s.cache:Disable(cache)
    if not cache or enabledCaches[cache]==nil then
        return
    end
    local wasEnabled = enabledCaches[cache]
    enabledCaches[cache] = false
    if wasEnabled then -- if it was on, then we need to unregister their event(s) and empty their cache
        if cache == "item" or cache == "equip" then
            s.cache.frame:UnregisterEvent("BAG_UPDATE")
            s.cache.frame:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
            wipe(caches.item)
            for k,v in pairs(caches.equip) do wipe(v) end
        elseif cache == "spell" then
            s.cache.frame:UnregisterEvent("LEARNED_SPELL_IN_TAB")
            s.cache.frame:UnregisterEvent("SPELLS_CHANGED")
            wipe(caches.spell)
        elseif cache == "mount" then
            --s.cache.frame:UnregisterEvent("MOUNT_JOURNAL_USABILITY_CHANGED")
            s.cache.frame:UnregisterEvent("COMPANION_LEARNED")
            for k,v in pairs(caches.mount) do wipe(v) end
        elseif cache == "toy" then
            s.cache.frame:UnregisterEvent("NEW_TOY_ADDED")
            s.cache.frame:UnregisterEvent("TOYS_UPDATED")
            wipe(caches.toy)
        end
    end
end


-- for each filter keyword, the cache used by that filter
-- local cacheByFilters = {
--     item="item", i="item", equipslot="item", e="item", type="item", t="item",
--     spell="spell", s="spell",
--     mount="mount", m="mount",
--     toy="toy",
-- }

-- turns on/off the caches depending on whether any filters exist across the flyouts
-- function s.cache:UpdateState(root)
--     local usedFilters = {}
--     -- drilling through secure frame tree to find entries used in flyouts
--     for _,action in pairs(root.actions) do
--         for _,flyout in pairs(action.menu.flyouts) do
--             for _,entries in pairs(flyout.entries) do
--                 local filter = entries[1]
--                 if cacheByFilters[filter] then
--                     usedFilters[cacheByFilters[filter]] = true
--                 end
--             end
--         end
--     end
--     for filter in pairs(enabledCaches) do
--         if usedFilters[filter] then
--             s.cache:Enable(filter)
--         else
--             s.cache:Disable(filter)
--         end
--     end
-- end

--[[ item and equip cache ]]

function updateItemCache()
    local somethingNeedsLoaded = false -- becomes true is something isn't data cached
    if dirtyBags["worn"] then
        wipe(caches.equip.worn)
        for slot=0,19 do
            local link = GetInventoryItemLink("player",slot)
            local needsLoaded = addItemLinkToCache(link,"worn",slot)
            if needsLoaded then
                somethingNeedsLoaded = true
            end
        end
    end
    for bag=0,4 do
        if dirtyBags[bag] then
            wipe(caches.equip[bag])
            for slot=1,s.utils:GetContainerNumSlots(bag) do
                local link = s.utils:GetContainerItemLink(bag,slot)
                local needsLoaded = addItemLinkToCache(link,bag,slot)
                if needsLoaded then
                    somethingNeedsLoaded = true
                end
            end
        end
    end
    wipe(dirtyBags)
    if somethingNeedsLoaded and dataCacheTimeout>0 then
        dataCacheTimeout = dataCacheTimeout - 1
        s.timer:Start(DATA_LOAD_DELAY,loadItemData)
    end
    s.cache:ClearSearch("item")
    s.cache:ClearSearch("equipslot")
end

-- adds a link to both the "item" and "equip" cache or sets up 
function addItemLinkToCache(link,bag,slot)
    if link then
        itemMixin:SetItemLink(link)
        if not itemMixin:IsItemEmpty() then -- battlpet links and non-item links are empty, ignoring them entirely
            local itemID = itemMixin:GetItemID()
            if itemMixin:IsItemDataCached() then -- item is data cached, safe to get name
                -- only caching equippable items to equip cache
                if IsEquippableItem(itemID) then
                    local itemKey
                    if GetItemCount(itemID)>1 then -- for items with multiple copies get itemString saved to potentially distinguish them
                        itemKey = link:match("\124H(item:.-)\124h")
                    else -- otherwise equipment is cached as base itemID (pocket-sized computation device can't equip by itemstring grr)
                        itemKey = "item:"..itemID
                    end
                    caches.equip[bag][slot] = itemKey
                    caches.rarity[itemKey] = itemMixin:GetItemQuality() -- add to rarity cache too
                end
                -- but caching all item names to item cache
                if not caches.item[itemID] then
                    caches.item[itemID] = itemMixin:GetItemName()
                end
            else -- item not data cached, come back for it later
                unloaded.item[itemID] = bag
                return true
            end
        end
    end
end

function loadItemData()
    local somethingLoaded = false
    local somethingNeedsLoaded = false
    for itemID,bag in pairs(unloaded.item) do
        itemMixin:SetItemID(itemID)
        if itemMixin:IsItemDataCached() then -- if something was loaded that wasn't before
            dirtyBags[bag] = true -- flag the bag for re-cacheing
            unloaded.item[itemID] = nil -- remove itemID from unloaded
            somethingLoaded = true
        else -- something is still not data cached
            somethingNeedsLoaded = true
        end
    end
    if somethingNeedsLoaded and dataCacheTimeout>0 then -- if anything still needs data cached then come back later to try again
        dataCacheTimeout = dataCacheTimeout - 1
        s.timer:Start(DATA_LOAD_DELAY,loadItemData)
    end
    if somethingLoaded then -- something was cached that wasn't before, cache its bag again
        updateItemCache()
    end    
end

--[[ spell cache ]]

function updateSpellCache()
    local somethingNeedsLoaded = false
    wipe(caches.spell)
    for i=1,GetNumSpellTabs() do
        local tabName,_,offset,numSpells,_,offSpecID = GetSpellTabInfo(i)
        if offSpecID==0 then -- don't look through offspec tabs
            for j=offset+1, offset+numSpells do
                local spellType,spellID = GetSpellBookItemInfo(j,"spell")
                if spellType=="SPELL" then
                    if addSpellToCache(spellID)==false then
                        unloaded.spell[spellID] = j
                        somethingNeedsLoaded = true
                    end
                elseif spellType=="FLYOUT" then
                    local flyoutName,_,numFlyoutSlots,isFlyoutKnown = GetFlyoutInfo(spellID)
                    if isFlyoutKnown then
                        for k=1,numFlyoutSlots do
                            local flyoutSpellID = GetFlyoutSlotInfo(spellID,k)
                            if addSpellToCache(flyoutSpellID,flyoutName)==false then
--                                unloaded.spell[flyoutSpellID] = j
--                                somethingNeedsLoaded = true
                            end
                        end
                    end
                end
            end
        end
    end
    if somethingNeedsLoaded and dataCacheTimeout>0 then
        dataCacheTimeout = dataCacheTimeout - 1
        s.timer:Start(DATA_LOAD_DELAY,loadSpellData)
    end
    s.cache:ClearSearch("spell")
end

-- verifies that the given spellID (from GetSpellBookItemInfo) is known and saves to cache if so
-- if the spell is data cached and added to cache, returns true
-- if the spell is valid but is NOT data cached, returns false
-- if this spell is unknown (by player or by game) or it's passive, returns nil
function addSpellToCache(spellID,flyoutName)
    spellMixin:SetSpellID(spellID)
    if spellMixin:IsSpellEmpty() then
        return nil -- not a valid spell
    end
    if spellMixin:IsSpellDataCached() then
        if not IsSpellKnown(spellID) then
            return nil -- spell isn't known by the player
        end
        if IsPassiveSpell(spellID) then
            return nil -- don't want to include passive spells
        end
        local name = spellMixin:GetSpellName()
        if name and not tContains(caches.spell,name) then 
            local subtext = spellMixin:GetSpellSubtext()
            -- subtext can be type of Polymorph like Turtle for Polymorph(Turtle). it's also rank in classic
            -- and used in many spells for display purposes but can't be cast (like "Expansive Mind(Racial Passive)").
            -- to avoid issues, subtext is not used in classic for spells
            if subtext and subtext~="" and not isClassicClient then
                -- if there are issues with some subtexts not working in retail, then uncomment here so it can
                -- verify that the spell exists (and comment the following name = name.."("..etc)
                --local nameWithSubtext = name.."("..subtext:trim()..")"
                --if GetSpellInfo(nameWithSubtext) then -- if adding a sub
                --    name = nameWithSubtext
                --end
                name = name.."("..subtext:trim()..")"
            end
            if flyoutName then
                tinsert(caches.spell,{flyoutName,name})
            else
                tinsert(caches.spell,name)
            end
            return true -- spell successfully cached
        end
    else
        return false -- spell is not data cached
    end
end

-- called on a timer to data cache missing spell data
function loadSpellData()
    local somethingLoaded = false
    local somethingNeedsLoaded = false
    for spellID,index in pairs(unloaded.spell) do
        spellMixin:SetSpellID(spellID)
        if spellMixin:IsSpellDataCached() then -- if something was loaded that wasn't before
            unloaded.spell[spellID] = nil
            somethingLoaded = true
        else -- something is still not data cached
            somethingNeedsLoaded = true
        end
    end
    if somethingNeedsLoaded and dataCacheTimeout>0 then -- if anything still needs data cached then come back later to try again
        dataCacheTimeout = dataCacheTimeout - 1
        s.timer:Start(DATA_LOAD_DELAY,loadSpellData)
    end
    if somethingLoaded then -- something was cached that wasn't before, cache spells again
        updateSpellCache()
    end    
end

--[[ mount cache ]]

if not isClassicClient then
    -- lookup table indexed by the mountType return of GetMountInfoExtraByID that says which table a mount belongs to
    local mountTypeGroups = {
        [247]="flying", [248]="flying",
        [231]="aquatic", [232]="aquatic", [254]="aquatic", [269]="aquatic",
        -- all others are land mounts
    }

    local _,playerFaction = UnitFactionGroup("player")
    playerFaction = playerFaction=="Alliance" and 1 or playerFaction=="Horde" and 0

    function updateMountCache()
        local somethingNeedsLoaded = false -- -- it apears mount spellIDs do not get data cached, but going to be paranoid
        for _,mountID in ipairs(C_MountJournal.GetMountIDs()) do
            local _,spellID,_,_,_,_,_,isFactionSpecific,faction,hideOnChar,isCollected = C_MountJournal.GetMountInfoByID(mountID)
            if isCollected and hideOnChar~=true and (not isFactionSpecific or faction==playerFaction) then
                local _,_,_,_,mountType = C_MountJournal.GetMountInfoExtraByID(mountID)
                local mountGroup = mountTypeGroups[mountType] or "land" -- "flying", "aquatic" or "land"
                --tinsert(caches.mount[mountGroup],mountID)
                local name = GetSpellInfo(spellID)
                if name then
                    caches.mount[mountGroup][mountID] = name
                else
                    somethingNeedsLoaded = true
                end
            end
        end
        if somethingNeedsLoaded and dataCacheTimeout>0 then
            dataCacheTimeout = dataCacheTimeout - 1
            s.timer:Start(DATA_LOAD_DELAY,updateMountCache)
        end
        s.cache:ClearSearch("mount")
    end
end

--[[ allToys ]]

local function gatherAllToys()

    -- if we have already gathered all toys into allToys, leave
    if #allToys==C_ToyBox.GetNumTotalDisplayedToys() then
        return
    end

    wipe(allToys)

    local oldFilters -- becomes saved toy filters if non-default filters used

    if not C_ToyBoxInfo.IsUsingDefaultFilters() then
        oldFilters = {
            collected = C_ToyBox.GetCollectedShown(),
            uncollected = C_ToyBox.GetUncollectedShown(),
            unusable = C_ToyBox.GetUnusableShown(),
            sources = {},
            expansions = {}
        }
        for i=1,C_PetJournal.GetNumPetSources() do -- blizzard uses this for toys really
            if C_ToyBoxInfo.IsToySourceValid(i) then
                oldFilters.sources[i] = C_ToyBox.IsSourceTypeFilterChecked(i)
            end
        end
        for i=1,GetNumExpansions() do
            oldFilters.expansions[i] = C_ToyBox.IsExpansionTypeFilterChecked(i)
        end    

        -- default filters show all toys (collected/uncollected, all sources/expansions)
        C_ToyBoxInfo.SetDefaultFilters()        
    end

    -- anything in search is not counted towards default filters; clear just to be safe.
    -- this is only done a second after login where search should have nothing, but it's possible
    -- a user immediately opened the journal and typed something in
    C_ToyBox.SetFilterString("")

    -- now go through and capture the itemID of all toys; worry about data cache later
    for i=1,C_ToyBox.GetNumFilteredToys() do
        local itemID = C_ToyBox.GetToyFromIndex(i)
        if itemID then
            tinsert(allToys,itemID)
        end
    end

    -- if any non-default filters were used, restore them
    if oldFilters then
        C_ToyBox.SetCollectedShown(oldFilters.collected)
        C_ToyBox.SetUncollectedShown(oldFilters.uncollected)
        C_ToyBox.SetUnusableShown(oldFilters.unusable)
        for i=1,C_PetJournal.GetNumPetSources() do
            if C_ToyBoxInfo.IsToySourceValid(i) then
                C_ToyBox.SetSourceTypeFilter(i,oldFilters.sources[i])
            end
        end
        for i=1,GetNumExpansions() do
            C_ToyBox.SetExpansionTypeFilter(i,oldFilters.expansions[i])
        end        
    end
end

--[[ toy cache ]]

local isToysUpdating = false

if not isClassicClient then

    -- reworked: rather than expanding/collapsing filters on every toy update, refer to allToys which
    -- is an ordered list of itemIDs of all toys
    function updateToyCache()
        if isToysUpdating then -- an update here triggered an event; ignore these
            return
        end

        for _,itemID in ipairs(allToys) do
            if PlayerHasToy(itemID) then
                itemMixin:SetItemID(itemID)
                local name = itemMixin:GetItemName()
                if name then
                    caches.toy[name] = itemID
                else
                    s.timer:Start(DATA_LOAD_DELAY*1.25,updateToyCache)
                end
            end
        end

        s.cache:ClearSearch("toy")
    end
end

--[[ event handling ]]

s.cache.frame = CreateFrame("Frame")

s.cache.frame:SetScript("OnEvent",function(self,event,...)
    if s.cache.frame[event] then
        s.cache.frame[event](self,...)
    end
end)

function s.cache.frame:BAG_UPDATE(bag)
    if bag >= 0 and bag <= 4 then -- only watching the main 5 bags
        dirtyBags[bag] = true
        s.timer:Start(THROTTLE_DELAY,updateItemCache)
    end
end

function s.cache.frame:PLAYER_EQUIPMENT_CHANGED(slot,equipped)
    dirtyBags["worn"] = true
    s.timer:Start(THROTTLE_DELAY,updateItemCache)
end

function s.cache.frame:LEARNED_SPELL_IN_TAB()
    s.timer:Start(THROTTLE_DELAY,updateSpellCache)
end
s.cache.frame.SPELLS_CHANGED = s.cache.frame.LEARNED_SPELL_IN_TAB

if not isClassicClient then
    -- when mount journal events fire to change mounts, repopulate mountCache (this event occasionally fires in spasms, throttling it)
    function s.cache.frame:MOUNT_JOURNAL_USABILITY_CHANGED()
        s.timer:Start(THROTTLE_DELAY,updateMountCache)
    end

    -- on events that can potentially changed owned mounts, repopulate mountCache too
    function s.cache.frame:COMPANION_LEARNED(companionType)
        if companionType=="MOUNT" then
            s.timer:Start(THROTTLE_DELAY,updateMountCache)
        end
    end
    --s.cache.frame.COMPANION_UNLEARNED = s.cache.frame.COMPANION_LEARNED -- mounts are never unlearned? keeping for
    --s.cache.frame.COMPANION_UPDATE = s.cache.frame.COMPANION_LEARNED -- not sure if this is needed, don't think so

    -- redundant (TOYS_UPDATE should fire too) but for reassurance
    function s.cache.frame:NEW_TOY_ADDED()
        s.timer:Start(THROTTLE_DELAY,updateToyCache)
    end

    function s.cache.frame:TOYS_UPDATED()
        s.timer:Start(DATA_LOAD_DELAY,gatherAllToys) -- get all collected/uncollected toys (if total count changed for some reason; unlisted toy learned?)
        s.timer:Start(DATA_LOAD_DELAY*2,updateToyCache) -- cache collected toy names
    end
end

