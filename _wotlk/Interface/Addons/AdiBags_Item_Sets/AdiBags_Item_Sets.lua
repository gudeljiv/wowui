-- This addon/module
local _, addon = ...

-- AdiBags addon
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

-- Dababase
local db = addon.db

-- Filter Setup
local filter = AdiBags:RegisterFilter('Item Sets', 98)

filter.uiName = 'Item Sets'
filter.uiDesc = 'Put sets items in their own sections.'

-- Filter events
function filter:OnEnable()
	AdiBags:UpdateFilters()
end

function filter:OnDisable()
	AdiBags:UpdateFilters()
end

function filter:Update()
	self:SendMessage("AdiBags_FiltersChanged")
end

function filter:OnInitialize()
	self.db = AdiBags.db:RegisterNamespace(self.filterName, {
		profile = {
			enablePVE = true,
			enablePVP = true,
			enablePVPHonor = true,
			enablePVPArena = true,
		},
	})
end

-- Filter UI Options
function filter:GetOptions()
	return {
		enablePVE = {
			name ="PVE Sets",
			desc = "Enable section for PVE sets.",
			type = "toggle",
			width = "double",
			order = 10,
		},
		enablePVP = {
			name ="PVP Sets",
			desc = "Enable section for PVP sets.",
			type = "toggle",
			width = "double",
			order = 15,
		},
		includeWeapons = {
			name ="Include Weapons",
			desc = "Include weapons in sets.",
			type = "toggle",
			width = "double",
			order = 20,
			disabled = function() return not self.db.profile.enablePVE and not self.db.profile.enablePVP end,
		},
	}, AdiBags:GetOptionHandler(self, true, function() return self:Update() end)
end

-- Filter action
function filter:Filter(slotData)
	local _, _, _, slotItemId = slotData.bag, slotData.slot, slotData.quality, slotData.itemId

	for _, categories in pairs(db) do -- Expansions (Vanilla, TBC, Wrath...)
		for categoryName, sources in pairs(categories) do -- Categories (Armor, Weapons)
			if ((categoryName == "Armor") or ((categoryName == "Weapons") and self.db.profile.includeWeapons)) then
				for sourceName, tags in pairs(sources) do -- Sources (PVE, PVP)
					if ((sourceName == "PVE") and self.db.profile.enablePVE) or
						((sourceName == "PVP") and self.db.profile.enablePVP) then
						for tagName, itemSets in pairs(tags) do -- Tags (Dungeon, Tier, Honor, Arena)
							if (tagName == "Tier") or
								((tagName == "Honor") and self.db.profile.enablePVPHonor) or
								((tagName == "Arena") and self.db.profile.enablePVPArena) then
								for setName, items in pairs(itemSets) do
									for _, itemId in ipairs(items) do
										if (itemId == slotItemId) then
											return "Item Set: " .. setName;
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end