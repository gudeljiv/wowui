--[[	kRestack 1.1 : Katae @ Anvilmar US
		
		Usage:	/restack [bags, bank, guild] - manual run
				/restack auto [bags, bank, guild] - toggles auto mode ]]
local AS, atBank, atVault, isViewable, canDeposit, restacker, tabswap

SLASH_RESTACK1 = "/restack"
function SlashCmdList.RESTACK(s)
	kRestack(s)
end

-- pretty chat colors!
local white, green, red = "|cffffffff", "|cff55ff55", "|cffff5555"
local kR = "|cff44ccffk|cffffffaaRestack" .. white

-- set user's container identifers
local container = {bags = {0}, bank = {-1}, guild = {42}}
for i = 1, NUM_BAG_SLOTS do
	table.insert(container.bags, i)
end
for i = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
	table.insert(container.bank, i)
end

-- ldb plugin
local function ldb()
	local drop = CreateFrame("Frame", "kRestack", nil, "UIDropDownMenuTemplate")
	LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(
		"kRestack",
		{
			type = "launcher",
			label = "kRestack",
			icon = "Interface\\Icons\\INV_Crate_09",
			OnClick = function(self, button)
				if button == "RightButton" then
					GameTooltip:Hide()
					UIDropDownMenu_Initialize(
						drop,
						function()
							for _, opt in ipairs {
								{text = "= Restack =", isTitle = true},
								{
									text = "Backpack",
									func = function()
										kRestack("bags")
									end
								},
								{
									text = "Bank",
									disabled = not atBank,
									func = function()
										kRestack("bank")
									end
								},
								{
									text = "Guild Vault",
									disabled = not atVault,
									func = function()
										kRestack("guild", false, GetCurrentGuildBankTab())
									end
								},
								{disabled = true},
								{text = "= Set Auto =", isTitle = true},
								{
									text = "Backpack",
									checked = AS.bags,
									func = function()
										kRestack("auto bags")
									end
								},
								{
									text = "Bank",
									checked = AS.bank,
									func = function()
										kRestack("auto bank")
									end
								},
								{
									text = "Guild Vault",
									checked = AS.guild,
									func = function()
										kRestack("auto guild")
									end
								}
							} do
								UIDropDownMenu_AddButton(opt, 1)
							end
						end,
						"MENU"
					)
					return ToggleDropDownMenu(1, nil, drop, self, 0, 0)
				elseif button == "LeftButton" then
					kRestack(atBank and "bank" or atVault and "guild" or "bags")
				end
			end
		}
	)
end

-- watching some events
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("BANKFRAME_OPENED")
f:RegisterEvent("BANKFRAME_CLOSED")
f:RegisterEvent("LOOT_OPENED")
f:RegisterEvent("BAG_OPEN")
f:RegisterEvent("BAG_UPDATE")
f:RegisterEvent("BAG_UPDATE_DELAYED")

f:SetScript(
	"OnEvent",
	function(_, e, addon)
		-- more ldb stuff
		if e == "BANKFRAME_OPENED" then
			atBank = true
		elseif e == "BANKFRAME_CLOSED" then
			atBank = false
		end
		if e == "ADDON_LOADED" then
			-- initialize SavedVariables
			if addon == "kRestack" then
				-- loading ldb plugin
				if type(AutoStack) ~= "table" then
					AutoStack = {}
				end
				local c = UnitName("player") .. " - " .. GetRealmName()
				if type(AutoStack[c]) ~= "table" then
					AutoStack[c] = {}
				end
				AS = AutoStack[c]
				if AS.bags == nil then
					AS.bags = true
				end
				if AS.bank == nil then
					AS.bank = true
				end
				if AS.guild == nil then
					AS.guild = false
				end
			elseif LibStub and ldb then
				if LibStub:GetLibrary("LibDataBroker-1.1", true) then
					ldb()
					ldb = nil
				end
			end
		elseif AS.bank and e == "BANKFRAME_OPENED" then
			kRestack("bank", true)
		elseif AS.bags and e == "LOOT_OPENED" then
			kRestack("bags", true)
		end
	end
)

-- hooking auto-stacking
for _, func in ipairs {
	"CloseAllBags",
	"ToggleBackpack",
	"ToggleBag",
	"OpenBackpack",
	"OpenAllBags",
	"OpenBackpack",
	"CloseBackpack"
} do
	hooksecurefunc(
		func,
		function()
			if AS.bags then
				kRestack("bags", true)
			end
		end
	)
end

local oSetCurrentGuildBankTab = SetCurrentGuildBankTab
SetCurrentGuildBankTab = function(tab)
	if type(restacker) == "thread" then
		tabswap = tabswap + 1
		if tabswap > 1 then
			restacker = nil
		end
	end
	-- going to lock tab switching while stacking is in progress
	if type(restacker) ~= "thread" or coroutine.status(restacker) == "dead" then
		oSetCurrentGuildBankTab(tab)
		isViewable, canDeposit = select(3, GetGuildBankTabInfo(tab))
		if AS.guild and (IsGuildLeader() or (isViewable and canDeposit)) then
			kRestack("guild", false, tab)
		end
	end
end

-- yielding function; items will get locked and we have to wait
local function coYield(loc, bag, slot, count)
	local elapsed = 0
	f:SetScript(
		"OnUpdate",
		function(_, update)
			elapsed = elapsed + update
			if type(restacker) == "thread" and coroutine.status(restacker) == "suspended" and elapsed > 0.1 then
				local locked = true
				locked =
					loc == "guild" and (select(2, GetGuildBankItemInfo(bag, slot)) == count and true or false) or
					select(3, GetContainerItemInfo(bag, slot))
				if not locked then
					coroutine.resume(restacker)
				end
				elapsed = 0
			end
		end
	)
	coroutine.yield()
end

-- main function
function kRestack(loc, silent, tab)
	if loc ~= "bags" and loc ~= "bank" and loc ~= "guild" then
		if loc == "resume" then
			-- manual resume if stuck
			if coroutine.status(restacker) == "suspended" then
				print(kR, "Resuming suspended thread.")
				coroutine.resume(restacker)
			else
				print(kR, "No suspended threads to resume.")
			end
		else
			loc = loc:match("auto (%a+)")
			if loc == "bags" or loc == "bank" or loc == "guild" then
				-- toggle auto-stack
				AS[loc] = not AS[loc]
				print(
					kR,
					"Auto-stacking for",
					loc:gsub("bags", "your backpack"):gsub("bank", "your bank"):gsub("guild", "the guild vault"),
					"toggled",
					AS[loc] and green .. "ON" or red .. "OFF"
				)
			else
				-- usage message
				local bags = (AS.bags and green or red) .. "bags" .. white
				local bank = (AS.bank and green or red) .. "bank" .. white
				local guild = (AS.guild and green or red) .. "guild" .. white

				print(kR, "Usage:")
				print(white .. "-    /restack [bags, bank, guild] - Run restacker manually")
				print(white .. "-    /restack auto [" .. bags .. ",", bank .. ",", guild .. "] - Toggle auto-stacking")
			end
		end
		return
	end

	if type(restacker) ~= "thread" or coroutine.status(restacker) == "dead" then
		restacker =
			coroutine.create(
			function()
				tabswap = 0
				local changed = true
				while changed do
					changed = false
					local vault = loc == "guild"
					for _, bag in ipairs(container[loc]) do
						if changed then
							break
						end
						bag = vault and tab or bag
						for slot = 1, (vault and MAX_GUILDBANK_SLOTS_PER_TAB or GetContainerNumSlots(bag)) do
							while true and not vault do
								local locked = select(3, GetContainerItemInfo(bag, slot))
								if locked then
									coYield(loc, bag, slot)
								else
									break
								end
							end
							local item = vault and GetGuildBankItemLink(bag, slot) or GetContainerItemLink(bag, slot)
							if item then
								local itemid = tonumber(item:match("item:(%d+)"))
								local stack = select(8, GetItemInfo(itemid))
								local count = vault and select(2, GetGuildBankItemInfo(bag, slot)) or select(2, GetContainerItemInfo(bag, slot))

								-- do "special" things with "special" items by moving them into "special" bags
								if not vault and select(9, GetItemInfo(itemid)) ~= "INVTYPE_BAG" then
									local bagType =
										(bag ~= 0 and bag ~= -1) and GetItemFamily(GetInventoryItemLink("player", ContainerIDToInventoryID(bag))) or 0
									for _, sbag in ipairs(container[loc]) do
										if sbag > 0 and GetContainerNumFreeSlots(sbag) > 0 then
											local sbagID = ContainerIDToInventoryID(sbag)
											local sbagType = GetItemFamily(GetInventoryItemLink("player", sbagID))
											local itemType = GetItemFamily(item)

											if sbagType > 0 and sbagType == itemType and bagType == 0 then
												PickupContainerItem(bag, slot)
												PutItemInBag(sbagID)
												coYield(loc, bag, slot)
												break
											end
										end
									end
								end
								if count < stack then
									-- found a partial stack
									local locked, found, done, pbag, pslot
									while true do
										-- search through bags backwards for another partial stack with a matching itemid
										for i = #container[loc], 1, -1 do
											local _bag = container[loc][i]
											if found or done then
												break
											end
											local _slots = vault and MAX_GUILDBANK_SLOTS_PER_TAB or GetContainerNumSlots(_bag)
											for _slot = _slots, 1, -1 do
												if vault then
													_bag = bag
												end
												if not (_bag == bag and _slot == slot) then
													local _item = vault and GetGuildBankItemLink(_bag, _slot) or GetContainerItemLink(_bag, _slot)
													if _item then
														local _itemid = tonumber(_item:match("item:(%d+):"))
														if _itemid == itemid then
															local _stack = select(8, GetItemInfo(_itemid))
															local _count =
																vault and select(2, GetGuildBankItemInfo(_bag, _slot)) or select(2, GetContainerItemInfo(_bag, _slot))
															if _count < _stack then
																found, pbag, pslot = true, _bag, _slot
																break
															end
														end
													end
												else
													done = true
													break
												end
											end
										end
										if vault then
											break
										end
										locked = found and select(3, GetContainerItemInfo(pbag, pslot)) or false
										if locked then
											coYield(loc, pbag, pslot)
										else
											break
										end
									end

									if found then
										ClearCursor()
										if vault then
											PickupGuildBankItem(pbag, pslot)
											PickupGuildBankItem(bag, slot)
											ClearCursor()
											coYield(loc, bag, slot, count)
										else
											-- if second partial stack is inside a special bag, move the original stack into it
											local bagType =
												(bag ~= 0 and bag ~= -1) and GetItemFamily(GetInventoryItemLink("player", ContainerIDToInventoryID(bag))) or
												0
											local pbagType =
												(pbag ~= 0 and pbag ~= -1) and GetItemFamily(GetInventoryItemLink("player", ContainerIDToInventoryID(pbag))) or
												0
											if pbagType > 0 and bagType == 0 then
												PickupContainerItem(bag, slot)
												PickupContainerItem(pbag, pslot)
											else
												PickupContainerItem(pbag, pslot)
												PickupContainerItem(bag, slot)
											end
											ClearCursor()
										end
										changed = true
										break
									end
								end
							end
						end
					end
				end
				-- turn off yielding function
				f:SetScript("OnUpdate", nil)
			end
		)
		coroutine.resume(restacker)
	else
		if not silent then
			-- user is impatient or there is a stall, tell them so
			print(kR .. red, "Restacking in progress. (use '/restack resume' if stuck)")
		end
	end
end
