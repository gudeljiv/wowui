local OpenSesame = CreateFrame('Frame')

OpenSesame:SetScript('OnEvent', function(self, event, ...) self[event](...) end)

-- If you want to see Startup Messages, simply un-comment the next line.
-- print("|cff00FF80OpenSesame : Loaded WoW Classic Era")

local atBank, atMail, atMerchant, inCombat, isLooting, inTrade, inCraft

local AllowedItemsList = {

   [10456]  =  true,  -- A Bulging Coin Purse
   [15902]  =  true,  -- A Crazy Grab Bag
   [11883]  =  true,  -- A Dingy Fanny Pack
   [5335]  =  true,  -- A Sack of Coins
   [6755]  =  true,  -- A Small Container of Gems
   [11107]  =  true,  -- A Small Pack
   [21509]  =  true,  -- Ahn'Qiraj War Effort Supplies
   [21510]  =  true,  -- Ahn'Qiraj War Effort Supplies
   [21511]  =  true,  -- Ahn'Qiraj War Effort Supplies
   [21512]  =  true,  -- Ahn'Qiraj War Effort Supplies
   [21513]  =  true,  -- Ahn'Qiraj War Effort Supplies
   [22152]  =  true,  -- Anthion's Pouch
   [20231]  =  true,  -- Arathor Advanced Care Package
   [20233]  =  true,  -- Arathor Basic Care Package
   [20236]  =  true,  -- Arathor Standard Care Package
   [11955]  =  true,  -- Bag of Empty Ooze Containers
   [20603]  =  true,  -- Bag of Spoils
   [6356]  =  true,  -- Battered Chest
   --[16882]  =  true,  -- Battered Junkbox (Locked)
   [7973]  =  true,  -- Big-mouth Clam
   [6646]  =  true,  -- Bloated Albacore
   [6647]  =  true,  -- Bloated Catfish
   [21163]  =  true,  -- Bloated Firefin
   [6644]  =  true,  -- Bloated Mackerel
   [21243]  =  true,  -- Bloated Mightfish
   [6645]  =  true,  -- Bloated Mud Snapper
   [21162]  =  true,  -- Bloated Oily Blackmouth
   [13881]  =  true,  -- Bloated Redgill
   [21164]  =  true,  -- Bloated Rockscale Cod
   [13891]  =  true,  -- Bloated Salmon
   [6643]  =  true,  -- Bloated Smallfish
   [8366]  =  true,  -- Bloated Trout
   [17962]  =  true,  -- Blue Sack of Gems
   [21812]  =  true,  -- Box of Chocolates
   [10695]  =  true,  -- Box of Empty Vials
   [9541]  =  true,  -- Box of Goodies
   [9539]  =  true,  -- Box of Rations
   [9540]  =  true,  -- Box of Spells
   [6827]  =  true,  -- Box of Supplies
   [8502]  =  true,  -- Bronze Lotterybox
   [22746]  =  true,  -- Buccaneer's Uniform
   [16783]  =  true,  -- Bundle of Reports
   [21191]  =  true,  -- Carefully Wrapped Present
   [11887]  =  true,  -- Cenarion Circle Cache
   [20602]  =  true,  -- Chest of Spoils
   [21741]  =  true,  -- Cluster Rocket Recipes
   [21528]  =  true,  -- Colossal Bag of Loot
   [20808]  =  true,  -- Combat Assignment
   [5738]  =  true,  -- Covert Ops Pack
   [9265]  =  true,  -- Cuergo's Hidden Treasure
   [23022]  =  true,  -- Curmudgeon's Payoff
   [19422]  =  true,  -- Darkmoon Faire Fortune
   [20469]  =  true,  -- Decoded True Believer Clippings
   [20228]  =  true,  -- Defiler's Advanced Care Package
   [20229]  =  true,  -- Defiler's Basic Care Package
   [20230]  =  true,  -- Defiler's Standard Care Package
   [12849]  =  true,  -- Demon Kissed Sack
   [6351]  =  true,  -- Dented Crate
   [8647]  =  true,  -- Egg Crate
   [10752]  =  true,  -- Emerald Encrusted Chest
   [11617]  =  true,  -- Eridan's Supplies
   --[5760]  =  true,  -- Eternium Lockbox (Locked)
   [11024]  =  true,  -- Evergreen Herb Casing
   [11937]  =  true,  -- Fat Sack of Coins
   [10834]  =  true,  -- Felhound Tracker Kit
   [21363]  =  true,  -- Festive Gift
   [21131]  =  true,  -- Followup Combat Assignment
   [20805]  =  true,  -- Followup Logistics Assignment
   [21386]  =  true,  -- Followup Logistics Assignment
   [21133]  =  true,  -- Followup Tactical Assignment
   [8484]  =  true,  -- Gadgetzan Water Co. Care Package
   [21310]  =  true,  -- Gaily Wrapped Present
   [21270]  =  true,  -- Gently Shaken Gift
   [21271]  =  true,  -- Gently Shaken Gift
   [21979]  =  true,  -- Gift of Adoration: Darnassus
   [21980]  =  true,  -- Gift of Adoration: Ironforge
   [22164]  =  true,  -- Gift of Adoration: Orgrimmar
   [21981]  =  true,  -- Gift of Adoration: Stormwind
   [22165]  =  true,  -- Gift of Adoration: Thunder Bluff
   [22166]  =  true,  -- Gift of Adoration: Undercity
   [22167]  =  true,  -- Gift of Friendship: Darnassus
   [22168]  =  true,  -- Gift of Friendship: Ironforge
   [22169]  =  true,  -- Gift of Friendship: Orgrimmar
   [22170]  =  true,  -- Gift of Friendship: Stormwind
   [22171]  =  true,  -- Gift of Friendship: Thunder Bluff
   [22172]  =  true,  -- Gift of Friendship: Undercity
   [8049]  =  true,  -- Gnarlpine Necklace
   [11423]  =  true,  -- Gnome Engineer's Renewal Gift
   [5857]  =  true,  -- Gnome Prize Box
   [11422]  =  true,  -- Goblin Engineer's Renewal Gift
   [5858]  =  true,  -- Goblin Prize Box
   [17964]  =  true,  -- Gray Sack of Gems
   [19296]  =  true,  -- Greater Darkmoon Prize
   [17963]  =  true,  -- Green Sack of Gems
   [10773]  =  true,  -- Hakkari Urn
   --[4633]  =  true,  -- Heavy Bronze Lockbox (Locked)
   [8503]  =  true,  -- Heavy Bronze Lotterybox
   [13874]  =  true,  -- Heavy Crate
   [8505]  =  true,  -- Heavy Iron Lotterybox
   --[16885]  =  true,  -- Heavy Junkbox (Locked)
   [8507]  =  true,  -- Heavy Mithril Lotterybox
   [22648]  =  true,  -- Hive'Ashi Dossier
   [22649]  =  true,  -- Hive'Regal Dossier
   [22650]  =  true,  -- Hive'Zora Dossier
   [10569]  =  true,  -- Hoard of the Black Dragonflight
   [20367]  =  true,  -- Hunting Gear
   [9529]  =  true,  -- Internal Warrior Equipment Kit L25
   [9532]  =  true,  -- Internal Warrior Equipment Kit L30
   [21150]  =  true,  -- Iron Bound Trunk
   --[4634]  =  true,  -- Iron Lockbox (Locked)
   [8504]  =  true,  -- Iron Lotterybox
   --[13875]  =  true,  -- Ironbound Locked Chest (Locked)
   [10479]  =  true,  -- Kovic's Trading Satchel
   [10595]  =  true,  -- Kum'isha's Junk
   [12122]  =  true,  -- Kum'isha's Junk
   [19035]  =  true,  -- Lard's Special Picnic Basket
   [21743]  =  true,  -- Large Cluster Rocket Recipes
   [21742]  =  true,  -- Large Rocket Recipes
   [19297]  =  true,  -- Lesser Darkmoon Prize
   [21132]  =  true,  -- Logistics Assignment
   [21266]  =  true,  -- Logistics Assignment
   [18804]  =  true,  -- Lord Grayson's Satchel
   [21746]  =  true,  -- Lucky Red Envelope
   [21640]  =  true,  -- Lunar Festival Fireworks Pack
   [6307]  =  true,  -- Message in a Bottle
   [19298]  =  true,  -- Minor Darkmoon Prize
   [21228]  =  true,  -- Mithril Bound Trunk
   --[5758]  =  true,  -- Mithril Lockbox (Locked)
   [8506]  =  true,  -- Mithril Lotterybox
   [22320]  =  true,  -- Mux's Quality Goods
   [19425]  =  true,  -- Mysterious Lockbox
   [21042]  =  true,  -- Narain's Special Kit
   [15876]  =  true,  -- Nathanos' Chest
   [9537]  =  true,  -- Neatly Wrapped Box
   [20768]  =  true,  -- Oozing Bag
   --[4632]  =  true,  -- Ornate Bronze Lockbox (Locked)
   [19153]  =  true,  -- Outrider Advanced Care Package
   [19154]  =  true,  -- Outrider Basic Care Package
   [19155]  =  true,  -- Outrider Standard Care Package
   [11912]  =  true,  -- Package of Empty Ooze Containers
   -- [9276]  =  true,  -- Pirate's Footlocker (Can Contain BoP)
   [22155]  =  true,  -- Pledge of Adoration: Darnassus
   [22154]  =  true,  -- Pledge of Adoration: Ironforge
   [22156]  =  true,  -- Pledge of Adoration: Orgrimmar
   [21975]  =  true,  -- Pledge of Adoration: Stormwind
   [22158]  =  true,  -- Pledge of Adoration: Thunder Bluff
   [22157]  =  true,  -- Pledge of Adoration: Undercity
   [22159]  =  true,  -- Pledge of Friendship: Darnassus
   [22160]  =  true,  -- Pledge of Friendship: Ironforge
   [22161]  =  true,  -- Pledge of Friendship: Orgrimmar
   [22178]  =  true,  -- Pledge of Friendship: Stormwind
   [22162]  =  true,  -- Pledge of Friendship: Thunder Bluff
   [22163]  =  true,  -- Pledge of Friendship: Undercity
   [13247]  =  true,  -- Quartermaster Zigris' Footlocker
   [17969]  =  true,  -- Red Sack of Gems
   --[13918]  =  true,  -- Reinforced Locked Chest (Locked)
   --[4638]  =  true,  -- Reinforced Steel Lockbox (Locked)
   [6715]  =  true,  -- Ruined Jumper Cables
   [18636]  =  true,  -- Ruined Jumper Cables XL
   [11938]  =  true,  -- Sack of Gems
   [20601]  =  true,  -- Sack of Spoils
   [21156]  =  true,  -- Scarab Bag
   [7190]  =  true,  -- Scorched Rocket Boots
   [20767]  =  true,  -- Scum Covered Bag
   [22568]  =  true,  -- Sealed Craftsman's Writ
   [6357]  =  true,  -- Sealed Crate
   [19152]  =  true,  -- Sentinel Advanced Care Package
   [19150]  =  true,  -- Sentinel Basic Care Package
   [19151]  =  true,  -- Sentinel Standard Care Package
   [20766]  =  true,  -- Slimy Bag
   [5523]  =  true,  -- Small Barnacled Clam
   [15699]  =  true,  -- Small Brown-wrapped Package
   [6353]  =  true,  -- Small Chest
   --[6354]  =  true,  -- Small Locked Chest (Locked)
   [21740]  =  true,  -- Small Rocket Recipes
   [11966]  =  true,  -- Small Sack of Coins
   [21216]  =  true,  -- Smokywood Pastures Extra-Special Gift
   [17727]  =  true,  -- Smokywood Pastures Gift Pack
   [17685]  =  true,  -- Smokywood Pastures Sampler
   [17726]  =  true,  -- Smokywood Pastures Special Gift
   [21315]  =  true,  -- Smokywood Satchel
   [15874]  =  true,  -- Soft-shelled Clam
   [9363]  =  true,  -- Sparklematic-Wrapped Box
   --[4637]  =  true,  -- Steel Lockbox (Locked)
   --[4636]  =  true,  -- Strong Iron Lockbox (Locked)
   --[16884]  =  true,  -- Sturdy Junkbox (Locked)
   --[6355]  =  true,  -- Sturdy Locked Chest (Locked)
   [23224]  =  true,  -- Summer Gift Package
   [20809]  =  true,  -- Tactical Assignment
   --[7209]  =  true,  -- Tazan's Satchel (Locked)
   [7870]  =  true,  -- Thaumaturgy Vessel Lockbox
   --[12033]  =  true,  -- Thaurissan Family Jewels (Locked)
   [5524]  =  true,  -- Thick-shelled Clam
   --[7868]  =  true,  -- Thieven' Kit (Locked)
   --[5759]  =  true,  -- Thorium Lockbox (Locked)
   [21327]  =  true,  -- Ticking Present
   [20708]  =  true,  -- Tightly Sealed Trunk
   [11568]  =  true,  -- Torwa's Pouch
   [20393]  =  true,  -- Treat Bag
   [12339]  =  true,  -- Vaelan's Gift
   [6352]  =  true,  -- Waterlogged Crate
   [21113]  =  true,  -- Watertight Trunk
   --[16883]  =  true,  -- Worn Junkbox (Locked)
   [17965]  =  true,  -- Yellow Sack of Gems
   [22137]  =  true,  -- Ysida's Satchel
   -- [22233]  =  true,  -- Zigris' Footlocker (Seems like bad data; a dupe of #13247)

}

function OpenSesame:Register(event, func)
      self:RegisterEvent(event)
      self[event] = function(...)
      func(...)
   end
end

function AutomaticOpener()
   if (atBank or atMail or atMerchant or inCombat or isLooting or inTrade or inCraft) then
      return
   end
   for bag = 0, 4 do
      for slot = 0, C_Container.GetContainerNumSlots(bag) do
         local id = C_Container.GetContainerItemID(bag, slot)
         if id and AllowedItemsList[id] then
            C_Container.UseContainerItem(bag, slot)
            -- If you want to see messages in chat every time something is opened, un-comment the next line.
            -- DEFAULT_CHAT_FRAME:AddMessage("|cff00FF80OpenSesame : Opening " .. GetContainerItemLink(bag, slot))
            return
         end
      end
   end
end

-- https://wowpedia.fandom.com/wiki/BANKFRAME_OPENED
-- Fired when the bank frame is opened.
OpenSesame:Register('BANKFRAME_OPENED', function()
   atBank = true
end)

-- https://wowpedia.fandom.com/wiki/BANKFRAME_CLOSED
-- Fired twice when the bank window is closed.
OpenSesame:Register('BANKFRAME_CLOSED', function()
   atBank = false
   AutomaticOpener()
end)

-- https://wowpedia.fandom.com/wiki/MAIL_SHOW
-- Fired when the mailbox is first opened.
OpenSesame:Register('MAIL_SHOW', function()
   atMail = true
end)

-- https://wowpedia.fandom.com/wiki/MAIL_CLOSED
-- Fired when the mailbox window is closed.
OpenSesame:Register('MAIL_CLOSED', function()
   atMail = false
   AutomaticOpener()
end)

-- https://wowpedia.fandom.com/wiki/MERCHANT_SHOW
-- Fired when the merchant frame is shown.
OpenSesame:Register('MERCHANT_SHOW', function()
   atMerchant = true
end)

-- https://wowpedia.fandom.com/wiki/MERCHANT_CLOSED
-- Fired when a merchant frame closes. (Called twice).
OpenSesame:Register('MERCHANT_CLOSED', function()
   atMerchant = false
   AutomaticOpener()
end)

-- https://wowpedia.fandom.com/wiki/TRADE_SHOW
-- Fired when the Trade window appears after a
-- trade request has been accepted or auto-accepted.
OpenSesame:Register('TRADE_SHOW', function()
   inTrade = true
end)

-- https://wowpedia.fandom.com/wiki/TRADE_CLOSED
-- Fired when the trade window is closed by the
-- trade being accepted, or the player or target closes the window.
OpenSesame:Register('TRADE_CLOSED', function()
   inTrade = false
   AutomaticOpener()
end)

-- https://wowpedia.fandom.com/wiki/TRADE_SKILL_SHOW
-- Fired when a trade skill window is opened.
OpenSesame:Register('TRADE_SKILL_SHOW', function()
   inCraft = true
end)

-- https://wowpedia.fandom.com/wiki/TRADE_SKILL_CLOSE
-- Fired when a trade skill window is closed.
OpenSesame:Register('TRADE_SKILL_CLOSE', function()
   inCraft = false
   AutomaticOpener()
end)

-- https://wowpedia.fandom.com/wiki/LOOT_OPENED
-- Fires when a corpse is looted, after LOOT_READY.
OpenSesame:Register('LOOT_OPENED', function()
   isLooting = true
end)

-- https://wowpedia.fandom.com/wiki/LOOT_CLOSED
-- Fired when a player ceases looting a corpse.
-- Note that this will fire before the last CHAT_MSG_LOOT event for that loot.
OpenSesame:Register('LOOT_CLOSED', function()
   isLooting = false
   AutomaticOpener()
end)

-- https://wowpedia.fandom.com/wiki/PLAYER_REGEN_DISABLED
-- Fired whenever you enter combat, as normal regen rates are disabled during combat.
-- This means that either you are in the hate list of a NPC or that you've been
-- taking part in a pvp action (either as attacker or victim).
OpenSesame:Register('PLAYER_REGEN_DISABLED', function()
   inCombat = true
end)

-- https://wowpedia.fandom.com/wiki/PLAYER_REGEN_ENABLED
-- Fired after ending combat, as regen rates return to normal.
-- Useful for determining when a player has left combat.
-- This occurs when you are not on the hate list of any NPC,
-- or a few seconds after the latest pvp attack that you were involved with.
OpenSesame:Register('PLAYER_REGEN_ENABLED', function()
   inCombat = false
   AutomaticOpener()
end)

-- https://wowpedia.fandom.com/wiki/BAG_UPDATE_DELAYED
-- Fired after all applicable BAG_UPDATE events for a specific action have been fired.
OpenSesame:Register('BAG_UPDATE_DELAYED', function()
   AutomaticOpener()
end)
