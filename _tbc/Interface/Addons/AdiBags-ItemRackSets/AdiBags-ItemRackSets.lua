local _, ns = ...

local addon = LibStub('AceAddon-3.0'):GetAddon('AdiBags')
local L = setmetatable({}, {__index = addon.L})

local filter = addon:RegisterFilter("ItemRackSets", 100, 'ABEvent-1.0')
filter.uiName = L['ItemRack item sets']
filter.uiDesc = L['Put items belonging to one or more sets of ItemRack in specific sections.']

local function sendFiltersChanged()
	filter:SendMessage('AdiBags_FiltersChanged')
end

local enabled = false
local nonce = 1
local frame = CreateFrame("Frame", nil)
frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
frame:SetScript("OnEvent", function(self, event, ...)
    if not enabled then
        return
    end

    nonce = nonce + 1
    local currentNonce = nonce
	C_Timer.After(0.5, function(...)
        if enabled and currentNonce == nonce then
            sendFiltersChanged()
        end
	end)
end)

local function itemRackUpdated(event, setName)
	sendFiltersChanged()
end
ItemRack:RegisterExternalEventListener("ITEMRACK_SET_SAVED", itemRackUpdated)
ItemRack:RegisterExternalEventListener("ITEMRACK_SET_DELETED", itemRackUpdated)

function filter:OnInitialize()
    self.db = addon.db:RegisterNamespace('ItemRackSets', {
        profile = { singleGroup = false },
    })
end

function filter:GetOptions()
	return {
		singleGroup = {
			name = L['Show as single group'],
			desc = L['Show all ItemRack items in a single group instead of by set name.'],
			type = 'toggle',
			order = 10,
		}
    }, addon:GetOptionHandler(self, true)
end

function filter:OnEnable()
    enabled = true
	addon:UpdateFilters()
end

function filter:OnDisable()
    enabled = false
	addon:UpdateFilters()
end

function filter:Filter(data)
    if not enabled then
        return
    end

	local bag = data["bag"]
	local slot = data["slot"]
	local id = ItemRack.GetID(bag, slot)
	local sets = self:findSetsForItem(id)

    if self.db.profile.singleGroup then
        for _, set in ipairs(sets) do
            return L["ItemRack"], L["Equipment"]
        end

        return nil
    end
	
	local label = nil
	local fmt = "Set: %s"
	for _, set in ipairs(sets) do
        if label == nil then
            label = set
        else
            fmt = "Sets: %s"
            label = label .. ", " .. set
        end
	end
	
	if label ~= nil then
		return L[fmt]:format(label), L["ItemRack, Equipment"]
	end
end

function filter:findSetsForItem(searchId)
	local sets = {}
	
	for name, set in pairs(ItemRackUser.Sets) do
		if name ~= nil and name ~= "nil" and string.sub(name, 1, 1) ~= "~" then
			for _, id in pairs(set["equip"]) do
				if id ~= "0" then
					if ItemRack.SameID(searchId, id) then
						table.insert(sets, name)
					end
				end
			end
		end
	end
	
	table.sort(sets)
	return sets
end
