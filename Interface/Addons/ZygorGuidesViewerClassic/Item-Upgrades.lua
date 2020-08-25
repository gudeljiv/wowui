local ZGV = ZygorGuidesViewer
if not (ZGV and ZGV.ItemScore) then return end

local L = ZGV.L
local G = _G
local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local CHAIN = ZGV.ChainCall

local tinsert,tremove,print,ipairs,pairs,wipe,debugprofilestop=tinsert,tremove,print,ipairs,pairs,wipe,debugprofilestop

local ItemScore = ZGV.ItemScore
local Upgrades = {}
ItemScore.Upgrades = Upgrades

local strip_link = ItemScore.strip_link

Upgrades.EquippedItems = {
	[INVSLOT_MAINHAND] = {},
	[INVSLOT_OFFHAND] = {},
	[INVSLOT_HEAD] = {},
	[INVSLOT_NECK] = {},
	[INVSLOT_SHOULDER] = {},
	[INVSLOT_BACK] = {},
	[INVSLOT_CHEST] = {},
	[INVSLOT_WRIST] = {},
	[INVSLOT_HAND] = {},
	[INVSLOT_WAIST] = {},
	[INVSLOT_LEGS] = {},
	[INVSLOT_FEET] = {},
	[INVSLOT_FINGER1] = {},
	[INVSLOT_FINGER2] = {},
	[INVSLOT_TRINKET1] = {},
	[INVSLOT_TRINKET2] = {},
	[INVSLOT_TRINKET2] = {},
	--[INVSLOT_AMMO] = {},
	[INVSLOT_RANGED] = {},
}

local GREEN = "|cff00ff00"
local RED = "|cffff0000"

Upgrades.UniqueEquipped = {}

function Upgrades:ScoreEquippedItems()
	ZGV:Debug("&itemscore ScoreEquippedItems")
	table.wipe(Upgrades.UniqueEquipped)
	Upgrades.ScoredEquippedItems = false
	
	local skipped = false

	for slotID,v in pairs(Upgrades.EquippedItems) do 
		table.wipe(v)
		local itemid = GetInventoryItemID("player", slotID)
		local itemlink = GetInventoryItemLink("player", slotID)
		if itemid and itemid>0 then
			if itemlink then
				local item = ItemScore:GetItemDetails(itemlink)
				itemlink = strip_link(itemlink)
				if item and itemlink then 
					local score,success,comment = ItemScore:GetItemScore(itemlink)
					local protected, protectedslot = ItemScore.QuestItem:IsProtectedQuestItem(itemlink)
					if protected then score = 999999 end

					if success then
						local itemdata = Upgrades.EquippedItems[slotID]
						itemdata.itemlink = itemlink
						itemdata.itemid = item.itemid
						itemdata.score = score
						itemdata.quality = item.quality
						itemdata.type = item.type

						ZGV:Debug("&itemscore SEI slot %d scored %d",slotID,score)

						-- cache counts of unique-equipped items
						local family, _ = Upgrades:GetItemUniqueness(item.itemid)
						if (family or 0)>0 then Upgrades.UniqueEquipped[family]=(Upgrades.UniqueEquipped[family] or 0)+1 end
					end
				else
					skipped = true
				end
			else
				skipped = true
			end
		end
	end

	if not skipped then
		Upgrades.ScoredEquippedItems = true
	else
		ZGV:Debug("&itemscore SEI missed some item")
		ZGV:Debug("&itemscore SEI NOT complete")
	end

	ZGV:Debug("&itemscore SEI complete")
end

local unique_equip_families = ItemScore.Unique_Equipped_Families
function Upgrades:GetItemUniqueness(id)
	for family,fitems in pairs(unique_equip_families) do
		if fitems[id] then 
			return family,fitems[id]
		end
	end
	local fam,max = GetItemUniqueness(id)
	return fam,max
end

function Upgrades:CanUseUniqueItem(itemlink,slot)
	if not itemlink then return false end
	local item = ItemScore:GetItemDetails(itemlink)

	if not item then return false end
	local uniqueness_fam,maxEquip = Upgrades:GetItemUniqueness(item.itemid)

	if not uniqueness_fam then return true, "no family" end

	local slot_1, slot_2 = item.slot, item.slot_2
	local current_itemid, equipped_item_1, equipped_item_2

	if slot_1 then 
		equipped_item_1 = Upgrades.EquippedItems[slot_1].itemid 
		if slot_1 == slot then current_itemid = equipped_item_1 end
	end

	if slot_2 then 
		equipped_item_2 = Upgrades.EquippedItems[slot_2].itemid 
		if slot_2 == slot then current_itemid = equipped_item_2 end
	end

	if uniqueness_fam<0 then
		if equipped_item_1 == item.itemid or equipped_item_2 == item.itemid then 
			-- ok, this itemid is equipped, we can only suggest it for replacement
			return current_itemid==item.itemid, "only replacement"
		else
			-- nothing from that family is equipped, do suggest
			return true, "family not equipped"
		end
	else 
		-- more than one allowed, count all and see
		local currently = Upgrades.UniqueEquipped[uniqueness_fam] or 0

		if currently >= maxEquip then
			-- we are at the threshold, suggest only if replacing other from same family
			return current_itemid and uniqueness_fam==Upgrades:GetItemUniqueness(current_itemid), "replace family "..uniqueness_fam
		else
			-- we are below threshold, do suggest
			return true, "has family "..uniqueness_fam
		end
	end
end

local function get_change(old,new)
	if old and old>0 then return (new*100/old)-100 else return 100 end
end

local function get_upgrade(newitem,olditem,secondnewitem)
	local new_item_score = newitem.score or 0
	if (secondnewitem and secondnewitem.itemlink) then
		new_item_score = new_item_score + (secondnewitem.score or 0)
	end

	if olditem and not ItemScore:IsValidItem(olditem.itemlink) then
		return 100 -- old item is not valid, spec change?
	end

	if not (olditem and olditem.itemlink) then 
		-- no item equipped, whatever it is, it is an upgrade
		return 100
	elseif olditem.quality <= 1 and olditem.score==0 then -- quest items may be low quality, but are protected by magic
		-- low quality item
		if new_item_score > 0  then
			-- and we are equipping better quality one with any score. it will be an upgrade
			return 100
		end
	elseif olditem.score and new_item_score > olditem.score then
		-- ok, non trash equipped, and it is better
		return get_change(olditem.score, new_item_score)
	end

	-- just in case
	return 0
end

-- Checks if item is valid upgrade for any of matching slots
-- params:
--   itemlink - string
--   future - anything - for checks for future upgrades. if set, level restriction is not checked
-- returns:
--   is upgrade - bool
--   slot - int or nil - slotid for what the item is upgrade for, or nil if not an upgrade
--   change - int - percentage of score change
--   score - int - score value
--   comment - string - verbose comment
--   slot_2 - int or nil - optional secondary slotid for what the item is upgrade for, or nil if not an upgrade
--   change_2 - int - percentage of score change

local fishing_gear = {[19969]=true,[50287]=true,[49895]=true}
function Upgrades:IsUpgrade(itemlink,future)
	if not itemlink then return false, nil, 0, 0, "no link" end
	itemlink = strip_link(itemlink)
	if not itemlink then return false, nil, 0, 0, "no link" end

	if Upgrades.BadUpgrades[itemlink] then return false, "", 0, 0, "rejected" end
	
	local protected, protectedslot = ItemScore.QuestItem:IsProtectedQuestItem(itemlink)
	if protected then return true, protectedslot, 999999, 999999, "quest item" end

	-- check validity
	local score,success,comment = ItemScore:GetItemScore(itemlink)
	if not success then return false, nil, 0, 0, "not scored" end
	local valid, final, comment = ItemScore:IsValidItem(itemlink,future)
	if not valid then return false, nil, 0, 0, "not valid "..comment end

	ZGV:Debug("&itemscore Checking %s for upgrade",itemlink)

	-- ok, item is valid, let's see if it can be used anywhere as upgrade
	local item = ItemScore:GetItemDetails(itemlink)
	if not item then return false, nil, 0, 0, "no link" end

	local slot_1, slot_2, is2hnd = item.slot, item.slot_2 ,item.twohander
	local equipped_item_1, equipped_item_2
	if slot_1 then equipped_item_1 = Upgrades.EquippedItems[slot_1] end
	if slot_2 then equipped_item_2 = Upgrades.EquippedItems[slot_2] end

	-- protect fishing gear if fishing pole is equipped
	if equipped_item_1 and fishing_gear[equipped_item_1.itemid] then
		local mainhand = Upgrades.EquippedItems[INVSLOT_MAINHAND].itemlink
		if mainhand then 
			mainhand = ItemScore:GetItemDetails(mainhand)
			if mainhand.subclass==20 then return false, "", 0, 0, "gone fishing" end
		end
	end

	local upgrade_slot_1, upgrade_slot_2 = 0, 0

	-- check first slot
	local upgrade_slot_1 = get_upgrade(item,equipped_item_1)
	local can_equip_1 = Upgrades:CanUseUniqueItem(itemlink,slot_1)

	--- this item has only one possible slot. 
	if not slot_2 then
		-- if we have upgrade in it, we are good
		if can_equip_1 and upgrade_slot_1 > 0 then
			return true, slot_1, upgrade_slot_1, item.score, "ok" 
		else
			return false, slot_1, 0, item.score, "not upgrade"
		end
	end

	-- we are still here? then item has two possible slots. 

	-- check second slot
	local upgrade_slot_2 = get_upgrade(item,equipped_item_2)
	local can_equip_2 = Upgrades:CanUseUniqueItem(itemlink,slot_2)

	-- upgrade for both slots
	if upgrade_slot_1 > 0 and upgrade_slot_2 > 0 then
		return true, slot_1, upgrade_slot_1, item.score, "ok", slot_2, upgrade_slot_2
	else
	-- upgrade for one slot
		if can_equip_1 and upgrade_slot_1 > 0 then
			return true, slot_1, upgrade_slot_1, item.score, "ok"
		elseif can_equip_2 and upgrade_slot_2 > 0 then
			return true, slot_2, upgrade_slot_2, item.score, "ok"
		end
	end

	-- we are still here? then item did not trigger any of upgrade possibilities. exit stage left
	return false, slot_1, 0, item.score, "not upgrade"
end

local function Zygor_GetItemStats(item)
	if ItemScore.ItemCache[item] then
		return ItemScore.ItemCache[item].stats
	else
		return GetItemStats(item)
	end
end

-- Calculates stat differences between given items
-- params:
--	item1 - string - itemlink of first item, always represents new item being equipped
--	item2 - string, optional - itemlink of second item (either old, old1 or new2)
--	item3 - string, optional - itemlink of third item (either old or old2)
--	mode_old - string, optional - special modes for handling more complex cases, values "equip_pair"
--	mode_new - string, optional - special modes for handling more complex cases, values "equip_pair"
function Upgrades:GetStatChange(item1,item2,item3,mode_new,mode_old)
	if not item1 then return false end -- something went wrong. we need at least one item
	local delta = {}
	local changes = ""
	local item1_stats, item2_stats, item3_stats

	item1_stats = Zygor_GetItemStats(item1)
	for i,v in pairs(item1_stats) do delta[i]=0 end

	if not item3 and not (mode_old or mode_new) then -- ok, we only have one or two items, so we can use blizzard functions
		if item1 and item2 then
			item2_stats = Zygor_GetItemStats(item2)
			for i,v in pairs(item2_stats) do delta[i]=0 end
			for i,v in pairs(delta) do delta[i] = (item1_stats[i] or 0) - (item2_stats[i] or 0) end
		else
			delta = item1_stats
		end
	else -- sigh. three items, here comes the pain
		item2_stats = Zygor_GetItemStats(item2)
		item3_stats = Zygor_GetItemStats(item3)
		for i,v in pairs(item2_stats) do delta[i]=0 end
		for i,v in pairs(item3_stats) do delta[i]=0 end

		-- calculate values
		if mode_new=="equip_pair" then
			-- item1 and item2 are new, item3 is old
			for i,v in pairs(delta) do delta[i] = (item1_stats[i] or 0) + (item2_stats[i] or 0) - (item3_stats[i] or 0) end
		else
			-- item1 is new, item2 and item3 are old
			for i,v in pairs(delta) do delta[i] = (item1_stats[i] or 0) - (item2_stats[i] or 0) - (item3_stats[i] or 0) end
		end
	end

	if not delta then return false end -- something went wrong. we should have at least single item stats

	for stat,value in pairs(delta) do
		if ItemScore.KnownKeyWords[stat] then -- hide stats that do not have blizzard names (shadow sockets for example)
			local mode = "%d"
			if stat == "DAMAGE_PER_SECOND" then -- show dps as float
				mode = "%.1f"
			end
			if value>0 then
				changes = changes..("%s+"..mode.." %s\n"):format(GREEN,value,ItemScore.KnownKeyWords[stat])
			elseif value<0 then
				changes = changes..("%s"..mode.." %s\n"):format(RED,value,ItemScore.KnownKeyWords[stat])
			end
		end
	end

	return changes.."|r"
end

Upgrades.UpgradeQueue = {
	[INVSLOT_MAINHAND] = {},
	[INVSLOT_OFFHAND] = {},
	[INVSLOT_RANGED] = {},
	[INVSLOT_HEAD] = {},
	[INVSLOT_NECK] = {},
	[INVSLOT_SHOULDER] = {},
	[INVSLOT_BACK] = {},
	[INVSLOT_CHEST] = {},
	[INVSLOT_WRIST] = {},
	[INVSLOT_HAND] = {},
	[INVSLOT_WAIST] = {},
	[INVSLOT_LEGS] = {},
	[INVSLOT_FEET] = {},
	[INVSLOT_FINGER1] = {},
	[INVSLOT_FINGER2] = {},
	[INVSLOT_TRINKET1] = {},
	[INVSLOT_TRINKET2] = {},
}

-- Checks item details for weapon types and pushes it into one of weapon arrays
-- params:
--	itemlink - string - item being tested
-- return:
--	success - bool - was item a valid weapon
local main_hand = {}
local off_hand = {}
local two_hand = {}
function Upgrades:QueueWeapon(itemlink)
	local item = ItemScore:GetItemDetails(itemlink)
	if not item then return false end

	if Upgrades.BadUpgrades[item.itemlink] then return false, "", 0, 0, "rejected" end

	if item.class ~= LE_ITEM_CLASS_WEAPON and not (item.type=="INVTYPE_HOLDABLE" or item.type=="INVTYPE_SHIELD") then return false end

	if ItemScore:IsValidItem(item.itemlink) then
		ZGV:Debug("&itemscore QueueWeapon weapon %s",itemlink)

		local slot_1, slot_2, twohand = item.slot , item.slot_2, item.twohander
		local score = ItemScore:GetItemScore(itemlink)

		if twohand and not ItemScore.playerDualTwohanders then 
			ZGV:Debug("&itemscore SBFU 2h weapon")
			table.insert(two_hand,item)
		else
			if (slot_1==INVSLOT_OFFHAND or slot_2==INVSLOT_OFFHAND) and Upgrades:CanUseUniqueItem(itemlink,INVSLOT_OFFHAND) then 
				ZGV:Debug("&itemscore SBFU oh weapon")
				table.insert(off_hand,item) 
			end
			if (slot_1==INVSLOT_MAINHAND) and Upgrades:CanUseUniqueItem(itemlink,INVSLOT_MAINHAND) then 
				ZGV:Debug("&itemscore SBFU mh weapon")
				table.insert(main_hand,item) 
			end
		end
		return true
	end

	return false
end

-- Clears all weapon queue arrays
-- params:
--	onlytemp - bool - will only clear items that are not in bags
function Upgrades:ResetWeaponQueue(onlytemp)
	if onlytemp then
		for i=#main_hand,1,-1 do if not main_hand[i].bagslot then table.remove(main_hand,i) end end
		for i=#off_hand,1,-1 do if not off_hand[i].bagslot then table.remove(off_hand,i) end end
		for i=#two_hand,1,-1 do if not two_hand[i].bagslot then table.remove(two_hand,i) end end
	else
		table.wipe(main_hand)
		table.wipe(off_hand)
		table.wipe(two_hand)
	end
end

-- Checks all queued weapons for best combination of mh+oh/2h
-- no params
-- returns:
--	mh - array, nillable - item object of mainhand to be used
--	oh - array, nillable - item object of offhand to be used
--	th - array, nillable - item object of twohand to be used
function Upgrades:ProcessWeaponQueue()
	-- check for best 2*1hander or 1*twohander
	local equipped_weapon_1 = ItemScore:GetItemDetails(Upgrades.EquippedItems[INVSLOT_MAINHAND].itemlink)
	local equipped_weapon_2 = ItemScore:GetItemDetails(Upgrades.EquippedItems[INVSLOT_OFFHAND].itemlink)

	equipped_weapon_1 = equipped_weapon_1 and ItemScore:IsValidItem(equipped_weapon_1.itemlink) and equipped_weapon_1
	equipped_weapon_2 = equipped_weapon_2 and ItemScore:IsValidItem(equipped_weapon_2.itemlink) and equipped_weapon_2

	-- check if currently equipped weapons are still valid (spec change, for example)
	if equipped_weapon_2 then
		local s1, s2 = ItemScore:GetValidSlots(equipped_weapon_1)
		if s1~=INVSLOT_MAINHAND then equipped_weapon_1 = nil end
	end

	if equipped_weapon_1 then
		local s1, s2 = ItemScore:GetValidSlots(equipped_weapon_2)
		if (s1~=INVSLOT_OFFHAND and s2~=INVSLOT_OFFHAND) then equipped_weapon_2 = nil end
	end


	local equipped_weapon_1_score = equipped_weapon_1 and equipped_weapon_1.score or 0
	local equipped_weapon_2_score = equipped_weapon_2 and equipped_weapon_2.score or 0

	ZGV:Debug("&itemscore PWQ Weapon 1 %d",equipped_weapon_1_score or -1)
	ZGV:Debug("&itemscore PWQ Weapon 2 %d",equipped_weapon_2_score or -1)
	local twohand = equipped_weapon_1 and equipped_weapon_1.twohander

	-- sort all weapons by score
	table.sort(main_hand,function(a,b) return a.score>b.score end)
	table.sort(off_hand,function(a,b) return a.score>b.score end)
	table.sort(two_hand,function(a,b) return a.score>b.score end)

	-- same weapon cannot be at the same time in main and offhand
	if main_hand[1] and off_hand[1] and main_hand[1]==off_hand[1] then
		if not equipped_weapon_1 or twohand then
			ZGV:Debug("&itemscore PWQ same item, drop off, no main")
			table.remove(off_hand,1)
		elseif not equipped_weapon_2 then		
			ZGV:Debug("&itemscore PWQ same item, drop main, no off")
			table.remove(main_hand,1)
		else
			local mh_change = get_upgrade(main_hand[1],equipped_weapon_1)
			local oh_change = get_upgrade(off_hand[1],equipped_weapon_2)

			if mh_change>oh_change then
				ZGV:Debug("&itemscore PWQ same item, keep main")
				table.remove(off_hand,1)
			else
				ZGV:Debug("&itemscore PWQ same item, keep off")
				table.remove(main_hand,1)
			end
		end
	end

	local best_main = main_hand[1]
	local best_off = off_hand[1]
	local best_two = two_hand[1]
	local best_main_score = best_main and best_main.score or 0
	local best_off_score = best_off and best_off.score or 0
	local best_two_score = best_two and best_two.score or 0

	--Spoo({main_hand=main_hand,off_hand=off_hand,two_hand=two_hand})

	-- if current mainhand/offhand weapon is better than the best we found, do not consider it for replacement, only for pair calculations
	if (not twohand or ItemScore.playerDualTwohanders) and equipped_weapon_1 and equipped_weapon_1_score>best_main_score then
		ZGV:Debug("&itemscore PWQ Equipped MH better")
		best_main = nil
		best_main_score = equipped_weapon_1_score
	end

	if (not twohand) and equipped_weapon_2 and equipped_weapon_2_score>best_off_score then
		ZGV:Debug("&itemscore PWQ Equipped OH better")
		best_off = nil
		best_off_score = equipped_weapon_2_score
	end

	if twohand and equipped_weapon_1 and equipped_weapon_1_score>best_two_score then
		ZGV:Debug("&itemscore PWQ Equipped 2H better")
		best_two = nil
		best_two_score = equipped_weapon_1_score
	end

	ZGV:Debug("&itemscore PWQ Best MH %d %s",best_main_score,best_main and best_main.itemlink or "")
	ZGV:Debug("&itemscore PWQ Best OH %d %s",best_off_score,best_off and best_off.itemlink or "")
	ZGV:Debug("&itemscore PWQ Best 2H %d %s",best_two_score,best_two and best_two.itemlink or "")

	if best_two_score > (best_main_score + best_off_score) then -- two hander is better than main/off combination
		ZGV:Debug("&itemscore PWQ 2H better than pair")
		--if best_two and (best_two_score > (equipped_weapon_1 and equipped_weapon_1_score or 0)) and (equipped_weapon_1 and equipped_weapon_1.itemlink ~= best_two.itemlink) then
		if best_two and (best_two_score > (equipped_weapon_1 and equipped_weapon_1_score or 0)) then
			ZGV:Debug("&itemscore PWQ 2H better than equipped")
			return nil, nil, best_two
		end
	else
		ZGV:Debug("&itemscore PWQ checking 1handers")
		local mh, oh = nil, nil
		if (best_main and best_main_score or 0) > 0 then
			ZGV:Debug("&itemscore PWQ MH upgrade")
			mh = best_main
		end
		if not twohand and (best_off and best_off_score or 0) > 0 then -- do not equip only offhand if twohand is currently in use
			ZGV:Debug("&itemscore PWQ OH upgrade")
			oh = best_off
		end
		return mh, oh, nil
	end
	ZGV:Debug("&itemscore PWQ no upgrades")
	return nil, nil, nil
end

function Upgrades:ScanBagsForUpgrades(onlyscan)
	ZGV:Debug("&itemscore ScanBagsForUpgrades")

	ItemScore.EquipTimer = nil
	if not ZGV.db.profile.autogear then return end -- disabled
	if not ItemScore.ActiveRuleSet then return end -- we are early, itemscore is not ready
	if not Upgrades.ScoredEquippedItems then return end  -- we are early, upgrades is not ready

	-- clear any related popups
	if Upgrades.EquipPopup then Upgrades.EquipPopup:Hide() end
	ZGV.NotificationCenter.RemoveButton(self.EquipPopup:GetName())

	-- clear upgrade queue
	for i,v in pairs(Upgrades.UpgradeQueue) do table.wipe(v) end
	Upgrades.UpgradeQueueCount = 0

	-- clear weapons
	Upgrades:ResetWeaponQueue()

	for bagnum=0, NUM_BAG_SLOTS do
		for bagslot=1, GetContainerNumSlots(bagnum) do
			local itemlink = GetContainerItemLink(bagnum,bagslot)
			if itemlink then
				local item = ItemScore:GetItemDetails(itemlink)
				ItemScore:GetItemScore(itemlink)
				if item and item.score then
					itemlink = item.itemlink
					ZGV:Debug("&itemscore SBFU bag %d slot %d",bagnum,bagslot)
					if (item.class == LE_ITEM_CLASS_WEAPON and not (item.type=="INVTYPE_THROWN" or item.type=="INVTYPE_RANGED" or item.type=="INVTYPE_RANGEDRIGHT")) or (item.type=="INVTYPE_HOLDABLE" or item.type=="INVTYPE_SHIELD") then
						-- for weapons, we may need to switch between 2hnd and two 1hnders
						-- so, we will record everything, and then look for best combination later
						if Upgrades:QueueWeapon(itemlink) then
							item.bagnum = bagnum
							item.bagslot = bagslot
						end
					else
						local is_upgrade, slot, change, score, comment, slot_2, change_2 = Upgrades:IsUpgrade(item.itemlink)
						if is_upgrade then
							local upgrade_slot = Upgrades.UpgradeQueue[slot]
							if Upgrades:CanUseUniqueItem(itemlink,slot) and (((score or 0) > (upgrade_slot.score or 0)) or ((score or 0)==0 and (upgrade_slot.score or 0)==0)) then
								ZGV:Debug("&itemscore SBFU armor upgrade %d %s %d",slot,itemlink,score or 0)
								upgrade_slot.itemlink = itemlink
								upgrade_slot.score = score or 0 
								upgrade_slot.change = change or 0
								upgrade_slot.bagnum = bagnum
								upgrade_slot.bagslot = bagslot
								upgrade_slot.slot = slot
								if comment=="quest item" then upgrade_slot.quest=true end
							end
							if slot_2 then -- upgrade for both slots (rings, trinkets, weapons)
								local upgrade_slot = Upgrades.UpgradeQueue[slot_2]
								if Upgrades:CanUseUniqueItem(itemlink,slot_2) and (((score or 0) > (upgrade_slot.score or 0)) or ((score or 0)==0 and (upgrade_slot.score or 0)==0)) then
									ZGV:Debug("&itemscore SBFU second slot %d",slot_2)
									upgrade_slot.itemlink = itemlink
									upgrade_slot.score = score or 0
									upgrade_slot.change = change_2 or 0
									upgrade_slot.bagnum = bagnum
									upgrade_slot.bagslot = bagslot
									upgrade_slot.slot = slot_2
								end
							end
						end
					end
				end
			end
		end
	end

	-- process upgrades now, since functions that called with onlyscan may want the results
	local mh, oh, th = Upgrades:ProcessWeaponQueue()


	local equipped_weapon_1 = ItemScore:GetItemDetails(Upgrades.EquippedItems[INVSLOT_MAINHAND].itemlink)
	local equipped_weapon_2 = ItemScore:GetItemDetails(Upgrades.EquippedItems[INVSLOT_OFFHAND].itemlink)

	-- if fishing pole is equipped, then do not replace it
	if equipped_weapon_1 and equipped_weapon_1.subclass==20 then mh,oh,th=nil,nil,nil end

	if th then
		local upgrade_slot = Upgrades.UpgradeQueue[INVSLOT_MAINHAND]
		upgrade_slot.itemlink = th.itemlink
		upgrade_slot.score = th.score
		upgrade_slot.change = get_upgrade(th,equipped_weapon_1)
		upgrade_slot.bagnum = th.bagnum
		upgrade_slot.bagslot = th.bagslot
		upgrade_slot.slot = INVSLOT_MAINHAND
		upgrade_slot.twohand = true
		upgrade_slot.pair = equipped_weapon_2
		ZGV:Debug("&itemscore SBFU 2H %s",th.itemlink)
	else
		if mh then
			local upgrade_slot = Upgrades.UpgradeQueue[INVSLOT_MAINHAND]
			upgrade_slot.itemlink = mh.itemlink
			upgrade_slot.score = mh.score
			upgrade_slot.change = get_upgrade(mh,equipped_weapon_1,oh)
			upgrade_slot.bagnum = mh.bagnum
			upgrade_slot.bagslot = mh.bagslot
			upgrade_slot.slot = INVSLOT_MAINHAND
			if equipped_weapon_1 and equipped_weapon_1.twohander then
				upgrade_slot.pair = oh
			end
			ZGV:Debug("&itemscore SBFU MH %s",mh.itemlink)
		end
		if oh then
			local upgrade_slot = Upgrades.UpgradeQueue[INVSLOT_OFFHAND]
			upgrade_slot.itemlink = oh.itemlink
			upgrade_slot.score = oh.score
			upgrade_slot.change = get_upgrade(oh,equipped_weapon_2,mh)
			upgrade_slot.bagnum = oh.bagnum
			upgrade_slot.bagslot = oh.bagslot
			upgrade_slot.slot = INVSLOT_OFFHAND
			ZGV:Debug("&itemscore SBFU OH %s",oh.itemlink)
		end
	end

	for slot,newitem in pairs(Upgrades.UpgradeQueue) do 
		if newitem.itemlink then
			Upgrades.UpgradeQueueCount = Upgrades.UpgradeQueueCount + 1
		end
	end

	if onlyscan then return end

	Upgrades:ProcessPossibleUpgrades()
end

function Upgrades:ProcessPossibleUpgrades()
	if ZGV:IsPlayerInCombat() then return end -- nope, no can do, will retry when combat is done

	local process_slot, max_change = nil,0
	for slot,newitem in pairs(Upgrades.UpgradeQueue) do 
		if slot==17 and process_slot then ZGV:Debug("&itemscore PPU slot %d: processed, breaking",slot) break end -- don't look at offhands if we have mainhand queued

		if newitem.itemlink then
			if not Upgrades.EquippedItems[slot] then -- nothing, so equipping something in empty slot
				process_slot = slot
				break
			else
				if newitem.change>max_change then
					ZGV:Debug("&itemscore PPU slot %d: considering change %s",slot,newitem.change)
					max_change = newitem.change
					process_slot = slot
				end
			end
		end
	end
	
	if process_slot then
		ZGV:Debug("&itemscore PPU process_slot ended up %d",process_slot)
		if ZGV.db.profile.autogearauto then
			Upgrades:ShowEquipmentChangeNotification(process_slot)
		else
			Upgrades:ShowEquipmentChangePopup(process_slot)
		end
	end
end

function Upgrades:SetBadUpgrade(itemlink,slot)
	Upgrades.BadUpgrades[itemlink] = true
	table.wipe(Upgrades.UpgradeQueue[slot])
	Upgrades.UpgradeQueue[slot].score = 0

	-- continue with the queue
	ZGV:ScheduleTimer(function() 
		Upgrades:ScanBagsForUpgrades()
	end,0.1)
end

function Upgrades:ShowEquipmentChangeNotification(slot)
	if not slot then return end
	local n_item = Upgrades.UpgradeQueue[slot]
	if not n_item or not n_item.itemlink then return end
	local new_item = ItemScore:GetItemDetails(n_item.itemlink)
	if not new_item then return end

	local c_item = Upgrades.EquippedItems[slot]
	local current_item = c_item and c_item.itemlink and ItemScore:GetItemDetails(c_item.itemlink)
	if c_item and c_item.itemlink  and not current_item then return end

	local message = L['itemscore_ae_equip']:format(new_item.itemlinkfull)

	if current_item then
		message = message .. L['itemscore_ae_over']:format(current_item.itemlinkfull)
	end
	message = message.."." --add a period :D

	-- Print a message to user then equip the item!
	ZGV:Print(message)

	if ZGV.NotificationCenter then
		local texture,texcoords = ZGV.PopupHandler:GetNCTextureInfo("gear")

		local slottype = (new_item.type == "INVTYPE_RANGEDRIGHT" and "INVTYPE_RANGED") or new_item.type

		ZGV.NotificationCenter.AddButton(
			new_item.itemlink,
			L['notifcenter_gear_title'],
			L['notifcenter_gear_equipped']:format(new_item.itemlinkfull,_G[slottype]),
			texture,
			texcoords,
			onClick,
			function(self)
				local position,x,y = ZGV.NotificationCenter:GetTooltipPosition()
				GameTooltip:SetOwner(self, position or "ANCHOR_CURSOR",x or 0, y or 0)

				GameTooltip:SetHyperlink(new_item.itemlink)
				GameTooltip:SetToplevel(true)
				GameTooltip:Show()
			end,
			priority,
			poptime,
			600, -- Remove after 10m
			quiet,
			OnOpen,
			"gear" )
	end

	Upgrades:Equip(n_item)
end

function Upgrades:CreatePopup()
	if Upgrades.EquipPopup then return end

	local function make_button(index)
		local button = CHAIN(CreateFrame("Button",nil,Upgrades.EquipPopup))
			:SetFrameLevel(Upgrades.EquipPopup:GetFrameLevel()+2)
			:SetHeight(50)
			:SetPoint("LEFT")
			:SetPoint("RIGHT")
		.__END	

		button.itemicon = CHAIN(button:CreateTexture()) 
			:SetSize(30,30)
			:SetPoint("TOP",button) 
		.__END

		button.itemlink = CHAIN(button:CreateFontString())
			:SetPoint("TOP",button.itemicon,"BOTTOM",0,-5)
			:SetFont(FONT,12)
			:SetText("...button "..index)
			:SetPoint("LEFT")
			:SetPoint("RIGHT")
			:SetJustifyH("CENTER")
			:SetWordWrap(false)
		.__END

		button:SetScript("OnEnter",function() 
			if button.link then
				GameTooltip:SetOwner(button, "ANCHOR_CURSOR")
				GameTooltip:SetHyperlink(button.link)
				GameTooltip:Show()
			end
		end)
		button:SetScript("OnLeave",function()
			GameTooltip:FadeOut()
		end)

		function button:SetItem(item,index)
			if not item then return end
			button.itemicon:SetTexture(item.texture)
			button.itemlink:SetText(item.itemlinkfull)
			button.link = item.itemlinkfull
			button:Show()
		end
		return button
	end

	Upgrades.EquipPopup = ZGV.PopupHandler:NewPopup("ZygorItemPopup","gear")
	local F = Upgrades.EquipPopup

	local ui = ZGV.UI
	local SkinData = ui.SkinData

	F:SetWidth(300) -- Make it bigger!

	-- set up item display objects. item1 and item2 are for 1:1 replacements
	for i=1,2 do
		F["item"..i]=make_button(i)
	end

	-- make double item button, for mh/oh<>th replacement
	local button = CHAIN(CreateFrame("Button",nil,Upgrades.EquipPopup))
		:SetFrameLevel(Upgrades.EquipPopup:GetFrameLevel()+3)
		:SetSize(240,70)
	.__END	
		F.item_double = button

		local function show_item_1()
			if button.link1 then
				GameTooltip:SetOwner(button.linkcontainer_link1, "ANCHOR_CURSOR")
				GameTooltip:SetHyperlink(button.link1)
				GameTooltip:Show()
			end
		end

		local function show_item_2()
			if button.link2 then
				GameTooltip:SetOwner(button.linkcontainer_link2, "ANCHOR_CURSOR")
				GameTooltip:SetHyperlink(button.link2)
				GameTooltip:Show()
			end
		end

		local function hide_item() GameTooltip:FadeOut() end

		button.iconcontainer = CHAIN(CreateFrame("Frame",nil,button))
			:SetPoint("TOP",button,"TOP",0,-7)
			:SetFrameLevel(button:GetFrameLevel()+1)
			:SetSize(70,30)
		.__END	
			button.iconcontainer_icon1 = CHAIN(CreateFrame("Frame",nil,button))
				:SetFrameLevel(button:GetFrameLevel()+1)
				:SetSize(30,30)
				:SetPoint("TOPLEFT",button.iconcontainer)
				:SetScript("OnEnter",show_item_1)
				:SetScript("OnLeave",hide_item)
				.__END	
				button.itemicon1 = CHAIN(button:CreateTexture()) 
					:SetSize(30,30)
					:SetPoint("TOP",button.iconcontainer_icon1) 
				.__END
			button.iconcontainer_icon2 = CHAIN(CreateFrame("Frame",nil,button))
				:SetFrameLevel(button:GetFrameLevel()+1)
				:SetSize(30,30)
				:SetPoint("TOPRIGHT",button.iconcontainer) 
				:SetScript("OnEnter",show_item_2)
				:SetScript("OnLeave",hide_item)
				.__END	
				button.itemicon2 = CHAIN(button:CreateTexture()) 
					:SetSize(30,30)
					:SetPoint("TOP",button.iconcontainer_icon2) 
				.__END

		button.linkcontainer_link1 = CHAIN(CreateFrame("Frame",nil,button))
			:SetFrameLevel(button:GetFrameLevel()+1)
			:SetSize(200,15)
			:SetPoint("TOP",button.iconcontainer,"BOTTOM",0,-5)
			:SetScript("OnEnter",show_item_1)
			:SetScript("OnLeave",hide_item)
			.__END	
			button.itemlink1 = CHAIN(button:CreateFontString())
				:SetPoint("TOP",button.linkcontainer_link1)
				:SetFont(FONT,12)
				:SetText("...link1")
				:SetWidth(240)
				:SetJustifyH("CENTER")
				:SetWordWrap(false)
			.__END
		button.linkcontainer_link2 = CHAIN(CreateFrame("Frame",nil,button))
			:SetFrameLevel(button:GetFrameLevel()+1)
			:SetSize(200,15)
			:SetPoint("TOP",button.linkcontainer_link1,"BOTTOM")
			:SetScript("OnEnter",show_item_2)
			:SetScript("OnLeave",hide_item)
			.__END	
			button.itemlink2 = CHAIN(button:CreateFontString())
				:SetPoint("TOP",button.linkcontainer_link2)
				:SetFont(FONT,12)
				:SetText("...link2")
				:SetWidth(240)
				:SetJustifyH("CENTER")
				:SetWordWrap(false)
			.__END
	button:SetScript("OnLeave",function()
	end)

	function button:SetItem(item,index)
		if not item then return end
		button.itemicon:SetTexture(item.texture)
		button.itemlink:SetText(item.itemlinkfull)
		button.link = item.itemlinkfull
		button:Show()
	end

	F.item1:SetPoint("TOPLEFT",F.text,"BOTTOMLEFT",0,-10)

	-- simple line: "with", to be positioned later
	F.string_with=CHAIN(F:CreateFontString(nil,"ARTWORK"))
		:SetHeight(12)
		:SetFont(FONT,ZGV.db.profile.fontsecsize)
		:SetJustifyH("CENTER")
		:SetText(L['itemscore_ae_with'])
	.__END

	-- FontString to display all of the stat differences
	F.stattext=CHAIN(F:CreateFontString(nil,"ARTWORK"))
		:SetWidth(F:GetWidth()-15)
		:SetJustifyH("CENTER")
		:SetFont(FONT,ZGV.db.profile.fontsecsize)
	.__END

	F.OnAccept = function(self)
		self.selfHidden = true
		Upgrades:Equip(self.n_item) --equip it!
	end

	F.OnDecline = function(self)
		self.selfHidden = true

		if IsShiftKeyDown() then
			Upgrades:ShowGearReport()
		end

		self.itemdeclined = true

		-- Send it to BadUpgrades because they don't want it suggested again.
		Upgrades:SetBadUpgrade(self.n_item.itemlink,self.n_item.slot)
	end

	F.OnEscape = function(self)
		if self.manualvisible then
			self.manualvisible = nil
		end
	end

	F.OnSettings = function(self)
		ZygorGuidesViewer:OpenOptions("gear")
	end

	F.AdjustSize = function(self) -- Need to change this because it is different for this kind of Popup
		local offsets = 45 + 10 + 5 + 20 --Logo and top + text and buttons + buttons and bottom + more room

		local ItemsAlwaysThere = self.text:GetStringHeight() + self.stattext:GetStringHeight() + self.acceptbutton:GetHeight()
		local ItemsSometimes = ( 
			(self.item1:IsVisible() and self.item1:GetHeight() or 0) + 
			(self.item2:IsVisible() and self.item2:GetHeight() or 0) + 
			(self.item_double:IsVisible() and self.item_double:GetHeight() or 0) + 
			(self.string_with:IsVisible() and self.string_with:GetHeight() or 0)
			)

		self:SetHeight(offsets + ItemsAlwaysThere + ItemsSometimes)
	end

	F.returnMinimizeSettings = function(self)
		local mainText,quiet

		if Upgrades.UpgradeQueueCount > 1 then
			mainText = L['notifcenter_gear_text_pl']:format(Upgrades.UpgradeQueueCount)
		else
			mainText = L['notifcenter_gear_text_sl']:format(Upgrades.UpgradeQueueCount)
		end

		-- Table to allow popup out text to be different from normal notification text.
		local notifcationText = { mainText, L['notifcenter_gear_text'] }

		local tooltipText = L['notifcenter_gen_popup_tooltip']

		--Some special handling of this up in ScanBags for no items in Queue

		return notifcationText,L['notifcenter_gear_title'],tooltipText,nil,nil,nil,quiet
	end

	F:HookScript("OnHide",function(self)
		self.manualvisible = nil
	end)

	F:HookScript("OnShow",function(self)
		self.manualvisible = true
	end)

	F.acceptbutton:SetText(L['itemscore_ae_accept'])
	F.declinebutton:SetText(L['itemscore_ae_decline'])

	CHAIN(F.acceptbutton)
		:SetParent(F)

	CHAIN(F.declinebutton)
		--Popup.olditem is not always there. EG no item in that slot.
		:HookScript("OnEnter",function(self) CHAIN(GameTooltip):SetOwner(F,"ANCHOR_BOTTOM") :SetText(L['itemscore_ae_report_tip']) :Show() end)
		:HookScript("OnLeave",function(self) GameTooltip:Hide() end)
		:SetParent(F)

	-- dump info about items in popup
	function F.debug()
		Spoo({
			new_item = F.n_item, 
			new_item_cached = ItemScore.ItemCache[F.n_item.itemlink],
			current_item = F.c_item,
			current_item_cached = F.c_item and ItemScore.ItemCache[F.c_item.itemlink],
			change = Upgrades:GetStatChange(F.n_item and F.n_item.itemlink, F.c_item and F.c_item.itemlink),
			})
	end

	function F.AnchorTo(what,to,offset)
		--what:ClearAllPoints()
		offset = offset or 3
		what:SetPoint("TOP",to,"BOTTOM",0,-offset)
		what:Show()
	end
end

function Upgrades:ShowGearReport()
	local Gratuity = LibStub("LibGratuity-3.0")

	local out = ""
	-- player data
	out = out .. "*** Player data: " 
	out = out .. "\n class " .. ItemScore.playerclass .. " system " .. (select(2,UnitClass("player")))
	out = out .. "\n level " .. ItemScore.playerlevel .. " system " .. UnitLevel("player")
	out = out .. "\n faction " .. ItemScore.playerfaction .. " system " .. UnitFactionGroup("player")

	out = out .. "\n\n*** Skills: " 
	out = out .. "\n locale " .. GetLocale()
	out = out .. "\n** registered " 
	for i,v in pairs(ItemScore.Skills) do 
		out = out .. "\n " .. i .. " = " .. v
	end

	out = out .. "\n** raw " 
	for i=1, GetNumSkillLines() do
		local skillName, _, _, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(i);
		local skillTag = ItemScore.SkillNamesRev[skillName]
		out = out .. "\n " .. skillName .. " " .. (skillTag or "")
	end


	out = out .. "\n\n*** Player statweights: " 
	for i,v in pairs(ItemScore.ActiveRuleSet.stats) do 
		out = out .. "\n " .. i .. " = " .. v
	end

	out = out .. "\n Fallback weight = " .. ItemScore.whiteScoreWeight


	local new_item = Upgrades.EquipPopup.n_item
	local old_item = Upgrades.EquipPopup.c_item

	if new_item and new_item.itemlink then
		out = out .. "\n\n*** New item: " 
		out = out .. "\nTooltip: " 
		Gratuity:SetHyperlink(new_item.itemlink)
		for num=1,Gratuity:NumLines() do
			local line=Gratuity:GetLine(num)
			if not line then break end
			out = out .. "\n " .. line
		end
		out = out .. "\nCache: " 
		for i,v in pairs(ZGV.ItemScore.ItemCache[new_item.itemlink]) do 
			if type(v)=="table" then
				out = out .. "\n " .. i .. " : "
				for j,w in pairs(v) do
					out = out .. "\n   " .. j .. " : " .. w
				end
			else
				out = out .. "\n " .. i .. " : " .. tostring(v)
			end
		end
	end

	if old_item and old_item.itemlink then
		out = out .. "\n\n*** Old item: " 
		out = out .. "\nTooltip: " 
		Gratuity:SetHyperlink(old_item.itemlink)
		for num=1,Gratuity:NumLines() do
			local line=Gratuity:GetLine(num)
			if not line then break end
			out = out .. "\n " .. line
		end
		out = out .. "\nCache: " 
		for i,v in pairs(ZGV.ItemScore.ItemCache[old_item.itemlink]) do 
			if type(v)=="table" then
				out = out .. "\n " .. i .. " : "
				for j,w in pairs(v) do
					out = out .. "\n   " .. j .. " : " .. w
				end
			else
				out = out .. "\n " .. i .. " : " .. tostring(v)
			end
		end
	end

	out = out .. "\n\n*** Gear and queue: " 
	for slot,item in pairs(Upgrades.EquippedItems) do 
		local replacement = Upgrades.UpgradeQueue[slot]
		local replacement_details = replacement and replacement.itemlink and ItemScore:GetItemDetails(replacement.itemlink)
		local current_details = item and item.itemlink and ItemScore:GetItemDetails(item.itemlink)
		local current_text = current_details and (current_details.itemlinkfull.." score "..item.score)
		local replacement_text = replacement_details and (" with "..replacement_details.itemlinkfull.." score "..replacement.score)
		
		if current_text or replacement_text then
			out = out .. "\n " .. slot .. " ".. (current_text or "empty slot").." "..(replacement_text or "")
		end
	end

	ZGV:ShowDump(out,"Autoequip report")
end

function Upgrades:ShowEquipmentChangePopup(slot)
	if not slot then return nil,"no slot" end
	local n_item = Upgrades.UpgradeQueue[slot]
	if not n_item or not n_item.itemlink then return nil,"no upgrade for slot",slot end
	local new_item = ItemScore:GetItemDetails(n_item.itemlink)
	if not new_item then return nil,"no details for item" end

	local c_item = Upgrades.EquippedItems[slot]
	local current_item = c_item and c_item.itemlink and ItemScore:GetItemDetails(c_item.itemlink)
	if c_item and c_item.itemlink and not current_item then return nil,"not current item" end

	local pair_item
	if n_item.pair then
		pair_item = n_item.pair.itemlink and ItemScore:GetItemDetails(n_item.pair.itemlink)
		if not pair_item then return nil,"no pair link" end
	end

	local F = Upgrades.EquipPopup
	local AnchorTo = F.AnchorTo

	-- keep references for debugging
	F.n_item = n_item
	F.c_item = c_item

	-- clean up
	F.item_double:Hide()
	F.item1:Hide()
	F.item2:Hide()
	F.string_with:Hide()

	local changes
	if current_item then
		F:SetText(L['zgname']..L['itemscore_ae_equip1'])

		F.string_with:Show()	
		F.stattext:Show()

		if pair_item then 
			if n_item.twohand then
				-- we are replacing mh/oh with th. in that case pair_item in is the oh that will also be replaced, so switch them around
				F.item_double.itemicon1:SetTexture(current_item.texture)
				F.item_double.itemicon2:SetTexture(pair_item.texture)
				F.item_double.itemlink1:SetText(current_item.itemlinkfull)
				F.item_double.itemlink2:SetText(pair_item.itemlinkfull)

				F.item_double.link1 = current_item.itemlinkfull
				F.item_double.link2 = pair_item.itemlinkfull

				F.item2:SetItem(new_item)	

				--[[ items --]]	AnchorTo(F.item_double,F.text)
				--[[ with  --]]	AnchorTo(F.string_with,F.item_double)
				--[[ item2 --]]	AnchorTo(F.item2,F.string_with,7)
				--[[ stats --]]	AnchorTo(F.stattext,F.item2)

				changes = Upgrades:GetStatChange(new_item.itemlink,current_item.itemlink,pair_item.itemlink,mode_new,"equip_pair")
			else
				-- we are replacing th with mh/oh. items are it correct slots
				F.item1:SetItem(current_item)	

				F.item_double.itemicon1:SetTexture(new_item.texture)
				F.item_double.itemicon2:SetTexture(pair_item.texture)
				F.item_double.itemlink1:SetText(new_item.itemlinkfull)
				F.item_double.itemlink2:SetText(pair_item.itemlinkfull)

				F.item_double.link1 = new_item.itemlinkfull
				F.item_double.link2 = pair_item.itemlinkfull

				--[[ item1 --]]
				--[[ with  --]] AnchorTo(F.string_with,F.item1)
				--[[ items --]]	AnchorTo(F.item_double,F.string_with,3)
				--[[ stats --]]	AnchorTo(F.stattext,F.item_double,5)

				changes = Upgrades:GetStatChange(new_item.itemlink,pair_item.itemlink,current_item.itemlink,"equip_pair",mode_old)
			end
			F.item_double:Show()
		else
			F.item1:SetItem(current_item,1)
			F.item2:SetItem(new_item,2)	
			--[[ item1 --]]
			--[[ with  --]]	AnchorTo(F.string_with,F.item1)
			--[[ item2 --]]	AnchorTo(F.item2,F.string_with)
			--[[ stats --]]	AnchorTo(F.stattext,F.item2)

			F.item2:Show()
			F.item2:ClearAllPoints()
			F.item2:SetPoint("LEFT",F,"LEFT")
			F.item2:SetPoint("TOP",F.string_with,"BOTTOM",0,-7)

			changes = Upgrades:GetStatChange(new_item and new_item.itemlink,current_item and current_item.itemlink)
		end
	else
		F:SetText(L['zgname']..L['itemscore_ae_equip2'])

		F.item1:SetItem(new_item)
		F.stattext:Show()		
		F.AnchorTo(F.stattext,F.item1)

		changes = Upgrades:GetStatChange(new_item and new_item.itemlink)
	end

	if not changes then return nil,"no changes" end-- something went wrong

	if n_item.quest then
		changes = "Quest item"
	end
	

	F.stattext:SetText(changes)

	F:Show()

	return true
end

function Upgrades:Equip(item)
	if not item then return end
	PickupContainerItem(item.bagnum,item.bagslot)
	EquipCursorItem(item.slot)
	if item.pair and not item.twohand then
		PickupContainerItem(item.pair.bagnum,item.pair.bagslot)
		EquipCursorItem(item.pair.slot)
	end

end